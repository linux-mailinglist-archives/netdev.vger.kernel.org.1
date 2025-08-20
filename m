Return-Path: <netdev+bounces-215164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74140B2D4B2
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F91168D0E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807C2D3A6A;
	Wed, 20 Aug 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HYfUj0nn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BB1F4606;
	Wed, 20 Aug 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674247; cv=fail; b=PhGOOFHMDXgqXYgROmKgR/jT8yglVRmMwlZaThLfhmHRa0sLlCC30RtBMnfncdfT9HVEXg6KcCREfsrzUJb8hw86DImQY8TGsccRly5Z8NsWzal/R99baQ+jcbyprdUhlkGwAIoFaWfyaiAjRRrwDVp7nIYTWghoKSptQ45b71U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674247; c=relaxed/simple;
	bh=M0lXAl9U0GlStoKrSlFM88t7p44UDXC7S8vRpYi5XRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnv8MLg2pbMIO+cz/9jug9zpMC2KgLh+sAtGXz6ykZizG+3pfQDSEwpTUcZC3Pumq9vfaKkR8qu14xc1pk8el2+d2QsgZrB5yvP5iHdgFoEfJ4lGy6gd0PH/1pATq4jHK60Gx17DwrEYqPuJRUDf+kl3KLO4O4AiKOo8ipIiWYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HYfUj0nn; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3jOdtnGloLp6cx+l3MqOxSBNPIX0zKel+BAZToBil8UpUbI7RMx1JGVRSxnIROBkO1b8tl/AmA4RpZliuXC6dlhXdf+FYJQeAjWTdnrAO7u6iQUW0hdwT1F/K6rhXSt7m1Idz1dCmOR4O4lLEGMZyCLu+pDA8Uyew2X9E/O19IzFoifL+GtklNgFkAGej6kNaQZvUZigm4euYacHQRPYhw88V/Wgl+3uzj4+xUC9JF2M3M+CyQE95FJQ5Jmpw/XqJWGaz8tW6wQVTJYYkvP2mmNOE7msFPfvK3Pj7GPbYUKvGjChvDAsU+lcDpU8LoFN7VoEaYnIqmt5Fipy1bizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrfKMkE0t7j/fVjLVc8MD8ncBslxN5zMFBgxPWqE8pk=;
 b=YjgBa6T7Vo03b2+0hILBtj1DrBZhRe0H5MKzpxRIyawYNNodPzlu+CJpbPvCcKiEMmzIcxAxCJWsmZoUIEQwSOzpFU9QuiTHRwt5DHtJ1uvWkZnd/y/iWqjDv+qgOGfZ7Dy1J+ZxHycVduXyweyGKtOwIPAmc+nR6Q3apqJ4vEcpH74ICudDbNVtJp73ek8i4WM/2kKSmIKzr8aInjBdFQiPMNOCm1qjiCBcQ5DPUOZ6/j4LVGykRYwHMRrl61hlOrtFCjRvmeylrh3+71T8LtZz+I/dWROJ1uD+xi6tfsJcBjUO+5oqZK916Vri/gXat0FUZ5vfk89/nvF6IWTxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrfKMkE0t7j/fVjLVc8MD8ncBslxN5zMFBgxPWqE8pk=;
 b=HYfUj0nn9oLGaKUhirr/9Tv90MICyFKjhH6noX9TMv/QwDvWklJoYtauMrksVitfqOe1UqmcIBUxKzwEPLUJTgOAhZVpqPiYdv7FcL3ql0qIMMaoNiqZvKAsRV5BthB40CYj2cm/be29UgB3RcRZaEFiiA6vCZQyEqew/IDhyNiud2C0i59sxnhb0K6RFY446wXC0qMpZih3uwqanMGmeVB5WfiQQCAtSU7uTSC8lV0cRZ2s21EaP1djzDvRMbqXUxaNp2bJkSXQ+z6BjwuNEk6wSn6RiKCJQflR+tV2/uI8MLyF7kCvmhfVquAfPZPCIcXORuFJEBY9Zl9i963LqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by CH7PR03MB7906.namprd03.prod.outlook.com (2603:10b6:610:24c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 07:17:22 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:17:22 +0000
Message-ID: <76aaa9f6-04d4-4a8d-bd2e-f53a03dfbde0@altera.com>
Date: Wed, 20 Aug 2025 12:47:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: xgmac: Minor fixes
To: Jakub Kicinski <kuba@kernel.org>,
 Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>, Andrew Lunn <andrew@lunn.ch>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
 <20250819182031.58becfe7@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250819182031.58becfe7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::7) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|CH7PR03MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: ccaff65c-4d80-4b65-b596-08dddfb99b78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGc4VXEyTk51bzNPQ1hBclc1MjVqdUJFb2FpdUlmWHFTV1BhTUtLSUlvTmt0?=
 =?utf-8?B?RkR3K3pLSC8yanovaldzVnZmMzVPeE9BSkwvQjVSMTBFTWd2OFpteGRybW9Y?=
 =?utf-8?B?U3lsUUxDZmxPdDRwZFZOS0JSVklQUnJPZzBYTHpxemtkTCs2WmRSQm5adVo1?=
 =?utf-8?B?RlZyVEZVLzV2WkZLWXRrWXdNMVpaUDgzZmdtRFRCWGtOUlRiWXQzQndBQW1B?=
 =?utf-8?B?Z1RGQm1LeGd3YzY2KzQ5M2puN3JvTVBsenBoNFZIUlpIdEtjV3M5TU11eWlU?=
 =?utf-8?B?SEIxc2FTWVd2bi9NbGZKcWt3WGw1ZGtKUUp0YWFQSHY3MURCNmhiTGx3Zzk3?=
 =?utf-8?B?eVIxclNkZGhDTFpYSG5QbkpmSE1hUWhURExCaXdydzQzdkV0ZENoVVo4TEVS?=
 =?utf-8?B?UzdQNE82OGhHQnM1U3NUbk9wRmprbnBFUzB4bVAzcmE3MHdLaitya0dMUXU0?=
 =?utf-8?B?VWVOY2FWdTJ2SEtJRzdEdTZjZm94bjE5ZFJwb2tTNGc4bUw2RWxML1A4WHpP?=
 =?utf-8?B?aStoREYySU1LOFRSazZ2T0NFSXFIaTBtd2hJTmNKQVZ1bjRQMVZYTGw0MVJG?=
 =?utf-8?B?YitGNVAxdEpZOGRLNC9tL3BEQnRnS3FFK3ZJZHhJSmRjOWxZVnJScVM1Z3g0?=
 =?utf-8?B?dkZqeDdGNDRnaUtVMGxSUHM2dGVmT09Ra0tVNTNkOGxFUjhCaDVDZ0UxU20z?=
 =?utf-8?B?TTRFaXZUME9LTFh3VElub2NlWXRhUmZlSm5SK2creVlySFpXTzllM04yLzc2?=
 =?utf-8?B?SWxpZWU3TFhQVU9SRFdjQ0ViN29Wb3VYZFVUTWxlVTlUbVpxWm1OU1NrbStX?=
 =?utf-8?B?ZnYveXRYZHVpZ21UN0I1Y0FUMVVqc2EvbzBPbGplb3p1cVBLblpmZ2JrZTQ5?=
 =?utf-8?B?MW81TUJNU1dSZkFpZ0M0WnkvZ2R1VHZGNkpUakpCMEZDVFR6aXQ2NmxFaXEy?=
 =?utf-8?B?Z1FnTi9YUzgzS0gvL0VhSUsyK0IxV3QyUncwUXdoczlYWE9zb1BGZWNYOG1P?=
 =?utf-8?B?VHo3WE95Zi9jQVJyUFcwOVdzdHMwRHZmbmxYRm5sSnR5akRncTRqQjJGV0ZV?=
 =?utf-8?B?dnVsOVZUQ1ZGMHY4RUZVZytHSElSa21mYnhVMnhkZXE5M3J5S3RFUy9lVW5R?=
 =?utf-8?B?bGt6VFlBUDVkcGRIdWNOQWVuUVV4RFUyVFJhUEJlUVBpRXBlczhQNldPZmZv?=
 =?utf-8?B?bTFNWEJIS2s1Ti9pa3Y3anRTa0JtMGMyQy9renc1VWI1V0xoQStYNGJ0SUpR?=
 =?utf-8?B?OE04alE0WkRwWnFNVG5JNlMvUEw3WXltQWVzYlpNcDI5N29XZnZsN044d0Rn?=
 =?utf-8?B?SEpLNDBaY3FmMmVxdGZHZ3BkTCtGSjVKQy9vRXY2MTIvcjhTMkhLREFsMm92?=
 =?utf-8?B?WjY4WHd0S24zTDVkdFZSK3FCYWJIK3IwUDJHWlI4WGNLUy9sRjNGUkZrbXlD?=
 =?utf-8?B?VzB3U1RDM2hWWGFOczl2d3hOZFlkcmM4d3hvT0RRWC9KUFFFSkxHSEUwckFY?=
 =?utf-8?B?RmY1cU5NRW8yS0N0a05vNm54bFNmS3FLd29aMklIcHhra0trNmhiMW92azdU?=
 =?utf-8?B?R2tRdFhsMkNqajdTQXlRVnhKQ2VjRElXUzE5OVdBSXZwNHkrU3NnN3FXOWlh?=
 =?utf-8?B?Q3dwYWl3cFRSTEJCUmZLTyt1WmREZkF1dlVhdkZ2dDRsbUFQcXBqRDJWNVdt?=
 =?utf-8?B?K21ZdEthSVpkMStMd3BobzVHSmhsRmdSdG9lejhjRXdKb3Z2MFREUGtTUGZG?=
 =?utf-8?B?bW9sY3IyWlZKbEwxVG9scDRvRnQyWU8zNXFaQ0VUYXRZdjEvK1BtMWJ0RXU2?=
 =?utf-8?B?ekFMc0s1UEtnelJ0MjVZUkVmQUppeTNRNU5tcVZ2eEVIQjVvTHlNR0I3RXV4?=
 =?utf-8?B?QjJkdzVxTTFza25WYzZwTUJybUZ4STV2T3RaTmpSRUQvbjdEM1Fubjh0eGdZ?=
 =?utf-8?Q?m8gY0dYNuJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGY5c2p1YWRUSmZQN0NQckk0c0VqeUhqM25majJBNnVnNzBwWmhVa01zWWV5?=
 =?utf-8?B?UTN1NE9Uc3BuYjU1eUUxek9vbXNJc0c4eXFVM29pYk9JRXFxanBvbW1UcWdi?=
 =?utf-8?B?N3Q3eEdoUkk0Tk82SmIzd0dBajZ5SGdZcjhWZFMyaXdTYUFsbkxCYWdZbmto?=
 =?utf-8?B?STc2WWR2aSs0OTQzMXVCYktmVmU0WGRHblR0YW9EdDQ5THJKRGJBS2FTamVR?=
 =?utf-8?B?WmNXZ3B2RG5KQVlzZ1hrYnVOTVlvMVR2NGFrNVRLMFdCYVhLelhydVdIYm1Q?=
 =?utf-8?B?bXR2cTBQcHRLR08xcnB1bjdpRVRyV1M2ZFphZk1CRGZoYVRuQklYRzlkS29N?=
 =?utf-8?B?c1RpR01maTlmbExZb0lZWEhubWtGaHVtTUtSanRzWHhHUmVnTTRCazZBRDk2?=
 =?utf-8?B?ZVIweFUrZFhQQ0N1Yk9ONm84a1NaeGVvRks1VzhKcVFjOFdxTDlxNkN0djRI?=
 =?utf-8?B?UmxOSndielptckhBbGNoa0IxakRUb2Q2WlQ2SDYvcUVjNnVpcWFKY3ZzUG8w?=
 =?utf-8?B?VDNRTHBWd3Yxc3JsMXFlWWpjekZHVzZVV1pTTnVjaDlxejRBMENNTVVxZExP?=
 =?utf-8?B?citkbWhFU3lqRWd6c3NlUlZqejdmTXZhZTdIMElpZkNKaW9KL2tiY05CWFJO?=
 =?utf-8?B?REdYRTExRytCZjVOKzkxSDBKMExiMjdySzUwWlp4SnhmVGtHbUozZ2dCb3RO?=
 =?utf-8?B?MlpWVzVqUGh1YjRwM3Q5VkR3MVJobDlXdFVIbHRvQnRvL3JzTExBTzQrdzFK?=
 =?utf-8?B?N01XZ1kwZGFhb1c1ak9FcW5jNzhZekVMcDZkSTZZL2ZibFVXSERDZ0w0OFFK?=
 =?utf-8?B?aFBjeGJqZkw5cUQzNlo3S2RrUUdTY3pRZ0NBWGZFbndWdmdoYTkySmFLcEJm?=
 =?utf-8?B?RlN2V3NGS0c1SHZFMWNiaEJwVWZodEpXVGtGbWx6c0ZHeEN1dGZDdFpTS09R?=
 =?utf-8?B?YTI2anFXeXYrQWs5cHYwN0dsQVdRWnJUREk4eDd3Z3JQOExPQ1FpNmN6cnR1?=
 =?utf-8?B?Sm5JYkVFbmtidW5oa3RiMjZZSFQ5NXk3YzhnM0hzbHVLRU5wdDhrb081aTV3?=
 =?utf-8?B?V0J6MC9qeWhjVVUyRWJyN3ZCZWNPY1pVZWFJZ1BvbjVuR09XVVNSaUF4cHY2?=
 =?utf-8?B?UENrKzhpM0s0ait0emtoT0hYRXVhWit4VHFjc1VvRjdxSXRhYlRnb1BJYlBN?=
 =?utf-8?B?dTd6elFZS3liNXErVSs3bitudmdXR252YTZJTCthYWJGZFNFUktFSzhldUdY?=
 =?utf-8?B?WDNkNFBnd1NSOVk2ZXlnT1JUVVlPOXRqY3FZeS9WUEVIQWtzdkNzbXpTZzRM?=
 =?utf-8?B?ZFNwN2drRVBxVmJQL0VTMTBXczlWS29neVU2cHRGSFdZYngyMFQ5WXZwNjFJ?=
 =?utf-8?B?bDFTVUlXTEk0REZMbjdDckdPdDRmVEYrK0lUR3VYL0kvQnZYK0xKOTFjYWJw?=
 =?utf-8?B?a1pnZ0lFMkhZTERWOE1VaDdJQmdzVVdjS1IwSG1iU1lUM2ZNWjR3V3FpZGIr?=
 =?utf-8?B?NFVvQWJjejJEZTF3Z3NrTmMvLzEzczd1QnRUUGg2SXl2cUllMGVmY3lIK2xL?=
 =?utf-8?B?WmJkc1hsMTBPM3hFNmRtN3lvZEMzcmRoMnhzNjBZNHV1REI0VkpBK1QrZlpH?=
 =?utf-8?B?Z00wL1JEVXlSZFQxQnNBM0lBKzhzc2xSSkxNU1ozV2k4Z3RORUp2VlpkdHVY?=
 =?utf-8?B?SjlaL29NRkkzZzloQUxTelNLeGNmUEhiL0FzK2QwWDJDSFl3SjRWMldSTlFT?=
 =?utf-8?B?SGNvUGxpTlAxMC95aWFsMmZEUEZTRmUycXhRYXV5dkhBVExDbEYzdFV5RzBn?=
 =?utf-8?B?R3lsMVFCVWRhV2RzNk5aOVZiSGNLMnFNUVgzb2c4YkhRREdOeWRpZHduUVBD?=
 =?utf-8?B?ZzdIMVA4RTd3eEZzMU1xekNaM1ZxeDRhdFdxYWZ5VEw4cVV5NzliUnAyVk51?=
 =?utf-8?B?SVBkbnJ3MTAwUHo3ZFJLQTJOQnI3SStKdUZ0MExCRXBxRGxuVXluMWNMek91?=
 =?utf-8?B?ZGlCQVhNekFNbU13UGVWeC95ck9Ya3hnS2Y2bVlYUm9OYXdzRCtpSDk1OUxt?=
 =?utf-8?B?c3F5aUhCcVRaK1hxZmxTbFJFckdWVkVPSFc2NzNJTXBQTDRUT3BBMGVzcDlz?=
 =?utf-8?B?Si9SWmIxNUNwWk5kbFpNZVdzVHlHbWZFd2c3cytCVnRlbGxNMDh4WWFLOTZK?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaff65c-4d80-4b65-b596-08dddfb99b78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:17:22.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY5brksGf/l07gkvuKWVtMSOwh6bruXzdJGhnDZdJo3/NmhjJ6lwwPgWXGV8R+dNag9M7uNWkXNCalc9GU/eWuUko4YZ0YTOvJSZYEUHDKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7906

Hi Jakub,

On 8/20/2025 6:50 AM, Jakub Kicinski wrote:
>   when you repost please use [PATCH net] rather than
> net-next as these will go to the net tree, and 6.17-rc3. Rather
> than net-next and therefore 6.18.

Sure, will take care of it in the next version.

Best Regards,
Rohan

