Return-Path: <netdev+bounces-220800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E039B48C78
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C301B168900
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EB22756A;
	Mon,  8 Sep 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3zIzPT7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35E21B9DA;
	Mon,  8 Sep 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332120; cv=fail; b=cgd7IesavfkGriDsx46InYQUuCSahBo6GuHhFUD5BXoytQ3o7TAyOrOzfXP/SOK3tddX5YfbimZn9Ip5VvgVUc4Sq8gzsDhGDaS4Ao2WGRqiqn5o/8gnSHcjogF/s5z81dXQ6Ic+z4ZaQUhDh6Cr9VK6C9q/CmpM5yXbZ595cLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332120; c=relaxed/simple;
	bh=J1cGL38J6nZBnXxiaQsiS+6KYOW8xAth1b8zp9+DB9M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdz3Q6Gc7gj9qoAKpHJv+Sf6Jwv2BVZq2Jk8GmKU+WbgqeaZfclTQ5SSLfSnlHEEuePgvIKVd/8QhPTJ6Nd0mNyNHARqDU/7FhHIKqOhduiDKixRmy4av2R2qs1SFF2dx9/kZP8KVjn6z+OhhVQbxFM/3djpm2kivAYRoHahs/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3zIzPT7; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imw14xURd0V1b+iSaJXDhue9lT6um/9FZMSSgchydx2Dv69UJpF7GD8vRNVEDCtHvoEYK6rPwNgIqrPry3wluBrZCvw8ErDVKa/fGCMEae31lrFhn/pHmiSaGmKM/1Axw2Wq9zn52BUUJwfxTWO2+gyzw5GlMjQMjL44q6pJtZfdK62bJlEJ9PMlJanfoH+WaTI5QYlj4z/49bcwhf53LFdWRB4Wo03B8+kd9g7S8XR0vXZcXbSmvuTsiGkG5RwG+7X4zjqSspQMf5yyUphkH4R08OdaCisJBjB7woEtt4thZ/fHJsv1Lzdjs4bVCvm4RVSj0SmJjAztqvsyZTAMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL7O5Ybh7n9TT0HmpP0GVA4zVAFcRU23ShJxTuQH1Hk=;
 b=BSqdHK5gKVzQyo088oAFoTDC33urCIYU/4MncxYiAH/nGuGizBUCJXHMmsF44DuHlnVcLdUUzpzNnvlAL0CGic+2+DP3ShEA8r5ib9xYdoOrj/KDeHNlZgabnkl8yiopBtug5m3Tbivzb3jRWtofBaMYIw8VKMQqbmqucGWnio/UJ1l4YtPBU+3Ra3cxHm1Wo13uy95xRYPb4if7Qr7NyfXaj88EzbH9ibny5GXlybkBGMGkITDz4hQXlgqqvOHM4zZXdljY/M6KuRLbb1INtUBduBQb65KjnTckPyJzHs8ayeS5lyBVOmjQfLIRvsmqHCPK2bxW+8kx1MNRteJ5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL7O5Ybh7n9TT0HmpP0GVA4zVAFcRU23ShJxTuQH1Hk=;
 b=B3zIzPT7N+f8Q+rbhdW17rY+nCc3MhWPbNml4LPat7nG7V3yU/oKusvj8T9wkK91XWD4c8E9qmO0JMJqCbw/KqA95yZogYfmy4D3bEqG/FNNrbpQ0kY4VIZ3Yfjey5dN+EXCmfLq6ijM6rBOZ1yxCQBsf616U89p61+mmhjiwfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:48:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 11:48:33 +0000
Message-ID: <8aaeef56-a1fb-4bbd-a2ff-45a4464d6e48@amd.com>
Date: Mon, 8 Sep 2025 12:48:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/22] Type2 device basic support
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
 <e74a66db-6067-4f8d-9fb1-fe4f80357899@amd.com>
 <44898314e457669a80ccb08976813161d8cd9eb1.camel@kernel.org>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <44898314e457669a80ccb08976813161d8cd9eb1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::22) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4a77ca-3f03-4a53-3dbe-08ddeecda280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekVYak1CVVVLbnZ3MmJoTytEZ0JwcC9ETFUvNmtWWE1DdkpuOGJxZ0ptWXhR?=
 =?utf-8?B?cE9kV0dleGVSajBXTzNGYm8wRWV6RlMzLzlpWHcrLzVaQytXL2xlaS9YdUZ5?=
 =?utf-8?B?U2EydGxEUUZueG9oOHllSXJaMk1scmNOdGg4cU93R1ZTMUQ0cjBUcXl3NVNr?=
 =?utf-8?B?SEIycDNLNVlXRWtxYWNnSy85L0RJcEFVUTRxbHZOZkwxWUY2SGw3TDVqRjlV?=
 =?utf-8?B?d1REL2NUSHRIdlhTMmZNTEgvbnR1T1JDR3NjOUx1djViVE13d1VVVHlSYi84?=
 =?utf-8?B?bmR1S1BoWFUxN0Z6aVNmbW9iaFRFM2ZxMmUxd3RLKzRMWWZyM280dU5HYTRy?=
 =?utf-8?B?bXpUWG1KMzQ5bFB2eEk5WUFnS2hjNEtaQ05yWlNuKzhvUS8rRkE0S2wzTUw4?=
 =?utf-8?B?TEVWbzdmVHo4Um5sd1hTK0hmTVd5TTk0bzQ0bGNuWTN1eDlMNWNCNElRNW85?=
 =?utf-8?B?eUNXUDFQb2R3N1JEbmpZQ0dCd3ZNb1R3OFExNUQ2Syt5YnFUWlhHQnBmTTFo?=
 =?utf-8?B?aWJjbnZiMGtFaXA0Y2hMWHhzM1dabnVxMHpCQ1lRb2pYNnVTVHBSdFlETVZt?=
 =?utf-8?B?bjVscG1MVHVKUkF0K0s5bmRwRm8wWU5YWUJsaUptRkwxeVh5NGlsS3RrL3Za?=
 =?utf-8?B?NkRheCtlSWJjdlpJaDB1Z25WMTRVbkhmNkxKRkIyZ0xLbEFZOVhFNnFjNmdr?=
 =?utf-8?B?YUhKbis2OUR1SndidkM5QS92V3hVSVhTZm5qREJSL3FBWTduV1djZkozd29m?=
 =?utf-8?B?U2toZlN3RmdKNlVZbW9FaTZHRTllbHFVNzNxTzk2VnFGcGFTZFVPVEgyRE1N?=
 =?utf-8?B?K2ZLaUozR2kzVmRDV1ZKZjVkV2tycEJrRnc4Y01SdEtwZUZRN3UzYTBvSWRB?=
 =?utf-8?B?Y1hTR3F2YStIcUgwQmFFaGZ4U0Y3THYvUXZLUDAzSmRiVG5WbXk5OFBRYSto?=
 =?utf-8?B?QWJNMVVjUlNITXBLSDhsT1kwalc1VEovby9OY3Q2MGFyaGU2MjRLMnlCcUN3?=
 =?utf-8?B?WGYzb0J2dDNvZnpvWGc0RERsZUoyVG8wdjU1RUNwU3F1MU4rT09ncjZTYUxE?=
 =?utf-8?B?YWszUnQ3SGRkaUtIMURWMTFLSXBZamFyQ0dGczBOQzRWUDViUDVmSm53TUNo?=
 =?utf-8?B?S0x5S3lMZUpldzBUb092TGIvY0FHb2syZlJsZFEyY1RUUTF4NXZOdHBvbjlR?=
 =?utf-8?B?UmgwenRSdm5ORlJXZmRHWmVqOUZtbEF0SmNTcllxcytka0NWVExBdStZQWor?=
 =?utf-8?B?Z0FEb0c4b0V3NHl4QzVSbmZBVitrZ0hwZG5vMjBLUy9rakxlYnBpNkIrR2N6?=
 =?utf-8?B?RnlRU1VjMEs1d1BVMHEvVVdSR3dZV3NlQ3pGOTg5M04xQXlmZGhxMWllb04y?=
 =?utf-8?B?cWRscnRKSklWc2s3WnNxTTlqdWFwbi9yNHFsRUc0MnM2OWdSaUN0N01PTHhO?=
 =?utf-8?B?TU90Wm5zZ251aFltNExzWmJFTDFUSTFoSzk5WVZVdlNmbHBoRXVPQ0F1Qi84?=
 =?utf-8?B?V0NYR3YvMnV0WlpUMFUvaDRlNzJBRy9KOTJMRG9BWE5yQWVNL1BWZVVJK3Vi?=
 =?utf-8?B?WlYxbG9hR2tENGFmKzRmTzNEcm9xSEdoZTROSHBycU1PM3dDLzRRU2hZR3dl?=
 =?utf-8?B?TGkyZ2lZbk42Ly9YZ2paU1RVc0lweWFhUFk5UTZQMXpPZC8vRnc5blFpb3lh?=
 =?utf-8?B?VWswY3o4VGwrVno3MlJvQWlLQzgyL3Uvb3c3KzZzU2RGU3BCY3JPcS9YNk92?=
 =?utf-8?B?WWk5OXowa2hQY1FmZ0Z2eW13OWhaN1RPYVpHTWxOWFR0MGhqUzlodldncXc5?=
 =?utf-8?B?QnlXYjFCYVM1eTlKWmFTSVp3TXJIQ3JvSGdZclNLaVpMU0Q2SWM5ekhwTlhH?=
 =?utf-8?B?WlZScmw4YVRvVU04SFkxN3FTMXpYSUhKNVJQLzZ5MmQ5UGZQZ3Q1Qm9QbjlZ?=
 =?utf-8?B?K2xBWWFZZzdiMzNJZThoQm1CNm9YUm42aTh4a3pyTk50TGJ5ejlBS1NFcUpU?=
 =?utf-8?B?MktmSDRCbGdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dIMEhMYUVMUnpLanVCKy95RTB3eDFyWjEyUVRYYXBVUVEwaXZPUU96aERE?=
 =?utf-8?B?bmNNR015TFdYME0ySFhvaUlzRUxQRGdGZzBUMkNIMHRwTFRmM085cFY3UUNy?=
 =?utf-8?B?T09IbitnZGxwaU5PMUIyNTdLYlB3ZXdRdGFVNHdLZ01lZ3hSbjVLZkdnaVln?=
 =?utf-8?B?SEJhc1FsR2x6RmdQNTBDVzlBZThWUW10bWRVZ2pSM0kzSis0bFQxbW5LYW40?=
 =?utf-8?B?THlTck1UNVo3elVHUldUa0JIU0h5bGNOYVZMekVjSTkvV3h6V1pvR0p0ME0v?=
 =?utf-8?B?NFp4WHJ5WThoRnFYbjdjMXAxbXZFSUtCR2ZEUHpCU3Vvalk0amFtUmc1MG1D?=
 =?utf-8?B?RUN2SE96Wjh6YjljdGt5WDhrTnd4c1JvT2VGSG5HZ2liemJmeGZNUW5Va1g5?=
 =?utf-8?B?UnQ5RDN4VERlTUFVODVOYWM5b0JMc1JrSmIydlJqRkpaSWd3MVhzMkYrQ2I3?=
 =?utf-8?B?aGp1TE1mYjZSR1R4bFMwWmQwYkFXMTZuS0dNT2JadytJRXh5VkdqK3FqN3pZ?=
 =?utf-8?B?UUE1VlNtcm9rZDRRd0ZtUjJ5MVVpcEt3SGp4bUdmKy9GdTVRN05uZVRsdW5h?=
 =?utf-8?B?V0VKSUZNOFJnSUpyUEpxN3pCRHRtVVljN3pPM0JUenJyYWxtcENkUVNTdVFC?=
 =?utf-8?B?NjRKbytCTEVWUVUzTHM3QW5IRk5nWXo3WU1wbnRrWEpaMVVCaHpuMFowRGRs?=
 =?utf-8?B?aWpUbUc1TjJFZ0UvdVA1NWFrZG5aNU1adThoZTR2NlhSS1hpZTlXRnBwMFJ1?=
 =?utf-8?B?d2krRHgyeDZFdkthSTFXNmdwZFBkc0lKU2xHbUt2M1EvaDRWemRWYzYxSzBM?=
 =?utf-8?B?QXJ0WTFqY284SXFUYVRienZwZlNCNzNHRExlZ0tHVVRkcVRsSWtJZnhJM3p2?=
 =?utf-8?B?Q2EvLzRtQjM5QWFjeW1RUEgvenZvNHExUU1wR3QzSFlFZXhMYURpSDA3M0hq?=
 =?utf-8?B?QURWOTNLa0xBeCtDTW1Nc3RWeHpkL3JJUm5TOGZPeGJGVEdnUUczSENzMW5v?=
 =?utf-8?B?MzBvTlZsTnZCYkl4NktQbmhnUGZjN0hiaEVtUmVlZm1GSTFmZkxmZmREZDdq?=
 =?utf-8?B?TVU1WGt6c2JBQ2ZBc1RJdmhlUnBrUlo1dGEwMUVRVVJqMTJsRTJoblZhOWNY?=
 =?utf-8?B?Q0UyVkxCNFJYYXhzSks2Rkkwek1JZ2xDOVltUG4vSXpWYW5MZkFzdCtuQWpX?=
 =?utf-8?B?SDZuU3plVGE2Qzlnd0l0UjFKQ0Q3RjQ0TzExejQrTTFtb0lQRU9zOGtJQ3Mv?=
 =?utf-8?B?cjZwd0R2WDdjaWI1TzVwUkp3Y3p0YmFpblVYTmNQaWpWdlNjWm1sZHZHQVBk?=
 =?utf-8?B?RGYyR3cvdGhQME5GY2x2VVRQT0RRYWNSemRFVGJyVUZhOHl5V0JUZkxmdDhm?=
 =?utf-8?B?UTJiUGJHZDM2QXNDVkpIbFpMTTBnbmNKLzJaZy81R0xEM3N4Tk1GaGxVaFBW?=
 =?utf-8?B?TTV4M3R2eWFkMGN6SnRpT2hJdnliL05PNGdUbHh4VWpPL1ZIbkthc2xXakU4?=
 =?utf-8?B?OFJjY2lFcklKa290aG9UZjFYMWd2TVZ0a2dwbXpKL0lUNXAwWnZqUWZ1MVRu?=
 =?utf-8?B?a2xZNERnbTlWOFUyTDZPaWNqZmMxUmpEU1J5Y2lkUkFuaVdrRkluSFhGTFVD?=
 =?utf-8?B?QU5Pc3JUMGhKRmt3aktTdXJzK1NvdXUxZmExNUV3VUxLVHdJYVVvSjUyaERJ?=
 =?utf-8?B?cWxEK09rdysyQ1ZmT29sZk1hdkZHZlJSaXZsa1cvbVhZZ2V1b0tBcG1oQkNM?=
 =?utf-8?B?RXo0MURUUGRHVkp0WENxbGRmdXRqelo2WEtQV1FXZUNoazU1YlZpMWRPcDIy?=
 =?utf-8?B?ZGhLakZvanpnTm9aMVZwRkx5azkzNUN6a0RHS3gzU3dnTnYza054VkdaNXJL?=
 =?utf-8?B?N2UreVFXKzVab3U0bHJaM0w1U254ckpkQVlseHBTdkJYanJsbGFVbWRqTzNR?=
 =?utf-8?B?dU1PRis4UVpXTXhsUGIzb3MvUlAwdUdBVW5LMVlLNUNnMFhSbnhIcjZVYlN1?=
 =?utf-8?B?N0ZrT250b0x1Sy9wTjZWQjJVblRBUHFaZGd3MDB5UFJrQUNUNkR5S0JMNHBZ?=
 =?utf-8?B?L0pRRC9rZVAwejQ2OFkxbU5EV0lGYXhaZjV6TVF3VHdPQ1kreThjM25zb1h3?=
 =?utf-8?Q?8F0VPoBdUiFbzaFWAloDRajiQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4a77ca-3f03-4a53-3dbe-08ddeecda280
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:48:33.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCBCdugpwtHQsaXeXhOiUtd8Tzh/j+lelFwlcKyJ0+8cHnaH104wuCB7022OrLmtpIfvNwtNkdzZg9PSUcCQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036


On 9/4/25 18:48, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> Apologies for the late reply.  Totally lost the reply during the US
> holiday...


No Worries!


> On Thu, 2025-08-28 at 09:02 +0100, Alejandro Lucero Palau wrote:
>> Hi PJ,
>>
>> On 8/27/25 17:48, PJ Waskiewicz wrote:
>>> On Tue, 2025-06-24 at 15:13 +0100, alejandro.lucero-palau@amd.com
>>> wrote:
>>>
>>> Hi Alejandro,
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> v17 changes: (Dan Williams review)
>>>>    - use devm for cxl_dev_state allocation
>>>>    - using current cxl struct for checking capability registers
>>>> found
>>>> by
>>>>      the driver.
>>>>    - simplify dpa initialization without a mailbox not supporting
>>>> pmem
>>>>    - add cxl_acquire_endpoint for protection during initialization
>>>>    - add callback/action to cxl_create_region for a driver
>>>> notified
>>>> about cxl
>>>>      core kernel modules removal.
>>>>    - add sfc function to disable CXL-based PIO buffers if such a
>>>> callback
>>>>      is invoked.
>>>>    - Always manage a Type2 created region as private not allowing
>>>> DAX.
>>>>
>>> I've been following the patches here since your initial RFC.  What
>>> platform are you testing these on out of curiosity?
>>
>> Most of the work was done with qemu. Nowadays, I have several system
>> with CXL support and Type2 BIOS support, so it has been successfully
>> tested there as well.
> I also have a number of systems with Type2 support enabled in the BIOS,
> spread between multiple uarch versions of Intel and AMD (EMR/GNR,
> Genoa/Turin).
>
>>> I've tried pulling the v16 patches into my test environment, and on
>>> CXL
>>> 2.0 hosts that I have access to, the patches did not work when
>>> trying
>>> to hook up a Type 2 device.  Most of it centered around many of the
>>> CXL
>>> host registers you try poking not existing.
>>
>> Can you share the system logs and maybe run it with CXL debugging on?
> What system logs are you referring to?  dmesg?  Also what CXL
> debugging?  Just enabling the dev_dbg() paths for the CXL modules?
>
>>> I do have CXL-capable BIOS
>>> firmware on these hosts, but I'm questioning that either there's
>>> still
>>> missing firmware, or the patches are trying to touch something that
>>> doesn't exist.
>>
>> May I ask which system are you using? ARM/Intel/AMD/surpriseme? lspci
>> -vvv output would also be useful. I did find some issues with how the
>> BIOS we got is doing things, something I will share and work on if
>> that
>> turns out to be a valid case and not a BIOS problem.
> I've been lately testing on an Intel GNR and an AMD Turin.  Let's just
> say we can focus on the CRB's from both of them, so I have BIOS's
> directly from the CPU vendors (there are other OEM vendors in the mix,
> same results, but we'll leave them out for now).
>
> We have our Type2 device that successfully links/trains CXL protocols
> (all of them), and have been working for some time on previous gen's as
> well (SPR/EMR/Genoa).  I can't share the full output of lspci due to
> this being a proprietary device, but link caps show the .mem and other
> protocols fully linked/trained.  I also have the .mem acceleration
> region mapped currently by our drivers directly.


Just for being sure, you are mmaping the CXL range assigned by the BIOS 
to your device. Right?


>
> What I'm running into is very early in the driver bringup when
> migrating to the new API you have presented with the refactors of the
> CXL core.  In my driver's .probe() function (assume this is a pci_dev),
> I have the following beginning flow:
>
> - pci_find_dvsec_capability() (returns the correct field pointer)
> - cxl_dev_state_create(..., CXL_DEVTYPE_DEVMEM, ...) - succeeds
> - cxl_pci_accel_setup_regs() - fails to detect accelerated registers
> - cxl_mem_dpa_init()
> - cxl_dpa_setup() - returns failure


It is hard to follow these calls when using v16. But your next email is, 
I think, more interesting. Anyways, if you can use v17, it could help 
for focusing on a specific version.


>
> This is where the wheels have already flown off.  Note that this is
> with the V16 patches, so I'm not sure if there was something resolved
> between those and the V17 patches.  I'm working right now on geting the
> V17 patches running on my Purico Turin box.  But if there's a specific
> BIOS I would need to target for the Purico CRB, that would be useful
> information to have as well.  My Purico box is running BIOS Revision
> 5.33.
>

No, there is no fix in v17.


About lspci output, as you can not put it all, could you tell what is 
the CXL range assigned to the CXL Root bridge and the range assigned to 
your device in those systems you did try? I'm saying so because I think 
you will run into another problem later on with AMD systems, once you 
hopefully solve the one making the current initialization to fail.


Thanks


>>> I'm working on rebasing to the v17 patches to see if this resolves
>>> what
>>> I'm seeing.  But it's a bit of a lift, so I figured I'd ask what
>>> you're
>>> testing on before burning more time.
>>>
>>> Eventually I'd like to either give a Tested-by or shoot back some
>>> amended patches based on testing.  But I've not been able to get
>>> that
>>> far yet...
>>
>> That would be really good. Let's see if we can figure out what is the
>> problem there.
> Sounds like a plan to me.  Thanks for doing the heavy lifting here on
> these patches.
>
> Cheers,
> -PJ

