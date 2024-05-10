Return-Path: <netdev+bounces-95308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4E8C1D88
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E6FB2211B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426714D716;
	Fri, 10 May 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aWuljZuI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC356757
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317437; cv=none; b=XbfLj1Unvsrh4kYSno8ORlRQVME00XlIDlJX7P6vzXy+69x3ON4PmH78kc9ZpnCSMFEqCfLLI7Wn6bMa1H9ixX3BQMtHtbkFEJC7STWLWWJ+I6frjYc+QJVRUqyQq7xi+nfkAWF2edhQ69Ws7VIZucKHd6G/VgZAV1XV7INpxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317437; c=relaxed/simple;
	bh=HsJUzFdytZK5U9W6S/GSLYW0Snza17BYIh+KM0u2VH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7HYpTNVNUvqPwN3GQ+vGZ3mALulxs/5LKPpxfFoib3QBD5KFWL+i+QuG85yojEmqoj84y2guh1DI1pqYbpnmPWowAx/ga9bFhJGHau6N94UmdCzfOkckJfvGCtr9elK1tTIfhcad46I4ncg6dqfm65cICrV1ahYuaFf0m6PS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aWuljZuI; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715317435; x=1746853435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMuGFJG1b6rtKYOt0wVoeCv/GVMZcZluq4T4uTO10Qg=;
  b=aWuljZuIwz3bDHI8glG8x3FiO7hniUa4mBAhZfFSKPgZUF45M3GllJjn
   fa2IUdZT3Vjv0zqI+Ps5Ld3H2vwGgNkZB1/xDAZwVOqtzX8PT93Gr0qNJ
   z5wKncA58IvTOPY578xaBIiq8hSxT+eb8YoiRYDS3daxCnr3D2Grtp7BO
   o=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="88215251"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:03:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:3029]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.40:2525] with esmtp (Farcaster)
 id 697d5bb9-a956-4bb0-b426-a187e4426851; Fri, 10 May 2024 05:03:53 +0000 (UTC)
X-Farcaster-Flow-ID: 697d5bb9-a956-4bb0-b426-a187e4426851
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 05:03:53 +0000
Received: from 88665a182662.ant.amazon.com (10.119.0.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 05:03:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Fri, 10 May 2024 14:03:41 +0900
Message-ID: <20240510050341.27782-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8015f2f2fec7d5a5a7164e1480d0e0c18b925f61.camel@redhat.com>
References: <8015f2f2fec7d5a5a7164e1480d0e0c18b925f61.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 09 May 2024 11:12:38 +0200
> On Tue, 2024-05-07 at 10:00 -0700, Kuniyuki Iwashima wrote:
> > Billy Jheng Bing-Jhong reported a race between __unix_gc() and
> > queue_oob().
> > 
> > __unix_gc() tries to garbage-collect close()d inflight sockets,
> > and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
> > will drop the reference and set NULL to it locklessly.
> > 
> > However, the peer socket still can send MSG_OOB message to the
> > GC candidate and queue_oob() can update unix_sk(sk)->oob_skb
> > concurrently, resulting in NULL pointer dereference. [0]
> > 
> > To avoid the race, let's update unix_sk(sk)->oob_skb under the
> > sk_receive_queue's lock.
> 
> I'm sorry to delay this fix but...
> 
> AFAICS every time AF_UNIX touches the ooo_skb, it's under the receiver
> unix_state_lock. The only exception is __unix_gc. What about just
> acquiring such lock there?

In the new GC, there is unix_state_lock -> gc_lock ordering, and
we need another fix then.

That's why I chose locking recvq for old GC too.
https://lore.kernel.org/netdev/20240507172606.85532-1-kuniyu@amazon.com/

Also, Linus says:

    I really get the feeling that 'sb->oob_skb' should actually be forced
    to always be in sync with the receive queue by always doing the
    accesses under the receive_queue lock.

( That's in the security@ thread I added you, but I just noticed
  Linus replied to the previous mail.  I'll forward the mails to you. )


> Otherwise there are other chunk touching the ooo_skb is touched where
> this patch does not add the receive queue spin lock protection e.g. in
> unix_stream_recv_urg(), making the code a bit inconsistent.

Yes, now the receive path is protected by unix_state_lock() and the
send path is by unix_state_lock() and recvq lock.

Ideally, as Linus suggested, we should acquire recvq lock everywhere
touching oob_skb and remove the additional refcount by skb_get(), but
I thought it's too much as a fix and I would do that refactoring in
the next cycle.

What do you think ?

