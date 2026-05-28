Return-Path: <netdev+bounces-292597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFrZB4sBGGrUYwgAu9opvQ
	(envelope-from <netdev+bounces-292597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:49:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B279A5EEEE2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB71D3028088
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68515385D62;
	Thu, 28 May 2026 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaB3iKHH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03ED384256
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957992; cv=none; b=qEmG3RCGe940OHrfEhJW9GJaDV6eDSNCRnw0Yj+SAAB7xo2JR78adNFqj9ulAqZhk+Mdg35Cf+wYeyn6H/kHlsSAHv6UcwbCxeeSdohryk6toNCrV7pInR0bdOG1abryOnEobHzbvrr98ru2XeQItVkOvzRjyfR8Tnjum03woXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957992; c=relaxed/simple;
	bh=fMYM8JCqKPobhx2+XeGMkMpSBVUS/gO5pEaKPyCgPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aroC8W1ZDaaJytmSKZ10IXsqQF4mJXK8aGDmq0m3E1EV56zp40c3ZIq16qf+HaEcwc4FrKj6+2bqEfv+SDiBdZcDadPx8UyhxZSBL0VB7JwJpXHApnly2/wCFo9K4njuRp3crsneJ5ZG7SFCLlwlSCk0RppD6/5Paf6KxThJkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaB3iKHH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779957988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR0GTLA4LMNs6rxCEoSZelP/CQcjAvND8QxJ3RJxiXA=;
	b=OaB3iKHHgbjyCr4hCFQgrqf0s3rgqqushhMiQp9DcnJjc9ukRktuwWT8L4s51/Mq5PpL8O
	5rYNytL0uEb3YqpgB7e8s45sv+NkXDzE2IOz3r3JZL0ThfaUrh0ZIOjwNbsVM5s4leHHSH
	6hoAmzXAm/YaCjtCw9IDKnNUdoO5ImU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-F9MXNAPVOcOzKW2vJCAlmQ-1; Thu,
 28 May 2026 04:46:22 -0400
X-MC-Unique: F9MXNAPVOcOzKW2vJCAlmQ-1
X-Mimecast-MFC-AGG-ID: F9MXNAPVOcOzKW2vJCAlmQ_1779957981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D6D19560BB;
	Thu, 28 May 2026 08:46:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 831561800760;
	Thu, 28 May 2026 08:46:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: admiyo@os.amperecomputing.com
Cc: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	Jonathan.Cameron@huawei.com,
	lihuisong@huawei.com
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 28 May 2026 10:45:44 +0200
Message-ID: <20260528084611.133703-1-pabeni@redhat.com>
In-Reply-To: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292597-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: B279A5EEEE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
mctp pcc: Implement MCTP over PCC Transport

This patch adds a new mctp-pcc network driver that implements the DMTF
DSP0292 binding for MCTP over the ACPI Platform Communication Channel.
Type 3 channels are used for transmit and Type 4 channels for receive,
with each interface created from a DMT0001 ACPI device referencing two
PCC subspaces.

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

A few questions inline below.

[Low]
The Link tag and the body of the commit message both reference
DSP0292_1.0.0WIP50. Is it intentional to merge an in-tree binding
based on a Work-In-Progress draft of the spec rather than the
published 1.0.0?

Anything userspace-visible that ships in this driver (the netdev name
mctppccN, the ARPHRD type, the literal "MCTP" marker overloaded into
the PCC command field) becomes a de-facto ABI once it lands in a
stable kernel; if the published DSP0292 finalises any of those points
differently, the kernel would have to keep bug-compatibility with the
WIP variant. Could the rationale for picking the WIP baseline be
captured in the commit message, or alternatively could the merge wait
on the published revision?

> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..e68d23794a80 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
>  	  A MCTP protocol network device is created for each I3C bus
>  	  having a "mctp-controller" devicetree property.
>  
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	depends on PCC
> +	depends on 64BIT
> +	depends on CPU_LITTLE_ENDIAN

[Medium]
Could the rationale for depends on 64BIT and depends on
CPU_LITTLE_ENDIAN be added to the commit message?

DSP0292 and ACPI PCC are not 64-bit-only, and the PCC shared memory
header is fixed little-endian which can be handled with __le32 fields
and le32_to_cpu()/readl() accessors so the driver runs on any host
endianness. Other PCC consumers such as drivers/acpi/cppc_acpi.c and
drivers/mailbox/pcc.c are not LE-only.

If these depends on lines are present to paper over byte-handling
choices in the driver, would it be preferable to use endian-correct
accessors and drop the dependencies?

> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
[ ... ]

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..f2dd5286efa7
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024-2026, Ampere Computing LLC
> + *
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> + */

[Low]
The header comment says DSP0256 but the URL and the commit message
both say DSP0292. DSP0256 is a different DMTF document (PLDM for
Monitoring and Control). Should the comment read DSP0292?

[ ... ]

> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_MIN_MTU            68
> +#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
> +#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
> +#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))

[Low]
PCC_EXTRA_LEN refers to pcc_header, which is not a global symbol or
type but a local variable inside mctp_pcc_client_rx_callback(). It
expands successfully today only because every caller happens to have
a pcc_header in scope. Would something like the following be more
robust?

  #define PCC_EXTRA_LEN (PCC_HEADER_SIZE - \
      sizeof_field(struct acpi_pcct_ext_pcc_shared_memory, command))

[ ... ]

> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *inbox;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	int size;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
> +	inbox = &mctp_pcc_ndev->inbox;
> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));

[High]
Can this dereference a NULL shmem during teardown?

Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
channel's shmem is iounmapped (and the pointer cleared) before the
shutdown path runs free_irq(). Until free_irq() returns, an inbound
doorbell on another CPU can still fire pcc_mbox_irq, which calls
mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
still set at that moment) — landing here.

Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callback
do not touch shmem from their callback, so this driver appears to be
the first one to expose this ordering.

Should the rx_callback bail out when inbox->chan->shmem is NULL, or
should the ordering in pcc_mbox_free_channel() (free_irq before
iounmap) be addressed in the mailbox layer first?

> +
> +	// The message must at least have the PCC command indicating it is an MCTP
> +	// message followed by the MCTP header, or we have a malformed message.
> +	// This may be run on big endian system, but the data in the buffer is
> +	// explicitly little endian.

[Medium]
This comment claims the callback may run on a big-endian system, but
the Kconfig has depends on CPU_LITTLE_ENDIAN, and the u32 fields
length, command and signature are read from MMIO via memcpy_fromio
without any le32_to_cpu() or readl() byteswap. On big-endian, those
header fields would be misinterpreted.

Is the comment stale, or is the intent eventually to drop the
CPU_LITTLE_ENDIAN dependency? If a future change relaxes the Kconfig
dependency based on this comment, the driver will silently corrupt
multi-byte header fields. Could the comment and the Kconfig be made
consistent (and the code made endian-correct if the goal is to
support BE)?

> +	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
> +		goto error;
> +
> +	// If the reported size is larger than the shared memory minus headers,
> +	// something is wrong and treat the buffer as corrupted data.
> +	if (pcc_header.length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
> +		goto error;
> +
> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
> +		goto error;

[Low]
The TX path stamps pcc_header.signature with PCC_SIGNATURE |
subspace_id but the RX path validates pcc_header.length and the
"MCTP" command field only — signature is never checked. Would it be
worth adding a signature check here for symmetry with TX and to
reject obviously malformed peer input?

> +
> +	size = pcc_header.length + PCC_EXTRA_LEN;

[Medium]
Is the type of size correct here?

pcc_header.length is u32 and is sourced from peer-writable shared
memory. PCC_EXTRA_LEN is a sizeof() expression of type size_t. The
sum is a size_t that is then narrowed to a signed int.

The only upper bound on pcc_header.length is the earlier check
against inbox->chan->shmem_size - PCC_EXTRA_LEN. shmem_size is u64
from the PCCT and is only checked to be >= MCTP_PCC_MIN_SIZE in
mctp_pcc_open(). If firmware ever exposes a PCC channel whose
shmem_size exceeds INT_MAX, pcc_header.length can be near 4 GiB and
still pass that bound, after which size wraps to a small or negative
int.

The subsequent skb_pull(skb, sizeof(pcc_header)) on a too-small skb
ends up in __skb_pull() which calls BUG(). Would using unsigned int
or size_t for size, validating pcc_header.length against an
INT_MAX-safe bound, and sanity-checking shmem_size in mctp_pcc_open()
close this off?

> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb)
> +		goto error;
> +
> +	skb_put(skb, size);
> +	skb->protocol = htons(ETH_P_MCTP);
> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);

[Medium, Low]
Two concerns about reading from shmem here:

First, the header bytes are read twice — once into the local
pcc_header for validation, and again as the leading bytes of this
memcpy_fromio() into skb->data. Between the two reads the remote
endpoint can rewrite the shared region, so the bytes the driver
validated and the bytes the MCTP layer parses are not guaranteed to
match. A common hardening pattern is to snapshot once into a kernel
buffer, validate from the snapshot, and then either copy the
validated header into skb->data and memcpy_fromio() only the
remaining payload, or do a single MMIO copy into the skb and validate
from that copy.

Second, on weakly-ordered architectures (arm64 is included via 64BIT)
memcpy_fromio is a byte/word loop without a final dma_rmb() and the
PCC mailbox layer does not insert a barrier on the consumer side
before invoking the rx callback. Would a dma_rmb() between the IRQ
and consuming buffer contents (and between successive memcpy_fromio()
calls of the same region) be appropriate here?

> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
> +	skb_pull(skb, sizeof(pcc_header));
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +	return;
> +
> +error:
> +	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	int len = skb->len;
> +
> +	if (skb_cow_head(skb, sizeof(*pcc_header)))
> +		goto error;
> +
> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> +
> +	if (skb->len > mpnd->outbox.chan->shmem_size)
> +		goto error;

[Low]
This length check is performed after skb_cow_head() and skb_push()
have already mutated the skb. It also looks unreachable in normal
operation: net core enforces skb->len <= dev->mtu, and
initialize_mtu() sets max_mtu = shmem_size - sizeof(pcc_header), so
after the skb_push the resulting length is at most shmem_size.

Could the check either be moved before the mutation (comparing
len + sizeof(*pcc_header) against shmem_size) or removed?

> +
[ ... ]
> +	netif_stop_queue(ndev);
> +	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
> +		netif_wake_queue(ndev);
> +	} else {
> +		// Remove the header in case it gets sent again
> +		skb_pull(skb, sizeof(*pcc_header));
> +		return NETDEV_TX_BUSY;
> +	}
> +	return NETDEV_TX_OK;
[ ... ]
> +}
> +
> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct sk_buff *skb = mssg;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
> +	outbox = &mctp_pcc_ndev->outbox;
> +
> +	/* The PCC Mailbox typically does not make use of the mssg pointer
> +	 * The mctp-over pcc driver is the only client that uses it.
> +	 * This value should always be non-null; it is possible
> +	 * that a change in the Mailbox level will break that assumption.
> +	 */

[Medium]
The comment effectively concedes that this driver depends on
behaviour that other PCC clients (cppc, acpi_pcc, hisi_uncore) do not
rely on, and that a change in the mailbox layer could break it.
Building a new in-tree driver on an undocumented contract is fragile
— if PCC core ever ignores or sanitises mssg, this driver's TX path
would silently leak SKBs or crash.

Could the mssg semantics be formalised in the mailbox/PCC API, or
could the driver instead track outstanding SKBs in its own state
(for example, a single-slot or queue indexed by send order) so it
does not depend on mssg being passed through?

> +	if (!skb) {
> +		netdev_warn_once(mctp_pcc_ndev->ndev,
> +				 "%s called with null message.\n", __func__);
> +		return;
> +	}
> +	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
> +}
> +
> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int rc)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct pcpu_dstats *dstats;
> +	struct sk_buff *skb = mssg;
> +	unsigned long flags;
> +
> +	/*
> +	 * If there is a packet in flight during driver cleanup
> +	 * It may have been freed already.
> +	 */
> +	if (!mssg)
> +		return;

[Medium]
The comment describes a use-after-free hazard, but a NULL check does
not detect a freed pointer — freed memory is not NULL.

Looking at the actual cleanup path, mctp_pcc_stop() takes
chan->lock, swaps active_req to MBOX_NO_MSG and frees the skb, while
tx_tick() in drivers/mailbox/mailbox.c also reads-and-clears
active_req under the same lock before invoking tx_done. So tx_done
should never run with a freed pointer here, and this NULL check is
effectively dead.

Either the documented race is real and this guard does not actually
catch it (the subsequent dev_consume_skb_any(skb) and skb->len reads
would still touch freed memory), or the race cannot occur and the
comment is misleading. Could this be reworked so the comment matches
the actual invariants?

[ ... ]
> +}
> +
> +static int mctp_pcc_open(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox, *inbox;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	inbox = &mctp_pcc_ndev->inbox;
> +
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return -EINVAL;
> +	}
> +
> +	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
> +	if (IS_ERR(inbox->chan)) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return PTR_ERR(inbox->chan);
> +	}
> +	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		pcc_mbox_free_channel(inbox->chan);
> +		return -EINVAL;
> +	}

[Medium]
On the shmem_size validation failure paths, outbox->chan and
inbox->chan are not reset to NULL after pcc_mbox_free_channel(),
which is the invariant mctp_pcc_stop() establishes elsewhere (it
sets the pointers to NULL after freeing). After ndo_open returns an
error those fields hold pointers to channels whose shmem has been
unmapped and whose chan->cl has been cleared. Should these be
NULLed for consistency?

> +	return 0;
> +}
> +
> +static int mctp_pcc_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	unsigned int count, idx;
> +	struct mbox_chan *chan;
> +	struct sk_buff *skb;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	chan = mctp_pcc_ndev->outbox.chan->mchan;
> +	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
> +	mctp_pcc_ndev->inbox.chan = NULL;
> +	scoped_guard(spinlock_irqsave, &chan->lock) {
> +		if (chan->active_req !=  MBOX_NO_MSG) {
> +			skb = chan->active_req;
> +			chan->active_req = MBOX_NO_MSG;
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +		}
> +		while (chan->msg_count > 0) {
> +			count = chan->msg_count;
> +			idx = chan->msg_free;
> +			if (idx >= count)
> +				idx -= count;
> +			else
> +				idx += MBOX_TX_QUEUE_LEN - count;
> +			skb = chan->msg_data[idx];
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +			chan->msg_count--;
> +		}
> +	}

[High]
Should this driver be reaching into the private internals of struct
mbox_chan?

This block takes chan->lock (commented in mailbox_controller.h as
"Serialise access to the channel"), reads and clears chan->active_req,
walks chan->msg_data[] using a verbatim copy of msg_submit()'s tail
math:

    count = chan->msg_count;
    idx = chan->msg_free;
    if (idx >= count)
        idx -= count;
    else
        idx += MBOX_TX_QUEUE_LEN - count;

and decrements chan->msg_count. These fields are owned by
drivers/mailbox/mailbox.c and there is no public API for clients to
drain queued TX messages.

Note also that chan->msg_free is never advanced by this loop, leaving
the channel with msg_count=0 but msg_free unchanged — this only
happens to be safe because pcc_mbox_free_channel() runs immediately
afterwards.

Any future change to the mailbox queue layout, locking primitive, or
indexing semantics would silently produce leaks, double-frees, or
corruption in this driver only. Would it be feasible to add a generic
mbox_drain_channel() helper, or have the mailbox call tx_done with a
failure code on free, instead of duplicating this internal logic in a
client?

> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +	mctp_pcc_ndev->outbox.chan = NULL;
[ ... ]
> +	return 0;
> +}
[ ... ]
> +static int initialize_mtu(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct pcc_mbox_chan *pchan;
> +	int mctp_pcc_max_mtu;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	outbox = &mctp_pcc_ndev->outbox;
> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(pchan))
> +		return PTR_ERR(pchan);
> +	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
> +		pcc_mbox_free_channel(pchan);
> +		return -EINVAL;
> +	}
> +	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +	pcc_mbox_free_channel(pchan);

[Medium]
Probe time acquires the outbox channel just to read shmem_size and
then immediately releases it; mctp_pcc_open() requests the same
channel again on first ifup. A few questions:

This maps and unmaps shmem twice. Could shmem_size be obtained
without binding the channel (for example by inspecting the PCCT
entry) or by acquiring the channel once and holding it across probe
and open?

There is also a small TOCTOU window between probe and ifup where
nothing prevents another mailbox client from grabbing the channel —
pcc_mbox_request_channel() returns -EBUSY if chan->cl is set, so a
later ndo_open would silently fail.

Finally, only the outbox shmem_size is validated at probe time; the
inbox is only validated on first open. Should both be checked at the
same point?

> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_max_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
[ ... ]
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->ndev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	rc = initialize_mtu(ndev);
> +	if (rc)
> +		goto free_netdev;
> +
> +	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}

[Medium]
acpi_dev->driver_data is set to mctp_pcc_ndev before initialize_mtu()
and mctp_register_netdev() are called. On the goto free_netdev path,
free_netdev(ndev) frees the netdev along with the embedded
mctp_pcc_ndev, but acpi_dev->driver_data still points at that freed
memory. ACPI does not call .remove() when .add() returns non-zero,
so nothing zeroes the pointer afterwards.

Would it be safer to set acpi_dev->driver_data only after all the
fallible operations succeed, or to NULL it on the error path?

> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001" },
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",

[Low]
Is .class = "Unknown" intentional? The ACPI subsystem exposes this
string via sysfs and uses it for grouping. A more meaningful value
(for example "mctp_pcc") or omitting the field would seem
preferable for a new in-tree driver.

> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
-- 
This is an AI-generated review.


