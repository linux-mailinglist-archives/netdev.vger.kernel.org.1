Return-Path: <netdev+bounces-20597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F19760345
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF001C20C87
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE42134AD;
	Mon, 24 Jul 2023 23:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CC12B6D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A5C433C7;
	Mon, 24 Jul 2023 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690242232;
	bh=xc3GbyDkN/vtNrG+9K09v2LJoqlN8c2/DWBOyoLqp4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mc5LmMIwGsi7ckAthGvVCq8IfCeOtZe/MVLUUM/x4ZxBYY45M41+Eaognvx9zoMWu
	 fAyEB1AWG45hHG62wciZaGdNmknTUfNc7QJrQw6mOjbVenVhb3kkbnmJaR2Dop3pRI
	 MbmJCtOSfAJhXbSZx7nyQUCk8TDSGRdxAAMTXeIDawOG+iUNme17hThUArnFKZnNO9
	 GUllftsHYkbaouHXcrMl0FkXGSbkIYoYbP6E6pduJQMfqqJ1yCTj3GFjos6WJnepiY
	 V4BdBrH4kNxnXyr//ZpcUkar5zUkWe37d6y7fchv8j9p1Ww39GKehwJ9yUBiHJ5d9X
	 a1JC8MYIC26Cw==
Date: Mon, 24 Jul 2023 16:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Message-ID: <20230724164351.2ecf6faf@kernel.org>
In-Reply-To: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
References: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 17:40:53 -0700 Tristram.Ha@microchip.com wrote:
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <net/if_inet6.h>
> +#include <net/ipv6.h>

You don't need these includes any more, right?

>  #include <linux/smscphy.h>
>  
>  /* Vendor-specific PHY Definitions */

> +static int lan874x_set_wol(struct phy_device *phydev,
> +			   struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *ndev = phydev->attached_dev;
> +	struct smsc_phy_priv *priv = phydev->priv;
> +	u16 val, val_wucsr;
> +	u8 data[128];
> +	u8 datalen;
> +	int rc;
> +
> +	if (wol->wolopts & WAKE_PHY)
> +		return -EOPNOTSUPP;

You're not advertising the support for WAKE_PHY, so you don't have to
check if it was requested. See recent commit 55b24334c0f2.

Please keep the review tags from Florian and Simon for v6, these are
minor nit picks.
-- 
pw-bot: cr

