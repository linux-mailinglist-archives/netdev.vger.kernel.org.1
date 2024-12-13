Return-Path: <netdev+bounces-151636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C899F0659
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00BD18843DD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F11A8F7B;
	Fri, 13 Dec 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SAh0hqnw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A1186607
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078547; cv=none; b=Zv6s4eX1NDwZi3Pbr4ZQHhWgiLsA0z3jIbWkSo/FCV/sY3+CC9GSTYr8PPQD1d4z4AX4xcguUWr3IasptH1fMDfj/uHyXx8CmAzLyORRelOCtmBYC1+ofLsKsuVr30VEceqccl4nfi+5Txl7n62cRuu5PoKFkeE+ngWKN15fhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078547; c=relaxed/simple;
	bh=FnMpcyjg2FBluX0gx/kJJ2webgdII3ef2il+HH+r+5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOsJYl1gasthADk/rQ2yN9UDZ3jzA+SQFZvfDURzsexFUxFZD5lnYw98X/d43gmVBl2w5MoZrx6wMYkBU3D59m2GIEWE7EBhrRuSJ8CG198qnu7JE7NQuRAUSl2i3AnWIjyKzYxv+FZsXeT8u7wtHvJah8n+CQQKfOO++Z78WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SAh0hqnw; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734078546; x=1765614546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fiTxr1uDwmqdoM1VGLaCpzc1lopNylyXlAEXXQMOERQ=;
  b=SAh0hqnwVtAbbq2r3SKHUftNWvNDaJxTEAfYQlXSFiQGMIwOFLyGstoO
   /yrS8ieOt72ugoOthlAk/JEayrbQrTud8UWml20r9hSUYoL0/OSp20KMd
   +Zw4iUf93n8QFNvUptgM0fll9NBpKj+7f8yvpsJfiHO4/ZQq929pW5Xd4
   8=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="152756761"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:29:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:51926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id c6d614f7-ecd2-4c81-b19c-79e0a17fe771; Fri, 13 Dec 2024 08:29:04 +0000 (UTC)
X-Farcaster-Flow-ID: c6d614f7-ecd2-4c81-b19c-79e0a17fe771
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:29:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:28:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <allison.henderson@oracle.com>
CC: <chuck.lever@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jaka@linux.ibm.com>, <jlayton@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<matttbe@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sfrench@samba.org>, <wenjia@linux.ibm.com>
Subject: Re: [PATCH v2 net-next 12/15] socket: Remove kernel socket conversion.
Date: Fri, 13 Dec 2024 17:28:37 +0900
Message-ID: <20241213082837.7994-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <19e15f0686ed67d5d9031ae17bb0762f8a09ed77.camel@oracle.com>
References: <19e15f0686ed67d5d9031ae17bb0762f8a09ed77.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Allison Henderson <allison.henderson@oracle.com>
Date: Thu, 12 Dec 2024 17:35:39 +0000
> On Tue, 2024-12-10 at 18:20 -0800, Jakub Kicinski wrote:
> > On Tue, 10 Dec 2024 16:38:26 +0900 Kuniyuki Iwashima wrote:
> > > +	net = rds_conn_net(conn);
> > > +
> > >  	if (rds_conn_path_up(cp)) {
> > >  		mutex_unlock(&tc->t_conn_path_lock);
> > >  		return 0;
> > >  	}
> > > +
> > > +	if (!maybe_get_net(net))
> > > +		return -EINVAL;
> > 
> > FWIW missing unlock here.

Thanks for catching!


> 
> Oh, good catch!  Yes, we need a mutex unlock before the return -EINVAL.  Kuniyuki, can you send an update?  Thanks!
>

Yes, will do.

Thanks!

