Return-Path: <netdev+bounces-222448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED193B5447B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A5F17F7BD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6832D3EDA;
	Fri, 12 Sep 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="1faGVedX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078A1FBC92
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664574; cv=fail; b=NYW+tQvFsrPvrUZwpYN2Qp9ZsnytC83QQrx4htI2vPexEH6FKOgCp0B/G9UTEqSHc1/e9dp7wQNhZxG8Exb6YHuXBt6jTN0euXzzru3ViHMPG4dTUb9kVsM0UyWIiv/Vez16P4ctDRI5CCf5yL+mnTSDpMordMWbjMYy3eWBcHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664574; c=relaxed/simple;
	bh=IAoMs7bRcGKf5nG2me1vEuPSAZFlOlM3u1m7V2Aa068=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1SfpN1lBnNgmQDYyjIBV5XV4SKwONoiX0pPvTE8n4T5potv+I3DYZ9VXtJAUoTVnS4UFfCDUBJ9rWk7MIizBGoTp2J+BYQrsk7aLjjKdhOYRenTyZOaH7YmSiFEsUK8pnpI3ni/G5+iN5ALqIln+T7NmqsjrRq2eSQ4LPVmfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=1faGVedX; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1757664572; x=1789200572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAoMs7bRcGKf5nG2me1vEuPSAZFlOlM3u1m7V2Aa068=;
  b=1faGVedXFz9IsBkn9Jr1aGqE3MUnGMuo6pkJlhkm1CLACcdAEAhUdSR7
   q9604EIs3uJLps6jltQvC3WZFE7RHWrtcALtVvPvLwdbAi65o4zzQRprx
   wh4wAclnFvk8Wp3YRKouxlU+qGcwYJKUv5TyckrmtsrSQTWnIGWZV2K4u
   g=;
X-CSE-ConnectionGUID: D4ywLM96SDCSLFC4orf7+A==
X-CSE-MsgGUID: aLZVUPeEQFK+HuYxzEWKzA==
X-Talos-CUID: 9a23:DwOcM2OChMjHA+5DdHV262oxS54eXlbm6Fn7f0iiBzkqYejA
X-Talos-MUID: 9a23:J42GBAhRRTgvrBvc1iEEK8MpPeNa3ZmWBW00v7ZFm9S1JT5dBBSPpWHi
Received: from mail-canadacentralazon11021099.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.107.192.99])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7CRelR7Y6CJAFmc17W24lrugJ8BGtY9DHA+xkXhgH6YOEICYQUytaA3nQM5Wg9FzRH9xcvY49AthOKdXXvb0G3W0jKg1VgcaIyxYALg6aXFliK8WM0LvI9vKact2gxUpbmK6OyKLXmzNJ1Iz3mAmKCv5e9oGE/SPoAU+MosL92mVx3yfqFpRZn8gzJdjY7/dZmopPbDMm0/tRAl1HuzhHyHf45Yms/vEYYqyINpqwh3DqfBqFufPiNDX9U6U55mxEYBVeGtakgRK2Pyu/AYUrBbbnjWp4AbPTQ8S/g/E/XbRl3RBcXxJ3eiP+T5PSqqx/MrwqxTaJUnIbQh9fX6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu/g9GQ5aPA1DCQ5CzuLEAYuWrQqyy3jTleJ5r4+tsc=;
 b=h/BYYB83gHyhOeYGNWDZIaW5RBCXZxpsQ69S+B0vu+IcDVwZQX9DcrK0ApjEEXZtVxapoS0ANjWjvk91qe0O5DQtsUQXeb1L69DpaB0NLeRahoQchDDBmPUsbOCVQozL5toJS8SKIJrl3OIA4xNzl5qZoEjN9dSm3Tt9p4scCwXi6XevTCIq0Qf8IRtCMnid7evmHWDiCFh0sjAL1Ui9ROAy8az4e1sZjsFOtMgoDA0sgg3kGmUSVk7m1rWbpDjUN4nZzG217W7uM+RBra+ZlLM/Og2Vl1GOcX6ijtlfh+Kbk5rrpYeptCQednfn/PTMC3FFcSEph61W2WzbyVcmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::22)
 by YT3PR01MB9009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:08:21 +0000
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ed0:c277:f1fa:a3f]) by YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ed0:c277:f1fa:a3f%7]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 08:08:21 +0000
Message-ID: <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
Date: Fri, 12 Sep 2025 04:08:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250911212901.1718508-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250911212901.1718508-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:70::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6565:EE_|YT3PR01MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: e1877139-7737-47c3-4f3e-08ddf1d389d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjFQWHcrd2hUa3RDZkdKNFpWMk9QdHBsTllJcWZ3THBINWVsb3hud2RSbDF5?=
 =?utf-8?B?QlNZQXhONm5PRGJlRUJoRW5CK21FclhjS0xVb2FGQ0o3WUJCMi9ZdlNRM2RI?=
 =?utf-8?B?R0Q4NjRPZmV2bGdBSHAya0VXb2NpcVpRQ0d2QkhEMmVaaThhU0luc2Q2OWVV?=
 =?utf-8?B?K3EyK01TYk9DcUZLU3dWRW8wNThFZDE5REgzc3YrMitiM200MUpLS3dHU3lH?=
 =?utf-8?B?Z2k0eUIrajc0dHlrS29aeHlmV0UycGVQaGVVQkNhM3NBdW93cDgxeW5lN2dZ?=
 =?utf-8?B?YnVmbnR6bExtVjFENDREQ1Zwb05XNzBJZnNldnBRUkxIRXBBUUlNTEhMQjlY?=
 =?utf-8?B?SjNPcWUxZ0RLYk1jYnA3bGZIMzRQQzRJWjlBWXJDeWxkY2UxWnJjcHNmWWdk?=
 =?utf-8?B?UGoraTJjNE5QZmVBZ0wrcDAvazkzdEVtSVF2N0kwNnJhZCtTUWZXNDY1Zmpx?=
 =?utf-8?B?T1RhVHFwa3ZYalNqLzNvWk9XZUlVTVdENGlaNXg3SzVQMXNlRlJJVEFjLzdk?=
 =?utf-8?B?ci9EamU4WnlhcGM5OWIzbXJVelRZdnZjTkRzYW5CenIvazUwcXV0YjhQNWRw?=
 =?utf-8?B?RWplOHZudWF1Z2JwZ2ZkWURCaEdaVWFsTTQyMS9IeGR3aFpZaERTM1FCRlBP?=
 =?utf-8?B?KzVoY1MvR0Y0RE1sbk5ERWw2TFprVzA3dGhLVzU1c1F3TUtvSExYZmlKc3Fw?=
 =?utf-8?B?cytTS0t3RTFaYksxV2R4R1Q0d0ExT1dqZ2JBL1REZ0F2VnQwNjV5MS8wQy8r?=
 =?utf-8?B?OFR6enM1eUZiN1llbWk2NzlYUXdFNTdaTlR6QmFJMXRqTThDV2xTeGE3V1d1?=
 =?utf-8?B?cFh1WDBWSlVOalJXZy83SmM4WFUxVGY2RVZHeUhWeC90STdlVWhjSDZyc3Qr?=
 =?utf-8?B?RVM2OHlCdWttV1dvUUpNT2RBdDdmTHpySFdLOHVyc2ozcTFkVjhtU3hEd1E3?=
 =?utf-8?B?dUhBNGltdytxVGlrYUNrbWpJWVc5ZFhXaWFxZUZ4OGM0ZVRucy9xMkdoWW1O?=
 =?utf-8?B?YkFFTmNscnZGNFpmeDVKQjUvZTlGVVZOeEZEaGcwSlZyaitReU01cTVMUDgy?=
 =?utf-8?B?R1prVnAvaWVPSXkxcUFNMkhWcFVCbG5ReElkSVI1b1BaRlZSM2hmZVV0bEVU?=
 =?utf-8?B?aHVYU0Ewc1cvY3VPZDFHWnZWQk1VdklXZ1pUQlRkcktrR3NyaTI3MXgxdmw0?=
 =?utf-8?B?My81MWNFNm52NVBBQTJTQiszYzU4YVhIQ2NscFZpNE10TzlqZy9velZXd1dq?=
 =?utf-8?B?aEFxRlRqZ3lSdTZBYytURjdYa2VnMmhFcmk3dHloY2F2V0w0VmsyaTNnWnV4?=
 =?utf-8?B?Ull3WkxPbnk2YzV3ZWo3UmdnT0tVTm1UVlBFTEh5U1hhN3VYZDcydzhIV3VB?=
 =?utf-8?B?N2prVzlzNk1IN1NZaUFIQnJSRk9BUDJsZWRyc3k2RXVuQ3cxdTJTejdpN25V?=
 =?utf-8?B?Ry9nZklQU2lick5XWlNMT3RINEQ5L0Z2NEcvMGtsK1pTdGd2MFA0c2xmWkNN?=
 =?utf-8?B?aFZ3K0NndlhRRDJHckt3Ty9FclRoSnpQTjdpdGxHOFNuOGhZMDNKeFBIaVRz?=
 =?utf-8?B?RWhLYjEvMlJ0dUZJdnRjMzE3SjFUTUhVdFB0Q2JrT05tS0xMcmN4Q0EzY3g5?=
 =?utf-8?B?MloyMW41dnR6Q0tVV2kzN1puUUl5OHE3cUxlVjVnenFXRGlZem1sQkxyaFJl?=
 =?utf-8?B?QXdPZkVjM3lrOUpnRnlHMlQxVVlmT082RFp6L1h6THNQZGpMaFBBRXVHQU5Y?=
 =?utf-8?B?cWhTWU1teWlDbExDVHIybmo1cTU3TFVRZVN2QkxYWHkvWk82djY0aG5MNmtt?=
 =?utf-8?B?dEcvaElrNThlM1NUK0doNnRvdm04RVJ4WUJ2Rkl2dnlLa2N3dU5KTndOQ0hM?=
 =?utf-8?B?aW1QaXRncy9QREMzV0pNUGsvOU9wdGdDeVM4T2h3Qlc2cDRMNEpta2Zra3ZW?=
 =?utf-8?Q?ORFPa4lNBk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGpaQndjc2F6NTRyVWpEaElWdlBkYTVQL3dRcGptejJ0anYxZTB3WURZY3Vz?=
 =?utf-8?B?QW5Ib0lwVzYvVUVqOFhnckdWLzZhVXVhM3ZZajBxU2piSkw5Znd4MWx5NXhh?=
 =?utf-8?B?QXJqYlV1WldqUDJYVXNrZGh1cGkzdTVPRXhWT2FzdEROK0R1QnErVTl4czhk?=
 =?utf-8?B?UFBTZFFXdXMzM3JQS1JCN0tna2hCQmFRTU50L2hzMEcvQkxMWnp6SmVhREFJ?=
 =?utf-8?B?VWhORFEweUJsVDJKdTluTVpQUTNCS2pBbThyMTBBenZjcEhnZEk4a1VyNWlB?=
 =?utf-8?B?WEdndjB4aHpyOHNQOUN3K2psZ1cxNU9DTWpaOUw1T3hSRmtCSmVYMTBGMnIv?=
 =?utf-8?B?eEpaY2U1a0VabHYrSXVsdEZoNDFyWWVJaVZmcDFsa1R3ZTR1bTVuS1dPR1FZ?=
 =?utf-8?B?YWcwc1dKWFJ4dDdJSDRvTnJ1QXg4cEIwZm9kbXIyVlV0SHVzZTRvTWxhQytW?=
 =?utf-8?B?ZEI1QkZDWm9nMGpHNzNUcENHUFh4MExhUFlXOTJ1Ym5QRjhoZTRBbFpKSkI5?=
 =?utf-8?B?YmE5a2t3ejA2bUJtVHNxaGQxTXJBaUE1cDR1c3BHeVRSd1c1cjlFZVRwVEg3?=
 =?utf-8?B?ZWV1L0I1NWtDUVBySjFpUlUwNDZydmxIV1NVbkZEUlZmNjRVZFMxNjFuOEFL?=
 =?utf-8?B?Nlg4K2lGMFhPaUN6WHQwL05iaDZ1MmZRQS9VV2REQm1QMzErWGtydEVYVVdH?=
 =?utf-8?B?djJFWnNsQTlwYllqWDM5eGZSenZrRzJpaE9EVHc1N3ZLV0FUWFRqWEd0L2NB?=
 =?utf-8?B?a212R251Y0w4b2RzdTY4N2NwTTVCYnY2Y0M0RHZoVmMyWERQQ1hVS3JaKzl5?=
 =?utf-8?B?N3F6OWNpVG9rTnl3OTRtSDZlVFFiajc4RVlrV21IV3M5cGVNUzg2S1Z6VThY?=
 =?utf-8?B?bFNIbUhGbkF4S1N1cXQ2SDZIVTAzYmFHN054dldHcVhuT0V4Z3BLYWNYaklW?=
 =?utf-8?B?ZkhSaUhRUEpibEpHeGI0dFpvVjJwTW9ZK1ozT3lEYTdSdysxR3dCRjdWN0lp?=
 =?utf-8?B?TXZVQjltRVI3blJZOHk2Sm5qTEI1OTRnSUFQVTNIQzdlMWwyRDdocnBwNTFI?=
 =?utf-8?B?WmN5Wi82MlhPdTdCU0hyT3E2T21SS2RudGtpcndBMGZWYzFrQTBJczNVY1Jx?=
 =?utf-8?B?Y1FKbVozSnR1N2tmOUxTMHhHNU1DekpvUEVtclNrR21NRmpDRWQveUR4NUcx?=
 =?utf-8?B?cGJyWk5zOUZzWDBrK0swUnlqZVlvemxrNHhJeGtuWlhPTjd0L3dkYk1Eclor?=
 =?utf-8?B?N1RuL0ZzcUxjUHFHWkRSR3NJdzErNXIwU0FmRUpuVXkxSFliZHB0NndCaGMy?=
 =?utf-8?B?bkJWc2FwMnY5NGFURFZaZkgvM1hLNTdYV2d0b3hhNmNhUVlkejUxaUpiMGJG?=
 =?utf-8?B?T1R1UjJ4NWNqNUNwYlhMM29pL3VURzhsNnlCTTFsdytnZGR1Y2dSUHJrdWJu?=
 =?utf-8?B?WlVpT3M2aVFEeVJseU9XS2g2cnB6UzRvY2M5aUJjeXBSdlZNZjYyWkFNWXNX?=
 =?utf-8?B?aGgvRzBjS3NnR3BtdStNbDJSMWJQdDNjTTZBSkxIK1hFdjRqcGhkS2Q2QkZE?=
 =?utf-8?B?bERVek5GTGhUa1BiaUZhL1BBMEhVREV4MnZhRTRvajFiYWUrcDZyZ1dXbEVz?=
 =?utf-8?B?eG00bFpnN0ZOMXpxQlVpMFBXVlVJME5UNlEvbitVYVJqNnVwMnl1VkRjREdO?=
 =?utf-8?B?Rks2MnlBUTVsY0FyU3FDcG03N2JQVG5vVkFBQ3o2bTczUng4RlBWYUJaYlFT?=
 =?utf-8?B?U213ZUdwdUM0cWZLNjA4eFk3SmNmZTFkRjdHcUpGMjlZeDg2NUZXSlBuOHlR?=
 =?utf-8?B?Z1BWbUp2dWZVYUpNdmo1SzVoV0REa3hLOFU0aVU0dU1BanhGYU5kb3BnUFZF?=
 =?utf-8?B?eTRkSXlIWlhjaHlpWlRQSjhHUzhqVmhLTW8vYWc2OXVyM21zbFFlVFVrN09I?=
 =?utf-8?B?a0FoN0NWYy81MHU4T1lxeDVQSWJuZDJOMnlRUGJtRTFoTkUrVUFSZXplWHRr?=
 =?utf-8?B?SURaWGM0aENKMUZqdHZKU3g3aFN0SHpIWXFZemRudTlOdExsdGppSDJ1QjJT?=
 =?utf-8?B?NC9HN3V5WlhCT1dJSHJDWDBTUzhPT3kwYk4wSSt2RWY0K1F6TE5MNS81bkd1?=
 =?utf-8?B?KzYzWEoxWUJkVThxZEZmSTRvT0djZEtJdFQ3YTIxT292N1NvMUtTZ0V0eUho?=
 =?utf-8?B?NFJGR1pWdnY2c0o2bHNQZmpuSUFneXovL2U0N3dtcVRtMFlJSlEwQUZweDla?=
 =?utf-8?B?a3BITldqZTVBVVFGejVYR2x0UGRBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w140WL16GJNkV6UpPOPGvj+xF1SZH5vQIngKaH+LhJUR+43xzQbJrGTmuYzjqSac/kOUetbfKRmHikQdX7pdNopEp05S2lfg5+f8LOD3FHIG89mZ7bH4Fsp8RXRYgs0W33zA2KQliefN5ga3iGBD24iJJE+MmhTlPUDV2VehaNQ7MX5jFqTHHeZtFhy2tnBCtMrsBx8lrOfn8tlmSHmUJ+jXagWJrJymAjinX2KS0e1R9aBfn0SyU8ZafsQXXNvfNDKCu8UIAS0kyFRjx5MHDpuUM71b3ctGwwd1RtPTBx1y7BuGUYKtvUIN6KkfyEu4o7V+ORfo+/NMPeSqbizGFLiQj8jHq3jVPCPS3yogMu9WQMkbZpPuLlSLb1kwzXV/EwML4il6c/zNZvgJOj2YbMCRxLdlp/hKUsgrcOLpVVVywSC8UwmvKM5/ZRmsqEmQSONxN7Ec6M/UKdFgpVhsL7JIp5ATAc/NmRTV+EgRxaetPVUHsuAIem6+X1OCrFZExDIU1eUdsnjvlMiRRm+4BBE79MlDfffxYwP+AteJ1oqvpkk6OUI5mqWJFWpa5U7qcaTjhfzmKgSb+iBFC9VYRyOj1ccU91zwT5LkkTb82EpKdbQlBnhWoYgFfg/K5rwJ
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e1877139-7737-47c3-4f3e-08ddf1d389d1
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 08:08:21.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0ImExtnnj4b0AKOlqCY8X7IaI/NVIu3++jt81trf4O4gBP/e/GToJ0mswZQS1y2G8xQUiqFL39LLg3QhQD3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9009

On 2025-09-11 17:28, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Extend the netlink interface to allow enabling/disabling threaded
> busypolling at individual napi level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. This can
> be suitable for applications that want very low latency at the expense
> of cpu usage and efficiency.
> 
> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
> backing a socket, but the missing piece is a mechanism to busy poll a
> NAPI instance in a dedicated thread while ignoring available events or
> packets, regardless of the userspace API. Most existing mechanisms are
> designed to work in a pattern where you poll until new packets or events
> are received, after which userspace is expected to handle them.
> 
> As a result, one has to hack together a solution using a mechanism
> intended to receive packets or events, not to simply NAPI poll. NAPI
> threaded busy polling, on the other hand, provides this capability
> natively, independent of any userspace API. This makes it really easy to
> setup and manage.
> 
> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>    frequency of the packet being sent, we use open-loop sampling. That is
>    the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>    recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>    delay in usecs on the client side after a reply is received from the
>    server.
> 
> The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.
> 
> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>    packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll
> 
> System is configured using following script in all 4 cases,
> 
> ```
> echo 0 | sudo tee /sys/class/net/eth0/threaded
> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> 
> sudo ethtool -L eth0 rx 1 tx 1
> sudo ethtool -G eth0 rx 1024
> 
> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> 
>   # pin IRQs on CPU 2
> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> 				print arr[0]}' < /proc/interrupts)"
> for irq in "${IRQS}"; \
> 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> 
> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> 
> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> 
> if [[ -z "$1" ]]; then
>    echo 400 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> 
> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> 
> if [[ "$1" == "enable_threaded" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_poll
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>    NAPI_ID=$(ynl --family netdev --output-json --do queue-get \
>      --json '{"ifindex": '${IFINDEX}', "id": '0', "type": "rx"}' | jq '."napi-id"')
> 
>    ynl --family netdev --json '{"id": "'${NAPI_ID}'", "threaded": "busy-poll-enabled"}'
> 
>    NAPI_T=$(ynl --family netdev --output-json --do napi-get \
>      --json '{"id": "'$NAPI_ID'"}' | jq '."pid"')
> 
>    sudo chrt -f  -p 50 $NAPI_T
> 
>    # pin threaded poll thread to CPU 2
>    sudo taskset -pc 2 $NAPI_T
> fi
> 
> if [[ "$1" == "enable_interrupt" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> ```
> 
> To enable various configurations, script can be run as following,
> 
> - Interrupt Only
>    ```
>    <script> enable_interrupt
>    ```
> 
> - SO_BUSYPOLL (no arguments to script)
>    ```
>    <script>
>    ```
> 
> - NAPI threaded busypoll
>    ```
>    <script> enable_threaded
>    ```
> 
> If using idpf, the script needs to be run again after launching the
> workload just to make sure that the configurations are not reverted. As
> idpf reverts some configurations on software reset when AF_XDP program
> is attached.
> 
> Once configured, the workload is run with various configurations using
> following commands. Set period (1/frequency) and delay in usecs to
> produce results for packet frequency and application processing delay.
> 
>   ## Interrupt Only and SO_BUSYPOLL (inline)
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> ```
> 
>   ## SO_BUSYPOLL(done in separate core using recvfrom)
> 
> Argument -t spawns a seprate thread and continuously calls recvfrom.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -t
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> ```
> 
>   ## NAPI Threaded Busy Poll
> 
> Argument -n skips the recvfrom call as there is no recv kick needed.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -n
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> ```
> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>   ## Observations
> 
> - Here without application processing all the approaches give the same
>    latency within 1usecs range and NAPI threaded gives minimum latency.
> - With application processing the latency increases by 3-4usecs when
>    doing inline polling.
> - Using a dedicated core to drive napi polling keeps the latency same
>    even with application processing. This is observed both in userspace
>    and threaded napi (in kernel).
> - Using napi threaded polling in kernel gives lower latency by
>    1-2usecs as compared to userspace driven polling in separate core.
> - Even on a dedicated core, SO_BUSYPOLL adds around 1-2usecs of latency.
>    This is because it doesn't continuously busy poll until events are
>    ready. Instead, it returns after polling only once, requiring the
>    process to re-invoke the syscall for each poll, which requires a new
>    enter/leave kernel cycle and the setup/teardown of the busy poll for
>    every single poll attempt.
> - With application processing userspace will get the packet from recv
>    ring and spend some time doing application processing and then do napi
>    polling. While application processing is happening a dedicated core
>    doing napi polling can pull the packet of the NAPI RX queue and
>    populate the AF_XDP recv ring. This means that when the application
>    thread is done with application processing it has new packets ready to
>    recv and process in recv ring.
> - Napi threaded busy polling in the kernel with a dedicated core gives
>    the consistent P5-P99 latency.

We have been through this several times, but I want to repeat & 
summarize my concerns:

While the proposed mechanism has some (limited) merit in specific 
circumstances, it also has negative side effects in others. I believe 
the cover letter for such a new feature should provide a balanced 
description of pros and cons, along with a reproducible and sufficiently 
comprehensive evaluation. Otherwise I worry that developers & 
practitioners will look at this mechanism in the future and be tempted 
to use it in scenarios where it does not help, but only wastes 
resources. It does not seem hard to do this and also provide experiment 
setup, scripts, and benchmarks in a coherent repo that is easy to use, 
instead of the current piecewise presentation.

The xsk_rr tool represents a specific (niche) case that is likely 
relevant, but a comprehensive evaluation would also include mainstream 
communication patterns using an existing benchmarking tool. While 
resource usage is claimed to not be a concern in this particular use 
case, it might be quite relevant in other use cases and as such, should 
be documented.

Further to the above, the most convincing results presented here are 
cherry-picked and only use parameter combinations that represent an 
unrealistic scenario of near-100% load, instead of showing a range of 
parameter combinations. In fact, even the conceptually easiest case of 0 
delay / 0 period is omitted.

Best,
Martin


