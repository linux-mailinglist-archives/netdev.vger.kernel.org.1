Return-Path: <netdev+bounces-211886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EFB1C385
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5961886C7B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF58289371;
	Wed,  6 Aug 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxXKxo04"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A428A1D9;
	Wed,  6 Aug 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473293; cv=fail; b=H+PkocRnhtW5BOLIBOcnesC6DBCdsUEQBFu1Y/FOJWkV6ckn1suOStExFc+6z6yb4+Yc8GC+T1eS4XNQd7cXrl4P6W+neVT0LapJOSa1cS7NY6SJZc2xL5OVkxHC/QkOCMhvhvPc5fw9VXPSy4Esf4SAix8+SBy3YRA08mTrtWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473293; c=relaxed/simple;
	bh=3Zt0AKXXHgt9dx8DdNdCedflL5Arpz8c5b0IaPLxmU8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDKRnYihxjRVQGed/IblQmK+wDs84V9C78mGIkduPYMgaIqHko6Wkwp5FCHbi6NpV4aciBAgTQ5nhbeN5mx/tucFmMvlolisnL8KJ5eyOwHZ/cYAepDSgJZjI/jRphuNPpwF5aWTjSclnsbxZu55GEO3+QhlTM44JaRJ4JH8xLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZxXKxo04; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIkEG0bp/+FbYTgNeNsxox0lhJirqQpRrV4Wo86z3Oj4vxK161nfYnkY+UF7eXLGDNSndyRHtw4WM0761xxZaN8Qq+P4M2Tq1Y/FufByi9nSUQDRtjEVRsSc6ptdXRt7X6Em5cIcvVZ5ocuwHAIeiDqWyqCqakFk1Dpn7izR7j+z69pL/lqoiQGZdXLHUs4qvEB2l7gtM1KC9Z+Kiw7nVR8Ile7120Y5AKwFD3G5ARMIpp27UMyvcCW4ZkVHjQ4PiQHGx2Nq+5853N/kdkEnHCKF3NQvogAcRbk1EORquMxPwP7ok1axOYTE0R47akMEm80Q1XjLPqgN6j+SqfMEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbr165kYQuazXQb3q7WvFiJKBoyXlEOGWYFwU3pnQ+Q=;
 b=upJ8sk5xFIM9CvLx92FZoVkXRCWPJiDWwNLPtxYkK6+b/zYX2Mz+c9+51JdZTmwtxXm3qk/T6Jmy/8k21kjvnHarKNtjfyuqU1RRyyq/ANtpq7Py5+Uo6BPwty+EEUEN4fG4Vt4Ug01MeKi0fWX+LgWVQRhe+lb7KyIFd3+R5S7eE7OeRqTAPUUaZ0ucm02qr560GbISYL0XpwkqBzeQZU7QHK1AxzxsOUQnKuhKu8VuFI/QkGs/UDf/hEr3pyEonr/aSZpTkFXsubPnrcEoJK+b+APqtrLU0op9jA8e3u+ejhqpJwjabTeWPb1UGC+NNrhU/U3A5nvS9eKgR4Lvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbr165kYQuazXQb3q7WvFiJKBoyXlEOGWYFwU3pnQ+Q=;
 b=ZxXKxo046Z5XOfL0vtt5Htg89+DPDkBHYuZ5WuqRlog9Cu6PetE6Qu7PHoAPwZCUnxIvr6zY7LpR4jwLmcGU96Zye74/XcwdOAdKpgRuVSJxYDRWguZFADTXi7T+W4CM5OWUHnlhucQCPPvZ5HkFi0XQayPKoXyHnV7un24WlFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 09:41:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 09:41:22 +0000
Message-ID: <6c7912f1-3966-479d-b916-bd477de59361@amd.com>
Date: Wed, 6 Aug 2025 10:41:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/22] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
 <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: c855942a-6cba-46ec-a916-08ddd4cd6737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnowQ2tsYlFFMFpnYmdSMi92MS96eUFXVllVbkxHZXdhbUNzMnM4VEFsQXcz?=
 =?utf-8?B?SGZHT3VhVkZVc1FqUmxsS2FsN0tZdjhlTERmOW85em5CMFhwR0xZZ245RStI?=
 =?utf-8?B?YlJReHQwSnA3WHhDVVk3aTBuZFY5cUFKaG5iZGZzSUtrWXE1cExoNXdBWkdB?=
 =?utf-8?B?Vytja0xMeWxjQ1BMMC9TK3lhUGowTDlHeEg4UWREb1NjR0JnQ2hHVUN2b2tC?=
 =?utf-8?B?REJlNTB5RnFDRS9xR1RUR3FYdGhWSnhwYlV0VEhzbUdMaGRMNHJhQW0rVVVy?=
 =?utf-8?B?OFF6KzVvZGpXUXMwYnV1OUtZN1duRk9hM1NmZ0pGbnNkQ0gxeXM3cTdRc0Fk?=
 =?utf-8?B?V3RvWUZ4S1QzajEyQ0hQUkc4RDA0WkFlT2x1TWYrRUI4VmpoM0FQQkVBQ3JO?=
 =?utf-8?B?MmN1S1ViVHVxZVFmTWxyaTNDU2V2N1I2aFZBdzRpVTBXdTJPakw0U2FMc085?=
 =?utf-8?B?U2k3WHBuQmpCY0d3MXpycHlkRDJVWWdsUGZ5QjlOdzRaUTh0cWcrTWE3MGtj?=
 =?utf-8?B?ejkwKzQyNXhCSEVETXplQlpCMzhBd1Z2RTJjZ09BL3FzWDhjeVp2WnFMVmVr?=
 =?utf-8?B?Y2VqYTV3VDdKZ3FueGdJSGZqOUlDc1UzQmV6UkhqUndYZ1FxcmtXVzI5OURX?=
 =?utf-8?B?a08vWkl1eks0VXFmUVo1NTVBWjhBaVkwV2phNGFjandKcjhTUVd5SVJ1OEtI?=
 =?utf-8?B?Nkd5R3Q3Nzd5NFRjRktTWHBTbkRaSTVZVER3V3BSaDZnWjJSaktxK1VVZzBQ?=
 =?utf-8?B?VnJWdHdCNXBUQUxHcEoxa2pGNHpZZ3loeXd3OUZvRHpoa0NCSTJxYWh4UUdE?=
 =?utf-8?B?cFNreXZyb0oxaTlYNFNoa2lBenVoc2N4ZHh0Yko1OS9XOFptT2l3UU1hWGhH?=
 =?utf-8?B?VFRyYWpjN1k3cktWRERBU08zR2xUTjQzM2cyMmRuVWo1VThYNHVJNXE4SENu?=
 =?utf-8?B?SnM5VFMwVGh2ZThQOGV2eWZveXNlWWN4S2ZwRGJmN0N1emdwM2FHeVNSUlEy?=
 =?utf-8?B?NGFLVUsyUm9pOWJybGliNzd2UnluRnVXbkdOcGFDOXNQK1lZcVV2QTN2dmlH?=
 =?utf-8?B?TzR1WGJUbVp3Zys5VjB4THNSTElIdkphazZ4bi80ZzJTaXhhcEhGMUExVzl1?=
 =?utf-8?B?ZEs2dWlqeVN5RGIyaENYdlFaeVZiVXYxUjZyS0UrbE5rRE4ydUNmMG5oVmtm?=
 =?utf-8?B?NkZNREEvcEVpRjZVMlVXeThxczU0cmxvdG8vVWJYa2JIbGRUZ09FWm5Ia2Z5?=
 =?utf-8?B?NUhnU2xrT1o5cit6cXlFS3V0akowSk5oZDA1bCtGNzExblNYbi8wYUJieXEw?=
 =?utf-8?B?bWc2cmZQSERaQWlSRGczcndzY1dNWnIxRWJReWF1c2Noa0wvWUZnd0ZCSFFT?=
 =?utf-8?B?VGN2aHVkcmtranhseXcvSnptZ0oydnk2cHVidWE1OE5VQjJFZlFOaXk4bnpI?=
 =?utf-8?B?UTZhZVVMTFcyUlhCSXE0Z1lsR3p2NW5EWlNFWWJ2aUZtVWIycHEzN0FyK3Z0?=
 =?utf-8?B?TmExeUw5SmVnRFlRa1U5MXJsNVBBVVBqMFAydkJoNmxlb3lNTkJLWXJDUW9Y?=
 =?utf-8?B?K3FMNEVibEx3c1I0a2FObnNpcHJvaEJVQ0tyTm5kTkM4dHNVUVNBWnlzTlZZ?=
 =?utf-8?B?TU12aXNZdzVFNG81eFBoakZkTGE5eVdNSHlwdU5FWjZGSDRyRGxjdlh2RVZq?=
 =?utf-8?B?NVlJWWxSa0Z2WmpSODlYZDNmRGVBNE9CWHlXVThlVUVZWGpCR2dCYmo4QklJ?=
 =?utf-8?B?bDZKdGpRL2dOZGg0eGVpTkxUWFlNWlJFSy8vdzRNWlJzb3cwMlNmcUpnenFr?=
 =?utf-8?B?SmRwcEczcDE5UFBLRy9hbTY1dGtSN0U0ekJacXJpa3I2R3JUQThGYjVqNUc5?=
 =?utf-8?B?aDJpaXZ3aVZ6emR1UXdyT0lhZVg4amhBMS9aUmxvR0lha1U4T1hqWjVOaitX?=
 =?utf-8?B?dVhSRkRlOGdCZFBMUWlyelRycGtyc3lmdGwyWWpPQUU0aUkrSXFoMW1SVHB4?=
 =?utf-8?B?VXZ4dHVNclN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDMyamgwY0tmYXBHdk9KNkVqL3EzQUJvRXVtZ0x6RnRmTk9zS0tvT3JOSXBs?=
 =?utf-8?B?YnIvQWxFK0N4MW1XdFZSTFBsenRFVDhQUDFjckVUZEd1SUVZM2hYMmp0VDk0?=
 =?utf-8?B?Slc1YVJNTTM3K291Q3J2RTdteEdvMjk0M1hwdkdHbnQvSy9YS0RMVmZsS0ZO?=
 =?utf-8?B?cVF1RWpTT0NIUHk1aGhJUGM1U0ZoSU5NL0FwZ3RnODF2aHZRQWwrTXg3dlFU?=
 =?utf-8?B?WjNjcVBpQnBLRVFwUnRnSzIvZ3NIeWFCNlhyTzlodG1ESWxkQzhNWE5mbWx3?=
 =?utf-8?B?WjNSMWdIaFlpenJUMTh4cDB1Nm90bFRxTGtMM0Yzbm1xbUpGbktzdncvSlRE?=
 =?utf-8?B?ckVGeUdaVXMzQTltbkpSOU5aOXFYM2ZDbjdKMVNBVUI3ck9RWEVKUGFrUzNH?=
 =?utf-8?B?WFIvWDVUMzdUWDJnZDZ3SG82Z1hTRmZ3OTNxa1k1UURJekZzLytSSGZVM2dv?=
 =?utf-8?B?SFM2MmlkNkZ0RCswSllSNEJUUWVuYWhkdDNZNy9kV0R6YnkvSU50dnlnd2x3?=
 =?utf-8?B?QU5vbVFqTVFpaC8xVVdKUVFtNndLZWlkN0hDSVMxcUdjWVMzZThJWm15b1Nv?=
 =?utf-8?B?bTJvaE1SdU9ZK1JRelVTNVN5bndmZTFrVDRpKy9Kc0pNbDE2QVhYVWg4c0hE?=
 =?utf-8?B?ZnNSOUd0RmZZSS9jc3JLNTk4c254VVZYZ0N2OE1BRUgrWlVwN3BMZnhaelA1?=
 =?utf-8?B?bGNCTFBYbTNzZ01mQS82ZEV3OS81MnBSMGxManREbjZXcWhqemJRWjNHUFN3?=
 =?utf-8?B?NEJhckI0Yy9IUFd2Nk9HWjU4Qjg0L1dOeGJFMll6YmZyWGlBTTNja3VwZ29s?=
 =?utf-8?B?bGxVNXJYanJUSmhkeUVRL01GcERMMSs3OHpvRU9QY1ZjZE9lYmNvUFdEWktu?=
 =?utf-8?B?L3NBOWtDeCtnS1lVa1NITmIyRzZHRGVHK05OWWFKR3RIR1ViZlBXWWZ2Q0ZR?=
 =?utf-8?B?cVFQOEYxZ3pqeHJNbU9mMW5BUlRRQTJUQ280TGZXa2VtVWlEdnpBMWNBMkoz?=
 =?utf-8?B?U2J6dHhoK2JNZjhOTGFRQ0hrQWF3alIvMVNNbXlVb0huZTJKakxMbUoraGQx?=
 =?utf-8?B?YjlCdGJEVkdubGlkWE16ckZMRXczT1VxZHY3c292Y1dQMUJJUTMvWDg0cDRh?=
 =?utf-8?B?N0RkM1hkTXVEUGZYdUtYZjhtVkJNbVJ1M3pHakM4VUtqYTVGNm9TazRzbTJQ?=
 =?utf-8?B?MjdXcVRxaXNiL3NBL0lzZmhSMXdYU2J6YkVkZ1VWdGVQSmc5U05jNldmZ0Mw?=
 =?utf-8?B?VnB1V08zYWREb01OL0VVZ3UvUFBiOW56SVlBNTh0VnAvR1lhM2t3Z0pqZkdI?=
 =?utf-8?B?UzNJR2JhNlR2a0ZoZ2dvZlVqRWNIbC9FTSs1bFNzeko0Y1dNcFhCSFA2Ukpp?=
 =?utf-8?B?ZlRrdTg3cDBTQ09WRndmeUhETWlpWndkMU1oeFZiQ043WW5rSEF1dFNDOUNB?=
 =?utf-8?B?a1R3amd3b0xTZXd5bzNqY2xKTEJncDBlWU1qSXk3K0dWQTFUQ2ZhQ2kzZGkv?=
 =?utf-8?B?ODhyeGVBSDhIYzBNclQ5L1NWc1hYc0ZZVUZBdFJ1RXRrTXFJK1hmclIrR3JH?=
 =?utf-8?B?S1BmU0x3TmJITTV1V1JTTHlHTGVLQmFiZFQ3REFnYWRXVFFtR1hBcG84dmtm?=
 =?utf-8?B?QVo1VndTajY3WElqV29YYXVpaG9ETFQwRGR5SFpPMUVPMnpJVmdYdFFlNnMy?=
 =?utf-8?B?dlk4SlErQjFBS1J2Z25kYm84dHpZdE1YWG1sR1hOeUwyd2kvYnFCWFk1YjZJ?=
 =?utf-8?B?dlBSVzdFZ3VHYW5GZHZaVE9OdzA0cThuZVdMS3dVdHNHTHNSQUtEb05HWGlN?=
 =?utf-8?B?ak9jNG5qOWp3MnY2TjdmR3lELzF4NEF2b1B3N1VtOEtjMWdNRW1iSWpWUGJ0?=
 =?utf-8?B?M3IySzltN1pYb3g1eEhTTUY0V0JJY0F2bUM3SGxxVGxjaXRFVisrVDEwaG5X?=
 =?utf-8?B?cWlZNDB3UEYyWFZ4SHRiaHRrMDhJRkdQV2EvMGFDY09FanR2V3FZbGhON2lR?=
 =?utf-8?B?TnZOcmVONkR4ekVYSnJTRVZtZVJzVXBmS1FVZ2FZSVJWVWJkZjVrM3p0WS9r?=
 =?utf-8?B?aUZFVzNsMTIwbjFRczcvRVhZdEZkeExVa3pTS1JieTFIdFF3TlptMk9hQlE3?=
 =?utf-8?Q?3IJCJQ02VeEAJfCzzNKpOrq4N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c855942a-6cba-46ec-a916-08ddd4cd6737
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:41:22.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/6vUO/yYqs+tGSWJhv3wqEw3tSZxgdsQhHKRxInA1BSUbftwAuhnwag4+IdkpBZ7XH9cehf7JYqw/ecEdlmPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017


On 7/25/25 23:55, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device component registers.
> I would squash this with patch5, up to Dave.
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/port.c |  1 +
>>   drivers/cxl/cxl.h       |  7 -------
>>   drivers/cxl/cxlpci.h    | 12 ------------
>>   include/cxl/cxl.h       |  8 ++++++++
>>   include/cxl/pci.h       | 15 +++++++++++++++
>>   5 files changed, 24 insertions(+), 19 deletions(-)
>>
> [..]
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 9c1a82c8af3d..0810c18d7aef 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -70,6 +70,10 @@ struct cxl_regs {
>>   	);
>>   };
>>   
>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> +
>>   struct cxl_reg_map {
>>   	bool valid;
>>   	int id;
>> @@ -223,4 +227,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>>   						      sizeof(drv_struct), mbox);	\
>>   	})
>> +
>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask);
> With this function now becoming public it really wants some kdoc, and a
> rename to add devm_ so that readers are not suprised by hidden devres
> behavior behind this API.
>
> It was ok previously because it was private to drivers/cxl/ where
> everything is devres managed.


I'll do so.


Thanks.


