Return-Path: <netdev+bounces-224492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55CB857E3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3ECB631C0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFE30E85C;
	Thu, 18 Sep 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbjL9Her"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC530CB58
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208154; cv=none; b=S8IY7HHa61SDkJEfrVNzSkDymcLyHlWnwGkjamo/Hm2SUuU75iRbSr93LQQrJjncqiFVI8KK9Ab/wO364vP9CAhqBQEtWUnYu8vq0vZx6yk0/oa6pgtEDbaExiCGFvvfYl17RUu2+MC5TNhjr6BCuzE9UjTObqo3jC7e8zPPhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208154; c=relaxed/simple;
	bh=48WfDspnNYYwY+nqsrybAAO10uUojF00QMRofRzWMNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxHYBjm1ilG/F5tYOw55dl1oNwPoArLLJ4eH7ZqcjVZtYOQ91J4B5SV29UWsn/qa2qbV8LIXFqU+6mWPhTEOtA7WtwxXu3ZVT4b8lE9vd3KSjvCWuVpnNEuzVoINmxt6wukqb1PMOnSEwe9gVSYMcAAdv3MKW6p+Az70LZSA+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbjL9Her; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758208151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
	b=CbjL9Her5yuI5edkX7ROGHGFTq0qx5K0LDnUBUY5j368MEszgg0Zf3LmT5AeBBgZX5I9BK
	y8GC9uw6fOPYUiQiCESOkpAPbdiMPGOTDBsh2zz5HWjuQYNjw6zfVZTWUnKEqBVtjQyTPf
	4Sm2qyqCkT/o51h5hTfLWsoZcPXaM+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-TKIyD-e8NJK-lzUJ4Go5OA-1; Thu, 18 Sep 2025 11:09:10 -0400
X-MC-Unique: TKIyD-e8NJK-lzUJ4Go5OA-1
X-Mimecast-MFC-AGG-ID: TKIyD-e8NJK-lzUJ4Go5OA_1758208149
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so7729455e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208149; x=1758812949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
        b=JB9CCvK7yS/x2VQ64NsMf9dxOlz/tJ3t+fgvNnE4oS4Oj3O78RArrI2TGznOsPls6T
         pxgCyCqh9ir3+ddX1gatIURd4ki72rS5eOc761LOqPOKZIi9B/7vMkZ9gwaKGcCiU22x
         b2MjEQPpFNzZtHWHArWBU0qi+H8WxIy662tSLKbAp69F5M3EnK7V5VPBF4uoc+DpZHZn
         D0L3xjaAG1JIRtyATMrtFdgg358Mfy2mFDa8VECJsuTcWtUWO1nWSKfm85cYPzKWl9dp
         H5usLJFvWQ01Vh/M49ymFwPzkmLPxcLGQWv1xjfLpAWSeyn7yBekNW2+2++1OQmM5W79
         u7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXL+FgKIawyyjnXfg2Lt8PNq63LoSIdgS8DVu97xgf+K4IVWY1auVaWhy7bqwAnUX0uEtJWgPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3u4Ra9/Mgu0D9TMx3cKZ2YrmJfWZH5Ndae9wc/0+tANM1nh7
	8g6tS/RnAM5l2tZwL6l1VdW49EhtsH6QI/oLte+hNb7CjR+mJgbYIxXvOHtXdIRhzbrEHLwl+iK
	WejBN9q9b1+uGvL+GuvwC4en7s8+Ile7hHqHg2d0DDfbhsHY63XJP0J9USg==
X-Gm-Gg: ASbGncsuV2mSyzDdCNTVquzIE+5+fvg73aZCoVFSh+BLxm4uGVS0jR2MGqlywm2qAfM
	7rs60mxJ+AOb4goeMcw0m2fBV2j4bH8Js7a68r9/dxKnBk2S+Qr5gZspWB3Nv3R/oI7XVeBszGi
	9470kQxC5AW/joYt9tmjMLlAXA8Bpcp78yDs5KSPZE39GJdicLpWZx3amRrTQbpSDNvbF8yz5g1
	cxeLrM8lJ8L+m4TShpvKbUnog5VbYT01dRzHpe7CVQFtjGGmJPcaCBC31tjXiFWKZrj0Urd+H9e
	YQo3WZ0V0UkP/KsTcUbufxOZxFPgvbgUPms=
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240875e9.9.1758208149050;
        Thu, 18 Sep 2025 08:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pxOb15HbXf6kQkik0F3fAf2Q1845KsjAT75QUOI8d0zEUi3a3iP8sUQbUJhBuS6AvT6fxg==
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240595e9.9.1758208148642;
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm52209105e9.15.2025.09.18.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918110828-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>

On Wed, Aug 27, 2025 at 10:10:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
> 
> Sean,
> 
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical…
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  		return ERR_CAST(tsk);
>  	}
>  
> -	vtsk->task = tsk;
> +	vtsk->task = get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
> 
> Sebastian


So how about switching to this approach then?
Instead of piling up fixes like we seem to do now ...
Sean?

-- 
MST


