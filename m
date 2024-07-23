Return-Path: <netdev+bounces-112662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847993A7C2
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF33B22CE2
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582313DDA8;
	Tue, 23 Jul 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ilwCWc8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5A13C8F9
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764035; cv=fail; b=HFyb30M9mv5kMjmllSMAJwvg9nD25w9n7f8m7vD/U0u45RTjA/gRFKfo1hDA3Kmymnqoe55DYBWJdxdTXPzSOzBlUL5pGCJmG35vSoWWWmcyfgIF5iHXyP9LSz0ZZXdGWqQz/rEOyEO6QQdaP5PKx99/HzY9L6inegvgJkjSDhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764035; c=relaxed/simple;
	bh=eIAwNy44VERZUkh1AqloCuSj9I3xumkz8PwhDlGK0es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WAnhO9BZPvrEYExmG5tVEy+mvoYfCKNhAoLGsJFbdhD4ik9gQnwhEo18ehqSLs7/xaZvrHNlVQCLIdIBDIN8mdcj2cknELu9LoSvv8DyC/BK/JF/bRFxKJS1v0eU54beAV+w7xEI4dLfRkOfxaPohxfKknC0geU1hZfz06yqqLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ilwCWc8; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4cl98L/lYkrxweq9aPnybHahAzfbGZZ6tP5DN0mWw8p+Sr6yQ5Aw5BBRhLlu7M0Dh2vbtDize1KDeuXxHPcKhhjkAcfVPeSqfTINiZ4qQr8O665FwRBPOG8BT8GKcp1q6MGVQRBhzqbVxgM/vGvxQRDya7rTcANxQE2c1lDrDiLpngBdaKT7qPlxSY/Cs2YabIcKSlCm47TSEPym0c3+PwpeJm7V4nkGxDBv6GhnLm+TocdBIrg3/ZmhfWH6UntSnExvEP1Ewo574Zly2BeqTqvsBQx9wZDkK1iy9X0dE1WHEF4IGo9RhaViXx7uOGdIZ9OiEwlhT/bD5brs5qiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3K4B3F1H+5oD7CQns0TXR8EvTBhvJQLAOMIDE8Oid8=;
 b=ojJYNQ7yRltfGx4Ys7/5qdXr+IMVGvby0j9qCksqVyGL0ESUdrexfLPk5oRoFBUeFScKix/ZmJyBqrysSgUGBcc22CVD+pnz+c8g+fv1f9bIItyFuGw5buT2SgFRJnHx00UCk4ey1ex5pouovh/YAwy0qFft8/dH1XFt6c0sFgbhc3GjpBY6CaOiMNKreL1EhAMKgZFvFt7kthIJz8hkKuhtR08+fdUjFS3KyMlG4F+LXePvELdAdGZih0ZfxKowqNKZYh6wN5lRCXStz2Qt8AYmAuUJqveOpUS6b/SeyP5oaVhMN+cJDbo1jQwD2VyY+qy1JrjT156prAsVTRjB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3K4B3F1H+5oD7CQns0TXR8EvTBhvJQLAOMIDE8Oid8=;
 b=5ilwCWc8qi5DnFeiWr0N0O8warTN2MXwKkkPAAZRq09JblAjz7AhdCj39krTJkV4GCRdG7u9OXDh5gkqxhu91kClofNWlXPOCic9V/WXqGNPTp92MzE7+AAyrMG1vZoqhdUUcUYUOIhWKF9+/b2SkxTxTdD5KnTsyYkuNy+Z7vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 19:47:11 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 19:47:10 +0000
Message-ID: <55500d9e-1b6e-4eb5-b3ec-d2843d7a1bca@amd.com>
Date: Tue, 23 Jul 2024 12:47:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart
 logic
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org,
 somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
References: <20240721053554.1233549-1-ap420073@gmail.com>
 <dcdf039f-4040-4a31-9738-367eda59fd04@amd.com>
 <CAMArcTUA9a7Jndk8aNK6cxth=B4UqgPhpJKk1++KXrQrzJXMzA@mail.gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <CAMArcTUA9a7Jndk8aNK6cxth=B4UqgPhpJKk1++KXrQrzJXMzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: e50ac43b-93a0-4e01-55cb-08dcab503e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU81SURZWlVoM2hGaGFaSTRKLzJ6ZUYzdVBCOTBsNkNVQW1vRzRIOWhRK3ox?=
 =?utf-8?B?U0N6elM0eFNESmtOR0ZJRlJQV0JrbG4ydFdScUFveUJFQ0ZnQlB0Y21BYndO?=
 =?utf-8?B?WjRaNldvbTk3cHdJVEllM1JFZkx5MEdrOHQ5dXdYTTNlUTRNRm8rckZrWG1J?=
 =?utf-8?B?MTJ1ZnpiR3RNQTV3eXpnSnI0TnAwY2gydmZFem1rUkJBekNMOU9hczNzK0s2?=
 =?utf-8?B?YWVHc1hLbnhuQUdjcDhXRlJjblpGWm9tdTg5N3FVYUlORGdTZHh1bGl2d0xS?=
 =?utf-8?B?TDR6UVluejFzWFg3Tlhnb2hpRnlkdVNwWDBISGJWWlllamYxMVJXa2M3MjM3?=
 =?utf-8?B?VkxxTlpvQ2MxR1JlcUMvR2JWSU9IekhBZW9nWFQ3RndYSm5ORmRSclVTNjFy?=
 =?utf-8?B?bUhYdCtqOVpqemJ6RjBqMm4vWDVSVFVHS01pVE9LWk5DQTMxZ3VPS3I3emhP?=
 =?utf-8?B?YWJPMk9HSlZ4VUppMFVrdjI1aXFNRUZWbWdFSnZkLzZWZ2FHcThiL2EyeThi?=
 =?utf-8?B?V2xKRXB0R0ErSnFhMUpoZi9ha0x4Uno2WThqUHdKWjNVRUxWQkJYZVNyejRQ?=
 =?utf-8?B?QVE0cnhCd2ZJd1pnY2wzaXNEb25xbU9zc29nbm5YYzRxWmdoa2RCRkhhc3BP?=
 =?utf-8?B?M2d0SEdxU0ZHZjZscEx6cGFiYVNwVG1Sb0YrRHFaR3FucXRqSW5KVEZGdk5k?=
 =?utf-8?B?VFZrSmdzWXJGT3g2NEhMdlloZi85bUoycWNKdy9mNXdpMU9wTlJQN0RBVTFW?=
 =?utf-8?B?L2FVZjIwNjB5MUNOSU40bnRLVDNoZHU1dm00YnJKOHBwQml4Wm0rOGFqUE1P?=
 =?utf-8?B?VGdhQjN3V21XVjZYdS80N2kyUUIwZXk2Ty9Ud0tkc2hRcUhLU0t4NHdjRjlK?=
 =?utf-8?B?aVlmQlVVOTJ4NVExTXBrd1F2WXFxcklCcm5Xc3lYcG1Hb1lSM2czcjhnczNN?=
 =?utf-8?B?UW5MeUUzb1VZQ1BEUmNyT2hvajlzTEFkTWZPa2lTVktmaUJIUVRLVjVYMkla?=
 =?utf-8?B?MDJxcVRlbytuSWJFbGV3SDlpaU4wTWs1Q3NRcjVyeFpSb2pxRmJZL3c2ekh5?=
 =?utf-8?B?ZDV3b2M5ZzVMeFJNVFVaMDRvSlFsbWJIV09hUmtMZlZMSnI2cDhmZEpLemkw?=
 =?utf-8?B?NTZLcDNXdThIczZuMkl5c0pYbTBYTURWd2E3TlMycUhQSi8wZzJMZEtpSTRz?=
 =?utf-8?B?U1ByYmhqR2tZdzFmam1DcW13MXlpUW1zVStuK3p2RTAwamd1YjNabklHS1Mr?=
 =?utf-8?B?RDJ2R1Z5NFovaTZxZ2NVelU2RmR4NGkxQTdaV1ZjQ2RiSlIxc1I2T0VOdXNU?=
 =?utf-8?B?ZEZ3TGROdW50ZjNmNTNOQk53UGhST3NVR25TYTZ0Nml4WFFKNURNUGl3Wlho?=
 =?utf-8?B?ZmtDM2ZaU1pOYkF2cUlldWM4VThObFdJVlA4Szg2cXU5YmwrMXJPV0xyUmRr?=
 =?utf-8?B?WlVMME1qKzhTZUFKTXNneVdPdCtVNnRDd1dtMTBibHZoRFh4RDhrSHUvOXhz?=
 =?utf-8?B?SzVJVEhkSnhDREgvVU5HcHBGaTErVFFiclNKK1ZXZk1yTE1KOGE5VWZUUHV0?=
 =?utf-8?B?N3RNeDNxVFczalhLNjd4aTRlUUdwYzdvYU1vT2U2eFQ2TXUyMU5XMEVzVXVT?=
 =?utf-8?B?ejZKRjZtSnExQktrdmdNRzl0VzBJYlhhVHVjTEdwUDRBTFpRRDFKY1o5OUxY?=
 =?utf-8?B?U2xvRURpZGJ0NUV3eklxMU9ZZUI0UWM0UWs2OCttSEVTb2RveGFFZWN1dDNQ?=
 =?utf-8?B?SXh5Q3JUbUVQbGQ4bTNrdHdhTTNPdTIzYnl6ajhnbGhadzl0aXlvYkRxeHUw?=
 =?utf-8?B?WTVPeElYWm9LQnh3TnhKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZ4NXR3VFRJSU5mYmVNWllmejRZK0tkWUlWdWVteEduRmo2ekorOUNQR0RT?=
 =?utf-8?B?U0ZKbGFrMHp1S0N6MzlHWDZlSGtYY0I5Skp3dDlsd2JmR1NVbmRrNGc1VTM5?=
 =?utf-8?B?SXVBWHZncE4yMGZDeVNIb1RnYldLbkloTVNtOFNGK295Ty9HaFBRZndQNzVr?=
 =?utf-8?B?QUtuakNIVW0rTlFhdHBaNHhxNzVPQVdzZG5BYVNTZUhvS2tOSE5JdHpBNGN0?=
 =?utf-8?B?c21OY215YTg0dU9lNXpZa1NIRDg2WElCQmhxNGZ3SVR4ZUhpV2FST3ZLM1dF?=
 =?utf-8?B?Vm8yTExCa0plWDZvUy94T1IvQWkrWUxoMHM3TzdYTVMyRG84WW9YRjBHYXdP?=
 =?utf-8?B?ajQwZ0p6Q0RQcGNQNTJESUJ5UHZ0MFFvRTh4a1VFcG5sa3hBK256YzRRckFX?=
 =?utf-8?B?U2tTdGRxVjZiZTBzbm9VR3RLZ2JRVGVNdGk3QzVveW82ZFc3dkxIekNwMWJO?=
 =?utf-8?B?ZDArRzRpcEhQMXpFRkxyZ0VZVkNmTFhZeXhOaEU3Y1JVR3FnWTd1a3d3WUtL?=
 =?utf-8?B?M3FkYnFqcUZSMWpSdFJKellGYVE5b28xbDhHdjdDcGlaZ3J4em5UQTQ1SUlh?=
 =?utf-8?B?TExZbE1TbzdGMDJOenpwa0Z0UUMvUDRHSDNkb0JMMSt2QlhwVG9vRHhMK25J?=
 =?utf-8?B?Mm5jdG1wZjNaSUtZSytuS1ZLVUR3Nmp1TWlsOTFkaFdHRkxscXR4Y29nL3ll?=
 =?utf-8?B?cHUzZXRLV05CN3Rkakd5ZHJydm8wYW13WHJxWDZDRFhXclZFWk5JMk1LQ2hm?=
 =?utf-8?B?U0ZrUmhsL3FoY2JCMHBySGRzY3dSYUFxVnNFdW90c3lYNm5mK0VUTG1Oelp6?=
 =?utf-8?B?M3VVR044L21XYVNwTDhBUUJDYUtpb1J0UDE0UlRLeFBpaURVb2lZdGkwWXNt?=
 =?utf-8?B?NDAyM0RLMXJXNHJKL2F1OThzOXVEU2psdmZWY2FTd2d6WnZ2ZW95OFo2d0hh?=
 =?utf-8?B?eFZlNTVhNHVXOFJKTUY5L0NLMVhmZ2pNZm81bmg4YmlqV2JCSzNUaGJtUk1i?=
 =?utf-8?B?MFFWZ0Q1dEV0U3RQcE9PNkZ3SFcwckV6dER2MVZpS2hQb2VDQTA4QjBPWmRI?=
 =?utf-8?B?b0xuTStRd2dXUHZYVUxSaDlKVkgyMmdCb2J3TDdtbHI5aU9OY3lGbzZsZUJq?=
 =?utf-8?B?ZlpKVHZsdWZ6UUZoMENDcUJwY3VNNzk2SjM3eUlEU2pBOFRxMHFUbGhpOUlY?=
 =?utf-8?B?YzJRK1BOYUVEQk9EUXBMV2N3OVJ4WTBidzJic2hCMk9UdzMzWit1em9mYmJJ?=
 =?utf-8?B?VUNaYWpFeVpEcmswRWJNL0tWZEFCWHVKNE0vYngxK2NDM3ZuR0F5eTFwQk9J?=
 =?utf-8?B?ejJaeUJxQTFQbUxPMkhzRmMxOE5pWm5yWVFxdW1tc2V3Z0wvcVROWmlOSGhs?=
 =?utf-8?B?bTg5clVvYk44WGdwd2dGQ05tN1pDSEhiRlluc0o2ZnRzU0F0eWF3R3A0SVp6?=
 =?utf-8?B?czBmMnF0ZmwxN1JtWVhFZ3ZKK1NMdlBZbUJWQ2NhSkNGby95RmhyQW4rUG5T?=
 =?utf-8?B?ZTVtTjZMSm5LOVp4Slc2QjA3aEd0K2E3TnB0aEVDVG93bGFQZklHdVAwOFdU?=
 =?utf-8?B?SGRodTQ0TDlka2xnZGRGR0ZXV3phcG1uOWZFSHhCV3NESTZVdForZ283bWJs?=
 =?utf-8?B?Y0VTakZIZWpHeCtoaVlZTDNNQi9tRkc5Ukd1Z3FlN0FnSWxWREdncmJFdnly?=
 =?utf-8?B?em90T3RrbWd6YkJpNTM2aFFQb3piOUpZUW5iTmFYNHVPdzlUa1JYYm04ME9s?=
 =?utf-8?B?RTJHUjdSakhqZStYTTZQdy9rd3hKWnZhYm5UWm5kOUlaRFExdy82Yk5KQW5h?=
 =?utf-8?B?Rk1Damh5cFZBVW9maWVJUHQ3c090TnB4YjNta0hkZVNYTWFwYlhZbVBqZUZl?=
 =?utf-8?B?ZlJRS2k1WHBQTEIwUjI4QzRPemxxcjlDLzJYN1lnelFQRTYxL0dzSzFmN24w?=
 =?utf-8?B?aHNsYTAza3E2Tis4dHBvNXdDWmtJd3k0TWtDZ3NlaExDTFhvQllXTlBsOU5x?=
 =?utf-8?B?NXlxdXdrQW44Qkp0UFZWVVhPd2MwTzlyT0NDbWkwbTF3czNIcGJlMmk0ODZJ?=
 =?utf-8?B?OEZtaW9UU1ZyaFpjakdnM0lRUmZLRnJyeGl6Yno3NUNMdHV4VmVZS1JyMnB6?=
 =?utf-8?Q?igM3I9nOazmQhiAUkUufnYsdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50ac43b-93a0-4e01-55cb-08dcab503e04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 19:47:10.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsKZTofVsKhDKNj2d3yFgEIcRuXqyuWv/1c3hfiNw2zTiBGPmhw3XJ2p6xgOml2hBwH2NHaa1xFPbhVEkOvdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

On 7/23/2024 10:58 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Jul 24, 2024 at 12:42 AM Brett Creeley <bcreeley@amd.com> wrote:
>>
> 
> Hi Brett,
> Thanks a lot for the review!
> 
>>
>>
>> On 7/20/2024 10:35 PM, Taehee Yoo wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
>>> updates(creates and deletes) a page_pool.
>>> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
>>> connected to an old page_pool.
>>> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
>>> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
>>>
>>> An old page_pool is no longer used so it is supposed to be
>>> deleted by page_pool_destroy() but it isn't.
>>> Because the xdp_rxq_info is holding the reference count for it and the
>>> xdp_rxq_info is not updated, an old page_pool will not be deleted in
>>> the queue restart logic.
>>>
>>> Before restarting 1 queue:
>>> ./tools/net/ynl/samples/page-pool
>>> enp10s0f1np1[6] page pools: 4 (zombies: 0)
>>>           refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
>>>           recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
>>>
>>> After restarting 1 queue:
>>> ./tools/net/ynl/samples/page-pool
>>> enp10s0f1np1[6] page pools: 5 (zombies: 0)
>>>           refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
>>>           recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
>>>
>>> Before restarting queues, an interface has 4 page_pools.
>>> After restarting one queue, an interface has 5 page_pools, but it
>>> should be 4, not 5.
>>> The reason is that queue restarting logic creates a new page_pool and
>>> an old page_pool is not deleted due to the absence of an update of
>>> xdp_rxq_info logic.
>>>
>>> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
>>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>>> ---
>>>
>>> v2:
>>>    - Do not use memcpy in the bnxt_queue_start
>>>    - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
>>>      bnxt_queue_mem_free().
>>>
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> index bb3be33c1bbd..ffa74c26ee53 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
>>>
>>>           rxr->page_pool->p.napi = NULL;
>>>           rxr->page_pool = NULL;
>>> +       memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
>>>
>>>           ring = &rxr->rx_ring_struct;
>>>           rmem = &ring->ring_mem;
>>> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>>>           if (rc)
>>>                   return rc;
>>>
>>> +       rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
>>> +       if (rc < 0)
>>> +               goto err_page_pool_destroy;
>>> +
>>> +       rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
>>> +                                       MEM_TYPE_PAGE_POOL,
>>> +                                       clone->page_pool);
>>> +       if (rc)
>>> +               goto err_rxq_info_unreg;
>>> +
>>>           ring = &clone->rx_ring_struct;
>>>           rc = bnxt_alloc_ring(bp, &ring->ring_mem);
>>>           if (rc)
>>> @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>>>           bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>>>    err_free_rx_ring:
>>>           bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
>>> +err_rxq_info_unreg:
>>> +       xdp_rxq_info_unreg(&clone->xdp_rxq);
>>
>> I think care needs to be taken calling xdp_rxq_info_unreg() here and
>> then page_pool_destroy() below due to the xdp_rxq_info_unreg() call flow
>> eventually calling page_pool_destroy(). Similar comment below.
>>
>>> +err_page_pool_destroy:
>>>           clone->page_pool->p.napi = NULL;
>>>           page_pool_destroy(clone->page_pool);
>>>           clone->page_pool = NULL;
>>> @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
>>>           bnxt_free_one_rx_ring(bp, rxr);
>>>           bnxt_free_one_rx_agg_ring(bp, rxr);
>>>
>>> +       xdp_rxq_info_unreg(&rxr->xdp_rxq);
>>> +
>>
>> If the memory type is MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() will
>> eventually call page_pool_destroy(). Unless I am missing something I
>> think you want to remove the call below to page_pool_destroy()?
>>
> 
> I think both page_pool_destroy() and xdp_rxq_info_unreg() are needed here.
> Because the page_pools are managed by reference count.
> 
> When a page_pool is created by page_pool_create(), its count is 1 and it
> will be destroyed if the count reaches 0. The page_pool_destroy()
> decreases a reference count so that page_pool will be destroyed.
> The xdp_rxq_info_reg() also holds a reference count for page_pool if
> the memory type is page_pool.
> 
> As you mentioned xdp_rxq_info_unreg() internally calls page_pool_destroy()
> if the memory type is page pool.
> So, to destroy page_pool if xdp_rxq_info was registered,
> both xdp_rxq_info_unreg() and page_pool_destroy() should be called.
> 
> Thanks a lot!
> Tahee Yoo


Ahh, yeah thanks for pointing that out. I missed the call to 
page_pool_use_xdp_mem() in __xdp_reg_mem_model(). It also makes much 
more sense this way as it makes the enable/disable flow symmetrical. Thanks!

Brett

> 
>> Thanks,
>>
>> Brett
>>
>>>           page_pool_destroy(rxr->page_pool);
>>>           rxr->page_pool = NULL;
>>>
>>> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>>>           rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
>>>           rxr->rx_next_cons = clone->rx_next_cons;
>>>           rxr->page_pool = clone->page_pool;
>>> +       rxr->xdp_rxq = clone->xdp_rxq;
>>>
>>>           bnxt_copy_rx_ring(bp, rxr, clone);
>>>
>>> --
>>> 2.34.1
>>>
>>>

