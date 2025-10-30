Return-Path: <netdev+bounces-234502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA5C22188
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F2C3A6BFE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B964333447;
	Thu, 30 Oct 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kmIAmpkd"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768832E136;
	Thu, 30 Oct 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854248; cv=fail; b=r6QibfZj6NwAdPPQDzKofa3C9esgMETSk6UT4h7Foci5XrHN3atCWXgdqwLCHt54MecHFkSPY0Gmb1Ndeq7hiHbeTraIUekGZK9Cm4NUTSjR7qzfud0gFU3sZ3LA3iEu6oLRintYInM0G9k6ckXLQc0sUgzO39NkVpUD3dQgwOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854248; c=relaxed/simple;
	bh=dmrxbTA+KwE8/TUFPCv7J2K/8T+OkwiHNPxNbKF8O7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XuKRRuP3zw+1lDAQSJns4c7sfoiblqcPLRdLM3CXPa32J3JFZgiVGyOA+goI2Rdr60Z1SJyiW9NKZ76GUY2/ZhMwPDFHXcMXQSRC567LaySl2b4tvoC98YuZsvWP70wCP0kWRJfiQw6FlvnI93Ni1iYT7Sm4MvMY6Wp+p8A3nJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kmIAmpkd; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9FG6GwBiGNTijvav2HlOH/jgysMTrkXO2ulynIK8puP5Hb76uE/3yIpMOMod4w+sHe6GgOn44Cf4XuTkc6AY30Vm0LJBA1jgarRMQPl/zyvvmn4W2fuYrUlbPTP06cyKOpXjaNzZTLhENOt7oot/0Y8pQICoapnOjw8yybV45o9wz5L6rxf3CrbWvoBDGkhg1ziyH470lCr4lWQxF8MiQdWZkqzMixy+9nPxJEOEG1p6E+iDK5t7uz5GFbFNEQyP7rk0nnNZC50FgGUPGnUPz4FsMBdhzVNyNfJP+sDzUv2pjNaczFtUo9mOZP4IbceTP99s7BmvsjArrfAb18fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP7nhQKSMDGwEN8ndnVSeiNqmSOPilPojjlDQvcwrTE=;
 b=LRLzapod4CisdNFP1sXUvUYENfCeRFWJ2pk2qsQrrz6282+C/xE+twmxLfZzEONc7+wvlpGNkZxfm03k2I0JLelsywwz5Mpz36lUKFdPCUXkDH9hI2R60n4MIpuZA7uDpkwV0rvr6ss1Qpxv0e5rI0eFgV+YGUZw68dU73ZloO/AImuEYx1hjbBNJD+AmXmuJpz9kMEAZM9YVq97XMaa+uO0eJ/zmryS2+MtQbY++UgvMa3ewij1J1rs3knEShGAA7QoGqtswRYs2Fvqmx9BeAehWAv6ROc4Q4KSgKP2qu7bLVxOCcv4Q1SJh8QGdNE59Jj6x6+3hj3k8olpEvcvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP7nhQKSMDGwEN8ndnVSeiNqmSOPilPojjlDQvcwrTE=;
 b=kmIAmpkd5F23UG22IKNtyLsRxBxoQ9Xf9KCMUvVufjCa+5fetjAKEMwul2sabKPNMRWMr4DuRvDsh8e75Dd5xqIF/w7IuaE5lINDmBS0yXIXsfEd9YM3SNX5pT1WGkeGK07eHOlnpxvyOn97I3bu84VBUX3lV7USKSYwut0FbIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 19:57:23 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 19:57:23 +0000
Message-ID: <030a36b6-0ade-4ee1-a535-9f01b15581a6@amd.com>
Date: Thu, 30 Oct 2025 12:57:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
 <20251007134053.00000dd3@huawei.com>
 <801f4bcb-e12e-4fe2-a6d4-a46ca96a15f6@amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <801f4bcb-e12e-4fe2-a6d4-a46ca96a15f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 211b7e3d-4ba6-4830-1be4-08de17ee8a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czlVbXhmY3I3WExOaWc0eWJOV0RhY2huTUdaUnU1U1dTZlI2MmtFLytqRTY3?=
 =?utf-8?B?Y1BCNXNwMXY2eXppM0xmWWhyRGxZZEljTEhGZ1ZKMkV5SS9WeW5ETi90dml6?=
 =?utf-8?B?QU9wUmFna1ovenp2dHhSVTljS29DNDZhbnJJSzVEMG9pQ0F4VCt1eG9TUFQx?=
 =?utf-8?B?T3RSVi8xY1FacjNJWmd4TU0ya0FkbUZPa1h3eEw2ZURGaGZRUjVjeWI2Y2tP?=
 =?utf-8?B?RjkzSGQ2cDM3R3Y2SVVkY2dVZHY1N2V6ZzlKTXByd3U0NWRwZDhCSXlBS05w?=
 =?utf-8?B?YWJTTGF6K20vNkZ0Zi9lWjg2bVdkNUI2YlYwRmtRdWIyU1BsTVI0MHdOY2JJ?=
 =?utf-8?B?cVJRRTZnNUx4RjNiUG9OMSszTFR4QlZuUDdYbU0xYTB0VjRCNkZManNzVFl2?=
 =?utf-8?B?Ni80TjFYMHVzcGpCVUtzNGlwSGlqMTNpcWZFcFNxeUs5QUlGZnU5djFjSlRK?=
 =?utf-8?B?UlJWOEFaUTByQ3FPcm1KbzBwMHZBNkdXOHR4dGRvVGQ2ZXZlOExrdlNJRzNj?=
 =?utf-8?B?N1ZaVGllbVVBYjlmRitGUW0rS3JHRXo1UE1iclcxTHVSbCtUd2dNWm82dUxX?=
 =?utf-8?B?TmVHSnV2TjJ3cjRFTkZrUWVtQ2FHS2NBWVJ3NG15T0gzTjJ0Y0t4UW1aVTRk?=
 =?utf-8?B?aC93TWRNc21rZDg2ZjBzbDkzUHBsRVcrV1VEYnFlSGJiSXltcVphdlVCVm0v?=
 =?utf-8?B?WjNPbFhSTWJjdUlQdEtzNzd4NEdWUmZPOHJRc3Q2VHUvNzVqcHdhUzh3SEdU?=
 =?utf-8?B?WVljakxGVC85VXJra3dETzBUU1BCdW8vcU54U1RDU2JtelVXNFBUKy92NHZR?=
 =?utf-8?B?VUsrWDBadi8rYUV4VkE5cUFBSDNZMnRHYWlEKzlxWnVaSWNwcW4vRWt5dStD?=
 =?utf-8?B?ZXIwcFlLWEN4QjJPSEZLVE1WMlF2anl2Y2dkNllGZXBPM0J1QTNRd2d4N2Fu?=
 =?utf-8?B?L3dNOTdQT0ZodG54MmpFQkQ4QWZzMjNET3BBNHZTdE96SWNTR3djWWdvNnF5?=
 =?utf-8?B?SDJEamErUHQzendsYkNiRC85aWZleUlvaVhxZzl2MFFYdFBiako4WmFBTTFO?=
 =?utf-8?B?L0I1NVdoK3hBOU0wZDFtRFFtTlBLY0p1Q21kZldDaVNXVFFsZ0l2VGNrTXEx?=
 =?utf-8?B?a25qVXpZVlFxTzVRZEVqOXRUTi9iQ2E3OHc1Ui9aaWdzbU5ZKzZVU3MrVjh2?=
 =?utf-8?B?bGhIODArOXBoS1RweDlKeXFNMGZsYnpuc0taWmdPcFNodFQ1TWl5OU9nM3kz?=
 =?utf-8?B?QzdNN0tOdkpUcVVnSURGWUZlVVNRckl1aE9PQ0p0dCt4Y2xodFY1NjFyNU9N?=
 =?utf-8?B?Y25wb2FhUTNoU1VKTnJjUk1leUt3Um1xVmdGdVFyYVpMck83OXZvWEllQTlD?=
 =?utf-8?B?TzdzTERIVHdkd1ExM0RjclF6M2pEcXdNaC9sQ0t1VWtNSCtudEllZW4rSDcz?=
 =?utf-8?B?cmNTWXo2RE1LSEt6OXpQQmhKcnlxNUxQVis2TUdKd0NMeUtwZWpzM2pxSktp?=
 =?utf-8?B?WXgwMys5YUV2SmFoZFE0TEdoRzFIOGNieDFyOHNTMkRZVkMwY3ZmNm5RSEgv?=
 =?utf-8?B?aUlGWktqMDJ0eHp1WFZNd3dPOVY0UkNxVk0rdTM1ckxSNFJNQ09kK1FEMUd0?=
 =?utf-8?B?Y1hVNThqVXdVejZNT3VCUU1jc2ViRHdXbC9yUGNMZzVDcFhUK09LWTQyMWti?=
 =?utf-8?B?cndDUVVEeE5SN09zYk1VZGRTd1BuT0JzM2FwTVpORTVlZys2N2pPWitWamxT?=
 =?utf-8?B?ME1xT2lzMUN3SEZUTEVtQmZXVEhjMmlCc0FVc0hLNDBhWHVBcU9QZ1ZPWTdy?=
 =?utf-8?B?RkgyYmMzWndFY1hSTkdaUTI0cXdwRjE0WCtBTk5ObXhlL25Pb0J6cTAvYWV1?=
 =?utf-8?B?LzJ5VW5nUEw5cWErdDJhTEI4RFZKaG9qL1NBdzRxSDdMTnR1bDlqdHh3OGhF?=
 =?utf-8?B?eFRHaEpwVVZPNkxJUkZUNGhjTzZVTVVkUDJacHBIN1NPZ1g5Q3VPTDE0d3Y0?=
 =?utf-8?B?QWF3Mll0dWN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEc4bzZHMU5zUFF2TTRxRDd6STZVdEJlWjFVZk9ETWI0U1FjRFRiTWx0SnBj?=
 =?utf-8?B?SnpKWmVsV3BMZUVsMEVqQW1uYlh3N3BpcWc4blBianUrQi9TVm1mbm1LQzI1?=
 =?utf-8?B?YzVqTkY1SmVlb2xEalVHUXhpWks3OUpTN1BVYWJrVXpTV0lrSnY4eVRYc09Q?=
 =?utf-8?B?SThZeU11blFucklBT0RkQXlVdWhTbDcyUFRJZGI4cUtqaENjRkpTTEErTEhD?=
 =?utf-8?B?STlBZ3R3MUJ3TGYwUnprRUdDMkJLQUIxYW40anVnYS9DWWRydFlPQStZNEhr?=
 =?utf-8?B?RktZMlpleUtYcUU2N0dQdE53b1ZQdXh4WXpFZk5ZV0R4YjZNQVBIT2FTclRh?=
 =?utf-8?B?ZGlsWktGZmJlcXZEb1JwdThyYk5uNnNiV0tnQmw0eU9qNG5TNlJRNndwam40?=
 =?utf-8?B?M1JEaFd1VXgvUWJ2MzA1S0Y3TGVvd05hajFTam1pdndMbVo2TjFXclZPUzZF?=
 =?utf-8?B?dGpYK0tmaVlaYUxSYnFOTWN0azhrdkJKUHllNGZhSGxMTGU3WXRPRmswUmF2?=
 =?utf-8?B?K1Y5UkwvQVloNEVnUUh0a1lHTi9RUWZNNGxjT2NiN1YxZWhkSU9NYk1TY2xm?=
 =?utf-8?B?emUvNWpGMlRUbWRveWg1UDdKaFpHY0FyUE9EQnd2WnZqQ0J3QzlhN0JlRURi?=
 =?utf-8?B?ejFrZ0kxS2pJTVhYdk5WVzBkclRoZEE5ZVNzWUpPSUVCa24vNER6NXZSUmU0?=
 =?utf-8?B?aTlJSC9vUkRGejhKUmVjOEdZc3k3MmlRYXlVWTNqSjJHbnpmd1dnSEN0anFV?=
 =?utf-8?B?WUxVd1RmaUU0c0RFbmY4NkFrcGtFR2V5a1Qyc25oeDR5V1NmNFVRYlBJd2J2?=
 =?utf-8?B?WEVkd0R1WEl2ZTI0WG53UFQ5UUYyaWxKUG9rUHV2ekE0OTVBSEhkV2hFM1hF?=
 =?utf-8?B?S0dZeGtuVTc5MlVHY3RJbHRJeittNDhubERPRlg4WWNFV0d1MnpMQmMyVkxp?=
 =?utf-8?B?QU5hcnBuRzQ5MTgrNlkyclRSSWZXbzl6V05vVlllS0FicDlwMlNORFZwYk9E?=
 =?utf-8?B?SHFNQmtIUjVpamw4cDY2bXBRK3FKclVSZ0pQeHNPVUE1cWNmVS9UQ1l5RlN0?=
 =?utf-8?B?bXlWRHpUN0tUY1FVMmtiUG96d01WV0ZzSGhtRVR0bHYzemlUQUNXSXVxM0o2?=
 =?utf-8?B?UWcrZjZ4NUZDRklrd2Q3YUxTOVZHY0dUMm1NRHRlSTBJV29uMVZvM0ZVZnZU?=
 =?utf-8?B?ellaWkRFdGxOempFbHZxUEF0MzJqcmtJTDUzNnJGcnVQR3ZHNHVHemVzaDlm?=
 =?utf-8?B?N0JrSWRubS82QVhhZFBVSysyQnE2U1NlK0ZxbWtaakV1ay9CWndmaklHbkhL?=
 =?utf-8?B?TzRMZnhTODNSTXlBdW5FUVhtOFMwd3d3dllhZmR1WTlZVjJxd01rVjVUeTRQ?=
 =?utf-8?B?OCtJMFo3YTlxMEc3V1FGbzhtRkV2ME16LzVkQ2RYUlY0dDdPMy9KNlVCbzgx?=
 =?utf-8?B?NTlxVUNYb1gvdHVjaFMvdS9NZlBKYjZadDFhK0tFZkV6dTFuZUI2TEpUb2ox?=
 =?utf-8?B?ek1sZm1sUWtMOU45M2lvTkJMRzY0REJRZ0JyU1dzZDR1eDNzUlFoRHlOWGlQ?=
 =?utf-8?B?VnZpT09HQmRyU1pmQnlwdm50c0ZNczVMbStxSENEY3dqakRoTm8vU09LamJi?=
 =?utf-8?B?MHJmYXdHaHdiR3dOM1ZvSDJhbWtXSHhBdlhyV2lFOHVHQ1RncFVCcEVVSnJk?=
 =?utf-8?B?TUtlNjZXMUlIc2NOQTlTZ0hTUzNwSU42K2pOK0pSU09CcXkzRnRxUmg4dUdR?=
 =?utf-8?B?c3d4VG9BYnZPUkgrWitZcHQ4dys5T0VTQTBWak9KTVI2eGpZcHphNXBYUWlJ?=
 =?utf-8?B?ZHNmWUVXZVpsQ0o5cDdDaXA5b1FGcUdBZFdJbUloWWpsa01UNWhSR09TN3Ax?=
 =?utf-8?B?U1dnY0FUdEZNcW5iZUlmLytBcU1VV2pHbW9ZUmRIZjBUanpwOXNkbEUycUVL?=
 =?utf-8?B?TVN3R2t2QU01ZXR2Q0ZCYWxRdmgrNU1yM0VnTHlkOHQvR0tVR2k1elVOdjVR?=
 =?utf-8?B?eG9vOFFXTnE2Z0ZuTmFLR3lMU1BzcHlqalhrbnY0clR0VzhqT1FmTmVJUFNC?=
 =?utf-8?B?ZUNLeElzemk4Z0d5bjREQ282QVRyVXF2RHptQ1RhUjI0c2JKcjV2ZGxxaDhZ?=
 =?utf-8?Q?WCce4jttWlqWEhLrxkUyl6Q0s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211b7e3d-4ba6-4830-1be4-08de17ee8a9a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:57:23.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gJFqOCfSKDqusnrbzPHTAK7RPk+F7MqSykRnnGiSDZMoSWgnMAPSmopHNBPdRxs667h1iaAukTN9hJjt/HTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Hi Alejandro,

I need patches 1–3 from this series as prerequisites for the 
Soft-Reserved coordination work, so I wanted to check in on your plans 
for the next revision.

Link to the discussion: 
https://lore.kernel.org/all/aPbOfFPIhtu5npaG@aschofie-mobl2.lan/

Are patches 1–3 already being updated as part of your v20 work?
If so, I can wait and pick them up from v20 directly.

If v20 is still in progress and may take some time, I can probably carry 
patches 1–3 at the start of my series, and if that helps, I can fold in 
the review comments by Jonathan while keeping authorship as is. I would 
only adjust wording in the commit descriptions to reflect the 
Soft-Reserved coordination context.

Alternatively, if you prefer to continue carrying them in the Type-2 
series, I can simply reference them as prerequisites instead.

I’m fine with either approach just trying to avoid duplicated effort and 
keep review in one place.

Thanks
Smita

On 10/29/2025 4:20 AM, Alejandro Lucero Palau wrote:
> 
> On 10/7/25 13:40, Jonathan Cameron wrote:
>> On Mon, 6 Oct 2025 11:01:09 +0100
>> <alejandro.lucero-palau@amd.com> wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> In preparation for CXL accelerator drivers that have a hard 
>>> dependency on
>>> CXL capability initialization, arrange for the endpoint probe result 
>>> to be
>>> conveyed to the caller of devm_cxl_add_memdev().
>>>
>>> As it stands cxl_pci does not care about the attach state of the 
>>> cxl_memdev
>>> because all generic memory expansion functionality can be handled by the
>>> cxl_core. For accelerators, that driver needs to know perform driver
>>> specific initialization if CXL is available, or exectute a fallback 
>>> to PCIe
>>> only operation.
>>>
>>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>>> loading as one reason that a memdev may not be attached upon return from
>>> devm_cxl_add_memdev().
>>>
>>> The diff is busy as this moves cxl_memdev_alloc() down below the 
>>> definition
>>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>>> preclude needing to export more symbols from the cxl_core.
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Alejandro, SoB chain broken here which makes this currently unmergeable.
>>
>> Should definitely have your SoB as you sent the patch to the list and 
>> need
>> to make a statement that you believe it to be fine to do so (see the 
>> Certificate
>> of origin stuff in the docs).  Also, From should always be one of the 
>> authors.
>> If Dan wrote this as the SoB suggests then From should be set to him..
>>
>> git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"
>>
>> Will fix that up.  Then either you add your SoB on basis you just 
>> 'handled'
>> the patch but didn't make substantial changes, or your SoB and a 
>> Codeveloped-by
>> if you did make major changes.  If it is minor stuff you can an
>> a sign off with # what changed
>> comment next to it.
> 
> 
> Understood. I'll ask Dan what he prefers.
> 
> 
>>
>> A few minor comments inline.
>>
>> Thanks,
>>
>> Jonathan
>>
>>
>>> ---
>>>   drivers/cxl/Kconfig       |  2 +-
>>>   drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
>>>   drivers/cxl/mem.c         | 30 ++++++++++++
>>>   drivers/cxl/private.h     | 11 +++++
>>>   4 files changed, 82 insertions(+), 58 deletions(-)
>>>   create mode 100644 drivers/cxl/private.h
>>>
>>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>>> index 028201e24523..111e05615f09 100644
>>> --- a/drivers/cxl/Kconfig
>>> +++ b/drivers/cxl/Kconfig
>>> @@ -22,6 +22,7 @@ if CXL_BUS
>>>   config CXL_PCI
>>>       tristate "PCI manageability"
>>>       default CXL_BUS
>>> +    select CXL_MEM
>>>       help
>>>         The CXL specification defines a "CXL memory device" sub-class 
>>> in the
>>>         PCI "memory controller" base class of devices. Device's 
>>> identified by
>>> @@ -89,7 +90,6 @@ config CXL_PMEM
>>>   config CXL_MEM
>>>       tristate "CXL: Memory Expansion"
>>> -    depends on CXL_PCI
>>>       default CXL_BUS
>>>       help
>>>         The CXL.mem protocol allows a device to act as a provider of 
>>> "System
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index c569e00a511f..2bef231008df 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> -
>>> -err:
>>> -    kfree(cxlmd);
>>> -    return ERR_PTR(rc);
>>>   }
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned 
>>> int cmd,
>>>                      unsigned long arg)
>>> @@ -1023,50 +1012,44 @@ static const struct file_operations 
>>> cxl_memdev_fops = {
>>>       .llseek = noop_llseek,
>>>   };
>>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> -                       struct cxl_dev_state *cxlds)
>>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>>   {
>>>       struct cxl_memdev *cxlmd;
>>>       struct device *dev;
>>>       struct cdev *cdev;
>>>       int rc;
>>> -    cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>>> -    if (IS_ERR(cxlmd))
>>> -        return cxlmd;
>>> +    cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>> It's a little bit non obvious due to the device initialize mid way
>> through this, but given there are no error paths after that you can
>> currently just do.
>>     struct cxl_memdev *cxlmd __free(kfree) =
>>         cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>> and
>>     return_ptr(cxlmd);
>>
>> in the good path.  That lets you then just return rather than having
>> the goto err: handling for the error case that currently frees this
>> manually.
>>
>> Unlike the change below, this one I think is definitely worth making.
> 
> 
> I agree so I'll do it. The below suggestion is also needed ...
> 
> 
>>
>>> +    if (!cxlmd)
>>> +        return ERR_PTR(-ENOMEM);
>>> -    dev = &cxlmd->dev;
>>> -    rc = dev_set_name(dev, "mem%d", cxlmd->id);
>>> -    if (rc)
>>> +    rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, 
>>> GFP_KERNEL);
>>> +    if (rc < 0)
>>>           goto err;
>>> -
>>> -    /*
>>> -     * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>>> -     * needed as this is ordered with cdev_add() publishing the device.
>>> -     */
>>> +    cxlmd->id = rc;
>>> +    cxlmd->depth = -1;
>>>       cxlmd->cxlds = cxlds;
>>>       cxlds->cxlmd = cxlmd;
>>> -    cdev = &cxlmd->cdev;
>>> -    rc = cdev_device_add(cdev, dev);
>>> -    if (rc)
>>> -        goto err;
>>> +    dev = &cxlmd->dev;
>>> +    device_initialize(dev);
>>> +    lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>>> +    dev->parent = cxlds->dev;
>>> +    dev->bus = &cxl_bus_type;
>>> +    dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>> +    dev->type = &cxl_memdev_type;
>>> +    device_set_pm_not_required(dev);
>>> +    INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>> -    rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>> -    if (rc)
>>> -        return ERR_PTR(rc);
>>> +    cdev = &cxlmd->cdev;
>>> +    cdev_init(cdev, &cxl_memdev_fops);
>>>       return cxlmd;
>>>   err:
>>> -    /*
>>> -     * The cdev was briefly live, shutdown any ioctl operations that
>>> -     * saw that state.
>>> -     */
>>> -    cxl_memdev_shutdown(dev);
>>> -    put_device(dev);
>>> +    kfree(cxlmd);
>>>       return ERR_PTR(rc);
>>>   }
>>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>>   static void sanitize_teardown_notifier(void *data)
>>>   {
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index f7dc0ba8905d..144749b9c818 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -7,6 +7,7 @@
>>>   #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "private.h"
>>>   #include "core/core.h"
>>>   /**
>>> @@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
>>>       return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>>   }
>>> +/**
>>> + * devm_cxl_add_memdev - Add a CXL memory device
>>> + * @host: devres alloc/release context and parent for the memdev
>>> + * @cxlds: CXL device state to associate with the memdev
>>> + *
>>> + * Upon return the device will have had a chance to attach to the
>>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>>> + * (hardware CXL link down, or software platform CXL root not attached)
>>> + */
>>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> +                       struct cxl_dev_state *cxlds)
>>> +{
>>> +    struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
>> Bit marginal but you could do a DEFINE_FREE() for cxlmd
>> similar to the one that exists for put_cxl_port
>>
>> You would then need to steal the pointer for the devm_ call at the
>> end of this function.
> 
> 
> We are not freeing cxlmd in case of errors after we got the allocation, 
> so I think it makes sense.
> 
> 
> Thank you.
> 
> 
>>
>>> +    int rc;
>>> +
>>> +    if (IS_ERR(cxlmd))
>>> +        return cxlmd;
>>> +
>>> +    rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>>> +    if (rc) {
>>> +        put_device(&cxlmd->dev);
>>> +        return ERR_PTR(rc);
>>> +    }
>>> +
>>> +    return devm_cxl_memdev_add_or_reset(host, cxlmd);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> 


