Return-Path: <netdev+bounces-216219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5CB32992
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55BD1B66549
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BAD2561AB;
	Sat, 23 Aug 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xsIDvRSi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DC12B93;
	Sat, 23 Aug 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963121; cv=none; b=L83ajsSJcfDSx1Exn5P43Ki++vKCOAUcs2xiA/LuVAiVQcJAi1KjL4Hwe9pSgXXV+bxWPjEBtruqprJvp6M/t4U6eXo41Bz+OYOrkKLEhJkkjVciwYikwAxEz3pd2vuF2wAv9eiwdQsMNy0TxDgXLkMw3L3CteHgvt4QDsq5tZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963121; c=relaxed/simple;
	bh=wXL+pvC99GOHYqNUpRrxI12/+Cl2nzb0cjhP/8jyUa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZyE0szOTKQ1jWXVcoMZGrVgWhmrTqOm3TWsnNtKZ+ESv3NyR/eOoLhjMQCwbZzZCcxTtfrf7uR7dRnm+4pcZJfpqM1OPfpq4bmaF0QiJnSQBwTZPWxT6reI7bQ0mlTktVeL0lhdBERvlhigo1+qCFHc2v14o9cYkELI9w9z8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xsIDvRSi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cf1HMZb2yq2UHmuZrlzPPNb9E3Vkfdo9fJxIjHEBHow=; b=xs
	IDvRSiSLsTe2K8ZZuuLx5hKAuNUguLDOSupOhGYC4b3fchBBTdR6lhv9xNJE+BQuLX/LlSvrONXZL
	1b7ZKSfa5Rf9huE2zoYFPqMBScuDkNQSWyYiLEYh7iqqLUWCzTmSXKp1dbI5MPwowi/QWltdWqD3C
	D0YDo6NDTORbfsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upqDg-005lXW-Oe; Sat, 23 Aug 2025 17:31:52 +0200
Date: Sat, 23 Aug 2025 17:31:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
Message-ID: <a0e637f9-e612-4651-8b12-8cb82dd23c55@lunn.ch>
References: <20250823090617.15329-1-jonas.gorski@gmail.com>
 <4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch>
 <CAOiHx=nC5f9-2-XPCKBVuVsh93NSrmbSQJp8RqF3EObbEq+OOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=nC5f9-2-XPCKBVuVsh93NSrmbSQJp8RqF3EObbEq+OOw@mail.gmail.com>

On Sat, Aug 23, 2025 at 05:27:02PM +0200, Jonas Gorski wrote:
> Hi,
> 
> On Sat, Aug 23, 2025 at 5:00 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sat, Aug 23, 2025 at 11:06:16AM +0200, Jonas Gorski wrote:
> > > For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> > > the ageing time register, but kept the field width the same [1]. Due to
> > > this, the actual ageing time was always half of what was configured.
> > >
> > > Fix this by adapting the limits and value calculation for BCM53101.
> > >
> > > [1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob/master/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
> >
> > Is line 28966 correct? In order to find a reference to age, i needed
> > to search further in the file.
> 
> Hm, indeed, it's #30768. Not sure where that original line came from,
> maybe I miss-clicked before copying the link in the address bar.

Or a new version has been dumped there, changing all the line numbers?
I've not looked, is there a tag you can use instead of master?

> > Are these devices organised in families/generations. Are you sure this
> > does not apply to:
> >
> >         BCM53101_DEVICE_ID = 0x53101,
> 
> This is the chip for which I am fixing/changing it :)
> 
> >         BCM53115_DEVICE_ID = 0x53115,
> >         BCM53125_DEVICE_ID = 0x53125,
> >         BCM53128_DEVICE_ID = 0x53128,
> 
> Yes, pretty sure:
> 
> $ grep -l -r "Specifies the aging time in 0.5 seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h
> 
> $ grep -l -r "Specifies the aging time in seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h
> cdk/PKG/chip/bcm53020/bcm53020_a0_defs.h
> cdk/PKG/chip/bcm53084/bcm53084_a0_defs.h
> cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h
> cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h
> cdk/PKG/chip/bcm53125/bcm53125_a0_defs.h
> cdk/PKG/chip/bcm53128/bcm53128_a0_defs.h
> cdk/PKG/chip/bcm53134/bcm53134_a0_defs.h
> cdk/PKG/chip/bcm53242/bcm53242_a0_defs.h
> cdk/PKG/chip/bcm53262/bcm53262_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_b0_defs.h
> cdk/PKG/chip/bcm53600/bcm53600_a0_defs.h
> cdk/PKG/chip/bcm89500/bcm89500_a0_defs.h

Thanks. That is pretty convincing. Lets see if Florian has anything to
add.

	Andrew


