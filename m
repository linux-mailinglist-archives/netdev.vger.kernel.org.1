Return-Path: <netdev+bounces-146614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC489D490B
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7452B238E1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431D1CBA17;
	Thu, 21 Nov 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbZ5lUn8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76131CB9F4
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178508; cv=none; b=USZo3nIyj/UZp24t55Kci1WZHFBFVfjNYRE/TzxjZJJG1+y/eqzOAty559YhKpPCzwia8ynF7YHDDo32HMdtyxlekaRSs/E4Toi+e7Bs7IxEFE/ZbZb00bG3FUOy4Pva+bEU5EsJwcQi4tD7BrEBumKaPtM9YqqPpRZOjk/Ulg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178508; c=relaxed/simple;
	bh=OakpjTtQorQ2BeUpm+/i89nPTw9w4eLYabvPpcRfSGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J/FP5UKk/AyJeeBB9riTpiUQMiC+T3t9GvlxVl3FZCNpICIbRU/0SyJWzBQ5c8AcufToz0hewoBSKQ8j39aN2dEbgRiXSVz8z0NKl/Tm4L1kVtllR9hebwKFpyx+fQ7Y1B1E4oaZNs8wBNzY1RBKva1BpZnVsWDVgMQNMULp2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbZ5lUn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732178505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EfxJ3fmdocd7gaMUfcoBEkyZJYyM0opLmf/LIX4Ouc=;
	b=gbZ5lUn8rzSAEGehFuasML3og/FMlirDDovCkblhdlytrUmrsN1OHUZDgpPbSgV5nztEY+
	LIuW6twPsW8xLbfioHf58JWuai7vL34DsB415C7upOVSQef8seYCIW821oVNcdCJaJ083j
	SDFdLrtuVND/uw615WeA077IONHbAQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-6rg1c241M2WNJTupPZjetQ-1; Thu, 21 Nov 2024 03:41:43 -0500
X-MC-Unique: 6rg1c241M2WNJTupPZjetQ-1
X-Mimecast-MFC-AGG-ID: 6rg1c241M2WNJTupPZjetQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822f550027so330425f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178502; x=1732783302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EfxJ3fmdocd7gaMUfcoBEkyZJYyM0opLmf/LIX4Ouc=;
        b=h5UBtAcl8fE0PfL4SSQXQGsWcXtCByFlZBw/GCm9/9v0g2KRI8Q2ai+TZWy8LzS6Nm
         8udm3e12w2pp1u4otdxUylQFAV15RB9wCnJYybveRbCeM1VYPJj2J72CVXPDj8Qvd+nD
         XMNqXDndV05RKM+vYXHwX7FIY94C7aInFU1XJGVe/lxpl9iwOgrcb8zyunFoVXsAgtnL
         zIujdXEVneOfSnkT/btEScyL2HuSwo6dPi9Yqt41sWgQVEZRAMTnPMHBKNvzq8t0wnhO
         eDpW1z8cyH36XPW22008iLcGcJwVrSOccn7bh2kYXA1XS+542cKt/HhoWaGdWDIbgkUZ
         zaHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7CpWMnFePBr6SbpTtrP5e5yAkXejTKjkeWexT6SzeQ5fEpJfLlpVlCz0l5pzYdlsuOkd/to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlC/lswNzo9XOB+a4ibZLOE6Mqtn/MbRg8WH3oP/XG9kXnB2ZM
	g0uVg41EiujCqpy2A77Cu0SV2gQsjPP4AvQCRNzCegT3l+IoG3dNARnpKF/Ukb4x/F8r778hRmP
	LYwznkLWaJ6eimYz2FegbF7MZ5DaI1gkyUQLSg+H2E5SUUd3OXd5fWA==
X-Gm-Gg: ASbGncuUZXxotxcMeCQcZ4w1m0zP+yc6PhLutWw6WzFc40b0IubA8767CtJfowyMp4I
	zgnkskuxquVgZkSMUYC5qe9XXe9hunfYvi75Z498k0KdJ/Olz19W5nzG1PnSzSELpzIGHTqcite
	8hijJcXc1Q3+GwmmDdtmC+wMznPqD1ftr7DufGxKj+9S6I3PeZtU4MoaK0GbMkXP0Fn0+rgoFg1
	S9MLmw+//LTcP2/gAtTwvJ1RJIwRp6PT3d8UBWe61TNLqcmlcY4aFqqb46euCtHSRKr2sqCNQ==
X-Received: by 2002:a5d:5f54:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38254b2905fmr5006766f8f.48.1732178502000;
        Thu, 21 Nov 2024 00:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWXza0JZ2QIRJ4eZp5svlyv9eMdR/9gHUUjPVmepznkQmbAhjCmDV1VegOdet0I40IWemEKw==
X-Received: by 2002:a5d:5f54:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38254b2905fmr5006743f8f.48.1732178501624;
        Thu, 21 Nov 2024 00:41:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea2bsm4297621f8f.87.2024.11.21.00.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:41:41 -0800 (PST)
Message-ID: <13a81556-d28c-46d0-85d6-d2fb1620d24e@redhat.com>
Date: Thu, 21 Nov 2024 09:41:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] Add Aspeed G7 FTGMAC100 support
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 08:50, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three FTGMAC100.
> The main difference from the previous generation is that the
> FTGMAC100 adds support for 64-bit DMA capability. Another change
> is that the RMII/RGMII pin strap configuration is changed to be set
> in the bit 20 fo register 0x50.
> 
> Jacky Chou (7):
>   dt-bindings: net: ftgmac100: support for AST2700
>   net: faraday: Add ARM64 in FTGMAC100 for AST2700
>   net: ftgmac100: Add reset toggling for Aspeed SOCs
>   net: ftgmac100: Add support for AST2700
>   net: ftgmac100: add pin strap configuration for AST2700
>   net: ftgmac100: Add 64-bit DMA support for AST2700
>   net: ftgmac100: remove extra newline symbols
> 
>  .../bindings/net/faraday,ftgmac100.yaml       |  3 +-
>  drivers/net/ethernet/faraday/Kconfig          |  5 +-
>  drivers/net/ethernet/faraday/ftgmac100.c      | 77 +++++++++++++++----
>  drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
>  4 files changed, 75 insertions(+), 20 deletions(-)

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle










