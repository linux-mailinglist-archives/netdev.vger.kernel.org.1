Return-Path: <netdev+bounces-70026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484884D67E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847851C22235
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCA200D9;
	Wed,  7 Feb 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NwvILSEt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83251200B7
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347334; cv=none; b=XKuqv1SRANzLzuPDg2hjILjckhxAyZC3unuqgJGPKh4zquZZZAkmtdDRxSGBQOtb+AJUMDWf5iENqtG4rL5S6KiuVFhRnbiX3WVwztAYRY/LYdC6M7oJA8qhAYpu7u9rmXN794+4St0TRrcd3bD8GnxPCJykgx8CAWP4vizYcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347334; c=relaxed/simple;
	bh=sIrl7RC5as6Qk4MmO9nHlUGq/N05P35DJnEq+3F2VJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l49umPIjb/2tEudL+VilhpooELXUPkq5Gyd7twywZEFJeAfs7tpjo/HNQCNg3zG2OR1XeHp71XcRkMIM79MpjVQB/u7eRTyUYFHpV+gmJ4Ldax/gLr7u0o04lpA648oSD8bfMfElBLqOnPpHxnPnzMC6sU/qX/bOk6BtZ+TcT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NwvILSEt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pGSFLLWm4Qhh2VTIpl0thDD+nAYdmBvjrw7KOCvDeEk=; b=NwvILSEtTPaG8XLSY2pPCgA6US
	PTAa87Ig8spXapIL7B737DAEfBcQiAf27T3jmMbS+9cJ/Z/r/u/jv+dPb/1O7lBQ2cXaBi9tcNYub
	SYRcCiZb8TGakbbjW7KECZWmub7kcQGS7bWD4ebLh0n8c5HPXYIyiv0FznrBrNRlsgWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXr24-007G83-BC; Thu, 08 Feb 2024 00:08:44 +0100
Date: Thu, 8 Feb 2024 00:08:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove setting LED default trigger, this
 is done by LED core now
Message-ID: <47ebdcf1-f55f-4336-8ef9-2bd71d6fdcc2@lunn.ch>
References: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
 <20240207200713.GN1297511@kernel.org>
 <7edda20e-d8a2-4049-81a1-1ef946934bc6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edda20e-d8a2-4049-81a1-1ef946934bc6@gmail.com>

On Wed, Feb 07, 2024 at 09:43:38PM +0100, Heiner Kallweit wrote:
> On 07.02.2024 21:07, Simon Horman wrote:
> > On Mon, Feb 05, 2024 at 10:54:08PM +0100, Heiner Kallweit wrote:
> >> After 1c75c424bd43 ("leds: class: If no default trigger is given, make
> >> hw_control trigger the default trigger") this line isn't needed any
> >> longer.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > 
> > This patch looks fine to me,
> > but the cited commit is not present in net-next.
> 
> It's present in linux-next. Not sure when it will show up in net-next.

1c75c424bd43 was merged via for-leds-next, which is probably why Simon
does not see it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


