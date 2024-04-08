Return-Path: <netdev+bounces-85883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1CB89CBBE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06805B235AB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5DA1DA26;
	Mon,  8 Apr 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoQxC7jL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06CF51B
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601320; cv=none; b=t3kT4dNzWrDwhAYDwUTReY3dMyGSK7lLhuW4vaTAV3h/hncjN2gWHHbZVqW3F8RB9gZzT5AXZgY0vtNaV52TuJB0Hek4m5I1CS59xT6qrQnuAPyIX1NhT/1YlkxA0mgPxyXv8cPvQKtqr+ueBEsIc8cSCG+cFkeGJ0PDBwgS/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601320; c=relaxed/simple;
	bh=RJifc8CeSJElTouDyVsc44EdDLN+J6G1ZlNE7436a2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nMTr6mI3JNHuQjpnlrX/jQSH4SpKPrsqmoVU6mhETMSS1sKo77rr76EP+VFsefCc4z5aFQSJEhOiKBfOR/DxdLi1ZKM4rR8jBZIcoRx4t5BwtEHj+/BGbzd7jpuRM/rJE3ric5bT+FRUQXtF5ag5xU4WnsLmeSvTQqdS4W6i7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoQxC7jL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso60613311fa.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712601316; x=1713206116; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed1HOypVddPvHfn9+p+lmHBXveQovp3tfW70qWZD3jw=;
        b=eoQxC7jLk5avZjgCQqk3O+ndjhGPzFdA38/QxYSyBpuhUZOe2+4Ihcd3D3G3GINcti
         yA4WhquFNSom0XakgNgkZrRx81ddZOS99gpMVGtxIptjdhns8/aEZH9GX5s5YRfmeByx
         PVqPhjhHAa+ymaMnptLF8lj8EPSChVZEhsSSA9s7aaa34Ym2LgqAz+0L2Dzbu/DunCPu
         6Wm3yb+aH2NKoLqT83MZeBhKjD+2cSRr9vrG02oCk2go8WDm0tAjXiX8MXLLteHfa2aO
         C4Mkl/+O7s4jGpK38USxD1r+fYH5ZrcXek0eVYt2UAJxDDl4mdCPF69hjPoolSZqxVm5
         eGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712601316; x=1713206116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed1HOypVddPvHfn9+p+lmHBXveQovp3tfW70qWZD3jw=;
        b=aAJx1vlnz+DEB/KIosKS3vHgQy2OIRC7Hkxrt2D98qQ+OC10vDNqLHc3Tb6LQBD2cp
         GEgbThdbEzJH5kaArJjuWxZa5VIBMvt3NrGnE2O+piJT9MDtFCtZ4frquFIFwRrW4scK
         aDuf0prMpIRqVDLxQfewp3jp9SdvqR1jABE9WQMaPUNCSo0l/ngnXZv0zCo+A0H/49+K
         /J1jQLWwDoEXhDuJ44Lt9ARrTmZyu9D1nKzEtQi1ErVaZyDWvHDgqRLvE229XOJ2lign
         omoLDD0uzosh+21iOxQBIM+iUc8Me3552Z40rqybJdc9oM2k1SJBRImrp3iwo568pWeC
         iHFw==
X-Gm-Message-State: AOJu0Ywrtx510tIg9XSC69oS1KOC8DSpzKNxPkwCJPaG3QCLTTbUXPOK
	fap3h1ab8UuZUpkbmYHRH9YC3SXBZi9Yc3W6p86OAm19mFwnahdMmJ18kPR6o+YtZUt+lAWJmnl
	aqneJGXZjFgV9RB1tfuHZ/VB0cf9VXI3KQO8=
X-Google-Smtp-Source: AGHT+IHtdS+CY0bU7v0bDpOcirPLtGoaCwJLyWkAShbjXp9cRZdwCzzaELzJa79Q57+/O6mQ5blnfOyoGwgkwcFPB2I=
X-Received: by 2002:a2e:9794:0:b0:2d8:6c9f:418 with SMTP id
 y20-20020a2e9794000000b002d86c9f0418mr5259827lji.44.1712601316107; Mon, 08
 Apr 2024 11:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF0rF3oUX0rb8eKTc94D-fF5EWM7nVAAFJM_VbH_wte8FGcJQg@mail.gmail.com>
 <8bacfc9f-7194-4376-acf7-38a935d735be@gmail.com> <CAF0rF3piNHcjwQt3ufV4nqavYopo67rr2phFFEYMygHjgp9N5g@mail.gmail.com>
In-Reply-To: <CAF0rF3piNHcjwQt3ufV4nqavYopo67rr2phFFEYMygHjgp9N5g@mail.gmail.com>
From: =?UTF-8?B?0JXQstCz0LXQvdC40Lk=?= <octobergun@gmail.com>
Date: Mon, 8 Apr 2024 21:35:04 +0300
Message-ID: <CAF0rF3r24zSthFg1OU=gaFA=4DKYQ67+_7Tb+375_JSEntxmKw@mail.gmail.com>
Subject: Fwd: r8169: unknown chip XID 6c0
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your answer.
Apply the patch, kernel 6.8.4, ethernet works.

dmesg | grep r8169
[    4.020210] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    4.033148] r8169 0000:02:00.0 eth0: RTL8168h/8111h,
00:e0:4c:08:93:00, XID 6c0, IRQ 130
[    4.033154] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194
bytes, tx checksumming: ko]
[    4.048581] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   12.854689] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[   12.998007] r8169 0000:02:00.0 enp2s0: Link is Down
[   15.717414] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full -
flow control rx/tx

=D1=81=D0=B1, 6 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 23:15, Hein=
er Kallweit <hkallweit1@gmail.com>:
>
> On 06.04.2024 12:15, =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9 wrote:
> > Hello.
> >
> > lspci -v
> > 2:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/816=
8/8211/8411 PCI Express Gigabit Ethernet Controller (rev 2b)
> > Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
> > Flags: fast devsel, IRQ 17
> > I/O ports at 3000 [size=3D256]
> > Memory at 80804000 (64-bit, non-prefetchable) [size=3D4K]
> > Memory at 80800000 (64-bit, non-prefetchable) [size=3D16K]
> > Capabilities: [40] Power Management version 3
> > Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> > Capabilities: [70] Express Endpoint, IntMsgNum 1
> > Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
> > Capabilities: [100] Advanced Error Reporting
> > Capabilities: [140] Virtual Channel
> > Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
> > Capabilities: [170] Latency Tolerance Reporting
> > Capabilities: [178] L1 PM Substates
> > Kernel modules: r8169
> >
> > dmesg | grep r8169
> > [1.773646] r8169 0000:02:00.0: error -ENODEV: unknown chip XID 6c0, con=
tact r8169 maintainers (see MAINTAINERS file)
>
> Thanks for the report. Realtek calls this chip version RTL8168M,
> but handling seems to be identical to RTL8168H. Could you please
> test whether ethernet on your system works with the following patch?
>
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index fc8e6771e..2c91ce847 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2227,6 +2227,8 @@ static enum mac_version rtl8169_get_mac_version(u16=
 xid, bool gmii)
>                  * the wild. Let's disable detection.
>                  * { 0x7cf, 0x540,      RTL_GIGA_MAC_VER_45 },
>                  */
> +               /* Realtek calls it RTL8168M, but it's handled like RTL81=
68H */
> +               { 0x7cf, 0x6c0, RTL_GIGA_MAC_VER_46 },
>
>                 /* 8168G family. */
>                 { 0x7cf, 0x5c8, RTL_GIGA_MAC_VER_44 },
> --
> 2.44.0
>
>

