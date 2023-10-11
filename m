Return-Path: <netdev+bounces-39967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA557C53A1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AC01C20C72
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7351F16F;
	Wed, 11 Oct 2023 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2451DDF1
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:22:04 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC83AB4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:21:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8866C000A;
	Wed, 11 Oct 2023 12:21:52 +0000 (UTC)
Message-ID: <80b08b65-804b-2c83-c953-67def27ee656@ovn.org>
Date: Wed, 11 Oct 2023 14:22:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Flavio Leitner <fbl@redhat.com>, i.maximets@ovn.org,
 Simon Horman <horms@ovn.org>
References: <20231011034344.104398-1-npiggin@gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 0/7] net: openvswitch: Reduce stack usage
In-Reply-To: <20231011034344.104398-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 05:43, Nicholas Piggin wrote:
> Hi,
> 
> I'll post this out again to keep discussion going. Thanks all for the
> testing and comments so far.

Hi, Nicholas.  This patch set still needs performance evaluation
since it touches very performance-sensitive parts of the stack.
Did you run any performance tests with this version?

IIRC, Aaron was still working on testing for the RFC.  I think,
we should wait for his feedback before re-spinning a new version.

> 
> Changes since the RFC
> https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.com/
> 
> - Replace slab allocations for flow keys with expanding the use
>   of the per-CPU key allocator to ovs_vport_receive.

While this is likely to work faster than a dynamic memory allocation,
it is unlikley to be on par with a stack allocation.  Performance
evaluation is necessary.

> 
> - Drop patch 1 with Ilya's since they did the same thing (that is
>   added at patch 3).

The patch is already in net-next, so should not be included in this set.
For the next version (please, hold) please rebase the set on the
net-next/main and add the net-next to the subject prefix of the patches.
They are not simple bug fixes, so should go through net-next, IMO.

You may also see in netdev+bpf patchwork that CI failed trying to guess
on which tree the patches should be applied and no tests were executed.

> 
> - Change push_nsh stack reduction from slab allocation to per-cpu
>   buffer.

I still think this change is not needed and will only consume a lot
of per-CPU memory space for no reason, as NSH is not a frequently
used thing in OVS and the function is not on the recursive path and
explicitly not inlined already.

Best regards, Ilya Maximets.

P.S.  Please use my ovn.org email instead.

> 
> - Drop the ovs_fragment stack usage reduction for now sinc it used
>   slab and was a bit more complicated.
> 
> I posted an initial version of the per-cpu flow allocator patch in
> the RFC thread. Since then I cleaned up some debug code and increased
> the allocator size to accommodate the additional user of it.
> 
> Thanks,
> Nick
> 
> Ilya Maximets (1):
>   openvswitch: reduce stack usage in do_execute_actions
> 
> Nicholas Piggin (6):
>   net: openvswitch: generalise the per-cpu flow key allocation stack
>   net: openvswitch: Use flow key allocator in ovs_vport_receive
>   net: openvswitch: Reduce push_nsh stack usage
>   net: openvswitch: uninline action execution
>   net: openvswitch: uninline ovs_fragment to control stack usage
>   net: openvswitch: Reduce stack usage in ovs_dp_process_packet
> 
>  net/openvswitch/actions.c  | 208 +++++++++++++++++++++++--------------
>  net/openvswitch/datapath.c |  56 +++++-----
>  net/openvswitch/flow.h     |   3 +
>  net/openvswitch/vport.c    |  27 +++--
>  4 files changed, 185 insertions(+), 109 deletions(-)
> 


