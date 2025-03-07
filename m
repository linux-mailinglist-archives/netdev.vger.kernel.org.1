Return-Path: <netdev+bounces-172942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E386FA56917
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29112172DCC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB873219E99;
	Fri,  7 Mar 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hyuqtSyO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14307EBE;
	Fri,  7 Mar 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354784; cv=none; b=UmFs16EAp24UdPRxtYUZwfklxpeW7ctxDQoGO1FTYxu/SVari9XsoIqurE0QABhOG62S36qsM0IOU3gvtsf50cFt9z1qkE1JCFq97M6ekbSe3J4DoHHFVeSv12lFSoIa5O2gxlEn7wLQYTRn88JxcFSufX8qumJ8EAE6uj0FyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354784; c=relaxed/simple;
	bh=QUy5vfTIM6uKZnTZYE7wvWBqN6x9Sj+pbPiMHwD/5e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMuZ904hPUYspC7k8CS+UYJ1hIfYslYSZIWWvye1VftXFYzGHjzifu1QIJ4Sz4mBDuVa7gEg+WnMsvn5XoM4yJuJBnW611cg0/z6BP16Q4slw/CUJoIzG9P0uukplbuHyV3rbVH2wdvnOqKeR6sKTmW0PSSeQ1ix/p5DwnK8Mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hyuqtSyO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s9GTymHVEg+tAMrRK+OmorllM5QUFiSEuuL4IEXKdqM=; b=hyuqtSyOvcW7W13WjOtvJB+Lou
	71/g2Z6dTR1MqULxhe/1uBLjtyZ8fqpEdXrpdHD8HJ+g4cd8P7J3KbiYKn2bMOiPkSYDYBayNM+hj
	Z2rGECOQEgjs8xPnupKF+QLMNgWxeixiY7qzW3YGS0DZ0egdXrkCuIov5NJkENGu42Qg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqXvJ-0039Mr-0a; Fri, 07 Mar 2025 14:39:33 +0100
Date: Fri, 7 Mar 2025 14:39:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: phy: dp83822: Add support for changing
 the MAC series termination
Message-ID: <6aee57d3-8657-44d6-ac21-9f443ca0924e@lunn.ch>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>

On Fri, Mar 07, 2025 at 11:30:00AM +0100, Dimitri Fedrau via B4 Relay wrote:
> The dp83822 provides the possibility to set the resistance value of the
> the MAC series termination. Modifying the resistance to an appropriate
> value can reduce signal reflections and therefore improve signal quality.

I have some dumb questions....

By referring to MAC from the perspective of the PHY, do you mean the
termination of the bus between the MAC and the PHY? The SGMII SERDES,
or RGMII?

I'm assuming the terminology is direct from the datasheet of the PHY?
But since this is a bit of a niche area, no other PHY driver currently
supports anythings like this, the terminology is not well known. So it
would be good to expand the description, to make it really clear what
you are talking about, so if anybody else wants to add the same
feature, they make use of the property, not add a new property.

    Andrew

---
pw-bot: cr

