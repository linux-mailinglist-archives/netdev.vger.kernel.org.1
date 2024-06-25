Return-Path: <netdev+bounces-106630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1991709C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C91C22234
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8A17C7DE;
	Tue, 25 Jun 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RQCHxK/t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88817C23D;
	Tue, 25 Jun 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341630; cv=fail; b=RBg7HFMWIlpdkaYdIxOqxfSArO1Ro4vHi5oXbHNldS/yquQRrgSLc7J2+DiHDNiKAI+XnZ2cQn8Tn3KmsMwgaxAcvFZFls3QtInDaiQpuFHLO5FUGdC/bBHgjnC3Cq8cZVjhOEjZ+QFWpy4AXEHYNaFfZbvynU+/0m5dwJEb0Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341630; c=relaxed/simple;
	bh=+6n7XMOZw6uKbqbz/+NGjek1tKGEGd7c1pOvVl8S+GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jw4gUFBuspD1DeqX0X9OvbmU/gmuX+j/1ahyLnq1CRtNPkT/4yUW3OA+i9DMxoxAXfc3KsfwXUINcM1VU6t/tBd9vzGUceXN462yYgIxi1c4AAtLLknzVkw4eBc+8lhXVFsiGSdGs2ZG9ibz4vv3hCK5arJuz3g7O55EI7FI+Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RQCHxK/t; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFlJK1A0URSs14lRQ6vbdHRDBLmP8WisQD7P349xpxGZ9CuvnV56mlEz1WLi3SpSXg9zrMSnHjsIRoSIsnDqt+iVo8kvZXNdngXjeArN2X8idVjQBNY/Mf2PryQEprZLh2G0LJ0vFr6P9/RqUkH9h640KPpBGcX56YeU1hCuvn59IOESOd5XkyEibL+XlmwEprSo3Ww0qWmyC1SUCYVGz1lVOGvG/wTV/OpSQplHHddCL25HUCJBuoHhotx0dA3EEhX+otxzND5A1bx79MSqnCnfzUShTvGq89oah45EXD1mc7q+7hI157OIjCB+sPZYcfDQUfkhJ021WnRQLCjSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q29wiy5+HBvTfdWDl7GntSBgtThBvZwXKEfvGZCKocI=;
 b=f+BD1gHS8cYVROPvfGdJySotCfaAgtYX2xTBELVPnhK9oQZUu+flrAmhjNU+6BH0TchGHcD09YSLPbdGM5cVnc/CyLwk5m0+cLe7GoZZZh0asrAopZP4Y/qocGBz1j3/ESeWqjtmhp7YYXa48hphIfrG5Tsc0TK/qLyYEH6jjYgm3kPCLc66Wurapa6zLOHKL9UuCoL+VASq9SNeBvecwuEiAexiSX7ThGheHq7UlcJe5ukyo9sqxkP8V+fcJ3wutiZgeMLpP7oQ764hGywXntqbTq5HGgQ/PxilvWlPJqnNju99HKxlVzpgHz4RoSYX6I+axRLMli/vf9AvRNul6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q29wiy5+HBvTfdWDl7GntSBgtThBvZwXKEfvGZCKocI=;
 b=RQCHxK/tDLvwzJRksEJXQhZ3izJzIkI2lKyX0QFyNgDAIiRgq9zM1ZQmkUWHSwakRszn1YoY9EMQuJCZrZPijT9nO/dlnpIVgkeWotDu08H6FRVfMynBP106NBDzVhU+x/q7nEyFbiahmXO6w5E0IPWoI1Jm7HTCvuV2ZefN1rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH0PR01MB8070.prod.exchangelabs.com (2603:10b6:510:295::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 18:53:46 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:53:46 +0000
From: admiyo@os.amperecomputing.com
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Tue, 25 Jun 2024 14:53:32 -0400
Message-Id: <20240625185333.23211-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH0PR01MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44a433-9962-48b1-ce83-08dc95482479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2SmlgdSpfu2MT85jVEYqajfi7gd31gnMmlpdeJWjtIt5aothuk+G1ZwliFl?=
 =?us-ascii?Q?CU5tgrQd8P2nWvdXQwWQ4BZUUALsL0BI8s254sMwIlLSDTqeKxtUoCkmMVdR?=
 =?us-ascii?Q?CpcFMLXaG5bm8p2OPZYVX83HeGmmdZwNChR0yvqdWAdt7ieB9iNN6ngHDNXf?=
 =?us-ascii?Q?wKECWJQaQHXg3kQ2vvyVjB4EsRtYiC1nCkzWFRRv8EoTHn960m6sS9DiUv6x?=
 =?us-ascii?Q?BvhxSeb+CA4ImQ/kEiaYnopjl2QQ4Lc32TNElsqg6oJyC3JoJjtGWH7GPSzc?=
 =?us-ascii?Q?GES0U2lqmORf5dCW2IXVTW2jTgdcv3iPE2uWj1qaSo0fyiZ1u/MkwH2GqguW?=
 =?us-ascii?Q?AaqoXWEUXLQzJ2PPIGChfYOssBaxCTQuZPfUHxjm2kyU//wqNSeyB+FsrvWF?=
 =?us-ascii?Q?L3TVlieEpe3frlKaK6/OGF3360TSjijqrAXz7pkxxoJKaKFCG0UOCF6/PEvZ?=
 =?us-ascii?Q?By3nYX8sLTupPXlmdd8sxxhDakhqpET/An23SiAszFHc4beVbZHOMlDyNhDs?=
 =?us-ascii?Q?GJbrTzY48uI/8E0anrf41qk7HAIvDRfZYgKfEo47uWp2tidiqvY4H9ATX9zB?=
 =?us-ascii?Q?ggfKjeXuSqBUIGM7zMfPrLNohOXba/M+l1hv18KmW0/XjF9+kg7jr9kkJFSk?=
 =?us-ascii?Q?gbi0/qUw1jC8DE9ZIgZ88VCtIdSFFJFnPOGgJSaUeAeZeaIIYIwy5swNiO7/?=
 =?us-ascii?Q?6j3InG/4nNe2Ks2FGkMwGJpZN9LSFFqlrYtRpP3mbUZhI5BxRPvzK5pftMrk?=
 =?us-ascii?Q?S56hgjtdjkbKO7Navru+zX7AsVO+vSFRTQHrEf4TroYk4cGH/A8UjAZS4qqR?=
 =?us-ascii?Q?IMG+E3F2y+nMUfW8wwMQrwUYtltb16eCi3NhxceMWBJQO2RYiyAr1Td/idtG?=
 =?us-ascii?Q?yon/y9xsl0mNF3xjguefjyNEuTDGt0Fw8cxN6jQiPhfnvwkmnu/wcF2LSLX6?=
 =?us-ascii?Q?J+zDZDpWxjJPGILcexncjqTCP/G4wiZ/e7VCcqUYMOc8AljsH8zU66SBrEmy?=
 =?us-ascii?Q?flOWsUOZtXD/I/UUdCmZdgF+opT61iItNbuekhSgnhg9l2wrf56mBugjn2Nd?=
 =?us-ascii?Q?umj69lKC20Pc6nftaFnA8dnZkfGyvgtfOhHbdgFUTOkDdGAsmN43SYzhvWFk?=
 =?us-ascii?Q?DMEK0ls4Mtq0SvWKS2oCk5HtM3YSjJJ8C1yrzpnBjmRC0bmJ5KszHecGd1wK?=
 =?us-ascii?Q?osoFugLTGin9Turx3kN+Lt/7H9f4myUJo4QvsvxsfR1ECI0Zx7iaUHSkacWl?=
 =?us-ascii?Q?FDM2Qm47Z7hAHKC30s8Mf4Pfm6CCb+s8XSnLgm7G/s/yksEi6xbxRibxgEQ9?=
 =?us-ascii?Q?VBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIfdUVqksYsjPrcx75ZCI4PtT4YaQjQyL5cXjWa8h2k2hOqez7JnvU5yRJh3?=
 =?us-ascii?Q?aoyByVDO0Oiqgt2pZjj6l7HsuLcub0t56OvXT6P/Ms7uSoBleZ025mtCGfcL?=
 =?us-ascii?Q?w1JL+AGUrjy7zrq3HwnnI3wpobcMt34Ex5uunUmUHzUEmhlfz+mO2cYIGMoJ?=
 =?us-ascii?Q?TxjUCGTg39iJEJDNfXgvdR8ivaZlXWkw3DhqmkqolHMJsh7ZBDkl0f41cLFr?=
 =?us-ascii?Q?KYGCimyurAZAoMlV77JIo9cSHhLM+Mx20YpRjdtg+aeVtn7Fulrz6oCFIahe?=
 =?us-ascii?Q?g01yhm2cntrtyydfabZmoDuGo4iiXYv6sCQwIPESR7cF3FDZrKQ78YEYzX2V?=
 =?us-ascii?Q?vC8Nn/QrmIcLh1S4bl+ePd/tA4Gs/bD9M/kQcg3DSgxg3mf3k6FIatNJj1/9?=
 =?us-ascii?Q?bGY/35OX/Xk6WgnEw8H9X7O4jUK2Qz1csTYz1xELWiaC0/X5YAE6OnfESpoo?=
 =?us-ascii?Q?qzspnrnHvVBNJBrg2N/2ke4nimC+udMxz98kJcGo35GVvn+8iIjpJb5rJGFT?=
 =?us-ascii?Q?leeP/CvjGEWEZ/qU4suWg4y77QpTaifidqgWVqpV4oDdFnrAusHO47SJ8C+k?=
 =?us-ascii?Q?IOSaecYuaGK+WL4WTjzqgJCQeozC8qd3ZcMQK+9DMQ8IcMAGQoDrS1oX9Op7?=
 =?us-ascii?Q?E75j1HHkRtaRCQl8pKNGWC9rghLaNOhxkgFrSX3S5u1P1ubYHA9Hemze8guK?=
 =?us-ascii?Q?TfDr2J5xK3RlU6MjiuApbinSm/6MLyRfkvOv3zIj1l6Cow9LjQMAmA6t9SZx?=
 =?us-ascii?Q?7IzoPgaZQrb8Y1OUkrinkRe+h/NLCX/2dMM/jPF893mMHGiZyh2wkziJm6ys?=
 =?us-ascii?Q?8EO3gW2X9nQ9+n+2KbMw7t9s10esQR6c2wk5U1zxngltPhzKZesdCoEBz3sN?=
 =?us-ascii?Q?QqmWTksB1l3OO2eL4inkUdNvC9ZyJM6pVOFZjjsOF5GRSvAvpHRS80gbYjLa?=
 =?us-ascii?Q?dQPT27nM6EvYL/MQ6pmiHgaXSdZmcUCNb5jLBdiGJGJ6k14KnGA7xW7KO0dM?=
 =?us-ascii?Q?sOm4tabqbMiu+0s3X+wbrmA5w2P7UtRbdR5X1XCzYSdL6teTWDizbTNhhA30?=
 =?us-ascii?Q?JjsRahbuWyRQ1loZQRh27xKZ4iT8WUvoSaK8NX7FhQeJjlE8poHNnxbh5kBm?=
 =?us-ascii?Q?6y3WPT9dpMlVbONsLgVhvn0NBL/8Od4RYf+ZtEuUHpu13WBQe2mUg9OuDn4o?=
 =?us-ascii?Q?7KL2+1huWb18dIMniaPrm+sK1aoTyWD9sF82Iwi2Ed4bFyZCGvajT8iRmDZb?=
 =?us-ascii?Q?BZUiXr5tbTdzKDCbFJtr4PUNHEMi/pqyplJ7QAn4F1FZGqasOBLsQmiHW5Kr?=
 =?us-ascii?Q?yzgCnNp+EjYUG/v8KVcWw8ewD/FB7wLkmMeXyUVBDOfh1rOogaoHpSEOxZnb?=
 =?us-ascii?Q?sa49q19xqYvgx6aiJb0Q41d21I60jsd2UGJNMziwWqiihC2IHUwIPepsrmxR?=
 =?us-ascii?Q?vlda63dlEmkeWZWCkjyL71ZoTcTI49BlfnFtateKv8qbI+1fJR+AETPNrqRz?=
 =?us-ascii?Q?uVGryhVLtJT7X6Ss3ayjDSS3yaTZkPagqX3E2LfVe3lR2IrkLn4Re5gyYbpj?=
 =?us-ascii?Q?JPwS4ZSQ1Bd39o/FvubomtSyZTzRow2GHbipi5byT6p+Ay8sjKus2Ov7nvv3?=
 =?us-ascii?Q?x84R+Zs3o23mZewPPBm0Z9kf4jYOVkjE7sKG+bUfaLokU7090807NQz8Dmpj?=
 =?us-ascii?Q?euuYMJMB6Mnra0TrhUEz32T7wNM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44a433-9962-48b1-ce83-08dc95482479
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:53:46.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2BCh/5cyQUKwK7mKD+95ttkm8tBboZu00qfKAChIaX6uf4QYIpQimDgEGS/FLnTw2TMv//8EXkL/Xqv+mg6ovK16L4+TK5EXy1N9fyqm5Uh3U+qLRJjB+P2DVGm/QdM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8070

From: Adam Young <admiyo@amperecomputing.com>

Note that this patch is for code that will be merged
in via ACPICA changes.  The corresponding patch in ACPCA
has already merged. Thus, no changes can be made to this patch.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/acpi/acpica/rsaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index fff48001d7ef..7932c2a6ddde 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
+	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 0x0A)) {
 		return (FALSE);
 	}
 
-- 
2.34.1


