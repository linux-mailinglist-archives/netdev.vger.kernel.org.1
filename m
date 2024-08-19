Return-Path: <netdev+bounces-119829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5280195729A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2945B23B3C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478B1684B9;
	Mon, 19 Aug 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oP9L5NWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F301CAAF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090553; cv=none; b=DJpKzya7TSNVmF9jhIhoaXrl0PTRBUxQprKzBNQcUKTrRX1D1ReCxv2//hlvXU3ACXa3l7uiyaSDGUEByicmboN8BBifQ1PkunMHufr+zaDls4UY1E2kQo/VwqIBSGcKrGfSDBj0Ms7kvF0+GpKZjfKCFjuPJFKIWse4caurTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090553; c=relaxed/simple;
	bh=VRHvAPebFfAseq2Kh6Ourg3/SmDHKbiJt3OL0yoVPy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9jMgdpIFctU5m+21osrBS+8cCzfp3hwq3u4Kbz8YlGh9C63APlhriSgJRQWpspLmMkKfUMlo77ZQsTgrStor0k/D+QFOO3N2jSHd3EV88mib1QmkdDcRZbT/fw558ERk/47HktU0fOM+V2KuvJByYYPNdoQf/bnLQaJRLKmxeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oP9L5NWg; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724090552; x=1755626552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xHLpj1LacH5tXh0997nWcZ7XkkBOQK3Ty8dP15MnlR4=;
  b=oP9L5NWg3q2gpqGPLqwzz+fXkvif8jmg+f2TvGJVw6wB0Ly0tuD4bVTb
   yM3/DJvujqmNBHMStw76AV//ahARh1bJZGRvMaa4tv9HQ2Y0dtb5KZ/pi
   J5ntLjJ/AjE3pbf6WvvY+WgCuCz0C9HS74pFb4OOMmyYuVob+K9nDOt1+
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="418072097"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:02:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:58375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.153:2525] with esmtp (Farcaster)
 id d0213244-1b06-4e81-bcd2-e6e134952706; Mon, 19 Aug 2024 18:02:27 +0000 (UTC)
X-Farcaster-Flow-ID: d0213244-1b06-4e81-bcd2-e6e134952706
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 18:02:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 18:02:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>,
	<tom@herbertland.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
Date: Mon, 19 Aug 2024 11:02:16 -0700
Message-ID: <20240819180216.15865-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iK60jxsJCzq29WPSZJnYNHHpPS09_ZmSi1JHmbkZ2GznA@mail.gmail.com>
References: <CANn89iK60jxsJCzq29WPSZJnYNHHpPS09_ZmSi1JHmbkZ2GznA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:56:55 +0200
> On Fri, Aug 16, 2024 at 12:04 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported UAF in kcm_release(). [0]
> >
> > The scenario is
> >
> >   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> >
> >   2. Thread A resumes building skb from kcm->seq_skb but is blocked
> >      by sk_stream_wait_memory()
> >
> >   3. Thread B calls sendmsg() concurrently, finishes building kcm->seq_skb
> >      and puts the skb to the write queue
> >
> >   4. Thread A faces an error and finally frees skb that is already in the
> >      write queue
> >
> >   5. kcm_release() does double-free the skb in the write queue
> >
> > When a thread is building a MSG_MORE skb, another thread must not touch it.
> >
> > Let's add a per-sk mutex and serialise kcm_sendmsg().
> >
> >
> > Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> > Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
> > Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> I wonder if anyone is using KCM....

Same impression :)
Maybe it's time to remove KCM.
https://lore.kernel.org/netdev/CALx6S37hSfQWw3Rku8vsavn8ejk0fndRk+=-=73gU7G-RbnK8Q@mail.gmail.com/

