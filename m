Return-Path: <netdev+bounces-169665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA48A452B2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DB816F9E4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27DB213E68;
	Wed, 26 Feb 2025 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx6+KCev"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2E212B29
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535529; cv=none; b=auM878bqK8uXehL/UejQ+/BellYuKnQU1BfKxYOuxxKVjSVUJ7y7YXefJ/2whAewKUUo6xLpKFWXZdbCSzVNdXfdk9ImB6Y+XaWCQvU3t/IFt7zFcqPscAv4YbUK9kThXnddIxQI/rYKcQbWIRenBgzv6b8JSVWZO9p3ph6f3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535529; c=relaxed/simple;
	bh=JCftPQYVyvK+z4ejhkMDA1JxlGnB45HtW0/686G+fKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSqtT2GuUi1CMn7DfB+n3A7QrZJ5dr3VLyA2mJYJO8bPmsEeVPjkM5CyfVELUDkWMEj9qZrCYuvCSMerNDMGvZ+ghXElQdUquLYwY2vyg/14BwBfhnW2iQzk7eMwVSd69be6rfSxANkmZfwkn3V9Ju4H9deoIYbawyoFpcCrj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx6+KCev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740535525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
	b=Qx6+KCev5WvUuGAsvoNGPm3AXroILOq6/6xi3fGB4CkZrKqYbZJoDfGulR0zIxieKlXy9a
	+VeCyaN2O0hWvv5PJn3SfsZPbEQMnXI10z8nzLxVp4j8KebBgDyaXjsWEh1r0mjqyJ4UkK
	Rs1UfVJVH+fj9TrvV12Ca+f7Wzy8wrY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-K1BrYFFqONagJZPNvbqovw-1; Tue, 25 Feb 2025 21:05:23 -0500
X-MC-Unique: K1BrYFFqONagJZPNvbqovw-1
X-Mimecast-MFC-AGG-ID: K1BrYFFqONagJZPNvbqovw_1740535522
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abb93de227dso589386766b.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535522; x=1741140322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
        b=Ik5v9BI/MW2IFfXS4CithjLm/7Xk1FCrLpKZazAlkLOL2pXOL7KoMcfQprE3X4CP8T
         /kLAUXbDtgoBKkXFaDeYiHT0BK3aNg5UpR1+JkMsFFgg+54WaJJPQdw5U2ykxXBs+qi8
         rh/QNvw0lmW0wHxz9RhUTYLy1VYPK4stoQdLeee0nd0pJ5UM/+I4DkKbcQkGSZMY1G/8
         gpjmxz+SRB+iG9aoN5milkFd7HMagg+Ir7Iz09H0mubDYdUiH1LV/8HIYbvHYeiTPBxq
         BPna69DM1TelZPHScSh/2gM/pDzgGNS1caRxGoi2PoKJHxwVV1dqeXcHbeY3rAQkBxRp
         QnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjO+7KDGAffd15GkfoqzvbHH7x9qx1+srAkVwyvvJZEamW+8rtWBxEwW+k6OIh0F8V5I4Cssk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fTPu3xg0bW4pHX5l/67LPX7EBa4j4HPwoV3vZC3+vkfz7Lgs
	qRIBkW7dRViwehU1J52nNOv/ZkOEurShrRFVVboVDvU0a7xGo/jVW0MKNghLBxLBKL/FEf1iox8
	gSodfepz+T13As7WesUSe3NNryGOW4tfWt86S+Gb+fxOYCVOOs5FPFfhC4IoVPP+pcnD8aqP7N/
	LkBplPhmfPVdNBfnzb+Rt5F4SWFNjx
X-Gm-Gg: ASbGncs8fy+5PpGscgX0awWfpNlGTs3Bqr7Pml46XZDbiHLgfWq0OxonpIwoekEYXQt
	KaqgXjHUdoCXWa+iXKYoULln/NWS9uKMXBkrzo5alHjCEG/hTbytYsGTRKuGJcCK9jSRcv7H8pA
	==
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id a640c23a62f3a-abed101a68emr584728066b.38.1740535522481;
        Tue, 25 Feb 2025 18:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDnpl2j+0DavpNWZdYT5Z/FgRyn64TInVqaEucZU+lYsdoJPEs6pdWR0j3CR6bsT3Arc59/ceBLEEvkVFCxxI=
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id
 a640c23a62f3a-abed101a68emr584726366b.38.1740535522087; Tue, 25 Feb 2025
 18:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250224164233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164233-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:04:44 +0800
X-Gm-Features: AQ5f1JqiQ7lr3YyNb7nTi5Z3YzGts4m-JzTljklxhrdzE-njba0nKckam0rKUMM
Message-ID: <CACLfguVo+04seP-hmbVjzKBVk4XfXcPvtRsuHOiiMUn7fzJB8g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
>
>
> This looks good to me.
>
> Pls address Jason's comments and add a Kconfig knob, and I will apply/
>
Thank you MST, I will add this
thanks
Cindy
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
> >
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
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (6):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: introduce worker ops to support multiple thread models
> >   vhost: Add new UAPI to support change to task mode
> >   vhost: Add check for inherit_owner status
> >
> >  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |  13 +++
> >  include/uapi/linux/vhost.h |  18 +++
> >  3 files changed, 234 insertions(+), 24 deletions(-)
> >
> > --
> > 2.45.0
>


