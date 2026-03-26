Return-Path: <netdev+bounces-272153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC1iLhtnxWkn+AQAu9opvQ
	(envelope-from <netdev+bounces-272153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9D338DD9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A3D53008095
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725E3FD156;
	Thu, 26 Mar 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="E1ExEmsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51239C63D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543473; cv=none; b=uGFhRI1QdM2ud5chj3bX9zAfwUp3M6aBSvW6grRW5DWsXEAjybQDUzFRD39S6jg9xo120jR+nTKD2rlypS4JrxFJf93kVmO9S5S6Q97Z0qB/Vg6sAeXLKEr7qlW1NMX4dZUBn6w86yE9NHk8OjfjMmCtzO73DGDsDLKSfsjZclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543473; c=relaxed/simple;
	bh=/G2bs0BwAXEyEVW9j93XdQ/22tQtf/E5LusP/Tpp5hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9XOPwjP+TQ0kAggNnhjzjQ68lJ3xKPtmyxENlZx77I7ki73DyhlRCjt9VqzS1NCAE6xc8oLXn6IKSGTd1FbyJtKEXqGPLaAksytBNLLDoSjiAFnWnC78hJB8BvOxvjxjGX2d1JPwOVoPzmdyzq5U/Cvdn3InojiRq3V3s8fiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=E1ExEmsQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b9109374eso41824f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774543470; x=1775148270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vGBNnYcyMccpdpNhrK4WEI6MensrK6wWkxqJK4annYs=;
        b=E1ExEmsQODmQbVdLnNpJhP0tZgNCmRvinCqmml611H2Qub0F3NZ8Nyrpe4/ybGK37P
         49fzJbKgdwMGHvff/eEVi7IS75V5kijuzh6uUAQVyTc5MaPAc1ePl8aDwrGgjxmiwNpq
         55J590RYubyOF5uj5zwFN/0p2NODQn2OMY5o5UFzzN8WsyfjD5evkHqT9X9MHdPADCe5
         xRhnhOz3MGeFEiBrZPAlQwXL/1aARk52SbvAEzg+QPZ+5F6PQ5XLJ14RylyhEH8jq0IK
         mUqi+AliJujhhZT+qgxulfTKy2pERCMzCGfKdqL0g4WDKkUOlU6wtD9pqzceWMrc+q79
         XtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543470; x=1775148270;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGBNnYcyMccpdpNhrK4WEI6MensrK6wWkxqJK4annYs=;
        b=qfL847Y1645SQ/r182iGLV1mVBTcBjQ1BjXWLvlXtR5VnRfWmlKhFS8kn8/6kVrDMt
         gqQ0piEdkkA/KJX7Ez5Fd905JLZQ98S1fsjhx+nocB73g4QQ1WeXKYfexuAtatqk7TPh
         Lqpc6LcDV6z4+W4K+ocsv/pyc+V12rTyjiUUbTSKBtyilHD8Vj/SW47B48iCoEkmrkQJ
         fN+JiuIS01//NVK7wZW7TOxFmFz8SoDYUe8pDs8HTAoo2ItzAZyIjwEAIFBe6HJox+lC
         imBCbkbq7jkqYjHvE+TV/u2qLVwB+yTw8wXFcr38jpbrDuD56QsxCBDBA+T41ygyeWP0
         oFmw==
X-Forwarded-Encrypted: i=1; AJvYcCVjnLVpFXVpGOHItWJ8aVk/1/9xprqes2uNW6pxpHsRMvK+vdjyZnq3P3hpE2vmsvd6uP6NDss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YKSY8FMxwvjE0/XAM3RCCQg/zUoxxfVHLuonGqPppTVnIS9q
	lafmSLUbnFdJLQYd0nkV26z3k50XONq7TugWWuCEGp1Z8RtQriFxi4rOGvo6ZdUOfw8=
X-Gm-Gg: ATEYQzxDsl0ikqHsk+FQj7iOYUXU3KffzLxVQ+x1Uz3ucRreTYMSmfyqRnTvHlqs8Ku
	ne2n3hcCzUY0h2NikzqBLnuR1YYpZxe11cd5CEeRC37J3ZBdYn+KN1HPb0TxOE7qzw7MW/94Sgd
	wc8C9FX0E/QJJTyH9d5D+wwtL4qUjGUOrCY+QWlFisNBDBHRtm1bGhfONzbUAxnHoVVUascOTpA
	spklfWsVyBV/gWq4eePcK4ZdzEuX5btfxa4tywKacA1mpN5478JNP0XGn8sW71v8U3M/s1wPrnt
	pHocxxiOxMMildUHYnOsLJAfvVvqNA8AK7GtWTIJhTeD7fJ1R6hl6S64/pg3S+hjBEWoeV1zyH1
	Ra6GrtrLlg772+rE+KimX9+1ZyqluATBTBKrU74dUmHXaWvPCS/tC9Gi0gQF6ujXMg+EYvNJQWz
	pyt/hJ0pT5zVlAvgA2UqEP5WW60uPjEKn8ZalfmI0QP4sfxzJ6pFjO7GmWMchkKyz7IBFIUtHWn
	RHi
X-Received: by 2002:adf:b648:0:b0:43b:8820:58cf with SMTP id ffacd0b85a97d-43b88a7472bmr5093339f8f.4.1774543470011;
        Thu, 26 Mar 2026 09:44:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e35esm8469873f8f.6.2026.03.26.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 09:44:29 -0700 (PDT)
Message-ID: <a4a4ba6d-da13-4bb1-b6b2-1f9a5de190a7@6wind.com>
Date: Thu, 26 Mar 2026 17:44:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH net-next 2/3] seg6: add SRv6 L2 tunnel device (srl2)
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <20260322000557.12559-3-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260322000557.12559-3-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-272153-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:dkim,6wind.com:replyto,6wind.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Queue-Id: D7B9D338DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 22/03/2026 à 01:05, Andrea Mayer a écrit :
> Introduce srl2, an Ethernet pseudowire device over SRv6. It
> encapsulates L2 frames in IPv6 with a Segment Routing Header for
> transmission across an SRv6 network.
> 
> The encapsulation logic reuses seg6_do_srh_encap() with
> IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
> infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
> 
> The device is configured with a segment list for point-to-point
> L2 encapsulation.
> 
> Usage:
> 
>   ip link add srl2-0 type srl2 segs fc00::a,fc00::b
> 
> Co-developed-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> Signed-off-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  include/linux/srl2.h      |   7 +
>  include/uapi/linux/srl2.h |  20 +++
>  net/ipv6/Kconfig          |  16 +++
>  net/ipv6/Makefile         |   1 +
>  net/ipv6/seg6.c           |   1 +
>  net/ipv6/srl2.c           | 269 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 314 insertions(+)
>  create mode 100644 include/linux/srl2.h
>  create mode 100644 include/uapi/linux/srl2.h
>  create mode 100644 net/ipv6/srl2.c
> 
> diff --git a/include/linux/srl2.h b/include/linux/srl2.h
> new file mode 100644
> index 000000000000..c1342b979402
> --- /dev/null
> +++ b/include/linux/srl2.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _LINUX_SRL2_H
> +#define _LINUX_SRL2_H
> +
> +#include <uapi/linux/srl2.h>
> +
> +#endif
Is this really needed?

> diff --git a/include/uapi/linux/srl2.h b/include/uapi/linux/srl2.h
> new file mode 100644
> index 000000000000..e7c8f6fc0791
> --- /dev/null
> +++ b/include/uapi/linux/srl2.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> +/*
> + *  SRv6 L2 tunnel device
> + *
> + *  Author:
> + *  Andrea Mayer <andrea.mayer@uniroma2.it>
> + */
> +
> +#ifndef _UAPI_LINUX_SRL2_H
> +#define _UAPI_LINUX_SRL2_H
> +
> +enum {
> +	IFLA_SRL2_UNSPEC,
> +	IFLA_SRL2_SRH,	/* binary: struct ipv6_sr_hdr + segments */
> +	__IFLA_SRL2_MAX,
> +};
> +
> +#define IFLA_SRL2_MAX (__IFLA_SRL2_MAX - 1)
It should probably be generated automatically from specs, see
https://docs.kernel.org/userspace-api/netlink/intro-specs.html

> +
> +#endif
> diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
> index b8f9a8c0302e..9c8f7e254435 100644
> --- a/net/ipv6/Kconfig
> +++ b/net/ipv6/Kconfig
> @@ -318,6 +318,22 @@ config IPV6_SEG6_BPF
>  	depends on IPV6_SEG6_LWTUNNEL
>  	depends on IPV6 = y
>  
> +config IPV6_SRL2
> +	tristate "IPv6: SRv6 L2 tunnel device"
> +	depends on IPV6_SEG6_LWTUNNEL
> +	select DST_CACHE
> +	help
> +	  SRv6 virtual Ethernet device that encapsulates L2 frames in
> +	  IPv6 with a Segment Routing Header (SRH) for transmission
> +	  over an SRv6 network.
> +	  Intended for use with a remote seg6local L2 decapsulation
> +	  behavior, such as End.DT2U or End.DX2.
> +
> +	  To compile this as a module, choose M here: the module will
> +	  be called srl2.
> +
> +	  If unsure, say N.
> +
>  config IPV6_RPL_LWTUNNEL
>  	bool "IPv6: RPL Source Routing Header support"
>  	depends on IPV6
> diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
> index 2c9ce2ccbde1..a7e81d0293ca 100644
> --- a/net/ipv6/Makefile
> +++ b/net/ipv6/Makefile
> @@ -24,6 +24,7 @@ ipv6-$(CONFIG_SYN_COOKIES) += syncookies.o
>  ipv6-$(CONFIG_NETLABEL) += calipso.o
>  ipv6-$(CONFIG_IPV6_SEG6_LWTUNNEL) += seg6_iptunnel.o seg6_local.o
>  ipv6-$(CONFIG_IPV6_SEG6_HMAC) += seg6_hmac.o
> +obj-$(CONFIG_IPV6_SRL2) += srl2.o
>  ipv6-$(CONFIG_IPV6_RPL_LWTUNNEL) += rpl_iptunnel.o
>  ipv6-$(CONFIG_IPV6_IOAM6_LWTUNNEL) += ioam6_iptunnel.o
>  
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 1c3ad25700c4..23213ab4fefd 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -72,6 +72,7 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(seg6_validate_srh);
>  
>  struct ipv6_sr_hdr *seg6_get_srh(struct sk_buff *skb, int flags)
>  {
> diff --git a/net/ipv6/srl2.c b/net/ipv6/srl2.c
> new file mode 100644
> index 000000000000..66aa5375d218
> --- /dev/null
> +++ b/net/ipv6/srl2.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  SRv6 L2 tunnel device (srl2)
> + *
> + *  A virtual Ethernet device that encapsulates L2 frames in IPv6 with a
> + *  Segment Routing Header (SRH) for transmission over an SRv6 network.
> + *  On the remote side, a seg6_local behavior such as End.DT2U or End.DX2
> + *  decapsulates the inner Ethernet frame for L2 delivery.
> + *
> + *  The encapsulation logic reuses seg6_do_srh_encap() from seg6_iptunnel.c
> + *  with IPPROTO_ETHERNET (143). The transmit path uses the standard IPv6
> + *  tunnel infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
> + *
> + *  Authors:
> + *	Andrea Mayer <andrea.mayer@uniroma2.it>
> + *	Stefano Salsano <stefano.salsano@uniroma2.it>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <net/dst_cache.h>
> +#include <net/ip6_route.h>
> +#include <net/ip_tunnels.h>
> +#include <net/ip6_tunnel.h>
> +#include <net/seg6.h>
> +#include <linux/seg6.h>
> +#include <linux/srl2.h>
> +
> +/* Conservative initial estimate for SRH size before newlink provides
> + * the actual value. 256 bytes accommodates up to 15 SIDs.
> + */
> +#define SRL2_SRH_HEADROOM_EST	256
> +
> +struct srl2_priv {
> +	struct ipv6_sr_hdr	*srh;
> +	struct dst_cache	dst_cache;
> +};
> +
> +/*
> + * srl2_xmit - encapsulate an L2 frame in IPv6+SRH and transmit
> + *
> + * When the bridge (or local stack) sends a frame through this device,
> + * skb->data points to the inner Ethernet header.  We look up a route
> + * towards the first SID, prepend the outer IPv6+SRH via
> + * seg6_do_srh_encap(), and transmit via ip6tunnel_xmit().
> + *
> + * The route lookup result is cached per-cpu in dst_cache. Since the
> + * first SID is constant for the lifetime of the device, the cache
> + * avoids repeated route lookups in the common case.
> + */
> +static netdev_tx_t srl2_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct srl2_priv *priv = netdev_priv(dev);
> +	struct net *net = dev_net(dev);
> +	struct dst_entry *dst;
> +	struct flowi6 fl6;
> +	int err;
> +
> +	local_bh_disable();
> +	dst = dst_cache_get(&priv->dst_cache);
> +	local_bh_enable();
> +
> +	if (unlikely(!dst)) {
> +		memset(&fl6, 0, sizeof(fl6));
> +		fl6.daddr = priv->srh->segments[priv->srh->first_segment];
> +
> +		dst = ip6_route_output(net, NULL, &fl6);
> +		if (dst->error) {
> +			dst_release(dst);
> +			DEV_STATS_INC(dev, tx_carrier_errors);
> +			goto drop;
> +		}
> +
> +		if (dst_dev(dst) == dev) {
> +			dst_release(dst);
> +			DEV_STATS_INC(dev, collisions);
> +			goto drop;
> +		}
> +
> +		local_bh_disable();
> +		/* saddr is unused */
> +		dst_cache_set_ip6(&priv->dst_cache, dst, &fl6.saddr);
> +		local_bh_enable();
> +	}
> +
> +	skb_scrub_packet(skb, false);
> +
> +	skb_dst_set(skb, dst);
> +
> +	err = seg6_do_srh_encap(skb, priv->srh, IPPROTO_ETHERNET);
> +	if (unlikely(err)) {
> +		DEV_STATS_INC(dev, tx_errors);
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	skb->protocol = htons(ETH_P_IPV6);
> +
> +	ip6tunnel_xmit(NULL, skb, dev, 0);
> +
> +	return NETDEV_TX_OK;
> +
> +drop:
> +	DEV_STATS_INC(dev, tx_dropped);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static int srl2_dev_init(struct net_device *dev)
> +{
> +	struct srl2_priv *priv = netdev_priv(dev);
> +
> +	return dst_cache_init(&priv->dst_cache, GFP_KERNEL);
> +}
> +
> +static void srl2_dev_uninit(struct net_device *dev)
> +{
> +	struct srl2_priv *priv = netdev_priv(dev);
> +
> +	dst_cache_destroy(&priv->dst_cache);
> +}
> +
> +static void srl2_dev_free(struct net_device *dev)
> +{
> +	struct srl2_priv *priv = netdev_priv(dev);
> +
> +	kfree(priv->srh);
> +}
> +
> +static const struct net_device_ops srl2_netdev_ops = {
> +	.ndo_init		= srl2_dev_init,
> +	.ndo_uninit		= srl2_dev_uninit,
> +	.ndo_start_xmit		= srl2_xmit,
> +	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_validate_addr	= eth_validate_addr,
> +};
> +
> +static void srl2_setup(struct net_device *dev)
> +{
> +	ether_setup(dev);
> +
> +	dev->netdev_ops = &srl2_netdev_ops;
> +	dev->needs_free_netdev = true;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +	dev->needed_headroom = LL_MAX_HEADER + sizeof(struct ipv6hdr) +
> +			       SRL2_SRH_HEADROOM_EST;
> +
> +	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
> +	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
> +	dev->lltx = true;
> +
Maybe setting dev->netns_immutable to true ?

Regards,
Nicolas

> +	eth_hw_addr_random(dev);
> +}
> +
> +static const struct nla_policy srl2_policy[IFLA_SRL2_MAX + 1] = {
> +	[IFLA_SRL2_SRH]	= { .type = NLA_BINARY },
> +};
> +
> +static int srl2_validate(struct nlattr *tb[], struct nlattr *data[],
> +			 struct netlink_ext_ack *extack)
> +{
> +	if (!data || !data[IFLA_SRL2_SRH]) {
> +		NL_SET_ERR_MSG(extack, "SRH with segment list is required");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int srl2_newlink(struct net_device *dev,
> +			struct rtnl_newlink_params *params,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct srl2_priv *priv = netdev_priv(dev);
> +	struct nlattr **data = params->data;
> +	struct ipv6_sr_hdr *srh;
> +	int srhlen;
> +	int len;
> +
> +	srh = nla_data(data[IFLA_SRL2_SRH]);
> +	len = nla_len(data[IFLA_SRL2_SRH]);
> +
> +	if (len < sizeof(*srh) + sizeof(struct in6_addr)) {
> +		NL_SET_ERR_MSG(extack, "SRH too short");
> +		return -EINVAL;
> +	}
> +
> +	if (!seg6_validate_srh(srh, len, false)) {
> +		NL_SET_ERR_MSG(extack, "Invalid SRH");
> +		return -EINVAL;
> +	}
> +
> +	priv->srh = kmemdup(srh, len, GFP_KERNEL);
> +	if (!priv->srh)
> +		return -ENOMEM;
> +
> +	srhlen = ipv6_optlen(srh);
> +
> +	dev->needed_headroom = LL_MAX_HEADER + sizeof(struct ipv6hdr) + srhlen;
> +
> +	/* dev->mtu is the inner L3 payload size. Since SRv6 encapsulation
> +	 * carries the full inner Ethernet frame, subtract both the outer
> +	 * IPv6+SRH overhead and ETH_HLEN from ETH_DATA_LEN.
> +	 */
> +	dev->mtu = ETH_DATA_LEN - sizeof(struct ipv6hdr) - srhlen - ETH_HLEN;
> +	dev->min_mtu = ETH_MIN_MTU;
> +	dev->max_mtu = IP_MAX_MTU - sizeof(struct ipv6hdr) - srhlen - ETH_HLEN;
> +
> +	dev->priv_destructor = srl2_dev_free;
> +
> +	return register_netdevice(dev);
> +}
> +
> +static void srl2_dellink(struct net_device *dev, struct list_head *head)
> +{
> +	unregister_netdevice_queue(dev, head);
> +}
> +
> +static size_t srl2_get_size(const struct net_device *dev)
> +{
> +	const struct srl2_priv *priv = netdev_priv(dev);
> +	int srhlen = ipv6_optlen(priv->srh);
> +
> +	return nla_total_size(srhlen);
> +}
> +
> +static int srl2_fill_info(struct sk_buff *skb, const struct net_device *dev)
> +{
> +	const struct srl2_priv *priv = netdev_priv(dev);
> +	int srhlen = ipv6_optlen(priv->srh);
> +
> +	if (nla_put(skb, IFLA_SRL2_SRH, srhlen, priv->srh))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +static struct rtnl_link_ops srl2_link_ops __read_mostly = {
> +	.kind		= "srl2",
> +	.maxtype	= IFLA_SRL2_MAX,
> +	.policy		= srl2_policy,
> +	.priv_size	= sizeof(struct srl2_priv),
> +	.setup		= srl2_setup,
> +	.validate	= srl2_validate,
> +	.newlink	= srl2_newlink,
> +	.dellink	= srl2_dellink,
> +	.get_size	= srl2_get_size,
> +	.fill_info	= srl2_fill_info,
> +};
> +
> +static int __init srl2_init(void)
> +{
> +	return rtnl_link_register(&srl2_link_ops);
> +}
> +
> +static void __exit srl2_exit(void)
> +{
> +	rtnl_link_unregister(&srl2_link_ops);
> +}
> +
> +module_init(srl2_init);
> +module_exit(srl2_exit);
> +
> +MODULE_AUTHOR("Andrea Mayer <andrea.mayer@uniroma2.it>");
> +MODULE_AUTHOR("Stefano Salsano <stefano.salsano@uniroma2.it>");
> +MODULE_DESCRIPTION("SRv6 L2 tunnel device");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_RTNL_LINK("srl2");


