Return-Path: <netdev+bounces-68557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918D88472A6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D38A290B0B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDA14533E;
	Fri,  2 Feb 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ajAUcRE3"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2158.outbound.protection.outlook.com [40.92.63.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B514533A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886505; cv=fail; b=hNC/UavVJIoizHg0y8J9t3P/G+lBkSySdBi7LySNXO1WofqvFod17uHgoVcrEyF1bDTS194eYe+qGcWfjWehhQ8XBOZQTla6JumjSBDnzW+dlR+dAqohph+SuHhCKJ2SDaz2GyecBWfWlrTN/kNiATnaAl88I86fzBfjRfrXCpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886505; c=relaxed/simple;
	bh=IK8tzTFaWQBeyh3K+NY8j8ncC259fBUTvPYrEt9aw5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asZftnceasgPa1nWWvBlMbN4VbvUrBe8sF9NoSgeEa3IpCXS7Yvt+LqF3rmjwErBDjuHgTraw855GaLdIW4cdI05PspLbQxf9TTJdPw3NHn69mrp7DiYKzy2i9IB5sVlIc23xqZH4cVZ83cdTTGFFl2H8yeNFhZfy5xkjkYvzRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ajAUcRE3; arc=fail smtp.client-ip=40.92.63.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZfRMTPWYSmQ8xsvAVMt3oZj37OJQGhFTFtfyCFyR0wk1M4nBUncZJL9iC9Q5rWb0PEJ6tBnYCJeailwFHfQc5rG6hD9gi27I2OXSLKkwCvo2mAY5nj1m07KYlBXgf6MXi8iSu3+pPK6gJmDvWvXqWdw28ZN+evrDmorXiUxjiG/0UAz4ntL0TiueRvXBCSDd6Jni+es6wZfFjHQ55V0gxCNCkyFJvtr2z1Z7PQc49kLAyeB2+zWo/siLaMybKTR/kn6h2MaIITVUElcGW10zbt0bMqcKrBR7uTsxzdPTLWVIzJ9VwEArQeDZDuZSBm+HCYLiRsE4VXpeCz0qQGN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK8tzTFaWQBeyh3K+NY8j8ncC259fBUTvPYrEt9aw5g=;
 b=fAV+DAe0kswP0yqDM63VKH0MaBiRINMKdBSPV+8pGJM4HZJeBpUEq16IVUlf5zrRgcEKSYJh2DmQuct5NGShlXRgikrGzIKmq5wGnfbcWiFaaj5jaO7UOT7SkMPsIvOuw/zaES3vOUMagc2lShJN3ZzFzV8iMWchEIzoxq/ks+C4NUpgUbdVgO9IxTms46DEDbOxeEUmqYU5yQgboLqDCj6Pb9VZTeVgSmFy3rwF5dz/OY/ccCPIzSr6Vn93/L7NcYDvjk5rYb8SJVyeDtJUMeeXolnhA681LskX53xtT2Kgh+mI5iD3Xrc4/jrHF4hJm4lfTUOG7bb9aA+6rLrsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK8tzTFaWQBeyh3K+NY8j8ncC259fBUTvPYrEt9aw5g=;
 b=ajAUcRE3BmydiFRdOYi88y6FlCfqf5YTdjhB0UepWuWWZhaOpEzufqyQRiOnwFGnnQ7XGr+WPics+PTDSCNk1DkaT8L7X5BSH4J1tq2KRQY2Zvgtl9tNR+RfZdypz8D7GEClvjZErL5JsodEJDjlpFJeZlWTLs/djsmMDFWGFqQyMG8bCOd7rwotBR8caZleeGIhzvH21yGbRPfBXTHgRKT2swt+rgx6GHZHgpk3Ayo7ESIanEwPwz648VOnBJdUIN7Atntu5X3y+Eh8FVE87uT8Nb7/1aSllHYsdM4ilqImEuWnVP8ctmTr20nsq1Psixow548EFHVkWh7hz/o64A==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3714.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:08:14 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 15:08:14 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: Re: [net-next v7 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Fri,  2 Feb 2024 23:07:50 +0800
Message-ID:
 <MEYP282MB26975577B6339843CDD6110ABB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZbyYbul92taHMPgq@nanopsycho>
References: <ZbyYbul92taHMPgq@nanopsycho>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [m/Yi+4xEUHM7eF0LtcjyO5t+eJKTnpO8]
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202150750.6355-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3714:EE_
X-MS-Office365-Filtering-Correlation-Id: 73906204-8f12-459c-dfab-08dc2400c75e
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fTa61voF783eI3ZA+3oOgpo13LmrOWLnM7zRWAd4LwqRNODHxoF3RtEqVqCY+fkkr7AjiOjKHijU9SvPLPTldPJCEWjWKBg3laYVAIS7d9iYlueTSm6sMsfzOrWZsRFBcCM30aXrANzqyGKpAOzpVXnVsIAp9nRAIu+a5CG1aroMyKX42rbM/O/ZW+vomNf0cQl4VQUfqfKXeGjlhzrjwEC3JtW6Czbst8yJxyOP43mTEaUh/u7/oMUUw1Nb3S92zYdHh1gncfa6MEB+GRGXDK5/Vx9LWUavf3ZjIiUA9xiAAa0Gq7/AK9/1A5BxGhJc1W2Lvvit3VF3uVhmnhphk+QqE4pB7agzryieC+hB39UDn2Y/CaTITrmrHyOFYKHL//1drAuC6oL0dp9xVDGd2LE8XsMfC+IK6bUqEBnAxNpsOoRPLEzPbIQwWdevA31booob3gVOs6jiHD4paivtXMrmxdJ+2tM1+Yl76dcb2OvsK5FIxw/U4NUmO/TU3Ez8e5We4dsiaLnk14gFjP4/BxXUtssMon8LV+kkiSDWIw3p6VM2yoA/Op28yhXTRjrabYec6ZE5PNsnZRQpKNeOFmi3sgQD/+qFUt8i6uDs9uCOp8R5TJugBg58msGSsal1ZkLu6rIaZS6aGl06pvSCLG8SICo5YbRLdN2+h37oN/WuyPXtGnfFEjQQ6qRXOnVJcS93RkYjMpJzi/ic+r43kwsz6TZlFmQCgOg9VxwSRVgHLkq/f0EtX+qG4SdBz8Hig=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4mxWFBFtToPh2LidO/CQ+u/dYJd/wq0Q97PmFcBHXK8i25eaILfnHlYKyslapf1ur7vjOVivn32eOvKfOiaCe3Iy4OBkBHkoE9VtHBl9n6rZJwFGYK1XFk/9ek7ek88PpnWjCn0CK7zbLRr+3HYKzdQ5YdA/wTVg79Z3Or4lAlbgTIx9N6GIRlA29JqR2OA6LTPJ7UhcNuIeW6J1J8Jt0C7H0fOfqdFyz4La+fySpeeC5wM+dZLbBYgV0egBFysMJHt1FE3TNNg7dJSLB5az58tTtX3HYUpgmTdVAO8/JJ1bsNt1lOQ4p00uv2hsWA/I23EMhrfIgxm21SH4Ziv/KOnc8dCCMbmwjs5mpbHxUjyST6gXJhJXeu+fZmtrF3Qkdb5yE1z0qmV9z+oH4rAYmjUj+6Eu82C0gS16sIgtvCNQ8zfjfyiPtREGcXS+w1USp6hNwjjAX9kRkpM7nlFejAPWFv9gmHip6/v5yULzORTGbpUMlTzXxlb3S86QnGrhftIbiFfP/mszeMvxUJs9txBAqaGWsAwr7GqyTm1CynnLquUMHuyc0xlNGeXyFh4EqNUo+j27QuqFUEPMPQH5PneBh9jWTdAatCFjznP/li6hgQZxxOUjpWWAoe/1uF+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jeqRYK2BQ/dvEIelvQTuA2ki/MRCQQyxGQ9umWqYTrhB6ThGr8Z5+dIwxjCD?=
 =?us-ascii?Q?kV4ySMriLYOXy/R2TbTNGbkRvhye+35IUtjGtyL9UukYj4k9PvAxWKPkrQdY?=
 =?us-ascii?Q?hxqcAC971K9pdy0f5Egcx+DN3OHLZ2OS3YAgBxiFdfXrGUEK42StkY1FrnSD?=
 =?us-ascii?Q?3axHMmZmcOZWyeFhL1tfOyEfYj7DEZZ/610BywYnLULJm/PrFu3Qf3EW96Zq?=
 =?us-ascii?Q?kEG+u+S2dbaioWQL7cqKGaXCBxG+XnXWma8YtPcJ/xJl6GLbBbSmAspJglb8?=
 =?us-ascii?Q?k+yyRLZB+oGLkxD0yTLSYKDPau1ddRGEb2z3c1Zpuujj12u2eMrHsS+OijKo?=
 =?us-ascii?Q?vMN8dMoDnIbFoTCFRgLQTk+1f/Sjz3FpQcFLF7B0iakeUzvu20NoKyl3P5EY?=
 =?us-ascii?Q?R/o7SW0ZTv2ihkSiNoPKahFqnk/EM0kuTSKNM1jc90inxB21NLt2cPCZ5EvJ?=
 =?us-ascii?Q?LIOPri57bgZBwqHPL0yDSVAH41l8uzp5Maa7h8BECn0eMguFoah8EUQjg22S?=
 =?us-ascii?Q?SC8oxITmiLG7DTkxw7gKV+D6/f+zgKQT6nVJ+z8N/KOA55pTIdXNz8igegIu?=
 =?us-ascii?Q?2Ii8rEnVhtEdeL2cPtkPdyfgi/+WXREku3Uqf7vmjbGJ3bYUgl28NNdUoCpX?=
 =?us-ascii?Q?IRtdo1gbuQi4+B7AltxXbDkGzR4nzy+WX7uUsWNLtLsJFE2P0SwjGaHSk39U?=
 =?us-ascii?Q?2uKUh8NnX0PJ4xw2DZkwyflHqceF077LVkxnPE7zw3NfiF4ZkpbuqR7ukVJf?=
 =?us-ascii?Q?bQD70//Nj9tQ2PiWoFMf3CIkEfQXbtPkVvLzQHSgIhFgkYfNpjPqvjk4HOA4?=
 =?us-ascii?Q?O/myh57AOgy4fUStGzuD7/jf4R4pkAYsTPi9OFIyTB0Yoau9HnYkY8L21Bk0?=
 =?us-ascii?Q?02rIWD5/DiQY0MUxhYYZDA1+azquX3L/ec4AJ8ytEBpfaN7SJHUZror7L4yk?=
 =?us-ascii?Q?syVDIFDKh1UxylmUYhpBoqPSGkqQtFJnSeiqS8M+n/wdpyW+/XxQmls2sPzW?=
 =?us-ascii?Q?+xp8vnmlvHwAbge4QZPZeCXIpQy0oCfLEijSoaW5b6PvVaQ5asELbykfB3Tp?=
 =?us-ascii?Q?2uKHVpmPe5R3hQuVFjCCwnt+uDuXGzX/+Hok75xYZP+FNioh/2vgPWc07E9i?=
 =?us-ascii?Q?cPNxlEaCy56xlo6JaxL0XvJGlgInrC5LykbXxVSYiQMnpO+xeAkkMdsEtKfV?=
 =?us-ascii?Q?42kF+mweLwNnvqw1BqxrQuTxw2b1MDgS4OgSNuczi/8a0t7btidZqHG6u9M?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 73906204-8f12-459c-dfab-08dc2400c75e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:08:14.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3714

>Fri, Feb 02, 2024 at 03:16:12AM CET, songjinjian@hotmail.com wrote:
>>>Thu, Feb 01, 2024 at 04:13:38PM CET, songjinjian@hotmail.com wrote:
>>>>From: Jinjian Song <jinjian.song@fibocom.com>
>
>Could you please fix your email client? You clearly reply to my email,
>yet the threading is wrong. Thanks!
>

Yes, sorry for that, please let me try to fix it, thanks.

Best Regards,
Jinjian



