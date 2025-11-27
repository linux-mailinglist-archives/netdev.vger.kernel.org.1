Return-Path: <netdev+bounces-242306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE6C8EB0C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85BA4347FBD
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DE3321D6;
	Thu, 27 Nov 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iJDgv8WU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E63314B7
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252375; cv=none; b=r8aYOXw9wfaBb8nn4tPH6G1ADmRaK1RqJDE3aTEIg0b5yrSoi8yA1SxNB493Mq43ILTYoMAjv+TBJi+HyVVkg2ExLIGILPM5u9+OOcH2kt16R9Ur6RzT8G6wpwlD8dSNFt0KTfTKP8x8fqqniJ5YZ4I/7qyML0tw5zHAUuK3Roc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252375; c=relaxed/simple;
	bh=h081qGqzzC7DK4xDqRTYPoX5XA7w8Vm/7PJPVFqiAuI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AzEdESirOAh8N7hJR3tzkUIewcdLl8sr8rI195MHYQ6nO6xz/GybDirLgx/kJRr9N8QqBt5ZaFSlj3QW/kqG+zOwaTEn+Xvp219VptYyrujjmWM1ROrXADUwoeWD5qRrrZnJ1Olue2Xup7H5ahvRBDl/8xS9Kk8RLISDa+HS+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iJDgv8WU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 15445201D3;
	Thu, 27 Nov 2025 15:06:04 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_0x1kRzpSM4; Thu, 27 Nov 2025 15:06:03 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 488FA2019D;
	Thu, 27 Nov 2025 15:06:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 488FA2019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764252363;
	bh=Zl2RBUrfPj5Idn4efyrsPU2YQznzI68T4nulrJMtVqE=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=iJDgv8WUJ9+I+HSj1T54yOeLuMg05EIRvGfBfkrhQsdFJmuBUXMcg9DZkWLatmaRI
	 sPJWTEzVMuoMKLdkWOEVaRTVHjbaLdBRl5MgHjyok1TeOf8vIo0+QhFpYPRdvAgDSS
	 NfzfDSl+3JCjybiaBk67RzSLDFZxUvNoD9XsJu0yOwEdRaMnrVUtTp51Rz30uHzdBJ
	 ASfpSGTlJ1c+hyMlAKXk4uNWYBX1o9VP1HSeM9SqafpY9W+c78WWCojcNxCywnhLVr
	 LYHSV1JL+hSbiVing6KbL5kdmYs5ooPPyG5cQVWCTbP0tNM1w7xgSCAYdMdPqX0ru0
	 75ZLwCEw/pDTQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 27 Nov
 2025 15:06:02 +0100
Date: Thu, 27 Nov 2025 15:05:55 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH ipsec] xfrm: set ipv4 no_pmtu_disc flag only on output sa
 when direction is set
Message-ID: <17a716f13124491528d5ee4ff15019f785755d50.1764249526.git.antony.antony@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-02.secunet.de (10.32.0.172)

The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
it was being applied regardless of the SA direction when the sysctl
ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.

Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
is configured.

Reported-by: https://github.com/roth-m
Closes: https://github.com/strongswan/strongswan/issues/2946
Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
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


