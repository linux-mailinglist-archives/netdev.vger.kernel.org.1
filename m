Return-Path: <netdev+bounces-106866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723F917E3B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F31C224F7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1C17CA0B;
	Wed, 26 Jun 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="AN3Ua0fH";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="SxtpaRPp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86315EFC8;
	Wed, 26 Jun 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397949; cv=fail; b=PJ9ihwwk+X2IEo7cP/U3acy1aEmAcyRXVm0qE9k3bo3ZMDORRK5SUnUDLac1Rh54Wx4Oh5T5+Anpdci0dwx5HZfhGZtp83gTePcy8f3sTxgyevLvB4ZWOWj4MHVN+HqSDiBduFN6MVBfuuux9bZ/OGhnXX4oIKG3j29TPAOoPXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397949; c=relaxed/simple;
	bh=gw1QoqDjMjGGH9KbxCAtz74SRAo8UsR4IbONgulayYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=STUZ081ayU56Jdw4q/aAQPLff06mTnrxX8RYvOjIRLtrommHMffG9A07n4UcCKtglRGVcpfMoEL0Sx0rRnNQIWM2Y1IAVqjWgKtWus63z+iBKkHU2a6OJvSEMyZ8O+Tx3qauXYnUO5lB5lLVG7m7Ll+tifJCljeFqXpgpmgW13A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=AN3Ua0fH; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=SxtpaRPp; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8cXa5032099;
	Wed, 26 Jun 2024 05:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=Xq+stB4HdrZl8cMwx/YiGZCqP4Sx+RthBtfb349fqlA=; b=AN3Ua0fH5hIY
	tJWBdI86zZipvL5stEVzr8qEdji2APmDnrSuRoJ5laGr+lQbVOpiTxuH4ocW39WS
	zgYiIJKoskz1C9x3epFvhuQlQ/HRjPjEpxfhs6wcMcDg3UOB8uGmlXO7lz5j5oy3
	lA0EgJ3y7yO90oghRB/h2/nG8sDTGyKsD03/d2MPPNMUvrTvJtpIPckmATupHMH2
	gNHYnbOsVYwVm4bO8QgwOGPLeN+w9YthUiY1DJ2PHHxKvIee4uNqM896h+rTbp6Q
	yA5k2s4Q264hn4LR8afcFtCgzpqTSJhTPiQ9ZJKUU5hdQ8DCsoo1VNFo9Wqj3ZMU
	aFOgUbnVeg==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 3yygr8aw1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:10:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4w/AfVb/PuXDa0Yq9I9s+ahE9TpFyA/2LiEWbn/Senec6RVBdgx/pY1XpiIeTqBlBrfK2nB2mREBuGFk4VCtm4St6V7C9xjIhufPXxNOkB4sIicNNFXfoBx6VXbM28mKbB9haqC1/CwjxldfZDFg3zTPQiDCS5xY33kFRvwfyLyt5+1iV5XL4Qd1dre8Y1YKvVLLahgtlYgOsl7jzlex1saifF9JIdrWWaQZXy18gxMCVYl+mfg7tJpQFOkC+HndobI7y0KuDxy3VyhXNDVYB4Hzn7OiLGA3AbI1ZZL2O9Rv3IBe2KXPlvtqf7fAWynAPe/2GxsOukpB0ZLHGqjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq+stB4HdrZl8cMwx/YiGZCqP4Sx+RthBtfb349fqlA=;
 b=D2Fzstg7EPnqflx4hHQPyHMKdaJ5zHHj6IaMUpQNyNUeSaF9/9pCt9Y5RBLVG3h/o9rIOusIRhezA3Mkq4giAxCHgg31JaD5zRXU0PXuffhDMSfgVqvJa7nhjQ3Zju/zT1MHxpARFxSn8PVHGNtUZMFT9QqDsZSnlIjQuAGGENle1gMlGHr4wq7A53F8W2M/1YXCLNDMWINTKb2fc+ptcS/m2Y4HRGEO3obt4gQ4uO8/3+xOzAfl6zsMBXboMNPUqK3ac8UmiVDXxrXEbFuKvjUM8zd8EdXkWUB+3x2q/6LMiOx1KnqtTw8Mk38RXoyAMbCJnmrprPYsftfgPWH3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq+stB4HdrZl8cMwx/YiGZCqP4Sx+RthBtfb349fqlA=;
 b=SxtpaRPps2+s7WMDnRfptCOwjHrs4DjCBotdnCyLLnzDhC2WrSX/z51viE2IiaTb6uFpZQY6ByO0bopW9CVYWSBtQnxgda5jN2sT331THVEapFQIwT4I2bpSdRxjel70zAFucQbowHMBtQnHZ7p++3UKG2acZQ7ztTZD3/KTIIo=
Received: from MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15)
 by CO1PR11MB5153.namprd11.prod.outlook.com (2603:10b6:303:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:10:18 +0000
Received: from MW3PR11MB4714.namprd11.prod.outlook.com
 ([fe80::9b77:8d77:3800:f0fd]) by MW3PR11MB4714.namprd11.prod.outlook.com
 ([fe80::9b77:8d77:3800:f0fd%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 10:10:18 +0000
Message-ID: <0fc38c1b-1a28-4818-b2cc-a661f037999d@silabs.com>
Date: Wed, 26 Jun 2024 12:10:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0
 segments left
To: Alexander Aring <aahringo@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, jerome.pouiller@silabs.com, kuba@kernel.org,
        kylian.balan@silabs.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        Michael Richardson <mcr@sandelman.ca>
References: <20240624141602.206398-3-Mathis.Marion@silabs.com>
 <20240625213859.65542-1-kuniyu@amazon.com>
 <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
Content-Language: en-US
From: Mathis Marion <mathis.marion@silabs.com>
In-Reply-To: <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To MN2PR11MB4711.namprd11.prod.outlook.com
 (2603:10b6:208:24e::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4714:EE_|CO1PR11MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e323937-9fb2-45a2-3d44-08dc95c82642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dmJqZ2JCd1BMZWI3bFk5dkUwVVNzanBwOHdNTjBZeXJkOCs0eWg1MWlYblFH?=
 =?utf-8?B?ZG5yTnIxSk11WnlUM0JHV3JmbmcvL1IzVEJjNWVpamk1TVI5MW92U2lGQ2tP?=
 =?utf-8?B?a2FHcGxZMXhkV1hhdElWbUgvT0JtR0ZmY3Y3Mk85VlR3cEV5VlNabUNSSDRi?=
 =?utf-8?B?QytYRktTMWhDRVFwdUxuMU8wQ0NDNkhJdUNRd1ZtRjREdDVkSzNlQ0JjS0Vu?=
 =?utf-8?B?cmNyTmRyd2pYUzBVMFZVclM5d21KY3NXV2RJQnNJcDIwRWJBNEpVUFkzVXRB?=
 =?utf-8?B?d05jVFlsaE9LVEdvV2UydXN6cUNDUXY5WU1jdlZsQWVobCszcFFkTWxFSlYy?=
 =?utf-8?B?aEVuRVRZYVpja1lrL3g5QzRNVjFBMkhpK1BVdjM1amlqZk0rMnkrWnFFajBL?=
 =?utf-8?B?SEJ6bk83c0xTS1lsdUZRQ3JvVGNNb2FZdGZ4NjVWclFpY1hjdGhvMEpHTkw4?=
 =?utf-8?B?S0Z6M2VSZHhKUDdZaHlqUEUxWUZ3ZERUdUQvejhNODNxYlArSlppRlBRSG9q?=
 =?utf-8?B?Y1I0SnNWUkcyOWtvanNVenorblRDNXA4a2JqTXhIQkRQcXB2VXhablpkVDk0?=
 =?utf-8?B?djZ5L3MzdC9Cb2dOa3VoVzdCK3JQcEdGREwrU1VQV1Q5bkFzNjRhMjF1a0VH?=
 =?utf-8?B?UEVEZ09HYldSUHNUcVR1Unc4aDRmME12V3l5aG0wM1lEYzYrTlhkZFFHTXNm?=
 =?utf-8?B?ZVlQdCtWeGJNb3NXbEprWDJackltczdKbFgxSnkvYzNqQWFpTlhHaTNwT0hl?=
 =?utf-8?B?bEVvT3d6dHVSS0F6bGs4OFdsajRxc2wrL1ZYQVpibGtkd3VHMGRTRkdUZG1F?=
 =?utf-8?B?M21LMkJZMGpESUlLK1k2QStNTVJMRUZyVHpNQjMwTThZcmp0MkcyTXlvQzNB?=
 =?utf-8?B?RDdpb1NmcE9CYUExd0dVdnloaDZONUZrTzVnS3dic3c2M2JBT1FuenIxMS9P?=
 =?utf-8?B?UGNKanZwZHFGYk9iOEpXT3FYUEJUcVJzR1hlU0dBVnQ0MmlkdHhNU1hnRkpm?=
 =?utf-8?B?SmtNcjhCRG45Z2NjU1NabVE2Ym5BUkNBUU02dkF0ZEFUa2V6NHlHaWwvQWdB?=
 =?utf-8?B?WHZrS2U4Z1IwaHdRZTN2bXdyeTBWc0N5WUNWVnJ6M3VITWVKQ1NCWXRqem40?=
 =?utf-8?B?a2NKVkgvVjQyTnRKMUNLWU9OencvL3c3eWtLZFJ1bHZPY1AycG9rb1ZBZDRs?=
 =?utf-8?B?eDRqcWEzYkZ4UjhVZVJaMDQxZHNCQjdZZ1dCRWQ5RUNyQWZhb3NOODdWcDcw?=
 =?utf-8?B?NVdWa212UW0wMUJsd1RZcms1YktSSEw4b0N6UTJQK0FhRDlIUlNQVTVaRlhN?=
 =?utf-8?B?UUxUN3ZaTDY3VVZLZENNWXpYUlRndTFBVkhTQ0hNNmxMaDdaV2xBaUdmUUtR?=
 =?utf-8?B?SnRXeUNjU1Z0STJzYVluajlDN2N6dXExSUFGYnhaMUVPUmlDOUFFV2FmOCtU?=
 =?utf-8?B?VHhrVjBpR0FiMFphM21aWFF1dm96UlgzU25nUGF1UzJvRWo2NDA0ZDhWOWU1?=
 =?utf-8?B?cGIxbjZNL3M0a2pRd1VIbzdUVHNUS0o2WEdhZ3VMRm1yeis1L3pOdnJia1Rp?=
 =?utf-8?B?WjRVY0hOcm1VQWZjVHkvUTAzUkYvQkMxdmt3b05aVnBCVGR5NjJEdWZPWTEw?=
 =?utf-8?B?Y2g3Vzg2OStCL29MSXM3eVd4MFZWSVdReDV5NmVKdUpNTUVXeDVTcWpqM2lI?=
 =?utf-8?B?ZklHNlk1N2NMK3l0Mnl2Rlo4L1BnYVphS2Q0U0tyWFU5SWZUUDZ4Z25Qa0Qv?=
 =?utf-8?Q?lyOpDS9TxcvfoACFeA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUhqOFdyYTNVVHNSMGhZY0lMSEc2czBmWUtOYW1Ic2lFVnJ2dnZraXprVE1t?=
 =?utf-8?B?TTllMXdHQ09JbXBMeDBkSU9rNDN5SzB1blN5L2dvK2dzdnF3WXdVWWVUdzAv?=
 =?utf-8?B?T0o5NnhuVXh6bFFWbXFUeHdNdUpSTXoyMmxtYUdNbVRNRnJ4bENBTCtLdk55?=
 =?utf-8?B?eEhDSEFpNDJEWGdpbXhCRGM1OHdpTGV0TzV4SXk0TGNlZ0g0SGJueEN4QVR1?=
 =?utf-8?B?d3dsVzh4Y2MyU2QzQnkrRWwyVUVoMTBySUt1VldONllSZC9iWElzbjc0RXE4?=
 =?utf-8?B?Y0R6VlQwdFVDbXJhOUVaOW81cWtLeE5RR2duU0VmL2V6Rnc1dFFwTjhjaU8z?=
 =?utf-8?B?MWN4SndyakVQbEVDWEI3d1Q5WUNHOEN1TTl0UzhLNFpWZ05vakRwRldDUmZu?=
 =?utf-8?B?TWVGRVJ2ZERVQ29JazFNdGswM1dSTk5UOXpINHFsN1IyZkNZZHFzYjhGTWti?=
 =?utf-8?B?cFRjT0hGKyswMVJ4cjcvY3JaSkV4dENYMVJXbGk2V0dSZ2lSNmZWditQbXF4?=
 =?utf-8?B?QjdWelk0bkxVUmkrblR6YUZiWkZLcXFtR3JyNHQ1Yk5ZL0UyaVMzRTNOV3E3?=
 =?utf-8?B?cVZ5SmpEWWgxamN4c3NjcHhOVGZYTWVSZC8yNitpbGFzWTF3a3VpR3lVY3Ew?=
 =?utf-8?B?VjNVS0FCczl2OWlNT2N1dFA0TmxmMVBGKzlBVTRBVG4yR1NHMGFQRWhqampy?=
 =?utf-8?B?cW84U3VYUVArYzBOQS9PN292QkNGY0h6d3RITW9qYm4vNkUvQnlNT0QwdkVS?=
 =?utf-8?B?TVhrN3BKTUdzYXFXeFZTa2dnc1lrNVBXNVFUSW1pUW56VWh1clpEUnZ2VkFh?=
 =?utf-8?B?SVc0RTkrNGc3S3FhYTFXZ3MyVndWMnV3MzhybVpOU3BDODVZVGVCUUovaVMv?=
 =?utf-8?B?QTRvdzFzeVhHb2lOVmdUcGpueFNES1VqNHhVTFlNWGdWNnlmTFczR3ZXL1lV?=
 =?utf-8?B?M3FHV0Z1MmVnaEtFc2RRNjF2TDIwUHZ5YUNaeXdyS0NpNkkvUUgwN1g3M3VF?=
 =?utf-8?B?MEJyYnhoOCtXN1ZodFV6ZmhmMkVqUEpYYTdBd0R1V0txaDFmU2g5ZExEbEw5?=
 =?utf-8?B?Z0FPV09MbTA1NXFSeTVSMjc4enhCVzEwQXp5VkRLZWxESGZhN1hxN1g3bVRE?=
 =?utf-8?B?Qkprbjk2eXRXT1Q0eEJtcVhpOEVrakRjRnhxeFhqTXVFMUVHalhXWXlCSWhz?=
 =?utf-8?B?UzVEcHZiNFhZN3VQRzQ0c0VlclcwYmM2dXU5UThZMmNKRFVnbzJDam94OGxW?=
 =?utf-8?B?bHJOOVNyTUtWVmhpcnlxbjVMMmhhZTRzcTYyaTdaVFNWdTIrK0MxYzArZEZn?=
 =?utf-8?B?bUlaOTRkNENKNzQ0MlJQSlNzRTlKQWh6bWF1aC9saUR6ODJjbzI3eDl5ZGtm?=
 =?utf-8?B?Ri9aRCtHVC9va0V3TzFBbVlxYWJPcFRQYzMrZUJQZWhpaUJVaHh5Z3htdWRX?=
 =?utf-8?B?TzR6UWVYQ0UvKysxNGZzeUhHZEtaT3lQRzVuMG5FS0E3YlByd2lWenRFMHNt?=
 =?utf-8?B?ZU9mamVycjZqY2pVY003REV5WkoxY1ExVzdBZ1kyNW8zQXhBemVhWEJ4bEVT?=
 =?utf-8?B?Vm1JODlEdUZoRi9tK3FWZjdEU2NzWnB5SHhWOGE0KzdSSFRvbHBWdGlUQm5W?=
 =?utf-8?B?eW1rbXlxRmwxZUQ2STlsdEdaWkpXbUFCbVRUZ0dyQUZYOXBYTVRQR0V2RmRG?=
 =?utf-8?B?Qkk3bERpK1FCUFgvMkZ4aUdXcUV6WktTMkJFMEhkWGdMQUZydUNtTW1vam41?=
 =?utf-8?B?dnJhd1NrOXlOclg1SHR6SXlLZ3RWUHYzdGZIWXJKM1VGRzNvcjkwVkx2Ny9F?=
 =?utf-8?B?alhOWUo0U1FOTEV2NXVKdUhnVHZEZlFvN2lhWlBxQ1M0MWpaRXdPV0RkY3Iy?=
 =?utf-8?B?MEdBcWVaaStpRXZZUE1aY095VzcvRzBQc0dLdWhNU0tBVUEvMzZyWmdsNW5a?=
 =?utf-8?B?N1Iweitmc0FvWVRLWmszZ2FVMWlLbkhUZDBXekFRL1dmaUc1dzlldVRZWHQ2?=
 =?utf-8?B?bkFEdkxTS3p1dkFPa050UG9palZneTV4MnVVNlU1TmFudmlheURvaDN1b29i?=
 =?utf-8?B?ejdrS2NzNnFMdzNSMWoyVndWbEVyREhWM1FLR2xGV3lFcVY2VVFuSmdaYTNJ?=
 =?utf-8?Q?qSQihrVxkSfHZnVxhUk/RA4lg?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e323937-9fb2-45a2-3d44-08dc95c82642
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:10:18.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69JZ5SI8XTys3H0oQycVRrOXbi5rUdFd1wgvQ8ftGHuN3/ijc03X5Hle6nKJgy4OOav3jUquCeahG23zDZm/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5153
X-Proofpoint-ORIG-GUID: xN3RwDd7M2iX-GKzzz_9KCKPUiooOQck
X-Proofpoint-GUID: xN3RwDd7M2iX-GKzzz_9KCKPUiooOQck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_04,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260077

On 26/06/2024 3:45 AM, Alexander Aring wrote:
> Hi,
> 
> On Tue, Jun 25, 2024 at 5:39 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>
>> From: Mathis Marion <Mathis.Marion@silabs.com>
>> Date: Mon, 24 Jun 2024 16:15:33 +0200
>>> From: Mathis Marion <mathis.marion@silabs.com>
>>>
>>> Routing headers of type 3 and 4 would be rejected even if segments left
>>> was 0, in the case that they were disabled through system configuration.
>>>
>>> RFC 8200 section 4.4 specifies:
>>>
>>>        If Segments Left is zero, the node must ignore the Routing header
>>>        and proceed to process the next header in the packet, whose type
>>>        is identified by the Next Header field in the Routing header.
>>
>> I think this part is only applied to an unrecognized Routing Type,
>> so only applied when the network stack does not know the type.
>>
>>     https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4
>>
>>     If, while processing a received packet, a node encounters a Routing
>>     header with an unrecognized Routing Type value, the required behavior
>>     of the node depends on the value of the Segments Left field, as
>>     follows:
>>
>>        If Segments Left is zero, the node must ignore the Routing header
>>        and proceed to process the next header in the packet, whose type
>>        is identified by the Next Header field in the Routing header.
>>
>> That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.
>>
>> But now the kernel recognizes RPL and it's intentionally disabled
>> by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.
>>
>> And SRv6 has been rejected since 1ababeba4a21f for the same reason.
> 
> so there might be a need to have an opt-in knob to actually tell the
> kernel ipv6 stack to recognize or not recognize a next header field
> for users wanting to bypass certain next header fields to the user
> space?
> 
> - Alex
> 

My point is that if a particular routing header support is disabled
through system configuration, it should be treated as any unrecognized
header. From my perspective, doing otherwise causes a regression every
time a new routing header is supported.


