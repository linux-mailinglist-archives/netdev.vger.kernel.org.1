Return-Path: <netdev+bounces-151896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54B9F181D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51198188C4AF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D5192B84;
	Fri, 13 Dec 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bGGlbvjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AD186294
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126154; cv=none; b=Tqk4lWtCh2uUCilEMJjKCR5c7dm+udN1nXRYGCvkQZbZhAC7w6HvH7ISUL6ww/5KZkrb0AdU35a6upmsxFCjysAZ5/7WeuvEjHFW5ie9woHisEUROARjBI2DCRtdPKuh962szACBPIaNlip7vA2liu+0q4UNd8v3auJuDvASOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126154; c=relaxed/simple;
	bh=MvgPi3ihFIfcBpZAGgQg8p+KUe2SxMlbdi1Y/iHAmVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLjnDNa8PpxosMMi+tPbFREqNzoEvz+A4pe2B2WQoQSF/avvgfeEON+LqYcQD8QfXzCLqss4UZuIqDnji26RXQSvZHCvN2S+OdXJxPrNuWYipv1hNwaL6WB2XLgo1ARXUP2PUcOKWhloYOb4KjwrE2EnwkbS8DM46nnZufgHcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bGGlbvjV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso1831760a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126152; x=1734730952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy26bp1B/KGMXkPXfbjFeCelVduPyFZfDh3KMMEt8QM=;
        b=bGGlbvjVWWC3M3CL5nw8vUz4dktu6NIVih8fL4CdEOHlSqRKn8K2U77bQZzGsSlmlk
         afX3l86J2ah3FVgWEFNfnfoVpLtGWYMex4c8dMpRaBBrto5v4/DHAsWsvc2DVTqdMiv9
         omo1K0DNEVFc5+iOi54HSGScP80J8CYn1d9n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126152; x=1734730952;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy26bp1B/KGMXkPXfbjFeCelVduPyFZfDh3KMMEt8QM=;
        b=wYbO3qBOwuiDqUlc9GYZNiztlEJq98XKX6I7hlxMhgpDv0j3BEjVLg65/DoKPxh+g5
         8/OEbQNfVGvegTAu5giVJ5wcRp5KHVQxgg2JQvhNezV60JcwCJIZxD+cacFBtL0sbfVn
         8YjElK+xkIO67h2BfVieUmS2a5WMXKK/F8p3WJTUR0Yc8fUaHDPU9vHeZtxd4pKHG/Mt
         TqwRHFhE8jJB2Oatfax3iV+tfXzrhVR4vQ50v/N3KSP5QGAI4OhtKSkV0KES/jE7TJ/E
         7syj7pFq5xCxTIGMNc7RBD49CVSMhkqjRvo35B69l6BB3Fj6i5YdXBVGYNYbmR4nBcTD
         nqcw==
X-Forwarded-Encrypted: i=1; AJvYcCXVOSI4VTorqRmGBoLVEQiXNc1wQDwbQTsePFTV1XIxlpSeolxyFq4tzlqaUuNnUB3UuRBAmbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ92apguwkdFP9OH80gpsdTLOIdJhe3WGISj9a4/xKqNANisQO
	2bG0k62Soy3YW616VChcoirpIh6qtjgIaomQdAOhW6mhTqEiqcEe8iZWCw7KDVU=
X-Gm-Gg: ASbGncu9wi9/gPcjCjxesKzyxXXWdG2UH2w/U6VUBrlmsTcalMXm9kUiHYWVe/ZwKSC
	7bLHMNc1hBvkLnkAjcxvAU6XLN71EJEijpQRxsQz1iGzp0sje03rCcGCv7BdodxmhZbGJIMUNwl
	PY/f5xzF4XCRj9JcfZIr2AEwCsH34ugAWgD1oL8FO8tM+S668NF4ifbyMqQ/fPN9Qv7bSnq/HM2
	8lXomyRh1qh7IEchlzJJil1zg8cSeBzOhC65jpLq4gNfD5uGkw2XfKJmenVg/1H6C3j3SEICr1p
	Xx/mcLRFBnGdBmvrXSWznc25wFrD
X-Google-Smtp-Source: AGHT+IEh7IooH1Gymt1citGHBSc+fi6oQGwwJB3mObjAKnZP9JUZILEUtl+e6ODtZcgB+Laei6yjgA==
X-Received: by 2002:a17:90b:180b:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2f28fb71a7emr7250658a91.16.1734126151961;
        Fri, 13 Dec 2024 13:42:31 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434ae9sm275244a91.33.2024.12.13.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:42:31 -0800 (PST)
Date: Fri, 13 Dec 2024 13:42:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, almasrymina@google.com,
	amritha.nambiar@intel.com, xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me
Subject: Re: [PATCH net 2/5] netdev: fix repeated netlink messages in queue
 stats
Message-ID: <Z1yqRYMOZRpSjhHG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	almasrymina@google.com, amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com, sdf@fomichev.me
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-3-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:41AM -0800, Jakub Kicinski wrote:
> The context is supposed to record the next queue do dump,

Same extremely minor nit as in previous patch: "next queue to dump"
?

[...]

> Fixes: ab63a2387cb9 ("netdev: add per-queue statistics")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: amritha.nambiar@intel.com
> CC: xuanzhuo@linux.alibaba.com
> CC: sdf@fomichev.me
> ---
>  net/core/netdev-genl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 9f086b190619..1be8c7c21d19 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -668,7 +668,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
>  					    i, info);
>  		if (err)
>  			return err;
> -		ctx->rxq_idx = i++;
> +		ctx->rxq_idx = ++i;
>  	}
>  	i = ctx->txq_idx;
>  	while (ops->get_queue_stats_tx && i < netdev->real_num_tx_queues) {
> @@ -676,7 +676,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
>  					    i, info);
>  		if (err)
>  			return err;
> -		ctx->txq_idx = i++;
> +		ctx->txq_idx = ++i;
>  	}
>  
>  	ctx->rxq_idx = 0;

Reviewed-by: Joe Damato <jdamato@fastly.com>

