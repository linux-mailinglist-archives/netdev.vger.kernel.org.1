Return-Path: <netdev+bounces-154090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE69FB3F7
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54551883452
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD71B87CD;
	Mon, 23 Dec 2024 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD7z9au1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4B38F82
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978223; cv=none; b=CZfIx2vELEK7pSK6r4euygL2X6lHESdtqop157y4XGaMuH/GtahKY/FNcSTt3oBpuxGeoLgwTsRq6fiFrKvZzrNBh62K0oktHtzYg5019h7W5vgky98kGf3olpg2fy6K/sBwM3O6mD/2xtnlwW38RCX7gjF4ixQe74vevtCVdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978223; c=relaxed/simple;
	bh=xvZVNI6j74MP6vaBdTx8H56PKkPepTsYf4Hp7QAP4EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Apn+jJ8E4fE47Y8iEyhWKIalDxVnVpDibAirhysXhyr0mGff5jR8rk6jmg2Flr7dWUhjphAAa8FgL7evMG4gUGD8kYKMBNgxkdzrfkmoJYPnzftiAAD13X2LoBdaHG2q6eBtagD37uCkQg2sjGgL7rlaAGiiN8IKxa+TgSexbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD7z9au1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB5C4CED3;
	Mon, 23 Dec 2024 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978223;
	bh=xvZVNI6j74MP6vaBdTx8H56PKkPepTsYf4Hp7QAP4EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eD7z9au1mGqHhZ+qJiRFD1Fc9bBTJNm17ZQ4uqynwTWHL3ofemOlOR4yvYQE/okcV
	 VXB4ll/xRC+AzjNKjugA0uckMi5D2syfIQj2rh9kH4Pklyk/8wJoaq1HansWUMkmjU
	 22EQNqpF7S1CIXC/jugTNhNX8HhlavJKiEnHXdhPVYaPiallyCx5A8K7OMc0HZ4Gz6
	 F9odFjDLz0fN+c42xLai7ySGRAY2EO9zmjOX1PiokzrDLU/e1+xDFwV1CFkSxnEieW
	 rnCaqSL6ljSsIlNVPeSL48sLEU2pvhabxyNhYckIMs1PrfsPqCDX0WGPsF7Z59+Ax1
	 DEVMlE3BV9MLg==
Date: Mon, 23 Dec 2024 10:23:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, "Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>
Subject: Re: [PATCH net-next] netlink: add IPv6 anycast join/leave
 notifications
Message-ID: <20241223102341.4d1fa5f2@kernel.org>
In-Reply-To: <20241222010043.2200334-1-yuyanghuang@google.com>
References: <20241222010043.2200334-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Dec 2024 10:00:43 +0900 Yuyang Huang wrote:
> This change introduces a mechanism for notifying userspace
> applications about changes to IPv6 anycast addresses via netlink. It
> includes:
> 
> * Addition and deletion of IPv6 anycast addresses are reported using
>   RTM_NEWANYCAST and RTM_DELANYCAST.
> * A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
>   notifications.
> 
> This enables user space applications(e.g. ip monitor) to efficiently
> track anycast addresses through netlink messages, improving metrics
> collection and system monitoring. It also unlocks the potential for
> advanced anycast management in user space, such as hardware offload
> control and fine grained network control.

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

