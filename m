Return-Path: <netdev+bounces-130090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824139882FA
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163A1284D88
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88248185E7A;
	Fri, 27 Sep 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujwwUHcm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601701741C6;
	Fri, 27 Sep 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434961; cv=none; b=eCMpTx1aNHgAabt3/548qBk+CTD/PRCipnKMIBW7Eb5oOzUHIHQsrNsF/0R4mElQBHvJC+HgOBoC7TGVTXHH3P1irMub1HCXJxoFTFM7Cd93zKAZO9mhYUHsUOzUCSvpwviebGMYV1HjZAKTN5oRKt+p3YNQiKz0WygVL6s64JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434961; c=relaxed/simple;
	bh=4UPUuX+Trl4Y6sfymx/iQndzU9LD0gq1bEPGXiBZtFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ZV7Uoci6fNUjJkDlhHM6ob8OvcE7Zt96v9dYHgVtCXBsI/wIzK+V5QIAJ+uOK3febH6lJIq84p7U+blukOXalh+RWC1WldzZTzGYs9w+BRH8oDSSjOcoXtn160S2n57Ou9/pmjZtsp9DX6E+l/W9XYsz6AnAPRnvTFJ+m7Dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujwwUHcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA56EC4CEC4;
	Fri, 27 Sep 2024 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727434961;
	bh=4UPUuX+Trl4Y6sfymx/iQndzU9LD0gq1bEPGXiBZtFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujwwUHcmPp97C/xhQjjwj/gz60+VNaaokKw8sZYPYQdyUINq5UXPPCHZ1r66xELKG
	 5zYbOOwUYsEb4AWdx1OPwsOOnDxuxbZjxvkwuSSDRa03ocAKuqNM1LqQrwSP+kq1AB
	 xTT82tILsrGbg2O1d3mB5xTDEzhHXzNG9roywwkZHTiRrxQcGRvG8LRDc5kdl0cLN8
	 UQaOzN8XNEXWy4K4+WhU1vjPzW0tFxybZBIdMjsEsS1RWCCDzVLQc0h56JgGluz2wL
	 yaraiSEoQMXGshQymdd1HHUDmIkNL9uYkHxT4Zc4hs4qx4IpvbaO3p13qgpkEGKx72
	 Yff/re53DwQEA==
Date: Fri, 27 Sep 2024 12:02:36 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240927110236.GK4029621@kernel.org>
References: <20240926160513.7252-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926160513.7252-1-kdipendra88@gmail.com>

+ Vladimir

On Thu, Sep 26, 2024 at 04:05:12PM +0000, Dipendra Khadka wrote:
> Add error pointer checks in bcm_sysport_map_queues() and
> bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().
> 
> Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> v5: 
>  -Removed extra parentheses
> v4: https://lore.kernel.org/all/20240925152927.4579-1-kdipendra88@gmail.com/
>  - Removed wrong and used correct Fixes: tag
> v3: https://lore.kernel.org/all/20240924185634.2358-1-kdipendra88@gmail.com/
>  - Updated patch subject
>  - Updated patch description
>  - Added Fixes: tags
>  - Fixed typo from PRT_ERR to PTR_ERR
>  - Error is checked just after  assignment
> v2: https://lore.kernel.org/all/20240923053900.1310-1-kdipendra88@gmail.com/
>  - Change the subject of the patch to net
> v1: https://lore.kernel.org/all/20240922181739.50056-1-kdipendra88@gmail.com/
>  drivers/net/ethernet/broadcom/bcmsysport.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index c9faa8540859..a7ad829f11d4 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
>  static int bcm_sysport_map_queues(struct net_device *dev,
>  				  struct net_device *slave_dev)
>  {
> -	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
>  	struct bcm_sysport_tx_ring *ring;
>  	unsigned int num_tx_queues;
>  	unsigned int q, qp, port;
> +	struct dsa_port *dp;
> +
> +	dp = dsa_port_from_netdev(slave_dev);
> +	if (IS_ERR(dp))
> +		return PTR_ERR(dp);
>  
>  	/* We can't be setting up queue inspection for non directly attached
>  	 * switches
> @@ -2386,11 +2390,15 @@ static int bcm_sysport_map_queues(struct net_device *dev,
>  static int bcm_sysport_unmap_queues(struct net_device *dev,
>  				    struct net_device *slave_dev)
>  {
> -	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
>  	struct bcm_sysport_tx_ring *ring;
>  	unsigned int num_tx_queues;
>  	unsigned int q, qp, port;
> +	struct dsa_port *dp;
> +
> +	dp = dsa_port_from_netdev(slave_dev);
> +	if (IS_ERR(dp))
> +		return PTR_ERR(dp);
>  
>  	port = dp->index;
>  
> -- 
> 2.43.0
> 

