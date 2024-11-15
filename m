Return-Path: <netdev+bounces-145188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEA9CD9E8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF12AB282F3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D11885A1;
	Fri, 15 Nov 2024 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NxvIAIp3"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E2183CC7;
	Fri, 15 Nov 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655679; cv=none; b=CQ2001ifWVImnKAnfrHT/ECCLyofUZ/VUebOBnqIPwgRfJrDbHbO2TafBgd6M/j0uGZsinL53LQefSccQh46odJQ1j1w8UUDh46/v7XwlZFbtLCUsEYxI46v8U9WY56k/ItiMNVnoUq1WwoyjDT7oqLKIgHD4qs6NmusjddbzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655679; c=relaxed/simple;
	bh=WwHB1f3gavVE9l2aZQ4WLcUSVZv8GqGUZZYPi6oRew8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPIt1N/vXmjb7vCi+j+SWDHuejOlJj3LOHKf4LB3dlz2nQlhMmWmwhZahU1BEEVfWdh106L2oQGtUsa3twqUj7/3JOc76F3cATXP1wF5dZOibkRnWKsc2cu3hS8QD8iZp/XMfG1HJcVwwCerek73XxUfMjCyRQjL4mGD10KvVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NxvIAIp3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731655668;
	bh=WwHB1f3gavVE9l2aZQ4WLcUSVZv8GqGUZZYPi6oRew8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NxvIAIp3CfTFgSECIk88TXnKOBfoHK4lkVwMqk+cBMbKKLmwvt3eZFGDCG3fwj1Gq
	 M8ZkOHvQAJ8EjBx2GjihvRpMKTgvq/Qak9peinF1HTtksafRotVt3/puDaKZF3SJ27
	 JRxuozlduDJjaF/N9hm5hW1pu4EPEBeezNKqliVJcEri2GoIE+yLwYAE7wNTp+MFvj
	 y1dOX+XT9JO0hzZgTBix4uWtMq1NZ4A/xl1iilxNf2n30zQHF4uGad96782lhpqWqm
	 0Xiv//jWDyGDmyF2COAUmG34MEbVue80QKQzoBgi1r9cEJXLH3HV7NHoAKGOnu2PPc
	 0Vir4+0zm3XTA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B8F3766537;
	Fri, 15 Nov 2024 15:27:46 +0800 (AWST)
Message-ID: <01be9950ef5591bd70685019cc56b7ffe0e3bce7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 2/2] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Fri, 15 Nov 2024 15:27:46 +0800
In-Reply-To: <20241114024928.60004-3-admiyo@os.amperecomputing.com>
References: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
	 <20241114024928.60004-3-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

All good with the hw addressing changes, but there are still things from
my previous review that have either been ignored or discarded. In case
of the latter, that still may be fine, but at least a note that you have
done so would be helpful.

Those inline again, and one new one ("Implementation [...]").

> +config MCTP_TRANSPORT_PCC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "MCTP PCC transport"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select ACPI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Provides a driver to ac=
cess MCTP devices over PCC transport,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A MCTP protocol network=
 device is created via ACPI for each
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry in the DST/SDST t=
hat matches the identifier. The Platform
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commuinucation channels=
 are selected from the corresponding

typo: communication

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entries in the PCCT.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say y here if you need =
to connect to MCTP endpoints over PCC. To
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compile as a module, us=
e m; the module will be called mctp-pcc.
> +
> =C2=A0endmenu
> =C2=A0
> =C2=A0endif
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index e1cb99ced54a..492a9e47638f 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) +=3D mctp-pcc.o
> =C2=A0obj-$(CONFIG_MCTP_SERIAL) +=3D mctp-serial.o
> =C2=A0obj-$(CONFIG_MCTP_TRANSPORT_I2C) +=3D mctp-i2c.o
> =C2=A0obj-$(CONFIG_MCTP_TRANSPORT_I3C) +=3D mctp-i3c.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..489f42849a24
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024, Ampere Computing LLC
> + */
> +
> +/* Implelmentation of MCTP over PCC DMTF Specification 256

"Implementation"

(also, might be better to use the full spec ID ("DSP0256"), as it's
easier to search)

> +struct mctp_pcc_hdr {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 signature;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 flags;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 length;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char mctp_signature[MCTP_SIGNA=
TURE_LENGTH];
> +};
>

These signature/flags/length still don't have the endian annotations
(nor conversions on access). This was raised on v2, but looks like that
got lost?

> +static void
> +mctp_pcc_net_stats(struct net_device *net_dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rtnl_link_stats64 *stats)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->rx_errors =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->rx_packets =3D net_dev-=
>stats.rx_packets;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->tx_packets =3D net_dev-=
>stats.tx_packets;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->rx_dropped =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->tx_bytes =3D net_dev->s=
tats.tx_bytes;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->rx_bytes =3D net_dev->s=
tats.rx_bytes;
> +}

Is this missing the rx_dropped stat (which you're updating in
_rx_callback)?

If you like, there are some new tstats helpers available, meaning you
wouldn't need the ndo_get_stats64 op at all. Let me know if you're
interested in using those, and would like a hand doing so.

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_lookup_context=
 context =3D {0, 0, 0};
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_ndev *mctp_pcc=
_ndev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D &acpi_d=
ev->dev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *ndev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_handle dev_handle;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_status status;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int mctp_pcc_mtu;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[32];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(dev, "Adding mctp_pcc =
device for HID=C2=A0 %s\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0acpi_device_hid(acpi_dev));

Super minor: double space before the %s here.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_handle =3D acpi_device_han=
dle(acpi_dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D acpi_walk_resources=
(dev_handle, "_CRS", lookup_pcct_indices,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &context);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ACPI_SUCCESS(status)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(dev, "FAILURE to lookup PCC indexes from CRS");

+ trailing newline (on the error message).

Other than that, all good!

Cheers,


Jeremy

