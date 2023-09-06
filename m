Return-Path: <netdev+bounces-32219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DAC7939E6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F455281416
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F081ECB;
	Wed,  6 Sep 2023 10:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803176AB7
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:30:32 +0000 (UTC)
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B211734
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:30:27 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 24CA0184CB;
	Wed,  6 Sep 2023 13:30:24 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 0C9651870B;
	Wed,  6 Sep 2023 13:30:24 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 23F2E3C0439;
	Wed,  6 Sep 2023 13:30:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1693996221; bh=ebVU1+X+mNAiSt1BbY6BxCt/GOLxee8r0cQHhUmYg78=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=IpvLD8LdV2GnU8DTI61Pyx1uzQU+x0THk1NQQ+fCy50HFjWoXFtyZ8NjPjn3J5tss
	 HGOZaisSxPdKVKVe9zKS4Vz9jQ4b11P9MwyYRwyT6FKlwMk0if+Oje8tVnlIWSI6OL
	 9h7EM4Hvz1+y96S+NZVe0ljcv/qHsvSKbPBTOa9g=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 386AUI19046421;
	Wed, 6 Sep 2023 13:30:19 +0300
Date: Wed, 6 Sep 2023 13:30:18 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: "liujian (CE)" <liujian56@huawei.com>
cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hadi@cyberus.ca,
        netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ipv4: fix one memleak in __inet_del_ifa()
In-Reply-To: <cbe579bd-4aff-8239-0e32-6acb79b11bca@huawei.com>
Message-ID: <734181f9-b340-daa2-0772-7ed220eee150@ssi.bg>
References: <20230905135554.1958156-1-liujian56@huawei.com> <bcb0e791-37ab-3fff-9da6-a86883924205@ssi.bg> <cbe579bd-4aff-8239-0e32-6acb79b11bca@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


	Hello,

On Wed, 6 Sep 2023, liujian (CE) wrote:

> On 2023/9/6 1:20, Julian Anastasov wrote:
> > 
> > On Tue, 5 Sep 2023, Liu Jian wrote:
> > 
> >> I got the below warning when do fuzzing test:
> >> unregister_netdevice: waiting for bond0 to become free. Usage count = 2
> >>
> >> It can be repoduced via:
> >>
> >> ip link add bond0 type bond
> >> sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
> >> ip addr add 4.117.174.103/0 scope 0x40 dev bond0
> >> ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
> >> ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
> >> ip addr del 4.117.174.103/0 scope 0x40 dev bond0
> >> ip link delete bond0 type bond
> >>
> >> In this reproduction test case, an incorrect 'last_prim' is found in
> >> __inet_del_ifa(), as a result, the secondary address(0.0.0.4/0 scope 0x40)
> >> is lost. The memory of the secondary address is leaked and the reference of
> >> in_device and net_device is leaked.

	We can also explain that the problem occurs when we delete
the first primary address and the promoted address is leaked because
it is attached to the to-be-freed primary address instead of to ifa_list.

> >> Fix this problem by modifying the PROMOTE_SECONDANCE behavior as follows:
> >> 1. Traverse in_dev->ifa_list to search for the actual 'last_prim'.
> >> 2. When last_prim is empty, move 'promote' to the in_dev->ifa_list header.
> > 
> > 	So, the problem is that last_prim initially points to the
> > first primary address that we are actually removing. Looks like with
> > last_prim we try to promote the secondary IP after all primaries with
> > scope >= our scope, i.e. simulating a new IP insert. As the secondary IPs
> > have same scope as their primary, why just not remove the last_prim
> > var/code and to insert the promoted secondary at the same place as the
> > deleted primary? May be your patch does the same: insert at same pos?
> > 
> > Before deletion:
> > 1. primary1 scope global (to be deleted)
> > 2. primary2 scope global
> > 3. promoted_secondary
> > 
> > After deletion (old way, promote as a new insertion):
> > 1. primary2 scope global
> > 2. promoted_secondary scope global (inserted as new primary)
> > 
> It is :
> After deletion (old way, promoted_secondary lost):
> 1. primary2 scope global

	Yes, that is what happens :)

> > After deletion (new way, promote at same place):
> > 1. promoted_secondary scope global (now primary, inserted at same place)
> > 2. primary2 scope global
> > 
> >  What I mean is to use ifap as last_prim, not tested:
> > 
> Yes, This is better and it can work also. Thanks.
> Tested-by: Liu Jian <liujian56@huawei.com>

	But let me propose another version. It is a minimal
bugfix that does not change the place where the promoted address
is added and just converts last_prim to be rcu ptr to insert
position. last_prim will start from ifap because the promoted
address can not be added before this position. It is better
not to reorder the IPs because scripts may depend on the
old behavior to add the promoted IP after all others for
the scope. If you find this version better you can post it
as v2 and I'll sign it too.

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..37be82496322 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -355,14 +355,14 @@ static void __inet_del_ifa(struct in_device *in_dev,
 {
 	struct in_ifaddr *promote = NULL;
 	struct in_ifaddr *ifa, *ifa1;
-	struct in_ifaddr *last_prim;
+	struct in_ifaddr __rcu **last_prim;
 	struct in_ifaddr *prev_prom = NULL;
 	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
 
 	ASSERT_RTNL();
 
 	ifa1 = rtnl_dereference(*ifap);
-	last_prim = rtnl_dereference(in_dev->ifa_list);
+	last_prim = ifap;
 	if (in_dev->dead)
 		goto no_promotions;
 
@@ -376,7 +376,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
 		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
 			    ifa1->ifa_scope <= ifa->ifa_scope)
-				last_prim = ifa;
+				last_prim = &ifa->ifa_next;
 
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
 			    ifa1->ifa_mask != ifa->ifa_mask ||
@@ -440,9 +440,9 @@ static void __inet_del_ifa(struct in_device *in_dev,
 
 			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
 
-			last_sec = rtnl_dereference(last_prim->ifa_next);
+			last_sec = rtnl_dereference(*last_prim);
 			rcu_assign_pointer(promote->ifa_next, last_sec);
-			rcu_assign_pointer(last_prim->ifa_next, promote);
+			rcu_assign_pointer(*last_prim, promote);
 		}
 
 		promote->ifa_flags &= ~IFA_F_SECONDARY;

Regards

--
Julian Anastasov <ja@ssi.bg>


