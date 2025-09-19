Return-Path: <netdev+bounces-224772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6BB898BF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D3A5A1F66
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F9224AFA;
	Fri, 19 Sep 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A5PVU/mS"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26D222587;
	Fri, 19 Sep 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286292; cv=fail; b=SDCbpyRp+BWA9/7ZRHsOUt8XJ2AA27cwpeumI/D38E6tPOAyQOorMoqINcuC2pR5X6E/cOTODeo+Kf07OmJQacWeIihl9M88Hv+V0FKAIUT0JlJxTyQ2uQEq5utunluLYM8JIGyHFDhYAYuqo9Zd12yVEgJjUOr1yIGQeTO5OOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286292; c=relaxed/simple;
	bh=KPJh1bsFbWpheGcu0nW5mzgEuAtgSFW+ym06xddPdoQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MomOXaYqmbRmSjF9hcPN+qq6VSod6WgJzbRpSl4glS7aLQ42l5pLJkoPcxL8KoqXBiaBLeKeybA0RAyZqeEPNMOREARc8OKk3LafQDFaXEg9NPE/Rp5CfsWYRqqtuw3hR1g47ztVZYsprigf0wHVAvHssJxzJ1OpW6Z4FZ6HjTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A5PVU/mS; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnY0E76KVAOp9XlYZ0UeyBeZeMw43k6IQOS760HBawSkSHysUqaVwa7uk54n7787pi2dV/GLMzbOxUb58XpzMXX/hfV5RCzzFCnSmRV+N973Mq4cG0EYA8huc07nby3THh2xKxTpvnZbgwWomnXT1b/lcu3OWniSKFcPbHHXxk8WfruaxRmKmFYY7DsN56a4SFFedYkwykB5a0NgM0UtzaCdAypU2PTMUpcJXFsKZfxi8bQHHOr6HmTHF9wrX2OhPVWoc/a6vc4MpIV3muoctvKvG03/+avLVtWH9dl4PiI6qxxOs1j61FX6fRee0+fEbt31o0LOoq/Itewdj50rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7ncK6KJI1DaHAqNWjVspHIkGGtzhsrzb4RdJAW0Wyo=;
 b=desx4W/iCtYKYULLNidWYE/lvgyUNIKqQ0CpeLeHg/l95IOS6dl7lUZ49okBt4Ra+aZUJjfL5tz0GijAPEUM1EozZEzje0VNXuJ7ijGvwPNa9TbQJKFPuoUbdgrH5PV3alNF1zDDFlchY5EcyoIqdmbnCGMPbGdIXlaR4fkjwtdvn6MPVVEX3SAVcTJr+qHqxpg/bApp+hTwVUS31q2RbcdvUt282QUgwBCJRbMXt/oWCkqxqsg7QcLzgmzLq+u5HuDRGQCYgpNQr9nYDal7buc9a9mnuo6tI9nRIhQ+M981c6HW7tfqB142Mtzr8Zi5q2BoV6mMLvfL1uiD7a8KGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7ncK6KJI1DaHAqNWjVspHIkGGtzhsrzb4RdJAW0Wyo=;
 b=A5PVU/mS4cSFzMoQo4BHddOoWJGQpqInBnZEVY206dZ0KvmQ7TvnOdoodsyS9lC7FXcsTVxnKbB5IWQmN5ZHZYk5V/sYF431BotJlHTa9ZGuhio/5KPP5EBOnYiP6WhXzWHzPM89iJrs8evm+BzL3H/I0L5a51sQA/hNk/O8nRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 12:51:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 12:51:26 +0000
Message-ID: <96586036-bc44-463e-ab49-44c07a6e6c26@amd.com>
Date: Fri, 19 Sep 2025 13:51:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 00/20] Type2 device basic support
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 806bc5a3-564f-4f86-8b18-08ddf77b3ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2tmVGxXQWlhY2EybXp4b0s1RDQ1blFYeCsrNkNSbzJpa2pjSjcwL3loNlA4?=
 =?utf-8?B?aHZHeHpzVGZON0JHV2tmNnVGcUM2T09XN3hTYUN4S1VteWNaK3pzbEFYY1VM?=
 =?utf-8?B?cjBra1FBclpldUpNMWpDc2I2bm9JMFRBL0Q2MitLOWZ5cWpHM3krZkhseEVo?=
 =?utf-8?B?aU1ISnJFMDNnMkp0eWJTTUdoMjh5blNBdUlSZXpRYllEdURmNm9zcUZsdkxV?=
 =?utf-8?B?WjZWdmNRYUJMak00MnNEZDh4K00ya2M1aE1HVHBvTlg2UXRSS0xxTkQ4TWVa?=
 =?utf-8?B?ZjVJL25jYkYvV1IzTXo3MFFMSnQ4U1k2Vy9FelduOWdTOEs5M2ZLeFlJakhh?=
 =?utf-8?B?SzBMNk5tbWpiWEc3MW1hazJxZWV0bFFUTVdYT0o0M3d6MHdlYnlGQmtSZElU?=
 =?utf-8?B?Y0tyTXRVTjc2SlB5RzBic1RCdStZbE00Rk5HOFVFczVESXN4SHNFajk3dmFL?=
 =?utf-8?B?MjcxcnJFUXhwRXhSOE1pbDBvZFQrVU5GWnBpWlY0Q0w5Nkl6cWcwT0JiODE4?=
 =?utf-8?B?Uk9vSUl6cW1jNC85cDM5aGM2QkZ3Q2dOVkw5d2RqNy9TSVc2c0sxZk5TRDZq?=
 =?utf-8?B?SnJUTjVmUGc1dDNzanF3aWtHMEZYVmFOWG1kcVk5MndOOEtDQ1ZVeWh2WXEx?=
 =?utf-8?B?Y3lvU1ZvYW82UGZ3dUZJeW1lT0Y1d044S09tSGxMaG8rQ2xYTGhEWmV5dUlp?=
 =?utf-8?B?L250MEFvM0I0Vkl1OFFjVnZMeGNUeGIvT3FQa01xTGFibnRxTkVRRlEza3FD?=
 =?utf-8?B?UFgwRmZ6NDZxNDFkWUdxWW5tSlJNeWMrMUpOcGhwRDBoeEI4K01mVGxZQmc1?=
 =?utf-8?B?TnZudVdzUERUd29MZFk5Q3dGSVlBMDVKTDJYNlBteS81S0tNNHN4dGR4cVgz?=
 =?utf-8?B?SU5qUEp1SlhKSCtEZHhoVmh3dUxKMy92M3g1UEtFak9WQ3dFMUM4TGExSnhE?=
 =?utf-8?B?ZWt3NHJtbXBJQXBraVYrQ0Q3T3NKa0FKLzYyYm5uM2d0NVJ1WFJTd0hMUDlM?=
 =?utf-8?B?U0gzeGJ0L2xHL3Y2czdGWHdxQlA2RlFqZWdsT2NtM1k5SHFQbXlWWklROTNp?=
 =?utf-8?B?aVlkQ2dkcnB6aGxFcDVlcFpxU1NpdGJHS0YxR1pCS1kyYUdIUlQ3OFc5RThC?=
 =?utf-8?B?SGJ5T0N2cmlSLzd5Y0RqSHF5c2E3U0hQNVNGa0JSZzJnSHk2bVNUZTdCTnFK?=
 =?utf-8?B?TG5Nem1ZWUIyUFN4eEVZbEZiTis4c2UyVkVXQVFXYTZqaUlKa0s1eHc0MVYr?=
 =?utf-8?B?NHhCbmFzTlA5NnRia01KVENUaGhabjdISDVTTVJzRmlRYzE4elpYTTl5T3hX?=
 =?utf-8?B?aU0ydmFUc3ZQRUZteHVKSjVlSjFNNC9LdFU4UzJGMXRheVBwZXAzaVFiV2xi?=
 =?utf-8?B?ZERmZTYzWEpUd3BLdHQxc3BjS3NmVjBhNlZFNTRCdlRyMy9hRjhCbW9oc0lS?=
 =?utf-8?B?aFJVYnBwUmp0U2FLVGNsRFd1SFFQRHNodGZnejJtMURvVTJXTGFpR2lCTnBm?=
 =?utf-8?B?bjZMRm5VNFBnSUZEWFh4emY3NEVNVStvNlZmeHZRV3crcFI5QzZYbFFHQ0JQ?=
 =?utf-8?B?YVA5OTNWSjJ6OE9VWmgxR0ZBUmVqTm5ZK2cxZW5YMWhWdTJwUmF1VUpEaWVB?=
 =?utf-8?B?OXg0b1NPbVRyYmk4cmVRdWRETkh4MFlPczJRZ1JZMTlreVF3L3lpci9tdUpF?=
 =?utf-8?B?dVNGdVJoMkNxNkFlM1RSeU1PSU5VU2N3NEFsNXVmU2h0U1BrMDJUTkJOUTRG?=
 =?utf-8?B?QVhxQXNFcms2R1h2QlNYaUhjN2IrNnNCMTRLSzd6YzJXZlNPazV2Q09ZK0JC?=
 =?utf-8?B?VGpBK09NNGxTUkVFaEUxb3ZySWZtN2tJYVRTSlBqS3BlNjhZKzBIZFlxU3VV?=
 =?utf-8?B?V0trSlY5MVl6VVFTYjQySHhwTWpwdG41T2tTK2lFV1oxOU8vT2IxWGZWZ3RX?=
 =?utf-8?Q?sHzhWf8Qahg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tLcVJmeTAyM3VzYWV6bXBwYVFwenFweDJsbXZDdHZZRCtEbTdNdzU4VDhX?=
 =?utf-8?B?Ni9SdU55K2FIRzRnYWhxeWxTcUh2eS9SR2c0MzBUZ3JjK0hQY1NEQUY2N3py?=
 =?utf-8?B?ZHUzUElLeHpMOStaV2Y3ODRHTTJob0t2U2E0WWFXa3UxRnpBbVZWWFI2dGZH?=
 =?utf-8?B?OGFIWSsxU3BQOTJUMGVKQ25ldDFGaFJHcG10K05OdXFUYXNUdXJDazJwRzRZ?=
 =?utf-8?B?bnBlQmV0WGNIOG5LZ3pDK3dvRm9pSjRyempuQ0Z3d0ZmL2FReU9kWmtYTHNs?=
 =?utf-8?B?Qjl5dmlnSkRKMWYyRlNFdEJLSlZRS2F0QjRHaFhneDNTci9WVTc3OHBsaVpO?=
 =?utf-8?B?ekcvSlduc1BscXl1SCtnVnNOY2xyK0FjRUNZYXNCM2lmcXNtNjJkSUZ2RzJK?=
 =?utf-8?B?UDN5dFZIQTlkcGlZaHEzZXdGV1FzRk9ZVUZ0RFlnU1NGdkxTNlNuYm1KMEg2?=
 =?utf-8?B?NGNJMW11aXN6UkJLS3lnMXNTYUNmTnAwLytUdFM2ZUVSTHdHRzg1RTRCNCtF?=
 =?utf-8?B?anVvallSeDZ3a0JHUVY0dldmelVzNDdYTUlVRWhjV2V4TXZ6Z2FxSjV3KzJO?=
 =?utf-8?B?Z1psYVlxeXFSVXY3ZEh1Q2NndW1HdWUzMW1HWENiWjlwOGJoYWNhWEwwait1?=
 =?utf-8?B?Y09XTWYzbVF6SWxKQW95aENMSGJ0S2NWbnBYbVZVcXJmSlY1ZnhQY3gycG5h?=
 =?utf-8?B?ajJodDAybGs3TkdqOUxtZERvRkV3TUJRcWZkU3dIYWl3VjZoaDgyWmpUbHB2?=
 =?utf-8?B?SXhrRVhoNUo2b0czcHNuL2E3MGFSdlRZQTc2akQ5UnI3ZklLeXZxbDcxZC9y?=
 =?utf-8?B?SFQrUHMxN00yd0ZkOHJhbUxXZEJBaVBoR0FJdDlpQ1VIa0lXVENyOUlQMWI0?=
 =?utf-8?B?dU9HU2pyZnIwd2lIdHZycm5SY1VvbHZpbFRsRmtTVzI5Zm8vUjhLeEMybVkx?=
 =?utf-8?B?enJZZGJMMWpYaVdUTDNoR2VLZnh4cUc1K1d6NkNHN2xCaklwTFo3VEtRT2c2?=
 =?utf-8?B?aUFBVTN5UHhkWmlvWGdTemd5MWpKVDdXaDdwUmE0V01IT1I0NkpiVjExazMx?=
 =?utf-8?B?Y1RsaDFVTzEyTGtZSkNIZFVhRkU0TXBIMFpHSm1kWTkwSTVhYmxlT3ZtZEtv?=
 =?utf-8?B?ekZqSGE0NmtZZmZHaDR4NlREdWlXcnVWOUFNVEY3Qzh2dzRLNW5qeWRHbHJj?=
 =?utf-8?B?NENaSlN3MlB5WWdOam1jYS8zV1h0SndVUURjOE9iM3pPQXFuZnJPNG5aSWRS?=
 =?utf-8?B?bGNHVkZUN3krM1BoRGIxNW9GdGluY1UwZnlhWDMyZEdvVm1VaG9wQXJuT2Ry?=
 =?utf-8?B?L3ltTGJpS3RqNzJ2L1RVcmVnNmNVMDY3ZC9iWTk4V2ZUODhEU0xRYVNZOHpq?=
 =?utf-8?B?VzAxeEJ1VVRWMy9lbHNWakJTSXJ4MG5hMUNUSEhscmtqRW1aRlhCRGg0WTVM?=
 =?utf-8?B?TExVcjVkd2o3Nm8yTnJ0Zm16cWRuZDd5QnJtS0hWMWhENzl2UXFlMnJZS09F?=
 =?utf-8?B?aFZjR0IyK3IycS9IRWU2SUVVbHUwTkx4b0JOVkFCa1ptUlE0dEVhMjUvRzJH?=
 =?utf-8?B?MXowWmI3eXlFeFRWUlNPQ2xTMk9MMWtLQlQvVjZMMk5TQWhadGRtejJoVGFU?=
 =?utf-8?B?cGtiRkZ3VlFFQjc0dk1zRmllUW5Dcyt5bVZFZzZPZW0vLy9nRVA1ZVRqd1VM?=
 =?utf-8?B?K0IxNmNZUE9UVFZiNXppTGxXYkdoSXh3aCtoVjR3RHQ2U3Q4Vk5PNDBKUGsv?=
 =?utf-8?B?Y21INGFac3pFdTJpVmowbDlHa1RDRGk0TWhEbDJReE40dE5OaEJTdTd4WStl?=
 =?utf-8?B?SktobUpuTTZKSnFBWHl6OUxHMnRxbU1SOGJkMjhtcFN1cWtjbEpWY3paVHBV?=
 =?utf-8?B?MVNhVVJiVlhnN2p1TzVFaU1rcjlvRUV0ZjFpRXpXdXdHL3ZUN3VScmhYV3RM?=
 =?utf-8?B?OXhpMVJOcitscUNoK3dEWWFkZEZVd252OE5Hb2MvcHZRRTAzQ21pdWpBOHEy?=
 =?utf-8?B?clo1R1IxckhORjlNR0JBZk1LQy81RW9oRTJNSDNsaVFlOUhTbVB4QWxsMy9i?=
 =?utf-8?B?Y3lmU2NBZm5iSnRscGE4Q2l2dUVwUjNBRjdwRnlPb0JIRXoveVJ3Q0xGWW5k?=
 =?utf-8?Q?4ErlY6NYVFkDfq8brwUkZCgqD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bc5a3-564f-4f86-8b18-08ddf77b3ebb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 12:51:26.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zysd2zTKgpw0G5glSQp/pwWPq71yZwpGWadkDCTS8LK72kjKxrky3bDXJ5r4xh1q8hdDt2btLnyZYLeuc3Otfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374


On 9/18/25 10:17, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> First of all, the patchset should be applied on the described base
> commit then applying Terry's v11 about CXL error handling plus last four
> pathces from Dan's for-6.18/cxl-probe-order branch.
>
> Secondly, this is another try being aware it will not be the last since
> there are main aspects to agree on. The most important thing is to decide
> how to solve the problem of type2 stability under CXL core events. Let me
> start then defining that problem listing the events or situations pointed
> out but, I think, not clearly defined and therefore creating confusion, at
> least to me.
>
> We have different situations to be aware of:
>
>
> 1) CXL topology not there or nor properly configured yet.
>
> 2) accelerator relying on pcie instead of CXL.io
>
> 3) potential removal of cxl_mem, cxl_acpi or cxl_port
>
> 4) cxl initialization failing due to dynamic modules dependencies
>
> 5) CXL errors
>
>
> Dan's patches from the cxl-probe-order branch will hopefully fix the last
> situation. I have tested this and it works as expected: type2 driver
> initialization can not start because module dependencies. This solves
> #4.


FWIW, I did not realize that those patches solve partially #3, as 
cxl_mem and cxl_port has now dependencies and can not be removed. 
However, cxl_acpi is still remaining as a potential issue.


> Using Terry's patchset, specifically pcie_is_cxl function, solves #2.
>
> Regarding #5, I think Terry's patchset introduces the proper handling for
> this, or at least some initial work which will surely require adjustments,
> and of course Type2 using it, which is not covered in v18 and I prefer
> to add in a followup work.
>
> About #3, the only way to be protected is partially during initialization
> with cxl_acquire (patch 8), and afer initialization with a callback to the
> driver when cxl objects are removed (callback given when creating cxl
> region at patch 16, used by sfc driver in patch 18). Initially, cxl_acquire
> was implemented with other goal (next point) but as it can give
> protection during initialization, I kept it. About the callback, Dan
> does not like it, and Jonathan not keen of it. I think we agreed the
> right solution is those modules should not be allowed to be removed if
> there are dependencies, and it requires work in the cxl core for
> support that as a follow-up work. Therefore, or someone gives another
> idea about how to handle this now, temporarily, without that proper
> solution, or I should delay this full patchset until that is done.
>
> Then we have #1 which I admit is the most confusing (at least to me).
> If we can not solve the problem of the proper initialization based on the
> probe() calls for those cxl devices to work with, then an explanation
> about this case is needed and, I guess, to document it.
>
> AFAIK, the BIOS will perform a good bunch of CXL initialization (BTW, I
> think we should discuss this as well at some point for having same
> expectations about what and how things are done, and also when) then the
> kernel CXL initialization will perform its own bunch based on what the
> BIOS is given. That implies CXL Root ports, downstream/upstream cxl
> ports to be register, switches, ... . If I am not wrong, that depends on
> subsys_initcall level, and therefore earlier than any accelerator driver
> initialization. Am I right assuming once those modules are done the
> kernel cxl topology/infrastructure is ready to deal with an accelerator
> initializing its cxl functionality? If not, what is the problem or
> problems? Is this due to longer than expected hardware initialization by
> the kernel? if so, could it not be left to the BIOS somehow? is this due
> to some asynchronous initialization impossible to avoid or be certain
> of? If so, can we document it?
>
> I understand with CXL could/will come complex topologies where maybe
> initialization by a single host is not possible without synchronizing
> with other hosts or CXL infrastructure. Is this what is all this about?
>
>
> v18 changes:
>
>    patch 1: minor changes and fixing docs generation (Jonathan, Dan)
>   
>    patch4: merged with v17 patch5
>
>    patch 5: merging v17 patches 6 and 7
>
>    patch 6: adding helpers for clarity
>
>    patch 9:
> 	- minor changes (Dave)
> 	- simplifying flags check (Dan)
>
>    patch 10: minor changes (Jonathan)
>
>    patch 11:
> 	- minor changes (Dave)
> 	- fix mess (Jonathan, Dave)
>
>    patch 18: minor changes (Jonathan, Dan)
>    
> v17 changes: (Dan Williams review)
>   - use devm for cxl_dev_state allocation
>   - using current cxl struct for checking capability registers found by
>     the driver.
>   - simplify dpa initialization without a mailbox not supporting pmem
>   - add cxl_acquire_endpoint for protection during initialization
>   - add callback/action to cxl_create_region for a driver notified about cxl
>     core kernel modules removal.
>   - add sfc function to disable CXL-based PIO buffers if such a callback
>     is invoked.
>   - Always manage a Type2 created region as private not allowing DAX.
>
> v16 changes:
>   - rebase against rc4 (Dave Jiang)
>   - remove duplicate line (Ben Cheatham)
>
> v15 changes:
>   - remove reference to unused header file (Jonathan Cameron)
>   - add proper kernel docs to exported functions (Alison Schofield)
>   - using an array to map the enums to strings (Alison Schofield)
>   - clarify comment when using bitmap_subset (Jonathan Cameron)
>   - specify link to type2 support in all patches (Alison Schofield)
>
>    Patches changed (minor): 4, 11
>
> v14 changes:
>   - static null initialization of bitmaps (Jonathan Cameron)
>   - Fixing cxl tests (Alison Schofield)
>   - Fixing robot compilation problems
>
>    Patches changed (minor): 1, 4, 6, 13
>
> v13 changes:
>   - using names for headers checking more consistent (Jonathan Cameron)
>   - using helper for caps bit setting (Jonathan Cameron)
>   - provide generic function for reporting missing capabilities (Jonathan Cameron)
>   - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
>   - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>   - avoiding rc variable when possible (Jonathan Cameron)
>   - fix spelling (Simon Horman)
>   - use scoped_guard (Dave Jiang)
>   - use enum instead of bool (Dave Jiang)
>   - dropping patch with hardware symbols
>
> v12 changes:
>   - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
>   - add public/private sections in now exported cxl_dev_state struct (Ben
>     Cheatham)
>   - fix cxl/pci.h regarding file name for checking if defined
>   - Clarify capabilities found vs expected in error message. (Ben
>     Cheatham)
>   - Clarify new CXL_DECODER_F flag (Ben Cheatham)
>   - Fix changes about cxl memdev creation support moving code to the
>     proper patch. (Ben Cheatham)
>   - Avoid debug and function duplications (Ben Cheatham)
>
> v11 changes:
>   - Dropping the use of cxl_memdev_state and going back to using
>     cxl_dev_state.
>   - Using a helper for an accel driver to allocate its own cxl-related
>     struct embedding cxl_dev_state.
>   - Exporting the required structs in include/cxl/cxl.h for an accel
>     driver being able to know the cxl_dev_state size required in the
>     previously mentioned helper for allocation.
>   - Avoid using any struct for dpa initialization by the accel driver
>     adding a specific function for creating dpa partitions by accel
>     drivers without a mailbox.
>
> v10 changes:
>   - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
>     memory after all and facilitates the setup.
>   - Adapt core for using cxl_memdev_state allowing accel drivers to work
>     with them without further awareness of internal cxl structs.
>   - Using last DPA changes for creating DPA partitions with accel driver
>     hardcoding mds values when no mailbox.
>   - capabilities not a new field but built up when current register maps
>     is performed and returned to the caller for checking.
>   - HPA free space supporting interleaving.
>   - DPA free space droping max-min for a simple alloc size.
>
> v9 changes:
>   - adding forward definitions (Jonathan Cameron)
>   - using set_bit instead of bitmap_set (Jonathan Cameron)
>   - fix rebase problem (Jonathan Cameron)
>   - Improve error path (Jonathan Cameron)
>   - fix build problems with cxl region dependency (robot)
>   - fix error path (Simon Horman)
>
> v8 changes:
>   - Change error path labeling inside sfc cxl code (Edward Cree)
>   - Properly handling checks and error in sfc cxl code (Simon Horman)
>   - Fix bug when checking resource_size (Simon Horman)
>   - Avoid bisect problems reordering patches (Edward Cree)
>   - Fix buffer allocation size in sfc (Simon Horman)
>
> v7 changes:
>
>   - fixing kernel test robot complains
>   - fix type with Type3 mandatory capabilities (Zhi Wang)
>   - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>   - add sanity check when dealing with resources arithmetics (Fan Ni)
>   - fix typos and blank lines (Fan Ni)
>   - keep previous log errors/warnings in sfc driver (Martin Habets)
>   - add WARN_ON_ONCE if region given is NULL
>
> v6 changes:
>
>   - update sfc mcdi_pcol.h with full hardware changes most not related to
>     this patchset. This is an automatic file created from hardware design
>     changes and not touched by software. It is updated from time to time
>     and it required update for the sfc driver CXL support.
>   - remove CXL capabilities definitions not used by the patchset or
>     previous kernel code. (Dave Jiang, Jonathan Cameron)
>   - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
>   - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
>   - Fix construct_region use of rwsem (Zhi Wang)
>   - Obtain region range instead of region params (Allison Schofield, Dave
>     Jiang)
>
> v5 changes:
>
>   - Fix SFC configuration based on kernel CXL configuration
>   - Add subset check for capabilities.
>   - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>     Cheatham)
>   - Add option for creating dax region based on driver decission (Ben
>     Cheatham)
>   - Using sfc probe_data struct for keeping sfc cxl data
>
> v4 changes:
>
>   - Use bitmap for capabilities new field (Jonathan Cameron)
>   - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
>   - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
>   - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
>   - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
>     MODULE_SOFTDEP instead.
>
> v3 changes:
>
>   - cxl_dev_state not defined as opaque but only manipulated by accel drivers
>     through accessors.
>   - accessors names not identified as only for accel drivers.
>   - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>     (drivers/cxl/core/pci.c).
>   - capabilities field from u8 to u32 and initialised by CXL regs discovering
>     code.
>   - add capabilities check and removing current check by CXL regs discovering
>     code.
>   - Not fail if CXL Device Registers not found. Not mandatory for Type2.
>   - add timeout in acquire_endpoint for solving a race with the endpoint port
>     creation.
>   - handle EPROBE_DEFER by sfc driver.
>   - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
>   - factoring out interleave ways and granularity helpers from type2 region
>     creation patch.
>   - restricting region_creation for type2 to one endpoint decoder.
>
> v2 changes:
>
> I have removed the introduction about the concerns with BIOS/UEFI after the
> discussion leading to confirm the need of the functionality implemented, at
> least is some scenarios.
>
> There are two main changes from the RFC:
>
> 1) Following concerns about drivers using CXL core without restrictions, the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
>
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.
>
> RFC:
>
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
> expanders. Type2 CXL devices, aka device accelerators, share some functionalities
> but require some special handling.
>
> First of all, Type2 are by definition specific to drivers doing something and not just
> a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI driver
> as for memory expanders. Most of such setup needs to use current CXL core code
> and therefore needs to be accessible to those vendor drivers. This is accomplished
> exporting opaque CXL structs and adding and exporting functions for working with
> those structs indirectly.
>
> Some of the patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing as co-developer, and a link to the original patch.
>
> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.
>
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/
>
> Alejandro Lucero (20):
>    cxl: Add type2 device basic support
>    sfc: add cxl support
>    cxl: Move pci generic code
>    cxl: allow Type2 drivers to map cxl component regs
>    cxl: Support dpa initialization without a mailbox
>    cxl: Prepare memdev creation for type2
>    sfc: create type2 cxl memdev
>    cx/memdev: Indicate probe deferral
>    cxl: Define a driver interface for HPA free space enumeration
>    sfc: get root decoder
>    cxl: Define a driver interface for DPA allocation
>    sfc: get endpoint decoder
>    cxl: Make region type based on endpoint type
>    cxl/region: Factor out interleave ways setup
>    cxl/region: Factor out interleave granularity setup
>    cxl: Allow region creation by type2 drivers
>    cxl: Avoid dax creation for accelerators
>    sfc: create cxl region
>    cxl: Add function for obtaining region range
>    sfc: support pio mapping based on cxl
>
>   .../driver-api/cxl/theory-of-operation.rst    |   3 +
>   drivers/cxl/core/core.h                       |   9 +-
>   drivers/cxl/core/hdm.c                        |  83 ++++
>   drivers/cxl/core/mbox.c                       |  63 +--
>   drivers/cxl/core/memdev.c                     | 154 +++++-
>   drivers/cxl/core/pci.c                        |  63 +++
>   drivers/cxl/core/port.c                       |   3 +-
>   drivers/cxl/core/region.c                     | 442 ++++++++++++++++--
>   drivers/cxl/core/regs.c                       |   2 +-
>   drivers/cxl/cxl.h                             | 125 +----
>   drivers/cxl/cxlmem.h                          |  94 +---
>   drivers/cxl/cxlpci.h                          |  21 +-
>   drivers/cxl/mem.c                             |  53 ++-
>   drivers/cxl/pci.c                             |  86 +---
>   drivers/cxl/port.c                            |   5 +-
>   drivers/net/ethernet/sfc/Kconfig              |  10 +
>   drivers/net/ethernet/sfc/Makefile             |   1 +
>   drivers/net/ethernet/sfc/ef10.c               |  62 ++-
>   drivers/net/ethernet/sfc/efx.c                |  15 +-
>   drivers/net/ethernet/sfc/efx.h                |   1 +
>   drivers/net/ethernet/sfc/efx_cxl.c            | 191 ++++++++
>   drivers/net/ethernet/sfc/efx_cxl.h            |  40 ++
>   drivers/net/ethernet/sfc/net_driver.h         |  12 +
>   drivers/net/ethernet/sfc/nic.h                |   3 +
>   include/cxl/cxl.h                             | 295 ++++++++++++
>   include/cxl/pci.h                             |  40 ++
>   tools/testing/cxl/Kbuild                      |   1 -
>   tools/testing/cxl/test/mem.c                  |   3 +-
>   tools/testing/cxl/test/mock.c                 |  17 -
>   29 files changed, 1449 insertions(+), 448 deletions(-)
>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>   create mode 100644 include/cxl/cxl.h
>   create mode 100644 include/cxl/pci.h
>
>
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
> prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
> prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
> prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4

