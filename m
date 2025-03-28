Return-Path: <netdev+bounces-178056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D82A74399
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 06:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A83AEB16
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4B21018A;
	Fri, 28 Mar 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b95OJZ1e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1E3010C
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140625; cv=none; b=ns7vDFXfGd1EWvvJBRa89I+GDr47PKk0iRSZtpOm2MOkPNg3ssTg4PL7iQ+D5LYwdTDrcViJ/uWiAEtz6D+SWvDdFOqEzC/rcdfAdR/9ecxVH+cOJqZvShk15BRdCWNCxkSDGbcTkCHKSeB0uSEnJHKGc/pCZU+bgHzjJuJIBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140625; c=relaxed/simple;
	bh=R1Cd1RWDi2fBuC1OYcPiJgOwZpJZ3ikPbq83P1CyQQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHQUCzLDE/8RQGzEMY2X7hOj24nMHo8/kwUW37uKAGUZj8jfCdGRTfQGRQbTzSq1qvXP7imcJI2wu3LtBFwr2EOveFB3mXpFI9xkNP1tbNFLWJeeQbWI7nhQSobHrP/NKVEKDbPNLaSSGONzNoQJ4sDOLT1msjYbdITVjin09PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b95OJZ1e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wksMuYw/9GpKsbd4SKNGSlHUTKX13CwUN+KU7W5lxQ=;
	b=b95OJZ1e8tF53ZMRLClypx4gZNfp1tvunIFZvSJMTxbpLET3HJ0tbVPnuY0gmjB4wFzC4R
	MLAMbBG/xo92M3LA7k6jmwlKWA+CxtdRGjGsfto2Uk2/Yq2OZnSwqQXcbThg1i8wbNWGjl
	ga7P6dOPBpPvplQ2M2mIk108eLMDrw8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-egwrM3-KOeaASe3WOazB-g-1; Fri, 28 Mar 2025 01:43:39 -0400
X-MC-Unique: egwrM3-KOeaASe3WOazB-g-1
X-Mimecast-MFC-AGG-ID: egwrM3-KOeaASe3WOazB-g_1743140618
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abf4c4294b0so173248866b.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140618; x=1743745418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wksMuYw/9GpKsbd4SKNGSlHUTKX13CwUN+KU7W5lxQ=;
        b=q3JoJiBRW17b++DrDlkz5vIqP+6UTiCCdQZCAHqTga2xlYYYj4Bauh0RdDJn+IkkVS
         qlKHP9H1zr/AoXNGGJDGTg1KSSJI6xviNGXNDVmEqvSKfyvJAyHLYmV33u2mhpuACk4+
         8UOZOr38rOSFxbCZSlGnztVW7Wx+6Ff9mhCR+PPCy2Uw/L0H2emoiiZQwcvmHPHjeBNr
         jK7bg4NoWess3S+ZHOvBzsNQZBf9wYxUxkMJwDLJsDLvdmhydHJAv+xngFtoiCnVB6OR
         aY7nSoHuK8uXnSxksP/05JyO+7R1E4tC3ASiS2xe+0hhWPp4UZuv+eFIN7pX4X5JBZIP
         xWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXH3iBUXMdMBAboOL6HzT9ROcJbG2vv7s0U1D803RwNlJ7RNOriIdCqOe4ygCrQ35/OU8gIVf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaA3BM7JAmD3YuEzw03B38vrnsQztFxe3Uy9rPQy52hfO3BZw9
	gkJs/RnZ62+wj/qAF/UApUYglMpB+2BiUKFWGj6HkZN4HizsEBv0dfoyISXtTPhP8H/5DYFtP/9
	SSL2W5mhtnnsc5mnysXuQbvDjjx5fIZlcV+dIrTo30mRlPO3n1hSAfSkjlhr3gvAGBwg9q0cJ4X
	LfnArNbiiOPxjUEVJFXDaLQFf1gYsv
X-Gm-Gg: ASbGncs115tD2ob0SugPBFNoWvkGEWl9wgdiQtOi4ze40bVf/D5KfYyLWpuBQLiLF0n
	NLEUBqYU3TNSOhwkFTfs3aTgjuel/dpliIp/nHpm8/oOaJAcv27ZFxQXj5wCrAPY1WOO0J/BJEg
	==
X-Received: by 2002:a17:907:d09:b0:abf:48df:bf07 with SMTP id a640c23a62f3a-ac71ec953a4mr133952566b.15.1743140618022;
        Thu, 27 Mar 2025 22:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNxIeMm1LXUGFUqFwfktfKRuuPWGPkRIHX8SMtj4Le0B0TdFaZ3P0I7nYy+Mxe+zRAUGYAlqF6VzzU8SAANg=
X-Received: by 2002:a17:907:d09:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-ac71ec953a4mr133951066b.15.1743140617642; Thu, 27 Mar 2025
 22:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250321153611-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250321153611-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:43:01 +0800
X-Gm-Features: AQ5f1JrnFEMx6y_4Kqib8q0i7cd7Ag5bB8-g7oD9EIrR0itmEqRSBH6v1-QxRBY
Message-ID: <CACLfguWG+rxAu-pBSKRd1etNQ0GBA33LHtG5vdKasub-1fueEQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 3:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Mar 02, 2025 at 10:32:02PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
> >
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
>
> This seems to be on top of an old tree.
> Can you rebase pls?
>
sure, I will rebase this
Thanks
Cindy
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
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
> >
> > Changelog v7:
> >  1. add a KConfig knob to disable legacy app support
> >  2. Split the changes into two patches to separately introduce the ops =
and add kthread support.
> >  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
> >  4. Rebased on the latest kernel
> >  5. Address other comments
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (8):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Introduce vhost_worker_ops in vhost_worker
> >   vhost: Reintroduce kthread mode support in vhost
> >   vhost: uapi to control task mode (owner vs kthread)
> >   vhost: Add check for inherit_owner status
> >   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
> >
> >  drivers/vhost/Kconfig      |  15 +++
> >  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |  21 ++++
> >  include/uapi/linux/vhost.h |  15 +++
> >  4 files changed, 259 insertions(+), 19 deletions(-)
> >
> > --
> > 2.45.0
>


