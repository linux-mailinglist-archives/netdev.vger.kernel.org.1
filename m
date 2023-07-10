Return-Path: <netdev+bounces-16561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DE74DD3C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C6A1C20A31
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9314A86;
	Mon, 10 Jul 2023 18:21:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BE13AF9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:21:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6A18C
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689013288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NeuGhmSWoH4+qucGUOsn4hJ4cAiP+8Z9obv1MHffoLM=;
	b=Wbuz9HrqqPL498Z3KNiCJLz/qxRSPHe7OSknUHZUM+QF6IFVtgLHWEFnjrPAkMR03RdFQu
	uvnFRHRxZgpKmoILBi7kV5gR3yr4GSIQEXIAfrnonpUPJIIgrR9Q/v0OfNmb1B7T0b79Pb
	RLOZm9ZCtW8m6MIdJcSNzddaS+qIcAU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-E3Cs6qlDPaqyZBPPi65QLA-1; Mon, 10 Jul 2023 14:21:27 -0400
X-MC-Unique: E3Cs6qlDPaqyZBPPi65QLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B8103C11C61;
	Mon, 10 Jul 2023 18:21:26 +0000 (UTC)
Received: from localhost (unknown [10.22.8.38])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FD1340C206F;
	Mon, 10 Jul 2023 18:21:26 +0000 (UTC)
Date: Mon, 10 Jul 2023 14:21:24 -0400
From: Eric Garver <eric@garver.life>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Aaron Conole <aconole@redhat.com>,
	netdev@vger.kernel.org, dev@openvswitch.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
Message-ID: <ZKxMJOdz8LoAA-A5@egarver-thinkpadt14sgen1.remote.csb>
Mail-Followup-To: Eric Garver <eric@garver.life>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>, Aaron Conole <aconole@redhat.com>,
	netdev@vger.kernel.org, dev@openvswitch.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life>
 <f7tr0plgpzb.fsf@redhat.com>
 <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
 <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
 <20230707080025.7739e499@kernel.org>
 <eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
 <dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
 <20230707150610.4e6e1a4d@kernel.org>
 <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 06:51:19PM +0200, Ilya Maximets wrote:
> On 7/8/23 00:06, Jakub Kicinski wrote:
> > On Fri, 7 Jul 2023 18:04:36 +0200 Ilya Maximets wrote:
> >>>> That already exists, right? Johannes added it in the last release for WiFi.  
> >>>
> >>> I'm not sure.  The SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE behaves similarly
> >>> to that on a surface.  However, looking closer, any value that can be passed
> >>> into ieee80211_rx_handlers_result() and ends up in the kfree_skb_reason() is
> >>> kind of defined in net/mac80211/drop.h, unless I'm missing something (very
> >>> possible, because I don't really know wifi code).
> >>>
> >>> The difference, I guess, is that for openvswitch values will be provided by
> >>> the userpsace application via netlink interface.  It'll be just a number not
> >>> defined anywhere in the kernel.  Only the subsystem itself will be defined
> >>> in order to occupy the range.  Garbage in, same garbage out, from the kernel's
> >>> perspective.  
> >>
> >> To be clear, I think, not defining them in this particular case is better.
> >> Definition of every reason that userspace can come up with will add extra
> >> uAPI maintenance cost/issues with no practical benefits.  Values are not
> >> going to be used for anything outside reporting a drop reason and subsystem
> >> offset is not part of uAPI anyway.
> > 
> > Ah, I see. No, please don't stuff user space defined values into 
> > the drop reason. The reasons are for debugging the kernel stack 
> > itself. IOW it'd be abuse not reuse.
> 
> Makes sense.  I wasn't sure that's a good solution from a kernel perspective
> either.  It's better than defining all these reasons, IMO, but it's not good
> enough to be considered acceptable, I agree.
> 
> How about we define just 2 reasons, e.g. OVS_DROP_REASON_EXPLICIT_ACTION and
> OVS_DROP_REASON_EXPLICIT_ACTION_WITH_ERROR (exact names can be different) ?
> One for an explicit drop action with a zero argument and one for an explicit
> drop with non-zero argument.
> 
> The exact reason for the error can be retrieved by other means, i.e by looking
> at the datapath flow dump or OVS logs/traces.
> 
> This way we can give a user who is catching packet drop traces a signal that
> there was something wrong with an OVS flow and they can look up exact details
> from the userspace / flow dump.
> 
> The point being, most of the flows will have a zero as a drop action argument,
> i.e. a regular explicit packet drop.  It will be hard to figure out which flow
> exactly we're hitting without looking at the full flow dump.  And if the value
> is non-zero, then it should be immediately obvious which flow is to blame from
> the dump, as we should not have a lot of such flows.
> 
> This would still allow us to avoid a maintenance burden of defining every case,
> which are fairly meaningless for the kernel itself, while having 99% of the
> information we may need.
> 
> Jakub, do you think this will be acceptable?
> 
> Eric, Adrian, Aaron, do you see any problems with such implementation?

I see no problems. I'm content with this approach.

> P.S. There is a plan to add more drop reasons for other places in openvswitch
>      module to catch more regular types of drops like memory issues or upcall
>      failures.  So, the drop reason subsystem can be extended later.
>      The explicit drop action is a bit of an odd case here.
> 
> Best regards, Ilya Maximets.
> 


