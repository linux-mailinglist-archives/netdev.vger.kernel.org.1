Return-Path: <netdev+bounces-84336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E7896A61
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B001F24C5D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC46F06D;
	Wed,  3 Apr 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3Wijdi3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD345008
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136091; cv=none; b=fv/5p99S+hqD067v/HNb9OQWkXoWBdrE/Nr9svJtRKCuZCH0eN29L6D6FHDTdrR5d2J9oflRi2qrZ/ssH9lVj/8OUvDMXohVLdmOmUoZiWXE0Wqoysdz1g0C/nxSiKTIeCkYidXFVrAMmv7CX72vkKGwSr9UG0NVj6yDotj4myU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136091; c=relaxed/simple;
	bh=pJu6+ZAMB5/iuWJvZl1OLiuv2MCaA4XQrA4I3YAgSkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzQkeESYxGG5TW+yDzHBHFSkavnn18oooeTRHeYV9FNpXN7teJix8sFz+F6wG3catFLOshQqlP3l8P0snQwC+J9avf8ngfMSq76mYwi/O3jArwWR13YovpQLc91mdU3/E+cErGqhdGLF6gzwGJ2dS3Ab9P61s/ImjyfZrNzoUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3Wijdi3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136089; x=1743672089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pJu6+ZAMB5/iuWJvZl1OLiuv2MCaA4XQrA4I3YAgSkE=;
  b=g3Wijdi31lXh3RIAXONtknD6ZchVyggTeEl49QFmj+MBFT7HUcDiZ/SQ
   Y5ZIZ+poSKC2SDGRv6HpOttELQIMWWzr2ZScFBU8G7Oj2aPP3gtvSvBJ+
   UZ8tzawHnGSaFB6pEKKdfXLrfk22abHd08TXojt/QbKvLoN3EMN42v8Mb
   DlUSoapUqsCLHhJ1yNf3mfhw/7fOcj/RyZ2RRg7eBn6KhPe/hggxzwjva
   MoRi3Rx0HFyoM23JPPM8mcy2+q2lvgPipCL9RiBeCfzr5wMVqo/CiEl0A
   DNQFNt0csa92ULCEOF9C0BzpcLD9koHx6Irdo40FiFUsLXSk5LRYaZmKo
   g==;
X-CSE-ConnectionGUID: awREbb0sQ/2Pl7iKmVPRWg==
X-CSE-MsgGUID: Do5x9h9PS42CXRUblJqdgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7223860"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7223860"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:21:28 -0700
X-CSE-ConnectionGUID: vYouQ9mzTVOHBDAG77CKhw==
X-CSE-MsgGUID: x4R7GP6hTeqOZ3HPRNbXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23138927"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.48.91]) ([10.246.48.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:21:26 -0700
Message-ID: <1e22362d-63ff-4aba-8ef7-0b139517ba56@linux.intel.com>
Date: Wed, 3 Apr 2024 11:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] ice: Reset VF on Tx MDD
 event
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
 "Wang, Liang-min" <liang-min.wang@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Chmielewski, Pawel" <pawel.chmielewski@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <20240402165221.11669-1-marcin.szycik@linux.intel.com>
 <SJ0PR11MB58667566B779717F962B9871E53D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <SJ0PR11MB58667566B779717F962B9871E53D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.04.2024 08:37, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
>> Behalf Of Marcin Szycik
>> Sent: Tuesday, April 2, 2024 6:52 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Wang, Liang-min
>> <liang-min.wang@intel.com>; netdev@vger.kernel.org; Chmielewski,
>> Pawel <pawel.chmielewski@intel.com>; Marcin Szycik
>> <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; horms@kernel.org; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-next v4] ice: Reset VF on Tx
>> MDD event
>>
> Please state in the title explicitly the purpose of the patch:
> Do you fix a bug? say fix
> Do you add  functionality? say add
> Do you refactor? say refactor

IMO it's neither of those.

It's not a bugfix because the driver itself doesn't do anything wrong;
the patch provides the user with a kind of optional workaround for an
userspace app that's behaving incorrectly.

It's not really new functionality, since the mdd-auto-reset-vf flag
was already implemented and auto reset was already happening for Rx
events. I'm just extending this to Tx as well.

And it's not strictly a refactor because I'm changing behaviour.

Please also note that I've picked up a patch not originally made by
me [2], and kept the original title and most of the description. I'm
open to suggestions to title though.

>> In cases when VF sends malformed packets that are classified as
>> malicious, sometimes it causes Tx queue to freeze. This frozen
>> queue can be stuck for several minutes being unusable. This
>> behavior can be reproduced with a faulty userspace app running on
>> VF.
>>
>> When any Malicious Driver Detection event occurs and the mdd-auto-
>> reset-vf private flag is set, perform a graceful VF reset to
>> quickly bring VF back to operational state. Add a log message to
>> notify about the cause of the reset. Add a helper for this to be
>> reused for both TX and RX events.
> Please describe your changes explicitly:
> Do you just add a helper function without adding a new functionality? 
> Do you add functionality?
> Do you fix?
> Please explain what are the changes in driver behavior and the changes in the driver sources you make.
> Thank you 

I'll try to make the description more explicit.

Thanks,
Marcin

>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
>> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>> v4: Only perform auto-reset once per VF
>> v3 [1]: Only auto reset VF if the mdd-auto-reset-vf flag is set
>> v2 [2]: Revert an unneeded formatting change, fix commit message,
>> fix a log
>>     message with a correct event name
>>
>> [1] https://lore.kernel.org/intel-wired-lan/20240326164455.735739-
>> 1-marcin.szycik@linux.intel.com
>> [2] https://lore.kernel.org/netdev/20231102155149.2574209-1-
>> pawel.chmielewski@intel.com
>> ---
>>  drivers/net/ethernet/intel/ice/ice_main.c  | 57 +++++++++++++++++-
>> ----  drivers/net/ethernet/intel/ice/ice_sriov.c | 25 +++++++---
>> drivers/net/ethernet/intel/ice/ice_sriov.h |  2 +
>>  3 files changed, 67 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 185c9b13efcf..80bc83f6e1ab 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -1745,6 +1745,39 @@ static void ice_service_timer(struct
>> timer_list *t)
>>  	ice_service_task_schedule(pf);
>>  }
>>
>> +/**
>> + * ice_mdd_maybe_reset_vf - reset VF after MDD event
>> + * @pf: pointer to the PF structure
>> + * @vf: pointer to the VF structure
>> + * @reset_vf_tx: whether Tx MDD has occurred
>> + * @reset_vf_rx: whether Rx MDD has occurred
>> + *
>> + * Since the queue can get stuck on VF MDD events, the PF can be
>> +configured to
>> + * automatically reset the VF by enabling the private ethtool flag
>> + * mdd-auto-reset-vf.
>> + */
>> +static void ice_mdd_maybe_reset_vf(struct ice_pf *pf, struct
>> ice_vf *vf,
>> +				   bool reset_vf_tx, bool reset_vf_rx) {
>> +	struct device *dev = ice_pf_to_dev(pf);
>> +
>> +	if (!test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags))
>> +		return;
>> +
>> +	/* VF MDD event counters will be cleared by reset, so print
>> the event
>> +	 * prior to reset.
>> +	 */
>> +	if (reset_vf_tx)
>> +		ice_print_vf_tx_mdd_event(vf);
>> +
>> +	if (reset_vf_rx)
>> +		ice_print_vf_rx_mdd_event(vf);
>> +
>> +	dev_info(dev, "PF-to-VF reset on PF %d VF %d due to MDD
>> event\n",
>> +		 pf->hw.pf_id, vf->vf_id);
>> +	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY | ICE_VF_RESET_LOCK); }
>> +
>>  /**
>>   * ice_handle_mdd_event - handle malicious driver detect event
>>   * @pf: pointer to the PF structure
>> @@ -1838,6 +1871,8 @@ static void ice_handle_mdd_event(struct
>> ice_pf *pf)
>>  	 */
>>  	mutex_lock(&pf->vfs.table_lock);
>>  	ice_for_each_vf(pf, bkt, vf) {
>> +		bool reset_vf_tx = false, reset_vf_rx = false;
>> +
>>  		reg = rd32(hw, VP_MDET_TX_PQM(vf->vf_id));
>>  		if (reg & VP_MDET_TX_PQM_VALID_M) {
>>  			wr32(hw, VP_MDET_TX_PQM(vf->vf_id), 0xFFFF); @@ -
>> 1846,6 +1881,8 @@ static void ice_handle_mdd_event(struct ice_pf
>> *pf)
>>  			if (netif_msg_tx_err(pf))
>>  				dev_info(dev, "Malicious Driver Detection
>> event TX_PQM detected on VF %d\n",
>>  					 vf->vf_id);
>> +
>> +			reset_vf_tx = true;
>>  		}
>>
>>  		reg = rd32(hw, VP_MDET_TX_TCLAN(vf->vf_id)); @@ -1856,6
>> +1893,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
>>  			if (netif_msg_tx_err(pf))
>>  				dev_info(dev, "Malicious Driver Detection
>> event TX_TCLAN detected on VF %d\n",
>>  					 vf->vf_id);
>> +
>> +			reset_vf_tx = true;
>>  		}
>>
>>  		reg = rd32(hw, VP_MDET_TX_TDPU(vf->vf_id)); @@ -1866,6
>> +1905,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
>>  			if (netif_msg_tx_err(pf))
>>  				dev_info(dev, "Malicious Driver Detection
>> event TX_TDPU detected on VF %d\n",
>>  					 vf->vf_id);
>> +
>> +			reset_vf_tx = true;
>>  		}
>>
>>  		reg = rd32(hw, VP_MDET_RX(vf->vf_id)); @@ -1877,18
>> +1918,12 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
>>  				dev_info(dev, "Malicious Driver Detection
>> event RX detected on VF %d\n",
>>  					 vf->vf_id);
>>
>> -			/* Since the queue is disabled on VF Rx MDD
>> events, the
>> -			 * PF can be configured to reset the VF through
>> ethtool
>> -			 * private flag mdd-auto-reset-vf.
>> -			 */
>> -			if (test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf-
>>> flags)) {
>> -				/* VF MDD event counters will be cleared by
>> -				 * reset, so print the event prior to
>> reset.
>> -				 */
>> -				ice_print_vf_rx_mdd_event(vf);
>> -				ice_reset_vf(vf, ICE_VF_RESET_LOCK);
>> -			}
>> +			reset_vf_rx = true;
>>  		}
>> +
>> +		if (reset_vf_tx || reset_vf_rx)
>> +			ice_mdd_maybe_reset_vf(pf, vf, reset_vf_tx,
>> +					       reset_vf_rx);
>>  	}
>>  	mutex_unlock(&pf->vfs.table_lock);
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> index fb2e96db647e..a60dacf8942a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> @@ -1861,6 +1861,24 @@ void ice_print_vf_rx_mdd_event(struct ice_vf
>> *vf)
>>  			  ? "on" : "off");
>>  }
>>
>> +/**
>> + * ice_print_vf_tx_mdd_event - print VF Tx malicious driver detect
>> +event
>> + * @vf: pointer to the VF structure
>> + */
>> +void ice_print_vf_tx_mdd_event(struct ice_vf *vf) {
>> +	struct ice_pf *pf = vf->pf;
>> +	struct device *dev;
>> +
>> +	dev = ice_pf_to_dev(pf);
>> +
>> +	dev_info(dev, "%d Tx Malicious Driver Detection events
>> detected on PF %d VF %d MAC %pM. mdd-auto-reset-vfs=%s\n",
>> +		 vf->mdd_tx_events.count, pf->hw.pf_id, vf->vf_id,
>> +		 vf->dev_lan_addr,
>> +		 test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)
>> +			  ? "on" : "off");
>> +}
>> +
>>  /**
>>   * ice_print_vfs_mdd_events - print VFs malicious driver detect
>> event
>>   * @pf: pointer to the PF structure
>> @@ -1869,8 +1887,6 @@ void ice_print_vf_rx_mdd_event(struct ice_vf
>> *vf)
>>   */
>>  void ice_print_vfs_mdd_events(struct ice_pf *pf)  {
>> -	struct device *dev = ice_pf_to_dev(pf);
>> -	struct ice_hw *hw = &pf->hw;
>>  	struct ice_vf *vf;
>>  	unsigned int bkt;
>>
>> @@ -1897,10 +1913,7 @@ void ice_print_vfs_mdd_events(struct ice_pf
>> *pf)
>>  		if (vf->mdd_tx_events.count != vf-
>>> mdd_tx_events.last_printed) {
>>  			vf->mdd_tx_events.last_printed =
>>  							vf->mdd_tx_events.count;
>> -
>> -			dev_info(dev, "%d Tx Malicious Driver Detection
>> events detected on PF %d VF %d MAC %pM.\n",
>> -				 vf->mdd_tx_events.count, hw->pf_id, vf-
>>> vf_id,
>> -				 vf->dev_lan_addr);
>> +			ice_print_vf_tx_mdd_event(vf);
>>  		}
>>  	}
>>  	mutex_unlock(&pf->vfs.table_lock);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h
>> b/drivers/net/ethernet/intel/ice/ice_sriov.h
>> index 4ba8fb53aea1..8f22313474d6 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
>> @@ -58,6 +58,7 @@ void
>>  ice_vf_lan_overflow_event(struct ice_pf *pf, struct
>> ice_rq_event_info *event);  void ice_print_vfs_mdd_events(struct
>> ice_pf *pf);  void ice_print_vf_rx_mdd_event(struct ice_vf *vf);
>> +void ice_print_vf_tx_mdd_event(struct ice_vf *vf);
>>  bool
>>  ice_vc_validate_pattern(struct ice_vf *vf, struct
>> virtchnl_proto_hdrs *proto);
>>  u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev); @@ -69,6
>> +70,7 @@ static inline  void ice_vf_lan_overflow_event(struct
>> ice_pf *pf, struct ice_rq_event_info *event) { }  static inline
>> void ice_print_vfs_mdd_events(struct ice_pf *pf) { }  static inline
>> void ice_print_vf_rx_mdd_event(struct ice_vf *vf) { }
>> +static inline void ice_print_vf_tx_mdd_event(struct ice_vf *vf) {
>> }
>>  static inline void ice_restore_all_vfs_msi_state(struct ice_pf
>> *pf) { }
>>
>>  static inline int
>> --
>> 2.41.0
> 

