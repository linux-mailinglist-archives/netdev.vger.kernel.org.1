Return-Path: <netdev+bounces-207203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB761B0637D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6375B7B48D6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49A24A078;
	Tue, 15 Jul 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLQl/tvM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A9231845
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594777; cv=none; b=rWCtGTFPEwrBs8ZfZhdXG3Bd88W/XIt5DwEhsp8yr65DKqe3AJlspecXRxv1T7km6OY90u6tatLBDtwYxw+vZlS4wWlp82/MGbdVKOdYXz+M03xGF3I7BDwpl4rw3Euem30SrHE5dArtsJ8AZIbm1dgPVZPTI+xv35EpLnqYHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594777; c=relaxed/simple;
	bh=uDfrJF/drcy35q3gMp74bx+UGibPNfQDLes/+Jl9AVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FodFYVGDus41PPxG7UV42UJNejTDxKtiYA4BqJBt3JT9FfAye+EDLv2PIuyrg44xHndgVYJpvay/auCk6UIuAb09X3YLawJSuy3AJsrz3TYRxMO/ChdqyXjwo/f7A1Zg5ypMPnPD4pwaGMrGwMzfQqXxC7L/BSm3oVGJnl/065Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLQl/tvM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
	b=MLQl/tvMlxZWfL6Z6F1MsFxOyX3n40nZf3w7F7faPfSgHEJe0Y0Ay/zT/I2Kz14boV050h
	oM9/C29AzxNuODAuhN7ncwK5AoAsw4JfycWzRbFViHgihoaURkqf0Lr8VALw/nbcF58CG0
	2Itk5x8pTz1NE/buO3SNsKqFn1r5wNM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-hrJTRUKJPg2q_GijFFpx8Q-1; Tue, 15 Jul 2025 11:52:52 -0400
X-MC-Unique: hrJTRUKJPg2q_GijFFpx8Q-1
X-Mimecast-MFC-AGG-ID: hrJTRUKJPg2q_GijFFpx8Q_1752594771
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae6d660903aso519090866b.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594771; x=1753199571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
        b=tiDZnK/Yaxn79i66ej3mziyHbE90MlqZzUcpaqeB/QBwbyNTX+EkEcW1ufLsDX1l1b
         m/aIyaMNabGHbEqPmbgjy5NpWmIukav35zw/yGEh0uXUhM4oVLP6nyvH+fqId2utngZB
         YBR+iQrOBiRhGjcJ+GunyTQshY/fb7tkyMPrnbr4ao7R4xrptxGVbXs7+igD5gch4pVP
         hRFI7xYnHrtSICFt0dORQ7kFJWd6IJr7U7rDQYKYnvKB9wuK3lRva3KrzclGTcWolW43
         nQOAbvvbScsya2rBl80wg1UUYBe79qHhRPl+Kef/zBxNN8dOCZrX9fGUIjNSNOTaL8qG
         CLpw==
X-Forwarded-Encrypted: i=1; AJvYcCWclJAgTFAxEQpFw/D29ezKliF1pEHFikecRzW7tyq0BprkPwNwOyLjrJMRu6xMdV8UufVsyvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQco9NWSUO+RradJW9rgB9at7GJjgkr0rRQ+6sCFxBDfk3rFk4
	E2LLPPKthuq5XDpu15W56HFs5/mUJOYUGqzw+/on/q1GFCLrEZjoRQvRXBQXggzDw0yi30iQEZ5
	fmKwCV0ljzxn3XLsN9PIZbPat5sUaUn7mhTHaYBsHYzQTb3He3Kj/ji6Tc3H62LTIOcB6GBmiBK
	JUiE9ooxFpZJ3X8H2MYQb56g09otqqA0U1
X-Gm-Gg: ASbGnctmcSuLWPmXOlnPNKFmHxa6Nj6n4XwnELNV7M40OTZh7pO8OKUwkNSP+aQmDkz
	rT6/ErpfbGlB/IEiSi3QENfLd9t0jsL6eVpRVPlknNoxHYaVwqcwp/vyoJVFYD1+myD7nrqgXVx
	J5Z4H8+lO/VfvcPnHvk3OmGg==
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae6fbe3d07emr2002471166b.27.1752594771133;
        Tue, 15 Jul 2025 08:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUS6HiH3OZ7t7wywPZ+i8XtYq8L6TxhaGYbPlDaYTLcxgd1/uZaFKuIjLPtsvr7tm1eM8MCwXkgLfvRdsAGGY=
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ae6fbe3d07emr2002466666b.27.1752594770666; Tue, 15 Jul 2025
 08:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:52:12 +0800
X-Gm-Features: Ac12FXwfXi0jx38BKdlRwU2IFKU-jNFpCJwwxM4OKirTaJ-ZKXvGTV-e0aBSlEs
Message-ID: <CAPpAL=w8GQypO4gFv6vgO0YDNPLLQ-4JuEKyp9oHP8WiATWOmQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/1]vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Changelog v13:
>  1.enable the kconfig by default
>  2.Rebase on the latest kernel
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
>
>  drivers/vhost/Kconfig      |  18 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 295 insertions(+), 18 deletions(-)
>
> --
> 2.45.0
>
>


