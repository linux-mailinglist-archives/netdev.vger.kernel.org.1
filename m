Return-Path: <netdev+bounces-98483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E368D18FC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A7E28A935
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0816C694;
	Tue, 28 May 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M81ndMM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984E16C691
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893659; cv=none; b=ABF0PH8bGeiLg1nPn3t+VnmUiITIIpZ13AvKMHjvDJWV52ulhkX0fDag8C0w77Gql4W7y+15QNMbAwJqxW5FK+IDxK0fWXqWHEXV6EzA8RqL25Cv3IbcBM9c2p0946uo3w/HXJpt+E2D9q9D2rYyLo2eo0HDNfob9fI5Ik6SaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893659; c=relaxed/simple;
	bh=6DsDltk3tw6ZUlKan1Hi5KU8wAdc0A7pjp2K5oIFm5w=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSiIXVcIlMnrfROYQfgxy0ow2ZMirUzWHORr6PvBuGjQQLlyptRe/rqZg09Bs0ji7HCWhL9x1/iYn2lN74C/ui/AvdMIG6zg56el9NmhPYDQaKrpQngmHA5P79iSzsLfLJzb6k63JUP4ZizvbREWOEMEcwxchSbPtNaR6kBVUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M81ndMM3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED16C424A8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716893653;
	bh=t+MxTuy89r1XuUchAjCOh9jZjiiQ9E0Lr8aKDQQ8Cs0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=M81ndMM3yCUmRN5Az4uH0S6naiOpuocFbfNa3rwqrna1U8+pzPQMC5gyZ2l7DBTN7
	 C0D0T9MaGyeNU8t7PL7K+7VWZNFnLmmZJZHcRgIkyE+VBwshC4hYblRhj2iNZKoAVt
	 7umu6A4MFEeeJrggEDaBWg2MH41S/Wk31qE0xXxwHD7sMoY+S+LytTrYKG00sVXw/i
	 NwPAAD75OwPplea3JUMWZLK+xywGaEL6aHKkTKnXNDqVOSywJqswirXz7a/LauctiV
	 bp1LKi8YV1RQ9dCvZQ0xLsYwmExwxS3fLTQhD6rQSxZMwFwnJ9iUVIBrTuaa0Id8bg
	 4Zzn2Hv3/xkYw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d1bfe016easo489849b6e.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893653; x=1717498453;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+MxTuy89r1XuUchAjCOh9jZjiiQ9E0Lr8aKDQQ8Cs0=;
        b=jdHiweUsHo6t3HRoeL2VDsi98kHhq/02apLPpj56G/YRnyQOmxHWuOjNdlkGbxiqb3
         /S/NbWIwQKb/u25ia7uEHlC8LxlKWD/mqH0+9M/mPycshtZNAqUEKmASOofketMbyoa5
         RdqesxTaQBnqVzsSl0O1CAqKzeaJhpwhTY3+5UdZ+zW8N/zgtdnGPaYbetQYbvHDWP2H
         kDaJNOnlUTXzJahIOgjf1ynVKSj/l9DELuf5kxepMIbSSi9rW+M8Yrm5rBXPhMgpJh7O
         kexM+fwlsmHWWd796g6UGexcMyRE+HPTiZz6v21q4NCIa5yD3norGKwlzTGdeI8997O1
         JUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVHa/LCFU1RieuVJjQLLLR6lcoNPVSELfiPMl9Gd6JMqmnEzCHtUJ7ibFD9fo0HtodZgu4YXPvOF2di0x2td2weWf/J1u75
X-Gm-Message-State: AOJu0YxSIM6GTOnLT7F//MIVpYXt0EVfSZaHTqPvGP2sZLfg6q+yTKsE
	6oVBTTkLa+Z9beTNIQYc47JSqJK00NZgszLwviPmh8YNd1jfpO8Argsyuz4NhrNJ82E/2CDK/Ib
	WBriG81Rm0vs1d29bductFiypFCvjCoymUI6CnK7rb2SONX2FIXzSc6JR+GHvZtRGIIlAQMG9Wt
	RuPeufCUUmTDihQ4KH03YN35urszFykgHwqzO6jrJ6sx3Z
X-Received: by 2002:a05:6808:13c3:b0:3c9:6987:1799 with SMTP id 5614622812f47-3d1a7c30f2dmr14667509b6e.55.1716893651287;
        Tue, 28 May 2024 03:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRnQ2YYO2njdHSKr+gsseo2W9USVkHj8m9Htc1vxAMSS1DDFiKtyDLGfxlb2TUj9R9LX16696Z0LisylVtCkk=
X-Received: by 2002:a05:6808:13c3:b0:3c9:6987:1799 with SMTP id
 5614622812f47-3d1a7c30f2dmr14667457b6e.55.1716893649577; Tue, 28 May 2024
 03:54:09 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 May 2024 06:54:08 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240528015120.128716-1-minda.chen@starfivetech.com>
References: <20240528015120.128716-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 28 May 2024 06:54:08 -0400
Message-ID: <CAJM55Z8KuzCMEqE4x2rsoiJTjkWhf-B5bCzaWMhbtDndZfNNOw@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: dwmac: starfive: update Maintainer
To: Minda Chen <minda.chen@starfivetech.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Minda Chen wrote:
> Update the maintainer of starfive dwmac driver.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..2637efd7660a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21316,7 +21316,7 @@ F:	arch/riscv/boot/dts/starfive/
>
>  STARFIVE DWMAC GLUE LAYER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> -M:	Samin Guo <samin.guo@starfivetech.com>
> +M:	Minda Chen <minda.chen@starfivetech.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> --
> 2.17.1
>

