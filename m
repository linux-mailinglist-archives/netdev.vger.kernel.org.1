Return-Path: <netdev+bounces-135481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527499E0F4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13D8B22D1E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25E1CACDB;
	Tue, 15 Oct 2024 08:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75C18A6A5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980685; cv=none; b=rrUUiSH10rdWcafBTD8p1Basr5940YlT2e0x+qOz67cyZvgPVr5Ubj+2DKTHNEPCDZzcvSQhC5CRRDdtcM9A6cU4BDaaWVAghppWcj20zqIu0yzIJjiABogw22aI0tzy6KZjPUYlm51dGsVJ1Jq3co/q3ry5r/6VCh0WpvnfKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980685; c=relaxed/simple;
	bh=U12twqqAqBGuXxrAXYg8jGWFyDjPFj/J1idTgXJJG1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zcgr6IB+DjEOH39yJhy0ue1ROxp6eEmy3Bm8bq18IDJd3zbt35Cp8InCIGxMJLUpGM2Kk5B9KKyRZyME3jATNpVSHvJR6ThNP+PjiXVgAJNsCa8o12N3GRvzs8XFkrCflDP28ViNrL99AQFTfo73QC9mLzmBSoCp8atGxagXLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6AB4461E5FE05;
	Tue, 15 Oct 2024 10:24:20 +0200 (CEST)
Message-ID: <011cfa1f-d7df-4d38-ba5d-7820176ebf8b@molgen.mpg.de>
Date: Tue, 15 Oct 2024 10:24:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix "Error
 I40E_AQ_RC_ENOSPC adding RX filters on VF" issue
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <20241015070450.1572415-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241015070450.1572415-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Thank you for your patch. For the summary I’d make it more about the 
action of the patch like “Add intermediate filter to …”.


Am 15.10.24 um 09:04 schrieb Aleksandr Loktionov:
> Fix a race condition in the i40e driver that leads to MAC/VLAN filters
> becoming corrupted and leaking. Address the issue that occurs under
> heavy load when multiple threads are concurrently modifying MAC/VLAN
> filters by setting mac and port VLAN.
> 
> 1. Thread T0 allocates a filter in i40e_add_filter() within
>          i40e_ndo_set_vf_port_vlan().
> 2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
>          i40e_ndo_set_vf_mac().
> 3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
>          refers to the already freed filter memory, causing corruption.
> 
> Reproduction steps:
> 1. Spawn multiple VFs.
> 2. Apply a concurrent heavy load by running parallel operations to change
>          MAC addresses on the VFs and change port VLANs on the host.

It’d be great if you shared your commands.

> 3. Observe errors in dmesg:
> "Error I40E_AQ_RC_ENOSPC adding RX filters on VF XX,
>   please set promiscuous on manually for VF XX".

I’d indent it by eight spaces and put it in one line.

> The fix involves implementing a new intermediate filter state,
> I40E_FILTER_NEW_SYNC, for the time when a filter is on a tmp_add_list.
> These filters cannot be deleted from the hash list directly but
> must be removed using the full process.

Please excuse my ignorance. Where is that done in the diff? For me it 
looks like you only replace `I40E_FILTER_NEW` by `I40E_FILTER_NEW_SYNC` 
in certain places, but no new condition for this case.

> Fixes: 278e7d0b9d68 ("i40e: store MAC/VLAN filters in a hash with the MAC Address as key")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
>   drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 ++
>   drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++--
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 2089a0e..a1842dd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -755,6 +755,8 @@ enum i40e_filter_state {
>   	I40E_FILTER_ACTIVE,		/* Added to switch by FW */
>   	I40E_FILTER_FAILED,		/* Rejected by FW */
>   	I40E_FILTER_REMOVE,		/* To be removed */
> +	/* RESERVED */

Why the reserved comment? Please elaborate in the commit message.

> +	I40E_FILTER_NEW_SYNC = 6,	/* New, not sent, in sync task */
>   /* There is no 'removed' state; the filter struct is freed */
>   };
>   struct i40e_mac_filter {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index abf624d..1c439b1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -89,6 +89,8 @@ static char *i40e_filter_state_string[] = {
>   	"ACTIVE",
>   	"FAILED",
>   	"REMOVE",
> +	"<RESERVED>",
> +	"NEW_SYNC",
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 25295ae..55fb362 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1255,6 +1255,7 @@ int i40e_count_filters(struct i40e_vsi *vsi)
>   
>   	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
>   		if (f->state == I40E_FILTER_NEW ||
> +		    f->state == I40E_FILTER_NEW_SYNC ||
>   		    f->state == I40E_FILTER_ACTIVE)
>   			++cnt;
>   	}
> @@ -1441,6 +1442,8 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
>   
>   			new->f = add_head;
>   			new->state = add_head->state;
> +			if (add_head->state == I40E_FILTER_NEW)
> +				add_head->state = I40E_FILTER_NEW_SYNC;
>   
>   			/* Add the new filter to the tmp list */
>   			hlist_add_head(&new->hlist, tmp_add_list);
> @@ -1550,6 +1553,8 @@ static int i40e_correct_vf_mac_vlan_filters(struct i40e_vsi *vsi,
>   				return -ENOMEM;
>   			new_mac->f = add_head;
>   			new_mac->state = add_head->state;
> +			if (add_head->state == I40E_FILTER_NEW)
> +				add_head->state = I40E_FILTER_NEW_SYNC;
>   
>   			/* Add the new filter to the tmp list */
>   			hlist_add_head(&new_mac->hlist, tmp_add_list);
> @@ -2437,7 +2442,8 @@ static int
>   i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
>   			  struct i40e_mac_filter *f)
>   {
> -	bool enable = f->state == I40E_FILTER_NEW;
> +	bool enable = f->state == I40E_FILTER_NEW ||
> +		      f->state == I40E_FILTER_NEW_SYNC;
>   	struct i40e_hw *hw = &vsi->back->hw;
>   	int aq_ret;
>   
> @@ -2611,6 +2617,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>   
>   				/* Add it to the hash list */
>   				hlist_add_head(&new->hlist, &tmp_add_list);
> +				f->state = I40E_FILTER_NEW_SYNC;
>   			}
>   
>   			/* Count the number of active (current and new) VLAN
> @@ -2762,7 +2769,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>   		spin_lock_bh(&vsi->mac_filter_hash_lock);
>   		hlist_for_each_entry_safe(new, h, &tmp_add_list, hlist) {
>   			/* Only update the state if we're still NEW */
> -			if (new->f->state == I40E_FILTER_NEW)
> +			if (new->f->state == I40E_FILTER_NEW ||
> +			    new->f->state == I40E_FILTER_NEW_SYNC)
>   				new->f->state = new->state;
>   			hlist_del(&new->hlist);
>   			netdev_hw_addr_refcnt(new->f, vsi->netdev, -1);


Kind nregards,

Paul

