Return-Path: <netdev+bounces-146334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C99D2F09
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770041F235F5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B51CEACE;
	Tue, 19 Nov 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="zPOMX9BA"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F98198E63;
	Tue, 19 Nov 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045703; cv=none; b=WlXvJQf8xTC9MwztLNraEbocRQK/ytfeKO1FyLf82YHzbuhAKqP8f1L7QQ8CJUHc2IP7m63W39xow45bAAwYQOAetQFILx15uvzwifitL7immoJwidsoMTifD26cXlPM31NhpoP73dLIzF9M8Hjsg/p8p4OiaAFNHoBaMmGEzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045703; c=relaxed/simple;
	bh=9rOtIf9+5qH5JGQj1SyccUusRCObJFcvjrbKXLl02PU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rImawOe3mtkfQsSaXSMERl258ZhgoGd/1Dxdo3+bkdR7tCfvtRiWMf9t9Be70d1L9XBTis0n2qk6yohd9H4dcilUxw3JpapMlcioMBLcAwhpmA1JIftLmoB+7qfoYFjl4p8tsm3vb8Xazx0HcailKjUfJLRY9qRmym5A6yoT6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=zPOMX9BA; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1732045652; x=1732650452; i=parker@finest.io;
	bh=psRyF88Lgs3hRSIlO7wrFe0tOotT7zyqin9CJPdcNE4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=zPOMX9BAZd8AS/wZR7mhpcqxF14qxHW90ALGb8ayWPTS+e4qc81jXbmECGzo79zg
	 +JfzIH6KsljVW5VeXYaskddQ1xOn1myr3o7zMXP6lon/l62vIe5O7COHLNixq9oVr
	 e+9ebK/nZPDJOPgBQBFR3T2sjBB45FZhgLHRo2EZm7iI0+5euJc7bsSVJBFg6cubv
	 nL59nc6KOMs2hbZ//kWtBDkJF3aoBslkGOFCX+aIGMry/P2ro6xVtg1VUPPclnRnT
	 yuRrfWgRjgq7LpigRZVidECyM1Bs/xQ7BXWGDGQV/UlEv6CE5UnPywNvthTPw23Wh
	 E5qdSmRouICUNH1J6A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MUpdy-1tEUmm1ruW-00Uouj; Tue, 19 Nov 2024 20:47:32 +0100
Date: Tue, 19 Nov 2024 14:47:29 -0500
From: Parker Newman <parker@finest.io>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <20241119144729.72e048a5.parker@finest.io>
In-Reply-To: <f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
	<f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
	<ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
	<20241115135940.5f898781.parker@finest.io>
	<bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
	<20241118084400.35f4697a.parker@finest.io>
	<984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
	<20241119131336.371af397.parker@finest.io>
	<f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nxu9rCdnIdW3P3qv7y+GUlOIPEyiicHtMkFAMxXbfvmXszGgWhq
 gytl6783/qhiYLAevL+5SRNu1dIjK8X5lDnRB5bmAt5lUmQ8G5PUYRElqKIxTnncpv8lskl
 FY1iHU9NHFl+nmPHbXA+tUrcMj1jNYH7GHtd+fQpalFRF1WKk5isUyPVv/GkblnDpTpe0j+
 ySk7+CTMlKlcg9c9UylKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IeTAM+Wzek0=;+TNVcZ5NOiYCiXgQHseq8IgxQmL
 KvE5z0B4ZyftUxgXFHiU/EYakeRN04yXl9IUYPk2UeEH1AV7tFa2piWIFRWtH12w9eB/mcu2G
 JZg7GKMM8YGFiqc5yfiVGzeM4CFFyeAAqxDYWbn9WoQjNe1C8eMaiw0XajULmJZDe4uX7Njnm
 /KN8VbIJtx1LhD9pkcyJyqHgBmlltSw6WxL6LmQcmhHaBXXSqjqZLqYpUPbUzkoonOpS+F12m
 Ryh+0fqnG6vae3EC0SmcfFhpBW++7bYP65crB3MfGHGP77favBbt0+Bphslji26RTjm9y3JoU
 RiY8fBnxXDa6RwKy1/5sXozMg29yXACBK3NrKoRv4Lni5lrORgllTzUmz52e/1eXclKYE/RsD
 bKZXwmFSJZpKwfqMr+NFhEihBI4vRuZRKMhwWcLnX1SQ1v5+4x1dtgWxPKI9M1uMF06MyNqq2
 W6hQYuepFsvgfk1vFx5R28US59P2ZdJND38etpcOj5E1OznyMK/WcnTEDtCvzpeDVkVgZfj4y
 O1EBrfifSgZ+502mc21SyPdbljqlUjrishtaFvP83VTm/8JpPBCrPdZM7CK2OP6p3D6VVWyxG
 uMjCuvQMgIsu8rPoIFjEOPEew7/8dbmHEglfBOtxZDHhnFQ/Jv+r6MsGMVu1Krv50jK1PAVay
 K00UWgJtI4/O7O7LJeygh5dfEtGaFL9a2kilgvQs+ejuPADFX76WChAGmDgVeLtvOy6TbNpQy
 lXpgxC2mcOZd0/TBjHvRHDu5pWdS5xUQmhDWR3FoKUyXQXF7rn8rpg/6jVFwTuwB8cC3yi4tS
 ziVHN/ZisJoo2SVXdEcKOj30zDgmqFlSwL6QFOIA8chB9ZCJgMPH3wOyTvJ6y9deJ2

On Tue, 19 Nov 2024 20:18:00 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > I think there is some confusion here. I will try to summarize:
> > - Ihe iommu is supported by the Tegra SOC.
> > - The way the mgbe driver is written the iommu DT property is REQUIRED=
.
>
> If it is required, please also include a patch to
> nvidia,tegra234-mgbe.yaml and make iommus required.
>

I will add this when I submit a v2 of the patch.

> > - "iommus" is a SOC DT property and is defined in tegra234.dtsi.
> > - The mgbe device tree nodes in tegra234.dtsi DO have the iommus prope=
rty.
> > - There are no device tree changes required to to make this patch work=
.
> > - This patch works fine with existing device trees.
> >
> > I will add the fallback however in case there is changes made to the i=
ommu
> > subsystem in the future.
>
> I would suggest you make iommus a required property and run the tests
> over the existing .dts files.
>
> I looked at the history of tegra234.dtsi. The ethernet nodes were
> added in:
>
> 610cdf3186bc604961bf04851e300deefd318038
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Thu Jul 7 09:48:15 2022 +0200
>
>     arm64: tegra: Add MGBE nodes on Tegra234
>
> and the iommus property is present. So the requires is safe.
>
> Please expand the commit message. It is clear from all the questions
> and backwards and forwards, it does not provide enough details.
>

I will add more details when I submit V2.

> I just have one open issue. The code has been like this for over 2
> years. Why has it only now started crashing?
>

It is rare for Nvidia Jetson users to use the mainline kernel. Nvidia
provides a custom kernel package with many out of tree drivers including a
driver for the mgbe controllers.

Also, while the Orin AGX SOC (tegra234) has 4 instances of the mgbe contro=
ller,
the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has carrier board=
s
that use 2 or more of the mgbe controllers which is why we found the bug.

Thanks,
Parker

