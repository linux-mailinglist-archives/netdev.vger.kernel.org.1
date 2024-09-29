Return-Path: <netdev+bounces-130245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2E98969D
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930222841CE
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C083A8CB;
	Sun, 29 Sep 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q/kyABuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0538396
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631355; cv=none; b=bb4fFwQ7nqLJRjELcvfSxMkK1oKVfg2RavD3O3JQpWZwM5Jtt9HLFRzqC4FayjOLJigj+GahsrczqAUMrzHNdYm96bRHSlaYlFLzJ2vHsl68WdWbQyGp/M8hTqwQM5n4kOxaqzfpsdj6MlIDa0iuJi4OGVN08cdzVwkRX7z1FyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631355; c=relaxed/simple;
	bh=7FJYoAf4UNnJsGqA3YqqHhA0Hb//TkkxwczcqdaRjo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THVops9WMsRzx2fa2h84ifeYf8WltSS1tcurafYbrxrL0FSETRHQKk0qjs7giQqTNJ/AwOc+KueXqPah8r1KdlXRF6K1rhPoVs4zZTjtsZ3Txmqh0GTjnmYAk014JIxDBUvrC5EDwzv82rbIH8LXsRBJMXhOlwOZeoXnv10ry2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q/kyABuQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6730C3F22B
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727631351;
	bh=Rl/pS/wt7QkZsPdEO+ufS/ZfVUHdqAefjBl7pvxI0CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=q/kyABuQccvPHM2EHagMIZ7oeXaHCtVsjCnoZ3OcrmpWHMXalaBORaSj1PYqbRlVX
	 oKO0q5NKHiyf/H5eoaIMWpd+SHONKOGTBJHb99cVSpouruTWhgiqavDc/UwG7Lz+9n
	 xUaBnhtzU09YGfX7gmHihVhtCokUuW+Hsm/6ttHgJ4WRIf1mqsL4cHiQK5jJIOFEmY
	 SyeuR23jxFZ6Sz7PTxFz3RehFEMOBH3Fyoyme/LyaaZNAYS11Y+iY7vd9M7OQvDIoD
	 TgZ/xyNVfXm3t12inUajjFC6lXse8gFfFodHHCuZJuHvBb2iwUCMoWTH0HKKQOGmL6
	 c+wQdrglPCbbA==
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4a3c8b1356fso12685137.0
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727631348; x=1728236148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl/pS/wt7QkZsPdEO+ufS/ZfVUHdqAefjBl7pvxI0CY=;
        b=QQ4o0jN7LCKBIwoW/fkxdoB7xAMuiwFndj1SycHrlrnQ2bEK7NTMklZkP2FYBi7fd5
         ggwxgNKSNGZ07jLKkOKleEXJMHDLTd3RSh8HTayenDVGV/yvovkfoshaTJ5w1h1hwItM
         lzjhqYwViBqwB8QgHJoihL17gblztTCVmpzrmDVxqVjkwmRr0FWFHl6Fju72Hk7gJ7oB
         DVJZHbI/1a40ECTqq1Ai8EIIPqZz4KWMH647ykNw/oZplUJNRoU9qddoku3mZbf2gfci
         yvq2xV2ucOaTn7UCt3uY6CNwKoga1aP+7ET4Zs6sQEg9/hi7Ei1jMaEIf4PD8TXYQcQl
         2SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUMILUpvLihbcArPcFvuF5V7qnDzy7LpoVwWlHf7N5r/joWK1OIq5aJYo5OFegstzaiXCfMCws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkS/mDWPxV1t/FIAFXTwU2+my83D75jny0fkna5XJm9gP056D
	76ksNBP4J340TuX/JQKg6vzrwKCEnKgdy2tEfd6Qf7FngxpUbd9PsYKg7wos3IKj034u2gctDg5
	T69x+nmMpKw59hLCtIEGKHj3/KSF1pkBOa27lZjq3JoiR5S4JFOnRUmhiRQCVSpTFAQQ3o/VqPS
	LLlM2Cxk8WIVTxvci3rCNm0eQvCjZXw98UYxWMgkAr5SCN
X-Received: by 2002:a05:6102:3909:b0:4a3:c48a:6d with SMTP id ada2fe7eead31-4a3c48a072amr568323137.7.1727631347974;
        Sun, 29 Sep 2024 10:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGumyMX+ocvMCel4pVMoToxGxjM87jX1L3K8ElBWypvEO0i4r1+ozb3p2pk+hDYSgoZzgLzkpNtCwVQexZ4Wy8=
X-Received: by 2002:a05:6102:3909:b0:4a3:c48a:6d with SMTP id
 ada2fe7eead31-4a3c48a072amr568306137.7.1727631346626; Sun, 29 Sep 2024
 10:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com> <20240929125245-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240929125245-mutt-send-email-mst@kernel.org>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun, 29 Sep 2024 19:35:35 +0200
Message-ID: <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: specify module version
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> > Add an explicit MODULE_VERSION("0.0.1") specification
> > for a vhost_vsock module. It is useful because it allows
> > userspace to check if vhost_vsock is there when it is
> > configured as a built-in.
> >
> > Without this change, there is no /sys/module/vhost_vsock directory.
> >
> > With this change:
> > $ ls -la /sys/module/vhost_vsock/
> > total 0
> > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
>
>

Dear Michael,

> Why not check that the misc device is registered?

It is possible to read /proc/misc and check if "241 vhost-vsock" is
there, but it means that userspace
needs to have a specific logic for vsock. At the same time, it's quite
convenient to do something like:
    if [ ! -d /sys/modules/vhost_vsock ]; then
        modprobe vhost_vsock
    fi

> I'd rather not add a new UAPI until actually necessary.

I don't insist. I decided to send this patch because, while I was
debugging a non-related kernel issue
on my local dev environment I accidentally discovered that LXD
(containers and VM manager)
fails to run VMs because it fails to load the vhost_vsock module (but
it was built-in in my debug kernel
and the module file didn't exist). Then I discovered that before
trying to load a module we
check if /sys/module/<module name> exists. And found that, for some
reason /sys/module/vhost_vsock
does not exist when vhost_vsock is configured as a built-in, and
/sys/module/vhost_vsock *does* exist when
vhost_vsock is loaded as a module. It looks like an inconsistency and
I also checked that other modules in
drivers/vhost have MODULE_VERSION specified and version is 0.0.1. I
thought that this change looks legitimate
and convenient for userspace consumers.

Kind regards,
Alex

>
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

