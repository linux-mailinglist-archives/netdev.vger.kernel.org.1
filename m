Return-Path: <netdev+bounces-112603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0793A206
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C34B1F23841
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB3154C1E;
	Tue, 23 Jul 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="B0IIUvoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3A137C34
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742716; cv=none; b=h2QxHagMzKaYZF8wz/lhCz3EZ2rW5eunrN6NybRnyJREt9Nt/zwX6EDZ8Ra4UNfJutGp0M0rWp2E6wUmos28xAoh4w6/L9mHu16l4sKoukbquRQ5QTIeTiEyI7gLvFtu6Nvpw1UN2p8hkV1Sps4tN8LvxNZEQjQfI+14cxARV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742716; c=relaxed/simple;
	bh=/teDg3xyCnz1X6v7zDlAnMreFJkc7/PaTO2cjjE97lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7BFqyYgUYpAGrlbAWTdwROyJLZw7oOhaRokWyvIpr1otyhaOIkPDGfhUGbKTfe9jmO5l4cvZ9sWUmwA9tk9alCUd5Kykl3PhztgypbGDKDFcwN4Rhf/9EVMqcvJfnEhgmwSpulgNMosr83/KrGVTBweIqAkolJG1LvnRhLOq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=B0IIUvoh; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B00127DCF4;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=/teDg3xyCnz1X6v7zDlAnMreFJkc7/PaTO2cjjE97lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2013/15]=20l2tp:=20add=20idr=20consistency=20check=20in=20sessi
	 on_register|Date:=20Tue,=2023=20Jul=202024=2014:51:41=20+0100|Mess
	 age-Id:=20<1857469bef821f5ef31e2f7ef586d1e904b83037.1721733730.git
	 .jchapman@katalix.com>|In-Reply-To:=20<cover.1721733730.git.jchapm
	 an@katalix.com>|References:=20<cover.1721733730.git.jchapman@katal
	 ix.com>|MIME-Version:=201.0;
	b=B0IIUvohI3f2Wiom7THAbHA6UAy3CWczUMX7V7VFRSh0lnXWX9CpQswc82WI74kVa
	 NUfB5wyRFhoCquBhd9fo4DVzszEEsnYzeUKv8vU7DorpCsInzmnqjKhBrz82npjuBj
	 X7rHl0zFCRSfHjmDsrxWL6Gv2c1mpkB3M8eoUpT64ty3xawJPIxhwjCPJjEcZQddTw
	 NvuqR/bsshejrXLn37A3bJaFL9Y3o72a5I9lGjucOZVQsSdlPkPjIbrHZvWjh5eyzK
	 St10jj1Y4QGMMCzeLDkPnCG+oy09lLoXhZ5WdRsnFVos5kznmJfU8hHVc3xgbka+cG
	 UPMspsZ9y9Q9Q==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 13/15] l2tp: add idr consistency check in session_register
Date: Tue, 23 Jul 2024 14:51:41 +0100
Message-Id: <1857469bef821f5ef31e2f7ef586d1e904b83037.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_session_register uses an idr_alloc then idr_replace pattern to
insert sessions into the session IDR. To catch invalid locking, add a
WARN_ON_ONCE if the IDR entry is modified by another thread between
alloc and replace steps.

Also add comments to make expectations clear.
---
 net/l2tp/l2tp_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index cd9b157e8b4d..fd03c17dd20c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -474,6 +474,7 @@ int l2tp_session_register(struct l2tp_session *session,
 {
 	struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
 	struct l2tp_session *other_session = NULL;
+	void *old = NULL;
 	u32 session_key;
 	int err;
 
@@ -517,13 +518,19 @@ int l2tp_session_register(struct l2tp_session *session,
 	WRITE_ONCE(session->tunnel, tunnel);
 	list_add_rcu(&session->list, &tunnel->session_list);
 
+	/* this makes session available to lockless getters */
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		if (!other_session)
-			idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
+			old = idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
 	} else {
-		idr_replace(&pn->l2tp_v2_session_idr, session, session_key);
+		old = idr_replace(&pn->l2tp_v2_session_idr, session, session_key);
 	}
 
+	/* old should be NULL, unless something removed or modified
+	 * the IDR entry after our idr_alloc_32 above (which shouldn't
+	 * happen).
+	 */
+	WARN_ON_ONCE(old);
 out:
 	spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	spin_unlock_bh(&tunnel->list_lock);
-- 
2.34.1


