Return-Path: <netdev+bounces-54542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE58076C7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DDB20CCC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C166A01E;
	Wed,  6 Dec 2023 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="G7LjdyIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6202D40
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:39:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0538d9bbcso49429955ad.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701884360; x=1702489160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epEPAoODqaSsyq6mWAsXlk/zwY3UQrTT5iMw4+zTkgU=;
        b=G7LjdyIBPxbsJPrlhEsc/+rcQEIDcADolRlDc0bxGGMoxV2At6voLXxW1WNg1sPigp
         ubDVSi4drL8F4IeGeN4cp7tKlL85UIPstQN+vSxODzRN8dQ/5WZeYyY4nqyPRkhxaVp8
         3Om4T3p9ZrfI93wQVBqlH1w0yigioBPPlVtUMpALHSKtioytu53GIcjsLQtr0fsQsmr3
         PxJCU90MYP02ZZ7aNCbhKM1/ju2pgzr+AEV7XqfNKMrW9PlvrgOPJQFJ/a4vrgOfpgd1
         sy6cORbKKk5h8ygo1blZd440qABNaIyhZJmZNNKk8Iu8d6r/wdcEK0uHFvynwOQs1WEs
         Souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884360; x=1702489160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epEPAoODqaSsyq6mWAsXlk/zwY3UQrTT5iMw4+zTkgU=;
        b=NUm5tL0392bPPsQxSavHa0sKQV3qDlS9v4jdbi1J1Q0jTQc2KWg/BcicYMP0OvX2ay
         VtEKyTn9s+CzTYHjpxXZbZ8lR7P2T8jiflkTVR3WiX1iw2F5fhW1QtQ+dAXVMUbktzO7
         4RsyJzqm1MBvbIhPxuKkURQiEY2ZR/3PCyxPm42h/jue2ZS5EG7TWDiK9mANzJwDfjcj
         UK2LTzdGYfD11J6w4S3jcJZEstH8qwPhX4EOaDHtHwJ/Z5/9nLnrIJPcPCKmY6oCUOEl
         rm8CQYCXsyTz2qK0ZCnBTbyugmLew6DZ/OKGwMxhrNOfHX2717gjf6UdVMyMJs69n9G6
         +HrA==
X-Gm-Message-State: AOJu0Yxf3hy+oEA+Yllj9BDNJAWUGgrBTXRX2/maDAWVfM6Rlh0Z5fC0
	y9+YrSKOOORAPj21Y8cT1JnG1A==
X-Google-Smtp-Source: AGHT+IGVTG9OQEKtoS6pjPpVNzMPWylYXwUA5I/GkMnBeOoLO3QQ7WcBm26jNLVY5AwA6U/sTaSzSg==
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:e2d7 with SMTP id z12-20020a1709028f8c00b001d06ffde2d7mr1069589plo.113.1701884360181;
        Wed, 06 Dec 2023 09:39:20 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001cff353696asm81396plx.302.2023.12.06.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:39:19 -0800 (PST)
Date: Wed, 6 Dec 2023 09:39:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Judy Hsiao <judyhsiao@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Brian Haley <haleyb.dev@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Joel Granados
 <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky
 <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Message-ID: <20231206093917.04fd57b5@hermes.local>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 03:38:33 +0000
Judy Hsiao <judyhsiao@chromium.org> wrote:

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index df81c1f0a570..552719c3bbc3 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  {
>  	int max_clean = atomic_read(&tbl->gc_entries) -
>  			READ_ONCE(tbl->gc_thresh2);
> +	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>  	unsigned long tref = jiffies - 5 * HZ;
>  	struct neighbour *n, *tmp;
>  	int shrunk = 0;
> +	int loop = 0;
>  
>  	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>  
> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  				shrunk++;
>  			if (shrunk >= max_clean)
>  				break;
> +			if (++loop == 16) {

Overall looks good.
Minor comments:
	- loop count should probably be unsigned
        - the magic constant 16 should be a sysctl tuneable

