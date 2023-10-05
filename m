Return-Path: <netdev+bounces-38302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2DF7BA1E2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2C852281BCE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11082E62B;
	Thu,  5 Oct 2023 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE832E625
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:02:12 +0000 (UTC)
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 08:02:08 PDT
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEA21D00;
	Thu,  5 Oct 2023 08:02:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 16261CC02C3;
	Thu,  5 Oct 2023 16:50:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Thu,  5 Oct 2023 16:50:43 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 52ACACC02C0;
	Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 096853431A9; Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 076443431A8;
	Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Date: Thu, 5 Oct 2023 16:50:42 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: Florian Westphal <fw@strlen.de>
cc: xiaolinkui <xiaolinkui@126.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
    David Miller <davem@davemloft.net>, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com, 
    netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
In-Reply-To: <20231005123107.GB9350@breakpoint.cc>
Message-ID: <2c9efd36-f1f6-b77b-d4eb-f65932cfaba@netfilter.org>
References: <20231005115022.12902-1-xiaolinkui@126.com> <20231005123107.GB9350@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 5 Oct 2023, Florian Westphal wrote:

> xiaolinkui <xiaolinkui@126.com> wrote:
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> > 
> > Before destroying the ipset, take a check on sequence to ensure that the
> > ip_set_test operation of this ipset has been completed.
> > 
> > The code of set_match_v4 is protected by addend=xt_write_recseq_begin() and
> > xt_write_recseq_end(addend). So we can ensure that the test operation is
> > completed by reading seqcount.
> 
> Nope, please don't do this, the xt_set can also be used from nft_compat
> which doesn't use the xtables packet traversers.
> 
> I'd rather use synchonize_rcu() once in ip_set_destroy(), that will
> make sure all concurrent traversers are gone.

But ip_set_destroy() can be called only when there's no reference to the 
set in the kernel and thus there's no ipset function whatsoever in the 
packet path which would access it.

> That said, I still do not understand this fix, the
> match / target destroy hooks are called after the table has
> been completely replaced, i.e., while packets can still be in flight
> no packets should be within the ipset lookup functions when
> this happens, and no more packets should be able to enter them.
> 
> AFAICS the request to delete the set will fail if its still referenced
> via any rule. xt_set holds references to the sets.
> 
> So:
> 1. set have dropped all references
> 2. userspace *can* delete the set
> 3. we get crash because xt_set was still within a sets eval
>   function.
> 
> I don't see how 3) can happen, xt table replace isn't supposed
> to call the xt_set destroy functions until after table replace.
> 
> We even release the entire x_table blob right afterwards.

I'd expect the author to send patches to netfilter-devel@vger.kernel.org 
first in order to review netfilter and ipset related patches there.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

