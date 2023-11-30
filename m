Return-Path: <netdev+bounces-52547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC37FF1A6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9D8B20F2B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41D4F89E;
	Thu, 30 Nov 2023 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vcT1ikKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD7838DE3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D1C433C9;
	Thu, 30 Nov 2023 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354049;
	bh=JvX9vOIldncs1qZta3Pp662iEvBIIZCayC4dB/Tb45E=;
	h=From:To:Cc:Subject:Date:From;
	b=vcT1ikKm9H2BhHQ0kaIk25AQlJGjuw/97fmICMhzZTR0jN3PGLbdMGmsdSGragO9H
	 mHKDud1VIB7ihBFVG4uFbuYD2WRwtmVal0jdXj/oVdL2PQiWadleV1rK/7jaYWld4d
	 RhaCDZm9DAYLdgs6F+86DJjzciMFy9Zx/GblynD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
	stable <stable@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net] net/packet: move reference count in packet_sock to 64 bits
Date: Thu, 30 Nov 2023 14:20:43 +0000
Message-ID: <2023113042-unfazed-dioxide-f854@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 99
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=JvX9vOIldncs1qZta3Pp662iEvBIIZCayC4dB/Tb45E=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkZs6w6gxujn1tIpT2Zf+mfbsvi4uOMpnwvI2okL/Rve l7h/EGkI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaSncqwoHl7jO6vL/tY537O zlm/pdPanv2+I8OCpTrHinTjNb4ubsrc9ZDL2YPzz7ubAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In some potential instances the reference count on struct packet_sock
could be saturated and cause overflows which gets the kernel a bit
confused.  To prevent this, move to a 64bit atomic reference count to
prevent the possibility of this type of overflow.

Because we can not handle saturation, using refcount_t is not possible
in this place.  Maybe someday in the future if it changes could it be
used.

Original version from Daniel after I did it wrong, I've provided a
changelog.

Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
Cc: stable <stable@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c | 16 ++++++++--------
 net/packet/internal.h  |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..9356b661c3d9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4300,7 +4300,7 @@ static void packet_mm_open(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_inc(&pkt_sk(sk)->mapped);
+		atomic64_inc(&pkt_sk(sk)->mapped);
 }
 
 static void packet_mm_close(struct vm_area_struct *vma)
@@ -4310,7 +4310,7 @@ static void packet_mm_close(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_dec(&pkt_sk(sk)->mapped);
+		atomic64_dec(&pkt_sk(sk)->mapped);
 }
 
 static const struct vm_operations_struct packet_mmap_ops = {
@@ -4405,7 +4405,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	if (!closing) {
-		if (atomic_read(&po->mapped))
+		if (atomic64_read(&po->mapped))
 			goto out;
 		if (packet_read_pending(rb))
 			goto out;
@@ -4508,7 +4508,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
-	if (closing || atomic_read(&po->mapped) == 0) {
+	if (closing || atomic64_read(&po->mapped) == 0) {
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4526,9 +4526,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		po->prot_hook.func = (po->rx_ring.pg_vec) ?
 						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
-		if (atomic_read(&po->mapped))
-			pr_err("packet_mmap: vma is busy: %d\n",
-			       atomic_read(&po->mapped));
+		if (atomic64_read(&po->mapped))
+			pr_err("packet_mmap: vma is busy: %lld\n",
+			       atomic64_read(&po->mapped));
 	}
 	mutex_unlock(&po->pg_vec_lock);
 
@@ -4606,7 +4606,7 @@ static int packet_mmap(struct file *file, struct socket *sock,
 		}
 	}
 
-	atomic_inc(&po->mapped);
+	atomic64_inc(&po->mapped);
 	vma->vm_ops = &packet_mmap_ops;
 	err = 0;
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index d29c94c45159..24acd0044a0d 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -122,7 +122,7 @@ struct packet_sock {
 	__be16			num;
 	struct packet_rollover	*rollover;
 	struct packet_mclist	*mclist;
-	atomic_t		mapped;
+	atomic64_t		mapped;
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
-- 
2.43.0


