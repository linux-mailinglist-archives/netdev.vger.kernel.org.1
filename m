Return-Path: <netdev+bounces-44630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235A7D8D45
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B07B21285
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040217EF;
	Fri, 27 Oct 2023 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k89mxws/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009C64A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80473C433C7;
	Fri, 27 Oct 2023 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698375238;
	bh=EyXeSNLa7tK0DV/fDsJKBnuzy0cW8YEfE0jxXnhc4Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k89mxws/0RO+ZLD6H8KeP5mmMgdoGmsjPkWWYQfmTVQmSXwV11VtY906pAvyGUexf
	 bOxqu6NuKwlxJ5a7vmMJLAMGSfLYjXGLwjD2Dw9SL1x8sTFjsfh6ZiTx+MWXOao04E
	 BmOQOKpubtgnNw4YQljcoB7xSHplTxAdDzIbC1TZfQmnjZWMe0W6nQBsYHSj5YkNF/
	 pBcG7+k1zq/KyImq222S7AuLN/EUA+KtH9eUUN0Kl1dTDOc+F30r6ipyQPq3TVDJPY
	 y+iCJrSAbbhrPmWlG9L+nrVd0dXEJMlXWu0xtfMCHkxm9L3p+Zv6DJ6LxEQDKJzE73
	 uxekNKAfjdIfg==
Date: Thu, 26 Oct 2023 19:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Daniil
 Tatianin <d-tatianin@yandex-team.ru>, Simon Horman <horms@kernel.org>,
 Justin Chen <justin.chen@broadcom.com>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Joe Damato <jdamato@fastly.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2 3/5] net: phy: Add pluming for
 ethtool_{get,set}_rxnfc
Message-ID: <20231026195356.7624669e@kernel.org>
In-Reply-To: <20231026224509.112353-4-florian.fainelli@broadcom.com>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
	<20231026224509.112353-4-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 15:45:07 -0700 Florian Fainelli wrote:
> Ethernet MAC drivers supporting Wake-on-LAN using programmable filters
> (WAKE_FILTER) typically configure such programmable filters using the
> ethtool::set_rxnfc API and with a sepcial RX_CLS_FLOW_WAKE to indicate
> the filter is also wake-up capable.

Should we explicitly check for WAKE? WAKE, and DISC are probably the
only values that make sense for PHY nfc?

