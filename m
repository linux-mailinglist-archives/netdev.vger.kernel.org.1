Return-Path: <netdev+bounces-130478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B471298AA8B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CBF288734
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4C195390;
	Mon, 30 Sep 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="T7m7ADgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E88194AD6
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715853; cv=none; b=fCsvvdS2PiTgEcD7CYG1/aU5GZOPGR9PQThSR1+KCxcmLLL7vr3I7K8r1zK0IjmCDHnZO9Pi9gk1ZbnRmVwNGoBUC6bqKJD0zp+2vIQVW98rMMkJOk/Yl+roFRG9mqge7C4VgvOBKV58CNc9RZdqB3iiQa38oFHGvXTFikKWcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715853; c=relaxed/simple;
	bh=Hxy5RRz3ZDbul6zT6nM1wJ24XgbC59beRrdTOnK6vH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee1HLt8S43oBEa8CJuZyYB8bO4fVj8LQWmEXYL/zvyIYS/QIgSk/IFA1i5eZsnMmAJTUFYt0CeRNuw0bsMqPe/qzFcV7rUZgwNDobgKjNdhSxBaD44CN654ikfI3W6H21dGn33b8PSwqe4M1wrMrTVfFne1IOqVSf3EcfczVUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=T7m7ADgb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16D163F197
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727715845;
	bh=uCq97dcBwspUfA12XvnHz7wkL3yN6ZAbWmU3HPjeKvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=T7m7ADgb4MitXj+Zs9Dk7wDPbb2SS9YzRH+RhPdUYF56kUbnuhA4OKqw13PT3EFVb
	 Yw7BrIpYiuQcHFxQJiEe8pwVhquqjlk5O7Zp0l9cpR7Q86Jy8Nl4wHKvYxYZf7zCX7
	 +okTr3BxOH1zkZIYODG1cIs6LGqzygOSMr33kzkD8w8ICntiytFKXvx3smXD47jHXj
	 8ToN8YTlGNFGb4rH+LzrPj8e/RBGemf+mX5fg8vIW7Qr/vzISYIBgOdj3JAfga74Ef
	 e0IgoKIv01zv7syoBoTwZOP0naSaTYKK41Kg1ihvbo/79fViKWq9J989ZQb0gdsG0n
	 Kd1UmpWI0Y1dA==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4f515696829so3626051e0c.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715844; x=1728320644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCq97dcBwspUfA12XvnHz7wkL3yN6ZAbWmU3HPjeKvM=;
        b=p6j4did3X0pOwDJhVZbyGxiVqeE+2DzqVOXMib3GFL3Ynq5dp7/nwzoOALYk/UK6nW
         0hnN6N3qpJ8PtdGG7yTGwYB0hzbBSfHuaQB/QvKwY3CuOzR6r5ksxSXc7NtMwF9e8mtS
         PCDz5AkyiE+Tv10O14RhH4ololSl5qphLGEsO+WmqI8j5GKFmiM7foUQPOTR+CUwdjJ2
         s9bNCmqgNM/pFLd3q+hE5Zd8GWrgeJEEUBsL8P6DVfpC7YUN5dxa8mYJuDPrC34ADkgi
         mvBVV8Ryq5x622vw9hlrW0w5mknGPSowDqlBzo6TU6GydpjkdJN4gcKTTuqloeqTf7pE
         cujA==
X-Forwarded-Encrypted: i=1; AJvYcCWEWksYVy68Pr6ABnvnPCjGR3kkjQgZ9+XZQN5+2fY+C6zZ9gT7gTOjz1lGUWx0mW9Qp9Dlalc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxofhHydvyhjqjQbZy/Z4wA/opU29nYOvJvdGimPATp6lBpNQ5S
	JULZH6j5UQnt75ce7XShntzdLGzklXhidXlR5BNCLig5VwusuS9VKgiSz3Fk6FwgJsKAEPrT7a+
	MEQJYJEwgUKVYpc2FmxUu94LZ/d3Dd84/jdBM86D3lSLTIpAFPJXaNOd/Om3MabESjIGD5sQxN2
	3sH4E7nrmeGmiNxafnMfz7ceDmp/O8TufJq0GPwleo9nNr
X-Received: by 2002:a05:6122:d0f:b0:507:a6a3:6d7 with SMTP id 71dfb90a1353d-50ad3b8cffdmr397278e0c.1.1727715843970;
        Mon, 30 Sep 2024 10:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI10r0Myyi5Nwjiwg4H3fq4K1wjxeTVvrkOnj6DDSqCblFOLZtzteahkiAAEq+1E70tbSFfRQUqLdEHoDATvY=
X-Received: by 2002:a05:6122:d0f:b0:507:a6a3:6d7 with SMTP id
 71dfb90a1353d-50ad3b8cffdmr397203e0c.1.1727715843469; Mon, 30 Sep 2024
 10:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
 <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com> <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
In-Reply-To: <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 19:03:52 +0200
Message-ID: <CAEivzxdP+7q9vDk-0V8tPuCo1mFw92jVx0u3B8jkyYKv8sLcdA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kuba@kernel.org, stefanha@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:43=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Aleksandr,
>
> On Mon, Sep 30, 2024 at 04:43:36PM GMT, Aleksandr Mikhalitsyn wrote:
> >On Mon, Sep 30, 2024 at 4:27=E2=80=AFPM Stefano Garzarella
> ><sgarzare@redhat.com> wrote:
> >>
> >> On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
> >> >Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_v=
sock module.
> >> >
> >> >It is useful because it allows userspace to check if vhost_vsock is t=
here when it is
> >> >configured as a built-in.
> >> >
> >> >This is what we have *without* this change and when vhost_vsock is
> >> >configured
> >> >as a module and loaded:
> >> >
> >> >$ ls -la /sys/module/vhost_vsock
> >> >total 0
> >> >drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> >> >drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 taint
> >> >--w-------   1 root root 4096 Sep 29 19:00 uevent
> >> >
> >> >When vhost_vsock is configured as a built-in there is *no* /sys/modul=
e/vhost_vsock directory at all.
> >> >And this looks like an inconsistency.
> >> >
> >> >With this change, when vhost_vsock is configured as a built-in we get=
:
> >> >$ ls -la /sys/module/vhost_vsock/
> >> >total 0
> >> >drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> >> >drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> >> >--w-------   1 root root 4096 Sep 26 15:59 uevent
> >> >-r--r--r--   1 root root 4096 Sep 26 15:59 version
> >> >
> >> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> >> >---
> >> > drivers/vhost/vsock.c | 1 +
> >> > 1 file changed, 1 insertion(+)
> >> >
> >> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> >index 802153e23073..287ea8e480b5 100644
> >> >--- a/drivers/vhost/vsock.c
> >> >+++ b/drivers/vhost/vsock.c
> >> >@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >> >
> >> > module_init(vhost_vsock_init);
> >> > module_exit(vhost_vsock_exit);
> >> >+MODULE_VERSION("0.0.1");
> >
> >Hi Stefano,
> >
> >>
> >> I was looking at other commits to see how versioning is handled in ord=
er
> >> to make sense (e.g. using the same version of the kernel), and I saw
> >> many commits that are removing MODULE_VERSION because they say it
> >> doesn't make sense in in-tree modules.
> >
> >Yeah, I agree absolutely. I guess that's why all vhost modules have
> >had version 0.0.1 for years now
> >and there is no reason to increment version numbers at all.
>
> Yeah, I see.
>
> >
> >My proposal is not about version itself, having MODULE_VERSION
> >specified is a hack which
> >makes a built-in module appear in /sys/modules/ directory.
>
> Hmm, should we base a kind of UAPI on a hack?

Good question ;-)

>
> I don't want to block this change, but I just wonder why many modules
> are removing MODULE_VERSION and we are adding it instead.

Yep, that's a good point. I didn't know that other modules started to
remove MODULE_VERSION.

>
> >
> >I spent some time reading the code in kernel/params.c and
> >kernel/module/sysfs.c to figure out
> >why there is no /sys/module/vhost_vsock directory when vhost_vsock is
> >built-in. And figured out the
> >precise conditions which must be satisfied to have a module listed in
> >/sys/module.
> >
> >To be more precise, built-in module X appears in /sys/module/X if one
> >of two conditions are met:
> >- module has MODULE_VERSION declared
> >- module has any parameter declared
>
> At this point my question is, should we solve the problem higher and
> show all the modules in /sys/modules, either way?

Probably, yes. We can ask Luis Chamberlain's opinion on this one.

+cc Luis Chamberlain <mcgrof@kernel.org>

>
> Your use case makes sense to me, so that we could try something like
> that, but obviously it requires more work I think.

I personally am pretty happy to do more work on the generic side if
it's really valuable
for other use cases and folks support the idea.

My first intention was to make a quick and easy fix but it turns out
that there are some
drawbacks which I have not seen initially.

>
> Again, I don't want to block this patch, but I'd like to see if there's
> a better way than this hack :-)

Yeah, I understand. Thanks a lot for reacting to this patch. I
appreciate it a lot!

Kind regards,
Alex

>
> Thanks,
> Stefano
>
> >
> >Then I found "module: show version information for built-in modules in s=
ysfs":
> >https://github.com/torvalds/linux/commit/e94965ed5beb23c6fabf7ed31f625e6=
6d7ff28de
> >and it inspired me to make this minimalistic change.
> >
> >>
> >> In particular the interesting thing is from nfp, where
> >> `MODULE_VERSION(UTS_RELEASE);` was added with this commit:
> >>
> >> 1a5e8e350005 ("nfp: populate MODULE_VERSION")
> >>
> >> And then removed completely with this commit:
> >>
> >> b4f37219813f ("net/nfp: Update driver to use global kernel version")
> >>
> >> CCing Jakub since he was involved, so maybe he can give us some
> >> pointers.
> >
> >Kind regards,
> >Alex
> >
> >>
> >> Thanks,
> >> Stefano
> >>
> >> > MODULE_LICENSE("GPL v2");
> >> > MODULE_AUTHOR("Asias He");
> >> > MODULE_DESCRIPTION("vhost transport for vsock ");
> >> >--
> >> >2.34.1
> >> >
> >>
> >
>

