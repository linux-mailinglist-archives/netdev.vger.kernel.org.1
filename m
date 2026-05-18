Return-Path: <netdev+bounces-288971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIqtKTHgCmqR8wQAu9opvQ
	(envelope-from <netdev+bounces-288971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95856A075
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0381C30166AC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD43E8345;
	Mon, 18 May 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwsniiEi"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EE3E7BA3;
	Mon, 18 May 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097071; cv=fail; b=LenP1ECGxk2Y/2wX0Vkfbgi4OrrIPlKDiicz+5XdxEoOgmlFMseUVZhGPG+43ScoQqCxAfOGrWaGCofdgq9Z2UNRHl07+vhiexVhjLMLCL17MhrrWThTdKtxk6mxKYDqAdQSYl0/2RZUExfbHcIJmuVWxD0LqnDQyZ6eyYElwzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097071; c=relaxed/simple;
	bh=i6nO4GYziL5j8LVHUeZzzDUBw2QN9KIGgINlKFCmreo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZudbB2e93Tgu/BW79G+8tOBKEnEv4VBrfU9phVW3CQOyICMSE59yQDFlXkdjBnW/52H5kshXxTWXiY+z4vfATJOLGGLYKuKRPkCLnvkLwv0T5R3NJ0dF5VL91vklLk03lrO1BFWslowA+MFPeI8ZYfBpPlQN1TOvol/MlJKagM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwsniiEi; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrNPShHfGPbEsarDPyigN7tDNXe7UaBUZRTPHLIr9nvOghGqJaPRAk5h1ZhBKokKyLS2ZISXIThnjSiHcfZx6ukNXtsWMYbQORK4ibkmlK7r7REO7linr00Il6aH/xbelVMugu8vsbpIS/e6qdf2j0ugEcsC6DtUbRSsTAkvxRa6hOY6AeZZB9YFq8PyvDqhZ1ippD2VBbiR4jxvdMUl3jd2QXYDwf0IQa6cbdsUOvpSMvY43u3Gqb4tQq53whpEKJTuH5/hP+d/E1QD2gZY+ID1l8/IeMBryDquekp+xhPq9FCmvEbYMNy04peihsu8DN9jqDfS9L6EpsgEGyk23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB6dmUP6HoLLh5XxZf/Gz1q6hlZF6cVbvJZbAuCxJ4w=;
 b=Nr8AQYZc957S1+HQ59sKwjQQoOGqMVOWiUM4QZunfWXPdicz2W7ZsXmaB1t0v8L+8c6lkAmO+B20SzUwo8V/flnWc/8Q3SiXMmq4RqYVypfnSiFXLqj8B0Z7Ok7WFgwV6GZn7+euE8uoxuNUs5QyHiyssFtK9h4/OZgmbwXTk6o0bkHl7RreBIeoQltVaOuuAsS/qtHAxL1Eh9+ygUyIKgaqRwjdgdPEE8kbyrkrk57HMluOQoM4xPlkP5NVCvRsC/P2jg71C+4gOkDnmMGd69YKqHvUNrjZZHc7fiaL5ENXZ+8Jrn4GbOfjRrBTI5TRbVQMEPhAHKsdMcTkw8yhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB6dmUP6HoLLh5XxZf/Gz1q6hlZF6cVbvJZbAuCxJ4w=;
 b=nwsniiEiDR6txhLOUVwSlYR9DBPzY7qT+kzHRmSkaPug18ppoduiw6IWnw3ohkr0VRsq20Wu8g8vh0z496FzVp0LE5/065x+eo5d/uSNbbHiUdcEWM1J6eID7JMox6XNKH1Fgnvoev13iJidJSi998ZU82WwHmy1abjtth7/zcKRrAEg863d+w5/1VBZVDLhDamz4WQOzvhZf/1VH/rixLWhUadL18W2fhPfRh3XqExTcyGzjYJo7B6UAIu7IsgFdDbE9K20Ym8brvAlRDyDNqQa3VQ+tVPX29KW0uxrSa1fYoGfHYSRk2gr85STzyHtOa1RattkmmYuZqpv7GFIfQ==
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:37:40 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::67) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:37:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 02:37:26 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 02:37:21 -0700
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
Subject: [PATCH net-next 1/3] selftests: Disable stdin for remote commands over ssh
Date: Mon, 18 May 2026 12:36:51 +0300
Message-ID: <20260518093653.551166-2-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: cd811a5d-0c2f-4bd1-d7df-08deb4c11ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|3023799003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YkRsRTOz0xmRLGVUk/kdsVqKYymwtswpTvp8wXqAmOnNWRfq4V1DfTP9jbZDV93uL9iFLXp7EzfyeZ+d0Y31DHocsFfl7Lad7WeHkQaR3rsxYbexAgls5PzeO2rgsHYopDgyTTTCiIiUSofLykm4zDxU/64iqyYDmPBHaGeXjHPKrDcvwCKBYSPrRJlfpjZHRCIPKj12wR+ChI7UZpgNV/deHz46BgIdWpjwHjekLSRYwJkFO+Ei0o0EJ6orw3gEexMW7O+0Cm5DWnh09PSY2Pt8SjG9SmITZiVAUhY4itkXZgYEP8DToL0dQd1QvePF0hONF61E6n+lpPM8JTdt3kNa3+yJS0zx5qqW04ZXm45+PD8MNbCuI/t+FuUyL5zGKeDHOdlNsqnyoLX3ugxhRcDvpqR+UgHgoaCwCRwdHvkAYeFwKmdbWrpNgR1BIvUgLMib8SpilyhwtS+Gyq/DIbgFN2eZmVH4xc95bvHHczuXDoubhkZAsvK+2vOW11XUtNK3L/FTIpmUNlfVUEyJRN1xHb+BoOn6DA3xsE4YwnB8sBak3yoCtfB9JUFr2WW98SwMoyGLZnx0M6VY+yJF7b8qlrN6mbmAypOQdqunLpzSuuqZBr8NUvwGqiE9peGaNsMdFxibRgxKSnu/zjZDf7NVvut+s0GVDBu6CimrQr2C7HKTYevKnzvIduouaS4GyxUREup3XG2GZr2EPN16t23ec5kxiaCtPG1aCNbRFoc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(3023799003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fkYB4S35AexPy0U+27Kq1wJ/xLbgCGWvBtlypOsB2En2sFH80JUHJxrd1VbeAb9LcAjJSRqgZI+HgIz7MjnduimqUeQ5nNPSmw5nyVV6TDi3PANV4QBHoeTFlALCqp7WAxuqHO/OVChD5aqL6emLCoUp5SAOghkoivbdwuOg2g3SlJPwQlRtNh4ZO3qnwUn/PV7GHtFlK5RHTJqvccLA5pU0tq2Jx9JMR713GU9Zkf9/PDZ2wfsj2nJOau3RmhyrmdVKJDVluN6NZMJpGOfAvGrB2t8WKNBzOEy1n7AeIKmxOL1kuDmCR9N2viEVAZLu785OxQLaPmE5OvDdjE0H7l0a+i4QAQuHnFKqtkASSSpjsfJREWy/M26XziiKODzZfyTufFvPCP5fN3PptzlL0RI1KyRd4S7vhmF8hTlCstndzJEN2Sas3dmdKVq9LkYl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:37:40.2323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd811a5d-0c2f-4bd1-d7df-08deb4c11ac7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-Rspamd-Queue-Id: AF95856A075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,debian.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288971-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Local ssh clients executing remote commands get their stdin inherited
from the test process, but stdin isn't needed or useful, as remote
commands shouldn't read stdin in any case.

Explicitly disable stdin for remote ssh commands to avoid executing
remote commands which hang on stdin input.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
index 924addde19a3..b8c042689d20 100644
--- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
@@ -21,6 +21,7 @@ class Remote:
 
     def cmd(self, comm):
         return subprocess.Popen(["ssh", "-q", self.name, comm],
+                                stdin=subprocess.DEVNULL,
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 
     def _mktmp(self):
-- 
2.53.0


