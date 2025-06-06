Return-Path: <netdev+bounces-195460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9661AD04B7
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF66189E0BE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE9289E14;
	Fri,  6 Jun 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpCV2m3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6B288CBA;
	Fri,  6 Jun 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222309; cv=none; b=VX08g7VwcDycF7XHI/1uC/i/9ox8ZdDEEyxqG2Ca8+eYo2X/Rpp8toMVxcs2ddZjgWzg4go9ssxIpl/5blvUpLoxC4rB/XfTbRJ3HCpZ9J6n5KzR/okIvL0a9H9tZEMIfamzX4Nb/qTICfIiVOCmX/7e6jlM0O2tJnYacFbsY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222309; c=relaxed/simple;
	bh=gJtT0Tn2PpQSNzJ2Th229/jPzi9ZJ2Ls6N/5fNjLzI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2jyv3Dy4iyS3Sns25AfIGZ3eNQhAt7noExVSe3SolIdJ+znoSw8bRmwHqUIErxCkoHN62wyp92zyyvszmbDRGwIRMsrOrJ4JXON+eY9k5+xxdRgxyy5goXK5pmttGbklnc51c+3LsksPTKZZWWO6t1fbBx+btok4aHwuXLIg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpCV2m3l; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3105ef2a071so25108781fa.1;
        Fri, 06 Jun 2025 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749222305; x=1749827105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NhdrlgztzgpE1Xk+Zp4kkuAyeJA1EIIswOLXPfRZyk=;
        b=YpCV2m3lvJOOefyFXL82qLH4EogGzFVPWK9M8oCN07Fic9U7v1tEDkXt95WXzFVp2q
         AZDqK0FCG7MzzPHmPUjQPmXUAbZgNouTnIp5tagkakj56oeYlHsiGL+3yo8c79yJE7PO
         IJFdUCYvA5b4PzBIzpxkhCjNNb3mzTJQceauLyOCTZ1kWVLEzbJ7v5HsxuKcaMGb5ur5
         ViGhjhBniksIIE0WnkZ0tc7Hs8QS2TL01fzz5Q2a4MYQlb+9CSlU/HkQ7pGFL/s9mzgI
         lIj8nefnfKImlYYhGGTlYFZDY10CHofyH/hQo1HZe2iMzTHFByKPREy2qo0vhHXmfXNA
         ZKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222305; x=1749827105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NhdrlgztzgpE1Xk+Zp4kkuAyeJA1EIIswOLXPfRZyk=;
        b=D/r0sXxjiDPejZlzps9G3ilCEbEvTYSvDAx64WWhcFDnDrS0S4+TR0d4qY1wB+WiOt
         4G9NRTP7vg4iAAZqG3Nh6bTi/tmO4iKCgHTU2ygoo2tnqj+ZxrAUY/ut0au5H1OSypXd
         wWSKyOmGXBBg7dUoMIeXNNckYrgEUw6lSGRinV32nvO1jr4WijaY0+18ThfRb/D5hVsH
         6lxTvMdDoal+yBKtHmF+cEZXHLKLmhkv4J/ylH7CgWPrmzErv+Rmsn16y2Eq0eBWOnIt
         Ay9ykoQ09X5qvq/aA76X3phalOS3wqzqwrYChIouR23P0IguNyHJL2XDuzZQlq5BIt2n
         zPzg==
X-Forwarded-Encrypted: i=1; AJvYcCVpnz/sqc4ziP30JMqf1mF5/86NlBjG9sC5CTwS3dZsxiDCXn/RK/L9LEtFucp2GiNjTPcbCczEbTYo6L8=@vger.kernel.org, AJvYcCXFTPRoCf6NacWolkDBNPEi2swHImLx+ElfCn/cuMSNyCIHDOUiwLNKxBoO97ZoWa+jqzwuQoVK@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkgFQ3toitz6kVAbx6arHiWeQr+PeG0vxFVm3f96g1Ii1M9nA
	Y7cSSrOaK95eBU4qeEj4qlsNTrdt7iDE8t+yM3MFx4bfXMD2m4Pnv2TXYa4Luxx2ASAvLFdKc1a
	fG6GYWeXeT85xG2tgKkSA4rpT3y2dVCs=
X-Gm-Gg: ASbGncs+0PRWoxPzBMHuIrAk596EMmTM5A5+VrS7XNAWkxnCKPtleL/vifMG7a43c46
	SotbBoho6faYhN140m0Y0JswMrJG7tgVWvcWMTRTMxvza9eYfJ2OS90iz6e9lO83Mv6JIu7el3I
	id+tEpfZpcNbhbLhE3bQh4+2z6LJ7nRVbLkYNOIXKfFOEn8LKDYnjzpvi2rlnirV86j1AybzAje
	8INuw==
X-Google-Smtp-Source: AGHT+IH78G8M0elhu6vNm3wt3JuGbGuw0AvHq4vu10oYAIAXshUAr7D1SoCJMauU898LZIj0vl45j514wQ0JYhgZ68o=
X-Received: by 2002:a2e:a7ca:0:b0:32a:88b5:7b3e with SMTP id
 38308e7fff4ca-32adfeec0bemr8720921fa.41.1749222305096; Fri, 06 Jun 2025
 08:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com> <2025060239-delirium-nephew-e37c@gregkh>
In-Reply-To: <2025060239-delirium-nephew-e37c@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 6 Jun 2025 20:34:53 +0530
X-Gm-Features: AX0GCFvdMphOgp8NP2z6BCJwn33AWaLDf2vr9-l3CqvYDu4QUg76FhA0esJXBe4
Message-ID: <CAH4c4jKrYsyVi_g=bem2bGmH1Y95mRkKPApqbQbWZXkQuVWtDQ@mail.gmail.com>
Subject: Re: [PATCH] net: randomize layout of struct net_device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keescook@chromium.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:50=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> > Add __randomize_layout to struct net_device to support structure layout
> > randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> > do nothing. This enhances kernel protection by making it harder to
> > predict the memory layout of this structure.
> >
> > Link: https://github.com/KSPP/linux/issues/188
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  include/linux/netdevice.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 7ea022750e4e..0caff664ef3a 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2077,7 +2077,11 @@ enum netdev_reg_state {
> >   *   moves out.
> >   */
> >
> > +#ifdef CONFIG_RANDSTRUCT
> > +struct __randomize_layout net_device {
> > +#else
> >  struct net_device {
> > +#endif
>
> Are you sure the #ifdef is needed?
>
> thanks,
>
> greg k-h

Hi Greg,

No, the #ifdef is not required since __randomize_layout is defined
as a no-op when CONFIG_RANDSTRUCT is disabled.
I rechecked the documentation to confirm this.
Thanks for pointing it out!
I will remove the #ifdef and update the patch before resending.

Regards
Pranav Tyagi

