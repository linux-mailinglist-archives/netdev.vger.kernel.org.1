Return-Path: <netdev+bounces-192411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E5ABFCA1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DD34E8344
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28B26462A;
	Wed, 21 May 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BAF37v0b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A7231A3B;
	Wed, 21 May 2025 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851051; cv=none; b=O06aniRNGnzZPDv6Hrow7e7dr7WA2OQXKwPnAsvhb2vf4TDqNbrqqqON5xGmSMQljclu67IRTyeUxYtE+GWCVAgwkwdIdRdJEwN/YWeegXqp2auKr8z4+8ktIlun2LTJlktBa6Z3aCuDwOW0fcN0sW4TNOHxH8zTSPSC0kJfJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851051; c=relaxed/simple;
	bh=Ja9FUurKvoLNhRg6VryUifWCri778qJhxOwLPadH5sk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmtzXwWVf3nCcc9IYXS3w+XI8f3AbhPSkYt867pGe34vbcuCPk5HgvtK7EQ4CgIJgLfE0OB9wm3t50peBPsnHrp4Tt/PUsidR52UMtx8pozRnhTeRK4v6GJT7SsO6wCU8cGdyEHG1r82z4Hm5CveIGnllalsmSa6g15HG3rNJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BAF37v0b; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747851049; x=1779387049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lqaKRMn9Y61ZMcGQCu5I5Bk7vV0gkXoSTtlGN9WxCI=;
  b=BAF37v0bRwTdriJZcpPDT4oalRs5Tf8agCTG+WogZeFYeaX+Aj2j7XAO
   tWfw0AI0bvXOcBCGjxpkSnmQVWTl3hXntQlxMhtqNpfOJ8DqIyJ1VNCvg
   UU+1QnuaBU+fUuQ5J2BiHh1DVPXTYdXzFUWw5WwrCG4aje7sc9ks2h/wG
   ffg0YlSjPccvfyeoiNJKMgognluXkIP9L9Gc/ohUVqxfcoY0GV5+FfLHy
   2MSsPjLQ6K+Urfbh8jFYC5U3jVZ5wXT4DKPEsg8j+kn5mMNYVqqpr4Ry9
   1GXoARYpayw2uTE7AgcJMkj/oc0txVEdlMk8O2IPVD/N4Wg331PjzR0Cc
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="22321835"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 18:10:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:62904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.121:2525] with esmtp (Farcaster)
 id a3c8e3af-5f1b-4900-aae2-5c02fe40f192; Wed, 21 May 2025 18:10:36 +0000 (UTC)
X-Farcaster-Flow-ID: a3c8e3af-5f1b-4900-aae2-5c02fe40f192
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:10:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:10:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.cs.hey@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [Bug] "general protection fault in calipso_sock_setattr" in Linux kernel v6.12
Date: Wed, 21 May 2025 11:08:09 -0700
Message-ID: <20250521181024.44883-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com>
References: <CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:50:38 +0800
> Dear Linux Kernel Maintainers,
> 
> I hope this message finds you well.
> 
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.12.
> 
> Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
> 
> Bug Location: calipso_sock_setattr+0xf6/0x380 net/ipv6/calipso.c:1128
> 
> Bug report: https://hastebin.com/share/iredodibar.yaml
> 
> Complete log: https://hastebin.com/share/biqowozonu.perl
> 
> Entire kernel config: https://hastebin.com/share/huqucavidu.ini

Thanks for the report.


> 
> Root Cause Analysis:
> The crash is caused by a NULL pointer dereference in txopt_get() (at
> include/net/ipv6.h:390) due to an uninitialized struct inet6_opt *opt
> field.

This is not correct.  The splat says the null deref happens at
np->opt.

> RIP: 0010:txopt_get root/zhangqiang/kernel_fuzzing/Drivers_Fuzz/linux-6.12/include/net/ipv6.h:390 [inline]

   385	static inline struct ipv6_txoptions *txopt_get(const struct ipv6_pinfo *np)
   386	{
   387		struct ipv6_txoptions *opt;
   388	
   389		rcu_read_lock();
   390		opt = rcu_dereference(np->opt);

and the offset is 0x70, which is of opt in struct ipv6_pinfo.

> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]

$ python3
>>> 0x70
112

$ pahole -C ipv6_pinfo vmlinux
struct ipv6_pinfo {
...
	struct ipv6_txoptions *    opt;                  /*   112     8 */


np + 0x70 = 0x70, meaning np was NULL here.

np is always initialised for IPv6 socket in inet6_create(), so this
should never happens for IPv6 sockets.

But looking at netlbl_conn_setattr(), it swtiched branch based on
sockaddr.sa_family provided by userspace, and it does not check if
the socket is actually IPv6 one.

So, the fix will be:


diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cd9160bbc919..067f707f194d 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		if (sk->sk_family != AF_INET6)
+			return -EPROTONOSUPPORT;
+
 		addr6 = (struct sockaddr_in6 *)addr;
 		entry = netlbl_domhsh_getentry_af6(secattr->domain,
 						   &addr6->sin6_addr);


> The function is indirectly invoked during an SELinux policy
> enforcement path via calipso_sock_setattr(), which expects an
> initialized inet6_sk(sk)->opt structure.
> However, the socket in question does not have IPv6 tx options set up
> at the time of the call, likely due to missing or out-of-order
> initialization during socket creation or connection setup.
> This leads to an invalid access at offset +0x70, detected by KASAN,
> and results in a general protection fault.
> 
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.

Try setting CALIPSO and calling connect(IPv6 addr) for IPv4 socket.


> 
> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.

Could you provide your full name so that I can give proper credit
in Reported-by tag ?


