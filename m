Return-Path: <netdev+bounces-133259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A361599569C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B2C1F25C4A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A858212D0E;
	Tue,  8 Oct 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGs2Pmp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51211E1319;
	Tue,  8 Oct 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412397; cv=none; b=mkMuqkV4wvN/K8YAr1Lk7eGoNHGmQX2coCnDlqddO7NBin/9MJVfXrs60b8LWJ7xY5iy7OkNMQ42HtUW2KiLwlWtqn/sIdpBnsS8gOrTQb2HTwBVVnOluY+4ZwNzX7Y2VxiSI11ua9ldngzxdVa0oHYljpKPsjcPKTJPeZhj9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412397; c=relaxed/simple;
	bh=divFETgwfAY9iZU+jpEIBPKO18PS8DtSvhwWZozhADY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erio4vJhGpzArGm9fxcYSYz5n1WVAmFl+auHkLzMlk9DhufWFA7dXoC9tAZgVhCSe1TfraqZGjvWGRCukSeJBAXbMr90bXFSBYNbd3GpOv4h4l5R4KWxl8esD2OSHpY7Yr/ohbRQqjfZdIkANYzAQ7CbAyXO4WrieDx4ukyr7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGs2Pmp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F54BC4CEC7;
	Tue,  8 Oct 2024 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728412396;
	bh=divFETgwfAY9iZU+jpEIBPKO18PS8DtSvhwWZozhADY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGs2Pmp1zNXEcOqQH11MRWzUchWAhdAA2luF1Hys3QA3aR8uCLapK3CgeNcQ4B+3w
	 piySQDyQWfhccVesw4Lyxdr+93F2F8C4LCsqJ0vPhLakMlts+1LMKIgjr+950sowO0
	 zPWNaytrWFsj/212Fba/eYcA/V8KsMw7lDrIOFyxmjy+sVGdpBJQNXnuZqTwJnWKZ/
	 W7+aRp5OXnZiq2ha/ckYgD5Z8EwmxeK3NHbmVZK0scwMxKGFeWWm1cUSpGDJso608Z
	 Gwq9RBYFADWttfoCU0Fvm73PyzZ6vgGrXRjp1/uRuFPwK9MuHyE5vrt8eE1+x28I6D
	 tq4G25+AUOeMg==
Date: Tue, 8 Oct 2024 11:33:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for
 configuring tcp-data-split-thresh
Message-ID: <20241008113314.243f7c36@kernel.org>
In-Reply-To: <20241003160620.1521626-4-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-4-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 16:06:16 +0000 Taehee Yoo wrote:
> The tcp-data-split-thresh option configures the threshold value of
> the tcp-data-split.
> If a received packet size is larger than this threshold value, a packet
> will be split into header and payload.
> The header indicates TCP header, but it depends on driver spec.
> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> FW level, affecting TCP and UDP too.
> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> it affects UDP and TCP packets.
> 
> The tcp-data-split-thresh has a dependency, that is tcp-data-split
> option. This threshold value can be get/set only when tcp-data-split
> option is enabled.
> 
> Example:
>    # ethtool -G <interface name> tcp-data-split-thresh <value>
> 
>    # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    TCP data split thresh:  256
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    TCP data split thresh:  256
> 
> The tcp-data-split is not enabled, the tcp-data-split-thresh will
> not be used and can't be configured.
> 
>    # ethtool -G enp14s0f0np0 tcp-data-split off
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    TCP data split thresh:  256
>    Current hardware settings:
>    ...
>    TCP data split:         off
>    TCP data split thresh:  n/a

My reply to Sridhar was probably quite unclear on this point, but FWIW
I do also have a weak preference to drop the "TCP" from the new knob.
Rephrasing what I said here:
https://lore.kernel.org/all/20240911173150.571bf93b@kernel.org/
the old knob is defined as being about TCP but for the new one we can
pick how widely applicable it is (and make it cover UDP as well).

> The default/min/max values are not defined in the ethtool so the drivers
> should define themself.
> The 0 value means that all TCP and UDP packets' header and payload
> will be split.

> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 12f6dc567598..891f55b0f6aa 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -78,6 +78,8 @@ enum {
>   * @cqe_size: Size of TX/RX completion queue event
>   * @tx_push_buf_len: Size of TX push buffer
>   * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> + * @tcp_data_split_thresh: Threshold value of tcp-data-split
> + * @tcp_data_split_thresh_max: Maximum allowed threshold of tcp-data-split-threshold

Please wrap at 80 chars:

./scripts/checkpatch.pl --max-line-length=80 --strict $patch..

>  static int rings_fill_reply(struct sk_buff *skb,
> @@ -108,7 +110,13 @@ static int rings_fill_reply(struct sk_buff *skb,
>  	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
>  			  kr->tx_push_buf_max_len) ||
>  	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
> -			  kr->tx_push_buf_len))))
> +			  kr->tx_push_buf_len))) ||
> +	    (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&

Please add a new ETHTOOL_RING_USE_* flag for this, or fix all the
drivers which set ETHTOOL_RING_USE_TCP_DATA_SPLIT already and use that.
I don't think we should hide the value when HDS is disabled.

> +	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
> +			 kr->tcp_data_split_thresh))) ||

nit: unnecessary brackets around the nla_put_u32()

> +	    (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX,
> +			 kr->tcp_data_split_thresh_max))))
>  		return -EMSGSIZE;
>  
>  	return 0;

> +	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> +	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {

here you use the existing flag, yet gve and idpf set that flag and will
ignore the setting silently. They need to be changed or we need a new
flag.

> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +				    "setting tcp-data-split-thresh is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
>  	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
>  		NL_SET_ERR_MSG_ATTR(info->extack,
> @@ -196,9 +213,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>  	struct kernel_ethtool_ringparam kernel_ringparam = {};
>  	struct ethtool_ringparam ringparam = {};
>  	struct net_device *dev = req_info->dev;
> +	bool mod = false, thresh_mod = false;
>  	struct nlattr **tb = info->attrs;
>  	const struct nlattr *err_attr;
> -	bool mod = false;
>  	int ret;
>  
>  	dev->ethtool_ops->get_ringparam(dev, &ringparam,
> @@ -222,9 +239,30 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>  			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
>  	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
>  			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
> -	if (!mod)
> +	ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
> +			 tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +			 &thresh_mod);
> +	if (!mod && !thresh_mod)
>  		return 0;
>  
> +	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> +	    thresh_mod) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> +				    "tcp-data-split-thresh can not be updated while tcp-data-split is disabled");
> +		return -EINVAL;
> +	}

I'm not sure we need to reject changing the setting when HDS is
disabled. Driver can just store the value until HDS gets enabled?
WDYT? I don't have a strong preference.

> +	if (kernel_ringparam.tcp_data_split_thresh >
> +	    kernel_ringparam.tcp_data_split_thresh_max) {
> +		NL_SET_ERR_MSG_ATTR_FMT(info->extack,
> +					tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX],
> +					"Requested tcp-data-split-thresh exceeds the maximum of %u",

No need for the string, just NL_SET_BAD_ATTR() + ERANGE is enough

> +					kernel_ringparam.tcp_data_split_thresh_max);
> +
> +		return -EINVAL;

ERANGE

> +	}
> +
>  	/* ensure new ring parameters are within limits */
>  	if (ringparam.rx_pending > ringparam.rx_max_pending)
>  		err_attr = tb[ETHTOOL_A_RINGS_RX];


