Return-Path: <netdev+bounces-193245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32895AC32A0
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221897AAE52
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BD1422DD;
	Sun, 25 May 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HGrrwe/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C23234;
	Sun, 25 May 2025 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748156447; cv=none; b=Lo7BYPdjm5DRjN88oNUIPungbrVVsgtCse3RCjJGxF+1n2zuwpgUixjDIyi8cI/hL/7rWM4mdQU6fUgjdNVn8R9Gm8gQ/e/gDe0dPkNU9AZ6+i+JPRddVS9jDksJ4tQoQ9mQIKxMZr+OaFPxyITbQORBfkPDET4AzUWUWZmkdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748156447; c=relaxed/simple;
	bh=2jhL0QXKh1RgZslTy7iWdYSUV2nxJ8KPEdZsA78MxDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUHOPppNien1CqE+hK8coPNRtYHpERx4jiLMkr49O9DURdC+H7vcfWlwkzT4EZnGVCn6LNK4G1cJrC8mohUSZFvtFSj/YbDcWOftxiKLhItx5q03PvbYP9GP+2SPf2NYBna13q7m90TJW8abYfCglggU1/S2ZSWZW+5satDmvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HGrrwe/+; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748156446; x=1779692446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7IzcpyZ4IDscyT4tmmEwKrGhf7NMtKjFCxFauHO9w+Q=;
  b=HGrrwe/+2xYqRDEg0CTvV6Av2cbRoxCIkqrAJuByoF0MbDv20teyeoxF
   b7Ktv9tW0+tqlaQ92kEtiR6vRT18grMyhol82d/rmqeYzRVj0EqLscS89
   ogKnIUyUcihryKMcDfSJN293ndcQpNOIcR+kYVirr2SLszAGiQHx1raaW
   g5MjvhNwCAjA6JmtY2tYh5Z1aE0FtRiv8nJ2+ZWhzxwIKPSLfdIdWa3Qw
   WQvmQ4fT7duTs+huJoTduCDa6Z0Z74pqf4ZksGaJd2qsWGEq5J1Vzh6A7
   p9k409j/a1GsqgfKYeeICBoBdcy7FZGH4+zoilXgCQb8MkQ5eT5Ui1F2A
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,312,1739836800"; 
   d="scan'208";a="23483643"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 07:00:40 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:28949]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.109:2525] with esmtp (Farcaster)
 id f92c0e5a-4d75-408b-8fad-b9c4d97cac9a; Sun, 25 May 2025 07:00:40 +0000 (UTC)
X-Farcaster-Flow-ID: f92c0e5a-4d75-408b-8fad-b9c4d97cac9a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 25 May 2025 07:00:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 25 May 2025 07:00:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.cs.hey@gmail.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [Bug] "general protection fault in corrupted at " in Linux kernel v6.14 [sock_kmalloc() Null Pointer Dereference via CALIPSO NetLabel Processing in IPv6 SYN Request (IPv6 + SELinux + CALIPSO Path)]
Date: Sun, 25 May 2025 00:00:25 -0700
Message-ID: <20250525070028.79606-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP=Rh=MvfhrGADy+-WJiftV2_WzMH4VEhEFmeT28qY+4yxNu4w@mail.gmail.com>
References: <CAP=Rh=MvfhrGADy+-WJiftV2_WzMH4VEhEFmeT28qY+4yxNu4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 23:41:23 +0800
> Dear Linux Kernel Maintainers,
> 
> I hope this message finds you well.
> 
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.14.
> 
> Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)
> 
> Bug Location: 0010:sock_kmalloc+0x35/0x170 net/core/sock.c:2806
> 
> Bug report: https://hastebin.com/share/vewamacadi.bash
> 
> Complete log: https://hastebin.com/share/otoxiberok.perl
> 
> Entire kernel config: https://pastebin.com/MRWGr3nv

Thanks for the report.


> 
> Root Cause Analysis:
> A NULL pointer dereference occurs in sock_kmalloc() at
> net/core/sock.c:2806 due to a missing check for the validity of the sk
> pointer.
> The function attempts to retrieve the associated network namespace
> using sock_net(sk), which internally accesses sk->__sk_common.skc_net
> via read_pnet().
> However, in the specific code path triggered by an incoming IPv6 TCP
> SYN packet with NetLabel/CALIPSO security attributes, the sk structure
> is either NULL or uninitialized, resulting in a general protection
> fault.

calipso_req_{set,del}attr() fetches sk by sk_to_full_sk(req_to_sk(req)),
but req->rsk_listener could be NULL in the SYN cookie case.

Here we need to return 0 or an error to avoid the null-ptr-deref.
0 should be avoided as it bypasses LSM, but returning an error
means CALIPSO effectively disables SYN Cookie, but it will be ok
given no user has reported the null-ptr-deref for a decade.

---8<---
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 62618a058b8f..86c26316592b 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1207,6 +1207,9 @@ static int calipso_req_setattr(struct request_sock *req,
 	struct ipv6_opt_hdr *old, *new;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	if (!sk)
+		return -ENOENT;
+
 	if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
 		old = req_inet->ipv6_opt->hopopt;
 	else
@@ -1247,6 +1250,9 @@ static void calipso_req_delattr(struct request_sock *req)
 	struct ipv6_txoptions *txopts;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	if (!sk)
+		return -ENOENT;
+
 	if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
 		return;
 
---8<---



> The vulnerability is triggered via the SELinux NetLabel connection
> request hook and affects systems with IPv6 + SELinux + CALIPSO
> enabled.

