Return-Path: <netdev+bounces-16957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0774F948
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBBA2819A5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C41E504;
	Tue, 11 Jul 2023 20:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883071FCF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:46:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C973170C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3lB6Z3GmffaWNBmcR2tw3C1mtOECVCo5Iz9+OUD73tQ=; b=rl
	5O+BYEaBAWaKyqkjNHgZt93S1HTBMoaHzfg4d1R42oK1MBcYAswXOpyXgY3SYg9mqu0U2NM/OS8mg
	OhzKFufM5RPv4Lot1XEYIULd/r3eMSVcEaWoOJHWQIBGVV4qByD0TYWGqIuc2/dGAA914FMnlpo2o
	hE4SUz7552NP2vQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJKE0-0014Ws-6l; Tue, 11 Jul 2023 22:44:44 +0200
Date: Tue, 11 Jul 2023 22:44:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Harry Coin <hcoin@quietfountain.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Message-ID: <cacc74f8-5b40-4d89-a411-a6852ea60e7d@lunn.ch>
References: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
 <20230711183206.54744-1-kuniyu@amazon.com>
 <3dceb664-0dd5-d46b-2431-b235cbd7752f@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dceb664-0dd5-d46b-2431-b235cbd7752f@quietfountain.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > > > The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
> > > > > 
> > > > >           if (!net_eq(dev_net(dev), &init_net))
> > > > >                   goto drop;
> > > > > 

> Thank you!  When you offer your patches, and you hear worries about being
> 'invasive', it's worth asking 'compared to what' -- since the 'status quo' 
> is every bridge with STP in a non default namespace with a loop in it
> somewhere will freeze every connected system more solid than ice in
> Antarctica.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

say:

o It must be obviously correct and tested.
o It cannot be bigger than 100 lines, with context.
o It must fix only one thing.
o It must fix a real bug that bothers people (not a, "This could be a problem..." type thing).

git blame shows:

commit 721499e8931c5732202481ae24f2dfbf9910f129
Author: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date:   Sat Jul 19 22:34:43 2008 -0700

    netns: Use net_eq() to compare net-namespaces for optimization.

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 1c45f172991e..57ad974e4d94 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
        int (*rcv)(struct sk_buff *, struct net_device *,
                   struct packet_type *, struct net_device *);
 
-       if (dev_net(dev) != &init_net)
+       if (!net_eq(dev_net(dev), &init_net))
                goto drop;
 
        /*

So this is just an optimization.

The test itself was added in

ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Mon Sep 17 11:53:39 2007 -0700

    [NET]: Make packet reception network namespace safe
    
    This patch modifies every packet receive function
    registered with dev_add_pack() to drop packets if they
    are not from the initial network namespace.
    
    This should ensure that the various network stacks do
    not receive packets in a anything but the initial network
    namespace until the code has been converted and is ready
    for them.
    
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

So that was over 15 years ago.

It appears it has not bothered people for over 15 years.

Lets wait until we get to see the actual fix. We can then decide how
simple/hard it is to back port to stable, if it fulfils the stable
rules or not.

      Andrew

