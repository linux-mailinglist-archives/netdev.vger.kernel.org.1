Return-Path: <netdev+bounces-209946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5FB116A2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 04:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB65A53F3
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129423185F;
	Fri, 25 Jul 2025 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+tew8Fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A554F81
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411499; cv=none; b=eRKX8s+TzZOf10brm+Zit0vJ8uWC2J7YDQIefFa7XZJso073dgI3Xqcx5uZIn2F6kBrTUuozyAN6lOrdHtODGJVvGG87iHKCC8k2Hg+agkjVxxNyMgRvKjPGGqlHEWxW/ddyxcTTxE3gjmfAVIKyWAdWtZ7dA009sAi7sPWB6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411499; c=relaxed/simple;
	bh=Bg92VHyOE6MEMFoWQRKE/2425Pc1ZojxSdZQl1Gp27w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3bx3Pu6c1D+9pyvPuJVUVHnP7xDaMnzmXe99TAk+Sf/M1eAXDHqO8pc1cSVbBNb53GfdGHfl20wP5TXhG/tDpV8EC2URdAPEdnPGCeGd4hYWPFj8t5CBVU1+Ai4b0awTP2FtpGFWHLE6SfMx/j6zegue0BUZkzkn1GFMUchr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+tew8Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD52C4CEEF;
	Fri, 25 Jul 2025 02:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753411499;
	bh=Bg92VHyOE6MEMFoWQRKE/2425Pc1ZojxSdZQl1Gp27w=;
	h=From:To:Cc:Subject:Date:From;
	b=S+tew8FwGKaY3GI5IwbL0I0vGWkNJqlszllM2CGtOigp2hFpGVy3B+eFjmL0ZiMYQ
	 tQFV8Vg+2XJRCIuop4bOUYzbZgnG8XQuQxIaSmRD/lMROIAsSTEcwDIxGXEh2hBd1y
	 MI1/NO8lRS/BcO7/D9s2oL4JuAFKeeLk80ZrsuGtg+WGqkDMnW79RZaWYnS9j53q5l
	 TxjdW04ViM4QW+pGBpOTZMBY2Yb+dlvhce1klTQNbh3CP+hj+xmUZuVjZA/2DvyS2v
	 +kUkYzIgAkF32XSIqfk4nIwEl/V6tLjhOIVVK2X+dxca2Mr+ABvseH1qEOi/wOOzOW
	 ruVr/Gl6cEnkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Zigit Zo <zuozhijie@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	leitao@debian.org,
	sdf@fomichev.me
Subject: [PATCH net] netpoll: prevent hanging NAPI when netcons gets enabled
Date: Thu, 24 Jul 2025 19:44:54 -0700
Message-ID: <20250725024454.690517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Paolo spotted hangs in NIPA running driver tests against virtio.
The tests hang in virtnet_close() -> virtnet_napi_tx_disable().

The problem is only reproducible if running multiple of our tests
in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
netpoll_basic.py stats.py"). Initial suspicion was that this is
a simple case of double-disable of NAPI, but instrumenting the
code reveals:

 Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
   state: 0x37, disabled: false, owner: 0, listed: false, weight: 64

The NAPI was not in fact disabled, owner is 0 (rather than -1),
so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
(!list_empty(&n->poll_list)). It seems odd that normal NAPI
processing would wedge itself like this.

My suspicion is that netpoll gets enabled while NAPI is polling,
and also grab the NAPI instance. This confuses napi_complete_done():

  [netpoll]                                   [normal NAPI]
                                        napi_poll()
                                          have = netpoll_poll_lock()
                                            rcu_access_pointer(dev->npinfo)
                                              return NULL # no netpoll
                                          __napi_poll()
					    ->poll(->weight)
  poll_napi()
    cmpxchg(->poll_owner, -1, cpu)
      poll_one_napi()
        set_bit(NAPI_STATE_NPSVC, ->state)
                                              napi_complete_done()
                                                if (NAPIF_STATE_NPSVC)
                                                  return false
                                           # exit without clearing SCHED

This seems very unlikely, but perhaps virtio has some interactions
with the hypervisor in the NAPI -> poll that makes the race window
large?

Best I could to to prove the theory was to add and trigger this
warning in napi_poll (just before netpoll_poll_unlock()):

      WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
                napi_is_scheduled(n) && list_empty(&n->poll_list),
                "NAPI race with netpoll %px", n);

If this warning hits the next virtio_close() will hang.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Looks like this is not a new bug, rather Breno's tests now put
enough pressure on netpoll + virtio to trigger it.

CC: Jason Wang <jasowang@redhat.com>
CC: Zigit Zo <zuozhijie@bytedance.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Eugenio Pérez <eperezma@redhat.com>

CC: leitao@debian.org
CC: sdf@fomichev.me
---
 drivers/net/netconsole.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9..9bc748ff5752 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -256,6 +256,24 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
+static int netconsole_setup_and_enable(struct netconsole_target *nt)
+{
+	int ret;
+
+	ret = netpoll_setup(&nt->np);
+	if (ret)
+		return ret;
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+	nt->enabled = true;
+
+	return 0;
+}
+
 /* Clean up every target in the cleanup_list and move the clean targets back to
  * the main target_list.
  */
@@ -574,11 +592,10 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netconsole_print_banner(&nt->np);
 
-		ret = netpoll_setup(&nt->np);
+		ret = netconsole_setup_and_enable(nt);
 		if (ret)
 			goto out_unlock;
 
-		nt->enabled = true;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -1889,7 +1906,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	if (err)
 		goto fail;
 
-	err = netpoll_setup(&nt->np);
+	err = netconsole_setup_and_enable(nt);
 	if (err) {
 		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
 		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
@@ -1898,8 +1915,6 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 * otherwise, keep the target in the list, but disabled.
 			 */
 			goto fail;
-	} else {
-		nt->enabled = true;
 	}
 	populate_configfs_item(nt, cmdline_count);
 
-- 
2.50.1


