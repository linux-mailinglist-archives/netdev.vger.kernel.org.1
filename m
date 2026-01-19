Return-Path: <netdev+bounces-250990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33986D39FCD
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D47630022D0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD5332906;
	Mon, 19 Jan 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pU2MUoP5";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pU2MUoP5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020114.outbound.protection.outlook.com [52.101.84.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8D3321A7;
	Mon, 19 Jan 2026 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.114
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807840; cv=fail; b=X2k0k4+thy/hDEm1x94SeCSOnxXXFYqwgZWbvFriAq8G6Xhz8l+IxTfTl/T2jtnU5cwzuiQsdXJQORqLzDEXmMuTv1V231fhMiozH2+g6QCYBDQgF2Vtf+TcAsIkMSnvtSYXDPhtsxR5Rb9EWqMF62JiwJECkHIxB/d4astM2hs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807840; c=relaxed/simple;
	bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAwPSTbkacxszmz1jJQz7DZ6zk4yPX421FkVQnBVLPIJLl8sbvgf9COZUJ8u2y0b2ax0pIBpciS290ThkPLUxiiNxx3BCdQ9xrhVaII1lu+l0YWcb6AHkOgeEp+CksnvEPVOFDICrG1aTidLYJ1JSbGYqoiE0r6ILHqAeHhhsTM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pU2MUoP5; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pU2MUoP5; arc=fail smtp.client-ip=52.101.84.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WvRIAEGM8H7zGhgdpWD+aFCTUQzN2y3jGScolr0DYA5qluPCMG5b2H8zNdG5R4cRZFyDE6pMsbK7U9bcEjrDfWc7346P62aRQyqjh3Yq2AtCLos41hU73HxO+96iHEwwde8uGFAMA+fcB44YkJAZ0f52BrkzJpVdwWYPuiCHICPjx0lEH1+o7j2nm2Sg1dJyTbkQ572h7X3b1hESvMfS7OSTw0tfIfUeFfG71ElZcXLJAlD4WX2BnTJUqUkv356Thv0PyPcZvH+vunHYrHVK4c9bW3Yhqkswwic3ohEcO9fEW/IHHJqaAfZB3gMco/CUNrfVM4s9pfRaOdD4yDS+IQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
 b=PYDK67zzblC5ujCtSh0M81dvOxWwC1beXfQcIBrdf+ZRm4y8vbzTJcREVNPcZlQoxzz3BopaF+JzFEVrVQ/lVuqJZdjh2+2FUj0lHlAtfe/hbDgnApdvO9YmsuQILGZU3VaL6WVEGaeP0yZuTjhPEv1FJO+Eo9yXvPctD5vwexIywFKY3seZnJu1xpG+KN/qW3Rov/jYS935MNNRM2+YYipqNXJErUggZymyzoeiD0V22uDY61lgWDfhuCjvCe1jELJrMdn0lNjaCUnAxR2hcX6mjPRXPi9BUYdbJVpKEHkyJRKrOZXY7bEEXzYrHMBOVMv8b6fNzJ0msrCbhg7oig==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
 b=pU2MUoP5xkkEg37tvwMGyuHESfPLWPisWU5fVFV2pj6om+InKjuX1gkUW7aBbBDWLuIDBB5zf06Zn31LrXuUI9AU79wRc6219Ltjdb58IYyPu8xgXWKsyLv4KJHLdwLQaqQRwyNzmldgw2bLa8NiGLd2lIOfaVGePcF7h1qzhR0=
Received: from DB9PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:10:1da::32)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 07:30:35 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::fc) by DB9PR05CA0027.outlook.office365.com
 (2603:10a6:10:1da::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 07:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 07:30:34 +0000
Received: from emails-411462-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-103.eu-west-1.compute.internal [10.20.5.103])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 9501F801C9;
	Mon, 19 Jan 2026 07:30:34 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768807834; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
 b=HIUp8VAgHoAk8zKdDIv87lpnxee11hq4U5hFPoaNVpcW5COA18RC+HsUwbdjYBN2RifAI
 f4WfmZ5AfsOIjXxYOY+vivn7/YdwxGHcU9DqUgpZLroyIQdnlrzK4veLf5osbAnwlONZyoS
 WWCDJbyelfg/dDmXbav0YGlrevYR3S8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768807834;
 b=GWE206jR3CMjoKwkplE8sSin5Ya4BEaeMWNuIVIb/gzHrzKc7VOmw+FD2/mBeVtRCIokL
 puURbS1lbp3reHygNGmfDCEmd/FsegC2rG/ZZykAv3MLWMbomTRmcHiukPrx/JoS1lt7Yoe
 DYB6kwmCCiNxDf3Il08WMX9ICf7As3M=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lykbiLUM1MJdm/zvFuuThqf8q3LqWVzX5tT2tDyNkWfMJp6QHHtT8sBSxTCjsd61KH3mWm0gYfO4KZzsOEXSDfSrhR0I4nErSjQRzRInpdEoNPjX46R/+tMbd7EPt2OA7Bwd4kjsDTORwdZo8pNc/k3WoXzjnndnBUoDBlFXNMp1CQqTiiAor0Gi5ZQOf+wJs9XO02dYbUwQGyxkuqfIhwQj+Ea/hu2fVb7WpgSXE9CGxqHsRpMPKviMt3lfNfyZtgJCSM+OociA659M9aBL5XIVi0+L1dp7lRQko6VvdzXVMa5MWqp7Oc+Lah7hP1PI+jvx37wFAjZ7JaPS1issGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
 b=Xaqlvo74DsjXeuKcHcuLLJgcDi6ueP3PoD3hH2Iz7tw9WH1lXOTFpJPgSheeEJWmoSMLqkgRVvQ7X2Lj9KLURc2lD6DlYj3xvxQ1J9ZLryfQ0M3L39+NGQ9tBwjSXCWKUeQy0WCmRjDRtxHzizZvC9lOsDvslBRup2CgU2HSuFEa7tp0VWcOXv7xGDYrPWwI8Q031AXE5C6wvdJ250nCb1Ee3EJlZoNezPRgv/6pex4W7lIWoOrMW9PSfR8pv87WNnXjz35/m9AzxoYapEllL5guRve7ylWlg1kKikr6rW0n+91kzjA1z/oVMAkCWQVI6AN2Y8oEnvTfkW6V5V38Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7UVwwYNTs46sWBl0nn+Flvr5jbPEdaHrq6nmja3nzk=;
 b=pU2MUoP5xkkEg37tvwMGyuHESfPLWPisWU5fVFV2pj6om+InKjuX1gkUW7aBbBDWLuIDBB5zf06Zn31LrXuUI9AU79wRc6219Ltjdb58IYyPu8xgXWKsyLv4KJHLdwLQaqQRwyNzmldgw2bLa8NiGLd2lIOfaVGePcF7h1qzhR0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 07:30:20 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 07:30:20 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Thread-Topic: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Thread-Index: AQHciIPWrdEyCfl1vkmXqYoNtgVQkbVYFmwAgAEDegA=
Date: Mon, 19 Jan 2026 07:30:20 +0000
Message-ID: <a8ea329c-42b9-4adc-80ad-2f602a5fbf0c@solid-run.com>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
 <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
 <e04e8bec-a7c5-4e2d-bdd8-fdf79c29deba@lunn.ch>
In-Reply-To: <e04e8bec-a7c5-4e2d-bdd8-fdf79c29deba@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7234:EE_|DB3PEPF0000885E:EE_|PAXPR04MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2673ef-0d8e-498c-cad8-08de572ca264
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UllxOEJXTmxHVjFjZldlaHRFRGtjUk1wSlBlM1dzMFk0MUJrMHlhRmRPcUV1?=
 =?utf-8?B?MDJjNTdmSUZiL0FVTmd1bE9rRGhlUVZYdTZuMHVMdFlMN2h6Nk82d3pJMnJE?=
 =?utf-8?B?SnZnYWdzTWlUaWZOSWVQYTZxWlVWM0pEYmpEWDBSbDlUNkYzN2E3eGpKeXB3?=
 =?utf-8?B?OUl2SDYyclpBWWJRdDA1NjhyNks3R1NIQXhtNS9od3NDajNGNHY0MCtkU0dv?=
 =?utf-8?B?VUVnNnZOb3ZlTlRNMkYvNEdEaWdLVVRBei9nbC9YamVjQ2paL0pvSXdrcFlC?=
 =?utf-8?B?RUpOS2dpRDEwUXNCWE1hRkxCdjRWaGlPMW1KQUpib04ydC85WlluV1lxUHo2?=
 =?utf-8?B?MVE3OFQrMlh2bWlOMUFtZmxrT3FYM3JkS1V3WGU5Q1Z2Mk9QS25Qc2ZDMXBu?=
 =?utf-8?B?bEh0MXJlY2ZXcUs4Z3JZV0pEd25DaGdwaVplWVZWbGtjZ09DUEI1OTBwM2VK?=
 =?utf-8?B?Z2JtTkZETEM2akZ3T0ZSTTdpYlQwZEdHZ1NVYlc4NGpJUDg3L1orV2VuUlEx?=
 =?utf-8?B?QTNXVFRlL01TTGxoS3h6dUFWWHRUdVRaWm9UaEsrcGRhT216OGNpWlQyRzQ0?=
 =?utf-8?B?UlNwSG9EdVgzTTQxeVNqQnEwaVpVS1c5UlhNUldwK2w5UytlK1FuK0ZFSk8y?=
 =?utf-8?B?QVcwdmVQZGd4d3p4RU9sNzRKc2J3ZlNXUS9GTzV2WEFzajcwVHZCUnJSNUpl?=
 =?utf-8?B?Q0lOWHZxUmE3M0pKYml4NjNNcHRobmZlbHhrQ2JNTnNrNW1NV1lLVlJiMUky?=
 =?utf-8?B?ZTVYMXZFSXZWYUtuUWMxWjJ3azBVUXRTbmdHL3ltdzVHUUdBTmZ0RGkwKzFt?=
 =?utf-8?B?WVhRbi9KTHZtemdmMFFodVkyTW1pSFRvTXBUREd2UFBVWGJkMFU1d0lqaldx?=
 =?utf-8?B?d2NOM1VROW5aM0NEc05aZmhqR01aR3ZxNlQ3UTBXWkNaZFhPVCtQNjEyWjhi?=
 =?utf-8?B?ZmYrL2c4cVZRUVlCZ3FUbUM4SzVZZ0JJdVJJNUdaUG43dEZNTlNpcnFtdEUv?=
 =?utf-8?B?Y1FZeENYNStNRk9HT3FuWkx0UEJueWd6eGVybUVNY3FKLytJRDI1Y3NCWmRI?=
 =?utf-8?B?NEpic0U3Y0VQZmhRZjRUcFNZU0Q4Y29xc2hXMGNFWHBRUmQyZkxZZ3ArbFpK?=
 =?utf-8?B?WGdqN3NCUHpld2c1WlhUR3dPRktkb2N2TXgxMEVwWlc4VStjblptN2UxMjQz?=
 =?utf-8?B?TnVnZm45Y01XNVJIYktNbldmVi9JZi9ZMFUraFliQjkwa0lxMXMxTjFDY2Y1?=
 =?utf-8?B?OXNwenQvb3NuTmpYVERpRktSMktySUd6dHV2a1BnM2tBaUdEUHBrT2ozZjVI?=
 =?utf-8?B?R1ZQOXp3d0ZaRy9hVEdtOEJ4bXRlWmhQSzdWeCs0Yi9lcG9jeTJJODd4a085?=
 =?utf-8?B?V2MxOXd6ejJmeU5FeFd3T0FZMlU5OS9TbGZpMWEwTEdsZEw2bk5PM3dtWGRO?=
 =?utf-8?B?R1U4eHF4QVZscDYxRk91OFRSZm5EeVJmcURudTJYemcxNEFFODVxaUdlSjhi?=
 =?utf-8?B?V2ZwYUlhNk1pSElDT3U2YnAveFFxRDZIaTdXYTk2M1FYczZWRmtmendmWnFV?=
 =?utf-8?B?RmtkdTRKN3BMZE0ydU8rNFlUUVpPN2hoYlpWaTVtVHdYMC84VXJsUmxLYWZx?=
 =?utf-8?B?dFBNOTViWkNCUUJSeEptd2tJOFRrdHdvblk3R200eVBvdk9NL1BPNlFycWFk?=
 =?utf-8?B?bC96RUFzRFladXYrVktzTHRUMWE1ZGNjNEtLRHhUbm1wS0daRm9TVDJXNXhj?=
 =?utf-8?B?aWp0cUhCMU1EMVkwT0UxRkRJZGVVaURrdkczY1NVUnZRMHd5WFZmemRDejM4?=
 =?utf-8?B?ZHNsdUxaMnNYd1F2TmVnSVV6OVliNHFZbU5Sek9EYUdwa01uL3BHRlJ5dDJ6?=
 =?utf-8?B?dVZCWXArWTRjZ2lTcC80Wmw4REpnb3hIc3E5Ym1jdGRkbHU3NkhnSW9IajVL?=
 =?utf-8?B?L2dYZHJINDZaSkxTeU9qN0gyZzRuTndvOWd4TGI0T0V6K2NxNWRKeVVuRnFZ?=
 =?utf-8?B?SFRDcW1VaGI4WUF0V2JOQ1RKSlhoWFNOamkwakxjRUZ2dDdndU92cEI2Yksw?=
 =?utf-8?B?SzVteDJ4TWRTY0JWVVA3M1FWZlFqTUpONEZrdlVmaS8yTWE3dGVLbDhjR29h?=
 =?utf-8?B?REhwWkhIWlkrTGVSZkJNTVNNUXVjeHBsQkRNaTc0Q0VDMTVFR05aQTI2VE1Y?=
 =?utf-8?Q?20VzA3jz24d1WZNIwo4ZyBs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <9741690242FFF64EB02628AB69119DE1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 5db8018dfd9142f0b1c0bda369722556:solidrun,office365_emails,sent,inline:237624808a164ab62f6bfc382de528ea
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	351a610d-2892-45f2-9093-08de572c99cd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|7416014|376014|14060799003|1800799024|36860700013|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXpWWEpVaFBEVGNBWiswNWdGTldMbHBSUkFUWktydzZPUndUeFppM3BFdW42?=
 =?utf-8?B?cDZSbEoxbGt4ek5OdjZSeVFGczFPWmlBVjhNRzFtdVdrWDJPL1ZjaVNoTmdU?=
 =?utf-8?B?di84SGc2dXJqdzJiQWoxaXZvT1YwL1NFd281Vk9rRW5jYUNOaFdKWEdrMHZE?=
 =?utf-8?B?TUJiYXhoZm5iSUxtR25VS2VJNDhHODRML1Z5VGU2S1VHSjJBNlJON1QvbVUy?=
 =?utf-8?B?OGNEU2lqNTJkb0ZQd0lISEtsUUxmaTZWV24rWGZlM2Vxek10S2VIYzdKQlhp?=
 =?utf-8?B?M1ljdzJKUWFWZ1JLNDBsb1I4dGMrTjEySForckJOdmtmNDNGNUdGMWw1cHlo?=
 =?utf-8?B?SnhDcWxYeklpNG1weG9jdEZEcGlDNEdlVUlKUkcrZ3RrOXBaYnp4Vmxvck5D?=
 =?utf-8?B?UFhhck5Dc3dEWmNqSGtKTFlpVjdNQW1nU2dCenlQdi9hS1RURGcrMjdkSVFj?=
 =?utf-8?B?RmNrc0VxZ3Frd0JXQ0VpZTBVV3FFNE4yZmI2R2I0NDQ5Y05JQ0V5MzRwM1dp?=
 =?utf-8?B?UGh1b1B1YVVZbE9CWGtiU2hDN21OY1FORmp4dzd3TU1DNWhNclZQaExJbTdH?=
 =?utf-8?B?Y0k4eHlVNlpSSUh5VkI0ZkJ3UVNqTGIvTjlOS3dxSnMyS0xzbWVEb2FGUXFt?=
 =?utf-8?B?U2IwRExFeVdFV01xVElFM3NGb3lmN0ZsOFh5amFlalVHeFZKaG9Ec1BuRXV2?=
 =?utf-8?B?dytJTzZZaG1YclJQRVkvUGNIYlU0WXF1RWt2ZGJIbE92dmhlK2w1SkpXMzVo?=
 =?utf-8?B?WE1ab3ExYWlDbnF4RkVVdjJuNHV6ejBIRFZ0Q0R3OTQyUjlXeVowdkF6QzRI?=
 =?utf-8?B?VGh1ZWFlSEFKdVg3NDkzbTBTY0VZMzcrTDR3YVhCZ1FnSzYxSXliTHhrNWdq?=
 =?utf-8?B?NGRXSFhYWWl1b3JFNzUwYXJaa25yVUVjbUJIVVB4L2VlVThtNXpxWno0eWRp?=
 =?utf-8?B?eE1OZnk0YjZxc2JkUEJqYzM3c28yMU9ORm1zV1RMVmRLUjVwd1N6Vkg1cVNB?=
 =?utf-8?B?bUsyS0dOYnBJUDBtcXVYTXBXNFk5YjRsL1VqTDlhUElPeUdNZHAyZ3hkOFdn?=
 =?utf-8?B?UThtZDJ3TzBVZ0l1aUE5RW1PbVhyK2dpQmU1R3cyYk95bEloUjQ1NEZadmpB?=
 =?utf-8?B?aEVXQWJDZCs2Y1NFdjhqeUV2ZVNiL2tQZmFuQ1g2Q21nM3hvUnA3dzZzUlAw?=
 =?utf-8?B?NjhxUlR5VlBDYXZid1NnUjQwVGF1SDIwZTJ5dU0wVUFGMTdZMzg0d1BYemRV?=
 =?utf-8?B?Z3RjN2MyNFNxVWVLL3RxN0ZqVFMyVmFnRjFEWXhITUwyVTFjclRUb2ZPbEwz?=
 =?utf-8?B?V0lNNW5GRDNVd3ZNWUFCWDNHZzFzdGQ5WDNvTzdkdHlxeWx3Z2hlQmtPbmRy?=
 =?utf-8?B?cVhYQk1aUmI0VnRpMU5UREx1NXRCYUEyTTlKb2ZMWHZ4eWhUTkJxb3RDSU5Q?=
 =?utf-8?B?clZ2UEVnWkNySjRseVRYVEd6ZDllZWxybG0rTGI0VXlXbmJPOHBRV2tUM2li?=
 =?utf-8?B?eUd0SHVnUFAyRzQ2c1ptOVkwUUdRT3lMakdOTWZKMFNkQ1BwM09ocy83WDNU?=
 =?utf-8?B?cFN4WVRDeUlheHNGT2tMektONVpDbHYwSTF5SkQzQWU5T3V2UnZKSGl2eURP?=
 =?utf-8?B?cE95elRxNnordHhGYUlQWERiVmZmODhibTJNS2Zjem9Dai9maSt0YS9UUm9o?=
 =?utf-8?B?UWlzYTlIWktkVEt2WUtvaHRzNi85anBYSVBVc1hheFQ3TVpCUC8zeEZVR3BU?=
 =?utf-8?B?TmV5ajhTMXpHTDNWVXpNalZZSXJsaEhLY0JQa01GQ2QvSDh3WG5XK0ZKU2p3?=
 =?utf-8?B?a3h0RjlaeHBDZ1JQMnRDTzRFUW1tYmpSZ1JsZ2N3ZDFFYjR3ck81Y0dDamox?=
 =?utf-8?B?bVNGZTBjUGhqc1hmZFlQUVNXT3RuWVJoUDk3Zys0WnEybk1oR2s0UTltRVo5?=
 =?utf-8?B?a3ljTEtpYlg4cUltWVVmZmFxOGI0aTlhaDcwemxwV0x5WG4zZ04yNWd1ZDlZ?=
 =?utf-8?B?TlNjbXNkOTVCcms4VVNnWWNPNEd4UVIwVnRkbWZMR3dETmRzM0Z6SWcvUGUz?=
 =?utf-8?B?WlUxQ3RWTWpYMGhaY2dCMzVtdUpUKzRNSEZ1T2haWkN1UmlzWnRYZ2ZqYUZ2?=
 =?utf-8?B?a1hubmFFZjdvM3NrTDhTMG5LV3dDUGx2Ry95L1BNTkYzRjVwdDdnelNoUmp1?=
 =?utf-8?B?VFZzYndNbllmbFdQTHhNYmcvbHRNTE0rT3VoaVBBS01DZ1ZDamNmRCtzTTdT?=
 =?utf-8?B?VW5EVjJNUHlZWjR6YjJOd2pmYklBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(7416014)(376014)(14060799003)(1800799024)(36860700013)(18082099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 07:30:34.7440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2673ef-0d8e-498c-cad8-08de572ca264
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285

T24gMTgvMDEvMjAyNiAxODowMSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFN1biwgSmFuIDE4
LCAyMDI2IGF0IDA0OjA3OjM4UE0gKzAyMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gVGhlIGV4
dGVuZGVkIGNvbXBsaWFuY2UgY29kZSB2YWx1ZSBTRkY4MDI0X0VDQ18xMDBHQkFTRV9FUjRfMjVH
QkFTRV9FUg0KPj4gKDB4MykgbWVhbnMgZWl0aGVyIDQtbGFuZSAxMDBHIG9yIHNpbmdsZSBsYW5l
IDI1Ry4NCj4gSXMgdGhlcmUgYSB3YXkgdG8gdGVsbCB0aGVtIGFwYXJ0Pw0KVGhlIHBoeXNpY2Fs
IGNvbm5lY3RvcnMgYXJlIGRpZmZlcmVudCwgc28gd2UgY2FuIGtub3cgZnJvbSB0aGUNCmRldmlj
ZS10cmVlIGNvbXBhdGlibGUgc3RyaW5nLg0KDQpGb3Igbm93IHNmcCBkcml2ZXIgZG9lcyBub3Qg
c3VwcG9ydCBxc2ZwLg0KDQo+DQo+IElmIGl0IGlzIGEgUVNGUCwgaXQgbWVhbnMgNC1sYW5lIDEw
MEc/DQpUaGlzIGlzIG15IHN1c3BpY2lvbiwgYnV0IEkgaGF2ZSBub3QgcGFyc2VkIHJlYWwtd29y
bGQgcXNmcCBlZXByb21zLg0KPiBZb3UgY2FuIGhvd2V2ZXIgc3BsaXQgaXQgaW50bw0KPiA0eCAy
NUdCQVNFX0VSLCBpZiB0aGUgTUFDIHN1cHBvcnRzIHBvcnQgc3BpdHRpbmc/IElmIGl0IGlzIGFu
IFNGUCwgaXQNCj4gbXVzdCBtZWFuIDI1R0JBU0VfRVIgYmVjYXVzZSB0aGUgU0ZQIG9ubHkgc3Vw
cG9ydHMgYSBzaW5nbGUgbGFuZT8NCkRvZXMgaXQ/DQpJIHRob3VnaHQgU1IsIEVSIGFuZCBMUiBp
bmRpY2F0ZSBkaXN0YW5jZSBub3QgaG9zdCBpbnRlcmZhY2UgbGFuZSBjb3VudC4NCg0KRWl0aGVy
IHdheSBpZiB5b3UgaGF2ZSBhIFFTRlAgbW9kdWxlLCB0aGVyZSBpcyBhIHNpbmdsZSBtb2R1bGUg
d2l0aCBhIHNpbmdsZQ0KZWVwcm9tIG9uIGEgc2luZ2xlIGNvbm5lY3RvciBvZiA0IGxhbmVzLg0K
DQpXaGVuIHlvdSBoYXZlIFNGUCBtb2R1bGUsIHRoZXJlIGlzIGEgbW9kdWxlIC8gZWVwcm9tIGZv
ciBlYWNoIGxhbmUuDQoNCj4NCj4+IFNldCAyNTAwMGJhc2VMUl9GdWxsIG1vZGUgc3VwcG9ydGVk
IGluIGFkZGl0aW9uIHRvIHRoZSBhbHJlYWR5IHNldA0KPj4gMTAwMDAwYmFzZUxSNF9FUjRfRnVs
bCwgYW5kIGhhbmRsZSBpdCBpbiBzZnBfc2VsZWN0X2ludGVyZmFjZS4NCj4+DQo+PiBUaGlzIGZp
eGVzIGRldGVjdGlvbiBvZiAyNUcgY2FwYWJpbGl0eSBmb3IgdHdvIFNGUCBmaWJlciBtb2R1bGVz
Og0KPj4NCj4+IC0gR2lnYUxpZ2h0IEdTUy1TUE8yNTAtTFJUDQo+PiAtIEZTIFNGUC0yNUcyMy1C
WDIwLUkNCj4gQXJlIHRoZXNlIFNGUHMgb3IgUVNGUHM/DQoNClNGUC4NCg0KPg0KPj4gU2lnbmVk
LW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+PiAtLS0NCj4+ICAg
ZHJpdmVycy9uZXQvcGh5L3NmcC1idXMuYyB8IDQgKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BoeS9zZnAtYnVzLmMgYi9kcml2ZXJzL25ldC9waHkvc2ZwLWJ1cy5jDQo+PiBpbmRl
eCBiOTQ1ZDc1OTY2ZDUuLjJjYWEwZTBjNGVjOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0
L3BoeS9zZnAtYnVzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9zZnAtYnVzLmMNCj4+IEBA
IC0yNDcsNiArMjQ3LDcgQEAgc3RhdGljIHZvaWQgc2ZwX21vZHVsZV9wYXJzZV9zdXBwb3J0KHN0
cnVjdCBzZnBfYnVzICpidXMsDQo+PiAgIAljYXNlIFNGRjgwMjRfRUNDXzEwMEdCQVNFX0xSNF8y
NUdCQVNFX0xSOg0KPj4gICAJY2FzZSBTRkY4MDI0X0VDQ18xMDBHQkFTRV9FUjRfMjVHQkFTRV9F
UjoNCj4+ICAgCQlwaHlsaW5rX3NldChtb2RlcywgMTAwMDAwYmFzZUxSNF9FUjRfRnVsbCk7DQo+
PiArCQlwaHlsaW5rX3NldChtb2RlcywgMjUwMDBiYXNlTFJfRnVsbCk7DQo+IEdpdmVuIHRoZSBx
dWVzdGlvbiBhYm92ZSwgaSdtIHdvbmRlcmluZyBpZiBpdCBpcyBhcyBzaW1wbGUgYXMgdGhpcywg
b3INCj4gd2UgbmVlZCB0byBsb29rIGF0IHRoZSB0eXBlIG9mIFNGUD8NCkkgZG9uJ3QgdGhpbmsg
d2UgbmVlZCB0byB3b3JyeSBhYm91dCBRU0ZQIGF0IHRoaXMgdGltZS4NCg==


