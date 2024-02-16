Return-Path: <netdev+bounces-72459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D6F85826C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954971C20FED
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444012FF89;
	Fri, 16 Feb 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTlNlHgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17D12FF6F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100805; cv=none; b=D89dQdT+Unpi/kuppFi9V11Pk3rGHuH7rYdsi7eTyJq72FB9QrbYC+2ItUkcAGPHfPv3adctcKhpRq/7UK1+J0TxVJ8+ogJbwlSh2kKNtOvK/uEps+9JIGjwzK5o2rXA4LRITqezkIPyFyz8LooR5qqFowR4buirNuQRRXyKwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100805; c=relaxed/simple;
	bh=LcZm2kWHQ4w78fgPQiXn6fezOQZ4PZIfAqO2QKgVre4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8iudjvC1wx3HFfZy5CrQArIYvafcGWnqONg0cobpSBHmEJ4nFoNXfw5EnUBqoU7yRz0V1K6NcmZGm0fl49+Ub33lRsgBQZPgYf8KagdPVVezXzjLbaqLSs/XMvH8CPtA1QEKD8o3yHMfSRjuhyZ0kbR9T4itxoI+qW8pa9rZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GTlNlHgB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2373448276.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708100803; x=1708705603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44tIHP3e27m9mssG+F+MhxgHY8yrYPkp9JDOgoTDz6k=;
        b=GTlNlHgBjngckS2bqahEVfaHLmZT7hItTbsRUPRkylEaTS3U0rg1cZ7MBDcSDzQVW6
         HnCoAEOq4cKV0xelIa8Hr4kciMMYPmKat7L2Bav7DXzj1VAmVJxgFrs1rJsNP0Rxc8Rx
         Tk3L8+4lVEkBhWSMGN4kapsJR00FXmEhddi4HgdtTSFuhdAthJRmW+p8ZQZvgCmJP/JE
         7VBoyM4eR1yOOCRt3/SNR/2H1VD8DKnV0IH5KvzcoQv+fej3ML3ddZEExOv7xlQ8GNOi
         QeptJG7C3epNKhif52dnDqQLFqmeAD8iySp0sz+2lGFz7X+BYCnbAWwnX3EAGfb0TBQ0
         JKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708100803; x=1708705603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44tIHP3e27m9mssG+F+MhxgHY8yrYPkp9JDOgoTDz6k=;
        b=rwuIEnwJ1wMSF5U1VvTaPUb7Y3N9bRA/7gx24uqgmtEIfEIdVL8C8V5MR7+yLNmLzv
         7og7X8hwxp54g2oxWSK2Zy86JuJNdeAnbm9rMWhPcoFEzMcLiclSy5yxTPSnKFBA0pcu
         cg/5MikuI/b5Ius2V3U1DwDsGwO6u/mdIyJVeQxtn+pXyD+0DW5iP6edrKjhVw9/Nhlz
         4ZB+GUElOAJ8xdpf4VKvVgXIVD7me7LdV4RTbaCfir/Cst6LVEFe6UPROQT87BPTYIao
         6ijNwWEJoeucpghMPXgRdz45fve/ETxmBJUzDXajh3BSdnrCXNQWPr1mOAM0C9uEOVUB
         LyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkB52cPYubak5JW5si3EtGtwfYgq6mSAqaBiiNiSq8YoekIYGEUA+CiEwrrOFIE76BhwnptOWHLOPndspDta1e/zVzdVQ1
X-Gm-Message-State: AOJu0YwQsmV/ncvBTGw6TPPTxMuhPhnoEP1bV8SnYzOIUXAWjHJhJB03
	ain0XRbYituIkPpOp3/BXSigegqS2g8vGmkuGAcFEZpBMpoeKijj/svtxkqdopF6OwtEQbCDplK
	rzkidWrHtsut/CZF/IMPC1OdMXHlsUM46kA9LHg==
X-Google-Smtp-Source: AGHT+IFuPYMq3HZ+E6QHC5yDkivYMMpl37gr1Cmwb52o7W8sSopxMnfNkn0jZFsKmhZQB/3N98O6EzewnPB6rpzvq84=
X-Received: by 2002:a25:2002:0:b0:dcc:9e88:b1a with SMTP id
 g2-20020a252002000000b00dcc9e880b1amr4736884ybg.7.1708100802770; Fri, 16 Feb
 2024 08:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com> <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
In-Reply-To: <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 16 Feb 2024 18:26:31 +0200
Message-ID: <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 17:33, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 2/14/2024 8:14 PM, Andrew Lunn wrote:
> > On Wed, Feb 14, 2024 at 02:49:41PM +0530, Kathiravan Thirumoorthy wrote:
> >>
> >>
> >> On 1/26/2024 1:35 AM, Andrew Lunn wrote:
> >>> On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
> >>>> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> >>>> enabled by default and it's RCG is properly configured by bootloader.
> >>>
> >>> Which bootloader? Mainline barebox?
> >>
> >>
> >> Thanks for taking time to review the patches. I couldn't get time to respond
> >> back, sorry for the delay.
> >>
> >> I was referring to the U-boot which is delivered as part of the QSDK. I will
> >> call it out explicitly in the next patch.
> >
> > I've never used QSDK u-boot, so i can only make comments based on my
> > experience with other vendors build of u-boot. That experience is, its
> > broken for my use cases, and i try to replace it as soon as possible
> > with upstream.
> >
> > I generally want to TFTP boot the kernel and the DT blob. Sometimes
> > vendor u-boot has networking disabled. Or the TFTP client is
> > missing. If it is there, the IP addresses are fixed, and i don't want
> > to modify my network to make it compatible with the vendor
> > requirements. If the IP addresses can be configured, sometimes there
> > is no FLASH support so its not possible to actually write the
> > configuration to FLASH so that it does the right thing on reboot
> > etc...
> >
> > Often the vendor u-boot is a black box, no sources. Can you give me a
> > git URL for the u-boot in QSDK? If the sources are open, i could at
> > least rebuild it with everything turned on.
>
>
> You can get the source at
> https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/tree/NHSS.QSDK.12.2?ref_type=heads
>
> You should be able to TFTP the images, write into the flash and
> configure the IP and so on...
>
>
> >
> > But still, it is better that Linux makes no assumptions about what the
> > boot loader has done. That makes it much easier to change the
> > bootloader.
> >
> >>>> Some of the NSS clocks needs these clocks to be enabled. To avoid
> >>>> these clocks being disabled by clock framework, drop these entries
> >>>> from the clock table and enable it in the driver probe itself.
> >>>
> >>> If they are critical clocks, i would expect a device to reference
> >>> them. The CCF only disabled unused clocks in late_initcall_sync(),
> >>> which means all drivers should of probed and taken a reference on any
> >>> clocks they require.
> >>
> >>
> >> Some of the NSSCC clocks are enabled by bootloaders and CCF disables the
> >> same (because currently there are no consumers for these clocks available in
> >> the tree. These clocks are consumed by the Networking drivers which are
> >> being upstreamed).
> >
> > If there is no network drivers, you don't need clocks to the
> > networking hardware. So CCF turning them off seems correct.
>
>
> Yeah agree with your comments.
>
> QSDK's u-boot enables the network support, so the required NSSCC clocks
> are turned ON and left it in ON state. CCF tries to disables the unused
> NSSCC clocks but system goes for reboot.
>
>
> Reason being, to access the NSSCC clocks, these GCC clocks
> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
> should be turned ON. But CCF disables these clocks as well due to the
> lack of consumer.

This means that NSSCC is also a consumer of those clocks. Please fix
both DT and nsscc driver to handle NSSNOC clocks.

> > Once you have actual drivers, this should solve itself, the drivers
> > will consume the clocks.
>
>
> Given that, NSSCC is being built as module, there is no issue in booting
> the kernel. But if you do insmod of the nsscc-ipq5332.ko, system will
> reset.
>
> Without the networking drivers, there is no need to install this module.
> And as you stated, once the drivers are available, there will be no issues.
>
> So can I explain the shortcomings of installing this module without the
> networking drivers in cover letter and drop this patch all together?

No. Using allyesconfig or allmodconfig and installing the full modules
set should work.

> >> However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
> >> gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is it
> >> okay to drop these clocks from the GCC driver and add it back once the
> >> actual consumer needs it?
> >
> > But why should you remove them. If nothing is using them, they should
> > be turned off.
> >
> >     Andrew
>


-- 
With best wishes
Dmitry

