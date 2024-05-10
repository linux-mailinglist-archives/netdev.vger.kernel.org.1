Return-Path: <netdev+bounces-95395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBF8C2285
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8391F2176A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0A1607AC;
	Fri, 10 May 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vxkx7PKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F321340
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338456; cv=none; b=eSFVAHmqiDYeBfn/n1mtqKT23j1txit9mITmzIfG/nA4zpqfwR0ehptdYXGw5CWTck5HmtPWg8x/PR4dRY2We6DxFh1EqGRGje7KxTTkGbozvmManov7PEVEUEG27LdzTQ3I7DKw2tKLxrnMTcTUjGlfay7PpYYmyuAjrqu/g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338456; c=relaxed/simple;
	bh=MO/OM/2fhj7aCEeAt1aUngS9eTccDVaXZdZMNYXF4XA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brfz66fRLuYGs8oXKTwZvms/BWufLZrOBxfS5lxDc4llyaSstVX474b2nRNlzUo7u4UQK1gHutK2BCbfe0pgrHtwGCYX4moYVjv97c95nxgkPIMWEm9DdmOXNPcnAXmYZD1XqRGP3l5Arc70x7tM3LLitj5uQK/OWluOhkcZ6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vxkx7PKd; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715338455; x=1746874455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvhr7yzdAZc0C53lsqLNl4G66CvqbeF4DDof8k8rgGY=;
  b=Vxkx7PKdv1EiVGsTTDzn5kf0zuZ16xPIq9I6MbkQVVvBm31h0dfpJ/mk
   fzmTZ2Zb35qtgrcGtFIimZku6Jt268VEvvEixuPaRPDrCY6Sh5pY8JIOY
   QU2fQS2lSWcCvNjpQ7CM3tz+eg2Oc8h+NDame0v5WKX9TKN1ZHfLqHJsL
   c=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="294221602"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:54:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:17234]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.40:2525] with esmtp (Farcaster)
 id 2e030f83-5101-49ad-a75d-463b14a4939f; Fri, 10 May 2024 10:54:12 +0000 (UTC)
X-Farcaster-Flow-ID: 2e030f83-5101-49ad-a75d-463b14a4939f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 10:54:11 +0000
Received: from 88665a182662.ant.amazon.com (10.119.9.22) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 10:54:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Fri, 10 May 2024 19:54:00 +0900
Message-ID: <20240510105400.32158-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6dfcdb8b562c567995ae9786ab399a1f3a24c62a.camel@redhat.com>
References: <6dfcdb8b562c567995ae9786ab399a1f3a24c62a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 10 May 2024 12:44:58 +0200
> On Fri, 2024-05-10 at 18:39 +0900, Kuniyuki Iwashima wrote:
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 0104be9d4704..b87e48e2b51b 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
> >  		scan_children(&u->sk, inc_inflight, &hitlist);
> >  
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > +		spin_lock(&u->sk.sk_receive_queue.lock);
> >  		if (u->oob_skb) {
> > -			kfree_skb(u->oob_skb);
> > +			WARN_ON_ONCE(skb_unref(u->oob_skb));
> 
> Sorry for not asking this first, but it's not clear to me why the above
> change (just the 'WARN_ON_ONCE' introduction) is needed and if it's
> related to the addressed issue???

I think I added it to make it clear that here we don't actually free skb
and consistent with manage_oob().

But I don't have strong preference as it will be removed soon.

