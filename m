Return-Path: <netdev+bounces-77219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CACEA870BC7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3100EB23599
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD168DF5B;
	Mon,  4 Mar 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dY+uaHpL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EA46FB5
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585213; cv=none; b=kiCknxqLhjsz3zZ8a1WnZD/3zWQdrDmTY+E/UHUtnPbc6FKwR4DjtAqy69DWBWpxD1avbiRie6E2eWG7dRlluDJm3u/c9CrCrMHZrL7x4/78SZLNUNrty6nhGXmSL6nnv/SVYCmWWeisGYqF4w6GGwiw0sQlloy1p5h1UBNVvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585213; c=relaxed/simple;
	bh=FxLR6v3h5alVpLzCs+/JArqifz4nAastB6qbFjTJ7Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edGUYl5q30eDVmO2+7FiEKWtsWUs5Turhor+guafgsGq52+0leRKO08SzRM4ZsvWAqBSIrRFwAiKbERFORu4oAnX61gq8o/GZZBX4EiGIGOJOo7mWaK2IUt5wlRoQXa/uirETkvEKcna5ndeoU7bCSY4aDLnE+Smj8epZxhnq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dY+uaHpL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z+olHfkbhoSMJfDBHY9OBmMRX0X1Zn7hFmkv/xpIln8=; b=dY+uaHpLU3jOfj9KPJNFRbD/Rs
	jwhDYZkentpXOT1LjroelhZyj9p7f1o6t0lOL8eQrUp9+mfXvZm0Qt/1ykjdA8FzZ9pBAomLpKpSv
	Tc9Tm2lOjz0xi/Dy7xcuGc7stpeuxo3nhiJ0JGV4qDD3iVnOPNgcFDnMFCHyvVfq57jc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhFDI-009M14-84; Mon, 04 Mar 2024 21:47:08 +0100
Date: Mon, 4 Mar 2024 21:47:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-3-antonio@openvpn.net>

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> new file mode 100644
> index 000000000000..a1e19402e36d
> --- /dev/null
> +++ b/drivers/net/ovpn/io.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include "io.h"
> +
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>

It is normal to put local headers last.

> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> new file mode 100644
> index 000000000000..0a076d14f721
> --- /dev/null
> +++ b/drivers/net/ovpn/io.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPN_H_
> +#define _NET_OVPN_OVPN_H_
> +
> +#include <linux/netdevice.h>
> +
> +struct sk_buff;
> +

Once you have the headers in the normal order, you probably won't need
this.

> +netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
> +
> +#endif /* _NET_OVPN_OVPN_H_ */
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> new file mode 100644
> index 000000000000..25964eb89aac
> --- /dev/null
> +++ b/drivers/net/ovpn/main.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#include "main.h"
> +#include "io.h"
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/net.h>
> +#include <linux/inetdevice.h>
> +#include <linux/netdevice.h>
> +#include <linux/version.h>
> +
> +
> +/* Driver info */

Double blank lines are generally not liked. I'm surprised checkpatch
did not warn?

> +#define DRV_NAME	"ovpn"
> +#define DRV_VERSION	OVPN_VERSION
> +#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> +#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
> +
> +/* Net device open */
> +static int ovpn_net_open(struct net_device *dev)
> +{
> +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
> +
> +	if (dev_v4) {
> +		/* disable redirects as Linux gets confused by ovpn handling same-LAN routing */

Although Linux in general allows longer lines, netdev has kept with
80. Please wrap.

> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;

Wireguard has the same. How is Linux getting confused? Maybe we should
consider fixing this properly?

> +#ifndef OVPN_VERSION
> +#define OVPN_VERSION "3.0.0"
> +#endif

What could sensible define it to some other value?

These version numbers are generally useless. A driver is not
standalone. It fits within a kernel. If you get a bug report, what you
actually want to know is the kernel version, ideally the git hash.

    Andrew

