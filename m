Return-Path: <netdev+bounces-37693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16907B6A94
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CB01E1C20756
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46042770F;
	Tue,  3 Oct 2023 13:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3448262AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5BDC433C8;
	Tue,  3 Oct 2023 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696340049;
	bh=YgpznB6UVwDAk8kZkqvYggW8dN/E0S+mAdS++LtlF0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cCwNRSLhR7ueBItEphJhcR6bYjpJmtiCtyuUcsw6+oL1oQvvtP6muvlQ8XBNEK6OF
	 Aa+SEEiKKBzyKSZf3pMJoPsBo7DGy6gdpJbMpKTUwHCGReYzO+4Na8lITqKDfQFOT0
	 oXnDX6nHmYIzfHEHEGnyeN/dDJU8PLv1RhxaZPnqWfaSayPgn3j9WT5XIqzKaYUuIG
	 ThoCB8ccZYGcN/mcPyrWRz4jpRI1PsOiy0JUVos0tU9h/lDeG9TV+TAdOT4SQcly4h
	 ZT6HAeUSjxub4ybVMDGyrHCEHgzmUmQAzmDMA8PzfdI4l9MfloMn5GHY9PYLQj6KYy
	 TQbJh3AJiODaw==
Date: Tue, 3 Oct 2023 06:34:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 Woojung Huh <woojung.huh@microchip.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com, Oleksij Rempel
 <linux@rempel-privat.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20231003063401.5fc0ffb9@kernel.org>
In-Reply-To: <20230911170222.hip2pcyzbfu3olau@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
	<20230911165848.0741c03c@wsk>
	<20230911160501.5vc4nttz6fnww56h@skbuf>
	<20230911170222.hip2pcyzbfu3olau@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 20:02:22 +0300 Vladimir Oltean wrote:
> Hi @Jakub, I remember you fixed some issues with the dev->dev_addr writes,
> after dev_addr_lists.c was changed to a rbtree. Is it easy for you to
> tell if the change below is safe from an API perspective?
> 
> Is the answer "yes, because dev_uc_add() uses an addr_type of NETDEV_HW_ADDR_T_UNICAST,
> and dev->dev_addr uses NETDEV_HW_ADDR_T_LAN, so they never share a struct netdev_hw_addr
> for the same MAC address, and thus, they never collide"?
> 
> The DSA and 8021q drivers currently have this pattern, from around 2008.
> But 8021q also tracks NETDEV_CHANGEADDR events on the real_dev, which is
> absent in DSA. If the change below is safe, it would be a simpler solution.

FWIW I think it should be fine from the rbtree perspective, but IDK how
the user space would react to having a duplicate lladdr.

