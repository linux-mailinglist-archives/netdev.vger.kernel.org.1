Return-Path: <netdev+bounces-168446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5CA3F10A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A5D188307F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45382046AD;
	Fri, 21 Feb 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOt5NTnP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E222045B7
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131609; cv=fail; b=Wg94b5feOx12kDk2t3JUQovF8Z347PKTnli7xSoZK3eL+esJk1D1aRFl+mjxGzDWw7+JWtTH4sXvkBqBzcTTfJWTfaqWzXL9a8fyAhsms+kg3pQ+NHiWwllWE6A3FZnVKiBVecKqS1pKON7PeX+r2MY3m9/qZtlw7EeuNQeIwuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131609; c=relaxed/simple;
	bh=rtcvkR9TtdGsjHyURQVRKAgnT61TAQrP+gMa4jvyqKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmU+lqHV+biXnCvvtkXsF0gQHm7OJ41sPsQ0xktYfHkbAs6AJnWrV9nrmMTfFKyzPZ4ObARt53NtJzOeaBC/PLuYF3hDcrLy42XG9ZKS/UmfLEZen3LCmZ9zoniUm8GS487238qomFHMZP2/JBlQCgn+lyOvJ0bDC3sX8Kl3pfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZOt5NTnP; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWAoxyQmHKm57CtSpfptPGiGIcx65WDQ7I/3UqmeVTGItTpwbAskL0Mi2dB2jUE0XdEc6U/g/hNr5TfDReK2a/Cc2P/CmeyY2LemYIRA49D6YvKGQcLryqsZRYI3JByysqwSf8ZPDYBSj5y2xdLsrVkcRoAHiLtiGnszlYYsboBhPNs10cStXNuyIW8rblSLQEDYOreJLKK69CInhu4/aLz4qE5YRiQmxjTSQAusT5v8L9ed7Vv0d98X4UpxOchFqh7BNjxKi+QaDusr7Ct9TzthSYIcgSX8MrjRMKsq1e/t9ZesZNdI3JcS+PKwkv9wdiUtDzG6MlCF/Gmt+6WYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN8dnHMQPEq/FxY4oWOxWXuzFQFcMqed7SpNBjxjesg=;
 b=g27V+3ZsAfa3OIaYjFxBZho1kuLWupYAD5tFXyI7Navagw/OMoekUiv+dgpB3U1tHeExkOcuoKcYwdhGWkRA+91VOJ2t2y9RhCWyil5gxZsbZZrTrYegJyb3x12B+maoVOCuR7+iFT6qyPwwqAJnXUiNYaBJ+iqYWhn6bqR6wsYodoU74mKBO4kRODdvsEZh2KyJz+yCadGuBf+ymaPfsR3UviPBEW3Se7HGvScPNU4uKrmEgg5pD0IyxFhkZaVkcJfAhbhzrbg4mqxqCRPAio0dCzE6opldUQOCAGS/ljDdPKuy+dO679rMf8scHim+2JqKKW5nhvw8E1NFGGIkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN8dnHMQPEq/FxY4oWOxWXuzFQFcMqed7SpNBjxjesg=;
 b=ZOt5NTnPxzS9/Nc8HXzI9boflnTii2RfkQzywzjSarG0XCVZw+uF8eSvONLQTkDV4defjETmaGu1dEiJpYcEo8cQCUoIUO6MLJvk6Y2S488p+tH+J8FWs7KRZUVNksmOLL4clTCnzjYpDJOPCbz+U2VGH2TDObs8i/83hIa0kTYM0Vj9AAx1tXoNATMfwaH9DFiD/a/eR8spLNWJeUrMfruwQ1FFHEAB/Y3DHQKbmowwYVKOJGZUTb4yJ3Gy4RveuZ4HI/oDdR+FIUdCRZTPgGHMOR6EcVKN++d5RqNIp9c5t7T9LfGzd4Ez+a0qAVYRkbh+VJbQla7nJ+RZPeMvtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:25 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:25 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Fri, 21 Feb 2025 09:52:13 +0000
Message-Id: <20250221095225.2159-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e4774a-e613-4b47-fddc-08dd525d9598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80A6R0uY9S/YLbwQKg+KNVZH8j8hzcKJwCGmU9zdfAvVfynV2veDl/w4l1Xo?=
 =?us-ascii?Q?OAuc37g/xCk5O/DkPVbpdkci1SzAowgJvTdCHhKK5qN5/RHgTWv6NFtiSrOj?=
 =?us-ascii?Q?x+x8L09i0oSXBFKvVkePF+KbgjC54wd7cgFdR+tp/XyxHqbmUc/tI0ZIiyDB?=
 =?us-ascii?Q?aISs67FIsaj8JmiMZbQWhfddByOPbFCVjjhIk070egh9sHnFGNfVLltL6Fj8?=
 =?us-ascii?Q?bgBsNDVZg1+Ine867orQM1jJodjKt5ENf657nVQT0s1uQNm5DTeDnSNMvHup?=
 =?us-ascii?Q?WdWgdrbXPrbskhtxxE/wBhJI6EXglfpxKng8GncsLcMSJa6Yv88gjOTg1ypz?=
 =?us-ascii?Q?zkBsXNOPOhX9hE72Kkz7GjW7mOhyvXbW19qmR8v6amJs9xyzJANkm/9Oscwx?=
 =?us-ascii?Q?jISRQ40v4DbYz2q8UOjerqFLArUi70/IPdADEfLZA1ZmxIDGMVDghFt4bKWc?=
 =?us-ascii?Q?By28bdyZGlsBNW42NJAxLrSDVvz2lBw6D5bxWf//WfOiUPg+2Ui4i4DegB4o?=
 =?us-ascii?Q?nGqX81GDIiCDYWEW/0BE2ZVevg8GY6pq0+0Y3B3+RQhIzO6eqsd45q4N9O4S?=
 =?us-ascii?Q?j4yH+e2t0d/RUp5mLxe7o5umNeYuoOSmO0Qgqs2GY38VwojxAp47BGVHQFOi?=
 =?us-ascii?Q?nlZocvq3OM49m2biRucvZNNG4xPSOSw9lHo2vX8WD7ueK2XU21Lir1sdgkrH?=
 =?us-ascii?Q?ZAm77D6mBmMK/VHgZlANBA48NrcnJSJ4EBJ7qODrlDmmPzcR2xwlQqJKNI1c?=
 =?us-ascii?Q?l4KfVefOGoKnYNUZvAJgdFMD3alpsDrF6Hgt2oU1xaMsTrPyF4XAKui/PxnG?=
 =?us-ascii?Q?lmJiOgfwZW7N+k6RAJHUfZmzh6kSor9U1ufxzLeWn+uK9sm9ycgje/ijd70h?=
 =?us-ascii?Q?CI9KsaFCl66NQxsIRecqVS76wNY5UHDiOlpTxs6DKIG07KHvBlZqSPxHfE1q?=
 =?us-ascii?Q?tJgp0MCqHnGjDIWpDQONAprz76LR/kAWBWccQY+YHJKx0dKpDh1IA7bqBtlK?=
 =?us-ascii?Q?oNKu7XpEO0LWxalU7stwef3mrn7oSSRjdfIQZRS7En5W6sS/jLHtigGCLlMr?=
 =?us-ascii?Q?RE5uOvxcgBGKzJphOCA5pLZRWL/3FjmD6qCT7adAwuOFDJTcRFTNhO20y1jF?=
 =?us-ascii?Q?ywBADxQr4HoFsXp+pBezWltLvgKmcFp5Jx+JRYl0jS3WCFLfNzZZNhbyl6f0?=
 =?us-ascii?Q?vWr24nTsVKyvkcH7kzNQPX7HrkqCoFDEXEW2bOII9fVyE5Td21cQXVP05aNC?=
 =?us-ascii?Q?/3M/qBVsy0D7DxHjZ3glIpW8yAJ+6JdFdL+puHBBa9fiZLsQ0dYt4zkoc721?=
 =?us-ascii?Q?zo9U0Qa4V92FIjIEeJN49mlty6pih/A/k9AtvH7n8TPer9w0G3mDGTm/liwy?=
 =?us-ascii?Q?mb+rLk7FyHnPI60LiYIiNm0jTLwS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BS5lVf0Fq9R/V4S7anXVgPbCWb8O/WVHetaUM4OzCKY5UM+oPZpPX8rBAC8K?=
 =?us-ascii?Q?F1e3j3VpjB2YqgCWDAdLNwi0YlsRAdRIF3oqQCz7yhWZlmZiH3V2QcmCCDHM?=
 =?us-ascii?Q?7SN0d5pUCqaQVZRm93nzGO1zMFvG8Tev1tDppcA0/dwidUlfIvWJrCKPpIt4?=
 =?us-ascii?Q?eyzHta7hPOfNYQdsYN4sX6BSaZN/DzSt70Ugyq5ZncVG2phwJw20ksWGHZj1?=
 =?us-ascii?Q?HAYkzCaNq82TRAA3tgqhdzxNn6Fsd2qa59ZR3sSxOn9NaJ2yq/uaKPnGgEaV?=
 =?us-ascii?Q?NsUZtnXdMZSHS2pVrhx2k5HXvUwYZ2O3EsgEEFHBk05MYO0I8cmoJdsO4FvB?=
 =?us-ascii?Q?Ylnftmkdm/6ReciIH9N4gj0WWMm/G0T7gCH9HeXcJQPXQSMu3lI/kGoWULG8?=
 =?us-ascii?Q?/aY9d11O6wpS6OeppPdhUTRafQPdzKQzJDCIppJbi0Mnt4yutpoDqhlBoMBf?=
 =?us-ascii?Q?qGvpAcRxn4Cge/7XSr1PeEB//0bofsiObRFdQ9/oQdG0dC700cxMd98eVl/m?=
 =?us-ascii?Q?0RF42D89RaexsGLVF6YUCUqxbggltrRINu7TwkG7j+/Z04zsjnMJMsyvLEI8?=
 =?us-ascii?Q?KgFwEcDj6TWyI+v/kyS4zxeznajMQs5s+wLg9HfDMwLsrJIfWM95Wdq/2iz9?=
 =?us-ascii?Q?uGE8wVnCQHcvXSpAt5yvGinVL/MNLem3ukRVL5+8nDdWzFKsuaBS0ecC/oIT?=
 =?us-ascii?Q?TIysgLvozOeYmQARQ7nnmYEFANp5ngAU+OkfM57XzUzjFC7JzCmEzG40460I?=
 =?us-ascii?Q?/s5YdqP8E26fgSPHw9xcG2TExn3I2ZwcWbbUlQqvDMIlDMzbwy7C11ZoKu7C?=
 =?us-ascii?Q?0VpmenPAe/IpyhJ43+q1RgbJDRPxGUFNyvcTGEjSZwpaAm/no9+v/SqHMnXh?=
 =?us-ascii?Q?M5swyNz8sAdTiAglbvoGYj8FYfTWO8ntTg3lm03otvck1JRi23W+6ltZUa/u?=
 =?us-ascii?Q?EszIx2SmPNUkI/OFKBBZf6/28BjcpIqJD7JA7UikLbsriDk1ysqC3ENbrO8T?=
 =?us-ascii?Q?3HQPD+2PhF4OnWmFtc3a+sceaFnkM+x5SYwddmhl9avl732X9Z4qsfy2X2Ff?=
 =?us-ascii?Q?jVq8fb1SsYVdGbozDlsojkbFzvNVPh7kL/0P0Wf8D2wMobQxAp5LhfrXNL0G?=
 =?us-ascii?Q?ZoqX5HOReEXM4DAVBO7QBWrnMEVTPyL47xuWKCd5G7S50dtEBspoj+P9e1l8?=
 =?us-ascii?Q?mgdN+VRkfolAq1uANOstf9BQZKKUkWoZ8K8EfVvEJkxXlXuxQNi/F6b8AM+q?=
 =?us-ascii?Q?9e8hUEUbiZ4xjFKmqstbatRpe4BiJDHHShx6pqpz4ED7of3sBgJbH6ytYRSF?=
 =?us-ascii?Q?9E7BQxSPZXmiFUB6jC//GA6+2CNeaZACDDhxvZWW87pl/nBCeG7/tXKrMrR2?=
 =?us-ascii?Q?MYHKU69kjb1LmGj1Utm1qgAv6Xz3x16kw5CxvD4ds0yGY1lEhyzFVqJSYtOQ?=
 =?us-ascii?Q?u/xYdWpWuplQ/capwVikPXQZZ19En8oFV6yWQWp5c4kNs21dvDXBjmq9CvPB?=
 =?us-ascii?Q?Pa0mnj9gxV2wDzreDeJQlp80GFk+zkCbD5FqtgZIsAobYqPr8I8zgeevjogn?=
 =?us-ascii?Q?dKaRJeK9WrVFeylpqcUSxCTvqFkE7ssCygFnMK8O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e4774a-e613-4b47-fddc-08dd525d9598
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:25.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+DRLd0pktmm3YjNmNO7EkKChpd9voT4un+6HHzKbETOwcNW/WWH4tok9IoW0z3PYH4zMoxOSnZ6Y/GfidFBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Or Gerlitz <ogerlitz@nvidia.com>

For ddp setup/teardown and resync, the offloading logic
uses HW resources at the NIC driver such as SQ and CQ.

These resources are destroyed when the netdevice does down
and hence we must stop using them before the NIC driver
destroys them.

Use netdevice notifier for that matter -- offloaded connections
are stopped before the stack continues to call the NIC driver
close ndo.

We use the existing recovery flow which has the advantage
of resuming the offload once the connection is re-set.

This also buys us proper handling for the UNREGISTER event
b/c our offloading starts in the UP state, and down is always
there between up to unregister.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3037c6480f56..600e225e38f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -246,6 +246,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3323,6 +3324,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+#ifdef CONFIG_ULP_DDP
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	if (event != NETDEV_GOING_DOWN)
+		return NOTIFY_DONE;
+
+	mutex_lock(&nvme_tcp_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+		if (ndev == ctrl->ddp_netdev)
+			nvme_tcp_error_recovery(&ctrl->ctrl);
+	}
+	mutex_unlock(&nvme_tcp_ctrl_mutex);
+	flush_workqueue(nvme_reset_wq);
+	/*
+	 * The associated controllers teardown has completed,
+	 * ddp contexts were also torn down so we should be
+	 * safe to continue...
+	 */
+#endif
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3340,6 +3367,7 @@ static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3359,9 +3387,19 @@ static int __init nvme_tcp_init_module(void)
 
 	for_each_possible_cpu(cpu)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
+	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier\n");
+		goto out_free_workqueue;
+	}
 
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
+
+out_free_workqueue:
+	destroy_workqueue(nvme_tcp_wq);
+	return ret;
 }
 
 static void __exit nvme_tcp_cleanup_module(void)
@@ -3369,6 +3407,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


