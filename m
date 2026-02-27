Return-Path: <netdev+bounces-261882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFBHEM21oWm+vwQAu9opvQ
	(envelope-from <netdev+bounces-261882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:18:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0881B9941
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85A9A301A536
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DF42EED9;
	Fri, 27 Feb 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck45Hiin"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E22877D8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205085; cv=none; b=AicynmtpPXrTaTGuTjvgvNtzst9LvfUBBg46s2uufPfDKnKMfCjn03CQBhR6yxaMIjgNaXnXvYWQfRBU/SpVrSTKDp94XTIY4EzDcgJfD2kG5JZan6cfod6es1O1v/rivhACd+DOyis7IWqWMEPy6KUekIwU/ihWgk7PVrABBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205085; c=relaxed/simple;
	bh=K2YM0E+tnb9WNh4xifqxDQyPLc2F+VQYAPbDLjtjnZw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NvNs52bmdVr0Bv/8sK1Vz8/E/hDvvaIcaf2P+1HbxKrmGuodFdkv1kjjxTaBqhAtL77GICzkUU0N3SLRpaS11j0KJN9qMz30zyNeeCOXN/oe7W7G7ycJy0nmJqj9C62OEcYIXgKVlGDHymbmBXshgSt72fzU1ekRO18bMCqBCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck45Hiin; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb37db8b79so2881282885a.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772205082; x=1772809882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nt6jbqslHchPNDyAilxguluaN4xSq1rhXN0g+Y6KYAs=;
        b=Ck45Hiinq9kqsoN+nCr+g752VMv/iC1FV8IcndzQTonE8a4LdhLwETN+o5gmJDchYz
         jZowemIpLzbadcNczTwRMs1UC3zvCjBDnX6Ui9iPMl6zsC9qSgbvgtAgxFg2JcTx2ghk
         BfbKIZXgSXMX6t/MJgr9QqDhvISd3DgMR5DgQaBWUUUUYXF2DTDM28l8TTbTe/06m7z/
         W820packUCmxA1nATETi/0YkCPEy+ZvqwKoUeakadTIPgFJQfzW2UnfvA6h/jJr18V2J
         YcjrJqdj4FzeAe6EbSXVl4yhQDd2Vom+Sk0gdrOTKpsdNt2vQmpow7MGrt9VeXAAMZ1B
         wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772205082; x=1772809882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt6jbqslHchPNDyAilxguluaN4xSq1rhXN0g+Y6KYAs=;
        b=O5Mmyv7/zfcF3Ns1V6+TV7hGXGy+ocdsB407pucbQ8o/BMePrLc1XiSNQkpDeDELxI
         QFalnWq+an3KtltyebuRC3+3R0uARj8MslTCT4p9l1ewGR/7g97gMeudde8O79XfH0vF
         piTCsHZ81r9zO6CEf39UKfPbahzdzIgipK/OUlSxQ+yeZo2ElCY3qwQOgUHIPH5tf48x
         6wFvlRefkfXc4QD4O5aH8rJTHxEU6doL4dqXU6FEkT/PMXLKY/3/rvY2sINN6CRb1BLU
         GNt4Mry0MKcLWeeefiT1AoZQNQ1K4wufOsI7S1YNIJBXPY3qNw/a0h/dSTHnm+qetTIP
         l1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVj8k4MbE0OkrW8zpYm0ufuVijN04os0JyXwh0OmzLRRKtsO3oEBj5cx40YafmTqQn18GijDIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/PAqX6ejdcjV13XMD9WExT6EeOmb2W1AWaEzQACcLbN8n9/P
	SvrSWmweudqTMOmHhj+FZ563Z9zqGaBAfXDexPgiKFU2ax/ASpvaN5lft36oOOBIltHfaE4Xn1c
	c3c0VwETkGZBhHg==
X-Received: from qknua4.prod.google.com ([2002:a05:620a:6984:b0:7e6:9c38:913d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2892:b0:8b5:5a33:22d2 with SMTP id af79cd13be357-8cbc8df0b71mr401834885a.46.1772205081485;
 Fri, 27 Feb 2026 07:11:21 -0800 (PST)
Date: Fri, 27 Feb 2026 15:11:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227151120.1346573-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove addr_len argument of recvmsg() handlers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D0881B9941
X-Rspamd-Action: no action

Use msg->msg_namelen as a place holder instead of a
temporary variable, notably in inet[6]_recvmsg().

This removes stack canaries and allows tail-calls.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux
add/remove: 0/0 grow/shrink: 2/19 up/down: 26/-532 (-506)
Function                                     old     new   delta
rawv6_recvmsg                                744     767     +23
vsock_dgram_recvmsg                           55      58      +3
vsock_connectible_recvmsg                     50      47      -3
unix_stream_recvmsg                          161     158      -3
unix_seqpacket_recvmsg                        62      59      -3
unix_dgram_recvmsg                            42      39      -3
tcp_recvmsg                                  546     543      -3
mptcp_recvmsg                               1568    1565      -3
ping_recvmsg                                 806     800      -6
tcp_bpf_recvmsg_parser                       983     974      -9
ip_recv_error                                588     576     -12
ipv6_recv_rxpmtu                             442     428     -14
udp_recvmsg                                 1243    1224     -19
ipv6_recv_error                             1046    1024     -22
udpv6_recvmsg                               1487    1461     -26
raw_recvmsg                                  465     437     -28
udp_bpf_recvmsg                             1027     984     -43
sock_common_recvmsg                          103      27     -76
inet_recvmsg                                 257     175     -82
inet6_recvmsg                                257     175     -82
tcp_bpf_recvmsg                              663     568     -95
Total: Before=25143834, After=25143328, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../chelsio/inline_crypto/chtls/chtls.h         |  2 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c      |  8 ++++----
 drivers/net/ovpn/tcp.c                          |  2 +-
 include/net/inet_common.h                       |  3 +--
 include/net/ip.h                                |  2 +-
 include/net/ipv6.h                              |  6 ++----
 include/net/ping.h                              |  5 ++---
 include/net/sock.h                              |  2 +-
 include/net/tcp.h                               |  2 +-
 net/core/sock.c                                 |  7 +------
 net/ieee802154/socket.c                         |  6 +++---
 net/ipv4/af_inet.c                              | 17 ++++++-----------
 net/ipv4/ip_sockglue.c                          |  4 ++--
 net/ipv4/ping.c                                 |  9 ++++-----
 net/ipv4/raw.c                                  |  6 +++---
 net/ipv4/tcp.c                                  |  5 ++---
 net/ipv4/tcp_bpf.c                              | 17 ++++++++---------
 net/ipv4/udp.c                                  |  9 ++++-----
 net/ipv4/udp_bpf.c                              | 16 ++++++++--------
 net/ipv4/udp_impl.h                             |  3 +--
 net/ipv6/af_inet6.c                             | 11 +++--------
 net/ipv6/datagram.c                             |  9 ++++-----
 net/ipv6/ping.c                                 |  3 +--
 net/ipv6/raw.c                                  |  8 ++++----
 net/ipv6/udp.c                                  | 10 +++++-----
 net/ipv6/udp_impl.h                             |  3 +--
 net/l2tp/l2tp_ip.c                              |  4 ++--
 net/l2tp/l2tp_ip6.c                             |  6 +++---
 net/mptcp/protocol.c                            |  4 ++--
 net/phonet/datagram.c                           |  4 ++--
 net/phonet/pep.c                                |  2 +-
 net/sctp/socket.c                               | 12 ++++++------
 net/tls/tls.h                                   |  2 +-
 net/tls/tls_sw.c                                |  3 +--
 net/unix/af_unix.c                              |  4 ++--
 net/unix/unix_bpf.c                             |  2 +-
 net/vmw_vsock/af_vsock.c                        |  4 ++--
 net/vmw_vsock/vsock_bpf.c                       |  2 +-
 net/xfrm/espintcp.c                             |  2 +-
 39 files changed, 99 insertions(+), 127 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 21e0dfeff1585d4316485889bfb30e30b2251893..1de5744a49b072bb85dc1b9536ad39e68838ec6b 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -567,7 +567,7 @@ void chtls_shutdown(struct sock *sk, int how);
 void chtls_destroy_sock(struct sock *sk);
 int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int chtls_recvmsg(struct sock *sk, struct msghdr *msg,
-		  size_t len, int flags, int *addr_len);
+		  size_t len, int flags);
 void chtls_splice_eof(struct socket *sock);
 int send_tx_flowc_wr(struct sock *sk, int compl,
 		     u32 snd_nxt, u32 rcv_nxt);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index ee19933e2cca56832f8b9b5e798932964b11a84b..c8e99409a52ad9bb0606e61362c58483c18428dc 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1332,7 +1332,7 @@ static void chtls_cleanup_rbuf(struct sock *sk, int copied)
 }
 
 static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			    int flags, int *addr_len)
+			    int flags)
 {
 	struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
 	struct chtls_hws *hws = &csk->tlshws;
@@ -1656,7 +1656,7 @@ static int peekmsg(struct sock *sk, struct msghdr *msg,
 }
 
 int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		  int flags, int *addr_len)
+		  int flags)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct chtls_sock *csk;
@@ -1670,7 +1670,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	buffers_freed = 0;
 
 	if (unlikely(flags & MSG_OOB))
-		return tcp_prot.recvmsg(sk, msg, len, flags, addr_len);
+		return tcp_prot.recvmsg(sk, msg, len, flags);
 
 	if (unlikely(flags & MSG_PEEK))
 		return peekmsg(sk, msg, len, flags);
@@ -1684,7 +1684,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	csk = rcu_dereference_sk_user_data(sk);
 
 	if (is_tls_rx(csk))
-		return chtls_pt_recvmsg(sk, msg, len, flags, addr_len);
+		return chtls_pt_recvmsg(sk, msg, len, flags);
 
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5499c1572f3e2563d09e1f207f5ebcad60f0cd97..65054cc84be55896bde6c344c434b8720dd9e66c 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -158,7 +158,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 }
 
 static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			    int flags, int *addr_len)
+			    int flags)
 {
 	int err = 0, off, copied = 0, ret;
 	struct ovpn_socket *sock;
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 5dd2bf24449efece6158636989ae15bbf8457372..3d747896be300adbddb323fdb657038867b96546 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -59,8 +59,7 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
 			 unsigned short type, unsigned char protocol,
 			 struct net *net);
-int inet_recv_error(struct sock *sk, struct msghdr *msg, int len,
-		    int *addr_len);
+int inet_recv_error(struct sock *sk, struct msghdr *msg, int len);
 
 struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb);
 int inet_gro_complete(struct sk_buff *skb, int nhoff);
diff --git a/include/net/ip.h b/include/net/ip.h
index 69d5cef460040558529e1fdd3e9336986e843362..52264c45935765dd7311f01a8c93d4cb33a256d5 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -812,7 +812,7 @@ int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 int ip_ra_control(struct sock *sk, unsigned char on,
 		  void (*destructor)(struct sock *));
 
-int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len);
+int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
 void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
 		   u32 info, u8 *payload);
 void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 53c5056508be543ae5d312e26dea6ed78fcc04ee..1c0ce51512753bbc2ee5705475f6a99882a8b429 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1129,10 +1129,8 @@ int ip6_datagram_connect_v6_only(struct sock *sk, struct sockaddr_unsized *addr,
 int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr);
 void ip6_datagram_release_cb(struct sock *sk);
 
-int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len,
-		    int *addr_len);
-int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len,
-		     int *addr_len);
+int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len);
+int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len);
 void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
 		     u32 info, u8 *payload);
 void ipv6_local_error(struct sock *sk, int err, struct flowi6 *fl6, u32 info);
diff --git a/include/net/ping.h b/include/net/ping.h
index 05bfd594a64c0e669f81227b796d0a48cea9bfcc..bcbdb5a136e3d3b47968bd01f9a6af0c91188ef1 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -20,8 +20,7 @@
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 struct pingv6_ops {
-	int (*ipv6_recv_error)(struct sock *sk, struct msghdr *msg, int len,
-			       int *addr_len);
+	int (*ipv6_recv_error)(struct sock *sk, struct msghdr *msg, int len);
 	void (*ip6_datagram_recv_common_ctl)(struct sock *sk,
 					     struct msghdr *msg,
 					     struct sk_buff *skb);
@@ -64,7 +63,7 @@ int  ping_getfrag(void *from, char *to, int offset, int fraglen, int odd,
 		  struct sk_buff *);
 
 int  ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		  int flags, int *addr_len);
+		  int flags);
 int  ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 			 void *user_icmph, size_t icmph_len);
 int  ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
diff --git a/include/net/sock.h b/include/net/sock.h
index e7099d3d0416edc06358f18b7addff68d3b9b91e..91fb5a41fba3d55ab2712d39c930ed111df4129b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1316,7 +1316,7 @@ struct proto {
 	int			(*sendmsg)(struct sock *sk, struct msghdr *msg,
 					   size_t len);
 	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
-					   size_t len, int flags, int *addr_len);
+					   size_t len, int flags);
 	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
 					struct sockaddr_unsized *addr, int addr_len);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9921c47491a541957a8eb5907bfa6d445ca1ca90..9cf8785ef0b42460a2389b4aa75570b3aa31cbb4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -500,7 +500,7 @@ void tcp_reset_keepalive_timer(struct sock *sk, unsigned long timeout);
 void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		int flags, int *addr_len);
+		int flags);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
 void tcp_update_recv_tstamps(struct sk_buff *skb,
diff --git a/net/core/sock.c b/net/core/sock.c
index 2032be9a03b5207ec01f3373b3c072464520df18..2636c57c4708fa02f8f3757768f78524c511a3bc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3951,13 +3951,8 @@ int sock_common_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			int flags)
 {
 	struct sock *sk = sock->sk;
-	int addr_len = 0;
-	int err;
 
-	err = sk->sk_prot->recvmsg(sk, msg, size, flags, &addr_len);
-	if (err >= 0)
-		msg->msg_namelen = addr_len;
-	return err;
+	return sk->sk_prot->recvmsg(sk, msg, size, flags);
 }
 EXPORT_SYMBOL(sock_common_recvmsg);
 
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index e542fbe113e7be2aaf829b038ee15d2c0c8bc612..85dce296d751393d6e53e4af62db2065a4591826 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -313,7 +313,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 
 static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		       int flags, int *addr_len)
+		       int flags)
 {
 	size_t copied = 0;
 	int err = -EOPNOTSUPP;
@@ -703,7 +703,7 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 
 static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			 int flags, int *addr_len)
+			 int flags)
 {
 	size_t copied = 0;
 	int err = -EOPNOTSUPP;
@@ -737,7 +737,7 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		saddr->family = AF_IEEE802154;
 		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
-		*addr_len = sizeof(*saddr);
+		msg->msg_namelen = sizeof(*saddr);
 	}
 
 	if (ro->want_lqi) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8036e76aa1e473ba241f1f2ec37e038dccd3b6bd..babcd75a08e273ed8b1d716a6678c95febfdba8d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -877,22 +877,17 @@ void inet_splice_eof(struct socket *sock)
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
 INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
-					  size_t, int, int *));
+					  size_t, int));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags)
 {
 	struct sock *sk = sock->sk;
-	int addr_len = 0;
-	int err;
 
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	err = INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udp_recvmsg,
-			      sk, msg, size, flags, &addr_len);
-	if (err >= 0)
-		msg->msg_namelen = addr_len;
-	return err;
+	return INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udp_recvmsg,
+			       sk, msg, size, flags);
 }
 EXPORT_SYMBOL(inet_recvmsg);
 
@@ -1577,15 +1572,15 @@ __be32 inet_current_timestamp(void)
 }
 EXPORT_SYMBOL(inet_current_timestamp);
 
-int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
+int inet_recv_error(struct sock *sk, struct msghdr *msg, int len)
 {
 	unsigned int family = READ_ONCE(sk->sk_family);
 
 	if (family == AF_INET)
-		return ip_recv_error(sk, msg, len, addr_len);
+		return ip_recv_error(sk, msg, len);
 #if IS_ENABLED(CONFIG_IPV6)
 	if (family == AF_INET6)
-		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
+		return pingv6_ops.ipv6_recv_error(sk, msg, len);
 #endif
 	return -EINVAL;
 }
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 697e18242d6c2a949265a2870a0664d8fef4871d..a55ef327ec932c6c9cabc268514472c2c98e19ee 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -520,7 +520,7 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
 /*
  *	Handle MSG_ERRQUEUE
  */
-int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
+int ip_recv_error(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct sock_exterr_skb *serr;
 	struct sk_buff *skb;
@@ -557,7 +557,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 						   serr->addr_offset);
 		sin->sin_port = serr->port;
 		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 	}
 
 	memcpy(&errhdr.ee, &serr->ee, sizeof(struct sock_extended_err));
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 71d5e17719debb14ca2400edcf5a2cc3153291c6..92ab0e0f6f71eeb0e035dcec4fc8b6be75711ce3 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -848,8 +848,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
-int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
-		 int *addr_len)
+int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct inet_sock *isk = inet_sk(sk);
 	int family = sk->sk_family;
@@ -864,7 +863,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		goto out;
 
 	if (flags & MSG_ERRQUEUE)
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb)
@@ -892,7 +891,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 			sin->sin_port = 0 /* skb->h.uh->source */;
 			sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
 			memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-			*addr_len = sizeof(*sin);
+			msg->msg_namelen = sizeof(*sin);
 		}
 
 		if (inet_cmsg_flags(isk))
@@ -913,7 +912,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 			sin6->sin6_scope_id =
 				ipv6_iface_scope_id(&sin6->sin6_addr,
 						    inet6_iif(skb));
-			*addr_len = sizeof(*sin6);
+			msg->msg_namelen = sizeof(*sin6);
 		}
 
 		if (inet6_sk(sk)->rxopt.all)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e20c41206e29d5655f5378f08fb283f2ecbd2097..34859e537b4926f15996dd1a684ae59a55a1643a 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -739,7 +739,7 @@ static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
  */
 
 static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		       int flags, int *addr_len)
+		       int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	size_t copied = 0;
@@ -751,7 +751,7 @@ static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 
 	if (flags & MSG_ERRQUEUE) {
-		err = ip_recv_error(sk, msg, len, addr_len);
+		err = ip_recv_error(sk, msg, len);
 		goto out;
 	}
 
@@ -777,7 +777,7 @@ static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
 		sin->sin_port = 0;
 		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 	}
 	if (inet_cmsg_flags(inet))
 		ip_cmsg_recv(msg, skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f84d9a45cc9d2876aa3bb436ccbd23e4040d770f..1790d2fa75ade77cda8d0a593e689ea4432734dd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2961,14 +2961,13 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	goto out;
 }
 
-int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
-		int *addr_len)
+int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	int cmsg_flags = 0, ret;
 	struct scm_timestamping_internal tss;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	if (sk_can_busy_loop(sk) &&
 	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index c449a044895e6e71c59937fb8ac8d0b7860a0552..a0215a2da3241a1a0049ceb7f626cd99ca70a1e0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -221,8 +221,7 @@ static bool is_next_msg_fin(struct sk_psock *psock)
 static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  struct msghdr *msg,
 				  size_t len,
-				  int flags,
-				  int *addr_len)
+				  int flags)
 {
 	int peek = flags & MSG_PEEK;
 	struct sk_psock *psock;
@@ -232,14 +231,14 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	u32 seq;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	if (!len)
 		return 0;
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+		return tcp_recvmsg(sk, msg, len, flags);
 
 	lock_sock(sk);
 	tcp = tcp_sk(sk);
@@ -352,24 +351,24 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 }
 
 static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			   int flags, int *addr_len)
+			   int flags)
 {
 	struct sk_psock *psock;
 	int copied, ret;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	if (!len)
 		return 0;
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+		return tcp_recvmsg(sk, msg, len, flags);
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
 	    sk_psock_queue_empty(psock)) {
 		sk_psock_put(sk, psock);
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+		return tcp_recvmsg(sk, msg, len, flags);
 	}
 	lock_sock(sk);
 msg_bytes_ready:
@@ -389,7 +388,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				goto msg_bytes_ready;
 			release_sock(sk);
 			sk_psock_put(sk, psock);
-			return tcp_recvmsg(sk, msg, len, flags, addr_len);
+			return tcp_recvmsg(sk, msg, len, flags);
 		}
 		copied = -EAGAIN;
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6c6b68a66dcd3b3d8f1747fead868c195e04a0a9..27384024ebc013e0c3a0c4181c5d7d1c05957e07 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2070,8 +2070,7 @@ EXPORT_IPV6_MOD(udp_read_skb);
  * 	return it, otherwise we block.
  */
 
-int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
-		int *addr_len)
+int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
@@ -2082,7 +2081,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	bool checksum_valid = false;
 
 	if (flags & MSG_ERRQUEUE)
-		return ip_recv_error(sk, msg, len, addr_len);
+		return ip_recv_error(sk, msg, len);
 
 try_again:
 	off = sk_peek_offset(sk, flags);
@@ -2145,11 +2144,11 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		sin->sin_port = udp_hdr(skb)->source;
 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
 		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 
 		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
 						      (struct sockaddr *)sin,
-						      addr_len);
+						      &msg->msg_namelen);
 	}
 
 	if (udp_test_bit(GRO_ENABLED, sk))
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97a2b0f0c891723b20b1235cc628d1..912f0bfef4afb35aed171e5be1f61d317fd2c8ca 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -12,13 +12,13 @@
 static struct proto *udpv6_prot_saved __read_mostly;
 
 static int sk_udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			  int flags, int *addr_len)
+			  int flags)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
-		return udpv6_prot_saved->recvmsg(sk, msg, len, flags, addr_len);
+		return udpv6_prot_saved->recvmsg(sk, msg, len, flags);
 #endif
-	return udp_prot.recvmsg(sk, msg, len, flags, addr_len);
+	return udp_prot.recvmsg(sk, msg, len, flags);
 }
 
 static bool udp_sk_has_data(struct sock *sk)
@@ -61,23 +61,23 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 }
 
 static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			   int flags, int *addr_len)
+			   int flags)
 {
 	struct sk_psock *psock;
 	int copied, ret;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	if (!len)
 		return 0;
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return sk_udp_recvmsg(sk, msg, len, flags, addr_len);
+		return sk_udp_recvmsg(sk, msg, len, flags);
 
 	if (!psock_has_data(psock)) {
-		ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
+		ret = sk_udp_recvmsg(sk, msg, len, flags);
 		goto out;
 	}
 
@@ -92,7 +92,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (data) {
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
-			ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
+			ret = sk_udp_recvmsg(sk, msg, len, flags);
 			goto out;
 		}
 		copied = -EAGAIN;
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index c7142213fc2112c9e423caa5e6d84bafeaca9936..17a6fa8b14093054b39663c20af0124bc9ff79ae 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -18,8 +18,7 @@ int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 int udp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 
-int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
-		int *addr_len);
+int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
 void udp_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 23cc9b4cb2f122975e8601f83b36c168784b9041..0b995a961359c26b079e01b8cf75fcb1bb6d1a40 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -661,25 +661,20 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 }
 
 INDIRECT_CALLABLE_DECLARE(int udpv6_recvmsg(struct sock *, struct msghdr *,
-					    size_t, int, int *));
+					    size_t, int));
 int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		  int flags)
 {
 	struct sock *sk = sock->sk;
 	const struct proto *prot;
-	int addr_len = 0;
-	int err;
 
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
 	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
-	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
-			      sk, msg, size, flags, &addr_len);
-	if (err >= 0)
-		msg->msg_namelen = addr_len;
-	return err;
+	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
+			       sk, msg, size, flags);
 }
 
 const struct proto_ops inet6_stream_ops = {
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index c564b68a056268c7cbc81b5f29f60289ea9e09eb..3cb84022a461c8db03bc735870fcf74d5037252d 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -452,7 +452,7 @@ static bool ip6_datagram_support_cmsg(struct sk_buff *skb,
 /*
  *	Handle MSG_ERRQUEUE
  */
-int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
+int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct sock_exterr_skb *serr;
@@ -503,7 +503,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 					       &sin->sin6_addr);
 			sin->sin6_scope_id = 0;
 		}
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 	}
 
 	memcpy(&errhdr.ee, &serr->ee, sizeof(struct sock_extended_err));
@@ -545,8 +545,7 @@ EXPORT_SYMBOL_GPL(ipv6_recv_error);
 /*
  *	Handle IPV6_RECVPATHMTU
  */
-int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len,
-		     int *addr_len)
+int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct sk_buff *skb;
@@ -579,7 +578,7 @@ int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len,
 		sin->sin6_port = 0;
 		sin->sin6_scope_id = mtu_info.ip6m_addr.sin6_scope_id;
 		sin->sin6_addr = mtu_info.ip6m_addr.sin6_addr;
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 	}
 
 	put_cmsg(msg, SOL_IPV6, IPV6_PATHMTU, sizeof(mtu_info), &mtu_info);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index e4afc651731a3f27f8f930c99cb5ce4acbb1b5cb..6e90d0bf9f3dabe9f949ec48fccdd1af81bc6942 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -24,8 +24,7 @@
 #include <net/ping.h>
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
-static int dummy_ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len,
-				 int *addr_len)
+static int dummy_ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len)
 {
 	return -EAFNOSUPPORT;
 }
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 27a2680591684eb2cad011e63cdaf396e79c0d77..0ac7046911000d30056e0d1f49a58964c61308cf 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -432,7 +432,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
  */
 
 static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			 int flags, int *addr_len)
+			 int flags)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in6 *, sin6, msg->msg_name);
@@ -444,10 +444,10 @@ static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		return -EOPNOTSUPP;
 
 	if (flags & MSG_ERRQUEUE)
-		return ipv6_recv_error(sk, msg, len, addr_len);
+		return ipv6_recv_error(sk, msg, len);
 
 	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
-		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
+		return ipv6_recv_rxpmtu(sk, msg, len);
 
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb)
@@ -481,7 +481,7 @@ static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		sin6->sin6_flowinfo = 0;
 		sin6->sin6_scope_id = ipv6_iface_scope_id(&sin6->sin6_addr,
 							  inet6_iif(skb));
-		*addr_len = sizeof(*sin6);
+		msg->msg_namelen = sizeof(*sin6);
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 48f73401adf41effe280f62e146edbf9e54b1429..5a3984e59c9060a6589ab7161328952fdd795ea3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -465,7 +465,7 @@ static int udp6_skb_len(struct sk_buff *skb)
  */
 
 int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		  int flags, int *addr_len)
+		  int flags)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
@@ -478,10 +478,10 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int is_udp4;
 
 	if (flags & MSG_ERRQUEUE)
-		return ipv6_recv_error(sk, msg, len, addr_len);
+		return ipv6_recv_error(sk, msg, len);
 
 	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
-		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
+		return ipv6_recv_rxpmtu(sk, msg, len);
 
 try_again:
 	off = sk_peek_offset(sk, flags);
@@ -553,11 +553,11 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				ipv6_iface_scope_id(&sin6->sin6_addr,
 						    inet6_iif(skb));
 		}
-		*addr_len = sizeof(*sin6);
+		msg->msg_namelen = sizeof(*sin6);
 
 		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
 						      (struct sockaddr *)sin6,
-						      addr_len);
+						      &msg->msg_namelen);
 	}
 
 	if (udp_test_bit(GRO_ENABLED, sk))
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
index 8a406be25a3a6dee687a6a02ea0b6a28428abb86..1bd4a573e1bb21145c72cac349628a2da71d1214 100644
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -22,8 +22,7 @@ int udpv6_getsockopt(struct sock *sk, int level, int optname,
 int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		     unsigned int optlen);
 int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
-int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
-		  int *addr_len);
+int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
 void udpv6_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index cac1ff59cb83fbecf9302d1afb0cb39784fac701..acb2570c11f6aa924478ee3562d409bb5fd081e7 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -537,7 +537,7 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 }
 
 static int l2tp_ip_recvmsg(struct sock *sk, struct msghdr *msg,
-			   size_t len, int flags, int *addr_len)
+			   size_t len, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	size_t copied = 0;
@@ -570,7 +570,7 @@ static int l2tp_ip_recvmsg(struct sock *sk, struct msghdr *msg,
 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
 		sin->sin_port = 0;
 		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
-		*addr_len = sizeof(*sin);
+		msg->msg_namelen = sizeof(*sin);
 	}
 	if (inet_cmsg_flags(inet))
 		ip_cmsg_recv(msg, skb);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 05a396ba6a3eb64d0985595af2a2ab76e074ca37..bdaae1b64d25a0513e468e184db72e6336fbdcfd 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -679,7 +679,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 }
 
 static int l2tp_ip6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			    int flags, int *addr_len)
+			    int flags)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_l2tpip6 *, lsa, msg->msg_name);
@@ -691,7 +691,7 @@ static int l2tp_ip6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 
 	if (flags & MSG_ERRQUEUE)
-		return ipv6_recv_error(sk, msg, len, addr_len);
+		return ipv6_recv_error(sk, msg, len);
 
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb)
@@ -719,7 +719,7 @@ static int l2tp_ip6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		lsa->l2tp_conn_id = 0;
 		if (ipv6_addr_type(&lsa->l2tp_addr) & IPV6_ADDR_LINKLOCAL)
 			lsa->l2tp_scope_id = inet6_iif(skb);
-		*addr_len = sizeof(*lsa);
+		msg->msg_namelen = sizeof(*lsa);
 	}
 
 	if (np->rxopt.all)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cf1852b999637ee373030cc4a1c35b9a99757048..3da3da2c81b18c860f91198b03fed074d7c9cac0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2259,7 +2259,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			 int flags, int *addr_len)
+			 int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
@@ -2269,7 +2269,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
diff --git a/net/phonet/datagram.c b/net/phonet/datagram.c
index 976fe250b50955ec51b0c5d73f2dfa132990b60b..22cf23f068328ebed36cf2040434fac64696158c 100644
--- a/net/phonet/datagram.c
+++ b/net/phonet/datagram.c
@@ -109,7 +109,7 @@ static int pn_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 }
 
 static int pn_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		      int flags, int *addr_len)
+		      int flags)
 {
 	struct sk_buff *skb = NULL;
 	struct sockaddr_pn sa;
@@ -143,7 +143,7 @@ static int pn_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (msg->msg_name != NULL) {
 		__sockaddr_check_size(sizeof(sa));
 		memcpy(msg->msg_name, &sa, sizeof(sa));
-		*addr_len = sizeof(sa);
+		msg->msg_namelen = sizeof(sa);
 	}
 
 out:
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 120e711ea78cbda8bd0e10a096bdefbe43f82763..4dbf0914df7df1422d5ed00ce74a7b7b13db1306 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1262,7 +1262,7 @@ struct sk_buff *pep_read(struct sock *sk)
 }
 
 static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		       int flags, int *addr_len)
+		       int flags)
 {
 	struct sk_buff *skb;
 	int err;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05fb00c9c33576d1e18ee31c34974d8b76efa768..d2665bbd41a294a8e993ade514a0b3c3673baf9c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2087,7 +2087,7 @@ static int sctp_skb_pull(struct sk_buff *skb, int len)
  *            5 for complete description of the flags.
  */
 static int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			int flags, int *addr_len)
+			int flags)
 {
 	struct sctp_ulpevent *event = NULL;
 	struct sctp_sock *sp = sctp_sk(sk);
@@ -2096,11 +2096,11 @@ static int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int err = 0;
 	int skb_len;
 
-	pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x, addr_len:%p)\n",
-		 __func__, sk, msg, len, flags, addr_len);
+	pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x)\n",
+		 __func__, sk, msg, len, flags);
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
+		return inet_recv_error(sk, msg, len);
 
 	if (sk_can_busy_loop(sk) &&
 	    skb_queue_empty_lockless(&sk->sk_receive_queue))
@@ -2141,9 +2141,9 @@ static int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	sock_recv_cmsgs(msg, sk, head_skb);
 	if (sctp_ulpevent_is_notification(event)) {
 		msg->msg_flags |= MSG_NOTIFICATION;
-		sp->pf->event_msgname(event, msg->msg_name, addr_len);
+		sp->pf->event_msgname(event, msg->msg_name, &msg->msg_namelen);
 	} else {
-		sp->pf->skb_msgname(head_skb, msg->msg_name, addr_len);
+		sp->pf->skb_msgname(head_skb, msg->msg_name, &msg->msg_namelen);
 	}
 
 	/* Check if we allow SCTP_NXTINFO. */
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fcb9edadc29b4b1653141f7d541cdc..e8f81a006520027110962655f7b69a5ca58d7fb6 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -161,7 +161,7 @@ void tls_sw_free_resources_rx(struct sock *sk);
 void tls_sw_release_resources_rx(struct sock *sk);
 void tls_sw_free_ctx_rx(struct tls_context *tls_ctx);
 int tls_sw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		   int flags, int *addr_len);
+		   int flags);
 bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5fe07f110fe8c7f3a61242428ac5f0b6bfded810..a656ce2357589672bcef24343fef0aa83606cf41 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2031,8 +2031,7 @@ static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
 int tls_sw_recvmsg(struct sock *sk,
 		   struct msghdr *msg,
 		   size_t len,
-		   int flags,
-		   int *addr_len)
+		   int flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63aabc814f7edd31e8c0b6fafa02ce7..3a7e00c063c383aa7c063c21029e45377b1aa8f6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2665,7 +2665,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
 	if (prot != &unix_dgram_proto)
-		return prot->recvmsg(sk, msg, size, flags, NULL);
+		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return __unix_dgram_recvmsg(sk, msg, size, flags);
 }
@@ -3139,7 +3139,7 @@ static int unix_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
 	if (prot != &unix_stream_proto)
-		return prot->recvmsg(sk, msg, size, flags, NULL);
+		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return unix_stream_read_generic(&state, true);
 }
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index e0d30d6d22acbc7b48fa83b54201a821c58d2aa6..d14cd5454a8d558e589c1e36cdaa373bfb3f8e00 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -49,7 +49,7 @@ static int __unix_recvmsg(struct sock *sk, struct msghdr *msg,
 }
 
 static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
-			    size_t len, int flags, int *addr_len)
+			    size_t len, int flags)
 {
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_psock *psock;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2f7d94d682cbed082259d74e084e594e82b4cd47..f0ab2f13e9dbddd8e1207a0c06977b025165af34 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1502,7 +1502,7 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot != &vsock_proto)
-		return prot->recvmsg(sk, msg, len, flags, NULL);
+		return prot->recvmsg(sk, msg, len, flags);
 #endif
 
 	return __vsock_dgram_recvmsg(sock, msg, len, flags);
@@ -2575,7 +2575,7 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot != &vsock_proto)
-		return prot->recvmsg(sk, msg, len, flags, NULL);
+		return prot->recvmsg(sk, msg, len, flags);
 #endif
 
 	return __vsock_connectible_recvmsg(sock, msg, len, flags);
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 07b96d56f3a577af71021b1b8132743554996c4f..9049d26486460cae4d06ba9c78e75e453b6a595d 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -74,7 +74,7 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
 }
 
 static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
-			     size_t len, int flags, int *addr_len)
+			     size_t len, int flags)
 {
 	struct sk_psock *psock;
 	struct vsock_sock *vsk;
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index e1b11ab59f6ee834bee093e2011f48be6757fde7..9988324190971e2221d066900a35dc230dac9f79 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -133,7 +133,7 @@ static int espintcp_parse(struct strparser *strp, struct sk_buff *skb)
 }
 
 static int espintcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			    int flags, int *addr_len)
+			    int flags)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 	struct sk_buff *skb;
-- 
2.53.0.473.g4a7958ca14-goog


