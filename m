Return-Path: <netdev+bounces-88568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD118A7B70
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6FEB22B55
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565845957;
	Wed, 17 Apr 2024 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcjIEWzL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D944C7C
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328673; cv=none; b=DgjoLPj5kJ3rtiVYABtJnwimZYQJc+ktnUwNbAlUntBtoSrTm0fQRaeSkFj4PtyyXIfbT5gVSEiwlYG+VizCByIxk9dtPi9SmJ8HldGVTBtMJvjjx+ev8oFC+WG74dV6knlOnMEZD4CcexoapinTyIW081FisN3pssXz9goELGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328673; c=relaxed/simple;
	bh=6u3GKlFSpoC10lgNlkKM4E/0oPW+3YT0UrSAx8dtQ8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML4hxJXfcLeF7Vp8DQPaUQN3NQNjEcBuhNm8DJAlBJJywbYNf82ShkikVDw3m/2jXcZaiI707NDDlHsVx/DHNILNhVL6qeKZvLumrx6f2S7EI1Y2kXTqCSpiQ4l2eizyorC38E0Zgu0QZYSWesB7pmssApQq2n+77EWxVb9Uv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcjIEWzL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713328670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDzI+eWvpQYZ0ImlPJLuB0OPGdawUBCt6eGK/x6pkLU=;
	b=FcjIEWzLgtEWICVURAe1CwYuW+DASVYAHOvvhxos+pntmfnBVWqLr3/xyYtz9J1oyczlgX
	2W+w3pAKfJpClgdLmEijlxOvFsi6SDMaTjfxChUMCEpBx57isHyqRuyrpBautBxq6ABBuO
	0dY2Y9kHSXOivlvGZgHTll41J+b6+dQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-gNKdYY0aOAK083Rt-VZe_g-1; Wed, 17 Apr 2024 00:37:42 -0400
X-MC-Unique: gNKdYY0aOAK083Rt-VZe_g-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c5ed191fe3so6417993b6e.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328661; x=1713933461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDzI+eWvpQYZ0ImlPJLuB0OPGdawUBCt6eGK/x6pkLU=;
        b=ls9YEdNas6O8eK7N1YG4o3Q9r4FrFfSGeThQX7S/8OWwSZB4IRrL2Uf8XEBoehWS99
         tTdFLHTUvGO9z9qR0+7WuYp3sNkjCLfkuioyc3Viv/5KO2Ij9YVg250d+rjLkEWBd8GP
         iqID1JE1RB/AkysNr/WCIwic+rHifSQB0TULiBe1C3AvEBvBmI6tujHWBMZ0POfxtlNV
         3GJUL6Xp5aoa9cOD930bCvscZ1PP6XHMmna3VhEHJVh4csmbBBN50uEZbpSxVolpsquM
         GKlCB2C1vPLRToyNMIKd4ycOERafdjN7jp3QSqWAyYGk+/jPeQWqpPX0FrMaqbHziciX
         BV1w==
X-Gm-Message-State: AOJu0YxkOmhZFX+hVpteT/JYf6kBlFTGLYKSr5bm8dlkHadVT69i72d3
	jowShTZbUG7/Ar+FnPpFnR7FZwAgrp/4L/ci8j+alEhNt7WRCS8a5zF5DBpQ2l+bs/yKq4D1gxV
	o49WenYs+JTkzeIMEinsNGu2ZWVz+XnjWiW+bVTOLw3rRYRisg13U7ZOZJCeTiptX36i4sbVJ8R
	gaXzG3hpCzrstwRhi46ydqdxLlt0iL
X-Received: by 2002:a05:6808:4406:b0:3c5:f056:5df1 with SMTP id eo6-20020a056808440600b003c5f0565df1mr14573926oib.30.1713328661607;
        Tue, 16 Apr 2024 21:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPyQOhuoksiXETieVQiL4ktPmvaFhbyn09+z30rs2FVFfsVE3H6qT8PMgIL12EumOKHbJEnaW4RziRWMxmwsE=
X-Received: by 2002:a05:6808:4406:b0:3c5:f056:5df1 with SMTP id
 eo6-20020a056808440600b003c5f0565df1mr14573913oib.30.1713328661365; Tue, 16
 Apr 2024 21:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com> <Zh5G0sh62hZtOM0J@nanopsycho>
In-Reply-To: <Zh5G0sh62hZtOM0J@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:37:30 +0800
Message-ID: <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:37=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
> >On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Currently there is no way for user to set what features the driver
> >> should obey or not, it is hard wired in the code.
> >>
> >> In order to be able to debug the device behavior in case some feature =
is
> >> disabled, introduce a debugfs infrastructure with couple of files
> >> allowing user to see what features the device advertises and
> >> to set filter for features used by driver.
> >>
> >> Example:
> >> $cat /sys/bus/virtio/devices/virtio0/features
> >> 1110010111111111111101010000110010000000100000000000000000000000
> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> >> 5
> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> >> $ cat /sys/bus/virtio/devices/virtio0/features
> >> 1110000111111111111101010000110010000000100000000000000000000000
> >>
> >> Note that sysfs "features" know already exists, this patch does not
> >> touch it.
> >>
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >
> >Note that this can be done already with vp_vdpa feature provisioning:
> >
> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
> >Author: Jason Wang <jasowang@redhat.com>
> >Date:   Tue Sep 27 15:48:10 2022 +0800
> >
> >    vp_vdpa: support feature provisioning
> >
> >For example:
> >
> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020=
000
>
> Sure. My intension was to make the testing possible on any virtio
> device.

It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
with mediation layer (like feature filtering etc). So it can only run
on top of standard virtio-pci device.

> Narrowing the testing for vpda would be limitting.

Unless you want to use other transport like virtio-mmio.

Thanks

>
>
> >
> >Thanks
> >
>


