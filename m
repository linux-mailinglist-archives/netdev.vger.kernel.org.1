Return-Path: <netdev+bounces-206322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FEAB02A6E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D356571D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C026B773;
	Sat, 12 Jul 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Du5zq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3310F9
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752316026; cv=none; b=iY788hGM1amyKQXOFMHMqC8KQH2oU98VivA3pkIzzaKKg49tiQDpr50DcfY+BcLQFwM4mHIlsAHWXDXAx+l7BeRr66X5Fmk5hfHpVuuqL49mZMvzz6IONf0JwHIJvVoa08sPXEX8mgVsR66iPwXK4vVeIBa1Wdo0yKffqklAlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752316026; c=relaxed/simple;
	bh=hUNoQmkupIb7aIZkr2oSCszVyneAWY3sJHAxxnZP7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFQOeTw+fyV6xqxNEpyQVCJc5pAgRUy6IMXkVSp1ljxY6Ewz0jkVeb4xI1HlWQLfyokMrbh0wPuKrMH/4XZwCaCM4PfELU/3yw2TvstvQvtwqmcsnWp1JDQiWnHw5ipHqRlZmLozlDjygVU3QB4520DjAA7V9EFQ/utZQiaXVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Du5zq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6998EC4CEEF;
	Sat, 12 Jul 2025 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752316026;
	bh=hUNoQmkupIb7aIZkr2oSCszVyneAWY3sJHAxxnZP7ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2Du5zq8FL+unm2xXO7hG6ukfL9xTIQE7VRmEW8ZoP0b3rqW4yNsbNpm+Kao9/sdk
	 AbMMhLa5k/dGj8Wa3zKovMj8DHIrC3Qp3OkU//PF7vNnyuXxgB/G4AnjDMtrRPABcU
	 v9foxF8bUORSqXZz5cbne67WlYFmo8PTjsEhe0sn2vYXtQxVIVj4JU8HKvBKeS6Xdp
	 Rkf2PmIRMWeodfneSu6UH/CUXN46yph3PDEwD5i8C475qE2YAkssMUkeuvV6Of1AOP
	 VOum5jdaphoi6ACQTVNoUVPyqYPCzCbdf8pbu/bSM+oN0IGlkc1W0Cuba6vl1mNHLz
	 CECh3ivJdSn4A==
Date: Sat, 12 Jul 2025 11:27:02 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] dev: Pass netdevice_tracker to
 dev_get_by_flags_rcu().
Message-ID: <20250712102702.GW721198@horms.kernel.org>
References: <20250711051120.2866855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711051120.2866855-1-kuniyu@google.com>

On Fri, Jul 11, 2025 at 05:10:59AM +0000, Kuniyuki Iwashima wrote:
> This is a follow-up for commit eb1ac9ff6c4a5 ("ipv6: anycast: Don't
> hold RTNL for IPV6_JOIN_ANYCAST.").
> 
> We should not add a new device lookup API without netdevice_tracker.
> 
> Let's pass netdevice_tracker to dev_get_by_flags_rcu() and rename it
> with netdev_ prefix to match other newer APIs.
> 
> Note that we always use GFP_ATOMIC for netdev_hold() as it's expected
> to be called under RCU.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20250708184053.102109f6@kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2:
>   * Use netdev_tracker for other places ipv6_sock_ac_join()
>   * Fix func name for EXPORT_IPV6_MOD()
>   * Update kdoc
> 
> v1: https://lore.kernel.org/netdev/20250709190144.659194-1-kuniyu@google.com/

Reviewed-by: Simon Horman <horms@kernel.org>


