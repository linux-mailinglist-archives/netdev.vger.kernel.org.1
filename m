Return-Path: <netdev+bounces-143584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8CA9C3222
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B89C1C2096F
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F4C13C;
	Sun, 10 Nov 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCThuYAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEC322B;
	Sun, 10 Nov 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731244734; cv=none; b=u/XBEyA/0+37hHsIX/Yz3Tb0nXcmmSMqMPAT5vRsQKnySahGerIcTeQ5D0CvsRTRIf2uuAdIXqcOTIo/cVgi2k20orgnZ25BEf5kS7c0Mzw/sAZE64hvY+jGpAgABJsGZCu+lavGc6Ax19/zYZGywkv4cKV0fO8IrWzMQiWfHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731244734; c=relaxed/simple;
	bh=tWRBXRMCUZlqEhKmLdxkBKOWGySKSFyZKYhKAr6Il+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnqiS4hRxTgFj6a0+g8kcz/zkzbgzNQRYsvDg8jyZ5z3SaBqJlRW1nrqe0VHXKn8ftvmokc6lTeuR7kMaG0lTjFZwpSpXBWH2lGbf5EkuXTlbKNJ4Hn2h4DLUB1U6Lrffm3lv0nqQyqf+8nPf4RTMYAtnu/Q9z2g5k7Zc8Mi2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCThuYAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34DFC4CECD;
	Sun, 10 Nov 2024 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731244734;
	bh=tWRBXRMCUZlqEhKmLdxkBKOWGySKSFyZKYhKAr6Il+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCThuYAitKJkVL1gpLHg+4rtjTn9sXvin2CQ6bp13N7e5hO9Ibdqn7+4oLKN6Iz/X
	 153JXAmUFDSOCnZG91nurxOihqo7RdR33vgKH/dnSFEvT4Vge7bW+5OPsxEnYCD6nV
	 qRUosUyouqu31hXhuy2p7MspsyRjIKv4KpnfyfhniImVlK9EivDBCfs87larYFyo7/
	 /OtSIAuW+qKT9MLJPh6sAZ/5zASR1MK95DVZsVDdkW4Vb8VSip8gXjD3BdxESrAURP
	 y3uNzcT/3308OB5i1iN2ucJWaZiUi9HZZ19Uk6nBI6kB+Mi1DN5nHlqkLwgsp0K6Hy
	 oJBKlutBgvbmw==
Date: Sun, 10 Nov 2024 13:18:46 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	sedara@marvell.com, vimleshk@marvell.com, thaller@redhat.com,
	wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
	konguyen@redhat.com, frank.feng@synaxg.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] octeon_ep: add ndo ops for VFs in PF driver
Message-ID: <20241110131846.GL4507@kernel.org>
References: <20241107121637.1117089-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107121637.1117089-1-srasheed@marvell.com>

On Thu, Nov 07, 2024 at 04:16:37AM -0800, Shinas Rasheed wrote:
> These APIs are needed to support applicaitons that use netlink to get VF
> information from a PF driver.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

...

> +static int octep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan, u8 qos, __be16 vlan_proto)
> +{
> +	struct octep_device *oct = netdev_priv(dev);
> +
> +	dev_err(&oct->pdev->dev, "Setting VF VLAN not supported\n");
> +	return 0;
> +}

Hi Shinas,

Given that the operation is not supported I think it would
be more appropriate to return -EOPNOTSUPP. And moreover, given
that this is a noop, I think it would be yet more appropriate
not to implement it at all and let the core treat it as not supported.

Likewise for other NDOs implemented as noops in this patch.

...

