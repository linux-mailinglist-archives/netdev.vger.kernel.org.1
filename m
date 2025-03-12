Return-Path: <netdev+bounces-174424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F4A5E868
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F43ACF0A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97301F153E;
	Wed, 12 Mar 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4FXY7du"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAB1EB5D5;
	Wed, 12 Mar 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822195; cv=none; b=QBKhlJwEUlHrqw/8ZrZwNoPHmvZ4I0uzNpOjt4/JxRwQCa4sqPdjDJmuFPMn1/F1p8v5cMiFMuhsDJ5HexXQcV9seeMFAEqiN0hadlJuRIhaxwdKE1lMqdJTvrI8h5PBzsaFKvr+4JYJ4hkgHk+s5QJQRP4aiLPWMFZnm70/X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822195; c=relaxed/simple;
	bh=fspsdGz14WdzOajPJOMQzjs2D+NwwiVnmRowuuxUM58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkVFywtgFj7NpXzG9yeAHu4eocrmn6jP8C3TbXCLscTXuIjB74ApQpR6THqvXQs8+I975nsl0I9Zgw8xW2cctnGeQsDYtyVZW5tVun/gQy8XHELVFg74+lp+A8/2NV8JC2dKaPU5mxuiPYxq/YMtoBnYLsmWwKr81m3cCX5Osrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4FXY7du; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be6fdeee35so58181785a.1;
        Wed, 12 Mar 2025 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741822193; x=1742426993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLfGaIgvY5ZVl4JrSGdwM0o3tslIHB1ct9yF4dQRXlI=;
        b=i4FXY7duuyX6pN5ovYLEdff5ApcFG+PFEDiCJ/cRpAXfqaYfEN2GOagk4JYTqtt+wO
         UL/9Dqj+3eAFlk6hAwZGloUvp2pP32JYaUqdxfDVnWVpJrR4YlXqyJTYfWQ92PiiRrrX
         h+SbB2UYt0uStmCd2nNceKqMrdTw07/CPEdpkyFdoIG2BZEDc3fuTRJlEVUb5W+MJDkQ
         CeWDrNyreqQfUkGXj0ALIW971k1tsPI0SMDN0Os/lKwvMYU3W/iUp7xZCZFs6W101sAd
         Vs/v/psDntGEsYKMVhEPMRQS3pbP6ApZ2kAQgzat+0Cb0Z4CV9BDX2axA4qv8vWq/K2L
         r0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741822193; x=1742426993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLfGaIgvY5ZVl4JrSGdwM0o3tslIHB1ct9yF4dQRXlI=;
        b=I57ow0qLiliXbd9HiluUYhgAzNgdgMx509TdNWMx7hohk0J0z3ZJ98S25IhSig86zJ
         g7pXXk81vde9F+fUIdDtZmaWLEmY4vWJ0V1D7gMumEcOgTFg2e3VyP8fmuwU/Nr/e5cq
         xxb+wGKQdaZExf5cbvktsEsU7CXFhqCPIIcrC7tMax5I6XvA3ydHVJILY+pg9BeOZoxO
         GVDlTqjIt8fCoi9ZBI57YMengCTdlVUThtOLo1xzLmrW1sslIc6UzBGngCPPMJtVFrjU
         3xFAFgCD+tR+3bJVw00Onz8Wtzg0zSfVwx4FxHj+NiL0/M/jBSYWS/AYdWy1SF5nobGw
         a9iA==
X-Forwarded-Encrypted: i=1; AJvYcCU5uYYh098Rg6N9A2gP1v5aO0BZ/TWcquwZD02f7/VUGUXPohzHqynWN26l+HjUupSEsij7GVbVAAQQV2mG@vger.kernel.org, AJvYcCU7WRiE+IogFm3NwqEFAXH3jXariUaJm97eAhLRsIvz5bB6uOxIc7DOUV/oKCsJJzcp9odR/LlF@vger.kernel.org, AJvYcCVVgHdWzhl1WkTLYTT5bDUBMkM+MPX6HCpdXRcchcXPjbiNr0sRE27/InKOMhbJKRFk8YNbaYlVH5nY@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRDakfWpFcs+074F5pcDNwmAf1PYW9VtYNE92JcF4bHvo/SER
	VUVzmZIp7CphnuGgLWmrlWsexOrT8mxYTzydCJ1seabr8a+0h9Ch
X-Gm-Gg: ASbGncsgnSt05UccCJHSL5gJkWE8aKknyWcqHIH20L/eBZR5+EE7tprRBkEKaPR0qSA
	Y9/ydAefGCHD5klVqO6Czd0/XkjHiRo/d0yXMp3rc4X8FhyFGXMIeg8xbpLfCuDfZMkmNZR8ZeB
	s6FaY9ny/HRXKgWpmbrypc0xpVkf8Homd3keeQz9SdhvWWb68BZUAylPeyFs4VHMtnG8ALi+1Qq
	cH8e1w1h4g7v/vvnRuB7YF4Sgf54tL98lxdVZak1Atz9o7aBSXgyUGKjhaeSDWM5JKHdnNJIqtn
	h//8hL97C/8grPqBfcSP
X-Google-Smtp-Source: AGHT+IG2pfcqk2sk8gdrKSI0hu3y9BsjzCHFtgLXjVkzz57vH+f9YiHwGclAKa4AV4l6e21yRYMqxQ==
X-Received: by 2002:a05:620a:2581:b0:7c3:d5a4:3df3 with SMTP id af79cd13be357-7c4e6112241mr2951625485a.34.1741822192828;
        Wed, 12 Mar 2025 16:29:52 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d8aeebsm14867685a.103.2025.03.12.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:29:52 -0700 (PDT)
Date: Thu, 13 Mar 2025 07:29:43 +0800
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
Message-ID: <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-2-inochiama@gmail.com>
 <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
 <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
 <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>

On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > On Tue, Mar 11, 2025 at 12:26:21PM -0700, Stephen Boyd wrote:
> > > Quoting Inochi Amaoto (2025-02-26 15:23:18)
> > > > diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > > > new file mode 100644
> > > > index 000000000000..d55c5d32e206
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > > > @@ -0,0 +1,40 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo SG2044 Clock Controller
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > 
> > > No description?
> > > 
> > 
> > I am not sure the things to be described. Maybe just tell the
> > clock required and providing?
> 
> Sure and point to the header file with the binding numbers?
> 

Good, I will add it.

> > > > +  - |
> > > > +    clock-controller@50002000 {
> > > > +      compatible = "sophgo,sg2044-clk";
> > > > +      reg = <0x50002000 0x1000>;
> > > > +      #clock-cells = <1>;
> > > > +      clocks = <&osc>;
> > > 
> > > I think you want the syscon phandle here as another property. Doing that
> > > will cause the DT parsing logic to wait for the syscon to be probed
> > > before trying to probe this driver. It's also useful so we can see if
> > > the clock controller is overlapping withe whatever the syscon node is,
> > 
> > It sounds like a good idea. At now, it does not seem like a good idea
> > to hidden the device dependency detail. I will add a syscon property
> > like "sophgo,pll-syscon" to identify its pll needs a syscon handle.
> 
> Cool.
> 
> > 
> > > or if that syscon node should just have the #clock-cells property as
> > > part of the node instead.
> > 
> > This is not match the hardware I think. The pll area is on the middle
> > of the syscon and is hard to be separated as a subdevice of the syscon
> > or just add  "#clock-cells" to the syscon device. It is better to handle
> > them in one device/driver. So let the clock device reference it.
> 
> This happens all the time. We don't need a syscon for that unless the
> registers for the pll are both inside the syscon and in the register
> space 0x50002000. Is that the case? 

Yes, the clock has two areas, one in the clk controller and one in
the syscon, the vendor said this design is a heritage from other SoC.

> This looks like you want there to be  one node for clks on the system
> because logically that is clean, when the reality is that there is a
> PLL block exposed in the syscon (someone forgot to put it in the clk
> controller?) and a non-PLL block for the other clks.

That is true, I prefer to keep clean and make less mistakes. Although
the PLL is exposed in the syscon, the pll need to be tight with other
clocks in the space 0x50002000 (especially between the PLL and mux).
In this view, it is more like a mistake made by the hardware design.
And I prefer not to add a subnode for the syscon.

Regards,
Inochi

