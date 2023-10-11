Return-Path: <netdev+bounces-39989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F67C552C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906581C20C24
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD931F928;
	Wed, 11 Oct 2023 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNXHm2LI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2D1F17E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:23:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E690
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697030601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGc8izLfBD5+/wCYakOVoKKmqXcUt92UD4LE+c5u8I0=;
	b=gNXHm2LIrXp7Tmx/rvtmZ1WRigDC3n0suNrzFzt5s9jJD4aI485fY0EJDI0DnyZWc4x4bs
	HzQuAGnF+YlPbZCZSRv029nItJp21CQoRarqg4PMBfMOHOxqvMR+nTpUdIjs20W4Xu/qTT
	jxmEawKioHO6hFohWuElGTw8jfOZe18=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-2ouwYUh3MC2K-k-eG6enWg-1; Wed, 11 Oct 2023 09:23:19 -0400
X-MC-Unique: 2ouwYUh3MC2K-k-eG6enWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 407071C08966;
	Wed, 11 Oct 2023 13:23:19 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 919A92026D4B;
	Wed, 11 Oct 2023 13:23:18 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "Eelco Chaudron" <echaudro@redhat.com>,  "Ilya
 Maximets" <imaximet@redhat.com>,  "Flavio Leitner" <fbl@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 0/7] net: openvswitch: Reduce stack usage
References: <20231011034344.104398-1-npiggin@gmail.com>
Date: Wed, 11 Oct 2023 09:23:18 -0400
In-Reply-To: <20231011034344.104398-1-npiggin@gmail.com> (Nicholas Piggin's
	message of "Wed, 11 Oct 2023 13:43:37 +1000")
Message-ID: <f7ta5spe1ix.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nicholas Piggin <npiggin@gmail.com> writes:

> Hi,
>
> I'll post this out again to keep discussion going. Thanks all for the
> testing and comments so far.

Thanks for the update - did you mean for this to be tagged RFC as well?

I don't see any performance data with the deployments on x86_64 and
ppc64le that cause these stack overflows.  Are you able to provide the
impact on ppc64le and x86_64?

I guess the change probably should be tagged as -next since it doesn't
really have a specific set of commits it is "fixing."  It's really like
a major change and shouldn't really go through stable trees, but I'll
let the maintainers tell me off if I got it wrong.

> Changes since the RFC
> https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.com/
>
> - Replace slab allocations for flow keys with expanding the use
>   of the per-CPU key allocator to ovs_vport_receive.
>
> - Drop patch 1 with Ilya's since they did the same thing (that is
>   added at patch 3).
>
> - Change push_nsh stack reduction from slab allocation to per-cpu
>   buffer.
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


