Return-Path: <netdev+bounces-305945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxEQN+6WTmo2QAIAu9opvQ
	(envelope-from <netdev+bounces-305945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE972981A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dXTzUtiy;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305945-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305945-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8EF1303F674
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4D3B42EC;
	Wed,  8 Jul 2026 18:26:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECA21CC58;
	Wed,  8 Jul 2026 18:25:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535162; cv=none; b=fVokFSK8GHeoFUWVMQSpRbSasTAPHwFn30z7fBHAcwkXCvaxxKMJP945J8Y9qmRosbl5odXD6ozdoojcfQkZcGtEdkpTPnciHf9Os6QWUy+HtDJrKDc9y7rqIgwh3w/ETr9H2rtSHakUMl98CagVx5lDMMrxTDc1W6ukELdfJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535162; c=relaxed/simple;
	bh=7ygv9zNUSd2ulxVRE0lEpnSk+Rc+r1kyJIfvOrIRmAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pm66zX9JDwdgwAYtZVMy0XfRGNwy8oFEWcnOm+SNFH9783PKSZiGPo+2YP+pPI0HTZ1Lpe7U6k4sUnOKQMlUBR6JC0IKb3yGI+9tzqpjIAhXepxrztgOxN8eO7WFWf5/Ru+/VDQWAELXxVCbpMQp6PM+aTDgXP6/f6TNmRW8ajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dXTzUtiy; arc=none smtp.client-ip=80.241.56.151
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gwRNz0jctz8v4r;
	Wed, 08 Jul 2026 20:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783535155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4iuFEB0S+wIFIF/+96tCQE1MxQdc4F6EeshLLWPU+0=;
	b=dXTzUtiyaHAbBOInci3ON7YWIZmzU0azhpPDSn9jy3h2WWaRDv1IXtic0AgX7IPulaR/Of
	B7OXD6hxDr8qX6WvlyE8ruVYehHlwnz39z3ZYVdO5yFIrzVyXabzCnGc4l1isahR4qqOUV
	OcLabbB+kYlM20upQm1Ia0QRBNEQYJjqkm5n5sntXEKybUQOeg7W5kpgJm1ju7BvLNyUaf
	y1QX3F+YAXfRQbLPC3nB9p2lrIHkngziZ+DApyyj5iRKv6/PllKx5oUMDky67QC0Cs+8Cb
	sRz2HRuIXUCq1uMeqYB5iNM14HEA5gwhy/GDa0AZBQF0MvjlT1ZD1hUznGKX7A==
Message-ID: <c6a291e752b889689c0776e59024e752e4306868.camel@mailbox.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: Manuel Ebner <manuelebner@mailbox.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman	
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 08 Jul 2026 20:25:49 +0200
In-Reply-To: <ak0KOrM5E2_sPIHf@makrotopia.org>
References: <ak0KOrM5E2_sPIHf@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 791c0825b960b52aa7c
X-MBO-RS-META: 8yycxhk77caia6ri7r6i4yem5mdpo94g
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:dkim,mailbox.org:mid,makrotopia.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40FE972981A

Hi Daniel,

On Tue, 2026-07-07 at 16:16 +0200, Daniel Golle wrote:
> Implement runtime firmware upgrade via "devlink dev flash" and version
> reporting via "devlink dev info":
>=20
> =C2=A0 devlink dev info mdio_bus/<bus>/<addr>
> =C2=A0 devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bin>
>=20
> The driver sends SYS_MISC_FW_UPDATE to enter MCUboot rescue mode,
> transfers the signed image over the SB PDI bulk-transfer protocol
> (clause-22 SMDIO), waits for the switch to reboot, then schedules
> device_reprobe() for a clean remove()+probe() cycle.

This could be split up into two sentences.


> Before the transfer begins the driver closes all conduit interfaces
> and marks every netdev (user and conduit) not-present via
> netif_device_detach() so that userspace cannot bring ports back up
> during the ~15 minute flash process. Progress is reported through
> devlink status notifications. Once the FW_UPDATE command has been
> sent the switch is in MCUboot mode and normal operation can only be
> restored by a reprobe, so the driver always schedules one regardless
> of transfer outcome.
>=20
> The reprobe work item is dynamically allocated (following the iwlwifi
> pattern)

I'm not familiar with the net subsystem, if the iwlwifi pattern is not
trivial consider adding a link or a explanation.

>  because device_reprobe() triggers remove() which frees the
> devm-managed priv while the work is still executing.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> =C2=A0drivers/net/dsa/mxl862xx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx-cmd.h=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx-fw.c=C2=A0=C2=A0 | 434 ++++++++++=
+++++++++++++
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx-fw.h=C2=A0=C2=A0 |=C2=A0 15 +
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx-host.c |=C2=A0=C2=A0 7 +
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> =C2=A0drivers/net/dsa/mxl862xx/mxl862xx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +
> =C2=A07 files changed, 463 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> =C2=A0create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h
>=20
> diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx=
/Makefile
> index a7be0e6669df..bccac0d0f703 100644
> --- a/drivers/net/dsa/mxl862xx/Makefile
> +++ b/drivers/net/dsa/mxl862xx/Makefile
> @@ -1,3 +1,3 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0obj-$(CONFIG_NET_DSA_MXL862) +=3D mxl862xx_dsa.o
> -mxl862xx_dsa-y :=3D mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
> +mxl862xx_dsa-y :=3D mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o mxl862=
xx-fw.o
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> index c87a955c13c4..e2aa2934e9e1 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> @@ -70,6 +70,7 @@
> =C2=A0#define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x1)
> =C2=A0#define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x2)
> =C2=A0
> +#define SYS_MISC_FW_UPDATE		(SYS_MISC_MAGIC + 0x1)
> =C2=A0#define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
> =C2=A0
> =C2=A0#define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl=
862xx/mxl862xx-
> fw.c
> new file mode 100644
> index 000000000000..7cd4a462667b
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Firmware flash and devlink support for MaxLinear MxL862xx

If you have a data sheet for the device please add a link.

> + *
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + *
> + * Usage:
> + *=C2=A0=C2=A0 # Query running firmware version:
> + *=C2=A0=C2=A0 devlink dev info mdio_bus/<bus>/<addr>
> + *
> + *=C2=A0=C2=A0 # Flash new firmware (all ports are taken down automatica=
lly):
> + *=C2=A0=C2=A0 devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bi=
n>
> + *
> + * The flash process takes approximately 15 minutes.=C2=A0

Does the user get informed about the wait?


> Progress is
> + * reported via devlink status notifications. After a successful (or
> + * failed) flash the driver reprobes the device automatically.
> + */
>=20
> [...]
> +
> +/* Timeouts */
> +#define MXL862XX_FW_READY_TIMEOUT_MS	30000
> +#define MXL862XX_FW_ACK_TIMEOUT_MS	5000
> +#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000	/* flash erase is very slow =
*/

Slow is relative.
Can you give an erase speed in MB/s or time for the whole memory?

> [...]
> +
> +	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
> +		 priv->fw_version.major, priv->fw_version.minor,
> +		 priv->fw_version.revision);
> +
> +	/* Close all user and CPU ports while the firmware is still
> +	 * alive. dev_close() on user ports triggers multicast group
> +	 * leave and host MDB/FDB removal on the CPU port through the
> +	 * normal DSA callbacks so the core's tracking lists are
> +	 * drained before we enter MCUboot. Then mark user ports
> +	 * not-present so userspace cannot bring them back up during
> +	 * the (slow) flash process. The conduit is only closed, not

(slow) -> up to 20 minutes long flash process.
    or -> circa 15 minutes long flash process.

> +	 * detached -- it is owned by the Ethernet MAC driver and
> +	 * dev_open() during reprobe must be able to bring it back.
> +	 */
> +[...]
> +	/* Silently discard all API commands during the teardown that
> +	 * reprobe triggers -- the switch firmware has been reset and
> +	 * has no knowledge of the old configuration.
> +	 */
> +	priv->skip_teardown =3D true;
> +
> +	reprobe =3D kzalloc(sizeof(*reprobe), GFP_KERNEL);

-> kzalloc_obj(*reprobe); - GFP_KERNEL is the default, therefore omitted.
as suggested in 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")

Did you skip checkpatch or is it out of date?

Anyway thanks
 Manuel

> [...]

