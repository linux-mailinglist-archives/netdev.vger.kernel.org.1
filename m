Return-Path: <netdev+bounces-37669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F57B68DC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A24611C203DE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6222F0A;
	Tue,  3 Oct 2023 12:20:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4F21A0F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 12:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04EC433C8;
	Tue,  3 Oct 2023 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696335640;
	bh=2/EQPHqoeRCb33z8dC4Q13xkMmAn+fpq36Al/bM6Fg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFR1r4HZNX+bbs2I4rWgnV/lnFuHk1VZy/30BGPYy9KccefNarh9Rtu8vbOoRmGlP
	 mEqQUfmDPpOb+K8UBQpLlXGZWTh/i+7+f9X8kEPdGK96hj8G/p3wCXKxpqiVAjOY/K
	 WfQzW6py6HBcTZK0Ms//Py+SXqZif++sX1GQ8qgTwTM5rGjoi5oNGLfZKR83gqwKtM
	 2doH0MZz7BQNKotgDNJWITmI/LeoAjEpV/AqeDNz2oZL9xguC/M9U6fMJDuEqr9TRM
	 wtqCCNueqXlEJnv4w8VjNct0Z3uX3hIg6vBuDqp3sFJ4YkglLPPGVtBw9LFOTJK/Kh
	 O6qtTHDVKCmtA==
Date: Tue, 3 Oct 2023 14:20:35 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, pieter.jansen-van-vuuren@amd.com
Subject: Re: [PATCH net-next 1/4] sfc: support TC left-hand-side rules on
 foreign netdevs
Message-ID: <ZRwHE0WiPCYle20r@kernel.org>
References: <cover.1696261222.git.ecree.xilinx@gmail.com>
 <890f07cf815ae31e7cd5b37cafb72801791f1c75.1696261222.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890f07cf815ae31e7cd5b37cafb72801791f1c75.1696261222.git.ecree.xilinx@gmail.com>

On Mon, Oct 02, 2023 at 04:44:41PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Allow a tunnel netdevice (such as a vxlan) to offload conntrack lookups,
>  in much the same way as efx netdevs.
> To ensure this rule does not overlap with other tunnel rules on the same
>  sip,dip,dport tuple, register a pseudo encap match of a new type
>  (EFX_TC_EM_PSEUDO_OR), which unlike PSEUDO_MASK may only be referenced
>  once (because an actual Outer Rule in hardware exists, although its
>  fw_id is not recorded in the encap match entry).
> 
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

...

> @@ -1354,6 +1450,119 @@ static int efx_tc_incomplete_mangle(struct efx_tc_mangler_state *mung,
>  	return 0;
>  }
>  
> +static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
> +					     struct flow_cls_offload *tc,
> +					     struct flow_rule *fr,
> +					     struct efx_tc_match *match,
> +					     struct net_device *net_dev)
> +{
> +	struct netlink_ext_ack *extack = tc->common.extack;
> +	struct efx_tc_lhs_rule *rule, *old;
> +	enum efx_encap_type type;
> +	int rc;
> +
> +	if (tc->common.chain_index) {
> +		NL_SET_ERR_MSG_MOD(extack, "LHS rule only allowed in chain 0");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!efx_tc_match_is_encap(&match->mask)) {
> +		/* This is not a tunnel decap rule, ignore it */
> +		netif_dbg(efx, drv, efx->net_dev, "Ignoring foreign LHS filter without encap match\n");

Hi Edward,

is NL_SET_ERR_MSG_MOD() appropriate here?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (efx_tc_flower_flhs_needs_ar(match)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Match keys not available in Outer Rule");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	type = efx_tc_indr_netdev_type(net_dev);
> +	if (type == EFX_ENCAP_TYPE_NONE) {
> +		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rc = efx_mae_check_encap_type_supported(efx, type);
> +	if (rc) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Firmware reports no support for %s encap match",
> +				       efx_tc_encap_type_name(type));
> +		return rc;
> +	}
> +	/* Reserve the outer tuple with a pseudo Encap Match */
> +	rc = efx_tc_flower_record_encap_match(efx, match, type,
> +					      EFX_TC_EM_PSEUDO_OR, 0, 0,
> +					      extack);
> +	if (rc)
> +		return rc;
> +
> +	if (match->mask.ct_state_trk && match->value.ct_state_trk) {
> +		NL_SET_ERR_MSG_MOD(extack, "LHS rule can never match +trk");
> +		rc = -EOPNOTSUPP;
> +		goto release_encap_match;
> +	}
> +	/* LHS rules are always -trk, so we don't need to match on that */
> +	match->mask.ct_state_trk = 0;
> +	match->value.ct_state_trk = 0;
> +
> +	rc = efx_tc_flower_translate_flhs_match(match);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "LHS rule cannot match on inner fields");
> +		goto release_encap_match;
> +	}
> +
> +	rc = efx_mae_match_check_caps_lhs(efx, &match->mask, extack);
> +	if (rc)
> +		goto release_encap_match;
> +
> +	rule = kzalloc(sizeof(*rule), GFP_USER);
> +	if (!rule) {
> +		rc = -ENOMEM;
> +		goto release_encap_match;
> +	}
> +	rule->cookie = tc->cookie;
> +	old = rhashtable_lookup_get_insert_fast(&efx->tc->lhs_rule_ht,
> +						&rule->linkage,
> +						efx_tc_lhs_rule_ht_params);
> +	if (old) {
> +		netif_dbg(efx, drv, efx->net_dev,
> +			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
> +		rc = -EEXIST;
> +		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
> +		goto release;
> +	}
> +
> +	/* Parse actions */
> +	rc = efx_tc_flower_handle_lhs_actions(efx, tc, fr, net_dev, rule);
> +	if (rc)
> +		goto release;
> +
> +	rule->match = *match;
> +	rule->lhs_act.tun_type = type;
> +
> +	rc = efx_mae_insert_lhs_rule(efx, rule, EFX_TC_PRIO_TC);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to insert rule in hw");
> +		goto release;
> +	}
> +	netif_dbg(efx, drv, efx->net_dev,
> +		  "Successfully parsed lhs rule (cookie %lx)\n",
> +		  tc->cookie);
> +	return 0;
> +
> +release:
> +	efx_tc_flower_release_lhs_actions(efx, &rule->lhs_act);
> +	if (!old)
> +		rhashtable_remove_fast(&efx->tc->lhs_rule_ht, &rule->linkage,
> +				       efx_tc_lhs_rule_ht_params);
> +	kfree(rule);
> +release_encap_match:
> +	if (match->encap)
> +		efx_tc_flower_release_encap_match(efx, match->encap);
> +	return rc;
> +}

...

