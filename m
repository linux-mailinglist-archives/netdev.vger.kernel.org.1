Return-Path: <netdev+bounces-277226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLKnN6Vt2GnhdAgAu9opvQ
	(envelope-from <netdev+bounces-277226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA583D1D00
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B91300C90A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CB30DD2F;
	Fri, 10 Apr 2026 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+sklYHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C41E4AF;
	Fri, 10 Apr 2026 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791484; cv=none; b=r6EVvBsjCPwos6+dhGyE8sbSaNjrLmxktgo9ypu1bZrJP7PcSrh4wAxrmnKaFPqul7bsTPb4ohqAeW3JEkxbAlsMV/MEuI4i/H0vC89NNqvWcc4qed3w83DWNvBVbRIHPwnlYNjL9iq7aypByGeQluroBf6zsd0xhFgshvpKqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791484; c=relaxed/simple;
	bh=pWPvrDdp8tudvhLYftIRn9t4Z7xfGRGUZGxtFyp27FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saoPL1CgHOJMZ/IwoFLXUhP2KZ/aQw+WghC1tMeBotFncN14bZ9+FXpJF5zE2/w3xCf1VhpbT+Ual5wwcU/O8YJFVaCLZl4rUP7k3mskvhgqL2cc4uMH6nhfmQ5NmDHJUb1wUIYQ5znlmOZIo/CVD9nXeO18sUYS+UOkdHMWa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+sklYHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605DCC4CEF7;
	Fri, 10 Apr 2026 03:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775791484;
	bh=pWPvrDdp8tudvhLYftIRn9t4Z7xfGRGUZGxtFyp27FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+sklYHzXdILqFdlRc+G9hNyVH8/MpnfV7Gvx4dMVOrVaDqeHNnT2ugWjm8UplT8l
	 eUZIvkmCMfh9bBfZUwvpL6XtsaulkYQhGQLQ0+mEkf+nBcd5Yic3paUG7rmaMrhTQI
	 E7RNEAoxjbkHlBtkgEKvLS1+6XQqJ+ci9OIncVAA8lAblRDzpmpaH1ritcn5OgS4+3
	 OrPib/5oXox8yQj3OUIGJ6Ojb/imRE1+/qrk0rdBPjjUNcjYySQpztG9iGHK+gsEWn
	 rKBVkkNKRrHMwBQiWOIK5W//gyqnbw8TgcJg39013PlO7jPZYLIqNYCR5tm163/ReK
	 daFeto1kafQTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	Jonathan.Cameron@huawei.com,
	lihuisong@huawei.com
Subject: Re: [net-next v38] mctp pcc: Implement MCTP over PCC Transport
Date: Thu,  9 Apr 2026 20:24:41 -0700
Message-ID: <20260410032441.1844450-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
References: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-277226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uefi.org:url,dmtf.org:url]
X-Rspamd-Queue-Id: 2FA583D1D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
mctp pcc: Implement MCTP over PCC Transport

This commit implements a network driver for the Management Component
Transport Protocol (MCTP) over the Platform Communication Channel (PCC).

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c

[ ... ]

> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
> +{

[ ... ]

> +	// The message must at least have the PCC command indicating it is an MCTP
> +	// message followed by the MCTP header, or we have a malformed message.
> +	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr)) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +
> +	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);

Can this size calculation wrap around? Because pcc_header.length is read from
shared memory, a maliciously large value (e.g. 0xFFFFFFF8) could wrap around
the unsigned 32-bit addition, resulting in a small positive size.

This small positive size would then bypass the check below, and eventually
fail in skb_pull(), leaving the malformed skb to be passed to the network
stack.

> +	// If the reported size is larger than the shared memory, something is wrong
> +	// and the best we can do is treat it as corrupted data.
> +	if (size > inbox->chan->shmem_size) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}

[ ... ]

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{

[ ... ]

> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;

Are these assignments writing native endian values into shared memory?

The ACPI Platform Communications Channel specification defines the shared
memory region as strictly little-endian. Writing without cpu_to_le32() will
cause big endian architectures to write byte-swapped metadata, resulting in
dropped packets.

> +
> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
> +	if (rc < 0) {

[ ... ]

> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
> +{

[ ... ]

> +	if (skb->len > outbox->chan->shmem_size) {
> +		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}

If the skb is oversized, this skips the copy and returns, but does it abort
the transmission?

Since mctp_pcc_tx() already submitted the message and tx_prepare() returns
void, the hardware doorbell will still be rung. The remote endpoint would
process the unmodified shared memory, replaying the previous packet's data.

> +	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);

Is it possible to read out of bounds here if the skb is fragmented?

The skb->data pointer only points to the linear portion of the packet, while
skb->len represents the total packet length including page fragments.
skb_cow_head() does not linearize the packet, so a call to skb_linearize()
might be needed before copying.

> +}
> +
> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct sk_buff *skb = mssg;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
> +	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);

Could this lead to sequence counter corruption and deadlock?

mctp_pcc_tx() runs in process or softirq context and calls
dev_dstats_tx_dropped(). mctp_pcc_tx_done() runs in the controller's hardirq
context and calls dev_dstats_tx_add().

The generic dev_dstats_* macros use u64_stats_update_begin(), which does not
disable interrupts. If a hardware interrupt fires while the softirq path is
inside u64_stats_update_begin(), the hardirq path will re-enter the lock.

> +	dev_consume_skb_any(skb);
> +	netif_wake_queue(mctp_pcc_ndev->ndev);
> +}

[ ... ]

> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	unsigned int count, idx;
> +	struct mbox_chan *chan;
> +	struct sk_buff *skb;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	chan = mctp_pcc_ndev->outbox.chan->mchan;
> +
> +	scoped_guard(spinlock_irqsave, &chan->lock) {
> +		chan->active_req = NULL;

Does this bypass the mailbox API and cause a memory leak?

By explicitly setting active_req to NULL without freeing the in-flight skb,
the skb is leaked.

Additionally, when the hardware completion interrupt fires, mbox_chan_txdone()
will pass NULL as the mssg parameter to mctp_pcc_tx_done(). Since
mctp_pcc_tx_done() dereferences skb->len, this will result in a NULL pointer
dereference.

> +		while (chan->msg_count > 0) {
> +			count = chan->msg_count;
> +			idx = chan->msg_free;
> +			if (idx >= count)
> +				idx -= count;
> +			else
> +				idx += MBOX_TX_QUEUE_LEN - count;

Is this index calculation accurate?

Since msg_free is incremented and msg_count is decremented in each iteration
below, the calculated idx jumps by 2. This skips alternate skbs, leaking
them, and reads uninitialized memory, which is then passed to
dev_consume_skb_any(), causing a use-after-free or double free.

> +			skb = chan->msg_data[idx];
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +			chan->msg_count--;
> +			chan->msg_free++;
> +		}
> +	}

[ ... ]

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;

[ ... ]

> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}

What happens if the _CRS table contains fewer than two PCC_DWORD_TYPE
resources?

If context.index is not verified to be at least 2 here, context.inbox_index
and context.outbox_index might remain uninitialized or at their default zero
values. This could cause the driver to blindly request PCC channel 0, which
may belong to another hardware subsystem.

> +
> +	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
-- 
pw-bot: cr

