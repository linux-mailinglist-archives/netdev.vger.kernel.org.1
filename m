Return-Path: <netdev+bounces-200944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B099AE76A9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47350172591
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3D14F9D6;
	Wed, 25 Jun 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="koKLmpQv"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023116.outbound.protection.outlook.com [40.107.44.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7F1EB5DA;
	Wed, 25 Jun 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831306; cv=fail; b=YOKGIfE52rDfp7c1YXlWjnYS4Ml//nzRdBpVDIjbpB+bY9TVTS7VfnCy1Ni+qgv2I2B01CTB5pCAzfptCiUIVM5byC0JaogqD1mmIgrL4f1clSMCfhBBHhmaHvdnYaaOyqomxJSMfQI6kky4nYwizkKhqWCZYOi7yrugWbErhzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831306; c=relaxed/simple;
	bh=j6tUPV2ioUOwxXCX7cb0tz8wGomcEtWjMms1Gpcr3dE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qem8Q4gCUnr4e79bGQwbASzhP0fpns/Bf1Zr5BUPOstZM39eUIy7diubyDXBmcjLQl4gwRcL3M1AklI1x7dKn/G70F7lK2dwH3X+SFcPSCDHjObnQt+GeVHBuSV3w4s5JVS8UWnzQUZPwfXOBE8NNip29hl1v9MmS8VLiP5tbEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=koKLmpQv; arc=fail smtp.client-ip=40.107.44.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udlM5D3RwYzRCq7GrSMtQpYTSKKgwExuoCwY3eraKrZsesY+Cgu0iA+v+3lJQvbAwV0YJn2v8btxNE7FbvKDa1x4ni8bsqgyXMp61/G0YiCOQuOPA9/1Orh5TNatnr34ZlwMK808kbVPWuzfOd/3OLMSU1rVdXWOOUxYFaanLUDjGIXUv6uco517JujeQVGioVwxtEEEJcUjDlvjDSHvxajNvhn/W/nB/xnkthAXhxj3qt8yo/DniKtYbbIOK8+VUkVPiFXUoEUjFEGQ6ckrXxVpOsagFbwSD1tgOEDm7bjBkDCu71b5Sc/SBLDZKZLntYSAVzlruAxZSkmPod3rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EyCg/8zhEk4FoCWSfKbK+OYxFaXSnDqIJ5qhdB5WWk=;
 b=T5k4Bu5kBYYQ91Xblz6tz4XADs95fUYESCHBtRlThOaDKEK7Ev6kYqEKN2JBz7FoXlYn/xDdy1KK17EJ4BszM2c4Lhd6SiHTW4pC3dVO/vEkATDXjX9z/VMDefe/xA10yJ3sbW67ogkLmHYowQYCV7GvF8n4z4HU7PU7apPo+KFoOLh4UWKMbqvqNqJ7IFAccOkZatzTGXA02oGOEyQsV2wIrby2cdeRZtALQ2CrpPfJzEPVpgN0oELY7nt1Y2psSp9kHyBryjRtI6pPU7IyoMoZuAljwBidbu3ZKwKTuoGNbKTwhHsv0yB0LiqU5KY7f5W0OExPHKodmP9uKRFE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EyCg/8zhEk4FoCWSfKbK+OYxFaXSnDqIJ5qhdB5WWk=;
 b=koKLmpQvXnCyEyOHke0rg+rY9ON2g8iGVqYqlmRTo8DRaX/hERVlhk7o8BHjmz/f8rmGhKEElF/M6ans358+Rcp5m/2cqy30g9D+V7Hp4tEvcPKBm5+8P9SyG69Ofi5kJ25hgVDHD+73sc6rUMCQz9nLHGkXxoSMF0tx5lbiguXyPN5Mo6NhvaHa1n0NFQ2QaZWIcIPUvTYSiXNahikyByzxuF7vzv8RGcvRAf76gI17obdpeWdhT6o8RLqWw9cQZ3L7sSdiMp7p5xp9IBtVlQh1CMOSiNhjlPx/j80QFrzenZMH5eYE5Lv8IjYWUCLOrOXmGLX7riLZw2CBmxDaWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SG2PR03MB6707.apcprd03.prod.outlook.com (2603:1096:4:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 06:01:38 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 06:01:37 +0000
Message-ID: <25aff260-bd5b-4379-ab5c-5fc85d7022e8@amlogic.com>
Date: Wed, 25 Jun 2025 14:01:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
 <CABBYNZKhTOWGXRWe5EYP0Mp3ynO5TmV-zgE43AVmNgm-=01gbg@mail.gmail.com>
 <CABBYNZLakMqxtJwzmpi2DuBg9ftzLutBKN8S-UEmwo9k9uek5g@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZLakMqxtJwzmpi2DuBg9ftzLutBKN8S-UEmwo9k9uek5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SG2PR03MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 9986cbfe-2379-40b1-a136-08ddb3adbf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGN5dmlPRVhldW93eDJ6a3lieGUxMTAzU0VpbnRQNWlQTHVPMkhIZGNRNGhp?=
 =?utf-8?B?TXdRZDNXbzZNRDJsa0N1N1BKblJPNjh4aWROekhZK3k4bDBmeTVDSU1yY0xR?=
 =?utf-8?B?d2lhT3praStBWVNYZEZNZDQwa2RVK1Y4bDIwM0QzYXU0YThGWCt5aUNrL1Q3?=
 =?utf-8?B?RWo5dVhDL0VUblNYRVBUQjZCRmNselpEaG9za1UzR3U2OGVKYmlJMERVU2pE?=
 =?utf-8?B?eWJsd240MVFDNVBMWkd3azhHcGNQVVpZVlBvMmZERCtSYzVOWU8rNWlhYVkx?=
 =?utf-8?B?NGhCWVhRc0xOQkwvVDVwUnpwSHB6SnBpOE4raFFlSWNwN0JuQ0RZd2NGU2hq?=
 =?utf-8?B?WFllblUxMU0vN2tmRWJGNVB6S3dmOGhBeDIxVk9YQU0rVnc4NWh2ZG9BK0dB?=
 =?utf-8?B?QmRPR215SFNWa3F4d2hMZjdRMUlORXZXdnFnVTNUZ1psV3BZMDdFMmpUMW4w?=
 =?utf-8?B?VHhrU3FWZFVyamJueDkrQ2d1bWtVZFR5NXNqRjgzcjdZZEhrWG9Jc2RwTHpX?=
 =?utf-8?B?cWZaeDA1TlNtaVI2MjkrWkNPcnpWN3ZhblIzRTdiaUp1ZGd1RmllMXJFTkE3?=
 =?utf-8?B?SXRsOTJMOFp6aGdaS0UycVV2UXBROEd1eUh1Q09PRmhOVWRrQXVMRE5JZnFw?=
 =?utf-8?B?N21LTWZOdjRRYnVIT2FmSGpvUW1YRHFVZzc5dmlpT0Q4VUJ0MzFVWkRyOVBQ?=
 =?utf-8?B?WEVlUFpWTUtDOTd0MUt4VFRmaEpqWEZmZkZNOHo4cWU2VG15NTlIZ0ZVRWo3?=
 =?utf-8?B?RlIyY0VaWlY2aTl6S0hRbHpReHVxNFBRRjN4NDhheDR4aEM0dmoraG45Q3Bo?=
 =?utf-8?B?YXJnYitQeCtWbzJ3VEVlNjB6bmpZVkEwajRQcktaVGJvR2VlWm1HUkpOaWVq?=
 =?utf-8?B?Y2dod1ZMQlNkcGdPU1orZVppZHRYYXdJbTdPeW9VWjBUdWVzRjFoTXcvdkg0?=
 =?utf-8?B?UGJ5aWhKRnErNy82dFFqVmVZandxOXNYTU1oNCtpS0RROEhuc2ZiRk5HT3d3?=
 =?utf-8?B?U2xKV0VIOXFvWWswQkRuenJSTVdOS0svSGJvZzRCbGtoVjNmTkswQnE2QXpD?=
 =?utf-8?B?OVpoZERPUW8vc2QzMEJUU1R4eE0rSWtuYXZWRjFCQUg1N1dGYkt2ZHFYQ3d0?=
 =?utf-8?B?MVVIVzZzejFFVTIrU2wzQXduc0lLN2dENktZZVVMbUlyTlZhaW9tNUdmVjVO?=
 =?utf-8?B?SkhkU1laUkJWeGRIdFBSbVZuYWw4ajl5WVhEbzRJT1d2SGpPSHBoZnYxZmgx?=
 =?utf-8?B?eXRIMVZjZUptQWRINjRIZzhrVWlNZDUxeG9KQTlhQU1xM0t4RDJzc2NWYURT?=
 =?utf-8?B?SHJ0YWk5Z0ZYb3Bxdmc3UEJKbitlczk0dFV4K0lkYTZKeFg0TW5vZHBNZ1Rz?=
 =?utf-8?B?Yi9ZTUxxWUI3aUc2VmpsVnVBSnZhZFZsTWJIZnZNVUlzS1dLSDhLTWVpR3Ru?=
 =?utf-8?B?bkFCSmRrMjlrMGo5TzZxZzVGYktveHA3VUg4dDRpYlVDTnVaemFzNEkvL0ZV?=
 =?utf-8?B?TnYxeGF6R0ZFQjlUYWozc2xQdTk5TTNDN0tZQ3ZEd0ZvOVRJd3lTOTFaMkhW?=
 =?utf-8?B?Uy9tTm1MVlBnTWFZVXNSZmRIcDVmeW4xRGdpM05zZkxIODVyb0NSRlB0VVFi?=
 =?utf-8?B?N2hHdzNJYUhqRkJUWXVlN290a29jdUNoTWl3RlMwOEdJWjFPazErRytrTkMy?=
 =?utf-8?B?VnQ4cTNQek12RHNaeHBsRnNpYUtrMzNkd1h6WGhFMXFMUG5uZDFlYTBSbXRG?=
 =?utf-8?B?TWQzbVF2c25MN2U1bDNONHBQRlhTVDR2ZTR5aWxEb0JSODNUZ1U5K0RXZ2hX?=
 =?utf-8?B?ZWNrVEo5aS82N25sWWdFR2FVckM2QkErY1hBRVZXTmcrdjJRSkhtbHNHVWJn?=
 =?utf-8?B?THdaUXhMRjROWDZ2MXZ5OHpqOUNuOGlXTlFSdlUxbVF6VnIyZnVPTFFGT0tO?=
 =?utf-8?Q?VbMqaezlvbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFOU0hYcWczamNISlJtZ1RZSHR4NDR5bzJhR01mTFkwNG9EdHFVYTgwQkIw?=
 =?utf-8?B?OVNBcnB2Qk9GL1NRUUh0cmorVUpiQ1pwRHUxdFhDOGRqSWcxNVpMSUJnSCtv?=
 =?utf-8?B?NHhzZzl5UENiT05ONGk2dDZ4YUowcEtkTTRIVnlISW9UWndZN01FNWxqVVk3?=
 =?utf-8?B?QVlFellCRGp2RFR4amNIdVFOSUIwdXphVk1ubEQwSUsyU2pmMzNFeGhuY0Mv?=
 =?utf-8?B?cDRtVkZucVhTKzR3VTVZMUxobnRoUjlKYUFjTk9QQ1BsNTFoang1SzNsSjVy?=
 =?utf-8?B?YVM2RTdIdjNXSGZnNkdnQWJhVTN6ZlAyRXl6ZGs0U28xTzRubXR6dTFKdzMy?=
 =?utf-8?B?eUx4OVEvOFh0ckxNbDBoSVpodEZ1dVFwSUdjbm1DbWN0QUhITkt1NFNKc0V5?=
 =?utf-8?B?QVRUcThaLzdHanBRa0ZrUnFuaU9Ic1VCNGRyOEVLNmZsaTZ4ZnpHMjJ5Z3Bm?=
 =?utf-8?B?L1NPcWpYN204a3hka0hzcHRjUWhRQlgzUnZnZGJEYnVFTHpVVTZWZ1ZuQTZD?=
 =?utf-8?B?TjBrZXFIeXpyZDlpNVFKM0ZTMjlVaUR2VElxclpqSG1ENHAxY2dZSWVCSTJL?=
 =?utf-8?B?REJwalRzNUM5VW16aU1xN2xUU1JBeDhSV29SL0ZhVGlITHRwaXJsdVFrMTho?=
 =?utf-8?B?ODNZSGxpVVdyR0ltSUVUaVNPczJrM0JvcG5CL3JxZ0xucDA2TGtFQTBpMk5v?=
 =?utf-8?B?NjhlOTVCbmZiN2Fid0dzbnJtdm5qbktucGhtWHBjQnVBR2VmZjE1cmliYkVR?=
 =?utf-8?B?ZGZ0MUZiQmFGQ3MzS0dlWDVNQ0lvaEFqVFoyazBRVHVGMkVEMTB5UkN2U1Ar?=
 =?utf-8?B?VXA1YklWYlA3c1l0aDl1bDZwTFFkUFNpZW9zZEpoUGtTQ2FKeWw5aFcxMzhD?=
 =?utf-8?B?cFR2V2hmaktCQnM5NVZyWTEwRjVTYXNSb1N0Tk0xSi9mRFh3U1ZnclFueEpV?=
 =?utf-8?B?S0NFZW9Uam1vcmM2ODFDS0JNTEZsK0dUUUhnaXU1UFJYbVVDY2ExbnEvaHdI?=
 =?utf-8?B?RHEzd2dHR2FybXlsbFBlbUNwMnIzLzZEcVk1UGRGVUY4U1lKUDYwV21Rci9k?=
 =?utf-8?B?bkRsbkFEeTdpQnhjMnVJZ1FUZEtrUERzSUxBVkhRZ0JhV3ZEOE9nL1BqMUF2?=
 =?utf-8?B?ZXd1NEU4MkJPdmNzSDRxa3BKN2xKeEpDWFhtV1d6S0EzNjZnTzE3aHJVTTR6?=
 =?utf-8?B?cWFWaWFHbldwd3ZMVWFGVUtpSG5FL2tnR2N6aHVEeEtIVkpjTkd5WUEvRVA5?=
 =?utf-8?B?ZGtUbFIyNml6T09ZOXAwdGc2QThXb0s3SGJNKzVVaUt2V2hRVjVvZFNLWUpo?=
 =?utf-8?B?TjlQcSt4NUtiYWw5SmwxaWZiOERTby96anRXRWwySzUzc0VlcVFxRUU1dDBQ?=
 =?utf-8?B?N2hFTi9sZDVOaFhkM3E2bnBvUTg5cndZSVBscTR4UGxPMVNtcllnMitMd3JY?=
 =?utf-8?B?cWdFZUI0LzFrdjIrN05WK2YxUDgwSW9oWDdDQ2V5SzVMcTlqaTN3R0R1cERX?=
 =?utf-8?B?bFY0OWM1bGN2enRHZVhtRjZwWXhRWkl0RjBBR0RzSU9mYjYyUjgrVzNYY0Ri?=
 =?utf-8?B?elkyRFVmbnJUMjA3SzkvdnlWTGRoOHZUc3k5T3RRbUhZY2xEUzhueUlFQU5u?=
 =?utf-8?B?VVJjbnJkaitiYmhja3VKQWlRdEplNjhEK2hSOFh3Ty8zTnUyNmx0ZVRIWDk2?=
 =?utf-8?B?SllQelJMMThMaUJXTzBLRDFaaUpkcTFjemFoTGI2Ymw4d05uREkyZzUxelJN?=
 =?utf-8?B?NjZ4STQvLzFCWjJ0cEFVNy81ckEvQnp2dmZLcC84YXlHRDg1QWRtUHdzalBh?=
 =?utf-8?B?MTlhKzk4amJFT3NOd3hXVDhVOXZ3eUVTWWViQjl3VHpJY2NkRUNaWWs2K2My?=
 =?utf-8?B?cHArbDZPN29QWFJQQVhKLzNjNCtnVUxnR3JWZkVMUHMwaVU2MldZcWIxS3p3?=
 =?utf-8?B?cEZBZFk1dk8yR1Bwdy9DRWxwQ2FvUTN6ZEpjNmI3Ykh6TmNzSEFPUWZMamJR?=
 =?utf-8?B?blB2cjZBV3ZYbzdXSzFQSHNsUG9TOGhDdDdDZVhHU2RudkNjdlJGL29kTDMr?=
 =?utf-8?B?bW1na3JTZldnb1ZJNHQ2Y0FaamVXemNyZHVmSnRhaEhSRk9qZTVqSkY5c2I4?=
 =?utf-8?Q?ieAVHUdAqKgMOSkVhIfPj6tYh?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9986cbfe-2379-40b1-a136-08ddb3adbf04
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 06:01:37.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urDaoU+AdaXrEowqrIz5UqjpCAC6HMKTlvKXgHqw6549wlyZTnKijGAyO4ibzmK3QbbUseT9spBdCvYxB4piog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6707


在 2025/6/25 1:17, Luiz Augusto von Dentz 写道:
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jun 24, 2025 at 12:56 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Tue, Jun 24, 2025 at 1:20 AM Yang Li via B4 Relay
>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>>> event (subevent 0x1E). Currently, this event is not handled, causing
>>> the BIS stream to remain active in BlueZ and preventing recovery.
>>>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>>   include/net/bluetooth/hci.h |  6 ++++++
>>>   net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 82cbd54443ac..48389a64accb 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>>          __le16  bis[];
>>>   } __packed;
>>>
>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>>> +struct hci_evt_le_big_sync_lost {
>>> +       __u8    handle;
>>> +       __u8    reason;
>>> +} __packed;
>>> +
>>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT 0x22
>>>   struct hci_evt_le_big_info_adv_report {
>>>          __le16  sync_handle;
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 66052d6aaa1d..730deaf1851f 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -7026,6 +7026,24 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>>          hci_dev_unlock(hdev);
>>>   }
>>>
>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>>> +                                           struct sk_buff *skb)
>>> +{
>>> +       struct hci_evt_le_big_sync_lost *ev = data;
>>> +       struct hci_conn *conn;
>>> +
>>> +       bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle);
>>> +
>>> +       hci_dev_lock(hdev);
>>> +
>>> +       list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>>> +               if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
>>> +                       hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
>>> +       }
>> Let's start with the obvious problems:
>>
>> 1. This does not use the handle, instead it disconnects all the
>> connections with HCI_CONN_BIG_SYNC
>> 2. It doesn't use the reason either
>> 3. hci_disconnect_cfm should be followed with hci_conn_del to free the hci_conn
>>
>> So this does tell me you don't fully understand what you are doing, I
>> hope I am not dealing with some AI generated code otherwise I would
>> just do it myself.


Thank you for pointing that out. I overlooked these three issues, and 
they will be fixed in the next revision.

> Btw, the spec does says the controller shall cleanup the connection
> handle and data path:
>
> When the HCI_LE_BIG_Sync_Lost event occurs, the Controller shall
> remove the connection handle(s) and data paths of all BIS(s) in the
> BIG with which the Controller was synchronized.
>
> I wonder if that shall be interpreted as no HCI_Disconnection_Complete
> shall be generated or what, also we might need to implement this into
> BlueZ emulator in order to replicate this in our CI tests.
>
> It seems we are not sending anything to the remote devices when
> receiving BT_HCI_CMD_LE_BIG_TERM_SYNC:
>
> https://github.com/bluez/bluez/blob/master/emulator/btdev.c#L6661


When the HCI_LE_BIG_Sync_Lost event occurs, there is no accompanying 
HCI_Disconnection_Complete event.

However, in the patch submitted to BlueZ, it is described that the 
HCI_Disconnection_Complete event will be reported when the CIS link is 
disconnected.

https://lore.kernel.org/all/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com/

I believe that the HCI_LE_BIG_Sync_Lost event is triggered passively by 
the controller when it is unable to synchronize with the BIS stream.
This may occur for various reasons — such as the BIS source pausing 
transmission, the device moving out of range, or interference.
This behavior is different from the host actively issuing the 
LE_BIG_Terminate_Sync command.

In actual products, this condition can be communicated back to the phone 
(Assistant) via the Broadcast Receive State characteristic defined in BASS.
However, in a simulator or test environment, there's often not much that 
needs to be done when sending LE_BIG_Terminate_Sync command.

>
>>> +       hci_dev_unlock(hdev);
>>> +}
>>> +
>>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>>                                             struct sk_buff *skb)
>>>   {
>>> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>>>                       hci_le_big_sync_established_evt,
>>>                       sizeof(struct hci_evt_le_big_sync_estabilished),
>>>                       HCI_MAX_EVENT_SIZE),
>>> +       /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>>> +       HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>>> +                    hci_le_big_sync_lost_evt,
>>> +                    sizeof(struct hci_evt_le_big_sync_lost),
>>> +                    HCI_MAX_EVENT_SIZE),
>>>          /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>>          HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>>                       hci_le_big_info_adv_report_evt,
>>>
>>> ---
>>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
>>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>>>
>>> Best regards,
>>> --
>>> Yang Li <yang.li@amlogic.com>
>>>
>>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz

