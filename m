Return-Path: <netdev+bounces-152855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AD9F604A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AE16AECC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E4183CB8;
	Wed, 18 Dec 2024 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C935Kcqf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200D14F9E2
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511159; cv=none; b=KmXNcAfguxUXAwx+GVxyYzljyhs6nqjGWHQbryjBnpIYoG5c/w4+Y/0UXUafnJ6oa2/K7+a8+dgERiYruhrJt/eeIpA4aQmcWZSZcHOZNsJ0nQtMITYR6rqADPFEfpwniIpL++/9pEmoEJItSaGIqB7R9VzhJHSSwvI3xFbkmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511159; c=relaxed/simple;
	bh=kvEZgLfuKpBIL6UXFHvWj4fhMBsAebQHK+DO4sBMdwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTSH8kJfQIrqjrIU3/+6r4tqvFXfUGrku2qII1XhL9QSm1I7J/NueNAwRwMpICGzUdt2eZganWWfTz4Qsc05Pcs4z7lEKlWHPX4spnEIubO65tQ1b1pKn+/isSvPW+6+jFSwBisUQBCh4hae5DiKJ6YhHtMCySm7dRzpqT2eqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C935Kcqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhonihEVaQJzVy2Bbs74DpiB+LrNVYNHZo3wHnFP0Ec=;
	b=C935KcqfSamycATtD7+UlrdsD6rnT3GdDRBFUaDoYodYMDX042M07N10I0s4hHEixK2arP
	XxDWhbE8c3Jy/dxtcA8Mwds1oRMINvmcYx/Kv/aJFHfTvm0ERMGKchS7EXpet5WcVGqNrs
	sO0eTznXZlSbjmsIsj04gHqQiJsETds=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-5MU0XO8jPLaKhyQrPQgEFA-1; Wed, 18 Dec 2024 03:39:14 -0500
X-MC-Unique: 5MU0XO8jPLaKhyQrPQgEFA-1
X-Mimecast-MFC-AGG-ID: 5MU0XO8jPLaKhyQrPQgEFA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aab954d1116so440913866b.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511153; x=1735115953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhonihEVaQJzVy2Bbs74DpiB+LrNVYNHZo3wHnFP0Ec=;
        b=iMjVVO0/VhmqC/hugQ+b/0gB/uzi7z/I+OA72G7VO9QxgI1rof+3vawMXwhwCF6Rkz
         plFl4zqu0u/tEt7Hyk9qMjJ0iCJfbIwfChQHYvnL+M32M0BgvvDdaA9pHkcehh85kOT4
         3UfqFMKE9l/TqUVagx2KZTKH78iEUq2rTMRtcAlCbkTSikAj9evtvgc+KD8MCOy8yNEz
         s6A/RMAoT98kT/9LkTgj/2kO1gRABkZw66tKYZUBQb5kLpdwU/4m7B1W0a+Jag9QxtXo
         aYOujbtl880VdljQhE+PGkcPJ3WjF+BVaYDyTqdKWU0mQt3PUeSob2Vb7mJ8iO1VEwNf
         pD+A==
X-Forwarded-Encrypted: i=1; AJvYcCU9DT7SSKY/m8soLPCsreK5qvDhCPYxZ3ISbhQ06zrt2QhZMjQfxYe2At9ohgTvjLmPXrGnfGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBqFAG2AknHjQMvZ9Rdl2S7Lb2qOZyBnS+O0NfG7eFvXBRE+V
	3gy1x8j80MEfV2nQhSPve74VhC5Htl5hoLeR9az5X7AuLpN+dcD/ONi7xLs3vYDw6K+S2tuq+TL
	arcvF2D4h+YjCW+yrsYQtsx1vR2f686fHDcQCBqcBOpkjiR2MtPbTgLMXvfPRXdqXuWm5A+tywc
	GxJiDn/CMeks5jwSqv7qvG2AxfSoyW
X-Gm-Gg: ASbGncugr9b0gaCqecCUL4VEgzzbJ4aK/nkI3UV2UeKBtYs5sIZ6MCyXxqxUXK1NKJ6
	pIG8sKoN/aWj4W/P/YRyRpjkllyHXT/j8ZgGcfUA=
X-Received: by 2002:a17:907:78e:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-aabf477ddffmr189584066b.31.1734511153367;
        Wed, 18 Dec 2024 00:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPyHUFmwfjNjzfUhcrQYfLNkqlmB6wOjQYl2K8WIGXcwvWI6bQLQsDKPK91gwt2HYdHpGSb0X2wb+YUCuEdFA=
X-Received: by 2002:a17:907:78e:b0:aa6:96ad:f903 with SMTP id
 a640c23a62f3a-aabf477ddffmr189582266b.31.1734511153024; Wed, 18 Dec 2024
 00:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-3-lulu@redhat.com>
 <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
In-Reply-To: <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:38:35 +0800
Message-ID: <CACLfguWPmu=Wx76bqQesa+OEUAvietEDfGNvXDUCOt4LEFzgbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] vhost: Add the vhost_worker to support kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:41AM +0800, Cindy Lu wrote:
> >Add the previously removed function vhost_worker() back
> >to support the kthread and rename it to vhost_run_work_kthread_list.
> >
> >The old function vhost_worker was change to support task in
>
> s/change/changed
>
will fix this
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >change to xarray in
>
> "and to support multiple workers per device using xarray in"
>
will fix this
Thanks
Cindy
> >commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 38 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index eaddbd39c29b..1feba29abf95 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >       __vhost_vq_meta_reset(vq);
> > }
> >
> >+static int vhost_run_work_kthread_list(void *data)
> >+{
> >+      struct vhost_worker *worker =3D data;
> >+      struct vhost_work *work, *work_next;
> >+      struct vhost_dev *dev =3D worker->dev;
> >+      struct llist_node *node;
> >+
> >+      kthread_use_mm(dev->mm);
> >+
> >+      for (;;) {
> >+              /* mb paired w/ kthread_stop */
> >+              set_current_state(TASK_INTERRUPTIBLE);
> >+
> >+              if (kthread_should_stop()) {
> >+                      __set_current_state(TASK_RUNNING);
> >+                      break;
> >+              }
> >+              node =3D llist_del_all(&worker->work_list);
> >+              if (!node)
> >+                      schedule();
> >+
> >+              node =3D llist_reverse_order(node);
> >+              /* make sure flag is seen after deletion */
> >+              smp_wmb();
> >+              llist_for_each_entry_safe(work, work_next, node, node) {
> >+                      clear_bit(VHOST_WORK_QUEUED, &work->flags);
> >+                      __set_current_state(TASK_RUNNING);
> >+                      kcov_remote_start_common(worker->kcov_handle);
> >+                      work->fn(work);
> >+                      kcov_remote_stop();
> >+                      cond_resched();
> >+              }
> >+      }
> >+      kthread_unuse_mm(dev->mm);
> >+
> >+      return 0;
> >+}
> >+
> > static bool vhost_run_work_list(void *data)
> > {
> >       struct vhost_worker *worker =3D data;
> >--
> >2.45.0
> >
>


