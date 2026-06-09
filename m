Return-Path: <netdev+bounces-297000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQX7I6zhJ2rb3wIAu9opvQ
	(envelope-from <netdev+bounces-297000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7565E893
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gjs3JrDd;
	dkim=pass header.d=redhat.com header.s=google header.b=Acm8YZW6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297000-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297000-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B000630DB0CF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE43E4C65;
	Tue,  9 Jun 2026 09:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69133E00A0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:41:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998108; cv=none; b=Na8af0vG/67Y0oDO7sjlyHO1xvvdN4rRu0TQvJUaW7fgESMdzsaHFwNQ/x72r+hYdx31X7EugnEweWlPkocNBreVE4i/l5II1WYehUEOAApyXOLjkwwR2Elj2vh7xeHjSLYNuhTaJNxJXfNtfcRZ47HuoOasPH05ywtHCU94m6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998108; c=relaxed/simple;
	bh=Avkrtn01Ayj3T2TvNljnHS34gZQIlNdTbIwKa1EoWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS4EehlbwG0zJbLGpULgfvC2TtlDrvGN/dd3Sz5i+ldZfRtb2J14yDGdiPnEpXEXebhJMRyeDv7OXsXl2C5H+VUj2/zdfTdf8iNDYeCMrv3jgofac/f6nV+Q071gAGnXYpSutTcgVvsxBwu6csdlmWyJL2bgV/4j+qkv7L/6imw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjs3JrDd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Acm8YZW6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780998106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
	b=gjs3JrDd3YSY+owg3xrvLOu9OAQfq4UL8Gd0q/rzPUSvmJaSqAXAGXQ88dtVIiI3OvEM1q
	KaJphGZi1vsgqrtRsJ2bZNcYL14I9+VDfEYXZ45JagO3xjxVDVhXr35bEA83DHtTa1JcB9
	alnE/VhT5r/d/kHhSpgW3CC13fc5/tI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-wjZDXPMYMiaEjmScpn2H5Q-1; Tue, 09 Jun 2026 05:41:39 -0400
X-MC-Unique: wjZDXPMYMiaEjmScpn2H5Q-1
X-Mimecast-MFC-AGG-ID: wjZDXPMYMiaEjmScpn2H5Q_1780998098
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so43758345e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780998098; x=1781602898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
        b=Acm8YZW6lfcIzAMp2Z23UfeSBDJN8+9G8dNKmcppwoUysS9vf2J9DrIxtRa7zRa8xZ
         7C39L6ja+tfQNsK+Vz10qIfJkw66Ve9KdWb3zaDPrKcZk/Y6/aCjm3vCY9ad9pBbdMmN
         sOTvlfl/wlpAtoRa/nxwYVgwOcfRL44Rw2H6pOlXI64UclDNopPflXI3Ijj6d9sSbARS
         lQEHbTgDCYjE1tZCM4BtBgodae47N39KV6ig+6xIyLuSYibfV3WpwkU8fLoexkK2Lpiy
         9lH3wwqfwkwLhg63WmKd+vPv+RLsNZPPTutNX/LpMx/Hq18kPDE97qSyVPORL5FGj+c2
         9ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998098; x=1781602898;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRY8LqFb7Uf3uguI4UokjXxEYGkijilafTjvNmMtFxQ=;
        b=YfhkppFaAC/lJlXknIjCIvXim4rNYQ0eD2+InHiqEuoNM2QFsHpi7u7XEj8lH50iqZ
         bvzKBydGhAo72M2t4hgw1n5IK77R/FN6iTq4dG/kjIGRxBormD5yURFllMmUEllAA26O
         iNsPLOTUo0ZwMCwVxk/lDosGmJ4IKEcqNxV12WomQewqXG6jPOamxclsGPNtp/1fSh6A
         yhvEY+HeUukvOmtVEHMhQPCBUQKVv3cHWlI2/C8HNWOQSNX6T5G4JUyajT4GsdhbfH9w
         V/W9yE1bo4bM7EGrCPm8jrJKt6+gy2Mcjh9sFihvTq7kTiYSBcD10/vNPtL/LAuJBYR/
         thEg==
X-Forwarded-Encrypted: i=1; AFNElJ/gtyF9cBNR6qGy0qHOyXO3dXlvIOUgmjjzwDfsO91PC3+/vv+/xwAW5beVSqI2yv5CCrFgIAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdY+xafGnusTCJIP47Z2Dw8v8ONLTPZlgDIYV0wV5BvpmqP51
	ocsCnS0Ijon3Ejy9W9DrZEczII+XRsHO1jHBX3I/FQz0+ejzwomADeBz1SDG7rOxfAQn3xSCFgk
	nLfJxRoc/NmGzD50sT7Rn3FAPFArOCbKqIVvH1Wk7WIIdmwTF5/9J3b0F8w==
X-Gm-Gg: Acq92OFt5Sr7GqP0RIusSSIeq7S8aLf5vb+gCrHp2sXj6TmThR2Hy6oNy4a/gjYxgNz
	ZwiFrQg4rczAlbJ67K8/XX7AlTDYzThq9xpctImt0mOEO9m84NjxZ/tiQuWcu2DaBkKsGpTswYl
	y4DFYYsncHbanC03sOHASZjeIt7kKmAYCZTcWPkwJpQznc7WR7vOQukA+FMXFWCtUKzgkPeBJXX
	Jvqy/E8X8D/GwNw0qsqgIBg/odBDib32J8wd4QTjGKnHkWsBnDQduwxhHm6JwrVAL8E4zgMr0/O
	l20X+eqiSthwA4nCUnZ8VMT2sfDz3SCDEGGpjFxe+h1PWm5MCPY6kmuALNmDjeK3ZJm51SWEA5o
	AjZIoct8yEsxwAh5mzcH6B4IxZN7mSouqwsH78DxV0CZjIPkDEeAUhyR+hd0uQwuxdg==
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr370753135e9.12.1780998098481;
        Tue, 09 Jun 2026 02:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr370752465e9.12.1780998098011;
        Tue, 09 Jun 2026 02:41:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm473121045e9.6.2026.06.09.02.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:41:37 -0700 (PDT)
Message-ID: <c9fe8a0c-51c7-4afa-8d2e-1a1d5730d693@redhat.com>
Date: Tue, 9 Jun 2026 11:41:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com
Cc: dsahern@kernel.org, kuniyu@google.com, shaw.leon@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297000-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06C7565E893

On 6/4/26 2:50 PM, Maoyi Xie wrote:
> A tunnel changelink mutates the tunnel state in the device's creation
> netns. After an IFLA_NET_NS_FD migration that creation netns differs
> from the caller's netns. The rtnl changelink path only checks
> CAP_NET_ADMIN against the caller's netns, so a caller with caps only in
> its current netns can rewrite a tunnel that lives in the creation netns.
> They pick the endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
> ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
> ioctl path. This adds it on the RTM_NEWLINK path.
> 
> Gate each tunnel changelink on ns_capable against the creation netns, at
> the top of the op before any attribute is parsed or applied. The ipv4
> types need it there because the parsers can update live tunnel fields
> before ip_tunnel_changelink() runs, for example ipgre_netlink_parms()
> sets t->collect_md. The check is skipped when the creation netns equals
> the device's current netns (net_eq), where the existing CAP_NET_ADMIN
> check already applies and no extra LSM hook is wanted.
> 
> The newlink path has long checked the capability in the link netns. The
> changelink path never did.
> 
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Since the fix is not centralized in a single place, I think it would be
better to split this in a series addressing each tunnel individually.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 169e2921a851..02328c9a3c07 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1457,6 +1457,10 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	__u32 fwmark = t->fwmark;
>  	int err;
>  
> +	if (!net_eq(t->net, dev_net(dev)) &&
> +	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))

the above checks are replicated several times. I think it would be
better to place them in a new helper.

/P


