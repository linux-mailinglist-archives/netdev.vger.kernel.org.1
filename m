Return-Path: <netdev+bounces-195016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0DACD7A7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D311B1896D21
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670E262FF3;
	Wed,  4 Jun 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By1ioEOv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609AA262FC1
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016906; cv=none; b=dHiej7axVYDYxNQeUw7/za0Zgy3nZgVPIXDzZdn+08J9ScvGEGrO2cb1Xbx2o7yWDrl9uzrUXFXYiyCIdKbmsDVddGkJG6ju0w4dNCzGl3/u5WFUfWIcy5Oyp2ks3Lq4V57yceD51Zce9cK+1FWkXZemd4hP/7HZu1FuYoEIX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016906; c=relaxed/simple;
	bh=4TyRBG1G4EzdBNunppuanZ43NQgPH8fGRCpZBDbYUus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXsTTQCegdSQkG0me08xa4yiv9gG/BsuU1bQdTepH8zKKj5y5HzdJmcUVtR/rrz95KCSVgmE9Gr7Kof+wy+GD9nsk/I5NbP+nCPcrm0ZHX9zArj02yOtsRQRWMVKftdJHsIR4ULxav12nuZ53n/9vdqTtxNKnU1VSJuuaE3/w0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=By1ioEOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749016902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuRWRJUNtoA1IwLH7xLOPSpkGMVdWFOSz6YPLpJ70Q8=;
	b=By1ioEOv1BqrbfEFVtHZglQknrGKWxxW+HrgkaflJ8rEmim7pBjyATsmwI1XCkyV0FB2Xb
	tXocnEIolIfjJWRH1NdIgSZpF94Q8J1F/ZnGs/8rosxWjxG3+/hWGhOj8yrKfNRKXWOien
	NN/2HKFzfQq7+wHeTCPoDgwhxzheP0I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-v5e27SSdNTCd1qBQ0_9i0A-1; Wed, 04 Jun 2025 02:01:37 -0400
X-MC-Unique: v5e27SSdNTCd1qBQ0_9i0A-1
X-Mimecast-MFC-AGG-ID: v5e27SSdNTCd1qBQ0_9i0A_1749016896
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad5697c4537so61170966b.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 23:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749016896; x=1749621696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuRWRJUNtoA1IwLH7xLOPSpkGMVdWFOSz6YPLpJ70Q8=;
        b=symTDHe01LHFgioeazLxMFbxQDcX/W+mRKMCfKzmJjUFUc+3hX/2pBZbgbItY8Bd2i
         HfQK9p7KKQy2mkfnNAQ06iMouEg/v3o2PATn3Ci85a53CiJ/MMxwPQ2cJAVUF97LIGG7
         mKBIVa3j4Sa660R9BJZD6EcRpKcjXn0wtAn+wX8gc/T2B11pXkh4dXgKJGyh8qOv45x7
         aqm4cWcSHPiZwt/3lqu6QcsrvQJBjj/sIRmP+YF/4/DDqs7eQFjdeNQnuQ512wzxQTgh
         uV+9hhND9NpQ8N0AV3aUM82VjRyiEZbenXxBFARJLakqLdqYbHh1F7l0kXeoG9d4Z8GT
         t38Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfkCbIexdUIZnSz4B5OnXyyxK9QjXIu79fwhLxWCDzc/D9l9GD+vGei1yDeUCWMvI7puL01+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaBCCGLp4CDQewzMZCQ+yCIQZz4gdwWDhxqfJlvNB48lccQJK
	sHKjlDYm+vw2epYWkfZawL/nfbr+dxRkee9wi1ZRfrkRyYks9OCLqyZ35iFzuJbBUQesiYeSQb1
	w5C9r4i+csz8tXd2jv01qBabMWU7K803jq0c6tChK7zcU2jugnTwB+PVHYu6TN9XX/rRh70AMKT
	vLEBhUOoPlZN2oQ9BOlK7YTDNUBAwe7hM9
X-Gm-Gg: ASbGncv3MA+VSogBBG//I5xAU3Grm1VLVEXShvcsHVrb1LOl+2t+ItQoY5W3raWZDEF
	SVyEDLeBgkp8HcHys4FrTX21yzKAdSQK/cT6FLPzmGTh7n8LbXwN4fFWhkwiwq16e10bbaA==
X-Received: by 2002:a17:907:3e27:b0:ad8:932e:77c9 with SMTP id a640c23a62f3a-addf6e5309dmr151677966b.3.1749016895881;
        Tue, 03 Jun 2025 23:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq7zshd+Mlb0ExzQc1p+OYd8O3naYB2lELgamGzeWirUG3oP6mxKyenZR4eIlwQzxmUZ2DblEvLugnFUc5+nI=
X-Received: by 2002:a17:907:3e27:b0:ad8:932e:77c9 with SMTP id
 a640c23a62f3a-addf6e5309dmr151674666b.3.1749016895432; Tue, 03 Jun 2025
 23:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com>
In-Reply-To: <20250531095800.160043-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 4 Jun 2025 14:00:57 +0800
X-Gm-Features: AX0GCFudKt31CUN4yXL1ybV6SffNxLvQTIurYx8hfUPGvIKESpW4_6rDnGimkiw
Message-ID: <CAPpAL=w24Wwq8Qa9uQr8OQqdg8vMiK0FSOUGdCHAvB0O2B_T7Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 0/3] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, May 31, 2025 at 5:58=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
>
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (3):
>   vhost: Add a new modparam to allow userspace select kthread
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: Add new UAPI to select kthread mode and KConfig to enable this
>     IOCTL
>
>  drivers/vhost/Kconfig      |  13 +++
>  drivers/vhost/vhost.c      | 223 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  16 +++
>  4 files changed, 255 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>


