Return-Path: <netdev+bounces-259708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEucM6tbmGkNGwMAu9opvQ
	(envelope-from <netdev+bounces-259708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:03:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008F167A94
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60389302E422
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67A345753;
	Fri, 20 Feb 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MjCwX4sT"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D98344DA4;
	Fri, 20 Feb 2026 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592595; cv=fail; b=uNxjd/urZm44Zvs+8kw6xajRgGchH3dOA0D2E96I8/PHlcNoHHanMc2pQ3NhncqubaC4EkJZK9X+TlwGYkzi74cudK8Mo7dQnsC+oiqFGSxwm0VbtzmXt/vPCSmhN5dSKr8waHC+azlEdZZa5flVr4D4q3Ztv9LDxHGFOQW4/D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592595; c=relaxed/simple;
	bh=wwDsxqdWXz1ep0oMmR4cy46fbcQ+cWSwMlAJsger7jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BopiuZeXvT/WiInekBcWfxc+BG3eAUwZ+waXyFKPjb7+Imc0X+U19OZmRMG9SxKGQMIeb9/BJmffvIooVhBlJ7NFoTk4bGWFJ3sjOqO4qJATYUYofkLl7HsclWrPJw3O4YCdIsKxEzqjIG4z8feJk7/JCQJP2I3Y9urf0C4CTTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MjCwX4sT; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb1Ak02Caw757a3w185k8r3vs1lhuwtVzWnn4qXgl/oUavamTZFnOGRgmhyDeRTOVUa68cc97i1JLqCINeFp49bXCT+YcSXpt4xaF2MRhdqiGtw3yZssfqGCMtnFPmEujWMx1Sdrf432nSFGykxiYsmPAqrJRHsHFg7i4FB/OWfIpu4sKft82RIKDeal2w59AIoNezB4pE/w+fU5HC7Cvj/SYL/dr+XkFsknO0T2aU87Ta5iyU4czejXGtPUitc2n/QqU5W2dYu6veUWu80Y77ZnRhTeYe1ejpMQKt9gkzRtM2avpQkW8NGU1DGDaez+kgYvTuB4uQtOa99IO5Oe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NyVlJbsKXRS6vEbxMGCqrADKx1luxmeeg/l4VoEu5Y=;
 b=UXScleQZw/Zk8o9jOt4hTOqGtyKLOrcsWuO2Cc1XsMZ6fwOc5rA5/z+n5B8Q65g5KrT2OByKxChnNWVVGDAAyhqXSSyz++XzwUXvKw95r0g5pTgC71Gwiz+CqrPyrYxW3bdVEUQ+9/ukpYTJppb/ttpMYWrNkvS8sPnNokK4eEVQ++XGfS7PXZMOWJWN+frQlPyRmKe1I2GgyUBeyPKGDlJ4rVbsnoxkSw18+hNPcGCZDk3ctDazZlgoAgmaT2Qp3+TNLuztm3rKIg+xN5AJbjNSv4QyjYHbP8mHO90YOGR9GOTCcA6XuMHguKt9yyKJOP8C+tH2aIh2u6h+X7Csuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NyVlJbsKXRS6vEbxMGCqrADKx1luxmeeg/l4VoEu5Y=;
 b=MjCwX4sTU2/6+V4mvzP76629LEG6UTSe9Otfe2aQMpySH3UrxaT4HbkipewVyUZ8IS27+OgA9J2Q5fZeYlFnF2TmNH9iMP6iFxCIy36LpWf8SNRH8SUzsOLoyy2jBHCwzWvUN6uIzSWLWozXe+LfHdbk79QXtdu/sKtHcTF9sbI=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 13:03:08 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:03:08 +0000
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
Subject: RE: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet MAC
 support
Thread-Topic: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet MAC
 support
Thread-Index: AQHcoWOT1raipV66w020xwAhQlA46bWKPd0AgAFQ5sA=
Date: Fri, 20 Feb 2026 13:03:08 +0000
Message-ID:
 <SN7PR12MB814702B7C9A28577A94FE79C9368A@SN7PR12MB8147.namprd12.prod.outlook.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-2-srinivas.neeli@amd.com>
 <76c811a7-d081-4238-bf6a-0226e867560a@lunn.ch>
In-Reply-To: <76c811a7-d081-4238-bf6a-0226e867560a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-20T12:59:38.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8147:EE_|CH2PR12MB4087:EE_
x-ms-office365-filtering-correlation-id: 2c382756-1bbd-481e-2f7e-08de708064c1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xRhqLT0d2DqBaKQZrD50zBdgHJ8YDQQ0hMzgtafGIqvzDtmZ7IMPaNcOjdYE?=
 =?us-ascii?Q?v8P1i5/gJX6UshWKO46/+A/jTttnPbYkXJZzfiBffE4TskuCBehm5At9+mMZ?=
 =?us-ascii?Q?lgc7ZkP1B0Kmuq/zhSB8YZJheu32ZEqNH6GkEtjtB7cWb2uG/Eo1Et1vuE5i?=
 =?us-ascii?Q?+OUu65BWSpFvmqucDRHTNoeGR9DtoM5qxV217xFgZa9l2Ht5D/Kvy1l7fFYY?=
 =?us-ascii?Q?U3HWdfjdc25hDffUtMQTdD4u0NzG6vtmjk4aP8rN5Oig+BhYYLhTlK8QBfkV?=
 =?us-ascii?Q?1gJfGRNVTUyDNjdXhgw6Bt+ZwwXUqECdpmHzI2faHkMOmASMnF4+GjODRwpF?=
 =?us-ascii?Q?KXGlFbAXJW+PUgyljXH2GCLkxKhHEuiAgSrkiQZeiQ8zEd4GXJAImDK32yrZ?=
 =?us-ascii?Q?l/s00PasIqSOE6MJVV18uUmqBKQWzjhwv6JJ8XcoNBR/v4ufn3HqQ3qhV9QD?=
 =?us-ascii?Q?RysM7DOxRXYytlj+9gJ58TKYW6UvZnanTftSxgMZqwlSZZOclszGwgEuunIc?=
 =?us-ascii?Q?lKTy2Mtt5YwB4EfcgqWrT0CFGOt17wfOAenboESB+Sf0ydtHr39iU2UuvfO2?=
 =?us-ascii?Q?qn6uTUcRsZri9VkfdP+9er3y5YtlT+WmCEr9iHCubIGYvW1ipJ2TF5p4a+TK?=
 =?us-ascii?Q?2vJr+cf2DZRTqghTlJsQWk3MXfsuIPXxTQaQHsPmm7s7tiT8yLt9qC64YXu7?=
 =?us-ascii?Q?zVL1SE5PqZfcy7WF/fPEhymRYTewY6oNdE62sbUhg5vqOXg7D7zlKqbeYCdH?=
 =?us-ascii?Q?ea+iUChWKonNpZoJQxAuedF34FeM6CQJBh5WuZ2EQtfOqzKO9MyKzpfUzifD?=
 =?us-ascii?Q?nzEi6sy3aCo4Sl2a81e5tHIoEuM3YBbN7zezoNnpjotLoiWar3IYjtsQ0Q1K?=
 =?us-ascii?Q?L9CLx1xzcJrCJnxh4dRtQIxkg6BrSdbqzbntfsFLn0Q/KJBAvSMNdFnL17/6?=
 =?us-ascii?Q?jx5Kt20txwaJ29oLR1qcEEHKjjNpY4+mMCpEbaHL9MOeSeMPGCO7iDuid+eY?=
 =?us-ascii?Q?Bm9sWS2QsJGiIc5Vwq6PgiamLrFleSHrNON3ufik56qzy6l0b+9ikOh8Vpgm?=
 =?us-ascii?Q?uIhQBob43nL6+5dKcrpGDWWF5dhNTR3div/9HsuGG1GweoP9nUhIXuXMvz/0?=
 =?us-ascii?Q?srqigkvjlKE7WrvfTW8RMWqJhDAEPPIin6iy5VaD+D+bLMaR/jpHAR7W7z6U?=
 =?us-ascii?Q?vMGLxf/fsNtqvLR4SXZxxr1xCHIqOsIW0nE4vGNJv0r62SzSR6B+1+MvVn/2?=
 =?us-ascii?Q?brKOvWWWMS/F6sUV0V9u/TkBZdPJCPIrNLHU/EqZcfVotpdxEFo0NKghzhhf?=
 =?us-ascii?Q?1YfyU+0N/Xd4eA7X+3ezQbXTrvtL+5S0LJDjPMhuVGo++qQVlz+OmaiMdA/o?=
 =?us-ascii?Q?6c3zWY98p7qEfTau7sxsDhI4TbmjY5I8aUuhBxK/12DMVI0jpMxYaDtQqym9?=
 =?us-ascii?Q?P8n99QrW7J0WE8UvywP9QFEjdQ4Jlvq/mGTMZC/i1BwznOzSoNuDpdfgyowr?=
 =?us-ascii?Q?qNKhBDQ7lf81n4W/6bRiBEBHLGe/ob6/l1vv2MYBsnQH7sTu7xp9c6R0WJfX?=
 =?us-ascii?Q?X/slQM0IyhuQDRldXdy3EA151Ow5Mcabozg6YHNuHkQiZsVU9MSqApckCOrX?=
 =?us-ascii?Q?qKUs7E4qa+J+sAIWwV5OqX0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q+8O80yD50doBGa+r5TYnvgI2t2apLPEhlW2cdnB79q+Y/yWQ9oA8ONDfkyX?=
 =?us-ascii?Q?DZsWPEHuOWjtlqxaBiyiB+kmzz2zxGoztmbFtIOg6vzn1NP8z3XVAhlhTY0S?=
 =?us-ascii?Q?w/An+qexnV54LQkBv22tw3DtZ+qEjYvR999uxUtGTVpUjVZf2X9I3mqwNYcN?=
 =?us-ascii?Q?gXri9YR7Z6ZooE1jFws08fNbGg/0O21bPLncRp7beU7SvyGPYaHD8AzuFbnN?=
 =?us-ascii?Q?nonmvc1nKJVmrUFCzGb1KLjyKGApWoyKUbvOUiLWWr8jOj89Yw6oj/r6Vy4A?=
 =?us-ascii?Q?hGgGEkum7VLojowMpTwmZV31mA+uMeZC2qqYbabVW5zKw+FQcBaXl1pYoiO0?=
 =?us-ascii?Q?KeizVP5Wj/IWLRkQdPYp8vk26OppBcnuNGrEGpVssHdfXfyloSj0cCGtddRT?=
 =?us-ascii?Q?fAGQGFO1t/zPgQlqvxgdAuX1OoL81M6KGypS9dIWARSkHy0ae4F9UbIYyxbf?=
 =?us-ascii?Q?Tn3OCkOtcI7XLADY2/bmQMHlwBly2VfVRHYBeV/tXHRTljtoLYy62csSAHi0?=
 =?us-ascii?Q?fWQzuL2b3oKuXftAxf5MDi0hK39zSY1Sefmm4Sw6jKifljkzC6mw8IxXd6RI?=
 =?us-ascii?Q?QsfkyNbTB8GdzVggwqDfIHFE9CBAnhWxdMxrEnPGcDu93KUZg3AOalsvuIf/?=
 =?us-ascii?Q?ANH9Wn0nNQrlaX02uyCHZH+Cy88q/yW62Y+yc9JeTBh+3p+2sEwTw3zrolFu?=
 =?us-ascii?Q?tZs74RvuTB6pF1sMQlNQeLu3Y/q6umr87nj2pmTzNND8x1+b7njidShr7LAk?=
 =?us-ascii?Q?KMEBYjZH5fuB5Q60wqWQVEu24iIxit43cKMkHXSbyRGFLH1MWFWtr4Rbeq/0?=
 =?us-ascii?Q?Iy5fbFYAZbc0q5TzpLaLcwB5uF6vMmixWHS4yMKC7SPFXhf1jpSsThEtb2oE?=
 =?us-ascii?Q?7LNh85n/ypLmuTmm6AB5pi2XwD4vBFCTN/tk5v2N55dd22q0PdcULsVgwIcx?=
 =?us-ascii?Q?Zkgy44Oi/qBbugxiEls88+eM2VCFGQ9sWFDtjCz42V3tIU+XXjmRDy2ygeN2?=
 =?us-ascii?Q?JIHHMVl6ep+qMSdd0HECkIf007wi+26H79geTbqJVWcYt+99HLniHAgHimDn?=
 =?us-ascii?Q?t0m5Bov5EQJn5cgoE0kxbySRNKUEBjrVicb9/8z6eyX7rIXCcCWKmEI77Sje?=
 =?us-ascii?Q?Hq+FoUAona5vhrD9jj7qVmv21Teh/IThL77U3K5XEZrbxwIggRRb5LvE5Swh?=
 =?us-ascii?Q?ExOVQcf9uVs9OIngMS8SrG4rTQNBNDKmxSRjLghM73ZHdukH+hHdknYmi+dj?=
 =?us-ascii?Q?NbXrItFaIqrIsfXf/KJb/2vxcTrMCafaAV8GdmBeejHq7AXNmu2K4WRGKJ9C?=
 =?us-ascii?Q?PJS8xTIzO0WwAt4iy3fjiz3gqon2PQFt5knPr/xQCM/SSe94yYmuNQC1jsRM?=
 =?us-ascii?Q?1X6Q7YlejNSUfJZEtb/HVba8Ho+y0SxsAv8BTXHGKQfnpsl51W2K1diCtBIV?=
 =?us-ascii?Q?A7GPHrT2FCbKwFWAkz+n5wvUuK+VtcNI8trP4GcWecZSnICP2G68LaK29/H3?=
 =?us-ascii?Q?deTvQIfFzSNtfcniEd9pjZ/n/qD7yqKWBUUHoUEDTV+hDU0AX0/PZpEv1pbp?=
 =?us-ascii?Q?+Fe44YgFQUdxMtzRcvk3hPZHW0vAHKvmmDjj3A1AcQzkVoEugIemETejHM0R?=
 =?us-ascii?Q?tnrpXmgaDpWiNcmpxGQbP9O1N2jVZmfHwV/w2m5TuQGiVmifg23UuVncN6Px?=
 =?us-ascii?Q?JU2+OPo4XEfrDHLLZxftkpVOtDiMA4YsNgcGAqwVfBm4xQPO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c382756-1bbd-481e-2f7e-08de708064c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 13:03:08.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoF01iM6L1IDHg3eaYRdGtsugyOp+nUK+vaPPSc/u6u6OCvBRGgehmZcHr2XcBpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259708-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4008F167A94
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, February 19, 2026 10:24 PM
> To: Neeli, Srinivas <srinivas.neeli@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Simek,
> Michal <michal.simek@amd.com>; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; richardcochran@gmail.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet
> MAC support
>
> > +examples:
> > +  - |
> > +    tsn_ip: tsn@80040000 {
> > +        compatible =3D "xlnx,tsn-endpoint-ethernet-mac-3.0";
> > +        reg =3D <0x80040000 0x40000>;
> > +        clocks =3D <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>,
> <&misc_clk_1>, <&misc_clk_3>, <&misc_clk_0>;
> > +        clock-names =3D "gtx", "gtx90", "host_rxfifo", "host_txfifo", =
"ref", "s_axi";
> > +        dmas =3D <&axi_mcdma_0 0>, <&axi_mcdma_0 1>, <&axi_mcdma_0 2>,
> <&axi_mcdma_0 3>,
> > +               <&axi_mcdma_0 4>, <&axi_mcdma_0 5>, <&axi_mcdma_0 6>,
> <&axi_mcdma_0 7>,
> > +               <&axi_mcdma_0 16>, <&axi_mcdma_0 17>, <&axi_mcdma_0 18>=
,
> <&axi_mcdma_0 19>,
> > +               <&axi_mcdma_0 20>, <&axi_mcdma_0 21>, <&axi_mcdma_0 22>=
,
> <&axi_mcdma_0 23>;
> > +        dma-names =3D
> "tx_chan0","tx_chan1","tx_chan2","tx_chan3","tx_chan4","tx_chan5","tx_ch
> an6",
> > +
> "tx_chan7","rx_chan0","rx_chan1","rx_chan2","rx_chan3","rx_chan4","rx_ch
> an5",
> > +                    "rx_chan6","rx_chan7";
> > +        xlnx,num-priorities =3D <8>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0x80040000 0x40000>;
> > +        xlnx,tsn-tx-config =3D <&tsn_tx_config>;
> > +        tsn_tx_config: tx-queues-config {
> > +            queue0 {
> > +                xlnx,dma-channel-num =3D <0x5>;
> > +            };
> > +            queue1 {
> > +                 xlnx,dma-channel-num =3D <0x4>;
> > +            };
> > +            queue2 {
> > +                 xlnx,dma-channel-num =3D <0x3>;
> > +            };
> > +            queue3 {
> > +                 xlnx,dma-channel-num =3D <0x2>;
> > +            };
> > +            queue4 {
> > +                 xlnx,dma-channel-num =3D <0x1>;
> > +            };
> > +            queue5 {
> > +                 xlnx,dma-channel-num =3D <0x0>;
> > +            };
> > +        };
> > +        // MAC 1 Node
> > +        mac1: ethernet-mac@0 {
> > +            reg =3D <0x0 0x14000>;
> > +            phy-mode =3D "rgmii-id";
> > +            phy-handle =3D <&phy0>;
> > +            mdio {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            phy0: ethernet-phy@0 {
> > +                device_type =3D "ethernet-phy";
> > +                reg =3D <0>;
> > +            };
> > +            };
>
> Two } at the same level means your indentation is broken.
>
I will address in next series.

> So each MAC has an MDIO node?
>
Yes, in this hardware configuration each external Ethernet MAC instance own=
s its own MDIO bus used to manage its directly connected PHY.

> > +        };
> > +
> > +        // MAC 2 Node
> > +        mac2: ethernet-mac@20000 {
> > +            reg =3D <0x20000 0x14000>;
> > +            phy-mode =3D "rgmii-id";
> > +            phy-handle =3D <&phy1>;
> > +            mdio {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            phy1: ethernet-phy@1 {
> > +                device_type =3D "ethernet-phy";
> > +                reg =3D <1>;
> > +            };
> > +            };
> > +        };
> > +
> > +        // Endpoint Node
> > +        ep_mac: ep-mac@16000 {
> > +            reg =3D <0x16000 0xa000>;
> > +        };
>
> Except the Endpoint MAC does not have MDIO?  Or does it have an MDIO bus,
> and you have simply not listed it?
The endpoint MAC does not connect to an external PHY and therefore does not=
 expose an MDIO bus.
It is an internal endpoint, so no MDIO node is required.

>
> > +
> > +        // Switch Node
> > +        tsn_switch: switch@38000 {
> > +            reg =3D <0x38000 0x8000>;
> > +
> > +            ethernet-ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +                    ethernet =3D <&ep_mac>;
> > +                };
>
> So this looks like a DSA switch.
>
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +                    ethernet =3D <&mac1>;
>
> If you look at Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> you see this node is derives from ethernet-switch-port.yaml, and that der=
ives
> from ethernet-controller.yaml. All the MAC properties you have above actu=
ally
> belong here.
>
>       Andrew

We referred to ethernet-switch-port.yaml while implementing the switch node=
. Our intention is to implement the switch using a pure switchdev framework=
 in a future patch series.
Please let us know your suggestions.

Thanks
Neeli Srinivas

