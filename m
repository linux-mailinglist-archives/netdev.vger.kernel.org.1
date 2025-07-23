Return-Path: <netdev+bounces-209333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFAB0F342
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4425558489F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BC2E7BD9;
	Wed, 23 Jul 2025 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jr7bwJZN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4E2E7BAB;
	Wed, 23 Jul 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275935; cv=none; b=eECpLCtsfsQTAFeVulH+vXgkmKo5KtNiQCdkH6M5xkxBN0qfDeu6iZlmoGP5uJ78T2SOb0OX0UxHNNfslAMKgtsvPDU8GhIcKhYE1z0a1T4+mrO/NZ8IZ9rJImCaVPleAfg0Es0D/vlVgRrbtZ7ZpsESKn9az+sfHfYSTKsUdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275935; c=relaxed/simple;
	bh=IdcktKmEjcx6wvZMEdLZX/htZymYVnF2tws+dZFxCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGt8W0U3BZUuE2Ezc2QcBGm23a/TXk7rVoUNR3Orq+PRYiSOml8zEUBQfMtMK1na1mTxFhpDeUTvi2NGX42C6STZq8kv4BJZmdKxKzV6CRkdmLg1u1poNZP8tunqiqf1LKmWdzwuSaAkbvJr9tRvWTbU/VEGUSHZQtkDe3Db1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jr7bwJZN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UrceJ7ZoyDj1MZAtLYt+fw215tZ59xeFRl70jTAzH2A=; b=Jr7bwJZN7gw2GfWM1YEsOSAQkr
	vfaLJ1ngI6e0wfJCwqO1bzAIqAlBTWlK3R1a/DjDNje3815nFdqKgArObXbyqP+mkFMfFiSzquPFP
	OXZc+2hXmE2dXveRnv80Rdq6jtGenm0E8pSCrxKbSZ1tgDBx6LwD+DC4rTSOXjexCUFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueZ9z-002Zeq-Mm; Wed, 23 Jul 2025 15:05:27 +0200
Date: Wed, 23 Jul 2025 15:05:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
Message-ID: <d8852211-e3ba-4c9e-a9ab-798e1b8d802e@lunn.ch>
References: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
 <20250723012926.1421513-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723012926.1421513-1-yicongsrfy@163.com>

On Wed, Jul 23, 2025 at 09:29:26AM +0800, yicongsrfy@163.com wrote:
> On Tue, 22 Jul 2025 15:06:37 +0200	[thread overview] Andrew <andrew@lunn.ch> wrote:
> >
> > On Tue, Jul 22, 2025 at 10:09:33AM +0800, yicongsrfy@163.com wrote:
> > > Thanks for your reply!
> > >
> > > According to the "Universal Serial Bus Class Definitions for Communications Devices v1.2":
> > > In Section 6.3, which describes notifications such as NetworkConnection and ConnectionSpeedChange,
> > > there is no mention of duplex status.In particular, for ConnectionSpeedChange, its data payload
> > > only contains two 32-bit unsigned integers, corresponding to the uplink and downlink speeds.
> >
> > Thanks for checking this.
> >
> > Just one more question. This is kind of flipping the question on its
> > head. Does the standard say devices are actually allowed to support
> > 1/2 duplex? Does it say they are not allowed to support 1/2 duplex?
> >
> > If duplex is not reported, maybe it is because 1/2 duplex is simply
> > not allowed, so there is no need to report it.
> >
> 
> No, the standard does not mention anything about duplex at all.

O.K. So please set duplex to unknown.

     Andrew

