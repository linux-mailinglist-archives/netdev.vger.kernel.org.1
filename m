Return-Path: <netdev+bounces-24119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4276ED77
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0321C215FC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5B200CC;
	Thu,  3 Aug 2023 15:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1891ED48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:02:50 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E07128
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:02:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qRZqN-0005rt-Jm; Thu, 03 Aug 2023 17:02:27 +0200
Date: Thu, 3 Aug 2023 17:02:27 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] tcp: Enable header prediction for active open
 connections with MD5.
Message-ID: <20230803150227.GE30550@breakpoint.cc>
References: <20230803042214.38309-1-kuniyu@amazon.com>
 <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
 <58f719e442b92a37eb764685bf3d5c3cbae627f3.camel@redhat.com>
 <CANn89i+OR9fDEN6w385KP1ZSO4qjcU7TAbO7p0jiKnqjKAH+bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+OR9fDEN6w385KP1ZSO4qjcU7TAbO7p0jiKnqjKAH+bg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Aug 3, 2023 at 8:59 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On Thu, 2023-08-03 at 08:44 +0200, Eric Dumazet wrote:
> > > I do not think we want to slow down fast path (no MD5), for 'header
> > > prediction' of MD5 flows,
> > > considering how slow MD5 is anyway (no GSO/GRO), and add yet another
> > > ugly #ifdef CONFIG_TCP_MD5SIG
> > > in already convoluted code base.
> >
> > Somewhat related, do you know how much header prediction makes a
> > difference for plain TCP? IIRC quite some time ago there was the idea
> > to remove header prediction completely to simplify the code overall -
> > then reverted because indeed caused regression in RR test-case. Do you
> > know if that is still true? would it make sense to re-evaluate that
> > thing (HP removal) again?
> >
> 
> I think Florian did this, he might recall the details.

Memory is hazy here, 31770e34e43d ("tcp: Revert "tcp: remove header prediction"")
has some clues.

One would need to refactor tcp_ack so that all the extra accesses are
only done if the packet matches expected next sequence without advancing
the window.  Not sure its worth doing, one would start to add tcp header
prediction v2, with little or no significant LOC savings.

