Return-Path: <netdev+bounces-211576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9DEB1A3B4
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12ADA3ACBE7
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CC25B2E7;
	Mon,  4 Aug 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MRzyBPjF"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EB26CE12;
	Mon,  4 Aug 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314981; cv=fail; b=XoP84zwWNU1N1k3oViCmPf26F0IzSMCOveBJXlN1580LIH6JCGJlNDzrMnrNJKJFQubvp2es3jjTe5TEO+F70P8TteJy6tgMrC/z9upLYHNbgl6lu7VTYezgwuowQ8HE0EbWJG9CePfaE/EaUEUl/7YgG2nYuwLm+jtEWCbbYGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314981; c=relaxed/simple;
	bh=/A7e6Tdl8wM3qXSITE7wweGW9IoU9vFMiYXxbJO6JGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8myxZiQAlCP742u31bp9PMWDNisAFn1uDeraS+qTs1RV+Cr8DjWxvi2aUkGRjBVtZAiHA8RyIqpwGWmntpkMfS/T3n0KcoI3P1K6neGvF7xY+RXsNsaoClHZ4M9f7WLsg4GByBxwrMpHeRjlnm4qoKOo46/stTjmmjDy7VPn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MRzyBPjF; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/vaNdynffbzGwFyBrLPVQnci4HdAsu/ZJG74RstANSLi5U+4pwwWVn0D6SMYe6rbj/vEpfp5ZXpymPZslDNoN/D7ceeXIT0NL0N1LUs6/8vkKCEQ83xJ0KpDU1Kds2I8A3FfR+Xtt/TkxMXqYZS7QAFdMEDQWT+btcAQBu6tXlZItTdyx0to5Z3fz21ywLbuKaP9Jas9SSMDGsu8ZhCdSI7ym9eCS+Ai/V1+RVexWKJo1Rd67VImzEvtMYZjV3fExP2hjBEcxbraclqL0FlCAzm8wPy3Km+49625WmUfv8PtGWtZW4srn3R5Iu1SsP4eQdypdI664UAk1C7tbttqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY47VLEAsvrz0279aB5AML8uokyM398cKM+W6L2IrwY=;
 b=mNlJTvJaTMeQPbLL2bTdph8KFLVMARgViqPdXpoQi13ns+weS50BEoVkYIsDlGseA8vBQA+Vo+ZRL3y5LRGnBDRBXJXplKubVcM2X1MdrowjyR7556jVpmNCShEXa9i+zV2Tt7nY0rNExIGPOraRcjC397b7mnSwicRFPZ179BZSaMl+ROQBt4O+/l+0PpLpbPLvkKTx/f2MVufc5uES2hlnvmzAMz4H55v6zfhUy95s5I7jIN1h4ztKf+zkQvPg+eqgChMWwc2/j8pI32RxjhYLzZzdeyGtXzK+BUmz5oMnhDatp+FVGH6Ny44QOCJCHOs+suBbEfNDriNZk58tCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY47VLEAsvrz0279aB5AML8uokyM398cKM+W6L2IrwY=;
 b=MRzyBPjFHwM/4+bkJnmCsq/843o1MI0sZEFL6CJXOzLzu/uXl5h0Q5lOoe4vghpwRTMy5wVnufQF/8nTpnYmNTdRLmWtLH68EK3oTvmA2DEmJgKXiAo2Ypx+DjQe+nBiU27FHlTrUjrEKoDoK7Q/XbAgbCx8s3sI8SGr2PFDX58z1xJ1+kTMDx/z/uGPuBf0PGAAbBYTdLRhrkoT9cqctiDi9bUe81kBoRkyaPgMssdSoSCCg+3Y+jskq44LNCI4WRuQeoI2snwOfKBOcEpBzKLgxazz3aZt611obdbLKvqfu24G9k7zu1ORQ1z0GrzbI0F8vYI4e/WEO1ZGa0ifBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8406.eurprd04.prod.outlook.com (2603:10a6:102:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:41:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 13:41:19 +0000
Date: Mon, 4 Aug 2025 16:41:15 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250804134115.cf4vzzopf5yvglxk@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR10CA0115.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f2362e-350b-4c4e-30f6-08ddd35c9786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXJ0MjVTUXhzYUhvVFlnYUVqZTMybHZqMjc0cnJ1QWJOYWpXY0xKNTR3a1dq?=
 =?utf-8?B?cGFZY0ZWNVFVR1pxSXB5dUJGTEJuSmpnMmV2ZHJwbnNHZElSZW9GeFVMSEZ0?=
 =?utf-8?B?eGdkc3RNOWZZVVRwakw1V3VudFdmWGZON1BZRk5xSzIzNXNmUkI0NnNLTmRx?=
 =?utf-8?B?d0s2Z0o2Q3JjUnhnckM0TGpLVkUxZnRTcjI0emZFRnVxZDlrNDBlRlBBN0FR?=
 =?utf-8?B?QVFiOGozVVl4OEZhWTZPek1JVnpqMlN3bGJEVGxjWEZFTDdZdndZamM3YjJL?=
 =?utf-8?B?T21tektiellPRmhLMGhsQ09tQXcrWTVBWEZDS1haVU9oQ2YxRUEyWW5ZVDdo?=
 =?utf-8?B?QzhzVzRIOWJueUg0dUsrdVloeW5wTFdmdzA1Tm9wMG5JSFA0YmM1R3JCWUN1?=
 =?utf-8?B?ZktkMi9RK1h6b0xTZXJQdlFUbHhwSlVaVHRBdnh5YUptMlo1QWd0em9NK1ln?=
 =?utf-8?B?R3FibFVGdThtNHkvbUJ5UlRaVmJMWDdUTkFvcmx1SHFlcUxPNFd4QXh2Zmhr?=
 =?utf-8?B?WGJyTUg3S1k5NkVyMFNHb1RiK2NlNVZmZGVLRDVSa2xSdXYreTZacTc5MGZG?=
 =?utf-8?B?L0JXVzNwR0JobXVaQk5wUEt4NzRIcFFPa3BRSVQ3TXR0SGcxaGRoTHVEV3hC?=
 =?utf-8?B?aDdUa0s1NmVXMXVmRmlvamZMOXRJSHMxRjJzeXFXcFFVTGFtTmR5d1BrTDVt?=
 =?utf-8?B?OEhWRlh3eWFJL01GWWU5UTFEMldVbVRmbWtRcmxtWllWM2g0N0ZHaUdhc0hq?=
 =?utf-8?B?aFhoR0VZR0ZVN3ZNT0hoR2c5Ky80UHp2anJwNkFNMlp2cUpCZWpIdDA0TEpU?=
 =?utf-8?B?ak5vYkFsdFZGdWdoNXZwWjJBT3djM2hMT3dMQmF6ZmhQQVNUWU9kMXV0bVAz?=
 =?utf-8?B?TmZOTVFRNEpwZm82aU1YeHhhRnYxQkxjenBYOEVVNks5Z1g3V0gybDU4NVFJ?=
 =?utf-8?B?ZTR2dm9yOHF4LzNWT2dJS3pVTzZxUU0xY1BIWk5lekVKT1k4Y2JxSWF0MFJH?=
 =?utf-8?B?Vyt6bkFaRFJzVUc0WFRZdkZ0RFVzSWx1UnJkM3F1RW5TYUxHRVJpMzdZYlZi?=
 =?utf-8?B?SC85STdYYVc2cVowZzRRWEFaMjFKN3RBOFBsZFJoUXNJWlpEMTc2SU5Zc2RS?=
 =?utf-8?B?U0pJSjE5Rjl4eHJFK0pBcDVpZ01FUk1ac1pmT3N1enUxTk1lb0NNS1ptNGZo?=
 =?utf-8?B?WUhCR0NmR25PYUJLcVhLY21jNVBqTFI2SzBBOFA4M1pLMGo4c3ROVUEvbndX?=
 =?utf-8?B?N1FCL3hlK0dsS1I1OC9ER25TcSt0ckQybC84YU8vWWx5TVVVdUx0WE96WnM5?=
 =?utf-8?B?S1ZGMXd5Ym5yaFgzL0NxcGk0REdLTG4vK2RxNU9leE1scUNVSTFPNzBmaFdq?=
 =?utf-8?B?eHk4NWhpRElYTVIwczFySGhKRUtGMERUWitNcm5EaHFWUVovcEdzYmdtOWxs?=
 =?utf-8?B?UUxUUzZUeUJvdE8rOVlFVittcGpoTEJULzhCMTlzblZlbmJXYkNqMi8rNExp?=
 =?utf-8?B?cU9pLzhHenFkbnpMdEJNMTFoeGsybml3ekhzUXplaWg5RlVDZklkMG9BV2s5?=
 =?utf-8?B?ZGFjVlprL21BOUNoU09Pcnc0YmtBWEhwQlRrZG9wZGpFamtHYkFBUlFnSFBX?=
 =?utf-8?B?YzRpdzlybWtuZDk0cHVOdS9nNmJFTVdKRUtvOVNJbVAyNDZZWjJCTVhJVTBu?=
 =?utf-8?B?Vjk2U0gyUFlTUjZnbEg4b1JMK1NyR1dROHBNYjJZcWo5cU4wT3c2YUE4cmpK?=
 =?utf-8?B?bWQrTGtjclpIM0NoaVBZank0TzZyU0lYV2FOOSsydysyYUY1cmxOeW54bVhH?=
 =?utf-8?B?VU02Ylc2TVkweTBpaWNUTkhZMHJjSlc5S1Ftb3lES3hpMGRPaGR6c0Z5eHFG?=
 =?utf-8?B?TjMwS3hlbW9HcDZxczRWZjhEWTVPUXdNWHNVT0dETnl0RHNQcVVOS1I4VVg2?=
 =?utf-8?Q?3oVOZJO5Bv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBtLzNDa3lHODd4SUk5d1FsOERpUkVkTjF1NlN6dnFlT1Z4MUVqVzd1bTJu?=
 =?utf-8?B?Rk5jT0RmTCtwVGFwc1JOam5NYjBNQnNpLzkwZWtoSDBGMEhRTVR2WUg0ZGRJ?=
 =?utf-8?B?bEVpaUhwQnZXOFVoVUFpRVNxV3ZjVnRodDVDcXAweGxzU282T3loNm5WWGlZ?=
 =?utf-8?B?M3llWUVRL3BRL3hBeW00UG9RMkt4ek9HcTYvTFhCbkhWN2F1TnNWc0xXTjFL?=
 =?utf-8?B?cGJhNmx6aWovbDZVQTE3SDFKU3gra0dQd0JJYzlsSmgzaldrSXVIRTBEeXcv?=
 =?utf-8?B?OXQvUnVaeFBOT05LQkxWVHY3U2Y5aTYvYytnWnV0cXgrcnlCMlYvYjNDRjN6?=
 =?utf-8?B?NHZsdWtEYkNaV1VsSm9rNkNhR0RIYnh2cTRBaEhzSDFmakt0WHA3ZStYemFR?=
 =?utf-8?B?NHFBMWRqZ3lyanlpaFVUUWZiODU5M3hjVXYxZ3pOeWdCc3JsL0Z4a3F5dWRS?=
 =?utf-8?B?eFp3bDNmVlJ3K2dyZWdDYmlYTjVVYVFsNlFDV1RDeHUxSURZY1RzNFRHeG1N?=
 =?utf-8?B?d3pUWnNNM2dtUXRzdjVZdUlJN1lFSnhONk5ZMjRwMXpBc3MwOStmZmhtUkRF?=
 =?utf-8?B?RDZHTC9JQ0tUWktLdGhDa0FNNnlXb01nb3NzV3NGYmE1NFM2aEIzUEhKdm5S?=
 =?utf-8?B?b0wzU0VjWGlYUS9SZnVNK05qVzdjclNHUHRyQ1pvR01qSWppSzlpRkhHRVNw?=
 =?utf-8?B?OFRLVytqbldRaEJ1d0M2bXMxZHl2dW9EdXNvKzhpeVJabm41TVhnQnp0dERB?=
 =?utf-8?B?TnM5WWIvOWdGOTNxUmZhSzd6OXk4SlZrNHJNbm9hUnBkS0RhdEg5WXJvbWZa?=
 =?utf-8?B?YSsrM2NHTnlyaWNhS1BmSER1MXRiWnViNE90VXNnMU4zN0t2VFc1U3ZIZDYx?=
 =?utf-8?B?U2MvOEozdUxvWEJ1ZXRMdTF3elhaa3lvdmJZdEFlR0IzbjRrU3ZWbStsYUto?=
 =?utf-8?B?Y3A1RWhIRE9idy9SRlJzRXRGcUJwQ0lkMXRueHdGLzV6Q1lMY1JUbWJXRytt?=
 =?utf-8?B?cmVDOUM5S1cyMXhscXNVdVVNWnJPVHFnZ1JxSkg2TXFCVmhGUW5mWVdlNUFi?=
 =?utf-8?B?YnRJczJQTHRwL1pWTXVKM1pRNlE5WmhKdTE1YnFhK2dNZHI1WFozcVhiVUNz?=
 =?utf-8?B?cTRBQWJpaTM4eXRPTElzSEQ3My9PclRHTy9PMGVXMkhnSTJiY3dPcWZNRnpP?=
 =?utf-8?B?N0RxVm02VGMxM2tMQ2M3NjVjM3hCQlRiMlY2cWc4RkRiRU5FakFDeTZuVFhr?=
 =?utf-8?B?cTI3UWlrNFdyVmlaUm5iRVlRbng4dDgwaG54alFPc0lYUDd0OUdMcmorazds?=
 =?utf-8?B?aEZnMXNwUmxIRTE4TklKNlNJWDB4VFVkVTkzaktOcGMwZXFtMkFFUVlkZnlQ?=
 =?utf-8?B?WFlDeU95dEdHVGQyOFIwcjlMNXJVTStuMzhWLzRZL1Z4VmlCS2dLcGE4STV1?=
 =?utf-8?B?NVJyV3I5WDBzbWhsZElpQmpwRjVGVW9SY1VwbEQvZEJ3b3M5a2lSc3ZxdFZ4?=
 =?utf-8?B?TnYxZEVmaXZSQUJGdjVOaFYvNXdCbzAwbEN6QmRNUVY1cEpKRkJYLzlyWURG?=
 =?utf-8?B?d3c1a25jYkkvc1Rrc3VuQTV4NFY2SDY1VXF2MHE3QU1oOWZ4T0xUN3dEMzk0?=
 =?utf-8?B?SEZDVTl1aFhaNnZXMDNVZlVsT1VwaVJ2NFU2cmRWVkZiQWtpb0Zsek5tNC95?=
 =?utf-8?B?VnlLdXh2ckFLYWJnd0JlZitWK0lzaU40dFcrc0VmRnIyeUxHalRuN2d3eHFn?=
 =?utf-8?B?WUd0MVhYUFJlOEZOdWgrdk5jZ0pneFVyS1h4MjVJOGJMV0VLbFF6WUdzRldP?=
 =?utf-8?B?LzVhVWRXTlhXVTNDVm1pRlNmZGR6YW9sdmFIKzh5Z0pmeDd5bWlQa3hvSG9a?=
 =?utf-8?B?UkVKY3VlM1dTalRvQ213MUdPa08zZVlubkZvWk80bWJVNkZndk5aanpPOWpN?=
 =?utf-8?B?UlcyQ0E5cnNjNUFJdVJzbHFWeElyQ0pEVFhnNW9BUnBpV0ZnUjRLMXNZUm9z?=
 =?utf-8?B?Umszb3I0WHJTNzVCT01iYm1NOUpmSm9SV1VzSmRhLzZtYittczFUUDhOUFpV?=
 =?utf-8?B?UEdVbUpQaVRtUUVTK1d5eGhtdGtFbDRlK0NzR0NRTDdES2RMeExaZmUvWmFW?=
 =?utf-8?B?TGR4bVlQOFpFZW42MGQ3dVhHNS9HVUZ6Y0ViZlQ4NDVnMjZmNnU4T09DOUJ5?=
 =?utf-8?B?aVM0LzV6cjN2SDlXOVIzSFhVdWdEeFFOV3ZDOVhzMW5KSENrS2VVQVZ6a1pz?=
 =?utf-8?B?enQ4MVpqS0F1QTFUWFVDakl0eHdRPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f2362e-350b-4c4e-30f6-08ddd35c9786
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:41:19.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNvDbNiTMlpmILRTUoE7qXG647wYwTmx09P9NwBU/8C4KtWWddqHAhg1uoH/j55td2uBaWHywODFvSdeYv5UzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406

Hi Alexander,

On Mon, Aug 04, 2025 at 03:01:44PM +0200, Alexander Wilhelm wrote:
> > Please find the attached patch.
> [...]
> 
> Hi Vladimir,
> 
> I’ve applied the patch you provided, but it doesn’t seem to fully resolve the
> issue -- or perhaps I’ve misconfigured something. I’m encountering the following
> error during initialization:
> 
>     mdio_bus 0x0000000ffe4e7000:00: AN not supported on 3.125GHz SerDes lane
>     fsl_dpaa_mac ffe4e6000.ethernet eth0: pcs_config failed: -EOPNOTSUPP
> 
> The relevant code is located in `drivers/net/pcs/pcs-lynx.c`, within the
> `lynx_pcs_config(...)` function. In the case of 2500BASE-X with in-band
> autonegotiation enabled, the function logs an error and returns -EOPNOTSUPP.

Once I saw this I immediately realized my mistake. More details at the end.

> From what I can tell, autonegotiation isn’t supported on a 3.125GHz SerDes lane
> when using 2500BASE-X. What I’m unclear about is how this setup is supposed to
> work in practice. My understanding is that on the host side, communication
> always uses OCSGMII with flow control, allowing speed pacing via pause frames.
> But what about the line side -- should it be configurable, or is it expected to
> operate in a fixed mode?

So there are two "auto-negotiation" processes involved.


 +-----+ internal +-----+          2500base-x       +-----------+  2.5GBase-T  +------------+
 | MAC |==========| PCS |===========================| Local PHY |==============| Remote PHY | ...
 +-----+ GMII not +-----+   in-band autonegotiation +-----------+   clause 28  +------------+
    represented in the                                           autonegotiation
        device tree                  (1)                              (2)

In the context of this error, it is about the in-band auto-negotiation (1).
This is what managed = "in-band-status" describes.

Actually "in-band autonegotation" is more of an umbrella term whose
exact meaning depends on the phy-interface-mode, i.e. the host-side
interface of the phylib PHY.

For 2500base-x, it refers to the state machines from IEEE 802.3 clause 37,
through which the two ends of this link segment exchange their support
of pause frames and duplex, through special 8b/10b code words.

Actually there is another form of "in-band autonegotiation" commonly in
use, where Cisco took the 802.3 clause 37 mechanism but modified just
the content and purpose of the exchanged messages. This is notably used
for SGMII and USXGMII. In Cisco's reinterpretation, the in-band code
words sent by the PHY on side (1) contain info about the link speed and
duplex negotiated by this device on side (2). And the in-band code words
sent by the MAC-side PCS on side (1) just contain an ACK that it
received the message and is going to reconfigure itself to the line-side
speed.

Whereas the "normal" form of in-band auto-negotiation for 2500base-x is
used over optical links and is truly a symmetric capability exchange,
the Cisco modified form for SGMII/USXGMII only carries useful information
one way (from PHY to MAC), and nothing is really "negotiated". A generic
mechanism was made domain-specific.

The auto-negotiation process which you are concerned about, the one
which dictates the line-side link mode to be used, is process (2) in the
diagram above, and happens independently of process (1).

The exchange (1) of code words is what the Lynx PCS doesn't support when
operating at 2.5G. It has no implications on process (2). It just means
that the PCS doesn't support being told in-band (over the SerDes lanes)
what speed, duplex and flow control settings to use. But it only supports
2.5G for speed anyway, full duplex, and the flow control needs to be
resolved out of band (by reading PHY registers over MDIO) and written
into PCS registers.

The limitation is more relevant for a fibre optic link than for the
Aquantia PHY case. I'm not even sure whether Aquantia PHYs send in-band
code words over OCSGMII anyway (I only tested in combination with the
Lynx PCS which wouldn't see them anyway), and if it does, what format do
they have.

> > For debugging, I recommend dumping /proc/device-tree/soc/fman@1a00000/ethernet@f0000/
> > (node may change for different MAC) to make sure that all the required
> > properties are there, i.e. phy-handle, phy-connection-type, pcsphy-handle.
> [...]
> 
> I decompiled the running device tree. Below are the excerpt from the resulting file:
> 
>     /dts-v1/;
> 
>     / {
>         soc@ffe000000 {
>             fman@400000 {
>                 ethernet@e6000 {
>                     phy-handle = <0x0f>;
>                     compatible = "fsl,fman-memac";
>                     mac-address = [00 00 5b 05 a2 cb];
>                     local-mac-address = [00 00 5b 05 a2 cb];
>                     fsl,fman-ports = <0x0b 0x0c>;
>                     ptp-timer = <0x0a>;
>                     status = "okay";
>                     pcsphy-handle = <0x0d 0x0e>;
>                     reg = <0xe6000 0x1000>;
>                     phy-connection-type = "2500base-x";
>                     sleep = <0x10 0x10000000>;
>                     pcs-handle-names = "sgmii", "qsgmii";
>                     cell-index = <0x03>;
>                 };
> 
>                 mdio@fd000 {
>                     fsl,erratum-a009885;
>                     compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
>                     status = "okay";
>                     #address-cells = <0x01>;
>                     #size-cells = <0x00>;
>                     reg = <0xfd000 0x1000>;
> 
>                     ethernet-phy@7 {
>                         compatible = "ethernet-phy-id31c3.1c63";
>                         phandle = <0x0f>;
>                         reg = <0x07>;
>                     };
>                 };
>             };
>         };
>     };
> 
> Let me know how I can assist further -- do you need any additional information from my side?

The device tree dump looks ok.

I said there should be no managed = "in-band-status" property in the
device tree, and indeed there is none.

What I failed to consider is that the FMan mEMAC driver sets phylink's
"default_an_inband" property to true, making it as if the device tree
node had this property anyway.

The driver needs to be further patched to prevent that from happening.
Here's a line that needs to be squashed into the previous change, could
you please retest with it?

--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1229,6 +1229,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * those configurations modes don't use in-band autonegotiation.
 	 */
 	if (!of_property_present(mac_node, "managed") &&
+	    mac_dev->phy_if != PHY_INTERFACE_MODE_2500BASEX &&
 	    mac_dev->phy_if != PHY_INTERFACE_MODE_MII &&
 	    !phy_interface_mode_is_rgmii(mac_dev->phy_if))
 		mac_dev->phylink_config.default_an_inband = true;

