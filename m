Return-Path: <netdev+bounces-202458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4451AEE025
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CDE16F0A3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201524466A;
	Mon, 30 Jun 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DI9AXk5z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243E28C031
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292510; cv=fail; b=V8b2vM6/0EkylqI/3rBgpWnFFE5F5Mf3jnEW13S3Dn+Qnx2mXD4K6fDOuLqLMjIDINdfZicvEPfVz/RzqXLYXo4WZ8jT/ngUdLRAy3e8WEj0MOhR9YiO4aRgYJeeiVgS3xBX24pUvo8cLA+DuppLuSS9KEelJF/NXp7jEYXmL1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292510; c=relaxed/simple;
	bh=kqrb6inR64fiBK+Jb6xs8/UaM41PqtUYJuAw90AN/0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QeH7e15YdAWy+qJPHKndxQ1tV8gBLVQd2Il4lyiD/7JUKnNS7DuF96urkcft6LNFqDoQ8E1pR8RLvZbov6V/m+F0BW3p9Byanjt5v6e36hc41gTh773vK2UBO3wPnh+bxMyPRnQY8eV2boIZ54U1OAyyqjOGyR8jw9J5GZdpIrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DI9AXk5z; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFpcq89iagBBLHvc4CRqQNewc6TZU20cNjZgE0hjlMJ1OaHfRNWv/EZVqEG+iSdagAul4/XfwkGXepZvJSoPytJTpxYnMQ7kRyeP5DYIVRUANcAgLmEihncwLoJjeHNPz0EneTM7c9pJQRJ6ll+tnxIG+UEK/9h6fEvMsPrBGRUvMh0G9hx61oJB8YVD7i8GxPmP8aDhqnqLges2+aA9goxHc7xNSoKV3+4iH2QLc43SE4qwC0pIZ7rMrogDLEjp0Ez3lxNwyuGP5jR+60HhM3qtb53x4yGmu+xJZ2T4Rgc+MadcsU27N8q7wSHvxC/4coej+BdkepgDios7zjvNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYWo2Bb7IkmsPC4dilQyIcRrxSjM9zcD/lFDasC6F1M=;
 b=INdztUniGst8UaGUErjKG7GfCIMvu3ng0zzuTUipuiwNKbVDv/MNUxNkGv+S5wmtQoUt4qmTTPTCb2ScKffVk8wKFfEksZ8jhGNYJTf144BW1yieTAKaH7LbdeTan86IoG6xyB4g77gFrYA6+2wE4Ylq+wK6A8W+xzZpgoc+Mox+P1N5Jv0xlHpHzICy5+Qm66GkNqagkwAmRjUn0xw8RYSLyywvOveOvMdzA1G6olRUZ46SI6gOC9Sk+Mk7iRYXghrYtp4ZwOIPP3gr4C7K1ZVlCGn3qII81JrlbB4l9o88NI1j55cbDSO30/ffz/uxNbQEQQvQUb/u5jwykQ7cfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYWo2Bb7IkmsPC4dilQyIcRrxSjM9zcD/lFDasC6F1M=;
 b=DI9AXk5zdT8ZgCrlnhq3TqbuWmktM8olZ9p8EjtKuCisGBXZpVv+OPJRNjDiuKyonsdiuhxB14XIDUYs5GGBwp3C0Nn40NdmgRoCDrvY9DkX9EK8D05r6I+Ra3YM82umHFerb18wkHhlZOW/PlxxJCaxhzhWLIkX8NxSuqnqGgiGWdod++y3yYPyDUxInAgb/D1m4XYKg5B2l3csghnG5ih7f55sVPPBxzA99ZcLH8Ggq9Rxzm0sd5nhPZrpulYoScQ9mMmvFkDzJWPEvaQ5ed0dLf1aar3Klv4iVJwya/wJN4aCnrlcumo1vCSwi8AB/j2HL00ZXLBTGopfwrSLzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:26 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:25 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Mon, 30 Jun 2025 14:07:25 +0000
Message-Id: <20250630140737.28662-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ea3df1-f4be-477e-870b-08ddb7df94b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7xVRv4sUfm7Bt2sR2WPNL7ZmXr5AeSlQivTSNg5ID4ERUtZ31EDExB+wJH2p?=
 =?us-ascii?Q?IsojEFIF37HIsgY623bOoBOtI57OC1kBgZQpS2c6s429aep+/tUZxg/WZiXT?=
 =?us-ascii?Q?3HNjoxKkKs9DC18mZK+NnXzlDDwor0306uJ306Ane6HE/vcPsc6qDbE2G5Mo?=
 =?us-ascii?Q?M3iI8IRLN6HOsCu9ovd8MMP9Ej9VFonaqc8gYRKW1FvXzcRetXqvBjTSV+FB?=
 =?us-ascii?Q?Lg9EAc7L6P1bxGKFQC4FkMRipcHnYOjwL1aoRxef2468y0W/WXbmu/Yv7DSB?=
 =?us-ascii?Q?T17rcVnGbyEJ/q0BXga+eUF8Rea8bTbZjKEF27qMXXSZLinQyaM31CVYG40n?=
 =?us-ascii?Q?L27BB35lBOxqaLR/DIXV8RyCzsd+XkbN3XoHLlco1bpmcTny4dsTECMr/Z4t?=
 =?us-ascii?Q?UKn3pnCxnvEotn3ESi7diml6ZDql9qiW+/AZjIwSPfwRCigoukpqLyOdcqvM?=
 =?us-ascii?Q?fMHErucA4p5su21gCvrrl1qdvKdBTEuWqzS8YuqMD73ZxAZrrZq6GynZiP6x?=
 =?us-ascii?Q?4QY5eNnMw6mgiNRaZRVP/Z4/+acD7Z4oiE8stE3ywwxPzNotpI4CbaDK06gz?=
 =?us-ascii?Q?6J3SzcwRmVSgU/CXr6cZMQVMZQDIDbzvL72b6gAExfDSkth7I3EuKOhuWMUj?=
 =?us-ascii?Q?LenNAeZLn4lq+n9zj32nbnLxrENJm76/kdM9rMWYaFzQryBDIvpH5jQIQ9d2?=
 =?us-ascii?Q?ko0eleZ4Wush0jLFQjjcX/T430QtkYKtKNwCRpnWkaVk2I/xgM8OQR6NgBcw?=
 =?us-ascii?Q?YSo3OntQ6iQRWzLP9shTFWFzoe3LDB4YcAENJkWc7sSfq6gL9YTLnKCMe/0F?=
 =?us-ascii?Q?/ZOUjCymvkwLzjqFqep07AYrjDHEgmGlhjiDf2ITf7uzGiPpyVFZ/l/pZFFE?=
 =?us-ascii?Q?nUicmMt9r96JNboWbAmc+49/xKs9CjqqwHhNz0rqab+9Hc+067sAAOEsG8Z6?=
 =?us-ascii?Q?NNXwnNPHlqoVZd1n0KErb7qzmiyHdPUhQvbSCtbEyJZjrZ4/U8+UkBUCpjeg?=
 =?us-ascii?Q?SkIgyBAsRR/KcoAkHR+Gs67VeMPEa7ySTJ0ELQ7mrVpTdlDk4BvTzw1W1G5Z?=
 =?us-ascii?Q?vtSiSfAhWo1W1BZVu5BjMTifMO4lUaGYwn3jiXuvVHUQgCNZcIrt8jKpUhQM?=
 =?us-ascii?Q?szEBHSLDevY98q2+8gINWSIszbqV7TqJRM5lsmFTXpG81dXo86lGHNAvn4q6?=
 =?us-ascii?Q?vsMI7ROklDe7TMV3GAMqUyzdibJUakFMRykmhrDa4pYszzqEXF67GA8AZey+?=
 =?us-ascii?Q?0sCSoCOjWK3SocTePpb92+JU5ubkkDyoKpgeaSSmxywtVqBpq9cESi21eeIb?=
 =?us-ascii?Q?WIoHU2a1mt+V53GVkwt7m4BJ5wbha4tz+N8SM9JpKJ917/Lu8Sd6f5QKlNpa?=
 =?us-ascii?Q?mhhI8ppVm+rhfTA0qwjc6Lzu+9d2s6QNh6i8iAOKo+wVOt7b+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGjCNbFpNf6LUDVyo/iE7ijno5JaqbeAtuJXbMbu7O3EgWYE8Uczv0sZ2uVZ?=
 =?us-ascii?Q?X4t6AT2A2x2aJTTdJRv1jl5oBf5XnpMBijalvZgABSzAMWcEM1cpfBmsX/vW?=
 =?us-ascii?Q?8pKEOwlZvqKmc27Z1ZdHhjXvMQNT4qV+/WaaywCClNL26VuJo2XYLLVYPAP7?=
 =?us-ascii?Q?7VCe3xiItJ75UReW2sgun8rMGulOig9+iFm/NzZ99+rmYAdubZijTh9p7DkC?=
 =?us-ascii?Q?ZRxHdSLvobYYXJgnI3h4pUBgsReGzZ39CyvOA9TIl5IyUe0jD+2naUI04RRa?=
 =?us-ascii?Q?uwbgnpVuBhagSx98QV+mXxND0xqojo3nIEiTV8GrZfRh7YzkUan7APLhIVmZ?=
 =?us-ascii?Q?RuFdj54ifVhlaVa8NZjORrtL9WeWuQ5ox2hM0JtOk8nvOXTZzVGmZxLulYI1?=
 =?us-ascii?Q?05POI5OLrBpY4pZ1s3wHrsqdgWnTcczeOWPqxiIvdGNsNeuBGXOgeDCtT663?=
 =?us-ascii?Q?DoYeSvytQm/37gnQ+VBzt/2Yx+za+IMAqKWqYJEMWgfnSkZ+Ok8ynCerqN0z?=
 =?us-ascii?Q?FkPvVx33Xk1UxrgP/cEf0B2nVKWxGRquMUWOQZsPSVqUShvdqYzufmv2OfIS?=
 =?us-ascii?Q?Y8x8CuFkAsM44pQ2YnNKrxKlHeiZ6qMTYvkzOGTJ/NBjvq+BuCvgqrmP9h1X?=
 =?us-ascii?Q?AdGxnX0pQxne9El86qXk92l3m2b0jMSsp0l9Lhx9GRixH8j2ggnun7IgCIUc?=
 =?us-ascii?Q?iew8TgVIO1uokObFx0B1TjbZNYPBCPlS89FzJy8Jw+EUOqpxqBPLtvT2RtQd?=
 =?us-ascii?Q?KdY/abjOYxQ9V+cwf+GtvK+nPCggO8A26zvHHDwKAvZ5CkFHWuYwpu2/V4VO?=
 =?us-ascii?Q?c4pV8OVwWnlN8OsASZGwQdI+pcU3QEz/0ibFKpjOLIQQG/xA0GS5NOHM3Oo8?=
 =?us-ascii?Q?NOiG5M4t9/vlzLCBRycLSu/b4zEbTZe+8JgYzYDccpkvwqOhZKNpyBTUi1Il?=
 =?us-ascii?Q?mr+ii8A/MWYuFBr7pZMe3ZOfrdY5OrcA4aa8eQeTejfoP7Bpgw19pDrVBlhp?=
 =?us-ascii?Q?DowT5tgoY74LgFc6ecnoJri9F+4sIkV64oPJXYtx+GuYuWvBFNlzPQqQ/FRb?=
 =?us-ascii?Q?zjudQXQCdY3uvNkLVA5n+qzwy02ntp8PhPO5xC12C1eMplWmcvdMrRWZqIhD?=
 =?us-ascii?Q?kodd8xR7DNwwTk89Hj60oQqtHJtXDAFigTF215YYozsZo70VBHxss/Joyg3j?=
 =?us-ascii?Q?jWF7emv1cZgW33HbwsQvB9hOENx8rv/Wz0l9EWqhi3JYBzN+J1n7P5lZxLuu?=
 =?us-ascii?Q?EeIvBwEr/ue7C4DeGor/M0RHxqs0nsgLy9V2eJehssgestFOqilu1OeKDIRC?=
 =?us-ascii?Q?zICkr049okrMgULjuLSCEbEW2wibozCZxeThIEkCkBGMno2HpbZtvBe+R6rj?=
 =?us-ascii?Q?mit2J5bA8lOsFTyrPKf+3wEqclrYYky0FbTNxsQakeEGgn6q42rwuHNQ4bQg?=
 =?us-ascii?Q?IYsLG5OnwqVSkDuwXSso1B7G+1tGdnlZB3UWts9CzVj0GtJzDK/5Ge5ouXaD?=
 =?us-ascii?Q?7e8yb/Au15DJ8Exw+n71Ut/j/3t1i5WNd98xVtQGh1DSjsMf8GQIIR+cjtKY?=
 =?us-ascii?Q?U9JTIKQ15lwPmcin/UQ78hZBm0Ay83jmK0bLqL9w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ea3df1-f4be-477e-870b-08ddb7df94b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:25.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8+wx5MMEikGImCo55vdcR0Aei9yeQd1iSiZifLE8zM6bupSkWlysnAhWMNQr/rnn60t0ifuslcUqhsnKXiFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

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
index efea6d782d8a..f9ac575e1b66 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -246,6 +246,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3463,6 +3464,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3480,6 +3507,7 @@ static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3499,9 +3527,19 @@ static int __init nvme_tcp_init_module(void)
 
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
@@ -3509,6 +3547,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


