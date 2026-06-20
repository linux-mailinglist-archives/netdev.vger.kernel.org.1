Return-Path: <netdev+bounces-300785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KySFER1VNmo39gYAu9opvQ
	(envelope-from <netdev+bounces-300785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 10:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB56A89F8
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 10:53:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZbMwWP+O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300785-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300785-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3E03020D5B
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626A34388C;
	Sat, 20 Jun 2026 08:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A52B9B7
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:53:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945626; cv=none; b=fk02Iwl4CdVq0OKubKtijKQfC2ssvBGOffX5gUaOT4yuVexhehnxETez5ZVRyLLA5ulUKM96HyYzMxzAZSBJIfU+KOlEzA8owRVF4k28b9U+O0Yi3fAy6fP32vSRb2qihUHCmkP7D10S8swKPzJInId1Toz3fj/i1plNTfiyMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945626; c=relaxed/simple;
	bh=1dDmBbpJoaalDMG9FJ/YD6P+/FeZHCjDquKJCujYgnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqFNR3RnB84Ux8pE9/lNFn4/rhIGjcY/kn/Sb9lekf6Pe9a0LxN0LDmNdels6RcAA9q50OwFa1YtGAH/e6t76tyyzNmdyq+j4u0Y+wniI0oJrj5e+T9IYLahuUI28Ydn8sNQT6XwdFcfMT1M6S/BBjYEdd/JEICmUnILwZCrFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbMwWP+O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239751F000E9;
	Sat, 20 Jun 2026 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781945625;
	bh=u8+egrML541MWpVVt07sjq5yP5ImkoHuZ/0MZ8y1gg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbMwWP+OaUZQPJMq0cU94POElOt381gzO7lVWcWpjfoKStmc75w+NTkz8MJ76jMIa
	 L8EASZqerFldTUtqDkUQLke/ZaHg3KAHPDys2XuUB02AVf48l6jsNxTvgPNfwaCgJ6
	 KpqzSkYG6Y9mbhRh7NLifqUVKT9dvDROm2AbUU9oIi5booQnBl/4TP6pYYjhu0cFMU
	 mzoGcI+6SUPiDrevr/xZxtO4eyz69EK37qwX5ZaQPgwwkcmKmQZ4ThFrcdzLf4WICv
	 3HT61xPbZUlzU3Ilx513/2CyRMyHbFUFPfb0YOHklKzObZ397WjaQPfzlL46JiLalV
	 09x4CsWyEpANg==
From: Simon Horman <horms@kernel.org>
To: sergey.temerkhanov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v2] ixgbe: Implement PCI reset handler
Date: Sat, 20 Jun 2026 09:53:27 +0100
Message-ID: <20260620085327.965597-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618142212.310475-1-sergey.temerkhanov@intel.com>
References: <20260618142212.310475-1-sergey.temerkhanov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300785-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sergey.temerkhanov@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:pmenzel@molgen.mpg.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87BB56A89F8

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: Implement PCI reset handler

Implement PCI device reset handler to allow the network device to
get re-initialized and function after a PCI-level reset.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[ ... ]
> @@ -12338,6 +12338,86 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
> +static void ixgbe_reset_prep(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	if (!adapter)
> +		return;
> +
> +	if (poll_timeout_us(test_and_set_bit(__IXGBE_RESETTING, &adapter->state),
> +			    test_bit(__IXGBE_RESETTING, &adapter->state),

[Severity: Medium]
Does this introduce a new instance of an ad-hoc bit lock?

According to the networking drivers guidelines, using bit operations like
test_and_set_bit() to guard critical sections instead of proper
synchronization primitives like a mutex or spinlock can hide issues from
lockdep and lacks deadlock detection.

[Severity: Critical]
Does this misuse the poll_timeout_us() macro?

The macro executes the operation before evaluating the condition. Since
test_and_set_bit() unconditionally sets the bit to 1, test_bit() will always
evaluate to true on the very first loop iteration, regardless of whether the
lock was already held.

Doesn't this completely break mutual exclusion?

> +			    IXGBE_RESET_PREP_POLL_INTERVAL_US,
> +			    IXGBE_RESET_PREP_TIMEOUT_US, false)) {
> +		/* ixgbe_reset_done() will exit early if this happens.
> +		 * A retry will be needed
> +		 */
> +		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
> +		return;

[Severity: High]
If this times out and returns early, won't it abandon the software
reinitialization process while the PCI subsystem proceeds with the physical
reset?

The .reset_prepare callback returns void, so the reset continues. By
returning early without setting __IXGBE_PCIE_RESET_IN_PROGRESS, critical
teardowns are skipped, and ixgbe_reset_done() will also bail out early:

ixgbe_reset_done() {
    if (!test_and_clear_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state)) {
        e_err(drv, "Reset done called without PCIe reset in progress\n");
        return;
    }
}

Could this permanently break the network interface until the module is
reloaded?

> +	}
> +
> +	/* Sync __IXGBE_RESETTING */
> +	smp_mb__after_atomic();
> +
> +	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
> +		/* Prevent the service task from being requeued in the timer callback */
> +		timer_delete_sync(&adapter->service_timer);
> +		/* Cancel any possibly queued service task */
> +		cancel_work_sync(&adapter->service_task);

[Severity: Critical]
Can this sequence cause a deadlock with the service task?

Here in ixgbe_reset_prep(), __IXGBE_RESETTING has just been acquired,
and then cancel_work_sync(&adapter->service_task) blocks waiting for
the service task to complete.

However, if the active service task reaches ixgbe_reinit_locked():

ixgbe_reinit_locked() {
    while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state))
        usleep_range(1000, 2000);
    ...
}

The service task will spin infinitely waiting for __IXGBE_RESETTING to be
cleared. Since ixgbe_reset_prep() holds the bit lock and is blocked waiting
for the service task, neither thread can make progress.

> +	}
> +
> +	pci_clear_master(pdev);
> +
> +	set_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state);
> +}
[ ... ]
> +static void ixgbe_reset_done(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
[ ... ]
> +	/* Allow the service task to run */
> +	if (!test_bit(__IXGBE_REMOVING, &adapter->state)) {
> +		clear_bit(__IXGBE_RESETTING, &adapter->state);
> +		/* Sync __IXGBE_RESETTING */
> +		smp_mb__after_atomic();

[Severity: Medium]
Does this provide the correct release semantics for the ad-hoc lock?

The clear_bit() operation does not imply a memory barrier, and
smp_mb__after_atomic() only orders memory operations that occur after the
atomic operation.

Could memory accesses from within the critical section (like the
pci_set_master() call earlier) bleed past the lock release, allowing other
threads to acquire the lock too early?

Is it possible to use clear_bit_unlock() or place an smp_mb__before_atomic()
prior to the clear_bit() instead?

> +	}
[ ... ]

