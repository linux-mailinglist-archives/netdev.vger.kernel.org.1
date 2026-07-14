Return-Path: <netdev+bounces-307449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2t+2J5YvVmoJ1AAAu9opvQ
	(envelope-from <netdev+bounces-307449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:46:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DC754B3D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:46:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M2DLt847;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307449-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B51300D97C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EE36897E;
	Tue, 14 Jul 2026 12:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C810346A04
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:43:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033033; cv=none; b=WzsAMEEyAIQfqpnGc9dU6UF7CGje1+uY0492e+PZAD3L1MKKhgWT1SnYvO4YqkfnwZo0K854g1gW0Ntey0pOuwDHVvmeOmSganunpJn1/uEUqT+TP8oMTkwzqsKIg9zrEWbk43Q8bBelTF2+L/CZUN0gL5ugkSwDtV8LGxevp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033033; c=relaxed/simple;
	bh=asqH4ZH4x4bRcWUlFbYg7+MWf8zJRXvrwE+S8jfWGCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz36d625RjwRocgqmyEGJL6tYpXt2XVW7Lge7ooJNVhgkkxFjDirG1++nCj0oiUqlITBTORXsSMcUgUZzc9W7z9vpUbs0NyVS6DzcGjmLCpP8OHwc8AhuC/ilFjx5uGfrG6Uxn3Zjs1C5aNFyhz04ztiris15HJJMsBi7I8Nsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2DLt847; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0331F000E9;
	Tue, 14 Jul 2026 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033032;
	bh=jtlHSUbiFYNyLLadUNgGYcL9nY8Nv0mWqimOCmfHP3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2DLt8470B2zE+vab6grYR7GWTyznRDtRlOgOEkTqOw2m54bUZN3aBNl6rBGmt+uQ
	 e85/i5TwIBdDWW7Q8nPS6Zi0h8QdSOWOvdvIejo/3ETWkW/eHPGk0U2cHha9c4GfuN
	 IF0faiXNCZYoApEGxefP8SAXxcAdKrognhjC0E7ulERJwgF950doNYzhuQ1wgpK3rO
	 N366JCe0H5iJQkEa6zCoJIurTb+1be0/tlMwvsGDDEeVa4LNWcDrsmQeOStVLLGHhn
	 DaM4WKPjUdopcs1VSoyPpoMvvA/uHhdKJNq7kq5jJCS0ZmsrFTQEU3duvqixp6ulXY
	 7Ad2MFBvSuryg==
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
Subject: Re: [PATCH net-next v3 07/15] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Tue, 14 Jul 2026 13:43:38 +0100
Message-ID: <20260714124338.1831986-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-8-mmc@linux.ibm.com>
References: <20260706193603.8039-8-mmc@linux.ibm.com>
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
	TAGGED_FROM(0.00)[bounces-307449-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mmc@linux.ibm.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB2DC754B3D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Add RX queue register/deregister helpers for MQ

This patch introduces new helpers to handle RX queue registration and
deregistration for MQ support. It replaces the single adapter-level
register/free paradigm with per-queue register calls to the hypervisor,
fetching queue handles and IRQs. These new paths are only fully exercised
when multi-queue mode is enabled.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 63b0184c622a4..7fc11a4e1f61d 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
[ ... ]
> @@ -401,6 +401,28 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
[ ... ]
> +static int __maybe_unused
> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i, rc;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (!adapter->queue_irq[i]) {
> +			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
> +			rc = -EINVAL;
> +			goto err_free_irqs;
> +		}
> +
> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
> +				 0, netdev->name, &adapter->napi[i]);
> +		if (rc) {
> +			netdev_err(netdev,
> +				   "request_irq() failed for irq 0x%x queue %d: %d\n",
> +				   adapter->queue_irq[i], i, rc);
> +			goto err_free_irqs;
> +		}
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		napi_enable(&adapter->napi[i]);

[Severity: Medium]
Could this sequence race with packet reception during interface bring-up?
By calling request_irq() before napi_enable(), the hardware interrupt is
unmasked while the NAPI state is still NAPI_STATE_DISABLE. If an interrupt
fires in this window, could ibmveth_interrupt() fail to schedule the NAPI
poll, potentially leading to dropped events or an interrupt storm?

[ ... ]
> @@ -1136,6 +1176,293 @@ static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapte
[ ... ]
> +static int
> +ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
> +				   union ibmveth_buf_desc rxq_desc,
> +				   int queue_index)
> +{
[ ... ]
> +	if (lpar_rc == H_FUNCTION) {
> +		if (adapter->multi_queue) {
> +			netdev_info(adapter->netdev,
> +				    "Multi queue mode not supported by firmware, falling back to single queue\n");
> +			adapter->multi_queue = 0;
> +		} else {
> +			netdev_err(adapter->netdev,
> +				   "Unexpected H_FUNCTION for queue %d registration (MQ mode already disabled)\n",
> +				   queue_index);
> +		}
> +		return lpar_rc;

[Severity: Medium]
Does returning lpar_rc here cause a regression for the single queue fallback?
Since this error propagates up to ibmveth_register_rx_queues(), it seems it
will unconditionally jump to err_unregister and fail the interface open
rather than allowing it to continue with a single queue.

> +	}
> +
> +	if (try_again) {
> +		try_again = 0;
> +		goto retry;

[Severity: Low]
Does this retry loop provide any benefit? Unlike the primary queue which
calls h_free_logical_lan() before retrying to clear stale state, this
jumps back to retry the exact same hypercall with the exact same arguments,
which seems like it will immediately fail again.

> +	}
[ ... ]
> +static int
> +ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
> +{
[ ... ]
> +	for (i = 1; i < adapter->num_rx_queues; i++) {
> +		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
> +		if (rc) {
> +			if (!adapter->queue_handle[i] || !adapter->queue_irq[i]) {
> +				netdev_err(netdev,
> +					   "Invalid hypervisor return for queue %d: handle=0x%llx irq=%u\n",
> +					   i, adapter->queue_handle[i],
> +					   adapter->queue_irq[i]);
> +			}

[Severity: Low]
Is this validation check placed correctly? Because it sits inside the
if (rc) error block, it will log "Invalid hypervisor return" whenever
registration fails normally (e.g., due to resource constraints). It appears
the hypervisor is not expected to populate the handle and irq on failure.

> +			goto err_unregister;
> +		}
> +	}

