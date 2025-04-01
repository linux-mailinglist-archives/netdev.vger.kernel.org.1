Return-Path: <netdev+bounces-178599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBEA77C16
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C52168E47
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59D13BAF1;
	Tue,  1 Apr 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdgGKKbp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89EA95C
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514229; cv=none; b=n2Jq9qCKpjs1HWdZAVjqFtS3oljl5vQLD5RituwzLlv6xHx7GPFsr3jPRqEqvwkhUcXyEamDXCfJdl+ChtK/5DDfreS/8lR6tVe0/+y1uspdGFiGmbznOsVG7kHh9KNhdR4mjOyRM00VxVsdpR7Vl2yMl5VkIVedd1ctJiRlSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514229; c=relaxed/simple;
	bh=xaI867HGHR4T8sG8WY/K4UFRf2cdS9W4OArVVIu7Kpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4bXAwicJCpCSMRJcBSeLG+yokX7tgrpsShg1Eq0W4UlI3TtwWgPhbyYBrzBFLlUFLjVufomcfDO7Nkt7wQn4F2JNdcxt/sQUnfTquxtA6m/hrMWaDv619Uv3ywo1GeiWEMp26QBbdO4cpdyOLiR+H1YFzu8ghqrThVNCgdyqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdgGKKbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GD6tHabuLwNG81tJKtS1hzWrYbj0F2aL9q0asRKe8YM=;
	b=ZdgGKKbpq/DYW4sOr9R+gRN2iS5oMwZzbwEtY5sGpgNhTOuxtgyR8aJgE9PIlREH/mKnqz
	IpER05Bgdx4ygGEm7/6fZI7ztzXlQzvIsC8K6pM4QHjpb/o3Tc2zvuHp9N1NvD4VcflciU
	usuk6131N82QbylMLbfmdUuZf6s0tq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-0bhtHosQP2iW3dhTzsMFdw-1; Tue, 01 Apr 2025 09:30:24 -0400
X-MC-Unique: 0bhtHosQP2iW3dhTzsMFdw-1
X-Mimecast-MFC-AGG-ID: 0bhtHosQP2iW3dhTzsMFdw_1743514223
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39134c762ebso2317953f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514223; x=1744119023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD6tHabuLwNG81tJKtS1hzWrYbj0F2aL9q0asRKe8YM=;
        b=CqXyOz0DUkhdvdL3CShUd/y8i5RPDtcLyqs/Z/eyWd/EoL2gLUHuiYkvzr7ULDosGV
         RNOHnbOSghNdwphP5bzlvr/NqRkkJjU5EGuBoEfvF8bWfA5LkwHloTY9Bp3BZBuZdvUD
         C1hQLxvTHa1Kur9hgPGJL441WUCutRojvDBu+Q6/n7312/u3fbjNNjdHAUwolIbX6J3C
         OPFJs9TEdA3ozIGZUxFad5PkjZ1+e0VjOkfi9M9SKNjzJUH54SIZDwpChL+lf+Y6Jyvc
         Lbz4EdLXd99VTdjiS9hMQMv/esF3OfJh9eiQ2ued+yFiddoZSGl9BmxLwteShi3LqTAL
         /Uew==
X-Forwarded-Encrypted: i=1; AJvYcCWfiiX9QeuM7qTP5EmX1D4H6OhSOWupA4vwu5TbFCObBRjRMu+SyR2Wh9QwSKEi9oESl9UhBqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRCBhnBYLdxHuxImPoIqBBNR8DOqT81NX4XzPTt9HOYEbdLAB
	/m68K/eOraUFyEvq4JXQ4X3r7g3rq1ZJBJqusOOE5gi/QIry1ZZqzIS4xUuLpWxF7jz5DdOI8mS
	QeJjYm3OSFdDHEYBfAllP5uhYP8T47NnxWz5UZeuUl8RdkWMLVnJt5w==
X-Gm-Gg: ASbGnctpFo5bCf7AJYLOiQvRFXEvXtiuyIemPIprfmxo0LwH5RwR3R7g80etWteV9Z3
	x1Z0LZ+4jOaCWSgJaSvFXrpdJm0oM9xxpKmNokGnn2Ia2NlDQ+mbgN2bkt36TdV55PEvG00UZQy
	0+/z2AMOdPHm6WD6nj/zHRrTVFd90mr+E9+g2OUPgrdCuvH1NeCheejUn2q8cygckoaQ3SLXOSU
	1fbofqp+BBWzXq/gaGH3g4umq4aMjCPoIaK9tYXkriocZgmkHjBTM0RMz9luf1KfwoLuXRGTr+t
	xcyG9FGenlVOEGFKecSKRimwlG+FPwtoeGMXYWUQS4c1/BUQPCebtqAjbuU=
X-Received: by 2002:a05:6000:1787:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39c120cca84mr10705801f8f.1.1743514223461;
        Tue, 01 Apr 2025 06:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrXMI4ItLJvlB6UQ12DShg3B37MVyGcSOysd3SaKEAZoFNB9cLMEIrsOQAU4HBuVM/YXR7Q==
X-Received: by 2002:a05:6000:1787:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39c120cca84mr10705740f8f.1.1743514222825;
        Tue, 01 Apr 2025 06:30:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm13928073f8f.7.2025.04.01.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:30:22 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:30:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-2-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:45PM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles,it confuses some legacy

nit: missing space "principles,it"

>userspace app, Therefore, we are reintroducing kthread API support.

nit: "userspace app, Therefore" -> "userspace app. Therefore"

>
>Introduce a new parameter to enable users to choose between
>kthread and task mode.

I would explain that by default this is true, and so we are not changing 
the behavior with this patch.

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 9 +++++++++
> 2 files changed, 10 insertions(+)

Anyway, the patch LGTM with or without the commit tweaks:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 63612faeab72..250dc43f1786 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->byte_weight = byte_weight;
> 	dev->use_worker = use_worker;
> 	dev->msg_handler = msg_handler;
>+	dev->inherit_owner = true;
> 	init_waitqueue_head(&dev->wait);
> 	INIT_LIST_HEAD(&dev->read_list);
> 	INIT_LIST_HEAD(&dev->pending_list);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index bb75a292d50c..19bb94922a0e 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,15 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	/*
>+	 * If inherit_owner is true we use vhost_tasks to create
>+	 * the worker so all settings/limits like cgroups, NPROC,
>+	 * scheduler, etc are inherited from the owner. If false,
>+	 * we use kthreads and only attach to the same cgroups
>+	 * as the owner for compat with older kernels.
>+	 * here we use true as default value
>+	 */
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>


