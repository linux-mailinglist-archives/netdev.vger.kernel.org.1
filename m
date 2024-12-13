Return-Path: <netdev+bounces-151660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D19F07D2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD11882BE1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394001B0F09;
	Fri, 13 Dec 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rP64M033"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3D1B0F00
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081916; cv=none; b=SssTKW0RHJUsDN/j6ItspEvY8fIetxlFdGPZj780sHP5tZFfhgZmf3qPRlcoWkfPoMcMTpHnY5Z8XOqu9I14g25ZA+X7RaxC3Dmz7acwbM/ZckI+lEGlvYsXT72aEUfmFtOKE/045nzW86XZD/0fbGAL2iKbih+AoifDGVWXYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081916; c=relaxed/simple;
	bh=Zm9Jq7/V9XZzH/Uk0XlPQKc117CUqd7wpFFdyxWlAVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3MNuxx7NfUQJBrf0K8e7m8NRACLupgy+9zdmERbW8RHeNCt6/BrmKACvSnn2PZ04kfXma3pvJ5FLzYaeuCikTs8zxizY9Tv//XRx4plepnM3qegzG5BuxFhozzV5bHZdXR8Opa9HRfOQe6jrwHJg6iqjAGdw7VtTGBcvAPtCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rP64M033; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081916; x=1765617916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MpC9Ly06tWsEP+CE7s+uh4xvlVu/hDAy6+FXQn72DoY=;
  b=rP64M033RFuNkFqnEAUpE80/vOxLFUslY6xEaN2hEQOszNlOMK8p9vn2
   OCPVfZkLNU1Lnyu9hwSLX+/J8A5uje1V/YpGvAMz7xQ2YqX74osDMHI8D
   ZWjXIuAGIJCH9w5giBiZBv6mjHXgJu40HE0EdcpyBzAoqjgtgwQ8xH5P4
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="783117709"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:25:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:25184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.5:2525] with esmtp (Farcaster)
 id 2df75f3d-2150-4d8e-a77d-a40bb47867fa; Fri, 13 Dec 2024 09:25:11 +0000 (UTC)
X-Farcaster-Flow-ID: 2df75f3d-2150-4d8e-a77d-a40bb47867fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:11 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 09/15] socket: Respect hold_net in sk_alloc().
Date: Fri, 13 Dec 2024 18:21:46 +0900
Message-ID: <20241213092152.14057-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213092152.14057-1-kuniyu@amazon.com>
References: <20241213092152.14057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns
refcnt held.

sk->sk_net_refcnt was set to 0 when kern was 1 in sk_alloc().

Now we have the hold_net flag in sk_alloc().

Let's set it to sk->sk_net_refcnt and add an assertion to catch
only one illegal pattern.

No functional change is introduced for now because currently
hold_net == !kern.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8546d97cc6ec..11aa6d8c0cdd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2224,9 +2224,12 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		 * why we need sk_prot_creator -acme
 		 */
 		sk->sk_prot = sk->sk_prot_creator = prot;
+
+		DEBUG_NET_WARN_ON_ONCE(!kern && !hold_net);
 		sk->sk_kern_sock = kern;
 		sock_lock_init(sk);
-		sk->sk_net_refcnt = kern ? 0 : 1;
+
+		sk->sk_net_refcnt = hold_net;
 		if (likely(sk->sk_net_refcnt)) {
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
-- 
2.39.5 (Apple Git-154)


