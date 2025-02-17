Return-Path: <netdev+bounces-167114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E3A38F4C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FAC16B9BB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16591ABEC7;
	Mon, 17 Feb 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhVC+Hsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD41A9B5B;
	Mon, 17 Feb 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832638; cv=none; b=NbIzMPb0PQGXQpFJ6mvHf2bC8zCs5vLJwU2MUaVweHoF0W3F+Sd+JqRoHCD2KNBQioqsWdSKdxW+8et0mOgfe+hpBETu2Ia6XFOMz4H/hMtH0RHsdXQk8zlnKvZZwxkZ4BZxyrrj/zm0WmUmL8FBj4hkwVoaq4rpsDpE3mb38Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832638; c=relaxed/simple;
	bh=/6SGeRltRm31xAdkNm0gzzyt7aeAn431Szrtm/7AyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/wuiKj4ZWWN27dTJ0dKkzHdLRmO3pOjGuIOnd+nc376fSdxy7itad+HzVjYQcmFg99SHMoPRyxNFI1KfhUa2DBu+pm0Et0BqsXs4hqzfPWUeKdQhaQVQl7LuKkRDDp9d3ryZHUXYuBn3r2X1RzJUAh6xJVLIgCCXg/I58R9pzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhVC+Hsu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07b65efeeso401936385a.2;
        Mon, 17 Feb 2025 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739832636; x=1740437436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuRB9Jwf6lkVtrT6vIlRJUWZnFJbbxQGyG8tssiDsGY=;
        b=BhVC+Hsu7UPe6UwDPY/QE5dIst6jjqZueUR33w1s/e717U+Sy8Lv/Pza2Z9B7sPS/4
         CFjNMurj82Fywygw+yJuv+PVJ7KG+rRxZgVJJe8a36zTmokQChclxRLab4m/VyxVGspd
         o420Gt8NXWZuGJ9koj2K9YlWxk4E1p5YCkpujB2+RqpfduNnDIRmh3YIydnfDMFaKdau
         Q8/EI+2zjdTTq6FbS0h1lEbOmoGV+N1r/vrBcWcrBw8FDBUw/aGlEUagGc5PGuRmGCpX
         X23WDCTXR3iAWwIKyuz5bYpruFAe+0B5PxbVQGOGUOv9Pr8xqf8B3wrxKOqivAXe5l+D
         RNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739832636; x=1740437436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuRB9Jwf6lkVtrT6vIlRJUWZnFJbbxQGyG8tssiDsGY=;
        b=WJ1kQ1gJdlVMKbutEzN/3fiBVtqFa19gvMVYDq+mpqzyrSXauwyTod/ACZ81zWHTOw
         xb9OsAXMEy/p/h5VreqYYl6ZqyfC+LpTVrhlWwgSD0cRFX0JcCe1Lk/8DWicyyA+H3y7
         xEGPgRbjDYLszMqcwWEHNDJ4yHA+rf+dPG6IEf/4g9r3R1FpbFIBGiGRtjm5spqQALmw
         +40eak5/9EtRXjH1eYPNDOZUYxznNRsfG+3EnSjJNMqd9AVRkNiPUjAyBNHuzeUjlXUl
         vjakG6w4/5MlJDWwp9A0wza25Sosq9a1dX+kWHwujNBvg8/FxQHvkpMKSQSs0ASCH+wN
         LBnw==
X-Forwarded-Encrypted: i=1; AJvYcCV42BkJFK8jx7zILSvYY7IgNYcqiVhaChoyU0Ru+jFsICpsvILabUHLEq1y0d/Fw6C+2uqANqceZROsUAKf@vger.kernel.org, AJvYcCX/sNUInCbirqkoK39D4WhP1GVc+FpfuEiw1dQ0uuBJZpj7dHEsWz4ZDBwZe6Nr+5CI8/TUCKHh@vger.kernel.org, AJvYcCXYIDytNpkxcMOltvqHi27mFG/33TqF5W3ja53YwzwgTzO1BuC3+kTrn8h0zsvVmEASIz0HfIZfdi4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoMLp1aUga6As1uJ9SS+L6/Un9+jJWQbNT8Ckpqne11Uj+1Be
	M1B7yFbH1Pxgj7+CJPQI1QiZhoOGHyVnrMPRCw2wMHlsoTfazy84
X-Gm-Gg: ASbGncuhpm7uNaKMIWmkYuMHJ9k9gde2uCLLna5BShxzd/FRCGXENh9felESi/Amhtz
	R5YN9Uktc/1o5EAcse1pOIZJPENJnLe1h+82JAtHF/1LQUhH2/+KeONmoYfhdqGLDAwvBrHPYcr
	habnp7G/4CH4rFGQX0so80t9AaHfXcMVoSdDNjR7m6Eg/SEQbGLpBJl3bq9BKym0gjsXu0qpZV4
	/A1bIBGIPQFZUTc8Kuzldmg1iPjHqsEVNrizLrTa86uHDerA/UMM9tpqwZNFG7jJOg=
X-Google-Smtp-Source: AGHT+IE77k8p+mAi1BZHXw2Af6ibqX9QoECI2nv0Dz4rUPqmmgRmUNBBDIKtrBxkEobOVjl1YJiisg==
X-Received: by 2002:a05:620a:44c7:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7c08a9a6481mr1561011085a.17.1739832636093;
        Mon, 17 Feb 2025 14:50:36 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c0971334f0sm208792885a.56.2025.02.17.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:50:35 -0800 (PST)
Date: Tue, 18 Feb 2025 06:50:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
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
Message-ID: <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
 <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>

On Mon, Feb 17, 2025 at 02:10:50PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > > I am not sure all whether devices has this clock, but it appears in
> > > the databook. So I think it is possible to move this in the core so
> > > any platform with these clock can reuse it.
> > 
> > Great
> > 
> > The next problem will be, has everybody called it the same thing in
> > DT. Since there has been a lot of cut/paste, maybe they have, by
> > accident.
> 
> Tegra186: "tx"
> imx: "tx"
> intel: "tx_clk"
> rk: "clk_mac_speed"
> s32: "tx"
> starfive: "tx"
> sti: "sti-ethclk"
> 

The dwc-qos-eth also use clock name "tx", but set the clock with
extra calibration logic.

> so 50% have settled on "tx" and the rest are doing their own thing, and
> that horse has already bolted.
> 

The "rx" clock in s32 also uses the same logic. I think the core also
needs to take it, as this rx clock is also mentioned in the databook.

> I have some ideas on sorting this out, and I'm working on some patches
> today.

Great, Could you cc me when you submit them? So I can take it and
change my series.

Regards,
Inochi

