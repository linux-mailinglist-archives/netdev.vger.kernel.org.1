Return-Path: <netdev+bounces-248581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C793D0BDED
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7582F302F2EF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D027B32B;
	Fri,  9 Jan 2026 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rJqsQBbC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72816248F7C;
	Fri,  9 Jan 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983949; cv=none; b=RFPoSgKNTAkhRDgqw5GVrhUMSC4FOtgKEoITmJBMIrmX1Gh+SnpygAcEI3j0hLf+0fnMLooe4WS2Lz8ccEx5LU0BE2+L3D5JdQYB4fp5W8rAC7tK8y+LAu1Nco19b2bPMZWIusPvW4RK/L/aeBRE4neqaA3Hfr2KV3yqFfojQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983949; c=relaxed/simple;
	bh=cPO4diAb2ylZvj4Fxe6lPcoHU6Vbn1IqPnvOrmGZyvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szm9EMzUlWaZL16VB4+XhIday+oy2lW7OLJ2M7b5I036RKAwzkmocfRdfLePwwUywS+gk9Nc126RQqFieAIuyDbsHyTWIrIXbDGxqVD9R4+Cq8BCc9s9NDaMfeYUKNiZc1jz+NKoCl5vYKMLp6Gj0Zk3LoNid2If6Vc0J2u9ILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rJqsQBbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZCXDAuDOCp378JhVD35WgH8svl9GMtW1ja10qhCRbFI=; b=rJqsQBbCtykf4ltqZkqeCNHnOQ
	EbNT1y1pf0xNu215sHZl9qJrlpLP07ldUncfDShAShU4bjQH7j5PquFcjeru/hcBQmDBfs5z+YCOf
	K3cFpVoG6eZNOv5SvwQw2JFjM1/WoR0vYkGlIvSWIz46VKCcwX/MTNSt0qs8pmXsSQkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veHNi-0029dN-HQ; Fri, 09 Jan 2026 19:38:42 +0100
Date: Fri, 9 Jan 2026 19:38:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 08/15] net/nebula-matrix: add vsi, queue,
 adminq resource definitions and implementation
Message-ID: <2fc40495-2b72-43a9-ad98-7d58961877fe@lunn.ch>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
 <20260109100146.63569-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109100146.63569-9-illusion.wang@nebula-matrix.com>

> +static s32 nbl_res_aq_get_module_bitrate(struct nbl_resource_mgt *res_mgt,
> +					 u8 eth_id)
> +{
> +	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
> +	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
> +	u8 data[SFF_8472_SIGNALING_RATE_MAX + 1];
> +	u32 result;
> +	u8 br_nom;
> +	u8 br_max;
> +	u8 identifier;
> +	u8 encoding = 0;
> +	int port_max_rate;
> +	int ret;
> +
> +	if (res_mgt->resource_info->board_info.eth_speed ==
> +	    NBL_FW_PORT_SPEED_100G) {
> +		ret = nbl_res_aq_turn_module_eeprom_page(res_mgt, eth_id, 0);
> +		if (ret) {
> +			dev_err(dev,
> +				"eth %d get_module_eeprom_info failed %d\n",
> +				eth_info->logic_eth_id[eth_id], ret);
> +			return NBL_PORT_MAX_RATE_UNKNOWN;
> +		}
> +	}
> +
> +	ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0,
> +					   0, 0,
> +					   SFF_8472_SIGNALING_RATE_MAX + 1,
> +					   data);
> +	if (ret) {
> +		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
> +			eth_info->logic_eth_id[eth_id], ret);
> +		return NBL_PORT_MAX_RATE_UNKNOWN;
> +	}
> +
> +	if (res_mgt->resource_info->board_info.eth_speed ==
> +	    NBL_FW_PORT_SPEED_100G) {
> +		ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id,
> +						   I2C_DEV_ADDR_A0, 0, 0,
> +						   SFF_8636_VENDOR_ENCODING, 1,
> +						   &encoding);
> +		if (ret) {
> +			dev_err(dev,
> +				"eth %d get_module_eeprom_info failed %d\n",
> +				eth_info->logic_eth_id[eth_id], ret);
> +			return NBL_PORT_MAX_RATE_UNKNOWN;
> +		}
> +	}
> +
> +	br_nom = data[SFF_8472_SIGNALING_RATE];
> +	br_max = data[SFF_8472_SIGNALING_RATE_MAX];
> +	identifier = data[SFF_8472_IDENTIFIER];
> +
> +	/* sff-8472 section 5.6 */
> +	if (br_nom == 255)
> +		result = (u32)br_max * 250;
> +	else if (br_nom == 0)
> +		result = 0;
> +	else
> +		result = (u32)br_nom * 100;
> +
> +	switch (result / 1000) {
> +	case 25:
> +		port_max_rate = NBL_PORT_MAX_RATE_25G;
> +		break;
> +	case 10:
> +		port_max_rate = NBL_PORT_MAX_RATE_10G;
> +		break;
> +	case 1:
> +		port_max_rate = NBL_PORT_MAX_RATE_1G;
> +		break;
> +	default:
> +		port_max_rate = NBL_PORT_MAX_RATE_UNKNOWN;
> +		break;
> +	}
> +
> +	if (identifier == SFF_IDENTIFIER_QSFP28)
> +		port_max_rate = NBL_PORT_MAX_RATE_100G;
> +
> +	if (identifier == SFF_IDENTIFIER_PAM4 ||
> +	    encoding == SFF_8636_ENCODING_PAM4)
> +		port_max_rate = NBL_PORT_MAX_RATE_100G_PAM4;
> +
> +	return port_max_rate;
> +}

Please could you pull everything dealing with the SFP into a patch of
its own. We will want to review this code and think about if you
should be using phylink.

Do you also have a PCS which the driver is configuring? If so, please
make that a separate patch as well.

       Andrew

