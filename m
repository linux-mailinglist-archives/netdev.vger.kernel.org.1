Return-Path: <netdev+bounces-29007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3778162D
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF027281E18
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC0634;
	Sat, 19 Aug 2023 00:56:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD794360
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:56:19 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDEA6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692406578; x=1723942578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M3VaQQhxkdaPz8YBTbfTyJylsFoCU1X5PW4QV9C6S/o=;
  b=P34FDtpuc+0SvjLPwnsHXNKksGetgPMI7roVaa593RMOc9MtBj6Zt0K7
   z+BnX2+4J4nIv03hGW1bgq9M52q/sdQd2b4m4oETUjKUXKDk5LrKnDIMQ
   bdYlTkB3bg2ucee6UaximV7iE2G0+keqc/e74cSDwbF5UcDx38zm7y24G
   0=;
X-IronPort-AV: E=Sophos;i="6.01,184,1684800000"; 
   d="scan'208";a="358212813"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 00:56:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 4F78F80695;
	Sat, 19 Aug 2023 00:56:09 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 19 Aug 2023 00:56:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sat, 19 Aug 2023 00:56:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] net: Allow larger buffer than peer address for SO_PEERNAME.
Date: Fri, 18 Aug 2023 17:55:52 -0700
Message-ID: <20230819005552.39751-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.20]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we call getsockopt(SO_PEERNAME), the buffer size must be smaller
than or equal to the length of the peer name.

It works with protocols whose address size is fixed.  However, the
restriction does not make sense for socket families with an arbitrary
length address.

For example, we usually do not know the peer name if we get an AF_UNIX
socket by accept(), FD passing, or pidfd_getfd().  Then we get -EINVAL
if we pass sizeof(struct sockaddr_un) to getsockopt(SO_PEERNAME).  So,
we need to do binary search to get the exact peer name.

  addrlen = sizeof(struct sockaddr_un);
  getsockopt(fd, SOL_SOCKET, SO_PEERNAME,
             (struct sockaddr *)&addr, &addrlen);  <-- -EINVAL

The error handling is to avoid copying garbage after the copied peer
address in the temporal buffer.

Let's update copy size by the peer name size if it is larger.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index c9cffb7acbea..f6ee2998a109 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1829,7 +1829,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
-			return -EINVAL;
+			len = lv;
 		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
-- 
2.30.2


