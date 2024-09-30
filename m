Return-Path: <netdev+bounces-130431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06798A781
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F381F214D1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBE192D62;
	Mon, 30 Sep 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="i85YcwQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C79192D6D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707432; cv=none; b=cGAaTuJlGGQRWhEGEFWOra6lb18f9R2kPGkcwPiF5XNKfmwH0KabDTXnYsPB0ydXPal98c7chYC26CNBGHDtekBiGLv7pBLGa8aPqU991VHb3+eMVT3CT4w5yfyGWoFHZ7XpfNZKxFtTa50Jog+jefmvIGL2ogrz5J0JVU1V2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707432; c=relaxed/simple;
	bh=uposKn/p+RXVVaJ13hyjFB5pwStx2I7diBnj3Ss0lRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnPeIXAemGxHDAKCP0mhYgjJN2hgvqE9xbyWgzijUZlU6RxedEbaWmpDHS12f1Sy6ZRJHj0saA1HpJQbAD/+UlGJBrcBU0Gb4SFKVw+3cB1LrWFyhf/UppoYPlbAqOmgYPQr9ls3dMhtyVVo44a7A/Yv4ZKDSEAUb0oGTa9+bbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=i85YcwQX; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCE9B3F427
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727707428;
	bh=W/CpSjXnAbCC5PhjkBvCzNNH6T78kZp9wxS/oiXqX4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=i85YcwQXXFRVhpvY9Yqy0AF1ocopzQ/yG354NT3Me4IKqO4TY0sFFaDKik83ezKoD
	 Roh0fENETmFkA8/r/idqKtB1v9er4eQWURDIH1xlyjSJBaXf3O3eVOiRBfxmBAhxMx
	 szM+2G96DUjmbxBGyCNBLnkLSCKPwU1zGNGzk81GsH3/dSL/Iz3j3L/A1VfBvfUINa
	 W3I5ojTWL4vel1Ka3SsAYTmLI/23NoV9NJCHfBt+AlVTJOZzyq2dnHL9Jwrm47zVFe
	 8q9HR53IjxQfdDf3/J6GTfwv4mE2hzR4CGpjp3CT/dfYj79WahfECgn+zbYGWc8H9G
	 S0oqrVN/a9xDQ==
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84eed724693so190945241.2
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 07:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707428; x=1728312228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/CpSjXnAbCC5PhjkBvCzNNH6T78kZp9wxS/oiXqX4o=;
        b=sgZbXr7G2nH/i85Y9nO+WkTYkTIRthcr3LZ/86Ublin1J2eX8dQxfe8+Dx6TxR6qD0
         6oPP6QS82lq6HSZGtjly3f3mwJ4SK2+q7b+S9JVJtsgVH3W0xRIZCoiGixOBF/a5l/1w
         BqbKB58iLwRBZP5h0fitzfSdCyLUZo2sr8BoM/ER9ybpT0Vlsvbra8QANXvRzSzI5Vyu
         QneTGhkkG1rjGATs89W743G3nWqr2eMIl2KkRkYIxGllzV1ths1/CorjpYP/QpsHxi9a
         wJuZuoacYR8mbrZ11MuQb8vxt3QKvi6JnmVr2PEIvY+KocdyMNdcH18WAVL8NMyrk7F+
         725A==
X-Forwarded-Encrypted: i=1; AJvYcCWAb58ffuNqyYigCU/fQN9RaZFIZDnal/xFfdvaHmp7VqJ6UnSK40LHpOeYwbOqkkVgjgMoiEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmceqhy8C81iqPYUOMfXnUuLo6ncGR/bBLl6GFdA3TzPo4JNv+
	Q51SQKglBoQ3bcwqdf0EUBJgrpKK3Hq/e0upCJdTIrgE0tvwHp8DbvB8QiLbaugGN/sTqtz0P1r
	6VNXa3aAu1STqWho/VH5c6ujIungPkApDf+t3aviy6tIgrkni+0WGU5zZFMEl93CeCuWbxuLssR
	CU2iAuQr77ydxGmzQVvqpdRN9GJ9N59IjzYptLTp4t9zlt
X-Received: by 2002:a05:6102:2ac3:b0:4a3:cb2b:973f with SMTP id ada2fe7eead31-4a3cb2b99famr2323742137.28.1727707427948;
        Mon, 30 Sep 2024 07:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT2J/m0NVC75kbEvfn4OfZt54LSw4OCiDc5FsVbH2mUHDoOJEzl4v18NtheL7cofpCqo9z3D4+bYZ//SP/5ks=
X-Received: by 2002:a05:6102:2ac3:b0:4a3:cb2b:973f with SMTP id
 ada2fe7eead31-4a3cb2b99famr2323716137.28.1727707427631; Mon, 30 Sep 2024
 07:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com> <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
In-Reply-To: <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 16:43:36 +0200
Message-ID: <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kuba@kernel.org, stefanha@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:27=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
> >Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsoc=
k module.
> >
> >It is useful because it allows userspace to check if vhost_vsock is ther=
e when it is
> >configured as a built-in.
> >
> >This is what we have *without* this change and when vhost_vsock is confi=
gured
> >as a module and loaded:
> >
> >$ ls -la /sys/module/vhost_vsock
> >total 0
> >drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> >drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> >-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> >-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> >-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> >-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> >-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> >-r--r--r--   1 root root 4096 Sep 29 20:05 taint
> >--w-------   1 root root 4096 Sep 29 19:00 uevent
> >
> >When vhost_vsock is configured as a built-in there is *no* /sys/module/v=
host_vsock directory at all.
> >And this looks like an inconsistency.
> >
> >With this change, when vhost_vsock is configured as a built-in we get:
> >$ ls -la /sys/module/vhost_vsock/
> >total 0
> >drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> >drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> >--w-------   1 root root 4096 Sep 26 15:59 uevent
> >-r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.co=
m>
> >---
> > drivers/vhost/vsock.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 802153e23073..287ea8e480b5 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >
> > module_init(vhost_vsock_init);
> > module_exit(vhost_vsock_exit);
> >+MODULE_VERSION("0.0.1");

Hi Stefano,

>
> I was looking at other commits to see how versioning is handled in order
> to make sense (e.g. using the same version of the kernel), and I saw
> many commits that are removing MODULE_VERSION because they say it
> doesn't make sense in in-tree modules.

Yeah, I agree absolutely. I guess that's why all vhost modules have
had version 0.0.1 for years now
and there is no reason to increment version numbers at all.

My proposal is not about version itself, having MODULE_VERSION
specified is a hack which
makes a built-in module appear in /sys/modules/ directory.

I spent some time reading the code in kernel/params.c and
kernel/module/sysfs.c to figure out
why there is no /sys/module/vhost_vsock directory when vhost_vsock is
built-in. And figured out the
precise conditions which must be satisfied to have a module listed in
/sys/module.

To be more precise, built-in module X appears in /sys/module/X if one
of two conditions are met:
- module has MODULE_VERSION declared
- module has any parameter declared

Then I found "module: show version information for built-in modules in sysf=
s":
https://github.com/torvalds/linux/commit/e94965ed5beb23c6fabf7ed31f625e66d7=
ff28de
and it inspired me to make this minimalistic change.

>
> In particular the interesting thing is from nfp, where
> `MODULE_VERSION(UTS_RELEASE);` was added with this commit:
>
> 1a5e8e350005 ("nfp: populate MODULE_VERSION")
>
> And then removed completely with this commit:
>
> b4f37219813f ("net/nfp: Update driver to use global kernel version")
>
> CCing Jakub since he was involved, so maybe he can give us some
> pointers.

Kind regards,
Alex

>
> Thanks,
> Stefano
>
> > MODULE_LICENSE("GPL v2");
> > MODULE_AUTHOR("Asias He");
> > MODULE_DESCRIPTION("vhost transport for vsock ");
> >--
> >2.34.1
> >
>

