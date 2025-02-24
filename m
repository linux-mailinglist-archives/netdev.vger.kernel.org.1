Return-Path: <netdev+bounces-169050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16EA42621
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083443A96F1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CA17C21C;
	Mon, 24 Feb 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6cF9bst"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538C1607B7
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410062; cv=none; b=eRY/Il0gLIBnfA4hpxECK4E0eZksfRCw9j1mOF+CV6uk4pm/b7D3gcS+A87i7oXp7WTE0ZzepLmJq6kr8/5GChuaAjhRDsw0MTkn8lPJlc01nu1aDmWp3yQk8mz7Jv+nUN/MhFFB95N8EdcGIgf11FSAp7tfkHtbG8HHLHrtbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410062; c=relaxed/simple;
	bh=60EDANKSZrkagzc6tUmC3fbQGdwCC6BeIMq8eEB8aPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAbEOB14Ckt4utqTprY1zUMWXrJItCMpSB7saLjnJaFNLoPB8p9Zt7HO16L2IlqxUQAihnLJ2PfT1QsSoTrQxfXM6NJBPDEIQRFBameslFhY8C/PKIKQtEDa3BB3ivpn7e9H9scn8ie51revdqVeY37onQ89XPbH8fuzekfjUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6cF9bst; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740410059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/OIVsN35hJS55OzGv2ukuVUaJw07LiZohQKwUs4joY=;
	b=M6cF9bstJvG6RaMTJRDUu+eO5pRUeVcDiFc7Se9VIpTjFrdW21FvvVXRO9MSDAXNtVsIyk
	vKA16S1eSnPEBFdo6apQtWp6FRqU4kXTtUfZEptJekTyBOY6LrZcSkLd5nC6l+kOdllDKF
	nQ2xG0AAGRH5KQiSWr0LCr+LG1DG5Gs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-vwn-tUyNNBCM3nnOftDnqA-1; Mon, 24 Feb 2025 10:14:17 -0500
X-MC-Unique: vwn-tUyNNBCM3nnOftDnqA-1
X-Mimecast-MFC-AGG-ID: vwn-tUyNNBCM3nnOftDnqA_1740410057
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e0a157ea0aso3773075a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 07:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410057; x=1741014857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/OIVsN35hJS55OzGv2ukuVUaJw07LiZohQKwUs4joY=;
        b=U8h+GVnoBIhP43wRcBwqShuh9xX58JH01IwoXlMafQQwPHnKtpYc8d9bS8UO6V1Abu
         of/m5YgmkWJIIm+FuNHfF81Wcgya+3v3ojYmkkrVfbrB0PgRcasMe+z35YAmdkZJJPac
         hbtg+vJoWsUKQiUAiISlm7fvBo1ciugYw51Ac7HoUZp73x38XIIjyzumKRpqr32WlZOK
         SK+MtStKAHfbO9r7XiqaWIfCXQFKxYxNEeHjugnS+zNBv6QsCpQ1WGkmCWaVdPWwc4cC
         f67e59G55OROejaiV31RQQoFq2fH4NCr6eOQ+KkWoFHLLnxu9aQQNAyG9NZxEc7cw3EU
         T0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCUzdDii6aDPxpoIU0wKv0uuldmpxKrTVY3mIP+Cpkq4wk0IP+7U/HjtuqsMoAi1GR1hxPgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwADxMMlK9wRqY/1L1S8TyGqM6rYIsmzUy2RAWRbEemM5yFkni
	VL9HhOl8dqLUXKC1dvRZ4Vy6laMy7DYgGkZpwWFiBorIlzhRr1hqKm8J/zo8vG4j2ggIVi2NsIg
	Ja6qewC4lopzDa5w2jDTrZUc/0MzyGRtjpNkImZiGVXkIFLrUZnJ0E//xDmSeUjjJYeiF6sfrgx
	DTaBEhO1pD/FX58yywQT9xEa4DnUEn
X-Gm-Gg: ASbGncscoJxmKjuUqlBQ+InfChfiD1jfvbScjCBibSrgTaoudyQm8pVbnPPIF9VHF5q
	lWzM3jBf+7t4YVLwcnghnxfUW23Nk64qnM7WZugqzCZ9tHlbYPQ8RFop6A+STbX+BiPFJn/qoIw
	==
X-Received: by 2002:a05:6402:42c7:b0:5e0:8840:5032 with SMTP id 4fb4d7f45d1cf-5e0a11ffb02mr17044075a12.3.1740410056598;
        Mon, 24 Feb 2025 07:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZmaNvoGvIZVGGdIwMY93Wp0Yy1Q6TK+nzx9SOVjoSDw+yiizvIm0X3myqUTvD89H31D2GF15UCAEoQ7Xt6T0=
X-Received: by 2002:a05:6402:42c7:b0:5e0:8840:5032 with SMTP id
 4fb4d7f45d1cf-5e0a11ffb02mr17044043a12.3.1740410056200; Mon, 24 Feb 2025
 07:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Feb 2025 23:13:38 +0800
X-Gm-Features: AWEUYZmPagj9OOZEPQeCs835JiaQmlpElW3pT8viTwfAfpqqaO40WKocPzM1el8
Message-ID: <CAPpAL=wQY3uknaDSiW_AJV4inkC5speMnvO0dGc3+NojK9TXng@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
>  5. reset the value of inherit_owner in vhost_dev_reset_owner
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: introduce worker ops to support multiple thread models
>   vhost: Add new UAPI to support change to task mode
>   vhost: Add check for inherit_owner status
>
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  13 +++
>  include/uapi/linux/vhost.h |  18 +++
>  3 files changed, 234 insertions(+), 24 deletions(-)
>
> --
> 2.45.0
>
>


