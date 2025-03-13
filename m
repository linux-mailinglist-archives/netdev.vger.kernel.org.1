Return-Path: <netdev+bounces-174432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1AA5E933
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54C3175BD8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 01:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0415E97;
	Thu, 13 Mar 2025 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEkj/tol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0756610C;
	Thu, 13 Mar 2025 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828105; cv=none; b=kCQdHZL7i4uglo9rhvZj+Z/ttRnCjIXdIIirWK2dFB/jD7t7AbiwVuD1f0hODlWmSarhMXQh6gY/EONZm/OqkSJswNO8UI29+5G2FZEUq1hOy+9ulbii6m5SYCuvH6Ar5imAkCPSeb+2TK52U3pEwUFBtrkmRmdP57EeUY6fpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828105; c=relaxed/simple;
	bh=L1B1sJ7YjsET1pMUISc3uxnEi8mM0HBOJ1+5dS36kws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewA6ch/bDaWzgzdUGmU/Gq9rsmgibik6JXqmaJbAi6Y508BLyLleqUSwYkOBl8XmXIy9JcZ9lWRtvW7nN8yfEVUqENdrfYy1uSuK9iYkrXKE8nHrA9YHGLMf8GLpm1PdQ6Sn7APcPIe6XJFOLFEn/sTZIyKAPyWzOICl3wwpv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEkj/tol; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so13941826d6.0;
        Wed, 12 Mar 2025 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741828102; x=1742432902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB3aa4DZXOqG8FkpT/yFPtGsJ00G9GKgyRtQ/0BrqTg=;
        b=CEkj/tolOH87SB9A6lBvONehnZ2RdeghXNP2ndY2+Xpwl4wySkcyvST2LBuv1/UXsJ
         GvFjmXIre6aB0E3boblxCbAazgHFigQhdrS08AO7xlF0vQ0tV7jfm6HKJeRpODNFRaoE
         F+ioCv3Xj2lzek4h60W5QzA27KHHimZxulZ6y4eeiQw3xcGB+doEAV9wvJkmRcjUXbAp
         TUyz6CnHgFtCmsBqqQ2+q7KaOK/HRDMBcVQ+/HEgn+F6zYlFD8xC3c8d3AsXC7jdcq5a
         oWPDh7v/44lyTK6Rv/ISHGCzrxdLg6eXLSby7eavnEslyuwz8mYHMAyk0Bd9BUVEIDdV
         G+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828102; x=1742432902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB3aa4DZXOqG8FkpT/yFPtGsJ00G9GKgyRtQ/0BrqTg=;
        b=u3BIqDO5vyt7oPHCTwTZcNiAL5zS+0E71cAV35Sy5uTuBNT910jKum1/D+Ee8Dnx4X
         bAn/WJPbrpLgmIH5wzUym8uv+FeUqpuLwI1KpaCeGdm+jW6f1W41FO5yAbwvXg9tf+zL
         wu+o+c+ScEhsfIWYtmKqMsEjjgb+58Egc6U6DwMLztuLMspLbMW1zyWcfb/mcjhvOzOT
         /CmPhufgFmoAy92Wkgf4jvMBIa3kk03LoZFdMO1xOIetMzffBp/ndUsG4Nx3/WZ56pai
         ATZ+PSCNXTkKJF842whj3t/PUUJgGG+CxipH9l51y63toh5iBxOerffdzoqlaZI7Rexd
         zBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0fO28+5PDfyWwkmUJaCDDR+2no4K6/LVsWIabigNlZDhY6X/C/wLoue9djhv7xWbkX4xMiR+8t2d9TC4M@vger.kernel.org, AJvYcCVW5y0fs7m7d0CultXhraa2d65ZH9gr5uNE2GjOyI2gXHKByEESAsNFWpmGYLAw4u609L96xvUL9FUg@vger.kernel.org, AJvYcCWvbyWJ/CTv4ktZT/SGb/11w00k+xT+e5lJIPRZLrgeZ8TyY5dFiZigVV+3Y07mPwpNXLKayIsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsJ1nvbqTvjmjdFiHEL1i4rj6axomFveFn3U0FrtdWsxpwVFM
	vJMjseYfwrwBZch6sCM3vgeBlH89u+KY4ea1X46SvEaxRs2glezJ
X-Gm-Gg: ASbGncs/v+x9PE6FxEbYYDNQ0dit5hSyLTfXifjMfqT12GEMnGLCijEi8vkW5jOAsJ/
	+dO1pG6uAbDNpxqHRV/PfMHlhue4xVhbM3O4GzeU+Se6erYLDyAZym70o/OMFr8aFi4JX3myrit
	hF2OPtj5DzyTKtfnRDd2cgtrCoP1rku315eCTqRcstgflwP+UI7IPf7ris1rwZYUGYAbJyis7ba
	KfIGMYhDcsd3+KXhnHm33TZDOVfwwzltk1dXzBTLZWMDDXfPsFFIc0RIdqGBZ6HcFGXG81waEs5
	g2CuupFidNcqJvQa7mKtus8MWGPJ0y4=
X-Google-Smtp-Source: AGHT+IErHgyMMC0gxpFbF0+ltzHlALBkq84d33gqNkyZ9Lj204hZXdZSKp7DGFvJyo8iPJlxvm7WCw==
X-Received: by 2002:a05:6214:5c47:b0:6e6:5c26:afe3 with SMTP id 6a1803df08f44-6eaddfbb91cmr8764046d6.17.1741828102495;
        Wed, 12 Mar 2025 18:08:22 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34beb0sm2540506d6.105.2025.03.12.18.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:08:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:08:11 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller
 for SG2044
Message-ID: <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-2-inochiama@gmail.com>
 <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
 <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
 <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>
 <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
 <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org>

On Wed, Mar 12, 2025 at 04:43:51PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-03-12 16:29:43)
> > On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > > > 
> > > > > or if that syscon node should just have the #clock-cells property as
> > > > > part of the node instead.
> > > > 
> > > > This is not match the hardware I think. The pll area is on the middle
> > > > of the syscon and is hard to be separated as a subdevice of the syscon
> > > > or just add  "#clock-cells" to the syscon device. It is better to handle
> > > > them in one device/driver. So let the clock device reference it.
> > > 
> > > This happens all the time. We don't need a syscon for that unless the
> > > registers for the pll are both inside the syscon and in the register
> > > space 0x50002000. Is that the case? 
> > 
> > Yes, the clock has two areas, one in the clk controller and one in
> > the syscon, the vendor said this design is a heritage from other SoC.
> 
> My question is more if the PLL clk_ops need to access both the syscon
> register range and the clk controller register range. What part of the
> PLL clk_ops needs to access the clk controller at 0x50002000?
> 

The PLL clk_ops does nothing, but there is an implicit dependency:
When the PLL change rate, the mux attached to it must switch to 
another source to keep the output clock stable. This is the only
thing it needed.

> > 
> > > This looks like you want there to be  one node for clks on the system
> > > because logically that is clean, when the reality is that there is a
> > > PLL block exposed in the syscon (someone forgot to put it in the clk
> > > controller?) and a non-PLL block for the other clks.
> > 
> > That is true, I prefer to keep clean and make less mistakes. Although
> > the PLL is exposed in the syscon, the pll need to be tight with other
> > clocks in the space 0x50002000 (especially between the PLL and mux).
> > In this view, it is more like a mistake made by the hardware design.
> > And I prefer not to add a subnode for the syscon.
> 
> Ok. You wouldn't add a subnode for the syscon. You would just have
> #clock-cells in that syscon node and register an auxiliary device to
> provide the PLL(s) from there. Then in drivers/clk we would have an
> auxiliary driver that uses a regmap or gets an iomem pointer from the
> parent device somehow so that we can logically put the PLL code in
> drivers/clk while having one node in DT for the "miscellaneous register
> area" where the hardware engineer had to expose the PLL control to
> software.

Cool, I understand what you mean. It is a good idea,
I will have a try.

Regards,
Inochi

