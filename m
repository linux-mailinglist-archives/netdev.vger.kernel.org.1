Return-Path: <netdev+bounces-119497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B124955E8E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC31C20964
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA3145A07;
	Sun, 18 Aug 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JMvLt9xa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16F208CA
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724006948; cv=none; b=b5a+BJZT3R3cAXDs7WjjZ0OM0W7z9xFtgtU6Zc8PYKz7q6EeTxWaMN8aCoA3XaKEX5hcj7HfRDDHRCJqQm6y/UX/p59tplDJ1ShPxzUC+TVMK5fVDEiVIqckoSKSYl3gLC6L3gWNEY0k3ZdDvgUtcIN5SVLdLK+F2FU/xqZ7aEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724006948; c=relaxed/simple;
	bh=N7h82PabHCcnceEZ2KBZoT701GPCZRTgUbvaMB4r+iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spAq0L10SrYruXvmWhFdim5u+2QzMQO4+sLXJeQit73xoy2rhvwxZO5JdOcCoHYX0c6/SZ/PIFFG2Dkhb+ARs59dueiN5LmRzFkzopjGER40WUWoyDcmYVM7+XarnuyOUGjMzcTk5Ntd9eCPXxhRgceZDPWNDPf3DfLBIvvb2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JMvLt9xa; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724006946; x=1755542946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXSTLv+jkobh92J9qYwFskEpFdwMFMZYKKemrQNok1o=;
  b=JMvLt9xaqdScRwnrjitYAUHkE31ksU9mmDCiUjwWiIw5+cvjyA0brw7O
   iZ8TO1X+oDTlTQ90CVhpICsZBazg5Tv2JmBJDJTb3Q3ZqBngB5Y7EPLb5
   GN56oxyVNBk8impkg2XfIKAbb0bBkofbJCQ1DeJg8NIOXT4WKdhHcf6jD
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,157,1719878400"; 
   d="scan'208";a="653207827"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 18:49:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:52995]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.118:2525] with esmtp (Farcaster)
 id e66bc0c5-4df6-47f6-8ed6-4ff484f8f83c; Sun, 18 Aug 2024 18:49:02 +0000 (UTC)
X-Farcaster-Flow-ID: e66bc0c5-4df6-47f6-8ed6-4ff484f8f83c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 18 Aug 2024 18:49:01 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 18 Aug 2024 18:48:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <0x7f454c46@gmail.com>, <davem@davemloft.net>, <dima@arista.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kernelxing@tencent.com>,
	<kuba@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple symmetry socket
Date: Sun, 18 Aug 2024 11:48:49 -0700
Message-ID: <20240818184849.56807-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 18 Aug 2024 21:50:51 +0800
> On Sun, Aug 18, 2024 at 1:16 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Sun, Aug 18, 2024 at 12:25 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Four-tuple symmetry here means the socket has the same remote/local
> > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > > $ ss -nat | grep 8000
> > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000
> 
> Thanks to the failed tests appearing in patchwork, now I'm aware of
> the technical term called "self-connection" in English to describe
> this case. I will update accordingly the title, body messages,
> function name by introducing "self-connection" words like this in the
> next submission.
> 
> Following this clue, I saw many reports happening in these years, like
> [1][2]. Users are often astonished about this phenomenon and lost and
> have to find various ways to workaround it. Since, in my opinion, the
> self-connection doesn't have any advantage and usefulness,

It's useful if you want to test simultaneous connect (SYN_SENT -> SYN_RECV)
path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && syn) case
in tcp_rcv_synsent_state_process().

  https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7

So you can't remove self-connect functionality, the recent main user is
syzkaller though.

