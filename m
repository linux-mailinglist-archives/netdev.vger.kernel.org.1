Return-Path: <netdev+bounces-51893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336327FCAAC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A421C21033
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C35733F;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3FZG34E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894757331;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0809C433C9;
	Tue, 28 Nov 2023 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213562;
	bh=M5u5ricN8dE0dpJH5QiswSnk5V2Np+4+FdicUPsxrdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h3FZG34EvFsQSarSI30iTTptlqmytgUki36OkcBrAUSJWbS2yuMNw9WJnOeKb3Qwk
	 irMyEDQWnTPCLOHEm5QTT+eztECBHD3YaDi1qQ4tBwt01LOHuJEXb3sCpaqVzMuPvk
	 dDeqZx+q/0ZXHTXKVzh2xCIq0a9vto2iBjyWvyL5QOFTDimxdPDRD50T9Br+DURYsD
	 ByA2Y45CeoP6Dsub1QNzvSrkLZHyp7vTvsWziD/G6cCKPtK92paiBEbRQU/5/PSAav
	 VVVB3nJvfDPu0rw3Ey+6aWJWazeTWIyRXdG7lop/16QCuWTu3bsQKi2mUL2SX9BafV
	 lZryyftbfmDUg==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:45 -0800
Subject: [PATCH net-next v4 01/15] mptcp: add mptcpi_subflows_total counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-1-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new counter mptcpi_subflows_total in mptcpi_flags to
store the total amount of subflows, including the initial one. A new
helper __mptcp_has_initial_subflow() is added to check whether the
initial subflow has been removed or not. With this helper, we can then
compute the total amount of subflows from mptcp_info by doing something
like:

    mptcpi_subflows_total = mptcpi_subflows +
            __mptcp_has_initial_subflow(msk).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/protocol.h       | 9 +++++++++
 net/mptcp/sockopt.c        | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index a6451561f3f8..74cfe496891e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -57,6 +57,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fe6f2d399ee8..458a2d7bb0dd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1072,6 +1072,15 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
+{
+	struct sock *ssk = READ_ONCE(msk->first);
+
+	return ssk && ((1 << inet_sk_state_load(ssk)) &
+		       (TCPF_ESTABLISHED | TCPF_SYN_SENT |
+			TCPF_SYN_RECV | TCPF_LISTEN));
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 353680733700..cabe856b2a45 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -938,6 +938,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	info->mptcpi_subflows_total = info->mptcpi_subflows +
+		__mptcp_has_initial_subflow(msk);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);

-- 
2.43.0


