Return-Path: <netdev+bounces-190581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878BAB7AF2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E3A863979
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4624C68D;
	Thu, 15 May 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TqrC6tHx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB58C1F;
	Thu, 15 May 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747272230; cv=none; b=sEFsBHwsN2zgId4VyDjwdQEM1/GuQKngVhpiIrWJwn18W4X0BP/2Pj2bQ5KkOu3qTw6CZGtY4b7eNryFCOrCySzvBWNLIwX+6fqf5Xo+nLX1xmFHtb8CvTkRLw9VRlgd8L+zmC5h7/PdIqNVcuzdib9K6IKm0i+d3xHiER9LfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747272230; c=relaxed/simple;
	bh=bSX8ZwcZSPjmpOO3el/q+Vf6RN/k/v0gYzWUjl+oSPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMPP8qSAYgbMjI7ONoYTXvQ2sskACAsXKh6la4msM/WjYnIo1CTmbc4Lt23WRR+CkiVA4i5drzcvHTzDxqCrw6vHes9kx+i6nFot/8LqL2cV/EtPU4u6ulG7vm8jM774oVVjLuI3QqgvQBPcClEgfCpNLIbTeXVb7eHKWQ2+lzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TqrC6tHx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZNEVePrYcEKpGjmy4ptaEK0bCgRenH9d4U+STgUBLp8=; b=TqrC6tHx2nDhX1MPJu5HfQDFFF
	7iqxY6YE+cP/esAGf7veHNXV1UqPnK7nme2FRbF2NuoIM2IJw58Wj7bkVswUBcQrkVJntiDzFCHdt
	tu1FC0gCzbV4WHr4o5HNEWiaqNxr5IwE+rAp/swFVcVA9BuGHRag39g70xUNxAlv4Grs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFNJz-00CcSc-Nn; Thu, 15 May 2025 03:23:39 +0200
Date: Thu, 15 May 2025 03:23:39 +0200
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
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 2/2] ice: add qsfp
 transceiver reset, interrupt and presence pin control
Message-ID: <200f7d11-50c2-4ee2-a80b-15341fbbd5f4@lunn.ch>
References: <6f127b5b-77c6-4bd4-8124-8eea6a12ca61@lunn.ch>
 <20250513224017.202236-1-mpazdan@arista.com>
 <20250513224017.202236-2-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513224017.202236-2-mpazdan@arista.com>

> + * ice_get_module_mgmt_signal - get module management signal status
> + * @dev: network interface device structure
> + * @params: ethtool module management signal params
> + * @extack: extended ACK from the Netlink message
> + *
> + * Returns -EIO if AQ command for GPIO get failed, otherwise
> + * returns 0 and current status of requested signal in params.
> + */
> +static int
> +ice_get_module_mgmt_signal(struct net_device *dev,
> +			   struct ethtool_module_mgmt_params *params,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct ice_netdev_priv *np = netdev_priv(dev);
> +	struct ice_pf *pf = np->vsi->back;
> +	struct ice_hw *hw = &pf->hw;
> +	u16 gpio_handle = 0; /* SOC/on-chip GPIO */
> +	bool value;
> +	int ret = 0;
> +
> +	if (hw->has_module_mgmt_gpio) {
> +		switch (params->type) {
> +		case ETHTOOL_MODULE_MGMT_RESET:
> +			ret = ice_aq_get_gpio(hw, gpio_handle,
> +					      ICE_MGMT_PIN_RESET, &value, NULL);
> +			break;

Reset, i can kind of understand being used this way.

> +		case ETHTOOL_MODULE_MGMT_INT:
> +			ret = ice_aq_get_gpio(hw, gpio_handle,
> +					      ICE_MGMT_PIN_INT, &value, NULL);
> +			break;
> +		case ETHTOOL_MODULE_MGMT_PRESENT:
> +			ret = ice_aq_get_gpio(hw, gpio_handle,
> +					      ICE_MGMT_PIN_PRESENT, &value, NULL);
> +			break;

but not these two. These represent events. I've not looked at the
datasheet... Does the GPIO controller support interrupts? For PRESENT
you are interested in the edges, maybe with some debounce logic. For
INT, i _guess_ it is active low? But i've no idea what user space is
going to actually do on an interrupt, and how is it going to clear the
interrupt? This smells like a user space driver, which is not
something we want. Even if there is a legitimate use case, which there
might be for PRESENT, polling does not make much sense when the kernel
can broadcast a netlink message to user space if the GPIO controller
has interrupt support.

    Andrew

---
pw-bot: cr

