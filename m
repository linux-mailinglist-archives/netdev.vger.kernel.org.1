Return-Path: <netdev+bounces-171091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD87A4B726
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 05:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679F916B496
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 04:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989181ADC6C;
	Mon,  3 Mar 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlG3+Xi8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4E13C9D4
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975986; cv=none; b=OY8GMbPlKWn5YEAQOkq0/6tTqm/rREdR9PRn+S0Y1BOhZGCQClhLc+ptw5SpphKcnddWb8b0k6iDtxHvIGoRAfvJ9JPqqbPhJQ5TBgjFK00//Yt9YL1lnVnla7CqaXnRlAc62/I2QrAYBq+4un9/uhLYX3mHxEAJhqlk0jYLw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975986; c=relaxed/simple;
	bh=C5iL4+UgEfYtFgc0oU8GEsbInCv6xJrYflTOLd9mLlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1xmV6hiZu8LssxYaA97eA4E6LKPs6+3kfpIVzh/VRBWGL+eII4Vyw4EnETa9ozKVew+dtEj20cWqsC1d/fSeFNg8jN0xF++YtfNOJiX3UpygCySk5Lnqjsq1DvxNhJ43TP0Xs/d4NjKg6JUvJB+nlQ3LcQA5eqn7icpxFosDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlG3+Xi8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740975983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5dSGTpmLn97joWduARVp0cs22gFzxB4/mv/r4vqwy8=;
	b=VlG3+Xi8hAOEjAOfK+vHFDRjbs3Ypb1c8ZW3iO6b4qxQHWU2XQyb0wI1rK8jfA0d1k5F22
	6hYOcQfsomm5jS7Qq/iVfmmEHajwoR31P40ZxUXO53U2BKpQYtHRggRf6OJJuKeyQUBCGW
	/Fqn8ogIlrTMFfg34ypHdJgP7psnR3Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-_k9eMfwoNgSRpg_Zu9pzrQ-1; Sun, 02 Mar 2025 23:26:12 -0500
X-MC-Unique: _k9eMfwoNgSRpg_Zu9pzrQ-1
X-Mimecast-MFC-AGG-ID: _k9eMfwoNgSRpg_Zu9pzrQ_1740975971
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abba6d94ae4so18133766b.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 20:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740975971; x=1741580771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5dSGTpmLn97joWduARVp0cs22gFzxB4/mv/r4vqwy8=;
        b=SZf5nqFgArSdxstDuMSyHZ16FPMqzdmIxZVv1FDPExF0Vaan2r+5Gp3KQcqrDRRUBe
         SAlBvv6JLF5GbWeSfVDCSxtecHpsxMZC7NfH9SGAMcVX0mmdkQoeSHX23eOTlGsdOceQ
         zDRbWVh2yc1YlaEv6OTQE1QyeMHcEQ62U7XbHVWVQi1bG+PKMcr9VJfhCEiwo4AaCu3X
         qqB77EKejvTzaz/9cTuOqh8gxPbxj8SE7V9fR0MmLo0iOV11rPkOq1saJVWas29/RvpI
         5cpD29kPVoCX9YTCTC/GU5pAUW8HHg5lsCsxcvfQ3yq5HKP8Fv5pZoj2qdvTiNdQYzen
         KL0A==
X-Forwarded-Encrypted: i=1; AJvYcCWzfSuU3q1jS37BuqZWP95pQUewMRDwxDdreOWPEqLv6lLhlUOahudBrpnNhkflybiTnRuyBRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPgPsvj6N4pZ6BFwUOlYU7JtfQqXNTiJgbBnCJics21pDLWv9
	+VYh4pkALQA0sVQQvut5+HWOWezSt9cRzAaKsFJbwz7b2HlGuxPKSeEFkTotE7Ot4pwFI3kNP1L
	FiSdCu0ba188jAAt+NkxodESkAfSBN/q51MI2gtUMfZCyh3SQRtvek/HZxHsIZxj91o0StCer++
	IMy3k2FiC/nWldkPrFb9bekpo/LVv0
X-Gm-Gg: ASbGnct5t0BcsfaRbyEdYdORJCuAwDkh4uhsnKbgKCnvJg5jZ1Kqr7+WnoMb4r5fXxC
	xqIusyJscjIPqLbwgLxSK69HrkHfUFlw5J9kuflGLxSJKQoAsN0I/nvteyKLEjMWMlpUFcMPozQ
	==
X-Received: by 2002:a17:906:f587:b0:abf:7a26:c470 with SMTP id a640c23a62f3a-abf7a26c65emr198736666b.51.1740975970951;
        Sun, 02 Mar 2025 20:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0DZmam62M33CFchi6Iot8/yKD5WtjQeX8AZY42o8lCmFpVtXhHd6dmyoN1uMg3/AghFVz73sYvs21PnyxwaA=
X-Received: by 2002:a17:906:f587:b0:abf:7a26:c470 with SMTP id
 a640c23a62f3a-abf7a26c65emr198735166b.51.1740975970622; Sun, 02 Mar 2025
 20:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:25:34 +0800
X-Gm-Features: AQ5f1JrtDM4meGmqZ71iruwsh2y39gPiEVFEaxe4BlZl8h_Xwrnd5iQqMoRKc2E
Message-ID: <CAPpAL=yGBNWYCCEKi049_yBQs0QjSCCA=AjiT-9NoMZikCOKjw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Mar 2, 2025 at 10:33=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
>  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
>
> Changelog v7:
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops an=
d add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
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
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  15 +++
>  4 files changed, 259 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>


