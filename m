Return-Path: <netdev+bounces-268928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAvlJ+houmnnWAIAu9opvQ
	(envelope-from <netdev+bounces-268928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:57:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E292B88FD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACD6300C587
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E638F94E;
	Wed, 18 Mar 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oce5n6oJ"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB68285050
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824212; cv=fail; b=hzx/xuVl0NU7Um3pEtkSz5UfAG9P/XxMQqR5Pa+kBRohEoeI+TaMvY0l7I1ac55qL8GEUYYRLtsXVb1n2g1NS1r/z/arXWYt7xCNIOwiq+dDqD6EoOZKLete46xkhR4DkifW0BlSr0rehOOfoZ3VxO2XCd79p1DMpsprCVZdZcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824212; c=relaxed/simple;
	bh=hhCGP+elbwiFpDLMjGQ0v6kHZLI7g9lbZpFRjPg9ulw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBeS06Yc2rzFQD3YL5HW3AuJj5LzOb6zxbeMmWSFj7ugEV6Ss69yUWN0/O8DsuqysEKcsRiCkiLrAAwE9G4v8LFszhEy9BmLZUYASnIF3ginkhLz33Qva+uhvR6W27rCzhnF9lv3xs7K1TbFs+gboF83ZxogfQ4NEqsa+PO4VVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oce5n6oJ; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyGM5OCH90HxF/TIPAx96cUZ95sj3o9YM4FNTnvIqUHarjHWphctca/yiW462yT0FqCN44r4j7N3frHehWRXXgHkZJ1+2TkQAs6lIwWzKVKrJc1x0kJeMbtLCdriUI8kbXZJ+6HTAy50d6ankZHdE6PuQOZIUuU9FIZs1Pr8Ac1w4SVERr1YSBufU9P9MbrHQSQL8PBIVHXesNMv1s0uUvCG3M3RsSQ4YT6zVsHXUg4NNRShuUf9he3INkog2VaLDPuYE+dUC670ln97NKSQE8WjVc0gfZ2uwBrInDh8hPcSShzv00/I+aaXgF/C0/nco8KtSenUyld1YaUlKzlumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhCGP+elbwiFpDLMjGQ0v6kHZLI7g9lbZpFRjPg9ulw=;
 b=g+OHARbUQSQg8hc3JZT73I9b+Nhegc+xB75vsRLNtOcygsB+K7b9O0EllrOyQzgdzywbUVcDcKPOe2CMxTfOOqSH1926efKif5JYlTf1jFyY1iGrmecLccpCl5kjWcBGHzJtlcwHkXBf5tFimnHsthyODVTTpNZcJAGktW7frUcJt4aO32VeOAh2seu8yRCW+fzfKG6dyyF42VEzA3wvzHlIZi7oMORccrFtfC1CN2ALHojwx5nIoxAJimnUnR1iUHYX8LBk5p6pAaQc1aqYJp7noiNPr5ZjTexdQcGaOeQTgWvOuCqc7JdIqEP6YJl8Rr4oYMN5d4LYOGQ53fmM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhCGP+elbwiFpDLMjGQ0v6kHZLI7g9lbZpFRjPg9ulw=;
 b=Oce5n6oJGwVqyjTKoWn9UbwNdz3D3QYUmUIJIdviNGM4y6y81cX/AitTa6tkXbRUuqdwK9PI0X3ROjJfWzBfauck/vYZVkMfyE9zvOHfzi3ZmoKTpFSJnIg+cAa8VxpdBytHQ6V7jbIU3J+Kalvcvads/QRDjb1L2uZNGIb4h70j0AaphMLde7bYufySa/dRvWwCFzS9YJY39e5vTEf1VtTjxkUUbFK/njhKzp8DCfvVjvDOhGOx7uNjVEVHfb+01JpXaGDyo78dlOi50TAcl0epPiaX/I5Nde+mWaxjBGaecC79KUHHllO/PCCQX/GR4Bi341yV9Ehx2J/LKDcd4A==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 08:56:48 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:56:47 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [PATCH ethtool] cmis: Fix incorrect LSB field used for wavelength
 tolerance
Thread-Topic: [PATCH ethtool] cmis: Fix incorrect LSB field used for
 wavelength tolerance
Thread-Index: AQHctrIDn3nkG/yjxECNYGxRUNtZmbWz+0jg
Date: Wed, 18 Mar 2026 08:56:47 +0000
Message-ID:
 <DM6PR12MB451699CF526A71A2B2AD4619D84EA@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260318083401.375458-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260318083401.375458-1-alok.a.tiwari@oracle.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB8308:EE_
x-ms-office365-filtering-correlation-id: 604ab3c1-134b-4b97-80c1-08de84cc49a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 LxAhI/XpSSspEUn+Miv6c7iwp0bcg33W0FSJIskA+F633lElR6Wdn0fSiO4VroibJupBF2wX6Wbk3d8r8GeHuffaOzQFi5JW682H5VSxktBM3L+dYZwKtEtxoiNvQ8BlWOnUqZoSqco9shoPsDgjgDJcJMyQPLQOQymWvMt0UJe2Gv5QuWhsUiBY60k5bs56xxWPWLw7usoNQAWHl23a/gnwRIRq0oRTUuCOsSuDK9atNwhzTlEb5bfyxQMczM4MFaYY4LBC4zDclrG7YIQZP2ulfJqlgjzkqT8cuje7lYSFF78uQETxomNEWQiPw6JRp3ybT5wkWK9oW5J916qZeRXlMjWspokZYvss6foqgHJVeaAE5yA75y0sdxaIBFtMtmUFI9es7CKydqAm3zb49AdFDLIVSO/cd5t3JVpA7YAyeNtLNvEwYk3H3w6eYR2YvBP7JJ32blzOOTC8k+xjo3Y8PiiAlIlOk2uA6WqQpjYcp1zGj3WSjVLpCtuTbYhglzK7ELCfUpEMkYjX3JRmFK+R5fMZtidvpUXzfYhTuoTn94tWqMM2puiugraTnmUc5p0EaOMZ5EPHbTTgsUdQx2MgNa1rGSF1zh0RPmLLJvwHV3dELVrbdhA0NKUThyDhxYMcyTByDrsWbmgIqMhzaph10bsomqMMFlc+51/dk0kx2RirasWq0dypVeyU6w8rp0jyFXNP59yYavW3Hq4pEl0pMzFpoqePKUuN5TcejhWnEe5UBR8FChcEhRtsRQa6xFaeiaZomrYohdTkrWZAYTTU5GdLpt8Rbh1+EZL+dII=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MThmenpaSW1PSzRxY2Y1YTQ2OUNqR3ZvcWxtUzRNdW51M2VlS1oxL1dWR2ty?=
 =?utf-8?B?WWdSZDhGU0tHNWI1dUNhV2w0YUdpUVdHNzFvbnViekZ5K1dMcXUreTBFWVhF?=
 =?utf-8?B?T1NrV1o4cmE0dmVtQ0lPSWlnVEh4WGZjM0l0eThmUlNsY1ZvOElXV1lDc0Zm?=
 =?utf-8?B?MHNBRXEzRUllNkJtdWNWelhVcFpJbnZRS1dZYVpiWERPeFY5cVc5VDIxd3o1?=
 =?utf-8?B?Z1NIMUw3clhWZVNnc1FUK3ZTUWlzRFdNQjFwbXN6Y0Q1VWlCRDJwczg0SkF6?=
 =?utf-8?B?YU80eHBhVDFUQkhKdm9wYS9VUXRwOE9uWVBQR3RXUkRSc3QrQ2R2Si81YzR6?=
 =?utf-8?B?NzQ5bkEyNjlTNklwb2NwdWFWeE52L1lRQVhtVnVCcU93Zy95bHlsdlZwV2g2?=
 =?utf-8?B?YVF2WFhYM2VYa2xyVGxPUVdic0lnZGFPTHdWT2ljamFSd3RmMmdZd0RkbGhL?=
 =?utf-8?B?b1QzTHhTamJrNkRTN1hYT09taU5hdjdkblFRZHZTWE53a3pmenJrbUJKVmxk?=
 =?utf-8?B?ekE3d2Y5aWJkKzkxdTNGQ2dsVitTWlh5S2pxOWV3bEJKZ1FmcGU4SUpyUjZv?=
 =?utf-8?B?V2RMbVdpRzk3SUxDdVgvSmF5MWdoMTJBaUNCQWs5Wms4YVZrdkFSUHdkYndV?=
 =?utf-8?B?aXZ3V3hJOEZzOWRDaHlROEFuMnhabUtDUnZqZTdUdDJMYXR4dXJkVy9EeHlB?=
 =?utf-8?B?bGplWFV5WE4yVm9CMHgrVFhvRlZHTXg1amttVWVvL0tNTzBrT3ArZkJQWkhL?=
 =?utf-8?B?REI0NXc5UWhqZ0JVNHhTNUp5UjNEOEkwNXVGeXozZFAzVFZvUlNlR1pZRHpw?=
 =?utf-8?B?dVpmS1AyRGJzWkpzYkZpVTAwclVScjFMTG9mbm9aUzZ5UTc1VmlBcjVkVWNP?=
 =?utf-8?B?SnFWU1k1M1dyQ2s4RXhJa1ZLT3E4SjVCcU1pbFdsT3diQTlLZFc0YVhsZ1BO?=
 =?utf-8?B?SkhxUTdrS1BmeWh5aUFrS0phK2NRbUthYnhIQ0VUQWJzaGVwVGt6OE9GZjJo?=
 =?utf-8?B?TWRjRWtRVzI3WjRoRFdFM1JIeXM2WmxXSzFQWHBjVmNDRFB6WEFMWDR6L29q?=
 =?utf-8?B?STVVNU5Sb2pTaFVhNms0UDgyUHo4bDBSVW9mdyswQlpCMTN3VUdiWTQzaENX?=
 =?utf-8?B?aHhlY1h6YUUwUXlrbVZiK3pGMU01aGdnbWJSVDRvZk9YYnZIb0F3YTNqOTNV?=
 =?utf-8?B?YlJROEwzcHdOYmUzZStuRXkxUkZ6Vlp1V05IWk5rbVcvN1hLa0dxVHZQV0k2?=
 =?utf-8?B?NklYRlg2YjNqaE9aNmJUdUVXb2dNb1Zhemw3cVVDZzRYcGhrQWc0cEtubDc0?=
 =?utf-8?B?NWpQb1BHbnpxM3NiOVJaVWQ3SytWcGh1b1dSbHBWN3I2YVptTmF1aitNWitR?=
 =?utf-8?B?RVhMME1nQytnYkY0UVRBNjI5d1htZUpYWk50bVhuU3ZzUmtrVkx0NVBTa1VR?=
 =?utf-8?B?aDlqeXNOWGJhbk05Z2xnWDY1SDNycFhJUGNMUHl1VWQ0dWJCRmRmVjBVbEVD?=
 =?utf-8?B?VSs3cEVwRUlPbGdaRUdRSXZqOTZDc2pOcGliVzIwUEtuOHc5eVNQWUVhdWxO?=
 =?utf-8?B?VnM3ZVFkZU1UL3NVYzlPU0RCLzFEQSttdjZ0L3ZjS3U0djJ1OU8zYUdub0JN?=
 =?utf-8?B?U3dIclkxN09hVXpYWlZRc0M1eElYSGwvUEgzQ1oyTm1BKzlzRXdIWWY3NjNm?=
 =?utf-8?B?MFVlOFB0ZjN5SXAvQXdNL3NzNjE4aHZMT3JiYmNKS2lTTVFQdjFFVW1ldHFw?=
 =?utf-8?B?YWdzcTd2bDBncmk2eXNUUUZFdXlheUszMExqNEdZOTZKaE5GQ3doM25SRm1t?=
 =?utf-8?B?OFBBUkoyNmlFcUxrLzVvWktaNmtoZms4K2dkeFpIenlLek1KQlFENUJPT2sw?=
 =?utf-8?B?MWJBbGRHRFZXZHRKWE1oWTJLbllKTXpqSlpKYlRwSUQxNDRTSkpuNVBsS3lj?=
 =?utf-8?B?VXpoMWJ3S0szU1dkTGlkRFpuTWpDWVVTRW8rTHhoQUMvZkd5UGQ2TS9hV2M5?=
 =?utf-8?B?bGQ3WjN2S2pKMUxRdi9DTi9IUzl6aWxWZ2cwb1RIaUQyNlpTZXRxc25YZGxI?=
 =?utf-8?B?UmI5NlJKR0tKWm5oT1Nzd25wUVhWVk1zdm5EN0RXaU13N0Z5Z3l6bTQrNUpO?=
 =?utf-8?B?TjhhNG5PNy9YcjBaaWt6U1ZRd2RwamJwQkRLZGxvemFZUVVhVXRJZC91a0c1?=
 =?utf-8?B?YWcvRUticnJuSXNLZkx1TXhiMndCcjNVTFpXRU84UWRQQUwwbXJtYmlvQ0RO?=
 =?utf-8?B?ZDR4NVhpZUJTenZyU2VTZXFHTmI3Y2IwSkVTM21XNmNSS0RXem1ibEhMazFN?=
 =?utf-8?Q?70YGJShGreNUcFzuKi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 604ab3c1-134b-4b97-80c1-08de84cc49a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:56:47.6875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sB6qkgMvAQQVrH4aE9B7UaQPwN4bd0UJIUnvl2DeZONb7NtKjo/IOgfU/wWIC5N+W6ELUOUT8l2CJT0L7gVaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268928-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 22E292B88FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbG9rIFRpd2FyaSA8YWxvay5h
LnRpd2FyaUBvcmFjbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDE4IE1hcmNoIDIwMjYgMTA6
MzQNCj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+OyBrdWJhQGtl
cm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2UuY3oNCj4g
Q2M6IGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbTsgYWxvay5hLnRpd2FyaWxpbnV4QGdtYWlsLmNv
bQ0KPiBTdWJqZWN0OiBbUEFUQ0ggZXRodG9vbF0gY21pczogRml4IGluY29ycmVjdCBMU0IgZmll
bGQgdXNlZCBmb3Igd2F2ZWxlbmd0aA0KPiB0b2xlcmFuY2UNCj4gDQo+IFRoZSB3YXZlbGVuZ3Ro
IHRvbGVyYW5jZSBjYWxjdWxhdGlvbiBtaXN0YWtlbmx5IHVzZXMgdGhlIG5vbWluYWwgd2F2ZWxl
bmd0aA0KPiBMU0IgZmllbGQgKENNSVNfTk9NX1dBVkVMRU5HVEhfTFNCKSBpbnN0ZWFkIG9mIHRo
ZSBjb3JyZWN0IHRvbGVyYW5jZSBMU0INCj4gZmllbGQgKENNSVNfV0FWRUxFTkdUSF9UT0xfTFNC
KS4gVGhpcyBjYXVzZXMgaW5jb3JyZWN0IHZhbHVlcyB0byBiZQ0KPiByZXBvcnRlZCBmb3IgdGhl
ICJMYXNlciB3YXZlbGVuZ3RoIHRvbGVyYW5jZSIuDQo+IA0KPiBVc2UgQ01JU19OT01fV0FWRUxF
TkdUSF9MU0IgLT4gQ01JU19XQVZFTEVOR1RIX1RPTF9MU0IuDQo+IA0KPiBGaXhlczogMzQ0OGEy
ZjczZTc3ICgiY21pczogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nIHRvIC0tbW9kdWxlLWluZm8g
aW4gQ01JUw0KPiBtb2R1bGVzIikNCj4gU2lnbmVkLW9mZi1ieTogQWxvayBUaXdhcmkgPGFsb2su
YS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBjbWlzLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9jbWlzLmMgYi9jbWlzLmMNCj4gaW5kZXggMzA1ODE0Yy4uMzQ1Y2UxYyAxMDA2NDQNCj4gLS0t
IGEvY21pcy5jDQo+ICsrKyBiL2NtaXMuYw0KPiBAQCAtMjc2LDcgKzI3Niw3IEBAIHN0YXRpYyB2
b2lkIGNtaXNfc2hvd19taXRfY29tcGxpYW5jZShjb25zdCBzdHJ1Y3QNCj4gY21pc19tZW1vcnlf
bWFwICptYXApDQo+ICAJCQkJICAgICAgICJubSIpOw0KPiAgCQltb2R1bGVfcHJpbnRfYW55X2Zs
b2F0KCJMYXNlciB3YXZlbGVuZ3RoIHRvbGVyYW5jZSIsDQo+ICAJCQkJICAgICAgICgoKG1hcC0N
Cj4gPnBhZ2VfMDFoW0NNSVNfV0FWRUxFTkdUSF9UT0xfTVNCXSA8PCA4KSB8DQo+IC0JCQkJICAg
ICAgICBtYXAtDQo+ID5wYWdlXzAxaFtDTUlTX05PTV9XQVZFTEVOR1RIX0xTQl0pICogMC4wNSks
DQo+ICsJCQkJICAgICAgICBtYXAtDQo+ID5wYWdlXzAxaFtDTUlTX1dBVkVMRU5HVEhfVE9MX0xT
Ql0pICogMC4wNSksDQo+ICAJCQkJICAgICAgICJubSIpOw0KDQpIaSwgdGhhbmtzIGZvciBub3Rp
Y2luZyB0aGlzIQ0KQnV0IGFjdHVhbGx5IHRoZSBvcmlnaW5hbCBjb2RlIHdhczoNCg0KcHJpbnRm
KCJcdCUtNDFzIDogJS4zbGZubVxuIiwgIkxhc2VyIHdhdmVsZW5ndGggdG9sZXJhbmNlIiwNCiAg
ICAgICAgICAgKCgobWFwLT5wYWdlXzAxaFtDTUlTX1dBVkVMRU5HVEhfVE9MX01TQl0gPDwgOCkg
fA0KICAgICAgICAgICBtYXAtPnBhZ2VfMDFoW0NNSVNfV0FWRUxFTkdUSF9UT0xfTFNCXSkgKiAw
LjAwNSkpOw0KDQpTbyBtYXliZSB1c2UgdGhlIG9yaWdpbmFsIHdheSBpbnN0ZWFkLCBhbmQgbXVs
dGlwbHkgYnkgMC4wMDU/DQoNCj4gIAl9DQo+ICB9DQo+IC0tDQo+IDIuNTAuMQ0KDQo=

