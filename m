Return-Path: <netdev+bounces-303990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2xJESQERmqXHwsAu9opvQ
	(envelope-from <netdev+bounces-303990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A866F3C67
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="H1/GRZj5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303990-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303990-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 129973008C98
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993923876BB;
	Thu,  2 Jul 2026 06:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE207363C51;
	Thu,  2 Jul 2026 06:24:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973468; cv=fail; b=NcpSgctcSpJJeIMdHfUGb9fpbleLjZ/T61k3ZYK1qG5Q8Fx+dxU7D9NEBd/3GvvbaTqErrWdS3Ivl10E4+T/5Q4zFnOknwB2i6+boZ6Q1Kzi62rs9N+vkTEQQ20owxcURmr2MRA6XiJxF1yhCpAiZ0okNmtiPLRMFwGNWYpFbuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973468; c=relaxed/simple;
	bh=Y6+weOrDanuLZ8WhBC/NM7f+ftu4FcJR+/ebxpXDvQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slgsYZMBM8YDAUBa2SoUjTxXcUqAwIIuQUgEmfOMcYAokoGQIHAYwx1uIOH+WgkmMYwZXWgHRhw2CmBMbOej7BUduwNhJFU/NIJsBdEkeXAinwCMHk/5SZx0EAl5hWxOXnIjLsC8Bzb60NksFwirYZ9H/Kx3fYQWauKNLpnnmxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1/GRZj5; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy0ftoHmhU0V4MLKYKXU4IuiYQrznOBvBIll4ScbSO6l1RyDgjD5FAW0gknQF7d52y+48Lfr1dyunZEmh3xg4bxCv4k6pRwpx8mIPzDWEAnZS4ttqXW9dbHvKr3gkxTsoo2qqyrqpT4FDPBe1Ds9R6Ax+D2Ui1stxFHpG27k+7TfX7VCHzUCf0VE8cH42Kr1Y/HZcgm9k3ObW93BM/rgDM8Y3JNvfZdTOW+dkLvypNzXSP3ouHAf96vqAijHm2b1J7tRrASl9WnnWRZDGjDoo/R9O/9Tdeqf8qOGnJTppBUbUTs7W9IwNSJ4ugmfcuhx+FWX36FP8p0hFZz0iz+VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7d1iDE8V1i2ZdKY4BzW4AObbccy51fUZmnunRaXlZw=;
 b=rNhS6OXBDfhPXzxCXXCvxIk3Yl1yjcZrJXAtCMb3KVGc6YeeV38ZdRW1Vn5zCZy48jY8vRU5mNmujQsn86jKpfGlOZPrGeiMv+HJwUi41drRL4nylniceg2q50bY2k/IpE7hLERSD8bVvlbNNNaEQpKfELoade3X41MpPQ2swEw0IVoAxT5hFm7uJ7WTVfTsb3bakiTIuMAvNjnNNuo9McSr3kZnY7s3UgumroWMsXH3evcE1TluUoeZiDuCjVTa5tiHVWQrHH4FuiUCcV8byMwTeSZvZx/nczFFSxQf0GwdGrVptEseXYkIhzlMSFkj95WSCjuG7KJYRBCnQ4raZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7d1iDE8V1i2ZdKY4BzW4AObbccy51fUZmnunRaXlZw=;
 b=H1/GRZj5n8/QdahoVrLd+Krh1hH8D0mKjwzsq0x7raLT45IrBI6FkZTe2YsMcU1t9liqNWXDLbdroE+BETU8nqdOcHdLokgc47m6Nf/1Sf7a/uEEZW76igiCM9Qu24nz2bNTfhV69XGdoirtyNGURNo2ahPynXM/YU/yPOrYNcNcEXCWipmUqoo6onlEzqy9v8UFknlxPAaAtt+IplNgOUDXhRk92SBxbGiL5303II9xv7lLPdXOWEXKB4/LhvJRPuUd05wm6PryDxqmds+SoV84OChylt/gMZhN8YjP9FJhLh8BJLiFEzHwLMfxesJY3PuH9hIY8cUH97TSUokJHg==
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:24:20 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::56) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Thu, 2
 Jul 2026 06:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 06:24:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 23:24:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 23:24:03 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Jul 2026 23:23:58 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>, Willem de Bruijn
	<willemb@google.com>, Wei Wang <weibunny@fb.com>, David Wei <dw@davidwei.uk>,
	Cosmin Ratiu <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/2] selftests: drv-net: allow switching env IP version
Date: Thu, 2 Jul 2026 09:23:47 +0300
Message-ID: <20260702062348.2123960-2-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260702062348.2123960-1-noren@nvidia.com>
References: <20260702062348.2123960-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e7a8b7-5cd6-4968-1ef7-08ded8028d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|7416014|1800799024|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/BIdW4pDNM1yZcPdVKHq5tpTt6GzuC7xIqmqquedVsFzt7pmm6NjatxWtY02cDsgZk80mS1gIT9mWBNRbvqUIallawwqKqMlcLEtJa8ndjKI0zc/iOUAFbXHCm4Wsl7hlGiWuKHKe1VTWavq7QxMli0sbJd8jmf0DLHm0KP6tyqKwJutDb3sfrCO9Vf1PlY7SS3r99y4dEfYCWtjncu9Wnq+QcNMl8Of/tMujWuSJMOb3P3TUJWXo44dsR3jpM+dAPIe5+fFwdPaP/8dvWzYrUlEla4a240yyNf7Jd1sr8g2/c/yOrFWJf7K6k2qrWd70e+3L/jKrHJJ/eGWVaUzDbnJuWUIr5Pv8fDUb6a86ymo/qmAnzwikbXCAQU+bu8+DonL1SYkR7BnsSpzsEL1FQXN+cD+cFLTadyR3Sw1SI8ARfVMmPeHKjR4U16zhh4cshTnClpptm7BAs84Az6aQaDZJDMiI35gq8+JE/En39KK82PXiM67J98tzbhW33N692cUd+AIrMbtSvQh9Wg5y//vAqpy4r0eisLbcn5Fd5M/jyVCvQ0ItqGjIXill22bn4gxurZPjgp1Yt5b4JwiEF37F8VbZd5GIn2YjxLqsuAQURdk1UQXOTO+6aycPJXTA6tEiTiSz1BFP8Wpcl1AHQl5T0Xxp+zBr161ByyqBhaMxQXnSq5A1XMPigXnB1pw48VLbYMpDsXFOJSSpeSbbg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(7416014)(1800799024)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	77gNuN+yDiUYViNZa24Z22aKEjx1hAFPfekk6/hiJMA71HHvImcXEw/P0CP8JWmHyqlrsdeezUDoQlAhdpCXpnh8bjPcQOfSPu3hLdSpu6lva0YBSKvvU3bdgdWV9t7EoLw6gXIGvFa6Lb6PwxNcKDHeW+a67irFF1LVoP/6qi9l1yUmnMRe6Mm565jd0WojkreFyAsYTU6PRwGRhTLDtbpYaEJoAeS6PKZWP1xtjoNKCS2u+rl1D1e4Fh79GxGyizhdNO6ODKh9fqyr5WC9zoB7C2Bae4BqoS5f5V7xfDjOggQKPvp9PdMGj2TPTpNJXNgg60dmxc2lO3e7DcC8lt+LhdL2Wnz7AjfRtax7IRpL3baqhk17pQ1LMeNpBIgXAng8UE9qPP+ioC16ooWeQx4XVDNkYIjt9jZtDvkehnaBDudn3WbLb0J+6hD4/UjV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:24:20.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e7a8b7-5cd6-4968-1ef7-08ded8028d2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,google.com,fb.com,davidwei.uk,nvidia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bobbyeshleman@meta.com,m:willemb@google.com,m:weibunny@fb.com,m:dw@davidwei.uk,m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:noren@nvidia.com,m:cjubran@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303990-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30A866F3C67

NetDrvEpEnv picks a single IP version at init time, preferring IPv6 when
both are configured.

Add NetDrvEpEnv.set_ipver() to reselect the IP version and recompute the
derived address fields.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 .../selftests/drivers/net/lib/py/env.py       | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index e4ab99b905b1..e4acf3d8333f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -159,13 +159,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
 
         self.remote = Remote(kind, args, src_path)
 
-        self.addr_ipver = "6" if self.addr_v["6"] else "4"
-        self.addr = self.addr_v[self.addr_ipver]
-        self.remote_addr = self.remote_addr_v[self.addr_ipver]
-
-        # Bracketed addresses, some commands need IPv6 to be inside []
-        self.baddr = f"[{self.addr_v['6']}]" if self.addr_v["6"] else self.addr_v["4"]
-        self.remote_baddr = f"[{self.remote_addr_v['6']}]" if self.remote_addr_v["6"] else self.remote_addr_v["4"]
+        self.set_ipver("6" if self.addr_v["6"] else "4")
 
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
@@ -252,6 +246,25 @@ class NetDrvEpEnv(NetDrvEnvBase):
         if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
             raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
+    def set_ipver(self, ipver):
+        """
+        Modify the IP version used by the generic address fields.
+        """
+        if ipver == getattr(self, "addr_ipver", None):
+            return
+
+        self.require_ipver(ipver)
+
+        self.addr_ipver = ipver
+        self.addr = self.addr_v[ipver]
+        self.remote_addr = self.remote_addr_v[ipver]
+
+        # Bracketed addresses, some commands need IPv6 to be inside []
+        self.baddr = (f"[{self.addr_v['6']}]" if ipver == "6"
+                      else self.addr_v["4"])
+        self.remote_baddr = (f"[{self.remote_addr_v['6']}]" if ipver == "6"
+                             else self.remote_addr_v["4"])
+
     def require_nsim(self, nsim_test=True):
         """Require or exclude netdevsim for this test"""
         if nsim_test and self._ns is None:
-- 
2.45.0


