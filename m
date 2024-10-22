Return-Path: <netdev+bounces-137760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 127929A9A63
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78121F21C96
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF912CD89;
	Tue, 22 Oct 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id7sMsiI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F41A269
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580512; cv=none; b=IbJT/irEowmZFFSFMtRvtBn/WxqsJOfwetxASc1t1Yae5hXxv6g81DdCGJqE2gsxThtmb2ilKTuHtLbjmy0Wj66hv08NIMyvwBlZlxbz5Z1ekM16+rbG0rFHbVpvO+S9yZQF71dkxXrWEY3GIqSNsEmq1PypUYJThV1cCEtiUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580512; c=relaxed/simple;
	bh=iGd0svsRJoMM73FUQQx+8lvLyVjM9AuGBs5o8D0CMvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/1XfmxJBVKCmues1craJpjeV9iYmVy+5SIl70YYrBblxBlT1QBq4uyA6JebXpK8XkUXydzEPpcy0NDHoBMqBsixotXGf2AfxPUE/T1k9sxlC+K/0+MaCpw55lUvph1bTrER7vMKn3TRSDRV92u3A0QDdHlYUm7QDadkoQ/Ykrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Id7sMsiI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729580509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McLC6rxMsiIGGLwJmoGIzK3loFmlCUaFldQaUCSuRHw=;
	b=Id7sMsiIjYcC8lCM+sn9uwIQOatZHZV3POApDvHHB4x7XdSNPCcBeNHhZd5uni5t/xf/dc
	zHmD09SHOuQNJqjTYZH4gzP7ibvv5Sdi/mcBhTepgL8Bk6aGHjt/cXKdaL0MVZ7ot+nTjA
	HAqsqXFjmWYyNrbXvmDHjx7Xj8tcAVE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-a3YxCopiNzC4A4Wkday0MQ-1; Tue, 22 Oct 2024 03:01:47 -0400
X-MC-Unique: a3YxCopiNzC4A4Wkday0MQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99fd71e777so331897166b.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580506; x=1730185306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McLC6rxMsiIGGLwJmoGIzK3loFmlCUaFldQaUCSuRHw=;
        b=qwMC5vbrf/Thdqx7Swff7tRKVqmsd/JekMArofeVyP24IrZeujsgcDONQHDzA5Vm1z
         N3WQTKzZQyMjsPyu3bJoRmMVqlgU//NSfPnQoyyPVeei+XEfbm1lF3K3ki+uNfrMZggv
         hniML1FTI4LvKLEUhxbu2UcohUu3APxi7GFZZ+NP0d70j3nn01qKFR1J9CkB+SX32V2l
         O1R6HdEAK8q5n5niQsMKXg7RLXzG463380kEHngRH2LNWiSfmHziRZtB4OoiXrsP0hJ1
         IEON7iBR0/TyJbck7+sRx5ij12OfCs6AcVj4mwHyvGTGFKDEFdDfwTdbIx8LFfrpuaXd
         DOkw==
X-Forwarded-Encrypted: i=1; AJvYcCUmEV+hgj1aF6XXzqB3NCpTXYGCU5GqAK6z4AXHEusSL1IEMXGfrj2XVihWslS0qjJgpZQOKNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTJWTgz5GYdA6Z9OrwxtWz/+m3naJz8dbPzzj4JsY99kwb396
	+qc4FzBasAZKGWxCDYh9KWDZPF/YkDWViRvj6nhOQ4jphccHo9lZPQ4DAegxdYpyalFlJz1oj9h
	ULOgjGQG8vMvOdQPw9fgQ7L2ZTc2u2MPFnBoTvWm+H/h0y6bMROJaAyASf+SPLZggp31CB/hePl
	hcZm8bNI7Cp9OrUqHaLPc/EwlPTS50
X-Received: by 2002:a17:906:da8e:b0:a99:dde6:9f42 with SMTP id a640c23a62f3a-a9aad21af33mr128246366b.47.1729580506020;
        Tue, 22 Oct 2024 00:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF48dTbEXXwlQOnxpmBcZNvJ7jilskfb2bse15+iV9DXl3KGAy+eoyKjHGVMQ3ujLlag50Oz5EOdiAnJTE+l8I=
X-Received: by 2002:a17:906:da8e:b0:a99:dde6:9f42 with SMTP id
 a640c23a62f3a-a9aad21af33mr128243666b.47.1729580505606; Tue, 22 Oct 2024
 00:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731071406.1054655-1-lulu@redhat.com> <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
 <CACLfguXqdBDXy7C=1JLJkvABHSF+vJwfZf6LTHaC6PZTReaGUg@mail.gmail.com>
In-Reply-To: <CACLfguXqdBDXy7C=1JLJkvABHSF+vJwfZf6LTHaC6PZTReaGUg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 22 Oct 2024 15:01:07 +0800
Message-ID: <CACLfguVZg7AAShfqH=HWsWwSU6p6t3UUyTD+EaA4z5Hi9JG=RQ@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa: Add support for setting the MAC address and MTU
 in vDPA tool.
To: David Ahern <dsahern@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 09:01, Cindy Lu <lulu@redhat.com> wrote:
>
> On Sun, 4 Aug 2024 at 23:32, David Ahern <dsahern@gmail.com> wrote:
> >
> > On 7/31/24 1:14 AM, Cindy Lu wrote:
> > > Add a new function in vDPA tool to support set MAC address and MTU.
> > > Currently, the kernel only supports setting the MAC address. MTU support
> > > will be added to the kernel later.
> > >
> > > Update the man page to include usage for setting the MAC address. Usage
> > > for setting the MTU will be added after the kernel supports MTU setting.
> > >
> >
> > What's the status of the kernel patch? I do not see
> > VDPA_CMD_DEV_ATTR_SET in net-next for 6.11.
> >
> hi David
> The kernel patch has received ACK, but it hasn't been merged yet.
>
> https://lore.kernel.org/netdev/20240731031653.1047692-1-lulu@redhat.com/T/
> thanks
> cindy

Hi All
ping for this patch
The kernel part of this tool was merged upstream in following commit
commit 0181f8c809d6116a8347d8beb25a8c35ed22f7d7
Merge: 11a299a7933e efcd71af38be
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 26 08:43:17 2024 -0700

Would you help review this patch?
Thanks,
Cindy


