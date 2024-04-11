Return-Path: <netdev+bounces-86881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A928A0972
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37895B28D5C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3A13DDA4;
	Thu, 11 Apr 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="q3BesB8o"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A813DBA8
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819663; cv=none; b=o6sn1xoCjOeUedXPJofev1O8rYU8Sa0NyHw06CPbljZCjpzCZ67txpcvD0TKbsA+oWKrMQgkP41uJPRcFGW4TpMPrws49lTRUpJ7hZk9YKB8MhXQNjnqPI5kd5fmTH/ZG6pm4H1kzuiCxdTg9C12ooUkC7QxsUnOrYJHqJYzE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819663; c=relaxed/simple;
	bh=LsHPC97QW/B0iStaaGUp2aEJetTODwriC2cj6D3uRY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n52W0tBihnl3qxcv0DhbBEhOBUR3aCcSjkBZYZiH53F0c3qQMqXfZS/HH0PnOMA2mJQkwAseRr8jMuDBPeCGJdE5V1AokgxyaLY9tvvKjHHbtjSfGo/4x08oj9mz6Da0E/hS+juDBwMeqj1LRaCb8eDbVVbBF+bLyW6s/7WpHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=q3BesB8o; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0280A2074B;
	Thu, 11 Apr 2024 09:14:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zF4XSneOtCQS; Thu, 11 Apr 2024 09:14:16 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6FDE4201E2;
	Thu, 11 Apr 2024 09:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6FDE4201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712819656;
	bh=gaRGgnstmclF3khnXUDdp/ph8U6ZuX81dUPqPeFxIwQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=q3BesB8odY0ORhThAIi2ZfuphRlnd9KzOjcMtPQt1YMggRKWuJtoUaQm9xmxWqu/G
	 EZEyDl8neYfAPf51E2R6P/s+bqS/lgEOVdS0Tl13zsHDd1Jj6YXOJXrhKk6BSHOLwk
	 KMnnWYg//WQtv7KR7wTzWCxYjPkItEpw9OFKMD4bMqDQPXCT/SVlmzEzL1oGYVY2UW
	 PjYUE/u6y11gto9YOpeUXbxcn9RT46Lfm+qPOfAAAQl+/sQlTFIOr6z0MpcO1TBnPS
	 7aeWZnbUiqyD9XogNUP6Su14QN1YyMBd3pGA6Afv+tMTNcZrOulltWCq5Nzly8MCAX
	 AmYFODcEqDzKw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 62A7C80004A;
	Thu, 11 Apr 2024 09:14:16 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 09:14:16 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 09:14:15 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A949F3182A94; Thu, 11 Apr 2024 09:14:15 +0200 (CEST)
Date: Thu, 11 Apr 2024 09:14:15 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
CC: <antony.antony@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZheNx5AYKzmRjrys@gauss3.secunet.de>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Wed, Apr 10, 2024 at 08:32:20AM +0200, Nicolas Dichtel wrote:
> Le 09/04/2024 à 19:56, Antony Antony a écrit :
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > This feature sets the groundwork for future patches, including
> > the upcoming IP-TFS patch.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v8->v9:
> >  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> > 
> > v7->v8:
> >  - add extra validation check on replay window and seq
> >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > 
> > v6->v7:
> >  - add replay-window check non-esn 0 and ESN 1.
> >  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> Why? I still think that having an 'input' SA used in the output path is wrong
> and confusing.

I don't think this can happen. This patch does not change the
state lookups, so we should match the correct state as it was
before that patch.

On the long run, we should make the direction a lookup key.
That should have happened with the initial implemenatation
already, now ~25 years later we would have to maintain the
old input/output combined SADB and two new ones where input
and output states are separated. 


