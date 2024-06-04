Return-Path: <netdev+bounces-100774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220E8FBEA2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A3BB20E87
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5814D451;
	Tue,  4 Jun 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="IMrQfajn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFeTNtxF"
X-Original-To: netdev@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815E14D2BC;
	Tue,  4 Jun 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539222; cv=none; b=JyvPIeJgHId8IdRRshs7AxY17Gf9O98I1WmjHNwtRSB6Dg+o9nBxepOcwDHLdxVBHcMUkkE3pknRuIT0JySSOZu8D0dDutJB0bXRr1hHSoW4eZluA+cGxz1536soIovrSmzChg3aB1LhQb+h5CN1K/MryI9RsZZPdMQNkoA5FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539222; c=relaxed/simple;
	bh=lYwlsFpXaffIux9v8UtowemAJ7x4EV5zC+20r626z6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf52LgliuAkOFFvPdTXgKSBdsaFpEnsJCWBcCiHYqqHA5bwDRiCK5XGGqFjTMDExgrMQbaZTc751hZEi3hYvVi/1sP97zdFAbZjp9JpxLHBtVETGsiIVrr5zQ4PRdYy20BBUdp8I682mudKrYOI1HH+KjqS287kdZtZPzntHgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=IMrQfajn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFeTNtxF; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 33B85200178;
	Tue,  4 Jun 2024 18:13:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 18:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717539219; x=1717546419; bh=muU5qJkRVr
	c/WJXrwBT0sJpUEwClb+SER/+HMwaSXbE=; b=IMrQfajnu+GoDRKlk7ICyJN2RB
	df07iUJTJhJdTdXsskFVN2YBYUA0ThPeeOJem8mlAf9L/GG0pOaXA/mfnqMtNioG
	Qg3eRDQefaetISlfIU3LvnYBFS+0WfChDyq/P0xWTWF51tbK50H/wqxB/DhcA16S
	ESVlf1iBwEBLJtPI18jyJFnVr5yiVI4at14G7PWsafABea8ghLtpKp3bfz8cO6/t
	O0WKTNLW57ZU36nkLt573ORKn1AUo/KT70eGo6mN4Y2LxhgmjlaNFtA0ZP9f2HmQ
	UxyyOOm10AqNUBs8MGdFCAnMfEjrdZfoimbLr5GfyIa537l6G6SLZuOKapuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717539219; x=1717546419; bh=muU5qJkRVrc/WJXrwBT0sJpUEwCl
	b+SER/+HMwaSXbE=; b=MFeTNtxFI2QMwDPKwN42XQzf9AsNmhYWklo3WTFDkq+5
	O30Ex0pMTHobmgDJZPvk60WZp0Y9jCn6VNa9vEgyiOSzlNHUpOQDbOogCzi4Uu7Z
	LBpp7nP4M9ACiqmwIWUnhzCxldVtsnGoId+TKQAYhl3S+zgxq+Wuss+OlxQoEyI/
	cLsXZYNpL/7MFJ6/vrwp+JsjJrekEHgVZ7hbSAwqRFbaVkDYbUkLvGIAYafIRftJ
	B6BtvThMJSEW4ZgPFzrmcDcEl36/UVQkZt1E0yaIPJO9pbgwusQ/npmm4pG/wEml
	ssfZc73DIRmqIheoviOdqsABd1gYrWz1kn1tRms8og==
X-ME-Sender: <xms:kZFfZkdczehyMxOFzsQWStdbFQ9b_QnsP8-cO963kDUl_5iQHuMzgw>
    <xme:kZFfZmMwwotOef-QBESG11xPxv4kufSeBLHUnWfVipehkWwj2HYKMY7_aOgKjhdIs
    NN_0UmcxggN_kWCURw>
X-ME-Received: <xmr:kZFfZljky2XQYlmljv4plW43mwdPMdcXj1oXDsqjBpnx6m9OzEkTlSIS-h8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:kZFfZp-1-pydffRIz4D7o3Ys2rwPeXZDWXsz6edwEcpxSH78j0sH6Q>
    <xmx:kZFfZgvzw6K8AoUay1km6TqbozmkIXVzkTjfxixAkdESpiw0RZJedA>
    <xmx:kZFfZgH61HKuJqAWVBTl4U4ScrOzd--4_lbpEocMhnidVq0jL_PTdA>
    <xmx:kZFfZvPp1AaskAuObiWsuU2zH7F8XYzrqL_GdJ-gG1Ka5nk-u4xyHA>
    <xmx:k5FfZhMRoPPM3AKMDF8th_eGWbzp_pkz6ZrW8V0ZEi_kEBCeYT6ZplaT>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 18:13:35 -0400 (EDT)
Date: Tue, 4 Jun 2024 16:13:32 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Simon Horman <horms@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <Zl+RjJDOX45DH6gR@tycho.pizza>
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-4-kees@kernel.org>
 <20240604150228.GS491852@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604150228.GS491852@kernel.org>

On Tue, Jun 04, 2024 at 04:02:28PM +0100, Simon Horman wrote:
> On Fri, May 31, 2024 at 12:14:56PM -0700, Kees Cook wrote:
> > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > +		char *short_size, *cache_name;
> > +		unsigned int cache_useroffset, cache_usersize;
> > +		unsigned int size;
> > +
> > +		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
> > +			continue;
> > +
> > +		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> > +		if (!size)
> > +			continue;
> > +
> > +		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
> > +		if (WARN_ON(!short_size))
> > +			goto fail;
> > +
> > +		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> > +		if (WARN_ON(!cache_name))
> > +			goto fail;
> > +
> > +		if (useroffset >= size) {
> > +			cache_useroffset = 0;
> > +			cache_usersize = 0;
> > +		} else {
> > +			cache_useroffset = useroffset;
> > +			cache_usersize = min(size - cache_useroffset, usersize);
> > +		}
> > +		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> > +					align, flags, cache_useroffset,
> > +					cache_usersize, ctor);
> > +		kfree(cache_name);
> > +		if (WARN_ON(!(*b)[idx]))
> > +			goto fail;
> > +	}
> > +
> > +	return b;
> > +
> > +fail:
> > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > +		if ((*b)[idx])
> > +			kmem_cache_destroy((*b)[idx]);
> 
> nit: I don't think it is necessary to guard this with a check for NULL.

Isn't it? What if a kasprintf() fails halfway through the loop?

Tycho

