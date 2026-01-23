Return-Path: <netdev+bounces-252970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AoDMVHlc2nEzQAAu9opvQ
	(envelope-from <netdev+bounces-252970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273097AD9D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E6F73037E43
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BE1F8AC8;
	Fri, 23 Jan 2026 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZoZlHcc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC21C5F1B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202994; cv=none; b=W9kmqtjJ86fBNt845jQfKf4CbboQikQg8+i/xHPbWRxQXE3q1SgJrD6qSmPfUTwpV6C/n89tiarw8BugjarLvpgkYby06VIsJOCRe5Jhr4qbWRnX82C0YdpeMyWLp10+GyxWw1IeKgvLCALDxMJFfekffsU3LaDaVAUDUjN6Gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202994; c=relaxed/simple;
	bh=jZ65mtrIh61iI72OrbJcAu/9pucAtrcTzfDMF9B7m2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PkeG9/VzxQcjUpYwexy08KPmYkZ2OVtK2Z206Mh8TjSyIjBs8O5/bfDFj0Sl1zxwHS5Qc/d1IUQCr1n7KF4BRthMnrcdpRo80H64FTmR6GMaMBZClIc/iiqi+qqwUiDfg13maX3lDxX2q4z0r+ytDP18yPP8FxthJhBL86iqGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZoZlHcc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4358fb60802so1542338f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202992; x=1769807792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCtU053PUoWUs1BXXRkhAIg7hyO65zq/+nHwYKqxXUI=;
        b=NZoZlHcckZC/iEvHI76ybYT42TOqVstma28lSD+8z1vWdxNINT2yjgY5klBuFDtH7w
         Ztz2oXJgpq7M6NtHq2a93Ed3p0dRXHXcgbNxOo05b4GCC3T3PpX7ef/nke5Wjrp7Xqd1
         Q7iffGD+3D8JFPS3Ni85d9VoUW6U3tZYfYLyq93EP5JL9fK2EGgp7w6MkX7VbnB8dmnF
         NnX3dDyXnVfRDI9iMqxLJ1W6N36O17/uRkzrkyV9OtQ8LECoT4G+5BzjOT02j7Z2pyA7
         6O83pUdC4kMIlz7U95znrMcKyk/Gs458hl6wZxxrHOMFOmkQue6K1pQ/mxPbmy4JqbYe
         0xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202992; x=1769807792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCtU053PUoWUs1BXXRkhAIg7hyO65zq/+nHwYKqxXUI=;
        b=oyeVBYXFe04FjLWRCYfEBPCsiqrxUtwwhngc9GpTc7VebIkP0PDgAeZve2LOqAuXLJ
         rUfJpqHpy3VPnHJUgPfl2Emg94LJQDUEkru2tlZ8UvBxpShB8wtc4QTIBr7wUvHO3WwQ
         OJ76JZ4uTHbWZ+BIT3UHce7AEiLEHPDU4Q6/qbzRS/4JBGlwHmaGGq70qgAvieitorH/
         puL6IsKu7V5zOfEiSPTZaJl4ibRWxzD2gZxRSCEkcpkN+7+LqgNXmje+4Qp2efvIX3Ox
         iCsJwZSgDYM9M3PbZPHtQ29KeOpWND8RmwaMGHLpvReueETB6dohY+QtquSQFRlSWyNq
         9+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV97Xr8l8BpI/TQWkl0m85oOrv1VvS7k8kK8+0jD06U/IrBIEasC2ab0RzH8OXy1c7iS+Vu6Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtzZ0IVOglULnDO2A7VovAOVrKcureJraHlDvJmzxn0wRT5Yk
	nOHeI896JDL9ZxCzQwcIh1Rdqqj6tO4oJ28/WEY90TqWixC6FDPb4IIHZGNPhh4h
X-Gm-Gg: AZuq6aIMDbj8KXHyDqiAoJrJlCaXVn/R/gzMXxlexwQaW0Y7bRbjNZDFAJg8ZHlCCth
	wf9sihwT7qGBO0M4IZ6rpSTXIl8bVLncJTTwf4ifufygC2XbEjWYBNSbWPeITqKgTqBfT0ZielX
	YgypsyTj3eX3hlKp6Ih6XmfTNJpigj9HLEbniOLKxoM/1NNZsd+fnDDkWq/g4tMGDzVCxqrtFMa
	wFC+BAftJHYVciCb0m3oqgtsr/qo7+qx12Nd4pE6O/9Zn4xDO5nbjo0UVhly7CgsbEvyZqMJFxD
	KR5ombfIFDL5ZsO6vPtOzmPMLc7HfFWbky45BoIXOsrmNZ+/3pjPsVoT6xGkfjnnKA7vHFJPCRu
	rzHzGdOM9hQePZ0DDKYZn/TpUv20ulh3sPaLluDJibBKq9qrCftddYVei5G/x5w9HimfBV7mrNp
	JYw7iJt/FdkIL2PAcxsOqqVaIkXss/1HODFzXlfCi2RMiaxJy/5cNC52OrlQh8vFouDQ==
X-Received: by 2002:adf:f812:0:b0:435:9e32:2b85 with SMTP id ffacd0b85a97d-435a5ff993cmr11073350f8f.29.1769202991455;
        Fri, 23 Jan 2026 13:16:31 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:b377:103e:67ba:8048? ([2a02:a03f:a75e:9a00:b377:103e:67ba:8048])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm9157914f8f.24.2026.01.23.13.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 13:16:31 -0800 (PST)
Message-ID: <30e7ea41-ed0f-4049-b844-b0d0507deedb@gmail.com>
Date: Fri, 23 Jan 2026 22:16:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/7] ipv6: Check of max HBH or DestOp sysctl
 is zero and drop if it is
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260121214925.112604-1-tom@herbertland.com>
 <20260121214925.112604-2-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260121214925.112604-2-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252970-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 273097AD9D
X-Rspamd-Action: no action

On 1/21/26 22:49, Tom Herbert wrote:
> In IPv6 Destination options processing function check if
> net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
> drop the packet since Destination Options processing is disabled.
> 
> Similarly, in IPv6 hop-by-hop options processing function check if
> net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
> drop the packet since Hop-by-Hop Options processing is disabled.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   net/ipv6/exthdrs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 54088fa0c09d..45bbad76f5de 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   	struct net *net = dev_net(skb->dev);
>   	int extlen;
>   
> -	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> +	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
> +	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
>   	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,

Hi Tom,

You should use READ_ONCE() and store it:

int max_dst_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt);

if (!max_dst_opts_cnt || ...)

[...]

if (ip6_parse_tlv(false, skb, max_dst_opts_cnt)) {

> @@ -1041,7 +1042,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   	 * sizeof(struct ipv6hdr) by definition of
>   	 * hop-by-hop options.
>   	 */
> -	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> +	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
> +	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
>   	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   fail_and_free:

Same remark for max_hbh_opts_cnt.

