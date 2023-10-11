Return-Path: <netdev+bounces-39993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E6B7C558E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9540428233D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A281F941;
	Wed, 11 Oct 2023 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLZZY48X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257E1F938
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:35:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3292
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697031298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAv1PVLvYqIR/2bWalv4WrsQM13eMyAByLg2arMdMWw=;
	b=LLZZY48XxFIzfmtxj3M5BTCNSFRPGaxxRmuRB3OX04DlYFqZfCYd7OgOuaYTcNM5ZXTZwa
	W2cECFq3J3tjisGXz8RUmEjYNXLKPLoOodojb2zXdVQiUj8K9bgncYmQTTK3eQh94KXUm1
	B1hfzn1xa7nv77kJkJmZ7cVYaxaS03c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-X9Bos6O6OpKznazHX95zVA-1; Wed, 11 Oct 2023 09:34:55 -0400
X-MC-Unique: X9Bos6O6OpKznazHX95zVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BAE1E441D9;
	Wed, 11 Oct 2023 13:34:54 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB6140C6CA1;
	Wed, 11 Oct 2023 13:34:54 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: "Eelco Chaudron" <echaudro@redhat.com>,  <netdev@vger.kernel.org>,
  <dev@openvswitch.org>,  "Ilya Maximets" <imaximet@redhat.com>,  "Flavio
 Leitner" <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
References: <20230927001308.749910-1-npiggin@gmail.com>
	<20230927001308.749910-5-npiggin@gmail.com>
	<f7tfs2ymi8y.fsf@redhat.com> <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
	<34747C51-2F94-4B64-959B-BA4B0AA4224B@redhat.com>
	<CW04VKYCMTJE.ZX0TQ1Y6H6VB@wheely>
Date: Wed, 11 Oct 2023 09:34:53 -0400
In-Reply-To: <CW04VKYCMTJE.ZX0TQ1Y6H6VB@wheely> (Nicholas Piggin's message of
	"Thu, 05 Oct 2023 12:01:15 +1000")
Message-ID: <f7ty1g9cmf6.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Fri Sep 29, 2023 at 6:38 PM AEST, Eelco Chaudron wrote:
>>
>>
>> On 29 Sep 2023, at 9:00, Nicholas Piggin wrote:
>>
>> > On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
>> >> Nicholas Piggin <npiggin@gmail.com> writes:
>> >>
>> >>> Dynamically allocating the sw_flow_key reduces stack usage of
>> >>> ovs_vport_receive from 544 bytes to 64 bytes at the cost of
>> >>> another GFP_ATOMIC allocation in the receive path.
>> >>>
>> >>> XXX: is this a problem with memory reserves if ovs is in a
>> >>> memory reclaim path, or since we have a skb allocated, is it
>> >>> okay to use some GFP_ATOMIC reserves?
>> >>>
>> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >>> ---
>> >>
>> >> This represents a fairly large performance hit.  Just my own quick
>> >> testing on a system using two netns, iperf3, and simple forwarding rules
>> >> shows between 2.5% and 4% performance reduction on x86-64.  Note that it
>> >> is a simple case, and doesn't involve a more involved scenario like
>> >> multiple bridges, tunnels, and internal ports.  I suspect such cases
>> >> will see even bigger hit.
>> >>
>> >> I don't know the impact of the other changes, but just an FYI that the
>> >> performance impact of this change is extremely noticeable on x86
>> >> platform.
>> >
>> > Thanks for the numbers. This patch is probably the biggest perf cost,
>> > but unfortunately it's also about the biggest saving. I might have an
>> > idea to improve it.
>>
>> Also, were you able to figure out why we do not see this problem on
>> x86 and arm64? Is the stack usage so much larger, or is there some
>> other root cause? Is there a simple replicator, as this might help
>> you profile the differences between the architectures?
>
> I found some snippets of equivalent call chain (this is for 4.18 RHEL8
> kernels, but it's just to give a general idea of stack overhead
> differences in C code). Frame size annotated on the right hand side:
>
> [c0000007ffdba980] do_execute_actions     496
> [c0000007ffdbab70] ovs_execute_actions    128
> [c0000007ffdbabf0] ovs_dp_process_packet  208
> [c0000007ffdbacc0] clone_execute          176
> [c0000007ffdbad70] do_execute_actions     496
> [c0000007ffdbaf60] ovs_execute_actions    128
> [c0000007ffdbafe0] ovs_dp_process_packet  208
> [c0000007ffdbb0b0] ovs_vport_receive      528
> [c0000007ffdbb2c0] internal_dev_xmit
>                                  total = 2368
> [ff49b6d4065a3628] do_execute_actions     416
> [ff49b6d4065a37c8] ovs_execute_actions     48
> [ff49b6d4065a37f8] ovs_dp_process_packet  112
> [ff49b6d4065a3868] clone_execute           64
> [ff49b6d4065a38a8] do_execute_actions     416
> [ff49b6d4065a3a48] ovs_execute_actions     48
> [ff49b6d4065a3a78] ovs_dp_process_packet  112
> [ff49b6d4065a3ae8] ovs_vport_receive      496
> [ff49b6d4065a3cd8] netdev_frame_hook
>                                  total = 1712
>
> That's more significant than I thought, nearly 40% more stack usage for
> ppc even with 3 frames having large local variables that can't be
> avoided for either arch.
>
> So, x86_64 could be quite safe with its 16kB stack for the same
> workload, explaining why same overflow has not been seen there.

This is interesting - is it possible that we could resolve this without
needing to change the kernel - or at least without changing how OVS
works?  Why are these so different?  Maybe there's some bloat in some of
the ppc data structures that can be addressed?  For example,
ovs_execute_actions shouldn't really be that different, but I wonder if
the way the per-cpu infra works, or the deferred action processing gets
inlined would be causing stack bloat?

> Thanks,
> Nick


