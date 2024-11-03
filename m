Return-Path: <netdev+bounces-141356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEA9BA877
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0761C20D85
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784818C020;
	Sun,  3 Nov 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IziPJNGL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A71189BA0;
	Sun,  3 Nov 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671783; cv=none; b=Q+l9v8fKLQo9goNyJcMPppsBixbkXQwfmYNfEWp7TxYNN6rCB3FEI8pIqDteCl3Vy2bUakfrlCT4XRDmqLLTvOY6gsmojoDEV4nChQWrmClSaTMRvYbuyQlmf8P8FDBmx95U12zal5Zao2lftB0+PC8ciU3i5eVS6QBe98rSd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671783; c=relaxed/simple;
	bh=WkYHzjB1FsobEK55AqhBuGNO8OPLcecCjyT36wwY6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYdXo7IOwJ7q8JO64PgRit4NqxVOauD9rsIeZnyS+p4NZ81SFbvY4odDwck2/Ewa1eH0u03pgwELXL57PorGeUtyWiVVmHhkiAVHZVFNMKeX9aEKhm3ufwL4BjdX5TTPYBV69tzR/N/ZFf+BSLdXfSks8WDktfR5mUYCyCnuH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IziPJNGL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7206304f93aso3456965b3a.0;
        Sun, 03 Nov 2024 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730671780; x=1731276580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rHJELaF04JBRi0aLmrWuxoS3tWtyUhwmRJRrDNiPz8=;
        b=IziPJNGLtz56KgxCv8Fn6ziU+UMUMlzwizoWlz45bCIqRzhldvhiwqRhl9JAU7u3ri
         bjnyf0RrPzPxeeGdPbQUulRBbIgW+hG8dStFaP3UW603klM1pZuyR19dWuPw6rxBzC7r
         9jwTDOBlThdKilsQrHGd8LtLG42MfFiG3vnKhxz7ZsnYcHyYOlqhHpQC59w5++EWv7JM
         g+VGVYKAgRKy/Pc5ZSoLqcQy0kSAk8vs10ReVrs+QjFgggxFPhpxqcwIz7nYP3g8fO1k
         vYbdMyiuIovi1FrO+XmIoY0JDkSdpQoSeTnheyFDe743yrST6iPzmLOB6e0FV9pTlUh4
         tc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730671780; x=1731276580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rHJELaF04JBRi0aLmrWuxoS3tWtyUhwmRJRrDNiPz8=;
        b=bkLYNfhnNgv0mgaTKivGL/rEkxf6Rk6jBwxYalxyQA/g01kJ0TWdEr8HUENQolkxOT
         zrizqeU7LC3sC0AgjePUUYwl+q7u13VDXqc8880cuFewULaw8WOKcsRPLnZF7CwPskgx
         DYvMOKiHyEPaCSoqtAlKWNuPkd8M9c94X5ofBx/fDr968Jh1gbkbgErWG+8OqOLgsSxW
         Itnc9BZqIFc0EjMdzH9VaFbLzyss9A4ALIAxTKVCClhlUF4h5TACS6R6FodDt3qP6Ran
         34vUsF3z7Aywdg8Qdt5nmwd0L3+0wpzQItpB+op5XbXbACNdw84pD6CXGNX1NmqreFK+
         mb7w==
X-Forwarded-Encrypted: i=1; AJvYcCV5/x6hqJTm+626GB7+ug56IHO9F4bsRAj/POXGpAr9Yf9zD7+f7KtNpO+IqR3UdPk3sxDF5BoA@vger.kernel.org, AJvYcCVEjNVCH2jro4pL5vgb+Jo0iU/M5Luq5H9KJ8gXzhGC9b11vtVA+4WTbula6NAxOrGwdhuTNNB4IGVtoBZ/@vger.kernel.org, AJvYcCXeTabEGgC2F3rRHEluaeYNnihIdJqd2xrbzTYg5gkM/Rjm+KV5y4uLHzwa33ai2Ft1MCjKAx099iho@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPZpx6SIFsxKUxUOL8m00xw4+i40+LlklU3H9/ScnMIujiKN8
	X0KTmmH9lk4pUfVlJ+RnwexD+VZkf12DnVH1Rp/veXQN+Qqj5SAd
X-Google-Smtp-Source: AGHT+IFKyJJZHHJG1xrvYibWpBIs/FS0N3kdjWrsxFMjWgEPFe5BpYTq3ei0lG/0AXdt3oOlAP3xDg==
X-Received: by 2002:a05:6a20:e605:b0:1d9:dfd:93c0 with SMTP id adf61e73a8af0-1dba556fdc2mr13977660637.49.1730671780063;
        Sun, 03 Nov 2024 14:09:40 -0800 (PST)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ba033sm6074536b3a.34.2024.11.03.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:09:38 -0800 (PST)
Date: Sun, 3 Nov 2024 14:09:37 -0800
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Drew Fustini <dfustini@tenstorrent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v7 0/2] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Message-ID: <Zyf0oVGk6FiVrPsB@x1>
References: <20241103-th1520-gmac-v7-0-ef094a30169c@tenstorrent.com>
 <662a8258-291d-4cfc-b21a-f3c92f9588f2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662a8258-291d-4cfc-b21a-f3c92f9588f2@lunn.ch>

On Sun, Nov 03, 2024 at 07:12:24PM +0100, Andrew Lunn wrote:
> On Sun, Nov 03, 2024 at 08:57:58AM -0800, Drew Fustini wrote:
> > This series adds support for dwmac gigabit ethernet in the T-Head TH1520
> > RISC-V SoC used on boards like BeagleV Ahead and the LicheePi 4A.
> > 
> > The gigabit ethernet on these boards does need pinctrl support to mux
> > the necessary pads. The pinctrl-th1520 driver, pinctrl binding, and
> > related dts patches are in linux-next. However, they are not yet in
> > net-next/main.
> > 
> > Therefore, I am dropping the dts patch for v5 as it will not build on
> > net-next/main due to the lack of the padctrl0_apsys pin controller node
> > in next-next/main version th1520.dtsi.
> 
> You should send the .dts patch to the Maintainer responsible for
> merging all the RISC-V DT patches, maybe via a sub Maintainer. All the
> different parts will then meet up in linux-next.
> 
> 	Andrew

I am the maintainer for arch/riscv/boot/dts/thead. I'm planning to apply
the dts patch to my for-next branch once this series with the binding
and driver are applied to net-next.

Thanks,
Drew

