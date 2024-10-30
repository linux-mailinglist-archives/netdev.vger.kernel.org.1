Return-Path: <netdev+bounces-140311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B09B5E64
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27700283EB8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F221D0E2C;
	Wed, 30 Oct 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="ahdBr7RJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0Pw9pib"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0E194A68
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278972; cv=none; b=KYGR4UnkpLiLQVSu0D49O79wk/6uqo4aFK6TR6vsPjhO3z6sEbxrXVwmDctgcl6EtQqu+7ptlpY4phY3oesr7Rb7kOyIKe3p+zBlldAxIChIR716eCZbJig43WXO/BaI5frdEEb8Eh104XKZYDr+8/K6vvuNntly0Y4tBk0UmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278972; c=relaxed/simple;
	bh=T3PEvjzf/e/K5/nZ8AM7VNOJSfJxgN0I0YAP5WAfOfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3FIcvHBHnHvbr3anUfAD+wAsKX7QOPVzOsKrDH24c6vch26tbT6eYOJ1FNJNFgfOUKLZRWJkVId21UErfdJ9Q34G6RtK3ap2SHAF6CUS+wtxpRRrNSicwVv3EY2vNVKuC5w4wchE+0DeOOy2iGciDUxFw1QRrivbH10P4aKYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mendozajonas.com; spf=pass smtp.mailfrom=mendozajonas.com; dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b=ahdBr7RJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0Pw9pib; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mendozajonas.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D5AF138018D;
	Wed, 30 Oct 2024 05:02:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Oct 2024 05:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	mendozajonas.com; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1730278968; x=1730365368; bh=ZLH+Ed+NvINahKlQCDEam
	vez+zFf/Nf/8UUcPFXyD28=; b=ahdBr7RJJ6k0x13h87lTa/n7UVdb4J/EUJVbA
	e7Um4izphKDCTrBSdCi+iMChE1ZC9d2tz1hVB2BYNx1e0ENxP+56mYIPVhBcFc4K
	7ktrWEElEVGK81kG6mx9B+7jlF+lYdifSjrJLxyCa6lnnq2rLjnrom4TU0qbKIso
	n3EFbHynegdWLTFsanr9YkrqglVPVkmLFwbSFkfdmMGPQmaAhFBUFmeDQ+ob7d1V
	+Dqsr5Z/L4p/t1EXOJp3xIPauv5vAfBJvEMMZuWK92gqdYekUkdBqT56uFANebP3
	2S/sOCZeAW4JB3aJReL57H31o+UEjpPJ6sR7Sppr71QMUO/rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730278968; x=
	1730365368; bh=ZLH+Ed+NvINahKlQCDEamvez+zFf/Nf/8UUcPFXyD28=; b=e
	0Pw9pibTs551x4Pq32l6e3cwbyWVgeqIuD0qBCsbUQU5j9fd7Fg4lX8uyxvOAf2z
	t1v7PV6FybEwTWhW8ojckTsEfdDpNG9M7vSTTq5sXOXQ+AzhEQvVmDqSxaMv+NeW
	tvoo3DTE1E4JWBqmvKNQIQdPMeGjHU4Q1E7rdWS8Ze4wjgHT9NO+HSfuQ4Nkj3hu
	tt9SNgRIEDPYr90010zHsQJLcI2ah6ynWdrAcS3kBCQmqPZmNQRdgww+4gGxSB5G
	FCE1I/OGQfrT1P+8zwNv1pJ8CsymaAWK+WihqiPYB1fhTjwtRPCg4B5H0PEeDyeR
	m/7hW/VQAZtkr6YvSJceA==
X-ME-Sender: <xms:NvYhZ7b1kjQzOqNw6HAriN1WxwyOXqlCVxxchhRByQzpA5uSQ5r7mw>
    <xme:NvYhZ6Y-EgvgNTMZYlFChj2snATAnLCXFLTsUSoD7kBZPcGTRMKWebbsKjyKEr1LT
    uzrHp2LJjVXE7Q2gQ>
X-ME-Received: <xmr:NvYhZ98odscWSA-qpRe0UptKQP9CjOKQWVDnqbiGedoOTtNPP3D8VOpcrN81nlhl1HcGQZ1pySgIgRVanTSuNntUCDB8xDx3rbVfS_bwiB50kNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepufgrmhcuofgvnhguohiirgdqlfhonhgrshcuoehsrghmsehmvghnug
    hoiigrjhhonhgrshdrtghomheqnecuggftrfgrthhtvghrnhepvdejffdttdeuieehvdeg
    vdekhfejtdettdevvedvveevvdelueetiedtledukeevnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhesmhgvnhguohiirghjohhnrghs
    rdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhksegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtg
    hhpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphht
    thhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtohepjh
    grtghkhigptghhohhusegrshhpvggvughtvggthhdrtghomh
X-ME-Proxy: <xmx:NvYhZxotf2rq9DetZy7Uv4m9Ia19XKPWgUdFkUHVPXFz60Rkllldkw>
    <xmx:NvYhZ2pU5_Zf_NKz2U1XbBfLVXQtUuOvP_QLidABelH0k0FAhhu9aA>
    <xmx:NvYhZ3TJ9DQpJ3-5yqCsn5j0JNeNiIZBTKGN3SqaCL7S68FvMV40lA>
    <xmx:NvYhZ-qPxTqe8Ctd_ySUPXCnLvC8T8dHzCJJG6l5hs2ATZUdh6L84A>
    <xmx:OPYhZzQh4GLwITAernUpw1XvcLUmvTXga6C5-FsLnrPyQlfV1LVA2Ycj>
Feedback-ID: iab794258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 05:02:43 -0400 (EDT)
Message-ID: <7e798de6-0476-4d1b-922b-51c335d6d0b1@mendozajonas.com>
Date: Wed, 30 Oct 2024 20:02:39 +1100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after free
 on unregister when using NCSI
To: Jeremy Kerr <jk@codeconstruct.com.au>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
 <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
 <20241029153619.1743f07e@kernel.org>
 <198a796d5855759ca8561590d848c52028378971.camel@codeconstruct.com.au>
 <040df8130f6dffc4c4e519dc9241e1c35ed819ca.camel@codeconstruct.com.au>
Content-Language: en-US
From: Sam Mendoza-Jonas <sam@mendozajonas.com>
In-Reply-To: <040df8130f6dffc4c4e519dc9241e1c35ed819ca.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/2024 1:58 PM, Jeremy Kerr wrote:
> Hi all,
>
> [+Sam, as ncsi maintainer]
>
>> So, this worth a try with the _remove sequence reordered with respect
>> to the ncsi device. I'll work on a replacement patch to see if that
>> can be done without other fallout, and will send a follow-up soon.
> OK, not so simple. ftgmac100_probe does a:
>    
>      ncsi_register_dev()
>        -> dev_add_pack()
>      register_netdev()
>
> - where ptype.dev is the ftgmac netdev.
>
> So we'd want to restructure the _remove to do:
>
>      unregister_netdev()
>      ncsi_unregister_dev()
>       -> dev_remove_pack()
>
> However, we (sensibly) can't do the unregister_netdev() with a
> packet-type handler still in place.
>
> Sam: would it make sense to move the dev_add_pack() / dev_remove_pack()
> to the ncsi layer's ncsi_start_dev() / ncsi_stop_dev() ? The channel
> monitor is disabled on stop, so we shouldn't expect to receive any
> further NCSI ethertype packets.

Having a quick re-read of those and ncsi_reset_dev() that looks fine on 
the surface; as you say outside of those no packet handling is happening 
and the link is forced down.

Cheers,
Sam


