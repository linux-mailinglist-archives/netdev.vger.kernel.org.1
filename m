Return-Path: <netdev+bounces-17177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2442750B87
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C624281771
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F634CE9;
	Wed, 12 Jul 2023 14:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BA34CC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:58:20 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F71BD6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689173896; x=1720709896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcW5kz8PrZMlxYxJAbQQUtUE+T2XGM7/jXVNUV8g9aM=;
  b=elnwPhnJsBoCvG4+uUI1zozAOGSuZBEEbjnjg2GbB45US2taD0Tkgkhy
   4sahtDzL3IsssS5o5xZccxgDHMSMDTQyAbXF1Hz/itzwZdveor1b6nKtn
   v+cEctY3nkKSPp9EvQX/9dTCGlBPLszGB8hkFhFWK5Sg223PSszsCzlFF
   s=;
X-IronPort-AV: E=Sophos;i="6.01,199,1684800000"; 
   d="scan'208";a="15918877"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 14:58:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 19BB040DAA;
	Wed, 12 Jul 2023 14:58:14 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 14:58:13 +0000
Received: from 88665a182662.ant.amazon.com (10.119.181.74) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 12 Jul 2023 14:58:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <idosch@idosch.org>
CC: <bridge@lists.linux-foundation.org>, <davem@davemloft.net>,
	<ebiederm@xmission.com>, <edumazet@google.com>, <hcoin@quietfountain.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<roopa@nvidia.com>
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in netns.
Date: Wed, 12 Jul 2023 07:58:02 -0700
Message-ID: <20230712145802.726-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZK69NDM60+N0TTFh@shredder>
References: <ZK69NDM60+N0TTFh@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.181.74]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 12 Jul 2023 17:48:20 +0300
> On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
> > When we create an L2 loop on a bridge in netns, we will see packets storm
> > even if STP is enabled.
> > 
> >   # unshare -n
> >   # ip link add br0 type bridge
> >   # ip link add veth0 type veth peer name veth1
> >   # ip link set veth0 master br0 up
> >   # ip link set veth1 master br0 up
> >   # ip link set br0 type bridge stp_state 1
> >   # ip link set br0 up
> >   # sleep 30
> >   # ip -s link show br0
> >   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> >       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
> >       RX: bytes  packets  errors  dropped missed  mcast
> >       956553768  12861249 0       0       0       12861249  <-. Keep
> >       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
> >       1027834    11951    0       0       0       0         <-'   rapidly
> > 
> > This is because llc_rcv() drops all packets in non-root netns and BPDU
> > is dropped.
> > 
> > Let's show an error when enabling STP in netns.
> > 
> >   # unshare -n
> >   # ip link add br0 type bridge
> >   # ip link set br0 type bridge stp_state 1
> >   Error: bridge: STP can't be enabled in non-root netns.
> > 
> > Note this commit will be reverted later when we namespacify the whole LLC
> > infra.
> > 
> > Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> > Suggested-by: Harry Coin <hcoin@quietfountain.com>
> 
> I'm not sure that's accurate. I read his response in the link below and
> he says "I'd rather be warned than blocked" and "But better warned and
> awaiting a fix than blocked", which I agree with. The patch has the
> potential to cause a lot of regressions, but without actually fixing the
> problem.
> 
> How about simply removing the error [1]? Since iproute2 commit
> 844c37b42373 ("libnetlink: Handle extack messages for non-error case"),
> it can print extack warnings and not only errors. With the diff below:

This is good to know and I also prefer this approach!
I'll post v2.

Thanks!


> 
>  # unshare -n 
>  # ip link add name br0 type bridge
>  # ip link set dev br0 type bridge stp_state 1
>  Warning: bridge: STP can't be enabled in non-root netns.
>  # echo $?
>  0
> 
> [1]
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index a807996ac56b..b5143de37938 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>         ASSERT_RTNL();
>  
> -       if (!net_eq(dev_net(br->dev), &init_net)) {
> +       if (!net_eq(dev_net(br->dev), &init_net))
>                 NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> -               return -EINVAL;
> -       }
>  
>         if (br_mrp_enabled(br)) {
>                 NL_SET_ERR_MSG_MOD(extack,
> 
> > Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/bridge/br_stp_if.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> > index 75204d36d7f9..a807996ac56b 100644
> > --- a/net/bridge/br_stp_if.c
> > +++ b/net/bridge/br_stp_if.c
> > @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> >  {
> >  	ASSERT_RTNL();
> >  
> > +	if (!net_eq(dev_net(br->dev), &init_net)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (br_mrp_enabled(br)) {
> >  		NL_SET_ERR_MSG_MOD(extack,
> >  				   "STP can't be enabled if MRP is already enabled");
> > -- 
> > 2.30.2

