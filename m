Return-Path: <netdev+bounces-193107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B38AC2876
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8234917379F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0E297B7A;
	Fri, 23 May 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CPLzDIQ9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AA224AEF
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020881; cv=fail; b=RpcdhJBP5ZI7ZXvdTVEUAdy7aEpfO5m46YZ+gKh/eGz9rhe7yXz1Jw+RGOqCeLV9XybK3y055fmVGo8qXkpq+VXp6BrB3WyHsD+G5Ceh4XWTF7F5FhtzPTvDPnJuRWYS/kaOAgHVFtDoPgsjfdG9GhxaZ/MtZ79lGH1+7BJZSAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020881; c=relaxed/simple;
	bh=FYywCUS1fmYJiyefIpDxsjaScQMylRp0YXLMEPqsZkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afjJmJCKQhpFUCGqCl+ifnkhzQU68IF8aZxDrvYSv84XPPWYas7beHM+qU/qWUyq9G2Mc/c2ob5m3dD/Cf0KjuQErjQIleulp2givAoGCO9yafQqCQnZzU3eozSpICKp4ic2iCONFcgbfC9wN5XeDnM5u+lSeR3wpVL7dwHQ9Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CPLzDIQ9; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW1hYG7Q6eV/oqchF5DD4Yd0fuh/6MNWysu28oJ1yMTHnteFzzDPyVLQK/hGq96y8JVS2QVZQXrvAEaeGNtQOSb89MTp4/We0b1rH0gpRclP7SERQzhJAEIlBg8cHZyaimDSgcItTuB0KAFZD1c1k8Xz3O92EIh8eg/XHvIhefRORg08mN+gDUZyPRaFgaFbsKahXkZ0CZqpTa8awxb14di9mZdnmEoH5VR2tyWzqcacaLvChp1xX5XPJZtAwhtEoQ2FKIaFKNgLGqOxiSodW39/rHF6cNdjQNh+igfSRHEjTNuUAGVsH+fDr9Wh9GDeXDgR0z1NG/oXZYGsG83Thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYywCUS1fmYJiyefIpDxsjaScQMylRp0YXLMEPqsZkY=;
 b=LO/z8JK11IppACT2nTB/6wBY96b+jJbhVygY4tYCjfYlv8t3dT2y3URwAAh3aG4o5esfgtixRuTSWiVCAFPiB/ZsLrGT+a/azxclqIc8/x1HGEu8jbBA65ZJhgs0u1jtfMFNd2oIcuKwHIxmdoYXUPWoRUqn/dtzBlYQPKO8A+aDCfTHR2qXprM0YnFOfKb11kYmA2htwDPlSESx7Y1PTWrjRxb22cFGXJGjffK/Za7IAYXHwUCoR834Ih40aHd21xEXikGphIX2m4LSKy3VH3yAkN+CC7YZeTRH/Nm+SWGrcgsQBaWFob8ODRe7V7cb65bMqbsXNtr37DY/j8PBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYywCUS1fmYJiyefIpDxsjaScQMylRp0YXLMEPqsZkY=;
 b=CPLzDIQ9guxwbsaoxqUJLLyncTeJBJTXsoDxKF1jMQX2jUz7niHqEI+V3BGmskFpYszz2Rl5vFincJKL2YXBx2ckuFx7gHWjUKUYZPbV/mhQpNlxlrs8hFJ//ioY6yGVtEXdqoM/6nnSyb11oyPq115KnmE3ORRmDq+lZ3+vR6+fymqP4+H2mDZ75Z9y/y8XJQ3QTvuj10jS5LJz4k2byZkWr1baMDDT4TNpcsnlp/lZehEbI3yCzykoXX2lQDv6TJbB81dlM5mFFsDGfDvjgjgngncQQrurN45OVHDBo9tBMLW6MDUFOpCgBQzMgRPizo5RgrwGGfSI3GZuYW79rw==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by DM3PPF78DCB3A49.namprd11.prod.outlook.com (2603:10b6:f:fc00::f30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 17:21:13 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%4]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 17:21:13 +0000
From: <Rengarajan.S@microchip.com>
To: <aleksei.kodanev@bell-sw.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
	<davem@davemloft.net>, <Raju.Lakkaraju@microchip.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: lan743x: fix 'channel' index check before
 writing ptp->extts[]
Thread-Topic: [PATCH net-next] net: lan743x: fix 'channel' index check before
 writing ptp->extts[]
Thread-Index: AQHbyyP4uxhYFSVuG0aKKU3xEb8YdbPgdvGA
Date: Fri, 23 May 2025 17:21:13 +0000
Message-ID: <ae5090d780d6214311f030818f47b48a9b04fe4a.camel@microchip.com>
References: <20250522141357.295240-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20250522141357.295240-1-aleksei.kodanev@bell-sw.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|DM3PPF78DCB3A49:EE_
x-ms-office365-filtering-correlation-id: fa57b7d1-fb25-47a2-7fa8-08dd9a1e3812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXQvZStFSElZRjY4cEZZbjBBVUFJM2ZIcVpoUDM1WkJlZFRtZ3pUZEd3bFdq?=
 =?utf-8?B?NW04Q0s2YnptaFgvSitCQXpjSW9wV0cyWHN0eEZ3dXErSnphQUdTM2N4N204?=
 =?utf-8?B?VVFMQlpFVmJwc3RWU2dhTlpaeVJqaWg4c04vNWRsYjFObzJkSDlZaFRZSnJz?=
 =?utf-8?B?TWluOTBTMUQzeEV6QXFLNmdldzVsckJuWXFMWHJ3c2JnR2pkWUZKUkk1WkIr?=
 =?utf-8?B?MUFZcGJDTmZUTmp4QmxWcVVXSjhIRmhIbEtjdmFsaHlIVFBhekxsVlRkMlNJ?=
 =?utf-8?B?TllKSCs2THE0UzUvM2t1Y3NpZ3FxeUc1amgrUjRZUnAyckRqMFFWems3TlBY?=
 =?utf-8?B?U0NpRitPb3Z5ZUVJODhBMlQ2RmZNS0ZTWmhpZ3ZHVit1MndCcEFrdUhKMzFu?=
 =?utf-8?B?MWxsUDBxaWswTkwrSFZ6TFVBeFR5Y01kZFFNK09Yb0tjenBXN1llYzRaMTZi?=
 =?utf-8?B?N3d0TzhqY28rOTdKakZqVEZQcGwwV1haQzduMllLMW1lb2ZDaFFtVDVpTEpt?=
 =?utf-8?B?WHRVTWlQZE9ib09YcVN1bFgxTWttbzdyMUltL2diLzZMSmY2cnpSdmNZMXIv?=
 =?utf-8?B?d1lyaTJzSlFLbk9hTGVvVlFjWGdNZ08xam02SitRVTRQd3MweVBrckRSd2xt?=
 =?utf-8?B?eGhDQzF3c2RndndDMlpSZDFuUkUzeWNpL1llTWRkZnE5L0pYWXkzNGJXMlhm?=
 =?utf-8?B?bGVGMmhRbldBNGRiT2tSa2YwYVJDVmpzLzJ3a1Q3TVA2ak15WUh3RVR6UjJP?=
 =?utf-8?B?TGEvUzZQUkFXOVVTMEs4eVRUaThiYUw1Mjhob2t3Y3lQQ3BWRitHWTJvU2sw?=
 =?utf-8?B?WlR2bzRJa0d3NjArcjc5NzdicGp0ZDgwQnk3bWhPdmM1d1BPWjdiSThTVUxT?=
 =?utf-8?B?VG0vRmlyWkdUZlRqUHkxS21Ka2F4SEg1NzhLb0ROMjRabnFXVzV2dmVtKzRE?=
 =?utf-8?B?aWY3ay8rR0FFd1lSUVVlM250WElFTDlRYStPd2JYQWptM0JzbnZtbDZ0cnU3?=
 =?utf-8?B?YVZQY01jK2VibWpEV2N0NVJYTnJubS8zM1RSZzZ1Z3l3NC9GTXM3WlF1eXhS?=
 =?utf-8?B?RElRbVlTOWpTUE9HeUdyTm9pQk1zWklsZjVTS1VCUWJTYXE2dVhuWU5YeEhl?=
 =?utf-8?B?M1JvZzBFVkhJWnlkUFp4VHJ0MUFwNTh1MG5OaVh2OFZHNFpmSStyTTlVTmtp?=
 =?utf-8?B?LzlqQ3FoRXlwNDBtbExMSHd2RXF6OWpHTnJybThwOFVwbWpOelZycE5UTldP?=
 =?utf-8?B?ZytXY3pOQWtHYXZHVC8rdktWem9UWEJPV2lDMG9OSFNyU1h5YUdkeXVwMWMx?=
 =?utf-8?B?YXRnWjkzb2RlaVdlSnZRMDJ6Y0UvN1lOM3pMQ3U1YmdXVm9wNjhzaUlESE12?=
 =?utf-8?B?ZkJzby9rUzQ2TURZRjZwcG5aZlRBTUNhQkFmYk0zM3BHc1RLUmFKMi9hSTJt?=
 =?utf-8?B?dnJKa2pXZ2M3R2lkYWQwYm0vbXhxMGdpVS9zcUZDQzFGTHRxNHhIZkh1bkJi?=
 =?utf-8?B?TjdNRVhFc3RKazhON2wwSm1IN05LVkI1NDU4UGp5enFYSjN2RkVjaUF0OFhO?=
 =?utf-8?B?bUxqbm5nWjl6Szc1cmplOXNPZG5GZUFkVlRXYUZQbmg1VU1YaDJESmxtQWls?=
 =?utf-8?B?UjlRaXRXbGZJaGl3bjYweEM4WitjWitIWWcrcm5iRHA3bTVSTzBoY2RKcURG?=
 =?utf-8?B?QUhFdEtTK2VSbjVjUjRST3BxU0RJTjVkUlVMZmpjcTJ4Qnh3TGtVenprQXpC?=
 =?utf-8?B?MURxWTBacnUrdDEwUlp2Z3hMYy9YZXIza2VyY2R3WEtXaWY2L0tQUmpKOTNa?=
 =?utf-8?B?QzRaVmdBNERmcUFjenVLa1AyRi9iRmhjOEFUVnhLSmtSTkZUZmd3cko0WmU2?=
 =?utf-8?B?cVVOMU9FVWNqOGUxY2pONitmUWtSQlY2M04zUXRtM01DUTFaUklNMmVxSkww?=
 =?utf-8?B?clBETlgyTjFGMlRwQlR1MXV3VGVacEwwKzBVMFdMZ09EZk9HWWd6OWFkVVIx?=
 =?utf-8?B?QjlmVUhpeFRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHp0TWRPYVNmb1IxWnU3S1lITHgyaFdSblVsSWk4bkNYb3ZDelhkbkhRZWsv?=
 =?utf-8?B?TkJTdG1mTVNlVTJ5d2tTdzlZZ09COURJbFJISW9DVm4reHlVaDl5ZmlMSU16?=
 =?utf-8?B?a2ZvNk0rb1g1MjkyL2pRaVNxZ2ZUMTlQaFlWWWZQWkpjQ3hQTHZWeEpUalZQ?=
 =?utf-8?B?WDNGVW8xZEdsTTV6Tm1na01QdFdTNWtGTG5mN0RyNm03S2xkUDlTTS9MQlpW?=
 =?utf-8?B?Q0V6Z2haZzJiV25rVXVmL3I3ZjNCbTQxWHIvaVdvdXA4UElxSjl0VWQvR0ZF?=
 =?utf-8?B?ZDhrczhrc2ZkSGx0M1g3M2x2cURpcjFlVWpBc1N2eHkwWUVPR2YxSFNzdk9S?=
 =?utf-8?B?cGtqVjZBV2xSeUlpYnEwV2RlMk93U0VrcUJrSUJsU2RzK3JvYmlDdVNDL2pK?=
 =?utf-8?B?WXlqTFZFRDcrQU1QenJSRldkZXU0NFg2cU9vaFlnUHFYTlZuQzZRdEwvSEpv?=
 =?utf-8?B?SHZuVEFMWUVPSnY4eXRyTTh5OEZGeXROckxWeDViTG14TjkxeFd5RzNIbm5s?=
 =?utf-8?B?T2tWTWppNHhVNk5BUTh4bFV1VXF4ZVBGcGVUMTlyTGpUMFVaNGplRnpTcG4w?=
 =?utf-8?B?cS8wcUxCVGtpRmFMN0Q3ei9VMytkR0R5a2lxaGs3V0JTcTNVc0hXRERSdXlS?=
 =?utf-8?B?d3JIM2tCajJGWGNienRrNEIvZXBTSXhzZzA5dmkvNzhIczRZbVFUWHNQTGg2?=
 =?utf-8?B?WHZEMnNOdU1xSTdqcGpkWHlHQ0tTNWhnY1lMUS90dVZLNEhPajlKLzBFOWpZ?=
 =?utf-8?B?VGl0R3VjSStTNG9YUGtxSDBFVGhtMDl1a3lPeDFjTXNRWWJqSUJJK2pMUjhC?=
 =?utf-8?B?TkpCbU84QVMySXFNKzVZdEtlSDVjZy9Na0R6OWVyRlpoSmxyRHErcTFvaUJN?=
 =?utf-8?B?NDdYOHBCdXRvLzh6d3pmQTMzMktMdDJjK2RJSDIyN01vZkZhT0M0dFlwWlI4?=
 =?utf-8?B?UnFBRklFYit1U0NRMHc2dmpSNzhFNjVqaDY1dDRPVURuc3N4dHhBMThlSktB?=
 =?utf-8?B?VUZhMVRJbFlVekpUTFIyWHdiWWNxQ1ArUjMyYzhrMHBneWxDNE9yRGQwQjlI?=
 =?utf-8?B?RERDWEZ5blJ4K1RnaGtJdnFVUFVOV1E2czBlakJid3FteHFMRkhxSml4RXFy?=
 =?utf-8?B?NTRTQkJQdG8ycllnQS9MbCtzQlRWUnBjbVJxU0M4R3RSM1NRZVJJTy81SEVX?=
 =?utf-8?B?aW8xcUlMQkJZb2RtbVo5bVQwY2dSSTQ0YzlERG5jVmM1Wmd2VEM0OFRCOTIr?=
 =?utf-8?B?QWc5UnFJQkdaY055c3lZT1dnM1BpWDRYTm1ic1RwRW1CcGxwS0IyOThyZDlC?=
 =?utf-8?B?YzUyU1l0aGpyc1g0S2RiaUV0cWJ2ckRJL1J6WFEyWGpESkRpV2taV0o1c1NM?=
 =?utf-8?B?cWdadjNYdXR5bjU3NlNjYmQzK21xNU8rR05WWlNLT2lOVGt3L0NUcFAwaHho?=
 =?utf-8?B?UFhHZGo4VjVBejRKRG53YVcvaVkxbFZtNDdWY3BXQzhJUjBJQWtuZnBuL0lX?=
 =?utf-8?B?NFNDNE80WTBQbGtvNWtZanE4b1pubmJQak9ZQ0JvVU1haHFCM09xc2p2b0dX?=
 =?utf-8?B?L0FiaFZQRkdSQlYwb2ZVM3AxUytDSEtNNkVUM2VFRk5YVzJoMkx2NUhMUHdv?=
 =?utf-8?B?NHdpL0xRUFl4OFpZRnNHM0pRNTgxSGNkVUhYM1czL3Jvb2NlWlNHVW5nZ2tW?=
 =?utf-8?B?a0NxaW1ZQ3RQbi9XanJJM2NFUmdEMVJSRTZIR0pKQ0JGaDdoOE1IVHErUEFu?=
 =?utf-8?B?Y0N4V1FwRVlValVRUkRqdzZlbWluSSttN2wzQ0NzeHJuNnFmdmI4Y2lDMzVF?=
 =?utf-8?B?QnRZdmNEZnJCSkhuYkxnUnFwZHBiN1JHMFZ4ZzR1OGNxb2ZveUxxVVd2VGN5?=
 =?utf-8?B?ckwrRVBwdy9wMlFuSFM5amlGaEFYcXhvN1owUjhYYmpZUzR5UUs4Q2toVDJU?=
 =?utf-8?B?WVVlbkRHYnlhTU1XdnlEZmIxZEI0S3J1TW16WWRzTFBoaExWYnEzMGZjcXcw?=
 =?utf-8?B?eHNuQ2k1MFRhV3hSdTBrUlp0S2gwSWw5eUFxcllseSt6bzdmWjJ3bGtSZ1ky?=
 =?utf-8?B?aENNYjVBc0VDLzFHeURPd1JRWG9yRTczV05YanRGYURsajB5eWtvL2xqWHdj?=
 =?utf-8?B?Yno5Z1Zsc2o5ZGpTN0krMDRvRExtT2d5b2Z2VGUwRGxyWnZGQkdwSVYxMTZm?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A174FAE3A957AA49BCEAD8F52F80B91D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa57b7d1-fb25-47a2-7fa8-08dd9a1e3812
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 17:21:13.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKa36GBX+F1+P3fJXGFD8Ai8kD36rYA1CHLIY5sIIng/BO8CMNovzUdGOIoc/goN/cd1bp9gWf3nptRI18Xyqs2/WCMyfuFcIEnWV05QQFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF78DCB3A49

SGkgQWxleGV5LA0KDQpPbiBUaHUsIDIwMjUtMDUtMjIgYXQgMTQ6MTMgKzAwMDAsIEFsZXhleSBL
b2RhbmV2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IEJlZm9yZSBjYWxsaW5nIGxhbjc0M3hfcHRwX2lvX2V2ZW50X2Nsb2NrX2dldCgpLCB0aGUg
J2NoYW5uZWwnIHZhbHVlDQo+IGlzIGNoZWNrZWQgYWdhaW5zdCB0aGUgbWF4aW11bSB2YWx1ZSBv
Zg0KPiBQQ0kxMVgxWF9QVFBfSU9fTUFYX0NIQU5ORUxTKDgpLg0KPiBUaGlzIHNlZW1zIGNvcnJl
Y3QgYXQgZmlyc3QgYW5kIGFsaWducyB3aXRoIHRoZSBQVFAgaW50ZXJydXB0IHN0YXR1cw0KPiBy
ZWdpc3RlciAoUFRQX0lOVF9TVFMpIHNwZWNpZmljYXRpb25zLg0KPiANCj4gSG93ZXZlciwgbGFu
NzQzeF9wdHBfaW9fZXZlbnRfY2xvY2tfZ2V0KCkgd3JpdGVzIHRvIHB0cC0+ZXh0dHNbXSB3aXRo
DQo+IG9ubHkgTEFONzQzWF9QVFBfTl9FWFRUUyg0KSBlbGVtZW50cywgdXNpbmcgY2hhbm5lbCBh
cyBhbiBpbmRleDoNCj4gDQo+ICAgICBsYW43NDN4X3B0cF9pb19ldmVudF9jbG9ja19nZXQoLi4u
LCB1OCBjaGFubmVsLC4uLikNCj4gICAgIHsNCj4gICAgICAgICAuLi4NCj4gICAgICAgICAvKiBV
cGRhdGUgTG9jYWwgdGltZXN0YW1wICovDQo+ICAgICAgICAgZXh0dHMgPSAmcHRwLT5leHR0c1tj
aGFubmVsXTsNCj4gICAgICAgICBleHR0cy0+dHMudHZfc2VjID0gc2VjOw0KPiAgICAgICAgIC4u
Lg0KPiAgICAgfQ0KPiANCg0KQXMgcGVyIHRoZSBQVFBfSU5UX1NUUyBkZWZpbml0aW9uLCB0aGVy
ZSBhcmUgOCBzZXRzIG9mIGNhcHR1cmUNCnJlZ2lzdGVycyB0aGF0IGNhbiBiZSBjb25maWd1cmVk
IGFzIEdQSU8gaW5wdXRzLiBIb3dldmVyLCB1c2luZw0KTEFONzQzWF9QVFBfTl9FWFRUUyAoNCkg
cmVzdHJpY3RzIHByb2Nlc3NpbmcgdG8gb25seSA0IEdQSU9zLiBXb3VsZCBpdA0KYmUgbW9yZSBh
cHByb3ByaWF0ZSB0byB1cGRhdGUgTEFONzQzWF9QVFBfTl9FWFRUUyB0byA4PyBUaGlzIHdvdWxk
DQplbnN1cmUgdGhhdCBleHR0cyA9ICZwdHAtPmV4dHRzW2NoYW5uZWxdOyByZW1haW5zIHZhbGlk
IGZvciBhbGwgOA0KcG90ZW50aWFsIGNoYW5uZWwgaW5kaWNlcy4gDQoNCj4gVG8gYXZvaWQgYSBw
b3RlbnRpYWwgb3V0LW9mLWJvdW5kcyB3cml0ZSwgbGV0J3MgdXNlIHRoZSBtYXhpbXVtDQo+IHZh
bHVlIGFjdHVhbGx5IGRlZmluZWQgZm9yIHRoZSB0aW1lc3RhbXAgYXJyYXkgdG8gZW5zdXJlIHZh
bGlkDQo+IGFjY2VzcyB0byBwdHAtPmV4dHRzW2NoYW5uZWxdIHdpdGhpbiBpdHMgYWN0dWFsIGJv
dW5kcy4NCj4gDQo+IERldGVjdGVkIHVzaW5nIHRoZSBzdGF0aWMgYW5hbHlzaXMgdG9vbCAtIFN2
YWNlLg0KPiBGaXhlczogNjA5NDJjMzk3YWY2ICgibmV0OiBsYW43NDN4OiBBZGQgc3VwcG9ydCBm
b3IgUFRQLUlPIEV2ZW50DQo+IElucHV0IEV4dGVybmFsIFRpbWVzdGFtcCAoZXh0dHMpIikNCj4g
U2lnbmVkLW9mZi1ieTogQWxleGV5IEtvZGFuZXYgPGFsZWtzZWkua29kYW5ldkBiZWxsLXN3LmNv
bT4NCj4gLS0tDQo+IA0KPiBOb3RlIHRoYXQgUENJMTFYMVhfUFRQX0lPX01BWF9DSEFOTkVMUyB3
aWxsIGJlIHVudXNlZCBhZnRlciB0aGlzDQo+IHBhdGNoLg0KPiBDb3VsZCBpdCBwZXJoYXBzIGJl
IHVzZWQgdG8gZGVmaW5lIExBTjc0M1hfUFRQX05fRVhUVFMgdG8gc3VwcG9ydA0KPiBzaXplIDg/
DQo+IA0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmMgfCA0
ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0
M3hfcHRwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9wdHAu
Yw0KPiBpbmRleCAwYmU0NGRjYjMzOTMuLjFlZjc5NzhlNzY4YiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfcHRwLmMNCj4gQEAgLTExMjEsNyArMTEy
MSw3IEBAIHN0YXRpYyBsb25nIGxhbjc0M3hfcHRwY2lfZG9fYXV4X3dvcmsoc3RydWN0DQo+IHB0
cF9jbG9ja19pbmZvICpwdHBjaSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBQVFBfSU5UX0lPX0ZFDQo+IF9NQVNLXykgPj4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQVFBf
SU5UX0lPX0ZFDQo+IF9TSElGVF8pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChjaGFubmVsID49IDAgJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2hhbm5lbCA8DQo+IFBDSTExWDFYX1BUUF9JT19NQVhfQ0hBTk5FTFMpIHsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhbm5lbCA8IExBTjc0M1hfUFRQX05fRVhU
VFMpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhbjc0M3hf
cHRwX2lvX2V2ZW50X2Nsb2NrX2dlDQo+IHQoYWRhcHRlciwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ICAg
dHJ1ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgDQo+ICAgY2hhbm5lbCwNCj4gQEAgLTExNTQsNyArMTE1NCw3
IEBAIHN0YXRpYyBsb25nIGxhbjc0M3hfcHRwY2lfZG9fYXV4X3dvcmsoc3RydWN0DQo+IHB0cF9j
bG9ja19pbmZvICpwdHBjaSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBUUF9JTlRfSU9fUkVfDQo+IE1BU0tfKSA+Pg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFRQX0lOVF9J
T19SRV8NCj4gU0hJRlRfKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
Y2hhbm5lbCA+PSAwICYmDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNo
YW5uZWwgPA0KPiBQQ0kxMVgxWF9QVFBfSU9fTUFYX0NIQU5ORUxTKSB7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWwgPCBMQU43NDNYX1BUUF9OX0VYVFRTKSB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYW43NDN4X3B0cF9p
b19ldmVudF9jbG9ja19nZQ0KPiB0KGFkYXB0ZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgIGZhbHNl
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICANCj4gICBjaGFubmVsLA0KPiAtLQ0KPiAyLjI1LjENCj4gDQo=

