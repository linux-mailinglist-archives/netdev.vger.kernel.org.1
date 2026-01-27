Return-Path: <netdev+bounces-253958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N6tNOn6eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:50:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDA298A48
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A21302F245
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8F2FFFB7;
	Tue, 27 Jan 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhXaJnol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629230BBBB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536231; cv=none; b=E3ZTwd1VAAV6zYG55n/FhDU8+c0Ug/PcK4uXCFNoPbgb7911uJ16NdIQ23F2YKfle0y/ncmFYylBrIINeXzCl74PUvqkd8gG+9D7iA1AHGAKYLLRDr1Jq/mcb1OujAj5Uue1C7LyNaO/9jMYKdk9xeZY+wcOcna8RahvKhCiMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536231; c=relaxed/simple;
	bh=ZmUbpYt0h8OB6FNL8iL6ZXUZMWEsMZ7pS0LlZFb26uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gmvbBQy4hQTeVw/XVUQyh6ewK4s60BukKb87FW6y/a+un8ibklKTmjs9cH5Xdw7hFrtWAYn2V9cKaEHIHAiw4P/d6jTB1fKDSiE0cXMj2xIrTcNZ27GZ8nGpuMeiw2VVjSU+2tDlr5I/j4SY2bgeKhX9w2WkH2Y7zvAsRwELu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhXaJnol; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3936601f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536228; x=1770141028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vibqe/KiXQ3Dj5llZDIR1MKDZHA6Cn2HLyE0+erftBY=;
        b=OhXaJnolWIa6417lU28UcYdzWgeXmyyxZVH+Bvqgr7hk1JZCZF3s9nubHJPZkGljfl
         ahguxV+qWtuUDe3i3Tvaj2V2UiL21ImZtFZxGcDxMGRA7cHJyCDIsxUWBaYJl1oOGE6O
         2oepuTmF1amPD3tkaqIZ3nGzOlVIQjts15YeHgJ4KeQ5ScnfIss4oayZUvOp/3VW4s/n
         xVO9wr5bspA8lpRbZVb4NZuIc77UWRvOz01oK+z3T+o6b2B6/S80C7Z0L7mRR4QmlmFx
         pkw6Uia0kYkQKuWgNtrHqeOsDYLKukJzaCW7jCZr04+rkYJriY8Lpuo6W9UW5CoJs68L
         ablA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536228; x=1770141028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vibqe/KiXQ3Dj5llZDIR1MKDZHA6Cn2HLyE0+erftBY=;
        b=E2vrDdMbczSfaAfauU7gpVRjbrHwgEwOG7G6STY7vbBoHQup13dkvELYiDiSfYR7t2
         EVxdrF/uZ6UeThwGqzUwp2gvl0gkFuhjXdo73WziR5D/Sc7VDa53N+OYIzDj3RMRGKng
         /5s54kp0GkmzEVk1BV0KHgxNk75OO6z4SeHA7QIG36NcDc8R+2pG2SH70orkVPZ7hCHl
         e9/WVL60cagD/keV2FpRKcU7Fiq70Zh5+z/fHRBr1VoEt/+KqvtJCXIUWSGb6PU3Gcir
         PorcqgnkO7Yv6peEEBwJ88tZiy5WaisEETqjy3u9RMEkIQlVWrKHiyJzNUmU8mt6N6sx
         kecA==
X-Forwarded-Encrypted: i=1; AJvYcCX43us/sw2l0Mbrbd+ZKICtQtYGYqH2gXVZ537I5+hds3Nprd5sdJTPYwq7teQ3sjvfAGP0Vl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/h6ZOU6Ru5gVIbTtjdJVkLiBe7vUxpUC9zwHnq4ray2Gaxm9A
	bER6heec3xv07Bu+tjSyCNCrpu2yJgvz1Yu4wzIQs8VqMtt0TC5QhTf9
X-Gm-Gg: AZuq6aKoWRZ/YvrwsKsk/dMDAavSDLezUg0ye5Ap26IDxMf+V4h5Ry5/xlDNUcm7m0S
	EV8IT3cceM4FDkq0T33Vh8yFzkcUCh0Z443U909By9rV2EOCL3ZEyxSeaOJhKS86HzQnw8oJ32o
	vVJt1VlbvNsZv8Ukvyo6ZjymRANNaioIUzY5x3+lF/2YaX6h8lsnBoZCDh+J2oDa/Hrp9TnYfTf
	PqXVshTaPeHXsLS3ewwDM4cKfsgXb5b/wXWA99u0vs/lborhXzno3WugtTslKDXCfEyCnjVSzbf
	wwglp7tjD4tf3BrZTKOm2t/tWDFnVnQd1G4Xd1ZjA7RcEiar5Su17dBN0BjciTnOfA/c8ZWpLZq
	PCM6cgbg2frpb5pZMjIre9yKjZvx5qhiFHsVlYWsqzK5PyTen85Ht5c/v8IyuRhbKbeZBLLE7yK
	p9gSMkmVJCuSai0iUf7milAWJayo2TRog4w6+P9PWT19O6XEhskPoxbPafkxkZsWJTCQ==
X-Received: by 2002:a05:6000:4381:b0:435:ad52:31d9 with SMTP id ffacd0b85a97d-435dd086069mr3589040f8f.28.1769536228011;
        Tue, 27 Jan 2026 09:50:28 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322eefsm330917f8f.30.2026.01.27.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:50:27 -0800 (PST)
Message-ID: <6ad428fe-bdfb-41a6-baaf-786663e2223d@gmail.com>
Date: Tue, 27 Jan 2026 18:50:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] ipv6: Check of max HBH or DestOp sysctl
 is zero and drop if it is
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-2-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-2-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FDA298A48
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
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
>   net/ipv6/exthdrs.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 54088fa0c09d..b9d186784b96 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -301,9 +301,11 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   #endif
>   	struct dst_entry *dst = skb_dst(skb);
>   	struct net *net = dev_net(skb->dev);
> -	int extlen;
> +	int extlen, max_opts_cnt;
>   
> -	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> +	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt);
> +	if (!max_opts_cnt ||
> +	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
>   	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
> @@ -322,8 +324,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   	dstbuf = opt->dst1;
>   #endif
>   
> -	if (ip6_parse_tlv(false, skb,
> -			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
> +	if (ip6_parse_tlv(false, skb, max_opts_cnt)) {
>   		skb->transport_header += extlen;
>   		opt = IP6CB(skb);
>   #if IS_ENABLED(CONFIG_IPV6_MIP6)
> @@ -1033,7 +1034,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   {
>   	struct inet6_skb_parm *opt = IP6CB(skb);
>   	struct net *net = dev_net(skb->dev);
> -	int extlen;
> +	int extlen, max_opts_cnt;
>   
>   	/*
>   	 * skb_network_header(skb) is equal to skb->data, and
> @@ -1041,7 +1042,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   	 * sizeof(struct ipv6hdr) by definition of
>   	 * hop-by-hop options.
>   	 */
> -	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> +	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt);
> +	if (!max_opts_cnt ||
> +	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
>   	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   fail_and_free:
> @@ -1054,8 +1057,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   		goto fail_and_free;
>   
>   	opt->flags |= IP6SKB_HOPBYHOP;
> -	if (ip6_parse_tlv(true, skb,
> -			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
> +	if (ip6_parse_tlv(true, skb, max_opts_cnt)) {
>   		skb->transport_header += extlen;
>   		opt = IP6CB(skb);
>   		opt->nhoff = sizeof(struct ipv6hdr);

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

