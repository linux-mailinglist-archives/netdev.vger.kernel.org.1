Return-Path: <netdev+bounces-144820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150629C87B4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA68E284867
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8F1F80A3;
	Thu, 14 Nov 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7pj2r2s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871741DC05F
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580473; cv=none; b=hz0n1KmeviHX668kbKxP+MVPpR7z6JLQZVFO2IwPIpPiFWeCBoOrdcnsgLOhH51OzUVB32Mkrr7VcMrmVJJcH6jw12FUdsSx5CN23Exs2wRlmI1WV8iQsEhqtr5h4tPMJQu5XPLrPOLaU9wwRbjQ4zlGjfr4NPI+7c/wkHdzvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580473; c=relaxed/simple;
	bh=9NSyV8J37zkgSfT8SSmvC9IvYLYLgSb5DtAfbz6Q0DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k4a+DB5j9ppH5SJAiDIhng9lG9jBUG2bZibV7LDtElRa+rfFSozcyn4V1q0aekebW3IOZoYIU9gsl9+f2AM1YHEWFL2dZwrbJcS0g7U8K1CdgDni9syG6hVPWTLy7ZXbnxbwI3a9PQFoHfABISH9+yKKUL21VuQMSpPOKG+AzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7pj2r2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731580470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bL1TDm7rZCPU5Kay9rqCq9qcbgcAxYuCQTRJOnYP6n4=;
	b=W7pj2r2sXi62IaErYTT+W/YJzgFwi3x677OkDlkMXQOd/Rkx8jvWaY6cIYKBWGsloCWOt0
	mJ+PtxHYQyEIgxBCJ7yveKGyKl0seVXCuFUM5mC4EJ0dtVMemWNIWpjhjLKineXtkmDkfV
	6CsVbhLph6752WLHrnwzQhUnlJUlyj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-MmL907OlP-CutNFUJGCWMw-1; Thu, 14 Nov 2024 05:34:28 -0500
X-MC-Unique: MmL907OlP-CutNFUJGCWMw-1
X-Mimecast-MFC-AGG-ID: MmL907OlP-CutNFUJGCWMw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so3724885e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 02:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580467; x=1732185267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL1TDm7rZCPU5Kay9rqCq9qcbgcAxYuCQTRJOnYP6n4=;
        b=K6PDoWmxz+YprMLUnhc8BRelssqN53axAkKT5frIfVkbBQBJgQz2JKPrXB0rIrZq/n
         UhI75Um2BRW2ILTIp+vPp7ot7uKcI1Zs536GfAOWOb8PeK36BJlUtwdzd3DfrsycZRo9
         j3z223FBdCp+7fdcoNY+sSZIPzANWDqMp+HL1C3co41ieFG92UVbkPvvd3dAK5C9QlAA
         02z8r53yzQ92S74cCboD1zeC79Sle+YCDP9hvLs1N0rHR13XvpumSba8CUH5h1VLdnMw
         6v2kJYtMjIKcO11a+R/lx8SIwYdxR06aTob9NbpjenXRw5K2Hw6MRTTU6M2lVzrJPeyK
         DG1g==
X-Forwarded-Encrypted: i=1; AJvYcCWb5x21P+dQBaizKcOkUtHEEtDrmYC2w54tPUfaRTYWwNqTVYdH4CL2O/NbUDocxn5BhvqaMJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8Fa+NGzcgjGiDivgUE4h++G9EYg6bpMmdll2lzSMgLlAHlaD
	tcL8LhDxTbl3635VQoonSv6/Ph0tfdGY/WeeWUbgaDSU5CtcQF7RGidxVSZUv89wPHEt2DFlUKJ
	MRE7U3zgcaKRw9Essj7ElujgVZBOs6gqhNyQKJ50NdilY8cqEBLBaoA==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr58575455e9.8.1731580467698;
        Thu, 14 Nov 2024 02:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7QUd4COsmqD7s0A3KVqaPte+ZWjxjNIuWILigzUy4UQb3+ONujlZta3QocdY4DXgTqnCCCg==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr58575275e9.8.1731580467295;
        Thu, 14 Nov 2024 02:34:27 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae25sm15396975e9.35.2024.11.14.02.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:34:26 -0800 (PST)
Message-ID: <7914fb1b-8e9d-4c02-b970-b6eaaf468d05@redhat.com>
Date: Thu, 14 Nov 2024 11:34:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: replace deprecated strncpy with strscpy_pad
To: Daniel Yang <danielyangkang@gmail.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "open list:NETWORKING [IPSEC]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241113092058.189142-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113092058.189142-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 10:20, Daniel Yang wrote:
> The function strncpy is deprecated since it does not guarantee the
> destination buffer is NULL terminated. Recommended replacement is
> strscpy. The padded version was used to remain consistent with the other
> strscpy_pad usage in the modified function.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  net/xfrm/xfrm_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index e3b8ce898..085f68e35 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1089,7 +1089,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
>  	if (!nla)
>  		return -EMSGSIZE;
>  	algo = nla_data(nla);
> -	strncpy(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
> +	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
>  
>  	if (redact_secret && auth->alg_key_len)
>  		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);

@Steffen, @Herbert: I think this should go via your tree despite the
prefix tag.

Please LMK otherwise!

Thanks,

Paolo


