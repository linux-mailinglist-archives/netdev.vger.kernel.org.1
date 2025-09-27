Return-Path: <netdev+bounces-226914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D6BA6185
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6765B7AFE18
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28521D3E2;
	Sat, 27 Sep 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiNlFnbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC121CC4D
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990434; cv=none; b=SiC6L+H3ZqOfUHl2qX7KILNOZ5CAXIBn0lllLP9EL8NRUwH5FaSDQxRXha8+oGgFhG8owyON5VgZ1Ob/teBsplW5lTWHT9CYq6XysW5OmoW2NFLUFvQluNJrmP74Dtm6/c/ZUfXSZN4WW1iB3f4fdLo1ji2Tqs8JNb+BPdF/3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990434; c=relaxed/simple;
	bh=vVeNZDUzmqCR5tohyCu/vudodRWX7MEMP9eIF2ApJVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAZcsPSYOkO1mpD1J64wp6CSVzkpC8VUFgMaHdMaH093kdcETgxj3Hp++0z7d9PPQt30/kPP+jD+u3t6LhRLwpuJhZcUDCHRkMfDtVt5TrkPLKgW59GJQNRAO0GcBhrz+CAg7oInVbK0bNdh33zjiuJqR0rKvJjusuHzV5bvmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiNlFnbj; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3727611d76so404719866b.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758990431; x=1759595231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfZFYlW0wdwTxAgpS/9PkxRW2aXQXo/CZ/Epth10HX8=;
        b=MiNlFnbj9TNmxF+V6M9WSl4BkdNVFQM9nt+Jmxqo9KKB4L8eBv1X4r+uBRsfb+y8qw
         h284TZxx1fZYIOKjP6Q9NFHOprUUtZgMd652R4f7i/qxoUeXAxoQQuDrbBOA0fphQS2Y
         WFr4zBy7s0GnRWnXJYt6fWjhjQPwEhm051wmS4xngW/zkSQjf4zFhtfoM0GbReIWF6Dz
         hWYrWZbqhtgnHIu1tlo5idaE2lAbPo2C7xIu9+12cguoc5KYXKlBnQS6bVl9bY8Mi6cs
         hUU3D/9y/gSKY5lSCbK0ldESqY6sKzgW7ZWuugSD2Rcbjg3OCmMCvC3ssEj5Qr9pdzOD
         FCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758990431; x=1759595231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfZFYlW0wdwTxAgpS/9PkxRW2aXQXo/CZ/Epth10HX8=;
        b=sNc0UsmlR7QFuk5zk1gVyD2WF6dQjMIW5JHlsgHGcaChEvTX7JseVlgIK0cMP5VRxj
         42B7trUB9Lx3EyG45LyGEvXxcxuoeu7ZrOT8dBbDHgiNtH02/BVc748cgzze0UlJkJDz
         4h4DdlmBsHBYgUKIMgi8F45cAURUzgovN5jxtJDeVGr//mqnlnIjX/MTqBjJbyTzz/LR
         kwa1Zgd9hA1A48XrjKS7QBzvldfk4pLIT6IiKqIKyk8WrcsFb7SQc/fqLwxtmPeDI8Ow
         CC/b+thBG2WMyHwNKPAlwIE/DyHwePnikQ8iGR5FmT2K6fjHGqaKqPczch7VX3dwZs1G
         e42w==
X-Forwarded-Encrypted: i=1; AJvYcCXnWA3uEmWihQUgXi+jbYelMFoaKRluxkHRfHs8zsJMhOF++e1DvNN3+cI6WcK8WCPNTxaI/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrJ/WNBe7nIbmll/Avnut+XocT0cNkGWb3SXx2oWgcyv+LIWQ
	hS3TrgDWLMUQ2DKtztZ22HEqLK0sUTgscluBH16TXSv9qNhfaYpZULxt5O2snsfLRXGhvU2flOF
	/8eDc7qEQ+0IsYI1379w/HCdCnGQjZrg=
X-Gm-Gg: ASbGncv3/FAlQXgGcvJa0hHD5W2zGX4nO0EBxw/MtoNZ8drVnHkfV5fhP5iRsVldjiV
	nWtwb8JUVX2nN+EZD43BZoDuhlU3/GSgEm9DL1EOC58YBrlOFXnp8g6I+wVN3383xHAiIhY8TxT
	kYIVtb4pyuFG253uiLBRl3J5U+/ZzLTgznYysxhvW5fX41LEC4fiJ0TJSebCxFngI6LwGReMPg9
	Jy4w3AlBEODa+LRzg==
X-Google-Smtp-Source: AGHT+IEm2jV42rGG7p5fnAgEp0mQdebl30tWmt7AxVYjslTP4Tk1rmf5shjSIlNO7exv/8/POfXlKAR/ZeXXXvU+VXo=
X-Received: by 2002:a17:906:46ce:b0:b35:3469:49ff with SMTP id
 a640c23a62f3a-b353478953emr979609066b.25.1758990430457; Sat, 27 Sep 2025
 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com> <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de>
In-Reply-To: <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de>
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Sun, 28 Sep 2025 00:26:59 +0800
X-Gm-Features: AS18NWDvuOQaoti1D_COhZmrCy5dQ4py-Ah3qreB3B80U5UMlAMWauKJrbU8dAs
Message-ID: <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexander Shiyan <eagle.alexander923@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Mon, Sep 22, 2025 at 4:50=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 20.09.2025 18:08:03, Andrea Daoud wrote:
> > > On 18.09.2025 20:58:33, Andrea Daoud wrote:
> > > > I'm using the rockchip_canfd driver on an RK3568. When under high b=
us
> > > > load, I get
> > > > the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus i=
s unable to
> > > > communicate properly under this condition. The exact cause is curre=
ntly not
> > > > entirely clear, and it's not reliably reproducible.
> > >
> > > Our customer is using a v3 silicon revision of the chip, which doesn'=
t
> > > this workaround.
> >
> > Could you please let me know how to check whether my RK3568 is v2 or v3=
?
>
> Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:
>
> | https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/diasom=
-rk3568/board.c#L239-L257
>
> The idea is to fixup the device tree in the bootloader depending on the
> SoC revision, so that the CAN driver uses only the needed workarounds.
>

Thanks, it is not easy to correlate this because I am currently not using
barebox. I'll try this later.

> > > > In the logs we can spot some strange points:
> > > >
> > > > 1. Line 24, tx_head =3D=3D tx_tail. This should have been rejected =
by the if
> > > > (!rkcanfd_get_tx_pending) clause.
> > > >
> > > > 2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This m=
eans that the
> > > > tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod=
 the
> > > > priv->tx_tail by two. But the printed tx_tail is 0.
> > > >
> > > > I believe these problems could mean that the code is suffering from=
 some race
> > > > condition. It seems that, in the whole IRQ processing chain of the =
driver,
> > > > there's no lock protection. Maybe some IRQ happens within the execu=
tion of
> > > > rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx=
_tail?
> > > >
> > > > Could you please have a look at the code, and check if some locking=
 is needed?
> > >
> > > My time for community support is currently a bit limited. I think thi=
s
> > > has to wait a bit, apologies :/
> >
> > No worries, I will debug myself, and hopefully send a PR if I found
> > something out.
>
> Great, I have a both a v2 and a v3 SoC here to test.

It turns out there are two issues:

1. The race condition (between TX interrupt and TX queue netif xmit) is ind=
eed
an issue. Fixed by adding a spinlock around TX logic, and no warning
occurs after
adding the lock.

2. The CLK_CAN0 was clocked by GPLL, which makes it 148.5MHz. This frequenc=
y
will lead to various errors quickly when dealing with EFF IDs. Fixed
by constraining it
to use CPLL and 250MHz freq.

Regarding problem 1, I will send a patch.

Regarding problem 2, I suggest adding some extra sanity checks to
guard against this.

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


Regards,
Andrea

