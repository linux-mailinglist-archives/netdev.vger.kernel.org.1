Return-Path: <netdev+bounces-123616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108E965AD8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BFC283C55
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5416DC3C;
	Fri, 30 Aug 2024 08:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B313BAC2;
	Fri, 30 Aug 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007538; cv=none; b=XRG+PuA5qVLn/JOOwbgIXaPD+FLEkDBkymZJidGtWRoHQXwNGf4HMIs9YgsNGDbZNH2XZJmsIiP7kfUESL3G/fYB2lJHZwpsbhWq5DbAsbiTp7FPwGs1aAF3DglYRNtgTWoAVgpTW18Cocmp0oRXe/Rx2NXSBgXudIBJzcriLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007538; c=relaxed/simple;
	bh=AjjfCvU5D8/cgk9YHPVrzmJnS4gI4pti0GSq8Nuq5pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAnWcZUSGxfSe6UbrN37mYZf21a8hUFBi7aqCvwr5dcIkXgrUhCLz7QvRj0/ad86ejjdB3W/8VWKP7tbGg8qwzI24pcKtPx0ATP4ldFWdChWJw2D7zXKvIACER8tR+pwcd8MhYQ7LsvUqMLPf1nPECGBvYEn2GMGmtG24ra/oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso1509256a12.3;
        Fri, 30 Aug 2024 01:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007531; x=1725612331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gspJ5kn4iTcVQBe4Tx90yeM/Odp+8sXvAdeGfGuxBY=;
        b=vnYe6919ySbr/yBl0BdaV2XUHEG1+AYlwuV6uSlLgBKt+3LUYko4doOY9HCDVAoty0
         DLttefdVaKvNszTP/DwtNvVeykEAI1Ui28tfTgtrVnhqEJSIdsYIlxlhfSp2/u4CoaZ9
         cntlNzeTDjIqOR2qG1QtB0tNc1TzSA64yTc7kxMG18sO+j1h797/GvMXLqoA3PQDrvSa
         drd1VGJVoWsoxtGnNvPDav64EbSxaWjW/cpHJH4dGy90nawvDCVUEi+lqJelMpZsoPC0
         EUAVOYFKYWvS4cZ0Vo4gIfggO3ib6Zn1wEowPBVJdjP+xumVZsn91JuSRBzhez/I7AUX
         XPFw==
X-Forwarded-Encrypted: i=1; AJvYcCW7SqSs0VkhGvMRtMXjzx0M1+RDcz+R8DwmleTlUzNqqgqrSLLczL+9kS7DFYXi/5c7kBqLXe8AuzRZRhw=@vger.kernel.org, AJvYcCWE2gNqY4v3vLxZFzg4P14mbXEiX2L840QtyGqsLI8wRDsGfgjmy8sFBOF5xsa98FjGgA/ewmaP@vger.kernel.org
X-Gm-Message-State: AOJu0YyukvOcuaH26ANQ8RnQ7zcDUnTv+MAjNeo4VvCOc5sbaw98UTKR
	4QDvfCQktuXtojOaftU8rQGENJvbBmXYfU95Voa08WQAsYQgZq+VrawLEQ==
X-Google-Smtp-Source: AGHT+IHKIVaCceLUHuX5KbTo/YuGzgQ/ZWAz5To3ZWxu1Cv2+YY6TLk4/hVh73RJoHZVQikrBZ5Ylw==
X-Received: by 2002:a17:907:9707:b0:a86:8d9d:898a with SMTP id a640c23a62f3a-a897fad58ebmr447148766b.58.1725007530456;
        Fri, 30 Aug 2024 01:45:30 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb31fsm190916966b.17.2024.08.30.01.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:45:29 -0700 (PDT)
Date: Fri, 30 Aug 2024 01:45:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] netcons: Add udp send fail statistics to
 netconsole
Message-ID: <ZtGGp9DRTy6X+PLv@gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240828214524.1867954-1-max@kutsevol.com>
 <20240828214524.1867954-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828214524.1867954-2-max@kutsevol.com>

Hello Maksym,

On Wed, Aug 28, 2024 at 02:33:49PM -0700, Maksym Kutsevol wrote:
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 9c09293b5258..e14b13a8e0d2 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -36,6 +36,7 @@
>  #include <linux/inet.h>
>  #include <linux/configfs.h>
>  #include <linux/etherdevice.h>
> +#include <linux/u64_stats_sync.h>
>  #include <linux/utsname.h>
>  
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");

I am afraid that you are not build the patch against net-next, since
this line was changed a while ago.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=10a6545f0bdc

Please develop on top of net-next, otherwise the patch might not apply
on top of net-next.

> +/**
> + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that counts errors
> + * @nt: target to send message to
> + * @msg: message to send
> + * @len: length of message
> + *
> + * Calls netpoll_send_udp and classifies the return value. If an error
> + * occurred it increments statistics in nt->stats accordingly.
> + * Noop if CONFIG_NETCONSOLE_DYNAMIC is disabled.
> + */
> +// static void netpoll_send_udp_count_errs(struct netpoll *np, const char *msg, int len)

Have you forgot to remove the line above?

> +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
> +{
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +	int result = netpoll_send_udp(&nt->np, msg, len);
> +	result = NET_XMIT_DROP;

Could you please clarify why do you want to overwrite `result` here with
NET_XMIT_DROP? It seems wrong.

> +	if (result == NET_XMIT_DROP) {
> +		u64_stats_update_begin(&nt->stats.syncp);
> +		u64_stats_inc(&nt->stats.xmit_drop_count);
> +		u64_stats_update_end(&nt->stats.syncp);
> +	} else if (result == -ENOMEM) {
> +		u64_stats_update_begin(&nt->stats.syncp);
> +		u64_stats_inc(&nt->stats.enomem_count);
> +		u64_stats_update_end(&nt->stats.syncp);
> +	};
> +#else
> +	netpoll_send_udp(&nt->np, msg, len);
> +#endif

I am not sure this if/else/endif is the best way. I am wondering if
something like this would make the code simpler (uncompiled/untested):

static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
{
        int __maybe_unused result;

        result = netpoll_send_udp(&nt->np, msg, len);
#ifdef CONFIG_NETCONSOLE_DYNAMIC
	switch (result) {
	case NET_XMIT_DROP:
                u64_stats_update_begin(&nt->stats.syncp);
                u64_stats_inc(&nt->stats.xmit_drop_count);
                u64_stats_update_end(&nt->stats.syncp);
		breadk;
        case ENOMEM:
                u64_stats_update_begin(&nt->stats.syncp);
                u64_stats_inc(&nt->stats.enomem_count);
                u64_stats_update_end(&nt->stats.syncp);
		break;
        };
#endif

Thanks for working on it.
--breno

