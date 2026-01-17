Return-Path: <netdev+bounces-250733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99ED390B0
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78FA3010A95
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A182D7DC8;
	Sat, 17 Jan 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XV95wywm"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039F1EB5C2;
	Sat, 17 Jan 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768679916; cv=none; b=hHhMVbiJcQwbe+A4xEyctqaD07EqmmPTzDZEFtmuLhuyAPiSECBrEYfHWDIUH4+9q8+AZMSUrvb0nB+/Ir6WTbioaP5FSDRXpeYApcoC+YOJJ5mHSV+04/sgw+ywXamRAF6iWeprJ8vE1Qad7BmRpXSDCwU8e+u4u6B6ZiSf7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768679916; c=relaxed/simple;
	bh=Tr4xu/PwhnYHf4/Lsag14Rbls96NnKkL3ksMbIp6iMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soKjuLWOGxT1DO5nuUrO/aRwwwYBWhknDQLBBWJIrgz2TzrYXGRKiNKz3R3DzRdnFPKr9nxcSH6Wvs97M+dDRFvwZ1XZ4267xlUH7UGI64eK60zhWCkQOY3waJxmaLIf2O/z7IuvOTLTqLWbtviOigkIW2F9C1FKNDQVJzgXkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XV95wywm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0DAA82085A;
	Sat, 17 Jan 2026 20:58:25 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dB4qMyJEu88H; Sat, 17 Jan 2026 20:58:24 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6DC0020799;
	Sat, 17 Jan 2026 20:58:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6DC0020799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768679904;
	bh=M4Nla2joKWRdPpDutpkmM+vQsJhrlwnFprMz6Y88qKI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XV95wywmK+jZLH+0p7pr6JL5lKGgdcF/e+FNX1auuVIRu6IjIunJ5zdIZW1NTe0P1
	 T5pTpP5FNH/DT20pGyW1uzld3wYjxWAWnjRGm8yscNqH+Y8yIpGQOI766HG5o+X+a2
	 DE1UhbEv8Vi59kttK0cbddAEOmZuT85vHBent7IsKsYNbrq4+U9C+U/nvCSDQuYqz0
	 BtwNSNnpTcBn5JuswZ2OT+TMcSPIWdiK3ntgClb+m2mh6chntnFx4CkEj038D2S1Ei
	 X14WDcz+t6HNNGlws5OfuYqRvFMcpp33iCdkjSqAW6CG6SfRnpxrTTQMMmt7jubc4F
	 LlnGYmABlYFBA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 17 Jan
 2026 20:58:23 +0100
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
Date: Sat, 17 Jan 2026 20:58:05 +0100
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


