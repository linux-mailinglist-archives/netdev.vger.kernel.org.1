Return-Path: <netdev+bounces-210940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55554B15C0B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBD37AD6C6
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166A275B1D;
	Wed, 30 Jul 2025 09:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.cecloud.com (smtp-pop-umt-1.cecloud.com [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1926D4F9;
	Wed, 30 Jul 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868225; cv=none; b=SeXg88cveorO4tfSiAOCZGLRInpmDDoXIQ/4nvhFFnVLqZ6xV9KRrBE6oz7P8MxK//8efNSceMVWVBX71BXYLuZSORDTNnm8UgupNnpGS0Mds7jxKNdhVQNDBnkFybTNK9h+T2jVSavesd2454Q5Tjo5mvOPMKtjkoGgZ2qvjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868225; c=relaxed/simple;
	bh=XgY84VYmd2hH14+kEb5sOVSlwxb483gjmX4Ox29snQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/zvh2nwVe3JGYFh/o3SMSYVGhN8u5XurJNJhghPE4jkjCMkXyl1yWQTPqBtnN+P6lz1XS+Laq8beT75kAxLT/VTSvWzrniJNbpDCttrxXoYOb0TrB/n/cc8qZZZBqDn6KDylKaVL2D5F/QeR5Nx9GGrooAKwsPMlbI/Er4OMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 933C17C015E;
	Wed, 30 Jul 2025 17:29:52 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.58.13])
	by smtp.cecloud.com (postfix) whith ESMTP id P2727722T281471814136176S1753867787395864_;
	Wed, 30 Jul 2025 17:29:52 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:zhangyanjun@cestc.cn
X-SENDER:zhangyanjun@cestc.cn
X-LOGIN-NAME:zhangyanjun@cestc.cn
X-FST-TO:willemdebruijn.kernel@gmail.com
X-RCPT-COUNT:5
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.13
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<bcd7d867fd0113528783db437b0d7cf6>
X-System-Flag:0
From: zhangyanjun@cestc.cn
To: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangyanjun@cestc.cn
Subject: [PATCH] tap/tun: add stats accounting when failed to transfer data to user
Date: Wed, 30 Jul 2025 17:29:40 +0800
Message-Id: <20250730092940.1439637-1-zhangyanjun@cestc.cn>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yanjun Zhang <zhangyanjun@cestc.cn>

To more accurately detect packet dropped, we add the dropped packet
counter with the device when kfree_skb is called because of failing
to transfer data to user space.

Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
---
 drivers/net/tap.c | 14 +++++++++++---
 drivers/net/tun.c |  9 ++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index bdf0788d8..9d288a1ad 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -759,6 +759,8 @@ static ssize_t tap_do_read(struct tap_queue *q,
 {
 	DEFINE_WAIT(wait);
 	ssize_t ret = 0;
+	struct tap_dev *tap;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!iov_iter_count(to)) {
 		kfree_skb(skb);
@@ -794,10 +796,16 @@ static ssize_t tap_do_read(struct tap_queue *q,
 put:
 	if (skb) {
 		ret = tap_put_user(q, skb, to);
-		if (unlikely(ret < 0))
-			kfree_skb(skb);
-		else
+		if (unlikely(ret < 0)) {
+			kfree_skb_reason(skb, drop_reason);
+			rcu_read_lock();
+			tap = rcu_dereference(q->tap);
+			if (tap && tap->count_rx_dropped)
+				tap->count_rx_dropped(tap);
+			rcu_read_unlock();
+		} else {
 			consume_skb(skb);
+		}
 	}
 	return ret;
 }
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd0..eb3c68e5f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2137,6 +2137,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 {
 	ssize_t ret;
 	int err;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!iov_iter_count(to)) {
 		tun_ptr_free(ptr);
@@ -2159,10 +2160,12 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 		struct sk_buff *skb = ptr;
 
 		ret = tun_put_user(tun, tfile, skb, to);
-		if (unlikely(ret < 0))
-			kfree_skb(skb);
-		else
+		if (unlikely(ret < 0)) {
+			dev_core_stats_tx_dropped_inc(tun->dev);
+			kfree_skb_reason(skb, drop_reason);
+		} else {
 			consume_skb(skb);
+		}
 	}
 
 	return ret;
-- 
2.31.1




