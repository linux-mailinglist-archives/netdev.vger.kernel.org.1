Return-Path: <netdev+bounces-287876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PB3OjiVBWpLYwIAu9opvQ
	(envelope-from <netdev+bounces-287876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6453FC08
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6015F3037697
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7F39D6F0;
	Thu, 14 May 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYVoSYa2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D0399004
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750676; cv=none; b=gMXdoHl1+2T1rlaeB6bL1N926Cd5S5xZPCuZZSvJALj7IaP+R32KficKEzvQF0BxxFqI9Ad0eMHx/JOYLhBt3bfVYA21cmK86d8UN3+ZUPQihgv8a8pfscazXIAsLXuD43LDAGEflMHI/dpqj1M188DU9q6ENqxewYpjvpEHQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750676; c=relaxed/simple;
	bh=i2jheD0cUUltvGibmv9bbjaVPeKNiPHEpKsDyGqDjqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeILDsoIOSJspxGrZPm8Hpwrl4wY/WQ9Bb5qeyPvrzN3gkxUzIcyPu5rw8vd2znVGnTDP3dVyLS9ZdX+OTlBaBjbA5jvUpput88NOcFHfYVa6ZOrzjrIUPJtaUuXTgNP5fJdCpou53fGJhH+44/PwO+UyMxMi6Kbc2D5pGiaJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYVoSYa2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778750673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3j06QFXutHGSOLwWfxBDGFISqmpb4y3Cflc+QGUtLs=;
	b=DYVoSYa2CWz0Qw8+FQBqJVdZfddgTxsB/ZK/d647oF6FfL0C7TjeaUBYQDkQgB8zP30YWo
	3NplwhfVJgnBzbRM0AdbXHgAt/Buelo0uJp+W8Cfh2fLu3QP+elLA5BSiSbhVbrFyVuy2v
	lwFjggkTl/OwCcM8E6DvVwqzo2uSMtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-KsM_h6_yNeGKbRU3_3tkdg-1; Thu,
 14 May 2026 05:24:27 -0400
X-MC-Unique: KsM_h6_yNeGKbRU3_3tkdg-1
X-Mimecast-MFC-AGG-ID: KsM_h6_yNeGKbRU3_3tkdg_1778750665
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F44B180035D;
	Thu, 14 May 2026 09:24:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCAA130002DA;
	Thu, 14 May 2026 09:24:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v3 5/5] net: wangxun: implement pci_error_handlers ops
Date: Thu, 14 May 2026 11:24:00 +0200
Message-ID: <20260514092415.90852-1-pabeni@redhat.com>
In-Reply-To: <20260509100540.32612-6-jiawenwu@trustnetic.com>
References: <20260509100540.32612-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 84A6453FC08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287876-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: wangxun: implement pci_error_handlers ops

This patch adds AER error_detected, slot_reset, and resume callbacks
for the libwx, ngbe, and txgbe drivers, gates pci_disable_device()
behind a new WX_STATE_DISABLED bit, and adds pci_save_state() at the
end of probe.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index deb9fac2e1a9..64d43bf6e9da 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -4,11 +4,119 @@
>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
>
> +/**
> + * wx_io_error_detected - called when PCI error is detected
> + * @pdev: Pointer to PCI device
> + * @state: The current pci connection state
> + *
> + * Return: pci_ers_result_t.
> + *
> + * This function is called after a PCI bus error affecting
> + * this device has been detected.
> + */
> +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> +					     pci_channel_state_t state)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	if (!wx)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	netdev = wx->netdev;
> +	if (!netif_device_present(netdev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	if (state == pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev))
> +		wx->close_suspend(wx);

[High]

Should this path consult pci_channel_offline(pdev) (or the state
argument) before invoking close_suspend()?  When state ==
pci_channel_io_frozen, MMIO is unreliable: reads return all-ones and
writes are dropped.

close_suspend() walks into ngbe_down()/txgbe_down(), which call
wx_disable_pcie_master() and wx_disable_rx_queue() in
drivers/net/ethernet/wangxun/libwx/wx_hw.c.  Both use read_poll_timeout
on MMIO:

  wx_disable_pcie_master() polls WX_PX_TRANSACTION_PENDING with
  WX_PCI_MASTER_DISABLE_TIMEOUT (around 80 ms)

  wx_disable_rx_queue() polls WX_PX_RR_CFG (~100 us per queue)

When the channel is frozen, those polls cannot succeed and will spin
the full timeout for every queue.  wx_update_stats() at the tail of
disable_device additionally accumulates 0xFFFFFFFF reads as garbage
counters.

Documentation/PCI/pci-error-recovery.rst suggests error_detected
should avoid MMIO when the channel is frozen and only quiesce (stop
queues, free IRQs, disable the device).  Would skipping close_suspend
or substituting an MMIO-free quiesce path be appropriate when
pci_channel_offline(pdev) is true?

> +
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
> +	rtnl_unlock();
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * wx_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Return: pci_ers_result_t.
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;

[Medium]

What unwinds the resources released by close_suspend() in
wx_io_error_detected() when this path returns
PCI_ERS_RESULT_DISCONNECT?

netif_device_detach() only clears __LINK_STATE_PRESENT; it does not
clear __LINK_STATE_START, so netif_running() still reports true.
After this failure, the AER core calls error_detected again with
pci_channel_io_perm_failure and the driver short-circuits, leaving the
netdev in a half-torn-down state until ngbe_remove/txgbe_remove
eventually runs.

In the meantime, any rtnl path gated on netif_running() (for example
wx_set_features and wx_update_rsc, which call wx->do_reset ->
reinit_locked -> *_down -> *_disable_device touching freed
wx->rx_ring[i]/tx_ring[i]) would dereference freed rings.  Should this
failure path also clear LINK_STATE_START (e.g., via dev_close()) so
those callers see the netdev as down?

> +	} else {
> +		/* make all bar access done before reset. */
> +		smp_mb__before_atomic();

[Low]

Is the comment "make all bar access done before reset." accurate?

The PCI bus reset happens before slot_reset is invoked by the AER
core, so "before reset" reads temporally backwards.  There is also no
BAR/MMIO access in this function prior to the barrier — only
pci_enable_device_mem(), which touches config space.

smp_mb__before_atomic() is a CPU barrier paired with the following
non-RMW atomic (clear_bit) per Documentation/atomic_t.txt and
memory-barriers.txt; it does not order MMIO/BAR accesses (which would
require a readback or wmb()-class primitive).  Could the comment be
updated to reflect what the barrier actually does?

> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);

[Medium]

Should pci_save_state(pdev) be called again here after
pci_restore_state(pdev)?

pci_restore_state() ends with dev->state_saved = false, and the
canonical pattern in other AER slot_reset implementations
(ixgbe_io_slot_reset, igb, e1000e) is restore-then-save so that
subsequent recovery cycles start from a known-good baseline.  Without
re-saving, repeated AER events on the same device would rely on stale
or partially-cleared per-cap save state.

> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);

[Medium]

Should rtnl_lock be held around this do_reset() call?

Every other call site of wx->do_reset() runs under rtnl_lock:
wx_reset_subtask() in wx_err.c takes it explicitly, wx_set_features
and wx_update_rsc are invoked under rtnl by netdev_ops, and
wx_io_resume() takes rtnl_lock around ndo_open.

txgbe_do_reset -> txgbe_reset writes wx->mac_table[]
(wx_flush_sw_mac_table + wx_mac_set_default_filter) and reprograms HW
(txgbe_reset_hw, wx_start_hw); ngbe_reset also writes mac_table[].
netif_device_detach() in error_detected only clears
__LINK_STATE_PRESENT and stops TX queues — it does not block
rtnl-protected ndo callbacks (ndo_set_mac_address, ndo_set_features,
ndo_vlan_rx_add_vid, ethtool_ops).  Those userspace-triggered paths
run under rtnl_lock and would concurrently modify mac_table[] / HW
registers, racing with do_reset.

> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}
> +
> +/**
> + * wx_io_resume - called when traffic can start flowing again.
> + * @pdev: Pointer to PCI device
> + *
> + * This callback is called when the error recovery driver tells us that
> + * its OK to resume normal operation.
> + */
> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		err = netdev->netdev_ops->ndo_open(netdev);
> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after reset\n");
> +			goto out;
> +		}
> +	}
> +	netif_device_attach(netdev);
> +out:
> +	rtnl_unlock();
> +}

[High]

When ndo_open() fails here, what state is the netdev left in?

ngbe_open()/txgbe_open() free their resources on failure paths and
return without clearing __LINK_STATE_START (only dev_close() does
that, and ndo_open is being called directly here).  netif_device_attach
is then skipped, so __LINK_STATE_PRESENT stays cleared.

The result is a netdev where netif_running() returns true (LINK_START
set) but PRESENT is clear, with rings/IRQs/phylink already freed by
close_suspend in error_detected and only partially re-allocated.  AER
treats recovery as complete (resume returns void).

Code paths gated only on netif_running() — wx_reset_subtask in
wx_err.c, wx_tx_timeout, wx_set_features -> wx->do_reset, ethtool
callbacks — would then dereference freed Tx/Rx rings, freed IRQ
handlers, or a disconnected phylink.  For example:

  void wx_reset_subtask(struct wx *wx)
  {
        ...
        if (!netif_running(wx->netdev) ||
            test_bit(WX_STATE_RESETTING, wx->state))
                goto out;
        ...
        if (wx->do_reset)
                wx->do_reset(wx->netdev, true);
  }

would call into reinit_locked -> *_down -> *_disable_device on freed
rings.  Should the failure path here force the netdev fully down (e.g.,
dev_close_many or equivalent) so netif_running() reports false?
-- 
This is an AI-generated review.


