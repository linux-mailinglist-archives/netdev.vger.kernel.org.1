Return-Path: <netdev+bounces-278777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEJ7DgeT32n5WAAAu9opvQ
	(envelope-from <netdev+bounces-278777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A892404C83
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7C63013D74
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD03A75A1;
	Wed, 15 Apr 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4GXhRDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B383A759E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259754; cv=none; b=THTqKHo+QXL5xwxw72r3uoEVcCV+mNm/cV2oD7K1D74brh00jhdE1jwDoizGA6Xe6m3lStlas+hSCqPAg6jwGVEE4CQRqmrJXdVdzJR1yMvHKpTXSwl8JKvH4uNQysmJt+FqEVZzhfGbCQSPGJeJrLqAS1e0YWRe134EgGJr4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259754; c=relaxed/simple;
	bh=eAWQHpbhG+wTBm+8dI2tV4sVTXIGvKAGTUtdJwkdizg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5iuce/wPakujtq1Ksf3WWzXRAaleMjtNC3oya7FgrMct1RH6zA3VVSm4ssK03I4T747e1g0BwsgQ/PBzafH6OgumbtaV1veVZxtbQu2UYuNFhbsWnBYIMOtlNVhjtksl82E74JTBc7F/6JznfYjFaOblrcA6MagSUJmIexO1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4GXhRDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A4C19424;
	Wed, 15 Apr 2026 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776259754;
	bh=eAWQHpbhG+wTBm+8dI2tV4sVTXIGvKAGTUtdJwkdizg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4GXhRDY6Ln7jxPnxTRB9PU3l07/uBxnJfD/Uxj9AihJXctersFsfAcUach85VjQT
	 FNRyjiRtLR/dUlFDMMvecy9n6xvc3cpD7r5SPx3CPw/T+JqElKwVjOA0YqTobera+a
	 zt0kkkX57W8ykDHOqhQTrN5VE/ynycmBDz7vRX/NS/Ut68vTgTz1tv3swmbatmWXR0
	 jfeo5pLA9pHppGZRdaszcygckFC3U1iuG6suozQzFKZaNGcrvrCSwqx7OD4shYtNz6
	 /M4CYM/rZy1koLakm/4VI8JaAKCLD1+rbV/pj4d621v2FuGAD40TS8SDGFrvgzKqcP
	 naTS9wOlzLA9Q==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	kiran.patil@intel.com
Subject: Re: [PATCH iwl-net 3/5] iavf: prevent VSI corruption when ring params changed during reset
Date: Wed, 15 Apr 2026 14:28:58 +0100
Message-ID: <20260415132858.805112-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413073035.4082204-4-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278777-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A892404C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: prevent VSI corruption when ring params changed during reset

Changing ring parameters via ethtool triggers a VF reset and queue
reconfiguration. If ethtool is called again before the first reset
completes, the second reset races with uninitialised queue state and
can corrupt the VSI resource tree on the PF side. Return -EAGAIN from
iavf_set_ringparam() when the adapter is already resetting or its queues
are disabled.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 1cd1f3f2930a0..390913170315f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
>  	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>  		return -EINVAL;
>  
> +	if (adapter->state == __IAVF_RESETTING ||
> +	    (adapter->state == __IAVF_RUNNING &&
> +	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> +		return -EAGAIN;
> +

Is there a lockless Time-Of-Check to Time-Of-Use race here?

iavf_set_ringparam() is called from ethtool under rtnl_lock(), but the
background iavf_reset_task() synchronizes using netdev_lock(). Because iavf
does not set netdev->request_ops_lock = true, the ethtool core does not
acquire netdev_lock() for iavf_set_ringparam().

This allows adapter->state to transition to __IAVF_RESETTING immediately
after this lockless check.

Furthermore, calling iavf_reset_step() later in this function without
holding netdev_lock() allows the hardware reset sequence to execute
concurrently from both the ethtool thread and the workqueue, which could
lead to VSI resource corruption.

Could this open-coded state check miss pending resets?

If a reset is scheduled (e.g., by a watchdog timeout setting
IAVF_FLAG_RESET_NEEDED) but the worker task hasn't started yet,
adapter->state will still be __IAVF_RUNNING. This check will pass, and
iavf_set_ringparam() will proceed to mutate ring parameters and execute
iavf_reset_step(), racing with the previously scheduled iavf_reset_task.

Can this be addressed by also checking for IAVF_FLAG_RESET_NEEDED and
IAVF_FLAG_RESET_PENDING?

Also, the commit message notes that triggering a VF reset before the first
one completes causes VSI resource tree corruption. Both iavf_set_channels()
and iavf_change_mtu() also dynamically reconfigure queues and
unconditionally trigger resets by calling iavf_reset_step(adapter).

Should these functions be updated to include a similar state check to
prevent the same VSI resource tree corruption on the PF side?

>  	if (ring->tx_pending > IAVF_MAX_TXD ||
>  	    ring->tx_pending < IAVF_MIN_TXD ||
>  	    ring->rx_pending > IAVF_MAX_RXD ||

