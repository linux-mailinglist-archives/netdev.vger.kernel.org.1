Return-Path: <netdev+bounces-205910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C1B00BE5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28202581440
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF742FD886;
	Thu, 10 Jul 2025 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gyp06PTO"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF732FD864;
	Thu, 10 Jul 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174820; cv=fail; b=PtWSxXfWsavDFmVFRCZvslyVnC3mdMzdJNkjg4cLks6gT5X5YSszvG54kSkYN4gO3RPd28q1I86RxokLYF+ufJfQ5qZVmBe961dw99ob0Akg61OrhDGhWDz9Xb96TElFSncpEpcebg6mGuFURH/ifqSFnCn4nbjvMq5gpPo2dsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174820; c=relaxed/simple;
	bh=B9gSMnFzYDdb4TjzNcbLWqQx/PU25rkmktDdo+kV/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a48gIxGbnRmmpz3GkfLz0qZ1LmLUvqSvltc5KhQhkDljgwqUpEKqugWoSZIp7btoUBMyuIndqWYrhRZvH2T2Bsa7H0gFxAVGnau+ET4piSIGLrd82s9dYSYbzFtkalavM7qXmXdxPTjz1a8UxxkvyfMty54nXFzHDqPBVU1npp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gyp06PTO; arc=fail smtp.client-ip=52.101.56.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkV7oOZ3y9TKzCj0XHlAqz+5MYmxN8eZbGUR/i5fTa0SaRPaBoH2hlP894uNIfNgSDp0/gXDzLvKFyHahdORubttpYv2IZ3rDkM2QxHcu53dMfluIdprnqVfDW6xThDFSDJDT7aCKunEFuV8qmTAd4vmJIczoFUrZsB9h0nyn8ILxRCdCThNa4F6iwpzQLVuQlqdv/BCq4cHeh4YK1J2Ld6AZ2wSElN4PH4gZpI3xVUUzTEfWEXvCWruNglsTjrWWsnkp+kID7f/C8TvmokRVxmB9o9y9Ze9xPEGoqbUz233AN0sGuiLYezxzeHo77dxqyxctPBJogfbgsfH1CbTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swsTZXuYvbJYDwwr/aV+fo6KtZqE4MDgpzMAar14Lns=;
 b=HemDrV6zj8K4qIwJlQptxExyMLNw+YdJmqgCfioRUNnbt1DQBvMHCAzbuWFzgeXJHz2yT1uAXTy955npa4Qe98XamksHLYjL8nmCBMJpHzsawMqx90I3BBiChIE8vAdkkibie9+n8JjlFX68xbpsgaWAjMTNNng0HatKxqq70nntyPpspPorR3O+fkvdkLtwCq2aFhVWAWcLMzef+klOEQMupkcEjG7ySzBYURQV2QZMXvQea35dqdc3En/ItnhvYQVZuVMEKX3VN9nGrCmuF2VmBcNL+QhFi0fsd3qs20fsfPxMIiNrPrBV+tBQGUtuYxeBCV/32xiKJMRde45MSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swsTZXuYvbJYDwwr/aV+fo6KtZqE4MDgpzMAar14Lns=;
 b=Gyp06PTOZFlRDi7y6ZMafQeGEAx1vw6h3VGivmpH5BTR5cId9eGjfJYutaKxy7AFnltMWZLTIIkCFkiSY446EB1jkjdAYa2sOevzcvSySkKrXGexLXG4T6nTTYN+WbVJTTMcSkW61kk/sBqgIu39g3QvRR+JpbbyLyFmMNmEtaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB7188.prod.exchangelabs.com (2603:10b6:610:f4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Thu, 10 Jul 2025 19:13:33 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 19:13:33 +0000
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
Subject: [PATCH net-next v22 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 10 Jul 2025 15:12:06 -0400
Message-ID: <20250710191209.737167-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
References: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e1866d-bbfc-44b0-3fe3-08ddbfe5dd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ku8ALpr8T52b9gEgFOvTMXzvVhnmFX3TY8pk3NF1jLmrfz4JfsJjZFQpvIZ?=
 =?us-ascii?Q?MwuzsHFYG6d2dsOWu1bDip0p21ce0z7cHC4CjbdUkTJ7Xs2cCePFY8JEopBv?=
 =?us-ascii?Q?MkI4pRLCwCyyRgJUIb91CGXZFo00NQhu96mIyp6K/RHwn2vc8hx8DG/JOFVh?=
 =?us-ascii?Q?ixQMyDO8/2EmxnqKHylf3vXQP1IAyK/+YY174ssw/QPPWGky9X+NFdkWojZ/?=
 =?us-ascii?Q?u7eKjbUjePBQX5SCom7z1Hs+ktYnLbge1Ehn5dQpxsE2UnhLt832ZvDjHaPK?=
 =?us-ascii?Q?JW8g5tJ3OBeB98A30QsYQhZSMgsGPckMxdVh//DrPzqcWJOd7kIBc6BdZhW6?=
 =?us-ascii?Q?/BmHkcHyHz0P2Qd1CVSxX4r35+3H6+Os96Z1pGU7d6VqJxKAlKNwLqUweVoj?=
 =?us-ascii?Q?9FdHhjw9hLBDM5qBrp7NMiOQ75lMKjPlg1ZynVqIIb8OBM07Ac/XcwZikhmO?=
 =?us-ascii?Q?2QS8a9QtVyA1X9nsA5ufyDMRcmFhMSUEKVN9JwMX69NunrOmlcX/waB3JDE/?=
 =?us-ascii?Q?zccDW9K6i313n65y2nS0MCbCcOpKdJ4zJ6AVwCg6WAqkavlhqUDDw5wBcsS8?=
 =?us-ascii?Q?YpX01nKH4p/3VythHu5Gdela2GjAmD9x9ZHhQ1n5PTFY4KDnCF6ObTw5RPRu?=
 =?us-ascii?Q?Qxl5VRvvKbk7pcYY2FFfZe+wfdx4G9BjVqW+IbcEugzYMeSqcA/rjhYDiYGU?=
 =?us-ascii?Q?FOciVPTk56bKCqm+pDiMgIP5n9aK54ts87qIqaTehX9wbFAJwvccLY/+QMSe?=
 =?us-ascii?Q?c24mRSLDsmsWu8p0TcUFPzIQfZz/TWeDCWBI5p2mNT6T2sOauvV7haQ/M6u0?=
 =?us-ascii?Q?Xlid23Ckhp3Qxd1wOmsBmCAC6MR17Zul0M1/8hkapS3hyg0ojCe0PQj4UDQW?=
 =?us-ascii?Q?WetB+PEyppuAAjJsQE0ZomX2A1MsJCOk4kZV6U9qw7nVlRqtadF3UnYWJopw?=
 =?us-ascii?Q?3uEBmkVPI6GyvPczu8heUiy66n144tjoXbMxVK0w0R71cjolsJjIbHO9vLmL?=
 =?us-ascii?Q?ceJyUrwILtgj+bEJZBWBGX9gpwu/2AZG30gQb5RZci235umAoVJ1jlDCzNFP?=
 =?us-ascii?Q?fe0YVi+UekB31QfpLwcBrNyXuDsghUcjkI/iosH4fBYlE+ejIevYz9InVNlj?=
 =?us-ascii?Q?dd4Li6TykFiyzn84UOcPLJda2TmGNTL+hklos6babX/xwzPb0FOszC/xWeGH?=
 =?us-ascii?Q?pAr2MfzED1LfojMtHWCEr9rqu9QjOmIcbZlDxJJFyb+5LVNZqUQYg5vi0KcY?=
 =?us-ascii?Q?mweuIaqsYi2AMHkupG3EFvdspG8oeoY3qCsWBa8uqrjmTyffqO4v4Y2L2IM3?=
 =?us-ascii?Q?jMaizwuXPqPxF27XqWrH4j0n6BhMuugtG1JaQitCr2yxRx26hsHuvrR3yHKN?=
 =?us-ascii?Q?zSf9qJxA9NJQZtga8ar0QvJbiJ+q/ox/5E+6C+Bh3aGChiB2CpHVNyLrLDq2?=
 =?us-ascii?Q?DjQTAHtPUvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GU18/yKxdP2HgBVLJCxnh5k0hs2VAvn91GQEbvKqUZ9rdF2P75iry4ABM2U/?=
 =?us-ascii?Q?I61JVlLWT8z/8jTYypgJRfXFvYv0FiKO6AYsUH6f4w//1ka6q5ZtA44BrMZL?=
 =?us-ascii?Q?2aAUqunGK1WResp2+HTv6AYWYB8AS/awAj9eImP8tI6YW6o6RefRcoAXieNo?=
 =?us-ascii?Q?6cXjTi8qzpdXX3BpEHr+O+Qx+gP/sywwWCreiYdNI8+vxP1ONdUXy3oJ1uWV?=
 =?us-ascii?Q?ipR0wnQWyLXZbZATyXaKM7u5ttEVMJ9wqJeOB+cOYO/gc0A9uNVusELth5Z9?=
 =?us-ascii?Q?RoMGnTWwr2IXZgSukRUO59MOXqy9dvb/UZUQX+esvIt7MJEBYm1J5qqZZnWZ?=
 =?us-ascii?Q?bN5HmhqAdVEMJXmrFG3D1vghi2tXTj7KMw8DmU8Ad95EF/fHxxoDcLK3Wnf7?=
 =?us-ascii?Q?0bjBm7eDuSaQRYCulpuZ9jvKQjtIfAsVkR4AqTdddiHLtxRW4CFgNAnUuuNE?=
 =?us-ascii?Q?n3s8B6GrGvD5tHkDGr92Y0J+aaEM/um89nVgEjhrCRKmTYSiO0ZCGGn50u8z?=
 =?us-ascii?Q?6ej+tFtcVkZYOCIzZmDf/9x8TXrTrkOjPrVFisD2mF0dHV8esETdYgR3A+G3?=
 =?us-ascii?Q?SnqJ7igCJTRt5cJLgqbl8qlk7AlISpmAzh+K2gtxERgUoFSpuSVX0exvCgbv?=
 =?us-ascii?Q?SvDyA/gNYln9Ix3s0nB+w5k8PaZ7iQjxHSJr6zICVLCld5isbJ9H0eW8nKty?=
 =?us-ascii?Q?5n4UzNUCEiQoN6qZj1TNalFmUP7IBP7g8j9nB6A9bgKgpFAnWDZBU6A/qHmm?=
 =?us-ascii?Q?/TMpzu+9uTbLS0NygKIb4+wtBAV8MHPwDhvnGtBnyssJNRqVz5BQ46RQhgfi?=
 =?us-ascii?Q?g6yTwmnBQ7k+72pVSaL+rBwSGYBof/38Cla4WsHcgAs24lYO0M00U7jxDHSF?=
 =?us-ascii?Q?7jwCPqXYe6uw8VIXO+fAgkbd4ptr6xsdeusz7iJUh3FkHZGFZlIgL9+2qvay?=
 =?us-ascii?Q?0KQXsnKhU3+rDZnQFAFzLWe4Y8/4m58xH8YJhIEN69jHqKfac5XPsBOCtVNK?=
 =?us-ascii?Q?LbL4R4J487UpdrONEo/H4nE/2gnVkae2hPWILfAFQMR+cEudev3WFPwbgWpY?=
 =?us-ascii?Q?eAhG4vODT1lm+dE5pmr6zdZn7C5D1eQcd7ftOraTDfgantS9d7SWIfPHBwil?=
 =?us-ascii?Q?NxoGpLjSsb0c4hkkcsFp8EXTx8Kt9aNFFhYiJp0bNF6szzj28j8kBmJHBvtR?=
 =?us-ascii?Q?Godmn4syQw84jekDgokI8Lu/lo7S4YZGzhJE1z9qVtCKVjn+T4Ro2YcbVlIJ?=
 =?us-ascii?Q?QoBmDcs2sMww1tesL4q2FDwxw0ZhHSd1UcA2/muMbXfC9KwJ5NYgLhHp9lGz?=
 =?us-ascii?Q?QVeyA8gzflzEidrH8IjSFZj2v2ET766WG0Akmq0vDQaF5wqsNrnX8nVUU7uC?=
 =?us-ascii?Q?VRPnU6IHud4xXoCXGXagbyskzhbqTvUi4gmR4PcOOhXtly+q+h21E95PNMRb?=
 =?us-ascii?Q?Z8ccowXM4mTfNLDdV5LCeMW8d2A4AEgq0eWBTeeGcHafflbG9+8LBrxMjTaf?=
 =?us-ascii?Q?FUt0ZjJWJOUt3HYOpu/pTZuuj70Cf3IbBW9oQlYIlicUY2n7q9Ov7s3m+zsL?=
 =?us-ascii?Q?y4EuRj8fezIioF9boLYjXZjmgJOyN1bDNBfPRY7fbnYIoDbp5L5fVU5nCgB4?=
 =?us-ascii?Q?y86yB84MDed/Y6laBbmI7oopvPXQ7h6rEZvF8AQC6c6r4L6OSem0vzJTSxau?=
 =?us-ascii?Q?tOJkSTBvlfp6GghJeKGWakTDpgA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e1866d-bbfc-44b0-3fe3-08ddbfe5dd1a
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:13:33.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlrlquZSYO3VN2t1Bihh8SdlaP21P3ZFozTd52vMcM2uJG4AjUMPIS1IkG1x6+gKK93uORA/zqCGcrzgiDUXBsoH/tUaVu/QTUF8fg6ZCR7GAWzrordHaNN1C+vW0B9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7188

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox buffer
management. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted  as a PCC message.  The driver
is also reponsible for allocating a struct sk_buff that
is then passed to the mailbox and used to record the
data in the shared buffer. It maintains a list of both
outging and incoming sk_buffs to match the data buffers
with the original sk_buffs.

When the Type 3 channel outbox receives a txdone response
intterupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 346 ++++++++++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 881a1f08e665..455618ee93b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14467,6 +14467,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..15ed449071d5
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,346 @@
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
+#include <linux/skbuff.h>
+#include <linux/hrtimer.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#include "../../mailbox/mailbox.h"
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0292 a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	struct sk_buff_head packets;
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
+static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
+{
+	struct mctp_pcc_mailbox *box;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb;
+	void *skb_buf;
+
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (size > mctp_pcc_ndev->mdev.dev->mtu)
+		return NULL;
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, size);
+	if (!skb)
+		return NULL;
+	skb_buf = skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+
+	skb_queue_head(&box->packets, skb);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcc_header pcc_header;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, skb) {
+		if (skb->data == buffer) {
+			skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+			dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, skb->len);
+			skb_reset_mac_header(skb);
+			skb_pull(skb, sizeof(pcc_header));
+			skb_reset_network_header(skb);
+			cb = __mctp_cb(skb);
+			cb->halen = 0;
+			netif_rx(skb);
+			return;
+		}
+	}
+	pr_warn("Unmatched packet in mctp-pcc inbox packet list");
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb;
+
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	skb_queue_walk(&box->packets, skb) {
+		if (skb->data == mssg) {
+			skb_unlink(skb, &box->packets);
+			dev_consume_skb_any(skb);
+			break;
+		}
+	}
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_header *pcc_header;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc)
+		goto err_drop;
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
+	pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	skb_queue_head(&mpnd->outbox.packets, skb);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		pr_info("%s fail, rc = %d", __func__, rc);
+		return NETDEV_TX_BUSY;
+	}
+	dev_dstats_tx_add(ndev, len);
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
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
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
+static void drain_packets(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(list)) {
+		skb = skb_dequeue(list);
+		dev_consume_skb_any(skb);
+	}
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct net_device *ndev = data;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
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
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	box->chan->rx_alloc = mctp_pcc_rx_alloc;
+
+	box->client.dev = dev;
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
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
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
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
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct pcc_header);
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
+	{ "DMT0001" },
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


