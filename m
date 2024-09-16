Return-Path: <netdev+bounces-128488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFB979CC0
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E065B22A8C
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C113D28F;
	Mon, 16 Sep 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ml2O8ih9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F713FD83;
	Mon, 16 Sep 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475141; cv=fail; b=KCmJjNTz0dYfhbjlqR6oxhVRyG4jqNZxocH1riVfWlCA7R82iBpGuX5oseW2G5Hls31I+nhT0lbORSyTl3iudknV6SpON8qyW7qRcHu03PlOtq8eVL0CHKklCpXGA7x0C3PDqg0Zm7bgq6WhQ+oU9kodY1xJXL+cMv2tCmMHkiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475141; c=relaxed/simple;
	bh=lnP1W8zD+T/VjqYcI4MBkIo6xPXdQTox3iH/s9/phGs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2SAB5H8fIYvCMyS86xsGrHW5dYsLzuqFgyhTyV5aseHeoMTKaphplFBqkgAIK7E6Gk6ZfD8VLvae4b2lKGlG3nD6K+nHWjsyU0v3lsQlsXFQS1FMNPwmWxchelyXR10ASpv9E+VVE2FySRx2JUtu+yFPVz+i7gD0WHBP+PsOZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ml2O8ih9; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMnDCBL1e/soxJmN2Wc29UroqVINzkCnBTqMWQTAL4nVYTBSgvxepDdegEwmlfGgGvV/AXt5melcWAiio8bqVTjIXv8P+yQIrNKaL4QSSS5+AAukzGb/BBWuN2221zmuXOltmxGWZZHCRMujFDO0tX8SMF0xNQ2BawTX8J3wYF5DnRu2MhtPKtK6woDCHmR/aOiquJi2iEGATqCMaxf1G/GSE4cvLRUWKM95DLNiGh9CFyAjQssa+gtwU7zRnDaE8r44fp4EIsSN41RQHvL//6d0he1qh3Cfkzm3eAu67E0wAHy2v8oDzZcCQbMC3QRFnt8Ow+P4vlLmMTmFU76GqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+jSt+TqmZKb15xi9PN1TuSn4MDsC59aBbuGUuqgj9I=;
 b=pFyzo8Ko2qvuuy3C3bzsIcEoFqp4da7YSbi//tXX7X40fy2AcWoYzYTvLQy1GDyAWInTxk1bJcGJ0x1X1ZylGUwvNFjbBvIRt5ggoDD5VHaI0kWvXaZ6mdHhxTYkX/JjHP554k0oWUoi7wc7OQfCLsMgyMIvRuVW1G7qoMqM8+A4OvSXS3Si3vcIf1VjcTsZO6oWJoIdVAwwAVQ+FVfLkwg1pvY/1yQN8Pc6xyFBG0YjXxkcKuCLYFKyv1sr4nmcjYujO9FhaclhRDQss3ufhlgsp/DtZOYxOYN6k7pa3Jg6W1o6TYC8zS3XXeamtohgJg7azmWbKKe/XN+o947Jbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+jSt+TqmZKb15xi9PN1TuSn4MDsC59aBbuGUuqgj9I=;
 b=ml2O8ih97m+zAKyfB5MC2ZYuuMEsV2YKP2tOm48yXzSPXYDyOjMLlXDBbKUk5/tR7yphMHWWic0oAr76Qd+9hl34tPrfbsk6P1yTgFaSORkKbkrrDGREar94Z2Jm7gH6RlRum7BGcpH/iau89iCrF3WKnH2hI6FE3do+m7QTIWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:25:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:25:36 +0000
Message-ID: <cfffaf6e-3044-a389-f4e5-6fbd50ecbdd7@amd.com>
Date: Mon, 16 Sep 2024 09:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
 <920a9258-650a-454d-b45d-673b7cfa1e56@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <920a9258-650a-454d-b45d-673b7cfa1e56@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ff9000-af8a-4bfe-05e2-08dcd62923d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmplY0tBQWNQajQyOWQ4bEdEYWRaZ1hpTkJac042OGo0WldTUmkxckowY2Qr?=
 =?utf-8?B?WW9vNkNCZ05DQ21HU1JMaFE2dU9ZVW1ia1RBMi9hTVhTNTVOZU03MUE2V0dW?=
 =?utf-8?B?R2dKM0FTeit5V2NHVXI3WDM1bkdxbnV1bWtYdlRhZ1hoNFVLNXg0cEY4N3Zp?=
 =?utf-8?B?YXFxc2VxV0krSDZpbnBCN2xMR0U1VE8vTDB3N2JrMTVaU2FrT1J1aFNHYWRT?=
 =?utf-8?B?TklSSG1Wdlp5UzZjb1pJVURGenBEZjNQUFVROUpLbTNUQ29HRldaTEJVMmNC?=
 =?utf-8?B?YW1KSXpucktNeW9QbDNnUHlrc3NrUndUS216REFJNW1SWDlEMzB4UFR3a0o0?=
 =?utf-8?B?SXZQNzZTZDlTaUNSbnhRN2xCVGhpd1hsenlOQzg3OXZGQ1RjODJFVUtrVjhJ?=
 =?utf-8?B?blE1U29MTzQrNTdhazNPdjNkbkEvUVhiZE5aNjM5bkNUYWhVZ1RoOGNqYVNO?=
 =?utf-8?B?S0VEZW0wdmp1NDZ3YXBmajZVK21nUkNqS0J2Q3pOditUdjBBZDZINEpsejh0?=
 =?utf-8?B?MVMzMzhOVmNQYkNlaGxYaFZLbmVwY2g5MzZOWjdzQlh2V0JPMUpGRGNyT3B3?=
 =?utf-8?B?aUMvVGJ0UEx5VXZ4YXEvMzdPREFoczl4VTFvV1BodTJXckdnVEtKTjE3OXB4?=
 =?utf-8?B?ZUNVRndxc1BoNk5zRENtR1ZUVWoxNWxZWWlXZU1wK3pTdlduZHloUTRnTFM5?=
 =?utf-8?B?N2JkRkpsdVlaTWtwSVMraWJ6TUE3T1pub3FUbE55QjMvNkVvZFB1OTAzT3Vl?=
 =?utf-8?B?SHFVMDR4U1I2MUIvb1Nma05CZnVBUkxhbDZTN2dUV0ttS0Fnb0UwQS9zbFFx?=
 =?utf-8?B?RGM4SGM4cTh5YnJIOXUrY1MwUUtiN0E2VEFWNzBOUS9YVXB4eGIrSTN0V3RL?=
 =?utf-8?B?MWZHOEdYZE93NDJNQXJ0N0xXUTNTTTErU29sSmlocEVXWVM4aVNtTWN4T3lO?=
 =?utf-8?B?YldOOGlrdTVNODY0cmxzay9CMmY4TkNma1d1dDlSV1dYUC9TdEd0N1dZellD?=
 =?utf-8?B?VGd4QnIyeGFLQ1pUYzB0RHVaRS9peVpuM3JwMmgrb2NiclBqMGxsZzJUZEpj?=
 =?utf-8?B?SW1XR0dMY1dRMFZDdlYyNU9kNll4cXNhYzFWbTQ4NzdjeHpja0l4cFJPcTc3?=
 =?utf-8?B?YzlWbXFxQzI5U3pNWUtHcjlyN01jclcvNTNOc254MEM0YjkxelpUbFI4UVBW?=
 =?utf-8?B?alB6alY4VEJiUjJjQ3l1d2tGcEQ3WWl0d281UlpZdVZOaHF3cmsreUtFRDFW?=
 =?utf-8?B?bFV0K1BwQmUwZldzU1ZlZmlPM2VxNk5MNTR1M0pZS3RPbVlabHRtVkhWNnBp?=
 =?utf-8?B?aDlxMDJRK0I2bVBaSEY2M0ZDbm1VL1RhcXlJVHVYbHNOSjUzVStYNTA5WHVy?=
 =?utf-8?B?eHA0d3ZJOWhuQmYweFJUdXFDaW1xdmNQSTZDMWJyV2s5cnNnRUswUnNlMlJh?=
 =?utf-8?B?a3JGckVwR3lwT0ZlSmkwRVlJZk5oN2c3NkNFUzdUemg1Zlk4dzByWDlxbndK?=
 =?utf-8?B?WDFSQTJLbTFWdjQ1MVdFNVVNMkRONE9Jc1pIaDg5ckpoclo0YzZPY21iNU5h?=
 =?utf-8?B?eGswZlROVkhaTzJWOHBaRlNVMGdWemJkLzBNTnVRODZFbkhXbHR6SmRvVXpv?=
 =?utf-8?B?bmJrTURic1JyTFhwRDVRUzNVNmR5d2lJS2hnOHE1dURib21JbmtZajZRY1Fl?=
 =?utf-8?B?eDFvSzZ4cVJUdTBtQk9jdGVDWmZYQnJMSnpzY3Q5V214TWpFRVNEQlIwVkhh?=
 =?utf-8?B?TUp6MVdndFltQThneUQybDlNbFg1Rm44WStYQjM4cnNmS2NtUmUrY1Zkb1BM?=
 =?utf-8?B?M0dpKzBZR0dtOUFhZTJUQ0FuMDY4ZXR2bm9kTVRUbEFOM3ZOQlA0MVFlNE1z?=
 =?utf-8?B?Tk5KVzRrcFBkdHhyd1YvY1lmOGkzSzFFdU41WGg4NC96bnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1WUlJDMHJ5S0NwaGgyNnE5eGlpTzRQLzRMaEVtaFZGdURQMWd1ZUE0VDVQ?=
 =?utf-8?B?ZkdsdlhLSXlEY0pUaERpdW55Unozcy9uek85a3NkcTRtUi9ISjRyRHU3am9M?=
 =?utf-8?B?anF2enZOVU5jUy9ibFNsNk5NbzdkOVU4VW1WY0t5and4NUE2WnQwZVkyeVNR?=
 =?utf-8?B?UHdnYnN3NmErQVUwekhRSTlYL1ByL2YxcnZpZGlHTmJnaloxVWo5a3hsYnQ0?=
 =?utf-8?B?ZG5pVXZzdVlMTWdoTUhxSXI3WllGQ3IzbGUrcTlMUmptUldjYU1BVHR4YmVE?=
 =?utf-8?B?RnJTNUNKMmNsL0JLVkYyUGZSdlNpU1VsN3pZK0pJcldncG9nL2wvbnZxbXNR?=
 =?utf-8?B?Q2JBK21KempRS3RjL2NDRmZuRGQxcnI3cndsMlZWNWtCWE55SWtIYjcxVEc2?=
 =?utf-8?B?U3Y5WXdmMVRNMyt4THU0VS95RzNMYUs2T1JMVHBCVlFsbmJDZkFZSys2Qngr?=
 =?utf-8?B?N2JVdElsM2ZJYkFVRGkwY0R6YW8vUWhNMG1vaXJ4clZodmdwZS9CMDZVd1ZC?=
 =?utf-8?B?N1lER2RaOHYxMXpTR0YwUGNoQWhrRENhK3FjWEJDSERhbTB0MG04YmswNXFB?=
 =?utf-8?B?VUE0N1U5YUVjNHNWbXBkRHhGN2E0UTZ1aUpPOTdnYThtWGgzYW50SkN4eDdo?=
 =?utf-8?B?TUd3Rk45RmpmQlJ0NEZKVlk1bEVlVlBEck5MaXN1R20vTGlWeFZkUFlPQ1RL?=
 =?utf-8?B?Ti9PS3kwR203N3lxYzA1Q1ppdnB3WGJ4TjdyU2VqMlE0dTZRZzdMSWl5bi9J?=
 =?utf-8?B?a0RlUmJTNDM0N3ppU3FuSjBrSXlsN2lYSXlJNy9LdC83K2R1MVcvQnhxdUpX?=
 =?utf-8?B?UWs5eHZQTElwWWFCTkxnMDVaYSs0MzVBSUk0ZWJZMnNtK1FKU0NjdEZtMlZs?=
 =?utf-8?B?ZDgvVDZwdHRDc3VzQnovNnVxQ3VzME9pblZVNHhlM3FMU1Fqb2VMbGJTdDNm?=
 =?utf-8?B?UU92VDZwazJVYkVkckU1K0RJZ1ExVE1HeC8wNzZWUEZ0ZFZ6RzY3K2J1bDV3?=
 =?utf-8?B?anFMejdyOTIwWkNaTzQyZGRpN0kzTHVqYU4xY0cxZ25VSHovTHp1RnM5cjlP?=
 =?utf-8?B?cHBRVGtjQURMdFRsK0hhanhYU0J4d3VlKzNxaFMvR1FXTzVjcElIK0NPWnJQ?=
 =?utf-8?B?NmhNblJKSm5EYytoTFR4RG83a2hBQWxlQTYrakI0TXRGLzVjbCtMajNlYnBu?=
 =?utf-8?B?K1JzeW1zZkJkN2RUSHNEL3lJdVY2S2xuNVhzS1lpcDh1TFlzcDZpMnIzSEE3?=
 =?utf-8?B?OTdYbGRlTUd2d0l1bi9xdElRdkFra0ViMkRlTjJkbExlN2c4Y3BlVVRYViti?=
 =?utf-8?B?RlNFZUE0QzlaMUUwcHE5S2w0dmluWVNHZHl6eUE4ZTc1RlBjQzZHWUJnbmVt?=
 =?utf-8?B?UkxsZHJKeEZnelNLQXVySmtqSTA2RDBpWWJCTnNFcGEvYVZ3Mm5DWnowOC9O?=
 =?utf-8?B?WWUwQXh1NGJNLzJmR3ZkSWt1allsZkpTK0cvN1FsNThxZ1hqWG9XRUkwVWps?=
 =?utf-8?B?S2x4Si9YRkR3UTEra1ROOSt1aGt4ZzF1cGp0UkIyWFkrWHZES1QvajgycFN1?=
 =?utf-8?B?ejdYcDU5NkJEanNHdE8wMEpFZnRKNnpuNk1MK3NTQlYwdEJOQzQwb2tCbFg0?=
 =?utf-8?B?TkkyRlV3b2pJdFRYRzBhOWJYa2VWdVRwYWxpUlUybUdHdWd6aHpHRWRCZHhI?=
 =?utf-8?B?dUdsbFJ1L1huNkJ1SCt2NndsWlNJc2NiU1JkTk54MTBwbm1wOGl4SjhMNFVa?=
 =?utf-8?B?UzdrUjJSTnQvOGZxNmpqNkREekJvMENiQVNCK0dOcCt2UW14TVFkdTRUZVFh?=
 =?utf-8?B?UWJxV0EzU1E3OGVXTUNiREhJbFdjeFdxMWZTZGFTMDdGV1d4QXA5bjZpRGo3?=
 =?utf-8?B?KzNOdGZRK0JpUVZ1VmxaT3dMdkE3dWVkVWVtYXVnVXltRmpaeVRMQnlodUp6?=
 =?utf-8?B?a1JMU3hOMHNjRWFRYzl3alFySm1FYmpOYlZITVJBYjFadjRWcDJMSW1HOXYy?=
 =?utf-8?B?MnlUQXpqQVU1OWRCcEpQVy9RS3lmNmJCUWNUdmtDckJ1bGsvNk5rMVJMV0Iw?=
 =?utf-8?B?ZDB4SldHb2tIU2czNUVDeW9vUVdGTE9kdkloK1VrMitqdEM2ZkFMRVBNSlpN?=
 =?utf-8?Q?dEanJotPVK4Sdi6YqGArRnwjU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ff9000-af8a-4bfe-05e2-08dcd62923d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:25:36.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk803YN5dNa5/cNV2yM0gVenfm/H9QKaChWfPuvL49s7XD80qeYojwmhgRA1P5XlwiaoVW6FfbNTfU+BREHv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255


On 9/10/24 07:37, Li, Ming4 wrote:
> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first stop for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be deferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c   |  2 +-
>>   drivers/cxl/mem.c         |  4 ++-
>>   include/linux/cxl/cxl.h   |  2 ++
>>   4 files changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 5f8418620b70..d4406cf3ed32 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> +#include <linux/delay.h>
>>   #include <linux/slab.h>
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>>   static int cxl_mem_major;
>>   static DEFINE_IDA(cxl_memdev_ida);
>>   
>> +static unsigned short endpoint_ready_timeout = HZ;
>> +
>>   static void cxl_memdev_release(struct device *dev)
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver.
>> + */
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	unsigned long timeout;
>> +	int rc = -ENXIO;
>> +
>> +	/*
>> +	 * A memdev creation triggers ports creation through the kernel
>> +	 * device object model. An endpoint port could not be created yet
>> +	 * but coming. Wait here for a gentle space of time for ensuring
>> +	 * and endpoint port not there is due to some error and not because
>> +	 * the race described.
>> +	 *
>> +	 * Note this is a similar case this function is implemented for, but
>> +	 * instead of the race with the root port, this is against its own
>> +	 * endpoint port.
>> +	 */
>> +	timeout = jiffies + endpoint_ready_timeout;
>> +	do {
>> +		device_lock(&cxlmd->dev);
>> +		endpoint = cxlmd->endpoint;
>> +		if (endpoint)
>> +			break;
>> +		device_unlock(&cxlmd->dev);
>> +		if (msleep_interruptible(100)) {
>> +			device_lock(&cxlmd->dev);
>> +			break;
> Can exit directly. not need to hold the lock of cxlmd->dev then break.


Not sure if it is safe to do device_unlock twice, but even if so, it 
looks better to my eyes to get the lock or if not to add another error path.



>
>> +		}
>> +	} while (!time_after(jiffies, timeout));
>> +
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 39b20ddd0296..ca2c993faa9c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>   		 */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 5c7ad230bccb..56fd7a100c2f 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index fc0859f841dc..7e4580fb8659 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>   #endif
>

