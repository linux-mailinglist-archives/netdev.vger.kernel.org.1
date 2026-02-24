Return-Path: <netdev+bounces-260465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aId6CVGInWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:15:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DA185FCE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACF973003BEF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF16637A489;
	Tue, 24 Feb 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zj/MwGqI"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD89376471;
	Tue, 24 Feb 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931723; cv=fail; b=eG352FXlqEUkf2fv3qu31BM7tGAPUfw30OksKgGJZ+kXP7QJPzboITZ0FO/VV/NXUVRd4/BTwFoqiuhRbmGC9IqM2t6twZLwhBNljtKUeTt7+gIOeZxFbgDxHeKFTGIg7oKwk4RZUDyvyEtNwxQkqFjLfVZV8PmaWDXDKwoH7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931723; c=relaxed/simple;
	bh=1pabV4sawhE1SJLoREUrMn/BwzN5P7iIq8NLGpd3xMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vag7fo907Y+Qynu9uVUCyG0xtr7i+C9q7esEu8ig+0Km1Zh77/yFm+mbfnGdWuewXQdvYgfwS+NZ9uu/mdg1HPmCP1EldINUVPGiKGc6v3a29X/2Tthariq2ARMcchftaqzs+e8nEFYwP2QiRa1TNzgYznrZy1oU51QZ3oEDyyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zj/MwGqI; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2Q6vkdtmKOx05zKrbAp7TNDdYZbkWkuQ6JZwpLNloCqWnyGX2ANSf+zM6ypfEBrw99yJYBqU50Q93RJlG8Od7PS6QdXLi64+5rbmAwXNzYPNSwp+3Nfm43MP5uzkqwNgWwDHek9BmKwSomYPauWPqvHsv1sdN/TDKdMntSGa1Sx0OIcqQ1xXHcC2XhergA6UWTLaHLCdPPMa19a7bZHXDXWkQZVopAp0kpW82gLUI9tYGeU4yJOV/ZdyrIkoHav1jPO8cQguGtMj8gOp/qgLbC0SSTSw4z7zH2daK5+p0/3Cj43fm/nEVwjkV6OKsXXIRInyOH8JPIkUHrFleIO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLZ5eMKSgxrziKxcZTjACpp8EAKsagBswR47fvgEQ/M=;
 b=lBsI0Qe57SNGNiqrvpIhBYRI5oOHGlj+aHR3WtW/S1SWTZh/K/XWhqeQ8VG0nkKEm6AP+K5xlDTFAYHEbRFju1icpP+cvsGunbdG1aH0VPX+jhqFJ7qdRfpwRLYrt82W3sod4fXqVQ0sZ9BwP6MTDRSzQZNBkPyqN2tAn5vRjwwBPX6dsMdnievTpLQRZCe6PVmX2ygC+KshUC1qRKMo2dPl3S8xSJa9ffyWx2ucHlCc7+ywQ12K/Bu4AXu8llILVsufhMIaGt2S+2qITm8GkUxYrBqXL/ZqOICCV9qpGYGSRzxHgBQwiKZhih3S8RX4qsAGyVxkba9Vr11Gf3MqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLZ5eMKSgxrziKxcZTjACpp8EAKsagBswR47fvgEQ/M=;
 b=zj/MwGqIjMO9W1k3TtTXGthWJPyjWesJHR5HES+voiIi5IVmptWDH5fb8FjXL7Hv33GmyHGR8MLM5Dl/e2iuGAIdECUkIcSXOT8q454LXe6Z9K5nMJ+Pk9cwCkzJ4u4FDhGWS+sawSzn60q/9/Hv9k17fdgsfvPtsJAln4YA3vk=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 11:15:17 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 11:15:17 +0000
From: "Neeli, Srinivas" <srinivas.neeli@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Thread-Topic: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Thread-Index: AQHcoWOqzDdhe8lnEUOy9LAm/yTeMbWLtASAgAYGU1A=
Date: Tue, 24 Feb 2026 11:15:17 +0000
Message-ID:
 <SN7PR12MB814759F384053CB4DFA8797B9374A@SN7PR12MB8147.namprd12.prod.outlook.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-5-srinivas.neeli@amd.com>
 <39ae9c0f-d832-4771-8177-838995fff4da@lunn.ch>
In-Reply-To: <39ae9c0f-d832-4771-8177-838995fff4da@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-24T11:13:17.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8147:EE_|SJ2PR12MB9087:EE_
x-ms-office365-filtering-correlation-id: 61878224-8cbd-42d2-6f25-08de7395fd61
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oLq7b+/CPNKAixg/Depwd3oyZn6S7tK8AeZmlAhUV1apch4pHGQdyh2LfpZS?=
 =?us-ascii?Q?ethDpL/Lwh6TVIHP8js9fC6YZa+E7wBMjdu0bQeePUSk0EBf1uw2XVfnrJh3?=
 =?us-ascii?Q?sOTDEDwzWv4MjqyBaLGJVCyBh3wupXaiyBmYC6gZLB02/GO5PDWosYR3qV2y?=
 =?us-ascii?Q?VfidN7uXdfy/bwPUVnKTecTZE+uRpGnbIsrs87u3pBFOjBcMQxeJRPH3dnQp?=
 =?us-ascii?Q?tHNOKAKsYI/ZqguOhZ+h/MyiUnUVvopcH8pnWK74MWt+38BndsQqD76ib3YH?=
 =?us-ascii?Q?1Coxuwp11MX/5D1oaC2Xj/GbdB3dtUGSetFfxbX90DFO/aU83pWVz9im5VEq?=
 =?us-ascii?Q?Ob1mPYzmpcNU+BYtccxOmL8r13Sidyrq5JZpvyU2527aDR93SQLDvkfwbaEL?=
 =?us-ascii?Q?aJ1d5r//4BFEcLAD/eMoxM8VrdMW3GGbG9F/gEFW5EfLcA1wpiT1sKpr9wQb?=
 =?us-ascii?Q?le47xZ8052vFy9HtxPCPBlznwtc5UOlgv5ip+BDBYraEfJG7YF+92RGdvhzZ?=
 =?us-ascii?Q?h+g8Cvdwgrxsr7OtKDA5IJJFqo5sJRGTC9ScFtkBdo7O2viojFXNsCoX4bmp?=
 =?us-ascii?Q?joJVQc+v8NLPo/SgWSyVQtam7rIRGN7WLCMSiiBNW1JWOvbi6yYTnGA0XBLY?=
 =?us-ascii?Q?QPv3pAx7zKgLB7IrEfXuOoMPQWrCCskA6ZHk07GqTQvEyQAHg3O6ESjrpmvr?=
 =?us-ascii?Q?C0JKCj9tNVCd475A9wpjlnEyephMMlEzWEDX4IRmeouTMsiTT70yrW1Lk1FZ?=
 =?us-ascii?Q?kDYWqOou9n04t1mKH5mxbJABYbpXOuDEK5Ar2aE/WAcHfwIivDBOV1+rT/Fb?=
 =?us-ascii?Q?ndK7auh8q5Wx9KvX0C5P837VbWOLkNKIjNufcBcxrt8vopVDFXbYvvoTn8LS?=
 =?us-ascii?Q?PJSVHz52g6RyVAqjz01NP6w7gSKHPUIiF+8GQrymlda71+CXMwFRA1aT4ckH?=
 =?us-ascii?Q?spu1wxmZ3JHvddEUs3rEkLN36Scw1I/cXorO2lWejYS7WQx/KrFQlQH2GuQv?=
 =?us-ascii?Q?JZEwjo5wW+31D/QgUMUCKSc9s9IF1fnxsaTwIxoA/cmsMSwmQlZfgxw2Fs2X?=
 =?us-ascii?Q?gGkZFJQYB7g5+Up4z7qry6xFJbEE4ArkmAmiALyT4EZj1zSXcY26qBrm6alg?=
 =?us-ascii?Q?A7RfL0hRq0iWoGoCEvqEVBM50arO31q3udHM+FBSZ4kphUWO93BD/Cm5JwRK?=
 =?us-ascii?Q?QUd3+MIeM7aPvhl0k7kxzfWgV4tssF6WhzIpdNcpC09RRfu0xsnm5vAbFnnm?=
 =?us-ascii?Q?W56EssevujGexBXtY9RoMlE2ry0pWRnAkWHtO2WGpu5HKtHfhn93RuxN0BOY?=
 =?us-ascii?Q?LOO0A/4i/bjPszkjl1S7iRr5eHVHt2erBqHT+VxN3V+O+L7QVl4DawAKw+3W?=
 =?us-ascii?Q?Q04BcctKub5bl3hVUfcEkn46lIJcRcSrQklCjM7zXFgjVMoEXOr9btFUekM2?=
 =?us-ascii?Q?afQmZZCGUWbx3oneXK6a4CtrGVGTqB84QzmXZ6GKok+WdIINL5en9pjLiLR3?=
 =?us-ascii?Q?x/9qTVnBxQqe6yu3lo7hEas7xUcCYma8jdoJX8mvdsVsdw5I/xtvM26WVMjP?=
 =?us-ascii?Q?zsNdPth+gWgd5PFKachkoO1ZkdCpXm+qluI14OJAlbBEXqTj7hadT/OLmbcC?=
 =?us-ascii?Q?jqxUJAQFCaRVrnrON8RUDds=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vsX7+9GafW8UXiCNOsvDYeMO5O0AD3z96mzg60A57RsVodMznD+KuTMhvZds?=
 =?us-ascii?Q?ud2nsLb9mSNiD45M4tmGuaMN2TZSIIw5MACy9xZEJLBmBmiZor4ZXvBD+ceB?=
 =?us-ascii?Q?k0nEbuqNSYShIig2LvRXV1FiW4Sg2CYFpkMptNIaDWrLErru10SK7F6zdyjl?=
 =?us-ascii?Q?J0VHtdAukzHx/BgosmJMuDJ+rFVdwkxFn7c++O9VQ7i9nA/xwjxReDGsy4vk?=
 =?us-ascii?Q?KtRpVEyxiT7lyYh63k0gc4l5EaMKdxtP0/eS8ks3klbbL8OPkhC32ZzJn52c?=
 =?us-ascii?Q?ehW7LpY8RsRJAT2Oq9Viij+FBnBlq5eNt0BT3iVQl0nc7cDWUUt0ykCK1xgr?=
 =?us-ascii?Q?PYqt0ubbFpG8QFe33t9XC6ZkwTKjbuxAa83vq65X9mQyuij0/Beeeg3rYulJ?=
 =?us-ascii?Q?CgBjypYgnh+Ef9lSo7H263HYAZuCdtLD6UXXbQuKZ7QQCZgaqPStN4nltxiB?=
 =?us-ascii?Q?QMbV7vuSofis65UXYSxKh44re83NjBnZEGEuKrk/LyZ2o1f4a8ItdaYbJWdE?=
 =?us-ascii?Q?1HgkweWIm8wPYxfbgQ+wKuRhJIIGSoPb/G/Wto7/idbu7FL8k5qLA5XOxhyr?=
 =?us-ascii?Q?g4dXMZZMs1poAtQoOWiMOqXtqjhdpTYGX5bZgJRnur+WUlfcI0rc+eXBGQsf?=
 =?us-ascii?Q?lnbNk8wI1rSsA7eQkXm4I8cbdv8aeNKftKPlMWL8oK4g4wlqBuDEipwJlzZa?=
 =?us-ascii?Q?N5n88x19vr8XFfix0g3rlY0pE/cTfVZI/yTg3/bUUa7upgjZn4fmy77zwOCK?=
 =?us-ascii?Q?RndOWn+qPKXnfm2JRTJqHFwdodqsQGgtWnchOA1iItuiVD/rcrdqTdJu3FvQ?=
 =?us-ascii?Q?7+XR6e6x6SgxZS1yJ0AVRgNGjSMfk3NV4vCWEGfJExu2uRHjmHVZSc1LKoVG?=
 =?us-ascii?Q?vZgwJmke9zV+zBd1SHmAAx3IL+MRZy3kuGeHQ9J9B0uPlV7y3GsMxsikqHNA?=
 =?us-ascii?Q?uUhDwt1E8wuK67XlrG8LtTPuTrDHlMuyIQ1MpQBcgcqEVejcVyx+W/sS68eU?=
 =?us-ascii?Q?OBz4avy1GBKR+jEL2mXkWTC54cb5BZFYIAwrc0npByoe54ZatsHe2+PcvJSG?=
 =?us-ascii?Q?F1eirixB9KNB+91wmozrO+ucpre4NBGykpGck1tvO3VMuXnVxDyv9HbScOmq?=
 =?us-ascii?Q?zPA7MhVB2xFZq/7AJdAeAcn4RzVBJA9TRLEl0qxK7aFuWdjYozxEEDyVMmQz?=
 =?us-ascii?Q?e0tnka8bzRmnN/seS7HBPBozlZzl/pwfnEffvBS4BZQSZpZD1qBpezu07B65?=
 =?us-ascii?Q?TWkAIT/ZQlmltFzR6iHy2+5AMWv2gZYEtHzMv2lXMgh43sb0w8/3smNubw4z?=
 =?us-ascii?Q?vHVwLBaC3c8Ytrem+GDbPkuejyxvCgh3Cn6JTkpfextmj5i4i2oEcR2EMkcU?=
 =?us-ascii?Q?+rIVXA27J1og/Bm87myKSBrzNZH29UH36nRVN8HIAZNLWGXyFtfP1fGUOpV2?=
 =?us-ascii?Q?Km1SojyWmwvlTPG8aVoQF171byK26JIj/MAhTBn6t4YxbS6S6Q2sbI0O3QtO?=
 =?us-ascii?Q?8VW3YFC9uIsoLYuYJwYF5JAbWH77v7ebTZxyG1h7jKlzYd4XEARqFj98jOj/?=
 =?us-ascii?Q?hnxuIBet3A08kDifKtCc4JdS+7jtNBOug9qa/+BjRhQ0Vc/Du8bfaxkOh/8O?=
 =?us-ascii?Q?f3iECcunNKOSp1rS/J/vdiM2bzdEp3fL38OooJmdGQPof0rBElAZDtLp2Qef?=
 =?us-ascii?Q?k5wv0O4iJ8PadtAz5WssbsoOsRlwXmofzLx3Dk9oFLyxYqbU?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61878224-8cbd-42d2-6f25-08de7395fd61
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 11:15:17.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+t3kgXy3KGGuyINIQnU8jX/MuIgpGSu2DvcEzYwALczxfaEjy3zI/ejrNQ7lgKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260465-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: 451DA185FCE
X-Rspamd-Action: no action

[Public]

Hi,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, February 20, 2026 8:43 PM
> To: Neeli, Srinivas <srinivas.neeli@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Simek,
> Michal <michal.simek@amd.com>; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; richardcochran@gmail.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDI=
O
> support to the TSN driver
>
> > +#define TSN_EMMC_LINKSPEED_10              0x0        /* 10 Mbit */
>
> If the MAC cannot do 10Mbps, why have this?
>
> > +static int emac_open(struct net_device *ndev) {
> > +   struct tsn_emac *emac =3D netdev_priv(ndev);
> > +   struct phy_device *phydev =3D NULL;
> > +
> > +   if (emac->phy_node) {
> > +           phydev =3D of_phy_connect(emac->ndev, emac->phy_node,
> > +                                   tsn_adjust_link_tsn,
> > +                                   emac->phy_flags,
> > +                                   emac->phy_mode);
> > +           if (!phydev)
> > +                   dev_err(emac->common->dev, "of_phy_connect()
> failed\n");
> > +           else
> > +                   phy_start(phydev);
> > +   }
>
> Somewhere around here, i would expect you to tell phylib the MAC cannot d=
o
> 10Mbps. You don't want the PHY offering those speeds for autoneg, otherwi=
se
> it might actually negotiate 10Mbps.
>
> I also think you should be using phylink, not phylib. But we first need t=
o finish
> the discussion about DSA vs pure switchdev. If this ends up being a DSA d=
river,
> you will be using phylink anywhere. If it is a pure switchdev driver, i w=
ould still
> recommend using phylink, you are less likely to get things wrong, because=
 the
> API is better designed.
>
>     Andrew

Thank you for the detailed feedback.

I agree with your comments. I plan to rework this driver to use the phylink=
 framework instead of phylib, as it is a better fit and avoids getting thes=
e details wrong.

In the next revision, I will also address the 10 Mbps handling and ensure t=
hat unsupported link modes are properly constrained, so they are not advert=
ised or negotiated.
Thanks for the guidance.


Thanks
Neeli Srinivas


