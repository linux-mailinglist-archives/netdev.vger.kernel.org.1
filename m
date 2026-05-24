Return-Path: <netdev+bounces-291155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2avREhq1EmpJ3AYAu9opvQ
	(envelope-from <netdev+bounces-291155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A47495C1AC6
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69AA300F14F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6498F31E84A;
	Sun, 24 May 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ch123vNd"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395E2FD681
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779610901; cv=fail; b=VpNKrnNyH0Ccrg6gQs+97CFM2jRnrlNumR2vX6FVFEGC6GaEBy5a9FhAbLHH7zRzFrd38TR0qiNNJfawwbLBTsUKaPDmOpCVX6TXaM7XC1feT0p5VbgY9YVzBLKiGfTaTLDO4PqfAx/qX88qslRhwdVzDfEQDAXtWISQlxy8Q68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779610901; c=relaxed/simple;
	bh=AHGmukRjVv0s5keI/jGAZMbHwIRsb+q7CpUErTttZIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nrQR0ls4UQ8MhwXOgMmGZWuoviRdukQisLCnUENNWCGPf983+znAV3sEFjkvyPBTf8hJvok+zsjt+EolKIHTcJhUKsDvc+IFbqRJpDSUPSBaBn5DjZR/Z5MW74sv24Ppt9X//HQcQMbavURY5vHFFUZevzRfrfG6DZZ4SnQ1Fvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ch123vNd; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC1A8hd2h3J/M9ZwcjtUqO87muu50WdGoQMdelTsAzWs4gHe+PymC5BjfaugYzUPM1+COUYs5zpu8PQfihX2IwIjB1siSsAz7GQZgr1wQyDZBT2QUcr4oQowdHYoSYwggn29HZXf7HRB7+ZlWOtoMPrZ5atFwG3gAU7VH/1LhSfoenkHvvbfXa5pCTG3E6JM9uNe/98LBvEJojTlbRr4lWjNYaFgtxn3J6JxligJphARi4NRoehi9Vd00ffZQaLIRB2K0RZsaZAGggLRbH2phS8S3eO0Z8XIDOJHhIrbdU5HpBORfnkGaDgAu4XPtbQC1lCnNLFikQuPj2wblapfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHGmukRjVv0s5keI/jGAZMbHwIRsb+q7CpUErTttZIQ=;
 b=ksY/XIoViAcb8S1rU6EIz1M7V8c18aUzzNGCzUkTz/ESzlgkdxgMm9AcQT86Y9hDix3MyOS8oP6FL6dUt5jZxTjWpIRXQOyZcXtloEWGc4sPl+ixfD5UWmHGegG9vh6TVUeENRtStPqTgj0nNkjrcd7Q5uH76442vtQb0KTS8w85R2GsXMTmJ8K4L0XREMTQ4IoB1ovWKVvU3d5tN6V3aOm1OUFeXy+AzaWrmupUCVTKOCGn/TfQ1V2tMkFN9GRrfkLxxtPa9oLRVO3KSXMd4DK0xbikRY8PJUK4cC1dlkR5bfoaEbGpVBmdvMw7/98UrHTOJQq0upQs1pAjaeDCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHGmukRjVv0s5keI/jGAZMbHwIRsb+q7CpUErTttZIQ=;
 b=ch123vNd86pls85pHB5zn5QIV81c9c/zeKyXj6qF5Bpe/4qNJfh3l+eCs2m7E+MpP5KrG3+ip9Nu9o8BpbsXr4qvGrOE2dHJHMH+woMqLOhjmhgjgLWAGU39sjhIjHlm4jginT7msS9y1k0qOl+NEp6QGbaFDnxFnGWCdnP/W2BfJQ0kL0U8zBZnj2xuqX4SE6e27qryUYM/aRNsgEM/AJxIrzMS6jM1MmnlK3ZybC1FNuwi4gjAAmrHQTWuvZSN/Al0tXvsB44yxoyqPbcmk7V8EFtp+pzZHOw1QPsLuhFtGfv4/vaWPjFHKLe0LDA8AUVjti29UtCMYc2FVhs6iA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sun, 24 May
 2026 08:21:33 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 08:21:33 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH net 5/9] ethtool: module: fix cleanup if socket used for
 flashing multiple devices
Thread-Topic: [PATCH net 5/9] ethtool: module: fix cleanup if socket used for
 flashing multiple devices
Thread-Index: AQHc6kCbKj0OGMBB20mZycQkwvue47YczsrQ
Date: Sun, 24 May 2026 08:21:33 +0000
Message-ID:
 <DM6PR12MB4516EA242A3CC27D2132C6B1D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-6-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-6-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA1PR12MB7221:EE_
x-ms-office365-filtering-correlation-id: 5c69ab50-6f5a-4124-dd05-08deb96d773c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799006|3023799007|4143699003;
x-microsoft-antispam-message-info:
 wqYVd18QsgxN2fvMTqgK5k7j9rXkImdHlUTyScQRi/wGkTCs4HOex+94lsA7loMYEVNarqaqO+ZW28iLw4tJXHhr3GAniwcjClyZHoJvHxpLNWR5mQbHmuy60sa30bbneVu95e1UKu3THap5HjHS7tZmgPZQ6iUpwNthZiYxUP81nZCaYkG1w2/bw+vxo17q50svRTBavvQUYYcuwY32f3IO/rmuJt+rT1bHAkMW6JtAwJVxe3q25HPMAIvP75YdRCN/zwNGlNQMODEYPULt3tuzhJx1hMj8sW9NXy25yGoCR5PzkAVIltfiktIIxgrGsqfaJpVa+t/GM4ActXH1eB2UHtwFICe76hyNphhiWBd7g3amOMlxq54p6roLU6u8mFY84OKehRLNi5uW/8Z7eXTIHCwNqO4/D5IdeiIAGyES+FX/shTHdS1e6egN057b69Lfl0ciGinckdoYYRVrerjQcrNyGVIbC0kUL7AvaZLhDb/ODoZTpkQEqEJ1eT4LiyXlsNwlW6VBgM0HP5Vq7NRSfVIahDxfNeyr25rS+h/MsEXb5XMi57ufU2AFJu3xib0/1thLwjeRXRpWLO2sDOdgkMA++19lKOAGyBBSMvaDErlrOW6kotc4gvSU8sBDT7AHXtE5xe5dXCBd7CkAmi7fhezNGnBkUEAq7ghKEZswuvZ27GX095aVxumhvkp9LqqygzMeeHjPuTNzKEXLP3VSYSkObq4GCUQlWYQsOJ/KMgA6O4UnItVLG7jaWBmQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWc5Y1ZzcGpZaFRVQkErQ0JTSktQenVKWGNndjdEdFRrNXRQY0JlTVNRQi9l?=
 =?utf-8?B?NG02aHhBUXFHZWpYTDBFVWdKSjNXS1NkWjVqdFhSM3dQdW9rV0pDRHh6ekJ3?=
 =?utf-8?B?Tyt1dk9MNStoV1U2STJ2RmlhZFozRktpb2s1TldCUWpkYnJBV2JWdFVzdER0?=
 =?utf-8?B?WFVFV2lFQnBVMnlTQTI0OTVSSlhCTTFHUGtOUXlCSzJmUkF0RDV6MmFZbHht?=
 =?utf-8?B?QUJTck14aGU1ZytBNkFzZmRjS3NNTS91SGkrUW1yVHZIeFdDbFhoSTl5Mm5R?=
 =?utf-8?B?aEVENnJ4OGVKb2o1RkpnRG1RNGJLNnR0eWNhTm9Tck5MRlU5WUkxWVdkWk92?=
 =?utf-8?B?SnBFS3VSUlY2RUYzQ2RoWmRxcC8zQldaRUZMR09OVWxaZUhkVm1zNzdqVHcr?=
 =?utf-8?B?b0pJVlA2YTIzUXZXekp1TlV3ZWhvTXdoNm9jZi9kRjNTaXZMZkloSnRjMW0v?=
 =?utf-8?B?L1BVeDh4bVFsYVJUYXVYWmIwUVMxTUZKcnVucExFOUc2MXpDOHhQV3hCUlpD?=
 =?utf-8?B?c29VdGVmcUlxRWh4OXVXNVFPTlRXNjR6RkxtbDF3eG5qWXdVbnZFOGRGOHdr?=
 =?utf-8?B?RXhzbysvRG5PNWUwWjZOekNTdFZnV2JsbGNpWXI4SDFPUHMwYlA5ZGU4LzRn?=
 =?utf-8?B?KzQ3TkdRWDg0L0IyV1B5b3kvbGwvcStLRmtjTFhvN0pMTEdGeDgyUEZuZEdx?=
 =?utf-8?B?dk41aGtuazVZemJoNTVWZXdIVkFtVlJZYjRIQkg2ekNGYUV3QXNObVZrR25V?=
 =?utf-8?B?Z1RKK0JYai9CT2cwSXZRZ2hvU0hvMWE3M01YazdjZ05lSGRwVVJyaWJSd1o4?=
 =?utf-8?B?aWVYZUpXODlzdUhneEVoVzM5NVJjM3VweGVyNk5ENXk4SWxyRU1abjEzbTJl?=
 =?utf-8?B?Wjh5cjBtWjRUSXdKUW1HWTNQTS9lVEVVaEtBQW1xbWZHQisvZTRYSVJVU20w?=
 =?utf-8?B?QUcxazc2L2RTVjczVkZ1YldkTVk4bldaS2IvY2VxY1prN09XL1Z6bGM4UVJz?=
 =?utf-8?B?bnRvK2NPRm8zWkNUTUZMZC9JTUhqOWxGci94UzlJdzd0REN2NndWOGQxN1lS?=
 =?utf-8?B?eVg2a0dvYk9paGE3RDlDdmthV1FJYnpmZlljSDg0dENwamZhTERxN2ViSzQy?=
 =?utf-8?B?SjJ4aHQ2Mm80eWpXdXN3anVBWlBIbC9zenhDQkQ0OFFVVFhXUkMvckpKb0lR?=
 =?utf-8?B?clpwMFBGNFc3V3FFczJBaWZFT25mTDhFMjByTk4rTW5pMmFuZXBlZFFBVU5n?=
 =?utf-8?B?bXdKWXlhcnR3aDh3bjd2OHd6aXI1WWpMTzQzN1huUTBLSVIrK0FWMEJSR0NQ?=
 =?utf-8?B?SDV6eE9xb0hlNVJHMnp4WCtOaEhHOTMxajNSbnVib3hBL1NpZDVGaTZxUUlQ?=
 =?utf-8?B?N0NIYmNkN0c5RnlmS2ZQTkwxUWhKTmN5U04xNkJKeWM0S1RMWFZqVWZndlhR?=
 =?utf-8?B?QU5ZYUI0WlhlUnR1YlFMdEcybHh5UVZGenZmQktyN3BlWGFOM1RMbGk5RGQx?=
 =?utf-8?B?bzF4UFBLWklrbEV2bmlaMEMrTnRCcEFmcVpScDVwR0lnTTI2TjFvRktyZEJr?=
 =?utf-8?B?ZTZtSW9wZ2xjY2Y1cGRXRldiT3ZCZmcwLy81SEV6V0U1WHVaMk9FNElKR2Za?=
 =?utf-8?B?WFRnM2VQeWp2NVRwR0tOejFFcDVxN3JaN0ZvTHA4YnNpd3JNV0E1SS90Y25s?=
 =?utf-8?B?SWdjUmlZM0VHSlJkcjNWNi9Hd0JuR2JNRjJoN3JKNzFBbm9tSWJkTUlRdE1V?=
 =?utf-8?B?a1VzRDFPdDZvQU5ZdjdCeTlxbWc3UXR0NUc0WmlPMkwrSE1kR242SVFacWZ1?=
 =?utf-8?B?aVVHTURPOGpLUSsweHU5OGRIdHNsd2JUMC9DdTdaY2ZtblpMT3VKS3Bxc3NI?=
 =?utf-8?B?cUx6T3VIN1FvQWFUek9jWjNrWGVKVXFZVVdYdlRwbTcrWk1vOHhNU1B6dHJQ?=
 =?utf-8?B?YzdsVXRpTGdMSGE3b2RvN3N6dkdPempvWkhJRzJyR1p3ZmxyNzBQaVpUeEJR?=
 =?utf-8?B?S1RmOFJHVFRRVElKc2llTUswVDhyVVVvVFdvSkw0dHd0QUlRNVBMbjM4dW8z?=
 =?utf-8?B?SGNjbDRGTC9EWFU4UmRvN1d0eVpvQUtHTmtuRE5aSGNyQXZhcFdUWkcvakhX?=
 =?utf-8?B?N0s3OE9ndDQ4bzNuelVTcWJNeDlpTFJPZU1jWGxiSDF3T3dBSmlob0RabmNK?=
 =?utf-8?B?WDV4c3QyMEtaRWI3MGhGZnZuRkE3VkNaaWV6aWJHakMwRk9PQ2JEbEcyVVlv?=
 =?utf-8?B?V3pINXNMTUpFNWxyNCtBcVdNR1BYeGxNcDdEeGNxR1RJZXFVamJLQ2ovWFhM?=
 =?utf-8?Q?hWwWUJAbTwE5z9cUmY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c69ab50-6f5a-4124-dd05-08deb96d773c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 08:21:33.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPDmt567/fzgHdT5ghUchnUL2Cmseu9zBNkvhoKKRvsfFl3Qerdmq5TjZkrPEVzv7Pvg7oDoY8MmoCwR73H0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291155-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.004];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davemloft.net:email,nvidia.com:email,Nvidia.com:dkim,pengutronix.de:email]
X-Rspamd-Queue-Id: A47495C1AC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMjMgTWF5IDIwMjYgMjoxMw0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgaG9ybXNAa2VybmVsLm9yZzsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+Ow0KPiBQZXRyIE1hY2hhdGEgPHBl
dHJtQG52aWRpYS5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsgSWRvIFNjaGltbWVsDQo+
IDxpZG9zY2hAbnZpZGlhLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBh
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDUvOV0gZXRodG9vbDogbW9kdWxl
OiBmaXggY2xlYW51cCBpZiBzb2NrZXQgdXNlZCBmb3INCj4gZmxhc2hpbmcgbXVsdGlwbGUgZGV2
aWNlcw0KPiANCj4gV2hlbiBhIHNpbmdsZSBOZXRsaW5rIHNvY2tldCBpc3N1ZXMgTU9EVUxFX0ZX
X0ZMQVNIX0FDVCBhZ2FpbnN0DQo+IG11bHRpcGxlIGRldmljZXMsIGV0aG5sX3NvY2tfcHJpdl9z
ZXQoKSBvdmVyd3JpdGVzIHNrX3ByaXYtPmRldiBvbiBlYWNoIGNhbGwsDQo+IHJldGFpbmluZyBv
bmx5IHRoZSBsYXN0IG9uZS4gVGhlIHNvY2tldCBwcml2IGlzIHVzZWQgb24gc29ja2V0IGNsb3Nl
LCB0byB3YWxrIHRoZQ0KPiBnbG9iYWwgd29yayBsaXN0IGFuZCBtYXJrIHRoZSB1bmNvbXBsZXRl
ZCBmbGFzaGluZyB3b3JrIGFzICJvcnBoYW5lZCIuDQo+IE90aGVyd2lzZSBpZiBhbm90aGVyIHNv
Y2tldCByZXVzZXMgdGhlIFBJRCBpdCB3aWxsIHVuZXhwZWN0ZWRseSByZWNlaXZlIHRoZQ0KPiBm
bGFzaGluZyBub3RpZmljYXRpb25zLg0KPiANCj4gRG9uJ3QgcmVjb3JkIHRoZSBkZXZpY2UsIHJl
Y29yZCBuZXQgcG9pbnRlciBpbnN0ZWFkLiBUaGUgcHVycG9zZSBvZiB0aGUgZGV2IGlzDQo+IHRv
IHNjb3BlIHRoZSB3b3JrIHRvIGEgbmV0bnMsIGFueXdheS4gSWYgd2Ugc3RvcmUgbmV0bnMgdGhl
IG92ZXJyaWRlcyBhcmUNCj4gc2FmZS9hIG5vcCBzaW5jZSBhbGwgZmxhc2hlZCBkZXZpY2VzIG11
c3QgYmUgaW4gdGhlIHNhbWUgbmV0bnMgYXMgdGhlIHNvY2tldC4NCj4gDQo+IEZpeGVzOiAzMmI0
YzhiNTNlZTcgKCJldGh0b29sOiBBZGQgYWJpbGl0eSB0byBmbGFzaCB0cmFuc2NlaXZlciBtb2R1
bGVzJw0KPiBmaXJtd2FyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBDQzogYW5kcmV3QGx1bm4uY2gNCj4gQ0M6IG1heGltZS5j
aGV2YWxsaWVyQGJvb3RsaW4uY29tDQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNvbQ0KPiBDQzog
cGV0cm1AbnZpZGlhLmNvbQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNvbiA8
ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo=

