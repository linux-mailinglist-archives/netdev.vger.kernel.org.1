Return-Path: <netdev+bounces-200581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA4AE628D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597E840520C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E0218ABA;
	Tue, 24 Jun 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="sgBIjiMo"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6F8634F;
	Tue, 24 Jun 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761348; cv=fail; b=kjQNUr6LYE9xZ+YL1GnSMKadPQ64IkJbpxv786s+ws78o3AMdu3JBIHJNbKLfuhR5INByJmPiEn+XflAZJHiG2YkxMrtsST2WwSo3cASYzRevGrb+eRBa1j2ZW+T/GbyXfvp4VYLIQfaDye9/HSdtwpIrOjiX8ltzvo5Dqy3R90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761348; c=relaxed/simple;
	bh=mJxpZ5nSKsGZ39/lF/objK8VlpkpFhmlNwvB7ErMy7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvKNvav+aoo6nx+jARmnrXv7QBKvNlu+xGb8JU/iri9xgCNY/rh5EdORY66MLgCtaWnld5uWTDpB4v7sgzT3yPePW0b0bgskSygIGcZ6PId1AvYWOMeoFX3xMIkgUbVNH5+7lQk944Xblz5xN/uKSdyB9zaEqcqaWfdOXtirjBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=sgBIjiMo; arc=fail smtp.client-ip=52.101.126.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW8yZFwjZWv7jWTvpltNgkD1jNCzdPsS74HA4qDfxlhV0FlDVtPsRBcx1rfxKtu95r0uiQ2A6pQTybCChK0kx/xSriR6C2GMnj/e7n0BnBbd+C//L0NS15mFo3xztsGrBVM3+tZMtRdu3WckQHDa59+6YyAiHOSoXMLXf+19u06VT0zqG5nsSUmNHZKrST3lPiHNSpQpA87vXLP+UkL/fK84ad41/Sw77pjQBKVfjB/XIJlVmPDxZAPwUI+lcbZdphYoFsAb4o0JF0wnGuSrhniP4/CFhDFZ44CYzo1Dta9kKEmeTsPDAqpxTQvHGz7fz35qUehTaq/GgqRyEIWO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBeLJ/X+IKgkaMboqWFFReTqPpJqCu3L48O1As8f9fI=;
 b=Nt2coVckdqAg6xUyikXtU72xUClIS4AzS1jvIGYQ1vgy3TFMAXyQDxl+IKfgk6JlYx9yFKHAaDMGOH1l/ZLsisfHdHvt5qkenBQfYiWoJ/K9Qm9vL0t1cf6JQi7CBkALCBgNfJGwPts8kIbSip9EgCg4Q9AoDC3Geim3lGDiZcagqlFiki7Eubw8hmqZtgp9gonAd3X3zMIohZwbs39ORsG3L4oF4KKty9bg1ERS1bQ8XetYSJretLj4nU+U4yLuv7ilOJSJ7q9IR/Md/dQ2HQfaQBliRt27/OH45i9KhDlYwZZHi0VLl8ChCDxM8H2Fv2HvTp92pCH29gXjB1f33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBeLJ/X+IKgkaMboqWFFReTqPpJqCu3L48O1As8f9fI=;
 b=sgBIjiMo+64i4a96xNoxJu5ThCqwgwzzK6TgC5zdkf8AJ7dVldyT4q9EweGSMsfs7+IN3VWfPtmZ1wgEo8xtRVKri28Agtl4LGeYzGp0X401WUEAK0HRK18ser4SjddsV/clJyIyqodPemJZOz7MlZljhJXKQxGe8ux9UrVXkFybISDKaosjooEP7XNYNC3O+pELlH/h7M4m+Vs8ma9AaMJ0iF53O9+eEVM4MHKY33oUfGqx2bMlNgoeMxiDESXQTyTRm22iU06Kb3B26EYDJ0O4EpAh5f/hrZ0XJQZYhs+L38H++1vHm5wTI/9AG7y6e6C+cnEgQrUi6Oja/YArZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB8098.apcprd03.prod.outlook.com (2603:1096:990:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:35:41 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Tue, 24 Jun 2025
 10:35:41 +0000
Message-ID: <47543ce8-10a5-4b40-84d4-bfa8e5fa50e0@amlogic.com>
Date: Tue, 24 Jun 2025 18:35:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
 <4db45281-9943-4ed7-80c6-04b39c3e9a5e@molgen.mpg.de>
 <d3ca7e7e-720a-42ef-b32e-19cd84d208a7@amlogic.com>
 <c92dd95b-3986-4b0c-807e-62c203a656df@molgen.mpg.de>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <c92dd95b-3986-4b0c-807e-62c203a656df@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f26186e-f12f-4bef-95fa-08ddb30adde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTJ4OEc5MU02Y0JKTDY1bTgrWU5SdkgyOG5kZ2xHWUFWMk5hQlIzWVRTU0tF?=
 =?utf-8?B?ZDBWcXkxcEIwWjRvVnphR2RjbGNHdVJIV3hxK0h4WVRoR2RMWFcyYU8weEF6?=
 =?utf-8?B?KzF6RlpDdHpDeE82YXE3MWQvYXRPOVJLS0ZLRytJZFgrMkdiZm95MXZqbFMr?=
 =?utf-8?B?dzRaYW9BR2FxVVZpajYyM29yVmJ5cWR4N0hNcHRmakZueEY5c0tVbnFvRkZF?=
 =?utf-8?B?Unl6aVBqN3JWeG01a2tQNG01eno4ekwxTzZSVWZUMFRJUnV5ajM5RmVXS1gz?=
 =?utf-8?B?emo5TkFvUzBCUjZYcnZjSURQRC9HRVFNNHJ5ZWhlRTVtRGZDZ3QvU25pUVpO?=
 =?utf-8?B?amNCajhqS3dtL01WUUtVbVJXREppdUNycjhWeEdmbnZKRDlFOTUrZW14d0to?=
 =?utf-8?B?a1VkVDJodTRlSEFYTTBXZDBlaFdkRDVxeWFneThnYi9kdjlqZ3UxdmZaSkZZ?=
 =?utf-8?B?ZGx3SnNTK2FsdzltNjhDbFN5STc4dDU5eDE2NUZFbVpRdkZtYVcrb3dmVEZZ?=
 =?utf-8?B?eS9FRkZWdEEwalFRU2V2MU9QNzM3SmtXZHkvYnNVVDcwRmRLcmQyeUpBSWtW?=
 =?utf-8?B?RGhFVC91WXI5aXMyWFBGdDlOYkF5dDZHTU01QWlNeTlhcDlIVmxyTUE5TkUz?=
 =?utf-8?B?Q3ltMGFtWXJNc0xzS0ttRi8vYS85NjlPYjluNk9RN29CUWZiS2wvSTZaYUZP?=
 =?utf-8?B?VFVnb25MV2RVcWVnQzZLYUJMV1BZQTc0WmV2NE01ZTBLdTg2UHpGNVZRMlpF?=
 =?utf-8?B?UmZ0alZ0d2xHY2dUV0Y0T0hCQ0hxV1ByYVpMczZSbmNoZmlrbHZjSk1NNXhB?=
 =?utf-8?B?RnhCRDlsR09SS2o4eEp0Vjk3eVZvQVpSeFRvTS9WZUViMm9uM0t2NzcvcTdZ?=
 =?utf-8?B?bnpjS1JCTnQ5aUswS1lEZXdXRTJYell3anVhN0grRUFFcEFYQ2hwY3J4Vkt1?=
 =?utf-8?B?alpCQjVkNXdIeDdDQmRPS3JVNTBJa0xJVjhBU0pzeUM5bER1a0RtZ0JacGJi?=
 =?utf-8?B?U1U5cWN4bjU3OUdPc2d0RGVrRHVPM2JKdVpqYjNIWnpyckFseE1GeS9pV2Y2?=
 =?utf-8?B?V2lLSENTR29QRm9LeUZnbXhnc0txdnFFNmhUbldHNWo1VTlrKzVJbTIrbjZu?=
 =?utf-8?B?ODd0alBlZE45RlJNNjZZY3hkWDErZHJ5NHZBc0wrdXVRWEh0dmFnRitsc2hk?=
 =?utf-8?B?RkpYenh3TXByTU95cVphdFFMTy9SS0hUK2hHY3czVzlaekJGY1pyNGlmdG5t?=
 =?utf-8?B?TU1TRWJwSllhc0R6bkdZTThxbjliQ2pYbFhUN29UbkQyR1hMWTBWT0thcEp4?=
 =?utf-8?B?Vjd5K3ZaSHBmOVZRYWVhNHlqTUxON2FsYTh5OGZJWkkvaGJadk51c3NHY0VB?=
 =?utf-8?B?UWlEMnBFd2FIaXpVT3pEeDgrTjZYVUhDbU5GUWdKYU5VOUt6THF6b2wzaFFG?=
 =?utf-8?B?SUkydGlMRzZlOFFQSERPZjNhbGs5R25Fa3JtclBJRUViSm45cDhWb1ZlZUt4?=
 =?utf-8?B?Zkl3b0lmcTdRSXBqdlZFVkJkTEV5MmRCMGZHZmZYbzYwS09PZDVkdlZ6VFJU?=
 =?utf-8?B?WGVvNXlqa01KakhrNXl0VG9xNXZ6U2lXSXBUN3NuWHBHQldsclBFN0E0V05S?=
 =?utf-8?B?Uk5CN0FENkh6aUp6Ym9mM2M1UHFzUi84bWtpUUZsZXRVQ0wyai8rVmNDY29r?=
 =?utf-8?B?ZHFwcXRvbVZqVlllbmo2N1lEd1JabzlKc29yNC95Z2JRcGpKbE1CbTM2Zkxq?=
 =?utf-8?B?d3BKL0V4elE1aW9YaHc4UVd1RGl4RVRMQkxaM2wwNjRFd0JWM3ZYQlZyZk4y?=
 =?utf-8?Q?AfivOL/Oi+bdNRpljidWPh0Qw0swDfrkuSoFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVk2WXliSCtNVUdQNFp4WVNTL3VJUStOdm9NcE9YYW9VQUZoVkQ2WlIxSnlV?=
 =?utf-8?B?T3pHd2hMV0VZSm1aQ1JDYnJYT0xRa0gwNUR5bGU0QXNwOUdlaGkyclI2TFpM?=
 =?utf-8?B?WUIraHVXZ3czdjErQVZiUFVFY3A5T3cyWVRYczRpWlpEYWVlcWZBcWIzQXlx?=
 =?utf-8?B?bHlYS2hsWlFPNzRESXlvcko4cW5DQ2xvRGprSzJKQllpNGx6ZDhVaTdDQnQ2?=
 =?utf-8?B?cWYwcytwUUdPRXpxdW51WGVHYVJLUEdLMDdNOHQrRm04UVUydDI0TTRsTGxO?=
 =?utf-8?B?YUhScU9CMGlGOHhhOEd5UXI5bng3Q1JYRFh6cHc4RHFLWGlPRmpoRkZxRVp5?=
 =?utf-8?B?dUVMWDRnZTA5QzlybVIvM1liOGlPMEx1MnQxNUxMZU5uYTdHcU4waFpLbzRO?=
 =?utf-8?B?blE3ZHNMekgrQkU5M2diRjcvVUN3VFlqVVZXL1pBZmFLWHJZQVhvcEptcm9S?=
 =?utf-8?B?UnlhOVFub1E4OG4rdThGbllnL3V2S2RPVGRqcW4zcEhRTWlxY0lhSER1UUwv?=
 =?utf-8?B?T2NsYzNKMTZPWmNPelM5RSt2MVJmL1VXckV2VFFFMFcwS1h0Rk0yaE9uK1V5?=
 =?utf-8?B?aEErdjAvcDFueWxXVTBrWmtUUTcrVVFGc1VVeS9GZFhzYVlSRGFPWUlHVnov?=
 =?utf-8?B?UlorS2dOTnFJdmJmb1hzaVdPZHFRc3dhMmdkanZUUGZyOGwxeS9JYjRXU3Rq?=
 =?utf-8?B?SGhQMThjSG5kZ1pXRlNpdjQxbzIzRjBoRldUczdlUHVsU2xxdzB4QWpkR2JQ?=
 =?utf-8?B?SGNEZVdVNTZTOEJnRkJrTDVicDZCbG95VlphMWJZQzNFNDQ5dUpBOU9JWkhD?=
 =?utf-8?B?eEl3eDhxZDI5STBDeUorNTVtUGphZjdPb2hkOVd2dytzZ3hkb1JMWkVMSWJS?=
 =?utf-8?B?bENId1RwYWl0c3RhSTU1eVVxcE94aVhtTS9SSjR4WE1qbCtRM05IcFlacVdI?=
 =?utf-8?B?aWdMa1FURmdXbkt5YUpoNmVuK2tFdUdmTk1pejZ2YVpBWEc0Rjg2R2lrMHVs?=
 =?utf-8?B?UHZCbU1TcEo5aDB3by9LWG4xdXdZbCtzeFVVdm1lTHk4U2s1dW5DMjQxZTMr?=
 =?utf-8?B?TnhOOXdPa2xsUXo0U01jQ2kvOFgyNmRsMTEzeG4rbE10WCtvNXdDWjVpZjV3?=
 =?utf-8?B?eTNGU1JaYVFYeHQ1RWpMaGV0NjhSTUpwUVFCN0tFQWJhbk9JTkNrUS9FUU00?=
 =?utf-8?B?QkJZR1l0UDh1bzJGbXNrdURnL2NabEJBQWpKdmliNzU3aSt0RGd2QzNSdGU5?=
 =?utf-8?B?NVFISVlveWMwbE9iaTdhZnQyQjR2aXFyUVhIMGdqcklJdnl2cXZWNWt2SjNu?=
 =?utf-8?B?QjNWR3QzNE9DSlRZcHAzbnVwYllOS2NBZnNpcEd4MlgzK0VnQ2FHdWxjMlVu?=
 =?utf-8?B?cjFCTm9HK0xRanRIV3lLQVUxbmJ4b0p3NEg5YWxobnpBOTRxZE9qbUJDbUR1?=
 =?utf-8?B?RE1JT0VPTU1FMXYxOWpuUSthZ0ROMDI5amEwNVZBa3Z6SEpMeDNLaDg4ckpq?=
 =?utf-8?B?M1grK3AxaEx6TmJVMjFKN2c0TWRuZU5tK1R5MVY1R3gzTGVWVHFDc0Fnb0ZM?=
 =?utf-8?B?SEd0Vm5RM29vYzB0cndnZ2JHa3JhdDhleVJvSzNyNDBQQ1NyWm9acnZza1pk?=
 =?utf-8?B?dGxGbmxTMkJkVVB0SWpmek5tTjJtcHlGcVBocFJ3MGRaMGN3YlVDRVA2eEZr?=
 =?utf-8?B?MU13YjZiSXJQVlJRSk52SVdqdWt5MVdqVHl4MVdNNnRHZXl0NDZROG5iZHor?=
 =?utf-8?B?NmkzZmlhRkxyNVlqalBYMzlyd0c3SVBPT01wOGlIekd2SWNuWlR5K1V1MVQx?=
 =?utf-8?B?cUUwZnZJQ2xaZTI2UG94ZzY3T01lL2JvT0dBcGIyL3pMSjBKU2swSDdVMHB5?=
 =?utf-8?B?bE5IblBZRzhhQ0hoTmRobzRqTThVMkhlb1FXWXp6bUovOEwvTzNpOVdxdlhu?=
 =?utf-8?B?T253TFJEK3NPRVEzbG9lNUZUNFY2L3Q3a0YrRURsWFFKS0FTNmZxZ3NGS2xM?=
 =?utf-8?B?MktwYWtaRVpMOGRsSFhsdDdWTDZIN0xSRG5XYUdtRlNndlluQlorU2wrd21o?=
 =?utf-8?B?am01cFhXWTR6ZURJSkw2d3BEejR1K08wWEgyVzdIWWRJRUtCMVZIVDNqOFJm?=
 =?utf-8?Q?VD9Uojn0KdGLo1qLtY5Prpiaf?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f26186e-f12f-4bef-95fa-08ddb30adde6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:35:41.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew+4pegtJnoBx1pH8n/5a/yIP5ff0EQqj/Eu8bL5y0nhq7ly5ewwwRqQwXjiQoVQzm8tye6NwJhbMNOv6QrX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8098

Hi Paul,


> [ EXTERNAL EMAIL ]
>
> Dear Li,
>
>
> Thank you for your immediate reply.
>
> Am 24.06.25 um 08:26 schrieb Yang Li:
>
>>> Am 24.06.25 um 07:20 schrieb Yang Li via B4 Relay:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>>>> event (subevent 0x1E). Currently, this event is not handled, causing
>>>> the BIS stream to remain active in BlueZ and preventing recovery.
>>>
>>> How can this situation be emulated to test your patch?
>>
>> My test environment is as follows:
>>
>> I connect a Pixel phone to the DUT and use the phone as a BIS source for
>> audio sharing. The DUT synchronizes with the audio stream from the 
>> phone.
>> After I pause the music on the phone, the DUT's controller reports a BIG
>> Sync Lost event.
>
> Excuse my ignorance, but it might be good to have documented. How do you
> connect the Pixel phone to the DUT? Pairing is not needed for BIS
> (Broadcast Isochronous Stream), and using wireless technology no
> connection is needed?


Yes, you're correct that pairing and connection are not required for BIS 
(Broadcast Isochronous Stream). However, the DUT is typically a 
resource-constrained device with limited input/output capabilities. As a 
result, we rely on the phone to act as an assistant in configuring the 
BIS source information via BASS (Broadcast Audio Scan Service).

The basic flow is as follows:

  - Establish a Bluetooth LE connection between the phone and the DUT.

  - Start audio playback on the phone and enable audio sharing from the 
device details page. At this point, the phone becomes the BIS source and 
configures the DUT (BIS sink) using the BASS Control Point (Refs. 
https://bluetooth.fluidtopics.net/r/lgpAAcjFeoVMObE~cpMDZw/nkLg6cYqSphBI_2mYkaxDw). 


  - When music playback is paused on the phone, the BIS source will stop 
broadcasting.

  - If the DUT fails to maintain synchronization, it will report a BIG 
Sync Lost event, as it can no longer receive the broadcast stream.


>
> What app do you use on the Android phone?


Pixel 9 and upgrade to Android 16.

>
>> I believe this scenario can also be reproduced using the isotest tool.
>> For example:
>>   - Use Board A as the BIS source.
>>   - Use Board B to execute scan on.
>>   - Once Board B synchronizes with Board A, exit isotest on Board A.
>>   - Board B should then receive the BIG Sync Lost event as well.
>
> Thank you for sharing this idea.
>
>> Additionally, the following BlueZ patch is required for proper handling
>> of this event:
>> https://lore.kernel.org/all/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com/ 
>>
>
> Yes, I saw it. Thank you.
>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>>   include/net/bluetooth/hci.h |  6 ++++++
>>>>   net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>>>>   2 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>> index 82cbd54443ac..48389a64accb 100644
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>>>       __le16  bis[];
>>>>   } __packed;
>>>>
>>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>>>> +struct hci_evt_le_big_sync_lost {
>>>> +     __u8    handle;
>>>> +     __u8    reason;
>>>> +} __packed;
>>>> +
>>>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT      0x22
>>>>   struct hci_evt_le_big_info_adv_report {
>>>>       __le16  sync_handle;
>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>> index 66052d6aaa1d..730deaf1851f 100644
>>>> --- a/net/bluetooth/hci_event.c
>>>> +++ b/net/bluetooth/hci_event.c
>>>> @@ -7026,6 +7026,24 @@ static void
>>>> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>>>       hci_dev_unlock(hdev);
>>>>   }
>>>>
>>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void 
>>>> *data,
>>>> +                                         struct sk_buff *skb)
>>>> +{
>>>> +     struct hci_evt_le_big_sync_lost *ev = data;
>>>> +     struct hci_conn *conn;
>>>> +
>>>> +     bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", 
>>>> ev->handle);
>>>> +
>>>> +     hci_dev_lock(hdev);
>>>> +
>>>> +     list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>>>> +             if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
>>>> +                     hci_disconn_cfm(conn, 
>>>> HCI_ERROR_REMOTE_USER_TERM);
>>>> +     }
>>>> +
>>>> +     hci_dev_unlock(hdev);
>>>> +}
>>>> +
>>>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev,
>>>> void *data,
>>>>                                          struct sk_buff *skb)
>>>>   {
>>>> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>>>>                    hci_le_big_sync_established_evt,
>>>>                    sizeof(struct hci_evt_le_big_sync_estabilished),
>>>>                    HCI_MAX_EVENT_SIZE),
>>>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>>>> +                  hci_le_big_sync_lost_evt,
>>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>>>> +                  HCI_MAX_EVENT_SIZE),
>>>>       /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>>>       HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>>>                    hci_le_big_info_adv_report_evt,
>
> Kind regards,
>
> Paul

