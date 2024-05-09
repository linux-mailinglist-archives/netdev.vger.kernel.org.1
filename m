Return-Path: <netdev+bounces-94866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2288C0E44
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D97283BD6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED912E1E3;
	Thu,  9 May 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch6m/viA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DB5339A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251014; cv=none; b=cvLJp9fPMHQH5fKwXDr4xPVQzUG8pwvCkwjMB/faeNfBN66hSVAMKeFw8iT79RjaOia38mup7pSKsilvY4aL6J9OYJuRRwMqbq4hC6AIyGGy01o4QD8eHSpCo44L0C3Vbp/anijX28FiDbmyx12wSq62LRtpZqZFWT5B4YPqSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251014; c=relaxed/simple;
	bh=HBDZwzRGeQnsIpiARlnK4c9lly2wfAMLwYCqSmUF43o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SECBy0qmpN0WxKfY7cBVg7Jn8djqpnxsPVqonqeRtmSpua0IScopvympjhs+LnxgrFdoPZSr9ia67zOv1mVOw+p2VNrS2IxrOfrt0C0lI/MR3rbhj1nb/p73ipQnvai9Io8eF9I5VpcOWd/+tBKqpjCUSGi6vZ1e/9O3WJp7Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch6m/viA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715251010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jLIz1Jbxti8NJft3YZRGOY+N8ghcPjRasffwEVjRfb4=;
	b=ch6m/viAuFdOU+l2JC5dp5HAND8SczHUHpYWL8wTP6RLH0lUk32R3Gi7NuiPzFFblWvoAd
	wLG3mTlB6HdS1P8WchgMyrqmqO5OPGvF+WPeBoEtuTOjqKZ3JVmzjTwzEvoSxnWXviIjhQ
	O/bjnhuLJ4i/Q3xLoHpVO/TSVzwltG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-As0XE-8nN32WyKnX_e-r1Q-1; Thu, 09 May 2024 06:36:47 -0400
X-MC-Unique: As0XE-8nN32WyKnX_e-r1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0345881227E;
	Thu,  9 May 2024 10:36:47 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CDB7E1C008B9;
	Thu,  9 May 2024 10:36:44 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: netdev@vger.kernel.org
Cc: casey@schaufler-ca.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-security-module@vger.kernel.org,
	pabeni@redhat.com,
	paul@paul-moore.com,
	xmu@redhat.com
Subject: [PATCH net v4] netlabel: fix RCU annotation for IPv4 options on socket creation
Date: Thu,  9 May 2024 12:07:05 +0200
Message-ID: <262f71a207e8cedd388bd89d17ef16155eb2acee.1715248275.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Xiumei reports the following splat when netlabel and TCP socket are used:

 =============================
 WARNING: suspicious RCU usage
 6.9.0-rc2+ #637 Not tainted
 -----------------------------
 net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by ncat/23333:
  #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setattr+0x25/0x1b0

 stack backtrace:
 CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
 Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
 Call Trace:
  <TASK>
  dump_stack_lvl+0xa9/0xc0
  lockdep_rcu_suspicious+0x117/0x190
  cipso_v4_sock_setattr+0x1ab/0x1b0
  netlbl_sock_setattr+0x13e/0x1b0
  selinux_netlbl_socket_post_create+0x3f/0x80
  selinux_socket_post_create+0x1a0/0x460
  security_socket_post_create+0x42/0x60
  __sock_create+0x342/0x3a0
  __sys_socket_create.part.22+0x42/0x70
  __sys_socket+0x37/0xb0
  __x64_sys_socket+0x16/0x20
  do_syscall_64+0x96/0x180
  ? do_user_addr_fault+0x68d/0xa30
  ? exc_page_fault+0x171/0x280
  ? asm_exc_page_fault+0x22/0x30
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7fbc0ca3fc1b
 Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
 RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
 RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
 RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
 RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001

R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
 R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
  </TASK>

The current implementation of cipso_v4_sock_setattr() replaces IP options
under the assumption that the caller holds the socket lock; however, such
assumption is not true, nor needed, in selinux_socket_post_create() hook.

Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
condition, except selinux_socket_post_create() _ where such condition can
safely be set as true even without holding the socket lock.

v4:
 - fix build when CONFIG_LOCKDEP is unset (thanks kernel test robot)

v3:
 - rename variable to 'sk_locked' (thanks Paul Moore)
 - keep rcu_replace_pointer() open-coded and re-add NULL check of 'old',
   these two changes will be posted in another patch (thanks Paul Moore)

v2:
 - pass lockdep_sock_is_held() through a boolean variable in the stack
   (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
 - use rcu_replace_pointer() instead of rcu_dereference_protected() +
   rcu_assign_pointer()
 - remove NULL check of 'old' before kfree_rcu()

Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
Reported-by: Xiumei Mu <xmu@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/cipso_ipv4.h     |  6 ++++--
 include/net/netlabel.h       | 12 ++++++++++--
 net/ipv4/cipso_ipv4.c        |  7 ++++---
 net/netlabel/netlabel_kapi.c | 26 +++++++++++++++++++++++---
 security/selinux/netlabel.c  |  5 ++++-
 security/smack/smack_lsm.c   |  3 ++-
 6 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
index 53dd7d988a2d..c9111bb2f59b 100644
--- a/include/net/cipso_ipv4.h
+++ b/include/net/cipso_ipv4.h
@@ -183,7 +183,8 @@ int cipso_v4_getattr(const unsigned char *cipso,
 		     struct netlbl_lsm_secattr *secattr);
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
-			  const struct netlbl_lsm_secattr *secattr);
+			  const struct netlbl_lsm_secattr *secattr,
+			  bool sk_locked);
 void cipso_v4_sock_delattr(struct sock *sk);
 int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr);
 int cipso_v4_req_setattr(struct request_sock *req,
@@ -214,7 +215,8 @@ static inline int cipso_v4_getattr(const unsigned char *cipso,
 
 static inline int cipso_v4_sock_setattr(struct sock *sk,
 				      const struct cipso_v4_doi *doi_def,
-				      const struct netlbl_lsm_secattr *secattr)
+				      const struct netlbl_lsm_secattr *secattr,
+				      bool sk_locked)
 {
 	return -ENOSYS;
 }
diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index f3ab0b8a4b18..2133ad723fc1 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -470,7 +470,8 @@ void netlbl_bitmap_setbit(unsigned char *bitmap, u32 bit, u8 state);
 int netlbl_enabled(void);
 int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
-			const struct netlbl_lsm_secattr *secattr);
+			const struct netlbl_lsm_secattr *secattr,
+			bool sk_locked);
 void netlbl_sock_delattr(struct sock *sk);
 int netlbl_sock_getattr(struct sock *sk,
 			struct netlbl_lsm_secattr *secattr);
@@ -487,6 +488,7 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			  u16 family,
 			  struct netlbl_lsm_secattr *secattr);
 void netlbl_skbuff_err(struct sk_buff *skb, u16 family, int error, int gateway);
+bool netlbl_sk_lock_check(struct sock *sk);
 
 /*
  * LSM label mapping cache operations
@@ -614,7 +616,8 @@ static inline int netlbl_enabled(void)
 }
 static inline int netlbl_sock_setattr(struct sock *sk,
 				      u16 family,
-				      const struct netlbl_lsm_secattr *secattr)
+				      const struct netlbl_lsm_secattr *secattr,
+				      bool sk_locked)
 {
 	return -ENOSYS;
 }
@@ -673,6 +676,11 @@ static inline struct audit_buffer *netlbl_audit_start(int type,
 {
 	return NULL;
 }
+
+static inline bool netlbl_sk_lock_check(struct sock *sk)
+{
+	return true;
+}
 #endif /* CONFIG_NETLABEL */
 
 const struct netlbl_calipso_ops *
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 8b17d83e5fde..dd6d46015058 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1815,6 +1815,7 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
  * @sk: the socket
  * @doi_def: the CIPSO DOI to use
  * @secattr: the specific security attributes of the socket
+ * @sk_locked: true if caller holds the socket lock
  *
  * Description:
  * Set the CIPSO option on the given socket using the DOI definition and
@@ -1826,7 +1827,8 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
  */
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
-			  const struct netlbl_lsm_secattr *secattr)
+			  const struct netlbl_lsm_secattr *secattr,
+			  bool sk_locked)
 {
 	int ret_val = -EPERM;
 	unsigned char *buf = NULL;
@@ -1876,8 +1878,7 @@ int cipso_v4_sock_setattr(struct sock *sk,
 
 	sk_inet = inet_sk(sk);
 
-	old = rcu_dereference_protected(sk_inet->inet_opt,
-					lockdep_sock_is_held(sk));
+	old = rcu_dereference_protected(sk_inet->inet_opt, sk_locked);
 	if (inet_test_bit(IS_ICSK, sk)) {
 		sk_conn = inet_csk(sk);
 		if (old)
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 1ba4f58e1d35..371158b22ec6 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -965,6 +965,7 @@ int netlbl_enabled(void)
  * @sk: the socket to label
  * @family: protocol family
  * @secattr: the security attributes
+ * @sk_locked: true if caller holds the socket lock
  *
  * Description:
  * Attach the correct label to the given socket using the security attributes
@@ -977,7 +978,8 @@ int netlbl_enabled(void)
  */
 int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
-			const struct netlbl_lsm_secattr *secattr)
+			const struct netlbl_lsm_secattr *secattr,
+			bool sk_locked)
 {
 	int ret_val;
 	struct netlbl_dom_map *dom_entry;
@@ -997,7 +999,7 @@ int netlbl_sock_setattr(struct sock *sk,
 		case NETLBL_NLTYPE_CIPSOV4:
 			ret_val = cipso_v4_sock_setattr(sk,
 							dom_entry->def.cipso,
-							secattr);
+							secattr, sk_locked);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			ret_val = 0;
@@ -1090,6 +1092,23 @@ int netlbl_sock_getattr(struct sock *sk,
 	return ret_val;
 }
 
+/**
+ * netlbl_sk_lock_check - Check if the socket lock has been acquired.
+ * @sk: the socket to check
+ *
+ * Description: check if @sk is locked. Returns true if socket @sk is locked
+ * or if lock debugging is disabled at runtime or compile-time
+ *
+ */
+bool netlbl_sk_lock_check(struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	if (debug_locks)
+		return lockdep_sock_is_held(sk);
+#endif
+	return true;
+}
+
 /**
  * netlbl_conn_setattr - Label a connected socket using the correct protocol
  * @sk: the socket to label
@@ -1126,7 +1145,8 @@ int netlbl_conn_setattr(struct sock *sk,
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
 			ret_val = cipso_v4_sock_setattr(sk,
-							entry->cipso, secattr);
+							entry->cipso, secattr,
+							netlbl_sk_lock_check(sk));
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 8f182800e412..55885634e880 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -402,7 +402,10 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	secattr = selinux_netlbl_sock_genattr(sk);
 	if (secattr == NULL)
 		return -ENOMEM;
-	rc = netlbl_sock_setattr(sk, family, secattr);
+	/* On socket creation, replacement of IP options is safe even if
+	 * the caller does not hold the socket lock.
+	 */
+	rc = netlbl_sock_setattr(sk, family, secattr, true);
 	switch (rc) {
 	case 0:
 		sksec->nlbl_state = NLBL_LABELED;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 146667937811..efeac8365ad0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2565,7 +2565,8 @@ static int smack_netlbl_add(struct sock *sk)
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
-	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel,
+				 netlbl_sk_lock_check(sk));
 	switch (rc) {
 	case 0:
 		ssp->smk_state = SMK_NETLBL_LABELED;
-- 
2.44.0


