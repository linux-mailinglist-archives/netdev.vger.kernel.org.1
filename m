Return-Path: <netdev+bounces-152695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB59F56A9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229D116FF59
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEC1F868F;
	Tue, 17 Dec 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Qi1/LXSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC161F76A0
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462250; cv=none; b=GdKdqhaRx7psk88FvNLluWwkK93M2RfrNOi7qW08sCAjIDYR+vP6xvY0agHDMYDzcnsQy9l36UzEIbEPzZCZbaDlZLGFKE3PxH3Ol8CKUIR5q9zDUQ4svJz39obem0a/K30ZZZnEo9fT9UVJJLRTE3n6dTiiiey//s1s/temY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462250; c=relaxed/simple;
	bh=jPr1fiLzQKQshsYCM0HhYICbbGSGu9nt2W3zqbl1eic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOiivyQhnbkqbl+9QVbsA4LJSbHmRbsnAovjLWreDjxxJSZqZoKa//gqxouG58R30Xe6ImYH2I5FdwfUtJ6grXqWdfhG5zPbNcEXrVRTovfMGtC/XwrtyyUC3Ywcc5xKJUOMkXTBB/HxTC8oZO/SEdZ+ThwPIjqFAioB/hV13Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Qi1/LXSx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72909c459c4so3899271b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734462248; x=1735067048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKJBJiI/cCQJDsqcNpZzhWufhzaH41z5oYV6DpzM/Eo=;
        b=Qi1/LXSxWPo79F5K6WUx2Ss7OFHrPz/PPHnucDSKChfuL/04x2EMlDpK2ty3Q5hfOi
         LRwg/o3BKHsmPU70aHViEotPWYiNy9Dx15+jlZNPrTpW/0YJsY9IG8qQZ81E95fPgmfB
         2iMTk70oBue4mk3pLkuU6ZO5d6+VM2lLULwI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462248; x=1735067048;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKJBJiI/cCQJDsqcNpZzhWufhzaH41z5oYV6DpzM/Eo=;
        b=goHoE51biWwwAFlKTNo9cFzfubmFNJ6eyym6EoQ3sCYfxcWAcqN4YPC9Re0ayJ7ayl
         q4aoz7oZBzaId8uoHCBuLOg0Z7BvIFTkPzAG5kwQ4QEjJqTFUefbzrVhfkuVR2iYcFLQ
         znJgdLokXF1EeHZOGHnfFaGto03tbvrwkfm/3ehrBp1sP6NKgyoZzLXgLNjBVIiXkl2u
         Aq3Z98NAQsZBSXb9sdNqa5Nwp3Zo6Kt8GXYSVk3Oy6OR5RrM34zFzhe/3fB90GquHLwD
         f3t/A+dnJ4Yn9FNQ2anaUyStJczqvquAcKpboIMVRDBW+PauABsVTYd9ATlv23X2bVyP
         QDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX9BWMJg/Lr1kJsc7lXHj8qeyn+i3vBeyfrQF82WU6qMTecoy8wc3qGNehTVF+uAnsZVPRDy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzL7wewVLykVSP6RjNTqF5KKx38QkBgTRX1H2Zg713MpSoqVmZ
	VZ+F/32O0/TNLkhZcskqfutN2KQ9AoVP6gK/My+CisWW3KzUXHBLfQZWnvWzTto=
X-Gm-Gg: ASbGncub6JgAOfOF/UddlHVuSm17M7xtaKLCEZTmXHsGnDN5w3PUAvTt0vtWlKNBJzm
	DHrsCxi/1DKuGobb14k4vUMb/ExFWJjoIg2GVpODgD2cNmBXZZ2g27noiANquv+EAY0WF1eUK41
	j3okJ8kMlJkSzx4vBWPO4EzC4Y2ElqaDeYuh8FzXvEVJZrem3jc+L4Po48rnN+Z0yV6xE+5JZg5
	2wEA/jhVdMjMy2GwhzbXK1+LelK/7Qp9MemAY/DyLA7Bd7c5LRGlNUMS+vv0CYvqdOrTOU0Yyiw
	k8DIf/LM2pzk5xQS6LEQCmo=
X-Google-Smtp-Source: AGHT+IE+GB/uOPJugYId7Ak0rCgLL5JK0sjF/ExW6l2pU/DIdUf+9Oge4ycpx+fvSa4yS9mkavnIgA==
X-Received: by 2002:a05:6a21:78a7:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e5b48228b3mr227465637.21.1734462248303;
        Tue, 17 Dec 2024 11:04:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b790a6sm7240393b3a.128.2024.12.17.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:04:07 -0800 (PST)
Date: Tue, 17 Dec 2024 11:04:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	admiyo@os.amperecomputing.com,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
 <20241217182528.108062-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217182528.108062-2-admiyo@os.amperecomputing.com>

On Tue, Dec 17, 2024 at 01:25:28PM -0500, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/net/mctp/Kconfig    |  13 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-pcc.c | 320 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/net/mctp/mctp-pcc.c

[...]
 
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,320 @@

[...]

> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;
> +	struct pcpu_dstats *dstats;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
> +		      sizeof(struct mctp_pcc_hdr));
> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
> +
> +	dstats = this_cpu_ptr(mctp_pcc_ndev->mdev.dev->dstats);
> +	u64_stats_update_begin(&dstats->syncp);
> +	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
> +		u64_stats_inc(&dstats->rx_drops);
> +		u64_stats_inc(&dstats->rx_drops);

Double counting rx_drops ?

> +		u64_stats_update_end(&dstats->syncp);
> +		return;
> +	}
> +	if (!skb) {
> +		u64_stats_inc(&dstats->rx_drops);
> +		u64_stats_update_end(&dstats->syncp);
> +		return;
> +	}
> +	u64_stats_inc(&dstats->rx_packets);
> +	u64_stats_add(&dstats->rx_bytes, data_len);
> +	u64_stats_update_end(&dstats->syncp);

I suspect what Jeremy meant (but please feel free to correct me if
I'm mistaken, Jeremy) was that you may want to use the helpers in:

include/linux/netdevice.h

e.g. 

  dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
  dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);

etc.

[...]

> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;
> +	struct pcpu_dstats *dstats;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +
> +	dstats = this_cpu_ptr(ndev->dstats);
> +	u64_stats_update_begin(&dstats->syncp);
> +	u64_stats_inc(&dstats->tx_packets);
> +	u64_stats_add(&dstats->tx_bytes, skb->len);
> +	u64_stats_update_end(&dstats->syncp);

Likewise, as above with the helpers from include/linux/netdevice.h:

  dev_dstats_tx_add( ... );
  dev_dstats_tx_dropped( ... );

But, I'll let Jeremy weigh-in to make sure I've not misspoken.

[...]

> +
> +static void  mctp_pcc_setup(struct net_device *ndev)
              ^^  nit: double space ?

[...]

> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct  mctp_pcc_lookup_context *luc = context;
              ^^ nit: double space?

[...]

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{

[...]

> +
> +	rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
            ^^ nit: double space

