Return-Path: <netdev+bounces-283405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CACiCpPy9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:48:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FC4B2079
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878F33037D75
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098236923B;
	Sat,  2 May 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="mr1365S5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2036D513;
	Sat,  2 May 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725885; cv=none; b=GnuAqLKcu0l6DjJjCooGTWQerPllZnsWiPAqrjG///UrtcYZV7PRdzOhsuntBTmc9GgLt3ii9uPoW+eJMZeBzeYnaL+BA9D1Z0+TbHuiuRE4lQVM6nXHZuNScxNU9ncpC7TdK/bQ0cp8JYnMl6btd2yjRV+COcx+gHX9KLcplWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725885; c=relaxed/simple;
	bh=OJGoCmPUZjOVF6lCpAXarpCbEo92pm9Wif3BO+sp3r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlrzbGGrRmhNadief099AG/B5szpHREL3jDvKrNkJ+P9USX8PpEcJ8HqhIEoH9s7D7fPEQkJmg9Jq1+r80dXGhhBiaGPBAijphdw3hmkAgIHIxlWT9/BrJVWu63wcWyWIZB+4SWbhZauuUWeEpi21w79IJJs+LK18qpWlFQEVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=mr1365S5; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725881; bh=OJGoCmPUZjOVF6lCpAXarpCbEo92pm9Wif3BO+sp3r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mr1365S5aafwrInjQgpAnR1Rc5trLEdmAz0oNfTIUPNF098bSZjRmSDYvsCZpTcXi
	 Id6wE9SY4Z4qKiCIAB3o+cFxgOxT+ecN9TWsAxNnuhZ0s3+oVuiazinMCybw8aDcEt
	 JF/zPxuo9P1cXKOBz/O1bae4/9iWhXsR7OfOdaodW+TppeK/mpuxA0g+Ek1UHycXQs
	 TEMwZGvtdZo/J8N5qAJOjwuj4h8ZmaG8ETInitUVkKTeXsSPxWd6y1VHh1KvcYgg07
	 mXTabKfq5JcrSlGcn3qhMmt+gNbkGSMPqUEPI4mxorM8lwxQITZdSAxMAFsNidWfJE
	 KjxI4BXMrQuVA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 86085125927;
	Sat,  2 May 2026 14:44:41 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 7/7] landlock: Add documentation for UDP support
Date: Sat,  2 May 2026 14:43:06 +0200
Message-Id: <20260502124306.3975990-8-matthieu@buffet.re>
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
X-Rspamd-Queue-Id: 7B9FC4B2079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283405-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,buffet.re:email,buffet.re:dkim,buffet.re:mid]

Add example of UDP usage, without detailing the two access right.
Slightly change the example used in code blocks: build a ruleset for a
DNS client, so that it uses both TCP and UDP.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 Documentation/userspace-api/landlock.rst | 89 ++++++++++++++++++------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..9d5da9896628 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
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
+        /* Removes LANDLOCK_ACCESS_*_UDP for ABI < 10 */
+        ruleset_attr.handled_access_net &=
+            ~(LANDLOCK_ACCESS_NET_BIND_UDP |
+              LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -180,21 +188,50 @@ this file descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because all of the requested
-``allowed_access`` rights are already available in ABI 1.
+ABI version.  So far, this was not required because all of the requested
+``allowed_access`` rights have always been available, from ABI 1.
 
-For network access-control, we can add a set of rules that allow to use a port
-number for a specific action: HTTPS connections.
+For network access-control, we will add a set of rules to allow DNS
+queries, which requires both UDP and TCP. For TCP, we need to allow
+outbound connections to port 53, which can be handled and granted starting
+with ABI 4:
 
 .. code-block:: c
 
-    struct landlock_net_port_attr net_port = {
-        .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
-        .port = 443,
-    };
+    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+        struct landlock_net_port_attr net_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+            .port = 53,
+        };
 
-    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-                            &net_port, 0);
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
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
+    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
+        const struct landlock_net_port_attr send_dst_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+            .port = 53,
+        };
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &send_dst_port, 0);
+        [...]
+
+    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_BIND_UDP) {
+        const struct landlock_net_port_attr bind_src_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+            .port = 0,
+        };
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &bind_src_port, 0);
 
 When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
 similar backwards compatibility check is needed for the restrict flags
@@ -228,7 +265,7 @@ similar backwards compatibility check is needed for the restrict flags
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
 allowing read and execute access to ``/usr`` while denying all other handled
-accesses for the filesystem, and a second rule allowing HTTPS connections.
+accesses for the filesystem, and two more rules allowing DNS queries.
 
 .. code-block:: c
 
@@ -716,6 +753,16 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+UDP bind, connect, sendto, sendmsg and sendmmsg (ABI < 10)
+----------------------------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to restrict
+setting the local port of UDP sockets with the
+``LANDLOCK_ACCESS_NET_BIND_UDP`` right.
+The ``LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP`` right controls setting the
+remote port of UDP sockets, and sending datagrams to an explicit remote
+port (ignoring any destination set on UDP sockets).
+
 .. _kernel_support:
 
 Kernel support
@@ -778,10 +825,10 @@ the boot loader.
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
2.39.5


