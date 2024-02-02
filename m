Return-Path: <netdev+bounces-68296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E028466F7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745B11C25155
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89158DDCE;
	Fri,  2 Feb 2024 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6EKDLy9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59BE573
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848014; cv=fail; b=M2gr6amecM3sGHrYf2/hQKir2qY8FsenRQaDzOtIVBnVoNbCzQUGXH4saOKMYOOZ3y9ayAheHPTKhZtoiKqNUWdypSRx8RPh5S3rASLroB81a0DUzt65vt+1F+PxXs8QfWwsxK8IhhSF7aow4skaQh0gi5VlytOPVgNS8WxOGeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848014; c=relaxed/simple;
	bh=FPkb5px8KmX36sj1QVeXGnslPlAMky1etKzAPuipWPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oP/BZAAZxGSYVjCC/PHw7rs6VIWZCge74ReOZNNU5H7SwsCnnt5iMvAX+yvc2M11pyRBJCUoT8vO2w8j7QhwtxsyF1M1iB+C41TIRXv/CyYkqdEsJZFkx9Xqh3AltVv/Y3HTyERYa8MKrWc7B89QJfyCBdnhAdy4IgIH2SfTzbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6EKDLy9; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8IEYh2vgkv70ru8a8sw4DVMtBqMw4A8faYetjW45LI8uiuQIavxWBJw8QJ01Vs+bglKqBYQAEscbaopykyn9eMZs7p3WjN2n2P5GaJZCSdZyo1z/L4PmwAADKFUvYKHr08m6XfMJaZwXGeiLQ4NDT1Qd3QIlhnRbzqhgQ1lguRpterHR7CeVbC9CjUVDWYXc5kbsUvxhIWkOgmKmhNTEyU6P1gd0rZ4pWp3Ph2Jm9Z5TqH/JA+2CUw6Q8JFXf+GPtLzglXxissUnv41Viy4K2hDySUrPGFXgqvvnBsrOWfhN1nZMarb2JLuCOpYNbbFoQIWY8Pck4LoOQUjmnLO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O33WFq6ulyELp3l2UdtX8sPxwrHxz+I8+YK42M/zvG8=;
 b=IoPjzpmgud6NXhazfHmNX1PBObEzL4ze4+/HvWKAaOgihGSp4A2Wl8XE4ovglZeO1sOfS+IfyGmf+fHW8qy+wyZKkLRVRapmP7Lwfr0ssniCicx7cgGZXIAiRDq+Z7FeRyqLAZXaZCrQknCJdwfdLGYs0Ugvd8d/Z1ttWP2brvQ6VvQ9vSQ428t0gbT3gn+tQRTVVbMu9NZfL7Ooin1rWT6RlXCEr4AG4ksvM2w9fWCNFBXHZzv3lgY/4CgiUfpxm5ZeOWMpwiqwwp7F9aEwwDyGcD04NdNBXo6I+869oCxQ26MuwT6FH/2h5IyaWE/aEXE4MG8CqpltwKX+CKYgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O33WFq6ulyELp3l2UdtX8sPxwrHxz+I8+YK42M/zvG8=;
 b=Q6EKDLy9kfr/itqMfjlkvZl1X8pzwD0fvvcDzzSIqA/wkU0zpq95d1i1tFg1fflin9J2Xv8hHHp2NssOCqRWX8t6Z1beb2aVLZcDmsESqnHwLtfR3DVrrOw1SyJelBZxoG2+w2K6kfx7uS646dCQJFX6ltz3tkUL50JJR9tuYghePHBNYt/nBSm9HXvcXdK/c02QRIcgn21xxiFP5jpcX78ykEMQictLbzNCpwYmq+F2vW3wVWlV1oS3VMd5xJmDX6T8OUxncHccv4jKDH5DwkDKkEHLNatZimbxoE5xMr9Se9DgmibuQ1hjHQmJm7TZG8qWdF6vW6haMxfSyYw9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Fri, 2 Feb
 2024 04:26:47 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 04:26:47 +0000
Message-ID: <49c079e3-1752-49fb-8f76-016b21a8dee0@nvidia.com>
Date: Thu, 1 Feb 2024 20:26:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
 jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 ecree.xilinx@gmail.com, Yossi Kuperman <yossiku@nvidia.com>,
 William Tu <u9012063@gmail.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <39dbf7f6-76e0-4319-97d8-24b54e788435@nvidia.com>
 <20240201193050.3b19111b@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240201193050.3b19111b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0368.namprd04.prod.outlook.com
 (2603:10b6:303:81::13) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 048744b2-6b9c-48a5-5ec2-08dc23a72b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/cfOqh7lAq8zVzYPpSKyPmeRYxKkA0IiU4TAh/Ef689g4m8BZo64P1txjFi/bdDm5FPczeW+tMbldcA4HC9ntGFw0c1+xfWZ+WuXBPSDyYyZ4dGKggI7wFhZASMZbn1SzgfnnNvtDaatyCk6u2lVimf7UmYrdfZwne9kzbzikAbQpnqQl1Cro95k+BpWYFw7CN275ZNvxAwiajh49NtGdG+mwiDdyDZF8GpCxwsSKjq+p1pt021DYIO2R8RJIw4Wa0baeTKY/YjkegDeRjXksCRu8SjORk1RgPIbDDnef9t8XmHN0aAOrxzxYMl5grtbwdyAK131JC2Vc+N3P67WwUiy3RpXN8McacP5kQK+7xCwupGzjO9FWvMDlhdA+C2Fhcv0snmUNwTvEuoSI7Q6JEIGGQbZkLVtwhzJpV+bjtYl0wJG41w9mzH3ejbAF2gAXN1sV1P24an6WT7yu+oKtWpCQ4iUSrKE/P3PLy6hUg+NkNlzJc4dvqFE9bCiJPrApq/nh7he291s6dW32JN33gXlWshJP4sKgDV2Q84hHipJqteDnxIp05SR4SaiVRLYEouXBaUl8JQ89Wl+zmE4DnyUSq8glauPuRLAn73o6E1TRUCCTEFtI/gHEwG7/yabXezE0QwP0lDi+01We3z4yye6ViIzRxdKJdecynljmp0E5B4ZdGwpjHA/ks+tgXFn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6486002)(6512007)(478600001)(86362001)(31696002)(53546011)(36756003)(41300700001)(26005)(2616005)(83380400001)(5660300002)(6916009)(4326008)(66556008)(2906002)(54906003)(66476007)(316002)(6666004)(6506007)(38100700002)(8936002)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW1MQk1KRUJUWHpMQ3cxN1dOZjhqZWs1ajBIVU43SG4vTkJzblg4dVIxRnIy?=
 =?utf-8?B?MzdGdytYWTNDWnNORWorWHR4bHBOUEw0OHFpMWZNMllWMk1FNVZtdDdEUnRP?=
 =?utf-8?B?MHc1dHhhdnBYMUJMZG9xZUluUzg5QnZRd0lpMmtzNGFNWUg1Q2krNHZjc1Z6?=
 =?utf-8?B?Mmo4aXd3VFRndHQ3dmRveW1Va25DWjZERGVGSzRPNi95YXZWRm1xbjlrSktU?=
 =?utf-8?B?dmt2K0VpZUk5V00rNkc2UHR5YTQxaXRmTVgrM3lSaFMwUU1PSW8xLzczWVox?=
 =?utf-8?B?ZDQvQmJXaVVNWkxFNDRPblpINGpjOW51QkpRZ1RaemF4OWVuelU0WDFORFVo?=
 =?utf-8?B?VXJXbkoyQklYQmVYSVRnTloxWENpeThkL1NkdmdkQmZLcy9nT2N0SjJlOHpF?=
 =?utf-8?B?MXhKczArb2FTa01KakRITkZiTjdwQm9XRG1PdGJRQU5sTVpiWDJPakxFOEw4?=
 =?utf-8?B?R042UUF1K0JFQ1hHdHdMR3ZueGoxTFdBZE5udEZOMmVSWGdzS2phZEFPdzVx?=
 =?utf-8?B?eVZERExUNW5QM0FYNnlZVmJsV05jdXVJcUtIVi9pSUFtTUE2bXdZazdCd0I4?=
 =?utf-8?B?c1o3SDhjVk5KMmQvcUVFYjk2dzBia2JLcERtUjJxa0FRbVVJanN5NUZLckR0?=
 =?utf-8?B?aDd5NExsUW05YnJmM2dITEY4cTJMK2FmckpEUnBqWnVSUlE5MUJ0RFpQcHBz?=
 =?utf-8?B?aTIrdng2bnN2SmRSWldzS3FHWGZOLzNlVVhGWUZ4ZDl6R3ZLOFNCdHFhTDZz?=
 =?utf-8?B?eU1Ba0t1VFJaeDZCNENzR2VjSnJOVGhTcTUveXJxbVpSS1VXZEx2R1Z3MGsy?=
 =?utf-8?B?MTVPNEw2bmlLYm9NMng1WXE2djN0Y09QSDdxbFBSZmlnNnlhdFlxd1RiaUp5?=
 =?utf-8?B?ajBjUkljR0dZUGJuc3N5OUJLcVc4K3dYMnVHd013aGRiK052RnQ3RDdSU1ZP?=
 =?utf-8?B?SzhVQVpRcTdQMUNYRnNIWFd5U0ZkN0pLbkkwZ0lFRVpBQ1pSdklteTd2dzhv?=
 =?utf-8?B?NVE5TzVoaUhBSkdERFJoTHgzUmxXQTVORVYvSDN0QkRudzAyck9iVUZuaFM2?=
 =?utf-8?B?KzB3citiYktJdUV3T3JYOVdiNWY5eU9WWjZraWhSY0xsZ2YvYUpKRVRBVHlT?=
 =?utf-8?B?akVJUC9kbVdxVjZzcTdzWHg2RWpBdHRyeCtqY3RYMGRsZFY4WUdkbDE4T1Ix?=
 =?utf-8?B?Rm5JQnVNTW12ZjlXUzFISFIzWUtYMFE4bjJscDBkQVlpdTNKS08wSTNZVUdX?=
 =?utf-8?B?WnJITE03RUJaWmNOTndISmxhYjBzdTNtc2VZUlRoZXEzNGlzd3FrWjJYZGN3?=
 =?utf-8?B?QUlqNEQ2a2RBRXZvUW1HaFN0UEZrMnhkTjBYTUNWRkw5T085RnRwUFZLRzl3?=
 =?utf-8?B?Z3VkOFF0TFc5LzRka28wV3l0QnJaYVZDazhDQm5HR0ZFMlNxdFV3OXpEVFVz?=
 =?utf-8?B?NW5JV1VWamRHOG4wMmhPWC9md3N5Sk5IbjdLQjZLUzZSdFZWeFI1MEhqUnhH?=
 =?utf-8?B?dWNQTG90MFBScTJ5YUdCakJOR3RkVmZHUlFtNjlNUURmYnp5S29tb21KdG9a?=
 =?utf-8?B?RXE1N1lmZTNnZTVicjZBQmpyQ2ZRcmJUUEg1dzVFUHhWZTUwQWdTbS9FVmZE?=
 =?utf-8?B?VXNuUXloSUxBUGVZalJBSTBrWERvYXZyMUZYMURXc2dlNVJsaGRWNERnYnoz?=
 =?utf-8?B?ZjdWVnpCUW11L052alVjSy9DUjJUbDFPNU5kb056Vm1jZmljNmVaR1NjL3F6?=
 =?utf-8?B?M2xZYnp5M1JXODBKNlVzWE5PdmptbHJkaVVtelNvanlFNEFSaDFmQmRBV0Mx?=
 =?utf-8?B?aUEzbEFxR3NOWDh4YlpsS1BzbWpGNlI0N2p5QWJ1R2Y3VUFKNk85MzVTTVhX?=
 =?utf-8?B?bi9jM2d2ZEtsMWo2S0hLUlNqNHdEUDNQRzVnYjFqeHlXd3dmbkg2T1oyR29C?=
 =?utf-8?B?TkgzTHlVMkFPWFpHYXVrTTh0Vlhxd3kwNXA4YVBtZHFZeElJSFVUTzQvMXdH?=
 =?utf-8?B?ZVBWWmpIODdua2RUS1Zvcnd4dEQ3WC9jOXU3Z1crZzVEaDlvWUh2RUpaZ3JF?=
 =?utf-8?B?VnpONUsrOE9FQWNxSUV6R2NncU5MOUI0N21aMHU2ZEFCenM3U2UxcG11ZklJ?=
 =?utf-8?Q?9Wja16TK4nLuL6bpxpkq9t5we?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048744b2-6b9c-48a5-5ec2-08dc23a72b4e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 04:26:47.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooBxsfi96tJ9ss9AtkkN5ioamEDfwmfSeJJR9d6s7aqT+oeZbfEcJtbv5seexWvV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302



On 2/1/24 7:30 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 1 Feb 2024 11:16:22 -0800 William Tu wrote:
>>>> I guess bnxt, ice, nfp are doing tx buffer sharing?
>>> I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
>>> I'm 99.9% sure nfp does.
>>>
>>> It'd be great if you could do the due diligence rather than guessing
>>> given that you're proposing uAPI extension :(
>>>
>> *
>>
>> (sorry again, html is detected in previous email)
>>
>> due diligence here:
> Thanks for collecting the deets!
>
> If I'm reading this right we have 3 drivers which straight up share
> queues. I don't remember anyone complaining about the queue sharing
> in my time at Netro. Meaning we can probably find reasonable defaults
> and not start with the full API? Just have the
>
>    devlink dev eswitch set DEV mode switchdev shared-descs enable
>
> extension to begin with?
yes, that's what I began with months ago, by just adding new devlink params.
We need at least two new parameters: enable/disable, and size of the pool.
I have right now is s.t like:
$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev 
shared-descs-counts  1024
$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev shared-descs 
enable
Once enabled, the default sharing scheme, described in the RFC, applies 
to all REP queues, and no way to customize the queue-to-pool mapping.

Then discuss with a couple people internally, and come up with this more 
flexible and generic API.

William


