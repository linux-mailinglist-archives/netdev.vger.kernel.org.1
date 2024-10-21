Return-Path: <netdev+bounces-137539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4509A6DCE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D58B216CA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB61FA264;
	Mon, 21 Oct 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Zfgz91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70631FA24E;
	Mon, 21 Oct 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523672; cv=none; b=E3/Gm/mR/wrB1P4NCSDO8NMIXtPh4mB0EO9C0wU2ai1WRxQ9oRl7N/R80JOFbeaUBNITMq8+0KbHgh5ZwwzbkvZ+38+jTcVoCCiuehpYYvwX8VVN3swzYaaG0PTzHg/glOk3+u55Q8IBV374RcNSBAMFUQYkK531RLX7tqAkIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523672; c=relaxed/simple;
	bh=UGwRH+uD/CUajxibX4q7O5V5qsIa9cWrqqplz3NZlWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0D96JD9Y/TRqgnnqeu7z6pRIBm8eus6/HYsOj5bnSxmIev0Nqy+xnK06EvtG5UiMSXVGeLALtqvxA+4+U5OKsuzts+LifUmomTFT6ja37C6IkC7LNTjfrJdQREPoZormsHbly+RQA8cBqgQ28DX4JQdorCpxs/D215sdllspQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Zfgz91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA0FC4CEE7;
	Mon, 21 Oct 2024 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523672;
	bh=UGwRH+uD/CUajxibX4q7O5V5qsIa9cWrqqplz3NZlWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k+Zfgz91VX2q3gHte1I6HFS/yKLMJZd7pTTA36WSBA5TmOPq5nQY6GT2iYSemXMs0
	 t6J5eVsZWQZpEOY5/HSbLN/cpDt9lT4m8B+eUMvj7MZzLrtdvxd6C3qXfckPxxudTU
	 DKrF38rwmclnRD0M4OH837nNFGQXizXDQ2dzxa0LyjqGL7MHu8RvNzHVKnmMYN0tvE
	 LMZQ3kZ5qAcE7yDWIjSW+Q+LSYI0B2SEu6P72q7GD0Leuch8KqnLHJBcJUhIL8xMYN
	 DJO9vFGGI8Ma8//Xh7fT2Lo3Hdq1C7eKVUjvm7GSm3PioZudBdh+CMFhX74Ispnm5j
	 cyXQ0Vm4Bh5qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 17:14:03 +0200
Subject: [PATCH net-next 1/4] mptcp: pm: send ACK on non-stale subflows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-next-mptcp-misc-6-13-v1-1-1ef02746504a@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UGwRH+uD/CUajxibX4q7O5V5qsIa9cWrqqplz3NZlWU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFm/Sv9u0ka3ZTg3C8CUZaNIRQZ6Kvcx4QsLD+
 QdUPDeUyr6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxZv0gAKCRD2t4JPQmmg
 c3NjEACFHVmaaaxHbLMTLmnOA4RGieRwkOwDxMFhV41OPCiZb8UmEiEgjnSs9n64Z3dfe2VKzMX
 abk6v2Fe+sd38qpFiis4v5iBKCUDmtGZAGJN3wh+NyNWIQSi9Q6rXDHGw12kSOuWKiuIZov/Cur
 CyCNx2pVeuycquXq+M1koD4SWqh1wBY24VrwAzS0woJqcLx4/LMBzytFBRrw/PvnfIPpVv3RGRU
 jHYfkCtbJA0MAYs1CO0AdKxGneMPauI5VIk0thdY373Czx2z91e2IDZecMifu60fUg7kBh8qmZc
 9iYLjIgTCBL88gfmXx3976oHoYmA+FPfH0QjOofxeiZlugpkbM7R0AT6uGYEdOYWAh8aqRRdkzy
 hVu9eT9rlNTGy3l2OROxln714CD23WWLaKku8FleL0zsqnaqS2VtueerydXXKI7Jf2/0SChdeiF
 Vh/gpMiDjMa1t1UvvUQFoQjIbLCbrKGSZxhuxOYV5/a172hSqjTfpNYMDHZYtYUgITQtDvM+KkM
 hPY0N/xBspwLnnyUS3OV1FRJeEMDaI1SPMp2SoGnLMiTKUrD9riD9sm9zaVZz1cVsvy9yA97HR8
 CJO3wEoCXZz8kbIx0ezsFjdNfoSDrp/UlmC+W1teQXmSNoo1heaPVYUpFFygZ2KblM694RnXpnf
 fQq7mykZufeFuCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If the subflow is considered as "staled", it is better to avoid it to
send an ACK carrying an ADD_ADDR or RM_ADDR. Another subflow, if any,
will then be selected.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index db586a5b3866f66a24431d7f2cab566f89102885..618289aac0ab7f558d55d8b2ebb00dc62fc72f88 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -781,7 +781,7 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *alt = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -792,10 +792,18 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (__mptcp_subflow_active(subflow)) {
-			mptcp_pm_send_ack(msk, subflow, false, false);
-			break;
+			if (!subflow->stale) {
+				mptcp_pm_send_ack(msk, subflow, false, false);
+				return;
+			}
+
+			if (!alt)
+				alt = subflow;
 		}
 	}
+
+	if (alt)
+		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,

-- 
2.45.2


