Return-Path: <netdev+bounces-209205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4EB0E9FF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9162C1C87C3E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE4245033;
	Wed, 23 Jul 2025 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+NUClb4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EE82C60
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247698; cv=none; b=OMtPon/CI7rtDYHd9H/aODQIwtWliRG+sW1FjtcdOAx9CTteEQjMRkiyKg4HZkJ33BfeDHB4cTfqo+ZL/tM4xhQz8rPcGqu1CFzi+F/N0t3cicTXX+Vg0Zg7o4AY0EmS55E+X9OIuSoqbQ9sl6Bvw5zXBuFV8FuVGll/vn3TWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247698; c=relaxed/simple;
	bh=1j3ys/TfTQ3XwfhTlxdRtJ7pOP+9pIYtXRnfNIEvgew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw+ZwuY8MBx/akCrAvqXJzrSpq0cXlk6jvc2ntr3pDlcfRg2K0/dOToQlRuo6QOxWBwGkHwZ3mDmIcMQbJdcUJVMVsMPeXantCyKrzQuKnKLSkHSMHlm4NJzRzYhxjSXptUlaP1lQpQQM0AwtNB43d4HFsb66R5NpyiepgMx6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+NUClb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753247694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1j3ys/TfTQ3XwfhTlxdRtJ7pOP+9pIYtXRnfNIEvgew=;
	b=S+NUClb4we2Jau3xIEN+DUJob0Zu+g/Wh34hqBonrQCWHdpIpX4GIa1ev7amAbG5wt+w86
	Ud/H3S/z5r+BewgRLwO8Fy3bBTT3ihsXAE4IP2JsMHeyC62GD34x/4XghuF8yPQ5XCVCaX
	1gRIZgep/mSX1sRUzuMzrdck90gJkmk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-8il8UpJ0OxyIGTKzkEmYbg-1; Wed, 23 Jul 2025 01:14:52 -0400
X-MC-Unique: 8il8UpJ0OxyIGTKzkEmYbg-1
X-Mimecast-MFC-AGG-ID: 8il8UpJ0OxyIGTKzkEmYbg_1753247691
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b362d101243so4798813a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753247691; x=1753852491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j3ys/TfTQ3XwfhTlxdRtJ7pOP+9pIYtXRnfNIEvgew=;
        b=Sk2mV5TBdeVGoGFb83NrDI9My+PsZpDtRJco81WL7MTT4OBUacFHXI1VYL/YVAQmEx
         ZGAXN+10MTU8s65K7deWOsGNQ9I6HAvdDkhxTUDZv2riW8BPRLJsepaeWKdFFgDmno4R
         mhvpUiy7Aj0F21T2M4VezciS5qVx8e6j612sPy95cggeysCdgD6vsvtgZ2MLo1cPQjCM
         JcFTgPsjEUVf0AbAuKPQeFz5O5DEyTLYewWg0pZWEntThZVHnvnJ4tRtTA4FwsgtOBks
         7t1d0mGw8ZkE/iNLXwFD8WAtg1Fv3QBwNmIhosjYoEezGwDehdI/IUxtfminUTEUexjK
         YuaA==
X-Forwarded-Encrypted: i=1; AJvYcCUbJ6PceD5a4FnJlydSvgeq98c5FHM/S3JGLjL2u6jUDkXJ7zI8NIRfchkyX+3fQOJgFy+Qwh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mL8kTklDb940m2FAxFGj7agaqQ9GqltvvFBmEN0JMKWdtEOv
	CWDwn1RXxRA6BuHDfcQ1Crgdm7pmhA5RgoEt6vGMOxkxkRM6qNCK3Lq4sHjuwTYc44OLDEDUw1E
	G+PqClJcl1MHccX2bn42BpBm4GGMURMEraluQkNQjlkplt6OmAYj2jJTlFu89n+oxBKk1qPRnKG
	qKyfEKffMj+O29e6CYmODK7kYulmGEhnDO
X-Gm-Gg: ASbGnctcSQYi6rLyEP0OcQKcWh6ctYfxYypNfSSn4xC7czMZ7zpefbrLuWtcPMKntNS
	55nC3n5H5cU1ec+05SAzMPXNzlXgOdDsv6bLV7kts9Sq3Go36R50I2JO8HmjNXLkM9Fc939wE6y
	eiLKnCAfYBoxEJ7munBGc=
X-Received: by 2002:a17:90b:2b43:b0:313:db0b:75d7 with SMTP id 98e67ed59e1d1-31e5082ce6fmr2502733a91.27.1753247691101;
        Tue, 22 Jul 2025 22:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY03FgvneZWmnr2443xQcflPqznIgEh5gvlB+LqFUVqMIGx1+PcaVaEWxNvNKGoJitX4pOyGgWZhGCpHvSsbA=
X-Received: by 2002:a17:90b:2b43:b0:313:db0b:75d7 with SMTP id
 98e67ed59e1d1-31e5082ce6fmr2502717a91.27.1753247690659; Tue, 22 Jul 2025
 22:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com> <20250722145524.7ae61342@kernel.org>
In-Reply-To: <20250722145524.7ae61342@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:14:38 +0800
X-Gm-Features: Ac12FXwEPeIcADmNrJKp2DSlJIlyR9Btt7edKHxnnXooUI2iQeqPJxqU3nuJS3I
Message-ID: <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
Subject: Re: virtio_close() stuck on napi_disable_locked()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Zigit Zo <zuozhijie@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
> > Hi,
> >
> > The NIPA CI is reporting some hung-up in the stats.py test caused by th=
e
> > virtio_net driver stuck at close time.
> >
> > A sample splat is available here:
> >
> > https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stat=
s-py/stderr
> >
> > AFAICS the issue happens only on debug builds.
> >
> > I'm wild guessing to something similar to the the issue addressed by
> > commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
> > but I could not spot anything obvious.
> >
> > Could you please have a look?
>
> It only hits in around 1 in 5 runs.

I tried to reproduce this locally but failed. Where can I see the qemu
command line for the VM?

> Likely some pre-existing race, but
> it started popping up for us when be5dcaed694e ("virtio-net: fix
> recursived rtnl_lock() during probe()") was merged.

Probably but I didn't see a direct connection with that commit. It
looks like the root cause is the deadloop of napi_disable() for some
reason as Paolo said.

> It never hit before.
> If we can't find a quick fix I think we should revert be5dcaed694e for
> now, so that it doesn't end up regressing 6.16 final.
>

Thanks


