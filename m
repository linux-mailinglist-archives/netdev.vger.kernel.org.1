Return-Path: <netdev+bounces-270300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BWrLROlv2mi7AMAu9opvQ
	(envelope-from <netdev+bounces-270300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 09:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54A2E8977
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 09:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92A383006214
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A70230D0F;
	Sun, 22 Mar 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ABhXR4cU"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DB30CDAB
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774167309; cv=fail; b=Ab45GfhTraZU5RCwVj/xnptiWf+l0F8xEpPkx3nZdqXUFjGhmmgeyDuMRJsmeK61ILPY8teaMA9NInV/+Vtqkku4MR/O5EDfgv+3p68mUlpuietXxDMjT+cPSyAEVnJr5lkTh8u9r8/V6tJpi8BEU3ot5d5bmhonukpfPUoTQ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774167309; c=relaxed/simple;
	bh=A/lYWXE7SQOiQgcEWrPEPb1OwW0y1SxJxehrZnzMwJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WNxacalYdkGVIt61W30plkKs+8bIIExmR/ytc6JEhJBTEv/ZCj3rXFN/Plm2LvJ+CrRv3vGz9szOObtwTqBQ+o8eliNSiftWWZglVSfm4EBHdlRBNLpMeaMU1VrRuIZ44wxf7gk4L3WuWZhM1SiZhOaz/Gcw8HYVUHydtbZYkL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ABhXR4cU; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZs7GysuOIhGtJYSCWGCsGTV/Ha0nqGLsVETdEd3NsXyBlcT7UjuuHhcFrHP2el6Fxmol/mV5vQ9kUtigJ+BkSDGdAhLuKSuD1yGOqhnqDpos2Xizqeu7mShX50/82EzHdupsrcZkESVJ/zeBzWmttkZEAplS/ydyr0DOsRM13T5Rqync6+zNJ3wj7S1voSE8QqFb126wlc/dp5PIubfgwmKu2TFEzV+deNZ+IHcY30L1vQBZ3c/U4QAFeGcWxx5f1REm96q0F7ingKPTwg+WmIIFrg+zAGniqULktKFLEdyG3EpaiqxGRwiU9woDglVGRxD4+4NM1v3+DfECkkjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/lYWXE7SQOiQgcEWrPEPb1OwW0y1SxJxehrZnzMwJ0=;
 b=npcrN0b4ZCGc+EI37rZzLGidLnXvOYeuC9kuva8QYKrKVPL2I+pVCaVUtCswbEwK0rjhjgtTycvQBMxY5AMWx8T2ECRXm0BRdkqS+uwUmXjy9JkD31EEDQ9k+QoblpnHLo7EsZ3wO6EGgQrBFmb+Gv2i89lql2CjQNT8N9rVpxQz3RAsp1URk/mpmEMdMuNqClauQIxcBRDH5yfnnDw7QopjGpnBtKgxXmAQ0fLtmuRX38j6WybzbXKPjR0VvOSBtCbnCyKdtlcA/4S6EMn66Seg0dhmVzPXAQiGIzFtP0vFS5UXYxq02N2hRsS505M88pXbaYeiv+qh7zx8XKHjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/lYWXE7SQOiQgcEWrPEPb1OwW0y1SxJxehrZnzMwJ0=;
 b=ABhXR4cUFhWfhg9tlQ+17H39ZuFpvt4dE66MQlq/+e8p2aDPo12iHiUxYyoIO/1RMwv4YkwE77f7FFivVRnV2lrI5FyebL1SCyczM8MK3gno96jOOQt/hcQmMgm5C+42Ggb5xnNIfHPMb5ckvTAh9dl2D30Gq9GUwGjE1WI6rGI64uYHomJSQu+DzSVpk/uHwoL0QJW70QPN8GvkDemrWUqTHDGPL3nAdiUPaPRBP0mzKYxec5eZJPXGX2eJ4919yusmBHPBs8SJItI5/CHW6W0b5PQMpxM8hNEhNR3NH7wd/MhL4PZMd6Nj5xoRx9JizV3ZsqNJu6BW32kXhsxTTQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 08:15:04 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9745.007; Sun, 22 Mar 2026
 08:15:04 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [PATCH v2 ethtool] cmis: Fix incorrect LSB field used for
 wavelength tolerance
Thread-Topic: [PATCH v2 ethtool] cmis: Fix incorrect LSB field used for
 wavelength tolerance
Thread-Index: AQHcuUjojcnl5l74702pS/ZaKUOXHLW6NT5w
Date: Sun, 22 Mar 2026 08:15:04 +0000
Message-ID:
 <DM6PR12MB4516F8DB9BD514E07C9B6350D84AA@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SJ0PR12MB8116:EE_
x-ms-office365-filtering-correlation-id: b4e6733e-5dd7-453f-5dc4-08de87eb1f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 uG+ktChMlPy5FA1c24tF0YhUq/G4u+kq9B0tBmWJeaxccOXcVTW6TL6MyUS760NShMQwTr0Q5o8TwISaR4BZxBur2PGn+6ImTBSvrQp3r2Avoilz4bbHxj7hyi75kWYR5vWJ9IqmGJ1FmxINJXPxTytY1JQNeD6DuZ1NP4UVh1IG6ZnJi+VciVZq7s2q72jMePW3vLAInfYnQ6kQ2fJA2GoMOgSvE0MGqPWWxKAwPHxBDq2u1upYT/ln4CsiUfBOrMKNIwk0IFq9ACHXXInLT96vuizUL9Rgjk5+2sZMg/nt9ghnYQrb0jzhr0nmq1nwUUH/+VKCJ+8ZNkZ+548kat9+l8mOFCWco1x/LMEzde7mLfe1tAKAKDeCtIwSNv9B1M0lRx3CVL2oc6aYHSAubPuQcD0YIyAjBQwJU5nyrq73eX0nJuieYQTjiwm0cmmVILMDdXiFguSPWN9ROT/CsTZd3lRcyCfPeR4W50KHmJWk/awGLpnJ6n6Qo6EgnsivEcDkzrq2phgZwMiT/wdlxm+6wE5PTSbP9zTZ3hH1Y/mR/aLD04OH4+niXkGPhqx6yasBFzpzWblThfGEd6Qp1alz7XHcyeLPJhSp1kBuAJep0yVjbEYsvA71+PID5gEXOy4a9JyhTFfCrYiah9EpgxKkWXAXbi9vzj7ULMJF6Mfhld33WPkqOwfN5kMmdBvIwFj6RbSqPwr8++bq1E9oWrMHYICyfBYprTD8Gg4hPzuGJ+eGNhMIAUOytaJLePJzjFnSbD8OBaTKwLHgUeaCZzSEy9Te/gkwheaYhVc9rzQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0x5c3J5Ui9uR0pJK1FFU3lwbnE0Y0FGQTlZWU9URTNwR3lacGwveE1CNXhY?=
 =?utf-8?B?emFEVWZuMjBmcUpXNFBZVUNwbEJ3bG54cGRrYVkxY1RZS0V1ZGg0TGticXhR?=
 =?utf-8?B?YzYzeFYvTmh6VURhR293M3htdzNyTGE3K2l4UDNNQzh6R2h0TXAzVGZja0ZB?=
 =?utf-8?B?WVBvZDBZTTN5WnEvUXpqMXNSSGRRdEtpd05SN2NEYmJWcmpZNCttaFQ2c2JY?=
 =?utf-8?B?bUtOOWhUcEl6bTBUZXhCdFEwTHlkTS81c1ZSa0IwNFdxK28xMU5HRlpQUUJB?=
 =?utf-8?B?TW1ZTGtEdGxQR3ljVk01RUhwaHJLTFJCM1VLT2owRTNZNjN4SkpHdnN0amwv?=
 =?utf-8?B?blRiejJGTVBpUWd5Y0FUZDQvOXNORnU2MjBhSW0wL25sUU1IS3BVcmRuYmFS?=
 =?utf-8?B?VlFCdjJhYTJQdGZjNEZaVnNwU3YvS2k3a0M5YVRJRnpvcDhRKzgxTktvOWZ6?=
 =?utf-8?B?bmE1bTBTZlZ1TmtrbUpwbGdPTjRTYjAzZlRPSUdiSXRialFjUWxGTlpZODdU?=
 =?utf-8?B?Q2QwYzVWZmh1Yjg5bkdWeUU5VVNBakZNcENyTHZ1ZVpudUN3UVp2RFMvSmoy?=
 =?utf-8?B?V0ZjYXVSUmZDRFh4azZCVDVCMk5WV1V5cHkyQmdYQmREWWtmS0s2YjhyLytN?=
 =?utf-8?B?bjNqMXVIeENnelRWWXkyMk5KV3Z3MkJVcENlbmpZZmdvM3N4ODR3NHordHFI?=
 =?utf-8?B?Q3N5V3llVkR2RDZQQXlTYWpQeVNBTkpBZkFuUDZGU1ZLRVN3Y2JnbzVkbkRU?=
 =?utf-8?B?L3RIU2ozMlBMNEUvN2lDYmo5Z29vRzN4SHk1VWQxZE9PRUlvbUkzTW1KTXMr?=
 =?utf-8?B?TUlQcFpNMVlGcGVlMWg2eFg2d081SnV0cTZ5RVp1NUgwS0FodDlrUlZCa2VU?=
 =?utf-8?B?QnAwRjYrd1F6ejgwWUorSjc3ZHBUS3N1NjlWaDVScHgzRWV4SmNwVW5oY2l3?=
 =?utf-8?B?aFNsVFpnNFRXOUM4NzF3ZXpvUmdyTDh5Y3FJTTNsT1JIek4zUTRHeHdYZ0ZV?=
 =?utf-8?B?by8yRTNlZXF5V3FlYmJKOHhiL0d4RzJaQVF2U1RvcXJXWFZhSlh2L0NRUnFz?=
 =?utf-8?B?YXk1NXpDd0JGbVlUNHZFT0lvdWdmU2M5L0lYRmY0MEkrcmtXMW5lTlpIOTRz?=
 =?utf-8?B?K1JoVHZGdFRFemU1RjA1Wnl0MkVqaGlXZTE4RXJwRkFsRzFMWjM3RmMwaUlp?=
 =?utf-8?B?WHZmOXJQNXpTSWxONlNGKzg5WkxjTWx1OS9maFRJTURrclhwUUpmY1pHdzZy?=
 =?utf-8?B?VXNSMEJMYW1WYmQ5MGJaY3VDSmc4WHY3ZGIxaXFIUmZwOTFjNmViU3V1cFdG?=
 =?utf-8?B?Nm9JQmE0cVp2Rm1acGFqbWJzM2EwODk1WDdIU3BSRzZBeFlraEhrdVNqT01Q?=
 =?utf-8?B?d2ZYV3NHUjF3MjRtb3lmQWJTWWpqTzBxWkwwMVo4a3pNUTB1ZGE0ZEFzTTNX?=
 =?utf-8?B?bThkWldIam9GRFJOWDFKZTQ4VUZqb2c5LzRQVG9JZ1NwdVloblh6VmU0U3Q2?=
 =?utf-8?B?ZFppelBGUjY2eTJDdTBpclJBS0RHY3k3WUJydFNuOW1BMEVCZmRZVmJFZzVi?=
 =?utf-8?B?YVI4bE1BTlFSWmd1ZXJaVU5FOWlkUExRc1Y1NWc0SzlzM1ROdEVINU1rRVlw?=
 =?utf-8?B?cHZNaEJtSlNmN1ZEVUs5TGNram54Q25VaVh4M3BhaEJMa2ZldU1ZMC90K3Nq?=
 =?utf-8?B?WlZtQXNabGZ1YkxMYnNnU0tIWHVpaFNIRDUvdkhTZ04yem5iK0R3cTVQbjB4?=
 =?utf-8?B?M0t4MXkyNFJtM2Q2NjdtVDgrSjVRNktGVzJ3Y21iQURpZ0J3OWtKY3h0N0Mv?=
 =?utf-8?B?OUpuM09ZbWVBenBlZlVkc0g3SE5ZZk5wSDBrUTQxS0Z2bUk2dzAxMldHYWU1?=
 =?utf-8?B?dENEaUFUeWd3UjcvWFRwNlEwa1RXRVhUS3VvNzgwZkc0Y1ZiSU9zVk9HSWdh?=
 =?utf-8?B?Zm02ZXdBeHRYclQwRGUrd3B2SWkxbjdBOVM0aVZJYm5HckZWQzNlbTNjb3Zm?=
 =?utf-8?B?NVNJV3RZaExBRFJEUTFYOE9kREhjV2NwZHZnWWhlcWJKblBpM2c4ejFUMVlt?=
 =?utf-8?B?S0pncERYNTBzTzZ0K3plZlNuMHVEY01ycjIrTFpaSFdweXRVOWkzSGk1U2Fa?=
 =?utf-8?B?N2VyeWgwY1o0RDV6aDY4WWp0RTN2VkFpRmNpcXRqN2FGUnVjelNvNzV4NEE1?=
 =?utf-8?B?UDQ5d0wzWWlqZEZhRndEUG9XVFcvZll3MkVKcGFSd3lGZEpub290b3YzZFNS?=
 =?utf-8?B?Zko1RDA5REx3ZUNHQ0I2UnFuRVF3Q3ZwbDh3SVd1NHpFMkJ1VUZ0K3Fsdlo3?=
 =?utf-8?Q?r6vXLrrn+clisrzeJt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e6733e-5dd7-453f-5dc4-08de87eb1f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 08:15:04.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJvDptR3olKiwS9AXGRrnx1ki30YE1pfjfz3s1riGfGI72SSQMYtvD5H74n2adRHz0m8pOle5RYPM6zHAiZ2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270300-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: AD54A2E8977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbG9rIFRpd2FyaSA8YWxvay5h
LnRpd2FyaUBvcmFjbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgMjEgTWFyY2ggMjAyNiAxNzoz
OQ0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IGt1YmFAa2Vy
bmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWt1YmVjZWtAc3VzZS5jeg0KPiBD
YzogYWxvay5hLnRpd2FyaUBvcmFjbGUuY29tOyBhbG9rLmEudGl3YXJpbGludXhAZ21haWwuY29t
DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiBldGh0b29sXSBjbWlzOiBGaXggaW5jb3JyZWN0IExTQiBm
aWVsZCB1c2VkIGZvciB3YXZlbGVuZ3RoDQo+IHRvbGVyYW5jZQ0KPiANCj4gVGhlIHdhdmVsZW5n
dGggdG9sZXJhbmNlIGNhbGN1bGF0aW9uIG1pc3Rha2VubHkgdXNlcyB0aGUgbm9taW5hbCB3YXZl
bGVuZ3RoDQo+IExTQiBmaWVsZCAoQ01JU19OT01fV0FWRUxFTkdUSF9MU0IpIGluc3RlYWQgb2Yg
dGhlIGNvcnJlY3QgdG9sZXJhbmNlIExTQg0KPiBmaWVsZCAoQ01JU19XQVZFTEVOR1RIX1RPTF9M
U0IpLiBUaGlzIGNhdXNlcyBpbmNvcnJlY3QgdmFsdWVzIHRvIGJlDQo+IHJlcG9ydGVkIGZvciB0
aGUgIkxhc2VyIHdhdmVsZW5ndGggdG9sZXJhbmNlIi4NCj4gDQo+IFVzZSBDTUlTX05PTV9XQVZF
TEVOR1RIX0xTQiAtPiBDTUlTX1dBVkVMRU5HVEhfVE9MX0xTQi4NCj4gY29ycmVjdCAwLjAwNSBu
bSBMU0Igc2NhbGluZyBmb3IgdGhlIHRvbGVyYW5jZSBmaWVsZCAocGVyIENNSVMpDQo+IA0KPiBG
aXhlczogMzQ0OGEyZjczZTc3ICgiY21pczogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nIHRvIC0t
bW9kdWxlLWluZm8gaW4gQ01JUw0KPiBtb2R1bGVzIikNCj4gU2lnbmVkLW9mZi1ieTogQWxvayBU
aXdhcmkgPGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gLS0tDQo+IHYxIC0+IHYyDQo+IGNo
YW5nZSAwLjA1IC0+IDAuMDA1DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogRGFuaWVsbGUgUmF0c29u
IDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCg==

