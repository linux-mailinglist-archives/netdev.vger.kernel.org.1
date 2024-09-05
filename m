Return-Path: <netdev+bounces-125667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DD96E368
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E261C21A22
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA915574D;
	Thu,  5 Sep 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Oz7XJEg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD1168DC;
	Thu,  5 Sep 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565590; cv=none; b=uSgtbL7XFnFvsldf89c4plY4m1Pu899PKFi2kkxEP6hHbWfnV4PJYNlWbzKRKu+LmuKWOzm6WPLJIsUtaORqxnX6SNTY+TLWEPiYQc2Dut7SVkqYqeq+JKIGT1MUkxyLnImyjGv2E47KqZNwAycKzhcd0twMQBo8IQW8zuduptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565590; c=relaxed/simple;
	bh=f7vhiLvLNJ60w1JKC1vKGP4jsqNxW79I8VtRV1ae7TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzQp7Wrqt56zJRmrBVfN9UKEDAq54Eqsep4bimcBDwEuxY5xD8Iq5DUnin+nvjAxtoGAcvnNgnfTn98u0PWAZ8QScnH4o0jlKdikrQbI2cAWUtTEsLEwyzaVBjMZKRILUHitpiFRnyQ910TNeXPpYxHNEkHw7Kpgy8M8HHAtRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Oz7XJEg0; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725565589; x=1757101589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVNzTv1cvjZ4zdtEBWKS6o6bjZ2tLjRk+gvpLLqF7TY=;
  b=Oz7XJEg0bOs25Y0fcZE5V1QnQtc4jidgN/CbTDckGCBBLMzwU95G2unz
   Cfty/u4dWyyBCdjQBhAq+LpIyVjsoVS8JtlBqHZoGXLX96+CTiN95sREx
   hT7dr9/l4KcTF6rtvmkGZmVi4zjLR9vkEXohLxGkJrakBZfg7XF5HNKJP
   4=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="757047457"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:46:29 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:5980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.223:2525] with esmtp (Farcaster)
 id 47117716-2bc7-4b4a-9d47-e71976b37099; Thu, 5 Sep 2024 19:46:28 +0000 (UTC)
X-Farcaster-Flow-ID: 47117716-2bc7-4b4a-9d47-e71976b37099
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:46:27 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:46:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Thu, 5 Sep 2024 12:46:16 -0700
Message-ID: <20240905194616.20503-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
References: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
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
Date: Thu, 5 Sep 2024 00:35:35 -0700
> Hi All,
> 
> I am not able to reproduce the issue. I have run the C program at least 
> 100 times in a loop. In the I do get an EFAULT, not sure if that is 
> intentional or not but no panic. Should I be doing something 
> differently? The kernel version I am using is 
> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.

The -EFAULT is the bug meaning that we were trying to read an consumed skb.

But the first bug is in recvfrom() that shouldn't be able to read OOB skb
without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
something bad happens.

  socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
  sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
  recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
  sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
  recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)

I posted a fix officially:
https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/

