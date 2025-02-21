Return-Path: <netdev+bounces-168618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F94A3FB22
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0636519C65D6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE42080FB;
	Fri, 21 Feb 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bL2Ed5zI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uf5PGZ4O"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F01E2838
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154730; cv=none; b=kWlqVaWh2a5cv075q+arn6mFfuWsdgnKSAmJeXADV4roQJMoG2t0wSKFRUbFYewobYGhlgR2eEhdbEAX7RTsIkx3ThKBj+eKVmJkDazap8IBA8tKuE8R7aV3V+PfyoOgk095uqDNuHO6rvd2T2cwPP8nfjTvbY0X7QkzHu/DL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154730; c=relaxed/simple;
	bh=sEgAnWjyBzhe4XifTOYbPIh7pKkdRflEWEo0q/ceaoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI/ZteoKDeWvtFTE+fDY05DHh2GLbFsnHmXTSWyA6hxRlyIJg5fSPsLP0hLujEXqsPm3ghhBjK7jD6xs0l6n4UbnO5mXMWq6HwPP27QnKAJ6O5t+yQ9VIlsdhTvDakV4KhzI6gCALEbKm8MSE8pfG7QGMVy64QKTkFIyCaOEBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bL2Ed5zI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uf5PGZ4O; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC43D2540126;
	Fri, 21 Feb 2025 11:18:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 11:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740154725; x=
	1740241125; bh=UyS5p1NFcFL5rsm/FqITfVGDDrnDXLUguvtyIkhZ0Pw=; b=b
	L2Ed5zI8N38wZbfWKH7LohyYMXcTsOngyp71ygNAiIsd++6+ehpjuJmoVgYpmPwE
	pSNMlUO+NNKOe2b70V/7Ua4F5JjkQOOXtyvdspr8SHovAB53sJTZF49NHPUZNDlw
	j09bmYsX72uZPeX8BxId/bFda2zkpsEsmW2ILdPN1FMhMOMmNgGCO84T3TrRFHYU
	QJWJlCKq4I8p/HHfsJbNg26qDwLnosyZ66mR73V/R5526e38zCvCyttB+pvSJ6CU
	DroXMHyIR/+1QswvLZXPs5AEUAC2WL+DNB4YLzHbTujKZ8+HwYAM8f9JPZUynKc5
	8ynPEcrtv2l0zTQaltZzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740154725; x=1740241125; bh=UyS5p1NFcFL5rsm/FqITfVGDDrnDXLUguvt
	yIkhZ0Pw=; b=uf5PGZ4O47FNwmJqAW5l3KaGFjsqEwlZMaUk0rOp9fIK3niO++E
	IOQLZtblIjUdDpd60jyzpM/xD92LnJMhLGW2w0oWU7C4dgBHD6XjKczxu0RkFZcD
	t5QNBiR263G5w/ImwlqfytC0CJvb7/d5cun6fdYKQ7XT8/IhXZNNd2JTJd/jMNv5
	6k3vm0hVKhlEVaRdQzpzRVRO21dQYpCjhviOdBroZ8yZ+sLWpkQM7aTzIKJNgWyX
	5lAkjaUZIwbV0cuZlqIFtltkHDisAv+uwEs8/XNJLKUsOT4+hMY1Q+uz0e/Z8Jv/
	9fE+p0UFYgl7p3/uAE8FT3TKuIP50uPxcvQ==
X-ME-Sender: <xms:ZKe4Z7CyGaQvrn90C-8t2aeJ22Gpf101QvN27jGvQryw0gRZLShggg>
    <xme:ZKe4ZxhRsZf0hQus88LsMlTNcs6dut-xwwCe-qorP4GXlBzk7ikqJW-vCgeMGl8g4
    t1ME3OW4iftItqieKE>
X-ME-Received: <xmr:ZKe4Z2lv2260YtQh89BApHpVkh777GtwMkh-NO-ua_52O-H40xlyqU3h9G6t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtfhhomh
    hitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghv
    rdhmvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvggu
    uhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphht
    thhopehsrggvvggusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zae4Z9wxNmGjKQEm3Gcm-XeV4Sj_-XxK2jx9w_pHn7UwvebJJZru1w>
    <xmx:Zae4ZwSn8g-Lb0OwkmJXGkiWkXIiCk7arp5jRWb2ffp2zZzBIKgZiQ>
    <xmx:Zae4ZwZR9bzvRfzbiJQGnMUfBzafWsyaHDpqYc3LDX5NS-az3P1z1A>
    <xmx:Zae4ZxR1ZDO5w7nipdqILSC83lJr2iWrvRPsEhnnJ5fevV0sUk_fJg>
    <xmx:Zae4ZzEE2e-LcbxzXOOVYxOsDPVokc0WO66RW4QZXaudfU3nq2NuUQ2k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 11:18:44 -0500 (EST)
Date: Fri, 21 Feb 2025 17:18:42 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v5 03/12] net: hold netdev instance lock during
 queue operations
Message-ID: <Z7inYue3xLFjlu5C@hog>
References: <20250219202719.957100-1-sdf@fomichev.me>
 <20250219202719.957100-4-sdf@fomichev.me>
 <Z7dGFLSom9mnWFdB@hog>
 <Z7dfqFr-knB3Bv0G@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7dfqFr-knB3Bv0G@mini-arch>

2025-02-20, 09:00:24 -0800, Stanislav Fomichev wrote:
> On 02/20, Sabrina Dubroca wrote:
> > 2025-02-19, 12:27:10 -0800, Stanislav Fomichev wrote:
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > > index 533e659b15b3..cf9bd08d04b2 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
> > >  			netif_queue_set_napi(priv->dev, idx,
> > >  					     NETDEV_QUEUE_TYPE_TX, NULL);
> > >  
> > > -		napi_disable(&block->napi);
> > > +		napi_disable_locked(&block->napi);
> > 
> > I don't think all the codepaths that can lead to gve_turndown have the
> > required netdev_lock():
> > 
> > gve_resume -> gve_reset_recovery -> gve_turndown
> Good catch, looks like suspend is missing the netdev lock as well, will
> add.
> 
> > gve_user_reset -> gve_reset -> gve_reset_recovery
> I believe this should be covered by patch "net: ethtool: try to protect
> all callback with netdev instance lock", no?
> 
> __dev_ethtool
>   netdev_lock_ops
>   ethtool_reset
>     gve_user_reset

Ah, right, sorry, I missed that.

> Or is there some other reset path I'm missing?

Looking at net/ethtool, maybe cmis_fw_update_reset?
module_flash_fw_work -> ethtool_cmis_fw_update -> cmis_fw_update_reset -> ->reset()

(no idea if it can ever be called for those drivers)

> > (and nit:) There's also a few places in the series (bnxt, ethtool
> > calling __netdev_update_features) where the lockdep
> > annotation/_locked() variant gets introduced before the patch adding
> > the corresponding lock.
> 
> This is mostly about ethtool patch and queue ops patch?

Patch 04 also adds a lockdep annotation to __netdev_update_features,
which gets call (unlocked until the ethtool patch) from ethtool.

> The latter
> converts most of the napi/netif calls to _locked variant leaving
> a small window where some of the paths might be not properly locked.
> Not sure what to do about it, but probably nothing since everything
> is still rtnl_lock-protected and the issue is mostly about (temporary)
> wrong lockdep annotations?

Yes, it's temporary (I didn't check the final bnxt patch to see if it
covers all paths).

> Any other suggestions?

I guess the alternative would be introducing netdev_lock where it
belongs before adding the lockdep annotations/switching to _locked()
variants.

Maybe it's not worth the pain of reworking this patchset if it ends up
in the correct state anyway, I don't know. Probably more a question
for the maintainers, depending on what they prefer.

> Thanks for the review!

Thanks

-- 
Sabrina

