Return-Path: <netdev+bounces-255036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENXWFqtRfGmwLwIAu9opvQ
	(envelope-from <netdev+bounces-255036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:37:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEFB7A5F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58A3330059A2
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B6314D13;
	Fri, 30 Jan 2026 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEWlIz8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36E2DF6E3
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755049; cv=none; b=cIXVDkbKN4x9gFN2o1nxHi1oSNnHOV79WjraATBandaktHG6hFx3C4wkiEBJzc3UrtD8WC8ryanTvkNAuv2bYs+QU1vTfJSsW4zAWi58Lw214LANhPMLyLP0dVPYxPaOjaB+rAG5mbrUhkSpjZCs6w5lfm+iLVCPmaZl/SYgbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755049; c=relaxed/simple;
	bh=95v7NV8y8jvkm5MvFyZ3sn6LRDvHRfQIIUv1qPreNHc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcbt9k+mljN4K397k6To+7KQC55b11i60kGUx5xfeTyS/NveZdab5PRZbnPacczemNMxh6O/61XBR+XCBRiZryV2X3A43AjXme+RRdK/qLfnAFx4gDTbMDaH02PNilE8wU7s63j2uGyCTzlHraXmaYkT5QnXh6F296zTFcUH0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEWlIz8/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1510238f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 22:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769755045; x=1770359845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iaIL6hcZTlvS2jyO/4/sgFg+iA2PNPmH4knID0fBdVs=;
        b=CEWlIz8/Ey8JQ76cky6LMxI2C+nzQavRmqmYHrq30lmWQcVJP+LvIv/A1Vslie0Yny
         Ton3JKnUPImiUuMhoV0EPZ1ErfybmYB94YvV5OOZewvpZwBfNk+w4mLAOZpqM1vhV2GW
         CRBGt92dAW6St1lFYEDYibAU3f3azFDxGTZxswiqf7kl/OTmKPHoLDWMQArl6FwHiZLC
         v2MIqWkb+qPPhhTcs43Kxu6jda6lFhrf9DS3gtE1YBEmluzQ5KJkRQI5kmGOv28vgzjh
         BfECj+5ceHA5UqDsDDCE9zG4nQOCDjns/s2fdik5y8fnBiS0kjRcNOd6PqrfrdMseTRP
         ilaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769755045; x=1770359845;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaIL6hcZTlvS2jyO/4/sgFg+iA2PNPmH4knID0fBdVs=;
        b=T/UHuEXjl9wf9f46U/0Y8pnAkl9qjqp4dW4h67qeAy4Ya+eks/wFFl7kDdau1zu2KX
         IdF4HBqjB/QJtxIiZdO4DBXZ8y6RGmqtBBz1pevWzH+iFnHEch0ThieLeL7OazZ4iuke
         m9xLwgnulkv66oqEJkfAPdkWAVi9FxFFTdBTeRsSsPSBa46DHn1kDXGVwRK/yB/4QMz4
         3U1FKChcwn/IqTZfKkTU+RQN6f5Y4+4iIDJfVDSxSI5chjd8TyPsT5cWeuouRE7gb2gn
         LC5ccZnQm02i1TWfJ5fAS5l1bP3lWm8mcnNfIrBtnI7VINCyjMm78lSPmAd+EbF3PEjn
         arZQ==
X-Gm-Message-State: AOJu0Yw3DV2q5CMBFtgCEBlOdDxOWTqRxPZifXkSWl6oZrdLpYJIXJEp
	pyXfe6c4IqUum/k2c8McxqbRr3YeWBULz2tgS8rc0c3nQVN4MEvnNYVu
X-Gm-Gg: AZuq6aKKLLWNO7OAYyffpw4nuDCAap3a8zG/4RxZiFPQzaHu4/u5wUIgNO3yDhwKHZa
	5BMPifkf3uQDJk4DDebdg1IWGE/3ZMBs9iLAoCQdsz2KlCujk2diw4DWtbJHwDG6sRTp7ujnNbe
	tRnwMGgpPRN36D7WZ/TdissT3do8xIUtuCN3M4hjPkBbM6yXSS+eaQlR8sG+P2v1CcTD+vDH3ot
	jsiu5y/9Pr0tJVOQZ/uT9A/57Oa2bRJ3g3S6ycgRYYWgcORZnZWzuuetPWS7WaexfKS65eFZVz8
	6gJ1b5DmuCHZglAAHXeSiibncz/PhiGbqpwK91fBjA5rHqSi58EuKCqnQ4WroJVtSZGDilNo8Nx
	ne1yBts4lLfSYDWSwl8qzREiAJTxBYYRWHXbcrv9Ot1gt7mPcqbZk9AozO9DfYOVOqFEWyBi2JU
	9GQTBoZgHNNFBv8c7NdD1Z+A85bMqFV+pUv9upIjBa/wp9FJdGYVDmIq/oucXjmWmfqCm/qHzQP
	IAzejeeJPKWxSqUXdm1v/ZOUZ1NzKFlQPHBr69P/B1Q1EODlqyK9Q==
X-Received: by 2002:a05:600c:3e10:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-482db4922d1mr20017285e9.17.1769755045218;
        Thu, 29 Jan 2026 22:37:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:1500:a5ab:a2a5:28b0:fbf7? (p200300ea8f341500a5aba2a528b0fbf7.dip0.t-ipconnect.de. [2003:ea:8f34:1500:a5ab:a2a5:28b0:fbf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e2543dcdsm5069745e9.9.2026.01.29.22.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 22:37:24 -0800 (PST)
Message-ID: <63ecf47d-6702-49d0-b063-f2f2510ef45b@gmail.com>
Date: Fri, 30 Jan 2026 07:37:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: lantiq_etop: remove driver
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
 Daniel Golle <daniel@makrotopia.org>
References: <7b2b53b6-d230-47bb-98d9-b7acfbfdd8ca@gmail.com>
Content-Language: en-US
In-Reply-To: <7b2b53b6-d230-47bb-98d9-b7acfbfdd8ca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255036-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0FEFB7A5F
X-Rspamd-Action: no action

On 1/29/2026 6:18 PM, Heiner Kallweit wrote:
> This driver in mainline lost its in-tree user with commit cd93b4895ea5
> ("MIPS: lantiq: drop mips_machine support") in 2012. Since then it has
> had no in-tree user. Only user seems to be OpenWRT, with several changes
> to the in-tree driver version:
> target/linux/lantiq/patches-6.12/035-owrt-lantiq-wifi-and-ethernet-eeprom-handling.patch
> target/linux/lantiq/patches-6.12/028-NET-lantiq-various-etop-fixes.patch
> target/linux/lantiq/patches-6.12/701-NET-lantiq-etop-of-mido.patch
> So it seems the driver is maintained in OpenWrt only, except tree-wide
> in-tree changes. According to OpenWRT maintainers it would be ok to
> remove the driver in mainline and keep it downstream only (see linked
> conversation).
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Link: https://lore.kernel.org/netdev/d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de/T/#t
> ---
>  .../include/asm/mach-lantiq/lantiq_platform.h |  18 -
>  drivers/net/ethernet/Kconfig                  |   6 -
>  drivers/net/ethernet/Makefile                 |   1 -
>  drivers/net/ethernet/lantiq_etop.c            | 745 ------------------
>  4 files changed, 770 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-lantiq/lantiq_platform.h
>  delete mode 100644 drivers/net/ethernet/lantiq_etop.c
> 
> diff --git a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
> deleted file mode 100644
> index 70ebb4d6f05..00000000000
> --- a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *
> - *  Copyright (C) 2010 John Crispin <john@phrozen.org>
> - */
> -
> -#ifndef _LANTIQ_PLATFORM_H__
> -#define _LANTIQ_PLATFORM_H__
> -
> -#include <linux/socket.h>
> -
> -/* struct used to pass info to network drivers */
> -struct ltq_eth_data {
> -	struct sockaddr mac;
> -	int mii_mode;
> -};
> -
> -#endif
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index aa7103e7f47..9775fd401b0 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -93,12 +93,6 @@ config KORINA
>  	  If you have a Mikrotik RouterBoard 500 or IDT RC32434
>  	  based system say Y. Otherwise say N.
>  
> -config LANTIQ_ETOP
> -	tristate "Lantiq SoC ETOP driver"
> -	depends on SOC_TYPE_XWAY
> -	help
> -	  Support for the MII0 inside the Lantiq SoC
> -
AI review complained that setting this config symbol should be
removed from arch/mips/configs/xway_defconfig. So I'll submit a v2.

--
pw-bot: cr

