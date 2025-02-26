Return-Path: <netdev+bounces-170030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038CA46EC8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D4416DE0E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326C25E829;
	Wed, 26 Feb 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lI1al3X5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1625E81A;
	Wed, 26 Feb 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610340; cv=none; b=QPW4/5nCJiSxu9MvS4gpgMlD6HWZN+wmtTQ6ntBvNMhgJ+p2e3NNeNSrDhtyy3LTlsGFoFNJRx2M/gmCnYOsRKCipKRg4Z557G8RqnZv5bt94PQbDbdLpYeu5O+TiqGHnRWqn9JpJ8h5v/N9OFadPCKAP6jNuSNf8Of5qMNMMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610340; c=relaxed/simple;
	bh=c8pm/RLQcFzlThTF6jt2RIPrCFmAIpiK1XJK/Dy/Le0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhE7M3bIsL6aRC/APuR6JdoDBF8BsLZIX587rVypgNL495MtRIQSbN3pGFTInfGs56BjcGx3BiENZiV9/pbbNlnPMb+DXZs6XogLhfAlTefAidaLratFNuxdHPg10zOAjYRJnK5f0C0LJpK9TcLJj+TYI+xkoh/zZXubsVZTEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lI1al3X5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MkQ8uUHQ+uezvHICBEfyNTjs8v7ihKU40F0pUzTSAuA=; b=lI1al3X5MiKMt2ao5EstWg5YTb
	fKd0BT5389tq2N7O8iD/8kGfBWC52DX/SDEOWObN/PSVuJn+jy/ysmwFj9tD/ax8cXw+v5H+c3+p3
	S+oH2uTzJde1ele0RY2yUiqNjdf6OWqAl6yFLrIJtjGVuuso/9hgBw9xTKMaHZcQLKtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnQG1-000PBp-Ql; Wed, 26 Feb 2025 23:52:01 +0100
Date: Wed, 26 Feb 2025 23:52:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Message-ID: <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>

On Wed, Feb 26, 2025 at 02:44:12PM -0500, Mark Pearson wrote:
> Issue is seen on some Lenovo desktop workstations where there
> is a false IRP event which triggers a link flap.
> Condition is rare and only seen on networks where link speed
> may differ along the path between nodes (e.g 10M/100M)
> 
> Intel are not able to determine root cause but provided a
> workaround that does fix the issue. Tested extensively at Lenovo.
> 
> Adding a module option to enable this workaround for users
> who are impacted by this issue.

Why is a module option needed? Does the workaround itself introduce
issues? Please describe those issues?

In general, module options are not liked. So please include in the
commit message why a module option is the only option.
 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 286155efcedf..06774fb4b2dd 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -37,6 +37,10 @@ static int debug = -1;
>  module_param(debug, int, 0);
>  MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>  
> +static int false_irp_workaround;
> +module_param(false_irp_workaround, int, 0);
> +MODULE_PARM_DESC(false_irp_workaround, "Enable workaround for rare false IRP event causing link flap");
> +
>  static const struct e1000_info *e1000_info_tbl[] = {
>  	[board_82571]		= &e1000_82571_info,
>  	[board_82572]		= &e1000_82572_info,
> @@ -1757,6 +1761,21 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
>  	/* read ICR disables interrupts using IAM */
>  	if (icr & E1000_ICR_LSC) {
>  		hw->mac.get_link_status = true;
> +
> +		/*
> +		 * False IRP workaround
> +		 * Issue seen on Lenovo P5 and P7 workstations where if there
> +		 * are different link speeds in the network a false IRP event
> +		 * is received, leading to a link flap.
> +		 * Intel unable to determine root cause. This read prevents
> +		 * the issue occurring
> +		 */
> +		if (false_irp_workaround) {
> +			u16 phy_data;
> +
> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);

Please add some #define for these magic numbers, so we have some idea
what PHY register you are actually reading. That in itself might help
explain how the workaround actually works.

    Andrew

---
pw-bot: cr

