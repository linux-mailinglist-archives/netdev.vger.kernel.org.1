Return-Path: <netdev+bounces-119924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DA957847
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1C1C22E02
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB91DD3BC;
	Mon, 19 Aug 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RJGD7rBo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F23C482;
	Mon, 19 Aug 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108298; cv=none; b=il96qNq7bwXkAk8iOo1FiarfhQtnXLAyIu2j8TPVYPl0B8dzFQYc5BCG9dS2FsyDpW+jU/XD805bsQSXiuZRf0nbghdS+lda1xKqmPdZjSNui0sS7MuEIpwAmvvNxk0K+d0ydjl2hhT+z+qs92025KI73tPkEOw/hs1KmSGAPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108298; c=relaxed/simple;
	bh=2zpRtyrCM3WvctsUskIrs+YRCWM215qiD/1euFsCgl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRFYSzOPv96hPnJUK4z+RXqMe/MWcucRN2eZBa2Q4yfjFlfE2U5vlhfa3243RfZd8D9+Y2c+gp4F7LeHkZRLOq7YKhJQUzyKwSuPOk5LiKGL0T/WGfTcCA4/b2kQCtv5EuYhsNTSEG0/rCLatwcpInUDlCweJOHELZhYeDYlbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RJGD7rBo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RkH4cAyfBpvxAzSzti1m4f3p+s7jZfNcgvRMhIhP9rI=; b=RJGD7rBo9aPzTHCcsFNDSF8ZAe
	YgwbkEhNjKnGjFyaSoMeIGirT6VH6feRoRnrXoeOlX+oBgF/2axxBBOyk/E7z/qrFs7CxjYP+81kr
	OUYDBVQF1qG5pA0tFOBuiJJQWHMagB7zDWb0Yeukd9MOyRgzq0f+WU5OtQs+vklEprww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgBK9-005A4h-1p; Tue, 20 Aug 2024 00:58:05 +0200
Date: Tue, 20 Aug 2024 00:58:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <72e02a72-ab98-4a64-99ac-769d28cfd758@lunn.ch>
References: <20240819222641.1292308-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819222641.1292308-1-Joseph.Huang@garmin.com>

On Mon, Aug 19, 2024 at 06:26:40PM -0400, Joseph Huang wrote:
> If an ATU violation was caused by a CPU Load operation, the SPID is 0xf,
> which is larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[]
> array).

The 6390X datasheet says "IF SPID = 0x1f the source of the violation
was the CPU's registers interface."

> +#define MV88E6XXX_G1_ATU_DATA_SPID_CPU				0x000f

So it seems to depend on the family.

>  
>  /* Offset 0x0D: ATU MAC Address Register Bytes 0 & 1
>   * Offset 0x0E: ATU MAC Address Register Bytes 2 & 3
> diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> index ce3b3690c3c0..b6f15ae22c20 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> @@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>  		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
>  						   entry.portvec, entry.mac,
>  						   fid);
> -		chip->ports[spid].atu_full_violation++;
> +		if (spid != MV88E6XXX_G1_ATU_DATA_SPID_CPU)
> +			chip->ports[spid].atu_full_violation++;

So i think it would be better to do something like:

		if (spid < ARRAY_SIZE(chip->ports))
			chip->ports[spid].atu_full_violation++;

    Andrew

---
pw-bot: cr

