Return-Path: <netdev+bounces-122352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF90960C62
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8452D1C2246F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72041C4634;
	Tue, 27 Aug 2024 13:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF51C4611
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766039; cv=none; b=bXaVekqIZT8NJxFGkM4wlvcNpkStDRu1KEmi4cxbPMFbb3iH7xJjJGPDl5nhYXm+JAPUW/WgHnHTKG4ClGbJREjYyEQ3VSkAZwayFJik7KhWNjpfN0P4IkjS4HVJO2YcMTVSKN1qlVZxHcq5vn+yDnTL007+mb1Kz786h846exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766039; c=relaxed/simple;
	bh=/bAXKX4AsAJRE1p6xO5cnJVzY22yN2k8inv+yNYOaio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTu13xQ9IoOln7z/bIy24Mf0NB1XXrsSGIJolId9/tZPYAYKQ++SGgmgYNzetMdr4S0IBurAMbjSLyCKWqz+R1PM/4GvFkNbn4k2r8j4ZYZcOMErQBOYnG0YMWyfBtj18c7aCmil0+MPh97T40GJVVg67Z0pKr3l+VVjrR5P69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1siwQx-00038e-Jl; Tue, 27 Aug 2024 15:40:31 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next] xfrm: policy: use recently added helper in more places
Date: Tue, 27 Aug 2024 15:37:32 +0200
Message-ID: <20240827133736.19187-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logical change intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b79ac453ea37..94859b2182ec 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1276,11 +1276,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		struct xfrm_pol_inexact_bin *bin;
 		u8 dbits, sbits;
 
-		if (policy->walk.dead)
-			continue;
-
-		dir = xfrm_policy_id2dir(policy->index);
-		if (dir >= XFRM_POLICY_MAX)
+		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
 
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
@@ -1331,13 +1327,8 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 
 	/* re-insert all policies by order of creation */
 	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
-		if (policy->walk.dead)
-			continue;
-		dir = xfrm_policy_id2dir(policy->index);
-		if (dir >= XFRM_POLICY_MAX) {
-			/* skip socket policies */
+		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
-		}
 
 		hlist_del_rcu(&policy->bydst);
 
-- 
2.44.2


