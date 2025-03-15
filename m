Return-Path: <netdev+bounces-175024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06168A627A9
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391853B82AD
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1119F127;
	Sat, 15 Mar 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vvDqCSO+"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA418893C
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742021641; cv=none; b=TfN4ktLb8aKvTF68hauRrPx2F8TEGNwVUst5UfGZpOWtCZ4sgI92iuIxYlBBY5aQkmBQaxxEF0xNR1pt52r6Ae2WXNfgZ4rG05w6u5uMmVoCwKovmcP4MiVaRHqhh6GDq09ZvHyU0yvwRQwHiA6BWY7ifMckCYkvWmJjBjfXMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742021641; c=relaxed/simple;
	bh=6U9X1JM3pG57RkKJppSrAPQc9JIp2SGUb7H50/WKzEc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVL8AG3MJDft7YD71YMV38xPgEWezk8nlLV8ZC1XViB1SSMMlp1lzWdYQcHvX+03J5FEGei5E1XkppSkYL1aqiKHGdxWcD+Fj0Ip1NztHp7sx0EFx5Kk6ch3TcIidEESz2XBRvRrQhP5JCBa90pLr0nDNDszh5linI34JMhn+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vvDqCSO+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 884892074F;
	Sat, 15 Mar 2025 07:53:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLEC7EquL543; Sat, 15 Mar 2025 07:53:56 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 02AD82074B;
	Sat, 15 Mar 2025 07:53:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 02AD82074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742021636;
	bh=VBAIWlmiGTtmw6QeWmg2C8FvuMa6MzynWRVRUv/E6ow=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vvDqCSO+S54+fxLd176tPsR3pHO7QP0u8MROgz/bQTjVT5937VtzJ1FrY3O0F/QTP
	 G7KALHUVeilRDuEzhQNXjss83xoOuGvgSH55Y+7aDo3eybJnNGq+fYBSG+NPFQWgCi
	 tQ/XlUUkbEPXeEeGaCBImMaT9EewWceUzzGWPZENPZjvzphSEQXsbO3VY4jkVFQeVC
	 dkwJ3RqhwehYKaPtMi46ztJx5ZPG+iRkIOtD4gEJdM1VBQeVv1gwc633smu2ysSLJG
	 HHKEoGSfWyb6ngUWD26vSiIM43R39GfRlh8lXtUMSg6Lktex6OHoZZWkNpDBv5uNs8
	 KETzIsuTGFhWQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Mar 2025 07:53:55 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 07:53:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3D3003182EDE; Sat, 15 Mar 2025 07:53:55 +0100 (CET)
Date: Sat, 15 Mar 2025 07:53:55 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
Message-ID: <Z9UkA99pbktct7qd@gauss3.secunet.de>
References: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
 <Z9T3V/M0hXIiHsLB@gauss3.secunet.de>
 <Z9UUxb2dclH9hrWo@gondor.apana.org.au>
 <Z9UZU6EGEF81OAYj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9UZU6EGEF81OAYj@gondor.apana.org.au>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, Mar 15, 2025 at 02:08:19PM +0800, Herbert Xu wrote:
> On Sat, Mar 15, 2025 at 01:48:53PM +0800, Herbert Xu wrote:
> >
> > Sure I can add it.  Do you mind if I push this through the crypto
> > tree so I can base the acomp work on top of it?
> > 
> > I'll push this fix to Linus right away if you're OK with it.
> 
> Actually there is no need to push this right away because
> xfrm_parse_spi has already done a check on the header length
> so this should have no effect.
> 
> But if you're OK with this change and the xfrm_ipcomp/acomp change
> I'd still like to push it through cryptodev.

Sure, go ahead.

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

