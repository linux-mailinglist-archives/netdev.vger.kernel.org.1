Return-Path: <netdev+bounces-75834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19C86B4F3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F9288527
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2C6EF11;
	Wed, 28 Feb 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mcDPH+fi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0F3FB81
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137797; cv=none; b=lwtByHM6oYuuQDJKMe8t0EGLKQRl+PVkrIkLNazxyYA7KbbTJ6+quKMwCGheIa9y1zfn4pOGl161FVpBiB1B1mVQZoOoEljj/7KTVkX6b2XojsR/AOTAT5rv8eNN073ifbxcKiFggpT/gR39F/StLxaSkJfGMAduVEXxeOrpKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137797; c=relaxed/simple;
	bh=bFVwT1pua6x6N7sKGYB/SFBWO2k7s7/k32hMsdJBMZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWznVyJEoIOuRLiWC7BHyz3E6C6sRkBQ8BijHJNKL7X10wZZyUQT5ZiH+saIUpPFMTMXD7orIAHZSJNbwDGqslgmP/jl6+TTnpDHia6mSj6/Q8rfS/6/+dJUI52wBZYv9D8ew4y4xl5EnuMCuc61hriFwJrgfeWZOzeBWJGiyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mcDPH+fi; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709137796; x=1740673796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+wWdsSP5DGFbUIA2UiDHRaEBVKPPiOGtKgGeROKoFE=;
  b=mcDPH+fiii0DzMPA40p6fbMWBezgoVN1OiShuxWJdFNgxm2CasXEui9B
   uKZM6UyevV2IljstKGCm0GoUO0+BqD4s0cUZihRO8A7INy3bdNwPX7HRo
   zXNW1XxEODNgR/37FOb8Oj2fZAqZntz4QL0Rtomzfc5LJLWSBtahDtBFj
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,190,1705363200"; 
   d="scan'208";a="69443586"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:29:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:18907]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.146:2525] with esmtp (Farcaster)
 id 4c723324-c822-4ed7-aecb-aec9d2fa08bf; Wed, 28 Feb 2024 16:29:49 +0000 (UTC)
X-Farcaster-Flow-ID: 4c723324-c822-4ed7-aecb-aec9d2fa08bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 16:29:47 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 28 Feb 2024 16:29:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 13/14] af_unix: Replace garbage collection algorithm.
Date: Wed, 28 Feb 2024 08:29:36 -0800
Message-ID: <20240228162936.98890-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <26eeffe603d4818c312374cac976ec00c4bff991.camel@redhat.com>
References: <26eeffe603d4818c312374cac976ec00c4bff991.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 28 Feb 2024 09:08:32 +0100
> On Tue, 2024-02-27 at 19:32 -0800, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Tue, 27 Feb 2024 12:36:51 +0100
> > > On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > > index 060e81be3614..59a87a997a4d 100644
> > > > --- a/net/unix/garbage.c
> > > > +++ b/net/unix/garbage.c
> > > > @@ -314,6 +314,48 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
> > > >  	return true;
> > > >  }
> > > >  
> > > > +static struct sk_buff_head hitlist;
> > > 
> > > I *think* hitlist could be replaced with a local variable in
> > > __unix_gc(), WDYT?
> > 
> > Actually it was a local variable in the first draft.
> > 
> > In the current GC impl, hitlist is passed down to functions,
> > but only the leaf function uses it, and I thought the global
> > variable would be easier to follow.
> > 
> > And now __unix_gc() is not called twice at the same time thanks
> > to workqueue, and hitlist can be a global variable.
> 
> My personal preference would be for a local variable, unless it makes
> the code significant more complex: I think it's more clear and avoid
> possible false sharing issues in the data segment.

I didn't think of that point.
I'll use a local variable for hitlist.

Thanks!

