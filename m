Return-Path: <netdev+bounces-227758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3890BB6AFF
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8407842778D
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9B2EF65A;
	Fri,  3 Oct 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4zW6Exfd"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D813C3F2;
	Fri,  3 Oct 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496386; cv=fail; b=O1SaqzeezBuNcSxmhiBHYlLwhR42NIP+eP68lOFajLIbvBMlbP97132DZnUlBUK0Zp6NrzXUtWODuIseHRpRSQkwKrXSyUXDSytNTWZNal4IUzuC+Iies5nbG87DkhcuNoDVKsGgDfumkjdxSGt1NxUwbxNVRAdGIkbJui+K/1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496386; c=relaxed/simple;
	bh=+zn4Y4eyoKjV9ThoYk6nibrxdegzlaWH37KppwOslpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMS8QmbnGsxacTAe3GfJyzGfl824xF2PA6X8Ps89ltPd/wkAj/gikKFGaMCCSCkopRn84KJTxj5xjLAU0GHVt2/54eBJQYlYAnGdsbCEAm82W3MnBhZvWESgYAE1LQgMcPWFIwA8D1bOPvZ0x02OsItilaZBDLQBE2uM0no4BhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4zW6Exfd; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+2fyhH4fkzMQVi0x9iY8pyLrNGml4DAkY50SWysNS9JWwWOuvd2AaxjWwf+zJNP952t8q3lmy6GltrJTpA87DzNrwVVyWIVSt+pJKJKXcSUi8Kof3UfBifNMQQ9ET6EFLtqLsorXmShcdCSHuu9D72F+5mtKtOT74kPn8mrR/ML6DW7zvEtl66B3HNjkX8s/jBkjYjpwShRSGJ0Vw575RS3Bvcq0dGkn6k9n9JCYJ1JH7Ty1QixTAjEBfi29Y/Mbt4L5CBe6rwEnTVq1mzsZlLA2rsDmObJocTE5/1VBMA+2+x8zlbQ4kwnx1hdZE9/Gsngd1XKRXcdq+MbvKBDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zn4Y4eyoKjV9ThoYk6nibrxdegzlaWH37KppwOslpw=;
 b=Lauem5gbV5KQESvygQZ/Bfd32SCmvHwgEgD+YY6+rLd8oJwlEmAwvXtpbjbKmtkmB4tgtlc5La0HKPZaBSProTZI0A3Oe4BJsBImCWsZABGOtsLy8WakLfo6fB9W7pkctIb0g7XcQJ4x4T3gh8VytES41ch8JqnLSwJNY468RQJ9FzF6Q80TCkOTFPpz+UbamV95MEWsflHMIOROJ0ubpmunCbo3iRR3xSAUFT1+PHbmSLcxjgcyfIhhnA+tieZc9v/3B1OGUwaGNiHSuYPcnfaKrLsGluMpVloVEQqw4SmTyHjrH9WZzXFpjsJ8uvZ2g2VRF52UvU1oHb5X9s5qsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zn4Y4eyoKjV9ThoYk6nibrxdegzlaWH37KppwOslpw=;
 b=4zW6ExfdLFQ+ArAaqOk8neQsrqQHm0KTrKsvLK+z5iCffbsxxtCItsLA3U2lGZnv0i18V8oCO/ytQHjxt1I9wpTQg8ibu8YduDyMkCrAFJOXAHnupqXrk9upd052EwDGtlGCtHPwrtFFa9bHwUvoBF0d2E27EwP9GvTivQ/UxCeiK68mLvFOLzqHgAgaPmsfutXSm9EeXpD1+CI5azkIt12Y7iiMi+hbTDIEYEnq+mI2Z2ybc07O7hnNsRimDWC6sp1y/qNfpf1NKU+gRXT822q+GkIxNidAa17uLi1Bq/KovG5UqywaeMc28WNhtqjhw7tdpFs5XQ6yMA6geluFSg==
Received: from DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) by
 PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 3 Oct
 2025 12:59:40 +0000
Received: from DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559]) by DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 12:59:40 +0000
From: <Divya.Koppera@microchip.com>
To: <josef@raschen.org>, <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Thread-Topic: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Thread-Index: AQHcLl6B38r4+cWxO0ijQ23prCCi/LSkctsAgAGIagCAAAYcAIAEkOaAgAXUmyA=
Date: Fri, 3 Oct 2025 12:59:40 +0000
Message-ID:
 <DS7PR11MB6102D0B2985344C770AEC293E2E4A@DS7PR11MB6102.namprd11.prod.outlook.com>
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
 <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
 <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
 <fbe66b6d-2517-4a6b-8bd2-ec6d94b8dc8e@raschen.org>
In-Reply-To: <fbe66b6d-2517-4a6b-8bd2-ec6d94b8dc8e@raschen.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6102:EE_|PH7PR11MB6473:EE_
x-ms-office365-filtering-correlation-id: 0b2267aa-f848-453d-1dc2-08de027cb729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFVGUHcxVndRemh3aEY1dFk4WHdXck9NTmxKWE1ZZXNIWkxCNzNmWmVpbjlR?=
 =?utf-8?B?NS9Xd3hXRzZSM0NldmFHQ0RKczgvei9URzkyeXpXQjY2L2RKR1hJS0F3MTJz?=
 =?utf-8?B?RFFLYXh2L1RHamdRUDVhVFZWemZCMWM5N2Y0QS80VHpYYWhUM2xnM096VUFw?=
 =?utf-8?B?dm92Yk15L2x5cC9uaFRDb3RQL3pSM2plSUpMSkxsUFJUekFwVUpSTlRFOW4z?=
 =?utf-8?B?UkN3RnNraXhVamdVM2FLT1B1MWVReFVtdVo1UURTWW8zVWJadDU4V2VYWTdo?=
 =?utf-8?B?QUZ0bHB0YThsR3lYWk90MkVsVFJLSkxZOHdUWU5XOUxmM3dxSWhvNVFGWjdY?=
 =?utf-8?B?cW50RUNseWFtRm16Y3BURG9wWjR3MEdtS0RORU0xWk1hRDQ2ZGtLa3M3dzNq?=
 =?utf-8?B?S3VxVkR2cTVzSFZJbitJSjlhUW9SdjZEREppdUlXa1NkZ3QzRktDcWVDZDNX?=
 =?utf-8?B?alhCQlhqMUhxc29Wd1VmQ2JmOGtDZ1VMcStaS0hSYStEOGxFMkV1L25MRXdy?=
 =?utf-8?B?TVo1Qzd6a3VTRWpaRzcxeXBmNGNZZS8yQjIva2VDZnFnWTN0bDdFUWVQcjEx?=
 =?utf-8?B?ZmI5RWpwTmlOZFpaYmJaMzdhMTRoZHJtdFExZTVUcWp5REx1aGt6VVp4TlJs?=
 =?utf-8?B?RThkM0pjZmd1Q3AvR2pzZmpoZnlKQ2xWbVA3Z21zWDhWd3RnVzc2c012cCsz?=
 =?utf-8?B?OHdzUVNxUk9HWis2bmZGQmFJTGRRUEo0KzgxeWsxSzVZbUdYMG1INWZhNW5v?=
 =?utf-8?B?cTlwT2NpVW1Ud3BvZUVuaGJXMTMvK2JaRWczRzBQemFtVUc5eWozelZLVytk?=
 =?utf-8?B?QkMzTlNyenA5a256bDhqSHBVSFQ3eXNBN1ZsdGpHYlNvVEFDZlpPOEtyc2dH?=
 =?utf-8?B?Q004Rzgybk9MUmlkU0ZSc0R3UDMvYTlpQ1RlVm1EM2FzWTAvOEdLcXVnai96?=
 =?utf-8?B?T3ZwMkRDYTFFcVBIYXlYWDcyazF6enQ1TE8zakM4ODU3dzd3Wlh4RFZzajkv?=
 =?utf-8?B?dnBTalFzU2RXL0xkcUtoRUliS1pNQjVicXk2eTZ0eFhnTU9SYzZ3ZGpwZDFR?=
 =?utf-8?B?VVQvNmJFRUtMRnNURzBVWUt1K0NVb0hQaXhydkUyQklWSlNFVWhFWEJMVGdn?=
 =?utf-8?B?eFBZKzVDd0o2Wnl0b0dudTl4U2l6dEpOMG5QaTR2NFVzeEJzY0FVSUxxZ0Nm?=
 =?utf-8?B?RjVoSTc5V3VTbTdmR0tpZzM3L09HS1VtZDh2UWFEZkdzT2d5Zm1TS3ErcHp5?=
 =?utf-8?B?TlhRcXpGdDFYTUsveW9iSDFDUWpYemdpRytWTXVoY0RBNS9hN2FoSjI0STQr?=
 =?utf-8?B?YzRRM052Sk5DWUtYNVhtNTkyRlNDTkJkaGNlYUpFK2V4bEZ1TFA2Q2c1azEr?=
 =?utf-8?B?SmtKMmRQK1RMbzNxcCt0MWV6LzUrdXJlQ3QrME1DVFJMMWlZZ2RuN2lwOXAx?=
 =?utf-8?B?WnBoNW5RNVhodnhPdlZCWlVZUzlFbENhYTZYak9UNHJYUEg3NHBxRmpBY25N?=
 =?utf-8?B?TEc1SzQ4QjFnS1NkRlY4VUVDdEtCNzhwVjAvSktpSE1Dbi9ndUlMWGFvVGlv?=
 =?utf-8?B?NlRkOTF5V28zeTV4VXVyRDRzTHNkQVVoYTJuNEhGOXlmRGtZelFBSGhCSnoy?=
 =?utf-8?B?czJJcEY1b1RmbGZaWkNDcE9qUHlIWXNQeGdsUnRhemZQa1JOUGdSTERmUUVx?=
 =?utf-8?B?elVoQjBsVUdQejBkRkxUMU1QN3V3eFEyYm9XK3Y2aHRNeFJud00zd2ljYS96?=
 =?utf-8?B?dmw1dHZNUVhGQnJOOWdBWE9CaUpSbFJ5eVQ2NUdpWFdQLy85VXZDSHdzcFNj?=
 =?utf-8?B?L3pIM1J0UzFuVWVHdHR5dXQzdkhock85NDE4a29QWGlzYUtYejJ3M3F2RHhV?=
 =?utf-8?B?Rk9XUHpjTTRzTzNNUzlneHZYdVovMGcwT0JIRjk3MkVBR0RNODlmdzNEdS9h?=
 =?utf-8?B?UUhRL2ZHMWdTcUlqWXJOdm5RRzdtU0YvTzRhQ3pseGtaSXBhNTdyK3FZSjhx?=
 =?utf-8?B?L0xlWm5taVl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUlQeCtRUHNHelkvNEJMQWYzSGZlcnlnZjRtcUUzRzdsMWZDMjZ1emYxcEdB?=
 =?utf-8?B?VVBmMFZiWDlnUkF4SjI0QmFEQngwbFZyNGpKc1QrTktYUW92ZlJWV2phVlBv?=
 =?utf-8?B?dzduc2RxaHFLVUZ2MDBPOUxralBZZ0l0K2RvKzd6OGUyNTJHZnFSNncvUlha?=
 =?utf-8?B?dHZtTUExSTJwdjhqNVpGQWl0aUNYalpYLzhMZVV6NUowcWJGYjI2UnQyalhQ?=
 =?utf-8?B?NWwwWVRQWnB1THovUHBzZzEzNUlFSStqczg2NzRudjVabFhvWVVZaFZZQ0JX?=
 =?utf-8?B?RFVIYVM5bVpuVDBvV1B6dlg2Qi9kWXl6Yys0dWp1WXNkbUxyK3BDQ0RxdlFv?=
 =?utf-8?B?UGU1RFdCZzRyazU1d1Y3VHM3ZXF4L0kwYjRBclp4Y2JWeStFUWk2OWpJaUVD?=
 =?utf-8?B?OG4wWnRvdnlPcjQwcHNCZmI1SFY4QWtlVkU5cTlPQzVvTUVhdVRaRjdKbWhl?=
 =?utf-8?B?akJuTUFGNHRTa0I4OUFVMUJFQ2krTWRPUktJTXFIYWN5OHFtTlhRV0NHL3dF?=
 =?utf-8?B?ejdpeUp5R0IrdXlITHBuczFNcThvWnZySG5aU1gveDhBN291WGNDWDd5QlZJ?=
 =?utf-8?B?TGFQZFFveE1mN3Q0Zk9SVlgrYUZncGc1SmFBSWUwZklNU0NSN0ZuRDM2WTF2?=
 =?utf-8?B?QWliL0g1YzEzOTB3OTRadW1TUXRKZm9sY0xqNnBMYk9MYlRGeTdpL29TR1lx?=
 =?utf-8?B?T3hkdTgyUjd2OW1lUXF3a3VkSHdKYUtLZkRYb0dsYU0yZlFScE1GV1VWNG5v?=
 =?utf-8?B?QW9xUDljZlg4TkZzKzRTTWR5S2pidDk2NW1TVUVoQ3JkbXZuV01IeE9ub28x?=
 =?utf-8?B?bzVDc0V1eHFkSFcweWhXSEgxOXdvRXVIRUhMd3QyUnVIYjBGRGZKb3NIcTBO?=
 =?utf-8?B?dFdxbzJJUTA2VWVEQTgzd0JVNWNFNUxmY1RneVl6eUZMTXVndTVzdGlOVmJ4?=
 =?utf-8?B?NktFa3Q2K29HSkYxakdsZjNxMkxVTGtVSXQ5ZVRRMUhNa0w0SFdxTWNmWEZp?=
 =?utf-8?B?WEV5WTZueXNEMFFHMi95T0ovWW5QNThtM0FmZEJya1FET2YvRFVSVENJZk5K?=
 =?utf-8?B?R1EvSFJBOEtlK0s0U2E3M2M5OUs1OEZVcWNEY3FmTkplZWJZUmttdWhqaWo4?=
 =?utf-8?B?N1hrbVQ3S0Npa0dzYjk2UzZubzdRUzlVRE5GRGY4cTV3Vjk4OHMrc21wVVgr?=
 =?utf-8?B?SXlMSmZ3SDNzRUJ3QWpxcEpLTFFEMGRYaTdJTm10Q0d2YW5LSUJhZ3EvSy80?=
 =?utf-8?B?bFRPYjQyQSs2ZEtrVk9iTTFrVHBOcHd3eGlzT3gzcFBvU3NwSXdJS2lBalFL?=
 =?utf-8?B?dDA5U1BtWVlicFpXbzNrVERnanVvQUxMUDJOSDRMNk00VkVXMGlYQVlsNnps?=
 =?utf-8?B?K2cxbVZud1BYQURJbmt2K3lVNzJKeWdFUGtVcS9BR3hkbHhKQzZyTmJ6RmNn?=
 =?utf-8?B?SHZEMEVQdWc1ZXZlVHVoNTNZbU9FcjJ1OWVHOVdMWU9wOGMzeStkd3dHN3Zw?=
 =?utf-8?B?UXcrQjdSMFJJK0JZdVN2NHZneUtDN09tNWFBaENLTXBlb01WZWNiMEwrTXI4?=
 =?utf-8?B?L0ZVdDFFdUlHeFJxbnpUeEdMY1F3cm5jdGhEeWpzdlVvNXNpK2JkK05OT0x4?=
 =?utf-8?B?VzQzMHlhUkNTdUhaNFlMdHJoclpHN00vZGxUT2E5VVZuUW5rZVNSNWlkK2Vv?=
 =?utf-8?B?RFdNc1IrVFk3R0p4MlJRbkhLYVE1Y2RWdXJEYUo4L0xFajJzMi9FRk1BZElJ?=
 =?utf-8?B?bytDc2h2d2hmYVJxZGJLSVZvRHFreWZzWjdkNnp6SGIzRExHZFlHUzVjYlFP?=
 =?utf-8?B?bmc4ekJzQTNmQnNvVGhmMlVsb0FkclA4a2ZGKzNDTUtoSnVDQmNsWWxudHJt?=
 =?utf-8?B?MFZBTUlzSFljTExLdXNxYWdqK3VkMWh1S1lvWm5weEZ1dVNsSUJLSndEK2Nk?=
 =?utf-8?B?V3NKdlZUR0ZWN1M1eUxGZzE4WDVHK2JmM0NKTlE2WUlpWTJ0aEo5cVB1NWhQ?=
 =?utf-8?B?aS9RRWhRZTlGVlVSQVBOVkk0S1dLS1cxcEpoalNYOEd2SFlLRk5CT0duSWZ1?=
 =?utf-8?B?S3pTOXVYeUtWQU4wdmkwaW43Wnp0K3pQcFJ6WWI2bmU3QXVRSElFNGswWlUv?=
 =?utf-8?B?VmVNazZkeFFwS2N6b0t0WXVCQTRFWVp0MCttT1REM3dkeU1BUHhZZ0U2Vkov?=
 =?utf-8?B?WEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2267aa-f848-453d-1dc2-08de027cb729
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 12:59:40.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXUK5h1M/gkvuXFvC6rwIDcD1TCIDEnI0Q10gCeNHllr0NOhO3xsE518WIAZy/6UWL0dzyRonLmuUmkaIDUbBGtPBmatatv3uljw5RgoX84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9zZWYgUmFzY2hlbiA8
am9zZWZAcmFzY2hlbi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzMCwgMjAyNSAx
OjAwIEFNDQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IENjOiBBcnVuIFJh
bWFkb3NzIC0gSTE3NzY5IDxBcnVuLlJhbWFkb3NzQG1pY3JvY2hpcC5jb20+Ow0KPiBVTkdMaW51
eERyaXZlciA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT47IEhlaW5lciBLYWxsd2VpdA0K
PiA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az47IERhdmlkIFMuDQo+IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+Ow0KPiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIG5ldDogcGh5OiBtaWNyb2NoaXBfdDE6IExBTjg4N1g6IEZpeCBkZXZpY2UgaW5pdCBp
c3N1ZXMuDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+
IE9uIDkvMjYvMjUgMjM6NDYsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+IE9uIEZyaSwgU2VwIDI2
LCAyMDI1IGF0IDExOjI0OjU2UE0gKzAyMDAsIEpvc2VmIFJhc2NoZW4gd3JvdGU6DQo+ID4+IEhl
bGxvIEFuZHJldywNCj4gPj4NCj4gPj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KPiA+Pg0K
PiA+PiBPbiA5LzI2LzI1IDAwOjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gPj4+IE9uIFRodSwg
U2VwIDI1LCAyMDI1IGF0IDEwOjUyOjIyUE0gKzAyMDAsIEpvc2VmIFJhc2NoZW4gd3JvdGU6DQo+
ID4+Pj4gQ3VycmVudGx5LCBmb3IgYSBMQU44ODcwIHBoeSwgYmVmb3JlIGxpbmsgdXAsIGEgY2Fs
bCB0byBldGh0b29sIHRvDQo+ID4+Pj4gc2V0IG1hc3Rlci1zbGF2ZSBmYWlscyB3aXRoICdvcGVy
YXRpb24gbm90IHN1cHBvcnRlZCcuIFJlYXNvbjoNCj4gPj4+PiBzcGVlZCwgZHVwbGV4IGFuZCBt
YXN0ZXIvc2xhdmUgYXJlIG5vdCBwcm9wZXJseSBpbml0aWFsaXplZC4NCj4gPj4+Pg0KPiA+Pj4+
IFRoaXMgY2hhbmdlIHNldHMgcHJvcGVyIGluaXRpYWwgc3RhdGVzIGZvciBzcGVlZCBhbmQgZHVw
bGV4IGFuZA0KPiA+Pj4+IHB1Ymxpc2hlcyBtYXN0ZXItc2xhdmUgc3RhdGVzLiBBIGRlZmF1bHQg
bGluayB1cCBmb3Igc3BlZWQgMTAwMCwNCj4gPj4+PiBmdWxsIGR1cGxleCBhbmQgc2xhdmUgbW9k
ZSB0aGVuIHdvcmtzIHdpdGhvdXQgaGF2aW5nIHRvIGNhbGwgZXRodG9vbC4NCj4gPj4+DQo+ID4+
PiBIaSBKb3NlZg0KPiA+Pj4NCj4gPj4+IFdoYXQgeW91IGFyZSBtaXNzaW5nIGZyb20gdGhlIGNv
bW1pdCBtZXNzYWdlIGlzIGFuIGV4cGxhbmF0aW9uIHdoeQ0KPiA+Pj4gdGhlDQo+ID4+PiBMQU44
ODcwIGlzIHNwZWNpYWwsIGl0IG5lZWRzIHRvIGRvIHNvbWV0aGluZyBubyBvdGhlciBQSFkgZG9l
cy4gSXMNCj4gPj4+IHRoZXJlIHNvbWV0aGluZyBicm9rZW4gd2l0aCB0aGlzIFBIWT8gU29tZSBy
ZWdpc3RlciBub3QgZm9sbG93aW5nDQo+ID4+PiA4MDIuMz8NCj4gPj4+DQo+ID4+PiAgICAgICBB
bmRyZXcNCj4gPj4+DQo+ID4+PiAtLS0NCj4gPj4+IHB3LWJvdDogY3INCj4gPj4+DQo+ID4+DQo+
ID4+IFNwZWNpYWwgYWJvdXQgdGhlIExBTjg4NzAgbWlnaHQgYmUgdGhhdCBpdCBpcyBhIGR1YWwg
c3BlZWQgVDEgcGh5Lg0KPiA+PiBBcyBtb3N0IG90aGVyIFQxIHB5aHMgaGF2ZSBvbmx5IG9uZSBw
b3NzaWJsZSBjb25maWd1cmF0aW9uIHRoZQ0KPiA+PiB1bmtub3duIHNwZWVkIGNvbmZpZ3VyYXRp
b24gd2FzIG5vdCBhIHByb2JsZW0gc28gZmFyLiBCdXQgaGVyZSwgd2hlbg0KPiA+PiBjYWxsaW5n
IGxpbmsgdXAgd2l0aG91dCBtYW51YWxseSBzZXR0aW5nIHRoZSBzcGVlZCBiZWZvcmUsIGl0IHNl
ZW1zDQo+ID4+IHRvIHBpY2sgc3BlZWQgMTAwIGluIHBoeV9zYW5pdGl6ZV9zZXR0aW5ncygpLiBJ
IGFzc3VtZSB0aGF0IHRoaXMgaXMNCj4gPj4gbm90IHRoZSBkZXNpcmVkIGJlaGF2aW9yPw0KPiA+
DQo+ID4gV2hhdCBzcGVlZHMgZG9lcyB0aGUgUEhZIHNheSBpdCBzdXBwb3J0cz8NCj4gPg0KPiA+
IHBoeV9zYW5pdGl6ZV9zZXR0aW5ncygpIHNob3VsZCBwaWNrIHRoZSBoaWdoZXN0IHNwZWVkIHRo
ZSBQSFkgc3VwcG9ydHMNCj4gPiBhcyB0aGUgZGVmYXVsdC4gU28gaWYgaXQgaXMgcGlja2luZyAx
MDAsIGl0IHN1Z2dlc3RzIHRoZSBQSFkgaXMgbm90DQo+ID4gcmVwb3J0aW5nIGl0IHN1cHBvcnRz
IDEwMDA/IE9yIHBoeV9zYW5pdGl6ZV9zZXR0aW5ncygpIGlzIGJyb2tlbiBmb3INCj4gPiAxMDAw
QmFzZS1UMT8gUGxlYXNlIHRyeSB1bmRlcnN0YW5kIHdoeSBpdCBpcyBwaWNraW5nIDEwMC4NCj4g
DQo+IEl0IHNob3VsZCBwaWNrIDEwMDAgdGhlbiBmb3IgdGhpcyBwaHkuIEkgY2hlY2tlZCBhbHJl
YWR5IHRoYXQgdGhlIGRldmljZSBpcw0KPiBhY3R1YWxseSByZXBvcnRpbmcgYmVpbmcgMTAwQmFz
ZS1UMSBhbmQgMTAwMEJhc2UtVDEgY2FwYWJsZS4gSSB3aWxsIGhhdmUgYQ0KPiBsb29rLCB3aHkg
aXQgZG9lc24ndCBwaWNrIFNQRUVEXzEwMDAgdGhlbi4gSSBkaWQgbm90IGtub3cgdGhhdA0KPiBw
aHlfc2FuaXRpemVfc2V0dGluZ3MoKSBpcyBzdXBwb3NlZCB0byBwaWNrIHRoZSBoaWdoZXN0IHNw
ZWVkIGFscmVhZHkuDQo+IA0KSGkgSm9zZWYgJiBBbmRyZXcsDQoNCnBoeV9zYW5pdGl6ZV9zZXR0
aW5ncygpIGlzIHN1cHBvc2VkIHRvIHBpY2sgdGhlIGxlYXN0IHN1cHBvcnRlZCBzcGVlZCBmcm9t
IHRoZSBzdXBwb3J0ZWQgbGlzdCB3aGVuIHNwZWVkIGlzIG5vdCBpbml0aWFsaXplZC4NCg0KSW4g
bGF0ZXN0IHN0YWJsZSBrZXJuZWwodjYuMTIueCkgd2Ugc2VlIGEgYnVnKEluY29ycmVjdCBkYXRh
IHR5cGVzIGluIHBoeWxpbmsgZGF0YSBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIGFyZ3VtZW50cyku
DQpEdWUgdG8gd2hpY2ggd2UgYXJlIG9ic2VydmluZyB0aGUgaGlnaGVzdCBzdXBwb3J0ZWQgc3Bl
ZWQgaXMgYmVpbmcgc2VsZWN0ZWQuDQpSZWZlciBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L3RyZWUvZHJpdmVycy9uZXQvcGh5
L3BoeS1jb3JlLmM/aD12Ni4xMi40MyNuMzA1DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L3RyZWUvaW5jbHVkZS9saW51eC9w
aHkuaD9oPXY2LjEyLjQzI24xMjc3SW4gDQoNCkhlcmUgY29tcGFyaXNvbiBpcyBkb25lIGJldHdl
ZW4gdW5zaWduZWQgYW5kIHNpZ25lZCBzcGVlZCwgZHVlIHRvIHdoaWNoIHRoZSBtYXRjaCBpcyBi
ZWVuIHNlbGVjdCBmb3IgdGhlIGhpZ2hlc3Qgc3BlZWQgaXRzZWxmLg0KDQpUZXN0ZWQgY29kZToN
CjMwOCAgICAgICAgICAgICAgICAgaWYgKCFtYXRjaCAmJiBwLT5zcGVlZCA8PSBzcGVlZCkgew0K
IDMwOSAgICAgICAgICAgICAJcHJfaW5mbygibG9va3VwOiBzcGVlZCA9ICVkIHJjdmQgc3BlZWQg
PSAlZFxuIiwgcC0+c3BlZWQsIHNwZWVkKTsNCiAzMTAgICAgICAgICAgICAgICAgICAgICAvKiBD
YW5kaWRhdGUgKi8NCiAzMTEgICAgICAgICAgICAgICAgICAgICBtYXRjaCA9IHA7DQogMzEyICAg
ICAgICAgICAgICAgICAgICB9DQoNCk91dHB1dCBwcmludDoNCltGcmkgT2N0ICAzIDE4OjI0OjI3
IDIwMjVdIGxvb2t1cDogc3BlZWQgPSAxMDAwIHJjdmQgc3BlZWQgPSAtMSAgID09PiB0aGUgY29t
cGFyaXNvbiBpcyBmYWxzZSBhbmQgdGhpcyBzaG91bGQgbm90IGV4ZWN1dGVkLg0KDQpMYXRlc3Qg
bmV0LW5leHQgZG9lc24ndCBoYXZlIHRoaXMgaW5jb25zaXN0ZW5jeSB3aXRoIGRhdGEgdHlwZSBm
b3IgdGhlIHNhbWUgc3BlZWQgcGFyYW1ldGVyLg0KU28gdGhlcmUgaXMgbm8gaXNzdWUgYW5kIHdl
IGFyZSBzZWVpbmcgdGhlIGNvcnJlY3QgbG93ZXN0IHN1cHBvcnRlZCBzcGVlZCB3aGljaCBpcyAx
MDBtLg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL25ldC9waHkvcGh5X2NhcHMuYz9oPXY2LjE3
I24yMTANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvbmV0L3BoeS9waHktY2Fwcy5oP2g9djYuMTcj
bjM5DQoNCk1heSBiZSB3ZSBuZWVkIHRvIGZpeCB0aGUgc3RhYmxlIGtlcm5lbHMgdG8gYWRkcmVz
cyB0aGUgZGF0YSB0eXBlIGlzc3VlLg0KDQpUaGFua3MsDQpEaXZ5YQ0KPiA+PiBUaGUgc2Vjb25k
IHByb2JsZW0gaXMgdGhhdCBldGh0b29sIGluaXRpYWxseSBkb2VzIG5vdCBhbGxvdyB0byBzZXQN
Cj4gPj4gbWFzdGVyLXNsYXZlIGF0IGFsbC4gWW91IGZpcnN0IGhhdmUgdG8gY2FsbCBldGh0b29s
IHdpdGhvdXQgdGhlDQo+ID4+IG1hc3Rlci1zbGF2ZSBhcmd1bWVudCwgdGhlbiBhZ2FpbiB3aXRo
IGl0LiBUaGlzIGlzIGZpeGVkIGJ5IHJlYWRpbmcNCj4gPj4gdGhlIG1hc3RlciBzbGF2ZSBjb25m
aWd1cmF0aW9uIGZyb20gdGhlIGRldmljZSB3aGljaCBzZWVtcyB0byBiZQ0KPiA+PiBtaXNzaW5n
IGluIHRoZSAuY29uZmlnX2luaXQgYW5kIC5jb25maWdfYW5lZyBmdW5jdGlvbnMuIEkgdG9vayB0
aGlzDQo+ID4+IHNvbHV0aW9uIGZyb20gbmV0L3BoeS9kcDgzdGc3MjAuYy4NCj4gPg0KPiA+IEhv
dyBkb2VzIHRoaXMgd29yayB3aXRoIGEgcmVndWxhciBUNCBvciBUMiBQSFk/IElkZWFsbHksIEEg
VDEgc2hvdWxkDQo+ID4gYmUgbm8gZGlmZmVyZW50LiBBbmQgaWRlYWxseSwgd2Ugd2FudCBhIHNv
bHV0aW9uIGZvciBhbGwgVDEgUEhZcywNCj4gPiBhc3N1bWluZyBpdCBpcyBub3Qgc29tZXRoaW5n
IHdoaWNoIGlzIHNwZWNpYWwgZm9yIHRoaXMgUEhZLg0KPiANCj4gSSBhZ3JlZSwgYSBnZW5lcmlj
IHNvbHV0aW9uIHdvdWxkIGJlIGJlc3QuIEkgd2lsbCByZWFkIGEgYml0IGludG8gdGhlIGNvZGUg
dG8gc2VlIGlmDQo+IHRoZXJlIGlzIGEgYmV0dGVyIHNvbHV0aW9uLg0KPiANCj4gVGhhbmtzLA0K
PiBKb3NlZg0K

