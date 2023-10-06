Return-Path: <netdev+bounces-38572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B87BB77C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A918F1C20965
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752C1CFAE;
	Fri,  6 Oct 2023 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1214F79
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:23:45 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F9CA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:23:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qojrn-00008q-N2; Fri, 06 Oct 2023 14:23:39 +0200
Date: Fri, 6 Oct 2023 14:23:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Theune <ct@flyingcircus.io>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	netdev@vger.kernel.org, markovicbudimir@gmail.com
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231006122339.GC29258@breakpoint.cc>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christian Theune <ct@flyingcircus.io> wrote:

[ Trimming CCs, adding patch author ]

> it seems that 6.6rc4 is affected as well:
> ----
> commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f
> Author: Budimir Markovic <markovicbudimir@gmail.com>
> Date:   Thu Aug 24 01:49:05 2023 -0700
> 
>     net/sched: sch_hfsc: Ensure inner classes have fsc curve
> ——
> 
> I have not found newer commits that would suggest they change any behaviour around this in any way, but I might be wrong.
> 
> Christian
> 
> > On 6. Oct 2023, at 11:01, Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> > 
> > On 06.10.23 10:37, Christian Theune wrote:
> >> 
> >> (prefix, I was not aware of the regression reporting process and incorrectly reported this informally with the developers mentioned in the change)
> > 
> > Don't worry too much about that, but thx for taking care of all the
> > details. FWIW, there is one more thing that would be good to know:
> > 
> > Does the problem happen with mainline (e.g. 6.6-rc4) as well? That's
> > relevant, as different people might care[1].
> > 
> > Ciao, Thorsten
> > 
> > [1] this among others is explained here:
> > https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
> > 
> >> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
> >> 
> >> The script errors out like this:
> >> 
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=ispA
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext_ingress=ifb0
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe act_mirred
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA root
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot delete qdisc with handle of zero.
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA ingress
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot find specified qdisc on specified device.
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 root
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot delete qdisc with handle of zero.
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 ingress
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot find specified qdisc on specified device.
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ispA handle ffff: ingress
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig ifb0 up
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev ifb0
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ifb0 root handle 1: hfsc default 1
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
> >> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid parent - parent class must have FSC.
> >> 
> >> The error message is also a bit weird (but that’s likely due to iproute2 being weird) as the CLI interface for `tc` and the error message do not map well. (I think I would have to choose `hfsc sc` on the parent to enable the FSC option which isn’t mentioned anywhere in the hfsc manpage).
> >> 
> >> The breaking change was introduced in 6.1.53[1] and a multitude of other currently supported kernels:
> >> 
> >> ----
> >> commit a1e820fc7808e42b990d224f40e9b4895503ac40
> >> Author: Budimir Markovic <markovicbudimir@gmail.com>
> >> Date: Thu Aug 24 01:49:05 2023 -0700
> >> 
> >> net/sched: sch_hfsc: Ensure inner classes have fsc curve
> >> 
> >> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
> >> 
> >> HFSC assumes that inner classes have an fsc curve, but it is currently
> >> possible for classes without an fsc curve to become parents. This leads
> >> to bugs including a use-after-free.
> >> 
> >> Don't allow non-root classes without HFSC_FSC to become parents.
> >> 
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> >> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> >> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ----
> >> 
> >> Regards,
> >> Christian
> >> 
> >> [1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53
> >> 
> >> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
> >> 
> >> 
> 
> Liebe Grüße,
> Christian Theune
> 
> -- 
> Christian Theune · ct@flyingcircus.io · +49 345 219401 0
> Flying Circus Internet Operations GmbH · https://flyingcircus.io
> Leipziger Str. 70/71 · 06108 Halle (Saale) · Deutschland
> HR Stendal HRB 21169 · Geschäftsführer: Christian Theune, Christian Zagrodnick

