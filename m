Return-Path: <netdev+bounces-278251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGJvMGGJ3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFF3F472E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 027E730B343E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516751D5CC6;
	Tue, 14 Apr 2026 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufFhFhzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB761D435F;
	Tue, 14 Apr 2026 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126114; cv=none; b=R07kOdOH8bwg/CIv6B28hEQcvNbtnsSJMjG5nSR0yeWvFcKkmL2yKEukxfMdOgwGBEqJ5YPBNy83gMS1LOGqBJunnFelbdAEqg77YuiSQC18x+AC2VNMBhCtkIcPsyk0u19TdRG0X/Lvw7yzisc64RMxu+GAxtRXPSNE8anIVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126114; c=relaxed/simple;
	bh=7Hd2NfLgh1FWZDBaXvUXeKpw88gHhevuy9a73OHY8w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpvxsLwpBwW8wLzYv79mkjXQCM18OiLE5ylWHVopEM36CgfKB9ZtLDqQyV87hH0tBygvo7uFcK07H3/ZMEHgC9QeQems+u5HFDLQe2mMGH+NYHsNmTsl+2fdi0zc2hNkThoL5o6W4ZnuGxgz97d2YeJZucG3C16hYEKD9P7n6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufFhFhzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB49C2BCAF;
	Tue, 14 Apr 2026 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126113;
	bh=7Hd2NfLgh1FWZDBaXvUXeKpw88gHhevuy9a73OHY8w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufFhFhzYxYHFeNO4lb9WHqNs3YqmoXaGNQTw1BGKg1bIWygu1tLiuMJEAPL90ypen
	 CIJtWC0nAKiPMB0Sp+XTAp6zXXfVY/Wc4JJ5I1XO/GmVCbezwQ+e/UKSxUbYiIPRDU
	 twKebsh3gpn2xD9EJvdwAOvMYWf7pJt0sbonoTBkMV2VtNdAot9ZYEmfPu9H4xjI8N
	 0vZUM3wolTrswXwO35oAcIAYh8Qa/5+o3At798MfIAqoKwpsn6Avgo1IOdG4dWmix9
	 1HBBnKelchQTOps9VQt5oO5LFKYlk/v9bcpRMLOGQbz9QOBEurfnaW3kjUL6dg+IpQ
	 zN/rkEPa7SabQ==
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
Subject: Re: [PATCH net-next v4 06/10] enic: add MBOX core send and receive for admin channel
Date: Mon, 13 Apr 2026 17:21:50 -0700
Message-ID: <20260414002150.3734545-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-6-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-6-f052326c2a57@cisco.com>
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
	TAGGED_FROM(0.00)[bounces-278251-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 28BFF3F472E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: enic: add MBOX core send and receive for admin channel

This commit implements the mailbox protocol engine used for PF-VF
communication over the admin channel.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 345d194c6eebe..c96268adc173f 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
> @@ -19,6 +19,7 @@
>  #include "cq_enet_desc.h"
>  #include "wq_enet_desc.h"
>  #include "rq_enet_desc.h"
> +#include "enic_mbox.h"
>  
>  /* No-op: admin WQ buffers are freed inline after completion polling */
>  static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
>  				    struct vnic_wq_buf *buf)
>  {
>  }

If an MBOX send times out, the timeout path intentionally leaves the buffer
and DMA mapping pending to prevent a hardware use-after-free. Because this
cleanup function is a no-op, are those pending descriptors and mappings
permanently leaked when the admin channel is later closed or the driver is
removed?

[ ... ]
> @@ -156,7 +157,26 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget)
>  					buf->dma_addr, buf->len,
>  					DMA_FROM_DEVICE);
>  
> -		enic_admin_msg_enqueue(enic, buf->os_buf, buf->len);
> +		if (enic->admin_rq_handler) {
> +			struct cq_enet_rq_desc *rq_desc = desc;
> +			u16 sender_vlan;

Does this sequence process the CQ completion unconditionally without checking
the hardware descriptor for errors?

Standard data paths typically verify flags like packet_error or fcs_ok before
accepting the packet. If corrupted administrative messages are received here,
will they be processed as valid?

> +
> +			/* Firmware sets the CQ VLAN field to identify the
> +			 * sender: 0 = PF, 1-based = VF index.  Overwrite
> +			 * the untrusted src_vnic_id in the MBOX header with
> +			 * the hardware-verified value.
> +			 */
> +			sender_vlan = le16_to_cpu(rq_desc->vlan);
> +			if (buf->len >= sizeof(struct enic_mbox_hdr)) {
> +				struct enic_mbox_hdr *hdr = buf->os_buf;
> +
> +				hdr->src_vnic_id = (sender_vlan == 0) ?
> +					cpu_to_le16(ENIC_MBOX_DST_PF) :
> +					cpu_to_le16(sender_vlan - 1);
> +			}
> +
> +			enic_admin_msg_enqueue(enic, buf->os_buf, buf->len);
> +		}

Is buf->len the original static allocation size (2048 bytes) rather than the
actual number of bytes written by the hardware?

If the hardware wrote fewer bytes than the full buffer capacity, it looks
like passing buf->len will enqueue uninitialized heap memory. This would
also bypass the bounds checks in enic_mbox_recv_handler(), as the length
will appear to always be 2048 regardless of the actual packet size.

[ ... ]
> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> new file mode 100644
> index 0000000000000..d144c86d9ef84
> --- /dev/null
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
[ ... ]
> +	vnic_wq_doorbell(wq);
> +
> +	timeout = jiffies + usecs_to_jiffies(ENIC_MBOX_POLL_TIMEOUT_US);
> +	err = -ETIMEDOUT;
> +	while (time_before(jiffies, timeout)) {
> +		if (enic_admin_wq_cq_service(enic)) {
> +			err = 0;
> +			break;
> +		}
> +		usleep_range(ENIC_MBOX_POLL_INTERVAL_US,
> +			     ENIC_MBOX_POLL_INTERVAL_US + 50);
> +	}

Could this loop falsely report a timeout if the thread experiences a long
scheduling delay during usleep_range()?

If the thread wakes up after the timeout has passed, it will exit the loop
immediately without checking one last time. If the hardware actually
completed the operation during the sleep window, the completion would be
missed, incorrectly disabling the channel.

[ ... ]

