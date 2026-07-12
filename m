Return-Path: <netdev+bounces-306906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hnm+Df3wUmpvVgMAu9opvQ
	(envelope-from <netdev+bounces-306906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF07436C1
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306906-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306906-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80BF0303A71B
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336621CA13;
	Sun, 12 Jul 2026 01:40:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0333238C1A
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820443; cv=none; b=d/Ja94VIGD8vJ4Jpvyvrd/AzrBVTuEKImCNRKFkSrlMaU1BQsZMtJIfmo42DXgv8K+P0AUEvhhwQutZBE8yDF+5fRu2xoXTsPHJawXHOD2RTVxyjUNGGQobNhPhwIixafEIiSI82UGBvjfSTcmUQhymvqfsYXdafOTMbW6JrABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820443; c=relaxed/simple;
	bh=D9jzOJpQJi5V8TXDJqp9bdaER+0QM5ON+1ZSCyc/Klw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbGOFLz5ytL/pR8lqSk896lmZnhskCXdWvtt2kTZI3LaFC6Tgq7+nE5FL2bf2VQ96zWsxbeE+UwLE06wGtbfBmX7X5KFtlqy7Mkvh1wCKOdFq4xffEiFdlFUu8MA9X1UEoAf1K/jyjta9W/GJ3cFhdPWV2GAb/yqZpni44sdUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA96B76D7E;
	Sun, 12 Jul 2026 01:40:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E774F779B5;
	Sun, 12 Jul 2026 01:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHleNY/wUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:40:31 +0000
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
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jeff Layton <jlayton@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/13 RFC net-next] net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
Date: Sun, 12 Jul 2026 03:39:01 +0200
Message-ID: <20260712013941.4570-4-fmancera@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306906-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,gmail.com,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:willemb@google.com,m:kuniyu@google.com,m:kees@kernel.org,m:richardbgobert@gmail.com,m:jiayuan.chen@linux.dev,m:jlayton@kernel.org,m:tpluszz77@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FEF07436C1

To enable compiling the INET subsystem without IPv4, shared generic
utilities must be relocated and IPv4 socket logic must be guarded for
CONFIG_IPV4.

This patch moves the generic ip_generec_getfrag() from ip_output.c to
af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
reject IPv4-specific ioctls, protocol registrations and bind requests.
The same guard is added to reject IPv4-mapped IPv6.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/af_inet.c   | 96 +++++++++++++++++++++++++++++++++++++-------
 net/ipv4/ip_output.c | 18 ---------
 net/ipv6/af_inet6.c  |  5 +++
 net/ipv6/datagram.c  | 12 ++++++
 4 files changed, 99 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..cd8e129394e4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -129,6 +129,28 @@
 int disable_ipv6_mod;
 EXPORT_SYMBOL(disable_ipv6_mod);
 
+/* Keep the function here for now as it is generic, it should be moved
+ * to a common L3 place
+ */
+int
+ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
+{
+	struct msghdr *msg = from;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (!copy_from_iter_full(to, len, &msg->msg_iter))
+			return -EFAULT;
+	} else {
+		__wsum csum = 0;
+
+		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
+			return -EFAULT;
+		skb->csum = csum_block_add(skb->csum, csum, odd);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(ip_generic_getfrag);
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
@@ -425,8 +447,10 @@ int inet_release(struct socket *sock)
 		if (!sk->sk_kern_sock)
 			BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk);
 
+#if IS_ENABLED(CONFIG_IPV4)
 		/* Applications forget to leave groups before exiting */
 		ip_mc_drop_socket(sk);
+#endif
 
 		/* If linger is set, we don't return until the close
 		 * is complete.  Otherwise we return immediately. The
@@ -478,6 +502,7 @@ EXPORT_SYMBOL(inet_bind);
 int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		u32 flags)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
@@ -570,6 +595,9 @@ int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		release_sock(sk);
 out:
 	return err;
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
@@ -965,18 +993,24 @@ EXPORT_SYMBOL(inet_shutdown);
 int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct sock *sk = sock->sk;
-	int err = 0;
-	struct net *net = sock_net(sk);
+#if IS_ENABLED(CONFIG_IPV4)
 	void __user *p = (void __user *)arg;
-	struct ifreq ifr;
+	struct net *net = sock_net(sk);
 	struct rtentry rt;
+	struct ifreq ifr;
+#endif
+	int err = 0;
 
 	switch (cmd) {
 	case SIOCADDRT:
 	case SIOCDELRT:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (copy_from_user(&rt, p, sizeof(struct rtentry)))
 			return -EFAULT;
 		err = ip_rt_ioctl(net, cmd, &rt);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	case SIOCRTMSG:
 		err = -EINVAL;
@@ -984,18 +1018,26 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCDARP:
 	case SIOCGARP:
 	case SIOCSARP:
+#if IS_ENABLED(CONFIG_IPV4)
 		err = arp_ioctl(net, cmd, (void __user *)arg);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	case SIOCGIFADDR:
 	case SIOCGIFBRDADDR:
 	case SIOCGIFNETMASK:
 	case SIOCGIFDSTADDR:
 	case SIOCGIFPFLAGS:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (get_user_ifreq(&ifr, NULL, p))
 			return -EFAULT;
 		err = devinet_ioctl(net, cmd, &ifr);
 		if (!err && put_user_ifreq(&ifr, p))
 			err = -EFAULT;
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 
 	case SIOCSIFADDR:
@@ -1004,9 +1046,13 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 	case SIOCSIFPFLAGS:
 	case SIOCSIFFLAGS:
+#if IS_ENABLED(CONFIG_IPV4)
 		if (get_user_ifreq(&ifr, NULL, p))
 			return -EFAULT;
 		err = devinet_ioctl(net, cmd, &ifr);
+#else
+		err = -EOPNOTSUPP;
+#endif
 		break;
 	default:
 		if (sk->sk_prot->ioctl)
@@ -1023,6 +1069,7 @@ EXPORT_SYMBOL(inet_ioctl);
 static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 		struct compat_rtentry __user *ur)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	compat_uptr_t rtdev;
 	struct rtentry rt;
 
@@ -1038,6 +1085,9 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 
 	rt.rt_dev = compat_ptr(rtdev);
 	return ip_rt_ioctl(sock_net(sk), cmd, &rt);
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
@@ -1156,6 +1206,7 @@ static const struct net_proto_family inet_family_ops = {
 	.owner	= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_IPV4)
 /* Upon startup we insert all the elements in inetsw_array[] into
  * the linked list inetsw.
  */
@@ -1169,7 +1220,6 @@ static struct inet_protosw inetsw_array[] =
 		.flags =      INET_PROTOSW_PERMANENT |
 			      INET_PROTOSW_ICSK,
 	},
-
 	{
 		.type =       SOCK_DGRAM,
 		.protocol =   IPPROTO_UDP,
@@ -1196,6 +1246,7 @@ static struct inet_protosw inetsw_array[] =
 };
 
 #define INETSW_ARRAY_LEN ARRAY_SIZE(inetsw_array)
+#endif
 
 void inet_register_protosw(struct inet_protosw *p)
 {
@@ -1261,6 +1312,7 @@ EXPORT_SYMBOL(inet_unregister_protosw);
 
 static int inet_sk_reselect_saddr(struct sock *sk)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_sock *inet = inet_sk(sk);
 	__be32 old_saddr = inet->inet_saddr;
 	__be32 daddr = inet->inet_daddr;
@@ -1312,6 +1364,9 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 	 * uniqueness. Wait for troubles.
 	 */
 	return __sk_prot_rehash(sk);
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 int inet_sk_rebuild_header(struct sock *sk)
@@ -1364,6 +1419,7 @@ void inet_sk_state_store(struct sock *sk, int newstate)
 struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 				 netdev_features_t features)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	bool udpfrag = false, fixedid = false, gso_partial, encap;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	const struct net_offload *ops;
@@ -1454,6 +1510,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 out:
 	return segs;
+#else
+	return ERR_PTR(-EPROTONOSUPPORT);
+#endif
 }
 
 static struct sk_buff *ipip_gso_segment(struct sk_buff *skb,
@@ -1777,6 +1836,10 @@ static int __init init_ipv4_mibs(void)
 	return register_pernet_subsys(&ipv4_mib_ops);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
+static int ipv4_proc_init(void);
+#endif
+
 static __net_init int inet_init_net(struct net *net)
 {
 	/*
@@ -1827,8 +1890,6 @@ static int __init init_inet_pernet_ops(void)
 	return register_pernet_subsys(&af_inet_ops);
 }
 
-static int ipv4_proc_init(void);
-
 /*
  *	IP protocol layer initialiser
  */
@@ -1873,26 +1934,30 @@ static int __init ipv4_offload_init(void)
 
 fs_initcall(ipv4_offload_init);
 
+#if IS_ENABLED(CONFIG_IPV4)
 static struct packet_type ip_packet_type __read_mostly = {
 	.type = cpu_to_be16(ETH_P_IP),
 	.func = ip_rcv,
 	.list_func = ip_list_rcv,
 };
+#endif
 
 static int __init inet_init(void)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_protosw *q;
 	struct list_head *r;
 	int rc;
+#endif
 
 	sock_skb_cb_check_size(sizeof(struct inet_skb_parm));
 
+#if IS_ENABLED(CONFIG_IPV4)
 	raw_hashinfo_init(&raw_v4_hashinfo);
 
 	rc = proto_register(&tcp_prot, 1);
 	if (rc)
 		goto out;
-
 	rc = proto_register(&udp_prot, 1);
 	if (rc)
 		goto out_unregister_tcp_proto;
@@ -1929,7 +1994,6 @@ static int __init inet_init(void)
 	};
 	if (inet_add_protocol(&net_hotdata.udp_protocol, IPPROTO_UDP) < 0)
 		pr_crit("%s: Cannot add UDP protocol\n", __func__);
-
 	net_hotdata.tcp_protocol = (struct net_protocol) {
 		.handler	=	tcp_v4_rcv,
 		.err_handler	=	tcp_v4_err,
@@ -1961,7 +2025,7 @@ static int __init inet_init(void)
 	 */
 
 	ip_init();
-
+#endif /* CONFIG_IPV4 */
 	/* Initialise per-cpu ipv4 mibs */
 	if (init_ipv4_mibs())
 		panic("%s: Cannot init ipv4 mibs\n", __func__);
@@ -1983,6 +2047,9 @@ static int __init inet_init(void)
 	if (icmp_init() < 0)
 		panic("Failed to create the ICMP control socket.\n");
 
+	if (init_inet_pernet_ops())
+		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
+#if IS_ENABLED(CONFIG_IPV4)
 	/*
 	 *	Initialise the multicast router
 	 */
@@ -1990,19 +2057,17 @@ static int __init inet_init(void)
 	if (ip_mr_init())
 		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
 #endif
-
-	if (init_inet_pernet_ops())
-		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
-
 	ipv4_proc_init();
 
 	ipfrag_init();
 
 	dev_add_pack(&ip_packet_type);
+#endif /* CONFIG_IPV4 */
 
 	ip_tunnel_core_init();
 
-	rc = 0;
+	return 0;
+#if IS_ENABLED(CONFIG_IPV4)
 out:
 	return rc;
 out_unregister_raw_proto:
@@ -2012,12 +2077,14 @@ static int __init inet_init(void)
 out_unregister_tcp_proto:
 	proto_unregister(&tcp_prot);
 	goto out;
+#endif
 }
 
 fs_initcall(inet_init);
 
 /* ------------------------------------------------------------------------ */
 
+#if IS_ENABLED(CONFIG_IPV4)
 #ifdef CONFIG_PROC_FS
 static int __init ipv4_proc_init(void)
 {
@@ -2054,3 +2121,4 @@ static int __init ipv4_proc_init(void)
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
+#endif
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e6dd1e5b8c32..beb2f6a27556 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -928,24 +928,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(ip_do_fragment);
 
-int
-ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
-{
-	struct msghdr *msg = from;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		if (!copy_from_iter_full(to, len, &msg->msg_iter))
-			return -EFAULT;
-	} else {
-		__wsum csum = 0;
-		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
-			return -EFAULT;
-		skb->csum = csum_block_add(skb->csum, csum, odd);
-	}
-	return 0;
-}
-EXPORT_SYMBOL(ip_generic_getfrag);
-
 static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..5652069d5eaa 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -299,6 +299,7 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 
 	/* Check if the address belongs to the host. */
 	if (addr_type == IPV6_ADDR_MAPPED) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct net_device *dev = NULL;
 		int chk_addr_ret;
 
@@ -329,6 +330,10 @@ int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 			err = -EADDRNOTAVAIL;
 			goto out;
 		}
+#else
+		err = -EADDRNOTAVAIL;
+		goto out;
+#endif
 	} else {
 		if (addr_type != IPV6_ADDR_ANY) {
 			struct net_device *dev = NULL;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 38d7b4845281..8165277629ad 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -33,10 +33,12 @@
 #include <linux/errqueue.h>
 #include <linux/uaccess.h>
 
+#if IS_ENABLED(CONFIG_IPV4)
 static bool ipv6_mapped_addr_any(const struct in6_addr *a)
 {
 	return ipv6_addr_v4mapped(a) && (a->s6_addr32[3] == 0);
 }
+#endif
 
 static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 				       const struct sock *sk)
@@ -153,10 +155,14 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	int			err;
 
 	if (usin->sin6_family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		if (ipv6_only_sock(sk))
 			return -EAFNOSUPPORT;
 		err = __ip4_datagram_connect(sk, uaddr, addr_len);
 		goto ipv4_connected;
+#else
+		return -EAFNOSUPPORT;
+#endif
 	}
 
 	if (addr_len < SIN6_LEN_RFC2133)
@@ -184,6 +190,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	daddr = &usin->sin6_addr;
 
 	if (addr_type & IPV6_ADDR_MAPPED) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct sockaddr_in sin;
 
 		if (ipv6_only_sock(sk)) {
@@ -217,6 +224,9 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		}
 
 		goto out;
+#else
+		return -ENETUNREACH;
+#endif
 	}
 
 	if (__ipv6_addr_needs_scope_id(addr_type)) {
@@ -522,10 +532,12 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len)
 				ipv6_iface_scope_id(&sin->sin6_addr,
 						    IP6CB(skb)->iif);
 		} else {
+#if IS_ENABLED(CONFIG_IPV4)
 			ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr,
 					       &sin->sin6_addr);
 			if (inet_cmsg_flags(inet_sk(sk)))
 				ip_cmsg_recv(msg, skb);
+#endif
 		}
 	}
 
-- 
2.54.0


