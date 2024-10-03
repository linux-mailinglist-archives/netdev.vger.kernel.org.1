Return-Path: <netdev+bounces-131636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EA98F16A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55351F21122
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8119CD0B;
	Thu,  3 Oct 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CWAFs5lO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAD154C0F;
	Thu,  3 Oct 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965835; cv=none; b=crnWBhbw0rP//mBCmLS8qLplDJ6bL6hAN63DGoUyCpAi+RbVNfkghtGdiLOP/sn8zpake8UmfvCLhjIwdAmu9yk6Pay7t5Mji1ZHpT4ZPhfHHkVt09NA7rirYTaIGRPIQdBmJ01n5UOMJSHPo31wXHCqlQI0fiPMaschZA5QSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965835; c=relaxed/simple;
	bh=Kt/zxTObtIhsH6nu6Fr+XIWm1MDAxBJCPQbwGL1FBRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFTTe/fdPWmYkviWwI1cIBPS2aNUaNVtV0bkwY+KClj2EYO+iSz3lmrpo7+3cTf0MalAE6zLhEN6mXQn2P9c5go0mcGSdcFq54DOcncX7pQYR+YBCLRMRZgEDOhakY8rKzLjlqN7jY2mfm387KbsEc6Ib6punAwfin6j+hXPRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CWAFs5lO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bhuIm46xY6cy3xTiaQHo5/KNUnRzYH4635NOH1AsjVA=; b=CWAFs5lO5zWxNrQJ8hdtVvpM35
	YuVCzF5kI2GD67kLXD5+stfz9mXd8StVNqx9dRXh4q3AW+bi1jVnLA3H1ccrpDccdp31jAqALJGin
	xndcIiFRUNgYKEpe5cBeNfeG2+gNk9khSMdwxCRUqA2qU55nkKCh6san+aOrZT/x8Gfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swMqR-008xEd-AU; Thu, 03 Oct 2024 16:30:19 +0200
Date: Thu, 3 Oct 2024 16:30:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Message-ID: <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003022512.370600-1-qingtao.cao@digi.com>

On Thu, Oct 03, 2024 at 12:25:12PM +1000, Qingtao Cao wrote:
> On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> activated, the device assumes a link-up status with existing configuration
> in BMCR, avoid bringing down the fibre link in this case
> 
> Test case:
> 1. Two 88E151x connected with SFP, both enable autoneg, link is up with speed
>    1000M
> 2. Disable autoneg on one device and explicitly set its speed to 1000M
> 3. The fibre link can still up with this change, otherwise not.

What is actually wrong here?

If both ends are performing auto-neg, i would expect a link at the
highest speeds both link peers support.

If one peer is doing autoneg, the other not, i expect link down, this
is not a valid configuration, since one peer is going to fail to
auto-neg.

If both peers are using forced 1000M, i would expect a link.

   Andrew

