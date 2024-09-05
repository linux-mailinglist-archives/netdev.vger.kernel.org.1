Return-Path: <netdev+bounces-125701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6596E494
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD91F26EEC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94F1A4E9C;
	Thu,  5 Sep 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N/moXsxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAF19306D;
	Thu,  5 Sep 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570245; cv=none; b=sfqBLRXoxY5BMDdyjttdqP1hmN3YjW3XV7guB7WWBKPi7u2BcrBIKviHvSCBpxL0K9AlcyM8L3agRSnpP11bYYSA26vd3+NWgQV47kDwU85MZeM4Hoee9a072DdsfnbBMWwtA8rCD6wx+1e2RIJ4s7kuZp/eXULXoYhQzu5NIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570245; c=relaxed/simple;
	bh=/5UzigxtKUU3fXq7e8cH4FMXDWhPoqRCyKrxRwvP2Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GahGO+i9u6XbjIWxC0U/R4NBZLxlCRkql+cr9nrEFuH7HL+FQKjPifPU6GPB/Pmyssr/1k4ut/A4q7yjK6eEOzgw7sIO22sX+6EOVyNF2nnE5oKhEWI9D7M07uIrKBRJJ6cM4eAJ575lPr3XyjIZGsdTTAPy73FuB39mZ5WOnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N/moXsxf; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725570243; x=1757106243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZ9MShwTh6wxM6C1t33CKEgAZtHExCAmt67BPNPyZvc=;
  b=N/moXsxfnQukJWLrPNWz227PYhBWDK3Lh3ZoaoIJs9xNw9I6QYyWQsHX
   Z5Jc8M+9OaFmhWhy43QSOZVu4GygOIgEL+Bj4/kcQoDE2++9SpTLZtg/B
   fcnHRRNoMyzO3mCQqc4/17CCMNB13CLYaeOoA+QS054bTfz0Tsf5Ok1kh
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="122726726"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 21:04:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23126]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.84:2525] with esmtp (Farcaster)
 id 6c245a1e-1afd-4273-a186-f2e34300ff4c; Thu, 5 Sep 2024 21:04:01 +0000 (UTC)
X-Farcaster-Flow-ID: 6c245a1e-1afd-4273-a186-f2e34300ff4c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 21:04:01 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 21:03:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Thu, 5 Sep 2024 14:03:49 -0700
Message-ID: <20240905210349.29835-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
References: <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Thu, 5 Sep 2024 13:48:16 -0700
> On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Thu, 5 Sep 2024 13:15:18 -0700
> >> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
> >>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>> Date: Thu, 5 Sep 2024 00:35:35 -0700
> >>>> Hi All,
> >>>>
> >>>> I am not able to reproduce the issue. I have run the C program at least
> >>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> >>>> intentional or not but no panic. Should I be doing something
> >>>> differently? The kernel version I am using is
> >>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
> >>> The -EFAULT is the bug meaning that we were trying to read an consumed skb.
> >>>
> >>> But the first bug is in recvfrom() that shouldn't be able to read OOB skb
> >>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
> >>> something bad happens.
> >>>
> >>>     socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> >>>     sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
> >>>     recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
> >>>     sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
> >>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
> >>>     recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
> >>>
> >>> I posted a fix officially:
> >>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
> >> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
> >> with the user provided address of the buffer, not the kernel buffer.
> > Normally, it's used when copy_to_user() or copy_from_user() or
> > something similar failed.
> >
> > But this time, if you turn KASAN off, you'll see the last recvmsg()
> > returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
> > on your host, I guess.
> 
> No it did not work. As soon as KASAN detected read after free it should 
> have paniced as it did in the report and I have been running the 
> syzbot's C program in a continuous loop. I would like to reproduce the 
> issue before we can accept the fix -- If that is alright with you. I 
> will try your new test case later and report back. Thanks for the patch 
> though.

The splat is handy, you may want to check the returned value of recvfrom()
with KASAN on and off and then focus on the root cause.  When UAF happens,
the real bug always happens before that.

FWIW, I was able to see the splat on my setup and it disappeared with
my patch.  Also, syzbot has already tested the equivalent change.
https://lore.kernel.org/netdev/00000000000064fbcb06215a7bbc@google.com/

