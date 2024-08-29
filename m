Return-Path: <netdev+bounces-123236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2438D96436E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622FAB25D12
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9987718E375;
	Thu, 29 Aug 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="eqZzHJ93"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FC1917D7
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931913; cv=none; b=kmrrkuPSfVNTkvIOQJ9JPUe0bvVXz/XchDq5mltMIU+vpcE4PGksKv2cInfHzShGllqadFrH4ZBkh+8nSNTcSh3mhjeySRLkl+YlXYaE6f2H9/ZJGIi8N7eqU/nGZrNv21y5dJqCGFV5dZ7PC0f3dF5xbK1YdEWiIFo1eHbJIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931913; c=relaxed/simple;
	bh=JTrJxhooLI6qLnBhS6Jxq2IQtct3MYih4J86EiVKU4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbZs5+DlnytmSTYerUNWeejZe3tO8IlUUvx39pNQH+HBdJS72n7PY2KF8IOgawdLrudkklPbMN6TGHadL8PhwngIwF79eMm/NJwhprrPTgVFOg8Iol/nPQqzrtn5XOw18JAMwBT06HW1MwOpWb51JlnsUDkz1N9lFQPFwYTP0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=eqZzHJ93; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: f9a02f26-65fb-11ef-b0b2-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f9a02f26-65fb-11ef-b0b2-005056abbe64;
	Thu, 29 Aug 2024 13:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=ngDrZ5ulhcbXqi+3cdcOaZPEkuFWBmJJEx1FfoL6N/0=;
	b=eqZzHJ93FAfC0lwBjHJ7K4W22+1qY+QRT10qpGzuMrW2dyP4R5GXNIOP89yQtGCqwkU3lHuQPBZUt
	 ka+yYWmKzOg9ZGwhOw+mlzyl4jjcZmgn9Omtm0jsfWORsJDBLhpaYqU/sUKMH1fsbFE0WD3v1Xysx+
	 cX0iCia4dLnT7FK4=
X-KPN-MID: 33|ywHbeqyAG8hOGh8D5A/dHu8DbmxzRoWcj9xLwHzKM6gxlm1fNd9QQMd3orNZsxS
 Ckdl5TXYNxPil+7y9BvrnkTxXnUMQMQSHAMMZEZf99iw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|QEw2RsUmDfR1jwwLTWGVBXQwgh96gaa+ivDdc7G69A9y/JJwOepwo/fw3V4/ObO
 pBrYhgkJWfDoFjbOYAWr5mQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f9fdd7bb-65fb-11ef-8890-005056ab7447;
	Thu, 29 Aug 2024 13:43:59 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:43:57 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v10 07/16] xfrm: iptfs: add new iptfs xfrm
 mode impl
Message-ID: <ZtBe_anpf3QOG8jW@Antony2201.local>
References: <20240824022054.3788149-1-chopps@chopps.org>
 <20240824022054.3788149-8-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NMxVuAkGGEZbhbb+"
Content-Disposition: inline
In-Reply-To: <20240824022054.3788149-8-chopps@chopps.org>


--NMxVuAkGGEZbhbb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2024 at 10:20:45PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Multiple commits follow to build the functionality into xfrm_iptfs.c
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/Makefile     |   1 +
>  net/xfrm/xfrm_iptfs.c | 210 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 211 insertions(+)
>  create mode 100644 net/xfrm/xfrm_iptfs.c
> 
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index 512e0b2f8514..5a1787587cb3 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -21,5 +21,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>  obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644
> index 000000000000..201406175d17
> --- /dev/null
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* xfrm_iptfs: IPTFS encapsulation support
> + *
> + * April 21 2022, Christian Hopps <chopps@labn.net>
> + *
> + * Copyright (c) 2022, LabN Consulting, L.L.C.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/icmpv6.h>
> +#include <net/gro.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> +#include <net/inet_ecn.h>
> +#include <net/xfrm.h>
> +
> +#include <crypto/aead.h>
> +
> +#include "xfrm_inout.h"
> +
> +/**
> + * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
> + * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
> + *	otherwise the user specified value.
> + */
> +struct xfrm_iptfs_config {
> +	u32 pkt_size;	    /* outer_packet_size or 0 */
> +};
> +
> +/**
> + * struct xfrm_iptfs_data - mode specific xfrm state.
> + * @cfg: IPTFS tunnel config.
> + * @x: owning SA (xfrm_state).
> + * @payload_mtu: max payload size.
> + */
> +struct xfrm_iptfs_data {
> +	struct xfrm_iptfs_config cfg;
> +
> +	/* Ingress User Input */
> +	struct xfrm_state *x;	    /* owning state */
> +	u32 payload_mtu;	    /* max payload size */
> +};
> +
> +/* ========================== */
> +/* State Management Functions */
> +/* ========================== */
> +
> +/**
> + * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
> + * @x: xfrm state.
> + * @outer_mtu: the outer mtu
> + */
> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
> +{
> +	struct crypto_aead *aead;
> +	u32 blksize;
> +
> +	aead = x->data;
> +	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
> +	return ((outer_mtu - x->props.header_len - crypto_aead_authsize(aead)) &
> +		~(blksize - 1)) - 2;
> +}
> +
> +/**
> + * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
> + * @net: the net data
> + * @x: xfrm state
> + * @attrs: netlink attributes
> + * @extack: extack return data
> + *
> + * Return: 0 on success or a negative error code on failure
> + */
> +static int iptfs_user_init(struct net *net, struct xfrm_state *x,
> +			   struct nlattr **attrs,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc;
> +
> +	xc = &xtfs->cfg;
> +
> +	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
> +		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
> +		if (!xc->pkt_size) {
> +			xtfs->payload_mtu = 0;
> +		} else if (xc->pkt_size > x->props.header_len) {
> +			xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
> +		} else {
> +			NL_SET_ERR_MSG(extack,
> +				       "Packet size must be 0 or greater than IPTFS/ESP header length");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static unsigned int iptfs_sa_len(const struct xfrm_state *x)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
> +	unsigned int l = 0;
> +
> +	if (x->dir == XFRM_SA_DIR_OUT)
> +		l += nla_total_size(sizeof(xc->pkt_size));
> +
> +	return l;
> +}
> +
> +static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
> +	int ret = 0;
> +
> +	if (x->dir == XFRM_SA_DIR_OUT)
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
> +
> +	return ret;
> +}
> +
> +static void __iptfs_init_state(struct xfrm_state *x,
> +			       struct xfrm_iptfs_data *xtfs)
> +{
> +	/* Modify type (esp) adjustment values */
> +
> +	if (x->props.family == AF_INET)
> +		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
> +	else if (x->props.family == AF_INET6)
> +		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
> +	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
> +
> +	/* Always keep a module reference when x->mode_data is set */
> +	__module_get(x->mode_cbs->owner);
> +
> +	x->mode_data = xtfs;
> +	xtfs->x = x;
> +}
> +
> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
> +{
> +	struct xfrm_iptfs_data *xtfs;
> +
> +	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
> +	if (!xtfs)
> +		return -ENOMEM;
> +
> +	__iptfs_init_state(x, xtfs);

I noticed __iptfs_init_state() is called twice during XFRM_MSG_MIGRATE.
This, the first, call does the right thing. However, the second call resets 
the iptfs values to zero.

While testing I noticed clone is not workig as expected. It seems to reset 
values iptfs. See the "ip x s"  out before and after clone.

Here are two "ip x s"  output one before clone and another after clone noice 
iptfs values are 0, while before max-queue-size 10485760

root@east:/testing/pluto/ikev2-mobike-01$ip x s
src 192.1.2.23 dst 192.1.3.33
	proto esp spi 0xcd561999 reqid 16393 mode iptfs
	replay-window 0 flag af-unspec esn
	auth-trunc hmac(sha256) 0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
	enc cbc(aes) 0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
	lastused 2024-08-29 12:33:12
	anti-replay esn context:
	 seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
	 replay_window 0, bitmap-length 0
	dir out
	iptfs-opts dont-frag init-delay 0 max-queue-size 10485760 pkt-size 0
src 192.1.3.33 dst 192.1.2.23
	proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
	replay-window 0 flag af-unspec esn
	auth-trunc hmac(sha256) 0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
	enc cbc(aes) 0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
	lastused 2024-08-29 12:33:12
	anti-replay esn context:
	 seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
	 replay_window 128, bitmap-length 4
	 00000000 00000000 00000000 000007ff
	dir in
	iptfs-opts drop-time 3 reorder-window 3

After migrate: note iptfs vallues are 0.

root@east:/testing/pluto/ikev2-mobike-01$ip x s
src 192.1.8.22 dst 192.1.2.23
	proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
	replay-window 0 flag af-unspec esn
	auth-trunc hmac(sha256) 0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
	enc cbc(aes) 0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
	lastused 2024-08-29 12:33:12
	anti-replay esn context:
	 seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
	 replay_window 128, bitmap-length 4
	 00000000 00000000 00000000 000007ff
	dir in
	iptfs-opts drop-time 0 reorder-window 0
src 192.1.2.23 dst 192.1.8.22
	proto esp spi 0xcd561999 reqid 16393 mode iptfs
	replay-window 0 flag af-unspec esn
	auth-trunc hmac(sha256) 0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
	enc cbc(aes) 0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
	lastused 2024-08-29 12:33:12
	anti-replay esn context:
	 seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
	 replay_window 0, bitmap-length 0
	dir out
	iptfs-opts init-delay 0 max-queue-size 0 pkt-size 0

Now running under gdb during a migrate I see __iptfs_init_state() called 
twice.

I got gdb back trace to show the two calls during XFRM_MSG_MIGRATE.

First call __iptfs_init_state() with bt. This is during clone/MIGRATE.

#0  __iptfs_init_state (x=x@entry=0xffff888110a1fc40, xtfs=xtfs@entry=0xffff88810e275000)
    at net/xfrm/xfrm_iptfs.c:2674
#1  0xffffffff81ece552 in iptfs_clone (x=0xffff888110a1fc40, orig=<optimized out>)
    at net/xfrm/xfrm_iptfs.c:2722
#2  0xffffffff81eb65ad in xfrm_state_clone (encap=0xffffffff00000010, orig=0xffff888110a1e040)
    at net/xfrm/xfrm_state.c:1878
#3  xfrm_state_migrate (x=x@entry=0xffff888110a1e040, m=m@entry=0xffffc90001b47400,
    encap=encap@entry=0x0 <fixed_percpu_data>) at net/xfrm/xfrm_state.c:1948
#4  0xffffffff81ea9206 in xfrm_migrate (sel=sel@entry=0xffff88811193ce50, dir=<optimized out>,
    type=type@entry=0 '\000', m=m@entry=0xffffc90001b47400, num_migrate=num_migrate@entry=1,
    k=k@entry=0x0 <fixed_percpu_data>, net=<optimized out>, encap=<optimized out>, if_id=<optimized out>,
    extack=<optimized out>) at net/xfrm/xfrm_policy.c:4652
#5  0xffffffff81ec26de in xfrm_do_migrate (skb=skb@entry=0xffff888109265000, nlh=<optimized out>,
    attrs=attrs@entry=0xffffc90001b47730, extack=<optimized out>) at net/xfrm/xfrm_user.c:3047
#6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=0xffff888109265000, nlh=<optimized out>,
    extack=<optimized out>) at net/xfrm/xfrm_user.c:3389
---
second call to __iptfs_init_state() bt.

#0  __iptfs_init_state (x=x@entry=0xffff888110a1fc40, xtfs=0xffff88810e272000) at net/xfrm/xfrm_iptfs.c:2674
#1  0xffffffff81ece1a4 in iptfs_create_state (x=0xffff888110a1fc40) at net/xfrm/xfrm_iptfs.c:2742
#2  0xffffffff81eb5c61 in xfrm_init_state (x=x@entry=0xffff888110a1fc40) at net/xfrm/xfrm_state.c:3042
#3  0xffffffff81eb65dc in xfrm_state_migrate (x=x@entry=0xffff888110a1e040, m=m@entry=0xffffc90001b47400,
    encap=encap@entry=0x0 <fixed_percpu_data>) at net/xfrm/xfrm_state.c:1954
#4  0xffffffff81ea9206 in xfrm_migrate (sel=sel@entry=0xffff88811193ce50, dir=<optimized out>,
    type=type@entry=0 '\000', m=m@entry=0xffffc90001b47400, num_migrate=num_migrate@entry=1,
    k=k@entry=0x0 <fixed_percpu_data>, net=<optimized out>, encap=<optimized out>, if_id=<optimized out>,
    extack=<optimized out>) at net/xfrm/xfrm_policy.c:4652
#5  0xffffffff81ec26de in xfrm_do_migrate (skb=skb@entry=0xffff888109265000, nlh=<optimized out>,
    attrs=attrs@entry=0xffffc90001b47730, extack=<optimized out>) at net/xfrm/xfrm_user.c:3047
#6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=0xffff888109265000, 
nlh=<optimized out>,

I have a proposed fix against v10, that seems to work. see the attached 
patch. The patch is applied top of the series.

-antony

PS: this exact issue was also reported in:
https://www.spinics.net/lists/netdev/msg976146.html

--NMxVuAkGGEZbhbb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-call-iptfs-state-init-only-once-during-cloning.patch"

From fced06475e82f328aede0370d26336bc8a48c333 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Thu, 29 Aug 2024 13:23:42 +0200
Subject: [PATCH] call iptfs state init only once during cloning.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 7f7b3078ca70..aa18ee4733f8 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2722,9 +2722,13 @@ static int iptfs_create_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs;
 
-	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
-	if (!xtfs)
-		return -ENOMEM;
+	if (x->mode_data) {
+		xtfs = x->mode_data;
+	} else {
+		xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
+		if (!xtfs)
+			return -ENOMEM;
+	}
 
 	__iptfs_init_state(x, xtfs);
 
-- 
2.43.0


--NMxVuAkGGEZbhbb+--

