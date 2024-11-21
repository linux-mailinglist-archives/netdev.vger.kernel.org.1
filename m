Return-Path: <netdev+bounces-146574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC19D46C5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4B8283322
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 04:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D11C6F54;
	Thu, 21 Nov 2024 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MEg8R2aI"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC614A0AA;
	Thu, 21 Nov 2024 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163350; cv=none; b=mGmrZ1E7391mZnG3NIr2fhz0lm6E+cdqAYyscFwNCfjgpsCSY/bq71fuEoLUSfRKgFQyIBXt2TKUACiMKR4OGRBFWXcVX0D1ENXmPevTxFjQipI2wKu17ohRwpkIn/Ux8CKp1DiDrghoL2rfCzKPUEV3+DYR2H7AMEE1oFbQpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163350; c=relaxed/simple;
	bh=mrLmzUmm6ToQPoBGZOkQVodGHG3cbLJ24xAFO3b7XsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkaCmQOrOYrziqxAh8NaqDwfjPuKh5yT+GWBQ5yzoqY1b5fP01kQa9BlhxR+rsrw05X0lLLfUsZLpQBtTKd1TCk3O7u9dtv8h/qsOjq08kp36lRYJGjfU7wsGzlL+uK8ILyCkMopZc04NV0M9uyYz9kxB7ZAp5qjsxPWgPqUUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MEg8R2aI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732163346;
	bh=mrLmzUmm6ToQPoBGZOkQVodGHG3cbLJ24xAFO3b7XsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MEg8R2aItOCsozsPbMgwasrISoK1DySd0kmnMLuGcFIDVypoEzI9axv9SrQU8Bacl
	 w5oxEl18qmEgYoTTTbw0vFb5jkm7oQ/LfWr+PC8qj8RtpDCAzyeDNZVc4YlYRbcSBz
	 IbuOFKez76r76Sq2AIgWeWv4vpqwM3SatVCW5KMDcJQFP2ycHZEZJyNd8nWmOeVzcb
	 qWBenb9nhm9Z1W8cUi9gCX87Iib9fYctRMXeZeP7XBHkzM3c0bvGeGkDoewEwDLkqm
	 5E02JqnKZVzyZfiV2ihQ5/1ZkJd6FiuVuwpXInGUUYMZG5kbE1mXmFQSt0Ej/89sTT
	 tQhcWYvrwZzIQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9CEB16C2B6;
	Thu, 21 Nov 2024 12:29:01 +0800 (AWST)
Message-ID: <944951bb04506e6b131293d634ab7be7417d8827.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, hkallweit1@gmail.com, 
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, joel@jms.id.au, f.fainelli@gmail.com,
 netdev@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 14:59:01 +1030
In-Reply-To: <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
	 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
	 <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 14:44 +0100, Andrew Lunn wrote:
> On Wed, Nov 20, 2024 at 03:13:11PM +1030, Andrew Jeffery wrote:
> > On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> > > When the command bus is sometimes busy, it may cause the command
> > > is
> > > not
> > > arrived to MDIO controller immediately. On software, the driver
> > > issues a
> > > write command to the command bus does not wait for command
> > > complete
> > > and
> > > it returned back to code immediately. But a read command will
> > > wait
> > > for
> > > the data back, once a read command was back indicates the
> > > previous
> > > write
> > > command had arrived to controller.
> > > Add a dummy read to ensure triggering mdio controller before
> > > starting
> > > polling the status of mdio controller to avoid polling unexpected
> > > timeout.
> >=20
> > Why use the explicit dummy read rather than adjust the poll
> > interval or
> > duration? I still don't think that's been adequately explained
> > given
> > the hardware-clear of the fire bit on completion, which is what
> > we're
> > polling for.
>=20
> I'm guessing here, but if the hardware has not received the write,
> the
> read could return an indication that the hardware is idle, and so the
> poll exits immediately. The returned value of the first read need to
> be ignored. It is simpler and more reliable to do that with an
> explicit read, rather than try to play with the poll timing.
>=20
> AS i said, a guess. We need a good commit message explaining the
> reality of what is happening here.

I agree, the commit message needs to be more precise about the
interactions and effects.

Andrew

