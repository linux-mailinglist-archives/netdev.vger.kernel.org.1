Return-Path: <netdev+bounces-185555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F3A9AE19
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EC14A0FD1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9127BF9E;
	Thu, 24 Apr 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pquxH5Tc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877027BF6F;
	Thu, 24 Apr 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499465; cv=none; b=DzRVcIt+5X2W9PdJjwBhBqMIBGQB0V7H3Mt359d4yhYS7zxBqoXqd7TSetrZr5J/hb7Ka1njcJDeGpY89TVR018gk4FpdI67/3ZNm2LyX72eh70H6fenzRGJoNceH8Ajgq28H4ttqLoI8Ey5MlsOmkjWp4UX4qKlF4mpgJcOjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499465; c=relaxed/simple;
	bh=J0lIE4vzLnRiJOxdYUmeZR6BncyTaoVNVM9VyFhACGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxB2etga0oLbhqXPQsPq+Mi793bkIV2vFoJYDm2ixnq5/Mqs8WsdfTVrrGb2ww3PH8+VvmZJnxbybTupWNMjgO4KgaSpggvJVJKwp1JF//0M2HHPWXCPmhmeN85+L1N+HdOFRIm1wHhZ932zQeyO2cUUqigE0L8DNY5/7bAowzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pquxH5Tc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ei9FNw6IjtxDnJGtZ0ljQWti041QWdVAFekLHXRFiv8=; b=pquxH5TcA9L1wdWXApkcJYJYcv
	UuJ3wPBl6Qmnm2H3WE6PKIU8sdYhYUPw9ic8jzEr/CfC4/gHksuQ73zK1kAnNeZiQSY6Ul2QErFw2
	D9Fq3/+6GVrOYvNUnytuZRe1jtUZXE60Apy3/Yd/3HF3SongBjPChdvdNGR9KEAHSfBM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7w8t-00ASoP-Lw; Thu, 24 Apr 2025 14:57:27 +0200
Date: Thu, 24 Apr 2025 14:57:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
 <20250424014120.0d66bd85@minigeek.lan>
 <835b58a3-82a0-489e-a80f-dcbdb70f6f8d@lunn.ch>
 <20250424134104.18031a70@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424134104.18031a70@donnerap.manchester.arm.com>

> > Just to be clear, you tried it with "rgmii-id" and the same <300> and
> > <400> values?
> 
> Yes, sorry, I wasn't clear: I used rgmii-id, then experimented with those
> values.

O.K, great.

I do suspect the delays are not actually in pico seconds. But without
a data sheet, it is hard to know.

       if (!of_property_read_u32(node, "allwinner,rx-delay-ps", &val)) {
                if (val % 100) {
                        dev_err(dev, "rx-delay must be a multiple of 100\n");
                        return -EINVAL;
                }
                val /= 100;
                dev_dbg(dev, "set rx-delay to %x\n", val);
                if (val <= gmac->variant->rx_delay_max) {
                        reg &= ~(gmac->variant->rx_delay_max <<
                                 SYSCON_ERXDC_SHIFT);
                        reg |= (val << SYSCON_ERXDC_SHIFT);

So the code divides by 100 and writes it to a register. But:

static const struct emac_variant emac_variant_h3 = {
        .rx_delay_max = 31,


static const struct emac_variant emac_variant_r40 = {
        .rx_delay_max = 7,
};

With the change from 7 to 31, did the range get extended by a factor
of 4, or did the step go down by a factor of 4, and the / 100 should
be / 25? I suppose the git history might have the answer in the commit
message, but i'm too lazy to go look.

	Andrew



I briefly tried "rgmii", and I couldn't get a lease, so I quite
> confident it's rgmii-id, as you said. The vendor DTs just use "rgmii", but
> they might hack the delay up another way (and I cannot be asked to look at
> that awful code).
> 
> Cheers,
> Andre

