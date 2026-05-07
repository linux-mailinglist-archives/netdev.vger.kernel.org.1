Return-Path: <netdev+bounces-285441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PaxLr7J/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7D4ECCCC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A373021E71
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90B36AB53;
	Thu,  7 May 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGmiSIAt"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFB283FDC
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174351; cv=fail; b=KGx5NZjsm21IulXNLnyjZz7rtM7vlHMZ2pgew4FoiKLo0UamfI6ms9Y+358QBmmykveo1/Xi79R28hI7mTJDcWgt2kxz5SD3N/KvdMwQazvp0FSHpDX6ypV7KK21rN5+hZ+ehZsEPcG8DbyZsjSV8yoLHkbr0iN0Jgp8RyZx66Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174351; c=relaxed/simple;
	bh=Cu0uAcZjT1594XFZ7zzW6u473lxIR8SlHp9++93CJRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bF1qgaV7wLbf/w6DBmFRaW5h6+Fgpalzoio3Em5Sc1NtMOwzeNcZks2zHCbFqTOpN2HveobqhlnOUUywh3AYwydVKlhU49NePJpiKQcFMfJR64fCn2y1tF6naIEyTuAlFbL/nfxd85lijka7uDG7pUX3zbXCnefSLV6AUT9eiG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGmiSIAt; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQfmoqXH78HvaWcwa2srOryO8BLbOsvl2UTeJyKzXNZrQcTw1fNr+eE/3D3lR7ygjAlwawpvxVR6aedZux4CfVwhxkJDhPgLOTlMR1vzQRQTVNAqBGJ0US36xtLUb75GkxiHPN6lKnIOW2ezT555viAhIXHTZ6FT2U8PsyeO9tHYSyAbJqKE5B2yLe6hEW3os1/gsG5R+Bz7+1eZH9LPvk/S9nhzpqJRsGBl4cMUTAM0e3YvmOUNC4CoXsfOLlbexQs/BgC6v0CMvpWI7WpJBfn6A18SWUocKSwYWB/90s/5+hhMXeSKfVg/ZZ7+ykiXDFG0SX9l0ZzORm1XvsXL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu0uAcZjT1594XFZ7zzW6u473lxIR8SlHp9++93CJRY=;
 b=yVYRatRWX1tHefL9sTNQVinWRzTeolVy/lbtGeP926hm8kWoju0yLzFHgNcQC3omBfkPyrAZn75rvJBYNyolaig9PRKYmEuYfTYgTa0He7eQC7+XN5efTr3232jgULfoAA70ybVRmhyFInKHRu3XsqEV7kmt4WsoyaO2NSoZN2n0pMhD+hZgxDjkUL/1TmFKHGQJfW6PwCItSeS/K4uCkbmaE3+H0cr20NvsBOoKq940Mo54VaQl93R+0WDxDwgcVuwO5umMJdyo+NR5EevddHQ0Nf59ok6MXhJela6qcJDQAw8LapMzEE1qSRampPQQgTtjDpvLDAlZoeFyTfpElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu0uAcZjT1594XFZ7zzW6u473lxIR8SlHp9++93CJRY=;
 b=tGmiSIAtPqkEgP+g0Vg1juqc1u5ADfieJ7rA0057FI8+bnZgF9IyYRl35QkYx9fp6UDBbf6VhPKjbXxavqknlPD0F+x5t8Fh2zQyn55Rzd1pVccgTgOJIZMg+1LfYKWij/PseLIqZ3IPxXrd1Q4eoVHLVZA5FkKkn7WrkPHBcM3YfVsMBIMVFMe5O1IdZxRRta0+1KWdDH/0/Km/6OwGslBp4dJovUG2+9j/4Fqx4u/J995TnsTiy56PSiUGplElFHeh4b5sJjOmnnBSAx7r6dCI3kgRO8/JvHNkOSpBvJcIt+F9iND4oTPCgQ5MHuIP/CIis6u2/AAa32HOziHsTA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 17:19:06 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 17:19:06 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Thread-Topic: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Thread-Index: AQHc3hdcxkfOfhDidEaoBf2siAMPrrYCfFcAgABRfXA=
Date: Thu, 7 May 2026 17:19:06 +0000
Message-ID:
 <DM6PR12MB45165B477AA4E68452864B4CD83C2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260507114721.3409128-1-danieller@nvidia.com>
 <5114542a-7c7f-4759-b13d-6873494944c6@lunn.ch>
In-Reply-To: <5114542a-7c7f-4759-b13d-6873494944c6@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA3PR12MB8439:EE_
x-ms-office365-filtering-correlation-id: 29e27beb-6cdd-4a4f-6a06-08deac5cbe4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003|3023799003;
x-microsoft-antispam-message-info:
 084T3pGHBvT10u1JIAKE+AhaFHvDqyy71XaLoLJQl8NEMAc+ZLqtE1uGwGGKCp9Ao/UUozDSUEuwVdDmbPJ+F9xB+p+0VqvA0yl6/xzEnAprX0R0XwcJVcw6w0npl3PbayJzQDRpdf15fBdFMXe+IebafSO3XPgKYCkFjxXfgXhvgV6Mhad+YoXgA4tJ8e6uL5RtxYi33GBf2O5fbST4yQvOd/yM8oza+Yr80SpSMWlgTNgewkQNXBgJVQsfyVk5DhcEfuPgWY1KV0w3k+63B79NeB6DBJf2JvrYBCkMzxvYdg0MDHUC7VQkFWn9h3uDYqf6T1bOeIXOCBDlDHi+Trc7/6Byg0PfrTNlRI+RfD9NUEfTebOxbS8WzLPhda5fFIpT5QMQvVHZWsxYLX2VFZSSf5jLJuTeJWmR799uCI33byp6rWRrr8X1e4ZgTVCNUrKeMcqRosVC07SuB5ArVzvEoiMFJV9Tb7TbMKRt6BbqwNZLahvxcy1hCdo7JU+O/0uuEq5Iu7ummbhPW4DxtUjawPX8rbhn4KZFKDWhJm2BQK0NVsLQhS0OpBbXa3zVg8lFLULAe3PqKWXnlld0LMVqndjqBtRryc0hYGF7eyInUNdbKe2Y/RI51a3Yd6moKHFsTrHUcQ1roORjYFcFMuR5fRBH4ZGfNI0kQyIt//+zFvx1WglGGED8O9yILSm39O2726kRrBmYY1LtVRF21bPcyU7vgkwnoFiK9OrJ+znJxN4AdmD08UudG4HSk9UI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm50NFI5TENqNW9IRFM3encvSzIzYmk3V1N0SHM4UytLaE9QMnl6eTRzMUJF?=
 =?utf-8?B?aFgzZUpIaVdLQmR0ZFQ2alR1SHErL3NUTjg4YXoybWpUMDhLNlp5R1psY0dC?=
 =?utf-8?B?dUJDdTVhUHhFVTE5T2RQRGhseXZYRTRKYmgwdVU5VVUrQkhkZS9FcXN0by8x?=
 =?utf-8?B?KzA2UWtSS0Rla2lkSHZsdkJHUGlyRjFDdWt6bFRtbDRIRVN0bVRRNlFQNDVv?=
 =?utf-8?B?N2RPZGU0RFdqNmFkc1k3R1M5cWxUWk15MVBNSFBlZFN2RjlGRlp6Y29CVDdq?=
 =?utf-8?B?ODhGVi9FSjhyUS9XWVVyUDN5dDRFOTFTWGRORVRpZm02dFhTVTA2enpudWtD?=
 =?utf-8?B?aHg2WDFTT013a1UyMmdYeFlvRk5wWlFpR2xNZXdXU1VrQ3BKNkZvdVRPUith?=
 =?utf-8?B?MnBmTGx5eUVYK294d1ZFZGpySmgrMm9TZG5ZUkhGdzYwa2RWRzYxaXpac2Rx?=
 =?utf-8?B?cmFIanZqL3lPNExmYUdwY3ZKUncxRWZVUHdwVmVRNnNwZjZ5dURiL3pPMDNr?=
 =?utf-8?B?M2drNEVWN1d6a0JMNlRLRGJOa2ExLytzbThuSVJqemMrMCtIZHBvZFJqa2dI?=
 =?utf-8?B?YjRsbHNQZ3ppSWFsNSs3SFYwRzlYUW5zYmlzTkRrZEpMSExHWVlRRzQ1M1Z5?=
 =?utf-8?B?c05wRFd4c0Y1OWNwdjVWK1VybGp6RXEreGI3UXVaNThEaXcySlRaYzFCSEMw?=
 =?utf-8?B?NWhtSUJCejNUa1M3bE5GUUMxbFo3cUc0NFF3S2R4a21kaUg1Mmd5MWYyV2U1?=
 =?utf-8?B?OFBLMkR2ZXh1N0RCTnVyZnRVVVh5WDIwQ0trS3lFYTFoTTVCMjA4RUNQT2c4?=
 =?utf-8?B?WmZmeXNFUDkyR0JOVHF6Rjc2eDd4LzdpYmlBdXZPZVAxa0h6b3d3ZWVlU2Np?=
 =?utf-8?B?SHQzUi9NVDdqUXJNQWZjWXBrZ2pBQVFwU0p0dWxnVVpCRktKd1pvYUlQck4y?=
 =?utf-8?B?a1FEdC9tY2Y5TEJyMGttYlBjblJpZmhzaEpGa0tsTmh3UEl5eDVXaElaNWIy?=
 =?utf-8?B?VzJoYzFPK3VHUklMK3VHb0Q4ZnBLdmNmUTNIakoxaXNzc3J6blRRbmt3ME5P?=
 =?utf-8?B?Qk82MFY0cVdUdGFxZFJWV05POWdEWlpuQ2h6amhEVXY3em5YQ0taZWYyUGJW?=
 =?utf-8?B?dFRDQXJnK0llMDlUV0V6OWJVK1ZqNkphc2JIR0xvYjMxYkFkdVdKQXBQcFdx?=
 =?utf-8?B?V3ZyQ1ZOVkU5aEdMb2VEUVY1UmFyeGMwYnAxYUZYQ09BRjdaeVQ4RUxneG5n?=
 =?utf-8?B?SWNRQUlUd2w4dDF6K0Fldy9iM092TmlpdWx0THZwZUk2YWFBWHUweUFLNjVx?=
 =?utf-8?B?QWN1QytVck8yT3AvUWxzejJMd3FyMDBMMEhuZG9EbjdBZUs5UzJZczVEbllo?=
 =?utf-8?B?OXVid3RrclcvUVB1WGh4aTZlenZQV1dITC9vZ2JHNXpEZ2JwUVcvM09HVmd3?=
 =?utf-8?B?UFZNaUZPTzRTaHRxbFNJODRhbzhQbU9LL2M5SkcwT3JXSEhpQVZqMzdad2Zv?=
 =?utf-8?B?dTN0YXJMcTZVWEhna3NaTXl1dSszUXVtZ3FFc2QxbVlyRFM2cVhNQlJ1MUpX?=
 =?utf-8?B?UiszZkF6Um9HRWlLV29Sa01PcnFKL1ZRaHBXRVJYaG9kMFdyczlUeENhTnBD?=
 =?utf-8?B?dUFUMzBPVnZTU2owU0Fjc2dSYzJSbnVqM0tDczZNZWR5U0d6Q1VyWEpGWVNs?=
 =?utf-8?B?R3Y2SWFBeGE1ckJadTVvaC92MFJ0MkFEeWJMT3pMRlVKZkpmd1p1RmY4Qzht?=
 =?utf-8?B?QWQ4RnorOEhJQncxR0lkMHR0cUZkT1crSUZPM05FY2tvM3A3aXVtT2hnUTQr?=
 =?utf-8?B?K056aGxsN1hQVWVhVmdrNGsvbGQrYUtiNk9VVnVrbFRxR2Y0RUhLbFcvNGoz?=
 =?utf-8?B?bWJscG8xYWZXcHVwdXRxdWJMNDlSNmV4ZjcvVURiRDlJbkR4eHVod2dmbWFF?=
 =?utf-8?B?ZVVrME1TR0M1c2VVWmI3Y3k2cSt3TlFqb2lqWXh6UEJhQWcyL3FDMFgxVVZl?=
 =?utf-8?B?eUl3d2w1QkZEbG40NjRpUk5Ya3NBRlN4TnRTQ3NnSTRaZWpJREUraFIzdThL?=
 =?utf-8?B?a2VjdW5Tc3NvVFZWeHJTOC9UTllyeFRWYzYvRWg0WlhlRHIweXFOZ0QzdjIy?=
 =?utf-8?B?WUlyWUd6UmMzMUliUm5ZcTVHYXBYOWhJSjFCeVlFZUZ0VlFMQnVUTlVQUmdR?=
 =?utf-8?B?bEJJZFpHclZyS0g1LzZiWW5VUmI3L2ltMGVuVHpjL3pUUTZ5bmlqUXdCaEQ3?=
 =?utf-8?B?cDhDQklUZTd1UFhKcHJEMlhnbEtJQWpWcEZYM2lvZ0VxQitQeVJJS04zUUh4?=
 =?utf-8?Q?0M4Cnc8LsrbJGB6nIu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e27beb-6cdd-4a4f-6a06-08deac5cbe4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 17:19:06.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYblRkSpSirw8oRIDVnH/7pedr1EEQTm9114fMc3oIR3vdqXk9IaM/HUm/gvfvoc9cAjtFsxJBmCtYak8xdkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
X-Rspamd-Queue-Id: 0AD7D4ECCCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285441-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,suse.cz:email,lunn.ch:email]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFRodXJzZGF5LCA3IE1heSAyMDI2IDE1OjIzDQo+IFRvOiBEYW5p
ZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbWt1YmVjZWtAc3VzZS5jejsgSWRvIFNjaGltbWVsDQo+IDxpZG9zY2hAbnZpZGlh
LmNvbT47IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBldGh0b29sLW5leHQgMC81XSBldGh0b29sOiBBZGQgJ3BhZ2VzIG9ufG9mZicgb3B0aW9u
IGZvcg0KPiBtb2R1bGUgRUVST00gaGV4IGR1bXANCj4gDQo+ID4gSW4gcHJhY3RpY2UsIGJvdGgg
b3V0cHV0cyBhcmUgb2Z0ZW4gbmVlZGVkIHRvZ2V0aGVyIGZvciBvZmZsaW5lIGRlYnVnZ2luZzoN
Cj4gDQo+ID4gT3V0cHV0IGV4YW1wbGUgKHZhbHVlcyB6ZXJvZWQgdG8gb21pdCB2ZW5kb3Itc3Bl
Y2lmaWMgaWRlbnRpZmllcnMpOg0KPiA+DQo+ID4gJCBldGh0b29sIC1tIHN3cDYxIGhleCBvbiBw
YWdlcyBvbg0KPiA+IFBhZ2U6IDB4MA0KPiA+DQo+ID4gT2Zmc2V0ICAgICAgICAgIFZhbHVlcw0K
PiA+IC0tLS0tLSAgICAgICAgICAtLS0tLS0NCj4gPiAweDAwMDA6ICAgICAgICAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiAweDAwMTA6ICAgICAg
ICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiAw
eDAwMjA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDANCj4gPiAweDAwMzA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDANCj4gPiAweDAwNDA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiAweDAwNTA6ICAgICAgICAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiAweDAwNjA6ICAg
ICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4g
PiAweDAwNzA6ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDANCj4gPg0KPiA+IFBhZ2U6IDB4MA0KPiANCj4gTWF5YmUgYWxzbyBhZGQgSlNPTj8g
VGhhdCB3b3VsZCBtYWtlIG1hY2hpbmUgcGFyc2luZyBvZiB0aGlzIGVhc2llci4NCj4gDQo+IAlB
bmRyZXcNCg0KSGksIA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCkkgY2FuIGFkZCBKU09O
LCBidXQgaWxsIGNoZWNrIGl0IGRvZXNu4oCZdCBleHBhbmQgdGhlIHNjb3BlIG9mIHRoaXMgc2V0
IHRvbyBtdWNoLiBPdGhlcndpc2UsIEkgdGhpbmsgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGhhdmUg
YW5vdGhlciBzZXJpZXMgZm9yIHRoYXQuDQoNClRoYW5rcywNCkRhbmllbGxlDQo=

