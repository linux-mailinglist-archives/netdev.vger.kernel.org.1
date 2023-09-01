Return-Path: <netdev+bounces-31795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A5790399
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442411C20926
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277311C8F;
	Fri,  1 Sep 2023 22:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2FAD53
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 22:21:12 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E593A95
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693606869; x=1725142869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gFMWj4d1vtsOBj4wAZPVC/Am3wend/GRmkgBBjGWlU0=;
  b=UYtPNqX3zhWXUZtmIulMz+gs5KZhKLG3Sir/jLOcVyiHvWDJq5vsMBcK
   cgV2zPc7ui9E+ko6Q8dqhS1xj41A7nDxjaJUnY30M/Ff2+jPG6/lNMq+h
   0fJK/8qJhHFtV3OVi9dDVQlZ6tjX3ETGZ1rFAGcP9NE0qcjMEs0xbkpON
   c=;
X-IronPort-AV: E=Sophos;i="6.02,221,1688428800"; 
   d="scan'208";a="1152056979"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 22:21:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id CBE6E84A3D;
	Fri,  1 Sep 2023 22:20:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 22:20:47 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 22:20:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, "Alexander
 Mikhalitsyn" <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 net] af_unix: Fix msg_controllen test in scm_pidfd_recv() for MSG_CMSG_COMPAT.
Date: Fri, 1 Sep 2023 15:20:33 -0700
Message-ID: <20230901222033.71400-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.14]
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Heiko Carstens reported that SCM_PIDFD does not work with MSG_CMSG_COMPAT
because scm_pidfd_recv() always checks msg_controllen against sizeof(struct
cmsghdr).

We need to use sizeof(struct compat_cmsghdr) for the compat case.

Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/20230901200517.8742-A-hca@linux.ibm.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index c5bcdf65f55c..c5608ca03a40 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -9,6 +9,7 @@
 #include <linux/pid.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
+#include <net/compat.h>
 
 /* Well, we should have at least one descriptor open
  * to accept passed FDs 8)
@@ -123,14 +124,17 @@ static inline bool scm_has_secdata(struct socket *sock)
 static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 {
 	struct file *pidfd_file = NULL;
-	int pidfd;
+	int len, pidfd;
 
-	/*
-	 * put_cmsg() doesn't return an error if CMSG is truncated,
+	/* put_cmsg() doesn't return an error if CMSG is truncated,
 	 * that's why we need to opencode these checks here.
 	 */
-	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
-	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
+	if (msg->msg_flags & MSG_CMSG_COMPAT)
+		len = sizeof(struct cmsghdr) + sizeof(int);
+	else
+		len = sizeof(struct compat_cmsghdr) + sizeof(int);
+
+	if (msg->msg_controllen < len) {
 		msg->msg_flags |= MSG_CTRUNC;
 		return;
 	}
-- 
2.30.2


