Return-Path: <netdev+bounces-231054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E388BF43DF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2035818A5E1F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC2224B04;
	Tue, 21 Oct 2025 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7eXwPeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE82222B2;
	Tue, 21 Oct 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009759; cv=none; b=S73ya6yhKeU8GeXybxfn+VjX+W18ofxHxoQkayr6h9XjwS7WD1wVnq1cMC4MTPfN5M60F9dBYc0B+KCuyKjep/6IYSHBuKPNt5x7avaVXUWm1e0aRBU1Ocng4o4K40guQYxhJkxlYMueKopPhvlYZ2n8TFA+HmTnhpXW013rwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009759; c=relaxed/simple;
	bh=Y+aCJCjusbz3Sh3VNt+NrGD54kYFdlm0Is+BwQFvkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOMIiF//1kpwS/r/aRhIglzP7gz3psGM0SipRL+oEZMMIUS1lW6k2Rt246W3FIE9Gunj5Mz5oVTDr0dj6PNI1LpjGH7Buy4M+ooxiWPAaWi+skHf5S+Dh96sV/4s6Kjyl6UU+foFN3Skczr6BPYieeJHCC4kfg+6V8RfKY5D6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7eXwPeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A56C4CEFB;
	Tue, 21 Oct 2025 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009757;
	bh=Y+aCJCjusbz3Sh3VNt+NrGD54kYFdlm0Is+BwQFvkpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o7eXwPeqnR5RT75+SFPguVVrCrd4ZpeWZNxEkRrshu8sn8A7PaEL072Tk3TO04y0L
	 U8XjJyK/iQj+nLzy7LJxttMYiyR40KM8hgPpluK3WCFkoyw+KGDi/dlywxHRKhXj0c
	 miEPBxpUgnWpQ84WFdE/DzrWUZ9Rf8b4kzJLWoW2tVXs3KY5vLLChwPRGNi9H8HHyd
	 MV7HEN06aDd9wrqFXHUT0R5K5ppop+RjOaCNXm0vDp4MPxjIjQ7M3G57802KR3SXaD
	 kKJjXg37TuzWz6pbArMhJrTqQqAjKHws0eKAtErlR0LhJKKCjOhOroirTZ/xTdWk/W
	 Rwh8xSYbpAEDg==
Date: Mon, 20 Oct 2025 18:22:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Dan Nowlin
 <dan.nowlin@intel.com>, Jie Wang <jie1x.wang@intel.com>, Junfeng Guo
 <junfeng.guo@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Ting Xu
 <ting.xu@intel.com>, Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 04/14] ice: add virtchnl and VF context
 support for GTP RSS
Message-ID: <20251020182235.7db743ee@kernel.org>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-4-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-4-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:08:33 -0700 Jacob Keller wrote:
>  void ice_parser_destroy(struct ice_parser *psr)
>  {
> +	if (!psr)
> +		return;

questionable

> +	{VIRTCHNL_PROTO_HDR_L2TPV2,
> +		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_SESS_ID),
> +		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID)},
> +	{VIRTCHNL_PROTO_HDR_L2TPV2,
> +		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_LEN_SESS_ID),
> +		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID)},

consider moving out all the static data and define changes to a
separate commit for ease of review?

>  };
>  
> +static enum virtchnl_status_code
> +ice_vc_rss_hash_update(struct ice_hw *hw, struct ice_vsi *vsi, u8 hash_type)
> +{
> +	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_vsi_ctx *ctx;
> +	int ret;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return VIRTCHNL_STATUS_ERR_NO_MEMORY;

I feel like the VIRTCHNL_* error codes are spreading, we've been over
this. 

> +static int
> +ice_hash_remove(struct ice_vf *vf, struct ice_rss_hash_cfg *cfg)
> +{
> +	int ret;
> +
> +	ret = ice_hash_moveout(vf, cfg);
> +	if (ret && (ret != -ENOENT))

spurious brackets

> +/**
> + * ice_add_rss_cfg_pre_ip - Pre-process IP-layer RSS configuration
> + * @vf: VF pointer
> + * @ctx: IP L4 hash context (ESP/UDP-ESP/AH/PFCP and UDP/TCP/SCTP)
> + *
> + * Remove covered/recorded IP RSS configurations prior to adding a new one.
> + *
> + * Return: 0 on success; negative error code on failure.
> + */
> +static int
> +ice_add_rss_cfg_pre_ip(struct ice_vf *vf, struct ice_vf_hash_ip_ctx *ctx)
> +{
> +	int i, ret;
> +
> +	for (i = 1; i < ICE_HASH_IP_CTX_MAX; i++)
> +		if (ice_is_hash_cfg_valid(&ctx->ctx[i])) {
> +			ret = ice_hash_remove(vf, &ctx->ctx[i]);
> +

spurious new line

> +			if (ret)
> +				return ret;
> +		}
> +
> +	return 0;
> +}

> +static int
> +ice_parse_raw_rss_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto,
> +			  struct ice_rss_raw_cfg *raw_cfg)
> +{
> +	struct ice_parser_result pkt_parsed;
> +	struct ice_hw *hw = &vf->pf->hw;
> +	struct ice_parser_profile prof;
> +	u16 pkt_len;
> +	struct ice_parser *psr;
> +	u8 *pkt_buf, *msk_buf;
> +	int ret = 0;
> +
> +	pkt_len = proto->raw.pkt_len;
> +	if (!pkt_len)
> +		return -EINVAL;
> +	if (pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
> +		pkt_len = VIRTCHNL_MAX_SIZE_RAW_PACKET;
> +
> +	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
> +	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
> +	if (!pkt_buf || !msk_buf) {
> +		ret = -ENOMEM;
> +		goto free_alloc;
> +	}
> +
> +	memcpy(pkt_buf, proto->raw.spec, pkt_len);
> +	memcpy(msk_buf, proto->raw.mask, pkt_len);
> +
> +	psr = ice_parser_create(hw);
> +	if (IS_ERR(psr)) {
> +		ret = PTR_ERR(psr);
> +		goto parser_destroy;

goto free_alloc, surely, parser creation has failed, there's nothing to destroy

> +	}
> +
> +	ret = ice_parser_run(psr, pkt_buf, pkt_len, &pkt_parsed);
> +	if (ret)
> +		goto parser_destroy;
> +
> +	ret = ice_parser_profile_init(&pkt_parsed, pkt_buf, msk_buf,
> +				      pkt_len, ICE_BLK_RSS, &prof);
> +	if (ret)
> +		goto parser_destroy;
> +
> +	memcpy(&raw_cfg->prof, &prof, sizeof(prof));
> +
> +parser_destroy:
> +	ice_parser_destroy(psr);
> +free_alloc:
> +	kfree(pkt_buf);
> +	kfree(msk_buf);
> +	return ret;
> +}

