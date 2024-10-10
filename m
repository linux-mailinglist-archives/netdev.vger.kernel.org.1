Return-Path: <netdev+bounces-133985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB59979E3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F471F235C7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725CC153;
	Thu, 10 Oct 2024 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1t16P2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39C645;
	Thu, 10 Oct 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521778; cv=none; b=cz+kWRtmeenc+vJqFIHWKuP2Eosvf1eTGcM0uvbkCWMr/RaQW9W1LoGT+ij8/CT+mHKdM2zEn0rH07sfkL6Ph7zkP5sIUFu1+iCnBAfmeqKkZ726uid6llQ/NohL4BhcmrMmbOH2EDXH5s3hWKsqTDKTzcXb5Pi9+bV62JhP6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521778; c=relaxed/simple;
	bh=vPU8eDSK0RCvm9VfT+wiAdV9Sb3h9y1YygQuyN6AqDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZKM49dBx1fMV4G/A6hDaUso6LvUoi1e9/WFHqp20uKF39+to6DOvFy2nYFgbO14tX/4Eip1EarPPUykq8n6xrBfUveo/FGOhVADzg672vtCATaFdFY2+Vfj+sDJJhyAtcofBPGRSiqpwbx3JTwOTxbiE2MkUOOmwiEXPqSUDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1t16P2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D3C4CEC3;
	Thu, 10 Oct 2024 00:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521777;
	bh=vPU8eDSK0RCvm9VfT+wiAdV9Sb3h9y1YygQuyN6AqDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1t16P2MA6Hr8Bn/mfs4uV+l8jLpaTHD8QH/9pcQgADSpxZvMULix4ItesEngeZQm
	 45y8DHwjXoIWNdKBwPdn6rCzIMyN2VBbtCGbwxXnLK1+0oHPrGuv+KyVy33xWaTugF
	 jOYu32Ujw8ebIRIHKXxzms6apyq5jtOv1hkacJ5Q/h2d3pakz224ERQREqovr0Viyy
	 mfnK7qli3nYbD+gich6RdoWfpElrKAzj/VhD2wHD0xauGeF0QcUgRY7G+6DW+YSiLl
	 GpJW1FL548WRFEjEyqvApLD7cnJL2Z1AdF3R/osjd4jNYd0tg5AY700ObOAPZLl7fE
	 aKuiKdT30cHmQ==
Date: Wed, 9 Oct 2024 17:56:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: support reading SFP module info
Message-ID: <20241009175616.39594837@kernel.org>
In-Reply-To: <20241006215028.79486-1-lorenz@brun.one>
References: <20241006215028.79486-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Oct 2024 23:50:25 +0200 Lorenz Brun wrote:
> Add support for reading SFP module info and digital diagnostic
> monitoring data if supported by the module. The only Aquantia
> controller without an integrated PHY is the AQC100 which belongs to
> the B0 revision, that's why it's only implemented there.
> 
> The register information was extracted from a diagnostic tool made
> publicly available by Dell, but all code was written from scratch by me.
> 
> This has been tested to work with a variety of both optical and direct
> attach modules I had lying around and seems to work fine with all of
> them, including the diagnostics if supported by an optical module.
> All tests have been done with an AQC100 on an TL-NT521F card on firmware
> version 3.1.121 (current at the time of this patch).

> +static int aq_ethtool_get_module_info(struct net_device *ndev,
> +				      struct ethtool_modinfo *modinfo)
> +{
> +	int err;
> +	u8 compliance_val, dom_type;
> +	struct aq_nic_s *aq_nic = netdev_priv(ndev);

nit:
Could you reverse the order of variable declarations?
We prefer longest to shortest lines.

> +
> +	/* Module EEPROM is only supported for controllers with external PHY */
> +	if (aq_nic->aq_nic_cfg.aq_hw_caps->media_type != AQ_HW_MEDIA_TYPE_FIBRE)
> +		return -EOPNOTSUPP;
> +
> +	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +		return -EOPNOTSUPP;
> +
> +	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +		SFF_8472_ID_ADDR, SFF_8472_COMP_ADDR, 1, &compliance_val);
> +	if (err)
> +		return err;
> +
> +	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +		SFF_8472_ID_ADDR, SFF_8472_DOM_TYPE_ADDR, 1, &dom_type);
> +	if (err)
> +		return err;
> +
> +	if (dom_type & SFF_8472_ADDRESS_CHANGE_REQ_MASK || compliance_val == 0x00) {
> +		modinfo->type = ETH_MODULE_SFF_8079;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
> +	} else {
> +		modinfo->type = ETH_MODULE_SFF_8472;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
> +	}
> +	return 0;
> +}
> +
> +static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
> +					struct ethtool_eeprom *ee, unsigned char *data)
> +{
> +	int err;
> +	unsigned int first, last, len;
> +		struct aq_nic_s *aq_nic = netdev_priv(ndev);

nit: extra tab here

> +	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +		return -EOPNOTSUPP;
> +
> +	if (ee->len == 0)
> +		return -EINVAL;

I don't think core will let that happen, you can remove the check

> +	first = ee->offset;
> +	last = ee->offset + ee->len;
> +
> +	if (first < ETH_MODULE_SFF_8079_LEN) {
> +		len = min_t(unsigned int, last, ETH_MODULE_SFF_8079_LEN);

AFAIU pure min() may work these days

> +		len -= first;
> +
> +		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +			SFF_8472_ID_ADDR, first, len, data);
> +		if (err)
> +			return err;
> +
> +		first += len;
> +		data += len;
> +	}
> +	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
> +		len = min_t(unsigned int, last, ETH_MODULE_SFF_8472_LEN);
> +		len -= first;
> +		first -= ETH_MODULE_SFF_8079_LEN;
> +
> +		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +			SFF_8472_DIAGNOSTICS_ADDR, first, len, data);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  const struct ethtool_ops aq_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -1014,4 +1090,6 @@ const struct ethtool_ops aq_ethtool_ops = {
>  	.get_ts_info         = aq_ethtool_get_ts_info,
>  	.get_phy_tunable     = aq_ethtool_get_phy_tunable,
>  	.set_phy_tunable     = aq_ethtool_set_phy_tunable,
> +	.get_module_info     = aq_ethtool_get_module_info,
> +	.get_module_eeprom   = aq_ethtool_get_module_eeprom,
>  };

> +static int hw_atl_b0_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
> +					u8 reg_start_addr, int len, u8 *data)
> +{
> +	int err;
> +	int i, b;
> +	u32 val;
> +
> +	/* Wait for SMBUS0 to be idle */
> +	err = readx_poll_timeout_atomic(hw_atl_smb0_bus_busy_get, self,
> +					val, val == 0, 100U, 10000U);

Why atomic?
-- 
pw-bot: cr

