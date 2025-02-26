Return-Path: <netdev+bounces-169992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F7A46BE0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91BC188CE30
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3102580D7;
	Wed, 26 Feb 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EC/dWWis"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7021CC66
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600160; cv=fail; b=nBuj6xxRJbruXFgvjHRx4lP3fLZ52T8s2o7jj31KabBS1i5MGhOdykfS2X17u6znSLFLWBC+zwnAAWRi47BUXAr9Ir/MtZ7S49ims3x5UdsXWlmdO3A07aSB/W0i/gyPbm+YSz7++SwAVWDsr/4z9TRJ0kFd6+BvNC+kdf2Yc9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600160; c=relaxed/simple;
	bh=AVt0ypb/Ma+kQ/YB2FmYmT/nZ31uibOYjVmSeSFMx5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLpjrhoTj4JvuL14xiu8qOoglh7jD11b6wGXEksPzwI9RKtSg1g9CjenMJVsMm9oF7sBai4ew7Fj6+edJwShkF92d4RK6DnhoEPfaWP4oKxNZHNZDadgR8IGxJIIKwrnLPfJg8WHlzZZZg/XWo4r03TRM04RVKvjEantvlkj+7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EC/dWWis; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv0K2Bb9NLHMbpUB0dK9VDf062qghQELf5pZ4Rey3eUJFj5ZgkTsGcxGZebMq9WFPhSEYF4L+velK3XI2QQ52oKyak/Bmm6YJk/Mb0wTdvBAqxKMGpohJWJNmeKQc8oHx5cOO7E7O3T6SqhZKeezpAjTPNApdK+HMgOOSV9J3GKm5hxjBLO5uMhcsQKzL1Qlt9SaG/DTXyFDv/YZjOEkGzx6/wSLW4tVzZ4F+zE80D3iVorhSS9Gqz34CTWVRv1vgZtyxEcibcPnPoJtp2uAKmab5SEa/5U8QdjEehEU9olWiB9rTDDCkiGPqRbZGXQADwms68xrvEur+zWOCJc0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTNbMuB9cYkyu4bbHMYJT4GmHVlDmnWLCh7ympLd3tw=;
 b=DG05QJyN7Ce12qr+1u8vTrbr290Z/12vQpUgyr10AGP8bE5MkzSeyHQ6kZuKOjseTBvwAmv4+2mX5tAHw+pmRQ1ZY4MtOu4c5YbifZhamV1BAyPUCT9Y9+aOFN48O6g4z7cpfPk6g6OuEeFxg0JdYPtFBFU2kMNTQZIzZ5MGHjj7UW0hs/7/JYWBTkcc+/Wm093Sn9xTuoKe2pg0v3rjFWdMK6XGSxSF7JQpEtJ18VclMUX6LYSQ7mtZAMjwi0aIx0wzl5X6SGMSavHIGObtatAq3/ebOGYc9ipArX+k2/LLUD4aTm/1I7ryhOygG/PBK+wwIrpvPiYZevAno5qJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTNbMuB9cYkyu4bbHMYJT4GmHVlDmnWLCh7ympLd3tw=;
 b=EC/dWWisf70AbUhSYhmM8atpDuh24Ww6OtNA04okeKQYe5CNgwzaozzz/ynRf1gFKyR8i8sUUJOkOJf3dSguBqprIX234Hh17BdaTRE+aRelMMV7UWMdhRB8rNArZ9OaL0sEVSgihG1GO08Oorckznwj5WtnVu51fmS1FyaeBt5AY8N4L+/8KlUJlNUflAvh53nHskkznCXLS0NBMs8jvhKvuRWeiP5YrzdI1kUXlH6pzRCLIS8HStL7b7f9NSGzzqlczX5xkHUlO3bhcOGDIdIsf3nbxfkDoQiUq732nBlpUWfVeb6tr7OS9ffkO5ryNa8Mf8LSeD6D6L0GN5pEXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 20:02:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 20:02:33 +0000
Date: Wed, 26 Feb 2025 22:02:29 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Message-ID: <20250226200229.kdg2ls2ejhsbzbwi@skbuf>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250226154753.soq575mvzquovufd@skbuf>
 <AS8PR04MB91761FDBD0170D8773395E9289C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
 <20250226171045.kf7dd2zprpcjrnj7@skbuf>
 <AS8PR04MB91767705160830CD63341E3089C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB91767705160830CD63341E3089C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::43) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5b76a1-05dc-4cd7-f0f7-08dd56a081f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mym7qPmv58/EtjKZDZIVB5T3eKBfpBxLEVwloKxqxAXJCk9faJ6ZcaeozoRx?=
 =?us-ascii?Q?gigxLPEeYiGIF1E6FdzbF6uQ5t03Z38RJta/UUJrJJQE/XF84BATVxJfDqtp?=
 =?us-ascii?Q?y8XM60IlfYg3I5b70bbCtH2GV44/dGpOMOGG4mn0p13rIdm4OUPfZCQxsW4y?=
 =?us-ascii?Q?8Aqamwg+mj+pobSfgf0qIBUsbbyFxwY15wGKWQIOAcnnaXOL45IcX/KRV7aV?=
 =?us-ascii?Q?BnwtBk8b8+ctNtpVm9usQAWH1CUZroDN5qLy+BSkAXzVo5emjFB5wx/hY3Sq?=
 =?us-ascii?Q?g+eGkqfHpaYPdJbjqq2j7DP/qtkgzz2LzfTRlAAE2c65cs7m5AMfRd6Jbwl2?=
 =?us-ascii?Q?9u+mZFyHBO7Dt/6W4vQCO9rzD8vRYiP+3JQr1YFlSFxRTwAbgOSij5M7KZ8d?=
 =?us-ascii?Q?9M+hf4mCSU1e2GwwyjoaNKJz9TFLDiOkw0eqtdvdufMjdbeWSWpaUWkcaOLz?=
 =?us-ascii?Q?AuNYUOyTdbl2SiDecZfAaNGdGMk0KgzIbPDpm09f4L6QUprItB3KalXzkvFm?=
 =?us-ascii?Q?1QeernzR7qujMvQS6OY7NtXRKRC8j1/LtcuxazWbxV3zra2ZI9ylhclQ20f1?=
 =?us-ascii?Q?mD2fKBxnBBpDC7n391defDDJVG93Bsktllf92L91ytR3oavivzUB4ygxY81w?=
 =?us-ascii?Q?mrCgrgeaha+jOKo8ah8JtMEY1AMqBVagzCnsIT2UpulZh3PdUArDVr3ONx3D?=
 =?us-ascii?Q?ttkS1AmOmT50YpE0y0iJA4Na1eDlfJJt3tqYWut9kBcBSCUSblP8yiuGmkyF?=
 =?us-ascii?Q?yWByRbmPcJponftF/3KRB/cqyYdHOS9RuQZmbTnaP4qywwrEGplQNKvGXyXU?=
 =?us-ascii?Q?4Nr++uWcyiAyQMJsgTVCoAiq1ACSjiAWNubHt0RCqPzfzhEN/g4SJ/NMTvqz?=
 =?us-ascii?Q?9NaL7vdcNdkjrIEm0STc2iOGtt1rYH95eHx4nn8cnMcOfnKm9P/+6B8rUQOH?=
 =?us-ascii?Q?6JhRa/O3TSP72Hd9FRxWxOAvBToqzLIuhTAE5Mv9qkTyhZA6A/NQfD7vxmtx?=
 =?us-ascii?Q?dKf2S9fDfER7a6YuKEDsc6Oor6G1yCCVFYRv0m4ei9PY+UJ6vXZo9SEm9Bp6?=
 =?us-ascii?Q?fWdxjKZ2t3a7W1XSqr5n9RsIFThoTOZCGOZ3b6nMq1mwMmYw7hEadr9Yzfzb?=
 =?us-ascii?Q?WNpA2R9utjO23/j7QKuBwZaOCQVB6HhstZAjfez3ppvARG22lpiLbnwZevPy?=
 =?us-ascii?Q?NxaB1EsLiQK1qSxV28C1erMVj7TW2hGwRaaVni6Eqtr3yRqDWHrUB3znT8bp?=
 =?us-ascii?Q?+8dum3Ul4cXx/5FynKmxSqg5FYzXVydk42sfjWjCrrw9GsUVTAD8FnDm8TMf?=
 =?us-ascii?Q?+lsFgVn4FeMlEXe4ZyCBLejgTmuQYAzQAd4T+din0fKungA6d23vUthLmUep?=
 =?us-ascii?Q?Vrp3iECaoyCpeYvL2Wqj/nL4SE1s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYI47KWiPu3Wi9S62W6KD3+7CPK/KUvKYh8N6Qf0G+6tJlUodTzX855q5CiM?=
 =?us-ascii?Q?ftISXlJ5iNzAWhi9vLfN19WeeMdvHLrwLUa5OrHHRaIrqWtl422u+TAmM5pk?=
 =?us-ascii?Q?Yaf5YCsKuqHvL8T5P+YW4AkfpItk7qU/8EMPpyNcK4R1FicrCvmLh0CwI71N?=
 =?us-ascii?Q?3cTnD9PqwHeCnn2IcAOH1TLY1TiSFNl52rT2DFt9vinysj4mJf7efO4XsNA5?=
 =?us-ascii?Q?Wz5dRSM0MVC/VGadGM6EROkkAIRxRr8cbsu7AlRczIxOwK+GPOQvGNld0ZiD?=
 =?us-ascii?Q?K1vLcKlMXSki8nOReYqu32jAYEY7+IWI/BQPGhH8RDxtOM9OkckYTamzRPUS?=
 =?us-ascii?Q?BKHPKtp27WJ/ZyBOeOBtqp7uejP+31JTjx4hVni9EWleJyKLeUAZ1pAPnJFE?=
 =?us-ascii?Q?Hiw+DtroGUVprYehtSY4uUT+xx4FcIpi/VLJJxcHBbALUq4Z1S59yMG8YAci?=
 =?us-ascii?Q?uYRAflN9rC6aNgYsv4iutI/Zesn6g+TMI58gMqj7EcmI6Q80XPINJVU+Q5lP?=
 =?us-ascii?Q?gxUSH3h7ygMafXOBLpyqNzeMwv8sshBlIvb2BD+snNTE6bqPcMl5ThtrF8cm?=
 =?us-ascii?Q?YjtWsWoGOTyVTQGc4UxPLwPTHxS2CO5ikXCcdCT8bXAkg8AGiMBHlSNEdED5?=
 =?us-ascii?Q?bvO6xpTiPbMPbHG5hXCGpvHkY3s+ZSE4VJgVGSqYnseRD5CGiwC5TfWJu4kJ?=
 =?us-ascii?Q?X4Mb6/cI0hpjdJ+88jqACFKepaklO3qg6kZg6LXPnuOtoJUixVRpb96fUkrN?=
 =?us-ascii?Q?wcV8sn6Aw6Z32sd7VCTAkbrhR4pkw33zznP4DWMStuL1GCd31w5jK04nVPbh?=
 =?us-ascii?Q?HrqwrpapJLocflFK4MApSRTY6LkbYQaLUosZ4L0tKLUqZogBe4s1nIvaN0NL?=
 =?us-ascii?Q?bVKbfTL8ndPvazy5E4yMI4Sm3I2X8sKcenlMt4sn/Q1miJCeWTd8J1N/RGhx?=
 =?us-ascii?Q?Gg49H9OlVoGEawpAnIXi8OHkYkPdFORcZBflXeJa5oum82DxaLsPcrFTGITW?=
 =?us-ascii?Q?KYTW1skG+xU5VdRfKaI+SRE349BD6EKOBS4tDEddPWvE+20d5ubfFq/kefHf?=
 =?us-ascii?Q?XFiG5+BNC6+m8NF7BdayQ7Cet4lCTv1UGuCvUOWUyj8vjb4XVTjpH3HTwrEq?=
 =?us-ascii?Q?i03PcegRfIMBcFlhw8ILDsbNFqO5b8s78mVdI5zukM5+7iFxbxBtGwIQ26ZP?=
 =?us-ascii?Q?PHrtuUfZh8kZekb6tvI90vUKob2ljgAmtjp1wb+CsWxIzRvUwBI6aoswC80l?=
 =?us-ascii?Q?fu/VhObub3zPqfRfkyv8TJ7nUBwKhxvWzPJBnHadcplBMrzawheohvSMD+qE?=
 =?us-ascii?Q?TlnwC3Vz9EpSjezFRdBKWIUEkunNlmX9avUZeEcjcYpFlkwKCoSysPZwuKxK?=
 =?us-ascii?Q?TlKtbt93Au45vzfN1nelzof6Iv8dDiTapRa7aQwvjRNSgq57xpL8CpOYtfev?=
 =?us-ascii?Q?FTMIb+TINwEcOEbh2ozrR0nWzoac4O060pWoBC14zQm7edFsEPw4PVW9Kkdn?=
 =?us-ascii?Q?tbBp2JxFqH5uYeFJaXTfCUOzs1N/Z7ZdgpQthtobAphorSHlYhu+juYmZrIq?=
 =?us-ascii?Q?06Daz8WPLCbBiatQVynG2gHt/GS4V83wlA3p8u4MCn+CQDVQJc1kwAgYqe74?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5b76a1-05dc-4cd7-f0f7-08dd56a081f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:02:33.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06JlDfJtfQyf7aS6Umg7C67wMDDQk6ha4EoXYE3JXJfRXiSdr7HQl54B5f3JPc6r7NFykte49CSY09LeIGN5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902

On Wed, Feb 26, 2025 at 07:43:34PM +0200, Shenwei Wang wrote:
> So my understanding here is that the primary purpose of Ethernet aliases in the 
> kernel DTS is simply to provide U-Boot with easier access to specific Ethernet nodes?

This is what my limited experience is telling me, yes.

