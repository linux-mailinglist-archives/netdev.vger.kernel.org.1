Return-Path: <netdev+bounces-37986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB77B835D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E1D662814C9
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C218E2C;
	Wed,  4 Oct 2023 15:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CF18E0A
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:16:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F59BF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696432581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oh2bT9i5b4h6iwoHtct825jIchDyqqM/SC2NklH0YQ0=;
	b=QDJGOPdhBNIgGSWhkhSMyi6r3sO18YRnJpVa1WO2262vTycFBGHDAzBGm4wnwIupzcgrBV
	/SSwJF869NFtcdtxqT5/KSiCoQ2qEkBjNFBSdvm/H+7Iqf5pygwZzS0jHAkNY0yLkndGFR
	W1nErPFPzRvZxkerU1OoRtk5fawWAxw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-hVSUVF2dPnGLNcyml4ZCnQ-1; Wed, 04 Oct 2023 11:16:15 -0400
X-MC-Unique: hVSUVF2dPnGLNcyml4ZCnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 632F2185A78E;
	Wed,  4 Oct 2023 15:16:14 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.10.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CF122026D4B;
	Wed,  4 Oct 2023 15:16:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: <netdev@vger.kernel.org>,  <dev@openvswitch.org>,  "Ilya Maximets"
 <imaximet@redhat.com>,  "Eelco Chaudron" <echaudro@redhat.com>,  "Flavio
 Leitner" <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
References: <20230927001308.749910-1-npiggin@gmail.com>
	<20230927001308.749910-5-npiggin@gmail.com>
	<f7tfs2ymi8y.fsf@redhat.com> <CVZH8D7WMBDW.3D77G01KQ48R3@wheely>
Date: Wed, 04 Oct 2023 11:16:11 -0400
In-Reply-To: <CVZH8D7WMBDW.3D77G01KQ48R3@wheely> (Nicholas Piggin's message of
	"Wed, 04 Oct 2023 17:29:30 +1000")
Message-ID: <f7tr0mafmf8.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>> > Dynamically allocating the sw_flow_key reduces stack usage of
>> > ovs_vport_receive from 544 bytes to 64 bytes at the cost of
>> > another GFP_ATOMIC allocation in the receive path.
>> >
>> > XXX: is this a problem with memory reserves if ovs is in a
>> > memory reclaim path, or since we have a skb allocated, is it
>> > okay to use some GFP_ATOMIC reserves?
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>>
>> This represents a fairly large performance hit.  Just my own quick
>> testing on a system using two netns, iperf3, and simple forwarding rules
>> shows between 2.5% and 4% performance reduction on x86-64.  Note that it
>> is a simple case, and doesn't involve a more involved scenario like
>> multiple bridges, tunnels, and internal ports.  I suspect such cases
>> will see even bigger hit.
>>
>> I don't know the impact of the other changes, but just an FYI that the
>> performance impact of this change is extremely noticeable on x86
>> platform.
>>
>> ----
>> ip netns add left
>> ip netns add right
>>
>> ip link add eth0 type veth peer name l0
>> ip link set eth0 netns left
>> ip netns exec left ip addr add 172.31.110.1/24 dev eth0
>> ip netns exec left ip link set eth0 up
>> ip link set l0 up
>>
>> ip link add eth0 type veth peer name r0
>> ip link set eth0 netns right
>> ip netns exec right ip addr add 172.31.110.2/24 dev eth0
>> ip netns exec right ip link set eth0 up
>> ip link set r0 up
>>
>> python3 ovs-dpctl.py add-dp br0
>> python3 ovs-dpctl.py add-if br0 l0
>> python3 ovs-dpctl.py add-if br0 r0
>>
>> python3 ovs-dpctl.py add-flow \
>>   br0 'in_port(1),eth(),eth_type(0x806),arp()' 2
>>   
>> python3 ovs-dpctl.py add-flow \
>>   br0 'in_port(2),eth(),eth_type(0x806),arp()' 1
>>
>> python3 ovs-dpctl.py add-flow \
>>   br0 'in_port(1),eth(),eth_type(0x800),ipv4()' 2
>>
>> python3 ovs-dpctl.py add-flow \
>>   br0 'in_port(2),eth(),eth_type(0x800),ipv4()' 1
>>
>> ----
>>
>> ex results without this patch:
>> [root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172.31.110.1
>> ...
>> [  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec    0             sender
>> [  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec                  receiver
>>
>>
>> ex results with this patch:
>> [root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172.31.110.1
>> ...
>> [  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec    0             sender
>> [  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec                  receiver
>>
>> I did testing with udp at various bandwidths and this tcp testing.
>
> Thanks for the test case. It works perfectly in the end, but it took me
> days to get there because of a random conspiracy of problems I hit :(
> Sorry for the slow reply, but I was now able to test another idea for
> this. Performance seems to be within the noise with the full series, but
> my system is only getting ~half the rate of yours so you might see more
> movement.
>
> Instead of slab it reuses the per-cpu actions key allocator here.
>
> https://github.com/torvalds/linux/commit/878f01f04ca858e445ff4b4c64351a25bb8399e3
>
> Pushed the series to kvm branch of https://github.com/npiggin/linux
>
> I can repost the series as a second RFC but will wait for thoughts on
> this approach.

Thanks - I'll take a look at it.

> Thanks,
> Nick


