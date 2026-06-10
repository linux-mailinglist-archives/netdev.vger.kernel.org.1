Return-Path: <netdev+bounces-297592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S9rpAdU5KWqPSgMAu9opvQ
	(envelope-from <netdev+bounces-297592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E666682F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=m4t523XT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006C730364B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86B3EB116;
	Wed, 10 Jun 2026 10:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BB352008
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:16:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086594; cv=fail; b=IUEudCdP1wimlZMpdMu4jG4afiNBBiHHC5fciIlDy5QcH9PFyRjRad0oQts8bqrrXHIo9mOyNPbuw/f9zhr8y5XncRe14S8/1I5qCiKGRj4zwoXTl7kWpxNPwki5TOw2VRY3bPgjf8WWxboMrf5ynS/DkhFBuWzjFXelVqiyGNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086594; c=relaxed/simple;
	bh=bDg7Pxbd3hQBx3FUtgb0R3e0DowNs2i28BPPt2rMvQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3DET2CaQ/mK0RrPExPV+0BhM6+Fyg04Wi1CJuY9Pa07w1wN3X/dZcriJ0hXb2H09buYmQQpqDTcbM6widqIbrflReJHiFRDkbiIIStVB5gfOOlZDR1g+M1ydGzn27mqJpeWyQNJolYlyIydIiG+Pgs4/wskfneskjl0cbVyCvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m4t523XT; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ4G9vATFdC301PFsA9Dpbo39k5YnLHel98g/PbW18FNXHxNdtIOX4NuqFlMnY1u/HGVEkCiziBHEvKJLhhxPaVq8HJJTlB7AqPFFt2M0djppzev6LRgIln5p+Zo3aZ/HWYzcuF6bKuNPnsv2pxq/B1QqA7Rx5+UsrXLmeh1HBeYt+2D7EK+pdCthtjjhiUGzJC7anmFkAkUtrwQrvp0248WZn+ttoKB06oFxTQGSqtnderWDQWFr4ThWjlyRXk0uFH7N8ar0UA9JqC9gAAVEk4t48vJuT/z52eClUqE/PFPsJnUVS8fvrLWUeB2BHHGk8V4EFOikBiZUdRATiwvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDg7Pxbd3hQBx3FUtgb0R3e0DowNs2i28BPPt2rMvQs=;
 b=V7rvC89BNnP2/GNjUltTwZ6w1FSKd0RLF+M7qBOwxZERo8y+E+fpkoMAS+AGik4dZCxtCdVjWk+BFb/WfgusB34SyscbNDizsWeHlBBXLAaWQ54f7t4JoV+n+ORL6B8g7Bz+kwO6Q4e2OwjAcV+lGwv4QvKkF21vG82RDpbPQxOySsDS7g3LwrzU4uHiFoulPRoSWfsgrdOFTipNn79t/D8Qar1zJUtYTROAAzjwpVVnHvYG6+4pPf2Rcbg8WmuwuteM57f6MPyXVom8hpe2copg7k+pZZC8LRb8rSNvU93oAoEtlPuEZ7AvtZlZdl7yJ9u/oxYD2AJMGitBbYeAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDg7Pxbd3hQBx3FUtgb0R3e0DowNs2i28BPPt2rMvQs=;
 b=m4t523XTrATw0qTjT99Jr8jz0cfeuYxV3NNCKKRSRwiAZ2e51EhuVD2beC6ROtlfVullrk/+bRcQdmtcUJ5PTz90hn+uVPT9W+0vUCNP+rY5IL2o7siX1m44Ov/e07E/IIZMi9MnT5PUYAy8CaTbZPbeDDpiOK6OeZou0/I+rwKXTpghnSyAsAId6k7ndUnZ51ql3NjSZ4M7eK6zbtsQHb/A31OzDTSBI6e9qeoTKRKuoOCq3Xh8dV9Mppj5PlOZP5vMwpN0kUu1/Y6CkOvAb4pPpNE29f+tADG4XauiSPhH1Pn+Z4l4YreEiqBmMOSW3k9G0yO6Vr3tOScKbxJHRw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:16:27 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:16:27 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 7/9] net: dsa: netc: add VLAN filter table and
 egress treatment management
Thread-Topic: [PATCH v4 net-next 7/9] net: dsa: netc: add VLAN filter table
 and egress treatment management
Thread-Index: AQHc97/tblOgZxqPwEWW2gTQUcTgULY3IsWAgAByHXA=
Date: Wed, 10 Jun 2026 10:16:27 +0000
Message-ID:
 <DU2PR04MB8629AE134703D9355FA002CF881A2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260609032955.2066089-8-wei.fang@oss.nxp.com>
 <20260610032800.508131F00899@smtp.kernel.org>
In-Reply-To: <20260610032800.508131F00899@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AS8PR04MB8293:EE_
x-ms-office365-filtering-correlation-id: 90f6ba53-cdb7-476c-cc03-08dec6d95589
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|366016|376014|56012099006|11063799006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 oqUE3xhwDsSx+BZhtvIlgLWduC07W2ROiH/U7EikL424YaNJfum49e5L8d7rjrPQFbRugLJluWkVl7eYgw0pH1JclHMRYktdJih1j5hMBWjW8jaeTWsVFSTIfZMrk3eJ8ePcMupq84Ir6WyN0Dj4apT9Qq4N6pUCqS+rYCys1xU29k8K7YLv5cYnplFyKfBL2fJJ6LKRwWSIPnwbTxXT6JBJFlJL8lwDqLz3S77hER5NNn2QvwInOaFeQ2mkgEqUHUMPOpDctLf+9WoSq/NLxShw1f8WMKJUk1ysSsY9oIfag5anEVsszkHbyR1e1IhTkKMdq1ehpw0XvCnXRe3vOAwaCFtMSzuD5fF7M5zK4wJrYpXT8YOvZx+nEQvASQ7xlAeibwota9RylZkhir5ALt1VMiPOReiO1MU9ohUyuat/ezmPaL488Vx3i9lQVo/QiGeexnrXOajDYa1O22tW4EH1lLGxccHMlwdO40Qh+fwBpwzJ12EA8CRkGHKvCEx9Lc/CKyK+q77K63yr10XRyWnaHp6Q1D3eWPqn9u6xXGF7FlCoMc5cICCOvJtLgPZKUo9mo2/4jQyqPRvph0JlI9XsktrlW5LdA0J9HOVE/kYBBPOtEmM/GpaAFzIiwukoeN+Qyyx2TpWk14reryypF3c3dWF2Rj4VsC9BBqyfqkQzmjatm502ld4k7yd+2S4WIo9wvhP5jJN8nK+Ad3GOeTIlyL+wHt6pps5oe2rz+pUPvAIHNMlN3ICOaOCVF1rT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW8wMHZ2UWZxajZkOUEyclR1M3VVeWN4MVZmemM2bVZrdmRaUlFaSVFQMFVP?=
 =?utf-8?B?d1pieXdKT1piNTB6NjBDanNrQ2hSWVRnSW5HUnI2RWlaWFVCRHpxYVd0L0o0?=
 =?utf-8?B?UjRJZDlaZmdXemVjbXpxcWl4bS9OVjNwblFVWWdIcWVTOTU5VitoS0twYmNK?=
 =?utf-8?B?TjFJYUxsODVyeC9VTG5HMWYyY0VrcWl2bGx3aGZVdHJtNlRyYmdjM0k1VnNC?=
 =?utf-8?B?MUVpWnltZjBUek1VVzFTRWVLTHhGMURTMGpaSjF6RG1hNUVQMTF4YnBlZXF3?=
 =?utf-8?B?bXNIWWszSUc5R21RRVZIUUFnZURHS0lYNXNZT3VnaTY0Wmc1WGsraGl6MUxE?=
 =?utf-8?B?aGNpRzgyaHJCZUZ3VDBhT2hFOWtuaGNCZ3pHOWhGa0xyTXNtdzZYN3hPL2Jw?=
 =?utf-8?B?aUtuemxIdzk3YWZ3UEVCK3lkQjFpSW1pUnQ0cVBxYlRCWm9CK3o5d05BNnlH?=
 =?utf-8?B?Q2Z5Qmt0RUM2MVFleXYxdFJvb1UrNmtBLzNIQWxlZ2h2TUxGQXpQVEVPa1lP?=
 =?utf-8?B?WmpSZ0IxYkdCRXZ0cjA4d2txcHpKUkpmTllVaUFyTDM0MWxQK0N6V0dSRExy?=
 =?utf-8?B?cDJnYXM1Q2xHd2dGdnNHdWp5MnE0UWYzSVZxVEgwOTN1ajNlQ0hIZ0p2Qkcw?=
 =?utf-8?B?OFYrWk1DT0FocWI2YkxZamVYTjI3MW5UNHc4SFVGOHM4dnpxeTE5ak0vbm5p?=
 =?utf-8?B?TmlmbEdUeXVpRVd1MWd3UnNwZ2VHNExjclJCWDFyREZzL21nUFFlbnJHMUpD?=
 =?utf-8?B?bFJYN040bENmT0Z3NC91a2Z2YmNnSGljUTh3Z04vemE1M3JlZjVseHpRYjVI?=
 =?utf-8?B?REJnU3lWUTdFYmdWTUpiVlh5eXk1alNwSWlraXhXeUJqTXFsT21tODU3L2lk?=
 =?utf-8?B?RmpEY1lkSUJSNlRnYTlXQnd3aTd1NGwxK2FlYlZiRzFnakRpMzFIczNIc1d2?=
 =?utf-8?B?cjM2L29nenJKR1R6QTRqUUtySUhxU3RteWl1S1A5eE9HRm45L3c1ZmJTelNP?=
 =?utf-8?B?bFdhMGVKU3o3eEZaUC85ODNKTDV6TjlGeGdHSTBuOHVrcS9RdzhQVWRSa2RO?=
 =?utf-8?B?WjRCVVVBd3BGNm9MQSttUjVzbG5JVzRvaWkva3dsWThza1RDMUpvUTF6OVpZ?=
 =?utf-8?B?SlNmSEFRanNDbFcrdjB0UEVIOWowcmhpN24wMWJtSGFleit2UFlISVJjTW9w?=
 =?utf-8?B?bkNuKzRNZ0RleFhRYjk4MUpiekpQRXVwTVNFaWg3cmNxcVphcllGY3hialZu?=
 =?utf-8?B?dFIzNnBSQkUrMzJ3Um5vTmlzamZnRmFvVldObEsvS1RBaDJvaGdXZHd6YVA5?=
 =?utf-8?B?SmNPS1dKYVFUTlFZeGQvVjBxd1JFNE45V1E2d2tXRFpMQ1I3b0RQTHFRd1du?=
 =?utf-8?B?K1ZzU2Y2YXVhZHk5aFlPcmdMQ3g1RFlrSUlUZld1ejJiQ3NDWlVqUEVoa1Nx?=
 =?utf-8?B?dmhkTUhENUpsclVacVRVclV6aXRTSzUrenNZYVJNRnh4OXV2ZlFBVHkwWFBX?=
 =?utf-8?B?VEdPakoxcjlRMTEwbHBRYkVNalJGaC9FNE9RVlJtSG5zbndUT1FzUnFPK3V3?=
 =?utf-8?B?TmR4eGhOYTNtZ3lJNFFtZXY5czFxL01NTVhTbXJBdVUwUElINnZLa1VNSTdv?=
 =?utf-8?B?aElvUGpYOXdLUzh4SkhPa1lPMWRCZDc4TnRiZ1NIUVNJMmpTS2trc3pjVS9k?=
 =?utf-8?B?K1RyZHZQR0U3ZklTbXRZRFlHQU5YYWhTSnhJeXJGbmYydWxoSXBVcWszRmxp?=
 =?utf-8?B?ZFpjaURTUlhGWktvZHpkTWhrdW5PMGVoSWRydU5Jd3Q1c0xSRzZJZEZnZVVj?=
 =?utf-8?B?OFk4cWJ0aXlxekJZSUk2ZHZ5ZmxnTXZPWGlXUThMeUFKZXhTbHJjNDVNV0pN?=
 =?utf-8?B?Mi9TdVhxNHlPb1M3RXV5dGFxTEJ3ZXRkSFI4dHh0VTdhQXhYRy95TkFNbmdJ?=
 =?utf-8?B?S2E3d1NPV3hIY090K25ETktwU0VNOFRvNXFnU085SzRjWHdZWi9GMXFCMjht?=
 =?utf-8?B?M052UHBlS2hnZnd6a09lVWRtcU8rb2VaaHVNVTNFbkovblFMNno3VE81OE16?=
 =?utf-8?B?SXI2MnM4cDkrSFU4VXJTcURXZ1ZHWHRkVUZuTlhtQUVQTHZTM0h0NjZOTXg5?=
 =?utf-8?B?azFkWnJVTWQ0cDd1TjlKbG11amFHY3dERTlsSlRvcm9RWmxURStJN3E1TUdI?=
 =?utf-8?B?Q1dkTkxML0xUTktVVmkvb05OcTd3ZzZMTGdTZE95RHBnblVHRTkrVmx0N0tu?=
 =?utf-8?B?RlB3dG1BaHNUb2JmNVJPbEhTVXlEUTFTUFhYVkdJVkhMeHNRbVdnZVdZWllM?=
 =?utf-8?Q?B77yo0fex7gv96Ve8Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f6ba53-cdb7-476c-cc03-08dec6d95589
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:16:27.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqcM5opA/M5OcrAjY+vTpP9znt2QJYyNYH4M8XGd3I/1tyKVqQBZZ5le903GQ9E0xhP75YWhqvy5EWcGgXhxRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297592-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,DU2PR04MB8629.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60E666682F1

PiBjb21taXQgZGFmOGU2MzM4ZDg1NDgwZTgyYTAxYjcxNWJiNmQ0MjlmYWU0ODYyZA0KPiBBdXRo
b3I6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiANCj4gbmV0OiBkc2E6IG5ldGM6IGFk
ZCBWTEFOIGZpbHRlciB0YWJsZSBhbmQgZWdyZXNzIHRyZWF0bWVudCBtYW5hZ2VtZW50DQo+IA0K
PiBJbXBsZW1lbnQgdGhlIERTQSAucG9ydF92bGFuX2FkZCBhbmQgLnBvcnRfdmxhbl9kZWwgb3Bl
cmF0aW9ucyB0byBlbmFibGUNCj4gVkxBTi1hd2FyZSBicmlkZ2Ugb2ZmbG9hZGluZyBvbiB0aGUg
TkVUQyBzd2l0Y2guDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbmV0Yy9u
ZXRjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfbWFpbi5jDQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvZHNhL25ldGMvbmV0Y19tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC9kc2EvbmV0Yy9uZXRjX21haW4uYw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtMTAyNSw2
ICsxMDU0LDM4NSBAQCBzdGF0aWMgdm9pZCBuZXRjX3N3aXRjaF9nZXRfaXBfcmV2aXNpb24oc3Ry
dWN0DQo+IG5ldGNfc3dpdGNoICpwcml2KQ0KPiA+ICtzdGF0aWMgaW50IG5ldGNfcG9ydF91cGRh
dGVfdmxhbl9lZ3Jlc3NfcnVsZShzdHJ1Y3QgbmV0Y19wb3J0ICpucCwNCj4gPiArCQkJCQkgICAg
IHN0cnVjdCBuZXRjX3ZsYW5fZW50cnkgKmVudHJ5KQ0KPiA+ICt7DQo+ID4gKwlib29sIHVudGFn
Z2VkID0gISEoZW50cnktPnVudGFnZ2VkX3BvcnRfYml0bWFwICYgQklUKG5wLT5kcC0+aW5kZXgp
KTsNCj4gPiArCXUzMiBudW1fcG9ydHMgPSBuZXRjX251bV9hdmFpbGFibGVfcG9ydHMobnAtPnN3
aXRjaF9wcml2KTsNCj4gPiArCXUzMiBldHRfZWlkID0gbGUzMl90b19jcHUoZW50cnktPmNmZ2Uu
ZXRfZWlkKTsNCj4gPiArCXN0cnVjdCBuZXRjX3N3aXRjaCAqcHJpdiA9IG5wLT5zd2l0Y2hfcHJp
djsNCj4gPiArCXUzMiBlY3RfZWlkID0gTlRNUF9OVUxMX0VOVFJZX0lEOw0KPiA+ICsJaW50IGVy
cjsNCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gKwlpZiAoZW50cnktPmVjdF9naWQgIT0gTlRNUF9O
VUxMX0VOVFJZX0lEKQ0KPiA+ICsJCS8qIEVhY2ggRVRUIGVudHJ5IG1hcHMgdG8gYW4gRUNUIGVu
dHJ5IGlmIGVjdF9naWQgaXMgbm90IE5VTEwNCj4gPiArCQkgKiBlbnRyeSBJRC4gVGhlIG9mZnNl
dCBvZiB0aGUgRUNUIGVudHJ5IGNvcnJlc3BvbmRpbmcgdG8gdGhlDQo+ID4gKwkJICogcG9ydCBp
biB0aGUgZ3JvdXAgaXMgZXF1YWwgdG8gZXR0X29mZnNldC4NCj4gPiArCQkgKi8NCj4gPiArCQll
Y3RfZWlkID0gZW50cnktPmVjdF9naWQgKiBudW1fcG9ydHMgKyBucC0+ZXR0X29mZnNldDsNCj4g
PiArDQo+ID4gKwlldHRfZWlkICs9IG5wLT5ldHRfb2Zmc2V0Ow0KPiA+ICsJZXJyID0gbmV0Y191
cGRhdGVfZXR0X2VudHJ5KHByaXYsIHVudGFnZ2VkLCBldHRfZWlkLCBlY3RfZWlkKTsNCj4gPiAr
CWlmIChlcnIpIHsNCj4gPiArCQlkZXZfZXJyKHByaXYtPmRldiwNCj4gPiArCQkJIkZhaWxlZCB0
byB1cGRhdGUgVkxBTiAldSBlZ3Jlc3MgcnVsZSBvbiBwb3J0ICVkXG4iLA0KPiA+ICsJCQllbnRy
eS0+dmlkLCBucC0+ZHAtPmluZGV4KTsNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCWlmIChldHRfZWlkICE9IE5UTVBfTlVMTF9FTlRSWV9JRCkNCj4gPiArCQludG1w
X2VjdF91cGRhdGVfZW50cnkoJnByaXYtPm50bXAsIGVjdF9laWQpOw0KPiANCj4gW1NldmVyaXR5
OiBIaWdoXQ0KPiBTaG91bGQgdGhpcyBjaGVjayBlY3RfZWlkIGluc3RlYWQgb2YgZXR0X2VpZCBi
ZWZvcmUgdXBkYXRpbmcgdGhlIGNvdW50ZXINCj4gZW50cnk/DQo+IA0KPiBXaGVuIEVncmVzcyBD
b3VudGVyIFRhYmxlIChFQ1QpIGVudHJpZXMgYXJlIGV4aGF1c3RlZCwgZW50cnktPmVjdF9naWQg
d2lsbA0KPiBiZSBOVE1QX05VTExfRU5UUllfSUQgYW5kIGVjdF9laWQgd2lsbCBrZWVwIGl0cyBk
ZWZhdWx0IHZhbHVlIG9mDQo+IE5UTVBfTlVMTF9FTlRSWV9JRC4gQmVjYXVzZSBldHRfZWlkIHdh
cyBwcmV2aW91c2x5IGluY3JlbWVudGVkIGJ5DQo+IG5wLT5ldHRfb2Zmc2V0LCBpdCBpcyBndWFy
YW50ZWVkIHRvIGJlIG5vbi1udWxsIGhlcmUgZXZlbiBpZiBFQ1QgZW50cmllcw0KPiB3ZXJlIGV4
aGF1c3RlZC4NCj4gDQo+IEFzIGEgcmVzdWx0LCBudG1wX2VjdF91cGRhdGVfZW50cnkoKSBjb3Vs
ZCBiZSBleGVjdXRlZCB3aXRoDQo+IGVjdF9laWQgPSBOVE1QX05VTExfRU5UUllfSUQsIHdoaWNo
IHdvdWxkIHN1Ym1pdCBhbiBvdXQtb2YtYm91bmRzIGluZGV4DQo+IHVwZGF0ZSB0byB0aGUgc3dp
dGNoIGhhcmR3YXJlIGFuZCBjYXVzZSBhIGNvbW1hbmQgYnVzIGVycm9yLg0KPiANCg0KSSdtIHZl
cnkgc29ycnksIHRoaXMgd2FzIGEgc2lsbHkgbWlzdGFrZSwgYW5kIEkgZGlkbid0IG5vdGljZSBp
dCBzb29uZXIuDQoNCi0tDQpwdy1ib3Q6IGNyDQoNCg==

