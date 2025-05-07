Return-Path: <netdev+bounces-188624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424CFAADFA7
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B118898BE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFE283FE8;
	Wed,  7 May 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy/4BwLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D7283CBE;
	Wed,  7 May 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621946; cv=none; b=ag/1g2XER5i/9KEoNdrDwb7m6vSIskM+2lao7rK8Yo9mbIt1p6HJRyS56BWPWyZxdvo78eiKBkIZ/wYfiVXSbluICsienkKO+NcMc0PmvjKcOUxh3gBxlHQRv2xX6lUTyqfdhb9IsVYMFWGu6SMZcRNR4c3U6v2dz/grRiBI1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621946; c=relaxed/simple;
	bh=9DxzN9AnLFsBNzZZdwpy9vlafkqwBrDUBdeLAzxHO7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZFP/UzWGQMluT/iQWlnVj/g+f/MrwW22bpkaQgmjcB/CawgtLczWpGuRtFwrbba+tSF0Rw8CCx15kayfa6rqiiSY9d3E3RNaIiDJWZ4FGhzvL8KMF9U1ue2Tx1loibmJ2RzpkXV3jeLvDPajddMoyvKxUpaILoJaEtoMmZZfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy/4BwLs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5ba363f1aso1017252685a.0;
        Wed, 07 May 2025 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746621944; x=1747226744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2zV074M+6nwcpFqf4vrNr7jLnOtispGdjqzYB/cGTY=;
        b=gy/4BwLsBM3siEmcH+xfrcJPvaX7/VuKlrC5SSryGdyO0A3lt+um3F9dwb8r+RjPT3
         RCDnEULzuADiz+YcpV+0uUlEbxjqLcl2HTpe5FpyFhoqWDFsoF6VWTRSdBm5MLqNolra
         uLxIm7LKwc4wUd9mILIoYJrGUM2SENbVRSllI+GaD/+mixBq+CpmP34udzHL34beuVW9
         QV1BiVrurHAx9T5LGXSNbSklzqrBfohXIpZAmtmwJkiztJDOh/1qdOmuH2QdWiLEGMdP
         k9VwKpj7GdzV0XKuUXf05bhJ9XRuULDpEYG9WX0delVdhGZEQjzKOu0PzxYLEY97IFul
         CK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621944; x=1747226744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2zV074M+6nwcpFqf4vrNr7jLnOtispGdjqzYB/cGTY=;
        b=olVfe3OecoHp7tXhSOjgKR6ufGoaOBoPNk8dTntglqhRJv0/6nwPIvNUa7rAmLnxh4
         3TvAMA5U3h61f374vc/g4yyIFs7gjT8QQSyIFOGpeScjtGyAxHUWXbsaux1KL7cIgILU
         tcULocJkx1+g4/vccgiHO9HAMwuWZNLZpRIJ5/Zpqb72SpcAc3lo/O3m0NJdUxOchez9
         j4cu6Vd5yP3/1Bx0zDa0Qndhld3Dg0QPMeiIqyWM8HR2AO/B9S3R5MiI+YFHGWJtNuLm
         l1Ez4NxTTrISt4HOwMRZ9gs59X0v7F9iNwe1QPxVpv1HhuXfraZvclNCTexCS3FmIubB
         W03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnvdywLTImpIvVQpiiIrWj8nWaWAOIx2owAxfyHwnJ5nezg5sqRfNgMREX3cPK52l2TSwy+FVhRtAhIKgG@vger.kernel.org, AJvYcCWuhAtyeRynDsPl6jUwJ+DszQFrrpGl7BZXrKoQViUPVOv4GMSedv94zyz4o1Rwvlhw2Bkj7Sxz@vger.kernel.org, AJvYcCXGsZLIINUSCOsVAFp6RJw6Ck7GgS8yEedcvD7RlZyV6ZAcm7jKcPqyvLx+lnLdIbFCMlfeLLA6Cy2c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0EG0xEFF1CLe+7UlTYslir6T1VDeY8aCvIgGQK6QxTLnoWMs
	hsdwPqwTPK/TpheUOY+wPyoYq5DFC6FUo7EtELna2/MkjxNP3t8IB7ObQQ==
X-Gm-Gg: ASbGnctri37GeD/9ZzDH1EOLuNuvfOph94OwflC/zVb01LkhQFIbq2MSwddFnyiQQkf
	tr26RLMTcSz8c5jh2XCX0BYYSOhuj0c07pByvRhOukE2NfSx24zgl7d7QjO/PMnZDZ8tx6qyRSl
	fN9uTWiv47J10axEDmN5Fi40lEsmIRTmfyaqLeQ9uIuvN3xSxR0GJ6YYMkVmxSe9BIBZLFr/ie8
	DC+9jwMtMljQPE7wJGKg21b4wMB6ESIorgDt5cDOXHTQ7o1D2h+yE0OQc4x8gu8uK66XUr75kiv
	npccyjgn3ZUJ925t
X-Google-Smtp-Source: AGHT+IFe4p/E5mc6ZXdUskO144UfSWaGztqfNqrlmQcNmUMrZJzV/ph5M+fDa1Vi9KU3agPcMIiCzQ==
X-Received: by 2002:a05:620a:40c7:b0:7c7:bbc9:aba0 with SMTP id af79cd13be357-7caf73fcfb1mr554734385a.35.1746621943769;
        Wed, 07 May 2025 05:45:43 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf75b3a6esm145729385a.89.2025.05.07.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:45:43 -0700 (PDT)
Date: Wed, 7 May 2025 20:45:18 +0800
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
Message-ID: <tgqngwc7mteczfzhuyguy3jojnqhdi3ecaqhupuq5lhhhn3ve4@n2gb4w3pc7va>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <c7a8185e-07b7-4a62-b39b-7d1e6eec64d6@lunn.ch>
 <fgao5qnim6o3gvixzl7lnftgsish6uajlia5okylxskn3nrexe@gyvgrp72jvj6>
 <ffa044e2-ee9e-4a34-af6a-2e45294144f7@lunn.ch>
 <2tu2mvwsnqdezjei5h43ko24vfave4c3ek2fjoatwsg72p6lpz@3vbtpmm7l73z>
 <b4ce3e35-9255-4fc7-9c8d-4078b24ac3fa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ce3e35-9255-4fc7-9c8d-4078b24ac3fa@lunn.ch>

On Wed, May 07, 2025 at 02:37:15PM +0200, Andrew Lunn wrote:
> On Wed, May 07, 2025 at 08:01:29PM +0800, Inochi Amaoto wrote:
> > On Wed, May 07, 2025 at 02:10:48AM +0200, Andrew Lunn wrote:
> > > On Wed, May 07, 2025 at 06:24:29AM +0800, Inochi Amaoto wrote:
> > > > On Tue, May 06, 2025 at 02:03:18PM +0200, Andrew Lunn wrote:
> > > > > On Tue, May 06, 2025 at 05:32:50PM +0800, Inochi Amaoto wrote:
> > > > > > The ethernet controller of SG2042 is Synopsys DesignWare IP with
> > > > > > tx clock. Add device id for it.
> > > > > > 
> > > > > > This patch can only be tested on a SG2042 x4 evb board, as pioneer
> > > > > > does not expose this device.
> > > > > 
> > > > > Do you have a patch for this EVB board? Ideally there should be a user
> > > > > added at the same time as support for a device.
> > > > > 
> > > > > 	Andrew
> > > > 
> > > > Yes, I have one for this device. And Han Gao told me that he will send
> > > > the board patch for the evb board. So I only send the driver.
> > > > And the fragment for the evb board is likes below, I think it is kind
> > > > of trivial:
> > > > 
> > > > &gmac0 {
> > > > 	phy-handle = <&phy0>;
> > > > 	phy-mode = "rgmii-txid";
> > > 
> > > And this is why i ask, because this is broken. For more information,
> > > please see:
> > > 
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/
> > > 
> > > 	Andrew
> > 
> > You are right, the right phy-mode is "rgmii-id", the delay is not
> > added by the PCB. It seems to be better to ask for the vendor about
> > the hardware design before copying params for vendor dts. Anyway,
> > thanks for reviewing this.
> 
> Please do figure this out. Since you are adding a new compatible, you
> have a bit more flexibility. If the MAC driver is doing something
> wrong, you can change its behaviour based on this new compatible
> without breaking other users of the driver using other compatibles.
> 

Thanks, I will check it out. And adapt the driver if needed.

Regards,
Inochi

