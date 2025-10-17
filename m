Return-Path: <netdev+bounces-230356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FFBE6F41
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F392B501C8F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11822D4FF;
	Fri, 17 Oct 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mS1NWN7P"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5D1D5CD7;
	Fri, 17 Oct 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686611; cv=fail; b=hPUxtc+zbZXzw9ytaV1R6Py4u3m9rZRwXfTFUSUx01bj8vme5miikpWkOibhDg3LVWGUijSHId3ZVFisAW17cJBtX18xMo0ibpSD4ZO+oWmOEpf9EDCF/tj7a2TCf3SXB9CGXV480YL8GmqghB8cELfcTdNR3bhh6ONwsIdvHec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686611; c=relaxed/simple;
	bh=YW/dNz1PNO/glqpf/SrONZdouspXciTpH9KOaslHBUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZZthw6yXv4TUD6qBRYnewF53PgT5HCqzLjG4V/GmhxHWobQdokRTqkUv6UHtefIqSsqW0Abniztd8tcx3FotNMLTmIDNM+AMBdR5qhVqSiLfmL7sJrY23+xlZQosCCGJF4eDKIKMXO95e7gvF+X9/IgvrhdpwjPeIdwZ0vT8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mS1NWN7P; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpah4SykFYLxbRj9im/QtBm9SwN4p/hsnO5OW4khyxG8q+IjCTzvuogYklt1j29ms6DVCJ/+TX4tio6yLB6vGolE2wsDyTvyQm5OUx+tXKuerg/b71ITpyl0H+8kyRRNfNvah5PG3Pf/O5Vp6qbGN4Yt//v1vrbyI/UkkNskPYK9JUREp9kJAVyVlfHXwJ0z9Oih9khUW5X7J1VK6inD8+lemQHUibwEWIysjuPERNVgncrqtaPQQCoEHHA5Kh84EVy/MEquQQxxF3/iQuIXnDQPhY+Oe6zNioCJK9yYpOLLxu0UAKu5vLzTQjC7enLg0kcer3iia/LUXsXKqyH6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfszXGSXDJDeWa1YJcsin7SPJZGsK61dObI76BLJ8Uw=;
 b=nTUC1MVp/EJL7pFRQ48vJVC2gFhjkgNfwBhTDOjlm/S9E4kEebroDriYf4ijAqhH6QH0/RQjeR0+kAzbKCtIm4aOfrticcgG8CbngKpbZOAWbGKOAVyCs4M4vfQTJDc0txodY8IzDQEwo6cDz6xETnQgX1yeqP3AXAj6LSe9/XGtmqQUeHphzg/78QUseSs9PZnPJ1fI1ndRGjhSoQyKwryPNA3+HOfYMbCtSneaOkd+iTx53DKqGdKpXAbPO4tHBAQ4x9btNyJ35FYv/dUdc/Wmt17cLa3xViKTIETGB9BTcaR0XK+gnX7iEukfcX+ufLTzAi6EnbKo+DS+HdffpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfszXGSXDJDeWa1YJcsin7SPJZGsK61dObI76BLJ8Uw=;
 b=mS1NWN7PSxZr4QvHg7BcgScsYuKyIVbJuo3xr0O5nv7bNEpSZm4J5I84FDBj1NGEFsoiLTd3p7/sesK+54KncR0pDZ39CFyxZZ5PUem7bspxRiENIU8y8yGGuYD4Aq58gbxe7M5ujHxHt9kc0Sc8CsWz1ZxHWIIJrcRPGt0U8GDGWEhtUycmpSS7N4kRM4px1MfHM7iVKmWGoCXwyb8nfgCYznI46oe+CEJEz6NH9jC0D8YdozvzrioN/bnAjLKfYt5xMJ977bd78V9cVESgKB8/P1G9OHjIVySjGy6++IIXumIZW2nfgk9KcEY8rIGa157joxyhBoLof+T6cjst2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SA0PR03MB5643.namprd03.prod.outlook.com (2603:10b6:806:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 07:36:44 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 07:36:44 +0000
Message-ID: <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
Date: Fri, 17 Oct 2025 13:06:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To BY5PR03MB5364.namprd03.prod.outlook.com
 (2603:10b6:a03:22e::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SA0PR03MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fea5aa-66ac-4216-2b3b-08de0d4feb55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnU2a2Y0SFp6WTBWMHhiRW5WWlZFV2VMMUhaU3hITkdYZEhNUG82V2ZFektD?=
 =?utf-8?B?V0dtUHFGZFBYV0Z3eDlSYVpvbDRpSFdLTXFyTlhmUzhXTVM3NjIvUlJuWEZD?=
 =?utf-8?B?cHU1MjlwYXIvZVRMcXlwWEl0U09EWmxTZklvSW1qTkFUR1VnS0MxWGVtcElp?=
 =?utf-8?B?N25hQ0RQRHJxTmNRZm9adnZZM3BIT2l3NTVhYUVhaDVqSXo2VDd6RVNFeHBu?=
 =?utf-8?B?Um1hYnFCRldxSUZrb3lBQkFNTkZSRmltUFZtZVJ2RVJIekZPZDhnSlJPb2cz?=
 =?utf-8?B?SnRpbjNPOW9qVU9tZUhQYUh0YUcrdkVTaXYzME5wMFBGYWNrMElaaVJPRys5?=
 =?utf-8?B?Snd0eU9UVkdwSEp5QncxRm5DY1llQWRNUlZGZGI2emI2N3p2Y3NjaTdjZ3FC?=
 =?utf-8?B?R2ZmWDJhVmUxaVRYU1VJZ1FaOHlIdVNSb201SFVVb2h0OXdLejdtL0dzbVZx?=
 =?utf-8?B?dm9KSWp1amJLa05EaXlRS0Q2elJoUTdBRVpmY2tPWlYvK1JLazBqeC8walcx?=
 =?utf-8?B?QTJwdXMyd1EybVhORlBNdWlaUlpSdEdBcitTWDhXMjVjTVNPUHlvbmtzaDZN?=
 =?utf-8?B?b0NEb1hnS3hyOXNTblh1UllOOU9hYlA0Ni8ydlhOZTBlMEtwWFRGSWdSelF6?=
 =?utf-8?B?bTZUVVBkZXZhczZVdVhoem1QcCtWK1FhUmRFWG1xVEhUQnhtYVdjVXVRbkZD?=
 =?utf-8?B?aTBnTGNSQVlHYmgvVmJKb2FtRS9STFM0WEt2cWZoV2hxaWxMRWM4ZEVYcURP?=
 =?utf-8?B?blBWcldvRnFBa3BtUERGbStOaEVlODAwd1VJQTdIcjVJamRPamV1aVV6Q3VP?=
 =?utf-8?B?WGxTT1E5V0JoYkJmOXBjck1CL0pLUkZQcGhmQU0xUmhXaWhWUTNXV1NDQlJE?=
 =?utf-8?B?azY2VzZGRThmNHdVSFpSc1I2K2xzQzlCckJyMFgrNTl5QldwaGxRSHJZLzlF?=
 =?utf-8?B?RHNDL3d6Ri9GWUNXaW1uV2k4allLNTFteFFBc3daZ3pHTkkramZ3STNZR1cr?=
 =?utf-8?B?V1hGalhiZkdXVWpzM091bWQ1elFrdnBqQURuQlVNbSs1aENBTStXakRCQ2k1?=
 =?utf-8?B?dDVXV3lQUEF0dk9yYXRnSFVEeDJNcWx4RUsxTmhZS0lNcWo5cHZYVm1FL1lz?=
 =?utf-8?B?YWNFeFhUUklDRjZsOFdIV1I2aTFZRGFVV0NjTnZBcjlPR25yR1dleXM2eS9Z?=
 =?utf-8?B?cUg4c3NoOCtHa3hoNlNyWkl4WHZSZmNIMVlneXpyUEl3ajAzR21nMWVJMUlZ?=
 =?utf-8?B?b3dRZXJpcHZUTDRXUTljUldrRDBVc00zWmR5Mk5yckpvUklTcjdKZVlPN0lW?=
 =?utf-8?B?TXZaUWVoUWZYUERkeDYzenI3ZTJBOW1nK1NrN0JUUXl6MjJFZFJGOVB0SFFl?=
 =?utf-8?B?aHB3Z0R6d3FOR2gzRFZ1Vkt1elRrSW5xWTdHd2N4RDdmUnVLYXVpZzgvMjZp?=
 =?utf-8?B?b09kRXltaVVOYWJ6UEI5LzFLVjArVGVKNWFvQnljdVFtQU1odzZPNWQrSVNj?=
 =?utf-8?B?QW1OVmNFTUxCWk1yZWVZckRiZXFMN0UycGliVDE3aEpKVjNNNFdzemhkamVo?=
 =?utf-8?B?WThaNGE2anRNVXBndGpBNVp3dENrMmtiN2IwOHVBVEpLMlk0WExmWUsrUisy?=
 =?utf-8?B?cEkrUkZvMGNKcW5CVE95S2haSFhDTFJ1YjZOZll2WlFBSVRsM3kxdU95UDJ4?=
 =?utf-8?B?OThKMnROQ1JIbTljZkdoVXNpSnFSaWlFT2FCN3ArMmxwZWJqYis3OXBRRnVt?=
 =?utf-8?B?bnpQQnFtNVhGblRHRDFYSDNSSEVYRVl6cGsyMzY4QmFrQ3R5SW9YbDZLVXNC?=
 =?utf-8?B?RkI3RjRDUEx1dERsSC96eTRBVE40TmtkRWc0YndmTHdySXUrbUZjdmVaOUl2?=
 =?utf-8?B?THY1NkUzT1RuRFl4ZzVtTU5XMmdhR25TT1VxTWR3dyt2dysrWkx0ZGNTTGJN?=
 =?utf-8?B?c1h1TWEwMmE2VzAxUHNYdTNLVWhldFlvUHBYMjl0TnpqNlh2K2NncjlWVHZ3?=
 =?utf-8?Q?vKApc6SIw31yGqjvKUx0qGPvPev6iI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWdiUVdzZWlqcC9xVi9xRTEyVEVidkg5TFgvWmZsZFRUWDlLUXVvb0hsVC9z?=
 =?utf-8?B?VmZOR1ZabTZQZkt3UGJsWWQrSEREQTNGUWNacFQrL1FPcS9ueFYwV3VsV3lo?=
 =?utf-8?B?RWwyYnVOeEhTc09naUlLU2xWK3NsdlhmZU84ZGxGdHFQN3FYZXZaQjVvNTRx?=
 =?utf-8?B?UjRSSVdVSnhxazF5SHlpa0hzSGFmQTRMT1dSYzErTHhwV282QURZdUZPY0Fa?=
 =?utf-8?B?Zi9hVFVYaG1vRjhjTHBZc25LOVBmRmQraXlCK0MrbHNlUGRscHpVSFRoK3pr?=
 =?utf-8?B?Ulp5Q2hZQ1UyTDBlNlh0cHZtZnRPY2p3N0NrMDVQMlJMc2k4RExYdSthVm9N?=
 =?utf-8?B?YWplRFJBLzZGMXdwcVEvNGQ5alF0aVRxSzdSempyczRhRTBSeXZhZjRIWEhv?=
 =?utf-8?B?WDd3dktVamxTK1h4WnJIY2JZVjNhRE5lcVEvTjJ4TVY1UVMrRDVPSWVZTUdU?=
 =?utf-8?B?Umk1T2EvcktVL2dSSlRWeENrcVdDNjVmTEdKYWpwWlFoRXJGTmxJNklnK1Jh?=
 =?utf-8?B?dTU3YTVvN3RyZFZwS1VhNExPeXg1Vm0xSE1JcURLMTlRYzh3Q0xsRWw5anYv?=
 =?utf-8?B?cjRzUjhwS1dXVjlVNGtpb0ZCbkNlM0lvQjhudTM0SmY3ZkttZEhFKzQ3Nm8x?=
 =?utf-8?B?MHNYbFZ4azRydVc0OVZkK2xHZ2Jja3NlV0JOMHRDTGZQdnd6cGxqb2QrWSt0?=
 =?utf-8?B?T1BmUzRhdllveVU1UlY3R1F3eGhvVHA0NlJPS05aWnBKdlBaZjdodGZxYjlm?=
 =?utf-8?B?c2Y2S3hRVGtNK2dCQXBKNEVCRmphNUFJTm9kaXI5Yms1MDdHTXpXNmEyZlFF?=
 =?utf-8?B?WGFpd2k3MU1jcDd2RTgvNGQ0cFZsZEJqV25vS21NZzJJOUdFZUFtUjFrdVNX?=
 =?utf-8?B?MmRiOVF2c1pJdjZxMk1vZnU2cE43Z0pMZHBERzJhcEhzSVZqYU5KaSszOU1Q?=
 =?utf-8?B?U2dULzhnQjBya3JMZ3BHTVAvdTRuVjJqeEVPcDFDZUV2eUhVNjhrUDNRZU1G?=
 =?utf-8?B?R29pNVpISjRLWnZPaml0V1RJdEh2YWtxbTk3M21SWmsxVFJQenFlQlRBaTZw?=
 =?utf-8?B?VXVFNC9sTzd3ZkhGTXlvNlE0RHJNWXM4NWNLazdYQ2RuTWw5YURic0E0bGN1?=
 =?utf-8?B?U0FGMU4xM1BiNGE5KzJZTENzZm5mTDFjc0F2RkFXMVNMcTVEU1lvQXJNajVl?=
 =?utf-8?B?dU1oaW45ZEN0SXR4N3JWQTJTeWVXWmp4Znp5YXdwc2w2cWFqQ0xuSHRSWU4z?=
 =?utf-8?B?RHBEc0U5bVdPck1ZTU51OHhuYVdBL01SbEpLMHA2OHNWZWF3WjRYUy95ZnFk?=
 =?utf-8?B?blArdHNXMXJBVnJMSkFuL1RjeUd6dW1FYXl5RmNSYmFPSjJhSnlyRVdSeTJX?=
 =?utf-8?B?QzFnLy80bHZNYTBKdHU1UVIwZkNPSWFKYkJLL3lnaVRTclZFanp1THZvUkwx?=
 =?utf-8?B?Ujd0VE5HSm1RTTEvWlhMV3g3cFFJVE9mY21KclQ5TUd0RERPYysyRVJjS3B1?=
 =?utf-8?B?OFZxRFFHRkMrY1h6aWdIVU94czIrQk5TaW9ybDhxWmYremNLSURPRnltTS85?=
 =?utf-8?B?SHdjVlNNcGNWNWtFcWxuaHBaeDFNTjZFY2dEOERiMElWTWVLUFR4M0hVV2VG?=
 =?utf-8?B?SVNpek81cks5dWVtTUlkMDlHNGgxRHpDZDQ0ZTlCd0N4WUNjVGx2OGxONUx2?=
 =?utf-8?B?ZDVtUWdkNnFZaXM3WTRKbmd2Y1dkZTgxclRwZzJMZWZObTMwbnA2cEVOS0hn?=
 =?utf-8?B?b1V6Z0Y0N0ZtVjMyaGUxL0lKNy9jWUVWYW4wa0txRFZkUVhMUHdFeW9JRXFu?=
 =?utf-8?B?L2xSdE1sN2FrSDh1cnhmWDVFNDNPTituanYzSmJOVWFaeFFKWHpuMThLRW1V?=
 =?utf-8?B?Y2hGYTJPR2toamVVWFdYS2hoNHczdlFnTnB6QjNvWG8zR01wd2hvdnRkM1Bq?=
 =?utf-8?B?OWM2dVYzVWVjQ2ZabmxpaGJpbW1KNjE5RFhuR3hqcytWSWwvM3JROGNPQm43?=
 =?utf-8?B?N05tWHdwSTgrR2p4ZFE5RzkvQVhVQVJMaUg3QzRGQnlxWFZaWVhnVDU1UFZD?=
 =?utf-8?B?MVh1anhOUzFRelJCemZQV3d5aEN0cVJ0aWUrbnExeklLOEFrTXc3WVZ4TTFz?=
 =?utf-8?B?cEpQQ0VRSnhJQlpaUDhFT04yVUprbUhSaEJXd3hjL0R2cXZYS0xzcWF5Ukt4?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fea5aa-66ac-4216-2b3b-08de0d4feb55
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5364.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:36:44.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlWYY/AuxT3gyS1CV66VLTgZsWStPqvJAE3/khD4dw0rP9Hz82MDibMEXCcq8Sr6JQYgQvLMiMTJBlx2t7KfHl8eOB7IvyfSFCV+hRvIQSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5643

Hi All,

On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
>   
> +	sdu_len = skb->len;
>   	/* Check if VLAN can be inserted by HW */
>   	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
> +	if (has_vlan)
> +		sdu_len += VLAN_HLEN;
> +
> +	if (priv->est && priv->est->enable &&
> +	    priv->est->max_sdu[queue] &&
> +	    skb->len > priv->est->max_sdu[queue]){

I just noticed an issue with the reworked fix after sending the patch.
The condition should be: sdu_len > priv->est->max_sdu[queue]

I’ll send a corrected version, and will wait for any additional comments
in the meantime.

> +		priv->xstats.max_sdu_txq_drop[queue]++;
> +		goto max_sdu_err;
> +	}
>   
>   	entry = tx_q->cur_tx;
>   	first_entry = entry;
> 

Best Regards,
Rohan


