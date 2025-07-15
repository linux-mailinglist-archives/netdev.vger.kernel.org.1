Return-Path: <netdev+bounces-207061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF285B057C5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87034E3581
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65132D6402;
	Tue, 15 Jul 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qai9w8Y7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE4211489
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575288; cv=fail; b=WkF1AlpTbyS4KBeqzf3xtGlSItX66crRUrdRDaVqmnNxDIuMZvOfKMmw4OHI4npSdXWrfIa7HWTm3UVj18Py1l0jPM6JWMaJ3E4EiWnnTKuUbQ5ARef+KveFEHK/uHB2DdjwAe2RxBl7kf0JTXtEU5bVLr13+wkwCn37C+8tI5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575288; c=relaxed/simple;
	bh=ezGfxdYOQ/M29QZfCJcvCLQ4UaevUeNtcsBTlxTDxLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+7dhPPvmaXmoCklC53eeA3gAEIhM2JwLWlbldIr/ZgbiHwvRjtREMwi9iyJu//kC5nVde8tdpAMzcZLa6YIlRPjxOmWX5ApJ/gEylMZGS0EwzZY9lvLK5ciQ7z785DUqhy8plqbcEqSI1u+b0b7cQEQ9hbNnwumNJsRYBFQkxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qai9w8Y7; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSOR8a16x1euJh/8Iun/pej/YLfN+TErxxLQbg4CCcZ22j3/btG+joKK7Ck1Zepae2l4Y+9OAag4uTI5+JeWZV2dDrkmVN62LA40qd7pXmXt1QOkMqD+Cq8novgJr36lNB4GCjbTDUQk0SkBuYWQr9ypb24GYt9zIJydkhm+TRsDiIkY4iKFId55x3Dn9i+09lHFARqqAmaZ0tHNTJ6tLzhDQyBfSIdxvntNlvpobZbiriJnnR8JeOcgwpBDy34EAgZ9z1Bk4J6tPDSaRE4zessW8/pgBMoB3pswUozBeohroTUYvVkvy/pdXkm90abKkMfFLZKArcEXj/+eDDOR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSTFGAOhncR04Qg4tOA0HQyEzsuCf5uOLPrdoW/f740=;
 b=pjViUtQOXAnjn684HcoykBnwG0Ad3u2NWHFA/dDekY0dKc4IX7RyLwn7A0yt48ab1y61un+KBwq8aHgCdLgI6pnSJZCJeCp0zzGolnnztlh2ZNz9+siMkfFzX9T635S2YGyoKn8FDPzhsg1LNP3uZDBzWTMRL18FsL5OJl6fDiK9of81YNZMz7P9jQCINR1/OQ73hI4CAR/UTX0AayLymeUPKCL0WPf2YYAbXnAfS2ddRIiZrF5EybegP3gzFoluwn8OTXTt4VOjgn9KwOe86CU2TFAbMwUg6VxQHfZQAzWUF2Gg1J/yW+DmeZ8Ucg2crvGGOlBEdPgcolBtuSO4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSTFGAOhncR04Qg4tOA0HQyEzsuCf5uOLPrdoW/f740=;
 b=qai9w8Y7dZp1Q0WP31PH9CtJ1/gfnDdp9Ql9QvWjcYwbUQSmeKTjL8Hwak4QduuaJxSAe7Ig0iOavX7o8f29L1OZ/Io0bjiWK8KuZFt0LutLfMuvW6EH/q4+UuTio3U+4Jtzx7l4u9bKFG2tvYQRBrYRxlhJNpZLnbU8R2DvJP7Q3lOZOt4jf+4MCh0hWIJgRYALQPj6DuELodD2KbwTHoGJffqD/p5F1m1ikW8IjKOISN7KEOwKT4NLpHgcc/pqh1xG7s5lqsxZKWe2DqO1HGMXeDH36NFdFhYsWbjrgQYB7YIy3Ay+X8KQPcesnOl+IWV370rD47ETHYxjWh+FpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 10:28:03 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 10:27:57 +0000
Message-ID: <7bfc8766-0f6f-4309-984e-24ef86f5c8e3@nvidia.com>
Date: Tue, 15 Jul 2025 13:27:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] ethtool: rss: support setting flow hashing
 fields
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-11-kuba@kernel.org>
 <2a4c0db9-d330-441f-bce1-937401657bfe@nvidia.com>
 <20250714092933.029a6847@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714092933.029a6847@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d4319f-2d8d-43fa-0753-08ddc38a4433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdLcGVMeU05QXI5NmFUcmE4c2R1Y3NvREF1V1VjMnRTQi9zaXcrbnBPbmV0?=
 =?utf-8?B?RWQvTkpmdFNkbG90VnBPZFpiMlRGMWJ2K0EzV1ZROWYxNzRZWVRJeExRUklG?=
 =?utf-8?B?M3Y4NDV0OTMrK0VIYVJaYXdXdmxpYkpvN3VxYkZUbVpUUTl1SEJJK1c3VnBw?=
 =?utf-8?B?anZFT0FubGZvQzJwSWdSOXJPdHAzbWZzUXJTSERLTlNON2pWYlluYVpSQ3E1?=
 =?utf-8?B?WTkyeUVXam5yeXdzak5HZkJJSC92N1Nza0RRZWZhME5FdU1jeVBObjUwTW9H?=
 =?utf-8?B?eTV1dXlkN3pHZlArWUFqcks5MHFGdXlEVWUzRUt1akk5R2kyY0lVYno4Rys4?=
 =?utf-8?B?ZTBnUFozbFpZbVRUaU4yOW5zQmRjM2pKSURlTWRrYjdIMTRobVJ3SkRpNFNV?=
 =?utf-8?B?bFJDT09xbDVNdUdkV1RzL1Vuc0UrRFkyM1hRRDNWM0dXdUsrNitiWUpvQTJl?=
 =?utf-8?B?anlzV3IzUll0NEcvMkkzTGtNNkN3YXU4RVFPRE5ybnJmcVZmL2JXenozaVhn?=
 =?utf-8?B?dFhQK2R4T0RId25QZUN0ZlBUdkhVRENkV3NOYlpLR3FiY3NLWXpTTFdzODhh?=
 =?utf-8?B?TlhlWWFkWk93cENUaWRTeCs0eDQxWFE4bFYzQUF0T1VVWUE2eDE2RGRweGk3?=
 =?utf-8?B?c0Noa1RRNTM3SU5xU1BjN0JmUElDTjFjc1ZoWDhyRHViRWVML2VkK2xUVmVi?=
 =?utf-8?B?bXp1NXN2bDV1cnhHWE0yQllJSXk3eldrMmpVZU52bUZTanZpZWNDY1F6L09L?=
 =?utf-8?B?eDBwazhuQTBKb3FNVXUyMWFxWEFBSi8yck92dCtZTFhyTmFTWWdvSFJYT21I?=
 =?utf-8?B?ODJ1ME1Lb2xDbHpVcm1sS0RiQ1hkN0E0ZGVVeFA4aGprbTFkNDdJbUJxVTcv?=
 =?utf-8?B?Z2hFZzZiZlU1WTdoSWVCL1grTWhvWWZKM09OTjliWUIzMEhoSk0wb1BtL3Qr?=
 =?utf-8?B?UzFsSVdMaWc4UmFXTi9aTHlOQ0dzcTFMTjB2amJRc0JTQ0RrbUNMRk1xdFlx?=
 =?utf-8?B?OFNQOVBvSjJzcEJEdDFQZDJ0bHpiZXV6cnBlYTBwM3A2UGh3RUVucGEwb204?=
 =?utf-8?B?c1IyL2V6b2hLL3JYaW1xa05zbC9jdXpKOTYvbDhhbndad0k1azBidVdlUkJo?=
 =?utf-8?B?a2l6Q1crVEo0RDBza0lVUWNoU3VhZW55SHVoVGpWNE1TK2pRZ3VtcmY4TE5m?=
 =?utf-8?B?QnJGeVFrMDRoeUM3d0JxZmcrZ3VwRm1mMU4yU1pHTDI0V21aSTh2eCsrS3Zu?=
 =?utf-8?B?aTNCNk9MbmNPNnBFeDdsUERRaGZFSTFZRWtzS0tDUERJbmZ3Z3lQS1dQVCsr?=
 =?utf-8?B?VElwOVZwUjBOUVV0UHdPMlU3bGJKMFdVTGEyNTcwZkdIalFJWDJzRWdQU0VD?=
 =?utf-8?B?UGJYdWRXb1FuZUZKcC9ORkRGb0lBanlUOTd3VjZwN053OW41b0ViOENsRGVT?=
 =?utf-8?B?MU9wNEl4b2VWbTRsL0dHVWxzU21CVWc0VFpFT080R1ozQktMMDh5M1lzRHJR?=
 =?utf-8?B?eWs5Z2VqcmhJdUtlRmJNaXcyUHVKNWF2QTJhVTZ0cnAycmxCZll3RE9XVmRs?=
 =?utf-8?B?dU9FSFBaYXRlZ0JOUE1Bd05VbXl0UWVXeGI2OEU0SGtNRDVYbFV2WUpITDY5?=
 =?utf-8?B?YlMzbmN1WHdsamRkU1FtRlpWc1FXQm85SkhyRVh6T3hCRldqN2UwTG5iYnFH?=
 =?utf-8?B?TnVYbHpoaSszNDdMVlNLaUs0YmhpUW9uU0dCem5LVGdHR2J2UWtrN09DYXQr?=
 =?utf-8?B?aVJMUTBZelMrRlBpYkt5NUdPeUdjRTVXNVF4eEpTQndKbnU4RHlETThndkZh?=
 =?utf-8?B?ZnRFUGdnV3A2ZDFjK01hb0w3ZGtSV2E3d2V4SkRhR1RVK0oxMzhuRFJvelcz?=
 =?utf-8?B?R2U2SVhybnNBOTcxL3lpMW9QcjcrWSswekRwQk5acEdrUStUUjBCemdiRGQ0?=
 =?utf-8?Q?y29PicvQ7W4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEptdHVnc2hkL2hFUjBkem91RGxveGdrbUQ2Tm9xT1gzTUo3cytEc1paVFVS?=
 =?utf-8?B?ZzUraDhmREpYcnpjaHBpMURrNlJzQ2I3NmdwQUdQWnhRNkVncjdmMFgxS1NC?=
 =?utf-8?B?V3l4QXVxTGoveGhpMHhBRTYzcGJEWFZsMFVxNUt3V01acGpZOStJSmtnaW5O?=
 =?utf-8?B?RFVCaDBvOURCYUc5Yk0yZ1QzNXgvUmRxRTR1ajlYTVU0M2FQc0x1V1RVd0FT?=
 =?utf-8?B?VnhOV2RUMnBqbVFBa2ZaTjlLczdiaHpPQ1JiSnlMMDc0eUlqRmRpV1h0blhp?=
 =?utf-8?B?c2pYT0Vaa1E1aUkxN2lNT3pzbFgxU3dPYmt4aUFHNUFOM1hhRVNtL2M5VnFU?=
 =?utf-8?B?Sk1PODFwcWIzU0Eva0VnV1lrRUNLSi9MYjJlTGxvR0duU3J1eEl1LzZUcFox?=
 =?utf-8?B?R3R3TFdETFRZM2NVejlzTmRDcFdMTUx0VmlqVDR4QnQwZ1JqYkN1OTZQNHUz?=
 =?utf-8?B?Q3F4NS9XaGJ2dk5PYUE3NVlQRFl5QU5XQkhoLzcxNmVkTE9iazRTUDg5SGlL?=
 =?utf-8?B?NHhGczhqU1FGYU5LWVA1YmFuOEZoN0RrbVBHa1ZXditMM1ZJMnFUQ3BpUTZ2?=
 =?utf-8?B?QjNVNDlaUmtMR2RkZFQrb2U0NzJnamUwb2x1MFRzUHE4OWgyQm02WWlvYkpy?=
 =?utf-8?B?by94ZmJHbGRWOTY5aElXRzNMQTFodnF4Q3hZN05GT0tnc3ZvSzR0SnVxYlJv?=
 =?utf-8?B?ei9WQi9Va3BrYW0yeHNldUk5eTdTaDlzbGdBMUt3MmlheWh6NUNuVXNMTUcx?=
 =?utf-8?B?dk1sNXRMY21CY1NhUk5ES0Y1Z1pnMUovK1Bsa0FIemFadDlnNlJqeE0rYU1W?=
 =?utf-8?B?dVZlZVZCVUQ1MmxxRnBWM2oyZUhNTHJiaFVRVzhMMW1tc00rcVRCNEliYnM3?=
 =?utf-8?B?dzY5emY4WTd1dGUzNkpjU2RFL3VaSitKaWlpclA3SmQzayt3MjltcFIvbEJj?=
 =?utf-8?B?eC9kRDJVVitlWVZvd2EyMUl3UHRZaE0rL3BVemlLbnRIcjhxekZRZFQxTTZx?=
 =?utf-8?B?UVA3YktSbTdzVjdQUVpiam53eFljck5GVDB3S01vS3VmTytZZGhSZHl3eHY5?=
 =?utf-8?B?Rjk4NXdpWFFqMkFWT0NieEtZTDRhUktqYmpFWVZ5Y2ZGckZTbFRwWTFxT1hP?=
 =?utf-8?B?MWtsNG01amRSUlBSN3pxbjBsRW5kKzlMVTA1cUJZZXRYcmFVeG05cXFsVTYx?=
 =?utf-8?B?Zzc5U1A4WllJZERqV244TXNlanJaOERiWE4yT1JDZjM3c05OZ29kaG1BR1U2?=
 =?utf-8?B?Sm5nQlppTzFVUWN3aGhHUy80K1h6dVZ4c2E2cWdXeHAxa1RHS3FPMXJYRTds?=
 =?utf-8?B?dHVwVDV6bGxMM3QzVGNzTE5Eek9HZ1lpSUdQa1ErSlgwSys1SzRVMnZ6TUVx?=
 =?utf-8?B?SDNmRHJ1U242NmlUNmtBOGxVeDdOSUE2TzVBeEJsQVNCN1ZmOU5tZU93ZUN4?=
 =?utf-8?B?K0pJSGFCNit5RkFxTXRPM29rZ1lZd3hOZ2tiS3RlV3FBa1ljTktYRUkxK21P?=
 =?utf-8?B?M0kyQU9SSGoxZUR1VFNqUGVkMERCYWVTS2I0VzJOZ0NWL0RlUVUwQWRTektS?=
 =?utf-8?B?M1hZbXFpWU5yUC9FVk1hbnRseTNqUUhqSVNaQjUxb1FXc3JVZmNrb2hFYm4x?=
 =?utf-8?B?SHZPcDE3dUNYNGxiY1Aza1VqdWsxL2Z4c3RmUFMrZElocmNkTFpDUXl4NHIv?=
 =?utf-8?B?b1lnVXFVRDR5L1ErRkpsL0xpSFBMZHI0TnBValZFVm01RGlPWjhaTGpUMlRZ?=
 =?utf-8?B?bHhwb0xnbEEzbUR5L011bmVSa0doa0NYMkJwTFZIdERpaWVnZU5BYmRXMlpq?=
 =?utf-8?B?TURiRW9pbGJaMk1pcVFKZ1NVclFXbnVPWVkySnNMazB5QWEyWmJla2x2RUdY?=
 =?utf-8?B?OCtRaVhXWElEV3B1ZWNnVWNtMmZqWEZrNFNoakxzZWhtWUZXTlVtWGt6SXhr?=
 =?utf-8?B?VVJlbFVGR1AySWdiQnIzb3NWTDhZQWJNNkE1RUdveUs5bFJvdlhtbEs5QWlM?=
 =?utf-8?B?dmpDREx6UnZ5c1djdk5VTWF2c2xZNzlpdzkzR2NuVjY3MHV2cWdCbHJTL29o?=
 =?utf-8?B?SS9VK2l6Yll0ODdoSXZrdEQwdEdmOEpCYklSNkVjU3FqTlRjeGxDbjc5cSsz?=
 =?utf-8?Q?LrQ0sLRXbzX9eu4aijkNiXmwI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d4319f-2d8d-43fa-0753-08ddc38a4433
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:27:57.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +92FI9BgM8pT38EAk90ZcvxsuDrls5q0Bgv7vu4qUj0V2FowdTeXkDypHiVyAubr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

On 14/07/2025 19:29, Jakub Kicinski wrote:
> On Sun, 13 Jul 2025 14:12:33 +0300 Gal Pressman wrote:
>> On 11/07/2025 4:53, Jakub Kicinski wrote:
>>> Add support for ETHTOOL_SRXFH (setting hashing fields) in RSS_SET.
>>>
>>> The tricky part is dealing with symmetric hashing, user can change
>>> the hashing fields and symmetric hash in one request. Since fields
>>> and hash function config are separate driver callback changes to
>>> the two are not atomic. Keep things simple and validate the settings
>>> against both pre- and post- change ones. Meaning that we will reject
>>> the config request if user tries to correct the flow fields and set
>>> input_xfrm in one request, or disables input_xfrm and makes flow
>>> fields non-symmetric.  
>>
>> How is it different than what we have in ioctl?
> 
> Because:
> 
>   user can change the hashing fields and symmetric hash in one request
> 
> IOCTL has two separate calls for this so there's no way to even try
> to change both at once. I'll add "unlike IOCTL which has separate
> calls" ?

So it's different because you can use netlink directly to change both,
but from userspace ethtool perspective there's no difference, right?
It's still two commands.

Makes sense, thanks for the explanation.

> 
>>> We can adjust it later if there's a real need. Starting simple feels
>>> right, and potentially partially applying the settings isn't nice,
>>> either.
>>>
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>> ---
>>>  static void
>>>  rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
>>>  		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
>>> @@ -673,11 +767,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>>>  	struct rss_req_info *request = RSS_REQINFO(req_info);
>>>  	struct ethtool_rxfh_context *ctx = NULL;
>>>  	struct net_device *dev = req_info->dev;
>>> +	bool mod = false, fields_mod = false;  
>>
>> Why not use mod?
> 
> Because it's a difference driver-facing op.

Why do we need to differentiate where the mod originated? We have a
single return value.

