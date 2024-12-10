Return-Path: <netdev+bounces-150784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060B9EB8BC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591C71888ED3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D092046A4;
	Tue, 10 Dec 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0tsuu78"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECE1BCA05
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853156; cv=none; b=ea/+B08WnxLAS8QVWNywxiIn7JcUQ4526isQkFJnSicyUWwqp12RJs0cOwYMcKg05DOBKu0OAGvcDgllCJ+/+2Pk5TlUAWYt4SMzod+cwFu8zDwUU+rHkDYjuYP80fOh8beAHpJuOhZ7qpRscqBVdl0Ws7HNPIH9YjqvFHTAe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853156; c=relaxed/simple;
	bh=jxM8Oak5FsSIuUdETeAfc41H8506k5MRoOUV/v8nVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lov8nWHJ+tAOZDjEkgOSgjtuaCbghvz0cwFtCHZI5jfsXEOvO8KjQsE3H5CO7LieeX9wSy7gV1RWZyJSHKCCDgDYuWOPSANTgCoO62FeWKGa9RSmMP8FHzMBqJ7CxmNygFhYJJFfPKTYoosWKzmymt5Vew5vE3B0qVTX1twTRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0tsuu78; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
	b=a0tsuu78D3jUtcmMzQH6U7qRj1h91uZQUfly3LDyZKdM1QeZpiX9B8+dggcQ9wGfhEk9rg
	h7xIYtRLhtqBFy0y4TJyWbBt+YjDApn1MlE+sM9lx0J/bLMpYtUzVo2rxrE5J+QDKyCMgy
	Wx8qz7fYaTGPuv1fAI7t6o7sw6cys1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-cqXcnCaIOqyh5f7i8MGbhQ-1; Tue, 10 Dec 2024 12:52:32 -0500
X-MC-Unique: cqXcnCaIOqyh5f7i8MGbhQ-1
X-Mimecast-MFC-AGG-ID: cqXcnCaIOqyh5f7i8MGbhQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434c214c05aso46174765e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853151; x=1734457951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
        b=uaRtlkyHahgK6/x2gayOBwo1Jegm1qlikHpKPfo4R1bRc175X9Gxauh2NP8Xy8PIbr
         8uQPd8scbZUuDDkPVJxXTFTB37CELcLNAQpXgypAs7YthMCcvMnCPoFVErAQ1PgCQYAf
         F/4jjpVccnWFHcnOlRyu3PhDdcAHURmb8gSk1VriKQcMU5p3vUfRM7iEBcagjJTUeA2S
         YnFLREplVSuvsq4MGV6Uj8ctyYMNcjZJvbv3rJFsftXnSre9OXR1p3sxFFsZo1fSLCoG
         S6XZn2bDsUaRGJP2Z1n1TYc4zuRrau3j4nNFpzBAaTMn7bIcPpELrsmAz5vLqz059Lcy
         9Y8g==
X-Forwarded-Encrypted: i=1; AJvYcCWvcniZzumzSsXxxoKerE/kiPiHRe9izHr/IolUhYEc3gAbXg9OxpANW4t9rY7NGMqtqbI1dOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGiyUMYcp0dA/JLCuKuzbKN+VXXyOTAxzxNJpRPcXa/JsoyKK
	dtC7IgLchaMo6COx9k8PZLII2Jp3vw19XMkX7Gf3KYjXhpehXg9RbuyuBPuMbt07ukf6byzRwV2
	Goaq0TDi76Ob9smzNZNOA7JQPGIHk/BZjwHfx5bL0V0v1l0XZPxjzmQ==
X-Gm-Gg: ASbGncuF8ZJPEIS8p1jRhmJ1FDBX+YCk2RwgSekg7qN/EPcdlilAzohIQZBRvSHQU0y
	Zi+jKiY3HKrBSVSSA6Mm1p/QREXgUNW0NlaClKrGSjndIWd9lc0SOtiuaTR56nt2oLSyOQC+umj
	1DSJUcBEBBM8MFAhiTQKNspTMjU6GES2XDE+Gpf5SOuYJVdC3aUf+O+Yef5/ttWFnTd73+ziQ8u
	wr9N2NxA8GItIkDnmVJ9gY0/oYbKhJqUrtYtuepZae+3y86OUzA+qHP945BQAOq4X/MEbOgbJjt
	/h4ogKdL9V0Wz6KqFtoFAxyBYDd/pA==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73407065e9.32.1733853151443;
        Tue, 10 Dec 2024 09:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6Om4hYhYhyD9qJSgoZ3Z6qXK38YTr//I5hZ9Q1woRRwaJmZu4m0F7M5ZzfAHvZP1EyN1sw==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73406865e9.32.1733853150834;
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3c96ca2sm99608845e9.24.2024.12.10.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Date: Tue, 10 Dec 2024 18:52:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-2-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:40AM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles,it confuses some legacy

nit: missing space in "principles,it"

>userspace app, Therefore, we are reintroducing kthread API support.

nit: "app, therefore" or "app. Therefore"

>
>Introduce a new parameter to enable users to choose between
>kthread and task mode.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 1 +
> 2 files changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9ac25d08f473..eaddbd39c29b 100644
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
>index bb75a292d50c..c650c4506c70 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,7 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>


