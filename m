Return-Path: <netdev+bounces-302646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wqcNINV1Qmrv7gkAu9opvQ
	(envelope-from <netdev+bounces-302646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:40:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B566DB5DE
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LFnYTSkF;
	dkim=pass header.d=redhat.com header.s=google header.b=nJmKcovO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302646-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 071E83036C08
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB340860E;
	Mon, 29 Jun 2026 13:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464D23EA97
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:23:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739406; cv=none; b=UOR4Z8+YWzJaPi+xDn5pB1GKGSb+Y1OOgm01bmg55+leKYBuayquX/RAFBuclZvaST10WIIn8zoz4q/tqL96X4o1PHxrN58UFAQcVI67AoUABSB+lAQIxmb6SbRjAZOyXFOsMeofLh43AR+Op4cLc9r+tNKDXnn1bagp1qaGnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739406; c=relaxed/simple;
	bh=jJa1vULXdD8nTb9yCBpvx7O8qwcNgz1MtHjhkOGJQGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovGTBUON2s6fFuhNTUaHvz+UbdG/dYqyxhBCCXyUfuZx8ClcXh6SA/tR8oxRuzhHWyDzZTJDu9wjnoKx1Yi5zVcnbTXjCbht+o3ycmCjkkllz30ze9cgrcSf7Lwtrl6Db5METQ+0c74NHEhCikD3oGIjbNEeC0HVl9OIfWgJ0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFnYTSkF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nJmKcovO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782739403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGH0r9n8LKSOXIwJNJ0nZ8wggtzDvg5vMSxTltBG1AQ=;
	b=LFnYTSkF7JhK8SfMyUn/JApZOGB2jcmSp25Z/dzFxQwKsk+PFJQGfRvyrC7cbq23d9FIHG
	B9n02pr9HyEdxhKdVkEgHR04LqhULp7n2wl/9CcufNs9YbCNGyJyfGGnchcucRqB08fB2L
	5Rn+GfbgzCS23oY+sE+JADCPuOhAwJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-8Li4ucE2Pgez1hSI5uvnDg-1; Mon, 29 Jun 2026 09:23:21 -0400
X-MC-Unique: 8Li4ucE2Pgez1hSI5uvnDg-1
X-Mimecast-MFC-AGG-ID: 8Li4ucE2Pgez1hSI5uvnDg_1782739400
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924583c7baso37476855e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782739400; x=1783344200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGH0r9n8LKSOXIwJNJ0nZ8wggtzDvg5vMSxTltBG1AQ=;
        b=nJmKcovOWRRuxN1vCoF+Zh00cg0H5C6QcapW6Pj4i7T0AKdPcwoV3ljfX0nbMRR7W9
         CBKUrUba+0N2G0xZDKI4REEyRQAG6/Tl4bdHLPLRK/K/rvBm9Ydbxu965/WTIEIZYNXZ
         /fTGMyWd995FvpxArHjTToWDcZiFVDFKHr3BHc38uMzRviakWT/YHx3WwYUMiB14bfGU
         7gSM+b/YxbiEgs2lzi/GrCKpqOtXxFh1O219xLQnUhso9YmUvyHW6lCdn8Cdp4BM5IAR
         yqZoC9J08GY5LHVd6lBYjRsM995OU8aKwt+Cq+YHuWxKskSRD5RHM0wztzLprdpk5ZAH
         Qm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739400; x=1783344200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGH0r9n8LKSOXIwJNJ0nZ8wggtzDvg5vMSxTltBG1AQ=;
        b=WaFZgtdeKwr1WHwLA4AD+5NpoU2R25szY+WWA5jaLj9uEVz0n3dgdG8VcYrgusOSNx
         b7xtcoGV+pHJqf3u7OEHzTYpvm0Lk5O0uuEuA6KR33eK+eAWwOJou25yJVD6SNaXS7y1
         8SFrd609wF3r9n8kTLmpgYG5y/j45fUXfkonQTGYc6vpj2kjY31dEzd95DnyNa5Rv+kW
         d1n+wLVmqQZSW14NCfau69myWsSMA97OpoDWAIseOpi3ZuJPtUYjd7YRZFOWOLwhYUXp
         PspuMbVHHGToh8q24pAkHckJlzDzexdPc+VcYPh8FD5uXOBsUW8lenhJxuz+wv/wn8Dd
         1uQQ==
X-Gm-Message-State: AOJu0YwZ6cY/l5MwxPBIJV4C4gr4Nh0EYqE87yltGQBUaPRV94zAPnCO
	mu6O9sAbHsvkv/9amNECFu4LpBaBbjCC4W4e2f2I20OgfBl8doYVsm/mfD5d1VveoJC5zNGaeFP
	3dm1ryzv/dTgFycp/jtPGu2YIgMLmD4pz7hu/x14+bQVR93tsTew0kLCHqEKixt3esA==
X-Gm-Gg: AfdE7cmLl7w0FhiMylOoFfs9UklCTWFsxNnmGgbpm69os7By8n0x+5pKATIUD4RzAiN
	nK510UX3mPOn9/4Y68hmeMriyIe3NuVrlhNaFA3HvzM9pdk5tGJjoAuZ6UlvzVWyMS9gi3TLjP+
	iZRGeObNUUohufpXzBNJN+Hy+hnGWzCGe2evlnl9h+bYY7svcX7NVPQP5u75Ll7RAOtyE9IdGUI
	ccjcQceY0LTnkMfUb/2slSSw365xA9oBj4dx0IOYxPGs+cqjlTPGuUg8H1hI9RtWYomsN36g9+Q
	guWKg+qAEfLkm/p85ReMPA8lQ/7Ea2hx9w05E3FD+B3aeU/PeWnfJrlOJ6+DHy5KYp5XdoeJLUA
	RdtNMoL9wSQ==
X-Received: by 2002:a05:600c:4fc4:b0:493:a54b:7f8f with SMTP id 5b1f17b1804b1-493a54b8051mr98736535e9.24.1782739400305;
        Mon, 29 Jun 2026 06:23:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc4:b0:493:a54b:7f8f with SMTP id 5b1f17b1804b1-493a54b8051mr98735865e9.24.1782739399781;
        Mon, 29 Jun 2026 06:23:19 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm432857925e9.14.2026.06.29.06.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:23:19 -0700 (PDT)
Message-ID: <7d21d2db-ed18-40e1-a5c2-7fc8c235805b@redhat.com>
Date: Mon, 29 Jun 2026 15:21:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] ice: preserve uplink DFLT Rx rule on
 switchdev release
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aleksandr.loktionov@intel.com
References: <20260622113428.2565255-3-poros@redhat.com>
 <20260623162556.1100516-2-horms@kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260623162556.1100516-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-302646-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 43B566DB5DE


On 6/23/26 18:25, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: preserve uplink DFLT Rx rule on switchdev release
>
> This commit preserves the default Rx rule on the uplink VSI when releasing
> the switchdev environment if the interface is in promiscuous mode. This
> prevents the catch-all rule from being removed while the netdev flags still
> request promiscuity.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index 2e4f0969035f7..48273ef9f69dc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> [ ... ]
>> @@ -278,8 +280,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
>>   	vlan_ops->ena_rx_filtering(uplink_vsi);
> [Severity: High]
> Could this lockless read of netdev->flags cause a regression due to a TOCTOU
> race?
Both reads key on the same live netdev->flags & IFF_PROMISC (the pruning
read just above included); it is a single word, so no torn read, and a
flip in the two-statement window is transient and reconciled by the next
ice_vsi_sync_fltr() after switchdev stops. I kept the read live on purpose
so the preserved rule and the pruning decision key on the same source.
> The ena_rx_filtering() call eventually reaches ice_cfg_vlan_pruning(),
> which reads uplink_vsi->netdev->flags & IFF_PROMISC locklessly to decide
> whether to enable VLAN pruning.
>
>>   	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>>   			 ICE_FLTR_TX);
>> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>> -			 ICE_FLTR_RX);
>> +
>> +	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
>> +	 * the session. Test the live netdev->flags, the same value
>> +	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
>> +	 * on, so the preserved DFLT rule and the pruning state stay consistent.
>> +	 */
>> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
> ... and then the exact same flags are read locklessly again right here.
>
> Because setup/teardown paths are protected by devl_lock rather than
> rtnl_lock, could a concurrent dev_change_flags() holding rtnl_lock toggle
> IFF_PROMISC between the two checks?
>
> If IFF_PROMISC changes from 0 to 1 in this window, the code would incorrectly
> enable VLAN pruning (seeing 0) and then incorrectly retain the DFLT_RX rule
> (seeing 1), leaving the hardware with VLAN pruning enabled during promiscuous
> mode.
>
> [Severity: High]
> Does preserving the Rx DFLT rule here cause a regression by permanently
> breaking multicast promiscuity configuration if IFF_PROMISC was set?
Correct, the DFLT rule is unicast only. v3 will fix this in patch 1:
ice_set_promisc(ICE_MCAST_PROMISC_BITS) will run whenever the netdev is
promiscuous, including when ice_is_dflt_vsi_in_use() is already true.

>
> During the switchdev session, ice_remove_vsi_fltr() removes the
> ICE_SW_LKUP_PROMISC rules. By manually preserving the DFLT rule here, any
> future synchronization via ice_vsi_sync_fltr() will evaluate
> !ice_is_dflt_vsi_in_use(vsi->port_info) as false:
>
> ice_main.c:ice_vsi_sync_fltr() {
>      ...
>      if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
>          err = ice_set_dflt_vsi(vsi);
>          ...
>          err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
>      }
>      ...
> }
>
> Because it is skipped, ICE_MCAST_PROMISC_BITS is never configured, leaving
> the VSI in unicast promiscuous mode but silently dropping multicast traffic
> destined for other MAC addresses.
>
>> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
>> +				 false, ICE_FLTR_RX);
>> +
>>   	ice_fltr_add_mac_and_broadcast(uplink_vsi,
>>   				       uplink_vsi->port_info->mac.perm_addr,
>>   				       ICE_FWD_TO_VSI);
> [Severity: High]
> This is a pre-existing issue, but does this teardown function fail to
> synchronize hardware state for previously joined multicast groups and
> secondary unicast addresses?
Pre-existing (rx_mode is gated during switchdev). This patch only gates
the DFLT Rx removal in ice_eswitch_release_env(); the multicast-promisc
half is covered by the v3 patch 1 change above, and replaying the full
deferred uc/mc list is a wider item left out here.

Petr
>
> When entering switchdev mode, __dev_uc_unsync() and __dev_mc_unsync() clear
> the synchronization state of OS-level MAC addresses, and
> ice_remove_vsi_fltr() removes the actual hardware filters. While switchdev
> runs, calls to ndo_set_rx_mode return early and do not update hardware.
>
> When returning to legacy mode, this function restores only the primary MAC
> and broadcast addresses, but doesn't seem to invoke netif_set_rx_mode() or
> equivalent to resynchronize the deferred Rx filters from the netdev to the
> hardware. Could this cause the hardware to silently drop packets for
> previously joined groups until the interface is bounced?
>


