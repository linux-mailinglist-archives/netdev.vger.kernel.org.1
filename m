Return-Path: <netdev+bounces-237171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC2C46765
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5204E7CEA
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167F30C36F;
	Mon, 10 Nov 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IyehJ9ue"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41342FD678;
	Mon, 10 Nov 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776512; cv=fail; b=Q4DVMxz5rO5EHB7Ll6wZpLwO74lf40TRUhYhUalFDY03F5sfQeohjG8Q5DMLPhNzmhER1LNTcmKly1Pvb9g9qUsogr+I6L2RMLEvWRO7PNM8A9gBvq5yvfgguaovZRw/+EDy/UXDPQ6wYzONiwYHHoL/G+hBMPVQ7LUJGuQWBHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776512; c=relaxed/simple;
	bh=nJIuog8uC+g6/p613c5/eaUFfejnFBIKjcGAetzfKyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkpsjiPeRlza7oLrmm5skmlsEE+n22zKeE6GGqhYXPcjabWatgL+twnY6wWc0YgRpZqmm5BgzEpCN9JTpUXVk0YefAaAsyB+4l3IeKQhmiFGP0OMC/HCUyn+OYFsSfXPsSWCDB81cxea/lcksv0FrnHQ8EboOIK+hsutHVtt25Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IyehJ9ue; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqs5u7F/hFZVCojCAbPgwptkAFvAJcOmbx/QyONWw4hVaPNmF4UQG5Aw+zFR3b4TIg69Y+gFq3mfpBvhpxhxx7ER7oUnl6lWzHiI7jm1XqLsBrA6BSg7obYi8ukkGzWeNkYK5kDUl1cLkOuVbE6cKb/9zEY7DGAXdRhJGN9+HIKragprT78SWeTF4Nd2vRrdSA0uabxXDIo+7pfJ4C0b3Xb8wBPXfRiWunEs6W6SNL2PCblGN3l1LhMihm5OJnEZdQi4e0uBYETq7ScQW8jFBbcnkpTwfT8jPBrTBSapiNOZCU6ynYVyMBUaAoBESP/DE5cBNoScBnyqvT/CeY8Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60BowCdFde/C9az9mSLFlw9JIGkLDWirmpr4tki0Vuw=;
 b=DOWXfTfZxY4pwLxd7TkY1tQ+pnzynBpyzkcwntwVr19lk9MQ1Nptn25+iUk6aSPEXvUL1KslEdPU02x+P/VZjM+1FBLL7gP8BPUP+yFad9zeH9MDxPmzJzZHvCcr8HZ4h8jgOPpO2yCzbyF5fIAy+0OAHL8vY4ULlL7UWh0PtHOMw4D2g9VIc9Tkqr0SLhH3pnIkVHLOHolmgHPgpt0zPYISOV/YPRBCshL4omvnuypu7pKPDlDHoa5ybBQfbmBfrdYILpmswfsiAcomGlGRrCHhO19yuhElUCbtw5MO1DL18aWDm9TCj6lNQWONtiP0jR8yH59/EJcZKn7WNUI8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60BowCdFde/C9az9mSLFlw9JIGkLDWirmpr4tki0Vuw=;
 b=IyehJ9uepjh2l/u9kffg/NQB9ISChiU5AAFU+xQ0OQ44at69gfyC+E8xwbb/0sz85HhprNmSr2sHxAimyddJK900lxPiS3+zU0jge8wFi/KR/cCFXOXxdgbf/a0rK4yMigPsawTA2zt4P53kfs8f8UShitu6K0HBPUdrnbBzboM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:08:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:08:27 +0000
Message-ID: <2be540bf-ea3f-42da-93f3-0dd35eb7a6b7@amd.com>
Date: Mon, 10 Nov 2025 12:08:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 14/22] sfc: get endpoint decoder
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-15-alejandro.lucero-palau@amd.com>
 <c9941eeb-045c-439a-ad1b-d0d6820eb7bc@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c9941eeb-045c-439a-ad1b-d0d6820eb7bc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e217e7d-ce8e-413c-ed75-08de2051db13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWpzQjdVZk55bEYyOG9XdVRzSFYzM0ltcEZpVjNxSEdzUGtOVTRKby9yK3Ba?=
 =?utf-8?B?OFJHczFBSnltUDA0N2s4UTFTc3M5emJCN1hCRUZWc3REQzl4MGZibFRzV2ZL?=
 =?utf-8?B?WVV0elh2T1hlSmNLNHI1VmhDQXF3QXNSTTdneXN2WlpCVHdWYyt2VWlwNzFo?=
 =?utf-8?B?eWNaakVrSVBlZklDVjZWQ21ha3ZraVVUUE4yWUIzU25sOEJSNEtOSVNFVWp0?=
 =?utf-8?B?Rk9TdnlVOFNOalFDMHVmenllcy82eHhPaHhhTTltUkY1dkxmVWxIOUtGcG1S?=
 =?utf-8?B?d1dhb1J6K3dJLzBCVndHeUZEajZ2VkI1N08zZVppVnNVYVV6N29UZnpUUnM4?=
 =?utf-8?B?bHlYOTN4WnluYTZTMFlXakFSUFUxVUZEZ0U1SnF5QWFMQXVZb3l1bDBrQ3hK?=
 =?utf-8?B?NlVZOGlzT1ZZaklKUXFqakhpZ2NSWGsxK2hjaGt5MUp6QVhhalozbnYrSm5l?=
 =?utf-8?B?T2pmRmRtSDBDWEJFZzNVcHJmOXlpaUJTL2dEWGJzQUw3N0NROW9QeTdLeURF?=
 =?utf-8?B?MkZ6ZzRjNzNTS2YzekVFbE9XMlJvQmJ1OTdjeWUxVHpOM0ordEJ2QThCSVc1?=
 =?utf-8?B?MDJsYjhTelA0ZTNRTGUzdWdGZ3pXSWFaWXJkQm53TWcvVS9RNXk1cGkvb1pM?=
 =?utf-8?B?c2xLQmc3Mi9xN3NGWlhaR2ZldFFjWGtaemxpWlE4emRFSmtOSEdnMzQvdWFq?=
 =?utf-8?B?TXFlR0dZc21seFRiL2l5Y0N1RzhZMms3SFcwS0sxcGF3eU9WUmZVbUdGbUpU?=
 =?utf-8?B?Z29uVmtyZUZuT0Yva2p0QzEwRktwcUpvY2hZKzF6MWxnbVN1V2RneHVwM2pz?=
 =?utf-8?B?ZXppZ2NRQ3JEM2h5YUV1T2hKdVdNQjlkbE82ZmdsVjhmMysyd2EwN3NoU0d0?=
 =?utf-8?B?NDF5K2RaQ3BLZmxKTklEZjhVU2lyR3I2b0wydjdJV1c0WVlrYnpWVUZndjkv?=
 =?utf-8?B?Nno5NmZYT2x4dml2WmlwV3NuaWpxV0RTN1pVdFR0ZzhKa0k0WnQxNVpQSWxo?=
 =?utf-8?B?Mk9qODBwdW9jQXo5RUhmZWNaclNlYTFGc2tKS0RKNmE3aVVacTViVmxQVmw5?=
 =?utf-8?B?Q2lmVzZjWStqRGVPQ21sNTF2c3pjdGhWL2w2L1RXcGRrUURuOURGaXNLWlVI?=
 =?utf-8?B?bFg3Qkt3WG9Bb1VMOVJrR3U4dVR4amVUVmUwS1B4WU1KMGxpZUN2OVViZHJ5?=
 =?utf-8?B?VVB3MGpZbVB6RmJic3RrQkR2MHh2cnp6VlAvS1RBWUppUTByeWhZaXRWSWZp?=
 =?utf-8?B?Qk5NQXpRT29uRzJoTlFxV3ppNDFXb254ajBTWUE5M0pFRjJxNExVNHBBaFl5?=
 =?utf-8?B?M1hOQjlpcXBhMy9EV0hScktiVFBFcCtOYWVveUZZaFVhenI4RjdreGtHZWcw?=
 =?utf-8?B?SkFUMkd2WHhiODNvaTdwcWJCb1A3NEVYWXJKL1NibWRqQU1XSklOR2JUVHh2?=
 =?utf-8?B?N2hhaTFJQWp2Y2hBeTBKdjZJUVZmQjBXV0pQUXhEdG9WazFGU0RrVUo0bmxV?=
 =?utf-8?B?d1FNQk9jMFcxWDlkNmEzUXRMSTd0akNJY1FWcVRWeVdWMWNJakwvNFIyTzIw?=
 =?utf-8?B?T3BrMXM0VTRwcHlIRXlxeUVWTndYSlIzcnNBM2tjMGdhdnJnZlYyVi9KZWpO?=
 =?utf-8?B?WE1ZK3FnK3BLKzVySC9odXdSdHAzTkoxQWJ6eVhnWGt0R1dVQmpOTGhjVi8v?=
 =?utf-8?B?bnJOSml0NDZ6cUdlQkFtVkE5Tk40WWs4SEwyaUg3ZlgwT1JER043VUN3VFVL?=
 =?utf-8?B?ZnBOdTZ5SEJWbEdjRzcrT3YvaVBRN2hJRjBTaXcrTmZUZkYydVZuTDI0bVcv?=
 =?utf-8?B?OFpwdldEUW5RMXl1dms4MjFGLy9QTmp6d2ZDSE9DVzlEeDM0MlNTMHJmbmpN?=
 =?utf-8?B?aWZNckhLUmlranRXSU96OUltNndIWUxtUERIanh4UHhpeXpiOEdLMk5Udysx?=
 =?utf-8?B?SGtOZkxuUUNUUEZqeWRWOUZKTlh6eG93QVd1WHVnNEJMMk9YaUU4cmhYa0E4?=
 =?utf-8?Q?rxDjv3tHQkHJFPVPAoquf5PKNOyYEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xaeHRqMWowczZ6akkzclR6dzQyWG1rOFFzRDlldFR4VWs4cUpGdTZUcXp5?=
 =?utf-8?B?MVJnTCs3UERSWkZZUUptR3hhNDRHV291RVpIMm5wdXNQK0V1aStoMWdjWDBV?=
 =?utf-8?B?R3hLVlNTVzRYQjI2cnlsM3R1RVVEYXMrRW95NU96cjBUK3AyUXpudnJBNHBV?=
 =?utf-8?B?elFnRWRmNUxkZ2c4eDI5NWlwUHRhZDVWektOSEtoZTljVDU3T2RSTll1aDhQ?=
 =?utf-8?B?eWRpOHd4OE92TkFpTkM3R090Q2ZwekkxU1EvenB6ZFlrejd0NDZoOGltNU9V?=
 =?utf-8?B?NzRHM0ZHTTQ3R1IwVmkrSzViY1VjdDYrUUVEaG1yUDJXQ1A0WkEzayszSzBV?=
 =?utf-8?B?SmtDazdLRDduWExZR2xCTGFjc0ZGU1JFaUcxMjYyUDN1WDdlMllOMm1Gb2hW?=
 =?utf-8?B?Q3JGT3RrOEtJSGVzUnBndnphZmJmMU56NU5QcVA1eCttMkl3WUZwc3Evb201?=
 =?utf-8?B?YWNsR2lDK0Z2cjZwK243TzVlZWtIZjdaSzBVRE83a3U5V0M3b0h0Y2RQRTgz?=
 =?utf-8?B?QmNSRk10T1l5azlWMCt1MVJQWW5la2NOS2JPelYveTVTdEUrcDQ4K3F2TVdC?=
 =?utf-8?B?UzJSYmNEeXVuV005dkRFWFNjc0JjdWt2UGY2dnhueWVBMG84NHJkVWZ3TkRR?=
 =?utf-8?B?amdia1pBMXR2T2liY2NHV0dIeWJNa09CenNDKzFYZGhOQnUwV2J0akg4SDJj?=
 =?utf-8?B?MVl6MGtZdFdOcjN2Ymd6TzNRWWd4RVpjQWg2ZyswR2VqSkRqS2NydGZ2UHFJ?=
 =?utf-8?B?TjJMWEI2bm5JcFF4azVuNnRFMXpjaXJmT1gwWjFHazJuMm1TZ1ZLY3hYZS9j?=
 =?utf-8?B?ZlR2bmg2Tm80eHAyWndzdmdKWW5WZHlFUGV0Qy9sSVZrNXZDbGFvaUJYN3dL?=
 =?utf-8?B?M3dQaE1sSTFyOG9BRG44VDB0RCt6cUFJVWQ0cjhtWHdURURGUWREU0JEQVF5?=
 =?utf-8?B?b25Xbi9FUGtqbFZUZEZFVkxrcXU5NXNjSW5BQ3lsalk3bFdVUGQ5UFhSUFQz?=
 =?utf-8?B?Z0tEWWZKK25ybjlqam5zQXpjTmNDUHlQTVFPNi9CbXpmUkpzRDBxdmlCMkdH?=
 =?utf-8?B?Zm5GdzlteDIrOXJaUzRQbFRDNWZMM3JiOGpUTHdNSlJGbWR3MmRWcHNZYisw?=
 =?utf-8?B?Z1QzRlRmYkUwM0JkcFhWQzJjYzVOSmZVVzhNN0U5WDAySWF0Q2UyYXE5RzU2?=
 =?utf-8?B?NnZuRDZubDNSVlpqcTZTQXJIMUQvOEd5TE5NZ3dHaGpyam1VTGhvZUlaeEE2?=
 =?utf-8?B?ZlhVL0FoQSs3RG42UVZDNERCdkhpNCszdXZESEFKcm5TWkY4RFRwSTBFQ1lB?=
 =?utf-8?B?VFBUNjkxK2xCY3VDbUZmaU4yRW5ndGQvdVRLRjdaQ3FWVXg5OFVERE1RcEZj?=
 =?utf-8?B?Y0lsM2syVUNscTdKVTM1cUhUVkx4K2VTd1FMM0JyOU1iOW9US3FzM1RoN1Nv?=
 =?utf-8?B?RENSVFplWnFkWFdTdGFBRzgzdi9uLzNpZkFjWGMyR0JwQmprTEdqZGFIUFAw?=
 =?utf-8?B?SzdQTUh1TVlQZnFFODRub0MwbHBVanV0ekVIMEllcEJOK0JCY0ZuQlZaQ3ZS?=
 =?utf-8?B?OTA0Wm1ISWZlQStiNnk3a2cxTCt5Wi9sT3RYSjM3S0hDcjZOLzYzeVdtUlAw?=
 =?utf-8?B?bmJGemJYa24vR3NnSFlhOG9vU3JEazlRY3ZMK2kweXdYL2c1SWl2TU5wVTZa?=
 =?utf-8?B?YXBFMXFpdXc1VHFIc2NQMmNHa3FQMGRvN2FWNW1SOFhnZll5MEUzb25sTmsz?=
 =?utf-8?B?OG94ei96ZzNVUWxyNlVRVEYzY1lsT2xhaTRJQnAzWjRYaXVCUWV4aGFJczBq?=
 =?utf-8?B?TSs0Ull0U3hMQklMaTM5RzA3YzM2eTltN2JzcnZhNFo0UW4zZmg4b082bXJ2?=
 =?utf-8?B?R25IM2ZWS1JBU0pRQlNQcnFXU1lTenpIWXBpM2hCMG5CWlVpUyttdnZxNTMv?=
 =?utf-8?B?SkJZZ1dMWGRVZS90Sk9kWnJ0MUFVQ1RzVmd1V1FkRnNzRnBQSDdKeGo5Tk1Z?=
 =?utf-8?B?WHg5cittVWdQRWtlSUhDUHVMckU1N3pqc0orTGpwNStCWUJlRVE1WjBKVU9Y?=
 =?utf-8?B?dThNYXFYZkhYRWk0UWRkaXFTQTdCSzJ2VlJYWUNkS25jVUZCdjJWMENtMTlv?=
 =?utf-8?Q?Lo1YBksDeiwl24H2k/e4U6yuQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e217e7d-ce8e-413c-ed75-08de2051db13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:08:27.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5RqHGN3YR1XjWSL+SDlXF7XghCiW/md1FAK+P/JBg1hohtzCvdPbUFJJTq4i+ltdjHRPow04E2KBN4IBtgFeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004


On 10/15/25 21:15, Dave Jiang wrote:
>
> On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index d7c34c978434..1a50bb2c0913 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENOSPC;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR(cxl->cxled)) {
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		cxl_put_root_decoder(cxl->cxlrd);
> Might be good to create a __free() macro for freeing the root decoder instead of having to do this for every error path in this function.


We are in netdev territory here and this is not recommended, so I have 
tried to avoid other uses of this kernel releasing functionality here 
since the RFC.

Thanks


> DJ
>
>> +		return PTR_ERR(cxl->cxled);
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> -	if (probe_data->cxl)
>> +	if (probe_data->cxl) {
>> +		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>> +	}
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

