Return-Path: <netdev+bounces-295253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3EkNT+EIWpbHwEAu9opvQ
	(envelope-from <netdev+bounces-295253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF9640977
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:57:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WIoWbiON;
	dkim=pass header.d=redhat.com header.s=google header.b=QZjIXEnn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295253-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295253-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4A5302F9BE
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDA47DD4A;
	Thu,  4 Jun 2026 13:41:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FED40F8D8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:41:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580490; cv=none; b=W0cZQriimfBMZlmmjVtQlhQYW4FOlaqo1KsiUoyNyali5W1uPlOI0JuXz3z4hCgVJxw225jqXte+AK/BBi8mGf1UEGDWqsM5ab59jiiBADd+b8AgSB3DDFdHFP0tMwNm2jQndTlw9Pl9nIGjLiQwB3sWFtt6mumA+JDMYliuV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580490; c=relaxed/simple;
	bh=mqSvrNs6qutA/iyIvRXQBm8ztoMR0I7alP4oXFMUOaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mS8PAy9Ik3bPNPe6JsPEYavRcw2EYU3n+Htrj3vy+IOrY9SLNgOC29OlVxFRNNuGh1sGNO6EoWqy1d9Cgv0nQU6WcX7T2VMTkOz1AKsvFM6HCngvfauL2SL1hqIuOR3sY97wkNV0aqohEULfOUydPA12s6NssUCa5eke3VJBXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIoWbiON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZjIXEnn; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maUWokqTyjYG2hZH87ZqeSI6FwjBdDWqODEJObqKpzg=;
	b=WIoWbiONtjRCLkbkmuO9EqQ36XMO0k0lKk3uBvKX3O0oQDstMB089SzQ7W/OvK2f1T+weX
	mFYrI7IADC97sIJnSoU4YTDFFevtHA67/kEHQWk90LwcHpo98f2tNSRPx2D1BZw0UN+mI9
	JiAcGr7FjBlIFoYJBtSL39daBqrQOtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-nzhAA2nWMwCDcywsBiU8AA-1; Thu, 04 Jun 2026 09:41:25 -0400
X-MC-Unique: nzhAA2nWMwCDcywsBiU8AA-1
X-Mimecast-MFC-AGG-ID: nzhAA2nWMwCDcywsBiU8AA_1780580484
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef0af9517so584844f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780580484; x=1781185284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maUWokqTyjYG2hZH87ZqeSI6FwjBdDWqODEJObqKpzg=;
        b=QZjIXEnnsvvDhI1sFeUCaDftjiPMCNyKzgQI7+1dqAyjGZQuGyApnIu9Nf25eDvDe5
         w6Gc0OB1gszMWDytgEz+0jtmmUb5ccIyqQITVASOcp7O6TAaQWdvSXIiEwgRXH1GPt+i
         rrBNd7G+546FeJDx/VBnBXs/3pQCJqSgL4zm2X/dhdM+oy13taveLVz0c+OBDqFP+jg7
         0N1oXvWNjKonhukj/MFlOoCSIVxacobVJiwcWDLeSSS5pjjD8+v0P+v5/T8sboxkCkBk
         PJEG0Oajo1SAcNYnquZ8gY5hjuRjS9Arlvgz+ZdxYxTRFclh6Bjus72VXrohYDPc1/no
         mA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580484; x=1781185284;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maUWokqTyjYG2hZH87ZqeSI6FwjBdDWqODEJObqKpzg=;
        b=eLAwqfi8EIBCBZ0dhqiu0mn249XjKovwqLxROkhP7yV/kXfFhu9mBSGNqgfkyatFyC
         k/CEyD1LSZI3teMq1AlenpFgfVDbJbhTyIYQ4HVs3e6YB4RMH0m3+CBPwhxMu6WfvsBo
         HUYRj5yNbnP9vschFxyHomjOUH2xzbbAG9mIWDRIjU7EpR4ZEH1PSRGwnKLAihJAtS8Y
         MM4vQrNi64XvfktoGjaxc01peMN39hQq3hgO0Gtcy/mhr499hNF5AIYKwVUfhlt6A3f2
         ByK2feqDgP1iwcDDVuygVs5jnulI8Z6srHpZ0Pwj2Gg/zRNbhx2Kx5Wigo+Zte7zsdbq
         YTwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jY8H7I1I1ht51yXbKHfVFJ0u+YB10X2xNNSa7n+Xj2LVDHbnC/Jx1RCyo6atVEzxdknN1Jq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tIIMoACP9wE5ps+2rsWaxzrOO+QG7EAdJeKYmllx9O0hcxiA
	ucy44/QLjIGP2doZJIiA9y50oEbnGKTSNBOAeVgwUJhA/L0qgJpE5X4xyjiU1c0A6WXCoJAgRvC
	WMlpfZpENnQ9J9DiVXthlk5lSwLrOPBxqhiI0jcANBhicJYnJCGZ7SWf/Lg==
X-Gm-Gg: Acq92OF+5fRrUPKnGS7NXtFvDVXNwk2aLBlO3H8k+WKrwojkDL6SeXy/BDwY2ZHGuwo
	zdD9Szuu1BwIMRKVNHaD97In9+Q7DdALsojWkvF2S3cN86KAkpg6TqEMw7IYPNG3lXOWaVI+j6d
	bgXaewFjtxE50igRiD1uRNV0dzFBU7jIrdG5Fe3tGwpfEnlZffIcT1Gs7wWwxmMB0lqGnQ/J3X9
	tS4E1BzV13uT8c8CiUSbEfspioGYnVMaE79xyaz2JXf38ylbNbpvPAFzKYvAgOhg58ySLv5issS
	6mktzxkSoCIrYN88GlfYac3HvTRnCEJHmZjNZBDfUcFeX9AzlNmJnQcSCutxjFfNZ2jf8+HE6S0
	xZfsDC31V7c0iBIKPZA6BDm6i5VomVZv4dk85i6mJgTpHq4bTN4FZbypFAqaK1wiZcqc=
X-Received: by 2002:adf:e00a:0:10b0:43f:e272:edff with SMTP id ffacd0b85a97d-4602178ae52mr8881791f8f.4.1780580483760;
        Thu, 04 Jun 2026 06:41:23 -0700 (PDT)
X-Received: by 2002:adf:e00a:0:10b0:43f:e272:edff with SMTP id ffacd0b85a97d-4602178ae52mr8881742f8f.4.1780580483348;
        Thu, 04 Jun 2026 06:41:23 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm8104724f8f.30.2026.06.04.06.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:41:22 -0700 (PDT)
Message-ID: <3564485c-0969-40bf-8f18-c9eb36c4065e@redhat.com>
Date: Thu, 4 Jun 2026 15:41:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9] l2tp: fix double dst_release() on
 sk_dst_cache race
To: Mikhail Lobanov <m.lobanov@rosa.ru>,
 "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Bauer <mail@david-bauer.net>,
 James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260601213302.18761-1-m.lobanov@rosa.ru>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601213302.18761-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:m.lobanov@rosa.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:mail@david-bauer.net,m:jchapman@katalix.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ADF9640977

On 6/1/26 11:33 PM, Mikhail Lobanov wrote:
> +static int l2tp_xmit_ipv4(struct sock *sk, struct sk_buff *skb, struct flowi *fl)
> +{
> +	struct inet_sock *inet = inet_sk(sk);
> +	struct net *net = sock_net(sk);
> +	struct ip_options_rcu *inet_opt;

Since a repost is needed, please additionaly fix the variable
declaration order above ...

> +	struct flowi4 *fl4;
> +	struct rtable *rt;
> +	__u8 tos;
> +	int err;
> +
> +	rcu_read_lock();
> +	inet_opt = rcu_dereference(inet->inet_opt);
> +	fl4 = &fl->u.ip4;
> +	tos = READ_ONCE(inet->tos);
> +
> +	rt = dst_rtable(sk_dst_check(sk, 0));
> +	if (!rt) {
> +		__be32 daddr = inet->inet_daddr;
> +
> +		if (inet_opt && inet_opt->opt.srr)
> +			daddr = inet_opt->opt.faddr;
> +
> +		rt = ip_route_output_ports(net, fl4, sk,
> +					   daddr, inet->inet_saddr,
> +					   inet->inet_dport,
> +					   inet->inet_sport,
> +					   sk->sk_protocol,
> +					   tos & INET_DSCP_MASK,
> +					   READ_ONCE(sk->sk_bound_dev_if));
> +		if (IS_ERR(rt)) {
> +			rcu_read_unlock();
> +			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_OUTNOROUTES);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		sk_setup_caps(sk, &rt->dst);
> +	}
> +
> +	skb_dst_set_noref(skb, &rt->dst);
> +	rcu_read_unlock();
> +
> +	err = ip_queue_xmit(sk, skb, fl);
> +	return err;
> +}
> +
>  /* Queue the packet to IP for output: tunnel socket lock must be held */
>  static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, struct flowi *fl)
>  {
>  	int err;
> +	struct sock *sk = tunnel->sock;

... and here, too.

Thanks,

Paolo


