Return-Path: <netdev+bounces-273016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V0D0GWuWyWmjzgUAu9opvQ
	(envelope-from <netdev+bounces-273016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C523541DA
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EF833001878
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BE25A2B5;
	Sun, 29 Mar 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izoiZh7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8383238171;
	Sun, 29 Mar 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774818915; cv=none; b=aWBN3qeByuOiPZP/trXTsaXruG8RdKG1FWREeTrx61iziSWm9YWGtNDogKFw9j6wR0gNObQap83AC/PWV2OZyHZWmxHmWwLRsSsQvH+bsOPYy5kQXmu6REEYDkGrBirBjjYk17jlhvs9PP3DsEsuSzBs3W844anxS1MDLvqmFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774818915; c=relaxed/simple;
	bh=i8sKF4CRcxyNRBNIzQkdDRtqPMWTv44zKumXQN18jEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKAfqRN1u1mhVgTfsAZR6Mokn09IuvSTUSfQTLdwLIZVsmiBRO2w3kyGKBjNLtXhNrzL3QfKkTVoqs47qWInrJ6UnbSd4ic5801ajPYN7nnLtUWw1nDs0T5HJ6s/AorWq7V2fKV+e09lrm+k+QAfXd+pR3wzQyPwPgq7KdpkCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izoiZh7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5AC116C6;
	Sun, 29 Mar 2026 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774818915;
	bh=i8sKF4CRcxyNRBNIzQkdDRtqPMWTv44zKumXQN18jEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izoiZh7JoS+DJxYDJKHogpxtNnkCcW2SAut1teliCHSU4TDEaaGPooMpRcOGoqbiM
	 HYQHvA+D5rSd0B0jwhWl8DRDzx0+x4sybAWwbh9eHEK/L+kvSa71Rr1ezNWWqAVJzk
	 VeuacqQpCLKz5PP2QWcFFm/S+grdhjSp0j4MCbgl6kLFnCOLba95vtN6V+0wYvLS/G
	 0aUC//aBO4bfg8iCT6NUbsnFWk/B+rvaP9imDR+oZ7UvcyFf0XrP1A3qLjwkytxBNp
	 nGkwhlZ1nVEIqRXLiMXwXCJ/ATU5fafgeeXKEmS1z7uHX/DCo1ieBLwQd0ma4o8j/Z
	 c7W7YWKl+vrpw==
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	jk@codeconstruct.com.au,
	Jonathan.Cameron@huawei.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	lihuisong@huawei.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	matt@codeconstruct.com.au,
	edumazet@google.com
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
Date: Sun, 29 Mar 2026 14:15:13 -0700
Message-ID: <20260329211513.2869470-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325194256.988853-1-admiyo@os.amperecomputing.com>
References: <20260325194256.988853-1-admiyo@os.amperecomputing.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273016-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,uefi.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56C523541DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
mctp pcc: Implement MCTP over PCC Transport

This commit implements a network driver for the Management Component
Transport Protocol (MCTP) over Platform Communication Channel (PCC).
It creates MCTP network devices via ACPI that communicate through shared
memory and mailbox mechanisms.

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..77cd4091050c 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
>  	  A MCTP protocol network device is created for each I3C bus
>  	  having a "mctp-controller" devicetree property.
>
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI

Can MCTP_TRANSPORT_PCC be selected when CONFIG_PCC is disabled?

The Kconfig depends only on ACPI but uses pcc_mbox_request_channel() and
pcc_mbox_free_channel() from the PCC mailbox driver (drivers/mailbox/pcc.c).
When CONFIG_PCC is not set, include/acpi/pcc.h provides stub functions
that make pcc_mbox_request_channel() unconditionally return ERR_PTR(-ENODEV).

This means the driver compiles but initialize_MTU() fails, ndo_open() fails,
and no MCTP-over-PCC communication is possible.

> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DSDT/SSDT that matches the identifier. The Platform
> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.

[ ... ]

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..fe08fd041d9c
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c

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
> +
> +	if (pcc_header.length <= 0)  {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +
> +	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +	skb_put(skb, size);
> +	skb->protocol = htons(ETH_P_MCTP);
> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);

Can pcc_header.length exceed inbox->chan->shmem_size?

The pcc_header is read from shared memory controlled by the remote endpoint.
The only validation is pcc_header.length <= 0. The size is calculated as:

    size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header)
         = pcc_header.length + 12

If the remote endpoint sets pcc_header.length to a value larger than
shmem_size, memcpy_fromio() reads beyond the ioremapped region.

> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
> +	skb_pull(skb, sizeof(pcc_header));
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +}

[ ... ]

> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +
> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
> +	return 0;
> +}

Does mctp_pcc_ndo_stop() leak SKBs queued in the mailbox?

Looking at mbox_free_channel() in drivers/mailbox/mailbox.c, the
documentation states "The queued TX requests are simply aborted, no
callbacks are made." The implementation sets chan->cl = NULL and
chan->active_req = NULL but does not free the SKBs stored in
chan->msg_data[].

The mailbox ring buffer can hold up to MBOX_TX_QUEUE_LEN (20) entries.
When the network interface is stopped, any SKBs queued there are leaked
because:

1. The networking stack already returned NETDEV_TX_OK, so it won't free them
2. tx_done will never be called since chan->cl is NULL

The commit message claims "Stopping the interface also frees any packets
that are cached in the mailbox ringbuffer" but this doesn't appear to
happen.

[ ... ]

> +static int initialize_MTU(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct pcc_mbox_chan *pchan;
> +	int mctp_pcc_mtu;
> +
> +	mctp_pcc_mtu = MCTP_MIN_MTU;
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	outbox = &mctp_pcc_ndev->outbox;
> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(pchan))
> +		return -1;
> +
> +	mctp_pcc_mtu = pchan->shmem_size;
> +	pcc_mbox_free_channel(pchan);
> +
> +	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);

What happens if pchan->shmem_size is smaller than 16 bytes?

The function subtracts sizeof(struct acpi_pcct_ext_pcc_shared_memory)
(16 bytes) from pchan->shmem_size (u64) through the local int variable
mctp_pcc_mtu. If shmem_size is smaller than 16, the subtraction produces
a negative int which wraps when assigned to ndev->max_mtu (unsigned int),
resulting in a value near UINT_MAX.

When packets are transmitted, mctp_pcc_tx_prepare() calls:

    memcpy_toio(outbox->chan->shmem, skb->data, skb->len)

where skb->len can far exceed the actual mapped region (only shmem_size
bytes were ioremapped), causing writes beyond the mapped region.

> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}

[ ... ]
-- 
pw-bot: cr

