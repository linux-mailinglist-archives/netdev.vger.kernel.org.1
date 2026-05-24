Return-Path: <netdev+bounces-291157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNYQMAW8EmpE3QYAu9opvQ
	(envelope-from <netdev+bounces-291157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A745C1B5B
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E5ED3004938
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412A335081;
	Sun, 24 May 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GP5CgCzd"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E035F5F3
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612674; cv=fail; b=ZB371gQoLGYRvPEkYqwLfVmXbMpNdipF4wWnkyqRyewYl3c5DTDR3gv4NT9QKzZtt0i5dC8Y1ZGYWAvjyaIvBZGT4m7chk0Z1ZjQVd6P1cTqtPGnCEynK3M8zvQb/uvwGVwnwnpz2+TqWLJlTyYisMiDR4STRkiH/4qULiiFeso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612674; c=relaxed/simple;
	bh=hdWjmlmZTCRuxcbGniJQSNLa2By9L9aI/2sbKc++FxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnx0GPtG4q4CPwLTN8olS/QllBE2xZl/0j8xIzGB1IZWN32yYJpw0M7X+AY0o8y2jAmpgg+Bq6e4RmfwyOpoSVZwXmq7Oyz7/WhAcGPLpfEYIJTuj88QGXIfAV3WvfCKoeFPt5Z2MNe5q/10V1qxuRvEh1HprKBIlhwfQp3tP0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GP5CgCzd; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/2giHHggY+S9S1xOO0gKUh9UX3kF5QDuzOirS8MZF19rVKxKymQjYmVQZ7gqKGxxO4KNyq8fWDUgtUxdbhAD86Cg7htTOHx9VkEQOyt8vI1b5lFvjj8RWS0N01CIKQq3jEASlW/+QAyMN3cau6ef+olcKwyGU/oU40gks4ZAMYyPKI1YAI+WEOLtfvon6/3Pcqs10lrXfMzwNH5brWkC+HjSPIy1ng3cmRiVm2SgZRisduJYAAv79NMSIaMxvB9Km5NchbkGHRpI4ZzEky0HUiDSZPSREG6m44fFbKTf9faBqPyECTjRsVB79jsTjsE4J4JU9HGpSTd8AAxQvy7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdWjmlmZTCRuxcbGniJQSNLa2By9L9aI/2sbKc++FxI=;
 b=ljQj7G2NadG7rxbkVhrEfB5UXttPCY6FD7ZDDSCSoJuJBpBMVaCoyMoj8pXSzdpCozD1+RGnHt3zKRovjHSgrDL+RIQ7zRWpVIW07YU8jeLjoFKSdiwcGTn3hz5YK6VKld9xfsijwQ8ZQHMEJg21EOLBEcVWpRSQOAR1sbz+wb3DuHFAH8KxxhE2Xnb7SHPzdzCYuhy8Xc9AoteMFGVNXWXQyyGD6aBloayGtyrsOWCNDBbKxOFtuDMBSEMwGtacElIQTfOFZNrS3bwK7ubib6nBhehNRhS619Ln/oF7oCC1JAYlUeptuESAKRxBREmXX3v85qQGEdXU3n8AyBKD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdWjmlmZTCRuxcbGniJQSNLa2By9L9aI/2sbKc++FxI=;
 b=GP5CgCzdogwf5zIuAV8tFajrXtUXRUOgM5t6gGM55Uc2Wjq3cClqi4E7bl2BZy9wVOzEwJis5wIE8FAMhfQJlbwZcPrSJMH0nxf20JVUe8v29p3PdMFLwlZYi+6DBABsI+4LqWgWUHxIlxegi8negzOrmVg6Z2Qm0EJaKDEKGl890mYte4zm/htAJJQcjY42R8kJ9v89nHODlrjdnCMnKckcfOAGgKWOjyIM5kZrma51UCFQ/JZjt4oAf4f1vG6aWsR1om18701ZfvaPGg0jSDAMhlLMhbteHYsT4JC+tIZ5qmRoMyPO1QtAZXSrhUkOGd/XzSGpqYLkahLlYF/mYg==
Received: from MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sun, 24 May
 2026 08:51:09 +0000
Received: from MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::c2bf:954f:fdcb:4b65]) by MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::c2bf:954f:fdcb:4b65%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 08:51:09 +0000
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
Subject: RE: [PATCH net 8/9] ethtool: cmis: validate start_cmd_payload_size
 from module
Thread-Topic: [PATCH net 8/9] ethtool: cmis: validate start_cmd_payload_size
 from module
Thread-Index: AQHc6kCfbt6oIF1Ls0+mklPBwKT9LbYc31cA
Date: Sun, 24 May 2026 08:51:09 +0000
Message-ID:
 <MN2PR12MB45173E906CF8AD1F744D3EEFD80D2@MN2PR12MB4517.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-9-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-9-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4517:EE_|BL4PR12MB9721:EE_
x-ms-office365-filtering-correlation-id: 10d009de-bf44-421b-35dc-08deb971997e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 qpeKfWsbANU1EMdsFiyVast6QmZ9aQuNyXu+Se0gxCHrtCgPs5ApQGx+GK1i4XQ6Sx1yzSPfhJll3K37Nq4XDR34aVPj1RVUAyBYjIeqxDGPyIxtJLI76mA+zA/na+NTO761CZmCWZXfkVnmKxqL1KxSqkJpISW85uOpVN7laSuR0giQ5G+MCHijGa5JwPjSlzVLhOfkgbOyBOoLWDo0vkVYJzMu2MEdGMxLESgAJqVdfXrkY9zHcjvaCtLqofJE+/jV0krW7NBTuDbFFSuQVGg9y+7mPSEuBTb8mrnclqxUzXNMZf+K3E+Ck1dwbgMsflBE4fbafGUGMtStBDBl95mU7BeaqfPzozjHgvTm7evIGjAtIKTKWgO4Q/T+Y7F6RjitXnM3g2fHI4lCljK3YX7Ja44onSekDaEHsKeDSS8NRgmJXeCAY8ehwQlxZkM1+YWPdGE1EsRkUVDIr/JocFIyLCO8rJPp4PxBCK996dblZD4cOGB4IbswhXI2OL4vRzRdMh+h9xyRzUdxT0cQlmChb6wvrKdWzmzLVRrssQ8zmEtBDgI7cUrk7XnCvhMSgwcTCEswWACxUWBjQRHmqEkuq0HTzItqar+vsWSSe5o1Lp8xAEVzXWZHR7Ltby+HAmrJqqdEjaV70FLQVM4c74UgddS1YMGSJNDfUxkZdhTQbFURxuxZ3smeMiNIUTxC3KLrUuYT+nRxD+OHoU9vfRsIwm8j/8o5yncQSz402IU1ljs3a4L8L1P3GwfiiCR8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWxEQjZROFpOMitSa2JsRmpucFNJZ1VCZjdKVkE3NGllMlo1VXFBc3JaTXlI?=
 =?utf-8?B?NTBXd3VuMWhPbXlVSDZ4N1ZWc3N6MkRPYk53TUEvTjVCRktxck1ZTEJOMXli?=
 =?utf-8?B?R2tRWXBnVmdxQ3o1R0pxN3NlZnQ1V2ZJM0dFcTdGaTJvWTl5ZGRsT09qZEdE?=
 =?utf-8?B?WVo3Y21XelJjWGJ0L05UZmtDaVp5Y1F4Y1F3WU1JQlZtc1VtME5vN3FEZW9H?=
 =?utf-8?B?MDlYRUlhckx6MGZVYytQMFVNL2F0ZHRuYjRINk8yNXhBam9Dd1Mvd3h4eE5N?=
 =?utf-8?B?d0tjUnBpYzk3OEl2SjhYcHdJMlFQSTNGNG1nemN4UTBXYURxYjkzbXVOd3Nr?=
 =?utf-8?B?aUMzbmRGaW9yL1l5R3prSzVWaWhHUHZtcjNMVW9LWEM0MVFDaUtCVnE5R0Ri?=
 =?utf-8?B?L1NxMks2Ulg4K0ZlYnhRdVRZR0RGMllQMWxpbm5ueDUrbkRyYXhEWkFwWUN1?=
 =?utf-8?B?dmhpTFBxNTl6eWY1R01HdEVsUERCVE5xb1BXS2lqTitmdDd6ZHBWNExITTlt?=
 =?utf-8?B?blZtSUozdE9xRjhqUXRnQnJ3TW9GMlRrTHdNeGtGUUFCWmZKUmI5UUJ6YVgx?=
 =?utf-8?B?Q3Ura1g5cEFoaStIOHhXVWpOckpQcjdkY1VJL1ZHTEFEcFE2UFZ2K2hxRWxy?=
 =?utf-8?B?RVVsLy9WZHJZWHgwdUdaZWNiMklWdzNpSjR1UXo2YSsyd29USHNwNisxT1Vy?=
 =?utf-8?B?ak9HS3ExWUZHMnBDanF6MHRpajV4THVvbFgxNFhEdXJhNDA5MW15eml0K0Vu?=
 =?utf-8?B?dUs4ME9zOUpOaUpkd2RDODgyYTloZWF2VlRUUWdNWm91TVZuWFFLUVRWcXpG?=
 =?utf-8?B?c1hEVXRWMUtRWitpNWsyUnQwQmIrYSt5Z3hyWklMcUs3S2RvRVpVcHpvWmdI?=
 =?utf-8?B?c0FlUTdDc1JuVGF5MGlZNFQvWXdEUWloaVFJV1JZdGxob2lpRXVJczhaNWN1?=
 =?utf-8?B?QjRHemV2SHNqaUlGK1dtS0dPNzJLSHZ2OXcxK0w4bGFGcW0xRkJPZ1llbFJY?=
 =?utf-8?B?N2hmYzFSbElPYUFZL0ZkOTBwVE9lcHVCMWN2Rzl0d0lURmRhSlJQa3RFN1JI?=
 =?utf-8?B?NHVOSHlxdlJVdW5TVTY0cFNJTjVIQ0JFck55UHRrWmZVMWdJT3ZPeS9XSk11?=
 =?utf-8?B?ZU1CRTNCTEtTbXVPZ203bjhHZ2MrdWQvYzNDVW40QlhLcEk3ZnJ2UmtIaGF3?=
 =?utf-8?B?dTUvMXdCZmtPNzZ4T2thRlp4TmpvTnQvUGU3aDQ3NjV3LzdvSm5oREUrV2lT?=
 =?utf-8?B?MVRmQTlrZlRVV203ajVQcjZmYzZaL0ptekd1Q2xsREo4MlFKSDR3NHQ0SEhV?=
 =?utf-8?B?V3I4d3ZxU29CUTVFYVM0cVMyRnE2ZnEwU244MlpEUFBwa0hiS2RkMitta0pz?=
 =?utf-8?B?NFFjMlJuWFhEeHpkNDBGd1M4dnRUVmtwZDc4UDRmeXNPVTVyL2RoUVJNQ04v?=
 =?utf-8?B?TWpKYThjbk42VVNBcjNsbjhoT0ROQThlRE81ei9LTjhJd01kNlFMS2RUUWJ0?=
 =?utf-8?B?VUtXRVlsM1dRdjV1R1ROMVd4TWMzYmdURllaWTdmbHJtV1ptTmFYcW92Z1N3?=
 =?utf-8?B?Z0M4M0ZEcWllcklQOVRVYVdFZUs0amYyOUIyRk56QXFsNjdVbDFBMlAyUmda?=
 =?utf-8?B?SzVPVmJTb3NnT1d0SFEwMTZvdVZhazMwMzZxZlZhc28zZGE1S2o2KzF1L2N6?=
 =?utf-8?B?RUM3YWt4ZS84RW9RR3RvdU41dHFiaEh6TDVBaFJFL21DbVJqK2lYYlJmdlB2?=
 =?utf-8?B?VnlHZTAydUpEMXVuc1h2R1haMU1lblNPSE5FYU5NWnp4aGhPelhzUlFKV2xK?=
 =?utf-8?B?ZUwrMmNMTmY5eFJGdFhvdXVwVk1Zbk10VHp6Y2w0ZHlWSm5TRkhJOHZacEdY?=
 =?utf-8?B?SWdXWFczOXdMWHV3YUxnLzJIc2psSGRWUko3NWNybkQ0OHZULzhuaEs5ZEpW?=
 =?utf-8?B?VTRXOGdYeWVxSTZQVVpHaE90V3dRRTdocmkydGhVeEhpRVJOZyt6VTFQc2RG?=
 =?utf-8?B?cmphZVFtOEZxOElsMzZ6U3VPcEl5NVF3d2dIQmVqc3MxL2dacUFkSlRwNGdR?=
 =?utf-8?B?VENYbVl6YTF1QnpPMWtXWmtNeUFoSE5NbUkxRzI5RWFHS3BxYkI2MGwrclVL?=
 =?utf-8?B?TkM0QzdCRzZHSmh0bnkyMGxsVjJ5eUxPc1Uzc3V0MUF1OE5aVk9icEpmU3hm?=
 =?utf-8?B?d2lLMkM0SWJiWHFOM3U2ckJQNGxLTk1rN1VUa3hjdWduLzhmYnk1aVQ3T1lP?=
 =?utf-8?B?UjNpaDRsck4zZjkwOUFWcGpjNm4zZnNRSkJuZnVIWUl6QWFGVmc2cXR6Z0VG?=
 =?utf-8?Q?L7UkyoLm9T7MLTyafd?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d009de-bf44-421b-35dc-08deb971997e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 08:51:09.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdkJxij8uOpKVVRbjEL99bhmVXyjnKDMAaGtJ48DDxrxujofzi3POBu6cdmjxxhN1ceDKgw5RUeSsCj2QkRWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291157-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.012];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[MN2PR12MB4517.namprd12.prod.outlook.com:mid,Nvidia.com:dkim,bootlin.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: 51A745C1B5B
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
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDgvOV0gZXRodG9vbDogY21pczog
dmFsaWRhdGUgc3RhcnRfY21kX3BheWxvYWRfc2l6ZSBmcm9tDQo+IG1vZHVsZQ0KPiANCj4gVGhl
IENNSVMgZmlybXdhcmUgdXBkYXRlIGNvZGUgcmVhZHMgc3RhcnRfY21kX3BheWxvYWRfc2l6ZSBm
cm9tIHRoZQ0KPiBtb2R1bGUncyBGVyBNYW5hZ2VtZW50IEZlYXR1cmVzIENEQiByZXBseSBhbmQg
dXNlcyBpdCBkaXJlY3RseSBhcyB0aGUgYnl0ZQ0KPiBjb3VudCBmb3IgbWVtY3B5LiBUaGUgZGVz
dGluYXRpb24gYnVmZmVyIGlzIDExMiBieXRlcw0KPiAoRVRIVE9PTF9DTUlTX0NEQl9MUExfTUFY
X1BMX0xFTkdUSCAtIDgpLiBTbyBhIG1hbGljaW91cyBtb2R1bGUgKG9yDQo+IGNvcnJ1cHRlZCBy
ZXNwb25zZSkgY2FuIGNhdXNlIGEgT09CIHdyaXRlIGxhdGVyIG9uIGluDQo+IGNtaXNfZndfdXBk
YXRlX3N0YXJ0X2Rvd25sb2FkKCkuDQo+IA0KPiBMZXQncyBlcnJvciBvdXQuIElmIG1vZHVsZXMg
dGhhdCBleHBlY3QgbG9uZ2VyIExQTCB3cml0ZXMgYWN0dWFsbHkgZXhpc3Qgd2UNCj4gc2hvdWxk
IHJldmlzaXQuDQo+IA0KPiBzdHJ1Y3QgY21pc19jZGJfc3RhcnRfZndfZG93bmxvYWRfcGwncyBk
ZWZpbml0aW9uIGhhcyB0byBtb3ZlLCBubyBjaGFuZ2UNCj4gdGhlcmUuDQo+IA0KPiBGaXhlczog
YzRmNzgxMzRkNDVjICgiZXRodG9vbDogY21pc19md191cGRhdGU6IGFkZCBhIGxheWVyIGZvciBz
dXBwb3J0aW5nDQo+IGZpcm13YXJlIHVwZGF0ZSB1c2luZyBDREIiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ0M6IGFuZHJld0Bs
dW5uLmNoDQo+IENDOiBwZXRybUBudmlkaWEuY29tDQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNv
bQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRp
YS5jb20+DQo=

