Return-Path: <netdev+bounces-302411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F1i6LStmQWq6pQkAu9opvQ
	(envelope-from <netdev+bounces-302411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6A6D49B3
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=JOsp50a1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302411-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0199D300D32F
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1E2D73B5;
	Sun, 28 Jun 2026 18:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E22980A8;
	Sun, 28 Jun 2026 18:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782670887; cv=none; b=eFycUpUYyZzZvBALJCR2oay85EEyxnnxVcyof+Qnln9PpCNIfJGWmjrzJYCrGw+/OsyHjotf6g1D5Q3odtMMzYt4DUI8cWKXEdaeP/Gy3ZWBaphjITs/WZGRzziNIWlfNlnzK/1ghzZXsT2/GbgshBOOqlaQyhVw++0neZ0XbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782670887; c=relaxed/simple;
	bh=6ecvcZZwIGW0WNu/LrNgER3uaYd3SAlzeBRoHgs8h/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPPt5G5CquDXnlnHhWXp3orHl2yaIc4bbKSDd9m4bC8noe6TrijDBDUsQKf0eGAwpKhF3RqkOVLczlNW6sXGUr0DRyFtK6uTJWOM+2rfOvd6C57reFZQAcAYygBII9FqlSgk+AKNJ6dKwQkvkLXGyyfs+DovXOeF6ZiKI8lW9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=JOsp50a1; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0396510046F;
	Sun, 28 Jun 2026 21:21:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1782670875; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ybx06QVngD4wXg30CBktfaC6csvkv2GtKhVcyiALC80=;
	b=JOsp50a1CfK0tIu32RlCpNbhKSHUAEX4Qgt6xM9TUtrxWmIRE+1Pza+t/J2T5YzYVvEXVL
	d7iV7YGmPdQ26f7NhV+ASX+F7V7dCQ3aXEDFZolYadcjNzeWB9swYY+LpVbZ2TXeGoF90O
	PoszX9e5GtAuMja7xYHTwksaTlza2eOfrN5b38A3yQxoNQvXjDI3wz3bxCQijWFmZSJJNj
	BqkrbKQoS+44R1HkHlDUVrtXgkJ0BJvUXLc3AJzbQnSq2XNXvdmkwgcTCZymd55zZsCrwE
	YO8FMzzfF/C9EUW/WL9vQJeE8pufrThJX5KA1VxuaCUShYmmhWrIc4GSDzI0kQ==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
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
Subject: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag handling
Date: Sun, 28 Jun 2026 21:20:52 +0300
Message-ID: <20260628182052.951760-1-avkrasnov@rulkc.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302411-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,m:avkrasnov@rulkc.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org,rulkc.org];
	DKIM_TRACE(0.00)[rulkc.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3F6A6D49B3

Logically it was based on TCP implementation, so to make further support
easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
this way, patch also adds handling case when 'msg_ubuf' is already set.

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 Changelog v1->v2:
 * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
   already added.
 Changelog v2->v3:
 * Update commit message.
 * Remove one empty line.
 Changelog v3->v4:
 * Update commit message.

 net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..41c2a0b82a8e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
-- 
2.25.1


