Return-Path: <netdev+bounces-189145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF553AB0A46
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B24A75AB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C77269AFD;
	Fri,  9 May 2025 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYl0Alc8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF51FF5E3;
	Fri,  9 May 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770949; cv=fail; b=YfkiXldwsN4QIJwBtxnFJROA8p0hefpy1/0omNy9Gk/5rtpu1rV8EOjYfdSnHPsAQ7mubYTgjoXoO6xFJabUb2uqDO51RdVSPV1egEVrv65irwle3CMxyb0PwD2idLsqF7mBeyppKE/N54f/z/cwuhyRtEZIc/ra3wLBrGZAUFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770949; c=relaxed/simple;
	bh=T0oBpFyuUdiQrOvl3PbuimK9hA5II/P3/v8h3CQ7bV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crtEDvGmywFtThQJ5HGLTZM4feWL1/vWXIyQZotbLMopZtM/xvAADggslgAUDms5eBLGpyzlE4MQdc6OAunQPlrQbCQEzTOBgGsKguxKir0IWDY/ZLLKT1DgXHMMgBPict7L/m1zedsnVqpG5vzxGotC95lbM3IHktQzpC6w6Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYl0Alc8; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMYM/CFtxHgKQyUXyASp/qqkq6pbni4MyhW2nPU8OCC4w5lrxOLOMEYRBEyw2QOBjqrV3r2trduda9jN0MBoksE4UJ3HOq0yQJ+TAPg85BVK+/M66+YSc8lHxYwSGBhjz1/bSXT0gCHcP6xS4/AvMCVtF7yVIv73PN2iAyeH7UgRGOLeNTQVSDEywFk3dI+OmwntoSraGEBAzMBSSr8iQ9QuBhbFoof0MxoAPUKc+Ip91j8+UiHst5/JOCL+ZZixyuMuwzq9EOGG/CgA+fpssCEbH91Enmj3p9V9Coyc7MrSw11KlITHedt7FWZZnXXVHllx8bdRchtzxds4jBhMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHtB2kxJjJOk0Vc08E/pJQ8i/Dplf4R4ZQ+dhj8/feE=;
 b=Pc737p0irkFt/VAOFbBpU3hpYvXT8VIi7IMULdTn2eyft3JQ+aU1I4eEpKQ5koYVd+LYmKQKq+4gwa0wqtThiWDwKIoTZvAtJNYtWh1wzVp/W2Ez1ejcIlDovgrqQ2CC0k9XshCK9kIYfunvUGkKZBPG6YQeQpUgRho92qpEVWjm2jWeOXiR/9QcLXejupDV7tbBk4eTh9V18yGSsVZh45Xn80jYcyX7i3QPHfMvsD6RNltqsv6MTzQKAmtEZfUBE/gOzyHRb+tpCsSXRrGz1hRMNwIYaS93XB0ZC9oSVEtVQsp70PIBp7M45CeXKaiWTdLDbphtZRL66DfiT9QrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHtB2kxJjJOk0Vc08E/pJQ8i/Dplf4R4ZQ+dhj8/feE=;
 b=xYl0Alc8WP77XbluyBUuHix35A6PAnfA+i5PaKKOs/+XOr9XueRRSg0BMmlAFaZtIWM5/tksQlLinwN6kMJAGdqhS8V7e46BVlnhUAJj+PpmCAv4Bn3BwIFLBgOFDuc4DMY6P2NXOo3MwqVJRl9TeQeZq+auwRvUYyZGt7fy4os=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 06:09:00 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 06:08:59 +0000
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
Subject: RE: [PATCH] drivers: net: axienet: safely drop oversized RX frames
Thread-Topic: [PATCH] drivers: net: axienet: safely drop oversized RX frames
Thread-Index: AQHbwCsFor/eGfWpmEqqbhfM1N5WFrPJz97A
Date: Fri, 9 May 2025 06:08:59 +0000
Message-ID:
 <BL3PR12MB6571F73095B337D0527EE102C98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250508150421.26059-1-ayberkdemir@gmail.com>
In-Reply-To: <20250508150421.26059-1-ayberkdemir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe3595f5-ada7-4689-bdcb-d1296ecb65ae;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T06:03:36Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DM4PR12MB5842:EE_
x-ms-office365-filtering-correlation-id: 4ab53f93-ef37-46f0-421d-08dd8ebffd59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gQllqGZ2eRb34lyvD5YyzPGLa/cnBu5lTGE3rEq7GHBVk7lFIjj0+3MDzMTg?=
 =?us-ascii?Q?CDn6OInEq7EmBUPp6klSGTqs5lezbAWY34ld2k+bGgAJDtLyQAwXiJR71EYd?=
 =?us-ascii?Q?D+F8GSAkbUGVvpRYjfW+MZxwlqmSDKNRuUIoei4lbiXmENCh7Yb5nWySojaD?=
 =?us-ascii?Q?9yYGSk2/5vKBPRxWKOHP1HgUgKUGnRJlrVE/V5rv5Ydq6Zq4BNpXl05svYbE?=
 =?us-ascii?Q?XFlM8EzGp/PmcXdywD3/tte0rp6qtsTv28M9dtpGOAkGBntwC8EGMBncb4Mt?=
 =?us-ascii?Q?dHxr9XJxMaZ7GHCOmPDmPFNWqv1P6wfWLr2o4P1lZXxNvJg8fHAigjHqt7yV?=
 =?us-ascii?Q?jOVAO+2oL8IYRt79qrWvXg37y5zEPntqkmobgfb6mUKzm0+XiLBHSKJRwORq?=
 =?us-ascii?Q?j8U8XYW1qQw9Fa3vd0DMuGzk7p0+7o44Tho9CbnL/rDBOoz1JEusu4/ib0cR?=
 =?us-ascii?Q?QX5mz5JDl1NI6RFKe4Q3H3KUAtRL72HTqDh2SvsC6NDMsJHWZsU8m3FHQ4iY?=
 =?us-ascii?Q?hTfOVG8Hw/EopP9OnF7AnDT7PRmEiYU1+RZo429Rd2FRttiPvhwoEOvMWspg?=
 =?us-ascii?Q?f3S9ERO74ehTffcUTVIF7K4hIHM0Ba8lmQP+YFsqNLV3o/3upK7iTK8cSaMC?=
 =?us-ascii?Q?g9cf78vz1Vm1LtBsGaQfPiI0GWlIT/kG1KsLPFA0SYP38ngXEFnX+ilQZl23?=
 =?us-ascii?Q?rVWesPFknPtJfEuF+dhk+PoneT5z7W7j13D1DPnp4wm1IlAyRVipRetM5Vos?=
 =?us-ascii?Q?nskqsDazGC5tOD6V5RECWEwMV/hvMUfwqGFP99TTsbt8DKzSWWTfiU0hzpB/?=
 =?us-ascii?Q?DXZEl90mGDla8HbCR2T3+qJJeMPDP1+XcmqaI26Iw2sHr8IH7zhDVTKIVcS5?=
 =?us-ascii?Q?yYjwOdTpYXkTTT3GezkyiBKUYME5e376MiLlMTYqeObfigqdbqML6gaARnI0?=
 =?us-ascii?Q?MWASIsdf7X0sLZlnyP2AGaovGExYRD47jkfZOZz1L02mAZj8jGu42WOuR1ji?=
 =?us-ascii?Q?kb27FkBh4qjjiLjqMORW5WEPqMIg5/YeLKD74cleTCX+G7L5VF9ykJt8I9RO?=
 =?us-ascii?Q?KXjETeAlm3ZOJDjD+nMlu8teZPwO67TXqbJGImUAVdExtDOWyWZRv3KygUZV?=
 =?us-ascii?Q?C2ZXXF6ODYOWNp8tmmzFkUSQapMDgi+3neM9iKzuSdqZjpvHvUSnqnNmDVNT?=
 =?us-ascii?Q?iiflMwc+wbbMevqgNFNZRsyvPmgJ0mGGT0DGauVlMXO3VUe3SFgKhY3IasQi?=
 =?us-ascii?Q?nvVxVjI0J6SlivyVRI26Biu25mk+jfphgtqDg1S2BEWDUl7zLbPBnckjXKSS?=
 =?us-ascii?Q?ZyBziwnjOZ8Hqco7MSTWH8u0dMwvQ6gaF463j3CMiT/DDPF0yyEdwRib2+Kk?=
 =?us-ascii?Q?iS3XH1vFDc4HiQTOm+zduyTRbvIwiwE0YOUvGcvmQOGh3K3T5WTNhRLSQBuK?=
 =?us-ascii?Q?DZfuK6eAGUhahuIoIP2m+21ta6u56CfvMOGPyNTIEmYb0IfsAbKTpsFUb73w?=
 =?us-ascii?Q?/mCSAn4qJcB2TSU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aeGl5kedpJPpWMYwXLeL9adgKPuU7389AJPe8EEpJsYMo/3TYrOqSWbgG/dq?=
 =?us-ascii?Q?zcgMFSzXQ4iA9NbwYw5jGL4oQSi+xBCEVupU2QCNNxRjpuQOIiN7BgKDPyeY?=
 =?us-ascii?Q?JIEj2c6etw7TrNMnJoAiQ+j46fA+ZxGTlG2MCnLQsXp1HJM72EYxXE9VKLhw?=
 =?us-ascii?Q?Q0gfs/yPCmBVO0Hd9JqOppgODmYhVqhFKJp8jIqx84NjSub4TzWIrTDxy+9/?=
 =?us-ascii?Q?BUq/yJixlqdcNdS/1K3+VQWsYn9dD1TBR+XYZSPe6NjHVFNU4Z19uoxhKCbo?=
 =?us-ascii?Q?XpjasLQTomqELk3aPzjGNizcO9Cd+8l35Uhb0uz1BnQUEy4Glw8QhUT5WxjY?=
 =?us-ascii?Q?7gk473SGMUHlyrY020o0AOeC/Pn68db8fxh4aAYLE6LJDq8g9AWikMBi6gP/?=
 =?us-ascii?Q?vJiEmhVWV2XMDWC/lSyCIFQXBgDQ5eVWA/epISkWLrXZlzky6YCSBEP4VslZ?=
 =?us-ascii?Q?yLggtQAYcrCykemcOM3C5c2MpnpwxNcIEDNb9skLFffqxCTc0lQBzpjrt8Tf?=
 =?us-ascii?Q?2cf4x0NaMTGVCiDRyOQEyhaThMykkyQdjc9TrNZ+9ZPWNlvBSceLaOcZfzEh?=
 =?us-ascii?Q?XE4CS4rWMdJ4QI+Qo8A52shOce7eAcxkPVRLgZ7ZxzzOTj9Sd/2ao+gUkHgR?=
 =?us-ascii?Q?OJaeEspVUMJUsXHdQwpHK5mGQy85AFhA9dhf1ph5quWXJSl4cPCN6ALswrNj?=
 =?us-ascii?Q?9rNX6PaSYChYZRSb9UDQtrIpPBFCVkWgbHdVIs+U9qKf3y1AEotF/PKE3fjX?=
 =?us-ascii?Q?/Mp+NC8yF/DJEWIzOCDcPNR7+ZWP6noiMFWDaxzyZWcv2YM1dD77fSn84t4Q?=
 =?us-ascii?Q?A1/brN71V/112sDfm6BnI6JT8vfZ3cyk1tkZNGoeMykTwkiyN2Mub7Gepd5Y?=
 =?us-ascii?Q?oUel2upSSiAvD+iw8unbAVaR4u6ElXTSrjMUR48ROVYDpr25KH3PO8l5LY90?=
 =?us-ascii?Q?SWviOWeSvwPjIS9nih4QGnE/bejlvV+xe7nAsJw8Rrb+hW36FxRMxDIEsHH6?=
 =?us-ascii?Q?7WogGW4kgbqdc6yhyvQtgdrsEPSIEwwtgtL1qkAPKOHCBCiFUg5fkowJRPSg?=
 =?us-ascii?Q?KNrnBF6lNR3yZToTN8o9V0hlZqnPrcZUmvxYkNe0WJhCzn51fBT98uYvm+6N?=
 =?us-ascii?Q?sRUgh2cJA0c2IG8yUdXVebyH6oKvD4zogHUqfh4LgK2VKBw97jiIKOH2J9Z/?=
 =?us-ascii?Q?4TdToO6pPuIB1iY16mJ8JjyfM+6NsolZY0sNl1diZItRjJf2xojzI5FhKI4u?=
 =?us-ascii?Q?pKocb9DnRjQ39o29lWRslkW+nVXJL9Mhl27PaBhkzkZgooBlllF7th/eXnaM?=
 =?us-ascii?Q?AXSToWsOrx2kZ+JVC3ZTGLSsTqlNXGiniR8Xf5RclmIOwm7K6H/awo7ejxsF?=
 =?us-ascii?Q?2GUmzgzHNlUyqnXOV3Vw6ja4kaMlJjH76q/YvrF1i8gHhegvT0PanxVUp/nU?=
 =?us-ascii?Q?cj1OYRhONqQ1xXq3E8yXQ+wKANpBOjIBxIV3/y+kpF6z77QVDJnQdNeJN8+8?=
 =?us-ascii?Q?bzWqbUng59Qi3DvPbryhzkBTD38sTiussVlw6wrTuYvpq+lqHzFst+CqNvo+?=
 =?us-ascii?Q?+PfYeUwfO+SKnY7DhLc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab53f93-ef37-46f0-421d-08dd8ebffd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:08:59.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgezJd9vhLLTme0l5g7tcg68mcwg0EJE99SzGTY1LFLVFYjE2YGLi9D15g8jPRRgfcuET6oGIt+j7otv31kXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Can Ayberk Demir <ayberkdemir@gmail.com>
> Sent: Thursday, May 8, 2025 8:34 PM
> To: netdev@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simek, Michal <michal.simek@amd.com>; linux-ar=
m-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Can Ayberk DEMI=
R
> <ayberkdemir@gmail.com>
> Subject: [PATCH] drivers: net: axienet: safely drop oversized RX frames
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> From: Can Ayberk DEMIR <ayberkdemir@gmail.com>
>
> In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger than=
 the allocated
> skb buffer may cause memory corruption or kernel panic, especially when t=
he
> interface MTU is small and a jumbo frame is received.
>
> Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
> ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 46 +++++++++++--------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>



Please fix alignment and coding styles, some of them reported by checkpatch=
:

CHECK: Alignment should match open parenthesis
#46: FILE: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1228:
+                               netdev_warn(ndev,
+                                               "Dropping oversized RX fram=
e (len=3D%u, tailroom=3D%u)\n",

ERROR: space required before the open brace '{'
#50: FILE: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1232:
+                       }else{

ERROR: space required after that close brace '}'
#50: FILE: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1232:
+                       }else{

CHECK: Alignment should match open parenthesis
#61: FILE: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1243:
+                                       if (csumstatus =3D=3D XAE_IP_TCP_CS=
UM_VALIDATED ||
+                                               csumstatus =3D=3D XAE_IP_UD=
P_CSUM_VALIDATED) {

total: 2 errors, 0 warnings, 2 checks, 55 lines checked

FYR: https://www.kernel.org/doc/html/v4.10/process/coding-style.html

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1b7a653c1f4e..a74ac8fe8ea8 100644
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
> +                                               "Dropping oversized RX fr=
ame (len=3D%u,
> tailroom=3D%u)\n",
> +                                               length, skb_tailroom(skb)=
);
> +                               dev_kfree_skb(skb);
> +                               skb =3D NULL;
> +                       }else{
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
> +                                               csumstatus =3D=3D XAE_IP_=
UDP_CSUM_VALIDATED) {
> +                                               skb->ip_summed =3D CHECKS=
UM_UNNECESSARY;
> +                                       }
> +                               } else if (lp->features & XAE_FEATURE_PAR=
TIAL_RX_CSUM)
> {
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


