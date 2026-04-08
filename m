Return-Path: <netdev+bounces-276414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BCSJ2kn1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E399B3BA34E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04210302A06A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B628355F53;
	Wed,  8 Apr 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ksY4sCyC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED13890F3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642382; cv=none; b=Wdr2G2ctUmRi1wgmn3QsRMvnYCr3V+r9JONy6K9sXg9comEYGeSsZS8rbaTr5+SIjKjrkQSLeQI83oKxfPgVHpT6KgnoGrZtkptxSgOclbVUT8XDwJ3StE5APg5/Ak94pttZlM2hhpAlr2rDWSWp0q0q17wr7THkrniiSmnxs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642382; c=relaxed/simple;
	bh=BPBXlc/A9fjMDUfY8Fhrfikvdr9rdvfI1W+fIytJnOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVVjYxpq5PZz9BxwqXwfOT5T66ZLb+EsZgBpUFvH1oHHa0BR7KoMnB6coWc5wdwnSnjp+wJ0nykOvc/XMF1CgEH+OySbDWjVX2Cy+wmUUWso62vb1cHhmAr/xO6IALgGbaHOYg4AxuF4Se116CgmNIwmXHA7iYN6UB1ufoUPPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ksY4sCyC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5CD1A207D8;
	Wed,  8 Apr 2026 11:59:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F59rw9xaFh1w; Wed,  8 Apr 2026 11:59:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BD524207BE;
	Wed,  8 Apr 2026 11:59:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BD524207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775642372;
	bh=HiDHsX9JzLoSQoH1F1tQBqlZUJSghs3mxxhmvkHCMz4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ksY4sCyCSFO/EA55YiHO+ArM9Sn6fWtFRLAKzL8F1xhs1UylaS8068KMhilaNMGLQ
	 Wke3pe+Z5IMQd2jeqoxZXdkRCFYaYBtXpBjlRX29JWunqek+4Ygm4DMAT/pJ90JvZ2
	 A3hla9a+3e+uzeR7g+5+2lJR5hjcfdlgLnHNg5gOOk3IkKJQYnEg3LazFC2K2PauP0
	 d8fVEhqvdkzyecR18D1tyx17Fw+TsYwu6yqqfV//NI0LhUw7FmUIoS+2p8492zVkpo
	 Eg40hMsiFXqY0XentiJwYbazQJBBlLwt26OGE8dHP9wUD5tifayA9jm73nwNrV7ySY
	 p8W4u5nWK7l9g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:59:32 +0200
Received: (nullmailer pid 256986 invoked by uid 1000);
	Wed, 08 Apr 2026 09:59:28 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/8] xfrm: fix refcount leak in xfrm_migrate_policy_find
Date: Wed, 8 Apr 2026 11:59:01 +0200
Message-ID: <20260408095925.253681-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408095925.253681-1-steffen.klassert@secunet.com>
References: <20260408095925.253681-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:email,secunet.com:mid,linuxtesting.org:url,strlen.de:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E399B3BA34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kotlyarov Mihail <mihailkotlyarow@gmail.com>

syzkaller reported a memory leak in xfrm_policy_alloc:

  BUG: memory leak
  unreferenced object 0xffff888114d79000 (size 1024):
    comm "syz.1.17", pid 931
    ...
    xfrm_policy_alloc+0xb3/0x4b0 net/xfrm/xfrm_policy.c:432

The root cause is a double call to xfrm_pol_hold_rcu() in
xfrm_migrate_policy_find(). The lookup function already returns
a policy with held reference, making the second call redundant.

Remove the redundant xfrm_pol_hold_rcu() call to fix the refcount
imbalance and prevent the memory leak.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Signed-off-by: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 8f0188e763c7..a872af5610dc 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4528,9 +4528,6 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
-
-	if (!xfrm_pol_hold_rcu(pol))
-		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
 	return pol;
-- 
2.43.0


