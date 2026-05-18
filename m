Return-Path: <netdev+bounces-288972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK5dB1ngCmqR8wQAu9opvQ
	(envelope-from <netdev+bounces-288972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD056A0A0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BA5D3016B21
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732123E8C44;
	Mon, 18 May 2026 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECFD/JiF"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD913E867F;
	Mon, 18 May 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097077; cv=fail; b=OHAeFDIYLGw7iAj762OJJiDall/MR5GRcwl9sKY+Xf5kO43u2eWQe934lC0mQ5qN9FNAGoelhRSXa0oJvF9rtqosI0Z6JgbIUj69oTi4REqVCCSnmcIjENtftXXVnmMmhttcmQ4Ja6eRDRA6gPybBdfZatV9dONxz9jgQvdC1iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097077; c=relaxed/simple;
	bh=t0V2X++9Aa7+XQ+Jf6bL05SdFWQ0uTv9I5LUzAmxO2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke0/yROcNZ1ExAG+mz3Bap/V5I4wnSiuCifncaOMMFVJu9/suW5tP69V0TuANBoh628qVOQj8bBju63UKlUumcP6hSPu3Xz+kUuy8glIVXDSUACoFGoKjghQw/UU1SkyUDjd+uIcT5v3rHAio6rbXIqh1lIf7++Yepbu8veG3pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECFD/JiF; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAeOljhvjOK7RSBJEggVn899SVcVlP6QayVnfXkgmgy47dXx3SQLKVKIstKQcz6paklNjvxraVsZmlctKRJWyi/vUu+sNXU7+fLg8ohYl2v1w5TxsRT7freaO3CXMswbTZ8v3/r8j43NZU912ziHtYXaFvkPeq4trSwDVP5cj99ZwBdcm1ZbkpzC4JNHh+4f8+sHEeG5L6cELdtAZdf0CoKstmyIe8J/mQvR4VCdCya2v9MIn4DvCTPajryTOrLu7F7Yh7UQOWHc8a1t7O7yWNwOTlB4IQuZtZ8xuaeJf8Pzi+T8v7No6ClLyhGoTqc7O9jmX1IPOl6WlQx9o7dCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNagNSnN9Hq1yQgybrOfxQpFE0jQNCe6FtZtgBgvOqw=;
 b=B8Ls7Rwf66BB9zjVuOqCKNrlmaKa5gNk/R9k1XLB1yFGBOI6BIzR3e++YOFQCoFeig1RhDmwcCHlShjpp9KHx1dGPgp+JXweB0FE/vvNH3T3Q6nERde+gq97X88RsDGPObcL4z9wq8bi0UYb9RSUwFBV8FDjOtxRJ15cSEkzneuPljfjFJ6o6aNChLv+0ZgKzjB9iRLCen/GwbxvRJsCa39LxXDcaYXFr/h+Aqk+y+AIFTVLGey6zGCtmQMoKNpMao/ODswOvhHpPLwrzH8kyaH1U0MaXTgXCWCrasAaSn3vjALBkZqAWECSMs1bfXeMu4rSTlBnWa478foSvRTVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNagNSnN9Hq1yQgybrOfxQpFE0jQNCe6FtZtgBgvOqw=;
 b=ECFD/JiFpBR2k02x5XDaauHtezY9d8YYeS9S27c1a3nJbjmdSA3bG8S0sjDho/7a3Oi6VMfijJEcGdf7fUms5O6CbuCpSAUlopxD7jyaV2wEfDltLPVdWfwUARsRJ/YIFZoPisnQlGCdg5LWB3jBe98ehSWX4OlkY/nzG40Vs5hYsUIGGLOuJ8R6iX8NXZzbb8O+AWN1PO3fwA6Q+MohP+eqHg40qbRgulOa/bBxgT6WyAvBdK9tOkdIu5piFYokhv5P0W0GtkNVULKzbyX1VXuhPQHGp7jYp6QwGfzxmJ8w5hgtYGx6EvofL8AApi5tHbrCa/hpWHxKNVVEeIl6gw==
Received: from CY5PR15CA0118.namprd15.prod.outlook.com (2603:10b6:930:68::7)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 09:37:48 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::bb) by CY5PR15CA0118.outlook.office365.com
 (2603:10b6:930:68::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:37:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 02:37:30 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 02:37:25 -0700
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
Subject: [PATCH net-next 2/3] selftests: Wrap remote command executions in PTYs
Date: Mon, 18 May 2026 12:36:52 +0300
Message-ID: <20260518093653.551166-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0d2bf7-614b-4e1c-f323-08deb4c11fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|22082099003|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	php4Y7SVQC1713+teL4f1ytTUuMphobofv8qjlSIKyBHzF6OTj4MwEF8El4945cQrD2Q89kwhtkFP44IpWeuiCVJv5ZgoUQD5Rpg4fcKFvh5JjLj3aMUBaqcjsDLCZREG0xXIXJ130W8C+M+Hfeb4gI6m5SmWWfYXbgO3JoUj6AXqUi/4VTyaZ2KXoBQuCdWicndNrZWUdMcHD8TKRMzR8RfUHOMmvb8MY3ChP2VODJZ4VcRkaeibIMat+jzTIhGKlLqtYkfyPYKW+lUZKOIkYLyWO2QJiajiTRsSYcJTjwggj/F+0jTiZl+qonhtomgepeVVF2d1qpNc1EcIA34lPjWpUDUnU8tLTvM2tngfmAL+hebHOMzIkKI1ygzPsiZ/uSVrbrJ40KX/7/FzVUo58nxK+5S/ZJ+NlPMRveUG9htB4a5eE/N2VlXEE98QzuPZU1t/8vjy7RYKcmnOMjgZLAmCaks3oGWeDsrvg6bt6CLAlGde5epyK15sgKP4jCEEsCnV4PdhqKx7aN0fQf9KJyeoluHGfGcILgEnmiD3vbIA5MITy1vimgtIXMr1Y3a470B1hUJlnbUkzksNckymJuADXz+08iJtchmaps3Cdf+PVxosVme6Z9UFWpI1M3APNwHeWKH/J/vKxMm1I6NPsKU/3MTWiWXzRy/pw6szac8uVfXuevcIlRRWdRI0Ndv2qNAs542whvvIs1HEs6rIOGMvL3zthXz6nam1b/x1pk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WWRoccrqGlaKhqvllXfFLtVPnX9WTqYY3fAR+5NpRraT97315l6WFzXQ6YbjfG2KzOuVTH/ykqLK+24ShokK3iAPphEWpZcnIVohVkO8N/qGyvjVD2J3noAkywqbz9/Tt7U5XT4HCD8d0Mu/GLQRovp9rJM6yYRZXsiV9v++0Xwpk+drFLgB1+ug3bq2qf7u/pcRSB76gV8bG6eJfQFzBJapzO9G31NmdxojmKiZqFZZH1NwtJIRc/qXL14d/IafOMdxDC36ac7oCgycPWR4ic2O+YDe5ZxVIJLpqDq8PH8258d7cRxlGnlQMH5CdXhP+BDVcUJs35bYQLYEEP9hxTrJxP7DAdP45mFe/cb0QhPJJbdRXeNYJPva+Xw7mmFCQA/mM7pJJifUBCpKGGSbF5CHPESthqPpkVWPASmV221CmPgMciszQxDL5uD8drw0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:37:48.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0d2bf7-614b-4e1c-f323-08deb4c11fc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
X-Rspamd-Queue-Id: EEFD056A0A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,debian.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288972-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Remote commands (executed via ssh) left running in background are killed
with a Popen.terminate(), which kills the local ssh client, terminates
the ssh connection, and eventually the remote side cleans up the forked
remote process.

The next patch makes use of an ssh master connection to speed up test
execution. Terminating a remote command over the master connection
behaves differently: Popen.terminate() hangs while the remote sshd
politely asks the forked command to exit by closing its stdin. Most
backgrounded commands (e.g. iperf3) don't care about stdin and never
exit, hanging until the timeout expires.

In order to make that work, use pseudo-terminals for remote commands
which are backgrounded. Then, terminating the local ssh client using the
master connection results in the same result as today: sshd closes the
master PTY fd and the remote process receives a SIGHUP, which kills it.

This is done by extending the cmd() interface for both remote types with
a 'pty' argument (needed but does nothing for netns). When True, it
results in '-tt' being passed to the ssh client, which forces a PTY to
be used on the remove end.

Using PTYs results in 3 changes. none of which matter in practice:
1. PTYs merge stdout and stderr. None of the tests expect things in
   stderr, it's only printed alongside stdout when things go south.
2. PTY line discipline uses \r\n\ instead of \n. Nothing in selftests
   matches on full lines including line endings.
3. There are only /proc/sys/kernel/pty/max PTYs on a system, default
   4096. This limits the number of concurrent remote commands being
   executed on a single machine from selftests, but the limit is
   probably unreachable in practice.

So this change should not result in any behavior change for any remote
command execution, but the next patch needs this to switch to using a
master ssh connection.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/lib/py/remote_netns.py | 2 +-
 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py   | 7 +++++--
 tools/testing/selftests/net/lib/py/utils.py                | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_netns.py b/tools/testing/selftests/drivers/net/lib/py/remote_netns.py
index 7d5eeb0271bc..e010b3137e41 100644
--- a/tools/testing/selftests/drivers/net/lib/py/remote_netns.py
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_netns.py
@@ -11,7 +11,7 @@ class Remote:
         self.name = name
         self.dir_path = dir_path
 
-    def cmd(self, comm):
+    def cmd(self, comm, pty=False):  # pty arg needed but ignored, netns is local
         return subprocess.Popen(["ip", "netns", "exec", self.name, "bash", "-c", comm],
                                  stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 
diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
index b8c042689d20..427082561d00 100644
--- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
@@ -19,8 +19,11 @@ class Remote:
             cmd("rm -rf " + self._tmpdir, host=self)
             self._tmpdir = None
 
-    def cmd(self, comm):
-        return subprocess.Popen(["ssh", "-q", self.name, comm],
+    def cmd(self, comm, pty=False):
+        args = ["ssh", "-q"]
+        if pty:
+            args += ["-tt"]
+        return subprocess.Popen(args + [self.name, comm],
                                 stdin=subprocess.DEVNULL,
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index be9408a77168..7d400290aa0b 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -58,7 +58,9 @@ class cmd:
         self.comm = comm
 
         if host:
-            self.proc = host.cmd(comm)
+            # Remote commands get a PTY, which forces the remote process to
+            # exit in all circumstances when the local ssh client is terminated.
+            self.proc = host.cmd(comm, pty=background)
         else:
             # If user doesn't explicitly request shell try to avoid it.
             if shell is None and isinstance(comm, str) and ' ' in comm:
-- 
2.53.0


