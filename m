Return-Path: <netdev+bounces-226442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40502BA0709
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D77B0956
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F92E1EE2;
	Thu, 25 Sep 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIt9ixoH"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7B241663
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815318; cv=fail; b=pnXsQIn9AbVV/k4HwaTj42VUrR9kZEEEb9s9q1739cUQXuxwNM56U2xOMY9A9uyhnX9/9DaH9oFM2IeRT8NROqVbaEMzabswviwy1Qn0ILMa01C+wIlTvaGTZ+oHPgOQghfYn9k6UHb8ynWaA7p5DcfD/IY3yQSBp99MDOBiNqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815318; c=relaxed/simple;
	bh=WmcvC0YFrJCwhRNfSiZ49bFAn89Z26NQIBR09W7GiVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwvSnrl4TsCLcB5XhWcxXjnLmbUC4gn5SZnScm7i6fWUegx0Fn2i4llWXTonqf8Hk8uouYGhEEaUnmoySzcerH7Ej8YU5ibFqi8FE/K+G4YxKhUL64unt6ZKdjevUmNuurXjMIrcEWT5faIBYH88QwzZHkai2pdxhN7OY23DBwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIt9ixoH; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JilzzDdjd0Pe9S+/IbQ0LaLQkfzYohipUUY0FarEBAWHhfGoOqKvIFaiN2Kvj7+duVLXx/KYO2s/ccJbpFRV7vVZApNPRi7StN0d295qInBP4yth0cmG/1TrrSvPu11zSyHdPtl+EcQjD1d1r70Q2oGvkbMG1aI5tfwL8zgw7NV7XBSjv4Lh+zNn4CAbja2YD4AecKKdrbdtTMIMR/5ZlvrJIVDsovu/4UnvB8+tR5HXHHxpu1QzC8jYTDKH1KisGKkG76DSuOXmk5HacQWBsLFUS9Wfoj8mm/wAZ1g1X/2g+XqEOp3j71dMXrDasZGQt5LpXqsZSz2vGeCKpGeDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIxfYafsbLT86pZicMqmDzX0JqvjPA6Y2vKiSa+xVKo=;
 b=qIe796+5MyZE+gDqw00bxvmojnAcw4havSL80Z8onSTVjzdBW5YItTfdAYU0J0OYgnGXJbRmkV0dBtAZFHTWmqdVChuYLcKn95TGESxj7p3pItg9HdiZZVB5D86DApPZTJkpvR8Li5zSpXaavASR8BXgQjhs6xCSNYDZvg4tucGhmFVfzgQS7bcQiocHFw/6SYWH8hf9DKR1SI3sZg/bKRRcOJhZN4DyzwmotIYy/p0UuSS36NtdxfqD96K04cjbj/EUJftHHZno6UmobfcvYU9Ngv9wLFhA6qfSu7LotzghkFADRnyS+UnO+doeTKyfChti/sjQ2AcHCBWhl/GWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIxfYafsbLT86pZicMqmDzX0JqvjPA6Y2vKiSa+xVKo=;
 b=SIt9ixoH1ZhP9BPcTJzQBEcdGEeuYpjV5bu7vphkHMPMCwUxrINqDJQisP3WLCZ+v65KBVd+d6ITNJDD6Bzd/aipuB/2tuSQRuRMeF06OL7PKCKK8U7XpX/T/ktJgvWLkZFqVc247mBzzNulmrgucXk6+YPr9huqWQQHSViyFZrcxO052kWmNGyaXc9MX0Pa+sTurGOwY56wrSygkzpzzMYEaELvffeR+v/EiqiKLLfPJY1ZVgbl3JcRG0+692crXGQ7ZFPg3h2+NypYmxdrWcZ2ATPP18ex7fD/49NKtTXa3AOooCvUm1kTw52dKwg/YzdIw5UrdT8DhnV8J9O9bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 15:48:27 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:48:27 +0000
Message-ID: <5caddf7a-b67c-432e-8c32-9b9a134f8b00@nvidia.com>
Date: Thu, 25 Sep 2025 10:48:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
 <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
 <20250925020502-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925020502-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: b52e590b-51ca-492d-5b64-08ddfc4af7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFVUZWFLNkswM3VnemdBRmNMbGZOS2M5MkRqV2tBaUhWc1BjeVYwbGNXaTJR?=
 =?utf-8?B?NzhMbFUvOW8wVXlsS0k5VTQ5eG5RbkllelNoSklSaTBRd1VKOUxKUlZqREQw?=
 =?utf-8?B?Y3lMY29Ob25WWWtib0dmQUsvaEZLOFNoN2tycXVvTDZuZTd6V0xqWkxlamZh?=
 =?utf-8?B?TzUzanMzTW1YUUF0VXpxem9nZUplSkNwanlkUVZ3bDA0NlNXTUZzTTFBTzJ0?=
 =?utf-8?B?WEl4cHg1eVZLeDk3cHBCNC9FVktadVdQNDd3cWZFdlQ2VWhQRC9MRmZkMWNx?=
 =?utf-8?B?M0RVSENUS1Yxb21WQTE4L3RBS0FEdHF2VUhsNUtaNGpmbGxXalNUbHpnLyt1?=
 =?utf-8?B?dkF4Nk0vLzI2MkRCVE5RdFMwb2tZRVBwUlJzQk1HdXNrWFRERGxkbjZVVWhp?=
 =?utf-8?B?alE0enBXMWJ2TlVCdCs2d0FpYTBNdjdDcHZWMnZ0Wk1TYktPQ0FmQ0VaRVN4?=
 =?utf-8?B?YmdMV2RueE85dUNsM3JTMFJJWDhNWm5hVzI5QVNzWlpCUFo1bjNRMkpLeUpn?=
 =?utf-8?B?MzE4NHpzUm5UZmNERUFXSUpYK3lpbWUwNTJ0Mll4cURFb0ZDS0tTUC9YRlR1?=
 =?utf-8?B?b0xnSkhrZHdjWVhPYXRiSUtWT1Q3M2tLcnEyY005U1FUY3ZPRUZXZWZJV0dl?=
 =?utf-8?B?bGNkUXNUd0tVOWFmclV3SjFLNVE3dHkwOUVSRmdSUkZiTFlpYnhBTWRhYWkz?=
 =?utf-8?B?UW1LdTJrN3BCVFFwRmh5NjA1Yk1PZWc0ZGU3UkRmWEJhcnhCM0tybXA5WFFZ?=
 =?utf-8?B?T1F5cnN6b281U002VmN2VjZ3eXdHNkFnY0lrakJYRTFqa2RJbERkTnM2R29M?=
 =?utf-8?B?ZFVzWWU5RFp1cXQ4ck9kNC9jUmZjbmxwSjZ1V09kRHNIOElBRCtDWjZuNndP?=
 =?utf-8?B?MFFkLzhmaDBaYzdjb1V6bDljTXY4RTRSWjBCWW91VmNzQU9oOE14cTZpNzZp?=
 =?utf-8?B?d2RrT1J4MERiUkh2SXh0Ym1NWlZGY0tzS2lyckpzYjJNT2U1b1B5Q29WU3JL?=
 =?utf-8?B?ZXhsSGxtamw5WFVmVVg5eDRtVmJLdVBDYVZCT1hrTUp1V2tOMWJ3ZmJqSFB6?=
 =?utf-8?B?aUx0OHorL3lTNVhZQnBJUnIzbWJ5aU0xY25xY1pJWVBFaFg1bENPSWNxR0JS?=
 =?utf-8?B?d0hoQVVUbW9DOWUvY1hNeisxLzBkY2JLa2Fad2luTTk0ajJnaHBhVUwxdkNI?=
 =?utf-8?B?blVLcEhuaE9zRzBYcUF2aEJQQThxeG1pajZHVmhpNlRhM2V6RmoydjVKbG9a?=
 =?utf-8?B?MXJ0cysxY1B6Y0RSM3BZY09xcU1BSUkyR1BaY0dnYzhsSE0reDZ2Y21MTTdD?=
 =?utf-8?B?WitrSUdmRlZmanZLWmNOQTNQdXpObGF6OTV3bElIQjBlT3dldTBQQ0tKd2k4?=
 =?utf-8?B?RzNtSlRiWGNxSDdpVzlKeUJMYlBGZ2pPYzl4MVJIVy9oR3FrVkd4dHhQb0x3?=
 =?utf-8?B?ZmxBYXNKaXd5d3ZTRTR2ZVBuUi9QckFRUGVJVmhBcVFZeFM2ZGk4Zng4VTQw?=
 =?utf-8?B?enVpUWpyQzBseUl2ZjZZN0tBZk1mdUhmdWJUaThZU20zSXlwZzVMcXRteTZT?=
 =?utf-8?B?WGhIWEsxTUk4dy9uMTFjRndBOVFaMmZrR1M3TWR2blRkSDFzTENGMjBsWW1E?=
 =?utf-8?B?dDYzajJGTlZiUlhLY1lYS0hQeDRWdFZlYXhzTnN0WUZ2TXc4cEQrMW4zQm00?=
 =?utf-8?B?MW5ROHJpL0lwWFhQWVlMenJ1TUp1TkUyVjJ3cWlKSHJFdEsyajYwOEUxWHI5?=
 =?utf-8?B?cEpDWEZDNGRPdDVwUkI5Rm5lT09lUFF0MElkUVZvUHhhYlU4aUZ2NkRjclA3?=
 =?utf-8?B?TUpOaTlPOHpUcEtlZjl0ZmpXcDhRWnZhSUtLb2plcDlCc25PV1pta0s0VVRs?=
 =?utf-8?B?RCtzd3V2Yy9Temh1M0ZQbDVXbGNwdXBjMEtHenlHTHhCaVQ4TEs4OExvaVJ5?=
 =?utf-8?Q?AakYwnfevck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJhVUoyc3JEZE1TbUtoYVdVQmROMTZkK09wRHVyQ1ZUU1ZPZWFFMEtWV1Q0?=
 =?utf-8?B?WWpyU2JUa3hlQ0FnUWxONE5iOVZxb2RRWUZTcVFhMmZqMlpyd1ZyUDcwMzli?=
 =?utf-8?B?Um03UDRWVUF0K1BqSDNzN09LU0Z4K1FtaWJZeVVDeXBON2dWL1IwRW1XRGFW?=
 =?utf-8?B?cWg2ZzVHa0x5Tjl3TzMrNitkY1M4a084dnhicWIyU0QvTkErLzg1QjFRSUNG?=
 =?utf-8?B?d0dQdHVvUk0xeVIxa0QvL2JmTDhRYW04ejk4cldvNDhCVEE5MXo5YzhEK2hP?=
 =?utf-8?B?bkJtaDhkS3pYendvZlJmLzExd1ZKMEN4Q01qdHNrWFdqZHlWWjRFYjRKMFl6?=
 =?utf-8?B?cVhWNzhlUTN2eFhweW9uMzVMK3JGYmdPSnBCT2lOUHhvT1ZSQUxVdkZlbE9M?=
 =?utf-8?B?dW15TGdJM3lYOUZUSVV2UUZVSDg0c0k0WFJXNWwvTjN4SUh3YXZPa1FaZi82?=
 =?utf-8?B?NVFNQ01jQWRGeUI2L3RmbW5QRzI0VnY5TFZhTDMwTjd1V05jTXFWUE5BWWdy?=
 =?utf-8?B?aUpkWVMxTHEvWlkzNHBpL2RzK2poMnRDUUQ0ZEl5V0V5bytrb2RJR0lKSkRw?=
 =?utf-8?B?MzhlWlBRYU4wZGgwU1htcGROSFh0U0M3aW5HMUx1LzIzMU1McThLem5nOUMw?=
 =?utf-8?B?VUZnOG9mRENxSDZsK28zUFhzN29zanE3T3VFR1dWV0I5WENiRHk5QUxRY3BE?=
 =?utf-8?B?SWN3SWJ6d2h0ekxHdDY4RFRwMEUwVE9iSloxdjNjMW43NjlaaEZwUTN2di8r?=
 =?utf-8?B?SzBSNTdkeE5JNTlPYUlHL1B3NCsrbnRaUy9US3cveTJ6RktBUDJoUVpJbTdj?=
 =?utf-8?B?UTZ4MlNCY3hlV1cvblhIQm05OGVVUWMzMGtBMlNCZmxxY1dNbFF2QndhM0xV?=
 =?utf-8?B?ekpCZzBKTHBsOHZrOGc0L21kZGdSUmwvSTVrbFNRSlowc1ZuMHU4VDhLcno0?=
 =?utf-8?B?Sm9mTC9qVENhLzFGMnpSdndHUjI0MmhBYzFBbDMweDVLVnlGNjJKRlVYTFhJ?=
 =?utf-8?B?NW9sanZtRHFpbENxc1lLZTR5M3VpVE5MVFNITHRZNXdveWZlYUdnSVcyMS85?=
 =?utf-8?B?ZVV1R0RnaUhVU3FJNEdXQTVWd2gzaFM5SElqSmZCK0JNL1ZDZ0hld0FGbHo3?=
 =?utf-8?B?eHNRZld6bUg3VmZvVmU0RlBRc0h0em1ndEFEM0Z3TnYvdERPY2swc2lzdGxu?=
 =?utf-8?B?UUJiNlNaWHo2Ly9vOTMwM0k0aGZuQ084K2xSMUZtZ3p1eVU0bFFxNzMxQ0xs?=
 =?utf-8?B?aDFYWDNwTlpkbEhOWEhNZm1nQ1lpbURCNjNDa1doUVhSeDhRZjB5d1MwT3VL?=
 =?utf-8?B?UVVMM2lHOUxqTmQ0VmxqczIrQnM2djRlVExUTnNvSkZtWks1cWE4RTMyYTcr?=
 =?utf-8?B?QXpYdUd5NjFWWjl3bWlxSHUxV083NzhVNkI2c29NM05vbHdEc1diL2FQbkVv?=
 =?utf-8?B?aHFodWZPa0IyZU9ObEtsd293VEZMaHVpRFZQN0c0TUM4UXo3d2VKZElXdHRj?=
 =?utf-8?B?VGQwZ3c5TEkxUHZlZ2wzeWlhb1dBTlg0ZVNGODRUcjlicVhTam45STVKcHMw?=
 =?utf-8?B?ZkVzRjljZDFwSm1UYUxmdVF0MnJ3aXlYSy9NUFRWNzhWaHJaQzVGOXNnWS96?=
 =?utf-8?B?L2RqMXpnN1Bsa3poZFF4NC9ST2toNkNBRkMreWpJK1FLZi92QVE2eXFQeWlv?=
 =?utf-8?B?dFhOdHhCbDUwYldDbW43djVwT2UyRFFIcW9YaUtidkVodGVtSnhCbHc3WW5T?=
 =?utf-8?B?MUdTRGQ2M2xyc1dNc1Z5NE00OFdPZ3FudnlpYmRWQVBvdllPRkdyZ1g1UDhT?=
 =?utf-8?B?WHdkWGErQWhONHRteFgxZ25xRFo3MDVmdko5SFUxRW10YWxxMjlhRWd3UGU3?=
 =?utf-8?B?d2toSEE4Vng0bFFweUtGVk4zT1dMNzEvbFlleVRtaWpUY296Q3VXUmJ3TVJX?=
 =?utf-8?B?V0FUWmpycDdpdjArTDlnZUhEVVNaQTFyaWUvbHlsbG5IOVRPbUlLV05uQWty?=
 =?utf-8?B?akZhUG5OQWEzSVA5dnVxeVpIOVl6YWlQWXNldUJxcFZ4N1JYV2NvV2puT3NM?=
 =?utf-8?B?Y1BPcGJWZ0svWXlFbFlwcmR3eElWZkNNclhaUmMrTlpiYklEN0E5ZVlYTmpC?=
 =?utf-8?Q?Oo9Qrxxwn7R40NGfkw+nzzoyg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52e590b-51ca-492d-5b64-08ddfc4af7d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:48:27.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+Bz/LYu+HACtRvvKbcAmP7B9dK7vsEQ5KPpxg6Mg67UI8H/3ntZdtCHmbWWTbbFN4Q5Gu3KaMQ3noYrjHhWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

On 9/25/25 1:13 AM, Michael S. Tsirkin wrote:
> On Thu, Sep 25, 2025 at 11:56:09AM +0800, Xuan Zhuo wrote:
>> On Tue, 23 Sep 2025 09:19:12 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
>>> The flow filter implementaion requires minimal changes to the
>>> existing virtio_net implementation. It's cleaner to separate it into
>>> another file. In order to do so, move virtio_net.c into the new
>>> virtio_net directory, and create a makefile for it. Note the name is
>>> changed to virtio_net_main.c, so the module can retain the name
>>> virtio_net.
>>>
>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> To help this work move forward smoothly, I don't recommend splitting the
>> directory structure within this patchset. Directory reorganization can be a
>> separate effortâ€”I've previously experimented with this myself. I'd really
>> like to see this work progress smoothly.
>>
>> Thanks.
> 
> Indeed.

It's not a hill I'm willing to die on, but breaking this up into files
makes sense. virtio_main.c is already huge, and this would make it 15%
bigger.

> 
>>
>>> ---
>>>  MAINTAINERS                                               | 2 +-
>>>  drivers/net/Makefile                                      | 2 +-
>>>  drivers/net/virtio_net/Makefile                           | 8 ++++++++
>>>  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
>>>  4 files changed, 10 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/net/virtio_net/Makefile
>>>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a8a770714101..09d26c4225a9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
>>>  F:	Documentation/driver-api/virtio/
>>>  F:	drivers/block/virtio_blk.c
>>>  F:	drivers/crypto/virtio/
>>> -F:	drivers/net/virtio_net.c
>>> +F:	drivers/net/virtio_net/
>>>  F:	drivers/vdpa/
>>>  F:	drivers/virtio/
>>>  F:	include/linux/vdpa.h
>>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>>> index 73bc63ecd65f..cf28992658a6 100644
>>> --- a/drivers/net/Makefile
>>> +++ b/drivers/net/Makefile
>>> @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
>>>  obj-$(CONFIG_TUN) += tun.o
>>>  obj-$(CONFIG_TAP) += tap.o
>>>  obj-$(CONFIG_VETH) += veth.o
>>> -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>>> +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
>>>  obj-$(CONFIG_VXLAN) += vxlan/
>>>  obj-$(CONFIG_GENEVE) += geneve.o
>>>  obj-$(CONFIG_BAREUDP) += bareudp.o
>>> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
>>> new file mode 100644
>>> index 000000000000..c0a4725ddd69
>>> --- /dev/null
>>> +++ b/drivers/net/virtio_net/Makefile
>>> @@ -0,0 +1,8 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +#
>>> +# Makefile for the VirtIO Net driver
>>> +#
>>> +
>>> +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>>> +
>>> +virtio_net-objs := virtio_net_main.o
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
>>> similarity index 100%
>>> rename from drivers/net/virtio_net.c
>>> rename to drivers/net/virtio_net/virtio_net_main.c
>>> --
>>> 2.45.0
>>>
> 


