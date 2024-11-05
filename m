Return-Path: <netdev+bounces-141876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1729BC96B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05871F23B53
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588061CC159;
	Tue,  5 Nov 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah4fEv1r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B31CDA26
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799494; cv=none; b=ijRh4RqqS9ODG+P941Fyx6wZcei89nOBmx46SUAFH/y/hzHVlOsOAZRogY4z8cHHTdckkNY1qZmjlLg3cXx1AHxVxJTKi5G5sOgm0mBLFtdlKUyBRtwxjX7POJXyEW7dvVh4EHl2WLKtHvs9TAyvFQ0vLXBSp7rIU9vgrvHlMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799494; c=relaxed/simple;
	bh=4p4VWrO8uF1H+WyvXfit2++bNDgDMcVv1cZ3lUw+ww4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUgtDxbBMCb/+jfA34B+gk4BF5fWfOowXgGidiwDDLda/8ioRX075JuAUFudIiGUR0BopjAto4F2dqgHUDsul0KeoHbgSfD0F9D6uGNHVfM4/IN3Z+RG96m/UdzCvkVJdqm2nt5CX0eMqx0WFR9zMhEZ60OBhVVRYttoQ+9bVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah4fEv1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
	b=Ah4fEv1rc1QYDJaVjqBTxabdLvmlLdB9akincqbaE9kgucGFtnh8Zu5a3B0btHthCeAb2Q
	zNDIrWsoDMzpA6gO3f2UYbz6B2JZ2p8Gl32zaJv3YYZdVU6Jqm45SVf6t6J1Vb+ZRbjXwE
	wSzbNpI3OZ8zOEg93vgGT7Meacx4PqE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-j3EfUnlHNxG4evfr7cmrPg-1; Tue, 05 Nov 2024 04:38:10 -0500
X-MC-Unique: j3EfUnlHNxG4evfr7cmrPg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7f3d8081c5cso1556432a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799489; x=1731404289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
        b=J1qos3r82ee0nroZF+/kM4lNnIIMHI5ALy8BE8AnR6NcOlN3+RhUqqJWjC7kQqX2eU
         pf5XyK1WxMOnTHvZ/7sE49v3Gh6Nqp3VsEEal80tz3fz75oEOdCxvSZEYyFCL2qkYcmv
         MtJjl/stckCCLcn67EfbK/babCxltOq3IwKfQj4M6yq96xKuR2i5D+Yzh4B5cbeBfKh9
         ZxZ7+oau+EPTiXiBglF76b4gvxG/ZtLAeXKWAQEBcnriiH0tPnw9XDiQ6LdKzxeuMrXn
         QngIsjB69hxdeOM3wRv8HD8MZY30uhrPcjUOJq50KUZpKm2sPFCcZCFvmlbr6N43D3qY
         +A3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrpvfFN39N500H8+NxtKuY3JQpNNu7x8I6iFt3NjGQa8Af+YWfKUzLJG7vW7cI4GXAPbLIAH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYy6gKD0q8FuESSLpNhFMOiDEX8dPF9FvhoKl9w6FkPVTAdim
	heDs+8DG8AGRfxRGKjHD97p0TdA/BqFtlpr9M79nizFM7X8dHseqZeip76hIMEM8lAz6VETyIty
	eZ0e2QHtIrbpD1RsvTK8n7Wtc3kdqcrcNwWGzSMcVpCbvajLsW7wDkM1Io2LA9+6vK7RyiKBoNn
	qbG+kiPAlSfSdjXLt2Gz3yA8rBSGSm
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e93e0ac496mr28583111a91.11.1730799489142;
        Tue, 05 Nov 2024 01:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfBptF6b+UYP/PMKuCsLN5l+Hz/l7bBxZshwZZZaQhmYBx4WQ2HXBLxNHL7GTxTu95PAoJg9Ii6581pMoCwkU=
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e93e0ac496mr28583022a91.11.1730799487601; Tue, 05 Nov 2024
 01:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-6-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:37:55 +0800
Message-ID: <CACGkMEt8XO6AvGp4i6PEoCyL=S5QrGvXhZnBdzjr6CvuxdQpYw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The function vhost_worker_queue() uses vhost_task_fn and
> selects the different mode based on the value of inherit_owner.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 603b146fccc1..8b7ddfb33c61 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -238,13 +238,18 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
>  static void vhost_worker_queue(struct vhost_worker *worker,
>                                struct vhost_work *work)
>  {
> +       if (!worker && !worker->fn)
> +               return;
> +
>         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>                 /* We can only add the work to the list after we're
>                  * sure it was not in the list.
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->fn->wakeup(worker->dev->inherit_owner ?
> +                                          (void *)worker->vtsk :
> +                                          (void *)worker->task);

Logically, it looks better to introduce the ops before introducing
back the kthread behaviour?

Thanks

>         }
>  }
>
> --
> 2.45.0
>


