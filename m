Return-Path: <netdev+bounces-32601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317A798A2E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B60E281B4F
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061AF9D1;
	Fri,  8 Sep 2023 15:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1A4C93
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085BBC433C9;
	Fri,  8 Sep 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694187972;
	bh=VNbazyRE370gNZi/pHSUlpmXcMceT96Fm7hfdqN6qm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+NDGlJV7b50NBiPVfSJUusyYpzLVAcE2elkubEwzBbLd6BTsm4n2noLzVcIJDinM
	 8N/F1KIUkj8eKSRy5mAXBRcBqE5Mrx1/IF65g+6x0vf8xUQI+VX2lSX1Syaiw0EKIE
	 Ca+fUBcUOFFlwmmMk1BUy7B/LghUxcD9rum750l3LwylSlqzQkQaPv+EncszfZxLo1
	 vfp12Bygewy/qQnhG8vMxwWEvRbmFoVvRpadgV9pu5RCl3yAFYuoMgNDbeSnziYQV2
	 4ZjTUgjo6Gih931sjhnKHwtsu8r/CyUwlAJi99zK5p5HgzB4IEibQWI5AyEFFR3eY5
	 CkfZjTt472MBg==
Date: Fri, 8 Sep 2023 08:46:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230908084606.5707e1b1@kernel.org>
In-Reply-To: <20230907092407.647139-7-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Sep 2023 11:24:04 +0200 Maxime Chevallier wrote:
>  	ETHTOOL_MSG_PHY_LIST_GET,
> +	ETHTOOL_MSG_PHY_GET,

The distinction between LIST_GET and GET is a bit odd for netlink.
GET has a do and a dump. The dump is effectively LIST_GET.

The dump can accept filtering arguments, like ifindex, if you want 
to narrow down the results, that's perfectly fine (you may need to
give up some of the built-in ethtool scaffolding, but it shouldn't 
be all that bad).

