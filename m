Return-Path: <netdev+bounces-14331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60922740277
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFFD1C20B36
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643231801E;
	Tue, 27 Jun 2023 17:44:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835C13071
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:44:28 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40978296B;
	Tue, 27 Jun 2023 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687887867; x=1719423867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFkTCQX8AfT2qU1mGZK3CaQ2g/IPGKwwnVUWVSMRUXQ=;
  b=QJILsuoyVgF5MVWmicMV1EB8iPL5K37PL07o/YmYSfYPMBbWIn+yLzNK
   Bp51jizg91k1vQkN9/t3+O96O2qE1IayKSRIhzfZ6AcP0gc+C7kKqjL+c
   0zyx5FLiC++ZSUKjR9uANttLx/LmKD08kT/AFar6wCea93H/nbb9vea/5
   k=;
X-IronPort-AV: E=Sophos;i="6.01,163,1684800000"; 
   d="scan'208";a="336478735"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:44:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id A96078A5C5;
	Tue, 27 Jun 2023 17:44:20 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 17:44:19 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 27 Jun 2023 17:44:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>, Alexander Mikhalitsyn
	<aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 net-next 2/2] net: scm: introduce and use scm_recv_unix helper
Date: Tue, 27 Jun 2023 10:43:14 -0700
Message-ID: <20230627174314.67688-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230627174314.67688-1-kuniyu@amazon.com>
References: <20230627174314.67688-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.41]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Recently, our friends from bluetooth subsystem reported [1] that after
commit 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD") scm_recv()
helper become unusable in kernel modules (because it uses unexported
pidfd_prepare() API).

We were aware of this issue and workarounded it in a hard way
by commit 97154bcf4d1b ("af_unix: Kconfig: make CONFIG_UNIX bool").

But recently a new functionality was added in the scope of commit
817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
and after that bluetooth can't be compiled as a kernel module.

After some discussion in [1] we decided to split scm_recv() into
two helpers, one won't support SCM_PIDFD (used for unix sockets),
and another one will be completely the same as it was before commit
5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD").

Link: https://lore.kernel.org/lkml/CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com/ [1]
Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Resolve conflict with https://lore.kernel.org/netdev/20230626205837.82086-1-kuniyu@amazon.com/
  * Add SHA1 in changelog
  * Fix checkpatch warnings for mismatch open parenthesis and unwrapped link.
  * Add Fixes and Reviewed-by tags

v1: https://lore.kernel.org/all/20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com/
---
 include/net/scm.h  | 35 +++++++++++++++++++++++++----------
 net/unix/af_unix.c |  4 ++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index d456fc41b8bf..c5bcdf65f55c 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -153,8 +153,8 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 		fd_install(pidfd, pidfd_file);
 }
 
-static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
-				struct scm_cookie *scm, int flags)
+static inline bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
+				     struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
 		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
@@ -162,7 +162,7 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		    scm->fp || scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
-		return;
+		return false;
 	}
 
 	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
@@ -175,19 +175,34 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
-		scm_pidfd_recv(msg, scm);
+	scm_passec(sock, msg, scm);
 
-	scm_destroy_cred(scm);
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
 
-	scm_passec(sock, msg, scm);
+	return true;
+}
 
-	if (!scm->fp)
+static inline void scm_recv(struct socket *sock, struct msghdr *msg,
+			    struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
 		return;
-	
-	scm_detach_fds(msg, scm);
+
+	scm_destroy_cred(scm);
 }
 
+static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
+				 struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
+		return;
+
+	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+		scm_pidfd_recv(msg, scm);
+
+	scm_destroy_cred(scm);
+}
 
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3953daa2e1d0..123b35ddfd71 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2427,7 +2427,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	}
 	err = (flags & MSG_TRUNC) ? skb->len - skip : size;
 
-	scm_recv(sock, msg, &scm, flags);
+	scm_recv_unix(sock, msg, &scm, flags);
 
 out_free:
 	skb_free_datagram(sk, skb);
@@ -2808,7 +2808,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (state->msg)
-		scm_recv(sock, state->msg, &scm, flags);
+		scm_recv_unix(sock, state->msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:
-- 
2.30.2


