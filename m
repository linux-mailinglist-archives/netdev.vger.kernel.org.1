Return-Path: <netdev+bounces-101561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FD8FF611
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A1E1C2155D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962E71748;
	Thu,  6 Jun 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKsmwPz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554814AECB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707004; cv=none; b=I36bg2DXUQZuvjhhJDMPPy6FAPnBw/g1aKNfmKHK0495WELTv9EENd3Ct5Ro4TbEICjDOsubNK2QPgGvRcRcB/oc1dHnTluyvUZnYy253gR46gHhywYKjP5YjcVD+GDCQUFl/SbirpmsCVN0+HtjSiNjpZBjmoH1N+vTV+bxwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707004; c=relaxed/simple;
	bh=kQj3ArTlwPWQzE3mxzZ9POQ8qxHK2BKS3RTaLBruKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsYEvXXWEJzvQboQu4b+vjACqRrQxM8YSzq2eWjViObTddd0y6H0/3tdRG2F5ew+yaWJRHWda1ta3Uu4lP890zPq/RAHRjYxshFF+iN1a3S5gNcT+PrdSa7xD0hWdhG6m9dqIVYfZdyHQ74D8yLUddvzKNwpZhln677f9mzMOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKsmwPz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06BBC2BD10;
	Thu,  6 Jun 2024 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717707003;
	bh=kQj3ArTlwPWQzE3mxzZ9POQ8qxHK2BKS3RTaLBruKW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKsmwPz8zfwUm9GnXVHMxw5buzRcbGPsw0sO/dN77nM33OKdSq9ioHRB661ZxIXul
	 vj67jWXzw2lDaSCvl+bkAHkMEP530/Tt7Z7qSwCA5kVb2TTmNzUxTLrntnGkhFo1Xk
	 fScD/nzx666fuEMXg//2TgA51QXZUfaktCe/cKN+B9oXM+qekcw73H98WDoSO/eWxF
	 nrNKhJeTtiN6gCICmAVg3feZ710KgyQ6rOrVWoOdVbNXLxOBIMcF7ABWj8ELmt5MAZ
	 S/BMXxZRAstzyTqrk3oEQJ3tQv3VyaLPkPyBw4uPGl0vdNPwh765CrDw5WqSYq09Zb
	 9tStzJ3TUT4IQ==
Date: Thu, 6 Jun 2024 21:49:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 2/3] net: txgbe: support Flow Director
 perfect filters
Message-ID: <20240606204959.GP791188@kernel.org>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com>
 <20240605020852.24144-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605020852.24144-3-jiawenwu@trustnetic.com>

On Wed, Jun 05, 2024 at 10:08:51AM +0800, Jiawen Wu wrote:
> Support the addition and deletion of Flow Director filters.
> 
> Supported fields: src-ip, dst-ip, src-port, dst-port
> Supported flow-types: tcp4, udp4, sctp4, ipv4
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

...

> +static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
> +					struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
> +	struct txgbe_fdir_filter *input;
> +	union txgbe_atr_input mask;
> +	struct wx *wx = txgbe->wx;
> +	u16 ptype = 0;
> +	u8 queue;
> +	int err;
> +
> +	if (!(test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
> +		return -EOPNOTSUPP;
> +
> +	/* ring_cookie is a masked into a set of queues and txgbe pools or
> +	 * we use drop index
> +	 */
> +	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
> +		queue = TXGBE_RDB_FDIR_DROP_QUEUE;
> +	} else {
> +		u32 ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> +
> +		if (ring >= wx->num_rx_queues)
> +			return -EINVAL;
> +
> +		/* Map the ring onto the absolute queue index */
> +		queue = wx->rx_ring[ring]->reg_idx;
> +	}
> +
> +	/* Don't allow indexes to exist outside of available space */
> +	if (fsp->location >= ((1024 << TXGBE_FDIR_PBALLOC_64K) - 2)) {
> +		wx_err(wx, "Location out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	input = kzalloc(sizeof(*input), GFP_ATOMIC);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	memset(&mask, 0, sizeof(union txgbe_atr_input));
> +
> +	/* set SW index */
> +	input->sw_idx = fsp->location;
> +
> +	/* record flow type */
> +	if (txgbe_flowspec_to_flow_type(fsp, &input->filter.formatted.flow_type)) {
> +		wx_err(wx, "Unrecognized flow type\n");
> +		goto err_out;
> +	}
> +
> +	mask.formatted.flow_type = TXGBE_ATR_L4TYPE_IPV6_MASK |
> +				   TXGBE_ATR_L4TYPE_MASK;
> +
> +	if (input->filter.formatted.flow_type == TXGBE_ATR_FLOW_TYPE_IPV4)
> +		mask.formatted.flow_type &= TXGBE_ATR_L4TYPE_IPV6_MASK;
> +
> +	/* Copy input into formatted structures */
> +	input->filter.formatted.src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
> +	mask.formatted.src_ip[0] = fsp->m_u.tcp_ip4_spec.ip4src;
> +	input->filter.formatted.dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
> +	mask.formatted.dst_ip[0] = fsp->m_u.tcp_ip4_spec.ip4dst;
> +	input->filter.formatted.src_port = fsp->h_u.tcp_ip4_spec.psrc;
> +	mask.formatted.src_port = fsp->m_u.tcp_ip4_spec.psrc;
> +	input->filter.formatted.dst_port = fsp->h_u.tcp_ip4_spec.pdst;
> +	mask.formatted.dst_port = fsp->m_u.tcp_ip4_spec.pdst;
> +
> +	if (fsp->flow_type & FLOW_EXT) {
> +		input->filter.formatted.vm_pool =
> +				(unsigned char)ntohl(fsp->h_ext.data[1]);
> +		mask.formatted.vm_pool =
> +				(unsigned char)ntohl(fsp->m_ext.data[1]);
> +		input->filter.formatted.flex_bytes =
> +						fsp->h_ext.vlan_etype;
> +		mask.formatted.flex_bytes = fsp->m_ext.vlan_etype;
> +	}
> +
> +	switch (input->filter.formatted.flow_type) {
> +	case TXGBE_ATR_FLOW_TYPE_TCPV4:
> +		ptype = WX_PTYPE_L2_IPV4_TCP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_UDPV4:
> +		ptype = WX_PTYPE_L2_IPV4_UDP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
> +		ptype = WX_PTYPE_L2_IPV4_SCTP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_IPV4:
> +		ptype = WX_PTYPE_L2_IPV4;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	input->filter.formatted.vlan_id = htons(ptype);
> +	if (mask.formatted.flow_type & TXGBE_ATR_L4TYPE_MASK)
> +		mask.formatted.vlan_id = htons(0xFFFF);
> +	else
> +		mask.formatted.vlan_id = htons(0xFFF8);
> +
> +	/* determine if we need to drop or route the packet */
> +	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
> +		input->action = TXGBE_RDB_FDIR_DROP_QUEUE;
> +	else
> +		input->action = fsp->ring_cookie;
> +
> +	spin_lock(&txgbe->fdir_perfect_lock);
> +
> +	if (hlist_empty(&txgbe->fdir_filter_list)) {
> +		/* save mask and program input mask into HW */
> +		memcpy(&txgbe->fdir_mask, &mask, sizeof(mask));
> +		err = txgbe_fdir_set_input_mask(wx, &mask);
> +		if (err)
> +			goto err_unlock;
> +	} else if (memcmp(&txgbe->fdir_mask, &mask, sizeof(mask))) {
> +		wx_err(wx, "Hardware only supports one mask per port. To change the mask you must first delete all the rules.\n");
> +		goto err_unlock;
> +	}
> +
> +	/* apply mask and compute/store hash */
> +	txgbe_atr_compute_perfect_hash(&input->filter, &mask);
> +
> +	/* check if new entry does not exist on filter list */
> +	if (txgbe_match_ethtool_fdir_entry(txgbe, input))
> +		goto err_unlock;
> +
> +	/* only program filters to hardware if the net device is running, as
> +	 * we store the filters in the Rx buffer which is not allocated when
> +	 * the device is down
> +	 */
> +	if (netif_running(wx->netdev)) {
> +		err = txgbe_fdir_write_perfect_filter(wx, &input->filter,
> +						      input->sw_idx, queue);
> +		if (err)
> +			goto err_unlock;
> +	}
> +
> +	txgbe_update_ethtool_fdir_entry(txgbe, input, input->sw_idx);
> +
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +
> +	return err;

Hi Jiawen Wu,

Smatch flags that err may be used uninitialised here.
I'm unsure if that can occur in practice, but perhaps it
would be nicer to simply return 0 here. 

> +err_unlock:
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +err_out:
> +	kfree(input);
> +	return -EINVAL;

And conversely, perhaps it would be nicer to return err here - ensuring is
it always set.  F.e. this would propagate the error code returned by
txgbe_fdir_write_perfect_filter().

> +}

...

