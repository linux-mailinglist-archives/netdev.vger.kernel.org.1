Return-Path: <netdev+bounces-288973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJakKJngCmqR8wQAu9opvQ
	(envelope-from <netdev+bounces-288973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C7456A0C4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04376310D5E9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4D3E928C;
	Mon, 18 May 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HpG6fvst"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920753E8C54;
	Mon, 18 May 2026 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097079; cv=fail; b=CV9kjLAj/ofMd6pdgBF+LctoQ1cs0lfVKML5i8umURWjQM/S7IwgpWlZD3sZ/3O59x6GlQvLF8SpZI94kf+fCUiy1aaqM8SBhdQ4qM/xN/9ewZXmKvAL8I8/MXKOnIdhOAgCzegJqastnTfbslLKwacve2BElyzW0zTJuKQ2VCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097079; c=relaxed/simple;
	bh=pXrVy3lifmvLABC3n7Hql42Hx5fCGyrQjmGfvh2KaS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1hrjHWAPlVOmReZFU9FSP3tOnUxxNrdKwgKU1xuSrUGGV5smiyGXFC9JsSVjpQuzKpmMYnKs9hlQShomCYHuB5hN7X93DAS447jKL+BruxHYIvOoE3bCXlbk/yhPk+muJLE0zBF9BPwmlL+aT6sK+uLwlsNehGM2Q2oxDWirtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HpG6fvst; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy7JLAOjABncF+2FneOBhCRCpP1r7kCGvQ16f7/8Fd+t34lGRE6wDHwJV5GylHJxOCvDby+vHS01nG03Ehxi6shNegfNc6G/yaxV5bjdOa236gqZkOycp1UqkKwE5L0dzVm5dm6IeA6w2TN5spT1eDi9k9p1tlZeDe5W15AcKcdmgPlGADk7vXFxhYux6yHozXIfhHX0kDK5y7WD9+hOYE6gP+U/Ne3UnBR92Qhj2qctthLYZt53KQUuwgHIqUaAjHjKb4eyKgaACRlJ3YRhNyvquHsf4c2ICxW68a+ZSEynpLZlfHJXg900YRIdNBuZh7j3JDtgiTd0DnEmNYrHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/zJGE1yQCMPgZ/gA7dGYbmiyu2dejnd+tpbS9hxb38=;
 b=YsHTfKSsqupqaEsOWVZz21YhYhrpbP/rKBDRTaNZsJ9klu0yZikrXsX7TpRIRRZ/c872j5QrR3TqFnd+imVNsHiznSpjAStOUks0GMYhmOQx0JWLx1xNdhB7RKFE4KACtIWSo96CN4sC3ZvAsWt2xBZs1TlUOK/hNcjYT4iuGuxJkd5UU7i5lcc4rGY63gKOOcFpveeUoGMY+9YoSZaQPqXbWIjOLjbaO9BL1Wh9eDaxT5H56MMDFvzTIKAJgygDESrM6q6DVLUAbbU6bSwYhF1rZwUSY4791aENaA3WIR03tb+dh/nLDsWs45gPVqXyxmwTzNSKomDbapwELuwjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/zJGE1yQCMPgZ/gA7dGYbmiyu2dejnd+tpbS9hxb38=;
 b=HpG6fvstA49m3j1TPkC8unsuLgYX3jeOydUmZz7sFgmFVE7IHxHQxirqD2h+TU0brm4N1Wez4Gqh+ZogjvLqi7ZDnTj8tr38sbVBBu06FWCeOYOWCxWCijY8tjRb5493ya4+8UFpz/18FbuVKkDoL6OvbjHBlVmxfsIUof6WjjzlEi5flYDRXpv6rSRSHlwIKx7Fo2B5Fzdjzs72cCmlR/304QjAGwfZ3FoHA7g9tCFvmaXOMPVVNg+ekluMwdHeFJX4zdSNlRquNF1eX2ga/pqkRIwDhsYc5H1dxMLMJozr1U2derZqTfFqzX18BsXXl0b2YYQITsr7eFt19SbEkQ==
Received: from CY5PR15CA0127.namprd15.prod.outlook.com (2603:10b6:930:68::10)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 09:37:52 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::c6) by CY5PR15CA0127.outlook.office365.com
 (2603:10b6:930:68::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 09:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:37:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 02:37:35 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 02:37:30 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Nimrod Oren <noren@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 3/3] selftests: Use a master ssh connection for remote commands
Date: Mon, 18 May 2026 12:36:53 +0300
Message-ID: <20260518093653.551166-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518093653.551166-1-cratiu@nvidia.com>
References: <20260518093653.551166-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: e7585d42-e95c-41c6-e283-08deb4c121fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	FAt+Bj+fR87Qk8mKjHuHDnmoLIEBc9c75DNrSRdAXwHfu7dTDKy0dmW0m3A2dfVceP3lRh9Wjp454+F/1oRT6ntU1HzN6LFoAlyAmVi5bJaxLTfqiPGtysa5mdz7iWeAKWsUFUDqj5UGMG7zawoKYaQCUwsAyxQ8tXWBOeeDJ9zp6K2MU+9WYqEcJBjJnP2mt8xBuRCUyyI+dXPKY5BzCKorEP5JVih6PbgS7FyxYxe12+c2NX5HlZsYttEnfbjNGd5TdPCZHJkNOuAyxYXAwyyKjLc+91Hv9lAFCpqQR1GJaO6RnTKA5JFjs/nSXCU3mTduk7FjdP+TomZXIMYPE3kdWsYFpxW7adt2tgixqqamg9zNbOTfXpIiyi6a/gZ2gMNzyQ5QrclVgRXDPVFbRcTLJ65rUsxchxLcGHcQacV+ScKdwOpZZuBLxvH/lLzLqOuKLAVFQnJVbOgTGV+Juj8zTd69VyKs7So9gmXB/h/KHfaTxFUyoGkmANFChic/vRvtOm4NF+OxC3JFdMxj8x5Vluxf36Sp6WJcedpG3CMUsQYHus3xJIreK+/BuZ9ky+TLhvxWd0GvACQe5Dtu5M9uArCa0AHjWygQIFrK7/aHTa9yLDWm7SdY/EA6GhtJKsji7s+kkvy+wzjIi+25jNVshM6evbHzKLtiKN/87cmNRU3DUCbHfzs9iFZpsOK5usDBpI3TkdL6g8Hh/dc2ju0mG2YEtwAOBtBBNL9Lt34=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BSLkvfCxq+AN7R7qCf9eN8J8OGRnkSMZVe+VNp11A1GGgB/ApsyF3RPG1Tar0Kmh4UkYyTiYrwZgmHOsO69dgF3xCtqL1Wv0zdzM9b+YQ0UvGL6JSozPPCMDs0G9GT7/33YdVfoomOneBDGjCsIR5IWzBnV9f5J2jsz+75/5lybeksNhFMs1Dic971RzY/Z7TVc83yhNRuOu5jHhHVIEOijW+s8+xQ98DeOr9yOsOHfj7lNrMlc9nTvldaQ0xgjxhIeFsWavVazT2q57mZ4DXk1fBs4aDgSecdb1uPaMTYJfxTX8XjOUL0GFc2G6cQPjyBFb7FPjt4YIurRfNjukZ+y1GUkDSL1DU47INPg/iYb/BT5pJSgEs3oLpUlhR2/j1dPZzyfxiVV4e1GAw10UpjU9uHCcW9ZeKu+FMFFDdQEUtbf0Vhx5Pw0YdvsskBL4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:37:52.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7585d42-e95c-41c6-e283-08deb4c121fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
X-Rspamd-Queue-Id: 02C7456A0C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,debian.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288973-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,self.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,ping.py:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Every remote test command done via remote_ssh has to exchange ssh keys
and authenticate, paying a (sometimes significant) setup cost. This cost
is compounded when several remote commands are run in sequence, and made
even worse when the remote configuration is usually restored on defer().

Fix that by using a master ssh connection per remote host, allowing
subsequent connections to skip these steps and be almost as fast as
running those commands locally. This will reduce infrastructure usage by
these tests because they will finish much faster.

This finally implements this part of
tools/testing/selftests/drivers/net/README.rst:
"Using persistent SSH connections is strongly encouraged to avoid
the latency of SSH connection setup on every command."

Significant improvements are seen in a b2b setup involving NIS, here's
an example with the ping.py test, with remote cmd execution instrumented
with timing info:

Before (one ssh connection per remote command):
  # ./tools/testing/selftests/drivers/net/ping.py
  [...]
  remote: 0.769s  ping -c 1 -W0.5 1.0.0.1
  remote: 0.790s  ping -s 65000 -c 1 -W0.5 1.0.0.1
  remote: 0.775s  command -v -- socat
  remote: 0.784s  echo dwlelyrvaimmzirvhlfrgxtjxpxjdwcxmzj...
  remote: 1.238s  cat /proc/net/tcp*
  remote: 0.761s  ping -c 1 -W0.5 1.0.0.1
  remote: 0.753s  ping -s 65000 -c 1 -W0.5 1.0.0.1
  remote: 0.787s  echo zmhdqnnwidygdmoylhpdimcfmtgubbvygkc...
  remote: 1.034s  cat /proc/net/tcp*
  ok 1 ping.test_default_v4
  [...]
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:2 error:0
  # Total remote cmd time: 55.416s

After (a single master ssh connection):
  # ./tools/testing/selftests/drivers/net/ping.py
  [...]
  remote: 0.017s  ping -c 1 -W0.5 1.0.0.1
  remote: 0.017s  ping -s 65000 -c 1 -W0.5 1.0.0.1
  remote: 0.016s  command -v -- socat
  remote: 0.020s  echo njbgxukbquvxqxynzyelisajhilshglkqmv...
  remote: 0.022s  cat /proc/net/tcp*
  remote: 0.017s  ping -c 1 -W0.5 1.0.0.1
  remote: 0.017s  ping -s 65000 -c 1 -W0.5 1.0.0.1
  remote: 0.020s  echo rmjpqfbfwfdtzesiqpmeljpdipiopvcfrhs...
  remote: 0.022s  cat /proc/net/tcp*
  ok 1 ping.test_default_v4
  [...]
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:2 error:0
  # Total remote cmd time: 2.563s

So a reduction in total time spent executing remote commands from 55s to
2.5s. Similar speedups should apply across all tests using remote_ssh.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../drivers/net/lib/py/remote_ssh.py          | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
index 427082561d00..8f2e57ccbe2f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import os
+import shutil
 import string
 import subprocess
 import random
+import tempfile
 
 from lib.py import cmd
 
@@ -13,17 +15,50 @@ class Remote:
         self.name = name
         self.dir_path = dir_path
         self._tmpdir = None
+        self._ctl_dir = tempfile.mkdtemp(prefix="ssh-ksft-")
+        self._ctl = os.path.join(self._ctl_dir, "ctl")
+        self._ssh_opts = ["-o", "BatchMode=yes",
+                          "-o", "ConnectTimeout=20",
+                          "-o", "ControlMaster=auto",
+                          "-o", f"ControlPath={self._ctl}",
+                          "-o", "ControlPersist=30"]
+        self._ssh_base = ["ssh", "-q"] + self._ssh_opts
+        # Open the persistent connection
+        self._master_started = False
+        try:
+            r = subprocess.run(self._ssh_base + ["-fNM", self.name],
+                               stdin=subprocess.DEVNULL,
+                               stdout=subprocess.DEVNULL,
+                               stderr=subprocess.PIPE, timeout=30)
+            if r.returncode:
+                raise OSError(f"SSH master to {name} failed: {r.stderr.decode().strip()}")
+            self._master_started = True
+        finally:
+            if not self._master_started:
+                shutil.rmtree(self._ctl_dir, ignore_errors=True)
 
     def __del__(self):
-        if self._tmpdir:
-            cmd("rm -rf " + self._tmpdir, host=self)
-            self._tmpdir = None
+        try:
+            if self._tmpdir:
+                cmd("rm -rf " + self._tmpdir, host=self)
+                self._tmpdir = None
+        except Exception:
+            pass
+        try:
+            if self._master_started:
+                self._master_started = False
+                subprocess.run(self._ssh_base + ["-O", "exit", self.name],
+                               stdout=subprocess.DEVNULL,
+                               stderr=subprocess.DEVNULL, timeout=10)
+        except Exception:
+            pass
+        shutil.rmtree(self._ctl_dir, ignore_errors=True)
 
     def cmd(self, comm, pty=False):
-        args = ["ssh", "-q"]
+        args = []
         if pty:
             args += ["-tt"]
-        return subprocess.Popen(args + [self.name, comm],
+        return subprocess.Popen(self._ssh_base + args + [self.name, comm],
                                 stdin=subprocess.DEVNULL,
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 
@@ -39,5 +74,6 @@ class Remote:
         if not os.path.isabs(what):
             what = os.path.abspath(self.dir_path + "/" + what)
 
-        cmd(f"scp {what} {self.name}:{file_name}")
+        cmd(["scp", "-q"] + self._ssh_opts +
+             [what, f"{self.name}:{file_name}"])
         return file_name
-- 
2.53.0


