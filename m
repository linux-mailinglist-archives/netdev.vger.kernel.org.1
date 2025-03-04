Return-Path: <netdev+bounces-171829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6647A4EE0A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40CD188E5F5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2491F8BCC;
	Tue,  4 Mar 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmqCb+uX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C601F37C3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118736; cv=none; b=mb23yLk33d65erSnP3UTQDBXsPBdnYOHpenAZiO6cqy+of4RGu9K2rpY3AhXnaOHmiN7jEbFS3ngw1CZ/3mkll+tmkY8SHism/ibUPkumfGRJhnTbk6Bc+ffDsAdpqb/FL8hFkoZmhLh2L7ydiEuOWjHGy5Pq6jsJ+kwRA8Wo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118736; c=relaxed/simple;
	bh=Yc5o8AAM03gqcwMaZIMFUJWm5niH57hleRgR8LPA2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNoHsUsWFXNGpxBFBBf2wYo0j4guIgBC5FGd1edLvXNohVPRviLLChXrGMK/sAO9I563px+yG0AvPRhMvD3iELcgLrD+XlvctoevYgk1ZuEHbz5goL2/AZ9S5rlQF5Y1QF0ipbrTrr6I6zZiwdOgWXbGasat6GFd0BKZl4vFkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmqCb+uX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223378e2b0dso88852205ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741118734; x=1741723534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa+0jqJt7RxZyWEnNlIeijPawv98xKd/6at7dqq5OEU=;
        b=TmqCb+uX7sWaiS4XmfBV1DOv36dOg6W3108o/g9t201VQX++Iw98DUp2iNze2yzfHo
         k4f0Vic8Af0xknyoyzFtyL57C8cnlqIn1l7oKEE7oRxGFmx89nGPI+tE/Jgsgy2zuubV
         3kQ0C+82/TVfEa53k6L4j2IZBHLlTs5cHtGx8cmY1UBwar21CP/banQ+sZfPrG7fCEhN
         Aeh8bnc3kBuvcMHSlObPElhNHpBrQFdpugzKqHhSECR9NXTLBlxOUYQLtNrTSAbyo3gk
         DEHvqxVKEsrnpakvH+NqXhIojQFwN/KucoDUerY1ja2HEknVgEPB/3/akvXmUsDuK3T3
         mYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741118734; x=1741723534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa+0jqJt7RxZyWEnNlIeijPawv98xKd/6at7dqq5OEU=;
        b=MqSnVBampw9CUfkM1iJ0HUnpENEAJSDp+2SumYZ/lhsyNi/Al9E5Q+JGaH/KAepG0V
         Lr7mqONu7Z/VycpjR1hHmc+6K5+0CwUZV2jH6ow+USSzHiw3VyQK0yuwO/72bygA3mM9
         Z/3H8BMD1SXz9vEaHAz+3It7zG6mlY2KamXY/pmfxrvHG7CIJde5D1yUT4IwYfVB4f+R
         B0Ay+7YTZYknMQON/OsVhlCrv2j7a5EAb4mwVJMU1eZjQKpEPzQ6MJly6r86Nnil1+AM
         n828rhSrYZz9jXG21mLG0PiYEmUV63avyl/mCLv7EsmfVBgLpVxChjgEGe6HuUbCLwF1
         7D+A==
X-Gm-Message-State: AOJu0Yx/iSR2XgfeG0UirJnAq7AXvfj8fOPpLgh9cHiJnzXAUQVKSX5R
	5Kk2wYAzxg5OeFdFBE78OjAeqQOuiltZ+iyC6ToOhSh+NSXFgjq3
X-Gm-Gg: ASbGncuCKsWvlxVXyN0r6zML1dj9KF7rsk4osm5zyV+S4XvX75RptBgtkwucZPUpvYF
	J129v4h7++8X3vyM2dmvP1Tl0MGdAreED1nehRqi+Jrs4GAlI+FdAGXclpvPohzV/LW6eU+L4Dn
	v/ZXPip0Z4XtFWkt7uRre18E7N9z2K0fIuaUzIhl4MvpfsupSOAKJoiL2x+Ck6JGBMupJVtEoCC
	SpWnV4zrTRu69QoIn4Bdwa5X/8Ws2Bw4IaPVXdcLmvY6t33EX4xvpT1UGMzXeukUVpc9XCrN1N7
	tChxnJ3B1NDPEsp806XKgoGpqHdvt5c2erthVgk0Tr03IcTy
X-Google-Smtp-Source: AGHT+IHVOmK8ob84EWFaaF/1pTIbrCtNQCsuHHy++ID7CmBElKeFrrUUESoyh8WvTi7IM2ufOAU6Fg==
X-Received: by 2002:a05:6a00:10c8:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-73682be66fbmr325371b3a.12.1741118734422;
        Tue, 04 Mar 2025 12:05:34 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-735e66ef952sm9029325b3a.98.2025.03.04.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:05:33 -0800 (PST)
Date: Tue, 4 Mar 2025 12:05:33 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: kwqcheii <juny24602@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] sched: address a potential NULL pointer dereference in
 the GRED scheduler.
Message-ID: <Z8ddDSvJZSLtHCGi@pop-os.localdomain>
References: <20250227160419.3065643-1-juny24602@gmail.com>
 <20250304141858.3392957-2-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304141858.3392957-2-juny24602@gmail.com>

On Tue, Mar 04, 2025 at 10:18:59PM +0800, kwqcheii wrote:
> If kzalloc in gred_init returns a NULL pointer, the code follows the error handling path,
> invoking gred_destroy. This, in turn, calls gred_offload, where memset could receive
> a NULL pointer as input, potentially leading to a kernel crash.
> 
> Signed-off-by: kwqcheii <juny24602@gmail.com>

Please use your real name for Signed-off-by.

> ---
>  net/sched/sch_gred.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
> index ab6234b4fcd5..fa643e5709bd 100644
> --- a/net/sched/sch_gred.c
> +++ b/net/sched/sch_gred.c
> @@ -317,10 +317,12 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
>  	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
>  		return;
>  
> -	memset(opt, 0, sizeof(*opt));
> -	opt->command = command;
> -	opt->handle = sch->handle;
> -	opt->parent = sch->parent;
> +	if (opt) {
> +		memset(opt, 0, sizeof(*opt));
> +		opt->command = command;
> +		opt->handle = sch->handle;
> +		opt->parent = sch->parent;
> +	}

I think the whole gred_offload() should be skipped when table->opt ==
NULL, espeically the last call of ->ndo_setup_tc(). Something like:

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..532fde548b88 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -913,7 +913,8 @@ static void gred_destroy(struct Qdisc *sch)
        for (i = 0; i < table->DPs; i++)
                gred_destroy_vq(table->tab[i]);

-       gred_offload(sch, TC_GRED_DESTROY);
+       if (table->opt)
+               gred_offload(sch, TC_GRED_DESTROY);
        kfree(table->opt);
 }

What do you think?

Thanks.

