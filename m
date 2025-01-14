Return-Path: <netdev+bounces-158214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D246CA11137
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF57188A831
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C00205AAE;
	Tue, 14 Jan 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nbVyu0WR"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020132.outbound.protection.outlook.com [52.101.61.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8071C3BEB;
	Tue, 14 Jan 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883087; cv=fail; b=lbzZwDRGoD6Wu01T/ksw2iFSmwb2sJC2/hM5iP2mroNSWQA3s4QZjonMCtBmHA8cqtpOcpn2JxdOcVV+0kPFT7OYqWR9+UCmp4fUztu3w+v0+7AjVduwFiO6tX9M6qreSyaIbzXcmRENQ+M1NavEKZ4SVDn8oy/KKzk0ZE5Msyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883087; c=relaxed/simple;
	bh=w5UYDJeyiJeV3K3/Bfa+V1lcnUJiQAJhoy3hkNGczgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QunkxgjHAuvFT28PjhRrb4j/camM3hZA5A1Fl1kiyXMxYAboJ5rxiIc12COH2aREzNMsr/wGBS4zE5Rt0loRnPSn/CH1Bv6trv4+6pUXJgmD6bWMLi4o9cySJE6/RugNxp2xoWaqHao2Lx1j5yMadXH3MBwLDpJ24f3J/OfgfYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nbVyu0WR; arc=fail smtp.client-ip=52.101.61.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzjWqHKNkIJfEsYzrJ+ykSbhAOAdD+HXA+/ORbcYRQ0Ztxmh/DAAPerpCVubFRUpt9kadcy+ncJQpj90pJcdpV+tBDzLJ5HcsrBCVSWUB5izxcWtlT2rLMPaoxZhBGbk0i+FarGaEL/Fev3+ruBOOEnDK/sUdt6Eow4xmCYdac52W7Ga2fk5J1RLziOA7bUiuUx2dkMucQOQbaQoldJrnOc246mqaIsgcV1NWBXBTTmM7kO6C2k4tCcqEUC4g04LyK4wq3X3D7p1vjmo0kpbO5aetyFg8U4Ph6MK2c9ae9yw5EQJoMnpImiShQoRduUDHOYRaHNO6W4HTPZsl7FtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hH6TIHOamvRz/E0yazDHnpIrM/orMNCVIEU7ykUhfg=;
 b=aVMdVqlbbNqK8FVdVikeXbmpu3gOVprKsBitfP6TlMncD6dlIBrwP5c/F2V3Sw5TDMX9Z0iHRCXk5B0OHG6/yxAqVb/+oO001g2pbcakomGtvLSKA/wZ5g/tkqD6qggKbrwyeTpiZSBX2z9EFB093WctuMY7SjehlIMdkdRhTI0Fv6MEXxctceKH3fOZg4sI9lXXgjC1Uko3pEaeKpEnSCYdZHkpVweEbja9NvDZ82/s3+DIRNNAEcobjvKl8/SCVoTARhyZlBSQNYv911Lb6vCBQhoVBH+6HrFmDAop4KpA48Lgu5nX9Z6pO0PBkGbsl6UOb1l45IX4tWJWxf7S4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hH6TIHOamvRz/E0yazDHnpIrM/orMNCVIEU7ykUhfg=;
 b=nbVyu0WRmZswgkeg9jH1f1G1Yu7E2yZmACTb0QnplGh25R9lfNzcUM5U7cgnUBGOIPkybq9pXbiZI7ji4Wjw1TeQ5nQThEF1kqJN2GpA7pKV8ap1egYHCEPXekCPTD0aYFD4kpG/7td4TIE1umG/N8s2QtaTd6f3SzbtWfl79x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 DM4PR01MB7763.prod.exchangelabs.com (2603:10b6:8:6a::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11; Tue, 14 Jan 2025 19:31:21 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 19:31:21 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v14 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 14 Jan 2025 14:31:11 -0500
Message-ID: <20250114193112.656007-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114193112.656007-1-admiyo@os.amperecomputing.com>
References: <20250114193112.656007-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|DM4PR01MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 905cf942-e3c2-409d-bec5-08dd34d2064b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FbHi5WtK935UiQiete4G+H6uuRw4Fq0MshHuNECKJ8UfI4Q+5z+o6xQdofp7?=
 =?us-ascii?Q?/gLpgAsX1XAS/usW7jBaCsPPj1poLly/ChO7RCOvc92+tizQC6wf/xoyTs5R?=
 =?us-ascii?Q?ks0DuUkFakWM2Lr5vhWY5+0RiR67e9eBklWcfKrgZ4145gxGvvhg5L+ygCMy?=
 =?us-ascii?Q?Ec/NO4IJ7L7G3Wf38/JJy75L2+Dmcl2OGFJuyGcFersS/EHSbwyOHSoGxyNz?=
 =?us-ascii?Q?A0T8+T6CVReoozzwHTg3+zSgjLgXVDkx5kXTJco/DjExqMQ/9ilGlWCxsDP5?=
 =?us-ascii?Q?xNmHBJCUJB1ygC//F+T3pc2YJTf8AUQqCZ1xWpqXxGhHtEN53gLPA4HQyHTU?=
 =?us-ascii?Q?8zYi1kcU9P/+U2MEx7OQbHzORVYNB8mND1oWaWJoySBCGjn4PXZYXl5AsV9u?=
 =?us-ascii?Q?+JBYfAyg/tvImimDTSuASXjFRbj5Xh05IlGXF7s/q/wvOGEFb2Qkbo9aXotR?=
 =?us-ascii?Q?BIgPOWXZpwCbeukKflylcURoWzqn4VQ4OjfG/sSq12RnbzIpHxS6g/SCQNsJ?=
 =?us-ascii?Q?Z9MjAGEuwB9DDPLQKC+AwMBT974kbkFda7wAAOME/bElv/8V2s1qJ41eMfSz?=
 =?us-ascii?Q?XoZpiG/nyKQ6VJs73Y72ukPjozXxgOER+GgPKmF98S/K3iqg0gLanCl4Dl+c?=
 =?us-ascii?Q?Q2EPeLDQVCRpkf+mbvVKpCCUpjQ12uqAUNve/zTVfsSC5SPzhdXzImqMg6oe?=
 =?us-ascii?Q?DiOLJJbtK3Y5N9Osc/nT/ouTZIIvjQ0sHhyEz3q1QVo0CgnfkCm3b91Bx1Hq?=
 =?us-ascii?Q?Fea4GAfXp99+NtDvoGbCADBPWb6Dg3UfIotSjVWCzSlHYm7Kw7lTBjRKRScS?=
 =?us-ascii?Q?uJ4zdnO8p+M1MOjPEViZMhW6/fypJJwzRdZny3VPELsu3ktuVgK18a/zEhkT?=
 =?us-ascii?Q?W48YYmJ9I1e0C9awb29N6NRLkrCNzTWgxXqytH4xFBea9Qlhk40UzvLs7mka?=
 =?us-ascii?Q?c8VVY24QdxyRKji4RXbeapNz7b0YTY3i4mzEJAcr44WcO9v6kLY1r4BQoHmS?=
 =?us-ascii?Q?KuZyhMHhWSGQw8Poqzlva6XNMzayNlZf055Dc6DruMxl7kcLGZJflk+GcB4S?=
 =?us-ascii?Q?DqTrI/1D3aVR0YgcHGzZNB4pjDAI/Bl75AVnbAchLKxkqDqVs9VazEnCVXQP?=
 =?us-ascii?Q?W19iubYLWib/r19il9w3oQXmCw227Mii3o79IAqqexRcXURjVzRnZ6eymCJA?=
 =?us-ascii?Q?8ZGnLkCQbHNB7jqIbw+r68tyAd2Xa0gmzET1smhGMKJKPqY8kVWPmyy5NtCO?=
 =?us-ascii?Q?yYwYKaixpqQym1Z90HmXskG0qTjfbegDXUXHEsGnL+GWe5mUzeS7Fts/XDu4?=
 =?us-ascii?Q?ydYL1pytSlDYRCn7nTXX6Ja2IW8zJBtjzYDapT/cWDT/3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qjt8+viXhE12TV0q34qoK+1qwq0grnQCPPdCcBWdT7hxEU8hP/tTN12GZvTS?=
 =?us-ascii?Q?rp5F6JHjJKDjUJrHWd1WvetRuhGpFQz8fqclz5dz/zKFBxzuNkgxr95trCLE?=
 =?us-ascii?Q?eWYt40QCNwIQnNLKE+IFpGiFZplgmDxYEvgFffe7Beb3LR+4FC0wJfEO9fLL?=
 =?us-ascii?Q?xpTeiA2VHPo82zP43yzg12mwQ+Y59yGIXiemweABxPsb4gN/6Zita0xv7zCr?=
 =?us-ascii?Q?XYIYTMz2jrn21NeE0U3L5skOaFY4NPSJxOFFQFPfbEdhsSVEtHcu+FmydR9O?=
 =?us-ascii?Q?fZti+3xKFUjmsoX0JT5fDnxhVbJzLL/AixW/L7F23iotaTmPWPmGaEn8byNt?=
 =?us-ascii?Q?XwxkHtD6W3hL3WTZev6nCL2BMWs8trsWeQt7bQiCZ6kc9JAmgNjPmqjU3atw?=
 =?us-ascii?Q?wi3rXwv8O76rg5+5lrkJGQ1hxcY7y5+CbbaEErLJVlhZhE5SM/btsAgus6wW?=
 =?us-ascii?Q?Qp1chT5qMMskzyYdKXV/x3lKnwyRJyejuwmFuLAMxGL7whznXn73WJ2bSfbp?=
 =?us-ascii?Q?6SylGJyrH5Y8GTnFb/U8yk+0R7lJKpVIyMZc/+M/uqoqL6zaXjGRjKbB+jQt?=
 =?us-ascii?Q?A9hxcUZqbGLPIg8n49ik/d5yCkBSNYcQ+IzjzB6X4oHD3/ovrjiDz2kjOvsx?=
 =?us-ascii?Q?k9tKhMdGuXLFdZUe9AVLUZdSowGjYeDpGNT0lfbbA0rBYBuXAo8uIeZUgXrG?=
 =?us-ascii?Q?Qpy23Yt2QTEPwLtDRYDMDWAzCcefPfNwDIRNcmS6KqsSWOl2TpxvYIIn4BIw?=
 =?us-ascii?Q?0ww5tfiJYRZLT1msfyHGG5htCy1eYxSCh+4pQ53KbL00eWLz6Bx+slpMVKgS?=
 =?us-ascii?Q?czrkPyL1EOwUjterAGxih2IJVBcR/qQ4VSLBeSOQH1/SC0h1bcV6m+obHYtq?=
 =?us-ascii?Q?Ypoqqu76p0cOD32nqjcZkYpoXYUdIp2Oc1FtPPpcRCzPIVezwp/X0WZAzEO9?=
 =?us-ascii?Q?vTZ/ddyIJVSr/4NXcdiZPP5Bd9nu0YMpRz1PCCEQu3N/KL+CnGV8yFvr/xRn?=
 =?us-ascii?Q?jmu/30lJt/wbey3o/kuMWtmDTMIMcIkhr1gsJ8hszwN1CMwrp4bY/emYXsUm?=
 =?us-ascii?Q?xj6IYRTE3LHmM+frLHmn9LxUWpSeef6CWzdZtVfPOnxkhuRUky/CJkf6pQYy?=
 =?us-ascii?Q?U5xCbjkcnqTrYt2bBsIRH4u8j81mF4/KYfgj4mWlIUfxA1QM1FU7fK4dMaBu?=
 =?us-ascii?Q?XIuWLIOCPJkzibH4JfQcQMCb0/l8Yh3gwX1MbsQqKSt6tTBbWCSKBDJTyBK6?=
 =?us-ascii?Q?s3POciCsYPld+kcpS04U26IvtBtbE09Yh4lCCtvdYbXL9qBMkTenm0xC+e8k?=
 =?us-ascii?Q?bBg81huwkSMsJWQ3F9Fjpkt6j1j+dl3BlpZP2xzZsCYdUCP/JxSuKu+85P/P?=
 =?us-ascii?Q?J3XEQ9wbDVgDDLQWWCVsJ/Y7CzlFf6r3Dfzktt8CLEyKLO5GaRECZPAgnQel?=
 =?us-ascii?Q?vk2O3Ajs387Pqlk8n7pAmemm2359z51U3fWC+kd/mLKmOdptvg3m9EpQR9H0?=
 =?us-ascii?Q?gTwEvDWqqoqHgFSWRwq0kQSnpeKgmFk8EcGWO77KIsN+Y70tD/0QbvD+9ykK?=
 =?us-ascii?Q?lbRJ4ypYTRhKid8AQ+VyZ5gYVFAIThtJvxdjrm9pgMTvJvNJz0iAzl4eIiiS?=
 =?us-ascii?Q?x6ztOZjDVYqtwTBnof1Y9Rti0QOS5Vez5IM9wC6kiLwvMuEmiZpKrREy/JaB?=
 =?us-ascii?Q?LwJUMnTDGsP7JejAdMta7tu3w+g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905cf942-e3c2-409d-bec5-08dd34d2064b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:31:21.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzJ0AbR6Jc/dadnzv4ltdwumYmtQtlOXi38UxKMiDYBdoeNitK8E7lNPlgA3CMzDsNh6uidqfKKhrXCuUTdIEPEPxMkOWCDsucYnYxK2hrOxbY3DdMcqBLOin2tD+YUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7763

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 313 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1579124ef426..a4b8168cb346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13789,6 +13789,12 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:      Adam Young <admiyo@os.amperecomputing.com>
+L:      netdev@vger.kernel.org
+S:      Maintained
+F:      drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
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
index 000000000000..87283e5b1490
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,313 @@
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
+	if (rc)
+		goto cleanup_netdev;
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
+return rc;
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


