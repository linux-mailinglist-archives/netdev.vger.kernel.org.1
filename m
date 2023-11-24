Return-Path: <netdev+bounces-50935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864817F799F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29506B20F5F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572135EFB;
	Fri, 24 Nov 2023 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9gId/2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E70173D
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 08:44:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2893108e87.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700844247; x=1701449047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUEQlV1akgro0NpiBVcWNMD/MF3mjN5utVYZWVg8mpo=;
        b=b9gId/2ZZJaxNXLG6BVzyJIUnRY4Wx0RPr7HJcIgr0GHZ99fKQHuz0q4JuuBbymjWz
         RF4DkEIZMJS6bl5fwfk1ZRq2i7hX2qN9oAUiqznH8C7GqYaFOPAGcd/uDry1YU+F+6n7
         2hUB3/kSeKQ/uh04FS2KMjSUorvbCpyJQjYhcwh6JWVjV/1htuoP+ypzEuf2a2UmGzOe
         FY3O5jjiBc8zySTRRbOBmdk+fwbvQuCD3/owjR67NeMP/6bhxo2mGx8ln+nPeAPsUFXq
         7exL4GfWr/S0kecrEAHv1O3HM2f87OzHapZt/3YzAhlpCuV5esiCqYcIIudlrOM1AwjR
         zEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844247; x=1701449047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUEQlV1akgro0NpiBVcWNMD/MF3mjN5utVYZWVg8mpo=;
        b=t3WQjtFDEuKzyH+yQnmmqctuHjp+tqhLj4mT8HTusNPDrdBcSWpQ+xzdRzrZd/LmuB
         O6qxvd/ZePWCwuWkPK6llcawAtNK/oPkKbJRT8JjQeaV7yFs4J70wRnZU5N3V7lxhwwF
         b9JbqjAflaxKLrbr87FPfcG6hN+MCcbnrf18cKopFFskfnR3EWIc820k+hKgs47/auNI
         KHNrB+2yIMKk2NO38flk+K0iW/k9gVCJqavnWAwInFc9HNIGvz9m/uLlAXwZ3ag3u+EC
         x9O3mASGQFcXdj2E/cjdy+pjQoimJw6mpWgDW7WuxM1PrfRQ9ohLQd7wVwi+veetEDhi
         Etbw==
X-Gm-Message-State: AOJu0Yxe+wj3t6UIXZ1EXv+HUm81xp7/p2TiU8WMeIPyEX2eW+JIQpL7
	ZpMPTrKb+KSbyv7iFPSFzDw=
X-Google-Smtp-Source: AGHT+IG7mYS5i9FUlFLi2exRPiJhglHVJqhrEQiqNFPjsmxmyu8g16972vmZ4BBTPfNejLAjusOhQg==
X-Received: by 2002:a05:6512:3b8e:b0:505:79f2:5c6c with SMTP id g14-20020a0565123b8e00b0050579f25c6cmr3522794lfv.6.1700844247377;
        Fri, 24 Nov 2023 08:44:07 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id br36-20020a056512402400b0050810b02cffsm545291lfb.22.2023.11.24.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:44:06 -0800 (PST)
Date: Fri, 24 Nov 2023 19:44:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk, 
	dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <3amgiylsqdngted6tts6msman54nws3jxvkuq2kcasdqfa5d7j@kxxitnckw2gp>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
 <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>
 <7dde9b88-8dc5-4a35-a6e3-c56cf673e66d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dde9b88-8dc5-4a35-a6e3-c56cf673e66d@lunn.ch>

On Fri, Nov 24, 2023 at 03:51:08PM +0100, Andrew Lunn wrote:
> > In general, we split one into two.
> > 
> > the details are as follows：
> > 
> > DMA_INTR_ENA_NIE = DMA_INTR_ENA_NIE_LOONGSON= DMA_INTR_ENA_TX_NIE +
> > DMA_INTR_ENA_RX_NIE
> 
> What does the documentation from Synopsys say about the bit you have
> used for DMA_INTR_ENA_NIE_LOONGSON? Is it marked as being usable by IP
> integrators for whatever they want, or is it marked as reserved?
> 
> I'm just wondering if we are heading towards a problem when the next
> version of this IP assigns the bit to mean something else.

That's what I started to figure out in my initial message:
Link: https://lore.kernel.org/netdev/gxods3yclaqkrud6jxhvcjm67vfp5zmuoxjlr6llcddny7zwsr@473g74uk36xn/
but Yanteng for some reason ignored all my comments.

Anyway AFAICS this Loongson GMAC has NIE and AIE flags defined differently:
DW GMAC: NIE - BIT(16) - all non-fatal Tx and Rx errors,
         AIE - BIT(15) - all fatal Tx, Rx and Bus errors.
Loongson GMAC: NIE - BIT(18) | BIT(17) - one flag for Tx and another for Rx errors.
               AIE - BIT(16) | BIT(15) - Tx, Rx and don't know about the Bus errors.
So the Loongson GMAC has not only NIE/AIE flags re-defined, but
also get to occupy two reserved in the generic DW GMAC bits: BIT(18) and BIT(17).

Moreover Yanteng in his patch defines DMA_INTR_NORMAL as a combination
of both _generic_ DW and Loongson-specific NIE flags and
DMA_INTR_ABNORMAL as a combination of both _generic_ DW and
Loongson-specific AIE flags. At the very least it doesn't look
correct, since _generic_ DW GMAC NIE flag BIT(16) is defined as a part
of the Loongson GMAC AIE flags set.

-Serge(y)

> 
> 	Andrew

