Return-Path: <netdev+bounces-290963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ5mFtLuEGrtfgYAu9opvQ
	(envelope-from <netdev+bounces-290963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E005BBAA2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4818D300C0CC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC91E515;
	Sat, 23 May 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sxFmLNjj"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC453FCC;
	Sat, 23 May 2026 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494607; cv=fail; b=HU2VF4OQGD4z1WE/dMVqDvEcIQVNA0IGfdXVeNGiue9e/kjQ1lim3gvGZ0Pu2IRnHBVIRJa2xWyKWIwqT/kTMYagAc98+ybleVyaAt0TBSeas+j/CB+zbpmL4mHpdjAybLsl9ThNzuFjgVClok1pgHxeJgEmRkCVhRT4wkVSnJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494607; c=relaxed/simple;
	bh=hlwfq8ZeGFyusd2lgR9QoZZgtsuIgm+pASiUWgDCQP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mt9T1QNJOND/BahcrvXq5FHwMypWZTqaoIkAIp061qyTIAk6FKkcSHTKU3C+hHZrQxPfjLPGMdYaEqCxcj5IjU1Zkx4rwHOzw3oVvbOVEfG9LK8ct9pWzIXasEmZhutYdrkS2WrU6GZ5bYENORzulj4aVNcuqbS1nN++vmUkBm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sxFmLNjj; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgPb6Hgx7nNm8HTt9i65tXulWT18v8eUeKPwGWOYTdo1muZrjFsRW8q99KUG2kGXqN+UDSpgtBGAKm3kt+yGzQywTqgqtambcoOcw6PByoaoFOw6EjVnkynxQ7s8WOhGtugUZqiheHwbcHK6pd3o9uKd4jCTzGiTeYYzhmK2uWoVL9Q/euYcs95d3PRqZLbNjNC1gUHt+8LmbxwQW+v+MVJr09SVnPhxKxFDi6/sVjiUzXHFl689vQDJhTl4eizGc6Kyx/TAAujYirW3XHMq/JeE6rzjr8RH31Uwrab8MugDq1L/0QM9wWd7Hpv0h0uPxavUPDazrVOHY2VaIHBWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlwfq8ZeGFyusd2lgR9QoZZgtsuIgm+pASiUWgDCQP8=;
 b=CBKE0s9SoM4db/adgJHJvD3r2qrkdKJTc46YNV0nbpUV7wxKiKzb3bp6GHeJ3edqUoZyuLcOopOwEm7G/2KXv0znNx6+Q8wb7JyXm4af3UpUc66umzPh0mFZsLDfNk2NzQLuA+H4YPHasyjAtgEGyfYDRk9P9nrR0fJMaBHUTQ2UDLYUwOjeh42JhCqB/NzmPn5b6sjjLa+V4JRE0fHhlcNmfuJQyVAXU3s/c1sCykw+USpFfH5ADtUlYSqQe2/MjiGwXvGCtP+FB4bFIz5sclx9lH5xe1YRORbLpHTYOqOnj2Gz1bTGlUnxTGLUInXH490AkyJbPGnJRmmQRBFMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlwfq8ZeGFyusd2lgR9QoZZgtsuIgm+pASiUWgDCQP8=;
 b=sxFmLNjjxCAlWpCnRrqNVnDmXqE64TcFPE9fmWboZqAZ0qRNev1f3HevLxmvVYfjdmDN258jBK8i2cFuPjE89lS+Sks1eWT9jhTUJuvYY3RBDyXn6LZ4IavlXcyd9Yk5Xvkpgm80VWFl9lMoCW7V38eNAtcSU+nIsKDrWyiQROCZsJA+w41a9BxQ34uZdOBmTCUij6QyhJqjcHro4rqts5XAmpdmmDFzEqUXY2nQxkD4tsTMZjp026rMBZJLpkpCKzg3kWU3D/kjJTUwohDqEOZOE4fh1ddsVuW72A+R6gTyvCje7tUtOkV6u5YLrtS426MtoYG8f8nW77tyxuE9Tg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:03:20 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:03:19 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>
CC: <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vladimir.oltean@nxp.com>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<kuba@kernel.org>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v3 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
Thread-Topic: [PATCH net-next v3 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
Thread-Index: AQHc6OjdAYaceqPEnk64DdKDXsMC9bYavHDw
Date: Sat, 23 May 2026 00:03:19 +0000
Message-ID:
 <DM3PR11MB8736EE1457A55360080E664DEC0C2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SN7PR11MB7705:EE_
x-ms-office365-filtering-correlation-id: 3d33ea2e-6948-4c5e-e4af-08deb85eb2be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|38070700021|3023799007|6133799003|11063799006;
x-microsoft-antispam-message-info:
 BPPOJXFPl6dGvC4fzs6qBlzUa5mpbM4yZSKt/BDM6yeE2y+XVkF9GqI3kOKDzZnPaTSuy+tBkalprf4FlqFlrG46ku8vEHukMhfe40HuvQ0KMOos/iAm8BQVSfIaT63nwh+vMbAVX20uOhwCEjnKKMZOBWK3C1NCEX1hv71Rn0n/dPLMN1cJ8nrCdLbHj10qdDw9lXovr9lUNBcxpmEnJbWDiCZuc+kLgQuZDOks1pQlgwkWucmqf3RJbIopkdDF5LT4mxFkOezbBBF+ApSc7F+HdhGpBW1Q5xI+a386Eq8oM1LfXCUr9X48YmqeOxCZJqqyc8aQAxEawS0ca42td1kwm2BuFwKw2PY1olBCy9iCWG7ZsXFSTWqUL4MhBLY/LEGtPD2BT3+kDPSxzzAsUUTvvscEiJwvIhrtJj46hk/jEP2816vdrexh6yhn5LRiz4CnNQCzKgymQ7Kbi45MgpbuxwyoSahEQG0woMqkEfouiwspu3giOvSQzohUqLCIgJiMrVwmTgje+/cCieVXunjZmwA6bQ03HywZKXw1KEcsB5OVf1T0uANucTr77cjlH0uhHcIKkUogDgB53JgPwa2Pwh/ib3Mlqk+9RSjPtke8xb5iA0ucM0pp8yw7RWxYuZpVraFtgEMgqOYLo8mS+RwBNWqSZP/9+tsLs8cYsXbLGOTiCpEehVqUp3czaU5/8P684d7iynfVAa/R081hWHGdMSjAilG8MHrzwN15wcPpwGfA5qy5B5UV5F0i+FRq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWpCQldaOXU0TExVYXMyMGFoektpWGVMU3ZYR2t0RXlSTmhqMkNRdkNlV3U1?=
 =?utf-8?B?MWZVMWtHMmZjbjFZVENicmZMNTVKMUdRZUZUeFNVcWM5czI0NE03akdsWDVD?=
 =?utf-8?B?djBJRzgwQnFzNmFRcWVSVk4wYXgvbkJmaTZKVGJ6YnRweDg2Nnc2R3lHTDVz?=
 =?utf-8?B?VFRoL1NsS0ZFaGdEWXdwRmNHWk53QzRML2IvUDJwM0Q4R0xZWHlkWkVyOS9E?=
 =?utf-8?B?Z2d4bnlLSU1raG5iWEJkMUdxZitRM2ExRTZ3YkpJaGV4TXdCTUcyeXJuRXZa?=
 =?utf-8?B?OFFUOVQvQTFzQXBEMVRTckxrU1ZESm1EVk9uenJYZW5acnI1cDRpblF5bkdi?=
 =?utf-8?B?Tjkxc3M2VzVwU2szTkhibjZGWFZ1bURLN0pWN3NtM3ZuZFZTTUx1MTRBT2Ri?=
 =?utf-8?B?U3ZubkNJRjZuTWMyYmNRNkRDUiszYjNJV2hyQzcwdkN0anlwMUt1WGEwdzVC?=
 =?utf-8?B?aForZjliTStYeC95dlIreDB5ZENTUUt2QTJaY1ExT3pDMWFsb0VvOXRuVmdt?=
 =?utf-8?B?aVNhOTJmVVdqbkxwOXAzZU9OR25heEZkNE90d3l3YVpzTTJrWFhDUUNKMUd3?=
 =?utf-8?B?OVFKSWc5RWJ3S2M0M2NyZWVlZmZ6VkRYdXcyMG5vdG5Id1ZGbGpkOXg2N3BB?=
 =?utf-8?B?RTNEYnlzSStZLzZ0Tkt5SkxEUWs0WTN1U0xhRnBJZlM2VDNwZE4rOG9MVzhP?=
 =?utf-8?B?bFNxTUR6KzFFUjl1dVdyRlpXZjZJSklMSkF4ZThzSlJtMmNKM3ZDckZ1c1dX?=
 =?utf-8?B?aHRCOXA5ZSsyREJFNTVqTzh5eWtJYjIyZlJ4Njd5MVlxcVo1dEVDaU02bGly?=
 =?utf-8?B?S1ArNEJQblVOV2NsSmtvSzBtc1BERk5pakw1VFBYZm4yWFhqaUsvelU2UzlQ?=
 =?utf-8?B?WUtIaHNZQ1pCdzlwNmd3dE80S0tlZE5qUEJ1WStScEI0a3JROVlReUQ3UVA2?=
 =?utf-8?B?S0RhYy9lbFR6MVBpd1JxWGw1dTBWVUN2ZlloYnpuWmN0UkZhUnQwdllkV0Na?=
 =?utf-8?B?NDNQWmxEcUNoWU1RbTJGRE5GeVFZRTU5RVVVU0xVYkxXWDBzNmZoZ0dXRTd5?=
 =?utf-8?B?TXF2YVN3L3VNdkVaQUZkOFhaMXhmblZYRlVVdnRtVlZrcUdOSkxobDVZbjNQ?=
 =?utf-8?B?ZVMreVJRZGVzalNWSVZpY014NzRJMTQ0aktPNHdGb1lCVTU1Qjl0Yitkb044?=
 =?utf-8?B?eXJZVnNRcW8xOEhHbXRsRzVTT20rS3UrU0ZrclhUZXJjbENjV3BmcjRmdG41?=
 =?utf-8?B?WU9rU3JIanp0bGRwZkgxRDlsbUxoaHRhcmpRYjZVb1N1ZndiMU1BNkJuUzBF?=
 =?utf-8?B?dWFMSjlwMU1TNjNheWxmZ2dGdlBOQ2ZPOTlMczF3TUx5SHU0N0JoOHFCNzBV?=
 =?utf-8?B?bnlWS0F4QUlSbEZiSXF5RGdIQVpma0FRVVdkZ2I0U1VzWGxJK2RMQ3V5VGZG?=
 =?utf-8?B?cmdFTkRJOTJDL2RTUWtLcDNGOW5WY2lwNk1ubkdXaFNDbjdteSsxd2dOY3U5?=
 =?utf-8?B?ZE9WMUpSSk51SFE1SFZXbythSVNLMEdKVTV1NmcvOUw3a0Vlak9XL3RuTVpH?=
 =?utf-8?B?eXdsYmJaM3BIUyswbTV5MUhNeEwza25ZNS9zUXBGRzM2TlEzWkxjTTlJTVRU?=
 =?utf-8?B?c2NIcDl6TGlpZklJNm1HYjVMbUJKS28xZ2UxMTI4d0lsczc0WEgzZGRBUndM?=
 =?utf-8?B?VzRvL2E1ZlJuc1pKa0NBajI1WFpjSHhkWHN2eUUxRDVQOHU3aks5Rmh3TmxO?=
 =?utf-8?B?RTVucXQ2ZW9Cb0FVcVI3L0JJbW1Cajg2Y1RObkZzSUtjN1pVU2RZeUtDbEIz?=
 =?utf-8?B?R1A5VEJUOW9FT090VnpwTFN2QUZ2aFBMZTk5WlQ5ZzVFajZIN0VBMkV0SmhT?=
 =?utf-8?B?cVhEZHBOS1F3ZkpoOFd6Sk5RZ0U2RGRkNDR5K0pIbUgzVHMyQU9WMy9VR3Nx?=
 =?utf-8?B?NndJNnVLQndTeVc5c0lnd2FMUGNxREpHdnRGTG5MMXdMQm56bFlkb0k3cGJk?=
 =?utf-8?B?Y0FrM3lxdTQvSDdtOHBDNjNKL1dUMmFzb2NyZkg0aXlTMHhWcWVwZVFiN1hj?=
 =?utf-8?B?UkNPdkE2RTMxS21WMnU3ZmxwaDIwVEU2Q0Q4Mk5pSDZtK0JhcERQa2hETnBF?=
 =?utf-8?B?dXpETFllekhTVit2dWN6VHlLSjNyS3plcFQ2dFVqK090OWtVY2RldHBucTZF?=
 =?utf-8?B?WjJqTzdGYWd2VGdZOU5BQnRIbjd3b1JSREhNYmFiU09QbHNjRnoxVnJyeE9J?=
 =?utf-8?B?OFg3TEp5SDZOSVY4Nno1NU1TclFNT0hFMHhZSjN2bUxOUXN5Ky85L0dCUEpu?=
 =?utf-8?B?SW5CWUh1dUxzc1E2dHBqUVd1di9hcUJXb3F4MSt6M21URnkwdnQvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d33ea2e-6948-4c5e-e4af-08deb85eb2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2026 00:03:19.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYmFc0qQ4dmJAAUVk3DoDBIvBgDj8LHtkURnL5daRxcI7xcA4QliC0UJ5zgxdG+uCiovpKwsQwimXEf+zByDcoe0LvpcAc9KkcX85rt+0Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[se.com,bootlin.com,vger.kernel.org,nxp.com,microchip.com,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,microchip.com:dkim]
X-Rspamd-Queue-Id: E1E005BBAA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBUaGlzIHNlcmllcyBjb250aW51ZXMgdGhlIHJld29yayBvZiB0aGUgS1NaIGRyaXZlciBpbml0
aWF0ZWQgYnkgYSBwcmV2aW91cw0KPiBzZXJpZXMgKHNlZSBbMV0pLCBmb2xsb3dpbmcgdGhlIGRp
c2N1c3Npb24gd2UgaGFkIGhlcmUgWzJdLg0KPiANCj4gVGhlIEtTWiBkcml2ZXIgZ290IHdheSB0
b28gY29udm9sdXRlZCBvdmVyIHRpbWUgYmVjYXVzZSBpdCB1c2VzIGEgY29tbW9uDQo+IGZyYW1l
d29yayB0byBoYW5kbGUgbW9yZSB0aGFuIDIwIHN3aXRjaGVzIHNwbGl0IGluIDUgZmFtaWxpZXMg
KHNlZSBiZWxvdw0KPiB0YWJsZSkNCj4gDQo+ICstLS0tLS0tLS0tKy0tLS0tLS0tLSstLS0tLS0t
LS0rLS0tLS0tLS0tKy0tLS0tLS0tLSstLS0tLS0tLS0rDQo+IHwgRmFtaWx5ICAgfCBLU1o4NDYz
IHwgS1NaODd4eCB8IEtTWjg4eHggfCBLU1o5NDc3IHwgTEFOOTM3WCB8DQo+ICstLS0tLS0tLS0t
Ky0tLS0tLS0tLSstLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tLSstLS0tLS0tLS0rDQo+IHwg
U3dpdGNoZXMgfCBLU1o4NDYzIHwgS1NaODc5NSB8IEtTWjg4WDMgfCBLU1o4NTYzIHwgTEFOOTM3
MCB8DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwgS1NaODc5NCB8IEtTWjg4NjQgfCBLU1o5NDc3
IHwgTEFOOTM3MSB8DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwgS1NaODc2NSB8IEtTWjg4OTUg
fCBLU1o5ODk2IHwgTEFOOTM3MiB8DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8
ICAgICAgICAgfCBLU1o5ODk3IHwgTEFOOTM3MyB8DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwg
ICAgICAgICB8ICAgICAgICAgfCBLU1o5ODkzIHwgTEFOOTM3NCB8DQo+IHwgICAgICAgICAgfCAg
ICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfCBLU1o5NTYzIHwgICAgICAgICB8DQo+IHwgICAg
ICAgICAgfCAgICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfCBLU1o4NTY3IHwgICAgICAgICB8
DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfCBLU1o5NTY3IHwg
ICAgICAgICB8DQo+IHwgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8ICAgICAgICAgfCBM
QU45NjQ2IHwgICAgICAgICB8DQo+ICstLS0tLS0tLS0tKy0tLS0tLS0tLSstLS0tLS0tLS0rLS0t
LS0tLS0tKy0tLS0tLS0tLSstLS0tLS0tLS0rDQo+IA0KDQpJIHdvdWxkIHNheSBLU1o4ODYzL0tT
Wjg4NzMvS1NaODQ2MyBhcmUgaW4gdGhlIHNhbWUgZmFtaWx5LCBleGNlcHQgS1NaODQ2Mw0KaGFz
IFBUUCBmdW5jdGlvbiBhbmQgdXNlcyBhIHNwZWNpYWwgYWNjZXNzIHNjaGVtZS4gIFRoZXkgc2hv
dWxkIHVzZSB0aGUNCnNhbWUgdGFnZ2luZyBmb3JtYXQuDQoNCktTWjg3OTUvS1NaODg5NSBjYW4g
YmUgcHV0IGluIHRoZSBzYW1lIGZhbWlseS4gIFRoZXkgc2hvdWxkIHVzZSB0aGUgc2FtZQ0KdGFn
Z2luZyBmb3JtYXQuDQoNCktTWjk4OTcvS1NaOTU2Ny8uLi4vS1NaOTQ3NyBpcyBpbiB0aGUgS1Na
OTg5NyBmYW1pbHkuDQoNCktTWjk4OTMvS1NaOTU2My9LU1o4NTYzIGlzIGluIHRoZSBLU1o5ODkz
IGZhbWlseS4gIFRoZXkgdXNlIGFib3V0IHRoZSBzYW1lDQpyZWdpc3RlcnMgYXMgS1NaOTg5NyBi
dXQgaGFzIGl0cyBvd24gdGFnZ2luZyBmb3JtYXQsIGp1c3QgYmVjYXVzZSB0aGV5IHVzZQ0KMyBw
b3J0cyBpbnN0ZWFkIG9mIDcuDQoNCkxBTjkzNzAvLi4uL0xBTjkzNzQgaXMgaW4gdGhlIExBTjkz
N1ggZmFtaWx5LiAgVGhleSB1c2UgYWJvdXQgdGhlIHNhbWUNCnJlZ2lzdGVycyBhcyBLU1o5ODk3
IGJ1dCBoYXMgYWRkaXRpb25hbCBmdW5jdGlvbnMuDQoNCj4gVGhlIHByZXZpb3VzIHNlcmllcyAo
WzFdKSByZXBsYWNlZCB0aGUgdW5pcXVlIGRzYV9zd2ljdGhfb3BzIHN0cnVjdCB1c2VkDQo+IGJ5
IGFsbCB0aGUgS1NaIGZhbWlsaWVzIHdpdGggb25lIGRzYV9zd2l0Y2hfb3BzIHN0cnVjdCBmb3Ig
ZWFjaCBmYW1pbHkuDQo+IA0KPiBUaGVzZSBkc2Ffc3dpdGNoX29wcyBzdHJ1Y3RzIHN0aWxsIHJl
bHkgb24gY29tbW9uIGZ1bmN0aW9ucyB0aGF0IHJlZGlyZWN0DQo+IHRoZSBjYWxscyB0byBrc3pf
ZGV2X29wcyBvcGVyYXRpb25zIHdoaWNoIGFyZSBjdXN0b20gdG8gZWFjaCBzd2l0Y2gNCj4gZmFt
aWx5LiBNYW55IG9mIGhlc2Uga3N6X2Rldl9vcHMgY2FsbGJhY2tzIGhhdmUgYSBkaXJlY3QgZXF1
aXZhbGVudCBpbiB0aGUNCj4gc3RydWN0IGRzYV9zd2l0Y2hfb3BzLiBUaGlzIHNlcmllcyBkaXJl
Y3RseSBjb25uZWN0cyB0aGUgaW1wbGVtZW50YXRpb25zIG9mDQo+IHRoZXNlIGtzel9kZXZfb3Bz
IG9wZXJhdGlvbnMgdG8gdGhlIHJlbGV2YW50IGRzYV9zd2l0Y2hfb3BzIGF0dHJpYnV0ZQ0KPiB0
byBnZXQgcmlkIG9mIG9uZSB1bm5lY2Vzc2FyeSBsZXZlbCBvZiBpbmRpcmVjdGlvbi4NCj4gDQo+
IE9uIHRvcCBvZiB0aGlzIG9uLWdvaW5nIHJld29yayBJIGFkZGVkIFBUUCBhbmQgcGVyaW9kaWMg
b3V0cHV0IHN1cHBvcnQgZm9yDQo+IHRoZSBLU1o4NDYzICh3aGljaCB3YXMgbXkgZmlyc3QgZ29h
bCkuIFRoZXJlIGFyZSBtb3JlIHRoYW4gNjAgcGF0Y2hlcyBmb3INCj4gYWxsIHRoaXMgc28gdGhp
cyBzZXJpZXMgd2lsbCBiZSBmb2xsb3dlZCBieSBzZXZlcmFsIG90aGVycyBhbmQgaWYgeW91DQo+
IHdhbnQgdG8gc2VlIHRoZSBmdWxsIHBpY3R1cmUgd2UgY2FuIGNoZWNrIG15IGdpdGh1YiAoWzNd
KS4NCj4gDQo+IEkgaGF2ZW4ndCBmaW5pc2hlZCB5ZXQgdG8gZ3JvdXAgYWxsIHRoZSBwYXRjaGVz
IGludG8gbWVhbmluZ2Z1bCBzZXJpZXMNCj4gYnV0IGhlcmUgaXMgbW9yZSBvciBsZXNzIHdoYXQg
SSBwbGFuIHRvIGRvIG5leHQ6DQo+IA0KPiAtIEEgc2VyaWVzIHdpbGwgc3BsaXQgYWdhaW4gc29t
ZSBvcGVyYXRpb25zIHRvIGdldCByaWQgb2YgdGhlDQo+ICAgaWYgKGlzX2tzelhZWikgYnJhbmNo
ZXMuDQo+IC0gTWF5YmUgYW5vdGhlciBzZXJpZXMgd2lsbCBiZSBuZWVkZWQgdG8gY29tcGxldGVs
eSBtb3ZlIG91dCBvZg0KPiAgIGtzel9jb21tb24uYyBldmVyeXRoaW5nIHRoYXQgaXNuJ3QgdHJ1
bHkgY29tbW9uIHRvIGFsbCB0aGUgc3dpdGNoZXMNCj4gLSBBIHNlcmllcyB3aWxsIGFkZCBQVFAg
c3VwcG9ydCBmb3IgdGhlIEtTWjg0NjMNCj4gLSBBIGZpbmFsIHNlcmllcyB3aWxsIGFkZCBwZXJp
b2RpYyBvdXRwdXQgc3VwcG9ydCBmb3IgdGhlIEtTWjg0NjMNCj4gDQo+IEZZSSwgSSBvbmx5IGhh
dmUgYSBLU1o4NDYzIHNvLCB1bmZvcnR1bmF0ZWx5LCBJIGNhbid0IHRlc3Qgb3RoZXIgc3dpdGNo
ZXMuDQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MDUtY2xlYW4t
a3N6LWRyaXZlci12MS0wLQ0KPiAwNWQ3MGZhNDI0NjFAYm9vdGxpbi5jb20NCj4gWzJdOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwMzA0LWtzejg0NjMtcHRwLXY2LTAtDQo+IDNmNGM0
Nzk1NGM3MUBib290bGluLmNvbSkNCj4gWzNdOiBodHRwczovL2dpdGh1Yi5jb20vYmFzdGllbi1j
dXJ1dGNoZXQvbGludXgvdHJlZS9rc3pfcmV3b3JrDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCYXN0
aWVuIEN1cnV0Y2hldCAoU2NobmVpZGVyIEVsZWN0cmljKQ0KPiA8YmFzdGllbi5jdXJ1dGNoZXRA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIFBBVENIIDE6IFVwZGF0
ZSBrZG9jIG9mIGtzel93b2xfcHJlX3NodXRkb3duKCkNCj4gLSBMaW5rIHRvIHYyOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjYwNTE1LWNsZWFuLWtzei0ybmQtc2VyaWVzLXYyLTAtDQo+
IDM1YTk2OGE3MzlmNkBib290bGluLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZW1v
dmUgcGF0Y2hlcyAxIHRvIDcgc2luY2UgdGhleSB3ZXJlIGFwcGxpZWQgb24gbmV0LW5leHQNCj4g
LSBQQVRDSCA2IChwcmV2aW91c2x5IDEzKTogQ3JlYXRlIGEgTEFOOTM3eC1zcGVjaWZpYyBwb3J0
X3NldHVwKCkNCj4gICBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBLU1o5NDc3IG9uZQ0KPiAtIExpbmsg
dG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MTItY2xlYW4ta3N6LTJuZC1z
ZXJpZXMtdjEtMC0NCj4gYzAwZjZjZTAzN2ZhQGJvb3RsaW4uY29tDQo+IA0KPiAtLS0NCj4gQmFz
dGllbiBDdXJ1dGNoZXQgKFNjaG5laWRlciBFbGVjdHJpYykgKDMpOg0KPiAgICAgICBuZXQ6IGRz
YTogbWljcm9jaGlwOiBieXBhc3MgZGV2X29wcyBmb3IgcG9ydF9zZXR1cCgpDQo+ICAgICAgIG5l
dDogZHNhOiBtaWNyb2NoaXA6IGNhbGwgRFNBJ3MgcGh5X3tyZWFkL3dyaXRlfSB0byBkbyBtZGlv
IHtyZWFkL3dyaXRlfQ0KPiAgICAgICBuZXQ6IGRzYTogbWljcm9jaGlwOiBieXBhc3MgZGV2X29w
cyBmb3IgcGh5X3JlYWQoKS9waHlfd3JpdGUoKQ0KPiANCj4gVmxhZGltaXIgT2x0ZWFuICg1KToN
Cj4gICAgICAgbmV0OiBkc2E6IG1pY3JvY2hpcDogZG9uJ3QgcmVzZXQgb24gc2h1dGRvd24gb3Ig
ZHJpdmVyIHJlbW92YWwNCj4gICAgICAgbmV0OiBkc2E6IG1pY3JvY2hpcDogYnlwYXNzIGRldl9v
cHMtPnNldHVwKCkgYW5kIHRlYXJkb3duKCkgZm9yIGxhbjkzN3gNCj4gICAgICAgbmV0OiBkc2E6
IG1pY3JvY2hpcDogYnlwYXNzIGRldl9vcHMtPnNldHVwKCkgYW5kIHRlYXJkb3duKCkgZm9yIGtz
ejk0NzcNCj4gICAgICAgbmV0OiBkc2E6IG1pY3JvY2hpcDogYnlwYXNzIGRldl9vcHMtPnNldHVw
KCkgYW5kIHRlYXJkb3duKCkgZm9yIGtzejgNCj4gICAgICAgbmV0OiBkc2E6IG1pY3JvY2hpcDog
cmVtb3ZlIGRldl9vcHMtPnNldHVwKCkgYW5kIHRlYXJkb3duKCkNCj4gDQo+ICBkcml2ZXJzL25l
dC9kc2EvbWljcm9jaGlwL2tzejguYyAgICAgICAgIHwgMjM1ICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejk0NzcuYyAgICAgIHwg
MTg0ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlw
L2tzel9jb21tb24uYyAgIHwgMjQ3ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5oICAgfCAgMjIgKy0tDQo+ICBk
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jIHwgMTY5ICsrKysrKysrKysr
KysrKysrLS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA1MjEgaW5zZXJ0aW9ucygrKSwgMzM2IGRl
bGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDgyMmQ0YThlMzkwYTA4Y2NmYWYyYWJi
MzQ3YWU2NzBiMjMwYjE5NmYNCj4gY2hhbmdlLWlkOiAyMDI2MDUxMS1jbGVhbi1rc3otMm5kLXNl
cmllcy0zYjc1NWVjOTljZjANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gQmFzdGllbiBD
dXJ1dGNoZXQgKFNjaG5laWRlciBFbGVjdHJpYykgPGJhc3RpZW4uY3VydXRjaGV0QGJvb3RsaW4u
Y29tPg0KDQo=

