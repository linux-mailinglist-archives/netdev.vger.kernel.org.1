Return-Path: <netdev+bounces-128489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C9979CDD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA2281C01
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D6139CE2;
	Mon, 16 Sep 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAu6LND3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3F1B963;
	Mon, 16 Sep 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475862; cv=fail; b=aUEoH1rLOnVn1Q7MOyrZ5P+A4wBsDbpVomYSHMVnsFi6X3SWPrhUkm5yaS5fRcTZAOpt9kIP/2DBoRyMIALumLVZt4/DI2KVTQIWg4EbtQgscOfzcEIHzHPI0ZTT/QVE3tHI1mN/j4Ww+wFt/in1B6/ifM22/2PHDrjUAe6XlSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475862; c=relaxed/simple;
	bh=va+24tIgP9XpcoOmVlP7OXiLv1TMCRkk5OZ6be2A2js=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfFqrJDiiiDw4T9Ob7qgg5hah4MX58Yr6s/08X5/R3OFlOt4rLPnvUijAoNwY7Tp2xuPcWT5z2p7RXrVSTifPX6HIG9RcfihKkhmbsLHu44tY+t8z40fcqr484kJa1Ui5BJqCA3NPsXdK9bfSaVTwT1JcRUdD7ETiOBANJGWZI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAu6LND3; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo2cXSIDtjwsk2BvoQiR1QlFzwyVSgxlM2wc88RZAB0nKWrvcYxrnvrV6uiJG8e3s09bRMFxdMMj6sXohyKk8V2Yw0xP4cLm325G0c4dRF+8qdmIEBiZfM182W/mmMtjyd6mBuPoIYFn/zneYGgzbJEjFdpaOqcmtBYfE+uKN2vNx0yd0U+jgPLurz0p63EqNTBqsyXerGwGWVJfGeookDsnlpfDMhCxvdYB1xRdldcdhHZgpWG2HrXeQLWm0nHTRLwDWPQh0lldJKOc+DvTSSQimQvPSbk/vL6tQ3DzzfHEdDLR9PIQc+5/WmIlRoUo+9FdUtoQ1p1Nwxl5hsrkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbgXWc0q3z+Z/bSzCFJwzj7XtJy9TkAtWF3HemNv3ps=;
 b=sylM+5Vox4fagBY581M5cz/REQzXxtc9mDyAuhQyt7k5EQIGNxkq40r5LkwjG9KufYW4/GEZLFf3UYAl2OwQzWwCDrVtSksTK1E7kgnH892/w8mqbX6LE8VhgnMX17iE6AmhOac35CKT6GaZ60WXItSaMeshtpXspNH/YIV7ttaIegNRE5cofeIli/5Mfa9Ri6gJqY+b+EUvdB7KFw3px19heftvYBz7fX3uoWtkbPKCf8m2IL0LBxXNTRHkVP9Of9Y93JDjOAZ9QpB/TlX3F3qZYRim21PJLzrHb+ZqMHZ/VPtuCh2zOrnruqoPQJ5YchbaqOiMEGCdCDXS6cOYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbgXWc0q3z+Z/bSzCFJwzj7XtJy9TkAtWF3HemNv3ps=;
 b=qAu6LND3K666+qs95EMEUFwn+J/csbhdKCdxdsb9B+VOtSes9PmFJjSMdEzPaEPSEW2a/9ie0kwxI4Umt+nAfzHSLYC33BloU4d8beETCwWWQ0Ql1Q0U9t+AKD0+aNbx6lD8PtvWPxPzNM1LArk/L8pc6liTMLOJ3CHkQWmVnCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:37:37 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:37:36 +0000
Message-ID: <7de26804-9b09-165d-02f8-0539bb17608c@amd.com>
Date: Mon, 16 Sep 2024 09:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
 <06cc4873-d841-4a41-b681-e73bd7a3d4d8@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <06cc4873-d841-4a41-b681-e73bd7a3d4d8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d61d4f-e9c8-4440-f862-08dcd62acf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUNsY2M0RkhJajA2RTV6Y25XRzcyNCtQRDlaRWd6ekNlWjFqNmpMU3cyaHVo?=
 =?utf-8?B?NE9HOUxkNmtTVmpCNkRXZzlMd0lrWUQ1ZkpYTTRFOVBhTnBGeGdaYlREaDhM?=
 =?utf-8?B?aC9DYXVuMHJuWUJldHBTZlJvTzNzR01ndWVNVkJWdklSNkJwNG1neUZNY0R1?=
 =?utf-8?B?MGpsRE94R29GR3FkRzJZcy9GMDhSQnBCSW9XZ2JlY2ZNT0grclBNSUZUc2x5?=
 =?utf-8?B?TTBBM3hKdUs1aU96Y01Ea1FMbDkvb0IzYzVIRml1ZVZMN2V6eHF3QXJxWDF4?=
 =?utf-8?B?cldRaUJBZTQ0UnlXaUo3WXo3YmtUT2dielJpRmE2K1VUalFDZElCOWFzaXFK?=
 =?utf-8?B?NlpXV3pKbmR1c3Q2WVlVMFZtYm5oUzRubW9DQnJRcHdVOFhtQ3ZiaW9tMUhw?=
 =?utf-8?B?M0dDU3pZRXVLU1ZGTGllblNMVU1zMjZobUpqRnE0RHFuQjZQWEk3SlU4WG40?=
 =?utf-8?B?REc0LzNlbHBOaU1oeHJDVk5vWFVKZG1CdGQ1a2xxbEQwZlZHZUdzQmJiTWxa?=
 =?utf-8?B?NzNqS3ZUQm5mckFTVHhzb3JBUCs5blFkdDFYWGlXQVI1Wkwya2hBdk8xREpK?=
 =?utf-8?B?V25FeTlaVW0yYWxjWTFUKy9jczRWUVZoaEdvemluODNvcWZHeFQ4dno1THNp?=
 =?utf-8?B?MElEVWU2R1JTK2dyRzIxT3VCZXJWYmg1M0tGbUdEeFNHTW5rMVJLZTgvRURD?=
 =?utf-8?B?Z0UvczFHQnEyRDNpV0JhbG50bVdkdzNBUHpjcXlzMzdlRTk1em00UkRrbkhv?=
 =?utf-8?B?VkVIZVV2bjBHWW1rd3U4QU5Pc1JxTWpscmhwblB2bjhXUk0zcWVpenlIQkYr?=
 =?utf-8?B?K0ZUQThuS3ZZLzRmYjFkdG1lbGVNRXVjdk1zYTFDY0RlZUt1dUFoZkoxZ01w?=
 =?utf-8?B?TlpmcmZpZTlTaEpvbW9xdTMvb0c0R05abmtKeE04dFJtNURjbGtuazRudklL?=
 =?utf-8?B?WlBXVHRTekRybU1McFNIcmVsakRRUmtuc3UzbHdkMnprWDZnRldjMDY5d1lO?=
 =?utf-8?B?NzFCb25sajRIUUhYaENpTGhjVjJlZitaT21NdW9rNzh1a3UyNE85R1VWSVlM?=
 =?utf-8?B?YnNyb3lqc0ZVOEVjMmt5WllQeTNDcGJDQTErY21pWFpsVnNZSFg3TzBmRVdh?=
 =?utf-8?B?d2xwa0NVNGFLVS9WS0F4bFJpb2g4Y2JnODJ2S1RwTmwrU1ZUcWxjNmlKemJZ?=
 =?utf-8?B?N3FqM1pUbFR0SXpLeFFuWXRub2k3NXo0cVFMaUJWR21MQlZsWXBrcHovZFNa?=
 =?utf-8?B?VTROa3NzQkxUZTBUaE9QUVJNZldIbll1eTdJRUpOZ2oxalllWHJtZlRYdllW?=
 =?utf-8?B?RVcvZmgxelJNOW15bGtDUWJoOW9aalJmckhTcnBnTytaMEF2SWR4dHFOM1Ez?=
 =?utf-8?B?K2JvdjVKb28wMVNMaUFrVXo5Tk15aCtkazFnLys0ZHB6S1JGdzlTYVF4aWZ3?=
 =?utf-8?B?MjJMUGpuNytGWW5waTBaRnpSRk1wOWpxY1dmeWxxc1A4RllwbTRUM3B2dThU?=
 =?utf-8?B?ZXZLSFBaVUV6RXMyaW1DTkludzBEYXN3TVM1OVV3ZnFiNjFhYjNwUmxXbGd4?=
 =?utf-8?B?UjBWM1N2QzgrK1dsVWJSYlIzYmhlVlVSYTZ4Ymt4bVB3K0w5QTJobWdpTm9W?=
 =?utf-8?B?OXMxSEU4cExXOTNZakFnVmRFdUN2dEtDdko2b0lJMEl3enFMZ203RkcyQldl?=
 =?utf-8?B?NGhpRDBsM3l0ZlVQbFZ6MDlnVlRDcXphR2pGM3ZHeVhEOGxYeW1TSnZFVUNR?=
 =?utf-8?B?RUswVWU4WEI3MU15dlJYWkJQcDdacTBpbExVdHZud0FHMFFBeGZDZTJoeE15?=
 =?utf-8?B?bTg1TG5DOWp2YkRRL2VubnFTZ2VjOTY1MHlKRkdUQ1AzaHFSdXBqTFRWV2hG?=
 =?utf-8?Q?i/6i0nJk9dZFi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlDYWtyaWRGcHFpeVBvZG4yNVV1UzhmaEE0K2p4TGlYZ0FXT0ZoVGVXc2dD?=
 =?utf-8?B?RmhZUkpiUnp1R0FpbVNhMUNnZFViNitXeGh5aG9BM3crU1ZJd0NwM055SndW?=
 =?utf-8?B?WU5UZlRFNTdtUE1vRTYvdzkvYTBpRVJ2UExLYTlYMW0ySzk1T0lBeGVmMjZ1?=
 =?utf-8?B?a2JWMjBxNW1YenRXcE5ra1d3eGxXb2RqU2U3Z0NETk1aNVcvMXRzRXdmMy9h?=
 =?utf-8?B?UlJoVW9rY0pseWVPUDN5TkpvQjEvVWxoZkdZeThMd28yVE9obmRQempCWUE0?=
 =?utf-8?B?NkhSN2kxakxXKy9naXdSdlB6ZHJabTU5RTdCcFNZYXpTV0pXTHRuQmNwOENL?=
 =?utf-8?B?bk5oaDg3TEVaandvVnNmOTRqYjhZbEhocElsNzliNWo1M0RXWU40R3ZvK3E2?=
 =?utf-8?B?R0hoUGt5aTd0NlpHWWlkVFNZOFZXS2tuOXBIaWo2Tit4UzJIR0pLV0pJVTRz?=
 =?utf-8?B?aGlidDEzU2I5Ym9qeDdqQk5ZS2NNYUNyQmNEREg4cWdjSlFEeGlQbzFsSHFH?=
 =?utf-8?B?WVN5RG1jTURIRmFVemhiSTA0YldCckU2eUp4M1MvYnY0eS9LMzFMT3J1ZlFQ?=
 =?utf-8?B?eUNpS05RR2tYem1kYWtSZUFBcHhVRTNnQ3V6S1NmWEdvZ1N6V3AzZmV6N1o5?=
 =?utf-8?B?bnl5VmJPblBaSHhDbU0yeFREeC81MVkzRENqQnZJQTJTTHZMcC93bjZhU3Ba?=
 =?utf-8?B?c1htZGozOTh0WlZZcW5jN1JUaktkTnU0bTdOcVU2c2tZRjUzWDg2cmgyTGJR?=
 =?utf-8?B?WEp6U1Q2cFA2V25uOXcvUG9SZ21LUnhvelk5MldUTVdhSFBkNUZKV25ySjNN?=
 =?utf-8?B?M3ZpK3FidXNwL1dwN1dOSENqSWJTbldPa2JWUDZmdWVCZGp2VTV0S1JKZTB6?=
 =?utf-8?B?SFJXRXh6dWpzNzBoOW9uVlFsUHVpeEpaSWhraDNaM1ptSFA2MHFCMEdQbllQ?=
 =?utf-8?B?ZlRpZ3VXQWZoYWU4aFBPbUxYS2dzR2pPTXdaT3BGRThaNWVld01iZXpuWkhr?=
 =?utf-8?B?SlVwd21WT0V5VWl5SEl0d2NleTRqcUU2NEdsV0pBUkNwTEJibGh6WWhJNTZF?=
 =?utf-8?B?Y0pKTC9kZnZ6Q0xsN2JERFQ3RDY5bXRMVG5xNWliSHV6ckI1cmJtY0M2Qk9m?=
 =?utf-8?B?d3Q3Z1FuOEc4YTZLTnZzMk9kakVGSkgrRVlqcXlTN3BFZGVsRUtNengyUnV4?=
 =?utf-8?B?MHpIaEJrOFNVSmVSTk5XUzBGRVdzeTZsNmU3NU1RNU5DU0E1bnFpczZxc1JO?=
 =?utf-8?B?Y2h5Ni83ajA5RDNSYTRmRnVaeGRoVHVIY0x0aGJvL2Riano3ZTR1Vk5sUStj?=
 =?utf-8?B?NVo3Rmc3MDhlTzAycXZackpZVFdmSFJxdGZQQnZwMHJRVHZOaWF5dXMza1lR?=
 =?utf-8?B?aHM4Rmo3SlRzVUpEWnBYSjczTXJnL3RBNHRUQ25KRVJYVmdvZ2NaYXNhLzBk?=
 =?utf-8?B?YWxZU3BNUHNEQ0R0WU5Vamo2RDVtUzlZMk1EVCtSV2pnUnJGWlpTejlGUWw3?=
 =?utf-8?B?c3UrVjZrWEErc2dLd1krU1ZXbHQvNUp2dHBrWDdEcWNyWG1XeFpyV0JCcS9k?=
 =?utf-8?B?RFZIM1lwOXN1aWxTdGN2U1cwNHBzRXd0Rzg5QVNYcm1maEZ1QmdHbjRsVEJ0?=
 =?utf-8?B?TjVaTVp3UXphS0VmdGsvbk40Yjd5d3dpMTRPYnNvY3pvb0hEb0NVWUt6Rnp5?=
 =?utf-8?B?b0x6YlpDQSs0YytTUjg4dXJpMjdPcTNrYm83UzdidUxyM2wvMU9Wck52a3Fs?=
 =?utf-8?B?Y1FpVEgzZGdUYnlUK05majY0bUpyR0dLTmtmZlVEdFg0OFF3bklZWkVzaWRx?=
 =?utf-8?B?NG9wM3VxSDJ1dWxQS09qRzFOZnEyK1RJTlUzNkFCMEVRbHhidTBtMWthbUQ2?=
 =?utf-8?B?bmZtR0ZqSHlCU1ppZ0lLRUN1bTJqTG4zZDRLdlQyOEI5Z1pOZjFISUp0YXgr?=
 =?utf-8?B?YU82VzBHOWNncnhRTmM4TWQxeXJOQTJhbXZKQnY5Wll2QXlOdUNmaUszVWpO?=
 =?utf-8?B?M0VYWXAyNG9QN2hJZ3QwZ2tRT2hKYjU5aE9lMnhlMXZKOU8ybnVpWjR6M2c4?=
 =?utf-8?B?aWFJdmk2RjNXS0YyYnN5UzJ5QUFoS0o0cnV5MjFROXVDOVo3Ri9wQW5EdjlG?=
 =?utf-8?Q?US5XYKOXtFe7u7Zw/Q0vV+Eoa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d61d4f-e9c8-4440-f862-08dcd62acf36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:37:36.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwlV8fA2vPQzyy69jPZc1AbgjH524oPLft9X4MVlOvsbE4Un01+7MERmEMLqyUyQw+4w8iaBV3g5FAFLqLEF7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736


On 9/11/24 23:17, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field for keeping device capabilities as discovered during
>> initialization.
>>
>> Add same field to cxl_port which for an endpoint will use those
>> capabilities discovered previously, and which will be initialized when
>> calling cxl_port_setup_regs for no endpoints.
> I don't quite understand what you are trying to say here.


I guess you mean the last paragraph, don't you?

If so, the point is the cxl_setup_regs or the register discovery is also 
being used from the cxl port code, I think for CXL switches initialization.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/port.c |  9 +++++----
>>   drivers/cxl/core/regs.c | 20 +++++++++++++-------
>>   drivers/cxl/cxl.h       |  8 +++++---
>>   drivers/cxl/cxlmem.h    |  2 ++
>>   drivers/cxl/pci.c       |  9 +++++----
>>   include/linux/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
>>   6 files changed, 60 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1d5007e3795a..39b20ddd0296 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>   }
>>   
>>   static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>> -			       resource_size_t component_reg_phys)
>> +			       resource_size_t component_reg_phys, u32 *caps)
>>   {
>>   	*map = (struct cxl_register_map) {
>>   		.host = host,
>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>   	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>   	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   
>>   static int cxl_port_setup_regs(struct cxl_port *port,
>> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>   	if (dev_is_platform(port->uport_dev))
>>   		return 0;
>>   	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>> -				   component_reg_phys);
>> +				   component_reg_phys, &port->capabilities);
>>   }
>>   
>>   static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>> @@ -789,7 +789,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>   	 * NULL.
>>   	 */
>>   	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>> -				 component_reg_phys);
>> +				 component_reg_phys, &dport->port->capabilities);
>>   	dport->reg_map.host = host;
>>   	return rc;
>>   }
>> @@ -858,6 +858,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>   		port->reg_map = cxlds->reg_map;
>>   		port->reg_map.host = &port->dev;
>>   		cxlmd->endpoint = port;
>> +		port->capabilities = cxlds->capabilities;
>>   	} else if (parent_dport) {
>>   		rc = dev_set_name(dev, "port%d", port->id);
>>   		if (rc)
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index e1082e749c69..8b8abcadcb93 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. */
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/cxl/cxl.h>
>>   #include <linux/device.h>
>>   #include <linux/slab.h>
>>   #include <linux/pci.h>
>> @@ -36,7 +37,7 @@
>>    * Probe for component register information and return it in map object.
>>    */
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>> -			      struct cxl_component_reg_map *map)
>> +			      struct cxl_component_reg_map *map, u32 *caps)
>>   {
>>   	int cap, cap_count;
>>   	u32 cap_array;
>> @@ -84,6 +85,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   			decoder_cnt = cxl_hdm_decoder_count(hdr);
>>   			length = 0x20 * decoder_cnt + 0x10;
>>   			rmap = &map->hdm_decoder;
>> +			*caps |= BIT(CXL_DEV_CAP_HDM);
>>   			break;
>>   		}
>>   		case CXL_CM_CAP_CAP_ID_RAS:
>> @@ -91,6 +93,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   				offset);
>>   			length = CXL_RAS_CAPABILITY_LENGTH;
>>   			rmap = &map->ras;
>> +			*caps |= BIT(CXL_DEV_CAP_RAS);
>>   			break;
>>   		default:
>>   			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>> @@ -117,7 +120,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>>    * Probe for device register information and return it in map object.
>>    */
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map)
>> +			   struct cxl_device_reg_map *map, u32 *caps)
>>   {
>>   	int cap, cap_count;
>>   	u64 cap_array;
>> @@ -146,10 +149,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>   			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>   			rmap = &map->status;
>> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>   			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>   			rmap = &map->mbox;
>> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>   			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>> @@ -157,6 +162,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_MEMDEV:
>>   			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>   			rmap = &map->memdev;
>> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
>>   			break;
>>   		default:
>>   			if (cap_id >= 0x8000)
>> @@ -421,7 +427,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>   	map->base = NULL;
>>   }
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>   {
>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -431,12 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	switch (map->reg_type) {
>>   	case CXL_REGLOC_RBI_COMPONENT:
>>   		comp_map = &map->component_map;
>> -		cxl_probe_component_regs(host, base, comp_map);
>> +		cxl_probe_component_regs(host, base, comp_map, caps);
>>   		dev_dbg(host, "Set up component registers\n");
>>   		break;
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>> -		cxl_probe_device_regs(host, base, dev_map);
>> +		cxl_probe_device_regs(host, base, dev_map, caps);
>>   		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>   		    !dev_map->memdev.valid) {
>>   			dev_err(host, "registers not found: %s%s%s\n",
>> @@ -455,7 +461,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	return 0;
>>   }
>>   
>> -int cxl_setup_regs(struct cxl_register_map *map)
>> +int cxl_setup_regs(struct cxl_register_map *map, u32 *caps)
>>   {
>>   	int rc;
>>   
>> @@ -463,7 +469,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>   	if (rc)
>>   		return rc;
>>   
>> -	rc = cxl_probe_regs(map);
>> +	rc = cxl_probe_regs(map, caps);
>>   	cxl_unmap_regblock(map);
>>   
>>   	return rc;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9afb407d438f..07c153aa3d77 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -284,9 +284,9 @@ struct cxl_register_map {
>>   };
>>   
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>> -			      struct cxl_component_reg_map *map);
>> +			      struct cxl_component_reg_map *map, u32 *caps);
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map);
>> +			   struct cxl_device_reg_map *map, u32 *caps);
>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>   			   struct cxl_component_regs *regs,
>>   			   unsigned long map_mask);
>> @@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   			       struct cxl_register_map *map, int index);
>>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   		      struct cxl_register_map *map);
>> -int cxl_setup_regs(struct cxl_register_map *map);
>> +int cxl_setup_regs(struct cxl_register_map *map, u32 *caps);
>>   struct cxl_dport;
>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   					   struct cxl_dport *dport);
>> @@ -600,6 +600,7 @@ struct cxl_dax_region {
>>    * @cdat: Cached CDAT data
>>    * @cdat_available: Should a CDAT attribute be available in sysfs
>>    * @pci_latency: Upstream latency in picoseconds
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_port {
>>   	struct device dev;
>> @@ -623,6 +624,7 @@ struct cxl_port {
>>   	} cdat;
>>   	bool cdat_available;
>>   	long pci_latency;
>> +	u32 capabilities;
>>   };
>>   
>>   /**
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index afb53d058d62..37c043100300 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -424,6 +424,7 @@ struct cxl_dpa_perf {
>>    * @ram_res: Active Volatile memory capacity configuration
>>    * @serial: PCIe Device Serial Number
>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_dev_state {
>>   	struct device *dev;
>> @@ -438,6 +439,7 @@ struct cxl_dev_state {
>>   	struct resource ram_res;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>> +	u32 capabilities;
>>   };
>>   
>>   /**
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 742a7b2a1be5..58f325019886 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -503,7 +503,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   }
>>   
>>   static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map)
>> +			      struct cxl_register_map *map, u32 *caps)
>>   {
>>   	int rc;
>>   
>> @@ -520,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   	if (rc)
>>   		return rc;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>> @@ -827,7 +827,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	else
>>   		cxl_set_dvsec(cxlds, dvsec);
>>   
>> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				&cxlds->capabilities);
>>   	if (rc)
>>   		return rc;
>>   
>> @@ -840,7 +841,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	 * still be useful for management functions so don't return an error.
>>   	 */
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> -				&cxlds->reg_map);
>> +				&cxlds->reg_map, &cxlds->capabilities);
>>   	if (rc)
>>   		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>   	else if (!cxlds->reg_map.component_map.ras.valid)
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index e78eefa82123..930b1b9c1d6a 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>   	CXL_ACCEL_RES_PMEM,
>>   };
>>   
>> +/* Capabilities as defined for:
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.0 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
> Should just use 3.1 since that's the latest spec.


Ok.


>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_SEC,
>> +	CXL_DEV_CAP_LINK,
>> +	CXL_DEV_CAP_HDM,
>> +	CXL_DEV_CAP_SEC_EXT,
>> +	CXL_DEV_CAP_IDE,
>> +	CXL_DEV_CAP_SNOOP_FILTER,
>> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>> +	CXL_DEV_CAP_CACHEMEM_EXT,
>> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
>> +	CXL_DEV_CAP_BI_DECODER,
>> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>> +	CXL_DEV_CAP_CACHEID_DECODER,
>> +	CXL_DEV_CAP_HDM_EXT,
>> +	CXL_DEV_CAP_METADATA_EXT,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MAILBOX_SECONDARY,
> Does the OS ever uses the SECONDARY mailbox?


I have no idea. I'm just listing all the potential capabilities here as 
you can see for things like BI or SNOOP.

Should I just add those referenced by code?


>> +	CXL_DEV_CAP_MEMDEV,
>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

