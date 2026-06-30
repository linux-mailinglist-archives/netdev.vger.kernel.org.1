Return-Path: <netdev+bounces-303100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5RirCvykQ2q+eAoAu9opvQ
	(envelope-from <netdev+bounces-303100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C406E36DB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:14:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="fOqY/0CC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303100-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EAD53074B0E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE2409616;
	Tue, 30 Jun 2026 11:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2C409610
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:02:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817351; cv=none; b=HDVh5qrN1uBOeFX1cqqCfcs4Hgv1XeU40IrOxU9TLf4sBUcIYDs+u31zlOJIWxStXLOkf90kyfexGkaENpLbX4gSnTo4Zj7ffrG5DSQNHtUhpYxZshRmk7bu+rmfOz+CSFoFCwbxRlI4HxUHS2wBujXmRTvlkjiM1g1/aFqpB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817351; c=relaxed/simple;
	bh=8wZAl9dIq90GZLioFiUpzFcU9diyNdRhpnpQypxIlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx3KWo9Lpoc9I6XmgUPdZFGTklEwtlsVHkLQnwrIKWYcwR1rnLZLGIpuZj+S41eSu/yyOk5nHPR7FhAklvx+Ix+vZepIGtgORTzXNnNbT06i9FsXOAYERFK/KqadfPtCfxFr1DKzSfLmp/owD+lLP4w0eQXdbFulW5G0qf9dhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOqY/0CC; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c825c88744so26455985ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817349; x=1783422149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=710DEh42/SxcOGjoC0hzcAfTSmEIF90NLkpYChDQKCY=;
        b=fOqY/0CCbio+7XRNKbwvkNQ0tt5ObisYqS/+D6LvltV0Lr2egGZJKkUPRyoa94YJb7
         rOeV5e9VSwaLUAYjyCxiWZSzh5Qu4hn7VxN23Xqf3NaZbmD9zDdJjaEizKuJHsDXuYhJ
         xddvtCjL+UpB+vmHW2+9cmKn3tjmAAX0N4Mzh3gy/+d+DK1NwsHVMATDzkyQxUKWuL7F
         bBwcD9Ff1Tat8XQKHYv6KlZC4dD5CO4zvTTrn1zbGLSU9AU2ztT0BXPeQHoIdkdB5otJ
         w4oL8i75Fwd9bs+oU+og107VD/qozD2+xKTOvz65j09vACl4TR8cz520SUF2yVT9oAZb
         cLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817349; x=1783422149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=710DEh42/SxcOGjoC0hzcAfTSmEIF90NLkpYChDQKCY=;
        b=r4PzGeFI14XvEp/RV5xlkPYhRle4PLb/bT/tCzeNc/b9QrO4jaEU/I6luJumHemU4f
         LmF4NmjtLk3UGEeZekRZZlPlTSh27j4ZAlgAgpANbFgpSAmI36A+ZPuwfNB2ALjT4rpp
         Em3WAOZHVwNHKJLBgOPyyN/QS8kPMOxdFA9c2HIy9/evaq87D4AaE3gkq+zKYYK4U1U+
         pVzNqM4EukzURQ0g3yUUC7EAbagP1CelLlLZcJ8VwdlWmeketHTgELzECHP1/+3FQClM
         DacWOyp7vkh8JSMCuYmGI5eyIGQ+Z2o9Zn751cr8l+vfZwaZGenbKXO+wHsrothXgxXm
         qb+A==
X-Forwarded-Encrypted: i=1; AHgh+Roa/XGgEW0PHh4jvDLcS2AIb2r3TqCHThfZgrUbeHEiX2Xi3H55DagM/nvlSFzRA8eAigXA6xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+Uj4tkEjwiRJCMOx1xj/BVas5H435DcH8+qJ1oELUxlqNRdt
	9AtlRStNY+mqip8w8KIfosMvhpelnNU/bfkFDzOJDk3nhexNu4tpwFPL
X-Gm-Gg: AfdE7cnPVELajMqgIN7na87x6R6BBqAYS523lKSO49QspK/GZnrCrOrq3yGNAYbHjlN
	2KUf6kVcTc0Wqo+br9Kmp58qOcjcoSdNxtGALi8u9IBzGjWn3qgSljT/eA4nnCccVxhCj4kEJ2d
	bDjgfA9uAwjlX+S7whmkPOecppjoJrkdkKogAofvUrNk9r8YwVE5R6ShwMf2TqWbDFLsnnih7Qr
	5djOFFJDt2zIgoyLlZZKyhbhc8LTYRrFioNUdfmlq3CwlAieEXyT7+aazLqw4Fhyc1kpMfq8DbG
	ufvEm6IybkkRdlPUqTCvueLr2u6dlcSwCYqJU9MQykFwFO44B/zKgHiHHhNkCv0v+/hf7FNZZJx
	jQpi02gVdx5bgm2AvZQfLi1ivaX2XW0imCyWxV3DsNDdAL+/tpZDbBPqadFPYXqCQtZFsIXMd+V
	OantyJvn8yZa3vIBdCtCFrGgo1Yn4GvKJcZHlWe0/5
X-Received: by 2002:a17:902:f645:b0:2c6:ad70:d870 with SMTP id d9443c01a7336-2ca2d54457emr24425215ad.13.1782817348784;
        Tue, 30 Jun 2026 04:02:28 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:ae0d:35d1:dac9:a0e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701b5sm11455265ad.17.2026.06.30.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:02:28 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: net: check multicast group user count
Date: Tue, 30 Jun 2026 20:02:07 +0900
Message-ID: <20260630110207.37841-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630110207.37841-1-sigefriedhyy@gmail.com>
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80C406E36DB

Extend the RTM_GETMULTICAST dump test to verify IFA_MC_USERS for both
IPv4 and IPv6 multicast groups.

Run each protocol test in a fresh network namespace to avoid changing
host-network state or racing with unrelated multicast users. Join a
fixed multicast group twice using separate sockets and check that the
reported user count increases by two.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.py | 101 ++++++++++++++++++++---
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 3622413d793d..0c67c7c00d84 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -2,27 +2,106 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import socket
+import struct
 import time
-from lib.py import bkg, ip, ksft_exit, ksft_run, ksft_ge, ksft_true, KsftSkipEx
+from lib.py import bkg, ip, ksft_exit, ksft_run, ksft_eq, ksft_ge, ksft_true, KsftSkipEx
 from lib.py import CmdExitFailure, NetNS, NetNSEnter, RtnlAddrFamily
 
 IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
+IPV4_TEST_MULTICAST = b'\xef\x01\x01\x01'
+IPV6_TEST_MULTICAST = bytes.fromhex('ff020000000000000000000000000123')
+
+
+def _users_for(rtnl: RtnlAddrFamily, family: int, grp: bytes, ifindex: int):
+    """Return mc-users for grp on ifindex, or 0 if absent."""
+
+    addrs = rtnl.getmulticast({"ifa-family": family}, dump=True)
+    matches = [addr for addr in addrs
+               if addr['multicast'] == grp and addr['ifa-index'] == ifindex]
+    if not matches:
+        return 0
+    if 'mc-users' not in matches[0]:
+        return None
+
+    return matches[0]['mc-users']
+
 
 def dump_mcaddr_check() -> None:
     """
-    Verify that at least one interface has the IPv4 all-hosts multicast address.
-    At least the loopback interface should have this address.
+    Verify IPv4 multicast addresses and their user counts in RTM_GETMULTICAST.
+    """
+
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            ip("link set lo up")
+            rtnl = RtnlAddrFamily()
+            lo_idx = socket.if_nametoindex('lo')
+            addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
+
+            all_host_multicasts = [
+                addr for addr in addresses
+                if addr['multicast'] == IPV4_ALL_HOSTS_MULTICAST
+            ]
+
+            ksft_ge(len(all_host_multicasts), 1,
+                    "No interface found with the IPv4 all-hosts multicast address")
+
+            mreq = IPV4_TEST_MULTICAST + socket.inet_aton('127.0.0.1')
+            before = _users_for(rtnl, socket.AF_INET, IPV4_TEST_MULTICAST, lo_idx)
+            if before is None:
+                raise KsftSkipEx("kernel does not expose IFA_MC_USERS")
+
+            s1 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+            s2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+            try:
+                s1.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)
+                s2.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)
+
+                after_join = _users_for(rtnl, socket.AF_INET,
+                                        IPV4_TEST_MULTICAST, lo_idx)
+                if after_join is None:
+                    raise KsftSkipEx("kernel does not expose IFA_MC_USERS")
+                ksft_eq(after_join - before, 2,
+                        f"users delta != 2 after two joins "
+                        f"(before={before}, after={after_join})")
+            finally:
+                s1.close()
+                s2.close()
+
+
+def dump_mcaddr6_check() -> None:
+    """
+    Verify IPv6 multicast addresses and their user counts in RTM_GETMULTICAST.
     """
 
-    rtnl = RtnlAddrFamily()
-    addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            ip("link set lo up")
+            rtnl = RtnlAddrFamily()
+            lo_idx = socket.if_nametoindex('lo')
+            before = _users_for(rtnl, socket.AF_INET6,
+                                IPV6_TEST_MULTICAST, lo_idx)
+            if before is None:
+                raise KsftSkipEx("kernel does not expose IFA_MC_USERS for IPv6")
+
+            mreq = IPV6_TEST_MULTICAST + struct.pack('=I', lo_idx)
+            s1 = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
+            s2 = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
+            try:
+                s1.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_JOIN_GROUP, mreq)
+                s2.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_JOIN_GROUP, mreq)
 
-    all_host_multicasts = [
-        addr for addr in addresses if addr['multicast'] == IPV4_ALL_HOSTS_MULTICAST
-    ]
+                after_join = _users_for(rtnl, socket.AF_INET6,
+                                        IPV6_TEST_MULTICAST, lo_idx)
+                if after_join is None:
+                    raise KsftSkipEx("kernel does not expose IFA_MC_USERS for IPv6")
+                ksft_eq(after_join - before, 2,
+                        f"IPv6 users delta != 2 after two joins "
+                        f"(before={before}, after={after_join})")
+            finally:
+                s1.close()
+                s2.close()
 
-    ksft_ge(len(all_host_multicasts), 1,
-            "No interface found with the IPv4 all-hosts multicast address")
 
 def ipv4_devconf_notify() -> None:
     """
@@ -56,7 +135,7 @@ def ipv4_devconf_notify() -> None:
               f"No 'forwarding on' notificiation found for interface {ifname}")
 
 def main() -> None:
-    ksft_run([dump_mcaddr_check, ipv4_devconf_notify])
+    ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify])
     ksft_exit()
 
 if __name__ == "__main__":
-- 
2.43.0


