Return-Path: <netdev+bounces-197876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE38ADA208
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 16:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78BC16EFB0
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F226B2DA;
	Sun, 15 Jun 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWqZn2SQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ADD26B0BE
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749996497; cv=none; b=mLmZhYiVUjPixpiTH8rCwtNfR/zLTdBsYlr/YK0kw1ydpjW7Fd+wRa9KeVhdo21XAwBVQlpR6+PeEfb48m/NDDGiSjn15CBthe3f/HEkHK7MluqEurhE5HtCakvmQJVY5+fTW3c3hWE56puVZZ7l7aoLhNaKDaD6bXSF/Se5hfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749996497; c=relaxed/simple;
	bh=ZMkuY8utSlgX4E1TJgbabBifoab9L056uppzdIxIscI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3Hg/tUibyvZ/Vpy6tFPTpe1NaPoggSzHipM6yWNEMnY2WyP8Jo7T8Wul9XkGQCYOD7BV8MJDJiJPbaA/HJ4Ez/GlNFzkQoYXlyQkwlMTjKwQQexOwWl8ORw74ftMQ8ZtDRjO9jsRe5acc66bCkkL092HYAYSRQkq7ILXHw7O0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWqZn2SQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749996494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5F9RD1nifDmIVXEq5JzNevYty30dQQi6BLivh0kLXI=;
	b=CWqZn2SQIR34SYIFteQdYnhsxPPIDlXsr5SLRJ8d+azxWphjCj3d04WhumpmAO0BDzjnAL
	qZRnH3jirFOF1l2Cgn8o0UjDfdMSzYJXNYW+A3XcHKJzuWyh5y5BSY+aWw3HQQeEsoFRLz
	XNk5M2PROmBfeSakmzDEh7vMQegCUNs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-trU5YdxAPn-uI9kR5QPZMg-1; Sun, 15 Jun 2025 10:08:12 -0400
X-MC-Unique: trU5YdxAPn-uI9kR5QPZMg-1
X-Mimecast-MFC-AGG-ID: trU5YdxAPn-uI9kR5QPZMg_1749996492
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2a31f75so1256481585a.1
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749996492; x=1750601292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5F9RD1nifDmIVXEq5JzNevYty30dQQi6BLivh0kLXI=;
        b=kIXqvqbBmzZoOj+YxoOIOGRxPUGqy3In3uycHLsV1A3f3G6LgpP9um8dkMA87HGIpO
         UsviQKHhRUYMDB2fUAgXMh99wvcMwTT5oS2TvPIfTeCVK6m1tGrrbYlH6AqlC6QY8aV7
         1RpB1Y3dfpedCsEv4rQpewI99PnCy1PpD/9imf76+xMbST0uzLPKK1F88oSQGqbFA09g
         xSeJKC57U8IEDZ4LYmMI8oRO2iFIBOiXq5zsIHdI1C7sRlrElVEyLP/aftoKmtAzFLZG
         Xms8umS985opxUm5qITQAEcPmoTVVqI/bkqrcuSQqMboKRIEvJL3LgxQTEO8ZjsMGGmp
         LswA==
X-Forwarded-Encrypted: i=1; AJvYcCUhYQN2grkIKKzWw+Ly8J4SRmTFl92jfex66SFs6nPeyhPzjKnoNePiknpcojS4YaxkYhpup+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66ddjNoIxQ1nuqWKQUjcjv73UsCP8o1UQxwXxnuogByDQ2kbo
	5HOT4U19WGgFC5d1PAIZjrtzdBMQK8U6pkwPAtLqbNxOJT5hXDqzcqXaWY69jxa1o9OABDQDCgd
	xo74b3PewA1GAlRwM5U6GDm5B1/k5QEIHMbwAMoeJ3NUXk8g9b5OPEJq0WrS/9mAPbY7jx2GMpB
	UVZUe6cuY0mDROCvEXR0iXRA0/glRtk51i
X-Gm-Gg: ASbGncvJhErutSsxBboAlAyZ81ODLxlpT7yH/9D0qRNC2nU0e2mwX//MSc27u44tDbT
	CqZcjsl7d/poy9jRlNNG2Wq0XU4FXN+lYY1bVAec0w7lSJrakZOMnwTs9J10sDNMYOQEyqorHV5
	vs8nn5
X-Received: by 2002:a05:620a:424b:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7d3c6c04a42mr976767285a.4.1749996491838;
        Sun, 15 Jun 2025 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx0K+fxFSP4BqeDRz0y+o/8CQcKF4SvXSEuhhUCRwUNvz+In8dyZXZqILXiqwaViRTlSKW5mWNGj/EecyaUpU=
X-Received: by 2002:a05:620a:424b:b0:7c5:562d:ccf4 with SMTP id
 af79cd13be357-7d3c6c04a42mr976764285a.4.1749996491522; Sun, 15 Jun 2025
 07:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250612022012-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250612022012-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 15 Jun 2025 22:07:34 +0800
X-Gm-Features: AX0GCFswiCco_DauL--0e2ckwRlj1O7zbAgJChjHQQatloXrMYTxWULtZX6JYno
Message-ID: <CACLfguVOmz5dzvX+08X_0bBQP1iEoxjX=eh=id3mWGtjSodSrQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:20=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 09, 2025 at 03:33:06PM +0800, Cindy Lu wrote:
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
>
>
> > Changelog v2:
> >  1. Change the module_param's name to enforce_inherit_owner, and the de=
fault value is true.
> >  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> >
> > Changelog v3:
> >  1. Change the module_param's name to inherit_owner_default, and the de=
fault value is true.
> >  2. Add a structure for task function; the worker will select a differe=
nt mode based on the value inherit_owner.
> >  3. device will have their own inherit_owner in struct vhost_dev
> >  4. Address other comments
> >
> > Changelog v4:
> >  1. remove the module_param, only keep the UAPI
> >  2. remove the structure for task function; change to use the function =
pointer in vhost_worker
> >  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> >  4. Address other comments
> >
> > Changelog v5:
> >  1. Change wakeup and stop function pointers in struct vhost_worker to =
void.
> >  2. merging patches 4, 5, 6 in a single patch
> >  3. Fix spelling issues and address other comments.
> >
> > Changelog v6:
> >  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
> >  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FR=
OM_OWNER
> >  3. reuse the function __vhost_worker_flush
> >  4. use a ops sturct to support worker relates function
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner.
> >
> > Changelog v7:
> >  1. add a KConfig knob to disable legacy app support
> >  2. Split the changes into two patches to separately introduce the ops =
and add kthread support.
> >  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
> >  4. Rebased on the latest kernel
> >  5. Address other comments
> >
> > Changelog v8:
> >  1. Rebased on the latest kernel
> >  2. Address some other comments
> >
> > Changelog v9:
> >  1. Rebased on the latest kernel.
> >  2. Squashed patches 6=E2=80=917.
> >  3. Squashed patches 2=E2=80=914.
> >  4. Minor fixes in commit log
> >
> > Changelog v10:
> >  1.Add support for the module_param.
> >  2.Squash patches 3 and 4.
> >  3.Make minor fixes in the commit log.
> >  4.Fix the mismatched tabs in Kconfig.
> >  5.Rebase on the latest kernel.
> >
> > Changelog v11:
> >  1.make the module_param under Kconfig
> >  2.Make minor fixes in the commit log.
> >  3.change the name inherit_owner to fork_owner
> >  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
> >  5.Rebase on the latest kernel
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (3):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce kthread mode support in vhost
> >   vhost: Add configuration controls for vhost worker's mode
>
>
> All of this should be squashed in a single patch.
>
Sure will do
Thanks
cindy
> >
> >  drivers/vhost/Kconfig      |  17 +++
> >  drivers/vhost/vhost.c      | 234 ++++++++++++++++++++++++++++++++++---
> >  drivers/vhost/vhost.h      |  22 ++++
> >  include/uapi/linux/vhost.h |  25 ++++
> >  4 files changed, 280 insertions(+), 18 deletions(-)
> >
> > --
> > 2.45.0
>


