Return-Path: <netdev+bounces-118354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E039515E1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F2FB28872
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF413C906;
	Wed, 14 Aug 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kc3Ad1Dy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BD41746;
	Wed, 14 Aug 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621782; cv=fail; b=mnzFIoxy5QzKrclAOxJpFnhMF0Ap7jmiZmb0rfXXyd+iusWnVqXCEi4S+mBqzTbqk1qqa/nf0xieGEF3QvyyypGCslPngfUM3RwNl+ocVuj2+/ZiFMaSaNYnS3p2uYnssmaP5L4tkmcQJs8dMGTl9+c9s365EKkWdck4nWKjLXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621782; c=relaxed/simple;
	bh=ppCnsxw1KmHPFFmJnmdmRMArBiuRkNDlugNn2HZX4oQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xk3FQruANRmBpW0eYkVvQPT3Y/+vNfDX0VOMN8UddaTEcXLEnaNq4zRD+ghTjW+R9L/8DWuus29EyMS/XBiD7bt2qNIqMBhuRbr4eJweD+1EwYglsYQy1WiHfM4XTWUmEZZ6bHQhJfZO0083uI0AuU+1UPjJu86ogZiQ6GsBgm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kc3Ad1Dy; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=typ14nSrjNL6uaya9jMfsYUDjgS+Oi5Khs7DKApuz5VTf1RVKp0GqajjHkElkZvfklW0+TTcG87Iw9ymRw7Z7UNQB+AgqrCOdfG+96j4UA7VwinA324NM37zAbnfwJNso0ehb0KWkTY3xN6QJWhJgVDi69JcBjDhYT2nhlwAm1en+oFfuF8WXZx5xlksm+iLqaLUUnSaZclZbxhryev5Wlrhg+EM1A5zmuiD0q5Bk/X8XA1p8Sn3XffN2NhQ+JKE7vlwlIdGrBpeBdViV6uY8Ht3G/p0uZZQuOiBCku3vK1D6ud1Xt9CpkQgBXoiwW1XHCg1SrqHem3yqasIyIoS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQicGjiHU31M2QkG+kBqN3G8aYmddGYNHbAuIBL/t/A=;
 b=eeGZGqvhHj+bNADZ2+4kN6V7sPLrZ/3acNaG3Ro1LqeBAvBSNtbdAAF3qKU2p4AtsL9kJsSpVQX+jI3eXNi3e9v4CnQfYLHcOvBIOic6JrYPYAzn5nrQFpJIMIhykKegxNh0Eph9gvvMUNzXScFpjU/1onZkCeaAz/SVBMiTvUIJwbgIvUo81Oua7/ln0o0Ld+XCP7ucxnFCiitiNdMQws2Nzb/fHuqoFiSJd/Fqck5nwfzBIv9KXO5bSg++WLtbt6YlOnJfZHELtT0CcbW3p0ZtF9H9lZJQQYs2OT02utGyN3scHWqbH0b2JtZLVelWBXth1vQZgswvCans80xoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQicGjiHU31M2QkG+kBqN3G8aYmddGYNHbAuIBL/t/A=;
 b=kc3Ad1DyMn81NT413w0jFKcgHbBGP/XcvKg/d503c4KKPfgSDuNCzxwpOdirDGbF2ui2pg/fK3NC8dOsxYx4sezRJBzdbdOoc/2gHnzMl/iTl9ypEU99CbZ8eokiNYH8STAy5Miywjlhuk0RnxtohtFag2I/DzmkRFjHZTsldf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 07:49:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 07:49:38 +0000
Message-ID: <3666c22e-c3fe-fcc0-e944-2992452764d3@amd.com>
Date: Wed, 14 Aug 2024 08:49:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
 <33c34f2d-55cb-4b50-888d-1293ea2fa67d@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <33c34f2d-55cb-4b50-888d-1293ea2fa67d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: cca239cc-1c91-47b8-c3f1-08dcbc35a59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VDeml5OUUzQ05zdktML3hmb0lTb2xxS2RlbnowcVM4eEJneUlNa2VyanlX?=
 =?utf-8?B?Wlc2UVpPQmtha21zZE91OW1ZclFGUDNPSG0yYmxLajBiNFRMc1hOckZSdzhP?=
 =?utf-8?B?dmlJUmZTU1p6NmhlWkZwallhUVFjc1dPVjZpUEpyRzhXZ0Uyc3d4RkRvakRH?=
 =?utf-8?B?aGIvbjZOenVRRHhnSXkvZWVRMW9PZGExSlZjOWt5TDZMWWdLdTFtdjhXZVRi?=
 =?utf-8?B?RVFOTkx6a2VDV3R3dmhXL0dDYlpPcmJOcVMrSVhTeGhGRHBZdHd1TFJpYkwv?=
 =?utf-8?B?ZFRFWWVIK2hVZ3BnOUlsTlNYZXg1TE1lZ1FjMTlJUk4zRzZ2WCtHbHFWdU9P?=
 =?utf-8?B?THQyTm54VTFDZXUwanM1Ni8xanJWQWp3c0NMTDdYbTBhSUdoNUVpUnpkaEtY?=
 =?utf-8?B?VlZzc3FITFV1c3VPNVF3TjNSaGtuZGUzeE9qNkNrUXp4NlBXWmtCZzA1YWtY?=
 =?utf-8?B?ZG9lQUR1UG9iR2hSSUxFOCtteTJkY0xhQWJjQlVQa1ZhNkJGNFVyblF5NkZW?=
 =?utf-8?B?dDBaZCtpbkJ4RlJFZzVLdnZMVmIrelduUVoxZzNIeXFZMzIvckZ1RHd2bkli?=
 =?utf-8?B?ZHVMUFdZSnQ0QTJuVmpTVS9aNngvRWw3NSt4U2ZWUUVpYWpyaStZNDdEa1lS?=
 =?utf-8?B?bGk1ZFFiVjZrODZLc0NsRUsrTHdScXQwVHhIYUJDZSttcGhVblRBSDM4dEo1?=
 =?utf-8?B?YlJ0RklBNXY5QmVtMDFJMmdyaW1FOGh2dUI1YXpXWmhCc3dOdjdUUGxFSXQx?=
 =?utf-8?B?b2dFaS90dlhKTlJzVGZ2aS9zMWhtamY3V0xhc2xTQndyczlzeFk3QTJuSFRh?=
 =?utf-8?B?WmZyQjFFTTEzdHQ3OVlUbnhyQU1VTXovdUI4aTNoZEZSQVRFMXY2d0MwTDZz?=
 =?utf-8?B?aHJYbGNTbEVJcnVjLzRVMFNoNlQ0NlNvWDNwOXVXdGZpT08wTXNXWHEyVXd5?=
 =?utf-8?B?K1ZVODJsVFhSbEtGSzN0dFlVSFRoZEFialNEbEN1NzRWR0d3Zlo2UVNWMUov?=
 =?utf-8?B?R1hUT3Q0Q2tiSFFXVzN6MURneW92cWRMdHExWWNMcW10aWFsNHFDbytJQ05l?=
 =?utf-8?B?S21jMDluaU9QczRNemQ2dEpmZjZ3MlNGQ1daM3F6T3JOZTVQVnU0MkVOdk1p?=
 =?utf-8?B?SnRNUWtBQWExNUthSHZtVEg4YVRKbkRzeE5nU0Z3b3VTUUYyNG5MdGxyK1di?=
 =?utf-8?B?VDNlT21DMy9hNVUydkFtYmU4RkFVQUFDc0xvVmU5eXhYZXRvcFZZT2NwaGJE?=
 =?utf-8?B?QXpSbGRTRXZORFdaRkk1RFlka0owSi95dzRHWTdkNXNROW5ReDhkN2VaSDBP?=
 =?utf-8?B?c0hVNGNoREYzWkdqeks3MkJoM1Y1TUR6a2xncWlpSXArR3BsU2ZkdWZYVWpJ?=
 =?utf-8?B?MmRBVGRBdjZRQjVpa2orckJmWXBFUk53L3pyQ0hCR0tSNW9PUjUvYk4yd05v?=
 =?utf-8?B?bWNyamNRR2dJUHJaN0lUOFJOUkljYkpUbFZJcnB1bHNYMUYvV2x4R2UvYVRi?=
 =?utf-8?B?YjlwaHF6SFBUZTFQb29VTlpXeHRHeUVxV2VlcXVXdkpTSzM3M1lDcFJJRDZl?=
 =?utf-8?B?UWdBMUlhamNJQXFxanpmaFlwcHR1Sk4zbkFHVFJMNjVPRUJ3QjdxTnV1b0xt?=
 =?utf-8?B?ekJFUHlvZGJ3UitTaTVnMUVOR0lyeWJzMkFZTmZhRko4ck5Xd2x5eE84QUhU?=
 =?utf-8?B?UlRJZUpWT1BUeHd1TE5VN2tLb0Y3TjQ2a0Rka2xlbEs3SmR6Y1d2S3cvamJl?=
 =?utf-8?B?UEdUYUZWL0lTSGZFV2hSaU9Fc1pQK2ZJcG1iNmtSMFRzME0xb1FiNzlhMkxM?=
 =?utf-8?B?Tk8veW9GS2ZHNG5uamRGTERSb1pSL3RDcngzdEZZUkFZT2tHNDF3SzZ2bUwr?=
 =?utf-8?Q?8J177NyE1ZBr2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJ5enpJNVhKeEQ2NTcrcCtLcTlYcHZKMDJRWlNVYUkvc1dLMHFzR0srZnZ3?=
 =?utf-8?B?NXhNTkNmeGtaVkFxd0hHVXFiQ0tSWGV2S25xMmlMV0kwR3pXWDdudHJ2b0c5?=
 =?utf-8?B?UWc0TkltRERGU3VxSjdjWWJFNGFCZ0twRjlWUjVzT3dLWkZXQndKdDA0am9x?=
 =?utf-8?B?ZjMycTFrT05NTnd3VU9CMXR3MDhDcit4L2htUUxxNE9QR0h3SnNzdkg4Mzhp?=
 =?utf-8?B?NUg1dWJHdVptVnlvdVNMQXo3RFVadlhIZXkwOGliejRIUjh6SlJFODNJdFJH?=
 =?utf-8?B?bkxDMW1SQUI2VWtobzJpb3hRSm9ubUFtMytGZXZCYmJVdVIyMmdONXNKZlRX?=
 =?utf-8?B?YlBIK2VhdGxMd29xc1BkcnBkZngwZmpqZzQ2WVhSK0RFYVVlN1F3NHJwZEk4?=
 =?utf-8?B?WkdlU3Rvc0U1QXE3Nmpxb25YRitpalhQbVJsREZsYTJvNHExRU1LUmR1ckVL?=
 =?utf-8?B?dXdVZzJKWUJGTUtCRnZudUoxc2lRTmtzUmVTSDF3WEhPTkVhNURiU0RLR0FM?=
 =?utf-8?B?SS94VEowSnoyVE5UVjA1VmF0SS9nZ3YzKzFwR2t2ZS9seW1OWlMyd3ZoaUo2?=
 =?utf-8?B?WWVqdlpYRHFkWU9wQ1hJWllzTmVFekluT3dlQkFPZ3ljREZ2cytpWVZRZThi?=
 =?utf-8?B?YWloTHlkenhGSWRzY1NuTFE3ckVtcnhENVBVTmd6K0Y2NHdGdjFoWVRVR3hP?=
 =?utf-8?B?bmhvSWw1MjlXUHBBWlZoRHdGVVNlVnZvWWNKNVV1Q09ZT1V1UHpOaFVkTU1P?=
 =?utf-8?B?K2dac25IMVhOMVVJTk5QS2pHb0VBUG5COU16bGFFUlRRb1E5S0QzYXVjUEJs?=
 =?utf-8?B?bnlNSW5nQ05IUDVrTndQUXM4QXRMdERRc0tzL3c4NTFqU05GWlhEeWJ4c1hE?=
 =?utf-8?B?K0JPZy9WVkJ1ZU9wOEo1a1N0Tmg0blprODdXY09PbHA2TmozZkFpeDlFd0ZF?=
 =?utf-8?B?bE8rSG13Y2RsQ3V2NWc1OWZ2cm11NFhGWHEydnczNk1xaW43eHBVVmFHV0Iy?=
 =?utf-8?B?bFJLdzVVZXlmaGFMamZEM0tGRTlGa0FQYWl3aTZpNEdvZ25mdXBOZE1ZQkgx?=
 =?utf-8?B?MXZKZU5RY0lPakxtU1luYm81Y0tQWWI0bTBMcWFWNUdhMWgrTUZrMWlXOG5U?=
 =?utf-8?B?RnQ4Z3NjZnFDaDZjTUk0YjRtUlVOdWtieHBNbFFRY1U0Vy84NlhiSkk4ajh3?=
 =?utf-8?B?Z2NucCt2WWV2Q1FwekJ2VEpmQ1pTeHY1YzlWSmxXdVBQUmR3aXM5VzZmMnJu?=
 =?utf-8?B?WGhTTlNDVzZNL0x6V2FSQ1N6MVZXdTVlZDNBSCtkMWdmbjNMNkQ0WG8zSlR3?=
 =?utf-8?B?VFI1STlRcVdOSU5HVHYyMk8vRFJCUjVIOWFQS25jSWtrcWxONTNFNDVCOCtl?=
 =?utf-8?B?TVZTTSttQlh5Y3NjVXc4bXB1ZitOU1AzZnBhdmQ3QkpBc1NoVVY0QXRvS25j?=
 =?utf-8?B?TzVIeEs2VTlkK3dSYkxuMi9HSEZGVU8ySlIrajJVbW1aMXVQNzJrUmllU3hH?=
 =?utf-8?B?T1ZQbUJIaUg4ZHFuRVVsQXh0TkRudmVLZWtsQllIV25NMy95ell2TmRicDNO?=
 =?utf-8?B?Y2hEbElRQ3pGTDAzSDBXMWJtSjlydFNMOTVjVHk2MnRjOHRtRnRFT1k3cWhm?=
 =?utf-8?B?bVI3WU5hbkhvV1Rld3RVTkZlUTd3QSt5RVVYT1ZPdU1wOW52dmhOWWxxVkhJ?=
 =?utf-8?B?WHRTMFdMaUhhMnVqZzFPRzhEWXE5ZTdQZXNCVDNSNzVoeDQvaW1tWDM4c1dk?=
 =?utf-8?B?UjdXNGZ2K0hMbnhpdEpzVTl1SkJxRGpoRk0vOWZIMXd2cTRSVHlWNzFrUHVQ?=
 =?utf-8?B?WE5lN3owMzlaMFBBR2w0ODZNa1FlVGF3VHVGNjdiRDhmQitjbW1ydEQrZ093?=
 =?utf-8?B?a2g3eWNpUzFnOU42Nk4ycmo0YWREWm5qK1p6RGFNTDhEekpoNDNXWGhQSXls?=
 =?utf-8?B?cUpubGRZZUZrUzlsRVMrL0Y2disyYmhyZVNnNUNyL2lZc1RWbDRxK1VqSTl6?=
 =?utf-8?B?MGRUSmJnRldZc3QyaGl5SUZ4ekQxTmNNc2lIRHFqOXdYVGtyWHp1OG9rN0pL?=
 =?utf-8?B?M3l1Y0xKRU8yM2daNTJCM3h1bHg1OUw4SndMVUxlcnMvKzhabEtLTFY1VFlD?=
 =?utf-8?Q?/pEc5Dj+Kfw+KUSU4EJCd8nvs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca239cc-1c91-47b8-c3f1-08dcbc35a59a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 07:49:37.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LULGCrDXsFbn7ajKGzAwMhVDZvlFxfHHmnqTIvKMov7FntEVZCFRyWlnT1AjGgzxxNEFpE09X0VGXBt0eFLIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190


On 7/19/24 00:27, Dave Jiang wrote:
>
> On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising the opaque
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
>>   include/linux/cxl_accel_mem.h      |  1 +
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index e53646e9f2fb..b34d6259faf4 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl_accel_mem.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   	return cxl_setup_regs(map);
>>   }
>>   
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> Function should go into cxl/core/pci.c


It will be in v3.


>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map);
>> +	if (rc)
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> dev_warn()? also maybe add the errno in the error emissioni.


Yes. Thanks


>
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
>> +
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4554dd7cca76..10c4fb915278 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>>   	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>> +
>> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
>> +		pci_info(pci_dev, "CXL accel setup regs failed");
> pci_warn()? although seems unnecesary since error emitted in cxl_pci_accel_setup_regs().


Right. I think I'll remove it.

Thanks


>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index daf46d41f59c..ca7af4a9cefc 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>>   void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>>   void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   			    enum accel_resource);
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   #endif

