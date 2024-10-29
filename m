Return-Path: <netdev+bounces-140144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BA9B55D4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC9A28580B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A0209F4C;
	Tue, 29 Oct 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyXPNL53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC202209F5D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241380; cv=none; b=syaDKgt709kLwU9ciVsv7hpQ+3pVVS4kefFmPahcTAQ5x0KtHpMhJFNnSzzC8GTKJnnorN2rSDzLwbF74xCk6SC1clHbKLqEM4nPwvxdsy0BEeIyPOp3nRkxst0V+M+qFfBMkGSRwObrJJEbaTxVyMV3g7h6XQ+blRShgJdr5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241380; c=relaxed/simple;
	bh=n19njbrG7N1xye5xpJJpzvRfoGP8rtO/mO47S4kAg88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFxFkrt3mt58txkDGs/v0Elfdr2t12fj3Dglz2lcb6JemUQZZPLIqiFS3Io14kABD04YJHAjuWREiBTPAWv3MxidWpT78ScbjAIxos4enSZFbAIazcaPN1SichtucBAbEaZnKikaj2Rd/5iIrbwxiz4v9Qk5ABcDK0CZvgGAcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyXPNL53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166FCC4CECD;
	Tue, 29 Oct 2024 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730241380;
	bh=n19njbrG7N1xye5xpJJpzvRfoGP8rtO/mO47S4kAg88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LyXPNL53+PSerqe6d7sjOIpJhx6pS4TrLaGDDQR34qKaP+yxLpxVpePWI2TIGFAgD
	 WGvztcnUuk2SvsOLfXxYIGVrrlJ1WyK7RLObSjXJ0hVydFrDjcEqz4erGva1QDVOFX
	 xvLUZeGF8IJWV/5ilILTSTq/JRayc3x/94yfBkffJgL5A4E4ydeG2jrUIIkeiD5ML1
	 fY77T9YMJCtZCGAWpHgpox7Op7nryQXQLUJHPKAVNuHGd32+2zMrzAHDXSePIspn/w
	 5V218FtbxsC4IzIRVnVPoZemDJFggz9rKy2z410xTkuqUwR/pQv1ftZDiGKkGleMfr
	 t4VSrfAF5M5Aw==
Date: Tue, 29 Oct 2024 15:36:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after
 free on unregister when using NCSI
Message-ID: <20241029153619.1743f07e@kernel.org>
In-Reply-To: <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	<20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
	<fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
	<0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 12:32:53 +0800 Jeremy Kerr wrote:
> As the ordering in ftgmac100_remove() is:
> 
> 
>         if (priv->ndev)
>                 ncsi_unregister_dev(priv->ndev);
>         unregister_netdev(netdev);
> 
> which, is (I assume intentionally) symmetric with the _probe, which
> does:
> 
>                 priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
> 
>         /* ... */
> 
>         register_netdev(netdev)

To be clear - symmetric means mirror image.
I agree with Andrew.

