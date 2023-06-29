Return-Path: <netdev+bounces-14593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248EB7428E9
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563841C20AF1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA9125CF;
	Thu, 29 Jun 2023 14:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130B111BB;
	Thu, 29 Jun 2023 14:53:22 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595152D62;
	Thu, 29 Jun 2023 07:53:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qEt1H-0007I0-3C; Thu, 29 Jun 2023 16:53:15 +0200
Date: Thu, 29 Jun 2023 16:53:15 +0200
From: Florian Westphal <fw@strlen.de>
To: Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230629145315.GB10165@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
 <87o7kyfoqf.fsf@toke.dk>
 <20230629132141.GA10165@breakpoint.cc>
 <87leg2fia0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87leg2fia0.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> Florian Westphal <fw@strlen.de> writes:
> As for the original question, that's answered by your point above: If
> those two modules are the only ones that are likely to need this, then a
> flag for each is fine by me - that was the key piece I was missing (I'm
> not a netfilter expert, as you well know).

No problem, I was worried I was missing an important piece of kfunc
plumbing :-)

You do raise a good point though.  With kfuncs, module is pinned.
So, should a "please turn on defrag for this bpf_link" pin
the defrag modules too?

For plain netfilter we don't do that, i.e. you can just do
"rmmod nf_defrag_ipv4".  But I suspect that for the new bpf-link
defrag we probably should grab a reference to prevent unwanted
functionality breakage of the bpf prog.

