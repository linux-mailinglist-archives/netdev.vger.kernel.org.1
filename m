Return-Path: <netdev+bounces-267475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA1VOOkdtGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:23:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDC284DDC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D95023037066
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FD39EF09;
	Fri, 13 Mar 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SV7W0vAw"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53532E137
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411544; cv=fail; b=F2pJSKUsffy6Ujsj3pN3nKOiVtG/B8yMSCQ7Vl2cEl+ZHBSok9gj6jxf6zmDOzW8+SmvbYGDKMrLS9B/YESukT8Phlx/rB27AmJbH7ALQA9x1CK/mxuPqkY0Cj9Pn+Kg2STL+RYWAPMyX+fVSTekd4bA328g2QRPNu+oVptuS7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411544; c=relaxed/simple;
	bh=NAv+kbfKNyPCyfLhiMUqTlVURo1dIvFcc4Q2Sr36X7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCPvIeexmZ4ywDGC41YSX3DjnTBSSXGkVVkPKlDjVCIaNw9XlDC+cuh4vVInlgS8Jud4Ei4mjtSCkJA50jbLAjXafuv46SJYbEpvz0c3a3LH/Rys3e7D8eI7AIlA4D7TqS6DGrWWRkYYOmHJmS4pQAkudS7Xiyg8ACKsTzjU38U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SV7W0vAw; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzhaIgHwUpCObyTVTy+LXsrKfGZF4m3sHPcwNaeHiFO+BnueNetJjOtI36IH1U/PWS0Uy3e36DJ1ao3xhlC+IgaTEHOQGdM+ZqnqBoFUEpi5mwAfYG47voBfxg1YGwyuiPHXtekSxLH8VxIwimjQLJbwnIU9IMJuQW9rytT8KqiVnDR/9ELT0n3WHhkOb6HeVCTya6pSv1ghCYIqGXsXt5mCFrlkGjVithIe00lx/ohMQoEs/XTLG0YSlaJTKIusKATa3hyb+NtXFPovQLFSj5td9boa1tL+z19gmfAdaBBnG5dKCjAZKeclz8iWVXG/MVFTL2/mI3SJgHpiplp8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAv+kbfKNyPCyfLhiMUqTlVURo1dIvFcc4Q2Sr36X7Q=;
 b=WubX6XB09OgHuM68JaixLOi6gAlLfZ5Y5Kny2yxk4Cxx0I4iuzGPl3a2rm7VP2hYcX3UuM1Jzjeq06R3UIsyYXkht2evJQ6uLkmjBnkRY2tJRzRb/trVX1vKtjenP8nFYEbCdwLMroK0K3+xKUHpy2TyzVzUMyRBmrVtAmzwiU8bWCmP+8E8X9/8PMvo6dVhqal1evRAs8tB79M9bA4uFu23B0b/LQv8dUQln/cccRqs9OHaFwLs/LpqzU91Js6TfBnvJM2QwwhrGXRvh/Fucl/JZKjda/I7JDnp9xKZhRxgPAp91ifiF6jAgGyFdRS5mDGnCyYDEzBaJWHuYF+bIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAv+kbfKNyPCyfLhiMUqTlVURo1dIvFcc4Q2Sr36X7Q=;
 b=SV7W0vAwUXNcrB8LEGvULNIjIjMT9tkocNVnzLSIR6MplQ20OYJkqZGvIa2JFdd4tid2lN9K/nDPiRQDcY1TGNOPyCQ3bIFUZNreLCs1celXgu4mcJeRoM/JFmVV9bYOtKGNK3nPQCG3ab7ykVJsIBkINqMOvlaZ7CEWfeZUVgf8flYyffXMsnB7U//ZneF7XoGY0O3QED4jcR1HWGF/o6vW8i5+oxVeM9Q5XDnivgVmcFtgvP3/Hka0dToF/Tg6K/fYjLCrLO6WTbTp0KdtODNa2UexFfNH388GhPZM/chynvADyDIQCw5JZR1kbGP6kMm2LjmJoaraU36jLlRnXg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 14:18:57 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 14:18:57 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "sd@queasysnail.net" <sd@queasysnail.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Thread-Topic: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Thread-Index: AQHcsteOyxTTKlU7oEuWtuS5nAxEzbWsSmWAgAA4kwA=
Date: Fri, 13 Mar 2026 14:18:57 +0000
Message-ID: <f8fa2a98694acc50e83e9fe4a57965d023e56e43.camel@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
	 <52fca5034ae2c4b0585e4a82329b73aee720dae1.camel@nvidia.com>
In-Reply-To: <52fca5034ae2c4b0585e4a82329b73aee720dae1.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|LV2PR12MB6014:EE_
x-ms-office365-filtering-correlation-id: 594cddc9-7044-41dd-73c6-08de810b76de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8FxjoXyveEoz3a3X9RYuYOknLtNppC20BM5mVzeiYhZ5X6CDj5m+TXhfN/izLz9WeELO8rpx90Pw1QrNxnCJkE6o75DkAutSW9Y+EQ6AUz0xWvhJB3gnMwhao8taTHI3iHv3XUhKFqiX9RyLlFLGJeojd3dkbEP95MMZKlAgA5Ksm+y0LFqM1M0jTnXMb5I2bR/HODio7BCJn4uenZQ5QIeKLNybiCobpWROvZk8Ofk4Xe4u2fit2o8DbGiaLEV9P87GTPcYSdFsb5J+mD0jOkfwYwwoROSrAO7JUIdlwuxh8M0nlBx8RWVFNUPXKCwy8kGuTGi+tBQ/fpLOhn7qEVn6YJHTloVS091vQqXYcVGnQTvpvrit830CNepZfeMXc6wE1PhKYPXjxnaI6IaVNPJaK5qczTI3dPL6Kg7NBepL/D9QoznHa0lBEc/JZHgpkWHx9Xk7fgS+3h21Dn0upImdFceRmfmePR/v0d/AHYpnVA3MjQQpiLC51vvhZn2FnUA7HXQZrCOOoXvJ5IpEq8x/JZZP1O5LaMZa2o6PbwLBKT8f+ESMJ2Ys1mVLLwVcBXtCwRm+LeSpFDVpnsyFSAr+vbVHg6aVgEjt1NiP4S398KPUwsXkQ0R6VtjP9ojL3dv5TT8uV4SYhGwqP1detLhs7vA5X0FJ5fw4cKxJ7rbKDn9wSVmh/rXQt2luyYms5p2rltC00KNOtMP7I4A9BzKR3bj82rpGo8WY2k1PQjnRs4xcpGEDriloiFDUN8PWjK8Akp4lAu5W9tmTfazVzTyT4MqTAIRMa6TwSKQ0C7w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3J2bmVVeUpORW5aQllteTNYTE1rc1lJYjRiVFFlSHJqSHBFbTlyY1dSYThN?=
 =?utf-8?B?NmFRNWFuNkxoc2RHcDdhTENPK3RCUnVOcFloa3JIUHVoQmd1amU2WnR3aGg5?=
 =?utf-8?B?aE5LQnFtNFg4K2o2Q2VudHlIZ2pTSzhtWjg4Nm8zWDBZVmdvVlVhZVhQQ0lP?=
 =?utf-8?B?eFhGdUZVM0VBQXoyMGVVSURzRFNGK1RRelh6azVaNlJHTkcyd3VjdDhQL0Rp?=
 =?utf-8?B?NlNNeUVtN1lXMGcwbEszamNuNXRKZy8vL3lKZ1drNVlJOGx2VndBUWdqTHRM?=
 =?utf-8?B?L1BLY2psWDFSYmxKRXBHWG1reTNIaFpnaFhjQXEzM0lxcCtxWW5ETFFGYk9H?=
 =?utf-8?B?MEUvNnpJTlh1M0F2Q2pIQW5wWDV6QjYrQzZva2tBYnlXcXNDS0t1Mm52dXdt?=
 =?utf-8?B?eUZ4OWxvKy9sR2dGa0xHNjhFQWUyaDFXTWFuVTVZTEl2ZlQ1VE52WkdXVEx1?=
 =?utf-8?B?NVNSV3dVQjYrWHNaUmJZcE4vdzlTcWY0eVhxZVVwN29ETUgyYmVsenZBV1BO?=
 =?utf-8?B?aFBsR29yWWQxSEVNTHhOcXpsL0greEtkL0x0MjNVdlhpM2ZyeEgrZzVXRUJn?=
 =?utf-8?B?K21qamYzMnREQ0RFUVVoeUQ0ajRrZjhHdlVlY0NHUTFkdTN5Q2pQeElYWHR5?=
 =?utf-8?B?SDB6SGg3YXUreTlvVkxhOFl3M0dVaU9jcXFDay9LWWpYWEtpQUVlSkFaV3Mz?=
 =?utf-8?B?NDZxU0hqZDB3SmtLckJpOXh1VmY0RkVBN0lMMzd1K08wMWh0ZUsvS0RBTGdE?=
 =?utf-8?B?a280SHhwdENyMTkrUUxNQTBRSmxwTUozVWlhSmxzdkY4ajdNRWV2ZHBhU0wy?=
 =?utf-8?B?bk4yQTFwamV4SFM2c1dkS0RaWC84S2xTOVpBcjM2NkdQeUY1U21UKy8wNEEr?=
 =?utf-8?B?M2oyZWIwd1dyQ1BINFlsMVRXc0JHakZJRGlKbGswdHFGRGJ3NlB2ZzBTTnhp?=
 =?utf-8?B?MWwxMmwwUXNYSW9MYUY5RmFWTVppRXQ3RmVaNzl3S2xST1lEejl4eVBVZjRw?=
 =?utf-8?B?K1hhaTViemF2dEZtdytoRTJUSit4NVU0OEp0U21zQ3FPcjdxRGp2b3YrWHJH?=
 =?utf-8?B?NnRhV0ZLQU93Q2ZYdWY4L2Zheis2QlpWK0NpMEJqN2ZGUUZaUURNT1JHL0Jp?=
 =?utf-8?B?RFlQbXQva1JKR1JxVHBmMHR5M1pMc3hsTVdGNW16STdOOS9hdU1hZkRjOGxr?=
 =?utf-8?B?NnBGVlVvcDBsTUtaNjVZc1pNdGJtOWhrVk1iMWJoNWVURVpXb0pOTDQ4TG04?=
 =?utf-8?B?c2tocWFGRHY0YmpDbDdxYlJEQXdISTY3NFppcWkrTW1HQUM2NmtZbTFKSHBS?=
 =?utf-8?B?My9Ud1daNTlZbTJLUEtZeTY0SFpKNDFORjQ1VzU1c3NUZS9FbWlRNDVkaVB5?=
 =?utf-8?B?aXoyMjdmRk5hNTFMd3JucTM3KzBQNUFPdzJRY1MrTXhhcDduZlh2N002bEty?=
 =?utf-8?B?dDVEekVraHdoQkRNcmUyVFBoYWVuRmRVMXd0aUNkUWhFaGEyUlFsTno0M1BH?=
 =?utf-8?B?QkxieWNkeSt1WFlCMURvOW5IY25rUjU5aW94MGVNV1ZESUFtQmdOVDlqNVJW?=
 =?utf-8?B?L01jOFAwTFcwcjBGS2V5T2lDYzdyUWpOTG0wcm9pUm5lUXpkWUpRTFk1ZWo3?=
 =?utf-8?B?clJ1cFMycHk4Qk1ZN2ljUXNuNHR4ckVOU2N3dUcrckQvdDRkY1lpeFN5TXdO?=
 =?utf-8?B?NmNOOVFENkVFYnRtWEQwK1diVVh2bi85cHBsZWg3cnJZVER1T1RzZHN3YUhE?=
 =?utf-8?B?dzZlWVdOWU9ia2lCOUh6SW4zYXk3WWpQWDRNamp2am5BTUFKMDRXeERsLytB?=
 =?utf-8?B?cXdWUysyMm1VTWoyd0ZSeGdwWCtFdDdDeDJyUFNmMHVkZzNya2YzYU41QW1n?=
 =?utf-8?B?ZDJ6YjVxUUFRdzZJOHBYZnZKT3BrdE5mOW1xVXZxZnBRQ25rdnlhU0ovOURH?=
 =?utf-8?B?cnFQSkIxcTBvR080UGRZL3lqRXY1ci91cnMxU1k1ejhFZndMYTR0VzBLWG5Y?=
 =?utf-8?B?Q3dzSHRXdDNyU2oyRGdSc2tRajY3aEt4N2p4VWlQZGxSeldYTlJtV1ZqVFFk?=
 =?utf-8?B?K1RySVhya3RVcTNqZ2ZtZ09rNk9qWDJhUVJGaThVSm5LMDBaQ0FrdTZ0RnhN?=
 =?utf-8?B?YjNrd3RFQ0NEQkl2SVJYdDlkT2NmT1dZVndnUWdnWU5GUWtJRVk5UzNRd0tw?=
 =?utf-8?B?aFR6NWk5RmhzejlKRDFCTVdXbzZYc09YNlo5NkllbjRRUDRoSTE2VWtmYVBX?=
 =?utf-8?B?NUROclgyakV3V1pZS0pqQk1lVWxtUXdIMVNTb2pScjlZc3p3Q3FIRDkxM0Fm?=
 =?utf-8?B?anduOGlxVEF4b1prTWxFaXdJRHBzTFh3UGx6MmxndE8veEpBVEhlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65F5F367C14E2F4CB8E90AAFFBCB0491@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 594cddc9-7044-41dd-73c6-08de810b76de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:18:57.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQSzLFtfj4aijC6FOfIEWqnOpjk6RX6eFZ/e9CYCsZb5p+cKOgu5JbWvLEjWNScOTCzchJYWz1mvA4bxL3EeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267475-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 86DDC284DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDEwOjU2ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIEZyaSwgMjAyNi0wMy0xMyBhdCAxMTo1MiArMDEwMCwgQ29zbWluIFJhdGl1IHdyb3RlOg0K
PiA+IFRoaXMgc2hvcnQgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgVkxBTnMgaW4gbWFjc2VjIGRl
dmljZXMgd2hlbg0KPiA+IG9mZmxvYWQgbW9kZSBpcyBlbmFibGVkLg0KPiANCj4gU2VlbXMgSSBm
b3Jnb3QgdGhlICJQQVRDSCBuZXQiIHByZWZpeCwgZXZlbiB0aG91Z2ggdGhlIHNlcmllcyBpcw0K
PiBiYXNlZA0KPiBvbiBhbmQgaW50ZW5kZWQgZm9yIG5ldC4gV2lsbCB0aGF0IGJlIGEgcHJvYmxl
bT8gU2hvdWxkIEkgcmVzZW5kPw0KPiANCg0KVG8gYW5zd2VyIG15IG93biBxdWVzdGlvbiAoc29t
ZXdoYXQpOiBJJ2xsIG5lZWQgdG8gcmVzZW5kLCBhcyBpdCBzZWVtcw0KSSBhbHNvIGZvcmdvdCB0
byBydW4gcHlsaW50IChyZWxpZWQgb24gY2hlY2twYXRjaC5wbCBvbmx5KS4NCg0KQnV0IHBsZWFz
ZSBwcm92aWRlIGFkZGl0aW9uYWwgZmVlZGJhY2sgb24gdGhlIHRlc3RzIGlmIHBvc3NpYmxlLg0K
DQpUaGFuayB5b3UsDQpDb3NtaW4uDQo=

