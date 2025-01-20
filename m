Return-Path: <netdev+bounces-159795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6AA16EDF
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611FD1883497
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2561E411D;
	Mon, 20 Jan 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSwKKy8X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78E1E3DE4;
	Mon, 20 Jan 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385137; cv=fail; b=DQ5bDoLUnqTSiKS44F+c5dsq0FgS99wAot67eR8JvnQuPXaLQW4rrzJN6h+0KpLEOTb46TQrBTolcjrB9fBECAccagxuw9ftMPFrbnnhJG3NW+mz6ZZx+O9NV3AMthVWQtuCFWqOqKmnYGu9xHbSjbUOo2Kw9/GlBbVUk+7zQEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385137; c=relaxed/simple;
	bh=tYd80s0UtW2L7k2KDoOTcaNrnmU9e5r8sCGhQqVK2pc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nApd2ZlopcJEmXDEPWHtXjkZ0rpgixZ/DxVvesf0gJcKjfm//XODw2twQU3+/yQRtG07WHHXXKL9FkjhnaE7yHa47HaUOTDdyi1CvFGEIIf2qnieQOv7LpQFy9L99xBG/D/JUZfPNlNmoc/6xYKO3ixGkONLT22UBQjlPwjiqtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSwKKy8X; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL+Pff+0H3Ke4Pb5GXxhLW2CdiTReNvbnDc5M7pnOgF3nDfSmYoouA8CSWhkV/tMmYHMT2QENkTieYYe4TI1FJYGDD+I0fCcuDogT/Py502AuIhC5K1StjSf9CKTc76SXaSOu/IxjNGDsN5HMZw5cFRNONw1w9rL7QvuZ7d8uG2rlb/gMKwDlKmxk4U2a1fZtz9pFG6mJT5bMGWa7Wv5jDbIM0wLgvzeuaXLCLESxsa6oCfN34+smxtcRTVn7FIjvrKg7x4bpFt4VWZThxQPTjUVYA2nwzBHilD3t7HxVKmHiajV1/OgX2yXNITZF8ketCEsKrAkwQFsuCXsydl8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKyjQw0IrGtnjfmLlm8SaCXWO9F/ZVJHLBfeOQo+I1M=;
 b=WEaSjeWxbXRVEXqIC0To0pFBOFqDjdegAmGNqBBOO9zWnGkjDrK0cMkV7aBlJ2ZD2kjB+98q7u3sY4SvHonD8x3HBiWGcc1WFcrxLmcKmURo0eENNh9ThrPO46ANNSBMmloiOMbz71TgXSclVKmdlaO0imR01jlW8Lh1frH+EGhM7gp6Eu+M8LGfmhxL6vMBZDHDUTcGq6t5gG84qz4duyJ74rTE1KqkeJGL5T0GK1xfv+TUJg72DB0ceQhnXoeLPYVCsTeQ4f1DCbO06Qi5QP9t3ZwABvcxnaeGXLIV6d6hOfg49AQ0eekuUl9JOluAiAd6sS2cUOlR1LWnWqVKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKyjQw0IrGtnjfmLlm8SaCXWO9F/ZVJHLBfeOQo+I1M=;
 b=dSwKKy8Xvp0CDburHUYnTjl7LR066Uq8h+kA6voBfKA5rA28imS8Edx39oSGsejFWoG63pJZhyhlvV0kONnUJBYciqdULn4Svky2fmZtaBC4WnNN1QdLL4Okh2p+j7RrVYanQysyYasF/Bq9WHlzKdglC6NRMs1+x4hlheR8gj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 14:58:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 14:58:52 +0000
Message-ID: <7ca6bcac-8649-5534-f581-b36620712002@amd.com>
Date: Mon, 20 Jan 2025 14:58:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
 <678b05d3419d8_20fa2943@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b05d3419d8_20fa2943@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00007578.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f5) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb49f19-4c37-42cc-c8f1-08dd3962f423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkQzVC9rcE9Za1NJNXV3cDVhVXpkY2hYMW5iaG9sQzlXS0RyMWIyK3lpZWwy?=
 =?utf-8?B?d1dBTzRQWndrSW1UY3JuOTJHWjRWUnlidE1HSGtuRFIxMVpKeVBiUUduenIx?=
 =?utf-8?B?UHJYZmdldFd3VGlKcGhVZDJFaWovV1h0bzEwWGd1bk8vNTBWMHBGNFlDMVVL?=
 =?utf-8?B?OVgwalNDRVJtVmhrMVlMY2dHMG80TnllanNZSlhYVUptYmRvZzJPTG84bU4v?=
 =?utf-8?B?SU5xUXZZbkZ4MlpOdktYYVoydnlhOXlRS0o5M3V1alFzNWRhUjI5UUN4dHpL?=
 =?utf-8?B?NmIrUzJqQUJUcDJlbXpkalZ3V3lqcG55U2FUN3pQUUY0QmRreGRoUWtRT2Ux?=
 =?utf-8?B?aHdZU3FCVVZidUdIQmdsS0JVdThVOHNsUHJlQXVUdmFoQVVxS1BLL0UvSytX?=
 =?utf-8?B?Z1RyYnJsOUUvTVViSzlqalF4L0tobzlZVXg4eGIveG5nc08yWnFlZ1dSTzNv?=
 =?utf-8?B?SzZPMVdFUUkyUTN6K295NFcrVWtjVnVwMzBKcXdVSmx4WlMwMWYwM09IbEEw?=
 =?utf-8?B?SUl2c1UvcG9Jd2JVd2F6Z004TndKV1liVlVKTVQzTS8rNDlIZ3hsbFU0YmlI?=
 =?utf-8?B?UE1CWVNBeG9vQ1FPeWZlT3IvYWROdEdvYmNPVFhiamhJT2NqZkZURU9wQUIx?=
 =?utf-8?B?ZEFXUFdKYnVIOFBkN0NvdElOTXBFQU9uS1cyZFliMG9JdUFDSi8xU0xDeVhx?=
 =?utf-8?B?dmovUUxONktRMFZFUytpUHZ1cnNNZmdZcUdsVnR6MWd4Nk1qbmNaRnlhYURr?=
 =?utf-8?B?STNOVVNjQUF2N1BBNjJ1SlBKeFdLeWUwZmtKV2V3Y0FBcHA4MDBONHFxenZI?=
 =?utf-8?B?WExtREtETTNINjdqWUNwMGc3NE5zVFNFYlRXQUUrd3V1dnRLZlZrOStRVHpR?=
 =?utf-8?B?M1ovNklpcUd6dE1FdmRDSENRWXZPZzJsTTJsR2hNQUNWaDdoZ2FjbFF0U3Ju?=
 =?utf-8?B?Tmg3VHNuSVZ2RFpPNWdSYVU5TmhCNDl5YkJjc1orSE5rSGxoalNxSC9CbUg2?=
 =?utf-8?B?U25iN2V3OWp1TEpHU1VZVk0yMVMxbEdRVmp2MUlQOEkwSnpxdHV2Y2FPai84?=
 =?utf-8?B?NVd4ZTZBb2pxSmhXOXRQYmprbG1tWTAwUzVYdHAwUzFINHFiaGpLWDRYV001?=
 =?utf-8?B?ZTBKeHJqalhSY2E5T2RMdjJ4SmNFOWJHTzhjSDNITGRyYjQ4N1crS3FhWDNR?=
 =?utf-8?B?R3krK2wxeXY5WDRscUxoZlZSb2VXOGxqM1kzTkw5SG4vSVdWR1pyekl6T2E2?=
 =?utf-8?B?TXVsS1RLMlEvUTFMNU1CUkxxZUdzZmd5alViN3M5akVlSGNIZXoxRUwvR3Y0?=
 =?utf-8?B?OTg0NEJ3N2Z4OVFKbVRKVmdTRGEwUmordmJYZFR6bWRVcE9vc1M3QzBpRmJ4?=
 =?utf-8?B?NzU2ZkF0ZnVETmhITkJEL2lCU2Zrb2hRcnJIWENheWNrd2s2Slp3djcvTUNX?=
 =?utf-8?B?TjJOK3hjS2dYUGZoSFR3RUxGaEQrcG5vbmxhOEZEYzFXY0lzNUdFejNVNCsz?=
 =?utf-8?B?NkoyNytBZnpiUkYrbTRncWFVSWJtSGRQcDVGWnBmemFlOGFzWjVKTndFU3FY?=
 =?utf-8?B?ZFpjZEdlK05yeEZyUHNyMWZqRUpWMVd0U0YwUitPUzNzcXlidFhlRUVLak9G?=
 =?utf-8?B?MWt1ZjVTQ1A4ZFp0TFJDdTQwTW80Rjg4SmlRdlVObkg2UGlhdy8rWldOd3lX?=
 =?utf-8?B?UldlQW1xN1ZpbnlCVjFJLzlwTVU2SHNVK2xicGxTSmZhL3ZGTHRhY214L1Z5?=
 =?utf-8?B?UFV3dGd6RFR4RFMyT29QU2xOL2tScGp6dUF0dTVMdEw0bzl2TlpRU0U2Zk0r?=
 =?utf-8?B?a1UxYlZDRmFsUmRBZ0x5dDZkWHFJa09Dd0YzemhGUEFQbSs3MDR4MlYwSXFK?=
 =?utf-8?B?OWtFYWFYQjlKajZHeW5IV1IyazNhcmlMcC9tUVd5S0FZZlJibEh6eHdyL2tX?=
 =?utf-8?Q?iVaopeGfFjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1zTisyaWRHdG5JcXNXS3MwWU0xYVhrUS9ZRkhMZ3ZvQmJCS3hUWDNIR1RN?=
 =?utf-8?B?b3dEWjBscnlOZFJzTmM0cXk4WW80TE9XWm5HczFkd25xRGcyQnZKSjhOOUpJ?=
 =?utf-8?B?cWg0aFVwd0hvKzV4WThXWW1xaXlwZWlMOVNRZURFbkU3Y2M4dVZydElTWXp1?=
 =?utf-8?B?UWIvelR1dzVjaFltdXA4WVUzdThSeFNDcHFoY3dpcnZpUExiS0ZucndEemdt?=
 =?utf-8?B?Y2hINjU2WHFac2RlRG5hM3dGNkFjZ3kyemZtQlJHQXp5WTVsTFNOS3ZkSHFi?=
 =?utf-8?B?a3NCbGtOMnRxTVk2SWhTbGw5djRTU0Y5V01mQk5vVUJVUytjZDdZZWdWZVY1?=
 =?utf-8?B?VmE4WmhDcWZnT0JqVnlWLzhRNlo3UEJqZnpRYjFKbGlnaEpRQWFDRGhaeFJB?=
 =?utf-8?B?SVFLRlN4SHhCYlV5TWtEZmtYeDVYdWp4ZEM1SE9QeC9KWXpvNnZheVNzK05E?=
 =?utf-8?B?Y1FVVWlzYUZxSmJTUU1BSFNyK0pkMVBsM25EZU9vbE9Cb0pSWEtXL2ZOcGwy?=
 =?utf-8?B?d2hDcWdZckdCY3p4aXFMYms4V0hhdFN2cnpWeUFTd2FIUXF4MUFzUHFTdE5K?=
 =?utf-8?B?aHFIdnhPWm96RDJWR3FCZStBUjdwNWhNUnJNTGR6bFRKa2RUUStWK2IzVlZR?=
 =?utf-8?B?U2tpQWpWdnFvTWFDWGpSSHplYm55bkhtQVF4QUlSb2s0dmVNVTU5R1hLVjhl?=
 =?utf-8?B?aGRDcFNVZ3BwRmxpaFFLQWV2LzZOTXdVdTBlQXJGUjlBa01nbWNFRzR6Ulh2?=
 =?utf-8?B?emRaajAwc0lPVklLL1FLd0FNMVhyand3SlNSMW9CUDJoLy8rMmJ0SzVOVmI4?=
 =?utf-8?B?cENldlN6dnVTWStTQ1lRekZwb3dNb09uV1F2U0EzRGtqNDluMjVTSUViQkNn?=
 =?utf-8?B?NWh0WDVzdGZlbUNQNExTYVgxMUEwcVVSZ2o5dWtNWkNwVjVlM0NpTUpYUVhS?=
 =?utf-8?B?SkhId1ovZ1lPS2dwUzRwTVRJeityNFRia3pTYWtLSFplK0c1T29NSTdwb0c0?=
 =?utf-8?B?bUs1aVlzSHlIYjN5NE54NnBMeTJwU2xLdUNFbEtuLzdJM0FyaDFrTDNrWmNQ?=
 =?utf-8?B?bzRvR2c5UUIrRmhCQTBwTTRBSUxvTTVkazVhQWxScXhQdksxMS94QXBHQU1F?=
 =?utf-8?B?RENETlZqVC94MEV6c3Bta1JtOW5XcHZkaGV1QVlwWjI3b3FhdCtvaFBjTG05?=
 =?utf-8?B?TXNucStXbHNlQzBra1RNeXdtSkRqeVRNekViL2UxaXpZaWtHaW9ISjdabVlV?=
 =?utf-8?B?MFZwZEFHOVFoS1BqQUxhTHRSQjZpRGhaZU85MGRvNzRaTDNRTHAxZ1B0dSth?=
 =?utf-8?B?Q3JLazlodi8zbjJmQmFJa0wvMVNFcVdWcmdnclhraUxNdnA0VEwvWmg4cUdt?=
 =?utf-8?B?SDd0N3JHWER3cVJKeFlTWEQ0bFFkVitsd3MvK2c5RUExMXl0ajYyRTVCRm45?=
 =?utf-8?B?OGRibCtNdjN1VzNkRnVCREJVL0oxZDkxZ3lBcGQ5YS9WdnF6QjZFRmIySWZS?=
 =?utf-8?B?Qmpsak9TMkFxQ1pnc3lPZ0pNSDFrcGdsbHE2YnAxVVdtVkRBNlB3Q1hFaTR3?=
 =?utf-8?B?NEd0YmsvVDVXT3N0aWt5ZVRlbU1uWnNPMWxjS1V6K2xtK2pVYk9Wd2Fzamo0?=
 =?utf-8?B?K1JSSEdvbDBCV0sxcTExOUF2NHArYzdidlk0SUpXenpPLzVEa2ZpeVljb3J3?=
 =?utf-8?B?Y3ZadUwrSUMxVkFpZ0tsL2cwRnZRRmdxQis4TlJLSXhZK2FEbXZoRFZYSHBR?=
 =?utf-8?B?S1BZMGg2dnRrbmx5RUZWZlI3aWxoMU5meTFhY1NTMVl3Mkl5cElKSXlwS2Y4?=
 =?utf-8?B?MVdCa3kzRWhOd2pHK3dPTGZIWTdFQXY5dkJBVTYrWHNnb1pza0MwTnYrR1Mx?=
 =?utf-8?B?NzZBUXZ2TVRWTmZzK1hGWSszTlBTNnlyY004RjlHVHBOV0pHUHF2c2ZWbURY?=
 =?utf-8?B?aHFpY1V4cGJlZXR0aExFVXo5QzMzT1N1TVRycXlMbFdjajNPWWF2TGhYZHcx?=
 =?utf-8?B?WmY2bGYwN1dpUnlNZjdCS1VjRy85dUd2ai9zOTVjcGJYQnhGdnBEYUFQK2Nh?=
 =?utf-8?B?eUM2YXFQeVV0cjlSMHhHVy94dU5zSEVFNkJhQkUxbnhlQXR0YkhOQkRBVnhr?=
 =?utf-8?Q?oP5l225SYuk3sItfBzVles6uO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb49f19-4c37-42cc-c8f1-08dd3962f423
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 14:58:52.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwAWiWkVzL+0/cZx2l/baf0AQpttgJdUK0634/9/ZYNxneNK9trGwHGaqWJD8ahGwiA+wzWdB1rOIX5uS+9yXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164


On 1/18/25 01:37, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field to cxl_dev_state for keeping device capabilities as
>> discovered during initialization. Add same field to cxl_port as registers
>> discovery is also used during port initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>   drivers/cxl/core/port.c | 11 +++++++----
>>   drivers/cxl/core/regs.c | 23 ++++++++++++++++-------
>>   drivers/cxl/cxl.h       |  9 ++++++---
>>   drivers/cxl/cxlmem.h    |  2 ++
>>   drivers/cxl/pci.c       | 10 ++++++----
>>   include/cxl/cxl.h       | 19 +++++++++++++++++++
>>   6 files changed, 56 insertions(+), 18 deletions(-)
>>
> [..]
>> @@ -113,11 +118,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>>    * @dev: Host device of the @base mapping
>>    * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>>    * @map: Map object describing the register block information found
>> + * @caps: capabilities to be set when discovered
>>    *
>>    * Probe for device register information and return it in map object.
>>    */
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map)
>> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>>   {
>>   	int cap, cap_count;
>>   	u64 cap_array;
>> @@ -146,10 +152,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>   			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>   			rmap = &map->status;
>> +			set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>   			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>   			rmap = &map->mbox;
>> +			set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>   			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>> @@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_MEMDEV:
>>   			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>   			rmap = &map->memdev;
>> +			set_bit(CXL_DEV_CAP_MEMDEV, caps);
> I do not understand the rationale for a capability bitmap. There is
> already a 'valid' flag in 'struct cxl_reg_map' for all register blocks.
> Any optional core functionality should key off those existing flags.


The current code is based on Type3 and the registers and capabilities 
are defined as mandatory, I think except RAS.

With Type2 we have optional capabilities like mailbox and hdm, and the 
code probing the regs should not make any assumption about what should 
be there.

With this patchset the capabilities to expect are set by the accel 
driver and compared with those discovered when probing CXL regs. 
Although the capabilities check could use the cxl_reg_map, I consider it 
is convenient to have a capability bitmap for keeping those discovered 
and easily checking them against those expected by the accel driver, and 
reporting them (if necessary) as well without further processing.






