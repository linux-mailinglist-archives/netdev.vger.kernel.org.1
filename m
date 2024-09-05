Return-Path: <netdev+bounces-125696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A496E449
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B7DB20D8F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E81A2C3D;
	Thu,  5 Sep 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FhkJ0oa/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB78F54;
	Thu,  5 Sep 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568995; cv=none; b=FyRPj7dzwtUfuwDbD5soqUhKHkfa7lL6OJWmGwxHWdaN8URNZNkxbzOOyF3385yYk4XeJHA5lbXFW+IDXRp+/Uf+dI6eX+k8naFly1TftghZ60iqtTtANBfBO+mC5xfoych82HW596EOQWU76noZyKJN4CK6HWngSpMf9EgggDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568995; c=relaxed/simple;
	bh=867Pu2jXRcvxlrESkOhUiIRb/+a03q8oL66iWCoFTQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0b9mPEWc/vq6+Hf3glOO3ZQ8WV4qSomXdzM8hGTamOyZeWeAUXkAZJOi0J3feYIatmMWjBLiEcXlD0qhhcQrgugn40lrgnR3SUbT0fW7/Ov0hZCyuIn4JBUZGC+Av7FxQaCaB6uA+o+Qluya/1+gzqOXQ5a7KXCQxnYzughSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FhkJ0oa/; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725568990; x=1757104990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQOYS+xy0MsFUUO8PkTI2H4FmEcKVBnFPMsC62Zqgkg=;
  b=FhkJ0oa/qSs7YL/KBGhg2unHr+s8UlYcPClUXj8X7QNxrzN8tO1HYvir
   FYiZ7iPyYp9ijqLGQZdcJ6FXfufvqQxWe1dwsEe3XCiod9leD+8yM8NOx
   y7WMKddwq4xNqlMFc/bVM/G8gUWqFpSTYA3jiNZeHRzcJLRYMbMwxD5DV
   4=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="421937967"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:43:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:62873]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.196:2525] with esmtp (Farcaster)
 id 9402953f-6d42-4540-8675-40ca75e960f3; Thu, 5 Sep 2024 20:43:01 +0000 (UTC)
X-Farcaster-Flow-ID: 9402953f-6d42-4540-8675-40ca75e960f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 20:43:01 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 20:42:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Thu, 5 Sep 2024 13:42:49 -0700
Message-ID: <20240905204249.27077-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <68873c3c-d1ec-4041-96d8-e6921be13de5@oracle.com>
References: <68873c3c-d1ec-4041-96d8-e6921be13de5@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Thu, 5 Sep 2024 13:37:06 -0700
> On 9/5/2024 1:15 PM, Shoaib Rao wrote:
> >
> > On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
> >> From: Shoaib Rao <rao.shoaib@oracle.com>
> >> Date: Thu, 5 Sep 2024 00:35:35 -0700
> >>> Hi All,
> >>>
> >>> I am not able to reproduce the issue. I have run the C program at least
> >>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> >>> intentional or not but no panic. Should I be doing something
> >>> differently? The kernel version I am using is
> >>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
> >> The -EFAULT is the bug meaning that we were trying to read an 
> >> consumed skb.
> >>
> >> But the first bug is in recvfrom() that shouldn't be able to read OOB 
> >> skb
> >> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
> >> something bad happens.
> >>
> >>    socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> >>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
> >> msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, 
> >> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
> >>    recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, 
> >> msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, 
> >> MSG_OOB|MSG_WAITFORONE) = 1
> >>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
> >> msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, 
> >> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
> >>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, 
> >>> NULL) = 1
> >>    recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad 
> >> address)
> >>
> >> I posted a fix officially:
> >> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$ 
> >>
> >
> > Thanks that is great. Isn't EFAULT,  normally indicative of an issue 
> > with the user provided address of the buffer, not the kernel buffer.
> >
> > Shoaib
> >
> Can you provide the full test case that you used to reproduce the issue.

I used the syzbot's repro, but you can check a new test case added
in my patch.

