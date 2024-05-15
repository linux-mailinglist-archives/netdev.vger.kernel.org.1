Return-Path: <netdev+bounces-96617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298308C6AF6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1451F229AB
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73FA25745;
	Wed, 15 May 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uk3nyQRA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC022F03;
	Wed, 15 May 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791962; cv=fail; b=C2Zp6mhjqYW3AiRfQ/W1dLOaJAsDVQ5Z47phWt7vHUkgja20AupL1rjKCEJvElWCOv8tSTxC6ZbpcWBq8QJVj8EBD1MKTXPnAtAof44f0uua+GS4nunFNcNhdYnHctT4xQrRSZkLFZBtKYSlRxpUTmK54wESjKjOtmSn/dl+FWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791962; c=relaxed/simple;
	bh=05oA51NiMHFoXMhlHr9L5XkoejTFtFfpOgEejGJrnKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qC5NbkTlGtYYsHEtof3mGEQHLvXicDORgg6WA1ckBYjeGV/gdbPApkRSrdLiW4ZOWh3UPEa0RnkOYNbr1p9P90DfiIsdhKHLEMj8i8Rxvd3VJ+nMWtqiRH9N9bQQjwowWKGFeD2qB6jfTplnTGsmpmHzzEYvqmJFSi6YsyziYPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uk3nyQRA; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM34o1n01VzKK6hSxudIgxYAw6v6DMIyE0BogFN3desm1QIk9szPw9gKqdvay6XjfKKA62AGrpuly0GMZ5Ezycq7Hu1i3xnBOE55CrqTNu6m8Xb0dA85AZ/ZVKv7D84Up3epj0faZ3yGd34eunBatSniXWPI9EVgSVpAX8BQv99hbDs+bVjDFFzBczixwCxoH5HJCY1w3a7LWUtt1e9XlEU+78oJyeUtEkq4ycs2WoU9I+pY8TVIcEn2n5TQYgzTDNvVYjGstpNsuZsleZFeLdPYcn4T4cJ/4Q0YlIwb9x9MMWqDRtAtN/gVkqFsENW6xbsjlEuiJnGyr5y9TOl7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YOAoM86uWle2yDyBI4rAxsD8DAOguq8ml+K7eiU5yA=;
 b=fUd1aPV0GAj0IrImg5zbC3kZBg8isBhmNaqHWMxpIpfdlU/Hh0AShYXaRTkAP0/X+rp68ZM5AKFxmbytQhnPwtYMqrvTzX7ru/nswDSyLNd2WzP1GYUtVU24mXEcr5XppH5ZITphnafNNI0Yt+pHzBBN/tjypX56/i9V8wG6RITEh25p8al4qC+Hn/ygKzkrDK83WU3AeSNhjtsu1g3elpIEK/GSd1JCarBIlD4mt0BNkjv4xprVSw+iVSkJSm1vrcY9fj+XiaRC28nv2TPyQYBoqzAdnhFEHW+pvT7jLvLNzjSzeb30y5jS/fLWQ0fxM8Zcm7VYcprCckkn+HjCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YOAoM86uWle2yDyBI4rAxsD8DAOguq8ml+K7eiU5yA=;
 b=Uk3nyQRA7vClYDDAL0R73Kti1kgYYe577Cfm5DcIs1tjGAx1KP0upU0s2nKIq+IEMH5B0l8Ke36OocrUo5Iqs33XY4cB4zx7bLnZkB4uE+tEnL5xT+bld8FS23Sl9FhJQgXECMlc4LMQJJ7SVKMiN1R7mhz9/YEeRBhmMzVb9H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 16:52:36 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 16:52:36 +0000
Message-ID: <26b64d11-9cd2-4e60-b7ce-be2dea0f2caa@amd.com>
Date: Wed, 15 May 2024 09:52:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v9] ice: Add get/set hw address for VFs using
 devlink commands
To: Karthik Sundaravel <ksundara@redhat.com>, jesse.brandeburg@intel.com,
 wojciech.drewek@intel.com, sumang@marvell.com, jacob.e.keller@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Cc: pmenzel@molgen.mpg.de, jiri@resnulli.us,
 michal.swiatkowski@linux.intel.com, rjarry@redhat.com, aharivel@redhat.com,
 vchundur@redhat.com, cfontain@redhat.com
References: <20240515142207.27369-1-ksundara@redhat.com>
 <20240515142207.27369-2-ksundara@redhat.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240515142207.27369-2-ksundara@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9caf4a-7c75-4d94-5a01-08dc74ff6c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVlYdmVodDc4UllsZFJuOXBDMDlhcFJOMHZ3L0FJK3JwQ0tRSXFkZTRvUjZO?=
 =?utf-8?B?TDhoTHNzbldqMXZSZWwyMkN0OUZmdzFTL1FJVElsYysvU1Jzdkdoa09qaW9C?=
 =?utf-8?B?cDhONXVoMS9ZM2ZOWXZYRytYNkgrN05Za3ZuTGNsVTVYQk4yWURLekVsNTRn?=
 =?utf-8?B?dEN3SFgyNm1IOSs3bnJKSnUzdHRjeFoyN2U2c1MvelZGQ1dWZ0JpZnl2b21R?=
 =?utf-8?B?dU1EeWM5SldtRjAyNGoyYjBmdG1QNGdrc3BUbWVQZGZGRGVOL0Nhd2wyR2pP?=
 =?utf-8?B?VkNlbzBiTEpzaVpySzNuRzFSRDNyZmxaL0FZeEx1QWM2eHhzWTlPMy9hbjdT?=
 =?utf-8?B?MGJZbENHVWhxRDhWNFFPaUZxNlNPRFBTRG1yN2l6d3ZvL2FUMkUwZ2FxMTFs?=
 =?utf-8?B?UVNkU3kraXNPSEJhbjRZL3ExMW5RUzFCY2dxVWFJQjZwM1BZQUcwVFJhTmdy?=
 =?utf-8?B?MG5tc3g3RHlzS0xSenFwS0JUTmxZbHRQUWJWeWREKzZZNWlSMXlFOENCQ2dh?=
 =?utf-8?B?Rk80TGE2TE0rbnhJTHpWOWUxUW9pLzNCbFpGYmI4Wk5HZkVuK2pMZXZqbWta?=
 =?utf-8?B?dWlkTUR2aU03dkozTlJjU2VEb3NqaVB1eHcreTFTbzAxeWxoQmFhUHQ1T21P?=
 =?utf-8?B?N3ZFWFFtMlRzbDBXWnVJNUp4MWRDdlNWRjZub3VBUHNDSmlKaGpUZFhRMDVo?=
 =?utf-8?B?L2NpaUQ5bys4KzJiM0tUamU5cjBSMkVjNTRydGNIcUwzMGNwRTBiSkFzQXJB?=
 =?utf-8?B?eDBIRXVrVldZTUJtVE5pSk8rMWxRaU5CeEJJbVlhZG0va2oyTmR1bEVBSlUr?=
 =?utf-8?B?a2JYM21WYkoxRlp1L2Q3QkJBWDJTSU5LNU9kZGU0N3BxM2dlTmNzQVB2Q0Y5?=
 =?utf-8?B?OHRNS3JjSGxkQTRSd0M5c1lLNnJZU2thczZySVFSZzZtNkZFN3J1WFFsQ0hL?=
 =?utf-8?B?UFBPS1VNc1VIQm4wMW1OTTJNZFZHNDJCNHVpT05nYXZYYWYxbEM2ZjdXM3Fx?=
 =?utf-8?B?ZnlMak5wZG1MQnBRQUF1Y291clNKN0VPSkVkWS8xNU8rSlcxV3hSRWl6amNC?=
 =?utf-8?B?aWM1NVJwcHh4allHVllUQ0l5NjFXeVUraklJZHFMR3BHaGE5S1UybDlSeTFa?=
 =?utf-8?B?RHBGRnRsN3JvRDNYY0V1NVJCczh1RTVrV0dSekVnWHdrY2tTY3ZxZHZFWnNt?=
 =?utf-8?B?OVhHWURiTDl1VVU4Q21QaFF3anBJZ3FycE80VGhzdnArVHZUZnNtbzhuNTVl?=
 =?utf-8?B?WHNWY2lIRDVZaG5jMTFPU1RRdGhUc0ZtV1JhTDJ5UGNhd09zMjJ1VjFSbjU4?=
 =?utf-8?B?eVZpUTd2bXJqRWhlTkd2YW9OY1NERktjSjkxQnBOQUNrQndnYkdkV2RqYytB?=
 =?utf-8?B?N0VxcWZkZ2JEczN4Q1VoT2dFM1NhUGFBcFByTlZNVkpTRGRWaG94WlpKc3NS?=
 =?utf-8?B?elBvYnUzZll1c3ZRQ09rS3NQd0oyT1VHaFpVQkZ1NjdPYnJkS0dYR2pYNUdm?=
 =?utf-8?B?YkV2MWhRQWNnUFJSTkhvL3lVb01LS1FBWXhtVy9jZ3R6WGZXMHdRREVVSDM3?=
 =?utf-8?B?YkFVWTZONnlKWmU0cWxsalVrT3YvNlBST1BqOTVtTXZVQUlzZjNtV0ZWSHFn?=
 =?utf-8?B?ck9ZVmhHTjVIYlE0NTJ0LzZzUHQ4Sks5cGEwa05iamIzMnBJc0g4WnkwaXNM?=
 =?utf-8?B?RXNsOVdBaEk2ZWVFakRoUkRQeXN0VGtSSDBQOGRKamU4Q2JLQzZnVytIUzY3?=
 =?utf-8?Q?RDNhmKihsAIcay3wKK0SIv525SIZmoZ0ZnvQfv4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmcrcU1VYUI0bzNGdy85dVdXVDRBc05OTmlaN2FpdWU1d3JkWlVrQ2ZSNCtS?=
 =?utf-8?B?aFRhOEkzaitkK1pkdkM0clVtcmZ0eUJraThGRE1jQ0htaGpWQnBZOVRGUDUz?=
 =?utf-8?B?dFFqcXJLT21xWjRuSmpBSm1xd3lBSlRBc3FqRW9QS240eWIrOXF0bzFkdVR3?=
 =?utf-8?B?cHE1ZUcrVitaa0FLZG5OZ1NpeWxvaHVTUUpoZHVqdVdsbm1UMHY1a2wyeUNU?=
 =?utf-8?B?K0FqNFdSSG0wVDhqaC9LbTVXK3ljSVJjYmxKaUJPSVpuOGI1b1hkNFhHTExm?=
 =?utf-8?B?OFVJZk1TMFRLWi9hMWs1WnNwaEF2V0JTWmR2a3ZWclh5SWg0SlR4cXhGbHds?=
 =?utf-8?B?L2gzSW1IU2Q0eE1GNWl2QUJXZG1hZDNpOXlDNmo3SmErMVhoQ0NsdGtrdzRC?=
 =?utf-8?B?NnFrSTlFdzJPNTdVOGYvTXpYaW5HRW4rd3U4eGZzTi96Sy9NcmVRaHJoc3Fl?=
 =?utf-8?B?a2hxbllmYUhMbnBzakVYOS9jWW1RdWtxU2lQODBWYnZZcE85STN2NmFud1hO?=
 =?utf-8?B?U2pEOTB3T05YVTRhUERjdEdrY3krQm0xUzVBZWFIcStUYzA3MzNzM0lSWDQ5?=
 =?utf-8?B?dmpMdWZsdEtOMXhXajFwblU2TFVhaksrVnZUdmcxR2g2TTRSdmw1VXdzYkJv?=
 =?utf-8?B?TUE2L25MVDNXeFBqVWNTMWxSem93Sy94NnRnRVFxL1NaZmgydmNuWmYyVlhZ?=
 =?utf-8?B?Qm1mSjRaMWljSmhNSjdCVDNQS1dodVkzWlZhMUhUV0ZTUndaeDNlVmNUbDJa?=
 =?utf-8?B?OGVOL0x2Z2psT2E3QWRObi8rZ29ybFR5TTZsQnZySzVBNE8yWXArYTcrUGww?=
 =?utf-8?B?MnlwbjZIcGdDWXU4VkNvV0xBOU1wM2F3NGYyV3hNSkxUTzUvRUV5QWxNdnhF?=
 =?utf-8?B?cXlxRWF5eml0a3ZiQUZxS0MzbnQ1YmdmeWFpMGNmWWJ3ckUwZkJMeEZqMDM2?=
 =?utf-8?B?cFpuaVFzWFpjYzh2Y05oR0dvM2lDSGZMTzdsdStQalFTblFRZE5uUEdpd2NV?=
 =?utf-8?B?Y1EvdDVzRDF3dmovSk1GT0krN1dibHI5MVF6Qk9EeFVUK2VFOG9lamwrSXpZ?=
 =?utf-8?B?Z0Z1eUgzUUd3RFpOb1VwUkIwclN4L0lGQTYrTmhYYi9vbU5tSkhVMWZjajRZ?=
 =?utf-8?B?WTZSbFluRmdSWkxGUTFQZjdvZGlsQVc5N05Eamc2MndrS3d4eVFIeW56NzV1?=
 =?utf-8?B?UWhSOGJyNTUzM2U5cFFRdms0V1BxSDA4Tlh3d0Rvb3A0a2s1d2tFdTIxZEpR?=
 =?utf-8?B?VmgzdGFWWmh0Y04zdFFoTDFGa0JkNWVGNWhYZ1piZFJvZnk3U2RBYlFQVnZh?=
 =?utf-8?B?dkxCNTZ0ZVRpR3N2ZzF3OHlUVW03N3kzN3duZ1pwamRxZGN0WC84UStNSmU1?=
 =?utf-8?B?cXBKK2k0S01rQ3lFRVFMUDQ1L0Z3aHlRVXVRZjlmb0JoZHBhdWtCRWt0ZG13?=
 =?utf-8?B?b0N2RG9OcnVvdDdybFFxTmx4dWJ4Z3dMczZSemFIdTRyaU4xNlFMZzFnck5q?=
 =?utf-8?B?YVhFVzYvRW1XRXdkOGlKT0xEVWpIK0Z5Rm9iTkxYNkJmWnFTcDV0VmtrL1or?=
 =?utf-8?B?Y243Z2FKcDJINS9SdFUyZkNKaXNzazZ5L1dYeFUzbG4wUDdVOS95U3BzWmta?=
 =?utf-8?B?bzNzVkZGTkZsSzJkN1UvSkgwUFlqdUZNUWdRanJmQnQ0UFBmTzAyRDBHaTlD?=
 =?utf-8?B?bFZ1UEk5Y05YN0J6ZXYyT0xoeldtRXpuTHpLSVpMQTVjR0tYaFhyNDJ4TFFu?=
 =?utf-8?B?eGRDY1gyTk1aKzVkZG5ud0JBY2VMeTdwQ2svdkpWOVpHeEVPRFJ1NjlQRGw1?=
 =?utf-8?B?RE1ONERDZWo2TjdWZ3VJc2hwZ1ZITHBaVEVBYTBBY2tKUjYwMWxNS3YyaXha?=
 =?utf-8?B?NWhZMkczc3NXWFpPYmJkbnZEbXQvaW0wVEF2ZEphTjIrY05FM2gvbi9EN3JO?=
 =?utf-8?B?dWpkekFSRUgvVlpBelduVWhOMmJnakZ5ZHJ0ZG9Xb2dpa2JvSmxFQTN4endt?=
 =?utf-8?B?VFA4OEcrYUNLek5Xa2I0R1piWFB2NXlpYjBYOHliSkEvOWVlT016TFhpVUth?=
 =?utf-8?B?dnBybm1XTWQxM0U4dld5enNaQ0VvZzNXRm5lVTB5bWNGdjBtbldFZ1ltZFRM?=
 =?utf-8?Q?IwgY1/GENCwiEawt/GL47WL1O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9caf4a-7c75-4d94-5a01-08dc74ff6c5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 16:52:36.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rdPhc/Cj8j3vr5d5LVTf3rpnyzs7kte7no2qxmoEw/1sAJvTQJuHHx5522zoZFKoRDdMpxyh43m98dNlBbv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317



On 5/15/2024 7:22 AM, Karthik Sundaravel wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Changing the MAC address of the VFs is currently unsupported via devlink.
> Add the function handlers to set and get the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---
>   .../ethernet/intel/ice/devlink/devlink_port.c | 59 +++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 62 +++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_sriov.h    |  8 +++
>   3 files changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> index c9fbeebf7fb9..6ff7cba3f630 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> @@ -372,6 +372,62 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>          devl_port_unregister(&pf->devlink_port);
>   }
> 
> +/**
> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> +                                         u8 *hw_addr, int *hw_addr_len,
> +                                         struct netlink_ext_ack *extack)
> +{
> +       struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
> +
> +       ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +       *hw_addr_len = ETH_ALEN;
> +
> +       return 0;
> +}
> +
> +/**
> + * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_set operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
> +                                         const u8 *hw_addr,
> +                                         int hw_addr_len,
> +                                         struct netlink_ext_ack *extack)
> +
> +{
> +       struct devlink_port_attrs *attrs = &port->attrs;
> +       struct devlink_port_pci_vf_attrs *pci_vf;
> +       struct devlink *devlink = port->devlink;
> +       struct ice_pf *pf;
> +       u16 vf_id;
> +
> +       pf = devlink_priv(devlink);
> +       pci_vf = &attrs->pci_vf;
> +       vf_id = pci_vf->vf;
> +
> +       return ice_set_vf_fn_mac(pf, vf_id, hw_addr);

Instead of creating a duplicate function, it seems like you can do the 
following instead:

pf = devlink_priv(devlink);
vsi = ice_get_main_vsi(pf);
if (!vsi)
	return -ENODEV;

[...]

return ice_set_vf_mac(vsi->netdev, vf_id, hw_addr);

> +}
> +
> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
> +       .port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
> +       .port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
> +};
> +
>   /**
>    * ice_devlink_create_vf_port - Create a devlink port for this VF
>    * @vf: the VF to create a port for
> @@ -407,7 +463,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>          devlink_port_attrs_set(devlink_port, &attrs);
>          devlink = priv_to_devlink(pf);
> 
> -       err = devl_port_register(devlink, devlink_port, vsi->idx);
> +       err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> +                                         &ice_devlink_vf_port_ops);
>          if (err) {
>                  dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>                          vf->vf_id, err);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 067712f4923f..dc40be741be0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1415,6 +1415,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>          return ret;
>   }
> 
> +/**
> + * ice_set_vf_fn_mac
> + * @pf: PF to be configure
> + * @vf_id: VF identifier
> + * @mac: MAC address
> + *
> + * program VF MAC address
> + */
> +int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
> +{
> +       struct device *dev;
> +       struct ice_vf *vf;
> +       int ret;
> +
> +       dev = ice_pf_to_dev(pf);
> +       if (is_multicast_ether_addr(mac)) {
> +               dev_err(dev, "%pM not a valid unicast address\n", mac);
> +               return -EINVAL;
> +       }
> +
> +       vf = ice_get_vf_by_id(pf, vf_id);
> +       if (!vf)
> +               return -EINVAL;
> +
> +       /* nothing left to do, unicast MAC already set */
> +       if (ether_addr_equal(vf->dev_lan_addr, mac) &&
> +           ether_addr_equal(vf->hw_lan_addr, mac)) {
> +               ret = 0;
> +               goto out_put_vf;
> +       }
> +
> +       ret = ice_check_vf_ready_for_cfg(vf);
> +       if (ret)
> +               goto out_put_vf;
> +
> +       mutex_lock(&vf->cfg_lock);
> +
> +       /* VF is notified of its new MAC via the PF's response to the
> +        * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
> +        */
> +       ether_addr_copy(vf->dev_lan_addr, mac);
> +       ether_addr_copy(vf->hw_lan_addr, mac);
> +       if (is_zero_ether_addr(mac)) {
> +               /* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
> +               vf->pf_set_mac = false;
> +               dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
> +                        vf->vf_id);
> +       } else {
> +               /* PF will add MAC rule for the VF */
> +               vf->pf_set_mac = true;
> +               dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
> +                        mac, vf_id);
> +       }
> +
> +       ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +       mutex_unlock(&vf->cfg_lock);
> +
> +out_put_vf:
> +       ice_put_vf(vf);
> +       return ret;
> +}

This is almost an exact copy of ice_set_vf_mac(). The only difference 
being the function arguments.

Was there any reason to not use ice_set_vf_mac()? Why can't you pass the 
PF's netdev?

> +
>   /**
>    * ice_set_vf_mac
>    * @netdev: network interface device structure
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
> index 8f22313474d6..2ecbacfa8cfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> @@ -28,6 +28,7 @@
>   #ifdef CONFIG_PCI_IOV
>   void ice_process_vflr_event(struct ice_pf *pf);
>   int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac);
>   int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
>   int
>   ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
> @@ -80,6 +81,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
>          return -EOPNOTSUPP;
>   }
> 
> +static inline int
> +ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
> +                 u16 __always_unused vf_id, const u8 __always_unused *mac)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>   static inline int
>   ice_set_vf_mac(struct net_device __always_unused *netdev,
>                 int __always_unused vf_id, u8 __always_unused *mac)
> --
> 2.39.3 (Apple Git-146)
> 
> 

