Return-Path: <netdev+bounces-33206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A165879D065
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7618D1C20CD8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0618031;
	Tue, 12 Sep 2023 11:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C229443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:53:03 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180510CE;
	Tue, 12 Sep 2023 04:53:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qg1wr-0004bL-Km; Tue, 12 Sep 2023 13:52:53 +0200
Date: Tue, 12 Sep 2023 13:52:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc: regressions@lists.linux.dev, fw@strlen.de, pablo@netfilter.org,
	kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in
 linux-stable
Message-ID: <20230912115253.GB13516@breakpoint.cc>
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info>
 <20230912102701.GA13516@breakpoint.cc>
 <20230912114729.EFBC26320998@dd20004.kasserver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912114729.EFBC26320998@dd20004.kasserver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Timo Sigurdsson <public_timo.s@silentcreek.de> wrote:
> > Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
> > wrote:
> >> On 12.09.23 00:57, Pablo Neira Ayuso wrote:
> >> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
> >> > kernel check that rejects adding rules to bound chains. The incorrect
> >> > bytecode adds the chain binding, attach it to the rule and it adds the
> >> > rules to the chain binding. I have cherry-picked these three patches
> >> > for nftables v1.0.6 userspace and your ruleset restores fine.
> >> > [...]
> >> 
> >> Hmmmm. Well, this sounds like a kernel regression to me that normally
> >> should be dealt with on the kernel level, as users after updating the
> >> kernel should never have to update any userspace stuff to continue what
> >> they have been doing before the kernel update.
> > 
> > This is a combo of a userspace bug and this new sanity check that
> > rejects the incorrect ordering (adding rules to the already-bound
> > anonymous chain).
> > 
> 
> Out of curiosity, did the incorrect ordering or bytecode from the older userspace components actually lead to a wrong representation of the rules in the kernel or did the rules still work despite all that?

It works, but without the stricter behaviour userspace can trigger
memory corruption in the kernel. nftables userland will not trigger this.

