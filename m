Return-Path: <netdev+bounces-255238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI9ZMZUFfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60DBE18A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32E103002323
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B62389451;
	Fri, 30 Jan 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT+bvUve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522538884B;
	Fri, 30 Jan 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801088; cv=none; b=sRex0dvFqYxXi4rymxu53SIAHklju82X3UPqX5paP6P3dWfJ2otJsKwI7i9TzyZ4O+rNzrwZnu0nhZ1zzCYIbLvFoBXv3CQl2/weKsWEvFtNPEYd6BbHV7didmhKwbi/RaieVQ36fnLo9FFhZj7eUXc1nzHOHrSffuROjcm3eIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801088; c=relaxed/simple;
	bh=OJHRmNNIJWRbPOyDdCEKU1GKMjHvZW8dJ0Y58MwPp6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNqiF0RjMx96PZw+I+5r/fKQQwel1BGTolQFBUld9uONrTvNWzM/BR99Vs8pCHEP1XcwS4T0S9jlkQpIP/fsjrftYsDn+xpwiD3FsBdTs02Nf3UEIXIDVTfr448rK2FbtQyFkdnaxUWFt/ncSaAiYusn+FPxMbSjqGMbPlhM7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT+bvUve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06FBC16AAE;
	Fri, 30 Jan 2026 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801087;
	bh=OJHRmNNIJWRbPOyDdCEKU1GKMjHvZW8dJ0Y58MwPp6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CT+bvUveE2kLSdQz77bEfZtngsSlhGtaN7EsVvbdusrs2DVfgKirgmT1GXSUbQecK
	 3Azuvzhex698r7nOLXoYrnw+mxLp03IDjzOJsF9DQlE9HPwm7hU6e6XHk5c19Toi6n
	 4TowlOA6po+VIypORSFioJwKAdWbRJYFP/SpspwaOxVj6qRcff1moTheX4I/JNzkiw
	 zTwoRd/0EkvJLMnhKhcBSK4AnNSEnDuYHiYD88qwZpOx/Hdj/MQMl4D1Zrau/fxAe6
	 Eb5rwIafGVHUqucTHf7G6nOVVat/NfebIzKAPcI7DtrUefR+FOV9OJ5xMBTRBKlLz5
	 ZA5IATnAaPiCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 20:24:25 +0100
Subject: [PATCH net-next v2 2/6] mptcp: implement .read_sock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-net-next-mptcp-splice-v2-2-31332ba70d7f@kernel.org>
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hannes Reinecke <hare@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KMuYOcjFI7Lawq5WHpxaJGlfAmPSD3RlV7+TssOLC88=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWUs6Lnh1+G6foeV0vOttzqZLz3a98vr2U6Bq2jmdc
 E2vEw8VOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSW8XI0NIcovhH9OUZD55T
 EoFVS9Ls/hgr70m9sWT9zPLjje9uhzAyzDF2OF5Ts+/84w3lRqEb50fysU4sWKS27fL6XO5Ngkb
 5jAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF60DBE18A
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

Current in-kernel TCP sockets -- i.e. from nvme_tcp_try_recv() -- need
to call .read_sock interface of struct proto_ops, but it's not
implemented in MPTCP.

This patch implements it with reference to __tcp_read_sock() and
__mptcp_recvmsg_mskq().

Corresponding to tcp_recv_skb(), a new helper for MPTCP named
mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.

Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
sk->sk_rcvbuf as the max read length. The LISTEN status is checked
before the while loop, and mptcp_recv_skb() and mptcp_cleanup_rbuf()
are invoked after the loop. In the loop, all flags checks for
__mptcp_recvmsg_mskq() are removed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5eb2a6182d4b..2071f984da12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4317,6 +4317,86 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	u32 offset;
+
+	if (!list_empty(&msk->backlog_list))
+		mptcp_move_skbs(sk);
+
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		offset = MPTCP_SKB_CB(skb)->offset;
+		if (offset < skb->len) {
+			*off = offset;
+			return skb;
+		}
+		mptcp_eat_recv_skb(sk, skb);
+	}
+	return NULL;
+}
+
+/*
+ * Note:
+ *	- It is assumed that the socket was locked by the caller.
+ */
+static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			     sk_read_actor_t recv_actor, bool noack)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		u32 data_len = skb->len - offset;
+		int count;
+		u32 size;
+
+		size = min_t(size_t, data_len, INT_MAX);
+		count = recv_actor(desc, skb, offset, size);
+		if (count <= 0) {
+			if (!copied)
+				copied = count;
+			break;
+		}
+
+		copied += count;
+
+		msk->bytes_consumed += count;
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			break;
+		}
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	if (noack)
+		goto out;
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+out:
+	return copied;
+}
+
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	return __mptcp_read_sock(sk, desc, recv_actor, false);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4337,6 +4417,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4441,6 +4522,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;

-- 
2.51.0


