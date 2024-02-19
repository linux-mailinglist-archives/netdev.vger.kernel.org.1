Return-Path: <netdev+bounces-73111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6885AF40
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32E7280D8A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58351535DB;
	Mon, 19 Feb 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s/ojOm0m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6368535D1
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383392; cv=none; b=qImt19FuekCrGK9jaZ5rX8AmoLU3dVIRXKlgb/Kh1JQ5gJQXYZ7g417YY78pI0EiPDCmCVFROlNz6Klqt6NkJlqdgNckR/mefqbBukZUf1Elv7/Qz7bcm5aiJ4xC2BPV+nL1CBXe3klUZsJWXU76UMIoINbycXnXGp9ipv1DhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383392; c=relaxed/simple;
	bh=uMVthBaDAkle+sMj2tdLnQcOMraag2PQa4XWHgqy49Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJg338W+aJsJ3zD8V9ZEv5w0dovGfR3FkzFvH4XYvY7nzELOFR+f9eRD1L8UAFupNfdfOYGNQQXzz9hG/Fkl9d+ZR5AKBjIvvFsgdHa4kdnjxWic/ip78SEA1VZ4JkqE7M4ZP1z2pk7Ok5tIY82RjwRe9Av936C0DuuPTrWaemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s/ojOm0m; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708383391; x=1739919391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcagesCSKmF2c8GuZX/cZfkHUF6s2p92lJpDi/xVi1E=;
  b=s/ojOm0mmg62msW9x5c/Xauizuv9Ad6J5pwmyA24UD836teQ1+87/9cx
   S3xw/YiqqoXDNutu6BXe7J4aoF3Ciy9PUGupxDrXQx9zizfM5/+HI/+Sb
   noV8o+fXJV30K4ANsxaJZgR5HvBAfJgFBp7oDa6IakoXf+bs5E/Ndy7Vu
   4=;
X-IronPort-AV: E=Sophos;i="6.06,171,1705363200"; 
   d="scan'208";a="705333703"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:56:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:46043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 1ebbaac1-7002-41d7-b6e5-86ae51371378; Mon, 19 Feb 2024 22:56:24 +0000 (UTC)
X-Farcaster-Flow-ID: 1ebbaac1-7002-41d7-b6e5-86ae51371378
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 22:56:23 +0000
Received: from 88665a182662.ant.amazon.com (10.94.72.56) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 22:56:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Date: Mon, 19 Feb 2024 14:56:11 -0800
Message-ID: <20240219225611.38239-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <65d38de7959f9_1f98e529449@willemb.c.googlers.com.notmuch>
References: <65d38de7959f9_1f98e529449@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 19 Feb 2024 12:20:39 -0500
> Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 5:07 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Eric Dumazet wrote:
> > > > syzbot reported a lockdep violation [1] involving af_unix
> > > > support of SO_PEEK_OFF.
> > > >
> > > > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > > > sk_peek_off field), there is really no point to enforce a pointless
> > > > thread safety in the kernel.
> > >
> > > Would it be sufficient to just move the setsockopt, so that the
> > > socket lock is not taken, but iolock still is?
> > 
> > Probably, if we focus on the lockdep issue rather than the general
> > SO_PEEK_OFF mechanism.
> > 
> > We could remove unix_set_peek_off() in net-next,
> > unless someone explains why keeping a locking on iolock is needed.

Probably to avoid a small race where setsockopt() does not take effect.

                                    sk_peek_offset_bwd
  setsockopt                        |- off = READ_ONCE(sk_peek_off)
  `- WRITE_ONCE(sk_peek_off, val)   |
                                    `- WRITE_ONCE(sk_peek_off, off - val)

> 
> Since calling SO_PEEK_OFF and recvmsg concurrently is inherently not
> thread-safe, fine to remove it all.

Agreed, we can do that locklessly.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

