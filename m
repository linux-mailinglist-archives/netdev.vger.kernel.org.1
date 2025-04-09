Return-Path: <netdev+bounces-180650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A731A8203A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335974C18D4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4322D4D4;
	Wed,  9 Apr 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSfCJDAX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5692AE89
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187908; cv=none; b=hKxA0WfvPmSPYBRYvK0O0CE2mEiakeuHKapTBoczcxJJfdk5GoWGurFFODTKsFBSKXnVnRvdGbz1YI9eIozXPcjkN9xhxeHqexqQKBTqHph91nv0dsVASuHf2ByYBgcnUK5LaBxNIZG3B6qxZdxvjS0WV4MD/PevkGHtcXHSqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187908; c=relaxed/simple;
	bh=61PW9y7PDNWOcIblSehzngap5jGtPaiZoqUtTkIf7Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHN3khf9oZhP36XbFy1qo5MO37TwnSYgQiYUsbhmMGGjfCGAmyX1lDTzixGZRJARmIPTc4Vj6NsEUryScarGNQvq1ztcLcrgKwFHWdIoia6E9ygGErkseJ96Xyq2dEWc+s+qc12jiGqSgJAzPvpTirxppbh/yRlRyOE37Zhflio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSfCJDAX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744187905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Db2JSRrytLkXPNCk2u9oY2iCWyl++39LNyoKOlHjxS4=;
	b=NSfCJDAXC34jrFptPGDjx0rTF0OMzG5QLUJf6xgealGWuI4d3jd+px3MoaSAS8ZOFABoOH
	bMxw/efRCmI7NrHxZRolHq3bkfFCZVrLEDdeiypBa/GRag7BHbMBDR4I58pm3YqJWIds39
	4F2alWgFNnA6e2qyMKSgANV6QvYWRGk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-mId4LvS-MOSWkKA2uOHcWQ-1; Wed, 09 Apr 2025 04:38:24 -0400
X-MC-Unique: mId4LvS-MOSWkKA2uOHcWQ-1
X-Mimecast-MFC-AGG-ID: mId4LvS-MOSWkKA2uOHcWQ_1744187903
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3dca41591so620175266b.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 01:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744187903; x=1744792703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db2JSRrytLkXPNCk2u9oY2iCWyl++39LNyoKOlHjxS4=;
        b=XbGUrdSTBSGzUwCz/6Hz4me/oycpSJ9fhG0x85bG+sMIfZMwNPOIJEcuRR8aFAwuou
         TP7Gi2hOUKcOQ3l+r/6NtFwUS9lFPgkjfySnDIMCP18p5CkLkHvCku7C9TTLCvytRg3K
         Xfcz0ZVHrPARYlHVMaCEoN8vpgmk8EhHm+iKlPnvc3dtItRSZoa7foGXSbPtJZx/clgO
         9t/ooxEG4OntpuNsb+SMRVYiZSNk2lSK8E2lw3OEmEZ+imIqK3K6h2ap4/3t68i9NCbu
         +GMBpfGIeou4K1HQ4VRb+8ddslG9NzaEEU9V75LrY316WlnEDYxRRWKXqCqUO2LUHTKD
         kiAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWdIf+ZWTiXujeZPUWQUZTEdjjaskHQ7awgmD2hMosYXrAPvrXuupgwTx+RQ9qIsUTeSuuerI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMcWgrAT4j9bgDUBTeaX1EB1f4e9F8p5Fj+Ke2+me2q7+6smU
	wudLF8ftZz0AGDb73OJMnh7RmQkuGM5jK5zQss598rlxKbyFKGa2Kp9F04LKe/Y4DHdzmSac+Sq
	JlHQRRqW+VmCdzcuyrO0QxaqTfNPqorr2fg/Ou6Fh/z/l5MJICAILrOzvhHC6+sYy8Wt+XaKzvb
	VXbIe6nFIDrV5MaHQAGg+H+i+biNz3
X-Gm-Gg: ASbGncudCOQp/Hlw6XzJ9LI7g2VMCQsQMRch3RVFya2KqlR/SMtuDzalox++mhG7TXz
	b9nyyGeeZyiqSGxO8ZgiPeSrqtFyGudtlv2fxWiU5w9gGPw9AIOcSOgLKuXP7NKIGp+5Zmw==
X-Received: by 2002:a17:907:d22:b0:ac7:e5c7:d235 with SMTP id a640c23a62f3a-aca9d5f2efbmr173776766b.17.1744187902787;
        Wed, 09 Apr 2025 01:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfsT/n2l3DnTQQWDgOLT9XB9DPUTgcUViU2G8XrGBhEdFOH5XIrY6JzqMwM3FJqCj1qI/dn6iOuo9AsFhQy0g=
X-Received: by 2002:a17:907:d22:b0:ac7:e5c7:d235 with SMTP id
 a640c23a62f3a-aca9d5f2efbmr173774366b.17.1744187902343; Wed, 09 Apr 2025
 01:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-9-lulu@redhat.com>
 <20250408075426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250408075426-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 16:37:44 +0800
X-Gm-Features: ATxdqUHSwziP5tEY_Ach5syGN9Prz3P9ZHSrioqnJKFuE86H3ZVl_NFlZH6Hdgk
Message-ID: <CACLfguXTYy2BfmB3wLnVdANu6jvxjP4G8a3h2XHO-iw5RE1CnA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +     bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +     default n
> > +     help
> > +       This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> > +       userspace applications to modify the thread mode for vhost devi=
ces.
>
> ok
>
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to=
 `n`,
> > +          meaning the ioctl is disabled and any operation using this i=
octl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
>
> no need to be so verbose - the disabled beavious belongs in commit log
> not here.
>
> Also either ioctl or IOCTL but not both.
>
sure, will change this
Thanks
cindy
> > +
> > +       If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..568e43cb54a9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >               u8 inherit_owner;
> >               /*inherit_owner can only be modified before owner is set*=
/
> > @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D 0;
> >               goto done;
> >       }
> > +#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > --
> > 2.45.0
>


