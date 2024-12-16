Return-Path: <netdev+bounces-152419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDB9F3E62
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C187318915C9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE11DA10B;
	Mon, 16 Dec 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DiPyhbhF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F51D9592;
	Mon, 16 Dec 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392407; cv=none; b=Awir3Ozh4HukdgaCgnCN33Abr/Rl+TFxAvTIzayRjopP4iQcn/Ym3JYiAZu9Ebo7lMVJLBVR35JBpn3FmhNM1KPMYuh5KDeAaTTyXYKNkx4zP5IdORYlNktuJ1k/8R5Kv/bARk0oDS1rKDf5wWntTE8M0LzRgGgKnPA/x8h/WBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392407; c=relaxed/simple;
	bh=hwFTU+aDrAxRqtfNu17S8fajQDpZT6VQ2Qyi0VlXrWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Tm6v8aL/lu7s79IbbCaaH2zsXPx5GuUwlonbzSv/uDt8/iJMPWbW7uDeL7qIAxlc60Pcrrs1hCNMsW8f34VpQ7II3CaPpQosQ4cm3b6tNlQfB0IKKIA89DP5C8Sw1/sN9uiq0ef72IgtAK1s2uSgMBPGgSAPOpn3YsH07dk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DiPyhbhF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iVv5Akk0Lsj+pfryBSdDLl6/RTTbH+SqQKI/EOqGTdM=; b=DiPyhbhFKha79zYSAZ1EtslcQg
	X0XykpcPfWcn862SSUyRZKiZ9DHEpXq1xKnLFQ1gdCVa2Ay0bofvE76pFMM7mMK3LOmg1iGKPaLOk
	Byw2hENG2fuQCQ8Dn+8YjVJJ38BC0a3llQw7PWtKu0+qfYKX4Q1v9fTAvcERiRGfeGIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNKgX-000m6m-KV; Tue, 17 Dec 2024 00:39:33 +0100
Date: Tue, 17 Dec 2024 00:39:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotiation
 support for LAN887x
Message-ID: <fb90188f-0f9d-4c6f-b5cd-800461dc4626@lunn.ch>
References: <20241216155830.501596-1-Tarun.Alle@microchip.com>
 <20241216155830.501596-3-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216155830.501596-3-Tarun.Alle@microchip.com>

On Mon, Dec 16, 2024 at 09:28:30PM +0530, Tarun Alle wrote:
> Adds auto-negotiation support for lan887x T1 phy. After this commit,
> by default auto-negotiation is on and default advertised speed is 1000M.

So i asked about the implications of this. I would of expected
something like:

This will break any system which expects forced behaviour, without
actually configuring forced behaviour both on the local system and
where the link partner is expecting forced configuration, not autoneg.

I think we also need some more details about the autoneg in the commit
message. When used against a standards conforming 100M PHY,
negotiation will fail by default, because this PHY is not conformant
with 100M, or 1G autoneg.

I don't like you are going to cause regressions, especially when you
have decided regressions are worth it for a half broken autoneg.

I actually think it should default to fixed, as it is today. Maybe
with the option to enable the broken autoneg. This is different to all
PHYs we have today, but we try hard to avoid regressions.

What are the plans for this PHY? Will there be a new revision soon
which fixes the broken autoneg? Maybe you should forget about autoneg
for this revision of this PHY, it is too broken, and wait for the next
revision which actually conforms to the standard?

	Andrew

