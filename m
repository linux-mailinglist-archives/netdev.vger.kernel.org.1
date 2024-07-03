Return-Path: <netdev+bounces-109069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D869926C62
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 01:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7D61F22578
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A715B54F;
	Wed,  3 Jul 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMR+Ydyt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F5136643
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048922; cv=none; b=eO7O80DPMWipLmXNpH8w9tvhLNhJvt21uxwyG6NqA9rT2eGM0RT39c3wgrgMAhhpVldXeBliXWAUxtFsY6gJqveixWEVdfz9Z2ramHUJWEzaZcXypZ9RMs5zknch96/arsluGU8eOV14IXaZHNPE7w9JD//RHktG4jSRkB/lhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048922; c=relaxed/simple;
	bh=JoIxIH8HYoJIFoUCNXLSaQQKK6rOyheoyuMKYwN25O0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pM8JFhAXUb4EQZY8j7TwUI7uN0UYcrA9sW4C/fUwxuoYVQ1t5kt82h/UwbHCVDuHDtPr32PknOh1dVNfjYbg4sYiRq+XhANlSM0ezy5PY/zOO6IkcZjSGtLvtVpLQfvpoNPiC1NWX6ANJTx9Rm8uXtFyx+jcue/REGAaA27O+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMR+Ydyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720048919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9D5ZUuOZ+skRCi07Xfug19ZtfocIaSHEUIlY636Amk=;
	b=GMR+YdytWaARqZiY/mVdkPw33DI6FQbMLxgSuF6f0OhrlP0a8UFx1CvOaxB4AEK4vGurxU
	nn4SRBYFi/JCZOGzVvAVApcC6nT2MwVMEBR2J2hRsl69A0Ga964ZPNvWrc2X7mX4Iv3p09
	d69kRoaZWtFiEAWuIboFKdf00y4ljsU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-sPE9h1-3MHCXG-ze21cTjA-1; Wed,
 03 Jul 2024 19:21:58 -0400
X-MC-Unique: sPE9h1-3MHCXG-ze21cTjA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410461955EF0;
	Wed,  3 Jul 2024 23:21:57 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7F181954B0E;
	Wed,  3 Jul 2024 23:21:55 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: dev@openvswitch.org,  Dumitru Ceara <dceara@redhat.com>,
  netdev@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] openvswitch: prepare for stolen
 verdict coming from conntrack and nat engine
In-Reply-To: <20240703151900.GC29258@breakpoint.cc> (Florian Westphal's
	message of "Wed, 3 Jul 2024 17:19:00 +0200")
References: <20240703104640.20878-1-fw@strlen.de> <f7t34oqplmh.fsf@redhat.com>
	<20240703151900.GC29258@breakpoint.cc>
Date: Wed, 03 Jul 2024 19:21:53 -0400
Message-ID: <f7ttth6njse.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Florian Westphal <fw@strlen.de> writes:

> Aaron Conole <aconole@redhat.com> wrote:
>> > verdict with NF_DROP_REASON() helper,
>> >
>> > This helper releases the skb instantly (so drop_monitor can pinpoint
>> > precise location) and returns NF_STOLEN.
>> >
>> > Prepare call sites to deal with this before introducing such changes
>> > in conntrack and nat core.
>> >
>> > Signed-off-by: Florian Westphal <fw@strlen.de>
>> > ---
>> 
>> AFAIU, these changes are only impacting the existing NF_DROP cases, and
>> won't impact how ovs + netfilter communicate about invalid packets.  One
>> important thing to note is that we rely on:
>> 
>>  * Note that if the packet is deemed invalid by conntrack, skb->_nfct will be
>>  * set to NULL and 0 will be returned.
>
> Right, this is about how to communicate 'packet dropped'.
>
> NF_DROP means 'please call kfree_skb for me'.  Problem from introspection point
> of view is that drop monitor will blame nf_hook_slow() (for netfilter)
> and ovs resp. act_ct for the drop.
>
> Plan is to allow conntrack/nat engine to return STOLEN verdict ("skb
> might have been free'd already").
>
> Example change:
> @@ -52,10 +53,8 @@ nf_nat_masquerade_ipv4(struct sk_buff *skb,
> unsigned int hooknum,
>         rt = skb_rtable(skb);
>         nh = rt_nexthop(rt, ip_hdr(skb)->daddr);
>         newsrc = inet_select_addr(out, nh, RT_SCOPE_UNIVERSE);
> -       if (!newsrc) {
> -               pr_info("%s ate my IP address\n", out->name);
> -               return NF_DROP;
> -       }
> +       if (!newsrc)
> + return NF_DROP_REASON(skb, SKB_DROP_REASON_NETFILTER_DROP,
> EADDRNOTAVAIL);
>
>
> Where NF_DROP_REASON() is:
>
> static __always_inline int
> NF_DROP_REASON(struct sk_buff *skb, enum skb_drop_reason reason, u32 err)
> {
>         BUILD_BUG_ON(err > 0xffff);
>
>         kfree_skb_reason(skb, reason);
>
>         return ((err << 16) | NF_STOLEN);
> }
>
> So drop monitoring tools will blame
> nf_nat_masquerade.c:nf_nat_masquerade_ipv4 and not
> the consumer of the NF_DROP verdict.
>
> I can't make such changes ATM because ovs and act_ct assume conntrack
> returns only ACCEPT and DROP, so we'd get double-free.  Hope that makes
> sense.
>
> Thanks!

Makes sense to me, thanks!


