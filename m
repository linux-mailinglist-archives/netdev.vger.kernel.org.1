Return-Path: <netdev+bounces-113708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8493F9A7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A276E1F22678
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3F15EFA0;
	Mon, 29 Jul 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="KwaxuRlC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9915B99F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267500; cv=none; b=HPVQJOnL6htDQDasLTHWbIKAzXMJ5aXrNaQoW7IDDNsuXuHvylre4hXYfUejFPUFhVvGwWssdory7KuofeaIpuZn+iEoM6HH0AMCwzBlYC1ZlclgrW+5JfDuJzc5npFBJN34jtUOnGHkNcXozo/MAkJWQa2Y2z8TVDIFm+cZn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267500; c=relaxed/simple;
	bh=Lmf8AwTaDzZptf4cWriAsE/Jek3Uv0srHGOHsfMh4Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3i6A9yAtEuWqFMd99zt341jx1muxPLhuDmzmPxzJ/5XEYGx/T69tvUFNwXg8NS0jh1Qd0tVBexXTdxAfQIRaXfHiBVxvhbhNF1/Y3xqxQUvoiLH/D8iIZraph74mb8TLo+4S/uxiByyV7O7agfuPoXwekxWJGDkxX/3pfQK4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=KwaxuRlC; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 981107DCFD;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=Lmf8AwTaDzZptf4cWriAsE/Jek3Uv0srHGOHsfMh4Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2013/15]=20l2tp:=20add=20idr=20consistency=20check=20in=20
	 session_register|Date:=20Mon,=2029=20Jul=202024=2016:38:12=20+0100
	 |Message-Id:=20<e60ca30c258c4909c219105fe5c6c30fbffcd51f.172226521
	 2.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.git.j
	 chapman@katalix.com>|References:=20<cover.1722265212.git.jchapman@
	 katalix.com>|MIME-Version:=201.0;
	b=KwaxuRlCnUGcFroEtjrYd83Z2UHjaiplSRS67GCY9KH2gNp8/I/whuLI+P67S8URV
	 bGOrAHBUfarvbij8a/xDtva2mhVyLLiMRlGW/TGTHPeKO2o0i9NX4LJIzXxxkOkKfR
	 /RRivC/6C1xKUyzkCCqF9Z9F7TIF3HPmECICaWU+Fr7qG2MBACaYak3BwZ1Y0McJN9
	 mjW4ROIhdsMciUZwn7NOsbI//MgVH15/F+v18up3I+0MkyW5GBes85Kek3waPVk3z2
	 YCpXhlWQP6WCpIZRuHzxqbXkDXvi6HDgHUj8IUeTksC85YMuvjkYcoj1Q0HIamuLiN
	 HvZo8wZxdHf6g==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 13/15] l2tp: add idr consistency check in session_register
Date: Mon, 29 Jul 2024 16:38:12 +0100
Message-Id: <e60ca30c258c4909c219105fe5c6c30fbffcd51f.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
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

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
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


