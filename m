Return-Path: <netdev+bounces-190580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA6AB7ADA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD494C7DAA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAE26989D;
	Thu, 15 May 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nE+5GleE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8A269880;
	Thu, 15 May 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747271439; cv=none; b=dF7Qp21hETz+aOH/gfXymCjeqFSnqNfBbUvNMdAr+f9qP87AoP3ZvV/aDK3QIrLVe5kN1IgxW0rc7GwL+g27AsD/bn0yqGSMzH+Dsx1FSUEZSBI9YldrGtAtsWXaP/uXcpkqHlWkKHOGWPMQT7e3X9EeZ3CtJAUvlJrttVkRzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747271439; c=relaxed/simple;
	bh=EA/SS/an8re5rk6oROj81WcuCzN+FTfX/QGAoBvCtTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS3QTS31vw4FvLj2Rqx2Rk0nuC8JDR5Jd6RVX4nnFwOZhtbExiuApJhzIh1roWosMkHtkvO76wQJ/+jm/2aFJp/+IeIeLwRUkF4iKiiClguA+H/d5I/SfWdBFiHDgEQu9bhrFDJLcUedzyUaxOaFLnfB91cVGq8ON93dYDJXeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nE+5GleE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rgze/gk20gcMc5t1HLHy2uBvblNz3B5eJhJy+7TrjeQ=; b=nE+5GleEusC4oX5Y2MkFdKdCYH
	/EM4+ydrgWChVXHmg84vCY1rG6uY25n6p53c+IhIq0E2Or94kZ45GNvQIkXBPg2ne4YpXZBE/uyhk
	U61rEsohwGSEmsuBqA3UDukS/G9q/AzG7qwbBn7SScTFm8yWGSwrqumNVArLs//GCbok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFN7A-00CcQf-1f; Thu, 15 May 2025 03:10:24 +0200
Date: Thu, 15 May 2025 03:10:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: aleksander.lobakin@intel.com, almasrymina@google.com,
	andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com, davem@davemloft.net, ecree.xilinx@gmail.com,
	edumazet@google.com, gal@nvidia.com, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, jianbol@nvidia.com,
	kory.maincent@bootlin.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/2] ethtool: qsfp transceiver reset,
 interrupt and presence pin control
Message-ID: <c6c33e70-267f-4433-95ca-93efca0dfbe8@lunn.ch>
References: <6f127b5b-77c6-4bd4-8124-8eea6a12ca61@lunn.ch>
 <20250513224017.202236-1-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513224017.202236-1-mpazdan@arista.com>

On Tue, May 13, 2025 at 10:40:00PM +0000, Marek Pazdan wrote:
> Common Management Interface Specification defines
> Management Signaling Layer (MSL) control and status signals. This change
> provides API for following signals status reading:
> - signal allowing the host to request module reset (Reset)
> - signal allowing the host to detect module presence (Presence)
> - signal allowing the host to detect module interrupt (Int)

What is missing from here is the use cases you are trying to
address. Why should user space want to reset the module? Why does user
spare care if there is a module inserted or not. What is user space
going to do with an interrupt?

> Additionally API allows for Reset signal assertion with
> following constraints:
> - reset cannot be asserted if firmware update is in progress
> - if reset is asserted, firmware update cannot be started
> - if reset is asserted, power mode cannot be get/set
> In all above constraint cases -EBUSY error is returned.

Seems like there should be one more condition. Reset cannot be
asserted if the interface is admin up. I assume a reset is disruptive
to the link, so you don't want it to happen when the link is in use.

> +static int module_mgmt_get(struct net_device *dev,
> +			   struct module_mgmt_reply_data *data,
> +			   const struct genl_info *info)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct netlink_ext_ack *extack = info ? info->extack : NULL;
> +
> +	if (!ops->get_module_mgmt_signal)
> +		return -EOPNOTSUPP;
> +
> +	return ops->get_module_mgmt_signal(dev, &data->mgmt, extack);

Should there be a module_busy() check here? Can you get these
parameters if the module is in reset?

	Andrew

