Return-Path: <netdev+bounces-230529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5CBEA83A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC25A8D1E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261821C9EA;
	Fri, 17 Oct 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="vcY8EI5C"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022118.outbound.protection.outlook.com [52.101.53.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517413C914;
	Fri, 17 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716834; cv=fail; b=o85QZAJdG7H/p2wb5URDJZ4XlCihfhgmsaDWS75kn/cQdLYsm4G9VCLPMSr4qKXXDTHeb9L/G8i8Mwm93TVzUP6brhQKmtWCrb+OXtIvX6u3RzFB02Hgt+TSHnMSXlW+PeTzAo/UKdwNTIHcOxxNrDbrjVyxSmCCINonBf70g5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716834; c=relaxed/simple;
	bh=a1fDNCg54Luq1gIyBLCyOFOtKDhieFt6tZALVkB/HIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9RxHnBmg3K0GsIoTP3wx6e4gXXysFORcsMCdgRAFV07ax6BLyNVB8bfG9S/7jjwZ3JvZ2GrIdCNA1ETnWIma3xpeknH7eM9rYXaBEBY0lpYUY+b60HlH3YKJE2M71xBHye8WBG5x8Tf6Imb3GdoJpuYsC7MFwEiQ6mwwFDbFUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=vcY8EI5C reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.53.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBPkue63xDYM19lcjkLDP0kzdnkyCo4iUmvQYEWME3C4IE2KnavkUnIgTPtTB1yA6xFggtSFjec28zyA/0ls1B0B+0UOjz+n02n6y0XzDhI6TAN85yv0NUEuclg130ArlecoZ/eVIRl97yZ/u9MCJsa5nieLWzfHX1OXzYrquvxGQR0hZc49ym5qyiB6tqq1j9u3Q5CDKmkHULTd77114LaN+vt+YeT221FJcLR+IGeph0W9Sykn5GucoRkWbI3eLKWfm7exSwXQGf4/EC9P3Eyw5dbYB80ZyWkcLqgr8MpAbpvMMxm/j+eoyJGNqEADTThpJhM7vCZBEju8RxDg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66AmN8vvXQZzPx3Nug3xSGocT7x7AOktPAWl3b4ZdaE=;
 b=jmM8c780+a/A/x8k68yJ8nWgzOUxL28i0bdOy/asvrjcmqN+zhqTQQpmh2rMMYr/xiRFAVTzdPaVmvrth/SKkfdVoF5V3j7yY2A+Mbx2M1tJD4J0PR7/psKOKgDB1JZBUZSxfEmaPqBuE1NfL8PV4RkCwuERC4xW0k2IcS0OZt+0o2LfBZ1/yvPcAJOjl5VwfsWyJA3/TINzcRq+oEDNiFEHoWXdJISzmriDnvTbLeSmuP6KIJHak2n9noJmAJrwysCEbxWEf+PLMTR6QOLlyqYeSL5fzFI+/XQEJRKxEnzu97O6wVHi+JdiKjC+l4ZR66tru30jmMqj/Rap+dUUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66AmN8vvXQZzPx3Nug3xSGocT7x7AOktPAWl3b4ZdaE=;
 b=vcY8EI5CbQ5GP+fRifqevl8y2ZvCNNcf4g5VrwxO78DLfUu/N4ZbheytgUI1RtlABLNnqMnd0htRcuVQBNYTbPIIn4XdsBw/rxLjzNWU+/PqwdqKbIjpdU+jmqmdLXn8DzbqwOW5SDmmYcYEvuUXAxXuXVTfzwoUxPSzIBnvvDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB6535.prod.exchangelabs.com (2603:10b6:303:d9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 16:00:29 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:00:28 +0000
Message-ID: <edad8768-b7e4-4dfb-a08f-f85bbc443eaa@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:00:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar
 <jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <20251016-swift-of-unmatched-luck-dfdebe@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-swift-of-unmatched-luck-dfdebe@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: d243934e-2d65-4764-1571-08de0d964acf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1RDaXdDbjJhL1lHMXhsQy9qcjJlNno1MzRRODRrTEdYZld5YXhQK21nUmdW?=
 =?utf-8?B?dldDRjAvb3FqaDB4cGM3QWxseWhsc0dBWDVoNVVFbjhpTU1Ra0Q1a2M0NjE4?=
 =?utf-8?B?bDlpWGtiemdaSEs2WXdrTTR6eTU5SFpJTk96cGlpSjN2aGlIZml2dHNWb0lp?=
 =?utf-8?B?ZUtyeUszOU5zU2hja0xZeGtHRDUvRVhmSytjRUx0Ri9uVXFsdXhvVmZlTTRR?=
 =?utf-8?B?V0ZmZjI3MytubDZZZlV5eFNsVkZOM2FWZ2NpdjVVMXlzQVlRQlozNmFFYzhN?=
 =?utf-8?B?UHUwY21sZVdzSUNXQlYybWorK2pVcFBaaEpvRy9ZU3Vva1U3R2Fqd1Q0SSt4?=
 =?utf-8?B?MGQwckJEQktrQXE1VXRWYXczaCt5MXZXL0ZHUFBTbkwzMkFGUlZWem9yb1Y3?=
 =?utf-8?B?NFhSbzZqOFpLb3B6K1ZkWEJCdHhVMmVuaWRlMVNQMkx0cUFSZExkcUlNYzZC?=
 =?utf-8?B?aTZVY1ZSRHlkbGhieFJEY3Z4MkxXTmRCRXV5dm5SK1FjQko2M05JMk0vZTVH?=
 =?utf-8?B?eFBMUjlGK0FPUWprTXpQWkZEcllvN1NUUDRnNmUyMUxueGtZSXd2dy91SThB?=
 =?utf-8?B?VWpFbzVzaUhPcXpmaE5nWEtCcTRSNW5UcWYzcXhJb0VvQ05OWkdEZTNwYjVo?=
 =?utf-8?B?U0FOZEJodkF6TUdEbTdKSFZpeGJUaERqV1ZGSGtKanZmcUt1RmQ0TXhrYWdH?=
 =?utf-8?B?WW5aMXF2djhzY3BtZ0JsMWxMRG9pQmxtUFdrQ3FMNEVidTBRMnhYLzBISDFt?=
 =?utf-8?B?bTF4cVYzWmNjTGErSVhXeWZ0bHlHRHFjRjZaZXR5ZnV5VWF4ZUlPY3psREhB?=
 =?utf-8?B?allLRVZlcytmc1N2YlhuVjl2Nm5vSmpsZDR3ZlNiOXo4Wm1iTml6UHpSSDdC?=
 =?utf-8?B?SGpFaUFEdlNqeEUvQWVmSFd2VENjZ3RQQm0yNjNGY2g1aGRNOTlGWkowZzZC?=
 =?utf-8?B?QVZOSVZIRHM4SDBZOHlic1g0bWZYMjhUOWIrMzhHVTlINURPNzFxTlJCTzJI?=
 =?utf-8?B?ZXRrdWwvejRjRXBwL2dlODJWRzN3Q2NhNVlXdmUzSmw0RVNWbHI4ZDBYY2lI?=
 =?utf-8?B?N2d6cmZoM21Nd0VZS3BJdW5iZTdYRHYwd2dZOUV0bUJyR2xGcEp2MTdjOTQr?=
 =?utf-8?B?YVk2SGRFRnl1MWVVZU1HQVlMVGpnbmNoSi8zejZZZllqejlzMU9yVGoxRVBp?=
 =?utf-8?B?Wk1jeTArZmxjZWZQZUwxK2xsMncxQVF5aDlweU9LenBqOUVHZXFqR3J3K2h0?=
 =?utf-8?B?RDNJWDhSc3VGditWdTA3cUJmNW9vdkVscVF4VXE0UXk1QlFOMkM3UHA3d3h1?=
 =?utf-8?B?RzFpWWduSjBnKzdUcjBGU1MxT2s0NVNxbUZDREdUUEt0eklVb051MGQwTm5I?=
 =?utf-8?B?L2hFeUJZeG5iNUR3ZG11YjNKWmRrWlNhQ0R3Mm1lelBBbmZvQitkaXdGUUl3?=
 =?utf-8?B?SEdjSUI1N1FSQmt4aTF0UHYxb0JReVRTR296NjdzWHBEM2FFdm02aVZQVW9o?=
 =?utf-8?B?dGVrUUZ4Und3WE13QXVxSDNJLzVvUjhKQVQ2QldEekhYeXhLbWVPUkhPMmNC?=
 =?utf-8?B?Q01RSzJyaWV2Sk5GTkdwUG5mVHFnQWZHZU1MS1VlUmhpWnNsT2pTT0dMSHFO?=
 =?utf-8?B?bklQTWRzc2ZKRHVuVkZyQWhiQkpFR2V4NjZuK2lkUlRLeUVFQXI3MjROZHBp?=
 =?utf-8?B?Y3Z0MWNaVDIzemxEalZINWEyWjhmZFpFOTBSUDVuUGFXQlpuc09OY3h0RzFk?=
 =?utf-8?B?blo3ZXFjdUxEbHFvbEQrQ1M3Mm9LeUJXUms5MDluN1lPazVYVlMvZGVLa3VF?=
 =?utf-8?B?TjF4QnVlU0EzL3oydVRZd1h1OXk3U1dzN0xZNjBYWjlKNHd2K01NL2lXdHhq?=
 =?utf-8?B?SWtaOStxaGRzaHQzeUx0OTl4WE0yeEd5QWp2dzkzMW5KQjdJMDFFd2swaXUr?=
 =?utf-8?Q?i3m6MtF++DRh5IijpY4tYEVjM0N5yKl/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2E5b3lCM3NvNzRNclcwNFBmRGN2WHBRSHFNYno5Y2hyVGdOczM3MWR0cVhY?=
 =?utf-8?B?SDVPVFBoUVRLQ3hBcTVMK25EMkZDdS82QStDVmM1WlNUdG0zRjRUY29pQVY3?=
 =?utf-8?B?amFTUDJjUDFJUUsxL25qSCtTQzVmak9jL29CditxaCtsWmtsV2pNMXFQbFJL?=
 =?utf-8?B?eXdQQ1BVVUVvUDlqR0cvVzJIOTZUTXEzajllTHRMeWpuOWdDTXpQaUpSU2Zn?=
 =?utf-8?B?eWx3VGJ3czBqSlZJcHZveUVnRTZyenlMNXZqWXBiS0JVTjJlRWUvMnhXSnBL?=
 =?utf-8?B?ODJQNjBYQXIrNzZveGtMQnA5QVkxWVVhcEIxR1JzZFRjSVNuRm1Pd05qUXVw?=
 =?utf-8?B?WEdBSWtudDhoR2RyYVgxWkUvaHF3RVgySnhIbnBEcThzRDhzdTV0azhwT0tE?=
 =?utf-8?B?d3pNbjBuYlRiZ3AvQjNWUmZjWWFhM00yVWJTdWJDT2h6VnZORXhXbWYvREd6?=
 =?utf-8?B?aHI4anNmTEV5bEhTUjFBWkpLS1RxVjlTRUg2SmNhMlQ2S0IrSUE4OWNrdThX?=
 =?utf-8?B?aHN1RktlZ1h4TGdVNEU3ZDdlNVBvNXJKUEZESmhpVkVDL0tKRkptMzd6VzhK?=
 =?utf-8?B?b3VBL0l3Slo4K1VDeUdBZ0xKT2FsS0Rab29qVVBXSnZoekRrWUYrckpCMjhw?=
 =?utf-8?B?amc4UENDbVlKTy9QRm9PYlZBd2Rjd3BxeFhxZUpacWkyNEliUlRkeW1XY0pp?=
 =?utf-8?B?SHVFN2tkRStqSUZyUDdMelYyMDRYSlloWGY0SnBmMWRPS3IzeFVVUU40ckJr?=
 =?utf-8?B?SkZyQjBRVy9LOEUyTm05VnpPV2E3T3lWa1NBVXNQSTFPaURxTFpKWHlrOWRC?=
 =?utf-8?B?ZVNad1ZaR2ZDRWFkVjlLRWp3dXNjWXJUL1lFWThIcyt5cmhIODNsNTg4MXp3?=
 =?utf-8?B?Z0QvOXJsWExjQzR6YjNXcXY5QzVtTmI3Q3FZYzRPcnU0Z0NHM1FHWXF2VldI?=
 =?utf-8?B?L0p1R2gxWjNkbUFxMHBoMW40aFVReDJGRUlHT2FLc3Q3RTdoQ3BjNlNFZ21Z?=
 =?utf-8?B?d01VazAwS05td21tdVM3dXZGeHluUWQrODJFdFhudjk2N2NTSXRSbENnUkJJ?=
 =?utf-8?B?NjlkUU5oRG90YjBQMmF2dUkvN29WRm1WM3FkZHRETEpSWEp5RUk5WmtQaTR1?=
 =?utf-8?B?ZFhVQ1VncVdpWGhORm5FekNaRUh1NmFsU25CcVR1K3V6OFpxNTQrbTNQN01K?=
 =?utf-8?B?Z0xRcDFYbkdxS2NtVzlkSmxic3RRQko5ZEFUYzVRMFlSMTdJQkxhRFRGMHJY?=
 =?utf-8?B?RDVWSjUvdktnSGNJcEZoMzVOckN1UTBxS1pxYjV3MUFnRDNuelZMV1B4K3dL?=
 =?utf-8?B?elN0Q3VBaUlxU0hFS0F6ZFR6YzdTbTZGZXRqS3Vhb0lCcFA0RlpMaTl4RDlm?=
 =?utf-8?B?UFRLaEV5aVBWRVR1eXhuaGpyZnptSTBGbS9zWXk5TWxGZU9BbEF5N1NNMnRr?=
 =?utf-8?B?Q2s2SVNETjhkdTg0VkRwMTROblcyS05TV1I2TGs1LzZNQURtWHNkOTE2RWlp?=
 =?utf-8?B?aHVsYkhMMEZjT21tMGczTlQ3aGM0QnpJR1E1ZHR6ODVjbHRKZDZPLzExRjd4?=
 =?utf-8?B?SitDSDF1ZU1HRW4yVDVYb1FFdnBnUEY3M0tNaTNsRk1XZzFwSjIvTmtER0ZF?=
 =?utf-8?B?WEZEM21sSWMzc0hQc0xpTEFDMHBUZldjVzJ4MU9IYkVxU3lHLzlyZzBxRGFT?=
 =?utf-8?B?VG96YzlJOXJoU3lFS0ZkaW1FSXhtVVVVZHEzZ1VxUysxTC9udkYwek5QcmZw?=
 =?utf-8?B?bFJQdERoSzFrbTdaMHdxS0tEbGh5dzByT3hHUVlEZDVuSVQ4eHBGaWwxUWkr?=
 =?utf-8?B?Rk1WWkNBdTNNRmNsTEpCUWV1Y3hXWGd1MGt6V29KQTZNVXI2KzBSY1J3c1Yr?=
 =?utf-8?B?Z0szbU9oNHpmYUl3d3h3RDM2aGJ4UlRGYW9SUXhSVlVkcjMyVldkTGNRQ0lW?=
 =?utf-8?B?QWZXUVcyYjhpUkVtRkZVSzNMK0MzTXpWWUs3OS9ud0xmaDZPclI2dS9lb0pD?=
 =?utf-8?B?RXVQMlhuSnpwQ01YUGhxdjcxZmZtUW4yVUg4cnN6UVYxaFZ1U09QbUNuc2VS?=
 =?utf-8?B?QjNOMk5iWnRKM3l5U3RrK0pFYmlXRWhtS1J0SC8rYzU0Q2hZdSs0R3pTRXRq?=
 =?utf-8?B?TSsrTHZpNlFzOXlKMWZKQmpjWERFd1BjQ0xwbnJQdUwxZmRlNnZVbHFyaXBo?=
 =?utf-8?B?cG5xblJqSm5sQ25LN3o4aG1DVndQMnlFS3JmdnZJSUZLMDcveEg5RWt2bUEz?=
 =?utf-8?Q?5pb2w/sfLhRFbPPnxD5sFcbNDCESslHDMkjRKTE1Jg=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d243934e-2d65-4764-1571-08de0d964acf
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:00:28.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE+cknrlsNJqlkq7xaFGB2x4uLowXrfjtIsFH2QqVo4FvctmT8iog3UhtUZ2NQm5eUVmm7dkcl8ehP7RtZdLJAzKp4IXq6wQOVlE0+/nGAxnyfcZV1fFH+/DAq3frvyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6535

Sorry, thought I was clear in  ACKing it.  Yes, please revert.

On 10/16/25 08:50, Sudeep Holla wrote:
> On Fri, Sep 26, 2025 at 04:33:11PM +0100, Sudeep Holla wrote:
>> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
>>
>> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
>> attempted to introduce generic helpers for managing the PCC shared memory,
>> but it largely duplicates functionality already provided by the mailbox
>> core and leaves gaps:
>>
>> 1. TX preparation: The mailbox framework already supports this via
>>    ->tx_prepare callback for mailbox clients. The patch adds
>>    pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>>    but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
>>
>> 2. RX handling: Data reception is already delivered through
>>     mbox_chan_received_data() and client ->rx_callback. The patch adds an
>>     optional pchan->chan.rx_alloc, which again has no users and duplicates
>>     the existing path.
>>
>> 3. Completion handling: While adding last_tx_done is directionally useful,
>>     the implementation only covers Type 3/4 and fails to handle the absence
>>     of a command_complete register, so it is incomplete for other types.
>>
>> Given the duplication and incomplete coverage, revert this change. Any new
>> requirements should be addressed in focused follow-ups rather than bundling
>> multiple behavioral changes together.
>>
> The discussion on this revert stopped and I am not sure if we agreed to
> revert it or not.
>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/mailbox/pcc.c | 102 ++----------------------------------------
>>   include/acpi/pcc.h    |  29 ------------
>>   2 files changed, 4 insertions(+), 127 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 0a00719b2482..f6714c233f5a 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -306,22 +306,6 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>>   		pcc_chan_reg_read_modify_write(&pchan->db);
>>   }
>>   
>> -static void *write_response(struct pcc_chan_info *pchan)
>> -{
>> -	struct pcc_header pcc_header;
>> -	void *buffer;
>> -	int data_len;
>> -
>> -	memcpy_fromio(&pcc_header, pchan->chan.shmem,
>> -		      sizeof(pcc_header));
>> -	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
>> -
>> -	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
>> -	if (buffer != NULL)
>> -		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
>> -	return buffer;
>> -}
>> -
>>   /**
>>    * pcc_mbox_irq - PCC mailbox interrupt handler
>>    * @irq:	interrupt number
>> @@ -333,8 +317,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>   	struct pcc_chan_info *pchan;
>>   	struct mbox_chan *chan = p;
>> -	struct pcc_header *pcc_header = chan->active_req;
>> -	void *handle = NULL;
>>   
>>   	pchan = chan->con_priv;
>>   
>> @@ -358,17 +340,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	 * required to avoid any possible race in updatation of this flag.
>>   	 */
>>   	pchan->chan_in_use = false;
>> -
>> -	if (pchan->chan.rx_alloc)
>> -		handle = write_response(pchan);
>> -
>> -	if (chan->active_req) {
>> -		pcc_header = chan->active_req;
>> -		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
>> -			mbox_chan_txdone(chan, 0);
> The above change in the original patch has introduced race on my platform
> where the mbox_chan_txdone() kicks the Tx while the response to the
> command is read in the below mbox_chan_received_data().
>
> So I am going to repost/resend this revert as a fix now.
>

