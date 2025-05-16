Return-Path: <netdev+bounces-191118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC4ABA1DA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962667AAF3F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD744247293;
	Fri, 16 May 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kzpw9FEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026823C4F3
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416283; cv=none; b=Zoxg8dBvzinK54oEmC/5Qf9IQ4ICQWLimGEbcpdP/GZJKqE95BKCNMvwdCVe/Id7k+qsPx3CcOAtKwihgUzfy/LLssxNP3pzf6ev8quaPgH8HlTHjL9qYYRMnrR0ol+oxMjg4wk8FhzxKPKzPJE1TDJQtx7400klcXELEHaUFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416283; c=relaxed/simple;
	bh=WlxHGGQ7gHHcG573DpzRm/jQlKK3nM6QGem7735COA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVbnBJN8L6rJCo9voygcPsV+eYNH+73KPtUW9C2nEKjz0ShGGPbbRxU+vZpN+5NZFzEOtBSErX8mViAn6ho4OgD2jB9ZhiP+W8Wzo3jcJMsjd8kxycHog+S90kGvMcY+s0zS31p/yKAGQjcZLJ+4XWJY2vq9OhaCzWS1Uz+zPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kzpw9FEQ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747416283; x=1778952283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUcyFOoyCI4Q4znaW8ONPcDdfs9Jpq8Lj/8FpAx5Wwo=;
  b=Kzpw9FEQa/s7Be1XlKUxrBR2rZXBwChBoMq4oLDsqjk9YJUEuuynQFHs
   JbcJMHmuUsmNIIoPtdBdXEtJuHqSupQg8ihfhFsNCxNHXHagty/Qp5YK6
   CEOc6PlWMnHBYDQqeSiEbU9OAd0rAcDTveERHKa/qj1Vw5AXUF/2c7tBE
   WCNiWugjXni6HFTvmC0HubNCs0aJ/UtDtr550xrkUgvPV2tXOytWS57IT
   QQS5v2/2MWqhQfpCiIUw0jhweB4F0776sEP9D/jqm996S27rsHqklqYli
   yr9b528JXCnDIrWJpxOCgItYeMhh03AU/O0XQGrkdlcyfz+s8dF83VpTw
   A==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="406098240"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:24:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:15283]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.177:2525] with esmtp (Farcaster)
 id 8819a42e-810a-461b-a409-be631e32147f; Fri, 16 May 2025 17:24:30 +0000 (UTC)
X-Farcaster-Flow-ID: 8819a42e-810a-461b-a409-be631e32147f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:24:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:24:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Fri, 16 May 2025 10:22:32 -0700
Message-ID: <20250516172419.66673-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68276c1118d32_2b92fe29428@willemb.c.googlers.com.notmuch>
References: <68276c1118d32_2b92fe29428@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 16 May 2025 12:47:13 -0400
> Kuniyuki Iwashima wrote:
> > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > are inherited from the parent listen()ing socket.
> > 
> > Currently, this inheritance happens at accept(), because these
> > attributes were stored in sk->sk_socket->flags and the struct socket
> > is not allocated until accept().
> > 
> > This leads to unintentional behaviour.
> > 
> > When a peer sends data to an embryo socket in the accept() queue,
> > unix_maybe_add_creds() embeds credentials into the skb, even if
> > neither the peer nor the listener has enabled these options.
> > 
> > If the option is enabled, the embryo socket receives the ancillary
> > data after accept().  If not, the data is silently discarded.
> > 
> > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> > would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> > descriptor was sent, it'd be game over.
> 
> Code LGTM, hence my Reviewed-by.
> 
> Just curious: could this case be handled in a way that does not
> require receivers explicitly disabling a dangerous default mode?
> 
> IIUC the issue is the receiver taking a file reference using fget_raw
> in scm_fp_copy from __scm_send, and if that is the last ref, it now
> will hang the receiver process waiting to close this last ref?
> 
> If so, could the unwelcome ref be detected at accept, and taken from
> the responsibility of this process? Worst case, assigned to some
> zombie process.

I had the same idea and I think it's doable but complicated.

We can't detect such a hung fd until we actually do close() it (*), so
the workaround at recvmsg() would be always call an extra fget_raw()
and queue the fd to another task (kthread or workqueue?).

The task can't release the ref until it can ensure that the receiver
of fd has close()d it, so the task will need to check ref == 1
preodically.

But, once the task gets stuck, we need to add another task, or all
fds will be leaked for a while.


(*) With bpf lsm, we will be able to inspect such fd at sendmsg() but
still can't know if it will really hang at close() especially if it's of
NFS.
https://github.com/q2ven/linux/commit/a9f03f88430242d231682bfe7c19623b7584505a

