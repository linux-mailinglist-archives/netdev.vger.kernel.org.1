Return-Path: <netdev+bounces-184509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EBA960B5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C7D3A7141
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACE1F3FE8;
	Tue, 22 Apr 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuiRYTyG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50224C061
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309674; cv=fail; b=q+YkrmHbg4z06eWJLH5O1SjTefI0bD8wLChHGm6LhX6G8+pjFC1kV7gaR6oGBl94rn7x3IcUzQx4sdmqKXyyJld9poNxTW/i6MWUx/JOT8PJIdVb0ht+vhJrVsr8/CsB4sLkGfZNV8qYN7+zAQGwqkJDJNMNo4WAl04pPj2fgm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309674; c=relaxed/simple;
	bh=0GXnbp7eOBPdjfxCXRXp3Q/AmOYe989SjlnEgavDGlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuFZ7K+QCpGHsV42Hw60qpHzYlSLaEc5lBi3ofXNwGuo3CLQ/1/y5UDMNtjq50JYb4appr8/pKM4WFc9VWUlGhgSuO+YeAE3KYz8X1/BgcASuvmeC7Wglh4UcUvSG+tx742coxkFQD1vfmsL5/k5PD7dkmACt9PARLTc9JB0xNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuiRYTyG; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBkbPMsS6uaFeLH8Z3wPzdqkluM9gfT05X0vZntaeUN9MnfbQdtLyXFlw+4dCt5hCjMEX3tkxtwNh3Py4KRTWSeixENL+1buqyYjJCFU8h/b/iqpNXqQdZKhhbOMO5NKSdS7c/qkOGECgBVDjY9iSlQg+OHQ6v3T4likNuy7Pg5wbNKtyKFfdNp7O9pANg8dPef870zwgcZK2G5vrVq8ljiZ/vSOahEQvCv7rg/Eia/oJ3FIt/oBJE3QvVhgKEVtvA0SIxeGTIzuEsVJNe0uOSTBtfglz0nOFjeeWBsCqen/1igx5d4mi8sw/wkCv+LTYF1fOBlhfcIgdphH7FCv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+D6nFYdN+N14RMPxyATf3xBKyoISoE21GeEWtY5Uc4=;
 b=fTxHatvm2xYGlmbQqujlTvODmfLUdjQFAXbrfm1Mh8Lc6EctPePxjJd/aSox876Ujy6mvxOHOQz4hzr0SeVr3ic+vOl/ogskPDanDmk5wJCmGK7/c4vKNV4cuCy0eU/BrFvgCO6vtXu6CxdnJ3feg0dvmsHRVUKqj7Fn0Q7Q8S24g2CNkWuZq8sSX+4KIlz7xl40fc6Hps/F9LqRsm4F52ivVww+VSWU72wonN/axfrTn3d6Q/6w9vLGi0sCXP+GrvrwLVA7/ka8KMF4eAT4YI317yRVmVu1wU3p9ksgeVFa4Vdeo+AGPBPzCGIODkNs4tty1UNUSAriAFCR+uFl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+D6nFYdN+N14RMPxyATf3xBKyoISoE21GeEWtY5Uc4=;
 b=EuiRYTyG+4zw52xs2+FXmZ5Om9PtkBErZxYKuggnzteg3dUeJQDMplEYy0MQGrlCepmVltC001cU832a6t38jLy8BctHTmtAJdiFPkBiZMH35oAL/buQJABSnvINbX8UCO1eSZSTqVHaEw7H9z5JY2EtuhEnpJMbuLEy37yphRV8+h6ees5qi0mHYjdJJSf2rrJuULAs3RkwtFobkqvSBhwA4DcUN8rrWAf2PX6Uq2Q7v5MSNY0TZquMtohG5JiPl5DvxYVhx1pc4W1x23GbTT29O3sx0MkqOiPGH67S213v4Ue8DMsONysepntAqf4rQcQfFnOL3pYfBZgPC0fJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Tue, 22 Apr
 2025 08:14:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:14:29 +0000
Message-ID: <39f1ff89-787a-489d-8ff5-9b90897afd28@nvidia.com>
Date: Tue, 22 Apr 2025 11:14:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [?bug] Can't get switchdev mode work on ConnectX-4 Card
To: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
 <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
 <90e40d18-ad31-4408-95e8-0cbe4fb12786@mails.ucas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <90e40d18-ad31-4408-95e8-0cbe4fb12786@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: cb226834-da73-4acc-d6c7-08dd8175b3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG5ZOGxvSHFTbjRWVnFzSmM3RklsSzZ5RElkN1Jtb3RpeXdtRnpFc0U4ZUcr?=
 =?utf-8?B?QitxNnhKRURvc3Q4RGljUTc3eElxQVg1UTY2N3dxdllxMDcySG83UXZsK0Vp?=
 =?utf-8?B?MWhjOEUxbmQ1Z0tMSklodTlyY1RmdnRMb2ZDa1ZRaytrWU1iY0pmTUtkTFU3?=
 =?utf-8?B?Zm4xcVhab2xVaVRzTWFhVnF0UVV1V3E1VDNqM2xGamNSTGpuSmdIM092MVpp?=
 =?utf-8?B?cFRIVnRSL004N0dDNmZMNCtMYVVNRC9idlZVN3ZmVU52MjQxOUo4NllWVWVk?=
 =?utf-8?B?aEc1NmluWWNYZjJSOWZCdVlwbjJFYkU2L3BNemFnUE9xbjVabEF0bklEOTFq?=
 =?utf-8?B?RlpJRFdFUlJ2cENlMHVUR0sxNzg5bnJiZ3p0bWo2cVg5TTVCVC9XLzJYQ3Fq?=
 =?utf-8?B?dzI1dDdEb3N4blAza0diMGNBMVFsYXBpSTFDRWZIc2ljVmFzMFY0ZDd3TkRZ?=
 =?utf-8?B?RmJQS0liUHhZSC82Sk4ySy9aM2JtVitMQ2lDekdUQUVscFNVY2x0ei80aXFB?=
 =?utf-8?B?eFZEeFVUV1A0aDl0Qi9NZlU0QzRyYzNNdWZxL2hXMHhZY2t4UFVsTzdZWVFD?=
 =?utf-8?B?L0pSb2pCS3ZDaFU1WkIwVGpGT05nR25pZVA0U0JrNFQ2VUV2ZGhra0tPemV0?=
 =?utf-8?B?bTRaWmVpTVdhd3hTWWJZNFZZZUQ4dDYxQi9xanJNRy81b3FWajlQZWt5OXIv?=
 =?utf-8?B?U1pXM3NWcExmb084NHBpYzBjaGF1U3hQWjVUTUxxMDFjMUJOcTFWNkRUbS9O?=
 =?utf-8?B?ZjVJdWVGRCtBb2cvSHMrNDNnQTBxUjBFS3kyUjc0NlRhYWNaV2J1RXBBdVFr?=
 =?utf-8?B?d1V4YlNVSE5jLzE3aElyMENrZzdGdm9QY25PQjBCT004TWJXSUtzbHkyS3BZ?=
 =?utf-8?B?UkF6RkljMHFtQy9FaXNYK0EyQllUQi9MenpJZlhkUkhIZjZuaTJRQktmZTJq?=
 =?utf-8?B?TSszSlU4Q0FpaDhUT3pVK1BQTGZsekRLR3dqSDFIS1N6aEtha3VZTEdjNmN3?=
 =?utf-8?B?MHNPWlFncVFENkpSbENPbzF2aitDWW4vOERTQXl6SGorenA0RkJlKzNTWkJh?=
 =?utf-8?B?ek9MOTB5RXRNYlp0YnhoUDBRZjU1Q1UyekgwclRyL3hKMXRJK0I1eGJPSHpl?=
 =?utf-8?B?WURJOFdWZHN4MUE5SWNUNkpOM3QyRTc1QXNaODVvU0dnaHV2ejhWcXdwTlVk?=
 =?utf-8?B?RXVDb0xaNE5hcXFhb0JibmMwQ1lWOUE2akRkbGZHMkZtRHQrLzk1TW1SNWU3?=
 =?utf-8?B?UlIwamgxVHl3WDd0UnVBN2h5WFhUN09id3BTblBlbEVoYTJEMzAyTmMxV3RI?=
 =?utf-8?B?UmtpQlhuc3QxbFJRQjBhakRoUkZoMTZwdG5MKy9aa01uNjJ5TGladng5eGQ0?=
 =?utf-8?B?RGJHTnpQTGVpYXdVbW9WQlJubHdqQ2hGM3g0RytXWUVLZWk1Q0ZldHdEaHF4?=
 =?utf-8?B?aXpGdk52T09wTVZCTDB4NDVJL3RCQ3NWSFRtWk10ZWZab3YyeVNyWjVRWUt0?=
 =?utf-8?B?ZElHRzh6NW83NXZGRnFkbGRQdExxY2NtempXZ2VCMUEzelRlc2F1dUJFSHBI?=
 =?utf-8?B?bFZIMnVYT0tjVG5OY0x1ZGx4OStZM0Y5eGVoTUtUNy94K0hnbVorUmtLOThY?=
 =?utf-8?B?SU53YXRYcncvdjJESFBML1JUZEYxcXNuVkNVS2ZMUTV2MG1YN25VdFRXRElt?=
 =?utf-8?B?T2lUUm9TWWZiVDdqdTZpdkt4OXdYbjJLODIzWVZCMjJDTVM3aVQzcTlKV0ps?=
 =?utf-8?B?N0w0NUlhNUM0SXV2S1VQQkJoeVBVSlNnc3kvVGx2L0RGYm5MbUxoUEs1VVFi?=
 =?utf-8?B?eDJIemo2eTlPVkk2SzNqbGFCYzdSbDdzV1FaYXJmVXJKUllZMmJmQWlKSUdV?=
 =?utf-8?B?T1o2azZWUmg4N2pTNWRCYXppL2sxZDFJTSsxRVRJY3FucEVZODdHR1dFVndO?=
 =?utf-8?Q?KDBfPNjvlcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldHenJNRlo5LzU3a09vMm42cmdxajBqR25lanF5MnlDcFBQeHMzQ1dBTDNn?=
 =?utf-8?B?cFROVlBBcFJKeXBvQW1BMUJqRUo0WFNNZjRLWEg1dUdoNDdFUkQzVEhCcUJD?=
 =?utf-8?B?L0R2NjBXZXdHazdrQkVkYm1kdTZUZFp0b0ppekZFUzN1cGZBUlhUT3FaWU9z?=
 =?utf-8?B?MzQrR2tIQ3lIYkJIZEI2Si82VWVIamw4RnRFYlpVM3o1M3ZKYnErejRpbkxK?=
 =?utf-8?B?R20zVmwrWmNnYWtIUk9NTzE3V2pIM3l0RHVtMjJ5MHVMcVFEWjBEOHRwdVdH?=
 =?utf-8?B?MnpXZ2diVjdEdUcwcFdLcDQyejJjc2xZQ3hmS3FwYVB4a1V4ZTlnWThYRjFY?=
 =?utf-8?B?RXVjaEh0OVRXbEg0aTlVMkp0V2dHQ0M3NWl2eC9TNCtPTzlTVU1KR0UxNXZ0?=
 =?utf-8?B?L3laQjhocTdiZTM5VVdHdG12RmNJc0R2OGpBZjB1V2Y0WmFLUG9wZFV2ZVlQ?=
 =?utf-8?B?aE83a1IrbnFFd3pOeDQ3RjR2T0hrZjNneUdzUWVvUG1iN3pFOXRtQ1E4bXc0?=
 =?utf-8?B?a0JEbENjMDlFSHFiNkc5bUlxUVFZOE1iSHA1Wk5KTzQxUDFpVW1GM1JxYUlo?=
 =?utf-8?B?dHh6c0lzamJNT0dsbVpEWHcwS09CUERpeHlIdTlSVnFQTDh5bVdBemhwSExW?=
 =?utf-8?B?MHlZcXFIMUdPOGlsQUdpNU9FMnlTdm5jaU01T3dFOCtscnJRamhHc3lwaElX?=
 =?utf-8?B?UklUNWU1eVlLa2h6VGVRK1F1cURZOXNHYnowTS9uT0RCZjcydUdWUjd2WUNw?=
 =?utf-8?B?UXFoemZZVUZkUUZrZUxkQUhxMVl4S0VnVHR2cENZSnBTTDNJWUhOZ1llQldk?=
 =?utf-8?B?Q2FHVmtyM1dKaTlSMjAyZlJWUzZJZStoK256KytwRmtQeGJ6RFZOS0RaTTVK?=
 =?utf-8?B?UGVKUi9aVy9kRnc0YmVuenc0VHBydjZBdHNacEdzT2tJbDVDUy9PekpVTzYw?=
 =?utf-8?B?UVRielEvTjBSTEw5U3c1UDMyOFoyTlB3WEFsOWJoYXNkS3lBR1hlWVVHSWRP?=
 =?utf-8?B?K0hLb29HNVR6ejhjdG8yK0MremtnSFFzclB2TE1KeW1UaHhjZGVLbjRrcDNE?=
 =?utf-8?B?bUFoMG5vTTBmREQ1N1ZvQVhheFBYemJ0VWkzUnJxSDNHUjBCSkZ1dXZRQm9t?=
 =?utf-8?B?MGNFNG9Ra29kY3VHdUVqRkt1NE1tb2dzN2RtbDlKT0JUeFdNYUtsMTBiYWtz?=
 =?utf-8?B?SjQ0L1BObmE3amQwZWg4RVROOEpMTEtpZTd1SjRvUG9wL1BLaXpONFlSUjRm?=
 =?utf-8?B?QUFsMUl3YzBHMklVZE9Ed0xYTEhXK21lTElZaS9hTEN6Q0EyVkFBUkxINUxs?=
 =?utf-8?B?R3N4KzE4dVVMUVd4WlJjZjNPVll2T29GWGZ5YTE0RlBhdjR2dU9IYUJYK1Z1?=
 =?utf-8?B?VjBtekJFLzkyZjc5YUpFeFljSDlLclhPcXdGazVJclY5ZEhJRVhOVHlSWkFG?=
 =?utf-8?B?TC9rcFRoOWRTOFZjTlp6QnNVcnI1Um12RDA0QzVnWmdLMmdvd09TbUd4M0k0?=
 =?utf-8?B?UTVRT0RsZ002S2ZmclBrVGtaRWJLRFdCYTl6clVVYk9hK1JiZHJ5RnRaVGxt?=
 =?utf-8?B?SXRmSExPVVpnS0xQeVNjRVpVZUhJL0ZuZ0Njc3Y4QlM3clJ5blFDUzZWcEdu?=
 =?utf-8?B?TFZIT1REbW81Qkhvdy8rcnNnZnNZZ2lvRno0SndoUjBKb0VOWG9YcTdQT09L?=
 =?utf-8?B?WEQ0bVAxem1oUTdhQUw4dk9KU25lUjdkbml0YjFMaWZYT09SeGtMM1hzdXJq?=
 =?utf-8?B?ckVOUXB3TWZsYVErSVpoelVWL0kzbERta0hJY1ZRbzdlK2l4d0tXd3VSUTFn?=
 =?utf-8?B?L1B3UUhFQU9TTllDTGVzSllicmZLcmpTc3ZBTGROYVY1SDJVbmo2b1ZrVFpk?=
 =?utf-8?B?cTJQelR4RlRKN2JsdVhkWTVkelZ3RTFSNzFXNmJ0THBlZWJXZTh2YlNZc2Jv?=
 =?utf-8?B?RDY1elpydTZrZDdXRjJmRmlvTWQzMHBSemhyOVpZZUZJMVpGeWh5QWlaQ0lT?=
 =?utf-8?B?ZFFDS1N3SHV3OVhTTUVzcHRPa3E4UHlkaE5yTGlsRCs3LzQzWmJ4U1paL3Z4?=
 =?utf-8?B?Q0VSbGdIc1Y5MktUTWNPM2t4bmxpVlZxMTlMcXljcFVZMFRvMjlIWVhoam85?=
 =?utf-8?Q?9TumhBA3VUYvPdIwqOnfSOPmN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb226834-da73-4acc-d6c7-08dd8175b3fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:14:29.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMmYVqEsDuUHubjPmCuLSjrQ+i7Kd+AmY6F0ohkHakF9fotsZUly94krZIzmwvlTDVIKHTqx3EpULrMWWGL0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994



On 22/04/2025 10:15, Qiyu Yan wrote:
> Thank you for your reply!
> 
> 在 2025/4/22 14:42, Mark Bloch 写道:
>> It’s likely that the issue stems from cx4-lx not supporting metadata
>> matching, which in turn prevents the driver from enabling bridge
>> offloads.
>>
>> Could you please confirm this by checking the output of the following
>> command?
>> # devlink dev param show pci/0000:c1:00.0 name esw_port_metadata
> 
> $ sudo devlink dev param show pci/0000:c1:00.0 name esw_port_metadata
> pci/0000:c1:00.0:
>   name esw_port_metadata type driver-specific
>     values:
>       cmode runtime value false
> 
> I guess the "value false"  here means not supported.

Yes

>> A better approach might be to check for metadata matching support
>> ahead of time and avoid registering for bridge offloads if it's not
>> supported.
> Just wondering what is the penalty of not having such offload?
> 
> The reason I am trying to enable switchdev is that I wanted to tag multiple vlans for a single VF. I see there is something called VGT+ in the document of OFED driver but the same function don't seem to exist in the mainline driver, so I considered to use the switchdev. But if the performance penalty of switchdev can be high I might want to switch to OFED driver instead.
> 

OFED is unrelated to upstream.

so you want to do QinQ (not sure cx4-lx supports qinq)
or just different vlans based on the traffic?
I don't think cx4-lx supports vlan push offloads.

You can still use software push vlan action using regular tc rules,
something like this:

tc filter add dev pf0vf0_rep protocol ip parent ffff: flower skip_hw dst_mac 50:6b:4b:b4:ac:0a src_mac 8a:ee:f9:37:bb:ef action vlan push id 100 action mirred egress redirect dev uplink0_rep

Mark

>> This way the driver won't offload the bridge but
>> it will also won't prevent users from adding the reps to bridge.
>> Could you try the diff below and let me know if it resolves
>> the issue for you?
> Will try but this will take some time for me to do so.
> Best,
> Qiyu
> 


