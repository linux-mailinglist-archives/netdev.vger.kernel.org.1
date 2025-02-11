Return-Path: <netdev+bounces-165268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53FA3157C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EB17A0257
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400C26E62B;
	Tue, 11 Feb 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="H6Y6GXq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6226E624
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302504; cv=none; b=U9UUjZViFVpeSkqdO7cDO9/rTpMMdfoXVaxSg0Q2eli6BR92MONMjsq6pOZIESKSys62Q7Bu0BO65KXBlWGEFkcmxBVSy7bSxO3eA3sRGr35aUpgGwE9d2QDm5KnRg3JbCfeISYwrzoedSmdwe1mw3W9DLytVhsyWpTWCILs8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302504; c=relaxed/simple;
	bh=mrYgjChbk9HHiVmGZOGjFmGJoTAjOpLqTwz3NCdgSIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMzhqoOwJxp9eCkNQKnYDL1PjNRvBh1c8y8GwoIYaGSCZt2z0/3r2c3mmVsxd2X+9gT1vM+VCs/qWO0BkfnleXqh7OT1aQyYN83b+wj8bucm4KxonZyAjob9Vcc1j9OZ9UQ0zaB/+iadGZLMYTnUTiW50f+wVyYNz+2xi9cqaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=H6Y6GXq2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f74c4e586so64972145ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739302502; x=1739907302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRnQhCSXILCiKcBPLiUnr7FWQ6Yj1dQg7rvdCqEBVWk=;
        b=H6Y6GXq2wZ78pYWuz7CL3UrGbFXjWdhiym4PkgbO5VrYesVNMqZ0dvhBUIerocH03H
         d6D+aZqsEkZwBL2eJeXVVKjYj0CWJoEiWyO70ENYIo3snBHEGErqQGFPmwrGQEFy/iPg
         lc9XdNufCNqfbcjEDtNuqEbUn71dHMVJwjrc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302502; x=1739907302;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRnQhCSXILCiKcBPLiUnr7FWQ6Yj1dQg7rvdCqEBVWk=;
        b=KBVXx24+4g9IZzVP8UPG0nG7UkrT9he6fXFdEkMjNl2QdDPVCYn8IPyaF36iyn7GHu
         n1ufv08Ro3RbyLGktSMzs0/XCiu8B8l+z3amA16sLh6AVtyBRuSmB2zRHmwwbFqLs8Va
         tS6U7BNWuA6u/YJ6Hja607+8ZyztSJ8F5C5BKs7+GCfyf+YYKBs8TOeBiHguDuLKu15i
         3mNc8hifAYoZl9m8MACA6u3E2GgyWvFNdsYqvoJ5ktkD/7yjRhAsGy9lesX8O2LNOjjf
         P92O9nEoMD8uLQPQEtsPW3DGADdSYHMcldI1BiLV9+Y1mjS7AXm760D1P4HkBv/ovqdG
         4Fdg==
X-Forwarded-Encrypted: i=1; AJvYcCVSbYPKauL8Hh4ttHDjRuLlFse/D1u517weHUb9C2ZfxijiRxUJyPJjHn211aaBEvG7D5+aZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDauUxheVQ2opMf3afyHv/21D47868+kk0MzhexGQQ8gNOcHga
	ofTsZVmbJzmlLieEH89bSxx6NoDy1NTtKpfWyH92vIxQJSMwb23DsnhR6ZkFQd0=
X-Gm-Gg: ASbGnctTwMZ6g7J9oaELA+Ckt1sEwKqIAPIZoGdkl8SM/VAKJPpCIn1hXbef5VytNTo
	3HdsO8Jarg0GPOgAvVUMwvUxv0+D/kengCkE/LyNSqPYL3fW7U+GOoOq8IocUyTZxqHN9Xt3wjN
	i9IWbs9AUVxiH5TD/Shu6JlE/7i4FgeIO3jC1WEilrNrp8yUsGeMR8xRM8pfhfayzGFUnMmulfN
	sindNeYRxwCCPYMlp0cfTceqPBvhAcmcmEFhq0pthWLiPCsJjvSnx/A6FWaGdi88t0sRG3FOBzY
	vr4/Ngds/rM/y2iI6mS04iW6YvhFQX+QUPTOEuGhxDf3US80CicZrPH+oQ==
X-Google-Smtp-Source: AGHT+IFcC+ZHhsOupDrvb2s8kAzHIlh8rRB4A7CKNKEF34fjjFKQzYJZ9xXY1arFn5BaLWh3jMc9iQ==
X-Received: by 2002:a05:6a00:3e0b:b0:730:8f67:2db1 with SMTP id d2e1a72fcca58-7322c570a4fmr261544b3a.3.1739302501988;
        Tue, 11 Feb 2025 11:35:01 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307a71577esm6256432b3a.59.2025.02.11.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:35:01 -0800 (PST)
Date: Tue, 11 Feb 2025 11:34:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net-next 1/5] net: report csum_complete via qstats
Message-ID: <Z6umY6t_ART7PdL8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	alexanderduyck@fb.com, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211181356.580800-2-kuba@kernel.org>

On Tue, Feb 11, 2025 at 10:13:52AM -0800, Jakub Kicinski wrote:
> Commit 13c7c941e729 ("netdev: add qstat for csum complete") reserved
> the entry for csum complete in the qstats uAPI. Start reporting this
> value now that we have a driver which needs it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> ---
>  include/net/netdev_queues.h | 1 +
>  net/core/netdev-genl.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 73d3401261a6..825141d675e5 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -23,6 +23,7 @@ struct netdev_queue_stats_rx {
>  	u64 hw_drops;
>  	u64 hw_drop_overruns;
>  
> +	u64 csum_complete;
>  	u64 csum_unnecessary;
>  	u64 csum_none;
>  	u64 csum_bad;
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 0dcd4faefd8d..c18bb53d13fd 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -581,6 +581,7 @@ netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail) ||
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROPS, rx->hw_drops) ||
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS, rx->hw_drop_overruns) ||
> +	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_COMPLETE, rx->csum_complete) ||
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY, rx->csum_unnecessary) ||
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_NONE, rx->csum_none) ||
>  	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_BAD, rx->csum_bad) ||

Reviewed-by: Joe Damato <jdamato@fastly.com>

