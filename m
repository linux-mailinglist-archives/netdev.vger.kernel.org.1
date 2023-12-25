Return-Path: <netdev+bounces-60207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C974E81E1C8
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C941C21010
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD652F80;
	Mon, 25 Dec 2023 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2YaEZ+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E852F6C
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E70C433C7;
	Mon, 25 Dec 2023 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703525841;
	bh=SuKfCw82FZtqhvV5Nmkeki0WU6Ek+Ag/mh7e+W5zbEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2YaEZ+/JKGhSPj87VigLxXeXU0LMj3CWNnR93RNg29vuKINkDhKJyo/1JbQAybVN
	 uPnwKQgCkal+2ev17d4cjgIFOf9XrYwWSMYJm7Nms8wJ3R5DTn8g2tQkUSvAXmPZmC
	 RmhA63f9f90UdA1JIJFqhkurejMc3PvlVGoIsfyjZFE0koJxce/H5daJ4V+W6yxeg0
	 jtHUHrMgFaus4lnPhlBesVKBrFDU79xdG2KTphNYOYVdERCHNBcLhPfuiyC/IrNkiq
	 zZ9tQx2r/pyrFWq4uqY2A/+jBrz+Cq313HHJA0Ztci3HCLLjIKyfErVSSu23vgz71T
	 VZzwqi1t3l6Yw==
Date: Mon, 25 Dec 2023 17:37:17 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 12/13] bnxt_en: Add support for ntuple
 filters added from ethtool.
Message-ID: <20231225173717.GK5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-13-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:09PM -0800, Michael Chan wrote:
> Add support for adding user defined ntuple TCP/UDP filters.  These
> filters are similar to aRFS filters except that they don't get aged.
> Source IP, destination IP, source port, or destination port can be
> unspecifed as wildcard.  At least one of these tuples must be specifed.
> If a tuple is specified, the full mask must be specified.
> 
> All ntuple related ethtool functions are now no longer compiled only
> for CONFIG_RFS_ACCEL.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c

...

> +static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
> +				    struct ethtool_rx_flow_spec *fs)
> +{
> +	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> +	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> +	struct bnxt_ntuple_filter *new_fltr, *fltr;
> +	struct bnxt_l2_filter *l2_fltr;
> +	u32 flow_type = fs->flow_type;
> +	struct flow_keys *fkeys;
> +	u32 idx;
> +	int rc;
> +
> +	if (!bp->vnic_info)
> +		return -EAGAIN;
> +
> +	if ((flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
> +		return -EOPNOTSUPP;
> +
> +	new_fltr = kzalloc(sizeof(*new_fltr), GFP_KERNEL);
> +	if (!new_fltr)
> +		return -ENOMEM;
> +
> +	l2_fltr = bp->vnic_info[0].l2_filters[0];
> +	atomic_inc(&l2_fltr->refcnt);
> +	new_fltr->l2_fltr = l2_fltr;
> +	fkeys = &new_fltr->fkeys;
> +
> +	rc = -EOPNOTSUPP;
> +	switch (flow_type) {
> +	case TCP_V4_FLOW:
> +	case UDP_V4_FLOW: {
> +		struct ethtool_tcpip4_spec *ip_spec = &fs->h_u.tcp_ip4_spec;
> +		struct ethtool_tcpip4_spec *ip_mask = &fs->m_u.tcp_ip4_spec;
> +
> +		fkeys->basic.ip_proto = IPPROTO_TCP;
> +		if (flow_type == UDP_V4_FLOW)
> +			fkeys->basic.ip_proto = IPPROTO_UDP;
> +		fkeys->basic.n_proto = htons(ETH_P_IP);
> +
> +		if (ip_mask->ip4src == IPV4_ALL_MASK) {
> +			fkeys->addrs.v4addrs.src = ip_spec->ip4src;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
> +		} else if (ip_mask->ip4src) {
> +			goto ntuple_err;
> +		}
> +		if (ip_mask->ip4dst == IPV4_ALL_MASK) {
> +			fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
> +		} else if (ip_mask->ip4dst) {
> +			goto ntuple_err;
> +		}
> +
> +		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
> +			fkeys->ports.src = ip_spec->psrc;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
> +		} else if (ip_mask->psrc) {
> +			goto ntuple_err;
> +		}
> +		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
> +			fkeys->ports.dst = ip_spec->pdst;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
> +		} else if (ip_mask->pdst) {
> +			goto ntuple_err;
> +		}
> +		break;
> +	}
> +	case TCP_V6_FLOW:
> +	case UDP_V6_FLOW: {
> +		struct ethtool_tcpip6_spec *ip_spec = &fs->h_u.tcp_ip6_spec;
> +		struct ethtool_tcpip6_spec *ip_mask = &fs->m_u.tcp_ip6_spec;
> +
> +		fkeys->basic.ip_proto = IPPROTO_TCP;
> +		if (flow_type == UDP_V6_FLOW)
> +			fkeys->basic.ip_proto = IPPROTO_UDP;
> +		fkeys->basic.n_proto = htons(ETH_P_IPV6);
> +
> +		if (ipv6_mask_is_full(ip_mask->ip6src)) {
> +			fkeys->addrs.v6addrs.src =
> +				*(struct in6_addr *)&ip_spec->ip6src;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
> +		} else if (!ipv6_mask_is_zero(ip_mask->ip6src)) {
> +			goto ntuple_err;
> +		}
> +		if (ipv6_mask_is_full(ip_mask->ip6dst)) {
> +			fkeys->addrs.v6addrs.dst =
> +				*(struct in6_addr *)&ip_spec->ip6dst;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
> +		} else if (!ipv6_mask_is_zero(ip_mask->ip6dst)) {
> +			goto ntuple_err;
> +		}
> +
> +		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
> +			fkeys->ports.src = ip_spec->psrc;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
> +		} else if (ip_mask->psrc) {
> +			goto ntuple_err;
> +		}
> +		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
> +			fkeys->ports.dst = ip_spec->pdst;
> +			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
> +		} else if (ip_mask->pdst) {
> +			goto ntuple_err;
> +		}
> +		break;
> +	}
> +	default:
> +		rc = -EOPNOTSUPP;
> +		goto ntuple_err;
> +	}
> +	if (!new_fltr->ntuple_flags)
> +		goto ntuple_err;
> +
> +	idx = bnxt_get_ntp_filter_idx(bp, fkeys, NULL);
> +	rcu_read_lock();
> +	fltr = bnxt_lookup_ntp_filter_from_idx(bp, new_fltr, idx);
> +	if (fltr) {
> +		rcu_read_unlock();
> +		rc = -EEXIST;
> +		goto ntuple_err;
> +	}
> +	rcu_read_unlock();
> +
> +	new_fltr->base.rxq = ring;
> +	new_fltr->base.flags = BNXT_ACT_NO_AGING;
> +	__set_bit(BNXT_FLTR_VALID, &new_fltr->base.state);
> +	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
> +	if (!rc) {
> +		rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp, new_fltr);
> +		if (rc) {
> +			bnxt_del_ntp_filter(bp, new_fltr);
> +			return rc;
> +		}
> +		fs->location = new_fltr->base.sw_id;
> +		return 0;
> +	}
> +

Hi Michael.

FWIIW, I think the following flow would be more idiomatic.
Although the asymmetry of the bnxt_del_ntp_filter() call
in one error path is still a bit awkward.

(Completely untested!)

	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
	if (rc)
		goto ntuple_err;

	rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp, new_fltr);
	if (rc) {
		bnxt_del_ntp_filter(bp, new_fltr);
		return rc;
	}

	fs->location = new_fltr->base.sw_id;
	return 0;

unlock_err:
	rcu_read_unlock();
> +ntuple_err:
> +	atomic_dec(&l2_fltr->refcnt);
> +	kfree(new_fltr);
> +	return rc;
> +}

...

