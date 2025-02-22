Return-Path: <netdev+bounces-168720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0DA4044E
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6C93AEF67
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511C73176;
	Sat, 22 Feb 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsRnN6vZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABB7082A
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184802; cv=none; b=a/t/bUCIvVNE0DX83qot17qyrWvZfjPpGrlaZs9vIq7tFq+/3ZDm9vf0FUIOb19cptwz29tKftckF9kaJizGqZFVqV2x+IwkDfqlRPoCxb8RSIlvIwZ7wFa8tIfgDLzph/0Cc6ExxCvOIQNVj6SemtD7ORpQW3OSmdtVg5HOfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184802; c=relaxed/simple;
	bh=jIXcGKN4jrP2kqERJoFAEUqSjjwvfj0lgvTHdLXDI+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unNy0vHB2PEzowcQAz2s4qQjXBRoXv9si/aF3HBDUWSJ3pEq4wUNs2ZuUHjgkeYtJGG3b5ddhLdj8gWEWTky3akVoFt+r1umAwsZSQffefmJ498X27ry647yiTzUSr9NngcXhTzmGizYzp824Xa7+9dQjwnqXy6nIxZ4OgqfsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsRnN6vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74580C4CED6;
	Sat, 22 Feb 2025 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184801;
	bh=jIXcGKN4jrP2kqERJoFAEUqSjjwvfj0lgvTHdLXDI+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HsRnN6vZGAvvg8mIQVsgE9BTXiDhFczgQuW2aFRfCfs4R2MdtkYM8vV05SOILAaba
	 sNOVX6LWI+BuhVLU5EakkgNh9z7KDDiq6S7qBIKjB1l/4b32RUk/y2D2n8TLpv9kW7
	 m/hqdEBDNf6dQuBzWYuQXn6+cF7s2bE8WKgMBhHf5qyDOycLtnjmgnTWuZ5gwopCR4
	 jaTry/V6ZuuywtMwDCj4r3Q+k29LamE9tuAePmQbL+cmNiyqd7QXJAQB499TmqKW43
	 VtKonhVZWQx7l1ZH0I8ZWoz+pJZaF5H2kgSTujn9we6LW0KNDOVNpN9+IjS3dLk+Yd
	 WxGa6AvDjZAyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE88380CEF6;
	Sat, 22 Feb 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: loopback: Avoid sending IP packets without an
 Ethernet header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018483225.2253519.5526334041096396876.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:40:32 +0000
References: <20250220072559.782296-1-idosch@nvidia.com>
In-Reply-To: <20250220072559.782296-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 maheshb@google.com, lucien.xin@gmail.com, fmei@sfs.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 09:25:59 +0200 you wrote:
> After commit 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> IPv4 neighbors can be constructed on the blackhole net device, but they
> are constructed with an output function (neigh_direct_output()) that
> simply calls dev_queue_xmit(). The latter will transmit packets via
> 'skb->dev' which might not be the blackhole net device if dst_dev_put()
> switched 'dst->dev' to the blackhole net device while another CPU was
> using the dst entry in ip_output(), but after it already initialized
> 'skb->dev' from 'dst->dev'.
> 
> [...]

Here is the summary with links:
  - [net] net: loopback: Avoid sending IP packets without an Ethernet header
    https://git.kernel.org/netdev/net/c/0e4427f8f587

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



