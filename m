Return-Path: <netdev+bounces-19177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B266E759E22
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A831C21120
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE925142;
	Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B425140
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD51BF7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 82EC1D9023;
	Wed, 19 Jul 2023 20:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792741; bh=AUNw7pMGIBUcHxLmJ+PKA8uewV85px2OvO6ZBPLUsM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUAK52+mjCfSMCPAWZ8+z5rCfwp5XjgpWxgVY+YE5oGzuH+psa2uvP2P9LQ1iPMtZ
	 eK7dSTYMcNgnFJLUe4p9acAJcU1QhTCEBOBwersXfHr9JS/i6b7DnC0E49xwao5q3g
	 VD/unZV2cYX8qv2QSAbGstVC7nLKbfkXcNA1HXlFCPsndhD2OmO2XaA1euea+cJWtE
	 I90aZM2X8W9wgb4Hyv+AGmTnaLu3fN3Ac6lcar3zKOcbnT2PSeL+x59bmZm5TooCJh
	 FZpkuy50ABKv6/Kn9UqY4Huw9gx8M5a3fDX6brRTuUwSL8ur2LDLIUUCCCVe8uwmqP
	 XWI3O/sbXoVsA==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 21/22] man: Document lookup of configuration files in /etc and /usr
Date: Wed, 19 Jul 2023 20:51:05 +0200
Message-Id: <20230719185106.17614-22-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 man/man8/Makefile        |  1 +
 man/man8/ip-address.8.in |  5 +++--
 man/man8/ip-link.8.in    | 10 ++++++----
 man/man8/ip-route.8.in   | 43 ++++++++++++++++++++++++----------------
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/man/man8/Makefile b/man/man8/Makefile
index ae5e37a5..6dab182f 100644
--- a/man/man8/Makefile
+++ b/man/man8/Makefile
@@ -10,6 +10,7 @@ all: $(TARGETS)
 		-e "s|@NETNS_ETC_DIR@|$(NETNS_ETC_DIR)|g" \
 		-e "s|@NETNS_RUN_DIR@|$(NETNS_RUN_DIR)|g" \
 		-e "s|@SYSCONF_ETC_DIR@|$(CONF_ETC_DIR)|g" \
+		-e "s|@SYSCONF_USR_DIR@|$(CONF_USR_DIR)|g" \
 		$< > $@
 
 distclean: clean
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index a2df22d4..b9a476a5 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -208,8 +208,9 @@ The maximum allowed total length of label is 15 characters.
 .TP
 .BI scope " SCOPE_VALUE"
 the scope of the area where this address is valid.
-The available scopes are listed in file
-.BR "@SYSCONF_ETC_DIR@/rt_scopes" .
+The available scopes are listed in
+.BR "@SYSCONF_USR_DIR@/rt_scopes" or
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
 Predefined scope values are:
 
 .in +8
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ac1a3b5f..8f07de9a 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2250,8 +2250,9 @@ give the device a symbolic name for easy reference.
 .TP
 .BI group " GROUP"
 specify the group the device belongs to.
-The available groups are listed in file
-.BR "@SYSCONF_ETC_DIR@/group" .
+The available groups are listed in
+.BR "@SYSCONF_USR_DIR@/group" or
+.BR "@SYSCONF_ETC_DIR@/group" (has precedence if exists).
 
 .TP
 .BI vf " NUM"
@@ -2851,9 +2852,10 @@ specifies which help of link type to display.
 
 .SS
 .I GROUP
-may be a number or a string from the file
+may be a number or a string from
+.B @SYSCONF_USR_DIR@/group or
 .B @SYSCONF_ETC_DIR@/group
-which can be manually filled.
+which can be manually filled and has precedence if exists.
 
 .SH "EXAMPLES"
 .PP
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 9fc3f4a1..76151689 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -356,8 +356,9 @@ normal routing tables.
 .P
 .B Route tables:
 Linux-2.x can pack routes into several routing tables identified
-by a number in the range from 1 to 2^32-1 or by name from the file
-.B @SYSCONF_ETC_DIR@/rt_tables
+by a number in the range from 1 to 2^32-1 or by name from
+.B @SYSCONF_USR_DIR@/rt_tables or
+.B @SYSCONF_ETC_DIR@/rt_tables (has precedence if exists).
 By default all normal routes are inserted into the
 .B main
 table (ID 254) and the kernel only uses this table when calculating routes.
@@ -420,7 +421,8 @@ may still match a route with a zero TOS.
 .I TOS
 is either an 8 bit hexadecimal number or an identifier
 from
-.BR "@SYSCONF_ETC_DIR@/rt_dsfield" .
+.BR "@SYSCONF_USR_DIR@/rt_dsfield" or
+.BR "@SYSCONF_ETC_DIR@/rt_dsfield" (has precedence if exists).
 
 .TP
 .BI metric " NUMBER"
@@ -434,8 +436,9 @@ is an arbitrary 32bit number, where routes with lower values are preferred.
 .BI table " TABLEID"
 the table to add this route to.
 .I TABLEID
-may be a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_tables" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes the
@@ -475,8 +478,9 @@ covered by the route prefix.
 .BI realm " REALMID"
 the realm to which this route is assigned.
 .I REALMID
-may be a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_realms" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_realms" or
+.BR "@SYSCONF_ETC_DIR@/rt_realms" (has precedence if exists).
 
 .TP
 .BI mtu " MTU"
@@ -626,8 +630,9 @@ command.
 .BI scope " SCOPE_VAL"
 the scope of the destinations covered by the route prefix.
 .I SCOPE_VAL
-may be a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_scopes" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_scopes" or
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes scope
@@ -646,8 +651,9 @@ routes.
 .BI protocol " RTPROTO"
 the routing protocol identifier of this route.
 .I RTPROTO
-may be a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_protos" .
+may be a number or a string from
+.BR "@SYSCONF_ETC_DIR@/rt_protos" or
+.BR "@SYSCONF_ETC_DIR@/rt_protos" (has precedence if exists).
 If the routing protocol ID is not given,
 .B ip assumes protocol
 .B boot
@@ -879,8 +885,9 @@ matching packets are dropped.
 - Decapsulate the inner IPv6 packet and forward it according to the
 specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 If
 .B vrftable
 is used, the argument must be a VRF device associated with
@@ -895,8 +902,9 @@ and an inner IPv6 packet. Other matching packets are dropped.
 - Decapsulate the inner IPv4 packet and forward it according to the
 specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
@@ -908,8 +916,9 @@ at all, and an inner IPv4 packet. Other matching packets are dropped.
 - Decapsulate the inner IPv4 or IPv6 packet and forward it according
 to the specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONF_ETC_DIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
-- 
2.39.2


