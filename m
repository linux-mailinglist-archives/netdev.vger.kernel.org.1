Return-Path: <netdev+bounces-171271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B30A4C4FD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A547A8E25
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE9214811;
	Mon,  3 Mar 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kB+ZlQDZ"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2090.outbound.protection.outlook.com [40.92.53.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DF78F44;
	Mon,  3 Mar 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015386; cv=fail; b=JJg74KtHesrv2e6GgzkynVcspgc1zWAMupMHD0N/GTv5FccInukN3bU1ephwPsScOps9/tVCH6FsI3ik2PfCq6VZiu/cTLZO4+kFqOpiWRepsH7Pst7ZbkmXanikrtYl9Bt7HFJ0Q4PCYX/zfXHneHe/1JtwF9WTkmDIcAS55io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015386; c=relaxed/simple;
	bh=t1XWgJ8sDgv65/nvemspGayEY5Ph3QaudoAeYPJxVeY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lgIhREa8LzY2t6TEwyNh/9+EPSfFLh9q9Cc1evgwlytIjQIVnh019U0S9cXAYmaC4TVbCZh1/Zq2SNHYj5l/qHZ9jjUqVamom5T0oFpc08VjN8i8RjHSQbFXT0BGdUvtkE/Fmw2Lq6kTXBUfluY6p4PMcMDbl0VZ/gLqZi4ofvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kB+ZlQDZ; arc=fail smtp.client-ip=40.92.53.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whqEWI/aSlu9jTyxjb1sar9YXavtCnmXJjn9Ho+TTRC0/DNlvQINL8sagFCJJyndt7du/1r0NaT9ojKyc2x+h8TXppyjVz0lWFSs+QO2ykTJHSjERfIeOOAYCF/MZI71sfdOmhVP9EUGoQeCYuWVDRQ1GkZAyzPJrsEWiu0NrHWcc1X0FbYFgbCigpimStTvZOqFuKuJPi56bIu2oym5XqiJ392O2Uqi+Tn965ufG9k4clAFf3zAC+A20bRQu2XoCdm0vFkF6aV3QU3L4vAsYIsVguvC+QeHIjxvLLZih7SeLlACzm3kBLhMwc8lu/Fw1s6EzyN4UUvdMLHwPPu34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLl0xQKVnLqfhENaed8i1I2D0hPYu0GzTdu6Rbkbycw=;
 b=dA/Pjr7Rnl56MsErLDj/2syFb/+1vdYB/N1T9NRn7yQZD8/NN9hgVqS6Qq6xtyiI35WrYaFjUt3jJbiBErP+b4QKCux75oQgKGk+uZAUFGZ3HXJpPY34Ureo/bnoliWLoRdYnXoWEeAErF7xv84tL2qRIP56EeIym1J7DXRtWkUtEjO48vFr6fGVhRkdR2rw676csYNQfIkadb6tzgqFFDzPrvRL76uZw/aoCavzrZEpy7BGUV5Vd5xRwrDbf8RCKEfQFDGSBzGManllway/xOEG2U+Ws4YZXufe66Qxv5ZED2Hgxupe4Upq5aIkDYKxnize15fJaVP+rmPsk02v0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLl0xQKVnLqfhENaed8i1I2D0hPYu0GzTdu6Rbkbycw=;
 b=kB+ZlQDZMGK/y/PAAQvpwb6qevi3Ne9uPJs8UCypKJyMJ087GxJ/GCatNgCojy8JszuXhyrUhqzQ+53Io9b9zC+esb2+bFGukI+eueRIgbm75tu60RYNYMqdKRpFuMTNlVYS1VMueC9ugXieCSam9UNrpZLLbHsQcX0CRCK/cum7xBWR2W2GkrhSicrktSly1t7dQxAiHPMzZEAgZWvt4eljqWDHW/wkicENBmBfsgkbSiPRiNQLY6fvcI3YR/DFacnNeOX4t9ed8LOrqrci3H7gN8UudbKDSGwaLtxbn8BEUSEUkzyzDOmkQkZ929FvY4RqB6jcuVt099xaf2Hklw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by JH0PR01MB5560.apcprd01.prod.exchangelabs.com
 (2603:1096:990:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 15:22:58 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:22:58 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: andrew@lunn.ch
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com,
	hzyitc@outlook.com,
	john@phrozen.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] net: dsa: qca8k: support internal-PHY-to-PHY CPU link
Date: Mon,  3 Mar 2025 23:22:40 +0800
Message-ID:
 <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5c::14) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20250303152240.6282-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|JH0PR01MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: c982bd76-993b-47c3-73e7-08dd5a6746b4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2poVIYGFuXhSIVSVb3K7u550BEkmUyE7xj1tRwNhw00aiLh1lB4vW7WHtKua?=
 =?us-ascii?Q?w8ek5OvteRN3UoZeIuPavh9NuORBHL2m+cPtQ/N7Cu6AsfJA1Rkj1MNrKGl7?=
 =?us-ascii?Q?bEbu8+CxWE4LQCmeD25VAj9imF/8YGlB6jUO245L869FNh0VlpP9z8cg8Hjp?=
 =?us-ascii?Q?AtoMEQEMQizbwxySApwJxpFMpiWDJ04M12DvJNoJu4r4Xxsc+3TSwjzJRz6H?=
 =?us-ascii?Q?OhDhJ57+Jmi4Me0ztoZPjQMz6QgBW7axVfyopbkc3gxOyO4G5qyDcDxzHCbk?=
 =?us-ascii?Q?aQl8Y62pMJTQhq79gIguow+Ma5ebWZzZyhhBuUUuKr+rzC+xlzfpxhHiTUSg?=
 =?us-ascii?Q?+Sz17/1UlV5I5I+1rtSKFvKtG3tMH7g7hdG2iPU6G/CEg1M4TanQ/E3wtmpd?=
 =?us-ascii?Q?hxFVrj3oynhr9ZGnguQzaLuCgHUgmb4vih45OzIfvPZK4797A/eeNVS7OVhF?=
 =?us-ascii?Q?PuuYEct3Q+sutmbk65nN6OzrQtvmsyTYSwjKuLqfJXL1Jy0Q93ibjxq9liMa?=
 =?us-ascii?Q?Zau6LPZvCRLgI1q12KTP8hFD0iZAICamp+ghU4ajTeBaebUH1GdaMAx63/g6?=
 =?us-ascii?Q?gR+eRid8o98UnktRKWGh3mETISrlLIGSUzEXXU72UCt76p1bIxPGjkZM1BW1?=
 =?us-ascii?Q?PX39XJwU8yaIa1fuWGNvV2tyS3pVWgHkZ0hb+Xv119qkbaoaYF81SIrrNlU0?=
 =?us-ascii?Q?+uXol0MQmSOjD58YkxyDn6nzp62ezfeXh3P5UY7428Nx+jXu8nQeCqxohGtj?=
 =?us-ascii?Q?kxTWQfIzfrUueuZCf2pIINP3Vyty3OMsstTBT9FdR+XmqiA8NNEKZ/hxh8vX?=
 =?us-ascii?Q?fkeHHciAqMqkr4ShOWLGgp64O/l8+eNXKcffl9JbhajDn7nzLpwC+lqcS6Q9?=
 =?us-ascii?Q?PC3BJgUlsl0KohqjzNxtkluLIOUfCVBkYYtwk4iO52zqbmFJQNT8tpbplcim?=
 =?us-ascii?Q?iBJE6ee5PH+BY0yhKn/s/CtE9f9j/2xfPm3MA2deHf/z3vr4qChN6eNFuZJZ?=
 =?us-ascii?Q?dIRk6KnRDz7C+xD0tBSXQwI27AxTNK8sFbU26L1M3r0O4qCYXlMo3qydreou?=
 =?us-ascii?Q?bNNCTp1/bYjusKH6D8l8B4VQM/Yzeg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ex7XcWU9JBudOWvWwdwjdlq8wrbLictaUTtSYXZi/gjHxRKceRZ9sU5jonU?=
 =?us-ascii?Q?0uiDY6koNez4M9i/F77ObEGG4odvu9Ht7KWf06H1IMVw6c7qMH2jFppPsLsn?=
 =?us-ascii?Q?7wNcFoTZb7kS8XY5Jc2HVkHnD6n4wD4wo7cq5vZBmxGEurXUbnOtEphlduGm?=
 =?us-ascii?Q?MEY3BnHLe93IoZZSNe8rWSrLJSkTXKLL4NDDqEpeYMjyyr+wkSAaMH7x9RcD?=
 =?us-ascii?Q?DKtUU/J8STzDFhyVW2kYZXuUEfbiox+9cA8L5Jg6HyMxTVBe3PnTdK/Z8sWV?=
 =?us-ascii?Q?FLsQ8KuZlw/Z4H7ueRVMVFzwTDp/UOhk1l/F4XT+7J1xzR3/u4Qf1qpuTsam?=
 =?us-ascii?Q?eGmLSWsG3bLtvtcsEftPnvGXu81Scf7YqBtXc+AqsXWJkKZK6i8icE5I0cVr?=
 =?us-ascii?Q?CzbOh7jEYAqEF3JcKEMouJE5g+qfjRzfwdv+i23awg4bWBwpslefzF5fD2vG?=
 =?us-ascii?Q?WJDvcbRlygzkwzdxBOKl7UZkJ+0a921ady7A0RaJrGdYh59t6C1FY1oK/t/o?=
 =?us-ascii?Q?PGpRBRNdGfZxc49c2L4gVYANz1cJEu6L/volzxKj1/8NrZQodLZyfdkUUSbM?=
 =?us-ascii?Q?lHMZtHehtHVsLIB58rlHHdzro3cWsiT2BUo/QUhS4BO6REcTXB8WGFUk/eOg?=
 =?us-ascii?Q?vgt2nCy1UyqGjC5uKqh37PuVcWfUMKMvoRCyAgR9So5PmXBNYDcoXs2gNt/O?=
 =?us-ascii?Q?e4JP5Mgs0i1pVbmqhbv2tnJkfHME9iO2jhxTKAlpR9Ryf2V/NW3RZkiKCPKa?=
 =?us-ascii?Q?ctwBrAyNyK8GJuVB6Iw2E7Iwhok9vPLl+q1BbvrPkX/vHploTaxTEQXGGb36?=
 =?us-ascii?Q?bG/g0eZnINOmjxM+2rPdM5b6rNNgQUPceb1tvzMrvowSFy6Y+h+oaF4fzyHa?=
 =?us-ascii?Q?g//lX9BOU4o7O7VNlO/6asa1XX/U7jYlFQSgJmMwVPHuXmdnQhvbjjn1CPCY?=
 =?us-ascii?Q?xrbtzejBJPNXNI209k/aHXp0cJInSPMl3MbYNl5OBHyd6rptQaoH6vgqWupr?=
 =?us-ascii?Q?XYTYFHgG2eN3KSnKfcIAWhD8Yl/eQTyYSOiqv3/CGkJaQcqjoI28bNxX3BCy?=
 =?us-ascii?Q?f378tDZeyfT65b64uPiwzs6IOQGLyk9tPts3jE8Vv4NB3JMA5CCY2fJrsx7X?=
 =?us-ascii?Q?Sit5PSnLX8M6E6PQT5KBvsP1gxNkSmHiM4aIovIB0iJ8vp1DqyUiuzC5ANCw?=
 =?us-ascii?Q?65CBfRhZnGZ1WcDsI66Wcd1eXmqGsPWyZ09weLd9XLqPuVFRURM2xO0mlxs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c982bd76-993b-47c3-73e7-08dd5a6746b4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:22:58.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5560

internal-PHY-to-PHY CPU link is a common/demo design in IPQ50xx platform,
since it only has a SGMII/SGMII+ link and a MDI link.

For DSA, CPU tag is the only requirement. Fortunately, qca8337 can enable
it on any port. So it's ok to trust a internal-PHY-to-PHY link as a CPU
link.

Ziyang Huang (2):
  net: dsa: qca8k: support internal-PHY-to-PHY CPU link
  dt-bindings: net: dsa: qca8k: add internal-PHY-to-PHY CPU link example

 Documentation/devicetree/bindings/net/dsa/qca8k.yaml |  7 +++++--
 drivers/net/dsa/qca/qca8k-8xxx.c                     | 12 +++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.40.1


