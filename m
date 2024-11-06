Return-Path: <netdev+bounces-142144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484AA9BDA55
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7978B23719
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50A1E522;
	Wed,  6 Nov 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6jp/OEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FEC10E3;
	Wed,  6 Nov 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853071; cv=none; b=ePz8ZRbIc0dcuR0txbQop3hwhNBDVmyNOQsk0YmkqQDAnE2N0n5WYqMnnrlsz37kbBDsTjQOpj32GHwQZ5cRu2+fcuDnsRzXFAKnX5/YoPwBG9miZ2nLgvgnri3Z4889ZTDXHj1fgFTGjOESdP/86dE8GY3p40X1Dm/zXH9IHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853071; c=relaxed/simple;
	bh=jOx6xPm2NQ2Dy+LcxTA/n5pvFHgVVddEWkJjFZh6pN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBXhGREUSA4qJmEk7NfhcltOV90oSU2rrSbDZBrsJoXE/NZDjotxILr9zT7jlKo8qAhuhdrqyB1Mnay685qSff0b3sYf0Fv5Syuaxb5Jqk+rftIMrsy7zEk7Bh0JFezl1WxUXjNl3Uy+IJhAh7AFfpUBnRoBOE9J4jw+9chHmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6jp/OEe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d8901cb98so181923f8f.0;
        Tue, 05 Nov 2024 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730853067; x=1731457867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYjmXwFHtnAB1duZTNcAEkMOaIotdcD7DShsEbstppg=;
        b=V6jp/OEevZwhXOmbJrB4r6PLXy83yGBLnZu/ngh3QBZL4yhRs7ctUfiiRwKd+vWKt/
         bbcBzwgxIUoH+ST94OijdZI7tmXvISWEmc5d8Q6OPwKdjyh4hXkQWGc6Pju7Ey+RqFco
         d84dsXpjXGpa5pJ1mZCJauTbKsfWMIyu0ydrKvTzd2Z1pEJyZO82Wef8DF9NL5LFv+rQ
         nj7+PZ1J1n8Zj9WFyEVEg/wYUgetCk47glKwSWpznYfvlGQGRJNWH+CJa4FwcjcdgfQ0
         dpKowV+8YErGFiTdwJBpru/t5bwHicqnU4j0pxu8XPNlawdw2LUtb8jRDwyR6Wxaes99
         47KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853067; x=1731457867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYjmXwFHtnAB1duZTNcAEkMOaIotdcD7DShsEbstppg=;
        b=OnAQ4yFRl6HfvPd3yushfLn17azIEfhvYdy1lu7se80M4k9N7g1e+PSmXn+lTFRH58
         4qw4Aw/RE3vfkfUVnXLg/Lo6aUX0V6ErsTNP7/R8zwqlc6pcmpA3DCyeEZh+yVJk13FS
         aXTUPYCB2PP1rL625klHmU1dprrFOXzyxQRfBEPa0US7i0IZ99MEUgXxcEFwWtL25Umg
         MM7meE9147GzAHpZzH/sIJLZYZyZSS4gQWbbaaYFW73HM0gOl7YkoWc2olbdupOW775U
         5O1/2gv+y26iQWF7Gv2DBshWOkLLprNOSBxSIfRH8IGM03Lu7tRYcQ8UiDZh8VirgihA
         n3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV59Ml5hjcXgz40/0XxzQbfBOUPv7MJVof/57idO9ZFiuOj0/dBySQ8YaxfAuw0ffmpLnUKrHTU/hCq8xo=@vger.kernel.org, AJvYcCXEfyjl68fvo2C/YBjGKeVr/S4o4Ou4aFSzxA7p1ndkMRTwJs6WAt4kKXPYncTW9M09Og7WKFNI@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTxrAmD2p/MHdOe2py1avu4NPqJBKooAUsKjJQCsx2bDiQqlH
	SNV35CwlauFJ8CIMXL29ipiammfEzSqWjaXGTTDxP8jCPB2FGSpm
X-Google-Smtp-Source: AGHT+IGZQlFVbZBFKAEy9zeOs9BkJdMECfm0uEy1awqXNEQsg3db0A3jYWtG4UkMKMfizWmRpQkZ2w==
X-Received: by 2002:a5d:5f45:0:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-381e81c4953mr466700f8f.2.1730853067086;
        Tue, 05 Nov 2024 16:31:07 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa737c86sm2881955e9.38.2024.11.05.16.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 16:31:06 -0800 (PST)
Message-ID: <f35c2ec2-ef00-442d-94cd-fa695268c4f2@gmail.com>
Date: Wed, 6 Nov 2024 02:31:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 02/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-2-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-2-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> OpenVPN is a userspace software existing since around 2005 that allows
> users to create secure tunnels.
> 
> So far OpenVPN has implemented all operations in userspace, which
> implies several back and forth between kernel and user land in order to
> process packets (encapsulate/decapsulate, encrypt/decrypt, rerouting..).
> 
> With `ovpn` we intend to move the fast path (data channel) entirely
> in kernel space and thus improve user measured throughput over the
> tunnel.
> 
> `ovpn` is implemented as a simple virtual network device driver, that
> can be manipulated by means of the standard RTNL APIs. A device of kind
> `ovpn` allows only IPv4/6 traffic and can be of type:
> * P2P (peer-to-peer): any packet sent over the interface will be
>    encapsulated and transmitted to the other side (typical OpenVPN
>    client or peer-to-peer behaviour);
> * P2MP (point-to-multipoint): packets sent over the interface are
>    transmitted to peers based on existing routes (typical OpenVPN
>    server behaviour).
> 
> After the interface has been created, OpenVPN in userspace can
> configure it using a new Netlink API. Specifically it is possible
> to manage peers and their keys.
> 
> The OpenVPN control channel is multiplexed over the same transport
> socket by means of OP codes. Anything that is not DATA_V2 (OpenVPN
> OP code for data traffic) is sent to userspace and handled there.
> This way the `ovpn` codebase is kept as compact as possible while
> focusing on handling data traffic only (fast path).
> 
> Any OpenVPN control feature (like cipher negotiation, TLS handshake,
> rekeying, etc.) is still fully handled by the userspace process.
> 
> When userspace establishes a new connection with a peer, it first
> performs the handshake and then passes the socket to the `ovpn` kernel
> module, which takes ownership. From this moment on `ovpn` will handle
> data traffic for the new peer.
> When control packets are received on the link, they are forwarded to
> userspace through the same transport socket they were received on, as
> userspace is still listening to them.
> 
> Some events (like peer deletion) are sent to a Netlink multicast group.
> 
> Although it wasn't easy to convince the community, `ovpn` implements
> only a limited number of the data-channel features supported by the
> userspace program.
> 
> Each feature that made it to `ovpn` was attentively vetted to
> avoid carrying too much legacy along with us (and to give a clear cut to
> old and probalby-not-so-useful features).
> 
> Notably, only encryption using AEAD ciphers (specifically
> ChaCha20Poly1305 and AES-GCM) was implemented. Supporting any other
> cipher out there was not deemed useful.
> 
> Both UDP and TCP sockets ae supported.

s/ae/are/

> As explained above, in case of P2MP mode, OpenVPN will use the main system
> routing table to decide which packet goes to which peer. This implies
> that no routing table was re-implemented in the `ovpn` kernel module.
> 
> This kernel module can be enabled by selecting the CONFIG_OVPN entry
> in the networking drivers section.

Most of the above text has no relation to the patch itself. Should it be 
moved to the cover letter?

> NOTE: this first patch introduces the very basic framework only.
> Features are then added patch by patch, however, although each patch
> will compile and possibly not break at runtime, only after having
> applied the full set it is expected to see the ovpn module fully working.
> 
> Cc: steffen.klassert@secunet.com
> Cc: antony.antony@secunet.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   MAINTAINERS               |   8 ++++
>   drivers/net/Kconfig       |  13 ++++++
>   drivers/net/Makefile      |   1 +
>   drivers/net/ovpn/Makefile |  11 +++++
>   drivers/net/ovpn/io.c     |  22 +++++++++
>   drivers/net/ovpn/io.h     |  15 ++++++
>   drivers/net/ovpn/main.c   | 116 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/ovpn/main.h   |  15 ++++++
>   include/uapi/linux/udp.h  |   1 +
>   9 files changed, 202 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f39ab140710f16b1245924bfe381cd64d499ff8a..09e193bbc218d74846cbae26f80ada3e04c3692a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17286,6 +17286,14 @@ F:	arch/openrisc/
>   F:	drivers/irqchip/irq-ompic.c
>   F:	drivers/irqchip/irq-or1k-*
>   
> +OPENVPN DATA CHANNEL OFFLOAD
> +M:	Antonio Quartulli <antonio@openvpn.net>
> +L:	openvpn-devel@lists.sourceforge.net (moderated for non-subscribers)
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
> +F:	drivers/net/ovpn/
> +
>   OPENVSWITCH
>   M:	Pravin B Shelar <pshelar@ovn.org>
>   L:	netdev@vger.kernel.org
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6af0e1a861867039c3624fc618e25..269b73fcfd348a48174fb96b8f8d4f8788636fa8 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
>   
>   	  Say N here unless you know what you're doing.
>   
> +config OVPN
> +	tristate "OpenVPN data channel offload"
> +	depends on NET && INET
> +	select NET_UDP_TUNNEL
> +	select DST_CACHE
> +	select CRYPTO
> +	select CRYPTO_AES
> +	select CRYPTO_GCM
> +	select CRYPTO_CHACHA20POLY1305

nit: Options from NET_UDP_TUNNEL to CRYPTO_CHACHA20POLY1305 are not 
required for changes introduced in this patch. Should they be moved to 
corresponding patches?

> +	help
> +	  This module enhances the performance of the OpenVPN userspace software
> +	  by offloading the data channel processing to kernelspace.
> +
>   config EQUALIZER
>   	tristate "EQL (serial line load balancing) support"
>   	help
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 13743d0e83b5fde479e9b30ad736be402d880dee..5152b3330e28da7eaec821018a26c973bb33ce0c 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IPVLAN) += ipvlan/
>   obj-$(CONFIG_IPVTAP) += ipvlan/
>   obj-$(CONFIG_DUMMY) += dummy.o
>   obj-$(CONFIG_WIREGUARD) += wireguard/
> +obj-$(CONFIG_OVPN) += ovpn/
>   obj-$(CONFIG_EQUALIZER) += eql.o
>   obj-$(CONFIG_IFB) += ifb.o
>   obj-$(CONFIG_MACSEC) += macsec.o
> diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..53fb197027d787d6683e9056d3d341abf6ed38e4
> --- /dev/null
> +++ b/drivers/net/ovpn/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# ovpn -- OpenVPN data channel offload in kernel space
> +#
> +# Copyright (C) 2020-2024 OpenVPN, Inc.
> +#
> +# Author:	Antonio Quartulli <antonio@openvpn.net>
> +
> +obj-$(CONFIG_OVPN) := ovpn.o
> +ovpn-y += main.o
> +ovpn-y += io.o
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f
> --- /dev/null
> +++ b/drivers/net/ovpn/io.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
> +
> +#include "io.h"
> +
> +/* Send user data to the network
> + */
> +netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	skb_tx_error(skb);
> +	kfree_skb(skb);
> +	return NET_XMIT_DROP;
> +}
> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..aa259be66441f7b0262f39da12d6c3dce0a9b24c
> --- /dev/null
> +++ b/drivers/net/ovpn/io.h
> @@ -0,0 +1,15 @@
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
> +netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
> +
> +#endif /* _NET_OVPN_OVPN_H_ */
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..369a5a2b2fc1a497c8444e59f9b058eb40e49524
> --- /dev/null
> +++ b/drivers/net/ovpn/main.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <net/rtnetlink.h>
> +
> +#include "main.h"
> +#include "io.h"
> +
> +/* Driver info */
> +#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> +#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."

nit: these strings are used only once for MODULE_{DESCRIPTION,AUTHOR} 
below. Can we directly use strings to avoid levels of indirection?

> +
> +/**
> + * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
> + * @dev: the interface to check
> + *
> + * Return: whether the netdevice is of type 'ovpn'
> + */
> +bool ovpn_dev_is_valid(const struct net_device *dev)
> +{
> +	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;

You can directly check for the ops matching saving one dereferencing 
operation:

return dev->netdev_ops == &ovpn_netdev_ops;

You can define an empty ovpn_netdev_ops struct for this purpose in this 
patch and fill ops later with next patches. This way you can even move 
the ovpn_net_xmit() definition to the interface creation/destruction patch.

> +}
> +
> +static int ovpn_newlink(struct net *src_net, struct net_device *dev,
> +			struct nlattr *tb[], struct nlattr *data[],
> +			struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct rtnl_link_ops ovpn_link_ops = {
> +	.kind = "ovpn",
> +	.netns_refund = false,
> +	.newlink = ovpn_newlink,
> +	.dellink = unregister_netdevice_queue,
> +};
> +
> +static int ovpn_netdev_notifier_call(struct notifier_block *nb,
> +				     unsigned long state, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +
> +	if (!ovpn_dev_is_valid(dev))
> +		return NOTIFY_DONE;
> +
> +	switch (state) {
> +	case NETDEV_REGISTER:
> +		/* add device to internal list for later destruction upon
> +		 * unregistration
> +		 */
> +		break;
> +	case NETDEV_UNREGISTER:
> +		/* can be delivered multiple times, so check registered flag,
> +		 * then destroy the interface
> +		 */
> +		break;
> +	case NETDEV_POST_INIT:
> +	case NETDEV_GOING_DOWN:
> +	case NETDEV_DOWN:
> +	case NETDEV_UP:
> +	case NETDEV_PRE_UP:
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block ovpn_netdev_notifier = {
> +	.notifier_call = ovpn_netdev_notifier_call,
> +};
> +
> +static int __init ovpn_init(void)
> +{
> +	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
> +
> +	if (err) {
> +		pr_err("ovpn: can't register netdevice notifier: %d\n", err);
> +		return err;
> +	}
> +
> +	err = rtnl_link_register(&ovpn_link_ops);
> +	if (err) {
> +		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
> +		goto unreg_netdev;
> +	}
> +
> +	return 0;
> +
> +unreg_netdev:
> +	unregister_netdevice_notifier(&ovpn_netdev_notifier);
> +	return err;
> +}
> +
> +static __exit void ovpn_cleanup(void)
> +{
> +	rtnl_link_unregister(&ovpn_link_ops);
> +	unregister_netdevice_notifier(&ovpn_netdev_notifier);
> +
> +	rcu_barrier();
> +}
> +
> +module_init(ovpn_init);
> +module_exit(ovpn_cleanup);
> +
> +MODULE_DESCRIPTION(DRV_DESCRIPTION);
> +MODULE_AUTHOR(DRV_COPYRIGHT);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a3215316c49bfcdf2496590bac878f145b8b27fd
> --- /dev/null
> +++ b/drivers/net/ovpn/main.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_MAIN_H_
> +#define _NET_OVPN_MAIN_H_
> +
> +bool ovpn_dev_is_valid(const struct net_device *dev);
> +
> +#endif /* _NET_OVPN_MAIN_H_ */
> diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> index d85d671deed3c78f6969189281b9083dcac000c6..edca3e430305a6bffc34e617421f1f3071582e69 100644
> --- a/include/uapi/linux/udp.h
> +++ b/include/uapi/linux/udp.h
> @@ -43,5 +43,6 @@ struct udphdr {
>   #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
>   #define UDP_ENCAP_RXRPC		6
>   #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
> +#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */

nit: this specific change does not belong to this specific patch.

>   
>   #endif /* _UAPI_LINUX_UDP_H */
> 


