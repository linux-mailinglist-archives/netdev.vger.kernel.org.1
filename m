Return-Path: <netdev+bounces-291150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c4tXN6WpEmr92QYAu9opvQ
	(envelope-from <netdev+bounces-291150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:32:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E45C19B7
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A40A300E244
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3922E3E9;
	Sun, 24 May 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvNy+bMd"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE842A82
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607970; cv=fail; b=NpvFkdJXjeJtYDCFYcVSqjfhkQjV/DIawTpPT0hUE4TvEx47w5Q3P0uBYhzAIIeGoo2Hdr/z+JhO7TGY/UWz8OU0l5ZKgwoEsOVhv5fwvzwZWVrabLNK5pzRN3h2iBywPqst3RKjH4ItI9XmL2uxuPmepDh4Qz3OjJeOtXb/rA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607970; c=relaxed/simple;
	bh=vK1B4pohXqzFYJuE/hhnNnnPhVia3DndB9eKcl/eioQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNLlu/718o1256+gWRi//LihIQS+5wcvmniveXkJdat9G9AyvlB4GKJc0lGJJ6rQl7r4Jl33lKgajWBBh4O+DmAux23wouY6ymKvwNnBZGY4s+cmO/qC0cgvf8Y72atPQyJhMZdtS3GRRiHE/9tM6FZN9EV9FgkhCsTRnDc5WUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvNy+bMd; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeK44ZhCkBC9NWFEbpxhnvL5rQw2jryWd+rwXP5kh5j7MnfLEuaE+RF/i4shMB0HSTdWpKMWHB8jztdKpuy0K7uKUVsrv0fU0t/fqEX8K2lQmj3CP1UB0UuKmEJPh7rlkAjejRzoieNUaXNpZv5UbSxTdhXBbXGkTrRctdonue+CpX32rNB7YsvWcfM4CsT9YUFSGhvheVxIzfokO3+a33M6/DukOdLlxPXDmjjwsHKJdDVTJE/LvpAy38AioII0VKapiQJHIk8NfGY6LAc+M0UYGyVFVlWlCM5bBdwqcHZEG1XRhuTIb8e1hmAD9hF47jU8ssysDYuRpQk6n5cf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK1B4pohXqzFYJuE/hhnNnnPhVia3DndB9eKcl/eioQ=;
 b=DCjcDK4UNh7/l5e1nOk6SSpOV8y9mlYo5EUApsK+RdVx/irp2gB0G6X3QN6XUXFJuY4iMoB0Bd4pTDvYng+4Psy9Uk8hfOU7rInmWxwC2XLR+P4CLOpWVNHwcfCMVEuVToOJa65p2X3H2hRzt2ApEVaqKzgjR7FrvKmonFBnM4olDGSxpNMlpvNXf1mCJ1w3HKF2YDDl30BGfx2CWG8dca91T4Lv0SY+Pn7Cz9dTX/reiDOBQgtBGZ1h5GRtsnlAawCjBbUzzrDsOjnf9oq7CxFrMXKhX6x/9I2Yo3VYdEUo+DLj+hxFmItPrrz3uB1rIGKNVU9vPy7alV9Po6fuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK1B4pohXqzFYJuE/hhnNnnPhVia3DndB9eKcl/eioQ=;
 b=SvNy+bMdOtrVLrN/1CPODUvpmSoYZfDk1n0Ewmei5zJAckIHZ/Hetk4TALcigQRURRLBDLTjvxTGKkodxNnmhEweRGgNULeZh5gQTgYWb4a08cwqhDKme7ZigTnPDWLI0tWWWjpF1xrm+Sv/SaISjNGZLAjq6f/2nQ6mZi4oYROwLynMXBp2aE7v0vdpb8HDmmyY1xOFlscUu65Ohet20UETRe09GhVMQIXd2C62TIkDHd52+2kQzI12YROwrgrUlE4cy+hR//OnwxN7bABjM/ztywtHign+WnDWPXfshaIQoQqbEFDLKAoa0QQ+DtDWowCcvtdmdqTG07z+9hjkvg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:32:44 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:32:43 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "kees@kernel.org"
	<kees@kernel.org>
Subject: RE: [PATCH net 1/9] ethtool: module: call ethnl_ops_complete() on
 module flash errors
Thread-Topic: [PATCH net 1/9] ethtool: module: call ethnl_ops_complete() on
 module flash errors
Thread-Index: AQHc6kCZ1NnB6bMFk0ylZ4+b4dOcpLYcu9dA
Date: Sun, 24 May 2026 07:32:43 +0000
Message-ID:
 <DM6PR12MB451664C459C23151C8BC5B85D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-2-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-2-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7641:EE_
x-ms-office365-filtering-correlation-id: 1dee00f3-0ed0-4b9d-d70c-08deb966a4f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 l7h5ZcW8d25I0d9LWbtlTenqgLcVz+nKLSM0xEeU+27SeSqdcMWZlcbeoe5XJqk8rTbsNaTWdaUgMUJw9FGRMvFLMBuXc+RRtAhXwLzjBXf1krcG+JYmTs/Onc/cDDMizDNeDFFc1532fnRNg11XHpHSZqvsQvfynYs170v+cnqQ9vkn4zYGufLggG14Knm1a7QAMRCWFFGUEqhovaoodYKxxJdFvY1jvm+fAaPLCn6nCGRNpBzGVtnV0Rz6lvMjJoYjugBrsPojfKJVnowaBjW+C3ujLIW/+7i1OX/+qzruqCJ/rd9pxQ6XSfXR7EV59gTcIT2RksJZswtsHcvfA6F6SfD82zSDwybiy2nA9Gwx3/OnNjwuVXG/hA0xUsec0S/cfGLWWtjoiDX/UZF74zUeT0svTZy7VOcPfHYdNkfXjsHy8mjlUUSe0MIhhfuTkQiptiuuXcN/Ynt7RPI+m3n1LPdYWbSYgy1yx6jkvpKatuD6YhyTq4CpJjagvWUWAGxD5qyPpqwpKZXAJqEuDPI8QIiWqrFV8gH+HnuBoP7XJX+gIQS67uB/CJE/dxjKbQOZRq/cqkUIggRHC49JU1XEOASDiJrsPyod8m5I2QkzuF/3HGq5ZYJC/lsHi4bru1B3yNJIePQYl6ivMsVUnrv0YYkhkHKnaTzmdPQ/NWT9mQSF/D1VgqC9Mjf2SUlGbs0WddV8tJmVN8fMJfUFClL0fvjiMoqF/yVMYP8C4zfUkwCBeRlGCLBdVNcKBFkC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWFib2RsNW9uV0dJS1Bxcm1sTGdRSkRnWUdOK1hKT3ZaVEpKbzByK1VEVTFQ?=
 =?utf-8?B?MTc1dUtWSURUZFlVYWQxS2ZyUmpqM1hPK1lUSFRrYzZ5Tm0xZEp4S1M2REdn?=
 =?utf-8?B?K1pQTVRvTHdYNVV1djBLeW0zcDE2bEhpNTV0eEZ5aG1NL0JQOXoxOEJiNWxj?=
 =?utf-8?B?NDh3RC9PTnE4SHhZM1poYnp4QmhVRThzR1ZRM1JTd1R6UGFud2toS0Q0SXdQ?=
 =?utf-8?B?cGllWGVMSmNGbmtzRFZyYlhUUEVOcHRiOGVxM3A4SXRRY01UcnhUbnRpVWdv?=
 =?utf-8?B?UzhTbWQrUlpZT1dZdkpCVUFMUHlkL3RDaGs1Z1BjbThEOTR0STFaMTlzdFhj?=
 =?utf-8?B?SWtlNURZQkc1NlZ1R0tDbi9COXlWdFdEdWxUQkdQaXdnTW5JUTRkcVFTYlk1?=
 =?utf-8?B?a2FjQWpwVVpSamsxdzF4d05HbkYyOFU1cFdtYTZ3TWNMakJlb0RzbStVU0x4?=
 =?utf-8?B?akd0TEZ1SXo1T2dmZHBTbWxCeGMvckdPYVQxb05HdVhkWHgvRHk1N1ZETFRw?=
 =?utf-8?B?YXpkcXdTeU1HUGJQTllyWVlVUE5tSDNwZzJJTTYvc1R3bDdWbWJqZmM2TDg3?=
 =?utf-8?B?aU1HKzNIazVrWmZyOUFTZFpXUlhXRDBibTdPaFBNZW4rQysxN05EL0JiRjJo?=
 =?utf-8?B?NTBodWZXUjRST05mVnQ4dFdyRC9OenNVVmdOdUpTaGQ0bWJlYTllWE9mbUY2?=
 =?utf-8?B?czVCZ2NWZGh1L3FDZjZicHhBTVluelNLVmtSc1czdWRiMm5qbStPZGgrbW5K?=
 =?utf-8?B?UjFDeDQvb2xYRjAzNzNXRmxWUjI0b0JmdkhtSEhJUy95Ty9IVUVlK3NQVW9D?=
 =?utf-8?B?aGZlc1lCckZOajc3aC9ueXQ0RmJxaGozU0F0WHVFNXBsYTlMeEJBZGNpbUZI?=
 =?utf-8?B?c1IzZTZKQUZLUDdPb1JDd1F5eTZvc3hOMjhYZDgyNDNGa3krVUd2OVcvOVhZ?=
 =?utf-8?B?S2JoQndFR0dlb3FxR09HcEtNWmQwTGJoU1hOUXRmaVBzVzNzZk42bEVHRW82?=
 =?utf-8?B?RTZZSzVmL24rUk9ibmxkdGdRZzVnbThURWptRTdmY2hnZy8rdXRPbVJIVDVr?=
 =?utf-8?B?S05RWi8zS3Z2dll0emtaclgvT2YrUHBZU0E1VTBBcDdubER1RDFLR1ExdjZz?=
 =?utf-8?B?U3l1NUZtZHg5azh3Nmd2a2svdi9GUERVd0FtQ0ZCUzZ3NUQxaU5XYkNZM2hV?=
 =?utf-8?B?ZHFPSlhreXVtU3J2L3NRMm5pNzBPakxvSFNxNEpscVRZaExDYnlWMzZEaDZ5?=
 =?utf-8?B?Ty9USzBMY2RnMm50N2lxbDJJUExScDJiVUxFY3RzVk82OFdqTThRaE1pMDM2?=
 =?utf-8?B?LytjdEZHTExtenRucUZySzNlczVzKzh6V1JQWGNpSFhPQXIxUWtqcVFucG9I?=
 =?utf-8?B?OFhlY3FocENoRTZtYlUyaXRGT3doSXVsVUMweU9ULzdTMzNZNU5IbDloMFF3?=
 =?utf-8?B?VWNOOUVqeU55WXk0WUx2RHQzYkpkWFp2dFMyeFBPcERGMTdNdFhxU083cXk3?=
 =?utf-8?B?b0drOWpIWjBTYVJnUXJ6ZDdYSy9HN0ttZEY0VExmYWR0N3NBUExQVWhaUk5x?=
 =?utf-8?B?ZkJNUFVjd3J6QVhMaUJzTkNXMVRnZ3Z6RW16elVoRTJEWmFQZlN1UWRqQWw0?=
 =?utf-8?B?ZVRxeXFUdEVpbjRrUTM1WFU4REtmdE8vcStwSEZnU2FtWkpIZHJUWkhXa1d5?=
 =?utf-8?B?RmxCUTZJdnZXUkExS2ljSWVKM0E3bUtsc0d6RmdEYmhoVnI2TkVqZnJ2QVZl?=
 =?utf-8?B?VGNVRzl6OEZ2Vk1UbVF0QUpSQ2RLdHZoU0JKaW9oWUJaU2FCREd5QThFZXk2?=
 =?utf-8?B?NHpISG1nSmtEbjc5eFR0QzdiYWJlRGRsTlVTWmgzNU5Va2lld2JWbjlYYlZN?=
 =?utf-8?B?UUlmNXEyVTN4ZzFZd3dscXQxd3g0SUdDRmljTi8velZ2VUUrYWhsaDZhdmJB?=
 =?utf-8?B?Tmh3R2pnUkZxTUlGemtmYkxrT3JCKzJLV3g5cUdkS25CRWJiUS92QXJmSmlK?=
 =?utf-8?B?MTJTbURrZ2psRnFtaEZVM2VtRXZocTBGWnArL1dQcDNYaVNtOUVlczRsbGVS?=
 =?utf-8?B?cHBaNHRPYWVrYzBKem8ybFh0ZWlLS2pxMmpIU2FZNURmTmdIRStsMmc0d1pp?=
 =?utf-8?B?bWpOWmRyTTEveVY0dDZZL1VSbXovNHlyRWxNcHhFWGhibDk0enJlUmhxKzJN?=
 =?utf-8?B?QmFwZ1k4WVhOMkFUUzRobVBNclQ0RG1RZlFwZGZGVW5XRHZBMkg3bEhlbk9W?=
 =?utf-8?B?WDdFQWpXV0haWkFWQ1pQclpVU1BGRUtoSE9ZQUZsek9GS0JicHErQm1ib3A4?=
 =?utf-8?Q?MjfQQ4g/r85LXGjfMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dee00f3-0ed0-4b9d-d70c-08deb966a4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 07:32:43.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSyk1HQkT68QeHj5FEdLRs3O/8hQ/1dJWvHCmqmxPRxR+GRGVQVH6w+rr3ddL86M0DKA/tMMzdVRqVZSwhlXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
	TAGGED_FROM(0.00)[bounces-291150-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.015];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,DM6PR12MB4516.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 553E45C19B7
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
bmRyZXdAbHVubi5jaDsNCj4ga2Vlc0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQg
MS85XSBldGh0b29sOiBtb2R1bGU6IGNhbGwgZXRobmxfb3BzX2NvbXBsZXRlKCkgb24NCj4gbW9k
dWxlIGZsYXNoIGVycm9ycw0KPiANCj4gV2hlbiB2YWxpZGF0ZSgpIGZhaWxzIHdlIGFyZSBza2lw
cGluZyBvdmVyIGV0aG5sX29wc19jb21wbGV0ZSgpIGV2ZW4gdGhvIHdlDQo+IGFscmVhZHkgY2Fs
bGVkIGV0aG5sX29wc19iZWdpbigpLg0KPiANCj4gRml4ZXM6IDMyYjRjOGI1M2VlNyAoImV0aHRv
b2w6IEFkZCBhYmlsaXR5IHRvIGZsYXNoIHRyYW5zY2VpdmVyIG1vZHVsZXMnDQo+IGZpcm13YXJl
IikNCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4g
LS0tDQo+IENDOiBhbmRyZXdAbHVubi5jaA0KPiBDQzoga2Vlc0BrZXJuZWwub3JnDQo+IENDOiBt
YXhpbWUuY2hldmFsbGllckBib290bGluLmNvbQ0KPiBDQzogcGV0cm1AbnZpZGlhLmNvbQ0KPiBD
QzogZGFuaWVsbGVyQG52aWRpYS5jb20NCj4gLS0tDQo+ICBuZXQvZXRodG9vbC9tb2R1bGUuYyB8
IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2V0aHRvb2wvbW9kdWxlLmMgYi9uZXQvZXRodG9vbC9t
b2R1bGUuYyBpbmRleA0KPiBjYWQyZWIyNWI1YTQuLjc0MWY2ZmIyNWQ0NSAxMDA2NDQNCj4gLS0t
IGEvbmV0L2V0aHRvb2wvbW9kdWxlLmMNCj4gKysrIGIvbmV0L2V0aHRvb2wvbW9kdWxlLmMNCj4g
QEAgLTQyNywxMCArNDI3LDExIEBAIGludCBldGhubF9hY3RfbW9kdWxlX2Z3X2ZsYXNoKHN0cnVj
dCBza19idWZmDQo+ICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+IA0KPiAgCXJldCA9
IGV0aG5sX21vZHVsZV9md19mbGFzaF92YWxpZGF0ZShkZXYsIGluZm8tPmV4dGFjayk7DQo+ICAJ
aWYgKHJldCA8IDApDQo+IC0JCWdvdG8gb3V0X3VubG9jazsNCj4gKwkJZ290byBvdXRfY29tcGxl
dGU7DQo+IA0KPiAgCXJldCA9IG1vZHVsZV9mbGFzaF9mdyhkZXYsIHRiLCBza2IsIGluZm8pOw0K
PiANCj4gK291dF9jb21wbGV0ZToNCj4gIAlldGhubF9vcHNfY29tcGxldGUoZGV2KTsNCj4gDQo+
ICBvdXRfdW5sb2NrOg0KDQpNYXliZSBpbiB0aGF0IGNhc2UgdGhlIGJsYW5rIGxpbmUgYmV0d2Vl
biB0aGUgbGFiZWxzIGNhbiBiZSByZW1vdmVkLCBidXQgaXQgaXMgbm90IHNvIGltcG9ydGFudC4N
Cg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQoN
Cj4gLS0NCj4gMi41NC4wDQoNCg==

