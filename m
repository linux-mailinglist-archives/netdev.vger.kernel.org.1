Return-Path: <netdev+bounces-167449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD5A3A508
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6533B3945
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D5270ECB;
	Tue, 18 Feb 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn4v/BxG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4B18CC15;
	Tue, 18 Feb 2025 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902390; cv=none; b=aKJO+XobUrqR2VaUEVCLW2z//4gz/7qDTPvmWTPNDiE6yzl/fWYhPOnTdfDdokDsWlY7hCpOvdF5z75+8ubG2cVhnCJXTfvH0LpFEXWZvY3XtgaihwiIuePXtIhyWLapbZbxk6Q+styR7oxbLkbRO7esmPjsC8YDsQ2Q2z9qs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902390; c=relaxed/simple;
	bh=Fw1t4/XZPhU/Ym8pt7ckV0tIUpcEQrQMeA8JgR5SvpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUxM+8QEhaTLYtLIKYUPfEF0O0iT1vZMIbISAeNKMwrEPzANP+JK5CrflKPvYLOowiHSHaGeK3BBaoZlLTWvq4eW1jDiHlPX9JWvU0mM8aQgYzALalqP/DtgRb/0ntPorKneTcK/PxNfqDt3Vmg+35lMy2RVbUJ06S6+1MYF29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn4v/BxG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so674072266b.1;
        Tue, 18 Feb 2025 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739902387; x=1740507187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TsYeNIQ+FlX/aj9gMCCQxPPx4VgWwYgaeivLd/Q74Vo=;
        b=Mn4v/BxGIja+zVpWT9GiiWMp3te5mq/uLPf00RU3aVIbfrV3+KIad2V5W2MoGTAT7P
         lxsedIqtNremfX5L4PxA3OLIxUeD6DEpaEbX85EXXTSByZNS6pkF0jmcmzqlLY+oapFy
         ZsCzDOMgoomF6NrUztKpp/eYi1i21Zgh92JpZDjRCg8hFsURiTO8OQvu+EHiUsFuPkuB
         xk4LjTTTDA8hcPN8K9QtVw8GT7P+8BjWaloEIvWZfz+dOgg9t6uPEzl5jOcUBzQtJr3M
         UkRT5M/h4saBCIpRy7yC1JNmUuZG/5iCNtXoU0oNMs65zyhBmvpi577WbCv0zaWwmuNU
         fTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902387; x=1740507187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsYeNIQ+FlX/aj9gMCCQxPPx4VgWwYgaeivLd/Q74Vo=;
        b=u0H4eHith73WxDehwP4VQlxnXIzFxxe4K7p18fQ9e0K3NTuvZe++HuJy8xHdSacInp
         BSftzSYLXSdLM/0toqeui4p61O2KcOfm96ivOdw3D/Q+AqVD0n6O1rvaFaY/R10JexMa
         hs/ZreU/nC9yQ3WdsZsf7rgMa5PhtwUA/aWDBD5WHkGPWdhCjrHRvRJyQmuuhwJO8nrL
         a0yylua60tdtO/C4z14I0d+R8+F3iybHadiEOceUEuFbeBVb3uUnb7K1Ujv7es2niIiq
         meYPNhpW+kbRgNYpxs9nwXw0yUOVNCWHzHiZ33iH5mjyDxNN8zk2oPHts+FUafKC1Ltf
         kkvw==
X-Forwarded-Encrypted: i=1; AJvYcCX+AuwBdMVNWC+JcWu59Q9qj1c5jI4B1OYGU6gTDR5zjuOqInKcu0YQaDmG+WDm7LFAG1MOCGRDwbcKRA8=@vger.kernel.org, AJvYcCXawM/DBhAICqCIaFjnsW4ptAQN4JngTwCN/gx7Jsm1JE1taYSqsPl6+tBObaw68DTFhGr7wM7E@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGOrsixUZBNuaENJErnIe97A9qGUgr/2OkapwwlnnmEKZyUNR
	R1jDSgx+T1xNUhfA9euiCAjRU5W7hHbkq095NsvPWDsMYYiPNiOU
X-Gm-Gg: ASbGncuCWxntr1/AjxvHu6VBknTNUlGR2gHWoy4CIadGOtQxVl/jMnX/Nqu/kA5HLHi
	vj3aE+gBe5FpEVapi3w0C79oETk91Mmvp/RHUm3oZynaflvPu+UI5L/+Tdtw+uVZ4jrGOON/sop
	A7z/1r0uPCOWoMRvgbi74XfWHJV5VwQAsW05zMeWSvWw2URB+IDr6fFzCL7NX/8fUyXFn+NF2Pa
	skhQYDF5Ka4U5MhcHlhu80O+JnRWlvpSeOZkJ7eP97fq71DkaHFnLBXQ9VAaRRhO0Sw3YvwFpjv
	AZAgPosBenxB
X-Google-Smtp-Source: AGHT+IEJHbthkACTR27TV8/8N6o8JA5RJ5EG5u4nvVcnlmLMhwVv/VD/ojGkgystZjEitS83mYV2uA==
X-Received: by 2002:a17:906:7312:b0:ab7:bcf1:264 with SMTP id a640c23a62f3a-abb70a7a559mr1597792166b.5.1739902386414;
        Tue, 18 Feb 2025 10:13:06 -0800 (PST)
Received: from debian ([2a00:79c0:625:3600:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4fc0c29sm334527766b.157.2025.02.18.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:13:05 -0800 (PST)
Date: Tue, 18 Feb 2025 19:13:03 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <20250218181303.GA3816@debian>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
 <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
 <Z7SuqnfPJD-qQG-c@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7SuqnfPJD-qQG-c@shell.armlinux.org.uk>

Am Tue, Feb 18, 2025 at 04:00:42PM +0000 schrieb Russell King (Oracle):
> On Tue, Feb 18, 2025 at 12:54:29PM +0100, Marek Behún wrote:
> > > +#define MDIO_MMD_AN_MV_STAT				32769
> > 
> > Why the hell are register addresses in this driver in decimal?
> 
> Shocker - some documentation gives driver addresses for PHYs in
> decimal.
> 
> It then becomes a pain to have to manually translate back and
> forth between hex and decimal if one is reading the driver code and
> referring back to the documentation.
>
Agreed. Is it worth to change addresses to hexadecimal numbers and use
BIT and GENMASK for the bits ?

Best regards,
Dimitri Fedrau

