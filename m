Return-Path: <netdev+bounces-154865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFFA00280
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F56C1883D17
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F52629C;
	Fri,  3 Jan 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIfE2/lH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96D1119A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869019; cv=none; b=XgTp/x4eiRfaOaAq75KUSGHKefTIccT3ccGHSxDKBt2Q5ArtiWyzrqgPDfCz8cDTCTEsoApLLTdyrK0x/5HaqZIP/1p0d+CH4AV1cKwAQyF5nU9k+qfJPBzcHJeGYqWnwCSwxv6HzNnnu3CUd22mdWkbTEq/hfqb7i55iKxbrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869019; c=relaxed/simple;
	bh=ugWlQcT2LvXutYN+EdP0XTdDZ2Af6oEJzyrnb6d7Lp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX/YKrY7Y/5iQXxiUGK2YDrZ4rYl1Qn194PwPIpUVQZX+PqoEqVFsRbjHioO9rdLFyKb9iyF6L/maTIHe/4NGn+O3k9xV52elBNTWFCGio94wbWSrQlT0JwA/yUC7gj05vY1qmd84Nb0KbhoBerQWPoqhzreXeb15t0+05Zlss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIfE2/lH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735869014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcP2qJh46eUcVs5AZUyl+IUjPfN/SLun1H/+PvBG35E=;
	b=iIfE2/lH6ZT9fSfMCM4PYOIW9t2lngvjkOReJhxR9Mv1BGzAEBLPsaW+4lX+xj78CcUJeL
	TPi7Fzyqv+VMaoTGJwy7OWb98yaDir8MOU8nRTJ92EpzAv5+lFGxR2y342e9Ez0wEANUMf
	hjgDH/xs8kwE1yI5UAbeD6dqfH51qJs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-qmssKPEDMhymUJH3-NCO9w-1; Thu, 02 Jan 2025 20:50:09 -0500
X-MC-Unique: qmssKPEDMhymUJH3-NCO9w-1
X-Mimecast-MFC-AGG-ID: qmssKPEDMhymUJH3-NCO9w
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3c284eba0so13024895a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 17:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869006; x=1736473806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcP2qJh46eUcVs5AZUyl+IUjPfN/SLun1H/+PvBG35E=;
        b=ZAPV+UU1y0MtA/vgLVT3UrPHMYrNUO9CjebbToFJedUmMJEMv2j0jST/ynmhQ1c2pR
         nyvhP/uAJdGRa4QJoeMeORs57yF9q+bJd2JKE4yDWpe71Znp56E1e7UJVHjQWSjLlkk6
         G1FaFuaWpgZzDV6OvxT4Lfj1aLpv+RipxCYc//pMaAeMDKgJYGXJFdXSJDCrOiNHpx/C
         aorj916p6sm4m28RmKKBbmGJBR3xHSDrvrr0iwSPkSd5fzTzxP7/+J4XraVCaQ7XNqb1
         03br9PO0HOLV0pwvrT8fV347RtnD9NsDn2S1VTl0YO7c9np4uheBkcf/6bFpmddZVfKZ
         vFtw==
X-Forwarded-Encrypted: i=1; AJvYcCVeCMeV7EJdl4a30s1+v0/VGm9TPEwkSJxirycHdRadoOoq8bTvhOruZkBemiDA185+Xj0yD7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeikvEQbh2llpUKVYIR35ptRJJJN5l2VqXNPmZeGzgY4myT/i
	sSfALnvoE2pf2vZPTkA55WDeD8EsI9bKRTner7Hfkj+KtTHQIjYWrWNHIV2GaD3wcDZ7fMfbqB5
	QNaqHhfnHzEwTG813b6HlhtxItUim+DV7Mgv8JBYYZR9bxKcd5goaeRUt7hsExNpIxTOc+U5hbW
	MOUj7rj6JPsDJBjuNfIxJ+JADu6KGr
X-Gm-Gg: ASbGncvoNZ5EUU2RwCDQowOI35B1mw7ZGLgTiEpa2fN/j8HL+Vfd4fIfK3vdVls9MJi
	kBmil2croAfGGug2sxzzZ7Nj/eqgr7wtQnuGeNuA=
X-Received: by 2002:a05:6402:430f:b0:5d1:2631:b88a with SMTP id 4fb4d7f45d1cf-5d81ddacf87mr33437953a12.17.1735869006459;
        Thu, 02 Jan 2025 17:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8gbSec5MrA3LDch29C5XkdV12IqVhzmcGZKBUwF2Ovv/WSVZhgrXSG3lcLmKAzES5YNxhp1Ov1bT+JGQANA0=
X-Received: by 2002:a05:6402:430f:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5d81ddacf87mr33437939a12.17.1735869006114; Thu, 02 Jan 2025
 17:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 3 Jan 2025 09:49:29 +0800
Message-ID: <CAPpAL=xFoJF1NiD3vbD56R+2voNOA=1m_un6KNEB9JjUPvAkZw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series v5 with virtio-net regression tests, everything works =
fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Mon, Dec 30, 2024 at 8:46=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add worker related functions to support kthread
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
>
>  drivers/vhost/scsi.c       |   8 ++
>  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |   4 +
>  include/uapi/linux/vhost.h |  19 ++++
>  4 files changed, 192 insertions(+), 17 deletions(-)
>
> --
> 2.45.0
>
>


