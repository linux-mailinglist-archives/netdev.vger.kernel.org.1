Return-Path: <netdev+bounces-287629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEQLGjKOBGoALgIAu9opvQ
	(envelope-from <netdev+bounces-287629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:44:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804F53557A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A46A3018F80
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051443DA42;
	Wed, 13 May 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSLoykrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31202423A8E
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683154; cv=none; b=H8g0fhRk/8R4C2J5QvI3Pw4GclGNTSNiOP5L54RAAR4ltofYCx/AjaER2mumxaj1zsAeujNoo66aiIsBd9j+nhK+j5G4X+BtRkvTmb/60rw+ptVg38WL+ThYsjJ2zE+ULJAOi4SpL/djjL+I7xeKs55Y7uuJf/v2XPw4vDAdkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683154; c=relaxed/simple;
	bh=tLJ9CfalQcWKJarLwUgnz4rFuVSrwbgfTI7Iyffc850=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j3C73nySkg2Z8Avz9p/aFWakk/4rYDA2NJwN54tf2/GqTpLpT6v7oQ6M7g779W08oRBuOaWrFtFtxybd0Y1yAhR3RFTVuj52fYQmAbELYHQTfXIQRS3cQ5tHyNUREJVsVgT0n/mWq2IXDf70PRw3dPRCz3Mqvt82DG/lvf7hOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSLoykrZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bc763e2ba8so22411675ad.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778683151; x=1779287951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+v+A2S+ZiZWa4ABzfTfoSKES+pA5RrDCYVE5sdxAhwY=;
        b=gSLoykrZb46iWFX7VmuHUbI6Nlz94/as+d2CCFWL374cy6HQyPlenCWMQE0Q9Dh5/y
         K+lrLlBkn0tusaY+dD60fNu/ctXQqu0G9hS8rfzU9v5gYMWgvzGYoxYsmJd/5ZovWinz
         uPB35xGwpOAIC6QmovyxS0M7J0bML7XtFEr9j76ClXlFlueZ8oAmx5ffnh+V/ZIirCG/
         Jl1xMZQpsqWL0+PimreH028sNb79pMJLijPFCwKAaDukJJk1UoiMrKhX3r1PNesUOKEy
         ENDzpT3aQPq+GYRl6A2IbJf/TUgjMf7gVVN1Qae5QvXYtu+KeNyMOsPqPHz09Zm5wpaw
         8cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778683151; x=1779287951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v+A2S+ZiZWa4ABzfTfoSKES+pA5RrDCYVE5sdxAhwY=;
        b=QfFR3yuOuc3ufWX990OKNeg7v52Qk2bVrqSAlKnHGudNSG9LuLFrRX6gDusCAmS9da
         VRxbTXX+XhOdVsYyDczFMIzSKGYF2xMOyQY1hRDOHP3L7IyPpuYu/2ypc363D2QjpYwv
         QvwnxNaxs5xJqAiR7icQEfGgPbQJeF+ENoy5l9+hBY4R/ssqByl+xpPWdEAEPVAHry+k
         aiEguydUXmOjiAIV3Hohp1zBuWLl5ugLpiB6qC/JFSFeuSsQWlv9nqQg0I1wUtIfFa/P
         OlsDUkBT0V4N+8jwCPnzBIiOb/BNPTyNEJ4L0GEPXvophuzJBXIciH+YRFYpcZsLXmKL
         +xVA==
X-Forwarded-Encrypted: i=1; AFNElJ83MqsblWnWmv/xekV3NSw21IHgKYpyZWZRbVaERZbflwsPVfVHEOvYrZQkF2/OPhLz+vdifEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIDwCh8Rw9hxu063BYaen2eZzFwD784BAAnrDHmDsR3WoIdd4
	soxQAxuM+tL2V+ntQ7iEtWIUf4pzV1U0t3lzWDrd7J54/dRU1dE/ObMS
X-Gm-Gg: Acq92OGSG28b13LB7Ng/M2q8GVlHMwYjY8znZZngXb4perB1RnoepluJWGa1Wv3Ooj6
	1fjRuk9Ofv0J1CoDxV6HCoKGDoEYLxysUTMDsLMRXzIvZbaEUPtkKBSqp6iqQ88QSnPP4E0fXVi
	Zw3AaOuJVRWFohEOEn/LZcGzwzq+GOPQiMaEhL5VwAoUw0FtmxaULzKEPC0Jf8JTCeKZCq4aood
	MgFpPFLfEoC4h7hD//IYxmFrIpqem2OF5gxgnujXZv519sU8YJVE88dWV/cFvgSzWUjtMoyw2Vg
	QjDCkW0keNX4Fv+WMjJthAWqT6F867mhgQjylmkQpH7mOpY7hwI0QOKkAvgPlesJBo0s5JDLqw8
	bNZWTgouyw5GYMcs7GBFdMuGkivFp38JbQ2493gDUFdPYl6eonGCqODBK2odvt6MdgnsSJk+Pr2
	OVYT8lG+cOmxgUkp6HMBkDBrAGuGO53R1zN+iJyYnkgh/W91c4ktfJiB1h
X-Received: by 2002:a17:903:f8e:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2bd271773f9mr40825345ad.13.1778683151100;
        Wed, 13 May 2026 07:39:11 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm171638535ad.0.2026.05.13.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:39:10 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	praveen.kakkolangara@aumovio.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v4] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Wed, 13 May 2026 22:39:04 +0800
Message-Id: <20260513143904.2497520-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0804F53557A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-287629-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The RDS_INFO_* family of getsockopt(2) options reads several
file-scope global lists that are not per-netns:

  rds_sock_info / rds6_sock_info,
  rds_sock_inc_info / rds6_sock_inc_info        -> rds_sock_list
  rds_tcp_tc_info / rds6_tcp_tc_info            -> rds_tcp_tc_list
  rds_conn_info / rds6_conn_info,
  rds_conn_message_info_cmn (for the *_SEND_MESSAGES and
  *_RETRANS_MESSAGES variants),
  rds_for_each_conn_info (for RDS_INFO_IB_CONNECTIONS)
                                                -> rds_conn_hash[]

The handlers do not filter by the caller's network namespace.
rds_info_getsockopt() has no netns or capable() check, and
rds_create() has no capable() check, so AF_RDS is reachable from
an unprivileged user namespace. As a result, an unprivileged
caller in a fresh user_ns plus netns can read the bound address
and sock inode of every RDS socket on the host, the peer address
of incoming messages on every RDS socket on the host, the peer
address and TCP sequence numbers of every rds-tcp connection on
the host, and the peer address and RDS sequence numbers of every
RDS connection on the host.

The rds-tcp transport is reachable from a non-initial netns (see
rds_set_transport()), so a one-shot init_net gate at
rds_info_getsockopt() would deny legitimate per-netns visibility
to rds-tcp callers. Instead, filter at each handler by comparing
the netns of the caller's socket to the netns of the list entry,
or to rds_conn_net(conn) for connection paths. Only copy entries
whose netns matches the caller. Counters (RDS_INFO_COUNTERS) are
aggregate statistics and remain global.

Reproducer (KASAN VM, rds and rds_tcp loaded): an AF_RDS socket
binds 127.0.0.1:4242 in init_net as root. A child process enters
a fresh user_ns plus netns and opens AF_RDS there, then calls
getsockopt(SOL_RDS, RDS_INFO_SOCKETS). Before this change, the
child sees the init_net socket. After this change, the child
sees zero entries.

Drop the rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count
globals. v2 used them for the size precheck and lens->nr; v3
replaced the precheck with a per-ns count from a first pass over
the list, so the globals have no remaining readers. The matching
increments and decrements in rds_create()/rds_destroy_sock() and
rds_tcp_set_callbacks()/rds_tcp_restore_callbacks() go away with
them. Reported by the kernel test robot under clang W=1.

Suggested-by: Allison Henderson <achender@kernel.org>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v4: Drop the rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count
    globals reported by the kernel test robot under clang W=1
    (-Wunused-but-set-global). They have no remaining readers after v3
    replaced the size precheck with a per-ns count from the first pass.
    Inc/dec sites in rds_create()/rds_destroy_sock() and
    rds_tcp_set_callbacks()/rds_tcp_restore_callbacks() are removed
    with them. No functional change beyond v3 for the netns-filter
    behaviour.

    Note for applier: this patch touches rds_tcp_set_callbacks() in the
    same hunk window as a separate [PATCH net] sent earlier (Message-Id
    <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>, "rds_tcp: close
    NULL deref window in rds_tcp_set_callbacks"). Both apply cleanly
    to net/main tip b266bacba in isolation. When applied together the
    second one needs a trivial 3-way merge in net/rds/tcp.c.
v3: Address Simon Horman's review of v2. The size precheck and the
    lens count are now both restricted to the caller's netns in
    rds_sock_info, rds6_sock_info, rds_tcp_tc_info and
    rds6_tcp_tc_info. Each handler now does a first pass under the
    list lock to count entries visible in the caller's netns, then
    short-circuits with that count if the user buffer is too small,
    then a second pass to fill data. This closes both issues Simon
    flagged: a zero-length probe no longer returns the global count,
    and a caller that sizes its buffer to the value returned by lens
    no longer hits ENOSPC on the second call.
    Re-verified on KASAN VM with the v1 PoC: attacker in fresh
    user_ns + netns sees zero RDS_INFO_SOCKETS entries; init_net
    access sees its own entries; lens returns the ns-scoped count
    on both probe and full reads.
v2: rebased onto net/main tip (b266bacba) so patchwork can apply.
    No code changes. Carries forward Reviewed-by from v1 review.
v1: https://lore.kernel.org/r/20260506075031.2238596-1-maoyixie.tju@gmail.com

 net/rds/af_rds.c     | 45 +++++++++++++++++++++++++++++--------
 net/rds/connection.c | 13 +++++++++++
 net/rds/tcp.c        | 53 ++++++++++++++++++++++++++------------------
 3 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 76f625986..ace52d3ce 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -43,7 +43,6 @@
 
 /* this is just used for stats gathering :/ */
 static DEFINE_SPINLOCK(rds_sock_lock);
-static unsigned long rds_sock_count;
 static LIST_HEAD(rds_sock_list);
 DECLARE_WAIT_QUEUE_HEAD(rds_poll_waitq);
 
@@ -82,7 +81,6 @@ static int rds_release(struct socket *sock)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_del_init(&rs->rs_item);
-	rds_sock_count--;
 	spin_unlock_bh(&rds_sock_lock);
 
 	rds_trans_put(rs->rs_transport);
@@ -694,7 +692,6 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_add_tail(&rs->rs_item, &rds_sock_list);
-	rds_sock_count++;
 	spin_unlock_bh(&rds_sock_lock);
 
 	return 0;
@@ -735,6 +732,7 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 			      struct rds_info_iterator *iter,
 			      struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_sock *rs;
 	struct rds_incoming *inc;
 	unsigned int total = 0;
@@ -744,6 +742,9 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -774,6 +775,7 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 			       struct rds_info_iterator *iter,
 			       struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_incoming *inc;
 	unsigned int total = 0;
 	struct rds_sock *rs;
@@ -783,6 +785,9 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		read_lock(&rs->rs_recv_lock);
 
 		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
@@ -806,6 +811,7 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_info_socket sinfo;
 	unsigned int cnt = 0;
 	struct rds_sock *rs;
@@ -814,12 +820,22 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count) {
-		cnt = rds_sock_count;
-		goto out;
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
+			continue;
+		cnt++;
 	}
 
+	if (len < cnt)
+		goto out;
+
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -832,7 +848,6 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 		sinfo.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo, sizeof(sinfo));
-		cnt++;
 	}
 
 out:
@@ -847,17 +862,29 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_socket sinfo6;
+	unsigned int cnt = 0;
 	struct rds_sock *rs;
 
 	len /= sizeof(struct rds6_info_socket);
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		cnt++;
+	}
+
+	if (len < cnt)
 		goto out;
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		sinfo6.sndbuf = rds_sk_sndbuf(rs);
 		sinfo6.rcvbuf = rds_sk_rcvbuf(rs);
 		sinfo6.bound_addr = rs->rs_bound_addr;
@@ -870,7 +897,7 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 	}
 
  out:
-	lens->nr = rds_sock_count;
+	lens->nr = cnt;
 	lens->each = sizeof(struct rds6_info_socket);
 
 	spin_unlock_bh(&rds_sock_lock);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index c10b7ed06..7c8ab8e97 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -568,6 +568,7 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 				      struct rds_info_lengths *lens,
 				      int want_send, bool isv6)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct list_head *list;
 	struct rds_connection *conn;
@@ -590,6 +591,9 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 			struct rds_conn_path *cp;
 			int npaths;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 			if (!isv6 && conn->c_isv6)
 				continue;
 
@@ -688,6 +692,7 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  u64 *buffer,
 			  size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -700,6 +705,9 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	for (i = 0, head = rds_conn_hash; i < ARRAY_SIZE(rds_conn_hash);
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 
 			/* Zero the per-item buffer before handing it to the
 			 * visitor so any field the visitor does not write -
@@ -733,6 +741,7 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    u64 *buffer,
 				    size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -747,6 +756,10 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 			struct rds_conn_path *cp;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
+
 			/* XXX We only copy the information from the first
 			 * path for now.  The problem is that if there are
 			 * more than one underlying paths, we cannot report
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 654e23d13..c2e44e9e2 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -46,14 +46,6 @@
 static DEFINE_SPINLOCK(rds_tcp_tc_list_lock);
 static LIST_HEAD(rds_tcp_tc_list);
 
-/* rds_tcp_tc_count counts only IPv4 connections.
- * rds6_tcp_tc_count counts both IPv4 and IPv6 connections.
- */
-static unsigned int rds_tcp_tc_count;
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int rds6_tcp_tc_count;
-#endif
-
 /* Track rds_tcp_connection structs so they can be cleaned up */
 static DEFINE_SPINLOCK(rds_tcp_conn_lock);
 static LIST_HEAD(rds_tcp_conn_list);
@@ -110,11 +102,6 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_del_init(&tc->t_list_item);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count--;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count--;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	tc->t_sock = NULL;
@@ -201,11 +188,6 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count++;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count++;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	/* accepted sockets need our listen data ready undone */
@@ -235,13 +217,24 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 			    struct rds_info_iterator *iter,
 			    struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(rds_sock->sk);
 	struct rds_info_tcp_socket tsinfo;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo) < rds_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (tc->t_cpath->cp_conn->c_isv6)
+			continue;
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
@@ -249,6 +242,9 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 
 		if (tc->t_cpath->cp_conn->c_isv6)
 			continue;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
 
 		tsinfo.local_addr = inet->inet_saddr;
 		tsinfo.local_port = inet->inet_sport;
@@ -266,7 +262,7 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 	}
 
 out:
-	lens->nr = rds_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
@@ -281,19 +277,32 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 			     struct rds_info_iterator *iter,
 			     struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_tcp_socket tsinfo6;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo6) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct sock *sk = tc->t_sock->sk;
 		struct inet_sock *inet = inet_sk(sk);
 
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+
 		tsinfo6.local_addr = sk->sk_v6_rcv_saddr;
 		tsinfo6.local_port = inet->inet_sport;
 		tsinfo6.peer_addr = sk->sk_v6_daddr;
@@ -309,7 +318,7 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 	}
 
 out:
-	lens->nr = rds6_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo6);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);

base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.34.1


