Return-Path: <netdev+bounces-147618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094EE9DAB76
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8BC281F43
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E30200B91;
	Wed, 27 Nov 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EEL041Q7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6462433A0;
	Wed, 27 Nov 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723767; cv=fail; b=cO74FGJ6zQsE6GK1sVaBFYC5errxzgomzfFTYdwQVghNVx0xcq+nghGyVOsPdtBqCfAQQa6knlmL5a8tZ6t8oYie5MSp681TEOhnlXGobTU/2qaplIXxNNiaitDd7drvHE/ho3razloXdEHUAzy+XDnbBkj5uWrVVMYHKlqlm70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723767; c=relaxed/simple;
	bh=tTZhAQ0cWiQbaGH1c086vwejcnsBn7irGwv6kzyW0Aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VdKxvHbReyzDDpn33pzDM1Rt0McEH3tExbNodM/ElpVjPtuvxSAMzJ2msYokU8X3yzlGJX8XKHykswnz4m8kWbib3QbgI4VVwNcc/qEjcMnwmzrSix8SZpKe24SECx/S5XFkuuR0Ag6hvyOEQ3j6Mt9HRDPGGh7s8yGhiWuv00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EEL041Q7; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzFs+iuRSDZF3nOf+ktwPCfRH1daFu+MGjnAFZhkn2EYomdnKaR2m7BNPJCF7e4lgfm2nbC4q74T/zSsP0mvGX5K2w8PlL5Ugoj1n8fuINtseZcyoeJWAfreqw/3ByYs/S54ot26qAOmPtxB5tD9UYZnPFMSDvOudregKMAKoViqM5SHPC7QWtTB/v2lBnpkewGjQJvm7mjL97THA2jEBYBhxd4wnw+toHLbkyWG65C5sqpXwoXMQGDO/BxfnHFwW1ca1CDBP/VN2BbxZvrmDj1g+5BcACTG9bWMCEkbQvGI9tHQapMNC+JxpV+qNdZSPogl6HhzM49K49G4Qk0Bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugwP36tzunlGunVodkZAKgRKUH9fzCVT0WtNR8X03Fc=;
 b=yo2myKcM3QEhUSEBI+ebONN/oXFqvrn1xCWBuZTEPv7dBUQwTCm+jvOtjGvmhlqjRwXfrfMAkCnINP6eV8WZHL8136Pp4zmgt8327PaLIOJri0vQOnIIocgu/f5Pl40yxBPHRJWg8gKYHzH97hcxwSav/b5kK+Wz80qjtn+8A+i0uRx4S1CnY3LPjiiMXCY8lOTDtncOq7Q/3/U7OhuNi3yRHiTrItHDjT6Qlry6E85aLjj64ztkZI6QRtEPe1Xky3ADsiJwiDB2u5lZfwdAvUu+po5eJev9QLPchOMpslsjJ77KDbzRHVZHXyd7HA5UbP0GjykqV5fpoMUtxwNnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugwP36tzunlGunVodkZAKgRKUH9fzCVT0WtNR8X03Fc=;
 b=EEL041Q7QLO5Q9UTvfaGsU+bFrpABdPKkjOQazG5ETjAHFxK9CIxSgEP7yDIG7+JUHSBKZ/bi+pNjXVQzwv6agrsFFa58xVEt0cVb1FHxwB7bSdYPXf6y1BHYoAhMtMa1xyT6zbOUwrObj7KnjSkgX5iGU8U76LKSG2lw9isQ0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Wed, 27 Nov
 2024 16:09:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:09:20 +0000
Message-ID: <04c2b050-ff42-1957-7426-b3314aaeea45@amd.com>
Date: Wed, 27 Nov 2024 16:09:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
 <87e61d7d-039d-4899-975b-0797d3bc486c@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87e61d7d-039d-4899-975b-0797d3bc486c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::25)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: bf28c2da-8f5e-40b8-b00e-08dd0efdd9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lLQVNmMnEwZ0pYTXFQcHdsenpFRkY0bzMyM20vVTRFbVV2aXVRNUQ3dUEz?=
 =?utf-8?B?Q0g2ZjFqTVBKTG5yRkVFZk5xWTJhcDRFS29jQmx1eDYwZ3Y0SzQ2Y2pKbm5Z?=
 =?utf-8?B?WEt6YTI0dGFkVmZpVEhVWEd3aGpQWVRtSjlVTXZua29nU2dXTUVMOGUzSjdi?=
 =?utf-8?B?YnRxbmxjbnJSTzkydmRUU3p2KytTWFJDMjJaQnlnU1Fod0xGbGh1NkUzUm1l?=
 =?utf-8?B?VmlMZ1JldENrS1F5RENpZU9EaDYxY1Z4am1JMFdnRWhWUHg0ekV6TUNQejVl?=
 =?utf-8?B?dTRaTDRVcC9YTDhUTEo5NUtrdjUwa0hqMDQxVEhkQXF4UkdkWWdzRE9jSWpK?=
 =?utf-8?B?bXc5YjBzTEEvZVZUT2Z2eG9MYnUrWDdMQnVvVUxnUUtFOWkyVGFFK3A3VnVx?=
 =?utf-8?B?QXdqY0pGVFk4L2FJK3VYMFo5QzJwVjRXNU5FbG44dlRpUURQRnU1K1psNWVX?=
 =?utf-8?B?SW9LR1h2TGxTSTA1RWwvdUhqQjhMUjFLZnIrcVg5Mmo4Y1JHNVNFTzlHd2lV?=
 =?utf-8?B?NHlSdjgxbjZyci92QlhVaEhKcnhaOVQ1d3U4RU5kcWZpVzB0VEYvVUNRWVNM?=
 =?utf-8?B?UEdLMWNaaTVxNkxNWUN3K3E5ZzloZjBGQ1dRTUdQKzNuazBDTVpuOTAvZ05w?=
 =?utf-8?B?allCbjlLSHhGWVNrTVRFK1pHWnVGYWlCQzcvN1V4MHZBalI4enUyYUtXSXA1?=
 =?utf-8?B?Q3lnWmhUbUp1UWVaSW42TmZTYzFaaW92Z29zR0FGOUpmSzJySzZScnhqdTF3?=
 =?utf-8?B?VG9keUhPUjNLaFg0MWVlclp4eVJrem1hbzc4M3VLUm92TmpiNFhRV2NtblEy?=
 =?utf-8?B?Z0c5RzlXSEo2dVBtaDRLMDRZNTNpUzc0VkpBMzdDeEVwcEdNcUE3NjUxaStm?=
 =?utf-8?B?VEJvaTVRQ1NSdEs5d21hb1RnYkJlaUJXRExnK0JwVDRWYktNNzlmeHU5a0tt?=
 =?utf-8?B?ZENBZitRWElONlhDK25HUXVCcmpOWUdqZ2dFZ1V3dnBDdU9NVC9FWlcwWXpF?=
 =?utf-8?B?THhwWEF3bVBGd1lRUkZqSk9obzA2ejNVUm9laUNtcmdjRUlDZGluK1N5aTRx?=
 =?utf-8?B?NThsYzBUOGdNL0Zrc3hSYXZIY0RjZjBBV0loNk9OUjdNU1BYVkM1cCswUDRs?=
 =?utf-8?B?eXpVQUo3WkxsaE90ZjE3OVhVTDNJWk5SYzVnNUxlVHA2dnBWL0xESG1zaE1j?=
 =?utf-8?B?UnZkMHUvbGJ4Z0MxMFpmc2t1ZGhXZmF2RWFUQ2twQVVXVU9Fcmo3KzJlaUda?=
 =?utf-8?B?bW9aZS95ajlrVkxGUXJMaWpBUFhJcFNjNVlUaW1IK3I2bllJQVpidFN1dm9R?=
 =?utf-8?B?RDF2T3gveEhsdnQ4clFabWp2RjRQbVhidFBVa3hvWEpIQ2hHSTdLVlpWOGg5?=
 =?utf-8?B?YVpENC9pdkY3TjNud3NZY21wRGtYTnJScHBsZUd2UkwzZy9kQVV6VGFGZmFF?=
 =?utf-8?B?QzRlWmRIbUFhWTB0K0hsWnA4OWRHdHM0SDRZclVMR1FQbmxldWRvTG9GaXlH?=
 =?utf-8?B?S1JpYW81TE5UclRTNnFjc0IrWm9VOUp0Ykoxek93dFllSlpOeFpSb2dlL0xB?=
 =?utf-8?B?MENMYW9ZZ0hmN01tZS9nR05GZXpnS1pKWldyTzZzWVloWkUyUnFWWWNNUnpr?=
 =?utf-8?B?TFRud296eDh3NGFRNnRGYVRMQStrYk1COWZWQytJYk5oKy9wQy95ZlpMTGVy?=
 =?utf-8?B?YmhScXhUK3BxR3U4WDEzSDRUMkN0S1dPbWZLMEpkajUzS0xpcnJraEJ5UzF3?=
 =?utf-8?B?dktNZng1NjFGU1EyZWZOUzJZL1VQMDdvbVpCZU5PSlUyREF5SmZpMDZ1UUVB?=
 =?utf-8?B?bTV2ZlFzRC9TRXFJK1ZPQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFo0WEhqSXN3eFcxb0Z1TDd6REV2NXhjNWFWZVZQdEplcURvQXVLclFMalZu?=
 =?utf-8?B?SWlOaGhKYkxBZDc5T0RpemcxYnRtUjc4VE05clJPOXdZVzlsTnBUcEk4ME1J?=
 =?utf-8?B?ZU5EWGszREkwSFJja0oveDNwR1ljemp4VFlwQi8yYWQ5enJYTmJDb1FldGxP?=
 =?utf-8?B?aGppZklMTUFUVWJvcVRPcCs3dWY5UlFhMlQvaGlteGIxN3lMVFozeXJyT01q?=
 =?utf-8?B?L0xTbEZnWUFEUXZuVEhGRlFEOENMcmh4MGtmMmdMM3JtQlpRTHZwUnhZRU9u?=
 =?utf-8?B?U2J1RGpXYWpIRDFZZ0QwWWY1bDBBRHpTZzJmcUY5SFdvYlc1QzB5cnZ5TzBj?=
 =?utf-8?B?M3NJazlUcXBNcC9YZWV1bEJUbFAyUmZnc1VNemhxMFMyOWp0WW5lb1Fzd1pn?=
 =?utf-8?B?MGxvenRpQ2oyYXJHMFZpRVBtRElDSVNuczhKNjVoRExhbWlmS3ZONmZkR00x?=
 =?utf-8?B?aVRYc05uN1hUNnlOZ2FUdWJMMERZWHlycXhZdytxUlI5T3FPbFVXaEJEVE1C?=
 =?utf-8?B?cjc0emREcXJ4Qjc4ZVo3enlRM0JsVC9BRGNqUldzQTFsekxuMFlRK1pXVkQ4?=
 =?utf-8?B?U3FLSE5ZbUs5Q2x5SThQeVBWdWhwbll1a3JJSTZFd3hkRjdqekQ0cGkwSXZE?=
 =?utf-8?B?Uit6NndjSEJLNkl0RjJlVC9FSVc5Vkp4UVZRVkdRbmdlVnU0K21LU0JzRWVy?=
 =?utf-8?B?ZGxpbWhDSGYrejlXSjBSV2NoRm5pTW1YS3ZMSDNRcTFpOEo5KzhPRzdIc0Zs?=
 =?utf-8?B?eExOQ1psbVVEN09JU1o5Witzak41RmpOV0wrNWFUNGJxY1c3c0hNOThWUlJC?=
 =?utf-8?B?c2JqU0Rucm1zcWlWdVhnUnY1VjVuZ2svb25QY24vbEdOZmVVTDAvNTkvTWVK?=
 =?utf-8?B?RjBXTDl2REdQUUJCSktwL0FjbkpjcG50YTJsam9LRGRmWDRsaHBkTktHK3Vk?=
 =?utf-8?B?K2hNcWRJM3NOejhxWVM3QkhoY01zUVR4cHlUT21HT2tWVXpzSFBydmoreDE1?=
 =?utf-8?B?TStkbGJIc0FFc2w2bGh5YzIrUjFVOHBsZW1LNEJmajhSYTBoSXppQStxTWxh?=
 =?utf-8?B?dm1mZ2d1NGJmUUdyVW5uZkt5WnZNQlpERjFYUFlXbmpmaWVVM1NjK3Iybytp?=
 =?utf-8?B?aG1wZm1OSEFHRHRxa245WUNOaGVKTllBdjY4WWpiN2liM3MrWXQycUdXN1Mr?=
 =?utf-8?B?dG9LMmlWckt6U2JNZ0h5dVVzQ0Q3R3U2UDRQRHBsaklzOUp4S280Y3M0SitM?=
 =?utf-8?B?UU1odmlLRDJjMVExaUw5Q2EzTmd3MlFaK29ja0hrY2g2Z1Vza0QwZ296aXZm?=
 =?utf-8?B?RFl4V3RZSDBQTjBta3FaU3hRN28wVGVyaFB2Y0ZKbjhsVnlKa21Da3ZDTGY4?=
 =?utf-8?B?bDlHY1ZYZXpMdHhpZ0tVa3B6aTRLcEdLVzZ1WS84bnZ5R3RuaU5PK0MrNVVK?=
 =?utf-8?B?eGZma00rMmlESUZGcytEQlNOQTV3YWxuVjZBNVZITVdBNlJ6SUNpZk8ybUJi?=
 =?utf-8?B?bEVOd3BjSW8wVVhzRkl6czJlRWQ1VXN4eUVoUVBHUWh0Ymd4TVpHdkJHOFR0?=
 =?utf-8?B?TTB1N0ZOR2ZRUjcxVUo4ZWF1MDViMkpicUljdUVWcG1OSmFwNjBDY2s4MWpw?=
 =?utf-8?B?dTdOR0wrOFUySWtieVIwSVIzMmxSOVord1ZEbmFweDd6a0ZpRVZ0K1h0VVNz?=
 =?utf-8?B?Z2ZMRnhwSzRVc2ZiQjNUNFBkZnU0TWtJYnNSSEU5MHI3UVVNSFR2NmV4Z1Fr?=
 =?utf-8?B?ejlBOTRaYkc4cnhKcGdHcE1YZkF1NG9GdWRxVGZTc3REZlVYNXRwbnRCRjla?=
 =?utf-8?B?U1J3aGVsUWpoZC9KWnFrWExpK3ZGcFhqT2lqY01laEFqN3ZQL2p6Y2dHVUhI?=
 =?utf-8?B?anhHTGJ6Q3d2UXpnVzlDRzIzNWVsQ25jL1dNM2M2Y3VySWQzc0MraC9yUUpX?=
 =?utf-8?B?SHl5TUJ3VUlVbVhsR2hFa0hVVEVvMThSU1YxenZUK01OOWYvWUpCU3FoTklw?=
 =?utf-8?B?UmtSbXdxVVBtMGwrcVBDMTVOd1NDSVNIV3NOYXVqK0xHdWZlVTZyNmdrOVRG?=
 =?utf-8?B?cTAxYjBabEJaclpDYnkyY0k0RllCemw2VDg0OG9TUWdSSmZQQTJUMlo1ZUk2?=
 =?utf-8?Q?VT+uiOnwSVUIcDnnAoIc5+C/c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28c2da-8f5e-40b8-b00e-08dd0efdd9a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 16:09:20.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB8yCOGHzki3OljxREpafzZd/5Phq6lhyawS2YValISc3ZHmmgDB/dGBNxKLE8WzYHrsUFsk/4nikbUxD57Bhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902


On 11/22/24 20:45, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of clx_memdev_state.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c   |  3 +++
>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>   drivers/cxl/core/region.c |  3 ++-
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/cxl/cxl.h         |  2 ++
>>   5 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index e9cd7939c407..192cff18ea25 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	switch (mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index d746c8a1021c..df31eea0c06b 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_memdev",
> I would like to see a different name than cxl_memdev here, since this is technically
> a different type and I could see it being confusing sysfs-wise. Maybe "cxl_acceldev"
> or "cxl_accel_memdev" instead?


Yes, it makes sense.


>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
>> +
>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>   
>> @@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index dff618c708dc..622e3bb2e04b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EINVAL;
>>   	}
>>   
>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>> +		cxl_region_perf_data_calculate(cxlr, cxled);
>>   
>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>   		int i;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index a9fd5cd5a0d2..cb771bf196cd 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
> cxl_accel_memdev don't use the same attributes, so I imagine this modification isn't needed?
> I'm probably just missing something here.


This function is invoked for a Type2, as the cxl_mem device is created 
and the attr group attached by default.

So this is needed or the reference will be pointing to unknown data and 
the kernel, if we are lucky, getting a null pointer or a wrong pointer 
making things worse.


>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 6033ce84b3d3..5608ed0f5f15 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif

