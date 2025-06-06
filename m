Return-Path: <netdev+bounces-195467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CFAD04F0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AB5188A00E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDC1B0F1E;
	Fri,  6 Jun 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DQTw9nl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrfroUUQ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D545009
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222780; cv=none; b=tKHBan+e1d/SyL8YRDsC8m1wf1OXoAnaG9v5c1y2BH2/0Egi0iamY3CAWGVUXXb9GKTJkE3YAA2EqAOzf5B94Fd5uJac0nbxxvjwVHMWEkP4avYfsH4q4FWA4+vHv4yfRXJZ44M65B0Did9asCYbzC3opstCwHf+kHVBTn335jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222780; c=relaxed/simple;
	bh=CfPrUY0ccFHhO4stV5xK7skzk+/2TSQVvIvZkILRryM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en4pwijcwfI+AYKSW1cq7WLejtJn7eFH1PTMWCSCF6+ALxbMbBEIbIOR/qSEkut8hJEY7bUKQBHwWCX4Xea66dV4jA/ENezlrIuRE2Z1POK6NRInLv/LULY/p26EmGi5yqcPk5tIrfkVRf0AH3/UnqDWp+tgYpktFYPwkhLWPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DQTw9nl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrfroUUQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D45D1140149;
	Fri,  6 Jun 2025 11:12:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Jun 2025 11:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1749222776; x=
	1749309176; bh=OycdHmucKqZhzX8K5Ys7TJE3ZfkGve5bJ6DPydvETzE=; b=D
	QTw9nl7urceXPCRyKXIwC6fOJb7QrL2ZUKLEnRwAqSzXKNEUgXBEZbtc0tqjSFS0
	rT5/q4VauFc9ZBLSiAPbiBm6RXl0H0Hf7u7zb/hMsTXVBYxcwpCygWjxdBnjpxCO
	OsGoX5e7Egi8P1CpSi7ivUNsPHHE9GzTb/dBHLgDTh+C9XYSBPCPTbhq1MhTRRfS
	s+Rwk4TSB4cVmT4NFFzswf+WBjI3Msl0F8vfLLu+nkwKCZJTmxd8zh0dhFrYB++V
	8IVj+jWyk2VbM5iUkLfWh6VGHeFY+K9K5UfG+KLb5i2hEthWLz9CTuH81Pw3738j
	YC0VTSmWM6uqXo4IF0ZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749222776; x=1749309176; bh=OycdHmucKqZhzX8K5Ys7TJE3ZfkGve5bJ6D
	PydvETzE=; b=QrfroUUQxccZZ9fnhBWoU0juZ/q3qa0n6ewFXLKwZl2KxTKGJnm
	MUvaiye04OBBPWT2+8cchIvNxN2S/zbC7QkSSRAd7qaUsf83moRhpE1YoXNgilaY
	LMrjsy9OX8RC2WsAxPVJqVyEoexOEilCmiD9hIrSRDQkkJ4sDA6AYL/81lqjsyDC
	TWelgSl7ha3IbOVUJevwJUbrOSpsO62/eBgFF0zKcbxedF2dk5SqLpe6BAuIAbyP
	mR245oUF2D0y2K5eZvyRiEowV3zNIKuAJr0t/lmlq3mMw840qCH/zk1SwtL7R/6L
	N1Lze+7h3P3uhH1ybDd5v0J+fMZwzUzS+cQ==
X-ME-Sender: <xms:dgVDaIsFN4ISLeDtl6iES21y1nOvIFfd3AMvWxPKL7ygcwM7aEuwQA>
    <xme:dgVDaFdags5vReeMDYokvxlGplH4mRktqmNDolt3dUklYhVt1b2z9g-Wwc1gzS5Ru
    vGyIx3X82iIpS1MVfw>
X-ME-Received: <xmr:dgVDaDz5PrxtL2pf81T6ToMe5MfllFR1Hf_U0IrFNIAjmcsuSr3dV07Rtk1a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehs
    vggtuhhnvghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:dgVDaLNy78pOAMNtQZl9oY-klRCQVgCdsbicvAd5NbHQLBuynG7QTw>
    <xmx:dgVDaI9sSLx-_knn-4yNurLyHHh4Hyr8rydpVC1P27hH6dZ1djeeVw>
    <xmx:dgVDaDVPGdOnPpFuQdIrDeSypvxxLIp0pCh7O0F0njVWSTFQBzRyHw>
    <xmx:dgVDaBfpaQwWf-w0e122sh5tfVHoBGuQFR_biER0-erurlPpxr9xvw>
    <xmx:eAVDaGJUwFq5ODV0Y8BBc5p4paMwgAZBhy1GlM_5n4NlPV9GXKlhzIqq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 11:12:54 -0400 (EDT)
Date: Fri, 6 Jun 2025 17:12:52 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next v1 1/5] xfrm: delay initialization of offload
 path till its actually requested
Message-ID: <aEMFdAPopn9Td-Dn@krikkit>
References: <cover.1739972570.git.leon@kernel.org>
 <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>
 <aEGW_5HfPqU1rFjl@krikkit>
 <20250605141624.GG7435@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605141624.GG7435@unreal>

2025-06-05, 17:16:24 +0300, Leon Romanovsky wrote:
> On Thu, Jun 05, 2025 at 03:09:19PM +0200, Sabrina Dubroca wrote:
> > Hello,
> > 
> > I think we need to revert this patch. It causes a severe performance
> > regression for SW IPsec (around 40-50%).
> > 
> > 2025-02-19, 15:50:57 +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > XFRM offload path is probed even if offload isn't needed at all. Let's
> > > make sure that x->type_offload pointer stays NULL for such path to
> > > reduce ambiguity.
> > 
> > x->type_offload is used for GRO with SW IPsec, not just for HW offload.
> 
> Thanks for the report, can you please try the following fix?

Seems to work in my setup. That's basically a revert of every
functional change in 585b64f5a620 ("xfrm: delay initialization of
offload path till its actually requested"), except that now we set
->type_offload during xfrm_state_construct instead of
__xfrm_init_state, so other callers of __xfrm_init_state
(xfrm_state_migrate and pfkey - we can ignore ipcomp since it doesn't
have ->type_offload) won't get ->type_offload set correctly. I'm not
sure we want that.

Do you need to also revert 49431af6c4ef ("xfrm: rely on XFRM offload")
from this series? The assumption that x->type_offload is set only for
HW offload isn't correct.

-- 
Sabrina

