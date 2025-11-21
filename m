Return-Path: <netdev+bounces-240770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D696C79A16
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEACA4EAA3A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45B34FF5F;
	Fri, 21 Nov 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v1gUoBGF"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5C346FB8;
	Fri, 21 Nov 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732505; cv=fail; b=u6kPO3xEY1gXZEcX/NRJ95NNLAxSaOg+N0ZaziCScViysDrpI3+JAbjam216nstl7V9Yi4MP0TRB5kV9g+KZdl0f6QXPO1PnwnTogVNzGy/7Y3tDWYf7XcKR6myGwvNOSY+6SWKlhYyJU9IJeOMpM0OUJlCiPxloV6wyd5JuXdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732505; c=relaxed/simple;
	bh=VmIHvJBShYKQse79BD029XNHj6FKa6Xzv++ZSm3aExY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4enfctxWxhrHMHn+LCI3BgX+BhFKBRq/Oc7FFlZy0lU3s7YWPU7/POt7vMK7E2fSTqbNVIS541Cu8cIZPJqIP4CMwfctZcj0iyWB2wefS9kSzj2ZkJBqp/uZAxTpmnOt9U8y5tsIRTAMtRG0I3Qa0NnZg5VFO7F+Rx0/1o9PHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v1gUoBGF; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo6iJDuOs+ugjFEkC9K6Q59Lmok7/soghCOF4f1nAV5SoCcrnn2tRuY0fqDCyCq872y3572l5Rjq5IOpYYoYcmLI6TnYew5XCBzxHXQXT59LepLROamoBNXP3A2cBs9oONPMVZkzNbF2JFhDoUWQveMe+/ok+POQgIdF7D5SKrg+2vcbQQBWwc96UcXhtU5zTXCxgvlzdi2INcAtoWbidMtNCqWhvMTosvIs2OnRSI0me/pCYft6dz86LFLBN0e3hSjro6vbJkkpIZuQHQ71DJieOuot3zq3WJuBzGXP93O18R4pqSMwy2brOF5H44l2Z3HPRFDQOiP9sYQ4yxvRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqVW9BEi0LLm0LbmohxoRoB72nLBlhOtK8vkeauFsVA=;
 b=lDJONalHniUci9DJXdnoGbkJHp8uwQKa5JUtAYSfMTeSHl8QuchJpOX7jdlbgsi5xGoA4YM8w2n2K2GJ9QJIjPiCEUiSf26rhj+HciM5SS8l3OA7EGBoc1GF/tDcoAvnMZIfu3J010AX2TrbXHMUHLjs9qei1q++xmmYtboHdJM6NhPUC35oYhWO0hX1a3KSYl6i8hShgbmg5sp8kq8HjvtZ0qhD+zWx6TeL1ZS2K7TUHnNHZL62YaBe0r013TOnh7nCWVQ+u6S4Lsc0yncR56VTpYoYWSG+I+YMb57migaYCrkkjUljDKn2p7bSl/E3lczODPVErCJUhusxt9pULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqVW9BEi0LLm0LbmohxoRoB72nLBlhOtK8vkeauFsVA=;
 b=v1gUoBGFMsXJw/jBUNPxZfLOP+N6wGM3rIW/ZHUiciS0JqIM4LQSJ78KSPeh6JFcEfqMDTOgkJ4gwzqoi3oESUBeHGb1gDwyJ9UxVZpL1VJMBiqvxmJBqeYQo4DKrrDloYhXcvcH9bQANLZQ9Tpqf2DXWJDSJ7ep0NcQS78khpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 13:41:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 13:41:41 +0000
Message-ID: <8e580ce0-56a8-431e-b371-e8695cfb1818@amd.com>
Date: Fri, 21 Nov 2025 13:41:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Content-Language: en-US
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
 <e507443b-71cc-4c48-a193-f5361a1f9086@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e507443b-71cc-4c48-a193-f5361a1f9086@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0062.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::25) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 286b1c43-96d4-4bca-8fcd-08de2903b3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNMRXZGNi9DVXMvbmFOVWNqc0RnR00rQnRENGc3c1Y5dHhHS1hSSXRoT05C?=
 =?utf-8?B?UVVTcEdpMDdMWGk5U210NTZPWkpXbEJ1VzFZc2lsYnpwZlJxMFVGNmVnMGxN?=
 =?utf-8?B?L3A2TGEyQUV3VUprNlAza3MvSVEzMU5rcjdVR2I0Yk83dzNjVk9ZQVN2N1ZQ?=
 =?utf-8?B?RjkrdnJZbVZsLzFiOUZiaHBPSHRYWW9xb0UybzJaQ3dKbmE4UGNtTXk4MkhM?=
 =?utf-8?B?Ylc5azZSK0lMQjdwSjJIMk5JUThPUC9BQUJRYndJSkZDcW0zSGJ3STFPNFpY?=
 =?utf-8?B?THhNblBjTkhzNWZVQVhsa1NoZmhreTR6WmlwTHJRM3ptUE9SQmhBZjlPTlZJ?=
 =?utf-8?B?NWZrUjdoZnlRSUkwbDdXQXRkaDhoR3lvVUhJMzZrSDd5WlUyK0IzZDZ3OEVK?=
 =?utf-8?B?NGFNZEpJaU5rS1NCWGJKYUd6WWZoMXJGdkVXN2lDU3pWS2FpUVhUdWdrZ0tt?=
 =?utf-8?B?cUJDak1wZytza3RvOEtERTJSYjEydytkLy94dG5ya3V0Q2dCR2wzcFlGNHlF?=
 =?utf-8?B?czBKaFJXeWlOcEFkT3pEckxtVjlNWW1rWVlFeUxYR042Q1pCbXdkMmdQT0lk?=
 =?utf-8?B?cjB2ZVBqR1Z3V1JWQjhYRnpDME9iNHdNRWg1YTJ4eW15YmxaR0xoTFRBbmk3?=
 =?utf-8?B?QkozSlRZRWYrekFqMGNxcGRCQ2Z3SVBKMEEvYmlqM2ZyNEhyeWgvaEZNd3BW?=
 =?utf-8?B?d1JvMHJhUTNMZklPYjZPSXVuOTQ0ZEpja1dtMDNyRnN2eHpaNUh1dDZ6WDcy?=
 =?utf-8?B?UjRwM25sSTZndXBBd3k3N2k4ZEhZZytPazRYRkdmMGZGVlhLUlRROHM3bTlz?=
 =?utf-8?B?aEpFTzl1L29LdWo1dFpDMVBvTnNvNXg4UDFGakNrL0RCaTB1VXJWM1dRU05B?=
 =?utf-8?B?bnlhTGJMOUQzTnZyZzhVSm5PTUNPa2luZ3QvYWpmQXp4aFBsVkRwVzEwNGpw?=
 =?utf-8?B?SnNJSFI2SHFNSDVaN0xjUUpRVXVkeXJaV0VrMUdESjFDZmhjZSt5Q3VaQXUr?=
 =?utf-8?B?emd5WU50N1puSzZMakNNRkh5R0ZUL096azJJTnNoeDRyTStWbUlaWjRrMS8x?=
 =?utf-8?B?d0d2TE9WOCtqMVlyV3k2dUJDNTMvU01sUzhYcWNqa0xjcjB3OE5oeEJ0NjJv?=
 =?utf-8?B?WDg5cytDdjIvYVdyb3RidFU1cWpsZHNoVWFMUWpCbFRNK3dzOUMvUjY2N2xr?=
 =?utf-8?B?VkpJVWpiWW8xaEt4cUJ5MENuaVRXV2xyNU1sTlM3azQwYUswQnNEUm4wUFlT?=
 =?utf-8?B?WllqNWtIMU84QnlwTXF0NElwU1IrVzVZZDhwblRrQ1NrMXduREVtbE42OWZw?=
 =?utf-8?B?c3IzUVlPcGFkTGlBdXhJdWVxbXVBL1JkL1VYWFdnNW9xV2Z6TWNDTXBudEIx?=
 =?utf-8?B?NUVnSGdScDlnOG5DTFpxTG9CVHZycXJSL2pkRjN0dWhxdStrK1FvMmM2UndU?=
 =?utf-8?B?Q0I1R0JZMXlGckxMSGVlaHZNUFFMVk8ybGtKQ1VheVFITjRiQnA4d2ljQ3Zl?=
 =?utf-8?B?VXNkUU1jTmFtaVZqV1J1Zm9SSjc0eXlTdHlYa1pmQjZDenptNFdXaVNSellH?=
 =?utf-8?B?VVlHRmo4YVM0MWtGWmhZeEptN01wbUhRYmdqZVQzSG94M0N6N3I1S25GbWV5?=
 =?utf-8?B?ZVlZbGJHZG5LY3JiUnl1dDNwTHZsb0lSUzZlNWhnZGFNVDM5aUNsZjFlajRZ?=
 =?utf-8?B?eDYrdXRudy9BTW9QaDZibGc4UXJhdGMvTks4NjZ6ckdXN0hnQ0VIUTdIUjlH?=
 =?utf-8?B?YitXamY3ZEROK0pSTmMxaWE4NitRWFlFZk85aEFIVnE3cFVVeHJqQ2FLTjdu?=
 =?utf-8?B?L2NrS0FEaUZMbmxuSytpSEp3eGVUN2pFZklxZ1VmVE1zTXV1ejk3Y0QvY0ll?=
 =?utf-8?B?UE5JTDFJeHpITDB0Vm14aVk2elNGZmJWTkNSdHRoRjNvQ2t2TzVWRTAzV0s4?=
 =?utf-8?B?dDJFN3lmVmFRa1p4cXBEWDNQSXNSN0xUeWNBY0JEa3FvYUhQVEp5SHYrUWtE?=
 =?utf-8?Q?3c9nwy+uIuMKll3HY6aTMK5VsQWHrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGxTL1VQMkQveEZybDJUdjZTMGc5bnJESzB6NWRraHhqRGJ3NU9uMW5hRlQr?=
 =?utf-8?B?UXFCYlVrU3Nvd0NIUldKSGtrb1orNkJtNE5MRm1CNnFCSmpXdHd6UFdnMVdI?=
 =?utf-8?B?ZFlpMWVNRERzME4rVzU2TVdmWDlyeTlWdy80SkJmVnVQMGozd0pEa2h0QnN4?=
 =?utf-8?B?b1BSREhSMDZvMkhjSVRRVVp4NzhjVVJTM0JUY2NvZmMzZDFvbmc4SUpIY1Ix?=
 =?utf-8?B?VTFhTzY3Tk5GQVdoc3Y4OW14alBQazFpVXZpNGtjMXJoS1hmZkxCajN4b2dR?=
 =?utf-8?B?WWlpR2RtSURSeEM5MzJ5M0ZrZ0FMa1Z0NFlORE84Z1RmK3o1N0R1dERoTExR?=
 =?utf-8?B?NHA2TXo4V1F4SXppQkRQYVozdFRVVTN3aWJQQzZxYWdjc1JvNlJvaW1kSjZi?=
 =?utf-8?B?U2lJSm9JTEoxZTEwYzRrbUFURmQvOERpaFc2NEFkd3UvelcxMnZzdFJzYkZl?=
 =?utf-8?B?V3FQOE91VUxjUnV3S1FrRzVLK2hyWVBOZ1NKVVo0SDVmbUNKMlFqcUkrMk9n?=
 =?utf-8?B?by96N1g0a1BaZlJ5N1FiK201cFZlTysxelZNYnJjTlRzT2NKbXJRbExaNmNz?=
 =?utf-8?B?QXRzNUc5SmdrSmpGUW5sTXl1Ky90K2ZZOGhjRGhodGJNdUlIMVRERUpLS2Nr?=
 =?utf-8?B?Wm94RVRobXVUYjk4ZlJRK3R6QUE3NUh3aWlOT2lkb2xyUTVxdlN1cS9ZWkZB?=
 =?utf-8?B?Nms0bThPTnpNd3g4K2ltNWtnVWMwTjR0d1htb0tTM3JMdWNMUHV4c25uejU2?=
 =?utf-8?B?OEVoYUpKUFNNdlpMK3BSalBaM01zMWZxZFlHbmlaclpmVTdOVVZZZTNMRi9F?=
 =?utf-8?B?ditXVTVuQU1vQVpQanY4TWdjdFprRHZ2TXd5T1RqU0plWkNnTjdBaUFqTDJR?=
 =?utf-8?B?aStBenRjN0dQTWplWjFnanp3N3F6NVdjYXNKZ21ia1lhUEhwUnRFZUtmVmtN?=
 =?utf-8?B?UDN5UEE0WVFUR1VhYXpEaXV1WjNIeUg5VFhzNnhhUzlRSWIwMjVvaHNWbEdr?=
 =?utf-8?B?S0MzWTArOWhaVlVjU0hjdFIzYWFLNUcxdFNkS1FKbzUzYm5JOW1uS2Voa1JB?=
 =?utf-8?B?NFQzWmJGYmtrUmwvUU4rVEsvcTdjS2FqaXNtT0RrV0x6SkFIc0lkcTJCTHlk?=
 =?utf-8?B?S0pidnowY0kzYzBZeWlDbWw0MlpFWWQxRmEySzg1ZGRpWVlCcXEwY0d2TW1O?=
 =?utf-8?B?Y1NLRTNjdnZ3cGs0UEVKZHpDOEZOTkh4dGxCcEpEaHVoaUR0N1hQV3RObkdS?=
 =?utf-8?B?dkZSMVFTaUpray9WS05MZEZwSWU5SG1nZHVjYzQzb29zeFVnZzlaUGh1QnhF?=
 =?utf-8?B?K09ZMkhHYkVBcnVabDl0d2pKT3UyYnRhTUJzS21IenYwUExybWFLa2RhWTAx?=
 =?utf-8?B?MEY1OVY3emN5M1JzQldpdThrVTNPU1djTnpJK3NjSEFPN2dsOGJEREM1SFFO?=
 =?utf-8?B?aHAwbGZMemhITzRQZ2ZkTzZ5ZGczMU5OYVNuM2dhZVlsd0pKUDF6aWRKU004?=
 =?utf-8?B?b2hrYm5mUEllMmZYdDE1bWQ5MUlWUEVBQytpOVFBc3ErRXpWSmZrS0w0Y1Rh?=
 =?utf-8?B?Um4xWFM1QUcyRGUyZnUwTEJOcGhrZ0RvdEI3SlZtL1ErNUxVNjd5YklBYVdn?=
 =?utf-8?B?YjIzNkw2RlE5ZVBXTytkazFROEdSYWVLTXNiakxQa01lMlA1cFFsRkdzYUFm?=
 =?utf-8?B?TkRJd2pxQ3FTcU0wNlJBZFRtakpJUWJKM2FqRENTRDdiamdMSmlJYnJQWG1Y?=
 =?utf-8?B?cnJkOXhnbHdSOFZ0YkF1bGV0anExdTJzT043c0Vnd3VCMVBGeFZ6cHVoMnU4?=
 =?utf-8?B?VzFLMVFFQ1BhRHNQcXFDcWtEeDdPeU1FRUNhN0RvNm1ZdytkaFo0Z1JLd2xE?=
 =?utf-8?B?dzRIcS9WL2NCOXppNmRzaXcvNTA3Q2xweEdINE8yc092aVBOK1RleUxhcTdS?=
 =?utf-8?B?YzN3ck5Nd01OQVJoUmpyT0htUGVhbGdwdFVEN3ZaaUxZYnlITGNsNWt3M0Ry?=
 =?utf-8?B?amtQVFhCZzFnY3VHWHZRSmx3aTRtS0JFRmNmcmhPUWJEbzE4MC9GVkMzdmM3?=
 =?utf-8?B?YzZtbnZUaGNPZUVhTjZSQlBTL3Rjc2RWUW1HRjV0anpsNjlQLytPclhCbnJq?=
 =?utf-8?Q?isGyGxMEi86ucjxZ6lFWmuJEM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286b1c43-96d4-4bca-8fcd-08de2903b3b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:41:41.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yRXlLZn/568jI2D+Qy8wGhsvMeAFJd4T66HyHtmnBHmrJmhEoc2MospRmTBx1/VV2LBrh4g7ALMydrSANfa6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996


On 11/20/25 20:27, Koralahalli Channabasappa, Smita wrote:
> Hi Alejandro,
>

Hi,


<snip>


> On 11/19/2025 11:22 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> +
>> +static void __cxlmd_free(struct cxl_memdev *cxlmd)
>> +{
>> +    if (IS_ERR(cxlmd))
>> +        return;
>> +
>> +    if (cxlmd->cxlds)
>> +        cxlmd->cxlds->cxlmd = NULL;
>> +
>
> This series caused a NULL deref in devm_cxl_add_memdev().
> __cxlmd_free() only checks IS_ERR(cxlmd) and proceeds to dereference 
> cxlmd->cxlds.
>
> Adding a NULL check for cxlmd fixed the crash in my setup.
>

Yes. Believe it or not, but I 'm pretty sure I added that after the 
IS_ERR check, but it seems I spoiled it with the refactoring.


But thank you for reporting it. I'll fix it in v22.


Thank you


> BUG: kernel NULL pointer dereference, address: 0000000000000358
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1553a7067 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:devm_cxl_add_memdev+0x71/0xb0 [cxl_mem]
> Code: 89 c4 e8 c2 c8 be f8 85 c0 75 17 48 89 de 4c 89 ef e8 b3 08 f9 
> ff 85 c0 75 08 45 31 e4 45 31 ed eb 08 48 98 49 89 dd 48 89 c3 <49> 8b 
> 85 58 03 00 00 48 85 c0 74 08 48 c7 40 08 00 00 00 00 4c 89
> CR2: 0000000000000358 CR3: 00000001553a6002 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> cxl_pci_probe+0x409/0xb00 [cxl_pci]
> ? update_load_avg+0x83/0x780
> local_pci_probe+0x4d/0xb0
> work_for_cpu_fn+0x1e/0x30
> process_scheduled_works+0xa9/0x420
> ? __pfx_worker_thread+0x10/0x10
> worker_thread+0x127/0x270
> ...
>
> Thanks
> Smita
>
>> +    put_device(&cxlmd->dev);
>> +    kfree(cxlmd);
>> +}
>> +
>> +DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
>> +
>> +/**
>> + * devm_cxl_add_memdev - Add a CXL memory device
>> + * @host: devres alloc/release context and parent for the memdev
>> + * @cxlds: CXL device state to associate with the memdev
>> + *
>> + * Upon return the device will have had a chance to attach to the
>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>> + * (hardware CXL link down, or software platform CXL root not attached)
>> + */
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +                       struct cxl_dev_state *cxlds)
>> +{
>> +    struct cxl_memdev *cxlmd __free(cxlmd_free) = 
>> cxl_memdev_alloc(cxlds);
>> +    int rc;
>> +
>> +    if (IS_ERR(cxlmd))
>> +        return cxlmd;
>> +
>> +    rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>>       if (rc)
>> -        goto err;
>> +        return ERR_PTR(rc);
>>   -    rc = devm_add_action_or_reset(host, cxl_memdev_unregister, 
>> cxlmd);
>> +    rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
>>       if (rc)
>>           return ERR_PTR(rc);
>> -    return cxlmd;
>>   -err:
>> -    /*
>> -     * The cdev was briefly live, shutdown any ioctl operations that
>> -     * saw that state.
>> -     */
>> -    cxl_memdev_shutdown(dev);
>> -    put_device(dev);
>> -    return ERR_PTR(rc);
>> +    return no_free_ptr(cxlmd);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>   diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
>> new file mode 100644
>> index 000000000000..50c2ac57afb5
>> --- /dev/null
>> +++ b/drivers/cxl/private.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2025 Intel Corporation. */
>> +
>> +/* Private interfaces betwen common drivers ("cxl_mem") and the 
>> cxl_core */
>> +
>> +#ifndef __CXL_PRIVATE_H__
>> +#define __CXL_PRIVATE_H__
>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
>> +int devm_cxl_memdev_add_or_reset(struct device *host, struct 
>> cxl_memdev *cxlmd);
>> +#endif /* __CXL_PRIVATE_H__ */
>

