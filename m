Return-Path: <netdev+bounces-153204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0B9F72B9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80D01890BE6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB986359;
	Thu, 19 Dec 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpQhuxCt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E286353;
	Thu, 19 Dec 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575750; cv=none; b=PE/D67xv7npMHatMN09qYkoxxKKW1rrUjwsxLTu1dMHTp5c8Abq72gz+2u48pvqDEAvGX3/8I7LQxw4OwsQaevarhSSK+Kkku/Pe6sMRApczxkXeg3n/h2Tvy4UszQ1ibpaWgTJwYlAliI1QNOMiFtKdDdbt0oJE5qOF8Afto6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575750; c=relaxed/simple;
	bh=4iFleLifyr173w2o35qfDhgP3wlvMCAXlkU6XKW/cEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCZ7xIQ574tt6U8xFdYX3dnF4GqfNdzSIJUFSgCSUjzf5WvQSuSGQEDAqqyK6boIGJkYJA6tT0FTEYhNGSME/DOt6JiMhoOCzw0r2ejTs0iS+5x6BkTF7PXHEfo56RznVuLlelym80jgPYb88llgExES8pICGbL6KjITnIeJjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpQhuxCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C2C4CECD;
	Thu, 19 Dec 2024 02:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734575750;
	bh=4iFleLifyr173w2o35qfDhgP3wlvMCAXlkU6XKW/cEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PpQhuxCt57B9CMW4Jk9DiFzL2+WLtsUJScMni4D3xVcCFmNK2CvkXY9b1lqDrhJ7F
	 xYtY1tTczBVIUVH8glYF2jmzSzf8O7bNL+DTOcpv8cQozl23tJyb5vx5r9hzwUorvx
	 Kguo1v8hdj6iNWu8GjQ1CArS0skvzAwy8aflAZvVhn9lvirVNl2zOKVSdykNO1X4UI
	 Q2QFRKGlRuSsth5oEbwyyOhHUIRFpKnmi6WONWVWj1uYy65BJ/llgaLdXihdiHVtmk
	 DucmE05BylBWwbXsrMHqW3Dw+hkMV/pJennIN+j8tLit6Ap3to80q4OJeNbmxrh+MO
	 dEuNTsgbNJx3A==
Date: Wed, 18 Dec 2024 18:35:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 4/9] net: ethtool: add support for
 configuring hds-thresh
Message-ID: <20241218183547.45273b87@kernel.org>
In-Reply-To: <20241218144530.2963326-5-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-5-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:25 +0000 Taehee Yoo wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 4e451084d58a..4f407ce9eed1 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -78,6 +78,8 @@ enum {
>   * @cqe_size: Size of TX/RX completion queue event
>   * @tx_push_buf_len: Size of TX push buffer
>   * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> + * @hds_thresh: Threshold value of header-data-split-thresh
> + * @hds_thresh_max: Maximum allowed threshold of header-data-split-thresh

nit: s/allowed/supported/

> +u8 dev_xdp_sb_prog_count(struct net_device *dev)
> +{
> +	u8 count = 0;
> +	int i;
> +
> +	for (i = 0; i < __MAX_XDP_MODE; i++)
> +		if (dev->xdp_state[i].prog &&
> +		    !dev->xdp_state[i].prog->aux->xdp_has_frags)
> +			count++;
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(dev_xdp_sb_prog_count);

No need to export this, AFAICT, none of the callers can be built 
as a module.

> +	hds_config_mod = old_hds_config != kernel_ringparam.tcp_data_split;

Does it really matter if we modified the HDS setting for the XDP check?
Whether it was already set or the current config is asking for it to be
set having XDP SB and HDS is invalid, we can return an error.

> +	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    hds_config_mod && dev_xdp_sb_prog_count(dev)) {
> +		NL_SET_ERR_MSG(info->extack,

		NL_SET_ERR_MSG_ATTR(info->extack,
				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
				    ...

> +			       "tcp-data-split can not be enabled with single buffer XDP");
> +		return -EINVAL;
> +	}
> +
> +	if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max) {
> +		NL_SET_BAD_ATTR(info->extack,
> +				tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX]);
> +		return -ERANGE;
> +	}

Can this condition not be handled by the big if "ladder" below?
I mean like this:

@@ -282,6 +276,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
                err_attr = tb[ETHTOOL_A_RINGS_RX_JUMBO];
        else if (ringparam.tx_pending > ringparam.tx_max_pending)
                err_attr = tb[ETHTOOL_A_RINGS_TX];
+       else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
+               err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX];
        else
                err_attr = NULL;
        if (err_attr) {

>  	/* ensure new ring parameters are within limits */
>  	if (ringparam.rx_pending > ringparam.rx_max_pending)
>  		err_attr = tb[ETHTOOL_A_RINGS_RX];

