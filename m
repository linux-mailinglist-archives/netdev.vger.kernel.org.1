Return-Path: <netdev+bounces-33207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A114E79D07D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278DC281C4E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B618038;
	Tue, 12 Sep 2023 11:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5818032
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:58:29 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655E1717;
	Tue, 12 Sep 2023 04:58:27 -0700 (PDT)
Received: from [46.6.227.206] (port=6296 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qg224-00CtNF-Px; Tue, 12 Sep 2023 13:58:23 +0200
Date: Tue, 12 Sep 2023 13:58:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc: kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in
 linux-stable
Message-ID: <ZQBSVTCxyi+zH9qG@calendula>
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <20230912113959.8F8B26321005@dd20004.kasserver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912113959.8F8B26321005@dd20004.kasserver.com>
X-Spam-Score: -1.9 (-)

On Tue, Sep 12, 2023 at 01:39:59PM +0200, Timo Sigurdsson wrote:
> Hi Pablo,
> 
> Pablo Neira Ayuso schrieb am 12.09.2023 00:57 (GMT +02:00):
> 
> > Hi Timo,
> > 
> > On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
> >> Hi,
> >> 
> >> recently, Debian updated their stable kernel from 6.1.38 to 6.1.52
> >> which broke nftables ruleset loading on one of my machines with lots
> >> of "Operation not supported" errors. I've reported this to the
> >> Debian project (see link below) and Salvatore Bonaccorso and I
> >> identified "netfilter: nf_tables: disallow rule addition to bound
> >> chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit
> >> that introduced the regression. Salvatore also found that this issue
> >> affects the 5.10 stable tree as well (observed in 5.10.191), but he
> >> cannot reproduce it on 6.4.13 and 6.5.2.
> >> 
> >> The issue only occurs with some rulesets. While I can't trigger it
> >> with simple/minimal rulesets that I use on some machines, it does
> >> occur with a more complex ruleset that has been in use for months
> >> (if not years, for large parts of it). I'm attaching a somewhat
> >> stripped down version of the ruleset from the machine I originally
> >> observed this issue on. It's still not a small or simple ruleset,
> >> but I'll try to reduce it further when I have more time.
> >> 
> >> The error messages shown when trying to load the ruleset don't seem
> >> to be helpful. Just two simple examples: Just to give two simple
> >> examples from the log when nftables fails to start:
> >> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not
> >> supported
> >>                         tcp option maxseg size 1-500 counter drop
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not
> >> supported
> >>                         tcp dport sip-tls accept
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > I can reproduce this issue with 5.10.191 and 6.1.52 and nftables v1.0.6,
> > this is not reproducible with v1.0.7 and v1.0.8.
> > 
> >> Since the issue only affects some stable trees, Salvatore thought it
> >> might be an incomplete backport that causes this.
> >> 
> >> If you need further information, please let me know.
> > 
> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
> > kernel check that rejects adding rules to bound chains. The incorrect
> > bytecode adds the chain binding, attach it to the rule and it adds the
> > rules to the chain binding. I have cherry-picked these three patches
> > for nftables v1.0.6 userspace and your ruleset restores fine.
> 
> hmm, that doesn't explain why Salvatore didn't observe this with
> more recent kernels.
>
> Salvatore, did you use newer userspace components when you tested
> your 6.4.13 and 6.5.2 builds?
> 
> As for the regression and how it be dealt with: Personally, I don't
> really care whether the regression is solved in the kernel or
> userspace. If everybody agrees that this is the best or only viable
> option and Debian decides to push a nftables update to fix this,
> that works for me. But I do feel the burden to justify this should
> be high. A kernel change that leaves users without a working packet
> filter after upgrading their machines is serious, if you ask me. And
> since it affects several stable/longterm trees, I would assume this
> will hit other stable (non-rolling) distributions as well, since
> they will also use older userspace components (unless this is
> behavior specific to nftables 1.0.6 but not older versions). They
> probably should get a heads up then.

There is coverage for the chain binding feature in our tests
infrastructure, but unfortunately the bug did not trigger with newer
nftables versions. In the future, I will keep an eye with running our
tests on older userspace nftables versions when working on stable
trees.

