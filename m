Return-Path: <netdev+bounces-172895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45AA56695
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367A11899F32
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10521ABBC;
	Fri,  7 Mar 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvzRmjq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAA21ABB5;
	Fri,  7 Mar 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346542; cv=none; b=NhoY5mC5pQYtRD56fKAsauAz/p4FFRCDeRQUcVTtEd0liM0Dib1YWGND7nmRjt8ICm3t3XcDoY13TZ7fAPURCkcgwHZI+O4Ho5qpjRsl1tucyDPsztJEmzmhCjIGEp0sv4yxshQn+ydCUui/SDveOg9Y3J8HZiBtLaiC+pcpuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346542; c=relaxed/simple;
	bh=/FHOKwn8GfJo1PvcqLmX8srRO550REK+qzPz5vzukf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlmi60qH1YRnBOOUY8TYPmmt6XFDPUD2biaPma2vyT08oaElmgvo6/cETLZaQppfej+n3RBq5/sFE34uWAGZY3jsEosULyYXeXQcgwCytBUYTjMsZyhTTPwQaUhNch8/VfjgZU9BRpib0v05x2jiuRM4cyc/USNtol1cFRDbD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvzRmjq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F3DC4CEE8;
	Fri,  7 Mar 2025 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346542;
	bh=/FHOKwn8GfJo1PvcqLmX8srRO550REK+qzPz5vzukf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kvzRmjq5+gBklCtWSGaDV/rvO2pAtyfi1eaAglxKyXdEt99lbkzrzgB87IcTBfxaH
	 dqMVKNibBZAw0zqbGqBsSuw4qjAvyisRp8FEzT/Io7Q+wd6AYLsSbivH680Akk2wUd
	 9J+oib6o4QSIP9ZWkalB4w39RX45fcqy6NKuaVvzfNBRm2LIZoYOhMsEUpYWqoB+St
	 fS9GO0OSw9dtCx0KbYis21tUWNJj8GoQrsV0sWvj9ovwSVV21ynKSAPEDzM2ZbFR+9
	 ys2ocGSJ13woEYeeciuh/tiwf5HTJkziA8g1WmovlJN5lFUkPsvY9jq4ZysE3Di6Nn
	 6H4HqTRDYXqvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:53 +0100
Subject: [PATCH net-next 09/15] mptcp: pm: avoid calling PM specific code
 from core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-9-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3938; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/FHOKwn8GfJo1PvcqLmX8srRO550REK+qzPz5vzukf8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbR6FOeJnK8O2yK28TmE5CnJwZECcpqf4lBJ
 Weexf7Abn+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 czd+EACYh8i1d7V2zr5Eh5+CwBK0X4Vz8VLI/1OeCLKY9H29HKOVtUFahDQDO5r6njMW2gu/MK2
 28wbnKLrFVvV4n87BgaBpBaJMVcO6sbBCHaVoFbjC292gXsXsqmC8BqBu5UzW5ah54yl8hxBLYM
 9fRFq557HqoUVTeSpzFI863EYEWkO+vo5K4Rf1oJY+guknDQAoveOuKGvN5RP/SMJ2GR+S7tCdD
 6YIAEAwNZpcnt6f8brFC6+Nj1JSZaoE8UfLnN+Q6Q8HmElhaYvoZRrXSZYvsCcm00TirEMpCQdd
 iwyIzsilATkLt5l1Tq3DtoHxFxLh2Q1c+pS+/tb5mPD+VCwpK5SN7IJjMbt+HEKsT4fiz7H0iBY
 aEyZ7OxqUWfs3UyruvUoYNysmtBIOya9ogTtX+6JS6aHObu+9XcNkvmDcUo2aKqcBnFfegAI0b4
 NV0HP3AdDC+PvxncR2gjMv0w+KoiDHE9bG/yImFnRe4G2/Ij8UfBZ+xLPYplvK6q4IjprkokV0K
 zglxrTFGhqnu2pFu0FZ68vqOkS79iIwzVrhH9R3pQ1LMBPX2ZpzShcfRFMp3jd5SCrDE+ZJIe8B
 phzsv5N21+sV/kmCEMc6JH1vpHbMGz0gX/XRyVxSJtHvuLA4rPbqlwXtzlM2nvhavlLsSA6pjUA
 4ZpMvbQhAt3bDlw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When destroying an MPTCP socket, some userspace PM specific code was
called from mptcp_destroy_common() in protocol.c. That feels wrong, and
it is the only case.

Instead, the core now calls mptcp_pm_destroy() from pm.c which is now in
charge of cleaning the announced addresses list, and ask the different
PMs to do extra cleaning if needed, e.g. the userspace PM, if used, will
clean the local addresses list.

While at it, the userspace PM specific helper has been prefixed with
'mptcp_userspace_pm_' like the other ones.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 8 ++++++++
 net/mptcp/pm_userspace.c | 5 +----
 net/mptcp/protocol.c     | 3 +--
 net/mptcp/protocol.h     | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ab443b9f9c5f28e34791fa75ce42ee013ed70d78..17f99924dfa0ee307cd10beea90465daf7c84aed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -599,6 +599,14 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 #endif
 }
 
+void mptcp_pm_destroy(struct mptcp_sock *msk)
+{
+	mptcp_pm_free_anno_list(msk);
+
+	if (mptcp_pm_is_userspace(msk))
+		mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2626b2b092d4ee901417fca89c0e2266398d54d2..13856df226736727783a27fc0932a0003aadd8ee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -12,15 +12,12 @@
 	list_for_each_entry(__entry,						\
 			    &((__msk)->pm.userspace_pm_local_addr_list), list)
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	if (!mptcp_pm_is_userspace(msk))
-		return;
-
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac946263ec64f2c0fc5e53dd50f14c721ee463a1..ad780ae1d30dcb6ff72960b340e1472a1400618a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3302,8 +3302,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	 * inet_sock_destruct() will dispose it
 	 */
 	mptcp_token_destroy(msk);
-	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_pm_destroy(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39bcad1def6bc97a3eca91f5c409b50c8fa2cd8e..0013b68a2731ed13cbbd817870c33f6f7f6d0b40 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -983,6 +983,7 @@ __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum su
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_data_reset(struct mptcp_sock *msk);
+void mptcp_pm_destroy(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
@@ -1042,7 +1043,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);

-- 
2.48.1


