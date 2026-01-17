Return-Path: <netdev+bounces-250734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE46D390B3
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED223010CD1
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520E2E092D;
	Sat, 17 Jan 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="POmdBRPO"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3B2E0925;
	Sat, 17 Jan 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680009; cv=none; b=MugKBysp9VNSNgmXNWcmNmK33etjRzOz9t1ZlDrFQyvkGFKpASeyztAkJb886r54uVXdiM2585TQ9K+gxmEjkV2NgRD6l+6xjGvOgQLR28arna4xd+nmv9xC96457DX/ZXVmuwz9uFHOA/8P7pwzLM/IfFaA3yfdCWJEqoSBV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680009; c=relaxed/simple;
	bh=Tr4xu/PwhnYHf4/Lsag14Rbls96NnKkL3ksMbIp6iMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbxA4tGKMZNpaPhENTlp6M91S6seQL81Z4hc59JQyo3UpdhNuR9DDQt98ok/SVNfL6H7z4zYFmXG8MN83mcZ58hKAdCn4tdZuuloixASbDZROK6K5VrMVqSV6iWqJYaulkPaINf86o0Rj2O3weL3s/gtjWAjhfrMDN0Bih1vhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=POmdBRPO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8F1382085A;
	Sat, 17 Jan 2026 21:00:05 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MxEhrdZXHNpq; Sat, 17 Jan 2026 21:00:05 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1225220799;
	Sat, 17 Jan 2026 21:00:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1225220799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768680005;
	bh=M4Nla2joKWRdPpDutpkmM+vQsJhrlwnFprMz6Y88qKI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=POmdBRPO52zih3dBRi/93G+zII4Yj8wgo6/1xyLG5najcDNUabqrMxlOfqHX1xeBe
	 l5NhIo+ti5PHgtw4Ef+AmsiEWjB6CY6FYz8kwwaeImyK695VG3ag3WuCUwXijjf4/a
	 tsb/SawsLFIUS474z2hMesStdqGa4K5z0qZQ0pI20Avk2qa9Y1GED/XqBzz+ooZr00
	 JbIF/mm92rIMY1LpuIN9Olf5ugyhyFMa8MMYaGOnaTELW8/7ZbkuOmZfPinW9pNIBo
	 eZUpv8JYHLNrwlddjFrOq9Hw8Y9T6axbxEl213CcvnVDPEO9G3OLEMxyniRM5sYLkW
	 s+iNj6YTZW44g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 17 Jan
 2026 21:00:04 +0100
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
Date: Sat, 17 Jan 2026 20:59:50 +0100
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
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

-- v1->v2: remove extra saddr copy, previous line
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


