Return-Path: <netdev+bounces-298364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2gewELQuK2oU3wMAu9opvQ
	(envelope-from <netdev+bounces-298364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:55:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4C6757FB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:54:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=aVwdc+vd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298364-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1809432CC9FA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666A378D63;
	Thu, 11 Jun 2026 21:54:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB263382C5
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:54:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214896; cv=none; b=Ya51rjThjUs1pkIEavGxPU8yJl64Vq5Y6pl2UFDOwf0yapmncIfEQkhqdhXYHNlNiPPFjqTil+8EpdjtZcMScaEgcOcKzzwjMllO0bTGo1RLZ7ic/zqsvuzc8Tp7w2fqy59b8076amG0BBJyCO8uOikzlqulbDcRm3lO/I+YP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214896; c=relaxed/simple;
	bh=hm1Wc+ustaIFchsLjkTtlSftxZa5ZpqvSxbJSnfFq44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8ueRLEvBw2ii/nYFpK9g7b4YyMzDJRfj9d80jY8/Qs6htHf/JfEdGEnrObx1pEfS94fkfrFTf0LOjQ/PFZt1PqTbiW4yW03weijcf+BMIeX+g3Uz8OK7kfJB2QvXCUgarwvpO9lq4LGgSkhqFr5ZyMVxAUcAkb5K84wSpLMgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=aVwdc+vd; arc=none smtp.client-ip=209.85.222.41
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-96393ce9a8aso192943241.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781214894; x=1781819694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMC2fmoKJksWOh42wt9P/JeBAXM+7cbQR42DZ5fGoZU=;
        b=aVwdc+vd7LTIhCTsHvy7wvEVQMR4s5Y3eK3vvF7zjPeW44hTzS81aVLQPxJGbmR1xC
         BLGWSX62xK0LxZaQRx+64eNnDkGtQkUwZ62GfxLyKETU/p1840pSGW/5Y85bHDrY9lXa
         arsX2RfwLZnTqXBRAYevoMNF79OXBsLWeAW0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214894; x=1781819694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMC2fmoKJksWOh42wt9P/JeBAXM+7cbQR42DZ5fGoZU=;
        b=sxR02GsCTSCl6eptkGDXW9T+hVbZNfoso/cwKLVgvFtHJbjYvmWT0m65dcXPLv4nI9
         LumYXA0lWD9oR2VbPNj+1g9/23QjctDt+4D2fR6KDqYcZRp+fdPXt1n2FKiqI5UkcKmr
         l/42vNGsTwlKwcgkOCUgPTtwFFacbdLCgzZv7anoRdJZW4HieUuNwGvP+OwA9G+h0i9D
         lCAjs8utU8O3fDatZNv/93JUpiRqQ+cjSgckEEbaHouMrDIGjd8PwfxM56Vfpx3WHH2+
         PjZ22kts/TvImEwKo0vuesBl2A4VG+QzdJIPbKkv/2tIdivTThKfNgv7RKTSf1Lg33L9
         jTSA==
X-Gm-Message-State: AOJu0Yx2d5On6juLlgJQp+sW8ZwbdMYRCRd77AeV2Lt9lKGig+gICNxF
	efBe02iZZspbF7MYw11KOctoWqzaJ5jJMtFpmvhaewXC6r0aKrLyl8VBHWM5gbwtEC8rQHZb3vA
	2ZOElTYSR/N8=
X-Gm-Gg: Acq92OFFItF8IEH/MvoR0AyRiUdza1k3p2J2Uoir8P5q0ijNnlkW2ugTsi+4UElhqQN
	WxCaVg9BAAMvwVY0MIu42T/GCHsihbVDu7b48k7rQCDkljpzNE4EH2szoHrWdIKivLPgo6/hXEi
	IktBILWJ15PyjlRquK76GFobwjj0tvqT3upwAc2OXJU0kkF5WKTGaou/MV4ErJG7l94/+xAmRic
	tvi7MhlkkmdsKlPDNKRDaHQQPCT2Vp2pIpSSc8y8R/FwykRQPRWKqGC7rXDxfWndtVY1sT9LngH
	JrZhdOdZsbgaMNEz5FM/oAp1PJkLTSVpzzYhxYB9XhqYxAaegJe2kC/XVXm7zKJYI56mwIm7D1D
	d4hRsmsPWpDuzE1Qm1yM+OdWnMoCrdPt+r7cA0M8h45EUqzI9dqU/IsyvFxvzYnTTnY1P5G7x4I
	tJrc26HZz33mBEQZxj44r4GfbJCUNSi7w=
X-Received: by 2002:a05:6102:a47:b0:6c8:eb6e:a078 with SMTP id ada2fe7eead31-71e888f5b7emr50020137.0.1781214894151;
        Thu, 11 Jun 2026 14:54:54 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9667402fd74sm110546241.8.2026.06.11.14.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 14:54:53 -0700 (PDT)
Message-ID: <213d61b0-daf5-48ee-a4e8-bc0cabf74a10@mojatatu.com>
Date: Thu, 11 Jun 2026 18:54:48 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: sch_dualpi2: Add missing module alias
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, horms@kernel.org
Cc: netdev@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com
References: <20260611205849.3287640-1-victor@mojatatu.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260611205849.3287640-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298364-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:netdev@vger.kernel.org,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56B4C6757FB

On 11/06/2026 17:58, Victor Nogueira wrote:
> When a qdisc is added by name, the kernel tries to autoload its module
> via request_qdisc_module(), which calls:
> 
> request_module(NET_SCH_ALIAS_PREFIX "%s", name);
> 
> i.e. it asks modprobe to resolve the "net-sch-<kind>" alias (e.g.
> "net-sch-dualpi2") rather than the module's file name. Since dualpi2
> was shipped without this alias, the autoload fails:
> 
> tc qdisc add dev lo root handle 1: dualpi2
> Error: Specified qdisc kind is unknown.
> 
> Fix this by adding the missing alias so the qdisc is autoloaded on demand
> like the others.
> 
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/sch_dualpi2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index a22489c14458..65d0f4036efa 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -1174,6 +1174,7 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
>   	.dump_stats	= dualpi2_dump_stats,
>   	.owner		= THIS_MODULE,
>   };
> +MODULE_ALIAS_NET_SCH("dualpi2");
>   
>   static int __init dualpi2_module_init(void)
>   {


