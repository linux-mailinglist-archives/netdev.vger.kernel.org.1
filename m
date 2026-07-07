Return-Path: <netdev+bounces-305399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QB3cHbrRTGrmqAEAu9opvQ
	(envelope-from <netdev+bounces-305399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0271A2BF
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:15:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IFtfT7HR;
	dkim=pass header.d=redhat.com header.s=google header.b=kpApTWHW;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305399-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305399-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EB830B8256
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C43DB63C;
	Tue,  7 Jul 2026 10:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3E3BB682
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:12:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419182; cv=none; b=MyhNd1UAaFSkF+jM4VF5nzDeYH5AvX16NtW+orwa3J898Oq+NUxOZosat/QKrb8I6ezT17Hbbsm0z2erubwDJ5eBPCr4mI1NEk87/8lF2L2oMDTEPg1uyHHjLftNz/dgslrC0aHW6fHYbt2iOgqs5dhAaZlV9XnqHNEDwLPp1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419182; c=relaxed/simple;
	bh=AA0vCLlAc1TtvQ4SznGg5KAkz2FrgdZjPmINo2w8XeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUvU+21M2SEvB7iLBwJ7pqneTep7R9qmm5kGjbkipcHNJ1EjjsX5pZ9yQUCC6QuWLM4owbu6MXK8cxvPbdy14zN7PPjTJAD2piMFQ1XqYps5xoqfrLqXv6tImaDB0bHJRIWzUk6t1Vuex9XxjxNlbPet9W5UzkG39AQYKl+zqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFtfT7HR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kpApTWHW; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783419178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvDwnmdzKSx6fVqz/Bd4orzC5tkXC+3Ic0fgIY3KsO4=;
	b=IFtfT7HRoV8uuj9e/jKllXJexyo1hQZcqhew65BiJkMVaQEL1EVY6Uw8am8YRIbRMpUe7A
	V/Ss/kuXRhnMBLRsGWkGNp4u8oioVPb12moSwgd3GSV1MCIHwJhZRqa0zSc5XW9B9Y7ctq
	Qu4V2N/4CU34a8dbM6GDwqvyXcKK2EQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-UY8uW9MFM86_JR9fTslNvA-1; Tue, 07 Jul 2026 06:12:57 -0400
X-MC-Unique: UY8uW9MFM86_JR9fTslNvA-1
X-Mimecast-MFC-AGG-ID: UY8uW9MFM86_JR9fTslNvA_1783419176
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1260766980so354270366b.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783419176; x=1784023976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvDwnmdzKSx6fVqz/Bd4orzC5tkXC+3Ic0fgIY3KsO4=;
        b=kpApTWHW+MHKXrqci+XxtaZ0XdPnFTLe33EWwgCC/UrwjOjvpI7KfMDSs9jjCTGZL/
         Xj8BcXSldbXEimKJgwmWnZx2aXevA+8n9s7bIekNRr94B0QCwL8yWHMeBG/L5TXcxXul
         TkVbtwQKA+Aj8kz8IiQAoZH7DPuoYnO+I99/ms56pK3dEWLrqAnvCDC9SM6nMvKNEuca
         G+EwQM7ynGzmOW3ihk8N0AwoQ6MzFptvu9Xq2+axmvXJJ3FS9TZDrm7DYeEJqWWMOydG
         DV3mbJ5+BbvQ0J1FOEL1m6UmgYRoKBhxG6xp6A3qCzLS/zUmN3NIBpLVA+TZ0L1EsaPV
         tebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419176; x=1784023976;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvDwnmdzKSx6fVqz/Bd4orzC5tkXC+3Ic0fgIY3KsO4=;
        b=D0TaIpSx8fJ3wiHD09jZqaOoGKkEutgOvgr7DELoJxLmHuGpW6gxqLcXZwlCKrTipd
         5Y2F8CrZ13SaePoM8LVhTWmERxf4ImcJGxeqP27vHbID45ldLMSzXT6mXIXmlfBhI65V
         4yZdIzOIab+FgKmWEnO40O8d8HcdYDwwYIX4TtiBzH8M/T6NKtllUdm9qNFVlj/YlzHB
         5Rw4ka/Ph7Dan5aOHML3neJXGzg9dzN1AAETNhnq+w37M4lJSkSm5g/EVdBHy+9qLzzQ
         a6Rt9tLSAKIIHez5levB8BxNi/UH7FhVzAWRt7CnIdgWDE+XxRC5wzDg6AnrirqcpWHw
         iMug==
X-Gm-Message-State: AOJu0Yye5aHzQ5woHBJ3EkuVtU91YDwEcugsrzHuE+9NeLGfeki+p8N2
	kPp8yUoC3B0oiuHYrgyyu5YaXwoJeQ1fmQHEfSy05PcmFNcNRT+vOIPX4cgebHjxAXHhtdAvqZB
	8Z3tIw9UpTEVlnCNBAh6t49S+O+GxbvjRDMcFEJjndZYgcFHSSYhn+nBvxw==
X-Gm-Gg: AfdE7ckxNqb5OrhWYM5xXcK3Ga70v8CXA75uyzxGNCTFtmg91lv4v02EJe/Obnskz+V
	gRoB+h14xttlX+WxOxwoS1S978LmzE1K8Gp1n8CSUeLiJqHcr9VTntQBsXUiucgHj628MvTOYdu
	h+OoE4JH1s+m7QY6RZYF5Vt5jjKn8GBtZHplXOPTMx9w9FXUZDVhcGQdj7BAs286S+ZC8HilNvo
	hWWgJMkYy4LRG+ZoaNpX9ofoIGw7flCPnN6jXudY4KZvP7LbHPd2Aq9AhMYqbAV1tXkAEpVZS8h
	A3MVc3vsCULcQFy5cQWmc7p4cXympfI5Orla+ZmwlBOvM5YFH6c0g71hn+v16N76WqKhMkHGztl
	CXPioNfJcUTsoJFzqyCQdEPucvWhP2QLScgT7Iv+B5Clb5P9RUmXRfMFpIUp+1OFejRjquxCFYq
	EMN8KY3X9AX3Fm
X-Received: by 2002:a17:906:e28a:b0:c07:3e6f:5658 with SMTP id a640c23a62f3a-c15a67bdfe1mr187816066b.31.1783419176202;
        Tue, 07 Jul 2026 03:12:56 -0700 (PDT)
X-Received: by 2002:a17:906:e28a:b0:c07:3e6f:5658 with SMTP id a640c23a62f3a-c15a67bdfe1mr187812266b.31.1783419175745;
        Tue, 07 Jul 2026 03:12:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b634d60esm51045166b.7.2026.07.07.03.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:12:55 -0700 (PDT)
Message-ID: <aaef7304-573a-419e-b631-30b300373a08@redhat.com>
Date: Tue, 7 Jul 2026 12:12:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
 <20260701110427.143945-10-maxime.chevallier@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701110427.143945-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,armlinux.org.uk,gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sashiko.dev:url,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8B0271A2BF

On 7/1/26 1:04 PM, Maxime Chevallier wrote:
> Expose the phy_port information to userspace, so that we can know how
> many ports are available on a given interface, as well as their
> capabilities. For MDI ports, we report the list of supported linkmodes
> based on what the PHY that drives this port says.
> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
> can output on this port.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  MAINTAINERS           |   1 +
>  net/ethtool/Makefile  |   2 +-
>  net/ethtool/netlink.c |  25 +++
>  net/ethtool/netlink.h |   9 +
>  net/ethtool/port.c    | 373 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 409 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/port.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a9..d62eaafa8d53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18794,6 +18794,7 @@ F:	Documentation/devicetree/bindings/net/ethernet-connector.yaml
>  F:	Documentation/networking/phy-port.rst
>  F:	drivers/net/phy/phy_port.c
>  F:	include/linux/phy_port.h
> +F:	net/ethtool/port.c
>  K:	struct\s+phy_port|phy_port_
>  
>  NETWORKING [GENERAL]
> diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> index 629c10916670..9b5b09670008 100644
> --- a/net/ethtool/Makefile
> +++ b/net/ethtool/Makefile
> @@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
>  		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
>  		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
>  		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
> -		   phy.o tsconfig.o mse.o
> +		   phy.o tsconfig.o mse.o port.o
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 1af395b54330..c076c07d0a08 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -26,6 +26,8 @@ static u32 ethnl_bcast_seq;
>  			     ETHTOOL_FLAG_OMIT_REPLY)
>  #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
>  
> +char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
> +
>  const struct nla_policy ethnl_header_policy[] = {
>  	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
>  	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
> @@ -431,6 +433,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
>  	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
>  	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
>  	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
> +	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
>  };
>  
>  static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
> @@ -1572,6 +1575,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  		.policy = ethnl_mse_get_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
>  	},
> +	{
> +		.cmd	= ETHTOOL_MSG_PORT_GET,
> +		.doit	= ethnl_default_doit,
> +		.start	= ethnl_port_dump_start,
> +		.dumpit	= ethnl_port_dumpit,
> +		.done	= ethnl_port_dump_done,
> +		.policy = ethnl_port_get_policy,
> +		.maxattr = ARRAY_SIZE(ethnl_port_get_policy) - 1,
> +	},

Both sashikos instances points to multiple races with dumps. I suspect
some explicit locking is required.

https://sashiko.dev/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com

I *think* this is hopefully the last pending issue.

/P


