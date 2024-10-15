Return-Path: <netdev+bounces-135601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1299E520
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981EC1C23732
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594F1D89E4;
	Tue, 15 Oct 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOhJEgc1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F715C120;
	Tue, 15 Oct 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990531; cv=fail; b=b30bK/qfgwmEuPI/IhygB0h+o9AfQalfCHpqngldm/ooyoG59aNS63Un1J4wkp1oMFur9TY48KJgePqSpG+f46KSdseTLbdfgoLhHNkhbqPWBAnrYpcRWXMYZ45wm/NI+x1nZAMcCUJT7wyW8gSJ4IWCoeIbigLU+qRjUNVunYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990531; c=relaxed/simple;
	bh=7vYpzjO1yilt1zdjI141Llo/fAXZT/CkGAhio87ss0A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKtANIz7bCHpJwHjgjfhtFftmM355TXnKs2mH1MPZ/wW0y+iZ6+zpVRVjPFnD6Mjtz/Z7ktTW2qdBywEBixAZ8Jnhc7PUhW2Y8MrgpA4vpqvtE25hIBJVZzZv0EtPWFdo6oXO2PngXPVIdoYp/ECBkWyLmF3wPahoYpgR6iNPyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOhJEgc1; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvgVwxQQG6a48jyTZuTygwXysvYZawUbFLi61QGnl6o64lgUBe2pVyFs/+d/CX3q91T99xviDUp5ZHXmKnSzN6ifKWgx3o85f7Fm5wrEB6+veoFmIs2XMvy/2HQ4Gijab84UX1YWe/rgFX9PF2NvZUn8rh37C2FZtdDJ9BQu9dKpZXiPZ2siZoRFlCV/MpDUmfpaG+zVM8IiMOB9w6XWoRapynuvy52FjzIF7TAh/0BC0E2o7ez51wHtAoSv2hg4MYYSiU5StxZoO6vqn0NhqpjpiWKEoILzqmLILZ7yg7TcaY1z1EX+zfaUVtvfWFnW0P0aDorSrCrNxH0wolUvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5ogBcGrWJdA1w5C5gcLvwHoVzuSoO0fsEL85vyVMxc=;
 b=o8BxKtJOO4OZD+UhCIM7HDuneY6waJQbk9COb7QEpT6RAIFR9QSuPlE+ehY+IhS0en46cS0mLt1MU3A+IAffMz2KTLBWCnNagdv3T/TWkHgtVRTl3qmSex0nSjEltHS6uos8rnJXZPDQfu56oKTzVwFAki3TVgkAbxM73ggZp6bZIL5GwyS9p8nKnpb/DXyxR+g9WRA288qF9XNAcf6uga6Cn95GHpa7/A+0QUzoHG/Dkgz0mPS9+fty0tOdFTLDuuT+cYWdPn4dpNDRvk1q+rzL7MbRFJLqvkOzCCjDaMuH/O+RU/lK+1qe7p4LB/wFIxd7UKrS6mSKJ9FMx/Cc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ogBcGrWJdA1w5C5gcLvwHoVzuSoO0fsEL85vyVMxc=;
 b=bOhJEgc1GXVneBIhCqEOpUYF3RpgmD4MI3ojJ/NBPT9LMkO+0UEhrrUB9v8WWoC+vJfDJeXpxcilLSGiVF8hMtNIPOOCqoAqFuL5RWo7v/yRGdcn3+AiAUVieSVvdn/N6dp0Ffix9JOhijsvFjD2cOzsL5kwvuymKqwWwjKcu9LiF7/s6pCyEJCa1rsOzL7rpb0lVdzp/7N3fiHL20cDl6nK/ln+TLedcSjWKvpkR7v7gRMeqx9D7yd7D+ISodXbF8PLNeQBoPQRbsK0Pmq2uq+HflfxirHhU728Q0uqrz67zEvvIrcHEhA2ULYlKqIEVDjGAAnfgx/uwjB4W15YGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 11:08:44 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 11:08:44 +0000
Message-ID: <4aac8cd8-57ba-4757-af9d-9ac99ec8ef9b@nvidia.com>
Date: Tue, 15 Oct 2024 12:08:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
To: Daniel Golle <daniel@makrotopia.org>, Hans-Frieder Vogt
 <hfdevel@gmx.net>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <f8282e2fc6a5ac91fe91491edc7f1ca8f4a65a0d.1728825323.git.daniel@makrotopia.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <f8282e2fc6a5ac91fe91491edc7f1ca8f4a65a0d.1728825323.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0612.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 703bfff8-85b7-4ac4-53f7-08dced09bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHl5azhoWVdqRTN1UTlqSVJwc1g4MXBGdHJ1aUwxVVZudUY4K09laWt4ZVlL?=
 =?utf-8?B?N1BOTlpHdGdZUVlFRUhkRS9hMGxySEZBNU1CUzJOcUlIYzdKY1hmYnhHNk5Z?=
 =?utf-8?B?MmJaQVB1T0MyUkhmOFozU2drYVRma01lWlJSRmxNdFRMaEE2OWFrVWcxMDRw?=
 =?utf-8?B?b210bW4wQ0hsOWZScUwxckRKcTJZS3FMTndDWi9JM3gwVHNBTDlXUkJIdCtx?=
 =?utf-8?B?aEk2RExEOUNUT0FpYndrdCsyVjhueUNoRkdLUno4amZWZHhITW9xVmkrQWl5?=
 =?utf-8?B?V0hGVUZoZlZMOGRpSGt6K2JzTzhDV05EYmZyV0VVVUFNejF5S3ZWYS9xSEUx?=
 =?utf-8?B?aTdNYjJwK0NHR04vK29GR2k5dmNnYmJKZVo5MmhyVlQ4TE55RnlEc1YydnQv?=
 =?utf-8?B?ODYxNHVMUDI1QVRaUEI4dk1uQlB2QnVZUUhhRjBCZytSUU1UQXJab0U2cDhU?=
 =?utf-8?B?NlNweGR6K095NnB2SDVYd003THdRK0V4WXJUQkwwVDJUN1BMaDdWa0s3VjRF?=
 =?utf-8?B?OS9HWTNtc00xRGhFcTNFak1SYTd6NklVaGhPWlJ0cmxjd3F1RkZlc0VybWh6?=
 =?utf-8?B?RjdFSjlOd2ZDMlMvTyswMkxzN1NSUHR5ZUlvZHFGQmNLWVQ0RDZQbXRMQXVy?=
 =?utf-8?B?NEEvM0NMM0JqU3QrT1dPdnMxTFp5YnQzeVIxeFlUcHBibXJ6VTZPZStnb2tI?=
 =?utf-8?B?NjZRdFhhL3daSTlxWkpmSjZxKzdiakg0NjZDcmEzRm1GNm5FYzZoZGZmZE13?=
 =?utf-8?B?SlJWeE91Y3NORkVkV1orVTA2S1p0NVZ3RlRNUE9KVjB0cy9mTmh6Z0RWcXdB?=
 =?utf-8?B?MXpINGJpZ3htKzRkeDViNDBsMVh4OG5FV29aSWtOTFErbm1qa1BrcDBxT1Rx?=
 =?utf-8?B?c2dZdDJZSEhnaU56ekE1d3IrUVZmVlV6ZGFGSXNhbEN4cktJZmsrckFWd0Q3?=
 =?utf-8?B?NEM1SmZ6czZ1TElPaUJkVitsRWw1TG94djluMkxlSTFkYVNpaDA0aU42Y25n?=
 =?utf-8?B?RHBDOWdFakpPMUVmV2xXNUdFemJITTloU0tzTmd1cER5bmZXdGRuVkJmNUN1?=
 =?utf-8?B?TmNsMEQzUElLMVIxZ1ZzK2RicGRjaitGeDhSSmtXaDQxYUR3SXk2UkpQendH?=
 =?utf-8?B?N2d6ZWREcmxwdG93VktzWG5tb0RjM04xUlpBSGVLNFVoRGgyOHpSbmJYWVBQ?=
 =?utf-8?B?ZTVFNzFSUWNGQ0RlalJVZ1ZFNHVqU2FYYTUxNGN4N0N3bnZibzlBQkl1aDdZ?=
 =?utf-8?B?ZDlYTXUzS3FkOUk1WHhEdnlsZi9rV1FFbkNYdFZUSGNNNkRYL2RpVmJQQ2hJ?=
 =?utf-8?B?STJDS1YwWGFVS0lIVWZvKzQvZ1QwZVZYYmNHQnZkcklSZUlZNjB6L0FBTU92?=
 =?utf-8?B?TkFzSFdnZDRMYWV5cW5oV1pJVmxZS3oybW8xYnFya3FybGxSRUpMK0gzWDBV?=
 =?utf-8?B?QmpLUzdlTHdHc2ExUnA5bVZabGlSOGVGSDBNTzA3U0M2WjhqSnZHaUkxYXB2?=
 =?utf-8?B?TUpueW5jd05JSlYxeGhHZG13VFYwZ1BXZDRWMVJqNXIzaWc4VmFaV0ZZbVJy?=
 =?utf-8?B?SG4wSHNHb0M3b3NjT1NkWjhIUG9aMEVLWUc5anJkemw1bnZKcWUrMC80YU90?=
 =?utf-8?B?YS9senlxeXpPc3RUNlY0cU8relhBTStFOCtRTEdvSVNyUThjZmNLMlQvVjd0?=
 =?utf-8?B?OGtzVkZGd3poOFNYbDE5SWZ1ZEkvblA1clBuWEZVdUZFL1JWTVA5a09uUHdD?=
 =?utf-8?Q?UEbHhjdjACaiTuTFf0fxwZxQJsBKDfVj1RfYRoP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZhK1FYcmdSZWpUQTJBTThHZG11NU8ydm4wM0V3RG1raWphNGhIRjdvWVVu?=
 =?utf-8?B?ZGFkZGNVYmpkeG5SNTNtMFJoVkNwMFpUellCaThOTU1YRjNUUHgxZ1BIMmt4?=
 =?utf-8?B?SHZId0VzL2thMWVzaVdzK3hydHFINlNvWjZNczk4dEd2Vk4xSVN2WUlYdUVD?=
 =?utf-8?B?TzZtSTdsVEpuc1BzZXgyay9tempFenJJV2lxOU15V1ZVMjVwTFFWbTZwenRT?=
 =?utf-8?B?QnBGdGwwM0gzY3l1SjRRU1JjRG94QjJYR2M5TGtrRDNjcGJyWDBXbi8xSmlN?=
 =?utf-8?B?dEIrQjM3Qm9WbitSNUswNElXVkxvUkYvWGVPWXhLMXRXcHJUc3J1MHE0Nmdj?=
 =?utf-8?B?UVVkcE9QL2tDL051dnEvdWlMZTVIcGdRcHo3YlI1RFhZUkkyckF6eTk1YUEy?=
 =?utf-8?B?eUxpNDZNb2FaSXhKb29ZWEQrRjdWR3NpZXhOSGlDMVM3U0RjUHlmNUM5NGJp?=
 =?utf-8?B?OG1TT0RqRXd2dFdDeGc5NGxySWJzVktwbkV2YzhMSkFiS01laEJxM1RCTnlE?=
 =?utf-8?B?eVdsR2NIcGhNU2U1a1dGUklPK3R2b3o2dmwvZnE4SExaT2FkSllObmFIejM1?=
 =?utf-8?B?QW1UTjNJeUN6aS9hZlFTck5aUzZUa0xtUWFMM1ZoOFpGcGVuaDdOTlE0YWhz?=
 =?utf-8?B?dHdWeDQySWJWQ21LVjFrdFBYbkZNZHRsTEoyTm9COGhSQVd0T0FhOXZrRWZu?=
 =?utf-8?B?eWk5dTJhc0FDTVkzMlV1aDlaM1FBdW5HT0ptcWlya3VsZGpiUlF5N1piUmxE?=
 =?utf-8?B?Yll4c2xFQkRBMTVmZ1IwSlVUVitpMW5vR0JkNHBlWkNqRXl4NkZpRDJOVkF6?=
 =?utf-8?B?YUtDS0JZaXJwSDlOaG52aDRubXh3b1RPV1ZXclpWcTNLRzFRbTBYNXYvdDJy?=
 =?utf-8?B?L3FNVkRqaFM0ZDR1K29oSG8vSFZ5ai9MaU1tRngvSnB3U04vWVI3Y0IxSEtm?=
 =?utf-8?B?OFJKZUs1Ky9FZFh5aFdNczg0dFJ2a21GUW1RLzc5d3ZJWU1nMXJaRDRnSUZv?=
 =?utf-8?B?NjNENDZJNUJsQ0hPNHdGcUxqRFlHZlNpaU9OWlBCV1ZTSlpyOEkwdXU3ZnVV?=
 =?utf-8?B?a0R2RmdqYlBKNytidy9WOFVJU1g2U2JLNDdFRTBQT2w3dHdGTGFPc0ZPZXcw?=
 =?utf-8?B?NFpOOWxmcEIxSzB3RGMvWTNFbVJ1VzFLd24ySDJ2Wk45Q1FzTmNiN2FyU2Nn?=
 =?utf-8?B?S0RmWStoS0pubXp3bkRBUnM2cTAzVGxuNDluVWZrQ29jOEgreEw0VDNjM3Jt?=
 =?utf-8?B?N2FYNllpaERoelhNbnROU0tNaTFhc2hablNYeFl3eHFwdTdBTlpiL0JYeks2?=
 =?utf-8?B?dTVZNXo5anZMSEZ2NTJMQjVNekdwemtmQ3lFQklwandSc3B1bnpWbGh4SHM2?=
 =?utf-8?B?bE92ZVkxY3hqRFBvSjlvb2FuaWNSejJqbUxHa3FsR1d5b2czbXY4ekhCSUlD?=
 =?utf-8?B?MDhqUlBhNjZna1ZCMVJyUXJKNWZ3UXZxb3FWUlhvRGJVdmxOTEd6eGRCSEZp?=
 =?utf-8?B?c1RORGhtRWVrREJLYXJScVViUmloejhJSFo0aTd0NVV4STVKYTgwUGd5MEht?=
 =?utf-8?B?ZTlXWWpNRTV6a1kxSStWSXBaazJGKzk1S29UR0FGUGVnb01oRkx2ekV4TmRZ?=
 =?utf-8?B?VFRYQlJCeGxQT1MxdWZHY1lJejlRSkhxTmVkcHZtbTg0VHJvMzU5ZFZHeThX?=
 =?utf-8?B?cXRUejVmYUo5U0cwREJNVklDOVZvWGtPdVVob2NiM2dNajFEUGduSFZWVWp2?=
 =?utf-8?B?Z3lPWThyQy9FM002NTRVOTk4SHl4NjFkSzlqV2EwM29waDYwSmpPcFVlWjhD?=
 =?utf-8?B?SmkyOTlLVldiZU1uOFQ3eFNqQlZQajlHSnZobFM5TlVNWk5PazdOV1NBaWdR?=
 =?utf-8?B?Q2FyUHY0dFpNZ2RDSGY1QVdHTUd3R2hKaUpQUDVQTmJTcU80dXZIQjNSK3NS?=
 =?utf-8?B?RHBZWXFLS3hVQ1lYeGxWanVXbE5Vc3p2eVJGejJDWC9wTlg3NHZEeFJHQ3NV?=
 =?utf-8?B?NlRPQTAvTUFUbTJCaWJMYXc5VEhnVHNLY0JLRENKOXBaMXk1VHM2MjNENkxk?=
 =?utf-8?B?aE9INjZPZ00xbElEV0FjLzN3UGNOZk9zanZWU2NSUHNrV2d5eUU0bFBTYmFB?=
 =?utf-8?B?dlpQUzFuSERNUE03Zldoa2lubkg4UFV0S3ZBZTM2ZmF4clBRUE1pWFp4OUda?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703bfff8-85b7-4ac4-53f7-08dced09bbfb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:08:44.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S67u4PKQCrR9EknPM9QaWLCAierG6I8ql2MpMWz116w+bIbz3SE3s+f/aJLVr6VzFmfV1y05OxneqXWhBmvEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176


On 13/10/2024 14:16, Daniel Golle wrote:
> of_property_read_u32() returns -EINVAL in case the property cannot be
> found rather than -ENOENT. Fix the check to not abort probing in case
> of the property being missing, and also in case CONFIG_OF is not set
> which will result in -ENOSYS.
> 
> Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pairs")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com/
> Suggested-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/net/phy/aquantia/aquantia_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 4fe757cd7dc7..7d27f080a343 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -513,7 +513,7 @@ static int aqr107_config_mdi(struct phy_device *phydev)
>   	ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
>   
>   	/* Do nothing in case property "marvell,mdi-cfg-order" is not present */
> -	if (ret == -ENOENT)
> +	if (ret == -EINVAL || ret == -ENOSYS)
>   		return 0;
>   
>   	if (ret)


Works for me!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic

