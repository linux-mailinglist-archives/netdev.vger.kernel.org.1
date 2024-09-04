Return-Path: <netdev+bounces-125233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6896C5CE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B943E1F21E83
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAA1D6790;
	Wed,  4 Sep 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmaVFiFF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3E2AE9F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472489; cv=none; b=pqLnIX32e+8vIDwcaKlLP2EvKQblVaEFI/N6mZ0N9UdOotSUSE7xwXOvwbPHYTMxjf1ClZHirq5Qc9pFvRI0xOopHuJllQDGAMqQ93Se7sIHE4z0NgsmfySM4P1V/nEpMvCFO1PVjun/Gez3HuClGS4qP5LiakGw7TUii4RI6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472489; c=relaxed/simple;
	bh=Z6HiyX93ykcjunBqVHUERr9afewumJr9FbixGfAFfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgO27STUWbn5awFDoLAc3DCxWSzwmlEXBS0fJi5ST7HQj08cu1lwhC3nw3Rw6OlwpHM3p+J5QAkp5RLsmRo5ytsgcD1yaz8hixRVjLxKeWtL2XGaIw9GlwpOulWMGBxchPSnCV5iU+W9s2L5r08G11DDqUHqkhLOXkmG6tzY+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmaVFiFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725472486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzbU6ouPAuxG+alhKrMt3VN81Hbe8no9a/WKkemkhDk=;
	b=QmaVFiFF8h41gmzsR2DVq0oKO4AfItwfHlcknXOjxB5GfnDBmRk/oiylk6wYlbe/WmKt6z
	07NGaL2o38ZZPtWhhOLREB0wkBCY3bz02A5/xP3mFVa+I1NwBD9Chpuj74qA3IMWXYU86p
	MBV22tbGZ6bceyqOAZxOxuE2XFysrV4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-5p1Q7fD4Nca4Ls4c5oyXHw-1; Wed, 04 Sep 2024 13:54:44 -0400
X-MC-Unique: 5p1Q7fD4Nca4Ls4c5oyXHw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c827c4d3aso10120255e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 10:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472483; x=1726077283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzbU6ouPAuxG+alhKrMt3VN81Hbe8no9a/WKkemkhDk=;
        b=F/AszJQB6kr2RgYCw7QWlBqOfj57jFls3Of2xUGClFFMCpSs5zcMI3v7tWZQbNO1vQ
         6jMs32tmxVGVI6XRnGGM+0a87bMT18Y3sils1/DlsaeogHiDM0xpMrg60d+F1tzoC2Gu
         EoSlSVdKO6re7ilCXHe8HSi/Chr4xOjgBzcfXctZl/5oIGvDV43MAateUSA61veOXFs8
         /OqJ+YMQgzXuijnT1qQSSWS//Or91uTMRDlmrlQFoCVIVInEXhj3wbncgrrhD9vYplwW
         uP7ljwXdamiCz+IzZvGVqm29TfmPL3R7xbNc+Q3roFHWGivX/fj3+HR+DcnA63z3w6NG
         TwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5JED0ebP+WyK8kq4x167fzOvOI02CMy927kzXie8i31FULoXgdFZdizCXJ5mll25ImmoIhNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojlgcdNVDnrOFIlKvEI4oYmpP06u0NH4cSwiBDNb7BXwt2N00
	0QaoQEc2d56Vm2IyXsvuTXYY2UlKmgv8oAjB/5oL6+sbX0o9hDEcbIwBFMb+50FVf8pFzFsYIQj
	FdpUVY6WX7YjOfs2q8Q7dMcrnE+y6V5SujPE+OYuM4aPNGAU0al/yEQ==
X-Received: by 2002:a05:600c:4691:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42c9545e5bbmr26273235e9.18.1725472483339;
        Wed, 04 Sep 2024 10:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcfBdpwRRXyT2Ul558JoI1Xh/UvCw4u7+UsWz9zu9bvEopMdUZL21bMwuVXU0/7rsWLP2zKg==
X-Received: by 2002:a05:600c:4691:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42c9545e5bbmr26272915e9.18.1725472482381;
        Wed, 04 Sep 2024 10:54:42 -0700 (PDT)
Received: from debian (2a01cb058d23d6001cb9a91b9d4fedb5.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1cb9:a91b:9d4f:edb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425a77sm249361855e9.45.2024.09.04.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:54:42 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:54:40 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <Ztie4AoXc9PhLi5w@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org>
 <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904075732.697226a0@kernel.org>

[Adding David Ahern for the vrf/dstats discussion]

On Wed, Sep 04, 2024 at 07:57:32AM -0700, Jakub Kicinski wrote:
> On Wed, 4 Sep 2024 14:29:44 +0200 Guillaume Nault wrote:
> > > The driver already uses struct pcpu_sw_netstats, would it make sense to
> > > bump it up to struct pcpu_dstats and have per CPU rx drops as well?
> > 
> > Long term, I was considering moving bareudp to use dev->tstats for
> > packets/bytes and dev->core_stats for drops. It looks like dev->dstats
> > is only used for VRF, so I didn't consider it.
> 
> Right, d stands for dummy so I guess they also were used by dummy
> at some stage? Mostly I think it's a matter of the other stats being
> less recent.

Looks like dummy had its own dstats, yes. But those dstats were really
like the current lstats (packets and bytes counters, nothing for
drops). Dummy was later converted to lstats by commit 4a43b1f96b1d
("net: dummy: use standard dev_lstats_add() and dev_lstats_read()").

The dstats we have now really come from vrf (different counters for tx
and rx and counters for packet drops), which had its own implementation
at that time.

My understanding is that vrf implemented its own dstats in order to
have per-cpu counters for regular bytes/packets counters and also for
packet drops.

But when vrf's dstats got moved to the core (commits
79e0c5be8c73 ("net, vrf: Move dstats structure to core") and
34d21de99cea ("net: Move {l,t,d}stats allocation to core and convert
veth & vrf")), the networking core had caught up and had also gained
support for pcpu drop counters (commit 625788b58445 ("net: add per-cpu
storage and net->core_stats")).

In this context, I feel that dstats is now just a mix of tstats and
core_stats.

> > Should we favour dev->dstats for tunnels instead of combining ->tstats
> > and ->core_stats? (vxlan uses the later for example).
> 
> Seems reasonable to me. Not important enough to convert existing
> drivers, maybe, unless someone sees contention. But in new code,
> or if we're touching the relevant lines I reckon we should consider it?

Given that we now have pcpu stats for packet drops anyway, what does
dstats bring compared to tstats?

Shouldn't we go the other way around and convert vrf to tstats and
core_stats? Then we could drop dstats entirely.

Back to bareudp, for the moment, I'd prefer to convert it to tstats
rather than dstats. The reason is that vxlan (and geneve to a lesser
extent) use tstats and I'd like to ease potential future code
consolidation between those three modules.

> No strong feelings tho, LMK if you want to send v2 or keep this patch
> as is.

I'd prefer to have this patch merged as is in -net. I have other
patches pending that have to update stats and I'd like to do that
correctly (that is, in a non-racy way) and consistently with existing
code. I feel that converting bareudp to either tstats or dstats is
something for net-next.

After -net will merge into net-next, I'll can convert bareudp to either
dstats or tstats, depending on the outcome of this conversation.


