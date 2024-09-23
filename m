Return-Path: <netdev+bounces-129341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B997EF10
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D87D1F22856
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFD19E993;
	Mon, 23 Sep 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhSY+zWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12817DA81;
	Mon, 23 Sep 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108387; cv=none; b=SFRghTWXmp/hCsQo7LPDKMKTU4lniftQcJ+M+3f26apcjGgh3Yaoc6D9b+dSe1bY68XTisrSRkR/yT4ngx3vAv4QINV+kEpOYAYPv7UsiSohr6yBkmlcgYXNcVNpAFGr6CuU3aUNuHAvJ7HexfDI5EDjgkgAsZVvurDzEPxzA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108387; c=relaxed/simple;
	bh=KsHqN5D+oGE/hbBqxBanh7VzDAEHHLPtse9cXR91jbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBjoZIm92gzOIgC3CnogGqBvdaVgNyzyaC+Or+ylsbm91vHCf5WOzORskr7EojK3/PMmBC65CVDc5OsexH8kGkY0h2vgTe6S1yao4C/Vq4Biam5dRNb76AdOQlaNKSNC9x7gtVGs1p8vN3ZKp5doAaT3BF1QGzrTPujcyORdnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhSY+zWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2874AC4CEC4;
	Mon, 23 Sep 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108387;
	bh=KsHqN5D+oGE/hbBqxBanh7VzDAEHHLPtse9cXR91jbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhSY+zWDQ6TtQ5Dv+JixbMwPUvaYLErzbQXmzbYMj30EcNC+rxKK197YhOzKcS5A0
	 Mbnu2N6TIa30w1ull439dt/kxk7k7m37UaI6f/kOO4eI+OxpyIgLt0kuPpLNAnD6ZH
	 ivNydHUC9fXrF01k/X22/Z+db4TxfFv9VFQRwUwezn5zb5Gd01gBzEO1XlHCCNhGz+
	 0xkOeGyL+yy99G0MZzrqAcmYP20H0q5jSzFqXFrYpye3ZbAN6YrmVdOe7dLug8/86m
	 tRr4/kcuyRor06lQv+gbOsnC+qFR1x4IPLwYmcUV2IryT/u2kWsaBwD6LT75k9lUZb
	 hCJLEqrDC20fw==
Date: Mon, 23 Sep 2024 17:19:42 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: andrew@lunn.ch, florian.fainelli@broadcom.com, davem@davemloft.net,
	edumazet@google.com, bcm-kernel-feedback-list@broadcom.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
Message-ID: <20240923161942.GK3426578@kernel.org>
References: <20240923053900.1310-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923053900.1310-1-kdipendra88@gmail.com>

On Mon, Sep 23, 2024 at 05:38:58AM +0000, Dipendra Khadka wrote:
> Add error pointer checks in bcm_sysport_map_queues() and
> bcm_sysport_unmap_queues() before deferencing 'dp'.

nit: dereferencing

     Flagged by checkpatch.pl --codespell

> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

This patch does not compile.
Please take care to make sure your paches compile.

And, moroever, please slow down a bit.  Please take some time to learn the
process by getting one patch accepted. Rather going through that process
with several patches simultaneously.

> ---
> v2: 
>   - Change the subject of the patch to net

I'm sorry to say that the subject is still not correct.

Looking over the git history for this file, I would go for
a prefix of 'net: systemport: '. I would also pass on mentioning
the filename in the subject. Maybe:

	Subject: [PATCH v3 net] net: systemport: correct error pointer handling

Also, I think that it would be better, although more verbose,
to update these functions so that the assignment of dp occurs
just before it is checked.

In the case of bcm_sysport_map_queues(), that would look something like this
(completely untested!):

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..7411f69a8806 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
 static int bcm_sysport_map_queues(struct net_device *dev,
 				  struct net_device *slave_dev)
 {
-	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	struct bcm_sysport_tx_ring *ring;
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
+	struct dsa_port *dp;
+
+	dp = dsa_port_from_netdev(slave_dev);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);

 
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches


This patch is now targeted at 'net'. Which means that you believe
it is a bug fix. I'd say that is reasonable, though it does seem to
be somewhat theoretical. But in any case, a bug fix should
have a Fixes tag, which describes the commit that added the bug.

Alternatively, if it is not a bug fix, then it should be targeted at
net-next (and not have a Fixes tag). Please note that net-next is currently
closed for the v6.12 merge window. It shold re-open after v6.12-rc1 has
been released, which I expect to occur about a week for now. You should
wait for net-next to re-open before posting non-RFC patches for it.

Lastly, when reposting patches, please note the 24h rule.
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested



