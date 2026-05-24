Return-Path: <netdev+bounces-291182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFGBBZz0Empq5gYAu9opvQ
	(envelope-from <netdev+bounces-291182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:52:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651795C26CE
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6423007362
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747D391822;
	Sun, 24 May 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOTYOAin"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D133EF
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627160; cv=fail; b=KHf0ySGtmYLSRnfMZCc15r9NZ2BvdftHlA2Y33GfI3tcrZQlpFXrDk1Y4K/G8A6gcdXqid6fPyxhFOPp69SZZADXi7uavCcwUt0alokzRBLw2feaEW4GENpkWt3FWuilpbskzBkgu5q/Zy9d1f2d7hcgx1ucx/fFgQkYMt7hwwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627160; c=relaxed/simple;
	bh=8g55Dg7QRU8IKTZDaQuENoHmaot4rQItm3vmdi6FWsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jeRh9EioYac5rP6ZZ1jsJmdmSVWJTIn6hAax8Qs7DbknPnq0h+PM2k+0jARt8sq0pPfqSwnbJQO29s7CplAfxV4OXw95vAzI83KIOYaLuEGS2yMOW0XZqC0kx6ftgpY6b90zudQjBeyk78TEaI57tzNfNwGdyV7jQAo+wt5iLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOTYOAin; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhYtv60KZbgHWzZXgO+kNF3KUNcS780mrHznYjBPfVz0y/qQPDX/eLWKYBC1wtIBLwdR06xz0c0Cm7gUES/ZpU1tnidz1m/sjBAaq/w/ts7JeUlX8wKmbrHV/aEWcZFJZac9TP82doC8Q0FVUJ2Z4VjMIUAMT4XRpD5y/lGq7FY3Y1nGCFtjLUOnpFZM0A80ocHF59E3Bb7tUte/AuLNBlh6oLLt5hQ+C/kTLhwOnJ1GrxUEqfGcVRxY16b1aLgcHqZbokpDuTFhIvRGjl4e0vGXyOwMpqGyYrYb7jIOm3PICwsvILcEMfxcMD+04pofZ4DLbbmUErLWvTnB0yVX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g55Dg7QRU8IKTZDaQuENoHmaot4rQItm3vmdi6FWsg=;
 b=l7zgP1ncB5+Y2wfuhET10S4zDBQBy5OdY8MJSsWS1DREegIg+p0q9zledZEjuGyEVFq6ST8RDBtAzS7w1tEpBgqiRADgKIWV2YKYOhKlUMoiiiLKtqouDbYPWXoPrTn87mrEBcn5+2B+sONuTuhAcb3aQKE0eDw8b8ywNbwcp/NUaYwAVVYnxEFDGf8OicEAGQetumzakdl8tgtiVfsTSe9BbADzSJd1n1ooVcRElVhE0TR6x8jyY2mBoqesIwhfzeByEtb4q7dJKSyQFBe1SjUahDeKcZiV9YoPkeMpULxNizdU2IdQk2ZeoKs+2dV9+wj8drV4r/D0viRoS8gJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g55Dg7QRU8IKTZDaQuENoHmaot4rQItm3vmdi6FWsg=;
 b=sOTYOAinUDAFhCrAP4ozmnzNYYEdicFirmo91phmZgcWsc06Rr3CFr9cnVhQyl0NuJVR/hRxTLnGeVyL10/H7Z7KQZLUHAnLmT6zlfH91KSXmQObjYMwYq7dy/ljzGz70G0cui1NrVGpm84pJJtszTwJ63gqsuAsKjwhn4hANhxokI3qjBijSuG6Y5nBDf1iuM82NPbempinw8Js8yLAVS4XvXgMt2F8cgjk81Iu070qNoFCUjxK+Xf7EvtsCBd0VJAzEDQyl+uXijS16sqYJzJRTT/Es9+vZAqEd8kq4kqiV7ahaMTHWKjmAUe2iqEIIL0fr5F9u2P5xrhg6xgFTQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:52:35 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:52:34 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH ethtool-next v2 0/5] ethtool: Add 'pages on|off' option
 for module EEPROM hex dump
Thread-Topic: [PATCH ethtool-next v2 0/5] ethtool: Add 'pages on|off' option
 for module EEPROM hex dump
Thread-Index: AQHc54xILk2cgojfmU6U8VZE4NqBVrYVY0uAgAfF2qA=
Date: Sun, 24 May 2026 12:52:34 +0000
Message-ID:
 <DM6PR12MB4516614C2DB7C0FC9A25536DD80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <cover.1779190777.git.danieller@nvidia.com>
 <2db0b93f-d001-418b-b3b2-ac5c7276bdfe@lunn.ch>
In-Reply-To: <2db0b93f-d001-418b-b3b2-ac5c7276bdfe@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB8224:EE_
x-ms-office365-filtering-correlation-id: de38f67c-36ea-475a-edb9-08deb99353aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info:
 3BImDEQRRVbB4LK0vNFGSJkZO6YoX/9Ik7sduYVPZVv34ABOb+gumzc4tBbrWz/Vs1G/Veev4az4tGypA42BeHqGYm7px6T1ek5zP9fplhB/P/+pEj5mTeSo4IvwR6elxArBhQn6zbarHbPQZ+GlPXekmgSxyUXYQz9x3gM36305ip/NABu5z0rWLF747Sei2JCqTJTLll1CPaBuBnn2rKhz2BRcbcWSB2uPCscXnkxsVWoJV2/X7Cuy8mgEe8RroP/qZ56p+cpKqkZgq6pI6fd4spTzwfz2wJmmHaZTZ0HgTWwVfkwkEMPa9+Vw7IJRpa/3CjwA4dPBBuitaAPbySZO26WYCdYSq2b3Kuca1hcpBilZscKOAROBn71oabpyN0cWk+tTcLmWiz982JzYJ8MtV7SvlCEvy75H29ZI+KU2XqibTG+NeZnoX3Amx5U9/hkLLhs+AsRNrhdDEbRdu3PQ+h1x/CRR+DMICGq7uweogRZVNZQSoTbipLSTdClw3dXpZOP8H+3A5VRxFJRdK7SO3lhmBZNcRRW2zCKopFoCt4+m3EBmZPaa2/hlyEYS4uQwzaAhFlUHrmIKzEZYJWmBCFNq/IseehJFiKQMCws446xikVyVtjVSVOQQU/MtzcZ8ckMMRMN9At5rx691mrXWMCZmqULcdbxboDBuGx4J97FFk8froKFqK8f0/1Sg5Y+jQ5e/OJmdMednMvT7rwawly4mcwUuK+lzHGIO05keo2uBdg1vzgwPhjsB81q4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFA5T245NXJtbVVTWnVVUWFlRFpscU1NTHJ2emx6Z3RvYXVBMmkxdjJ3Z2lL?=
 =?utf-8?B?NWhPOVZ2YWFodzRSMkZEcWRyK1VkaE5vTU5QbmxiVlBqdTJGek1CU3JsdEpU?=
 =?utf-8?B?Ym9jSWpBWXNJdDF3aG4wS05NckNkeDUxMktMemxhY0Q0UXUxbjZNRHcxV0xn?=
 =?utf-8?B?c3FhSnFMK0U1eUJaSk5Cem9hUXhvTkpCMFZ3R0NQczJsQ0NTa0NqdG1VOE5P?=
 =?utf-8?B?U1ZhS3NkNUR1OWcyZkJ6Ym55MjIwOG5pY2xvQlIwLzlKY3JGRkRBVGpWRnRt?=
 =?utf-8?B?ak1uT0k2Qmw4Vi9YUEpnQmZYenRkNlI0OW5Rb2ZWTCtvQ0FtNlBCa2VubkdN?=
 =?utf-8?B?VWlVOUx4WmpoOEpaQnZqYWZMMThaMjk3ZGM3VnYxSXBnZmN4WUVERTZpVnlw?=
 =?utf-8?B?SVhYdzliZUY4M2VpQjhrZHkva293Y1ZJcFFKQTVqUlpETURCQUtLV0xWR3dk?=
 =?utf-8?B?OXRGeG1hQ0JzRTZnZklzajlZVWwyM001aUFJRU1QR0k2VFAybjZKbzh5cW1D?=
 =?utf-8?B?LzI0c2NlMjhnSlVOTWZWdVo2V1NtdmZsYTFWUHl2YWplQXJhNUNiWmhTZC9o?=
 =?utf-8?B?NHBvUXF6N1U4L2FLVmlib0RsN3lkTzlINkk5aGx6ZG5wdG9Eb1pZbGRjUGVa?=
 =?utf-8?B?ZVZoNnB3K2tCWHZlamZhTm5LdDN5dEt6TnRvSWdqdmk5dXVXdlVnd2JGb2Nw?=
 =?utf-8?B?SnQ3T2xXMkdZbUp5YlZyMmVSQWQvSFptVXppeVI3azhHcGFFcEp4MnRSWE5q?=
 =?utf-8?B?UHlUSlF2a1VzWWczNUtuRHU5TlhhSmFERExRN0tEdFNJSk1HK0ZSMjVKemRN?=
 =?utf-8?B?WVJTL3dtSGhmNnhtT2JFeDVOQ0tLZ0lkdzZaRnlXUHFXWEVtaVNDN2JXd2Zu?=
 =?utf-8?B?K3l6NExKbjUxSUxkcjdVM2RQMkJwdlpWVVpXVUQvbWRhS00xN3MrUGlGc3pR?=
 =?utf-8?B?RGZhdWE5cHphMWZtRmZqS01XYUhyZTZ1aExZdFRMZjFCUkxoVXNUSEFrNitW?=
 =?utf-8?B?ZUY3MHZKTjR0RlBBclBmYzhldEtXdFU5dU1KYmxrNjJLblFsY25HY1ArQ2hL?=
 =?utf-8?B?ektoOUZrR0R0WjhRdGtwQkRJSGpoTjNHZG1qeHVhelBleVIwc2xlYnNxcFJx?=
 =?utf-8?B?UjhVeUpDSE9DQXNETVBUZVpWR2JQL3BpNHVMOGdEZmlnZnhWNjZtTUExaUJB?=
 =?utf-8?B?cU94enFuUVZWZFZRZkJaN0xzMHlLbTZxZEkzTjJ5SGJCZnVBNFJWZkhodHpG?=
 =?utf-8?B?RnRWczlqaXY3Z200ZWwzakI5T2k4R2tvUHRySzJlaHNaaHhPWWk3WGtQNUNo?=
 =?utf-8?B?RTd1NTVUR0QvcWhMcmZ3TEJOL0Vma05oendGMkZYekVMN1hwRm1laEhMbUZ3?=
 =?utf-8?B?L3phRk9BMmhWOTR2WHRXWG9tV2JObDl0Z0ZodzFHblhjTVR4S1J1ZDJvZ2Mz?=
 =?utf-8?B?dGw1M0NmVmdqWXdxRm01VDlnUGx4UUdSNmxPWnEvbG9JOUNCTTR3emd4bXNR?=
 =?utf-8?B?SkxabWhUWDI0SXpBZy9zTFJKd2R2bEZZaldBWHNEaUlxYXp5bDVkTXgxc0Y3?=
 =?utf-8?B?Z0VwV0Q4RklrazZJUlZ2YzlCSzdLYm15ZmpaOWIvdFcvalRyZzNRdmtFOGxr?=
 =?utf-8?B?dlRvTnRoTzd4ajVKa0c3dStrR1YrcnpOdC8wVk4wUE1mY3Z5RGxSSjRmVk4r?=
 =?utf-8?B?NVQ2U1VkUktsdXpmaytac1VjMTFjTUtqaC9veTBjMUxFQUZDWkpXbFViRlRr?=
 =?utf-8?B?bS9qVFJERnd1ZUgvUTZTQnhwcjNjOEN0K1h5eUF1bWp0N0RlSHovN21pSFRX?=
 =?utf-8?B?L2pSWkh3Ri85bkdna1dPT2ExYUl6OEd5dWdSb09OL3lVd1htTTRYUFpHZ0xp?=
 =?utf-8?B?SnJLb0EzbFFwWU5QcWs2eUZ6OHpvTDlYcHpDaXBGWmcvNmNtTWZZMTZYYW1n?=
 =?utf-8?B?emgxbjRXd0puSndqQW1RVWRGaVliaEFHSDdnMnVhT3VBeWNnblUvUngrenFj?=
 =?utf-8?B?ekhLZFdmRGFXRkgyalFYWmpvM3RqaCtuQWpvc3FUMURjQzU5eUdtV3RqVEZE?=
 =?utf-8?B?NUJpZGRwU0FyaDFsSUR4MWU1K2NqQVV5RWxFSGQ4YlEyM2JaVTkxWWxHNk5V?=
 =?utf-8?B?eWdWcXFCYVZCQy9aMkxLWEZDU1BlckVtQU1iY29jT09nSnU2Vi8xbWJsWnhk?=
 =?utf-8?B?ZTVKR1ljV3dGL1NjZVgwZUs2ZEREWWhoalRxU3FPd0MvZDk2R0U5cEduZ3NZ?=
 =?utf-8?B?K25tSC9ub2luZjIrd0FJcjB0K2llVFlqNVJqVFN0b3V5ZzFRRUtGVWsvbFNu?=
 =?utf-8?Q?5pjjqvoReYsPXbteuv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de38f67c-36ea-475a-edb9-08deb99353aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 12:52:34.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xFzMOhQ+xKM0bE9dKYyac1W3QE8orkDrCLBPWr2sdbSpiSh+j8+lOCCnUT9htg8xoZ3vE44cVPDAH85E4U2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.923];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,suse.cz:email,DM6PR12MB4516.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 651795C26CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFR1ZXNkYXksIDE5IE1heSAyMDI2IDE3OjEwDQo+IFRvOiBEYW5p
ZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbWt1YmVjZWtAc3VzZS5jejsgSWRvIFNjaGltbWVsDQo+IDxpZG9zY2hAbnZpZGlh
LmNvbT47IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBldGh0b29sLW5leHQgdjIgMC81XSBldGh0b29sOiBBZGQgJ3BhZ2VzIG9ufG9mZicgb3B0
aW9uDQo+IGZvciBtb2R1bGUgRUVQUk9NIGhleCBkdW1wDQo+IA0KPiBUaGFua3MgZm9yIGFkZGlu
ZyBqc29uIHN1cHBvcnQuDQo+IA0KPiA+ICQgZXRodG9vbCAtaiAtbSBzd3A2MSBoZXggb24gcGFn
ZXMgb24NCj4gPiBbIHsNCj4gPiAgICAgICAgICJwYWdlcyI6IFsgew0KPiA+ICAgICAgICAgICAg
ICAgICAiYmFuayI6IDAsDQo+ID4gICAgICAgICAgICAgICAgICJwYWdlIjogMCwNCj4gPiAgICAg
ICAgICAgICAgICAgIm9mZnNldCI6IDAsDQo+ID4gICAgICAgICAgICAgICAgICJsZW5ndGgiOiAx
MjgsDQo+ID4gICAgICAgICAgICAgICAgICJpMmNfYWRkcmVzcyI6IDgwLA0KPiA+ICAgICAgICAg
ICAgICAgICAiZGF0YSI6IFsiMCIsIjAiLC4uLiwiMCJdDQo+IA0KPiBXaGF0IGlzIHRoZSB2YWx1
ZSBvZiBsZW5ndGg/IEl0IHNlZW1zIHRvIGJlIHNvbWV0aGluZyB5b3UgY2FuIGRldGVybWluZSBm
cm9tDQo+IGRhdGEgaXRzZWxmLiBJcyB0aGVyZSBhIGxlZ2l0aW1hdGUgY2FzZSBmb3IgbGVuZ3Ro
ICE9IGxlbihkYXRhKT8NCj4gDQo+ICAgICAgICBBbmRyZXcNCg0KUmlnaHQsIHdpbGwgZml4LCB0
aGFua3MhDQo=

