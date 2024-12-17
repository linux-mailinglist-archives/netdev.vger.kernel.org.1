Return-Path: <netdev+bounces-152469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867C9F40A6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B88188E312
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96B770827;
	Tue, 17 Dec 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLfk6r6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537213B780
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402139; cv=none; b=CvMdvTZk8/LSIsiAiWRWgxyn3gJl6Ys0f4GmV4GTT3Qse3/KO2sDyAJ+tgEpjmfkIdXr7lqaL9qC1u/DVgesPZ/L4/s7x6nsAwOqzVCYJ5tEhBFSQejrK2x/BM0R0K4bPBThfxGU7DyvppMNHzRJOo8aLrJgiEoTuaKvra6VHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402139; c=relaxed/simple;
	bh=Ky77N2KdzsWBfxScSvwkUfdeek9I1OOam0EonJYi0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOdUgmX0hCBPcHe0WLwpUCQHBSc6b1J+gJ0EwIcOOe/aY9XdKMcUV938M/6zVkys+rcnSqbd8cW6MGxNRsrPqJhXG5VdCHgpiBP1oZWbRJLoYNtom+PaV5J0assohPSixm3RkogLdRl1ajdWLJ2M5m3roIuHYsAtO7nNm3W4IIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLfk6r6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE73AC4CED0;
	Tue, 17 Dec 2024 02:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402139;
	bh=Ky77N2KdzsWBfxScSvwkUfdeek9I1OOam0EonJYi0RQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eLfk6r6jqQ/wT21qMM0X7zQyroP7+eaataR8c7xQ/+D0y10eDbhOkbxuOh+awmblO
	 ITR8PKGn+8XxUGRI6ye25JShMl9NJ+3KYo82ohmWBEye/V+e29q0iitgrceFLiKtrg
	 iuy+9upTlDyrmnsnZHat3Zq0CfYzNA121H4vYZI1jiOXJaXjvfN/Y8gJKZ1olSri/+
	 C+o2gQ0Olqk/OfBXMtOyBzO6SBBr7F+L23+uNhG5y2A/8VVDj3/5bH0LCNlbbaKKST
	 QKErF6vKGMgCTGu/BY4TJmK0eS6L9yeiGR3kCjmw47D8Rm7GuyKq8DVdkuwcWKyzbR
	 R+gU4AH8oX2yg==
Date: Mon, 16 Dec 2024 18:22:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Xiaoliang Yang
 <xiaoliang.yang_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/4] ethtool get_ts_stats() for DSA and ocelot
 driver
Message-ID: <20241216182218.5c66e075@kernel.org>
In-Reply-To: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
References: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 16:08:48 +0200 Vladimir Oltean wrote:
> After a recent patch set with fixes and general restructuring, Jakub asked for
> the Felix DSA driver to start reporting standardized statistics for hardware
> timestamping:
> https://lore.kernel.org/netdev/20241207180640.12da60ed@kernel.org/

Looks like we need a rebase.

