Return-Path: <netdev+bounces-132239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625D991135
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E101F21A75
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D5335D3;
	Fri,  4 Oct 2024 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bxEB6WVo";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qAtdZn4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVErRAXS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FA748D;
	Fri,  4 Oct 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076638; cv=none; b=aKA4oQkr3tzymTz4/Kd9pQ76fWAZ4t6nwRiiZcg2vUrcglaaDA0vvc/UpQ3X5J7Wl49RcHNAtvV9h49HC8TVcLdATTEZlC+k+Cxefpf7IyIaTXdNeAValyp74PMPjzsWyYTx7a5ognBXdgj6U/BuG2K9uVUBmSSa6/W5ZGMDqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076638; c=relaxed/simple;
	bh=RpoEDeqlxbuppRWdpLnZslav63s3dmblrVDw6McgZSc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iq9CiNGdWznNfpg6w4sq4K9CQYtUxefhQhAPA0+RoIiM2EBBbUhwfMoQkLOr1zusDw80KwNahmBdLkQICh8QPNmpDTH/a8In4o+B2bUThevM2UIdPQdgPGn8HXNqAvb8xhIGQqx1o3ugiUOa8PZEsOCEbbdy9csHHPGl/J+1Mg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=bxEB6WVo; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qAtdZn4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVErRAXS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5F021140186;
	Fri,  4 Oct 2024 17:17:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 04 Oct 2024 17:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=2016-12.pbsmtp; t=1728076634; x=1728163034;
	 bh=sJiGPvaGT9+liNHplnBnzyAkSDZcQrT4sSVBTwtxIFI=; b=bxEB6WVocmY+
	cBk85Al+a4K0vWknGE++XjdRFC8XVtJqkkdhcOAIJWPY0fJufFrbUyv2V7jNpB+r
	WJy2QWTuha26l35WQHloZLh1vMkwVnEyp63XJbNHhyEgw4o7UMEBffcZc2fo7MkT
	1WqXSmBPoNBMglUt1rPwWuWXXNzu09Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728076634; x=1728163034; bh=sJiGPvaGT9
	+liNHplnBnzyAkSDZcQrT4sSVBTwtxIFI=; b=qAtdZn4FgJWmrFhHhM3Y0xlNxK
	Fco0wPlnSR3rgxjzujCKG6gCtxU7S2EOBlH7TF6kMeGlMbK+3zOMHqVgoMyq5x1u
	E0ZFSjFWSUQfKKTTuVRDsCUK0azCC3WBf7qG55GCtc1Slh0vkYYNGWfWD2HemWSa
	i0/qwD6toTExIETQtDjyOnb82yUhY3RmlvO9JLOvuiRaNSeBzXca3/MK2Fnb9Cpj
	kRMqtieI7mAB0KA441wZrfcdgb4JE7YmKByPI1zBcCcol9iZjTpyAOi6CPsLuJXj
	NQZdrCupuu8bKYKhDZOx5UuH3IL/quUq46XukoG4XyZtFbTPRmfsvqwgk0FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728076634; x=1728163034; bh=sJiGPvaGT9+liNHplnBnzyAkSDZc
	QrT4sSVBTwtxIFI=; b=hVErRAXSm5dH1JzcgCEXAcuoZY37hg8ROnTM2jsWrXo1
	eGiD3n7ZFQjIkt4ZhcIj5epRMGH4IZ6GCRFaPYroEfWlwfqpkP0jw5ZyTivw6ovt
	pz74HFgIIDoaleVcXTU+vLWWcBvnkXHFbtb9+TikgRMDRCt3GZeEFohYKaWTiSo4
	RgMqMhLLr7kkMm2kepiTlR9UJ7JK0Ccp7DdjvWFK9fgeyrkw+SYTLE4GmtjzGLqV
	wIYd6VtsqS7ngfNwqeqkvERNqV/Wwcmj/gs1tSEnsvLiBhcBKHgC4qgICICH/F+3
	rHYfZlZVbm6DYmuO2CiIbWctNvSnLPO3VkHcIMcqGw==
X-ME-Sender: <xms:WlsAZzFmNpeEryzlppeqDGaz08uzAGB2Qg8BAdwrKiJnseUvxEcUKw>
    <xme:WlsAZwWlGz39C-CtULVtBGblnaqhxuZdGk_24ElKAvK5fvETsQWEMyxobYUrJskgA
    MEYlHMxLha-ZX9zyEA>
X-ME-Received: <xmr:WlsAZ1IZBEnokP48tbutmeNzEmC0zQic-pYQE1URCvPpMfgYIvlL5ODWfQXvObOm34j5eVOfy2DO2KqcXbxLEJ4y8nermqS6js--yhz8v1HWW3AdnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhepgfevvdfhfeeujeeggffgfefhleffieeiuddvheff
    udehudffkeekhfegfffhfeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoghgvrh
    hqsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepghhrhihgohhrihhirdhsthhrrghshhhkohesthhirdgtohhmpd
    hrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WlsAZxHg-X36rmzdpGlpADMfdJg0NCuYECu_LR4tVlGw1zJ2j5kESg>
    <xmx:WlsAZ5Vxo6xAkuxfOTzZYPfsobE7p9SBKepDwxVgj2SsAPEroYJ1EA>
    <xmx:WlsAZ8PW5cWrUUrVPC54UuEF6ky0x2iyvrAPesGxfnz6gGGl77rb6Q>
    <xmx:WlsAZ400MUqH322TMaAR_Uh5nxTUdCCxc1LFva4aMtov3CFtbwjthw>
    <xmx:WlsAZyOTTQTJvOqRx7kTglG9jVexxnXjLn0LBBbJiFiDIn1aHVmFiWDy>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 17:17:14 -0400 (EDT)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C4024E427B9;
	Fri,  4 Oct 2024 17:17:13 -0400 (EDT)
Date: Fri, 4 Oct 2024 17:17:13 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Roger Quadros <rogerq@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Grygorii Strashko <grygorii.strashko@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
In-Reply-To: <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
Message-ID: <6s1952p2-7rs5-06nn-19on-5170q4720852@syhkavp.arg>
References: <20241004041218.2809774-1-nico@fluxnic.net> <20241004041218.2809774-3-nico@fluxnic.net> <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org> <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg> <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Roger Quadros wrote:

> 
> 
> On 04/10/2024 18:37, Nicolas Pitre wrote:
> >>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> >>> index f6bc8a4dc6..e95457c988 100644
> >>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> >>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> >>> @@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
> >>>  		return 0;
> >>>  
> >>>  	/* alloc netdev */
> >>> -	port->ndev = devm_alloc_etherdev_mqs(common->dev,
> >>> -					     sizeof(struct am65_cpsw_ndev_priv),
> >>> -					     AM65_CPSW_MAX_QUEUES,
> >>> -					     AM65_CPSW_MAX_QUEUES);
> >>> +	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
> >>> +					AM65_CPSW_MAX_QUEUES,
> >>> +					AM65_CPSW_MAX_QUEUES);
> >>
> >> Can we solve this issue without doing this change as
> >> there are many error cases relying on devm managed freeing of netdev.
> > 
> > If you know of a way to do this differently I'm all ears.
> 
> I sent another approach already. please check.

Slowly being built.

> > About the many error cases needing the freeing of net devices, as far as 
> > I know they're all covered with this patch.
> 
> No they are not. you now have to explicitly call free_netdev() in error paths of am65_cpsw_nuss_init_port_ndev().

And it does. If am65_cpsw_nuss_init_ndevs() fails then it frees them 
all. Same as with am65_cpsw_nuss_phylink_cleanup().


Nicolas

