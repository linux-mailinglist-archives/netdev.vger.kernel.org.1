Return-Path: <netdev+bounces-272084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOKmF7k/xWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:16:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0735336A8D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21C1730B0621
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAC33EB1B;
	Thu, 26 Mar 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSBbFzzB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E833AD81
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533942; cv=none; b=hhq5qysRRDyrTAuAH5B0me22ccBqbHcViEGVG4YkKwTaLl6qWx3zt+Wp2g/tf8490ehMyUjuM0xzckxYTmmxsSIw7ybrCh4lcZatpf3ZvmWw7mJYHLvQjolhWOlDI7cKX3ZfDdiN//LRM57Ka56NmoQpxaNAR5DlVKhAaciwgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533942; c=relaxed/simple;
	bh=+P/UaSSOrZzUsHGMRUaucczR4HHnEzzY5ibe0fyS/zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwzVJh4AWlESsHpE9smAiO4zaj5VpJwhanDTcU45POO+VE5RyaNb4EWhekRRj5VnN6+sosN4MB7z5a2F360GfOSeH2uCRXqSDHUJsAFC5ilWsdc/6CGOF0VLCO79GHDU+lTGgq5yWg9bOgT8QD5bl4Ox9ajCcHrhYnJmmPLqIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSBbFzzB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so132742666b.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774533936; x=1775138736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHl7tocSnGmIBgBLm+xo8yjHEwMa3jnz1csUCNaWtac=;
        b=fSBbFzzBrm2ZZrbtwsqEJOXnicMSW0NLxvNaoSm7Pz75vsudXAh5U2LoGcSN3+Fc7b
         Asp7JVm1kUCvgdUYHYLyOJ/SWUWoLfAMLf3FSxsIflcLPcfgBTYCXvA4l9OunaxyxoAc
         mp20mLHw1iiskjRGdk/9nK3xpib0cZfrw585TarBJFakvs6mjVHpUmrNVHCV9Cawka6c
         RndZabTREjJQxwQzPMeo9ffyudlDRZu30qjs3nne+0s3DAbePln5zgBd4t9lXMXHueV6
         3CzMf5EBRhywS7Q15v9rioDKJJnom5vnbxdqHGKjXGoXoZPURWXZOR/854LmAr9F7OXn
         /EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774533936; x=1775138736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHl7tocSnGmIBgBLm+xo8yjHEwMa3jnz1csUCNaWtac=;
        b=RNzNG9InlawVqIr540owqGkMa0Oq4pHdB47kvgjFUyOhGIb8+1g+ykO0o6RvpgNYBr
         +DU7L3Hb1e36Q+7YTzjBGn25r8fz/vG9XdBelbCDWKjRYFd8ekFr03S0wep7Eq/7GhM0
         D+FGhUsKedN+eLWkAIVZn1LXczYk7Iq2m34uYq9a7oH8Qw1pPce4c+PEsLVj6wbTaUot
         yQOHGaYD11Y4W0IXWi86Ask3LOPFMQp5+cNh2wFP3qPXv1zKdzQPB4LGXVOnBvBNqNuo
         bDGaeCs7Rhzy5xOFVluh/G9D+reG+1KngWmEaB2mqA/1Ku52NLoh4L3tfwFjGuwbAuEG
         02kA==
X-Forwarded-Encrypted: i=1; AJvYcCUbAsfwxsJd/+FMt1RchUBdBFcpkAeSk/N0/gSmWIi/2JC3qZcCfC1iG1h4Ivi+rBfi5oFIMnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaC6Kd1q23s6R3TdGCprMCBUTxvXQ7BDpuSn2Cz4npeVrwu4LU
	oSKivIHVRF+epOCLNa9qPJdIMu5UQZ3mVCh72OyGUA/sEoYueHaY7L6k
X-Gm-Gg: ATEYQzy2RBVkhVEBRVzFse62FxUfu4ndkLYB5QKLiDSTKN8uoQipk6fiCzKla2xg3nA
	nzz4Oh0eWHiS9dvi5RyQFTWvnKPzbtl7hv0+HKdqlNZJMWqAlisrl2DLITtszzU1Aa+VJ+B/Qcx
	XxCZ5e1ySwO0a4SCYbC99aTg2P1oZSVQF0gmJnQgvmRxEhMmiaeXACKVja56gznJmMd/ppWKQnK
	yvW1JWRfqJSClP+NBUjWmGf4hRJFcPA4fuCA0djhLf1aPVnTXry0F0Q4YpAVaVpS2QmrN+xf43f
	wpMd4RBal3HdFeVLGh3t39+rSYV0mQKeB22T0uUvZg4C5V18BXLop05hpr2NTtyjG2lpcrOqodE
	qlbe2+jQp6tI5dsL5k2sI4GHWaMVCHkVldjnlwAb2g00YhIydBEvlx5HgaVyfhvipxKQDr87CeZ
	6ozxTAIuvXt0rzfaAZpnDyhKiGCBP2kh4dYDAqGwMomnLAwHdTv9etkXqTwoDlpN61Ak64NcSrz
	+hreA==
X-Received: by 2002:a17:907:c30e:b0:b97:bc8a:f45e with SMTP id a640c23a62f3a-b9a3f1665d2mr499473466b.1.1774533936094;
        Thu, 26 Mar 2026 07:05:36 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:41b0:4bee:eddb:bf6a? ([2a02:a03f:a75e:9a00:41b0:4bee:eddb:bf6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203eeeccsm127701166b.44.2026.03.26.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:05:35 -0700 (PDT)
Message-ID: <a17ebe6b-ea8a-49e1-8993-2989ae57821d@gmail.com>
Date: Thu, 26 Mar 2026 15:05:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: ioam6: prevent schema length wraparound in
 trace fill
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260325074152.17064-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260325074152.17064-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-272084-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: E0735336A8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 08:41, Pengpeng Hou wrote:
> ioam6_fill_trace_data() stores the schema contribution to the trace
> length in a u8. With bit 22 enabled and the largest schema payload,
> sclen becomes 1 + 1020 / 4, wraps from 256 to 0, and bypasses the
> remaining-space check. __ioam6_fill_trace_data() then positions the
> write cursor without reserving the schema area but still copies the
> 4-byte schema header and the full schema payload, overrunning the trace
> buffer.
> 
> Keep sclen in an unsigned int so the remaining-space check and the write
> cursor calculation both see the full schema length.
> 
> Fixes: 8c6f6fa67726 ("ipv6: ioam: IOAM Generic Netlink API")

... should be:

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated 
Trace")

Respin needed? Otherwise, LGTM.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   net/ipv6/ioam6.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> index b76f89d92e7b..3978773bec42 100644
> --- a/net/ipv6/ioam6.c
> +++ b/net/ipv6/ioam6.c
> @@ -708,7 +708,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   				    struct ioam6_namespace *ns,
>   				    struct ioam6_trace_hdr *trace,
>   				    struct ioam6_schema *sc,
> -				    u8 sclen, bool is_input)
> +				    unsigned int sclen, bool is_input)
>   {
>   	struct net_device *dev = skb_dst_dev(skb);
>   	struct timespec64 ts;
> @@ -939,7 +939,7 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
>   			   bool is_input)
>   {
>   	struct ioam6_schema *sc;
> -	u8 sclen = 0;
> +	unsigned int sclen = 0;
>   
>   	/* Skip if Overflow flag is set
>   	 */


