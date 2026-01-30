Return-Path: <netdev+bounces-255240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJUGFa8FfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333BBE1A8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AD773019D7D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC4389DF1;
	Fri, 30 Jan 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug7hDnJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F411388874;
	Fri, 30 Jan 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801093; cv=none; b=Fu0YrO1EKZaZkkLXBqYGa/prLUrH896XbQLE2yFP1CqOQeaPmniTUzg5ARAcGKXdQbRcB2tk5w5PPMYiYhQvqs2YhHMkfV1dyA2O4dOzbA00/fYGweDQ7BrClbueThp8peetAmnFFFkOvDBDm4bsmWsRuHQK883+mQ043xVbiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801093; c=relaxed/simple;
	bh=LYLjPE5IORq4UG8eIVkHs/P+wZb4Kq6vHRgDcEijYRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQbY5vwThiKy6Z02pYdaXxsrWFxDkwd15wq1L0Kvvm+9ccK1llg68c9T4TPxv7KmySFTAKa66vkBRuqAWjhemPMAFs/HlxvEgwwYo/e1GFf7EdP2C4N2yDug3oR9Im+NAGS8qOHrAVPEJLEO/a2p/NZzT3q0zxQwMYsur44qP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug7hDnJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6064C4CEF7;
	Fri, 30 Jan 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801093;
	bh=LYLjPE5IORq4UG8eIVkHs/P+wZb4Kq6vHRgDcEijYRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ug7hDnJeSs6BZvkht88WBiDalhscCjJc++vu7r/HArZmhCOZytim1+/ocPfhLZN1Y
	 Q0X5F8+khPlu9t48XJjAClwtraRHhMTKG96rthMccrhjNZUT/shupDngBeDFjmIkjf
	 DT+6nA2ykzH03EteEkTCT6KjHPXhhD3HGzk+2tzU396wP0UDsZeUS3SAogfwVl+hts
	 wZqv72eq++A3lZjIZCBl5Z1Eey4/z1IUR+EQTdIBtuIXBKN79lX3tQsK0Iymzulirh
	 WOMPzm9mLLHOIivm+K/tZSTZpVsSU19N5NikFMSy0XfUqPOGUiS39lPWvALiK8Zfv+
	 cNt/jJ2mc0KiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 20:24:27 +0100
Subject: [PATCH net-next v2 4/6] mptcp: implement .splice_read
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-net-next-mptcp-splice-v2-4-31332ba70d7f@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dGLYK6/3afPrBVUkXgyFIvesaiZzdIaNnL/eMHu9RBo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWUs5V1RqFL+qUtBfeeL1k/NfPqy7UP+a+8BLz6Z5M
 30+KR7R6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIjQKG/2nB3L735D5eKdnF
 3ruV8/iXQ006++J3TvyhVSf2vE/yHjMjQ98VpmLxrNtTk9TefJZcvPl43PnVfx1fWyiUMCc/eJe
 2ngMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 3333BBE1A8
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements .splice_read interface of mptcp struct proto_ops
as mptcp_splice_read() with reference to tcp_splice_read().

Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
invoking mptcp_read_sock() instead of tcp_read_sock().

mptcp_splice_read() is almost the same as tcp_splice_read(), except for
sock_rps_record_flow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: Fix kdoc warning reported by NIPA
---
 net/mptcp/protocol.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2071f984da12..9b8c51937eb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4397,6 +4397,121 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	return __mptcp_read_sock(sk, desc, recv_actor, false);
 }
 
+static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
+{
+	/* Store TCP splice context information in read_descriptor_t. */
+	read_descriptor_t rd_desc = {
+		.arg.data = tss,
+		.count	  = tss->len,
+	};
+
+	return mptcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
+}
+
+/**
+ *  mptcp_splice_read - splice data from MPTCP socket to a pipe
+ * @sock:	socket to splice from
+ * @ppos:	position (not valid)
+ * @pipe:	pipe to splice to
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will read pages from given socket and fill them into a pipe.
+ *
+ * Return:
+ *    Amount of bytes that have been spliced.
+ *
+ **/
+static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags)
+{
+	struct tcp_splice_state tss = {
+		.pipe	= pipe,
+		.len	= len,
+		.flags	= flags,
+	};
+	struct sock *sk = sock->sk;
+	ssize_t spliced = 0;
+	int ret = 0;
+	long timeo;
+
+	/*
+	 * We can't seek on a socket input
+	 */
+	if (unlikely(*ppos))
+		return -ESPIPE;
+
+	lock_sock(sk);
+
+	mptcp_rps_record_subflows(mptcp_sk(sk));
+
+	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
+	while (tss.len) {
+		ret = __mptcp_splice_read(sk, &tss);
+		if (ret < 0) {
+			break;
+		} else if (!ret) {
+			if (spliced)
+				break;
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+			if (sk->sk_err) {
+				ret = sock_error(sk);
+				break;
+			}
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
+				break;
+			if (sk->sk_state == TCP_CLOSE) {
+				/*
+				 * This occurs when user tries to read
+				 * from never connected socket.
+				 */
+				ret = -ENOTCONN;
+				break;
+			}
+			if (!timeo) {
+				ret = -EAGAIN;
+				break;
+			}
+			/* if __mptcp_splice_read() got nothing while we have
+			 * an skb in receive queue, we do not want to loop.
+			 * This might happen with URG data.
+			 */
+			if (!skb_queue_empty(&sk->sk_receive_queue))
+				break;
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0)
+				break;
+			if (signal_pending(current)) {
+				ret = sock_intr_errno(timeo);
+				break;
+			}
+			continue;
+		}
+		tss.len -= ret;
+		spliced += ret;
+
+		if (!tss.len || !timeo)
+			break;
+		release_sock(sk);
+		lock_sock(sk);
+
+		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
+		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+		    signal_pending(current))
+			break;
+	}
+
+	release_sock(sk);
+
+	if (spliced)
+		return spliced;
+
+	return ret;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4418,6 +4533,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4523,6 +4639,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;

-- 
2.51.0


