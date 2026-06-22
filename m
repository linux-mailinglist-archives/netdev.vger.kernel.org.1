Return-Path: <netdev+bounces-301039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pk9CNhkSOWpGmQcAu9opvQ
	(envelope-from <netdev+bounces-301039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:44:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 759346AECD1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VHLZJPif;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301039-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07D873011352
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFBE3A257A;
	Mon, 22 Jun 2026 10:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE6396B79;
	Mon, 22 Jun 2026 10:44:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125067; cv=none; b=qlRKhTLG07A+gbusRmReNH3VdwNAXb69WEgmwjiaNPfDFVts0hxKKylqmhG82Jm7SAQbuMYT6nHnmwI6JkkLOZ9AqJH1vuHyP/mZCATzqMe0yi90+XC+hhGYW96Pjzoi2vjnuaqrQENj8u8EIrZzTxioegui6V14DafJOdySsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125067; c=relaxed/simple;
	bh=XBYv5zz3sOwlsm9ckbexl4pEDfCTMycnVQDACpe4atQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wvqdl771UhhBnw/ESTXcJn3d/XEEGj8CHe8uPZFyeSoYIVPNMkGsYBGfbuJUAzGiVmOkTkeEjMPpdkMaZXdYZIBM66HkHpit/JEqc+mcM1njHkPYuwyoThA0P1GXbYGUYMcmg2Tj+cRUM2EfdYp8kDkFBSnCupTQ3OP//iwmTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHLZJPif; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77C21F000E9;
	Mon, 22 Jun 2026 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125066;
	bh=NICoJhyso/xKwA0V9BHghdzw8uXRKsBqUsvBGmFqrNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VHLZJPifVrl03prN+KWe2+bHWPLEtRk3bauElubabnGTUnWNEXR/pYnm359flu9l6
	 8zLLBASimj5pCC+nxL9vO2NNa9mSB9B1U+ppH66etajQq42Dw0MHTHqbEOGV89ERtm
	 VRX7uRYP8u5Tqq612M89qYsIMerr8mXdO918hKIQbFUz8g/9hKTcZertAZVXmyGEDB
	 di0utKFzj6iRDMggl0dyfGWKuQajCOPDZ0bPVwcbEjj1b8QZ4GyCu/4gXP8TtEg7Tc
	 V9++7tLWDh5+h2XQKrg0ncXyQp/XtMX/AK3lA33yMhkNNlUteT7sVfc8YjArpe8xlQ
	 U49dybBsmVKbQ==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 03/17] tls: add protocol dimension to tls operation cache
Date: Mon, 22 Jun 2026 18:43:23 +0800
Message-ID: <1d024f02806622ab3ad467e90ea7311dd5810073.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301039-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 759346AECD1

From: Geliang Tang <tanggeliang@kylinos.cn>

The current TLS operation cache is indexed solely by IP version
(IPv4/IPv6). This was sufficient when only TCP was supported.
Rename TLS_NUM_PROTS to TLS_NUM_FAMILY to accurately reflect that it
represents the number of address families.

With the introduction of MPTCP, both TCP and MPTCP sockets within the
same IP version now share the same cache entries. When an MPTCP socket
enables TLS, it overwrites the cache with MPTCP-specific operations,
causing existing TCP TLS sockets to use the wrong ops, leading to type
confusion and kernel panics.

Fix by extending the cache arrays with a protocol dimension to separate
TCP and MPTCP. Introduce TLSTCP and TLSMPTCP enum values, along with
separate saved protocol pointers and mutexes for MPTCP. update_sk_prot()
and __tls_build_proto() now select the appropriate cache based on
sk->sk_protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index be824affd1b1..94133d62f73e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -53,7 +53,13 @@ MODULE_ALIAS_TCP_ULP("tls");
 enum {
 	TLSV4,
 	TLSV6,
-	TLS_NUM_PROTS,
+	TLS_NUM_FAMILY,
+};
+
+enum {
+	TLSTCP,
+	TLSMPTCP,
+	TLS_NUM_PROTO,
 };
 
 #define CHECK_CIPHER_DESC(cipher,ci)				\
@@ -117,23 +123,30 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
+static const struct proto *saved_mptcpv6_prot;
+static DEFINE_MUTEX(mptcpv6_prot_mutex);
 static const struct proto *saved_tcpv6_prot;
 static DEFINE_MUTEX(tcpv6_prot_mutex);
+static const struct proto *saved_mptcpv4_prot;
+static DEFINE_MUTEX(mptcpv4_prot_mutex);
 static const struct proto *saved_tcpv4_prot;
 static DEFINE_MUTEX(tcpv4_prot_mutex);
-static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
-static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+static struct proto
+tls_prots[TLS_NUM_FAMILY][TLS_NUM_PROTO][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+static struct proto_ops
+tls_proto_ops[TLS_NUM_FAMILY][TLS_NUM_PROTO][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
 static void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
+	int proto = sk->sk_protocol == IPPROTO_MPTCP ? TLSMPTCP : TLSTCP;
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &tls_prots[ip_ver][proto][ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &tls_proto_ops[ip_ver][proto][ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -971,18 +984,19 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 static void __tls_build_proto(struct sock *sk,
 			      const struct proto *saved_prot,
 			      struct mutex *prot_mutex,
-			      int family)
+			      int family, int protocol)
 {
+	int proto = sk->sk_protocol == IPPROTO_MPTCP ? TLSMPTCP : TLSTCP;
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	if (ip_ver == family) {
+	if (ip_ver == family && proto == protocol) {
 		/* smp_load_acquire pairs with smp_store_release below */
 		if (unlikely(prot != smp_load_acquire(&saved_prot))) {
 			mutex_lock(prot_mutex);
 			if (likely(prot != saved_prot)) {
-				build_protos(tls_prots[family], prot);
-				build_proto_ops(tls_proto_ops[family],
+				build_protos(tls_prots[family][protocol], prot);
+				build_proto_ops(tls_proto_ops[family][protocol],
 						sk->sk_socket->ops);
 				/* pairs with smp_load_acquire above */
 				smp_store_release(&saved_prot, prot);
@@ -995,10 +1009,14 @@ static void __tls_build_proto(struct sock *sk,
 static void tls_build_proto(struct sock *sk)
 {
 	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
+	__tls_build_proto(sk, saved_mptcpv6_prot, &mptcpv6_prot_mutex,
+			  TLSV6, TLSMPTCP);
 	__tls_build_proto(sk, saved_tcpv6_prot, &tcpv6_prot_mutex,
-			  TLSV6);
+			  TLSV6, TLSTCP);
+	__tls_build_proto(sk, saved_mptcpv4_prot, &mptcpv4_prot_mutex,
+			  TLSV4, TLSMPTCP);
 	__tls_build_proto(sk, saved_tcpv4_prot, &tcpv4_prot_mutex,
-			  TLSV4);
+			  TLSV4, TLSTCP);
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
-- 
2.53.0


