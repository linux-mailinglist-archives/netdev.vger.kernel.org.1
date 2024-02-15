Return-Path: <netdev+bounces-72044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C27856484
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F46B220E8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AC130E44;
	Thu, 15 Feb 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAQiFr7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417E130E3E;
	Thu, 15 Feb 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003752; cv=none; b=V0HLbb0rPnUj1EL5oNt7x54TWAP00eAbxE7E5Y0vjfrZSyh29OtWWGZZ28kbDcFr+2dJEzV48IOiOU+XCt6hQmjjd7+xnHqzBsOYG9Z0Xosl067AymfNLPEZVbwanvetTiqSAU5rbnWqC4ESQ4I/05md8CbjAPFLYcI2cxATnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003752; c=relaxed/simple;
	bh=2+JNMFaL+epx7QSXNjlhcxeVpelRDQbM9W5unaiMKz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4WNOSLHFdWqjJlakJgRA+it1TYfzVZ6n576DMovF8SefEUc9m2PESz1K+oM2T3Kc5OA1YkqF5bg7J56cxw1QFzMGs8R7ibPRRI3ceIArLJNeRINviNkd6WJGCnizP8DEz2OxuuQCPSSjYCdbIzM2D6CB7Zya/t3oaiBBo2kRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAQiFr7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ADDC433C7;
	Thu, 15 Feb 2024 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708003751;
	bh=2+JNMFaL+epx7QSXNjlhcxeVpelRDQbM9W5unaiMKz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAQiFr7mbS4QNKvcSI8zRSYeIiKDDGOdFlqEtaIoIn8g7fDq2/rc2Uy0DbbAF2P7j
	 gX9lwLVEKs9ezTMuD7X7H4N+l2S+YdNpoz6WOYB2wW48jIY/BLCRzbCgg5Uj8Q8nST
	 A07rKoDMYRuHLNCbecuitjot7WeNvEGECq2KFSlnkK9Ks/5aDzssvivXVyd9AoUG8A
	 T9bUlrfM93qaYvlSrnRwqB3IHCJ2nAYYX8q9wHbyHfKcsslQRjDoze5jjtzRSZaDJH
	 1ma93XYKphK7yzErHqTLAmoKWffzWww1JciWnkoxTa03R1NWPLzZQc16cih1lSfLsa
	 mQqQK+DqffKBA==
Date: Thu, 15 Feb 2024 07:29:08 -0600
From: Rob Herring <robh@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h serdes polarity
Message-ID: <20240215132908.GA4004551-robh@kernel.org>
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-2-ericwouds@gmail.com>
 <76f9aeed-9c8c-4bbf-98b5-98e9ee7dfff8@linaro.org>
 <f2b4009a-c5c3-4f86-9085-61ada4f2ab1e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b4009a-c5c3-4f86-9085-61ada4f2ab1e@gmail.com>

On Wed, Feb 07, 2024 at 05:42:58PM +0100, Eric Woudstra wrote:
> 
> Hi krzysztof,
> 
> I mistakenly thought that changing from rfc-patch to patch, the number
> would reset. I will mark the next one v2, or do you want me to mark it v3?
> 
> I have been using realtek,rtl82xx.yaml as an example. I see all your
> comments apply to this file also, so it would seem I could have chosen
> a better example. I will change it according your remarks.
> 
> >> +
> >> +allOf:
> >> +  - $ref: ethernet-phy.yaml#
> >> +
> >> +properties:
> > 
> > This won't match to anything... missing compatible. You probably want to
> > align with ongoing work on the lists.
> 
> As for the compatible string, the PHY reports it's c45-id okay and
> phylink can find the driver with this id. Therefore I have left the
> compatible string out of the devicetree node of the phy and not
> specified it in the binding (also same as realtek,rtl82xx.yaml).
> 
> If you are implying that I need to use it, then I will add:
> 
> select:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - ethernet-phy-id03a2.a411
>   required:
>     - compatible

Don't need any of this unless you have a common/generic fallback 
compatible.

> 
> To the binding, and
> 
> 	compatible = "ethernet-phy-id03a2.a411";
> 
> To the devicetree node of the phy again.
> 
> Best regards,
> 
> Eric Woudstra

