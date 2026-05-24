Return-Path: <netdev+bounces-291158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEJPMVi9EmpW3QYAu9opvQ
	(envelope-from <netdev+bounces-291158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:56:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2C5C1C1A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D7FB300F947
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3611519B4;
	Sun, 24 May 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beS3EQCy"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0234DCE6
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612916; cv=fail; b=CwHwRz6Jv2W9Brhq3IkgIwNONyZQ6rsxhrvZEZdgPkHcoqbgcvORSjY+l8HT9PziccwNXVIxSI1JgoIZ6ssjfJcFHQqnomXn3x1GWsAlB4CkJM0UXcgZpNfrVXU6um+JOTxSCQgJDyyyCRpCoiSDTb69Ke9fPTYKiG2TCSOhaeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612916; c=relaxed/simple;
	bh=btnCJqrFiHEdYUROBO1mp9XSzQOW8UVp6Bm5Nsi4lW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eWT//4KMbDeIYnZiw+tUmDm6CW4ptKEGliyBIxtv7TkDFX2FzP7hTCF9EqZ/fv1nM9IRejiJtWqKeyzxEmUkbcSsuUyjLEvBhd73ux8medK02UCf02TAJymi9XbPgsrX9yXeFO8iRCILfTMciwA7KOOOe3Y07YmiTfZrBSw+Wt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beS3EQCy; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsrV4We2OeGE9KSC7HNCqqSCecpjyjWPWR5HinZVCmCi1yyQNhbyxKt6J8CjR7Nkd9nC2Ts9mOlHhzpKGNq891onOVIcIhnq+/Ly0tWBkQMep8+4JlJmk4UUaY1A4EDKBfyg/2FbTRbo/7GnMrUMNBiPTkZbhD1V/V82Az/WfgkV7w9fejQpp8rf0PZXVXH19k3RPm/74dvdYQ6dCawMD9MXj4igQEOHBnX0xA86gu9JIUNZfZ7+Mt8JCARJ9EjfWFpUZNj8EG5SYUbdToR5f6UMrOSXI1HXVQ2fFaIZbIRUf+6iwPJN40i1a7mHUt8ncMCNjtCz0V62QO6mKbqC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btnCJqrFiHEdYUROBO1mp9XSzQOW8UVp6Bm5Nsi4lW8=;
 b=dRRAxd+id28/GUNK+tFs8VZugIsUlhvc4XH0zlr1O5G74HILRvDK95eRGMbi/G5CwcRl7zucqRgnK8O7AEPJCFoFJ+5azaXnzwpUB4cDmg4vror7x5C9zk/oPnrLC7CIx4RM1Q5VqQ13FcnOmrUK9otm3CPkrpRh+pYlTtOn07oZYOoJQE0MVR9glGRfFc2SQ0HPDI+R3eJhdzNQAyxPQrFZLGB05gjkszUq+fyVHLMVANoHX0eEH2OB9xULljf9nrKiZRolE7bOgj6EsKpjgipnkLnm8P/lEWT8cjxeusYOvIOy6PdvCU6ES4TB46PV94cZ9/0QrvM48RTTlcFMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btnCJqrFiHEdYUROBO1mp9XSzQOW8UVp6Bm5Nsi4lW8=;
 b=beS3EQCyvjah2Aiq+3pgEKgmloljCaklXrjxGwA8j8nHHXN/hhCdOdAVblZ7IqRKOMlREezkvFlmFvweyN4cZ9D8ESvLYU+rgeDdd1TvQug2k+eTN/qzAlvN0QIoMIKsLwZyC6QQO7c+5m9GG+7i6niyBn+x/fIHX2HKuGOtQ7FXvBUTIIH0aB8RKUda/jfK4qeIfoLEaLLdBL30Y/XtZnkhw+ZEJzVJVAtCY0FgkfSSsErPKhzM9Z5DraM7i1VuShOJsc4x9ok8X0OecsK091omvbFHO9r6Bji1B8RSQ87cLEwJyGP6U53pZ0p2PdQY9uQoKy7OFlLb5qoWiiSx1Q==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 08:55:09 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 08:55:09 +0000
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
Subject: RE: [PATCH net 9/9] ethtool: cmis: validate fw->size against
 start_cmd_payload_size
Thread-Topic: [PATCH net 9/9] ethtool: cmis: validate fw->size against
 start_cmd_payload_size
Thread-Index: AQHc6kCdsutAfZN+BkK7mz2l8jFdDbYc4WnQ
Date: Sun, 24 May 2026 08:55:08 +0000
Message-ID:
 <DM6PR12MB451693F53E56FF862CC1F668D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-10-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-10-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH1PPFC596BECF8:EE_
x-ms-office365-filtering-correlation-id: 81c257db-272e-40d8-b36b-08deb9722870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|38070700021|11063799006|4143699003;
x-microsoft-antispam-message-info:
 DjJ1JkWruMxDfinEerGnv3Bqadw3VQjXxAKy+FTQLyKZJ6XkYq1fx229M2xHMaZNkzA+twd/+ZsYnVGSlx2OQ8IF1As/rfaQ9X5lnoHRfl3kzjfv38+5D5j3hxW3tEFpazQxfnCRut8T/TNBOxXvWL5tk8+W8v/NGExjhrd+zoTLtTZkxvIUl9db/ZVOFmWuHQSMrQiXWU48oRIcSI8euuJr5bRvLo9M3oiCwk7qZZ3JjRz4IUlgwPcJkvx13ysay5GkKqztrWIQDLN6tdZsoShVwbsjkTH48fYnKK6HSLbHpTDnFwbfOLia/wAX/8EgtJPuR+GXD852s3toOnyBoc1TftSUYHj0mX8bwxUmZStwG2iKIY9KeopBN1T8xjtzEERfk3jU6LmkQCjLBsJm5LPyjJm/IA7mFUerVqQjwTDeyUpmhC87ENEwax8juWYOSLTdSWQ1MOt9AuRNWRMhXqabWltcx3T/6ogBuyc7GKeih98+fES16gJ64sumwrH3VH0LFAga6txQMNUqQzsaHStbCLOX6ySRIdzKQuODNYExX40AaAXCmYj1fZxmIg+aEhVmdctnnbkpIlOCPE+9uyPjL6I7VaZotFzhEKPL3tNaUs0SWLtuVzIFalWZezA+gUTthYIk3yffNPOZYIo6MNkm7C8ENLEJxaxlOzCNWtfHT9eYxy+y1BKSA4TvRd+FW7Pmiox1SVCDbLBnSf5Zsa7caMD9Nk7nKqRcnlrspC1u1jsWH0RSsw6w+qIfKhxG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVVMcG1HQWJQRWxVSzF2dDJ6Ykl1emxZZjZaSzZKMTJCeGVJaXVLVzZmanRm?=
 =?utf-8?B?SUsrOWdoTkVsc3ZNNTU2blJtaWFBOFRzeG9JeVNVajRPS3dzdzZWbjdVaVFs?=
 =?utf-8?B?dUZzWEFNTkI3ZHlxUlh4OXdnUDVyc1lKWnBVWUhYSnc3WElZaFJQbHE1WlVj?=
 =?utf-8?B?ZGVGQlVxZFVqSE12WUd6SHdpMVhsd0I5bzRmeWJtci85ZHpzd1lYcmQxbGQw?=
 =?utf-8?B?RlR1RVUzSmRTM3lpVzYwVVFjVSt6VlJoWVNvVmlaYUw4cG4wOTA3b3hvdjJ1?=
 =?utf-8?B?YU5FRlltSnp5bzhJNXM1VG9CZjhsUHRVenpMdkErT3VYcGtnTFNFNytJcFJa?=
 =?utf-8?B?azQzNksyZ1hEMDJ5Rm5HM0F4Qk9TbW43RmtJVjRrVVRScC9kVjNkMjhuTnVV?=
 =?utf-8?B?V1dkZnJVU0xmalZWUUpZYTVtZS9iNlhGTzg5dUJQQ1ZPNzVyMFhvNGlYMlM5?=
 =?utf-8?B?bC9BRDJCYXUySHFreWNHalREOFFRZHZycmRra1dDSXRiUjdhekY2MkkwYVA5?=
 =?utf-8?B?eEZvY1VjSTdYbjRLUlhXRTVoRUdUK3gvVUpEQ2E3K2VoOTlRSnoxUFZPV0Vw?=
 =?utf-8?B?MnZXWFJLNnZsUGRBRlZGM0NHeTNuUCtNTXlRS1dJYStKSnc3V3RlYjJ2czNW?=
 =?utf-8?B?eDdFZXlkRTBxTmkrZlhNQ0VHNFVtTHFyUGp6STRYdnlON1FuSVVZcURFN2tt?=
 =?utf-8?B?c3l1MC9xZTZpcTBIdi9XWndMdHFrdXVWc0RKRXM4NkJRenFObmRPWHcrYkxZ?=
 =?utf-8?B?NTIyMXFzSEdFTk9FV1ByUnB5eWNsV1B3MEEvTWZLbEZEZmdmVTZLWjFsTkxS?=
 =?utf-8?B?RGtEcmZ4eG1FR3hpejdBZzl0eHExMURwdGpLV2xkb3BQdkYzMUtQTHI5eURB?=
 =?utf-8?B?elF3bjdubmk1ZjA1anlKWFM2UmQxalgvcGRlN0l5aGw1c2pGQVNidFg2WXlZ?=
 =?utf-8?B?M21XOGVadHEvMnhLNFFxTmpkVUg2QlE0THRmbExlTXFsT2RoTmhGUExyU1oz?=
 =?utf-8?B?WW1tc1FKSWp1bVlnZCtkd1IvRllSMFhFaVAzL2lUZUwwV21xMmhtR0RONm9l?=
 =?utf-8?B?Q1MyOVdyOHFBelpleHBJUGFXZ3NNZlk1M285VWM4VVkvRjF4YnYwWW1FSkdh?=
 =?utf-8?B?ckdMMnNCWkx2UWd5WFNsbzl1eXpDZDBCbkdJcGoyTitNYlRrRUNhNjNJWGFH?=
 =?utf-8?B?bTVRYStQbElaSjgvRUdWRzA2TER6eGRCM1VSeHBmREFQS3hwRERvcVhCeTgr?=
 =?utf-8?B?NGtTU0xycTZ4UFRDN2JoRllJcGpDTzFrcVQ4NHVUSkwzK3BGZUFkazVYcHlL?=
 =?utf-8?B?SiszY3JCcWlCR0NHWmdBb0YrREQ1aFR3d3hITm5tMGI0ODBKc3RXMWpDYkZ3?=
 =?utf-8?B?ampZYzZ1QXpNTkk5blhCV2RqV0hIaEJFTkNiZStSUmVRdzRFbXk4eE1XWW5K?=
 =?utf-8?B?cTFXd2FDc1VNMEhDaXFFL0Zldzl1RVhBRzZwVVJFMks0QU80QjlObHpLY2No?=
 =?utf-8?B?a0lOdGtVdHBnVlMvQVBIVnZTQXBnalhnN0NqYmFqMW1hUzNsSlRrYW5EMjAx?=
 =?utf-8?B?MURibitTMm8raUl2ejlTcmh2d2xSY2IzeCtmQURKWk1STXdMYXd3OWJ1Mkdt?=
 =?utf-8?B?YmQzZFplMzFRVTliSEd5Z0RwOElMYjNKei9RSVZkTUprZEhTeDM5RHlmRzQ4?=
 =?utf-8?B?ZVdNNEV5NTlGWlEycjRhKzBkd2JiMUhLTWY0enpCY29xdDFJRzVSVWVpbkU5?=
 =?utf-8?B?Y1JUdFh5dlU4cm1RMTNtNFRqRGNLQS80aUNKZy9Uem51dy94RzFHQlRrdHJR?=
 =?utf-8?B?Nm41SUJkM1NPbFBTU1N1UWRMNTYzOEhpTGVLMHc3RXkrdjg3RWxxVlNoWmtN?=
 =?utf-8?B?SWQxOXpLdEJWS24vazJhWHNUTFFkZUpicUtQZmFZT0FjdmN0OXFva0Jsb0U1?=
 =?utf-8?B?ZWlKN1lFVVZTaUhiZEJ0OG0vdkdsMWFrQTJZTW1TK3pZUkpkOWRCVmxhR25Y?=
 =?utf-8?B?YU5oaUhaQ0NvUUdOOXFack9Udk9HMDdqTzFvQndvRU8zUGlZSVBlU0l3c2lm?=
 =?utf-8?B?MlJYSlo3Rm1WbDdWeThrUTgvTUhSVnNyM0d3ZmJEMitIZjhMRjJiTmJxUEw5?=
 =?utf-8?B?aEh3YVpUaE9CVjdZeDdhQnQxV0ZmY1dsZ3dMdmhxTTIrc2ZTWVUrLzJEUlQ0?=
 =?utf-8?B?bUNPNFBkQjJtSXFYYWVYM0JNMlh3Ykxac3FIQ0NmcWFCalBYUUMyeVF1RFVI?=
 =?utf-8?B?b3gxcyszWkVtMTVva2F2NU9OY1FKTS9YaUNvL1FnMmZmMWtESWM2bTY2ZFFJ?=
 =?utf-8?Q?jHisxTbCH7yu0IH40D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c257db-272e-40d8-b36b-08deb9722870
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 08:55:08.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGbuGGgwo1Ljt2EPepGLkx06nKZtyBBfDoqx2LbdAQO4WMHEpdTFjTVSLl8tcn/3dFLMbhlK+VReOX34foj50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.010];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,bootlin.com:email,davemloft.net:email,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 48C2C5C1C1A
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
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDkvOV0gZXRodG9vbDogY21pczog
dmFsaWRhdGUgZnctPnNpemUgYWdhaW5zdA0KPiBzdGFydF9jbWRfcGF5bG9hZF9zaXplDQo+IA0K
PiBjbWlzX2Z3X3VwZGF0ZV9zdGFydF9kb3dubG9hZCgpIGNvcGllcyBzdGFydF9jbWRfcGF5bG9h
ZF9zaXplIGJ5dGVzIGZyb20NCj4gdGhlIGZpcm13YXJlIGJsb2IgaW50byB0aGUgQ0RCIExQTCB2
ZW5kb3JfZGF0YVtdIHBheWxvYWQgd2l0aG91dCB2YWxpZGF0aW5nDQo+IHRoYXQgdGhlIEZXIGhh
cyBlbm91Z2ggZGF0YS4NCj4gDQo+IFNpbmNlIHRoZSBzdGFydF9jbWRfcGF5bG9hZF9zaXplIGNh
biBvbmx5IGJlIH4xMjBCIGFuIGltYWdlIHRvbyBzaG9ydCBpcw0KPiBtb3N0IGxpa2VseSBjb3Jy
dXB0ZWQsIHNvIHJlamVjdCBpdC4NCj4gDQo+IEZpeGVzOiBjNGY3ODEzNGQ0NWMgKCJldGh0b29s
OiBjbWlzX2Z3X3VwZGF0ZTogYWRkIGEgbGF5ZXIgZm9yIHN1cHBvcnRpbmcNCj4gZmlybXdhcmUg
dXBkYXRlIHVzaW5nIENEQiIpDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBDQzogYW5kcmV3QGx1bm4uY2gNCj4gQ0M6IGRhbmllbGxl
ckBudmlkaWEuY29tDQo+IENDOiBwZXRybUBudmlkaWEuY29tDQo+IC0tLQ0KDQpSZXZpZXdlZC1i
eTogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCg==

