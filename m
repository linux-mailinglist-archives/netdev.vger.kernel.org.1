Return-Path: <netdev+bounces-168601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93926A3F94F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D94251C2
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06EC1EE03D;
	Fri, 21 Feb 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEQzXAJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29951DBB0C;
	Fri, 21 Feb 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152656; cv=none; b=COta3aZtvnLTCliwCIcN10C9dzD81brDpGQUiRR+zNUE2MwvVdAIsn0Uhoq/YJP4YBe52n3uHAiNzQECoqWV7EUIy2zj2qnMqvVhLUFfucdMaUrrTBHFmVpqlq0flJla7uoDyQuuwBFAePA3JuR2af2ZwsJN6WQTeOBQJj7naBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152656; c=relaxed/simple;
	bh=WRIm7ZdYRyuJpKCOtNt2nvnSMXYDI3Z1Wee6MrqYF0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+7+O2tNQ0lHZFQoQeofwxDcTgl4FklMg3CL2dKTn+Aie3uqI+f7pxxc3ZwolsLkFc5AyjRqI9VUUZ0hTzetDyLAnWOIpZ5D/JhUnPeqrO6ojglOozTkkMGwBLAgpx1YoV7ZAkE1wt8BQTqSpBcD4bcokwdSwPJF0QkDepEJDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEQzXAJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F64C4CEE7;
	Fri, 21 Feb 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152655;
	bh=WRIm7ZdYRyuJpKCOtNt2nvnSMXYDI3Z1Wee6MrqYF0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EEQzXAJHhk7cCXzRkz50h3t51uubPD/0rDmFBs+HyxKar2+yvP4gVpQ93HFmDbMdw
	 DK3RxImUp9fNIThhDiIvk2VBI2L8gbhB7TIeUmU8nU89wMiFu8zdTrSsE8fcYSRvtJ
	 HUr1/id23DM/9DtOj81nQcN3geuTkYthCDlcvQjZ8loDRTaxaibytXAZdbLG+3oSIK
	 2MggmmtX0U+Zo3iuZCeZHcUZvgeQk0mUUgPRMqlGzvRE+UN3PIutm0CB3eT6rr/wnP
	 1UQbayfbwkS1mJ77ebtu2z8LOkZ6pfgAaCB7N9vYSLDtU/q7GcxImFP2XBRHMOQCDO
	 F3nV9p/y4DKgQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:55 +0100
Subject: [PATCH net-next 02/10] mptcp: pm: change to fullmesh only for
 'subflow'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-2-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WRIm7ZdYRyuJpKCOtNt2nvnSMXYDI3Z1Wee6MrqYF0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HKwndhRWIuQ5BBb3a+1Q1jKXQrwjNkjXyP
 l69E4zvevuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 cyvlD/9Y75/3WDF/4Ui9RBepKf2V1AQ9TQZsiGHc6CnG1utnK089iozHuJ+k6WLX+f4F5zznJSH
 cocEoTZSSlmESf6pf06TIT5DponEPhsFl7ieHQarMWoi+OIyADFPh6c/SjZk0ef65iwyYnBrcga
 oRPCDqIDUi38semd7yKOvpJI0z54lDrJij5PfZqkG196YVqCN5OatYJFNDamz7Ulmuh60csSPDa
 x4MlisZyWfiw1fjPpxww7gXkmjx2+2LBBr0pdRSvi2VPlC7pimfBqxYRRiPgVI/nGe1MZOC7Q1u
 7gUb53xJL3BbiMl1r1uxL4hCR2G2yhsZMTlcF0UQdmMrPomSMnCTRLvs8emXPvwoyeErUVc183A
 RVnbv0iiP6vfuTvGTTJ0d7fmZEEb6UodZl+65rZUpGqpjEq7nB5vtzAVQ73wJjz8TrcwHVvnOIP
 LrUGbkRqNx2wOORml/qzsFtrqtfXxUYHDF3z2uw5/f1B6CvYjiEudJaHfwVG4AEi1/CqGekviSx
 aUfN2nJRX3krXXKyFJl7X4tUSpiWnZM5apyJiDC2KHwa6ClSAJtHCbm8omQ3MLY1Zr2DIs2A7nV
 jqw6RiwP7W8+Qn/F7Vp11Ol7oaF1kXmmbh/oU/+AWR6Ow70s7vkNKEZarIjKYsdHF4ltIvOkF4F
 QVUvNNTIe2EQRVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If an endpoint doesn't have the 'subflow' flag -- in fact, has no type,
so not 'subflow', 'signal', nor 'implicit' -- there are then no subflows
created from this local endpoint to at least the initial destination
address. In this case, no need to call mptcp_pm_nl_fullmesh() which is
there to recreate the subflows to reflect the new value of the fullmesh
attribute.

Similarly, there is then no need to iterate over all connections to do
nothing, if only the 'fullmesh' flag has been changed, and the endpoint
doesn't have the 'subflow' one. So stop early when dealing with this
specific case.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1..1a0695e087af02347678b9b6914d303554bcf1f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1923,11 +1923,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 }
 
 static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
-			       u8 bkup, u8 changed)
+			       u8 flags, u8 changed)
 {
+	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
+	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
+		return;
+
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
@@ -1937,7 +1942,8 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
 			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
-		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		/* Subflows will only be recreated if the SUBFLOW flag is set */
+		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
 
@@ -1959,7 +1965,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
-	u8 bkup = 0;
 
 	pernet = pm_nl_get_pernet(net);
 
@@ -1972,9 +1977,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 		}
 	}
 
-	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
 	spin_lock_bh(&pernet->lock);
 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
 			       __lookup_addr(pernet, &local->addr);
@@ -1996,7 +1998,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
 	return 0;
 }
 

-- 
2.47.1


