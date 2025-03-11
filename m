Return-Path: <netdev+bounces-174055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17805A5D327
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 00:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B5917BDCB
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0F233145;
	Tue, 11 Mar 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edwniisu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3B1F09B4;
	Tue, 11 Mar 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735901; cv=none; b=UzCswBjzEZPxUGfv723E5761feOIGKf7MxR4kxY6hEIhkMBk9LghmcI/xuhCZz18remLekLY0iEEAmw3Fu1SXC2nNik/PLwT0RZGwfbHcZ/wTIRMm9O08BYj3Iw9hLzpVnYjWh9bqdj6WZdvOfvNdQeKbkn0wXHU9BasNziEULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735901; c=relaxed/simple;
	bh=VBwwG7l9rCWl77EdQeNbuIKmifjvy46Iw3hIDBS6RME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSeaTWZE8DPlbVWiWkBxPb25rubQFaC6CwvGbA00dGW0RRLKyF+OF2znPbp76OUvfMofSMfjotmBP+T0K471WRi68UjZMtHb9g6onNu7SfCzyfDn6QGrmFU7pxNVjv2zGvLSRhIBr+6z392Z7idCuSLNifqdOEk92g/QP4SBEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edwniisu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c56321b22cso30124985a.1;
        Tue, 11 Mar 2025 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735898; x=1742340698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csNibhOv6YnsrzbmKIDpYFSAlfzjMkpooBOgsitHNaU=;
        b=edwniisu5JMgGAa7iNkVf51ZkF8vmDd4mdG77GEIE+o9rXhAYUfvuBuZ63LK12yxl3
         Wlm587v4Artrk/hUpiQWCDBN5yzpIIdkEOqQYjz1pM4wbJQlQZBssiZGmp7fCig6lstq
         QQEMiVviLyk8UEKwU3XnUb8SvwGtwHAhMvKLyD//Iu+dTgU/+O7t8VICnWfCHY01wqjh
         oUh514zl8PyhyGwKAXWNpRQoRqVkq4TM/wxDp4daFBEHMUIO4VeMefMiqavBwtMl56TN
         e3HmOtw9WKOnO65yZCXcrNdW7XwXYcIMGQ3papqFJNFj4YnjCWMslvLRBPxeCO1t85vV
         jfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735898; x=1742340698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csNibhOv6YnsrzbmKIDpYFSAlfzjMkpooBOgsitHNaU=;
        b=Ny3fXEzTzun/t2iPO3MVUYngV6p7p9CvFdYfNw+ps7ZjVSyeRyeubVHg68cdkMcU0Z
         /OuSuylNBa0e9SvyoXjHnyByq+vZYJKRip6ayX7tycK14AkR25yRvnRaVf4wJZMAfkAI
         9EMcjKsjQy79989xdo7T8vFScfISi6S/daaauYbouasg8CYyx9fsIPA5uI7Bhdp6MbHg
         8z8ZN3nRWzgkvDbUvBhbOxMecLryDPjlUUG5ljxDax3z2ISoLmsnLyBUX4NmjenCyeof
         fpY70jRccnRXW8EyATxFs06x7aasWJhnBiOFrUIrBfukgX/bhId+Egzh5eXAtlsPZqqQ
         OAXA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9W9QSdKnTUcx0PI4L2PPCDxOAyi2lS2WvUOgSkpA7NEVSze204jFYtvYwFk/lSmngMLgpZ8Nobsdef3Q@vger.kernel.org, AJvYcCWsQw7X0cySpMfpcfv7hk+DeFlGK8/dbTLvm6hYBV7lsW4RIr+QmxJEXcsIA0Y+HSp7wMQVWGaC3Um7@vger.kernel.org, AJvYcCXGl7iT3Xmwr3k4cwdl3vHFHZ/JM6/50XyjE0bcftDXir40lFdlyfsr3nmwCN4IlaKdTYKE8Vf1@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOLOeqkfGkEesNsfaOmhChu/13s+3rwmdIERXapyqiRmUA16S
	tYXIHODmpeeLYMd91+dZLnSjVyu6rjbPWfLS+l75FYqS2tmpX8e4
X-Gm-Gg: ASbGnctiOFHbGYrF4Ftz9TSVSfezVbzCEpoQvar6ydNtZbZUpE+HTe3yua6ZbGQkszk
	YBSDrBygSX/Plo3+fWZ8OrlpntMGV1yhfPmPK7DKlmUmIXGxGcBohWmzUwq0QwfxqX7Ew1Wza65
	zPIupysVTzi9BwCbvcMWiww7zNywI9/kOpHY0yJjGPqXQ5Jpqbuy281FzwX4s8a6FZQzkkJ5cZ9
	/Y4vtff3aW8Qb1uf47Vo1S9t9UNxgOI+oAYua/NDhj9y8dV9v05N+JFnI18fWOHIIDKlThjqXm+
	8Fw2PeQMU7Jb9A7Xj79iNGytaUxyXWM=
X-Google-Smtp-Source: AGHT+IHq9hqC1JJsQsEh0Cz9ZylVSH0tGSrNyvWOdRkyjR2J/hgMZweHvicPAvizQ4S8l8+AJa2jhA==
X-Received: by 2002:a05:620a:27d3:b0:7c0:b3b4:9e73 with SMTP id af79cd13be357-7c55eeff050mr593292585a.20.1741735898337;
        Tue, 11 Mar 2025 16:31:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f715b4fcsm78391226d6.78.2025.03.11.16.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:31:37 -0700 (PDT)
Date: Wed, 12 Mar 2025 07:31:29 +0800
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
Message-ID: <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-2-inochiama@gmail.com>
 <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>

On Tue, Mar 11, 2025 at 12:26:21PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-02-26 15:23:18)
> > diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > new file mode 100644
> > index 000000000000..d55c5d32e206
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2044 Clock Controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@gmail.com>
> 
> No description?
> 

I am not sure the things to be described. Maybe just tell the
clock required and providing?

> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,sg2044-clk
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clock-controller@50002000 {
> > +      compatible = "sophgo,sg2044-clk";
> > +      reg = <0x50002000 0x1000>;
> > +      #clock-cells = <1>;
> > +      clocks = <&osc>;
> 
> I think you want the syscon phandle here as another property. Doing that
> will cause the DT parsing logic to wait for the syscon to be probed
> before trying to probe this driver. It's also useful so we can see if
> the clock controller is overlapping withe whatever the syscon node is,

It sounds like a good idea. At now, it does not seem like a good idea
to hidden the device dependency detail. I will add a syscon property
like "sophgo,pll-syscon" to identify its pll needs a syscon handle.

> or if that syscon node should just have the #clock-cells property as
> part of the node instead.

This is not match the hardware I think. The pll area is on the middle
of the syscon and is hard to be separated as a subdevice of the syscon
or just add  "#clock-cells" to the syscon device. It is better to handle
them in one device/driver. So let the clock device reference it.

Regards,
Inochi


