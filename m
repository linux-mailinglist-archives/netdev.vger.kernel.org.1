Return-Path: <netdev+bounces-160121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E0A1857F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEFF3AB4C0
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0CE1F76D8;
	Tue, 21 Jan 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="X422TL3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A01F76A7
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486673; cv=none; b=Qta2HK7Zfewse+FBhn8K06R52IwXMvp0kvYdhUuplPWoUs0lejIHMeKXQGNyqgRcl8uPt87cO7pN4T63ervHmdSbcwqfc4oj8y/RdUo4W4ogB94E21n/irxWd88qjO5Rek4E8neCrjRUnENdAQfzPC/DbryaK4/DIPjRJQvqELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486673; c=relaxed/simple;
	bh=36m+Ryb9CJuvJR9nbvQowFH7ClbOSrNUnAqBaTNmIQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9JUqUTHPh8F+uNRrc1r5XRdNN/1qlOMK5hUJBhfEUL9fymw+VSpjb6JSzQNz//ZcP3KeVgkwBmF8BBFVW+4v4OFHmAW4apiSgQJloNPO5KHVKE4epI1RXODl4XwXJfLNJqHrIlTIPo5BfqJC/iZZdhMHodEK1i7uf/XrAk761g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=X422TL3N; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so10396023a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486669; x=1738091469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDwiQXOb0dtbRJ3DmhupJOiqoOo1ySphxgwOZ65b5Lc=;
        b=X422TL3NgiDRJB9TLcq0u5EBu2w1v5ZZuFriMvZtJRVPqlQxCpFEvdkuozAlgADo09
         wrb0sKV4WC9ZNLGRbw7W4vYgPAn2rVo0JLUNJ87Fe9XyeyP9qBsPpvuz/K/ND6pG3KaF
         XzomIJxyA9JzADSCTyp9SgLZo2+8jQppuyxc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486669; x=1738091469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDwiQXOb0dtbRJ3DmhupJOiqoOo1ySphxgwOZ65b5Lc=;
        b=UkdrJOhmZ6R1qy2Yo5CojuEQUnFojPR/sm87QG+NfgwizJ2Lyt24HVvKAWS8zLNtUL
         gSQ3KSVmWTnKVaSjoOUm8u6UGCGul+k40rIUs0Z1UniG68upovPJY+nbWHKWLQgDtwjK
         G0VP3AHKHJTrX5lk0ku2NZQUhyczCyJT5bELP+w9Hyrj3UWarjDWxNN27QWbXhvvCRj0
         Md1FUiWybd/xvzhESXI9WOHn3EwNRFXtQCwBAZ+2F5S9UqbeWItmStF48O/dGmTjKbB2
         beuZr1/S3R5X6tfAy9OHmByLOh6KHolIyTbqIoKp966nKOr1l9HZvMQHj1o8a3T+qquY
         1VVw==
X-Gm-Message-State: AOJu0YzShw03Sswymf2w+wzcenIsHM/AIG52/HCSvt8fIU1EKNzP7YCL
	GhxURFnHC+o9cUqWNx64OKt11sCid5hfau1FUHnKxPhgElnpNnlKswIkOEolvUKUT3YhyrqCBCj
	YZFVZP/HF+CmGcblizq1WI/zvbj2hmhnbo0/cfwRlUWs5kBc/7m4sMMPf3kPnsN+iXuhtkOVMT7
	nTh0Kxpkcj8mYMRiEWKFPLKJ5QWryTrQLnPFY=
X-Gm-Gg: ASbGncvehyzVa/hFBn35cs/wFXq75hf5Xz48lNDATI1QftUoKmt3zdPeLcBWIEmDTfI
	3dkZbMNcgpnUZOMOmvJw9DIqjKCTCuE+Q6BXgWnlrZsjMR5d1GQ79kogbCaTWBpKovM0g8jeBwp
	U/hVWbkcnpNLMojbWKV8q7ittPZLbT/7gSxvinTTDpQNNdj4BYow5E4M+s8zikc6Senu8q70WJf
	Bi0n/EZqCl0SKfTSGjUF5Dxb4ActLfAlYKs29m9NTa5/g6y5PQwn3XpRfPmncm4j6AZ794PVOir
	pg==
X-Google-Smtp-Source: AGHT+IFrbRJ/R0m0SceTG3oQbb0XNatc3hOdnfunYdBKaQ+YC8e4bymwDNEoE5iJLWgFoSXDDDTmQQ==
X-Received: by 2002:a17:90a:d60f:b0:2ef:31a9:95af with SMTP id 98e67ed59e1d1-2f782d32956mr26450648a91.27.1737486668611;
        Tue, 21 Jan 2025 11:11:08 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:08 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 1/4] net: protect queue -> napi linking with netdev_lock()
Date: Tue, 21 Jan 2025 19:10:41 +0000
Message-Id: <20250121191047.269844-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

netdev netlink is the only reader of netdev_{,rx_}queue->napi,
and it already holds netdev->lock. Switch protection of the
writes to netdev->lock as well.

Add netif_queue_set_napi_locked() for API completeness,
but the expectation is that most current drivers won't have
to worry about locking any more. Today they jump thru hoops
to take rtnl_lock.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Added in v2 from Jakub.

 include/linux/netdevice.h     |  9 +++++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8da4c61f97b9..4709d16bada5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -691,7 +691,7 @@ struct netdev_queue {
  * slow- / control-path part
  */
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * Readers and writers must hold netdev->lock
 	 */
 	struct napi_struct	*napi;
 
@@ -2467,7 +2467,8 @@ struct net_device {
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
 	 *
-	 * Also protects some fields in struct napi_struct.
+	 * Also protects some fields in:
+	 *	struct napi_struct, struct netdev_queue, struct netdev_rx_queue
 	 *
 	 * Ordering: take after rtnl_lock.
 	 */
@@ -2694,6 +2695,10 @@ static inline void *netdev_priv(const struct net_device *dev)
 void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
+void netif_queue_set_napi_locked(struct net_device *dev,
+				 unsigned int queue_index,
+				 enum netdev_queue_type type,
+				 struct napi_struct *napi);
 
 static inline void netdev_lock(struct net_device *dev)
 {
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 596836abf7bf..9fcac0b43b71 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -23,7 +23,7 @@ struct netdev_rx_queue {
 	struct xsk_buff_pool            *pool;
 #endif
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * Readers and writers must hold netdev->lock
 	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..ab361fd9efd9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6842,14 +6842,24 @@ EXPORT_SYMBOL(dev_set_threaded);
  */
 void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type, struct napi_struct *napi)
+{
+	netdev_lock(dev);
+	netif_queue_set_napi_locked(dev, queue_index, type, napi);
+	netdev_unlock(dev);
+}
+EXPORT_SYMBOL(netif_queue_set_napi);
+
+void netif_queue_set_napi_locked(struct net_device *dev,
+				 unsigned int queue_index,
+				 enum netdev_queue_type type,
+				 struct napi_struct *napi)
 {
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	if (dev->reg_state >= NETREG_REGISTERED)
-		ASSERT_RTNL();
+	netdev_assert_locked_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
@@ -6864,7 +6874,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 		return;
 	}
 }
-EXPORT_SYMBOL(netif_queue_set_napi);
+EXPORT_SYMBOL(netif_queue_set_napi_locked);
 
 static void napi_restore_config(struct napi_struct *n)
 {
-- 
2.25.1


