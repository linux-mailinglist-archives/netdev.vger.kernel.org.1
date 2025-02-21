Return-Path: <netdev+bounces-168608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E88A3F951
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072D17A729A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC495213226;
	Fri, 21 Feb 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6gmFD7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034D212FAA;
	Fri, 21 Feb 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152672; cv=none; b=VTKcn4zg4ecx2RjJrOmZN+9Ah3yUsKDnl7ZQtwP23PVYv9e9TdCCHvF01vLk0F3HsMxcqLFEaqMxOo6kiTVQAMVsYwRWquO2VknRTWoH89d9M14OEkNTgziZf4FD1kd7iciWV1ndStj4+OqNHpQqeDw10bi45YGX7gqnY5TFOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152672; c=relaxed/simple;
	bh=UBj9dMClQZezqlXlgcKU8Jj3hHkFDTNQJxKvzRTchbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pK/I2WkMtU1xvrKUNGE4/7JcILg7U9mNmxAU/NUA1d8QTgtZdWtK0SklEJwtbi9X4T32f/xpfLR81+FtXnRVPz/YtPL/nxQT+xp2dO3RtRDlm1bY5lW+GZ/2d6/zDYLVSjvq1Zs5wV/MmoKnepVicdkB1GMS+Exky1Auq4gmmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6gmFD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B4AC4CEE8;
	Fri, 21 Feb 2025 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152672;
	bh=UBj9dMClQZezqlXlgcKU8Jj3hHkFDTNQJxKvzRTchbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YV6gmFD7vretqaw78yswnEb9rjuK4OXMUH2F53Agl+IfO29KYpicFXMeFeTiCS8ne
	 Ppjq7VSoPjTrJ/oJF++no5bInyezCCdLYm0fJiwIG5/C0nGyvi5fbSnk2l+E1LEX20
	 MmdFapfsdEr2cNotP/gDeruXKlHit3BGCLHIeW6Y3wLqr5Oj+NITRLBa3eTxHJng6N
	 l1FgjcBEDFVVpWMLO94/h56vnZNRd/J90joryzCytKtmQFHiHAQ15dXl2bP3MpZU5J
	 7F1nmXWKhV6Qih0EIty+q8XM7id+K9pF/vDFAks3VBBn7kisFZoSvFK/viT9v4i1bQ
	 wpW8jFRAgVDyg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:44:02 +0100
Subject: [PATCH net-next 09/10] mptcp: sched: reduce size for unused data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-9-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UBj9dMClQZezqlXlgcKU8Jj3hHkFDTNQJxKvzRTchbI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9H7gUWwrXzNME+yQpPk/ZT71mKfIC4orEDS
 3wfTgrNbjaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c6ecEADHWD0cgzY4TucaQaqmprk+akhhmisGItmfyJbczDy1GCzmPzM/mIvjHxdN8Qjp78Eddtn
 oHEExcgrjXEjY4ZwHhnbseYs49TYBPUrJfmBk2rJiPdT/V1Mgb8xpjegQFL67Jwgnrmn9FAQbIO
 vca3sJSQbEn7t/YXH9GqEkmUPX87Z+paZgDUG70ogj4P1ls3fYmP2WS+P98r7FC4C4XGgDP1xgr
 eyxbOYfK4mrvATBPvKzQmysFIIQP5/NzU3WnsNQ+J7egomgktwmdgdvDcWW84n1TEoMNtOlXJz5
 m5wwbxRiGDhGdRQCJ6PjhtDS0kHxfkUo7AHTIX1OeNaMgTqKliGHpFVQy5aDBB00YuWTClzC4IS
 qkuuHF1W2QOx3y3fiu/hqoxDPfJ5hx95riPER6LYdFip2xa2hj/aQqaFI8eq2poWddNBm5DHS5D
 R+0sp339CO3SIO2Glu3G1DSrW9tjpJbuVb5yOp2sLfDlD8xACYohZdQ9cYtzYnCxbfNLFbf6FNS
 Kt01jn8j137pmSp2hfLkXLhOxrxKLXPCQu2IrKBPeq+graIVRTFpDxtLweYCYg0M4oNBOLuDqr7
 kz6CIH1SllCgk8qif0iWXEFbeBge6dfB6myqWIXUM5lXdpsm82nGBb2AhnF6m6FC2yd8CTQzaIz
 bklZ1p4ZEwos09Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks for the previous commit ("mptcp: sched: split get_subflow
interface into two"), the mptcp_sched_data structure is now currently
unused.

This structure has been added to allow future extensions that are not
ready yet. At the end, this structure will not even be used at all when
mptcp_subflow bpf_iter will be supported [1].

Here is a first step to save 64 bytes on the stack for each scheduling
operation. The structure is not removed yet not to break the WIP work on
these extensions, but will be done when [1] will be ready and applied.

Link: https://lore.kernel.org/6645ad6e-8874-44c5-8730-854c30673218@linux.dev [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 94dc4b3ad82f6a462961ae5195b7eba2271d8275..c16c6fbd4ba2f89a2fffcfd6b1916098d7a18cbe 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -157,7 +157,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -178,14 +178,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, &data);
-	return msk->sched->get_send(msk, &data);
+		return mptcp_sched_default_get_send(msk, data);
+	return msk->sched->get_send(msk, data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -199,8 +199,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, &data);
+		return mptcp_sched_default_get_retrans(msk, data);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk, &data);
-	return msk->sched->get_send(msk, &data);
+		return msk->sched->get_retrans(msk, data);
+	return msk->sched->get_send(msk, data);
 }

-- 
2.47.1


