Return-Path: <netdev+bounces-129323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B212797ED8D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D5281CB4
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85481749;
	Mon, 23 Sep 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZBlSltin"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980D1CA84
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103767; cv=none; b=i8FOt3I4hHa6GtQCwZ+qW3XbMxkoBbVLEaKPMAF7azYk0wrfaS2hQyeW9+4LLt+xEL4bpT2r2WdTrftHOBeC3rOyqlhFFQwsDRJ1rLzGnhYpQXRwcZGbArKNki2IIAYmgxItaZgmwYyma3hdkQjzrPvyAXv277wYFhMPGQjGPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103767; c=relaxed/simple;
	bh=Vu0qZ487BLK9YGNzTsWJhWdNot/byiIn/Rlq9Lr4OwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjv0UBh3pDM+NeOiCWXC9d8BC2LqCtZTERyPr+a8bQ5XgGC1nCFSGK83+dgLv4C5f+MUpLKXCauPHWC875f9gxlZZc1Jnc/BcQ99BjN9BZu3xmxscMocecZ379N+ckubN+XtvukSZ3EgM/xOkCidkaUeW08MkysfQVwaUB6x3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZBlSltin; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE3151BF203;
	Mon, 23 Sep 2024 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727103763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+ydyGmUsv6CKlgCdcUxLShZ5R58rZaOXUnePmMbVbM=;
	b=ZBlSltin2yU9Kt/xsqkUDtayEVikt1r3Pmnd2M/0l/vLWP3k5BaTiOB76k6lkLfO5jKK5Z
	IMdZaD1EF9TzutwoRyGvs97ON2WEXApuUBPu7GhPSrL97yixjU4rCj1BGgQpin6Hi8w93x
	SnvM01pvFfnP9mqBdw2LZFZpuwEPVesygppRGAyKbcLbQLZzn4Eq1Wq8OzymhtvamOJgDk
	KK2rQKmERU1/+wySSdMORxNSWPz/AYhHlICmMzrRuKVDSP76k0/zqbCsyeZMgs68Tz8X75
	+AOZ/dM1jBn2/ur3r3OCUk0xOtDXbKtl0NGcMmgX8BbAZIzBjB3DCakmNNRFxg==
Date: Mon, 23 Sep 2024 17:02:39 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>
Subject: Re: [PATCH RFC 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <20240923170239.5c1bcfc7@fedora.home>
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Mon, 23 Sep 2024 15:00:26 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi,
> 
> First, sorry for the bland series subject - this is the first in a
> number of cleanup series to the XPCS driver. This series has some
> functional changes beyond merely cleanups, notably the first patch.

FWIW I've reviewed the whole series, to the best of my knowledge this
looks fine, nice improvements. I don't have any means to test however.

Thanks,

Maxime

