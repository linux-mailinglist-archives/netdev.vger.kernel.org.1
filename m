Return-Path: <netdev+bounces-108696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64180924FDD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA21284E3B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2761BC2A;
	Wed,  3 Jul 2024 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kome2z1F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338628379;
	Wed,  3 Jul 2024 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978012; cv=none; b=NAWuUPRTIfJAjQz/jMRiMCcaD2rSh/ab4+ot29PDhYOpjlse/e+ZQLnOi13nbMouwnK/zNOxsXye6uu3m7TVuRPBlawkKunJkULsE3Sz5gFR5cRqv1WycQJq/8UEcuJaPARiziNB8ak1XY3o8oQCQ9X7/qs/3zm1IKBxqj3k6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978012; c=relaxed/simple;
	bh=M3gsERjcbjsNq/Gxcdwyw4WmdX/3lkdL6b5Mc9WmBOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJr6CQBOSOw973ueYu0Kl0yu1gDSHW6cnsfoaeIlXCj3/kcdss3N+w/zYnKaWncqBHgP3p8dxjzKbrzismVcI9DfgmqR5QLK0pO37nE4rPFz729aBuTt4JMMuYQ+c1RPYPSmseM/YFhSckIT7lxtpmg9zAtoiw+SryP1qQHuBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kome2z1F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TATpo3rifH1vuYMWqwmPHFaKqfkHrmIpDNZEDdKjNX0=; b=kome2z1FuUYJlJbL2/gYIegsHG
	12xvgR78xHCIZAO61Qn9kFMcsJf+3jHmUXGNX1zRDxDeJi5cTRh9SICXZ6o36sI1p9f/MqqaowT+A
	Pgv8Q1qEsiCD/5yftsO8i159uaHp8qVgL0PX9p62dkuVE/BaJRI58FZP05uAPKuDE4pI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOqqT-001ghu-GH; Wed, 03 Jul 2024 05:39:49 +0200
Date: Wed, 3 Jul 2024 05:39:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sander@svanheule.net" <sander@svanheule.net>
Subject: Re: net: dsa: Realtek switch drivers
Message-ID: <65566aaa-ba49-4ad9-ab3f-9d49780a809b@lunn.ch>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
 <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch>
 <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>

> One reason for using DSAI've just found is that in theory the RTL930x
> supports a CPU disabled mode where you do connect it to an external CPU and
> the data travels over SGMII like you'd get with a traditional DSA design.
> It's not a mode I'm planning on supporting anytime soon but it might come up
> when I get round to submitting some patches.

You might want to look at ocelot, which is both a pure switchdev and a
DSA driver. Its design is not great because it became dual later in
its life. I suspect it would be designed differently if this has been
considered at the beginning.

	   Andrew

