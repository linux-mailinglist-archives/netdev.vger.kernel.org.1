Return-Path: <netdev+bounces-59725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1781BDE3
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803A428C347
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2926634F7;
	Thu, 21 Dec 2023 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8rlK77f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D8627E2
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E7C433C7;
	Thu, 21 Dec 2023 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703181904;
	bh=S0rperlvdvRpLYdAUUBME525R9ucxPyKYFMs2MF8Xcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8rlK77f8w0IcfwVUFSYPCxVRvAPBP3vU8f3JgtAvPZmLzZwt/xSeTFDySOw9Xc54
	 RYcpLWCYDIkR6UUbjinGUgjhoIWa+0+5T4sDpViAwkHX/tf36E0AqTLvLrQl2eOSg8
	 0PHPYNMaSBp2r8gEygViP9kzCAestlyJyFT5kwrpFic5nWbs6CiPNIcWJqW1AWljZc
	 lXbSZU25DfS1FpjVDUe2mzgtR7Nt3TE6OkIqmFH+NemTrT3XF+9aMlmpfjrhKuyruO
	 roPQzkNo8xXt0/DVydErP+NbBMql9r95H/qwJ4tamsYe24RjcF1mQEgtDJOuLzyWp7
	 /rk7f9jBri8Pw==
Date: Thu, 21 Dec 2023 19:04:57 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Message-ID: <20231221180457.GE1202958@kernel.org>
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
 <20231221-new-gemini-ethernet-regression-v3-3-a96b4374bfe8@linaro.org>
 <CANn89iLuRKOeUGUV+X3fqAe+9gvLfqj5dCfbqqE78FYL+E2MRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLuRKOeUGUV+X3fqAe+9gvLfqj5dCfbqqE78FYL+E2MRQ@mail.gmail.com>

On Thu, Dec 21, 2023 at 09:50:41AM +0100, Eric Dumazet wrote:
> On Thu, Dec 21, 2023 at 1:02 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > We had workarounds were the ethernet checksumming engine would be bypassed
> > for larger frames, this fixed devices using DSA, but regressed devices
> > where the ethernet was connected directly to a PHY.
> >
> > The devices with a PHY connected directly can't handle large frames
> > either way, with or without bypass. Looking at the size of the frame
> > is probably just wrong.
> >
> > Rework the workaround such that we just bypass the checksumming engine if
> > the ethertype inside the actual frame is something else than 0x0800
> > (IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engine
> > can actually handle. VLAN framing (0x8100) also works fine.
> >
> > We can't inspect skb->protocol because DSA frames will sometimes have a
> > custom ethertype despite skb->protocol is e.g. 0x0800.
> >
> > After this both devices with direct ethernet attached such as D-Link
> > DNS-313 and devices with a DSA switch with a custom ethertype such as
> > D-Link DIR-685 work fine.
> >
> > Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/net/ethernet/cortina/gemini.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> > index ecc247acac39..6d153eba8e81 100644
> > --- a/drivers/net/ethernet/cortina/gemini.c
> > +++ b/drivers/net/ethernet/cortina/gemini.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/of_net.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/etherdevice.h>
> > +#include <linux/if_ether.h>
> >  #include <linux/if_vlan.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/phy.h>
> > @@ -1143,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
> >         skb_frag_t *skb_frag;
> >         dma_addr_t mapping;
> >         unsigned short mtu;
> > +       u16 ethertype;
> >         void *buffer;
> >
> >         mtu  = ETH_HLEN;
> > @@ -1158,7 +1160,24 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
> >                 word3 |= mtu;
> >         }
> >
> > -       if (skb->ip_summed == CHECKSUM_PARTIAL) {
> > +       /* Dig out the the ethertype actually in the buffer and not what the
> > +        * protocol claims to be. This is the raw data that the checksumming
> > +        * offload engine will have to deal with.
> > +        */
> > +       ethertype = skb_eth_raw_ethertype(skb);
> > +       /* This is the only VLAN type supported by this hardware so check for
> > +        * that: the checksumming engine can handle IP and IPv6 inside 802.1Q.
> > +        */
> > +       if (ethertype == ETH_P_8021Q)
> > +               ethertype = vlan_get_protocol(skb);
> 
> You meant : ethertype = __vlan_get_protocol(skb, ethertype, NULL);
> 
> Otherwise skb->protocol could be something unexpected, according to
> your comments.

Also, __vlan_get_protocol() deals with big endian Ether Types,
so I think you need something like:

	ethertype = be16_to_cpu(__vlan_get_protocol(skb, cpu_to_be16(ethertype),
						    NULL));

Which is a bit ugly, so perhaps it is nicer to switch
things around so ethertype is __be16. And perhaps the
return value of skb_eth_raw_ethertype is __be16 too.

> 
> > +
> > +       if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
> > +               /* Hardware offloaded checksumming isn't working on non-IP frames.
> > +                * This happens for example on some DSA switches using a custom
> > +                * ethertype. Just bypass the engine for those.
> > +                */
> > +               word1 |= TSS_BYPASS_BIT;
> > +       } else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> >                 int tcp = 0;
> >
> >                 /* We do not switch off the checksumming on non TCP/UDP
> >
> > --
> > 2.34.1
> >
> 

