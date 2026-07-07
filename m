Return-Path: <netdev+bounces-305459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCMkKyf9TGpptAEAu9opvQ
	(envelope-from <netdev+bounces-305459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4554071BD28
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IUOMmi3z;
	dkim=pass header.d=redhat.com header.s=google header.b=Kry6JUni;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305459-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305459-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14FAD306656F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5A2F7EE4;
	Tue,  7 Jul 2026 13:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B33DD875
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430163; cv=none; b=RHKKOas58ZFC3hJSI9nWk5cn6QUXrTucJnytioQYwXOGloC0z6M5UM2waHBW+95M3Cyagvs6vy8qEbG6LYNfSQOLNzAVa66TUBA+XrMjvH9nQU2/2g26dbDJgdO6kSzxYDKE0ZvnSFLHwk87rDe7GTy0BiMaJ04xudbCiFSzz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430163; c=relaxed/simple;
	bh=7ZzwA0kHSIuI6Nj6eH1EkGH2hRIEmiYtj1wPF4iX49o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT0mlGjfNMEfR7QKi/s8t6U38rXmTD9OQkFPC3NxuiX42ZEy5ORs2SK8ybOU1jicOcAwbwH9Zsr5aUCJoO58OwZ57jOTlmcLfDkQql0kb9GM4ZvzAEMxeTKOZ1Nx+2cSPuLFwjywdf16DeCXSBAMbcWkHjqDDV5Rc4PIG7xI0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUOMmi3z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kry6JUni; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783430161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGO+CD8S0fxotRZpNU0Z8M8hZNfvdW1V4xa8emjvK9I=;
	b=IUOMmi3zU606rnCbx57S4jqoWICf+veOmRuw6ceMb89FGYKqPRS810fIIzjr+k92P++Ci8
	HKb0uyGqIAE0lBbTDYJwLl77Kkkcqd44anNCaM+dvsIkLKL4h2uv56pB4/lBHv1J+w+XuZ
	TdiCq0DNyXX36DIJ8Gwc/Fl7mbo4y/U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-Dnmng78bPBOPH-bLfIQZfg-1; Tue, 07 Jul 2026 09:16:00 -0400
X-MC-Unique: Dnmng78bPBOPH-bLfIQZfg-1
X-Mimecast-MFC-AGG-ID: Dnmng78bPBOPH-bLfIQZfg_1783430159
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aa6914d494so2552882e87.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783430158; x=1784034958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGO+CD8S0fxotRZpNU0Z8M8hZNfvdW1V4xa8emjvK9I=;
        b=Kry6JUnim4ryIiLxEf8DztrFSbgUblz241Ol+UOJxKOXyhi438s3yktS90vRTdo8EP
         IF5ONcdiIFV9VDXigp6RJyOVCq1rPDhLB7d6s+TLGpXMUHukPVipjP7nGik1dUkRM136
         VBc3v/YVzh0d1qnuSKK3vGX5GSL9FUV6yIScCugqfboF03tMYd0TabO1maypSb9Dz7fj
         1CsDgZVxXtoZWte7jFhQAr/Tw0Rrt+jeE3F04pxGyruwkr5y28UaimuhjF8ZuDrICFbl
         xlQ9pk/acwYox2rPRnLs5qq96kQ2jI2EPXmx0fb2kpLuSUHnXFEnWlL3Hr3tEdCiX5hy
         7kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430158; x=1784034958;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGO+CD8S0fxotRZpNU0Z8M8hZNfvdW1V4xa8emjvK9I=;
        b=IyHYHfKN5lhMFXfK9pr+tonMfTINIPkwRVPwtMMK31QZLX94pqW6nAt7wIOtrJlp8J
         s6RSSTAHJAyH78d+V2EpHI+k+XtIoTPnrojjQyKkpbRPyrqKvKwO3N897RxNci004W0N
         jbPXawHJcE2LSis5xsyUlkR/vAbLHAQlSIi3qxRbV4IokMq1S8BdPJHs6gGfued1y2yB
         nT+PZ6uqehsytJzzn+shNhl3fp5c3abKWzEJ+gsyuvHVtPT0iWE6hBAudH+kEc2VhKXm
         EqFMYiYfJfBmY3DEwcFeUxsgOR552mf0Tf/SDSyPcotGu1VefgMlz7nQSJoB+bYnzGfa
         J1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RrI/w0gKyf5iMheNNGcypkkyoKhuf2dGcWiEEXFYT13f5+OAIgcauirFPheDMVFTuRADAQGwPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOuisIK3j6BcgFlQGZH7MmLG4HW8R/wpDb47YBB7PgJrJ/R9H
	NcFd4pxtu+LcKETLVPQozKhoXHFI15QxTjaeHVVLan+W8d5GTXTy45wIj1baoRxtM7WoZZAvA2R
	9C4b+ndovGMtYEU+NxIBCcvS9EkpWvfvkoQyAI2K13lpr2mmG75RP7wYG4w==
X-Gm-Gg: AfdE7clHd10V14kQ/QBsVv4mj6Qxz7GWKx5jizcuXDXCKYOSFAM8Xg1STLO4nLsWR6L
	Lsh9YqY4PxOVNYeDWhIyIAXdDj2OAtRSFVD6OQYuLaql18NF6ZuXjbTndR1l3Mh4WAvROJxIXqv
	OUIJGpgOBs17t3vAKVWc10TeS9ZCNwwdTQZq4YuUT2kOtwYV5WZ5RNsyyZXv3pHRb/6q9ohwX+p
	rHkoV7+fqzPDkxpwblGHxhkpFigs39CcA87lmD7g3sut4jIGZwmOFCBceuOrPtX0fKAhlgHOOcm
	CjmmzfkVEqpWcJJuvGUfwB18oL9vOqL0XzcGm2EfwOc5pAXjFa6TGLD6tIjj4U8yrmEaU4sc+44
	g+RE5Z6waSJI3sflkeoEM4oYbVdzI0/VTgPfbZeDD4hOlsddjeB/AmLnU1VnQitN4cB1eQHEh45
	2S2yWmkyNpZ5KM
X-Received: by 2002:a05:6512:3f14:b0:5ae:b8c1:8c99 with SMTP id 2adb3069b0e04-5b007b7a122mr1287301e87.22.1783430158294;
        Tue, 07 Jul 2026 06:15:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3f14:b0:5ae:b8c1:8c99 with SMTP id 2adb3069b0e04-5b007b7a122mr1287292e87.22.1783430157704;
        Tue, 07 Jul 2026 06:15:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed137702fsm3698877e87.19.2026.07.07.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:15:56 -0700 (PDT)
Message-ID: <6c4a0a58-8233-408f-ae6b-c66f38d8f3a9@redhat.com>
Date: Tue, 7 Jul 2026 15:15:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] geneve: convert config to RCU-protected
 pointer
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260701120454.3533252-1-edumazet@google.com>
 <20260701120454.3533252-2-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701120454.3533252-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-305459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4554071BD28

On 7/1/26 2:04 PM, Eric Dumazet wrote:
> @@ -1137,21 +1144,22 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
>  static int geneve_open(struct net_device *dev)
>  {
>  	struct geneve_dev *geneve = netdev_priv(dev);
> -	bool dualstack = geneve->cfg.dualstack;
> +	const struct geneve_config *cfg = rtnl_dereference(geneve->cfg);

Minor nit only mentioned because a repost is likely needed: here and in
a few other places the variable declaration order is not respected.

[...]
> @@ -1539,28 +1551,36 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct geneve_dev *geneve = netdev_priv(dev);
> -	struct ip_tunnel_info *info = NULL;
> +	const struct ip_tunnel_info *info = NULL;
> +	const struct geneve_config *cfg;
>  	int err;
>  
> -	if (geneve->cfg.collect_md) {
> +	rcu_read_lock();
> +	cfg = rcu_dereference(geneve->cfg);
> +	if (unlikely(!cfg)) {

I also *think* the conditional is not needed here.

[...]
> @@ -1717,6 +1790,8 @@ static void geneve_setup(struct net_device *dev)
>  	dev->netdev_ops = &geneve_netdev_ops;
>  	dev->ethtool_ops = &geneve_ethtool_ops;
>  	dev->needs_free_netdev = true;
> +	dev->priv_destructor = geneve_free_dev;

Both sashikos point out this may cause double free.

Side note: I think that ideally it would be good to break this patch into 2:
- passing an explicit `const struct geneve_config *` argument where needed.
- doing the rcu conversion.

/P


