Return-Path: <netdev+bounces-244829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 684ACCBF714
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2F60300183E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC830B517;
	Mon, 15 Dec 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1ozq0u+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9128A72F
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823642; cv=none; b=MxILrvpX8zLYWd2Wxap40DoE3XPIgTxhd5PtPvyHKIr6fHmRKejAz90lWusuK2irs1vVH4SgUbNy5pgtFSbPeiEsbiwMWbtAbvrRKqNYQel0G0Oe9EoHjZEbsWaWDimmsOBOhZZlqfIumBKQj2TpwVxOG2QnCPHlzg+yh5ACqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823642; c=relaxed/simple;
	bh=WNJuxtR4xjqLFfaBNgAaSfYdatv+C8mw731fRCaI/ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCVW/UKhD/jeoZFYfK1WCK6eacwMJc30Quyk+ninlc2Ex0qEqudqQbed6ddFRSpyJxMr7BqcIwQFQss1USko20otM+7aBv/AwUXto85IyCOBRAUjlRvV8bKdEk/vT2Gs/d1kkzQbv4t3kSsFigBTM0NR+bf40HmqRe0gQ8JVodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1ozq0u+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477aa218f20so25077115e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765823639; x=1766428439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ivCXo0tlAhX6SrgNkqQcm5Kx6Z8sjaJXC/TK9cEdNg=;
        b=g1ozq0u+qLCyj9/71XQmGIJOtbq9JBPKG747QJ5uDfUQgFG1VpDkeniMNPpJmSvAoy
         TCe/WGK2Z6g2XllSPXHOap6N2lGRcer6m7VT9rY3XqDcfmMj0H4LA6GscFw2+GCBxOyZ
         9s2YdlKzNhGpmgpNnwj5Tp2VU7orV7aTC+FP6no5BLyYinrT9v6cA/Dg4SsBq/F2qhg9
         0R3eFkPlm+FHmQExZlSyu0h8/qURh/XyIVU06OJDibG0cE79oIqh9+15elCXTS0Q9DT4
         8ZVCg5jU/pdaAKBox1GGT4rZhZGWufHoGi3NKS7nedBjCfMdqwxFHZFiCp/55/dWSoJe
         CedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765823639; x=1766428439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ivCXo0tlAhX6SrgNkqQcm5Kx6Z8sjaJXC/TK9cEdNg=;
        b=ED3MMTj909qO6+mxWXmXSOUDDmcXd5ExeGfMXc5tnq9hfyYHJeNFyY25B7Yva6L8km
         /gNZmm0I7Lh1sSBYV6a1eo9nGsutBnpsCb5K+A04L6m0cjQdDaUi9wt7KHWrZDfV978/
         cfmsN8QPDu4O/MCxwrNqPD3yDSHMlrbVKftknaKpQ3WRW2RDvS8If4yu2oIjWAigpvzS
         kRIznufyyWYDhWjpDNmj1eX/o5NE8gki/+OHyCI24OvujtGIljumg+rmuXt7xuHjVmsM
         ugBUlPqqs7M6u5eA4695E4mQBkadL38e2l5dGnJLKflZS3XXlhwdwDS8b5jEjqZfrkRO
         CuOw==
X-Forwarded-Encrypted: i=1; AJvYcCW0qIOLjuWCorHUiIQNP0BcbC4yNjdBISOLund8NLZtNun2OXxYFRsMn9CyQM8xjJF9UIyvGP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6jWxOAtuoJ5N6ZuEjxsKETju03AhEHZj5FKazc5LurbSOz0K
	3uY0FGngCC6dn3kkdVExVVkg6WSpGN/BIiu3mWrscq/VxTkn/Fua+8k6gmF1KLQbBC8=
X-Gm-Gg: AY/fxX5vQBa95PgVA5sqZS6J2PuiUUET6umIsEKU+LNLbsHjo/pMcSL9Eh5MWMk3Sz1
	YpGnU3gAFz8ONQLQ3h8g67dr3+K8XgvTj1hysvYPClbdJFEqmilhH1dfObPNzMJ4QdC6hL01XTQ
	lDy8AV/XFVN3Um679EOxhKf70/901pEyFiA++232XqfMSaoSFJGDa4CuhsVbVLyQcShU4qxkvCv
	XJw0HqgTcsO3JrugCdnbVgzsorgNHI+Hqv1PfjQhqnB72oPpWKUHI+4XOMCxXRRmqR7eV1t/f4K
	nohBCGFAi/gMUFB//llFPzdlyaH127UVSH3cIinxmrsYH7wdQ4m1MLXeLYyvaNC+rwNxt+LvuGX
	853lOa8PBB+ySU2R1+l8oqbqLUtj1LMDnFvBQ+2Yz/0wcT50vJb94ovTGCcHLtaa9c1nUoqKNT6
	9Tk4N7F8cjLOKqY8u+
X-Google-Smtp-Source: AGHT+IGD9iih4mWv4BLSj82m0Ympx0mGmlL43wh+neFiQaKbjBxHvTG8uww0J8sP/od0z1H7q0uRNg==
X-Received: by 2002:a05:600c:5252:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47a8f708ebamr117215125e9.0.1765823638856;
        Mon, 15 Dec 2025 10:33:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f280cf05sm16491842f8f.7.2025.12.15.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:33:58 -0800 (PST)
Date: Mon, 15 Dec 2025 21:33:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUBUkuLf7NHtLSl1@stanley.mountain>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>

On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > The s32g devices have a GPR register region which holds a number of
> > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > anything from there and we just add a line to the device tree to
> > access that GMAC_0_CTRL_STS register:
> >
> >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> >
> > We still have to maintain backwards compatibility to this format,
> > of course, but it would be better to access these through a syscon.
> > First of all, putting all the registers together is more organized
> > and shows how the hardware actually is implemented.  Secondly, in
> > some versions of this chipset those registers can only be accessed
> > via SCMI, if the registers aren't grouped together each driver will
> > have to create a whole lot of if then statements to access it via
> > IOMEM or via SCMI,
> 
> Does SCMI work as regmap? syscon look likes simple, but missed abstract
> in overall.
> 

The SCMI part of this is pretty complicated and needs discussion.  It
might be that it requires a vendor extension.  Right now, the out of
tree code uses a nvmem vendor extension but that probably won't get
merged upstream.

But in theory, it's fairly simple, you can write a regmap driver and
register it as a syscon and everything that was accessing nxp,phy-sel
accesses the same register but over SCMI.

> You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> 
> regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> 

You can use have an MMIO syscon, or you can create a custom driver
and register it as a syscon using of_syscon_register_regmap().

> So all code can use regmap function without if-then statements if SCMI work
> as regmap.
> 

regards,
dan carpenter


