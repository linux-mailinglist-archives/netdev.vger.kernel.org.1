Return-Path: <netdev+bounces-222669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B0B55547
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A1AC41E9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85496322764;
	Fri, 12 Sep 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j8SpWoXC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A8227BB9
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696541; cv=fail; b=WJ+n7D+VB+Z8LPa9X0Xgkt//5jGqWnEk+4lL7xlmm4z0R8Q0sU4263vGhl5ddFfl29QB+gjc6Vtu4aIZ8XO5yvdwVCNNnLXDWa9eP6ENdUC+oMhpiCW+LC4sBoXkXZmOVFe7cCpfVsONI84stMZXJnTG6TkPzFHqiOE7x6VoH3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696541; c=relaxed/simple;
	bh=6o/J5OPpiVGHpGgGkh2SOyglL/86OqFm8qTkk+p/ndo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RybMQb9ryElTg3MTUuESFuAOAk+UQxfoY1G3hGESEAuFeh17gQucakVOJ+9naxVtJs7cKDqCCPIb0eeQyFpPaHt/KuZCA54KkmTOxJTpcnjDD7iOvaPPNLs4zionuVy0lBh0uj2sH+gDQsnJyeeSw8TieRZ6QQxzVZI5PudlIiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j8SpWoXC; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeYEOMCpMIRIZ+YRHUp3T+aDumPa/Gpzu2uTFye5E06Pdes1sChclGhTS3Eq8kYBVlgw0nUFlkFpym8GWldgcqzcLkVOZbbvMUtY3IL3UZJwlKMtdvLOYDOtAthv142qinBcca1soq798hvcuz28vefZX8FguVaScQuHmx2Z3IWiBw5r2++fn093bxlCdwLPgQLzFilOkZmhJQhFB+ASq5aUXBMgv06KWjbaOwMcQ0DOn8DXJuYckkY2KIyrrNJyjUqMpDN6e0ajJbOPnh7tsWPEHlr4C8HtC8OqnZq9npALzWuqok2rHTAWBs9nYIhh6ErAVOsigKRmUX/kjmyMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAtCp3oPmY/wRvqKWIkwfcxYrgrX+OzuEy+xLKw5Cj8=;
 b=Lf76UedgkJth7b6+SNqob7oDZTNxCyw4R1sTXTPjr+pm5cHKmUtr19q273mCIpdC3A9BCgfvsQdZx0ANxrH2vcgVMsRDGRjLhS6k+Jle809QAtK9963KZmQUxll51kOwDZ7f+lgTOqDUW4Xh4bddQAaNStLDFN4RnTF3FBu6y+lyLsnYoeBQ7LXHTixe0/gmdUmPUZdEmj8qGbaPC44O7sZhMqVRwPbQkyB9pruhYEmnOFgQW2L0PYOaWfTo26dLY9XYfNzYZJIfZdkR0hP/NvkHuMMEm07AkGSyV7BrruTGwb9kQ1EbllT7kz6Nos16qJs36I4zX4+NWHb9aEZpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAtCp3oPmY/wRvqKWIkwfcxYrgrX+OzuEy+xLKw5Cj8=;
 b=j8SpWoXCeH9we79vn4xrQhcfUVyOYVVN7zKi35VQkQXH0eDbxuy/+bBaOSM9J1/egCVNCOAmdsVT/6/EtAhPpZ4gq0LPQ976kAxuZkqdqT1gfyJrSkdB1I5lZy1EdgY+1c6oVWkXBTLrZ66ayhmpb+5Hqr92GNiwHIEvl/uW/nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 17:02:16 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9115.018; Fri, 12 Sep 2025
 17:02:15 +0000
Message-ID: <f654f6fe-defb-4bdd-b4a3-7228ff5b5f8e@amd.com>
Date: Fri, 12 Sep 2025 10:02:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ionic: use int type for err in
 ionic_get_module_eeprom_by_page
To: Alok Tiwari <alok.a.tiwari@oracle.com>, sln@onemain.com,
 brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20250912141426.3922545-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250912141426.3922545-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: be3103f6-3ec5-4a50-4b5d-08ddf21e1fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2R0YThNTmM5MWxMcU4vL1pYaFRObUhaNll2c09iV01TSnQ1c09FcGVVTmM1?=
 =?utf-8?B?SkF6NStLUk96S2dQYURLK3BYUGZqK3lMUm9jMGdwbzJ1eWJkVGEyaHZlSGxn?=
 =?utf-8?B?SkJZZnM3VkoyYUNVUndLWG5xWElQbzVXbGtoekZoWW5RMC9mSlpmRkNKK3NW?=
 =?utf-8?B?OExBSzUvZWdrNU0yQTNTM2p2V08vbUxPMUhNbDFXbkU0VlBuc1dyRVN6VzQr?=
 =?utf-8?B?YUg4cUMyN2p0RkxzY1NzY0J3MGpDNklHRkxIZzBXWUpqR1ppS2JDazVwblg1?=
 =?utf-8?B?d3RHMlJRV09SK2xPR1JXZzNEakpYbmZaaGwwZUVQcDFHSWg4UmNwVnh6bkZk?=
 =?utf-8?B?WVNHZStVN3NOSE1tM08rVWlPcnh4aEVxVXB5aXNvWGtzQ1I3Q0s2RUZJcWJ2?=
 =?utf-8?B?VEpKaUx5SzhCdHNJTTJOZCtrbzNlY0g3Sm9manJGeTlINmFOdVRiSlhtQUtY?=
 =?utf-8?B?Y1FhQ3NwMUpVclZpTEJrTjkycU1ZM3RkWjdMTjc1a01QN244UnFxWDhuZ3V3?=
 =?utf-8?B?azA3Z2gyQ2duQitQODRxVFA3ZUlEMC9WTHVDOTg0MlF0M0FxTXJ1SGZkbnVX?=
 =?utf-8?B?VVhWMmhwcDM5QWxVNTNNaHo3WmMvSTZ1SUFnYWhUaGRNcWo4TTZIUlpTZEt5?=
 =?utf-8?B?V0UxUjRiaEwxY1QxUk5xc1p6U3FYb0lrOENqc09ONk54UXMvV2pyZGpVSnFs?=
 =?utf-8?B?RFV6bEY2OVk0ZTlnQld5SkkyRWd3ejNvdzQwTHBXVytiM0dKdk5CYWxIQ3lJ?=
 =?utf-8?B?MmV4dmF4SExNRllCUWtFckQraHF5dDBvMjhMU0R3d205UXcyZ1pFQUxhSEUr?=
 =?utf-8?B?U1d0c01sL3I1cFJvdVBYUjlzUm1reHZRbXlLaEZySjByT05GVzlyTWZMeUhB?=
 =?utf-8?B?UmJVdnVoc3BwQ05tY2tvQTB2MUVWbzZWeHlFcUp0MG9iUHp3emdhYXFjTThp?=
 =?utf-8?B?TERvaklnUnkzbEMrRkVSM1NsNVd0eWZOVUwveW5VVzh4YWk5QmJiVndrNHB0?=
 =?utf-8?B?ZUcxMXRyTm9BT2xVd25UdU1VOC9meVFkeWdjdEQ4VUllNWRwcUU0QWJQbEpv?=
 =?utf-8?B?ZWZMWWF1RGNSZ2F2SFdkeTZuVkFIOE80RXNVSE1sdzZ1TkpHRndLMkJLcmY3?=
 =?utf-8?B?WlFWS3dRTlY1Z3FiRkFTZXgzNHFzbFV4Uno1ZkhSdDcwNFNTSTliQlhXbkFL?=
 =?utf-8?B?S05iQXJLUUNuWjJkdHZ4bnhaVlJISlVKREVZVllnNlRIMW1zVlozQkQycGZ5?=
 =?utf-8?B?VlRuSzQ5MlJUeFNJN0x2VWdycTRFRE9UenVIOGpiWnRBK25JUjFTRm1WSThR?=
 =?utf-8?B?VXllSHRYVGNpbXFhcEp4MmFFWjEvN01KK2xmdFBJdmtKTFRmU0lZeGhWdE9B?=
 =?utf-8?B?RGtLU0dibGhmMllxUFN1U1o5QlJJN3YyUkhjb3JpWjFpcjNOdGNZZnZJcitN?=
 =?utf-8?B?cXpwWmRKT0c1Qld6TmJVWXdXMVcrclpvQW5FWnlva3lXUmRMRUlrZ3RUaTln?=
 =?utf-8?B?U3BYQUlDYWFSRmN2c2c1M3FTVkxGMHNUaUZsWGxIRmd5Z3VoQ1NqNUdCRm1W?=
 =?utf-8?B?djN5RVorcnpnb1g0bm5KbEcvOG1oZks3YjJlMW9jTE1tREw4cVYyKy8vdWNr?=
 =?utf-8?B?a01CMXhLZkVNTVpGSy8vNHhYTTVnZk9kS00waFZFTkI2Q2JmUkxjbVFqSHVP?=
 =?utf-8?B?T1EvajJTNHhwNGErc3k1cWZ0cm9vMkxZRlFvZWxCWGVIVEM0Vy9Wbmk0cFBr?=
 =?utf-8?B?TDRmNVV3eldvRGdtN2VCTGltbnJqNHFkWjNWUFc0S2NmZVZlbnFzNTlXdnpQ?=
 =?utf-8?B?OTVUU0FYTzVYN0lteGdsM3RpcGtQZWlKUGZnWFd4K3d2TFBaNDhyZmxHa0cx?=
 =?utf-8?B?QlMrdVloYk13NlpVaHdxZTFyaDBYL0w1N2hxOEg0L3dIMFVCeTBvVGw5cXBa?=
 =?utf-8?B?cVlaSUpDYkFvS3FsZGtkb1F6Ri9mUXJVYkswZVl6d1RPWTFlUUFzNlFtZlFH?=
 =?utf-8?B?blowRnl5NTB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlB0WFEwZkR6bVMxRmwzajZuU2o0YWR6RVBlYTVkVEhRdW5hZ1BSR0V5aWxx?=
 =?utf-8?B?K1VnSWJSUllhNm1FTktDZzdlcm1JQlZNMXVHY3crZnhDWDVOZVNVUG04K1FJ?=
 =?utf-8?B?ckQyd1FMc3BtR05kaitBSzZjTXhPOEFuU096WXduTmlvcVJyTHFoTVVDK0d0?=
 =?utf-8?B?NVFUSU9uNnNxQTVocE9JcXcrMW1INzdVTThobGdZUVJlbzltTmN2ZHQvM1d3?=
 =?utf-8?B?K2p6aGZwTEFBWmF3d1B6K0lsTGFIYm9BbjdYRGJEbGd1U2xzUk5sZ3RpRjZH?=
 =?utf-8?B?aWkyRWlvRmdnd2FFUzQxdnlFaFhFOExsUHlFWk5LVXVFeTQvdDNrR3JBRytN?=
 =?utf-8?B?U1UwYTFZcFRLbkkxUVVhT3R4RVJKTm00U255RXlLaEo0dnlFN2NxTE40VTll?=
 =?utf-8?B?NXQzWkNYNWtpOGhHcEdmcy9zeHFMSWxKaUxJNDZ5LzRtZUlVcW9aVkNGb015?=
 =?utf-8?B?SHcrdmw0M2piS0hGYXEyalBiRG1jNGNnZ20rb25tK1hPZE1CSjZvbjR6TERt?=
 =?utf-8?B?SDk2eVRzYnNFY0M5MFNvZm5mWWsrR1Y1SnBZYi8yd0RrY0ZzdG5TQ2JUVUgx?=
 =?utf-8?B?ckh2by9nSHNmbnI3c0ZJaFZYRGo5R2t6YTUwc0tRYjV2WVg0UWpFbUZ4bDJ5?=
 =?utf-8?B?eVMrdGNxS2ZSQlFseHhKRks0SG5EV1Ria1NEb0RvQmQwSXkvdWFQditYdUhB?=
 =?utf-8?B?MWVtM2owY05OajBkSzhJUmFCcHlQd3A2c3Jjbm1zbGVzdFlDdy9Wc0tsMGl6?=
 =?utf-8?B?SVlrb25UbWlPYkRZbUdIdEJjOUJFN09TeEswWmkwU0JPaDMwUFh0eG1aaXRD?=
 =?utf-8?B?M24vL05vSFlDN1MvMUwwbSszSmplYmg4TVlJRjR4REVjU0o4WFpVMjA5MjBB?=
 =?utf-8?B?ZFZRa2VVeU0yQXFRSzJPRC8rblArWEtQODFKZ2R0b2tvS0dYQm83eUFOem1q?=
 =?utf-8?B?V1Jwd09GUUJ1bVZHL1dtc2JOZDhjSU9MOFgxY2NBMk04L2xDMW9mV1l4Z2oz?=
 =?utf-8?B?L2VqcVo4NmMwNjM1a0JUWitxdTFYZ0xCVGtkYnQyUHhZWDRFSEJudWgza0t6?=
 =?utf-8?B?TkFIcHIva3BxUVZqL1VWOHZJUTNzZ08zZWpHaHFWL0FtemNLaFFzcDcySStU?=
 =?utf-8?B?c29xd2w3bHFOR3lJRU04eWJmdXc1N2tQRmxZVDRtK2lTM3pXMXhWS0txTWVr?=
 =?utf-8?B?V0syRHZQbG5SRnU0VkNzMjNiSlBVeE1QVTg1cjZrTnhJMlZyTWtUL1ZsWmts?=
 =?utf-8?B?WEEvbTdCSXp4bStRS3VDZU1jc0Z4cEZxWDFWcHNXQ2ZORnBEb0JaekR5VnlN?=
 =?utf-8?B?bnlBMmtScW1yZTNEcGVQNEdnWnU4M3Y0VnN5SFdRR3AzZkdPNHhIMXFKdDBQ?=
 =?utf-8?B?ZGtOUklGWlpEMS9NdGVEOTdrQTFiRklrdzlIUEtvYVJrRUVOd2Q3YWpvYVRO?=
 =?utf-8?B?b1lHQ1NYVWgxVlRYUS80b0FJeXVwS3prT3lyT0Qwc3VmY2hLbFZ1Qy9QTTdL?=
 =?utf-8?B?dGE0VDFjQUdjeGxGZUl1eVE5VGFlNCsya2U2bVM1cW1xSFVEVnB0TW5vbVBS?=
 =?utf-8?B?U0NjTUdqSG1yWEpOcnJSb1MwaFY5eFJjaWYyV1hCUTd5K1V6TXFselhrdTEw?=
 =?utf-8?B?N1Blc0xnUXJCZnRuZG5ucDk2a0xnV0g1Y0xYWkxuY2tjbG1CZlYwcTEvMmZi?=
 =?utf-8?B?UjRhMXA4MmVxc2Rxb0d1ajRsYnJPc0U2Z3JWSWRMbWRjRkhPbFRxMlJsN1Zw?=
 =?utf-8?B?M3ZLR0swdHZTb0FkVG9LN3ZDN3RVZ1FhTEZSNmkzVk9GZzdrRENsR2J0K1J0?=
 =?utf-8?B?TmFxd1NZK2U3dEp6WkI4cWVBM3hUdERKSElrWTVFYUh0V2lzWjk3WlA4emhP?=
 =?utf-8?B?NGVZUm1iUVEvQ2RtZXYybXZsUGd5cXhTYUtlaExhUXRtemlGalgxQzdjdnBz?=
 =?utf-8?B?U3gyNUlzVUVEUzkvZSsrVE1BOTdVYzRBajB0M3ZMWFc5UEhKNDZieW00OURL?=
 =?utf-8?B?RUZNa2xZVnF2ZHErV2xBby9Dc3ZjUytvZHN4em95U2phRTBta0dUNGtleTM3?=
 =?utf-8?B?dXVVdkV5UUpaNmNDUEZXSmtzTzM0SVNBYU96Zmk1UmhJWFhmNkVLZlBEekpM?=
 =?utf-8?Q?ZanhVT7f0QpwGETKmb+4jykJ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3103f6-3ec5-4a50-4b5d-08ddf21e1fe0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 17:02:15.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y96O9k0VubTAer1ogVMuYwXxxI9bWXUW4M8Na+Y6qKVDtu5F3w80mRTAx905cPOnjwKT/wt8/uBm4GMURGonZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253



On 9/12/2025 7:14 AM, Alok Tiwari wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The variable 'err' is declared as u32, but it is used to store
> negative error codes such as -EINVAL.
> 
> Changing the type of 'err' to int ensures proper representation of
> negative error codes and aligns with standard kernel error handling
> conventions.
> 
> Also, there is no need to initialize 'err' since it is always set
> before being used.
> 
> Fixes: c51ab838f532 ("ionic: extend the QSFP module sprom for more pages")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> ---
> v1 -> v2
> Made 'err' uninitialized as suggested by Brett
> added Reviewed-by: Shannon
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 92f30ff2d631..2d9efadb5d2a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -978,7 +978,7 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>   {
>          struct ionic_lif *lif = netdev_priv(netdev);
>          struct ionic_dev *idev = &lif->ionic->idev;
> -       u32 err = -EINVAL;
> +       int err;

Thanks again.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>          u8 *src;
> 
>          if (!page_data->length)
> --
> 2.50.1
> 

