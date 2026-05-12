Return-Path: <netdev+bounces-287203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA5QNW9GA2ri2QEAu9opvQ
	(envelope-from <netdev+bounces-287203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA4523979
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8C631CE00C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406493B4439;
	Tue, 12 May 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BB2PVYAb"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020134.outbound.protection.outlook.com [52.101.69.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424513B2D38;
	Tue, 12 May 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596341; cv=fail; b=g+Kt/LTu+GLnuvfVhdxFAJqIHgx6O4zsCU9zNo3lQKlYXWD64VvV/oGART7MI4cKh9Se16Qsn42OY254X7dbXpTUqqYwSwxdXjSjw8/9VrqFMW0mFH8NeexF7G9eV9JL+pPtV+K6Y8FYxKzF+cLWzKwcbLdFOWi78gmzeWoi/D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596341; c=relaxed/simple;
	bh=kBcPhwUMbs3DgAt3wXNvxbdze1j7ltTbQrQbU65ucwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKyqHTeGJXLEyhFJYwCDA4sFkXi9pnIzx2sl8hO8x0b1NoJuurCh9CKCs2UZ3Vwyk22x0cDFITilAsMJhI015H7N/Vd62QcXvUP6LBFGZHtPjQpvOt3gDuWdr/6ARM0IpB7YRAdD4i+BgjdbR4U5fn2eoiMXoYOOL09725x/gXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=BB2PVYAb; arc=fail smtp.client-ip=52.101.69.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciWmwLoiknTTObjo2i5jbRQiFEkhrpmqA92+tZEt8gL63RyV9bpgrH8OmHmZ+cDb8E3ciIPcN89iLzTwZj/ORMkABeZkjb8z3PzQHYF9jiqexmUUoVrlxYuYvj0IbqKait7K6/Lt+z9rg9Y35fFwugfEkFaMsA3+QhERfQpPel9BJRL+vFIdxVKLH0WbPaHJDbnLItwtWOC+neOilvpXf/VY6V58yzc4eRX4c89yc1Pp3TC10G/j3gMDDA8NGAkqjaTBy0YiHo74pSu1DI4k636tLcHstVhyb3+BQKdK1NpC4aJkynPPKqg5jR/WjflFkC4P7TS83L/Hgeb2dLfnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBcPhwUMbs3DgAt3wXNvxbdze1j7ltTbQrQbU65ucwE=;
 b=vWCIIAQ3XWkz/gPYJZbCEeaWjrmiRK4zDsrvkuhtuRshOCWTIpKnwjRbk5cFKKv4sLN1bvBYvWeMiKALzjmz8v2oH4Fyn8gNmuXpHQ8640nRQa7LUM2tc4fgBiAeq0wy8kcJu41bdMp+rxnx9lqIiiIpAI9afce+2XgFirdzk5AtuECnviiTBI1ijMV2zvvXcID6p1yeLCOR59waKDSZNzXkCWHpRsMCTqD2XGHU0C4JWrzi25XAYt+mUcHQG2JduVVgZEBX7HyJPIyFhtua2hRBgdAYTJbw7liDfRruYdrQRhcXYb2QZ99ybzZrkZbK5w8Tpns5XTntrmsUy02q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBcPhwUMbs3DgAt3wXNvxbdze1j7ltTbQrQbU65ucwE=;
 b=BB2PVYAbPuqwkE89WREalDDVhQxULpXJV5UcwmeQaBc4SzHqBGQ5DK9pGZ1lveT+owaGoVZjUKRs2yz4Qh95au8tzckJp7TPE0PzJlOcWET5Shndi5qY4MDo4dsOMohcw7hgR75SUhF9wBV2ontHdqSIPHoFeZpmtD6RN68hGAqIUWuoELzGmNANkPTp1AQeOyds7OuaS0/jt/5ielMniQw+z27SFBYb48Dgl/g2fCuRB83ic7Sd7d9WGhXwvQhargDD2YKYE3X6y/ls2EWQm8m1NRYHDXQrMb115XUfQuo8b6ZXLvdLfpOS3RjvNuFucl2nLQF0aDA7FwzOMDKZUQ==
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by DB4PR08MB9264.eurprd08.prod.outlook.com
 (2603:10a6:10:3f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:32:15 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:32:14 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
CC: "den@openvz.org" <den@openvz.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when guest
 isn't ready
Thread-Topic: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Thread-Index: AQHc4VZbvXFbdjip3UaqAROOt5MiVbYI+teAgAF6vAA=
Date: Tue, 12 May 2026 14:32:14 +0000
Message-ID: <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
	 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
In-Reply-To: <agH3WvJtAsQ_5zx4@sgarzare-redhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR08MB10828:EE_|DB4PR08MB9264:EE_
x-ms-office365-filtering-correlation-id: e0a70e5d-e663-446f-e803-08deb0334301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 4rw5ayD5mOMzINVZcx72VaBfHTW122GPHGaSIq13vDaSB2o8c8o5+zYbl2pzGpWjvUBKRtqPunGSxnziVlWZ/K4ok+5fDcwUJBcakjhReUrs6Tr0D30NBlTqW82YR5W9uGmxRmukT+xDe4HYgrnH2PX+tA/Wz/TRjbcygilVmO7gQNJcjq+j6GTas5GAoWwXoOPL2PVuAFX6G0Yl5yc/ZDaoxhSiTMDEM03vQK2JsytJTVhnW0PzT9yFfunEGB3qY3/Qf+XiQVM/i4HDPqMlj6kDrflM4fkqFyGvrkWoIymUPl8SJi1BUG/xWLCSfWHuuMP6/z6t59P9aAGXzjii57GyezPNmK+Fcm/3ThX6S3xOvOCKIXrAlYYdA+/N3iYOvwOj0OGZcJjmGomVMCXmpkcatm6M/8pz2n6XRxEh3KBbz6a/wN0stX/LiuVea5RyYXI4/KGYLTF+DbCFujVLAGooO6JalLrPzYEEHV4uwAc0psVFufIAUsIWzjmEXd+RzDfv/FW108vJZSfRw3DZd2B49H6u6bTVUSfYtL4YReJoRL5rL5ffOlgfs2x8slMJ4ofaYdhhPbCbizpu897mNmlX8Q4HP8sBth0RRMhEV+7qIJrEM4ZlvBiNfGF7EjT2RtwihTHe0xyltT55aOy/e34Lr+Hvl12aD4GzkPzbaGznBU1ImKqkz2wnIAH4zvN3HoJUwy5ZM1+78CWTCh2SfyxVDa02RhHgDKVf1UYtv60KPI/Ro5vpUI5gD22XY6jn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10828.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NURpa1RvRE1xWmdEOTN2aytSZDFvNk4wekI0QTByblZ1aUh2RUZoSmZ5UDRo?=
 =?utf-8?B?aW1LdVd1c09aY3I0VElPUGRoQnlONzFHRE5XSTYxWldLZjQ5bFI4K2Nzc2lu?=
 =?utf-8?B?NE5VNUppS0p5UGoxMVFtcE9MQUdIVjltbXlOY3hXUW9MMnJaOWY0Y2xpaERP?=
 =?utf-8?B?MjZxdnhHWjUrUkFQaSt0L2hLd1Q4WHFHaXRUREU3MTZpMng2RjVnRlZlS1ps?=
 =?utf-8?B?Qkt0Z2ppVDU0cWNoMTJoU1IzcFNTT3ZweXc3aEVUaHZoV3h1UE5NN0VGbFpE?=
 =?utf-8?B?Nkx5cGR1TXY1a2VHYkU1QUxxczM1Y3BPVUdndFY1TERFZGllZE1IUitCTGgr?=
 =?utf-8?B?TlpZZlB5Um52WDgrcUNJd3pkTDVIWnk5YWVMSkx2Nm9Oc212aS9ZQXVaWm0v?=
 =?utf-8?B?SUlJOWZzOFJVZU9mZ1pDNGpRWFFjUFBFRnRHZ1BsYzBDMndVM3RYTDB5KzNx?=
 =?utf-8?B?UUI3QXkrK2xyMkR6WG5HclB6QW4vNXQ5YmhCMlhHSmJ6MUxmS1ptTER6LzR4?=
 =?utf-8?B?UkpPWVVuRURHU2k4WmwvK21RcnhaaFBkWWl5d3I4L1phNjJrNWRicHIzcExq?=
 =?utf-8?B?Y0hEd0JvR1V4dlJuQ2Q1VnpjYkR6Y0luc2J5RG02eEZTbGtualJVZ0RJZGFo?=
 =?utf-8?B?SUE3eUNRZzFtMnpvWm43YVN5dW45Z1hLV1J0bUs3ZFRERlBtL1NxYWFsMHNm?=
 =?utf-8?B?amwzQkpwTUF6ekNGTklnN2QvcG1USFpNVi9hYTdOSmgyUlExVTNRYW0wT0JW?=
 =?utf-8?B?NjhFTi92QmE4SE9ycWxRR2lEMzNuR1IzeittdDg1Tm9hTUQrNEhGRkJrTnVo?=
 =?utf-8?B?bkVwNWprWVNlRjR1Q21yaUx6WGhhdlNwamN6MXRoQ29UYVJFL000UC9rTW85?=
 =?utf-8?B?L1FlWWlUN0pBUEJQMkNVTTJadWh6U1hRUHdOVkdGREU0eFAwOWFWQWxPdytj?=
 =?utf-8?B?SU5ZN1JuOWtzMXhHRXYvRXRpUU9oMFJuU0lPS296bzBrd1RnRTlwYTN5U003?=
 =?utf-8?B?dzFSdHFEVzl6ZjdFSk43aXQ1M05MYThmaUtaL1pIMFV5eXY2L0IxLy9DbE9Y?=
 =?utf-8?B?N0hzWlh2U3luWSt6bnRscDM0Y3NrNWt3Q0ppZ0U5Z09LTERCdXpVQ0FEcUhi?=
 =?utf-8?B?TndjUGRDcm9NZGxZWnRCUkwyK3ByeTdTTytQZHBWR1FkakhkRUpGbHg4OEEw?=
 =?utf-8?B?UzBwVjlIOTRRQXlSSFlIOHJtTksyekFqMFQxMjdJcFRNbFM4bVJUck55WHBi?=
 =?utf-8?B?ZXZBVGo4L1d5Z0tOZ2dia3cvNDg4b211SHJZVHRDRUVldmZnRzJZMnUzcjN6?=
 =?utf-8?B?YjR4QSs2ZEpYNFdteUVDRWZoWFE1QmpSb1dUcVpDOTkrMCt5UEx4eXgramlh?=
 =?utf-8?B?T3dGZFBSVDdhWTVBSHMzZEZ5VVlBWU5FYUF1MW8zdGFUUFlQQkQ5cWpEd2Ur?=
 =?utf-8?B?TUxVbTlURFdVZ25Rc2JqelNWaXdROHd5Q04zdmFQY3l3TmJEQ3BqaEJQWVl0?=
 =?utf-8?B?K0NLdFZXdnBOM3dnZDEyZlZvaGREbUNEeDFzNzViWDVqaWNMMC8vVWRZeXNp?=
 =?utf-8?B?VTdPMHJQSDhlajU4WXF1UUd3cndXaGpYNUw1SCszemtCeE56UmJyZkt6MUxY?=
 =?utf-8?B?ZWk2Vzh0NktKSUxoTTBucGM0T1BhMUtGV3IyY2dYYzhsQTM0TDQ2Q0s3Ykp4?=
 =?utf-8?B?c0F0Vkc3eTVpY1RFR2pjcUhuWWVsUWgwZ21LamUzTUxyMEpvMy9RTVpwNzd5?=
 =?utf-8?B?VEZOTnpSRWRmU1RHZFJCUEFLdUNoNFh3MmJRN09ORkVGcElRcndyaHBKQ2U2?=
 =?utf-8?B?aTRkcVJGc2RnUERIN0ZmeDVUbE56eVM5OTdVMTJPYytCRTlYMG1wMlZVWHFj?=
 =?utf-8?B?TjVRbkRTeWtBRi9RekdnaENZVXppb0lCeUZMVDRMcnpZdU8vRldVWEw4Nm96?=
 =?utf-8?B?Yytqc0Fjbm14YnJXTmZYOEl3SmxrYXg3MU5xY1NNTTl1SjJhdzdBczJqNktn?=
 =?utf-8?B?ZjNSeHRhTE9wbjZPQnd6UVZxalZmWEMySDVMbnplZ0swYXFFZHMwWktFZ3NV?=
 =?utf-8?B?bmpYRmpmVE5BZThYWFlHZVppNWEzY3c2ZlN4cEREMjcyQU9aRktBYWp1Y24z?=
 =?utf-8?B?S0xoZVFzSGs1NGJkY2pncG1odnVpam1XT1c0NFRZRzFhTTU4WFNjbUM2T3FL?=
 =?utf-8?B?MUJYaU5sMkNUTERoTWJRL2Q3dUdkQy9SK1hyZTBCeEN1VFFpM0szM3JxMTUv?=
 =?utf-8?B?ZEtvR0ZsRjc0b2dtQmlVZUlyTmh0VXRMUHRMNUdPV01ZeERFeElXSVhzeEYz?=
 =?utf-8?B?RGUrSWp4S1lsUmlHUEtjQ3pIK0NBdXZqdmFKTldZb2lUTGtoaE1uTldMaHBY?=
 =?utf-8?Q?ZI82iWKr0UyvBdW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA5A4B79D8FEFA4B9254023A58EBA71D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10828.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a70e5d-e663-446f-e803-08deb0334301
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 14:32:14.6908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtHsDHeOwjCkGjMOcIJGbmrLazducClXTVVJzASvGt83l2nztbaHNmWzZikZq6VKhdrWGL6Zh86OPZp9oblbRTPt1riMFtc1tltW6lwnrRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9264
X-Rspamd-Queue-Id: 37CA4523979
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287203-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[polina.vishneva@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:dkim]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE3OjU2ICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6DQo+IE9uIE1vbiwgTWF5IDExLCAyMDI2IGF0IDA0OjU2OjEwUE0gKzAyMDAsIFBvbGluYSBW
aXNobmV2YSB3cm90ZToNCj4gPiBGcm9tOiAiRGVuaXMgVi4gTHVuZXYiIDxkZW5Ab3BlbnZ6Lm9y
Zz4NCj4gPiANCj4gPiBXaGVuIHRoZSBob3N0IGluaXRpYXRlcyBhbiBBRl9WU09DSyBjb25uZWN0
KCkgdG8gYSBndWVzdCB0aGF0IGhhcyBub3QNCj4gPiB5ZXQgbG9hZGVkIHRoZSB2aXJ0aW8tdnNv
Y2sgdHJhbnNwb3J0IChpLmUuIHN0aWxsIGJvb3RpbmcpLCB0aGUgY2FsbGVyDQo+ID4gYmxvY2tz
IGZvciBWU09DS19ERUZBVUxUX0NPTk5FQ1RfVElNRU9VVCAoMiBzZWNvbmRzKSwgYmVjYXVzZQ0K
PiA+IHZob3N0X3RyYW5zcG9ydF9kb19zZW5kX3BrdCgpIHNpbGVudGx5IGV4aXRzIHdoZW4NCj4g
PiB2aG9zdF92cV9nZXRfYmFja2VuZCh2cSkgcmV0dXJucyBOVUxMLg0KPiANCj4gQ2FuIFNPX1ZN
X1NPQ0tFVFNfQ09OTkVDVF9USU1FT1VUIGhlbHBzIG9uIHRoaXM/DQoNCkl0IGNhbiwgYnV0IGl0
IG1pZ2h0IGJlIGRpZmZpY3VsdCB0byBmaW5kIGEgY29ycmVjdCB0aW1lb3V0Lg0KDQpBbmQsIGdl
bmVyYWxseSwgdGhlcmUncyBubyB3YXkgdG8gZGlzdGluZ3Vpc2ggInRoZSBndWVzdCBoYXNuJ3Qg
eWV0IGluaXRpYWxpemVkDQp0aGUgdnEiIGZyb20gInRoZSBndWVzdCBpcyB1cCBhbmQgcnVubmlu
ZywgYnV0IGRpZG4ndCByZXBseSB0byBjb25uZWN0KCkgaW4NCnRpbWUiLiBUaGF0J3MgZXhhY3Rs
eSB3aGF0IHRoaXMgcGF0Y2ggaXMgYXR0ZW1wdGluZyB0byBmaXguDQoNCj4NCj4gPiANCj4gPiBJ
ZiB0aGUgZ3Vlc3QgZG9lc24ndCBzdGFydCBsaXN0ZW5pbmcgd2l0aGluIHRoaXMgdGltZW91dCwg
Y29ubmVjdCgpDQo+ID4gcmV0dXJucyBFVElNRURPVVQuDQo+ID4gDQo+ID4gVGhpcyBkZWxheSBp
cyB1c3VhbGx5IHBvaW50bGVzcyBhbmQgaXQgZG9lc24ndCB3ZWxsIGFsaWduIHdpdGggb3VyDQo+
ID4gYmVoYXZpb3IgYXQgb3RoZXIgaW5pdGlhbGl6YXRpb24gc3RhZ2VzOiBmb3IgZXhhbXBsZSwg
aWYgYSBjb25uZWN0aW9uIGlzDQo+ID4gYXR0ZW1wdGVkIHdoZW4gdGhlIGd1ZXN0IGRyaXZlciBp
cyBhbHJlYWR5IGxvYWRlZCwgYnV0IHdoZW4gbm90aGluZyBpcw0KPiA+IGxpc3RlbmluZyB5ZXQs
IGl0IHJldHVybnMgRUNPTk5SRVNFVCBpbW1lZGlhdGVseSB3aXRob3V0IGFueSB3YWl0Lg0KPiA+
IA0KPiA+IEZpeCB0aGlzIGJ5IGNoZWNraW5nIHRoZSBSWCB2aXJ0cXVldWUgYmFja2VuZCBpbg0K
PiA+IHZob3N0X3RyYW5zcG9ydF9zZW5kX3BrdCgpIGJlZm9yZSBxdWV1aW5nLiBJZiB0aGUgYmFj
a2VuZCBpcyBOVUxMLA0KPiA+IHJldHVybiAtRUNPTk5SRUZVU0VEIGltbWVkaWF0ZWx5Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IFBvbGluYSBWaXNobmV2YSA8cG9saW5hLnZpc2huZXZhQHZpcnR1
b3p6by5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUG9saW5hIFZpc2huZXZhIDxwb2xpbmEudmlz
aG5ldmFAdmlydHVvenpvLmNvbT4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMg
fCAxMCArKysrKysrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92c29jay5jIGIvZHJpdmVycy92aG9z
dC92c29jay5jDQo+ID4gaW5kZXggMWQ4ZWM2YmVkNTNlLi5hM2YyMTgyOTJjM2EgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy92aG9zdC92c29jay5jDQo+ID4gKysrIGIvZHJpdmVycy92aG9zdC92
c29jay5jDQo+ID4gQEAgLTMwMiw2ICszMDIsMTYgQEAgdmhvc3RfdHJhbnNwb3J0X3NlbmRfcGt0
KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXQgKm5ldCkNCj4gPiAJCXJldHVybiAtRU5P
REVWOw0KPiA+IAl9DQo+ID4gDQo+ID4gKwkvKiBGYXN0LWZhaWwgaWYgdGhlIGd1ZXN0IGhhc24n
dCBlbmFibGVkIHRoZSBSWCB2cSB5ZXQuIFJlYWRpbmcNCj4gPiArCSAqIHByaXZhdGVfZGF0YSB3
aXRob3V0IHZxLT5tdXRleCBpcyBkZWxpYmVyYXRlOiBldmVuIGlmIHRoZSBiYWNrZW5kIGJlY29t
ZXMNCj4gPiArCSAqIE5VTEwgcmlnaHQgYWZ0ZXIgdGhhdCBjaGVjaywgZG9fc2VuZF9wa3QoKSBj
aGVja3MgaXQgdW5kZXIgdGhlIG11dGV4Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAoIWRhdGFfcmFj
ZShSRUFEX09OQ0UodnNvY2stPnZxc1tWU09DS19WUV9SWF0ucHJpdmF0ZV9kYXRhKSkpIA0KPiAN
Cj4gV2h5IG5vdCB1c2luZyB2aG9zdF92cV9nZXRfYmFja2VuZCgpID8NCg0KQmVjYXVzZSBpdCBs
b2NrcyB0aGUgbXV0ZXgsIHdoaWNoIGlzIHNsb3cgYW5kIHVuYWNjZXB0YWJsZSBpbiB0aGlzIGhv
dCBwYXRoLg0KDQo+DQo+IEFsc28gaXMgUkVBRF9PTkNFKCkgb2theSB3aXRob3V0IFdSSVRFX09O
Q0UoKSB3aGVyZSBpdCBpcyBzZXQgPw0KDQpJdCdzIHJhY3ksIGJ1dCBhcyBkZXNjcmliZWQgaGVy
ZSBpbiB0aGUgY29tbWVudCBhbmQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLA0KYW55IHBvc3NpYmxl
IHJhY2Ugb3V0Y29tZSBpcyBjb3ZlcmVkIGJ5IHRoZSBzdWJzZXF1ZW50IGNoZWNrcy4NCg0KPiA+
IHsNCj4gPiArCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiArCQlrZnJlZV9za2Ioc2tiKTsNCj4g
PiArCQlyZXR1cm4gLUVDT05OUkVGVVNFRDsNCj4gDQo+IFRoaXMgaXMgYSBnZW5lcmljIHNlbmRf
cGt0LCBpcyBpdCBva2F5IHRvIHJldHVybiBFQ09OTlJFRlVTRUQgaW4gYW55IA0KPiBjYXNlPw0K
DQpFSE9TVFVOUkVBQ0ggd291bGQgcHJvYmFibHkgYmUgYmV0dGVyLg0KQWxsIHRoZSBjdXJyZW50
IHNlbmRfcGt0IGZ1bmN0aW9ucyBvbmx5IHJldHVybiBFTk9ERVYsIGJ1dCBpdCBoYXMgZGlmZmVy
ZW50DQpzZW1hbnRpY3M6IHRoZXkgbWVhbiB0aGF0IHRoZSBsb2NhbCBkZXZpY2UgaXNuJ3QgeWV0
IHJlYWR5LCB3aGlsZSB0aGVyZSB3ZSdyZQ0KZGVhbGluZyB3aXRoIHRoZSBvcHBvc2l0ZSBlbmQg
bm90IGJlaW5nIHJlYWR5Lg0KDQpCZXN0IHJlZ2FyZHMsIFBvbGluYS4NCg0KPg0KPiBUaGFua3Ms
DQo+IFN0ZWZhbm8NCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+IAlpZiAodmlydGlvX3Zzb2NrX3Nr
Yl9yZXBseShza2IpKQ0KPiA+IAkJYXRvbWljX2luYygmdnNvY2stPnF1ZXVlZF9yZXBsaWVzKTsN
Cj4gPiANCj4gPiANCj4gPiBiYXNlLWNvbW1pdDogOGFiOTkyZjgxNWQ2NzM2YjVjN2E2ZjVmZDdi
ZmU3YmMxMDZiYjNkYw0KPiA+IC0tIA0KPiA+IDIuNTMuMA0KPiA+IA0K

