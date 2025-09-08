Return-Path: <netdev+bounces-220892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B0B495E5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488573429CF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1030F93B;
	Mon,  8 Sep 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzkPqdRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF34221271;
	Mon,  8 Sep 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349854; cv=none; b=A5Yad/FWSpG1fzZTTakUxmyVWT6wjb5DZQyYvYrkSbCtlSyUgSmavUJ+fgvFzsAAqenVwBqDBYUTAQKLTqbxgEyQ5VWrr5y+uMajTiz8kA/7KiWeCe3+L4NTxoW1B0RlfpyKFZeUpIzKsS+N5Qebeq1I0rMr9Hgvt3HiS7VTx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349854; c=relaxed/simple;
	bh=c6RDo+MvvWy+hWXeayW1XjeBBC27GldxLu8pw/RdIQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL7AveGfuIFw1dtQyOQXNxHlPE490PiDnxLqXNOVne3tplmJyB21rJPX7uRoQfGy2M8KGm4pkX/2bzXnPYUpf2+pZ4vf8hvWj1+y/Y5S7t8uG+ogjlX7NlXLb7ToNhcQ71K1K2mUZBZHchdPCtx7RNMLBEwFfDOyhSPt+hU4/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzkPqdRL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60528734so36676507b3.2;
        Mon, 08 Sep 2025 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757349852; x=1757954652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wr34sNpRK9Vrc9Y5AeoZyDXPdh2Xa7V3XI2jmbZrnjQ=;
        b=jzkPqdRL6y7IRpaWI55X/y8Lbm40xRXnu3SUdTUxntHUb+8hR4nx6c7Py++lznXlZ7
         d3DH74ajlApHV34CS4KZR6xdd3/OmUngnum8uUnssu6SGfFloilEcPLQ3UWUD+uKAPdD
         cUcHTs2/FDjt/sCKv80vZIuCBNrpN621rzVw4ZnwIxStVG6cNIHw/5+yhbPS1m5EIlnO
         rV6nke0GlQMPxBu3cairl+6GzwfCQ1ecaHDVs6U/uREnbyiBn96kMeX9rzwIGigl4JBB
         cFqPGJidVXaEBAePaxRcbYK9MuZk1yi8EBBD8UGJPwoMq2M0gyp/0wd2K2AQFBF182TS
         CdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349852; x=1757954652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wr34sNpRK9Vrc9Y5AeoZyDXPdh2Xa7V3XI2jmbZrnjQ=;
        b=aF5UJ6cyLXTCLBBNRYy3ate8mKVCM/P44K9WYJKJHu+2fHmgbC78D0M5PQTENkEyZE
         drbwJh3HMt4dIDTs+tOs9c8JKP4tDjI8Sqdlr+rIsI6YS5efeOAZAWBsd9HN0uwmEsX6
         IKdA7VKZ+c5Zjo5RTbjnnyUlhC/DA1KpcaHOdeT9lXjafebUmfEPQGLcROxVSqVk9eYi
         7eDxpSPZ8kwfQoT4EcEgTKfLub1rgxkvahzDlWBNvzbidzz7WfyPAeRMkzmPNBALn3q6
         0OEmO6FmN4y1psKyTsQp7QISdmf7t6VPJzvdYR7Sw4qcKB1juiNBUw5QamOTI7W3XiQ2
         qalg==
X-Forwarded-Encrypted: i=1; AJvYcCUxn/xRjiBLLnSrIvSNQ3cvya/3v9u6L8WIyCPrNwK3dLt2JgfkWFlc4dPSVtIZZpN+qeD8FTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19MN4ALMjWkRkYuY6Bma3ksSgIdkhggpC8j7kAvoc6Ggsj8Pp
	nrw5jduWamC684InqsVN0gXnhR8+kku3Grz4Ir2ZC2O+iergU7IcIkgA
X-Gm-Gg: ASbGncvOzdfMUCEyrsHQ/DM4woITPMCi8Qp7AgqZP0XQeYjM9pwgMzM2XL26jJYVWMd
	kjxUi4n6nge2e0sVFjX5Em94zAn0KgAgdRgwRIEXu47URz8e+Xw76OTX5dO5CQCpH1q5529AMBP
	bpCxWNNFyORn5qgO6uAtVzM5lknE+sXJnoqIsJOcmgW/uOoJL79ibfEdpitf4Lvho3RUPD8P2Pn
	ONhUUOIYLSKxtkcsmZD20acX04MlR8desIOqsQVs+pOGkO2petxeMdgVVRNiSn+O75yAzuXGZ5u
	hOSfIGGOFk+HtelbJEs6lcQnUd34EYl66G4W5fKDu87l57mg4CQ6OCwZ6uUGo6FwrvuTzH1ZEZb
	ZvuDLMUxb2a1wKHBkoShx2S8Q50k5czuknCp6rILoWAnb3Q3XDUFLcFdP
X-Google-Smtp-Source: AGHT+IH3/Z3zS36W8LjI8s02PyQGn8XTxF5N3xxUa2cDq53wbgUDrDDcGIGoTBlL6XKJlDi6cFE6ng==
X-Received: by 2002:a05:690c:4b0b:b0:722:8762:9d10 with SMTP id 00721157ae682-727f368a842mr84176087b3.22.1757349851580;
        Mon, 08 Sep 2025 09:44:11 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8552a82sm53212687b3.52.2025.09.08.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:44:10 -0700 (PDT)
Date: Mon, 8 Sep 2025 09:44:09 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue
 users
Message-ID: <aL8H2VtN2dw1a8B+@devvm11784.nha0.facebook.com>
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905090505.104882-4-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:05:05AM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This patch adds a new WQ_PERCPU flag at the network subsystem, to explicitly
> request the use of the per-CPU behavior. Both flags coexist for one release
> cycle to allow callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

[...]

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index f0e48e6911fc..b3e960108e6b 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -916,7 +916,7 @@ static int __init virtio_vsock_init(void)
>  {
>  	int ret;
>  
> -	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
> +	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", WQ_PERCPU, 0);
>  	if (!virtio_vsock_workqueue)
>  		return -ENOMEM;
>  
> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> index 6e78927a598e..bc2ff918b315 100644
> --- a/net/vmw_vsock/vsock_loopback.c
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -139,7 +139,7 @@ static int __init vsock_loopback_init(void)
>  	struct vsock_loopback *vsock = &the_vsock_loopback;
>  	int ret;
>  
> -	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
> +	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
>  	if (!vsock->workqueue)
>  		return -ENOMEM;
>  
 
LGTM for the vmw_vsock bits. Regarding step 2 "Check who really needs to
be per-cpu", IIRC a few years ago I did some playing around with per-cpu
wq for vsock and I don't think I saw a huge difference in performance,
so I'd expect it to be in the "not really needs per-cpu" camp... I might
be able to help re-evaluate that when the time comes.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

