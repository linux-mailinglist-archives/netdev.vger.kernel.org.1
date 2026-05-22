Return-Path: <netdev+bounces-290786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEgEIqhAEGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76E5B3245
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 257873029CDE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642293E5A2B;
	Fri, 22 May 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axJHsxK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3793E5566
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449456; cv=none; b=AwB9cxSR6UaFWjMSNT+1xagGHvFQ2EiQP4ooAaEOUbYCd0C7Dx1xb7J8PxBESPgIQcVbMOdtM3Tox1BmXHVxqarlGnC+8MWfSNiWd7N6J6NEUjWqxV+7vjrDG1797mA1Qbd9ainaKTV3xvxetB7B6Fp+jaRvKPDUeeMkzQNw0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449456; c=relaxed/simple;
	bh=H1nmy02gyGOlKuhMXt0+W8+FdecET3kpyLxWGI/LBlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhX9S7OAAXBO5pRvISxiexgpoFhxXaLgwkB1hMHn8gc2oXRjeudy4XaP2TUTXgOE+FKU0kQaUZIby6DxFmr+gogO743IWWz3o/3klrv6HnuBcGhGUunn353UbrNzc6RA6rjMAtH/P9VYSHU8UHh2vOWlPm3HOEDPY6SLzZfLSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axJHsxK1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b0786beso49651405e9.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449447; x=1780054247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwo6XBm3FfgxPraqk1pyuNtv1lhcfsjOcWanxd4FgRU=;
        b=axJHsxK1t/meeB1t9e/hr8hBvy2+U5QbBxEeh4y3IPijRk+wyAiZinkEFbsiFrcptk
         c2vPBsHF3srDC+fmUAKsaRuHVNbWyvgEHvB3Lsa42xXJZ/ShttRfHDne8JbegRs9aZuP
         +2Ky1oY7643XBbeWtJj6wS3IY4x5xks72nlQtnUqjYlRVQAp4EPfGWI2gb9GkyaquR2T
         aJo25MTalZWxX6a1xbEKbUZEakyI2ldAnUWDxwCJ48cF35m1HIdoAUxwP/xo3Nz0lp7p
         ixgo9+ecEdiNhDQmr4QKKM13080ocZU48ikB+Wu+99pL4DZKi3THZ6kWzU5Dr/Pfq8sO
         FdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449447; x=1780054247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwo6XBm3FfgxPraqk1pyuNtv1lhcfsjOcWanxd4FgRU=;
        b=E5InEzaynWW3HYuDJptgHLQ6vIxMSCFrGpKdJISCYUjTcack0Fu2khyYNCG48q6ZED
         2lFEHpP3r66VY/c9ACfaAowuRqkPHRBoto8h2Vy8J2aQ9QN7jqVbf491s4qi/+6d6DkL
         IrQxeBLOX01BkpUTatPhxYk5Nal4nyaol1AzVNHb/n0opS7kWDrBFbP/TaTh850uS3MI
         ES6AkMZ2lR2QLoTo9EB7wDZUgGKGu3o+IuU55tHjNUPQy9tXq/5/9o29sla7nMzWLqO7
         CfwH3DB9EQlxb4hUR02GvO5ZhmTUg5MEVIms4cOSNtAS9ueqw3CsndzUkV43PTR6LAVR
         CH7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9EhNpFXH5ruzQ56BZq21jGWnGefgSersh3AvTdQE0Ymw+J5R8bTne4t93I+x40f28mHcqFaJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTajcBqowlbReixRHWq0sx+FM3rLk5gD6YAfB/g8555NwErSZI
	0sSkAL1AeUDMn19QN+Mg+CzDcdpcbkPDWKaU1J8ebwF2kF2ZVvUtSKp5c5y4dMfI
X-Gm-Gg: Acq92OH/fwnCCfhEbw0gCFQJ0noiUy5n0y3NzjM6sMTSrEn+GmC+TSv5zLABmdm0WVi
	xEU1JxnrMJdI11lNgU/uImRZblUYypRZeIZLRHWjPk/FoNZCmXmvnjOuMNfJdxr2lQvTHSDSOKx
	yn5KZjqRlfvB1rhXKG4kuhHtSVlS59jrXNxH3fgHbZuDGAH9xzwkKkcNJ7Novyx/ifIwcHQirHr
	7raWlARrQPIZC2rvPjF+1RLBh8cA09yF1ydpCQ9BpBjY8bIZLNgI2cI1ftshJG6FougQXfjZm7A
	DY6bsXNzYq+8iUkW0cv4wC8+QcuL6bD40qjtPbLtN4HW09eicmNmQJT//ezDRcGhyaGaiW3fTq5
	p5GaoBTELGxfBxD9olOFMOFCCq/XUcTNknMmY2TsBu47Mp/8ZmUK/5/Ya7IlSWwfGMeAYGaLO89
	UtLtJeLde0nHnPx+8zYMzLms0DzQ==
X-Received: by 2002:a05:600c:a402:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490426d079cmr30955295e9.16.1779449445633;
        Fri, 22 May 2026 04:30:45 -0700 (PDT)
Received: from [192.168.8.108] ([31.4.50.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042cebaaasm14273845e9.36.2026.05.22.04.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 04:30:45 -0700 (PDT)
Message-ID: <ed9cf618-a5b6-4343-9f20-b51b3814acaa@gmail.com>
Date: Fri, 22 May 2026 13:30:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ipv6: exthdrs: refresh nh after handling HAO
 option
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, yoshfuji@linux-ipv6.org,
 nakam@linux-ipv6.org, davem@davemloft.net, yuantan098@gmail.com,
 bird@lzu.edu.cn, tr0jan@lzu.edu.cn, zcliangcn@gmail.com
References: <cover.1779247873.git.zcliangcn@gmail.com>
 <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linux-ipv6.org,davemloft.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-290786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 1A76E5B3245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 11:42, Ren Wei wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> ip6_parse_tlv() caches skb_network_header(skb) in nh while walking
> IPv6 TLVs.
> 
> ipv6_dest_hao() may call pskb_expand_head() for a cloned skb, which can
> move the skb head and invalidate the cached network header pointer.
> Refresh nh after ipv6_dest_hao() returns so any trailing padding or TLVs
> are parsed from the current skb head.
> 
> This matches the existing pattern used in ip6_parse_tlv() after helpers
> that can modify skb header storage.
> 
> Fixes: a831f5bbc89a ("[IPV6] MIP6: Add inbound interface of home address option.")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> ---
>   net/ipv6/exthdrs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 47c5502a34a2..751e07392aae 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -201,6 +201,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
>   				case IPV6_TLV_HAO:
>   					if (!ipv6_dest_hao(skb, off))
>   						return false;
> +
> +					nh = skb_network_header(skb);
>   					break;
>   #endif
>   				default:

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Note that the same issue applies to IPV6_TLV_JUMBO (hopopts), I've sent 
a patch to fix it as well (see [1]). Which makes me wonder... at some 
point, we may refresh the nh pointer once by default, regardless of the 
option. The impact wouldn't be that huge, and it would avoid missing the 
above for similar (new) cases.

  [1] 
https://lore.kernel.org/netdev/20260522112013.12342-1-justin.iurman@gmail.com/

