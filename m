Return-Path: <netdev+bounces-202502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D54AEE18E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D43F3A77CB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E728C2B2;
	Mon, 30 Jun 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iXBdD/Mw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17825C833;
	Mon, 30 Jun 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295353; cv=fail; b=iV7FOvZDE+TgMjJ11lJZZ84hg9MAKaAzeQ6usjeBB9X+ikg9rpQNQe6Uz76XSxd7+H+ioeBrgnudNkUwVnKptjyXGH5mqjfsvQqcKS8hmTyL4Jkm5ZjkZmpGnaLAXqZPLVwvAuxWgIGoqhzu9mYkdls/ff68fzO5elsYRzH0aTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295353; c=relaxed/simple;
	bh=lV1Engj2mStkis0EfUu8lKcvvTSQA2tAgTSBfFnrras=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYoVKAiOS8ozLv9lwbqQVz01wwLc/4aW2IGOAt/uqoigccHBiXF/c5EMj2NcusuSjWm3UgstsvMyaAlOR6EVbVP33pnx3NHwFPQBnJ6VW0NxLbWkw0jpKWiC+qKVD/ouoBH8Emb9o/hIWWEegEiv3TVrByXYZPJqellGkoQr0QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iXBdD/Mw; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiZqLZ+71xigcoXKBEx9eLDksRXxfrB9vaRr18mHmqm4OCckmNgb78ebnZTxjeDy+Yn1JApLi+ZsiW0T4LhPOemOS0S0KbSZw1NFTHpQOejR5a2byHTSK4eIGcqYR95k2tuqhR+skTIBcy+UKGq5ABX91qDWIfg1Rcft12x9KzY8T7nxtsncuI15tS/A3/IGKQyDmqaFU6fd4WEwIHPQ8+ARKmTuPcIawERgACrvySthD5z6IjHdmjhgV6e3rXN3riLF3jm5R5ZInIU2Ve6Luucpywx0QI/2S2YiUQndW/z9FUHcs7dK1Ee7NuTPJLsQU8tFO3X6X7fXucVNFsarxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j1wR/S/gRgCdNqckNzpOEfcP0wzKlwkjNgTpRvZafU=;
 b=oQ+ChFTyj+4pUE7j7jxmOEFa+ewZcd0a1PSpuyKLtSMpxz0f9FyVQvdH3Ou0S/TdLp2XcZGXuoXv9ugHxRWO5cb/YzV0LZS30OM2WHl68w3slDDsWvZTOUuUS5gl4QpRty25tdvMwZ0W/6WdxsfRZ+t7+xEGOUyRJVdfUu85Uuj96gyraRxFK+999Tanm/AO4062WBwNnd+8E8+XoAXZoy9GrT/hfa5pze22w/Bt0VTEoUhA0e1LXNBamqWiQrVdbkkRtYjLPD7LC53MFVBzsNahfjPEXJP/7xCOdKdv9GNFQRcj/jG5iHVaa7pyS9qC++HoV4zrn3R/q0P5a3qZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j1wR/S/gRgCdNqckNzpOEfcP0wzKlwkjNgTpRvZafU=;
 b=iXBdD/MwWf3xT7sZRJwbM4/YnaQ+t9hSIC3SxEzUKkazRIjq0W68EYykq5xYewzh13PkTjnE/KK1SC11iDUf2YAeiSkP43NNGFWEcVMnZF0vo2um49TItwYBXLGz5jAWBKi3qHMK36l+XU9OsVZgSrVs8SWjX/Bhp0dyCqAv/J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 14:55:43 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476%3]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 14:55:43 +0000
Message-ID: <f56886cd-ca42-459a-87d7-eb3f472e88b4@amd.com>
Date: Mon, 30 Jun 2025 15:55:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/22] sfc: add cxl support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
 <20250625173750.00001da4@huawei.com>
 <1a6ba55b-3077-4db2-a6cf-c7dc96619c94@amd.com>
In-Reply-To: <1a6ba55b-3077-4db2-a6cf-c7dc96619c94@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fe3640-dd0c-48b6-861b-08ddb7e62fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWZjV0EyMXRuaTVtbXFCcFUvWlE4blFtT0hlSVdtcC93SE5HZWNaUEYrVTJq?=
 =?utf-8?B?UGVBRkIwNldOdHNnRkhWNVNmejdYV2xTTUY4c0lDWktXYXJCTjJVcXJjRzg4?=
 =?utf-8?B?aUpEK1Rqcmx1d1lVdE1yNURLMXQrcUhKR1pyL0FLbHRIVlRocTEwQy9qMDFp?=
 =?utf-8?B?Uy9GYm5HcVZMYTlBOXR4ajdpZlo0dzdBaVgyWmIvUFVOWDBXMFJyS0FNMnZX?=
 =?utf-8?B?SzYranl5OHhndStWTjIwYlcvZ3lQYkhrTUFuVHNxdVVPV2ZXRWZtbFJaVlIy?=
 =?utf-8?B?Mjh1STh0bHBPRTRLeW55T1FtT0lIRW9wbDNuU1l6YVdQbjRHSDVhVDN5aFFj?=
 =?utf-8?B?SUV0czB3T3NhVnpCa2NwbEJFWFFSbUZHRCt6U0ZOV3FPVXBsaGt0eHdpU21K?=
 =?utf-8?B?R3NuaWQ4c0tSTm9NZ0lTNzB3a1JTRFEzbVhmU0lPZ2lDSGdnbUg0SmVrbXNr?=
 =?utf-8?B?ZkVwZ2Noa2lvclpEdE9FaW5KSDhpemNiWTN3c0NuaEMxcGJETkgzZHpWTDJ2?=
 =?utf-8?B?dGsrR1E4aWh6bXNDbGxPWjBwRGhFN1lISVVIUmpQUGFGMG9MWmc0cmhzeVZx?=
 =?utf-8?B?bGxuK1NYdHFDeUlFSTFNVFIxVkVHSVI5ZGNJdm1HcVBNSEJMRENKTnFHOVlE?=
 =?utf-8?B?TmJNTnlLenVKUThuVXhKaHpISE1kNVFwRVdvV2VCVm9kc0EzbWQrSmUxZ0hC?=
 =?utf-8?B?ZWp5K25BSXk0eVdSd1FKWFNqcU1oOVdnWXVOc0h0cnAxZ2NxUXpyZldMYWJz?=
 =?utf-8?B?Y3JrcUFBWFBGcWFsaGFlYnQxK3djK0RXVmNKbDhJUm9sNk9Wb2RWcTdEK1VT?=
 =?utf-8?B?Y1A4RnlsLzZwYVFrcHRaZW9ETmMySHE3b2Y5Q2YvcnVTYUtMNk1TekJ2L0FI?=
 =?utf-8?B?cDNqelZSUVZtTWpsZW5YTDVrRHB2TVB6QTh5K0hZN01vMVBBc0M3WlAvdzEv?=
 =?utf-8?B?N1RpT2d6OEtCK2RiRUFMQTBjS3N1VDBlNzY4bmtmSUVNeHY0TnZVeVQvZU1j?=
 =?utf-8?B?ZFhVaHpOaU9xVEZsZkV5M1hxZG04b2FwQm5YdThUaVByNys2cUtIdGtBeStD?=
 =?utf-8?B?OVoxOHJubkNPOE1iS2VSTkp1SjMxYVRGUzI1QVNvVU5ETlRVdElJZ0c3WmlT?=
 =?utf-8?B?aHB5ZHRaaGVBajZsUEVjT0IyQWxoWnZPcGpCTFZJTi9iNFRZb0dSdmlkSzJZ?=
 =?utf-8?B?V2NlaHdQSkNiR3prRHFpckZQSHRpUG5yNDV4U3kzMkJRcUdZNjhXK3NrWTcv?=
 =?utf-8?B?K2pLR01hT3ZUeU5sRTBCbkZQZ2xaYjdaMXVOaUZuWEhDMkV0dXJQSXVnN2hq?=
 =?utf-8?B?YzdYZ3hBWWxrY083UktmZWYxcHFzdmdYQ1RSTDdPdXFqeHZtZW1tVDVtaHNv?=
 =?utf-8?B?UVM4dTBuMVAxeERKYXdrckE0MHhlVllQMldVd1pjTUoyM2llT2Y0MUdaNHJm?=
 =?utf-8?B?NUxLV1ZLelJrUXRGRWh0czZ4WmZ1QmM2RFlENUdXelltWVA2djJqaGJwRStP?=
 =?utf-8?B?cWJkQU5jNmwwbEgwYXVROXBQbndTcnlKUHRENVJ0NW5saTlydndDay9VdmlK?=
 =?utf-8?B?SWtRWGxnRXFHZlBmWUFIV1ljNnRHT3BwV3UvN001M2QzUjJMeTJRTklObEdG?=
 =?utf-8?B?SCtFTHBjK1BrdjdzVGNBR0NLdDlDa081aUw4MXRxTGZ0bWJFNWxWNERmdnhy?=
 =?utf-8?B?Qm9KU3l4UnVBZDdXNkdnSktCVGlqWUpQV1VGVE8wcWNic2ZqY0RmSFR1R0xh?=
 =?utf-8?B?cTNFRkJHWWUzWXF6TFVzVDBaaGpIQ0t5RFdwZXl4VjJiZitCbThxQnlJRk5S?=
 =?utf-8?B?N2hpQkIvbkIrWlAvK2EyQTJ0alZjRzE3bzJzKzVuOGxNUEFXdUJHYi9oUzhp?=
 =?utf-8?B?cDhaVWhiWFRscGRhSlNua2phWks5R2trOVpnSHJ4c0RpN0toSnFnKzRQY1Uw?=
 =?utf-8?Q?nbMwFtW/WpI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDUvU0NSRHhBL3dFditHNXk0T0Y1WFREMSsydjRBOXFrSzQ2N0pNVWpxOG5W?=
 =?utf-8?B?SmdCSjQzbjhPZ1Znd25Od2ZnN3ZqdWhBNUtKRzFYYVZ4UlB4WkZ1TnhTVmJz?=
 =?utf-8?B?UU9wbEIzazNyZFZOK3BuWCtWZEdUeExPVzg0TmNJdGxyT0JJaHE4N2kyekJ3?=
 =?utf-8?B?WHhRUUhsdnVKdng0RU9Cd3N2a0VTTzlPdGs2ckNvM3E2TlNaaGRmZE9EUHlG?=
 =?utf-8?B?cndCTURkNkxXdnRXbzBxQ1B6bWhJeDRUOEpxQVZqWWhQNlBjUVNsNXAyYjBs?=
 =?utf-8?B?amlCdWJIYUxtUlVjSlhpOHlhTzh0WFduVWxuTWh2ZHpPcnF3QkNwd0VUZDBt?=
 =?utf-8?B?S0loU2ZrOE84SGVHU05pWWFvQms5ZGNTeFRvc0ZENlhNOTN3WmxyenQ1bUZT?=
 =?utf-8?B?NkpFMWRXQjB2U3V0STRaekcwQnBtZ0lNbVV4V0xndFM5cUF6WEFuU3JnVzcv?=
 =?utf-8?B?T1lKU1pNQnMzblZUcUxCUkhkTnJqZ1JTcGNDZjZFUWhseFhJcDZxdEZrbmJy?=
 =?utf-8?B?Z285bDNDN3cydkNsTkVvVDMvVDJDTHN0Q1hlelp3OVhDVmxDc3F0SU1FS0xK?=
 =?utf-8?B?VVREZm5SK0N5VDBvUzJ1TVdIaldRRDJRU3Z4VTEzbkh0ajhTQ3pTWHRleTNa?=
 =?utf-8?B?NUp0UE5qK0E3ZHVqWE1PRTdabndjKzNWdVQ5VFBzcTMvc2xuZ2Zzanh4eFBk?=
 =?utf-8?B?TkNtbENLWENXS0JsVGNsL2xNOUhGUEhkVzJNbzIxWDhOd2Yrc25oaTBIZmh6?=
 =?utf-8?B?Wm5Tdkk2TDJPa0p2ejhRbHArUkFEYjBhcGpSYzZ5RWcxQ3ZYNlFBRWVDdWN5?=
 =?utf-8?B?ZWVBVjdhYkVyNU96UHlVWUZWT3YyMkRyTmczaytPUHc5bU93WEhYRFAwUTI5?=
 =?utf-8?B?SGwzZWxBUEhtMDlsT1hYYkZuV3pEYlhHMHdPWWdsOFlVbEN5cGNCL3hQZStD?=
 =?utf-8?B?eEUrbjlWbXRYK1B4bmMrbEZWVnROWlRJY1dTc2xvRGZFWnZnNVJ1dmNoUTla?=
 =?utf-8?B?NHlVZEVNOTRUc2cxdEhqMkJ6N2U3ZTFuai9wTHc0VHNMUkZNTnNRU29lTlJp?=
 =?utf-8?B?eEJvUEtHbkVmdXY0bUtxSTJLZ1NvSm5IdElCVXhQampOcGhlQm5XdnpSVklM?=
 =?utf-8?B?VzNNaXNXd0htNlA2aGZtMEw1eWp5OU1YYnZXeDZCVlRYUWxsWXA3eVNDRUN3?=
 =?utf-8?B?YXJSdlYyS1B5akpxOEVnVWNxWkF2L2NQd0lJZi9tUnA0Q0Q0OG1rQkdJemZz?=
 =?utf-8?B?NVRaM2FDa0VGQzZiU3VOc0ZoM2twK1lwN3AwRzczd2pZb1JpZzIrQlB4RnRp?=
 =?utf-8?B?NVJHa0JKYUw5S1F6UFdWa2lpMjIrRnhDclVUb3NTZUV4MnR2SE1ldUt4Rllx?=
 =?utf-8?B?NlhhRDNreTlEMVgvSDduR2ZRWWpUUUI4RjZydFhRVURMampuZzF5Z1ViQUt6?=
 =?utf-8?B?b2RVamllUmFJMVVNTkJJVkVoMGRLNFZXTSsrYkVPSk84WnRJL1NWZ1dnU1FQ?=
 =?utf-8?B?WGpqRDBKYUp4T0lHeUVwKzdWd0QvbEduSndXWDZ6RHo5a28zWVlxRk95eS9i?=
 =?utf-8?B?b2N0NitUOTF0bDJEcm1lUDE5UU1UQWRBM2RNdkZhenc2WmlTQ1RWcjRVeXpI?=
 =?utf-8?B?UlB4RlFyZHdGcVlkRXFmTFVpUFhsRnRFdkFXeFV1YTBqd0RtV3loR3pvTC9u?=
 =?utf-8?B?eDlHTFgvdjFobU9Xa1JSanpqOWNSYnhSVTU5dENHQTNUUUpOWHplOVFEZEhS?=
 =?utf-8?B?b25DYURsa28vczJPYlRpMlVlS2JRWkhHbkdaZDcwQ0FWSDdmTFU2SzNlUFU4?=
 =?utf-8?B?enkyZGFWVHZJMUxmdzVqbzBIcllvNE1zYjkyK1dTd01TY2pJVlliUzRLSVEw?=
 =?utf-8?B?MGY2KzM5MnRZNkpQYkd2RGZYRzhEN2k5eVlWUGxHN3J1a2g4WTNQcjQvQmhq?=
 =?utf-8?B?bzI1S0lOZGdUQmwwY0dBc2gvMzAyeU56Z215b0Z0NDBMNHdyV1R1U2tXNjJV?=
 =?utf-8?B?ZU13dE8ya29EQjFFYjh3L3YyaVZDZkQ2UGd2OUpBUW8zSEdLR1lRTmt6NEdH?=
 =?utf-8?B?ZlBtUk1MQjlaNjNGcTJ0RXFsV1ZNSXNvODJMWW0zWGdacUdBN3lBZlNLRlZt?=
 =?utf-8?Q?QaxP787u8gh1UmmjTTFbqBJ7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fe3640-dd0c-48b6-861b-08ddb7e62fe3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:55:43.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGCPBQNfuUHMdsZFA5TmS8ok9KjDfVaKO5NmwWGddgvf6sSqN6F89e2cHOc6zZmMPMsqG9K5pIr2rUYk1sSCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398


On 6/30/25 15:52, Alejandro Lucero Palau wrote:
>
> On 6/25/25 17:37, Jonathan Cameron wrote:
>> On Tue, 24 Jun 2025 15:13:35 +0100
>> <alejandro.lucero-palau@amd.com> wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Add CXL initialization based on new CXL API for accel drivers and make
>>> it dependent on kernel CXL configuration.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Hi Alejandro,
>>
>> I think I'm missing something with respect to the relative life times.
>> Throwing one devm_ call into the middle of a probe is normally a recipe
>> for at least hard to read code, if not actual bugs.  It should be done
>> with care and accompanied by at least a comment.
>
>
> Hi Jonathan,
>
>
> I agree devm_* being harder in general and prone to some subtle 
> problems, but I can not see an issue here apart from the objects kept 
> until device unbinding. But I think adding some comment can help.
>
>
> <snip>
>
>> +
>> +    dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +                      CXL_DVSEC_PCIE_DEVICE);
>> +    if (!dvsec)
>> +        return 0;
>> +
>> +    pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +    /* Create a cxl_dev_state embedded in the cxl struct using cxl 
>> core api
>> +     * specifying no mbox available.
>> +     */
>> +    cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
>> +                    pci_dev->dev.id, dvsec, struct efx_cxl,
>> +                    cxlds, false);
>> The life time of this will outlast everything else in the efx driver.
>> Is that definitely safe to do?  Mostly from a reviewability and 
>> difficulty
>> of reasoning we avoid such late releasing of resources.
>>
>> Perhaps add to the comment before this call what you are doing to 
>> ensure that
>> it is fine to release this after everything in efx_pci_remove()
>>
>> Or wrap it up in a devres group and release that group in 
>> efx_cxl_exit().
>>
>> See devres_open_group(), devres_release_group()
>>
>>
>
> As I said above, I can not see a problem here, but maybe to explicitly 
> managed those resources with a devres group makes it simpler, so I 
> think it is a good advice to follow.
>
>
> Thanks!
>
>

FWIW, I just want to add that although I agree with this, it is somehow 
counterintuitive to me as the goal of devm is to avoid to care about 
when to release those allocations.


