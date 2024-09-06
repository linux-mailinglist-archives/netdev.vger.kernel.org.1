Return-Path: <netdev+bounces-125879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435996F17D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A139B20DA1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6721482E8;
	Fri,  6 Sep 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzSejvdv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C613AD2F
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618636; cv=none; b=QH71Ckl1JMlcC7IpiRWaSNiB3ZN4YTBKHvhFbaE+ydVrafQVp06eY0ueQGMO/7zOpdCKe7YnI7hAI37PcCLh2mITh1cly6eljRABYLcfcqP2X1nFn7dD/qrBXhY5saYUvcZoxE+oqf8iSMoTLQwBicxVKlX5BHNV7Dtyuuuwx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618636; c=relaxed/simple;
	bh=gpurG5DS/qY/4tckUDEul6HGlDkofHf40drk89kXyL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmmwNEkDy/cx/yEjvRmivPnZvgRUP+VquzHLFnAtGqEZncCIH9e668s+X+4e1alYLOR6zavXGUla7LQbYpMQ7+GIsEEnvnAhdj0xXGUz1VxRVT3kizqIPnzCaN8ZA/zhhu/yUOa5c+xjBPD37vInJaQcCjrcLw8/7+AVcgXFp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzSejvdv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725618633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nwSvcgAY7yqK6W5cuMH1Sl/JPzQHktUXAyhnBaZCMc=;
	b=gzSejvdvU4/BspTgIAG8L1uEk5TDMa1cUvWVb1LlvK0t96dgzDJ7cJrYKqp8qYY3GZQYOQ
	IXsj20Vzyn0rvJxWhlhHuRlughz7NiUTMii/nYaXvWgtz/dzozrJFJ1/RKFtjBXJavcMWH
	StvWuKwxVjKFKfLw4p6ONst6vBUuN/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-_bXC79x3Ni6Hds371OFLow-1; Fri, 06 Sep 2024 06:30:32 -0400
X-MC-Unique: _bXC79x3Ni6Hds371OFLow-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb7178d05so15056185e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 03:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618631; x=1726223431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwSvcgAY7yqK6W5cuMH1Sl/JPzQHktUXAyhnBaZCMc=;
        b=FY42LrrLAe7wYnbj9Y8/uBR5Gl1iKDoABSJumeLcoxFYGLQ0AfATmtbocHPSinyv+D
         CcwLccOyE/LBXeXa/zdcNoGyYesTp67JjznpgH6UuhAndC3slI1LS/jmuMBT6jNLbgFG
         VMr9CPHfZIEKTkfFIbszSidpHF7IrEuPqsz6efYLCpqfcQhYL/uVe9DRGh0CoX2NrxQr
         mNJCUyvc1WkD/zfiZAm4l+MmMMTo+J0HREEusgzNznX467ueoOLxnmk0SLLNQQ4ozFYe
         mEmjpySOqbq4b97uGWROMvkWInW9xamhH0R8MIDGPZDErAkZ10A1jnINGIhrVI5/79C2
         SDLA==
X-Forwarded-Encrypted: i=1; AJvYcCWIhVMxvZmrZpWcXSezNwRfiul5BcvwNMszBqBetNcd+rMWdk72L5Oblk7FOTwVIv1fDXIwvWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWVot0TMEOf/WxvZlZUK9X2HRq5dCl+uhrds+mE7Mx1ZJtxOD
	36XlVJpSvKRpghDFff+qYh0Qw/DyS5DgXPYXL+PZLoYoyXlo7NdcsnICA9E6noRqE/kAJwiAMwb
	xde38RfJIVGjxRFhH1DPfypClcSUdzor1m+8/z5vQjWxCJZV9PAz5hA==
X-Received: by 2002:a05:600c:1385:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-42c9f8eeed8mr14682125e9.0.1725618631250;
        Fri, 06 Sep 2024 03:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXGEZfjZnC6w6eRgpQxrlAS3dz51FU3pvypFv/al4joSB4o0ZH9YrRpzEuARqVgR0dlKgIdw==
X-Received: by 2002:a05:600c:1385:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-42c9f8eeed8mr14681595e9.0.1725618630057;
        Fri, 06 Sep 2024 03:30:30 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d86f1sm16063975e9.35.2024.09.06.03.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:30:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:30:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <ZtrZw8UdMXAJT5GR@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org>
 <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org>
 <Ztie4AoXc9PhLi5w@debian>
 <3aaa7117-ded8-4d3d-acdc-82a1e9fb73b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aaa7117-ded8-4d3d-acdc-82a1e9fb73b8@kernel.org>

On Wed, Sep 04, 2024 at 07:50:55PM -0600, David Ahern wrote:
> On 9/4/24 11:54 AM, Guillaume Nault wrote:
> > [Adding David Ahern for the vrf/dstats discussion]
> > 
> > On Wed, Sep 04, 2024 at 07:57:32AM -0700, Jakub Kicinski wrote:
> >> On Wed, 4 Sep 2024 14:29:44 +0200 Guillaume Nault wrote:
> >>>> The driver already uses struct pcpu_sw_netstats, would it make sense to
> >>>> bump it up to struct pcpu_dstats and have per CPU rx drops as well?
> >>>
> >>> Long term, I was considering moving bareudp to use dev->tstats for
> >>> packets/bytes and dev->core_stats for drops. It looks like dev->dstats
> >>> is only used for VRF, so I didn't consider it.
> >>
> >> Right, d stands for dummy so I guess they also were used by dummy
> >> at some stage? Mostly I think it's a matter of the other stats being
> >> less recent.
> > 
> > Looks like dummy had its own dstats, yes. But those dstats were really
> > like the current lstats (packets and bytes counters, nothing for
> > drops). Dummy was later converted to lstats by commit 4a43b1f96b1d
> > ("net: dummy: use standard dev_lstats_add() and dev_lstats_read()").
> > 
> > The dstats we have now really come from vrf (different counters for tx
> > and rx and counters for packet drops), which had its own implementation
> > at that time.
> > 
> > My understanding is that vrf implemented its own dstats in order to
> > have per-cpu counters for regular bytes/packets counters and also for
> > packet drops.
> 
> VRF was following other per-cpu counters that existed in 2015-2016
> timeframe.

Thanks. That was my impression as well.

> I have no preference on the naming; just wanted per-cpu counters.
> 


