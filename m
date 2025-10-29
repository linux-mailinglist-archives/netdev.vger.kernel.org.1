Return-Path: <netdev+bounces-233930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6BC1A4C0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD0188A01D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78837DBE4;
	Wed, 29 Oct 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GLdMTMm5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3F375754;
	Wed, 29 Oct 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740638; cv=none; b=Ce5hFveBBJCZsOkhMk8ORvX2oFyMrRGbFOvb3NnBa3kxZ0lWZ1uXyePbHix++FIcdIcgEbnObzoAI2Bt30xLQbohKGct3vKKj++zzes8y7xVPzpbQI9alOjPNMhMekQw+pS9zQBP7spRzzW5Sisl3rVpwuiJST5mml/OEIlYQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740638; c=relaxed/simple;
	bh=vxXTuWk7/yIZErhv/OIuFmCRYOsKBsV8L4JwDDsuQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1oPGKTBxwEQt3tzIa60pwjK7+X2CMwIUkwb8R06ZZVimDPtfpSuXXKG0DowFn3yUdgvcaDgAAv5q9+q2yw02tDb3CS92XqlDd7kYMZl0V8lfYaVpQdp/+srWjVVgKGXMqZPqxaHhTPvGfs4OCTzbDaZ63UB2fAeMmC0KYQ1CEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GLdMTMm5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CA7FHkYc67rF9PMAUrRqXbfA2UpRx4BpJDiWCxDnXP4=; b=GLdMTMm5bKuwGT6dsMDtyHcnO1
	6nsSNv/3XSOG1T0fzgs8PUg8O2rdUdPFPinJBUHoCi5ID0BYel1+5cAy0BDdzMTdK5JvtL3Py1DWH
	We30Y8+luWhDKtEVfq4BeAiCsfdXggJpUtLkk/eMAEtmK0wCUamRlNLYVdLNbjT+jUHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE5DO-00COt7-Rv; Wed, 29 Oct 2025 13:23:46 +0100
Date: Wed, 29 Oct 2025 13:23:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH net-next] net: phy: nxp-c45-tja11xx: config_init restore
 macsec config
Message-ID: <40c9522b-f761-4ef5-880b-5b11cd4b8ba1@lunn.ch>
References: <20251029104258.1499069-1-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029104258.1499069-1-andrei.botila@oss.nxp.com>

On Wed, Oct 29, 2025 at 12:42:58PM +0200, Andrei Botila wrote:
> Any existing MACsec configuration should be restored when config_init is
> called.

Please could you expand the commit message. Why should they be
restored? What is clearing them? Why is this part of
link_change_notify?

By looking at the code i can see what the change is doing. But it can
be hard to say why. So the commit message should be mostly about Why?

Is this a bug fix and should be back ported?

	Andrew

