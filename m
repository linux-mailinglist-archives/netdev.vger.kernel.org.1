Return-Path: <netdev+bounces-106156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17138914FFB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391FB1C21907
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D219AD5B;
	Mon, 24 Jun 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="0fVNBV0Z";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="R13jKv0S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786619AD45;
	Mon, 24 Jun 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239558; cv=fail; b=bwZSVdTe1pnC+GkXsFZyisJXuOjHMN0zpi5Q4nnKx9EruPJ56lvqR8E4t3SvZVMAwEg/LWciMyBsvjj6xrgdhT38j0fFmstgOagJz7c6lIqsEu9xH3Rj9ZHo7vfmJqFYd4iDyz9ylWxKAsSrP+9SS2oVQJ4GabCrQku8yVCMTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239558; c=relaxed/simple;
	bh=5eNjSKjKHQxaTQqdIO0oCqqBBxXItB/3OsuHuMp6oIc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KTS6KqCGWAfjqbJw1kSMa/DEg3401W5qDL6tU7paE1lwvd4zZvCH9WXJDfnYobHnnOtybclO1HpbE8a5CgsGBG0+7/880Wt11boL4oV1r+K/I+cPTMgCbm0nAh1BqUiZ4W62S/f7lY23PU4Nd/UJiKlvd1w6NXglg4ygylzkGk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=0fVNBV0Z; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=R13jKv0S; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODYZZn011774;
	Mon, 24 Jun 2024 09:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=5eNjSKjKHQxaTQqdIO0o
	CqqBBxXItB/3OsuHuMp6oIc=; b=0fVNBV0ZxMcEwOQuBEWD9vas/u3g3NKuwLjA
	+83a5OTGwYXOzMRODQIIGm49E3L6/F/qVKuDFxo9JgibQiNP1a2H+2MWyCcl3VrQ
	7Ofc3mNZTJxyKlt/u7DRu9+jm3XtEcsm4Aoq1CfwZojyj+RJdDoLc7HfXVnbLWF/
	7T153Mng0+iFX9g65Ig1uITLa1KvvjJHeyl06ZsdCHwkEVs4EXV4LP8d9KPve6zZ
	IQUJQL5uA6YxJCSYGDwCXf+vY987i09QDJ+/cAmqb+GxJfuMJ5giWdJpdZTh/35N
	wAPtUaAKddu6YgrX/gA/jAl4sBRHvbnbscnNC0slRxaB/v022g==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 3ywtx92e3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:16:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF+JTm5nu+ZlLiNNtQLLx/MTPjWqt5bffWjtLoEEuKN5cJbTKEhI9gRGjiEDpWa7hCWIO5FNNqQlVMuM0h+rJTAO1ueIsGHY4atnEDcN3pXn1BNqSbtecMOoFUfmzVmBQKik2WrIBzAZ4TFu/sYgXB7fYUIk2V2xn16yROrAcyJIfx+6G/UhEbvE2xJ8gUmaPjMIEc/yO9sshLnCHx3Zv3jfADyn3DMvpn2nxVKR1PsGTnvUiyRk/1MT8ISCtsCkbd+HzVPX+rNZ0mj6casLC8SPpwo/hP2cT8xdtrpJ9h6sZS5CQBPlGBPen0kyrLnHcL0Bnp7Eb4gRFELZLiZ1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eNjSKjKHQxaTQqdIO0oCqqBBxXItB/3OsuHuMp6oIc=;
 b=Nvcu8wGPp7o778o1ogxpkuLwwR5+qqPyjKDy4f8uSzXt8iueiqDQF3zUqN89i8YBvSDF8JUBTp4gTBCJNMpCUrQqIdvaQ/AH3buDSncJmrpgvWOIDX8s6BgU6WjhRjPo7luJGQI/4adVCEzNPo74s8jl7F/YxAo95Q/ImkB8qmCgY7NfIiQyPwcBH5zQU7oDjLZCWeIQ+ft+azC05rbnhUpPKOnb7aGJjlTe7Fd7eeItSzHzAWbmniR/MfM/eAwY1x7jTve/Ozm0hM54UZyJB3IsoG4LqYs2F5h6qeSj+3NUi7VECVhKPwNIu9aYXympdQQFl+rzd5do/s1lv/9TUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eNjSKjKHQxaTQqdIO0oCqqBBxXItB/3OsuHuMp6oIc=;
 b=R13jKv0S7+PkQl8lUTG94oadSNwAO6+uWw4YtiBFW9WekROOD1TYnX6SvBFNZeUxMUw0de3z/snlkrCDgzvlfGh2GiHapBpNAV7ffSAYSQYptraC1SD4BeIaYHo5SgWQfb1moulVYZOhwGeyZJNfgYCT03aNn8Oatmt8++Lm1xM=
Received: from MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:16:52 +0000
Received: from MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7]) by MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:16:52 +0000
From: Mathis Marion <Mathis.Marion@silabs.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
        Kylian Balan <kylian.balan@silabs.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Mathis Marion <mathis.marion@silabs.com>
Subject: [PATCH v1 0/2] ipv6: always accept routing headers with 0 segments left
Date: Mon, 24 Jun 2024 16:15:31 +0200
Message-ID: <20240624141602.206398-1-Mathis.Marion@silabs.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To MN2PR11MB4711.namprd11.prod.outlook.com
 (2603:10b6:208:24e::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4711:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdf65a3-704c-4ae4-8e54-08dc94584b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZhIB300sGu9PKXy3biGXMi9NhX2QrNwa1UOIKQ6bipomN3oCgTgv2Zf/TawX?=
 =?us-ascii?Q?rlzK50vbIo9HCoPHlzHs+K0PFKhyGr4/LVoqd3HdS+tVaJ58TiIPCv5zeumJ?=
 =?us-ascii?Q?xV96uCDghoUnbMT7SlLUyZ8/UztmX+rpGlAXuBUJ+v+4QOwZ1IsuGytwLwdM?=
 =?us-ascii?Q?TGMzes6anX4irJNUivYG/TguYMY2fQCR1zCZKh/0PzLyw/HLcHN5+gZBElDr?=
 =?us-ascii?Q?qXzucwWUlBjaH7oUp54xgOqgKlEqnhLELRJkvBy6MMJSuwkl/333bIgJllNz?=
 =?us-ascii?Q?UCxFsnRWrmAq03oD+OjwWHyjxELZ8Fr831fUxqs54oAFjzy1vLdysSVc1wE6?=
 =?us-ascii?Q?cYc5WUiR+PCEO1Dl2aOp7ZB+Q5UUjjcA1TbN73mF1YbPFq1zlXts4TH+Srbh?=
 =?us-ascii?Q?rzXJV2+2pWFbiJ6ytdCupcptnnqTKIUWa/z53AfLlO6kXOuHQ4cTJkK3j+xj?=
 =?us-ascii?Q?nU6cZ6eZkrt7DPzCZQvJOi4plucvkT2lsVfEmb7WRY77zaRFIvnBBxywTLJ1?=
 =?us-ascii?Q?Oe9I5LcX3FbINfJQfujVgjPJ0WbXLO10hQqPnJtSCgeRP6nUdb/q5MZ6MLdK?=
 =?us-ascii?Q?mv8MY/w2eDBgCAqe3Jblh8qTfSqZGZ9E6uIagO3cAF2q2UHTxJTgk5JIGowO?=
 =?us-ascii?Q?iZGJQmeXlc5LOddxcVwqSgW5YHeAO3Uh974S7ti0jvPBDF8H/vCoSWpgKwqB?=
 =?us-ascii?Q?xwlYCrk01Bln6aHpXggS3O8ieMGUU8lX6GomfcVuctK74zNdblcYMsuNUBgE?=
 =?us-ascii?Q?kA+AaMrlHU2MygXpF0UA5m34+hzffa3Kw7Ovjn10hvfDQc4WKVBMxGcGIth6?=
 =?us-ascii?Q?DOji6ulWwh5mA7ITYbvWPgY8zMeitCpJ01IbOa5cB0I/laehlk2mxBdtEPQZ?=
 =?us-ascii?Q?Tpy6f5hg6l6JC4PyuxlDQv0IELJb1GmZU4LnCg/OVgKKaHo4gIkaT/mJDsed?=
 =?us-ascii?Q?EpQDA5zTh0kNe+OwA12ZPBcw1pT7A7BciHbs/7CFyWWreOsrwOZwFb4dKS5T?=
 =?us-ascii?Q?emaKVvfjmHzqKR+miUzck2lMGhKqCwLxYmSWBot+iKoSRi7pLIpakzqL+ddF?=
 =?us-ascii?Q?I8d5zDK15OGUGLAo/EJErnMEiyWf/pAY7S195U71o8k31ES16oZP+lHr7zAv?=
 =?us-ascii?Q?NwJxIVkeDz8oY0X/ka2PwCkhouE5ITGe/WCOysycvzO57AxM6ieICABn74wN?=
 =?us-ascii?Q?IqgvGXdgOX9ovB9Tfed8lvnnBIKADH2HC6ALAgp2R1MfcjluGZgqNvnoXLbH?=
 =?us-ascii?Q?uVOqaQ+2+SPKM44xc9XwONxXq8b0aox6E0S5trrhxOxkE4yCGcpbjxQAnvsy?=
 =?us-ascii?Q?0r11vQkYRc718ANC7eAJgds0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xoEr5tkoKO/ROC0FFryW9s4+ErHCDoRqIgruFfCwF9TvLY96LBwb0bJmcVLI?=
 =?us-ascii?Q?R1qbRsYsBe+1dZMDHkaFDVABLsRK5tKkHQzVkNKECSMWW7+fOwrr5VRBkv6T?=
 =?us-ascii?Q?2lEaUpb2TcoTrZTel/rIsw5wNKSxPAqhEZvPydu9kTz4SVocQ446edTcZ0LG?=
 =?us-ascii?Q?oH3hic2mNovN8TckAu3RaCK5Am7voE6LZE+kKqLmAd7R/geqovrN9OzIqyG1?=
 =?us-ascii?Q?2ds3A9nWTpGGpSedcqgysvZPa9kADKeVMiqK3mpIgDi18Xv8Jtnrfdk5vxgK?=
 =?us-ascii?Q?mKGh4jMoTjfb5qBup1f5Kvg8eOhge7sKf33N9XygfA53paIY79clmA0U8lm5?=
 =?us-ascii?Q?50t0VR57JeUwyAVPeVxlL6Csr17z5ozDvYMdnjEX928gGTnmaFr1ODCMbppP?=
 =?us-ascii?Q?F61oHTAzxAklYCUBv3eo4b5J1FYtQdf9rTJzC3N+k27A1TBedP/K8abHWfpy?=
 =?us-ascii?Q?X2xsf0gD+psON1uJDESJK5x7xIOhcx5c7OTkW/QqsxqeOUqbMGAWSuEJ06f8?=
 =?us-ascii?Q?H+XwOULjtXSkMuJ4s/PkVFL4+tRnJq/MI4INuJt7S9WnYCafodGdCj68qkaH?=
 =?us-ascii?Q?1EGzTcxqsiGjHNjjATe+BurQxv+9x6QBUsE4I2f+/kJ4uclvTUA5x62/fnSB?=
 =?us-ascii?Q?kFqQjb15k869BuNWFX7Tc1IKM2NduqNEtf1itJeQ2i0BuR8kwfit+a7DJ62B?=
 =?us-ascii?Q?TOs6YCY/gCx+V+nutdpP619hFWiTLH6gOKFJ4+9HNY4jFsZ6lIfMJm4kV8hb?=
 =?us-ascii?Q?ECHH4ITXn7jkW36lfQ9pJ2/1QlifAT+VIwlNK3S5Cc7bPkxleqZwhKo3jvIG?=
 =?us-ascii?Q?O86M+z2lrpWPUiFgSpROM5VkstIHc/5b7+br/xRQrYRBmbyp9MhvZnosMdPL?=
 =?us-ascii?Q?y0+txXJoce5OhU//QSX28CJpx+8NSYaMeCFElfVBxmxpyfG4/ORXqAIKssCX?=
 =?us-ascii?Q?MZ0ebL/6HTnuB0EFYhp+ux6s8kZGwonajnsYyNy9D0pqIAcAFkYo1JZfeRBV?=
 =?us-ascii?Q?gVhClSavG6tPEZQwBLYd2OfpVYbTz7gLjO2/wJPnikV7TWEZrv1mBHnlfuuw?=
 =?us-ascii?Q?txfPcGvXOvN30kl9sK/gC25whTdP3nx4AHIoau4Wkho1WxXG0JGn9SaHZtEY?=
 =?us-ascii?Q?i+pqtLyiTr3eUTluzHk4ogNMSrI+m0icl7uIEKa7VpjtrJR/FgE88QqqEygp?=
 =?us-ascii?Q?CX1H/OmS+eXbQ0r84UAZis1vGWkjQC/OvZXShK+CcHR8HG4Ke5hqCQhT9ll0?=
 =?us-ascii?Q?jbX+Ts/lqaauDLFm7gASi7JNSQJ3Pu4fWaTf63xZNsmg4nXGbOSBIfhXgkoO?=
 =?us-ascii?Q?pyn7xhmJHljuCwHENI3XN6S3xLb8jTFDvqSVe0+ATrJKaixL0ElEgZIeGXrn?=
 =?us-ascii?Q?qdoCjyNecSe4hKiQ7KM5PuhCsPu+NKm6WTz+dftrvC6h2UUjhsNL35ypTvvs?=
 =?us-ascii?Q?9o3YRtrzSiLbeyx3rzgUlX4Jss79sbkvYiT3L+SwMnU5Nah8P0EuAeyavT/B?=
 =?us-ascii?Q?0ANnw8393EHm7AvmsMqV8Z/YWDCj8Mri8XOzYdbect76ECibYXKnCeognWm8?=
 =?us-ascii?Q?E9jZJqyFqhtPI01t73A0LXDjiUaMfUXKFulO6blD?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdf65a3-704c-4ae4-8e54-08dc94584b40
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:16:52.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLozK/nVRv4+EwBwVl7rhKBwI5Q6HZWR1JoRUWBfi/iB1diJRRXN5ZOD5y+DuYvhxObKsiwUKi6VjC0eT0FOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-Proofpoint-GUID: iDECBXaRd7DEdGsgyi3Th--4gFWafVqO
X-Proofpoint-ORIG-GUID: iDECBXaRd7DEdGsgyi3Th--4gFWafVqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240114

RnJvbTogTWF0aGlzIE1hcmlvbiA8bWF0aGlzLm1hcmlvbkBzaWxhYnMuY29tPgoKSGVsbG8gbWFp
bnRhaW5lcnMsCgpIZXJlIGlzIGEgYml0IG9mIGNvbnRleHQgZm9yIHRoaXMgc2VyaWVzOiBTaWxp
Y29uIExhYnMgaXMgd29ya2luZwpvbiBpbXBsZW1lbnRpbmcgYSBXaS1TVU5bMV0gcm91dGluZyBk
YWVtb24gZm9yIExpbnV4WzJdLiBXaS1TVU4gdXNlcwpSUExbM10gZm9yIHJvdXRpbmcsIHdoaWNo
IHVzZXMgYSBzcGVjaWFsaXplZCBJUHY2IHJvdXRpbmcgaGVhZGVyWzRdLApzdXBwb3J0ZWQgYnkg
YSBrZXJuZWwgbW9kdWxlWzVdLiBDdXJyZW50bHksIG91ciBib3JkZXIgcm91dGVyIGRhZW1vbgpk
b2VzIG5vdCByZWx5IG9uIHRoYXQga2VybmVsIG1vZHVsZSBhbmQgaW5zdGVhZCBpbnNlcnRzIHRo
ZSBTb3VyY2UKUm91dGluZyBIZWFkZXIgKFNSSCkgaW4gdXNlcnNwYWNlIGFmdGVyIHJlYWRpbmcg
dGhlIElQdjYgcGFja2V0IGZyb20gYQpUVU4gZGV2aWNlLgoKRnV0dXJlIGRldmVsb3BtZW50IGlz
IG5vdyBnZWFyZWQgdG93YXJkcyBhIHJvdXRlciBpbXBsZW1lbnRhdGlvbiAoYXMKb3Bwb3NlZCB0
byBhIGJvcmRlciByb3V0ZXIpLCB3aGljaCBkb2VzIG5vdCBpbnNlcnQgdGhlIFNSSCBidXQgaW5z
dGVhZApwcm9jZXNzZXMgaXQuIFRoZSBmaXJzdCBzdGVwIHdhcyB0byBpbXBsZW1lbnQgYSBsZWFm
IG5vZGUsIHdoaWNoIGFsd2F5cwpyZWNlaXZlIGEgU1JIIHdpdGggMCBzZWdtZW50cyBsZWZ0LiBF
dmVuIHdpdGhvdXQgaGF2aW5nIHRoZSBSUEwga2VybmVsCm1vZHVsZSBlbmFibGVkLCBJIHdhcyBl
eHBlY3RpbmcgdGhlIGtlcm5lbCB0byBwcm9wZXJseSByZWNlaXZlIHRoZXNlCnBhY2tldHMsIGJ1
dCB0aGV5IHdlcmUgaW5zdGVhZCBiZWluZyBkcm9wcGVkLiBMb29raW5nIGF0IHRoZSBrZXJuZWwK
Y29kZSwgaXQgc2VlbXMgdGhhdCB0aGUgU1JIIHdvdWxkIGhhdmUgYmVlbiBhY2NlcHRlZCBiZWZv
cmUKODYxMGM3YzZlM2JkICgibmV0OiBpcHY2OiBhZGQgc3VwcG9ydCBmb3IgcnBsIHNyIGV4dGhk
ciIpLgoKWzFdOiBodHRwczovL3dpLXN1bi5vcmcvClsyXTogaHR0cHM6Ly9naXRodWIuY29tL1Np
bGljb25MYWJzL3dpc3VuLWJyLWxpbnV4ClszXTogaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcv
cmZjL3JmYzY1NTAuaHRtbApbNF06IGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM2
NTU0Lmh0bWwKWzVdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni45L3NvdXJj
ZS9uZXQvaXB2Ni9LY29uZmlnI0wzMjIKCk1hdGhpcyBNYXJpb24gKDIpOgogIGlwdjY6IGludHJv
ZHVjZSBpcHY2X3J0aGRyX3Jjdl9sYXN0KCkKICBpcHY2OiBhbHdheXMgYWNjZXB0IHJvdXRpbmcg
aGVhZGVycyB3aXRoIDAgc2VnbWVudHMgbGVmdAoKIG5ldC9pcHY2L2V4dGhkcnMuYyB8IDEyNCAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCA3NiBkZWxldGlvbnMoLSkKCi0tIAoyLjQzLjAKCg==

