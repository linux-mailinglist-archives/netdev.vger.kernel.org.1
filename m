Return-Path: <netdev+bounces-73270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BA85BA76
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EA11C248E0
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C3664AB;
	Tue, 20 Feb 2024 11:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34D69D0A
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428229; cv=none; b=hT/x4kA7qH6kV8uXEulqAPUWOu72vwe6ysWR7EgLmas6yVk2j6gtdX7+/5+7Ve8NLr0iclfHRY+fXX4LL5Eglhs43YFwusvLv01QdDfhNWMBli2bqfxHSLUtn5sQ+M5VQocp1YwFq40vyOm06JYVNq3vzSsQHUnu/lQVJ/LydFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428229; c=relaxed/simple;
	bh=RDAWUbcFO2uB6AAumf8DkaVI5yCeJDZhMn8JqVBY7pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obgqsE1oNbrikY1FkF7XaUwseCzJf20tGbBwnjpIU0ybqLPqS0horsR0KqHvFJKYw/77ltuaoZfi+FcDF3zcHEQ023nRGdqcW7xE7T4LvSt4GDyc4hUFUBsy+zNQdOo1IaMd66IJ02cqxoTbmcUhp7iXVxqDxqoGRiJxM6+ay00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BA81C61E5FE01;
	Tue, 20 Feb 2024 12:23:11 +0100 (CET)
Message-ID: <30416589-7340-4ad3-8749-bef1f82743cb@molgen.mpg.de>
Date: Tue, 20 Feb 2024 12:23:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v1 1/2] ice: tc: check src_vsi in
 case of traffic from VF
Content-Language: en-US
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, sridhar.samudrala@intel.com
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
 <20240220105950.6814-2-michal.swiatkowski@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240220105950.6814-2-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for the patch.

Am 20.02.24 um 11:59 schrieb Michal Swiatkowski:
> In case of traffic going from the VF (so ingress for port representor)
> there should be a check for source VSI. It is needed for hardware to not
> match packets from different port with filters added on other port.

… from different port*s* …?

> It is only for "from VF" traffic, because other traffic direction
> doesn't have source VSI.

Do you have a test case to reproduce this?

> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index b890410a2bc0..49ed5fd7db10 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -28,6 +28,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
>   	 * - ICE_TC_FLWR_FIELD_VLAN_TPID (present if specified)
>   	 * - Tunnel flag (present if tunnel)
>   	 */
> +	if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
> +		lkups_cnt++;

Why does the count variable need to be incremented?

>   	if (flags & ICE_TC_FLWR_FIELD_TENANT_ID)
>   		lkups_cnt++;
> @@ -363,6 +365,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>   	/* Always add direction metadata */
>   	ice_rule_add_direction_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
>   
> +	if (tc_fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
> +		ice_rule_add_src_vsi_metadata(&list[i]);
> +		i++;
> +	}
> +
>   	rule_info->tun_type = ice_sw_type_from_tunnel(tc_fltr->tunnel_type);
>   	if (tc_fltr->tunnel_type != TNL_LAST) {
>   		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list, i);
> @@ -820,6 +827,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
>   
>   	/* specify the cookie as filter_rule_id */
>   	rule_info.fltr_rule_id = fltr->cookie;
> +	rule_info.src_vsi = vsi->idx;

Besides the comment above being redundant (as the code does exactly 
that), the new line looks like to belong to the comment. Please excuse 
my ignorance, but the commit message only talks about adding checks and 
not overwriting the `src_vsi`. It’d be great, if you could elaborate.

>   	ret = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, &rule_added);
>   	if (ret == -EEXIST) {


Kind regards,

Paul

