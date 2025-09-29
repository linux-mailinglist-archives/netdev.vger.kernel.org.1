Return-Path: <netdev+bounces-227204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB42BAA1B7
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59231C5A99
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10492219301;
	Mon, 29 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="eTP0ZUzi"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022115.outbound.protection.outlook.com [40.107.200.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0015CD7E;
	Mon, 29 Sep 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165895; cv=fail; b=U9W/iU3g2dPxRC3+umds9S4KpL0rZ4N3GtjOu2qmHHFrEku51b+9A/jMrkVw58YqQ7aQk+84yceGpdyngQueFXZzesWpyHAGDzhuFpQ50b66itrGDCPG//eRqTO6z4SYnt318VmD62r+Ubclld2yN1+L7Ii7+DbwyoVEzAUMXUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165895; c=relaxed/simple;
	bh=C9lQ6D3/tO7igUyybdSOSMJbYOXZpOzq0qflSdGrE58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afhIAWwx1xnfiu8sRZNh+ckOgMXTHGi9WIjxxurS0DJ3UbpSKd9VQUDpiGC7TFuM8D009KuSD9LdGlKE5sJhtJDZFigiXXbOLZmslO+DF6asyghUCedlMzUetqI7qM7qF3CleAzlLGRCQJQt7gYQPkUtQO+xEVDFV9cI9Thz21U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=eTP0ZUzi reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ujum4DQeL4q5Lcj4mtOfY1wPnNfF7U8UA8fAalz8xZH6vYQckNwdE8zuQGM2BD8zZbG/D0LnWWnATy+sUMQz5jATQVkKV7UrjwHC7CweKKdLRLyrmLrFAbrKqqmJy6Lhj+WqFD+UsdGwqetYrlniijweSjhXzvy9an/IUn0UaACue6hmWLOkUF9j2sYk2XkQGgOGbjjqfazrSPMhqqWJoBuNo5VwkglTHiRdQY74yJyM5s4yr2xbooyMVXIpSb9KqCsMEmQUXvhI51QijLS2rSlNqq8NkGbOrCsvpdM+pUqcCfC2m1JySMswuRb2wJ3TYjauVN05sFIV7zbemJopLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfXXYSMqAzcQPk11waEi576U1UCjDv42CQscg1O3hbI=;
 b=p+CjFMCezKB5HFWUumUjrdipicUBE/qEv37mTzg2QkqrQrpp1WO9KAfO9oaO7ilHvFARwYGvtwh6hucqZzt2VQLKvSGkRG0LnY8id+jfuE48zCHQzXG9+efra8HfV3VNnxra9ph/vRWGzHQYvY5rA16IP17d6lrmuyvphrLSfydZkVJ/4/OZfNneyHXmR0EZM5xyfJZoc5oTEEfsYMWVCtkmpxFqnUixgvQdLg8bM7OoSObPOAAsTxJ/O/7MIc9ilsmVgtbTWvz5s30b+RUw5e14VRabfte6Z383JI8BZWIXvOaBkC4WUvrr0uYujMzP+pWlSt6hvxKVZSE9OU70sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfXXYSMqAzcQPk11waEi576U1UCjDv42CQscg1O3hbI=;
 b=eTP0ZUziQFppu+IV9ABZKjAuUZrf0Id+927WQ1gccudoGF6IbkAUvskCbx6ewAcxMea1ezcm6d+k4vJU3/TwMYVj6P1DLxqKuI+4v3jltsMVYakySBOw0oO+HC5d8DZtcgzWn2Ul/kWfyZqCzX38LO0/d0FbpK1OCKyHZNQSPTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB6874.prod.exchangelabs.com (2603:10b6:610:113::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Mon, 29 Sep 2025 17:11:27 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 17:11:27 +0000
Message-ID: <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
Date: Mon, 29 Sep 2025 13:11:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar
 <jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250926153311.2202648-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0110.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c125751-9b7b-4d00-c3ba-08ddff7b39eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDFTWm5aWWY2Ukk1cW9IRWY2eDEvTktCUi9palI4MTlOM29Ra3h4eURwRHUy?=
 =?utf-8?B?eVJLRzJ2cmhrTGhHQmFXTVkrdWFuNVNlYnZ3SzV6a215d0pwaFpOV0ZFUUtL?=
 =?utf-8?B?a2R3SktBR1dCbm8vWnVoTDdCUTdvV2lDcVk0eXNwL1hqZGNZZTNhTk95cnZO?=
 =?utf-8?B?VVhrTUc2eDZpbUUwVUtWek1kS1gxN3BDcjM5c2k5aDB3bjRnZGEwdnhVZmRO?=
 =?utf-8?B?K25YRzcxQnhsdXZuMmsxaXFxcHFjQ2dIN0JvTjFrYStaMVA2VmgrbEVRVU9Z?=
 =?utf-8?B?TlJ3eWRQbEU4dmdrNm5FODk3REtqL1g5VGMrMmU1VnhzcUZ3dDUyUXlkSTIx?=
 =?utf-8?B?VG5PS29UbWFRT1pXTzREZGI2MGRrMk1UQXRETU45dEswZWdONithdDcrTGtB?=
 =?utf-8?B?Y3kxa0owQ0VFa1VTRUplY2FFTVFsYmt4Slp6aUxjNzhka2I3dytlWnp6NXE2?=
 =?utf-8?B?OFBiT3Ywb05MOG1pTEk4MC92OEc3QU5MNkVES3EvN0NmL3NoM256SFpsQWRl?=
 =?utf-8?B?WmREbDF4Y3VTNWtEUnBQdFMxTVJCWkZQRTNIZEFRSzJiaS9PQ284bDVxelN2?=
 =?utf-8?B?QXlZOEFneE5aS25BbEJDZkxDODhKWXRhYUtMUzBHZjJXenQwTENaNUgvZW1U?=
 =?utf-8?B?R3JoV1MxWkdhRTZjK1djcFlOd2JDNjIzWFBYVENMQXljdUZRTTREdjZFQ3Bi?=
 =?utf-8?B?SkpRUHNjd1hraEsvbG91TWZ1VGxIclQvUjdyY3Yzd0NlRUtodFhrbmxoRDF3?=
 =?utf-8?B?ckZWQXdnOHcxMkxURVYwR2psbG1rTWtBc2NIbnc2NzlJZEZEcmkrTDMweEJF?=
 =?utf-8?B?aXdXR1hMcVRDNmh6bmozc2lTblhNZWw1WHBFKy80S3djdDNFRzg0MGpRT1FT?=
 =?utf-8?B?eXZqMDNKQTlDL0orRG05K0tBbmZCeTRPRGJ3emZidnZJU0RRd0w5Q3dqM0ls?=
 =?utf-8?B?SkFxYm9Zc3NldGdqUW1QcWdtaFBNSHpNUCtBMmYzeENMVVU2dTVtZEsyU0FE?=
 =?utf-8?B?ekhsYUlPOFN2MXFrSjBCRzVFUERPQUtnK3BRWXdEQTdxRWorSWpPcjNpaWFo?=
 =?utf-8?B?NUlGWVMwUmhjVm9OdVZIMzJ5Z0o3MlVyM0N0WmViek9hcldsVnM3SS9FZHN0?=
 =?utf-8?B?S2RZMGI3Rm9OT244cG1QamQ1OVZVcWlBNVNEaDNxRWk3U0trNVJsclltYysy?=
 =?utf-8?B?ZFlpYldTQ2dLTlZvV0c4RkgwSFBtY09qaExvZmZ5M0Evd0FURzhtUXVVNWFU?=
 =?utf-8?B?cjlmaSt2OVVOQ3ZVUzZxc2xnU3lweE5aQnZXbUVZVGtRaVlYeTBvSml3eFUy?=
 =?utf-8?B?Q2ZPVUd0bXRwWnVUUXNuK2p3NUc3bG5kYkI2TE02b3Y2OW9YWktWaEx6cjRv?=
 =?utf-8?B?N2JVSHUrdGVobWp4OVBiN01MRjJIZzdTKzZJWnVTc3psWlYxT3I0Qm83RlNY?=
 =?utf-8?B?NGZFMmNNY2N0dXd1SkRCWHVTTWZKYmJTUW85dGo5UStMdTk0WkxTY2EwTlF2?=
 =?utf-8?B?L3EvUitubktWdXpZUmpHZjNIWkZxU1RjWnRoUm9oZU5TZSsvV0pGbVJuTFJD?=
 =?utf-8?B?R2w4RitxNkNDRWtWWEdLc3RpbFFtOC9iZGVzNVJBbkVFbVQ2U2xZQUpDVWlv?=
 =?utf-8?B?NlpuTGN4ZFRKNHY2cXlKZXlXYU9ZeDZHb0ZpTi8raVZESVNzV0l6bjlOckVo?=
 =?utf-8?B?REJRbWcydHM0NkhvU2IyTUh0SjQzdTMwcVBKNVgzWGFRZkl0WTA0SThidFdW?=
 =?utf-8?B?UE5SWEFUU0RONXFsQmFSODBiNDh3ZDNwcU5yL3d1OGdmdTlmMkJQKzZtWEpY?=
 =?utf-8?B?V1ZoRytSMlRuWTBiK2cxMTV0MHgrZmZVU1hlK0xkc1J1Q1E4R3l0SDRidEN3?=
 =?utf-8?B?VCtZRXMrWlVYdWlDNGppTHJGekhLMllNTTlib1V6eE9ZUkdveXA1VHlVN29p?=
 =?utf-8?Q?cYPkoRxmCEeyeF1mXVzFOPvaG5f/hnad?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3B0ZlJ6QThVaFdkZFdadHdpUS8zOVpIU1lJUjkzcHMyMmNqS1BDMkxDSGJh?=
 =?utf-8?B?NWo4bVJkcnQwdUl6TFUxajBCTGpCeXV6UnNWeUVkWmxlNlpHMGNtR1k0Q1Fj?=
 =?utf-8?B?cHZhK01CdEVyblJZNHhkV3laTW5GR001aXUyQURkM1ZuZ1JsaHpKSFNJS29V?=
 =?utf-8?B?Y0VzWDBxdGd1VXdOVXMyRDZzUHlIckNOaW5kak44NFo1YXN3bDIxaGN0VFkr?=
 =?utf-8?B?Z2F3TGNKak95dkxaSzQxSVJtc0l6QVV1OWxvQjRwVDBKRHBxS0ZLU0QzVkdr?=
 =?utf-8?B?UDU3NzFySHdCZ0RySk0wTnhGam9PNmhOZDlkQm5mN0x3U1l5TTFnZjdVWVk0?=
 =?utf-8?B?eHJLNDUzcndOcDl2emRHRlp3ckREM3Fxb0ZaRzZLTWdpTWRMcHRnQ2VzcDlV?=
 =?utf-8?B?QnEvQWJlVUFXUnNMdmZsYkxjOGlYT0xtcm4zMzNrZTFJMktvT1Q1L2JuVm9t?=
 =?utf-8?B?WGE2ajJMZTh2UmllYm5iWEhiWlBnSkdra3hZekFQSFc2SUhpZW52M0QzNEkw?=
 =?utf-8?B?dkpuSG1rR2VsOG9yNjc5aDVabDJYdk03ZkRKYWJiWmlxMmlUY29jOEwxZ3d1?=
 =?utf-8?B?L3BQa0k1NWRsV1lHWkJhZkI0b2tMS3J2R2x3T0ZWN1RVZW5lTnV3UVRpd0xw?=
 =?utf-8?B?RVpYK3RHN0FUeEFWZkh3WFBSaXNRcGVJT3NvSTZJKzRocGVNWUtRZUFvYnpt?=
 =?utf-8?B?a3RKRHFXL0xyK3lqTlFNbCs2SVo0K1B3SlFmN2xySitKQmt0M1NlU2xUZ25o?=
 =?utf-8?B?UTBQT29pZTg0K0RKMCsrYi9wUzZENTFYaGd4VXhPc3orK2RzWFJmTXJoMWl5?=
 =?utf-8?B?Rm1LbjFhMG9aM2lRYlo5akswZlp6V2lWSDVhaU9NZnlUR2JOZnd4NGlIV3or?=
 =?utf-8?B?YWZoeVEybmVCdjhhSEFDYWw5aXJOTUJTblhzdWxsVDN1cG00cHBpMC9CSXdr?=
 =?utf-8?B?cHdHZHI2Y0FSTEpMNkp5djFxYnJjQzRCbis3eURFWWkvWUZBSVJFTlFiSnUx?=
 =?utf-8?B?aGgyOGZiMDduZDNNVXhlTm12dnZYTzhJcFllcFEvZm50NlUyWit1Uk81M3NJ?=
 =?utf-8?B?MWM5S2VpNHozaGx6bVVIU0hBVWwrWTdiOW9OWElQU3p0SGROOVFtNW5KUStl?=
 =?utf-8?B?YmJWMldvMlUvVXV0REFacmMvdnlOYytKN0NIZlJJYzhGbERuQ05SUWRNa3Bn?=
 =?utf-8?B?bW14eVdNaG1yYzR6Nm9IbDlaczNRVGhsZlo3SzNhMGVlK0ZYZEpjL1hCTFBX?=
 =?utf-8?B?Q0J0NFVDVndsazhQTDBJNkh1ejJORU9zdmFlUWhVM0JHTlYvSXkxY0I0U0hi?=
 =?utf-8?B?VFlDcGpuUTQyMTcvOHVWYzBpNmpIWVpNUmIvRmU4VWlOSDRlK3l3UFRVblhM?=
 =?utf-8?B?RE1DV3QxUGd2S3RYeU1nWHpNa1RyRkl6T1pNQjlyV2JXeEdrM0M2NEt5aHRq?=
 =?utf-8?B?VDlQR20wTytrSjRiWGhWMzZUZTdaQ25jeGJTK0laQU5KdUc3RzBwZnZMMU1j?=
 =?utf-8?B?TTFFQlhmeGgzWi9FTTJXVjdpVklncmZEYjduZlR3QnMyNzFtMlRrcFF5L3cv?=
 =?utf-8?B?OC9OYWhOMmxiYmRnS01qUVJ0azRsbXZYamgreXRRK1ZQZUFLUGJQNnNVRElp?=
 =?utf-8?B?OW1yNEQ1Vnp6UWJTWnRxeEp6NDdyZmZVcUpjb091Zkp5SU9PUCtFZFJtT1dI?=
 =?utf-8?B?UXRSTW8wMTdrYnJKM1psYVU2aktiRjJtU0t4WTFQOWJCSnc1RTB2MGdGY1Fw?=
 =?utf-8?B?MXFwQ2RRbHBGQkNrRXBDbUtzbDBIVWNCdmJmbnN1d3RTMk9vRzJmaEl1S25C?=
 =?utf-8?B?blB1bkN1eEwzanRJUWdVa3JDRGNvTWl0MGJmbHFrRUszZlhTbE4zRGhPWXdL?=
 =?utf-8?B?NGN3cTBBeXEwS2U0Q2FVTFlVQkNhdHRmdTRTSThlSGZjK3VoRTF2WnVuWVIx?=
 =?utf-8?B?MFYwSWR0ZnlaWUdvWFRIVnh2SFdSZG9YT243QmJRT2Y5QndXRHM2aGViK3NU?=
 =?utf-8?B?YXZVWmNlZkdHMnlWMEw0U0J1dlBOelVlSHI0bWJ4NE00Smt3emJSaEE1NTFq?=
 =?utf-8?B?TFZXQnNNb0ZQc3NObmlINHBMQ1U0djV3eVUwcnNEYU5BTzk3eUk0NE5BblRZ?=
 =?utf-8?B?elYyTzAreERISzhhall3N05UZjUyb3F0YklIWG5mWEl4SEFlZjZGOW1xSlJj?=
 =?utf-8?B?UFhFQ0g2bWlBN1JpUDByRU8wQUZSSjJmU3VuQ3Q1cGVLQTAwTkZOdTVxb3Vk?=
 =?utf-8?Q?B8GNUUoHNapvvUVG5h+vkDHD1DNpfuSUnnonimQ5ik=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c125751-9b7b-4d00-c3ba-08ddff7b39eb
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 17:11:27.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik15vKHpABMDQeO0fWppTVHFJ7owUC7vubqCz0pSczoCLQ+Hta9JwA8McLsXJAg1OL9dXw7EHGHkkvy1w35NaEptpgRKxN96cCREyW1x3MIXMIfoQye+7EOsSvhBPQs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6874

I posted a patch that addresses a few of these issues.  Here is a top 
level description of the isse


The correct way to use the mailbox API would be to allocate a buffer for 
the message,write the message to that buffer, and pass it in to 
mbox_send_message.  The abstraction is designed to then provide 
sequential access to the shared resource in order to send the messages 
in order.  The existing PCC Mailbox implementation violated this 
abstraction.  It requires each individual driver re-implement all of the 
sequential ordering to access the shared buffer.

Why? Because they are all type 2 drivers, and the shared buffer is 
64bits in length:  32bits for signature, 16 bits for command, 16 bits 
for status.  It would be execessive to kmalloc a buffer of this size.

This shows the shortcoming of the mailbox API.  The mailbox API assumes 
that there is a large enough buffer passed in to only provide a void * 
pointer to the message.  Since the value is small enough to fit into a 
single register, it the mailbox abstraction could provide an 
implementation that stored a union of a void * and word.  With that 
change, all of the type 2 implementations could have their logic 
streamlined and moved into the PCC mailbox.

However, I am providing an implementation for a type3/type4 based 
driver, and I do need the whole managmenet of the message buffer. IN 
addition, I know of at least one other subsystem (MPAM) that will 
benefit from a type3 implementation.

On 9/26/25 11:33, Sudeep Holla wrote:
> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
>
> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> attempted to introduce generic helpers for managing the PCC shared memory,
> but it largely duplicates functionality already provided by the mailbox
> core and leaves gaps:
>
> 1. TX preparation: The mailbox framework already supports this via
>    ->tx_prepare callback for mailbox clients. The patch adds
>    pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>    but no drivers set manage_writes, so pcc_write_to_buffer() has no users.

tx prepare is insufficient, as it does not provide access to the type3 
flags.  IN addition, it forces the user to manage the buffer memory 
directly.  WHile this is a necessary workaround for type 2 non extended 
memory regions, it does not make sense for a managed resource like the 
mailbox.

You are correct that the manage_writes flag can be removed, but if (and 
only if) we limit the logic to type 3 or type 4 drivers.  I have made 
that change in a follow on patch:


> 2. RX handling: Data reception is already delivered through
>     mbox_chan_received_data() and client ->rx_callback. The patch adds an
>     optional pchan->chan.rx_alloc, which again has no users and duplicates
>     the existing path.

The change needs to go in before there are users. The patch series that 
introduced this change requires this or a comparable callback mechanism.

However, the reviewers have shown that there is a race condition if the 
callback is provided to the PCC  mailbox Channel, and thus I have 
provided a patch which moves this callback up to the Mailbox API.  This 
change, which is obviosuly not required when returning a single byte, is 
essential when dealing with larger buffers, such as those used by 
network drivers.

>
> 3. Completion handling: While adding last_tx_done is directionally useful,
>     the implementation only covers Type 3/4 and fails to handle the absence
>     of a command_complete register, so it is incomplete for other types.

Applying it to type 2 and earlier would require a huge life of rewriting 
code that is both  multi architecture (CPPC)  and on esoteric hardware 
(XGene) and thus very hard to test.  While those drivers should make 
better use of  the mailbox mechanism, stopping the type 3 drivers from 
using this approach  stops an effort to provide a common implementation 
base. That should happen in future patches, as part of reqorking the 
type 2 drivers.  Command Complete is part of the PCC specification for 
type 3 drivers.


>
> Given the duplication and incomplete coverage, revert this change. Any new
> requirements should be addressed in focused follow-ups rather than bundling
> multiple behavioral changes together.

I am willing to break up the previous work into multiple steps, provided 
the above arguments you provided are not going to prevent them from 
getting merged.  Type 3/4 drivers can and should make use of the Mailbox 
abstraction. Doing so can lay the ground work for making the type 2 
drivers share a common implementation of the shared buffer management.



>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 102 ++----------------------------------------
>   include/acpi/pcc.h    |  29 ------------
>   2 files changed, 4 insertions(+), 127 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 0a00719b2482..f6714c233f5a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,22 +306,6 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>   		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
> -static void *write_response(struct pcc_chan_info *pchan)
> -{
> -	struct pcc_header pcc_header;
> -	void *buffer;
> -	int data_len;
> -
> -	memcpy_fromio(&pcc_header, pchan->chan.shmem,
> -		      sizeof(pcc_header));
> -	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
> -
> -	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
> -	if (buffer != NULL)
> -		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
> -	return buffer;
> -}
> -
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -333,8 +317,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   {
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan = p;
> -	struct pcc_header *pcc_header = chan->active_req;
> -	void *handle = NULL;
>   
>   	pchan = chan->con_priv;
>   
> @@ -358,17 +340,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 * required to avoid any possible race in updatation of this flag.
>   	 */
>   	pchan->chan_in_use = false;
> -
> -	if (pchan->chan.rx_alloc)
> -		handle = write_response(pchan);
> -
> -	if (chan->active_req) {
> -		pcc_header = chan->active_req;
> -		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> -			mbox_chan_txdone(chan, 0);
> -	}
> -
> -	mbox_chan_received_data(chan, handle);
> +	mbox_chan_received_data(chan, NULL);
>   
>   	pcc_chan_acknowledge(pchan);
>   
> @@ -412,24 +384,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	pcc_mchan = &pchan->chan;
>   	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>   					   pcc_mchan->shmem_size);
> -	if (!pcc_mchan->shmem)
> -		goto err;
> -
> -	pcc_mchan->manage_writes = false;
> -
> -	/* This indicates that the channel is ready to accept messages.
> -	 * This needs to happen after the channel has registered
> -	 * its callback. There is no access point to do that in
> -	 * the mailbox API. That implies that the mailbox client must
> -	 * have set the allocate callback function prior to
> -	 * sending any messages.
> -	 */
> -	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> -
> -	return pcc_mchan;
> +	if (pcc_mchan->shmem)
> +		return pcc_mchan;
>   
> -err:
>   	mbox_free_channel(chan);
>   	return ERR_PTR(-ENXIO);
>   }
> @@ -460,38 +417,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> -static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
> -{
> -	struct pcc_chan_info *pchan = chan->con_priv;
> -	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
> -	struct pcc_header *pcc_header = data;
> -
> -	if (!pchan->chan.manage_writes)
> -		return 0;
> -
> -	/* The PCC header length includes the command field
> -	 * but not the other values from the header.
> -	 */
> -	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
> -	u64 val;
> -
> -	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> -	if (!val) {
> -		pr_info("%s pchan->cmd_complete not set", __func__);
> -		return -1;
> -	}
> -	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
> -	return 0;
> -}
> -
> -
>   /**
> - * pcc_send_data - Called from Mailbox Controller code. If
> - *		pchan->chan.rx_alloc is set, then the command complete
> - *		flag is checked and the data is written to the shared
> - *		buffer io memory.
> - *
> - *		If pchan->chan.rx_alloc is not set, then it is used
> + * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
>    *		specific read/write is done in the client driver in
>    *		order to maintain atomicity over PCC channel once
> @@ -507,37 +434,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	int ret;
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> -	ret = pcc_write_to_buffer(chan, data);
> -	if (ret)
> -		return ret;
> -
>   	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>   	if (ret)
>   		return ret;
>   
>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> -
>   	if (!ret && pchan->plat_irq > 0)
>   		pchan->chan_in_use = true;
>   
>   	return ret;
>   }
>   
> -
> -static bool pcc_last_tx_done(struct mbox_chan *chan)
> -{
> -	struct pcc_chan_info *pchan = chan->con_priv;
> -	u64 val;
> -
> -	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> -	if (!val)
> -		return false;
> -	else
> -		return true;
> -}
> -
> -
> -
>   /**
>    * pcc_startup - Called from Mailbox Controller code. Used here
>    *		to request the interrupt.
> @@ -583,7 +490,6 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> -	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 9af3b502f839..840bfc95bae3 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -17,35 +17,6 @@ struct pcc_mbox_chan {
>   	u32 latency;
>   	u32 max_access_rate;
>   	u16 min_turnaround_time;
> -
> -	/* Set to true to indicate that the mailbox should manage
> -	 * writing the dat to the shared buffer. This differs from
> -	 * the case where the drivesr are writing to the buffer and
> -	 * using send_data only to  ring the doorbell.  If this flag
> -	 * is set, then the void * data parameter of send_data must
> -	 * point to a kernel-memory buffer formatted in accordance with
> -	 * the PCC specification.
> -	 *
> -	 * The active buffer management will include reading the
> -	 * notify_on_completion flag, and will then
> -	 * call mbox_chan_txdone when the acknowledgment interrupt is
> -	 * received.
> -	 */
> -	bool manage_writes;
> -
> -	/* Optional callback that allows the driver
> -	 * to allocate the memory used for receiving
> -	 * messages.  The return value is the location
> -	 * inside the buffer where the mailbox should write the data.
> -	 */
> -	void *(*rx_alloc)(struct mbox_client *cl,  int size);
> -};
> -
> -struct pcc_header {
> -	u32 signature;
> -	u32 flags;
> -	u32 length;
> -	u32 command;
>   };
>   
>   /* Generic Communications Channel Shared Memory Region */

