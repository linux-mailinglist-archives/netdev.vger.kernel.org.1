Return-Path: <netdev+bounces-127452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C04975759
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858331F22D46
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA7E1AAE01;
	Wed, 11 Sep 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mE3W1Mfj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4115C13F;
	Wed, 11 Sep 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069297; cv=fail; b=sQ4Si/VgDBtAi/OT+D/sgAPKuTsp3H8rBdhMkihA+v49GhjdwRSgSiH9/eDmcZD2yn8Z7VvR/j/27QUChgUV3t7bwRxNMLX09/Xu47zRq6tPDMDGlxGNoq8cHAEonCuBBpckPquMWO1rnO5BSN4UA335EFbHdzKhbg2XVnjpik0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069297; c=relaxed/simple;
	bh=W7H+6COVsU2RZcN8z1FIAKl/lkVfPjhS1wTtvDg8uJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHqQc4Dit88gPGbIEHHthOqzbvdzsbxMojzLf6IWyQE7omDVBQ3WAO2BHjiSsHUFfaj/+/rsSv23QFdXDA8oTcqq/RxRFXUMc8NGkcn/2+TgG0D+ZH6mYoBuarOvxacUh/07sA1twilszXaewnx3DUbvQB3EdaVKLyrklZvI6Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mE3W1Mfj; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfxhO9X0YUo9uiwbcC5V+fbp0zStqlxiXey2qkaGb+tdlhI+DsZOFxMKDkf8DQcOnQCcZthEXlNhb+XwOLrRBBLpHpBKr8NLjBTfDteJG26EDw8AK7elLlf2twPR1yMmSpM7RWyuxAJqvN8x/ttG1Sq07IZ4oI4UdWQ4SElyXGj82NVLOOfpE4w1D77dexUO5WwEYTtoIcm6hjxUnADgBSdpnC58W3yv7Ts5zm28CqxrROJDvOLUJBI8+2nDml1puJqus27DfwxKdPdIx/k9S8UENTbiv2aQTLb0B04I53qKkWPnjTUvcKiFCTRDwX7CmpKbya6XJMQvzoMpJbJLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7H+6COVsU2RZcN8z1FIAKl/lkVfPjhS1wTtvDg8uJA=;
 b=Jp2fVR5+vr4cKmpxZqrkiANb59xfOz+YIdMKPn/DwteN3yiT8KdtCSVlJuJSDzphNCHiaW2Vumc8WJPni0vXkefY60g+cqrNkOVpSJJcbgh0FeoZW20p1ukkQr66qZJV5q6QwNH4PmT7m9zcOiA9VpeQ/oxJD0w+5dsjMmSmbBtF4GhNq5sCuy7N0eGT6Oi8nQrRwJR8/yZAdFc4njhpB5prf5zR6Cn1D8aMAbPs0WyhZhmC3QKgnAEM1APYY3CWGYnc/+Stboa5Y6e2RRLPXK1h4fqaRsrbquv/0oo316Qho8sc2GSxujYBSRLVhxgSdGa1sOqGRm/aDJpYgDDikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7H+6COVsU2RZcN8z1FIAKl/lkVfPjhS1wTtvDg8uJA=;
 b=mE3W1MfjtP6CSdoGCnhvloTCFU+mNQMmcHcWAmI+JHHyUWSqU24lPVdZ37pBOA2sSXTixHsH4Ajs55O81VcV1SZOZVMMiGDF/zHLY+WLj/jf+6nl59KTaT+y/NBEd1XJwcdrkpB3nmIApwzt4MLAHcIcQTVRB9ru5Wjl5VpN5EKESzdShELarJge1B8qXDyztSlvxXnjASU38UXqjF0boaHUvmGKzfDvpyx/7lyrhEEMs8BdCsdObCGlwUmv9MLNHayGzLYzHS0O/gAVcjYG3mfhbdUgEIX0+fcfjaOaGaNdVJdNSz8Hs9TaBzy+QLGvesaLAXueYfJiB3Dzu8rRvA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 15:41:32 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 15:41:32 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Topic: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Index: AQHbA2A2/ifz6xdLskaRO4d4gN4jcbJSMsgAgABSFgCAACuisA==
Date: Wed, 11 Sep 2024 15:41:31 +0000
Message-ID:
 <DM6PR12MB4516864A308D5BDFF0021129D89B2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-3-danieller@nvidia.com>
 <20240911073234.GJ572255@kernel.org>
 <cb9d0196-5b91-486b-932e-e73a391fa609@lunn.ch>
In-Reply-To: <cb9d0196-5b91-486b-932e-e73a391fa609@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB9222:EE_
x-ms-office365-filtering-correlation-id: 159485a5-28c8-47b3-c905-08dcd27835d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHFUNThYZ3I0N1JpUndJMHE1VEVrTVVkc1MvZm1SSHhqcGY1S0JocWliZEs4?=
 =?utf-8?B?aWhvMVMvQ0xCYStKa1IxSkU5NEd3OEhPU25PSDJ6NFFWWjFPdHhQelZyeUpJ?=
 =?utf-8?B?bHg2a2RJODAzT012K2xreTB0RGhBZS9yQkM3NFhDYTZ1QVBQbm5iQSs5L3B2?=
 =?utf-8?B?MDlHTVNVc3FBRU1Wb2VBaWFQWTliYklWU3pIUGgrRUx6aWozOGw5dURzbkpR?=
 =?utf-8?B?S05nYmo3blhvcTJvUGtzVzdKMlpSelhyWnlqcHdpV1JMRmU5QjVvc1N5c3Uy?=
 =?utf-8?B?eWJZcWVlM09OSU53dVFNVHp1OUUxczRyM3hGKzlZZDRaVHJzeGRwZklmcXUw?=
 =?utf-8?B?MEk5YTNKRTVoWDYrb1VYSnVhSFNlU1ZIdjRXREJTWTZuc0JQTjRETlhmS1V0?=
 =?utf-8?B?VDhzS2hvTkdtOEJMampGRTlSOWN1azhGRzNrTzJNdWhMa1FRN3JEbURTNWFD?=
 =?utf-8?B?bWxVQTRqMUNKcWlBTkhuY1U4Z25SZ2JocXZnVGRhRHh6U2I2TitJZktOYktG?=
 =?utf-8?B?Q3FXaDZVN2x2UGlic0NwbEs1WDhpZFR3bWJDV3hIb292MERlVzJhQmZ2Mm5I?=
 =?utf-8?B?WmJVQTZ3SHFPSWh4cGtpZjZiY2NPdWZRUFNNZEhqd2prYXVIbFlMM0t4T1lt?=
 =?utf-8?B?Y25Wci8vcWJtUzVpclVZOFJPV2s4eFgySW41YUkwTXBjRkZsN3lRcTlSSDQ5?=
 =?utf-8?B?eCtibFZ4MlVLZ08rcG5vZnFORGliRDdycW13Wm42UXlta1ViRmRLdldOUXZV?=
 =?utf-8?B?YnZhenJsLzJzbXlPNzhYWm9ha0Z5L2RkY3I2dGlsbE1sbFlkd2NHK25wcytX?=
 =?utf-8?B?QXdrTW5QajB1LzhyWHhwREpjZ1EydEtRRWVtOTZUWGY3di8yemh6SXJVM0Vs?=
 =?utf-8?B?RVRPdjcrQkQ1WWJ6TGpLQVJneUxBbndxTGxCeERGMEpCSVdKNHd2dzRIWks0?=
 =?utf-8?B?bkFrSDZ6dXpEaTQvT0xYcnR3TUMxTmtBa21aVjVyR0FxdTBqWm80c2xWNGpr?=
 =?utf-8?B?UUpHWW94eXZMWWtnVHl5NjZQU2M5ZmRzMjRBbVB0dVVCdWorN09ScFFyMWlo?=
 =?utf-8?B?aVRkOUpCWlVaYWw4a2Z2WUVwYnVrN0hRdW54SEZQQ2ZwMEpEL1Axd1I2WEZt?=
 =?utf-8?B?eVdoMS96c292dTJaREI4R0k0SEdCVlRBRGpERzdmSzlJekVpR1lRUkFNNTYx?=
 =?utf-8?B?aERiRGJCb3luV292TzVzTmRrTHhMdkFUSTljUXl4aFcxU1BYWVY0TU1ZQUNv?=
 =?utf-8?B?L2ZmcGFJZ2JIQVhRVG41V1FObHBpanQyVkVMNjdRWXAwQkhDa2hFc29jSmhz?=
 =?utf-8?B?SXIvRE50UDZZbTBhdGRidEpZU2NWZUpNZGcwdUZmbEZ6anVMc0UrVndDMkRG?=
 =?utf-8?B?ZU8xUTNsbHVCeDFCQVgzdFhBSUtJeFFsQ1AwM2NrckE2WHJ0NEc2eVVQcGpp?=
 =?utf-8?B?YlZZbWpOUkxnNXJVL1hBOEdMTWxUTVRqdVNaeHBjMHczbHpGa211MkdJMmN0?=
 =?utf-8?B?UDd1OWFzeUxZMGxzQXM1OXJ0Szl0S2g3ZVJQT0l1eHU4SWs4YnU3V1owKzVw?=
 =?utf-8?B?TFFBT0FCYUVncldKYjBvSG1ReHZZOHNYaEkyQWk3TWM2RVFrRzNNMWxNRXRj?=
 =?utf-8?B?OWw0WFZ0NjRkWjJ5YjZoeWJWUkh3aFhkaW9sdklNVXhBT2dlMTU0RlU3K2lB?=
 =?utf-8?B?Y2x0bmp2SWs3MEhUNkJuR3p5N2c3alpkaDRNc2ppVnUxWTF2WGU0S1QxZlpm?=
 =?utf-8?B?d2ZBaEpYNnZjL3JPNi9NcnQ5L0JEVis5dlJtR1JlN2dNN0FURWZTcFcxUW9D?=
 =?utf-8?B?ZWZLeTQ3aUdqMWZ1S3pra0RVaGFhTW90Z1VGWEs3eTdQYWdSa2ZkbEVGTitM?=
 =?utf-8?B?QmxzVzM5K1Y1cDMzNFJ2QnZwZWtiaCs3MkZwNk41YTdiNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWU0aEhwZEdlS2g4UmdIcDRJVHZvMERjM3FXYXlhenZsTzRQSnhtakxsUlBD?=
 =?utf-8?B?d0ZVQXhzVEgxSW1NazVHV29ZelE1YXVNeFBpUDMzcDViODJKV01mNVgrdzE0?=
 =?utf-8?B?NlNrYkxxK0dkVDYzU2dtK0xBWXV3cmIvRlNiQ2NVdUZ4TmlhOE9wUGtQaVNU?=
 =?utf-8?B?eEVFVmEzRVU3UlNTRHdUdklmS2F6cXlab2dCQ05NRUlZVHJFVi9QSmpIK3NG?=
 =?utf-8?B?dlI5RE96cFlRWDlzTkVBcjZneFg5d29wYjU1Y1E4d2J4b3J4d1RtUVNSSVpK?=
 =?utf-8?B?M29FZ2kyb0xmVVk4Nmp2QWk0VksxMHB5UHluQk9OVXVLQzFDYXljRWVNUGRu?=
 =?utf-8?B?MWJHUnVOcHkwTzJsb29jSDBTMm9pQ1lrRHl5MHkrenM4azgvRFBMQ1FPRFZx?=
 =?utf-8?B?cnhRYmZGUFp4NnZlZlcyNWh3WDNEamtqVTROUHMxMEw3eEVBWm9GUjVMUEwy?=
 =?utf-8?B?V2ttUmNCUEU0Y1F1d0tFNXNNT3RmZ0hON2xhT3k0U2NPckxPRDQyZEtaSGFK?=
 =?utf-8?B?WW1pUm9rWlU0MUVzeVRHelhQZi85QWxncm93TmZjL0V4cjJ3MFAxdUI1OXRF?=
 =?utf-8?B?ekpnRGdZUVBRTzNZd0pNNUJxcWExcDdLWFZzTFZsZXc1cjk2MUpuSXdtZnY3?=
 =?utf-8?B?UHBMU0NoYXg4N0pDS0J3RURTVStLemltNnZZeXM2NzdWT0FLVmRFQmFDWTdQ?=
 =?utf-8?B?YXRJT3N1MExFTCtRNzBZMEQvbzgwV1RCUkJBeEQzOGVvMThVNS9SWkh6WDBY?=
 =?utf-8?B?WVVCeWdjbGVtZnhzV09Kb3lzTVZsdDdLd25vdTVCd254d1N4OWkrUXJVT3RQ?=
 =?utf-8?B?SnN5QVFVVSt0MllZTTJCaGhDby9hSXRlWmZGdGlzMmRsSnFSazhwN2p4ZFd0?=
 =?utf-8?B?bThNajBqaGlrMFFUaExtbHd3VjZGY0pWYzlvNmJiY1JPMnJRSWpVb09MRnNt?=
 =?utf-8?B?N3ZSTzFkT242NnVpODlVdnZhVlZITHJ6TmlSalZPQXNEVHZjOGEwYTZjVy8r?=
 =?utf-8?B?N3JBZWE0K2IveHozQS8vMWFnQ0tvZGJ0QzkxRW5wZUhMTmx5cTY4MVZkWHZi?=
 =?utf-8?B?RmJqMk5oNkFyRE5iZURvRElWSzhSdGdYbVVldnZHcUt5LzRXS0R4bG1rRjdp?=
 =?utf-8?B?b3JTZ0RVSmNrb05LeTFrVTgyYURyMktNUXI1RTdHcHdJUzVocmtkU0pIWTFB?=
 =?utf-8?B?aEdtYkRFM2JyUWtYMkJvdjR5Q1dlU1YzenloWUdTWWlIZE9oYU5TUFAzZi8z?=
 =?utf-8?B?RXdGN01kd0NMVk1jSW5FYjBKUmFwbGZHZzl1clAxa2ZEVTZQa3N2Tnp1U0ZJ?=
 =?utf-8?B?WVFSSERJRXlLQVkxdU02Zmg4emI1cTNIN090TWpPU2dYMDdZSWpWYlBNN0dV?=
 =?utf-8?B?ZUhjVFJlUE56NlBYT3M5NWtYUVRXVFpFNGt1RUJPdjAxaGRoT1cwQVVzbUZY?=
 =?utf-8?B?eEtLYS9UZ3k3dHljM2VYek1DTnZjV0hTT0xwaTl3YjQxVGxJUTVDR3ZYZWRK?=
 =?utf-8?B?U2RVTVRVbStPRXdyZmhSejA5OXRHWm9OQzJLbCtqa1IxcllOK3JrUHdNT0hn?=
 =?utf-8?B?b1FMdVdnRW1GZlZoQndpbktCU0k5empXNHRqVlVkSVp0Sm9kOHRtZmxFRVI0?=
 =?utf-8?B?Y1pHUFNiOW1vWFpLV3hmUjFIVVZiazlBMVBRelI5cHBUUCtwRW1TTXBZeFVE?=
 =?utf-8?B?dHZGaHFvVk5TRE4yRGh2M2k4UEJnNUpRdWg5QmtDN3pVV05NQ3pDa1NiTEdN?=
 =?utf-8?B?eUJRTUVpaWZLZ2NIUVB1bEFHU1JqcG9jaDZxZVBURzVKZ2s5M2owWE1jMjda?=
 =?utf-8?B?RWc2TDEwemVvTkhlemZobmdHTEdtM0M5eEw0QmhUbWxuNHVXc0ZITWpDVnlz?=
 =?utf-8?B?MTczRFMxTUw5VEdvcWhrL0haSXVTais0STRaMjQ1VkFxSXBEek9zRm1ROWVB?=
 =?utf-8?B?dHErSGVVdVpiclFsYndtTE1oWEVlTy92c01jTlpIMHNOOVRZenNpSWhiRHRv?=
 =?utf-8?B?b2dVUzlGd2JYNkZCNHJxdTllRjlkdXZFWFhhV1dNU01ZZllhenljWkp4NDFu?=
 =?utf-8?B?Zi91ZG9GcW5aeHdqQnJHZkxRcXkxdEFWWFE4d2xCdlVWcFMzYmlEeEdSYVUx?=
 =?utf-8?Q?DQb3Zlh+upIUrPUYumnOzy16x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159485a5-28c8-47b3-c905-08dcd27835d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 15:41:32.0582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFDU+T0FgEjbDJnccC50IPtssXZM0jDblrvaGYBZ5/pzURuC+XSLTinFLkKue6DqE1qAFJsGvkqVpal6GAUTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
MTEgU2VwdGVtYmVyIDIwMjQgMTU6MjYNCj4gVG86IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz4NCj4gQ2M6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyB5dWVoYWliaW5n
QGh1YXdlaS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MiAy
LzJdIG5ldDogZXRodG9vbDogQWRkIHN1cHBvcnQgZm9yIHdyaXRpbmcNCj4gZmlybXdhcmUgYmxv
Y2tzIHVzaW5nIEVQTCBwYXlsb2FkDQo+IA0KPiBPbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAwODoz
MjozNEFNICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+ID4gKyBBbmRyZXcgTHVubg0KPiA+
DQo+ID4gT24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgMTI6MDI6MTdQTSArMDMwMCwgRGFuaWVsbGUg
UmF0c29uIHdyb3RlOg0KPiA+ID4gSW4gdGhlIENNSVMgc3BlY2lmaWNhdGlvbiBmb3IgcGx1Z2dh
YmxlIG1vZHVsZXMsIExQTCAoTG9jYWwgUGF5bG9hZCkNCj4gPiA+IGFuZCBFUEwgKEV4dGVuZGVk
IFBheWxvYWQpIGFyZSB0d28gdHlwZXMgb2YgZGF0YSBwYXlsb2FkcyB1c2VkIGZvcg0KPiA+ID4g
bWFuYWdpbmcgdmFyaW91cyBmdW5jdGlvbnMgYW5kIGZlYXR1cmVzIG9mIHRoZSBtb2R1bGUuDQo+
ID4gPg0KPiA+ID4gRVBMIHBheWxvYWRzIGFyZSB1c2VkIGZvciBtb3JlIGNvbXBsZXggYW5kIGV4
dGVuc2l2ZSBtYW5hZ2VtZW50DQo+ID4gPiBmdW5jdGlvbnMgdGhhdCByZXF1aXJlIGEgbGFyZ2Vy
IGFtb3VudCBvZiBkYXRhLCBzbyB3cml0aW5nIGZpcm13YXJlDQo+ID4gPiBibG9ja3MgdXNpbmcg
RVBMIGlzIG11Y2ggbW9yZSBlZmZpY2llbnQuDQo+ID4gPg0KPiA+ID4gQ3VycmVudGx5LCBvbmx5
IExQTCBwYXlsb2FkIGlzIHN1cHBvcnRlZCBmb3Igd3JpdGluZyBmaXJtd2FyZSBibG9ja3MNCj4g
PiA+IHRvIHRoZSBtb2R1bGUuDQo+ID4gPg0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHdyaXRpbmcg
ZmlybXdhcmUgYmxvY2sgdXNpbmcgRVBMIHBheWxvYWQsIGJvdGggdG8NCj4gPiA+IHN1cHBvcnQg
bW9kdWxlcyB0aGF0IHN1cHBvcnRzIG9ubHkgRVBMIHdyaXRlIG1lY2hhbmlzbSwgYW5kIHRvDQo+
ID4gPiBvcHRpbWl6ZSB0aGUgZmxhc2hpbmcgcHJvY2VzcyBvZiBtb2R1bGVzIHRoYXQgc3VwcG9y
dCBMUEwgYW5kIEVQTC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWxsZSBSYXRz
b24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IE5vdGVzOg0KPiA+
ID4gICAgIHYyOg0KPiA+ID4gICAgIAkqIEluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdieXRlc193
cml0dGVuJyBiZWZvcmUgdGhlIGZpcnN0DQo+ID4gPiAgICAgCSAgaXRlcmF0aW9uLg0KPiA+DQo+
ID4gSGkgRGFuaWVsbGUsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUuIEZyb20gYSBk
b2luZy13aGF0LWl0LXNheXMtb24tdGhlLXdyYXBwZXINCj4gPiBwZXJzcGVjdGl2ZSwgdGhpcyBs
b29rcyBnb29kIHRvIG1lLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj4gPg0KPiA+IEkgZG8gbm90ZSB0aGF0IHRoZXJlIHdlcmUgc29tZSBx
dWVzdGlvbnMgZnJvbSBBbmRyZXcgTHVubiAoQ0NlZCkgaW4gdjENCj4gPiByZWdhcmRpbmcgdGhl
IHNpemUgb2YgdHJhbnNmZXJzIG92ZXIgdGhlIGJ1cy4gSSBzZWUgdGhhdCB5b3UgcmVzcG9uZGVk
DQo+ID4gdG8gdGhhdC4gVGhhbmtzISBCdXQgSSBkbyB3b25kZXIgaWYgaGUgaGFzIGFueSBmdXJ0
aGVyIGNvbW1lbnRzLg0KPiANCj4gSSBkbyB3b3VuZGVyIHdoZXJlIHRoZSBzcGVlZHVwIGNvbWVz
IGZyb20uDQo+IA0KPiA+IFRoZSBMUEwgY29udGFpbnMgYXAgdG8gMTI4IGJ5dGVzLCBhbmQgdGhl
IEVQTCB1cCB0byAyMDQ4DQo+IA0KPiBBcmUgMTI4IGNvbnNlY3V0aXZlIDE2IGJ5dGUgdHJhbnNm
ZXJzIHBlciBibG9jayByZWFsbHkgZmFzdGVyIHRoYW4gOA0KPiBjb25zZWN1dGl2ZSB0cmFuc2Zl
cnMgcGVyIGJsb2NrPyBJZiB5b3UgaGF2ZSBhbiBlZmZpY2llbnQgSTJDIG1hc3RlciwgYm90aA0K
PiBzaG91bGQgYmUgZG9pbmcgNDAwS2JwLiBJZiB0aGUgbWFzdGVyIGlzIGluZWZmaWNpZW50LCB5
b3UgZW5kIHVwIHdpdGggdGhlIHNhbWUNCj4gYW1vdW50IG9mIGRlYWQgdGltZSBvbiB0aGUgd2ly
ZS4NCj4gDQo+IEFuZCBkb2VzIHRoZSBzdGFuZGFyZCByZWFsbHkgc2F5IHlvdSBjYW4gZnJhZ21l
bnQgdGhlIGJsb2NrIGF0IHRoZSBJMkMgbGF5ZXI/DQo+IA0KPiBJIHN1c3BlY3QgaW4gdGhlIGVu
ZCB3ZSB3aWxsIGhhdmUgYW4gQVBJIGJldHdlZW4gdGhlIGNvcmUgYW5kIHRoZSBkcml2ZXIgdG8g
YXNrDQo+IGl0IHdoYXQgc2l6ZSBvZiBibG9jayBpdCBhY3R1YWxseSBzdXBwb3J0cy4gQnV0IHdl
IGNhbiBwcm9iYWJseSBhZGQgdGhhdCB3aGVuDQo+IHdlIG5lZWQgaXQuDQo+IA0KPiAJQW5kcmV3
DQoNCkhpIEFuZHJldywNCg0KSW4gYm90aCBjYXNlcyB3ZSB0cmFuc2ZlciB0aGUgc2FtZSBzaXpl
IG9mIGRhdGEsIHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZSBzaXplIG9mIHRoZSBmaXJtd2FyZSBp
bWFnZSwgdG8gdGhlIG1vZHVsZS4NCk1vcmVvdmVyLCBpbiBib3RoIGNhc2VzIHRoZSBzYW1lIHNp
emUgb2YgZGF0YSBpcyBwYXNzaW5nIG9uIHRoZSB3aXJlLCB3aGljaCBkZXBlbmRzIG9uIHRoZSB3
aXJlIG9ibGlnYXRpb25zLg0KDQpCdXQsIGluc3RlYWQgb2YgcnVubmluZyAjbiAiMDEwM2g6IFdy
aXRlIEZXIEJsb2NrIExQTCIgY29tbWFuZHMgKHNlZSBzZWN0aW9uIDkuNy40IGluIENNSVMgNS4y
KSB3aXRoIHVwIHRvIDEyOCBieXRlcywgd2UgYXJlIHJ1bm5pbmcgI24vMTYgIjAxMDRoOiBXcml0
ZSBGVyBCbG9jayBFUEwiIGNvbW1hbmRzIChzZWUgc2VjdGlvbiA5LjcuNSBpbiBDTUlTIDUuMikg
d2l0aCB1cCB0byAyMDQ4IGJ5dGVzLg0KVGhhdCBtZWFucyB0aGF0IGluc3RlYWQgb2YgcHJvY2Vz
c2luZyAjbiBjb21tYW5kcyBhbmQgc2VuZGluZyBiYWNrIHRvIHRoZSBjb3JlIHRoZSBzdGF0dXMg
Zm9yIGVhY2ggb25lLCB3ZSBkbyBpdCBmb3Igb25seSAjbi8xNi4NCg0KVGhlIHN0YW5kYXJkIGRv
ZXMgbm90IHNheSBhbnl0aGluZyBhYm91dCB0aGUgSTJDIGxheWVyLCBidXQgdGhlIHNwZWVkdXAg
ZG9lc27igJl0IGxpZSBpbiB0aGF0Lg0KDQpUaGFua3MsDQpEYW5pZWxsZQ0K

