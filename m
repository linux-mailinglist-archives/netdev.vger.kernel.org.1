Return-Path: <netdev+bounces-86919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143138A0C82
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455181C21589
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718E0145335;
	Thu, 11 Apr 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wCZwyxZR"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB71448E3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828180; cv=none; b=onlgXtdq3hZy/vN7CQdpvtNmPYG5vfpAvdsDRYZyLygBxyn3JmKrAzp0rxI3w+X0mRyTV45kXs5LXGnL25sJNGifuuB6dVdOnGjsDcKUKiSCec9VkKIPcDpy5dQbBUnfWPDI+v0RBb7pLr/9ueY8Mqxxre5EYNHXpfGhrHkM3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828180; c=relaxed/simple;
	bh=iQtB5VhgQG3EjVpEMdn8g6PtJavtpTMhPg8+Os0D+00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s413U98o7T9v1UXmOb6SCdBb8dQUy81ymeDB6iJdctuzBNMJ7VeBO6iODNrBcUrLGdi+RW/hK1F8jIRQ8nQdwevBkABOQOKUzJONwMOkdZIE6GgfeJsOedB0KrU7TDNWLc/8WoG8nxIvhqVqTpybDx8fiZyObQWgDbyFBQJNmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wCZwyxZR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D45B720842;
	Thu, 11 Apr 2024 11:36:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5MhneHLQ3H_n; Thu, 11 Apr 2024 11:36:16 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 471282083F;
	Thu, 11 Apr 2024 11:36:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 471282083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712828176;
	bh=YIA5vPP6njC1KI8i4Dlul8j3eQfc0SWPFfPirg8n6bE=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=wCZwyxZRS2gwW9r8CR3rJ+gwtRjiwrKP9W8fJonbilcbbbBsPj/rdWy0HqRBvhWaN
	 WonHzlT28PTSQ0Hwv5gk7P7Wva9RPRio5IkJ+vaGpYV4n1qesMPgPyAyBe07RKuYDy
	 /BdsOKaCWbuCweY4jMqqGe2W5JNdzt8QiuTjzNDJTC5QHuBUKKttgflVWbs/81K5qh
	 O9ifpA2pucJII6llbadMF1r50fylDyhwbi2UaqtaEgkft5C7+p1QfIaCycfGyiTzyV
	 KgqCvab/QGf8xPYyqlNjZdZHHblCGtRsVNTTU2puB4skfPiEXuQZjDUqo1c1NwV2VU
	 N0WWeS1twVVLw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3A51180004A;
	Thu, 11 Apr 2024 11:36:16 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:36:15 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 11:36:15 +0200
Date: Thu, 11 Apr 2024 11:36:13 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Nicolas Dichtel <nicolas.dichtel@6wind.com>, <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhevDSFg7WhB2Phn@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZheNx5AYKzmRjrys@gauss3.secunet.de>
 <39ed70fe-ee5d-4e9c-8fba-d3b2dd290cde@6wind.com>
 <ZhenlYZLnYD3A7jD@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhenlYZLnYD3A7jD@gauss3.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 11:04:21 +0200, Steffen Klassert wrote:
> On Thu, Apr 11, 2024 at 11:01:32AM +0200, Nicolas Dichtel wrote:
> > 
> > 
> > Le 11/04/2024 à 09:14, Steffen Klassert a écrit :
> > > On Wed, Apr 10, 2024 at 08:32:20AM +0200, Nicolas Dichtel wrote:
> > >> Le 09/04/2024 à 19:56, Antony Antony a écrit :
> > >>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > >>> xfrm_state, SA, enhancing usability by delineating the scope of values
> > >>> based on direction. An input SA will now exclusively encompass values
> > >>> pertinent to input, effectively segregating them from output-related
> > >>> values. This change aims to streamline the configuration process and
> > >>> improve the overall clarity of SA attributes.
> > >>>
> > >>> This feature sets the groundwork for future patches, including
> > >>> the upcoming IP-TFS patch.
> > >>>
> > >>> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > >>> ---
> > >>> v8->v9:
> > >>>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> > >>>
> > >>> v7->v8:
> > >>>  - add extra validation check on replay window and seq
> > >>>  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > >>>
> > >>> v6->v7:
> > >>>  - add replay-window check non-esn 0 and ESN 1.
> > >>>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> > >> Why? I still think that having an 'input' SA used in the output path is wrong
> > >> and confusing.
> > > 
> > > I don't think this can happen. This patch does not change the
> > > state lookups, so we should match the correct state as it was
> > > before that patch.
> > This is the point. The user can set whatever direction in the SA, there is no
> > check. He can set the dir to 'output' even if the SA is used in input.
> 
> Ah, yes indeed. That should be fixed, thanks for clarification!

I have v10 with two simple packet path checks and error counters as
Sabrina suggested. I imagine this would avoid inconsitancy Nicolas trying to
avoid.



