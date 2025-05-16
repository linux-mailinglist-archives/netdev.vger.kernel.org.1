Return-Path: <netdev+bounces-191081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA47AB9FAF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B89A16B4B6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FE16F841;
	Fri, 16 May 2025 15:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191584174A
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408597; cv=none; b=HNu6n+nqnfYYvqx2xcpzoJjOND+9LBx04m1GlBYLVFtRxo0jWhW0qcluXbmrougNS0ygrVyZ1NYc5aTlf1BJbO/Jdn/0UgK1wZ14VtJ/EW12igkz6ALYNUyf/4xow55KVY/RHifpStJTFRrZJoInOydHMfP4sdvirgOwNC9pmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408597; c=relaxed/simple;
	bh=ZJ4LxqDlVwaXgOd5U7VeAE8f4Maza2Jq7na2pMv7pFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPfe6rRZelcitTcYg4aEHHo+dO55oGMLfP2ZsSiWJoYKHk3B7ES0GgILsYf+dWCWjFnrNKc9dWvUBKqrsCc9nTl2af1E0J9VMSvwTrrjdstnruPyp3PMSbAHBZt++mCwDLL27tzLSUCrXP2wvZYjZG69QAiTL9LwS1Ne8iWGh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EE38161EA1BF8;
	Fri, 16 May 2025 17:15:54 +0200 (CEST)
Message-ID: <be6f3fd0-e45b-460b-89df-7b3e846eefd9@molgen.mpg.de>
Date: Fri, 16 May 2025 17:15:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 40G speed to Admin
 Command GET PORT OPTION
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Aleksandr,


Thank you for your patch.

Am 16.05.25 um 16:42 schrieb Aleksandr Loktionov:
> Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
> to process this new option in both the devlink and the Admin Queue Command
> GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
> ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.
> 
> This feature allows the driver to correctly report configuration options
> for 2x40G on ICX-D LCC and other cards in the future via devlink.
> 
> Example command:
>   devlink port split pci/0000:01:00.0/0 count 2
> 
> Example dmesg:
>   ice 0000:01:00.0: Available port split options and max port speeds (Gbps):
>   ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
>   ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
>   ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
>   ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
>   ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
>   ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
>   ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
>   ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2->v3 - fix indent
> v1->v2 - fix typo in commit message
> ---
>   drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
>   drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
>   4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
> index 767419a..63fb36f 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
> @@ -30,6 +30,8 @@ static const char *ice_devlink_port_opt_speed_str(u8 speed)
>   		return "10";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
>   		return "25";
> +	case ICE_AQC_PORT_OPT_MAX_LANE_40G:
> +		return "40";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
>   		return "50";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index bdee499..2ff141a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1672,6 +1672,7 @@ struct ice_aqc_get_port_options_elem {
>   #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
>   #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
>   #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
> +#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
>   
>   	u8 global_scid[2];
>   	u8 phy_scid[2];
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 4fedf01..2519ad6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4080,7 +4080,7 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
>   
>   		speed = options[active_idx].max_lane_speed;
>   		/* If we don't get speed for this lane, it's unoccupied */
> -		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
> +		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_40G)
>   			continue;
>   
>   		if (hw->pf_id == lport) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 6488151..f2c0b28 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
>   
>   		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
>   			port_topology->serdes_lane_count = 4;
> -		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
> +		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
> +			 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)
>   			port_topology->serdes_lane_count = 2;
>   		else
>   			port_topology->serdes_lane_count = 1;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

