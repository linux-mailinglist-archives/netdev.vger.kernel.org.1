Return-Path: <netdev+bounces-163993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBBA2C3F8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE83E188A7B7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE41F4E48;
	Fri,  7 Feb 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dgEFejOH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0121EDA3E;
	Fri,  7 Feb 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935770; cv=fail; b=OPOHBBk+1A0pmD7kSdGbUJLkZk18etaxqE2L7K9Uh1sJz9bReDu8HQSUHEOr50rNawIhXibymTKoRJZs5WUtkkPkah7L6V6xjO7sRhPaKFCmJcKGAiwadax5PFj/NOu6kPLOPGJwQCwgppQl68/TFJ4mDcz/Rz7F98GhwaYWedg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935770; c=relaxed/simple;
	bh=Akj8Cia6G9mYnCNaNpVK8vKc1lqRs8Ipe1QUSLEqxV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUEz8twdD2naoyA3bFsi8bAAtI9MSjVn7vHoEewWA/SIV/yR1OZ0spZCSXNyLpWWsyMmqUGOWgC1x9ay8Mz/+H7y/4f1EubJ9SQe3LgAWBlg0rc3j90h0jEHvyDt/BbhuIXz7bX7AIuoxuW+99aZ23d+9Z8vSBOnN5op0m4A6fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dgEFejOH; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSqXCuQmPdVmQ+dPkQu1LOKME16PnbOOf8PdpUM5ImYOSix7fda/tHIijFKqbIFOam+UeMjMUn4iqmhtSEBXf1/TgIcNk4A/yDzl0034pVi62ZPylVn5pJ9tdNXPMRMD7ISOj0Ef9k6t42mZ+lEG1FEfgA+EieX6x4r6ppK+JCwSGOozYDx+dtwkQD/AuzDWlvD7lWdS88Wc7z6QChwEIYMQI3W/rjY4O1RpclxGD8AuqNCI5z7aw/2hC9los8WBfVA9WBtk+knB1kGYxi0AjJ62vecziIOLWIzkkYl7jTD4JogbU9mx9dd4eSNo+t6FV7R9QQWQr6t1njaKDtZGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1NCMaRjDyuVtAdIk9052UhepOU0ihmynhDlii2mi/M=;
 b=PjdTd+sNS+KPsIxmlULYpA+J4ftEXSkOZ4tJwoLWNn1eEhPuK9k7TkAJwtFL5IS5iu4jaS0Z48KHuTcPZ+VX+tAOypLFvnpjFoPPC1L67tlbK46Kv+6Et7xbWqtaZALI0jFTi559QyZOUDtiCc97CM0OLdKPS2ny3bEPhitGko+nKNLVESwlzrDODoo080gExog9jyeqLfz4YGYI+IVTkv2sGtz24EuakKMXDdyfkcAUw7thNhX1Z9ZWRMB9OZIi+grkTUu/uxzZ1w5EUR9cZESsU5CczhwunD2EvNwaWh6tTUgNJiO23+BhCf9v5lEBBgOtViTpmMmMJ1sU3HtLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1NCMaRjDyuVtAdIk9052UhepOU0ihmynhDlii2mi/M=;
 b=dgEFejOHZUXGM1O55KUvs2gQarriu03Bhe3cp/000iqb7VtbsKqF6S2b3WUdxJw2/IUx7tpT+W5i6B5YOzuYhFiYdQyEwau1olGwqueYEZhycq1Zvsf9QMj7Z9x0iAm4j9vpWA9Fy7NPs6mypGMe5ZQEe20z4NLhAVFVSoBVeRM25fBMPN0/rmreyYJi6iLkhkll2FLN6ag/AOgobsP/FG5l3+7SYqPw0+ztLIhhzKmNMS0Nb0XXZuPeask/AWfXGluX7jI5sFqhPYKv/cOdOWlHq7q1ijAB7flVKxMj75UW2SD5ujB5NZxOSnRXDGBEO6+Scz4EmKaY5BleLQBASA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 13:42:44 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 13:42:44 +0000
Message-ID: <5d9e68df-9a66-4f84-b30d-3789cbed0d71@nvidia.com>
Date: Fri, 7 Feb 2025 13:42:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Furong Xu <0x1207@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>,
 Brad Griffis <bgriffis@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com> <Z5S69kb7Qz_QZqOh@shredder>
 <20250125230347.0000187b@gmail.com>
 <kyskevcr5wru66s4l6p4rhx3lynshak3y2wxjfjafup3cbneca@7xpcfg5dljb2>
 <108592a6-de5b-4804-92ff-c7d4547beff0@nvidia.com>
 <20250207170744.00006ceb@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250207170744.00006ceb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc59fb0-4902-42a5-ad52-08dd477d4cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2YyYlBxdUUxWnVrOHpKZHhSUFpiVTNJSXFOMGxwc1lJcldPZjFPbTAvb2t6?=
 =?utf-8?B?UjRjcGl6aFFESHFZd3JLOUI5SW1sTG4yWjlGVHE1dW92YXl1MGpCZDlsR0I0?=
 =?utf-8?B?Z05IKzZWRHBEbm9maTlnUld0dXFlM2FXNHdHdHNLbFRMVXcrbnVxSUluYWFs?=
 =?utf-8?B?K0kzYzNCSXFrL0tKb3lNa2RmZmNGbGk3c2dMZ211NUtmdmZTb2NJV0J1VHZv?=
 =?utf-8?B?VStwZmF1QXVpNHljUVBWM1haQW5NWG9oUStiY0ZoZzVjYUlxZ09Kb2xJRkpz?=
 =?utf-8?B?QVNqQWRDeFI2RmtOZ3hQOEQ5VWVLMUZXVmMyM2xKM0pMMHlvV2lGdnN5WTdR?=
 =?utf-8?B?RmtYZDVGM09ibFQyb2EyNHB1R0hNMkpaeVpSaFVxZFczb2lpYjN5RU82TDhn?=
 =?utf-8?B?akNxZEg3QzdLQ3kyd0ptMkFFV0VjaVVEMnF0Ylhld3BZZnpJcVdGcFZ2RzU5?=
 =?utf-8?B?THg3S1BtTlJSL3I4NVpOdjRkd0hZNThBcWJmSlNXRzcrSU82empqZk1RMVFO?=
 =?utf-8?B?bmJVSytPcWZGSkNuaUlvTW9xems1U1BoZGxVbHJHUzIvU2Z0ZDhrOFFMbGIy?=
 =?utf-8?B?a3dDVEg5TVlhcFNVUHJtT21LT0ptRmJtS1dhS2NXRTl6a01MZVRHYjk3Wm16?=
 =?utf-8?B?QnN4Z1FKeFpjK2lsOWhnaEs0K042ODlvMmZIWVNBZ1dFeXdtTCtid01IekhW?=
 =?utf-8?B?UlJmYkFubVg4QThJOTY0cmFheVlMczdwT0dyZC9mbTZmZlk1WlN1ZmVSMWtF?=
 =?utf-8?B?ZzZOY3BVbXh2dnRSMU0rbFAzTzlKVmlCZ0pMWE9EMHBadW1hNUFJWlh1TzFk?=
 =?utf-8?B?Qm4xL1JublJCWklrZFgyaXFZWXlsTW0rMlhubVcremI1Rys3Vm1hYjdYN1ds?=
 =?utf-8?B?c1l6dXhIL0ZEV2RhbFExcUxWUkJSRUR2V004eDd5OGF3aklUaHBPOXlQSzlv?=
 =?utf-8?B?T1k2a2FPMEVKSzF6MHZaZkE3UUZrZmRwTzF0dHh1Qk9sVCt3YUhqVUNNbkpx?=
 =?utf-8?B?YjRNb0E0bFhZcXAvMVB4Rlo2OXBlcitURVdzQW1icmhjRWVnM1l5RGMrc2hr?=
 =?utf-8?B?czJBVmVYSlV4d01KUFhnbFdTdk1YUmROQ0VBL2V6QXpaV3ZKZ3ZWR29BMkxt?=
 =?utf-8?B?L1AyREpxRkc1NFNBeGdjSGZxU1pseFhEREgxNW11VWhLckJhNlMxcTJYUGpV?=
 =?utf-8?B?dXZvZE1PMnduZjNRc0h5ZGd4YmczSVpqQVJab3ROZ0R5dXZtUEREL2FlcTAx?=
 =?utf-8?B?dFdMQkpXeEh6RTBOVnZ4c1NrUzNNVjlWRFBXU0hxT2l2MlY0V0RwdXpJSWtZ?=
 =?utf-8?B?d2NQSllZTlpvK1h6ejhYbmVLdzNWY3NqM3d0cVBMODg3dEZMd3I2L3F5VW9Z?=
 =?utf-8?B?RlBzL0VZQUxXWk1DQ25ZV3JBTWdOUnBUREVDRk13TGxVLzJ1L1duNzRIMWtl?=
 =?utf-8?B?dmpXSUxXQURwb1RSUHBIektBSmQzZ1B2bllqK0U0eEloMnJoQWxOdmlZVnlm?=
 =?utf-8?B?dVBqVytzdHFBRkEwdHdheGdjRzdYQjdOSHcxUGdsdmJwazEwTVIzREJ1VXh6?=
 =?utf-8?B?WC93K1NWT0pRWUhRemZ3Vy9UVldjQkxUWWVrU0g4Y0RSTWtJNzk1ZTBYNnZm?=
 =?utf-8?B?WUMzZmFvN0xpM0RIcEQ4Q2FmYXZBYzRaaVJXWWs4YkVudzJKRm1BTTZ3R0xh?=
 =?utf-8?B?WEFCRFA0cGdDbW11YnliU2FsRUpRVFhnN1FBNG56d2xDeVZaWGR5YzZnZGYw?=
 =?utf-8?B?aXEya052MXhldGZHbzhRRGtoc0RsaTg1aWRUWFZrVTkyb3FWUVo1Tmdtb3M1?=
 =?utf-8?B?RGFUbmJHMHZmUGtKcGp5cWVlSk9hZUdJWjhyankyV2d3ODdDUkhVT0xENEZU?=
 =?utf-8?Q?yoZbogzCqv8Qp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3RSd1FQTU0vVUtqczk3bDlYdEh6aUFQWHFnU05HT0VITEg5NEdKaTFkMGh3?=
 =?utf-8?B?YXNQNUlMbG5DRW1ZdXR2MXc0OEwvRnEzenc3NzAwZ3RxdnZLOW9OUFFpOFRV?=
 =?utf-8?B?S0RyWWI5SjlrZFFuanpST2l5aHZhdWNPOEI5SDZMc3g0Ky9EVUZjcGVSd1FD?=
 =?utf-8?B?emdEVW9SbHZsOW5sSS9WVi8vcnVwQWhzZTg1Y0hialNhU2xPMnBSUUFTdk5B?=
 =?utf-8?B?aEhNSW5NYXJXVmw4b1hzYm5TV3VXNjkvWlhaUng0M0FVa3JuS1JPcFBFNHpa?=
 =?utf-8?B?OXpFSEFIMUY5NkJLZ2JOTVhsUFBsRkx0aDlkNFdrb05tU2l3Vyt2ajdVbzNr?=
 =?utf-8?B?ZVh4N2JMU0pQVi9tU0NuL0NENW1mdjlYcmdMVEpqcUh4S2VRSG12MFl1ZFhw?=
 =?utf-8?B?UFVFT2pidU56Qy8zU2l3M3pxWXA1WjhVTDJLRExUV1dWci9naEk2VnBScnZU?=
 =?utf-8?B?ZlB3c0dJVzVpVFhtMDJZbkxUcUVFZW1RUlN1WWJDVVdkWVgxVGFPN2dSc1k5?=
 =?utf-8?B?NlV3SmlLYXAvbys3czJxbWJ2VGZ4ZUtONjl4ZS9vaGpPM0szbjNGYjJkY0ZN?=
 =?utf-8?B?NmFQeVByNWpuelVDaUJRWVdnL2psaW0xeWhEaGVHSmpDeG5hb1ZROUFGM2Zl?=
 =?utf-8?B?ZnYzOXRYdVBicWdjNlpZdUYzeVpHVWwyQTV0VGgrREVERjNhaTdmNUt3MTlR?=
 =?utf-8?B?VmlQcE5uOG9mM1JSbGlIaDhac1BYZkl4UU5VTE5TS2JIUjM0aGlrWUF5akxv?=
 =?utf-8?B?YlhFV09zbkdIQy9xdlN3M2hJS3BNN1BOREZJeCszNDM4ZnUyRDFwanVYTmU5?=
 =?utf-8?B?VEk5dnFObXZsc0pUYzVxQjZ1TGxONExhckFyNlNwVzQ2bEdOSzFLYVlKUFFu?=
 =?utf-8?B?dFNFMjVjQS9rbmxGRW1aNSttTWR6cTJBVDg3S25KbjhjeEovV1VnUDBId0d6?=
 =?utf-8?B?SkZoRDFhOCtjdnhXYkh3NlZ5OVZTQ25LSlhnS3ZMdmwyaTVlOUpLYlV5S2JD?=
 =?utf-8?B?Vm9TTDhLUGJkSDgrN2dRdFdUcXFRSjBpdDFjZVBhWVBkbXdqUGpsYnFJS3d4?=
 =?utf-8?B?VlQwSlNXREdCRU03RFp6TzdvYUtSZ1lzNUZQUVRaSXJZK1NyRS9Eam5TNGxD?=
 =?utf-8?B?RVBQRTJvTU84amRMeFltdy80akxyVnY5YVoxbDlsbzEyY0lKV1U2ais1SDNS?=
 =?utf-8?B?MktqVlRzSmljOTVsSThJUUJXNGxQTmVhcTVlRDhlaFFuQVZ0WE90ZEdieTlN?=
 =?utf-8?B?NS9iT3NJYzYxbW9uclNYY1JFMEwxZzNPbUFCMnVLK05KbVJBSmQxTWJjTnBT?=
 =?utf-8?B?dFNWNDRQYUZWc25IRnZoQlEzNmtOMmp2cERVQ0JKc3RlVU5uRnFKVkpDbkQx?=
 =?utf-8?B?K3prQzNoWnB5RWszcWtjVEVBWkU0dTEyUGJHUkFjaUZra1BvUmFoREFRenlZ?=
 =?utf-8?B?ODJPU1VhME5RdHdaY3lTUzZKWWtMYWphbHpkamVQSVp2SmoyZFdLbkNVY0Jy?=
 =?utf-8?B?L3RIaENMOGlEU2NBT1pGR1RLM0RhQ3BBaW52VStmd1E5Vkw3YU41TnlzVlRU?=
 =?utf-8?B?YmxVTnFEOHpzblY3dVdsSHkzOC9jdEZaYmJNd3MwY2V1UTE3bmZra2V4bXQr?=
 =?utf-8?B?M2VJWWRrZVRiL0FiVU8vYWh3anQvZ1VWZ25sT1dMcHRmb3VvNTFjNWg5SVFS?=
 =?utf-8?B?OHAwdmtXV2x6MG81WkkvSUttbHdCM2ZEMzlhMGUwRXV4c3YwdXk5Zy9EWVRG?=
 =?utf-8?B?Nlo0RlJncVFlZUVFd1FzUGNSbnJXdEVGWnZYbnJYY05EQmtpTVE1Zjdqbnpz?=
 =?utf-8?B?K0w5QjV4UlBhS240MnlRUTJVSUJMMTlnRzNiMkM1VW8zb1ltT21qdTMwS3g0?=
 =?utf-8?B?bUlQYXV4aWM2THN6QXZTVVpuSmI5UTlkL2ZQV1k5NEplK0dNSVpjTmltdFht?=
 =?utf-8?B?QXZwMGw1WHdUSEprL092d1c3Ly95clg1QjBWeVYvVUJFZlZWV25Hdnd3NUZW?=
 =?utf-8?B?NGFHNkZ5RFg2Y28yZW5UR0JCejRHd1YzelhUWFpNZkNWWDhaSGlpOXBDQXF4?=
 =?utf-8?B?Ykc0VXFGRC80RlV6T1VITGxXSWg1WWROS0lxeXhaT3VBV0o4UEp6R01IMkNi?=
 =?utf-8?B?TWdPMFB1a1lSVndzbEFPSmJoYWZwMkhHbDNRR3RGVXZ3cllnc2hDWnZQNUhO?=
 =?utf-8?Q?THz/8cNo4+o3v8WPSiHuptA8R++At5kuQs7pcQGAqi7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc59fb0-4902-42a5-ad52-08dd477d4cbb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:42:44.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHbhatnDFT+OUYcccwDjt4mVGWQ/4xgfc5+5x4WVUxctNfc5oaLPq6jKCGgtJoHiXaAJj0VCn1ALqV+J1+bNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962



On 07/02/2025 09:07, Furong Xu wrote:
> Hi Jon,
> 
> On Wed, 29 Jan 2025 14:51:35 +0000, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Hi Furong,
>>
>> On 27/01/2025 13:28, Thierry Reding wrote:
>>> On Sat, Jan 25, 2025 at 11:03:47PM +0800, Furong Xu wrote:
>>>> Hi Thierry
>>>>
>>>> On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:
>>>>   
>>>>> On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
>>>>>> On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
>>>>>> wrote:
>>>>>>>> Just to clarify, the patch that you had us try was not intended
>>>>>>>> as an actual fix, correct? It was only for diagnostic purposes,
>>>>>>>> i.e. to see if there is some kind of cache coherence issue,
>>>>>>>> which seems to be the case?  So perhaps the only fix needed is
>>>>>>>> to add dma-coherent to our device tree?
>>>>>>>
>>>>>>> That sounds quite error prone. How many other DT blobs are
>>>>>>> missing the property? If the memory should be coherent, i would
>>>>>>> expect the driver to allocate coherent memory. Or the driver
>>>>>>> needs to handle non-coherent memory and add the necessary
>>>>>>> flush/invalidates etc.
>>>>>>
>>>>>> stmmac driver does the necessary cache flush/invalidates to
>>>>>> maintain cache lines explicitly.
>>>>>
>>>>> Given the problem happens when the kernel performs syncing, is it
>>>>> possible that there is a problem with how the syncing is performed?
>>>>>
>>>>> I am not familiar with this driver, but it seems to allocate multiple
>>>>> buffers per packet when split header is enabled and these buffers are
>>>>> allocated from the same page pool (see stmmac_init_rx_buffers()).
>>>>> Despite that, the driver is creating the page pool with a non-zero
>>>>> offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
>>>>> headroom, which is only present in the head buffer.
>>>>>
>>>>> I asked Thierry to test the following patch [1] and initial testing
>>>>> seems OK. He also confirmed that "SPH feature enabled" shows up in the
>>>>> kernel log.
>>>>
>>>> It is recommended to disable the "SPH feature" by default unless some
>>>> certain cases depend on it. Like Ido said, two large buffers being
>>>> allocated from the same page pool for each packet, this is a huge waste
>>>> of memory, and brings performance drops for most of general cases.
>>>>
>>>> Our downstream driver and two mainline drivers disable SPH by default:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c#n357
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c#n471
>>>
>>> Okay, that's something we can look into changing. What would be an
>>> example of a use-case depending on SPH? Also, isn't this something
>>> that should be a policy that users can configure?
>>>
>>> Irrespective of that we should fix the problems we are seeing with
>>> SPH enabled.
>>
>>
>> Any update on this?
> 
> Sorry for my late response, I was on Chinese New Year holiday.

No problem! Happy new year!

> The fix is sent, and it will be so nice to have your Tested-by: tag there:
> https://lore.kernel.org/all/20250207085639.13580-1-0x1207@gmail.com/

Thanks, I have tested and responded. All looking good!

Jon

-- 
nvpublic


