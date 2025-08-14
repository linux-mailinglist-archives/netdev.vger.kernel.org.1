Return-Path: <netdev+bounces-213842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91527B27072
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FD05E089D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28A273D8B;
	Thu, 14 Aug 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XnxdYUoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D7266B59
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204993; cv=none; b=L6aRwKP8euxRHpby05pS0vKDoK2CFMVMNNNPqriorZefqRFkqS14Pltvgstq9VZuLQVsF9ajCkp3GOMSOMCEIWIn17rK8WuraTzvYtywYwexerzBJtTNA3GRMZQAOnwx5QaORMDVljnqMOuvmGjH0Z3UAHssiJSByufqHqFLr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204993; c=relaxed/simple;
	bh=j6JPZONw9/j0dLXlcsyc7hoC6rAkX3Y3VABybTvHwIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svndvts0FgUcAIXjUTHsaH+WfoUgrPqgxkMsufWc1DSH+o5ttwrjog9VKFFm7t63vbChJhhmjNoO1v0mdTbJH4ywU4Z01treE5JMYZZvJgzUsivKA+UIm/haXMMYTGMSRnV6QD8DjonHKVPYeTRD4cOYH8KUsgZSGjCctPPXDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XnxdYUoD; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cceb749d7so542259fac.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755204990; x=1755809790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCOW4bsDUhYI0x0xwfM8hqboWSnjWIjYYmU3Is7O8PQ=;
        b=XnxdYUoDyBUiFKfS6QOLN7NrHV7sLC/qFpcJo+GkdcmOJQPQcuy7P2PDdGYnVqXR3k
         N/3Q9yhhf8iM6/spnEf/n2rIHxxnG7D71sakc9WxY1W40E2mCUIcajS22EmNw5P30vHd
         0/Hr8qpxPhfS3Jxz22LHMHD8MlAhVEwkdqO2oqFEMOricBbGVbZiErWeAF9pNDqCPJPA
         A+2Z9k8YIiFRoT0XzbJTf02sZSeqLgpfE8juGFU8DqoXD+oqcWsBBKTVLj/HZbD4vJwY
         mPH2vb9/nKkbHtWuFf7b2djXtXxNRch+xKstxs6xgzG43aEriily2pt80eDIcf4CATxd
         XJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204990; x=1755809790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCOW4bsDUhYI0x0xwfM8hqboWSnjWIjYYmU3Is7O8PQ=;
        b=OAXXrjVb9KfafuyKEsL8W4WdAcT1yI3XH8bj9K/RlmVOODwXlLQjfh06fF2OhWLkh/
         UGBEXOgWg7KYVXYkg+fRJ9cJnGJJS7TIggzpXnYPsEr76u8QUlE/wcGwNyMIOBG7dlgt
         fI04S7GS2SrzrVplF+tCH22qHvuExPY3IfUQAZKzh7vE2f1it3uzAPjGEtOyH3eZp8eD
         JPMHgR/J/HI3/LRyrLSq5VeJntLo/I38tmBhPkB0mUffJdtYuVzLryCLhvOaliu7lYeH
         cRVXeG8/AYbl9L2cRYzmljTeCxHUcSpzW8CsZ5Jpt4RBwecu2U8pxjyu0V9Yrev77EoM
         uZlw==
X-Forwarded-Encrypted: i=1; AJvYcCUXn5hP2noumYsoUNMddw4H23/h4+NKGnjbWS8R2XnExjsYm8M9Q6dNsCHsxdT72GuCNRrXnBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvwzhgc3qxvf/9u65Sqb4ROUMcVxqKXccVNsYlVSxBUj+k4PJM
	tddaad5YP3t9E1+iUlKArOEKmjVE2sG1yNnZH5tgqZZb2PE2nY0PFaC5Xz6J600jjNBAnYCod0X
	PNnNVjmU=
X-Gm-Gg: ASbGnctP5CmgvTkeRnx8Kt7U51sNgo69AnWMGAA8ELCuDuLofRv2PE3G9BC4GpGNC3z
	/SLnrcN9yJ2jiGRQQU/R6OAYOnBIJbm0nKIpuWw5+wtkNy4Sk3oLKMm4bUiLYa0xy72XaGFTaXN
	XiJTFZaA+c9kNPWnFAJe+J7c2UbS4wZqGZsDgb6gTyVeiyYHHGoADsSjxJCNz2v9jbWioaJq/em
	N/kpHfH/xdCDtkUMurZMo5wX4c2QUb9LNta9FxVOJCXZu9vKC0G53kgEOLFYZGSfYPvNg62WVpP
	3JXIlQ9SM3tw6BGU5jHqfIFinjmhN63pMV0JQ1+14t1XyQSCnHRt8JMjGF1k1O/ffPHD07mQ1if
	QIN+j
X-Google-Smtp-Source: AGHT+IFfrlqwWeK98t7G2HWzL4XLwAjvfYLspD0bNCez3QfcF5IqCjUnVUbYVJkKThNj5NayL33EmA==
X-Received: by 2002:a05:6870:8926:b0:30b:85e1:d3ea with SMTP id 586e51a60fabf-30cd12e313fmr3030460fac.21.1755204990536;
        Thu, 14 Aug 2025 13:56:30 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::f:384])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30cd00ddd98sm895032fac.18.2025.08.14.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:56:29 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:56:27 -0500
From: Chris Arges <carges@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	dtatulea@nvidia.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, tariqt@nvidia.com,
	memxor@gmail.com, john.fastabend@gmail.com,
	kernel-team@cloudflare.com, yan@cloudflare.com,
	jbrandeburg@cloudflare.com, arzeznik@cloudflare.com
Subject: Re: [PATCH bpf] cpumap: disable page_pool direct xdp_return need
 larger scope
Message-ID: <aJ5Ne4U2nLY5DmCL@861G6M3>
References: <175519587755.3008742.1088294435150406835.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175519587755.3008742.1088294435150406835.stgit@firesoul>

On 2025-08-14 20:24:37, Jesper Dangaard Brouer wrote:
> When running an XDP bpf_prog on the remote CPU in cpumap code
> then we must disable the direct return optimization that
> xdp_return can perform for mem_type page_pool.  This optimization
> assumes code is still executing under RX-NAPI of the original
> receiving CPU, which isn't true on this remote CPU.
> 
> The cpumap code already disabled this via helpers
> xdp_set_return_frame_no_direct() and xdp_clear_return_frame_no_direct(),
> but the scope didn't include xdp_do_flush().
> 
> When doing XDP_REDIRECT towards e.g devmap this causes the
> function bq_xmit_all() to run with direct return optimization
> enabled. This can lead to hard to find bugs.  The issue
> only happens when bq_xmit_all() cannot ndo_xdp_xmit all
> frames and them frees them via xdp_return_frame_rx_napi().
> 
> Fix by expanding scope to include xdp_do_flush().
> 
> Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
> Found-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  kernel/bpf/cpumap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index b2b7b8ec2c2a..c46360b27871 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -186,7 +186,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  	struct xdp_buff xdp;
>  	int i, nframes = 0;
>  
> -	xdp_set_return_frame_no_direct();
>  	xdp.rxq = &rxq;
>  
>  	for (i = 0; i < n; i++) {
> @@ -231,7 +230,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  		}
>  	}
>  
> -	xdp_clear_return_frame_no_direct();
>  	stats->pass += nframes;
>  
>  	return nframes;
> @@ -255,6 +253,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  
>  	rcu_read_lock();
>  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> +	xdp_set_return_frame_no_direct();
>  
>  	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
>  	if (unlikely(ret->skb_n))
> @@ -264,6 +263,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  	if (stats->redirect)
>  		xdp_do_flush();
>  
> +	xdp_clear_return_frame_no_direct();
>  	bpf_net_ctx_clear(bpf_net_ctx);
>  	rcu_read_unlock();
>  
> 
>

FWIW, I tested this patch and could no longer reproduce the original issue.

Tested-By: Chris Arges <carges@cloudflare.com>

--chris

