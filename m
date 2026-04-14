Return-Path: <netdev+bounces-278255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEgUJBGK3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:28:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA73F4765
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0655430D7759
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E223EAA6;
	Tue, 14 Apr 2026 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucuqy8xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D4221FB6;
	Tue, 14 Apr 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126156; cv=none; b=RArGuC0nJc2CoR2ujtfBqxn/U0a/Bw7vjCUk8R/8yG6/unvUmwxviCBwK/OKv4i3MinLzOokCuSwt7+dgKiVCxwdp7uBjZwYh19j/wmuzTp+FGWaussBYZSUGUX7qPQEtATyVaxJLTW2s51+UbiYr8MorVJdPhzh+748QIrEFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126156; c=relaxed/simple;
	bh=SzyqCF4Cma1yPoJZR71AvrW4v5Oelm/MwCK6NUYCvqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGycmZIC7X8+Hd96xTpQg+/XVTdnFFlIhXt27xEX5mBSMpZiO3GTcZZk17wzUZgafe3k3yaCWtm9ghp2NNbEY7o7xDh+smdosB9RCePU3dq1GnJxCeRVEVqf8DTVcyZwzUMdMAV2XOblkJdbIgJsbz+Kaz3nEdWyxMAVhXZ1v3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucuqy8xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4240DC2BCAF;
	Tue, 14 Apr 2026 00:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126155;
	bh=SzyqCF4Cma1yPoJZR71AvrW4v5Oelm/MwCK6NUYCvqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucuqy8xbDth4UHXPH5VcdM0Y3+aHWaDRuCT461Ng0Xq0UgM/0DQSLnN4TheKdgNoI
	 3C/nG51L0cksuMGtp32r2gTJFgloQ258iVHyll0WPMihs2y9WjeYp9l92F0SHp57cw
	 Rq4nTUFl//lWGepFfzYbz2e6tUb+Ak+RgRIhyheQRJxB8glGw72c5M7Jyl43+CrxEG
	 mAJV1WgHC+cI/HaSD6levRuHpTbTE/c7aeG9VAQhqLU1eLJ+C4go8yIuN7mEx346FF
	 bTUaGDoGIOe6uQeshsQUO/kpDGlmGSFq2v3vsy4sqxNgZ6ljPyIe5JUF5W91LpsOFY
	 sIEbgNcay5cow==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 10/10] enic: add V2 VF probe with admin channel and PF registration
Date: Mon, 13 Apr 2026 17:22:34 -0700
Message-ID: <20260414002234.3735463-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-10-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-10-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278255-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8CA73F4765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add V2 VF probe with admin channel and PF registration

When a V2 SR-IOV VF probes, open the admin channel, initialize the
MBOX protocol, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 057716ccc2837..bf4417e67b16d 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
[ ... ]
> @@ -2992,6 +2997,32 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_out_dev_close;
>  	}
>  
> +	/* V2 VF: open admin channel and register with PF.
> +	 * Must happen before register_netdev so the VF is fully
> +	 * initialized before the interface is visible to userspace.
> +	 */
> +	if (enic_is_sriov_vf_v2(enic)) {
> +		err = enic_admin_channel_open(enic);
> +		if (err) {
> +			dev_err(dev,
> +				"Failed to open admin channel: %d\n", err);
> +			goto err_out_dev_deinit;
> +		}
> +		enic_mbox_init(enic);

Could this ordering cause a race condition with an uninitialized completion object?

enic_admin_channel_open() dynamically allocates the MSI-X interrupt, registers
the IRQ handler, and enables the admin hardware queues, making the interrupt
live immediately.

Only afterward is enic_mbox_init() called, which initializes the
enic->mbox_comp completion struct. If a spurious interrupt or a left-over
admin message causes the admin NAPI poll handler to fire between these two
calls, it will attempt to call complete(&enic->mbox_comp) before the
completion struct's internal lock has been initialized.

Also regarding the admin channel resources, are we properly handling the admin
channel across a soft reset?

When the driver recovers from a Tx hang or queue error via
enic_tx_hang_reset() or enic_reset(), it issues a CMD_SOFT_RESET to the
firmware, which resets and disables all hardware queues on the VNIC. The
recovery path then calls enic_init_vnic_resources(), which only re-initializes
and enables the datapath queues (wq, rq, cq).

It completely ignores the admin channel queues (admin_wq, admin_rq, admin_cq).
As a result, the admin queues remain disabled in hardware and desynchronized
from the software descriptors.

> +		err = enic_mbox_vf_capability_check(enic);
[ ... ]
> @@ -3156,6 +3199,17 @@ static void enic_remove(struct pci_dev *pdev)
>  		cancel_work_sync(&enic->reset);
>  		cancel_work_sync(&enic->change_mtu_work);
>  		unregister_netdev(netdev);
> +		if (enic_is_sriov_vf_v2(enic)) {
> +			if (enic->vf_registered) {
> +				int unreg_err = enic_mbox_vf_unregister(enic);
> +
> +				if (unreg_err)
> +					netdev_warn(netdev,
> +						    "Failed to unregister from PF: %d\n",
> +						    unreg_err);
> +			}
> +			enic_admin_channel_close(enic);
> +		}

Does this unregistration ordering introduce a use-after-free on the freed
netdev?

Because the admin interrupt is not masked by ndo_stop(), it remains fully
active after the network device is shut down. If the PF asynchronously sends a
link state notification after unregister_netdev(netdev) but before
enic_admin_channel_close(enic):

The admin workqueue will process the notification and call
netif_carrier_on(enic->netdev). This adds the device to the lweventlist and
calls dev_hold(dev), bumping dev->pcpu_refcnt.

However, unregister_netdev() has already completed its wait for pcpu_refcnt to
drop to zero. The driver then proceeds to call free_netdev(netdev), freeing
both the pcpu_refcnt allocation and the netdev memory. When the linkwatch
worker subsequently processes the event, it accesses this freed memory.

Should the admin channel be closed before unregister_netdev()?

> diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
> index 436326ace0499..74cd2ee3af5cb 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_res.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_res.c
> @@ -211,7 +211,8 @@ void enic_get_res_counts(struct enic *enic)
>  		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
>  		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
>  			ARRAY_SIZE(enic->admin_cq) &&
> -		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
> +		(enic_is_sriov_vf_v2(enic) ||
> +		 vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1);

Does this configuration lead to interrupt resource exhaustion and probe failures?

enic_adjust_resources() allocates all available interrupts (minus
ENIC_MSIX_RESERVED_INTR) to data queues, which sets enic->intr_count equal to
enic->intr_avail when queue counts are maximized.

However, enic_admin_setup_intr() requires an additional interrupt at index
intr_index = enic->intr_count. This triggers the
intr_index >= enic->intr_avail bounds check and returns -ENODEV, causing the
VF probe to abort.

Additionally, on the PF side, vnic_intr_alloc() hardcodes the resource type to
RES_TYPE_INTR_CTRL, effectively stealing a standard datapath interrupt instead
of utilizing the dedicated RES_TYPE_SRIOV_INTR hardware resource provisioned
by the firmware.

