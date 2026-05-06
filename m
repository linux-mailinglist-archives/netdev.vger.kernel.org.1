Return-Path: <netdev+bounces-284824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF4wBUI6+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9354DA946
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA56430701A9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241344418D7;
	Wed,  6 May 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eavvO+vW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C034FF4F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071858; cv=none; b=pVnlo7PZ59NPGv4btZ5wRJTred2aytmgrg4NbTKEWyG4oETZ7e3Pn/VVWJdiqsIFvynDxr7B3JOdwH+6OdfIbeXdWvS9d6NCNL+TpyQS1T8PqvTDEYJxzqxYK49ePUCppe3aWs5i5lncFQ+QDyIU3ODGYOv/e1/+Qx0kK0PH97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071858; c=relaxed/simple;
	bh=AjOnaNgsiOWj0vDA4OPhCCW+AJRwz5CExSuQwVUS5iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYiskkm8GOTUvQWucafC2ir7KzDyFBaTayB833sQ2lbTIsX5uSja2nErLD5gxrSHEwd4HJYOVQPZ7zaVqQJQuaPLuPiJAkMxeq43OWNPKFTmvHBJqGBrwKFKQPSuTUsNDGVyaQU4GmScJ6UVV0NV6nMbEA8p0ZtX8zCXZHt4YJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eavvO+vW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778071857; x=1809607857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AjOnaNgsiOWj0vDA4OPhCCW+AJRwz5CExSuQwVUS5iY=;
  b=eavvO+vWPRC3UU+Bwn6k3sZVd6UQ1Od6CnjDN5F8PkY+gmMl1ZZOedgi
   NCEYuUdADPZdm0A2XkrEyBa1E0miqBSkwNkrgaraTQUl0kRVTbbetOAAL
   NB5h7wonP74t6sACTYFEbBuviVa+yIIuwRfg8FgxUqfvWp65J+f85gnh0
   +v4iioVBdUbn4r+fvzFociriudZdRv6zAa9t9TCROCfpGwv/453VFBYZm
   t1PcYyqOLJTz4uljbs+APOCSNRc72WP+UW7tb8oYl1imcmACHeoMzDsys
   fRIYHTgoU+yVlCjaIykakSLg1vSE7XtdjRwLaIyVpbF1XIkfiE62gD/Vz
   g==;
X-CSE-ConnectionGUID: tMKYJ8GsSvWO05fxL4muGA==
X-CSE-MsgGUID: jXc0z0W6TzGBBCeNRuQ7sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78848500"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78848500"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:50:56 -0700
X-CSE-ConnectionGUID: 158reD9IR/aWxx3kTHcTBg==
X-CSE-MsgGUID: ShPOC7/pQyO8IN62ZE0ukg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="274267198"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.161.2]) ([10.217.161.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:50:54 -0700
Message-ID: <af025816-d5bb-40b7-a776-36ea4e05221a@linux.intel.com>
Date: Wed, 6 May 2026 14:50:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 00/10] Add ACL support
To: intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3E9354DA946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284824-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,sashiko.dev:url]

This patchset has been applied to dev-queue, however there were a lot of potential
issues reported by sashiko [1] that I'm currently addressing. In my opinion a lot of them
are valid, so I'm planning to submit v3 soon.

[1] https://sashiko.dev/#/patchset/20260409120003.2719-1-marcin.szycik%40linux.intel.com

On 09/04/2026 13:59, Marcin Szycik wrote:
> E8xx hardware provides a Ternary Classifier block for implementing
> functions such as ACL (Access Control List). In this series it's simply
> referred to as "ACL".
> 
> Implement ACL filtering. This expands support of network flow classification
> rules for the ethtool ntuple command. ACL filtering allows for an ip or port
> field's optional mask to be specified.
> 
> Example filters:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -1
> 
> This is a resurrection of an old series from 2020 [1] with several
> improvements, but the fundamental logic unchanged. v1 was almost pulled
> in, but ultimately it was decided to drop it [2] because of unresolved
> issues. One issue was too many defensive NULL checks. Second issue is
> about inconsistency when using multiple input sets. Both are addressed
> in this patchset.
> 
> More about the second issue:
> 
> From [3]:
>> I would argue that you need to have some sort of logic that basically
>> checks to see if you are going to hit the input set issue and falls
>> back and applies the ACL rules. Otherwise you are significantly
>> hampering the usefulness of this filter type. It doesn't make sense
>> that dropping a field will cause a rule to fail to be added, but
>> masking a single bit in some field will make it valid. It would make
>> it a nightmare to use from the user point of view as the rules come
>> across as arbitrary.
> 
> Flow Director (FD) has a hardware limitation where all filters for the same
> packet type must use identical input sets. Previously, attempting to add the
> second filter would fail.
> 
> Patch 10 adds automatic fallback to ACL block when FD cannot accommodate a
> filter due to input set conflicts, which resolves this inconsistency.
> 
> v2:
> * Rebase. Notable conflicts were the removal of ice_status and the addition of
>   libie (which affected AdminQ communication)
> * Reduce the number of defensive NULL checks
> * Use = {} instead of memset for definitions
> * Use kzalloc_obj() instead of plain kzalloc()
> * Move from devm_ to plain allocation for objects that don't require it
> * Move iterator declaration to loop start
> * Move some defines out of structs
> * Fix kdoc (except untouched ice_ethtool_fdir.c functions)
> * Adjust style (err for return variable, spacing, rewrite some comments,
> * commit messages)
> * Remove overly verbose comments
> * Add patches 5, 6, 9 and 10
> * More changes listed in patches (if applicable)
> 
> [1] https://lore.kernel.org/intel-wired-lan/20200914153720.48498-1-anthony.l.nguyen@intel.com
> [2] https://lore.kernel.org/netdev/7192efe4d27c93148b3205e65f37203c89170316.camel@intel.com/#t
> [3] https://lore.kernel.org/netdev/CAKgT0Ucxd5-gvEwWAdbL04ER2o++RX_oekUV3E0rYquEgFKj1w@mail.gmail.com
> 
> Lukasz Czapnik (1):
>   ice: use ACL for ntuple rules that conflict with FDir
> 
> Marcin Szycik (3):
>   Revert "ice: remove unused ice_flow_entry fields"
>   ice: use plain alloc/dealloc for ice_ntuple_fltr
>   ice: re-introduce ice_dealloc_flow_entry() helper
> 
> Real Valiquette (5):
>   ice: initialize ACL table
>   ice: initialize ACL scenario
>   ice: create flow profile
>   ice: create ACL entry
>   ice: program ACL entry
> 
> Tony Nguyen (1):
>   ice: rename shared Flow Director functions and structs
> 
>  drivers/net/ethernet/intel/ice/Makefile       |    5 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   21 +-
>  drivers/net/ethernet/intel/ice/ice_acl.h      |  170 +++
>  drivers/net/ethernet/intel/ice/ice_acl_main.h |    9 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  391 +++++-
>  drivers/net/ethernet/intel/ice/ice_arfs.h     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   18 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |    2 +
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   39 +-
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |    3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |    5 +
>  drivers/net/ethernet/intel/ice/ice_acl.c      |  486 +++++++
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 1111 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_acl_main.c |  293 ++++
>  drivers/net/ethernet/intel/ice/ice_arfs.c     |    8 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |    8 +-
>  ...ce_ethtool_fdir.c => ice_ethtool_ntuple.c} |  641 ++++++---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |   30 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   11 +-
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 1208 ++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   10 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   91 +-
>  drivers/net/ethernet/intel/ice/virt/fdir.c    |   32 +-
>  23 files changed, 4344 insertions(+), 250 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
>  rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (79%)
> 


