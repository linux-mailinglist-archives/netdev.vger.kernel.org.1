Return-Path: <netdev+bounces-150786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9169EB8C0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EDA28346C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D61C2DB0;
	Tue, 10 Dec 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJCn+yP8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361E86336
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853196; cv=none; b=QEFaVGvYk3wz3v4HmXwuQLPBgNYYXhAU/jc2wBfVy12pH95SeVegiuzb4O7AiibYPn/4sJdSPx+E6ufGp4BxOpQuxxYHEEGHbbvNHH20n+omPIiUhUdjWGDHJQ/gnTD0JMAIBboniXzVppkS7K7Ye78H4HCnWm85o4UtybOOCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853196; c=relaxed/simple;
	bh=GiA6E6YUT24hkxZZfyf2XJKY4+22S6/8ZvzlZG2X5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDGw3ml7ggGcLJf9dUv4aVPUuZleT2UFC9QWhSpivNKNllMDvb75gQdqotCpNurmsvJizAe5YD9JupYf3JG7ZuAhgaPc70vAtq7eyKW07oGfNYn8igC1cPTGebE4OjmW3vaLkkg78muao04PzcvzFvFklv5CrVfesc674k7oCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJCn+yP8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
	b=gJCn+yP8vPPSth8nlHEFz1Y9Ju1H1++Vs4FPskH8JDfIqrhlhaqcMqAdqFYaLDA48U605I
	PVafCcF3ocbTq9yIopJHnnumE42iqSqmyhLZyLynr102W8JBH+yseJxqCjsKOtJ7n80aVn
	H9Hcb76MaAj4OaLcRy7tXYF2oujnCss=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-HokKkV2jPluoowaTQsNoIA-1; Tue, 10 Dec 2024 12:53:12 -0500
X-MC-Unique: HokKkV2jPluoowaTQsNoIA-1
X-Mimecast-MFC-AGG-ID: HokKkV2jPluoowaTQsNoIA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcadffebso1539602f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853191; x=1734457991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
        b=RBx2faKWs4iEec74rRHbfJJ5T8MxVWp1qr5Y8Yeej/ed+i8Isn3bqr7KBbSEpivTVy
         1vAEe9F//GhO5Qhdn0p5i8gGNIJSjJmtfyggi1VYmHYDab/WRtbijb/AaAR97GUtDbv+
         2N8qn8sjOXCltBwttqpKRRo/fnnK2Mc4j5cqpl7wfnsEExQR7BraUJzL0pTRhNwOVO4K
         TCaqAkQbg4Msf6pK3LyTMmuw/99OAuq8fAWGopW3q2oGh1KsqGRvKji7uDDzBzpbl0NY
         bYKFwxqfDxov5NFnkbYAjZsP9SdfKRSJfWBpbHULEnSmq0JedO83ZkT4ITXAB3hk8CWn
         zYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVV7A3T0PaBxKG1qP08L7/Vboo5B7+sZ2jAFv3PSoLfg7tUbr6GnffXo7aoNKa1GJbfGZKMGko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGC4em+j1Y9tjvR0a29k0lPl/KTt/cnBbdVlAx/kz7A12u59R3
	zGw84N4ssAN0Tc17UMt5FB/J0jXHW/lBjjJD0PBYb7patunBHfpsIcKkUmUKHA28+9nPF/t6wjL
	lzu9A07arq3lw2TKkAWCuftqleKKADtUqlPqht0Rrwt+6TC9Ee2FOwQ==
X-Gm-Gg: ASbGnctzt5H87DTfq+DW8Rt3KN32b419Xs0mpcBvC/CCttaup+db1/UJXrfbY4uBpan
	hCIOy9lLAehxw3cOls0YzKVSr0dKxguMCD7c1fiq9jawDOmxjEfWo6J0vQfW9la11C6Ea7dSOqe
	XKCgmWek4+s7d6+EuPj6lb1QJ6zvVpc5XSGH5zSX0KMWssZflQ0Sjuef3HgfSx1v9c4nMw5Sqef
	OM43W4DtRhDpSt0/4kpTMoMtbrftW4mG9rRRr8AVfb2g1pllmYDd24Zff+g2jGmv7D4frjKjCQs
	KD8FKZI/dBZDHWEORViQmsSl0KclaQ==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20243f8f.4.1733853191431;
        Tue, 10 Dec 2024 09:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyNGcJtqIvdODAbGKru3zIfA/gLNJtt/5XcSx5m5F9FIgAvZT/2YjpbC5CxbPoDO18XR8O7g==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20218f8f.4.1733853190735;
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13157753f8f.108.2024.12.10.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Date: Tue, 10 Dec 2024 18:53:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/8] vhost: Add the cgroup related function
Message-ID: <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-4-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:42AM +0800, Cindy Lu wrote:
>Add back the previously removed cgroup function to support the kthread

nit: missing . at the end

>The biggest change for this part is in vhost_attach_cgroups() and
>vhost_attach_task_to_cgroups().

It's not clear what the big change is, is there a piece missing?

>
>The old function was remove in

s/remove/removed

BTW which is the old function?

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 1feba29abf95..812dfd218bc2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -22,6 +22,7 @@
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
> #include <linux/kthread.h>
>+#include <linux/cgroup.h>
> #include <linux/module.h>
> #include <linux/sort.h>
> #include <linux/sched/mm.h>
>@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
>+struct vhost_attach_cgroups_struct {
>+	struct vhost_work work;
>+	struct task_struct *owner;
>+	int ret;
>+};
>+
>+static void vhost_attach_cgroups_work(struct vhost_work *work)
>+{
>+	struct vhost_attach_cgroups_struct *s;
>+
>+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
>+	s->ret = cgroup_attach_task_all(s->owner, current);
>+}
>+
>+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)

This function looks renamed, should we mention in the commit 
description?

>+{
>+	struct vhost_flush_struct flush;
>+	struct vhost_attach_cgroups_struct attach;
>+
>+	attach.owner = current;
>+
>+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_worker_queue(worker, &attach.work);
>+
>+	init_completion(&flush.wait_event);
>+	vhost_work_init(&flush.work, vhost_flush_work);
>+	vhost_worker_queue(worker, &flush.work);
>+	wait_for_completion(&flush.wait_event);

IIUC this block is the old "vhost_dev_flush", right?

Maybe we should mention also that in the commit description.

>+
>+	return attach.ret;
>+}
>+
> /* Caller should have device mutex */
> bool vhost_dev_has_owner(struct vhost_dev *dev)
> {
>-- 
>2.45.0
>


