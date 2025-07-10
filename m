Return-Path: <netdev+bounces-205745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C4AFFF43
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363355A5175
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664F2E4248;
	Thu, 10 Jul 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M27Gz/d1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8791DF75C;
	Thu, 10 Jul 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143234; cv=none; b=RIxQyIKKUyLZ9EPumllPs9DVKatZuTuTGFxJ1xt6chiQZT+IQoN66lS93NHt8vkpYSExQ/y6XzJ7RRoCusIfPuRIA+iA0nI/D4/QiaSu3veNjI314vajOSyl+OGX7aBd0THXc2zfiytL0VsjbXjLsaOAdmQ1KP0rIwV1qhXPnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143234; c=relaxed/simple;
	bh=V7vFD7/Fb8G++Y1kaiWeRxlwbZhdhohmLHeU+PMkKdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGE17o4IVhFcfuMbannYbMRJAXbwgr3/2rX8E85Nt8ZTgM7ir5jVkusvqYtk6fZov9a6Qzls+z6oanv5TtIr6WDnFjrAUckrLpgVCHjAQNvFi/Wlx75+ieB7AEypndQSaqI+ZCo40KPyXfwBYmSWtpho4nHdpxFctJ9GEK333jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M27Gz/d1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9j
	sQItpI3KggjxElmfZojdWrsrVGwjxm/rP2m4AKOMA=; b=M27Gz/d1EGqoZdCuZt
	MzKgkwl7d22rG61D0Fy67NXLbNGCZq0pF6mD752l/1RAPbbxZ+D6WYS/uVAQsWOt
	GzSMALSMGF4VAtmL+uOWH/K3mCHT/pmM5cPNJYMy1ARi5ZoTfiPw/KJARHQDeMT2
	JGPwwyPa5LnVn8pzXM92awzFc=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXowFflW9oGKJ1Dw--.26998S3;
	Thu, 10 Jul 2025 18:26:41 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
Date: Thu, 10 Jul 2025 18:26:37 +0800
Message-ID: <20250710102639.280932-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710102639.280932-1-luyun_611@163.com>
References: <20250710102639.280932-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXowFflW9oGKJ1Dw--.26998S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13Zr17KF13tF1fJryfXrb_yoW8tr4rpa
	y5K347XayrJr10gr1xJ3Z8X3W3X3y8JrZ3CryFv3Waywnxtr9aqF18t3yj9FyrZaykAa43
	JF1vvr45Aw1Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsYFAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWwuGzmhvj82eWwABsZ

From: Yun Lu <luyun@kylinos.cn>

Due to the changes in commit 581073f626e3 ("af_packet: do not call
packet_read_pending() from tpacket_destruct_skb()"), every time
tpacket_destruct_skb() is executed, the skb_completion is marked as
completed. When wait_for_completion_interruptible_timeout() returns
completed, the pending_refcnt has not yet been reduced to zero.
Therefore, when ph is NULL, the wait function may need to be called
multiple times until packet_read_pending() finally returns zero.

We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
constraint could be way off.

Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from tpacket_destruct_skb()")
Cc: stable@kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/packet/af_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3d43f3eae759..7089b8c2a655 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2785,7 +2785,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen = 0;
-	long timeo = 0;
+	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
 
@@ -2839,6 +2839,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
 		size_max = dev->mtu + reserve + VLAN_HLEN;
 
+	timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 	reinit_completion(&po->skb_completion);
 
 	do {
@@ -2846,7 +2847,6 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
 			if (need_wait && skb) {
-				timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
-- 
2.43.0


