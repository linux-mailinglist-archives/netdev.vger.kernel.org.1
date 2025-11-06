Return-Path: <netdev+bounces-236373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C3C3B31B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44311188781A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B830C344;
	Thu,  6 Nov 2025 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VUhGzAK5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4201F4174;
	Thu,  6 Nov 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435320; cv=none; b=anIk5Sx3tAj2cN3m5d1lQpyMADrX8Kg//G0MkZNqmtJS7Xr/tPIJPk1PQ4tWAAIRcGbr5KW7ORsWBA/zRXNpKkod8tu6JEY3DmQy4tFROpHFxiEtQeFZ9y6K9zh2xzHd3hXUu7mFl5aAse2diKNPYKsmyO7kQ/MMEo0z02Ijs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435320; c=relaxed/simple;
	bh=71C0I5n58bGGgCMwPh367yUCxZGV0IWXyE17k6a3ghg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq9NXB5NnXeRAKCK7YKwGBX0qdC92BbMnGm68y4viIPJo8S2fASUm6m5D2l6C4b9zF8F/q5wNsj8ga3poZh79LyFED8BMVW3jo5uuaQBVOmKtHE4EutC1jxnbaWdLQBDgkrEAKMvzSi2ev4CgOtwIVD3N67exm/wN0wd6+48tRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VUhGzAK5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Obyr+hCjQWTwlTchcrrVyCiTRkl+E0+Zq2PR/MmnLlk=; b=VUhGzAK5E9Ac8+xgCI0duVhy8J
	l9UPh5wqigU66Xjmf+jO7CiRITxAKC9li64+7FkvBSpTu3ZFDdCayC/Tedwrdas9lt26LXq2q+Gj0
	Nn+CQT47s+5ftbbKCyvakr0m7VP4VRmXYRG3W95BGjO9s6HmWKXwsC0uVey+UU8y0UtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGzvv-00D7Ld-9s; Thu, 06 Nov 2025 14:21:47 +0100
Date: Thu, 6 Nov 2025 14:21:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Divya.Koppera@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII
 interface
Message-ID: <98bbc307-a61a-4297-85fa-1ff3a71c9039@lunn.ch>
References: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106090637.2030625-1-horatiu.vultur@microchip.com>

On Thu, Nov 06, 2025 at 10:06:37AM +0100, Horatiu Vultur wrote:
> The lan8814 is a quad-phy and it is using QSGMII towards the MAC.
> The problem is that everytime when one of the ports is configured then
> the PCS is reseted for all the PHYs. Meaning that the other ports can
> loose traffic until the link is establish again.
> To fix this, do the reset one time for the entire PHY package.
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

