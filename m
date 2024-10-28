Return-Path: <netdev+bounces-139581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB39B357B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FAE1F2202D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080031DE4FD;
	Mon, 28 Oct 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhEzsEnN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE21DE2DA;
	Mon, 28 Oct 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131037; cv=fail; b=YUWnZjw59TYlof+TXwADftRUcAE4J0CM1Ki0IDq30Xkzbn/nJyqthU9SzvR61IhzBLn7cE2euXaAJDOxVzmx2VGLxN57OtydrZOFy/7bACPWcopxXc8AH12fV+jfUawebeDhNTtIRFCfqvF53bVTqQd9LOPAO620YaSm8GMynOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131037; c=relaxed/simple;
	bh=6Gh1uqYJ2RFueCeOndzPCs3Od9qjA827fhyhg1jZ6y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qOUGAntRdLyT54VI+pN7lcei+suSKM2EKZ3tNCd3FmrOHiaSxn3qx5wkBh1inUM/Mie/NyZIix7Vj6/Nz7HCKBWL/vxG8Lmpn7kqrSv9n+mIY34rnsHgDxszQ7GquqMxMWE0oJZW5PR1uqk02uGH8909uz9WcWPizN7MHsUNccc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PhEzsEnN; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGlztUsk0KuX080FkXoc6EaHvCd5auaaHTnAPOg77QfI3xnevlqEOrfrjcQvl9XmxtTkrVNO6s1Jsrdr+cvkhf8h6YiKcfjUJnblvJU28aNtWIoRWCz9nOBwa0JLVcvE4vONOWnGf7SXwk8R7uBpDbz/Wv3ihkeZZg93tMXkjpwwK/zFVwU/yeHSehoeNXKFhGdJj5l5WvL+Lg6Hv9rlbygjdQAbZgK/e0qkACae4F7gl+ynJby/c3NWd3dp2wMelWPv8ysz50kSlR2MIEdHZP19H7NxjYesmDA7KhgHf+m8W9KVAnPk4NjMB+1ec1eGowvf9j6Xk2cPdzzKWdBntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NHXzrc1GlsivXXhM2bZu2D0EWBou5UYYauiBbrVHo0=;
 b=uIdAAk+2EL5XLYKZ+p18J/zla09DZBd1/Un8zJxJOwGiRp9iLN0fYoluKtSyIvkJdCyLcwsP2vmtrnUUVMkFjW5ePN0ceNzSt7j/dqA9GM4ja/Hi4/czuijht8rI3BpTbSUVNI+H5X+HaTHJMyT8ofYWgT5QjlyXVYpFm7wSWMKjIdz/wYVp9WLKnTpAfHWjsV3zSOK6L5zXLvGjuagE9Yr7SnsbwjXNbw8kEoFInWGAKQz+qiYvuj+HlcheMPFiX+Hufd/0bMuIyfzpZ6XPxZmjrIf0zbijptDhXdESWBBieoiNxj5SU5RXwPdz51AcdRsjTFvL1SwRKEdEMHQalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NHXzrc1GlsivXXhM2bZu2D0EWBou5UYYauiBbrVHo0=;
 b=PhEzsEnNNsowJTZ0odkQoe8OV/H68qFD6HLeOyVjpklskhxh8nAVkFZPLxlsk9U4Db0ZA8wDOHfJ95pUO4TxEXpz5co+eLEh/vFPAk/l0mnJOqg6lzlF0PgRVIxncmLY/4VLzBGRjqbs3zmOASqbDxcQILlAk5qMKaIFwFKsglvT8NJtdNCxDlrb/W8oLsqNcFCBGY29wL6UnUpaexbdK3phM/uqOSY6UW54DcHA/7fuW0C4k6JZ1gA5ofo6EZoohbyqvywRBn4Fuyk6bS/64DJdYcPUQtZ+mQLRzxr5+BAVf9BzRfjMytXSK20eAcUi/aYNATDG6+JKZinxyhCHDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB6932.eurprd04.prod.outlook.com (2603:10a6:208:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:57:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:57:11 +0000
Date: Mon, 28 Oct 2024 17:57:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Baowen Zheng <baowen.zheng@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw
 flags for actions created by classifiers
Message-ID: <20241028155708.n676l5g7qgxzf4cs@skbuf>
References: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
 <Zx0g1uQ6LTDycCKq@pop-os.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx0g1uQ6LTDycCKq@pop-os.localdomain>
X-ClientProxiedBy: VI1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bd1b80-067e-4872-037b-08dcf7692f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2R/z4Yp7Iz70AgM+FR1tgi2Kf7JF6yaZ56sIXCP00jJwkgpPSyT3Kx5TLDTk?=
 =?us-ascii?Q?hbxgYPuO2h5iBgA5ivmetqEXC//zDO+56KyfKCXprTai62sCNmIBxuoxg+x8?=
 =?us-ascii?Q?MNfYIP/8sABWjm0SGArnQyPhiyc/Ws1Fw+MDLXHpQhPI+mPfiDdt3uofQC+b?=
 =?us-ascii?Q?NPiqUkE9jrUnCTpSQTHOz3ggMzG+OpsdbLFkhZFw2i2Kf3dyAY5qRD+nk/lJ?=
 =?us-ascii?Q?N+veTQoTMehfKN/C36my3e5QycIDNVTVGNo2IruTsfbaNn9WodVmdyRE2Loh?=
 =?us-ascii?Q?0Vy+KtJtT/9XojpUbDg1CP6dWXvIU9YWouYSC9vFiwCKEhmqIwXYj+VbTJnp?=
 =?us-ascii?Q?E5oTnN22PVFLPGYoTdWkF17wkvNRPMdojaJ+GVwLIXDbcxbt0NDzxnCECen/?=
 =?us-ascii?Q?X36CIQ0qr5MFaxmCJwfbwsm69aZcNK1KN1IvMTZ5Mss1YEwxFRiDiRasB6Z9?=
 =?us-ascii?Q?usXTOuCTCunTIGqVvSwiJU4PiHEAbqEADce08lS3/J9cR6G5REZxfqqtcAZO?=
 =?us-ascii?Q?B2Xatx+fO7VMyBxuaheJbciEC/s8RIV8XreexN9cphBedmcnJ9ZhWNTvQIwW?=
 =?us-ascii?Q?4mECHAIN8AZYD/BWKAi6Hmt606jXAmIP2qv2MoVr0lXbwXdFLTkDz5au9Ltn?=
 =?us-ascii?Q?ipYarMh8fjP2/EYkE2WlE0toSwegSrHrsXuhFXttRdHSysak1+Celfl2UQzm?=
 =?us-ascii?Q?fe5yEAArnP8bpjMZ+wOufVbGQqjoLFyTEL92UyC7imO9liUU6Brn9GhdY3Gp?=
 =?us-ascii?Q?zdp5XklX3CMnQ+ounSMZCnWdaNwgIHrUsKUHJTrzsZjyhc9iNDxJxqBp0uQX?=
 =?us-ascii?Q?Xm9v00PR9vV1rZIv7B3AhQwiDsks1uf8sY/kDl2Fi2sXeKpZ3zZCo4gzmE78?=
 =?us-ascii?Q?aCm4sMXiZuAkO0YnpO/WaMdSh971tI8Ne04zrhqMwTqG5W7c3YSvduCyIiW1?=
 =?us-ascii?Q?5D956Eze/7eiYd0EM4ekfVa10WHAVYRydQC8A6HCLP0jrIGQWeNsnJX3gPGj?=
 =?us-ascii?Q?wTtlnBGh/mRGwXHWOPLqygKrBnX235UuwKCqHQ/l4YvGi5XRUs4KoQAx8WD9?=
 =?us-ascii?Q?EffeffcTbhUDGnT945PeZeRvQRc4iEFf/kLovaojCV4PBlvbSOa1MIpbAwII?=
 =?us-ascii?Q?7KQpBKzgcyzHAIFhg3eS+Yo79jupUQAgERHUOvfgIGVTf1HvKINk9GsOeRSm?=
 =?us-ascii?Q?HmCOwB6mAMsY0LE5UN/WxAW70Uw+jOLaxyjscIvvNKw7mGvIUdMIuXEde9Qw?=
 =?us-ascii?Q?Vy0AQLYRC6uLgJKEybbKzf/PeH37+Lb2Bh+HOWCP7sii7tRcgDnWtVy1q65f?=
 =?us-ascii?Q?Zx0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqCbvj5RzGK0xoF00nXd9ZTgh1rocVHaErLeXxcrbrN17pnte4642+hAOhZk?=
 =?us-ascii?Q?9n9dyU6WQPjQDtFdhDeFJ6E21Rj+4QfMqNobf8RJb3cqShZbT6HNb81RIvvc?=
 =?us-ascii?Q?oAr+fkmzyl2IvlgvApLf/KTd2zqtg2Wfs9lrVSriR6OHRwryWlO2IIh49EZT?=
 =?us-ascii?Q?i8yU5C9leXs7tpnas57BWPeCzjf/hzRDsUY11YZFc1NNYGgQnQqhnVngl3oH?=
 =?us-ascii?Q?/+7dGXseYRt71g/secjUyZ+fuQsdmAXRJu2SGvPAqpAi+SRtc/v6UpzYEhrs?=
 =?us-ascii?Q?kTMETKNxwOYV/y4wTjjIOnUZAswdM/UgJoLtwMVeD3LZe79jMPuNrxNoVtiw?=
 =?us-ascii?Q?zqkmkuiydKTeupNf/ox+Ty2WJRqLedlVFISBb5j2jLF0ZzvOf3X4+HqeRKU9?=
 =?us-ascii?Q?FZfLeYTYPYJ2cMzOdmL+WX4lDTJRfbG9TtzuN9hKLmXEoHnfDOmssqPNCP7V?=
 =?us-ascii?Q?sK5CibwfyMS+FIgrEZeSS60I9K+ClNwKmy+ct5xRkFjQTn9nzLcsPk/5ys50?=
 =?us-ascii?Q?FIczrqOyUbp4SxDHBf4de8jKX5ENrGU7HWwDGIr3XvGROEaZsgapeEdDT8e1?=
 =?us-ascii?Q?eCDMb10WClWTuN1Cyz1/RPAicLvId3JpBsEpDNw1Q5NDALuBL8j3Nd1TON3V?=
 =?us-ascii?Q?a39HIsPCbMWPfvzXV+zZZ+ofuW2NVntzTMEz9BVeA3aF2ofxjkibt2Vvh3Pt?=
 =?us-ascii?Q?2smmDbL3YCdyX+M0PIPP5b83nR9oE/hFMAW5Z4jgkJ9rd0sZpIIrDxJwFC0j?=
 =?us-ascii?Q?6B6rv+qN4Qw8SCqD8d+0FNcXjitzG3d8MmeLOQZ1dmkczUPmfkkVsOrIeC6R?=
 =?us-ascii?Q?/sUPd/MZRwBBOWPgFbqVfqeb1MzW+iWjVkd6wrHRBJ2hcUFPR+Dao1uPGBSi?=
 =?us-ascii?Q?3xqgItEZfmEbhhsSI/L2bFHDgjCUpeulhQwwUMXrlurIHki6PRyC6qzyoFHQ?=
 =?us-ascii?Q?lUrtA8zfSpZvoT6hgqKpV+knqmgcpIw/GSQn85IX/ryvcD9jJ7/mtD4Y7von?=
 =?us-ascii?Q?jvytuZrFidZnmbBfELTa7mppjBGR6VdXKgXsGO73lwNSGxwPM9ROhYIhd4ys?=
 =?us-ascii?Q?Mmc01noO+q1UQ/Ez6iBkopdYJ5LWT3RWMry5owlpM3TDu7UN2nb01qTF3VpG?=
 =?us-ascii?Q?f65eFAuRLwDXhbKhIRmsgDqNqrzJ0psoRGXXGDRwyu9/+Gw5poHlDVCowwk7?=
 =?us-ascii?Q?NJRXaJzPHjhvW50SKRHf1HVmY007aDj2lpqCaOF88j/A2Z6YFkgIkq+4xEd9?=
 =?us-ascii?Q?YqevxwtIEKdkt/rFKdRNJkRr7NmGXq11nefaIJ2Tyr0IhKL6UhPqcvE0H8zM?=
 =?us-ascii?Q?UC2UQeiI/yWC2ZGjgBzMiT3m/+PcJUNhRi3R1Lu8Y5XkLHWvJFnzq3qZOfaG?=
 =?us-ascii?Q?qF1n0htoqvf1f3sMEYxP+qLNfPqFrssUVMtDE9lBrrLP23g4tGAWa8N/RqmX?=
 =?us-ascii?Q?G3CjjaJz+PiLKtVp65+Tkk28IbtKSbtwG38kE9s6c0fPBXmNPNn3O6kYYHl0?=
 =?us-ascii?Q?caKf2eIjcnqJ7Dvm6bawfEaf241hOo0Hf5xPk+BXP10Kc6koH8wYx60ytoNP?=
 =?us-ascii?Q?oVICsxZG52Vj4LLNOKCzftEHv1Qs5cIg58KKnOr93iVZAZ4VbS/PGN/8i2oV?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bd1b80-067e-4872-037b-08dcf7692f0c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:57:11.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y85r1lamBPcAmsfsgYE844GKL+WLYYMiKrn67ninK3Wu/bJDgXmSq1w4vwzoZ0HiYypGe3Xjsm+qi4l7smk0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932

Hi Cong,

On Sat, Oct 26, 2024 at 10:03:18AM -0700, Cong Wang wrote:
> Can we add some selftests to cover the above cases?
> 
> Thanks.

I'm sorry, but I don't have the necessary time (either in a professional
or personal capacity) to write new tdc selftests for this.

