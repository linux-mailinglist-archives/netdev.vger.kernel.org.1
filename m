Return-Path: <netdev+bounces-47815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B07EB710
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145851F25896
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F226AF5;
	Tue, 14 Nov 2023 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOo7GARy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE326AF1;
	Tue, 14 Nov 2023 19:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA2FC433C8;
	Tue, 14 Nov 2023 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991904;
	bh=PrT/WXRWQ+UoLDuLY86hcudF5jYe+rrWiSE1xiAAZME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HOo7GARyB7IhJCM5f/VCt155npdbAcsiX4oGqaX5rkajopetA9SDGynf/9Hx1c2mE
	 i+0NiIlzdesXkzN0pyZ+YRbemnb4jf5fkhriHvzjq8Ag9ABvOnl/e9LJrGLvT0tCqu
	 RNNkthfXkfbmQd/OnZDkVXXUxM3TbnwRYdjXYwAZf2TFxA89ZhgJNU3VDZ3TY2aOAw
	 fjnV/NJjpwRA9TZz+DliV2yVjmaiGm/NWG0+3Gjs6qwu4NIJlalBQk7g7MfgkxRoOu
	 ebH+DlNHCtjeKsTTJprHpdgqaZCjdzhH6fNlWDpkQiUL+cQYphQLDObUXDS2qhnHnd
	 TN6luYqlFQGbg==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 14 Nov 2023 11:56:43 -0800
Subject: [PATCH net-next v2 01/15] mptcp: add mptcpi_subflows_total counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-send-net-next-2023107-v2-1-b650a477362c@kernel.org>
References: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
In-Reply-To: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
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
index 77f5e8932abf..8d485c40585a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -935,6 +935,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	info->mptcpi_subflows_total = info->mptcpi_subflows +
+		__mptcp_has_initial_subflow(msk);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);

-- 
2.41.0


