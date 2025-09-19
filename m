Return-Path: <netdev+bounces-224866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B2B8B132
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 666B34E0EF5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3157261B8A;
	Fri, 19 Sep 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kY0n5sTO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09D1922FD
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309955; cv=none; b=HPLM9Sd9YeznVqUJYAI+6KU7dtU/y6P+XP2HKoLMVC4cInsUVSJ9s4mcGTdZQGDMGQulCIrKIyq8uOu5rhokUZQRzXjsnDhs7GVAAo3yy90rd8tQJN32V9EsCzkgYNYtxvi5dzC7h/c3nF8KFiOzdBnRS3Hwha/jAHft7li7sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309955; c=relaxed/simple;
	bh=vGa+2BHCQsUug1/7saGit6EFpL1XeOW7sckc2hXFXoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSSQJIEqJMlhEYDv7C8EmbonwNLIRBZXg8Fzh1/0ldgys0ddI+Z2apYui3xwtj0YQNb5nmtALc1f938OeJE5yQjKY3W/3KfYX/Ww3yXTfvJ/a5JM3NgyEvXV4FD9AfuiwLAredRn3vbvCvPXYx3HnPyARMVdCWpW8zlTplSoce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kY0n5sTO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZInlcN+DvGdNu745jzDdBoDzHWXTf1TLNjhV9Xf1J5g=; b=kY0n5sTOoIl0SuaUbZMDIH7SLl
	CQiQZdnev6o/unPfv+PsARTDIKbqgtpM18B22QiP4Dgf2sSv7wBWl3JS8DETjyCT77O/y6p4S3CVJ
	WlcngUO5odwOPQQjVRq7eEcIBhpbME1rdLUWnTCY2J5mkuZZLXTHUHfWfeBNLOu5HpxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzgjo-008yFy-R4; Fri, 19 Sep 2025 21:25:44 +0200
Date: Fri, 19 Sep 2025 21:25:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	gustavoars@kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
	kees@kernel.org, kernel-team@meta.com, lee@trager.us,
	linux@armlinux.org.uk, pabeni@redhat.com, sanman.p211993@gmail.com,
	suhui@nfschina.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Read module EEPROM
Message-ID: <a7184bd2-2203-465b-b544-4dbea0b9645b@lunn.ch>
References: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919191624.1239810-1-mohsin.bashr@gmail.com>

On Fri, Sep 19, 2025 at 12:16:24PM -0700, Mohsin Bashir wrote:
> Add support to read module EEPROM for fbnic. Towards this, add required
> support to issue a new command to the firmware and to receive the response
> to the corresponding command.
> 
> Create a local copy of the data in the completion struct before writing to
> ethtool_module_eeprom to avoid writing to data in case it is freed. Given
> that EEPROM pages are small, the overhead of additional copy is
> negligible.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
>  3 files changed, 223 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index b4ff98ee2051..f6069cddffa5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -1635,6 +1635,71 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
>  	}
>  }
>  
> +static int
> +fbnic_get_module_eeprom_by_page(struct net_device *netdev,
> +				const struct ethtool_module_eeprom *page_data,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_fw_completion *fw_cmpl;
> +	struct fbnic_dev *fbd = fbn->fbd;
> +	int err;
> +
> +	if (page_data->i2c_address != 0x50) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid i2c address. Only 0x50 is supported");
> +		return -EINVAL;
> +	}
> +
> +	if (page_data->bank != 0) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid bank. Only 0 is supported");
> +		return -EINVAL;
> +	}
> +
> +	fw_cmpl = __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,
> +					page_data->length);
> +	if (!fw_cmpl)
> +		return -ENOMEM;
> +
> +	/* Initialize completion and queue it for FW to process */
> +	fw_cmpl->u.qsfp.length = page_data->length;
> +	fw_cmpl->u.qsfp.offset = page_data->offset;
> +	fw_cmpl->u.qsfp.page = page_data->page;
> +	fw_cmpl->u.qsfp.bank = page_data->bank;
> +
> +	err = fbnic_fw_xmit_qsfp_read_msg(fbd, fw_cmpl, page_data->page,
> +					  page_data->bank, page_data->offset,
> +					  page_data->length);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Failed to transmit EEPROM read request");
> +		goto exit_free;
> +	}

At some point, you are going to hand off control of the I2C bus to
phylink, so it can drive the SFP. I know Alex at least had a plan how
that will work. At that point, will you just throw this away, and let
sfp_get_module_eeprom_by_page() implement this?

	Andrew

