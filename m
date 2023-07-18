Return-Path: <netdev+bounces-18650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B71758365
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37AE1C20CAE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C214A97;
	Tue, 18 Jul 2023 17:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CBF9F7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:25:15 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730CBE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689701115; x=1721237115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZXCXD/LGxFk48Xt5ol5Q3iTg9guWb2zWzjLUQOoe4o=;
  b=A9DcJNzfyWaVNeCDHyXoFk7yTDm4HhYdcLTNhOWhk504d+0UI7Tup7xu
   qozcsgj8gFMzt5u53xo4zi8JjAOgkFY1YEGZ4efuSR9DYUNdfvEdr4bua
   4QpsSTGmim9Hog1TrMbFsH6zvuucsy8npN+OjYvv8a/gXZJKRQVYdwhON
   4=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="296070721"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:25:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 5893766F1C;
	Tue, 18 Jul 2023 17:25:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:25:03 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 18 Jul 2023 17:25:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<hcoin@quietfountain.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <razor@blackwall.org>,
	<roopa@nvidia.com>
Subject: Re: [PATCH v1 net 1/4] llc: Check netns in llc_dgram_match().
Date: Tue, 18 Jul 2023 10:24:51 -0700
Message-ID: <20230718172451.54487-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e7def8ab99c2a27176e0861117efbe4797c908eb.camel@redhat.com>
References: <e7def8ab99c2a27176e0861117efbe4797c908eb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Jul 2023 12:34:47 +0200
> Hi,
> 
> the series LGTM, I have only a couple of (very) minor nit, see below...
> 
> On Fri, 2023-07-14 at 19:13 -0700, Kuniyuki Iwashima wrote:
> > We will remove this restriction in llc_rcv() in the following patch,
> 
> s/following patch/soon/, as the following patch will not do that ;)

Exactly, will fix :)


> 
> > which means that the protocol handler must be aware of netns.
> > 
> > 	if (!net_eq(dev_net(dev), &init_net))
> > 		goto drop;
> > 
> > llc_rcv() fetches llc_type_handlers[llc_pdu_type(skb) - 1] and calls it
> > if not NULL.
> > 
> > If the PDU type is LLC_DEST_SAP, llc_sap_handler() is called to pass skb
> > to corresponding sockets.  Then, we must look up a proper socket in the
> > same netns with skb->dev.
> > 
> > If the destination is a multicast address, llc_sap_handler() calls
> > llc_sap_mcast().  It calculates a hash based on DSAP and skb->dev->ifindex,
> > iterates on a socket list, and calls llc_mcast_match() to check if the
> > socket is the correct destination.  Then, llc_mcast_match() checks if
> > skb->dev matches with llc_sk(sk)->dev.  So, we need not check netns here.
> > 
> > OTOH, if the destination is a unicast address, llc_sap_handler() calls
> > llc_lookup_dgram() to look up a socket, but it does not check the netns.
> > 
> > Therefore, we need to add netns check in llc_lookup_dgram().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/llc/llc_sap.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
> > index 6805ce43a055..5c83fca3acd5 100644
> > --- a/net/llc/llc_sap.c
> > +++ b/net/llc/llc_sap.c
> > @@ -294,13 +294,15 @@ static void llc_sap_rcv(struct llc_sap *sap, struct sk_buff *skb,
> >  
> >  static inline bool llc_dgram_match(const struct llc_sap *sap,
> >  				   const struct llc_addr *laddr,
> > -				   const struct sock *sk)
> > +				   const struct sock *sk,
> > +				   const struct net *net)
> >  {
> >       struct llc_sock *llc = llc_sk(sk);
> >  
> >       return sk->sk_type == SOCK_DGRAM &&
> > -	  llc->laddr.lsap == laddr->lsap &&
> > -	  ether_addr_equal(llc->laddr.mac, laddr->mac);
> > +	     net_eq(sock_net(sk), net) &&
> > +	     llc->laddr.lsap == laddr->lsap &&
> > +	     ether_addr_equal(llc->laddr.mac, laddr->mac);
> >  }
> >  
> >  /**
> > @@ -312,7 +314,8 @@ static inline bool llc_dgram_match(const struct llc_sap *sap,
> >   *	mac, and local sap. Returns pointer for socket found, %NULL otherwise.
> >   */
> 
> As this function has doxygen documentation, you should additionally
> document the 'net' argument.

And will fix this and the same miss in patch 2.

Thanks for catching this!


> 
> Thanks,
> 
> Paolo

