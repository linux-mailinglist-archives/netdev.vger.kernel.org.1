Return-Path: <netdev+bounces-96151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C428C481A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE935B2126A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BD7E110;
	Mon, 13 May 2024 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Aqo9/W9Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09D7E0FB;
	Mon, 13 May 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631481; cv=none; b=EmRaBT0TOUCTCtQa7U8wgmUFsVldHIY1xKbMdM7/GDFWWR2AnIWeaR/5lNXo26m9AeWl6zNvZ3iUxecsnfCyzbWvFZ5aSRckMDKXpKGUGKNJr58v0FqmrTPZ9lLyQ0RzpA0BQhgH8Rz/teLcscf1APyQ4z01Sx33mU/ow2EoEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631481; c=relaxed/simple;
	bh=QPPucxNzMGci2VCLPJG4C88e7OqjvcCNvLSfh/GvPJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY/FmrL0iz1KguJ6crl93GI8+16a/ArjAWQ+mSGJUdyicmuEKD5lFjTU7NopQi/DjuwCelV50FM8pe/qg5EjwqxbfqFHe7sya2ea7rkED2VJYP+Yw1psHp+jJMWHdIXDorMmYgEJdO1EdSw51BVr02FN19DXZhqgh8RNeW3Wc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Aqo9/W9Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nqxnckkmky72wratqJjxCB8HyiXkypohHfXZ7n/n1OE=; b=Aqo9/W9YcKQK58JqM5gceiv3OA
	O7McD0Us4UBR9Wt3OtqfTkFTx5WhU26b2UENWil4GbLhCsw+Ducd7MSH9pyByfoZnRIGuFYzsVLEN
	+oZ4F+aurC5YQekgLuoq3RDs9uKvuVK2g/97r7fJ5jEPllYvZVqDHSpqO8HKk/bgOU78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6c7I-00FKip-6L; Mon, 13 May 2024 22:17:48 +0200
Date: Mon, 13 May 2024 22:17:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <48ef7972-4b8f-4027-a2ca-357e53dcdd0f@lunn.ch>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240513173546.679061-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-2-admiyo@os.amperecomputing.com>

> +static struct mctp_pcc_packet *mctp_pcc_extract_data(struct sk_buff *old_skb,
> +						     void *buffer, int outbox_index)
> +{
> +	struct mctp_pcc_packet *mpp;
> +
> +	mpp = buffer;
> +	writel(PCC_MAGIC | outbox_index, &mpp->pcc_header.signature);
> +	writel(0x1, &mpp->pcc_header.flags);
> +	memcpy_toio(mpp->pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
> +	writel(old_skb->len + SIGNATURE_LENGTH,  &mpp->pcc_header.length);
> +	memcpy_toio(mpp->header_data,    old_skb->data, old_skb->len);
> +	return mpp;
> +}

...

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	unsigned char *buffer;
> +	struct mctp_pcc_ndev *mpnd;
> +	struct mctp_pcc_packet  *mpp;
> +	unsigned long flags;
> +	int rc;
> +
> +	netif_stop_queue(ndev);
> +	ndev->stats.tx_bytes += skb->len;
> +	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer =  mpnd->pcc_comm_outbox_addr;
> +	mpp = mctp_pcc_extract_data(skb, mpnd->pcc_comm_outbox_addr, mpnd->hw_addr.outbox_index);

I don't see any length checks here. How do you know the skb contains
sizeof(struct mctp_pcc_packet)?

> +static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
> +				  struct device *dev, int inbox_index,
> +				  int outbox_index)
> +{
> +	int rc;
> +	int mctp_pcc_mtu;
> +	char name[32];
> +	struct net_device *ndev;
> +	struct mctp_pcc_ndev *mctp_pcc_dev;
> +	struct mctp_pcc_hw_addr physical_link_addr;

Since this is networking code, you should be using reverse christmas
tree for all your functions.

> +	snprintf(name, sizeof(name), "mctpipcc%x", inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM, mctp_pcc_setup);

%x is very unusual for network device names.

	Andrew

