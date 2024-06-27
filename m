Return-Path: <netdev+bounces-107408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E191AD96
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C22281EAA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2119A28C;
	Thu, 27 Jun 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USA08AJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68749433B3;
	Thu, 27 Jun 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508255; cv=none; b=Dx6paAWj9L8PjgN1E1ygezmuw01ukxnihbNOeF63clNCaRT19i3JMbsnLVSvBGOfP3f3eIjKhninfOS980RghXvYgZvVKm81rY/Fs1foJOZla4rngdPbkVXwaFXo9BJ863awZNz2Or7gAatGM03piv5sOqLsu/zXfZN71sKz/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508255; c=relaxed/simple;
	bh=s4l27g42udRCB8rJG6YI5oyKnL4uIh9SB56X2gZxZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBu8ZKi7KVzXIXjrl+QhCfRFFMyG/SVmoYo1Bjd/mKXVCCKj4j5uUeYmHk0y/GctUpO8zy8veWVscC8szsi7EUX4ivSgLHFvSfhiM2/hTptZKcYpBpxqt0ZKt1JsoGfLg4neVECWDevTHwCW5zIw3eOLoj4DpXWuYjgvPp/1FTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USA08AJD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso7974611fa.1;
        Thu, 27 Jun 2024 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508251; x=1720113051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQlcJ+6aWC6ZSM3mk9e3WLtJ8bng42FgNFtFpOoN34I=;
        b=USA08AJDqAa7uEy4vLsPzLySgDwD/V5LHVIg3udGCn+O9G/3L7ZeQZYfau2jzfVFwC
         FYVzo4KL/7Ak9u1T/PjZeA4zE8sjmAjJaBNy2GuqhXvGbtCyVnOOxnS5nfV6DTZ443aa
         skI1E6jkegDavw8gxn5JpOL6/44S0/aXnyqH8o/e/Mdk8aWk4SvrIUw7yNCOxJnCZGda
         b3FBCs6qy5CnthWnTCufXKErdwQSKVNhNhdr/nedwk6ZhN/FynNWfEcC9CaOZL12b/i1
         CrP3OpCZ23BdyUo2P3aROC9nawZu+VebR/pgM/CjDrf+XOLjgMT96UpgD/YXSvGGbYOb
         cRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508251; x=1720113051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQlcJ+6aWC6ZSM3mk9e3WLtJ8bng42FgNFtFpOoN34I=;
        b=SKW5hF08JSXC+1yoPJ/cxNOoH3Nu05i20Csux4OYq3GZKo31X6fWlZ72FR6dP2ohVA
         ryXClszEsvYF3qz6/Q2MCNRaIYfnkc7hl10N44/rAreRQuWOzICTIluZYoR55wcwLH7h
         rhk4kByHX8hEwp8t3vs3K5mAvAyzuhUXNeJEC0XB7jd1jU2k9S7r6L9qHqSX3AOrWqtm
         gkvTIaPoYcSDSdX6bR82AoYU4SYmmAEd0+xcwzN00wPqY2VF8wX1ADn12+0p4PHVzek5
         Fg3dAxmy4DHTudIaINdAln0r2Eed9UnJuYMzbgzx01/8WrP6/D7aJly9tPc70E+qxLMw
         VtfA==
X-Forwarded-Encrypted: i=1; AJvYcCVvtU3YYXxziWh/kOgv1/zppKEKOGuK9ZO5YqJrADp7qTHsQvgzeCHTK54jP0aH66fvQrdgUp66vZA0NFRIKaFunXa9bssXTWqDAGgUVEUxz7mxop1hbwLMsGpplHQWgQgEbweFdIfToYp6oLLGwmP2qtdhpgK9l3a8ZYaf+c+m+w==
X-Gm-Message-State: AOJu0YwIhNBTLZYHXjwc1j9JgaQJRv9Tev9I327HriqaRscy15nL0Bj9
	Hw0VLVOY0Uwctn/HEmeMOpguy/smjYmzPSOzLE3zdxIZR8nzta51
X-Google-Smtp-Source: AGHT+IH2++0VlmY/PoUFoK6twB3OYGqFKj6eVnvwbmE3JDf/EUiLDbwoFbuBSVIfzxdfjfkEmAnCPQ==
X-Received: by 2002:a2e:b0e2:0:b0:2ec:361b:c079 with SMTP id 38308e7fff4ca-2ee49863be6mr6958261fa.25.1719508251179;
        Thu, 27 Jun 2024 10:10:51 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34411esm3151361fa.19.2024.06.27.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:10:50 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:10:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
 <20240627-hurry-gills-19a2496797f3@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-hurry-gills-19a2496797f3@spud>

On Thu, Jun 27, 2024 at 04:51:22PM +0100, Conor Dooley wrote:
> On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> > +  clocks:
> > +    description:
> > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > +      source connected via the clk_csr_i line.
> > +
> > +      PCS/PMA layer can be clocked by an internal reference clock source
> > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > +      generator. Both clocks can be supplied at a time.
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - minItems: 1
> > +        items:
> > +          - enum: [core, pad]
> > +          - const: pad
> > +      - minItems: 1
> > +        items:
> > +          - const: pclk
> > +          - enum: [core, pad]
> > +          - const: pad
> 

> While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
> name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?

Right. It's "pclk". The reason of using the "pclk" name is that it has
turned to be a de-facto standard name in the DT-bindings for the
peripheral bus clock sources utilized for the CSR-space IO buses.
Moreover the STMMAC driver responsible for the parental DW *MAC
devices handling also has the "pclk" name utilized for the clk_csr_i
signal. So using the "pclk" name in the tightly coupled devices (MAC
and PCS) for the same signal seemed a good idea.

> If two interfaces are meant to be "equipped" with that clock, how come
> it is optional? I'm probably missing something...

MCI and APB3 interfaces are basically the same from the bindings
pointer of view. Both of them can be utilized for the DW XPCS
installed on the SoC system bus, so the device could be accessed using
the simple MMIO ops.

The first "clock-names" schema is meant to be applied on the DW XPCS
accessible over an _MDIO_ bus, which obviously doesn't have any
special CSR IO bus. In that case the DW XPCS device is supposed to be
defined as a subnode of the MDIO-bus DT-node.

The second "clock-names" constraint is supposed to be applied to the
DW XPCS synthesized with the MCI/APB3 CSRs IO interface. The device in
that case should be defined in the DT source file as a normal memory
mapped device.

> 
> Otherwise this binding looks fine to me.

Shall I add a note to the clock description that the "clk_csr_i"
signal is named as "pclk"? I'll need to resubmit the series anyway.

Thanks
-Serge(y)

> 
> Wee bit confused,
> Conor.



