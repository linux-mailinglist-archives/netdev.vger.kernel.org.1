Return-Path: <netdev+bounces-212421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8A3B20322
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831723AAF15
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51A2DEA7A;
	Mon, 11 Aug 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="q1SyQXJL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F52DCF58
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904031; cv=none; b=UU7h6pWb7XcB4cIrDKSPnsRwDzofyP2zEcRY7Uw2VaIz7j+G05ap3DFlAwMjz651owCUq/7+hsZ1BOojVC6H4NFW/AziotjpHYu54cTLSljQAvfnyWT7OmgfJSEDcg3WuXd8qQL0FwgNPwbvSieQ5OOSTFiMpmp2c0Kh78s2oDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904031; c=relaxed/simple;
	bh=ZiARH1DwdRHyCi1z6pkR985MoDcEXhqFA6zGwQYhswQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcL2ZPDGMGhG+lGY8/rfFerTTimfV2b66aU79SANHBf//7yJYO1+gddI44MdlrO74c/XvQiGeiifB7PZXd7nmJGyWYxT2kAryGK5zLTwtDW/uAHOf6wOLdBjDtyfX3ZFvxkPumG2LJVOheKTY5zhYZJyWV/BMuwsYjM8xMOk/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=q1SyQXJL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3B8ED207AC;
	Mon, 11 Aug 2025 11:20:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bg91w0Q8K4ED; Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0B1DE207C1;
	Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0B1DE207C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754904021;
	bh=01RlwN7dSdvLbAosNDBm8qbffCN79It3QFRcNQemvXc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=q1SyQXJLIUyUEE/Q6suSf3eTfctI1H/Ul2iBOj4h7MoEaP+UpEYsl3Xuc8+4PUL7p
	 9/ELXff1lcCnR6oz5OEuNLfbwOtRcCHSTbqR0OonOOQBJUSuTufPyLwLOJv0b5iXkx
	 Gu8YpPvswUh1rq1lfV7Wbw1EpYZdCJmtCfcVblR/rNA2xDxrdC1dM+4NoLG7THSzh1
	 lQJuHiLJu/6VZmrTBm9vN+73dRZsAgnOlTZnVfTvFDz/Gdjp1Ll+UXR1lT3xc0bklg
	 xV8pH8CAj79ZDvsUh5fEY7EGDOcyvZ1jvWpMJiBTzwelxVhJDQv7J5oB9jVefhVz5c
	 ucEOsWAtWljwg==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 11 Aug
 2025 11:20:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id F32913180D88; Mon, 11 Aug 2025 11:20:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/4] xfrm: flush all states in xfrm_state_fini
Date: Mon, 11 Aug 2025 11:19:29 +0200
Message-ID: <20250811092008.731573-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811092008.731573-1-steffen.klassert@secunet.com>
References: <20250811092008.731573-1-steffen.klassert@secunet.com>
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

While reverting commit f75a2804da39 ("xfrm: destroy xfrm_state
synchronously on net exit path"), I incorrectly changed
xfrm_state_flush's "proto" argument back to IPSEC_PROTO_ANY. This
reverts some of the changes in commit dbb2483b2a46 ("xfrm: clean up
xfrm protocol checks"), and leads to some states not being removed
when we exit the netns.

Pass 0 instead of IPSEC_PROTO_ANY from both xfrm_state_fini
xfrm6_tunnel_net_exit, so that xfrm_state_flush deletes all states.

Fixes: 2a198bbec691 ("Revert "xfrm: destroy xfrm_state synchronously on net exit path"")
Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_tunnel.c | 2 +-
 net/xfrm/xfrm_state.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 5120a763da0d..0a0eeaed0591 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 77db3b5fe4ac..78fcbb89cf32 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3297,7 +3297,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
+	xfrm_state_flush(net, 0, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
-- 
2.43.0


