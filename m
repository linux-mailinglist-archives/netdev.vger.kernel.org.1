Return-Path: <netdev+bounces-148565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720739E2351
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269A6162A80
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072B1F7572;
	Tue,  3 Dec 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0LtIHMms"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC144646;
	Tue,  3 Dec 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239845; cv=fail; b=QFRCHnkZoRkM7MDl/aOyA0YcmW1oO2UYyaytA4ruR+6BZ3MFR9RHnbw71Mo397KgZONiKepXmuzHJ5W+Nsjw7qRfQpFMr4NSz/+Izpt996XCL6i9WNGV6u579xL7nxUzPlX5AhWMIN2+e+lDOkbjM+ZH+hrQrRiiwKVDHGqJ6G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239845; c=relaxed/simple;
	bh=P1Q5utBhCaI/1ovbyjK1F6Dgw/aMAselmDjFmNtvJrA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmujrUteW/uPl53qcNpikBNpqkXgNvup4Mzu8oNrsemdYY4q1qUp/QcbBokTQX5+16aG7VjssfyxPsqzn9QCcPs9f3nNfCA/yL5dwWT2W5pSz5Yni6NUL3meXRLMN9WFe9brfHdju5oWxNO0GNlKZ5V9aXldoGqb/oSmysCd5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0LtIHMms; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgEov3tdNPXGjhkzxZawE6fXJvKoswwHa60leXTxIi3toHbzyoLLTaledmgWqgyvatkP4A8E6rE9FFKMo8axmdPXbV22vGlXeh8XVMm2jSZmPGgRkOAr7zQDR5jC66H5/MH/laPikr4u0b2IRxTWFs0OJyYq57ypt7tUx0Fqlvqkk10ewCPHzZXpGlL2QIJT28vocAOkZeXl62VwqI6fhqb2cyslxSNJRqzLhfYW9I9yelXquN4q0zxdSJew5apoMJTjzZQ/N3+a1zO0Rbky62z1uT25LTttsvDD86BcXHublqGxhY4qF/66jtrU3kl3bxEfeIvs4SrSIYrZTogP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWjFIjp3NBROirMIwh73Zhw1dKhxIynlsfoN/INkI/Y=;
 b=xEZuMwSPUouhjGN5TK8BLQ3IZQ9AGHT35T3AnJkOjX43URjhb379lU9xHtFEFSDOuWHhlRCq1PE4q9MqXFQYjeIsZju4VxtsVf0ks9PTQZNFrcIZHYXGNXQbn/6DxqeCL3q476QMPITyT2vK3cV0eSe2TtMntW8GigR9WQ6l7Yv3dZheWRXJtzON3G4mKSQedIpGo9r8SjhCWgDKg1Taxn9mSGNDSdTwQpF0sIiG5wLS2u1M8F3yXAn3K7/eiJJdSPIz2nQujcepd6FmYXADQvpp/qydBAsheSi5jYdMytwQbRs7z+u3XmyOBhezQKSauD/QP2fGIjoQskr7JTuzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWjFIjp3NBROirMIwh73Zhw1dKhxIynlsfoN/INkI/Y=;
 b=0LtIHMmsIeglfzoUKqgECTGQ8HAin4wfAoaZ7omFQSLxiLs0Prg8a+bp/fy3IQP9VHyVdAG6jprLrl/azYxI9ggEdt9PGkOnAJFyCacC4uFGDEhyLqDOSkzPp7LpafU7oJP570b2Y1iiVzEduiygAev2GqyCdOgKvk4V/uxNd38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 15:30:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:30:40 +0000
Message-ID: <2c217426-f1fa-9ee1-7c27-d1c1d4fec0f2@amd.com>
Date: Tue, 3 Dec 2024 15:30:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 28/28] sfc: support pio mapping based on cxl
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-29-alejandro.lucero-palau@amd.com>
 <20241203145242.GK778635@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203145242.GK778635@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::33) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: c205c2b6-b021-4496-a7b1-08dd13af717c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWo4VklHREpEYm9Ma25nRjJEWWRMNHdmYTljaXhJclMzMHVKZWlla0FOUHg5?=
 =?utf-8?B?VzRRZzFLeXFtaTI4SVM2NGs0eWU4OFBtZnNubDRwUWRlVVZqbXhEczBSa0I4?=
 =?utf-8?B?WHh0aDNkOWhDcHljYlJmRXI5QXJsbTBNTUtsZ1U2bW9QWkoveHZ1MjB4c1lq?=
 =?utf-8?B?QTV2aXpCbngvYXpzckZ3Vm5NYWdOaThObVNJb3FjNnFESEMwY2tUYXVXODBS?=
 =?utf-8?B?OXVNTE5ZNDVaclVEcnZGRnA2Q3VGTCtUMEpPditzWEx5Rk01U1YyZFQ1TmVw?=
 =?utf-8?B?NFQvQmNaczNNcFFlOTFTbUEvUVN2aUZWVEsxdlQ4djJvRmZtQkh5aHErU2Ev?=
 =?utf-8?B?bnZxc1lNeUxDU1dwWWU1ejZNUlpoOE1FQ1JuL2lBaHBFUGVFa3Y2UFhCR2FU?=
 =?utf-8?B?VUM3ZDJYbUdtZzNienk0QUZkT3NhNzFRem8zOHM2NVdseWk4VGJONDdHditC?=
 =?utf-8?B?MVUxODJpK0MybVZhZnc0cjl1aTBFNkFKVXJFWTlsWklVK1JjVkZIa0RXUTNq?=
 =?utf-8?B?RGcrbXVGMzFwQktycWd4L09wWSs1YisrN0hZdTYvT3lwZEFOK0N2THpvR2tl?=
 =?utf-8?B?M1NaZGZYeVUzZ0JMZFl2SjNpUTBIM2lrMVF5aExOZFpTZERtYnhLczZMcW5G?=
 =?utf-8?B?Tk5pM01zRStrK0ZueC9kMm4zYXc4MnQxaS9XdHlLTW55L0NzMTkrOVN0MnJv?=
 =?utf-8?B?ajR1RmJvVnB6Z2NzMHZrUkE3WlRkWGpteDZRV0hzeU4yQ213bHFNNGErcWMx?=
 =?utf-8?B?b2NtcS8zZ3Z6ZkNVNjJjMStqYUxjUWw0OTRXL1gyUXoydXFHYldqV3hTL3VC?=
 =?utf-8?B?VFpPVTE4ZE9qWHpIYmNiem14QnlYaE1WZklSTGVlR3VMUXN3bHdMVGdlSVFs?=
 =?utf-8?B?RFZtaUIxVGxiZ2MwMlhYbzMvcHhLT0hSZ1dZTkFDeS9NTFJoYnNzc1hKRU94?=
 =?utf-8?B?Q042YkxMcnVmdFV0T1M3WFVja3RrSzJZTmtvVDBEUjdsN1d6QTRoTXpPZGdn?=
 =?utf-8?B?cmIyVzVINGpHNHFlelpNMU9mNmQ3aWkwQWNqZVJ0YWEwVjByOXYzOXZzd1Vu?=
 =?utf-8?B?QStoRzhGK1NFb3BoOWNXUy9MR2xyY2RqK3Btc2piNEtJM2RLUmRjMW1Yallw?=
 =?utf-8?B?L0ZiUFVFS1RhUmJFMkZxQkpqVlg0NENnZFVjMjY1aVpJc0tOTytPdWh0Z1B1?=
 =?utf-8?B?QmE5SkZZaE80UDg3MXY5NjVLTXBtK1QrdXltUUVkUlJyenM1ZkMrcE95Nmtk?=
 =?utf-8?B?UEM0ekhHUi9XQ0NkeURPVVlXd21DUW1FVzlCaUkxcCtkVUtkeGpDUFp1anps?=
 =?utf-8?B?YVhjQWU3V2xnR3VOVjZNR2hQOG5FUzZqK05yZVorZTNBTTFZWk5TdjQvSGs1?=
 =?utf-8?B?UVFZQzFjREkra0VacTZYOWlQcjdJMnJ5Y25jaG5ZRWY2OHFvNHdTN1NrRnls?=
 =?utf-8?B?T0s2aTZQQVRsOGZyWGhmTm1CL1lCVVNYR0tFTnRnaFNLSHYrdmd0R1ptSFNH?=
 =?utf-8?B?SmQ4M0p4VzlPYmZxeTNxQlI0WTUyZ0lSRmVpTmRZd2RoZHg3Nm5QdXhUUnZS?=
 =?utf-8?B?bTkvTFZtY0Q0YlczUGY5UGEvV1ZBYU9rZHZaWVA2R05Mc01VZlIydmlMM251?=
 =?utf-8?B?akVFdjY2WENIcU92TnBMZkdMMG12dTlqc0RubEEyWHM2TU1ZUkNNRkVRa1Bj?=
 =?utf-8?B?aDVqenhHZml3V2Y5OTV6YlY4OXpGQkRXcUwzdUJpeVhGK1FwbFlyR0VXSlpv?=
 =?utf-8?B?UGNMT2taTkV6RWpSK055QjFjTkg5WUF1aXhhbjUzR1NGT2V5MUJ6SXlUQmp1?=
 =?utf-8?B?T3UraDJrSEFzU08vck1mcHlvSWh0dWphRG92UStzN1lKNzEvdDk0UzVKMURK?=
 =?utf-8?B?SVBpNGlTTDVwZHFiV0djNytHUWFJby92VEsrQ01rUVJ2Unc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtlYjVKRGRUUDhrOVZEWjN4cjBSdTdFejJkZWJYbTZaQlkwdHdpekpVUUdh?=
 =?utf-8?B?bmhtb0xIWjZhUVFzRitrVnQrRlVFdit0VFF2UGU0T3YzYWlYdk9Ub1BQY1dO?=
 =?utf-8?B?NmFQN1lpSlZleG4yRmY2bWJoUDlOV3U3L1lKeWcvN3V2eERybjJrdVNCaVlR?=
 =?utf-8?B?NzNjTmZoYUdNVkFMQnBFb0FTcXJIWGZKU1p3cjZvL1h1VlZHZTZENXloeU1G?=
 =?utf-8?B?MndwN3J0QytEMjU3RXk4aVYzcHR3T05vRyswWUZIYWhvc2pGdXc3ZFZsck9Z?=
 =?utf-8?B?am9CVG1JTGlOL25BaHA0a254bHl6eVM1VkRnVlFPZUY0ZG15UDV5WXlWNVF3?=
 =?utf-8?B?QU0zZkNoQ2V2dHQ2dVRNOWZuUjdFZEtaY0VnUFcyOFNBUVpTc25kOWdSM1pv?=
 =?utf-8?B?TmVkWXhVd3VwZERLUjAxenBpd09VT3V5YURWQUFtYithaGNvekVrTlh3dHJW?=
 =?utf-8?B?SWUyK1B3VWlVM3BId1NFTmdIS04yWkdrUGpIRmxoN0ZQY2ttUTA1a0hNYTh0?=
 =?utf-8?B?MDdvcE5tejhpVzhjMWlVZG12SUVMcmg4Y1BVM2pzUVNpQ3N4S1duUzk2d1k3?=
 =?utf-8?B?aTBHT29MWmlpdlpQOTROUUZTb29PRTl4UEY2SGgwcHpCN2VXbDFmN3orMWhX?=
 =?utf-8?B?VGg2Z0pPckFrUXBwK3l4OXhPNHNMdUpsWEcvVGFPaGJiUDM2R1d6K2lKaVNW?=
 =?utf-8?B?dnBuc1pvbVRna2R2Q1lJTnFlcEpWL2dBV1dWWmhZWXFJSTJPOGx4OXlOY2Nt?=
 =?utf-8?B?Z01PVWVPYXI3ZW9qRE9tT1VPd2I2M2FFNWZoUmJva08rZEJ2MldodE1ic2RX?=
 =?utf-8?B?d1haeWVEcUd2SFhSZ1k0dUNZMFlOSEZJdzlTcyt3S09VTkE1RXB4dFJ1TXl2?=
 =?utf-8?B?eTB5cEluMTFaYWo1ejlsdnZ6NWwyb3dvZ1VrYnZ1cWpQY2dJd3lhVnE5dlc2?=
 =?utf-8?B?RHpPemJLT0JEamhBdm13Sk5JTGdkcmFFamlnWHF3Q2R2Y1g0eUtXbkUrUGdq?=
 =?utf-8?B?ZThDa3VTdmlQMnYxTzNuZmZKZWhqaEprWFFlR1NhYXl5TnAzNWt1TnpaQWg1?=
 =?utf-8?B?WjY1Vm91d3lsdWRtSUVzQ0dZWmd2U3ZMQ3ZqeW5QQUNzbllPa1UzMkpSVnRG?=
 =?utf-8?B?RDRZZTRZcmpqQmZNVktrUzVMZTJaNTBBeUhCdTZZdzZhNjVSdzVRcTFMVUhZ?=
 =?utf-8?B?bElFbnZac3RMV0hESG1WOThMa0w3ZVdLdExyK0FMV2tyYW1OWXdTLzhjTHhj?=
 =?utf-8?B?N25pN1dNREhnNXZpanNtVGJyelc1YTg1T2VPZjVJWU9ubFV3c293bnU2OU9t?=
 =?utf-8?B?WXB3T1VIOVR1RW1uU1plb1pTMGdGOERnalJyb29aQ08xK3V0VGtxZWJsOUVk?=
 =?utf-8?B?aE52blZoTndnL3oraEYvZ01oYUhSVFVpK3dBdXFWU3d5SFg1V2ZaYWNKTHFT?=
 =?utf-8?B?RXU0Q0ZMYi9RdVRCbWEwZUc0WW12QWVMRi9wL0FuZVZaZjVzRm8xN0RTa3VR?=
 =?utf-8?B?TGpwQmZENS9uQlJIbFFQSzR3Y052ZDUrdTY0b0JLVHd3QzVtTE4rSUZGME1Q?=
 =?utf-8?B?ZUg5T2tQaGFFa2xxcGpqVXprQUVYZFR2Wk5nTnMwSGZLVEMxSHQyd2w4dnZR?=
 =?utf-8?B?dDZuNHVCOS9yY3FtbTBZU3k4bTR4bjBTL0Q1N0FzVlZCWFVqQ2dUK2pYeFJq?=
 =?utf-8?B?YmVjRWZnL3o2SHROakx0MlZGUzVkQVhoUUdhdnd1WWI0NjQ1dEg5dW5ua05v?=
 =?utf-8?B?QzBNL3pacEo0NDdCT20yMGNEcnNQMmVxeStoOVhIWlp1ZitVN2JUUkNnc2ow?=
 =?utf-8?B?SDlUZGhCZHltUDZudDExM0w4SzdmSFhlVDNzM3ZVUUFmbU04SDdJbENaME16?=
 =?utf-8?B?Y1Z6cnpzRzlGdmQrNnRJUWJlcHQ1VkxIRW5DNFZpbGhKaENBaUp2R1BsSGxm?=
 =?utf-8?B?MTViemx1LzM3L00xM3hMVThRNmxyWEpBeExNYzJiekRxTGNZMjlRb2dub2x1?=
 =?utf-8?B?K3ZoOXVNVFZqakIzNFdCWVlYeHVudlVsdk5tNkxhVG0xaEZ1TXA5YmxLMzdI?=
 =?utf-8?B?T1o5K29CbER5MGEzTmwwcGY2a3VYQjVnTkhKVk9CcHJGd3RKZTZwMUxadkt2?=
 =?utf-8?Q?Pt1vAHoQvvgmJxUTRqZ3K3LnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c205c2b6-b021-4496-a7b1-08dd13af717c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:30:40.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVxlXMiN0O4VYQqp3N6LS1GaiBCgMM85hxpPOng/5t+OgdR/NhmcHmtCq1cgo1Q3YbOLOWgHRwY8Yk3iqkn0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266


On 12/3/24 14:52, Martin Habets wrote:
> Hi Alejandro,
>
> On Mon, Dec 02, 2024 at 05:12:22PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/ef10.c       | 49 +++++++++++++++++++++++----
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
>>   drivers/net/ethernet/sfc/net_driver.h |  2 ++
>>   drivers/net/ethernet/sfc/nic.h        |  3 ++
>>   4 files changed, 66 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index 452009ed7a43..f2aeffc323c6 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <net/udp_tunnel.h>
>> +#include "efx_cxl.h"
>>   
>>   /* Hardware control for EF10 architecture including 'Huntington'. */
>>   
>> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>>   			  efx->num_mac_stats);
>>   	}
>>   
>> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
>> +		nic_data->datapath_caps3 = 0;
>> +	else
>> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
>>   static void efx_ef10_remove(struct efx_nic *efx)
>>   {
>>   	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_probe_data *probe_data;
>> +#endif
>>   	int rc;
>>   
>>   #ifdef CONFIG_SFC_SRIOV
>> @@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
>>   
>>   	efx_mcdi_rx_free_indir_table(efx);
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
>> +#else
>>   	if (nic_data->wc_membase)
>> +#endif
>>   		iounmap(nic_data->wc_membase);
>>   
>>   	rc = efx_mcdi_free_vis(efx);
>> @@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   	unsigned int channel_vis, pio_write_vi_base, max_vis;
>>   	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>>   	unsigned int uc_mem_map_size, wc_mem_map_size;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_probe_data *probe_data;
>> +#endif
>>   	void __iomem *membase;
>>   	int rc;
>>   
>> @@ -1263,8 +1281,27 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   	iounmap(efx->membase);
>>   	efx->membase = membase;
>>   
>> -	/* Set up the WC mapping if needed */
>> -	if (wc_mem_map_size) {
>> +	if (!wc_mem_map_size) {
>> +		netif_dbg(efx, probe, efx->net_dev, "wc_mem_map_size is 0\n");
> Please still print the details of the memory BAR that the netif_dbg has below.
> It is useful for debugging.
>

I guess just a goto there setting rc and removing this debug comment here.

It makes sense. I'll change it.


>> +		return 0;
>> +	}
>> +
>> +	/* Set up the WC mapping */
>> +
>> +#ifdef CONFIG_SFC_CXL
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	if ((nic_data->datapath_caps3 &
>> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
>> +	    probe_data->cxl_pio_initialised) {
>> +		/* Using PIO through CXL mapping? */
>> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
>> +					   (pio_write_vi_base * efx->vi_stride +
>> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
>> +		probe_data->cxl_pio_in_use = true;
>> +	} else
>> +#endif
>> +	{
>> +		/* Using legacy PIO BAR mapping */
>>   		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>>   						  uc_mem_map_size,
>>   						  wc_mem_map_size);
>> @@ -1279,12 +1316,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   			nic_data->wc_membase +
>>   			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>>   			 uc_mem_map_size);
>> -
>> -		rc = efx_ef10_link_piobufs(efx);
>> -		if (rc)
>> -			efx_ef10_free_piobufs(efx);
>>   	}
>>   
>> +	rc = efx_ef10_link_piobufs(efx);
>> +	if (rc)
>> +		efx_ef10_free_piobufs(efx);
>> +
>>   	netif_dbg(efx, probe, efx->net_dev,
>>   		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>>   		  &efx->membase_phys, efx->membase, uc_mem_map_size,
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 71b32fc48ca7..78eb8aa9702a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -24,9 +24,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>>   	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct pci_dev *pci_dev;
>> +	resource_size_t max;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> -	resource_size_t max;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -135,10 +136,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_region;
>>   	}
>>   
>> +	rc = cxl_get_region_range(cxl->efx_region, &range);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL getting regions params failed");
>> +		goto err_region_params;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region failed");
> This error will be more useful if you print out the start & size. Users can
> the check that against /proc/iomem.


I'll do.


>> +		goto err_region_params;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>> +	probe_data->cxl_pio_initialised = true;
>>   
>>   	return 0;
>>   
>> +err_region_params:
>> +	cxl_accel_region_detach(cxl->cxled);
>>   err_region:
>>   	cxl_dpa_free(cxl->cxled);
>>   err3:
>> @@ -153,6 +169,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		iounmap(probe_data->cxl->ctpio_cxl);
>>   		cxl_accel_region_detach(probe_data->cxl->cxled);
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index 7f11ff200c25..79b0e6663f23 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -1209,6 +1209,7 @@ struct efx_cxl;
>>    * @efx: Efx NIC details
>>    * @cxl: details of related cxl objects
>>    * @cxl_pio_initialised: cxl initialization outcome.
>> ++ * @cxl_pio_in_use: PIO using CXL mapping
> Extra + sign here isn't right. Please build kdoc, I expect it would have caught this.


OK. I'll fix it.

Thanks!


> Martin
>
>>    */
>>   struct efx_probe_data {
>>   	struct pci_dev *pci_dev;
>> @@ -1216,6 +1217,7 @@ struct efx_probe_data {
>>   #ifdef CONFIG_SFC_CXL
>>   	struct efx_cxl *cxl;
>>   	bool cxl_pio_initialised;
>> +	bool cxl_pio_in_use;
>>   #endif
>>   };
>>   
>> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
>> index 9fa5c4c713ab..c87cc9214690 100644
>> --- a/drivers/net/ethernet/sfc/nic.h
>> +++ b/drivers/net/ethernet/sfc/nic.h
>> @@ -152,6 +152,8 @@ enum {
>>    *	%MC_CMD_GET_CAPABILITIES response)
>>    * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
>>    * %MC_CMD_GET_CAPABILITIES response)
>> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
>> + * %MC_CMD_GET_CAPABILITIES response)
>>    * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>>    * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>>    * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
>> @@ -186,6 +188,7 @@ struct efx_ef10_nic_data {
>>   	bool must_check_datapath_caps;
>>   	u32 datapath_caps;
>>   	u32 datapath_caps2;
>> +	u32 datapath_caps3;
>>   	unsigned int rx_dpcpu_fw_id;
>>   	unsigned int tx_dpcpu_fw_id;
>>   	bool must_probe_vswitching;
>> -- 
>> 2.17.1
>>
>>

