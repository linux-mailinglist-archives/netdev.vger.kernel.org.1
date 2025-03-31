Return-Path: <netdev+bounces-178284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F039A7654A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E415B3AA05A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A31E2614;
	Mon, 31 Mar 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG5AaPPK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122361E378C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422425; cv=none; b=WarGmlP3U3OqoKaL/UMXOqZNseampyBNXhcuLdLL/OdQ3/4XjEt9/jWvUywKZQDroD1r2H448miAgBMeOAPkLe7IYPlq34RzgOVdgyOjDcmx5NoOnvOfUwT43m1G7naCLJeXDfF80AS7uQ5C4Xp58+QyI+jfZXGbYrIGrEzcDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422425; c=relaxed/simple;
	bh=76SU+zIo7WlCNaXWUl6aelYPfKu7lO0vioy9H+xSEnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjNd87fy8oEwAT9BmlZab2Zk3ax1KziDesAFa2Xs1iNBzez+Q0eJBklLM46N5gHHe7DFy081w5z0lti4B6ouJZaIquQF6pAJQBI2MV14Iwsqj+XgdjL9+9irMnF5VT+5q5mcx6Z0Ht9Q9SkqFSgwGXGbPwTNaYscfdats87tYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG5AaPPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743422421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SALfqHpaVZ7H1/T2YDaQ+8Ub/OE8/ksE1OnbpJljKQE=;
	b=JG5AaPPKDjc7CYX84He2u2FWsD1541T+t6JH0pG0Nkr4JsfO5HVGBFAAhYb9U/nj3wwH0Y
	RTlsCVLEnudK+W19A7thHedO0+0ZT+me6nfbgFbVLpqoHEa4RQqLuhneqYSyHdJ8kYsO8t
	gWodskqR/9SN6RgM7l1zd/2FOYogb8Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-vM0OLplUP2ySNhvCp32tjg-1; Mon, 31 Mar 2025 08:00:16 -0400
X-MC-Unique: vM0OLplUP2ySNhvCp32tjg-1
X-Mimecast-MFC-AGG-ID: vM0OLplUP2ySNhvCp32tjg_1743422415
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac31adc55e4so369216666b.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743422414; x=1744027214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SALfqHpaVZ7H1/T2YDaQ+8Ub/OE8/ksE1OnbpJljKQE=;
        b=PjFd14VCx7rzLdAaIYBxQIXvlaBR+ddXjrlcRa2QZDIstroZcmlyA1K5IAzwzy44vD
         ZxpfvqLXnkvmI6f8a32M1NtWDBSx7nPFniiC1JFwIFcpEYBZTCMz71SWFvUij7p2YuBy
         aSkD770K2b8qCD+VMUcHSOIjqIpCH20MP5BoaG7Fzs9VJ7SUd4R2R6EEzdHeAuoPXHVv
         G07EC+v87NPXLzke1v/ZZh0e2P6kiB10QrlKsRcr2v+gNw4cFvACXz0gp+fX6FBRjdHZ
         srp5zlVGOuhscKubOqSU8BMrYHeiW7jDMuVYfFpC/qb0XU+Opu80jIHBItf/HNgYEY2t
         kN4g==
X-Forwarded-Encrypted: i=1; AJvYcCWGArHwFdjoanC6OAnvLZBA91r2szv1LTDDbs1fLj38jitPZ/gpGI/bdvw8ywYu8WwUzU3iXIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AS6H1mlBJCDAWFHVFykQOFb5zD4eM7BWXrfBFVoPM8bjUN5S
	tTQgsIA2LX4+7GItP4l6YYRAEjfS0JcXsRfyDVaRuWdmDz/5nOfj3u2gTG8nXsI6ReteFvXMaLH
	ZzGFiCqtVwcSqrN6Rdk/HyTDq273wN7+vlwokBJDJbrt0OKPtC9nLnogmUBgTr/hq4Kfo3+rQcQ
	72rcipDJyxJUH4x3OOR+kCnhU+UvnScZ0WwtEx8w2t1w==
X-Gm-Gg: ASbGncvFVdys3c8loq50GtLzdR5hE510A7Nc4qAycyLBUE02sDno9QZi6K5E+mfiA+D
	aXH5wt3Cx5Na+ReSu5i+O1r8gQSbFO+FWpKgC/mJmvzohe+vDw/yl5+6Ah20XZhkndIAPhVJnng
	==
X-Received: by 2002:a17:907:a08a:b0:ac3:cff:80f1 with SMTP id a640c23a62f3a-ac738c880d3mr758638366b.54.1743422414489;
        Mon, 31 Mar 2025 05:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnA3ED+fmlUHGPDP9zSXTFcjlj2+EA7N/YnNwtisbC+ekVhCoZq1nyT+pnlJz/9pdqBVMe0AoZpt/YKM5Oao=
X-Received: by 2002:a17:907:a08a:b0:ac3:cff:80f1 with SMTP id
 a640c23a62f3a-ac738c880d3mr758635266b.54.1743422414079; Mon, 31 Mar 2025
 05:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 19:59:37 +0800
X-Gm-Features: AQ5f1JroAFl0j8Y8E1rVmceWhY1UAp8ypP7a0k97xGC3a_KBzP4oWFz8KEo9czA
Message-ID: <CAPpAL=x00fw7qV3GdOCQPZcry-VyQFFUq1NXu7uOH7zVmESNqA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of v8 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Mar 28, 2025 at 6:04=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (8):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Introduce vhost_worker_ops in vhost_worker
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: uapi to control task mode (owner vs kthread)
>   vhost: Add check for inherit_owner status
>   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
>
>  drivers/vhost/Kconfig      |  15 +++
>  drivers/vhost/vhost.c      | 219 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  16 +++
>  4 files changed, 252 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>


