Return-Path: <netdev+bounces-23863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55B76DE3F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651051C213CF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C448F4B;
	Thu,  3 Aug 2023 02:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBE846A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311A7C433C7;
	Thu,  3 Aug 2023 02:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691029903;
	bh=i9jgwhjR1t6uFiO0Wv3aTMvA8AbCzNmZLabvWMaiOdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XC+uHY7iPjtv9RQgSsts8uLzV0EQFSazZQoq6iWjzG1qvv5+B83F/s5lYAdNwePYd
	 SbFllKYNXTMui//urzwDG4wL18F9lkbmeg6HIaca+wQR2RBsOQQqqRISHmEz0XLBN3
	 SMIdMalVDPuMGMQxvxPvPY7ojQGuGx2MpwxovC3ygy/F+uh4fhzIQU3EtXo2NaQNnP
	 fhgivmEjCWLrbyBryHP4kec9D+6OQkFnUtRgivpS1xicJaSiQuWDSoOaVWO06cXA43
	 mho+Yh8ljV5r/D/05qSao9TbwQa8eO/wXd/UC311Hyfx+v2R2E5szuacW/zrPFlrC3
	 7/DQPjZCfLZQQ==
Date: Wed, 2 Aug 2023 19:31:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@idosch.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vlad Buslov <vladbu@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Wojciech Drewek <wojciech.drewek@intel.com>, Simon Horman
 <horms@kernel.org>, Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br
 offload
Message-ID: <20230802193142.59fe5bf3@kernel.org>
In-Reply-To: <20230801173112.3625977-3-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
	<20230801173112.3625977-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 10:31:07 -0700 Tony Nguyen wrote:
> From: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
> with vid = 1, it means that we have to offload untagged traffic.
> This is achieved by adding vlan metadata lookup.

Paul already asked about this behavior but it's unclear to me from the
answer whether this is a local custom or legit switchdev behavior.
Could someone with switchdev knowledge glance over this?

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 67bfd1f61cdd..5b425260b0eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -104,13 +104,18 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
>  static u16
>  ice_eswitch_br_get_lkups_cnt(u16 vid)
>  {
> -	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
> +	/* if vid == 0 then we need only one lookup (ICE_MAC_OFOS),
> +	 * otherwise we need both mac and vlan
> +	 */
> +	return vid == 0 ? 1 : 2;
>  }
>  
>  static void
>  ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
>  {
> -	if (ice_eswitch_br_is_vid_valid(vid)) {
> +	if (vid == 1) {
> +		ice_rule_add_vlan_metadata(&list[1]);
> +	} else if (vid > 1) {
>  		list[1].type = ICE_VLAN_OFOS;
>  		list[1].h_u.vlan_hdr.vlan = cpu_to_be16(vid & VLAN_VID_MASK);
>  		list[1].m_u.vlan_hdr.vlan = cpu_to_be16(0xFFFF);
> @@ -400,7 +405,6 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
>  	unsigned long event;
>  	int err;
>  
> -	/* untagged filtering is not yet supported */
>  	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
>  		return;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> index 85a8fadb2928..cf7b0e5acfcb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> @@ -103,15 +103,6 @@ struct ice_esw_br_vlan {
>  		     struct ice_esw_br_fdb_work, \
>  		     work)
>  
> -static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
> -{
> -	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
> -	 * to offload VLAN 1 with pvid and untagged flags set. Since these
> -	 * flags are not supported, add a MAC filter instead.
> -	 */
> -	return vid > 1;
> -}
> -
>  void
>  ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
>  int


