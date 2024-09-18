Return-Path: <netdev+bounces-128774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20297BA30
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC063281647
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E21304BA;
	Wed, 18 Sep 2024 09:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17334282E5
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652080; cv=none; b=N1KXlqXSvk+HJXvu1yU0Eo5hToz+VPRzdSItewTFZf6mNCURJbwuj3XMcayvKHBRc7RKbZQy2HcHcS1j4QgZjp7BIR4l5L2umubet6UpzkLyMgAHQCgObF/IuTSKw7J8o91OI1wiUJtoLwK9cq/24nIQrvMutPZJsKB41GQjkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652080; c=relaxed/simple;
	bh=N7BZRAMHDSaM860aWrDEqaAb2Mvx1oV0aXZJoRU75a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mo5q9lDGw/OF5jKJFZSEKy2ovrwY5zyshlIV0XirB1kxV8FBSF2TX/VSTm2cpedZ7uLjhpRdW7BCjsxDzldow4qj/NuLQqXSPFqDHxZXEDyuP+t+6t8FF7QuDbzrbcompFvevVJ0GZ1Bzu+E9uMj2dgel2APXEpSe0FU/DnZkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sqr50-00031F-4Z; Wed, 18 Sep 2024 11:34:34 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec] xfrm: policy: remove last remnants of pernet inexact list
Date: Wed, 18 Sep 2024 11:12:49 +0200
Message-ID: <20240918091251.21202-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_net still contained the no-longer-used inexact policy list heads,
remove them.

Fixes: a54ad727f745 ("xfrm: policy: remove remaining use of inexact list")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netns/xfrm.h | 1 -
 net/xfrm/xfrm_policy.c   | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index d489d9250bff..ae60d6664095 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -51,7 +51,6 @@ struct netns_xfrm {
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
 	unsigned int		idx_generator;
-	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
 	struct work_struct	policy_hash_work;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 428ee83fe298..d555ea401234 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4179,7 +4179,6 @@ static int __net_init xfrm_policy_init(struct net *net)
 
 		net->xfrm.policy_count[dir] = 0;
 		net->xfrm.policy_count[XFRM_POLICY_MAX + dir] = 0;
-		INIT_HLIST_HEAD(&net->xfrm.policy_inexact[dir]);
 
 		htab = &net->xfrm.policy_bydst[dir];
 		htab->table = xfrm_hash_alloc(sz);
@@ -4233,8 +4232,6 @@ static void xfrm_policy_fini(struct net *net)
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
 		struct xfrm_policy_hash *htab;
 
-		WARN_ON(!hlist_empty(&net->xfrm.policy_inexact[dir]));
-
 		htab = &net->xfrm.policy_bydst[dir];
 		sz = (htab->hmask + 1) * sizeof(struct hlist_head);
 		WARN_ON(!hlist_empty(htab->table));
-- 
2.44.2


