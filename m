Return-Path: <netdev+bounces-86401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E789E9BE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C952285A07
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2B19BA6;
	Wed, 10 Apr 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xql4mdAt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D38F44
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726963; cv=none; b=N8FHoY9BLNmSZIgMSpe77qrIQ11OYWjqzZN+0nBD8wHlrx1KzL/FlsOAggTBGygIeWxGbyP6pcdzLuFnxIw72pIOtrtKZ6y555soks1JcTBJ4fLasZ1rLh5M9TSr70z1pv8wMiup138MFElixK/kaEloJ10r/0FBykE18aBCrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726963; c=relaxed/simple;
	bh=Garsb0yrb09cyxnrIqAQEaABu4EXVm1wLQ8zJlWQFy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k4dk8adrY6SrEj2IFnYjEyUBU9y6aRJGm/03dpfWzU0hMHzB6SRKYnY6dNQJ+d9Blb7/57wbik0pMtXjRRFcULr3epwtlmTXj4J3JQGL3PgejhY1TZEirD804jGIuZB2PB8Rxuzvq9fMwWamV7fRGxUKvLRewNQ2/guAUDv8Hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xql4mdAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712726959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALjg/ntug4MBk1XtNMajyyKljj175m906YvGN0uC3zY=;
	b=Xql4mdAtwbksp+5q++cuZUU1PmsezbLmn8xXnX6RiRQlqaSgxWBJbzjlp51dUIROdtOmBv
	rWK2pSacXRkEezcjy9lQEvTDxJrGh3tj8B0yWUOAVD+J/9pqvDQLRUUSbhD9EJTfaoCs4K
	K1fDjPGGN+knMqp27NlVUoHhVFvUD4c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-92SJjxe-MDaABCwWgT-w9g-1; Wed, 10 Apr 2024 01:29:18 -0400
X-MC-Unique: 92SJjxe-MDaABCwWgT-w9g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b97efbb8so409130766b.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 22:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726957; x=1713331757;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALjg/ntug4MBk1XtNMajyyKljj175m906YvGN0uC3zY=;
        b=QIdOJdC8JTZRfPpjsZN8lYOAEdKC/lgMNZC/RoYDmkwbnEyl39edmptsEGIPPZaPjm
         MdutucoRARjJGEQlJV4O9ERigfKa8FmokpA18PveldxmwozzR6U0MZHh+9XRRBVofCRa
         midFvV7a23MacdA5qBbHlpm4gQEAV8H6nzKIOx7BXAkKtI01dqDV4hUdka6YbrITI/3A
         xf4pzuYebUm5YP8tyH4OREjDsUNaRnJjV4JFm1/chbYIdw+fhNSYewxB/YawxRn1pzvY
         PwtuXk75lSdwKqmKqWyTGFr8wGfuqkitTzrx5xOUPDiMiK+slpt7eM9GplEyQITrJqN+
         Wj9w==
X-Forwarded-Encrypted: i=1; AJvYcCWisWJU6DzGuB2MB6TFwDJBzwKdTi3lCiu+wHKFAoNPHkr5k+nTxfa+NU1uB0zLn+QW77BxsNuT/UAMVZ2gUlnFN20Tbcxf
X-Gm-Message-State: AOJu0Yya/AVFMU+aOvqUi3TedcCQoK4287olkpV6652AMLlYkCagBcoc
	Gv2xCDP/aebSae+ozJ72XJDP6GzMh6fNIDMWK/ndBly9jAK7fUskbqjaX7JbDi/gV9qJF04yVQW
	bxFFBJ/t2IWI7OUulmGEYcAfHMI7CtcUebk2oqgUpeji5XtjyGn4D+8azv8TFGRL9/EP6teuSy8
	zY4/KgeY1SAik5o8tNs8aYz+yaiLng
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr1381817ejq.19.1712726957039;
        Tue, 09 Apr 2024 22:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ro1TSS6P51R8HAGDNJrNtBNNdENLxX7oHAMyEfVHKQkSe40Ls/G0b/qqZdnwgw3ZDazI/7T4ggthUqEqHRk=
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id
 v25-20020a170906489900b00a51b49e473emr1381809ejq.19.1712726956864; Tue, 09
 Apr 2024 22:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410043450.416752-1-lulu@redhat.com>
In-Reply-To: <20240410043450.416752-1-lulu@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Apr 2024 13:28:39 +0800
Message-ID: <CACLfguW-o8ox5zmXdmr4Phm-8zSX3sWif8CtNDynW6kRH2fBoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] virtio-pci: Fix the crash that the vector was used
 after released
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, send to the wrong mail list, please ignore it

On Wed, Apr 10, 2024 at 12:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> During the booting process of the Vyatta image, the behavior of the
> called function in qemu is as follows:
>
> 1. vhost_net_stop() was triggered by guest image . This will call the fun=
ction
> virtio_pci_set_guest_notifiers() with assgin=3D false, and
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0
>
> 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTOR
>
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
> assgin=3D true, so the irqfd for vector 0 is still not "init" during this=
 process
>
> 4. The system continues to boot,set the vector back to 0, and msix_fire_v=
ector_notifier() was triggered
>  unmask the vector 0 and then met the crash
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
>
> To fix this, we need to call the function "kvm_virtio_pci_vector_use_one(=
)"
> when the vector changes back from VIRTIO_NO_VECTOR.
>
> The reason that we don't need to call kvm_virtio_pci_vector_release_one w=
hile the vector changes to
> VIRTIO_NO_VECTOR is this function will called in vhost_net_stop(),
> So this step will not lost during this process.
>
> Change from V1
> 1.add the check for if using irqfd
> 2.remove the check for bool recovery, irqfd's user is enough to check sta=
tus
>
> Cindy Lu (1):
>   virtio-pci: Fix the crash that the vector was used after released.
>
>  hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> --
> 2.43.0
>


