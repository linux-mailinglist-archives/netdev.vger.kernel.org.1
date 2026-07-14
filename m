Return-Path: <netdev+bounces-307470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyp9O644VmrE1gAAu9opvQ
	(envelope-from <netdev+bounces-307470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 426137550E8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ITK9trsY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307470-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B2F3236B01
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E57265CDD;
	Tue, 14 Jul 2026 13:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933E298CAB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:15:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034910; cv=none; b=jFwXb+VHdxwo0ZHjk9Hx5x3wMIbrfNrewyioGGXzb0C07BDPMzHbJu08pAPrCnjAOTFuaeYg7RWY6166Y9moqFPyKsOcVvwsE8g77gjukCdhdpIH+RANTqGPdg/BYadF6phaBGSuFEtEOrgaXERihNXnrKqlKlOMapJ+f/oiQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034910; c=relaxed/simple;
	bh=3b7/+olA1pvFjMhFNfaGf6KWzHXFNd/QpLcVlnf1tlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI1AYfeZETIIUSxzfnq5qk/n/Zi4lLAucNKAL7XDtoNMXrrAlMoGv1KvrwshqN8o3Re7LV6CAFnS6cAjaCcULp/jg7TEnbYMm8/sA+aYWV5NlJXUoUWwlsTo+RHWDa7w27oOlNhixocZGL2AKISlwyUMA5IDvBFGT3xRbdgKQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITK9trsY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC11F000E9;
	Tue, 14 Jul 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034908;
	bh=NBo8CYi3Y72SAdTjIf2wrjxpjS/L+HX8XmDUHz8O1ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITK9trsY7zH++52/IA5fwEbrrJfbKgz8On2K5PUCSWTX5ziv09P/H3w5XrK3V6cls
	 giF2rwY1waEQSge3WHRJax2ZL/xmvMmQEqdMchuusSTVMxKYL/mMTk8VoWaWG4EGf8
	 8BSGa7kWltC/1l8i3YXSjOunWry85KucAqOxhaUNHNf6ZoN9cyvP3kdkSaHBw0bLmc
	 EoeZ2nXxQXGRs9iXfrjAasSdvD+3qePddubbOGBF/8bRc/fKqqSmW5QHej/iNSuy1F
	 MJw03vsujVu188gHxa4FX4/yj9yD2xlBCkUC8EB+q+S/lQyJ6VkdSEvEq//Vb4eJWy
	 l9JNG8IRfqmdA==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 15/15] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Tue, 14 Jul 2026 14:10:54 +0100
Message-ID: <20260714131053.1844276-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-16-mmc@linux.ibm.com>
References: <20260706193603.8039-16-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307470-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mmc@linux.ibm.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 426137550E8

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

This commit fixes polling hangs in the ibmveth driver after queue resize
by skipping over bad correlators instead of retrying endlessly. It also
ensures NAPI completes when the interface is down or being disabled.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 50a332ab83fd3..eb84b4e5f69fd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -2959,8 +2978,23 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  			__sum16 iph_check = 0;
>  
>  			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> -			if (unlikely(!skb))
> -				break;
> +			if (unlikely(!skb)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,

[Severity: High]
This isn't a bug introduced by this patch, but can the unvalidated packet
lengths and offsets from hardware descriptors trigger an skb_over_panic()
here?

Further down in ibmveth_poll(), the driver reads length and offset directly
from the hardware receive descriptor and passes them to skb_reserve() and
skb_put() on the reused SKB:

    int length = ibmveth_rxq_frame_length(adapter, queue_index);
    int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
    ...
    } else {
        rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
        if (unlikely(rc))
            break;
        skb_reserve(skb, offset);
    }

    skb_put(skb, length);

If a faulty hypervisor provides an abnormally large length or offset,
skb_put() will extend the tail past the end of the buffer, which triggers an
skb_over_panic() and causes a crash.

Should the driver validate that offset + length is within the known buffer
size before modifying the boundaries?

[ ... ]

> @@ -3034,8 +3068,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  
>  	ibmveth_replenish_task(adapter, queue_index);
>  
> -	if (frames_processed == budget)
> +	if (frames_processed == budget) {
> +		if (!netif_running(netdev) || napi_disable_pending(napi))
> +			napi_complete_done(napi, frames_processed);
>  		goto out;
> +	}

[Severity: High]
Does calling napi_complete_done() here conflict with the NAPI core contract?

If the polling loop exhausts its budget (frames_processed == budget), returning 
the full budget after calling napi_complete_done() might cause issues with the 
NAPI state machine. The NAPI core (__napi_poll) will operate on the instance 
assuming it still holds the NAPIF_STATE_SCHED bit. 

If napi_disable_pending() is true, the core calls napi_complete(), which will 
hit a WARN_ON_ONCE. 

If napi_disable_pending() is false but !netif_running() is true, the core will
add the NAPI instance back to the poll_list. Since the driver cleared 
NAPIF_STATE_SCHED, a subsequent interrupt can trigger another napi_schedule(), 
causing a double list_add_tail() and potentially leading to list corruption.

