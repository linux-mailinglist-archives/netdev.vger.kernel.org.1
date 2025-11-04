Return-Path: <netdev+bounces-235538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591CC32463
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7A41A2187A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ECB341AC1;
	Tue,  4 Nov 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGHJGwNH"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135733BBC8
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276073; cv=fail; b=pezJMTL3muvDHnreLQfc7ExYam+7WYqHAtAa8Al1aiVOxlqwPCnh+A3U3MJvHnHkDbdSeS0h9ulOmWoxSxG+BoitFgwWg7KuKdE+trAGsIrnx4AOufPJpIBW+XN+yenbu1sB//JIe80oFq5Dw7Vx0w8Z8Ff66eObdqYqPsCe9rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276073; c=relaxed/simple;
	bh=uOibEmHIxfkjG8/2kD+SSBmPKta9XWTKDTYt+hKbPKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LX+RhCjue4Pvu37fikC0LVZBj0kP1dAhp6FNjEEJE9oq0rehARbv0w7s8C93NjSldvthoidH7qroS25RcUv/mqUU2+JNPWhkGoQ5q6aUCTeBY+iqGWMPvoU0X5Gp2FT6sgI6SGCyFd4KNHj5SJg1ZuRrqTn0TX1KRq/RYedQoj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGHJGwNH; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giZadHbR4s6h/BVvsKeHcgQ7w9r2ThPlDzjv+djvju8IQZx6TsucVYOcg1pR3NVy76nXzoSVMDh18xkjezk8XbNklIrSt3SO17+UjFOkGSMQRWnPugqBiSCpmkWVJ89vRn1cIaeiPufIBqonC8mMEcH3L0paA8f0dIzrv2oGPtNghMdAyZ8x+PKnjQ7lAyt+/8M2tQBBAk1ksS43Tu5VTYnyeJo5y9M+bu6zwOSxUPFhhEFBvqTbfllbF5iOvS/A2g+YLfmVYseod+gYKy/VSpVJc9a0k7sjIQ2fUmw81/qskxa8lB2sDpK5CMMJdtCirv6jTY0nISDfDJPVOXu7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHhCMbyEm/X73f3BXX1xv2fQhsGVbwj5t7g3ZSwLigQ=;
 b=G+LIE7aSFmK4wfluZNGCcWREV1jn1aZPMlu2n1wCImLD4VbQeZTpJVEVInKQcXNpKKPUyzwCR/6ymgQ8vsrcznJ649uLMzd1TC095fjfZ6uliv5qSEovFrawqaiV+5AGBfWNGkuu7lrC9k3eo6V+wmr6sj9s7T52bwHYOKsEMPTNfXhnInBOH8yDHzAKcH1Sg+TK+RLiFCuLfoXoH+oYiQY/a1Egku7sz++frVChBecnJny1r8eHZu1Kuf4OkJSfCb9bt5lhgki2C4tKGdKD28M80P/jNUmQwUSkuk1GiXIyW1qyBJRChd3jgvkqtfPhJmm86vtjy/Jsy2Hy+CVwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHhCMbyEm/X73f3BXX1xv2fQhsGVbwj5t7g3ZSwLigQ=;
 b=jGHJGwNHMeb0u5UoHmTWOZBK32KdZbVXxToGdhfs8dFJhwT7NWTDpE4QmEsXhdbfiVhO6hLKtk3LbqZqQ1q0DxKHS6Cx8s9W56nCRhtSMx+7fOXZWUM33gLTEIBZ6ZMXDAZzayJFS1KuFVdu+IT104kDYkg45oT0ayJCiJznLEdukY8h7yEfyUp40cwnsqXso8neVN9L60QyNv4wDup/ik268rT4Ms+vwEHz8hstgN52vFJH7PfpUBivwyfs+fwpPC0RssijKYwuhkWa/kUmDE6v3DEQyUh7f+VD+n+FAzE41E4lTeoRXaWplZokTQ64Rgr/Me0ANBTFVdx+7Ha6/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 17:07:47 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:07:47 +0000
Message-ID: <a3236a44-88b6-4819-9fb2-4e4584b7be16@nvidia.com>
Date: Tue, 4 Nov 2025 11:07:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251103225514.2185-1-danielj@nvidia.com>
 <20251103225514.2185-8-danielj@nvidia.com>
 <CACGkMEumoo3J1LTKBJqLCWLAZ=DX1NeX8D_87HjJ_9hNkV0bZw@mail.gmail.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <CACGkMEumoo3J1LTKBJqLCWLAZ=DX1NeX8D_87HjJ_9hNkV0bZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:5:330::8) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 590770de-1758-4ad7-f0b6-08de1bc4ad54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDFvU0IrN0ZOeVYyMTRZbkpvUjczQ2dER01TQndxMjBsTEFzbWw2YzU3S1Y5?=
 =?utf-8?B?U1ZraW16WEIzdjEzQy9UK2RXelYvVUhUbG1qS3JMZVNnay9TMktvM0pRZi93?=
 =?utf-8?B?MElMUThudFNtaXdmYjhFdnYrYlFPM0hJejVQK0V5Z1VvSXJROGRSTWxybngx?=
 =?utf-8?B?Qkw0ZEJQVFV3dEVoWmpBTXpJSTRQcFAwZ3lwTVEzb1cyOUhsbGsveEx1UUxW?=
 =?utf-8?B?b2s1bXIwQXB3L01Td3h3UkdQcmQvVW8xU0h3M3hLVVcydnJCSDY0UDRscUht?=
 =?utf-8?B?Vm9XaFBHd0x6NHJDNDc0Wm8zZXhyNVBrY3dFa3VCWWtsOEs3RytTKzNLQlNp?=
 =?utf-8?B?MEk3ZWpZaTkxOHhsTmZ1dElVcFhPeUlZQTlLUDVxVWJrY1J3RjUvTjd2eHFt?=
 =?utf-8?B?R0tobEFYMUk5Nm1uU0QybXFtaVBWOTFDdml6Vzl3aXpxZmpzeVgyVmZnK2Mx?=
 =?utf-8?B?K2ZNUDdKMHVJUWxic0RkOTlobzFpbGxObWZITDdQbTR4aTQ5dWZmSkF1YlBk?=
 =?utf-8?B?aU44L05pQjJLYm12M0RkWmpNamp3WktuQno3bEJITk9ZQjQ3SWduWEN2K2xG?=
 =?utf-8?B?Lzh4WWMrcld6SmwzTkw4LzkyMGhud2pXVmJ0cHlwSUpTSTVzWGNBc0UyaWd4?=
 =?utf-8?B?aEtxNWErakpjUzcrM1o0ZlhxUThBQ09OeGNCd0U2eWR6T3cwd1g4ODcxOWRz?=
 =?utf-8?B?Qks5VXlBL3IxYzdaNnlpTnJxSmtUTGpRRU1zOWRHVndtS2FtYkszYlNLSXlW?=
 =?utf-8?B?SmYrOTE5Vm5sOFp6STdSeHB6REVVUFVhWlpsMENDL0V5elpZbk1vempkanNP?=
 =?utf-8?B?Tlp1NnZkSlQwRllabVJuRXJ6Y0tES3FYaTVtTVJHeHA1ajVjL2pvL3BRM2hY?=
 =?utf-8?B?V1VMbVlBZmJEdmhDZEtLWEVCeVlSWHRHVUlqNUlHVjNQanVjZWozdGZrQjB6?=
 =?utf-8?B?YWpET0dMM1hFdlRFRFVJckU3TmpzN3ZtdHd5RjA1UXA0SkFPV0RSTjY4Q3Fx?=
 =?utf-8?B?M01xeGdUWFhnMDlMLzBzQVZHMVN5a0VkUmJlUUI1L2gvTFJPQlBBSEUvSS9N?=
 =?utf-8?B?ckFmWlNNYm1SQkxPZVZPRzVzT1YvUjV4bnJqemIwaDhLYm1NTVBLb3c3V2o1?=
 =?utf-8?B?UlVTUEcxekUrbnkxaTNwWEpBL1ZBK25VMEhVcDRwMUY4VEJIc1RVd2REWkRn?=
 =?utf-8?B?T1B5ZjIzOXBOby9ORkJaK2RROWhMNmxIZ2JtYmpBVkU3bFVWbzllV0oxYWMr?=
 =?utf-8?B?eS9xZVBVT3dNNzg5Rms2YldLU3ZQK3JvNHFzVzgyWnN3WW9DTlh2QkVxZlly?=
 =?utf-8?B?L29JWjJRMEY4WjNxcWFhMmNQV1hQb1Z2eUY1QSszdzZUSHM0UnVoTWlCTTJa?=
 =?utf-8?B?akEwUm85dDVMbUlRVUlQMjMwdlRncGVXMUZ2dEMyeDI2NExHak9VNnpUVjNt?=
 =?utf-8?B?bGRuY0ZHalpYOTBmYVAwcWRXRWd3WC9FSkVabXUzUVFlMTU5OVZPZ1JWVUtJ?=
 =?utf-8?B?OUpOVVdaYUFsUFVJbkdoM2Fja1NXblNQd0ZPMk1ZS0Zhb2NFTThSQzBFNmRu?=
 =?utf-8?B?S29heXhNV0xBYnBaZGRyUTRhME9TTTJLY2hsdE0vTEVVOGg1L3c0VUJjQVVP?=
 =?utf-8?B?cmlQczU5QWtxamZZVUIvTVhDREtjdE56QVhuQ0xZcytZQ1VpSEJKR1ZBZURo?=
 =?utf-8?B?VUYwclZsREErVVY3dlJPT09Yd2ZsQ1g2Y3dOZndBRHpNK0MxZm1ieU5NTlRK?=
 =?utf-8?B?T25ydnlJcFVkVUxmU3ZrdUhVTy9LS0VkRVpENDZnQnVNK0s1UnRtUVdiVVhO?=
 =?utf-8?B?YlJUUFpFcnpPM3VMd0VRdlpGcmx6aTRHby8vQXBmNzFLaHpCQnorWjZWL1Va?=
 =?utf-8?B?QUp1MUJndDFJdTF2SEZjcGd2N3R3dkJqQ0Fqc2ZqdmQyeWVJa1o0d051QVBp?=
 =?utf-8?Q?VrCkdCjXyq1wr6Gkh2Cs/AkFDxou/OcH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1hpZG1DNkJiTngxVnJuQ0VYZ0FveS9HeHdwa2cwUi81QlhlZnVHZTBtMDZS?=
 =?utf-8?B?a1NrbFVTN3ZIVWtZTEpOeEZ0WVkveTlPck9SUmFTaU50SWQ4MWEwYklOVTF4?=
 =?utf-8?B?Zk5SOFRzZ1lUdkJNTVB0YVJEKzArczFKWHhsOWFKdFlKY2VYZDhVb1o4Wkx5?=
 =?utf-8?B?azR4S0p4bEFCTHN5U2pFeGFodm5nT1l4NjRad3lKRTc4NDcxNjJvOGwra290?=
 =?utf-8?B?dXkwdmJoUUMyZnFUeWpUdThNL1FjK2dzenpLWWl2YUJhUm11dEFXak1NSm1K?=
 =?utf-8?B?dXpCZ1Z4eDF4VS9GbkNmTUxuUjB4ajNwM1VYdmNZSm5PODRha2N3dTZ5eUQ1?=
 =?utf-8?B?aUN0NlRHL2FJZEZZa0RwVEkxa2YwUFJKclpZekFja0lqS0VjZjBrNmlKcUJN?=
 =?utf-8?B?dWdLTm5XYUtQZXlFbVBvWXNZNUlvQ2YwWVkyeU82WlJuVzRnbTZFOTlGd2s2?=
 =?utf-8?B?OEJ3VVR4TXpSRnErbnRvNVoxZk9Fd1Z1M21qbWw3L0JPVkxVMm5wOGlZQWIr?=
 =?utf-8?B?em5LUXdsSkhIenZqVVFQMmJ1SGJMUitKdUV0WmNYT2N0TEtYdEFJRFNSY25F?=
 =?utf-8?B?NmlUSG4wL3VRSzBKclVGaFBab2dGVVliWTlMNWxwVitRTmNGN0pyallmc0xN?=
 =?utf-8?B?SE8rYnFRMDBrRFRaRlVlem9tbU0vcWplYWlRcys2Z2FhYjBROWhRM0JBenVp?=
 =?utf-8?B?YU5wTUdjelRqRWtIV1lmNUJlek1LSnhObjUrUlNMUHF1Tk1EeDF2L2c5V05n?=
 =?utf-8?B?SzdWSGVhRmEzaFpPRDJqQ1hmSXhEQ1U3NkVFT2ZkYVRNVlgvamgwYmJ2dUxM?=
 =?utf-8?B?YUdiVjFZMjRtQnNMT3JNV3pzZlFXUjU1QS8yQlpZaTRpU1JGRFRyVzdEVmRo?=
 =?utf-8?B?KzA2ejN6c1Ezckk0QWE4b2RlODRjdWJkSWtQcTkrZEtJVUQ2WVNkcERQQzA5?=
 =?utf-8?B?VWtCb3dwemR5VGJQSi9UcGd0T1gzY2dOVDQycmJMWDlkTlkxNzg5SUZ1SWVK?=
 =?utf-8?B?S3hwem1jbEt2NDJVTE1zdUN2bUt6cnd2akN2SUVrKzRwQUtFckFrcU9SUktw?=
 =?utf-8?B?emxBV2xGNzVUbjV5VEpzM3dtMk4zWTlBNllYQ0Y3WnBJa1BpR1Nva05INnFR?=
 =?utf-8?B?SmJGQUF1dkN5YmVENVlYRk1tUngxN04zVFRPSUNiclVKYWlCbGV2S0pMUWtX?=
 =?utf-8?B?RmlTczFHekY2VUVKZEFyckFvSkFXR3RSTXUxd2c0alhEOCtvaU4rbVVmczJU?=
 =?utf-8?B?V0MxYi82WTlKZXFxWVUraWwvcjdLc3pQVFVsY1ArY1dicmFxZXNGRjJ2Q051?=
 =?utf-8?B?bUFOUzZ2ZTN4b1pXbklUMkZ1NmkvS1FteFE5elpDZHV2Nm53NWhBOUhHTmFN?=
 =?utf-8?B?SUg3NmJsVVp6c2FyTmNONGJBcEFyWmIybFNyNDQ4bDBpeXdGZEVlc0p2NGFm?=
 =?utf-8?B?SUt2TU5UUmFTREZOa3ZYSmh3WEkrdHVHaHFJN0ZwdGNMU25Bd2ZDSDV1cFM4?=
 =?utf-8?B?OHNrd2Zwb2J0QXU4ekl2QUNMY2Zidm5CV21hNW9BU1RJZVFQcGFPMi9Oa2ly?=
 =?utf-8?B?d1BsQm82bmNibXp6dWpoa1o1SzhaRUt1OVV2WWU4Z1ZtUStwV3JjdEVMTHd2?=
 =?utf-8?B?bVh2eEJMRFd2emZxOFFNcmlWYVFWcjZXMnc1SUdIZnQxVC8xUWVTenhtK2Nw?=
 =?utf-8?B?cVVoeG9iMWlVdElyVzhxbFg4YXd6RTFIOHVxSFhiUmIwczJwZTVDTE8zeXpj?=
 =?utf-8?B?TzRoVGNwc1JjdkhlVGtIekpqajRYdHBacXQzWmptcG5NSndlZmNKOEh5MnEy?=
 =?utf-8?B?WTYrRU9hWlhPQ2hBeEIvUG02STFKdEhKM1BzYnJNZ0NxejBLZWZiTEFLTWYr?=
 =?utf-8?B?WG5DYjhlUTZpcFNTN0Ryc2tyMHlzUm9IbGxSekhPa1VNZSt4d0xwUjN0NmI1?=
 =?utf-8?B?UHVtR1haWWdaV0VROFZ2bEU0Y3NQNWErNzc0OE04RUxzd3lBbHF3N21YQWFw?=
 =?utf-8?B?U0VxWVVrOXBXTVR1dExPbzhjQmtmb2I0UnZmM3ZlRVVTL045aGRHNWZFcDVq?=
 =?utf-8?B?L1ZhRVd1NnJjUG1aU2pSdTRpLzNSVEJGWVAxbGgwR3phQTBjS3pucCtIL2hD?=
 =?utf-8?Q?bwPTB26uPxZcXO7agTRzztn0W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590770de-1758-4ad7-f0b6-08de1bc4ad54
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:07:47.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ/agNYwzdfnPLm6vccfNlkilAdYPzFgt7pPXJGFV9h6wnC+qDJMWucMCoANbUSq/CKS+YxH7DLsdNpnV36dNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817

On 11/3/25 10:34 PM, Jason Wang wrote:
> On Tue, Nov 4, 2025 at 6:56 AM Daniel Jurgens <danielj@nvidia.com> wrote:
>>
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.
>>
>> A classifier consists of one or more selectors. There is one selector
>> per header type. A selector must only use fields set in the selector
>> capability. If partial matching is supported, the classifier mask for a
>> particular field can be a subset of the mask for that field in the
>> capability.
>>
>> The rule consists of a priority, an action and a key. The key is a byte
>> array containing headers corresponding to the selectors in the
>> classifier.
>>
>> This patch implements ethtool rules for ethernet headers.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
>> Added rule with ID 1
>>
>> The rule in the example directs received packets with the specified
>> destination MAC address to rq 30.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed double free bug in error flows
>>     - Build bug on for classifier struct ordering.
>>     - (u8 *) to (void *) casting.
>>     - Documentation in UAPI
>>     - Answered questions about overflow with no changes.
>> v6:
>>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>> v7:
>>     - Move for (int i -> for (i hunk from next patch. Paolo Abeni
>> ---
>>  drivers/net/virtio_net.c           | 462 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_net_ff.h |  50 ++++
>>  2 files changed, 512 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 998f2b3080b5..032932e5d616 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -284,6 +284,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>         VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>
>> +struct virtnet_ethtool_ff {
>> +       struct xarray rules;
>> +       int    num_rules;
>> +};
>> +
>>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>>  #define VIRTNET_FF_MAX_GROUPS 1
>>
>> @@ -293,8 +298,16 @@ struct virtnet_ff {
>>         struct virtio_net_ff_cap_data *ff_caps;
>>         struct virtio_net_ff_cap_mask_data *ff_mask;
>>         struct virtio_net_ff_actions *ff_actions;
>> +       struct xarray classifiers;
>> +       int num_classifiers;
> 
> This is unused.

Removed, thanks.

> 
> Thanks
> 


