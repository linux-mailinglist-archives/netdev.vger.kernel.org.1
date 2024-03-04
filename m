Return-Path: <netdev+bounces-77267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4F871045
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A51C20FA2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71786E542;
	Mon,  4 Mar 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zxt5henz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E503C28
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592356; cv=none; b=qguZpn9/6TICBgx0P7PGzVMw3mugbR7hk3B9/p7Qd8YC3rOscuBcJ00VUoW153D+vnnK3AbpYEWxPKJAnJqfbF4xVwOFqqK8r9QmtqmYDWOXDoqjySibQ0w026MTxwIAG5YguFhzwPbpXB21Q41J8Hiqm+ND+2laNsZc40UvAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592356; c=relaxed/simple;
	bh=ZAtWMgTUN5l42htogHBiqR68aIIxcdayEBUDhVJfHQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzB3rVERgEl2+piQ8HP9xemAiwugAfoB7cIrFKSO+U0779isFkNCNFo4BSRTEVA60oAv1AQgImgajuD5YlFgupHXOSakkdjeOwUcJ2XvjNRNLGBS0EVDkpO7j/i6nkMWaCclOONjFhO/+Yayfld9jpKh1O2cqH3NElGj2rGaZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zxt5henz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VHW85iB46K9gV/X9KgxJa+Wf1zCUwUA2OGw9PrYEs5Y=; b=zxt5henz7yhROAeekTokjCmL5d
	NrxaiJWxQCaWtACM+yD599tfTzm5ml1g7SgSf0g0BJyyaAe94f2XtMxCFuUmigLn2G0XnTgKjxKxO
	zOACTHbSHcDTP9omW371H2fBY+zz7mXJB7H6sadNIsftnWIQxrDchCWOP9G2u+G3vUe0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhH4b-009MNT-L3; Mon, 04 Mar 2024 23:46:17 +0100
Date: Mon, 4 Mar 2024 23:46:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <07050ffc-aa8e-417a-b35b-0cf627fc226f@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-3-antonio@openvpn.net>
 <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
 <517236bb-fd03-43cb-a264-c7d191058eef@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517236bb-fd03-43cb-a264-c7d191058eef@openvpn.net>

On Mon, Mar 04, 2024 at 10:30:53PM +0100, Antonio Quartulli wrote:
> Hi Andrew,
> 
> On 04/03/2024 21:47, Andrew Lunn wrote:
> > > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > > new file mode 100644
> > > index 000000000000..a1e19402e36d
> > > --- /dev/null
> > > +++ b/drivers/net/ovpn/io.c
> > > @@ -0,0 +1,23 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*  OpenVPN data channel offload
> > > + *
> > > + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> > > + *
> > > + *  Author:	James Yonan <james@openvpn.net>
> > > + *		Antonio Quartulli <antonio@openvpn.net>
> > > + */
> > > +
> > > +#include "io.h"
> > > +
> > > +#include <linux/netdevice.h>
> > > +#include <linux/skbuff.h>
> > 
> > It is normal to put local headers last.
> 
> Ok, will make this change on all files.
> 
> > 
> > > diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> > > new file mode 100644
> > > index 000000000000..0a076d14f721
> > > --- /dev/null
> > > +++ b/drivers/net/ovpn/io.h
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* OpenVPN data channel offload
> > > + *
> > > + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> > > + *
> > > + *  Author:	James Yonan <james@openvpn.net>
> > > + *		Antonio Quartulli <antonio@openvpn.net>
> > > + */
> > > +
> > > +#ifndef _NET_OVPN_OVPN_H_
> > > +#define _NET_OVPN_OVPN_H_
> > > +
> > > +#include <linux/netdevice.h>
> > > +
> > > +struct sk_buff;
> > > +
> > 
> > Once you have the headers in the normal order, you probably won't need
> > this.
> 
> True, but I personally I always try to include headers in any file where
> they are needed, to avoid implicitly forcing some kind of include ordering
> or dependency. Isn't it recommended?

It is a bit of a balancing act. There is a massive patch series
crossing the entire kernel which significantly reduces the kernel
build time by optimising includes. It only includes what is needed,
and it breaks up some of the big header files. The compiler spends a
significant time processing include files. So don't include what you
don't need, and try at avoid including the same header multiple times.

> > > +/* Driver info */
> > 
> > Double blank lines are generally not liked. I'm surprised checkpatch
> > did not warn?
> 
> No, it did not complain. I added an extra white line between headers and
> code, but I can remove it and avoid double blank lines at all.
> 
> > 
> > > +#define DRV_NAME	"ovpn"
> > > +#define DRV_VERSION	OVPN_VERSION
> > > +#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> > > +#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
> > > +
> > > +/* Net device open */
> > > +static int ovpn_net_open(struct net_device *dev)
> > > +{
> > > +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
> > > +
> > > +	if (dev_v4) {
> > > +		/* disable redirects as Linux gets confused by ovpn handling same-LAN routing */
> > 
> > Although Linux in general allows longer lines, netdev has kept with
> > 80. Please wrap.
> 
> Oh ok. I thought the line length was relaxed kernel-wide.
> Will wrap all lines as needed then.

https://patchwork.kernel.org/project/netdevbpf/patch/20240304150914.11444-3-antonio@openvpn.net/

Notice the netdev/checkpatch test:

CHECK: Please don't use multiple blank lines WARNING: line length of
82 exceeds 80 columns WARNING: line length of 91 exceeds 80 columns
WARNING: line length of 96 exceeds 80 columns

There are some other test failures you should look at.

> > 
> > > +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> > > +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
> > 
> > Wireguard has the same. How is Linux getting confused? Maybe we should
> > consider fixing this properly?
> > 
> > > +#ifndef OVPN_VERSION
> > > +#define OVPN_VERSION "3.0.0"
> > > +#endif
> > 
> > What could sensible define it to some other value?
> > 
> > These version numbers are generally useless. A driver is not
> > standalone. It fits within a kernel. If you get a bug report, what you
> > actually want to know is the kernel version, ideally the git hash.
> 
> True, unless the kernel module was compiled as out-of-tree or manually
> (back-)ported to a different kernel. In that case I'd need the exact version
> to know what the reporter was running. Right?

With my mainline hat on: You don't compile an in tree module out of
tree.

> Although, while porting to another kernel ovpn could always reference its
> original kernel as its own version.
> 
> I.e.: ovpn-6.9.0 built for linux-4.4.1
> 
> Does it make sense?
> How do other drivers deal with this?

$ ethtool -i enp2s0
[sudo] password for andrew: 
driver: r8169
version: 6.6.9-amd64

It reports uname -r. This is what my Debian kernel calls itself. And a
hand built kernel should have a git hash. A Redhat kernel probably has
something which identifies it as Redhat. So if somebody backports it
to a distribution Frankenkernel, you should be able to identify what
the kernel is.

We tell driver writes to implement ethtool .get_drvinfo, and leave
ethtool_drvinfo.version empty. The ethtool core will then fill it with
uname -r. That should identify the kernel the driver is running in.

There is no reason a virtual device should not implement ethtool.

BATMAN is a bit schizophrenic, both in tree and out of tree. I can
understand that for something like BATMAN which is quite niche. But my
guess would be, OpenVPN is big enough that vendors will do the
backport, to their Frankenkernel, you don't need to keep an out of
tree version as well as the in tree version.

      Andrew

