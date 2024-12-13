Return-Path: <netdev+bounces-151679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7229F091C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2503169918
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAA1B87F9;
	Fri, 13 Dec 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuCo+COU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7941B413A;
	Fri, 13 Dec 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084543; cv=none; b=J00DWYtZo2yvEcoPsZD9CluWsnvm8WXZlUHKmigh+cvN9rqCyN0NDhl1ZOmg0lP3V1l5uu73VeStma3fh2Y/hrertb/ls8K/nofhiPG91NpGDhmnSJcblqXiI2mfqoM7+r5rAdZb/rcIWtfA2eJ/QnJgDza2r0FhLB+mBz3j6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084543; c=relaxed/simple;
	bh=FcDuO+xQqxomYB6F/Fmp9CM6ES57XdPaE+SpIRGRm4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8gfeyYyneBEKlzZv1NRyWNc0cZ8Qy9uLSgR1YCftYNhEkGMZtqX3EBITKwIGTiwyDM49JVAB44O9DCgoK4m4U/lEoS6l2wiQ33Lzk7R2LM2re5Zh3ex62DAL3md64E9hLMpf9ziol7ATwdYa1e2PZEvy2vPYZaWGsTRdBq10Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cuCo+COU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uz92ybMyABO7UIcVN9ORXs2VW98/j7BDjmm3Mn0C9uk=; b=cuCo+COUK6+gh/ZQ1MhBYW/4W/
	biTjqTYa7RtDdO/m/XomLxW210YNXIomw74Gdii2spdbjVlmIJJqc4loDM689AioxGjF5L0luokA5
	GNbX8fnEOcP6oz37JkS37Q6VwoPoiFqqwbfJGHAKtTDMWqtgel1FBQJFdMzVeikZC4XE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tM2bJ-000K2B-2h; Fri, 13 Dec 2024 11:08:49 +0100
Date: Fri, 13 Dec 2024 11:08:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <3ee3f428-b4ec-4b81-8b4e-551b3a957338@lunn.ch>
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
 <20241212-dp83822-gpio2-clk-out-v3-2-e4af23490f44@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-2-e4af23490f44@liebherr.com>

On Thu, Dec 12, 2024 at 09:44:07AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The GPIO2 pin on the DP83822 can be configured as clock output. Add support
> for configuration via DT.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

