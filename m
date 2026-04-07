Return-Path: <netdev+bounces-275937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH6QMCnd1GnzyAcAu9opvQ
	(envelope-from <netdev+bounces-275937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7483ACE3C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96ED3065D88
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7E39B979;
	Tue,  7 Apr 2026 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkPuZGO5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRV4en3M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA763976B8
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557657; cv=none; b=I01Mw7BBH5yN7dBk8AadiExoImLZZBakB+c+neRp4kllZfK3kYNd88GevVhjGl8qKL9sFBzIVCamkX8KQG9+OD92wTWBuI6aSDPOm6sOFzAjM44zVZJY2sI9BlCPsmzlNIdp9dxK49ZTx8eez///nFXJSqgspZGSxN+n7CxkxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557657; c=relaxed/simple;
	bh=bjw97Nq69sgYaOVc2cxlNKH6jJlRKnPqoQcsdCrBRKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VByL5+k92WMjm/Fe2hyOq37CYKmNGyzhsgrFhRx8waLsxeeJ3az0L/Dc3RKedAAkRyz9Ml1l4IZNBkUoe/Kb6CHAJyNKPSwZ/74B6KBeZuo8recY7caJTq4wVQ9UI6RHNrIOCbMaN2mg4p62qi6olddX5ZpWKNKvTFUJkObo1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkPuZGO5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRV4en3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775557655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n77q3qe2X9uEWYZe5PbZjhiPr23OWjrheRwwkTN7kU=;
	b=ZkPuZGO5ZN11gZK99Wv1RK9VjCvPtyVVvQIYuOH3gkY8eoCNVX6J7oKQngEScs/psp6WCX
	Sgba1XaZYxBXuAbdotWjXpfjLgFm3cYRe2IQ3Uozb7og/F3WDrlvLSj2MR/9xTzc9WpLKi
	zdwnBK75S19GyVt+h4G9F6tPJenpyag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Ef5y9hfePXSnsCPtEuX5lQ-1; Tue, 07 Apr 2026 06:27:33 -0400
X-MC-Unique: Ef5y9hfePXSnsCPtEuX5lQ-1
X-Mimecast-MFC-AGG-ID: Ef5y9hfePXSnsCPtEuX5lQ_1775557653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c0cd1ba8so2011225e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775557653; x=1776162453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+n77q3qe2X9uEWYZe5PbZjhiPr23OWjrheRwwkTN7kU=;
        b=hRV4en3MF6ImQhyS6Xp3jFWe79VNYm13L4GX3hy8r95m5KEQgcbp1GRfMAXJcuyS05
         NYuejRoHx3Mjv0bLeznB41heJbIxKrwSlTusesKIFTEYNrTE7QlFS/u8wFob9qiqImJ1
         sA4zy6ytV7pZK388vBiqWCz0KfR5407W97+y9g9rP32qFex2sXJOIqvRraLphcdUZhF4
         sv+8e0IFsbL/oMDIGAJxpvEa8cCvHUh6zD2anYE7J+fsVhTMxMexmepssHDHVpUQiWrB
         L72HmAGPljpTknBVygYK+EWpLxROLABVqL4dvEGObACOoILmecEf42SrZK3hiMhiEZn8
         fecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557653; x=1776162453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+n77q3qe2X9uEWYZe5PbZjhiPr23OWjrheRwwkTN7kU=;
        b=lIilGvsCIKWPn/pYtbm5SFBur2EAFryrfCUZ53QN4TQR8AqPGKdrvMbMC/676r3k34
         1MHpt4f6zCfg7yf0qIUknpjt3KbdXGCFM3mYpDl1yiBrDBbdQqnoicov7Gf2LpcpAY9n
         gKypbH+HKWElLWTHOk7nRHgUNAO0dfIRPLlMHF3zbX5sO7W6gX8TgeCYoX2VXcxwN5t5
         uftjA/jBx6Gjv1J0EIydTevmEFUHipKdonLzPaYAyja2i84VeWClvLNGEJthviKet+CC
         DHhTEKhpT/Jf4ydwkib7PvugmRvjOYPppaxol4Ddb3S9WjLqvV5wV5KbatmWtHuZJKEQ
         wIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXUH9kGwThR4K/jYywZ3cjn7gGq1ID4E+VKXIjkL+lbvvYhP77HM7iJdHY0ZGB/K35SiKHyiW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GdPXimUfN6NoIeqSRmtVPiN/l5LmxF83Elpufl1UQekZC2F7
	NgnsKOYlriMaJ5p3h2pO923r8Tbu0M1WBNN8SgsxzA23f2B8sNMTKxL/koxHLDGUjCtnQXoGBhB
	N6XazQYd5dBm03fkumLEbuTLu2IoAD/MhLBdutOctpGUDTSGTssXzEhvxEw==
X-Gm-Gg: AeBDievSp8ajTJrKQ0uR4DI17EpXVDv6ZEGLDhjeZA0xP71bElLR02rE9k8kt2FhjDW
	39uRTN2CtodUDblCZoY8McjdE7EBFQ0Y1i8hOKhnENOm1/3o+q4zXqNjv7HXaY7GcTwHfnLwbJe
	tGKsI0kCaGBgfFLTOFJxgGrqhlBizlKEbxemz0yy/5BjPOSG9mXxsjCWKgkkfsRPrXcYLQ0vKHj
	yTx8xsBdoq6kv6lUaxCezHelqxLvJd6BuwIAMiRnTTranCL+H5CV/dbIMxy+/ow0/DehadNkWpq
	+pcqhgU2RWMDQWr3Rz5tYougqpczHm4D7gcOP8emw0iDM6HKBZCCrtNG3DNMNfcN+DnMJwm134c
	1A8+bZ8RcZKnF8Rk2flsrkBN7pUBczieQDvfaVQWPG/LSitVv9/yXFk7DaA==
X-Received: by 2002:a05:600c:8b32:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-488996afe1cmr220727795e9.3.1775557652601;
        Tue, 07 Apr 2026 03:27:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-488996afe1cmr220727625e9.3.1775557652195;
        Tue, 07 Apr 2026 03:27:32 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e48da1sm111772465e9.18.2026.04.07.03.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 03:27:31 -0700 (PDT)
Message-ID: <bc004773-aead-4431-95fc-860490773c49@redhat.com>
Date: Tue, 7 Apr 2026 12:27:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: add READ_ONCE() annotations to fib6_metrics
 reader paths
To: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>
References: <20260403-fib6_metric_read_once-v1-1-45de44912b24@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403-fib6_metric_read_once-v1-1-45de44912b24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-275937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E7483ACE3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:16 AM, Hangbin Liu wrote:
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 9f8b6814a96a..2dfb04fab5da 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -594,7 +594,9 @@ void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
>  void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
>  static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
>  {
> -	return !!(f6i->fib6_metrics->metrics[RTAX_LOCK - 1] & (1 << metric));
> +	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> +
> +	return !!(m->metrics[RTAX_LOCK - 1] & (1 << metric));

Sashiko notes that here you may want to add an additional READ_ONCE() on
m->metrics[RTAX_LOCK - 1], which in turn looks like more a
follow-up/separate change than a change specific to this patch

>  }
>  void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
>  			    bool offload, bool trap, bool offload_failed);
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index dd26657b6a4a..3c96580c2a03 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1144,9 +1144,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  					iter->fib6_flags &= ~RTF_PREFIX_RT;
>  				}
>  
> -				if (rt->fib6_pmtu)
> +				u32 pmtu = READ_ONCE(rt->fib6_pmtu);

Here the READ_ONCE() on rt->metrics is still missing.

> @@ -1635,11 +1635,12 @@ __rt6_find_exception_rcu(struct rt6_exception_bucket **bucket,
>  static unsigned int fib6_mtu(const struct fib6_result *res)
>  {
>  	const struct fib6_nh *nh = res->nh;
> +	struct dst_metrics *m;
>  	unsigned int mtu;
>  
> -	if (res->f6i->fib6_pmtu) {
> -		mtu = res->f6i->fib6_pmtu;
> -	} else {
> +	m = READ_ONCE(res->f6i->fib6_metrics);
> +	mtu = READ_ONCE(m->metrics[RTAX_MTU - 1]);

After this patch there will be a single usage of the `fib6_pmtu` macro.
I think it would be better to entirely drop it and replace with an helper:

static inline unsigned int fib6_mtu(const struct fib6_info *f6i)
{
	const struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
	return READ_ONCE(m->metrics[RTAX_MTU - 1]);
}

/P


