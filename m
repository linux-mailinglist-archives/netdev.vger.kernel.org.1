Return-Path: <netdev+bounces-33204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF24279D053
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A3E1C20D1D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B118030;
	Tue, 12 Sep 2023 11:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515416400
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:47:32 +0000 (UTC)
Received: from dd20004.kasserver.com (dd20004.kasserver.com [85.13.150.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3410D2;
	Tue, 12 Sep 2023 04:47:31 -0700 (PDT)
Received: from dd20004.kasserver.com (dd0804.kasserver.com [85.13.146.35])
	by dd20004.kasserver.com (Postfix) with ESMTPSA id EFBC26320998;
	Tue, 12 Sep 2023 13:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
	s=kas202306171005; t=1694519249;
	bh=Ujehp2CrxYPoXuYDlpiKj4du5N6E27baKTbPSJgLyDs=;
	h=Subject:To:References:Cc:From:In-Reply-To:Date:From;
	b=I50aEkjTO1YDotnc2qFwZ9CM00zhMymhQh3v4UbI4IYSBll47/qoTqM/SeUk6M9kg
	 AbwEoHlZdvCtVcGCL2HQ6KynlRlJOYxepjA24K2qDw86hU3EiJEutMf9BijDSBYI7j
	 R9PLEc9w1P3ROpifpDr/yIIV42BiRzNTNqm8gfqtXzKkiIFAJdNNyZiEtOetb9/xHc
	 SGOJVXn4sN1HuKEk2hGRDjZLOWxHrtnGNCPtFK/m0/deZkrcqdUYcf4TPA5zGQPdmi
	 FjIAP1CW+ypnSQ7De1ONtmJHEZEl37x3gmKkeMn4hYhC0/e70G1X6yGg/EVxJngFLT
	 g1v5SqsU/WWVw==
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
To: regressions@lists.linux.dev, fw@strlen.de
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info><20230912102701.GA13516@breakpoint.cc>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, sashal@kernel.org, carnil@debian.org,
 1051592@bugs.debian.org
From: "Timo Sigurdsson" <public_timo.s@silentcreek.de>
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 89.246.188.214
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230912102701.GA13516@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230912114729.EFBC26320998@dd20004.kasserver.com>
Date: Tue, 12 Sep 2023 13:47:29 +0200 (CEST)
X-Spamd-Bar: /

Hi,

Florian Westphal schrieb am 12.09.2023 12:27 (GMT +02:00):

> Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
> wrote:
>> On 12.09.23 00:57, Pablo Neira Ayuso wrote:
>> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
>> > kernel check that rejects adding rules to bound chains. The incorrect
>> > bytecode adds the chain binding, attach it to the rule and it adds the
>> > rules to the chain binding. I have cherry-picked these three patches
>> > for nftables v1.0.6 userspace and your ruleset restores fine.
>> > [...]
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

Out of curiosity, did the incorrect ordering or bytecode from the older userspace components actually lead to a wrong representation of the rules in the kernel or did the rules still work despite all that?

Thanks,

Timo 

