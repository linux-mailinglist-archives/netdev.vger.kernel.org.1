Return-Path: <netdev+bounces-212478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBAB20C96
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA25E188F6D7
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF625A2C7;
	Mon, 11 Aug 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GArAYi/A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD471DE3BA;
	Mon, 11 Aug 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923564; cv=fail; b=DvYwaAkl57FyAhF6jmXXpHZy+3IYTuk4JT7/3ZndxzxmpPj7x0bejmEByzNnLREIoFf1X/W0mADRhw+/XnOaYbzDSed71DJHX7hj5QQdIjj+ghRKh9bZQhCUpOgyFnwcomo7RWhuXmzJPfXw1MmvJxxD4WcCGfds4IjYnAER/t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923564; c=relaxed/simple;
	bh=wqZQv99KpOp86DqI3tG5a5wmDRYlUxHHL3kVVaMlWKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSIuJLWaBljNEfuoR0XCFaF2hbpQ/wBYTL5pn6XTesj//sYLd81PhQxmWN16R/Xd04/HBI5rZ5RBtW4XMiuM+TjTctol/p4miKWt0CTohbdnI5NiuyXXPMWO0g5oSeIwOjDPYaqaAFqfgVn63cdaO25XAuz0gc0LXVfiSdje+IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GArAYi/A; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOcTmLC63h6KR14XIlo40iZY5gmQ0udOGAyGSquGQUY2MyGodt84CYCcgCEZlF+pyOtZu8tdQOhPUNB41fPGa1aWJGxq1AHjlN5i/eR/VEqa+qquV1R8eClDwE3K7SMvXdrQN92rXuwO7lw2RtJwUGfRHvCSKe6qVvuUkyglOObNmQ3JZkn1fplDJqyfejQEet+U4W+mnPilAWvUBsrwF0cVRVdFJCGt6UtsXvEjBB9RNMZGXJc0lFzfTI4EdTChv23TLtuB5hl8WyHzrPhDzcrX9Gvb9swqRYrqec+wHYY5Jh5aDR6OX8paWodrsgHrurusPAHHroE9Wg6HkqGNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1JoFnNAmRUW0K+ySkkcFcGNT9Ry3EpLa1Wq6Kxs8Xg=;
 b=KbhLoaWzzYJQiWMjd2F/gG3dzH2/OAWop+iLCWXpnrjB/HiE1AlBtFFyMPHIA1Fs5wkv4X+VVtcKG+79bXXG0e2pD+8sxGq0Wazf59/cDl7QIrt5LJaXtaDnmc1pmtQNexKKdPd8daWFMzL9HxXpJ88Kce884sA0w/551BWBDEJoNWQ6NElTxJ/vVk6zE0Q3zGsmqoyq40QtNqjHRmjxzQI8caMdFifEnN8f0dy8vhtC3pELIhU7j7up7lb7ELLuL0Uy1TYZkRRp1ul4LXmVemJHIXSKAVdzQug//1ucj4IKmQDtZ6g0sggFAGgS9pKp0Gkp6d/rYyc5xCVX5rrtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1JoFnNAmRUW0K+ySkkcFcGNT9Ry3EpLa1Wq6Kxs8Xg=;
 b=GArAYi/AU224udu6noEzLfTOf+aGHLGs0LsdNNPs98hnU7IfPDwwQKXB1B5GEWKKevv6rl3YgNSzk+XyLMFclMlmOCUF8ab9VXOM+SenvgDSJPF7ru0a85ETfyAqy6QYk3IsuwMYZ57d0UkMOZqM+clmd0I4aI+NXBX44928dNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:45:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:45:59 +0000
Message-ID: <b4b5d1de-6682-4161-8c81-30cee0756a63@amd.com>
Date: Mon, 11 Aug 2025 15:45:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
 <6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c628b5-7a4d-46dc-78a7-08ddd8e5c95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEF5c3VyNHJKRGY1MktncmR2d3ovSFdnM0svanZpMG9oWEVVeHVEL3pYME1E?=
 =?utf-8?B?Q2pPd1FhYnYxSHpFZmRQd0VmYTlQM0FSTlZlbkplZjExUTZlVnJTa3RWQ1RJ?=
 =?utf-8?B?KytoY3NOTVJqdVpCVVBnTTBPK3ZTbnFmaWRUdmJMeHQ2VkIzQ3RWdmJOZXZs?=
 =?utf-8?B?VHdSTFlhWU84dUw5Tk14WWtFTVNrTnYyeHJvTXQyREtTSW5jZFB2NE94RXhs?=
 =?utf-8?B?dSs4cTFTYTVJUFlnUU9zMnhVUm90UEY4ei9aUjZ5bnMxejFsMUN1bSsvd2M1?=
 =?utf-8?B?K3pFNmRNUmdKNFIwdW1vZmI2ci9nNHIrNTM5ZVlFMnhHTUJNaVBmcUp2MjlO?=
 =?utf-8?B?Q3ZZYXpUT1RKVHdoMG11VEQzeEpOamJCSnR0ZWkyUHZLVy9rSmpGRm52NHVE?=
 =?utf-8?B?dEU5VnVic0xtR2RxM05vWHUzb2FnekJQR1JEVGhTd3JwNURXTWc1VGZ2ODNC?=
 =?utf-8?B?WGhmRFRtVGYxdGtzNG93eE4vZE16ejdtOGdwcm56dFNvMXlGb0hRK3FrNkhG?=
 =?utf-8?B?VU5pQUFTTGhEU1EzOHdPQkNyS1RnekgyN1RVTW1lQ0tJdG1kMzJiek9GYjhn?=
 =?utf-8?B?aDJEeVVWZjl6U0xZQWlrc2l5YldpcGtMcUVWTSsxWmVJb3FpbXh0azlmTTBm?=
 =?utf-8?B?L0JDRTZBTHJCaFBPblp2VnhTOFAxbzhTVXRSa1VlWU5rS0hrRWxaUnBwL0Za?=
 =?utf-8?B?c3ViODdsMVNNeUR5OWJpZFJsVlgrUWRPRkdUWHlLY2ZkU3krMmg5YmdxWTBV?=
 =?utf-8?B?TGJPL2NQc016b0Q0UFB6VytGZ1pOaDNrc0VGcmY1RDcxc28zK2VDSHl4S21M?=
 =?utf-8?B?NEFzUVVhcmUydmtRMUVmblA4YTcrRjQxNm80R1dzaExZWVpmc2kwK1YwVjc1?=
 =?utf-8?B?VEZJRjBocDRjMWN6cW15Y2lpQ3orNFZTczdwRVVWL0s0bHBWQmdkalNjK1pm?=
 =?utf-8?B?OVFseS93aDRUb3hQaGZTVXRnMkhUWHpFQ2d1a2ZYTU9UZXhoTWFXTThCNGZo?=
 =?utf-8?B?QnVxK3N5U3UvSjFVMWlWazVDWW13WXRnTmlRNWpRbWtrZDlhRVU2YTRBSDdK?=
 =?utf-8?B?T2g4ZG14UEhiU3JXam1jNFFyOEU4a3dBU2xLd0dHMjdPTFBpV3VxbUMyRWxa?=
 =?utf-8?B?Z0JpaCsrZXZUNzJOZnphTUxVaEg5bVRhS1UyWGY0bmZoQk1TcWxQL0JVbmR4?=
 =?utf-8?B?Vk9TbmFPcHRCa2ZjQjB5WFZIQXE5ZVc5S0pqQkdSU3BHS3pCVmJlV01uN3p3?=
 =?utf-8?B?QldGcHhVYWJDSFVqVmtzQ2h6MklkQUUxcTR6Zy90aWxYOW1TSVU4dXpsbmh1?=
 =?utf-8?B?ZDFMUGxhaFdIb2JVN1p0K2ZDaW9kTTgyYkdLRGlYcHp5LzYxKzhDdmhKbyta?=
 =?utf-8?B?anpOS29RcHZad2RCQjhsZWxSUGN1Q096K2NubGhUSVRJV1RUNHg3cGJMS3RY?=
 =?utf-8?B?SkcwemZZL2pSV3phNTEwTTlvZ0doVkZOSWRmM3pueHYreW9IWU1RSjFFOEFE?=
 =?utf-8?B?RHdXVjlqaSswWVN2MXVNN3JWcVFOMjErdDdSTjZ3WHFNbDVITmowanJMYndi?=
 =?utf-8?B?bGdzM0gvczNlTVArUXBxem9LQ09ZZG0xQk5VQnZreDIvOW1BbGF2TlNCdEhm?=
 =?utf-8?B?Qmg1bVRIR0NVV3RSSEs5Qm0xeDVIOU81ekluYWtvbExCcjRhQmNiNUFsOFBh?=
 =?utf-8?B?ckdLKzNEUWpVZThDL3kwOHQxenNXTytLNCtrRVdwT1VTaFM2ejdKWDhZT2Ev?=
 =?utf-8?B?V3BzRW5LeFAzUzZTRm5PSXo4RmxBeTYyNTg5bEpCUU5hbDFKc3laM2Z3azBQ?=
 =?utf-8?B?c3FtMGNnWWRXK2FKdnFtUDNld05xS0R3WEYwU2xXS3luSWZ2Z0o1TkpRdUNR?=
 =?utf-8?B?dUNhcm5YWmhnNkFPdk1vYmxtVndKRkhWM1RtU2FnQzB5V3Q1SWhxMTFiUGxI?=
 =?utf-8?B?TjlmZVVZdUFtMll3MWhtbzY4MGQ1ay8vS1BQZTJjM0VJYS9Cbm16VXMvTUYx?=
 =?utf-8?B?ejVaQ2VObWZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXlLQzRHWkN0NnplbjEvbDh0QVQrU0k5dkpYaGRJNkhYWDZzVDUvMEEwd1hp?=
 =?utf-8?B?TTB4ZUUvMDVTUEtScnFEWlNjbzNRRWx0N3FLRkdFWjRaWjBYNkdGbnQydFJC?=
 =?utf-8?B?V0VnK1lpM3k2RjBHVkE1VTRpaEhnUUpsMnF6Kzk1VmwzR3JlNFhRNFJFUXZz?=
 =?utf-8?B?QzBwMFVNVGQzQkZwUDI2eE1XZmlPcEV1NVlpaS9Jbyt1NWp3MnZKUCtKQUlN?=
 =?utf-8?B?SnF2M3F5Ulc5dTBRRnROWmFrK2x6NisxN211bnNxcnVvNWtLVTd0MXdmY2d2?=
 =?utf-8?B?U0kvUnNGNHdyMTFqcVZrTGhvVS9sTmxpQlQxTFFRNklpV0pVUDN0cnorRlFZ?=
 =?utf-8?B?UCt3ZnZIeHlHeC9WeHZWaDA3WUZKR0wrb1VWZlF2LzNURmtpNkF6MjNNWXd4?=
 =?utf-8?B?RUlpa2t2N1o4MTVIOFhRNm9ocDBpeDB2WmZpOFpDYXhhdTVKWkM5RnQ0SVBB?=
 =?utf-8?B?Z1RnWXAvUUFyckFvRkYrU2puKy9NcFArdHhhdXp4YjlYQk80L0ppeGZmWU5W?=
 =?utf-8?B?bXVoaFBxR29CS2txNXpmZSswUDVPWEovUzcyOVBtVlFvS1FVWUlRS1BlVmlO?=
 =?utf-8?B?dDE1QkpPdmYvTHlpVHBKTk50SG9lZ2phSWFsNDIwWUhjbkpHZCsxN0tYZGR6?=
 =?utf-8?B?TURPajFrTllPMWU4aWxiRHltM0xBZ3lTMDJLbXRwM0RjQXlpTEQ0WEhDS3d4?=
 =?utf-8?B?RzdJbk1XSFBEbDVLbmdhSVl2bm44OTRPSk1VTFRFbjVWdEFCeU1vdTNMclNm?=
 =?utf-8?B?VTRrMkFXb1lVQjlLVHJvb1MzSzZwQ241K2Y1bk5CVE5LYVJzRzhGSFlVL0gw?=
 =?utf-8?B?SVFKMTZnK3hiZlp3VkFISVNVdCtYVlFNcTRpU21TUktCbHUzcmE4dVZDazl3?=
 =?utf-8?B?eGt0Y3pMRHpWUEFqZ1VnRlVXRGhMelMwTjA4dTY5RlFpd05GMGMyOGxzdEtz?=
 =?utf-8?B?MXNGQ1lDODRHcGVId0JFZ1FPNkgzYW5oUS9CWTdMSzdvVFRuQ0JNbjVvQVJP?=
 =?utf-8?B?cVEweTFUT1NmMGErejVuOGEwZzZxY1lGd0VwOWxXZTBNMTdBRjYzYTR4SllQ?=
 =?utf-8?B?TllDUU4xRU90d3JlZ0d3anpaQUc4aFVmR3IySWpWTnp6WHMvTC9uQ2RmSnFy?=
 =?utf-8?B?MFZFM2x0UlNBeXVZeVNPaXFvQ1QyWWNyYnZ5djVRdTM4bWJtVlVLd0NhT29W?=
 =?utf-8?B?YW9WVWE4ZFJkMm9zbzAvYXJ3RUJQWFhMcWdoaWJGSzdTV2pueHdmZDUwK0Iw?=
 =?utf-8?B?ZGxzR28wQS85STgxMkNnbXpITW50RGYzMmxDMGN5VnhtdURXcDVQWjFzSlJJ?=
 =?utf-8?B?YUxpZnQwbUVEVjAreUlXM2ZIMUpVd295dTVacDhUbDh4M0tFV3ZWNWk1YThC?=
 =?utf-8?B?cjRKeHFhL09YcHF5cXZPdVFGek9ITVJjamRiRlpyU016QnIvbVFDckZ6QmlB?=
 =?utf-8?B?QmwwNXg4QzFsdXBmUzVDMkNYRkcrZDVLRVB6TlVmWThOZStIb0x0N29PT1F5?=
 =?utf-8?B?ZVptMFZoNTlqUGxVbE5NNmkyaERKakxlWGJWWjNiai9hN2JTb1pyb0p5SG5R?=
 =?utf-8?B?aVJ4Yzl1TzdlaVo5ekhLQm5SaHFmaStISFNTZkJ3azdzSFRtVzNzdFZBUFZz?=
 =?utf-8?B?b0tXQUEvM2JOUEcxMzVmMGpBSFhhaUZaQ3JZUktWQTA2dzUrd1dtMFpNcVdp?=
 =?utf-8?B?Q09yTnlIQmJ4OWNIMzgvK2g4OUJCTjZ4MHFuVmVabjhidE1JNVZqa1Q0cStG?=
 =?utf-8?B?OTFMczAyQ25ibi9pNU1FYzFMMjVRMVRsMFdvb3VSTHVmVE5PcW1wRS9CZi9R?=
 =?utf-8?B?UlFXN05MRTFucjZ4eTNlNTRIUlBqcWNMK1dhWDZ0am5OaWJPeVFneFQrRVlK?=
 =?utf-8?B?U1FJWUIwWHJUdjFCUXEvWGZXRVBRcEVKRlUybFlWSEVRT2NUSU9oUDdDZlA4?=
 =?utf-8?B?WmxYR0RycHkwdGVmN0U5RDByRjByTUtMSDgxWVViVnpxU0xacW5mUDJEVlRN?=
 =?utf-8?B?REQvQjlubzVYNG9vdzc2TkhLWDBHMm5meDBjQ3dxKzE4RWtpd3dZZHpLcllF?=
 =?utf-8?B?dzVhcnd6cDI0ZDBQcnpIdklOUWdXYVdOMHhRZHZkY0lOckQ0bk1PRzRaMi9h?=
 =?utf-8?Q?zU3f2542ibC1ZtXopNCK+fH3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c628b5-7a4d-46dc-78a7-08ddd8e5c95e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:45:59.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzYIlTqGYNSXjcbpm8BZIGXFckcVuYxcqmqWo8r1+RKKN35G4fEpsQQRMzUQrk6ujx3cC21pfIvHIpaNBCgTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429


On 8/5/25 17:33, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
> The hardest part of CXL is the fact that typical straight-line driver
> expectations like "device present == MMIO available" are violated. An
> accelerator driver needs to worry about asynchronous region detach and
> CXL port detach.
>
> Ideally any event that takes down a CXL port or the region simply
> results in the accelerator driver being detached to clean everything up.
>
> The difficult part about that is that the remove path for regions and
> CXL ports hold locks that prevent the accelerator remove path from
> running.
>
> I do not think it is maintainable for every accelerator driver to invent
> its own cleanup scheme like this. The expectation should be that a
> region can go into a defunct state if someone triggers removal actions
> in the wrong order, but otherwise the accelerator driver should be able
> to rely on a detach event to clean everything up.
>
> So opting into CXL operation puts a driver into a situation where it can
> be unbound whenever the CXL link goes down logically or physically.
> Physical device removal of a CXL port expects that the operator has
> first shutdown all driver operations, and if they have not at least the
> driver should not crash while awaiting the remove event.
>
> Physical CXL port removal is the "easy" case since that will naturally
> result in the accelerator 'struct pci_dev' being removed. The more
> difficult cases are the logical removal / shutdown of a CXL port or
> region. Those should schedule accelerator detach and put the region into
> an error state until that cleanup runs.
>
> So, in summary, do not allow for custom region callbacks, arrange for
> accelerator detach and just solve the "fail in-flight operations while
> awaiting detach" problem.
>

This is similar to what I mentioned in patch 20: the idea is to handle 
cxl modules removal and not CXL errors.


But seizing on the error case, if the error is:


1) not fatal and related to CXL.mem: the sfc driver can keep working 
without the CXL PIO memory as a datapath.

2) not fatal and related to CXL.io: I see this like current pcie error 
handling.

3) fatal and CXL.mem related: probably nothing safe to do or too late

4) fatal and CXL.io: not sure if similar to 2 or to 3



