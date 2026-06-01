Return-Path: <netdev+bounces-293666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JeODg9XHWpLZQkAu9opvQ
	(envelope-from <netdev+bounces-293666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E261CDFD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5654C302989A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB6395AE1;
	Mon,  1 Jun 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1eo05PU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45638887D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307128; cv=none; b=Ujcuet/TaTSmhpzL/t0bIqijsYW/+fURvKm70NscHKQzxSGxPgvXlrR9Z/60VE9iQnqlvUPeUEmIVOwnXxdPM2uvd+Jzrkd0p+VG9FmimjpI353ceKyP2wVQFqQbdPjEFZGJIpAHNSKC85qEmeG5KYGhsBr6y6MJ8PA4Y+WOvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307128; c=relaxed/simple;
	bh=l0Picw4fs18nY9Kv0T1KHBRrF4f6NuQCKc3xyRlXbls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOQ1+N+y8XzthRp0mWhqf1eD+sWIeGt13oM2FXTVzBIbV3KQHMHhKKptHmqEZv4DnB97nm3z2Wl+eJ0VnQg0V8/BrrybvJNmbbHr1txX4l07pYol4FpUf/xsEp+LDNJPNc66MbkWpY9YaGPECEiUt9zvuOf4sOupFWK8GnnT7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1eo05PU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780307122; x=1811843122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0Picw4fs18nY9Kv0T1KHBRrF4f6NuQCKc3xyRlXbls=;
  b=n1eo05PUO7xl5q8GAuWo/42ohkTRZG5qGRfSR1vN9lDE5D508SLQ+s/D
   MZCKJt1IAthy9VlkxMJ8kc5phk/Nsb/E5HTkXEo4qvq8oT06JR0y3myI6
   8RkxkbmHZu99RSCBOjKb7vo5BrrSMsH0j35e3+84FwO3/1O/xLlK1Nw4h
   lbtVGvCsGiZ+UY8t2QtXgR82blZ/yNoon7tjzLUGL7b0ZlxSXBxP0sxzx
   wp4Q8UnmI6Y3j1nHPBKkYAigfmwRfVkEFXttZuRxXYjFoyGzpDQytYpLf
   KHdUeEjm+6+FlkdP/PiJqROc7eOzXjcL3ly4E07hYYpOrj2AjlWlkc61j
   w==;
X-CSE-ConnectionGUID: Gam7uwZ8T/Gf5JovnlxCaA==
X-CSE-MsgGUID: Mj25cTVuTcSpkWlOv60L1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80200919"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80200919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:45:21 -0700
X-CSE-ConnectionGUID: E6yG66ftRvi6/K+HeqJKCg==
X-CSE-MsgGUID: BeD92rN9Tn6kVMq9VYNI5A==
X-ExtLoop1: 1
Received: from unknown (HELO [10.217.160.157]) ([10.217.160.157])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:45:20 -0700
Message-ID: <cf39b55c-f9f2-4944-9ca3-14c6a1bff7de@linux.intel.com>
Date: Mon, 1 Jun 2026 11:45:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org
References: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293666-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 7B7E261CDFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 09:18, Aleksandr Loktionov wrote:
> set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
> ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
> providing ptype >= 1024 through VIRTCHNL, resulting in a write past
> the end of the bitmap and a kernel page fault.
> 
> Reproduced with a custom kernel module injecting a crafted
> VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
> FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
> kernel 7.1.0-rc1.
> 
> crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
> crash_parser: setting ptype=0xffff (max valid=1023)
> crash_parser: calling ice_parser_profile_init -- expect OOB crash!
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> Oops: Oops: 0002 [#1] SMP NOPTI
> CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
> Hardware name: Intel Corporation S2600BPB/S2600BPB
> RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
> Call Trace:
>  <TASK>
>  ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
>  crash_init+0x127/0xff0 [crash_parser]
>  do_one_initcall+0x45/0x310
>  do_init_module+0x64/0x270
>  init_module_from_file+0xcc/0xf0
>  idempotent_init_module+0x17b/0x280
>  __x64_sys_finit_module+0x6e/0xe0
> 
> Bail out early with -EINVAL when ptype is out of range.
> 
> Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index f8e6963..3ede4c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
>  	u16 proto_off = 0;
>  	u16 off;
>  
> +	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
> +		return -EINVAL;
> +
>  	memset(prof, 0, sizeof(*prof));
>  	set_bit(rslt->ptype, prof->ptypes);
>  	if (blk == ICE_BLK_SW) {


