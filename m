Return-Path: <netdev+bounces-301136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D8kvDlM/OWrkpAcAu9opvQ
	(envelope-from <netdev+bounces-301136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53E6B0146
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:57:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ljGgCYc1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301136-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6810301F4C9
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B83B47CA;
	Mon, 22 Jun 2026 13:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94D3B6349;
	Mon, 22 Jun 2026 13:52:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136376; cv=none; b=VbWkSu5bDGmpkinI+EB5kmH+z7ZrNGowkNTzyDlrJTPQdIsHHjuwAF/NwQTXHONY0BBlcB6utVKZ/dGEdO9EIaXNCKJhIgTCnDrfffytNnPUEGTTQRh2dQTqvy9EB3oP8BEA+1rL9M28bIUQAo6P9sdpyLDmrS70ugeSY51KSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136376; c=relaxed/simple;
	bh=8IGxnFLIvHPA5eCvzWhuRYe0PBGao496jKdiz07JBDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtNhdsUWn2z2cBOn9FSNBQzNAq9HkNbKhPKZ5my9JkHh+Hvg0ZpmOI7tVFThbe6MZacEROhvvh+J7znNTwfdPFA9FNU1QLiGJdhTx+OjISse01JiD4Amt7T7xRclJkduFpqtVIMG9mUOaQWiS9iMfyLsw83GX76tXM5OUPBbsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljGgCYc1; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782136375; x=1813672375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8IGxnFLIvHPA5eCvzWhuRYe0PBGao496jKdiz07JBDk=;
  b=ljGgCYc1YS8EI0a0lFB9FSanQiITbmj8bSsBv1mzD0acjCCi161mNltC
   V2WQRhm7B9ZWolO1/GCYugvsepzvd7ktQ3rojFZbA9FUtE7Xx1eEyLbAC
   MfeOoVL0Q2+CR2UNroqrs5IT5dRc7tNq6unnMjyaFFq2W27y60cv6otgf
   T2Q6byymInPuC/hGkRS5Id7u372rMeHCBRWKGIZqIxndOYbGiDyUGPZbV
   4LVKQ74wxx2+KrHg7dyuwp0VXrfy1VpXGBcRJszhXgFcfGIkh5ptMj0pt
   Gy0KuAgROCcczAIfKlReVu+skR0SaI3b4SgALjwfzv59AKmE85NMduJJL
   Q==;
X-CSE-ConnectionGUID: DX0Mz6O8QMW48KbyGyy+MA==
X-CSE-MsgGUID: PGAKl1N2ROmRXze2Ofs1zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82874531"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82874531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 06:52:55 -0700
X-CSE-ConnectionGUID: TorE0h44SyapVDUhwFe1qA==
X-CSE-MsgGUID: Rlf3rkzbS+GNN13FUSGUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="253133706"
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 06:52:51 -0700
Message-ID: <4dc1eb2d-e69f-4f13-ab08-ed0077305098@linux.intel.com>
Date: Mon, 22 Jun 2026 15:52:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
References: <20260622081030.2312129-1-poros@redhat.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260622081030.2312129-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301136-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:poros@redhat.com,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:michal.swiatkowski@linux.intel.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:intel-wired-lan@lists.osuosl.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F53E6B0146



On 22/06/2026 10:10, Petr Oros wrote:
> When a VSI is configured as the switch's default forwarding VSI
> (ICE_SW_LKUP_DFLT) and is then torn down, the rule is left behind in
> the switch. ice_vsi_release() no longer removes it, and the SR-IOV VF
> free path (ice_free_vfs() -> ice_free_vf_res() -> ice_vf_vsi_release()
> -> ice_vsi_release()) does not disable promiscuous mode either, which
> only happens on VF reset in ice_vf_clear_all_promisc_modes().
> 
> A trusted VF that enters unicast promiscuous mode becomes the default
> forwarding VSI (this is the default mode, when the PF does not have VF
> true-promiscuous mode enabled). If the VFs are then destroyed without
> the VF first leaving promiscuous mode, the ICE_SW_LKUP_DFLT rule for
> the now-freed VSI is leaked. When VFs are recreated, a VSI reuses the
> freed hw_vsi_id. If it is assigned a different VSI handle than the
> leaked rule holds, ice_set_dflt_vsi() does not recognize it as
> already-default, and ice_add_update_vsi_list() folds the dangling
> (freed) handle into a VSI list, which the firmware rejects. The VSI
> handle assigned on re-creation varies, so the failure is intermittent
> rather than every cycle.
> 
> Reproduce by repeatedly running the cycle below on the two ports of the
> same card, where $VF0 and $VF1 are the netdevs of vf 15 once they
> appear. The VF must be brought up so iavf actually pushes the unicast
> promiscuous request, and the rule must settle before the VFs are torn
> down again:
> 
>   echo 16 > /sys/class/net/$PF0/device/sriov_numvfs
>   echo 16 > /sys/class/net/$PF1/device/sriov_numvfs
>   ip link set $PF0 vf 15 trust on
>   ip link set $PF1 vf 15 trust on
>   ip link set $VF0 up
>   ip link set $VF1 up
>   ip link set $VF0 promisc on
>   ip link set $VF1 promisc on
>   sleep 1
>   echo 0 > /sys/class/net/$PF0/device/sriov_numvfs
>   echo 0 > /sys/class/net/$PF1/device/sriov_numvfs
> 
> Within a few cycles the ice PF and iavf VF log:
> 
>   Failed to set VSI 25 as the default forwarding VSI, error -22
>   Turning on/off promiscuous mode for VF 63 failed, error: -22
>   PF returned error -53 (IAVF_ERR_ADMIN_QUEUE_ERROR) to our request 14
> 
> This cleanup used to live in ice_vsi_release() but was dropped by the
> referenced refactor. Restore it. Clear the default forwarding VSI rule
> in ice_vsi_release() when this VSI owns it, which covers every teardown
> path.
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 2717cc31bff8fe..408464434506ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2872,6 +2872,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>  		return -ENODEV;
>  	pf = vsi->back;
>  
> +	if (ice_is_vsi_dflt_vsi(vsi))
> +		ice_clear_dflt_vsi(vsi);

In the referenced commit, the chunk of code that contained these missing 2 lines
was moved to ice_vsi_decfg(). It also sounds like a good place for them and will
be called from ice_vsi_release(). Are you sure we should place them directly in
ice_vsi_release() instead?

Thanks,
Marcin

> +
>  	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>  		ice_rss_clean(vsi);
>  


