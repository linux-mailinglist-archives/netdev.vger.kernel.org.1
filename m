Return-Path: <netdev+bounces-145743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619C9D0994
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62C3B213B1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110114D2BB;
	Mon, 18 Nov 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XkKSRr8f"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2E14D2BD
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911048; cv=none; b=vCQjb5oGsb0P64ojrApwgOT2rBmA6hnF/POrREyPu4GREinsHE61uam+N+NJ6XKj3BNPO7cTiGJgqkvj1bxUW1N7r91vLAZIoen64epXTDAjTgAdWEFok7hJU14lkc/e7FgdecW2ikDZ67kAAYrn5zLhqtN0ssUDw5W9GdF4P2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911048; c=relaxed/simple;
	bh=3PMtOOF+GJ3jRtl3ppR8lLq+pToQ1JP2DAuh5zKDzks=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv+R0D/xrBbvJMs49vLMERz8UekEmrgqRPlMuc83es/THlrgRehIE8W8YhAaumPlaJyaFZhujKsGrNjwM+C0Lb+Nn4kl33R+IlZkuWMwtCeYgkPXbWaDOJM9l/WZQCFl3dc88QT1fJdJ7QL0QHw4ikY9+75//Ccv7di+ruRhpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XkKSRr8f; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CCF02206F0;
	Mon, 18 Nov 2024 07:23:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESMnyRMAq3my; Mon, 18 Nov 2024 07:23:56 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7EBA0201A0;
	Mon, 18 Nov 2024 07:23:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7EBA0201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731911036;
	bh=a/yc6Sn3zg/5B2NsrMe3Hxl2pC8u/fCGs1esoP203io=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XkKSRr8fzCBOr8bqiv/7DF17byZr9kndNEYhBI5I39ZA3p7IrOC5o/5A4NSVuH6wG
	 qoOSe7Tycs/mjR8XJ6y22XdRhtpGAmAOy0iXtajYr3ILADx20aaVXECq9n3E0zcVNC
	 nt1VzjmHbE2ZwnXeHlVA5kjjxcWxnVHXwI52rjNspvUv7aAXuIz06LTRaNSMIpdC+z
	 Q+OUi7llp4BKrAzLrr+EP0EJekyt9QygSCxuzdcIk/v4UAle1HSuanuTZ3TA8rCh7W
	 fMYXaco+CVcSAdXURYfyHcAea3fe3NUx8uJuRL9qn8McXTRdxkwuq6thKTII1UpDdL
	 lHxDOV2uU51MA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 07:23:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 07:23:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CB1C03183D20; Mon, 18 Nov 2024 07:23:55 +0100 (CET)
Date: Mon, 18 Nov 2024 07:23:55 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 01/11] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <Zzrde4aJcmzjDnqI@gauss3.secunet.de>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
 <20241115083343.2340827-2-steffen.klassert@secunet.com>
 <20241115180908.1d2c2108@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115180908.1d2c2108@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Nov 15, 2024 at 06:09:08PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 09:33:33 +0100 Steffen Klassert wrote:
> > +	/* We need the cpu id just as a lookup key,
> > +	 * we don't require it to be stable.
> > +	 */
> > +	pcpu_id = get_cpu();
> > +	put_cpu();
> 
> Why not smp_processor_id() ?

This might be executed in preemptable code sections,
smp_processor_id() will throw a warning if that happens.
Maybe raw_smp_processor_id() can be used instead here,
but was not sure if that's the right thing.

> 
> > +	if (attrs[XFRMA_SA_PCPU]) {
> > +		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
> > +		if (x->pcpu_num >= num_possible_cpus())
> > +			goto error;
> > +	}
> 
> cpu ids can be sparse, shouldn't it be checking if the CPU is online ?

I thought about that. But then we must wait for an IKE negotiation
before we can use a fresh booted cpu. If we pre-negotiate a SA,
the cpu can be used right away. I depends a bit on the usecase what's
preferred here.

