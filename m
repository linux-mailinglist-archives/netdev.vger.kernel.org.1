Return-Path: <netdev+bounces-114428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BB94290D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142C01C217E8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ADD1A7F6F;
	Wed, 31 Jul 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3ER8IKl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C721A71F7
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414054; cv=fail; b=Wu2plXAxgmuRoT5i/k9ITTSj6FPAEsvb6tL0IiCcgO/bK2zh5GlfzHW1Sgf68QzGlUyhFtdD2U3dfA10gY1WcrxJVBjZQZqdRyu9gxK01pNH/K0/Ga0KOazDEtDiciy41EVWJAuCHzQAkvnyZcGBZqXmC/bpPoMKHrGWVURa/Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414054; c=relaxed/simple;
	bh=xDzZH4ukRYS5tR8NmIZDW+cKUzWXqHWMOyjDcloAdtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mp2t64Ff4en6TrU7Ml+QDByk+VTGmLuoDA4GYjgUh7EzuR9WYJNepbsB8FP0EIh3DyW1yawUPoWORVpgl+YO9im/jG8OrGNhzKowGAHwdAFM1TcllroM5x4SNrW+XQSg8DEnVls/L+4uQeOtn7bCopiD+JJ9iIEnKG+zBjQ5ChU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3ER8IKl; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnTGFhZfCSeOkU2vFuKE4bMCQsayKwgYI0nm+t6uQqtsDO1GogP+8Qu2NypHkpuV+gxKEpJDW1vOsUOwoooedku3wzaX7GWShA1AlK8T7JMpWOJk1QrXHO9uuAKmTDaFMTY3mb7yX0GiI7OzGcN434PfWHJk1EK06zaXxWHw2/MaWpmjdn+6CY/vbCR/yxK23Vh3b1mpubo5GC3V/xXpS4JsU8ZwPS6UEsbSmc/ehwxGWMCpAMt7Ob+NrjbsvRBxx50gv4lZmIiVrRMdK++gifqIF/iUqp8W16wysJCjuXvjtmtCw6OCL0UTJa4seIniRqRdghytGrvxdNgW2JxpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDm15jJbgJOo3ECk/ISFdq8Ebh6KtQZY8eLhEwx9OmQ=;
 b=WjBoW1TDk91tjsjWfruqqJBkKX+kSD3Arv+9WgRGRstlBETIM9Gg4GuMnqGkmC0ivtkj+B2p5/yiEBd9cBh3Fo9IbUJHsU4cCglbcrdWocV3jvHYglSkcc/O+2ogDMHvXAS7HeHsve6HKEOzEKXnt1t8tGDgkXPpvA7DMw7ncJ8SnO2CTIzdnioi1XMEDOV2Ni+Fx4JQs5PHd65e6/ZCyk0Xn+KqmGfIDGKWpHOEtzL8tXfyrN/ICdKYeKVkwQYjq9TcIbvNVIGO18t/1WGMogRMvehC3FobMDAyfAOzUrIWQgrNugRqMpI6oC/UQTevX4HdkMybibO+Z7UHFe11tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDm15jJbgJOo3ECk/ISFdq8Ebh6KtQZY8eLhEwx9OmQ=;
 b=T3ER8IKlx0kyrXZBriUW8C94sOL/gVrY6wknIrmuRfnCLjL/aLFtJDKaxFoT1XJb9gpQfmzGmSzFJqX+ro9Q1Dh7AdbkUqw0GxJEA+Bw29ACuxKRW/AHP8BVGg6SriLMACgVvx+zb72mOFeHmALSd5WhZrtUMYwkcgBIvlHkTBv4VwVE1IrCOBAdyIqxRlk0gEofcbR+gSrfTIPpm7pAWwyNs/231ehKaSI3b8aY1RNa5FDgK9f18WMxAOgMaE78VxGIGvlgUXE7tNglHLJVYCmrqcKS5F6RlLWGJEgeo9szEFzqmM0tTmbjNlbcAIIYYmgIqKYSVsYvBvabi9owQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Wed, 31 Jul
 2024 08:20:49 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:20:48 +0000
Date: Wed, 31 Jul 2024 11:20:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com, Dan Merillat <git@dan.merillat.org>
Subject: Re: [PATCH v2 ethtool] qsfp: Better handling of Page 03h netlink
 read failure
Message-ID: <Zqnz1bn2rx5Jtw09@shredder.mtl.com>
References: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 37049bc9-1e3a-4e8d-a393-08dcb139aee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXJBRGVUalVvdWM4bHEvUFpIRzZPbU15eVdWMC9rQUxUYWU0a2Z3bE0vL1Ft?=
 =?utf-8?B?YlFRRkpwRzhYeHlya3pUdW1pQ3MzL29SR2R3STBzQ1d3eU9UWjlsemxveHdT?=
 =?utf-8?B?RXgweFBONUplWko3VnVlb2F4RER3UXVmQ2FZKzlxQ2xPSFV1aVZkQXJGdmdV?=
 =?utf-8?B?T2puZEhSMU9NTWhybjQxRnM0NHFMOG8xOWQzdXpMeWV5eTRPcWQ4bzdnbzJk?=
 =?utf-8?B?RjhrVFBqaWVaTVM4bWZlRDB1SmtWMk9WWGpvY1VxYUdLb3U5UUhxZnZpdVp0?=
 =?utf-8?B?V05qZzUwQ25jOEF1Q1ZRL1RwdGFrYmVhNnNqOTc1MTl2Zm1UMVJOZzFhTlFh?=
 =?utf-8?B?VmJxeTFBaXFYUVNNZ0dtUUZVN014ajg4YmgzNTlkRXZtenpKMmt6NHpHYTEz?=
 =?utf-8?B?Z01YMU9FQ3NTeFZWa01QS3Y5N29mWVhzcXpldUFsaDNGVXhLcHpjZWY5Mkw4?=
 =?utf-8?B?azNjTXhwZE01TFJycHZZT2tmeUt5bTQvUkxPRTBwb0dsZ1FSYlk0a1NYWnM5?=
 =?utf-8?B?QmR1MW9XQW9PRHE3OGlrL2xjdlkzc2JIeSt6bjhFWHRCSldzMk9DL0FPS2JR?=
 =?utf-8?B?MHl5OXI2UHRsWDVhNXBzU3FSbUxYSEdMSEtVUUVBQ1AxbEQrTTlRaWZSeXFm?=
 =?utf-8?B?MmhCVXhzV3hZdVYxQXJYQkl2Q2lvcStCcFBEZk4xb1pZWDNiYlFKa3NWbnND?=
 =?utf-8?B?U0o1Z1lSalh6b2M2a1FFUktTMno3TExmdEJXNE96azBKVktVaWJRbmlIWmRQ?=
 =?utf-8?B?cklERVZ1UjVZV1VtNnZsczlEdjk1cERla2dJdUEwdWx0NlluTDJRTlhxZk90?=
 =?utf-8?B?VWpYeTl4U3N4S0VPM3BpeWEra0NGaWFJT2NZd3IzVlNFM0JMRXRDNzJjcDA4?=
 =?utf-8?B?VkhIMWJ1ZTdLVjZ4aHZkcDFtbmhBM2Z4VW9SZnNxL3RoUWw5Wk9jTlBYbnBP?=
 =?utf-8?B?NkNYVTBhTGZuS3lEYnlqMFh3TXcrMEVISjZiZzlSa1JaSC9FQmg1TjgwbWlQ?=
 =?utf-8?B?ZE5JZlc4ZUt0dkx5T0JyTWxDUjJIQ3l1NnJJMGxneWdyYUFqWVBlNisrbldX?=
 =?utf-8?B?UEZRdUtsUUFCVnRtS3cxNE42eGFXRmw5MVh2RkxHQ28yZkRoUWdXU3ZkL0Q1?=
 =?utf-8?B?NzJRcnRSN3c0OUdYSE5tMkNrSU9iUzZEM01Hbmh6by9xTWpLMWZPVU11N0xJ?=
 =?utf-8?B?YlBRbDVwdXNibFh0dStKZExSSWFSNTFaeGlFbTNXM2p6dm1CREJXYm0rN0F0?=
 =?utf-8?B?ZElOM0hWaWlCQmhUbDdqN2hxSHdxZkZFRVB4NVNVa3V5SDhNd05rVlFsTXZS?=
 =?utf-8?B?ZzFIS3NkeVZxczk3bHJSWS9xeFV5RllsYTluV01SRWwvbHJ1eDMxalp5MzVM?=
 =?utf-8?B?cHlwZGRmNEYwQkRZL2lTUzN6aDZPOHhUZ2w3ZUFBWU8vWGU2Q2I3NlVxaHBY?=
 =?utf-8?B?SHNYV3R5NGJVakJISkRRRElaZUl0dGtBaEl4Rjhkdk9XN2hDNTF5N1ZDMmZl?=
 =?utf-8?B?MjQ4RTZRRmkvcmI4UE9pSFF5TkdHNXBCblV0VVFaN0RWVkcxeE55NXF2eFRw?=
 =?utf-8?B?cXJkZktOdzIxWlBtZUhiRlBBS3gveXFwMHlRM3FPRHA0QXBLV2NmNEZOQmtz?=
 =?utf-8?B?WStNY2J1SHJQWmwyNUNua081WkFZWVJ3aXVDN1l4eU44YjEyMlIrUm53MkEx?=
 =?utf-8?B?YkdpKzVHcjdsaGRnRjVPYURXUlYrVzFiYTlvVUppa0Jlb2ZtaU5jOEVrV1VE?=
 =?utf-8?B?ckFpT2s5NkN0VjVrY1R0UUV2KzQrR2xGb0lCOGkreFNMK1RhaVpmcDFzVzJy?=
 =?utf-8?B?V0lwNlVJek9wMVdLc1dVdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3huR0lrUWoxRlRLbjc0WnVaK204NlIweHhmcXZGSXV1QkcycXRaQVowTms3?=
 =?utf-8?B?R05VaVBYMzdZcEZHOTdRV3NnUnBUamdUdXFGckVWZFdhRzV5Vm9tdGNwYjNV?=
 =?utf-8?B?a0VQV3BpZ2hTSEFBbk1jU21RYWF2d0pKMXpWc203QnE4cUVzUnhxYkR0Sk8z?=
 =?utf-8?B?dGJ1c0lESGFJeDhpaHJkOW1MbTVabGY1VW9DaXhSL3NuRGZCT3VWTmovcTBK?=
 =?utf-8?B?dTh3NjRhUjhyNTNCa0RXM3JXbk50NWZSQzA4S0JHbmZVVm5FbzVnQTN6aHNj?=
 =?utf-8?B?OEx5SnJpV2JsZE1Ob21JbjhlKzE2Vzg0WklseXJoVmdXM1JPZVFWcXBKems1?=
 =?utf-8?B?OFBIdlV6OW93K0xJQ0xwUCt2SnFCWDhLQjNqc2JzZ3RpN0pVaHhLTENPbHNF?=
 =?utf-8?B?NC9JL3A4MDFWR0w5bm9EWVBSOTFEemY2RnVIdHZWTFNsdStGMmhSNllvTG9p?=
 =?utf-8?B?R2daRysxSDhyYndvMXloQ3hnb2JISXpBL3BBcUJPODNGUVpGV095dVIyUUp6?=
 =?utf-8?B?U01DdE1peDlSQUJXZHlidXJIc3pkTGNxZFlsM2RZWXNVRGp1ZFZ0SU9KNy92?=
 =?utf-8?B?eFRENjYvU254OUZhVXNuQ0VTWEs4U3JXWUltMDZFQ3UvbmwvTEpYS2tLL1Ev?=
 =?utf-8?B?TnJxbXhtSDRXNFBzUTNOYmVjQjByd0RONnYzcmw3YWNEQ3JISjlZU0NvdGlu?=
 =?utf-8?B?ZHRUaHhKeVRMRDV2Qm5aWFNLb0ppaExHK3ZOZ0VPcGZwOVNwWUxKTFd6OWNs?=
 =?utf-8?B?U2ZRbDNCeFFKamVEMy9UMFVPelpKU0xZSmcyeU13TTI1U0JWL3dCWlovSXRB?=
 =?utf-8?B?SUpkZ1ZpZ2NuZFV4cWtTY1pydjRzMUl2V0NlSVh2Rm9GL2grTGkxR2h3WDhF?=
 =?utf-8?B?QWx1d09WYy84YzQxUTZiM0ZFSVlXS2t5UlVBQnpESTlWdHJ6SEZicExleVdh?=
 =?utf-8?B?b0g5M1FDMmxyd0hkL29DRnFBN0lxdklKTUlPbEZVYnJVUFJIdGdNejhVb0hk?=
 =?utf-8?B?emhjMDY3WjRxTmtISXY3ZkVPcVYwOVJ0YWJTbExVR2l0YVlBR2krTmxZQWFm?=
 =?utf-8?B?MGh6eGRtNEdkaXBsdG9ISHJpcmR6eU84d2V1dU5VQ2NpTjRPQ0laWDd3bkZp?=
 =?utf-8?B?c2xWSzFYT05PUGpGYk9DcWI1bWdtYVUxQXdTUm9lUmhoeVZPVllKZzM3TTR3?=
 =?utf-8?B?Ymk3c0JMK050Q01qM1A0cGJkQU9oU0FIUEJKcDJUcVlMMEQ5TE9EUUN6V3pH?=
 =?utf-8?B?NHliZjBTMStvd2lpZG9OQ2U5VGlETGZrTGlSMUN4T3hlbVBOdzFQdFkxTFNr?=
 =?utf-8?B?NFZNV2FnSGJPY0xHQjZuTWxZakZWOSt4QjRiV1JFYnVuUmJDK25hOVZNSTgy?=
 =?utf-8?B?eHlYYzcxZHovR3JJek1oR0JETlRsYm9ZY0UxbVIxMkNxUm9NTmQ1dVRMSUlU?=
 =?utf-8?B?U0c2VzV4dXZ4OGtOQ1Z0WWRBZ3hMZ0MxcU1zakpiR1B6Q09aRTlxcmpkWGQ4?=
 =?utf-8?B?ZHZ4Zncrb1NQY09jRk41RzlNblQ5TmoxQjlqaDNBOENtV2JkN3EwSDNrbU1X?=
 =?utf-8?B?Q3VnZTVGZDVuOWZLU0luOXh2RzUvVU0zaXhDTzZ1UVlUQjgyTVc2dEJnWHR0?=
 =?utf-8?B?alR3dTRNUHE4U0p0VGpJVCtIM1pzYTBObW9YVzZERTZOMTVCQkVXL21LQ1M4?=
 =?utf-8?B?MndkREkwMzNXWnA5d2ZuVkcxS3g1TkZpb2RmUGNBRnYvdWpTSjhhcWVzWEZD?=
 =?utf-8?B?ZEhwNCtpbUZPMVd4UFdIQkxxcGdxTVBIKzdVV0hyWWVVTnlobXNsUFozRjlG?=
 =?utf-8?B?OUFRaGxvQjBJYUJWNE9yd1VLOUp0WlladFd6MExpNkg5THVmQnFXbGwyY0RH?=
 =?utf-8?B?TXpFaDhRYVhKY1ErMDhmeTQ4b3czZll2RkhQTWJIWXNFZWpISjcxUVpJRUc4?=
 =?utf-8?B?QmYrcEk0OFJoZ0tmMXQ5UkhkNEJmZTdkcmtjeTBCL3F0ekhpb054aW9kaCti?=
 =?utf-8?B?VGdkZEtqWVJ6ODRCTDdjY05abDlnRk4yZXVqaWlQaEVOeXNjazBscHBwK29S?=
 =?utf-8?B?SUdjSEdQRURta0ViVkJSdmtmQ0VZV2x2WUo3SnFzK0IwbnlSMS9GSEpQeTRW?=
 =?utf-8?Q?kzRVhKwGfMItuVfyV9r6Q0h5I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37049bc9-1e3a-4e8d-a393-08dcb139aee7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:20:48.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVvhCtnYrOiS92AGv92RjMUvBJOWxSkFqFMK98/0GME4QxC9+vLdlPlLAci3R/AnS55mSF5Hn/KVJjyn5QbmAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

On Tue, Jul 30, 2024 at 05:49:33PM -0700, Krzysztof Olędzki wrote:
> When dumping the EEPROM contents of a QSFP transceiver module, ethtool
> will only ask the kernel to retrieve Upper Page 03h if the module
> advertised it as supported.
> 
> However, some kernel drivers like mlx4 are currently unable to provide
> the page, resulting in the kernel returning an error. Since Upper Page
> 03h is optional, do not treat the error as fatal. Instead, print an
> error message and allow ethtool to continue and parse / print the
> contents of the other pages.
> 
> Also, clarify potentially cryptic "netlink error: Invalid argument" message.
> 
> Before:
>  # ethtool -m eth3
>  netlink error: Invalid argument
> 
> After:
>  # ethtool -m eth3
>  netlink error: Invalid argument
>  Failed to read Upper Page 03h, driver error?
>          Identifier                                : 0x0d (QSFP+)
>          Extended identifier                       : 0x00
>  (...)
> 
> Fixes: 25b64c66f58d ("ethtool: Add netlink handler for getmodule (-m)")
> 

Nit: No blank line between Fixes and SoB, but maybe Michal can fix it up
when applying

> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

