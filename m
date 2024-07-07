Return-Path: <netdev+bounces-109666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0562929775
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A551F213BB
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1406517C91;
	Sun,  7 Jul 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyvRH6ro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFE17BD2
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720348838; cv=none; b=SFdiGwSW7UH670FDmt60Y84laEyhIsCn5polRDJmeTmWieFogJH35xw75Qsf6JBlUptYvoKGK5VBN7jITlexZMkzXkIgxe9ma6uMKF/TI3XHfYlnnbtp9XWmOWP8eRt3ceKChJRLaVOOOcCEvB+0BtHOT21E6/++gDYjvmI+sL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720348838; c=relaxed/simple;
	bh=EDsjsCoR5OWghDtVOebaM7T7DbpC1sYYluRaZ375cbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0FBiuyxbw6dI38D8CkCecyORKGtQ1i6fnJabRo5Y3cpAGWbIqhzfcUF7lzV/DLmqY6M/uRbvilR3u77a/3LYzll2qmKBzckrMFqbhRAJpjkxCPmLBdcxu9dqa4X/qSYEmjcyZn7Pj+BQ5pot+xzTNhE+DxQWsmqcGlOLZ5KoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyvRH6ro; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea79e689eso2623419e87.1
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720348834; x=1720953634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0zXTAuvNjLIUjZcMx+/0g7rsjd7wX/OE6P399QAvfQ=;
        b=VyvRH6roIaISEZJF4uFoDW1Qm8yHhplU8BEU8j5TUsWPsX63efeYCGN6WuD8nNgloN
         YVQJZ0qRWEVFYDF2+hel7QSwyZWCXgmO1s1slnolvYwSpeu51mSspKEX224I9Xrz2vSF
         3yKaZRa3MtSoT0kO7BBOFbYQeT7T4JQJOZWBmPhLve+PUmQF0CKizRdpltP4OhRH5NdF
         pCI5Xak8LCjO4dX0K5l/R3n6Kn10WhxVd5eY/+si9U9h3WNH/Awiqg2LNCxGizoddI23
         K0uT2Q15QW9VCeV34cHPOKUCSUeYmDv2ErwJ2RP0X37Bwbcilr9d7q5Vs5WEshxcb4gG
         ckAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720348834; x=1720953634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0zXTAuvNjLIUjZcMx+/0g7rsjd7wX/OE6P399QAvfQ=;
        b=SuE7R1Eo7R90SOPnpuDTfY5EhZZPAG1kE2Q5dBHe07SCVDwXON1SSAxKGKKsSrYxTE
         qSNC0ezd+Pz0tJpFb5h/FOBufR6weVCDOTwTl+iwiSPAeVRXrnL4jC6sNEMoS+hPaaB9
         oeYhOuHetsskkNWk8SL+psg7nW7UM8p4AUbVSc5GmYBs3mvRDlaQjeIZbvnlnPRgiz9x
         hkNDGDhIvHurVWjY/8EMog0k/R0Vf0U5rib6yjJsEkymeXmdjlM9QKOEThxg4zYsHXSw
         q57D2WeOuVhY7FCTLm1dZfrNbjCr1nVHy+T4VY0GqqSL99bUt9XeLbaxyS06Gzqs/Oag
         de2A==
X-Forwarded-Encrypted: i=1; AJvYcCXeCm7zh0R3B9mgGhdGItUNJNnIUkCe/NiNKizt/vjTen5Y+Ub+AyvfHP1UBEfJFifDaHHhC9P5yEdUQrn/ayvsb0SHnTtk
X-Gm-Message-State: AOJu0Yz0Pd8L9BG+pUtoh2LbYQIOWyK0TEJ5L7MqQR1JgMBJnRmuCsf9
	+Iy0WrP49R6kuqamd2FTqxtSk3DdwGC9lEcvBAm+tlAk8Ii06/Xd
X-Google-Smtp-Source: AGHT+IHd3H6J8OHBqlIEti3wkiFoFLk/c/ogW8ySSBAyY5GI8lD4wF8wpXK94RioRNCkXN2Vx6yhTw==
X-Received: by 2002:ac2:5a50:0:b0:52c:dd94:bda9 with SMTP id 2adb3069b0e04-52ea06c78d5mr6774690e87.56.1720348833997;
        Sun, 07 Jul 2024 03:40:33 -0700 (PDT)
Received: from mobilestation ([95.79.243.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27b14sm3256082e87.125.2024.07.07.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 03:40:33 -0700 (PDT)
Date: Sun, 7 Jul 2024 13:40:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <2iptp5kd4kk2pqpynqx6apdhfrri3mtmhgt7kqzglgd26h7pmv@56up3lir53dd>
References: <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
 <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
 <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>
 <3pmtzvpk5mu75forbcro7maegum2dehzkqajwbxyyjhauakapr@j7sovtlzc6c6>
 <16ce72fa-585a-4522-9f8c-a987f1788e67@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16ce72fa-585a-4522-9f8c-a987f1788e67@loongson.cn>

On Sat, Jul 06, 2024 at 09:31:43PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/5 19:53, Serge Semin 写道:
> > > $: cat /proc/interrupts
> > > 
> > >             CPU0       CPU1
> > >   20:       3826      12138   CPUINTC  12  IPI
> > >   21:      15242      11791   CPUINTC  11  timer
> > >   22:          0          0   PCH PIC   1  acpi
> > >   28:          0          0   PCH PIC   7  loongson-alarm
> > >   29:          0          0   PCH PIC   8  ls2x-i2c, ls2x-i2c, ls2x-i2c,
> > > ls2x-i2c, ls2x-i2c, ls2x-i2c
> > >   34:       7456          0   LIOINTC  10  ttyS0
> > >   42:       1192          0   PCH PIC  17  0000:00:06.1
> > >   43:          0          0   PCH PIC  18  ahci[0000:00:08.0]
> > >   44:         40          0   PCH PIC  19  enp0s3f0
> > >   45:          0          0   PCH PIC  20  enp0s3f1
> > >   46:       1446          0   PCH PIC  21  enp0s3f2
> > >   47:      11164          0   PCH PIC  22  xhci-hcd:usb1
> > >   48:        338          0   PCH PIC  23  xhci-hcd:usb3
> > >   49:          0          0   PCH PIC  24  snd_hda_intel:card0
> > > IPI0:       117        132  LoongArch  1  Rescheduling interrupts
> > > IPI1:      3713      12007  LoongArch  2  Function call interrupts
> > > ERR:          1
> > > 
> > > 
> > So, what made you thinking that the enp0s3f0, enp0s3f1 and enp0s3f2
> > interfaces weren't working? I failed to find any immediate problem in
> > the log.
> I'm sorry. I made a mistake. It works fine.
> > 
> > The driver registered eight Rx-queues (and likely eight Tx-queues).
> > enp0s3f0 and enp0s3f2 links got up. Even the log reported that two
> > interfaces have some network access (whatever it meant in your
> > boot-script):
> > 
> > > The device(7a03 and 7a13) can access the network.
> > Yes, there is only one IRQ registered for each interface. But that's
> > what was expected seeing you have a single MAC IRQ detected. The
> > main question is: do the network traffic still get to flow in this
> > case? Are you able to send/receive data over all the DMA-channels?
> 
> Yes, I can. in this case, enp0s3f0/1/2 can access www.sing.com.
> 
> 
> Because I did another test. I turn on the checksum.
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 25ddd99ae112..e1cde9e0e530 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -133,8 +133,8 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>                 /* Only channel 0 supports checksum,
>                  * so turn off checksum to enable multiple channels.
>                  */
> -               for (i = 1; i < CHANNEL_NUM; i++)
> -                       plat->tx_queues_cfg[i].coe_unsupported = 1;
> +               // for (i = 1; i < CHANNEL_NUM; i++)
> +                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
>         } else {
>                 plat->tx_queues_to_use = 1;
>                 plat->rx_queues_to_use = 1;
> @@ -185,8 +185,8 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>                 /* Only channel 0 supports checksum,
>                  * so turn off checksum to enable multiple channels.
>                  */
> -               for (i = 1; i < CHANNEL_NUM; i++)
> -                       plat->tx_queues_cfg[i].coe_unsupported = 1;
> +               // for (i = 1; i < CHANNEL_NUM; i++)
> +                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
>         } else {
>                 plat->tx_queues_to_use = 1;
>                 plat->rx_queues_to_use = 1;
> @@ -576,11 +576,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,> const struct pci_device_id
>         if (ret)
>                 goto err_disable_device;
> 
> -       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
> -               ret = loongson_dwmac_msi_config(pdev, plat, &res);
> -               if (ret)
> -                       goto err_disable_device;
> -       }
> +       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
> +               // ret = loongson_dwmac_msi_config(pdev, plat, &res);
> +               // if (ret)
> +                       // goto err_disable_device;
> +       // }
> 
>         ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>         if (ret)
> 
> In this case, enp0s3f0/1/2 cannot access the www.sing.com.

Smart.) Indeed it implicitly proves that at least two channels get to
work. Checking out the interface queues statistics (ethtool -S
<interface>) would make it less implicit. Although something more
comprehensive covering all the channels would be better. But it's up
to you to decide whether you need such test implemented and performed.
I just wanted to make sure whether the common MAC IRQ case was indeed
tested since your original result contradicted to what the DW MAC
explicitly stated:

"The interrupts from different DMA channels are combined by using the
OR function to generate a single interrupt signal sbd_intr_o.
Therefore, the software needs to read the Interrupt Status Registers
of all DMA channels to get the source of interrupt. The MAC interrupt
status (Bits [29:26]) is updated only in the interrupt status register
of Channel 0."

The sbd_intr_o line is the main IRQ signal reporting all the DMA and
MAC events (so called "macirq" in the STMMAC driver). (There is a case
when the later events are reported via a separate mci_intr_o wire, but
it's rather rare.) So it seemed strange that the Loongson GMAC/GNET
HW-designers could have diverted the IRQs delivery logic so much.
That's why I was so persistent in asking the way the test was
performed.

-Serge(y)

> 
> therefore, the network traffic still get to flow, and I can
> 
> send/receive data over all the DMA-channels.
> 
> If there are any other tests you would like me to do, please let
> 
> me know and I will be happy to do them.
> 
> Thanks,
> 
> Yanteng
> 

