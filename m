Return-Path: <netdev+bounces-44569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA847D8AFC
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F5282229
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A43D99D;
	Thu, 26 Oct 2023 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMT+wMfc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D84426
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 21:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E31BC433C8;
	Thu, 26 Oct 2023 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698357406;
	bh=4p2Y8y/+j2W0nrEmfMNRT7ybpiEYGUJzt74xW+AVL0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMT+wMfcQ99JqJdKasqGaK07OIoyHxfzjl4U1O3oMuz3I5r2u9uSuGg2dti7U73Jm
	 E+gMzSK4H7AsAh4c8b4GXmd+jWQy7voHLAgm9H3Ns7mzOZJ2eHCCQXtJy8Bva6yu0w
	 8tdroNth7cwhh0OtAuw85OBQ7gRxsISPJv9/7ul8oURh5aeHSyWMPq4BWzLv2p5fI8
	 CaZcXmBQMwWl8UdFYbzY5hZcxVTISNMZ3GR3r0PD7TV/frzRatMr+lqC1RDAa6pqaT
	 n11a6AyI41Y4qDWjF25cIT80kfNDJSI+qv42QIV5vE7qH8ZR99+vHVWzFKtxUR7c7x
	 E/e13lClXgg7g==
Date: Thu, 26 Oct 2023 14:56:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org,
 Doug Berger <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Daniil
 Tatianin <d-tatianin@yandex-team.ru>, Simon Horman <horms@kernel.org>,
 Justin Chen <justin.chen@broadcom.com>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Joe Damato <jdamato@fastly.com>, Jiri Pirko
 <jiri@resnulli.us>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] net: phy: broadcom: Add support for
 WAKE_FILTER
Message-ID: <20231026145644.58a8bd90@kernel.org>
In-Reply-To: <e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
	<20231025173300.1776832-5-florian.fainelli@broadcom.com>
	<CAMZ6RqJJXK5EyyOwXXbdA-bDTY=_JQ+xfKpoCHDJZqv+rNnASQ@mail.gmail.com>
	<CAMZ6Rq+iBazJ+fM5yd5Tfa8==DEGV93iD-XojU=f1m3ScSGEww@mail.gmail.com>
	<e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 10:55:10 -0700 Florian Fainelli wrote:
> >> Also, did you run parse to check your endianness conversions?  
> 
> I did, though nothing came out with C=1 or C=2, I might have to check 
> that separately.

FWIW

drivers/net/phy/bcm-phy-lib.c:1128:42: warning: cast to restricted __be16
drivers/net/phy/bcm-phy-lib.c:1128:40: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1128:40:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1128:40:    got unsigned short [usertype]
drivers/net/phy/bcm-phy-lib.c:1188:17: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1188:17:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1188:17:    got unsigned short [usertype]
drivers/net/phy/bcm-phy-lib.c:1190:25: warning: incorrect type in assignment (different base types)
drivers/net/phy/bcm-phy-lib.c:1190:25:    expected restricted __be16 [usertype] h_proto
drivers/net/phy/bcm-phy-lib.c:1190:25:    got int
drivers/net/phy/bcm-phy-lib.c:1193:33: warning: incorrect type in argument 3 (different base types)
drivers/net/phy/bcm-phy-lib.c:1193:33:    expected unsigned short [usertype] val
drivers/net/phy/bcm-phy-lib.c:1193:33:    got restricted __be16 [usertype] h_proto
-- 
pw-bot: cr

