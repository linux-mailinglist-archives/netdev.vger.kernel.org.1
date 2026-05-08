Return-Path: <netdev+bounces-285957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAp8Coos/ml0ngAAu9opvQ
	(envelope-from <netdev+bounces-285957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:33:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0824FA9F2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B74E3025D0B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0B3783A8;
	Fri,  8 May 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="jgavkDgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AB1F91F6
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265222; cv=none; b=cC6ChaeBSaaKdI4vqGCt9lgudgNgn4BslMZJsxaydS/Cpd2ukWAYBIvEngtH2/S41ffMvluxuF7h77BRz8Yfzo1Hg5Dv2YaykqxRr6tjzJ/+wpuOkGJ+cfBx86FtpOM01r7iIwA45yFhSDlWceqMckuxxfXPY3bbHia8ieL/P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265222; c=relaxed/simple;
	bh=6GLyNF6vbIZMeC9hJuUoOqy9YYTm345Gh23ogdPiPG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeHjlWTqOaNc5M3jD9hJgOI0dXXCReDSAYy3cl9KiPG/a8AgCj+c6CBHMQMZOevREclYSQn05+YEa8zrR5vkewx4sMCXhIGsN6uc5W7RmBVKXXyXtr2PSft6SAicYVm90E+ypXD02N82FwlyQ/ULp0auoX6NG54NWc10NSIuQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=jgavkDgz; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1309f4ee97fso3100432c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778265220; x=1778870020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQ2n3k/rZIJ8kJFhv4WMs9Q2AXD8SGmPY7Bkax05prQ=;
        b=jgavkDgzjTUv9CXWBY5/btQb0FMIkjWGfGXM5Ts2Td61u1DsCyW/k8jGOsvLJuSwhy
         sI2EHS27mH4Q9tQQLVNaCODp7LsUIc9KGF9AUALed2lQA7IFOL4qXOe6R0lqPm9HaFxN
         ZSlvljuvZ2DfvYy8d9K7fQ8tb1bx2VJU1huQXPzzaAFBvwl/DWRNl7g60oI6OwlIqwTY
         9dtbW73bNi/fLATDl9PntktBp+26Os5MS+TIvCaWej2n4Vagf2SEHZcWh+kKDYFFD0UF
         9uDUjYWxz4JstAXBkekXN5+iXAG1nCkkeQvl1aNQg2FzKzWw86qNYVwXCobZ3nkQPj5G
         gO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778265220; x=1778870020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ2n3k/rZIJ8kJFhv4WMs9Q2AXD8SGmPY7Bkax05prQ=;
        b=l6znIdQHLF96LctDjHemUHe/yYEvNTRZvt5CbX8Skr2WOvK2cvZ94qOStpTacDfJV+
         iPBIuKbUjhOhIbW82H1WMjjgZBFpZRFIZP4KCMfOIzu4aXGYQBvK/lOJuCG0Ykbkk8gW
         QgOdhhSV+xGHwhBSGuxYMV2wPFOVLi9oNvN5GyAyvk+c/DsUE/QhdJ1rQk3g1oro3CPi
         APE90OpndsAkYicvxYfq5oiTHxHOJXrN637PAU7NYgLnKTWtyF+nsNyPlpYidodLnYIQ
         lUb2YVrexRV0BOP76Stlke+iooQSM3bcWCH5YPg3IrBO7OMDajmW7HC3sng+T6+chWf8
         mwUw==
X-Forwarded-Encrypted: i=1; AFNElJ8N0wUwpBVQczukZSJMno1jV6lHcHV73MtmBbLjqIzoLQ1zisTBK+2j4KpkZxcyqyG8aHBOmh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9y2RGF05E3O8RnyOqxPAY4AngUWcYhWc1L9mdiwm9ufe4s/3I
	UrImNYUjmEAAyBZp/yxJz3elWQ4IT0zMYfh8l8s0epkotaaUAR8xTVHmLf8QsaBl+w==
X-Gm-Gg: AeBDieuDBMZtEQovGX+0vsZ3C7WfuZEZsj/AHCTgycoTmDMki7pwW45dJVfj7dJ2b6H
	ZR4yVM46xb71VMsaGyGCZ3pczwBDr9W28/WwwYf3PaEKts9yXahl8mkuK8fsGy1cWNTPtJY02A1
	Sbs8CbIX8EpFnixGB22ZoFpi3T5OHqbiPKifvLMdTIJbhE1YD6Bc4twOLb5XUi8Zu5TA70v37rw
	KAPJnfWCsrjHCufBwFCzs4qxqUtKZRn8+/QxjokKuNqhekVCLPX7T2Mq8sbzvbePO+SGbuP1ueo
	KHM+bMiKRsD+g80pw544aEN5lp7Qf/kJk+0IS938A1pEFAfxa3v4sWZxCptOyn6RnJaxdTkCYg3
	aZwQKQWuFxs2zMq6S3JUdCrn++8Ghg78Tx2wqGNZ5/H+1eLtgdomUK04LfcFpDu+HLFLpM3kH6+
	IqUfGYIFgezDMrEkD0M8Wrw8S0l6VfvydBYw==
X-Received: by 2002:a05:7022:e19:b0:12c:61fe:fb49 with SMTP id a92af1059eb24-131967d7c1cmr6928969c88.6.1778265220522;
        Fri, 08 May 2026 11:33:40 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm3395907c88.9.2026.05.08.11.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:33:39 -0700 (PDT)
Message-ID: <6b5d2268-ffaa-4746-87d0-8f16135aba44@mojatatu.com>
Date: Fri, 8 May 2026 15:33:34 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net/sched: add const qualifiers to
 gnet_stats helpers
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260507221948.335726-1-edumazet@google.com>
 <20260507221948.335726-6-edumazet@google.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260507221948.335726-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F0824FA9F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 07/05/2026 19:19, Eric Dumazet wrote:
> In preparation of lockless qdisc dumps, add const qualifiers to:
> 
> - gnet_stats_add_basic()
> - gnet_stats_copy_basic()
> - gnet_stats_copy_queue()
> - gnet_stats_read_basic()
> - ___gnet_stats_copy_basic()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> [...]
> diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
> index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..3b2f9ea2eb072dde792aad5b60cf00dcc2efa76d 100644
> --- a/net/core/gen_stats.c
> +++ b/net/core/gen_stats.c
> @@ -124,7 +124,7 @@ void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
>   EXPORT_SYMBOL(gnet_stats_basic_sync_init);
>   
>   static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
> -				     struct gnet_stats_basic_sync __percpu *cpu)
> +				     const struct gnet_stats_basic_sync __percpu *cpu)

This seems to be causing a compilation error:

net/core/gen_stats.c: In function ‘gnet_stats_add_basic_cpu’:
./include/linux/percpu-defs.h:238:1: error: initialization discards 
‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   238 | ({ 
         \
       | ^
net/core/gen_stats.c:133:54: note: in expansion of macro ‘per_cpu_ptr’
   133 |                 struct gnet_stats_basic_sync *bcpu = 
per_cpu_ptr(cpu, i);

cheers,
Victor

