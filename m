Return-Path: <netdev+bounces-49461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC487F21B1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E589F2813DE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E023B787;
	Mon, 20 Nov 2023 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNse8Wwy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7963B2B2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D2EC433C7;
	Mon, 20 Nov 2023 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524477;
	bh=Vezd9uq13hNO4AeXpO85JVgRRoWUvfwGAjAydyFIRSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNse8WwyocClfO55Rgn2mR0r2oRIP6C5XdD0aFWOOddSq9HFTcs2Su/OCEXp+1C/T
	 qKayOQRGZdtGjnYOQ7dEYDhPFgvUuAgvQr3yYehbmh4mIOEjQJC5eHc+BLMWtCruAV
	 Zpj97bU50ze4+iP8osDD7zcARnbbq2UZI794ut2T1cK6Sdj4G0vbC7PQZf10GkmgwW
	 g3ED1TSEt3clodam80xXjy3+shsxcSAfhuvFuAYscnyDyRz+fEIa6bd0gaPVD7LEnp
	 xzSblkhSEzJe9GL1Awzqczo1V/yKs1biaecQihv7DaWY6dlDJWJzhQiGQqasFxROwd
	 o1d4zlhpV5LNg==
Date: Mon, 20 Nov 2023 15:54:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Message-ID: <20231120155436.32ae11c6@kernel.org>
In-Reply-To: <170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
	<170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 17:16:48 -0800 Amritha Nambiar wrote:
> Add the napi pointer in netdev queue for tracking the napi
> instance for each queue. This achieves the queue<->napi mapping.

I took the series for a spin. I'll send a bnxt patch in a separate
reply, please add it to the series.

Three high level comments:

 - the netif_queue_set_napi() vs __netif_queue_set_napi() gave me pause;
   developers may be used to calling netif_*() functions from open/stop
   handlers, without worrying about locking.
   I think that netif_queue_set_napi() should assume rtnl_lock was
   already taken, as it will be in 90% of cases. A rare driver which
   does not hold it should take it locally for now.

 - drivers don't set real_num_*_queues to 0 when they go down,
   currently. So even tho we don't list any disabled queues when
   device is UP, we list queues when device is down.
   I mean:

   $ ifup eth0
   $ ethtool -L eth0 combined 4
   $ ./get-queues my-device
   ... will list 4 rx and 4 rx queues ...
   $ ethtool -L eth0 combined 2
   $ ./get-queues my-device
   ... will list 2 rx and 2 rx queues ...
   $ ifdown eth0
   $ ./get-queues my-device
   ... will list 2 rx and 2 rx queues ...
   ... even tho practically speaking there are no active queues ...

   I think we should skip listing queue and NAPI info of devices which
   are DOWN. Do you have any use case which would need looking at those?

 - We need a way to detach queues form NAPI. This is sort-of related to
   the above, maybe its not as crucial once we skip DOWN devices but
   nonetheless for symmetry we should let the driver clear the NAPI
   pointer. NAPIs may be allocated dynamically, the queue::napi pointer
   may get stale.

I hacked together the following for my local testing, feel free to fold
appropriate parts into your patches:

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1a0603b3529d..2ed7a3aeec40 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2948,10 +2948,11 @@ static void
 ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
 		   struct napi_struct *napi, bool locked)
 {
-	if (locked)
-		__netif_queue_set_napi(queue_index, type, napi);
-	else
-		netif_queue_set_napi(queue_index, type, napi);
+	if (!locked)
+		rtnl_lock();
+	netif_queue_set_napi(napi->dev, queue_index, type, napi);
+	if (!locked)
+		rtnl_unlock();
 }
 
 /**
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dbc4ea74b8d6..e09a039a092a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2644,13 +2644,10 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
-void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
 
-void __netif_queue_set_napi(unsigned int queue_index,
-			    enum netdev_queue_type type,
-			    struct napi_struct *napi);
-
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
diff --git a/net/core/dev.c b/net/core/dev.c
index 99ca59e18abf..bb93240c69b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6400,25 +6400,27 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 EXPORT_SYMBOL(dev_set_threaded);
 
 /**
- * __netif_queue_set_napi - Associate queue with the napi
+ * netif_queue_set_napi - Associate queue with the napi
+ * @dev: device to which NAPI and queue belong
  * @queue_index: Index of queue
  * @type: queue type as RX or TX
- * @napi: NAPI context
+ * @napi: NAPI context, pass NULL to clear previously set NAPI
  *
  * Set queue with its corresponding napi context. This should be done after
  * registering the NAPI handler for the queue-vector and the queues have been
  * mapped to the corresponding interrupt vector.
  */
-void __netif_queue_set_napi(unsigned int queue_index,
-			    enum netdev_queue_type type,
-			    struct napi_struct *napi)
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type,
+			  struct napi_struct *napi)
 {
-	struct net_device *dev = napi->dev;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 
-	if (WARN_ON_ONCE(!dev))
+	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
+	if (dev->reg_state >= NETREG_REGISTERED)
+		ASSERT_RTNL();
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
@@ -6433,15 +6435,6 @@ void __netif_queue_set_napi(unsigned int queue_index,
 		return;
 	}
 }
-EXPORT_SYMBOL(__netif_queue_set_napi);
-
-void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
-			  struct napi_struct *napi)
-{
-	rtnl_lock();
-	__netif_queue_set_napi(queue_index, type, napi);
-	rtnl_unlock();
-}
 EXPORT_SYMBOL(netif_queue_set_napi);
 
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-- 
2.42.0


