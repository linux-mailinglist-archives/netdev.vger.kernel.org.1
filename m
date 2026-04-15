Return-Path: <netdev+bounces-278764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ENIDqmK32l5VAAAu9opvQ
	(envelope-from <netdev+bounces-278764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:55:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5C4048D8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6614530ED4E8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067733468C;
	Wed, 15 Apr 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Z7E+ea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1232B9A9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257367; cv=none; b=EiVBucksA3VTPSisoF6uZlyTuBRkGVYS+S9/mJ/ja2RUwjHXvt7hA7uXFQtnLkDFwJZTgiYxvSSPRedGGz85kAD6+3GaGpYsjZURsql3bFgZMF48HDQRHn5cjTUkmDkBVVJVlhbB10Dp+G9STNpLMndLYIj8qF65Cqwx/5/DAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257367; c=relaxed/simple;
	bh=GOwZ5doA46qVcWz3RPILsKEjPzaIRsf8e9HxV08nzL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ/kaKc2etOxYb0aclosD1v5m/JLybsAkUuNizo3cvdtKaeF6o9u2/zThu4HMOH5AUKNM2IXu2aYKlASeIHhlQApUvGoIbgePSoDPWTPfuqh4giQ8KHy8iXfD9NEXJDeeq78yC7a8QNF/5kdpBZIoL7BcwSEw0tvv9hVKVGvFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Z7E+ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2879FC2BCB4;
	Wed, 15 Apr 2026 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257366;
	bh=GOwZ5doA46qVcWz3RPILsKEjPzaIRsf8e9HxV08nzL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8Z7E+eaoXU5E36Ci2dtxMk1/QFNhGsdxvTszyuFWgzvwVnwmMB419YrtxS0qiImi
	 O82QO67KWosKyuRvX72/MLD6BaW9Ml6DQd4N6ltTvgkugqfmtmdj//Fg/vMasEQiIq
	 ydquxxeH3qwC5Rl/NCS1BXmi+T0VQkCTwUdRcte63xVwtTZxXJP9sG8jbLwHbpWiJZ
	 i5zLGGJGAbFQ6njoeJtyPy+Tvo4cDmA3LzVWDS/nv/Wu7tqY4wJv1cVwPeGOb39BTO
	 Dqhxe6lCosXo/yQhmG/DvxTbmm//HOfMBdk8ciMyXabCcRlLgX4cdQ9zTMSgrCg+N1
	 UeeU+Q825PSYg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	kiran.patil@intel.com,
	sylwesterx.dziedziuch@intel.com,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	avinash.dayanand@intel.com
Subject: Re: [PATCH iwl-net 1/5] iavf: fix null pointer dereference in iavf_detect_recover_hung
Date: Wed, 15 Apr 2026 13:48:45 +0100
Message-ID: <20260415124845.797759-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413073035.4082204-2-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278764-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A5E5C4048D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
iavf: fix null pointer dereference in iavf_detect_recover_hung

During a concurrent reset, q_vectors are freed and re-allocated while
the watchdog task may still be iterating rings in
iavf_detect_recover_hung(). Dereferencing a NULL q_vector inside
iavf_force_wb() results in a crash. Guard against this by skipping
rings whose q_vector is NULL.

> Fixes: 9c6c12595b73 ("i40e: Detection and recovery of TX queue hung logic moved to service_task from tx_timeout")

The Fixes tag points to commit 9c6c12595b73, but that commit only modified
the i40e driver and did not introduce the iavf_detect_recover_hung function.

The bug was actually introduced by commit 07d44190a389 ("i40e/i40evf: Detect
and recover hung queue scenario"), which added iavf_detect_recover_hung with
the code pattern 'if (tx_ring && tx_ring->desc)' that calls
iavf_force_wb(vsi, tx_ring->q_vector) without checking if q_vector is NULL.

Should the Fixes tag be:

    Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scenario")

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 363c42bf3dcf..e7e7fc9a5c68 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c

[ ... ]

> @@ -195,8 +194,11 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
>  		return;
>
>  	for (i = 0; i < vsi->back->num_active_queues; i++) {
> -		tx_ring = &vsi->back->tx_rings[i];
> -		if (tx_ring && tx_ring->desc) {
> +		struct iavf_ring *tx_ring = &vsi->back->tx_rings[i];
> +
> +		if (!tx_ring || !tx_ring->q_vector)
> +			continue;

The check `if (!tx_ring || ...)` tests whether tx_ring is NULL, but tx_ring
is assigned as `&vsi->back->tx_rings[i]`, which is the address of an array
element. This address is always non-NULL by C language rules, as noted in
the commit message itself: "the compiler can never observe since an
array-element address is always non-NULL."

This creates misleading logic. Other similar code in the driver correctly
omits such checks (for example, in iavf_virtchnl.c and elsewhere in
iavf_txrx.c).

Should this be simplified to just check the q_vector:

    if (!tx_ring->q_vector)
        continue;

> +		if (tx_ring->desc) {
>  			/* If packet counter has not changed the queue is
>  			 * likely stalled, so force an interrupt for this
>  			 * queue.

[ ... ]

