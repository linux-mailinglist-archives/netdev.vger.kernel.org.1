Return-Path: <netdev+bounces-302601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NGTyGHlhQmqU5wkAu9opvQ
	(envelope-from <netdev+bounces-302601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:13:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB26D9EA5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:13:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DIedX7mE;
	dkim=pass header.d=redhat.com header.s=google header.b=KXc8DLuC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302601-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3399430004F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D23400DEF;
	Mon, 29 Jun 2026 12:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928A3FE674
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:09:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734942; cv=none; b=Ne2y2sD+yTZ3LU3tQ4dc/JR1lNkerbWpWXVleQAAESqVYABYM3Cy2YVzTnRuw6o3iH1NvSrm/7LJb4OWNnbf678pCts0krKGvhoOSEB2ihIt/V5FFETkRD2P9La/ruePcp3dieN6c8mvKQyFyZ0sRUNEPxUijPmtRKJEU4LdzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734942; c=relaxed/simple;
	bh=/TCM9zv+wLwELsviIpMFpvSpLicPZkNmd2fkjXrN9R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drr9Pr7gxpPYV+jc92u+mtwIBxNDSqKqy7xVyBemQ0TyArd5q6HUMZDzAOvVOI4A66c+aPP+7XHKLcITvfxx+omVM5RGapYzOwPb2kf+ZQ+UpSrXJmeL153xq1xqtTzr6b+ySQfaJDTw+ngo5QLNMNpMxK9ArI4OWdZHr8wTlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIedX7mE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXc8DLuC; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782734939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiYhLHlcjxd8mY4ZIXeTTCzvjXYSje0VSPco7CIYYbA=;
	b=DIedX7mEz2cXhnuKAMXkNAT2Khm9zugnY1V+ggTYO2oM+TVZdOUZ27bBcGvlkAzJrxIC1g
	0vggR+TJHWAxxnH4cSFCr/UehHmZbRtFUzbGrQOhCHgqNt3nZCgymOZSGFdbMvvOtfqntf
	FiV6V8f5dOu4epGGRjhaMrSx/p//onE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QkX4Wrc3Pc-ZZQ9hB7dh2g-1; Mon, 29 Jun 2026 08:08:57 -0400
X-MC-Unique: QkX4Wrc3Pc-ZZQ9hB7dh2g-1
X-Mimecast-MFC-AGG-ID: QkX4Wrc3Pc-ZZQ9hB7dh2g_1782734936
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69843ac68d0so1867096a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782734936; x=1783339736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiYhLHlcjxd8mY4ZIXeTTCzvjXYSje0VSPco7CIYYbA=;
        b=KXc8DLuC4qDfAjS1wQWCTvxd8hJC9nxO2mI3afKlHcI0DgTlB++IQROP8Gk5mc882c
         XoOZpfSbN62pBBOhhATRPEj4FWOk8TmQE2YeBlOqxrYC9Ah/RKnMAsx7NyvvVkkf7h1c
         1lQJOkyBmLNZC5nRoWSEyLQS14uVogIaYtIu0tjvfl80JgkvHqUefpM8/0MYV2G+x0yC
         fQrOWKiGWHXqJpn/hw6k7I4pygzFI3tLsReaPwEXmjG4hw4VgJuLeQ1QiyOX2PWxb0zX
         xYDyVcoQ9wpr12RI3Bqmvs9+Jiy8U5Op1tCD3ALPrXDrTiRsEHc5yjjMHNHLHFvYwkZH
         1uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734936; x=1783339736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiYhLHlcjxd8mY4ZIXeTTCzvjXYSje0VSPco7CIYYbA=;
        b=cRgHG8Fqm1CRjiGOjOrAuIO7G2GxUfImXhcfTjjw+tALCqKUnByDesZlJvpf98gAhn
         MFsZIrPwzan3cwAlGhEX9L+UVDKxiBhY25H8LMmogFAFdrTyjkz8tNjmXgKi0XLzH8gA
         LaTThsTjutXkkMTfN6YZ5E2k3UBOUDpan+wscbREqcQ0/InSUuNvJe+/E40hjbw0GWOs
         qlCv4dvYQAc23NGF0d2/zE+KZFhheGn9LlZHkhVTJlSBROzCeQoJq7M62eXz8DDKv5pu
         mhOHwZy7ovIuoJTe2TTvvvs3+8nI6ayR7DN/20S/ofHox5Q5xtdYvVndJcITEj0f2uWg
         cl0A==
X-Gm-Message-State: AOJu0YxkRt7mPfDTWYvQf9lBAhsiNjqyzoFslzjYPCPBilA0q81DJ/En
	7jf70kwDC2rpULizOWJEHX2+yyy0No2xLovfV4PFNDhRg8zeHYiErYcK0bYrfDshjtwhy13zSY9
	0mTt/SDkW8vxNVc96gB475O3NaFMumKO55a+YX6pHQHYLt59RBz/RFu6N5A==
X-Gm-Gg: AfdE7cmLg2TT3/y7iUFWKH7L5OPBQviiRKT3iupqD4zRG+acpnUXdLMWx/R8vvdWfi5
	NK9JP9TJG+4dSadb0Cn/vuJlOCc6v/AKopryiRC4Wrt7YwbGhJuplM3g0hNhYKLHe2MDQwFD1WY
	OplidPoSMJT0aeCltLDdafhjzaDtDmcps6lcnrF0ekHZ8iupMaxUIbugMCNlfaNaQ2l57Ku4W3I
	UdiO08HdKtxbJH4mIogaqKE3fLIIyAlFBiGAke8doqC01XOpJcr27ixZe3rE1J2ZUdWxa+KNfge
	OZHDHfxesGTM2ekKFOE23ZPy7Oc9ucU1Xb3iyaJXrITgN+NAgLWyQ5uyp/T7c+UPW6azM5tnQgd
	hTzkiQTJ0Gg==
X-Received: by 2002:a05:6402:a512:20b0:698:1504:4cd8 with SMTP id 4fb4d7f45d1cf-69815044e39mr3991866a12.29.1782734936249;
        Mon, 29 Jun 2026 05:08:56 -0700 (PDT)
X-Received: by 2002:a05:6402:a512:20b0:698:1504:4cd8 with SMTP id 4fb4d7f45d1cf-69815044e39mr3991864a12.29.1782734935702;
        Mon, 29 Jun 2026 05:08:55 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc6713sm6857124a12.23.2026.06.29.05.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:08:54 -0700 (PDT)
Message-ID: <3af161de-b79a-49dc-a2fa-48e182b1c626@redhat.com>
Date: Mon, 29 Jun 2026 14:06:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: skip per-VLAN promisc rules when
 default VSI Rx rule is set
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aleksandr.loktionov@intel.com
References: <20260622113428.2565255-2-poros@redhat.com>
 <20260623162526.1099096-2-horms@kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260623162526.1099096-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDEB26D9EA5


On 6/23/26 18:25, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> Subject: ice: skip per-VLAN promisc rules when default VSI Rx rule is set
>
> This patch optimizes the number of hardware switch rules used when an ice
> port is part of a vlan-filtering bridge. It avoids installing per-VLAN
> promiscuous rules if the broad default VSI Rx rule is already catching
> all traffic.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index e2fbe111f8496..efb1f536de6c7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> [ ... ]
>> @@ -442,17 +496,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> [Severity: High]
> This is a pre-existing issue, but does MAC filter overflow fail to force
> promiscuous mode, resulting in silent packet drops?
Pre-existing; the promisc_forced_on fallback is not changed by this patch.

>
> When the hardware MAC filter limit is reached (LIBIE_AQ_RC_ENOSPC), the driver
> attempts to fall back to promiscuous mode by setting promisc_forced_on = true.
>
> However, the execution flow then reaches a check for IFF_PROMISC:
>
>      if (vsi->current_netdev_flags & IFF_PROMISC) {
>          /* Apply Rx filter rule to get traffic from wire */
>          ...
>      } else {
>          /* Clear Rx filter to remove traffic from wire */
>
> Since the user never explicitly requested IFF_PROMISC, this evaluates to false,
> causing the driver to take the else branch. The else branch actively disables
> the default VSI rule and clears promiscuous mode instead of enabling it. The
> fallback feature appears to be non-functional, leading to lost traffic for
> newly added MACs.
>
> [Severity: High]
> This is a pre-existing issue, but could this function prevent retries of
> incomplete configurations and break multicast promiscuity if any default
> VSI is already active?
v3 will address the multicast half: ice_set_promisc(ICE_MCAST_PROMISC_BITS)
will be issued whenever the netdev is promiscuous, not only inside the
!ice_is_dflt_vsi_in_use() branch.

>
> In ice_vsi_sync_fltr(), the setup of multicast promiscuity and disabling of
> Rx filtering is gated:
>
>      if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
>          err = ice_set_dflt_vsi(vsi);
>          ...
>          err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
>          if (err)
>              goto out_promisc;
>      }
>
> If ice_set_dflt_vsi() succeeds but the subsequent ice_set_promisc() fails,
> the function jumps to out_promisc to trigger a retry. On the next cycle,
> ice_is_dflt_vsi_in_use() returns true because this VSI is now the default,
> causing the entire block to be skipped and leaving the VSI misconfigured.
>
> Furthermore, if another VSI (such as a VF) is already the default VSI,
> the PF VSI entirely skips setting multicast promiscuity, breaking multicast
> reception in promiscuous mode.
>
>>   		} else {
>>   			/* Clear Rx filter to remove traffic from wire */
>>   			if (ice_is_vsi_dflt_vsi(vsi)) {
>> -				err = ice_clear_dflt_vsi(vsi);
>> +				err = ice_vsi_exit_dflt_promisc(vsi);
>>   				if (err) {
>> -					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
>> -						   err, vsi->vsi_num);
>>   					vsi->current_netdev_flags |=
>>   						IFF_PROMISC;
>>   					goto out_promisc;
>>   				}
>> -				if (vsi->netdev->features &
>> -				    NETIF_F_HW_VLAN_CTAG_FILTER)
>> -					vlan_ops->ena_rx_filtering(vsi);
>>   			}
> [ ... ]
>> @@ -3675,10 +3724,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>>   	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
>>   		usleep_range(1000, 2000);
> [Severity: High]
> This is a pre-existing issue, but isn't there a risk of TOCTOU races with
> this ad-hoc lock pattern lacking memory barriers?
  Pre-existing; the ICE_CFG_BUSY locking is not changed by this patch.

>
> The driver spins on ICE_CFG_BUSY using test_and_set_bit() and usleep_range()
> to guard VSI filter synchronization. The lock is subsequently dropped using
> clear_bit(ICE_CFG_BUSY, vsi->state) at the exit label.
>
> Because clear_bit() lacks a memory release barrier, the CPU or compiler can
> reorder memory stores from the critical section to occur after the flag is
> cleared, leading to data races and corruption of shared filter state on
> weakly ordered architectures.
>
>> -	/* Add multicast promisc rule for the VLAN ID to be added if
>> -	 * all-multicast is currently enabled.
>> -	 */
>> -	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
>> +	/* skip the per-VID rule when the DFLT Rx rule already covers this VID */
>> +	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
>> +	    !ice_is_vsi_dflt_vsi(vsi)) {
>>   		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
>>   					       ICE_MCAST_VLAN_PROMISC_BITS,
>>   					       vid);
>> @@ -3696,11 +3744,12 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>>   	if (ret)
>>   		goto finish;
> [Severity: High]
> This is a pre-existing issue, but what happens if vlan_ops->add_vlan()
> fails here? Is the hardware switch rule leaked?
Pre-existing; the add_vlan() error unwind is not changed by this patch.

>
> When adding a VLAN to an interface with IFF_ALLMULTI enabled, this function
> first allocates a promiscuous switch rule in hardware via
> ice_fltr_set_vsi_promisc().
>
> If this succeeds but the subsequent call to vlan_ops->add_vlan() fails
> (e.g., due to ENOSPC or memory allocation failure), the function returns
> early without rolling back the promiscuous rule. Because the network stack
> considers the VLAN addition to have failed, ice_vlan_rx_kill_vid() will
> never be called for this VID, permanently leaking a Flow Lookup Unit (FLU).
>
>> -	/* If all-multicast is currently enabled and this VLAN ID is only one
>> -	 * besides VLAN-0 we have to update look-up type of multicast promisc
>> -	 * rule for VLAN-0 from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN.
>> +	/* On the first non-zero VLAN, promote the VLAN-0 multicast promisc
>> +	 * rule from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN. Skip when
>> +	 * the DFLT Rx rule is installed; it already covers every VID.
>>   	 */
>>   	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
>> +	    !ice_is_vsi_dflt_vsi(vsi) &&
>>   	    ice_vsi_num_non_zero_vlans(vsi) == 1) {
> [ ... ]
>> @@ -3763,11 +3812,12 @@ int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
>>   					   ICE_MCAST_VLAN_PROMISC_BITS, vid);
>>   
>>   	if (!ice_vsi_has_non_zero_vlans(vsi)) {
>> -		/* Update look-up type of multicast promisc rule for VLAN 0
>> -		 * from ICE_SW_LKUP_PROMISC_VLAN to ICE_SW_LKUP_PROMISC when
>> -		 * all-multicast is enabled and VLAN 0 is the only VLAN rule.
>> +		/* Last non-zero VLAN gone: demote the VLAN-0 multicast promisc
>> +		 * rule back to ICE_SW_LKUP_PROMISC. Skip when the DFLT Rx rule
>> +		 * is installed; no recipe swap is needed.
>>   		 */
>> -		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
>> +		if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
>> +		    !ice_is_vsi_dflt_vsi(vsi)) {
> [Severity: High]
> Will this modification cause a stale switch rule (ICE_SW_LKUP_PROMISC_VLAN for
> vid=0) to be permanently leaked if the last VLAN is removed while the DFLT VSI
> rule is active?
Real, and introduced by v1/v2. v3 will drop the two vid=0 recipe-swap
guards, so the rule is demoted back to ICE_SW_LKUP_PROMISC when the last
VLAN is removed and never stranded.

Petr
>
> This patch skips demoting the vid=0 multicast promiscuous rule from
> ICE_SW_LKUP_PROMISC_VLAN back to ICE_SW_LKUP_PROMISC when the last VLAN is
> removed, if ice_is_vsi_dflt_vsi(vsi) is true.
>
> However, if the interface later drops IFF_PROMISC (removing the DFLT VSI rule)
> and then drops IFF_ALLMULTI, ice_clear_promisc() is called. Because the
> interface now has zero VLANs, ice_clear_promisc() executes its else branch:
>
>      } else {
>          status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
>                                              promisc_m, 0);
>      }
>
> This only searches and clears rules from the ICE_SW_LKUP_PROMISC recipe. The
> stranded rule in the ICE_SW_LKUP_PROMISC_VLAN recipe is never cleared,
> resulting in a permanent hardware switch rule leak.
>
>>   			ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
>>   						   ICE_MCAST_VLAN_PROMISC_BITS,
>>   						   0);


