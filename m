Return-Path: <netdev+bounces-37985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B77B8359
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 413B62812A3
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50F18E1E;
	Wed,  4 Oct 2023 15:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536A18E13
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:15:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA326D7
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696432535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q44NhlxH9QmpX+3kZY7RksgmAEsVHT6ZLia8SwlZRg0=;
	b=B5FgSPW78aW3cf1uRRQvo3BCmCUnvK8oU630UcjFCpxQfOjhMFfKaKsZ7OnunNAqa/7MDk
	+GcT1EFGKRqUMwlNqCpWGmZKGPKHVY3SBwItg2g4RLsJx5zDm7S0zk/biKORA6ueYFihd3
	fu5BGbDF7I7bhnyKa5wLlkRhY12sQv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-DniWRud-NLa77hJ7FCrBCA-1; Wed, 04 Oct 2023 11:15:32 -0400
X-MC-Unique: DniWRud-NLa77hJ7FCrBCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FF7A811E7E;
	Wed,  4 Oct 2023 15:15:32 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.10.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5948400F0F;
	Wed,  4 Oct 2023 15:15:31 +0000 (UTC)
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
	<CVZGUWQGYWQX.1W7BH28XB6WKM@wheely>
Date: Wed, 04 Oct 2023 11:15:31 -0400
In-Reply-To: <CVZGUWQGYWQX.1W7BH28XB6WKM@wheely> (Nicholas Piggin's message of
	"Wed, 04 Oct 2023 17:11:56 +1000")
Message-ID: <f7tv8bmfmgc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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
>> other root cause?
>
> Haven't pinpointed it exactly. ppc64le interrupt entry frame is nearly
> 3x larger than x86-64, about 200 bytes. So there's 400 if a hard
> interrupt (not seen in the backtrace) is what overflowed it. Stack
> alignment I think is 32 bytes vs 16 for x86-64. And different amount of
> spilling and non-volatile register use and inlining choices by the
> compiler could nudge things one way or another. There is little to no
> ppc64le specific data structures on the stack in any of this call chain
> which should cause much more bloat though, AFAIKS.
>
> So other archs should not be far away from overflowing 16kB I think.
>
>> Is there a simple replicator, as this might help you
>> profile the differences between the architectures?
>
> Unfortunately not, it's some kubernetes contraption I don't know how
> to reproduce myself.

If we can get the flow dump and configuration, we can probably make sure
to reproduce it with ovs-dpctl.py (add any missing features, etc).  I
guess it should be simple to get (ovs-vsctl show, ovs-appctl
dpctl/dump-flows) and we can try to replicate it.

> Thanks,
> Nick


