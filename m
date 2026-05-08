Return-Path: <netdev+bounces-285750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMW4BEC3/Wm4hwAAu9opvQ
	(envelope-from <netdev+bounces-285750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:13:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E74F4D6F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2106630305F4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BD3A4F54;
	Fri,  8 May 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TN3CX7Ti"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F737755C;
	Fri,  8 May 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235103; cv=none; b=StJrCxPHAQ8OdEB5FB1smtxvu9Mb0ijtmQCrWVVLql0N6seYEpSxHwX69itT9qZ4gQVU7nOfZS1zy6dUIhmaSVurpAE3iFrSqTEM8QdWZvZAeRWlNF+qbBPjA+xvGxUOBEC4MXgtQTi8Bw6LkND+odULWzHJbikzZrTreYZwLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235103; c=relaxed/simple;
	bh=cR+GkrvrvBAeaQmmz7cNJHxnFSsBdmmxka4r11I7lls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGpq+Dt7BscXMNM7IynNQz+ClHOr/2/pWCxC/Cpi6XZxCWO/Z4VFsP4dCi9cWNXjWJpQm+XQ0KnZyfM4g8epZTrtQJm/9I7mmhTFRnWg7mn807oWP/5zFyRDGogCjByi6pw3QrpoeVhQ97FuAomh3vDMn5W+E+PqfO5nqg+fAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TN3CX7Ti; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1778235098;
	bh=ZmNHp33pdRvYj7JFUvpbCMHvgW37Dvl9DEZJOFwe7UY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TN3CX7TiIaKK3mG4PGMlGBCy0o33RQEewPuTn2cTHQXtbhnM+pLiS9Z9ybxwwDIyM
	 yecx73/T5R9XtTMj9RJqRI9yzMWotkkWQ6EszVvq8Q4iVDS/jUGEZKi7433puutUhE
	 J6nfzTr2kKtMb2dPT4gcHmHDufWeAawajfyStTFMl2GbJ9abhNulUWDnfjAya+Ee/u
	 3CP1Xf/CwKPSZtph0U+P0nDwaoldVt5kBW3AHaPKcO+GpwA8IvVsdciKdfVq6VaxGH
	 VM9E3+0RLLKJvQRMvrMTcSuTYlN6Ta6Puwnfze/f8GpBsgeqZvEgxOMGKRZt82X4To
	 y7eTKaH8uyeyg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 427C160007;
	Fri,  8 May 2026 18:11:37 +0800 (AWST)
Message-ID: <0d3f5d8e61cb8ad1c981880947c5ce1e7a5e956e.camel@codeconstruct.com.au>
Subject: Re: [net-next v40] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@os.amperecomputing.com>, Matt Johnston	
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Huisong Li <lihuisong@huawei.com>
Date: Fri, 08 May 2026 18:11:36 +0800
In-Reply-To: <20260508032953.337036-1-admiyo@os.amperecomputing.com>
References: <20260508032953.337036-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 221E74F4D6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285750-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Adam,

> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *ms=
sg)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *inbox;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	u32 header_length;
> +	int size;
> +
> +	mctp_pcc_ndev =3D container_of(cl, struct mctp_pcc_ndev, inbox.client);
> +	inbox =3D &mctp_pcc_ndev->inbox;
> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
> +
> +	// The message must at least have the PCC command indicating it is an M=
CTP
> +	// message followed by the MCTP header, or we have a malformed message.
> +	// This may be run on big endian system, but the data in the buffer is
> +	// explicitly little endian.
> +	header_length =3D le32_to_cpu(pcc_header.length);
> +
> +	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr=
))
> +		goto error;
> +	// If the reported size is larger than the shared memory minus headers,
> +	// something is wrong and treat the buffer as corrupted data.
> +	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
> +		goto error;
> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) =
!=3D 0)
> +		goto error;
> +
> +	size =3D header_length + PCC_EXTRA_LEN;
> +	skb =3D netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb)
> +		goto error;
> +	skb_put(skb, size);
> +	skb->protocol =3D htons(ETH_P_MCTP);
> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);
> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
> +	skb_pull(skb, sizeof(pcc_header));
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	cb =3D __mctp_cb(skb);
> +	cb->halen =3D 0;
> +	netif_rx(skb);
> +	return;
> +error:
> +	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +}

Super minor, but odd spacing here. This should probably be:

            if (!skb)
                goto error;

            [...]
            netif_rx(skb);
            return;
   =20
    error:
            dev_dstats_rx_dropped(..);
    }

(ie, with a bit of spacing after the goto and the return)

> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *n=
dev)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
> +	struct mctp_pcc_ndev *mpnd =3D netdev_priv(ndev);
> +	int len =3D skb->len;
> +
> +	/* Consolidated a fragmented packet into contiguous memory */
> +	if (skb_is_nonlinear(skb)) {
> +		if (skb_linearize(skb))
> +			goto error;
> +	}

This is still not needed.

> +
> +	if (skb_cow_head(skb, sizeof(*pcc_header)))
> +		goto error;
> +	/**
> +	 * This code could potentially be run on A Big Endian
> +	 * System.=C2=A0 The ACPI specification requires that values
> +	 * in the shared buffer be little endian.
> +	 */

Minor: You've taken out BE support, but left this comment in.

> +	pcc_header =3D skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature =3D PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags =3D PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length =3D len + MCTP_SIGNATURE_LENGTH;
> +
> +	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
> +		// Remove the header in case it gets sent again
> +		skb_pull(skb, sizeof(*pcc_header));
> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	return NETDEV_TX_OK;
> +error:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}

Cheers,


Jeremy

