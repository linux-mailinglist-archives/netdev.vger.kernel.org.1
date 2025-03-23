Return-Path: <netdev+bounces-176946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C906A6CE45
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B2F3B0648
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E11FFC53;
	Sun, 23 Mar 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEhKP6Gb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163081E990D
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714381; cv=none; b=GGXQ+cmW9wcDLUsBqH19DRI12cQm4Eph0Nm0Scw5dipa3kwGxKxGPvXYCh3esgakVG+RosKz/dG9JpAw9nP30smakpMiUJP89ADSlo7tRllD8O6svvK/PLu7pXpcvhUYPKK/kWxP/QN+r8RgWq/FSxhzCzS3wq+Oa3zufIrDdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714381; c=relaxed/simple;
	bh=gQAfyPttVXntUtud3yIQYXlBGsUs73eCw26eQOKmrII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF/Vuk3Xceb5Xc6wbQ7+LoC9k9ESG24MmOUwUC/ErgIOPeZybV1HgkFHCU8uyEFhSU3+LJPAJizuP3h27AewbqdD0CACZrvJtBzoGffmNaxcs+sofsB5rjGQ/fQbHogDmnpUi2Dn1+/kz43Ps6VKkrcl16PJNDNoLC906IJY0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEhKP6Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C490C4CEE2;
	Sun, 23 Mar 2025 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742714379;
	bh=gQAfyPttVXntUtud3yIQYXlBGsUs73eCw26eQOKmrII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hEhKP6GbfhOSPo4Ely7KxSIuxE++7aIgjfLShgNMj8f8YE8kIwNRhHs+P1Ym6S/8J
	 vPECDTcLpblihZ3pcpoPVjyyVXM0MO18PMEnJbsAgi6bb9lZbR4ehxaGmAMtANG9iB
	 dL4m8zD0TMk/hbq5yadwCkj/rQ2dm54v1qP9MV6RDZX6M9qhpX6F38UKvSSSpRa6GX
	 tqA3gUDQ2ZOOEeIly0PiHPxkPGsN8gSU8ktN7cuqqlam00lpHiNTXRE5Ej92Z4kSPN
	 owSaa6ssy8ZzX+xMuxCKnc7b89y4m9ozOeOqajazTTuworgaZJsENlifU7j06II/3o
	 pU+/Fz62bLIhg==
Message-ID: <89f81b99-b505-48ad-b717-99e5d4d8e87b@kernel.org>
Date: Sun, 23 Mar 2025 09:19:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: Check return value to avoid a
 kernel oops
To: Benedikt Spranger <b.spranger@linutronix.de>, netdev@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250322143314.1806893-1-b.spranger@linutronix.de>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250322143314.1806893-1-b.spranger@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Did you actually get a kernel oops? If yes, which part of code produces the oops.

On 22/03/2025 16:33, Benedikt Spranger wrote:
> of_get_ethdev_address() may fail, do not set a MAC address and return

Even if it fails we do set a random MAC address and do not return error.
So above statement is false.


> an error. The icssg-prueth driver ignores that failure and try to validate
> the MAC address. This let to a NULL pointer dereference in this case.
> 
> Check the return value of of_get_ethdev_address() before validating the
> MAC address.

If of_get_ethdev_address() fails the netdev address will remain zero (as it was
zero initialized during allocation) so is_valid_ether_addr() will fail as well.

> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 2 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 9a75733e3f8f..273615c8923c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1152,7 +1152,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  
>  	/* get mac address from DT and set private and netdev addr */
>  	ret = of_get_ethdev_address(eth_node, ndev);
> -	if (!is_valid_ether_addr(ndev->dev_addr)) {
> +	if (ret || !is_valid_ether_addr(ndev->dev_addr)) {
>  		eth_hw_addr_random(ndev);
>  		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
>  			 port, ndev->dev_addr);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 64a19ff39562..61c5e10e7077 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -862,7 +862,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  
>  	/* get mac address from DT and set private and netdev addr */
>  	ret = of_get_ethdev_address(eth_node, ndev);
> -	if (!is_valid_ether_addr(ndev->dev_addr)) {
> +	if (ret || !is_valid_ether_addr(ndev->dev_addr)) {
>  		eth_hw_addr_random(ndev);
>  		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
>  			 port, ndev->dev_addr);

-- 
cheers,
-roger


