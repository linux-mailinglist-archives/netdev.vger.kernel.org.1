Return-Path: <netdev+bounces-112034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82409934A9C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B12B23E57
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD28060A;
	Thu, 18 Jul 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eF5ONff3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D57FBB7
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293190; cv=none; b=tcPb0Pu5V3RueRVotGf9Jzknz8Lrrickp8ppIxA7CJKCa63tDwKlKubbq6ApM9BMnLWmMprAIWdvtw1yDX9zAFNoNA2jmH1PsLzky9LY7A8KEgR8620cCB7tdOQ5U7iQyul8d6xck+Vd22AZtntR+86WrGXOP7zQ4xT89RcjZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293190; c=relaxed/simple;
	bh=GECgGQ/Ota7Qip10a9ZFVD2VngZuGjohbWR+tfjOJDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4EffvxAbuZKRGHCUlCI1qpcD9irRdR92BuDkdUL5U8uNYyh10ptE0sLMEqJfgMFZ/Xb4MxDbfqYozO6WgmOXdnt218t1c9dZVOwbO8fOP9jePp12p924PUjcsWWx6J0kjiqXdir7yshE2Kef2e52wrdWijMlb3EH5/Lb7VEUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eF5ONff3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgMVMQRohcF5WdcemhAgGK2mnTBxhy1oAaWpEwFYhYM=;
	b=eF5ONff3AM1wwgnXSrWz5u3kZ5UHK73glDb4jfU0bm3MIghXJXWivfHlaxmMxa6wYBcawa
	0FHAUI3N0jMuGOQ6HswYYY/40OfBlnF0ZQOI61hyTDrOtl5YWcLpI3sXcAXfXO92aaC/XA
	1sb9Zk7Rcto+qjnQxXUJ0qgMsnK9+mc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-nmO5mHNnNn-8SEr4v5pEOQ-1; Thu,
 18 Jul 2024 04:59:44 -0400
X-MC-Unique: nmO5mHNnNn-8SEr4v5pEOQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 897B21944B27;
	Thu, 18 Jul 2024 08:59:42 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00C81955F40;
	Thu, 18 Jul 2024 08:59:41 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A8DC5A80D05; Thu, 18 Jul 2024 10:59:39 +0200 (CEST)
Date: Thu, 18 Jul 2024 10:59:39 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2] igb: cope with large
 MAX_SKB_FRAGS
Message-ID: <ZpjZe1pgqbJ-Zp0S@calimero.vinschen.de>
Mail-Followup-To: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240423134731.918157-1-vinschen@redhat.com>
 <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
 <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
 <CANn89iJ_eM2oK5ruGu1NMk0ZEivEQO=R64E9eb9ujYj+=qWiKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ_eM2oK5ruGu1NMk0ZEivEQO=R64E9eb9ujYj+=qWiKA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Eric,

sorry for the very late reply, I was offline for quite some time
and then other things took over.

On Apr 26 19:54, Eric Dumazet wrote:
> On Fri, Apr 26, 2024 at 4:30 PM Corinna Vinschen <vinschen@redhat.com> wrote:
> >
> > Hi Eric,
> >
> > On Apr 23 16:10, Eric Dumazet wrote:
> > > On Tue, Apr 23, 2024 at 3:47 PM Corinna Vinschen <vinschen@redhat.com> wrote:
> > > >
> > > > From: Paolo Abeni <pabeni@redhat.com>
> > > >
> > > > Sabrina reports that the igb driver does not cope well with large
> > > > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > > > corruption on TX.
> > > >
> > > > An easy reproducer is to run ssh to connect to the machine.  With
> > > > MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> > > > [...]
> > > > @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> > > >
> > > >  #if (PAGE_SIZE < 8192)
> > > >         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > > > +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> > >
> > > I wonder if adding IGB_SKB_PAD would be needed ?
> > >
> > > adapter->max_frame_size does not seem to include it.
> > >
> > > I would try using all mtus between 1200 and 1280 to make sure this works.
> >
> > Erm... did you mean between 1500 and 1580 by any chance?  1200 doesn't
> > really seem to make sense...
> 
> No, I meant 1200 to 1280 .  IPv4 should accept these MTU .
> 
> 1200 + 768 = 1968
> 1280 + 768 = 2048 (2 KB)
> 
> I am worried of some padding that would cross 2048 bytes boundary,
> while SKB_HEAD_ALIGN(adapter->max_frame_size) could still be < 2048
> 
> 
> >
> > I tested this patch now with mtu 1500, 1540 and 1580 successfully.
> >
> > Either way, I'm just heading into vacation, so I guess I'll pick this up
> > again when I'm back, unless Paolo takes another look during my absence.
> >
> 
> I guess your patch is better than nothing, this can be refined if
> necessary later.

I now tested the patch with all MTUs between 1200 and 1280 and it
works as desired.  I just sent a v3.


Thanks,
Corinna


