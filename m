Return-Path: <netdev+bounces-258582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHxgMiTmjmkDFwEAu9opvQ
	(envelope-from <netdev+bounces-258582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3913433D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EAA230238CA
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EB349B06;
	Fri, 13 Feb 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cejD1Pss"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B5DF76
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972681; cv=fail; b=FsBavyryYdau8mJzUw6OMBs9SSB7wGMykUGIYeCCF5FIGrxvzQ5plrrP4Q0JbW9aiKlXVaDLRa90vkZ6Fw7zvUpBRPrw98q/R4ra5gf+qzMP+1FNTIGgqW5WdaUrIaaSylcjp/zfcMk5IxDlmKRM+58MMsEnRKd6QAVQZdrjRrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972681; c=relaxed/simple;
	bh=XHcXCmnDJM5F1Z54fIUEmB1xI/qPsy7brMbbgjOeeLM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZSU65HwoPD7PDJ3HN1d57NbtFcTAMxBgAmA+ezmA+VfhTp6c+O1YfxIkPd7jAmtJXDudTRF2Yfgk0rKOz3kKBs1dZj5p2wl0yq6dZb6AzguU2mEJ3mQ1n6LdHpYonjJNeoXb5u9E2yi5wSxsmBTvh3ZHB1bWDrCm7rfWD1Uw8MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cejD1Pss; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq2YngK9EHo81V+of2K9EXNrz4u+aX0wnjLnlxJrDX08rkXzDjY9EMVaf3btuzgw/1wMzvhVzy+H2qtUePBb9S8dWhEJE0Utmt2Rf+O6P6yODTTs440TRwG6oaNKqUqN5bmiMb0PdNaJWxXgO5SusMTPLjKnKts7UJdxPdED2ELBNmKC9mJpZb0zxT/H6oyDD7djbrS6ET54w8wXMAQ9X7j6i30cu2PgU5gqTXKT90pHT8G2SNZb/i+pla2Y+SiH2BIeM/4fjt7f7+yWxWVGI7SsuzFNXXh7ZH02oQq2n8jk8hBSM0cjOSX3noctw15uMuAy03zZaFDlw50PYtbBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n+CH7JkACVh6+jBdbvJUem948km/ZIkeh1v7AO+0uM=;
 b=HXrD40wbKwlqlxc0vn2eBuTXc/8X/ae7RqaZ26YI56wyMZdBGT1e9vqq/wpSxHhBrBfxuNtBT+PUCpKAj12ZRgE5in8XLWxjNtnJbt2PDbpPbj5jVXKf33o2lUQCe26ntM1mWXVfhw/XV9qkrrM5FLqz5RF+rlnBY/zzME1DGKXHttyTuHLOBJzSPDMhecUxlzG1yyab/a48A5ZTjtn7Z0NCh9kEJHyP4cmd8dhu9jo4z7v6Pw1HG9TVq/AaclqHt+uqDkRgicIP8NXUe6lG6lH8q0X/CQZpP/D/ZGBFA/M2PL/adYqf0QkSDyTzZZTcjMJWEPATXksyfEzhgGPvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n+CH7JkACVh6+jBdbvJUem948km/ZIkeh1v7AO+0uM=;
 b=cejD1PssEGo7wU64WW1Meux7q/9a4QSmC+UEjtSsOCAcTcYjxvqLpDbPuUqIOetJTjNljNg7OHS2XXcnI8KsQO3T/pXtN0bKcu1NSriUhRQ98ywRzRmoLCyYIdNMhYcbK00Wz9Tczy75/9MVzxg8SRLHWJbn9bHLq+Bz9ZOduGqs8OQcdYi/3Er9GwY/OskTrk3KwWFqEf4g/1BDx0Y2uZ92/PMuN2UpDdY48BsucGzChjgY5/w3Ybnl7oaJBmllLV0Vh3eWRmJWgDu95UYN14yGvdBkWSK+wLbrSt40kgsaZoyRBQeu6tiQkOgO9YFK9neBoU1JVLXzj1lx0eHZfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 08:51:16 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:51:16 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net] drivers: net: ice: fix devlink parameters get without irdma
Date: Fri, 13 Feb 2026 10:48:41 +0200
Message-ID: <20260213084841.1406442-1-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de5d81-f45c-44eb-0e36-08de6add0c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2jJLqMa5dBU/uELmdlYqG+B75gimpEORgKDWb7r/Z8UYqaTNx26qi4dIpuh?=
 =?us-ascii?Q?qlWD9+1NWZynhErFDzsu01zaskT2jlUjTAqp7eMC4700Qan0S/BpeUzIlukA?=
 =?us-ascii?Q?dHckL9WghCHymRz/5LkSWs1NTbqs6eT30P6sTvUNVXVnf1aWZfcLjje10dIR?=
 =?us-ascii?Q?anMeGyKgUchucuHlf8MG7caMXV3Q3LZctTrBlxMxhMmZUj+lKEwG3Pv+uJsp?=
 =?us-ascii?Q?GOYK0mbRrlgwEPygVBj39g5uHr2iOPdqcBy/YWM6wrND8A6Py8IggPD8uCOp?=
 =?us-ascii?Q?yPFyodNeR9zEikCmaQvin00MIzqwEkraKRtg0qFrPWcR+oxLAbnbyIIT4PD2?=
 =?us-ascii?Q?T49xUJeBHAyEbLBaHBOYObF15ybNMS6IwUZtOzIcldv6phzrpqXL34+Xs0qj?=
 =?us-ascii?Q?F76XRJAXc1loZ96hVIApAwz0uKjkVXRZou+ZgaZ97yR0Ea3d8YZ0i1F0NExN?=
 =?us-ascii?Q?+6qiwE89kCYiDyTCMeND8v3EoiJzkhKEAVaib+PWj8Cc3tP3bVCnh2PaYsO+?=
 =?us-ascii?Q?jYSdrAWy7mCY5L0YSyJFenAHerbG+zb5tAWiVkPwRkOtGY5NPQfq21x3F9yO?=
 =?us-ascii?Q?KWdfTJXHMw0a79CaxP/8nBwU0nFfEkF3bkxdvJbX67LimCuDh0XxlwmONc3H?=
 =?us-ascii?Q?s89AUxa5DNuPe0aXGfxwoKDC8HH0HES9s0xeMF9LesYM3NK/8FeCUhdsBWFM?=
 =?us-ascii?Q?zMPLf91lLaNHC9tAs/uVIRJYeTGn0yFzuU3koni0RaVV+VW2g2UIUZbGMWo3?=
 =?us-ascii?Q?Bdh/bTO7HVIOC/4EyoYohd1Y+rDlTzuoeEMBjpX/C7l45b4qIQw7fG0v47Yz?=
 =?us-ascii?Q?0G1aV3R8XCLyx5Am2O4rTGahPYn/RVdfOuxSbHSnBJyvUiuVkprywqzjKnjt?=
 =?us-ascii?Q?laZqv0KiZcws85zWmO2oCTkOAIGmsDpWa559qAev8M3kU/l9Of+qjxLypTqT?=
 =?us-ascii?Q?y9wozljDChq0CWYr6vbziTx6ZTHMSAQrI7F8qqhQ54RAaMc3zYE+kczo72KQ?=
 =?us-ascii?Q?b1KKNsDCVEzixOyZXp+czpgyf09xMbm/FkjgfMyMyT7ooRhq8tWPmHLNivS6?=
 =?us-ascii?Q?nn4OPqLJgeneig9eYPWt1m7puA7dR5NTYnBeWlD+Tug8U3JZydYQQKd5ryfs?=
 =?us-ascii?Q?UFukENFtT15dDyurWsrN0cDK4OHa47oyKKZrf+rZ/4ZM50ylPO42ArPVRV+L?=
 =?us-ascii?Q?m8eyreumtJLZPdosgMN7o9gppJIz1ArG69jTAyaFhsJAen6tL/BTor/QGAP2?=
 =?us-ascii?Q?qET4YhqWCZOj3lAiRKsWw1VN3mB47axnh0o0fPjfNBDbEIA2ZOeHg4/tcDq+?=
 =?us-ascii?Q?wnHBx/7GBnBnEB0oXmW6t8isbZM0z5+gJc0FnU+DdHzSbX3+QjYxQ8RxJSLE?=
 =?us-ascii?Q?R8/eM4bkvdREOeuVZpImYbQtanr7X2SKqvzqMBhWiNP5c9iMJHLp7yaJIDJ2?=
 =?us-ascii?Q?nn5+jqB23n8vCdENmf+av+5h+ozlIEzVayO71qIAulMJsy5BUzTQaMy2CyEH?=
 =?us-ascii?Q?ST8KQIcZdyaP72sKTEAYlgRJgtCYXj/G6hAOVM2AXua0pbBFZz1ULyGA6SQ1?=
 =?us-ascii?Q?07rGuPp9DvdXnE9FUrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NjiDXOgwWxuIGTrnyTioi1INwW7VbnlAcXE+pgg6cYPWe/OK2s9QeYuyWxX?=
 =?us-ascii?Q?AEbF2jtnyTWhG3RNf90wYMqc2S0FihvBOPkUcEgxXsrgEQG+TKdqMEEJFgBz?=
 =?us-ascii?Q?/JbCMSCIQ2b9CsCelM+eCuZRQHyuaQXinNALQM7/zVaV1vcizAVFBUx48ZlN?=
 =?us-ascii?Q?cVqg1QLipgGA03h9Z+mY11TW0Kh4XyhMJhd26ZFB1D2pTZ5iIP+OLnXGKPUX?=
 =?us-ascii?Q?LhP6S833q0CvkDJ7plXID+F+7CenFNYsWBEBBZiRq9rX7+GOALf66j2mEW7f?=
 =?us-ascii?Q?q9seTxlW+d1qxHpjEogX0akeYzErqbVYAFaq2BZE6744bYTbtR/qmuA6wjfY?=
 =?us-ascii?Q?MmVyACoe7ltYVR5vVIOejTBs4I6yemOwqzUeRmbg7kA7zJl+ElgtIsBJ+2KZ?=
 =?us-ascii?Q?x602Gxo43m0Rf9TwdF+c/Zg+yp5EE3HLpLYknuv/+niwKff+BfLvXbcDiSJX?=
 =?us-ascii?Q?Cy32O48JnTu+eIrADgfc2K7T9c1Qf0tF4yCfavjaBN956k22/JzRc5AFa2pF?=
 =?us-ascii?Q?bD6zylusuLw2fleUBMjQKFq/P+EGOcGRHCPcupe1EOfS4DU1IN++6qdiqEln?=
 =?us-ascii?Q?PfNs73GG2xio4fzWEbEVyySL/7TnTMbYQj/dEniBKRoEP8XDv7EWZ1LYd2zk?=
 =?us-ascii?Q?0R6EjlpVI3EZs09hPQKq2qp8Tbo5vFAYVt1KSh+24Km3JrIYbtl10lhycuYn?=
 =?us-ascii?Q?oA4eTEcjLtowee3PZ5Sv8FIDMzn0luCd+MWxBcJ5sq/EEPQ5BvUBr5GyuoF0?=
 =?us-ascii?Q?DX108fNZyXFi+E6U3WYPWbsGDpTUOTmM+BrP47Nu7h5aLLGspKGBdVipqnrg?=
 =?us-ascii?Q?NR8WzEEjrRtM6ULciIr94HtrURrR7mXEfblqVYc0b64WvbPENsukAJElKJJz?=
 =?us-ascii?Q?ALVnXb98kSE6ajRYfG7Bxk/iXmxw46hE6dHDAcpXTddAaEXCvAOuzr9mZIW0?=
 =?us-ascii?Q?/MMAs5ES4DgON5OwEefhmA9r0pcuYychCJDGq01Y9jxmzU4gRhVcg95sJbB7?=
 =?us-ascii?Q?PKwVyWY9LTGLRH/yTodwlYLWA1nGULb9zIqzG1hNIrtjSEywlzLAwPbRwp1T?=
 =?us-ascii?Q?xiAKeJIYCbznpC6DMZzpd+MOtVf1w9vsVnBSTRubsAN0b1DhXaaLzEdCIhXL?=
 =?us-ascii?Q?Gr9s6wZ2YZILsxqmwHT28cZQkHWlg6j92ItWlenDhNKHkcIoyoZGTNgOHEjo?=
 =?us-ascii?Q?REkg7Xo5aj+8A62JcFKJ+YtBefKOSFicbscJKr7hkSgLrWgoex0VhpNepwDa?=
 =?us-ascii?Q?WYzOSSyA3idCHYfzP/ABJ09AI0+O72Y1J1rFGbZTmTFE7vkt1DUKvo8IcnRS?=
 =?us-ascii?Q?9+yPQkz61kMUXbchE4ZEGA7XnnuxinNhbO5kl3AJaPJUHt2QvzQIo4j/h+qD?=
 =?us-ascii?Q?yFt1Fa2sUJXe3SYmHNomVDKd46NLrfRyEvFWVTRKP3S9gRSj0yRCHzhOsbls?=
 =?us-ascii?Q?TiFVtLiKBlZJSqcVXqAxNFFKf7uhDoCmiVJUBMrLV6oPz5I1ZJCQmKHtyyo+?=
 =?us-ascii?Q?4Xrkcygpf9dWAMNxwCSlp1R37YEFCL9pasvfyUaAB4mG8NIxBRz4Koodh5hZ?=
 =?us-ascii?Q?GZU7urZUYWA/UrmW0DYp3SMEnfgebe95/oOHCJxTi2Y/hlnuOSlj2n1jmcuH?=
 =?us-ascii?Q?4HSbwmxJF9qffakAan3478eJEKWzYAl30TU3JKo2exAuag8O27PXoAWQWrs/?=
 =?us-ascii?Q?vCMMCmm9xgTj8dfzdrbW6mNrTqfsnmsJf9W9xiHtSZoBgwasIP9Jua/V9GdX?=
 =?us-ascii?Q?8Q3ASgL7dQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de5d81-f45c-44eb-0e36-08de6add0c7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:51:16.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xIAEcZrthG596HUboLVAih9dkDcBUkA89oeFuzLFb5QQbiks8mynXM7VZjEOI7EZghKerN7yiznRCrY9DYE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258582-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 50B3913433D
X-Rspamd-Action: no action

If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
driver will prevent full devlink dev param show dump because its rdma get
callbacks return ENODEV and stop the dump. For example:
 $ devlink dev param show
 pci/0000:82:00.0:
   name msix_vec_per_pf_max type generic
     values:
       cmode driverinit value 2
   name msix_vec_per_pf_min type generic
     values:
       cmode driverinit value 2
 kernel answers: No such device

Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
devlink parameters.

Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 2ef39cc70c21..7de749d3f047 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1360,7 +1360,7 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 
 	cdev = pf->cdev_info;
 	if (!cdev)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2);
 
@@ -1427,7 +1427,7 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
 
 	cdev = pf->cdev_info;
 	if (!cdev)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_IWARP);
 
-- 
2.47.3


