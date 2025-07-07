Return-Path: <netdev+bounces-204636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC613AFB80A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32531887963
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F271FF5F9;
	Mon,  7 Jul 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TGlAztAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAFF1E3DC8
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903646; cv=none; b=D+/Qz+nnIsiKHQ2D9CHlKrpgYwGU+XHZK6I5lcjSDT5NJNpNXyIZh51OsuThJvjSkVhKdYExGJW9+C8hTH6iu/9CqHqrTI3wT5c/DrnTJD1CDgeQ9gGGRIAhj1+hDNMEvu3y9QugGVKpPtHpBpIg9w3w0mCd59XtKsTHgdnJcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903646; c=relaxed/simple;
	bh=1yMvJOMP5eu695VIaFJfpgCosy8Bezu/9C1wapjTDVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxgyZUmACMLLJzI8S0DqZYunYBrAXyifQU1BsVTEe1fsgKkdwDAkLzT4UiYtjCHsKeFOEVDGnaYAJ50gX4CWHDRNfVYM2Bh39UA/xV/IjEkVpKPFzfp4kHU4VnHtC1efs86dPMwSGVH3VhCZIJOPLLXHojMZXtUvTm2OmjKmw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TGlAztAt; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafdd322d3so42651526d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751903644; x=1752508444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dj2ub6oSd9b3F1QRmV6yw5wJ4k+kRz3q7ASEMB6KGlc=;
        b=TGlAztAtdO5xq6ba6N1xbga23XpT2rdeiupzLG6VKLPLNG65V9K7VaRz99jvgZLRBE
         Vb5p5zXSEkMSTvg9KfeB/Oh4Af+BVUCOG3LvZCmpDZr3Z4RYiOo0+aqQUC1+bRk+i09r
         z2reBJu4wvcDIfKHMhzCxu+QTFbXlrmrEY9WsiIlS9zhPtY1lWAtjanERJjGWKbrqeJ9
         Gl4FfAP7SRjsRjEgcqPbd3qH9pXTbjHBK3g4SDz36+NITv7USfmpbU6A3w9uGTzLBt+6
         fesTYS7Ob9P3cqL6gtUTJoPv++yG/tVEeNA4vrG2CItM6DM4iGCYEqvn+f+axOn2ntlk
         ib8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903644; x=1752508444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dj2ub6oSd9b3F1QRmV6yw5wJ4k+kRz3q7ASEMB6KGlc=;
        b=wlYFlNocJqTgjqiNMvc3SMF8VbBI+oUElJ2Eisbt/Y6XhTeGwX6ng7esb8g6YoYN7H
         y4P1BeOR/RhXYynQhavR4mgvzO65myQRlkxePesPWR2r5/FdPSJ2ZNLonyxLL6fFABKD
         nsdQYOUHNaJyV+GwOaGWHrfqJUADavMtGgUJsxVa4hSQwOTGeLqhb95uYkWCkz0tXD6O
         sDK4w84ekvdpUKjWd259FZWOwQi8bjfGXh/Hpvo6qHR4U/S7Lk2wW+ySkHKyOW6QnOXs
         nijg4fYZyRStycWqbl1N2iFz7mKiOpGqs/gHn6Yyc7KlE4mJE4pcV7UJAKTwpzviMXCf
         lO0w==
X-Forwarded-Encrypted: i=1; AJvYcCU2UW4Tc4Kk+vLGeySEzAigXZfICQHGQh4ncT/E0Xpfnj+1E/8jFw5z81k2fiAQgYs47pXvYCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuF0rKbKbkZ0RukmV98BZOI9BVXrooMEGcJSnxnwo38dz+RZcG
	LlVuslfKLqD+s0qFg7SMjlqcHLaD8pjXIL/CMV6p8Tx/icvnyftkEOYNQzHQ6xQk6A==
X-Gm-Gg: ASbGncsq/Vi4GAqzrsIv2U9nKX2aoDDxP+Y1XBWKbMH7yuxibsOFvbiLjm2HrFlJ7iK
	+olu7c4cJoogt0PWuPr95JvD25s8xnnH/az+QxUvKcVSyKpi5YINx2oI2PSIxNit+axHPh7fDzY
	swaz0+ofyjsZeWZqHP2eFXykCa2Dt/wHJF7grdcOGRuHV5/k0plcX5FO2VhTFRyMGZf3nrGVCfB
	jBoAO1l1frcHHd5Mtvo/xluZRnv9X2rIhf3msfATDvQxi7GBFHZfGKwo4re8OOgPvWdzAXef0vy
	jPWvkhzVE8gc3yGwd33dpwK2EJucFxFOUbIyOMW+x4I9OQbHGFQiyW1E6ApxE0BgixtDSso=
X-Google-Smtp-Source: AGHT+IFuUXFAQ5li2OAp1y7aRvgoOcyzZcjHEE4Zl3SPBYulGFUDI3NCmDH0sQYDa2OT+6zdOyaAjw==
X-Received: by 2002:a05:6214:238e:b0:6ff:154a:aa4e with SMTP id 6a1803df08f44-702c8b5b7ebmr216315676d6.7.1751903643452;
        Mon, 07 Jul 2025 08:54:03 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc7379sm60541086d6.17.2025.07.07.08.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:54:03 -0700 (PDT)
Message-ID: <4006930e-fda6-4f5b-b016-016ccee2e710@mojatatu.com>
Date: Mon, 7 Jul 2025 12:53:57 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/11] net_sched: act_ctinfo: use atomic64_t for
 three counters
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250707130110.619822-1-edumazet@google.com>
 <20250707130110.619822-6-edumazet@google.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250707130110.619822-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 10:01, Eric Dumazet wrote:
> Commit 21c167aa0ba9 ("net/sched: act_ctinfo: use percpu stats")
> missed that stats_dscp_set, stats_dscp_error and stats_cpmark_set
> might be written (and read) locklessly.
> 
> Use atomic64_t for these three fields, I doubt act_ctinfo is used
> heavily on big SMP hosts anyway.
> 
> Fixes: 24ec483cec98 ("net: sched: Introduce act_ctinfo action")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Pedro Tammela <pctammela@mojatatu.com>

LGTM!

Acked-by: Pedro Tammela <pctammela@mojatatu.com>


> ---
>   include/net/tc_act/tc_ctinfo.h |  6 +++---
>   net/sched/act_ctinfo.c         | 19 +++++++++++--------
>   2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
> index f071c1d70a25e14a7a68c6294563a08851fbc738..a04bcac7adf4b61b73181d5dbd2ff9eee3cf5e97 100644
> --- a/include/net/tc_act/tc_ctinfo.h
> +++ b/include/net/tc_act/tc_ctinfo.h
> @@ -18,9 +18,9 @@ struct tcf_ctinfo_params {
>   struct tcf_ctinfo {
>   	struct tc_action common;
>   	struct tcf_ctinfo_params __rcu *params;
> -	u64 stats_dscp_set;
> -	u64 stats_dscp_error;
> -	u64 stats_cpmark_set;
> +	atomic64_t stats_dscp_set;
> +	atomic64_t stats_dscp_error;
> +	atomic64_t stats_cpmark_set;
>   };
>   
>   enum {
> diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> index 5b1241ddc75851998d93cd533acd74d7688410ac..93ab3bcd6d3106a1561f043e078d0be5997ea277 100644
> --- a/net/sched/act_ctinfo.c
> +++ b/net/sched/act_ctinfo.c
> @@ -44,9 +44,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
>   				ipv4_change_dsfield(ip_hdr(skb),
>   						    INET_ECN_MASK,
>   						    newdscp);
> -				ca->stats_dscp_set++;
> +				atomic64_inc(&ca->stats_dscp_set);
>   			} else {
> -				ca->stats_dscp_error++;
> +				atomic64_inc(&ca->stats_dscp_error);
>   			}
>   		}
>   		break;
> @@ -57,9 +57,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
>   				ipv6_change_dsfield(ipv6_hdr(skb),
>   						    INET_ECN_MASK,
>   						    newdscp);
> -				ca->stats_dscp_set++;
> +				atomic64_inc(&ca->stats_dscp_set);
>   			} else {
> -				ca->stats_dscp_error++;
> +				atomic64_inc(&ca->stats_dscp_error);
>   			}
>   		}
>   		break;
> @@ -72,7 +72,7 @@ static void tcf_ctinfo_cpmark_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
>   				  struct tcf_ctinfo_params *cp,
>   				  struct sk_buff *skb)
>   {
> -	ca->stats_cpmark_set++;
> +	atomic64_inc(&ca->stats_cpmark_set);
>   	skb->mark = READ_ONCE(ct->mark) & cp->cpmarkmask;
>   }
>   
> @@ -323,15 +323,18 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
>   	}
>   
>   	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_SET,
> -			      ci->stats_dscp_set, TCA_CTINFO_PAD))
> +			      atomic64_read(&ci->stats_dscp_set),
> +			      TCA_CTINFO_PAD))
>   		goto nla_put_failure;
>   
>   	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_ERROR,
> -			      ci->stats_dscp_error, TCA_CTINFO_PAD))
> +			      atomic64_read(&ci->stats_dscp_error),
> +			      TCA_CTINFO_PAD))
>   		goto nla_put_failure;
>   
>   	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_CPMARK_SET,
> -			      ci->stats_cpmark_set, TCA_CTINFO_PAD))
> +			      atomic64_read(&ci->stats_cpmark_set),
> +			      TCA_CTINFO_PAD))
>   		goto nla_put_failure;
>   
>   	spin_unlock_bh(&ci->tcf_lock);


