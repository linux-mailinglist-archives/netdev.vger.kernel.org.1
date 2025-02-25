Return-Path: <netdev+bounces-169436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C60A43DFA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCD017A8C8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179832686BE;
	Tue, 25 Feb 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIv0Xm8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FB267B10
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483718; cv=none; b=K4GqOWiO5M5vR0YyNvVIaOdndxeicuMpJTfP7KyKqiwuxP+WJXxk7B3tCGHt/ZNYy7BvDLdwkU1twma2hiChk4mNtwbi2ISsCZfJy4eP0sJx8G+vimRxP2mL9bzSoIOrliXiCcs9rYj+1feikXNqx9rItut9M/fbJD/AI238VOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483718; c=relaxed/simple;
	bh=CKyOL0dq4XhTxXKNvgQCDaAmo0Z3lBdpUJRyRETK/1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK4vqpBuWPuGxkPa/P4RKrmudkdR/JMCYk9gmrpuj+oXVG4SZIfW/mVyiinw7QLjtEQwW0dP2n3IfL7qFuA4ZhYfS1uXwvc+Bi/GxSd9w2syDSGIUmhXAsCKna2lH9BDVGW3haCoGqlQwAFiArTjmag4k/TydJ5oGTsAxqpniV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIv0Xm8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740483715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6ggdA4Yip2z1d3LHS7C+TUR3rF6w0Xoc1I30vx9XO4=;
	b=EIv0Xm8JUxTA0qTeRH5rmqQ8Dx9tuV46RTzQ/Qm642uHt2TewCsqlvmk8CKUJnhspcdkEy
	5VzZgnI7jWufT1F4k9U4rVmUWknbyTtpcoUF/C4sLXJGkzbNYw8ctBYGDbhnMa8fCsvIXb
	ssJVEdQiKexAZ0fFWbINY+aJv8qsVbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-zno2z-elPJOCMt4dy61keQ-1; Tue, 25 Feb 2025 06:41:53 -0500
X-MC-Unique: zno2z-elPJOCMt4dy61keQ-1
X-Mimecast-MFC-AGG-ID: zno2z-elPJOCMt4dy61keQ_1740483713
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so52117465e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483712; x=1741088512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6ggdA4Yip2z1d3LHS7C+TUR3rF6w0Xoc1I30vx9XO4=;
        b=GPXKEZAH0cqW/1BwitdwiROfoLLwH9890v76FyiacLLwvUH33eurQDBaq0DqrRQjC4
         SbjiDk7mlIejA5GwYxASJkdn8Iv9fc5xvvvUE3ibfY8cGhBGK87E3ERvaiMnus72OjoD
         vFL0FWNnjj98407GQAsqXXgK7X2FMjijEcVgEkucxWaxZgdxX/u/PTVcm3WOD6OcEsOf
         KfQbSEvoVIXDFwi/c3KRZhpdBEUFf93inmC0Q3HlrewENhh9zdjrjTFRCHvCS/lZK0+U
         OjDa7DqIMunFTcd/Eezfd8mGyi71LlfhEOOqqDTwDqZgbAKKFwI17gqy9KJNy1oG4tI1
         s8PQ==
X-Gm-Message-State: AOJu0Yx0Iy2VZnY10yipFV4Z2z3CiEuVTtqghtLcH+eZxVzExtIWIISx
	nn+H1WTECVyXUERwz15FirDbAEktWR6hYiftgTbE6C9p5dQFaLUnACQI2iGLMBnqW660XpjxhlJ
	V/cJFVV6YQ7uWAv3wGFkJmSPGLe9bCkYBLyvvOyu7PPhfphY2E8bWakZtmGwaoA==
X-Gm-Gg: ASbGncvu4UlZPhs/D4bHgKNirqE/s9ls/MGDtStI9tQNybcBO/5+nPDC7dxJLknaTlr
	39NrzTVZ94Uw6hF4BN6nxRJ++Z7QNEkSpW7GjZSDu9PrE1ZwvnRvMVRqkvKcAEBMUwJhN4R5uZT
	644+oMjdPgNTtJ2cXn6Y9d8YdociKP8rXyBlclvtbALUj3GpN4heXWOCYmJyazCcls8n406QSt8
	MO8n6/7216SnMOO9vpb5aK6UxXIPfNEs8jyv0Cl9hen9ZUohMs94qigfxVP0/gRSXB32OHme1I9
	ZClrFUPTzhgiXFB131XslUVmm/EIxEF2VA9Bd6EJCzM=
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr30046775e9.18.1740483712368;
        Tue, 25 Feb 2025 03:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUzCsKXyrBcsIL02vOqLDaHj/LvRegxo7XAQO9jd0Q3JP7pHTLj0XRvx0x5fW0Mplj5/KsQ==
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr30046415e9.18.1740483711879;
        Tue, 25 Feb 2025 03:41:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1569e84sm22373085e9.33.2025.02.25.03.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:41:51 -0800 (PST)
Message-ID: <7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com>
Date: Tue, 25 Feb 2025 12:41:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] netconsole: add configfs controls for
 taskname sysdata feature
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 2:52 PM, Breno Leitao wrote:
> Add configfs interface to enable/disable the taskname sysdata feature.
> This adds the following functionality:
> 
> The implementation follows the same pattern as the existing CPU number
> feature, ensuring consistent behavior and error handling across sysdata
> features.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 1b109f46512ffb7628c6b34c6efdfc301376dd53..5a29144ae37ee7b487b1a252b0f2ce8574f9cefa 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -426,6 +426,20 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
>  	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
>  }
>  
> +/* configfs helper to display if taskname sysdata feature is enabled */
> +static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
> +					     char *buf)
> +{
> +	struct netconsole_target *nt = to_target(item->ci_parent);
> +	bool taskname_enabled;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	taskname_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
> +	mutex_unlock(&dynamic_netconsole_mutex);
> +
> +	return sysfs_emit(buf, "%d\n", taskname_enabled);
> +}
> +
>  /*
>   * This one is special -- targets created through the configfs interface
>   * are not enabled (and the corresponding netpoll activated) by default.
> @@ -841,6 +855,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
>  	nt->extradata_complete[nt->userdata_length] = 0;
>  }
>  
> +static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
> +					      const char *buf, size_t count)
> +{
> +	struct netconsole_target *nt = to_target(item->ci_parent);
> +	bool taskname_enabled, curr;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &taskname_enabled);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	curr = nt->sysdata_fields & SYSDATA_TASKNAME;

Minor nit:
	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);

would be preferable, and more robust if later on other SYSDATA_ bits are
added, 'moving down' SYSDATA_TASKNAME definition.

Also it would be more consistent with previous usage in
`sysdata_taskname_enabled_show()`

Cheers,

Paolo


