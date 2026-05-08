Return-Path: <netdev+bounces-285842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDPHBQzo/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC344F737A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC84230C6D5C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA737BE70;
	Fri,  8 May 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2ja3fyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBA3815CB;
	Fri,  8 May 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247101; cv=none; b=iDsywo+NRvoa2gPCZz7KDIXqux6VX5mqrSg4tZoaG0eVdq79+R6bxACs73BAUr005ItDpSofjGDlnPs+3WGxFShUOIDmXdoQFYUHKPDfStSCbW5JXqOUYFy4oz6WfqLKyWdZJgvGTJTJ/Ysysej4ZfZ9T82kZMR+myo1ygNlI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247101; c=relaxed/simple;
	bh=JxypbuWnNL/2mPFJRS9B0fB7VeJz/jcNnlNcUQF/xfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHheXklhQBWE2BOCtcXXajZbJLwbBRBXJx8NMzcSErvAL6Xvk3wvRYLv4YQ87eM1jqV7thxD2A67Ac6ZcuJOrS+Z0buFJbdmIt3Gt6QuxyJJJVlODKA/ZpfITt3Mfgt7biiHzjkIyh59R+1jBxuwy5Ve9x2E50oSVJOx3ZKKzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2ja3fyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E98C2BCB0;
	Fri,  8 May 2026 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778247100;
	bh=JxypbuWnNL/2mPFJRS9B0fB7VeJz/jcNnlNcUQF/xfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2ja3fyrqJNqOj50SGTmCp06oLbtZHfnCUor/bUag/UUq45Nu0NzhDTaVd5mhMZAd
	 S5DDU/B2LsLmDIYVf50FR16Tf/DCB2tO/DQq5ik51526R1Ba69lCXmneZpQPMvYlhw
	 8Na9yXfKXyq/50mkMUzz8Q5ze+FbAoaYzxLRMx7borZck3uYCbX97Oo1MUUToJO7pM
	 XgZgKPVITOvNCeQpw7vyv/BJcROF2VUUIQNJ16azFV8I2hB/lowbfRmUbcsr75RLje
	 7LMq/hmWBtCW1NHT2w0grZq7D6+iTxM6FPTLvoKDh8VHmoM0ufiyvnEjovhvudHqX2
	 ZXC8ElFqa4WEw==
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kohei@enjuk.jp,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 3/5] ice: migrate to netdev ops lock
Date: Fri,  8 May 2026 14:28:29 +0100
Message-ID: <20260508132827.1183079-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FC344F737A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	BROKEN_CONTENT_TYPE(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-285842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
    ice: migrate to netdev ops lock

This commit migrates queue management operations to use netdev locking.
It updates several NAPI and VSI configuration functions to use their
_locked variants to avoid deadlocks, taking the lock manually where needed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index 16aa255351523..7d89c0acc5d8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
[ ... ]
> @@ -1107,7 +1106,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>  
>  	rtnl_lock();
>  	/* disable VSIs affected by DCB changes */
> -	ice_dcb_ena_dis_vsi(pf, false, true);
> +	ice_dcb_ena_dis_vsi(pf, false);
>  
>  	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
>  	if (ret) {
> @@ -1119,7 +1118,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>  	ice_pf_dcb_recfg(pf, false);
>  
>  	/* enable previously downed VSIs */
> -	ice_dcb_ena_dis_vsi(pf, true, true);
> +	ice_dcb_ena_dis_vsi(pf, true);
>  unlock_rtnl:
>  	rtnl_unlock();
>  out:

This wasn't introduced by this patch, but does this error path leave VSIs
permanently disabled?

If ice_query_port_ets() fails, the code jumps to unlock_rtnl, bypassing the
call to ice_dcb_ena_dis_vsi(pf, true). This seems to leave the affected VSIs
(including the main PF interface) in a disabled state (ICE_VSI_DOWN) with
ICE_VSI_NEEDS_RESTART set, which could result in a denial of service.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f7..af0cc77fbf718 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -23,10 +23,16 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	struct net_device *netdev = uplink_vsi->netdev;
>  	bool if_running = netif_running(netdev);
>  	struct ice_vsi_vlan_ops *vlan_ops;
> +	int ret;
> +
> +	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state)) {
> +		netdev_lock(netdev);
> +		ret = ice_down(uplink_vsi);
> +		netdev_unlock(netdev);
>  
> -	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
> -		if (ice_down(uplink_vsi))
> +		if (ret)
>  			return -ENODEV;
> +	}

Simon says: It seems that the topic of locks in this patch has come up
            again ¯\_(ツ)_/¯

Does manipulating the state bit outside of netdev_lock create a race
condition with interface teardown?

If the interface is concurrently brought down, ndo_stop (which holds
netdev_lock) would call ice_vsi_close(). Because ICE_VSI_DOWN is already
set by the test_and_set_bit() call above, ice_vsi_close() would skip calling
ice_down() and immediately proceed to free the Tx/Rx rings.

This would leave the hardware queues active and performing DMA operations into
freed memory, potentially causing a use-after-free.

