Return-Path: <netdev+bounces-278044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KJxOy7N3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154C3EB091
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77DDF301319A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56C3C0621;
	Mon, 13 Apr 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhEkTvs0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881E3C0617
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077862; cv=none; b=Vjqlfjx8RAuedwN/pnpzcck7AwjpOk1JYBbfj0YDreURwTJ4AKLIfpuAgK/+rJsVs7QkwgoZUSrW25p5urkfjp6M89bQj/BfJQY+s7OLAEDA2dJHXv3xVdKusRktrr4p0LB4IuU3iCAGKm0P1TZBE7B6dYB7xt6mqZPISMt6HVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077862; c=relaxed/simple;
	bh=v+Yl5oo6K3n5TZC9lJDiqsFSe9szOV/2yEYYDRyBvVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxXRVyS8Ytmd0N9pzqKahlTriSSkWAe6Oj+bg3lswNmpa7EXX4rxJpqjcLPXG/d8MbU/ipxN8lEW2hqHXrBcpvslxq85zJywktUsxmveTn1IaJ3to8Eoxn0f8Nb/6P2+4PAnw2JUfluIbQMuxEsK8AVvniMrdKb2h4l4UYppdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhEkTvs0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776077860; x=1807613860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v+Yl5oo6K3n5TZC9lJDiqsFSe9szOV/2yEYYDRyBvVU=;
  b=IhEkTvs0G5T/dgT4k6Mkui895dv/Ihya1yMwuJF4GdnEqTULa6ZCUdZ6
   A+NDFt7zx2kjcH2VuKjkjfYXOCD39fO/KMd9OSVkYOzqg6pInibiGeduB
   g+Xgy/YN1z4WWcj78eGV3yRemv7g43DKYgmlxQWhsgJ+NolA3J1zV04cO
   NV/XXb9TIap2s2dcPlUorjXune3vWMLHz9iYeP/HAgMa06/dLEkOx5fOY
   Q6Dbuyn3jGQlIXCqAWbCWKfbFdlDYydFTqGKGPwqCguKNqnRlxwnSq32s
   Hjqb4wD8g9FzGfxKpBxTJewAMGH89uxHoJRYmkxJR37f7sjKd+mtBrT94
   Q==;
X-CSE-ConnectionGUID: gDCEz5WPTJi9HQhBJZluvQ==
X-CSE-MsgGUID: q6jwvWuKT5C4WNAg01p2xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80871414"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80871414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:57:40 -0700
X-CSE-ConnectionGUID: FGce+dNNQPqG90xFSbApZw==
X-CSE-MsgGUID: 2S2LXk1KTJGhDx65yUw42Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="267742753"
Received: from unknown (HELO [10.217.180.180]) ([10.217.180.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:57:37 -0700
Message-ID: <44f2e76c-d573-4eb0-87f5-0c91e6340715@linux.intel.com>
Date: Mon, 13 Apr 2026 12:57:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 08/10] ice: program ACL
 entry
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>,
 "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "Cao, Chinh T" <chinh.t.cao@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-9-marcin.szycik@linux.intel.com>
 <IA3PR11MB898666B7AB0330B3C29DC630E5582@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <IA3PR11MB898666B7AB0330B3C29DC630E5582@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email]
X-Rspamd-Queue-Id: 1154C3EB091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09.04.2026 15:35, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Marcin Szycik
>> Sent: Thursday, April 9, 2026 2:00 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep
>> <sandeep.penigalapati@intel.com>; S, Ananth <ananth.s@intel.com>;
>> alexander.duyck@gmail.com; Marcin Szycik
>> <marcin.szycik@linux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>;
>> Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-next v2 08/10] ice: program ACL
>> entry
>>
>> From: Real Valiquette <real.valiquette@intel.com>
>>
>> Complete the filter programming process; set the flow entry and action
>> into the scenario and write it to hardware. Configure the VSI for ACL
>> filters.
>>
>> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
>> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
>> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
>> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>> v2:
>> * Use plain alloc instead of devm_ for ice_flow_entry::acts
>> * Use FIELD_PREP_CONST() for ICE_ACL_RX_*_MISS_CNTR
>> * Fix wrong struct ice_acl_act_entry alloc count in
>>   ice_flow_acl_add_scen_entry_sync() - was e->entry_sz, which is an
>>   unrelated value
>> * Only set acts_cnt after successful allocation in
>>   ice_flow_acl_add_scen_entry_sync()
>> * Return -EINVAL instead of -ENOSPC on wrong index in
>>   ice_acl_scen_free_entry_idx()
>> ---
>>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>>  drivers/net/ethernet/intel/ice/ice_acl.h      |  21 +
>>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
>>  drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
>>  drivers/net/ethernet/intel/ice/ice_acl.c      |  53 ++-
>>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 251 +++++++++++
>>  drivers/net/ethernet/intel/ice/ice_acl_main.c |   4 +
>>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  48 ++-
>>  drivers/net/ethernet/intel/ice/ice_flow.c     | 395
>> ++++++++++++++++++
>>  drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
>>  10 files changed, 782 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h
>> b/drivers/net/ethernet/intel/ice/ice.h
>> index 9e6643931022..f9a43daf04fe 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -1061,6 +1061,8 @@ void ice_aq_prep_for_event(struct ice_pf *pf,
>> struct ice_aq_task *task,
>>  			   u16 opcode);
>>  int ice_aq_wait_for_event(struct ice_pf *pf, struct ice_aq_task
>> *task,
>>  			  unsigned long timeout);
>> +int ice_ntuple_update_list_entry(struct ice_pf *pf,
>> +				 struct ice_ntuple_fltr *input, int
>> fltr_idx);
>>  int ice_open(struct net_device *netdev);  int
>> ice_open_internal(struct net_device *netdev);  int ice_stop(struct
>> net_device *netdev); diff --git
>> a/drivers/net/ethernet/intel/ice/ice_acl.h
>> b/drivers/net/ethernet/intel/ice/ice_acl.h
>> index 3a4adcf368cf..0b5651401eb7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_acl.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_acl.h
>> @@ -39,6 +39,7 @@ struct ice_acl_tbl {
>>  	DECLARE_BITMAP(avail, ICE_AQC_ACL_ALLOC_UNITS);  };
>>
>> +#define ICE_MAX_ACL_TCAM_ENTRY (ICE_AQC_ACL_TCAM_DEPTH *
>> +ICE_AQC_ACL_SLICES)
>>  enum ice_acl_entry_prio {
>>  	ICE_ACL_PRIO_LOW = 0,
>>  	ICE_ACL_PRIO_NORMAL,
>> @@ -65,6 +66,11 @@ struct ice_acl_scen {
>>  	 * participate in this scenario
>>  	 */
>>  	DECLARE_BITMAP(act_mem_bitmap, ICE_AQC_MAX_ACTION_MEMORIES);
> 
> ...
> 
>> +	/* Determine number of cascaded TCAMs */
>> +	num_cscd = DIV_ROUND_UP(scen->width,
>> ICE_AQC_ACL_KEY_WIDTH_BYTES);
>> +
>> +	entry_tcam = ICE_ACL_TBL_TCAM_IDX(scen->start);
>> +	idx = ICE_ACL_TBL_TCAM_ENTRY_IDX(scen->start + *entry_idx);
>> +
>> +	for (u8 i = 0; i < num_cscd; i++) {
>> +		/* If the key spans more than one TCAM in the case of
>> cascaded
>> +		 * TCAMs, the key and key inverts need to be properly
>> split
>> +		 * among TCAMs.E.g.bytes 0 - 4 go to an index in the
>> first TCAM
> "E.g.bytes" -> "E.g. bytes"
> 
>> +		 * and bytes 5 - 9 go to the same index in the next
>> TCAM, etc.
>> +		 * If the entry spans more than one TCAM in a cascaded
>> TCAM
>> +		 * mode, the programming of the entries in the TCAMs
>> must be in
>> +		 * reversed order - the TCAM entry of the rightmost TCAM
>> should
>> +		 * be programmed first; the TCAM entry of the leftmost
>> TCAM
>> +		 * should be programmed last.
>> +		 */
>> +		offset = num_cscd - i - 1;
>> +		memcpy(&buf.entry_key.val,
>> +		       &keys[offset * sizeof(buf.entry_key.val)],
>> +		       sizeof(buf.entry_key.val));
>> +		memcpy(&buf.entry_key_invert.val,
>> +		       &inverts[offset *
>> sizeof(buf.entry_key_invert.val)],
>> +		       sizeof(buf.entry_key_invert.val));
>> +		err = ice_aq_program_acl_entry(hw, entry_tcam + offset,
>> idx,
>> +					       &buf, NULL);
>> +		if (err) {
>> +			ice_debug(hw, ICE_DBG_ACL, "aq program acl entry
>> failed status: %d\n",
>> +				  err);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	err = ice_acl_prog_act(hw, scen, acts, acts_cnt, *entry_idx);
>> +
>> +out:
>> +	if (err) {
>> +		ice_acl_rem_entry(hw, scen, *entry_idx);
>> +		*entry_idx = 0;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * ice_acl_prog_act - Program a scenario's action memory
>> + * @hw: pointer to the HW struct
>> + * @scen: scenario to add the entry to
>> + * @acts: pointer to a buffer containing formatted actions
>> + * @acts_cnt: indicates the number of actions stored in "acts"
>> + * @entry_idx: scenario relative index of the added flow entry
>> + *
>> + * Return: 0 on success, negative on error  */ int
>> +ice_acl_prog_act(struct ice_hw *hw, struct ice_acl_scen *scen,
>> +		     struct ice_acl_act_entry *acts, u8 acts_cnt, u16
>> entry_idx) {
>> +	u8 entry_tcam, num_cscd, i, actx_idx = 0;
>> +	struct ice_aqc_actpair act_buf = {};
>> +	int err = 0;
>> +	u16 idx;
>> +
>> +	if (entry_idx >= scen->num_entry)
>> +		return -ENOSPC;
>> +
>> +	/* Determine number of cascaded TCAMs */
>> +	num_cscd = DIV_ROUND_UP(scen->width,
>> ICE_AQC_ACL_KEY_WIDTH_BYTES);
>> +
>> +	entry_tcam = ICE_ACL_TBL_TCAM_IDX(scen->start);
>> +	idx = ICE_ACL_TBL_TCAM_ENTRY_IDX(scen->start + entry_idx);
>> +
>> +	for_each_set_bit(i, scen->act_mem_bitmap,
>> ICE_AQC_MAX_ACTION_MEMORIES) {
>> +		struct ice_acl_act_mem *mem = &hw->acl_tbl->act_mems[i];
>> +
>> +		if (actx_idx >= acts_cnt)
>> +			break;
>> +		if (mem->member_of_tcam >= entry_tcam &&
>> +		    mem->member_of_tcam < entry_tcam + num_cscd) {
>> +			memcpy(&act_buf.act[0], &acts[actx_idx],
>> +			       sizeof(struct ice_acl_act_entry));
>> +
>> +			if (++actx_idx < acts_cnt) {
>> +				memcpy(&act_buf.act[1], &acts[actx_idx],
>> +				       sizeof(struct ice_acl_act_entry));
>> +			}
>> +
>> +			err = ice_aq_program_actpair(hw, i, idx,
>> &act_buf,
>> +						     NULL);
>> +			if (err) {
>> +				ice_debug(hw, ICE_DBG_ACL, "program actpair
>> failed status: %d\n",
>> +					  err);
>> +				break;
>> +			}
>> +			actx_idx++;
>> +		}
>> +	}
>> +
>> +	if (!err && actx_idx < acts_cnt)
>> +		err = -ENOSPC;
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * ice_acl_rem_entry - Remove a flow entry from an ACL scenario
>> + * @hw: pointer to the HW struct
>> + * @scen: scenario to remove the entry from
>> + * @entry_idx: the scenario-relative index of the flow entry being
>> +removed
>> + *
>> + * Return: 0 on success, negative on error  */ int
>> +ice_acl_rem_entry(struct ice_hw *hw, struct ice_acl_scen *scen,
>> +		      u16 entry_idx)
>> +{
>> +	struct ice_aqc_actpair act_buf = {};
>> +	struct ice_aqc_acl_data buf;
>> +	u8 entry_tcam, num_cscd, i;
>> +	int err = 0;
>> +	u16 idx;
>> +
>> +	if (!scen)
>> +		return -ENOENT;
>> +
>> +	if (entry_idx >= scen->num_entry)
>> +		return -ENOSPC;
>> +
>> +	if (!test_bit(entry_idx, scen->entry_bitmap))
>> +		return -ENOENT;
>> +
>> +	/* Determine number of cascaded TCAMs */
>> +	num_cscd = DIV_ROUND_UP(scen->width,
>> ICE_AQC_ACL_KEY_WIDTH_BYTES);
>> +
>> +	entry_tcam = ICE_ACL_TBL_TCAM_IDX(scen->start);
>> +	idx = ICE_ACL_TBL_TCAM_ENTRY_IDX(scen->start + entry_idx);
>> +
>> +	/* invalidate the flow entry */
>> +	memset(&buf, 0, sizeof(buf));
>> +	for (i = 0; i < num_cscd; i++) {
>> +		err = ice_aq_program_acl_entry(hw, entry_tcam + i, idx,
>> &buf,
>> +					       NULL);
>> +		if (err)
>> +			ice_debug(hw, ICE_DBG_ACL, "AQ program ACL entry
>> failed status: %d\n",
>> +				  err);
>> +	}
>> +
>> +	for_each_set_bit(i, scen->act_mem_bitmap,
>> ICE_AQC_MAX_ACTION_MEMORIES) {
>> +		struct ice_acl_act_mem *mem = &hw->acl_tbl->act_mems[i];
>> +
>> +		if (mem->member_of_tcam >= entry_tcam &&
>> +		    mem->member_of_tcam < entry_tcam + num_cscd) {
>> +			/* Invalidate allocated action pairs */
>> +			err = ice_aq_program_actpair(hw, i, idx,
>> &act_buf,
>> +						     NULL);
>> +			if (err)
>> +				ice_debug(hw, ICE_DBG_ACL, "program actpair
>> failed status: %d\n",
>> +					  err);
>> +		}
>> +	}
>> +
>> +	ice_acl_scen_free_entry_idx(scen, entry_idx);
>> +
>> +	return err;
>> +}
>> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c
>> b/drivers/net/ethernet/intel/ice/ice_acl_main.c
>> index 53cca0526756..16228be574ed 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
>> @@ -280,6 +280,10 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi,
>> struct ethtool_rxnfc *cmd)
>>  		hw_prof->entry_h[hw_prof->cnt++][0] = entry_h;
>>  	}
>>
>> +	input->acl_fltr = true;
>> +	/* input struct is added to the HW filter list */
>> +	ice_ntuple_update_list_entry(pf, input, fsp->location);
>> +
>>  	return 0;
>>
>>  free_input:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
>> b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
>> index 3e79c0bf40f4..21d4f4e3a1d0 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
>> @@ -1791,6 +1791,21 @@ void ice_vsi_manage_fdir(struct ice_vsi *vsi,
>> bool ena)
>>  	mutex_unlock(&hw->fdir_fltr_lock);
>>  }
>>
>> +/**
>> + * ice_del_acl_ethtool - delete an ACL rule entry
>> + * @hw: pointer to HW instance
>> + * @fltr: filter structure
>> + *
>> + * Return: 0 on success, negative on error  */ static int
>> +ice_del_acl_ethtool(struct ice_hw *hw, struct ice_ntuple_fltr *fltr)
>> {
>> +	u64 entry;
>> +
>> +	entry = ice_flow_find_entry(hw, ICE_BLK_ACL, fltr->fltr_id);
>> +	return ice_flow_rem_entry(hw, ICE_BLK_ACL, entry); }
>> +
>>  /**
>>   * ice_fdir_do_rem_flow - delete flow and possibly add perfect flow
>>   * @pf: PF structure
>> @@ -1824,7 +1839,7 @@ ice_fdir_do_rem_flow(struct ice_pf *pf, enum
>> ice_fltr_ptype flow_type)
>>   *
>>   * Return: 0 on success and negative on errors
>>   */
>> -static int
>> +int
>>  ice_ntuple_update_list_entry(struct ice_pf *pf, struct
>> ice_ntuple_fltr *input,
>>  			     int fltr_idx)
>>  {
>> @@ -1843,13 +1858,36 @@ ice_ntuple_update_list_entry(struct ice_pf
>> *pf, struct ice_ntuple_fltr *input,
>>
>>  	old_fltr = ice_fdir_find_fltr_by_idx(hw, fltr_idx);
>>  	if (old_fltr) {
>> -		err = ice_fdir_write_all_fltr(pf, old_fltr, false);
>> -		if (err)
>> -			return err;
>> +		if (old_fltr->acl_fltr) {
>> +			/* ACL filter - if the input buffer is present
>> +			 * then this is an update and we don't want to
>> +			 * delete the filter from the HW. We've already
>> +			 * written the change to the HW at this point, so
>> +			 * just update the SW structures to make sure
>> +			 * everything is hunky-dory. If no input then
>> this
>> +			 * is a delete so we should delete the filter
>> from
>> +			 * the HW and clean up our SW structures.
>> +			 */
>> +			if (!input) {
>> +				err = ice_del_acl_ethtool(hw, old_fltr);
>> +				if (err)
>> +					return err;
>> +			}
>> +		} else {
>> +			/* FD filter */
>> +			err = ice_fdir_write_all_fltr(pf, old_fltr,
>> false);
>> +			if (err)
>> +				return err;
>> +		}
>> +
>>  		ice_fdir_update_cntrs(hw, old_fltr->flow_type, false,
>> false);
>>  		/* update sb-filters count, specific to ring->channel */
>>  		ice_update_per_q_fltr(vsi, old_fltr->orig_q_index,
>> false);
>> -		if (!input && !hw->fdir_fltr_cnt[old_fltr->flow_type])
>> +		/* Also delete the HW filter info if we have just
>> deleted the
>> +		 * last filter of flow_type.
>> +		 */
>> +		if (!old_fltr->acl_fltr && !input &&
>> +		    !hw->fdir_fltr_cnt[old_fltr->flow_type])
>>  			/* we just deleted the last filter of flow_type
>> so we
>>  			 * should also delete the HW filter info.
>>  			 */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c
>> b/drivers/net/ethernet/intel/ice/ice_flow.c
>> index dce6d2ffcb15..144d8326d4f9 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>> @@ -1744,6 +1744,16 @@ static int ice_flow_rem_entry_sync(struct
>> ice_hw *hw, enum ice_block blk,
>>  		return -EINVAL;
>>
>>  	if (blk == ICE_BLK_ACL) {
>> +		int err;
>> +
>> +		if (!entry->prof)
>> +			return -EINVAL;
>> +
>> +		err = ice_acl_rem_entry(hw, entry->prof->cfg.scen,
>> +					entry->scen_entry_idx);
>> +		if (err)
>> +			return err;
>> +
>>  		if (entry->acts_cnt && entry->acts)
>>  			ice_flow_acl_free_act_cntr(hw, entry->acts,
>>  						   entry->acts_cnt);
>> @@ -1879,10 +1889,34 @@ ice_flow_rem_prof_sync(struct ice_hw *hw, enum
>> ice_block blk,
>>  	}
>>
>>  	if (blk == ICE_BLK_ACL) {
>> +		struct ice_aqc_acl_prof_generic_frmt buf;
>> +		u8 prof_id = 0;
>> +
>>  		/* Disassociate the scenario from the profile for the PF
>> */
>>  		status = ice_flow_acl_disassoc_scen(hw, prof);
>>  		if (status)
>>  			return status;
>> +
>> +		status = ice_flow_get_hw_prof(hw, blk, prof->id,
>> &prof_id);
>> +		if (status)
>> +			return status;
>> +
>> +		status = ice_query_acl_prof(hw, prof_id, &buf, NULL);
>> +		if (status)
>> +			return status;
>> +
>> +		/* Clear the range-checker if the profile ID is no
>> longer
>> +		 * used by any PF
>> +		 */
>> +		if (!ice_flow_acl_is_prof_in_use(&buf)) {
>> +			/* Clear the range-checker value for profile ID
>> */
>> +			struct ice_aqc_acl_profile_ranges query_rng_buf =
>> {};
>> +
>> +			status = ice_prog_acl_prof_ranges(hw, prof_id,
>> +							  &query_rng_buf,
>> NULL);
>> +			if (status)
>> +				return status;
>> +		}
>>  	}
>>
>>  	/* Remove all hardware profiles associated with this flow
>> profile */ @@ -2214,6 +2248,44 @@ int ice_flow_rem_prof(struct ice_hw
>> *hw, enum ice_block blk, u64 prof_id)
>>  	return status;
>>  }
>>
>> +/**
>> + * ice_flow_find_entry - look for a flow entry using its unique ID
>> + * @hw: pointer to the HW struct
>> + * @blk: classification stage
>> + * @entry_id: unique ID to identify this flow entry
>> + *
>> + * Look for the flow entry with the specified unique ID in all flow
>> +profiles of
>> + * the specified classification stage.
>> + *
>> + * Return: flow entry handle if entry found, ICE_FLOW_ENTRY_ID_INVAL
>> +otherwise  */
>> +u64 ice_flow_find_entry(struct ice_hw *hw, enum ice_block blk, u64
>> +entry_id) {
>> +	struct ice_flow_entry *found = NULL;
>> +	struct ice_flow_prof *p;
>> +
>> +	mutex_lock(&hw->fl_profs_locks[blk]);
>> +
>> +	list_for_each_entry(p, &hw->fl_profs[blk], l_entry) {
>> +		struct ice_flow_entry *e;
>> +
>> +		mutex_lock(&p->entries_lock);
>> +		list_for_each_entry(e, &p->entries, l_entry)
>> +			if (e->id == entry_id) {
>> +				found = e;
>> +				break;
>> +			}
>> +		mutex_unlock(&p->entries_lock);
>> +
>> +		if (found)
>> +			break;
>> +	}
>> +
>> +	mutex_unlock(&hw->fl_profs_locks[blk]);
>> +
>> +	return found ? ICE_FLOW_ENTRY_HNDL(found) :
>> +ICE_FLOW_ENTRY_HANDLE_INVAL; }
>> +
>>  /**
>>   * ice_flow_acl_check_actions - Checks the ACL rule's actions
>>   * @hw: pointer to the hardware structure @@ -2541,6 +2613,325 @@
>> static int ice_flow_acl_frmt_entry(struct ice_hw *hw,
>>
>>  	return err;
>>  }
>> +
>> +/**
>> + * ice_flow_acl_find_scen_entry_cond - Find an ACL scenario entry
>> that matches
>> + *				       the compared data
>> + * @prof: pointer to flow profile
>> + * @e: pointer to the comparing flow entry
>> + * @do_chg_action: decide if we want to change the ACL action
>> + * @do_add_entry: decide if we want to add the new ACL entry
>> + * @do_rem_entry: decide if we want to remove the current ACL entry
>> + *
>> + * Find an ACL scenario entry that matches the compared data. Also
>> figure out:
>> + * a) If we want to change the ACL action
>> + * b) If we want to add the new ACL entry
>> + * c) If we want to remove the current ACL entry
>> + *
>> + * Return: ACL scenario entry, or NULL if not found  */ static struct
>> +ice_flow_entry * ice_flow_acl_find_scen_entry_cond(struct
>> ice_flow_prof
>> +*prof,
>> +				  struct ice_flow_entry *e, bool
>> *do_chg_action,
>> +				  bool *do_add_entry, bool *do_rem_entry) {
>> +	struct ice_flow_entry *p, *return_entry = NULL;
>> +
>> +	/* Check if:
>> +	 * a) There exists an entry with same matching data, but
>> different
>> +	 *    priority, then we remove this existing ACL entry. Then,
>> we
>> +	 *    will add the new entry to the ACL scenario.
>> +	 * b) There exists an entry with same matching data, priority,
>> and
>> +	 *    result action, then we do nothing
>> +	 * c) There exists an entry with same matching data, priority,
>> but
>> +	 *    different, action, then do only change the action's
>> entry.
> Too much of commas, please reduce the number.
> 
> 
>> +	 * d) Else, we add this new entry to the ACL scenario.
>> +	 */
>> +	*do_chg_action = false;
>> +	*do_add_entry = true;
>> +	*do_rem_entry = false;
>> +	list_for_each_entry(p, &prof->entries, l_entry) {
>> +		if (memcmp(p->entry, e->entry, p->entry_sz))
>> +			continue;
>> +
>> +		/* From this point, we have the same matching_data. */
>> +		*do_add_entry = false;
>> +		return_entry = p;
>> +
>> +		if (p->priority != e->priority) {
>> +			/* matching data && !priority */
>> +			*do_add_entry = true;
>> +			*do_rem_entry = true;
>> +			break;
>> +		}
>> +
>> +		/* From this point, we will have matching_data &&
>> priority */
>> +		if (p->acts_cnt != e->acts_cnt)
>> +			*do_chg_action = true;
>> +		for (int i = 0; i < p->acts_cnt; i++) {
>> +			bool found_not_match = false;
>> +
>> +			for (int j = 0; j < e->acts_cnt; j++)
>> +				if (memcmp(&p->acts[i], &e->acts[j],
>> +					   sizeof(struct ice_flow_action)))
> Due to comment above it should be if (!memcmp(&p->acts[i], &e->acts[j],
> Please fix the comment or code.

I believe the logic is fine, but naming/comments might be a bit confusing.
I'll try to make it more readable.

Thanks,
Marcin

> Otherwise, it looks good.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
>> {
>> +					found_not_match = true;
>> +					break;
> 
> ...
> 
>>  }
>>
>>  /**
>> --
>> 2.49.0
> 


