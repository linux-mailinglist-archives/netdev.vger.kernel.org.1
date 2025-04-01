Return-Path: <netdev+bounces-178613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD7A77CBD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900FC7A2864
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06C2040B2;
	Tue,  1 Apr 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXUh2oCq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234FC2C6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515516; cv=none; b=XCiXLFERi7fMgTtvjHIKbFVDDd8DVHZ/UrPxYItLZD4oDF/r6OwIqZAamQ88r6ErMiFNy8LFqCRGf0xJJES3U/McrW/QdnBj40xTlP6DXlJ0lTcWALAZc+7+HU50f+/EnUi6l73hrCoiryzdXD28lyVFBECxB/Kw0EzH+IgjQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515516; c=relaxed/simple;
	bh=fyJnXBrOut1qI3iVOlrjftIknLYmdN5T3FQdk35b5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn7iKztKsf+OawO8KesGllsadQ3oM1fq57DRxA1+Hj93/OfAUTv4XpQd45LMAXM3/48NxSRXEBZoVwK7ztPRMc55HRyr5HuWtsC2M9cXMbzVsbmKLHqAzrj3M7n/X8dLleC81OIaYvWaVzdov7OAxXdvs6BNG98+aUIZQjpedCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXUh2oCq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yd713vKppQHQbjGvhffkowOQ35Ux0lbgZmPhSE6rLE4=;
	b=DXUh2oCqO1ROUWPH9FsOCb2vIi7aEw9cFXs8Wd2MT//ewVMR1qzWvxWhArg1aEIv+yxneX
	wlr6CmaPzWfj4M8Jz77xLWVIiP7RH2ZQtVWfnI/pkm8yml/cLTKR+Xjrb3mRnCuD61H393
	t/ee6bw7ZWLxrE6cgoPts4yAlnqCFBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-15T3kF9vPCiWu1hBffIHpA-1; Tue, 01 Apr 2025 09:51:52 -0400
X-MC-Unique: 15T3kF9vPCiWu1hBffIHpA-1
X-Mimecast-MFC-AGG-ID: 15T3kF9vPCiWu1hBffIHpA_1743515510
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so39828755e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515510; x=1744120310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd713vKppQHQbjGvhffkowOQ35Ux0lbgZmPhSE6rLE4=;
        b=eY0dCVCS3sTvFcwQDLov3FFYqoAxZpxOQW5Ba7IbS8iFpCeOA1Vpm6N9p1RPs+jAFm
         cQ7MTH7LZu9KrRR1DJuN4ciGCtuthlsDcEzqVG8OjuuiVsB4gPDMeljkvxoz/f3nc6fv
         2G0J9qGWFx9WssvZ2r5LIhm0CuUXdAjlY7Ov706yeEaQd4Lx5/CbiS3msw4arsYvK1qn
         yIKYQeklK24e+pwA4pLNFv2gopz1A3OXGcVNBXyO62sdJxrvgjNsw+SVprGQDgKKI5ls
         ubXJ3PHnf/kE8zPeha/sDCq2BJqXH8JtE997+Uzk67L57oEjOKreSV9uU3rgcKClfkkD
         LHIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrcNTT1QjmVPZ9zC3nQ2mYEWY6hqgwLyriBla4+WBmf2oBO/twuLB8cNy6MlI/hR5iJ8DlZ6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YziV7Fry6qvhtu/4QkCSOmRyku0noU5E7qsBtrxKxC+xAY9KK2Z
	IpJPCZarsm6ajYebEpVHRlV38liqlAz8aX3UTJ66InTsgXudgT1+iji6/I9aIfV5ORYQamlPatH
	c7GPZ6qR2nY+HuHJBHVZHBKm03/nkSQoEUqtrcnQxgnRnNSRBBauATg==
X-Gm-Gg: ASbGncuNjgJUWKlEJp7gUQO/hKFSVNc7W7+Ky0/sHnriBa0M59fCYMqMVM/6buHygyh
	ndJm9cOhatNUcAkLY2926FnGlVkmRRuhNtRUiQfoK94eFjeOTPk0vlWqwQipB5vp+iuoUwIfel6
	S2Nuu0/curWkba3kLB/ZsiZ4M43Aok7dbGwQL7/S+KLruhi68gptyTTVmKr6o2dWdU0inzVFENl
	OKJnMweqsUL3EOD2r9IQI9r3IOOZ0yw5w0XjXVeFAVMcEne5a8ST2U9td12RYLd8VegjuwR/NI/
	k7FUgllZwHtqDA8cXQaCpUBZpcmNSYyduCnxnjEUw1a/B8F9lYD4qse2Q2Y=
X-Received: by 2002:a5d:5984:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39c120e079amr10530783f8f.25.1743515509947;
        Tue, 01 Apr 2025 06:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsBMqSUaVpvZcub9DerZUyAcDAdWPbokGx4MrEDvZ1V89a1sJp60yqYaFeSZ3uq31KHnaDGQ==
X-Received: by 2002:a5d:5984:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39c120e079amr10530760f8f.25.1743515509455;
        Tue, 01 Apr 2025 06:51:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4318sm13937042f8f.87.2025.04.01.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:51:48 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:51:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
Message-ID: <qtii7gazb52fuvkeiymllkapnd3l3ji6ht7y7cfegybreavmit@h6bvfhwpghg6>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-6-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:49PM +0800, Cindy Lu wrote:
>This commit restores the previously removed functions kthread
>wake/stop/create, and use ops structure vhost_worker_ops to
>manage worker wakeup, stop and creation. The function
>vhost_worker_create initializes these ops pointers based on
>the value of inherit_owner
>
>The old function was remove in

nit: s/remove/removed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 48 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index c162ad772f8f..be97028a8baf 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -734,11 +734,21 @@ static void vhost_task_wakeup(struct vhost_worker *worker)
> 	return vhost_task_wake(worker->vtsk);
> }
>
>+static void vhost_kthread_wakeup(struct vhost_worker *worker)
>+{
>+	wake_up_process(worker->kthread_task);
>+}
>+
> static void vhost_task_do_stop(struct vhost_worker *worker)
> {
> 	return vhost_task_stop(worker->vtsk);
> }
>
>+static void vhost_kthread_do_stop(struct vhost_worker *worker)
>+{
>+	kthread_stop(worker->kthread_task);
>+}
>+
> static int vhost_task_worker_create(struct vhost_worker *worker,
> 				    struct vhost_dev *dev, const char *name)
> {
>@@ -762,6 +772,41 @@ static int vhost_task_worker_create(struct vhost_worker *worker,
> 	return 0;
> }
>
>+static int vhost_kthread_worker_create(struct vhost_worker *worker,
>+				       struct vhost_dev *dev, const char *name)
>+{
>+	struct task_struct *task;
>+	u32 id;
>+	int ret;
>+
>+	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
>+	if (IS_ERR(task))
>+		return PTR_ERR(task);
>+
>+	worker->kthread_task = task;
>+	wake_up_process(task);
>+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>+	if (ret < 0)
>+		goto stop_worker;
>+
>+	ret = vhost_attach_task_to_cgroups(worker);
>+	if (ret)
>+		goto stop_worker;
>+
>+	worker->id = id;
>+	return 0;
>+
>+stop_worker:
>+	vhost_kthread_do_stop(worker);
>+	return ret;
>+}
>+
>+static const struct vhost_worker_ops kthread_ops = {
>+	.create = vhost_kthread_worker_create,
>+	.stop = vhost_kthread_do_stop,
>+	.wakeup = vhost_kthread_wakeup,
>+};
>+
> static const struct vhost_worker_ops vhost_task_ops = {
> 	.create = vhost_task_worker_create,
> 	.stop = vhost_task_do_stop,
>@@ -773,7 +818,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	struct vhost_worker *worker;
> 	char name[TASK_COMM_LEN];
> 	int ret;
>-	const struct vhost_worker_ops *ops = &vhost_task_ops;
>+	const struct vhost_worker_ops *ops =
>+		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>
> 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> 	if (!worker)
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 98895e299efa..af4b2f7d3b91 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -37,6 +37,7 @@ struct vhost_worker_ops {
> };
>
> struct vhost_worker {
>+	struct task_struct *kthread_task;
                           ^
nit: I'm not a fan of tabs, but here all the other fields have it, so I 
would put it in.

> 	struct vhost_task	*vtsk;
> 	struct vhost_dev	*dev;
> 	/* Used to serialize device wide flushing with worker swapping. */
>-- 
>2.45.0
>

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


