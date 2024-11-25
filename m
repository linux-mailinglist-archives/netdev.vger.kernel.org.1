Return-Path: <netdev+bounces-147185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921879D8219
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D2AB2259B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82731607A4;
	Mon, 25 Nov 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="I5RE05pv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF081531E8
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526392; cv=none; b=Ey2mZvUBdUIbyUteREblwK0Ajg638SIXF4gZzgPo5lzjIx1TFj6YTv6lZGQCcGvyzfwbHw4QDX7MHvH5wtFywIgLkQu5K5qeDAkf4QvF7qrkY+JozaHuyeSRcDlpXiLUtu3GNJOd5tPM9ypkCUzT4ggKxMxxwKVGcfTqNvMa6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526392; c=relaxed/simple;
	bh=diqqxYiLjrRf3QZZifBvUqXqaK+915+aMt+MqM/XfA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DHnQIQ2vTJqUOJxcW07YSnbOdDlTmTn1FNhXqDc/GzyTbLTT7UrrVF+nKeMkDy11taTF9Rm7R75kSBvTPmw9g1arc+EgBs+7erxIvZdEWcXs/jtnzMHFtH7RgfaoTVoLNuBEKURpIjYrR+Pldmf04FVvWeTrqVU06m7xOulJFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=I5RE05pv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53dde5262fdso1575479e87.2
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732526388; x=1733131188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xHDSLrvBwNTWcyluIsTeyeRD7uapTC9/jjuO3O34G4=;
        b=I5RE05pvh8Xmng3KjbB88RPKUzQNrWWwaQzRHc6I/vglAhMLIBelRpiy17uFqQg1UL
         ediWF/NekKE/1fGH2FtR/4W9YzWR/531pWat3SVBfo6fnGnO//ReeXb3u/MJBdaGmEtJ
         55M1+Ke9MDyNelxX4SMQvAEVp9slrBVCPKur2srL3Ldq+9CsBU9++WLsfa7vo1Owh/8r
         9oL2F8DTNymskldei/Y2SnNhosPyF1gPbuDY3avn1Eu8jj0juIOUoWxhV6s9qtcDPUlT
         qQW+Qj/Tkl4UwOLhc3uZBNJBcDgBeiHV1OdMhHJuhjzEkCUyumpZbXZjN0XTncuQfDWC
         gYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526388; x=1733131188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xHDSLrvBwNTWcyluIsTeyeRD7uapTC9/jjuO3O34G4=;
        b=EaSL+47K692dAiiNo1nCkKtFm9znv0QTZIIkenBd7Rr0ilaMQVd8aNJ7Nal3x8q2EZ
         W7/PbsCisCkTDQS93uUPayXXkHRwU8sB9F4wdetVtZ7XjN15lrb0beTPE8QCnaPm/qbA
         g8/JVkCbtvmJ+8p9LU54BVColZ40YzTLRs/6VeZhXYUDDEnX8pNVYLmIwECfGI+1d/jM
         jU8I5jM5tWQEYn+FtEzCaZXpm6tmtEA5T2ybgBsECJGeqGFPwyV/IfJsnLUPx5RfKUcN
         LwvwQnjEtNCAg4dxvxrYKSWPi4CjYeZLRIVa7PTMqzOMMKU0e6s/2/L8s+Y/sQSozona
         ntrw==
X-Forwarded-Encrypted: i=1; AJvYcCWXpRFZgYAwuZEiP82ebuEPXKFhS3nt912lX6rVb79iXdwzy1rC+G9wGP/j6Y6jz9TYJRa1hUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoMEwOftop7AKCqAXjeb7pOnvXWcTYTDN1oTd+I8Emg+hm5kC
	Q6DBbghEY1GKgOi6LRqWC2YrSNj14/k/+S/JHBO/41BRF9iRTows0otDgzbDa+9/7CBl7IxkaKP
	5
X-Gm-Gg: ASbGncu8M4xylFLFrFlqOpYguJVQkGEv22NIT2RFDbmyeP1nCIARU23V0jQz54KEw+i
	fao6l9+RmNw13KtkcaKr+5ia0MUG0R5/wsMbW/xOQiHUofnp57zfNy6JGzK6IAZqUqt3ZRbesj9
	njxqienEWfkFWP2YJlxKGb770ACKitMtJUtgCg8Y37DBYNx+ifQsz8iWZuI98TWFdrpY8a65P0M
	vogZJbzW72VnnjFAZBMmkIjdaXPEfxu2jO6AJ38ej96+ewMO9OS
X-Google-Smtp-Source: AGHT+IFUMDaJaUo/zwLRCPPn6+xlTSaKSGOILl2CPQC9sV9xuen4izfbUt7w4YV88nymV9lxgSulaw==
X-Received: by 2002:a05:6512:3994:b0:53d:e4d2:bb3 with SMTP id 2adb3069b0e04-53de4d20fccmr886163e87.50.1732526388441;
        Mon, 25 Nov 2024 01:19:48 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9829sm9843088f8f.31.2024.11.25.01.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:19:47 -0800 (PST)
Message-ID: <385b4ead-8d43-4845-ac66-4218b285be32@blackwall.org>
Date: Mon, 25 Nov 2024 11:19:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: fix memory leak in error path
To: Minhong He <heminhong@kylinos.cn>, stephen@networkplumber.org,
 netdev@vger.kernel.org
References: <20241125073147.68399-1-heminhong@kylinos.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241125073147.68399-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 09:31, Minhong He wrote:
> When 'rtnl_dump_filter()' fails to process, it will cause memory leak.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  bridge/mst.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Please CC bridge maintainers on related patches. This is a patch for iproute2
and should have it in the subject (e.g. PATCH iproute2). Also there's undocumented
and unrelated cosmetic fix (removal of extra tab below).

> diff --git a/bridge/mst.c b/bridge/mst.c
> index 32f64aba..a85e6188 100644
> --- a/bridge/mst.c
> +++ b/bridge/mst.c
> @@ -153,6 +153,7 @@ static int mst_show(int argc, char **argv)
>  
>  	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
>  		fprintf(stderr, "Dump terminated\n");
> +		delete_json_obj();
>  		return -1;
>  	}
>  
> @@ -214,7 +215,7 @@ static int mst_set(int argc, char **argv)
>  	state = strtol(s, &endptr, 10);
>  	if (!(*s != '\0' && *endptr == '\0'))
>  		state = parse_stp_state(s);
> -	
> +

This change is not documented and unrelated cosmetic fix.

>  	if (state < 0 || state > UINT8_MAX) {
>  		fprintf(stderr, "Error: invalid STP port state\n");
>  		return -1;


