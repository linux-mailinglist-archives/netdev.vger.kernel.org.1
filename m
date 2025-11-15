Return-Path: <netdev+bounces-238846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305EC60183
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98EA935FDE4
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5DE25393E;
	Sat, 15 Nov 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MCetHSxb"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB4224B05;
	Sat, 15 Nov 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763194598; cv=fail; b=IbizcNs6Wj4+RQvAkkLNH4hIH/LqHLraM4nR+vKuO638jPkN+hNYXbjnIyoI8mBUNW7IxbxfdLRpirePHs7EmKqX2oQ0+/1VB+Ss4TR1NfN2ubXCOk6BH/tBpq+SLNpUE1kIb0ULS2Z/VbFrEq0k26lZhDgfu+Hp5aoQyvTrEas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763194598; c=relaxed/simple;
	bh=ooi8uE2jWFq+rNO1+7zuxWaDK8gfAyOkTL/3wcRrR0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j2b/NqM2aIyPpcJQMKLYtv1Af6x0dOmAsk6o+DcUOOZFyKwmrh6rgb5G6VMiAq9VpFdvfqQ9uzcOvl6gz3gcZYdHvbQOkAIjkkJJPlPPB+0bvF3WJ/aGyRIh/bLGLouoA1iPTb0iU2+XAooXQrNi/6VEWAjgyKLEEi/yPakHnvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MCetHSxb; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f92yL5PXyXbI8Bz7+05vlwEkl4SMB/OCPGvnGp/V78zyvHvZUi9eql8/iHC9CD6vVbzU2IaCjO8Lx3Rk01rVz4gHM10gsLVudksslxi74MalJbndpaPwu4M3PnkiurAA08Eg0Iz8ZFeHo0NWVVojNo5GC6RUR9myvSs1Ge9edHaSIlGhjIZjXEJ4mPXh+fa3bw6KYhJiUNi4k73yziBK0J5ucxjx9cME7p22awxlIpZHUlXDzRy1XikXhu53D1fTEau9ekZwu8LvboKRmfP1Q6AMpRgudEYt9dCPuhFwww337RJlamI4/XzAua5TeQ/mhw98JdPd9e1Fg6PfsYjIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGlrLafqK7T6z3574QJQWgI1Lk8Sv97A4xPaF1qvqyY=;
 b=Mnp/4JCAhgisAgxAtNx09L2o/wtvE+064XKY5vsqfUrw1Jyfk6VzaVDcNRmLVNysbSa71Vyr4rSyfrmjDB1kj44bHM1eKuErOOOfOdspO3MmfJcZepxKZ5tjYdoLELL0/JHNxFr6u/POMvTUFeKxWDPMBTzUZer2USX/fb6hl3JK5NVPss7wdl26O9ihDlK1if2Gb63z2y3x+xl6wfLvF4co7Kk8gPScHgvSVtwizLDMyeZwj9xf60eh7uG18tfU3fTwpnpiU0/NkpPZ7meX5qZyNq/RuMYCKDJb7yIXQL5Yrwexj6XeDN2Mk5khgDbC2FBZNsTZ3PihrX1giQn2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGlrLafqK7T6z3574QJQWgI1Lk8Sv97A4xPaF1qvqyY=;
 b=MCetHSxbwqSuhiAmPsfa/7JV1Q9ddgA7cUHfy0Y4W7ws8s4mDMwIEDrH21MqqZjGDG5rhyPXUizjy+YchedBJnebT8yiP76tKwnaL5eUHg2IZUqI61tb01JQKesJXmuGRs1WzKuEBJIWVrNBBxKEWHQ1z951gVv5R6ouw608Yr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 08:16:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 08:16:33 +0000
Message-ID: <c8efb22b-57c7-4db5-8986-72b1b2cf605b@amd.com>
Date: Sat, 15 Nov 2025 08:16:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e9dd2d-0ee3-49bc-f164-08de241f49b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGRKNmlQRU1tbXBKVGlabG90TVExNTVlc0Fvc2htc1Qzd2E3djFQUUd3UC85?=
 =?utf-8?B?Qk05eEJaU2lYRFd2QVdaOHJUcjUxM01mZU9CWVU0ckhqY2NPNVFVNUZ4ek5I?=
 =?utf-8?B?MHI5cVlqdVJ0V2o2RzJqck1CUzdUMTdOai9ubWFZdXVOSWlwRVdvZzV6bW51?=
 =?utf-8?B?ZlVLeSsrOEZQd0FPWlpvVW9zZGMyUFZUWTNqNHAzSWI0eHFOZlZsZTl2OVpo?=
 =?utf-8?B?UWp1aFFCc1QvRWVoQnh2WnRNdDQ4VnphTE44WXRCQXVMSHM4Z24zU3hsY0hr?=
 =?utf-8?B?YUNFR0cvWUpzbms1UGhmbkxXcnBGZlpuYlBuSXZkMEQ3SmZLSVpSbURjWWlG?=
 =?utf-8?B?dEtSeTRKRktIeFRJdThTRWV2NjdZc2FLcHZRNmE5NlVsam9XUjZybUp1MmhL?=
 =?utf-8?B?d0JTZEZlSzR4MC9kK0E1UHIraTZyTXJvR2dSQjlWSXdRWlllU0tnNlB5dTB1?=
 =?utf-8?B?YW0vQnNsK05jUUo4a05EMms4aXFySjdQVVZlQlZZNW1SUkVJL0owM25tdkxI?=
 =?utf-8?B?SGxFY0pGQmZ2emR5ZkxCb0VRVklYUkZhUXRtNTNWNUJYWlJ5cEh1dWI0Sk9V?=
 =?utf-8?B?S2o4OWoyYlMyaDJZVWR0Y3c0RHoyU01SWjV6VGhqWDZWcjJFV3dweHVOMFBr?=
 =?utf-8?B?QXJXbHd3SG9xaElzcVZydFdoN2Q4THF2VEhxRDBHQk4xWEN4S29WYTFobnZ6?=
 =?utf-8?B?bU9wdXd4TUF3cS9rcWMrNk5Rb3MwczBYV0ZsQ3I3dzczODBXMHplKzVITDVH?=
 =?utf-8?B?b3ZadEphR2ZyZXRYZ1FKNUVUWnhvWHpWQm1NUlZpbTJ1Y3JJTjkwd3NBQUZj?=
 =?utf-8?B?WTY3b3VNTEtyei92RGNkVkJkVVpxa2VIbUlQYU90RXA4Zy9aZWYxT0xTdWM5?=
 =?utf-8?B?dzZuaGROOTZnNEMwL3hiRjU5MVZacmRnOFI1ZlZuWmJMOGFlc01oM1FGbDdW?=
 =?utf-8?B?YThXWU44bU1vVy8vK0loQk5PUlE4M1NwVVo2QWtSTmJhWml6TW13RVgyVy9G?=
 =?utf-8?B?Qmpxcmp1UTdkeDF1T3BFYkZFNmxlSnFHQTBXUmN2Rml5MWVYbWtHa0lKckc2?=
 =?utf-8?B?cGVEYmI2YURpUDJEQ2FLK09scGE2MFNwUXB0c1dKNkdESUdxUlgrQm5SWFQz?=
 =?utf-8?B?eXlTM081elgxS1V0TTZpbHNENTJ2MmxMd2xxczE5c1preUZqdlVteXJoSFRS?=
 =?utf-8?B?dGVTalVRMjZJZEtldVBqbGxYQ3ZydmpsbGU3Q0orVEk4SEdmd1dZZ1VXNHho?=
 =?utf-8?B?dDNQZmVxTzUyWEdXSjl4bUVOK0FXeWgyUWU4VTZmeHJjRXFvNGd5bGJRVmNS?=
 =?utf-8?B?ODJwemFJR09PZVhYbWloMFNIdXVhVCtwYUVzNldnL09lZURmaGRHUzhPdWhT?=
 =?utf-8?B?K2dsbHY0U0lEbU5tYnJPRUg0Q2xPdncxZ25odGVrTTc2djRiaGIyQ010RWlj?=
 =?utf-8?B?UW5OSFBWcDZ1VzdoV0U3N3c2VjFsRDYrdnJSMkxFYXdia1EyaUF1RldaeWJE?=
 =?utf-8?B?eS80WExuT2VWTDltV1NiZC9PYWFTdldSUDFabERLZWU0ZlNMRjl2WmNZM1Y5?=
 =?utf-8?B?N29zc3RBdTJJUjlOOFI2bDlIUWZQYldXaEFVaHZha1c3UE54clJLcUkrRzlS?=
 =?utf-8?B?R3JNdUk5dnhxZ3JrNzAxZW8vcVN1c2N6aDhsbjdiTDdPSDNVTWxKOHowWnda?=
 =?utf-8?B?ZkdnYWdwamRKOUN1TGg1WGxvZlNEYXJMVC9VWml0WmlFb0h6elFwbTZ6cGhC?=
 =?utf-8?B?ZmFaWFJoeHVEOTF5Q0MzSmsvOXV5Q053OFl0aUJuLzJGZ1dtaTFiZXZZVFdJ?=
 =?utf-8?B?Y0hxd1hNMkRTNCtoWktWVDJRMzV0UWZhNXpoMUt6SjFLMHBXQWQ3ZmFTK1ow?=
 =?utf-8?B?Y2NFYk04MHQwdVBWaTdPVThLRGVMYnVIWEF5VmhCREZrTWVtR3E2dnNSVWN4?=
 =?utf-8?Q?2cxKsKZp0SBJ1738/0gk03ek9YTkHwe3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cCt3ek9FbUFsM3Q0V3Rub1NhSm15L2grZDMrOVFOZStmMnJpRlRSaTUrTndD?=
 =?utf-8?B?N09OYmwrMDhQbGhaZkg4dStkU2IwdmFxRHNDODhVV0xWQzl3ZWk1Y1ovQ0pU?=
 =?utf-8?B?d2ZFY0taOWE0OEdDZmIxVmRzV1VlV1lsbWhqbXpHUEE3Z3JNTHg2Qm9lOUtk?=
 =?utf-8?B?MC95bHVyOGFUbEM3RGJYQWx2QW5sYVdhNFNhd2llaEhEcktBWkhpSUFyMG1a?=
 =?utf-8?B?ZkRkNjRrMnhPQVNWSVNFWGZSOEVQZXRJNzR2L3E3RFNiNmN3WEVxQ003Y0ZW?=
 =?utf-8?B?WHFrZ1J5cTlNTFFqQUxHQlhjY0Y4L3NIakErSzE5bVhGc2NrSXR3WkRFK0o3?=
 =?utf-8?B?WGRUUVJMa0cwRWR4bkJWN0ZJblVQdDBSNHBPUlpPbmRzamJ2Ym5odXAvczlF?=
 =?utf-8?B?ZVZKMWU0UmVKaXlVVjY0QUUwUzNicGRXSUlwTHVaN2FxR1ZjS3JaOXZoY2N0?=
 =?utf-8?B?bDdMVmNld2lhV2JQWmVFWmxQR1hOSVJJOHd6cVAvTkt1ZTNDUi82V2d1V3ZF?=
 =?utf-8?B?TjdaSkVZVWNOTm4rNTcvTGNmM3NwMFhPQjlxUTEzVWpDSVU2cnJTSzNKTlla?=
 =?utf-8?B?d25xUVlWalB1RndjVTRlOUlQVXBxcmdoaGF6ZU1oV0pBUmNMSE1GakZ4MExO?=
 =?utf-8?B?czgyM1hrMTNubWhWTXVZTk9CWDBYaXlVQmNPQWplcHgzbVV6dVU0MWhzRU5K?=
 =?utf-8?B?dVZlbmZ1bk1kaWlPQVJmVUozMTZidTJpRmRYNmp2aWhwZjVkVmN5MDc0VGg3?=
 =?utf-8?B?b2pFRE5nREl6dU90SGNPemFES1lqdmpFbSs2cHYrVVJkQnFIcUtXVnVXZmtW?=
 =?utf-8?B?T20yNkkrYndBZk1tTGRCTlBNZ1ppTmhwMVR6Y3VFeDJSeW03Ylc2VTVhSFBT?=
 =?utf-8?B?bnpZakxOZGZlMVR0MHdYRzA5azNIaS9mUmFsYTlBNXBXNHQ2cURVWDFTMHR5?=
 =?utf-8?B?Ulh3TkxkYXV6dUZIUk5abExPU0V5bm5sZVU1Tm1PaHhmcUdndXl1U3RDSC9Y?=
 =?utf-8?B?TURvSTdna25IR2d5Y1J4M01qRTVzSkhWUW9pd2ZJaUs1QjkvQXQ2YzlyV0NH?=
 =?utf-8?B?MVR1NmZIa1IrOTJwMldCeFYvVTV3RDNmbnplQ0tzL2czMzBzOVZiR01kazN5?=
 =?utf-8?B?cVFoaXc3Y0xlZUF6QmdvNDJxNUxOVGJLS3NkaWc3eXV1R1l5YThoRk1wUDRm?=
 =?utf-8?B?NGllV1R1VDBXMEVJOVFCbTJuQXE4bERiVms2TDhyY2ZCeW5GbHRpeDRKVS9C?=
 =?utf-8?B?Y1laKzRMR1plbXRicTZjMVg5SVB2Q0pkeG5MRmdWRXpDOW5QUlVDZ2ptN2RJ?=
 =?utf-8?B?UE9kUS9UZ2NLai93ZFNjcEd4TzRjV2lLTUNWYlV6aVMvc1RaeXBabEtCMDQz?=
 =?utf-8?B?eXFaYzJkV2grbnZTcmh4Ullma0JJNHd1cWk0T2VXaWJjc3F4MXNhUUNhQksr?=
 =?utf-8?B?T01HVjUyWWYwdTRLQUhNVkdpMUZaZDJNbXZSMm4rS2xUM28zc3ZDY2RpVE8z?=
 =?utf-8?B?b2NKSDV4Qys0cFhldFJHS2F1Z1plK2dLaGd1eVJhNFZsUSt5MlkyTjV2YTA3?=
 =?utf-8?B?NEtVbnllc0pGRzVMc1FSYllnQkE0cGdPM01qRDRlS1k0YlA0ME1rTklEaGlq?=
 =?utf-8?B?MTFKZ3RsS3E3L0tNS1RiM1pnd21YWnJNZnZCL2s2Q3p2MUltZDJGNVoxaDR6?=
 =?utf-8?B?ME5xWEQyOU1ZRFcrUnFVQkg4Qk9iV3Z5QzRKQ2V5ajJHL01kZC9IM0pVaFAy?=
 =?utf-8?B?R2I5azl0Vk5RM3cxRzlEQjJ2bDdSU2N1Q0NITGJ4dEFPUk81eVpqbTZ0dmFX?=
 =?utf-8?B?Sk9XTzRNcTl0NjFCazdvU1NMMmxON3UxYXJoV1MvbjdhOHA3SE43dHVuMXhU?=
 =?utf-8?B?QnZzaThJMmUwVVZrckd0RHFuSjJrSGhHYU4xOFVzS1JBS204RG1uTng3ano0?=
 =?utf-8?B?U2phSTV0OEFkVVlhZXQ3MmhPMXdZR2hIQnhwcE5EZm95N3FJL25nME0yM3ZC?=
 =?utf-8?B?SFJoTjA1TVZ0b0JjV1dsKzNEamRjMS9CV1NEb2tyY21jcjNWdnJIV0tPZTZw?=
 =?utf-8?B?S2lzVUxsV0VoTnoxUCtNcVpoL09hbmloTFFiWnJlYWcwRDEyZmxyUTUrTXhL?=
 =?utf-8?Q?EWdFF4wRoafq58TePb/5mD6g4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e9dd2d-0ee3-49bc-f164-08de241f49b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 08:16:33.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkv52ViL7rENcPDc2dxMoDiXlVjQkBIqyrLktyvUz3tPoCdMJPGsXeVp6Q4gRv7KMnQGVdo1ZvCguotyzKKGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443


On 11/14/25 00:25, Alison Schofield wrote:
> On Mon, Nov 10, 2025 at 03:36:41PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
> Hi Alejandro,
>
> I'v been looking at Terry's set and the cxl-test build circular
> dependencies. I think this patch may be 'stale', at least in
> the comments, maybe in the wrapped function it removes.


Hi Allison,


I think you are right regarding the comments. I did not update them 
after Terry's changes.


>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
> Terry moves the whole file cxl/pci.c to cxl/core/pci_drv.c.
> That is reflected in what you actually do below, but not in this
> comment.
>
>> Fix cxl mock tests affected by the code move, deleting a function which
>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>> setup RCH dport component registers from RCRB").
> This I'm having trouble figuring out. I see __wrap_cxl_rcd_component_reg_phys()
> deleted below. Why is that OK? The func it wraps is still in use below, ie it's
> one you move from core/pci_drv.c to core/pci.c.


I think the comment refers to usage inside the tests. Are you having 
problems or seeing any problem with this removal?


Thank you.




>
> For my benefit, what is the intended difference between what will be
> in core/pci.c and core/pci_drv.c ?
>
> --Alison
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/core.h       |  3 ++
>>   drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
>>   drivers/cxl/core/regs.c       |  1 -
>>   drivers/cxl/cxl.h             |  2 -
>>   drivers/cxl/cxlpci.h          | 13 +++++++
>>   tools/testing/cxl/Kbuild      |  1 -
>>   tools/testing/cxl/test/mock.c | 17 ---------
>>   8 files changed, 78 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index a7a0838c8f23..2b2d3af0b5ec 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
>>   static inline int cxl_pci_driver_init(void) { return 0; }
>>   static inline void cxl_pci_driver_exit(void) { }
>>   #endif
>> +
>> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>> +					   struct cxl_dport *dport);
>>   #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a66f7a84b5c8..566d57ba0579 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>>   
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map,
>> +				  struct cxl_dport *dport)
>> +{
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	map->resource = component_reg_phys;
>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +			      struct cxl_register_map *map)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(pdev, type, map);
>> +
>> +	/*
>> +	 * If the Register Locator DVSEC does not exist, check if it
>> +	 * is an RCH and try to extract the Component Registers from
>> +	 * an RCRB.
>> +	 */
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) =
>> +			cxl_pci_find_port(pdev, &dport);
>> +		if (!port)
>> +			return -EPROBE_DEFER;
>> +
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>> +		if (rc)
>> +			return rc;
>> +
>> +	} else if (rc) {
>> +		return rc;
>> +	}
>> +
>> +	return cxl_setup_regs(map);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>> +
>>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   {
>>   	int speed, bw;
>> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
>> index 18ed819d847d..a35e746e6303 100644
>> --- a/drivers/cxl/core/pci_drv.c
>> +++ b/drivers/cxl/core/pci_drv.c
>> @@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   	return 0;
>>   }
>>   
>> -/*
>> - * Assume that any RCIEP that emits the CXL memory expander class code
>> - * is an RCD
>> - */
>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>> -{
>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> -}
>> -
>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> -				  struct cxl_register_map *map,
>> -				  struct cxl_dport *dport)
>> -{
>> -	resource_size_t component_reg_phys;
>> -
>> -	*map = (struct cxl_register_map) {
>> -		.host = &pdev->dev,
>> -		.resource = CXL_RESOURCE_NONE,
>> -	};
>> -
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>> -		return -ENXIO;
>> -
>> -	map->resource = component_reg_phys;
>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> -
>> -	return 0;
>> -}
>> -
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map)
>> -{
>> -	int rc;
>> -
>> -	rc = cxl_find_regblock(pdev, type, map);
>> -
>> -	/*
>> -	 * If the Register Locator DVSEC does not exist, check if it
>> -	 * is an RCH and try to extract the Component Registers from
>> -	 * an RCRB.
>> -	 */
>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> -		struct cxl_dport *dport;
>> -		struct cxl_port *port __free(put_cxl_port) =
>> -			cxl_pci_find_port(pdev, &dport);
>> -		if (!port)
>> -			return -EPROBE_DEFER;
>> -
>> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -	} else if (rc) {
>> -		return rc;
>> -	}
>> -
>> -	return cxl_setup_regs(map);
>> -}
>> -
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index fb70ffbba72d..fc7fbd4f39d2 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   		return CXL_RESOURCE_NONE;
>>   	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1517250b0ec2..536c9d99e0e6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   		      struct cxl_register_map *map);
>>   int cxl_setup_regs(struct cxl_register_map *map);
>>   struct cxl_dport;
>> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>> -					   struct cxl_dport *dport);
>>   int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>   
>>   #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 3526e6d75f79..24aba9ff6d2e 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>   	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>>   }
>>   
>> +/*
>> + * Assume that the caller has already validated that @pdev has CXL
>> + * capabilities, any RCiEP with CXL capabilities is treated as a
>> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
>> + * registers in a Root Complex Register Block (RCRB).
>> + */
>> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +
>>   int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>   struct cxl_dev_state;
>>   void read_cdat_data(struct cxl_port *port);
>> @@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>   						struct device *host) { }
>>   #endif
>>   
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index d8b8272ef87b..d422c81cefa3 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
>>   ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>>   ldflags-y += --wrap=cxl_await_media_ready
>>   ldflags-y += --wrap=devm_cxl_add_rch_dport
>> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>>   ldflags-y += --wrap=cxl_endpoint_parse_cdat
>>   ldflags-y += --wrap=cxl_dport_init_ras_reporting
>>   ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index 995269a75cbd..92fd5c69bef3 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>   
>> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>> -						  struct cxl_dport *dport)
>> -{
>> -	int index;
>> -	resource_size_t component_reg_phys;
>> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>> -
>> -	if (ops && ops->is_mock_port(dev))
>> -		component_reg_phys = CXL_RESOURCE_NONE;
>> -	else
>> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>> -	put_cxl_mock_ops(index);
>> -
>> -	return component_reg_phys;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>> -
>>   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>   {
>>   	int index;
>> -- 
>> 2.34.1
>>

