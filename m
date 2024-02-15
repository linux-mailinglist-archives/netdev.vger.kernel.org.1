Return-Path: <netdev+bounces-71946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E866385596C
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D74B2A1CE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE494A0C;
	Thu, 15 Feb 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j54iiKsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8034A08
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966657; cv=none; b=pIXqCx46uPl+2vaN5QfDaJWqDQREV2hk7VeKlSt6HuCwENZF6ISFCWeNURvF4lNhSeNosGtEuZppIY8WMHd0UnjcKFBIQSOqBXgyYutdWfsHYnZpQ8OO5870SDneukepyuzc22oG7MTAbmejIgGuEG7YZeMaEmTBYBkA/khweL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966657; c=relaxed/simple;
	bh=wCujdonz0vxtCpTydB8LIsMldwA5tICwh9J+S0KkpmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHDME5Qdr77Ml5JVtiCFbNyJMSeLaASDZzEzpMPEiI/D5y7smQ3JeC/Ip7pzU94ki6PtKUqs5MjACOhBKtpLgrAfHgkP42LkCEgK0vtN+9Qc9fNJsL1ITjWSUOPzA5D+EJMBLElHlR1jn98gHhaXXE3bOR/afCWJk+gY50DuRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j54iiKsH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c3e01a7fdeso14362639f.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707966655; x=1708571455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OShWbewYoTgFO2PXcYAKkJmHEjDDmGp3MzIJuNqvFoc=;
        b=j54iiKsHxwZpK9YUz/9yPsmDUg8xbhc+yREyVrc2uG35aJHEbDfLIb4Q+OfoaHyO76
         /Xtj3Z0R47XZjMlJ2ZWxLWZwj6qnF53EaEMl2dgBnyLIexwYxWCGbdZxJkVXtAMZPJru
         vpv6fjWoBh0sTwIbGYr1eNJH6x7oMitqzPKjQSpsdFanN+/LQ563tow+gyEHB7ZG63kC
         kRfe69ORNMbvhHCUzMpQE8xJBMcIofdymWuRFRME2W7nJfrL//153Zfk7n6kn0xKpfNe
         EqMVyZt0JmI+ve+2ypqoVvy8f8EoUEHQFbIgom0mh/6flLKqCPr7n3mo5oMd8D4htlEZ
         atKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707966655; x=1708571455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OShWbewYoTgFO2PXcYAKkJmHEjDDmGp3MzIJuNqvFoc=;
        b=Db105iqNah4DVbtazM/PP/v3aB9Q+At8TRdwrBhYMyIxik2FUa7Mhr4dt6bnJGh61c
         fpFHK/gKQnHyEaw2OwN1WJcFtAr2BoYRDFrqFvNchiS/YWndlFlA54hedga3yI5swugD
         wBoEDEcmNl4ji2iPKY0RIrbbtOm9mM+sAKGWhzseXTyvtangJ+EkAm03Q+8QF1x0x790
         xAOuQoMhzjWWTi+6td+AKtTFsoOiSVQuKV/KKZZCaUkwCGQ4igQKSyK6u31Z48J5gxHB
         hs/LuDXPZrH1qUqsVcQGoOgMqXwQ2VBagbI3YXXwK358722H1HMZTYB6b0dWdUCP4rQu
         z82A==
X-Forwarded-Encrypted: i=1; AJvYcCWDVsvCoVjPozNoL6iK1mkx7VeKNpU7dREwD4Bx8kXd37JTSWcBzdUg2p2S7bogP/dN7Ev+ygNlzwlhvcYsZteS2LVTW14Y
X-Gm-Message-State: AOJu0YxPDRG3d4V9oWZahzO/FvzytNKnJDqm0KzL9OpVqiTlts1pXtpD
	1NjAbVvDqgi41Op02PSR9lCQRV7uMV+am2ppzcWKqosFlGPK7Svx
X-Google-Smtp-Source: AGHT+IGXL7w+5jHEg1Z8QaSiO3s3NQgB4RNMc0s3OcvqrV72WcG0tlWlkR81eAvtRE5SQq8Y2KtQ9Q==
X-Received: by 2002:a6b:e60f:0:b0:7c4:607a:def8 with SMTP id g15-20020a6be60f000000b007c4607adef8mr823609ioh.17.1707966655602;
        Wed, 14 Feb 2024 19:10:55 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:80a2:7f78:25ab:8de9? ([2601:282:1e82:2350:80a2:7f78:25ab:8de9])
        by smtp.googlemail.com with ESMTPSA id fn26-20020a056638641a00b0047133a05f33sm131490jab.49.2024.02.14.19.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 19:10:55 -0800 (PST)
Message-ID: <f04a4b8e-9db0-458b-926a-fdd448becbb7@gmail.com>
Date: Wed, 14 Feb 2024 20:10:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 sgallagh@redhat.com
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
 <20240209083533.1246ddcc@hermes.local>
 <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
 <20240209164542.716b4d7a@hermes.local> <ZczcqOHwlGC1Pmzx@renaissance-vector>
 <d2707550-36c2-45d3-ae76-f83b4c19f88c@gmail.com>
 <20240214190519.1233eef6@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240214190519.1233eef6@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/24 8:05 PM, Stephen Hemminger wrote:
> 
> I just did this:
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index 5296cabe9982..679d50b8fef6 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -8,6 +8,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <inttypes.h>
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> @@ -3241,7 +3242,7 @@ static void mptcp_stats_print(struct mptcp_info *s)
>         if (s->mptcpi_snd_una)
>                 out(" snd_una:%llu", s->mptcpi_snd_una);
>         if (s->mptcpi_rcv_nxt)
> -               out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
> +               out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
>         if (s->mptcpi_local_addr_used)
>                 out(" local_addr_used:%u", s->mptcpi_local_addr_used);
>         if (s->mptcpi_local_addr_max)
> 
> 
> And got this:
>     CC       ss.o
> ss.c: In function ‘mptcp_stats_print’:
> ss.c:3245:21: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long long unsigned int’} [-Wformat=]
>  3245 |                 out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
>       |                     ^~~~~~~~~~~~         ~~~~~~~~~~~~~~~~~
>       |                                           |
>       |                                           __u64 {aka long long unsigned int}
> In file included from ss.c:11:
> /usr/include/inttypes.h:105:41: note: format string is defined here
>   105 | # define PRIu64         __PRI64_PREFIX "u"
> 

Andrea: can you check on how perf (kernel utils) compiles on ppc64le? I
thought Arnaldo had build "farms" for all of the architectures; maybe
not for this one. __u64 is used a lot in the perf_events UAPI and PRIu64
is used extensively in the userspace code.


