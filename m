Return-Path: <netdev+bounces-269911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDwLKMFJvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:21:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED92DADEF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E09C63011C5B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D843A640F;
	Fri, 20 Mar 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxXay1q4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD53B6377
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012861; cv=none; b=OYIiRDbj5dODU2jN2XQsTEcmZamkhcp6ozb0Qk17DJ5KXMYI0lwTJbbTuw3Ay1A7GgHueyF/V+QCo0LFMIC8kcy8Iem1+cOGbiUe1JHnfpN6JKctYou/MrcgSWkGegtPSpKRupKwMKlBI1Ws8aDPtN1Q6so8d+4mSnrEMk/FQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012861; c=relaxed/simple;
	bh=PQ6yOqa4PgyAZF4ktQrGNLVKtsw3530HSr+f7H4rcpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GykQg/J38yuxbnFCxq5mRliYrmVIXqHvZqeXf30F678f9tgECcuE5UyE0Yky3KR0vMigzy0dYFbUFHSLPRVutu14YuikN/35vPouWzD2/15+BJlgloT5Ruz3fmWayvTOUE3XV+frTgw8KymaGMD8O0kRp3jEwmv0Z8+qhK6xeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxXay1q4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774012856; x=1805548856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQ6yOqa4PgyAZF4ktQrGNLVKtsw3530HSr+f7H4rcpw=;
  b=WxXay1q4zo8CXb3SExwCGpGGy2pB7crV9fJsitRsNHGNdAyBnTDUkDaV
   oGLzZ00HN6QAxh85EOQjpnMFOYgHtLx+oPopM0YLLj6QmLZZBs+02FD+e
   B/B1Nt0LhoBaD5SdlGHzMejUwFIajYCL4r31br1ZxetjWYbYfFwg5kW0M
   bQJSI6Ig+TfNAGoHPU5JcfmTdL3cwfLsHyjBWRCTALsWw/2vCpBq97zAg
   aSIsjnJ82ozl8CdxrrkUJ8vp0M3dbO5jSyb7mA7+bt+vpClwQLSyDcd4v
   TD/AAayFT/Ioce0pjLEsWiOo5ixIf08JBNUqtyRfFjzOMQRVljvA9ynpE
   g==;
X-CSE-ConnectionGUID: W54jYpMFSciCZ+Q7L9/igA==
X-CSE-MsgGUID: Cg8JVK5fT7OSxq/iGKuSpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85722706"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85722706"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:20:55 -0700
X-CSE-ConnectionGUID: YB/3+kZyQZOx90BORRLQcQ==
X-CSE-MsgGUID: 02YQOKTsRDmxZwYCT/OZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227409603"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.17.139]) ([10.246.17.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:20:53 -0700
Message-ID: <ea943092-d0a2-4a93-b6f2-72fcad8f9914@linux.intel.com>
Date: Fri, 20 Mar 2026 14:20:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix allocating excessive
 memory in ice_create_lag_recipe()
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
References: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269911-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17ED92DADEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20.03.2026 06:05, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>

ACK

> For some reason ice_create_lag_recipe() allocates an array of 64
> struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
> Fix it, while also using kzalloc_obj().
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 310e8fe..70357dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
>  	if (err)
>  		return err;
>  
> -	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
> +	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
>  	if (!new_rcp)
>  		return -ENOMEM;
> 
>  	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
>  


