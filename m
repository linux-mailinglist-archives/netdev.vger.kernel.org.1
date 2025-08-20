Return-Path: <netdev+bounces-215401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800AEB2E6C8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D31C86BB8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82C2D5A16;
	Wed, 20 Aug 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kMZNlXQ8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57092275AF5;
	Wed, 20 Aug 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722600; cv=none; b=PzApWpoFUzdTQX2PONUG3hK/WfBdkKXCnProwKWY5tvW9o6MXlrAGJudoCRFOeEkQOHPAjhDLdhVTxrAFj/BGv9Lvf7GvpvE6T69glesjfjLB9frapoW6Y+nJC1McO06swa6tKwaAOz+JP10WydE6yMJghUahM0vxoUzIGMTOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722600; c=relaxed/simple;
	bh=wpXZ7WzQnS9IVDrr/uRi+CTlb5wL/J3rEvHyGptDAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHyjKyzUHj2JAANnOtOFjXxiHwFvAhcy7Jrg68/96O2gEmWDkFxei9Ruk8NoWsr8ymqRvhriwX6kj9KwPDUqdmlZqBSJtF9pd0No4B50U0z57Lytf6DhCCCg5IAi5wygtAXDmIxnavow38dX6b+QFsAYPD6TajcAP678GqtjOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kMZNlXQ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MJbTBSkgGlQ/leyrGxDdC6kh8e9e8NNR7n5dt+jAZO4=; b=kMZNlXQ8CPUgGREnoN7Af6ozHU
	ylpsbSvsHhbkIz3628p/KnVlk2Ygmpefmgxsb1Mk/+5AAi0v5HFTcI5GwoZObYTE74C139uYO7m2s
	oH6bH85XJMO2pTxf33pTwCi4BnqgXS55cuJDGKegwUKicr9Vo+qh/nh9CKspnA84+Ccc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uopdv-005Mix-6n; Wed, 20 Aug 2025 22:42:47 +0200
Date: Wed, 20 Aug 2025 22:42:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] net: rnpgbe: Add register_netdev
Message-ID: <c37ee9e7-53de-4c21-b0cb-4cfb0936bc1e@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-6-dong100@mucse.com>

> +static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> +				    u8 *mac_addr)
> +{
> +	struct device *dev = &hw->pdev->dev;
> +
> +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port) ||
> +	    !is_valid_ether_addr(mac_addr)) {
> +		dev_err(dev, "Failed to get valid MAC from FW\n");
> +		return -EINVAL;

I _think_ mucse_fw_get_macaddr() can return -EINTR, because deep down,
it has a call to mutex_lock_interruptible(). If that happens, you
should not return iEINVAL, it is not an invalid value, its just an
interrupted system call.

This is what i'm talking about needing careful review...

    Andrew

---
pw-bot: cr

