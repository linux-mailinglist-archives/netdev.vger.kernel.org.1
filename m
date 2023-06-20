Return-Path: <netdev+bounces-12372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC01737383
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BB51C20C3F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DD174F5;
	Tue, 20 Jun 2023 18:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492D2AB5D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63272C433C0;
	Tue, 20 Jun 2023 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687284511;
	bh=NY/tWi/zjKZWTcx2AE5BwIl1UX/bIBxKSgjWEyli4Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOvVgH7w2Qof4nq/kD3/0XwFvnhbPV6VKHl2bI7To1HN2S5x0qsmo8Cmqxl3JNdUM
	 V95iGdqsGKSxrDS07QsZK2vHEfGbA0g5E85Zs3iKjnripz5LyoAnhBRNMCbfZNvDC/
	 MO+bJ1pbm1UQNqyrRhld+YBflIYOkGP5Hwy8wMFQnBU059/WCPk1GfAIakMZQrJ+rJ
	 7V0PZ2k4wXSDRSLZbxEKzKvtkYTFwcvcsutnv5U0SCoYS96CQDw+w/GpXES7bHPGDj
	 kTy9rITbzX0V6Xsc68d4a986HFc0OhMo5MEGtDCNL9u0kmeVXVoKb1IL6UmZLr+0Qy
	 RWZvWXYcC7EDQ==
Date: Tue, 20 Jun 2023 11:08:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Message-ID: <20230620110830.7e16eb6f@kernel.org>
In-Reply-To: <1686788150-2641-1-git-send-email-Tristram.Ha@microchip.com>
References: <1686788150-2641-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jun 2023 17:15:50 -0700 Tristram.Ha@microchip.com wrote:
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches ARP request for IPv4 address of the net device using the
> PHY.
> 
> Multicast WoL matches IPv6 Neighbor Solicitation which is sent when
> somebody wants to talk to the net device using IPv6.  This
> implementation may not be appropriate and can be changed by users later.

Quick look at lan743x and natsemi seems to indicate that WAKE_ARP means
wake on _any_ arp, not arp directed to the local IPv4 addr.

Could you separate the changes to support other wake types out and post
separately? We can merge that without much controversy. The ARP may
need a discussion. My instinct is that since existing drivers interpret
ARP as any ARP we should add a new type to the uAPI for local ARP.

Sorry for the long review delay.
-- 
pw-bot: cr

