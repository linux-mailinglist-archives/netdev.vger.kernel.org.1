Return-Path: <netdev+bounces-171597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D87A4DBF8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B51775F0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CED1FF611;
	Tue,  4 Mar 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JDS3IVlV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFE1FFC4D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086595; cv=fail; b=FI5uf9iyIkS3E+JiZUL05/DuMaED3YxVkvZgfoDfZ5ULF6Y52IOPJQJb0CCQXY5laPaaqbtYA9dCmxOUb2jwppvVntngfuJLGgTocOnWjNjRRHXlES4UCFXF/mc+iAULPFJT6/Z1SEimkjwJKckdm0h6Bngl4LsXrX4aMAZGMYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086595; c=relaxed/simple;
	bh=lyOX7HmatsFJvaOtL4tlzctRaw2Bbrz5EZdyY1dBMbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUltrXzvpag+kNXz3NCJtG0Sw6gHMqtTS0HieII6xNgd19PkE0LxiaU4eqTZRLILMKI5cHwQ1vhxEaynyz7tSTL0L5JexsKM3HpUT3PipNNdWmI1IHd5CA3X1EGHXRWo3MipOoWs3mWyIqGVrWigRLm/7wB+ECjXojpc8LVpvVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JDS3IVlV; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dion8VRxT18GTNccjt5dp24IBPZr4bemspwmeFSg8gxtABwZIo1mdNKPA6SMxDTMpIZpVNc6tli/HBVFApvJnJk3NTFQLlnDtoCLP/BeRKiN3J7zMGZXDbUfGw7kmYIlycDt5fD6+oVebIGPFPm70qfMSBBJtvStO7mIrIhUqUb3nxQ4VzF8FNGSG6bx2lBJRvg6z9V0HmNDlFhIedVdYDnWdCA9uQMmJys9RWW8d763ryegnwEm7sO/OG1YN5OpPD81dpD2Bv7OAWGv04hgmFHKwyV8e7IHbUy7R2otKcAgqu0z+kuk0xKYX3KlsHrW0xofGpXYH785lkgjyzpQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUfAgtRDivwNGYbb643Vws5A7lDyDQ1d0LEllV+Cl28=;
 b=w6Xya/OxTu6I2OxXHiAZZFe/qPdOZOPWKQGZGdx9BTCReufLQ8VaBbE2wdcWK04bDsXX0M+XhN38GEx+H/wL814x5JwQI7hhgktBU7xVFMVjYmO8wWGAQn5dHyPZzVi2m+k/WJ0H4X53VYRG3RMfYA8WRk9yec570hdKcOoCdXLYEOLB9TctrRqzph19Wq5nmcoy/1bqepHzm3dxFkvY9zYkIBCifXN1KG/t0aKenQH7gPu/dGuinfK7QnG8Efqhyt3X5fpbEJjTj9IryPW59Ic8zSpIMYPOVXb+QCHIh94NvfWLM5hSC3TwMti/yFmK/Xetoo6ytTZEVg7NxlFzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUfAgtRDivwNGYbb643Vws5A7lDyDQ1d0LEllV+Cl28=;
 b=JDS3IVlV963x1U5G6VmClC6odFCZZQFzKF19qbWg0fP9jGqXr6IzQR30KLGuWNfbRh3aUKyhgl2qjG/jgFR5X1vEIU6hKCaXxYcboIrORV9XunBlsDx6OjYlsq3w1RYhgixf6LJ6CJvtqb20S+K8hzvOQcDLhotTNT7ng4WR6fpQmo60OtdLMLj+Uut1nz9YAGki0wfQHHuRT0chHf+w1VXnptX3o/Vu4vYVLhx4gxH6hmZHt1ed+o1S9Vb8sus/pYLglw3h4t+pmAMSSYH5wX18ApZ8WZARer4hpTpHWiCislaWLA+p/qy97gqJFmwXnS/UNP0ZgnlrCsAZLNkY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 11:09:50 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:09:49 +0000
Message-ID: <a548dd08-48f0-404e-8481-3fa5fb3090a4@nvidia.com>
Date: Tue, 4 Mar 2025 13:09:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org>
 <f5bf9ab4-bc65-45fe-804d-9c84d8b7bf1f@nvidia.com>
 <20250303141717.67f6d417@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250303141717.67f6d417@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::12) To IA1PR12MB7496.namprd12.prod.outlook.com
 (2603:10b6:208:418::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7496:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5bfef4-b29a-4365-fd09-08dd5b0d14ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDQ1ZFpVSWZJZFgrdmpIbk5hek1VdXdOZFFLSUtGaGxYQU1VOHVkbkR3dTJW?=
 =?utf-8?B?Q2dWTzNsVUFwQTIwM0JqTVAxWmxDSGNvODdZck44dlpEK0NYMXlMbnBOck0r?=
 =?utf-8?B?UE1TRzh3eEVMbTYrQzAyL1pIei9FUXZXaUpNd2JoemEwQW55WkFWbW1LM1d4?=
 =?utf-8?B?bGNEWnIwWHp2dmI1UkpILzBSZkFBQkFjVlFQeUt0Wmg3aDFIeGIxSHRxcTlx?=
 =?utf-8?B?Smw4WTNuSUY0VXgxcHYxVWhzY3ArUnZVYUwzeFp4blBMRTc2R1U2L3crNm9S?=
 =?utf-8?B?MHUybnNEWE8wSnRhc2RDcndneDRnOTh6ZHh5RElHS2k1U1BJZkZmZVpRdlVG?=
 =?utf-8?B?aFVyOWtwQW8xR0V0cjU4ZjFrYVh6WGt3cDFTa1lHWllSM3ZHd3RzVGg2RVFi?=
 =?utf-8?B?NCtORStNMEhoZ3lkODZFYjNtaWZ4U05BQUpOQ3dvQTU4bC9ENTZaRXoxaHFz?=
 =?utf-8?B?M1I4OWliaVZ1T3VMc1pTc3dBWmRoK2ZRNVZXQnhzYmlSc202V3BLS05VUTJX?=
 =?utf-8?B?YXFiMFRTd0NLcE1MWjhyeEVtcUNrcTRvYjJsaVY5UVd0dk9NVnZOTlNmcjcx?=
 =?utf-8?B?aE5sQ01uZ2xOcDVTSWdDTCt4UHdyblFCQnhEb1N2aXVTUCs4L2lxWXcvTko0?=
 =?utf-8?B?Nm5SbmkxdXFlRWZOVXNWUWZxVjZVWnV5UTNzbWt3Y1I0K2ZKMEtZRXlybTJC?=
 =?utf-8?B?Q1BtNjFqeUM4ejhNT29wcTZHSkpMVzkzb3F5eGl3STVsZjhBOVlBekpjUFhi?=
 =?utf-8?B?RTRRWWxtUm84ZnpxV1NsNzJqVG5TcGpSY1lEMHpkbDhMVlR5aTR4dGhuL0w1?=
 =?utf-8?B?QU9FQ2VqcCtMQnVNT1hGU0l3TFczQ1dqNllFbjRQVmZYNm9HRUZLSGttU3Vv?=
 =?utf-8?B?WVViUGdldVZtalFjSmJsdzI0N3dSQ3B6bUQyWFd1cGQrc2hZZlA4UDZZZUR6?=
 =?utf-8?B?VUh4UzJ4WlQ1TWhtZnlockdRSGpJRjlXeEl3THVXV25RRFMwbDRhejJKTVZr?=
 =?utf-8?B?RjlWa2kyOEVrRUt2SEU1QWJVRkY1VlNMcGU0Q3NVMFV6MG9Eb0N0dDRIRkM1?=
 =?utf-8?B?Nmp3VS9jZGdEVVNUMjAxRUxWMVVXYTFLdTN0TDkwYjJxTG40QjlScDI2dXhT?=
 =?utf-8?B?TW1zMlZXaE1HVkNRaWpxdTVpdlYvY05DNzUwWDNRMktoZHFodlBlY21CY1hY?=
 =?utf-8?B?TjhsTXdkWjBUZ1B5NUM5NVk4aEFtSTNDUHJSMWZQekpNdkFkNzBIRTAwNDIw?=
 =?utf-8?B?eS9iNXMxRW9Bd0dTOXdSMEV1cXd1aEpENTBUTHp2OTFFV0NRamVjMW1zSG5h?=
 =?utf-8?B?b0VIenI5dngxcnVSNFBPODR6alRKZmtWeTE4NVgxa1dua0lhTjRsNkQ0TnF1?=
 =?utf-8?B?Q1VNMXdCQzMxRWpmS3dRZFAyYjdKeDE5VWJzemlwY2VIQ21KM1VDUVhoc3NU?=
 =?utf-8?B?WUlrcG9aSk52S28xUHkvQjdiT3RiUkcwYmFxcUdqdHVIclBFT2xRbDRybFha?=
 =?utf-8?B?YTN2ZFN6S1FSV3dGeC9TNS9DYmhzUE9NaXJNSlozSEczbE5MaTJBeUVWeWVV?=
 =?utf-8?B?aVZtd3NWQVd4VlUycDcvYWNkc3M5NXVWS1oyWTVhbWtUSDVFbHdaK2VKUUVV?=
 =?utf-8?B?YWIwNEwyMXROdldDaWhiUEVyVmc3NEhscG9DNDZOWEc5RlVNSTc3Ym9WbDRw?=
 =?utf-8?B?eUQvekl1YjJRR1FNV2p2V0tkUXpzbWZLYy91cE9aRTZCa2M5SlJLTUZpZjVN?=
 =?utf-8?B?OWgvR1dnK2Zic25OZlZDZWQ5amYrTlR6SkFxZU0yOU01Y0VEUmR6eVpIOWlp?=
 =?utf-8?B?ajZHK2N3dk9sWlVaRytoMm85aHA5L0pUczhzZ2szb0pmSWtHOHB1S29mbVFI?=
 =?utf-8?Q?FzczStfFosVBG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFpqQlBoNCtzdHFLUWRVL2lDVkRnZEZKM3NJVDQvQW9pdHh2OEgyVmVocVE5?=
 =?utf-8?B?ZDVkeWs4K2R2Wjc1SGhPeVhRZ2c4WHBPTThCZG9ETXp5NkNjRjRSMG42R1dQ?=
 =?utf-8?B?WTlTUUJsUTRVMG5XdHRGYTRxSkVybm9sdkhDMVBrMlh0Wld5YkZYbjJ2ZEh0?=
 =?utf-8?B?aDh0UUx4MlAzOXhwSW5Jamoxb2kwUktONUo3YkxyYld1bkNPaE9MdUh0K0RQ?=
 =?utf-8?B?RWtzbzkxVjU3akROeW9HMG9GQmNyQnd2WUNETjZlUTQ4NkJlUEc2Z0cxQWYv?=
 =?utf-8?B?b3FCbkxqVjlzbk1oOTZmTEN6MDU0aWZ6NUVpbjJmbWVpU0dKRzJ2VUtjMmRt?=
 =?utf-8?B?UGlaRWw4emhqaDZEY0lOempaaW9JQitXTWpLV2lKS1plQWFvT0VWSHpjRTNk?=
 =?utf-8?B?OUJwK3p4bTBnSW9ZL202TkIwN0MrWmNFdThGQWljK3R6UVFJWEVyY3l4aHg1?=
 =?utf-8?B?ZStwbDNTeUxYZS9wL0ZMaUVJb29YOFcraFlXeGZwUzZWaEhDMXpxM3F0bUR4?=
 =?utf-8?B?V1lXdkpHWHJsdlNsOENDLzVjRHRGeDJjYWFOWE1kSS9xdjVvS1hZSlEwblM4?=
 =?utf-8?B?b2k3bWE4Z0JwN3N4em1yMWRtN3NxSVlSMitUQ01ocXo4K21NWFVTVGVIMnh5?=
 =?utf-8?B?UStIOXlFZ2JnY1Z5ckQ3M2FCU0JMQU9maUhxT1kwck1CaVZHYkY5NzFQK1Fq?=
 =?utf-8?B?bjM3bC9xQkF1bkNWek4zeHo2MHVoejh6NTFhSlRMYzZXQTR5dks2cnlYbkpL?=
 =?utf-8?B?YzRmaHFGaVlEV25Ma0J0WExsa3lUR3N2NzIzVTNOb0xNby8zQWxqVHUzS2JK?=
 =?utf-8?B?ZndCSjlNTTR3Zi8yQkZCQnpBTSsweGp5Z2xMcmJJWU1sV3lvdU9yc2t0MVZx?=
 =?utf-8?B?bUEybkw3QjVlS1JyL1NOT2VuM0hXRlYvUmVndHRwK01Yb1hMK3pSdjJYS3FO?=
 =?utf-8?B?ZDg5S2tNa0tGTUlkWFovQWNwNHZjK1BEanRkbEZnNWZGU2tQZXZVU0xrQ2oy?=
 =?utf-8?B?VTB0N2NZclhBSlRuaW5KVmk1cTgyV1E4ZHBZejhkZ0hPTmg4YWNwbnF0OWtK?=
 =?utf-8?B?cUNhbGhhK1YwNnN0V0cxcEthTGZocWdENzVxajlmbE1HUnRINFJhK2RTMzFT?=
 =?utf-8?B?YTU4Vkp4U01iek8zbFJYOHJjL3N5cGVxL1RFQk5nNjNnS1ZUR0ZOdzlpM3gx?=
 =?utf-8?B?emNua0F0Q3l3SlR2cjY3WWY3RHZoZTZzZGthUmFnMkJsNXl6VHkrZEoxMUUy?=
 =?utf-8?B?TXo0cmI0SjJRaFFnaTAxN0lRdTZCY2JjZFg1UFRMNkQvUWZCWkpIckZqNW9S?=
 =?utf-8?B?L3B1SVEzcnBqdG1uRGlGa0ZKbFBKTXV1bk9BOTU4UElLdDFYVjUrcFJ2WjB4?=
 =?utf-8?B?VzE4RmEzL0cxdlZxT1N0c04zZDAvVmpweUZKY3MxeGlzbDJDL0ZkZ3VYYXJ3?=
 =?utf-8?B?enlkM2Nia25EOXBKSVd3Y1dSSzVOeXhLTW92RWFQT3Zhb0dud3QrS211SXVX?=
 =?utf-8?B?dTFUUStFTFNRekREdDZPelBGR0puSGE4V2NpS08wU0p0L3p1eWUrVE1DR2JP?=
 =?utf-8?B?NjNWemhiUXdFVExDM2ZuckJiUzYxaVZZVVBLaGdISU5MTFVVL2dKYjdrM1Vm?=
 =?utf-8?B?bG5mWmE3bE5jWWtHL2svbStXMkpuTnNUUkNpZHFLTVBZTDQzMXF0MGhoNWxo?=
 =?utf-8?B?NGVGRkFGVjgyZXBEK3pBbWZlMjVNL3hTQ1ViSkY0REx2eFRTTmJMbXFwQVBK?=
 =?utf-8?B?UWFiZHRGVnlVbmFZcmwvRkhMSXh1MTA0d3JGRE9kTThYUXBYMVhTMW5CVnEx?=
 =?utf-8?B?SHd6ditFUUUwM2gyYWhzZTNZSzlpdmV1NzhpL25mSWdCbmlBWFRiV1NzaHp4?=
 =?utf-8?B?VXFxVE1wRnRXYlhuYXlvT0pyR1BoTU44a2IwRGtQaUFvQzZXMzFXWDlvZ0RL?=
 =?utf-8?B?YTNEUHF1WFBUOUV1endCdnN0TkVNaGIvWURVdW1XcHRwbTBRd0c0MlNwbFI1?=
 =?utf-8?B?bDEvKzd6NWpaYnA5di9hV2hTQlB2bDhjaklsMGFtME9XQ2pTbUI3WmhyVHlJ?=
 =?utf-8?B?UzR6dHNqaUsvVmlqbnpPOEkzenVndHRuR2JtZ1FHbU9UZVFnZlhoS2xCM3Bt?=
 =?utf-8?Q?HtAyidNzfTlLqYPnIk00uulNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5bfef4-b29a-4365-fd09-08dd5b0d14ae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:09:49.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr//+am8jAk+2QP9XzR56VkAQ2Dl2mBzoAM6OtxKYqyag+QQ4j+wU/aConrWLuJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

On 04/03/2025 0:17, Jakub Kicinski wrote:
> On Sun, 2 Mar 2025 11:55:34 +0200 Gal Pressman wrote:
>>>> I can think of something like redirecting all TCP traffic to context 1,
>>>> and then a specific TCP 5-tuple to the default context.  
>>>
>>> The ordering guarantees of ntuple filters are a bit unclear.
>>> My understanding was that first match terminates the search,
>>> actually, so your example wouldn't work :S  
>>
>> The ordering should be done according to the rule location.
>>  * @location: Location of rule in the table.  Locations must be
>>  *	numbered such that a flow matching multiple rules will be
>>  *	classified according to the first (lowest numbered) rule.
> 
> I'm aware, Gal, but the question is whether every driver developer 
> is aware of this, not just me and perhaps you.
> 
>> The cited patch is a regression from user's perspective. Surely, not an
>> intended one?
> 
> I believe this message should already answer you questions:
> https://lore.kernel.org/all/20250226204503.77010912@kernel.org/
> Fix the commit message, add test, repost.

This is a bug fix targeted for net; the test should be submitted as
net-next material

Just to confirm, are you making test addition a prerequisite to merge a
bug fix?

