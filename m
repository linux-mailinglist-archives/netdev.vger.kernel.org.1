Return-Path: <netdev+bounces-188609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1EAADDF8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EDA1BC63ED
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0222580D2;
	Wed,  7 May 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdpZlfgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6974B1E45;
	Wed,  7 May 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619332; cv=none; b=pN1GAKLrWuZVE+Smdzt0fhRkcoR7qngbJQDswtcXHnON9aDTtWcgIgzGss61/ht9HbVpSypHvzEXxwiMAcRb/bZS9q1IzseDSj72U9V0pJGnP+9LbcbQtJkpNqggXITVsinxeRzZDPO8kJPVt6ARwv/in3HJw3+qtWSJpi67chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619332; c=relaxed/simple;
	bh=G+gGUFnonfHfqvLJtT3/rMFE4bMTKjw81qinxKZTkP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxs98oysZA1BzwhaL9UB2xO9BfQcNrjhls2nkVfpaPJW5APMSgGG95jE0tXJHn4SMxgPDr5y7mLv0nuB8pmWTVCtmXNVsQb1sAQIOsG+oUb7jAWDwWDgD2AHLqtEak9bRLguFRSDOojmUESUm0poSJ65YC0JBDRk5uKa/9K4We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdpZlfgo; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so99166046d6.2;
        Wed, 07 May 2025 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746619329; x=1747224129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cB9Vli3Xxo4KwEG4QM0VC4PHMgHe2AYxc+yOmxy2QWQ=;
        b=HdpZlfgoaRPcb4fTwldKsQn1aw2IexvtV5C5OCzyM6eWMpFuDU4XSENi40xorORDiw
         8D7xGaG28rqAFkRThJjVVxNZ9jm4pJ4uKGju8ODLQcN8kT2bcxmhynvsed82049DduoZ
         TlinWhpn1Ts5CCE+D1L0khVh1HqpUYQVoEmzUGxD9+auTSRbImAaDlPOreg1Yh37R/98
         44JQEcVjHfxo/cVPseI395WeILZAEluqsdBaqcWM85dj1rYkTu4q1RW/038ddg954d9R
         1uc8VDjSv+Drt0xZ+1irf7PkrNB072drp1vqfeQa9r3uVgS0twCO2Kdc6nme1BdqKpXj
         BnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746619329; x=1747224129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB9Vli3Xxo4KwEG4QM0VC4PHMgHe2AYxc+yOmxy2QWQ=;
        b=kyIY4ojPueMi/N3w2yCRKJG8UZtJ9orZdStG4gExbK8BhFZpANPqDz+zWtovlfdQUZ
         L9oeJDzXMF2moULEViHxdvLDryZMWMPAc7KoLu2sDkcgQDK/ar71yPfsAXuvciLGea2F
         yQQygvYQ4GZGktxNZxJv0iaHc/wURiRK6UHEzXrR7MC3ItQKZBNI5L9S/oQNSZdYV8ER
         NlFLy4JYoR1B7V5cNIeIUok66bhHJJgkYYjWajdxLia227JoRcPzfTZuD4Dk5kNhbRL6
         LGv21T64xTvhsyNJCFX5ZOGdfxNpuHlgoxNYQNn1GDHUcr7BI649NGrIuVRXXjK3rNkF
         nJZA==
X-Forwarded-Encrypted: i=1; AJvYcCV22aigdEs8QKbAUXmAVFZZZK3GdvGVY7uvhEyT3NDJvr1oeD2TkzJiyzcSIMQuQsgYUvmYM+ZhyY6f92qJ@vger.kernel.org, AJvYcCVQl9KMXlA2JdhUiMF83B/bKnek8vmQK7BNl5RuHwpuAzJe1QStYEHcB/EDHKnpuBxs/HkiGE9A@vger.kernel.org, AJvYcCVhM93NyFKycSbFNoSJqecsDZvGmioI5mT6NV1PNKkKb19AEriG6jiVC+I9KTvF3lTZMCh1KyCh+GwB@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK9KkM6qBvu12j7156KwY566r0Llru4Lbx4X2iZ1iEEnOu+00
	Xv0Uzi7PQOm/gVBGg6jiK11BS4rRL5xlhtPrvIlwWA2XR+dqDSBSuMePtQ==
X-Gm-Gg: ASbGncvDDiJFrXs9fOXv1hJqDFQn+SxAHXLLAGQpdi8qBWG07o69QE+UGmJS7ECTQsY
	8uZGS1VJyoqLPaZW4+RTUyD4gMj7ODUqhSSPiaaFIlkHyCbbQ+H8p8WPfPOcM6uSDnw5HgaedkQ
	pp3KEgBqPFR6ZMBxR6sSl5k+z9POa6f/TOdCJE6Qt2vsDs5PlXgjFczatfOS/NPqZLbeeKy8Sek
	8MDJ8M6nHnR1IF+xfXItxMDrGlfENkIE8KSBgZw5r5HUQQKMybF0NZ6lnBURlvjiekgGlhCl7qg
	WEtHdYg0YowqJR+w
X-Google-Smtp-Source: AGHT+IGRl9BUi1WrHprzmvGHRtZmly2KUBbHCnPcITRG9+w3NMHRJoWIA8I9LxLmf29VDGt76SQFqg==
X-Received: by 2002:ad4:5dc3:0:b0:6e8:ede1:237 with SMTP id 6a1803df08f44-6f542b31434mr45097126d6.43.1746619317492;
        Wed, 07 May 2025 05:01:57 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542647e03sm13464756d6.29.2025.05.07.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:01:56 -0700 (PDT)
Date: Wed, 7 May 2025 20:01:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Romain Gantois <romain.gantois@bootlin.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 0/4] riscv: sophgo: Add ethernet support for
 SG2042
Message-ID: <2tu2mvwsnqdezjei5h43ko24vfave4c3ek2fjoatwsg72p6lpz@3vbtpmm7l73z>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <c7a8185e-07b7-4a62-b39b-7d1e6eec64d6@lunn.ch>
 <fgao5qnim6o3gvixzl7lnftgsish6uajlia5okylxskn3nrexe@gyvgrp72jvj6>
 <ffa044e2-ee9e-4a34-af6a-2e45294144f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa044e2-ee9e-4a34-af6a-2e45294144f7@lunn.ch>

On Wed, May 07, 2025 at 02:10:48AM +0200, Andrew Lunn wrote:
> On Wed, May 07, 2025 at 06:24:29AM +0800, Inochi Amaoto wrote:
> > On Tue, May 06, 2025 at 02:03:18PM +0200, Andrew Lunn wrote:
> > > On Tue, May 06, 2025 at 05:32:50PM +0800, Inochi Amaoto wrote:
> > > > The ethernet controller of SG2042 is Synopsys DesignWare IP with
> > > > tx clock. Add device id for it.
> > > > 
> > > > This patch can only be tested on a SG2042 x4 evb board, as pioneer
> > > > does not expose this device.
> > > 
> > > Do you have a patch for this EVB board? Ideally there should be a user
> > > added at the same time as support for a device.
> > > 
> > > 	Andrew
> > 
> > Yes, I have one for this device. And Han Gao told me that he will send
> > the board patch for the evb board. So I only send the driver.
> > And the fragment for the evb board is likes below, I think it is kind
> > of trivial:
> > 
> > &gmac0 {
> > 	phy-handle = <&phy0>;
> > 	phy-mode = "rgmii-txid";
> 
> And this is why i ask, because this is broken. For more information,
> please see:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/
> 
> 	Andrew

You are right, the right phy-mode is "rgmii-id", the delay is not
added by the PCB. It seems to be better to ask for the vendor about
the hardware design before copying params for vendor dts. Anyway,
thanks for reviewing this.

Regards,
Inochi


