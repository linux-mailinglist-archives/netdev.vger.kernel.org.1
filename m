Return-Path: <netdev+bounces-158061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB3A104DE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692087A26CC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681B20F996;
	Tue, 14 Jan 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZA9uCtO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842920F967;
	Tue, 14 Jan 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852445; cv=none; b=Le0hh9nJQz+3WLjbYZ4kUK1Zvn7Cim8IKcZV3CL9KA/Eaj02wYqAZgta53o9btviGayZ3cuT2+7KY11h8oOAqFE0rZ5dgDuDf+2/R3gh6WPRflL+rDf5f1zkkm/ht+Dojbid7g+z3dWn0VqTXvm2Rd4lWirB08eug+M1OGzwknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852445; c=relaxed/simple;
	bh=dy+0OpWkOtKcxdJg/sg6wrwRV6JTQftrjNAVNQZokSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELhaklx0kZdAVsr22xx6jLx4HZRfrGFW6DKXE0oaYwpssYn2bOEKuzXhlCnckQK2tJswZo8+nVYcd2YQWr8hTE9OtSAfPZe1NQS0dgXaKFDRC1cbNek4Am8kXTEamNdlYTHJNJv6DU6mrwnbBZ9pDDteytLotHYaWiTKP+HBzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZA9uCtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AD1C4CEDD;
	Tue, 14 Jan 2025 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736852444;
	bh=dy+0OpWkOtKcxdJg/sg6wrwRV6JTQftrjNAVNQZokSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZA9uCtOCTt/RE+xSaAsObjmPGUG7Goglw+N4gGqBnbKfDfELHs9FL1cukNab2he3
	 +L0JjLeT9U6ZSqajQIxmMTHM6aniGETe6FMI5Y7k2ACSLJWqcOHISxv5rEFdHzM9gE
	 ABkD2iNV58Uo/4paT9ea25YsXaIieDaeiW0C5wBcSOHkCZgCMk4gy4JhyXHMkdKE4h
	 iXdgak+azn3sr6CxEx47SaYNQ1I3bYvs/56SWu329iP2xYygmBPgbWw8RgS5HP/xZV
	 fTtl51v5uzfEKGaGpUWCpWD16rbzsc8kRRKS8T7vQALYfhLu9vb2he13KdeGOn/Wi3
	 y1zAl+dClYjcA==
Date: Tue, 14 Jan 2025 11:00:39 +0000
From: Simon Horman <horms@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <20250114110039.GG5497@kernel.org>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
 <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>

On Mon, Jan 13, 2025 at 06:40:13AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> Add support for configuration via DT.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/net/phy/dp83822.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c

...

> @@ -197,6 +201,12 @@ struct dp83822_private {
>  	bool set_gpio2_clk_out;
>  	u32 gpio2_clk_out;
>  	bool led_pin_enable[DP83822_MAX_LED_PINS];
> +	int tx_amplitude_100base_tx_index;
> +};
> +
> +static const u32 tx_amplitude_100base_tx[] = {
> +	1600, 1633, 1667, 1700, 1733, 1767, 1800, 1833,
> +	1867, 1900, 1933, 1967, 2000, 2033, 2067, 2100,
>  };
>  

nit: The use of tx_amplitude_100base_tx seems to be protected by
     #ifdef CONFIG_OF_MDIO, so the definition of tx_amplitude_100base_tx
     probably should be too.

     Flagged by W=1 allmodconfig builds.

...

