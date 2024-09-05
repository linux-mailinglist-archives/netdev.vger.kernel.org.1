Return-Path: <netdev+bounces-125691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DCC96E42B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754501F237DD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E9193434;
	Thu,  5 Sep 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fXiZzQEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F617741;
	Thu,  5 Sep 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568544; cv=none; b=f3ik9cFH78Y2JNHFyZdXF7rtehwVxKV1Eo0sUheJcvZW4SC+GTzrAH0ACtELqU2zLOpXJHVkLX/YBBXbXg1OqiaViNboyaxXB5XbPwCId9lMyBoy5E5jTDuJHgyKGOmNUHJ/A18ufpYSh5XYxGf0lxMqcKbTuX937/nfQLQAcrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568544; c=relaxed/simple;
	bh=V9zzLGI0CJoWL/TyWGq3XKvRDTDaJlt9oN84ZvdjKdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AH2DtP+yjfgiOSqcHI0HFJCIjnyz/ixZSsK211iHiDDGg0AmzVpo5zJNTNKBLix7GSeLqs02kdZ5w3J0Ja7mJKxp2x+8xEkMWqUuV+MI8nVSoT4be5dwz5TlKj6rxrM1CxEhgDDgjg7g0aViYVrEsr1MihYf6knHlMhN6boiudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fXiZzQEy; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725568544; x=1757104544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iUGMUA7J3qICfhohJxC0ebd8fD9piK6yrYaWXX289k=;
  b=fXiZzQEyDn7s/WG6Bus4+Yf5lHgCST+84Vwjcdqdx1n6heQy8BrDRwbf
   A42kIpyw1OFQK5V8rQGzV9QXYHyMAjdXnHfQz8APuolJPfOiYUiizE6c+
   i1mNfLzWHhlDHmC+R+27+hlyE/n6T4dCNRAbdaa+wd8Yxh2hlFWANiebZ
   M=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="757063664"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:35:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:14282]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.90:2525] with esmtp (Farcaster)
 id c55b94cc-da0e-4245-9cb1-625bfa867e0e; Thu, 5 Sep 2024 20:35:37 +0000 (UTC)
X-Farcaster-Flow-ID: c55b94cc-da0e-4245-9cb1-625bfa867e0e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 20:35:37 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 20:35:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Thu, 5 Sep 2024 13:35:25 -0700
Message-ID: <20240905203525.26121-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Thu, 5 Sep 2024 13:15:18 -0700
> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Thu, 5 Sep 2024 00:35:35 -0700
> >> Hi All,
> >>
> >> I am not able to reproduce the issue. I have run the C program at least
> >> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> >> intentional or not but no panic. Should I be doing something
> >> differently? The kernel version I am using is
> >> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
> > The -EFAULT is the bug meaning that we were trying to read an consumed skb.
> >
> > But the first bug is in recvfrom() that shouldn't be able to read OOB skb
> > without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
> > something bad happens.
> >
> >    socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> >    sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
> >    recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
> >    sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
> >> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
> >    recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
> >
> > I posted a fix officially:
> > https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
> 
> Thanks that is great. Isn't EFAULT,  normally indicative of an issue 
> with the user provided address of the buffer, not the kernel buffer.

Normally, it's used when copy_to_user() or copy_from_user() or
something similar failed.

But this time, if you turn KASAN off, you'll see the last recvmsg()
returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
on your host, I guess.

