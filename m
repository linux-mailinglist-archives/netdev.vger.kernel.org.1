Return-Path: <netdev+bounces-132401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83020991862
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E636B20BB3
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72226157A7C;
	Sat,  5 Oct 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VERdIoIa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596E14F125;
	Sat,  5 Oct 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146633; cv=none; b=jcjG6NCU7bGLzhv6KTZ0LPZb0n9v+VOtTcSmqnRMR/7YsQJx5lccw3G8fszmORpaapD4liPDVpiDDjfksvTxvpmcUQHjzZptFJU0wfPQigYQ8BKGRiCdFgZCD0irAbzY1vEKItBHbGk2Zj2MhBy/b1M52ZAjx47U+FcTrTXcuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146633; c=relaxed/simple;
	bh=bK8KRtp69Xe5XP3uPaSL/BuejAl7Es8uHX4gIKtomGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9pqrWi8TP+8qzwrZ+nw0jFZn/xCPXssAswYnpA9ATIWCR2W/NHL5aCgoOEZhlePspZ+g1NDXXgTUwaxetXBoDMm/TFrE2o1MIl1JyAFqqGYvfXwad+dhtSAYenaMLRAQEh5PZLS6FbRpjriGVQK+h8d7jgnHUm3LFCjJOgzmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VERdIoIa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dPtkJXBGaDHkzM7BXi1yJh4k9iNNBXd7xeF+C8idGS0=; b=VERdIoIalkb7JNzlDa9AHFV71P
	qVwOce1M/VOkS0AfrxZ82dzYNnfO6llsW991BUmd54ypnaca3rJ30/gw+R9WKF3IuGOLDkUyDtWzD
	T1qOJZZpHvycX/BraqFBG87C7ZdlAtuiz7aTl0MKEfvcebqeFCcOCAnBYm04ffliQab4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx7sb-0098tk-6e; Sat, 05 Oct 2024 18:43:41 +0200
Date: Sat, 5 Oct 2024 18:43:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Qingtao Cao <qingtao.cao.au@gmail.com>,
	Qingtao Cao <qingtao.cao@digi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/1] net: phy: marvell: make use of fiber
 autoneg bypass mode
Message-ID: <e68c2806-8058-4669-8f47-726ddb60c90a@lunn.ch>
References: <20241004212711.422811-1-qingtao.cao@digi.com>
 <ZwBj-3t6S3SL9Fyu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBj-3t6S3SL9Fyu@shell.armlinux.org.uk>

On Fri, Oct 04, 2024 at 10:54:03PM +0100, Russell King (Oracle) wrote:
> On Sat, Oct 05, 2024 at 07:27:11AM +1000, Qingtao Cao wrote:
> > 88E151x supports the SGMII autoneg bypass mode and it defaults to be
> > enabled. When it is activated, the device assumes a link-up status so
> > avoid bringing down fibre link in this case
> 
> Please can you stop posting new patches while there is still discussion
> going on.
> 
> I'm simply going to NAK this patch, because you haven't given any time
> for discussion to conclude on your previous offering, and I see no
> point in even bothering to read this while the whole subject of
> whether AN bypass should be used is still unsettled.
> 
> Please wait for discussion to conclude before posting new patches.

+1


    Andrew

---
pw-bot: cr

