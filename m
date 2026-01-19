Return-Path: <netdev+bounces-251306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635CD3B90C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27AF73008DF5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDF239E75;
	Mon, 19 Jan 2026 21:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A282F6921
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856723; cv=none; b=HeDZEwraOpjXfetAKvnutdH9zGiB0ykefZXIypvt3TmdE+7G8Bzl5fAVX7fptv0xUZI9faeW3ulAUH4Z7DCtOsBWg78a4yzCWBc25cUP7FjuPHCUh3TaAzlktNCUzbuR1EE7JUetD79Czf7337fMMxPyJhUgvJmICoz24LgECzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856723; c=relaxed/simple;
	bh=N7agwbJRW1l/djFFzsVT5DGch6qDmZxxSBFRQoO2YEU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=apIzTC868MfzdisuJWogEeTuGQaXQ3K9/+XE5upxalVh8CtScruRaRH7lwYBpBzRLUR9qGuGJwiqckPonZtpwEFYWbNtjBbJKIgerg+fz6kpoxRY8kSbNxmY3CCOx1yaoPWC0bQuPqbZHIUNG2uI8LFsGjt7GXVteYeQJkJrHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so35508125e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768856720; x=1769461520;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ch2ygY/Gb3koILArIw+E5wLp2aRrYg6I7QfReG24w=;
        b=i82/Udy7eVIWlAWxuTOonyqw3OKs6Emns7BJ5cUk0mx7mw51K4i0zcQ0f/lGFgz5JM
         JcYUnuWOofUyComMD6gCbOJjYnU5PUFLXeE3zpfMiO2qnXtQTn8FBtbxOnhDM0VYHROp
         nm3bZPUr3c5tJ52orjo9+BuNo91eXF6m8WOwuo6R/9bkgW4/DH5A+mXerRQa65gxfzt4
         iUASEq2v9rinBBRdASHj1UmeVFABN8jaN6KBzUhYPsh6bgMxDVzSD8SX4mX10mgnon6i
         elNvHh9JQ4B2rwlrgkA2qiF7HXSxfO7W0Ner/fHPG45omHXDlvgmgtLRQ1J44amZddVU
         FZTA==
X-Forwarded-Encrypted: i=1; AJvYcCWzILd1qQyjZcQvapzXctSFFc1Mbo7jCo1UZuVV61cLd9IpIO8xacXvM/xKWuNZLtWRg6PqtVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmodU39kLZOMjf3ogxqGgEpGgiruovyPm0LDK9tsmlimmYDiHm
	v6jviOtD2MJgeAZ8l55TTYBKxVSG7au2tOqBQukrpuzTICqxA3w49+s+
X-Gm-Gg: AY/fxX4L0GjHYIIn/ZQk4wN9me+8zRq0MdI1/MlgFJWwTksvDuX+TiWQlVjqi1MdIRr
	PxfoyAOt+3gdLNI6cd8dLn07yCgSAt79JLhNMpqOgYEORa/ZgCh1LzYP+A/R76yHb1qCB8MhsyA
	bxe9LwtXovVe7eX8KNnGVNw+dfscSPOnPUiDdfbR3XnevpfCUPuDfxOHHa7JJnkcT45jYY+hWKX
	zVFAQqziY0z5tpO96b2YUSNfvmNELh1jwXFxdShU66izTs/hpGK8bwgfFWyHZhJfQNAefFCDE8F
	7FLAHSRDTegMVx+73N4MKqmhZKbTwDh/fCeA+6IYB2CY16v3FMu8IF/hJNfr6hW8ny7Vx2i6PHj
	0Y0CfLUG9azMSzJJ5ehUKoeyqxjDp4mCJyNZRnfVb/rmR487XE1L0gm1I5S/Bwd0L6pb5PjelGS
	Cf72tFfYSBlStDeV1TGyFQo2PUie1pEBQC+ed7QihzcBErJL4=
X-Received: by 2002:a05:600c:4745:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-4801e33c17fmr170422835e9.24.1768856719606;
        Mon, 19 Jan 2026 13:05:19 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe74987sm92662215e9.8.2026.01.19.13.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 13:05:19 -0800 (PST)
Message-ID: <67a91c79-3b4a-4ab6-850d-dc09a75fff28@ovn.org>
Date: Mon, 19 Jan 2026 22:05:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, wangchuanlei <wangchuanlei@inspur.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: fix data race in
 ovs_vport_get_upcall_stats
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
References: <20260119181339.1847451-1-mmyangfl@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260119181339.1847451-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 7:13 PM, David Yang wrote:
> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
> 
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  net/openvswitch/vport.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Hi, David.  The change makes sense to me, thanks!

> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 6bbbc16ab778..bc46d661b527 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -319,13 +319,17 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
>  	for_each_possible_cpu(i) {
>  		const struct vport_upcall_stats_percpu *stats;
>  		unsigned int start;
> +		__u64 n_success;
> +		__u64 n_fail;

In addition to Eric's suggestion on using plain u64, you may also
put these two together on the same line, right above the definition
for 'start', to keep the reverse x-mass tree ordering.

>  
>  		stats = per_cpu_ptr(vport->upcall_stats, i);
>  		do {
>  			start = u64_stats_fetch_begin(&stats->syncp);
> -			tx_success += u64_stats_read(&stats->n_success);
> -			tx_fail += u64_stats_read(&stats->n_fail);
> +			n_success = u64_stats_read(&stats->n_success);
> +			n_fail = u64_stats_read(&stats->n_fail);
>  		} while (u64_stats_fetch_retry(&stats->syncp, start));
> +		tx_success += n_success;
> +		tx_fail += n_fail;
>  	}
>  
>  	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_UPCALL_STATS);

Best regards, Ilya Maximets.

