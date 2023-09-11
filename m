Return-Path: <netdev+bounces-32792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BBB79A71F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2683280CAC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA1C157;
	Mon, 11 Sep 2023 10:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC80C129
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:10:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C6101
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427003; x=1725963003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cWQCr6326rcQV0Ctr+xviO22iHTuRxhc6Uks+r6hMDw=;
  b=XLKyUMRLIBCrIfiFXFP3isysI1Xvs5OSZsszw0liF3bNhoRMpIYW8Mr3
   eC7nIrq0+idJdrjddmzJlr9eP4lqCnAmFqaqn0DEriEblfp+cmymUBDsJ
   IFNZ03aeeJMPudwHCMw8S03Lb/PQ9ihGbmE709dBBEulHhipm/3j4Xs92
   3+BQYzjutTQycnJYym5JMYPt9RC1aJhkx4vEnl/SMMYveejQUPdIQJn4K
   P2WNw3qTGX18dO5VGjHZwtYCNG3GwSrLCrRds1EFskBX0tWHIRNI7rIdy
   oDPVcr0kpfLFpbpCxYJ76o3SSdJhXmojTvR3hVxuUtJ4MrP2eXuzQVRLR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358347446"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358347446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778333529"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778333529"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 11 Sep 2023 03:09:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DCD7F988; Mon, 11 Sep 2023 13:09:56 +0300 (EEST)
Date: Mon, 11 Sep 2023 13:09:56 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Balcanquall <alex@alexbal.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: thunderbolt: Fix TCP/UDPv6 GSO checksum calculation
Message-ID: <20230911100956.GZ1599918@black.fi.intel.com>
References: <20230911095039.3611113-1-mika.westerberg@linux.intel.com>
 <CANn89i+RbD3Dr+ca1+HErkW099DgZXQ7VF=vcY3zAd-xViFusg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+RbD3Dr+ca1+HErkW099DgZXQ7VF=vcY3zAd-xViFusg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Sep 11, 2023 at 12:03:06PM +0200, Eric Dumazet wrote:
> On Mon, Sep 11, 2023 at 11:50 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Alex reported that running ssh over IPv6 does not work with
> > Thunderbolt/USB4 networking driver. The reason for that is that driver
> > should call skb_is_gso() before calling skb_is_gso_v6(), and it should
> > not return false after calculates the checksum successfully. This probably
> > was a copy paste error from the original driver where it was done
> > properly.
> >
> > While there add checksum calculation for UDPv6 GSO packets as well.
> 
> This part does not belong to this patch, and should be submitted for net-next.
> 
> Note that this driver is not supposed to receive UDP GSO packets.

Ah, indeed.

I took this part from the original driver that was submitted
around 2016-2017 timeframe but was never merged. This current driver is
reworked version but I missed the skb_is_gso() and the rest.

> >
> > Cc: stable@vger.kernel.org
> 
> What would be the Fixes: tag for this patch ?

It would be the initial commit:

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")

But I was not sure if it is really practical here. I can add it to v2.

> > Reported-by: Alex Balcanquall <alex@alexbal.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/net/thunderbolt/main.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > index 0c1e8970ee58..ba50a554478f 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> > @@ -1049,12 +1049,21 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
> >                 *tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
> >                                             ip_hdr(skb)->daddr, 0,
> >                                             ip_hdr(skb)->protocol, 0);
> > -       } else if (skb_is_gso_v6(skb)) {
> > -               tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
> > -               *tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> > -                                         &ipv6_hdr(skb)->daddr, 0,
> > -                                         IPPROTO_TCP, 0);
> > -               return false;
> > +       } else if (skb_is_gso(skb)) {
> > +               if (skb_is_gso_v6(skb)) {
> > +                       tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
> > +                       *tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> > +                                                 &ipv6_hdr(skb)->daddr, 0,
> > +                                                 IPPROTO_TCP, 0);
> > +               } else if (protocol == htons(ETH_P_IPV6) &&
> > +                          (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)) {
> > +                       tucso = dest + ((void *)&(udp_hdr(skb)->check) - data);
> > +                       *tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> > +                                                 &ipv6_hdr(skb)->daddr, 0,
> > +                                                 IPPROTO_UDP, 0);
> 
> This is dead code in the current state of this driver.

Thanks! I will submit v2 with that dropped.

> > +               } else {
> > +                       return false;
> > +               }
> >         } else if (protocol == htons(ETH_P_IPV6)) {
> >                 tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
> >                 *tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> > --
> > 2.40.1
> >

