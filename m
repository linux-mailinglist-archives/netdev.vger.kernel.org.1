Return-Path: <netdev+bounces-269910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLkCGVNJvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:19:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF822DAD94
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3A1300E58C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C03B19D0;
	Fri, 20 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQnbD86j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57B3AEF32
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012752; cv=none; b=b5MFz+26rViba9w72UdhjpxJgOuwrdf+hMb8PU0nQ/IhktU7cOOFgSBkz69DmzGXjmYWmfTGkYWjeadNYuWUP9voCfQ1lp+zW/Uf8Yz8yCPh5raoc2HhUp3/EM9Ch1mn31ikiK/0vMBoP8nhvcG9XcOdptG3N9Afani7Rag3/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012752; c=relaxed/simple;
	bh=qZa3UKNeYYMd21cN91QyetESTuvn9ZfMASz3YdI2F6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XImzIclXCzQYKEcDu/28zG40iYRFg3lyeX1JsdZcxft+/1jSfLGw9jnjcAI1ziIo57X2ZWZvjYQ85Kx6PVRFuo15C2ynpTmjsktHyhE1QDabgFnJsRvNxzsSyLIlMcLP3NOQutOtWtOFRn4MD/ypNTJXFjIVEP1NwIy22RpuHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQnbD86j; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774012750; x=1805548750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qZa3UKNeYYMd21cN91QyetESTuvn9ZfMASz3YdI2F6c=;
  b=KQnbD86jhd48tWS2bHsh4PSzO3QXYNcQwVVvTgN70ogOvaiDHv2s8Xwl
   7T5U9IQwXmA1cDUBavEUvR6uSFed1r+diq9wqpchDLOtCrDNcglPsqZEj
   AbckMu/yl6VFJcXM42G1EBqOxjB+L7RCjyzGtv05ER/OcwVGKpXOY6J3I
   LElbiEjyTKPh09/7crb0LtJphIDc0lgXp26pljnwhk6bl4rc68fZDM73J
   oMcNzqkpkYHfhkn5Uog9xGu4Z1nImXFHESTcAm3uCmZpzpzplBg2y+kMY
   Z36jO6RKij1ldKOgBaR5kEFmSzGT+JexH9b6c1xaNxxkGsKGs/ozohJJv
   Q==;
X-CSE-ConnectionGUID: MH6TN5KwQsiORZ03awV12A==
X-CSE-MsgGUID: vlrV3abmShemoAHFaaRX+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85722484"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85722484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:19:09 -0700
X-CSE-ConnectionGUID: Lx423qDxSKu/l1MtS1QhTQ==
X-CSE-MsgGUID: USvdCJOpRS2ELwjrPwdxxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227409341"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.17.139]) ([10.246.17.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:19:07 -0700
Message-ID: <ccac99ca-4a9e-4997-adf4-2eee389d60cc@linux.intel.com>
Date: Fri, 20 Mar 2026 14:18:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: use ice_fill_eth_hdr() in
 ice_fill_sw_rule()
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
References: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269910-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 1DF822DAD94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20.03.2026 06:05, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>

ACK

> Use the already existing helper function to fill Ethernet header. Also
> replace sizeof with a (also existing) macro to reduce the number of
> variables.
> 
> Suggested-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index bb0f990..6496534 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -2612,7 +2612,6 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
>  	u16 vlan_id = ICE_MAX_VLAN_ID + 1;
>  	u16 vlan_tpid = ETH_P_8021Q;
>  	void *daddr = NULL;
> -	u16 eth_hdr_sz;
>  	u8 *eth_hdr;
>  	u32 act = 0;
>  	__be16 *off;
> @@ -2625,11 +2624,10 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
>  		return;
>  	}
>  
> -	eth_hdr_sz = sizeof(dummy_eth_header);
>  	eth_hdr = s_rule->hdr_data;
>  
>  	/* initialize the ether header with a dummy header */
> -	memcpy(eth_hdr, dummy_eth_header, eth_hdr_sz);
> +	ice_fill_eth_hdr(eth_hdr);
>  	ice_fill_sw_info(hw, f_info);
>  
>  	switch (f_info->fltr_act) {
> @@ -2730,7 +2728,7 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
>  
>  	/* Create the switch rule with the final dummy Ethernet header */
>  	if (opc != ice_aqc_opc_update_sw_rules)
> -		s_rule->hdr_len = cpu_to_le16(eth_hdr_sz);
> +		s_rule->hdr_len = cpu_to_le16(DUMMY_ETH_HDR_LEN);
>  }
>  
>  /**


