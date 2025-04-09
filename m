Return-Path: <netdev+bounces-180896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8DA82D89
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1EA3AFBD5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35767270ECC;
	Wed,  9 Apr 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCq7Y+ov"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BA78F5D;
	Wed,  9 Apr 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219547; cv=fail; b=GagSoIrm5oyDn7KbRtlVJkaNBXJpghwZqNrmTDol/qU55CdalTlkRROqlSxVlhNyvGvtP0emi+WOrRLe4VZ7cVGwY8WGbF9v9N1PVfXpod74UxFqxxa5eHws0k5wAKTOtfGwwcjS3UBLYSzrEvo6rH1fHZBp3++Q9dm25/h4tbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219547; c=relaxed/simple;
	bh=DSra2DEsZTMmBNujOQ2kV64W6N/fJEIVrbo7lBPVhtk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGVLZ7LpR1gdTBtRq+gb0frig8O7TGO3JiAebPT6Vg8M6XqDW08p8QlSq8Ni4WUubDtLgZKON/8w0NI6Y7utkSleBdG79Z2ddYdo8V5hX27hxKPFj67jxikcaGr/6AfEpaQsxWyExums8gduq3fOrbtoJpYnG2NhVlm4Y+fvU9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCq7Y+ov; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmu+ePpSrxq3fvdsSzDqlrIRQu5g8MYJHFCmF5LeEGxiZ4gdZSuiLAHT+pVZVa455xzbVp+vtAWp/Q+BN7qHhuVOp31ouSTFSyyzIt8qItzAZj0A5U1sls4d6aSINUpSpCrdIxpjijXlO9QMcNa6Oc34speRE8LJiAdxpBCYVokrlVWmpZnlOXdzlmN6BVV89PJce4rkchNj7tgQCb1SCZAvdSqc5gx0PK8krx4R6RfDZ5ZmaQtl6Hro0q4N1Be931BZNBre9HiAItY67jGxNWTkxO8vw9w6Q4JuN1gwfIItJGQ/Xjx+r2zLF/HZGO4m48tGMfc18B1W1ryySWFDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onc8ZUzdyKEhPqAXDOzEsB7Tm6AYhRqY9VCBulVe3dc=;
 b=k0ei3d7zDIyDVkx42TI/+9GXn22wMUwfYWEiZF5V17eKAUcahszDdgUu+zxEh3egYpa7OMLSe8UoW9FVaCf9ZfhWDz8mtOQHbtaRPNlkTj1uvLgzuGOnL+vhRtX1BjuqbbC8SR/bJKO/2NIpVC+KqhYRTb/E4LIwAIuBUhukpCxhKPkimUU2a+AAtxr3flGn9L9NEcZlN5wAepnNiDijAt81P3SGj12N1geUGYW3tIWlRzXMZbejVdNt8ggP7FudKD3Ztsa/UCuY1ho+hXrzbK+vQnxg0WPAbF68miCQ2izr1PzcmefP0LO5J5efxqhnNhtS9ji8GlAjsB1ZUymSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onc8ZUzdyKEhPqAXDOzEsB7Tm6AYhRqY9VCBulVe3dc=;
 b=eCq7Y+ovJQ4W2ZPLrLIcQuYz4D9BdymtTTle5lDcyK107m6sFret4rgF/V4oLGCBPagoOnsP0gRuYZNnFOZMw8UZI0WqRENnyDGdoIY9ctOZuM5Yy2yNXrZjKXtbArZVVyZepuSvgeep/s9G6JtUYAgv4VgPtv44dwegUgkeN7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 17:25:41 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 17:25:41 +0000
Message-ID: <5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
Date: Wed, 9 Apr 2025 10:25:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: Jakub Kicinski <kuba@kernel.org>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet, Eric"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 "R, Bharath" <bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
 <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
 <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
 <20250409073942.26be7914@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250409073942.26be7914@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: ca445da9-85f1-4802-282b-08dd778b8d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0FJRHdKcEZqWDd4T0dYRXlzUWkwTDRRekNwZ2dUalQxZllMS1p4ZUJWSHRv?=
 =?utf-8?B?Y3hPMUF1elFNMDU5cWYyZ0VjQ3V0bkY2cVM4aG5UV0pPeXFVbHdRTktDdkVY?=
 =?utf-8?B?THpBOFBaQjVsU2lzTk5xMWJUYVk4TWhUZDk1azMzZUI1NUhRU3pOZFI3b1JG?=
 =?utf-8?B?aDMrZ2hGRjBvY2o1RUp5ekVBV1RvRWRjTTFKRmdJRi9zSEkwYjJUcUxKWkg1?=
 =?utf-8?B?WGFETnpYN25uMEYwMnVNVnpuOWVZN2RXK0R4MEt6QUdENUlSNDJvMUtndmxp?=
 =?utf-8?B?djd3bkZOZ3hLWkRQVFgxeThYTzFDYSt4bmI0SVhQWkxlbE1pRFhEUnhnNFdZ?=
 =?utf-8?B?R2JOVW44OTRwTis0dE92bmlJeE1uQmhEU3RzT0pWN1QwaitEbGYwb01VVXQ1?=
 =?utf-8?B?d2k0VytCbUhwQ1c1QjRJLzBlemdqOHV0WjBBYmxMMFFJWjkwNzgrU2tLdGJ3?=
 =?utf-8?B?Z0VpTmI1cDBDaUZwaEViY3RlVnRURkd5emY5bGlvdUNJUXJBUjBFbi9mSW1S?=
 =?utf-8?B?ZE16dXlnVTlnbWpvYy9WS2MrOEIyRGhENlZKRUgvL0ozMmw4Z20yZlVNVG44?=
 =?utf-8?B?ejZ2d3ViU3A1YXM4dkNEMWFyK0I0dUtJR0I5UWRmRnlaZTB2TEZPb2VhMTU1?=
 =?utf-8?B?S0V5NXJGSDNkSXpBaWxBajRBWmNvamVBd1Q5TnlMTHJjRm1Hak12ZCtFS0Fk?=
 =?utf-8?B?NkhjQzFJNks0TERGaVYyazBZTEltbk5xMEUrNmpwTi9JNFkrb284N2YwVnNC?=
 =?utf-8?B?eEs3S2V3a3VMZzFCTkVrRWhOUitpN1UwcElKMnVESUwvTSthUUpWZWdsQytt?=
 =?utf-8?B?ckU2SkZBMWhweTl2S0t2bHZOekJIS3ZmK3ZSQmZaQ0d0U1FNK0dST0s5azJy?=
 =?utf-8?B?dTkzSCtWNTFxSnFwUWhOOEtkdzhvdldrTlJBUUVOdHg0c2g0TWtCdCtoTitj?=
 =?utf-8?B?VW1NK1QzNGpwaDhhMWd4Qi8zdU9JUEQyWDAxY00wQ0RXcElsWTZkUEs1L1ZR?=
 =?utf-8?B?MFp2UW5tNlA4M2NjTUFlSGZCMmRXaG1BWVhPRFdUczZzTGpDUCtHYjM5cjVP?=
 =?utf-8?B?TVVsN3c4ZldWTjg4MFIyOENtVHFoVzZhSVpqenEwWSt4anZKaHBuY3FUY0NK?=
 =?utf-8?B?Q2pnclhSaXl3MlA1VDJ0RWVmSE5tdkUzdHErSnYydE43a0wzUjFRY2FKZG95?=
 =?utf-8?B?Z2dJZlJrMk1xbmVEaDhlV3NlTXA3SmpkWFJqSXYwMk9uZnkva2xqSEdWWGlj?=
 =?utf-8?B?R1pUaGE3VUFhWm1oc3dUSnh4am5NV0FydVVqZjhDcXJpSmdxVGwwRTRCMEtL?=
 =?utf-8?B?ekZ6bnZpZTRUNGpld3pVNUdRdlcvRlNEM2grbXBDTXN0WFByc1RnbXZRdlo2?=
 =?utf-8?B?R3hQL25pMVN4Q0ZreXRFVCtPU1BNRU1NSDFuK1R6b0RJeWtyOXRiaytYUFo0?=
 =?utf-8?B?MDRJMG5GNEhibURSNm5KQ296bFpGL3hoRXpEUGo1YkRuOGNTMmRobU1lTENy?=
 =?utf-8?B?RG5uTWFjTjhnaFFBN2xjcGtsdVJmRzY5d0FGTUVMOS9FWVFyVUp4cWhwTk1s?=
 =?utf-8?B?VlM1UnFCRnVIbGJYcnBubUFZUmlWVEM4enJnTUNOSG5hS05MVm1SOWRhYnBo?=
 =?utf-8?B?RDBSSFZTbllrcU9PaS9RQ3ZpYmw4NFJrVDFoTHJEY0IyczEzVldFSDFGcnY3?=
 =?utf-8?B?NjNtVHRITVVPN1hBZlRoa3g1RnlJNHh0RkZOamlFdy93bjVoZ2trWngwNkVu?=
 =?utf-8?B?MFhycmVSMk1ScWtaVmc1RGdtUnQ3ekk5QytsQ3NORTJkNnNDY3ozVUlRdUN4?=
 =?utf-8?B?MkNsK013ZERoSWFNdU5vNWNwaVAzQVJneGdBZHMwQTNDbnM2K1BwV282aHBN?=
 =?utf-8?B?TE0vekZ5dzBBYTlKNFlHMjR6NGlPZ1ZKUDRjTElSb254dUhTc3h3dDFwbnVi?=
 =?utf-8?Q?62eiWKltQ94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEM0NTIwNEd0cm5ZU0ZzZHBpbUVEUmdRR2VKTXBicDhqU1pWdnl3eElWMC9w?=
 =?utf-8?B?Sll1clJpcXV3NVhDYTN5V0JxOUdGdWlaSndEeVNiampHNUp3d0VDeWlqQXoy?=
 =?utf-8?B?YkxTeXZWMmRsYmQ0dS8wRHN4N1hUb2xsTWVCZmU2a05MSjJ4S3ZnMEd2emRU?=
 =?utf-8?B?eStMTTdzZ0pGZEVHKytxSUZpaDlSeUl4YWhOakhWYWhmWnNyKzhRbEVERWFP?=
 =?utf-8?B?ekdOR2plSFpuVExWckpqL3pvNUM0d3dCc0MvWGtwc2RVVjVza1BuY3htTE1S?=
 =?utf-8?B?dUg5L29YRURDQ0lTNlhyNW1JejZJNU5BLzFEdVFWa3BUNk5JREoyM0FGbkR5?=
 =?utf-8?B?dGQzL0FGOUZhbU5pKzYyc0R2bm03VXlGbVQ3MEtvalBHWkM2bVQyY3lYVG9n?=
 =?utf-8?B?MDVRMDBsU0hyalZvUk5sNk1GTy9uRmwzU0RCb3JGeFkxRUI5UUVJS083OEhx?=
 =?utf-8?B?bGxrNHBNTzdjWnVZeTl4eDNEd3I5bkM0NzI4UEQ5VzFRc3NIQWpYSjFQajhB?=
 =?utf-8?B?QVZSYWJjR1ZwcTB2bGJDRTh1bVpxVFpuaG50dWhjODNhaHpTYVlnMzNRaURQ?=
 =?utf-8?B?Ym5sbHVkdkJUekF4UVhrWU92bGo1SGkwVkJVYTd4SndIejhJK3B5MDJhenNr?=
 =?utf-8?B?V01sR3puTXRIQ0hBdkxMdjBuQXYwK2M1anNpb3F5cStRVXg3Yjh2YkllK1ZC?=
 =?utf-8?B?MkpVVkRlYkxqM2Y0TDlDUnJZK0RvcmJXMlUrTHhRZG1aQmFvM0dVZVhmcFA2?=
 =?utf-8?B?cnFDTTRVK2k2NFExeElHdlUwL0JuTEcvbXArSC9DSlZkUXI1VVVrSmN5Q0Jk?=
 =?utf-8?B?MHFWMDQyK2FaRDd2aUpuYjhQemQ3alcyV1I2Y1ZuSDkxSmNoWjdTdmRFR0pJ?=
 =?utf-8?B?V2VJcVlsNXlCRHdOWVBPV0MyYTE0ekljZEttS0ZQMk8zR0gxUUNWcjlFSXo4?=
 =?utf-8?B?MDNCdG42V0xWbWtzVDZZUE9GNXprMlFUYytIZDFJdkRoTGpCb1NPb1paSS9H?=
 =?utf-8?B?bG5abktITjVLaGUweGg1RGtPOXdmV1FJTDcrSDZSWjZtSEorSHdOOERWd3k5?=
 =?utf-8?B?VExiOE84bURNd3oxQ1MwcGUvUUdVOEtwdGdLRnhnbkFyUlNFdk5LbDlyRzZj?=
 =?utf-8?B?OFoyMFQyVTg3WnpqNlUxSTlmU1hhU2xsTGFSOGMrOW5vaTlEY3VLK3E2R3Iv?=
 =?utf-8?B?bW03VTUxbkp1eE9nODdQY1kzZjdEUzZFN200WVBGNFhGaDhaMWl4YjlzYzl0?=
 =?utf-8?B?R1VFTkMwQnN3RGpJM2p0ZUxtRTJrN0hDYmtxVDRqZkVmaWwyMTJlaTM5L0RK?=
 =?utf-8?B?OGM0cC9WQk5oVEtTV2ZkUFhoelEvYXg2VHhONllEL0dPT3pVeFdadlpJeHNQ?=
 =?utf-8?B?VmkvNllhUVlFTGthcFBLVEVPYk9XZTVoN05QT1NtQWV6eGpnaVZMK0MwYnpo?=
 =?utf-8?B?VEJzTHhQbWsxN2l3WFBQQjlTK3JtZzJSMzRXNXQzWVZadnpPYXN1ZWRQN0lj?=
 =?utf-8?B?b0tEaDNkK2paY3oyRVAvVFp1THlEYk9WTUVaOUdPby91V0pUTk1ZRXlpOGk1?=
 =?utf-8?B?NExvMkZwZlZsVExyYUJ6dFViM0J4L01Nbm1PS0l6MW1KRkVZTEgwdW5yOWpF?=
 =?utf-8?B?WWlEODc3bkRJSWR0bkcrNkFsUmNmelJCR0pJMExiQzZWL0FWdENkQU1ha3dL?=
 =?utf-8?B?UHB6QkIvVnNWc00wZUt5VGNCcDVuYXg5My81VVhNMW1xQUJYc1R4RWJQem5T?=
 =?utf-8?B?aEEvVHZJZUROVk1LUFZNV1pnVWdkekxsWTJLOUxldkF6cHFDOEtNZDJPek5z?=
 =?utf-8?B?M3RPRjdCOElObG5PNm1OeDBFZ1k3emJYY3pEdXdOVVhSZ3VNcmdUZldpekE1?=
 =?utf-8?B?SXIrcThtMndkK2ZwK1d5VG1zS0UvSmpTNTRBN0xYRVpwdkRIU2pOSmxkR3JB?=
 =?utf-8?B?VU81K2ZML2VucTE1YjRFODhiYlozVll0L3RSMnF1bjE2c0c0b3hlZnJTSVZN?=
 =?utf-8?B?bTJRWHFYOHByaUVrTHJudEgreUVFekVrZnlsRjNvZ3F5MGdkcGpZa3phcTVF?=
 =?utf-8?B?QzMxWkRacTdWN09Fcm42c2RFcjU4L1JvQktoL0t4T0hZUDBxRlQwN01LS2N2?=
 =?utf-8?Q?Gg7tbrcMj83ugedwdbUIZB8nl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca445da9-85f1-4802-282b-08dd778b8d88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:25:41.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MzrTOA9ynPhLvYY7QkSUp3Gd3ebCw2jNJocizO7dwnSG8UwZtETlGvdEal43gDUzfLSpJXrtdYRK9XXlYVZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

On 4/9/2025 7:39 AM, Jakub Kicinski wrote:
> 
> On Wed, 9 Apr 2025 14:14:23 +0000 Jagielski, Jedrzej wrote:
>> No insisting on that but should empty entry be really presented to the user?
>> Especially unintentionally? Actually it's exposing some driver's shortcomings.
>> That means the output was not properly validated so imho there's no point in
>> printing it.
> 
> +1, FWIW, I don't see the point of outputting keys without values.

Because I like to see hints that something might be wrong, rather than 
hiding them.

sln


