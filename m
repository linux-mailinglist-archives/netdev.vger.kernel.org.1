Return-Path: <netdev+bounces-18813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0C758B92
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818611C20922
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359317D1;
	Wed, 19 Jul 2023 02:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4A17C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:53:44 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3C1BC9;
	Tue, 18 Jul 2023 19:53:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qLxJb-00043q-Tk; Wed, 19 Jul 2023 04:53:23 +0200
Date: Wed, 19 Jul 2023 04:53:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 1/2] netlink: allow be16 and be32 types in all
 uint policy checks
Message-ID: <20230719025323.GA27896@breakpoint.cc>
References: <20230718075234.3863-1-fw@strlen.de>
 <20230718075234.3863-2-fw@strlen.de>
 <20230718115633.3a15062d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718115633.3a15062d@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jul 2023 09:52:29 +0200 Florian Westphal wrote:
> > __NLA_IS_BEINT_TYPE(tp) isn't useful.  NLA_BE16/32 are identical to
> > NLA_U16/32, the only difference is that it tells the netlink validation
> > functions that byteorder conversion might be needed before comparing
> > the value to the policy min/max ones.
> > 
> > After this change all policy macros that can be used with UINT types,
> > such as NLA_POLICY_MASK() can also be used with NLA_BE16/32.
> > 
> > This will be used to validate nf_tables flag attributes which
> > are in bigendian byte order.
> 
> Semi-related, how well do we do with NLA_F_NET_BYTEORDER?

Looks incomplete at best.

> On a quick grep we were using it in the kernel -> user
> direction but not validating on input. Is that right?

Looks like ipset is the only user, it sets it for kernel->user
dir.

I see ipset userspace even sets it on user -> kernel dir but
like you say, its not checked and BE encoding is assumed on
kernel side.

From a quick glance in ipset all Uxx types are always treated as
bigendian, which would mean things should not fall apart if ipset
stops announcing NLA_F_NET_BYTEORDER.  Not sure its worth risking
any breakage though.

I suspect that in practice, given both producer and consumer need
to agree of the meaning of type "12345" anyway its easier to just
agree on the byte ordering as well.

Was there a specific reason for the question?

