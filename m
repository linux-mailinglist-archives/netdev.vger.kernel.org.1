Return-Path: <netdev+bounces-95137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05668C17D5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA671C20AD7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E2770EB;
	Thu,  9 May 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VnpqV795";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DG9geJXN"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B1C2ED;
	Thu,  9 May 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287649; cv=none; b=MoqwX3YVgasu7ZAH5UhlW2BOTYZLmG4adPOu/KoNFzPk3XCWvj6KpX+tmVesOBLHVijzo6TGBqIdSjjMPU3xNdYn4fauqzkOreTkrGkvdcOqLs+tAK+XkyhYrLGAnFuedyJuEpIIO91JyFglwS3a7lN5UkdTalIwoTaUxu/jgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287649; c=relaxed/simple;
	bh=LzRm47B1O70Prbd444BZbXlXNsdgncurpsO/SnH5gXY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=i07qdLqjQyAFx9oe6i579+jqI22u7SlqNhTCzldE64rLq0hte8gmo5gI/00KDSZs+p77EmwMz2UMHSQAK9+1xfK6ASSz+qNCB20j/xV3o68Yya8WsJg5OSEaPdbWNf1ZM5Bvk6UE7MpdpHrUwOWuPJag7vK2hAd7r5G+Mk5Ukrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VnpqV795; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DG9geJXN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D498114008E;
	Thu,  9 May 2024 16:47:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 09 May 2024 16:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715287646; x=1715374046; bh=mz6niMhiXS
	bLSWvYwWOExvotvdMEBuYNMUreHlPi8so=; b=VnpqV795gpWGS7wq6klfXzFl9U
	K2r97slcHjlY3xygj3TbEaTlIhCuB5WSAClDhG+E5NOA7zArW0W+H4RlKTE25g7q
	qHBhyPama1AwBLJmpCoHyb42leGLLuiAvD9YYUkU8RUnY+ydX2hWJk/j8ThneDS6
	d60XKyiW7GAUVIlhKjVShxIsLDqJvi/RW9OlKYCPsDA1+OzVHS3dQ1N4sh4lJCKb
	I7XMc/MmtjwmP/RVIKyD2MkFL2Bo1JYVWtK69geDU6w1XcUsxxiBPH98fB7/jnLp
	NDBEoM5RzJsfF1v5gp4PD0jDLUv0hwAax3/8Jegn3FziTkU7H6I5JXmDvpmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715287646; x=1715374046; bh=mz6niMhiXSbLSWvYwWOExvotvdME
	BuYNMUreHlPi8so=; b=DG9geJXNLCdb5rb4NIbiHrw1LctXxlTqKiIyw38Z+l2E
	XQyrNgal50nSSYsKSJDCeYRuQ3Kmy/pR3yeHCMmK4BD0OJIcZLbYbw5N65uLkt6N
	vCZ83+PFqcySnZaasG6hYcam2eZTCz/P4Vle5BgNDzbU/aBjTqCLM0AXgA4jkqG1
	CJexCmrI7oM+5oex/7fIZnkcGDOsHIEA9yzVFzAOrF2d8+4MI1L9yfINqvgm64Qt
	F2jIc0mnuaJ8RMHrV8vONYhWdg2YH9ClmscY5X7kBgLvtvmKPoOOy2I8NQUOKGyK
	+FGElKk93BpYAgSVVS7eFO5kRP+prs3ji+dS5uDtqQ==
X-ME-Sender: <xms:XTY9ZgJtA5SiJm7iyC3wLLJhcdz_b1TSSuxo6ovNZL1hGLAsY4CpnQ>
    <xme:XTY9ZgJSM5u_eRdKY6LLf62sOOyCTXnH-Wf4lTKfpOgiwonkTE8f9ttJ3BGCWuWMD
    VAifkn3ibTNk3AGOio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XTY9ZgsPwH1bgF9Zp_etqbWKxo9KsF2t6NMx9ldb0r0v4yctjDOlIw>
    <xmx:XTY9Zta1UcUWnIyhAYeerCbfKg_wQgVNM4Vsry35_Y9jZnYngdGMvg>
    <xmx:XTY9ZnZ0tN7ONANjJVzGmeX_LJjEwisOkYF8jC1C4F5lT6nF57MnQg>
    <xmx:XTY9ZpA2JiVmKSfw06C4g7GRsJkFkDgukqew-Thssr90GcXoDfUPag>
    <xmx:XjY9Zhn4N3_RhJoq78BYrT2kZfHfuVjZCtc-zFZn2pIz4F1pTYYllIcq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A53E8B60092; Thu,  9 May 2024 16:47:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ef3df08-ffc7-4925-82bf-0813c8b0b439@app.fastmail.com>
In-Reply-To: <20240509121713.190076-2-thorsten.blum@toblux.com>
References: <20240509121713.190076-2-thorsten.blum@toblux.com>
Date: Thu, 09 May 2024 22:47:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>,
 "Nicolas Pitre" <nico@fluxnic.net>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Greg Ungerer" <gerg@linux-m68k.org>
Subject: Re: [PATCH] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
Content-Type: text/plain

On Thu, May 9, 2024, at 14:17, Thorsten Blum wrote:
> 
> +static inline unsigned short _swapw(volatile unsigned short v)
> +{
> +	return ((v << 8) | (v >> 8));
> +}
> +
>  #define SMC_inw(a, r)		_swapw(readw((a) + (r)))
>  #define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
>  #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)

I think you can just use iowrite16_be() and ioread16_be()
here in place of the little-endian access plus swap.

Also, it looks like it's been broken for six years without
anyone noticing the problem, so I wonder if there are even
still any machines that use this driver and get kernel
updates.

     Arnd

