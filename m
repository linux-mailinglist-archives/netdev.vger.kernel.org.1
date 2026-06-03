Return-Path: <netdev+bounces-294659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rwXMo/jH2pyrwAAu9opvQ
	(envelope-from <netdev+bounces-294659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A0635A01
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=mq+ea6vy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7B763081C16
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A583A6411;
	Wed,  3 Jun 2026 07:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EE2E54AA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472573; cv=none; b=Zt/m5FkCn888NlO59TlRHWKaU4p6KLbYOrAWbsaiAci/wO8hWCczS8cl6/jSiiE+gJ23a00tB4HJAlvxu6BwZReiiN1Vl7tbDUWM3GNh6829r6RVDt9sMYHfwoSaDE74B/pzlU4mnm3NI4bz/4ev/HEOMpfFaNCIf/qsorQ+GP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472573; c=relaxed/simple;
	bh=pA41DLj7JBByWoVP6EoLasziY7MoVWzR7WjfPlqY7/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7vfeoMcc0z9/X+Sfb/e2U/jV9h2H1XFplbzJi4pKEWgcTD6tcoL2U+SyINAfDZIVnk/h/x5j5D+XXeRp01fkt5Mrwe3cwkFw/oApQhKcJtPpbfXpmjuanl2OSIv4OnZEp60/Hp71JHqDcDKs79ALbciJy+UGGAED+JMVn33IAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mq+ea6vy; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b915ded5so2118805e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472571; x=1781077371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WnRYtq48lOv3kRIaPOdMb+Alm1VGiz/ao2CcAxEN4U=;
        b=mq+ea6vyJs9pS7dUtJZKxYjiSsJg3/AcZdpFkQkyVvD64MTRYqFt1cJ2JAXIANkUbv
         wwonQledoDTJKhQZpXSRQxADkiBEv0jLoafCRRkuAM9VAkDx3ToQQPbOsqqcnrgVMUOi
         0OkNzOOS3jVycGyeexWu+LY21AFyTRzYDeWD7P1glCyKtq8/WaVLdMJworVM8b7AlHXe
         GKJzFRu6HvOKwMn3unSWYsu9MADQrKO2TeNSaetgO101A27cdb75gyIK8/zjhc2dQTcK
         6rIGk4JZcYvBWKFGDhJCPfE57spCNjcTIK+T1z6O+amEx7uiYM0XqXfPMvIHpigNYztX
         3CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472571; x=1781077371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WnRYtq48lOv3kRIaPOdMb+Alm1VGiz/ao2CcAxEN4U=;
        b=kme5SIxiakK+Qqp5ffaNMx8x2QFSypdpLCkVPNBOQdVW8rBn1MPREkbGD1xLVmkQAi
         S6sQC8YTxhl47fkvIOpCsND0rwPaz6AxEKYxMVZi9Ytd84ufFf0n40vqfymBUKRIpLSl
         dVgUuQfi8GB0d4rRzLKHdNC5g1fzeAZiNzj620LYhAwcrYFFe5FKJoEl8BABn0AlCBMW
         sB0FTBU6bhvJS21qHvseEogGYJC9Vc8whkehdsy2dJI65xEFDUtGqg2I6Y7eIKvWyk2m
         uGzJoZnsM7wIUNXJ8aNAG9tPgHds+B7DIvEhiFSYlwJwnLVg4VofyXG5AtC2wZ73aHT6
         D8hA==
X-Forwarded-Encrypted: i=1; AFNElJ8ARV0VZ+QZvjNluZuU0sO3UuXcsiUaNF1rmIPHpbWjNiogOYquJcHju5YvAgarclu+ohjBr28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86LL329URIBWH4xM6i98s7cnAXL6UAD2N9GbppmecMLwmBlpA
	puJoOgq01czwNBnJDm58JebwQZUlW5loX9xra3Bif7kdtLb9UMGIz9PbpXINEWJeTlg=
X-Gm-Gg: Acq92OG9snc9J0vZsTiK0JpHdLXAAGbO1ghXDQG3Anc/mHfGCh6SDTLK4bcMl85AEhq
	ZfiGs5JIgP94H+31JDl81pKZ890MJK3/LI8coyeSdcinfpL14J/f8M2G8QBXHD/ZPXwZYRf8lF1
	nCqU6UTfte3bp6hpl3sjBK6WIOG+G8OvN7ou/hktI4Lnyx2OMZEm3cF0yxEJhWYAE+pBMExTAeQ
	SMMDo2EZ5RG7RHu7vEnoqiwMxRhObVU+hYCcelInHy4Aep8vdEVTlORNb3T6Eba0gbENcHV8H7z
	DLvIt+gCoaZj0uentJfZ05F9NVHWIkHPaWVns3b8Y8B8def+8cBaQg1tUy+8kmFljORRzVPHl0N
	QLcjeIeqC/mBzyIu71YtpFme401x9nL5ydbnJH9dieb/u14OlPR/k1AJK2qpjq08ZqFhWItC7Y0
	EbvFETHO4myv7S+cVYL8NiXaU4D/Z1B86M58LqufBnfCd6KuutF5mOce3hx3gB6SldWIbLVa5rb
	yU=
X-Received: by 2002:a05:600c:1381:b0:490:a2fd:e1e5 with SMTP id 5b1f17b1804b1-490b60de796mr33194645e9.17.1780472571044;
        Wed, 03 Jun 2026 00:42:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e7639csm123712005e9.10.2026.06.03.00.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:42:50 -0700 (PDT)
Message-ID: <af6c753f-c4a5-4876-b651-741bb0b8009e@blackwall.org>
Date: Wed, 3 Jun 2026 10:42:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/11] bridge: use BR_PROMISC_BIT
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-4-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A46A0635A01

On 03/06/2026 09:20, Eric Dumazet wrote:
> Use BR_PROMISC_BIT and set_bit(), clear_bit() and test_bit() lockless
> functions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_if.c      | 4 ++--
>   net/bridge/br_private.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index d39571e13744431f5e4c67f34ee7de34eb8bb6b0..3169fab686a534cf2a6458ff228eee2b6fc7e7e4 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -110,7 +110,7 @@ static void br_port_set_promisc(struct net_bridge_port *p)
>   		return;
>   
>   	br_fdb_unsync_static(p->br, p);
> -	p->flags |= BR_PROMISC;
> +	set_bit(BR_PROMISC_BIT, &p->flags);
>   }
>   
>   static void br_port_clear_promisc(struct net_bridge_port *p)
> @@ -133,7 +133,7 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
>   		return;
>   
>   	dev_set_promiscuity(p->dev, -1);
> -	p->flags &= ~BR_PROMISC;
> +	clear_bit(BR_PROMISC_BIT, &p->flags);
>   }
>   
>   /* When a port is added or removed or when certain port flags
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 02671e648dac7ab6fd59b80e044f62b00a8e4a8a..d55ea9516e3e369bb9e0045fca5b8d034ef5a45f 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -452,7 +452,7 @@ struct net_bridge_port {
>   #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
>   
>   #define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
> -#define br_promisc_port(p) ((p)->flags & BR_PROMISC)
> +#define br_promisc_port(p) test_bit(BR_PROMISC_BIT, &(p)->flags)
>   
>   static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev)
>   {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


