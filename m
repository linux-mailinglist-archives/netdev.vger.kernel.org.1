Return-Path: <netdev+bounces-37481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2B7B58A2
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AA0241C20860
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A11DDE0;
	Mon,  2 Oct 2023 17:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB91A73C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:11:55 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE016AB;
	Mon,  2 Oct 2023 10:11:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qnMSQ-00039e-DV; Mon, 02 Oct 2023 19:11:46 +0200
Date: Mon, 2 Oct 2023 19:11:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Yan Zhai <yan@cloudflare.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
Message-ID: <20231002171146.GB9274@breakpoint.cc>
References: <ZRcOXJ0pkuph6fko@debian.debian>
 <20230930110854.GA13787@breakpoint.cc>
 <CAO3-Pbp2onn+EUhKRrB5an_tyzLcaH+1FUqrThsxXqqpBAxshA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pbp2onn+EUhKRrB5an_tyzLcaH+1FUqrThsxXqqpBAxshA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Yan Zhai <yan@cloudflare.com> wrote:
> On Sat, Sep 30, 2023 at 6:09 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > This helper is also called for skbs where IP6CB(skb)->frag_max_size
> > exceeds the MTU, so this check looks wrong to me.
> >
> > Same remark for dst_allfrag() check in __ip6_finish_output(),
> > after this patch, it would be ignored.
> >
> Thanks for covering my carelessness. I was just considering the GSO
> case so frag_max_size was overlooked. dst_allfrag is indeed a case
> based on the code logic. But just out of curiosity, do we still see
> any use of this feature? From commit messages it is set when PMTU
> values signals smaller than min IPv6 MTU. But such PMTU values are
> just dropped in __ip6_rt_update_pmtu now. Iproute2 code also does not
> provide this route feature anymore. So it might be actually a dead
> check?

I don't think iproute2 ever exposed it, I think we can axe
dst_allfrag().

> > I think you should consider to first refactor __ip6_finish_output to make
> > the existing checks more readable (e.g. handle gso vs. non-gso in separate
> > branches) and then add the check to last seg in
> > ip6_finish_output_gso_slowpath_drop().
> >
> Agree with refactoring to mirror what IPv4 code is doing. It might not
> hurt if we check every segments in this case, since it is already the
> slowpath and it will make code more compact.

No objections from my side.

