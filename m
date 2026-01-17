Return-Path: <netdev+bounces-250737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7263D390BE
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 21:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3A2301A185
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA72DB7B4;
	Sat, 17 Jan 2026 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EmufzurN"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEF2417F0;
	Sat, 17 Jan 2026 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680397; cv=none; b=ettyx3oMLADFddrIwP8K7J8kCKqnPNM38nUe0w5RYDtdCeWD7b1ts6iE6afkfrtNnbSBLQbgTdiNbMlkmayiyoHq3uwP+k28R98Zv+5//JuqYQ693JbvtpRexG6hfOXpId/cnRXsNEGuRsMrGDwcW49r5Ugp+d1jlDFdJuWnG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680397; c=relaxed/simple;
	bh=McBfmnnEkA+VZYmqzhNi4kRUbW9eYfFWPDIlaRVdc2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjwBKpkbckaO2NHt6xpD9XjQaLaGPa98zs0t9g2fT2Y6p2hwWK2DPnqKPLcJlnUk5R+zIaqux57pEiWxOSYvLFfzelT8a33u/WwGiYmBAukQhNIAfeJI2eA6c13j2z1/HDdXwN+cwj5yVZu1MWz2KE0DWLpPjBHs3ps3U2+1Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EmufzurN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AFA612085A;
	Sat, 17 Jan 2026 21:06:33 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPi8zy-_4fBp; Sat, 17 Jan 2026 21:06:33 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2E8D620799;
	Sat, 17 Jan 2026 21:06:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2E8D620799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768680393;
	bh=5BQ439mslfuweEeq26rQ7YLVOhzXbgR+eNZ0ziniS8Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EmufzurNFjkAHqbqpgCNMtgzeJhidyh4JRG04yHMthLyrgwGs1AiYXzqoZZVhiTC2
	 YVDT7y9DzT/F6X3NhwhkrGJPTZvDE3BhcLgJ+xgEF+Rrk257yi9DffGvieblH5hZjM
	 BGGbWNHFlvO9OYJ/OZMzXmZ8JQKQdSWuV76lZmmAXRg/3bgUPxYLX2n8tsnA9YUMjZ
	 OsGTYlmLNrRm860x66t161NCU+4etVKmqCDwYu8pHwxc+WbutToh35YRVSb5ytJWJ7
	 C4EGYAq4LixuE3mBaw7l7DFTLnJbnqFI78WQS4Cs8JDfCWaUpBp6cHFQDknOJV3TMa
	 Ry5+EwvpecCeg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 17 Jan
 2026 21:06:32 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v2 1/4] xfrm: remove redundant assignments
Date: Sat, 17 Jan 2026 21:06:19 +0100
Message-ID: <d9860ca1c930339e9c48763df2c853558c8916ec.1768679141.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768679141.git.antony.antony@secunet.com>
References: <cover.1768679141.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

This assignments are overwritten within the same function further down

commit e8961c50ee9cc ("xfrm: Refactor migration setup
during the cloning process")
x->props.family = m->new_family;

Which actually moved it in the
commit e03c3bba351f9 ("xfrm: Fix xfrm migrate issues
when address family changes")

And the initial
commit 80c9abaabf428 ("[XFRM]: Extension for dynamic
update of endpoint address(es)")

added x->props.saddr = orig->props.saddr; and
memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1->v2: remove extra saddr copy, previous line
---
 net/xfrm/xfrm_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55c..4fd73a970a7a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1980,8 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
 	x->props.reqid = orig->props.reqid;
-	x->props.family = orig->props.family;
-	x->props.saddr = orig->props.saddr;

 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
--
2.39.5


