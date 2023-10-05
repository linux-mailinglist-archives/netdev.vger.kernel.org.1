Return-Path: <netdev+bounces-38227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831197B9CF9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4C9D61C20929
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935A17F5;
	Thu,  5 Oct 2023 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFC1A26B
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:31:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADDA26A42;
	Thu,  5 Oct 2023 05:31:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qoNVT-0008M5-La; Thu, 05 Oct 2023 14:31:07 +0200
Date: Thu, 5 Oct 2023 14:31:07 +0200
From: Florian Westphal <fw@strlen.de>
To: xiaolinkui <xiaolinkui@126.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <20231005123107.GB9350@breakpoint.cc>
References: <20231005115022.12902-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005115022.12902-1-xiaolinkui@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xiaolinkui <xiaolinkui@126.com> wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Before destroying the ipset, take a check on sequence to ensure that the
> ip_set_test operation of this ipset has been completed.
> 
> The code of set_match_v4 is protected by addend=xt_write_recseq_begin() and
> xt_write_recseq_end(addend). So we can ensure that the test operation is
> completed by reading seqcount.

Nope, please don't do this, the xt_set can also be used from nft_compat
which doesn't use the xtables packet traversers.

I'd rather use synchonize_rcu() once in ip_set_destroy(), that will
make sure all concurrent traversers are gone.

That said, I still do not understand this fix, the
match / target destroy hooks are called after the table has
been completely replaced, i.e., while packets can still be in flight
no packets should be within the ipset lookup functions when
this happens, and no more packets should be able to enter them.

AFAICS the request to delete the set will fail if its still referenced
via any rule. xt_set holds references to the sets.

So:
1. set have dropped all references
2. userspace *can* delete the set
3. we get crash because xt_set was still within a sets eval
  function.

I don't see how 3) can happen, xt table replace isn't supposed
to call the xt_set destroy functions until after table replace.

We even release the entire x_table blob right afterwards.

