Return-Path: <netdev+bounces-189900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E333CAB4726
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BAF8C242E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53384299A81;
	Mon, 12 May 2025 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BsGPhjC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC31DFDE
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088072; cv=none; b=MPPDNpFHeud9ndZOSi/CJXDeE3iY4L+6qi0ZHo84GpDi5zCyRPPVh7qDeU8VEyVqO8Se6EBmyQFmk5Vxu/YTWPFQERcsuUWtePzQeTsJmERL/2wSXczzT9SoCMyhYbezsSHVX1/zbKoeuZOE2qPrmrxymYN/mAKwUgxKUibsor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088072; c=relaxed/simple;
	bh=KqhLIenFHmILGgCGph8vwO73knG8WbbinGrBzdi6nxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1hqy68tFWWOfe6Vs33Y7WJ+ll2wHtSYU/DxtjPg3UHdy6kTAfItYlqbQVEV7nXtXpJ45BnQI4SAeo4s1w/MznHQtxmZFoc9NY/7hMBY45/BJcGDwqKOl5MjchRE3BmJMe9cFn49NoCEHNv0y8qFTn3KVSZG8ke/7ALhpXBgE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BsGPhjC5; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747088071; x=1778624071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyMFQW0aWgAigKioYFir1mqeQgGLglnDHg6C7hcKSGo=;
  b=BsGPhjC5qgM+R5ftNhV5IugX5fs9+fmGhgI2ymqFJTcjncfObBXg2U9B
   3//3pRl8XK5gtM9LNQZCs4wW2d3aOigay1++IFH7NaPnIoqq1vQPSZlX0
   vfyzlWMXEyVzGvAaKkb2CVq0mE7P0dGAaY8+x+eJE6k1Drxtq0f1272A2
   EL3w+HcDX1aNYb6kscXWGmeJ1C6kQzQiL4QMJ9frzABu//wtQsKDWwN2I
   5ff5aQ1qmU4+LengwnvgXi77Qwq7ajTR7A51FD5l9LPSagDNdmwWU1lVZ
   hmNSTgz49/ZeyG/s0sN8SaheCLf0YtcvlOVFQpvYRv84DeiBlGOv/Cb9u
   w==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="519723300"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:14:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:5343]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.26:2525] with esmtp (Farcaster)
 id fcbd806b-1972-453c-9a94-935ecdfa1e4f; Mon, 12 May 2025 22:14:25 +0000 (UTC)
X-Farcaster-Flow-ID: fcbd806b-1972-453c-9a94-935ecdfa1e4f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:14:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:14:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Mon, 12 May 2025 15:14:01 -0700
Message-ID: <20250512221414.56633-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68224974de7ed_e985e294b5@willemb.c.googlers.com.notmuch>
References: <68224974de7ed_e985e294b5@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 15:18:12 -0400
> Kuniyuki Iwashima wrote:
> > sk->sk_txrehash is only used for TCP.
> > 
> > Let's restrict SO_TXREHASH to TCP to reflect this.
> > 
> > Later, we will make sk_txrehash a part of the union for other
> > protocol families, so we set 0 explicitly in getsockopt().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/core/sock.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index b64df2463300..5c84a608ddd7 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> >  		return 0;
> >  		}
> >  	case SO_TXREHASH:
> > +		if (!sk_is_tcp(sk))
> > +			return -EOPNOTSUPP;
> >  		if (val < -1 || val > 1)
> >  			return -EINVAL;
> >  		if ((u8)val == SOCK_TXREHASH_DEFAULT)
> > @@ -2102,8 +2104,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> >  		break;
> >  
> >  	case SO_TXREHASH:
> > -		/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > -		v.val = READ_ONCE(sk->sk_txrehash);
> > +		if (sk_is_tcp(sk))
> > +			/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > +			v.val = READ_ONCE(sk->sk_txrehash);
> > +		else
> > +			v.val = 0;
> 
> Here and in the following getsockopt calls: should the call fail with
> EOPNOTSUPP rather than return a value that is legal where the option
> is supported (in TCP).

I was wondering which is better but didn't have preference, so will
return -EOPNOTSUPP in v3.

Thanks!

