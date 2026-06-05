Return-Path: <netdev+bounces-295800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9eKfDZW6ImpdcwEAu9opvQ
	(envelope-from <netdev+bounces-295800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:01:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB00647E91
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=gX8dz6Jy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295800-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295800-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E675300144D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9414D98E0;
	Fri,  5 Jun 2026 12:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E83B3BF2;
	Fri,  5 Jun 2026 12:01:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660881; cv=none; b=O0P43sSC52XN64Rig2bOO7qMAmcBkgPZPjmgkMts2An6eSYDUgz8O1ofqhw8NGuMgGEJ4/Ia+wlnzUIr52DsWLmbD4WwZs0sCshOdK9ScYxAvNSZuiN5X3i6gLs1ERvtKBENzclKiJb9GWpF6uxnh92qlN6KpzlB48WsHiQhSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660881; c=relaxed/simple;
	bh=mVQZ3Z5gP/h9nfdD+wZ39ygVu8JFQL3b7h/XBXivkrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPxDRoKvOynSLm1JVGc7bJOoD0LHis9qEWemvfANAcQxLVrA0NP+7uU17kZG14KY7T3csXSAJteyW8/Z2GFw4Hg0uYzmE1eVsU/b0GESIUh/zKmabAthItDY9FAZ9C6aIQrkyZZsSjZygbKS0axBouJ9aKtjIsGgWQ+tyBg2n1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=gX8dz6Jy; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D416C100036;
	Fri,  5 Jun 2026 14:53:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780660424; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6iwVaCXRpwiv+vZVNr+kltBX5rtqh1FPWM+jo4bxm3Q=;
	b=gX8dz6Jy2eSO7V4psvQMSFoBw/4WKMZBqGzngW/t9BLUC/h/82UuA5cn2TwlKfyC4GknqM
	kern3R9VYAm4U+wajP55edgXl3yrBlzhHreotpUzjYknFHOmqvcdAFSeJb8ZjpyhzoppGH
	2VeobGTX7wtgg6SE/4R7ammAm7GpKCtVxXO3m2htivJ5Vj94+TbxyuMnWkA8KQkillrTZe
	pGRCKij7eOAR+yaM+G201q/S7ktlWQ8n7C6KG/Xj0s3IepcdHbRkUzgzX0vpYy9G06Tvjf
	yLDjlPB1KgilNNxdGgbNYx47Eh36yvhoncwYMysg3hCSq9U0lTHrwJfd2PSBJA==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com,
	rulkc@linuxtesting.org,
	Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Date: Fri,  5 Jun 2026 14:53:14 +0300
Message-ID: <20260605115314.552321-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,m:avkrasnov@rulkc.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295800-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[rulkc.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org,rulkc.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFB00647E91

Logically it was based on TCP implementation, so to make further
support easier, rewrite it in the TCP way.

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2fd9eaaf5ca6..00caeeaa5590 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
-				     bool zcopy)
+				     bool zcopy, struct ubuf_info *uarg)
 {
 	struct msghdr *msg = info->msg;
 
+	/* We have completion - attach it to 'skb'. */
+	skb_zcopy_set(skb, uarg, NULL);
+
 	if (zcopy)
 		return __zerocopy_sg_from_iter(msg, NULL, skb,
 					       &msg->msg_iter, len, NULL);
@@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
-						  u32 dst_port)
+						  u32 dst_port,
+						  struct ubuf_info *uarg)
 {
 	struct vsock_sock *vsk;
 	struct sk_buff *skb;
@@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
-		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
+		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
 		if (err)
 			goto out;
 
@@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
 		return pkt_len;
 
-	if (info->msg) {
-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
-		 * there is no MSG_ZEROCOPY flag set.
+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
+		 * handling from 'tcp_sendmsg_locked()'.
 		 */
-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
+		if (info->msg->msg_ubuf) {
+			uarg = info->msg->msg_ubuf;
+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
+						    NULL, false);
+			if (!uarg) {
+				virtio_transport_put_credit(vvs, pkt_len);
+				return -ENOMEM;
+			}
 
-		if (info->msg->msg_flags & MSG_ZEROCOPY)
 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
 
+			if (!can_zcopy)
+				uarg_to_msgzc(uarg)->zerocopy = 0;
+
+			have_uref = true;
+		}
+
+		/* 'can_zcopy' means that this transmission will be
+		 * in zerocopy way (e.g. using 'frags' array).
+		 */
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
-
-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
-		    info->op == VIRTIO_VSOCK_OP_RW) {
-			uarg = info->msg->msg_ubuf;
-
-			if (!uarg) {
-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-							    pkt_len, NULL, false);
-				if (!uarg) {
-					virtio_transport_put_credit(vvs, pkt_len);
-					return -ENOMEM;
-				}
-
-				if (!can_zcopy)
-					uarg_to_msgzc(uarg)->zerocopy = 0;
-
-				have_uref = true;
-			}
-		}
 	}
 
 	rest_len = pkt_len;
@@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
 						 src_cid, src_port,
-						 dst_cid, dst_port);
+						 dst_cid, dst_port, uarg);
 		if (!skb) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
@@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
-					   le32_to_cpu(hdr->src_port));
+					   le32_to_cpu(hdr->src_port), NULL);
 	if (!reply)
 		return -ENOMEM;
 
-- 
2.25.1


