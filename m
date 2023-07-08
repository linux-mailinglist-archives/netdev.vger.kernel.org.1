Return-Path: <netdev+bounces-16167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C274BA74
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D928198D
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B580197;
	Sat,  8 Jul 2023 00:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC3195
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 00:08:22 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16511B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688774900; x=1720310900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/10GfcX+HPwYExreHzU6Wgc28EDPcuv0Kuk9GuUuxD8=;
  b=maVMRlACXs1Z3FgYY7Hg2NjZ65Ba0uRcs2QBuCOjts2AZl1FCYWW1Xoh
   m1WCI3qw8+QMELog4PLF9LCItMsRNm0q0woorgD3VpplaZrNaqjCfH+0c
   bbKHZMkZqEJVegBj5UaHvDuuJNpbAloxPKD/H68+wH4SO/pnbUO9as5jr
   I=;
X-IronPort-AV: E=Sophos;i="6.01,189,1684800000"; 
   d="scan'208";a="294634491"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 00:08:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 26EA38046C;
	Sat,  8 Jul 2023 00:08:10 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:08:03 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:08:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <wangyufen@huawei.com>
Subject: Re: [PATCH v1 net] icmp6: Fix null-ptr-deref of fib6_null_entry->rt6i_idev in icmp6_dev().
Date: Fri, 7 Jul 2023 17:07:52 -0700
Message-ID: <20230708000752.62733-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4950eec4-b5ec-89ab-2e1d-311ad5dcdc0c@kernel.org>
References: <4950eec4-b5ec-89ab-2e1d-311ad5dcdc0c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.9]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Ahern <dsahern@kernel.org>
Date: Fri, 7 Jul 2023 15:42:58 -0600
> On 7/6/23 5:30 PM, Kuniyuki Iwashima wrote:
> > With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> > has the link-local address as src and dst IP and will be forwarded to
> > an external IP in the IPv6 Ext Hdr.
> > 
> > For example, the script below generates a packet whose src IP is the
> > link-local address and dst is updated to 11::.
> > 
> >   # for f in $(find /proc/sys/net/ -name *seg6_enabled*); do echo 1 > $f; done
> >   # python3
> >   >>> from socket import *
> >   >>> from scapy.all import *
> >   >>>
> >   >>> SRC_ADDR = DST_ADDR = "fe80::5054:ff:fe12:3456"
> >   >>>
> >   >>> pkt = IPv6(src=SRC_ADDR, dst=DST_ADDR)
> >   >>> pkt /= IPv6ExtHdrSegmentRouting(type=4, addresses=["11::", "22::"], segleft=1)
> >   >>>
> >   >>> sk = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)
> >   >>> sk.sendto(bytes(pkt), (DST_ADDR, 0))
> > 
> > For such a packet, we call ip6_route_input() to look up a route for the
> > next destination in these three functions depending on the header type.
> > 
> >   * ipv6_rthdr_rcv()
> >   * ipv6_rpl_srh_rcv()
> >   * ipv6_srh_rcv()
> > 
> > If no route is found, fib6_null_entry is set to skb, and the following
> 
> ip6_null_entry is the one set on the skb.

Oops, I'm lost while writing :)

I'll update subject, changelog, and comment in v2.

Thanks, David!


> 
> > dst_input(skb) calls ip6_pkt_drop().
> > 
> > Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
> > as the input device is the loopback interface.  Then, we have to check if
> > skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
> > for fib6_null_entry.
> > 
> 
> ...
> 
> > 
> > Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
> > Reported-by: Wang Yufen <wangyufen@huawei.com>
> > Closes: https://lore.kernel.org/netdev/1ddf7fc8-bcb3-ab48-4894-24158e8a9d0f@huawei.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv6/icmp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> > index 9edf1f45b1ed..bd6479e3c757 100644
> > --- a/net/ipv6/icmp.c
> > +++ b/net/ipv6/icmp.c
> > @@ -424,7 +424,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
> >  	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
> >  		const struct rt6_info *rt6 = skb_rt6_info(skb);
> >  
> > -		if (rt6)
> > +		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
> > +		 * and fib6_null_entry could be set to skb if no route is found.
> > +		 */
> > +		if (rt6 && rt6->rt6i_idev)
> >  			dev = rt6->rt6i_idev->dev;
> >  	}
> >  
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>

