Return-Path: <netdev+bounces-156879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B212DA082C5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60153A7FB1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8E204F7A;
	Thu,  9 Jan 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ICjZ0Zb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gehVl9eT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8819ABDE
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461799; cv=none; b=qLt4wtp+31cHK6fewYo9i6yft8iILLSkhYactnwqUaSQv8sLzWJd7To4IUqvtq8cgTMuNjXDr2yu61hLTu0UsbbaK6nwY8dMbkkIZTEm3oT5oisg7ZDRn8Vds1m4Y1SvdkPUyU4BIEdzsbFR40vNH8TjjUKkcfGBpci/sl5KyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461799; c=relaxed/simple;
	bh=hqtfTYrMqc3YxcocIPQa6Nh360Cr7qA5yM12RckNDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZiHn0NL0AzMCbwVy40MR8aowNwb60R5zuLNO56jk6evL+mevl13Mm0cm1p2rV6+LEHtg+OhMxTXNYtvycWAI3OlrVvHXZ16Ay9exf8POmKDM7o4qOooQ5r8uc2z9w53uCS+UXSxNsl++0g9kS3ZPoYhX+69YQhk2XvDkJDjG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ICjZ0Zb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gehVl9eT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A60BA2540149;
	Thu,  9 Jan 2025 17:29:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jan 2025 17:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736461795; x=
	1736548195; bh=BlXH2T5NbGiDRIxkUW0Ws3y3AtLc6YLAFV7X6tF9pyo=; b=I
	CjZ0Zb6DNYIqp19LWZqj7jsSe//ffGmIeLrjC/6n8qnaBeErim1tjj8Lu6q2y+va
	TegYIsMhnp0pe8MtOCoJCIMlJyOjhNVBNEVxHoD0NAg78HvUvSGHF438n/XRVFv2
	jOsl3uyF62qzCy7mLisYJhejCKi3Yh9InQZcAH2gSHUBpJaBvHp9Lunq1hbtgddy
	3h0yqpTIDeVPWkB6G/+oMfev3x+XceSLn7GdkTMs0jr+ACsNkBqoa9AgDGu55nVY
	rDKPQOlxh42AFeq1+5TsRjnDy7YmpJmczDppKeA7AUa60rYbnrgdXPi+j43JyqdR
	PwiR8Ok4ajgd3mPC2nuLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736461795; x=1736548195; bh=BlXH2T5NbGiDRIxkUW0Ws3y3AtLc6YLAFV7
	X6tF9pyo=; b=gehVl9eTrhlc5YOqzeqjMqddelALrUd9dAC6u60i734sHRVLE3T
	qYXkIw5DdvDpBDVRMXGUueBzgoB5QWueEgcafHkt0ZHFPfNy07MxoyBxx5GYw5LF
	GBjZNxkRjqGNsnyXSpOp+JzodhVBAsh3FT6XP//hLhgJLufuAmB1lJwCb4xQzq0p
	Zyd29fw37oYd1WwbmkLm8k+lNNwPicTUyywTYPH9I+dDqLNE8UwJIAO9Y2GB1ca9
	vwSQOdO2nJbQ4IEEGKVFEzTqxkqjr/Aqmy91hohDFjEmfXZIta2CrjFUnjC1Cs+Y
	1430VliWy/KokEr+wP0DeS9cUceTg+/ZMxg==
X-ME-Sender: <xms:4k2AZ9joHJt-Iti23_n5NXAdB03v9ITlZWNiPg4zxRXij7ZBK-lDGQ>
    <xme:4k2AZyBQl0Nqf5h3zI0LAvZ1amy9eUyCppfEWFojzNJcor7rsADC5O07KMsawYJYu
    jviWdCVrLZxLKGXYfM>
X-ME-Received: <xmr:4k2AZ9E1Sk4Kq6jMCI4z_FHnZb2S5h-eHcZnQH8-fmaN38cbUffw4qjZCfUl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghtvghnrg
    hrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvnhhglhhonhhgkedrughonhhgsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:4k2AZyQcgiELLeewTFP5_n3xxi4bKsAc9lu6--QOZ3bOOng4gLOeog>
    <xmx:4k2AZ6wXIo8aHI3uV1pORbOxsgTd6XOVKRlWctup5JV4OoCxxsuhgg>
    <xmx:4k2AZ444Pw4SavpoVZ8kmj6sy0YZn8g_6FiDGPJHf7ac-CCoWw5utg>
    <xmx:4k2AZ_w5QJcV88dXIRen5JMCpOEzJhe86Fsiury4LOj7tkvR_4-0Lw>
    <xmx:402AZ1wi9ZgCClKfsRSOM7R_DXnD6NXzhmZDPNUvMbNfTO8UjbuoOhQF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 17:29:54 -0500 (EST)
Date: Thu, 9 Jan 2025 23:29:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH net] ipv4: route: fix drop reason being overridden in
 ip_route_input_slow
Message-ID: <Z4BN4EHgHcLhxoz1@hog>
References: <20250108165725.404564-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108165725.404564-1-atenart@kernel.org>

2025-01-08, 17:57:15 +0100, Antoine Tenart wrote:
> When jumping to 'martian_destination' a drop reason is always set but
> that label falls-through the 'e_nobufs' one, overriding the value.
[...]
> A 'goto out' is clearly missing now after 'martian_destination' to avoid
> overriding the drop reason.
> 
> Fixes: 5b92112acd8e ("net: ip: make ip_route_input_slow() return drop reasons")
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/route.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Antoine.

-- 
Sabrina

