Return-Path: <netdev+bounces-250397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02DD2A027
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4446C304BCA3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBA338F26;
	Fri, 16 Jan 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8NZSCV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E433984B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529479; cv=none; b=kW/MpejVGrO+d/bG1wkrGr4fVCNmGJGfJdId+woZrA89xm8OkAYFO5I5Gb6yFEMtTMTZe4tSODY3JhjSPdLzX1VeYMXd5zvpwqusT25O13ol56xOSfkn31x+6A3Bz4w7uWu25Q0X2r+Y0svYx9A8piSO5UagCZ2HbGbpL8c6Ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529479; c=relaxed/simple;
	bh=Mn1dvgQ20AbJOfu5CyU0Mh0IxSvij2C9DJCC31gekEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/FYSjEZQAKk4gZ/ZSHJnddd52m5rAGIsVJv+VdLxg7rhesINYZZ9fEu6HgeHzllAHS9/pAV+6XMXm2Ddv5W3B6tSvCnCNyDwa8TrtyGQ1ez1jAAseuwUTOAj0WhNJ3gttwdvtMgGtMJJcWSjEehsxhChUMEN/h4ZCSTkcc2Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8NZSCV8; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79276cef7beso14841707b3.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768529464; x=1769134264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aun2afeMvM8y/gxd5d+IrnkwMgQK/MdMuh8uQ2sw0bM=;
        b=J8NZSCV87TasrVPfyq//A7oMaeT16x4peybhTJ0pWqZOOPA9nnqqCC2Or8WDpNQU9c
         yuWA4JYKBG8/rI6dzdpaGk1TJGTsvA4Ny5hG/Zf9TwfYQvMqZF0TlBP7/GtOYfO0VsIu
         fS2rSSMynnHYGKJpzprZluk31qwuUGHvHZnaVDrKEQpKHTFyttJgXF+RtWwR8TTlV9v8
         5eBFZPGIBahVP+MKBy1QFdCbIfiv+PVxznqlB2hqBICi+zpldHwt3PrwE7dKTzaZRale
         6Jb9kVbvp0O9k7iqoOfne1fTsns5I0iTDFsfY+Kd+9lMeA4eOfznUZ+NjvtD3Ky11Q70
         pxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768529464; x=1769134264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aun2afeMvM8y/gxd5d+IrnkwMgQK/MdMuh8uQ2sw0bM=;
        b=cpXvQOdX+InNOfg08Ur3SBSG/Zx2yHYu+Q9aD7qM4jTpCgLJ9XlKoMU+GOnLBDDEAe
         I9u6fstpuFNBYUuB8R88kCgaXTD2hr534nTLsdn8Xs9XjX02DcG84TFAmiu7/MWhL6EX
         w/e8c1xPwlnalLXA6z2jojRPyufuXcq7Xc5qikEm10fPrZUSw0xCTN1/l+oiu6QY9sHI
         PDozrQvrG7LKsKUcA9ra6gpQFPN9WwbhkuJbDPM60xBDSyvONycwgFN3Mx/kH2OG5xaX
         9cjCnFgMmg7xSMPyHOPlXSLwinpwvJsybNjnn3qWAf7+raaB8m6lL4HppC8gb0vksH6P
         BBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkxKPRj8Fjtg2cVq+srhDVEP1SZpe8r4d8yqsftcjaJ/+AAhgtpAq5QYbxR6N4r78Sj+lax+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTXne1uxgPKmxkC8hvV/rOQuTlZ3fkAwJikX5vag8ScxMrAm0
	bzoqYFPCIyaJsKsGq15/bDn6RbIlHsAVIO8saeiu0/ATknVdFIykGwv2ojq/+TEEyVGWHQsaSWE
	NmICLJaV84fWFJU1C2dcM7eKBL9XjG6E=
X-Gm-Gg: AY/fxX4/sExR8nPiNi8JC0fz2DnsrjpoyCldop2Lb3Nzauyd1SugFL3WUgaR/sGLmwx
	oe6de9GVHXi2vmgbn6nACxbTcRjSKk4jGC8ImnTJrwwVhtXji+Q9OMyL28E7SSZBLnJrW2eI46W
	eVHxEQ2UD0bPFyBSJwL+dVZpse0I/SBs9UIAZ7QsyUi2PlYkIYVcv5e3AdCtwuNbAmGA2ACZRTf
	MiK7zcboXFZu6wgaEghw/0UV0tfc6lejxCZAzT/EgEacykESRi8tjrn4j4kXHP4ZMymAZ6P2i6j
	ghzl
X-Received: by 2002:a05:690c:7206:b0:78c:2d5c:1988 with SMTP id
 00721157ae682-793c52ab10bmr15497887b3.15.1768529464505; Thu, 15 Jan 2026
 18:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114025622.24348-1-insyelu@gmail.com> <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com> <1b498052994c4ed48de45b5af9a490b6@realtek.com>
In-Reply-To: <1b498052994c4ed48de45b5af9a490b6@realtek.com>
From: lu lu <insyelu@gmail.com>
Date: Fri, 16 Jan 2026 10:10:51 +0800
X-Gm-Features: AZwV_QggB5ObtjHHXQLAj58mfsv43P1yTDIpyeNYtBFiEmAmND1YU0Gr9FYXEpY
Message-ID: <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
Subject: Re: [PATCH] net: usb: r8152: fix transmit queue timeout
To: Hayes Wang <hayeswang@realtek.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de" <tiwai@suse.de>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hayes Wang <hayeswang@realtek.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8815=E6=97=
=A5=E5=91=A8=E5=9B=9B 19:42=E5=86=99=E9=81=93=EF=BC=9A
>
> lu lu <insyelu@gmail.com>
> > Sent: Thursday, January 15, 2026 9:37 AM
> [...]
> > To reduce the performance impact on the tx_tl tasklet=E2=80=99s transmi=
t path,
> > netif_trans_update() has been moved from the main transmit path into
> > write_bulk_callback (the USB transfer completion callback).
> > The main considerations are as follows:
> > 1. Reduce frequent tasklet overhead
> > netif_trans_update() is invoked frequently under high-throughput
> > conditions. Calling it directly in the main transmit path continuously
> > introduces a small but noticeable CPU overhead, degrading the
> > scheduling efficiency of the tx_tl tasklet.
> > 2. Move non-critical operations out of the critical path
> > By deferring netif_trans_update() to the USB callback thread=E2=80=94an=
d
> > ensuring it executes after tasklet_schedule(&tp->tx_tl)=E2=80=94the tim=
estamp
> > update is removed from the critical transmit scheduling path, further
> > reducing the burden on tx_tl.
>
> Excuse me, I do not fully understand the reasoning above.
> It seems that this change merely shifts the time (or effort) from tx_tl t=
o the TX completion callback.
>
> While the intention is to make tx_tl run faster, this also delays the com=
pletion of the callback,
> which in turn may delay both the next callback execution and the next sch=
eduling of tx_tl.
>
> From this perspective, it is unclear what is actually being saved.
>
> Have you observed a measurable difference based on testing?

HW: RK3399-based development board (dual-core Cortex-A72 + quad-core Cortex=
-A53)
OS: LEDE (OpenWrt)
NIC: 2.5G USB Ethernet adapter connected via USB 3.0

Due to platform performance limitations, it cannot reach 2.5G. When
processing in the write_bulk_callback and during USB submission,
iperf3 stress testing shows a difference of approximately 8Mbit/s.
This may be related to the platform's big.LITTLE core configuration.


>
> If you want to reduce the frequency of calling netif_trans_update(),
> you could try something like the following. This way,
> netif_trans_update() would not be executed on every transmission.
>
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -2432,9 +2432,12 @@ static int r8152_tx_agg_fill(struct r8152 *tp, str=
uct tx_agg *agg)
>
>         netif_tx_lock(tp->netdev);
>
> -       if (netif_queue_stopped(tp->netdev) &&
> -           skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
> +       if (netif_queue_stopped(tp->netdev)) {
> +           if (skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
>                 netif_wake_queue(tp->netdev);
> +           else
> +               netif_trans_update(tp->netdev);
> +       }
The queue was stopped because it exceeded the threshold. Attempting to
refresh the time at this point is clearly too late.

Thank you for your suggestion. I will submit v2 (immediately updating
the transfer start time after successful USB submission).

Best Regards,
insyelu

>
>         netif_tx_unlock(tp->netdev);
>
> Best Regards,
> Hayes
>

