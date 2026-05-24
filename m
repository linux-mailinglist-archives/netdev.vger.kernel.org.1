Return-Path: <netdev+bounces-291153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMfzAwKqEmr92QYAu9opvQ
	(envelope-from <netdev+bounces-291153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9725C19CD
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482533008A7E
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DB3603C9;
	Sun, 24 May 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MN962ez6"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742A22E3E9
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779608013; cv=fail; b=KoVMDFSjUwr7Q9L3GIkQsG+n8ksJmxc8UFlmt8obk5wIp0giueqF7yH0gyaBixF49fc0oxFAIpZu7/gEaKSo2tzhK+GYjINUogA5NDeodVZ1FbvaJakptgb/07s09hJ3XZq/2/cCe7PSLtelaNle+rqyl6lk5jKOo2jvmRYtw8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779608013; c=relaxed/simple;
	bh=nduI7ZVW3tMr3qnVUOR0Gb/T7wcj+PFUKdBWLxd9jLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMZjOLG0E89GvYxVefqGQ3sWFLjqFlQHTOAB98PKavxK42+KDzaeXKJskJS+IkzmH+C9IqssemYRFuVnNNxFK2Od3Kvr46LHM9txKLBEpPoQJny8ZqR3/Z9iFIeJFmrJyQFvkjPN/9uoOfDC3FqK8AhBYJmub7rEQx+ckM0XLSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MN962ez6; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXm4+PRPJgNoYeQREn1LFWFcvDaBhPLndC/aqFf9BXMQ2+PgOJSQBgWiHyDnyYX8yM1OKq1Or+Zr0om/aPfrqqbBQ8ViHSCMMbIROA16pcC8OAlCZ2vU1xRMkXTycURf/m8M18TVbb2qIizES4HIjh6wEX5so220kZ+Rfy+bzYQpBbfz4RLT39d8KVlhFGOK8OqlrQytOFSxW5PA6IDnTKgT+i5S9c9kexNbTSYmZpN/BAtEEbSqnlpMA72s5N1PfgocNYSYKVJlDd69Nxxfm1x06u6D4OmBG5MvAZJtwx04VxlxX0BcB9Wl/Uj5+iu2taRTHwVrhj+/8O7jPizF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nduI7ZVW3tMr3qnVUOR0Gb/T7wcj+PFUKdBWLxd9jLA=;
 b=QIf9YENKUCTfZUbCtPjUoQgk9j3mSpa1ZiV+VJS816ptBga/hkJr7tru2LUotrp4yH3lL3AKgzTJ0mjgxGBKVh0vschCeHzXf2IqA2LZzLv/jYpmKvecMU2xSePrcGF4Vb3X3H0mXVKUIdu14JaVCDZY0ee1ik0biMxm3Lv5hdyea1h7AfQ2kr+XIeGK+0zQKvHFcV5IZzxcKWqESA2i4xY4Yw91piXLEmP6JsO9gHnoehpF1oqbj5wOIgHU5GG1m5j+gX91tU7X5ChHjIM0cERjeEUfmkiM7/NYppgTjwrwAgNePe2AexlmpgbJjabjvXXe8o3GR6TX2FYRkEh4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nduI7ZVW3tMr3qnVUOR0Gb/T7wcj+PFUKdBWLxd9jLA=;
 b=MN962ez6uIbFFJMHv0JCOIWtDU+ucbqkgKy+WSMp9kohzwz92+ppCsBdz0J0fNvKmAtKjSxB1SHguX1vfCUIPkqY7begPb12O6sp5qy6usx3t/REDkxgBnynZmHl9MJfi/qmdg/pNKmsxN/02GpvwkF6nHHhxdYLB5hDn1h1lmFxMEyHsgno4Cqu0G67VKIqM8vZVcenGbmGhFvaTUYTb+2FAKGajhsi6TGmaoCj1i8urwIkz/1i/NOqbDYwYntioZpDXuDrBk+APdJ8njVox/Fg7FcjIQQjasKIat/kd1pw6VlHhIeB2U8iwcxT4g8qbzVFgF3q9PGj58kJgqobUA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:33:27 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:33:27 +0000
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
Subject: RE: [PATCH net 3/9] ethtool: module: avoid racy updates to
 dev->ethtool bitfield
Thread-Topic: [PATCH net 3/9] ethtool: module: avoid racy updates to
 dev->ethtool bitfield
Thread-Index: AQHc6kCZzMUhi/WC602sa2J9dfTkYLYcx1YQ
Date: Sun, 24 May 2026 07:33:27 +0000
Message-ID:
 <DM6PR12MB4516E58A1061209A04D485D1D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-4-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-4-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7641:EE_
x-ms-office365-filtering-correlation-id: b61f0bb2-3741-472f-3f65-08deb966bf1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info:
 wcOybQE+pvS4kAnzBVmR1xBPGil22C3LHQYvD6/DlIJUoGri7krzzUdz0b4GF0imcxaBpqBKXZbkyCS+PxpDMkZZvrio1UMhmT469NjhwM0ccvJAlRUNCFLs4sSmv/hhcFUPlD2JpPwKa7SZCGMHPk8nzuH/z8EAtqcMhW6OsKUNc29affQJ05yxRFbpCeLZqsDSQRUF6s1AXQUJ6ursKdtVHh5vUjkitH/kAsdlSq4YkVnCkdYmC2HJ2Q021HbNFVQ+cz3yE1AxX/+y9u1Al3gUzHktPrwji4NVvdQWyFUGoTVyR2FN22n/3Hh4YYMWjzU/OBvdoJmLH8qERso9NE/SPZa15L7WCtfKNoa4ysLirozbiaHKhXtrnkX2E+neC5zXs6DZCi8r2UmzB7puGnQUTfMQtiei5+iYFl7OjUo8BNC5EfkcPGe5ZfuX3nV24TS8pAjbjhiESMh3epoZjM1b+lsFvDNdkexHMmSnzMTJERh5/FLr5tQ5cgJEdyf38kRxaPhKBVS9NB0f9V2YcIQggQZe7FPKw3Cs0rPQy/5ufLOWqE6hAtM5/HsOQ32OPI/W5SHZvqb4vobnCR/Hkg7BL6YOwi4oHASDDVdR5yTe2sCulHl6MF2iRJB/9ZFrJmLlzWlPL2iGk/LsVaroQRd39srOMeWigrCxWtrgXSFnD6s2nMw3bys5sPFJheNV7APip75YzaxcIibPCvS89N0rTsWlF4MZV3yIHsbcG/ntbm5pNP8ksoWut3KEf67c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b000cm9yQUo4NSs3ODJKb284eXRpVjYxUHp3dTU0TnZ5KzBCNGdnUDBSUEhB?=
 =?utf-8?B?SHFyOElVU2ZvYWREMVpDYjl6Ui9Da3dDZnVCbERRalFjZUc4K29JdkNDdjI2?=
 =?utf-8?B?STJUQ25KOEgwNmRHNEEySVgveXVCT25WVFp3ZEpmWUhzZ1pQOHFaV05hRVFU?=
 =?utf-8?B?SzRrWUx5WCtBMGxmMG9kQjJzbWZKWnMrQmxLRFlwVklweDYrWDRtclI1WmVP?=
 =?utf-8?B?eFVySk5CVHJDK29DazhOVDZTa3hEZU15NjJTZ0JMTkVQdGROVCtRdmlSSWky?=
 =?utf-8?B?YXpJUGJUVWhBdVFrMWxtajJvTWp3aytFOE11TmJqS0V4TkNZZUFaWXEzRDNB?=
 =?utf-8?B?M2w4bXBZV2hSWkwrWVBadnE1ZHFuY2N5V0FWMktVeHN6Y2xCMzVMd2tYUm1q?=
 =?utf-8?B?blA4SzFiZ2VjL09FaTVFYytuOEkxNGZjUTM3dXYyTFlVR2VXLzQ5b1lTQjVj?=
 =?utf-8?B?TFlnMnBRVnlvNW1KVkR5ZDhGR1lvK3crdWxjeWhDeTBYVkgyTGx3bXpjRC9s?=
 =?utf-8?B?UldtYUgzUW5Bd1l6K3AxVTUzN2FuQnRIUm5JVllwU1k1WlBzMmVObnQrNlhI?=
 =?utf-8?B?ekR3SU8rQ1Y1Wkg1Mk8vcXlGenpxTTgzNTlwTGZsRHBheS9lcWcydTRSeCtm?=
 =?utf-8?B?SkdJTWtRR094d0d2ckdPbERSdE94eXYvaExtYlRmRDFGSThoVE15cm5aUVFr?=
 =?utf-8?B?WVVzRTBIc3NraTBPM25BY1VNeVorRS91Wi9EaGo5SUF2a3IxTmZiTEhiZzkz?=
 =?utf-8?B?Q2t6YldTRmd4Uk93bGpmb0tEN1dPaGh0MkFMeURNczB2M09vMG8vWWg4MS9o?=
 =?utf-8?B?dmNzSzVNMTN4eEx3SGV5Y3lJSllEQ3k0ekVEQjhqem5EZ3FUby9VZ1FhU2ZY?=
 =?utf-8?B?TVVpaUVNZUVBNmlSclNZN2pyUUF5aHdsSkFVQUdUTC81VXUvZVI5WmZubHQ2?=
 =?utf-8?B?OTRaR2I0Z2tzUnEwY2RTbEZON3krdjhIUVlMRDJBZDM3elNwbDYvM05JSTFK?=
 =?utf-8?B?c0lkMDM4Wkljc0RSVWo3SFdoeFF6RkxlWUJtMSsrdUhsY3pEYlNmN1ZSc3cy?=
 =?utf-8?B?SFZQaFlEajBhcFFiWW50WlEvR2I4ZmxCK3c2VGp0L1A4OFpPS0E2T3E1S0p0?=
 =?utf-8?B?UzZBblRaSzFHaHEzWkxkTE5tZkFxQVhjTlhObWQyeFpobDJoNVdoOWZNZm9K?=
 =?utf-8?B?VGFDdXh1R3ZiRHBHeVEwMDFaaC9oVjQ0bDBFUTZKNzA5aFdvRDk4ODFIZ2JM?=
 =?utf-8?B?eVVSc3ArbW9qZU5jYW5TNkpGR2FhZS90OTNIL1lZeGlPQ0E0cWxHdTZiTjIv?=
 =?utf-8?B?L2NoVEIxNVNGcWovM3oxZERzRFc4OGh6WXc4MGhMZW1kUFhuUzUxZVd5bnpJ?=
 =?utf-8?B?VitjVGQvM0taNlFXb3ZiL1dvQXhIZnJZcVlZc2lzYVpwWm5WZHhJcG5xaGFP?=
 =?utf-8?B?aVNGbjlZOFlsc21hMVdDcE5ZWWhhdmY2aFE1bjM0VUxSNTA2VlcxblIvelVl?=
 =?utf-8?B?bkpBWVFWRmtad01VT2REUVY4UEVNTVFmQUgxTGJsNXFNYXU3cXlhelE0OGlm?=
 =?utf-8?B?eTYycFZGcWVkQkVPZHliMkJpQ0FRZG9CWDJuSUgxaTB5MHdUTENiVWp2MFlr?=
 =?utf-8?B?UlBKQnVMSTN6OExqdUdZVEZXWXNJT0xNd0xJbXl5bURPNHNvbXZCTyt2ek1l?=
 =?utf-8?B?UEx4eVlkdk8xKzN3TnYzTDlweC9ibkJJVGpzS0lFWFhkbHR5diswNWZRb1Zj?=
 =?utf-8?B?QWYrL2wrQU4rOWRXM21KVm1GN3NmbU9SOG1CRjVEdVNoRHZ6c3E3WW1yeFkr?=
 =?utf-8?B?dnA2QUcrdmlhWTdlajdnRXJLaVpKZ3ZaS2F0TXYzeXdIMGRRZmlRemFPSjh2?=
 =?utf-8?B?OE52czVWbnc0OVpzalo2Z1lNWlk3MXpYeThid0xDaFVWYzdDS3NlNTJpdlVO?=
 =?utf-8?B?UHB6aE9aVk5MT3phaGt1b01ybTZQK2ZEem5wcC9xSHAxT3pVZnpVMHRzZjdk?=
 =?utf-8?B?amd0eFBFcUNVb2JIbHI3T1ZQRkI0eHk2c2VrUTZpYjZ5cUpNSGdpaDZkMkVV?=
 =?utf-8?B?WGtxWno1S0JsTUFqYmhYd2M2Zng4cXRKd016Q2R6cXJrOGRnNUpMRjMzVVpo?=
 =?utf-8?B?Y3BrcVozeVJ1MlRxQnJCRlJzeEJsSWh1U1g5eGNla0RxWkM0S2IzczNiT0Jq?=
 =?utf-8?B?ZEE5WUdTZklVNlZaUGF4Tm5WSmZHNEpGbWJHdkpqd3R3V0ZSekZBMi9FN3Vj?=
 =?utf-8?B?cEFKTnVPNHlJTWV4Q0VQa3ZDOWVNbHkzM25wSVFMUFNKS0dKdmZFK1JlQSs3?=
 =?utf-8?Q?gNisadfMS+/86wXKnP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b61f0bb2-3741-472f-3f65-08deb966bf1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 07:33:27.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ufWV8a4QPVs61Td2gBAtYgRCKtku9xMF3Y5mLLCQ68n1+ZuFY89adNBf6nnXiYUQLCOwp0trmWavmRzRLgsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291153-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.019];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM6PR12MB4516.namprd12.prod.outlook.com:mid,pengutronix.de:email,Nvidia.com:dkim,bootlin.com:email,davemloft.net:email,lunn.ch:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C9725C19CD
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
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDMvOV0gZXRodG9vbDogbW9kdWxl
OiBhdm9pZCByYWN5IHVwZGF0ZXMgdG8gZGV2LT5ldGh0b29sDQo+IGJpdGZpZWxkDQo+IA0KPiBX
aGVuIHJldmlld2luZyBvdGhlciBjaGFuZ2VzIEdlbWluaSBwb2ludHMgb3V0IHRoYXQgd2UgY3Vy
cmVudGx5IHVwZGF0ZQ0KPiBtb2R1bGVfZndfZmxhc2hfaW5fcHJvZ3Jlc3Mgd2l0aG91dCBob2xk
aW5nIGFueSBsb2Nrcy4NCj4gU2luY2UgbW9kdWxlX2Z3X2ZsYXNoX2luX3Byb2dyZXNzIGlzIHBh
cnQgb2YgYSBiaXRmaWVsZCB0aGlzIGlzIG5vdCBncmVhdCwNCj4gdXBkYXRlcyB0byBvdGhlciBm
aWVsZHMgbWF5IGJlIGxvc3QuDQo+IA0KPiBXZSBjb3VsZCB1c2UgYSBib29sIGFuZCBzcHJpbmts
ZSBzb21lIFJFQURfT05DRS9XUklURV9PTkNFIGhlcmUgYnV0DQo+IHNlZW1zIGxpa2UgdGhlIGlz
c3VlIGlzIHJhdGhlciB0aGFuIHRoZSB3b3JrIGlzIGFuIHVudXN1YWwgd3JpdGVyLiBUaGUgb3Ro
ZXINCj4gd3JpdGVycyBhbHJlYWR5IGhvbGQgdGhlIHJpZ2h0IGxvY2tzLiBTbyBqdXN0IHZlcnkg
YnJpZWZseSB0YWtlIHRoZXNlIGxvY2tzIHdoZW4NCj4gdGhlIHdvcmsgY29tcGxldGVzLg0KPiAN
Cj4gTm90ZSB0aGF0IG5vdGhpbmcgZXZlciBjYW5jZWxzIHRoZSBGVyB1cGRhdGUgd29yaywgc28g
dGhlcmUncyBubyBjb25jZXJuDQo+IHdpdGggZGVhZGxvY2tzIHZzIGNhbmNlbC4NCj4gDQo+IEZp
eGVzOiAzMmI0YzhiNTNlZTcgKCJldGh0b29sOiBBZGQgYWJpbGl0eSB0byBmbGFzaCB0cmFuc2Nl
aXZlciBtb2R1bGVzJw0KPiBmaXJtd2FyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBDQzogYW5kcmV3QGx1bm4uY2gNCj4gQ0M6
IHBldHJtQG52aWRpYS5jb20NCj4gQ0M6IGRhbmllbGxlckBudmlkaWEuY29tDQo+IC0tLQ0KDQpS
ZXZpZXdlZC1ieTogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCg==

