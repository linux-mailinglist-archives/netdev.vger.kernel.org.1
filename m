Return-Path: <netdev+bounces-123728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E59664C1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB911C2338B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8C1917E2;
	Fri, 30 Aug 2024 14:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C618FC81
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029949; cv=none; b=n4YZqVLopq2nQYUfo/LbPnuSo2JQ/eW5WXpgu8U7dhqcUX9aqmQtiQWqDBfZJ68FcrPZTwApTtiLT9k75HwDZUEUDZJ5KAIWxOCSYtzPYVJPou/6lz2PE+sGdwSlPK5WsItfQzR65grZi1aYC9DsRg5fkFun9K7NTGa1lzheJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029949; c=relaxed/simple;
	bh=pkjkhn/1q6PBTugNhuWV8pkcXNnmUgN6/+UAG7q8tps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO3cvPmbMuyX/SuhkrdtJiVcTcpcRPNAGUHnAittN7zYrMgL7xQo6Sj+NDbKoHLyL3b3oA928V9TcqCLUiYozH0Yr392dkJ+0pyupNYrjxax18fKC5NU4cqkg2xR6XJAv8xLz03NaIzzE2MeklBge/sCNdL5XkzxNwMvna/wbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sk35d-0008RN-0A; Fri, 30 Aug 2024 16:59:05 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	Florian Westphal <fw@strlen.de>,
	Julian Wiedmann <jwiedmann.dev@gmail.com>
Subject: [PATCH ipsec-next] xfrm: policy: fix null dereference
Date: Fri, 30 Aug 2024 16:39:10 +0200
Message-ID: <20240830143920.9478-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com>
References: <06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Julian Wiedmann says:
> +     if (!xfrm_pol_hold_rcu(ret))

Coverity spotted that ^^^ needs a s/ret/pol fix-up:

> CID 1599386:  Null pointer dereferences  (FORWARD_NULL)
> Passing null pointer "ret" to "xfrm_pol_hold_rcu", which dereferences it.

Ditch the bogus 'ret' variable.

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
Closes: https://lore.kernel.org/netdev/06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6336baa8a93c..31c14457fdaf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4429,7 +4429,7 @@ EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
 static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *sel,
 						    u8 dir, u8 type, struct net *net, u32 if_id)
 {
-	struct xfrm_policy *pol, *ret = NULL;
+	struct xfrm_policy *pol;
 	struct flowi fl;
 
 	memset(&fl, 0, sizeof(fl));
@@ -4465,7 +4465,7 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
 
-	if (!xfrm_pol_hold_rcu(ret))
+	if (!xfrm_pol_hold_rcu(pol))
 		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
-- 
2.44.2


