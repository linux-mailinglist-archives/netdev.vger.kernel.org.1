Return-Path: <netdev+bounces-272545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPxLHT12xmnSKgUAu9opvQ
	(envelope-from <netdev+bounces-272545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:21:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AE344205
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 853A03076797
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1239A7F2;
	Fri, 27 Mar 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lmsKCsEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31C35CB9B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613968; cv=none; b=Z7ylcRGY+FuwANb551piY/5wp7F8DiL0ExxJATe9FP6fTrX5vNeSaXlq6TLJySqSx/2QbOZh7dBiKEiJQ7TBmkBUcUYH557xU1oSyoCEZk5v4GkGqO0w71N04RWJ3q5ObRMeC6XfFgN6zHlV40QjssZu5nxAsAd8gPKpdwBBqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613968; c=relaxed/simple;
	bh=PqtqR/6h0NC60cTerLw5KDXlizq+v+vVVirZ7vHZIx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo5C0wN+BeFgRug/tYCykhBlrPfezuPpCzagadl4hoPD3/eqKYYr8GYflRQykfNFAeQlDlZMHcK1GtKlnQY0WZjJd02r/WMhWrYITPr2/vHSDOEm4Qnaro+SaZo0rpGAw4OOp64PzPmTS7+X/N5pj1rDgxOiE6d7dGR1lbi4/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lmsKCsEu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so19503035e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774613965; x=1775218765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zimsPVsDumOVwRCe4M573NwSIeXesqqtNX9MQ4nuFE=;
        b=lmsKCsEuHvZIO12LjzzCgNq7+Y1DWX9U7+ZJACip59PNydO5T3plHK3W/09pK9PYBl
         P2kRcH951VMDGVzms7sNXxiIVPdKkOwvl2SBLz9ZXAHDKPI96RQ344u23Tt23MqTsH/E
         7HnSUdjkumT8k+KWWm9yvyBMf9M2Gj5g/pAMnFFPNBRNabKA6clPlp05/KSSldGrwRxb
         wPhOL+l15fCQhKznT167HNGck+8j03f1RwJmHWs8V9QVUhZJOy1ciSf/9dtcS8Wu4+Bz
         ss1SWfgPR34v6jpyybqJ9r/qxuJFe9YziZTpI/wa4gWEogObtF7F39q7Wx2MJlOo8YKC
         lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613965; x=1775218765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zimsPVsDumOVwRCe4M573NwSIeXesqqtNX9MQ4nuFE=;
        b=HiFfKjhgnHArzvzGqeER+/hFPWciadYHumo/IBWq9GO3b4BZ+Y0+gUqPJn9Gh4QO3B
         KwvpX9vuqe5E55tjO0/HPl4bDsCN3BGSR6KQjnr2TAkoz0XZGxb8KDLKBSmi/gGfvnhU
         lk3CDqWbC6OAu0LAglAKH65ldajGQ3S44yPZm62AYLujYT3nnoV4Unx66JvQvWmb/cHD
         fS7v80V9Vqt/w4VfgNUuU+Y5D0wxRcGUwetGg4+ibGTi2Fkk9SWjCrkKvi3pRovi6ofd
         qF/BX0pG879aOZss+B+oXfcxuYnPBF1TJTwzpfVnAE6qe71yD756KVNHeOhNdjFMR6yr
         5KgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHYno/P2Mw+zqogdft6QPgi/vC7cCe3/hfZc1W5ScChF9x05iINeMIzU8rqUbrC4Yy5QbAtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrZSC7G7GHad2MehiGzp65omnFvvHYtk3LbvrWJcjgtj7aNd6
	e0qn+/mBAZWCn91Dl+DwwcUV+CjsKRb9uEIsTfdYaDfS0ITzgmfmOQFxunvNs2eqWCk=
X-Gm-Gg: ATEYQzyHJ+m32wu35uP1oJCp+2HxioxsB/lNKDQnH8fngkx5tIHBw2mNpZnQCfS5lht
	Sjllf9D8NfiONaaFxYi1zuvRvGT//huuhsWPQURZP3vhoJQxDe2O2gnV+Pu5j34EvqWNjUZKHZS
	nravWC5stlcyfYjehNqgIJGr6nbBmgMgKUN6S4c3VD6WYShFAIMx5AMOz1/Sx8swtbbUMq6SZvU
	GAQBOfCvnOXO0YUSuLPalYdZ2hY177r0JXdzI6obnBZ2cOv73inlsrYFBItkt8Qfzj/Ppdj8sKp
	tjpl5ICY2IqNh3VdYviGGG6EAGVkPeP3tgbZXR8Ax6+glm4tTrDc1+WxS7fzomlxAjU2RaYSUaJ
	rebrUjYuTHas82xPMsjQzylQWg4236L3N044btiuxEWbupWTGWIwlEY28ZsxpQ2nWhtB7RMNhVX
	oOJKdpQ3yE1tebwr2YjD4+eK5cBlfuvkAW7qgi+mOGjfd94OT14m5McQ==
X-Received: by 2002:a05:600c:8b4b:b0:485:3fe6:21f5 with SMTP id 5b1f17b1804b1-48727f0e5f8mr35058265e9.10.1774613965289;
        Fri, 27 Mar 2026 05:19:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d38a5fsm86886705e9.12.2026.03.27.05.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 05:19:24 -0700 (PDT)
Message-ID: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
Date: Fri, 27 Mar 2026 14:19:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ipv4: igmp: encode multicast exponential fields
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
 <20260326150742.50289-4-royujjal@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326150742.50289-4-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272545-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E82AE344205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 17:07, Ujjal Roy wrote:
> In IGMP, QQIC and MRC fields are not currently encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any raw interval value that exceeds
> the linear threshold is currently parsed incorrectly as
> an exponential value, leading to an incorrect interval
> calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC and MRC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for QQI/MRT).
> 
> RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
> a floating-point value as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c | 14 +++----
>   2 files changed, 86 insertions(+), 8 deletions(-)
> 
[snip]
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1438c023db62..1de6242413e0 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -939,7 +939,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	struct sk_buff *skb;
>   	struct igmphdr *ih;
>   	struct ethhdr *eth;
> -	unsigned long lmqt;
> +	unsigned long lmqt, mrt;
>   	struct iphdr *iph;
>   	u16 lmqt_srcs = 0;

please keep reverse xmas tree order

>   
> @@ -1004,15 +1004,15 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	skb_put(skb, 24);
>   
>   	skb_set_transport_header(skb, skb->len);
> +	mrt = group ? brmctx->multicast_last_member_interval :
> +		      brmctx->multicast_query_response_interval;
>   	*igmp_type = IGMP_HOST_MEMBERSHIP_QUERY;
>   
>   	switch (brmctx->multicast_igmp_version) {
>   	case 2:
>   		ih = igmp_hdr(skb);
>   		ih->type = IGMP_HOST_MEMBERSHIP_QUERY;
> -		ih->code = (group ? brmctx->multicast_last_member_interval :
> -				    brmctx->multicast_query_response_interval) /
> -			   (HZ / IGMP_TIMER_SCALE);
> +		ih->code = mrt / (HZ / IGMP_TIMER_SCALE);
>   		ih->group = group;
>   		ih->csum = 0;
>   		csum = &ih->csum;
> @@ -1021,11 +1021,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	case 3:
>   		ihv3 = igmpv3_query_hdr(skb);
>   		ihv3->type = IGMP_HOST_MEMBERSHIP_QUERY;
> -		ihv3->code = (group ? brmctx->multicast_last_member_interval :
> -				      brmctx->multicast_query_response_interval) /
> -			     (HZ / IGMP_TIMER_SCALE);
> +		ihv3->code = igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
>   		ihv3->group = group;
> -		ihv3->qqic = brmctx->multicast_query_interval / HZ;
> +		ihv3->qqic = igmpv3_qqic(brmctx->multicast_query_interval / HZ);
>   		ihv3->nsrcs = htons(lmqt_srcs);
>   		ihv3->resv = 0;
>   		ihv3->suppress = sflag;


