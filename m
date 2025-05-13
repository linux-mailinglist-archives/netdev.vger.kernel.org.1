Return-Path: <netdev+bounces-189964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFCAB49EC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C597466CF9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC741AED5C;
	Tue, 13 May 2025 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LfzBnkw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166129CE8
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105928; cv=none; b=kBkFQvGZcWseYppAdprut/Sldi2X2SrulSwCYtIstxY2SyQyXI/E/60QddFHHKcQhDDrdfYXj31KjmCc9MeAJNECuC7qUCkugC44xMP2Qp6XARLvsA1NPc+T58dU4KHbJI6d+E5xezS9v7YI9WMLF4YbmFs+Gb37l4vT3zp6UfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105928; c=relaxed/simple;
	bh=7G3uMX7P0wFDA5v678FEDVOPMDeUneT/VLmdfw/W6uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr3hVSFo69IPqO9KjGC8D87YYoNnDxsuRKPO0WtApwtevcNOh+4OFCBKvx6coQCqPKl8xVhiUzJ8Vu+NcSXypKmV0wcLcePk6YU5gV+PFNA1Eb3ONTSlZ8EPgEVYowAMVwGEBRnG/iM3yrCHiRHD9/CiMAVxfqE6NDkav5FlViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LfzBnkw1; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747105928; x=1778641928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/LuJNhAtxZXL4qJy3M/Z7Jd4urTAV6l4xLxiVNq/Uc=;
  b=LfzBnkw1hK5TFDp/Kgl3MMe54MN4Lh29zhBG+Z1gYP83sgVRapR+Wfuz
   aHQ5bM3yAbq2ABTYJM7a4uVGMQfIrXHEL7BBH3RjmgHFxGmpPYh9njTrD
   +Dls/LrUJMQB4b4UDFSx3Ond888c7/6iVGyyi7OgIxkywso1csr0VdOA6
   cUtrFqDCSn1ah6DU1snisuhysB8a0daV6v1y+xbFnVEqjFSKujcLHWO1P
   3EVil+Edu8svICT66w7Oh9FuaIOwPixQSdqnodyIEXkr+n3Ps0pUweHye
   PVCgSp3AWnFrDz4chD/hc8JyVi3xHJqwFtL1kFXi4z39z2avOWbrF06Ts
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,284,1739836800"; 
   d="scan'208";a="743926016"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:12:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:55061]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.127:2525] with esmtp (Farcaster)
 id 2c0b16f1-4ead-438d-a315-c760a34ce05a; Tue, 13 May 2025 03:12:02 +0000 (UTC)
X-Farcaster-Flow-ID: 2c0b16f1-4ead-438d-a315-c760a34ce05a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:12:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:11:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Mon, 12 May 2025 20:11:18 -0700
Message-ID: <20250513031151.94700-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6822b191d0399_104f1029490@willemb.c.googlers.com.notmuch>
References: <6822b191d0399_104f1029490@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 22:42:25 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Mon, 12 May 2025 15:18:12 -0400
> > > Kuniyuki Iwashima wrote:
> > > > sk->sk_txrehash is only used for TCP.
> > > > 
> > > > Let's restrict SO_TXREHASH to TCP to reflect this.
> > > > 
> > > > Later, we will make sk_txrehash a part of the union for other
> > > > protocol families, so we set 0 explicitly in getsockopt().
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/core/sock.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index b64df2463300..5c84a608ddd7 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > > >  		return 0;
> > > >  		}
> > > >  	case SO_TXREHASH:
> > > > +		if (!sk_is_tcp(sk))
> > > > +			return -EOPNOTSUPP;
> > > >  		if (val < -1 || val > 1)
> > > >  			return -EINVAL;
> > > >  		if ((u8)val == SOCK_TXREHASH_DEFAULT)
> > > > @@ -2102,8 +2104,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> > > >  		break;
> > > >  
> > > >  	case SO_TXREHASH:
> > > > -		/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > > > -		v.val = READ_ONCE(sk->sk_txrehash);
> > > > +		if (sk_is_tcp(sk))
> > > > +			/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > > > +			v.val = READ_ONCE(sk->sk_txrehash);
> > > > +		else
> > > > +			v.val = 0;
> > > 
> > > Here and in the following getsockopt calls: should the call fail with
> > > EOPNOTSUPP rather than return a value that is legal where the option
> > > is supported (in TCP).
> > 
> > I was wondering which is better but didn't have preference, so will
> > return -EOPNOTSUPP in v3.
> 
> It's a reminder that this is breaking an existing API.
> 
> It is unlikely to affect any real users in this case, as SO_TXREHASH
> never was function for Unix sockets. But for this and subsequent such
> changes we have to be aware that it is in principle a user visible
> change.

I agree it's unlikely, and given we recently added 5b0af621c3f6 ("net:
restrict SO_REUSEPORT to inet sockets"), I think this type of change
is okay where it's appropriate.

And I noticed 5b0af621c3f6 didn't change getsockopt().

