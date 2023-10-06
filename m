Return-Path: <netdev+bounces-38472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE47BB15A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D205282060
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC95226;
	Fri,  6 Oct 2023 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3D46B3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 06:06:45 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19690;
	Thu,  5 Oct 2023 23:06:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qodyp-0006fE-FF; Fri, 06 Oct 2023 08:06:31 +0200
Date: Fri, 6 Oct 2023 08:06:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Henrik =?iso-8859-15?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation, causing MTU problems for
 virtual machines
Message-ID: <20231006060631.GC11420@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <2197902.NgBsaNRSFp@pc>
 <20231004080037.GC15013@breakpoint.cc>
 <3259970.44csPzL39Z@pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3259970.44csPzL39Z@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Henrik Lindström <lindstrom515@gmail.com> wrote:
> On onsdag 4 oktober 2023 10:00:37 CEST Florian Westphal wrote:
> > Can you submit this formally, with proper changelog and Signed-off-by?
> > See scripts/checkpatch.pl in the kernel tree.
> Sure, i can give it a shot. How do i properly credit you if i submit your
> patch with some small changes of my own?

You can use:

"Suggested-by:" tag here.

> > You could also mention in changelog that this is ipv4 only because
> > ipv6 already considers the interface index during reassembly.
> Interesting. I've been trying to understand the code and it seems like
> ipv6 does defragmentation per-interface, while ipv4 does it "per-vrf"
> (correct me if i'm wrong). Is there any reason for this difference? 

Only for linklocal and multicasts.  Added in
264640fc2c5f4f913db5c73fa3eb1ead2c45e9d7 . Even mentions macvlan in the
changelog.

> The idea being that bcast/mcast packets are always defragmented
> per-interface, and unicast packets always "per-vrf".

LGTM, but please CC dsahern@kernel.org once you submit the patch.

