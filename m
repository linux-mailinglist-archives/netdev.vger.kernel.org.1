Return-Path: <netdev+bounces-245133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD8CC7974
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B70303B7D8
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1729B764;
	Wed, 17 Dec 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNMV+RRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91424BBEE
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974086; cv=none; b=swQzKnqpREj8YlknuWOB9gJmdQldJRiXG3FHzbs+xlLIuMH+1ywIJerEmgK8dVx+Euh1fucMAs/J9RUglaw8D8nhEpo4bZ4cMk10MSc7xCluuQzJCmFYvWpUluAsbpJK8dWHa2hiG0L1Jx3ehYqjpAhtqZqoZkZaL7B9zhonVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974086; c=relaxed/simple;
	bh=fny9SFTxturF7015JakyAPXxKQIp2Ma/cwO/hVKlOlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoSVPLuqWKp4fAJPinWCVJ67kurtc32HzGgO1DTKtqUhZOaJPI54Z1EBHGEizDyOeYAyg6kA9LCUDte+gx/MRj8TqfwYPwjeLqVm1EnsohlwxPmvglZgeIqpiuhjoS3GgZADmcbjmchnKKIjUZsong6hR1H6TGYF7K48H4T0NnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNMV+RRd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47a8195e515so46661005e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765974082; x=1766578882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYXq2m6KIBeaHm0Y860B+iQgDTaW343HwilrkCCxiCU=;
        b=SNMV+RRd6noDNpXs2aKVhos/B28mz0h992v9tw4Rb2eWuEIE8FaQlpeELC4w85+Xgx
         3Syxrufaeu+7L2zMEvd0V4ByRSFlmltdrPjyM4UUQKKbyuFXiYvYP6egaqyLaNDaCjYN
         3vt0ZX4VECLqxLzgC95/J8cea2rj9JC/RolhB7sqpY/DSwSm8nvAWtnIGZK1a9i6uMGX
         wZqVwbsmAtEVaGDEr5hdm8ee1cEpi1UXEtJ9TZvF+QveAHcuZziMzxFN0dRb1iwssIlf
         WzUAPnXxbpn1ff7JO+xrDmukXlsfYjjGv2GwQAeDyPEEZ9brEWzmIitMaxTa7BXkdKeS
         NfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765974082; x=1766578882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYXq2m6KIBeaHm0Y860B+iQgDTaW343HwilrkCCxiCU=;
        b=AeAKuZ0+dTxVuUAXxZfXTuB7SPiYg9C235RBoKVySrHGtqwPx8Lomx8Mqk+caZjBeX
         dkc2u4LXq49Jpm1SufaizaQXMz4r9XeIBdbAkxcHaYKveTqu1ik/yA6HofjSwP7HUD/S
         bjmizoplqOIHsCMue3wl9PfxMWbOqrxrcOziIDwiJ8bojXXPaFrVCoM+DdryLrc7xF2b
         FQJ6AlGN7L6K8M2JcYvxynHYJ03/vsVds/Ui+r3tuYL9OiL5QA4IZmmUbGhA6ebNwrJK
         N+ukhRYiQegTF7QQrTxo2ECnCO66gIrmZgmmCVlt1RdyVDKoaDzy6cQ5MfC7YsKvXVft
         3e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkQ6T8F4tGAN6mc5hAnlvUe0fOh7jMQwBqiLAHBqA3qwU41GY/Dq8cme/KEMaGGHdr5hq0gJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTh8ftE5znRvYnuCvh5Ka8tQInS0424QWiekrh43yJbSMb2fDt
	TSAd7ZE4noUuY1zp17s1cdrjCOhap97P/cv4O7withc8xNcCQpdva3zX
X-Gm-Gg: AY/fxX4NFqFttQiOo54a1/lWPvp2uflDtZRCeddF9qMG73X2nnHnfXkLSlPRo5R0EnE
	y12bkZa6Cmz8r4QDfn0LyVqxQBOoSCY3FZTSfuFOEUUEdkhM08oLoxjNGrlnK0GBcdUwhvmqhwp
	dDFaLyMRWSegiS1yzfoLZT+XJvR9dBT8DO6SKOJvcEvVbMOLrjLyscqgn/WHtV7TTzQdd7Fjr58
	VGG+Nv6PdttXdoKeJGoVZGee5BvFXhr3v6MIpUxUd0Lnqdpazyl8ACSENrBVJ9f5BQ2p+TVLC9k
	sGKbSWi14MzrLir762ylGiROHl7HMJAF3D1E6McyU8Lf44mvOebpbg3Dfsn2nO/YZ9Ijh61UsCb
	780GEXO7aUVJBLjhQXu8fEV09mibwdlGkZ+pPMPNNCMYqCirwUuB/joCYIK8w6dhArBLrhjtZGj
	sSnh3foZVI5x8=
X-Google-Smtp-Source: AGHT+IEHnifimtj7VdGfz6MjbhY2lEOpq0xdu6/7cpFkjgiXCk7n3y9Quh4Rc68+jvf5AZydr2IWWA==
X-Received: by 2002:a05:600c:3486:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-47a8f8a79e4mr188945585e9.5.1765974082138;
        Wed, 17 Dec 2025 04:21:22 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:b288:1a0e:e6f7:d63a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1d991fsm37975775e9.5.2025.12.17.04.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:21:21 -0800 (PST)
Date: Wed, 17 Dec 2025 13:21:19 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <aUKgP4Hi-8tP9eaK@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
 <aUJ-3v-OO0YYbEtu@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUJ-3v-OO0YYbEtu@eichest-laptop>

On Wed, Dec 17, 2025 at 10:58:54AM +0100, Stefan Eichenberger wrote:
> On Mon, Dec 15, 2025 at 08:03:30AM -0600, Rob Herring wrote:
> > On Fri, Dec 12, 2025 at 09:46:17AM +0100, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > Add a property to activate a Micrel PHY feature that keeps the preamble
> > > enabled before the SFD (Start Frame Delimiter) is transmitted.
> > > 
> > > This allows to workaround broken Ethernet controllers as found on the
> > > NXP i.MX8MP. Specifically, errata ERR050694 that states:
> > > ENET_QOS: MAC incorrectly discards the received packets when Preamble
> > > Byte does not precede SFD or SMD.
> > 
> > It doesn't really work right if you have to change the DT to work-around 
> > a quirk in the kernel. You should have all the information needed 
> > already in the DT. The compatible string for the i.MX8MP ethernet 
> > controller is not sufficient? 
> 
> Is doing something like this acceptable in a phy driver?
> if (of_machine_is_compatible("fsl,imx8mp")) {
> ...
> }
> 
> That would be a different option, rather than having to add a new DT
> property. Unfortunately, the workaround affects the PHY rather than the
> MAC driver. This is why we considered adding a DT property.

Francesco made a good point about this. The i.MX8MP has two MACs, but
only one of them is affected. Therefore, checking the machine's
compatible string would not be correct. As far as I know, checking the
MAC's compatible string from within the PHY driver is also not good
practice, is it?

