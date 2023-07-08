Return-Path: <netdev+bounces-16172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C274BB21
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647AE1C210FE
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2210FA;
	Sat,  8 Jul 2023 01:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9347F
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:40:24 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4D129
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688780424; x=1720316424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n9EOIQUCKs5tuvlBxnZjs/3WuMa3Z+yAA+dDXVSgfJA=;
  b=kHuy8qnE5yvmN2la42xPfkQxTsKmweNndJgLeVziG7ef/XxSGVgVNpIx
   yyxwJQvggQoyXz/BPylR1GWuciEhVjWInNsmktI3cARhCQOuih+/wmVzf
   tO0U2tbRCzSaQe2GmSiqccPRkoXWLZCGC7jrtGNSwWjQWeQg/7+jDJ8TQ
   8=;
X-IronPort-AV: E=Sophos;i="6.01,189,1684800000"; 
   d="scan'208";a="343392338"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 01:40:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 7922E40D6D;
	Sat,  8 Jul 2023 01:40:17 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 01:40:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 01:40:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <wangyufen@huawei.com>
Subject: Re: [PATCH v2 net] icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
Date: Fri, 7 Jul 2023 18:40:06 -0700
Message-ID: <20230708014006.86743-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8ae0ccf3-0e88-f968-037d-f7f2a1d7ba9a@huawei.com>
References: <8ae0ccf3-0e88-f968-037d-f7f2a1d7ba9a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.9]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 8 Jul 2023 09:35:27 +0800
> On 2023/7/8 8:21, Kuniyuki Iwashima wrote:
> > With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> > has the link-local address as src and dst IP and will be forwarded to
> > an external IP in the IPv6 Ext Hdr.
> > 
> > For example, the script below generates a SRv6 packet whose src IP is
> > the link-local address and dst is updated to 11::.
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
> > If no route is found, ip6_null_entry is set to skb, and the following
> > dst_input(skb) calls ip6_pkt_drop().
> > 
> > Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
> > as the input device is the loopback interface.  Then, we have to check if
> > skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
> > for ip6_null_entry.
> > 
> ...
> 
> > Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
> > Reported-by: Wang Yufen <wangyufen@huawei.com>
> 
> > Closes: https://lore.kernel.org/netdev/1ddf7fc8-bcb3-ab48-4894-24158e8a9d0f@huawei.com/
> 
> This link seems not right.

Ah... exactly.
I'll fix it up in v3.
https://lore.kernel.org/netdev/c41403a9-c2f6-3b7e-0c96-e1901e605cd0@huawei.com/

Thanks!

--
pw-bot: cr

