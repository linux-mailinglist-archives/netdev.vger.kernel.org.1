Return-Path: <netdev+bounces-287505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FufHS9IBGo+GwIAu9opvQ
	(envelope-from <netdev+bounces-287505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E468530E34
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6341D301F4AA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF93E7157;
	Wed, 13 May 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YZlGeoIf"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021121.outbound.protection.outlook.com [40.107.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3C3A8724;
	Wed, 13 May 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665499; cv=fail; b=b16DwvmEERb1CdxSUpocpC+KjIIuOQaYmx0z5xzrrBrzkwrL4jGPEM8w8x81oJ8TzuqQzFYXmFpE7NSptzTKmjVvlTaXI1MH25xQVIhYvOfqGu5POdjByfiTEmHl6GCttBoa8NxOigMvbQuuQNDvBkJIXJP6uHtxEqTObNgebEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665499; c=relaxed/simple;
	bh=lMfnS6Lj3hOZWwVlMDd+HC65KK+1wUBxbJvJdXksugk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eW/aTYnyZWImOfNymRSETXvQG/FrqeZ8HJxEDHT9ozMrbx9VxZ4BGyHJZH3NRdoaSK7DBJTvGxU+naQbbTQ/6l0myn9w9VkPi7b1pBm1Vel/dSte0WLVP2F00miFi001OGkxLePRJFvJaMjWRiv0DZAsceP1Dlw3zrODXhoISQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=YZlGeoIf; arc=fail smtp.client-ip=40.107.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdmm65+cD2heX5QwSE3rMBvzqF6W46aisApfbgwGPw0WINQvC2FJOWpqntRUTV2nRTuI5qCb098CJ0iR3BKQdlKuSJtqjN8gdlPdSbD+tP2qNSGgFwmWMtwQvLR+ZRzqkF6lg1A4WXEaI7okDl++rCrKlQPTd3/qvspn9bSc4i7e4Ge21smIwRl+D4eANd3HqaIYHGsG6+XQWym+XLeb78wSTxCElt1S7pnWwVdPJLyG1bwX4EeVGXnC/KsF5KhtcCGWMiRNXywfsuHGjLFGACwDQkfxaeabN6fTIzq8jtlHSlx97zY6RuJ1cKCyMq+NVliVlg/85XXKvqk2xSni0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMfnS6Lj3hOZWwVlMDd+HC65KK+1wUBxbJvJdXksugk=;
 b=e3oh4YfvWhd7sa0WzgyN7QgoqxoF6dsLcQUGvZnIdRzUNVbF34d0Dq+BpROPCagMwExrgi6o/ps2X6+6IRUQDtfnAQc+0P4mqy+OQdd8DJg7js+P3FARg/QndsqZkiZrJX5VRQekZryP8aysgjCyaWozinHSfT7BYCQA59gUGsSZDH1BZaZt9Y7v5S751IJAHa84aofoFIXdoIc9yKTPIN/2lQLTMJ4+S2X7k9+KYRyPj8PS94fnUhG5fSVCl6tOrUqm+MbORO5sbGf5g8tSEiOCA+fyWLBOkFXiyTJ8M2oirTkP05s+hY5F8+H6vOJ1gCBDJt5wc+SOQzJ9fCqJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMfnS6Lj3hOZWwVlMDd+HC65KK+1wUBxbJvJdXksugk=;
 b=YZlGeoIfT7JF3DL5WzZHiVqUaXi/MjG5ZZoL2Pw2Ir15qBL8WdoMyvV8ALCQ72mg84REL+4dy+9AUTJ4k8G+zjOmCE83puw3+Pf6Km1iKH+7jfAHdF8nnyHYrH2aYJyxbew8nHhyF/SJo2hmWNbq0Fvz8O8sY41O+gU7c0RwwvxJxe2gW3ULyFqm2NxqT0PP5FbXIhcvtbRJOSZOcYTg5vze2xBs8tSGQ1PoGBZKj1N+06AfAk0NbFG3QDulCtFyNXjUWaaY6dplm8gJtBQJ0Kh4rQHx2YfQC1U5U4xnAo+/il369R/x/S6f1kZ/+mxMbofiv4td9FuPlOrtWodWow==
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by DU4PR08MB11575.eurprd08.prod.outlook.com
 (2603:10a6:10:61f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 13 May
 2026 09:44:49 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:44:49 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>
CC: "den@openvz.org" <den@openvz.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when guest
 isn't ready
Thread-Topic: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Thread-Index: AQHc4VZbvXFbdjip3UaqAROOt5MiVbYI+teAgAF6vACAABLhAIAABjQAgAEo8QA=
Date: Wed, 13 May 2026 09:44:49 +0000
Message-ID: <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
	 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
	 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
	 <agM8cxqUCJNjBDlm@sgarzare-redhat>
	 <20260512120019-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260512120019-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR08MB10828:EE_|DU4PR08MB11575:EE_
x-ms-office365-filtering-correlation-id: f6323cf0-9d47-461b-dec9-08deb0d4467f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 +rHSnO+qsh776kFWZi/uEN4t6U7sAz6P4p1enpmWz3LzB0FK9r90+1gnTybKnnbcKNcH4HGaj9Ot9pyymLZg4kaDqeyp1jduR5FgP+FQyEVA9C8ggg9hjkOSaZIdUEU5rA/3QaDqSJS7gkyWXt3rxnzAEJtxjoRcieEInNosDlM8Fgps0e/iZNzdS0jyR8TNPaNol+n8CaBUKo1kFrxexsQVQk8PBOk36tZkOj4Zp/YcgkGLMQdNCigyBRte+Sh4w+C1tYM9sflM/JpH4FcQWL/FCwxA6m83sq7I5RG0IKoGmtxgVwVGvyw8GjnIYEN+gBCzwu8Zswk2Erm+k1pcXGOSii5cbfKRUEfcQAoowcov4g7P0ebDj56shU6siCsxKBT0tx0ofo2HCrvuUUvt6De72PT5T3ygdiE1OIv4udCgIHMHw1fIwwV7LqShi+tYZMxLJHfLCSTy2HyNT+DIo4cfulstc5Jp1pqi6G72+AN02iVK+lSz7RzODV36W4JdVCZyP0fnDQwnx/c0cmY+bgw8G0tnea5/8pJUX9JwijgSYb9dW2gmE54cychSCEmZ9FDw7UPgtOhofeQKSkyBtExGHEd2pRTkFdCHspqb3huLqcms3fbh1cJaWBd9RZbg/59nWQApWpYPDOSqQPeo7Z3goCcBbdKgOomk2NuAnlVOdiEVlv7MqUgYDs4su0Oo+mv5xE7xdwPLY4gFh00cmzZS6RJHKDv74BfuO7LtSmUf/yy9gRNYN9FkxlKWO+9R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10828.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlkrTjM0NGVUUFBHMHc4YmhhdjZsNlIxdlVweUFNYUthVFpodVN5OXNLRHAw?=
 =?utf-8?B?L1IrRkdtL2kyZFptc1FNRGdWZUw4WWNKclZxbWZFT3JodCtRRHh1RXVnQUtl?=
 =?utf-8?B?WFNDSE9EQ3pUVzJZZFB1MlBFMjcyWDFpVTc1REVnbXl2bFFSSnloUXl6WUhU?=
 =?utf-8?B?SHh5eHRjVHlvSE00dk43dFk2TEpJTmdhdzdTbW42K0FGL0dXZ2F3UmdDcFJW?=
 =?utf-8?B?TUJuQmJHZ2JhVkxLQjZNbkoxRzF0S2xGU29Kczd1RlFaMmtTSkNUc0lwbkJo?=
 =?utf-8?B?VmNpOWxDQnJtR2hoa0x0Y1VWUXZBSTY1cFowYTIvQUJHOUEwZm5YamZKK3BS?=
 =?utf-8?B?blRJb1ZzT2ZyUWhIREFzLzJkeVExeGl5dXdnK3IxcWZ3QlRVdFRjZlllRy9X?=
 =?utf-8?B?TmRpdTFRRDhoSEVoU1RrNVNUM3FDUjR0TTBhV1Rld1hCVGNRL1l4SW00TWNr?=
 =?utf-8?B?UkpmR2lseEc2ekRPUmJMdUpqbGRpRjRzS1dTaXplb2JHeU01VmhISXhVemtO?=
 =?utf-8?B?QzFOSG1DM2pnMGlVYzBaKzJJWVhpTnJ1bURrY1dLZ2lVckUyU3duTU90WWhS?=
 =?utf-8?B?dWkyTzhZbkVCYzNDSlNuLzlyeVI3N081V05rMmpVTmx4bzZZMTNKMDJvUytW?=
 =?utf-8?B?UlkzVG94bDlqMUJsb2Y4ZG1NcGxRV0h0dkNmRExZeG52K25BZjZuMVU5M2Y4?=
 =?utf-8?B?Q1dQby9WLy91ODRzU2Zxc005dXE0b2ZyanR6VlFrS2JjY1BUR3YwNEhiZEZP?=
 =?utf-8?B?d0Y0N0l3eW8vRWtPSytmUGNQeUxqUnAxS1ZFdUhPOWo2TldOeG95cXhKN0Rx?=
 =?utf-8?B?Z0NqcjVnN1RtdWRKNmttdkRTemo2ZmVlb2JkQnNpeU4ycTJ0YVpsbGxlRWRK?=
 =?utf-8?B?b2E3VzhUMUlSM1lDMityV3Zrby9TVXh1Uk42aEs0L3Z0aDFsbjVabzBYWHFR?=
 =?utf-8?B?bFM5QXdmUnpYSWJrTVB4SUNvdkVvcDhNU05ZeWlYQjdFa0xCbkJZMW96YTh6?=
 =?utf-8?B?WkFSVEpkUllJK0lkU204OEpmTWlFR1lGRkZCMk5DL2RBY0J0UktMWjZtVkNL?=
 =?utf-8?B?eXlEM21sdVNGTitRZXROQkVxY2hkVFFaTy9iSEYvSDY4dDA3c1VXckE0RnNy?=
 =?utf-8?B?cGg1VlJDc3dJVktDcXJVMk9hTDZwVktuaUZsaFB1djNROWhkdEV4V0dodG5E?=
 =?utf-8?B?a1RCL25JeS9NNGFiT2NHWFE0ZDI4TEpuOEhoRE4yZUh3ZVY2Uzk1OHZydmg4?=
 =?utf-8?B?V2FjTHMyNEVlbnBuUFV3cU5EWThXM05NWU52eit1TWJlVXd1ZFQzNFZCTmt2?=
 =?utf-8?B?L2NmZmxmcHBvUTIvQTFpaWhwcWtQSzRsaGVRUGFSVDEzNkZVUEl3ZkhuSSts?=
 =?utf-8?B?cVI0VWt6ejRnTjdJajFOdjBqT2pZbnc2Wm1kcmpKYS9sVS85a1VCZVNma3Bn?=
 =?utf-8?B?dWJ5L2RhQTBoOFFiMFJkK0xTZjRSNTBueXVqVlMwZWNFSThWRFFZVEFDYitP?=
 =?utf-8?B?L014U1djei8zOW9pQVFGV29RNDIvc1E4MVlqT1l5Um44QVFQd3kweEI3eGkw?=
 =?utf-8?B?bks1OWtCV1luQWRGblZ2Tjh3a0cwS1BSVzFVaG42KzVISEh3bDI3NWR5STV5?=
 =?utf-8?B?eWkzU1pGOFcwb0pHWDZ2dStHVnBrWSsvL1VMeWRQVXpaNlpFQ29IeVhYaXRo?=
 =?utf-8?B?Q1l2bkppZFZvK3pQWGROSWNBbGc3NU1kanJwdXpTRllKL1JFUE5PYWtsNDlj?=
 =?utf-8?B?WXhVV3RrYnhwbzhRVXpKR1Jhd1NTRFdheFFNSzFheUt4MzgrR2tHbXdneUNU?=
 =?utf-8?B?dTl2V0M3cmFjaWFWcVk1MlBNa1ExOXpNMytpb1diZGkvTVE1NXNSSTJYMnJv?=
 =?utf-8?B?UEdJM3dEM1FlNldQSHFENEpvai83cFVlSWZlM2drVUpqeFhqbWg5VmRRN3pH?=
 =?utf-8?B?YnZTV2t1akd2dmkvM2JPUnJBbUtGTW8zWGVQSVlldDY3WE5zaG9Oem03ZGpq?=
 =?utf-8?B?Rjg5MHBTR0pHeHUrbGZZR0hFQ01KMjRCWGUrMUE5SzZHbkxLNkl6QnZ5azdK?=
 =?utf-8?B?TTNQZlJJTlNyRWpxSEF0K1FaQWlPSW92WHd0eDJBUlhhdDJ2dVA3MXZzZ2g1?=
 =?utf-8?B?RXJGMlRxTWFnZ1RKU05peS81dmpMLzVoOWJEajY2N1NSZnViNnByQXBpQ2wr?=
 =?utf-8?B?WkpxclZ3cU5JSXVTdCsxeDVRTzJqWUFxV1dGaWhVY043S2syUFNId2JRRlFt?=
 =?utf-8?B?YWd1a1pmN3RBTFZQcnVObU9Za1lRaXVJNDBzTVArclBHWTJxaXlRWHR0STNN?=
 =?utf-8?B?bXUrZjNZQlNoenlNRHRQYTh4UW4rZTdSVnJzODM5ZUI3Z3U5VVRPOXFTcmxh?=
 =?utf-8?Q?LkR82Db9Wq+1x80M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAEBAB12D4DCC409057617AE8BD87F3@eurprd08.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6323cf0-9d47-461b-dec9-08deb0d4467f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 09:44:49.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsFTtrYzLCPr3q2xvqHPpouUn9/YeGBAe/Zg+MOKTkky6693wi9U+QrRgCE9cCx5p5kKvevEX3HSyETgXcEpuEBtIzEkeoESv9zlHKMy6RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11575
X-Rspamd-Queue-Id: 0E468530E34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287505-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[polina.vishneva@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:dkim,openvz.org:email]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDEyOjAyIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgTWF5IDEyLCAyMDI2IGF0IDA1OjM5OjQ4UE0gKzAyMDAsIFN0ZWZhbm8g
R2FyemFyZWxsYSB3cm90ZToNCj4gPiBPbiBUdWUsIE1heSAxMiwgMjAyNiBhdCAwMjozMjoxNFBN
ICswMDAwLCBQb2xpbmEgVmlzaG5ldmEgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjYtMDUtMTEg
YXQgMTc6NTYgKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gPiA+ID4gT24gTW9u
LCBNYXkgMTEsIDIwMjYgYXQgMDQ6NTY6MTBQTSArMDIwMCwgUG9saW5hIFZpc2huZXZhIHdyb3Rl
Og0KPiA+ID4gPiA+IEZyb206ICJEZW5pcyBWLiBMdW5ldiIgPGRlbkBvcGVudnoub3JnPg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFdoZW4gdGhlIGhvc3QgaW5pdGlhdGVzIGFuIEFGX1ZTT0NLIGNv
bm5lY3QoKSB0byBhIGd1ZXN0IHRoYXQgaGFzIG5vdA0KPiA+ID4gPiA+IHlldCBsb2FkZWQgdGhl
IHZpcnRpby12c29jayB0cmFuc3BvcnQgKGkuZS4gc3RpbGwgYm9vdGluZyksIHRoZSBjYWxsZXIN
Cj4gPiA+ID4gPiBibG9ja3MgZm9yIFZTT0NLX0RFRkFVTFRfQ09OTkVDVF9USU1FT1VUICgyIHNl
Y29uZHMpLCBiZWNhdXNlDQo+ID4gPiA+ID4gdmhvc3RfdHJhbnNwb3J0X2RvX3NlbmRfcGt0KCkg
c2lsZW50bHkgZXhpdHMgd2hlbg0KPiA+ID4gPiA+IHZob3N0X3ZxX2dldF9iYWNrZW5kKHZxKSBy
ZXR1cm5zIE5VTEwuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4gU09fVk1fU09DS0VUU19DT05ORUNU
X1RJTUVPVVQgaGVscHMgb24gdGhpcz8NCj4gPiA+IA0KPiA+ID4gSXQgY2FuLCBidXQgaXQgbWln
aHQgYmUgZGlmZmljdWx0IHRvIGZpbmQgYSBjb3JyZWN0IHRpbWVvdXQuDQo+ID4gPiANCj4gPiA+
IEFuZCwgZ2VuZXJhbGx5LCB0aGVyZSdzIG5vIHdheSB0byBkaXN0aW5ndWlzaCAidGhlIGd1ZXN0
IGhhc24ndCB5ZXQgaW5pdGlhbGl6ZWQNCj4gPiA+IHRoZSB2cSIgZnJvbSAidGhlIGd1ZXN0IGlz
IHVwIGFuZCBydW5uaW5nLCBidXQgZGlkbid0IHJlcGx5IHRvIGNvbm5lY3QoKSBpbg0KPiA+ID4g
dGltZSIuIFRoYXQncyBleGFjdGx5IHdoYXQgdGhpcyBwYXRjaCBpcyBhdHRlbXB0aW5nIHRvIGZp
eC4NCj4gPiANCj4gPiBPa2F5LCBzbyBwbGVhc2UgbWVudGlvbiB0aGlzIGluIHRoZSBjb21taXQg
bWVzc2FnZSwgSSBtZWFuIHdoeQ0KPiA+IFNPX1ZNX1NPQ0tFVFNfQ09OTkVDVF9USU1FT1VUIGNh
bid0IHJlYWxseSBoZWxwLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IElmIHRoZSBndWVzdCBkb2Vzbid0IHN0YXJ0IGxpc3RlbmluZyB3aXRoaW4gdGhpcyB0
aW1lb3V0LCBjb25uZWN0KCkNCj4gPiA+ID4gPiByZXR1cm5zIEVUSU1FRE9VVC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUaGlzIGRlbGF5IGlzIHVzdWFsbHkgcG9pbnRsZXNzIGFuZCBpdCBkb2Vz
bid0IHdlbGwgYWxpZ24gd2l0aCBvdXINCj4gPiANCj4gPiBJIHN0aWxsIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IHRoaXMgaXMgcG9pbnRsZXNzLiBJZiBhbiBhcHBsaWNhdGlvbiB3YW50cyB0bw0KPiA+
IHdhaXQgd2hpbGUgc2xlZXBpbmcsIGl0IGNhbiBzaW1wbHkgaW5jcmVhc2UgdGhlIHRpbWVvdXQg
bG9uZyBlbm91Z2ggdG8gd2FpdA0KPiA+IGZvciB0aGUgVk0gdG8gc3RhcnQgdXAgYW5kIHVzZSBh
IHNpbmdsZSBgY29ubmVjdCgpYCBjYWxsLCBpbnN0ZWFkIG9mDQo+ID4gY29udGludWluZyB0byB0
cnkgYW5kIHdhc3RpbmcgQ1BVIGN5Y2xlcyB1bm5lY2Vzc2FyaWx5Lg0KPiA+IA0KPiA+IEhtbSwg
b3IgbWF5YmUgbm90LCBiZWNhdXNlIHRoZSBkcml2ZXIgd2lsbCBkZWZpbml0ZWx5IGJlIGluaXRp
YWxpemVkIGJlZm9yZQ0KPiA+IHRoZSBhcHBsaWNhdGlvbiB0aGF0IHdhbnRzIHRvIGxpc3RlbiBv
biB0aGF0IHBvcnQsIHNvIGl0IHdpbGwgcmVzcG9uZCB0aGF0DQo+ID4gbm8gb25lIGlzIGxpc3Rl
bmluZywgYW5kIHRoZSBgY29ubmVjdCgpYCBjYWxsIHdpbGwgZmFpbCB3aXRoIGFuIGBFQ09OTlJF
U0VUYA0KPiA+IGVycm9yIGluIGFueSBjYXNlLiBSaWdodD8NCj4gPiANCj4gPiBJZiBpdCBpcyB0
aGUgY2FzZSwgaXMgdGhlIGZvbGxvd2luZyBsaW5lIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24g
Y29ycmVjdD8NCj4gPiANCj4gPiAgICAgSWYgdGhlIGd1ZXN0IGRvZXNuJ3Qgc3RhcnQgbGlzdGVu
aW5nIHdpdGhpbiB0aGlzIHRpbWVvdXQsIGNvbm5lY3QoKQ0KPiA+ICAgICByZXR1cm5zIEVUSU1F
RE9VVC4NCj4gPiANCj4gPiBJIG1lYW4sIGFsc28gaWYgdGhlIGFwcGxpY2F0aW9uIHN0YXJ0cyB0
byBsaXN0ZW4gd2l0aGluIHRoZSB0aW1lb3V0LCBJIHRoaW5rDQo+ID4gdGhlIGNvbm5lY3QoKSB3
aWxsIGZhaWwgaW4gYW55IGNhc2UgYXMgSSBwb2ludGVkIG91dCBhYm92ZSAodGhpcyBzaG91bGQg
YmUNCj4gPiBhbm90aGVyIHBvaW50IGluIGZhdm91ciBvZiB0aGlzIGNoYW5nZSkNCj4gPiANCj4g
PiANCj4gPiBCVFcsIEkgdGhpbmsgd2Ugc2hvdWxkIGV4cGxhaW4gdGhpcyBtb3JlIGNsZWFybHkg
Ym90aCBoZXJlIGFuZCBicmllZmx5IGluDQo+ID4gdGhlIGNvZGUgYXMgd2VsbC4NCj4gPiANCj4g
PiA+ID4gPiBiZWhhdmlvciBhdCBvdGhlciBpbml0aWFsaXphdGlvbiBzdGFnZXM6IGZvciBleGFt
cGxlLCBpZiBhIGNvbm5lY3Rpb24gaXMNCj4gPiA+ID4gPiBhdHRlbXB0ZWQgd2hlbiB0aGUgZ3Vl
c3QgZHJpdmVyIGlzIGFscmVhZHkgbG9hZGVkLCBidXQgd2hlbiBub3RoaW5nIGlzDQo+ID4gPiA+
ID4gbGlzdGVuaW5nIHlldCwgaXQgcmV0dXJucyBFQ09OTlJFU0VUIGltbWVkaWF0ZWx5IHdpdGhv
dXQgYW55IHdhaXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4IHRoaXMgYnkgY2hlY2tpbmcg
dGhlIFJYIHZpcnRxdWV1ZSBiYWNrZW5kIGluDQo+ID4gPiA+ID4gdmhvc3RfdHJhbnNwb3J0X3Nl
bmRfcGt0KCkgYmVmb3JlIHF1ZXVpbmcuIElmIHRoZSBiYWNrZW5kIGlzIE5VTEwsDQo+ID4gPiA+
ID4gcmV0dXJuIC1FQ09OTlJFRlVTRUQgaW1tZWRpYXRlbHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogRGVuaXMgVi4gTHVuZXYgPGRlbkBvcGVudnoub3JnPg0KPiA+ID4g
PiA+IENvLWRldmVsb3BlZC1ieTogUG9saW5hIFZpc2huZXZhIDxwb2xpbmEudmlzaG5ldmFAdmly
dHVvenpvLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQb2xpbmEgVmlzaG5ldmEgPHBv
bGluYS52aXNobmV2YUB2aXJ0dW96em8uY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IGRy
aXZlcnMvdmhvc3QvdnNvY2suYyB8IDEwICsrKysrKysrKysNCj4gPiA+ID4gPiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMNCj4gPiA+ID4g
PiBpbmRleCAxZDhlYzZiZWQ1M2UuLmEzZjIxODI5MmMzYSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zz
b2NrLmMNCj4gPiA+ID4gPiBAQCAtMzAyLDYgKzMwMiwxNiBAQCB2aG9zdF90cmFuc3BvcnRfc2Vu
ZF9wa3Qoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldCAqbmV0KQ0KPiA+ID4gPiA+IAkJ
cmV0dXJuIC1FTk9ERVY7DQo+ID4gPiA+ID4gCX0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiArCS8q
IEZhc3QtZmFpbCBpZiB0aGUgZ3Vlc3QgaGFzbid0IGVuYWJsZWQgdGhlIFJYIHZxIHlldC4gUmVh
ZGluZw0KPiA+ID4gPiA+ICsJICogcHJpdmF0ZV9kYXRhIHdpdGhvdXQgdnEtPm11dGV4IGlzIGRl
bGliZXJhdGU6IGV2ZW4gaWYgdGhlIGJhY2tlbmQgYmVjb21lcw0KPiA+ID4gPiA+ICsJICogTlVM
TCByaWdodCBhZnRlciB0aGF0IGNoZWNrLCBkb19zZW5kX3BrdCgpIGNoZWNrcyBpdCB1bmRlciB0
aGUgbXV0ZXguDQo+ID4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gPiArCWlmICghZGF0YV9yYWNlKFJF
QURfT05DRSh2c29jay0+dnFzW1ZTT0NLX1ZRX1JYXS5wcml2YXRlX2RhdGEpKSkNCj4gPiA+ID4g
DQo+ID4gPiA+IFdoeSBub3QgdXNpbmcgdmhvc3RfdnFfZ2V0X2JhY2tlbmQoKSA/DQo+ID4gPiAN
Cj4gPiA+IEJlY2F1c2UgaXQgbG9ja3MgdGhlIG11dGV4LCB3aGljaCBpcyBzbG93IGFuZCB1bmFj
Y2VwdGFibGUgaW4gdGhpcyBob3QNCj4gPiA+IHBhdGguDQo+ID4gDQo+ID4gZWhtLCBzb3JyeSwg
d2hpY2ggbXV0ZXggYXJlIHlvdSB0YWxraW5nIGFib3V0Pw0KPiA+IA0KPiA+IEkgc2VlIGp1c3Qg
YSBjb21tZW50IGFib3V0IHRoZSBtdXRleCB0byBiZSBhY3F1aXJlZCBieSB0aGUgY2FsbGVyLCBi
dXQgSQ0KPiA+IGRvbid0IHNlZSBhbnkgbG9jayB0aGVyZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gQWxzbyBpcyBSRUFEX09OQ0UoKSBva2F5IHdpdGhvdXQgV1JJVEVfT05DRSgp
IHdoZXJlIGl0IGlzIHNldCA/DQo+ID4gPiANCj4gPiA+IEl0J3MgcmFjeSwgYnV0IGFzIGRlc2Ny
aWJlZCBoZXJlIGluIHRoZSBjb21tZW50IGFuZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsDQo+ID4g
PiBhbnkgcG9zc2libGUgcmFjZSBvdXRjb21lIGlzIGNvdmVyZWQgYnkgdGhlIHN1YnNlcXVlbnQg
Y2hlY2tzLg0KPiA+IA0KPiA+IE9rYXksIHNvIHdoYXQgaXMgdGhlIHBvaW50IHRvIGNhbGwgUkVB
RF9PTkNFKCk/DQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gPiB7DQo+ID4gPiA+ID4gKwkJcmN1X3Jl
YWRfdW5sb2NrKCk7DQo+ID4gPiA+ID4gKwkJa2ZyZWVfc2tiKHNrYik7DQo+ID4gPiA+ID4gKwkJ
cmV0dXJuIC1FQ09OTlJFRlVTRUQ7DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIGEgZ2VuZXJp
YyBzZW5kX3BrdCwgaXMgaXQgb2theSB0byByZXR1cm4gRUNPTk5SRUZVU0VEIGluIGFueQ0KPiA+
ID4gPiBjYXNlPw0KPiA+ID4gDQo+ID4gPiBFSE9TVFVOUkVBQ0ggd291bGQgcHJvYmFibHkgYmUg
YmV0dGVyLg0KPiA+ID4gQWxsIHRoZSBjdXJyZW50IHNlbmRfcGt0IGZ1bmN0aW9ucyBvbmx5IHJl
dHVybiBFTk9ERVYsIGJ1dCBpdCBoYXMgZGlmZmVyZW50DQo+ID4gPiBzZW1hbnRpY3M6IHRoZXkg
bWVhbiB0aGF0IHRoZSBsb2NhbCBkZXZpY2UgaXNuJ3QgeWV0IHJlYWR5LCB3aGlsZSB0aGVyZSB3
ZSdyZQ0KPiA+ID4gZGVhbGluZyB3aXRoIHRoZSBvcHBvc2l0ZSBlbmQgbm90IGJlaW5nIHJlYWR5
Lg0KPiA+IA0KPiA+IEluIHRoZSBBRl9WU09DSyBwcmVzcGVjdGl2ZSwgSSBzZWUgRU5PREVWIGxp
a2UgdGhlIHRyYW5zcG9ydCBpcyBub3QgcmVhZHksDQo+ID4gc28gSSB0aGluayBpdCBjYW4gZXZl
bnR1YWxseSBmaXQgaGVyZSB0b28sIGJ1dCBhbHNvIEVIT1NUVU5SRUFDSCBpcyBmaW5lLA0KPiA+
IGZvciBzdXJlIGJldHRlciB0aGFuIEVDT05OUkVGVVNFRC4NCj4gPiANCj4gPiBUaGFua3MsDQo+
ID4gU3RlZmFubw0KPiANCj4gSSB0aGluayBpdCdzIHdvcnRoIHRyeWluZyB0byBkbyB0aGUgc2Ft
ZSB0aGluZyB3aXRoIGUuZy4gVENQDQo+IGFuZCBzZWUgd2hhdCBlcnJvciwgaWYgYW55LCB3ZSBn
ZXQuIE1hdGNoIHRoYXQuDQoNClRoaXMgY2FzZSBpcyBub3QgZGlyZWN0bHkgYXBwbGljYWJsZSB0
byBUQ1A6IGluIFRDUCwgdGhlcmUncyBubyBvdXQtb2YtYmFuZCB3YXkNCnRvIGRldGVjdCB0aGUg
Imhvc3QgdXAsIGJ1dCBub3QgaW5pdGlhbGl6ZWQgeWV0IGFuZCBub3QgcmVhZHkgZm9yIGNvbm5l
Y3Rpb25zIg0Kc3RhdGU6IHRoaXMgY291bGQgdGhlb3JldGljYWxseSBiZSBFTk9QUk9UT09QVCwg
YnV0IG5vIHJlYWwgVENQIHN0YWNrIGltcGxlbWVudA0KdGhpcywgYmVjYXVzZSByZXBseWluZyB3
aXRoIElDTVBfUFJPVF9VTlJFQUNIIHJlcXVpcmVzIGEgVENQIHN0YWNrLCB3aGljaCBpcw0KZXhh
Y3RseSB0aGUgdGhpbmcgdGhhdCBpc24ndCB1cC4NCg0KU28sIGluIHJlYWwgd29ybGQsIGEgc2lt
aWxhciBzaXR1YXRpb24gd2l0aCBUQ1Agd291bGQgcmVzdWx0IGluIEVUSU1FRE9VVC4NCg0KPiAN
Cj4gDQo+ID4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywgUG9saW5hLg0KPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IFN0ZWZhbm8NCj4gPiA+ID4gDQo+ID4gPiA+ID4g
Kwl9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IAlpZiAodmlydGlvX3Zzb2NrX3NrYl9yZXBseShz
a2IpKQ0KPiA+ID4gPiA+IAkJYXRvbWljX2luYygmdnNvY2stPnF1ZXVlZF9yZXBsaWVzKTsNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBiYXNlLWNvbW1pdDogOGFiOTkyZjgxNWQ2
NzM2YjVjN2E2ZjVmZDdiZmU3YmMxMDZiYjNkYw0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi41
My4wDQo+ID4gPiA+ID4gDQo=

