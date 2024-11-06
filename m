Return-Path: <netdev+bounces-142564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774599BF9EB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36545281DED
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABB20D4E0;
	Wed,  6 Nov 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bqyLoLId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721501DE2CD
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935465; cv=none; b=O4FO7RI/iVAu9WJuLiy7K+EL+bcRpeHP14D8RX4vtx4ZFH9ffcoa+NX+MIuj6kYxXyAIWgSmRGK1fWZNnBkOTw/FGDF6HmjK6tvcv1aemPiz59Ld5eRptvEPHi4rQm9U+9n9V471efEqMlBqXWz95hJ5u6uV12J1ZuV7e5mqiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935465; c=relaxed/simple;
	bh=1ElPWqQTpgh0MjxYAipqt0Rh6P9ozWBIBags1rw9Ulo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n42qlc7QSxeuw4FIozzS1E7Qc0eAa9YgvCg/3j3oBbeWG77Wb4pVu2c03/MMRNAsxIKcUKxReD0XkO6WAyoL9Pkl5+y6nQlJuoPbg+0dI3SiXYS5MI8AUJjLRn7pgQxesZBzN3ZvcMIz6J4HmCMgRiBOhTzsBTELXdPlyr46Gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bqyLoLId; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460b16d4534so1981741cf.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730935462; x=1731540262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8uxnrcOwKifkarVHZh48p269SqKXVupbsayYJfQgAA=;
        b=bqyLoLId5UFb0fk036HnZnRpC56bO8gfjXVxBnfAoDibbSNg+F37TNG0zL1aw6zPqb
         w2qnYM1BCWwKHuzgRzMc1ELkjd3zsiSQlM4cGXkX7xiZsjTLQW1e1BI2MfPH8j1g6e27
         jpy4NCWhLSrGpIiV08AuBUWvnzCr6I8kLMzxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935462; x=1731540262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8uxnrcOwKifkarVHZh48p269SqKXVupbsayYJfQgAA=;
        b=BgiGKO2nTiQgauPWTglb1eZWykflMWKZn/u7yoSL9yAxmj9DBzuiTyjY8uBoR+WpYo
         OFvct+ta2Rr+pX+cctwY6JuUhpNCY71xmg0dRJTlORjtpH3tnLgcCb0IMvu8FMM1DoRw
         3QKVcTHKaTnq457gaUFJ9UXm29zffS2T0DwdQ3lESqfGEYFMc64Dft9BM5Yp1Gcpppbn
         gcuA/6KDsWWZW3XRdsvStq1xFUf8Jj5G3b9WyDScr5JFc9WL9q61bfqtDlQToPE1udAw
         5YR8Rt8bjnEGewInGT/QqG2yQQ1iZAxwqbDYQKRaTPARbYe2HA8z9XnaqxNn+FmOl2hH
         d8Pg==
X-Gm-Message-State: AOJu0Yz+a9vvBKyCPZyQZ7J5inK66cJFzF63J+n1QwhxGEprdTvn5NmI
	KWF6mASxRRd5KRb9Lx0ZIOtoSzSqKVIb1ruDbIqfVabc1HZ1ZZ+pmtD9p8J1bw==
X-Google-Smtp-Source: AGHT+IFXx00yL8MXEioceyI6AFnT20/LFsr0fhoMsjU1YFDXGYK5QfiOdSAFhXlqe4DyhmxMi/X1WQ==
X-Received: by 2002:ac8:5f95:0:b0:454:ec22:dd79 with SMTP id d75a77b69052e-4613c046d49mr642303201cf.24.1730935462405;
        Wed, 06 Nov 2024 15:24:22 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm323961cf.15.2024.11.06.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:24:21 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Wed, 6 Nov 2024 18:24:13 -0500
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, skotur@broadcom.com
Subject: Re: [PATCH net] bnxt_en: use irq_update_affinity_hint()
Message-ID: <Zyv6ncZSVR5mohsF@JRM7P7Q02P>
References: <20241106180811.385175-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106180811.385175-1-mheib@redhat.com>

On Wed, Nov 06, 2024 at 08:08:11PM +0200, Mohammad Heib wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
>  1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
>     order to prevent IRQs from being moved to certain CPUs that run a
>     real-time workload.
> 
>  2. bnxt_en device reopening will resets the affinity
>     in bnxt_open().
> 
>  3. bnxt_en has no idea about irqbalance's config, so it may move an IRQ to
>     a banned CPU. The real-time workload suffers unacceptable latency.
> 

Thanks for the patch.  This seems inline with what have been done in other
drivers.

> Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 99d025b69079..cd82f93b20a1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10885,7 +10885,7 @@ static void bnxt_free_irq(struct bnxt *bp)
>  		irq = &bp->irq_tbl[map_idx];
>  		if (irq->requested) {
>  			if (irq->have_cpumask) {
> -				irq_set_affinity_hint(irq->vector, NULL);
> +				irq_update_affinity_hint(irq->vector, NULL);
>  				free_cpumask_var(irq->cpu_mask);
>  				irq->have_cpumask = 0;
>  			}
> @@ -10940,10 +10940,10 @@ static int bnxt_request_irq(struct bnxt *bp)
>  			irq->have_cpumask = 1;
>  			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>  					irq->cpu_mask);
> -			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> +			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
>  			if (rc) {
>  				netdev_warn(bp->dev,
> -					    "Set affinity failed, IRQ = %d\n",
> +					    "Update affinity hint failed, IRQ = %d\n",
>  					    irq->vector);
>  				break;
>  			}
> -- 
> 2.34.3
> 

