Return-Path: <netdev+bounces-184934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C20FA97BE5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C09D3BDBF2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ED02CCC1;
	Wed, 23 Apr 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWJOYj5X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54622097
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370107; cv=none; b=ulSU7ApM5bQMQPZLtKzjL4bdfJ3xGVTX6AN03lTK0rqG3yR8/9cs8emSfxlQur3liNkBWf0u0Co5srS62fFlbg+wM8vySRLoeRgXU0Nw52S7yLFWUpZtVaAI6u4VHBRXlfp+Tal2lnF67cuKopb8qPICCmY6V9llhX80qQy2VjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370107; c=relaxed/simple;
	bh=y4+VmnBCPOFdbmvjAoCJyBhIVZ7F2LWAXF/xQBnUmV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaKbHmf7zpg9HfrirzNJih9Ew8qAq3X91ChmsTYg7cdUzFnIduQLjtUG0PZpv+gblS3RgK/eRLUF8u1Tn4MCZhxiecn4ZgWkpZc4OK3sZccZwJ+gEorWTnCaF0Dix52HDF/IUZA0tSrlA3juJYcuwg8GXiJl1pjzpFE8k8OlNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWJOYj5X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745370104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suLnBGeG8Dzs3RiMxqx0Nd3yTcCcCMOBUwV5pRHCsPQ=;
	b=fWJOYj5X13o3UKWeazgW2VwXJXKLD9S2Y9YeMGRqCxh0Rzd+p8NQp8t08ipe2SeOADFwNS
	gfR4d+AuMe3DnyB82ySfmxUTLrQ1wYhCmWhhml0/ElsRdaE1KSTLcgz6jPuQD9yE9LSVOQ
	nOnZJm17mobnD7LOLvJnF3y5QzByfIY=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-RixEx_kCOjCNmprCFTlf-Q-1; Tue, 22 Apr 2025 21:01:41 -0400
X-MC-Unique: RixEx_kCOjCNmprCFTlf-Q-1
X-Mimecast-MFC-AGG-ID: RixEx_kCOjCNmprCFTlf-Q_1745370100
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-524021ac776so1421703e0c.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745370100; x=1745974900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suLnBGeG8Dzs3RiMxqx0Nd3yTcCcCMOBUwV5pRHCsPQ=;
        b=AwB46bVedZqjTZIQZXgOWhNfDukadi/7iZQ37FFWIgP6AEuWcV0DQIIejm/xcTUuGY
         WLV8fBrubU9qjrPG2GTs7kDlmH268EGTQnL8Y8NozUzDdmKVm288xh8HnUDFb5xjbIIv
         Vuy5Hx5DmG1eQ3Hx0byUB/eDS2V3T/lo+idowXuXsHgpS+EKvbV0IRPp0WHzjkab7IAI
         9lZUOTmgwIgnippbRsWsEuo1PVocjg1PN77qSFA0i4eabd/Pm5o3N5D+YwGEaeHJ/YcX
         br5lusjAMaHbmtb8sFPKoW8p2PEhToF+OSXksIBEVQxhbEwbnzrOIzS4lSmFgnk6XF7g
         g7nA==
X-Forwarded-Encrypted: i=1; AJvYcCWjzUav3ms1ehairpfj4nxqHRT7Nmm0JwsCqpn54K9Ljnu06sWzni57sJ/LJT03KFT158QSLcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51zjHCsEFa+DcfCn8Z7RARQF5+HCW7Fb27WP0C5/51/okCL9Z
	3qrNDw4W3QUgryVUwLJ9pJocw5AdyeMRd54l/fgH6UX0OwjTjbL0ykmaFzeFCVWzm/3JizOeUU4
	HnVgVqxgi/XTgnNvQk05MxsBEA6j8VNH/JBE1FMXA8GVR/XhSQ9GkD0e6mMDdKGZowRNqn0G6lg
	E5Zb2YZDlm2XXMvghZPiTNme3hI4bn
X-Gm-Gg: ASbGncsD+PNxm3Bd2Q6rcX6C6iDtT7jYsjJ9vxQ5YYOTrsV2ucvAWZeuB96HJTqRDvZ
	fkNa6PTog6lftgmrk+gdK95qF6xoKogY3R0zzXQFBQCP+HteLYiPrRycA4BPO7ZXGf4S5eA==
X-Received: by 2002:a05:6122:845:b0:529:2644:76bf with SMTP id 71dfb90a1353d-52926447a6emr10277477e0c.9.1745370100527;
        Tue, 22 Apr 2025 18:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvbJCqStjpUJNcZsRJqdDhzCFeNoakSOeF9eWWWREDdOPwaj5kbrY2hywj7CHtE2jo8yhRHUx16ZSWPen1OD8=
X-Received: by 2002:a05:6122:845:b0:529:2644:76bf with SMTP id
 71dfb90a1353d-52926447a6emr10277435e0c.9.1745370100250; Tue, 22 Apr 2025
 18:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
In-Reply-To: <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 23 Apr 2025 09:01:03 +0800
X-Gm-Features: ATxdqUFDeBhiQEseub1vErKUpOwvixR2h27usGyemXjbTXL31lTjXbacVPQH1vs
Message-ID: <CACLfguXocCF0dUrM9k2YvZz0fuC4=3dYmbh3h7gpUZQ2ASF3zA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:50=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Apr 21, 2025 at 10:44:10AM +0800, Cindy Lu wrote:
> >Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> >to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> >When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> >is disabled, and any attempt to use it will result in failure.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/Kconfig | 15 +++++++++++++++
> > drivers/vhost/vhost.c |  3 +++
> > 2 files changed, 18 insertions(+)
> >
> >diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >index 020d4fbb947c..bc8fadb06f98 100644
> >--- a/drivers/vhost/Kconfig
> >+++ b/drivers/vhost/Kconfig
> >@@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> > endif
> >+
> >+config VHOST_ENABLE_FORK_OWNER_IOCTL
> >+      bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> >+      default n
> >+      help
> >+        This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> >+        userspace applications to modify the thread mode for vhost devi=
ces.
> >+
> >+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to =
`n`,
> >+          meaning the ioctl is disabled and any operation using this io=
ctl
> >+          will fail.
> >+          When the configuration is enabled (y), the ioctl becomes
> >+          available, allowing users to set the mode if needed.
>
> I think I already pointed out, but here there is a mix of tabs and
> spaces that IMHO we should fix.
>
Sorry, I missed this comment while preparing the patch; I=E2=80=99ll fix it=
.
> >+
> >+        If unsure, say "N".
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index fb0c7fb43f78..568e43cb54a9 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+
> >+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>
> As I mentioned in the previous version, IMO this patch should be merged
> with the previous patch. I don't think it is good for bisection to have
> a commit with an IOCTL supported in any case and in the next commit
> instead supported only through a config.
>
> Maybe I'm missing something, but what's the point of having a separate
> patch for this?
>
> Thanks,
> Stefano
>
will fix this
thanks
cindy
> >       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >               u8 inherit_owner;
> >               /*inherit_owner can only be modified before owner is set*=
/
> >@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D 0;
> >               goto done;
> >       }
> >+#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >--
> >2.45.0
> >
>


