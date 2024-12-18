Return-Path: <netdev+bounces-152859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDD9F6067
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388B5188A18F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113A192D69;
	Wed, 18 Dec 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNnEFYvr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A49192B95
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511590; cv=none; b=fHigyPM7kQbItHXezZ+64dsWFv7effbMyHrztDYlp6euFAGYLlWCdpRteof1mS32LtQa/ezjzeqcz9S9EblAJWjAINGRIawHmGELIE0iPVk0vLHlMSbtso1U8KrWycWlHyq6dwOLyEEzSfHc/1CYjhAxd3FpxbtIrMQNgjf40Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511590; c=relaxed/simple;
	bh=O3ovGN6Hg1bqUxumZterPrFzVTulwMpdVPSvm/DtAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCMsYxHIgA82W04JQiAO5rkOgLrr1btMcgYvMnx9hkUZGRRjdSRwCCtzll9kvZmgGyUpQ0N0Hy92YSpUcVZ2zLeX6iclvdGKVfRQ9iP3bRVxpyApb4WYXrzRnM3v/Q+Thkz3PIIqrKjW8KQTv41DMAGdsCov4JWEyMauJQmD7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNnEFYvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqGOCEuKyFp5Mq0Dor8PkiIuS+YUjt1N5OpQaCIrUnI=;
	b=XNnEFYvrJ5NeSOnV870f0Yj5K60VTJodU5tqCDkCvXpxCr3m1MruRjZrIKAZ5PCrWYdxbE
	9DwMDYQvtV7hntuWFS4MDdkfzzUkor22JFjdbmGchCvi51ZmbLwIb9BQI1kRVHGyEZmS7a
	S50fYiyMdUtMGXCBfDY0e+ptEjT1rl0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WC0tWb6JPjuKcRDaqngd3w-1; Wed, 18 Dec 2024 03:46:24 -0500
X-MC-Unique: WC0tWb6JPjuKcRDaqngd3w-1
X-Mimecast-MFC-AGG-ID: WC0tWb6JPjuKcRDaqngd3w
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aab954d1116so441520166b.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511583; x=1735116383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqGOCEuKyFp5Mq0Dor8PkiIuS+YUjt1N5OpQaCIrUnI=;
        b=IbqSlnA9Y60Ietwe8p6f9THVewe12xnyzJBhzTvcXn/14dm1++xGZWt+DyUAzZRuxd
         R0vlKtDeWig6WSpjhgw12EQkXlxWc6XR6uzkVEsVC7JQ62GVgKPbTtdlycpQ/HGDsjkl
         7vXafy1D+Cg7keTpLcTG22xeXO9vVZkuA0vpSYjrseL+GGclew3zusVSSGK+kCal/aPm
         VzTwH3H2twWfU/Tb82T5C0tSsQvi1VeUAiYuLKA+qAOwJ02i+Vgc7b3qUSH/9MhE0mB1
         rZYKI9oJtLxh8pg/qsZuWbBoDlrRWCZliUh4JLuNJuy+iEkQw4Ag+gL3KRZs/n/oi7JL
         r6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWrGXxfuHfYznExOoTDuU/dVY4ZgRnrbM5CesW9kRT2HkNbYqlD3pJ0crHgpXq/zneyvZYqUeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPRtRC/x1KWuV0G/b2u30pSdnMU2I7x+gg7w026ltEFpYJNuP
	QWE4RDiuX4Vnr+mUtQKwGZWwRBJHcUSSUnGQVctW1pIKtwPaA02oqjPk1JP7PBEbw1wmI4H8hmy
	PC0xnfAAHoFUnBCZSsoahYo9Fb7NVss0H+DC6fgbZrbUqDdfPR8e/naLiQrUvHBIOZiVsI9oOGU
	XXRr9f5ZJnDT8ZthHPZpdaJXYFvbJs
X-Gm-Gg: ASbGnctDcOK3iyx6si2HlVa0k8Fx0JSq9wjh6poi+2icmBUi3vXFno8+izwtocp3yjN
	ZCgzFQmlqYUsaVFi36atsjaKZl+vINg7IA9icEo0=
X-Received: by 2002:a17:907:86a1:b0:aa6:8430:cb02 with SMTP id a640c23a62f3a-aabf4966c7dmr144137466b.61.1734511583418;
        Wed, 18 Dec 2024 00:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHFm3Z3+PffAYmhBV7W18HwZ6rWjm1WHllt6r3VVlY7cNgegLPC1hcc2vCR+lKDficcfktiXwIyQn7ScZf8Y=
X-Received: by 2002:a17:907:86a1:b0:aa6:8430:cb02 with SMTP id
 a640c23a62f3a-aabf4966c7dmr144136066b.61.1734511583030; Wed, 18 Dec 2024
 00:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-4-lulu@redhat.com>
 <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
In-Reply-To: <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:45:46 +0800
Message-ID: <CACLfguWtkt6xXs5dJygyEGQwztFdC8BrT3KOr1wpGjSraFL8HA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] vhost: Add the cgroup related function
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:53=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:42AM +0800, Cindy Lu wrote:
> >Add back the previously removed cgroup function to support the kthread
>
> nit: missing . at the end
>
will fix this
> >The biggest change for this part is in vhost_attach_cgroups() and
> >vhost_attach_task_to_cgroups().
>
> It's not clear what the big change is, is there a piece missing?
>
sure, I will rewrite this part to make it more clear
Thanks
cindy
> >
> >The old function was remove in
>
> s/remove/removed
>
> BTW which is the old function?
>
I will add this information
Thanks
cindy
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> > 1 file changed, 33 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 1feba29abf95..812dfd218bc2 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -22,6 +22,7 @@
> > #include <linux/slab.h>
> > #include <linux/vmalloc.h>
> > #include <linux/kthread.h>
> >+#include <linux/cgroup.h>
> > #include <linux/module.h>
> > #include <linux/sort.h>
> > #include <linux/sched/mm.h>
> >@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> > }
> > EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> >
> >+struct vhost_attach_cgroups_struct {
> >+      struct vhost_work work;
> >+      struct task_struct *owner;
> >+      int ret;
> >+};
> >+
> >+static void vhost_attach_cgroups_work(struct vhost_work *work)
> >+{
> >+      struct vhost_attach_cgroups_struct *s;
> >+
> >+      s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> >+      s->ret =3D cgroup_attach_task_all(s->owner, current);
> >+}
> >+
> >+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
>
> This function looks renamed, should we mention in the commit
> description?
>
> >+{
> >+      struct vhost_flush_struct flush;
> >+      struct vhost_attach_cgroups_struct attach;
> >+
> >+      attach.owner =3D current;
> >+
> >+      vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> >+      vhost_worker_queue(worker, &attach.work);
> >+
> >+      init_completion(&flush.wait_event);
> >+      vhost_work_init(&flush.work, vhost_flush_work);
> >+      vhost_worker_queue(worker, &flush.work);
> >+      wait_for_completion(&flush.wait_event);
>
> IIUC this block is the old "vhost_dev_flush", right?
>
> Maybe we should mention also that in the commit description.
>
sure, will add these informations
Thanks
cindy
> >+
> >+      return attach.ret;
> >+}
> >+
> > /* Caller should have device mutex */
> > bool vhost_dev_has_owner(struct vhost_dev *dev)
> > {
> >--
> >2.45.0
> >
>


