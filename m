Return-Path: <netdev+bounces-297282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wAtHK4J7KGpDFQMAu9opvQ
	(envelope-from <netdev+bounces-297282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549116641FB
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297282-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5A31300F5D5
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE7316199;
	Tue,  9 Jun 2026 20:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008F38E8CA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:45:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037952; cv=none; b=jRUwK+H6l8e/dy4UUUMILqu7r/4iLT6/vp4uZBvn0qT5rIR7I5c/Suzs4vcJENLvfpCnj1baia+kNIrT8Y+Bh2+Xb5a9DWyj++M7JIZKh0v1+20wARXt6wPE3lETQ86kyNFJlrQj8nD0bWAQQPmKq8FQvJkL5HGMALTs/wmGeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037952; c=relaxed/simple;
	bh=OK72ueWDEgQvMR2SYgegbw4WfBUOIuRqqPp2/bj/Xz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5PZ3Rd5Z1LqcZYB87/x2D7j6LosMc0QBE1Rl0OI2SQ9PQN8mVjIuH9BhADKIBGwrmUlLAwi+qvMeaIyuZo2Ryi13kHS+LLt3JCe+0Mp1A2l6W2F6762/jXI289x8371Yh+76N3Q4RXbGDB+cvKPDelDMkRlWhbzVwSwYuVxyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7584B759E9;
	Tue,  9 Jun 2026 20:45:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEB9E779A7;
	Tue,  9 Jun 2026 20:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKdWM3N7KGq7PwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 09 Jun 2026 20:45:39 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 3/3 net-next v6] selftests: net: add test for IPv4 devconf netlink notifications
Date: Tue,  9 Jun 2026 22:45:20 +0200
Message-ID: <20260609204520.4670-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609204520.4670-1-fmancera@suse.de>
References: <20260609204520.4670-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297282-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:email,suse.de:mid,suse.de:from_mime,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 549116641FB

Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
sends the appropriate netlink notifications when IPv4 devconf parameters
are modified.

The test depends on the newly introduced iproute2 command:

`ip link set dev <ifname> inet`

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v3: added this patch to the series as requested by Paolo.
v4: fixed lint warnings, some of them cannot be fixed as they are
related to the YNL hack.
v5: use the newly introduce iproute2 inet command, drop the YNL hack
v6: fix ruff warning about plain "except:", instead catch CmdExitFailure
---
 tools/testing/selftests/net/rtnetlink.py | 41 +++++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index e9ad5e88da97..3622413d793d 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -1,17 +1,20 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_exit, ksft_run, ksft_ge, RtnlAddrFamily
 import socket
+import time
+from lib.py import bkg, ip, ksft_exit, ksft_run, ksft_ge, ksft_true, KsftSkipEx
+from lib.py import CmdExitFailure, NetNS, NetNSEnter, RtnlAddrFamily
 
 IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
 
-def dump_mcaddr_check(rtnl: RtnlAddrFamily) -> None:
+def dump_mcaddr_check() -> None:
     """
     Verify that at least one interface has the IPv4 all-hosts multicast address.
     At least the loopback interface should have this address.
     """
 
+    rtnl = RtnlAddrFamily()
     addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
 
     all_host_multicasts = [
@@ -21,9 +24,39 @@ def dump_mcaddr_check(rtnl: RtnlAddrFamily) -> None:
     ksft_ge(len(all_host_multicasts), 1,
             "No interface found with the IPv4 all-hosts multicast address")
 
+def ipv4_devconf_notify() -> None:
+    """
+    Configure an interface and set ipv4-devconf values through netlink
+    to verify that the appropriate netlink notifications are being sent.
+    """
+
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            ifname = "dummy1"
+            ip(f"link add name {ifname} type dummy", ns=str(ns))
+
+            with bkg("ip monitor", ns=str(ns)) as cmd_obj:
+                time.sleep(1)
+                try:
+                    ip(f"link set dev {ifname} inet forwarding on")
+                    ip(f"link set dev {ifname} inet proxy_arp on")
+                    ip(f"link set dev {ifname} inet rp_filter 1")
+                    ip(f"link set dev {ifname} inet ignore_routes_with_linkdown on")
+                except CmdExitFailure:
+                    raise KsftSkipEx("iproute2 does not support IPv4 devconf attributes")
+                time.sleep(1)
+
+    ksft_true(f"inet {ifname} ignore_routes_with_linkdown on" in cmd_obj.stdout,
+              f"No 'ignore_routes_with_linkdown on' notificiation found for interface {ifname}")
+    ksft_true(f"inet {ifname} rp_filter strict" in cmd_obj.stdout,
+              f"No 'rp_filter strict' notificiation found for interface {ifname}")
+    ksft_true(f"inet {ifname} proxy_neigh on" in cmd_obj.stdout,
+              f"No 'proxy_neigh on' notificiation found for interface {ifname}")
+    ksft_true(f"inet {ifname} forwarding on" in cmd_obj.stdout,
+              f"No 'forwarding on' notificiation found for interface {ifname}")
+
 def main() -> None:
-    rtnl = RtnlAddrFamily()
-    ksft_run([dump_mcaddr_check], args=(rtnl, ))
+    ksft_run([dump_mcaddr_check, ipv4_devconf_notify])
     ksft_exit()
 
 if __name__ == "__main__":
-- 
2.54.0


