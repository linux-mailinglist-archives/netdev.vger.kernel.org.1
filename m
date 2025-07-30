Return-Path: <netdev+bounces-211004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A67B16229
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2973AF167
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2B1DA60D;
	Wed, 30 Jul 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="t3BPRj9e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLZUJt8s"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9E2D613
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884135; cv=none; b=fSmS58WlN+noCCyFaElkjFsdJWTlJ15z0+oj+6agcsCzc9sCirifkY8M9MVF7npUIf8IqqxQcelKcBjVS7EdxpgEOC0G1zgsqXRvId1YaJ1MdtkLN7Bxbfeln0NS8zmERfRvLSESkdJF4kpCy8uqNtgpxY/pSZa3ubZtCeYwnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884135; c=relaxed/simple;
	bh=7H18pEK2YoPnUQi63R+VacM5GEI7pPgYW/GeLhFgP4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjVCKbJPuCZlDhAsWc/M0X7WlzrDiK9ytQ0CbPI7/L9cqeCwUg7RTnOzHTd6fl+w5M+KG0xrNanUmCQ46UiTrMt3EcAUtOLFx+H1DOKO3kho3Z+ZOGjkUlg4J92S/3UCqGvpmTnNsD33zVz5/VO1oEt5JeJDtu36js0pEPvrc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=t3BPRj9e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLZUJt8s; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 79B0EEC1EFF;
	Wed, 30 Jul 2025 10:02:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 30 Jul 2025 10:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753884130; x=
	1753970530; bh=RqdiGE4C0s8TduU/0IfXVpBJQ6PmtPLPlEt0X3G26/c=; b=t
	3BPRj9etV0LcHAdN7Uu0nub1Y37p4j+5zrJcIZf9F3EWcopLJKA7QKA49+lZqFYX
	JzwSmh2Rx7zdCn436WCDU2Ge8QZiG9sEPKx89/3ggNSy6cDK9dnMYMbeXjWF3TA1
	jhzLQejPPTaP9qqPLWg/O01lCEMQVCYKk4lgCLtSmhdexDyNcCiw8HXUsQwyc5+l
	uVU76Bvzk0d0cPP6UY30r1gpvaSBEq/sR7gyVrAUIFBz888sAFtDillae1MuTURA
	I71h08HuQAKzjs9gNvhu4TsEtyRC1pjk/ZJI4LcPWyAo5x6JZmuWCFuOb0dEH8xe
	wpTunH4OSGGBgo8DYypXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753884130; x=1753970530; bh=RqdiGE4C0s8TduU/0IfXVpBJQ6PmtPLPlEt
	0X3G26/c=; b=FLZUJt8s/diflHf7H9B/lSslDOHBzPMt+EJAyxdd/AcRKJnU3B3
	52nSozV6tFGMwC8bXbmRkcU26jmEFIAbdSXBTs8g++krajO/gwmqTohAojiTeZwV
	ghXY7o2eGyJaV1WTzX2zQ+RxHxEwFVhgTnVH/lch2rud+k5EorIub/7e8xuG8V5f
	/l/pKRffkMF63PdOe2IBlhNKimpo2vTenB8VB3G+xTdfFQD+Gkahz+XZ9kyTosDK
	T5VZvxt7rwiUyiSPKbhTZxlrLKpJcXjmMk82lVxlH304O9ijSgmQbCpvpgBD35iR
	ZqUxn5YCU5fZfUzSrOPb9mUZck4HDcPB59Q==
X-ME-Sender: <xms:4SWKaJe6j223jrzlXnH3CjdFalCKnUZAzo91v6IfMAvACQOt0jn3TQ>
    <xme:4SWKaCuvHGAShHdeT78epGghpztqQUExxGFWkULXxwonzcgCUkqH6X2i2ZtE8azES
    zxiTGtgtLcd-AJSKM8>
X-ME-Received: <xmr:4SWKaI9h3PwaMDhbtdNlVbpQ6wZr26niHirktRteeXP0RaBGN5AU2iLCnxgi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehlvghonhhrohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthes
    shgvtghunhgvthdrtghomh
X-ME-Proxy: <xmx:4SWKaN3AZdBQ35vrrigXVrlgeMnOyPdBLqx2TUglbhtrb1SeVXRDIQ>
    <xmx:4SWKaNAFUpxR2eFAakfB4tWyc34sR1qiz0m70vlxEDUi7xIZk5i6Ow>
    <xmx:4SWKaJehHlLKgyBWfmi0_vdvDXdHJ8_i7cDsm7WmongO6Oud0ITllQ>
    <xmx:4SWKaK643VwXwpWR070y0HywdE0kQ0KebL-S5XNGbi3DyHgzAb2XcA>
    <xmx:4iWKaIkRr-Q1z6PEPhgFzy0cHAN1To3kYvwq6nW_dRAycaRsKwTTMTcd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 10:02:08 -0400 (EDT)
Date: Wed, 30 Jul 2025 16:02:07 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check
 from validate_xmit_xfrm"
Message-ID: <aIol33zSxJk6OQSy@krikkit>
References: <cover.1753631391.git.sd@queasysnail.net>
 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
 <6d307bb5f84cdc4bb2cbd24b27dc00969eabe86e.camel@nvidia.com>
 <aInzWYscMcTRylVg@krikkit>
 <2b6578f3fa54feff8d7161e3ee46f204e0ae2408.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b6578f3fa54feff8d7161e3ee46f204e0ae2408.camel@nvidia.com>

2025-07-30, 12:32:13 +0000, Cosmin Ratiu wrote:
> On Wed, 2025-07-30 at 12:26 +0200, Sabrina Dubroca wrote:
> > 2025-07-29, 15:27:39 +0000, Cosmin Ratiu wrote:
> > > On Mon, 2025-07-28 at 17:17 +0200, Sabrina Dubroca wrote:
> > > > This reverts commit d53dda291bbd993a29b84d358d282076e3d01506.
> > > > 
> > > > This change causes traffic using GSO with SW crypto running
> > > > through a
> > > > NIC capable of HW offload to no longer get segmented during
> > > > validate_xmit_xfrm.
> > > > 
> > > > Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from
> > > > validate_xmit_xfrm")
> > > > 
> > > 
> > > Thanks for the fix, but I'm curious about details.
> > > 
> > > In that commit, I tried to map all of the possible code paths. Can
> > > you
> > > please explain what code paths I missed that need real_dev given
> > > that
> > > only bonding should use it now?
> > 
> > After running some more tests, it's not about real_dev, it's the
> > other
> > check ("unlikely(x->xso.dev != dev)" below) that you also removed in
> > that patch that causes the issue in my setup. I don't know how you
> > decided that it should be dropped, since it predates bonding's ipsec
> > offload.
> 
> Apologies for that, I think I assumed that if offload is off, then
> xfrm_offload(skb) is NULL and the code bails out early on "if (!xo)".
> Seems I was wrong. On the TX side, the only place that adds a secpath
> and increments sp->olen (and thus add an xfrm_offload) is in
> xfrm_output, after the xfrm_dev_offload_ok check.

Yes, the "offload" code is used for both HW offload and "SW offloads"
(aka GSO/GRO).

> > The codepath is the usual:
> > __dev_queue_xmit -> validate_xmit_skb -> validate_xmit_xfrm
> > 
> > Since the commit message made the incorrect claim "ESP offload off:
> > validate_xmit_xfrm returns early on !xo." I didn't check if a partial
> > revert was enough to fix the issue. My bad.
> > 
> No problem, good that we caught the actual issue. Will you prepare a
> follow-up patch then?

I'll send a v2 of this series with this patch updated. Thanks.

-- 
Sabrina

