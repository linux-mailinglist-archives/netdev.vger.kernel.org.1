Return-Path: <netdev+bounces-204495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F602AFAE70
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70094A036A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035925A65B;
	Mon,  7 Jul 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WmKB25tV"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022103.outbound.protection.outlook.com [40.107.75.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1902D78A;
	Mon,  7 Jul 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876346; cv=fail; b=G8IqFQokDqeFsnLzQJtl+sQK46ffl/B6/cwU5Y2YTRJtj/GX11F0YjyCfQufw2lwiXms+1jGNTb9ue2bxxT6suSTg4k+k02xXlMRInTnTuchadOVkEpVfxR4aO1MGmuKzreOweGSWJyTA2KP6gl0clAZt+WUV20IpUoo4enql8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876346; c=relaxed/simple;
	bh=k5/CdLUqhTZLflnQsPtujfr34iWPvyJZGHSh3hxL9M4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GaHZaxGRVft4a6z9z+PlNuKdp+YmQmrvr3lUGl4ppXINDi9RebA8UohBKXQKXGAfRm4oMMa7mp2dia7xgskUFFzSxDV2wU43ImgRDbGPFg/lQahpjucf4tJr7JRcrs7EUgTMB82zgaVZi1q5dg+mYe/5I1WYmhf+ijiRANfBS7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WmKB25tV; arc=fail smtp.client-ip=40.107.75.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFnooSdjB1AXPINz0PPGFMLtac6qt/39zyCy0OuW4k6u5/joPpqrlAT4dGS9eomedHmn4PBL4DN/WmJB8lttmtZVDpWBZSJcAm2P7tYwUOQaS01StqZpwWtGdnR1E1kskqpKwc4Yq+HElTufTgBNUgDvZu2m8dE0Plo/dnxO1qFwT+zrnvktMkt0O2LK2O8Bxlae8ECj71cTMrgp+DuffrhoRd2QzE35kn7iVeBbNACjvdLx1a/4PHehkmO4CoT4HT2mGxWpn0R+OJnqivXhL8yDR1iHt47qTXtx6mGu+a3K82HSsOFLrnjg+4SmFC1Y65gzAI2iDePFxdLGAhmD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdc0ryBJ2OI/MDZHgN2XQmHtZZ0LhrZieJn71LatxaM=;
 b=b9owROVLXpk0BAqtI3WJAcv4UPSiYJDGc0U4Zh6rl841lXBgIO1S/cVjJjKGF/pyt1XiEjORO6qxhswvVnHpkhtakmaDjoEjcrSqFIu8vshLPtXKQcbvFJbZbSJ2YxkA3JWAHEROEB37hUIAAc1mitiDndvhSaq0fMyN7eyyP38YN8or6bLXA1I1UIZnmeLWRMnZx+YL3VPElqIfu0+myNWkqKQC0TE/thqdjeLBq7IFUM8CLjGTw6+HlGApBYI38IKvmDM7TBR0Vexo4alBZ5vnMnq/1DNhVp9qQkLr8eyUuxul4K/yIqG47KHCoRErCGISNe/tklRF3Yn3AhM+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdc0ryBJ2OI/MDZHgN2XQmHtZZ0LhrZieJn71LatxaM=;
 b=WmKB25tVk0Acjn9mPatx8+I4b53hfhuN9noLkRIz1/ANaXwerZq9qj9u8fIsSEdZB0hC5WkBICpY5ZlgyLiCdwrk9Us7smPKVgRhSLW2QBNW7oH54yYDk4Pat8anMyNGCHjPeoY4IkPBStYL/dDndf2ptUH4mH413Kv1/BFR+tUm1/yRSt/I9L+e6CEvlC04ulSl80j6c2Omg7QxHN5cWKDDrUKcjr9PeOxaMPrdEWm0zqW8cPe6oPGDRwY4acmBmWk+h2lWyhTED+O2nk/QNAA4v7qNukJLBnRiY74K0JXR55AiOL28FvsiuhfRwIofMj0HFvI8ktWh25F821GlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SI2PR03MB6511.apcprd03.prod.outlook.com (2603:1096:4:1a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 08:18:58 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:18:57 +0000
Message-ID: <8f4f0d1d-aff1-42e3-9ab0-a5eb6ca1523c@amlogic.com>
Date: Mon, 7 Jul 2025 16:18:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
 <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
 <df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com>
 <3586e2f53a1a4c0772515846cf5ec91044e2cfec.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <3586e2f53a1a4c0772515846cf5ec91044e2cfec.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SI2PR03MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bee5d9-a28c-4b2e-73c6-08ddbd2eeb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVlQkg4bnVqZFlTUmNwajZtV2VkWG1jd3Z1dVRTOFNSQlE5MC9qdjdkOWFS?=
 =?utf-8?B?OW00QnZVbjJCOG1GOUZUb1MxeVh0aTI0MDBaNVlxdVVSSTFRNUdrQVFTUFl6?=
 =?utf-8?B?UytEY2hUM3pvZWVjQ1gyTjNwZHpvTUJtODFQWk45dklWemp2K0kwWDNmNVVE?=
 =?utf-8?B?MzlBNmt5dHNKVkl3ZUd1S2xScjFJc0VHOWhsRUNQdDk2TzhndUhUcnlQZXZv?=
 =?utf-8?B?aEN6NnowREo5NkFNWkFjR3VOdGxPZjQraDVRS3dkSTFIeDFYTEhVSXhWTEZj?=
 =?utf-8?B?WGdvUWxCK05Vc21lRTkxc2pVQzV0MVhVTFdka1RMU055a2ljRDdlZUwvd2F5?=
 =?utf-8?B?ZCtkdmgxSWRXRkV0b3ltL09SV2RHZnlDeGRyeGJHSUV2bGNXbm92M3ZkNmN3?=
 =?utf-8?B?a2djMmlXcTJUMGZuV0dhWWhFZFB3TFdKQklCbHJNbXh0RTc2RnNlc293R1oy?=
 =?utf-8?B?NVpUd2hHNnN5M0hGMUx2T1pRb1JCdDhvM1N0U25sNjUzU0VaVWllditLc0E4?=
 =?utf-8?B?TzQ1Mml2QWo0a2N2S3dvdDlHZWRxV3ZNTnVMNmh0U1FrRmgrWE1VcHk2bXNB?=
 =?utf-8?B?UmU2eERRdUFUblI3d2EzRGdid3FVV0E1ME5sY0tUb05LdEx6L0FMZGtzZlNG?=
 =?utf-8?B?VGpOSEprVVFwYUoyYUNWaXBzcFlCbXEzRTZNV25yWGQrS0JQUVYyM2dUNTEx?=
 =?utf-8?B?ZW1qSWNrUVBzMUJZckNlamtTL3dyTjFPbFpKbDZocWxicytKcUFpRDdPa01Q?=
 =?utf-8?B?eXpYWDRGMU9mSWJuVlhCUDc5M2xCNzJtQ0RFUVVpbGhUeU9leEZPbm03dTdy?=
 =?utf-8?B?UnZVRnpXUDhpSUFmY3RrZWIyYnE1SVZNbkp1cG9JZ0JhQXdJZWw5UXpMcEtP?=
 =?utf-8?B?VVBnakhQZEVjR0JIc25ncXR2cG9UeWRQbEVjR1NuVkMrZjg4RVg4VllMV0dQ?=
 =?utf-8?B?L0tGZWpTM2dwQTVCSTBCekJuV1dPS1pmNysxOE5zNWdaSmlqUmdzVHhPQStZ?=
 =?utf-8?B?dnhLU2FWWDNIY1JwOUlCTk9WazRXWmliT2F3dGJJQ2xpRHl2NFNVL2NYRWFv?=
 =?utf-8?B?R0xTRE9kaXh0c2hvQmpWUnBDTFBsRzFKRjdTRUcxUlNlcnlVbnpObWpNcnBZ?=
 =?utf-8?B?bGZETVUrUUZZNThZNUphVzc2cFdyM0lNOEUvOWMwOTNMd2RHT2xXakRvZ2Nt?=
 =?utf-8?B?dktPZmVUMG1JSGt4bDN4MVJqZ0s3L2J0N09PNk0wd1ZwVmc5dGxBcDFYQ3Vr?=
 =?utf-8?B?UkdWaDVxNTl5RFNYZ1Z5SDBuMUMvWFpLQks0RjRzSEVzOU4zOGxad2VnOE1u?=
 =?utf-8?B?YmJtNWxlc1dIL1NLNWpPK0Z5a1I5Q0YvQzR2ekZYcXBtbVJ1S0tYakFZWXFi?=
 =?utf-8?B?SzJvekdUaWo2Zmtkem5TZGpTMDlOTDBQbk9SUHFTYlVzZTE0djlNamQrR1Nr?=
 =?utf-8?B?aFczRVFwV2xNaWhyUE5HcUtZK1ZjVWdQUlFydWxyWWpiTkRjaks5T0ZTK3J1?=
 =?utf-8?B?K3I5WCtpVE1RTXR5R01xWHBzSVFRcDhDcGpHK01mLzFNbVlFSDQ4ZHJ3anEx?=
 =?utf-8?B?bVZRdW9wemt3VUJsVnI5VnF5bWVadFAzTXlqOUhmOFlCNllKUHlwNjBkaUl4?=
 =?utf-8?B?TjFUakpMWTFRVTdCMTBFeDdKcXdKZmU1aUVtbUhGcjZ3a3VScEJPb0lxVU5Z?=
 =?utf-8?B?TUFxaW13WFpDdHFaVUoxY1h0QWNCaDhJYVhoejJpS3FhaUJFUC9MZTl0eHYv?=
 =?utf-8?B?cDhMWHBEWmRDd2Nia1k1V2ZHVVhQWmc5VXR6Skl4V2NwVFg3dm5TeEsrc3lk?=
 =?utf-8?B?T2YwcDcxVVRWS1JtdXVlNGxjMlFXa2VkNWpKR0pDbGtrOExVaExTL0FUcTVz?=
 =?utf-8?B?MWpiYVFVUVNTZ2REQThJNHJsWEErZGN0Qll2bk04MGYvTWFlT1J2eHdGQzdx?=
 =?utf-8?Q?jhmRNch8Z+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2wyQXc4cktJNUhoUEllZWFXNWZtRmV2TFMyd0w5SUF6MytvV2lPRWNNTjZt?=
 =?utf-8?B?cDNqVFJiN3RtYjVodm1LUFk0ZzRHZ3pDUG1jcFpZdDVHcWROeG1MdncyNHI0?=
 =?utf-8?B?UmpNZk1tRVpZV1h2UTJRbVUrd1A5ektZckRhOVpyaklyNEV4QWhmQmFNZERn?=
 =?utf-8?B?T1VvdXM0ZnpwS3pHMWFVQktIMkJDN3phL1cvQlI4UzFKZnpFTnVQd2ZDWlcw?=
 =?utf-8?B?RnRMNmRlN0tDZVNYT0tzNzVxM3EwQmNJL0M4ZDh6ckJJQ2pWMGlsVEdCR2s0?=
 =?utf-8?B?OWZMRWNqbkdDbjJEZTZIbmhDT09nS3Z4S3R2SVVWT2hydE5PV3QrMFR3cDVM?=
 =?utf-8?B?dzA5TEpNeHFkV21sLzlPQmQrUVZDeFduSlBoa0NsYlJWNWJ3VWY3MUdMWGtp?=
 =?utf-8?B?bTM0MVVYcWZUNE8wRC84THhRRXdFL2gzY0xIZHVybUs1T0prenNDSEVlbm1G?=
 =?utf-8?B?OE9lcFRRN2E1ZlM4L1kxSmk4L1BSKzRVU2F1UEdVZ1FrL0hJcWVrbjhlR3ht?=
 =?utf-8?B?WWF2Nk1weGdJa1dHRWZFdEx6UWJOR3IycXl6SmxjMFBjcU1lWng5NTNQb2tO?=
 =?utf-8?B?ekxJeWVPNU5pdCtyRHo1OTNQV1lXUFF0QXhIMWQrQlBtZkYvUktDQlh6TzM5?=
 =?utf-8?B?UTJCOXhPaGJDVXgvQ1RjVDFLUlgxRTNSVUVkeVVLSUZvVGFJb0J4eXJOUWV1?=
 =?utf-8?B?QWVoYXV2V2V5WDBqK0pxM1AxRWhNcXd6U05ZeGV0TEJYS0FGNjFEc0xOTzdn?=
 =?utf-8?B?MEJVa1JzakRpZmJDaktYbmNpN0FZSmxKMFNlUTdnS1Z1cnppUzI1M3h1d0JU?=
 =?utf-8?B?N01NT0RVV0lyNVp3U2R4MUFmblZXQVgvQ2M3ODVHa0F2U0tuVDN6aHI0M0Ni?=
 =?utf-8?B?dTl5SHczdmQ3amFYSEIxTlVQdTFsUDdOQSt6cytOUUkwV3FJdWVGamVQcGo3?=
 =?utf-8?B?ck5lS1VkYjBGOHdCZDBMOHlRTldvQ3JvNDg0aHFSbXQ5V0JnY0Y1dlVLQTQr?=
 =?utf-8?B?UEtudUZQRXFmeU5uZVdqMThZYzYzanorWE9uOW0xY3Nudy9xTTBTVDFRNzdY?=
 =?utf-8?B?NDkwVk5LRU80NmhBU21LM21YbjgxUmRhSCsxQ0ZtSFVCZ2xzQUtpRWV5UVd3?=
 =?utf-8?B?RmM0SVRhU2lyN0ZURGFZcnN4MFFBeGZ4OWJ2Y05WNERLbVdaMmJOQnRCeWt0?=
 =?utf-8?B?dVBUTVpvTmZvRjFGSmtQZmNxQVpLU2FoeTIyZG9tT0FjNlY2eXFsK3RmUE1Z?=
 =?utf-8?B?c1ZkWjdMTlhIaTdlTjJMZVZKcnJ5d2E1QVkvRlhWb3loaFJDalV3OWtJaWJa?=
 =?utf-8?B?alp4QldHK2JwamkwK1BSdTVvYjI5bFdkMGhjNDVMR2VWdWRHWkxGSHM0Qjh4?=
 =?utf-8?B?YzdNdWZOVFI1VUhsSzRtNDdZLzVpU2VUZlZZUFlhRkN6MjNFQmUvbGNqd3Bu?=
 =?utf-8?B?VExhZEhmdEUySHRJTStLd1dIK2VIK1hSeXg3bTBuR0w3SlRmM0VGTXBxYS84?=
 =?utf-8?B?WnNVZTJqMXdaVEdGeGpWRlhJSTJ6ZFE3aTBSbzRhMHVHRVZ4SlhmR3pkOE9W?=
 =?utf-8?B?aFNuTHphamZ6UllRTjFBNHMwNGtqcExzR2JmY0ErT2V2OEtqWVZHY2ZndXh5?=
 =?utf-8?B?eTBoYm9wV3FNcW5WNmRUR0RDU2N0TE16Ykx2cmhVQVZJeHJHTXZiYk9nMWhw?=
 =?utf-8?B?UkQ4Y213d0lSeEVBcEkyUUJGWS9VUjNmMm5PcEpiUjZvSFRiY0ZXSDVmVjZH?=
 =?utf-8?B?MjZaQlJveWF6MnFuWktpNzdyOWVUOVc3a2VURnlMOGorZnRZbHRmTm5taUow?=
 =?utf-8?B?eTE0dFY3WXNieXl3QWhLTHAzekhGb2RzOTVvS3AwbnFiVlNZeWlraXJKY0RK?=
 =?utf-8?B?YnBwdXQra0phdE1VS3hPcUY4VjlSVlpVRm1jUTFFK1hpZHhKSmRkR0lkY2hB?=
 =?utf-8?B?b0VPQmc4eFVqMitYSG5Td2JJdkY2Z2FGK1dBcmlOWGR2amlMck9wL2llTXls?=
 =?utf-8?B?VklMdUFoMWZZVWVDZS9aN0RPbEwxOThYUWFUcERTOWlNR1BISmxvR3VBcHlh?=
 =?utf-8?B?ZlZYSG95dHIrdHlvZm5oa0lVdnVDYndsNVJoZ3NxSTViaGN4WVhmaDBUT3B5?=
 =?utf-8?Q?P9oCVntpajiU1EgRTK3XzLirv?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bee5d9-a28c-4b2e-73c6-08ddbd2eeb90
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:18:57.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/O2WiSHI344a6gizcJF9Pzur+u5UiVmzG3EhZrLdlkgUJBXTQUUy8x0GEmxhkjGD33cUMaOusi8QVX/XeU7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6511

Hi Pauli,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> ma, 2025-07-07 kello 09:48 +0800, Yang Li kirjoitti:
>> Hi,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> pe, 2025-07-04 kello 13:36 +0800, Yang Li via B4 Relay kirjoitti:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> User-space applications (e.g., PipeWire) depend on
>>>> ISO-formatted timestamps for precise audio sync.
>>>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>> Changes in v3:
>>>> - Change to use hwtimestamp
>>>> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>>>>
>>>> Changes in v2:
>>>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>>>> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>>>> ---
>>>>    net/bluetooth/iso.c | 10 +++++++++-
>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>> index fc22782cbeeb..67ff355167d8 100644
>>>> --- a/net/bluetooth/iso.c
>>>> +++ b/net/bluetooth/iso.c
>>>> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>>>                 if (ts) {
>>>>                         struct hci_iso_ts_data_hdr *hdr;
>>>>
>>>> -                     /* TODO: add timestamp to the packet? */
>>>>                         hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>>>                         if (!hdr) {
>>>>                                 BT_ERR("Frame is too short (len %d)", skb->len);
>>>>                                 goto drop;
>>>>                         }
>>>>
>>>> +                     /* The ISO ts is based on the controller’s clock domain,
>>>> +                      * so hardware timestamping (hwtimestamp) must be used.
>>>> +                      * Ref: Documentation/networking/timestamping.rst,
>>>> +                      * chapter 3.1 Hardware Timestamping.
>>>> +                      */
>>>> +                     struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
>>>> +                     if (hwts)
>>> In addition to the moving variable on top, the null check is spurious
>>> as skb_hwtstamps is never NULL (driver/net/* do not check it either).
>>>
>>> Did you test this with SOF_TIMESTAMPING_RX_HARDWARE in userspace?
>>> Pipewire does not try to get HW timestamps right now.
>>>
>>> Would be good to also add some tests in bluez/tools/iso-tester.c
>>> although this needs some extension to the emulator/* to support
>>> timestamps properly.
>>
>> Yes, here is the patch and log based on testing with Pipewire:
>>
>> diff --git a/spa/plugins/bluez5/media-source.c
>> b/spa/plugins/bluez5/media-source.c
>> index 2fe08b8..10e9378 100644
>> --- a/spa/plugins/bluez5/media-source.c
>> +++ b/spa/plugins/bluez5/media-source.c
>> @@ -407,7 +413,7 @@ static int32_t read_data(struct impl *this) {
>>           struct msghdr msg = {0};
>>           struct iovec iov;
>>           char control[128];
>> -       struct timespec *ts = NULL;
>> +       struct scm_timestamping *ts = NULL;
>>
>>           iov.iov_base = this->buffer_read;
>>           iov.iov_len = b_size;
>> @@ -439,12 +445,14 @@ again:
>>           struct cmsghdr *cmsg;
>>           for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg =
>> CMSG_NXTHDR(&msg, cmsg)) {
>>    #ifdef SCM_TIMESTAMPING
>>                   /* Check for timestamp */
>> +               if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type ==
>> SCM_TIMESTAMPING) {
>> +                       ts = (struct scm_timestamping *)CMSG_DATA(cmsg);
>> +                       spa_log_error(this->log, "%p: received timestamp
>> %ld.%09ld",
>> +                                       this, ts->ts[2].tv_sec,
>> ts->ts[2].tv_nsec);
>>                           break;
>>                   }
>>    #endif
>>
>>    @@ -726,9 +734,9 @@ static int transport_start(struct impl *this)
>>           if (setsockopt(this->fd, SOL_SOCKET, SO_PRIORITY, &val,
>> sizeof(val)) < 0)
>>                   spa_log_warn(this->log, "SO_PRIORITY failed: %m");
>>
>> +       val = SOF_TIMESTAMPING_RX_HARDWARE | SOF_TIMESTAMPING_RAW_HARDWARE;
>> +       if (setsockopt(this->fd, SOL_SOCKET, SO_TIMESTAMPING, &val,
>> sizeof(val)) < 0) {
>> +               spa_log_warn(this->log, "SO_TIMESTAMPING failed: %m");
>>                   /* don't fail if timestamping is not supported */
>>           }
>>
>> trace log：
>>
>> read_data: 0x1e78d68: received timestamp 7681.972000000
>> read_data: 0x1e95000: received timestamp 7681.972000000
>> read_data: 0x1e78d68: received timestamp 7691.972000000
>> read_data: 0x1e95000: received timestamp 7691.972000000
> The counter increases by 10 *seconds* on each step. Is there some
> scaling problem here, or is the hardware producing bogus values?
>
> Isn't it supposed to increase by ISO interval (10 *milliseconds*)?


Yes, you are right. The interval should be the ISO interval (10 ms).
The 10 s interval in the log happened because the kernel version I 
tested (6.6) doesn’t have us_to_ktime(), so I wrote a custom version, 
but the conversion factor was wrong.
kernel patch as below:

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 070de5588c74..de05587393fa 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2251,6 +2251,10 @@ static void iso_disconn_cfm(struct hci_conn 
*hcon, __u8 reason)

         iso_conn_del(hcon, bt_to_errno(reason));
  }
+static  ktime_t us_to_ktime(u64 us)
+{
+       return us * 1000000L;
+}

  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
  {
@@ -2285,6 +2289,11 @@ void iso_recv(struct hci_conn *hcon, struct 
sk_buff *skb, u16 flags)
                                 goto drop;
                         }

+                       /* Record the timestamp to skb*/
+                       struct skb_shared_hwtstamps *hwts = 
skb_hwtstamps(skb);
+                       if (hwts)
+                               hwts->hwtstamp = 
us_to_ktime(le32_to_cpu(hdr->ts));
+

>
>> read_data: 0x1e78d68: received timestamp 7701.972000000
>> read_data: 0x1e95000: received timestamp 7701.972000000
>> read_data: 0x1e78d68: received timestamp 7711.972000000
>> read_data: 0x1e95000: received timestamp 7711.972000000
>> read_data: 0x1e78d68: received timestamp 7721.972000000
>> read_data: 0x1e95000: received timestamp 7721.972000000
>> read_data: 0x1e78d68: received timestamp 7731.972000000
>>
>>>> +                             hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
>>>> +
>>>>                         len = __le16_to_cpu(hdr->slen);
>>>>                 } else {
>>>>                         struct hci_iso_data_hdr *hdr;
>>>>
>>>> ---
>>>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>>>> change-id: 20250421-iso_ts-c82a300ae784
>>>>
>>>> Best regards,
>>> --
>>> Pauli Virtanen
> --
> Pauli Virtanen

