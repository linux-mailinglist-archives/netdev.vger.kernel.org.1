Return-Path: <netdev+bounces-35924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F57ABC6E
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 01:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C1CD3B20A4C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E348E90;
	Fri, 22 Sep 2023 23:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E773E480
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 23:54:01 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB441A2;
	Fri, 22 Sep 2023 16:54:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qjpy3-00008b-FL; Sat, 23 Sep 2023 01:53:51 +0200
Date: Sat, 23 Sep 2023 01:53:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Madhu Koriginja <madhu.koriginja@nxp.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS
 handling
Message-ID: <20230922235351.GA22532@breakpoint.cc>
References: <20230922210530.2045146-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Maximets <i.maximets@ovn.org> wrote:
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
> 
> That leads to nf_conntrack module being impossible to unload as
> it waits for all the conntrack references to be dropped while
> the packet release is deferred in per-cpu cache indefinitely, if
> not consumed by the application.
> 
> The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
> missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
> check and correctly dropping the conntrack context.  However, the
> issue was introduced to IPv6 code afterwards.  Fixing it the
> same way for IPv6 now.
> 
> Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 policy checks are done")
> Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org/
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/ipv6/tcp_ipv6.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

LGTM, thanks for tracking this down.

Acked-by: Florian Westphal <fw@strlen.de>

