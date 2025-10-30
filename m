Return-Path: <netdev+bounces-234349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB37C1F94A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3AE4283BF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B16351FB1;
	Thu, 30 Oct 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="IGUOwze7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGqch72S"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9C350D52
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820122; cv=none; b=S2tKmWdnl/JlmeoNBaGQQTVdgJZNWTDRqQfJ5gcEEc73/SUZkLlajnUwS5grfKVPCfBeo97E+gXBWt82HcdW7XnnBia/GYoIKlu97iUdqgKA0jUPCw9p2Pgc6rdCFTn6Usj/0VpnJacrX3UYtlouUcVsdm+r9PPxLXc+fifIryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820122; c=relaxed/simple;
	bh=0/baVWMxFoAo/Ib95gC0lBZ45HRVyqvAZbY/K71GKk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e09I3kqBYz+Ka6CR4OgCfd8fbkbP8LIDWlN0WE/hPqUf+wddHUjTxqvir/d3Qqas5WZNVjOQB/Jpz5BCFmqpQ7MUN5UCGxAuzHqaZV13hmTWaA0VEJCnNvA2ku6q1SQz0WF3lKIXtTNIS/OSLHeTNfIz3QHkRww9ITI7EUdZFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=IGUOwze7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGqch72S; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AC26A1D0018C;
	Thu, 30 Oct 2025 06:28:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 06:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761820117; x=
	1761906517; bh=pv3kIQ2je0JxNKKQubVH5mPhZIsYYqq5229K/Th1UN8=; b=I
	GUOwze75oK88VMJczvny8YRTIqd4p0raiiywhcuzOs5jGEkioPeCor/Nc/mSSrcI
	YxSMXKF2tHJc+0RI8u5pv+aHO4H6gLdFnKHqeCK5GRgZIFZ3i/WUIHzrBNw5QCiQ
	30ZrC5cd2qDchmQRxVWQiMbFQ4iYpknlcTQrEfhJV2HZqpxFvxkgLR7tTBIhzcsb
	dbQce5hVj2xNSSKkacE0FtLVRaCoKZxnpCmgEkrgM/cE/uOBiA9XdXRfFNnSVN8l
	boK3/fRgGwu+Be4B1w21QE14YTBQawkNzFO/HkuYXvknA1FdGd0DQfFfSPyUz7/L
	/tj2fcfNNw/v/OSWGeEcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761820117; x=1761906517; bh=pv3kIQ2je0JxNKKQubVH5mPhZIsYYqq5229
	K/Th1UN8=; b=RGqch72SMmum/KbE8hS5aknTDxEI5caW70xQNOIPHkfgClo6ovZ
	waYQi9z4cpHEF0XBm3ueN73EV7GTbDatbwklWSI/G2lJftadRPPxwirvmgjPcNlv
	mBe3GBXRzqq3M7005APRDKrK2WUMRKU+o7Nw+2Wq0icXevg0517xn9zHMcVBkZ/Q
	mFBJA4Gahh8xJwgdagd1nfQKvPs37l2jtNsChdR1EiKG7ktBIA7wHHolrjh17Rlc
	Z/jsbcLRCk3/6sz3rlLh+Q4DcRG1n1Igho/CbbbqeJ8HK+bjkqPJMyv71fVmmHe4
	5qLAOrCeIXc61jwqigfhzbvtWjYMbn0dJKw==
X-ME-Sender: <xms:1D0DaUaGMCXWMm2cSWMNU5BbBR8oH3r_n2cm2FArk-VtmVr_1UE9JA>
    <xme:1D0DabTiuOF4_G4Pq9BWNg-EWrY83dIGtUNjOZ8TlJxOP1F8srdSyqEnxwJ0eRz9I
    fJF7oC9dx1sQNP8uHuMilc8YOzC2I494XEu7M_StCnxyUu1qxPJ3N8>
X-ME-Received: <xmr:1D0Dab9ZIR3Po3y6SYzTDWDlTfZYoTiPTMZIo-6VkXdZ-RqFz2dZwqBVOwee>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtse
    hsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepjhhirghnsgholhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtg
    homhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdr
    rghupdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:1D0DaTg7Gnm14shy7ifD9Pa3B01GQqJMqnp1o34EwJEJVSWyKnIkxw>
    <xmx:1D0DaUbAUBHh_HWQ-9Sha3VKKa3ODYrvm1Aw4uNawq05H_pkrGFzJg>
    <xmx:1D0DaQ__VhOxbfoy6auPXZnYWyqjK3ZJDRAmDUFtg5AOPUPci2MSSQ>
    <xmx:1D0DaeOpkM_bo0BgzQx_v6wD_ljTaBurID7XUXat0DmoRzr4tOyhhw>
    <xmx:1T0DaaUfJbPuilo9FEJuEV45K2UWV-UmWsxPVZj9R8dgar0OlIZZgQ3V>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:28:35 -0400 (EDT)
Date: Thu, 30 Oct 2025 11:28:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
Message-ID: <aQM90v2J9maIvTlU@krikkit>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com>
 <aQCjCEDvL4VJIsoV@krikkit>
 <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com>
 <aQDbhJuZqFokEO31@krikkit>
 <aQMc64pcTzvkupc1@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQMc64pcTzvkupc1@secunet.com>

2025-10-30, 09:08:11 +0100, Steffen Klassert wrote:
> On Tue, Oct 28, 2025 at 04:04:36PM +0100, Sabrina Dubroca wrote:
> > 2025-10-28, 21:36:17 +0800, Jianbo Liu wrote:
> > > 
> > > My proposed plan is:
> > > 
> > > Send the patch 1 and patch 3 (including the xfrm_ip2inner_mode change)
> > > together to the ipsec tree. They are self-contained fixes.
> > 
> > So, keep v3 of this series unchanged.
> > 
> > > Separately, after those are accepted, I can modify and re-submit that patch
> > > [1] to ipsec-next that removes the now-redundant checks from the other
> > > callers (VTI, etc.), leveraging the updated helper function.
> > > 
> > > This way, the critical fixes are self-contained and backportable, while the
> > > cleanup of other callers happens later in the development cycle.
> > 
> > The only (small) drawback is leaving the duplicate code checking
> > AF_UNSPEC in the existing callers of xfrm_ip2inner_mode, but I guess
> > that's ok.
> > 
> > 
> > Steffen, is it ok for you to
> > 
> >  - have a duplicate AF_UNSPEC check in callers of xfrm_ip2inner_mode
> >    (the existing "default to x->inner_mode, call xfrm_ip2inner_mode if
> >    AF_UNSPEC", and the new one added to xfrm_ip2inner_mode by this
> >    patch) in the ipsec tree and then in stable?
> > 
> >  - do the clean up (like the diff I pasted in my previous email, or
> >    something smaller if [1] is applied separately) in ipsec-next after
> >    ipsec is merged into it?
> 
> I'm OK with this, I can take v3 as is.

Ok. In that case, you can add:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

for both patches.

Thanks.

-- 
Sabrina

