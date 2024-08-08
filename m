Return-Path: <netdev+bounces-116887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812694BFB0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB351F2194A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A918A6DB;
	Thu,  8 Aug 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d80Nop4H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5341EA90
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127574; cv=none; b=ujfUhphyKljIZUKNO1vY6A9bnplQbtaH8GU0Jas+XrCMLLDiCDnWU9ShehnTvOB4pmVc5pJWsz4Fq9p2voDAttPZ0fWDtaz1z7qnvWaNi/PPbGXW53Zr5hsPdB6AaFo4HztP1n9103at1sIgD3Us2YcifZ1KBoI409ZpzI4hYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127574; c=relaxed/simple;
	bh=Kg/lHd1XmdJ7P4rkAR1pnicbvqdx0W+obOyMjAlqzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmn90NaOYvvdZMfWeeW86uhnpzCJb5+K0hHCeVhXaiJ5CHcRlMM4GF5o9W+PllFepNTllhCaglKzDoKnQjF17gDcktNkRIt1TRsbvFsE5eKUwU0uHFFy5wfloPyUp3xJSmrlna/CmDPZpstnXlIQvEzSprYuk4DMrmGXsujvxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d80Nop4H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ziJ+9R3tUNQYG36KGiYVzWcbAn7K45SUHPOVNL1mYfY=; b=d8
	0Nop4Hu1v3E3GVfec9QDojQp36JCoNVZYuDGHug9FyhnZvt4zbi10zJmgoDSQu8Ce+7gS5xx/q2JN
	8Yh2GLhxL7D79C6dxvSp9pTvxArYz6Y4xJINkz+bCkDLgTr59jmtXiHExg/MBTVDiQQ1B61be1k1d
	BlL8ZNg6fVJduBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc4C3-004IP0-2O; Thu, 08 Aug 2024 16:32:43 +0200
Date: Thu, 8 Aug 2024 16:32:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
Message-ID: <8e994724-79ed-440b-b543-802fccbe3db8@lunn.ch>
References: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
 <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
 <4CF76B28-E242-47B2-B62C-4CB8EBE44E92@net-swift.com>
 <c98c7d2b-d159-4306-bd26-2999be45e1d0@lunn.ch>
 <D0A7F7D6-38F9-4197-A1C4-3F484A8EC543@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0A7F7D6-38F9-4197-A1C4-3F484A8EC543@net-swift.com>

On Thu, Aug 08, 2024 at 03:23:58PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2024年8月7日 20:58，Andrew Lunn <andrew@lunn.ch> 写道：
> > 
> > On Wed, Aug 07, 2024 at 01:42:06PM +0800, mengyuanlou@net-swift.com wrote:
> >> 
> >> 
> >>> 2024年8月6日 19:13，Przemek Kitszel <przemyslaw.kitszel@intel.com> 写道：
> >>> 
> >>> On 8/6/24 10:25, Mengyuan Lou wrote:
> >>>> When use rgmmi to attach to external phy, set
> >>>> PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> >>>> And it is does matter to internal phy.
> >>> 
> >>> 107│  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit media-independent interface
> >>> 108│  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal RX+TX delay
> >>> 109│  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal RX delay
> >>> 110│  * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal RX delay
> >>> 
> >>> Your change effectively disables Internal Tx delay, but your commit
> >>> message does not tell about that. It also does not tell about why,
> >>> nor what is wrong in current behavior.
> >>> 
> >> 
> >> I will add it, when wangxun em Nics are used as a Mac to attach to external phy.
> >> We should disable tx delay.
> > 
> > Why should you disable TX delay?
> > 
> > What is providing that delay? Something needs to add a 2ns delay. Does
> > the PCB have an extra long clock line?
> > 
> 
> Mac only has add the Tx delay，and it can not be modified.
> 
> So just disable TX delay in PHY.

So slowly we are starting to understand the problem....

You need to document all this in the justification of the patch. This
asymmetric setup is also very unusual, so you should add a comment in
the code explaining it.

For Linux in general, we let the PHY add the delays, and if the MAC
can add delays, we generally don't make use of that ability. There are
a few exceptions, because there are a few PHY which lack the
capabilities to add delays. Anybody with a general Linux PHY
background are going to look at your code and question it, because it
is very odd. Hence the need for a comment.

	Andrew

