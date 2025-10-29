Return-Path: <netdev+bounces-233839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E5C18FF2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1875D504595
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3631A045;
	Wed, 29 Oct 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qBR64tPO"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63821FF3B;
	Wed, 29 Oct 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725518; cv=fail; b=CxBPBkb+LW63dw+LJObJmAmYtmkMxH5pEUep4SsFLB9AxA35zClD5NO+3An5sAx0zLD99OWQKIESJRP3YoFdfWgmwIdV4BaF7DtcAObbuapglI9vBngvGjG+g7Mm0IUuafUcJYJbO75CTxNki/5ZxX+hGoWlGmFwq/ZFWvcOkak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725518; c=relaxed/simple;
	bh=5Cp48mbq+QDFqrgJriskKzxOVZojuROYUMJnEUTUTEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kvze61clGlhk/ai4FM5SP2IfXq5VpjGmLOfTDWy6HoQhCto3ETdsGl7yL1I0oWmEpeONJKXIwLuDZc6gkbAW+SKW+8VYz/3dhxE53ADSHGdf8nrty5tg9gW9DLQsk1/+IiEk76FtU8fWbKonMekgknQ5PUITJFoJp0jogjNcP4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qBR64tPO; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVyPk2a4XTvFsqEXyNeKpVAw0vodz/yRxIt0wB4E1CN6z3dh2GZGP9flbiAEYI4EdEKC5PMyl74Y9OT37m7qBgtjeW8t5qyl9BPkf82P9TtEQjSn+/OzflkiEJ88/SuYMxDxb0QL6XWQohacYQgD5Q5hUlwXw3rs4tcj0aaphzl8D7C3f23gUFnNjkZL0Gs/EWUgYr90f4LeBrzU6mU43kutWIfrTu+8NuWGjZQF7NgtqVsoL+bkY8sNTti+797/BFn6njv3Pt3/ocyVct2jFTdIG520RujWCdUCfvssP1DMPorGWrmSd7wImLCoaPAv324ZIbGEcRJN/BLme4Onqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0nNdsan3HfIMaLFLhxSQOiUMqti5s39VuswGMNfayY=;
 b=tZOwWiTfZznMugSQ0O6l9gkkiLgGSD3a0VPqO7LI2ku53Od6MLNH2kfDf6cC53q9OHIpDIO59ywjbZZyQK6TrFZHEcToq8fgFu9KG37hoFIyrsE73v3XL9bLML+dzcpilWsLXs1zYEqB/Lqq/H0//5JQrK86UVNqzr9nRqyzzFH1KeVUFZ0YWnqInJ/W/KUdALLeX/JswLuPdwSgyeelfo2e5joCfV1WJx5y2H/dnsI5J73rRF1f4KnIk3eCKSUsrNI/bdwPMoVE4pjQOh9uObz4NiBDtVMr/9b/wL73Wb7iBynjlD8ybmj35ZvkuVnsQO/TUTx4CD6q/QNzEGPAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0nNdsan3HfIMaLFLhxSQOiUMqti5s39VuswGMNfayY=;
 b=qBR64tPO2E2FUsWQ5u3qwc+tP8noks5Gx6sjtz7A9gN2oW/M64C7Xm1CQ6sc1vWh1qIfA1+vTY/fQJQYygD7+39n1tv6g7Sd0gkXua7A7gCgjdDTVCgL2NypOgLmTiDU26wmRCNVh4XwbQtulG/R1S/gKFbPAIg8swVxsusYfoMMJmUpkPQD1o9mFVXfgeY9hKyLpIMbi+gBNIiLjCpujHslCOw+Qf1R+0/5wk3u+yJqNco5MQQVPCZJTLpKsT6mlMZ14o0MO2F0fzI5oK2QOigDgOvlgwpeLi39I26mCNkdiYawqHvH5fK3WeYp9JqQFQ9wnrrK+fR6XcqajmA++w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by CO1PR03MB5809.namprd03.prod.outlook.com (2603:10b6:303:6e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:11:53 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:11:53 +0000
Message-ID: <d3d2f4cc-c0ad-47fa-a356-2e8aaa24e9bc@altera.com>
Date: Wed, 29 Oct 2025 13:41:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] net: stmmac: dwmac-socfpga: don't set has_gmac
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
 <92e953b8-4581-4647-8173-6c7fa05a7895@bootlin.com>
 <87tszo7a7y.fsf@pengutronix.de>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <87tszo7a7y.fsf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::10) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|CO1PR03MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: af024228-3d1b-43f7-073e-08de16c2d169
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0lCZlBIak9kVG4wZ2l1RkhaUDB1dk93aUpMby96NEhpQUNXa0RoTGh3emZ1?=
 =?utf-8?B?UThlQUVMSDZQZzZtd1VET2k0dXhYL2Erd2taWGNyUXZSVTBQdFNwZDdjSEZj?=
 =?utf-8?B?bHZwR2hNMDFEQkp2SzdaZDZIamxybjJsR1ZVZGs3REV2L1oyU1k3ZStkWG1T?=
 =?utf-8?B?djlqdG54MlZ4WndqMGg1YXQ1Mkg3aVIwd2VreWxUT1lvZnFuek40T3k2SG1i?=
 =?utf-8?B?Qk5LVzRGVDRST2JiVDg1L1BianhRRGNyY0tDeHZIc1VidWhhNEVUaVlLbG9i?=
 =?utf-8?B?OHV3RjdQNWxuYkZXdEFQS2hwRXArRi9ndEFiVUV4VWNkODNRZnhzT0lTcTND?=
 =?utf-8?B?bi9VcnAvNURuUnJ3WHYrU21BL1Y1SlZGZms0akhQcmFHS1g0RVJhRmpzL3hF?=
 =?utf-8?B?T2Z1L3lEMXB2SndYamtINGZjZll1TDRqeUVkM2FacktKTGtzUEU5RkJyRE5C?=
 =?utf-8?B?N253dlUreVl1d01qYkFuMmpteGl4akpPNlV0ZHRvaEgzSlpsdGl2S1lON0NB?=
 =?utf-8?B?VTVrMWE1Q2FNMnFPY1hOd3hnbjdSR2hocGVpTnh5UnNiM1d2YnJtSUVnVTFK?=
 =?utf-8?B?eldybzA5bEhOWEM5SkN5bjdhSi9xZTMrdzBXU1VlZEkrTnFKVXlmYlQxeWFJ?=
 =?utf-8?B?M24wVk1pT1hESzJ2WE43dC9LQnhOTHRoeEVGWnd3MHlRZ3V1TlpSTjdLcGVs?=
 =?utf-8?B?aEF3TlROeVBtVys5eURhSHdlanBUamtMZFU2WWxISDBWaE8wa1pMS1loVm5E?=
 =?utf-8?B?aitRQ0U4QWtLakp6QWp5VXJrZnkwMGgxSE9ZWUc2S0p1L1lSS29sRWV2ckdt?=
 =?utf-8?B?N2Z1YVJub09UV3gyRWU2TFA3eFBCNG9rZngwb2ZBcEpXcGoxUVhJeWNQVDFk?=
 =?utf-8?B?YkxVWkM3L2huT2tqTHZiNVpsd3kyUFNBbUQrTFVxVTJzYkd5MFNUSUtjNk04?=
 =?utf-8?B?WittNzk4RytuQ2tGR0c1bHFqVkFMWHJIWFFSUTNPQm4rYloreDA2YkdvbDFI?=
 =?utf-8?B?M2ZqTWxrbDdKd3pYendsNlVTQzF1SnF0SmlDL3ZUWHhncm5uZWZYQkw3TG9z?=
 =?utf-8?B?aS9ldjVobnhNcnFKYkxvY3RDZG9pNTZnc3lFek9XT1lJWDdiVU1rT3JUWC9M?=
 =?utf-8?B?cXNJWHlDS0NIQnVzY25xbDViS3lhVFRWbURLcjMzS1NROWFuV1c5K3RCOXhl?=
 =?utf-8?B?R1ptZWtoK3JBeXg2dm1MTVZEOS9uZldKVDJFTzRmWGErSnlFNjVGbjlMaXJB?=
 =?utf-8?B?eTZOMDdlOXpYVzVsMFZaV0E0NWRtWXR5cUh5bXZzSUZocW9sMUFsaVE4MTRk?=
 =?utf-8?B?cUdhcUMzUDVDQ3FhU1lITllUd0YvY0wvazJBV1RVUDRPdmZEKzlPQzFybXdz?=
 =?utf-8?B?dlZzM0Y0OEJlcmJPV1YrSlpsY09MUFlOVkRSWnNnQjdncVBlVktCdzY1ZEps?=
 =?utf-8?B?Q2wvSFJmK2RNSkc4eTVheHdaYi9VNG9jNk1BcFN0VUVqZmNOcHU0VHYyTHFs?=
 =?utf-8?B?V1ZYd0toVGxzb0tXOG96ckduQVNhbWl5VE1xWGhqRnZqSXZPTnVMZXhkMHdB?=
 =?utf-8?B?NnhvQ2l0WWtOa21ZQkY3eUFZZlVXUFhCYXQ5Ky8rWDh1L3VyTFF0UVNBZ2lL?=
 =?utf-8?B?bVVFUjJSaS9COUdxbGZJd3pVZ0xkNmMzTHZYb3hINDE1Q0RoS2Jud2RHVnV2?=
 =?utf-8?B?Q2MrbFNaSkg4cGp4ZVpJNFdpakoyRVlpYnhKSWJnc0J6UGoxNTc2dU5iTmdL?=
 =?utf-8?B?NUNBTk5jeW5vNU8vcUR4bFQzN3IzVkpVWHY5OU1vL2lyUjJoT2Vsck1aYUNo?=
 =?utf-8?B?dEZxakMzR29sMldkKy9iMWpRVjRDSWxDMjJzQThxQVlNdU1KamVmNDYyblk0?=
 =?utf-8?B?L3ZoTCtvL1hRcHNDaGNrcFNhY0tKZ3FkaG9CUTRVS3doVFR4VnRLTFZTNmJE?=
 =?utf-8?Q?kO8JkHAxtm0KAfWuSHEGM1HN1ZH3g7AD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZvOG01VE1KSXdDWDhzRjByYkxDTXRpb05idzdZeldnYlFoZHRqRUI1Y0ti?=
 =?utf-8?B?SUMrcW1lTjZBbkpHcDAzbnZIMzNyZ0huZWVWbmdLRVBEZDhsL2RySUJXSmp3?=
 =?utf-8?B?VFo0M0pUM0xpMmV4YytpMWFiTnNUWnR2cldBdVVtSWdHY1NlWlpRM0ZiaExN?=
 =?utf-8?B?YXdNckdldUdKazZ6Nm5pUDB4YjdMQUJTeEJiRXROS2ZiMG4wUS9ITkxJV1k0?=
 =?utf-8?B?eU9WWGpSbFk1L0c3cHcwV2J0NVduYzdJSUpHMEc0eEEram44bmZVT2RyYWhR?=
 =?utf-8?B?RWpGbi9uWjErUC81SnI2Q0xmK3N6a3htWWYvMkZ3S0tkdzZZNFJxSVdOR1RN?=
 =?utf-8?B?RzE5Y3pEV1VtM3g3T0pDQlZpVW5ZTFc5VUVhT0tJZnBFN2c2R3pvRzhSNTBp?=
 =?utf-8?B?S1l3Vkl2MGhFS1ZGNUx4SXpFVkRuaVlGZ1VmZmR0TytqaHNHZGFuU25oL1JO?=
 =?utf-8?B?Q2ZwMXZKMTVLZEhzWGhSc2VxSTFSbTRURG5SSi9lbHppM0tJSW5IL0YxSU5i?=
 =?utf-8?B?Qm1BaHFLQ0xtcU4zb1JOeHlVZUdra1psOXlLY2JmT1ZuM1NkcFNPRWhSSm9Y?=
 =?utf-8?B?bFY2bkNqL0dnN1kyWlRuY3Z2T3lvVmwvTHZ6azRmeDlqaW1tM1MvbU94ZmVG?=
 =?utf-8?B?TGxNMWI3RmZxZmg3TnlEblk5N1RGMW5wSlZXUmlMUVFSaEQ1ckUxSGJlZGtN?=
 =?utf-8?B?K1U5dUluRGlxZER0Tk1VSEZQOEx1a2Jtd1dkNlRLUnRaUUdkVkN5d2txbmp2?=
 =?utf-8?B?dnFBd2FvN1A4djZrRlk3YWV2enUwNjhsMDVaRmhDMEZoOERTVXJ6Sms3RGJn?=
 =?utf-8?B?akEvSWRnbXpCUmxMeXFJVTREYmxCY29kd0x6QWhaZVhiUXF3OTNKZk5YSUQv?=
 =?utf-8?B?b0ZhcUMzbHFDV1ZUNlhscE9DVzh4YmdLSnRXL1RpQmptZG1KZm5lQktmc2JR?=
 =?utf-8?B?WEp3VDhNSi95RENQS29WOWh4RmcyeThHS3hjOEhVU3R2ays1alVmbW41UUxK?=
 =?utf-8?B?cWpKYTJBd2NPUmRyVHE4MnAxL3B2MFNYMWJTUTJCRWlhb3ZRN2VqNHpUYjN2?=
 =?utf-8?B?dFpUTUg0K0xPa1NNZmZpMlJPelFqTExXRW5VNXFFd3huekx1bUkya0RFbC9M?=
 =?utf-8?B?RngvN1pldHcyM2R6OWhkRGo4cWcrSmI5SithbG1KWm1EaDlNbFNsdWVBRUZJ?=
 =?utf-8?B?Rmd1Q0hIakVJZGExYkdUaFFNNjdpTEd4Mm0reXFkdXNvWnUzbVovbWIxTGF6?=
 =?utf-8?B?Z05YU3JObzZJNDdYckxZNmRDTGVvUGMzbGJvcDhTbmJRK1BNUkg5UUhVYWYv?=
 =?utf-8?B?dUpTUlh5cU5nQXlaNWJqS01IeFFDR2FKNjU2cS9LM0JvWXpkREw4d2pvK2w4?=
 =?utf-8?B?ZnpwRjJsRytMSC9YWEVzT0Z1d0FSSUtrS2hpZElKSEg5SXhnNm5rMDhPRjRj?=
 =?utf-8?B?Q0RsWHNLSncrSHk0QytURElBWU9CN25aQmVRUWwvUURRZ0tVRlhOcklIMVFO?=
 =?utf-8?B?dGJodmw2azBncnVzMGswQzlRTEhSN2xIa1UrUFlYcVE5eUlkMUFwbHozUktW?=
 =?utf-8?B?d2R5aXNlTUMyZ1QvSUhkZldJWFJmVkcrZksxWHFyK09HalVGK21VL2JnZ1BO?=
 =?utf-8?B?eEJkWGJaNjFXd2tNQ01mSVVONGVtN1hzb25VWXEyVmJqWmlXTEtNS0FDUVph?=
 =?utf-8?B?S005bDZFMzFQMndMMHB6OCtmUCtJWFZxL3pQMHpMbTlLKzZWQTJiVjlnOHFp?=
 =?utf-8?B?US9aNnlZWTlTZ29HNmlRaVV0TjRBU2laZ0dhVEtMZzJ2MXpDNFVHNnhzRml5?=
 =?utf-8?B?V1k4UnRjemhEWFQ2OThMMzRWZmtTa3p4T1JEZk1YYmFWSUFET3E5MlVqZSs2?=
 =?utf-8?B?VW1tNS8xWko3Z29ETE5TL0FBVVVzSnhmZm9HbkpINjhwWXRwcmtVOGI4NEdX?=
 =?utf-8?B?eHQwTjJTckd6aWpZRnVDY1V1Y0NIeDlhMHBqWGFNRjFYSmpGc0J1OWRiaW9Z?=
 =?utf-8?B?TDBCNFVlckpoL2dlTFFlWGczNXZOWmtZQytGaFIyZGJYUS8vcm45Yjl2U1h6?=
 =?utf-8?B?VHhjQTI2bVlTTVJGRWtRMkgyWmE2VnZPKzdJVVFrdVNRNmRFL2pONE5VMW5S?=
 =?utf-8?B?ek13Z01GVStDbjk5V2ZrQ2JRYUJiSllBaU5Pd2ZmSTBiS0NHV3JLL1lKS3hU?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af024228-3d1b-43f7-073e-08de16c2d169
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:11:52.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvnwjUCoIi+O1lx8UgsPC99jZn0p9chb9Dy79zPhGVH82ljORUp377j/8Bq+/wGRm4YZFodeyJZSODxdbTgtDOwvaHgGZBdc0qtmfI9v/p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5809

Hi Steffen,

On 10/24/2025 6:00 PM, Steffen Trumtrar wrote:
> 
> Hi Maxime,
> 
> On 2025-10-24 at 14:11 +02, Maxime Chevallier 
> <maxime.chevallier@bootlin.com> wrote:
> 
>> Hi Steffen
>>
>> On 24/10/2025 13:49, Steffen Trumtrar wrote:
>> > Instead of setting the has_gmac or has_xgmac fields, let
>> > stmmac_probe_config_dt()) fill these fields according to the more
>> > generic compatibles.
>> > > Without setting the has_xgmac/has_gmac field correctly, even basic
>> > functions will fail, because the register offsets are different.
>> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> > ---
>> >  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 -
>> >  1 file changed, 1 deletion(-)
>> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c 
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> > index 354f01184e6cc..7ed125dcc73ea 100644
>> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> > @@ -497,7 +497,6 @@ static int socfpga_dwmac_probe(struct 
>> platform_device *pdev)
>> >      plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>> >      plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>> >      plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>> > -    plat_dat->has_gmac = true;

I was preparing a patch-set to enable additional features in Agilex5.
Since Agilex5 HPS EMAC has different configurations from the previous
platforms adding a separate platform setup callback for Agilex5 and
other platforms. Here is the link to this patch-set:
https://lore.kernel.org/all/20251029-agilex5_ext-v1-0-1931132d77d6@altera.com/

Could you please confirm if this patch set aligns with your commit?

>>
>> Note that this field is now gone as per :
>>
>>   26ab9830beab ("net: stmmac: replace has_xxxx with core_type")
>>
>> You'll need to rebase the series :)
>>
> 
> I see, bad timing, but luckily an easy patch :)
> 
> 
> Best regards,
> Steffen
> 
Best Regards,
Rohan


