Return-Path: <netdev+bounces-179528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B5A7D789
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F236188A83A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34225229B21;
	Mon,  7 Apr 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPGqhr4N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40829229B18
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013836; cv=none; b=WY7DtGGPqVWlmwm465O6CvCa72RWZweULMtsV9YFAZIrP2MPfYE45WPClrFoSyoVw6hzuBfv7E/VpwMpKCo5CK1blWlG/YgUIjGtxX96+Q2OK/4zhe5CykH02Di+s37xdOy4sKPewupSTEgWZKNjRBveXKFoHwXOP2pR/2dG2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013836; c=relaxed/simple;
	bh=mSjUh8N/O5w5UJDg+QA0tXXjTVKD7/6jJkNLyw45Ceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FACHDRBS5bD2ufzdWtHukvjQmS4rDu+UQ5DTzO9IeMDwgl1zBqaby8DVViEo8HEupEpKPyX92UidIwQARlRvRDnRvJuEDi1oeyDDdlwnFmeAMcX7PUMgKybTOWHL1Wzfbce+jBQrysnVefHuUy6PPH4tgdIoHaOsKFfSRc++sWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPGqhr4N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744013833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NXeUmz6sFdPq3LVWzGbgGpd+TscgMz224LBsRMb8cc=;
	b=KPGqhr4Nm6FWa5DisL2S1XxlYiaqlaCTHBi+5OUihHKpCVZjPHKSfk0kgMBkP23GiVNHfP
	uwmSsDBJ3Kr96V7yXLegsg6fxq6Fk4hx+yFSgYEwnGgXNF+kLMY7wjNj4yd57ftIb1gSl6
	nDT+ppHYx2pDt3/5A2G732inqJ/uWFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-hyaicLffNEeJ3dOLJEaaKA-1; Mon, 07 Apr 2025 04:17:11 -0400
X-MC-Unique: hyaicLffNEeJ3dOLJEaaKA-1
X-Mimecast-MFC-AGG-ID: hyaicLffNEeJ3dOLJEaaKA_1744013831
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso2090143f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013830; x=1744618630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NXeUmz6sFdPq3LVWzGbgGpd+TscgMz224LBsRMb8cc=;
        b=uRHj2AxphHJis+5syUmtSfQfEi3ErkffTzicXzNK2b7h1MIjq9sDQ+uEkZnV146z0U
         R6XcoYb4s/o880Zh/fnKX+rHrKm1j00f7qTaaucf/yYi3MZi1a3JO+Rzy3Y4kSsN1Y2n
         bnRpN9NNlk9qy7KEgq5e513TgpkC/mjhmYLyvQuIhXQqguGbUDsFpoWk5tkQuK7e/A5O
         clq/AZN0vrmgO/5ZTMYdNnXhT+e1hnTD30AvszvRebHF72Gfqv1g8Bf4gF2BTmllu5SI
         ZeRdmy4B5a/PVyKd92plEFJfYyWgQyNx9xmzX81wh7sFrvFpr1XozhdUf/ppCkEUOdMN
         Oyyg==
X-Forwarded-Encrypted: i=1; AJvYcCVjwvAiB/arZ/RWcU6im+UE/vgYpfqliuWSxzqY8Pq2/PfsiM+cdVfPkNAEXDs2en50IgvQP0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUi4a1259MbesZrc9P7Z+tIA6GFZ7qLQmTN7PcldCgSEBJQP5
	rGecNWq04gxodPrVlkPsFj735FGcoWnHdGEYONn6+r9c49aYfl08cGwQEG9qaWkEw25T3XFPkXF
	xktK0aHQeAauL9fYzVPIWmGp2GyVI5BTvr1RBfd08a9HJ1H8Y7Zc0Kw==
X-Gm-Gg: ASbGncsaoTARqbGm651fXedhVPvnXeI013tpQWUYmMF74y2SBbaa9w1iuV6Ga4p1JQO
	qYzno9A1SgIXlLh1QCoDQ667W6RnTNAYnROdsXwxXOEganUw4gpMt4OXK3xj4UZ/DWkvqSHqlqq
	JcC/aoyK1ImiBVJO3JDwzQbgt4BR1DZyiqLkfqPyO+MHhVxY3VA1LOLk1EZVwD0eMH8OW79jt6K
	uA2sFV6VEwudR4PiguJTMJwX7XL5RKOkQiRtPrAZ8ryqIkZhbxUbDUQRHyM67w3PL07UWmowqsg
	aVKRc9m0kg==
X-Received: by 2002:a05:6000:2505:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39d0de12ccdmr8771258f8f.16.1744013830506;
        Mon, 07 Apr 2025 01:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwOTqjbMc9o3iiqXoVsN5aZIAS84q095cDwnrD0zTHjtFAU1Yzf7ek1qUTjNU8khKKwtAHAA==
X-Received: by 2002:a05:6000:2505:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39d0de12ccdmr8771226f8f.16.1744013830045;
        Mon, 07 Apr 2025 01:17:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968cfsm11484116f8f.16.2025.04.07.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:17:09 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
Message-ID: <20250407041540-mutt-send-email-mst@kernel.org>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-5-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> Abstract vhost worker operations (create/stop/wakeup) into an ops
> structure to prepare for kthread mode support.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I worry about the overhead of indirect calls here.

We have the wrappers, and only two options,
why did you decide to add it like this,
with ops?



> ---
>  drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++-------------
>  drivers/vhost/vhost.h | 11 ++++++++
>  2 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 20571bd6f7bd..c162ad772f8f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &worker->work_list);
> -		vhost_task_wake(worker->vtsk);
> +		worker->ops->wakeup(worker);
>  	}
>  }
>  
> @@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>  
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	xa_erase(&dev->worker_xa, worker->id);
> -	vhost_task_stop(worker->vtsk);
> +	worker->ops->stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  	xa_destroy(&dev->worker_xa);
>  }
>  
> +static void vhost_task_wakeup(struct vhost_worker *worker)
> +{
> +	return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_task_do_stop(struct vhost_worker *worker)
> +{
> +	return vhost_task_stop(worker->vtsk);
> +}
> +
> +static int vhost_task_worker_create(struct vhost_worker *worker,
> +				    struct vhost_dev *dev, const char *name)
> +{
> +	struct vhost_task *vtsk;
> +	u32 id;
> +	int ret;
> +
> +	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> +				 worker, name);
> +	if (IS_ERR(vtsk))
> +		return PTR_ERR(vtsk);
> +
> +	worker->vtsk = vtsk;
> +	vhost_task_start(vtsk);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0) {
> +		vhost_task_do_stop(worker);
> +		return ret;
> +	}
> +	worker->id = id;
> +	return 0;
> +}
> +
> +static const struct vhost_worker_ops vhost_task_ops = {
> +	.create = vhost_task_worker_create,
> +	.stop = vhost_task_do_stop,
> +	.wakeup = vhost_task_wakeup,
> +};
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct vhost_task *vtsk;
>  	char name[TASK_COMM_LEN];
>  	int ret;
> -	u32 id;
> +	const struct vhost_worker_ops *ops = &vhost_task_ops;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
>  		return NULL;
>  
>  	worker->dev = dev;
> +	worker->ops = ops;
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
> -	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> -				 worker, name);
> -	if (IS_ERR(vtsk))
> -		goto free_worker;
> -
>  	mutex_init(&worker->mutex);
>  	init_llist_head(&worker->work_list);
>  	worker->kcov_handle = kcov_common_handle();
> -	worker->vtsk = vtsk;
> -
> -	vhost_task_start(vtsk);
> -
> -	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	ret = ops->create(worker, dev, name);
>  	if (ret < 0)
> -		goto stop_worker;
> -	worker->id = id;
> +		goto free_worker;
>  
>  	return worker;
>  
> -stop_worker:
> -	vhost_task_stop(vtsk);
>  free_worker:
>  	kfree(worker);
>  	return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 19bb94922a0e..98895e299efa 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,6 +26,16 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +struct vhost_worker;
> +struct vhost_dev;
> +
> +struct vhost_worker_ops {
> +	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> +		      const char *name);
> +	void (*stop)(struct vhost_worker *worker);
> +	void (*wakeup)(struct vhost_worker *worker);
> +};
> +
>  struct vhost_worker {
>  	struct vhost_task	*vtsk;
>  	struct vhost_dev	*dev;
> @@ -36,6 +46,7 @@ struct vhost_worker {
>  	u32			id;
>  	int			attachment_cnt;
>  	bool			killed;
> +	const struct vhost_worker_ops *ops;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.45.0


