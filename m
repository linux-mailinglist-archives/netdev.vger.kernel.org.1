Return-Path: <netdev+bounces-211920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0BB1C809
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6832C3A4CE5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0055528D8CA;
	Wed,  6 Aug 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KhUxaJhg"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8428A406;
	Wed,  6 Aug 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492344; cv=fail; b=AmX863kuVg4DnCNGb59UqfnJuN880sJGCRHAGGG2IroNHVo98+2SbgXv+ixoqga22jRxPcS/GZgy58uvfLgxQVUsaMHI7ku7GW6yp5ryUsohiFk705TRmlqCcqY9x5D3/QqpZgVZY9d3wOvFY0iCsaGmmNKsBMUOi0kifTKpKcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492344; c=relaxed/simple;
	bh=1dS3DW73kJIYlwdQe73QWH19Sl9Y+tOjzvf7Y2RzuSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBmjWfFQ4WrCDIE80M1pkPJj7FY/8GiDFK7Ed6Vn0FDpM1J2DmrNPPEnpKQifPv1M9Ku8qplIPaaavDX5owj213xc0Nu4LVCMEyAGmcrtPcfY/ineGG2z9t6/SzviANUy+noHosqEUF3ZGPPRnBcMBToTqjQCrFHLfl5Ff8OXkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KhUxaJhg; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIQq76MgA+qiq0JTr2nbC1KRC5C6p/YTBKJv0r9E/rNGQhX9BmqPQ6iCcJwsA3wiLuqG4QcsgPm8AmXsituzmqTHaSnDcKSEcFLc+oi/YEIYpWtq5qNeY5SFSGYIrYe5irUPcv08jOKxX97j1HZlktkSTng7R/hzY+xB4gEPmx2l0Q9fm4//ECHW0E7eddYZP7M91FjU5smG1mUB4+IPErxcn/0DRe4MecGEayGS8K16vPPxmtPZwmgVg5pgqt0bTZdAO8Di47Tc1PJ6XPfs33JiWIT6+1mf8ciSmAztiSGUF40/F05quF0zffnYaoB2L+pnFnHNyxPcUhtwg/E/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXTkDEBl1H7NSl6nmAnfc3/KccG0uw/DnNp1ES5ImGA=;
 b=zSA+ZZrUhAoLhK4WbFloiAqs8a+HUWe4IsFkQHkc1IMhEzW8wAwwSmwHjZwPCD6ENbvmaH74lP8taVkn+XF7vgQ8wABgTNdcyOvkmnrfo5YsDZK5yJNiot862hPqhkPe08CxxAvO7KBQlmlx2CjD5R3yE50JWRMngkpbgUn9ZgXLWzjeVovyk/0hUfsNERgQj2SpkaVGJP50EjadOPn/tI18IPIHwCdKpBBqah8RGGp3ZmCfR+Lbgy2b5RLCGvSbjEypXKmjLci0c9HlHsnPX2t7fIcGN+CV7OfVxblpoazo3jDXlZjtMZlHvuCIVqUVBoHj87sXUn4jqWP1iFCiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXTkDEBl1H7NSl6nmAnfc3/KccG0uw/DnNp1ES5ImGA=;
 b=KhUxaJhgAJxYYLKMCqZ+O5cIKOIpTwv/aIotLxawtmqSRAfPbtRuTRGOa8TR9saq3CipYsJmOPbbvdFfjnZVgT2VWXHB9HITRDCyWQ5MhtscDoCQzbkHyJ2ncdxcMU09PyifZXjV9PYEJp6w0jMsmOKY090IU4CMpbAh5zGXDrCCOMTfvEOy0m2aOxQn87ziVEfOYQLNnbWupfnDFGnNu5lDlSyESGj1SBNjrU2aHlCSzAfJwydN18V/Kn1Ldp0V2rHSUhSTe2rAHtlHpOnw+3VJNDwZAABdQDYB8/xxqZQ4011zgl4f15OiuYqHqV5w2d55FEbRQ543bYzUFRct4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7734.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 14:59:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:58:59 +0000
Date: Wed, 6 Aug 2025 17:58:56 +0300
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
Message-ID: <20250806145856.kyxognjnm4fnh4m6@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR09CA0153.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b8bcb3-2698-420e-f1e7-08ddd4f9c666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgEcGC4zNFBu9j/nywWWXljdo64sSjpofhYT3bR0KCquQnAxht1Nuu5Vwaqe?=
 =?us-ascii?Q?XimNdm9eXSxNu+iEsnl3WLzU6NTQJ+8DLu/o4ABCSqM8JFXz6weZ6Nub8Ebd?=
 =?us-ascii?Q?y3iid1gIUAzk0g3CQpfbXTd+jSCDUSOLlrzcrDENnnDVs4R+BJMGs5yQRL6W?=
 =?us-ascii?Q?tAdFZPyu8lk/GVsXV10ZEe4SL5FBDR9/9D6yjC3RGYksUyvDPE2MPwtZg/VO?=
 =?us-ascii?Q?LZbdJHEjKzMY0ZzUTMTPzhBOCVR8iQYD8z8ib7mnfaXWcZF5QGqOaC1B2cqF?=
 =?us-ascii?Q?d4iurq3+herdA72twCbizNqsL1b2pFx+wfIgaz9y4Ev651XBXn5jPTnXjjL/?=
 =?us-ascii?Q?ByQOnpQVqJjRXqY65IyK+M6BGJ4JafRi7hjHcqNjAc0Tzuwk2w24tzeUqoIO?=
 =?us-ascii?Q?DUWwxX78LozUk5UJBoK7pKaewcBWtrKM9k3c5Nv7qd/WBieXpExYiCNTG8/j?=
 =?us-ascii?Q?kykqFgLhl01Ppr05pL2Z005Xj8ls6iN+LerLXRgHW7om4FDDK8Z+cBjBL70c?=
 =?us-ascii?Q?3pm7zk9LQAKw5jIUX05PTpqn+03Al+QTkaPkEpJ/NCdYwS5h7lSTat3gWWhp?=
 =?us-ascii?Q?13/4GoMs/gCcdmeG2mU+QLbbcy/gDsmNPndp+I8MhQEXosdFqX+/Tdy8QY+d?=
 =?us-ascii?Q?/lK2iWBDGStsNmNkcPyTpi6YsSc18awTbu5cYF4ppCxVbQfTDyWNEfSkM+gY?=
 =?us-ascii?Q?tHHXcLRAqPQ0kUtctaX4ts+AbayKriop5onfHiOBQ8PNUK24hI6plePon23+?=
 =?us-ascii?Q?Fky6f0Y0heT55lX4PM0TOiuwCJsAmDJIKzlcCHhEJBCSBElVDT4SLN7BirMu?=
 =?us-ascii?Q?YNJ8qUips59jQlM9dpfOL2rbEpNcu39Vul72p8RJ2sxWHT259TYoufND0t5H?=
 =?us-ascii?Q?Ieq4yibtnPVV2rK5ov+xpiqOOL9/tJDoH+oqlHt6iVSjnXVMTQT3Z6Mf7S/K?=
 =?us-ascii?Q?GnJ9cVr3SccaQQBClMnPScJ1FkNJR9edUFwDAxLYTE3kqqHXUrI+WeKhCFe4?=
 =?us-ascii?Q?HBrChmAzgighDw385FdECpRrdhsIFSgTFuffQi01aa7Wrnd4aREdCZsJWsiE?=
 =?us-ascii?Q?2smiucpOBCYQObdcn8Mj9BR1thIlyeGFEC2hBk1LiFOVwTd/NTjvmoLXN7mc?=
 =?us-ascii?Q?W1xwgKu/EsADf+//KzQDsdQlyxiBrNAJMY7T4aw3XmX24iZw8ZvxvzcH/Yzu?=
 =?us-ascii?Q?b7XY9N8vXv7wuTQ5t9RPZAeEstpMBTjeHov4uiyjbCkd1YbM4cuzsBK+dwPy?=
 =?us-ascii?Q?ccU9Q503BG4vr5OD7n/LxbfR/CTJrCyaPoZdDV80V6cIBjXYJUzsqcXynvgd?=
 =?us-ascii?Q?rDrU8qxM4is1A8CMCwn1Ww3OhdnkzWYoKJOnE1DOuxWcgqXGdiDDRz7fiIW0?=
 =?us-ascii?Q?Gi/lwaBqaw7Q0a4AhYmEm4CEZW8zTKoh//frRRIdLysmXyqoMSyOkxThTk+o?=
 =?us-ascii?Q?mmL79LIhR+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3JVsu3zhOsD+Gq9P+wNH1eA1P/ljHXjeL9zWZLVefLIxQrsBjXQiYSwRfPAM?=
 =?us-ascii?Q?hTZ9OC6SPgv9DDWUdVjYI/Fo81U3aL2+PhhaA3nm12EqT5GLUki24LydcEg1?=
 =?us-ascii?Q?jP8LuJauxssseTVTKKnL/j2eKf4rXXN/RbLPOx9XKKAJAqwOZRedBzTFEk+B?=
 =?us-ascii?Q?k/E9I5+tIT77D7XRjcqm5PIcivnBZ9XScZUt5/BWAU7E7shwio1BUEyIRfI8?=
 =?us-ascii?Q?K7noZe70/Gqojmgopg9XR4/7Jns6lPoxDnB9q47qtl7MCqp8CXkJTCPyuQc5?=
 =?us-ascii?Q?tCZdMd/wtvv69Jraw7D9V/4fxFlSMFUk8mlHhvoEAXoxobFa/L3Z7PjP46jJ?=
 =?us-ascii?Q?I2/htCyDJ814VrjwxfigIJ2CXD3HHlt2NhE4f780hWM5s/tDZepRJXYU09b4?=
 =?us-ascii?Q?n9dW9pJZzR3TqNgLhnQp9fJwygMgZ7j6zBrtnRuK/DXNwpmRb6xB4MonR+zu?=
 =?us-ascii?Q?TNBEBqvNDGunNKQqz+sAg8+2hg3usqNNaUQhvxEbl1hJZqqP2L7QpYcsYc01?=
 =?us-ascii?Q?Ynd9+TxWpouldMW1R1sKDFycXXq1Vudx347+w97i+Uc4EwsmYhucq252QZo4?=
 =?us-ascii?Q?ns+kKIpPj0JF4wA+xP7xZNQxVNkeAv2Jphc/rcy1ayGN3uAGJT9koAFC1pVK?=
 =?us-ascii?Q?gVRy6TNxKGVwnj8VXiBMjq37BdnZdvv/Lu5f6RmXOXhMEigVKAkpKOeDDMsx?=
 =?us-ascii?Q?9lA6FuzkJulW+iQW4WGBwnvPa1KGeVmhIeaTCp9gcNpwGJGAdeCcOH8M9i8L?=
 =?us-ascii?Q?EJYM9SSUdsEVbpeMaD1V8k//6UqzbD8OZdhgHyWtzoScEBj7hToUB8Yg18XY?=
 =?us-ascii?Q?QzyJ5NlaeaaP6qrl6ypTyfCRa/V6RDuR3OqhQQI20fBeZCjUl6IL+o0fP8vD?=
 =?us-ascii?Q?BnFM9muOlMxqlC5AVB/OqA0qqZGiSf/S2CHeo9Gz1jmW59Vh7SpOmUEYhvL2?=
 =?us-ascii?Q?QfOD+dZKBUZd1bB6EQdSLH4qDpwQssETVwLCKVEbbGAlY/k7YDn0FDN8PufD?=
 =?us-ascii?Q?KkFC1xJ9v5l3olxVQyjFbZEyPFl0xvg610/eM3tNRP34T9t82N8YKtK89luO?=
 =?us-ascii?Q?dWZ+/Xm0uXYFMO3K1SxE4kqp3CZx4NXOGChr55aWautpA2sLP5Rf2dir2CDW?=
 =?us-ascii?Q?ixC27h/33Dc/XdDPqPS+fZAFFLqPj6YwQhOSLU828rNJ0wY7bZWikLiDuRSe?=
 =?us-ascii?Q?Xm0aJ4O1gA+J46ZymaT0ZliQWtxoa2aIdPM4h9H1d0E2asx0rrtNzgiuDi+e?=
 =?us-ascii?Q?6W+2QSm6cZQU4YaPPvqWEIl0xUSEjoysVzwhgmBNQSYTX/CJm5GTQaCnRjbW?=
 =?us-ascii?Q?boAqbY/0cjAGeSNv4Hqge+neyxfkcEqZQqkuk0qNebAWviyIo72IWopGHNMQ?=
 =?us-ascii?Q?/DMBoGojJxu+v5qnad8MpGwohmgpxbAXhE96Yta5hriMHI/NLtiK5lXR+SK5?=
 =?us-ascii?Q?oRz2QzRuVj0KSl+hg/GZnbtMpLFA1z1lb71q797w5/MhdkY11AppqRpxzm+5?=
 =?us-ascii?Q?O0QH/Nv/ycCkdxZYLLI+k/KspJvyBWhx+QIARZ5o8dUYEjRquIU9ukW2WFPo?=
 =?us-ascii?Q?r2XD7csZKuaff2a2pqPUK0ammehxAcl99VTMAX4sRN1u+UnHGEfbk2+Qb5I1?=
 =?us-ascii?Q?eO4Cd2T/GaH86Wj7SOaR3s/44OXkA4N2hwXCspDReHCvwXYGwtD3Bul+R08+?=
 =?us-ascii?Q?dtOGOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8bcb3-2698-420e-f1e7-08ddd4f9c666
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:58:59.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z/pvGCMW1EPPXmTukGWH/p8O3RIcODdJq3AMnY4cwODQt/efyXRSkNDcZslzXZSPbSfxlCWTuncGttkbMtkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7734

On Tue, Aug 05, 2025 at 02:44:15PM +0200, Alexander Wilhelm wrote:
> Patch is applied. Here are the registers log:
> 
>     user@host:~# logread | grep AQR115
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10 SerDes mode 4 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 100 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 1000 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 2500 SerDes mode 4 autoneg 1 training 1 reset on transition 0 silence 1 rate adapt 0 macsec 0
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 5000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
>     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 0 macsec 0
>     fsl_dpaa_mac ffe4e4000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)
> 
> While 100M transfer, I see the MAC TX frame increasing and SGMII TX good frames
> increasing. But the receiving frames are counted as SGMII RX bad frames and MAC
> RX frames counter does not increase. The TX/RX pause frames always stay at 0,
> independently whether ping is working with 1G/2.5G or not with 100M. Do you have
> any idea here?
> 
>     user@host:~# ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0' && ethtool --phy-statistics eth0 | grep -v ': 0' && ethtool -I --show-pause eth0
>     Standard stats for eth0:
>     eth-mac-FramesTransmittedOK: 529
>     eth-mac-FramesReceivedOK: 67
>     eth-mac-OctetsTransmittedOK: 79287
>     eth-mac-OctetsReceivedOK: 9787
>     eth-mac-MulticastFramesXmittedOK: 43
>     eth-mac-BroadcastFramesXmittedOK: 451
>     eth-mac-MulticastFramesReceivedOK: 32
>     eth-mac-BroadcastFramesReceivedOK: 1
>     rx-rmon-etherStatsPkts64to64Octets: 3
>     rx-rmon-etherStatsPkts65to127Octets: 42
>     rx-rmon-etherStatsPkts128to255Octets: 18
>     rx-rmon-etherStatsPkts256to511Octets: 4
>     tx-rmon-etherStatsPkts64to64Octets: 5
>     tx-rmon-etherStatsPkts65to127Octets: 385
>     tx-rmon-etherStatsPkts128to255Octets: 26
>     tx-rmon-etherStatsPkts256to511Octets: 113
>     PHY statistics:
>          sgmii_rx_good_frames: 21149
>          sgmii_rx_bad_frames: 176
>          sgmii_rx_false_carrier_events: 1
>          sgmii_tx_good_frames: 21041
>          sgmii_tx_line_collisions: 1
>     Pause parameters for eth0:
>     Autonegotiate:	on
>     RX:		off
>     TX:		off
>     RX negotiated: on
>     TX negotiated: on
>     Statistics:
>       tx_pause_frames: 0
>       rx_pause_frames: 0

Sorry, I am not fluent enough with the Aquantia PHYs to be further
helpful here.

I have made a procedural mistake by suggesting you to print select
fields of the Global System Configuration registers instead of the raw
register values. I am unable to say with the required certainty whether
the configuration for 100M and 1G is identical or not. The printed
fields are the same, however there could still be differences in the
unprinted bits (looking at bit 12 'Low Delay Jitter'). That's something
you should explore further.

About MAC RX counters not increasing at all. The mEMAC has a catch-all
RERR counter which increments for each frame received with a wider
variety of errors (except for undersized/fragment frames):
- FIFO overflow error
- CRC error
- Payload length error
- Jabber and oversized error
- Alignment error (if supported)
- Reception of PHY/PCS error indication
The structured ethtool statistics API doesn't seem to have a counter for
received frame errors in general, only for specific errors. So I didn't
export it in the patch I sent. It's possible that this counter is
incrementing (but the more specific RFCS/RALN/... counters apparently not).

In any case, the T1023 host configuration is literally unchanged from
1G to 100M, so I am suspecting a misconfiguration in the Aquantia
provisioning somewhere. Maybe an FAE or AE from Marvell can help you
further with this issue.

If you do contact them, please also request them to fix the discrepancy
where the Global System Configuration register for speed 2500 has
"autoneg 1", but all the other speeds have "autoneg 0" for the same
SerDes mode 4. It is precisely this concern that I was expressing to
Russell that makes it difficult to implement .inband_caps() based on
reading PHY registers.

