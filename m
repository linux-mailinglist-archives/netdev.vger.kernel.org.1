Return-Path: <netdev+bounces-212010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54843B1D245
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DDA5626CE
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EA18FDBE;
	Thu,  7 Aug 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Uq7Lr5Qx"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECE23DE
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546655; cv=none; b=dgZsdN33FEtVfk87oSR04rGcxjFmx3A4i5E7cEOfyxnZ5f7co1aL9yLahcTTckESpwDtFpIYKjEnw6pGUN8dg24cJtEm1LIPM6hWfwqcX6qrgkueDCefO2qIJoIKonVyPG6IhO90TMLQoWKoHwnQDGEndUbFEdbTWMR/sLyYQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546655; c=relaxed/simple;
	bh=B8kiJasimrUmxscYgRIyCG+/HkqpoYjim0+O2SqlafU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUl3SvYXLTeGoFLszlweSlar4622RzBAP3zaN+NQjIFRh18r8PiI93INUaHV8JlWjsySbvf9m1gpJtz/ZF0FMZqDMK0gUuXEkv1gzLRTL/kh97ST67Iwau2LrmJamect6JnQRdOQFg0TKhk34w2G7ey0vV2shRrxXcSMRlx0Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Uq7Lr5Qx; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D7DDC2087C;
	Thu,  7 Aug 2025 08:04:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mq4rwd_QFXQk; Thu,  7 Aug 2025 08:04:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F2DB62083E;
	Thu,  7 Aug 2025 08:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F2DB62083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754546643;
	bh=KbnCBawYixmdjUZ7YuT1MDbmpTybFu6XKrvKDoG/1y4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Uq7Lr5QxilbYWQF+U/8twt7r/Gkywuu2M8wsq5uASVW0PRND7BpA4GGTM7J3Yrh4/
	 XAR5euvdTWv89G7xA30wSWL0XlwR8ugtSB+MBEIdL6IYb6YFLjfCz9k+U8y1Y7mmfD
	 FgPILGPjsj4fYUjamo1hDLrLbbsxqjLT2YJxkjFeVC22AV5onnRmxF9rXaOpIYiEWa
	 voHgb4hAgzGWpZdh93iQy6Nd6Y6+O/L/mFdqRIGhUvmmVznTT6kycjq3C9PKP1mufD
	 xZKloDzwloszIiXvrObU+UeRx3SJfOwZ02OIvZgrqrtkvx82nRmOoM73fN+E9+dLNm
	 OmVWsSR2BGVKg==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 7 Aug
 2025 08:04:02 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 604353183E3E; Thu,  7 Aug 2025 08:04:02 +0200 (CEST)
Date: Thu, 7 Aug 2025 08:04:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Cong Wang <xiyou.wangcong@gmail.com>,
	<syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
Subject: Re: [PATCH ipsec] xfrm: flush all states in xfrm_state_fini
Message-ID: <aJRB0q1ouPGR_ll_@gauss3.secunet.de>
References: <beb8eb1b675f18281f67665f6181350f33be519f.1753820150.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <beb8eb1b675f18281f67665f6181350f33be519f.1753820150.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Mon, Aug 04, 2025 at 11:05:43AM +0200, Sabrina Dubroca wrote:
> While reverting commit f75a2804da39 ("xfrm: destroy xfrm_state
> synchronously on net exit path"), I incorrectly changed
> xfrm_state_flush's "proto" argument back to IPSEC_PROTO_ANY. This
> reverts some of the changes in commit dbb2483b2a46 ("xfrm: clean up
> xfrm protocol checks"), and leads to some states not being removed
> when we exit the netns.
> 
> Pass 0 instead of IPSEC_PROTO_ANY from both xfrm_state_fini
> xfrm6_tunnel_net_exit, so that xfrm_state_flush deletes all states.
> 
> Fixes: 2a198bbec691 ("Revert "xfrm: destroy xfrm_state synchronously on net exit path"")
> Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
> Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!

