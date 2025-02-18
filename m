Return-Path: <netdev+bounces-167140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066BA39018
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32B27A116F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82061DFF0;
	Tue, 18 Feb 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCxM0oVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F769182CD;
	Tue, 18 Feb 2025 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840535; cv=none; b=I2EpS1zUpq6rQ0uJcUqaAC2jTodAgoXZmx2Xhp7156OkbJOMNsGGdP6mvvf6XR2ylFRDeRWsBJpACXNxyBrAge8TuDK+n2CWDZzJwcMNy9NYiq+Igt8ivfSPCYNe0x+71lvOwtX72olkmVtM+f8meP1mdpLWxM3Y3CToiDwQQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840535; c=relaxed/simple;
	bh=vLGtwfpCTvhL3aUHObITpX3cBQfQEi07taOlT6kCG84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/gdxbBVp54MHQpKzw6Mz//l7siteBRdO2lXyWD27T/itZoReaqir14C1GE2bhKW+zZQEyCqgYjsUtwiDEpEEStDT2yKYbPIO6ByQHtn0dWY1bjuagKaqdiihBNeTjUXkn160akDCKF2LCsFl5xMM+4FEuu9NnirXXgYusprBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCxM0oVU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0ade6036aso10777185a.0;
        Mon, 17 Feb 2025 17:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739840533; x=1740445333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Edn74AFcsuP9KsL9TiLXPO+mD82mDfRGLigRZWWQmH0=;
        b=lCxM0oVUwYmJrl5tm/9nV3qjMVwoT0J0IVKN2/7Nqay7rfUm8Rhif6NsGmJnaJxQhR
         aZUzJLWlWovjE7XDcV82b/jlg0p+k+bHQJaaAnX4Ct5kYeZtgwHxp1cD13PsB9fayr1B
         ZiUTxc2sVH97xmTGaBjGC7cob88golAg5JfGLD0p6gMlJyZrkHVzDu/OsT7RMn5RlxHf
         XNggmRq8yv5DXaUIYVR0d5Ockz2Ri0hly9PN9A3ZxTR1a4f3sfb70nP44sGsAAolb0xu
         AyFaIxwpuVxDg7+T+5dsJNvsUCJPU8A8Dz5IyKO3kEDwJnf6X8muMI8he+rpuAnK5C/d
         lWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840533; x=1740445333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edn74AFcsuP9KsL9TiLXPO+mD82mDfRGLigRZWWQmH0=;
        b=PvM5Bo/eTwNrdG6GoNR7qCYTnaBTX3y5X7bnNliev5/rb0dUbkzHDBSmrnm3KQ6DIt
         L6wB6wm3m4dvbY4rdLLjEy6dEejYSfP9XCaEfDRrH02cspakGctEAuzgfVCXo+qMSE7u
         2brpz4LOt7lUQTokdmnqlITLSRhihCVUs2w34Xo9sM1Y70CqiUf3e9FAl5DiUTwk5kYU
         6AL/KwNp8vp2/26j9A2XkOcL/YxYp9+ngXnCsxs2aPSJjrvk5P1q+QIejz3LmHMtWzqe
         AEafVNUCmDvBk4KL4XopoMulCn2/PWlFnQwgRvFWlsvwSixQ5XJx9Or/i7kdfC2fiFq2
         IrAw==
X-Forwarded-Encrypted: i=1; AJvYcCVoXbsrro8wxHLP/2k+HqGmO147AH7sAv2WZkzY0Fp//E1k5cPNtLIvl9HO6XGbLL6qNsOGgP+v53ap@vger.kernel.org, AJvYcCVtheQP0D/FS+g7tVZcuT8N28nFuBD4Geb3eyZ4n8wIHYQpOx1/xBJM/P12Yar9m3Fa/flxowBn@vger.kernel.org, AJvYcCVxc6y521Nhm2UEu/3kONMuEC2TlwhBYtj/ipaCLhDwT7CzYpTmdnG2GVXIpl5KPelqC5KLDqUeGXlJEI7z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjq9Uh8NsNxqOMlDeItnkgT6geDkVCD9L+HvRvSDDu4zJfYx7i
	ksCYh+OtbgAM98RHH2Qd5qOBWzzYd1NPSRyP2z4QWRoKGZCFZC+k
X-Gm-Gg: ASbGnctjWk7+3AvHbYeDWZvEJNhJaK8oDCLi9puif5CmMNL4PR50V/i2j9Mx8hs5bCp
	0SA4FdrMFbLs6HdvEVDU1ZO4z8yYGU15QpbYDm1x6TnBN2KpRt4tkcbjsCyX8anErq/KjOXTLRO
	vQldQj/xhne7EF2DkxiyL0y7yE8A2SSJuaEK8TSrYaklweNPlkVGvyh9oyVAzczGE7CwR+2YC0S
	NnCo9gWeEo7sBJxUBzNDAFZBS+qPZHnXwQST3SdlvbvwfLF6np+rUAj1nXLdPdGE6Q=
X-Google-Smtp-Source: AGHT+IED0MT/Y3Zl2u3Z7wdGB5LOycEU5pxFY7tKuSKPsLRXNIGrw99KUylS24xgTBikaz1r1N9Tbw==
X-Received: by 2002:a05:620a:3729:b0:7ac:b95b:7107 with SMTP id af79cd13be357-7c07a892c13mr2798593385a.12.1739840532807;
        Mon, 17 Feb 2025 17:02:12 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c608291sm597329685a.43.2025.02.17.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:02:11 -0800 (PST)
Date: Tue, 18 Feb 2025 09:01:59 +0800
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
Message-ID: <6obom7jyciq2kqw5iuqlugbzbsebgd7ymnq2crlm565ybbz7de@n7o3tcqn5idi>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
 <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
 <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
 <Z7PEeGmNvlYD33rZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7PEeGmNvlYD33rZ@shell.armlinux.org.uk>

On Mon, Feb 17, 2025 at 11:21:28PM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 18, 2025 at 06:50:24AM +0800, Inochi Amaoto wrote:
> > On Mon, Feb 17, 2025 at 02:10:50PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > > > > I am not sure all whether devices has this clock, but it appears in
> > > > > the databook. So I think it is possible to move this in the core so
> > > > > any platform with these clock can reuse it.
> > > > 
> > > > Great
> > > > 
> > > > The next problem will be, has everybody called it the same thing in
> > > > DT. Since there has been a lot of cut/paste, maybe they have, by
> > > > accident.
> > > 
> > > Tegra186: "tx"
> > > imx: "tx"
> > > intel: "tx_clk"
> > > rk: "clk_mac_speed"
> > > s32: "tx"
> > > starfive: "tx"
> > > sti: "sti-ethclk"
> > > 
> > 
> > The dwc-qos-eth also use clock name "tx", but set the clock with
> > extra calibration logic.
> 
> Yep, that's what I meant by "Tegra186" above.
> 
> > > so 50% have settled on "tx" and the rest are doing their own thing, and
> > > that horse has already bolted.
> > > 
> > 
> > The "rx" clock in s32 also uses the same logic. I think the core also
> > needs to take it, as this rx clock is also mentioned in the databook.
> 
> The "rx" clock on s32 seems to only be set to 125MHz, and the driver
> seems to be limited to RGMII.
> 
> This seems weird as the receive clock is supposed to be supplied by the
> PHY, and is recovered from the media (and thus will be 2.5, 25 or
> 125MHz as determined by the PHY.) So, I'm not sure that the s32 "rx"
> clock is really the clk_rx_i clock supplied to the DWMAC core.
> 
> Certainly on stm32mp151, it states that ETH_RX_CLK in RGMII mode will
> be 2.5, 25 or 125MHz provided by the PHY, and the clock tree indicates
> that ETH_RX_CLK in RGMII mode will be routed directly to the clk_rx_i
> input on the DWMAC(4) core.
> 

RGMII is not the problem. The databook says the RGMII clock (rx/tx)
follows this set rate logic. 

For other things, I agree with you. A fixed "rx" clock does reach the
limit of what I know. And the databook told nothing about it. As we
can not determine the rx clock of s32 and it may be set for the phy,
it will be better to not move it into the core.

> > > I have some ideas on sorting this out, and I'm working on some patches
> > > today.
> > 
> > Great, Could you cc me when you submit them? So I can take it and
> > change my series.
> 
> Will do - I'm almost at that point, I have three other cleanup patches
> I will be sending before hand, so I'll send those out and then this
> series as RFC.
> 
> The only platform drivers I've left with a call to rgmii_clock() are
> sti, imx (for imx93 only as that does extra fiddling after setting the
> clock and I'm not sure if there's an ordering dependency there) and
> the rk platforms.
> 
> Five platforms converted, three not, and hopefully your platform can
> also use the helper as well!
> 

I think my platform can fit. Thanks for your effort.

Regards,
Inochi

