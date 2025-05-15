Return-Path: <netdev+bounces-190649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B392AAB8135
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82CB3B7EF0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4C1F461A;
	Thu, 15 May 2025 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="PFBFJwVC";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="uypIGHl4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B21ADFFE;
	Thu, 15 May 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.141.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298591; cv=fail; b=fDUApXSGDnWN99B+UAdYcC5KakVsFF3t7R/5yHt37XESdtbvY5C1F58ANXifkOOvownuiEHMZksMoMyY4Q1bG4pEAyDJyCePoPZWVeVvRe0U2CR601GbsoZRhd6FPuf/hXIi9fIzgw2otwZsgwBq3GCA/Ba31ig7LTkHJboMbsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298591; c=relaxed/simple;
	bh=vJpRvm4+tPgg/2N5/dF60vBBquUPSesOzIMP4ljl43o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mArGQT6tRf4uZenPTl+ZAfLs5sAWrPuEKTbaJwRDFB+bkHJtYCDdz/KJSR8FcJt2LjTgaczs/tGDcUDKMd+/aBjnKyCi27rzaVRbe8Xs/KvPqktbCjiKk/QunUIkhjjqje6PVneQfYdyWKtDwmrV53ktKFOsDB1SjVVV9mzNc70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=PFBFJwVC; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=uypIGHl4; arc=fail smtp.client-ip=148.163.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Received: from pps.filterd (m0462408.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F0n2ri032056;
	Thu, 15 May 2025 16:34:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=7SN+SNIKFdSVL7UVAP23u/P
	KSvmzjB5aSVkfltnEYGI=; b=PFBFJwVCc5Vh+rhl0tcvmtdnktf2mAtDXm9goGH
	fhWi3MrRJsZSijL/2bFAqKE991n6YanouBE5MWRge3lLFxGdMS32g2zYjenay29M
	BhrWNLUQ5w1IDMd/po3f+hBPlP5J2zXvFHGqdzygc84D84luBb+mQFepHHyEahzT
	6juImcchhBKUg330Uyqiu/farEIR8LHIlYh9i1zF7SYWnyDWsFPUNMC1zn/1TSW7
	lRQFUFuYGFT1ZJjarsZFLqa7sPymNeCztfoD4dLTR7gya/EgJ9Zk525RUtKgttzo
	ciHzAILil9SQ5R15PgSKcF4JTZCDbyXtPOp+n5Ilc3nQ2Rg==
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazlp17012053.outbound.protection.outlook.com [40.93.130.53])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 46mbdft554-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:34:58 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uafmdsS2/O1n6QNBMF2CYYyTVa+1D4zrdHHn2xrAJSpH9y9TEfw63yBuvFbJrtBb+LX8IFAK/owQHMdipSO79WJnHIuQdmbXKfYw7q88o6U9HiVoz8sTsnw+IxF6Gbka257NV2lD2tA7eu4o/FjaDNt7P74ZGycqZ33rnWHr4vAdiEPB6ju+7iRbXPk4NtBqeNhGqTsj6JZtwv7XpOq8CSlbUyE4nKxTMCUfyF/uNoDegQOQOIi/hOObYNDvqiQQY+64t4yLHI5WKHTEIPDx1tno1g85hWtWFui1slp76h6Nh8YPYz3dwoJylsb5fvMZWtfsVY23CUM+csUyfukqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SN+SNIKFdSVL7UVAP23u/PKSvmzjB5aSVkfltnEYGI=;
 b=VoIOOxCXdLyuEjNs/jzWN9tg/3ejTg3tVYNFbF/UDFblIeccwmVZPfinIz2VY2Kc91Jn/BLL3D0YEJjI+QPllZQrKJ4dM96tk2PX2gglsVI2N+DFAUPajXcYllXdAb4HBuPd5k4mLOEbA+2180Dixd5yXj30oCjj/pfNKyKJDVLaKJE4goF75HUBh2g7tji0HAm1w5WxpBtHYPIjdGHWLMASbUF9mVQ3UNaHHa6eL+twk+VTsNvSSvYT0eQfoMImgF3CRJOC2BpFJ0is0TaS9G8VPWaL8xAgESz3V+w8reIUlaGyw1HH2VicwT+sDxUqyT9fAaNrz4+VGMTpSDzCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SN+SNIKFdSVL7UVAP23u/PKSvmzjB5aSVkfltnEYGI=;
 b=uypIGHl4zmlHiFE9+fi+z8m5kTxJzLbsfbM2vFXUCejTKL1giIvQfHzf9RpW77ECI3FjwH/2v2DCikeQsAvZHi7LJKnKAzkcGYXQGR9Lz3w4CMgJOSMlmTplZfQfs5gnAAPfXLPp0ln6GlnoYIZ9GeYiLs+c3nLJDp8VR5z4W11tHqWsdAlv2cmweEoQb8c58EE4q84B6otJadZQXZsKCTiuciiVs6+IK22pvE0zj/fGdmFF+8FDBv9YvpTDaGAkKWq3xDMNjj+i6g26XIcNcIyPQd2X21LdAk5Jtx2AkUH/yr/3w5HkpOL8ugpyiEG/K5ty5nYGcQ4sLCcsDfc2tg==
Received: from SG2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:4:188::16)
 by SEZPR04MB8311.apcprd04.prod.outlook.com (2603:1096:101:24a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 08:34:53 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::7b) by SG2PR02CA0136.outlook.office365.com
 (2603:1096:4:188::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 08:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025
 08:34:52 +0000
From: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
To: patrick@stwcx.xyz, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Paul Fertser <fercerpav@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jerry C Chen <Jerry_C_Chen@wiwynn.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Date: Thu, 15 May 2025 16:34:47 +0800
Message-Id: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEZPR04MB8311:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0a656e2-abce-4657-d4dc-08dd938b5d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HCDqrA8VkDDih356Y/ZzIS+gOTcG8TsH9ZVFwqGreTJPI+agTvIBZ8b/3XC?=
 =?us-ascii?Q?ygxx82sv0Ctd3L7kcREry/cXxfOjK5ifEXX0l+MEFLTMrOMcYjjGBH2UoX2p?=
 =?us-ascii?Q?1rUGJ7KO9INCFnHfFLQnVIhMXXXh+ObT8o76YPkyMHr3smsz0ISbozr8R8k+?=
 =?us-ascii?Q?77cerBt3+tBuGuQxwCx1o3Oe/qR/rFQPhZqImPZn2j7btUHawXwiQR0y8fqD?=
 =?us-ascii?Q?WPa/N1PTCRCUOf9i4Shf1SDHgEnaJWVumO/DP+xQMftRVTXIbED5ryxYY1iU?=
 =?us-ascii?Q?bmFMBq9Y6MyLmhHO2sg4OMdLTUoq5Mo7i8iQf3zuCk6CwXtnYy3OdEG0jgs2?=
 =?us-ascii?Q?aFvD5xt/whPdmoQkqhxmuLMV1DwXsa9XExVtjNU6Rro2RyRSqRXRg8cBYGXu?=
 =?us-ascii?Q?BnWeTFtWZ2q7fXoPCYGRVSYOP6CdWS2iBCrCXlaKqMNCP9az600XwKESX92K?=
 =?us-ascii?Q?+hNEFT5gLiezQOF/CRgedu6MldQ5tQQY1ccCrmk34KT+StRrprGu5CYGklZQ?=
 =?us-ascii?Q?uBHzCUXJmZdJJZ2ixwINrJ0ZQJqwEuFwzMgdMkC84fDPT/N4qODlo6sk36gD?=
 =?us-ascii?Q?7of2UIMk6oUKBdKNhMMeQ21VTp/HLdbh0ignS/Ks4cXlA/ATCBC6fvhpduV7?=
 =?us-ascii?Q?J9EyJAkLs12HYAsvTFylHbsMs7q1Lqn+vn7fgHpeSZHj1p9HcC2btSm7XOOx?=
 =?us-ascii?Q?a87WY8EfrdvERZjL+HAwMOSzNdkHOyVkK1m/qDPgoLePrOoq/Uw/2KSakNq9?=
 =?us-ascii?Q?K549h0bn8VcYFGXR53Yfn0VyHqirj9O1/Q02LuNshErciL8lytquRSFcijee?=
 =?us-ascii?Q?zyt20zz6SuILW47rHsmRw1AmIa36XMzqU77noc/sQ+YnnYWtPcksW3DUUPea?=
 =?us-ascii?Q?fcXy83MsiT5AQ4O+qEy7IE/FAamUL7DxyNj8OmHG1GQwhBJC4Emh7D1xMB4/?=
 =?us-ascii?Q?miNmVezNc9TFbpuKtdN0lCAjNujQ9pwHiBZ8O4Y1YpxeQwpC83rsU4eWQKND?=
 =?us-ascii?Q?QQhFvY5+Xd+N83h16uwgbywgyPsQP3R5SE/Jh5+RkBTqAJ7Zz2FsdAmVS7EE?=
 =?us-ascii?Q?x15VgjVkGVyiBExsrDucwiyXBBg6cZGyBx6a/ulCQZciw8vekVCgeNcOdgm+?=
 =?us-ascii?Q?ervqLjeJSPF0wISEE23aVpiTwadW2liafB+j4MYS8mNOZkJEC4TkzXP8B6VK?=
 =?us-ascii?Q?5fz48TRlxsJhcf0ZwfTTSpmCzairab2HVz32yzo9CZjw27gJmEjLi94jjmfL?=
 =?us-ascii?Q?Z46Tyf13LZsG7njy4s0YWtXga0cwOyRU2glpsxxFESmsn4BoN/cKBg1Ka7zZ?=
 =?us-ascii?Q?vgw6bKP7uZ8qcC9rQ66kegjV7EXIfcM4f6UW6TIRfuJGOJPlHx8vkVbhilXt?=
 =?us-ascii?Q?P3kGuOzOkwINB1vVZk/QY2pNQvNsOFvNlmObi7/+Jsumd7vtxFjlu4t1pMgW?=
 =?us-ascii?Q?NOYASqTzvd8wpuR1144BwY7A6jHf9L/rrhiV6vqcotXnKr4sPYtJUX54roLS?=
 =?us-ascii?Q?Dm4kaQGQxVWPMLF15qbnAcTU875HGPjVq5eQ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HsPB8NQz39psWokusZMnNpWIX+jB89rLYcyd61W40zrxZXWWm164YEH1olbkSV2sLqwnxAiY4sWHgG10oTeSakytebFTwyAJRxHeXUFMxMKL0sSHRO33aDuyaHMGRC/DXxdVaeDwj9EVFaOggRbhH3yAAROnVgFnA7b3MmXBxmK7q+qjssBFdLMRVHQxtOYkfgsumkRu9dIkhU+QddKKPsoBjKwTSMC7+BQTCbH8H0e/AOgWbKCQ+eRHkCYWb98FuMMnRwCYWABRDyZlld41x1Bl5vMHznbMvyL2t2OYYycIxKREtPeAqCaHQbRAbGqFUVvYnwkQfgSkdaDBWqhMhuHLniYsEsBw+L3/+mJWYFFr3Q7fANgU0qJFSASUbOmHWVmAbFaE4e6MM1a0P2Uv1LisdfNdDKMIBaE3wdIe7UhZRkwlWs4tc/7XOxLqtDrCfqS5Ex5pb/KouHycc9DzbXoGjlaGbBPoXfYkE5uBLGC23ZlYs1v98pwnEswtXuxNNyaW9RN+L5dSxsEKnalw6jBWdFhZaJ/u1/ULWQclfk6JubFkTioI5Pn3Id892sDkGRsV7yXCt24QyR1Yj5blLRh+1az054O8ZGoHGh08d8jo6OavR97OOzl8V0egHZsy
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:34:52.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a656e2-abce-4657-d4dc-08dd938b5d55
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8311
X-Authority-Analysis: v=2.4 cv=HvV2G1TS c=1 sm=1 tr=0 ts=6825a732 cx=c_pps a=1dhF/aCiZyYTsCmGNFLrlQ==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=dt9VzEwgFbYA:10 a=4AL28aEVfeMA:10 a=cPYzWk29AAAA:8
 a=3vZ3Hx-D3aiqhd03gzUA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-ORIG-GUID: LHzPvPDlTdw8pnfGegfNeVCGU64A794A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA4MyBTYWx0ZWRfXwjYPB3N/7VP7 dXG6y6ItryJhpygM+nuJKKGnmQ6H8HPcXVqksUXJqTBz8r/bDuLSPTzfgy2EH/ZkfSy5FvNX36h 7kaySG7UEwetX6/MPraXXBf7oEO3If0QlCUspNmpxvG4IFpZYnhfSoH3fV90jJrUWZbNAGfNokL
 6JbpD6sPr/LTZBU5SFKJ3L/BY0ExwsA86c1AG5pMoZffvvTjeihn4Ryu9QpEyw0NicJMsRYSBao xOZhnsu6cSEGz4P+/W8v/uwYF+m6gf42iez6dDwpe7CGb4yu961BuA5AKc5Dz8YUsVgKBd01tyo 4ZD4pqqnuie26Q8E/rsjH69LwdTMZk28ghH5nhi+bh5OgMPPX9O+fVZZSBVlXd/hJNu/y0YhL27 cUpa2uLw
X-Proofpoint-GUID: LHzPvPDlTdw8pnfGegfNeVCGU64A794A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505070000 definitions=main-2505150083

In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
need to be null terminated while its size occupies the full size
of the field. Fix the buffer overflow issue by adding one
additional byte for null terminator.

Signed-off-by: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
---
 net/ncsi/internal.h | 2 +-
 net/ncsi/ncsi-rsp.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c260f33b55c..ad1f671ffc37 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -110,7 +110,7 @@ struct ncsi_channel_version {
        u8   update;            /* NCSI version update */
        char alpha1;            /* NCSI version alpha1 */
        char alpha2;            /* NCSI version alpha2 */
-       u8  fw_name[12];        /* Firmware name string                */
+       u8  fw_name[12 + 1];    /* Firmware name string                */
        u32 fw_version;         /* Firmware version                   */
        u16 pci_ids[4];         /* PCI identification                 */
        u32 mf_id;              /* Manufacture ID                     */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 8668888c5a2f..d5ed80731e89 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -775,6 +775,7 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr=
)
        ncv->alpha1 =3D rsp->alpha1;
        ncv->alpha2 =3D rsp->alpha2;
        memcpy(ncv->fw_name, rsp->fw_name, 12);
+       ncv->fw_name[12] =3D '\0';
        ncv->fw_version =3D ntohl(rsp->fw_version);
        for (i =3D 0; i < ARRAY_SIZE(ncv->pci_ids); i++)
                ncv->pci_ids[i] =3D ntohs(rsp->pci_ids[i]);
--
2.25.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.

