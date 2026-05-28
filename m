Return-Path: <netdev+bounces-292721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH6fB/JRGGqwiwgAu9opvQ
	(envelope-from <netdev+bounces-292721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6C5F3B86
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 420C33016C6A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78E2DC77F;
	Thu, 28 May 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2vp2RVK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412633E5575
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978696; cv=none; b=kIPIKuo1cEJP4OvkVmbOgaGUm7JegCnTgF5Qa3o5z1YGTkH4B68Ro8StZrYcSQGGP1FNCntdFN52BmM2kAhK4Z7OU8FTIYmKmrby8+nGRfkghlGlHnwjGFBREe3OjmhPQrStchfQg5bfQ1abH2zsJq9qkzAtC4yFR8FGx05/tM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978696; c=relaxed/simple;
	bh=fDuZdXmDJAvG6UyUc59QNJium2OJEAnH0313/JHkFhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/MANOxIL8c9NMvaOCxRfPky7DUSZTg05gE6meH+uZ/KpiFs81pV0MgBeYmjgZ0QpTb3KRV5lRI4gjiHqlvjRVfRhCK/22Jokttkq1KoUqyZflWnGc7yN2K95yoTlYtBGRqcIc5OJYc2tt6xFv9TBlH6uP2WdHPp6GwSbKZvFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2vp2RVK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779978693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nosj54CS/w1v8DX+xXPgimYXGQ9UXBm17ySIVHUG2Kk=;
	b=B2vp2RVKlUY9kVDIxS8yVZVwSMjxUrZHSk+9jAc2/FVvHh62bTDnJQhWmmcxs3TS/on63e
	p+1JxHUJ3hxk7o2+vcLnl0prk5mMidxtH5HWjim71IKJcj4yfLxYqJwxFNhXj0SuTH2uno
	M2QqFYQP8zoJNtIG3pRnX3KhjsU1dyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-eF-ET-tuPnGdNzgx0pP7mQ-1; Thu,
 28 May 2026 10:31:29 -0400
X-MC-Unique: eF-ET-tuPnGdNzgx0pP7mQ-1
X-Mimecast-MFC-AGG-ID: eF-ET-tuPnGdNzgx0pP7mQ_1779978688
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B99E195608E;
	Thu, 28 May 2026 14:31:28 +0000 (UTC)
Received: from [10.44.50.40] (unknown [10.44.50.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A40719560A3;
	Thu, 28 May 2026 14:31:27 +0000 (UTC)
Message-ID: <e112de51-687b-48de-a0d9-eebbfd5b32f4@redhat.com>
Date: Thu, 28 May 2026 16:31:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C devices
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-4-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260327072332.130320-4-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292721-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: B9F6C5F3B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 8:23 AM, Aleksandr Loktionov wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Change the order of PTP reconfiguration when port goes down or up
> (ice_down and ice_up calls) to be more graceful and consistent from
> timestamp interrupts processing perspective.
> 
> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
> is called which starts/stops PTP timer. This patch changes the order:
> - while link goes down: disable net device Tx first (netif_carrier_off,
>    netif_tx_disable), then call ice_ptp_link_change
> - while link goes up: ice_ptp_link_change called first, then re-enable
>    net device Tx (netif_tx_start_all_queues)
> 
> Otherwise, there is a narrow window in which PTP timestamp request has
> been triggered and timestamp processing occurs when PTP timer is not
> enabled yet (up case) or already disabled (down case). This may lead to
> undefined behavior and receiving invalid timestamps. This case was
> observed on E825C devices only.
> 
> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
> Cc: stable@vger.kernel.org
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> 
>   drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e3..8896805 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6797,10 +6797,10 @@ static int ice_up_complete(struct ice_vsi *vsi)
>   	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>   	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
>   			      vsi->type == ICE_VSI_SF)))) {
> +		ice_ptp_link_change(pf, true);
>   		ice_print_link_msg(vsi, true);
>   		netif_tx_start_all_queues(vsi->netdev);
>   		netif_carrier_on(vsi->netdev);
> -		ice_ptp_link_change(pf, true);
>   	}
>   
>   	/* Perform an initial read of the statistics registers now to
> @@ -7328,9 +7328,9 @@ int ice_down(struct ice_vsi *vsi)
>   
>   	if (vsi->netdev) {
>   		vlan_err = ice_vsi_del_vlan_zero(vsi);
> -		ice_ptp_link_change(vsi->back, false);
>   		netif_carrier_off(vsi->netdev);
>   		netif_tx_disable(vsi->netdev);
> +		ice_ptp_link_change(vsi->back, false);
>   	}
>   
>   	ice_vsi_dis_irq(vsi);

I cannot find this patch applied anywhere... IWL patchwork indicates 
Changes Requested... I don't know why...

Thanks,
Ivan


