Return-Path: <netdev+bounces-209240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0DB0EC90
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D81AA18A1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02BC279782;
	Wed, 23 Jul 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Quyk2TH3"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811A277CBC
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257645; cv=none; b=foNBGc2KVvpV+MKCsZHk+i4uqoGLjha+c7O5x/yHzK/LknvWpp9zWSQK6wCoAyXgZasnjKOqDhG0wK/D6GHh0ft8YdST4Rpr1KWu/QW1FGTJ0xhwKNSH66rwB7C86+9XqjBWPlGkqY6UmTNBLAwNg1OJVlUfH2JRxp5NKBo05zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257645; c=relaxed/simple;
	bh=tgX4azDne0T6HFiw9T4A7dqSWiGPeloRXFGOWr17WIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEs2BssWynFp65YkL4Yk1EXaA125DR3C++8bgiDn1DBV6FbXSQkSHfB5lJH6FQBcFaUSSS2b3rdXlR7VuhC1NCHK5p6rtaneE9IM8XVP/rd+ygu9TV1v2t3CJLLtEfG9SIrl7zQz8l5RzXSZUIfCVGEmpFTyjXONXSy5dBB5dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Quyk2TH3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 939F8208A8;
	Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6A0iDO0_QQtN; Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 833552088E;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 833552088E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=CM7jFZ5LwcozS+L8GQNTWQAxvvl/GgFf8+UQDknJ/3E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Quyk2TH3PZgeH34hwdgCBxfFfMTTGmpgjN2XPkiZxr/yWJxYn5Fore8Bc7EfY1QM7
	 ZHRLd12mceM0Ka6FkzFvGJAh9p9zqUjb0OkC/WW0/NuWI5t4cHCgJDJ6Y1UhCqCcly
	 +rg87SLujqhi4e3vmNJA9GLyDW8dxZ2ZzLZxpncIiAKr6cfK6Ns/IX/Oh7FVV7pQg5
	 eQFvsfJC0nX6vOXOtqIwAeo5CV6f6myrtRltIsGkVWv3qhjZHDMuILqjDmnur7VA8Y
	 N4f55qjJjqNfTouptH2Wz/W/D2tF8oyHieBUsaBXZKAz09IlmfiCTAZP35zjFIxwhP
	 2vywVhhw9ccwQ==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 95E16318122E; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/8] xfrm: state: initialize state_ptrs earlier in xfrm_state_find
Date: Wed, 23 Jul 2025 09:53:53 +0200
Message-ID: <20250723075417.3432644-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

In case of preemption, xfrm_state_look_at will find a different
pcpu_id and look up states for that other CPU. If we matched a state
for CPU2 in the state_cache while the lookup started on CPU1, we will
jump to "found", but the "best" state that we got will be ignored and
we will enter the "acquire" block. This block uses state_ptrs, which
isn't initialized at this point.

Let's initialize state_ptrs just after taking rcu_read_lock. This will
also prevent a possible misuse in the future, if someone adjusts this
function.

Reported-by: syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com
Fixes: e952837f3ddb ("xfrm: state: fix out-of-bounds read during lookup")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 203b585c2ae2..2e2e95d2a06f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1389,6 +1389,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
 	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
 		if (x->props.family == encap_family &&
 		    x->props.reqid == tmpl->reqid &&
@@ -1429,8 +1431,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
 		WARN_ON(1);
 
-	xfrm_hash_ptrs_get(net, &state_ptrs);
-
 	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
 	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
-- 
2.43.0


