Return-Path: <netdev+bounces-75532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A386A69A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5228F287D62
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E582107;
	Wed, 28 Feb 2024 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jc4nVe9H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FC1D681
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087699; cv=none; b=H9OVHBi1fP3znoBW6YxfDsGeeJst0gJ9HfjE+GgKRZc129RT/fhQOKE7HGW/LaReZ8lQZE4oCLxe/ie8+12POuoiIocBcinbcWaF/XNqB9sYL4i8h9q5Aacs40tRYv81gXJgVT9FTaosaWraUAZCDMZNSLYwT8izCaNsZxgBDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087699; c=relaxed/simple;
	bh=IWfGOK2afINcpSvHp4gxga/hDc6NfNOcZg7++pGrDAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Rmo3N8+sKh2u3VzpDPW2Ma5BGkJDcG8qbwre9aKZE+C5XjjQumkjkFFiPjlrvRmxgPgnCBlWZ51tmsduvbeqKD5seWw3G36ahq1yfxb1GziQZb4Tewwl+sED7lmoX3t63eftZj0MWPKacLR+z1bV3hyqw1dIJKzDreFikj7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jc4nVe9H; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709087698; x=1740623698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0z+uy/qOYkDaAl5lHxrqN9e/299YLkFgkNoApJ7Cg4=;
  b=jc4nVe9Hwk6T+lNL6i6488+89TM6vbiVF3mLYq6pFTjidTRrME1DQjvP
   Sl8LJLEKGSvhslU1n0C940eS3Tz5QWeq3pwcvu3rhpI1OzR0CE/mg/JND
   lqON+40ixMCSUjjEwnnvLhXOjC9e/1wXSQ9O1DXUc7knYcMYh2tR8hRiJ
   w=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="69260502"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 02:34:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:14192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.146:2525] with esmtp (Farcaster)
 id 7c3b9133-5de6-4ce2-ac0b-6605a9d88c37; Wed, 28 Feb 2024 02:34:56 +0000 (UTC)
X-Farcaster-Flow-ID: 7c3b9133-5de6-4ce2-ac0b-6605a9d88c37
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 02:34:55 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 02:34:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 04/14] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Tue, 27 Feb 2024 18:34:45 -0800
Message-ID: <20240228023445.28279-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d90b617800cedf03ce8d93d2df61a724f2775f56.camel@redhat.com>
References: <d90b617800cedf03ce8d93d2df61a724f2775f56.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Feb 2024 11:47:23 +0100
> On Fri, 2024-02-23 at 13:39 -0800, Kuniyuki Iwashima wrote:
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 96d0b1db3638..e8fe08796d02 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -148,6 +148,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
> >  }
> >  
> >  DEFINE_SPINLOCK(unix_gc_lock);
> > +unsigned int unix_tot_inflight;
> >  
> >  void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
> >  {
> > @@ -172,7 +173,10 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
> >  		unix_add_edge(fpl, edge);
> >  	} while (i < fpl->count_unix);
> >  
> > +	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
> >  out:
> > +	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
> 
> I'm unsure if later patches will shed some light, but why the above
> statement is placed _after_ the 'out' label? fpl->count will be 0 in
> such path, and the updated not needed. Why don't you place it before
> the mentioned label?

fpl->count is the total number of fds in skb, and fpl->count_unix
is the number of AF_UNIX fds.

So, we could reach the out: label if we pass no AF_UNIX fd but
other fds, then we count the number for each user to use in
too_many_unix_fds().

Before this change, unix_inflight() and unix_notinflight() did the
same but incremented/decremented one by one.


> 
> > +
> >  	spin_unlock(&unix_gc_lock);
> >  
> >  	fpl->inflight = true;
> > @@ -195,7 +199,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
> >  		unix_del_edge(fpl, edge);
> >  	} while (i < fpl->count_unix);
> >  
> > +	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
> >  out:
> > +	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
> 
> Same question here.
> 
> Thanks!
> 
> Paolo

