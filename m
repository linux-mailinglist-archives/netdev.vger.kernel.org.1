Return-Path: <netdev+bounces-232416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83EC05994
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00F71A6516D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873D3101B5;
	Fri, 24 Oct 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="apIJRd2d";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="WmROuvmm"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay12-hz2-if1.hornetsecurity.com (mx-relay12-hz2-if1.hornetsecurity.com [94.100.137.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EA30CD9D
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302082; cv=fail; b=MFZREiUag4zDAxxXSfqXFHUsFUhXgxhUL6Fg3Vz6IaQJnyeuDZkNAjxljBJPeVXrH9tbqwwKnhdinsJjiKrbBSlHy5M81qjTwvRSs//LSacOD25M5ybx0AETz0jHmvdVLhs1RhR/PwYrykF+ds3wnh3rALA9Ejq0Ps4uul5inKE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302082; c=relaxed/simple;
	bh=hoa15FttkiQ+p7l5l7yiqbfRBb4bAoM5FUj0hYWgFI0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=fdntTRPo3HqrEOVhQ/Dw04VgfxOhtV1MpR9KyX/UnrNb1m9XuRtyg5HRe/R6MQ0+3gvr5Mi5RuwYLzXD7rxBms+GPvOagXSMIz+2hjXXgkQRbVNkK7uAS2/KBJ3krdpGXloiey8jTvQTY+0aC7Q4zlypqCkQmWgD9TTlndnNyQQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=apIJRd2d reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=WmROuvmm; arc=fail smtp.client-ip=94.100.137.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate12-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=u4mHTHFIn007KGWkwCvwBKHJviHdkBG2mT/Vp2ORbrY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761302076;
 b=JFJmJFzG6zuXXQ1JyhmAkJHkxTD5vh7GL1ZJzTHTDKuNnUCDD2o9i0aSU1N/0JotETncxqRy
 OtpvTzsE1iGz2tRr6kJ3XNSbbJG7vq3HKqinDaa7XThRqKui7PBobAWocwd5WD3/+FbJDWtQf4Q
 fpJvjJMzstCw1qJCEe1noYhDIpVM9FnDdVTt00TF400TTlAkIxO7VvZqtZNVdn4XuS3XVfre6Gl
 D4qyY20l5A3Db+hZejH0aFxeZ+zcdCwdvLw/OR8XTqWhN7rZ114WoIxzTWchdKz629vCyQz8q8o
 xzIzV1yOg2Pv1ajpLHW5LUDbxLt6EZdXLlmtexpk68oiw==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761302076;
 b=UKqa7Wsr5Fnd3DpDLi62mF71KITIHc7b9KGAS4HNJhlVcZkZajBXYv1PxjU9HMK00D6iLBqw
 i0hnncmXTLjnV9feXrqDeu4YYXouakrAj9mjZyHA5KC98lMnpSd7zz5nWQE/1pXznMv6H1DBbcZ
 Gm3s6Jcw40W3gsXs5NKdu6kx9zeJAG5xHMcT+Dd3sMdHZZL5mtp2pyPnM2p2v6Az3Ij9lQMnOJE
 CUuE1NcEzJQT5Zeb/HQHGFhW+OQTA0rYh/thoAu3p77CfmYXF3XadmUSuyPg+0zCHZH0FqZOvFp
 dLQ0c9coRgLH7IpwS/mYMYDGp7AdPtF331PepHoW78WPQ==
Received: from mail-westeuropeazon11023102.outbound.protection.outlook.com ([52.101.72.102]) by mx-relay12-hz2.antispameurope.com;
 Fri, 24 Oct 2025 12:34:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACZWVV2cXdD2JxKn7kBpw/EdmHDKEzes6k/HCbjuZghNMqJDIdliy6j+0w88SF+R2nstQXmrtF/00qPW2twsgJacvmOiW6Mlr91JvzaSXmfNZXlUHIXZDDhw/DEzs3WEmsOr7wpPprgeZ2/lNIjRziIbys2MvtvPMT2XiPacXdjCUzQkEsT1LxsLKuUItAvBofna79mh9ksHsSoh8l+R5L6yop30rpmDXRS5qPmC9oB5gLrZJHqACEGuqf8rJq1RKCpXfNZjFW7CUGZf8ancoY5Hk+qAEwOG651Y16GllE2IfbU657XvZ3ogEuWbCdsR+O/qxtFZknVxK5+7y4d22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP34AbGCAF951MDU1QqZcjIA3CFrttwuedmPpb3u7u4=;
 b=u3WOk9nuAa4HNeeGpv1NtYLHnAbuMbSqRNbFnUHAhhEte710ZfTOubXq8o/Yy1IFHI7b5uq4YSGuQmvMRDG6FzcTVGd+XrT0pr9AWIDemcA6bRngYIQTpGzvX+oSyfJfAlubqqHYotFkOv7GKDwXwOOQz2cyh64S2PZxdvOohnbvrdxgZUuQDcIqwDt4cZeb38K2hXCmde5BcHHe/gALF/LIshN3a8UeOMBQXdi2DTsAZdV4eX8lmNwHN8jpIVcIoJVtc78rn6BU/H3QFRZAuN0Au1idMimTHiNRNmHAG/7idC6kJi8l0MTR20fgBOUkjt9mEIfjgAQ2z1Nte4WKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP34AbGCAF951MDU1QqZcjIA3CFrttwuedmPpb3u7u4=;
 b=apIJRd2d1zYschC7asLxSqwvKERLWJgF5wLh0Z5xMdQsci71G3KhisJifyZWndTc1ZycJwJhBLoOSMsRWI+ACfjU4bdBC+Rcf6+BigcflRwkl1um3TgI0tK3CGZC39KapOPZV+OgIIOS44yQbi3GftnNeXtgONhQwqPKmgdOdU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by PAWPR10MB7789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:34:04 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:34:04 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Fri, 24 Oct 2025 12:32:52 +0200
Subject: [PATCH ethtool v3 2/2] module info: Fix duplicated JSON keys
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-fix-module-info-json-v3-2-36862ce701ae@a-eberle.de>
References: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
In-Reply-To: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761302040; l=4189;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=U/bDmY+8p9INT6HMl3Hvi429795RwLlBE1s/WRaJPCg=;
 b=xVrPu18qfLe87eJ25/aDL7vvP8pDNoSIpjCo9sdxbY+ZRCQ26xtVY5sSjiMAmfye6kR4o5O5E
 STga0Z6VsDJAUV5q3BIUNW4iUC4GXgOqeDKLWIISzTz7BKKYROEdLY0
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|PAWPR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c08cb69-c422-46c8-53de-08de12e8dace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE1LSHZaaGpZbXhZZExpSWpSOFpKdnRtOG5Yejc3c2JtekdhNFBEcW91bjdP?=
 =?utf-8?B?dW45QUhoaDI0UFNlckFWb1llN0ZwLy9hRVc1RDE2amRuRmlOOGF2bHFkNjVv?=
 =?utf-8?B?emVqK0hDdjNaNDJObHVzbU5zQ01MaHQySWxMQU1BelhaMmdHdjdTYkNVbXhm?=
 =?utf-8?B?SVlPeW9HRFIrN2phMVhORGZ6Uk80YzJEMnVENzR1ZmdZeDRLVWFBazEzWGFu?=
 =?utf-8?B?SjNGU0h4Wk8vT3JZZHVkdDNIMksyQXp1WERPellOdHUrQnFVNVF6TzlHMnZm?=
 =?utf-8?B?cHVreDRYcEtXNjFZblpwbVRLTEUwZURiSWs0TzFEWWd6NlVhRUJPSm9sZHlt?=
 =?utf-8?B?b01GRXlRYnhGdXpPSllhV1VYVXRoWWx6Slg4b2JDc3RLeGNMQmJsZXhwUUw0?=
 =?utf-8?B?U0R6L1NBSEJ1Wkp1K1RYb3N1OGpZTFUxVWFkRUV0N3oveG5nTnJWS0FKZmdL?=
 =?utf-8?B?TlljcHhHRGV4T2dmeVdJQk9mMEVJL01kcTlhUS9vNTg5ajk1TFRjWHNKdmJa?=
 =?utf-8?B?WldqVXY4bDMrUDFRK3ZPajZXT3gzeHJRT0tTVjJmSFBGRW5YRHppMmtkVnpO?=
 =?utf-8?B?SDVDVUFTcGFKbi9ZbjFwbFFJczB5Y1BTSk1lVEFiNjhvemd1ek4zOFFSNTM0?=
 =?utf-8?B?cllhNUp0VWZ6OWh3RlBZYTF0NDgrVnBRMC80eVdGQnE2L1lWa0NQZHZBTXhj?=
 =?utf-8?B?M1ZGejd4SkJtay8zMTZrcjZOMlNyY0x0MUpyVlpSdHk4Z3h1VktHb2xlNnE4?=
 =?utf-8?B?K0ljN0RpbFNiQW1ZTVlZeTJIdjhVOWZ2VE1CSVVHcUtzTE5yQVhiU3RVSXVx?=
 =?utf-8?B?ckx0azk5VDUwa1VweUtSS0ZWWGVUbjJ5Z3lLM2VyQkFWbHZMem5MN1Vld0xB?=
 =?utf-8?B?MlVkMjZFQkNTZG1NcXBtTm9KaC9FNEN0d1l6TnpmWlNDdnMrSlZOU2hkS1pS?=
 =?utf-8?B?K0lNZUh4MnJGQ281Q0xrd2xqKzRXV2xyR0RWOG84ZzBHMW9raEpvOTVJWkpv?=
 =?utf-8?B?T0lIWlp0Q3krTlN6QTcwc3pOcjJUQWpEN0ViZWFmYU1reURsT2IrWnYyMVFK?=
 =?utf-8?B?dkl1djIwZEZ2VnlaSzZDQzlFRDc5cERzTnRDc2crckZrOE9HbitaaGxULzBV?=
 =?utf-8?B?K0RVNk5XNjkzYVcyNDcwOUEvRGEwM0dab24vanZiSkZSRjhUbWpEN2psWkZE?=
 =?utf-8?B?QTRoRGlZRXJRZXJjVDZIdWNENzFsOVVQQllLU29CSXpJaHhXVWo3Vk16QW1n?=
 =?utf-8?B?aUcrZmJLQkZEV2NpQVpoSWt0SlJGNlNTckphZkd4Y1FuQVV3ODljK0dPekNl?=
 =?utf-8?B?V1RNRzY0YjJ3dU5TMjB4cHYzaGhxOTZTMHozYzBHN3VhRWlpRnNpM2tNcGdz?=
 =?utf-8?B?TkRXRlFycy9SbVVxRTBUY29sczVTc0FyUDRUUmtxV0VoQTFsTDZadHUzLytw?=
 =?utf-8?B?V1NWak1VZjB3WFFWeGQxZlRlTXIzbENmMXRJTkNHSHg0RkxPUTlSYzdWNXla?=
 =?utf-8?B?WHNOdytRU25ydTlwdUlUaTd2UHV1cWx0eUxuaG1yLzh1RmsyS1QzcS84SmIr?=
 =?utf-8?B?RzFtVU9mdHQ4dUluU3lFYUdYSTRod21CcE92U1R5Y1VqQ0VWMER1QXppN1JB?=
 =?utf-8?B?M2hhTEc3d3U2dlpqQmtXNVhudWlOSDJrekI4Ulh2TklDS1Zhc1BGVndZY1ht?=
 =?utf-8?B?VUh5QzZQaENQVHBGMjdFUW1BdmFEa1V2RHR1VWpYb0tCWWl4bzNEZFRhS2JW?=
 =?utf-8?B?NlBnRlFydjVzNDdIQ21kNDRLcnN3K0FRalEyeTZtRElObHI0Y3ZxRTlaL2cw?=
 =?utf-8?B?enpzS3NrS3Y4R0ZKUVZCWUVLQURiVFQrNlA2bUZlY0EzT1I0ZVZiNmczU0Vk?=
 =?utf-8?B?dS8rUXR3U2VPalpQL0hGclk2YU9DL2R5UkVOVnA5ZGJZalNBdlRwUmU2SVU3?=
 =?utf-8?Q?OGO1Dm86SlsmNO83XQKbXL79g4WHlw0U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czIxNktYT3dPTkRMdlhGcjVyaHYyL1B0M2ozWVpWZ2trZmVkT3h1RGh0RzVM?=
 =?utf-8?B?Q0NOWklFRzhPVXNwVXlYczdlcXZNbHc0eWdDcTg4T05scndhc1FVKzBkUm5t?=
 =?utf-8?B?SmphQ2Fpd1hxM2NtZEFsa3NWRjZzMXNqS0NGdGpqWHNwcGltci9ONnZXbkNT?=
 =?utf-8?B?MnRFWkVYY2VHcVBUOThzTXZKUmphcHJNeTIyZDNUeGN2WnIrQzhXeWgvS1lB?=
 =?utf-8?B?b1pubHpzeUd2Rk11WGVmaWhtOTJLcjdnTkN4TmdBSXNyZ29UTHlMeU1YYm1z?=
 =?utf-8?B?RWlqTTlkU1BhVkJVZWs4b2diUFpHNHRPMWQ1ZGJTN2VpS0lxYnBDVTVXeGF6?=
 =?utf-8?B?czJ5d1pTVyttVDExYit6N3QvdHR5S3BTakdXM3M1MVduajhBMUFDa1dMbm02?=
 =?utf-8?B?WFZHVEZINnZhMk4vYUJ2UDRKK2I5UXdtWHp0dzBkaWVYQkhYdTJJaGtmeFVB?=
 =?utf-8?B?ODE4R0Z3MnJxcVhMZHNFMGpnVHArVUE4SGZnWkJzN0ZUUW5DR1hweUdXclZW?=
 =?utf-8?B?OE15bytTQTM4RjY1MElSWVUxK0pubThjcjFlZXkzV25LK0xNTjZEZldYTkh1?=
 =?utf-8?B?Z1J4QndRS2N6M1pTU1JoRm9wSGFrOEJya3FPa1c0TDYyc2Z4YUhKd3BwM0lJ?=
 =?utf-8?B?Mi9YRUNoc3Q0VjJDWVJ0NlVrZW9QOVphalhQbGtoT3dxMWxyWEV4UHRTc1JO?=
 =?utf-8?B?V1F3UkwyY3p6ais2WDA2SUlaSUVHNW81VmxIV0YyamFwZXArellOcXVuZkpH?=
 =?utf-8?B?UFFBaURSRGdsRjJYMXRyUWZHYytkeTkvaTRPcFZMWjcydUJWUjVJVWw4Y0Nv?=
 =?utf-8?B?NlNkTEN5UnpoRTFRQ0xxU3FpK01aRXE5U2NaZnVBTklGWEJ6U1d3d3dHdkhV?=
 =?utf-8?B?bXFHNUxLL3JDRFdJK3BBSDlTNlF6WHpPM0ZMV3NjN0NWYjFxK0lsOFYxM25P?=
 =?utf-8?B?bDd3bmZEb3o5THpqV3kwRE5SK2VXMUpLUkFvRlk3RXF1a2pJNTNwYzZId1Fy?=
 =?utf-8?B?cnlka2VaV1VGNVZRVGRxSlByRU9VQm5xVWV4MTlXREhabmRwNWVnRlJyYkNz?=
 =?utf-8?B?NEVDR0d1SmUydkxtdWtycVJIVE9DVERSeUtHelNHRFZ1bGQxTTNnTkg0VEVi?=
 =?utf-8?B?UWZybEl1RmNZY0VMMVVwM0V5QUcyV3pKbDd3RlNiZ09ySEdEMSt2UFJTb2FI?=
 =?utf-8?B?d1dFdHV6Y3JpT29JK2ZESm4rOHVJQzJ1L09XY0ZRWm1DczVQWmFQUGVSYWhZ?=
 =?utf-8?B?UHNHSTErUFZOU294MjRPaU9XY0czOURLNk5XazlPWDVQNXBxdUpMdjl5bnli?=
 =?utf-8?B?bXpUL1RBWTE4MWZZME83M2VjZFBwZEtUckZ1RHUzZnd4K2Jtd05IMGlVTGln?=
 =?utf-8?B?VHQ0SUhZR3EzZ2NuYk43akhCdGVISEs4ZVNTSmlya3YwOHFpbktLaEN6eHk5?=
 =?utf-8?B?NzgwRVhadWdNNU1WVUd3YXYySTgwOFdCMCtaTnVTZDBsRlFrMkhFNWZMZ21k?=
 =?utf-8?B?YzhETy9HemQzQ25pbHlKY2krTFd3RlVrSTl5RTJaazJMaG5VSW9TM3g2aVV2?=
 =?utf-8?B?eGVZSkZxVCs2WThIeXQyZytPN2VubThWUFRlUGpFOFNPWjd5Mjhid2lFQmFa?=
 =?utf-8?B?ZUNXREZBdWZnbC9LaEZkdUZETkQwdFRicVFZYUt1aW52WDRNbE9nbUlvTjlC?=
 =?utf-8?B?U2VXVm0yV1NxSURBUVVrN0FrYmtwNkJPNm1ZSmsxenQxZDBTQzliQlJSekNx?=
 =?utf-8?B?SFI1cHRQUUdqVTVNQ1UyTFlwTWFrVmV4alAwTXFMMTViL2I2ZkFObzB3YkM4?=
 =?utf-8?B?Zjd3djlRa0xvWldUNEVBd3NlcFlxcnU1bE5EbkR1NUovdHpnQUJ4dExZYkk5?=
 =?utf-8?B?aWFZaXp2ZWtBUU92dmZTcVBQY0ZPd0hyRmZSWlFQRWdaN3kyUkdyUGlOQVpp?=
 =?utf-8?B?dzFFcGZPbFl6a2M2bUhWQmZPZWw0VVhScmNUUkpwZWtsN2ErSmFKSDVncHEx?=
 =?utf-8?B?TENwdktkRHRMcldPSndTUTNpN21yT2hZRS9iT3lrenNPLzQ5d2tsbDI5bVRI?=
 =?utf-8?B?T2JucFZKZ2JhZW5CVzBMTERmK0cvSEFQay9aM0N5R216S3pqcXJrVEVvSUN1?=
 =?utf-8?B?VmhJVDlJajVDejBCQzJVNGFGVU5CZ3MxTDBKVE1PcHlMSzdaM3JURmZvbTBK?=
 =?utf-8?B?VTRra2FtSXkxMkM0WkFTd240b3ppL1NzTDFWRlVZdDdncy9FMC9CMmtzK20w?=
 =?utf-8?B?cFhOWXVoeDZ0ZHJ0QWpSeDdQNjZRPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c08cb69-c422-46c8-53de-08de12e8dace
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:34:04.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfe6CRFvzFf5scJk6zzy4bToJbekN9BP4S6LoieluW9kiEWt1m39fuKjOa5uOekZKXFO27QVWg7GYtKWGybVUzSeBNXMI6EJYIklEvu+BMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7789
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----3036EDC7C7DDAFDA778D182BA4185618"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay12-hz2.antispameurope.com with 4ctK5Z3lcQz3BJsr
X-cloud-security-connect: mail-westeuropeazon11023102.outbound.protection.outlook.com[52.101.72.102], TLS=1, IP=52.101.72.102
X-cloud-security-Digest:ef0e604dbd8b50eb248331f43ca2f63c
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.683
DKIM-Signature: a=rsa-sha256;
 bh=u4mHTHFIn007KGWkwCvwBKHJviHdkBG2mT/Vp2ORbrY=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761302076; v=1;
 b=WmROuvmmC0ClUmUyxZO9Ni5gJCVdsbEz2Kkc5m64UdqFv65z+lKEQ4Wzg4l1RupBcKV7Z3QL
 LZXH8A5z+Wy5Lgn/VtXjs6rnznVEfl3FW5qLn3TiHgiFnsV4JmhLBoGA+XeH/2jRwmrKa8mdveu
 veF5tsbX3ffingb0J2WzU4SkjddJsuFCrsWWJ0JWJVCcPLVZkPV4wmy72M7n/TLDSX9OXHTMMIf
 PWXn0KRXUn6cVC6sdtLQN/sblJsciTKKNy64f+IjptZkn+5TXu+cMftf30WVntYkEe5PLDIaV0n
 D6RIUhE74IsVwAX0H2Z6v9/m/D+lq2g1rnlgHU3m5u1HA==

This is an S/MIME signed message

------3036EDC7C7DDAFDA778D182BA4185618
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v3 2/2] module info: Fix duplicated JSON keys
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Fri, 24 Oct 2025 12:32:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Fix duplicated JSON keys in the module diagnostics output.
This changes the JSON API in an incompatible way, but leaving it as it
is is not an option either. The API change is limited to the following
keys for measured values on QSFP and CMIS modules:
* "module_temperature" renamed to "module_temperature_measurement"
* "module_voltage" renamed to "module_voltage_measurement"
Keys with the same names for threshold values are kept unchanged to
maximize backward compatibility. Keys for SFP modules are changed as
well, but since it was never possible to get the diagnostics in JSON
format for SFP modules, this does not introduce any backward
compatibility issues for SFP modules. Used key names for SFP modules are
aligned with QSFP and CMIS modules.

Duplicated JSON keys result in undefined behavior which is handled
differently by different JSON parsers. From RFC 8259:
   Many implementations report the last name/value pair
   only. Other implementations report an error or fail to parse the
   object, and some implementations report all of the name/value pairs,
   including duplicates.
First behavior can be confirmed for Boost.JSON, nlohmann json,
javascript (running in Firefox and Chromium), jq, php, python and ruby.
With these parsers it was not possible to get the measured module
temperature and voltage, since they were silently overwritten by the
threshold values.

Shortened example output for module temperature.
Without patch:
  $ ethtool -j -m sfp1
  [ {
  ...
          "module_temperature": 26.5898,
  ...
          "module_temperature": {
              "high_alarm_threshold": 110,
              "low_alarm_threshold": -45,
              "high_warning_threshold": 95,
              "low_warning_threshold": -42
          },
  ...
      } ]
With patch:
  $ ethtool -j -m sfp1
  [ {
  ...
          "module_temperature_measurement": 35.793,
  ...
          "module_temperature": {
              "high_alarm_threshold": 110,
              "low_alarm_threshold": -45,
              "high_warning_threshold": 95,
              "low_warning_threshold": -42
          },
  ...
      } ]

Fixes: 3448a2f73e77 (cmis: Add JSON output handling to --module-info in CMIS modules)
Fixes: 008167804e54 (module_common: Add helpers to support JSON printing for common value types)
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 module-common.c  | 4 ++--
 module_info.json | 4 ++--
 sfpdiag.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/module-common.c b/module-common.c
index 11b71bd..4e9a0a7 100644
--- a/module-common.c
+++ b/module-common.c
@@ -651,8 +651,8 @@ void module_show_mit_compliance(u16 value)
 
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 {
-	PRINT_TEMP_ALL("Module temperature", "module_temperature",
+	PRINT_TEMP_ALL("Module temperature", "module_temperature_measurement",
 		       sd->sfp_temp[MCURR]);
-	PRINT_VCC_ALL("Module voltage", "module_voltage",
+	PRINT_VCC_ALL("Module voltage", "module_voltage_measurement",
 		      sd->sfp_voltage[MCURR]);
 }
diff --git a/module_info.json b/module_info.json
index 1ef214b..049250b 100644
--- a/module_info.json
+++ b/module_info.json
@@ -47,11 +47,11 @@
 				"type": "integer",
 				"description": "Unit: nm"
 			},
-			"module_temperature": {
+			"module_temperature_measurement": {
 				"type": "number",
 				"description": "Unit: degrees C"
 			},
-			"module_voltage": {
+			"module_voltage_measurement": {
 				"type": "number",
 				"description": "Unit: V"
 			},
diff --git a/sfpdiag.c b/sfpdiag.c
index a32f72c..137a109 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -254,9 +254,9 @@ void sff8472_show_all(const __u8 *id)
 	if (!sd.supports_dom)
 		return;
 
-	PRINT_BIAS_ALL("Laser bias current", "laser_bias_current",
+	PRINT_BIAS_ALL("Laser bias current", "laser_tx_bias_current",
 		       sd.bias_cur[MCURR]);
-	PRINT_xX_PWR_ALL("Laser output power", "laser_output_power",
+	PRINT_xX_PWR_ALL("Laser output power", "transmit_avg_optical_power",
 			 sd.tx_power[MCURR]);
 
 	if (!sd.rx_power_type)

-- 
2.43.0


------3036EDC7C7DDAFDA778D182BA4185618
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjQxMDM0MjlaMC8GCSqG
SIb3DQEJBDEiBCCp6F2jqRw1VpxUk3LceLGf1/BV+/XsAAtUQVOQpfClTzB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgCKkj1FQ2PS
T0uyQnjZhO/lE8dltuXzbbhx0kLrL1xIe4RpB/5AcYlRkF/AmlBgEKmKqYgkFe17
Ipet1Ph+qT+bGGiXMPScxYMzNZj5W2NgqhMwTqPrKXnId4RbQm3TuxJA0NkW5BNb
sNfUOAJFKPAlUg78xJVTfRzUenLWbAA9Q4xH91kQh+YCBlUh/h8jRXQoPGeI6VZ8
1y6rjqbFanJlYDWvBiOXm217qbhDMA5/BaAV1wLTILZfLazdnEmuVL8PmhI7PfR6
9KmAn8Tt3mMPsdppM8vI5vU4/VulW3TgA4aaXuBFhEO/RHguutDzvRX4Zso8+UBf
IyfiallJsRMd3ZdDagoMdW+l/ngGZoxaTzNVYPAvqKcWMsEqExczVUH64gDJufnA
tnkqG2xZtco9trXB/j+pxFqOEN1QuZVk5Hj6t19en6XAP9DNnjJbVQg4pYahTROA
x20qvb2xVmOZPd9L+lNQmP93b3pMIMcnVfGWOqax+bT8ne7/hwXwmuSJ7HlUze8p
y7kOmXyzg9CsD0srRRrGTirX4q6a1FaQNvRC9NLz3EZoZbNxPW+MFCDZRSCXD4JU
69PuOusm8cFah79Ec/T6lTy8jdbqDBFIhHG1RyFL2cKjAf+2MhG9OiKquRbPluNg
9j6aeXtiI2/rGMA1L63bdb5vbNzqQTKdZw==

------3036EDC7C7DDAFDA778D182BA4185618--


