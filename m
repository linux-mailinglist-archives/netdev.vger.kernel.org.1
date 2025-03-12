Return-Path: <netdev+bounces-174241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF5A5DF6D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2443ADC7F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DD24CED6;
	Wed, 12 Mar 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KyQMPyir"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77E189913;
	Wed, 12 Mar 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790954; cv=fail; b=tryGQyaU6apQKdopD6XrQEZui6g3dOpAOn4jSFYJ6+Mpi3CCi2RAUDIg8wgxto/f7x8ZmQLHBgIurYjPV48sCOynOFNcKTYJKzBSpUcbIJaIDx+gfuFlAR4SlPMc+SejEqe2Xt9UIDyPVKmOucQ1gM5R+JhZR5yi2YuIinm2gvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790954; c=relaxed/simple;
	bh=r/NXP0yg3j/ctVBDzZAI++F5U1RBHJQAP36eo9czcr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPqg+upO8RBqw3p98JgoPBb8PqmgIz8QZF1op91FCqbcIRnlzMJSnCWolNEKqJxwODjTNXmFnkjDg1Jf5gSMXq3WimydLjYyseOfBocMvvMFuejOpPC98peHWW3Wf/S/LQ2MlTTpwFv2kvsnscs5UkfiDDzLNsgLd4KYTradHTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KyQMPyir; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7nBfdl/y3nfG+Wiwl3BWQQgDQ24o5cN56ceb0cfeYX72WEWxT9ESmjOmt76/Oy/LuPBjO5kJUVZBjmOa//6K+GljRsjQnVsXU9Q3ZJh6eV9ZQdvjZTVa1kCYFhkH/7AdbUPtDB5o7InFgupcaUAR1pihOZuhiR8xinefplVgarDJe7y84KWp5EslwkDvqfIvI/WoEfYGKP04MFe0pa6BhYpM3Dm7hVyuw5f3qno+5dWCs/oUMpgHSQcecO7TfGM73CZ0zgeOYiwiBp7e1cuUaYtNyZbw5JMshCBQHmjllIDfR24iTda2eNTAiIQ1KbIGQPgUEJD+egn5T4yuchOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFLwzgPnOAtksnNAv/coL8TgqdzzHUdNP86OdYE/tHg=;
 b=DB2//lbsiqgzvudiDppB8Cyu95fJtIqSQmxeA/xV+nXVKq6wkvD673xfAXizD1M8rd0T5L7AHB4brygeCRadakEqTKaBazdmU+RvSnKKVg002Fp4q0jVT+qJzwzF2bvclN4p9uGb1icf6qFW7426L5sg3HDfGZSOfFsDHVf8BQZNofabs5KDJUyEbs6P+i9VqNKezP+yt0ePhNf8lPXFbYmk7c4lQoayLySYRttY9+AhAUQFhy+R5ZBSw5zFKQHJKj14i2Tg8iGWe51A4S0R+hM1cFCPPsaGaaXgk7eWPMGGGtWjIj7AEZHZk8XKSXJZGRpFKhNr54dEhTWHHbP7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFLwzgPnOAtksnNAv/coL8TgqdzzHUdNP86OdYE/tHg=;
 b=KyQMPyirIkk99o8gLpcJhe3Kt86GNsGZcaoIuleSpQnrAaP95QDFbKMF3NQAe5f7rLuh1gVrJKc7CWxMHlN2C2vN5dWrrxHP++VmYLkKbGUAoBYc9a6qoDpUK2QfbwFZhwmYm8D3LcNnJuyBdxNGMftQQacsYPidQbAm98c1ztw=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:49:05 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:49:05 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Topic: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Index: AQHbkzTKsOmRASZLiU2r8QNuR6Yh/7NvfgWAgAANigCAAAd4EA==
Date: Wed, 12 Mar 2025 14:49:05 +0000
Message-ID:
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
In-Reply-To: <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b76a2f4e-5660-4616-9599-a611a46fb4a4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T14:40:37Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|SA1PR12MB7271:EE_
x-ms-office365-filtering-correlation-id: a4263404-7a87-4d2a-e934-08dd6175096a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zn8PJA8imbVSLchESGxL34X5RcXFY64EeiShAcWrlRJKvyArYgXbsE9U7Ds7?=
 =?us-ascii?Q?phIByvqd6DLH3c8TSZpOEL3RTPYQBlmeVN8cYrBygRlPiYK0q4gFNyguA0zz?=
 =?us-ascii?Q?sAzH5cs74jnwRzl8qMw6N6uMEJWltBeM+M9Rsj8aSCdQ8iDqvt4EpCsO4/zM?=
 =?us-ascii?Q?yJS+yJVuG3DgpQ4q7GgCsR219c3edw1oI6KF15/XqtHiu9Az8m1IL3hbmd2X?=
 =?us-ascii?Q?yNirjlkn4HP7KAtNuaOONFjer0y9knHAwDEdQxTMizV6HedvOLFXXoOx5BXq?=
 =?us-ascii?Q?IV1ZuCtsnzyh/jrl3gdFQngZ9MhRyWeRxD+cwIBe8w/VV8smvBy6faAVFQ4S?=
 =?us-ascii?Q?GdjJp0OpCl54LxNChjwLxODLQXhIyztKLZV0SqQLyn5QdLcsL3DtbhtCN39+?=
 =?us-ascii?Q?NVhdz1nuWV41sDx0OgocHhXZgjhIPIUL43w18of4a5sPzxh11RswrRZJXDiQ?=
 =?us-ascii?Q?BdDK5vvJo0+pR+uFH/cyCqctcPJT8PQwyKJ9Ubu0ZJnUNuPLOEMI0UthTHlK?=
 =?us-ascii?Q?DeTvxdLv4COCQkY4wiSEfyNOO8nmSI753ZvnRETLclQ96KgkQLP7M8eIKXC+?=
 =?us-ascii?Q?WIIwI2AA/ixT4MElYykf0ZpqX0h8xJ+R0LYS1omxr8j7598PMkz6RjRdYe+S?=
 =?us-ascii?Q?uX8B3hCvB+E6ozCy2suzSNu10qbe0g1kM/OvDr2MQo6yyQOju1Gjwn7lGDjV?=
 =?us-ascii?Q?d8FPDcsbCsfLvQ8qKQahyeDu98NktqdCSuZJVpBcl19kC8BPezFimFV+JZHR?=
 =?us-ascii?Q?/+nWKdskm6+RnTQkbHQXRcnlFyaj/tAG6iXcSGEuZY22Id+2fgkVdA83l9zF?=
 =?us-ascii?Q?nGt8gz3z1yBLwlSEal/ED6pHVb+s3PCuRl3xPlBgtU4bImt7yMaNtMq0Yj83?=
 =?us-ascii?Q?IiBnOe5CTJK6Wqy+dzbstDkyhW23HdP8WsX3fuFyvBAdUMxBrYpmrNVBmO2i?=
 =?us-ascii?Q?AWG55rQ+hmCee0fxfGaeJ3bOF4V20K4mF/2Q5a3+yz6lBobbmueLKQsazKFW?=
 =?us-ascii?Q?RmEtfK2njVr31b2uhreL3BaUG4Eeb898sxg78D8LBIyrCa4a41EdTUVDamnw?=
 =?us-ascii?Q?v3P6hrV7h22u60/ax306A3sxlwUlKVmMQmlnGD5rZdQiePxY8/QuMse38NdR?=
 =?us-ascii?Q?6k5dK46WbuXILDi+cF6Ef8m/akgxdNLKKEnwkYlwpZ3Xb/Pg/dMNIK+B34Xy?=
 =?us-ascii?Q?FaVvlfav9LAWpRpUBVYZKJQf5qdtq2tZ88VyIhFifnbvzgFBQO24yeweAJlF?=
 =?us-ascii?Q?ZEtmuTpwEXPDDqmtTS07guwk/Ky9ScJEc9hhiTs9i2RJ3KGV0e+ORAdY2L/T?=
 =?us-ascii?Q?upuCb7aji9U2bXQdwFd/jJ4/touU+7zNcLyumhFGxN6jAgZbAHfaNVLHe87l?=
 =?us-ascii?Q?Cxsy4yxi8tVLZyN96fB9gDCtMlsv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UGwey9KTopFzBNYEuBj92qUx/ogZ+skgoRa15h4I8E2+99WF7y+kIX04jVPO?=
 =?us-ascii?Q?2lj7BSxP4pT7CX4vV4LAV18vSU6Y4XPuuubcrC4A4c+g5Ep0i6KrLoojES8a?=
 =?us-ascii?Q?Z8WqupGWbMBzbiS0B6vGI9B72/VzxiACpIf8IiTqYTvbf4Mi3Obqyd8AA4rE?=
 =?us-ascii?Q?8gGIYOJRp4nZj3JmCrV/k5Pb3R0ylVqZxOv5K54lW/thCiwhFTl+m6F1A8UE?=
 =?us-ascii?Q?VSar3ci66K5+M6Zgx2juM7b0sQ8bJybN8ITN0akVjbuTUfrYhnJCnZLYUvfQ?=
 =?us-ascii?Q?SpBZo9cgHAkfr9Z8Hi430JxFlFnVLMdbKaBz0C7dS38I8rDZXT506McSf/J4?=
 =?us-ascii?Q?2uyAiH50L6K2ErRteUPyo1s5okBMU5kBy0vg3ckt3oWxG1gjj095m7JGgF3E?=
 =?us-ascii?Q?qvbbiS1cmIS1pWqjXlhcgjwIj9JzCSyadoNz0P00um8evYVQdHhOyoeCnYcP?=
 =?us-ascii?Q?qf2Ne5Q8Ladzp4yagJyLwuZFxhpTXZDqg42cFE3p2fkycKF/J9pKqh/QmlU2?=
 =?us-ascii?Q?t1ytznpVTJIJkJh+CmkiPi6n5ymO0+tfVqwTgq59jaX7BhPwraRalr3dvqRi?=
 =?us-ascii?Q?d43l62BNdRk2CBvqyd6g9858UNP4Dx/zpWs1YM29Mxcp+NyTe+d3CR01UrcQ?=
 =?us-ascii?Q?9sc5bkIw0Avh+dLN1+sBzE7BFL2LNT/1rzDNP2d2ShWgFNZgYQcawCkDEp7w?=
 =?us-ascii?Q?9Xr8ua0ULBIESuozDxLTT6zfUT9vL0JT9iKz72EjR3QAnXgx8lY2rUw2qbFb?=
 =?us-ascii?Q?76AX3WqK28PKpcNff34MukznzpFD1CTxkTROz1tB12IXaKYbgiZDw4anUJVo?=
 =?us-ascii?Q?7EsvYxxYuFv+fkZq1/0B5UyFHkezH7jfWFb4de/c8TR5wnKNLWMVWx8P4Lnl?=
 =?us-ascii?Q?0j1CmlK16w8kNg4VZAhFvMgUjvgDF4Qv6myF6QazPmdP2OH4WSw98epEdS9I?=
 =?us-ascii?Q?jcj9wd/iXAA7oNvKNuW4U/kWFepVZfzXBDzk7qV5fbejgbzvbhwtMxKcH6ga?=
 =?us-ascii?Q?0Bb6tbDo5MlAGDm1nzkEfOI1Yw7+8Jy7NqI/lmL6jeuDqu89GBOhV1I0aQs3?=
 =?us-ascii?Q?evuSNU3t+8pvrz6AAIafZrBsaS1uWaAoRAXGt/fHYp6aeWRgITQmL1doacAi?=
 =?us-ascii?Q?AOMrgM7I/0rnKXk/R9ArPYWc7liVy92RIbATu2G0I9AE1qx7S9lh25PCoheI?=
 =?us-ascii?Q?6zF3KQfUCy9pub6u0bCkY9/BX36ND0Zs4AkyWFOfdzo9d8QXJCEaitF4Y4bD?=
 =?us-ascii?Q?7CAhjF7bOyS7WX2rSUZcF+m0I7kQtotPnReJsf/r8Gljbqn24lCLlEDh0Okl?=
 =?us-ascii?Q?ohSivEjLJFFes4Ef18RDfwnziC5RobbP6gotqUdbPiGp31hsAPMFDyJHl3/M?=
 =?us-ascii?Q?vC71wftWfDDeKgY5vGovpfmD36IvrjXCxQa/F103jUAbhpL/i6vR5mSdQHle?=
 =?us-ascii?Q?uHFocn2RrEM92t+SFM6//R6uVXbQ3hIbqKvnt4UXFGR6glR6BAMrdBv2GeW6?=
 =?us-ascii?Q?uaZzrVi9Ahumfw5tnjT3OZnqV/qv12UjVuzIDN+y+cmhUJa0B3t+LhEdVej8?=
 =?us-ascii?Q?sjjLUvT6VOEHQ4Hzxls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4263404-7a87-4d2a-e934-08dd6175096a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:49:05.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyQ7nKY6XVQMxJMP8a453FCzKyJius+ReItNnfWzOul1qs9Qt9+aiYdGTZeIxpMP6u01FpuisSPU2UJ3WRAn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, March 12, 2025 7:44 PM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> Simek, Michal <michal.simek@amd.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Hari=
ni
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500ba=
se-X only
> configuration.
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > +   /* AXI 1G/2.5G ethernet IP has following synthesis options:
> > > +    * 1) SGMII/1000base-X only.
> > > +    * 2) 2500base-X only.
> > > +    * 3) Dynamically switching between (1) and (2), and is not
> > > +    * implemented in driver.
> > > +    */
> > > +
> > > +   if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_2_5G)
> >
> > How can we tell if the synthesis allows 3)?
> >
> > Don't we have a backwards compatibility issue here? Maybe there are
> > systems which have been synthesised with 3), but are currently limited
> > to 1) due to the driver. If you don't differentiate between 2 and 3,
> > such systems are going to swap to 2) and regress.
>
> We've discussed this before... but because the author doesn't post regula=
rly enough,
> it's not suprising that context keeps getting lost.
>
> Here's the discussion from 20th February 2025 on a patch series that I co=
mmented
> on on 19th November 2024.
>
> https://lore.kernel.org/r/BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3
> PR12MB6571.namprd12.prod.outlook.com
>
> Suraj Gupta - you _must_ be more responsive so that reviewers can keep th=
e
> context of previous discussions in their heads to avoid going over the sa=
me points
> time and time again. If you can't do that (and it's a good idea anyway) t=
hen you need
> to supplement the commit descriptions with the salient points from the pr=
evious
> patch series discussion to remind reviewers of the appropriate context.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks Russell, sure I'll add salient points from previous discussions if i=
t becomes old (won't try to delay at first).
Andrew - Keeping previous discussion short, identification of (3) depends o=
n how user implements switching logic in FPGA (external GT or RTL logic). A=
XI 1G/2.5G IP provides only static speed selections and there is no standar=
d register to communicate that to software.

