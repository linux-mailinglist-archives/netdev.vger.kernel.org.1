Return-Path: <netdev+bounces-205294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3AAFE17C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CBE1C23E1B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A22737F1;
	Wed,  9 Jul 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Fyx0jAOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CD272E54
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046678; cv=none; b=s/dYCBTu2J79eiEB2vlp1udSU5lABC5t1TTNAAbhFXS0yMDbGLWLiGUfCTmUDdtiABWxKsXFulh9fyfgBfmP7y2fcpgnY1sN3qxKouhKiHz4PMYdMp7gDZfaNyNOlYK4EcOl3X75/gn00OtNH9RaBc3oLjXLqIvo+wmBPb4r7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046678; c=relaxed/simple;
	bh=9OPmNg1Ke93Fs8SkZKBisFI6U+uVxoHqsm9QDX67Rgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxZRcq3Z1emgH7uiS+e/q7n6vo8AArsms4c9UMyq2uXmX2EkRkTnrRQ4XtJ8Gg1aWehanU43Kp+WINMCuOzBd0rFDx/uiDLRxG4CSbzGbaX+qwCr4iINI9Ua57n0dgjZWjVEjbDWOoED5L8ePWXnzXCkVXBnfj5FAw3EMumeyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Fyx0jAOV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0df6f5758so868675466b.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752046675; x=1752651475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=Fyx0jAOVtP481WsWBZ5NWcYpPL1fT5ZKqKrZq+LAj+HgBJf945INpeqp56yXMTt9BI
         1eE9321Nax0+yrQnBRuLuX384KLwGUk6XIEy9adBSzXKf+tGIFjiN/uRiRBdzouYiHnM
         ZqnTu4cQNzotKyKcUHeaImmmetjzNbVlzQtq+r7UDGMN6AuxbtzZQEGEtQaQLD6xFdOB
         mEGrJdrpxT0NLzlM7ZjgqlGsUQVNgRh1EoZ4mQJfs4xByBRUu5IzeehyDSSuLUl4mdEt
         XgBN7nNkfWDPUra62kCWaPl94JtN+PGIVnZKKT+YTh5KAV7PRbINNxTZZOXlPF7D7tLx
         0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046675; x=1752651475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=YBLPrwuxU0UrpwCA+3rUnE12tCwEgWpLj7Z1JCMbJVPYB1YgFSE88mrXR+cv8dSb1P
         NSuU9rkzJS1bOepteEN5yJPZaSlf19ofdj2b1xJ2PbPA1kchafL93fSEakEAeUx6OgZm
         gPX30yItmjglQ44FADHS9BZhSKZatAKRfswT4zonewHHViM0gzPLcchsxP8hujEvwfcV
         hxvxS/DFbV4b20YiJYhB72T5vFTEBBWAOKbScAf5LCwLtxB6rYbc+kbypPzSnO2jB41w
         21aSiD5e9hSY80XW9SYJGeF1CToTdnOqQSI2luD8TfdVe+9O3fTFvTslCWbGIWNjfawL
         3vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvn+mtAd3elx/zYAePZJkwhX9pVZC12NvzSaFpElG09gEUTqSpMPlRblfLeLx0hwpuflBVGRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBliIaY4z30jXaXgqW5wEmZVJAPQ2lbA+Xp6+KWHcaBeWAj1A
	5/vIPrCl9Q8+ED/UpGTLtPgYC3niwki4PuJXzruhGMSdVh5Muka+MiupjAVQ3kCZIBc=
X-Gm-Gg: ASbGncsw1xaY+G9YX6hbb21sZvRna2Gll3A8uFY57HddQW6G676z94Uqnks7BuYr60j
	qfPTmAI4xcTL30HH6pcbAk27Wf12bo69b/p/ZIoHPUaWJ+BU3FwhLu0GmpT3P/jf8Hk12cBHR97
	W55s8n83cmD2HfDsziAYu3t3QldEoCc8CQCwtaRJjPFamPS1HDdp5CbFyoIaxlJJO6Fn2QyX9AT
	B3AwIY92JWpsxVFn2jioaW91F2T3TdtgC6VEjrom5Lt0ToLRnB0YTKRgw1lUQ+8C4uVYaI6mOTa
	mx3J2DpDLjZZvincz0jyYpravvFBs7hsMX0f6MUaLIi5JpdEqKA+BU3IKVTKEJeIVuTE4aTlqgK
	sOBxu2gmxeXvLmznSEw==
X-Google-Smtp-Source: AGHT+IGKNKwRhwXTcmwtGN+5HGqX7L50fvavD2PabeX9y+OqiZC5bMINAl/BO5b4T2iWDRdBG72Lbw==
X-Received: by 2002:a17:907:3f9c:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae6cf73f3f5mr147273866b.33.1752046674928;
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02f68sm1054983366b.117.2025.07.09.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Message-ID: <f382be0d-6f30-443e-b161-d1d172dcd801@blackwall.org>
Date: Wed, 9 Jul 2025 10:37:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/7] netkit: Remove location field in
 netkit_link
To: Tao Chen <chen.dylane@linux.dev>, daniel@iogearbox.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com,
 jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org,
 hawk@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20250709030802.850175-1-chen.dylane@linux.dev>
 <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 06:08, Tao Chen wrote:
> Use attach_type in bpf_link to replace the location field, and
> remove location field in netkit_link.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  drivers/net/netkit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5928c99eac7..492be60f2e7 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -32,7 +32,6 @@ struct netkit {
>  struct netkit_link {
>  	struct bpf_link link;
>  	struct net_device *dev;
> -	u32 location;
>  };
>  
>  static __always_inline int
> @@ -733,8 +732,8 @@ static void netkit_link_fdinfo(const struct bpf_link *link, struct seq_file *seq
>  
>  	seq_printf(seq, "ifindex:\t%u\n", ifindex);
>  	seq_printf(seq, "attach_type:\t%u (%s)\n",
> -		   nkl->location,
> -		   nkl->location == BPF_NETKIT_PRIMARY ? "primary" : "peer");
> +		   link->attach_type,
> +		   link->attach_type == BPF_NETKIT_PRIMARY ? "primary" : "peer");
>  }
>  
>  static int netkit_link_fill_info(const struct bpf_link *link,
> @@ -749,7 +748,7 @@ static int netkit_link_fill_info(const struct bpf_link *link,
>  	rtnl_unlock();
>  
>  	info->netkit.ifindex = ifindex;
> -	info->netkit.attach_type = nkl->location;
> +	info->netkit.attach_type = link->attach_type;
>  	return 0;
>  }
>  
> @@ -776,7 +775,6 @@ static int netkit_link_init(struct netkit_link *nkl,
>  {
>  	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
>  		      &netkit_link_lops, prog, attr->link_create.attach_type);
> -	nkl->location = attr->link_create.attach_type;
>  	nkl->dev = dev;
>  	return bpf_link_prime(&nkl->link, link_primer);
>  }

LGTM for netkit,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


