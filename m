Return-Path: <netdev+bounces-167308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B6A39B15
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589E83A5C4B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5923956F;
	Tue, 18 Feb 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFRCn7nY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6962309A1;
	Tue, 18 Feb 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878505; cv=none; b=J/trhrWliuHSHI7Sc21VEED/uPlWCvjc4M1B3E3Q4tRX7jDGwOWN+zHTQvPLR2fBhElSzZRSkKC+u1od7YABAIGf6H6IjBUyFRTrwYW2WS/5vWPo+PK2PoUxWG98lzYKuTv2REh35rpqJ9n8gwVbPPqqmlIURgi+NAZiIj4xQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878505; c=relaxed/simple;
	bh=0Ooo78SXds6E1nnEquaFe/2Vk0UC6/lAqlJ+KmDmEl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwl/yqylQCWjhuvmY+yBx5UKRF2tDWSRqoMnQKs0kmM05Zcz+FDhNaGcj6zuLbEJ3sB8zdgmdNSeEfz8+qPHEzA51VymMxVFq0ti+avLZJnLrRCaPEO+4gpahSurkcmyFriW3URsVrMcFuKAeJGeC+JGEzaD8ZBicTDw8Z2+5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFRCn7nY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471f686642cso13027721cf.2;
        Tue, 18 Feb 2025 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878502; x=1740483302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afaSq1n/9Zx2C/a6yp1UZpzU8FTiNXOckROl9W+xe1U=;
        b=LFRCn7nY4wSYpdYikwLE6F4lT4hQ586RRoeh/R1ehbFwBUh1Ds8yTjFIXBNrFuurSF
         V1MZbLYrGIserlJy7NXMerGuAhYytdHFMZF4rMwREIvgHJqnRJZLAYIq7l77Ku7uQ49G
         ZubIWCiPh/TrMuhxAjdxAgcFT77nUhHgGJuu8OClB9Oh7IcfsTtDAA7+33knaP7VgTRe
         wY+46MxnSUvchg2Mbb5UMHQK0xI7zVcQ8fmQaEkg9+x4y70bv2wFGxAZ+wEsiZKu1Bd5
         FjWUB92o50rdMSuS+L+YqWpnshzbY9V6OleZKpciZmJ7kFmT86fRbLYH0t1MqdKtlpkd
         gMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878502; x=1740483302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afaSq1n/9Zx2C/a6yp1UZpzU8FTiNXOckROl9W+xe1U=;
        b=jYGoj3+8VDhY+7VIeo+g0RcDSgin/+9zg/NMcuqHN4TeeYlf7rUKAh9rk92jThb1C/
         axys8Rb5fSz+pEKKzVmdJNhB1bXpE1QsmI9Uw3nD5AU85KQcur/6htCShILhUtnRSgfw
         KFNvNbqnFKl/2Qk37dD3n0d8Ir0bjl1WWdWfURJpJhKkITBb1l4/Mbbja9rTUGLajwS5
         79ePfu7RjEEoU6SIpZ0/6Szp/oa1la5yTr+fQlVUZFpnHbi+Q70s8jGNW513k3u7CNpp
         8IZXJaBhhZIedt/tYdiHJRhgmr/LN5yK6FvUe5FiGuP7nmcMEZva6M3s85OmucMoKBbQ
         S38A==
X-Forwarded-Encrypted: i=1; AJvYcCUb/XnineksvmqnGcWrfFLZ9dIO5pnmmnhOrBqaOA8xyOuNLSV3UPlRvy3k4uBX32FiRD8+OR/VWFlVvW2L@vger.kernel.org, AJvYcCWemLGru0v5ug8vP4KIRC0ouhYpHXpfdG0Po91JybHdHMCADIolFIf/IFzS8Izo7j7dYLUL9KLb@vger.kernel.org, AJvYcCXT7zWBQ23pwjC9sXcsOHWjEcxZneT6RRqPqLH5Ci9x8KXYsgjr4ucoK4XYFyk0g5R2aDOTHaxlGzlf@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9WES3IQkGe1vTRV6Jp+h6AOrFYQ54SmXoFFCJONRPwZL+Xbd
	HPrY2AsXaKcO2iKw84ycbZ4qrYswfOeGWP3oSfd81yF2p0eCv7iR
X-Gm-Gg: ASbGncvCH+ufD8i/EuVJVfE/75t34o1eLHX+xkW/6NRqTCVk9p3kckIcwKTgyfI497h
	ozGPOwHkLzXTa/h6GgxsK/ioiYNTCiw6fBhpGf9rL/LM+0WgaTvEKNzUUn/Y+bwNPkgdFe6awLt
	UrDqmrOPknz/x0vO7so43VHIUBnz9Ap2q6a/iOIvjKYW1bCZuahYJtBxjFkAxdXCZpeUpgv3BEN
	2NCm64v21wu06kgEAYXT57KWn3qDTupOFJabW27gSaIuf848+gSWHjMqWtpMprHaQw=
X-Google-Smtp-Source: AGHT+IFe6C/gSNnzxL8kV6UCXZr3P6tf9lX30/uxdZgxSpgJktrmUiTn4Zw2m+FrVeltIJ8PDsdvvQ==
X-Received: by 2002:a05:622a:1803:b0:471:9cba:ad2c with SMTP id d75a77b69052e-471dbcc2e05mr196823821cf.11.1739878502351;
        Tue, 18 Feb 2025 03:35:02 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471f2b0476dsm19857671cf.28.2025.02.18.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 03:35:01 -0800 (PST)
Date: Tue, 18 Feb 2025 19:34:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, Furong Xu <0x1207@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Serge Semin <fancer.lancer@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <thc5oknaqaw54wghyxpx6nr4kbykxvpgkgvpqsnsp2osjlxgwv@dekgtkxoywrm>
References: <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
 <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
 <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
 <Z7PEeGmNvlYD33rZ@shell.armlinux.org.uk>
 <6obom7jyciq2kqw5iuqlugbzbsebgd7ymnq2crlm565ybbz7de@n7o3tcqn5idi>
 <Z7Rjjo5nZ0gnCbzq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Rjjo5nZ0gnCbzq@shell.armlinux.org.uk>

On Tue, Feb 18, 2025 at 10:40:14AM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 18, 2025 at 09:01:59AM +0800, Inochi Amaoto wrote:
> > On Mon, Feb 17, 2025 at 11:21:28PM +0000, Russell King (Oracle) wrote:
> > > On Tue, Feb 18, 2025 at 06:50:24AM +0800, Inochi Amaoto wrote:
> > > > On Mon, Feb 17, 2025 at 02:10:50PM +0000, Russell King (Oracle) wrote:
> > > > > On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > > > > > > I am not sure all whether devices has this clock, but it appears in
> > > > > > > the databook. So I think it is possible to move this in the core so
> > > > > > > any platform with these clock can reuse it.
> > > > > > 
> > > > > > Great
> > > > > > 
> > > > > > The next problem will be, has everybody called it the same thing in
> > > > > > DT. Since there has been a lot of cut/paste, maybe they have, by
> > > > > > accident.
> > > > > 
> > > > > Tegra186: "tx"
> > > > > imx: "tx"
> > > > > intel: "tx_clk"
> > > > > rk: "clk_mac_speed"
> > > > > s32: "tx"
> > > > > starfive: "tx"
> > > > > sti: "sti-ethclk"
> > > > > 
> > > > 
> > > > The dwc-qos-eth also use clock name "tx", but set the clock with
> > > > extra calibration logic.
> > > 
> > > Yep, that's what I meant by "Tegra186" above.
> > > 
> > > > > so 50% have settled on "tx" and the rest are doing their own thing, and
> > > > > that horse has already bolted.
> > > > > 
> > > > 
> > > > The "rx" clock in s32 also uses the same logic. I think the core also
> > > > needs to take it, as this rx clock is also mentioned in the databook.
> > > 
> > > The "rx" clock on s32 seems to only be set to 125MHz, and the driver
> > > seems to be limited to RGMII.
> > > 
> > > This seems weird as the receive clock is supposed to be supplied by the
> > > PHY, and is recovered from the media (and thus will be 2.5, 25 or
> > > 125MHz as determined by the PHY.) So, I'm not sure that the s32 "rx"
> > > clock is really the clk_rx_i clock supplied to the DWMAC core.
> > > 
> > > Certainly on stm32mp151, it states that ETH_RX_CLK in RGMII mode will
> > > be 2.5, 25 or 125MHz provided by the PHY, and the clock tree indicates
> > > that ETH_RX_CLK in RGMII mode will be routed directly to the clk_rx_i
> > > input on the DWMAC(4) core.
> > > 
> > 
> > RGMII is not the problem. The databook says the RGMII clock (rx/tx)
> > follows this set rate logic. 
> 
> Sorry, I find this ambiguous. "This" doesn't tell me whether you are
> referring to either what s32 does (setting the "rx" clock to 125MHz
> only) or what RGMII spec says about RX_CLK (which is that it comes from
> the PHY and is 2.5/25/125MHz) which stm32mp151 agrees with and feeds
> the PHY's RX_CLK to the clk_rx_i inputs on the DWMAC in RGMII, GMII
> and MII modes.
> 

What I said follows the second, the clock is set at 2.5/25/125MHz
with speed at 10/100/1000Mbps. The only thing I can refer to is the
ip databook.

> clk_rx_i comes through a bunch of muxes on stm32mp151. When the clock
> tree is configured for RMII mode, the rate on clk_rx_i depends on the
> MAC speed (10/100Mbps).
> 

OK, I have no problem and find some descriptions related to this in
the databook.

> This suggests as far as the core is concerned, the clock supplied as
> clk_rx_i isn't a fixed rate clock but depends on the speed just like
> the transmit clock.
> 

This is what I want to say. clk_rx_i is not fixed but the
s32 uses it as a fixed one (This is the thing I felt weird).

In fact, Non-fixed clk_rx_i is why I suggested adding the rx
clock to the core at first. Since the drive may not use rx
clock as the databook says, it is good to leave it alone.

At last, it seems like that I need to improve my statement.
I am sorry for it.

> > For other things, I agree with you. A fixed "rx" clock does reach the
> > limit of what I know. And the databook told nothing about it. As we
> > can not determine the rx clock of s32 and it may be set for the phy,
> > it will be better to not move it into the core.
> 
> I'm intending to leave s32's rx clock alone for this reason as it does
> not match what I expect. Maybe on s32 there is a bunch of dividers
> which are selected by the mac_speed_o signals from the core to divide
> the 125MHz clock down to 25 or 2.5MHz for 100 and 10Mbps respectively.
> As I don't know, it's safer that I leave it alone as that means the
> "rx" clock used there is not clk_rx_i.
> 

Thanks for your explanation. This is OK for me.

Regards,
Inochi

