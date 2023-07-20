Return-Path: <netdev+bounces-19369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C275A8EE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD2281C58
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D473174C0;
	Thu, 20 Jul 2023 08:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B4171D2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:17:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B51711
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689841071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFfHYXGH+DVIwKUfeFwvujlvWMplHcko4q0e04SPqxo=;
	b=c/e6qcr7Dg0aE19lwCvHsQeGvetVHvj/nYLjkkYTaK1eMbAAc9/nFX/1WeQgnyY8wvl93e
	V6k7dNUhhSWcj905nJcODQeU3AExBA32n6KDQPKWPKzCGRxsPQjrNKexN/S6dv/SOLGiFV
	Q5fYdrUqWZrFJdlolbWtOkQEu6HR3po=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-hjVxV0ycNnywddrtIl1hxw-1; Thu, 20 Jul 2023 04:17:46 -0400
X-MC-Unique: hjVxV0ycNnywddrtIl1hxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C171800CAF;
	Thu, 20 Jul 2023 08:17:46 +0000 (UTC)
Received: from griffin (unknown [10.45.226.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC434CD0E1;
	Thu, 20 Jul 2023 08:17:45 +0000 (UTC)
Date: Thu, 20 Jul 2023 10:17:43 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net] vxlan: calculate correct header length for GPE
Message-ID: <20230720101743.0318684d@griffin>
In-Reply-To: <20230719210828.2395436f@kernel.org>
References: <0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
	<20230719210828.2395436f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 21:08:28 -0700, Jakub Kicinski wrote:
> On Tue, 18 Jul 2023 12:50:13 +0200 Jiri Benc wrote:
> > This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU is
> > cached. If the VXLAN-GPE interface has MTU 1464 set (with the underlying
> > interface having the usual MTU of 1500), a TCP stream sent over the
> > tunnel is first segmented to 1514 byte frames only to be immediatelly
> > followed by a resend with 1500 bytes frames, before the other side even
> > has a chance to ack them.  
> 
> Sounds like we are overly conservative, assuming the header will be
> larger than it ends up being. But you're saying it leads to oversized,
> not undersized packets?

Sorry for not providing enough details. The packets are actually
correctly sized, initially. Then a lower, incorrect PMTU is cached.

In the collect_md mode (which is the only mode that VXLAN-GPE
supports), there's no magic auto-setting of the tunnel interface MTU.
It can't be, since the destination and thus the underlying interface
may be different for each packet.

So, the administrator is responsible for setting the correct tunnel
interface MTU. Apparently, the administrators are capable enough to
calculate that the maximum MTU for VXLAN-GPE is (their_lower_MTU - 36).
They set the tunnel interface MTU to 1464. If you run a TCP stream over
such interface, it's then segmented according to the MTU 1464, i.e.
producing 1514 bytes frames. Which is okay, this still fits the lower
MTU.

However, skb_tunnel_check_pmtu (called from vxlan_xmit_one) uses 50 as
the header size and thus incorrectly calculates the frame size to be
1528. This leads to ICMP too big message being generated (locally),
PMTU of 1450 to be cached and the TCP stream to be resegmented.

The fix is to use the correct actual header size, especially for
skb_tunnel_check_pmtu calculation.

Should I resend with more detailed patch description?

Thanks,

 Jiri


