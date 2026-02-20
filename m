Return-Path: <netdev+bounces-259702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPv+I5hMmGmaFgMAu9opvQ
	(envelope-from <netdev+bounces-259702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0A167667
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A815300381A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5874E34029E;
	Fri, 20 Feb 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="R/nzDI7s"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199C330672;
	Fri, 20 Feb 2026 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588756; cv=fail; b=c8/mLok5LoNyvNESrM+nyxJPtpQoCdC/1bKO5fsXuj28dQaKT/g8QYifxP+Or9U6VtQmIjaSV9kaD2JUnzfxirqp0utAOy7G7nLT4ETJs46leHCHzdJZPQoQIShXTwq3mJ810hvn/c96xvLLsvxpnvhRGTFwJGhdwGAYvChhVxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588756; c=relaxed/simple;
	bh=Gswi0TPukwEv86U3DkUwi1wiixllFInQC/ud5AQsjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXHAznbfGH807Hzpu0fsyGxpsuM8vI9uV9Ko7i5Y3jy95qzD6GLWhPHdkVwd79LZFy+slIlDfBo3K1PdFUPB48vzsbiDdsJO44EmuhfjlFPovoxKeqtkGEcE4dlbfIiX5f0UrKgyyeWPdoy9bs1AMY7ovy7JiGyfMtbK9dYl4dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=R/nzDI7s; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWjuKcXSeYcWeicblvL7eWx7JUCTkJL+CU+hKxj7Lo5QX+RyFZ/M3fpWndm2lYUGkOdzCQyfyNF5RL3Mb+dMB7taN/9+QGjVp3Xdpdpg5ijzBVip+Xx+OlHaHCVauh0//0kuSZjGN4MWL4DsFrjQfKeElDzdFS3Z5J7yQ3/axffopsUc8ptjh9s3uEZsEROxxdGpHfDf+70Lt1Zzl23IySTNzfrNe9pH+gw7QH6Hq3FlOwDk8Qi814wxOuuz17FQZ09ur/54B5thBerM5dYzmqC8Qp5sk8zMqteq8D9o/QehfYLeYEHgR9Rl2wJc/2feY5uSW8JUbCxGPyEkUuzlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxVeE6dugXs816M7prKnkVR5yS/SWudfIshlbt3L5KI=;
 b=eXv1eC9iyM1PTktWJKdtC2vRZ1QGZH8p+NT1LAaTYQGHu1wr4Wvcp9wJON1Ax7IZimKOVv7fjPTEWho/nC97xRR5x4ao+DDlsNm04Q+PJ9tTulr2Sr7mXqlwKbbN3+xQ72Dcamb5xtotVnlpCg1yp3ASCrMK8ryEj7FKuNC7Lij2yHxdmvrUJ02gdxJ9eLlJxeJwps2DpwfpTaUauviIxfF7W5e1hgncUdOyfaVZU75VkuBgVhNw9V6IqHzkfa5V74L/d9keVUuDeNcofeNkWNOrKDN8D+25p7tTVQdczvi40R8NCjJuDyRPpbBvBJYeB8h2w3MElwPADlRG80eIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxVeE6dugXs816M7prKnkVR5yS/SWudfIshlbt3L5KI=;
 b=R/nzDI7sLkbHHnkV9uWmrOgoeD3Enq6bHLts2uR8rY4XDzVNCiQkVCSwh8PR/PeiP5c1ln8zjUgfttpb8FXgjafvq6n1ctfUkVOlLzZM42F4o4UYLp+OhMTccD3f1hmW8gA3rHKEQRBYOrDJbWihEtSLxSl+BGcYzr3XRcLmXaKiHusdJC5L2AV3W67DWXA/T0/icffC4sO1d68NntX5ai4jUo45VQAemFRQowBDiJvFn0k5DzR3Opi8+Djz0E6cPZofu8Xwy3q5NPVn4iwqwVlpluIoPy/DyaqibkHKkbQ1b16Z2o7KL5Xq6xZiMzda9N+xob2Efnwqn70iLFSvdg==
Received: from PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::24)
 by LV3PR22MB5320.namprd22.prod.outlook.com (2603:10b6:408:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 20 Feb
 2026 11:59:12 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::65) by PH7P222CA0024.outlook.office365.com
 (2603:10b6:510:33a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 11:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 11:59:11 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id ECEF31A2CC;
	Fri, 20 Feb 2026 13:59:09 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To:
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
Date: Fri, 20 Feb 2026 13:59:05 +0200
Message-ID: <20260220115906.102470-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV3PR22MB5320:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab7c72b2-63c0-49de-de64-08de70777630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vw+u2NIjZ4jQlE/vQde+xOA51ZpcQgocbE07JMS2+GN0tHbOKGSFjjwOmJ4O?=
 =?us-ascii?Q?nl0B1VZ6ueY9OZKTPEXlkq64YeReb8PUaYtqEC2es5Y8wLTq06je0A/XZd5u?=
 =?us-ascii?Q?w/U0ohLHirJeN6zMn5VG5CsCAv/X/fc3G/5smlWVYUzkgQFE+9MYE4Z34eX7?=
 =?us-ascii?Q?KMn04slyo7kNkwBaBZiTbv6Is+Be+1nXys/aSW5BF1O03iWZOWOSYIbvfpxS?=
 =?us-ascii?Q?3LWy6BW4tAmiX8NW9NzTRMALiSIB8f0Vi3Klq0GIGNhYoGv5CNf7keW2ZhoX?=
 =?us-ascii?Q?q9nTBPeTwhV84BSZT8s080RiZra02L0aryWJHIVayATho972vK+cZM4D8wCm?=
 =?us-ascii?Q?Bn67boBQAnMnLQ7PAk6qGgbCPsp4dC11kwN4PQk7QDAwE87OoeCit1Y9Ba94?=
 =?us-ascii?Q?zl6pmG7cHDNkt+6trf898aEvMpet6OyWNKvDEDHhuBE+wpff+qBVdsX0PRdd?=
 =?us-ascii?Q?PMJiUDS+dbmDxjcXmFEDzTVOwPIMTP7U16Vb3I77q5H1gCmigryI4Qz1oTEY?=
 =?us-ascii?Q?ItG2FxOmk5qUTa/ZSbDnEFOht9AkvGdZOF3nk29s8na21E0vWSCYRPLPyWIi?=
 =?us-ascii?Q?vE4r6ohMZmcXBd+r8f6/DHKif6Bxh20mlvKzI9mAHeUuDxiofclrk7q1BWAN?=
 =?us-ascii?Q?3pDvdxg/S5pD/v1928T3YiCB5LIhJaQckqwaMIObJdG9dco0J2Lqb+4ECTa3?=
 =?us-ascii?Q?0fLoJS3tUYG9uZHF9gGe1dlEtR43TyvIOoDBXNoavGiqdO409nzu65/NSZYt?=
 =?us-ascii?Q?ioLdY7SDFD0J1eizdqkzGTb0kRvcWRA8FW5IV5kA54sHmSxYd5pdvWwQM4yj?=
 =?us-ascii?Q?jKMeZlbSWBdm+wUz9nVPU2Ejljvsxy6TT0vG9MnyGD7S6Db8OF/ceIuB9Ble?=
 =?us-ascii?Q?z/5qP+wTsGuxALPK5WW0LjKXLVAx0XKC0+dzXx6xFOuiXep6WPB7DoH+5W3Z?=
 =?us-ascii?Q?sSvMcpRl7/4zD3tuIi6npIIbbX5db6YHVsdQxzKsU0HsZJf7h63QSL5AQ1J/?=
 =?us-ascii?Q?/zDNCHhKH99rb2VByIa7V4NMp+GelkXKMxniBriUVYDuj9dzdEusG5wIJ20K?=
 =?us-ascii?Q?2Be6CPnzg2A46CayB0sJMNtpuFVBqNWoXUjwTbyg9WrMHaDJuer1UZttL7xm?=
 =?us-ascii?Q?w2n680omPY2U2ogzMK8qQlt/jQuhSnaS8YNqbWj6b+t30M2X2M3KjV/yrPCN?=
 =?us-ascii?Q?1uNngcVzJZ6X9zmRoHGRB1brC01XCKd3E2Cnraw/frOenZdzHb7FkT4GIO6a?=
 =?us-ascii?Q?riyz7vIJehwL/xxuMk08pSAHtUMujt8ZcEqtx6/KPTH5VHccsF+la0x3u3d5?=
 =?us-ascii?Q?YWEVPIg2HirVlGowqW5Yx9urFYssB4/P3ZT+TT5lIqC+jufcXFUUBQ9W2tPn?=
 =?us-ascii?Q?o63RBzSHKXjOpcdtsXSlypMTugB/X8yalulcJkXQhUHCiu48ZYGaIkxI2oxE?=
 =?us-ascii?Q?UbAnxVpoIeDmVmGzaRoYBtzvkW9+O1y3ApUNLO07IpMbClQtmT7LUI5nHgDy?=
 =?us-ascii?Q?Co+F3y8SqZkRVIlwBERtqmLlMlvXNL6oJoetSgm2LXACOJUQSx1RQzed44xx?=
 =?us-ascii?Q?h62cO28DZede4YnwsIUeuZCXeJmklJMAsyr9Toy9czxPsP+qEko1xb9W6YLn?=
 =?us-ascii?Q?yRvVyFpHQAtMYEth9Y0ffIFj2fDg7Of2WbyTZhKXU1zxYbwqWt2jhcyPxRk4?=
 =?us-ascii?Q?JV0GPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jCIEf6QW0r9e0swGbJYRSdtks7iciijSHzIYAJai+KQ8gnzZk6b3UpydVkWa5MjvmiKEwGM9gMXvGxwyph/hXFTPokLV4dku373YR5ZtlKAL2/jMGsqDkZzjidSNuGiyVTOgccqAhj+84/9FW882wFpgpkZMpYTYAhYIVUrcpbuJGVcK3ijaOtJa/tzHknmYFRJv6joQY4PJRKkwz2T7uvCAk04jz3z8RKgfv4oHFEM9ge+9+1h+5iggqcJTN49DFvna9hRm5oN6VY6KDqUjLAEP6qO1jdlSRfV1s46zwdDKvuyBnpzGpw2CllLXgXffoDnLkfWUsPSYUoAZCNZ80LrSfPsNaR1Sn7LMhUwW46t5z1bmYuWCHbHEsNJSy4M0kAZK5bZ5bldGPvSl4yRoqGEcfJbSlqzk3Xeq5eTmp3y6S2pvEkdNp2tmfrKKW5Ln
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 11:59:11.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7c72b2-63c0-49de-de64-08de70777630
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5320
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259702-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gehealthcare.com:mid,gehealthcare.com:dkim,gehealthcare.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B7E0A167667
X-Rspamd-Action: no action

Allow the firmware and enable GPIOs to sleep.

This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
connected to I2C GPIO expanders.

-- >8 --
kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
-- >8 --

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/nfc/nxp-nci/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..b3d34433bd14 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
 {
 	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
 
-	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
-	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
 	usleep_range(10000, 15000);
 
 	if (mode == NXP_NCI_MODE_COLD)
-- 
2.49.0


