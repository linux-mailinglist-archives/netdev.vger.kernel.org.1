Return-Path: <netdev+bounces-32694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402337996A9
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D0281B31
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22A30FAF;
	Sat,  9 Sep 2023 07:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010A370
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 07:05:43 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B71BF9
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694243141; x=1725779141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zKhu7vHoHaDwWV88WyTFZOWD++2iw/TYqJR9jHjppn4=;
  b=vfYnW1ojGMWdX5xJ8OgrpAbfk98vfjBj9CZ3RoTGW8sc8BE9v3XW7z4O
   aAH1kxO9sWxKwgIIMCUED4zMvG3Kz+QJE+ENijAhQ2ccHIEGZ3FCMJvFA
   kSUEPy6VhjfJvSha34HN/9OUYiVDPIp42xwLqDbl6A56orAV2lksT2lIx
   s=;
X-IronPort-AV: E=Sophos;i="6.02,239,1688428800"; 
   d="scan'208";a="237672379"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 07:05:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 0732440D52;
	Sat,  9 Sep 2023 07:05:33 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 9 Sep 2023 07:05:32 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Sat, 9 Sep 2023 07:05:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <avagin@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <glider@google.com>,
	<joannelkoong@gmail.com>, <kafai@fb.com>, <kernel-team@fb.com>,
	<kuba@kernel.org>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] net: Fix incorrect address comparison when searching for a bind2 bucket
Date: Sat, 9 Sep 2023 00:05:20 -0700
Message-ID: <20230909070520.35940-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZPuYBOFC8zsK6r9T@google.com>
References: <ZPuYBOFC8zsK6r9T@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 8 Sep 2023 14:54:12 -0700
> On Mon, Sep 26, 2022 at 05:25:44PM -0700, Martin KaFai Lau wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> > 
> > The v6_rcv_saddr and rcv_saddr are inside a union in the
> > 'struct inet_bind2_bucket'.  When searching a bucket by following the
> > bhash2 hashtable chain, eg. inet_bind2_bucket_match, it is only using
> > the sk->sk_family and there is no way to check if the inet_bind2_bucket
> > has a v6 or v4 address in the union.  This leads to an uninit-value
> > KMSAN report in [0] and also potentially incorrect matches.
> > 
> > This patch fixes it by adding a family member to the inet_bind2_bucket
> > and then tests 'sk->sk_family != tb->family' before matching
> > the sk's address to the tb's address.
> 
> It seems this patch doesn't handle v4mapped addresses properly. One of
> gVisor test started failing with this change:
> 
> socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 3
> bind(3, {sa_family=AF_INET6, sin6_port=htons(0), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::ffff:0.0.0.0", &sin6_addr), sin6_scope_id=0}, 28) = 0
> getsockname(3, {sa_family=AF_INET6, sin6_port=htons(33789), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::ffff:0.0.0.0", &sin6_addr), sin6_scope_id=0}, [28]) = 0
> socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 4
> bind(4, {sa_family=AF_INET6, sin6_port=htons(33789), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
> socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 5
> bind(5, {sa_family=AF_INET, sin_port=htons(33789), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
> 
> The test expects that the second bind returns EADDRINUSE.

Thanks for the report.

inet_bind2_bucket_match_addr_any() forgot to take care of
IPV6_ADDR_MAPPED inaddr_any case.

This change fixes the regression.  I'll post a patch after
checking other two functions that the commit touched.

---8<---
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7876b7d703cb..6f2a8dba24fe 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -837,7 +837,9 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		if (sk->sk_family == AF_INET)
 			return net_eq(ib2_net(tb), net) && tb->port == port &&
 				tb->l3mdev == l3mdev &&
-				ipv6_addr_any(&tb->v6_rcv_saddr);
+				(ipv6_addr_any(&tb->v6_rcv_saddr) ||
+				 (ipv6_addr_type(&tb->v6_rcv_saddr) == IPV6_ADDR_MAPPED &&
+				  tb->v6_rcv_saddr.s6_addr32[3] == 0));
 
 		return false;
 	}
---8<---

---8<---
[root@localhost ~]# python3
>>> from socket import *
>>> 
>>> s1 = socket(AF_INET6, SOCK_STREAM)
>>> s1.bind(('::ffff:0.0.0.0', 0))
>>> port = s1.getsockname()[1]
>>> 
>>> s2 = socket(AF_INET, SOCK_STREAM)
>>> s2.bind(('127.0.0.1', port))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
OSError: [Errno 98] Address already in use
---8<---

