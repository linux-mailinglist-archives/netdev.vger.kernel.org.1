Return-Path: <netdev+bounces-277215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHysBDdn2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C63D19DE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B473023DE8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF0A3033E9;
	Fri, 10 Apr 2026 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnFOYfpo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F1302750;
	Fri, 10 Apr 2026 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789844; cv=none; b=GDrw4W+SBdMav3hMLHJhq1fJCsjt78MQbydo9uJyUE42qwv9mE+2c1VBClKaJhUSm1LrBLvt665j1B1kb5m62SNl8YAw4bhGfNY1z9waNt7uMFBkQXmYVBolK2HlRfwX5gsPhMgi9JpEvj5IqvEYffI3NVFxdjTUuDcbQoqNN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789844; c=relaxed/simple;
	bh=SOtsO1H4hBhJ7UgGNQF2cWoATJZ7lwtCCm/KkSB8iFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIOkowdM4HacEvZ4BYHT7OL4KwNoPjRGO6MSJGn0bmWn+QuI7b8PBUilNJyFXTh+/WdyjfFBPxMwWpDY7UPk0+liDedRXEHbcmJoBGgYzGkSy3bo6+oJ8X69uQkWxKi5qVVdYPd8UvpvNp2ucrYQ3QOWIbU3RlLn8CpRPZ6FadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnFOYfpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690A3C4CEF7;
	Fri, 10 Apr 2026 02:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789844;
	bh=SOtsO1H4hBhJ7UgGNQF2cWoATJZ7lwtCCm/KkSB8iFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnFOYfpo9b+bO1fznuRTZ5Iv+akaYDbstDHVouFywHRepUoqYUoE/tDWcklCZeo4j
	 ZfPGDK/tulUNrULmUueq4RLzPIiq6mA8ZIW7sgVtREWz+EXGkqrsF9d8A6RgPwW02I
	 6skMAUB3KXLd7tB71Tuq253H5VmfSapnc/DsPKO9STrfKScrhkTzjEQwz7ng889dZB
	 p9JlE0VCy4qQAei9coPoxl/2Wf/rcz0vrlH9RojTh6+XuGShXDeqjYZEGylfIwgyU6
	 n7qVIcmNJ81sCJReDg+zIFbm4NwXjzTJVPrMWzfpTHh74r0x5ytgnp0xetXNW0e6rn
	 IpG7M3Kr+qW+w==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/12] net: airoha: Rely on net_device pointer in HTB callbacks
Date: Thu,  9 Apr 2026 19:57:22 -0700
Message-ID: <20260410025722.1809973-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-4-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-4-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-277215-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C0C63D19DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
net: airoha: Introduce WAN device flag

This commit introduces a WAN flag to specify whether a device is used to
transmit or receive WAN or LAN traffic. It enables specifying multiple LAN
devices but limits the configuration to a single WAN device.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 5b0cd37b155e4..9988011dca53f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1796,36 +1796,77 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)

[ ... ]

> +static int airoha_dev_init(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	struct airoha_gdm_port *port = dev->port;
>  
>  	switch (port->id) {
>  	case AIROHA_GDM3_IDX:
> -	case AIROHA_GDM4_IDX:
> -		/* If GDM2 is active we can't enable loopback */
> -		if (!eth->ports[1]) {
> -			int err;
> +	case AIROHA_GDM4_IDX: {
> +		struct airoha_eth *eth = dev->eth;
>  
> -			err = airoha_set_gdm2_loopback(dev);
> -			if (err)
> -				return err;
> -		}
> +		if (eth->ports[1] || airoha_get_wan_gdm_dev(eth))
> +			break;

If a board's Device Tree enables both GDM3 and GDM4, and GDM2 is not present,
does this sequence permanently assign the WAN role to GDM3 since it is
initialized first? Is there a Device Tree property or fallback configuration
mechanism to allow users to specify GDM4 as the WAN port instead?

> +		fallthrough;
> +	}
> +	case AIROHA_GDM2_IDX:
> +		/* GDM2 is always used as wan */
> +		dev->flags |= PRIV_FLAG_WAN;
>  		break;
>  	default:
>  		break;
>  	}
>  
> -	for (i = 0; i < eth->soc->num_ppe; i++)
> -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> +	airoha_dev_set_qdma(dev);
> +	airoha_set_macaddr(dev, netdev->dev_addr);

Since the commit message notes it is possible to specify multiple LAN
devices, does unconditionally calling airoha_set_macaddr() for each
device overwrite the single shared hardware LAN MAC register?

If so, could this cause only the last initialized LAN device to have its MAC
correctly programmed into the hardware, leading to dropped unicast
packets for the other LAN interfaces?

> +
> +	if (!airoha_is_lan_gdm_dev(dev) &&
> +	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
> +		int err;

[ ... ]

