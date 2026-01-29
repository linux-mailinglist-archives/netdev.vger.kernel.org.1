Return-Path: <netdev+bounces-254761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKJdNqtAe2nECwIAu9opvQ
	(envelope-from <netdev+bounces-254761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECBCAF7C4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6808B3056679
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F71385EC1;
	Thu, 29 Jan 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEaEe1WM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAA38170D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684889; cv=none; b=ZM+8HiD6Fotvp0Wt2/0AXv8Mnwdn1gMkcbcZKOPbAVvbnc0OWarrAxEK2tJF2rzBa1oApESJiA4Kvg485ZEe2/rFsdOmPrKddsw4Zu+GB2KXvCltyyCydLib2gehx8id7GIGlKPrJxpSlB+NjKP9D3g+eKiZ/zzfm9QBU6+eELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684889; c=relaxed/simple;
	bh=VO+8rp/bLfGqAH28Zcs4Kfuvsdslw/N3JtsbzEIUO/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhkbMrZO1vEr49CptH7XNdnOIijhAD1pjBC8nj1a3uMTFLuL8dEpYwWtULTwNxqu/nPh18QT/p30aJDPXCO003gjsGh1uil7RNWtXITaJsJmM58FFthL4t6p6cXkMd6Fw9xIJ+11mMsMa2pm5BhFKX/R/A0qln3lOOfsIGuOmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEaEe1WM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769684887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntbgkhKtRWARdssn5Y+QqDqVGEcBIsUot1MZAzH7HLI=;
	b=FEaEe1WMnwDI8iQRdcE+ei2Qjwz8hQNmachIkhmRjoFiRqAFQNrQlmLZztSxZ50YrI5OfD
	m3FIrmFVblgzVSlQICHtk80Ej4yDp+jQDgcMG/R9KQtpqNm7rm/t6OX2m72SmJqdikyIDs
	K4PH9LwTZ+q5juq1ajCYSFcLo1z6NT0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Ni2U2sqlMfOumndh9SsP-A-1; Thu,
 29 Jan 2026 06:08:02 -0500
X-MC-Unique: Ni2U2sqlMfOumndh9SsP-A-1
X-Mimecast-MFC-AGG-ID: Ni2U2sqlMfOumndh9SsP-A_1769684880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A68FE1956060;
	Thu, 29 Jan 2026 11:07:59 +0000 (UTC)
Received: from [10.43.2.2] (unknown [10.43.2.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDE953000218;
	Thu, 29 Jan 2026 11:07:55 +0000 (UTC)
Message-ID: <544fac80-d2d9-4895-951d-2201d7ebdc8e@redhat.com>
Date: Thu, 29 Jan 2026 12:07:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] iavf: fix PTP use-after-free during reset
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: mschmidt@redhat.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260129095723.7269-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260129095723.7269-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254761-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,lists.osuosl.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECBCAF7C4
X-Rspamd-Action: no action

On 1/29/26 10:57 AM, Petr Oros wrote:
> Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
> worker to cache PHC time, but failed to stop it during reset or disable.
> 
> This creates a race condition where `iavf_reset_task()` or
> `iavf_disable_vf()` free adapter resources (AQ) while the worker is still
> running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
> accesses freed memory/locks, leading to a crash.
> 
> Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
> This ensures `ptp_clock_unregister()` synchronously cancels the worker and
> cleans up the chardev before the backing resources are destroyed.
> 
> Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 4b0fc8f354bc90..0dd58ce5a53ab1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3025,6 +3025,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
>   
>   	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
>   
> +	iavf_ptp_release(adapter);
> +
>   	/* We don't use netif_running() because it may be true prior to
>   	 * ndo_open() returning, so we can't assume it means all our open
>   	 * tasks have finished, since we're not holding the rtnl_lock here.
> @@ -3200,6 +3202,8 @@ static void iavf_reset_task(struct work_struct *work)
>   	iavf_change_state(adapter, __IAVF_RESETTING);
>   	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
>   
> +	iavf_ptp_release(adapter);
> +
>   	/* free the Tx/Rx rings and descriptors, might be better to just
>   	 * re-use them sometime in the future
>   	 */

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


