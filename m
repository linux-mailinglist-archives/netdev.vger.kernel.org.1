Return-Path: <netdev+bounces-172908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE11A5670B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45ECF1774D4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29707217736;
	Fri,  7 Mar 2025 11:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD1211A29
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348158; cv=none; b=WJLxlLSDtVhrRkKSf5vROeGbX63Sk6YNn6jD6AU5Anr+3iUj6Jx5ahwTwNXt3wbyw4+wgGfUIzJgvrvsRruPCYkcOZB0ePNjhr+yFHcQKW7BpR0lwweOVWk9sfUPMrnOAFHjv3PuRLzsE+DigEC5c/cT54WcRelQqO38Ki8nVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348158; c=relaxed/simple;
	bh=J++fNfHg1lpE82xy0Im7LSPsNCOY6e7w8fJT0ALlf98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKBNAKBiek7izCuQXIm4FkcgF/0gga+uAhxBszy9XUwLi3AYqxns5XMXX3c78vG5QTarFm9C2CV0zXmD7mJ1tNCyniEhl1MVRCvVumTPpCx222TuwI+ZiOLuG1m/TtQrqlISVWaV6xz1VbZI7D20ivS9LG9F19U9TjQ9oPzF7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1tqWCT-0007ef-Ua; Fri, 07 Mar 2025 12:49:09 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next] xfrm: state: make xfrm_state_lookup_byaddr lockless
Date: Fri,  7 Mar 2025 12:47:54 +0100
Message-ID: <20250307114802.9045-1-fw@strlen.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This appears to be an oversight back when the state lookup
was converted to RCU, I see no reason why we need to hold the
state lock here.

__xfrm_state_lookup_byaddr already uses xfrm_state_hold_rcu
helper to obtain a reference, so just replace the state
lock with rcu.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7b1028671144..07545944a536 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2313,12 +2313,12 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
-	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	rcu_read_lock();
 
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
 	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, daddr, saddr, proto, family);
-	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	rcu_read_unlock();
 	return x;
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
-- 
2.48.1


