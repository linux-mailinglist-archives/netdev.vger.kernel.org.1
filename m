Return-Path: <netdev+bounces-153119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1439F6D58
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A4F7A1CBA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D51FAC4B;
	Wed, 18 Dec 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1Q2fZr3r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB8156968
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546669; cv=none; b=G6Tu2T+VE/xifTO0dcwOHiklOVe5ii10sIOmKidynOnl2SBvo/glmcnauUAc7mgiIuWPVTpIMhGwc4frqE49RBLBNriQuwODdrOP9w9fmutH3JM8zKpxdGDsq8dSnRJtRHLOWScpNEV8c7ETg8xhxiirnoOx5ZGuutNaMDlzDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546669; c=relaxed/simple;
	bh=0IdzN+Rl5BkAJGcCkueS5gxI6fSxnlmKbxkcmOi0Y10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpKCcdkJcHLhnRxuTf6t8TBdZSxJR+E6T8rKwua3xUhtIvXWE5jskc9Q/NgXvP8rs429ulBKfa3uMDECQUqaT3lqR8wiXMupFh6SN8peN3LK1xVvTWTLAVHZLV5xbZKHv8MgZl8Az25kXAirdJ+CuXtRcEBAHqN2An3KPe0Flxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1Q2fZr3r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GpcYmlELp/Y+uOsekpEkHPdBziPffZ5earBfBWVp51M=; b=1Q2fZr3r+Sx0lRVt2woBFQ3mc7
	ObSon5cZir//QZ2a6kMOS7G6RmjXJ52gkSSkQefxVOE4arv1Gjn3HEA4QdlrDjulkdO2WcD+GYkTf
	RetwcPDuvp/tYKPcN/vbA/yYCgxnhCiliUFb+20sUKnj/M1asbhtqfYlDwozIQE1Xypg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNyp6-001MZE-20; Wed, 18 Dec 2024 19:31:04 +0100
Date: Wed, 18 Dec 2024 19:31:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v1 16/16] net-next/yunsilicon: Add change mtu
Message-ID: <c8ffef39-ce76-4028-b54f-7ec919a4620c@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105057.2237645-17-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218105057.2237645-17-tianx@yunsilicon.com>

> +static int xsc_eth_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	struct xsc_adapter *adapter = netdev_priv(netdev);
> +	int old_mtu = netdev->mtu;
> +	int ret = 0;
> +	int max_buf_len = 0;
> +
> +	if (new_mtu > netdev->max_mtu || new_mtu < netdev->min_mtu) {
> +		netdev_err(netdev, "%s: Bad MTU (%d), valid range is: [%d..%d]\n",
> +			   __func__, new_mtu, netdev->min_mtu, netdev->max_mtu);
> +		return -EINVAL;
> +	}

What checking does the core do for you, now that you have set max_mtu
and min_mtu?


    Andrew

---
pw-bot: cr

