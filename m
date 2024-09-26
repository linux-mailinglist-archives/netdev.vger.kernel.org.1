Return-Path: <netdev+bounces-130018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD198798D
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 21:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F9D1C2190B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87447172BD5;
	Thu, 26 Sep 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="dYfMKgYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943E1D5AC5
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377990; cv=none; b=iY3XOVKnqPMjo3iWvIxPeyOXY+FgI8EBk9pOs8+tPXIgGwd+L4aZnnxB6nkTEKFmJUCbWuOClHH0bxXBpDUVNOXZ6WBZmrfRmXdnK9E9TDijvsuzXkr8gHioKbIVUZgvDQGImopuhF4ZCz/JFMP9v3wMIIHBfUXz/GYMCqaZoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377990; c=relaxed/simple;
	bh=cPPMlB+vtFQT2CeU6d0BNvKEGolYxkwnjZlbZZtBpY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+N7rVn3bR11yG/xPqKYhv+qCZrgzgk20zb8+sRlkBTaiUwX1y0F5Ot23UR0MhI3rvIT699dZIltCrzbIXe2zuaX8siKFtrLdfYCrAJC4ykPdcI0qQR6IvMdZb++tCYosdfCqAVJax9Ut6wqFVPmg42huzcQbTGT7J2P4IeQVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=dYfMKgYP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b0b2528d8so14483515ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727377988; x=1727982788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4WZTo6nI26Bhfdln9Gf7wFMawvUlUInYNk7SP122zU=;
        b=dYfMKgYPKAVrvAJStpBvuHVRxAI0/8O/shzmLQsQKHxOwTyZvA9i9Kf5JPHCbv12vO
         KlhIbQO9eaUjZielRtn3JjEP6DeD8b5H6J60tjuidfePU9CmNRwqC3h4CGuSxEeFny/w
         wkQBu2sWWTp5D9D2b6kLU0jmJqEDUhhENAPjb7VXKrzxGv/tndhT+A5rSAboI+vwYrF+
         yEbN/GSb83W5OhnqW+UspJnA2Ri1W2UZiz2Q2labCwMVWGVl2g5MP3dE4cjkA4bLfwt9
         j+ZSdQ+aHBZL2E7VaBuEJHAq8yigPBHXW0Ljli2SMabz0Hejq2WnRUiwwX6pxpuW1idv
         8QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727377988; x=1727982788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4WZTo6nI26Bhfdln9Gf7wFMawvUlUInYNk7SP122zU=;
        b=bfiNbAdzkH/O+O+AR4TEKHiQy2YqhonOwmBPmxt5xoazhNFLAvz9Mun0b1ZbXL7jLZ
         E00xbWpX9PNFcICIK2f+kHOhCI1vO05Kvo/6+m7zJdjCHcRT5VS/2Eq0Qz8x3ShdMRdO
         rFpDh6ROrBTyRHHCpnrKfDW3XPKdwEYaymQk9pZvERh3QHdfkh9QIMT8UEEqrhm4EXWm
         debg0L6z9iE0hhklIG/16MHt0Shr+Fc6F4dp/H6opKfcew0fveQkjjiU+f1ObhMPRCrD
         FO3V8OuUMo615jKta0G5GXkFzRLwdCRk1yV5LZHgCRdMmS0Yb9vfPjijKFXXUuOE25JW
         KoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYY9aT/YDkR1EVFVxG7B4yB3e9lA6T2mYkzB911Lz5kCCz9tbTQfMsmI2nw2wkcTRCqpck5PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7A1zvKwi5Z5p9yeyBOR1HGMnKzO4TbQBp+vw0gZgEW1orOF5
	3OUbzVZICB6pRM/ht3/e+iidxjOMFP5V5IrkFU8jIEvEhR/eg8IWxD0Q1dMaQkg=
X-Google-Smtp-Source: AGHT+IEMklrWdPx+X7c21DcecTVJ7lxpddUaIsHWWZy+aOWGUu3YS5G/It5NPJNOcBI2+VtqDMCCmw==
X-Received: by 2002:a17:903:41ca:b0:206:9ab3:2ebc with SMTP id d9443c01a7336-20b37b7c063mr8647165ad.47.1727377988323;
        Thu, 26 Sep 2024 12:13:08 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e543dasm1740175ad.258.2024.09.26.12.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 12:13:08 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:13:06 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
Message-ID: <ZvWyQo+2mwsC1HS6@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>

On Thu, Sep 26, 2024 at 08:39:29PM +0200, Andrew Lunn wrote:
> > +&mdio0 {
> > +	phy0: ethernet-phy@1 {
> > +		reg = <1>;
> > +	};
> > +
> > +	phy1: ethernet-phy@2 {
> > +		reg = <2>;
> > +	};
> > +};
> 
> Two PHYs on one bus...

Thanks for pointing this out. I will move phy1 to mdio1.

> 
> > +		gmac1: ethernet@ffe7060000 {
> > +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> > +			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
> > +			reg-names = "dwmac", "apb";
> > +			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;
> > +			clock-names = "stmmaceth", "pclk";
> > +			snps,pbl = <32>;
> > +			snps,fixed-burst;
> > +			snps,multicast-filter-bins = <64>;
> > +			snps,perfect-filter-entries = <32>;
> > +			snps,axi-config = <&stmmac_axi_config>;
> > +			status = "disabled";
> > +
> > +			mdio1: mdio {
> > +				compatible = "snps,dwmac-mdio";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +		};
> > +
> > +		gmac0: ethernet@ffe7070000 {
> > +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> > +			reg = <0xff 0xe7070000 0x0 0x2000>, <0xff 0xec003000 0x0 0x1000>;
> > +			reg-names = "dwmac", "apb";
> > +			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;
> 
> And the MACs are listed in opposite order. Does gmac1 probe first,
> find the PHY does not exist, and return -EPROBE_DEFER. Then gmac0
> probes successfully, and then sometime later gmac1 then reprobes?
> 
> I know it is normal to list nodes in address order, but you might be
> able to avoid the EPROBE_DEFER if you reverse the order.

The probe order seems to always be the ethernet@ffe7060000 (gmac1) first
and then ethernet@ffe7070000 (gmac0). I do not see any probe deferral
in the boot log [1].

Thanks,
Drew

[1] https://gist.github.com/pdp7/02a44b024bdb6be5fe61ac21303ab29a

