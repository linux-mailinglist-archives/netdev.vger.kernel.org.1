Return-Path: <netdev+bounces-254898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ5iG1q0e2neHwIAu9opvQ
	(envelope-from <netdev+bounces-254898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC8B3F3E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B7B30675BD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4D325494;
	Thu, 29 Jan 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFZBf/wJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD75324B20;
	Thu, 29 Jan 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714643; cv=none; b=lgMzwTJlSyAlB3YgrG+ccFzyAPMXrXH4bf7itUPomlXCAtA+uaV82JHbltxViIM2TY0Fb99WuK7AKhf+0E4LAz5O79x8cx5rnGXB7JtsVwOh0nSCsAfm/1pTkdNwaFmhYehvO/Q+kO+Ml960+UO/FeByriBykTTpvyQoyphgL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714643; c=relaxed/simple;
	bh=5Dh23pg4rmx3pdbZnLnTYRE9W6G0tlsmGnODKbU5NA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBZx0D4TDW161BSPdCl09wgyoRghzSy0dRHVSIvHAv9MsDA9BeGBOIPz7GoHCl5LXJXNm242T9KeDW5hxl1s9NQwakm0OGKL/FkxuHPlXY5l7QY7LWCnQcSBAwM37u8B/13uZW7tECfJBMx7CEO4zK7rZxfWVn90PFcbbgNRQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFZBf/wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0C5C16AAE;
	Thu, 29 Jan 2026 19:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769714643;
	bh=5Dh23pg4rmx3pdbZnLnTYRE9W6G0tlsmGnODKbU5NA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bFZBf/wJ8hri4UyRUcvsyJFZLO9JtXx8lFUzwdiPm4MiUVySbe3GmXwXj4oZL+4mY
	 np9CuiKNL2Khhtp1rBJ6EzL/IgmH5GRbAmlP49ksXCmJq0FGJc44Nq5WXPP2IW8xLb
	 GLn+zCnoX1UObVcuO1veEaBuJ6CbNXX98kWQqEDq+bCpf9HewDp/n2+nwpxm2Hyq//
	 2dMhF34domOta3t6Hq9mmIEO4fZKYGYRl7mIVI3tlVmbl722GmfrfuVAPQaC5oXQ9k
	 FMuXW8MZRLfkS9W2wUsYI0DMg3Cv9TlZwx1O1Tt2F2l9f7QVe7VXZFr++CrmCLxGZG
	 KaPjuGWIoTqew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Jan 2026 20:23:37 +0100
Subject: [PATCH net-next 4/6] mptcp: implement .splice_read
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-net-next-mptcp-splice-v1-4-994cac40daa0@kernel.org>
References: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
In-Reply-To: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4175; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IWSUQH5+FB7+9xbI11VudN0EMrz/ck/e9lZJTN2typA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKrNx+uy0l4dGtBV2z1vZUVgocebukX37XZ5ry1WltLz
 KqLT1wudZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykR5jhn7LZdVGJFTXtbXyp
 W26vX+Wl9WpzAwPbzx+HLm0u/mtT3sHwV/r8CbHt959ueDw1WcTz3tT0R6wB9873akTVbDxuYbu
 dgQsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEEC8B3F3E
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
 net/mptcp/protocol.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c58e306ec3ef..3aee29f70954 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4396,6 +4396,118 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
@@ -4417,6 +4529,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4522,6 +4635,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;

-- 
2.51.0


