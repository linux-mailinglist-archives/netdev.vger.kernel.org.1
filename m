Return-Path: <netdev+bounces-185292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54FCA99B2B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773995A68FA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCF1F30A4;
	Wed, 23 Apr 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LohNN0uj"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020112.outbound.protection.outlook.com [40.93.198.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A8194A73;
	Wed, 23 Apr 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445716; cv=fail; b=GuxBM7aw/RQP6WZEi+zRvWRp/qdS2dJ4V3JIpwASVnHMbImVj7OCzddNbdRGuV8SHZBsLc5oCAOwghI5p4mP4E0h2wxb3HqD0vDo9keoRnHBfUK3EGSs4itSnwNPU7LhPKdiJ1DLIgx525S3uKRCzf6WLVI5dqgP1voFNlWV9V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445716; c=relaxed/simple;
	bh=pybMHScUL2AwMZa2qg2ATt4YqmFWYJUtQ9yFd3NXbio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UK7WnPE12po0p/m6NmHiuHez9miAojgTlAYlQ+O6zEWWhvk6Spb/AcrqNT8XJu+G65xSu+d4df7XEvvCIaDvnXEX5yVHDOQnom06OUR24SVq1DAuyCgyhxOwRAw+rcPPzmztPBvFESILabyyR+Yoo/U3w03vxQF+iM3mO3gPPJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LohNN0uj; arc=fail smtp.client-ip=40.93.198.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdK4oUZ8lHl1iG37IFCIl030WlhXfW6nKWSJqbr/4blUIKMrGKJtZKE1TyT4ak9+xMJCULw2+maSdIBZsWoHwlH0SnDB7uYAcIEeyTAI9+97HAR7LDNAnJtk7GS5ucvwhv9RjPmV7UyE+p3KQiY+8ul0NfE/nrz9eR0XirEH7F4kCnkwsKfO5JkF9165K+XK/XMfe2sOMElVFt62KPZDeMCdgTfHq3WXwFqzKdaxcYwotaKHaUH0HY7NcIY7mMQj18gwZHOg8h2+QqtIIB4vs+YTj8a1bQppowFhwUf2ehqK4K0s3q6W4cVkHYMMVqLS7bmw3T8xBelp5ycVFrWYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuBsaHZKgvzFmYy1CsuwdBR7V56BZpPeQcHvqmZI/J8=;
 b=Hn8Waqgd3A0BsaLNyhMbeIapffNQZ4n1ugvYz1DAopHLjKrybejiyD1mfF93LFpvHEFNdKaFqw/3WQkmgSylIEfLn+i+RuvJNAg6AuzkrWdo8w/XN96qpAxdySwFLJkl6Uit0oXwPIMQkJNiabsUXWOZTaTvKEgNUhI6h61ZB9aAyyiV/AtDmiZoZCoIif8etHNKJL36EVWNy5XLKV+YScTLBUemEYn6DhOuz618ndeoGilNYtD8PfffV4LBKJktfbOh5GfO38AkBKVH+v247G0AqozRXEDQaW2fV4+52nL+/gUesWZauwLO38JIdpNKZvLOtkbE2H9LwW96Ytbn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuBsaHZKgvzFmYy1CsuwdBR7V56BZpPeQcHvqmZI/J8=;
 b=LohNN0uj7Wo2XiDCddO4Tu2vRv3KR6PLhuDa7mDCT8OvLqZyAxSrZRUbQJhN+2SffbboZ3JudgNWgiqo4aBidxJG/teYML9fuM6RGRb4mdBmXlIyPmesk9+HQo617XEWXgsZGrvuYScdNKsIhSDi7kyeQpeqEkSPCKcPKNjPj4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SN4PR01MB7406.prod.exchangelabs.com (2603:10b6:806:1e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Wed, 23 Apr 2025 22:01:51 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 22:01:51 +0000
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
Subject: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 23 Apr 2025 18:01:42 -0400
Message-ID: <20250423220142.635223-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::30) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SN4PR01MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 260a4dd3-317a-41f8-1d7c-08dd82b273d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yi0KuYrTXxC8FvLi75h588WDqkQQLp+i7YuF4tNLabCqBu0TSpwTKSBS3J/h?=
 =?us-ascii?Q?eRo/EMkQ/22Cz8TFt5AO9QhSYHkOdGTLiNSz0NIEMKaAzNe8uV+A3OyGb3Jn?=
 =?us-ascii?Q?C2RSG/9AoULexSKWI/7JkOZ0gfp+wNO5e2EtJqLycjXp/EXYYMmVCMBBnc8Y?=
 =?us-ascii?Q?STMfxQcdupV0wJaN0yrMD3uZnLp1Cbkc/KPi6FUQDLvhnjzSdIsIp4IVIsJn?=
 =?us-ascii?Q?FRB6G0Vq9q1i9JaCNu17se+jc4TkYuucBx7FdxLFYmy2tji8lAGfVeuKYLrk?=
 =?us-ascii?Q?NbWMInPKDu0Es3wLPfyEivSTqJ3ntr15ZXfidnFVwj+nhK+dvyL2CjO6cf3e?=
 =?us-ascii?Q?Ahswrgwl5k8FmJE1SBRVHtDr26qBA3dz8fDsvFGCeysufNYLt/gE1mV8Ps8x?=
 =?us-ascii?Q?IF/FrBnkdSsYUSUuHV1hOZd5HzGNIcVP6G6WfqCBYGz9qfbdYvMSJRLSziPP?=
 =?us-ascii?Q?Qs7MzjC4bdKMe8rbgRLyEyS5aMd1yA4Ew+l0G7bmJIGvYsEMYXIcUEVmD6XW?=
 =?us-ascii?Q?rug1NnbZaER3D9rdXjHMk0SNCy11u5ztEEmnSbbfe63v5hkz3O5UWX76HuxL?=
 =?us-ascii?Q?QWDHhXPA/UG/+zbAoNRRZUvLw415wN6/oIFQwckb/r/QvrHq32JpWF7lqdHG?=
 =?us-ascii?Q?V4K44+koUWq5Vwj0TiuW4TglcjGmlVDnnpj1/U2/H6FajTNkzOYnmRFzu3kX?=
 =?us-ascii?Q?1jYboplw+aLG15Pfm+kHrehr+aFtRv5HLSwouppWwSx4hHpQsrC83Ov5B8qS?=
 =?us-ascii?Q?WEw++zVvICH5M/mBpb2K79HY2U/asGg2osmHJYKGRK4+1h45oj6jndBhWZBJ?=
 =?us-ascii?Q?L1H44rDH/zntfWXDmIya7dgqyeNPsOrV8KFUAUtqv2L6NOazk6JSJVXVE/6T?=
 =?us-ascii?Q?m83Mh6g1j9SZrIIqzLzitxOFQ4CQgiWmMLnc16b863Pbs9UvuSRgi2E3IcdC?=
 =?us-ascii?Q?+R+qpM4JhlQFdZ5PWPGCi+DmwfiDm2TqRRVf8h0AE//liKFJE9GfDmPZxDFm?=
 =?us-ascii?Q?p719CpPfsBwH/Rc9Gz89o3UUmju0fl3RvoEOfffD9b+3YFqx7nAmN9jNhYRY?=
 =?us-ascii?Q?Uq66XSyGmrpYEAqd9s2TXpD8a6VacRaXfXN3gaknw+/y1geFkm3M6ezMo19w?=
 =?us-ascii?Q?nxOxoUQgi5gcBLO9T65YiIbC3mLrig2S9wOLTcZm93GoElszKAeLwHyHg289?=
 =?us-ascii?Q?GQet4uz3lBZUKVGFUWqKpCGNkb8dJBKiK/b6BT5dzCMIUqAfFpJko1jIrD1k?=
 =?us-ascii?Q?iw0gBFl0/9Ehb1aB6OaBj2RGzvzCPcEiYyemEIegUY2qfxwDDgcA7yzRyUE6?=
 =?us-ascii?Q?XTxfJaDutHnL2Qim+7yMiK3/L4ZdJshsjac3S/ZHgduzypuo4yADbCPRAyJY?=
 =?us-ascii?Q?5yId4/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kyy1b1SVd+kk1a6Qn2lZPU03QWRrJrhgyUA4Cag/v8pgwDMT3xKco/A2sykS?=
 =?us-ascii?Q?4044sGEoGdP9jLd1Bulv7WREjGTappKKJ2urSidQKbbaDN3GwmtlS16bRlwM?=
 =?us-ascii?Q?meKucwY5m+GdI/Cyeq4vPfbijhmhGoD3Sthw4BlGK+o6ZPodzWek/s9MYf/L?=
 =?us-ascii?Q?OlNfSTVuhYe87vhFZn//G/EaigRciMKve3FXQd2qOewupv42MKduRfP3oOv5?=
 =?us-ascii?Q?gyFw7RBU/8OTz7+RiYJgwfj2mihSMyRNLnoSyZjtN2cja67kBF2up/m+oKdn?=
 =?us-ascii?Q?4QVZAENUPCzrAPzmsB08tu5/FvGfwVVCgChoRaG7pCwPYQWBjqFcXQ9xVCwo?=
 =?us-ascii?Q?dKoo6PgWSp0TCKJZAooKvKKb9OR4ixIw875hQ1XbEaeV++uEDg5s//ZU43dQ?=
 =?us-ascii?Q?6Dkl3rxEc9qbiaywagNFW/n+ku0/kEmXuqVTzb6uLCmJ+cSq8qbR/IR0BZop?=
 =?us-ascii?Q?SYW6V4OcO1PNohqHbi4Bmkl9cAo/Csak0JD11MK0uuy0tHuppkvoj1R664xt?=
 =?us-ascii?Q?CTB6pwMmuSfpIjUG+SZeKHWcZHRtlvS+jzRbXyi3UstTmrXPDCuaiymDrNWz?=
 =?us-ascii?Q?X9eX10E8r4/IX3wP9q4x8Wd4spMxn6Sb3JyKkZKDrQyQr2+VyLiEYMy/Fyt9?=
 =?us-ascii?Q?rpTpsXbV/LXJZMmlV+Pq8lVYKhdXGSGBS/szge8+GoP3OpATofs5VI5nQZy6?=
 =?us-ascii?Q?ySpu5WpakWJbz4gDnwXbRoqqfZpls+wqL2iWvbPjpjYI5kvxKYCUJHCLcAxW?=
 =?us-ascii?Q?Y7EcKrqXf7ssJykob5YV56yXUojsMyvc+0JRI/3jE6bHye5HmcADLOhQ8QID?=
 =?us-ascii?Q?U2L1Ta9t6aqMv0hTnkxnYwzxsr3XBtv6zAkWHjVOu/T2XpxOiUW596S5rdqA?=
 =?us-ascii?Q?aPTEQ1MoViozXnJSqog2r8BnHlRU+Onwryt/pRgUxNagTqH/ZsKkYUQ1snSL?=
 =?us-ascii?Q?e0H6eApqgpFOq5RKjEmt8iqyUZil/whqobOV1oHTRR+o9lL4sa1akev9edMK?=
 =?us-ascii?Q?q/BjYghetKDxReKZtzpvqqU/SKbx3xagF9RGPzt27/wIcVe6bs0GdqCCKXb0?=
 =?us-ascii?Q?+tv/1bw+8hN+jmpWV/gPXo12uhogXuu7sNQouOtoNNmeEORweoIPs4kFlUWb?=
 =?us-ascii?Q?lnv7lxGQ5WcpwWJdNbl9RG5phGhPCkq7GRMSu9GEGk6+2I1n822x1UyeDJoY?=
 =?us-ascii?Q?M9PfPPJfNxHHj5uBYUUNUDmZijOarQr4dEKzR1Hba+dJ0qBKZLOYg5crLYo+?=
 =?us-ascii?Q?ETSV3CuCHfZ7V8s+7T/N2OMMnmLThjsZELCmOCjvXaawqHeI646b6Y8XvOWQ?=
 =?us-ascii?Q?hvV8G2DqX4aVtZMQo6elOmWKvHxsOtEac7j+Y3bs1F2+AIGWOUNHoXp14Rp1?=
 =?us-ascii?Q?GYpJeMbKax6HdEdna2GjSCebpPp3EdK6VrV69JFw2srRJe1jmgK8rijI8y/q?=
 =?us-ascii?Q?bPiDEQRIWOlL921MQT0kOH5iBsJEMqXM84eqEzvd/jSRtzAisXCdfnFq4nKO?=
 =?us-ascii?Q?9xgg1/lGQzn1psJSXSs9O0SEgXX4yPt0myCGuWpTORcy0+U4OaOmPTeFmm4n?=
 =?us-ascii?Q?NcF4rvuExlMqPI8ft+1Um0sM8gYQG+LtfiUPMS6DW7nlx1kJ0CKPPnKcPqwj?=
 =?us-ascii?Q?HPWHWQFlot2oQkc7CpJILAr9QP4/vaLIJjvtUTtgs+LpwjvEnJmWRXHFwZ8o?=
 =?us-ascii?Q?k55/KOqTD/lcbD+k8CVQuFgqDNg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260a4dd3-317a-41f8-1d7c-08dd82b273d3
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 22:01:51.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fliawr1xeVS3Sg+JXw8t1GMQnIOOUzjq++oKHyonx0Aw/p7mHw1xmt3J/urZp7eyhyrszCcUvpLnEkNP1FHnsBa4XrKy5y6+kYPiPyR/QA2WjBisZAb4KR4MEW+AUjDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7406

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 317 ++++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 657a67f9031e..7642afb18092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14200,6 +14200,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
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
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..589ba4387ce6
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,317 @@
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
+#define MCTP_PCC_VERSION        0x1 /* DSP0292 only has version: 1 */
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
+	struct mctp_pcc_hdr *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
+	if (rc)
+		goto err_drop;
+
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->outbox.chan->shmem;
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+							NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_dstats_tx_add(ndev, len);
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+err_drop:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
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
+	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
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
+	/* inbox initialization */
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
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
+		goto free_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
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
+		goto free_netdev;
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
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


