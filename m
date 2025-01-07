Return-Path: <netdev+bounces-155984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3AA04834
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9450162805
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E11F5415;
	Tue,  7 Jan 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ap6fAx1g"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786891F37CF;
	Tue,  7 Jan 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270873; cv=fail; b=BSpVyYiGV+vp2wWWSVcO+3kZEyWC3u1hzrdt3nZHV05qgIr52Ia4Kt1On4EnqvGcjbndmZHuBAVFtYENpVAwkpQrNZS+BvCjUypCQFwZ037BW8LI1F41oVLzN/D2BdAa8AInQYk7tB/Py+NtX9vq6yAJL3+yJZ9CZgaPzLPDahM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270873; c=relaxed/simple;
	bh=sbi5h06ZKvoz9tMj5xzMsCXeqaNgrcP7eWejvBJfPMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKE1jrzuPRoVoY/E5Xp+7GZx0B1BHMmjyLBndJOU2gzfmX7ebVTsQR0haHpHBZTaiKfWd1oap1Gb2gEBVQCyuSZShUXliVFIiu3FGIBMdcEqe6qgqXqlsfEvyT2A2VE6u1+D1Ft0QZn3JI2to2yGon1cWyewqtCSIJ1KleaTMkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ap6fAx1g; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZZHO6DAfCVV0Yq+UA+tB2aS3bX8wbga2gXC8nq7MW5dTiIhs4eLN9wswHwINGWC0u73e1JWyiRa0/G4kRYfO9ntN1ID2AAj6jHRgN9+kiIMgqPbe5PiNiMzCxT5Ob0PaO+MbP7GkF9ZgEELn54Auw+2ryjKHC7G/kRriDBqxkd7XFM7h9UWtTXjmLkOnhs/LtzTIbwQoRWYg4QnbQd93TzM5tyUvUwGw38M64Avpa3Wx3HnglS3LqRYXeFgWlxHdXBCmcAsi4tBuXh74tUM/r/1CcS10l5DAtykMeyJdkLl8YYrsc1nBnkREcxfVzRxqmbGxDJMW9+94f8kAy/Ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK4HQHGBMrRRuyOLhf74wHxX/DRPPBO2mIdzgK1mEVM=;
 b=MLaQEndtJt+qIbrnpoNXIw6xRXoYSaQF7jlUt/lJVnD1MFFel3ZX35o1CvTtPHN9xy+7w+MfFSRpMzXyka1XfFB20FqQg2WdN+y97QHM4YyseQE1YuAbIQjhR9BEDzDAMCGqV1oBmzDpTCZqiIgCpLKhkUkK2yb6Stp/DeeRhNdw7nNQaCf13czap9CJUm4PZkv2xyBL8/PeDU+EHisr5r+Z5wsgdnno2CA0YrSKpUT/Za4dHgxCZF+T91DV1/ZfpUqUdxAPSYMExUjaQkF+vFIH4tlNnHEx/LbtNmJcjZuSyfIam6SXiL+ID6LGW0XNljm/MtsQLfTyH3+/j2W+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK4HQHGBMrRRuyOLhf74wHxX/DRPPBO2mIdzgK1mEVM=;
 b=ap6fAx1gjEb5pVvTtlpfviWVsurWiGsYlI78QELyvnByszeX7xkxZ9gIhmFXjMNduPcT/FJkTOFGcAnNrv2xMuOu00Sg2Au8lfOTWx/xcYqLczk4IHOW++0FJqFtraCDDfLcqPcbHElS3OhMP3ppwd1o9krn6SKb+wWoE5qbjSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW6PR01MB8344.prod.exchangelabs.com (2603:10b6:303:23a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.9; Tue, 7 Jan 2025 17:27:43 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8335.011; Tue, 7 Jan 2025
 17:27:43 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v13 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue,  7 Jan 2025 12:27:33 -0500
Message-ID: <20250107172733.131901-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107172733.131901-1-admiyo@os.amperecomputing.com>
References: <20250107172733.131901-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW6PR01MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4cfd53-ed75-417b-ad68-08dd2f4097c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?simtpLzL44Lk5tS1Vuh7zin7JDVqTarONNtXyIJp1W0g5rDUou+WCTOEj6Vy?=
 =?us-ascii?Q?WNiEpev8IBE8o0eSz91u1FzK0iCk0sMOyvId6XsZIQWGnRAGNVlGQYNPhGCq?=
 =?us-ascii?Q?0lOcUQLKv3KtghKU14P2sj+MicZFkhKCqPT5rDgqlZNwIas8CFfn0ZOTifQb?=
 =?us-ascii?Q?wcdkmpsXGNcWnnUeMRnePoQsaijxhwaTsMw8E9OluXfJkDhV3UdYli7TLvsq?=
 =?us-ascii?Q?jQCEiKNz31HgUkJYondV51PopRmufrdGdaULjjMpOVpSkehfvl3x2Y9Iy4tF?=
 =?us-ascii?Q?XctP0llUXInZlU8XbKbPQTnHjLldj+4lAfqY1EDAxEIOV0t4zQGdFekEVw9e?=
 =?us-ascii?Q?OT62fmCNbmJYzQtRpJecaQ6qV97ducSb7OZmGcmoz1SjaO/JoQfWt8mj1ekW?=
 =?us-ascii?Q?QdzlZFLD1+JAlXyhjAbLYV+4XrNFVuPxj9WWVeCVZgS9fDovjQ/ScVzyTmfA?=
 =?us-ascii?Q?y8KbvUbPiItxR1RPPsdpc5TM3b4tZlqh/THHDtao4V8dKPfLEGWIkHuLPtIV?=
 =?us-ascii?Q?4gsSXBX+MUZnByemo6kjfxC8t0hJM+TWiQmKmgpCG8O4NS+wtLoedd2bNp6g?=
 =?us-ascii?Q?6IdB4upXLOAvJl877EQl0ZOdxTPkMhJrHb/2yL8V/AZDtaf+sVhElaFly+67?=
 =?us-ascii?Q?sZgqZulUcOBY/WSEK7ynlDky7201BEwuub2aeTsDJbRuJuVOkQbSdO/JdKmB?=
 =?us-ascii?Q?Lp/B0LD1o9EEdT0QpadERjiZXxctSJB7XP709i5Ve2o4FFxSyAJyzzwnAZII?=
 =?us-ascii?Q?GMxKjYrLoHMTgf5ZkgBlNFPtBW6TcWTLUrxkRu+N57AWp6QwFsx8ruAQR4FU?=
 =?us-ascii?Q?Nlou45t3Ilkw7wee8VYFskCubcsPIFKXo/8gha5HBxRkaap0n3exn2myD1ce?=
 =?us-ascii?Q?2J59gl+/3crgVDtlx+Fxr8o8WO61440tsVnP21zJ9qnzHdVstWCkPCtHJzzs?=
 =?us-ascii?Q?dXpZPGUXpgM6FbA0tpFIlAm3K8oJFcg5mu7CJIWGy4Rswo5F5IjqmV8YfhLP?=
 =?us-ascii?Q?TtdHgT+Nz9fS9dOKpp5hyAdYPyT20ps3yDYNseurPs2Aiuf6QEyKZTqvR734?=
 =?us-ascii?Q?94JA66E1kFbHpC3vJXKQ+3YYRi6HcuEAUkTA/rrKCAtOMTTEDnTmMdwOCRU0?=
 =?us-ascii?Q?TtQrZtmA/NdNMH8gAkfYDiHwJCE4BzJzo0t39FnTWstdkZmi7tzhTHHO55Ht?=
 =?us-ascii?Q?UGMaiw55wORfyfA3R4hHaUGcPbC8JYyo9h05meRa1BnvjezntrcVd7Ikg1h5?=
 =?us-ascii?Q?FYNH0K3ns9c7QA1uawGY2+S4oUEtP4MY4Jlioy9I1G56Zs7J5FZoJvMVlNM3?=
 =?us-ascii?Q?EmYSggStAK9QYXngSfVEdvLbEgi17BH7ltLbWIdbUbfSHVydd5Pw4OfM+aal?=
 =?us-ascii?Q?l3n14PEJqGyR0j4EMSgnNq+qPjiz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PaI5nSv6LJ4irRh/4lntFxtPBpCGEbucjgKsDZmGiQN9bg2V/Pn3pQaRFeI?=
 =?us-ascii?Q?Ary7K/IgZ1lqdA0sebfri8o10lrxiHvLSZO8c7oG+McuMRky2p0WJPnt6I7X?=
 =?us-ascii?Q?9b1Toy+ssUsYJuhlgQwLsdfEnxCBv1wPrfo1+594W6k8LoO3XsnZv3TP3tNf?=
 =?us-ascii?Q?uI14lMYg7jSNQ8n53DLQZeOHR3NJ2VAs5uAcekCNUYDPZxJ+SClg62/Brdcx?=
 =?us-ascii?Q?/QUI9kZCEohkPjaJWmWxvCMfksCdT4x87OeIauUvEv4Wd3DugTxPKFHYB45N?=
 =?us-ascii?Q?A3+jDac72BtqA9yhQBqqnWmri3QI6qngMmHRbLpkOF4J0H6uebptit38y0z8?=
 =?us-ascii?Q?t9sm0T7tBGE/8kwj/QbpZvchAOkp4oFkNAXNIESNJ9KAkeR2o+GKP6axY7Vh?=
 =?us-ascii?Q?Ts5P7qyR5aBVe3l9/Nh6Yawc+VVqPHbOBZi408gdqPZtAHXxD8gie0M1Rr06?=
 =?us-ascii?Q?wFYHhQPszIvJylJAtB1TnTJO/1e3gyKGFeeC1lp2hY6oNt9hO9k1NWJ1pkZP?=
 =?us-ascii?Q?8E34XJ0GwBG0LFSw5+AMdgaFBFpXtqTG5hKofYIz5uHR9Xsu+APY/WPB7jrQ?=
 =?us-ascii?Q?AHzs0C4eulfvfOsHnrupIFVJ7wIauCoGN8Z/jbZDKOqWRDapgao4UyeWMylT?=
 =?us-ascii?Q?+5elmBB38cLpMDd8uVoB7lHO6/A6uIidaO7rMX1CmDk9khuqE4mAg1kNVkWc?=
 =?us-ascii?Q?m2s70suq8rUeLkYI60rab06pKjm+PUyytAJDqAtrhsyF5j+rFtCgKDs7H1FI?=
 =?us-ascii?Q?QVPDLMsJ27bNg/c1IBgqpMx1iL17uEHk54/e2HJCjPtVQ3tvPjvxJQJ/rnlO?=
 =?us-ascii?Q?kiFZYdQGmPaXJfS6brhkwJ+1DrdOEP9ZDjm9IsNAgcH/GwRfDakr3htfEY9P?=
 =?us-ascii?Q?mXkYCljVVWpFahoqQHmfvJqGHn5dJ8uNuIOXDlsQ0UDX2YDsAy9LuBfrqeoU?=
 =?us-ascii?Q?LTaEHwMneBJlVzk1uuEEOfv31YccHgi90eiJRM1rELS8Ajw0Th7mupxLEe/3?=
 =?us-ascii?Q?xYVQrwLK6Szsk4K50bz044NVSuIS2344QR3/ed3PvacSrHhak95WhCg0/uKK?=
 =?us-ascii?Q?oEb6AjPwlvMwM73v53UU6T7Y6pHr6FHDyyhbAvh954XmziZjXWQUkT/SEeG+?=
 =?us-ascii?Q?fSHhKyRtiuuKMKxTekC7GXjoRREq+Gt/liDuPH9TmeOOwu/jHe3KqWy9hX/H?=
 =?us-ascii?Q?Yasr/ENTT1x8P/HxgpYgMkUWGXRBm+0VVGQ/XDlpyOXVZOSleZ26aj8jGzPz?=
 =?us-ascii?Q?7ov2Wj79ptRF7tW9esYz2P8ISp34mWyKhAL1TAiWYw4ksA2Je9WwThX2TPDx?=
 =?us-ascii?Q?FjebJrvgcWPbaj/8jDEFu/xuPIFhOHh54CzzfXywk6QWoY2aW2J/xx692G39?=
 =?us-ascii?Q?lRz+pwyPbQhW5sLHSp+B9TQC0KesClXKtbBIy7bY7HeWQxSLjrc+qtizLMJl?=
 =?us-ascii?Q?zt2gw1vhM6vYVFPwmtT0EBqoz+Wp/4udOW0MXsZuf84NRNF6AStGgKbhcoN0?=
 =?us-ascii?Q?81rnEIEUBokMS+ECr2R4fg9jVDicRV3mz1WmEHSpv1yxal8cvmc8/i+8EEll?=
 =?us-ascii?Q?oTDg2Ug0RdEy0RV4M9BINKpBVqK8DFS0YPRlR2bHCX/YiDthTe0/poHyiNlS?=
 =?us-ascii?Q?m98iznHJG51MH/FYPwvAWfpBZU6WJvGSjF3cstm771cfPkNhbYPt9E2s1UB6?=
 =?us-ascii?Q?eBp+373Zqeear280RCFIG+9hehk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4cfd53-ed75-417b-ad68-08dd2f4097c5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:27:42.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNa2MLlPkZLUXSbhlWMyE/JwnIdYLpiIok2EOjXnaiFGkw+NiAWZOMt1vvEzGsSN9VqEoRtl8OBxSdrN8Zov2qcR994V3zdj8hOUhPMFTrsz6g8EXY9MwmVjkBDi+Q23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8344

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..073eb2a21841 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..a40232ad971f
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	dev_dstats_tx_add(ndev, len);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	ret = pcc_mbox_ioremap(box->chan->mchan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	//inbox initialization
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto cleanup_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	//outbox initialization
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto cleanup_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	return rc;
+cleanup_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


