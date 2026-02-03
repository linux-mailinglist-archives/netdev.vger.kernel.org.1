Return-Path: <netdev+bounces-256190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN8PBI2xgWloIwMAu9opvQ
	(envelope-from <netdev+bounces-256190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:27:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A813FD63A0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 052A5301A915
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FB393DEF;
	Tue,  3 Feb 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwiXdTgl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2+cxwfW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC739449D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107273; cv=none; b=DeqeAQDdh1X5F6HDxyZCOyAt7ke4+JsFku4hGBDCtmmmgtKQroXCirTqJ6IFzb9Qpzb8/Z/aPw9ZZyGWPDcFXCRoZC8As8RQhFSRDtsu0bZs1W9bN1j1LcMTN5Pe3yonoSJyQ9lMWTaizA8DNo9TNxqUsNIkR60q7RJj5fgkb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107273; c=relaxed/simple;
	bh=Bc/c9zaxL/eAQgO8mi+sZhXVLgFBxiqM9sNMXxqaEwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4KNmOn3+5YMnhFhxf9SBlYa6MyTEoIMQTVU+wxoPtzrPkvNwuWZKBSFKZN42MwRem+xFhToNL/BHLRxppuAD4xDkktdL6QqtE/KvHtP9VvkjifQAEl7zgXOmSfgS7Rnrvi7VRMkFjnOjF3xdVRIgAZgmJ66IUw0SVpR7P/f+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwiXdTgl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2+cxwfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770107269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4ltkbJKxfMrhICZondDFopFyJ6DJynHUIc234ljrno=;
	b=FwiXdTglFraozDpqgp20zyezPwlF6a/027DM7Sf+SwQJJRqxI/85GEmCj/5UI5B6BMMOg2
	SBGI56A/waFTfoEpeU/VmyNR+O5lbn/TjXcI+fXlrYeaq/UH2QuAUIG8o7JKIV7UbeQHc7
	weUdSnsbn/xWRnP2SdRmAe53YPL0eow=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-CC0ScKvgMYOQWIYio9lP8w-1; Tue, 03 Feb 2026 03:27:48 -0500
X-MC-Unique: CC0ScKvgMYOQWIYio9lP8w-1
X-Mimecast-MFC-AGG-ID: CC0ScKvgMYOQWIYio9lP8w_1770107267
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480711d09f1so72795395e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770107266; x=1770712066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4ltkbJKxfMrhICZondDFopFyJ6DJynHUIc234ljrno=;
        b=H2+cxwfWJ8tXjrYnneVzKND5xobSFYWTe0ihS3CL5c0BFXwdhPbY35OaTszo9ectD3
         iPOadFagGL6Zy0VK+cp0WN7bBHuFuXktiCoeCRVMnCufNnZTBA5QHcoQzQNjCzqJ2KLQ
         pch+dAcrNJ3KLvhA30QX97hdxdNJq5LF8Ymb/mfqr85CNkYMN9eL0EGiBh4Tk8vwl/uO
         tehR40IHQZ/OZAD5AQA6Xx2IgtIKZEY2lH3M8PDQr/H/GwpCR7OGJVZjWCZXSbrmsEU3
         QIMdzU6/hweJmPDi6oSc37fIS1ubZbKdQ3/QpP8kx/aIiOS56/OiuWw4eBHZszj/lDhg
         U5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107266; x=1770712066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4ltkbJKxfMrhICZondDFopFyJ6DJynHUIc234ljrno=;
        b=pEfNWruyMkLf68djYNewyPDyVZ91YgruK8hwQatILW5+Gk+DJRHIqgNiJQQC1lAAAW
         OjziI2SPT4Zgk9DSOXnM5/Cu1Q442oEFfKtF69rdMgNB4IBsRWOORz8qCnRuCp9cwrWw
         vM89ygfBO8bigaXSiFXs+x5QhquElIsXuOcLz9byd8H8cEC/z2DrHC0lAVKhm0UDlVG/
         Jwlc47lMdw9CtzGF48GgcOamkOK/7B3xvwiaKW7U4j61m/l3RrMbgnbpt9XyMmOrC1Zg
         HQrHWAicJzXV44B/AdZJW8xA1IqILY5I7+vjbp+g2GoPs46Aqyn77wj1hb1SPWQ8NVCg
         cLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZRV7YvzXGzXSOz/KVx5k/ehkK7b83QvYvsKtbPU66X8U4aKhDL5EDnPQuZxSzgLY/+w8O2d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2h9MQ6KHuiCi2/9rCQhTpr2RDtnEPlm4kpBB0H8z4pKeJ8O9
	1V7vq+7Jxo/sPCWeFvxTorjZfF2lyIOnqIzrYtj1A7XQwlRprUSsbBUBvLobPnM8rn/jnqKwBb2
	c4KL/rZfAj7hJ/UW55KBu09EWbt6krr89n01k+SzQk0aaj0W/H+SFiJmVK8t8XPj0Ew==
X-Gm-Gg: AZuq6aKdnq5mKODdO7XaJHh4wyhg2hHF288x3jTefAtqG6BxPl9hRHd4uwdfbXrcp1J
	nm7EvqaU1yrjTYq5Znxwsx9+qQaFY/lXvXFzgr+YbXTzGFJ1VyQeI0az+AET6eivTMluKj5mHRy
	8aO9m1qGwfVgea8W1k1ge6rRFaS571QxpM6R2/0bAsX9X5erIpEM9Km14WJU9+kdDrr3e9udBVI
	KUsOMnM2cNFcRgwra8Xms7Lg2mpPeaoZFGhaYQBHxwJdOIAFCF2q/bb1J4o6dP9diq58rFQ/ujy
	3L8pS10hUjij3OO2e53OCAIiIqZt8GAWdMucuel2vI4tHuyD0NFosehxZSa2EipT5FwgPeTmNmb
	2mWBLKbUtSis=
X-Received: by 2002:a05:600c:5297:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483088759f8mr16309445e9.35.1770107266584;
        Tue, 03 Feb 2026 00:27:46 -0800 (PST)
X-Received: by 2002:a05:600c:5297:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483088759f8mr16309115e9.35.1770107266116;
        Tue, 03 Feb 2026 00:27:46 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830513352csm47149135e9.10.2026.02.03.00.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:27:45 -0800 (PST)
Message-ID: <4f57fb3f-3d33-41d7-99e0-7867395ce792@redhat.com>
Date: Tue, 3 Feb 2026 09:27:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 07/11] net: tunnel: convert ip_md_tunnel_xmit
 to use a noref dst when possible
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260127070452.6581-1-mmietus97@yahoo.com>
 <20260127070452.6581-8-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260127070452.6581-8-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A813FD63A0
X-Rspamd-Action: no action

On 1/27/26 8:04 AM, Marek Mietus wrote:
> ip_md_tunnel_xmit unnecessarily references the dst_entry from the
> dst_cache when interacting with the cache.
> 
> Reduce this overhead by avoiding the redundant refcount increments.
> 
> This is only possible in flows where the cache is used. Otherwise, we
> fall-back to a referenced dst.
> 
> This change is safe since ipv4 supports noref xmit under RCU which is
> already the case for ip_md_tunnel_xmit.
> 
> Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
> ---
>  net/ipv4/ip_tunnel.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 2136a46bcdc5..40ff6ad9b9b9 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -609,7 +609,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
>  	if (use_cache)
> -		rt = dst_cache_get_ip4(&tun_info->dst_cache, &fl4.saddr);
> +		rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache, &fl4.saddr);
>  	if (!rt) {
>  		rt = ip_route_output_key(tunnel->net, &fl4);
>  		if (IS_ERR(rt)) {
> @@ -617,11 +617,12 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  			goto tx_error;
>  		}
>  		if (use_cache)
> -			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
> -					  fl4.saddr);
> +			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
> +					    fl4.saddr);

Similarly to what Sabrina noted on patch 4/11 it looks like that:
		else
			ip_rt_put(rt);

here will avoid a bit of later conditionals. Similar note for patch 8/11.

I must add that the amount of code churn and possible regressions looks
IMHO excessive for the reported performance delta.

/P

/P


