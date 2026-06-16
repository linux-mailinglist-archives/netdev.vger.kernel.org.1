Return-Path: <netdev+bounces-299861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4IJ2O0xXMWrkhAUAu9opvQ
	(envelope-from <netdev+bounces-299861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423CA6902FE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:01:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=xMueWzbG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299861-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7D5302A4D7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351F3368B2;
	Tue, 16 Jun 2026 14:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021118.outbound.protection.outlook.com [52.101.65.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350F28640B;
	Tue, 16 Jun 2026 14:01:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618502; cv=fail; b=pY7m8yB+gdqHGuTgZ/4SPZTIHHrwE8UK0bfvL2ZmkI1PS5ZkckoahagYFH/pcK7e85F+mxet/H4jhAOx10ZllFc/n+Rb/bf568ahcDpj2L2jDzqiv/bPkZQCHOwp6aOuLueuGMOb3ezmjZ9H8T7JQLe8c/xC5Pj8qp87ByN3WGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618502; c=relaxed/simple;
	bh=0YcA9wvj4YZROX3LgO83U5dhLoN5qeYSpDDjzy5RkW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RjQtFbzVfWGr2vPDb9/hDzOP7IYHA+uXNi573Yxv+wrq17c74dM7X7yn8I2GclfFNLnOdKY1hLxYQUPUvAvBTtpOS/rTOtliOpNMTYzniL8DL0rJZz1tdxx5EQdrpxFdnj+HaIp7qZuZcAbqn8/wPLZZUQv3aAgi8hfGPycgJSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xMueWzbG; arc=fail smtp.client-ip=52.101.65.118
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5NFbluMTaZRUR73rV86LGfzR8TCDSYPnRgpXIFJXodmID5N4QFvCnAXaqKzGCYMxGAYT5zdTZNSmIGaF/V3FXARrj5Fe/BSDCxYIWhiQ5FUPNt6p9XF72IyaKWXkT6N1Y+zz/6jZUaHHCXaBdtt5HCY9PYFc20gJvovE4uVNdz8Q3sRXkFg9QLNZ5d2m7aW3pNgnl/DZe0PJ+XD9iy0KWmqCK4I/GpiLvM5FMhSZZbug1tr+xZpjHKL1yLaQamCqECj2D9Kp1mVsV3QCzMorQoi6RKTKFLhWHLG2PuRndMvhbvjhI6BvbaClg8ujlyIbla0Vt8WbGpf5sXRdMxseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58AoLZS7Z9+3HlVF/FeA89oVz+zeoEVgwnmULM4jUlk=;
 b=oZzV89h8qzhZ/UGDAbTmVnOL2aUZGhI1e6HNbgoaeaAwMWAW8Z2v54MaVUmNihct9hDaSgyT8KZjjECqVDqB5AzmztCxl5p3xfGzs0yp2nNFBAOIx2tFx5BWbDg1Kf85jmGrqCa9C0CmldkrAtLFXZXqH73rhC+emlZgfyS5Au4cFdbVB2JZU5Er4T29Stwn3ciHvJPPFI0/A/rBBaf1jla4lzk3bmh9bUcTNNA5eh2ehMspWw7OpAT3AejJC3AoAGJewf8510SKwcf+0NlZLHxMZF2ZUjAcmbRikZazAmwvDW8pdoj3bUKdpzNtikBjWaqCNzwIhlmLLZozaw1XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58AoLZS7Z9+3HlVF/FeA89oVz+zeoEVgwnmULM4jUlk=;
 b=xMueWzbGC+fkR+F9QIFBJeO2xXSDdpkyF3MWQr5QEp5T4rGpoDsSqXiHMZX7eNbgkruRnc5kTXddeqnkZipYzUTX7iyeZQNgnfAzFpMJlgJ1kmL3w60u4HLFMQ1ivMSZFD66eyOf1F/QELKpidscytqul4O+zcZ+N6qHDGQ/y1H3wFdsnEnBh7dBIgTGv+qVyJl1D0fZstcdwYZTY7NJdT2Zi5zpW7LmF98aDfaWg6MOf3W5knfcNk0HhDT4+n2hlAjorGteNiWDg/yf0FxMa5i3XzthEo5m52pNue6nb4S0bUF1AdG0R927HJ8bzC4yqaDKBsOaUN48u5E02k+C7Q==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB8291.eurprd08.prod.outlook.com
 (2603:10a6:10:3dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:01:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:01:36 +0000
Message-ID: <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
Date: Tue, 16 Jun 2026 17:01:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <ajFLvKcT-A0wvLYW@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ajFLvKcT-A0wvLYW@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: e957ed6f-3023-43fa-8b66-08decbafc793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tZW8+lqlLe0UciGD0leosPv2DlBibrHY7RRthOumik6semdskdAIYrIwpnHagx++K4xkXdqJ9YJ+nkv/zLPc16GakpRGvoAAHEwYT+wuqWZDrMPzguPK9LAYScBW18BnwvYFEgdvsnTlQUUPEtgkTQZTh107lzDeAheadamFLZ7lsttn2bP9Tpx1GrdppdGedTPHfxEZ5h/KlNxvM97CbBe9Kol/uno89mNa6V291p2PEy/yUxLCLRLgdtVdzSINS4Db2LihW+b+iGM79AC4x2ACCXaTBZJqorsjIkLsTRG418P+A0q9MUU5UuBs1D5N88IOYlKSvZb6JOtyaOa10fwkXbOjzLEq3Kshvww4Co4GzpPuoPnVWEiBv1i93zyEwJ6gpEC19GpBirJ71H9wDGn3W6aTZhAniT6FWZHV1LTbvzTlaf4Ag/FIXWjJC3hkLGJxDzj4e2MbovWWOc7zvkYBqOMg6xLkweUUJsehevRoSrTqQwmzM5gyIKr7xOVYUVfF9z4SeRLAydFxOgFnSdbHn4RMzROmF2Ub5lXoUChiICtIHZAIDb13JmSCIq1tcSlQL48xC2nL+EtopztPM+IDaCfSisc3cZHq5CWarL4bKxL4CxEmYNxQpZGtRJlVDFt/79YKVpuAJ5S2NyeygVDPH6kXzyolGWvqHXTYYfYv5YzzExrgncl91fuA1Xk4RrcCq25r6/NtykQrqIyNiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFJjQ1hRZHNLd3p0RnR6bytVc0tnaFQ0TTdzdytBcmlmcXBpU0RWaWk2Z0hM?=
 =?utf-8?B?QzFxTi9sMEE0dUdrZXl2UGd1MUpOSFpSczdpRzhsK0JnejM3U0huREhRdlRV?=
 =?utf-8?B?K0dUZ1NXdXJRbHVYc25IaFFQSG56OEVZS3c2UUJYbWREckRIRmt6YnhCMHpy?=
 =?utf-8?B?QWlrdThHemNXNUlRNDRjU2diNDV5dG1Od2RwSmowRWEyTkxQbTh0YkUweGJn?=
 =?utf-8?B?bzA1dkFNejZMaWMxNkJKRCt6THZIY05MM1NJTVZucjJBTE9Wb1JUYVZUNGRD?=
 =?utf-8?B?VGYvVEJ1azRzYTBwZnhmajlZU1A0TDA1aCt3MWpCaG5MOHBvV0xLT3JmMi9s?=
 =?utf-8?B?OFExSUo4cGNad1h1akd5dkc1OEYrQWdHbnlCek1Yb29TM1M1R2pVMjQ3OVdV?=
 =?utf-8?B?QnNUc05zM1g2alROQ1NQU3lXNUJyc3VkQ04yK2R1TmRFY2FGUTA2eHAxRVVD?=
 =?utf-8?B?TnU3Q3dEclR2VktXZ3Q0UlF2MlJYdVlWQVQ5Yk9ndE43MzJpUTRIUjg0aG1k?=
 =?utf-8?B?dGpQUXI2enkzeHhrNXRJSU9hWGQ2czhPbVpxTHBNQ0M2NDlhNjV5MUZrNUpx?=
 =?utf-8?B?NHlaaDU4T0RFaDJkM3hLL3NJWUh6ajU3a201dlY3ODdIaCsxM093SjF1eDky?=
 =?utf-8?B?VkdtWXM1ZXpkd1hZUXI0aXRaNmNXNWY0a2RoVVdaZ1VXeXNNL0pLMFlRakRr?=
 =?utf-8?B?U1hjNFdPaWtpeEZRbjlkM2p0RG5iaTJ2UU9hait5K1pGTlRGQS9qY1R4NFdL?=
 =?utf-8?B?blBNOXIvT29FYkh0VHRkeU5ZZ1pVK3ljZ2YzV2JyR29mR3lZbWEvQnVjcGxu?=
 =?utf-8?B?MnkvaUhaa3JFUmRpUHAvNHZDbC9Objg1dm1qOE1CWHExWFZVemw4cmtYZUJt?=
 =?utf-8?B?c0w4WnB1Mm14c3RLak9oRGRTcUtVVWVUU29BWGNlemtvMEhmLzIwTHUzUmRO?=
 =?utf-8?B?dWEvb25CNXFBenpnbWY0RERISVJhNmhpaU1aKzJVMzd0MHNMRGxnSzZFdGli?=
 =?utf-8?B?QjlFcXEyMC9mR1Q5UmtpQkMweWwwUllhMGdpcDlrdHBidGNNTjZGamV4VXQz?=
 =?utf-8?B?cldFemljT0FWckU3TTZ6dW1UU1ZuaXJiYjlZUGtYZm1FbmVsdDlKQ3JsQVV3?=
 =?utf-8?B?L0NFbDlJd3VnejB6SERGUzVESnRUVzlFSHVUZWZGN3p4TGY5ZUk4bjBYMkFP?=
 =?utf-8?B?RjloajJEQ0RKblFOOFRHbTlNSCtialN0c08vbHkyd0p1Zktqb3NvM0NpRkRj?=
 =?utf-8?B?YW03QnNzSG5jQ1dqc2kwL3l4OEkvSHQrNzFwZTZDRWdnN2xEcjlVa2ZEMURZ?=
 =?utf-8?B?QVJieGhNT1RHOE55amNUTkp1M1B4aTN3V2ozY2N5VnVDT2FwQWVLd09JRmhp?=
 =?utf-8?B?M0V0a3pDb29ORDFyOWtxVTNmL2lxaTZwaVNpLyt1eGhMcWp0MDZkTEZQWjJw?=
 =?utf-8?B?VklrNzFxd1ZjYVhNWW9zQ0RjWmQrRmI2eU93cHQybTBTSU8yVHY0djhNb3ph?=
 =?utf-8?B?UEpYektUTHpKT1RCVXZDVWp1WGRvNFBzQnIyb2Joajc2TVY2b0hRYm5od0lF?=
 =?utf-8?B?UDE2NG42enFoMmc2cjBvV3ZNOHloOHNxVVhDRS8va2dnNUMzc2l5T09scnMv?=
 =?utf-8?B?VHJrOHBwaUJYOVErMUR2Njd2L3RCQ1J0THByWmorZFlaVStsN3FKR0Z5enpI?=
 =?utf-8?B?YUJGUW9WWW5ma1Z4bGtpeWtoLy82Wkk5K3ZZTTJNNnBKZkR6dTVMdWJGSW82?=
 =?utf-8?B?L0ZCNXIyUlcxLzMyOHhjZzlYZnNVQ3RKVzVBNWlwVVJRMm9LRDFxSlJ5dlVv?=
 =?utf-8?B?N1EzaUp5K2ZBL2RHM0oyQlhIcm1FY1dHWjVpelpteS9JejVSTkZ6YjVseXd6?=
 =?utf-8?B?cTJES3VJK0lWekVFZzVlRjlFTnVRbXlXbkFtSE9EaTduS0pjd0UxUG81ZktD?=
 =?utf-8?B?NTBmQVBLUnE1Q2ZyYUNUdVM3VW9EWmpGWnpSb1E3em04TXNhVFVqeFRtNWJ6?=
 =?utf-8?B?MlZOdElaQ0hRS2ZoNnJsY3VSU1E4YUxiV3NGdEt6VnJmc0F1bG5KZHMrRkxl?=
 =?utf-8?B?V3FyRituSDg2eWtGUnJQWG9WeWlEUzRoZUJ6OW90NnJ4S0NYNU5kbExwWWZR?=
 =?utf-8?B?NkQxMzdMakV1dzQzNlIxaWVlWU9TM0ZneExBR1lFMEVLOXpVNk1QWkxQWWp3?=
 =?utf-8?B?aWMrcG9sMzJpZjhNQUdkWHpGa3diRnFRTFlSMnlXVE9nMThVbTFLZmx3dlZH?=
 =?utf-8?B?RVJFdWJuUC9CQUZFTWk1czVJRy9wNHlwMTdaK1AyZ0FGTTRSVDcwaTJEZC9y?=
 =?utf-8?B?YWdnUWRWZWhXU3dER3JNakJ6MzVudXlVNXVkamErK3lneCtRSjJCZEtsbGh5?=
 =?utf-8?Q?7bjwz5TxO2zAxHrs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e957ed6f-3023-43fa-8b66-08decbafc793
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:01:36.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3/6FgUJjQDxbg1Xao/NvSoWzzeKo4Db+lq6XlRdpIKDFDegjzyFAF6fJdQQzNOY0mnKwgLp+/GGBHF265XOElsbbaJNHszK7avxZjpONVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8291
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299861-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:mid,virtuozzo.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 423CA6902FE

Hello Stefano,

On 6/16/26 4:35 PM, Stefano Garzarella wrote:
> Hi Andrey,
> thanks for the series!
> 
> On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>> Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>> outlive VM migration, since VM is moving to another host.  However
>> there's a special case, which is QEMU live-update, or CPR
>> (checkpoint-restore) migration.  In this case, VM remains on the same
>> host, and we'd like such connections to persist.
> 
> In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually 
> sent by the device after a migration.
> 
> IIUC the specs don't say this has to be done all the time, so we don't 
> need to change anything in the specs, right?
> 
> We just need to avoid sending it (which I think is what we're doing 
> here... I still need to look at the patches).
>

Sending this exact ioctl is guarded by one of my patches in the QEMU
counterpart series:

https://lore.kernel.org/qemu-devel/20260612165110.431376-6-andrey.drobyshev@virtuozzo.com/

So we indeed avoid sending it on migration target in case of CPR migration.

>>
>> For this to work, we need to be able to transfer device ownership from
>> source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>> issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>> calling VHOST_SET_OWNER.
>>
>> Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>> such implementation (patches 1-2).  Also fix regression introduced by
>> the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).
> 
> If it's a regression, should we fix it separately?
> 
> Or is it related to this series?
>

Probably my wording wasn't quite correct.  I posted this patch here
because we found the problem during testing this particular
functionality, i.e. vsock data transfer + CPR migration.  And the
problem was introduced by a recent commit, which is fine on its own, but
breaks the CPR case.
>>
>> There's a complementary series for QEMU [0] adding support of vhost-vsock
>> devices during CPR migration.
>>
>> NOTE: this series needs to be applied on top of Michael's vhost/linux-next
>> tree as it contains relevant commit [1], not yet present in master branch.
>>
>> I've tested this (patched QEMU + patched kernel) approximately as follows:
>>
>>  * Run listener in the guest:
>>  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
>>
>>  * Run data transfer from host to guest:
>>  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
>>
>>  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>>  * Check that file hash sum matches
>>
>> [0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b
>>
>> Andrey Drobyshev (1):
>>  vhost/vsock: re-scan TX virtqueue on device start
>>
>> Denis V. Lunev (1):
>>  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>>
>> Pavel Tikhomirov (2):
>>  vhost/vsock: split out vhost_vsock_drop_backends helper
>>  vhost/vsock: add VHOST_RESET_OWNER ioctl
>>
>> drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
>> 1 file changed, 69 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.47.1
>>
> 


