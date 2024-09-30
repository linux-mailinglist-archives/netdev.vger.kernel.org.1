Return-Path: <netdev+bounces-130354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572C98A269
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3D1C21710
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE918E36A;
	Mon, 30 Sep 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DL5jFyXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615618E354
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699328; cv=none; b=a512nIrJeIHCeYTPBp3EC19bU/GQvVzf+rRZEvk72C8hC4ZG0P2VJVnHDQeq2fbOThdEvJyEYj6VrbBZpMHwgu7OgIZX+Mr8ITsWBx5hbf0kLEyc3fNLO8JvTULkl/UjSqz25VQJ27xwUUpqK0MwBts9Od3/bI0FKQ24/iibSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699328; c=relaxed/simple;
	bh=Qs3Lx77ih1oGuQEQaE5Xr+rDDJ0+tfigyqRV7na0ym8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HihD+BHZrtMpJltrfjix27fa8cmWy268dqGFoQjaswlEsI5uieuqVgElxCTqqs7NdXf2krBFANsQGj22FABTF1dnY6iQ6w24riilQWPp1f2U4Z4BWyfPxSBBxtP8r1ne9os0F3BV+Q4JRVgLpDegoevrim7ha2nqTlvbGijjOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DL5jFyXA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C0D83F5E4
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727699323;
	bh=ccmCiOQhZeUMRjWEGS0Si8fclp+XCrQMa0zBHhcdvp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DL5jFyXA+iEMng/14fyKJXqqRSIoRUQurMRhUFNCZrXnf2sq1FYlK/wUMgzxOrSst
	 /ZWnddWij2KMELi61CPb0XMgo9dqiwwDDddslIMsvSQvbkJ9R4i1iqFDRwuWvxm1Np
	 RHKR+8YmOkyYSxYYM45W36r80lN0howG6N0kbFspl+PlglkjiJNAoYu68S9xOyDM9D
	 LSmbMpq4Yo1efkEak20Qybgq/lrrLSnaqC4T67AbxJ9OEHDP0QS5OVOxOw12BTrnc2
	 3Cv6etWMc/3J2aF/z4JXkLs6lWxoMyRXevY/gMzzlyCQJacfAoK94vuO1eFrmBd7lQ
	 GOBMHuSTxLCJw==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-509ea43af33so221498e0c.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 05:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699322; x=1728304122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccmCiOQhZeUMRjWEGS0Si8fclp+XCrQMa0zBHhcdvp8=;
        b=Z+VOut0dEJ2r3yX4YVn72404tDcYZgbFM0x4QRsC+EsYJ+2fakTGxtJZmpGYqZSGEF
         fLTIM0mpGDpd/WwwGYJcbuBArKvvvZRmEKr1sWWVD6OA/9izVwLCuzkA/fXwA/Rd4PF/
         XLId159i82hStj/twJquhKSr6IMWPpE4UqGy4p1DLjP0BWY6DIbe4Qxdgm92Q1zEfXj7
         r3WcWolJrvi2rpakCPZhXjJHGI570Rn5Edjnaq8BaKymNXD3HUI4W9Xwr+mTPRnuCoVH
         yjfoMt0E4h2iYKGGIyvJLPZN37MTaUBjM3qNmBcXxa5dCJ/AltFvbLd6g8Wk+9sVRfJl
         TrgA==
X-Forwarded-Encrypted: i=1; AJvYcCV/dJ02WYcSFiK6tISwUYAdklKUd7whMIhhMlyEk46xm2Bw3+qYv3bZ1er4cp2PiJWg6WKwwsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiET9FtxakZWa4rl3ONvb63MFmrKfRfFiYOn4P17bKT729EBAu
	9r1mGXxRC65kBCImLDZlJml+U6Oy8g63Vgqf94XniATrM8+djL8CLmqcqXU1lCrSUYA/aQwFgig
	oSFHo68AuTWFkHe/1OgfZVm/CWhUa3nCs9PS4YGMePrLkfbU6i4loTsJ9RjqeP50gekCW51VpDy
	fk+Gxi0QzjWwhVN9XZ5TEz+yolxpheTeb6kZfTR3fdf6Ul
X-Received: by 2002:a05:6122:c9a:b0:50a:b7b5:30c6 with SMTP id 71dfb90a1353d-50ab7b5345dmr1653706e0c.8.1727699321593;
        Mon, 30 Sep 2024 05:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9iHSL869qB63t3MhxKcid/7j2ONP/nctW+LPfFUOmGxo8rYFIokQ+0UJMT9guM5Zj73BaD99bYvbkHrBiTJA=
X-Received: by 2002:a05:6122:c9a:b0:50a:b7b5:30c6 with SMTP id
 71dfb90a1353d-50ab7b5345dmr1653680e0c.8.1727699321135; Mon, 30 Sep 2024
 05:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com> <20240929150147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240929150147-mutt-send-email-mst@kernel.org>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 14:28:30 +0200
Message-ID: <CAEivzxcvokDUPWzj48aJX6a4RU_i+OdMOH=fyLQW+FObjKpZDQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 9:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 29, 2024 at 08:21:03PM +0200, Alexander Mikhalitsyn wrote:
> > Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vso=
ck module.
> >
> > It is useful because it allows userspace to check if vhost_vsock is the=
re when it is
> > configured as a built-in.
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
> > When vhost_vsock is configured as a built-in there is *no* /sys/module/=
vhost_vsock directory at all.
> > And this looks like an inconsistency.
>
> And that's expected.
>
> > With this change, when vhost_vsock is configured as a built-in we get:
> > $ ls -la /sys/module/vhost_vsock/
> > total 0
> > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > -r--r--r--   1 root root 4096 Sep 26 15:59 version
>

Hi Michael,

> Sorry, what I'd like to see is an explanation which userspace
> is broken without this change, and whether this patch fixes is.

Ok, let me try to write a proper commit message in this thread. I'll
send a v3 once we agree on it (don't want to spam busy
kvm developers with my one-liner fix in 10 different revisions :-) ).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Add an explicit MODULE_VERSION("0.0.1") specification for the
vhost_vsock module.

It is useful because it allows userspace to check if vhost_vsock is
there when it is
configured as a built-in. We already have userspace consumers [1], [2]
who rely on the
assumption that if <any_linux_kernel_module> is loaded as a module OR confi=
gured
as a built-in then /sys/module/<any_linux_kernel_module> exists. While
this assumption
works well in most cases it is wrong in general. For a built-in module
X you get a /sys/module/<X>
only if the module declares MODULE_VERSION or if the module has any
parameter(s) declared.

Let's just declare MODULE_VERSION("0.0.1") for vhost_vsock to make
/sys/module/vhost_vsock
to exist in all possible configurations (loadable module or built-in).
Version 0.0.1 is chosen to align
with all other modules in drivers/vhost.

This is what we have *without* this change and when vhost_vsock is configur=
ed
as a module and loaded:

$ ls -la /sys/module/vhost_vsock
total 0
drwxr-xr-x   5 root root    0 Sep 29 19:00 .
drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
-r--r--r--   1 root root 4096 Sep 29 20:05 taint
--w-------   1 root root 4096 Sep 29 19:00 uevent

When vhost_vsock is configured as a built-in there is *no*
/sys/module/vhost_vsock directory at all.
And this looks like an inconsistency.

With this change, when vhost_vsock is configured as a built-in we get:
$ ls -la /sys/module/vhost_vsock/
total 0
drwxr-xr-x   2 root root    0 Sep 26 15:59 .
drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
--w-------   1 root root 4096 Sep 26 15:59 uevent
-r--r--r--   1 root root 4096 Sep 26 15:59 version

Link: https://github.com/canonical/lxd/blob/ef33aea98aec9778499e96302f26058=
82d8249d7/lxd/instance/drivers/driver_qemu.go#L8568
[1]
Link: https://github.com/lxc/incus/blob/cbebce1dcd5f15887967058c8f6fec27cf0=
da2a2/internal/server/instance/drivers/driver_qemu.go#L8723
[2]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Does this sound fair enough?

Kind regards,
Alex

>
>
>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  drivers/vhost/vsock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..287ea8e480b5 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >
> >  module_init(vhost_vsock_init);
> >  module_exit(vhost_vsock_exit);
> > +MODULE_VERSION("0.0.1");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Asias He");
> >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > --
> > 2.34.1
>

