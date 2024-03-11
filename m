Return-Path: <netdev+bounces-79195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85F8783CB
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C601F22483
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C754AEF0;
	Mon, 11 Mar 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="GG9w/Ley"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C24AED9
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170956; cv=none; b=NTS/MmhCCV6aFHi8c5To9mS2lSyYq8kD7cFqJfoFAa9LLctMvsWPxXRuUjN+47wgJULTUNwPDqw+DcHvqoRLYVNF7dKFAuoY/rRzb8QfFAx+ae48hw4oCUQAsgQqwwzS0bBoYJL3e8+bPKlKWUDHuQYJGIL83iiLxHmQ8FHfpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170956; c=relaxed/simple;
	bh=e6TFE/1KfvvW7dIxLWV8I/Uiw2fbSncmPD9VPYm2nJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXFnIjdDCiQ1RZntzgKgeQW51j+ZW1ickE1K3LjAw0xogrYJ6rUI0Kq1DJfYSWtoUyevqOpdtoNI1KSqVkRWDAFXQNY7jSegoX6/a9LJpZdTOQrrqAqGjZ0Re2wyb1MUjjceVJkEHFbA0LBrBoNzGCr/grcsaCVrJJpjufseqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=GG9w/Ley; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132cbe26a9so4361085e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710170951; x=1710775751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBRdUgazJ1HnLsYGkRF0jKMpPcVcTcXQbKGRIqRZPjY=;
        b=GG9w/LeyV9WgyjVUjY3zdgyZj3jaaKNt9/reFo/vkrZtW/AhbnLCB64bpzoy6bMHG4
         4m1Y8XgP65NeAZ4/5TkSJ0CdG2ZIjC5y3uq9z9Wk72x2CjQsqKmvIiPo9S3PkjdAtMlZ
         kJeFLaA7luKLc7Fnm1iyKkmLmVtcxgnDAQrB/pknRWhwWdH0ZhgIOfoVma5l7thlR3QJ
         fCZHT/aBtHiv26GWyKx1vJ0+7M9QGArXTTsdWbQepwdsfEfYTHTfQA0EaIIEnCIM9sTH
         i3GrHl6sAt8zPQRGY78IWezjMd6GzJzUDUkULKKh11InxGbdS3pjrvCnvqJjpKp5ohfF
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170951; x=1710775751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBRdUgazJ1HnLsYGkRF0jKMpPcVcTcXQbKGRIqRZPjY=;
        b=pD0BBoK+ew7/XpY3Dm95eJ4cc9qkbU+ZYoj7738xv+yYnXOQQN3Sxawu2geaRMZ4o8
         82L1RuNEBe/cRTBNYy1GwY3McwVGp4bhNibJMZe0E4B3rOlcNGOigO67UYpCm7pjdlWK
         hdFio4qfzn1ZsSGDvckngK2uz71xmQFZhXDHfbgajNiyDtqEeVgBV4uwBBLMtZ91Gnda
         XdBGPf/1eolAylwYXkdkLZpTnlSD2GEsUiCkvqEC0G4MVsxnKPDi7+4aOyTDCmRCGJrs
         cmCwXVeOttxPxY06pBkh1O3En62HOPNAoPLhfuvqLRsjDTKfkjCjPPIGkqNLNZdquffC
         yDbA==
X-Forwarded-Encrypted: i=1; AJvYcCXteAp5LjSJnZIjqZmIx6KLGo9bz84s/3Oox2Y7vi6a3HO8NSVNjqmVuUo2DU3Y5RZdnSec1ZFdujUyHdI+w+iNSY7CujVV
X-Gm-Message-State: AOJu0Yymo7GsHSUkBA0b+OROOyLLjjAOzbw+Lb8VZiVq2Cteq5LhXh1Y
	YrreSSMIicUV+HFpBPyvcsQTBtoj71YBYPkFdlLhPSs3E9M3WXEjIoFwag1XIMM=
X-Google-Smtp-Source: AGHT+IEwgdh7H+9crLcV9S5SLA+JZoumOzg/VaQuwX7biWBYjQ6DqPv+BHttGcsj9IyOJw9JoIyg7w==
X-Received: by 2002:a05:600c:4449:b0:413:1f5c:baa6 with SMTP id v9-20020a05600c444900b004131f5cbaa6mr5344265wmn.30.1710170951441;
        Mon, 11 Mar 2024 08:29:11 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:5231:db44:25b0:339e? ([2a02:8011:e80c:0:5231:db44:25b0:339e])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm15941091wmq.21.2024.03.11.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 08:29:11 -0700 (PDT)
Message-ID: <e8f37842-1ddf-4241-97f3-b83ffcb32ddc@isovalent.com>
Date: Mon, 11 Mar 2024 15:29:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 8/9] libbpf: add support for the multi-link of
 tracing
Content-Language: en-GB
To: Menglong Dong <dongmenglong.8@bytedance.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
 dsahern@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-11 09:35 UTC+0000 ~ Menglong Dong <dongmenglong.8@bytedance.com>
> Add support for the attach types of:
> 
> BPF_TRACE_FENTRY_MULTI
> BPF_TRACE_FEXIT_MULTI
> BPF_MODIFY_RETURN_MULTI
> 
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  tools/bpf/bpftool/common.c |   3 +
>  tools/lib/bpf/bpf.c        |  10 +++
>  tools/lib/bpf/bpf.h        |   6 ++
>  tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h     |  14 ++++
>  tools/lib/bpf/libbpf.map   |   1 +
>  6 files changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..ffc85256671d 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1089,6 +1089,9 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>  	case BPF_TRACE_FENTRY:			return "fentry";
>  	case BPF_TRACE_FEXIT:			return "fexit";
>  	case BPF_MODIFY_RETURN:			return "mod_ret";
> +	case BPF_TRACE_FENTRY_MULTI:		return "fentry_multi";
> +	case BPF_TRACE_FEXIT_MULTI:		return "fexit_multi";
> +	case BPF_MODIFY_RETURN_MULTI:		return "mod_ret_multi";
>  	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>  	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>  	default:	return libbpf_bpf_attach_type_str(t);

Hi, please drop this part in bpftool.

bpf_attach_type_input_str() is used for legacy attach type names that
were used before bpftool switched to libbpf_bpf_attach_type_str(), and
that are still supported today. The names for new attach types should
just be retrieved with libbpf_bpf_attach_type_str(). And function
bpf_attach_type_input_str() is also only used for attaching
cgroup-related programs with "bpftool cgroup (at|de)tach".

Thanks,
Quentin


