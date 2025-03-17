Return-Path: <netdev+bounces-175374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57ABA657B9
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256B57A45E0
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0D188907;
	Mon, 17 Mar 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PrHYv3F7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjuIUQrl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAB8C1F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228262; cv=none; b=RVxj799Go9F/j76nqvtFdHXHCCQkffITFLxEkGj9NOGtdRnX/3wNN+Kw4KcV4cwY3pW6KR6qCA0gZD/ph+Byj/VdMhg2XF0VzPMbiYrazrQi3rulS4b5StS4Mc7GMi2NQipoEq+iwyts7OsPSZ7wAjd+k0r9kb6b/CAxxAxKsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228262; c=relaxed/simple;
	bh=DkxM2XIkdIcuvoC7cMCwQnYH7PW7SvIfahaSZB9Cn3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyJlvKHhGfs1ztlgZ03b+QMD3eXi9AQln+UJclpp4SrSW4J8Ngc+ObJ/TrM74wvV6xL1GAgDPA9c6GTZrPu1CLs6un3GEUkcFlozCTJwMaOO8l/sAsTcfEt624/OPwBcs+ZVyLBMqPDxWSfLmwrXuIVcifCN3haeRCcZk+rfUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PrHYv3F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kjuIUQrl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DE12411401D7;
	Mon, 17 Mar 2025 12:17:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 12:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742228257; x=
	1742314657; bh=rChHcIiTsqfJMfRRaSk9XzCEBpSq53JiuYtJYOMaOXs=; b=P
	rHYv3F7pdvTvJ9p7CkKL+OESnK/481FPd8M/2NOZl5brmBkA4CYQYaa56StVYEjH
	aqHdR4r4+AU59/5uuRw/3P4fBM5PHkhFnTEbBdV9X2hhgFH9oUokLq0svdLNNtHT
	CqEeIZnR1Id5Gmn6Zx6jZV62ro6vLvsOHJ7Pt69Oq6p64CnBvZP9VQtn4/D7f1Y4
	XkrICapEy+nP2kMp/A0Gz8wWe3MIOCWXIebzfevi4ul5pJLm2Q7rfszmhPkTYX/0
	9271W2eVji1beGetXbO1lOBhbLaiQiMkVPengk6EjU9Hld6R8dBzA64JfJcPvV4c
	OCRgSmfR3aVvrmfdAVLUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742228257; x=1742314657; bh=rChHcIiTsqfJMfRRaSk9XzCEBpSq53JiuYt
	JYOMaOXs=; b=kjuIUQrlCAUHJ2I4ZHJmh28HOe8KyRo2h5zuZvEUHGxA0D5pGYV
	Ja1zOLGO5sl9PBvptarugXd6LNQtipWyGgceuqjl6nqbtGfrCoi03D7jhr2jJFu0
	Z7VX7ftQ5HIiGwqO7rHtRZIK36VmhGXprpAvr3VYJr/gfsxhvFRu/9NyBHvOvnaX
	plrvGQbWSROHnbAv9KqihFn35wwr98iFMxx0iW7ZanNBSHzuSTwK6yirUDBJHXzZ
	R9eKQAsaQUrgtgzG5dbgvXAZK3oEATU5/caVWGg4VO5pyqjftePdq+XbDkXSMCSX
	968NIK8KnxtcgRMkGcn4zSB0FpuCjS11jug==
X-ME-Sender: <xms:IUvYZ_oRjpgaYD1YCI9g7EthIN5VNfPnr5C2LYdWePdovW6DSitNzA>
    <xme:IUvYZ5pfEj9Tvj96-Nmvy2k3-gmH76SSKnpXJbCim9H4KL7PGBewIuxZASn-zhTI0
    sFtMdKnTWJaxP_R2L8>
X-ME-Received: <xmr:IUvYZ8NoDwIhnf6AcHC-wUp8LqTjEcKxaw6K3zez49INd3JcXhrlVutGkvH1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgtrghrugif
    vghllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephh
    horhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IUvYZy45VqukZ9YePzGGrVmkjGDU2aoI247Oz-CtBuvSqvi8jjekcA>
    <xmx:IUvYZ-5wwUHfok9bxbc51PRiOkZzRsOZhs6mrrIOzMXQrxaA-WcS2A>
    <xmx:IUvYZ6iFIcvpnB08BleTdipRScQ0jobG-wk04O5KpnOxmyaS01H8tQ>
    <xmx:IUvYZw5q2PQ2ZvOPITTAMBkfhS8EiSmvMM59_ODMp0RRaB1RO85nGA>
    <xmx:IUvYZ2hSRKUzDmcgZb5FctANgVM9Co0nLuoVSLHyh5nZar-anatI58Up>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 12:17:36 -0400 (EDT)
Date: Mon, 17 Mar 2025 17:17:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: move icsk_clean_acked to a better location
Message-ID: <Z9hLHoGnvHqD5da4@krikkit>
References: <20250317085313.2023214-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317085313.2023214-1-edumazet@google.com>

2025-03-17, 08:53:13 +0000, Eric Dumazet wrote:
> As a followup of my presentation in Zagreb for netdev 0x19:
> 
> icsk_clean_acked is only used by TCP when/if CONFIG_TLS_DEVICE
> is enabled from tcp_ack().
> 
> Rename it to tcp_clean_acked, move it to tcp_sock structure
> in the tcp_sock_read_rx for better cache locality in TCP
> fast path.
> 
> Define this field only when CONFIG_TLS_DEVICE is enabled
> saving 8 bytes on configs not using it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

