Return-Path: <netdev+bounces-118448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834A9519F9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C9E1C20DD7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B81B0118;
	Wed, 14 Aug 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="XlM6xtDG"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4B1AED2E;
	Wed, 14 Aug 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635209; cv=fail; b=vDGDKiRntancn3RFgyqfLXbzTZSzZ+kR4nKonJdEEvGUdtB2Je4BfdbGrMpsGbgm5nbqZOvn1qYUOFHQtWMkZ8d9T4bvmVMTrd4dVI1KZB08S6PehvR/A5rn070hoqtUWsQSNJa6drX43SZukw0JBkGD14IzNM05KutrlJHnnRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635209; c=relaxed/simple;
	bh=TD6Hzo/z2hlM8WkqvL8zAn0Dtcf1rV49ZfR5TvL7qls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exebAfiqycriPRFjmVBLHxStA2UQWodBP5gwyoSniev0DvFNGhyX3BNNtk9DQwJoq8BFODB3fIqJNyQxrodKeQ1dz11Fdv3wFRNV9bmogNfqNoKn8G83D4I/TdE+n2BG9JZpc0ntEItdFFUOk8tcnq7j5k4y2zdkYhMDtuA2eYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=XlM6xtDG; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ees3mGnb6YOPBkh9D2RHrqiPQ5lnOwXwt0+419SWAFoNFXc+BWeYstN3vX8FVS0xSCUKpneEJDQNuqD8RcFhS4luoEYU82Y60RGNuds3LJQhWb42ws+QhN9zsS+ItNBA6LYEhdOX1IZfR7RD/IefZul0h/FA5v8PXAazeuXMC8IjlQP8HEZV5nyki5JXDV0/EXr0kCtJcTjjoIWLMqOw92eqso8tg40FMcPI30vqeCX618wrf8RAnW7yofhxux7/Ugfbrw5bvXx4cNECK9F+KghWhSfT+5mykFon6Ny91/rCb81LgwkZDTzx21dLjoxm12lZIurS9jXSkhzGD83Syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjiz5htpcwecTe5Bs9F95gGtBf280uCfmkq2FYAMtFU=;
 b=G3Z9VyI+z97aZhYj+gOEayTmgl8n3no4XJzMMIJ0B7AzOZ8EC1FZPYzM6yxBVXhCLGt1YTVMMsyrhHlq9T5ejScuZLQfpNgiVK3APnT72hs82sN9AzMEnaOZo5+2HIVcWGzNHxcn4oyrHyIZL81axZWVSwwX7fKNDfU3TrWZtF7BEDX4EggJhRe2GGtPHEDFx89iIHKSKQlUKQlnJpluRCBJsJOyCMAT+dCNvfScIorcQFgM8HWeZhau9uEboprf6stnB3F8s7k8nXPuiEXKnxQxrJYc3sx1jJ5HkGP3bpqYvDOQb2KjeRrz9LS2Ev3uvclidtCoCjx5U0MQIhjGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjiz5htpcwecTe5Bs9F95gGtBf280uCfmkq2FYAMtFU=;
 b=XlM6xtDGFxHMOKAD1X0p/UAOD18SXwQBWE+OPTTeqxvAM5I6zSKljDyeRF45hbs+kyF0l18K+A0TrE8GviaeH5iQwV//74srSHdaF9EnO3I2DxLgXnfUf3x9TGR0wEIlSGSRg2g/Btu/U3R/lYecCyHrXwibKZfjFY8AlQYCvXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYSPR02MB6447.apcprd02.prod.outlook.com (2603:1096:400:40f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:33:19 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 11:33:19 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: pabeni@redhat.com,
	Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	helgaas@kernel.org,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net-next v2] net: wwan: t7xx: PCIe reset rescan
Date: Wed, 14 Aug 2024 19:32:53 +0800
Message-Id: <20240814113253.5471-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809033701.4414-1-jinjian.song@fibocom.com>
References: <20240809033701.4414-1-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYSPR02MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: da3818fe-1949-4809-e7b2-08dcbc54e4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UC8wbFc0WTBYSHd4dUY2QlZvZlhRK2RZU0FXUTBaV0owQjYxSEtaRjV2T0kv?=
 =?utf-8?B?M1hXQTFQa3MzTHVYSFNLaGtuYnF3UU5JdXZnT0I2UkVyWkNxcDdCVkwxSGh1?=
 =?utf-8?B?bkVka05kR0tkY2xNMTRON254WFV2aTcrcUFNcm9qaEpaSDFBYVY0TWJIcVpC?=
 =?utf-8?B?SHl3UHBxdlNWdUtycm9CM3NyVFFtdGlZOGpKQ1BOTEU2Z3Azdnc5d1dJV2Nu?=
 =?utf-8?B?cVdUcjdIZFkwOXZPMVVCM05HZE9waFN6NWhNcU1LUkdEUStjM2laQWhUbU9q?=
 =?utf-8?B?ZnBPUytyNW1wWEV1RkZRaDNRZm5HZE5wdjlhMGJ4VW9JQW14a2xNU0NIRG1i?=
 =?utf-8?B?aDhiSy9Pb2R5emhnVE5JQ2tCTEVrUzFkNHYvcW9BbDJYSzBJelhtalZJZ0Z6?=
 =?utf-8?B?ZGFxanZQVytpWmFFVmhLaHh5UHZaa25YaTZ0UWFQNTliQ1Q2TFQ3RmJuRE5l?=
 =?utf-8?B?cno4NGlvZlFnZDgwSWZlSTY5b1EvSVZvMHk3bWVQZ2ZOdEhxYk1CbGpqVCtK?=
 =?utf-8?B?cWVuM3JBb24xSk1VSUVsL1doQ3BXaXlQS1h0RUlydWhZM0ZveGVOU0dJRTk2?=
 =?utf-8?B?ZVB2VCtDZWx2dkY2MVJQdW1VSWwxRTZyeXNoSDBvaGh3S2dxaXVObm9qRDdx?=
 =?utf-8?B?akpnZEFoMVFQeldZaW14Rm9PeDR6dE9lY1ZRU2pnbjk0WnNNazJYWktwRW1C?=
 =?utf-8?B?QTA3cm1iY0l0WFlUb05PV3JnaU84QVk2OFpOWmRWZjY3azBaTlc2enVYaGpP?=
 =?utf-8?B?bnhkRGNMd1lpSkJzVjdpL3pjbHJqcVliUms4Z3ZlUyt2Z205WndaaUVGY1Vq?=
 =?utf-8?B?dUxOajhISFBKTHZlaTBYN1BhVHhERDJsWUErQVgvOFhCcnFWRDFTM2g1bVBi?=
 =?utf-8?B?NEJCdlJFK2xrUlNGaHBIaWdOamo2QkR6WWIyYXF0a1JJbFVpRjJrVVB6N0xm?=
 =?utf-8?B?RHUwSFNlZ21QRDVhTndYV3lBcnJpNUhnRWljQjlSZnRsdFFkMm1TUFFUa1JF?=
 =?utf-8?B?UUZHMlM5Y2FOUVRPNWpjYUhmdWpqdjFySWNpVm1XUzJ4V3pqdU84MmM4a0hJ?=
 =?utf-8?B?Q1NmTXFBNytTaWlXZThDaGdIQU12QUtYN01ZL0NaVkFKSlgrRVYwcjhyVlVj?=
 =?utf-8?B?cWgvMG5jbXZ5QldtY1FCdDZyc3h4cGJldFBLTHJKMzd2VUhXMnU4M1U4TldG?=
 =?utf-8?B?ODRuYVBDVFE4UzBzQ2NtZDZvMUt1S21JUE9YVE5vQXhUaE91d0NjNjlJMXJD?=
 =?utf-8?B?Y1VRcllHNmlRRmQ3MjlyOFJMRmwwSG05MUVtL1hYMGI4V3JtbTRXQnlNVVlO?=
 =?utf-8?B?djI1azB4M1djQmVhelVCZXgrM05pakVoZW51aGJXL29QVWZuYUFZLzE3WlBp?=
 =?utf-8?B?SU5lN3R5OTcydW9mRHFYUGNvYld1OE1iSEg5SlAyOFdWeGJSeis0YW9pUWpn?=
 =?utf-8?B?ZjJSOFc2K2RMa09hUERCaHFLSmhpUVpHeWZnRVlNZm9hNDVDcjdLR0FxQi9X?=
 =?utf-8?B?MFhGYUZFUVcvK2htTEdhblo1bzRtb2tRdEl3Um9VczhoTjgxY3h1bm56T3pp?=
 =?utf-8?B?Vm9kVjRhOGhIT0U1ck1YT3FEbGd4QlhhbmFva1pka3BBT0h6YU5nRmE5VU1r?=
 =?utf-8?B?dG8yTG5VR2ZUZzUra1JsQkRGNnJzREVhSk9Dek9QbncrY0NsUzEwVFFYaXQ2?=
 =?utf-8?B?UWVoblcxd2xJazhIWWNnRnVFeEtJazJ2b1RlVVpzMzQ1RXFybW1wWm1NNVBr?=
 =?utf-8?B?cmRmQ1liMVFyRXlEOEtZc3dDQlhKSzJWTlViM2ZvNW02dHU2YWEvWGU2QTBM?=
 =?utf-8?B?VzVvY2lHNnQvYW9mbkMrcWRJSHUzNGhzdG80azhXK3UzeEpKdlJJS3ZzRlRY?=
 =?utf-8?Q?wVHJrQ5JSRvmn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmN2bzBjckx4eE9mdmpJT0tPNUhSU0pkYUNySGFENC9kUHR1ZTBYWXc0d2pB?=
 =?utf-8?B?L1J3TG0yNFFPeFhEdDllQVNqRnZidkVYUFdLUDVtcW9DZkJRdmIyY0hva04w?=
 =?utf-8?B?NE93bFZFaE9wNzY0cTRzSXlyRFZNZVNrZCt6M1FwR0RVS0JSeVVVcFZueFBD?=
 =?utf-8?B?cU05cERnRFZiOTJGb0s4Um5sZEZkNzYyTlNQakRkQ3JrVTBiWkt1cHhjSkkr?=
 =?utf-8?B?am1YQnFTT1lZRjIvSmhrMFdSRFp5bnB3QXN5UkE3cFh1RDFtN0QrUEs4SW9K?=
 =?utf-8?B?SGRWZDZxeHQ0c1NOVjZxMU0vWVdtOFRtOEY2V2kxRW5UQUZ3a0I4dHF1M1lC?=
 =?utf-8?B?U2o2Rk43V0JrYklpdXdQNkkrRHA0ZHBsVnQydVU5N1BOMHVTUVRZcFRXRmZH?=
 =?utf-8?B?eE03MHlwdTQyYlRuZVlCYmNFbk9MdmYwL1oxeFdXcHNZNEprYTdJZGh1K3ox?=
 =?utf-8?B?ajFWWDBlbXJ2UWFIVWhkb3dIblJwVE9lTi9IeW42aGR5d3VBMHVMa213Mm1K?=
 =?utf-8?B?WW1vNkVENU8valNyUDI2cVNTdVBuZHl6djJwVmhhQWRqcjdmRFVQL1pxeG5w?=
 =?utf-8?B?WFNCMXpDMC9GWjZWdEVLK0M3VW1zakFscE5TcUxoUGZIa3F0dmtGOEVDUlZM?=
 =?utf-8?B?LzZQcDBQZ1E0UGVFZUFQdFpRa0ZCdlBIVml0d21NOTRUSUMrTXlqYmh5UE1J?=
 =?utf-8?B?VlNqL3RrZFh2amoxVnRmM2VUbno1MHg3dzUyNFp2MU1mVTlUeFRXbFFCWFR1?=
 =?utf-8?B?K2RLbVdFMFpFNlhRSVdHUXlnTVo1MFN6bElibFV5T014empCYW9PRGV6QXBr?=
 =?utf-8?B?VXpCM0ZrV2U2b2hRMFNHdlZ5OEhxaFcxdXpzbkpQc1JuQ3ZTVHV6TnA3L01E?=
 =?utf-8?B?YXlITEJGZlhqSnZMVFZaajByOCt1WlE1QytUTDRYRUhxZ2VobUVMSXBsRTJH?=
 =?utf-8?B?a01CQ2x3WUkrRExwZ2NMZS9OY3hQaWNEc2xWbkNVZVJXR1RyaG1TR3RCbVpt?=
 =?utf-8?B?Z3gvOElDTUM5aWxTTXdYR3pZazQwMGZ4WURVd0VreFpINjRNNEcyakJWbjI1?=
 =?utf-8?B?VlU5SFl6d2tpZWFUMXlBV3E3M1NLT2FOMWdJYnM5QUFybGJZdFBpeVpmc2tM?=
 =?utf-8?B?a0NZR0oxN21YcURhMmZOMWRnZWFpeUFmYTVGd3dvQml0d2ZHU0NxMjN0QXNK?=
 =?utf-8?B?TldEL2dCTVBTalZzSlRCUFlTK1pacW1jMjY0VXJuendEZjYyc3F0TzNReUdG?=
 =?utf-8?B?Y3I2czlZanliOG9yNWNaMTNVRmNVeWFjSXEzeEduMW5sMGNqaGxqdWVMeWI5?=
 =?utf-8?B?V2RaMFJsSSsvRWNLSXNiN2dBelFyUlVNSDNYTTdWOXFkcC9pbXZPbTlRVTNa?=
 =?utf-8?B?MDBlbHpNY0t3RUpIdW9KK3VkeWNVQlozZlMwVEd0TTZBT3pIQjNJbk9UNjFz?=
 =?utf-8?B?aVFxUTlSc1NKNmZiREo1aXFmbmRhRGNVUzVHcGRISTIxWEFkWW1tTzVjNnBG?=
 =?utf-8?B?b0hKWjlleTBrZHdlclVkdkV4K0VnVWh0c1lmSlJlU3ZueHZKcS9zUVYrOXl0?=
 =?utf-8?B?U1ZMeEN5Vmw0d013WG5Ja0JoKzRWR0lrTXQ4R2xlQ0s4THVNWFAxeXRSL1Nh?=
 =?utf-8?B?cm9Qb0xWd1pESGp0cEp0MjVpNlpkelJSaDg4azhnWnBtaXBsWlJsSjJMQUYr?=
 =?utf-8?B?bjh1ankwdm92OG9GcklFSU40RlhzeWViWTV5R3NHUFhNaHE1MkhJRXlTd2R3?=
 =?utf-8?B?UmlTZEFqL2JvdXU3UUlCaXVZYWlFbGdtMG1uanp2eXdyYjJlZ00vVnhyOUtZ?=
 =?utf-8?B?bVlrUEx3QTZSMjB2Q2ZwVVk3anhEZ3ZsalZ1Zm1sM09xc0lVUXYxUTQ0aW9w?=
 =?utf-8?B?ZlBCOXdIQ1hYNW5UcVl3NVJLWUluRWZNREU1UEdBb0VnZDlxaDI1cU5CM1NG?=
 =?utf-8?B?TjZVUHFoSi9sYjBTUWlvWitOMWtiRHNKYkN0VFZ5aXNuYlVTdG5NS3hkakd4?=
 =?utf-8?B?Tm15UjhBWlRrZ0ZEWkdYa09NRFl1VkNpalVHTG5yNmJkMU5yZVJkT0k5cElR?=
 =?utf-8?B?VTViUHdDM3ZxMStYYVk5YXBQQmNoZ1QwcVArSFBrTC9Rb0VKNU84aTJ0OWpF?=
 =?utf-8?B?TjFxdVVERmtJbFJFM1NBVEJMR01WWlhrbmxNb2tBNG1Kb3ZMQ2d5TzVjQUhI?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3818fe-1949-4809-e7b2-08dcbc54e4f2
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:33:19.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2rIuak6fwDdFj05Ui1XloTmf0Wl64crPNpQIOAViHY5HvFlri6u5RG2o8tWrvFRbp5S4A1q3BHpcHtIRUoD9u7Q3RQ0uwGHglOrjBuTOwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB6447

From: Paolo Abeni <pabeni@redhat.com>

>On 8/9/24 05:37, Jinjian Song wrote:
>> WWAN device is programmed to boot in normal mode or fastboot mode,
>> when triggering a device reset through ACPI call or fastboot switch
>> command.Maintain state machine synchronization and reprobe logic
>	^^^      ^^^
>Minor nits: missing space and missing article above.

Please let me modify it.

>> after a device reset.
>> 
>> Suggestion from Bjorn:
>> Link: https://lore.kernel.org/all/20230127133034.GA1364550@bhelgaas/
>> 
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>> ---
>> V2:
>>   * initialize the variable 'ret' in t7xx_reset_device() function
>> ---
>>   drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 47 ++++++++++++++++---
>>   drivers/net/wwan/t7xx/t7xx_modem_ops.h     |  9 +++-
>>   drivers/net/wwan/t7xx/t7xx_pci.c           | 53 ++++++++++++++++++----
>>   drivers/net/wwan/t7xx/t7xx_pci.h           |  3 ++
>>   drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  1 -
>>   drivers/net/wwan/t7xx/t7xx_port_trace.c    |  1 +
>>   drivers/net/wwan/t7xx/t7xx_state_monitor.c | 34 +++++---------
>>   7 files changed, 105 insertions(+), 43 deletions(-)
>> 
>> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> index 8d864d4ed77f..79f17100f70b 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> @@ -53,6 +53,7 @@
>>   
>>   #define RGU_RESET_DELAY_MS	10
>>   #define PORT_RESET_DELAY_MS	2000
>> +#define FASTBOOT_RESET_DELAY_MS	2000
>>   #define EX_HS_TIMEOUT_MS	5000
>>   #define EX_HS_POLL_DELAY_MS	10
>>   
>> @@ -167,19 +168,52 @@ static int t7xx_acpi_reset(struct t7xx_pci_dev *t7xx_dev, char *fn_name)
>>   	}
>>   
>>   	kfree(buffer.pointer);
>> +#else
>> +	struct device *dev = &t7xx_dev->pdev->dev;
>> +	int ret;
>>   
>> +	ret = pci_reset_function(t7xx_dev->pdev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to reset device, error:%d\n", ret);
>> +		return ret;
>> +	}
>>   #endif
>>   	return 0;
>>   }
>>   
>> -int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
>> +static void t7xx_host_event_notify(struct t7xx_pci_dev *t7xx_dev, unsigned int event_id)
>>   {
>> -	return t7xx_acpi_reset(t7xx_dev, "_RST");
>> +	u32 value;
>> +
>> +	value = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
>> +	value &= ~HOST_EVENT_MASK;
>> +	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
>> +	iowrite32(value, IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
>>   }
>>   
>> -int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
>> +int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
>>   {
>> -	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
>> +	int ret = 0;
>> +
>> +	pci_save_state(t7xx_dev->pdev);
>> +	t7xx_pci_reprobe_early(t7xx_dev);
>> +	t7xx_mode_update(t7xx_dev, T7XX_RESET);
>> +
>> +	if (type == FLDR) {
>> +		ret = t7xx_acpi_reset(t7xx_dev, "_RST");
>> +	} else if (type == PLDR) {
>> +		ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
>> +	} else if (type == FASTBOOT) {
>> +		t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
>> +		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
>> +		msleep(FASTBOOT_RESET_DELAY_MS);
>
>Did you test this with CONFIG_DEBUG_ATOMIC_SLEEP?
>
>AFAICS the above adds a 2s (FASTBOOT_RESET_DELAY_MS) unconditional sleep 
>for 'fastboot' inside am IRQ thread function via:
>
>t7xx_rgu_isr_thread() -> t7xx_reset_device_via_pmic() -> t7xx_reset_device()
>
>Well, the existing code already looks broken with a 10 ms sleep there, 
>still...

I have not test this with CONFIG_DEBUG_ATOMIC_SLEEP, The FATBOOT reset don't use
during IRQ thread, it only used by sysfs attribute interface, so I think we don't
have to worry about this.

Device IRQ -> t7xx_rgu_isr_thread()->t7xx_reset_device_via_pmic()-> only support FLDR and PLDR reset as before.
sysfs attribute 't7xx_mode' -> t7xx_reset_device(FASTBOOT), this way will use FASTBOOT reset.

>> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
>> index 10a8c1080b10..2398f41046ce 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>> @@ -67,6 +67,7 @@ static ssize_t t7xx_mode_store(struct device *dev,
>>   			       struct device_attribute *attr,
>>   			       const char *buf, size_t count)
>>   {
>> +	enum t7xx_mode mode;
>>   	struct t7xx_pci_dev *t7xx_dev;
>>   	struct pci_dev *pdev;
>>   	int index = 0;
>
>Minor nit: please respect the reverse xmas tree above.
>

Please let me modify it.

Thanks,

Best Regards,
Jinjian


