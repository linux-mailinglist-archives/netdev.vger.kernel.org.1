Return-Path: <netdev+bounces-115184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14696945604
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AD7281DA4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C630FB64E;
	Fri,  2 Aug 2024 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RassVBmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E523BE
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562621; cv=none; b=geX/QUXQ7b43COP3p3JinOclu9yfnOHu8JJc86zVmaxIdNyc/J5AHmaxzH+PelP3FyYfd4553PwmNKOu6H2nXPy4wH5tciLDayJ0PD0UXRsjd0JE6Id9y33ILoeZzvXQk6UzyC8Fcf2RuSzk3SaoBg7bNboErDaUPYRoXpamynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562621; c=relaxed/simple;
	bh=hxDbxNmJtDf3gQdGh/G+r7cz9bCNoOZ/xzfkI/2Qr14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQiTfsWZoTFq8lSWY2VcnJv8xDfg/IynAGf9TMmvj536kGyYUFD9frU6zpQcpyrXQYLrEW23ckDgiOgKndmewBeY62ioQs7eNkJeTwuQQCb0CIHXEwNBn354NXLOXKLVnA4Ugv6tpbQa3al6wr+f4vNSOVBiM2B1qvesX4+Hteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RassVBmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE129C32786;
	Fri,  2 Aug 2024 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722562621;
	bh=hxDbxNmJtDf3gQdGh/G+r7cz9bCNoOZ/xzfkI/2Qr14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RassVBmdB0BEtHo/BgnhvWKHyIE+7+uQgwnD9CW17vz2G7r+Ehwsm4ypeo6XWmCpb
	 WOCf634+9ZacosI7nHswMEgQlovKFaVQZLzwOsr62PoUBkZElOV87E9lPOIt30kMJ8
	 WyzELiXw4E06e3aNmoUxJaKt4nWs8LA1crbiMYN3hKUyP11RpXJWfM2B3JiL4mqkpF
	 bnzdntYzHHp0h6yBjIAZptIjJHOYvRHSqNDas2d6ZjAehN42wvAVK7x1k7X1Do4ZKZ
	 VdVNYZi/fk6BfLrmQzj5HUOvThgnaNJ1qs6glVbfB1OGsJDJscYgJtC1gDOVElX6ck
	 uPJsjd2UGUdAw==
Date: Thu, 1 Aug 2024 18:36:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, kernel-team@cloudflare.com,
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 0/2] Silence bad offload warning when sending UDP
 GSO with IPv6 extension headers
Message-ID: <20240801183659.17c25cbd@kernel.org>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Aug 2024 15:52:52 +0200 Jakub Sitnicki wrote:
> This series addresses a recent regression report from syzbot [1].
> Please see patch 1 description for details.

The test doesn't seem super happy in netdev CI:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/709100/79-udpgso-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/709101/78-udpgso-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/708921/75-udpgso-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/708921/78-udpgso-sh/stdout

