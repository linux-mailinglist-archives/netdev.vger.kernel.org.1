Return-Path: <netdev+bounces-119798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3273957018
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6615BB275F6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18845BE3;
	Mon, 19 Aug 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3vT0QfR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA245014;
	Mon, 19 Aug 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084121; cv=fail; b=FesQNOzOfAR6+kx75E1v4Lhy2JWXiTEP7nFpGhtzwGWn8HC4QRIG8ZzNAuTDp1LmSPIIH4C3H6FHkcucX0XodtlJYMOPnmGTF/h46Y2O9INsRXBKNOqZgGunpIZbUq9ZA+h0+3bqAYvirXxz+dMLjq9jXRzDqX7s5xs+0zc8hV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084121; c=relaxed/simple;
	bh=89vnAeYdK8mTeqnXQKb7jSKzEMTbj6NSvq1ijA8PTpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofK5dJFmBMM8ToknCC3TyVapFa7iQCAsOqOyvzfaCxjtY7RUr7/i5Bll4xu+MTYk3OcmQaW+bAKHUfGh9bV9Fvtp2GnCU+QDupZKXuYj/XbSzYyt5kFNy/QwT4dyoWJTSqhtE03XMShOOY6h/O3dpNN3YQ7z0hZDikGPSQ5RrC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M3vT0QfR; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK2Xld626pjFTID8Jgz2mPy58z8p7OuBOdRxklIKnlvQUljJGTO8h5xKB0HxnkkRRw3T/KYHFZyvl+0ewCktuY18qJWtXzBNrTB64C1EkDXbtOTPfZwsC8Z8tf4Vb99D5cyimFwyutIBGGX73sV5EdO8McZbHNsP1raSYCjjOZXHM7QZeSyjTMA3y7rzEVVrsfxVtJI6UgRJGN/nwzf0Pd2SYD5nmPAqmwKyU/lO9ScVxhwgpxWD4E79UpXg8wJK2UklfHmth8Zto62rYJKGGcyhxblwvm+Dl1z2FCYOpscpDTWWaxSqHoNXKgOYth4TeQEl7ich2QdK1HosaqgFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=torwd5wNBOjTq1qY2OQ0L86ILij6qY57QO5WJYD6kaY=;
 b=wYfP4ZeIJA7Ug5K910UfLKDYF4lzZLBHSmfRm+0GVgbCQSq0ph+NuTcc5s7mTHtL8DJQfhGcgYbEDY+oHUZl/FkhbRNfll+tHAodOezkaW19EPRZs5lAWqj5S+LTZ9Xk6MvhwaGqdfud6nwVEFRu9cFBXzdp+57qaL+JlC0/1ZuS6I6RzSphv5GRlXF/gXYecUKVn59BBPNO4qLXbd36dMXhCtO/F6/wDAvDtVTMQoAGCIiH2m5cmv0knJ8jStC1refTIWRPz4malDJEM8M9KbJfkn7Xaj9W5U5VP64Ik9iZ/4uPEXvYIt5mUDFgN923jLvnKW0ZN7k+/xkXHnHuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=torwd5wNBOjTq1qY2OQ0L86ILij6qY57QO5WJYD6kaY=;
 b=M3vT0QfRxhA5oXc9SlLjChiQVTZKBrdkY2POREqEzrmD3oAoapwiqrpfo+qJiB6wTCOzd/Kqot/GXHf2cVz+Z8iBEbcX8qna7IWjaxvmdWaG/McuKE5Kr/w0BAfGQHLUsnKbofvbiraQO6diI70YRVIIeEBUKJ1zKE+c7Hnv0Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:15:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:15:16 +0000
Message-ID: <76347d1e-5e49-860b-3cbf-bad2a52c3853@amd.com>
Date: Mon, 19 Aug 2024 17:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/15] cxl: add function for obtaining params from a
 region
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-15-alejandro.lucero-palau@amd.com>
 <20240809182420.00002f9e.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240809182420.00002f9e.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c824f44-c8f7-42f0-cbc2-08dcc06a1ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDdLMU5Hb3VNYnN0eURCZEI5MUl5VFB3OXJzNDc4bjl5YWtUYkNycjhRT0JW?=
 =?utf-8?B?dWJmR053T2hyZ0Y1ZDlJb1lVK0t5c1V0ZnVyTjBXbHBCUUxyYVBhVkpRS3Vh?=
 =?utf-8?B?WTBKNjR1b1VLb0JWWGh3UGhCcUJnZGJvd21EZFlKVFdUamRPSmxRaXp5Ujg2?=
 =?utf-8?B?M2NiRXFZMWJHQVRGR2dUZ2JINE1OQmsxQ1o4dnJtWTFQQ0JFdkZueXI1ZEhz?=
 =?utf-8?B?ODdTZ2NXcXBibFQwdC9vbDh1QXNXREZtZDVESGxacU5FSXRuY0Zlb0sySVVU?=
 =?utf-8?B?bS9tV1R4ZHVSNTVwQ0l1cGNWZXNTOVI2em83dGR6dUplU1EzdjdISEpPdWs1?=
 =?utf-8?B?aVJFdGFnM1ZhbmhzaTFTckducENleURpeWtKWENhSDZhQ2ZBWUlibWpWczIy?=
 =?utf-8?B?eVVvUitMN0k4am9HcVBmTGFGdGxOcnZBVWx3bDFvbmxUODMwazdBa2k5L2ta?=
 =?utf-8?B?REpITEUxWDdSMWFZT0c5ajdBa2cvWTdoRUhyWXVWRXJ2TW1mVEJhMDZCM0J3?=
 =?utf-8?B?T2VIN3ZrYXA3ZmtmZXV6OHVuOHJ1Ykd5OGo1MURwd3dXakZWaDAvak82ZGF6?=
 =?utf-8?B?YlVlSWpNTUdvSFJ2KzBSZnp6QlJGOGozb2lYUkFlNXJWV2hiMFRTU3ZPejdD?=
 =?utf-8?B?aGYzRm41YjgvME1Ma3VxZ28wbEdSckNWZmNKQzczVzhUR2gzOTg1WTI0K3l5?=
 =?utf-8?B?ak5aWUxIWjliQVd1K1VqUHJ5MnJHVnVObzZycFZhaStqZzZzdGxrQnhiNk56?=
 =?utf-8?B?Q3NINytGZXdCeEVIeDVNeWl5NHpNZWJZemdJajNWbTYwamJNVlBPbUN6WTZK?=
 =?utf-8?B?R1B6dlZMQ2hFbHpkalVRSzc0UElxU21qandsTVFDTDRZbWVoek5sZG5lM0pM?=
 =?utf-8?B?RjUzeHpTTkIvZG5FMG1HeGl3Tm55VFJZVURLeXZ1ZlJCVjRjVHBEK1FUdXVO?=
 =?utf-8?B?OUlRZUJzMU0vTER0Rzd6aTNQWS8zSmwxYklUQmdRbDYwY1I2VFNDZVpsQm5Q?=
 =?utf-8?B?WFBUOVE5RWhQZ3VIc0VpMTM5U0JnRjRlakxzSWZFcVpMVnpQVCtxQzAvVVNC?=
 =?utf-8?B?R1NESVZOYmNGS1hrMlhEZHVMc3hnTndnNGl3WlJieFVZM0FqcUNVNGNZb2VS?=
 =?utf-8?B?dmxwUnFjelhvcXpJeklGM0wzLy9CaXYvZ2FnUmpEQlRFTkFyRGtaTFd1eEJK?=
 =?utf-8?B?Q3NlSyswUHQ0YnNJMEREMUd2SlhEMUp0a2FMQ3JwdW11RENnOHBhYjFhWW5Y?=
 =?utf-8?B?RjlWY3hGYkVVTFpxSjA4SjE1b2VSK2w2SlhFY0M5cXZUVXFwOEkyYld3L2o1?=
 =?utf-8?B?R04yM3hUcDBxeWVQc1IvWVZZUVVGb0RjczdpV3ZacWxRbkU3cm9OV0R3YUMw?=
 =?utf-8?B?MDd2Y0IzYWttTVlPcHJ3TXBGZUphalVNNGNqSzdxdE54SGxteWNuM0d1Z3Rn?=
 =?utf-8?B?ZnZFdHYwZlQ1bG5pM2pnc2xENm82cEFSMlVGTEYrVjN1UnFSVy9ONytNdTU3?=
 =?utf-8?B?Z09OdURhZUpaeWZpWFZySkJERnVWd0g5OVordWFzdzFDZFhPVEMrWkR1ZGt0?=
 =?utf-8?B?VnZnNVRHb2lLK3BqT0JSS0VTelJ6RXpLTkN6cWtNdm5XUlRmSHFRUTBSb25U?=
 =?utf-8?B?UU8wOWtIaCtUYW5OcCtGTnkxdkFhVy91Z05la0tFOERvR1U3a2RXK2YrUUg3?=
 =?utf-8?B?aTRzMXlOQlZvUUxDSUVLVDRoRXhIRHRUOEYxb0pZd3R6cHVFK2I5UEdnRzVL?=
 =?utf-8?B?L2oyWUlCRmFjaXQ0SUZGNkdUNkdXOFNxNWo5ZXFLWHJmdGpORVIxVFpldGVW?=
 =?utf-8?B?N3hwVEo3LytWOTNBKzNEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxxaW4yL3pwZlp5ZmNiSTd2eWRtSFEycFNiM3Jhcm1hMWNFVnViSm9mQXgy?=
 =?utf-8?B?R21jb2Qwa2RRQW9YUGlpRlVXbkp3eUhmUW1XNFN0WUkwSWJ5RmhBeGZyR2RK?=
 =?utf-8?B?cG1JYTBVK3ZFU2FqeVl6ZGZkNTdYL29LaC9UeFJzOW9lSkkwZk1WbmZvNEVG?=
 =?utf-8?B?MnJHQUJEMFBxaGhwWVhLUi9ieHJPcTl4dzFwUzZlMU45d0pVYkIxMVhCOUV4?=
 =?utf-8?B?QW4yQStJNEMzZzF2R3dJWUp5M2JRK2pIQnU1N2ZndzdLbjR5QmNJQUVWY05M?=
 =?utf-8?B?YW5oMUVITmk4UDF2ZlF1K1k0SU1Hdldnek9mbW9uN2h6R2pOUERRSVR0RFVP?=
 =?utf-8?B?OS9iWklPa2oxekRJd1B6TzdKSnBwQWdlc2d5K3AvRnRlVjRHVnhKbnExUURJ?=
 =?utf-8?B?di9McVVFTmhuNDhrR09BVktaVmxyVnFTZTNRRmc0RWkrZzBON09JQlNGZFl2?=
 =?utf-8?B?d05OZUhQK1UxRmVYWDZmM0I4OWh0aXlGYzVocHAwWnJHMW42MVJFSXNQaE5x?=
 =?utf-8?B?N3FwR042cklxT3RpMXl3VDFUL0pCMVVRM1JnajZmWWFaZ1h1eUNoellscGN0?=
 =?utf-8?B?bDdtakZNUzd2SzRqQ29jNUxlU2IvWThPZU04cElRNHUxUXlBRjhKOVBRWVlL?=
 =?utf-8?B?KzM3RFM1SXBtOUwyV1U5SGlidFQyRG9iWW5vUHhtazNSaFJxaG8vQWFkVGs4?=
 =?utf-8?B?cUlLS1gvaWhuKzhJMVZaelM5VVVNMjZySTJsNTZrbnlMVXVFcWRUejBONmlS?=
 =?utf-8?B?djFVdUd4N0ZNWkdBb2FoTTI0ZGI2VUMycUFQNlRTaE1IVC82b2IydXVlRnd6?=
 =?utf-8?B?ZUxpNXVPOUR5MTFHMjZkeitvMVBaSmFWUDB2Q0Q0YSs2RmVKNTA5ZHlja1NH?=
 =?utf-8?B?M2NUNVlNU2lxL1Q3MGNxYTZmbDRTT2U2cms1TzNpRnhpR1d6bmY5K21LQnFr?=
 =?utf-8?B?ZU45SzU1aTZnTmY1a1J0OFJOUC9HdHNJaFVGSHBVUTBDSkNQeTNxVS9aUHlX?=
 =?utf-8?B?TUptNmcxUGhMNlgxRG9yd3hWaGhESU5ObVdZNDhMbkkyRWZMZWpMMWJ0NjB0?=
 =?utf-8?B?bVRxQ1Z0Uk1XTS9RZ3AzSlRoQlhITjVzbjlHZHd0aVp6QzVmbkhMVXZma0hw?=
 =?utf-8?B?T01hSjBsNEgrcGdXRHFVRERCOXZ6NXkyNXFiRHkrUmNqeGdDSGZFVVoxTlRM?=
 =?utf-8?B?WU9URElwTmpSdVpzVFlaRnJ0cWlrUERoTkNDTTc4WThUcUpocjhHUUNpNkVw?=
 =?utf-8?B?ZEpKUHpWcWc3VEtCaGd2aFN1SCtLenAyVktseSsweXFaVWNwS1JjV1JySnhy?=
 =?utf-8?B?S0FxOGNWWFJkbFlpM3h2dkRiNDJlTm13b0VmcktHbzRsekd1ck1pVXNmbmtm?=
 =?utf-8?B?MUU5bVNNOHpYdmJGYWJRNzN1NDM5YTkvcC9kMmVMWGxKU3JuQmdBdDEzaHhH?=
 =?utf-8?B?V2JRM1BLZDRpRDVNbkQ4c0hrSFdUd3ZMOFlJaGZlQVlwOWlYcHVza1ZOZ1ZF?=
 =?utf-8?B?MlJZcklWYWZFWlZPbk9yMG1sdG45eE9QK09JeW03RXJiU3ZsYkIyWmNaeVJ0?=
 =?utf-8?B?bkdvLzdjNlRUVXJpSkRhTVF4WENMWnUxWWFhQjUxRjJ0UisyUDltZVhDRU5i?=
 =?utf-8?B?VE1jc202ZWs5bzlBYXI0OFo0SjllL0lFNGlhaHNOb1ZZZ1BHRlZZcERBSGR5?=
 =?utf-8?B?VDVhU2xkc3NBbFBmSkErU0s3Y2FQMDA5clJSSWltc2pjZVc5elRjbVNWdDMx?=
 =?utf-8?B?SENTUW9yWHhycWhUaDRaNnVrTTlGYVRjT0NGN1YrTS9pWElCQ1R6REd0MW9P?=
 =?utf-8?B?KzRWbUdNNi8wYjVpOHpJRVNYb2h3KzRlRVJqenJYUm1LV0IzbjlnM0NKYnEr?=
 =?utf-8?B?bEp4aWsycS9aSW9CdFU5cGd4emtvSkZneDZTV3FndzQweGFiVWR2N1FwR3NN?=
 =?utf-8?B?TkFWNXhkOXBHcENyRldtYjRSYjB4eGpRUk11MzcxTFBjejFyc3Mrb0hDbzdV?=
 =?utf-8?B?SVlNN3c0TFk4eXVMMENxMmlyTzJPRS9sRUQvbFVjcHY2bi9KYnVma3VnY2xk?=
 =?utf-8?B?VzF4ajQ2eWg1cktGekhET0JTT2R1eHVYZnVwUVFoL2RDcXRFTTI4a3RFdHl3?=
 =?utf-8?Q?VCoYXtNubxw8aJERe1Y9sfbru?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c824f44-c8f7-42f0-cbc2-08dcc06a1ca0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:15:16.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MveDaLkm1bHYd2fDaeB+AFLbTpUgli6sGy7qO0kyRX5nQdBtPb32ipygwMfcG0p9+0LVQbdnnkY6f3DzYF+fWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627


On 8/9/24 16:24, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:34 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for given a opaque cxl region struct returns the params
>> to be used for mapping such memory range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c     | 16 ++++++++++++++++
>>   drivers/cxl/cxl.h             |  3 +++
>>   include/linux/cxl_accel_mem.h |  2 ++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c8fc14ac437e..9ff10923e9fc 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3345,6 +3345,22 @@ static int devm_cxl_add_dax_region(struct
>> cxl_region *cxlr) return rc;
>>   }
>>   
>> +int cxl_accel_get_region_params(struct cxl_region *region,
>> +				resource_size_t *start,
>> resource_size_t *end) +{
>> +	if (!region)
>> +		return -ENODEV;
>> +
>> +	if (!region->params.res) {
>> +		return -ENODEV;
>> +	}
> Remove the extra {}
>

Sure.

Thanks!


>> +	*start = region->params.res->start;
>> +	*end = region->params.res->end;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_get_region_params, CXL);
>> +
>>   static int match_root_decoder_by_range(struct device *dev, void
>> *data) {
>>   	struct range *r1, *r2 = data;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1bf3b74ff959..b4c4c4455ef1 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -906,6 +906,9 @@ void cxl_coordinates_combine(struct
>> access_coordinate *out, bool
>> cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>> +
>> +int cxl_accel_get_region_params(struct cxl_region *region,
>> +				resource_size_t *start,
>> resource_size_t *end); /*
>>    * Unit test builds overrides this to __weak, find the 'strong'
>> version
>>    * of these symbols in tools/testing/cxl/.
>> diff --git a/include/linux/cxl_accel_mem.h
>> b/include/linux/cxl_accel_mem.h index a5f9ffc24509..5d715eea6e91
>> 100644 --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -53,4 +53,6 @@ struct cxl_region *cxl_create_region(struct
>> cxl_root_decoder *cxlrd, int ways);
>>   
>>   int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>> +int cxl_accel_get_region_params(struct cxl_region *region,
>> +				resource_size_t *start,
>> resource_size_t *end); #endif

