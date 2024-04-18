Return-Path: <netdev+bounces-88920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670868A903A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E731C1F21DBB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C63611B;
	Thu, 18 Apr 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBDqNvPH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7053AC
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401997; cv=none; b=Hp8fi3sAxlSje9I77gxP9MCV9UwkOaXdU8Vlhr4sjcGduxyBSEtKDYcV9MA3S6Cx8Kxqn9cWuJT2wHzJO85lJDZV/M/5jqOqUdQEKlPE7PIqmQo49IXoXp+i3VLocQYxccWfYM7i/C+ZdaBbAEC/FJ/FRhF1HKGSt2QVQsJ4Azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401997; c=relaxed/simple;
	bh=0PLswlzdRZac7fSfdw04a3qPdOrmUrMFKAUR9gvwR3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqPKU4KFmiArKCthhaRIF0MPuv63T8MfB2XOSbheVDCBv9V1PJLx2KgKAH8DT41oMKMvqMt0no4Iip1pTntSE8gYfuQ5eZ9t/6/yE/41If0UmSYDJbrACMoSwUzVfCYNRAjfN6t8JnCmnZ5RY31NhNIqtKLOKeLzxk6tPvF5iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBDqNvPH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713401994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRp0Lio2AX9EGb63nd6AbRw/SjgJeY4MzMTWj8Re0mo=;
	b=CBDqNvPHQKdXXMKz3dHVgyfTXj6bl+FYe6bCaBEZHQiCAoftmW1vKHVaB+vpQxklBDYf2T
	W2bgzRXBC37tEd2nTHoKIUwGCGabxg3bD9FcyAN8LC5U9ZvcOrNQBZ7nCu5SUchhQCGLsd
	pMY8qvxHEF+BFDkSAVghPsM11SkoCwo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-YTM4-QXGMtWZM7FiQZU5_A-1; Wed, 17 Apr 2024 20:59:53 -0400
X-MC-Unique: YTM4-QXGMtWZM7FiQZU5_A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so398347a91.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713401992; x=1714006792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRp0Lio2AX9EGb63nd6AbRw/SjgJeY4MzMTWj8Re0mo=;
        b=nsdPBL+oABJnsA1WQbCgT3n5Sm4lnZxh/mT81e4RP/e4HI+Pmtfs1W08eavxpNhx1c
         01lg+8G98VT/rfgCLN76HO6D1XHz0q0RaNxfFYGmrezuBJBeiEs+XUbWfNLloi9tjfP+
         ZKzsdHSZAIu3rgWDGOlVOYJFfvz8r7JSKSuPor9hEOJznoNkJTUVcUdXL8wqz4NyG0pb
         b0buW1INHUhywYaCMnjpqedqrohhoYvs4T50p9fA7DNmOBRLXKrqnwgxu2C7CaLJUj9C
         ZUoY5+tuYrVn1rfz6vf+OFi8DtdzCdrvp9wd2bR155iNxgLcO+UYa2JEa+0xaz/m6eeW
         r18g==
X-Gm-Message-State: AOJu0YyiEnnmuy94/32/cTIA8tKABcX9GHpGLAw8qrY7wVaA2VLD//DR
	YbUearaoUekGSAMNzVGVAGiMzeKX9hLledmTQo307iraBhlrgpaEb+n93ehwDthFNqicE5Mz2uJ
	tPEx2E9MJZHksai5uBny3E9JuIn5Xrjr6cgyKFy9Rajlo175iW1mlknQxVJdQel9ZCwI7FmK7YF
	BAFqmaVRaFJkUxVxHkOd8SMBzh+Ycq
X-Received: by 2002:a17:90a:fd0e:b0:2a4:9183:c8fd with SMTP id cv14-20020a17090afd0e00b002a49183c8fdmr1163528pjb.18.1713401992582;
        Wed, 17 Apr 2024 17:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRSEZTbSzFpG8KTOdNp1Y148is/WdwL9i3H7sSnLKQSp+rT15RLf+aKIMtklQmrOvy1WUR7L1GIi3UypknUms=
X-Received: by 2002:a17:90a:fd0e:b0:2a4:9183:c8fd with SMTP id
 cv14-20020a17090afd0e00b002a49183c8fdmr1163505pjb.18.1713401992242; Wed, 17
 Apr 2024 17:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho> <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
 <Zh94zX-oQs96tuKk@nanopsycho>
In-Reply-To: <Zh94zX-oQs96tuKk@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:59:41 +0800
Message-ID: <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>
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

On Wed, Apr 17, 2024 at 3:23=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
> >On Tue, Apr 16, 2024 at 5:37=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
> >> >On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >>
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >>
> >> >> Currently there is no way for user to set what features the driver
> >> >> should obey or not, it is hard wired in the code.
> >> >>
> >> >> In order to be able to debug the device behavior in case some featu=
re is
> >> >> disabled, introduce a debugfs infrastructure with couple of files
> >> >> allowing user to see what features the device advertises and
> >> >> to set filter for features used by driver.
> >> >>
> >> >> Example:
> >> >> $cat /sys/bus/virtio/devices/virtio0/features
> >> >> 1110010111111111111101010000110010000000100000000000000000000000
> >> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> >> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> >> >> 5
> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> >> >> $ cat /sys/bus/virtio/devices/virtio0/features
> >> >> 1110000111111111111101010000110010000000100000000000000000000000
> >> >>
> >> >> Note that sysfs "features" know already exists, this patch does not
> >> >> touch it.
> >> >>
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> ---
> >> >
> >> >Note that this can be done already with vp_vdpa feature provisioning:
> >> >
> >> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
> >> >Author: Jason Wang <jasowang@redhat.com>
> >> >Date:   Tue Sep 27 15:48:10 2022 +0800
> >> >
> >> >    vp_vdpa: support feature provisioning
> >> >
> >> >For example:
> >> >
> >> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300=
020000
> >>
> >> Sure. My intension was to make the testing possible on any virtio
> >> device.
> >
> >It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
> >with mediation layer (like feature filtering etc). So it can only run
> >on top of standard virtio-pci device.
> >
> >> Narrowing the testing for vpda would be limitting.
> >
> >Unless you want to use other transport like virtio-mmio.
>
> Also, the goal is to test virtio_net emulated devices.
> There are couple
> of implementation. Non-vdpa.

So what I want to say is, vp_vdpa works for all types of virtio-pci
devices no matter if it is emulated or hardware.

Thanks

>
>
> >
> >Thanks
> >
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >>
> >
>


