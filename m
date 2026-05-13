Return-Path: <netdev+bounces-287519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfYI1lUBGp/HAIAu9opvQ
	(envelope-from <netdev+bounces-287519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E420A53168F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D81C302A05E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D839A05F;
	Wed, 13 May 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L+4cw5ug"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022118.outbound.protection.outlook.com [52.101.66.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659437BE74;
	Wed, 13 May 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668452; cv=fail; b=OMm98fK2j0ayN0qR8LWM81IwPFNUxS+K+7d/5AuUkvmr81gE6DgQ2xOEC4qRiKnn4etV7fyG5OBL7LH2yCXJAqK7o7MpJFrDud53ZH/3YHAokV5o1Jh434uQi2pTEJxWVh2G5HrVHsvxEc32Qy+Asky0x0QtrVi34cN6ulscbTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668452; c=relaxed/simple;
	bh=6tSqa3wJC6dmb/y1a3he+yPjtbpBPRoNweAZJpyiRb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tw2nAVLt7f3qq4zRO+hSMc6Zl2yYKIfVcbyZOsfc+pw5mXSplLJ5vGpfu5xDMNERDwFxGtinCHCkG9UotLMFLBa5tCei8ytwmCKDFMi249UmQPyuC0Ebek7VY6iVzhYjnTgK7+ZnyNGy2XzCxL1bA0f8BLQi8pPyjF+jdHFTxHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=L+4cw5ug; arc=fail smtp.client-ip=52.101.66.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PetVtpjYyZw857+WacnUyuLrsmI8Zs+FURQGOflI++atqA+e+y8TEItikFFH8IqLgPlu2PRUnnxpTt0RnaHi4VgISIBthU0RcJFoTz3MGWRQxt6ysnE2u2O6t+ktnrhUpHpz/yhaAYdk1zPmB4OOrivMe1eZSHjeO3ltwsuUfGJy5yaZtqE/boSTE4d+3b6RFlndAx87Zq8Av8G6iPkYXQQxkgxQsF6LeplzkavvK/SSR7T/Bpn4Y/l/Z9e3GfL3IBjBL0J5KEc+ykOvD5FG2dLo+fJYrvTT+yysVowJYCIk8YrPXRmuhuGx+HqraZJBFEOqVqlF+Z5qP0ocMHvtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrkeOoXup4+YsyOYfITMhomhLbgl9xKWG7tzi4DAf+8=;
 b=eBqZI0Ny6LeDPBCZ1qVquANPLEao4nQguR+MwHzItJ3ulwuLg/vsPlz+vmX+9S/TpsRcW7RNncue3zE/ZMY3T4bFPFpRlYM0g3qvrskJqFfqkAFNNWjck+jXhk9sGRRk5E0mHUIfQ28R1liN3iq0cJb1KlYBl86qBjPNfpwII43hyJwhgHpFdYNYM0AnAFhRJbIfrJ82/xWWSY5XqJyXFVkqjLbZePv5e7Ja7IdNLmFNScJsQDkniG17M330bT8JTnSZWJi99Z2fnOPmsfiN7faPs922576AUCI2Vs5WozN9jfuzgKVjlawPLMyPUMPkUcTjs79Rv//Qq9DAC79DMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrkeOoXup4+YsyOYfITMhomhLbgl9xKWG7tzi4DAf+8=;
 b=L+4cw5ugLbDBda8UYP/ZvOtY8HhRMFsP11ArsYkOwyAcAdslswaFqEi7xA4/96Uu+gUcVmzQPavdcirny8TLwIfEQDUFXbanPO/RjklrV4MHdksXBHjAjFX0Jgq83bEzYLDWQB1trRv9OtL0GWJqGDSM7ellqlJFVWAVslBNkhzwCd4yNgn/ss69smIPeUsQ5gxJ/NY7cch0fWo92yODoIV13ngN/JEWatYMpPjS/fMgaR37nl0GUQuKFMqDrhXUNEmMR7sO5JgXde2xyQrWr42CPmlMfKL+FO/fccxJglPjySIOHUS9A0mMNS240UY+sRSj4zc66zjyoS0pPn/P+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS2PR08MB10322.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:34:06 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:34:06 +0000
Message-ID: <c20d5ca6-b810-4732-9f59-376f9f77f854@virtuozzo.com>
Date: Wed, 13 May 2026 12:34:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when guest
 isn't ready
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "den@openvz.org" <den@openvz.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
 <20260512120019-mutt-send-email-mst@kernel.org>
 <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
 <20260513060124-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260513060124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000228.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f1) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS2PR08MB10322:EE_
X-MS-Office365-Filtering-Correlation-Id: bf903090-5261-4c84-c03e-08deb0db28bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IICj2R8OMIpGCCiVNTaUv4qNzm617+P15KIKci2K7YDZ1fgioXLrT151Ey0zxFohTuEJyPZGNC+toYobFMmwlBhNPLL0vEUPOANBmLBLlZiuK4SZBDF+ZisQqVawmUOMxhXO8jToBFTOx+cMZMnUjrH1b421QuRtovONj3vGrfd+7DbiO8rnpAWsp09IiXSjZ1B3OgKOx8vbWSI6rzlNAUToGzzIkGAPYpZBPSmYuFXO3uTtPuwPOTlRiUqPj3kutG20+gs9/8OlXeapmi+CKKbw3Ql/gc8I5caN68WH6pSb0ZBXLQQSYtoy2aIzPucMNuTAelCU2oOJO3HHFIuLk2L5cM/FVTNFduyHUTsdOzfzRB3IryushL/lRhF13FaiFSLOholmX7184FoZuvzzw9ttoFDmUjVsU13S+WICbBkiJR3rVey6IqYUvn4Q6pa82KYm1pG64y8Aa/jwDkEs/pHxXkD7/H4/uOxRCdTdsnySa8qxm52mq9bXumM0pqH6tYL8nYxSTVzsHPP9FtHb+lgLUnq2Gy7rH/8+zrmfVTo96Ka5GMGqyWjxcqWXsacY2HWGV6GA7NRNZ6S+RYtFIHsXjSW0wG3rSRxMu6hG3yx9bFBPJXRjGDCXyOXv7C0cXHcWBDl2wh/fvy1O/3toMo6ZtDrdMaV21VdX+63KS+BlH3xOWNEHcDBOYzhdeea3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REF3R1p6VExNUmkvc0ZwUG15R2QvTTZsV1RYUXRwSXdqL0wwNEJNNERpS2Z5?=
 =?utf-8?B?QjRJMDY5VGJWUDhucWVUQXJkT3FrdGRMQWRtQnpPaC8zOGc3c2NKVnBOaUdo?=
 =?utf-8?B?Q21hTU9XdWV5eG5EVWVkS2IweXJwaU13WmpFMkpuOUd3dHo2L2t3M0ZtTy9C?=
 =?utf-8?B?OStaRDYzVFRuOU15UzRLQzh5VHVLUU1UWjZ3VVlWVVdTb09Qa0ZDQWs5NG1O?=
 =?utf-8?B?dDlzcE4yZHJNbjdKa1A2cVFJbC9DWHBSSzBxWXdwQ09TMkZsU3BURHNzb2Ns?=
 =?utf-8?B?ak9HNnB5OGtzSmZ5UllxK28xcVpDc3FVejhVNldySjgzM2ROMUFteFVWYjZ2?=
 =?utf-8?B?ZzJzNHF6NUsxWmRvU0wvVTBJQW00d3hqalEzNnh1QmV1UkhLRVpwa0Z1OTNq?=
 =?utf-8?B?ZTJweUJIOVhTWGs1ajR2cnRnMjJHZTQ0czJ3NVlyS2k0K290N0k2aFBqWVo0?=
 =?utf-8?B?aGsvSFNlc3M3bEFuY2VhVUZVeUlGZ0YyR0lvc09memRVUFNTNU52SXR4SWRB?=
 =?utf-8?B?UVRodFFyOFpRc09EQzJlQnpPL2Q4R1ZzWDdyVU9hU3AvRTJzclJCTXlXdHgv?=
 =?utf-8?B?N1B4Mk5RTFBHOEJVdGpnOEZ1OGFYNnhyQlNpQWhtSXVpbHpmVzV3TUd2LzRQ?=
 =?utf-8?B?alNVZzFqZkI2cU0wbmNmM3dxWmZEMU9rQmhWc3ZjQzgvZUFGVUk2UkVqN2RT?=
 =?utf-8?B?RTM1TWtRTWt6VlFjZHRmblkxMytDYXBmbEFiakNZOWpkUkRhbnMvK3BGNmNW?=
 =?utf-8?B?S0FyZ0dYeTRDNTA4Y1hiWGhnL3R6SHhQKzJWMEZObGRwek5VTllDdjE0eFg1?=
 =?utf-8?B?aEZpZFFSZVEyOWp0S0Z3MllBRjlaTFBHVWtvdUxGK005MjhLSXF4a3VXa2Q3?=
 =?utf-8?B?bFhtQzN0bEErb2o3WmQwdWpXKzlaNXJ1RWt6MlZMclZDeGZHa0tmTFhWNDJ1?=
 =?utf-8?B?UXp5bGFRUnJ4OXk5djBLYzRKUVpnZnA3c0lJMFVteU4wbVBTUnI4U2RDM0ZZ?=
 =?utf-8?B?WjRsUmhGUy9CTW1MYVc5ak1JaEtTRWhVYWlmcVBCQzJPVTlHc1VnKzFVVDA1?=
 =?utf-8?B?U2Z4NnVxbExIN2JlcXlpeGp4YVplTWlEaVJ1NWZPdWY1MUlHTkVOYkVsVnBR?=
 =?utf-8?B?TUFuYVBiT01SMTRiUDFLd1VxcXBRenNqNlRLbzBzVUZxYmRvUDRvQzQrRkdi?=
 =?utf-8?B?NUFTTlVialpsYklqTnF6bDc5enVJVFVOZUJrNDc4dnB1Nm9EcHFoa0JTT0lJ?=
 =?utf-8?B?SzUwTm1yOUhuQVhHT1JrbFZiRU84b0J2SHg3NllTVlludlJINmp5cU51dGlL?=
 =?utf-8?B?YlZrNUtoMzRzQlJwdXY3U3IwSHM1Q1Z5Q2R6bHRERGJSNEdYWEVxT21sSkNR?=
 =?utf-8?B?Ym9CM2N1Ym56azQrbE81U3BGUGh3VnlIQU1WUS9JWUVzVmNBUVdGU3ZOcnJq?=
 =?utf-8?B?QmJBc0JEQ3R3ekp4SkZicExDWDI1elg4dWR2QVdTbkR6elM2OHY1bUkwZDd1?=
 =?utf-8?B?SzB0QlN6RGJYYStCM09xUExTdEhnMGUrc25HNEJxb0VVcStGakpKVWVRa3Ax?=
 =?utf-8?B?T1FucVJlUGZUMk0rNFpPNVozaUk2MU9VS1BFVnRNQVZlZ2lwV2JkdUtUWSs5?=
 =?utf-8?B?WGl0RFpnRkZNUVBsUTMzSmFWeG1CK2t2N2FHTStTYXNvclBvSDZLUUtNaUI0?=
 =?utf-8?B?bFJ0WE51dllYSmNSM1VTV3dIZVp4M0lMc0R5NTNNdGhXT0F0bUFSRlRCeFA2?=
 =?utf-8?B?SjNJV0FObWgvQkhyOWNFZWZYMXRsbzhmKzFJSW1sTy92b1BzVWNHSHdTUTNz?=
 =?utf-8?B?aUtycVNVUnVJQ1VEakNkR0pWRVo3NStqY21yWWMrd0dGYmw0RWFpV0pvMXo5?=
 =?utf-8?B?djRXL3FnWmY4SzlUbEw5NjJHVU5DR3pEZzN4c0hVN2Z1MSs3LzZUVVRHSTYv?=
 =?utf-8?B?YXpyakw4Mlh0d3JQdHgrV01kN1g0bDlKc0w2ZFVFdUVkbFNWRGJ1Tk03dGk0?=
 =?utf-8?B?aU1rNEE5RWo4ME1ZRTJXWmFUYm9xa0NvU0VBaURKSkZvMW5OY3RyV1lDQ0cy?=
 =?utf-8?B?NUdvdUNMeHpiWk1zYTFkMmdXSUI0SnpVZFJVR3d4dEVLaTRtTWNpOXFlNFQx?=
 =?utf-8?B?N0t0WVJabmRadldhNWNCeDVHOVdOeXhNU0RNYnJkeXRwZU54SlI1VzkvNnl6?=
 =?utf-8?B?S01qdDZOSWdSSHp3eHovV2hTbDdZU3FUVHJQOVJwZGV6dzdpaTBJRjF3YUpR?=
 =?utf-8?B?UTFTejc3RFRRZGtZZzZYMlpsRm91Y0lwUG1tTXl4TVd3VUJpSVZoRUNndEpS?=
 =?utf-8?B?Qlk3OTVlQ24vWkY5NUF5Vk1kWWZsRDF4eGtvanJsZ3RMVEpwdVdpN2Z0RnJj?=
 =?utf-8?Q?pP7uW9Ay017DuCogzmISM8ZJEhroCvtvnPAiox0rS7GqA?=
X-MS-Exchange-AntiSpam-MessageData-1: +Jr+m814fET06Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf903090-5261-4c84-c03e-08deb0db28bc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:34:06.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzU9J7ICajxcpHJMpV4puyfaT4UAq4a8iduIbgdcQjhSFdFVjVtXiaDNbtG42aQYA1TbKrfDyFXuCK0NDvjfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10322
X-Rspamd-Queue-Id: E420A53168F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvz.org:email]
X-Rspamd-Action: no action

On 5/13/26 12:03, Michael S. Tsirkin wrote:
> On Wed, May 13, 2026 at 09:44:49AM +0000, Polina Vishneva wrote:
>> On Tue, 2026-05-12 at 12:02 -0400, Michael S. Tsirkin wrote:
>>> On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
>>>> On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
>>>>> On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
>>>>>> On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>>>>>>> From: "Denis V. Lunev" <den@openvz.org>
>>>>>>>
>>>>>>> When the host initiates an AF_VSOCK connect() to a guest that has not
>>>>>>> yet loaded the virtio-vsock transport (i.e. still booting), the caller
>>>>>>> blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>>>>>>> vhost_transport_do_send_pkt() silently exits when
>>>>>>> vhost_vq_get_backend(vq) returns NULL.
>>>>>> Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
>>>>> It can, but it might be difficult to find a correct timeout.
>>>>>
>>>>> And, generally, there's no way to distinguish "the guest hasn't yet initialized
>>>>> the vq" from "the guest is up and running, but didn't reply to connect() in
>>>>> time". That's exactly what this patch is attempting to fix.
>>>> Okay, so please mention this in the commit message, I mean why
>>>> SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
>>>>
>>>>>>> If the guest doesn't start listening within this timeout, connect()
>>>>>>> returns ETIMEDOUT.
>>>>>>>
>>>>>>> This delay is usually pointless and it doesn't well align with our
>>>> I still don't understand why this is pointless. If an application wants to
>>>> wait while sleeping, it can simply increase the timeout long enough to wait
>>>> for the VM to start up and use a single `connect()` call, instead of
>>>> continuing to try and wasting CPU cycles unnecessarily.
>>>>
>>>> Hmm, or maybe not, because the driver will definitely be initialized before
>>>> the application that wants to listen on that port, so it will respond that
>>>> no one is listening, and the `connect()` call will fail with an `ECONNRESET`
>>>> error in any case. Right?
>>>>
>>>> If it is the case, is the following line in the commit description correct?
>>>>
>>>>     If the guest doesn't start listening within this timeout, connect()
>>>>     returns ETIMEDOUT.
>>>>
>>>> I mean, also if the application starts to listen within the timeout, I think
>>>> the connect() will fail in any case as I pointed out above (this should be
>>>> another point in favour of this change)
>>>>
>>>>
>>>> BTW, I think we should explain this more clearly both here and briefly in
>>>> the code as well.
>>>>
>>>>>>> behavior at other initialization stages: for example, if a connection is
>>>>>>> attempted when the guest driver is already loaded, but when nothing is
>>>>>>> listening yet, it returns ECONNRESET immediately without any wait.
>>>>>>>
>>>>>>> Fix this by checking the RX virtqueue backend in
>>>>>>> vhost_transport_send_pkt() before queuing. If the backend is NULL,
>>>>>>> return -ECONNREFUSED immediately.
>>>>>>>
>>>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>>>> Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>>>>>>> Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>>>>>>> ---
>>>>>>> drivers/vhost/vsock.c | 10 ++++++++++
>>>>>>> 1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>>>>>> index 1d8ec6bed53e..a3f218292c3a 100644
>>>>>>> --- a/drivers/vhost/vsock.c
>>>>>>> +++ b/drivers/vhost/vsock.c
>>>>>>> @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>>>>>>> 		return -ENODEV;
>>>>>>> 	}
>>>>>>>
>>>>>>> +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>>>>>>> +	 * private_data without vq->mutex is deliberate: even if the backend becomes
>>>>>>> +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>>>>>>> +	 */
>>>>>>> +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
>>>>>> Why not using vhost_vq_get_backend() ?
>>>>> Because it locks the mutex, which is slow and unacceptable in this hot
>>>>> path.
>>>> ehm, sorry, which mutex are you talking about?
>>>>
>>>> I see just a comment about the mutex to be acquired by the caller, but I
>>>> don't see any lock there.
>>>>
>>>>>> Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
>>>>> It's racy, but as described here in the comment and in the commit message,
>>>>> any possible race outcome is covered by the subsequent checks.
>>>> Okay, so what is the point to call READ_ONCE()?
>>>>
>>>>>>> {
>>>>>>> +		rcu_read_unlock();
>>>>>>> +		kfree_skb(skb);
>>>>>>> +		return -ECONNREFUSED;
>>>>>> This is a generic send_pkt, is it okay to return ECONNREFUSED in any
>>>>>> case?
>>>>> EHOSTUNREACH would probably be better.
>>>>> All the current send_pkt functions only return ENODEV, but it has different
>>>>> semantics: they mean that the local device isn't yet ready, while there we're
>>>>> dealing with the opposite end not being ready.
>>>> In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
>>>> so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
>>>> for sure better than ECONNREFUSED.
>>>>
>>>> Thanks,
>>>> Stefano
>>> I think it's worth trying to do the same thing with e.g. TCP
>>> and see what error, if any, we get. Match that.
>> This case is not directly applicable to TCP: in TCP, there's no out-of-band way
>> to detect the "host up, but not initialized yet and not ready for connections"
>> state: this could theoretically be ENOPROTOOPT, but no real TCP stack implement
>> this, because replying with ICMP_PROT_UNREACH requires a TCP stack, which is
>> exactly the thing that isn't up.
>>
>> So, in real world, a similar situation with TCP would result in ETIMEDOUT.
> Then it just might be best to keep the current behaviour which seems
> to match that pretty closely?

My motivation on this is very simple.

1. The guest is not configured rings yet
2. Connection request arrives, waiting is started
3. Guest has configured rings, assuming initialization is performed.
   Important - there is no process listening in guest on the socket
   yet, even in Linux when dependency will start next service this
   will require some time
4. The queued connection request in host revives and gets -ECONNREFUSED
   in my understanding. The destiny of the packet arrived just in this
   window would be the same
5. Guest listener starts

At my opinion packets coming in the moment 2 should have the same
resolution as packets arriving in 4, without timeout as if these
packets will be served in the moment 3 they should get this resolution.
No need to wait.

Den

