Return-Path: <netdev+bounces-19096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE015759A84
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8041E28154E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8C3D3AE;
	Wed, 19 Jul 2023 16:12:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6F11C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:12:58 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067171739
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:12:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qM9n6-0000em-OH; Wed, 19 Jul 2023 18:12:40 +0200
Date: Wed, 19 Jul 2023 18:12:40 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Xin Long <lucien.xin@gmail.com>,
	network dev <netdev@vger.kernel.org>, dev@openvswitch.org,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: handle the exp removal problem with
 ovs upcall properly
Message-ID: <20230719161240.GB32192@breakpoint.cc>
References: <cover.1689541664.git.lucien.xin@gmail.com>
 <20230718195827.4c1db980@kernel.org>
 <20230719030131.GA15663@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719030131.GA15663@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florian Westphal <fw@strlen.de> wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Sun, 16 Jul 2023 17:09:16 -0400 Xin Long wrote:
> > > With the OVS upcall, the original ct in the skb will be dropped, and when
> > > the skb comes back from userspace it has to create a new ct again through
> > > nf_conntrack_in() in either OVS __ovs_ct_lookup() or TC tcf_ct_act().
> > > 
> > > However, the new ct will not be able to have the exp as the original ct
> > > has taken it away from the hash table in nf_ct_find_expectation(). This
> > > will cause some flow never to be matched, like:
> > > 
> > >   'ip,ct_state=-trk,in_port=1 actions=ct(zone=1)'
> > >   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=1)'
> > >   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=2),normal'
> > > 
> > > if the 2nd flow triggers the OVS upcall, the 3rd flow will never get
> > > matched.
> > > 
> > > OVS conntrack works around this by adding its own exp lookup function to
> > > not remove the exp from the hash table and saving the exp and its master
> > > info to the flow keys instead of create a real ct. But this way doesn't
> > > work for TC act_ct.
> > > 
> > > The patch 1/3 allows nf_ct_find_expectation() not to remove the exp from
> > > the hash table if tmpl is set with IPS_CONFIRMED when doing lookup. This
> > > allows both OVS conntrack and TC act_ct to have a simple and clear fix
> > > for this problem in the patch 2/3 and 3/3.
> > 
> > Florian, Pablo, any opinion on these?
> 
> Sorry for the silence.  I dislike moving tc/ovs artifacts into
> the conntrack core.

Can't find a better solution, feel free to take this though the net-next tree.

Acked-by: Florian Westphal <fw@strlen.de>

