Return-Path: <netdev+bounces-151966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDED9F2063
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DF57A11A1
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3420194C61;
	Sat, 14 Dec 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="eoJN7Q50"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DEB170A13;
	Sat, 14 Dec 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202049; cv=none; b=IDVNx7TlPqPBb/zdomaZX+xnnOa12rLsOpekA5mkGlhxAuex2CdEtSWnTEkkftHzqhlxsCelinN2MB7uBLsTM9oqXVzmLJqwvcf7Q2TrIC4qLTav/Y9mcHqeTYF3ygzG2PGggfcwUHrrF8f8176nx0Ec40bF/b09CZqSQZhuRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202049; c=relaxed/simple;
	bh=XEQp1OcuB4+I0Fh+eWQThAsoSIRNC02YQBYnzl4D8PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzH/aSAMa/ApMfozkAD+vpF+6j8FYia59u4rJ6LEHd00ZBOnYBdLt2sOe+oyYVukRsaacWRkYIbljzilqNVNpqiYezcZPXzGuXQkCfX4r2n+XpoVilnWxbBMT1P2AIIDWBca6hLbW/lFDc5r731TfkmHW0g+XxKqEJe+bcAboG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=eoJN7Q50; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734202045; bh=XEQp1OcuB4+I0Fh+eWQThAsoSIRNC02YQBYnzl4D8PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoJN7Q50bn5D5rd/Yp+pTEcG8Um+17+nP+884LaR6yozBIghkBzj/w/OiXcOMCVWM
	 f1Yz6Y3Izx1Wi7zv/sT0Grs9JTsK0UryHCO2YFi4fYn8lxtvuv8Aj7TFNLamLKmIeP
	 2TBKcIGlEsheq2/mgbMhEvU/NlqIoFfYCbitTh4WwPHlV4GtrEA0JW+GVkP/A6l3jw
	 Mic/7/2fMjDedkO+0nlGAvxsYVhvoYVrHfEvTvGHjHZRLerO1yG0p4W5eUyRg56K53
	 kx7TafvRp/0pzhVHflq34XRXaTCtEF5GJSSg57f6e4kVFYo16XaSM62FgzOXfGe4QF
	 9eo9PkxbjJfiA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 7A2651252E2;
	Sat, 14 Dec 2024 19:47:25 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: Mickael Salaun <mic@digikod.net>
Cc: Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 6/6] doc: Add landlock UDP support
Date: Sat, 14 Dec 2024 19:45:40 +0100
Message-Id: <20241214184540.3835222-7-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241214184540.3835222-1-matthieu@buffet.re>
References: <20241214184540.3835222-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add example of UDP usage, without detailing each access right, but with
an explicit note about the need to handle both SENDTO and CONNECT to
completely block sending (which could otherwise be overlooked).

Slightly change the example used in code blocks: build a ruleset for a
DNS client, so that it uses both TCP and UDP. Also consider an opaque
implementation so that we get to introduce both the right to connect()
and sendmsg(addr != NULL) within the same example.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 Documentation/userspace-api/landlock.rst | 84 +++++++++++++++++++-----
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index d639c61cb472..7018a03096e2 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -40,8 +40,8 @@ Filesystem rules
     and the related filesystem actions are defined with
     `filesystem access rights`.
 
-Network rules (since ABI v4)
-    For these rules, the object is a TCP port,
+Network rules (since ABI v4 for TCP and v7 for UDP)
+    For these rules, the object is a TCP or UDP port,
     and the related actions are defined with `network access rights`.
 
 Defining and enforcing a security policy
@@ -49,11 +49,11 @@ Defining and enforcing a security policy
 
 We first need to define the ruleset that will contain our rules.
 
-For this example, the ruleset will contain rules that only allow filesystem
-read actions and establish a specific TCP connection. Filesystem write
-actions and other TCP actions will be denied.
+For this example, the ruleset will contain rules that only allow some
+filesystem read actions and some specific UDP and TCP accesses. Filesystem
+write actions and other TCP/UDP actions will be denied.
 
-The ruleset then needs to handle both these kinds of actions.  This is
+The ruleset then needs to handle all these kinds of actions.  This is
 required for backward and forward compatibility (i.e. the kernel and user
 space may not know each other's supported restrictions), hence the need
 to be explicit about the denied-by-default access rights.
@@ -80,7 +80,10 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_IOCTL_DEV,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
-            LANDLOCK_ACCESS_NET_CONNECT_TCP,
+            LANDLOCK_ACCESS_NET_CONNECT_TCP |
+            LANDLOCK_ACCESS_NET_BIND_UDP |
+            LANDLOCK_ACCESS_NET_CONNECT_UDP |
+            LANDLOCK_ACCESS_NET_SENDTO_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
@@ -127,6 +130,12 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+        /* Removes UDP support for ABI < 7 */
+        ruleset_attr.handled_access_net &= ~(LANDLOCK_ACCESS_NET_BIND_UDP |
+                                             LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                                             LANDLOCK_ACCESS_NET_SENDTO_UDP);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -175,26 +184,53 @@ descriptor.
 
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
+
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
+
+We also need to be able to send UDP datagrams to port 53: we don't know if
+the client will call :manpage:`sendto(2)` with an explicit destination
+address, or :manpage:`connect(2)` then :manpage:`send(2)`, so we allow
+both. Note that granting ``LANDLOCK_ACCESS_NET_BIND_UDP`` is not necessary
+here because the client's socket will be automatically bound to an
+ephemeral port by the kernel. Also note that we need to handle both
+``LANDLOCK_ACCESS_NET_CONNECT_UDP`` and ``LANDLOCK_ACCESS_NET_SENDTO_UDP``
+to effectively block sending UDP datagrams to arbitrary ports.
+
+.. code-block:: c
+
+    if ((ruleset_attr.handled_access_net & (LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                                            LANDLOCK_ACCESS_NET_SENDTO_UDP)) ==
+                                           (LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                                            LANDLOCK_ACCESS_NET_SENDTO_UDP)) {
+        struct landlock_net_port_attr net_port = {
+            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_UDP |
+                              LANDLOCK_ACCESS_NET_SENDTO_UDP,
+            .port = 53,
+        };
 
-    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-                            &net_port, 0);
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
 
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
 allowing read access to ``/usr`` while denying all other handled accesses for
-the filesystem, and a second rule allowing HTTPS connections.
+the filesystem, and two more rules allowing DNS queries.
 
 .. code-block:: c
 
@@ -595,6 +631,18 @@ Starting with the Landlock ABI version 6, it is possible to restrict
 :manpage:`signal(7)` sending by setting ``LANDLOCK_SCOPE_SIGNAL`` to the
 ``scoped`` ruleset attribute.
 
+UDP networking (ABI < 7)
+------------------------
+
+Starting with the Landlock ABI version 7, it is possible to restrict
+sending and receiving UDP datagrams to/from specific ports. Restrictions
+are now enforced at :manpage:`bind(2)` time with the new
+``LANDLOCK_ACCESS_NET_BIND_UDP`` access right, and at :manpage:`connect(2)`
+time with ``LANDLOCK_ACCESS_NET_CONNECT_UDP``. Finally,
+``LANDLOCK_ACCESS_NET_SENDTO_UDP`` also restricts the destination port
+when sending datagrams with an explicit address, orthogonal to whether
+the socket is connected or not.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.39.5


