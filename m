Return-Path: <netdev+bounces-150618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89019EAF80
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46971887CD5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB82210F5E;
	Tue, 10 Dec 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWaxPpjE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4D210F53
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829007; cv=none; b=JLk9rFD66K2dACVoYoxDdO9c4R5lo1FYUnXYRMmMeVglhRUfBWkYVESp3iYDgt/RUHUgwbcQBtTnw3SyQMcvXd6UG2TRtu32anea9rEXAYfvDTCbAyObpeAJJz014+jdMZTNz5qEjbgZu7hELIsSwJlkKuJv5D7lhfaSASy7bxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829007; c=relaxed/simple;
	bh=FMEKrToJmfBes2IkIWI0FUbZrDzX9gRWI0fGcz6poD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R86A8A5JEKGCnAFnptDswcpSv7RMjSOM1WfTlBRPf7qpEPlIQgj4Wd1oKE3GxmjtC7MRPXoQg/cLM5xQz+xKHg1X8uNBINnjsiy8TiJi1X7TuUBARFr7uxZwb6167UnY9yndRD5h3Chej3O3QHkLfkEgFjj92vmrQ3EF2sNqDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWaxPpjE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
	b=KWaxPpjEaJ5TNziZqxawZ4e6YalXPyOL3uJbtDOseAxmoDel0QH26sTCnEgDPkSIU/z9AC
	b5WfigAmZbmdSoNPIB3YOwlfhEQXflNGyFzerD6fISTpd3mTbewisvqRQU5g0aoFXhBFE2
	X2Z/DiAMUqho7ehA4AFrCW47y0SlYQs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-exLcCdu9NpGaP_HsoXBMuA-1; Tue, 10 Dec 2024 06:10:02 -0500
X-MC-Unique: exLcCdu9NpGaP_HsoXBMuA-1
X-Mimecast-MFC-AGG-ID: exLcCdu9NpGaP_HsoXBMuA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3eae7a9b8so2614441a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829002; x=1734433802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
        b=Akb8SLNV53y4e+zBYpGaBU3WmtJoWZNibkBNlrxwkMjKvftN5px1YxcsqSSuam9ATW
         f6HAKgE6TocnDYTi47UwLSyrAayHHPma4dweSwjzL7ymB4LDzYoEZOM9q/J3Ax1CMNDM
         S8xHuIELAeJGY8B3C4Sg8JlqUyl6ViCxtPbYGc4AhLrxuXAw7hu6qQxyXEOkeaU/Neth
         j/xhZbcsrnZ+5hyOIwZsCfAmTFE50EBc5Xvf/BiMpSkaye/nFb4avgTuR+UfR+cFoDNr
         7YFRMNTyRHu+IreGB6b+ZGCBH3XtAXI9d3gahfvNZl/EoSfR0Uqrxr4xKhz/Cr4J8HJs
         axNw==
X-Forwarded-Encrypted: i=1; AJvYcCW6WnNA/LtcFb3xL2e7P5cvNF/llAI0XgOQF5IoVSVNi07bGcApOBE022aeV3yXi52LAc50i+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIcsDG4V1BhLFJRiHdQumq7Deuo+lTaPgCgyQHn+1ustmbOr0
	cIv0CcG7PKLKjGyXrOmxm11aGKK//aB6kxMNwIyxNNLnYjFM80Ttq1qcaDJ7ZYe6lbavIk/6sU8
	6lMYz26YjSrh0Rv/kldS74ZKxpGpfmTu0ipZ68Aa49Gq9cIM3p3a4h+KvAYLZWKgFpiEPQztO/a
	f+vuGzMShzWgcEwqfa2gFZFCi5ZaC9
X-Gm-Gg: ASbGncsUUqeMPWTZpxBcPruFdiQnJkoQAi+Q/hLDC55LLBWPq6Mznq+2tOMxHcn46R7
	2Vivv9Xy2HH0EEB29xEcglY6W3yyTAIUX+ub8
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id 4fb4d7f45d1cf-5d41862e26fmr4233959a12.31.1733829001638;
        Tue, 10 Dec 2024 03:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaVJmbf9FsFzQlv76BIkK6pJvh123nB+XTw7CeGSQecbDCarRu6td/3KUmrwW2b7PdOi/34sbWrQxNNyd1r0o=
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d41862e26fmr4233925a12.31.1733829001213; Tue, 10 Dec 2024
 03:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 10 Dec 2024 19:09:24 +0800
Message-ID: <CAPpAL=zqL9qmaa=4XW8fu-nMgbh+LkDc1OUCfYOuYv7vVcp7rA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> The vhost now use vhost_task and workers working as a child of the owner =
thread,
> which aligns with containerization principles. However, this change has c=
aused
> confusion for some legacy userspace applications.
> Therefore, we are reintroducing support for the kthread API.
>
> In this patch, we introduce a module_param that allows users to select th=
e
> operating mode. Additionally, a new UAPI is implemented to enable
> userspace applications to set their desired mode
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
> Tested with QEMU.
>
> Cindy Lu (9):
>   vhost: Add a new parameter to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_worker_destroy()
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
>   vhost: Expose the modparam inherit_owner_default
>
>  drivers/vhost/scsi.c       |   5 +
>  drivers/vhost/vhost.c      | 194 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |   7 ++
>  include/uapi/linux/vhost.h |   2 +
>  4 files changed, 193 insertions(+), 15 deletions(-)
>
> --
> 2.45.0
>
>


