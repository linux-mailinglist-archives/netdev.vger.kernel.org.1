Return-Path: <netdev+bounces-200494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E7AE5A57
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0441B65A12
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF371F582C;
	Tue, 24 Jun 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzwVeLUb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DA1E260D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734413; cv=none; b=rH7avshbldAbQFrMFAZ5ndjlaoiRTV3OwvpEUXZczyBEoNfN9/x20eOy3OyTtIS3+zcdOYxPd5KY6sj3TjOWfCTDwylxcMYdjfaz9+VEet+0oxlqqQLcAtb1hyR+0xQ70+siA3Y2FyuDQKHFCCQVcis/lkmq4XDd9sh6of7sglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734413; c=relaxed/simple;
	bh=Hf4pTDvMYaPZ6cEcFPUxwJ3dIHRZ97tgnAGbROXDCAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBJMpVezhxOIidPHF0LwFxE8ybTlmEi/3rzkuYThQjy+X1J+PoS/FGd9FjMj91O5fLcz0ylIbK6E/AXVB6vhveJcilLpr7n1t/9oSpVv7asebQ0uGAt+9vyOq82qmBPDFRAYPQHyZ5kMYVJmqteRlwF8JrUIQi9NxT2cjFRHadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzwVeLUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750734409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx6sgmMMgVG7mUKi7Kr+wT8T087UyGpYIyapJqyqMJY=;
	b=AzwVeLUbqkLiaJ9NXZUuDn9efIsoWuYjjG3kR2ejyEuLkW/sHnd7mJLle4ZXBskImPlveZ
	WraQpTzvZehmyGQJ5Kmrr3qmjzL/ebw+uKhMMuShoyJekC4Bw4A7THcMmo3n5JiiJzz1ra
	rNYnfA97F+ND5TPA+IBX0Ks2EvkUVCY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-VTokKKBwPnS21otSE65uBw-1; Mon, 23 Jun 2025 23:06:43 -0400
X-MC-Unique: VTokKKBwPnS21otSE65uBw-1
X-Mimecast-MFC-AGG-ID: VTokKKBwPnS21otSE65uBw_1750734402
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50b9cso439259166b.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734402; x=1751339202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx6sgmMMgVG7mUKi7Kr+wT8T087UyGpYIyapJqyqMJY=;
        b=BIjy3fQnp/j2Ava5VsCo1BDKzzRIBaAvRrbb6FBJQfDRuvi9HUwowuUqZClKon4Jhi
         OnNufrdx3QdMF1NbA0xInt1YEn/LDN6+mrrY280LtntvjFvPTSgGVhjjigCzhSTl8fnC
         u+05QI4I6eOnfOby5n39KltfiMMC6XPlPUKh+kx5MyvIXX5GRKWrLwPO5+UHwpT6fYyG
         E8rb5vdkY6ugrWq3DkwvG8kpAYlWvXBcWKCLzqojW1E9KCkIpopen8Zu1D0VVwRMzsRB
         VcYMX3VnZkRVLdg33n3j71Dv5VV/k0kKUIReWl9TuzvJMXlSmu6N1S2B+IZxPDRYJYmx
         VY6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9LMK+V1lgBJ3Adkwva7KEZ7rqER6jh1ecWYnbnBAmuSzQyRb/4OcazNua26ggIf6YdwUAcJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcC6CHnbLTdoIF28qYB+JKmI7J8Vwg2W6igfh1lPdGTn0DM6Q
	FfCUwAOHd5cduU58T5JbHhEtSIhmNbPlUHV0yzELNt9/BbeY1uhVS0eSo+W513jNceb2ABgejaa
	TJmpwlkmzP8M1niAx3UJcvw3o6zwFaPfF/nwpgBy1h1dTsoSogjIPZukYr4aHoZJZcllJXu3ZE4
	cT0t9tL935PpghyUiWs+Vm25bWAu6B9bil
X-Gm-Gg: ASbGncvtrY9erb1iWpi6k8Rd2ifdIl94tehw25amV4KWx018O9R9rvmtnADQmJNgOZB
	2UaiiSEWgRwfi4JRMgSH/00IAzcPF08YCfjkK5XnqIWEKr3hXEDTH9UHWJVwC+PaSTog6lmuPwS
	4FUAYi
X-Received: by 2002:a17:907:7e82:b0:ade:44a6:4a46 with SMTP id a640c23a62f3a-ae0579646camr1357685666b.24.1750734401893;
        Mon, 23 Jun 2025 20:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCafKAXMcIHxmBhRwK7iS3XqemOJaV64Z8YrHbwgZKXjFKieDbmnmUfsC1RX0ZnO0TrS5tn9NXnxrmG/36Ll0=
X-Received: by 2002:a17:907:7e82:b0:ade:44a6:4a46 with SMTP id
 a640c23a62f3a-ae0579646camr1357684166b.24.1750734401547; Mon, 23 Jun 2025
 20:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com>
In-Reply-To: <20250616062922.682558-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 11:06:04 +0800
X-Gm-Features: Ac12FXxonylFwEpUfkwEJ5y5yjB5bxPnbHAzx0yEInUcezXskog1NQQnLXV30mQ
Message-ID: <CAPpAL=y8WxyFiXifBDARFZf+wcEO1r3MYPg09MKz8aMAXBFtSw@mail.gmail.com>
Subject: Re: [PATCH v12 0/1] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jun 16, 2025 at 2:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> the vhost now uses vhost_task and operates as a child of the
> owner thread. This aligns with containerization principles.
> However, this change has caused confusion for some legacy
> userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> In this series, a new UAPI is implemented to allow
> userspace applications to configure their thread mode.
>
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the defa=
ult value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the defa=
ult value is true.
>  2. Add a structure for task function; the worker will select a different=
 mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
>
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function po=
inter in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
>
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to vo=
id.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM=
_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner.
>
> Changelog v7:
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops an=
d add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>
> Changelog v8:
>  1. Rebased on the latest kernel
>  2. Address some other comments
>
> Changelog v9:
>  1. Rebased on the latest kernel.
>  2. Squashed patches 6=E2=80=917.
>  3. Squashed patches 2=E2=80=914.
>  4. Minor fixes in commit log
>
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
>
> Changelog v11:
>  1.make the module_param under Kconfig
>  2.Make minor fixes in the commit log.
>  3.change the name inherit_owner to fork_owner
>  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
>  5.Rebase on the latest kernel
>
> Changelog v12:
> 1.Squash all patches to 1.
> 2.Add define for task mode and kthread mode
> 3.Address some other comments
> 4.Rebase on the latest kernel
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
>
> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
>
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 294 insertions(+), 18 deletions(-)
>
> --
> 2.45.0
>
>


