Return-Path: <netdev+bounces-37013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E787B31B1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 312F1282BA1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E1182A9;
	Fri, 29 Sep 2023 11:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638111864
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:46:39 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28B1B4;
	Fri, 29 Sep 2023 04:46:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qmBx0-00054T-AZ; Fri, 29 Sep 2023 13:46:30 +0200
Message-ID: <89dded30-d250-4b7a-b5a8-b18e3b509bf1@leemhuis.info>
Date: Fri, 29 Sep 2023 13:46:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
Content-Language: en-US, de-DE
To: Florian Westphal <fw@strlen.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Timo Sigurdsson <public_timo.s@silentcreek.de>, kadlec@netfilter.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, sashal@kernel.org, carnil@debian.org,
 1051592@bugs.debian.org
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info>
 <20230912102701.GA13516@breakpoint.cc>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230912102701.GA13516@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695987996;3a87d281;
X-HE-SMSGID: 1qmBx0-00054T-AZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12.09.23 12:27, Florian Westphal wrote:
> Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>> On 12.09.23 00:57, Pablo Neira Ayuso wrote:
>>> Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
>>> kernel check that rejects adding rules to bound chains. The incorrect
>>> bytecode adds the chain binding, attach it to the rule and it adds the
>>> rules to the chain binding. I have cherry-picked these three patches
>>> for nftables v1.0.6 userspace and your ruleset restores fine.
>>> [...]
>>
>> Hmmmm. Well, this sounds like a kernel regression to me that normally
>> should be dealt with on the kernel level, as users after updating the
>> kernel should never have to update any userspace stuff to continue what
>> they have been doing before the kernel update.
> 
> This is a combo of a userspace bug and this new sanity check that
> rejects the incorrect ordering (adding rules to the already-bound
> anonymous chain).
> 
> nf_tables uses a transaction allor-nothing model, this means that any
> error that occurs during a transaction has to be reverse/undo all the
> pending changes.  This has caused a myriad of bugs already.
> 
> So while this can be theoretically fixed in the kernel I don't see
> a sane way to do it.  Error unwinding / recovery from deeply nested
> errors is already too complex for my taste.
> 
>> Can't the kernel somehow detect the incorrect bytecode and do the right
>> thing(tm) somehow?
> 
> Theoretically yes, but I don't feel competent enough to do it, just look
> at all the UaF bugs of the past month.

Thx for the answer. FWIW, as this was a judgement call I mentioned this
in my last regression report to Linus; he didn't reply, so I guess it is
-- and will remove this issue from my tracking:

#regzbot resolve: can be solved by a nftables userspace update; not
nice, but likely best solution in this case
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

