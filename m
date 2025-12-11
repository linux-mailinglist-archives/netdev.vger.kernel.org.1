Return-Path: <netdev+bounces-244365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8ACB584D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA647300DA4F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12F303A37;
	Thu, 11 Dec 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AAaGw4Ec"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A57280338
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449041; cv=none; b=SclvTA2nVdXXPnCL/E1LAA3rYQcbtnumic1ve+uzz4mubLw9raImPAzS6VhQRhzkx09BAAFkzCd40t8NfZT9pXWVQ46NNXe/nw7jngZBz4Uj1pVYJZqVGrGYdGo4DMcq+4uLAuN8+r4BcwdltuM3nTCuXHV2dUWXiNYVSHLPa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449041; c=relaxed/simple;
	bh=sZ5HnBKpwrSdQIqEhKslNOP8c1zuBT6JGzOu7y1FBaQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NVdc05/b6pF67y6JLYTkzdJ/lx3i8RyyJvi7LkonAJvBsN9v6jKA57kdNEXJuHu/DLP0MMhwsQUgZkwFSQTqChaSFlOdGI7mEhqwtcslbOWay4B9Yum6FS+LByf9dnJDO22MylhjBqOC94Nb8S4O4YjvZte2cdvcTnffvbsdvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AAaGw4Ec; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5768B207D8;
	Thu, 11 Dec 2025 11:30:36 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kot1UtXZ-68E; Thu, 11 Dec 2025 11:30:35 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 46E9820820;
	Thu, 11 Dec 2025 11:30:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 46E9820820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1765449035;
	bh=Mw6FOEVAvbfH0lgDOtYoWasdv1ZQ+BageINplETwOAk=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=AAaGw4Ec8qTTwy44P9qEa0aHZmJN22PYX7g2DQ46c4nlATsohnrEdx+iIJsVkBfEf
	 AZU6bkCYqyYTjTjlWKF06WU+9Y+pRGhDDGavI9NZ0mhhPqe9p3AlbaOJxUs3Stc8fV
	 RadYTGXH5C1peks70mvOA59F93rv/fNonNsHaI0WGMTqQw82zA/0PAT+4G3FjZOJng
	 bYJV2ICKqELqex7ki3wuuiwL0jYQRUD6el2V4zOiuLjAUqriu9gABdaUfBQUYdx4Qw
	 3TryrPnvSZqPUrAfQ2UHlifk+2HoBP6/0Nz9fgxPAEpPn350ddvvN+fw7N6PfLK1DC
	 J/OA/pQdTR55A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 11:30:34 +0100
Date: Thu, 11 Dec 2025 11:30:27 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: [PATCH ipsec v2] xfrm: set ipv4 no_pmtu_disc flag only on output sa
 when direction is set
Message-ID: <8524e1c3229c868eb3313d238aff43992aaa41a5.1765448730.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
it was being applied regardless of the SA direction when the sysctl
ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.

Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
is configured.

Closes: https://github.com/strongswan/strongswan/issues/2946
Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1 -> v2 removed Unrecognized email address: Reported-by: 'https://github.com/roth-m'
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55c..98b362d51836 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3151,6 +3151,7 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	int err;

 	if (family == AF_INET &&
+	    (!x->dir || x->dir == XFRM_SA_DIR_OUT) &&
 	    READ_ONCE(xs_net(x)->ipv4.sysctl_ip_no_pmtu_disc))
 		x->props.flags |= XFRM_STATE_NOPMTUDISC;

--
2.39.5


