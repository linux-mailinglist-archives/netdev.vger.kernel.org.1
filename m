Return-Path: <netdev+bounces-110356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B223292C1B9
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23792B2E325
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E61B86E3;
	Tue,  9 Jul 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="WlPrZYO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D919DF6C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542546; cv=none; b=VBHgmu8n9ShYYhgDBzDqkHBhBkH4c/K5WV0e+KfohF7UK73VCq2G8PqAXihfoifGQESDObsg2h8fO5TWPOjUMICNK6mg1U/YVHAJ3OzIDJw6IioTSs6dSe+fxx4WXRTtTTxrPEF7Jx4zHZPE3Cc0nHqq8f0R4X7pdz+Pz+nbrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542546; c=relaxed/simple;
	bh=f9ZbAb8S1Fl0bPH5uk8Ocxo+yq1SESLYk+JXHGcB/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OxJm9L3sC+Lbc9h8mAE0pDLnf/zcOfx1tyeXKNLzYPvcYvdOD13NKWhcJdxGso/rn83RWUtGNNcGLIIxnyIQSeB19FGQUVR9Zd3Ya37STmhbqtcqqG85x74ofkauysom1dvwtydGwNbBZYdfwEuQOH9fFYkfRWjObkpGVrcaqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=WlPrZYO4; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:ef7:1002:b4dc:8fa2])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CC8417DA8A;
	Tue,  9 Jul 2024 17:28:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720542537; bh=f9ZbAb8S1Fl0bPH5uk8Ocxo+yq1SESLYk+JXHGcB/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09tpa
	 rkin@katalix.com,=0D=0A=09samuel.thibault@ens-lyon.org,=0D=0A=09ri
	 dge.kennedy@alliedtelesis.co.nz,=0D=0A=09thorsten.blum@toblux.com,
	 =0D=0A=09James=20Chapman=20<jchapman@katalix.com>|Subject:=20[PATC
	 H=20net-next]=20l2tp:=20fix=20l2tp_session_register=20with=20colli
	 ding=20l2tpv3=20IDs|Date:=20Tue,=20=209=20Jul=202024=2017:28:39=20
	 +0100|Message-Id:=20<20240709162839.2424276-1-jchapman@katalix.com
	 >|MIME-Version:=201.0;
	b=WlPrZYO4Joivb6L9Pv6Toi9/YnXAExPgu1LBV9p4B3uY+XegquLUKw7aFeVGOBIMS
	 pqd63LGmLx+Un/82Fg17xFN0/6wvLaaSpCRAhIkeXZ9OKAXADwuNPAYB/IhLpksLGe
	 CjgvcyL5YNexOWI7xtT76GhyZjbnU1AtnORGQEvgYhkb6NgJdJSs2AkOKLUR3E8+jk
	 csH2Upn+490kR7JUb/feqsY2id7Q+lUo5jfTsF90mB5ZlBHPpoxtA5zmSaKSpWGpc2
	 GyCAVFdMoERtmZK9nAiYv5FHyriNMzKqiegCgscxYuBE/LK95j+86pSPR4J0mzkT1S
	 TnDSKEll2mRuQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tparkin@katalix.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz,
	thorsten.blum@toblux.com,
	James Chapman <jchapman@katalix.com>
Subject: [PATCH net-next] l2tp: fix l2tp_session_register with colliding l2tpv3 IDs
Date: Tue,  9 Jul 2024 17:28:39 +0100
Message-Id: <20240709162839.2424276-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling colliding L2TPv3 session IDs, we use the existing
session IDR entry and link the new session on that using
session->coll_list. However, when using an existing IDR entry, we must
not do the idr_replace step.

Fixes: aa5e17e1f5ec ("l2tp: store l2tpv3 sessions in per-net IDR")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 29dfbd70c79c..1c1decce7f06 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -436,6 +436,7 @@ int l2tp_session_register(struct l2tp_session *session,
 			  struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
+	struct l2tp_session *other_session = NULL;
 	u32 session_key;
 	int err;
 
@@ -456,11 +457,10 @@ int l2tp_session_register(struct l2tp_session *session,
 		 * support existing userspace which depends on it.
 		 */
 		if (err == -ENOSPC && tunnel->encap == L2TP_ENCAPTYPE_UDP) {
-			struct l2tp_session *session2;
-
-			session2 = idr_find(&pn->l2tp_v3_session_idr,
-					    session_key);
-			err = l2tp_session_collision_add(pn, session, session2);
+			other_session = idr_find(&pn->l2tp_v3_session_idr,
+						 session_key);
+			err = l2tp_session_collision_add(pn, session,
+							 other_session);
 		}
 		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	} else {
@@ -484,10 +484,12 @@ int l2tp_session_register(struct l2tp_session *session,
 	spin_unlock_bh(&tunnel->list_lock);
 
 	spin_lock_bh(&pn->l2tp_session_idr_lock);
-	if (tunnel->version == L2TP_HDR_VER_3)
-		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
-	else
+	if (tunnel->version == L2TP_HDR_VER_3) {
+		if (!other_session)
+			idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
+	} else {
 		idr_replace(&pn->l2tp_v2_session_idr, session, session_key);
+	}
 	spin_unlock_bh(&pn->l2tp_session_idr_lock);
 
 	trace_register_session(session);
-- 
2.34.1


