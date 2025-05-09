Return-Path: <netdev+bounces-189157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08741AB0C93
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60B43A6D55
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7B270EB5;
	Fri,  9 May 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CjZT2bM0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45126A1DA;
	Fri,  9 May 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777979; cv=fail; b=PiWtIwFi1O8xpfg6MTi2IJTnZriICiZE9Ac/iSyHPKMhKj4euvSVRC9zNwyz4khlFYlMsaQwL4LiFmMsvU6m6smtdxQ8FAMmt+AYtCNotOi/OmXWa1KXrWX5o5CyG4/WpSWIzOKtVWSURf5OknASJmSQmuND50zw8oX+ZjPJrck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777979; c=relaxed/simple;
	bh=U1NHF79iLadZVw5KFER34RoZlcJMqi50gYU3ZKP5kp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nSP9Mg7RXHl+KobD/cPG+f6GsXP8zThk4xDfvYermgNsW+TH+1G2NwUQTxY8ow1ZsNZB3uMBonBqUTW3O7T92KPIagCjdP0W/ebS8zZvZVkvOXFDs4hyOjMdCOTSW1JygF21fHjxKWFDT5PdZByKPEVn3DxLLEiydGX6FVR2XAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CjZT2bM0; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGhhcwGs0uOoI65CV11+sScYkjFCYiWKWSZfFTZ0MAXUxYMLzcwjBGbYnts9h4iapGK4v1QmuWglDg3Mmy5/hY7o1aEBMkPxp6nQ4GZhJq+VnbQmZ4KgrR5wZosfgO91GiHqBfa6FDb/sXgLcECP7CFSr8+m34PpZxgmEVMg6S6K/jYXa4Xq39QldF1ZP9vLvIh7AxuwFdLWjEG269fstpITrmraP/byZhL5iVQAwFkg+LAapFB4XYDV/0D2HGd7HKTl4kRLRJBX7nAtLRe14Pt2iDBrmP+eZUT/Fledfn5/1DNsTfIOGxGxvgXJNu+/Kp4ytCT6kKqHSgOBsJmm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2MWhxTlYFajg/irs69pH5zmJkNeFGrb9CAQx7BJx2k=;
 b=SpK0M6bl3UR4busBRbzF5Iq4j9gJqvb1fR+bUOHiARNDXPAJ1z86rUfbopGbe5qTWganFEuzK+BLzfTPUH5z19mg0jWNSwfYBpY/qOycq9RS/kH7NDfY2tADnxyFJVGmcg+lRn5GvktXyCxTUsBheiM38lOaQE4Ng5xUrneUJ/t0zCdOjt8r70Td7C4Ngr4MiQtEU2w+GHecgUrz3Bkub05VwRTFhYbTKCERh7GvWnwgpSuMtKv5OTsX1RptaJVhDNKFV9ADBgTBGjLPxdK8C5M5/cff5aYjzVFra2EfNIroFIedm7ZlyG0GzQfbl3dAGT1LJsG34g2Ty300/EG88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2MWhxTlYFajg/irs69pH5zmJkNeFGrb9CAQx7BJx2k=;
 b=CjZT2bM0JyttyhQTBopF6mnJVHyvOnn7qaDDeWodzf28CKx0IKXkaA0QlVhl1Sw1b5vkA0C3212nVyo8ehwSTNbybrR8S85mKbEEJHZBWQtZwwZko4dDo5pW1rGdg+CHvFeGgwg2R/0s8bizQaPidiskXOgpqNb/oNIbzJ1oAVU=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 08:06:10 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 08:06:10 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Can Ayberk Demir <ayberkdemir@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: net: axienet: safely drop oversized RX frames
Thread-Topic: [PATCH v2] drivers: net: axienet: safely drop oversized RX
 frames
Thread-Index: AQHbwKzxjgO2LrCKBkeMM+DnkMfdzLPJ6Qkw
Date: Fri, 9 May 2025 08:06:10 +0000
Message-ID:
 <BL3PR12MB6571CC45853F09B6AD9477C9C98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250508150421.26059-1-ayberkdemir@gmail.com>
 <20250509063727.35560-1-ayberkdemir@gmail.com>
In-Reply-To: <20250509063727.35560-1-ayberkdemir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=63c434cb-5c04-4bb9-b1e9-b11825536167;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T07:37:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: 3dc03197-1bb0-496d-0810-08dd8ed05be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UkVBNKAzjZtqceaYDO7ycVcD2kg4xs4o8zLgR9+27+nQmfNrq9UuPuU0TiOw?=
 =?us-ascii?Q?bwJAeT/tfDIl90I2ck2p7BTXfMhS5zxysU65H2KUtwwzS/7w6TNFlVg2htH5?=
 =?us-ascii?Q?KBx0U59UQNyWkl+OR7uztK9pOZYS9a0Pie1fcKiLg/cV1E0fHxlRtH4hQ78t?=
 =?us-ascii?Q?La2SRPX84eF3wPlVA3BYT0W0Ab/0c17+MzMob4PzoBjNpuFp+Ok6G1RXK39P?=
 =?us-ascii?Q?1g6Ieu3j5dKoFF5ovTaOMkAp5BjW6sIJUqhyGTwP0xL9U80anajcuuliYPp8?=
 =?us-ascii?Q?vawcy6ek+N/fqc9tQatYsmT4r0hn7/eU9Betrq6Iw/CD+KMiGB+joOCVgL69?=
 =?us-ascii?Q?8M4fvxlhz4oJhketQj96w1MlP+g65WyXfzByfcHhkwm+d6EaQOrxZCrHHs+9?=
 =?us-ascii?Q?aJ3ef/ysp8emAMNiVXb1fdZF+u60HXQDfwH18zHfnlNqeqP2GqkiVti2CEs4?=
 =?us-ascii?Q?cl6bcD+znv6ewDU6FWsG8188sA308igTRglgcm+ch0JGLLK8dhzWWmjT9OlJ?=
 =?us-ascii?Q?gif/9OUVRiGuN0r/9h9vxGDenbA5yDU1xUZOGbtJD8zminBUdnH1L0MY3S2L?=
 =?us-ascii?Q?Gyi7m+kOLef9hpK7ug/3oMihJ40sk3Sx7Fk7qfejgjQUW8Y9mrX7C+7QEOEf?=
 =?us-ascii?Q?gEtGnTKrUdc8tyd2qEIvJU7siPsTTGBBJnh9ZiMnByghaa4QfnzSN/ieWqKj?=
 =?us-ascii?Q?/8f9Ta3i7HlGhuqjhWdRQ8QDQwdJ+8cTmdgT0XEeAgv/klRovsfi58Sbn/k6?=
 =?us-ascii?Q?oJmbDYfdT1IdmXxP6/LK2KMghsr86Z81Ft06Lz+DmxixWzDk7oTgA5RkqJzL?=
 =?us-ascii?Q?Nodlkg3tZQ2z8JFlGDCjq9WEtjiAV89u6xBhpF7godeOBNiQ2CAbBIZb3wmm?=
 =?us-ascii?Q?xYTbaPEHJW/FmwHlY5sEZRIyuA4h7V6W5Bof3MtGfPGY6UICCwiBlyHXD2OF?=
 =?us-ascii?Q?1oXF5fDf0dm1C1x0n1MY7RvCD1YEiONInntmFLwkjsvUg9vQN9O6aqz6ime9?=
 =?us-ascii?Q?4J0bfrlnmUZw+XPPVtCsX9SE91zsqe3NZ3PowXXqXAGWffQBjMYL7g6mVEn8?=
 =?us-ascii?Q?n74LQaxAo2vgvw7grUnonfZ4HAoTsN3CXNnM5YZXBGfj0YGCefaVhQu+1yA+?=
 =?us-ascii?Q?wLCjIdmQTas0wKcsOC36rMS4iv5KsBPY8W7B7AAAjqnbp+UgoomH1RVtKxz4?=
 =?us-ascii?Q?B3MhvckwOZTnduYxETeBA6RoasTTeidQWphjnoJ+ZSEXvCrf7rEOCad2B2CY?=
 =?us-ascii?Q?/b+VYYj8cWjeURf6cTSm676FA1s6pxoJMd3l0OzBQDnIb/witU6n063HlkrO?=
 =?us-ascii?Q?zgiHbSgi6I2C6HBGqfZgaL0I0xMK6y9W4TMMXRfe4nV+97e26aoBpKbZe7k9?=
 =?us-ascii?Q?SdXolNzEKstKpD3mH8cs0JLdi6/kUi+ycFJe2RuuL6Dc+LZ7K4LL20RiapBt?=
 =?us-ascii?Q?WbyyuVBBLipcaTuvQIMjfkAntBo/2xcO8pPe26CYHr6NyKUJBxD6JEq3XxR5?=
 =?us-ascii?Q?INANhbUSyfUXxD8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/qpkJnGl1yNoRWCc4kxAAKSLjqy6u9SJPLq+nLpLO67sc3h+smgeWCsgb1sG?=
 =?us-ascii?Q?9S1FDFawd4zJ+IPxfHFPPQ21uWFUHzOPZVTTV8ke4fBnydTbQZVvuIgAM+Ex?=
 =?us-ascii?Q?bBddq7Dy+ixcox2DHEx31NsGk18W0OZTgCfcoxEXrjI2Af1zPMJRed5bncAL?=
 =?us-ascii?Q?lyFr36Zq/5bMddLmOzkmhuiWjQTnqk9v+HXT0d1w25Vh3CO9Ae9rzEZnrXEK?=
 =?us-ascii?Q?tJjOq5YB0bHs+wc6EM695niL6gXKwLDL+nqHzsSuQ6VbJmXERALfNE+9nB53?=
 =?us-ascii?Q?iA8NIFxnLcC2q9C8+3/CEic+jKNzyn/jleklHLMyPUsk9cfQSHR0M8RqON0A?=
 =?us-ascii?Q?hLIAWytnX33jPuTiOCZTusaVdQW/z3Cn1NCRjWwSF6wJjoJUOUWN6sVO8PYU?=
 =?us-ascii?Q?kocEHy7ec8rtWsD2l99HrMXb5MhsCxHWe/BxSvdzrPZiNh1bjgDNdgQR5t0A?=
 =?us-ascii?Q?VMHpaQ2j1eiAtwd86JWOGSZyMWOScFrdG/NxRIjFt16GCHz+4rRyt9/qbocZ?=
 =?us-ascii?Q?fSUETWhrEqmJWy5N3a1xTkyfSVlWvQyUo9/ZyQ+at9uNqF4kF1aGfoghcxH9?=
 =?us-ascii?Q?/0vIPwgaRfRbbS/Z6osvdAKhmxg7IFSyAWVtQ3f+XLq895rsqSHoGwgjnMSt?=
 =?us-ascii?Q?J16+pxn2UdawrEk0fH1uDA2nOIs7gznqiTX0fSI+aaCyZgLXofO1rhg3DKvO?=
 =?us-ascii?Q?yAi7wDx/kBRAlYhMwQsmiWro82+Dvr/0uTaTS39O3GfLIAqMhzdPEhRIWmf5?=
 =?us-ascii?Q?kirF069etTiYn2QP87rg4MWCDKmOqbQv8KQYLsjKFScI9fYO9Bt3GmRHevMG?=
 =?us-ascii?Q?PCdyYX2hfGCpEvqWQAdmsYvjOp5kPpx4JkqgYHOScow4hX7lkBc2tJ66RlSq?=
 =?us-ascii?Q?LjhUYN/oO+hjjQxiS89+u+JWbXE4dIwBTX0kGtHJBqswad5NfLjPSdZB0dCr?=
 =?us-ascii?Q?7kc5+hc50CJ3tUeL2MiybqYkCS/+5ozoICb1dKnzXWS5wM3+VRj4BKcwn36D?=
 =?us-ascii?Q?23W3OcD/dWie24n7umdbQ+7TNS9XH66MzpKHCbfpJACoJ42fQ96MlOQ3GWY1?=
 =?us-ascii?Q?XjfRfa40F7+TSCvE09qie5akOLMFb7FmUeLOBJIMAEIOw0hXhH9chHVS2Oe4?=
 =?us-ascii?Q?XNTrTaTQQVB9oDQyspOT4ht8bJykJ+uAvXALMcVlBwsm6YcjgF3zBYJZ2dSr?=
 =?us-ascii?Q?PaYn2EGV1CfepOZ7RUmBs12vbCyZOIwOXxLGWGnWCV2l9tjlHjsJYvw/tpkv?=
 =?us-ascii?Q?yuN1vi+rYomG51wlZujNzVROy8UY3sceJbKC5ml6eh6FtP0ipLh+L0yBWDzi?=
 =?us-ascii?Q?Sj+1vTLUmEEv40jKwjrCKlfO1qhuASEXZfMaSZ2FGLeN7LjAB2d0/7OAqJtu?=
 =?us-ascii?Q?0GhnLqNea0jM8VI78o2zdRUj1jc3+xSO4y+mSHF9q81SSJFgbGZBTI2NQC/i?=
 =?us-ascii?Q?tW2s+BvpQzqNQjxP8kEwM/nA3tvqzwb0nLuZQvmJXeQ+k9tqR69V+2TRsQdQ?=
 =?us-ascii?Q?qWcdii/ZHqls/l6zkWBO+ltm4BF09A4SdXX3TYtClkjJNW2CytoWKwkPHg9t?=
 =?us-ascii?Q?rdIlb2TGB6OEZOzGriA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc03197-1bb0-496d-0810-08dd8ed05be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 08:06:10.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KejIHWokKwhXNMjMOJe7Jp4iXQo3AFL7IO8V3CH7FpG5rhM+sGQbWVjwwoDm1UxwNpAlvw4cN2Aqlp8ZWm7xzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Can Ayberk Demir <ayberkdemir@gmail.com>
> Sent: Friday, May 9, 2025 12:07 PM
> To: netdev@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simek, Michal <michal.simek@amd.com>; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Can Ayberk =
DEMIR
> <ayberkdemir@gmail.com>
> Subject: [PATCH v2] drivers: net: axienet: safely drop oversized RX frame=
s
>

Since it's bug fix, please use subject prefix [Patch net vx]


> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> From: Can Ayberk DEMIR <ayberkdemir@gmail.com>
>
> This patch addresses style issues pointed out in v1.

Please add changelogs below "---" after SOB
>
> In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger than=
 the
> allocated skb buffer may cause memory corruption or kernel panic, especia=
lly when
> the interface MTU is small and a jumbo frame is received.
>

Please add Fixes tag and better to add call trace of kernel crash.

> Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
> ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 46 +++++++++++--------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1b7a653c1f4e..2b375dd06def 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1223,28 +1223,36 @@ static int axienet_rx_poll(struct napi_struct *na=
pi, int
> budget)
>                         dma_unmap_single(lp->dev, phys, lp->max_frm_size,
>                                          DMA_FROM_DEVICE);
>
> -                       skb_put(skb, length);
> -                       skb->protocol =3D eth_type_trans(skb, lp->ndev);
> -                       /*skb_checksum_none_assert(skb);*/
> -                       skb->ip_summed =3D CHECKSUM_NONE;
> -
> -                       /* if we're doing Rx csum offload, set it up */
> -                       if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
> -                               csumstatus =3D (cur_p->app2 &
> -                                             XAE_FULL_CSUM_STATUS_MASK) =
>> 3;
> -                               if (csumstatus =3D=3D XAE_IP_TCP_CSUM_VAL=
IDATED ||
> -                                   csumstatus =3D=3D XAE_IP_UDP_CSUM_VAL=
IDATED) {
> -                                       skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
> +                       if (unlikely(length > skb_tailroom(skb))) {
> +                               netdev_warn(ndev,
> +                                           "Dropping oversized RX frame =
(len=3D%u,
> tailroom=3D%u)\n",
> +                                           length, skb_tailroom(skb));
> +                               dev_kfree_skb(skb);
> +                               skb =3D NULL;

Update packet drop in netdev stats?

> +                       } else {
> +                               skb_put(skb, length);
> +                               skb->protocol =3D eth_type_trans(skb, lp-=
>ndev);
> +                               /*skb_checksum_none_assert(skb);*/
> +                               skb->ip_summed =3D CHECKSUM_NONE;
> +
> +                               /* if we're doing Rx csum offload, set it=
 up */
> +                               if (lp->features & XAE_FEATURE_FULL_RX_CS=
UM) {
> +                                       csumstatus =3D (cur_p->app2 &
> +                                                       XAE_FULL_CSUM_STA=
TUS_MASK) >> 3;
> +                                       if (csumstatus =3D=3D XAE_IP_TCP_=
CSUM_VALIDATED ||
> +                                           csumstatus =3D=3D XAE_IP_UDP_=
CSUM_VALIDATED) {
> +                                               skb->ip_summed =3D CHECKS=
UM_UNNECESSARY;
> +                                       }
> +                               } else if (lp->features &
> XAE_FEATURE_PARTIAL_RX_CSUM) {
> +                                       skb->csum =3D be32_to_cpu(cur_p->=
app3 & 0xFFFF);
> +                                       skb->ip_summed =3D
> + CHECKSUM_COMPLETE;
>                                 }
> -                       } else if (lp->features & XAE_FEATURE_PARTIAL_RX_=
CSUM) {
> -                               skb->csum =3D be32_to_cpu(cur_p->app3 & 0=
xFFFF);
> -                               skb->ip_summed =3D CHECKSUM_COMPLETE;
> -                       }
>
> -                       napi_gro_receive(napi, skb);
> +                               napi_gro_receive(napi, skb);
>
> -                       size +=3D length;
> -                       packets++;
> +                               size +=3D length;
> +                               packets++;
> +                       }
>                 }
>
>                 new_skb =3D napi_alloc_skb(napi, lp->max_frm_size);
> --
> 2.39.5 (Apple Git-154)
>


