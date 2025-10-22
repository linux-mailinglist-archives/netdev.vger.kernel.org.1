Return-Path: <netdev+bounces-231602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A5BFB70F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C0188A4EB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322B2765E2;
	Wed, 22 Oct 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gilCXgff"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28925487BE
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129941; cv=none; b=gu5p51hXHvUVd/dqskCks8OOg3ARwTJl+8XJlwvxaay0e1qfS+DUyvaDufYBO/Kkg8WGBT3QPWU4amnluqBFK8wgvHxw9D7cE7LZt18p7KK0+FMip6YeG/s+vSPed7+E3m9rLhurvVQgE8VNV/kkl13qRC6m4cq1cyJO0p8TGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129941; c=relaxed/simple;
	bh=Zj8rFDKRtb8uCvUQL4/0fON2f8BB4nZtU51UIH2n/9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUcLU22Iq5ke0DVb/zW39uZ9TQNQCd8/EsIrWs8/e1XhJl0U6+NveFpeTtnLttXXo+A23+ef88HDo1sw/DIt/IrK9TVKqiUuY+iFGTOG/p20YrBUbHNeiWX0mmg0+A0y0pVVGozmBMhPTvLLoagJZoL0YddxbBemqCXHPS6368Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gilCXgff; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1990D1D000AB;
	Wed, 22 Oct 2025 06:45:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761129938; x=1761216338; bh=uxyO+Kkfu/CiEQvIrijT6h181NpzcnSAV7d
	H1PJL3Jw=; b=gilCXgffZgJMcg8ACM5DI1WpJd0ilUhd7VXMdJ4DnOqY7bJ4slj
	wc+2M0baW2QIgZRFLR72jAsUs+coN3hWyewEQpv6IJvHZE9MQiHpajNn8w6v4xr5
	f1PL8NQcZj0Dc5duiN6fOm33PBRcdnohru90k+Zzjh65hlPVPBzBpFuDC09627yG
	P+gqkXEGxAR7jyPpd29T9WdeIe4iVieCKv99eQ8ZB1IRYn9rK8vpYzwtIp7IR0rT
	30cohGBv6GbAazU46CQQWwpcvLWVfNngttdcAYgB/lSrOieddWChQKC7nIVDoys/
	Ght81WefVC2lytFZK/Qx/lVpVdpkme8Gy6A==
X-ME-Sender: <xms:0bX4aBsXY1Ul4FRs_sL4Uc2WcLP--BwbZDbLE3dRZLz1ebaBidiSBQ>
    <xme:0bX4aOJZSBCiOv0Zm6fR9gFOabts6BvWe5ShtS3A_qNE9WHmrARV9DSuHhujvi0SA
    3chPhjr6zcsMu06I7eBiAh4wiFd8P-k3C4q-K6jHAEbr6t4jQ>
X-ME-Received: <xmr:0bX4aOmrqhAoeWSgbscVyaVXTpWZ_mtnK5MwwhvpNy3HuFnq7PrEomXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhngh
    hhrghosegsrghmrghitghlohhuugdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghrrghnsggvsehmvghllhgrnhhogidrtghomhdprhgtphhtthho
    pehjihhrihesmhgvlhhlrghnohigrdgtohhmpdhrtghpthhtohepgihihihouhdrfigrnh
    hgtghonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0bX4aPL319v43mmBWg2OfpJe8PA4GOZzWKnjGIqcGVKQ02cNJp_bjg>
    <xmx:0bX4aD7NRXkFnB3OJarcNcoGlfcmOP6JAtTXp1ZAVcqpkIk8ajy_Bw>
    <xmx:0bX4aD02duG2CydQJyE09HEkPs8hVysJoQzykWas5W-gETzfvmnyqw>
    <xmx:0bX4aJdcVChRsgPmnML9B_qqgNr4VWbWgi0mm9r36c_GjWIJuypZaA>
    <xmx:0rX4aIxXYgSqwvU8jbORg8gCxGQ2SwZdT-4_NIwOcRO8vef2OG-_5xAO>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 06:45:37 -0400 (EDT)
Date: Wed, 22 Oct 2025 13:45:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net-next] net: add the ifindex for
 trace_net_dev_xmit_timeout
Message-ID: <aPi1z_frpBzpBPpa@shredder>
References: <20251021091900.62978-1-tonghao@bamaicloud.com>
 <20251021171006.725400e3@kernel.org>
 <27169B5F-3269-4075-89F4-FA7459241EB3@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27169B5F-3269-4075-89F4-FA7459241EB3@bamaicloud.com>

On Wed, Oct 22, 2025 at 04:31:34PM +0800, Tonghao Zhang wrote:
> > On Oct 22, 2025, at 08:10, Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > On Tue, 21 Oct 2025 17:19:00 +0800 Tonghao Zhang wrote:
> >> In a multi-network card or container environment, provide more accurate information.
> > 
> > Why do you think that ifindex is more accurate than the name?
> > Neither is unique with netns..
> I thought ifindex was globally unique, but in fact, different namespaces may have the same ifindex value. What about adding the ns.inum inode ?

The netns cookie is probably better. See this thread:

https://lore.kernel.org/netdev/c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev/

You can also retrieve it by attaching a BPF program to the tracepoint.

