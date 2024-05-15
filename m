Return-Path: <netdev+bounces-96595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E627A8C6958
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205411C20B4F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B415573D;
	Wed, 15 May 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Movt4rzK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B185DF3B;
	Wed, 15 May 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785868; cv=none; b=lJfJAFmas6usBkBoiucyUJKkYoeFTkVzC0/hd8RzkGWjXwSl8lr89DB8HKEgbLLR3mNtxWEG3hBbfnFV0RQuM/AN6gojsCtOHFJSUUJo4cYQ9ipKAsgs+GQTi9ixslO/wajJVOAypSwHCOU7M6C5Q8DnUqvpHvgz1aaSoLVk68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785868; c=relaxed/simple;
	bh=29PrztJZldYF2W2DVZi/w2+hJZPuUm3z2k2Ch5n3sjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5Lq4H2dwq+mwY6oeIq+zAqikVbAE+lTXWydauBGMEQUU3bUj35kIPm7ZByejJZQOlVbLthVToMLpAtrmvksYgX4roj03LkMJkUHQq4KHP8EuCgkyQG30qVTCQjB21ZKXzmUW71VnAMWPiqZp8cPxumQgYJ18RnwhdSeR992WOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Movt4rzK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1e9w9yqkxxgBKEE7I+MvdChO+ZAZRqAgVmll2NsjAr8=; b=Mo
	vt4rzKoVlCN2wfo++WXtU3LCg5ZuCVBl1CD0HbT4ueshfpTaWzmLafUQ8HNKF9GgCgC8Z6uanupSy
	jOWUW2Siy8fycsiebaA8l0b4E6xw24SBYbUZGecTXC/RamsY+mF0WQLCj0lQwrHrGYrnd5XQYAq8e
	ocA70c1n+DAUU0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7GHL-00FSaI-2I; Wed, 15 May 2024 17:10:51 +0200
Date: Wed, 15 May 2024 17:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas =?iso-8859-1?Q?Ge=DFler?= <gessler_t@brueckmann-gmbh.de>
Cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
Message-ID: <7b951904-6193-45f1-8878-7bf3ecf83b74@lunn.ch>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
 <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
 <38bc6947-391b-478d-ab71-6cc8d9428275@lunn.ch>
 <338669-229a-5eac-3170-3477e5ae840@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <338669-229a-5eac-3170-3477e5ae840@brueckmann-gmbh.de>

On Wed, May 15, 2024 at 10:15:33AM +0200, Thomas Geßler wrote:
> On Tue, 14 May 2024, Andrew Lunn wrote:
> > On Tue, May 14, 2024 at 02:27:28PM +0200, Thomas Gessler wrote:
> > > The RGMII-to-SGMII mode is special, because the chip does not really act
> > > as a PHY in this mode but rather as a bridge.
> > 
> > It is known as a media converter. You see them used between an RGMII
> > port and an SFP cage. Is that your use case?
> 
> Basically. I would call this an RGMII-SGMII bridge. A "media converter" I
> would call a device that changes the physical medium, like 1000BASE-T
> copper/RJ45 to 1000BASE-X fiber/SFP.
> 
> We have this chip on a daughter card with exposed SGMII lines that can be
> plugged into customer-specific motherboards. The motherboard will have
> either an SGMII-copper PHY (this can also be a DP83869) with 10/100/1000
> auto-neg enabled but without MDIO exposed to the CPU on the daughter card;
> or an SFP cage. The SFP module, in turn, can be for 1000BASE-X fiber,
> 1000BASE-X-to-1000-BASE-T copper, or SGMII copper supporting 10/100/1000
> auto-neg.

The SFP use case is probably not too hard to support. There are PHYs
drivers today which have the needed plumbing for this. Look at the
marvell10g driver, its mv3310_sfp_ops. qcom/qca807x.c: qca807x_sfp_ops
etc.

	Andrew

