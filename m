Return-Path: <netdev+bounces-298216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47fMBP/hKmoTywMAu9opvQ
	(envelope-from <netdev+bounces-298216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04366737E0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=QPDrUPSB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298216-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298216-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28A5E305EB05
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0C48A2BE;
	Thu, 11 Jun 2026 16:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA247ECE1;
	Thu, 11 Jun 2026 16:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194927; cv=none; b=FN1WEBs+iZOL9DUTRXB1zUf1F1v6ePR+qjHg0J+EDM/lx/ojaBRlIbWL9qLf1v0/ym5+/vFpPRa1rQrOcHjC0nD4pA/jL3DRoDokqoT1hln2zTp6EBGzKfFFbapDJICKy1w5EP3OkRMtrjBFbbZJdbStHfNf/V0cf+NlJaGZCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194927; c=relaxed/simple;
	bh=32DTtbncqLOKunhSApTn8IyZxuTnNOgKWpIEaQeBkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTeQgi8RLxi0iSvetzzphuAdYyijMDb6gEOGf4jTKYKqTWMc8WmiBHLLtFD+s57YR9pICxikY1Ef/6hZMc43dQZd0P9DuIKYWdQdRNNMIbBt13v27wDcUK0olNrsLtaCidwJ3GsP6CcYkAdPbYBGCSwpXOocje1GApaL5A+Epao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=QPDrUPSB; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781194923; bh=32DTtbncqLOKunhSApTn8IyZxuTnNOgKWpIEaQeBkOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPDrUPSBJOvXutXd3QS0+Wtx/sTjuP1BzdFIxHFSnZJ+qui3bj+k43a5VvlSvjaEF
	 UoLqimQ3wxhjqQRBa7HAYWjbMCxzko98hvximsaL2d5fqSfUAY0284Yd0CIrAGu5Dw
	 LXZfNH/KZkDOXPIYMaUgx57U38kBVwnu8YiBHP14OrFtRm/Dg5TDLNtoXTHH4+te54
	 frTMgBYyldlV3P9O5m6I5hYEi0G8vN3Dtq+mwvVqW5fX8kXeSz5puVoa8RvnK6p6ug
	 +KBlvBdZQUzwnNOFSViX1XFzcelcWj8cGpiTz8I4UhC3o8sLdAl/Z4gbK78aG0GxP0
	 khcmCbbUMJXeQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id B713E125982;
	Thu, 11 Jun 2026 18:22:02 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v5 6/6] landlock: Add documentation for UDP support
Date: Thu, 11 Jun 2026 18:21:06 +0200
Message-ID: <20260611162107.49278-7-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611162107.49278-1-matthieu@buffet.re>
References: <20260611162107.49278-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:konstantin.meskhidze@huawei.com,m:m@maowtm.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[buffet.re:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,buffet.re:dkim,buffet.re:email,buffet.re:mid,buffet.re:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A04366737E0

Add example of UDP usage, without detailing the two access right.
Slightly change the example used in code blocks: build a ruleset for a
DNS client, so that it uses both TCP and UDP.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 Documentation/userspace-api/landlock.rst | 91 +++++++++++++++++++-----
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 45861fa75685..0ea55c2c732c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: May 2026
+:Date: June 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -40,8 +40,8 @@ Filesystem rules
     and the related filesystem actions are defined with
     `filesystem access rights`.
 
-Network rules (since ABI v4)
-    For these rules, the object is a TCP port,
+Network rules (since ABI v4 for TCP and v10 for UDP)
+    For these rules, the object is a TCP or UDP port,
     and the related actions are defined with `network access rights`.
 
 Defining and enforcing a security policy
@@ -49,11 +49,11 @@ Defining and enforcing a security policy
 
 We first need to define the ruleset that will contain our rules.
 
-For this example, the ruleset will contain rules that only allow filesystem
-read actions and establish a specific TCP connection. Filesystem write
-actions and other TCP actions will be denied.
+For this example, the ruleset will contain rules that only allow some
+filesystem read actions and some specific UDP and TCP actions. Filesystem
+write actions and other TCP/UDP actions will be denied.
 
-The ruleset then needs to handle both these kinds of actions.  This is
+The ruleset then needs to handle all these kinds of actions.  This is
 required for backward and forward compatibility (i.e. the kernel and user
 space may not know each other's supported restrictions), hence the need
 to be explicit about the denied-by-default access rights.
@@ -81,7 +81,9 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
-            LANDLOCK_ACCESS_NET_CONNECT_TCP,
+            LANDLOCK_ACCESS_NET_CONNECT_TCP |
+            LANDLOCK_ACCESS_NET_BIND_UDP |
+            LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
@@ -132,6 +134,12 @@ version, and only use the available subset of access rights:
     case 6 ... 8:
         /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+        __attribute__((fallthrough));
+    case 9:
+        /* Removes LANDLOCK_ACCESS_NET_*_UDP for ABI < 10 */
+        ruleset_attr.handled_access_net &=
+            ~(LANDLOCK_ACCESS_NET_BIND_UDP |
+              LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -187,20 +195,52 @@ kernel does not support are dropped (the compatibility switch above already
 cleared them in ``handled_access_*``), and the rule is skipped if no supported
 right remains.
 
-For network access-control, we can add a set of rules that allow to use a port
-number for a specific action: HTTPS connections.
+For network access-control, we will add a set of rules to allow DNS
+queries, which requires both UDP and TCP. For TCP, we need to allow
+outbound connections to port 53, which can be handled and granted starting
+with ABI 4:
 
 .. code-block:: c
 
-    struct landlock_net_port_attr net_port = {
+    struct landlock_net_port_attr tcp_conn = {
         .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
-        .port = 443,
+        .port = 53,
+    };
+
+    tcp_conn.allowed_access &= ruleset_attr.handled_access_net;
+    if (tcp_conn.allowed_access)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &tcp_conn, 0);
+
+We also need to be able to send UDP datagrams to port 53, which requires
+granting ``LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP``. Since our DNS client will
+emit datagrams without explicitly binding to a specific source port, its UDP
+socket will automatically bind an ephemeral port. To allow this behaviour,
+we also need to grant ``LANDLOCK_ACCESS_NET_BIND_UDP`` on port 0, as if
+the program explicitly called :manpage:`bind(2)` on port 0.
+
+.. code-block:: c
+
+    struct landlock_net_port_attr udp_send = {
+        .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+        .port = 53,
+    };
+
+    udp_send.allowed_access &= ruleset_attr.handled_access_net;
+    if (udp_send.allowed_access)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &udp_send, 0);
+    [...]
+
+    struct landlock_net_port_attr udp_bind = {
+        .allowed_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+        .port = 0,
     };
 
-    net_port.allowed_access &= ruleset_attr.handled_access_net;
-    if (net_port.allowed_access)
+    udp_bind.allowed_access &= ruleset_attr.handled_access_net;
+    if (udp_bind.allowed_access)
         err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-                                &net_port, 0);
+                                &udp_bind, 0);
 
 When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
 similar backwards compatibility check is needed for the restrict flags
@@ -234,7 +274,7 @@ similar backwards compatibility check is needed for the restrict flags
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
 allowing read and execute access to ``/usr`` while denying all other handled
-accesses for the filesystem, and a second rule allowing HTTPS connections.
+accesses for the filesystem, and two more rules allowing DNS queries.
 
 .. code-block:: c
 
@@ -722,6 +762,19 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+UDP bind, connect and send* (ABI < 10)
+--------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to restrict
+setting the local port of UDP sockets with the
+``LANDLOCK_ACCESS_NET_BIND_UDP`` right. This includes restricting the
+ability to trigger autobind of an ephemeral port by the kernel by e.g.
+sending a first datagram or setting the remote peer of a socket.
+The ``LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP`` right controls setting the
+remote port of UDP sockets (via :manpage:`connect(2)), and sending
+datagrams to an explicit remote port (ignoring any destination set on
+UDP sockets, via e.g. :manpage:`sendto(2)).
+
 .. _kernel_support:
 
 Kernel support
@@ -784,10 +837,10 @@ the boot loader.
 Network support
 ---------------
 
-To be able to explicitly allow TCP operations (e.g., adding a network rule with
-``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
+To be able to explicitly allow TCP or UDP operations (e.g., adding a network rule with
+``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support the TCP/IP protocol suite
 (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an
-``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP
+``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP or UDP
 operation is already not possible.
 
 Questions and answers
-- 
2.47.3


