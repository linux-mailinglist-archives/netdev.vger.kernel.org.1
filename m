Return-Path: <netdev+bounces-171032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F0A4B3D5
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CD7A55EE
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8591E98FB;
	Sun,  2 Mar 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaHe0ZLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD1433D9
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740937081; cv=none; b=EdphrvDTgugeu8acaHTvpr3czBt8PiTNkjsR4DxileRE9Ev93JQU2egGhJUrKVoCMofX1N9fNEURDVCUBqdsyHXYJPzvM2lTv/L/VA8dZ2k2cH0W7SLV63VPTYBJAClag6CUBK6Hn+zdCU1nRCY2z0+269uWirGMnEnqaIflvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740937081; c=relaxed/simple;
	bh=RfcJndM3l+ioBd4f6Xg5ADHNeW75D6kjQFjswfut5jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6rCdQmcIMpSkGcUnFzVDMqygg5tkyhbIjHvRry8+DUK9cEjZO+MyGVJxL9/2Anma0VgqnkF7AcDPcILJmjM+kZkNink+D0lcdQZrn0SikahMynZUO0iY7lAP99E4omBUIPK9IOzZZuFNPFCnYTKLY8IALPMWWz9Pbkl4vyOsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaHe0ZLq; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5238b366e2aso363315e0c.2
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740937078; x=1741541878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4+0cdb06avDNrWq4F+/YTGY2VUJ6FyKOG7dhy2lQ98=;
        b=BaHe0ZLq1uID7OqkdjT2XUJTxQX897WttMFzQj9QVETEKdBC+oPz9QAHFJkf48/J4Y
         rt0vgKFK7lnnnNcna5l0W7e/YkZubO383Xyc3nYwDRzULFU98qw5loW7yTKx3pHRG+NH
         HcW9hNetuzAGqqQVQd3cj04BUijzT9bEmsy7sAeDTPI9RaGgVkcSK1UNZksEtb11Ksy5
         8leVeTTcIntUVlvWSqyE+yzQTFUfrTnPSbDC7xievS8dgYEUxA+7mRFzvVV3EUpX0g6S
         9WS2yylkEOcct4RfL1rL0mAW0NC3gjHYjhXwZxKbKq6Yi+p323QYvt6wMjoiDsUEeYW3
         7CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740937078; x=1741541878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4+0cdb06avDNrWq4F+/YTGY2VUJ6FyKOG7dhy2lQ98=;
        b=FP8hGKn/Mti1Gk13wwWeTdlgSt99k7SQT+Wkta5hNBlMaa9RM2SzsseZ59CKftzZDO
         dtsrD6zbmgVogF2CxB4HnyBaPO/h+1Ml9pn71e80N+Y2mMpOBMDw2LYwIpWw/dZ5vkK0
         gg1iZ8dQdIXbB5PLcWzpb3a1TmsPiEd7E/18hNbuoFCvsdiNfJI2vfnGtVGTXJ20qGzc
         1OlTIX4p4luvThtw9bAeOShdb0kP05UVKbByhtfzo85DaSfWkKN02ZVQchcR8R166JA0
         Y2mI6othFg/MB8UeWRvXNa/fgmMq2+PzdZ+6a5xa0gwP8uXrCynWY+MPLh7Tew1Gg+iQ
         p6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZmtBYUID9Dv9IlXe61UtkoREa6+ZoriXbikzVAUplEs4HyndR4PtIxh/aEznAtP0IICpLOso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqjjo9Z6uKewqSkaDQfzb74YQcEwKoR25yLI4BS2H6uxi7QyW7
	wmA8AhCAWFmJOpqY3lIKK+XSHSH3n5E/lCdb3et/+Ac2U+FW1GfmFMYW9Oz4Ca+0a+BnKc830VG
	o12DFkfPu2xm7WOF8LkTvkxSGsIo=
X-Gm-Gg: ASbGncsyrX0xgUSeCunrVrp0e+c4cqLZpLQFK4bOqqGsDGJROrYoXWnLHN/7FswW3Ym
	tIanHYZNDonfSNGDeY6yTasEEOkL8RYOjcsEFwGfSFvhGp0b1JoMD5NiC8E1WtY3/AR3ZY3Jb8P
	RFP5TWj6lZeN1Dc1/2kDqCJPTn8w==
X-Google-Smtp-Source: AGHT+IHliCAhKC+txZmo4KvZKnv962a5PwWNVdwZA+Yn/a4VruZbK8IN0RyxD1X2YZAmg8NycEE7iKvr4c09lJWcs5k=
X-Received: by 2002:a05:6122:2897:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-5235bda6a79mr6383512e0c.10.1740937078486; Sun, 02 Mar 2025
 09:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <Z8LjAbz5QmaMeHbO@shell.armlinux.org.uk>
In-Reply-To: <Z8LjAbz5QmaMeHbO@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 2 Mar 2025 17:37:32 +0000
X-Gm-Features: AQ5f1JoZEI6jR8ko8-l1P37_1K444RXdFxWGKTvlipTeH4vYmJiDQj275BTA3iU
Message-ID: <CA+V-a8uWcgOsyG8Fy=ivs_zNqU7ur4OHzESQW=4EfYx+q2VJHg@mail.gmail.com>
Subject: Re: [QUERY] : STMMAC Clocks
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	netdev <netdev@vger.kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Sat, Mar 1, 2025 at 10:35=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> > Hi All,
> >
> > I am bit confused related clocks naming in with respect to STMMAC drive=
r,
> >
> > We have the below clocks in the binding doc:
> > - stmmaceth
> > - pclk
> > - ptp_ref
> >
> > But there isn't any description for this. Based on this patch [0]
> > which isn't in mainline we have,
> > - stmmaceth - system clock
> > - pclk - CSR clock
> > - ptp_ref - PTP reference clock.
> >
> > [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685=
-23-Sergey.Semin@baikalelectronics.ru/
> >
> > Can somebody please clarify on the above as I am planning to add a
> > platform which supports the below clocks:
> > - CSR clock
> > - AXI system clock
> > - Tx & Tx-180
> > - Rx & Rx-180
>
> I'm afraid the stmmac driver is a mess when it comes to clocks.
>
:-)

> According to the databook, the DW GMAC IP has several clocks:
>
> clk_tx_i - 0=C2=B0 transmit clock
> clk_tx_180_i - 180=C2=B0 transmit clock (synchronous to the above)
>
Ive named them as tx, tx-180 in the vendor specific binding.

> I've recently added generic support for clk_tx_i that platforms can
> re-use rather than implementing the same thing over and over. You can
> find that in net-next as of yesterday.
>
Thanks for the pointer, Ive rebased my changes on net-next.

> clk_rx_i - 0=C2=B0 receive clock
> clk_rx_180_i - 180=C2=B0 of above
>
> These are synchronous to the datastream from the PHY, and generally
> come from the PHY's RXC or from the PCS block integrated with the
> GMAC. Normally these require no configuration, and thus generally
> don't need mentioning in firmware.
>
On the SoC which I'm working on, these have an ON/OFF bit, so I had to
extend my binding.

> The host specific interface clocks in your case are:
>
> - clock for AXI (for AXI DMA interface)
> - clock for CSR (for register access and MDC)
>
> There are several different possible synthesis options for these
> clocks, so there will be quite a bit of variability in these. I haven't
> yet reviewed the driver for these, but I would like there to be
> something more generic rather than each platform implementing basically
> the same thing but differently.
>
I agree.

> snps,dwc-qos-ethernet.txt lists alternative names for these clocks:
>
> "tx" - clk_tx_i (even mentions the official name in the description!)
> "rx" - clk_rx_i (ditto)
> "slave_bus" - says this is the CSR clock - however depending on
>    synthesis options, could be one of several clocks
> "master_bus" - AHB or AXI clock (which have different hardware names)
> "ptp_ref" - clk_ptp_ref_i
>
I think it was for the older version of the IPs.

> I would encourage a new platform to either use the DW GMAC naming for
> these clocks so we can start to have some uniformity, or maybe we could
> standardise on the list in dwc-qos-ethernet.
>
I agree, in that case we need to update the driver and have fallbacks
to maintain compatibility.

> However, I would like some standardisation around this. The names used
> in snps,dwmac with the exception of ptp_ref make no sense as they don't
> correspond with documentation, and convey no meaning.
>
> If we want to go fully with the documentation, then I would suggest:
>
>         hclk_i, aclk_i, clk_app_i - optional (depends on interface)
>         clk_csr_i - optional (if not one of the above should be supplied
>                               as CSR clock may be the same as one of the
>                               above.)
>         clk_tx_i - transmit clock
>         clk_rx_i - receive clock
>
> As there is a configuration where aclk_i and hclk_i could be present
> (where aclk_i is used for the interface and hclk_i is used for the CSR)
> it may be better to deviate for clk_csr_i and use "csr" - which would
> always point at the same clock as one of hclk_i, aclk_i, clk_app_i or
> the separate clk_csr_i.
>
I agree, I think the DT maintainers wouldn't prefer "clk" in the
prefix and "_i" in the postfix.

> Essentially, this needs discussion before settling on something saner
> than what we currently have.
>
Indeed.

Cheers,
Prabhakar

