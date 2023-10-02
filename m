Return-Path: <netdev+bounces-37357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22A7B4EE3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 7E9B5B20B35
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1FC2E3;
	Mon,  2 Oct 2023 09:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD168F40
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 09:20:21 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0325B99;
	Mon,  2 Oct 2023 02:20:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qnF62-000861-Nl; Mon, 02 Oct 2023 11:20:10 +0200
Date: Mon, 2 Oct 2023 11:20:10 +0200
From: Florian Westphal <fw@strlen.de>
To: Henrik =?iso-8859-15?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation, causing MTU problems for
 virtual machines
Message-ID: <20231002092010.GA30843@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Henrik Lindström <lindstrom515@gmail.com> wrote:
> I found this old thread describing why macvlan does this:
> https://lore.kernel.org/netdev/4E8C89EE.3090600@candelatech.com/
> Interestingly, the problem described in that thread seems to be more
> general than macvlans, and i can still reproduce it by simply having
> multiple physical interfaces.
> So it looks like macvlans are being special-cased right now, as a
> workaround for a more general defragmentation problem?

Looks like it, maybe Eric remembers details here.

AFAIU however this issue isn't specific to macvlan, looks like some people
insist that receiving a fragmented multicast packet on n devices means we
should pass n defragmented packets up to the stack (we don't; ip defrag
will discard "duplicates").

There is a vif identifier for l3mdev sake (that did not exist back then),
we could use that as a discriminator for mcast case.

Something like this (totally untested):

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -479,11 +479,29 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 	return err;
 }
 
+static int ip_defrag_vif(const struct sk_buff *skb, const struct net_device *dev)
+{
+	int vif = l3mdev_master_ifindex_rcu(dev);
+
+	if (vif)
+		return vif;
+
+	/* some folks insist that receiving a fragmented mcast dgram on n devices shall
+	 * result in n defragmented packets.
+	 */
+	if (skb->pkt_type == PACKET_BROADCAST || skb->pkt_type == PACKET_MULTICAST) {
+		if (dev)
+			vif = dev->ifindex;
+	}
+
+	return 0;
+}
+
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
 	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
-	int vif = l3mdev_master_ifindex_rcu(dev);
+	int vif = ip_defrag_vif(skb, dev);
 	struct ipq *qp;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);

... which should allow to remove the macvlan defrag step.

