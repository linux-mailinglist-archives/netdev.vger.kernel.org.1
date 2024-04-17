Return-Path: <netdev+bounces-88594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62168A7D32
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E481C20336
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1936CDA6;
	Wed, 17 Apr 2024 07:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD63F516
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339373; cv=none; b=R8W2WA5NJ27XkhdsxvsOYr7LI+tZkEJ/9oIou2kCcCy8Y6SnJ/FzUeuNubuxCckaEkP6ygmY9A3at8yDFXQQwnJdoCS05lVQXyKLdkUpCWGokKmZVjdINcTptWeBbP05PiLKaDBerJXdcbv0fjzqC9Je4vWxVOSJfxtyzjMWZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339373; c=relaxed/simple;
	bh=siZkua4XZaF2v2JoHWneSFI0DVRfWkp8m5BYQLNbGYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExC0X5dx0A2Fpw+h8l7cIcfKBAx67ItCKsTISrSdi2hwR7yoyQ10zyCozRfc+l5aj1H5nwtBPMpYc1hmsOdjrAUFq5wr2ZMWNqnI0ba8XsOj421OxgbKXrgoulg0C3qw8/VGu7fQJGgSzDPLygVjg9HAw8d6g0snpGjgzrnrb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 09B1528011608;
	Wed, 17 Apr 2024 09:26:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D2F7E32453; Wed, 17 Apr 2024 09:26:36 +0200 (CEST)
Date: Wed, 17 Apr 2024 09:26:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <Zh95rJqViOEpR40k@wunner.de>
References: <6b6b07f5-250c-415e-bdc4-bd08ac69b24d@gmail.com>
 <ZhzqB9_xvEKSkMB7@wunner.de>
 <20240416164113.3ada12c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416164113.3ada12c7@kernel.org>

On Tue, Apr 16, 2024 at 04:41:13PM -0700, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 10:49:11 +0200 Lukas Wunner wrote:
> > >  struct rtl8169_private;
> > > +struct r8169_led_classdev;  
> > 
> > Normally these forward declarations are not needed if you're just
> > referencing the struct name in a pointer.  Usage of the struct name
> > in a pointer implies a forward declaration.
> 
> Unless something changed recently that only works for struct members,
> function args need an explicit forward declaration.

Not for pointers:

   "You can't use an incomplete type to declare a variable or field,
    or use it for a function parameter or return type. [...]
    However, you can define a pointer to an incomplete type,
    and declare a variable or field with such a pointer type.
    In general, you can do everything with such pointers except
    dereference them."

    https://gnu-c-language-manual.github.io/GNU-C-Language-Manual/Incomplete-Types.html

That's the case here:

    struct r8169_led_classdev;
    struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev);
    void r8169_remove_leds(struct r8169_led_classdev *leds);

In this particular case, struct r8169_led_classdev is only used as a
*pointer* passed to or returned from a function.  There's no need
for a forward declaration of the type behind the pointer.

Thanks,

Lukas

