Return-Path: <netdev+bounces-112437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6094939143
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68819B21C35
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43416DC3F;
	Mon, 22 Jul 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq9kbjRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9816DC3A
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660558; cv=none; b=eq6VtbokGKWhsqU2nc03wg1+4W/m7ujym5tULQgChQG5E2BneSB12DqZT3KAMgQdk64m7EjmmZCEkPwa9bDixUxgjElr6KUQfP29ndXIkcRPtjo3C1CqGnD1kkauo605DR7upTe1yqnUXQqRi1rntkWdP0lS5LhQNTh8WagjlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660558; c=relaxed/simple;
	bh=pAk0rVV50P2Q+ArDebksQq7XsI+EGNKBGEJfMCA5Sqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI5l68TmF6GuQmoR5+WUaR/AzcDyyTGDFigPTSuBblAq63caAeCCI2RJBATKzpcbP+yP91p/RIjy5+Zg44s/xCWvDI8QUnhMLf+R2HFWYg/8iJkg8xyoBVZRJTt8v240t0VcBKLC5cdfdNhMSbG9wsrul1oJEqS2UT+QBJwg1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq9kbjRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D26C4AF11;
	Mon, 22 Jul 2024 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660557;
	bh=pAk0rVV50P2Q+ArDebksQq7XsI+EGNKBGEJfMCA5Sqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq9kbjRLugWzyckQ9EdM8GYrf3Wl/LbMZXQ69ozdR8Bv9+VZz9C0CJGBYvxSXtIrd
	 Qzcp+P4Zm8I8QbOYYyjvObn7wVP1XLzL4f0r81R3jP7atc2qjVk/NizMGO3WvHqvL7
	 LofbBg1ReVb8eBgV9jvr0Tyteu2Y0+KSeqbxSz9KLL2ArgpqcL4AdTIazWK+drY7Zj
	 LuvPCnRqKvaw/FrKECOxn5yZHYhWJR2+0iA9b8vKby04fLV30dqVKuf8/ABIEewOvS
	 D7/L7M+DpEMQ1AtbtPqBOwYjN+moN3cwjAYGZ9qi2yxWC8VoUIl6Am3T1MWIPu+Uqc
	 JtWT+RAp+PfDw==
Date: Mon, 22 Jul 2024 16:02:34 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 06/13] ice: support turning on/off the
 parser's double vlan mode
Message-ID: <20240722150234.GI715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-7-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-7-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:08PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add API ice_parser_dvm_set() to support turning on/off the parser's double
> vlan mode.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 78 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_parser.h | 18 +++++
>  2 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c

...

>  static void ice_parse_lbl_item(struct ice_hw *hw, u16 idx, void *item,
> -			       void *data, int size)
> +			       void *data, int __maybe_unused size)
>  {
> -	memcpy(item, data, size);
> +	struct ice_lbl_item *lbl_item = (struct ice_lbl_item *)item;
> +	struct ice_lbl_item *lbl_data = (struct ice_lbl_item *)data;

nit: Explicitly casting void * is unnecessary.

> +
> +	lbl_item->idx = lbl_data->idx;
> +	memcpy(lbl_item->label, lbl_data->label, sizeof(lbl_item->label));
> +
> +	if (strstarts(lbl_item->label, ICE_LBL_BST_DVM))
> +		lbl_item->type = ICE_LBL_BST_TYPE_DVM;
> +	else if (strstarts(lbl_item->label, ICE_LBL_BST_SVM))
> +		lbl_item->type = ICE_LBL_BST_TYPE_SVM;
>  
>  	if (hw->debug_mask & ICE_DBG_PARSER)
> -		ice_lbl_dump(hw, (struct ice_lbl_item *)item);
> +		ice_lbl_dump(hw, lbl_item);
>  }

...

> +static void ice_bst_dvm_set(struct ice_parser *psr, enum ice_lbl_type type,
> +			    bool on)
> +{
> +	u16 i = 0;
> +
> +	while (true) {
> +		struct ice_bst_tcam_item *item;
> +		u8 key;
> +
> +		item = ice_bst_tcam_search(psr->bst_tcam_table,
> +					   psr->bst_lbl_table,
> +					   type, &i);
> +		if (!item)
> +			break;
> +
> +		key = (on ? ICE_BT_VLD_KEY : ICE_BT_INV_KEY);

nit: these parentheses seem unnecessary

> +		item->key[ICE_BT_VM_OFF] = key;
> +		item->key_inv[ICE_BT_VM_OFF] = key;
> +		i++;
> +	}
> +}

...

