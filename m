Return-Path: <netdev+bounces-154339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BA9FD1CF
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E591883554
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7314D44D;
	Fri, 27 Dec 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YzJvMKNx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8982BAF7;
	Fri, 27 Dec 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286779; cv=fail; b=JJjR4fwsVc9v2G5XlBihrLFsyU1VLP8clfLcJ3cS1+TWmE1p06N/d3RjzsmpLzRps9RMvgp3LB5Kkt7NtCWcXr7cJrw9PhLHxtinH1AxJDpX9z9KwYEt26MJUd+Q17zC8ajqV/hM2Pw13rerJtbFHhY6Qy9hUxS0XcLGK4/mKGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286779; c=relaxed/simple;
	bh=ircVMrTdwxOWJRjEGfdcoEoyWiUtdVFG6HIeXPB4/ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MushiybjKhCvahBW98XaIuErloBcqibOhCZ4mmcq/1NIw76YuPTINSrBKE+G798/vcfVIoMoGC+CYz0GecQ/vdA1tGeuHk62Pxhtd02UM82LmY+TM630icZcaTey8aNbj+Q1nythCgWgb3v+JO8TowJwutvxPFTlcyq9ZphCLwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YzJvMKNx; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYcrISvsglEuSZjGr4JQdchN9AWjwY355BZPV2d5ZqMxaEVmll2Vaw52sDCtTgNMk5ucj5xOqmLMuPw8NSMuKsOLSPvYrsmEqVOo6Rgj5RgQ2FZHZ2gQD3NrRaSNLyHIuJGBWGE+A5t1XFYKL5jnKRKJ//LiPLgy/xqFKXJAloJ2lMWQqjqgkQFJZD91F4PbZXGNZb8qDWbd/IDh1tkSfrVIqX6/I2TiRqetZDUzNfMg4B/P4W/gV0feqyWP11NjWCfADJyfph8kEv9vmcbUTJd5p7n0JN9ZHt8SxMe23DIaubGn5slfbgKIhVoGWRL6ZpGnpow9BEHPwDXOJL4igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKlpBmKgJC+9thoewf8iHNdrtTlSiLKVe+8IQ1I4/os=;
 b=mZDuWn4dJBzWBw37nCMwchytE48gCPS+4Kyzovf1NmMmYxRvGdYy6sR7uURtnrqeVTUpMDZzBlk1VSSoqOBpOsmNUdXv4/TjyGXpFY3/SnJcMBO0rXlKNH7fMHKff2D+VLHf6Lxh6XDvawxLuJ/jy7TnSK4BXvALP6bZdUrIzSAwqllLaIWGW2MXS1ibVHMt7/VtFxooJrnDlIBKrhAnkw7hPKPGIiGYY9UZ/xQfsc9FmXwYy6aswZ9GQgaCyqtyf0L+OHQLWavZ14SqINm9859yy+Izi5zkyq9pbNMw2HYwygYj8x0oclCAJcmVnpAFQVVW9YTyuu6xhw/AP08I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKlpBmKgJC+9thoewf8iHNdrtTlSiLKVe+8IQ1I4/os=;
 b=YzJvMKNx+TSJV5HozKliPw8YZ5scYbCst4hAnGJIdExoh1hkBeqJRDnEyBJRfo0Fpt9LkNjsNOTs0xlGCh/L8yWMcihRMzK54z/aGFaOuZ171f5ohfRH/4PVx3QXmH1Fk+W5JfMc6jqxy3+gWGSAEoQS/c2W7+DwWNWIF4pj4r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 08:06:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:06:10 +0000
Message-ID: <468b818c-fc16-4b26-3c40-99205d10323b@amd.com>
Date: Fri, 27 Dec 2024 08:06:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 08/27] cxl: add functions for resource request/release
 by a driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-9-alejandro.lucero-palau@amd.com>
 <20241224172535.000019e4@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224172535.000019e4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: f71c5e46-e3b1-4813-ebc8-08dd264d5335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0U4ckhMaEZGd3NYdmJLSGx0Z1pjQWhIZzlGZ3k4aG1tRzVPZWQwdjFKRXhp?=
 =?utf-8?B?dGVzaExUS0VhTTBSNGk4YXVwcnN2WStiTXp0RDg1T01vZngrY1R1SWlFT2Vw?=
 =?utf-8?B?TEZzSmlqUk1wanhVeGJzQzFaYzhrUXA5dWhwMDludlJ5ZGZxV0pqYjlWRGVp?=
 =?utf-8?B?WTVHd3JVaUUrQkhIQ2hsWllwS2s4RUlNMGpneE9VRllUVWlZQ09vUTdVQ1FQ?=
 =?utf-8?B?WXlocmRDZGIzT2FPNng4Rjg2SWIyYnM2dnlrdzF3ZnZpRy9sOTdzL2JJTUJ4?=
 =?utf-8?B?bEhadDNvV2FlN1laTzE1QW9UUEhXTHp0T25oZURWQkRRM3ltRlFQdFl3WFRV?=
 =?utf-8?B?U2xNRUw0akFUMk9vWDhlSEJRN0plZVFmaE0xRWZrWGdhd3RQVGhFUnliVjZ1?=
 =?utf-8?B?aUVzUzVzam9WS3Z2UllhN29zZFZJNVQybW5PQmZYUnU4RDJ0ajZ1R1dUdUVi?=
 =?utf-8?B?citIQTQvOEZXK0FuOU9Xa05NdDBZajdEbko0clBmb3JZaXZWN2dPTzV0b0to?=
 =?utf-8?B?VDN3Z3FjTkVFdGJhZldHeGpDY2ExbmM5WjU5bUh0Vyt5dW9HZkt6YkJ1YmJQ?=
 =?utf-8?B?ZTdGS0VEMVNCK244YjdBc2lieitZZXU2MzBGN1dhNWl2alFLNnlhZm9NZmg2?=
 =?utf-8?B?SHJySkd1R21NWHZiQ1JkbVhVd0dXVTFySzJoVUxlVFk1N2pRdTZFYTFaMkJU?=
 =?utf-8?B?Y0lQQ3dZSFVYeHlOTjI5WFpNck1HNFlWYXVwWmhVL0JmUC9uSEFVV3hRNzNw?=
 =?utf-8?B?NGpveGRpbU5Hc3lYVkcwUzlEd01xT3cyQW1OUGNKRUJ2L0JqZENFa2RMTmJS?=
 =?utf-8?B?eXQ0eE5mWmEzU1hkYTdnOXJWekR1VWZkV0IzUnA5OXJ2TEtKUGJIT0UzQkRr?=
 =?utf-8?B?VE53R2hrY09sVm9mclhZcDk0dWNXK2xKWko0QzRSUlF5SmJTeVF1V29oaUlY?=
 =?utf-8?B?cUFhT2syUVVSN2V3WFA1Um9UMlFQRElpL3Jpd2FEKzhkUVorZDdGUFEvSWNQ?=
 =?utf-8?B?QXovVXF0SW11c1NhUGFzWllIaWFjeGRQK3FRQU1UT0pMUzB0dnlpaGVxVzd5?=
 =?utf-8?B?d0F1aHBsanVDYnZyWjZDdGFkSldkNU5uV0huSngrSWpNZ3FhU2k3M2RuRjFn?=
 =?utf-8?B?ZW8rT2IrL0J4WEtuMEJpY0hSc2xETmxvdk02NklkZk9VdFFMdWlIS3NXSzJk?=
 =?utf-8?B?cTJ4Y3dJSzlDemp1eXEwcUVkTGErSzU3WlVCWnAvZ1RiaktXK1Jya2Vqc0xw?=
 =?utf-8?B?S0x2Vm1sY2NCV2U2WkJJYWRWTHpRRndkaWxrTmtFSFZjdFVIdkhYYVhXM1ZK?=
 =?utf-8?B?bWpjZGdPQWR5UWtESGRYQXUrbXJlSnlnNlUvQmNHL0FFQm9zK1BMZ3RKU3VM?=
 =?utf-8?B?L0JUQTVxNERjMjNqWDMvVTF6UDJuUGNabWdGbFFkTHB4cy8ySStTSTV5RUZ1?=
 =?utf-8?B?bHBSeDlYYmJLUGFHV1hUbFJXazhjdWNEOURHVGtUTlovUGdUcWZtaElFN3o0?=
 =?utf-8?B?MFJ0OW5DdTVjeTJMNUdDVWhrMzRZek9oem5LUWxKVWxmTGRlQ3RhN0lwQ1FC?=
 =?utf-8?B?anFwNUNnSzMzVkVHRXY2WXlwR2ZCMmRjckxtQ2FtcStqQ0F1U2VYcWlSRGVk?=
 =?utf-8?B?Mm9uS0lyamZUakdXeG9janVmeFB1bE40ek5teit1MTE4dXozWk9JazYzOExi?=
 =?utf-8?B?ZWV3bmdHcEhhdms4YkpvaDFTL3hRMEg0WWdyTkpHY1pJU3ZOUVlnSzlJa0hX?=
 =?utf-8?B?TXV5UHFiWDVEKzNHVzdzS1ErTVN5cVVqYXdJK2gzNmZsRDJPSnMvRUdxOEFT?=
 =?utf-8?B?YjJhM0tMYjBVWFJJSk45TU5YTVZTSGhMV0tFaTArZGNsVFg0N3JmZHpGVURM?=
 =?utf-8?Q?1kqqFt8MgI+mK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3dQVXJpWGxTVkZwN1hOSm1NbUZNYkRPWUU2S2pBZ2d1aStGR0hsTXBNS01Y?=
 =?utf-8?B?ZS9jaFhqb2lWUmV5RndZdmk3L1hDd0pSRnUwTnpqR09PcS84S242cjcxTVB2?=
 =?utf-8?B?bVcwdmVwdXBXTDU4UFFsbm90THAzSmoveDBrTFJmcllrNGd5TVpOZ1dzc2Nk?=
 =?utf-8?B?TmpiUlFYcmV0cm5GaHlBa2pxL1dzenRZVkpGeWZkZjRyOGVHb3lZUE5PNkFZ?=
 =?utf-8?B?SWcydTlFNkg1bEpYejBNZ0lTQ004WlhJVnZOMFFwdjIwSXJJRnhVK1AwSmU4?=
 =?utf-8?B?dVJzUy9MMk5OTnNKVWxqaUduZzQ1UEI5U2l0bk11eWQ3WTNOZUJqcWxrZGZM?=
 =?utf-8?B?bStyQmV2amRvczVzUmJ4Ty9MTGlLYXptUERKRk10UmNvNGsrK3M5bjBFNHJy?=
 =?utf-8?B?WmFlRE5DL0hwclVsaDN6WE9VSEUwbzh6bloxUW9JVkR4bldXVWdlQVVic1Ar?=
 =?utf-8?B?bTF6cXZIaHp5R2lxQk9hRFZzZGowMzFzMytIMTFHaHhrcHRRRGZ2YWRyYWI0?=
 =?utf-8?B?WGZzUHord3VyTjlZZERsVDc2cTJ1WU9lU2ptRWJtcUw1Vmw1NmN3ai9JRkt5?=
 =?utf-8?B?L2tJTWRiSTZXZ1ZwN3VaM2c0TWo5dUd6Wk96WDl2V2gzS1RwaGRCZnlGNFZF?=
 =?utf-8?B?UmNrTUZ2cnlDNzZMZzVWdGgxT3JER1k2dXVLVDFRVVI4dFMwVXdEZjRHa04z?=
 =?utf-8?B?aW53aGtaeTF2dzdUUUV2ZFVJUWVaU3FNRnZ0bkR0WGZ0dW9VWlNHdVJtcHdZ?=
 =?utf-8?B?UDF2WDFRNjNNRnV3OGZqb0UxY1RHVktIalBYWlBoYUNnZ0E3OFd6TTd6RGNO?=
 =?utf-8?B?Y3Z6UVM3cFJsaGc2ZUlGTExJd0FkZkkwZ3FWcExYYmd4c0Z6SkUyYWhML1Vu?=
 =?utf-8?B?YzZ1VndwL2ZTZjEweXY2aFlKNTBRQm1vRXZ6QnhWL21wM096S05hMWZ0TXY5?=
 =?utf-8?B?K0grUkFYSVhIRVFtajM5L2pReWhqRldmYXJWTTMxMzhEai9GSDBNdm05UDFo?=
 =?utf-8?B?UkZrR2h0VVBIZ21pR0hrdWJEcFg3eUJHWDIrSUpIb1RBdHpJNCtOTFlWTEN6?=
 =?utf-8?B?UjNOa2dURldSbVorWWhLQjZVbmNGKzFPWFRDWnFoMDMwMHcvcjdVTWNSK1hU?=
 =?utf-8?B?LzZiQzdtd2xJM1JDUzMxNVZuWU5MN1VDZGdjQWVFZ1RES1dYSjJOcGxvVG5N?=
 =?utf-8?B?VUV5elU1aGliZHdJcEthS2NteXExRHpiRkxhVHB5b1BId05nS1pMT3FmUTZK?=
 =?utf-8?B?THhrSThpNkpIOG5ORi8xM2ZtNWZMOEJjSjQyTTNJMUdqSFROdW14MUdzNHI4?=
 =?utf-8?B?U0hHaUMrZ2NmUU5KZ0UrSHJQZVNsSFU4TDk2WlBCekZGbHNTN1FtNDhTb2Qv?=
 =?utf-8?B?d2ozNGlRbUNwWXliYm8vMVZENFlZa0hCdkZJcWZ2Ym9YaXJzVUxaTXQ2bTlO?=
 =?utf-8?B?VGpGQnBzb2Z5ckVZaGphSWFuMU02Y1pwMHNOb2N4blp2TTBSQzdFRm5PVFVH?=
 =?utf-8?B?aFg5dzl4TllzMnpscEF6dDdEemZ1YzlMT2dRYkhVY3plUkt2VUt2aTY3cnF4?=
 =?utf-8?B?TEJac1VEQnBBQVp1Z1VhYnZpSCtaYk9FQUg1d2lkWS9NNUJYYmNTWWxrU0tz?=
 =?utf-8?B?Z2ZCVzRaYUFWTk0rVGhEN0x0NDZkeW56VU1kMGVlZHhUVkllMW53c2h5S3Nj?=
 =?utf-8?B?RGxFbTVNQm5QbFIrdXZaVGQvblNsV0pveVhKNjRNM1hBd3l6MnZoaVd3SXI2?=
 =?utf-8?B?TDJWNVJxZ0tHQ3JtU0xmTHF5RFRteElJTnJoS01MTVZMR2hBR0hUdmRPdytV?=
 =?utf-8?B?TElmVWQzSHhXUjc2WXZmNmxSb3JrcUNIbFlBdXBaaTBtcWJmWDJKd2RhalVJ?=
 =?utf-8?B?dUd6Y1o2WU9kNjRjNUhETXF6Wm1FRnltanI2YkVjN0RORXVWTG1hVWRXN0pF?=
 =?utf-8?B?N2VsbzlIMU9EV1JJZWxpeUttZ3JhZlNITnlwWVFIaG1NTnNSRit1NTl1UFlM?=
 =?utf-8?B?MnRWd25ybFBaVWdKd0dDTHk3ci93MHdhMkZuRys2cUlPK29BUURGUStoUHdi?=
 =?utf-8?B?NituV2RxNmxVMUtMNHptRGhCbks0UStDRzFTcHJYaVFaWWFrcnlrT2NaZHVm?=
 =?utf-8?Q?ruMqJBUDeadCSS1vTMrabcE3C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71c5e46-e3b1-4813-ebc8-08dd264d5335
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:06:10.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owzBfQIX8QYZ7aLzUty3CLmv3Hl+7w0yWlD0Igy8BJad7k5F9VMyCAYKbESm8slXFzTFN+LbXX/HfEH93b5iug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


On 12/24/24 17:25, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:23 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create accessors for an accel driver requesting and releasing a resource.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Hi Alejandro,
>
> Minor comment inline. Either way
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/cxl/core/memdev.c | 45 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h         |  2 ++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 99f533caae1e..c414b0fbbead 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,51 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
>>   
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_RAM:
>> +		if (!resource_size(&cxlds->ram_res)) {
>> +			dev_err(cxlds->dev,
>> +				"resource request for ram with size 0\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		return request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +	case CXL_RES_PMEM:
>> +		if (!resource_size(&cxlds->pmem_res)) {
>> +			dev_err(cxlds->dev,
>> +				"resource request for pmem with size 0\n");
>> +			return -EINVAL;
>> +		}
>> +		return request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>> +	default:
>> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, "CXL");
>> +
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_RES_RAM:
>> +		rc = release_resource(&cxlds->ram_res);
> 		return release_resource() unless a later
> patch add something that happens after this...
>
>> +		break;
>> +	case CXL_RES_PMEM:
>> +		rc = release_resource(&cxlds->pmem_res);
> same
>
>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
> With above, this isn't needed.


It is cleaner. I'll do.

Thanks


>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 18fb01adcf19..44664c9928a4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>   			unsigned long *expected_caps,
>>   			unsigned long *current_caps);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   #endif

