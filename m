Return-Path: <netdev+bounces-178605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4694A77C66
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8EE16C3FB
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09387E792;
	Tue,  1 Apr 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcDarGC2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692220126C
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514916; cv=none; b=BOf31g2qFR1fRqtCABc941FVJQV6OGceUcKM4tllbuEN2etAUBmuApIGdrO/ddOxZB9xiDUkuCpQaxnRYlW5/RdOF3ItBQOBd+EyWvH2Oyz1ZC6+uWCMFKaVXBxF+vHmpp3YCDG+q1y33kuc7xqNVO26xYMHTxS6WS8h2HP1WH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514916; c=relaxed/simple;
	bh=9DmKSKgpRK/Ghoozm0xXZsix9t8rCDXOdYOtPeAD78E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL1KZ8qvipAOkyt/CeUCBwEJNQGoFqKdrpqA/pE5AGUAnpHfBTtJPdrNlBS5fiOulYZ6wS/1L8rbM3aB9Ur5shxPQl1pqIdJAMTSCpqdinLrF8PFujxkmOW/f73Q1v0vu3rUU0UWJtZEZoyaYzb4YUjMq1ka6WCPzZEHaUa37jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcDarGC2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JT/1HJ7j1dGnCuukkfDvHYvyoCmZ0J/ymsOhodchoIw=;
	b=dcDarGC2gddVDEPe4RNEH554bR1RiI+ZMECqJ7afbb1OHqgqlOefz4BLhmyGg9BAHpgAIz
	4t9Ejuau2SR01bflU0aS/Xq8+VzhA8YgOOw7Ke0muHVdNWfNLTWKcqw1qOBxExPqYeeL75
	TjiMHOzO7dyw9t+14UZeOL3mUds2hOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-REquLzR8M1mrtaMPxLLQ3A-1; Tue, 01 Apr 2025 09:41:51 -0400
X-MC-Unique: REquLzR8M1mrtaMPxLLQ3A-1
X-Mimecast-MFC-AGG-ID: REquLzR8M1mrtaMPxLLQ3A_1743514911
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so40809275e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514910; x=1744119710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT/1HJ7j1dGnCuukkfDvHYvyoCmZ0J/ymsOhodchoIw=;
        b=mkeO54G9OtBu6m8yllKRzrEEY7CSQ2R52ivC+w6Z1qufHAph0WclCbZ4w1Xi9D0yOB
         8WEfMgZkcaoH4zCTpwkA1eE67/ahN9uGMEwRipprvD8/ZLQwtyWRfTCK/3uuM3eNirks
         /NoKI3AipEj1dplhSXE5smXq5WBZK8Xi0iO5+w0JfLIlq64S7AELOGVBlfXzigHA+8Sl
         qlBepLbmVkDQoGc36hvOdGpaFL80zSWjfq76VNjiPRN0o7qkmFXdjQxRr4vJ+eXLPOiW
         cugO3eR7qeByWEbamX3D99KEd/rkxbWHHfw4NC3akRrwvK/pTrsA7qCEdBzVX/ejPLFp
         Gv+A==
X-Forwarded-Encrypted: i=1; AJvYcCUcm+m0RwadERUXsaKYKmC6d8TiilhdZzE7MrH9TO7W7EvqSww8bWnjK7fMYQydYGTmwvUrZDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42isOzLPwfrLzs8kWHTxX0s0DvZCDA5iRjXLAd7HaDaVcmZSX
	91yKN5KW5ac3GDzVCW9gW5mzHFjx8K85e3bxavbXUKHNv49jbXty+m6pMegd40UAPBpuUfQMV5W
	KOtdTEMwZ0Q4Bo2WJKruQGHkrdWiONlSH9V9wW7uidAiHjduzoANJrQ==
X-Gm-Gg: ASbGncu33o76k7e1Bgnq5nnQs+C1FtR/orXBZmShTIJlBYhBNkB7Zf6/K6TZg86Olyp
	mQwva6Dyz7VCL9j117gviyEkyy5kJsXRAZkKYk2tKIg8Zw+gDx+feO2aIfG6otXLZ1kgNnW7I0N
	ezyytFN8EgzcQjKhLiJL59eUOiAtTWEOk+Y4d2Y3g7Qacgk8KiaqilfBCm/JZZFlvzA+lzESgxc
	U09SOnBDOgA1LmeBabRkIeRPdz097OYHT4adls6fDFWnpudCCsXc8j9xtckQlElaOHAN3aamKLU
	8YsG6nl0g7Gwg+ROBESghFDdq5Mswv6TmW7ElI1mqCov5TCc9H4DyRux0h8=
X-Received: by 2002:a05:600c:4705:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43db6247e03mr130604225e9.14.1743514910753;
        Tue, 01 Apr 2025 06:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOonQsa/shEuP0wDgfiH+HuLEzgbTbno+i+to8l7EiHyrr/1tPYY8WHBx9YFeKuuzvpEHoDA==
X-Received: by 2002:a05:600c:4705:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43db6247e03mr130603935e9.14.1743514910230;
        Tue, 01 Apr 2025 06:41:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e33asm14333177f8f.66.2025.04.01.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:41:49 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:41:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/8] vhost: Add the cgroup related function
Message-ID: <qucbuuwmqlrjhm7t7onoedzldrb2cvixjbjezmcovpo24ttzdx@sde275drep5u>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-4-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:47PM +0800, Cindy Lu wrote:
>Add back the previously removed cgroup function to support the kthread

nit: Missing . at the end

>The biggest change for this part is in vhost_attach_cgroups() and
>vhost_attach_task_to_cgroups().
>
>The old function was remove in

nit: s/remove/removed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

As I mentioned, this patch also has unused functions, but LGTM.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9500e85b42ce..20571bd6f7bd 100644
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
>@@ -620,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
>+{
>+	struct vhost_attach_cgroups_struct attach;
>+	int saved_cnt;
>+
>+	attach.owner = current;
>+
>+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_worker_queue(worker, &attach.work);
>+
>+	mutex_lock(&worker->mutex);
>+
>+	/*
>+	 * Bypass attachment_cnt check in __vhost_worker_flush:
>+	 * Temporarily change it to INT_MAX to bypass the check
>+	 */
>+	saved_cnt = worker->attachment_cnt;
>+	worker->attachment_cnt = INT_MAX;
>+	__vhost_worker_flush(worker);
>+	worker->attachment_cnt = saved_cnt;
>+
>+	mutex_unlock(&worker->mutex);
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


