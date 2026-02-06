Return-Path: <netdev+bounces-257545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BiNKknohWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA283FDE3D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 386A4300D272
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E83D3D0B;
	Fri,  6 Feb 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXuLTkuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E03AEF59;
	Fri,  6 Feb 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383405; cv=none; b=HZPt11HS8lQXWErfz8mTKOpSTEwkg2UsBzmNHTuZ9oGPqod8Nyj6idX7LV5vnMF7BwyiZ76WbcrxEv4jWvy36uMKIUxIfSm+3g1F0SD3OlTrFLWZeunTs2YVppmUxntnwfrlNlLM7GSr1WbnstEeQ3z0wA/tW8lEZI1r/MDCD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383405; c=relaxed/simple;
	bh=hqTg+W43cuP9GROxoO3hWnsKMvI1ipu6Tj00dHfZyH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CNWkmRIZkOm4WC2PyH0weLDoROdsmVzHe5pEhREVfECP9a2Rt+0CAQ2M6lK9D0qAFeYpMzu84NfMgkO2fPXkEkL5pENurFooaiaz2pD3tRgQeqwSEP0Ck3DmFmGiGTk5iqNXXL1Y8kQpMNR3n7Ve4yI2rqjLuTfjDG4/mFfWCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXuLTkuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C16DC116C6;
	Fri,  6 Feb 2026 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770383404;
	bh=hqTg+W43cuP9GROxoO3hWnsKMvI1ipu6Tj00dHfZyH0=;
	h=From:Date:Subject:To:Cc:From;
	b=oXuLTkuu9n8ehqygtpOyTpsZ3b+elZUMhpLFzp5Nn61j4SGtD/6cnh7ku7GY9iPMS
	 wUDOxstm5Inighc0j15nhQapA+h3r5IhfnxOW6xyWbgjYWoM6gutFGqBYykd3V+cf0
	 jw08RWn5YHj7srHxGSLeXi0xf2vlf+4ZsCVSnd1JqIahnkUErhVUX62BPovx/G+l/D
	 QFa/uSjd6XxfKQ2kg5Y8U86gb9QrgSTHA18XoHZ1RgAELj6e6qDPUp1MjxSKBqyB3z
	 ol5Bex4HKG1g+8vvXgIsZgFPoiM2vq5VADt6rvDJ1mGhBL4YqNm72v9XJG6tfkyXWK
	 4gA9QsI9+ncFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Feb 2026 14:09:24 +0100
Subject: [PATCH net-next v2] mptcp: allow overridden write_space to be
 invoked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-net-next-mptcp-write_space-override-v2-1-e0b12be818c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAPohWkC/zWNwQrCMBAFf6Xs2YV00Sr+iojE5Kl7MA2bUAul/
 24o9DCHucwsVGCKQtduIcOkRcfURA4dhY9Pb7DG5iROBidu4ITamCt/cw2Zf6YVj5J9AI8TzDS
 Cn2fn4+lyFOl7aqVseOm8XW60B+i+rn/RQlRGfwAAAA==
X-Change-ID: 20260206-net-next-mptcp-write_space-override-b70ad5842211
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Sq+lU6RYuul91JeLGtKwgy51nQgLiBBw90QlQ7LQZdM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJbX2h5nPTcf+hFwp2VQhZ73CfUWC5f097YIn4l/9OT6
 1/0runmdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk43eG//lL2/yYlgUVFvXc
 vrkxeI/5KjGV3QabnvYoPPx80P5oeAHD/5KtxQu+ZvSsOXRsXuLzBJNS250FDJ9XOQp5m50N75k
 XywMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: BA283FDE3D
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

Future extensions with psock will override their own sk->sk_write_space
callback. This patch ensures that the overridden sk_write_space can be
invoked by MPTCP.

INDIRECT_CALL is used to keep the default path optimised.

Note that sk->sk_write_space was never called directly with MPTCP
sockets, so changing it to sk_stream_write_space in the init, and using
it from mptcp_write_space() is not supposed to change the current
behaviour.

This patch is shared early to ease discussions around future RFC and
avoid confusions with this "fix" that is needed for different future
extensions.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: set sk->sk_write_space to sk_stream_write_space (Review assistant)
v1: https://lore.kernel.org/20260203-net-next-mptcp-misc-feat-6-20-v1-7-31ec8bfc56d1@kernel.org
---
 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e0b4745bbaa9..cf1852b99963 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3058,6 +3058,7 @@ static int mptcp_init_sock(struct sock *sk)
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf = READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]);
 	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
+	sk->sk_write_space = sk_stream_write_space;
 
 	return 0;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4bfe91ca7f9..0bd1ee860316 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -975,7 +975,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)

---
base-commit: 24cf78c738318f3d2b961a1ab4b3faf1eca860d7
change-id: 20260206-net-next-mptcp-write_space-override-b70ad5842211

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


