Return-Path: <netdev+bounces-240828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B4C7AFD7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2C513687B2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405734FF47;
	Fri, 21 Nov 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR2Sp7nC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E934FF41;
	Fri, 21 Nov 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744565; cv=none; b=EPW9+M/np4pNITmKJ76g3ZRAw9wv7FiM0fnGdbhJjA0Lsgw1umHYygl8577vKLmQC0XXp5GhgdUZN/wI+Hp32FN09+uf3lXOvBbkcMSZ19nnKR6PJ3Psm+sSwOxh+adYNqgUVIcm2RXOruEkR5LRBBhoUWbwm8A34xjbEouhIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744565; c=relaxed/simple;
	bh=yR90RXZ3QrEYVCUxbKbZqVjv/h5Ac8YPBbnH0DCdS84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ob70GpSPcNdPGJoucrLqTuFA+xbXHFvOGU/WStmamYESW4oRUR7Gui+B+xhEW2xbqMzf8RUBGv83W9wsNULBF0Mje1vKWlaLrDIg6kAu4f19TpUml/nu8Hn6lU4JS2ibLTbyX5KhacqKsKoa8MImyEC8ubBXt/KA24cVT1zFba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR2Sp7nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC6C4CEF1;
	Fri, 21 Nov 2025 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744565;
	bh=yR90RXZ3QrEYVCUxbKbZqVjv/h5Ac8YPBbnH0DCdS84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LR2Sp7nCzmQrZHf+Erqbt7xwGjNeGmtru2mfEH+z3ajOp0Fb02Kc3pWNW0nNwzY5L
	 fUejlBa1gbb7qxII5nrjg0jCerHdB3CXzUO6xZZjQS7DtcQtz2BlwRxHkPskVBUWFZ
	 qOt5KquUqXkDjztzoVHWuBEC/vX8400ZTp1GnXBLj8NSv8UqSk+q5BTnXu2ExyTRqS
	 mmPfinWyixBTqdDmVOO8TvblsV98xZru/qzjoaPeNjwRD9kFHwbFksApU1vlq8+TCi
	 ery2ZKLLbng6sBiIrT2n+tzUTOC3JU+DABxisO/AnMKK5JFijvNa8NepHljyaNKFjd
	 XmCx8f5New9vw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:04 +0100
Subject: [PATCH net-next 05/14] mptcp: cleanup fallback data fin reception
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-5-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VEHGF89C18Lt+T6mAhQaFTy0GJ+jzNFrpHskh7oH5Ek=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZot9jFcS9LqzP3Hl9cLERDPTntl/LixbcIv78Pdg8
 +2J9nopHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZk8/wz8Ty4Pn5xnHW5VlZ
 SntdWw8ZJB/5dbHmltpBQx7h7GSRrYwMW9SOeIjecDLwm/Y/dZ8nPw8Xo9Q9rUn8+ZbmdSd+1Vs
 wAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

MPTCP currently generate a dummy data_fin for fallback socket
when the fallback subflow has completed data reception using
the current ack_seq.

We are going to introduce backlog usage for the msk soon, even
for fallback sockets: the ack_seq value will not match the most recent
sequence number seen by the fallback subflow socket, as it will ignore
data_seq sitting in the backlog.

Instead use the last map sequence number to set the data_fin,
as fallback (dummy) map sequences are always in sequence.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 72b7efe388db..1f7311afd48d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1285,6 +1285,7 @@ static bool subflow_is_done(const struct sock *sk)
 /* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
 
 	if (likely(ssk->sk_state != TCP_CLOSE &&
@@ -1303,7 +1304,8 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 	 */
 	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
 	    msk->first == ssk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
+				      subflow->map_data_len, true))
 		mptcp_schedule_work(sk);
 }
 

-- 
2.51.0


