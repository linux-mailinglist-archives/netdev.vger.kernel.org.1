Return-Path: <netdev+bounces-154343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6ED9FD237
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2C73A064B
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1E13B792;
	Fri, 27 Dec 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5+ZNhQv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538E130499;
	Fri, 27 Dec 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289176; cv=fail; b=aELCt6DlYWUkaH0rUnqfDjtX+8etwRGt4+PqfMwl4bFYh+eyeOJNUuMUAfKga0eqBYGpyjKq5VALNn/Rc0sBf3HzV6a+gSwqeI9HLAvlemiSYaeOeGya/vIUD2MfF96YBxeRdt6MO+WCmt0ejcrgRcuhrVbluiaDzMIBhmnBSsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289176; c=relaxed/simple;
	bh=rwtKfauvh3KR6FGdCHNQGFeNK+RTgcOL+P3Rd69QtwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKrpKCMr3uFochCenAG2WUsPZubi5ddz28grEraRz1OYhyIpTu5KEKgqODzs1V/ILiESSQmHsR9+6TS0KOTBvvunU160gE1iWx8LSWLy/Z630vpdS2G5YnB8ko71OGNg2zbD12B4JvhIAJhJck3LMIUWizpiResucu719qAd+YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5+ZNhQv; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACGSW4cHkL1HCvPVbKP2dgcaQqE5DsGr07/FYxAIrj3MfLkP4dc422ZdYiSAXPy/yTvziD77bX+TMOeEaq8vTVIK7Zhxbu8vrSxcbv6Se64lnl0CY5+ZSrHGV7793k97XtYLHLcPNyd8ZBrtUG47dDVf9F8dPPUTBAriKe+oYsN62snH0rsV3K5aHMBHeaBU2wdJzTWDEjlAA+bWsRA21LFIgMYBOskfDoGScB1lcGQuCUTn6xSWTLHnhf+PgLbuSDpNLZqyViVjKreynvnWcDNktOgcJsk4yZtUugS7pEZUv9zpj/+tGZlyvjK9YztdPsQvoUruuDyBIMZzJHCjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK/1fcWZGlLnWuEY8X+QCjR5N/YXrkOJ+KD2Qu5Duhw=;
 b=GHzky/TIWHx2VRO4E/YsSv6TEgW1itLDsPiXQwU0hOCOhKJNtRhdZTO6ekgQI+cnJ9bBV/UCAcGCeIc/G30S8OudaTtOUGg/mRCM/DjOyNCNlXyaC1+RB3WyJm3T1AAQfA0jB4JD0q+Rqhgffc/n1yEfUf9751s0xFTRY6b44B+3QmxTbVJdHYb1jRIvtkFsOOCu6m+gvDfU+rOd4LWFeH+tY5v0sJHAPQdW5WJvM0keNPFMU5Mt5JG5I3+06u/fphYdisRfBMMpb2lFfE2QNIwUU5qjqHdkX0NzAQa8mOgoSup9WgjaYTXb8YX5NuXFG+dy+yIcnzkQOXsf+cKMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK/1fcWZGlLnWuEY8X+QCjR5N/YXrkOJ+KD2Qu5Duhw=;
 b=R5+ZNhQveuZhhFYKQIqIcKYw1bM9vKexPT28N3qOVR+0JbC5WYxxXYDKeJsSFA/bgKqgfq+GMtnFOGBS0tckqeej7y/xfLBYmJUiPmlX/MzZMTia4/L/TIVS6hvlSIN8A9nnuHehz90kVjxr1LA+IWAbNzNuG7lyo5IsHQqVGIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 08:46:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:46:07 +0000
Message-ID: <2ec3e22c-ca17-03e0-aff2-15d7ccea2ab0@amd.com>
Date: Fri, 27 Dec 2024 08:46:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 23/27] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-24-alejandro.lucero-palau@amd.com>
 <20241224180458.00001812@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224180458.00001812@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f75e31-5cc5-4f93-8d45-08dd2652e77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0FhMnNCdnY3WVpGd3l1Qll5NzZhMEdsQzUvbVpUV0xTQkVwYjRhU2V1aG5z?=
 =?utf-8?B?ZmlsbWNlZStGNUYwdU1EQ1YydHJoYnRMNlBJRHBpMzU2ZUtvM2pEOUEzTU1y?=
 =?utf-8?B?NTRCRHR5OWVNQkk2MUdRRmQzd3hvbUIvWlVEVnZzMWdrenhhRFI4a3NkY2hz?=
 =?utf-8?B?RzMwaVkxR1NITHoyVWRVbzRZZlV2ZTl6VzZ2S2VsVlhjbGJ6TWFCNVdaKzE2?=
 =?utf-8?B?OUg4VlN6QmsxVENpamNuZWF0anJ6eEFPWlFQYVNwTXM2ZHdKZWkvYms0WGlp?=
 =?utf-8?B?c1d2V1NwT2QwenpCcm14UlF2clo1Q3c2WVpJbEY4YjZ2ZFVaZnBWTmt2em0w?=
 =?utf-8?B?WDE5SjFMNUdva2ppaG5rSWp6NTZsMXl0eFRtYjhFVHo0b0lEcEF6OWJjMVdF?=
 =?utf-8?B?L0t6RHFwZEV3QlZNQlhOWGpiRlZXRGwvVmdEUVprZ0xPTWVEK1BHTndxMlJz?=
 =?utf-8?B?UjFVNC8vQmFjS1NHMDBvWkxmRDhsTklXbGxlWGNpNURBWkJQcWpFSWtsYW5C?=
 =?utf-8?B?R08zTDJ0eUUrS0VEdVh6WnNEcXludnZUakI2TzFHVGdLWS9GakFvMms3b2lE?=
 =?utf-8?B?OGZEa1FtVWtpU3hmM1Y2a1dFTG5NSDNvTkF0RXJ3cmNUZk9XNm5IUEVtRURU?=
 =?utf-8?B?WlFGVzM2bXZ1dzIrd2JicDVqQWp0aStYOFhjclhLRlZ6V1BvUmJmNUtsc21L?=
 =?utf-8?B?MVUwa0FIeXlmTS9qVm5vWVE0VUNaU3Zsem9mUkV6U2JUeXZ3Y1BWSDR1OFBS?=
 =?utf-8?B?OEFiSGNzaXppbmMxQVFSLzh5VGM3RUlhTVlPeDVMTHNmalBOaGtDbEJ5WEV4?=
 =?utf-8?B?bGloYXpaczJ6VlR4eXROQStHV2tWZm80a0VHdjB5ZGM5REhGS1J4SGNReU1j?=
 =?utf-8?B?Wi9DWW1jdHBYbkY4RFJ0bnhkQTRtTWdYY3BkK2tPeGNEUXZBZUdEUmh1SFFl?=
 =?utf-8?B?QVYreWhMMHo4N0ptNjJKejU2aEpsUmkxZFBkbHlVVjJtVGFXQTgvRFZUTTBB?=
 =?utf-8?B?ZDVmWkdtVERCMTFVOVM2blJ6bzhoUnFGMzBCaS84bHg4ZlVmTDRWNGJpejJt?=
 =?utf-8?B?N0FtS0hFNk0xSHhMcTgybmNSUWl4NzFlSmpSbkxjMnR4VXFNRjgzdGdMWkhX?=
 =?utf-8?B?bmljbVRpUDNEcDV0WkNIeXVTanE3RHFSYUxSRVdXQnNJNmQzOEtpcXVkN0dq?=
 =?utf-8?B?eE9UY2pyWXVoblVWZG4zMmM2U2VyYTJaWFNrRHpubEtIY2pGNk9ndGFNbDhZ?=
 =?utf-8?B?VHNpUlR4dkluMUlWSUY0clBkL0hObGFQMTU1RGNUUThRbkVNdW44WnljVmV3?=
 =?utf-8?B?cnVvT3k4WHRGYkFyTUlDL21BaDJ0S1ErUlhJRmUySjh3SU1tZjBIZDVGUzNy?=
 =?utf-8?B?cFhtaTFaQ0VEREJKaHlrb01PTnBvZkpRb1NLdWQ0REdrZjRieTFFMEc1ams1?=
 =?utf-8?B?NW9FZGdFV2RMTUdoVWVrYkVIbjN2d05WS0UrSkNPcXdwTGRWaTYzTjRwYTNJ?=
 =?utf-8?B?RURINmFvSTdwclkwS2U0UDlpODBzdmc3cjZmd1RJT2lQdU9pL1p6YWFURTlZ?=
 =?utf-8?B?M2V2QzByMitxVmN1SWZSZmN2eWhQYmxKUDZTTWFmNFRyNU5oUDQwTmZ3bXFL?=
 =?utf-8?B?bUVWRElUdlN3NkRYcXdEQlozRjJ3MDRFSUZ3SG1YdWJ4MWR1UmR2RmpTQTVw?=
 =?utf-8?B?MkhRVUtoRlB4RGhGdm5JcHU4cjF0eGpJb3BlZW9ndzdyUm1VaWZrTHYrdXU2?=
 =?utf-8?B?enZOaE14MjJjbStKdlczTmVNaW91b0xMa1E4cDgwZGh0eTJSYXVFZ0MrUnps?=
 =?utf-8?B?Y3o5OVg2ZTZOQ2dJR0F0L3laOHNiSHkrZUhtZ0xTRlllR2ZOa3AwQ2Q1NzNl?=
 =?utf-8?Q?XySNKNnYFq1ia?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnhXTEhTZjZOSFpiVk9VN3BLVHphYS9oTlpUamFGZ3ZNTGlycEpzQ3FpY01O?=
 =?utf-8?B?MlNjcjlJN1I4dUlWM2JwZXNCSVY2MGNXN2hwT0N0OXpyMG1jbk5OcnFVY3FH?=
 =?utf-8?B?M0pKRFFxVEgvSSt6VnVIeHdGZjVxWU5HSGRCRTRyRHhIZ1FkaTdtMzV5ZVhU?=
 =?utf-8?B?ZnQrQlNZd1prN29GTkZnRHQ5UUFCWXVWc2Y3SkppMXFYeVpxb1dFS1pWUkR2?=
 =?utf-8?B?TVBGUkpUcU1lR1FGL1BYK2o0YUlYZG4xcEsvaWp3d1VpZWt0aFpPakNpMGpL?=
 =?utf-8?B?ZnhOeGw5bWxJYXE2TG4wa0tuUXVlamNYZDlpWlF0cEFOZjdBRWZhRFFJRWVx?=
 =?utf-8?B?cldOYjZKUDBPTnUzejVyS3VNZ3Q2NExTZjFpUkRoMDdkVVZIQ2s5aHdxenl5?=
 =?utf-8?B?NGd6OFV5RU1haDRLbGZHVVdSd2tZOGFOMGd0Z0hLeVZxM2Z0TnFlRU5PdTBz?=
 =?utf-8?B?TFhvdTRxYW5RN1ZuQkdaZEFmYWl2eDN1dEJ1OElzQU8yMklzYU83MTlIRkVQ?=
 =?utf-8?B?Y2l1NmJZZTVXNkxndEI4NGhQUEtOY3g2Qm1Tb1JVTjN4dytBOXNyekJTeS9w?=
 =?utf-8?B?bEFiNE1icGpSUzVEdWdCaUh5L0gvVFY2SENrWVl6TTdEZElyb29oWnBqY1BK?=
 =?utf-8?B?Nm9HWkt5cUZsNE1EbGNycFRzQXpreGRLMFRKRlhsM3RoQnc2RlEvcVZnVENE?=
 =?utf-8?B?aTI3cHZ5UUx1aU1XNk8xY2ZNWklHeWRsUkQvK2t2NENaMUU1bkJMRDlNTExs?=
 =?utf-8?B?M3JhVncreCtwNnp2THMwcmlONElzZU9ZeGxsdm50VFFtWXJJMUFzajJMdFZj?=
 =?utf-8?B?Z2tYN2swenJEUkZCL1FmNWRGSFYzeFNyTVdUVnA5cDUrdGFKcEZWdzlxM1VU?=
 =?utf-8?B?U1BNMlNKbGxLZWZySGdBcnJZSVJMMXQvVnJXWWlVV2pqZHMyak40NUpzWjc3?=
 =?utf-8?B?VEVQVDZITDh4TFlWTU9oSlNHNFBvcXRGTzdtdk1OdXVxSkVPV0VpWnpPc21S?=
 =?utf-8?B?VyszdUFGbkxROG9yWjJkNnR0STIvdmRZaWRlMFhrMDdLK2ViVFhNY2tXUlBq?=
 =?utf-8?B?NTFwNzRzTmpoTTd2akxxWmhreUx0NzB1a1lCQzB1Rlg5Z09TWUNkckNJS2I5?=
 =?utf-8?B?czhnN0taVGlnZmVXQ0ZZR25DdlNYa1hYc0RDRFFvVWw2cVFlSHBJZVNpV3pL?=
 =?utf-8?B?UDgrS3JPOCttL2pVUktvdkRHSU1rb3B2L2c1a3Y0cDE5eUMzSzRFZVk3MXIr?=
 =?utf-8?B?OWY4UUUrYXdJd0ErNk1SM01HaFpIYWs3ZGxYMTRWa3hFSjlkSDNydlBhb3kz?=
 =?utf-8?B?L3kzSlZhSVdRaU9hNldPamZEUThkUmVYZGl6TVJBUGZuOGJ0T00wY0JEZFo0?=
 =?utf-8?B?aFhYWnVzZ0pZN2VWcXBXK1hKd3hPaHJMTWxlT1ZJOG9yTW5wdUVtVnBXUURB?=
 =?utf-8?B?RnJpTnJOdkxUSGR4b2JKcTN6c2t4ZWZNRVdaWkZrZXZodkthUlhqekpNK1lY?=
 =?utf-8?B?dVV3d3hpM0w0WjVVS1NMY1JwSDFrUC9VRUFOR2hvditFVVY0WHBVSW1PVUJ5?=
 =?utf-8?B?K3Axci9uTGlOS3JqOFRlSmpoZTFMRFVXY3FjQ3Q1ejFMVkRXK1NOamNXNzRC?=
 =?utf-8?B?S3lFYVhHVjdSOG41VUtMOExPRGowaXpBNGVsR2VYbDUzQ09Ld0dEd3poNElw?=
 =?utf-8?B?cy9CbEsvZzM0RmNDcEdSenhzVXFxZHMrMVI1Q243a1UyRzZCME5hSGNCdHli?=
 =?utf-8?B?RE9FSE00eno1MkNDTTFXZVpBekJSR2NqRHlHL0FLOHlMdWV5OW5Mcldid0pJ?=
 =?utf-8?B?N21PVExQVnJScENBcDVGM0x3WFNJd0VNN1B5RWdFbWlpQTEzNEk1b2JpVFQ0?=
 =?utf-8?B?VjBiT000bVUxaW5rSlFydHdHTmU3amhQek5nVlplRVBHTG9aOEdyRGtMR05o?=
 =?utf-8?B?elJjb0tpUkxyY1ZkRVVvWUJBZm9OUldhWGNsZjlCNW42a1ZsZnhMSFhaUFA2?=
 =?utf-8?B?ZVNXUzFXTU1xZlFsS0RVbXNnR2w2MEFKQ3lFa3ArUW54ZldkbU9CbGpONDlx?=
 =?utf-8?B?dHNZRlNsVitjZEVMRS9DWGN4VmhPNzFOL0VTbUd4b1FHYWRkcHJZVFZuNjJh?=
 =?utf-8?Q?yupG6FgGG9iTNE47B5VumWzss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f75e31-5cc5-4f93-8d45-08dd2652e77b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:46:07.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pngU8ov8NMOS57P5BH2wdqgPypFIHniUtW2a4lJLM5P50zK29Jv+DDj1I9Zt0bVUEf3CtFW6KBmi3KCHyYgcng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441


On 12/24/24 18:04, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:38 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses. However, a dax interface could be just good enough in some cases.
>>
>> Add a flag to a cxl region for specifically state to not create a dax
>> device. Allow a Type2 driver to set that flag at region creation time.
> So this is presented as something a type 2 driver would chose to set
> or not. That feels premature if for now they are all going to set
> it?


I would say, by definition, a type2 should avoid dax, but it could be 
dax just what is needed.

I was told to add this option in previous reviews, and I considered it 
more flexible and harmless.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>   drivers/cxl/core/region.c | 11 ++++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   drivers/cxl/cxlmem.h      |  3 ++-
>>   include/cxl/cxl.h         |  3 ++-
>>   4 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index a24d8678e8dc..aeaa6868e556 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3557,12 +3557,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * cxl_create_region - Establish a region given an endpoint decoder
>>    * @cxlrd: root decoder to allocate HPA
>>    * @cxled: endpoint decoder with reserved DPA capacity
>> + * @no_dax: if true no DAX device should be created
>>    *
>>    * Returns a fully formed region in the commit state and attached to the
>>    * cxl_region driver.
>>    */
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled)
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool no_dax)
>>   {
>>   	struct cxl_region *cxlr;
>>   
>> @@ -3578,6 +3580,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   		drop_region(cxlr);
>>   		return ERR_PTR(-ENODEV);
>>   	}
>> +
>> +	if (no_dax)
>> +		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
>> +
>>   	return cxlr;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>> @@ -3713,6 +3719,9 @@ static int cxl_region_probe(struct device *dev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
>> +		return 0;
>> +
>>   	switch (cxlr->mode) {
>>   	case CXL_DECODER_PMEM:
>>   		return devm_cxl_add_pmem_region(cxlr);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 57d6dda3fb4a..cc9e3d859fa6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -521,6 +521,9 @@ struct cxl_region_params {
>>    */
>>   #define CXL_REGION_F_NEEDS_RESET 1
>>   
>> +/* Allow Type2 drivers to specify if a dax region should not be created. */
>> +#define CXL_REGION_F_NO_DAX 2
>> +
>>   /**
>>    * struct cxl_region - CXL region
>>    * @dev: This region's device
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 9d874f1cb3bf..712f25f494e0 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -875,5 +875,6 @@ struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool no_dax);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index e0ea5b801a2e..14be26358f9c 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -61,7 +61,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     resource_size_t max);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool no_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>   #endif

