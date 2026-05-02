Return-Path: <netdev+bounces-283401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGdACrrx9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A224B2015
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 345F4300CFCA
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC636D51F;
	Sat,  2 May 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="CLcZAMii"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481436C9CB;
	Sat,  2 May 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725877; cv=none; b=caHIvzGuskU7Q/txVU9PmYW5VbOavXjl66BDV+bKXL5OK0QydfpTY1isKPlselpYJW2vZFO+Tamewiuw8+IF+TWpJ4LXRT4d+sqfqOYRoboDppZdJBpMO6Csav9UaXFo9cdVElp49tQN1yFiVD52qqQrWjp0bHkgrKy7HlxtJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725877; c=relaxed/simple;
	bh=+rGcPBgtyaeiKQsQSraonrw6gQGDj+zneIU/vWbo84M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPqBEjHi5ZTaJSthPQKZRiRR9sWWYuVny3LL2Cg46P56QTZPghbVhxT3ChhHmggXuKorwtceglJ4UVnyhA8MHZhFIIlZEluuKUKjVNnWkd9mdJZouy6s9VZOIkR/j9zRqD1sH1LPLXUr9GCuWn+NurluhjV2HjU6ktJp+KbSXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=CLcZAMii; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725873; bh=+rGcPBgtyaeiKQsQSraonrw6gQGDj+zneIU/vWbo84M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLcZAMiiFjpelKptvbGI/lXtUOHb7uZwCaOaJueaUSnB3qkf0Nq2a8NKiFSty/oL6
	 211tOtdM2EV1XnPH5278oB6e2gyF3Iw/OPbeQzfSwRi1C2Mj0CJoK39q2pAIamEJ28
	 FSZsPVfQngwwuzrPLSzUj8/K/hbpDK3uIfuLFQoURRl9vQ0V/1V1n3FhuZlQoBR5+e
	 yZEIBQqpaoQOkZ++BW0pPDat7/YzbETwbEfV/cHLkZo4KOplyGE9NoizsHC2frrs3u
	 yE5LxbFo8iI0KIQGIyDZc+rfuCCgMKGWMUMw4+Ylg582+r8tPhwiGTB+ugj7ruJn5V
	 sOHOlpV1bEsMg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 837DF12591E;
	Sat,  2 May 2026 14:44:33 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 3/7] landlock: Add UDP send access control
Date: Sat,  2 May 2026 14:43:02 +0200
Message-Id: <20260502124306.3975990-4-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6A224B2015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283401-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[buffet.re:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add the second half of LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP: control the
ability to specify an explicit destination when sending a datagram, to
override any remote peer set on a UDP socket (in sendto(), sendmsg(), and
sendmmsg()). It will make the right useful for clients which want to
send datagrams while specifying a destination address each time.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h |  4 ++
 security/landlock/net.c       | 70 ++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 22c8cc63f30e..b147223efc97 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -396,6 +396,10 @@ struct landlock_net_port_attr {
  *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on a specific port, and
  *     call :manpage:`bind(2)` on that port before trying to
  *     :manpage:`connect(2)` or send datagrams.
+ *
+ * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination address
+ *   family is not supported for IPv6 UDP sockets: you will need to use a
+ *   ``NULL`` address instead.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 045881f81295..8a53aebdb8c6 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -44,7 +44,8 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
-				       access_mask_t access_request)
+				       access_mask_t access_request,
+				       bool connecting)
 {
 	__be16 port;
 	struct layer_access_masks layer_masks = {};
@@ -69,7 +70,8 @@ static int current_check_access_socket(struct socket *const sock,
 	switch (address->sa_family) {
 	case AF_UNSPEC:
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
-		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
+		    (access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP &&
+		     connecting)) {
 			/*
 			 * Connecting to an address with AF_UNSPEC dissolves
 			 * the remote association while retaining the socket
@@ -82,6 +84,35 @@ static int current_check_access_socket(struct socket *const sock,
 			 * inconsistencies and return -EINVAL if needed.
 			 */
 			return 0;
+		} else if (access_request ==
+			   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
+			if (sock->sk->__sk_common.skc_family == AF_INET6) {
+				/*
+				 * We cannot allow sending UDP datagrams to an
+				 * explicit AF_UNSPEC address on IPv6 sockets,
+				 * even if AF_UNSPEC is treated as "no address"
+				 * on such sockets (so it should always be allowed).
+				 * That's because the socket's family can change under
+				 * our feet (if another thread calls setsockopt(IPV6_ADDRFORM))
+				 * to IPv4, which would then treat AF_UNSPEC as
+				 * AF_INET.
+				 */
+				audit_net.family = AF_UNSPEC;
+				landlock_init_layer_masks(
+					subject->domain, access_request,
+					&layer_masks, LANDLOCK_KEY_NET_PORT);
+				landlock_log_denial(
+					subject,
+					&(struct landlock_request){
+						.type = LANDLOCK_REQUEST_NET_ACCESS,
+						.audit.type =
+							LSM_AUDIT_DATA_NET,
+						.audit.u.net = &audit_net,
+						.access = access_request,
+						.layer_masks = &layer_masks,
+					});
+				return -EACCES;
+			}
 		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
 			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			/*
@@ -124,7 +155,10 @@ static int current_check_access_socket(struct socket *const sock,
 		} else {
 			WARN_ON_ONCE(1);
 		}
-		/* Only for bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket. */
+		/*
+		 * For bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket and
+		 * for sending to AF_UNSPEC addresses on IPv4 socket.
+		 */
 		fallthrough;
 	case AF_INET: {
 		const struct sockaddr_in *addr4;
@@ -257,7 +291,7 @@ static int current_check_autobind_udp_socket(struct socket *const sock)
 
 	return current_check_access_socket(sock, (struct sockaddr *)&port0,
 					   sizeof(port0),
-					   LANDLOCK_ACCESS_NET_BIND_UDP);
+					   LANDLOCK_ACCESS_NET_BIND_UDP, false);
 }
 
 static int hook_socket_bind(struct socket *const sock,
@@ -273,7 +307,7 @@ static int hook_socket_bind(struct socket *const sock,
 		return 0;
 
 	return current_check_access_socket(sock, address, addrlen,
-					   access_request);
+					   access_request, false);
 }
 
 static int hook_socket_connect(struct socket *const sock,
@@ -291,7 +325,7 @@ static int hook_socket_connect(struct socket *const sock,
 		return 0;
 
 	ret = current_check_access_socket(sock, address, addrlen,
-					  access_request);
+					  access_request, true);
 
 	if (ret == 0 && sk_is_udp(sock->sk))
 		ret = current_check_autobind_udp_socket(sock);
@@ -299,9 +333,33 @@ static int hook_socket_connect(struct socket *const sock,
 	return ret;
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	struct sockaddr *const address = msg->msg_name;
+	const int addrlen = msg->msg_namelen;
+	access_mask_t access_request;
+	int ret = 0;
+
+	if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+	else
+		return 0;
+
+	if (address != NULL)
+		ret = current_check_access_socket(sock, address, addrlen,
+						  access_request, false);
+
+	if (ret == 0)
+		ret = current_check_autobind_udp_socket(sock);
+
+	return ret;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
 };
 
 __init void landlock_add_net_hooks(void)
-- 
2.39.5


