Return-Path: <netdev+bounces-306912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlpmAtjxUmqSVgMAu9opvQ
	(envelope-from <netdev+bounces-306912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:46:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AED39743728
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:45:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306912-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306912-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DC3E306A3BA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB812147E6;
	Sun, 12 Jul 2026 01:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D40236A73
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820493; cv=none; b=q34zJegETByDbTCqMF4Qa7n26ERGu7Njf6LAxnSK4/kzEdGHW0Jsk5pl+q++PLeqNqma4su/WvLKN9ZcbCdQ8dTiiWShkSKJQN005CV+7zLt2iGapCEvbMyBa+iWO1DKGo1MeT6OVGHGs9+0F8sXa8fHqAkFst5RcHsvcl1PIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820493; c=relaxed/simple;
	bh=EcHUbyvurR82V3HdX3eLhi+/TiiljyMvzLS6SUo2/rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO5cu5WIrzqlpnmK5QVADq4YI96lrN52Qgno5Qti1Q80DKutkwpsERM8g5EpzNIe+ZifXGSNecN/GYspBTSwWIUCXBhgo4p6Jgui8/boYhHeMD8vdD3UFA+8iY9L449Wk8da0/qMXNSYBFN4e+BrSpZbOhMLsnnmiIKoKGcQ+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FF7877052;
	Sun, 12 Jul 2026 01:41:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF570779B5;
	Sun, 12 Jul 2026 01:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GI+zJ8fwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:27 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 09/13 RFC net-next] net: fib: split common nexthop logic to fib_core.c
Date: Sun, 12 Jul 2026 03:39:07 +0200
Message-ID: <20260712013941.4570-10-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306912-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,iogearbox.net,gmail.com,fomichev.me,strlen.de,nokia-bell-labs.com,icloud.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:kuniyu@google.com,m:asml.silence@gmail.com,m:dtatulea@nvidia.com,m:ebiggers@kernel.org,m:ardb@kernel.org,m:fw@strlen.de,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:yuuchihsu@gmail.com,m:bronzed_45_vested@icloud.com,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AED39743728

To enable compiling INET subsystem without IPv4, shared FIB and nexthop
logic must be accessible to IPv6 when IPv4 routing stack is omitted.

This patch creates fib_core.c and move all the functions for common
nexthop initialization and release from fib_semantics.c to fib_core.c.
Note that fib_core.c is under net/core.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/ip_fib.h       |  43 +++++++++++
 include/net/route.h        |   6 ++
 net/core/Makefile          |   2 +-
 net/core/fib_core.c        | 146 +++++++++++++++++++++++++++++++++++++
 net/ipv4/Makefile          |   2 +
 net/ipv4/fib_semantics.c   | 142 ------------------------------------
 net/ipv4/netlink.c         |   2 +
 net/ipv4/nexthop.c         |   2 +-
 net/ipv4/sysctl_net_ipv4.c |   2 +
 net/ipv6/ip6_fib.c         |   2 +
 10 files changed, 205 insertions(+), 144 deletions(-)
 create mode 100644 net/core/fib_core.c

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 0a35355fb0f3..0c56d8690e00 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -250,7 +250,13 @@ int call_fib4_notifiers(struct net *net, enum fib_event_type event_type,
 int __net_init fib4_notifier_init(struct net *net);
 void __net_exit fib4_notifier_exit(struct net *net);
 
+#if IS_ENABLED(CONFIG_IPV4)
 void fib_info_notify_update(struct net *net, struct nl_info *info);
+#else
+static inline void fib_info_notify_update(struct net *net, struct nl_info *info)
+{
+}
+#endif
 int fib_notify(struct net *net, struct notifier_block *nb,
 	       struct netlink_ext_ack *extack);
 
@@ -578,10 +584,23 @@ void fib_select_multipath(struct fib_result *res, int hash,
 void fib_select_path(struct net *net, struct fib_result *res,
 		     struct flowi4 *fl4, const struct sk_buff *skb);
 
+#if IS_ENABLED(CONFIG_IPV4)
 int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
 		struct fib_config *cfg, int nh_weight,
 		struct netlink_ext_ack *extack);
 void fib_nh_release(struct net *net, struct fib_nh *fib_nh);
+#else
+static inline int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
+			      struct fib_config *cfg, int gfp,
+			      struct netlink_ext_ack *extack)
+{
+	return -EAFNOSUPPORT;
+}
+
+static inline void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
+{
+}
+#endif
 int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 		       struct nlattr *fc_encap, u16 fc_encap_type,
 		       void *cfg, gfp_t gfp_flags,
@@ -620,7 +639,13 @@ static inline void fib_combine_itag(u32 *itag, const struct fib_result *res)
 #endif
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 void fib_flush(struct net *net);
+#else
+static inline void fib_flush(struct net *net)
+{
+}
+#endif
 void free_fib_info(struct fib_info *fi);
 
 static inline void fib_info_hold(struct fib_info *fi)
@@ -658,8 +683,26 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 			  struct fib_dump_filter *filter,
 			  struct netlink_callback *cb);
 
+#if IS_ENABLED(CONFIG_IPV4)
 int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nh,
 		     u8 rt_family, unsigned char *flags, bool skip_oif);
 int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nh,
 		    int nh_weight, u8 rt_family, u32 nh_tclassid);
+#else
+static inline int fib_nexthop_info(struct sk_buff *skb,
+				   const struct fib_nh_common *nh,
+				   u8 rt_family, unsigned char *flags,
+				   bool skip_oif)
+{
+	return 0;
+}
+
+static inline int fib_add_nexthop(struct sk_buff *skb,
+				  const struct fib_nh_common *nh,
+				  int nh_weight, u8 rt_family,
+				  u32 nh_tclassid)
+{
+	return 0;
+}
+#endif
 #endif  /* _NET_FIB_H */
diff --git a/include/net/route.h b/include/net/route.h
index 08adb14224a9..29944be291f8 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -128,7 +128,13 @@ extern struct ip_rt_acct __percpu *ip_rt_acct;
 struct in_device;
 
 int ip_rt_init(void);
+#if IS_ENABLED(CONFIG_IPV4)
 void rt_cache_flush(struct net *net);
+#else
+static inline void rt_cache_flush(struct net *net)
+{
+}
+#endif
 void rt_flush_dev(struct net_device *dev);
 
 static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
diff --git a/net/core/Makefile b/net/core/Makefile
index b3fdcb4e355f..63ebcdc6b9f1 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 obj-y		     += dev.o dev_api.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
-			fib_notifier.o xdp.o flow_offload.o gro.o \
+			fib_notifier.o fib_core.o xdp.o flow_offload.o gro.o \
 			netdev-genl.o netdev-genl-gen.o netdev_work.o gso.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
diff --git a/net/core/fib_core.c b/net/core/fib_core.c
new file mode 100644
index 000000000000..93894b5847e9
--- /dev/null
+++ b/net/core/fib_core.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <net/lwtunnel.h>
+#include <net/route.h>
+
+static void rt_fibinfo_free(struct rtable __rcu **rtp)
+{
+	struct rtable *rt = rcu_dereference_protected(*rtp, 1);
+
+	if (!rt)
+		return;
+
+	/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
+	 * because we waited an RCU grace period before calling
+	 * free_fib_info_rcu()
+	 */
+
+	dst_dev_put(&rt->dst);
+	dst_release_immediate(&rt->dst);
+}
+
+static void free_nh_exceptions(struct fib_nh_common *nhc)
+{
+	struct fnhe_hash_bucket *hash;
+	int i;
+
+	hash = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	if (!hash)
+		return;
+	for (i = 0; i < FNHE_HASH_SIZE; i++) {
+		struct fib_nh_exception *fnhe;
+
+		fnhe = rcu_dereference_protected(hash[i].chain, 1);
+		while (fnhe) {
+			struct fib_nh_exception *next;
+
+			next = rcu_dereference_protected(fnhe->fnhe_next, 1);
+
+			rt_fibinfo_free(&fnhe->fnhe_rth_input);
+			rt_fibinfo_free(&fnhe->fnhe_rth_output);
+
+			kfree(fnhe);
+
+			fnhe = next;
+		}
+	}
+	kfree(hash);
+}
+
+static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
+{
+	int cpu;
+
+	if (!rtp)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct rtable *rt;
+
+		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
+		if (rt) {
+			dst_dev_put(&rt->dst);
+			dst_release_immediate(&rt->dst);
+		}
+	}
+	free_percpu(rtp);
+}
+
+void fib_nh_common_release(struct fib_nh_common *nhc)
+{
+	netdev_put(nhc->nhc_dev, &nhc->nhc_dev_tracker);
+	lwtstate_put(nhc->nhc_lwtstate);
+	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
+	rt_fibinfo_free(&nhc->nhc_rth_input);
+	free_nh_exceptions(nhc);
+}
+
+int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
+		       struct nlattr *encap, u16 encap_type,
+		       void *cfg, gfp_t gfp_flags,
+		       struct netlink_ext_ack *extack)
+{
+	int err;
+
+	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
+						    gfp_flags);
+	if (!nhc->nhc_pcpu_rth_output)
+		return -ENOMEM;
+
+	if (encap) {
+		struct lwtunnel_state *lwtstate;
+
+		err = lwtunnel_build_state(net, encap_type, encap,
+					   nhc->nhc_family, cfg, &lwtstate,
+					   extack);
+		if (err)
+			goto lwt_failure;
+
+		nhc->nhc_lwtstate = lwtstate_get(lwtstate);
+	}
+
+	return 0;
+
+lwt_failure:
+	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
+	nhc->nhc_pcpu_rth_output = NULL;
+	return err;
+}
+
+/* Update the PMTU of exceptions when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ */
+void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
+{
+	struct fnhe_hash_bucket *bucket;
+	int i;
+
+	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	if (!bucket)
+		return;
+
+	for (i = 0; i < FNHE_HASH_SIZE; i++) {
+		struct fib_nh_exception *fnhe;
+
+		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		     fnhe;
+		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
+			if (fnhe->fnhe_mtu_locked) {
+				if (new <= fnhe->fnhe_pmtu) {
+					fnhe->fnhe_pmtu = new;
+					fnhe->fnhe_mtu_locked = false;
+				}
+			} else if (new < fnhe->fnhe_pmtu ||
+				   orig == fnhe->fnhe_pmtu) {
+				fnhe->fnhe_pmtu = new;
+			}
+		}
+	}
+}
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 83c25f52eb58..b540d549f25a 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -19,7 +19,9 @@ obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
 obj-$(CONFIG_PROC_FS) += proc.o
+ifeq ($(CONFIG_IPV4),y)
 obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
+endif
 obj-$(CONFIG_IP_MROUTE) += ipmr.o
 obj-$(CONFIG_IP_MROUTE_COMMON) += ipmr_base.o
 obj-$(CONFIG_NET_IPIP) += ipip.o
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..6ed252e9559e 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -136,78 +136,6 @@ const struct fib_prop fib_props[RTN_MAX + 1] = {
 	},
 };
 
-static void rt_fibinfo_free(struct rtable __rcu **rtp)
-{
-	struct rtable *rt = rcu_dereference_protected(*rtp, 1);
-
-	if (!rt)
-		return;
-
-	/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
-	 * because we waited an RCU grace period before calling
-	 * free_fib_info_rcu()
-	 */
-
-	dst_dev_put(&rt->dst);
-	dst_release_immediate(&rt->dst);
-}
-
-static void free_nh_exceptions(struct fib_nh_common *nhc)
-{
-	struct fnhe_hash_bucket *hash;
-	int i;
-
-	hash = rcu_dereference_protected(nhc->nhc_exceptions, 1);
-	if (!hash)
-		return;
-	for (i = 0; i < FNHE_HASH_SIZE; i++) {
-		struct fib_nh_exception *fnhe;
-
-		fnhe = rcu_dereference_protected(hash[i].chain, 1);
-		while (fnhe) {
-			struct fib_nh_exception *next;
-
-			next = rcu_dereference_protected(fnhe->fnhe_next, 1);
-
-			rt_fibinfo_free(&fnhe->fnhe_rth_input);
-			rt_fibinfo_free(&fnhe->fnhe_rth_output);
-
-			kfree(fnhe);
-
-			fnhe = next;
-		}
-	}
-	kfree(hash);
-}
-
-static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
-{
-	int cpu;
-
-	if (!rtp)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct rtable *rt;
-
-		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
-		if (rt) {
-			dst_dev_put(&rt->dst);
-			dst_release_immediate(&rt->dst);
-		}
-	}
-	free_percpu(rtp);
-}
-
-void fib_nh_common_release(struct fib_nh_common *nhc)
-{
-	netdev_put(nhc->nhc_dev, &nhc->nhc_dev_tracker);
-	lwtstate_put(nhc->nhc_lwtstate);
-	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
-	rt_fibinfo_free(&nhc->nhc_rth_input);
-	free_nh_exceptions(nhc);
-}
-
 void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
 {
 #ifdef CONFIG_IP_ROUTE_CLASSID
@@ -607,38 +535,6 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	return 1;
 }
 
-int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
-		       struct nlattr *encap, u16 encap_type,
-		       void *cfg, gfp_t gfp_flags,
-		       struct netlink_ext_ack *extack)
-{
-	int err;
-
-	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
-						    gfp_flags);
-	if (!nhc->nhc_pcpu_rth_output)
-		return -ENOMEM;
-
-	if (encap) {
-		struct lwtunnel_state *lwtstate;
-
-		err = lwtunnel_build_state(net, encap_type, encap,
-					   nhc->nhc_family, cfg, &lwtstate,
-					   extack);
-		if (err)
-			goto lwt_failure;
-
-		nhc->nhc_lwtstate = lwtstate_get(lwtstate);
-	}
-
-	return 0;
-
-lwt_failure:
-	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
-	nhc->nhc_pcpu_rth_output = NULL;
-	return err;
-}
-
 int fib_nh_init(struct net *net, struct fib_nh *nh,
 		struct fib_config *cfg, int nh_weight,
 		struct netlink_ext_ack *extack)
@@ -1864,44 +1760,6 @@ static int call_fib_nh_notifiers(struct fib_nh *nh,
 	return NOTIFY_DONE;
 }
 
-/* Update the PMTU of exceptions when:
- * - the new MTU of the first hop becomes smaller than the PMTU
- * - the old MTU was the same as the PMTU, and it limited discovery of
- *   larger MTUs on the path. With that limit raised, we can now
- *   discover larger MTUs
- * A special case is locked exceptions, for which the PMTU is smaller
- * than the minimal accepted PMTU:
- * - if the new MTU is greater than the PMTU, don't make any change
- * - otherwise, unlock and set PMTU
- */
-void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
-{
-	struct fnhe_hash_bucket *bucket;
-	int i;
-
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
-	if (!bucket)
-		return;
-
-	for (i = 0; i < FNHE_HASH_SIZE; i++) {
-		struct fib_nh_exception *fnhe;
-
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
-		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
-			if (fnhe->fnhe_mtu_locked) {
-				if (new <= fnhe->fnhe_pmtu) {
-					fnhe->fnhe_pmtu = new;
-					fnhe->fnhe_mtu_locked = false;
-				}
-			} else if (new < fnhe->fnhe_pmtu ||
-				   orig == fnhe->fnhe_pmtu) {
-				fnhe->fnhe_pmtu = new;
-			}
-		}
-	}
-}
-
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
 {
 	struct hlist_head *head = fib_nh_head(dev);
diff --git a/net/ipv4/netlink.c b/net/ipv4/netlink.c
index b920e1bdcf58..57d4dca16d3e 100644
--- a/net/ipv4/netlink.c
+++ b/net/ipv4/netlink.c
@@ -16,10 +16,12 @@ int rtm_getroute_parse_ip_proto(struct nlattr *attr, u8 *ip_proto, u8 family,
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
 		return 0;
+#if IS_ENABLED(CONFIG_IPV4)
 	case IPPROTO_ICMP:
 		if (family != AF_INET)
 			break;
 		return 0;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case IPPROTO_ICMPV6:
 		if (family != AF_INET6)
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57aa85..b113a31f6150 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1414,7 +1414,7 @@ static bool nexthop_is_good_nh(const struct nexthop *nh)
 
 	switch (nhi->family) {
 	case AF_INET:
-		return ipv4_good_nh(&nhi->fib_nh);
+		return IS_ENABLED(CONFIG_IPV4) && ipv4_good_nh(&nhi->fib_nh);
 	case AF_INET6:
 		return IS_ENABLED(CONFIG_IPV6) && ipv6_good_nh(&nhi->fib6_nh);
 	}
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ca1180dba1de..9c343c9566b7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -613,6 +613,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "fib_sync_mem",
 		.data		= &sysctl_fib_sync_mem,
@@ -622,6 +623,7 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
+#endif
 };
 
 static struct ctl_table ipv4_net_table[] = {
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a130cdfaebfb..8b5f855c8dcb 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -645,9 +645,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	if (cb->strict_check) {
+#if IS_ENABLED(CONFIG_IPV4)
 		err = ip_valid_fib_dump_req(net, nlh, &arg.filter, cb);
 		if (err < 0)
 			goto unlock;
+#endif
 	} else if (nlmsg_len(nlh) >= sizeof(struct rtmsg)) {
 		struct rtmsg *rtm = nlmsg_data(nlh);
 
-- 
2.54.0


