Return-Path: <netdev+bounces-154093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32579FB400
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D46188526E
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915A1C07EB;
	Mon, 23 Dec 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyJEz7Cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351F1C07C3
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978314; cv=none; b=V96HuMMJYEAPBy3XBgvhh20hkCvbwwpmR2gdi/Ydh3t6f6FJ6tmjITjAbs9jFHqJEFQOQvU6cq+yQVNCmy1mrNx1l2ja6fr3gKqZEa8RGpeH5IDyV3cxlynZbTLv/n331LepLWr7WCeFF7dOqfEPxLxr2P9+qmJap0E3+n4j5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978314; c=relaxed/simple;
	bh=EvVGnqQzG1NqrMcQ0RZQcKfZGnDbmldzWPgkmLGi4MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ1a4i2kkAUKuEuVLlh8H7yeTpfS3FO5pmGgac6WlFKFtTjexwgGoCkON6+H+f83vbgnruPa0Gwh6cT236TRL9FQyar+RmVbTrevfnV5VAs3r7BS2J9ZGJIrg+eokzaI6Rffv5i5CUNQZBS1hW/V3nxuxOxsdHwOaSg6Sq+GME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyJEz7Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9AFC4CED3;
	Mon, 23 Dec 2024 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978314;
	bh=EvVGnqQzG1NqrMcQ0RZQcKfZGnDbmldzWPgkmLGi4MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eyJEz7Cfll8pyuQEj9k3RgYCKZjcLYEtXIn9+UDpEXivNgu/NVrDvWvqW1QfmVb3o
	 msiqdBFpPf7Sf4O3qZasUEr5mJS0MPcl5UBTtcpFkNrtXZOTjVZB/zEz5k17z93tc9
	 l7R2lCeT7XJSge1zcjjl3JGc8qPR6J9NJKvPyka5qpZcyPs4KK5GZ/BkKEphuP9jBw
	 zaFDn0toXm7FaAsbbBnSs+87akFQbntw3KOdkL2MqsUg1jtOW12dob7371JUPsSW7j
	 u6woERsyZ4CoOIaUxlFoWJbhibHcvIslBjIJf8aZs2V0g7GKrQwZJBBimqnmhHZGYO
	 wcDeFUM+eWETA==
Date: Mon, 23 Dec 2024 10:25:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com,
 netdev@vger.kernel.org, "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?="
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v3] netlink: support dumping IPv4 multicast
 addresses
Message-ID: <20241223102512.68467ea3@kernel.org>
In-Reply-To: <20241221063522.1839126-1-yuyanghuang@google.com>
References: <20241221063522.1839126-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 15:35:22 +0900 Yuyang Huang wrote:
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

