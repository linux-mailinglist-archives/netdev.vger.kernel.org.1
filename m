Return-Path: <netdev+bounces-130430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86E98A711
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1673B1C21E25
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32501917F8;
	Mon, 30 Sep 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BVfNqhXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DD18FDD8
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706703; cv=none; b=OehY22eBS1jlyFGoonMbCbew4mfUr+/LFT404212XOdyq5zFtXn878alIvM35cnY2pYE9dtQWoM+tavtwL3NRA/kxtEAJJeJGJCY2Tyy1JH8AJSirjtMcLqLOgUhMsPo8x2NJC5yPbTVzQk3jsbbR1M5pk0FLtAhBl9WSn56/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706703; c=relaxed/simple;
	bh=PV75RsCHFd9Set6408trF5b+jscrnWLWrq8vU1FBhhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWKOkJFts37P+xbQa+qAHEKaXgWDq1J3GmzNxrb2rRKCssH8bHxWP0FqNViXE7h28piFF/8VNeL5iU5JUd6DX9ysoWqVsPxCCga6PjMQPRFIl61qre4Q06jhL8G2n1KTJ5yGWWrP5RClQX6uswaHFjwbvrJGuDMv+D3n6aeZKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BVfNqhXf; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F7A43F371
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727706699;
	bh=VUmP4zgDk2FCqePA5hQ7O8LU3PwZfHmbS4Pals0CPPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BVfNqhXfgqPKEVf00N+LEc4RJZjSlK432uxHKDR6G2yB3B3nDmuBtLdoQ54W9ZjYh
	 eJ5aX+S3tnhITD90ResmWmsLeSvWAXy0Bp/JttXLMSFIMiczbKnwC12teyZF3gDPCh
	 ZsKBOB5f/LyqLndLtXX0ydbU78ETAGt/8/G8AelCGSTL3zXGTjQyhWkUkJbh3A4cYO
	 JeN7PF0whkrLI4c1FYbPxX8SCTBg/vGlkrh0dVLV2bHdwBWtEFr3FIZiX7K120FduV
	 LsMKDl2PwSRKyVyeCrcEGmtMTR/NXAPYnS9KmXfoOFbwzuyjHZnMlzgTVjU7ul85Gn
	 j27rWpLfyFpew==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-509ea43af33so260210e0c.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 07:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706697; x=1728311497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUmP4zgDk2FCqePA5hQ7O8LU3PwZfHmbS4Pals0CPPE=;
        b=pY42tRzT+AsRaOyQrH2GWk0eUiWJGR9jyb3Uy4Uh9yLv4gc0nugS4xn4+NLehZS8+u
         M5TWyg/MHoW+UyvOfUYZQEEDmvystb4qXHc/cbB9VLCG70BXYbylIhGL/QlYjPAZeqBl
         1+SavWEdVYwZIbxeOTFl4KJPlQHfiEiJl1ZN26q/EAUR7g/F41jm4P/mb/ZFKxbAKtOh
         4Ta5YuGFs18DnmITpZSIdwNX2cyHiAyQE+6Q8NUghxIlww0mzJpTvDpFb/XWUmFa26Pe
         ziWsSkuY0czxdjhDDSTH39QNbWjLsw3t20si7kjle9yNoq8f6j84ahDZG+SXvtEugzZi
         pNMA==
X-Forwarded-Encrypted: i=1; AJvYcCW0SnUeI1E395gz5umkHcl/cYtkA2tH+ZlencVq7cdapBpDe00ifDThQNh7ozlGuH4iauNi6pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIkpPzusyluE1lfcNBYD0GI4Y2N4zdSYu3LPWuZFFaCrWS6+y
	IX2LMuaXct1JieCgy+qkJMq9kDF4V2pSCoJQrdLo9QvOmy4cTriB3+rIhYkqMI6qdjF4/b2FcKh
	EkFZ9SHfjv+wlcMQ9uoeW4fGy7I2Yi6D4sQF4ren6rOLhf6xphg8b9MCSGr9ZXYshSqaRtexq3n
	gX/nUwkmIbYKjgFk2LsJIKBexbGJMYPUOdxvVkazFws6Dl
X-Received: by 2002:a05:6122:469f:b0:50a:c73e:b337 with SMTP id 71dfb90a1353d-50ac73eb866mr1132462e0c.6.1727706696622;
        Mon, 30 Sep 2024 07:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUm0HvUYsfb4b25izSbvZDphH102aNkELKCDsxbCwfS/CukKD+k5zVEfDIEJd2YZSQnWu62hWtUFb1+rs3YZQ=
X-Received: by 2002:a05:6122:469f:b0:50a:c73e:b337 with SMTP id
 71dfb90a1353d-50ac73eb866mr1132432e0c.6.1727706696263; Mon, 30 Sep 2024
 07:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929150147-mutt-send-email-mst@kernel.org> <CAEivzxcvokDUPWzj48aJX6a4RU_i+OdMOH=fyLQW+FObjKpZDQ@mail.gmail.com>
 <20240930100452-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240930100452-mutt-send-email-mst@kernel.org>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 16:31:25 +0200
Message-ID: <CAEivzxeBbRSgOKqDTkdxy2nyShD-Gq7+Go3+4Nm1DrwQ2-rGzA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 30, 2024 at 02:28:30PM +0200, Aleksandr Mikhalitsyn wrote:
> > On Sun, Sep 29, 2024 at 9:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Sep 29, 2024 at 08:21:03PM +0200, Alexander Mikhalitsyn wrote=
:
> > > > Add an explicit MODULE_VERSION("0.0.1") specification for the vhost=
_vsock module.
> > > >
> > > > It is useful because it allows userspace to check if vhost_vsock is=
 there when it is
> > > > configured as a built-in.
> > > >
> > > > This is what we have *without* this change and when vhost_vsock is =
configured
> > > > as a module and loaded:
> > > >
> > > > $ ls -la /sys/module/vhost_vsock
> > > > total 0
> > > > drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> > > > drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> > > > --w-------   1 root root 4096 Sep 29 19:00 uevent
> > > >
> > > > When vhost_vsock is configured as a built-in there is *no* /sys/mod=
ule/vhost_vsock directory at all.
> > > > And this looks like an inconsistency.
> > >
> > > And that's expected.
> > >
> > > > With this change, when vhost_vsock is configured as a built-in we g=
et:
> > > > $ ls -la /sys/module/vhost_vsock/
> > > > total 0
> > > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> > >
> >
> > Hi Michael,
> >
> > > Sorry, what I'd like to see is an explanation which userspace
> > > is broken without this change, and whether this patch fixes is.
> >
> > Ok, let me try to write a proper commit message in this thread. I'll
> > send a v3 once we agree on it (don't want to spam busy
> > kvm developers with my one-liner fix in 10 different revisions :-) ).
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Add an explicit MODULE_VERSION("0.0.1") specification for the
> > vhost_vsock module.
> >
> > It is useful because it allows userspace to check if vhost_vsock is
> > there when it is
> > configured as a built-in. We already have userspace consumers [1], [2]
> > who rely on the
> > assumption that if <any_linux_kernel_module> is loaded as a module OR c=
onfigured
> > as a built-in then /sys/module/<any_linux_kernel_module> exists. While
> > this assumption
> > works well in most cases it is wrong in general. For a built-in module
> > X you get a /sys/module/<X>
> > only if the module declares MODULE_VERSION or if the module has any
> > parameter(s) declared.
> >
> > Let's just declare MODULE_VERSION("0.0.1") for vhost_vsock to make
> > /sys/module/vhost_vsock
> > to exist in all possible configurations (loadable module or built-in).
> > Version 0.0.1 is chosen to align
> > with all other modules in drivers/vhost.
> >
> > This is what we have *without* this change and when vhost_vsock is conf=
igured
> > as a module and loaded:
> >
> > $ ls -la /sys/module/vhost_vsock
> > total 0
> > drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> > drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> > -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> > -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> > -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> > -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> > -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> > -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> > --w-------   1 root root 4096 Sep 29 19:00 uevent
> >
> > When vhost_vsock is configured as a built-in there is *no*
> > /sys/module/vhost_vsock directory at all.
> > And this looks like an inconsistency.
> >
> > With this change, when vhost_vsock is configured as a built-in we get:
> > $ ls -la /sys/module/vhost_vsock/
> > total 0
> > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> > Link: https://github.com/canonical/lxd/blob/ef33aea98aec9778499e96302f2=
605882d8249d7/lxd/instance/drivers/driver_qemu.go#L8568
> > [1]
> > Link: https://github.com/lxc/incus/blob/cbebce1dcd5f15887967058c8f6fec2=
7cf0da2a2/internal/server/instance/drivers/driver_qemu.go#L8723
> > [2]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Does this sound fair enough?
> >
> > Kind regards,
> > Alex
>
>
> Looks good, thanks!

Thanks, Michael! And I'm sorry for not being clear in my commit
messages from the beginning of our discussion ;-)

Then I'll send v3 a bit later as I see that Stefano reacted to this
proposal too, will see how it goes :-)

Kind regards,
Alex

>
> > >
> > >
> > >
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > >  drivers/vhost/vsock.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 802153e23073..287ea8e480b5 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> > > >
> > > >  module_init(vhost_vsock_init);
> > > >  module_exit(vhost_vsock_exit);
> > > > +MODULE_VERSION("0.0.1");
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_AUTHOR("Asias He");
> > > >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > > > --
> > > > 2.34.1
> > >
>

