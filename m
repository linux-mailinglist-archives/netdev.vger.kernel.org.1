Return-Path: <netdev+bounces-63382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D482C8E6
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933A1B2274C
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C47171DD;
	Sat, 13 Jan 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="n9zd2/gU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AD1A700
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dddf12f280so3325055a34.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705110413; x=1705715213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqeW5gKdNiXPyd+fGG3DalL7cVMbYMkUx+N1Od0gY4Y=;
        b=n9zd2/gUhO+hlQ/teyC6bASfOtLpRPJCvxuds2IyuGgYNghwDpgWWfs3fzqeDGfUV+
         fsZtEYwoVA/td6a0TG+4jiBoa2lQB+M78pWB9ZAsyK4BRJI6gEoYNq7fpGgB6R19Q24r
         1vWvQkmsQYd+WOC4kWyjdhndpPKby44PmrlPiH4PQxLjGi9EmNMjC5FExktsA8QPDcg2
         Gkk1YEZv30mI4KuqV3Gfy2LpsbiBRbvW0NRVcWu1Qtt4sdsWrvV2ZCYootiAiAP6GqJg
         abbl7FNZds4PRRlUiK6xo5Tbc56WKUI7y4dgIEkI9EFK3CjhYKbaOcZTt9favnonIIcm
         yD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705110413; x=1705715213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqeW5gKdNiXPyd+fGG3DalL7cVMbYMkUx+N1Od0gY4Y=;
        b=Bqajw9B40oNW8Z5/qtwuJpPeUdIQ/CITkSOTl2XFwG84pKY2gJd7UPHBUxHmuOnkfw
         hXjpqvVajAbN306640GlJRL2HhrVMcDsholGDmVkoi1s8fmGK85zNI2KLu01bmPmPWXV
         PJTdOgJFV4sX99BgVHTfpOJene5f1/YXdnHIreXLMgzPZK5hZpK6tsaOSu3xF4VLA4Sb
         8IdFQyOsvrkLBAp44ZSHQXRkdH0dLCAfDsnzO4wGjqZ/GLz6N+3IOznwlQo/8UNTpjfs
         9Uo80j6PpxoW0zb+8qJDACzofahA3fxnN2rCOnN8C/O3KLiHvnKfQaixjJ0u8jsArtoX
         P9eA==
X-Gm-Message-State: AOJu0Yy4nlgVuubuAo7cFlgzAjcXO3eWY6qSkJ8+twtgL/S3rHjBaTEN
	mw2gtaeWTdGVGbDErl01Z+M/pvUUOCmGpQ==
X-Google-Smtp-Source: AGHT+IGC1/bzzOpqXFRGMEkK0UiZP2WxYO8u+uYgLLMsIO7cCv+rtW/g/QcX1E/nlbXUNSj85rnO9Q==
X-Received: by 2002:a05:6358:b09b:b0:174:f1d9:563a with SMTP id b27-20020a056358b09b00b00174f1d9563amr3944550rwo.47.1705110412985;
        Fri, 12 Jan 2024 17:46:52 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id oh6-20020a17090b3a4600b0028cc9afaae9sm4961227pjb.34.2024.01.12.17.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 17:46:52 -0800 (PST)
Date: Fri, 12 Jan 2024 17:46:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ifstat: Add NULL pointer check for argument of strdup()
Message-ID: <20240112174650.6216eccd@hermes.local>
In-Reply-To: <20240110205252.20870-1-maks.mishinFZ@gmail.com>
References: <20240110205252.20870-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 23:52:52 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> When calling a strdup() function its argument do not being checked
> for NULL pointer.
> Added NULL pointer checks in body of get_nlmsg_extended(), get_nlmsg() and
> load_raw_data() functions.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Yes, ifstat has lots of poor memory management, but this patch
isn't addressing it.

> ---
>  misc/ifstat.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index f6f9ba50..ee301799 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -129,7 +129,12 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>  		abort();
>  
>  	n->ifindex = ifsm->ifindex;
> -	n->name = strdup(ll_index_to_name(ifsm->ifindex));
> +	const char *name = ll_index_to_name(ifsm->ifindex);
> +
> +	if (name == NULL)
> +		return -1;
> +
> +	n->name = strdup(name);
> 

What if strdup() returns NULL?
The error handling in ifstat is frankly aweful.
It just calls abort() everywhere.



>  	if (sub_type == NO_SUB_TYPE) {
>  		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
> @@ -175,7 +180,12 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
>  	if (!n)
>  		abort();
>  	n->ifindex = ifi->ifi_index;
> -	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
> +	const char *name = RTA_DATA(tb[IFLA_IFNAME]);
> +
> +	if (name == NULL)
> +		return -1;

This NULL check can't happen. A few lines above, there is check for tb[IFLA_IFNAME]
being NULL, and RTA_DATA() is macro that just offsets that netlink attribute
to find the data.

> +
> +	n->name = strdup(name);
>  	memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS]), sizeof(n->ival));
>  	memset(&n->rate, 0, sizeof(n->rate));
>  	for (i = 0; i < MAXS; i++)
> @@ -263,6 +273,9 @@ static void load_raw_table(FILE *fp)
>  			abort();
>  		*next++ = 0;
>  
> +		if (p == NULL)
> +			abort();
> +
>  		n->name = strdup(p);
>  		p = next;
>  


