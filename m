Return-Path: <netdev+bounces-231181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38ABF6004
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88E89353A73
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DE2C026E;
	Tue, 21 Oct 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmaHQXZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CE2F3C36
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045702; cv=none; b=Fe4155lDzlZLuqyr7yT+OBMR/aYdfjwI6JDThS0N6DS/wROk3w23Jk32jZqj5jvWhbUNl7Sf2k35ul0+na8QjfReGWQHptrOkQtJycWwZVDGVFoG8oX6/qk10oAqwsp7I5ddBhi6yqJQWzZgaWefdgG6KEl2+iohGpwpe5S417E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045702; c=relaxed/simple;
	bh=VAArEVHHcYhpX4k6HMKyM0xWpgVkJtTFVZz+NeeWTsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq8yqMWLCQrXXVm94cwqOR1owaXczVyYZ2/DpA7KYlnFcXROFBwxDUpYFY0iK6t9JEBd3nPaPAonZSi77Ag3Zkln7jaz/8wXxjy8G5Lbsg05sjSAzz3ikcJobvMPf2QjunLJqgmjBwTTLR7O0Femlf4/v741G8ZS03XVK8AVsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmaHQXZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5223AC4CEF1;
	Tue, 21 Oct 2025 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761045702;
	bh=VAArEVHHcYhpX4k6HMKyM0xWpgVkJtTFVZz+NeeWTsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmaHQXZpcPybmgcdrsaYmVcc1b3eo3ccQDAHNDL6e/rluzhMtSQncMdTgqNeyN7D3
	 GqeueQUDZI+vm/YXCHzR3u6NWfbZGw0IEnc5hUosG4EkCNBb9Yb2F0BO65Ud0pDxB+
	 sTy2JFXNEMyQ7NNH94nd2aO6ZXcnGzuTopwCtS/0VQ6dXSezM4dED96h0f2rv91Ivf
	 6lMDsmOrYpF0Ho7sLCHUUwwMNE3SxMDpthifv5HsogRicgugA+PCSe5yuM8SpoxaYx
	 iSK5Yea8dJFuRKhTAYi8Drqqk/L/+4J9TSSkKFyk2F1dmhonxzi1wbu7eIe8WNBmcZ
	 r+iGVlnwfzTXw==
Date: Tue, 21 Oct 2025 12:21:38 +0100
From: Simon Horman <horms@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next] net: bonding: use workqueue to make sure peer
 notify updated
Message-ID: <aPdswnBumIsSq8fY@horms.kernel.org>
References: <20251021052249.47250-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021052249.47250-1-tonghao@bamaicloud.com>

On Tue, Oct 21, 2025 at 01:22:49PM +0800, Tonghao Zhang wrote:
> The RTNL might be locked, preventing ad_cond_set_peer_notif from acquiring
> the lock and updating send_peer_notif. This patch addresses the issue by
> using a workqueue. Since updating send_peer_notif does not require high
> real-time performance, such delayed updates are entirely acceptable.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
>  drivers/net/bonding/bond_3ad.c  |  7 ++-----
>  drivers/net/bonding/bond_main.c | 27 +++++++++++++++++++++++++++
>  include/net/bonding.h           |  2 ++
>  3 files changed, 31 insertions(+), 5 deletions(-)

This is not a proper review. So please wait, say a day, for one.

But this patch does not apply cleanly to net-next,
and thus will need to be rebased and reposted.

-- 
pw-bot: cr

