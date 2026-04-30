Return-Path: <netdev+bounces-282848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ft6OKBQ82lnzQEAu9opvQ
	(envelope-from <netdev+bounces-282848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CC4A2EBF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8033048084
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007FA40FD93;
	Thu, 30 Apr 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="gXu4cSbX"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33D2D7DF8;
	Thu, 30 Apr 2026 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553442; cv=fail; b=ktBWg2/rGbSk6LILlpoXDgcbaeJGTPdWyFZLePzp7U6IVKx1ogIY/WVZzjJlc9+H9pf8IkDB7PCgE0B3BQWVznII3fqEBKRBKjfjdyUKESZhlI6WwxrdjVVJzdEalQkKSgHXL08VrYLddXVehr+Rk3cc2wn8QNhAVC1Z516eC1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553442; c=relaxed/simple;
	bh=Ls7diikslxeqm2Pv21jLLQEdsFin4RXOs0OfkK7aQDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5TRFVRVFpxseNyLVr4nptKKLhSyQu3KftArt+E+nM5yqbraJGcOqDmW4c7Cho7G67HncaaEgmKER/l1Ptf+zv7UD+k+MwcD0khT5M4ieYob/7UT4tH69PnISlfaLgoOc1LJydta3+UfRqyQY67YgFri8cXliemNci5vEon64wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=gXu4cSbX; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITPj7CruWwMgbwh81nbma9oQ3bzUUQElC0925ZbJfHVPfeMdaeF/5Yp3G2kMpg6muznHrtGEaQPtMg970Vql3f1luu4Pz9puY0bXV4tvKzz1waXwU5tuNxGMlpT6FugcNKy/plaAQtem3q3MF+gucG+H4e6VzaEthYIH5S80Oq5/KnUMdtcsgV4pPqVeVHWtCGsdWqfwYnf1hyIMP/59h7QSeB4qz03rmgO5vPZkSnpQ+wJXZDlje49SbMFtmxwZao7yyv+AQZS6hXxCimwSCIMece97fEctGaCfos/oMJFQdgkHwZ1IntdtewZC/panJImC+2YxP2e2mauPbyF5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q31y+Y1zmMgn8xKAPozCEs6nDGQExBY43Zmlt2piF9E=;
 b=MRGSG63sBRiQkcF4iZx9r1j8QqwecybXl75zTTxFxAcMlCi5XDqm9m7aDCdggd8rQXk3P5WXlWb1yvnZccIq0vXm/4ysr3T8utnmjmqis1J9OJ3xR90WCg+Q9TXntRjIuKNdZTuBa6vMkrNfW3nuQ8sXDbN/20VKQw7drpDSnpIFvOD09QQylg225gQuaHFThQGQ3oAxvAGEQshm1SEgT7LpDwVR0OyMHWLkzTVq6g5DKxL/0tjCUgXbyCaZGiOZmoCMcw6YX56YqW/UWwGXn8AP9Fb9wGgcQ2TKMgNJcdQa5s/H0OcHGJHR4Yj6QWrFtyUKTL+rWX6DaihvDtcCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q31y+Y1zmMgn8xKAPozCEs6nDGQExBY43Zmlt2piF9E=;
 b=gXu4cSbXn2LaoxeHh6PbywLXlZPQ9g3U6udqMb6B+9cRXGDdobl0sF/kfeIi+b3t5mHfRB/mE8ZzUeqL3BX1bOtVKZhE2YeTG8YcZLiOMGN168u9jT9vsaEf67kE1+Z9uouvkut4rGKp9bgZNr/uD3fpH+5/ljGRT309ROHsWgWKgwXubQcbAFoigeSwWa+SV8hOss6u9OV0oNDoRrqht5p/j7voB252w7HgwQG44m99zfLGMayXbImWWCigaRBgO1VU9cRlois80b7GoRKM2a1eS9Va7f1nwFyVAO5z3fjG1aNACncuFMwvC9MtWw+husl/JQXStUi1P45ZfJbPYQ==
Received: from CW1P123CA0005.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:293::19)
 by GVXPR07MB9889.eurprd07.prod.outlook.com (2603:10a6:150:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:50:31 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:400:293:cafe::8d) by CW1P123CA0005.outlook.office365.com
 (2603:10a6:400:293::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:50:30 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 30 Apr 2026 14:50:21 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 1B6AD402084F;
	Thu, 30 Apr 2026 14:50:21 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 08D881005C88; Thu, 30 Apr 2026 14:50:21 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>, "Fidan
 Aliyeva" <fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next v2 2/2] mv88e6xxx: Add SERDES Support for mv88e6321
Date: Thu, 30 Apr 2026 14:49:07 +0200
Message-ID: <20260430124907.3533344-3-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
References: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|GVXPR07MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba9534-96ac-4901-c858-08dea6b70ffb
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sZ1GJjUp4eVP6Tj3SodJZ7pzrTBLhZHvuoKLdXMd3na2zTttMKlBlJvmNi2UV7Yg9QJUD4dWGMX8TnlYkWi75vapMYNK3h/6Wat3ldQzFlh1Z13g+MMc+7sBvZr202eP++cG9njz3bEmpnIimqPRjMrZb6wZ9cKZzd1cgXnaJBEIzSxKysdvxkuWnDU7NiJrSipHAjVpfPapN5WH8JP+BdW/CUduc6Ve92GKQ8wt6koW5aQByOSAtIuB8bFNjVEv4a5TUhyHmwA+73eYOIcrwvbywz/U3e/kVFY+CqLDBCiRt6iGlDbJS96sJ83AxtpThhmeAtm5yG0mQJ9cZ3evzVe5rMgWSDckqTpuy4zNuLHz5Yh3P/0WZ/dTJB9A58SEoyzecq5OdaaaeW+gjqbERdkjnsAunXkxFbU5PjtzQmfmcSLYolKDuUTG8s2JB0IDYQQGUOrtN1/GmdbS0gwviyMQt4o7t2hl7TdBjpqwT2KJQbSk13BxuKqPnQZmEWjbkhCGBJSblB7MOCcPwjnRfYBxB6GBZjTnyRSs5A57M3TNjnfyfPicUHliaXmlLYtCD4ld2EAQpY7SPGGBPNDPHTVMewCQqEpcdHxu+OAmPoQhNHhkCk8mbKQ7Kt4m4aXEoJVlOx5f9uPphnXEMOzwjbqsR64ahJzTCIQn/CskGRHzJsIu26xQN3pQctaAhfRt0aLp6aQIlgky54VwbNi7MLM7AyuSkl3ktcluXHJm9rz3YlNAi7NHXhEjNgy9zoEfnUfPC0VXQl2T6GU5zl9tKw==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X37LdzSVdMaDjAZCNm9kh0hGqGJJpq5/Xja2awbcxLIc0vY16uhqmMZFZp3t8Bo9UT6SGZtLyhL5XKCoM0gc6K+nFrYqbMybo8e52pxb7JnY4FngN0jCTkQwT0NJIyPd13IZfoHElZLz9DL3YRoYykJwgVsN+UYCm/UrqdQ04d+4S0eye43Y6lciWphI9IF30QKaHSCWYune4ISD9F/qgxM9G7W/jlG7dj0ltbhq9/7jXnYCZkPPwXCRnHAVQhfO9/rnFSJlnhuuNwZHGevnLGDsANM7YSdDPEDitYYFZwo+w7Vre8p2GV5oTmyQNtH4LnKWdNmER5ad5JT8v3TBCjHTFJYOtoGiaEQU8nx2oTzl7eZ2Uk0QdUzlg0eyo/3CsNlvPURQcPJV05totleHOVT7SdqU0M4gUHuTFUwzvxUCQiwSyhAQk9d5D3Mcpmtt
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:50:30.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba9534-96ac-4901-c858-08dea6b70ffb
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9889
X-Rspamd-Queue-Id: 4A6CC4A2EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282848-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ericsson.com:email,ericsson.com:dkim,ericsson.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

Add serdes and pcs_ops functions for mv88e6321. In mv88e6321
2 ports support serdes functionality; port 0 and port 1. These ports are
serdes-only ports.

Changes:

1. Add a function support to return the lane address for the port based on
cmode. Once that in place, reuse mv88e6352's serdes_get_regs_len and
pcs_init functions for mv88e6321.
2. Add mv88e6321_serdes_get_regs function by reusing
mv88e6352_serdes_get_regs_from_lane

Tested on mv88e6321 switch port 0.
Builds were done with allyesconfig and allmodconfig W=1.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 29 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  4 ++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 15a8028a02a8..c1f7fa21d964 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5259,10 +5259,14 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6321_serdes_get_lane,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6321_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.pcs_ops = &mv88e6352_pcs_ops,
 };

 static const struct mv88e6xxx_ops mv88e6341_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 273c3b169f65..3f8c178cf843 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -249,6 +249,35 @@ void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 	mv88e6352_serdes_get_regs_from_lane(chip, MV88E6352_ADDR_SERDES, _p);
 }

+int mv88e6321_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	int lane = -ENODEV;
+	u8 cmode;
+
+	if (port != 0 && port != 1)
+		return lane;
+
+	cmode = chip->ports[port].cmode;
+
+	if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+	    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+	    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+		lane = port + MV88E6321_PORT0_LANE;
+
+	return lane;
+}
+
+void mv88e6321_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
+{
+	int lane;
+
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return;
+
+	mv88e6352_serdes_get_regs_from_lane(chip, lane, _p);
+}
+
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
 {
 	u8 cmode = chip->ports[port].cmode;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 21e050b328cc..c11ea2118efc 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -14,6 +14,8 @@

 struct phylink_link_state;

+#define MV88E6321_PORT0_LANE		0x0c
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -114,6 +116,7 @@ struct phylink_link_state;
 int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);

+int mv88e6321_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
@@ -134,6 +137,7 @@ int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip, int port,
 size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 				  uint64_t *data);

+void mv88e6321_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
 int mv88e6390_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
--
2.36.0


