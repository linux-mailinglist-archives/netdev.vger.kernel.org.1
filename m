Return-Path: <netdev+bounces-178058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6739CA7439C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 06:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D3B189DBF7
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5A19341F;
	Fri, 28 Mar 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fd0+WxS7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA0EEA9
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140894; cv=none; b=jhDZ8xXUMKdyzPex+zSSKVfirjZiXJq9ajMfBfBVBWRbYUCkkcouANnumbUTLtgviuoa6+xhcOOTKrRzljZ4R6H9vDky8JzupWyK39JYRAIJwyDmf8BpdfpLJCw8U63wD/RUTGejAST+6FALtneXDu5B3nAVwDIL0Ev6x/JP8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140894; c=relaxed/simple;
	bh=xzcyd/4tACV1vdkZnBnWWvBGExY6+i1HYokMa9uBOqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta2dqv2jaELOIXnOE9B1IeTQ8mCRrOa+1i6TOf5NfSrlVN69QeK5oFUoTQd32UH/nWxypZK8dLAuCLrgdOSrT37TlT8H6LQVGXNMNN0D3YtG/Kb4xlQUF/84er7OCaoPT3N7QFgYxW+eor7plo3/SMHtVDHNhf8R+LdY8QabHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fd0+WxS7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTKh94tdwNg9q3c5LOM370VR1+uTKQc5L4EVszLLHWU=;
	b=Fd0+WxS7tpF43X6i34ZE6shR0niCLYjJ+Pk8ON8b5/29YFEF6Ck/o37T5ZrqcYgHhpX2HX
	oCJ6wK66mGYu+7jsqjQACm2Kd8SVkxFV4XpqREjo8WksbElYsH/eUtLMT3uW1yNohFDZkx
	Z1R2C/utOVwjf1S1cvX0Wh7D+w+/5iw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-_-yOdHU1PAmHmPMnsx8FSA-1; Fri, 28 Mar 2025 01:48:10 -0400
X-MC-Unique: _-yOdHU1PAmHmPMnsx8FSA-1
X-Mimecast-MFC-AGG-ID: _-yOdHU1PAmHmPMnsx8FSA_1743140889
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so193046266b.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140889; x=1743745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTKh94tdwNg9q3c5LOM370VR1+uTKQc5L4EVszLLHWU=;
        b=jln+cQ5bocpRFBWUX/qC4UPNOfaYWiGnUUIzEldzVsFcHkvxKfbAiKFZHMuh/WQqur
         8Nz4Eif2vl6jc2HDbGXJs0T+KQBsSVgLBh+GPmBE0whNEhgELm3yzJ0D4s40M+hC/vDt
         d1imduWZ0206jFmFOvZMbycYQEkdPglnVtv3Cq88jZe4mh1nAcT3zC1YRRdCTANsRb1q
         msjL5xs0aEVAfoo6d/M/YMiH3cV2uL3mIp2guckurun93pXkJgGYzAB/4KExD8jm6ysi
         WEAZvjUfWM3/4NDTNBQ25E3vm4L5OfbVedKBUCSFT4oKG/POirMhDPEzx88MsEJI7SOl
         R2AA==
X-Forwarded-Encrypted: i=1; AJvYcCVXGnxgNZguqwCpkKKa3CHZF7mTenViwVbsXCsVaS9V/DrecYnWNJfBZGg45LDUnwU5Lm1JsUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2NHoAuT8IWaaJnIC48lBLNnT9sIp5/Nj9yU6m58yqdBgxuRy
	dFJy6/8tY3IMN4S+UJ2Q5Kesuz00+dT5I5m28ne06bECQsFpUzT6LcsnLJhWvzpE4tcaSJFHAO1
	ntPQncRP63AQniSVZJ5dY40/e64OtkBs3N9hb//dNtn/hqu179PQ7g3JBKfFQweoQNglWaTTtqy
	7hAszaBfxu2l7p3IygeLIRcAmc+CkC
X-Gm-Gg: ASbGnctBMoDRr/7HG2dj4AqRZKFWkLXtEq5bja6ty/1EyCR5knoq6kVoWUrDchj9QEL
	8XaB0oCI6FtTKARaUtghYHFefieQG3yjQXKar7m+qI7CHbR2xDXNRzAcvyZb32z2liUR+6SA+Tg
	==
X-Received: by 2002:a17:907:608d:b0:ac1:fb27:d3a2 with SMTP id a640c23a62f3a-ac6fae43107mr572830066b.5.1743140888720;
        Thu, 27 Mar 2025 22:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAxFnUp1kopqJ87Yu6gx3aXwUHDTW6oUEiLodlLZhwNh8981qQjsS2iXuR+w9T4KcHv8JjuXB4mL4fMR7n4KQ=
X-Received: by 2002:a17:907:608d:b0:ac1:fb27:d3a2 with SMTP id
 a640c23a62f3a-ac6fae43107mr572828066b.5.1743140888321; Thu, 27 Mar 2025
 22:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
In-Reply-To: <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:47:30 +0800
X-Gm-Features: AQ5f1Jq14v0a610in7Y1BoeO9ekSPxC1BG3Mk0b8VDIHn8AMhS-ZlF3OlrBypI8
Message-ID: <CACLfguVActMtC-_2fSS7GMWSgmSjaHFcXr-7H72Co301ZbXC6w@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:12=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> >On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >>
> >> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> >> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> >> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> >> is disabled, and any attempt to use it will result in failure.
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> ---
> >>  drivers/vhost/Kconfig | 15 +++++++++++++++
> >>  drivers/vhost/vhost.c | 11 +++++++++++
> >>  2 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >> index b455d9ab6f3d..e5b9dcbf31b6 100644
> >> --- a/drivers/vhost/Kconfig
> >> +++ b/drivers/vhost/Kconfig
> >> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >>           If unsure, say "N".
> >>
> >>  endif
> >> +
> >> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> >> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> >> +       default n
> >> +       help
> >> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which a=
llows
> >> +         userspace applications to modify the thread mode for vhost d=
evices.
> >> +
> >> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set t=
o `n`,
> >> +          meaning the ioctl is disabled and any operation using this =
ioctl
> >> +          will fail.
> >> +          When the configuration is enabled (y), the ioctl becomes
> >> +          available, allowing users to set the mode if needed.
> >> +
> >> +         If unsure, say "N".
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index fb0c7fb43f78..09e5e44dc516 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> >>                 r =3D vhost_dev_set_owner(d);
> >>                 goto done;
> >>         }
> >> +
> >> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >>                 u8 inherit_owner;
> >>                 /*inherit_owner can only be modified before owner is s=
et*/
> >> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >>                 r =3D 0;
> >>                 goto done;
> >>         }
> >> +
>
> nit: this empyt line is not needed
>
sure , will fix this
Thanks
Cindy
> >> +#else
> >> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', r=
eturn error */
> >> +               r =3D -ENOTTY;
> >> +               goto done;
> >> +       }
> >> +#endif
> >> +
> >>         /* You must be the owner to do anything else */
> >>         r =3D vhost_dev_check_owner(d);
> >>         if (r)
> >> --
> >> 2.45.0
> >
> >Do we need to change the default value of the inhert_owner? For example:
> >
> >#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >inherit_owner =3D false;
> >#else
> >inherit_onwer =3D true;
> >#endif
> >
> >?
>
> I'm not sure about this honestly, the user space has no way to figure
> out the default value and still has to do the IOCTL.
> So IMHO better to have a default value that is independent of the kernel
> configuration and consistent with the current behavior.
>
> Thanks,
> Stefano
>
> >
> >Other patches look good to me.
> >
> >Thanks
> >
> >>
> >
>


