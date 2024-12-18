Return-Path: <netdev+bounces-152784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFE9F5C71
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF31B18857B3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E13595F;
	Wed, 18 Dec 2024 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1fgD2Nr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468593594A;
	Wed, 18 Dec 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486792; cv=fail; b=PW+nMOX73IxFXih/wCnUaYg+0z4CQ/BU1RpJSOqYlZpvK7OmiX7H/ECbWJVc2boPa1vrm+jm+H8mmACTW6mgTktPkc4+UbN1y3KboNb48I1YowlscIGbtVq5Bp0qAB00OSLyX3hWHVgOctGszyujqvHeKlxeu6qruBRWAOxCYG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486792; c=relaxed/simple;
	bh=nuN3hjv0serZucJIOpoRuHU1wf9CENV8oYdEp2X/Qc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=av6jECPtxYMTeDfsIGUyu2/wD34TLFA09HmW036F4WkKTB7zcNJlKoCn8RH5aIJyYpIRajoxyn3vmZ6MaFQGKc0n6nWJG+uMb9X2e70Ne0p3YR4hn8Dtrscikif3A2Nlh80nlyZ70+655Ccr9HYqTSBv8acEbgzXi41+o+jfKu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1fgD2Nr; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHgbwRxxjDqg0Hdp0S1ZuivQC3Zj4M0toLHDV0TV+skg156FniizdfURV8EKyZazx0+wZxzqmQoJwylc+oTFxpYw7get89fJBX/LN4+O5XajtUJ2r5EFkFO4GPKeN6XQ6Mtws1ElwE3DuewOw+ETYuygr0RoVT4XbwJhFM8aA5lmIqr5Ix0E/jgG7qdiHNoJMh8geaznzphUU/Az/fFVMdFEJRNwomRdf9A+NbOpYj++X35Uad0dA6QauIhCHrf6o0t0VjOziAS0il0q+gVD8+v4UJ+opGLIpC/c4OIEBVRoApw+m0XHFcaYVJblArN2GD0RXJ0k/08yAzIdwYrIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuN3hjv0serZucJIOpoRuHU1wf9CENV8oYdEp2X/Qc4=;
 b=y/HGmWZbw3pIjCGxfCqgIW783dvJ16v0uCGt9FoAhguKB4KPo2Zad4mGHKw3h6wxm7Y03SMqbsIGUYvV5b1j0P2Ggx4ehmxUZzGnpRaCpOwtZEhdBrXDVUowjIRm9YHQsSvtzl9/s95e/cueMpCMgAJBZSEfKwmu+uSqHdn48VEhVxkExNWyRJac7r+Y1NxGjFQkznWNauwMUaKJRQ9zS5Ls8RJ+7p3+VQCBVV75fxTN/zAtJ0UNY5SOoz9JJFjzznn00NmXleQDGRApkbP996gKjfd3wCoRp5pXayxqQ8Kbg35PJgV0sbgEeZwf583eFQX0d2BPPW0HntqZzXGNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuN3hjv0serZucJIOpoRuHU1wf9CENV8oYdEp2X/Qc4=;
 b=V1fgD2Nru2cDcJTWIVxtlwMAO8XI0rPOLxmT5RGxicM1SL9RYuU4WvEiR2PzQMYFQlrDX4GaFkBY5SWftUieOmJoLZC87rqRmGNrIL+vsKg/qiH0M3u16C1NkRi3tntSxGXezBA6/5AzVwEkiz2FLcagE9MIzJ+KcML7Vkx+HecfMY00x3fIBs5Qp4Zehjkk3pawiksmSIhAtISZQymQWUTiSrOB2MEGu46+7fc7t1JFxrPXs148hnzv6/w1clpJR2Vdb9SSmbJQYW/8Ft17KtRpixDfGTctBSkK6dfEZCVDMqhU+Ow7rHoBZVHoi65nb76qesKvqghpsnrrHjv76w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 01:53:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 01:53:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@idosch.org" <idosch@idosch.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v8 net-next 1/4] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v8 net-next 1/4] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbTQdn+xqUSCD+lEqLDtawtDnXu7LqklKAgACuODA=
Date: Wed, 18 Dec 2024 01:53:06 +0000
Message-ID:
 <PAXPR04MB85106BEF8ED9E4D373FEA46388052@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-2-wei.fang@nxp.com>
 <5f2eb433-479c-49d2-bc2f-07f6c0a52c60@intel.com>
In-Reply-To: <5f2eb433-479c-49d2-bc2f-07f6c0a52c60@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9707:EE_
x-ms-office365-filtering-correlation-id: a59e46fe-5224-4dfe-549d-08dd1f06b7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REhjTkZiV016bUczUFR6S0k1TW96dFB5K3o3K2pFcW1pU2d1V3lmODh0QzJy?=
 =?utf-8?B?OWhKNW5UL1BTeVRFUjl6UzBPNUNJTUd2cWhXTkJBWWc5RjRuT3dXSDBjTFBM?=
 =?utf-8?B?dnlHZU5QSXhsV1VPK1VaQy9NbmRaWUhhZEpNekI2dVVDYlJzNUhmaDJDN2FB?=
 =?utf-8?B?LzcwY2NJY1k2V2luRkVnTy9hNUJ4SWRXTndoWjM4ODNxQVZZNVBUQ0o4OWh0?=
 =?utf-8?B?Ui8rUWRkRHlJMXpGMzhndDNxaS9nWGVkeDA5ZFVSZWtIcjNvVjloODJvQXMw?=
 =?utf-8?B?SEdDTDJSTkdsUlN3eW0rVmY3VWVtY2NBOWZaNzZtZldBTiszbk1WaG9oVUp0?=
 =?utf-8?B?UmtoZ2l5RmdEMkxITXhaN2NiK1owOHdVNmlEUzNVUk5pUU5jK0tvcG5HWGhv?=
 =?utf-8?B?UWJObjBPTGs0Z3ZOTDRFcTI3OG1yS2t1MzZROVphY2NDbU1UZHJBbzJSZmEr?=
 =?utf-8?B?NzlqcEFEcjNQNDhzeGFPNTEycHVkWkFYWTBEOS8yem5CRGIvR2NoSnVJYXI4?=
 =?utf-8?B?RDF1QUxYQTlxVktVUHhLdk5aM1J6dm9Fa0daeE9zYTdVY3RrRDJ1V3YvRUNI?=
 =?utf-8?B?MDgwOVhnQ1c5d09HdlBSS1ZMZTdCelA5RVhHSWljdHI3aGptY2tCdytvRlZH?=
 =?utf-8?B?VmJMeCtzaGovS204a2RUUjFjSm9UVDdFS3NpZEd1K2wzcE1ObjZKakxtZjFB?=
 =?utf-8?B?aEJUQmY4eEN4UEpYMnR2aEVxeGtOZG1jOUhPWFlrbzZqOW5DNkZKZVdpMVpi?=
 =?utf-8?B?aEw1Y2paWFJ3VHZxS2xzMW9HVGI2YkZEaTg0NEpyb0U4SDJ1T1VkQStXOVFW?=
 =?utf-8?B?ODl3cmhLYlhEc3VWMi9NKytrcXcwamN4VnBGQWp1V3BkOElUcUNBUTFnem1U?=
 =?utf-8?B?UE9XWkh0NXlra29peXFXbUVPUVlueDJacE9ScU9ZMHFDNlM2MHZQakhRYTdy?=
 =?utf-8?B?d1lEc2JHODlBRmFNZDBBazdHOEo2bnhoeXJMNFNtc2ZBQ1F6bzhRZitOeTc5?=
 =?utf-8?B?ZXgwQUZqLzY1WVh0eGNQZmkrMmd6QmR6MFpMR2N5dk5Ub0NiTGxPTGFhUHBp?=
 =?utf-8?B?YitGTmtuMStmUGY4enNZVFJGYnBXS0NHcmRKRyttY2tJc0NoNCtNTHU2dUNx?=
 =?utf-8?B?ZkpnYkVFWFJjOEF6bVRzTk12UUdNSnVjZ2lHLzZtWGdTczVlMUYvdk9Bd296?=
 =?utf-8?B?ditBNTNxcXo4LzRRZlYvbk9qbC81bE1RWllwWDJaYUlzTWVMNlZvbkpwMjRI?=
 =?utf-8?B?K1VLcVF6a0dyeS9IeXZQb3hwQVhlSkw3TU42alJRSFNMUVQxVVUvSGJJWHJx?=
 =?utf-8?B?ZEY0dzh4eXI2ZTBCSjU5UW1aUG1vZmlObUJ4eG40aUZ0VnhXR2tGTUdpQzRl?=
 =?utf-8?B?ejBBM081U0c1NWRGK0Zydy96OC85OXExSGhmNU9EUGd0dG5rMEtIOFJsUTQ4?=
 =?utf-8?B?d2Y3NHMxQ29wSkFzZG5SRFptNEgyTGZwZ1k2NHFmcnpsTjlTb2tvR2RNRjJM?=
 =?utf-8?B?U096VlEzMFdKYUZDZGVmUnVvRHhsaGloWU1VSk8zUHNOYWRRcEJtcGF3SFQr?=
 =?utf-8?B?WDlPTTFpcUpLRTJ5STFQZmoxWk4xd0xiTFZrTUYwSnd3N2ZyOWFLVmk4TE5H?=
 =?utf-8?B?Y2xpY1dOM1VBdFN2ckxmUUNEWEFqTFRUZ0RvV3FJSnM1blI5U25Jb0FOYXVP?=
 =?utf-8?B?OS9OaDViNEx0enhOUXd1LzZFTG9vQUJ6ZktudHNPYVNQTlFqVnFZK21DcHpk?=
 =?utf-8?B?aXZvWitIbHUzRVp0cVJicFhVMDhCeGlTZE5DTzcyTWh0OFhWelFXdUNxOGhm?=
 =?utf-8?B?U2VLWEZLRDVJSW16L3dnQzhKSjl4U3RpYmNpM0d3M3UrVVo4aUlyLzRTSnls?=
 =?utf-8?B?UlhQWlQ2cU5sSHA0YnFLK3p0MklzcWZKcEpZSjNZejhIZVZzZDdrTGkvTVM4?=
 =?utf-8?Q?LeSnOb1rrrN3WGWG7bRTw1NR6sqEXgbs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDgvejhEK1k4UnVkOG1OV2VtVDZYRHRIYnpXUUZwNENBOXdUeXhmN1pGOEtG?=
 =?utf-8?B?MXM4VDBzMzJuRzNPcFEvTnlYWmlPaEdyc3gxRnc0cHZkVmUrazdWZ2ZCditC?=
 =?utf-8?B?N1F4RSt6SGsvNEd6Qm5oK1hDSWRzTGpHSURwTWtjY1hJSTBORGR1V0xMNUJr?=
 =?utf-8?B?dEl6U2ZkcGhRb2l5TDdHSUVMaWVnK3dVMnA3MCs4Rzk3ekIzRjV3UFhBQ0pF?=
 =?utf-8?B?c3piNFNrcDFpL3VkanFlTU1ZV3k3bHdMN2I5OUpSeHE4TDdZaHFscUp5TEFy?=
 =?utf-8?B?S3dLTDBpRGE3K0RlUitjU1RPZ0lIUTY5MG5sNG5BcExwRXI5YUxaRXYxdjFO?=
 =?utf-8?B?SEV1dHRhS2IvUndrMEJvS1pzN3JSVlI3NXphNmFVQUdhT0VDWDJNQ2EwRi96?=
 =?utf-8?B?VTl1cWZtMmhZWEdQaWE1QldrL1BEZDRLNEgyVGw5b0RXK256b0VCVFg5STU2?=
 =?utf-8?B?L3lPektHYno3blNjZXYvNDhuUk1zTTJoOFBrWWFTREJsc3JDYUE1cFJNOGtk?=
 =?utf-8?B?S3YvOTcybjRmY2JuRVJSL2IzTldVWVpycEYwMEloMDdWZzhiMmZxWHRvNkNB?=
 =?utf-8?B?d1l2U2RPRFdWT01RUEJNL3RDV2RJOGlYcnRUMytjU3hQNXQ0cmFPY2F3NzVP?=
 =?utf-8?B?UVVqTDNpcWpoSzkvOC9idUtqTVFXMDZMUnd5dnRLRklXRFJQVUtLS3ZMMFdZ?=
 =?utf-8?B?ZDYvYVpQVGRoL0lFdXdIYVlhWXJoSXd6cVVnRkZtVUdJdElsRTVXSnBwSHd4?=
 =?utf-8?B?NTFSRFdWeXZHbU85NmpBeEQ0a08ycEs1d1hrZXY5K09nUWNBTXNaUW93NHBv?=
 =?utf-8?B?R0l5MXRoMC9JOE5KbTQrblF6bzRjdWVxajhyK2pkN3RlWWRRUDZYbG00Wi9Z?=
 =?utf-8?B?Zk9qOEI1cC8rRHN4Z0thb3RzNnFYMWh5aHZMZWc3ekVhdThjRVR1azArSzVR?=
 =?utf-8?B?dVR2WXdWeXFTSERISlJSaXE1L0FMd2grZDZyRThzaE5vVVk5c01OZy9oUjlq?=
 =?utf-8?B?Z1AzL0g5bFpacG5XRGxMNXhOOHhDaUhSRFFXbGVzcERxMFhxS2IyVlVsTlow?=
 =?utf-8?B?R1AwMjh3OGh0a2dyODZ1U3o0L3V4cTVYYkU5Y0c5RWwxOU43dFZiZHNXbjFY?=
 =?utf-8?B?VHRtSi9WYnV5VGNzZDZ0Rm5sWHNlS0x4eFh4clQ1Zm5MeU9Ya3M2WWxuZFdo?=
 =?utf-8?B?S3NZMi8rTlZ3aDc3bnA3UzNYR0V6K2pTZDd0cGlaNFFVUU9FTjNlQkdqOEEw?=
 =?utf-8?B?YjVrcWdaa25wZWpsV0tQeFU2N1l4SE92WmdiWng3akp4aUhXL1UzTU5kdTNl?=
 =?utf-8?B?cVMvdEdaZUZzdlFJaE9NOTJNSFMzaDlkaXZhYThITjJyaW0wczM2STJDYXZY?=
 =?utf-8?B?WXUrRm5FZHhSMWpWSjcrTzB1aElrTzBEVHdDU3RFTE1vUzZNZ0FzaWttKzJY?=
 =?utf-8?B?aDBaYW5LdVc4aUp2amRDT2thdHJaSjVHYVdVR1ZoU1lVRGRIUDQ3WnZaQ2xM?=
 =?utf-8?B?aGhvSTh5Nm4vS3EvYStUSGROVmRGLy83YThUc3lUd2tVcThIU1dMZUQ0YVcv?=
 =?utf-8?B?Vll1elROdXF0c2xvWHN5ZEJhTXpBU0tvSGhURFBjWFJuVnc3YTRmVnN5ckUx?=
 =?utf-8?B?ZjNjUlRLU1B2cWxUMG15QngyRTV4Q2IxSG0vcVdvaFM4R2VuRHlkUWZhSFhM?=
 =?utf-8?B?TzZRRHJieUlhVEdudWNCR0t6SFRQd05qNkZueFpMZS9GN0RlZnpOclhlZlFZ?=
 =?utf-8?B?UWowTWlmT0wwK2t4OU03cDFLTGpIY1orZnhqb1ZtelExT2dnZ2tGcnA5Rmdl?=
 =?utf-8?B?ZFNpTEpTRXlDRGhzdkY5MkJqYk1LMkEvTlBybjI3eGRab1owOWRqaXhaVnFa?=
 =?utf-8?B?cS9YTVJBR0lSZUtYVWUzbmE1WVJ0VWFRby9GNFB0Q1Z5ZUFJa0lZRWtZbWlK?=
 =?utf-8?B?emQwOG1xcWdEWEFmME5WU3JRY2hzSW9BTE9USklUb1JZcDVQaEduWTdRWEx6?=
 =?utf-8?B?NGpKbW1jWWlZSndETm5FN3R1WDhmUjE0QzVtNC9CSDlWSFAxWENZaFUzSkwy?=
 =?utf-8?B?TmRsdnpYb2ZSVDlJbEpxQjM4QUdrbjV6bUZmWXY0YndpcWwzUzhYeVdLZko4?=
 =?utf-8?Q?Hbn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59e46fe-5224-4dfe-549d-08dd1f06b7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 01:53:06.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nhbq7ifRYGvj66qeqLjaffBF8NUi1+BePJ696HqfTa16+gnyI6xRZ6eHAE6OgNKcPebf0q6wuR3/+OHWwY14Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707

PiANCj4gRnJvbTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IERhdGU6IEZyaSwgMTMg
RGVjIDIwMjQgMTA6MTc6MjggKzA4MDANCj4gDQo+ID4gSW4gYWRkaXRpb24gdG8gc3VwcG9ydGlu
ZyBSeCBjaGVja3N1bSBvZmZsb2FkLCBpLk1YOTUgRU5FVEMgYWxzbyBzdXBwb3J0cw0KPiA+IFR4
IGNoZWNrc3VtIG9mZmxvYWQuIFRoZSB0cmFuc21pdCBjaGVja3N1bSBvZmZsb2FkIGlzIGltcGxl
bWVudGVkIHRocm91Z2gNCj4gPiB0aGUgVHggQkQuIFRvIHN1cHBvcnQgVHggY2hlY2tzdW0gb2Zm
bG9hZCwgc29mdHdhcmUgbmVlZHMgdG8gZmlsbCBzb21lDQo+ID4gYXV4aWxpYXJ5IGluZm9ybWF0
aW9uIGluIFR4IEJELCBzdWNoIGFzIElQIHZlcnNpb24sIElQIGhlYWRlciBvZmZzZXQgYW5kDQo+
ID4gc2l6ZSwgd2hldGhlciBMNCBpcyBVRFAgb3IgVENQLCBldGMuDQo+ID4NCj4gPiBTYW1lIGFz
IFJ4IGNoZWNrc3VtIG9mZmxvYWQsIFR4IGNoZWNrc3VtIG9mZmxvYWQgY2FwYWJpbGl0eSBpc24n
dCBkZWZpbmVkDQo+ID4gaW4gcmVnaXN0ZXIsIHNvIHR4X2NzdW0gYml0IGlzIGFkZGVkIHRvIHN0
cnVjdCBlbmV0Y19kcnZkYXRhIHRvIGluZGljYXRlDQo+ID4gd2hldGhlciB0aGUgZGV2aWNlIHN1
cHBvcnRzIFR4IGNoZWNrc3VtIG9mZmxvYWQuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBAQCAtMTYz
LDYgKzE4NCwzMCBAQCBzdGF0aWMgaW50IGVuZXRjX21hcF90eF9idWZmcyhzdHJ1Y3QgZW5ldGNf
YmRyDQo+ICp0eF9yaW5nLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAJZG1hX2FkZHJfdCBk
bWE7DQo+ID4gIAl1OCBmbGFncyA9IDA7DQo+ID4NCj4gPiArCWVuZXRjX2NsZWFyX3R4X2JkKCZ0
ZW1wX2JkKTsNCj4gPiArCWlmIChza2ItPmlwX3N1bW1lZCA9PSBDSEVDS1NVTV9QQVJUSUFMKSB7
DQo+ID4gKwkJLyogQ2FuIG5vdCBzdXBwb3J0IFRTRCBhbmQgY2hlY2tzdW0gb2ZmbG9hZCBhdCB0
aGUgc2FtZSB0aW1lICovDQo+ID4gKwkJaWYgKHByaXYtPmFjdGl2ZV9vZmZsb2FkcyAmIEVORVRD
X0ZfVFhDU1VNICYmDQo+ID4gKwkJICAgIGVuZXRjX3R4X2NzdW1fb2ZmbG9hZF9jaGVjayhza2Ip
ICYmICF0eF9yaW5nLT50c2RfZW5hYmxlKSB7DQo+ID4gKwkJCXRlbXBfYmQubDNfYXV4MCA9IEZJ
RUxEX1BSRVAoRU5FVENfVFhfQkRfTDNfU1RBUlQsDQo+ID4gKwkJCQkJCSAgICAgc2tiX25ldHdv
cmtfb2Zmc2V0KHNrYikpOw0KPiA+ICsJCQl0ZW1wX2JkLmwzX2F1eDEgPSBGSUVMRF9QUkVQKEVO
RVRDX1RYX0JEX0wzX0hEUl9MRU4sDQo+ID4gKwkJCQkJCSAgICAgc2tiX25ldHdvcmtfaGVhZGVy
X2xlbihza2IpIC8gNCk7DQo+ID4gKwkJCXRlbXBfYmQubDNfYXV4MSB8PSBGSUVMRF9QUkVQKEVO
RVRDX1RYX0JEX0wzVCwNCj4gPiArCQkJCQkJICAgICAgZW5ldGNfc2tiX2lzX2lwdjYoc2tiKSk7
DQo+ID4gKwkJCWlmIChlbmV0Y19za2JfaXNfdGNwKHNrYikpDQo+ID4gKwkJCQl0ZW1wX2JkLmw0
X2F1eCA9IEZJRUxEX1BSRVAoRU5FVENfVFhfQkRfTDRULA0KPiA+ICsJCQkJCQkJICAgIEVORVRD
X1RYQkRfTDRUX1RDUCk7DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJCXRlbXBfYmQubDRfYXV4ID0g
RklFTERfUFJFUChFTkVUQ19UWF9CRF9MNFQsDQo+ID4gKwkJCQkJCQkgICAgRU5FVENfVFhCRF9M
NFRfVURQKTsNCj4gPiArCQkJZmxhZ3MgfD0gRU5FVENfVFhCRF9GTEFHU19DU1VNX0xTTyB8DQo+
IEVORVRDX1RYQkRfRkxBR1NfTDRDUzsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlpZiAoc2ti
X2NoZWNrc3VtX2hlbHAoc2tiKSkNCj4gDQo+IFdoeSBub3QNCj4gDQo+IAkJfSBlbHNlIGlmIChz
a2JfY2hlY2tzdW1faGVscChza2IpKSB7DQo+IA0KPiA/DQoNCk9rYXksIGFjY2VwdC4NCj4gDQo+
ID4gKwkJCQlyZXR1cm4gMDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJaSA9IHR4
X3JpbmctPm5leHRfdG9fdXNlOw0KPiA+ICAJdHhiZCA9IEVORVRDX1RYQkQoKnR4X3JpbmcsIGkp
Ow0KPiA+ICAJcHJlZmV0Y2h3KHR4YmQpOw0KPiA+IEBAIC0xNzMsNyArMjE4LDYgQEAgc3RhdGlj
IGludCBlbmV0Y19tYXBfdHhfYnVmZnMoc3RydWN0IGVuZXRjX2Jkcg0KPiAqdHhfcmluZywgc3Ry
dWN0IHNrX2J1ZmYgKnNrYikNCj4gPg0KPiA+ICAJdGVtcF9iZC5hZGRyID0gY3B1X3RvX2xlNjQo
ZG1hKTsNCj4gPiAgCXRlbXBfYmQuYnVmX2xlbiA9IGNwdV90b19sZTE2KGxlbik7DQo+ID4gLQl0
ZW1wX2JkLmxzdGF0dXMgPSAwOw0KPiANCj4gV2h5IGlzIHRoaXMgcmVtb3ZlZCBhbmQgaG93IGlz
IHRoaXMgY2hhbmdlIHJlbGF0ZWQgdG8gdGhlIGNoZWNrc3VtIG9mZmxvYWQ/DQoNCnRlbXBfYmQg
aGFzIGJlZW4gY2xlYXJlZCBhdCB0aGUgYmVnaW5uaW5nLCBzbyB3ZSBkb24ndCBuZWVkIHRvIGNs
ZWFyDQpsc3RhdHVzIGFnYWluLg0KKwllbmV0Y19jbGVhcl90eF9iZCgmdGVtcF9iZCk7DQoNCkFu
ZCBsc3RhdHVzIGFuZCBhdXgqIGZpZWxkcyBhcmUgaW4gdGhlIHNhbWUgdW5pb24uIENsZWFyaW5n
IHRoZSBsc3RhdHVzDQpmaWVsZCB3aWxsIGNsZWFyIHRoZSBjaGVja3N1bSBvZmZsb2FkIGF1eGls
aWFyeSBpbmZvcm1hdGlvbiBwcmV2aW91c2x5IHNldC4NCg0KdW5pb24gew0KCXN0cnVjdCB7DQoJ
CXU4IGwzX2F1eDA7DQoJCXU4IGwzX2F1eDE7DQoJCXU4IGw0X2F1eDsNCgkJdTggZmxhZ3M7DQoJ
fTsgLyogZGVmYXVsdCBsYXlvdXQgKi8NCglfX2xlMzIgdHhzdGFydDsNCglfX2xlMzIgbHN0YXR1
czsNCn07DQoNCj4gDQo+ID4NCj4gPiAgCXR4X3N3YmQgPSAmdHhfcmluZy0+dHhfc3diZFtpXTsN
Cj4gPiAgCXR4X3N3YmQtPmRtYSA9IGRtYTsNCj4gPiBAQCAtNTk0LDcgKzYzOCw3IEBAIHN0YXRp
YyBuZXRkZXZfdHhfdCBlbmV0Y19zdGFydF94bWl0KHN0cnVjdCBza19idWZmDQo+ICpza2IsDQo+
ID4gIHsNCj4gPiAgCXN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihu
ZGV2KTsNCj4gPiAgCXN0cnVjdCBlbmV0Y19iZHIgKnR4X3Jpbmc7DQo+ID4gLQlpbnQgY291bnQs
IGVycjsNCj4gPiArCWludCBjb3VudDsNCj4gPg0KPiA+ICAJLyogUXVldWUgb25lLXN0ZXAgU3lu
YyBwYWNrZXQgaWYgYWxyZWFkeSBsb2NrZWQgKi8NCj4gPiAgCWlmIChza2ItPmNiWzBdICYgRU5F
VENfRl9UWF9PTkVTVEVQX1NZTkNfVFNUQU1QKSB7DQo+ID4gQEAgLTYyNywxMSArNjcxLDYgQEAg
c3RhdGljIG5ldGRldl90eF90IGVuZXRjX3N0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYNCj4gKnNr
YiwNCj4gPiAgCQkJcmV0dXJuIE5FVERFVl9UWF9CVVNZOw0KPiA+ICAJCX0NCj4gPg0KPiA+IC0J
CWlmIChza2ItPmlwX3N1bW1lZCA9PSBDSEVDS1NVTV9QQVJUSUFMKSB7DQo+ID4gLQkJCWVyciA9
IHNrYl9jaGVja3N1bV9oZWxwKHNrYik7DQo+ID4gLQkJCWlmIChlcnIpDQo+ID4gLQkJCQlnb3Rv
IGRyb3BfcGFja2V0X2VycjsNCj4gPiAtCQl9DQo+ID4gIAkJZW5ldGNfbG9ja19tZGlvKCk7DQo+
ID4gIAkJY291bnQgPSBlbmV0Y19tYXBfdHhfYnVmZnModHhfcmluZywgc2tiKTsNCj4gPiAgCQll
bmV0Y191bmxvY2tfbWRpbygpOw0KPiA+IEBAIC0zMjc0LDYgKzMzMTMsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGVuZXRjX2RydmRhdGEgZW5ldGNfcGZfZGF0YSA9DQo+IHsNCj4gPg0KPiA+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGVuZXRjX2RydmRhdGEgZW5ldGM0X3BmX2RhdGEgPSB7DQo+ID4g
IAkuc3lzY2xrX2ZyZXEgPSBFTkVUQ19DTEtfMzMzTSwNCj4gPiArCS50eF9jc3VtID0gMSwNCj4g
DQo+IE1heWJlIG1ha2UgaXQgYGJvb2wgdHhfY3N1bToxYCBpbnN0ZWFkIG9mIHU4IGFuZCBhc3Np
Z24gYHRydWVgIGhlcmU/DQoNCkkgdGhpbmsgJ3U4IHR4X2NzdW06MScgaXMgZmluZSwgd2UganVz
dCBuZWVkIHRvIGNoYW5nZSAiMSIgdG8gInRydWUiLiBBZnRlcg0KYWxsLCAndTggeHh4Om4nIGZp
ZWxkcyBtYXkgYmUgZGVmaW5lZCBsYXRlci4NCg0KPiANCj4gPiAgCS5wbWFjX29mZnNldCA9IEVO
RVRDNF9QTUFDX09GRlNFVCwNCj4gPiAgCS5ldGhfb3BzID0gJmVuZXRjNF9wZl9ldGh0b29sX29w
cywNCj4gPiAgfTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2VuZXRjL2VuZXRjLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGMuaA0KPiA+IGluZGV4IDcyZmEwM2RiYzJkZC4uZTgyZWI5YTkxMzdjIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5oDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmgNCj4g
PiBAQCAtMjM0LDYgKzIzNCw3IEBAIGVudW0gZW5ldGNfZXJyYXRhIHsNCj4gPg0KPiA+ICBzdHJ1
Y3QgZW5ldGNfZHJ2ZGF0YSB7DQo+ID4gIAl1MzIgcG1hY19vZmZzZXQ7IC8qIE9ubHkgdmFsaWQg
Zm9yIFBTSSB3aGljaCBzdXBwb3J0cyA4MDIuMVFidSAqLw0KPiA+ICsJdTggdHhfY3N1bToxOw0K
PiA+ICAJdTY0IHN5c2Nsa19mcmVxOw0KPiA+ICAJY29uc3Qgc3RydWN0IGV0aHRvb2xfb3BzICpl
dGhfb3BzOw0KPiA+ICB9Ow0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQo=

