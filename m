Return-Path: <netdev+bounces-270568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIj5LX5owWliSwQAu9opvQ
	(envelope-from <netdev+bounces-270568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:21:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AC2F7EFE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 285293232474
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A773B0AF0;
	Mon, 23 Mar 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1bAk2ET"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B13B0AE5;
	Mon, 23 Mar 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276928; cv=fail; b=TwXET6r4ByF2+aD4dldXbvFtuKniOce9+HXN9iRMgc5zpP2HlQyXhTIrLnisSKuSo00k6Xl1YsUYXnGM4IeRWtZE3pJhYDBtIegUX9cX5TY/4CXX4mqFEMm7/FNpdhxlmy8QVdgz5PGdIO/5L0HdlhFwgJ2sPek5hyEWpox7Bq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276928; c=relaxed/simple;
	bh=jI2rKGKvcyg9cdm7amv4ZiuhmHYfAexbU7SAX2rwRcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KpMwZHcGFAI0c7HdLf1cDCRMaLwKFT2Yn7IbRFvD6MucaNpxMaSjy4MKGwmvPG/Gh1BXYxt3d9qa+ugb8zx/o/pyKrDBdU9Z19DZYaZ13SBMTEMNxfRgqT1Aj+0CmCSKlwF7y8yyYN9KlVnaWQf/x41x1Nkq3Rqwg0V3PUmZe84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1bAk2ET; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqF3sFwT5emO+RowEGq61FeNAcMCcfAnhANFqg8NNPrtYwSVD7bq5GqCK3atwEm3dfVVBQjTglNkHlkb2BRE+6Lv/IUj9KD5++ELDQ0bzBLnFrncmup/PF+Jj5NOhjGH5+wNvHKVpo+i4GaTMPEAZuqqzHRz5vkL+WPMxV51Fpg1fLvdx9zIga9OS9Ls6u4Ce8Z8j6QqF5GjQWgDyHExNWVdZvliyvVhdjpZPBTF5DRhigM/SbZ5jlHEQ6E6JTJNcorfwM+CIzzKVxsFbQ1ju8fn+JT/517bIMDS3zHTluVhLAfVN7CNaHIW9K4z7QYqmjw9R7Rz+niySDwwYOh0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI2rKGKvcyg9cdm7amv4ZiuhmHYfAexbU7SAX2rwRcc=;
 b=iM115RUDqoi9PzFOUl+dNbOB9461PDNf7cA5QAf6JVNYcjhFNrDZfvubXZaWUZqGA/+jVPgKPLmzXNJwpFRXog3+baxkoV13HoZweHR9Xj7R91707dL/LOFGMFe7+oJKbncc6iBwQkaCf9eZegt3tfYlV0Ivy+3psdtOa9tPOOSGNtxgfTqabRom6JoZS+9tspj6NuYiFcDUYvi86KZE8tvREfi063FB/NvUkJ2j61Ginj8R8t/9Nb4M4KdlEpOdtrhS9yD0zGlTXnqtYTbKD+se2eyuuFZxsfCmZuBT2MnNrZhJKnLgxHUqVuUQQ1TYKCevLerMCjskOuDrIDyzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI2rKGKvcyg9cdm7amv4ZiuhmHYfAexbU7SAX2rwRcc=;
 b=N1bAk2ETUBIcXhBHQmLDFgcl0VAAC5x4u2fVSBmiOupSrH6HPaa7Haqyx2IUdZdp288q74F/C0mdqJ+SWb2TTopEZdBSyzbzbxkvgklA5u5OQjA9SXa8yrT4uQvNr9lQRbq9Ws9I03unkCrnjod9B89WSC9VSpP2QsR0N6Rpj146hzTQJJraEROA9pTzFPjxlSIyZpTmPIf6gVsokwPL0FodXVvbko/SZS0KE1pvCQbX4ecPqJnCo0+9O621yuV0xqe7I7p4H1LwCjJawnn57lsDk34mP3keb4AOQjgDqmaZm9hkF8A10QbqL7ui13w/7dNQ8HOI54u2dhE4Zpl1aQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH7PR12MB7872.namprd12.prod.outlook.com
 (2603:10b6:510:27c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:42:01 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Mon, 23 Mar 2026
 14:42:01 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Topic: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Index: AQHcusHFtVV4nTuLykGR5FK+1e+FhrW8LSAAgAADwoA=
Date: Mon, 23 Mar 2026 14:42:00 +0000
Message-ID: <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
References: <20260323123633.756163-1-cratiu@nvidia.com>
	 <acFODtfaa8LCKX4r@krikkit>
In-Reply-To: <acFODtfaa8LCKX4r@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH7PR12MB7872:EE_
x-ms-office365-filtering-correlation-id: e86ec53e-bae9-4d66-efc3-08de88ea57bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 DuYeOVVk03JgfqRlLvcQ1L0jlAVBrq5m+PmdGzgX0MHZWS30Zcj6L9rLH3k+dyDiGoiF6CCVQitOrbfIiLlSuWtpe3j3rSnQ5FT1hpIFWfGovv+ybfn8/ezUWzrSw+kJ/7wOBLhEKn+rnnJTUi9sdGY85NzF8tIC9jXAlkSsfy3yM5oWEy2bN3IggfkSCNmnqlgjfUloZqhBXXDtD0lLxxuv5v383VYlTd15DApuMRK0XA9UuJN6x3vhNsS81w5giBpl1mzAWwyHpM8t18WX7XcT7kChvZU67R6SVb7TDfeYCAjyA2PBfITPQ5usmA/ss8kUpQGJP40BtNaxGATACPo5GqX4+rfccmtIIO0qwOjDeD9CyeRUObFM7Jrm5b7Iyp4ec0TMIjRKgtitDxt8a45A+JPnxS/5VRZL+U7PAxA89NHf16DQqmoRrMVdrI78jphKE+zo61QpcyqDO8/6x3rr6kp8kis0p3R1RFHjMoZiF4XvbaE2yIEeuaRlX9lf8pSKduz0P094MBp1NOyLBRU97GgU50fOdacpb8MlT1JsaM0m87iHqyCxZfO+utNO2AKCfMs/K7SDGXgu4OEhhhhCiaeMc+PavPOKyJdQkPCFmvWFYcEMXCyI3Rhgbu/4QgUMA7zAR3H5KeWKrVKv/ikh6tdyE6r3zuSQTbPet3s5P1Jz5wCRWUibkgaeuy1dXxSlK764nxpQJms12Gpl0IczLQTD2lcrX52O9EJg6EIPr1le8InLTzMrnvmdof/IfyHlCDUCzcb1NGE6GsOam9LEbbVeU+Uq77QAiXy8gBM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3NZVHNzeWdGdVVJbnNmSHJMRU9sOS9XYnpRZEcrMDNnWXBYL2xxdStEYW93?=
 =?utf-8?B?bG9ld0Z2Yk42TDFwL3l4aVF2SGlPYm5RSWNvZVhoMmtaTzJSK1FYaktzRjBY?=
 =?utf-8?B?eDJHSVBGSGNMdHI4S0N6S2VBRktkbWladlFYZGhnT3VOMjRoZVFnb2w5NzNW?=
 =?utf-8?B?QWdzNFdWQ2Y3dytwTVRqOXpWbVBaeWpOTzZKVjVIbmpXa3gvb3ltYnRadkNF?=
 =?utf-8?B?ZWs4eXVLUUVMU3lrbEdFWVNLWnQ0anNCQ0pXdGVlMnBKeEl4ZHhBTko4K2RZ?=
 =?utf-8?B?aVI4SjZCTm5JVzdNT0pnRXpXRGR0RHFsVkw5U1R0ZHp1TDcyd0Rma21Ma1Yy?=
 =?utf-8?B?ZFdpb1o0U3hHUmU1ZzRYZFpack5EWjNSM1FQK3UvVHMvd1lkM1JGNUVKUXN3?=
 =?utf-8?B?YU5PNjArUzF2cEdCYnp2RSszbXlRWUlVakZ0K3NJTHY2dWd4cGlIZ3g3NHBv?=
 =?utf-8?B?NlZyaEk4UExTR2JhRFRVd0MzSDJqSnJvZEdKOHJkMlllRm9EdzBHUjR2aExN?=
 =?utf-8?B?NlhSWEFRZHo1emhrdjNnY21xdCtCa0pab0Z0WTZuK0U3Y3EwOEtMSDNXRUJ3?=
 =?utf-8?B?L1hWYWlqd3A5dzRJbzZHMlVHYzFRVDVhSVlJVTZFbkNxOENOT1VJQVVvcnhx?=
 =?utf-8?B?MGdYVGtEUmtOZmFvRmVwR0pBVXdoS2pUT0xBQ0pWOVFsdlAySTZ1VFprNlNa?=
 =?utf-8?B?S211UCt1VmRYZXVvRy9JS1VYc3RWRWZ3bXgxKzNXWmppbXZUYy84Si9RWDJY?=
 =?utf-8?B?VWZGSU14QWs5c3dJdW93dVlNMzN0cVhMR09Vam1wUkFHeWI5aFh0SUdVUWI5?=
 =?utf-8?B?dlBVMHRtRGJnalhyRDltbHcrcTBYSlgzT0NocUtjaWlHVlppQ2FaYWQzWmZ6?=
 =?utf-8?B?R3NQL3FRbnNyWGxHck9JRzZFSTBKV0JmYWJSMXovcC9paHE4WndJNkpKU3RN?=
 =?utf-8?B?dFlnbXhoK2k1RlZTaGptbE5qZHdNckMvbTVsY2YrQnJzdFZYUHFkMTQ5aEhm?=
 =?utf-8?B?RlpwMGlaUWdmMm15VVFWWnN1MHl4ak0yRTlNTFVZbnJjL3FUSktvUnFPM2lC?=
 =?utf-8?B?ZTRKZGFFLzR1TnVuajA4R2p3VkRtMjNURFR1OFF6UUk2aFRQb1o0OGZxeHdR?=
 =?utf-8?B?YWJSSFRDMVgyUWtDTWxubnlZZE8wS0lPNUdVYW1XSUJvU0IyTGRMRWJTdk1G?=
 =?utf-8?B?a28zMFpUNmJ4Y21jRVNFYmk2eFhhVmdQVkFDZk01WlZJK2dVUStTSXQ5Zm5l?=
 =?utf-8?B?MHZWcVU4aG1zSStTZGVEZkpDNFY3SENTbm9zUTdmbkpiVHRacFpkZGpYeUVH?=
 =?utf-8?B?ZXgyYS8zRmFiQVFoRHFGK1ZUdVBnUEdvVHpydklnTU9KNzhjc21rT21uOWhm?=
 =?utf-8?B?QWswNDJIanRDQnNUWDIvNitkVEFLNFlodlhzYzdOdFVKWlVOTWFVZUEzNFVN?=
 =?utf-8?B?T3NqRHFOTUVoOVE1UHBDWnN4WDFqNzE3cXpjOEVjRitoL1BBYW9qT0ovajJp?=
 =?utf-8?B?WWw0Tld6TXlqS3NJM1E5bWFSczJIWk5UeXpTRi9HcjQ1NWdjb1dPM0c2a2lG?=
 =?utf-8?B?SWE1UzYzTDdXdjVLV0JZR3I1bFRSVVZ0VXdpSVJTRElKbytOZ0MwSWRTb25F?=
 =?utf-8?B?S1JhTS83b0Ruc1djbmgyTUJHTEYzWGhEbXpSdTA1alVUUUQ4SlIxVGFSVG5p?=
 =?utf-8?B?bGhNT2lYeE9QclJ3cFJBcVZWelA0Mlhjdlg3NmJrN1hLd28xaVpwMGF2RkVC?=
 =?utf-8?B?UFN3NTFmVFpPRHNjOXpCWTNkMCtuaTZ1UnBEa29pdy9XQk9TdXlXaFdoNFJ0?=
 =?utf-8?B?N0hYa0xPT2VHYlU1ZUtMV1ZKc2d4LzV0MmF6dEFzVlYvRkNuNnlTVS9weXhq?=
 =?utf-8?B?TWZoWHQ5bmZyMFhxYm42Q2dTNGd4U3NCQkZjN25pYUc5TEd2R0xvcGdSL1Fo?=
 =?utf-8?B?SU9PWklDaXpaeDVoOWZLMHN1bURTeGx6eVRKVDRibWNFcWdrUXRIc0ZQeUtD?=
 =?utf-8?B?NWo3cVVRc1ZhS0JMSzJDS2JzblUxd3pabk5JQU94UHhkbVN2c3N0ZER4S3hD?=
 =?utf-8?B?d1FjRlMrSWNycUhjMTFaYld1WndtZENWcjR5a1NYMkM3QUtpSnpwVnY2bm5v?=
 =?utf-8?B?Z0lWUld5cGxSRENjMzRFMktaWExPMXBITXhDbFJXbGJLdGVuaENpVUpoZDVR?=
 =?utf-8?B?RUwxRlhXbHEvUmJwVjdFMStpWTdwYzF1azI3RFVXZ0d4RFBJQjdTYmphanhQ?=
 =?utf-8?B?VjdOajZkYUtGTWMvUHh2eEFQVEdjNlByY21YcHlpOGtCQVp6WDlncU8vVlN5?=
 =?utf-8?B?NTRUbmdjVHBLRmVjdldWNGNMbElVTkpkMzRZWitwQTl6NG11Vkhydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <660E28A070CD9C4D96E4D57909DB71B6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ec53e-bae9-4d66-efc3-08de88ea57bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:42:00.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fMYpno1ApLyk2sD9vNnDte0uYCv30ehF0r2pKPW0P/u/mPvh95pH+B6bhBzqJSsaP9qxSZyLlvfBM9NLTxsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270568-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5F5AC2F7EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE1OjI4ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMjMsIDE0OjM2OjMwICswMjAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
VjQ6DQo+ID4gLSBNaWdyYXRlZCBuc2ltLW9ubHkgbWFjc2VjIHRlc3RzIHRvIFB5dGhvbiwgdXNh
YmxlIGFnYWluc3QgcmVhbA0KPiA+IGh3Lg0KPiA+IC0gUmFuIHRoZXNlIHRlc3RzIGFnYWluc3Qg
Ym90aCBuc2ltIGFuZCBtbHg1Lg0KPiA+IC0gR2F2ZSB1cCBvbiBuc2ltIHBhdGNoZXMgc2luY2Ug
dGhlIHRlc3RzIG5vIGxvbmdlciB1c2UgdGhlbS4NCj4gDQo+IFdoeSBub3Q/IEJlaW5nIGFibGUg
dG8gdGVzdCB3aXRob3V0IGFjY2Vzc2luZyByZWFsIEhXIGlzIHN0aWxsDQo+IHVzZWZ1bC4NCj4g
DQpUaGUgdGVzdHMgbm93IHNlbmQgbWFjc2VjIHRyYWZmaWMgb3ZlciBWTEFOcyBhbmQgbnNpbSwg
aXQncyBqdXN0IHRoYXQNCm5zaW0gZG9lc24ndCBkZWFsIHdpdGggVkxBTiBmaWx0ZXJzIGF0IGFs
bCBhbmQgdGhlcmUgYXJlIG5vIHN0dWJiZWQNCnZsYW4gZmlsdGVycyBpbiBkZWJ1Z2ZzLCBzaW5j
ZSByZWFsIGh3IGRvZXNuJ3QgaGF2ZSB0aGF0IGludGVyZmFjZS4NCg0KQ29zbWluLg0K

