Return-Path: <netdev+bounces-216294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB3B32E59
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7984E22C3
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5372652B2;
	Sun, 24 Aug 2025 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfV2PHl3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B02641FC;
	Sun, 24 Aug 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025089; cv=fail; b=KaEdLkm8PRbtAf3YvfHvivnIelXPOKES4qY5/u8EnOLXulHI4dvBPqD9igX1VuOuayFsU8//Ip4uPpWhKMbQ/m1N7X/GW+hHxk4tcdwyjgA33clEKSGZzzG2fVImaUuzFNc/rOP0YUs41gQyUIuH7TlAsOu0FaZOnjf6r1TQDc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025089; c=relaxed/simple;
	bh=wVlTTx0zcB3+Pt1SF4QYDNB/RXopu1ew6HD95avLsEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvzEytjwqSczUGlqURM0Qiacjn34p4E5JMW2fwLi3aNE4vQ/mrcdnhfwmxKSK/xASKYOBdDtu8tLCvZIHAFgB8hyxJdtZ0j2F/FpPq75q5UqCtmkWH5276JSsuzS2JcM2dI2/VxvzcGR17hq9uhxiUDjq3FZYFJ1+Et8Mxv2XKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfV2PHl3; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKoyBf6McSxvYlquUMMLS7aCbOOc8yBrUpnzqkfhJnqdG4Llmirtbkxm7CU35aTWxZ/uIX4ciMmTapBZvzJqiYr5dEXmJRAh3pvBr6bJKmzLdMx7V71tk0osBSgt4I6D6CHQ+0z85PQWhDBuK6NrmYXOpyeaCi7nR2iSbngshhv4SocYe3XebPKeCSEESSoQj5NqX8NGVkXcE4GizTI8uAiP4qE0GOHNyo7eVRpdFfcwv2EsmHFdDV4J4pzmNRVeihj/NfvmHBSDJwc8V48qdOHCp7C8ZotP12rLPvJPWA5dlPzJ4KAjh7MV9EWun1Vz1cqa7VVIH4VxNlAS155yfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GAwcZX6l2oFKra56W+9ZWC8gNRB0OjkIGR2Ov8XSbI=;
 b=CKzq/KiXKWPNhEF6++F6R1O88t6S26926Wi7v3pp9xShFjcGuj+cXWK3LABmOtINFkHgYvwehixsLTDDClpHRxFSCt0EVmOK2dPE8KvOgYJIUzsI/uN4cC/nPWW0xg4DoycVAkVs/DzjzRomKsDwvmxClfPPiyU/SvsbOw7+/FtesXj58e9j2XRvI7mWT3fNo6dsTWfw/e3K/EqRdcmRxjjSAghjBZWEfVIR3CLIfByURiL8HLLF2ZpNPBOsvYUrMUDD8aDyYRyFpasiIO+Ee3sY2Beh7pI8muFM7TNSOFJ8nbSDfuxe2pECxQXQJdkZMfWJJF1K+HRX/DMEGJrabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GAwcZX6l2oFKra56W+9ZWC8gNRB0OjkIGR2Ov8XSbI=;
 b=jfV2PHl3tN0DPmDfJOH3OBIYGHZ0NVCRty3Rug6Tj1CKjBf3F8xYOCiy6JXAjPUc6n1Ot5Xx1mNW3YR39HYIjNgQXyK7WkDku/Z47SDe9YlInIcUrp184xmx4vqujsASyNsDFX/gewxJQOeWO/9ikdMnKwz1gB9DLJ9IuXYvWZ2bj5PiL2wUmtDyjsoV/vqP+7U07WDiJIXAHEc53ShBiMpp8HiYqL5jJkXOlLAK19niDh/ShQ7acNgrNEhit7ggjGklp5XHwPeIsiDgydyZq83rpJB4h3rPbeZvqcoXFmRrPj/qErAy9IRw5hTTYxmXryY2Yj4eFE5/vg0CIKLE6w==
Received: from BLAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:36e::24)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Sun, 24 Aug
 2025 08:44:37 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::8a) by BLAPR05CA0019.outlook.office365.com
 (2603:10b6:208:36e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Sun,
 24 Aug 2025 08:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:44:16 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next V4 3/5] devlink: Introduce burst period for health reporter
Date: Sun, 24 Aug 2025 11:43:52 +0300
Message-ID: <20250824084354.533182-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
References: <20250824084354.533182-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 486bfefc-989b-425e-79a0-08dde2ea754c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgHnnW9F2zuaK240Hyd50G2COqqY/IREfwhfk9nboSJZvCp9O3PA2kH/iKRA?=
 =?us-ascii?Q?cMlve4W7hsAsijClmL3RVCaLUcJDv7tskb73jK8jPN7B6hVTU6cEupDXgxYG?=
 =?us-ascii?Q?EWOjxZekv2Pa2LQRRZiWFbhlPCM4MDXrPWnhJClfcelAqOq/zzovc0UhEltF?=
 =?us-ascii?Q?QxAbq8DrRTiXv21t2pfE1+3AFhx8duQUwKqJxMOypBgRTgtIJDu1u+0mTiN0?=
 =?us-ascii?Q?mOJPtT1TDU3lxQMioLYnXtzJymKlVuk8okX21DXJu1GSWO7x+6gkqTrOSelb?=
 =?us-ascii?Q?ngUVbiKBfDlS/IIk0UnCUgreiC7kbQfXs12EPgqMgVe2itxmaiyzI+KHHPaF?=
 =?us-ascii?Q?RNA1288CVVUkOPJ+9Yq8d3A50vnjH2ItYJSJPDAlQWYxa70s6AOFheuQnvWn?=
 =?us-ascii?Q?ssUTYgfXkv1pahYv85O4AnwzdEDZwQYKSX5pvl/cCcEi34ga9nK6ewbjHwvd?=
 =?us-ascii?Q?hF3YCMWOD+bxZp8aGosMn4wH0dQ8cjKjExGrtt/S8feUIbK0xD/74kovj/Ik?=
 =?us-ascii?Q?VOfTOYYbYO1ndyaY+gY+R0SARM2JjdGSAbtd9Ne2rEIFXPc/YJUVRIxKqmkP?=
 =?us-ascii?Q?3IiYfpyDzPEpndmpuIDJneEe9gVXBSmv/4fhUaZZx1EJXk0uLo6pR9PRTXBt?=
 =?us-ascii?Q?+fOQoPrNFPQogc1aey5BY8QVyIqRVccly3fuOQ5y+aAhW0A+Ros/6PTpitAS?=
 =?us-ascii?Q?pGtzgFaZW8RLNACFB0ny5cg8F/hz38ITRP+6+kBKFf1zIpGNefoN+6dUUxqJ?=
 =?us-ascii?Q?BZZlZnLz6usEmkuj/KHyK3aDN5n/RrsTR2nQ2zdMB5DqCBsyVZq1+XRFoMwL?=
 =?us-ascii?Q?K+cuRbpG3bBpxMQFRx4G4tCH5Vx7bt534cpIEk2OfDJVVNqPln/jitpXhnI/?=
 =?us-ascii?Q?osn96qxCQgW3c94EJdbiKprd6gjq53mg60NiL9bsNB4Dszv83LLhgHpFfCB/?=
 =?us-ascii?Q?rJTzR8+CamYT2UuzYs5i/Jxaiy6jTdY3nLZSUogJbe9iZmGiqmXni3EGtl4U?=
 =?us-ascii?Q?G6Mv3bhaCBx3VHm7LauYcF5N544ok66sTtlsFZB6lUYj/ScqvEYRSrKBXJR4?=
 =?us-ascii?Q?cuclJS0iyLdtutF6i9mkSG+lIjSGX/FGNFmkPWxdJCqikTsVoRO26FX6z1mg?=
 =?us-ascii?Q?CzxD8wd+msK5ceHaClGll8QNnWWOL6SAuQGrVExJnkyFX2oJbG+U7H0FNLXO?=
 =?us-ascii?Q?q411RbV88xUI/YBjJXsawaA0sVyZ5xVsnnmkWqJx3OJK1hIC5YmL+bNowVAO?=
 =?us-ascii?Q?Kg582tkvOBNqD4YlTuYt/xqSQWlu+Iv8gUKXT64TMsyOkdsvvMhXEX/tHBsr?=
 =?us-ascii?Q?OjewbCkZQZOAddmj1HTgD77Gio7Lax0x5vcDTTlWaQqDtW0eUfM2Ksm0YxMt?=
 =?us-ascii?Q?Ii74qOlJpXxH5ACY54HYHWggxNFiTArdLeOYd1G4KwkZnYSvm+yvuR3iyGOp?=
 =?us-ascii?Q?fl19F8kHQ2aGd/9gyu6EpJViQ0+GvH73IEOQkenbn/9qiGVDqEJBWktdE3xV?=
 =?us-ascii?Q?ns+oy2aADUWj40NIiuo8EbFMJJzY1XSrnJ9z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:37.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486bfefc-989b-425e-79a0-08dde2ea754c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

From: Shahar Shitrit <shshitrit@nvidia.com>

Currently, the devlink health reporter starts the grace period
immediately after handling an error, blocking any further recoveries
until it finished.

However, when a single root cause triggers multiple errors in a short
time frame, it is desirable to treat them as a bulk of errors and to
allow their recoveries, avoiding premature blocking of subsequent
related errors, and reducing the risk of inconsistent or incomplete
error handling.

To address this, introduce a configurable burst period for devlink
health reporter. Start this period when the first error is handled,
and allow recovery attempts for reported errors during this window.
Once burst period expires, begin the grace period to block further
recoveries until it concludes.

Timeline summary:

----|--------|------------------------------/----------------------/--
error is  error is       burst period           grace period
reported  recovered  (recoveries allowed)    (recoveries blocked)

For calculating the burst period duration, use the same
last_recovery_ts as the grace period. Update it on recovery only
when the burst period is inactive (either disabled or at the
first error).

This patch implements the framework for the burst period and
effectively sets its value to 0 at reporter creation, so the current
behavior remains unchanged, which ensures backward compatibility.

A downstream patch will make the burst period configurable.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/devlink.h |  3 +++
 net/devlink/health.c  | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index c7ad7a981b39..5f44e702c25c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -748,6 +748,8 @@ enum devlink_health_reporter_state {
  * @test: callback to trigger a test event
  * @default_graceful_period: default min time (in msec)
  *	between recovery attempts
+ * @default_burst_period: default time (in msec) for
+ *	error recoveries before starting the grace period
  */
 
 struct devlink_health_reporter_ops {
@@ -763,6 +765,7 @@ struct devlink_health_reporter_ops {
 	int (*test)(struct devlink_health_reporter *reporter,
 		    struct netlink_ext_ack *extack);
 	u64 default_graceful_period;
+	u64 default_burst_period;
 };
 
 /**
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 9d0d4a9face7..94ab77f77add 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -60,6 +60,7 @@ struct devlink_health_reporter {
 	struct devlink_port *devlink_port;
 	struct devlink_fmsg *dump_fmsg;
 	u64 graceful_period;
+	u64 burst_period;
 	bool auto_recover;
 	bool auto_dump;
 	u8 health_state;
@@ -123,6 +124,7 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->ops = ops;
 	reporter->devlink = devlink;
 	reporter->graceful_period = ops->default_graceful_period;
+	reporter->burst_period = ops->default_burst_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
 	return reporter;
@@ -508,11 +510,25 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
+static bool
+devlink_health_reporter_in_burst(struct devlink_health_reporter *reporter)
+{
+	unsigned long burst_threshold = reporter->last_recovery_ts +
+		msecs_to_jiffies(reporter->burst_period);
+
+	return time_is_after_jiffies(burst_threshold);
+}
+
 void
 devlink_health_reporter_recovery_done(struct devlink_health_reporter *reporter)
 {
 	reporter->recovery_count++;
-	reporter->last_recovery_ts = jiffies;
+	if (!devlink_health_reporter_in_burst(reporter))
+		/* When burst period is set, last_recovery_ts marks the first
+		 * recovery within the burst period, not necessarily the last
+		 * one.
+		 */
+		reporter->last_recovery_ts = jiffies;
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_recovery_done);
 
@@ -599,7 +615,11 @@ devlink_health_recover_abort(struct devlink_health_reporter *reporter,
 	if (prev_state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY)
 		return true;
 
+	if (devlink_health_reporter_in_burst(reporter))
+		return false;
+
 	recover_ts_threshold = reporter->last_recovery_ts +
+		msecs_to_jiffies(reporter->burst_period) +
 		msecs_to_jiffies(reporter->graceful_period);
 	if (reporter->last_recovery_ts && reporter->recovery_count &&
 	    time_is_after_jiffies(recover_ts_threshold))
-- 
2.34.1


