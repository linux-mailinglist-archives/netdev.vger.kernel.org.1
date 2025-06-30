Return-Path: <netdev+bounces-202679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C116EAEE981
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7FE189D0AD
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719D23BD02;
	Mon, 30 Jun 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ba8grLwy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAB2264BB;
	Mon, 30 Jun 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319490; cv=fail; b=LMNbE2vlv7yBls0Sn2E3WjD2wtT5UYDL5xOWgjlJmQSbjITSZFMHb131p3IziXktvCeqjHzJRpFb3D5HfvHJLK6JKWIP+Al6e/80H/RD1MD3EYUGkLcm3b4+cT8hztHt8w3BIA9UJvepwbN1VexKMBD21TND6K/QGHFz7RdohI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319490; c=relaxed/simple;
	bh=8cQtd66C0jtBDe9JUsphXVedQ1aP0/1MkJzRPyKMljM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jSCvKjX8U7ojjgesCKV8VMhorTDEmO5QbdanSqCA020CL6lq1JyIPqduLfFbkKqyxdPbNBvE6cRygtBzoO55XTpEaHuGXrIMvu3NuJmrn2q2KX01dVhDvq9vjNwksI7ngCWORarzcO4c7mbFrGckTA+Ba7K8n/xcfKG/X+XDg3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ba8grLwy; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/RkG8cwJtyoICZZOBx33Wz3pNywbstFvrYAy9oPoy+8aU93m+hkTHBPwMD2Bwhspn0bI0pfrvCq0lRMgcLeYrT+8aV05SZvNmnG9JbQR8VTWucV0QkY1p5DevxGQwP2JqNH8suF/dEf9ye3FNkGYdGiFsJFBM1/PSlluL2xciyGZQiNF9dRIWz/404okkQ4zoRMkAEB4OR8lhH0gU4X71wZwNeInEBZi9rpyw9rz+GI/WmftqF7GhoYkezPZ2HwfpZOKxSbiMJn11SnvANrmnxY5h4x9IUBiyyViymKj60gN93B9rL1b+Gir7YIaF8j2CFSkZfdgP0XVdWmL556xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/066QfUFMX38A8Is0vEMKspJKbl4z3H978XM+wR8KA=;
 b=kUQdPP489HdD4bo3BRMH1nks5VtyZxBMKA02DpO3ttQyzrf0lg08NRrqEYP0T0YgkAiYb/kWdgMSgtfx+eFBaVB1+BH18oVu2OU34+nIYw42f1jqGVy4C1Z/GcQCyaRvNqzd2twiioDYKj8SZ/IBWr2N4JRXy+9O0BzHPNvpQFP5XREAcy2GDBZPzKlY06gGXKAGlmjfUHp7B5J51t4Gr69YVTZkOYTPF2ntKmlwYJ/owgoPfWQgvJwCu/jfFQvpf5IXzkE9j3/IElG07aDfRQ+2+mDaxuIs10jOcw1MR2IpxRhv9BC/FtFnf+h9R1aMMMHo60BxZzmyMB/ELTwBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/066QfUFMX38A8Is0vEMKspJKbl4z3H978XM+wR8KA=;
 b=Ba8grLwyhNzZ9Hh43XME5BJv6gcASsgwKoSQIHe4xlY//RVmNzMPXgZWLqZuS1E8Coe3lJMIxXfkhunmWiQD9Guuc+KG245XzOMDFxsVZLljByTMcAzgtXu/eLnVVwosvG3EayjxTmMREBeiEY4HCUJgDMkCQxYsN2dx+5nJ8vAfd/B78K1XRwzRfyeIH8gzOB1e+H1WJpmly7qLb7O1YbwuWtNbHruATC3JtXIlnfSRgpPOa8FeuOXKCCY8RnWmNnlabp6Ta4YV1CZYdezQTt7UQNdt6cPwBnz4x3dTfvKLdWxu/l49v72a6IS2bM/Y/K0h5E3i1hwKZVJXN9Gc6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA3PR03MB7234.namprd03.prod.outlook.com (2603:10b6:806:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 21:38:06 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 21:38:06 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: [PATCH v7] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Mon, 30 Jun 2025 14:37:48 -0700
Message-ID: <20250630213748.71919-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA3PR03MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 894e51ad-c989-4c87-ca52-08ddb81e662b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XKDnwhT/wDBc7Ss9ebIwXUU4sdhLplRwIXLQoUriHeaZh6mLRGFuR3f+D1Ml?=
 =?us-ascii?Q?O9mffj0N3aMaabg5y5nJE17S+vHRkDeSO3nnDPsCB/o1gBCPV3/yGkmUndTH?=
 =?us-ascii?Q?lbER6mhWRwN32AVT6FwYdcKN5jXNE5GEGQ3S6ho2RrkHTAlDhW7kNJvkFi7f?=
 =?us-ascii?Q?xgmurxnmJSJi/jvq4dC30zTFY4fT2iw1L0/ZHiUsR0lgU7or+1UvUwWXRYJK?=
 =?us-ascii?Q?+qqI7sqM8jm2mqnui8H6HyfpZQWoblBmHA7miMGAW9nO+G3ZLTANgV2yTgi2?=
 =?us-ascii?Q?8qhsRsYjvZAsbAsPVpRU5wRHJ2l815+48kZQQmPkJRWzPYKgzRPkDnI0bnU+?=
 =?us-ascii?Q?yPvYMyQMcsvnjU6gQlDIdzyDilpxx44V1Fak78zhyN0ZjZxD8/18EKla8YFQ?=
 =?us-ascii?Q?HVZn1DgxcB34Tj92adslTAOqyugWta9Dp1tz8PzcqNTED4FPWk0yyaDf1J3h?=
 =?us-ascii?Q?Pm/g7MJeQTCAU8YQDe+fzHP7bpUYysyBVAtCR/I7QaSnXttQfISNreOOlC7i?=
 =?us-ascii?Q?d5AejwWJ/NFU8AcXVMY34YbXjVTSRrbp5BuyXuThswdP9WSqG/8E9DVd/Fvh?=
 =?us-ascii?Q?xKkkA7PCdJMtXPnU/c6y0MNlwkwWz91uU92P5WzqZ/IhNWdH5Q2y/h7onwIA?=
 =?us-ascii?Q?etE2qwhHEadEVASAbOBpfeB6NQM8ipKLmIcgq3kSExnKDCcpwxrYBakym3cz?=
 =?us-ascii?Q?lrwPSKqcQL7KVju1rBHnRznS8gAJTklkwI076qq89FfWgE/UapyMDWmwojQ8?=
 =?us-ascii?Q?Xtftbzk42v2vF4lFwnue+k9hHOVVRi/E/zIFBZXp/czk3yBee+7zPKBJl94N?=
 =?us-ascii?Q?ZKYEEPXxY7HOVkfPqZjYHHW8ifNB1x3lsXDxLLjHuPmW4qvC72l5T6AVRBjr?=
 =?us-ascii?Q?sZ79A6BVjpW5daGFPLAip0OYYclZkSmllyPrSKCtb36UyyXzX0XcwVGfFoxF?=
 =?us-ascii?Q?zWltZK83n5bQEN29/Zz2G5yZTyUMPGexvKhDmECRXoVL6BQwqeNFBFlQ7DK2?=
 =?us-ascii?Q?SZX29wXPASBLGLlCO6WFYJjK1CQIxTXp9yQZK4qQGChod9dSfgaf3wBDQurm?=
 =?us-ascii?Q?w98eoWqOe4Do/9KQFpljcURj2mxayX+uWy25N/oeZoKxYTejffu6ZEgf5Uwq?=
 =?us-ascii?Q?4EkfEcLAZAheqN/WTsUVXvSH2R/eB6I8RzXTbtCtCjelSZHAOdszX1GGgnqs?=
 =?us-ascii?Q?pLAjnGZdUf60bE3jZbDRNddZoLflusJHsoRBow+aE41C7+Ag9oZYq4n4U3V5?=
 =?us-ascii?Q?0hzUCIipPBXNQP32e8uzC5KsxYOJkhu49gTucVkLTA7Z0bEaCATs0HHAvv2Z?=
 =?us-ascii?Q?hooDG3lVay33J4KQ3/iUE3b5QMEm/WhXatWiRdjJ3GkC1RYHI49adEOpeo+2?=
 =?us-ascii?Q?frbhtzzDzaXEwX0Re0ufyaSGVns2/bT5kg8mcT3Rti0cXARHOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxPn4Db47tOEBOthuCEzbtMJJke7V5Yg9TOG7J5NGQaQoA3rocByaKOZ0Co3?=
 =?us-ascii?Q?jvEyUe6+dv7tk3xsKWvsLvESaUiBVdx/8WMhu+H414fdETgAoas6rDizUify?=
 =?us-ascii?Q?19YvgID/ABlkIEw3XH4iBLqCymvIfOhNWjjaAwpfbe/wed2sylNdy+RuAwBN?=
 =?us-ascii?Q?nI3aEkGZUyQQlUpY6l+s4vIMYy0sei8iVw+R2a/xOeXRlO2AwxyfspyHMr+l?=
 =?us-ascii?Q?JNgoSaJqThMGmEQ+2euIeEy2h9FEkzqdFDqPKFo8ckEKZ0rFqnNQ0X1x0qt7?=
 =?us-ascii?Q?CU87LNbGRDMEdegbCYEDgkJ1w6D+S3IkfZPvwWyWvq8nYnTMUNYKPMjghfYX?=
 =?us-ascii?Q?5J1Im3sQ7Xpu5B27corviD8+5FMAVYTkZgtZVOXi4pbzEXMKW4jVKV8b5tTJ?=
 =?us-ascii?Q?/JLFvZU1FWkv0Nv9Sp90vFs7n2+UXGmZt11gH2uyRNwRPUvuCpyS+LXjxpvW?=
 =?us-ascii?Q?pURjXkOXfJS6LWnzo18WSGrv/601CGXrj1g/3U6MNET7MsgCuUwK2oVUBxyT?=
 =?us-ascii?Q?rtogkva0Z8bCRlfhX1ujzULp3Rn2Ve050xEedfiA1i1FQmQLEbtd8h5MHXCZ?=
 =?us-ascii?Q?E2ppLG/Abgp2cNEodtTrPv2Qm5uQkMY7RDnc6w9RmeBz29aOWKmNJ0w7H3DT?=
 =?us-ascii?Q?fQT/wPqseDPPVbbOwwsKcqKJPUOVN+OG9guXikZZ6J+lgHSeE8oTtLtxLEdI?=
 =?us-ascii?Q?oI1OWeXmopEgxrNcIVeMKU7Cpsn99SjQFG2fakZOOFnfQpi55x2quPOLYzu/?=
 =?us-ascii?Q?3ol2kuFeiwciEqMMn0BZNrrHkX8cd2MqSQNECvSEzkHovdivvCKqDvFr2a5Q?=
 =?us-ascii?Q?SqkBjKdexaqVY1ShJEgTtIKnY3Y9KTQ/Mt6K23MjFi74fDgz0J89RGZS8DhO?=
 =?us-ascii?Q?BVkeqfID1s4VcvdNT6QSM8r1smPIJ8hdB+aR8q3z7eb3OAhRoKf1BXVlU+Jd?=
 =?us-ascii?Q?FZHozER5PoidwhsdkZBM/Onxuc3cqswvm+K2Wk83ys9oOKNZvvxfK617qxEu?=
 =?us-ascii?Q?yd+9LKgIxCQmETiOAx5rVIVpihMqj+K8Oe4CTTIvWi3HcrcUtVVimxaAD93C?=
 =?us-ascii?Q?PyJLGmXeVYSKbYzW3jSSfHXKokI0l5mOdQUcLODZ5JhLXyENHsZI20KyGuJI?=
 =?us-ascii?Q?RneOenQRMT9neZG5190NlzDb78qevZO7zxKuQ1JgzouMRHECSgFLiFepOELQ?=
 =?us-ascii?Q?U+H1g401xaNVGjEe5/FwO30dE4V/Ir5DY5ZigTd4PqJgE2dltnqWNrUVdNAZ?=
 =?us-ascii?Q?L3JaCnUqNNr5ijYXGlsePxWFKHI5rY1RCrsAhjq+9/rnsl2d9f3fTgalVEqr?=
 =?us-ascii?Q?xALlAYwxsjolMhFwUmde6tAh3M1EvkUPNPPI1HVYfOamiYZ5etDs7Ylo0otv?=
 =?us-ascii?Q?PSRPVs/MANrDl9iG+6yQKGcVeOZEOapyCXUVL2VGS+I75Wn85Z+9q4mslvr6?=
 =?us-ascii?Q?/PP115w+7COFnFDJvMgDn7TuKUbjUphL1WAYbs+84B6u/Yt7FdT4VBS/rfbc?=
 =?us-ascii?Q?ZPEWRKTFYh2zBQaiY0yw4CoE4/IkcbsnhRnfDhD1fgb4SHgqMDdbesF16oz+?=
 =?us-ascii?Q?bXCWltqMhPueHdh9b+EnIbtX123aj1Cv7GM3KxHhc90s/9LTJtcqaM/WByTZ?=
 =?us-ascii?Q?XOaK4xPxmrMVXXYQC3MHqbk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894e51ad-c989-4c87-ca52-08ddb81e662b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:38:06.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eedBvS5Z5Zv0m1i4K7dnksEfT/f673ipYywIwGNNk9DAp3hTBhDn4Fhu+qb5WbDtHjygU15LpgYq9M2C9qK/CDkcelby2a0qvAfcu+QaBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7234

Convert the bindings for socfpga-dwmac to yaml. Since the original
text contained descriptions for two separate nodes, two separate
yaml files were created.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v7:
 - Add compatible definition for Arria10.
 - Update iommus to maxItems: 2.

v6:
 - Fix reference to altr,gmii-to-sgmii-2.0.yaml in MAINTAINERS.
 - Add Reviewed-by:

v5:
 - Fix dt_binding_check error: comptabile.
 - Rename altr,gmii-to-sgmii.yaml to altr,gmii-to-sgmii-2.0.yaml

v4:
 - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
 - Updated compatible in select properties and main properties.
 - Fixed clocks so stmmaceth clock is required.
 - Added binding for altr,gmii-to-sgmii.
 - Update MAINTAINERS.

v3:
 - Add missing supported phy-modes.

v2:
 - Add compatible to required.
 - Add descriptions for clocks.
 - Add clock-names.
 - Clean up items: in altr,sysmgr-syscon.
 - Change "additionalProperties: true" to "unevaluatedProperties: false".
 - Add properties needed for "unevaluatedProperties: false".
 - Fix indentation in examples.
 - Drop gmac0: label in examples.
 - Exclude support for Arria10 that is not validating.
---
 .../bindings/net/altr,gmii-to-sgmii-2.0.yaml  |  49 ++++++
 .../bindings/net/altr,socfpga-stmmac.yaml     | 166 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
 MAINTAINERS                                   |   7 +-
 4 files changed, 221 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
new file mode 100644
index 000000000000..aafb6447b6c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii-2.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera GMII to SGMII Converter
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera GMII to SGMII converter.
+
+properties:
+  compatible:
+    const: altr,gmii-to-sgmii-2.0
+
+  reg:
+    items:
+      - description: Registers for the emac splitter IP
+      - description: Registers for the GMII to SGMII converter.
+      - description: Registers for TSE control.
+
+  reg-names:
+    items:
+      - const: hps_emac_interface_splitter_avalon_slave
+      - const: gmii_to_sgmii_adapter_avalon_slave
+      - const: eth_tse_control_port
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    phy@ff000240 {
+        compatible = "altr,gmii-to-sgmii-2.0";
+        reg = <0xff000240 0x00000008>,
+              <0xff000200 0x00000040>,
+              <0xff000250 0x00000008>;
+        reg-names = "hps_emac_interface_splitter_avalon_slave",
+                    "gmii_to_sgmii_adapter_avalon_slave",
+                    "eth_tse_control_port";
+    };
diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
new file mode 100644
index 000000000000..c5d8dfe5b801
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,socfpga-stmmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SoC DWMAC controller
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera SOCFPGA SoC implementation of the
+  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
+  of chips.
+  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
+  # does not validate against net/snps,dwmac.yaml.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - altr,socfpga-stmmac
+          - altr,socfpga-stmmac-a10-s10
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: altr,socfpga-stmmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.72a
+          - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.74a
+          - const: snps,dwmac
+
+  clocks:
+    minItems: 1
+    items:
+      - description: GMAC main clock
+      - description:
+          PTP reference clock. This clock is used for programming the
+          Timestamp Addend Register. If not passed then the system
+          clock will be used and this is fine on some platforms.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  iommus:
+    maxItems: 2
+
+  phy-mode:
+    enum:
+      - gmii
+      - mii
+      - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
+      - sgmii
+      - 1000base-x
+
+  rxc-skew-ps:
+    description: Skew control of RXC pad
+
+  rxd0-skew-ps:
+    description: Skew control of RX data 0 pad
+
+  rxd1-skew-ps:
+    description: Skew control of RX data 1 pad
+
+  rxd2-skew-ps:
+    description: Skew control of RX data 2 pad
+
+  rxd3-skew-ps:
+    description: Skew control of RX data 3 pad
+
+  rxdv-skew-ps:
+    description: Skew control of RX CTL pad
+
+  txc-skew-ps:
+    description: Skew control of TXC pad
+
+  txen-skew-ps:
+    description: Skew control of TXC pad
+
+  altr,emac-splitter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the emac splitter soft IP node if DWMAC
+      controller is connected an emac splitter.
+
+  altr,f2h_ptp_ref_clk:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to Precision Time Protocol reference clock. This clock is
+      common to gmac instances and defaults to osc1.
+
+  altr,gmii-to-sgmii-converter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the gmii to sgmii converter soft IP.
+
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be the phandle to the system manager node that encompass
+      the glue register, the register offset, and the register shift.
+      On Cyclone5/Arria5, the register shift represents the PHY mode
+      bits, while on the Arria10/Stratix10/Agilex platforms, the
+      register shift represents bit for each emac to enable/disable
+      signals from the FPGA fabric to the EMAC modules.
+    items:
+      - items:
+          - description: phandle to the system manager node
+          - description: offset of the control register
+          - description: shift within the control register
+
+patternProperties:
+  "^mdio[0-9]$":
+    type: object
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - altr,sysmgr-syscon
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ethernet@ff700000 {
+            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
+            "snps,dwmac";
+            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
+            reg = <0xff700000 0x2000>;
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "macirq";
+            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+            clocks = <&emac_0_clk>;
+            clock-names = "stmmaceth";
+            phy-mode = "sgmii";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
deleted file mode 100644
index 612a8e8abc88..000000000000
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Altera SOCFPGA SoC DWMAC controller
-
-This is a variant of the dwmac/stmmac driver an inherits all descriptions
-present in Documentation/devicetree/bindings/net/stmmac.txt.
-
-The device node has additional properties:
-
-Required properties:
- - compatible	: For Cyclone5/Arria5 SoCs it should contain
-		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
-		  "altr,socfpga-stmmac-a10-s10".
-		  Along with "snps,dwmac" and any applicable more detailed
-		  designware version numbers documented in stmmac.txt
- - altr,sysmgr-syscon : Should be the phandle to the system manager node that
-   encompasses the glue register, the register offset, and the register shift.
-   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
-   on the Arria10/Stratix10/Agilex platforms, the register shift represents
-   bit for each emac to enable/disable signals from the FPGA fabric to the
-   EMAC modules.
- - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
-   for ptp ref clk. This affects all emacs as the clock is common.
-
-Optional properties:
-altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
-		DWMAC controller is connected emac splitter.
-phy-mode: The phy mode the ethernet operates in
-altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
-
-This device node has additional phandle dependency, the sgmii converter:
-
-Required properties:
- - compatible	: Should be altr,gmii-to-sgmii-2.0
- - reg-names	: Should be "eth_tse_control_port"
-
-Example:
-
-gmii_to_sgmii_converter: phy@100000240 {
-	compatible = "altr,gmii-to-sgmii-2.0";
-	reg = <0x00000001 0x00000240 0x00000008>,
-		<0x00000001 0x00000200 0x00000040>;
-	reg-names = "eth_tse_control_port";
-	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
-	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
-};
-
-gmac0: ethernet@ff700000 {
-	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
-	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-	reg = <0xff700000 0x2000>;
-	interrupts = <0 115 4>;
-	interrupt-names = "macirq";
-	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-	clocks = <&emac_0_clk>;
-	clock-names = "stmmaceth";
-	phy-mode = "sgmii";
-	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a928ae141de..bd64ee852d76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3271,10 +3271,15 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
+F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+
 ARM/SOCFPGA DWMAC GLUE LAYER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-- 
2.35.3


