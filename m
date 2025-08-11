Return-Path: <netdev+bounces-212635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D8B217F2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E7D623B70
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57902D4817;
	Mon, 11 Aug 2025 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wMs69WWf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D773299AA9
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950168; cv=fail; b=iGZtRdGNJDyM3T6Ue89QWNW1G3r0tqkZ5gW38ESq8AD/Aant3Z/IXKUWtTIhArgIrUzyRkW+mVDkE/e8yiL9YkW7leZNbUDSKwMbanhYlaxb7cq4Lu1a5Qlxcu+6Rf4kl9NeDhp29Ir4GDvoEbl0JRjoed/Ha6ZJupNQqm0KnOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950168; c=relaxed/simple;
	bh=o0ddE5X4P96ni7hmtwp+zSqLDE5OlBZPK/LfEl/XZeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1ZEmsXH5ROFEl0PJERj+dftspmz/MN9e1y22TnZbHRAuJPxT/YiEmNbm+XMOnw53WWTV3cadU9sKjKrYe1dVW+/sjDZQguP5ghHwIhZxMawDC2kN15zkcAK43Fv/n9xDsCM6i4fy4/8eEGkbWN8KS5ILu5ZAskMkHXiQVJMQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wMs69WWf; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2ix/LDiYXXF8by4EfUwgJD3jBMJVLTAGJCyLUBFJS8CA2aLdWxxj4+HVTiDive3gxoxB3b8TzhFG9E1fhDjdm0i+xMxhOrC+mDqnfGV1G9MHSF3XUYlXHzWxEt6Vakh+GdB8d5iA2iujFrbha9lxjUVvxcE/a331kmZYLR4DSLd7TiRBB3C1N6pd3sotHNdgDM/19BnDlU4pz8Y2yvqSUnlcsTdmhwHOjmGGlTD6+MljLvo6l4SIYKYreQkXokLOS/AGAQeGF2533Tnubjb+BjOfiAis4j8qDg6SkUU9wz16i2boa7TLKc7OT4K0QRfYXHI3FAod52QcXRsQw4etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxlErVZ3n7EQy3s4aGGkN0h+zoRXd97doMxXUfg/PKg=;
 b=oJPr+ViDoMs5HYE5ZQ0JSM9G44qIbYQZwneWE4Vw1l/tmRG0fqq+uuI0CjBOlFz2cxwneUv5VZS8ivibkGIYvNM1QzyP5bZIzWT4rHuxvvj++jufBaMmDuEK8LDQudCmuhRdi16hRVKGe92mzK7WKLZwTm73NApup2fi5+cUyPzRCBIVb8bJMkGtfpuD9MqIaT8lgR1sIqHclmSes2238I6uZ34Fa3HTmrV62BB83iucbwPsxC9oTXpZjd3ZQOI+H/is72hOaL40vKPPpgk/LnwNfzm1ZyT1yGqYwBYKqIlIADlUs6UA2/KFzQWtPMAgc6R4eICcHTj3/A80SgEieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxlErVZ3n7EQy3s4aGGkN0h+zoRXd97doMxXUfg/PKg=;
 b=wMs69WWfC3qvNo9WlVCpaX0FwBrjpFMDdAaHJ1MxB9pSVeBaeHN39MtzvbzIxqkt1swdlpP5TFjrAl+oF1D6PwZEZFex5vrTsFa8f02MtDBtltP3DbBozKAFum0CWr4p0KgsxBz0AmbHslXwXIw/Pjwy4yjayaMTiatGhTBlgKKFZCu3istWYB0u+5CbLUhn6Iz2GJRGQBRAAIpDaMoun69hvzWO2THh140kho1bvOhKYd8OWkp6RY10SznwF/GONfA90GobCAm7WRFF5t+0WONeiu1URjtpWC70tSAE7SHjb0FHXxF4hoJ0Dg/UO0u6xqa/vDhAh3lA3QppCHfWEQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA4PR11MB9230.namprd11.prod.outlook.com (2603:10b6:208:567::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 22:09:23 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 22:09:23 +0000
From: <Tristram.Ha@microchip.com>
To: <marek.vasut@mailbox.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
Thread-Topic: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
Thread-Index: AQHcChE4b1dqM1jPbUue9pY0XZUvtLRd6bDwgAAHvYCAABFlwA==
Date: Mon, 11 Aug 2025 22:09:22 +0000
Message-ID:
 <DM3PR11MB8736FCDDE21054AC6ACCEA44EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250810160933.10609-1-marek.vasut@mailbox.org>
 <DM3PR11MB87364054C23D4B64069F4639EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <5fa3a420-e25a-4178-b0f3-b3b7bad4665e@mailbox.org>
In-Reply-To: <5fa3a420-e25a-4178-b0f3-b3b7bad4665e@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA4PR11MB9230:EE_
x-ms-office365-filtering-correlation-id: 2b9828a4-6181-4b16-46b4-08ddd923ba5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Pq4ubuBaTJmcPWeu+aS5EG3OYBBOpWRAK9VrH7AqdS6G+oIJUjw4DpiwbCpR?=
 =?us-ascii?Q?5X/Ta5kh1DaEtSnbHKkvu3HcWKBSng9n9/Ff57ypOskOCEcFoVQaj+18HYSD?=
 =?us-ascii?Q?QC+N771vpGGvf1G+sde+L947YQTkxjN3aFHXEATHzKc2tsq8koSKEuoQCzW2?=
 =?us-ascii?Q?CVfcgOaKKzYR6DJZIKEbMll2XgiVPOrxpyNxOZs/UqEkVkU4/ilaKd53DWsN?=
 =?us-ascii?Q?XSVw4zwgqkWcCkR6i/WmhBFEokD6ax2zB8hjX0lt8kk0O4BzukxBTkWNH5UB?=
 =?us-ascii?Q?A9Knk8S/T2DrK3dPBdnBVpKbsezUmmTvLm/eexGPprUl/AWmS1Epv3mBjG+u?=
 =?us-ascii?Q?sF1mOVRI1RAoiNanw24tgtBIvHv7WtUqIp0E/rlH4KlS7YAxzDgGEDcUsde+?=
 =?us-ascii?Q?AlCOjwfzwnXzEBtOpp+uFtj6dXbvvr/JHj+aFA57knYYjneAhcWXtLqcIOdP?=
 =?us-ascii?Q?DsxNcJexxF2i4HKP8hmnAB63wQOgazVxigEPOGcs/jnJZi/kZhqvwWljG5bC?=
 =?us-ascii?Q?69CZ3oyoPqMc71OC1qn3NsIQ6WdtAaSD8cVqTpQgg3D3a/dpEpJp3BFWdQ/Z?=
 =?us-ascii?Q?CpIKL2RZ1+mSegcbDOanOkGMn7YQ+NhaTqqDmgJ1WN5jQDcH0Lr5PBOShYXd?=
 =?us-ascii?Q?+iGJOh3rn235vpBkl/1VGYVxy2rjrvAatpP7+OLqv549DYgn695M6VbQ9UtO?=
 =?us-ascii?Q?AE2Y1RaxfsV51tElYOlEjjK8yZw9KZpHFs1iLxKKHOT56Vqa6fBiOknvy19Q?=
 =?us-ascii?Q?wPwbjBuo1z+LK3dYPfV6MIv1t8a8/zpEbFER63YJr/ByHk6pNc9bjEJawfk6?=
 =?us-ascii?Q?XYHHYWTC9Q+UpO3nwPX2qjaVap90+xneG2pOk5DH7YPay3/azVgakFyoYYqp?=
 =?us-ascii?Q?aZiQ2JTJN4OG3upArP80AXDmF9YljQaqIQyvhQalqLQ5uE+E9ED4jX49CJi1?=
 =?us-ascii?Q?CyfM7r+5eUnmd08DcQz1QaZ3m++HNXkBnywE7PQIALTiVU0zmwxoxB0jaVUT?=
 =?us-ascii?Q?2GB+lAeeVffe7LfiROpePGHt2PiT2tDt+r9FgaKJrRChUOUCYqZRgQScaAJx?=
 =?us-ascii?Q?jA0GMZhjtxSif3o2HMcanffJQrWr1/ylVoZhFBl0d/qt2I7cXrc4uWIvGJl8?=
 =?us-ascii?Q?R8vQ3Ohyi21qU+lEZ9QQ63rRhHBw4DcqnI1jOG+RIOcN7yecxTAqMfSHkMfU?=
 =?us-ascii?Q?NNyI1G2UB2ejUnt4CAvmbkGYU/g36Ef/lJUZIioWaazaBqS7wIkqsgk+oJVz?=
 =?us-ascii?Q?9XqR46BXL1Dw6lvAEgiho59nsx1PP8B/ESGbVheCbFJdccAe83CCjYhteOTd?=
 =?us-ascii?Q?XLlWf15FZ0phRf5Q6VI2LwZ5pypupGKdQ9jf0ZjLxTqDbSOFSfULVNXowJc/?=
 =?us-ascii?Q?sk7SX1605A74UW4NnMG9btKhyih+eZYml/6N33xYHhyWIuVBdkUf1X2Hj+Da?=
 =?us-ascii?Q?L89SdrK7E1wW6T4CUfruREa8/uHTxWh+xFExKaRzcdOQD2/Ae32S+Jue8B/6?=
 =?us-ascii?Q?E5wPNyi2kLANz98=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cdKVZFfrOGDDXlZy7nnwi8Qgi5+FHkFhuDgRkNDCNxvTPu0g4WVjNW82PBjt?=
 =?us-ascii?Q?9+dTEjlXdVedub8N3aV4t53s8SCCOVcfZqoKL2WlUoR/5YjfwFJnRmUn2GtV?=
 =?us-ascii?Q?607K5PZwx4VXd62K+8i/HiEWFUdmpMCNKm9xFsEIFxh064hOvdKAeC3LaNNN?=
 =?us-ascii?Q?IkU528sDQV48Vpy0R/3c0nbhVUeQCvwubxtvo1JwtF7ZitiO9X4MhhnCWB7x?=
 =?us-ascii?Q?8hjqIrVqqd8/w+DYzHcfI5EPB4mirs8kNAABTVmh8STYir4cIWxo69vvS9tw?=
 =?us-ascii?Q?yTpRcQZvm3XqVl73N9C45hFsdIF4sNXlfCttZRbQk/BQu3tTPSaGD2DU3FBt?=
 =?us-ascii?Q?IhkvO48P/YGF4tcYBYF2Bs85DkzF+QBthXO9paDOhGTh29cUHh0G4xYWjG6e?=
 =?us-ascii?Q?yV3e3+MwFPYyMyLXgdLIiIYyXfmMq7zQnVvkdVl1967PB0Ds16j6jsvu4/Dq?=
 =?us-ascii?Q?9JNq6tbYwv8jqXy66EdH0VzIunlh8AbhsCFPyUB2oBGwEOkhkzD79n2MBigb?=
 =?us-ascii?Q?44piD67owXJRykC5jzAtcOvp9aOZCKj8PPvTyP7oV3ICTlwc5cDFqXZhIaio?=
 =?us-ascii?Q?6yVY56dfk9Q5oYfaystGQhX0EjqvSZrkbIOZ+RQubV6LQRCGkAJJ+OT7ttiu?=
 =?us-ascii?Q?3ypP4gU+oU2NQCD/RQ9Ru5oIBizsBD6xD2kAp3KaM6qZxJG6rLFziv78+B8k?=
 =?us-ascii?Q?eyr5zECSNMlxZbworZ8F4CB4O/TZLOHGvoQ6ZwuGp6pMBY6YOkaHb+N9KAYE?=
 =?us-ascii?Q?VioS0QZQgxOeocQ075uXuAFnqbcpFm3U1GNrrBbhx00Nv+fsLj5TKx2el03+?=
 =?us-ascii?Q?BjTlHGGmLnlwWwZY7hDroTIA7g++v9i0ngk6KC4yFfJ6Wv5DPDmapRNTqH5K?=
 =?us-ascii?Q?45I9uIMfLmFpwmJo9ozKuSOtB+SJZdAup9kzggEeyb+0wAB88aFhpq1r0y5Q?=
 =?us-ascii?Q?Dbm8KYpXP1tLA43mSE0pd4rlAMzB25UisDpV0ZUTbyXNkybWnKt286z8MIST?=
 =?us-ascii?Q?fKmiS7xkAtRL6BCDDT1f79wX91+v7NqOWoRiksXDHw+c+ixETzQuxXJq29PI?=
 =?us-ascii?Q?45dACXyzWlTvV0Z3E/SQTUN0bmg4+IUypUkMhC1KCMy+ulmdUD0RCwTd7JT7?=
 =?us-ascii?Q?hpHQpktknkriROsW3v3rsBiVg8TCEeR1tCps56hL5gJJsdgogiht/mr9gFvF?=
 =?us-ascii?Q?R6WioQvxOA+B2MZsY5V+vVW9anXn+xqMox9RYlRLsdjlWb3294OnA3M6a7iZ?=
 =?us-ascii?Q?RK3zdCdmQt2EF59uWxE5VPHojmyJ21XTnFVOXGM0VmherxrtGG5yPwBMF8cm?=
 =?us-ascii?Q?y+Mv4IPeDfYnkQ+7iTjO8lfqmSIKW7/W5Rb9KC79HEzZ5yEQRvo/KHeuQG2h?=
 =?us-ascii?Q?oGq0BidlN7Xe6MzYnEol9PCXhVgQZ2ql1+poy3j4lujdKtTElshQAfWyxd+i?=
 =?us-ascii?Q?ikrK0zgiLjilacny3IuzT/pEnX4NfTHlh0VG02Mh7SiNcYrEIYHBXVLUVj99?=
 =?us-ascii?Q?zEfEAi5CpBz9Esayf0o0GcEmk/YK4XH1/iNt0zf4yfMn3IGAd3CFJrGujm+i?=
 =?us-ascii?Q?5TpTDzk2miw8GHwsChPkam3GTnU+f+IxIbwBqiUp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9828a4-6181-4b16-46b4-08ddd923ba5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 22:09:22.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBCHtP0aV4zNzdPnm3DVZ+/7RXOSjCMi9kfG+E6voagg598kUdXubBrhjRgn/ViZ41Hyk0BJaLYmUmRUMHF/DBYf5Kpo8cr9HfaHEzDhprY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9230

> On 8/11/25 10:47 PM, Tristram.Ha@microchip.com wrote:
> >> Unlike KSZ94xx, the KSZ87xx is missing the last four MIB counters at
> >> address 0x20..0x23, namely rx_total, tx_total, rx_discards, tx_discard=
s.
> >>
> >> Using values from rx_total / tx_total in rx_bytes / tx_bytes calculati=
on
> >> results in an underflow, because rx_total / tx_total returns values 0,
> >> and the "raw->rx_total - stats->rx_packets * ETH_FCS_LEN;" calculation
> >> undeflows if rx_packets / tx_packets is > 0 .
> >>
> >> Stop using the missing MIB counters on KSZ87xx .
> >>
> >> Fixes: c6101dd7ffb8 ("net: dsa: ksz9477: move get_stats64 to ksz_commo=
n.c")
> >> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> >> ---
> >> Cc: Andrew Lunn <andrew@lunn.ch>
> >> Cc: Arun Ramadoss <arun.ramadoss@microchip.com>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Tristram Ha <tristram.ha@microchip.com>
> >> Cc: UNGLinuxDriver@microchip.com
> >> Cc: Vladimir Oltean <olteanv@gmail.com>
> >> Cc: Woojung Huh <woojung.huh@microchip.com>
> >> Cc: netdev@vger.kernel.org
> >> ---
> >>   drivers/net/dsa/microchip/ksz_common.c | 13 ++++++++-----
> >>   1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> >> b/drivers/net/dsa/microchip/ksz_common.c
> >> index 7292bfe2f7cac..9c01526779a6d 100644
> >> --- a/drivers/net/dsa/microchip/ksz_common.c
> >> +++ b/drivers/net/dsa/microchip/ksz_common.c
> >> @@ -2239,20 +2239,23 @@ void ksz_r_mib_stats64(struct ksz_device *dev,=
 int
> port)
> >>          /* HW counters are counting bytes + FCS which is not acceptab=
le
> >>           * for rtnl_link_stats64 interface
> >>           */
> >> -       stats->rx_bytes =3D raw->rx_total - stats->rx_packets * ETH_FC=
S_LEN;
> >> -       stats->tx_bytes =3D raw->tx_total - stats->tx_packets * ETH_FC=
S_LEN;
> >> -
> >> +       if (!ksz_is_ksz87xx(dev)) {
> >> +               stats->rx_bytes =3D raw->rx_total - stats->rx_packets =
* ETH_FCS_LEN;
> >> +               stats->tx_bytes =3D raw->tx_total - stats->tx_packets =
* ETH_FCS_LEN;
> >> +       }
> >>          stats->rx_length_errors =3D raw->rx_undersize + raw->rx_fragm=
ents +
> >>                  raw->rx_oversize;
> >>
> >>          stats->rx_crc_errors =3D raw->rx_crc_err;
> >>          stats->rx_frame_errors =3D raw->rx_align_err;
> >> -       stats->rx_dropped =3D raw->rx_discards;
> >> +       if (!ksz_is_ksz87xx(dev))
> >> +               stats->rx_dropped =3D raw->rx_discards;
> >>          stats->rx_errors =3D stats->rx_length_errors + stats->rx_crc_=
errors +
> >>                  stats->rx_frame_errors  + stats->rx_dropped;
> >>
> >>          stats->tx_window_errors =3D raw->tx_late_col;
> >> -       stats->tx_fifo_errors =3D raw->tx_discards;
> >> +       if (!ksz_is_ksz87xx(dev))
> >> +               stats->tx_fifo_errors =3D raw->tx_discards;
> >>          stats->tx_aborted_errors =3D raw->tx_exc_col;
> >>          stats->tx_errors =3D stats->tx_window_errors + stats->tx_fifo=
_errors +
> >>                  stats->tx_aborted_errors;
> >
> > I am not sure why you have that problem.  In my KSZ8795 board running i=
n
> > kernel 6.16 those counters are working.  Using "ethtool -S lan3" or
> > "ethtool -S eth0" shows rx_total and tx_total.  The "rx_discards" and
> > "tx_discards" are hard to get.  In KSZ8863 the "tx_discards" counter is
> > incremented when the port does not have link and a packet is sent to th=
at
> > port.  In newer switches that behavior was changed.  Occasionally you m=
ay
> > get 1 or 2 at the beginning when the tail tagging function is not enabl=
ed
> > yet but the MAC sends out packets.  The "rx_discards" count typically
> > seldom happens, but somehow in my first bootup there are many from my
> > KSZ8795 board.
> >
> > Actually that many rx_discards may be a problem I need to find out.
> >
> > I think you are confused about how those MIB counters are read from
> > KSZ8795.  They are not using the code in ksz9477.c but in ksz8.c.
>=20
> See [1] TABLE 4-26: PORT MIB COUNTER INDIRECT MEMORY OFFSETS (CONTINUED)
> , page 108 at the very end . Notice the table ends at 0x1F
> TxMultipleCollision .
>=20
> See [2] TABLE 5-6: MIB COUNTERS (CONTINUED) , page 219 at the end of the
> table . Notice the table contains four extra entries , 0x80 RxByteCnt ,
> 0x81 TxByteCnt , 0x82 RxDropPackets , 0x83 TXDropPackets .
>=20
> These entries are present on KSZ9477 and missing on KSZ8795 .
>=20
> This is what this patch attempts to address.

As I said KSZ8795 MIB counters are not using the code in ksz9477.c and
their last counter locations are not the same as KSZ9477.  KSZ9477 uses
ksz9477_r_mib_pkt while KSZ8795 uses ksz8795_r_mib_pkt.  The other
KSZ8895 and KSZ8863 switches uses ksz8863_r_mib_pkt.

The 0x80 and such registers are not used in KSZ8795.  Its registers start
at 0x100, 0x101, ...

They are in table 4-28.


