Return-Path: <netdev+bounces-218098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF592B3B186
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65022A028BD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9729221271;
	Fri, 29 Aug 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="QCYuKCvt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0659188CC9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437348; cv=fail; b=skj0UTAAF1D2kLkkRv/QNdVg7JcGPjOSXB1URhAahOt35DH0kTnaoIldorRV2L4nVwGjahnF3q84CL+a1TIOm31WKrdQuOeBDvZkUgbaJJIeeBCe2cCvmR/iR+js8GDZ7ZAurgs/Pj0NxbcdloQ4gmsT8MnhYKyq5N9q7hIBjaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437348; c=relaxed/simple;
	bh=iLWj55v3+UnSqDesnx+Zk/EtPBA6OM1seVbfPK2ZMKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R5X2/HCAWxaUxQvYC1oQDsW4CjQUfZqXQpnD0HLVqd+5O104jLS8ce62nXkNzUDm663zgl/VHWnDxUA39UTzsS6OgxRPYvjl/EzkbCXL7G1XRkCe49H8qSpf5otuvOnxIfrPRVXugnkfEo7cXXrSu2fqIPY3bHYwUaN2vZ1Qvkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=QCYuKCvt; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756437346; x=1787973346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLWj55v3+UnSqDesnx+Zk/EtPBA6OM1seVbfPK2ZMKA=;
  b=QCYuKCvtz2FhMBppIfUKeHs/fTqk3OlBzmpX2Ke3IJy1jPd/VT1J17bS
   i+XjNZUYqRkxJs32n8mB/SM9yKPe2syU0fA+mzc9GI53z+J87PZKYuTYN
   JTUcMFRnW1HZUtVgoRvKss6i/x2uhY2N2qlNotGbxDD4PgTADJFX0pjU5
   Q=;
X-CSE-ConnectionGUID: lPWfQCFdSjiGPlVQqHn9rQ==
X-CSE-MsgGUID: ngQiYvX1Q7KBuFiIrWKu+Q==
X-Talos-CUID: 9a23:X5YIT2+Rz/aA5oKw/42Vv0osJc4cWVPR93XRDHe8N19waLvEU2bFrQ==
X-Talos-MUID: 9a23:vd2eHghuj9P8B72aWbuQ4sMpMshR4pWwOBk0zrYspueFFDZPGCretWHi
Received: from mail-yqbcan01on2095.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.95])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVfnZbrfeHr8YsC9JMnsqqlx6pciefMczVuNoFENXvNviN0a2DHjPvmgH5/rMZsSEFjqeQmBmulIbv7x3QBwIt96l7ctgjLrOK66ui1/mBt6fS0Cx3ypFr5VgX7tBJ0/75Kq/ksCp1Qiazeply8pB4kXQgXWNxHR4Pi3eJccAOtDIthIki0wWjL12qYsOYIUac/gAr1Dni0C902WYgWLItNOhB4hDsyDf6kjZBVnk3WmLhBFgiN/Obe8TaN+Du6Zz2eKwGliec5Ahxq4sR2U7WNFKZ8QDnWtxu5Q7h2qT52DXuMUMdyHhvVUfAdiKcVBnAzkgKBnlubgtiECgEzMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4gC4x0GmANv9t8DRPqSML1pVVAp0uTvPZ+jSoIhxxE=;
 b=p3mEFUX9PQv2cjcN4GCnLAIBOu4imS8iSkldns+c3+7jPhxhSmCDvbifIR6FIQjyVSt9FG3C0kV/mNEPtDZZWchpHtFVY1WrhCOgzb3Samuzfw+mBKM6crVOd3Nac40xDvLGppMUoR0yX8yqcfzDs/F1pVwNYIlV6TI51shjyQTTRQNhA92W3l1TuzU7iUEJL/mJjYGCIIOHHsEmcuY/jZxVVdZCkSa0D82RRqXyU5xpumE/hx1p9Q8rogy7MXAFl9JddS4NTDTXNjCiVC/+zu+FrRLRZShzozIopYUPh7mk+nahLuM/5TTn0I58vZFYLu3yqwbdnL08XzYuwcPyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT1PR01MB8233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 03:15:40 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 03:15:40 +0000
Message-ID: <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
Date: Thu, 28 Aug 2025 23:15:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250829011607.396650-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250829011607.396650-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:408:eb::32) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT1PR01MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1d0806-83bf-408c-4795-08dde6aa5547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFNMYmppbG9iWnowSVpDS0pKN0JYV0hHNEduS0NrZXZvdlErcUIvOUpCOVky?=
 =?utf-8?B?dVo3YXZhUkZ4Ym5qVkN1V0dLL0VpQU5IRkgwSWNNZE1HdEtTQ0lXYkxHSnVJ?=
 =?utf-8?B?NVFENWQ4dHlKMmNTcXBYUlk3WmhYYTh5L3R0TC93TTd4cEszcU9EZjZyRDMr?=
 =?utf-8?B?V1RLNkQ1RFVGMUlvUEM3dHo2dWxoNXpyTEwzNWVuZVFDTkZTVGZDelNlYkdI?=
 =?utf-8?B?Z0JCVWFkeTVwb0N2cFpwVmJCeTlKMC9rdU9uZkdnNVdNTDNwYThIdHZBdmFz?=
 =?utf-8?B?bzZwRlBUZGg0SCswenVsVjIyUTM0dkxtS3hLU01DOEZ2c21DWHdFZ0JlMTFk?=
 =?utf-8?B?cHBQQXJsUGo4Qll0NEgwVG1OWDFQbVJHYjNiYkplOW5FZWFxNXdkZXNWSXJN?=
 =?utf-8?B?ZFVwTCt1cGZKL2FoUDB1aTJOaS9tT0ZMSjExeXd2QVVYYzJ3OFUySGxuOWRw?=
 =?utf-8?B?SDFGZkkyZCs3MW1xTlphZnhHNEpwamRiQURER0dyQ0F1NFdZTDlORC9hNUFJ?=
 =?utf-8?B?QXFNdFIvNFJTb09UNjMxSXVrNzJzSWk4VmkvWjlBRnAxRGdHYkFPLzlXRkFQ?=
 =?utf-8?B?bXN0eEQwbEMyTmlneHhvbUxqQmpQdHdkVjJUSHJGNXFIS3ZvdThDS0d6Q0s4?=
 =?utf-8?B?Q2s2ZWNSSDU5TE81aFRvQ3RZck0xZmNwSXlQTHQ0S1U1bTNyeHd5KzNRQnR5?=
 =?utf-8?B?SXNsM2xOZEpxZkE0N2ZXckRqSXh4Nzh6eTdtRXdEUVdGMlY1eFo5VDBZdnZs?=
 =?utf-8?B?N2MxVmdaTm1NdWdLY01sa2VrZHluMXVBNnBQWlpQdnh6VWpTWHY0N1RPeFZW?=
 =?utf-8?B?bGZoVFR6QXFST3NyOEFpOXZhbzl0NkhFd0k0dmtRclBqQUlLUWdJT3lHbFho?=
 =?utf-8?B?OVFzeGxtWmpMdHdiSEVTTTdGazhHWElaMnBRaklsU29VaW9uRUZidEFUWk9J?=
 =?utf-8?B?S3Njbm9tR2pVZU5kRVpCYXdxZVJRdHV6MFlMbnU3cFMzbUdtNDVmQk94UHRW?=
 =?utf-8?B?R0ZKYXJOSTl2VXdZdlZFd1FuQ21KV1dhS09oMy95eHh2eC9IMC9ITm5ZS2Nu?=
 =?utf-8?B?NmxjbEhjNGNueFc3S3diZmUrZFlOUUdxYWRyVjJoTzBnV3l3Uys3ZkI4UDFC?=
 =?utf-8?B?blR3ampHaEwwSnVhYlhKbG1Uem96RVVZdzZyU1RkRjY3S3FHTmdmdW9YM2F6?=
 =?utf-8?B?eWh5V1UwbjI5UlNVTWhJN2ZGUWpRQm1ENjhNNE9OQkhvNCtTRW9YczhBQS84?=
 =?utf-8?B?WnVhTllIcTNrcDBUNFpiSmtnSXFUR2N5bUMzZW9xeGNHQUxRUWFpYmtsUU5L?=
 =?utf-8?B?U2tDeHVWaGtybUR0RGtEZ3d5alBMSFk5RDVQUm5ISUxCUWdBMHI3ODZWWWlF?=
 =?utf-8?B?RVAzY0NoeTdxVFViY3UzOUN5dk1HMHhGSUFwbUR1RUlXTEhIMmhsOTlpa2V1?=
 =?utf-8?B?OXQ3QW90MWZEQXNVK2lFVGNvSlA4RFNlTUsyRHVET29aWUZSVVR1ZTAvK25w?=
 =?utf-8?B?dy82Wlo0eWVnMnpJRGZrRFV3OUZobVcyUlpLWi9FdlY4eHZySnRXc0c1ZGJ5?=
 =?utf-8?B?b3BjTzN4aXBqekhLMnA3c0VhYnlSM3JqYk9MczVkRXJLdkYrYUZPMWdOQXA5?=
 =?utf-8?B?SldwY2xWTnE5elFkNHNsUy9FaUpFZWRWSjYzQnRFVU5JRmxXNmZweHM5WDB1?=
 =?utf-8?B?SE00MTB2TjAwQ2E1ZVQ5QkJESThwQkw0cGtkOXdteU9CeEhTQWhXSmFCYTdG?=
 =?utf-8?B?V0RhUTM1RWR0NE5sbzVCNWZmdG1PN01xU0xXeEFxZnBqWlhlcEhGK0xCUlR2?=
 =?utf-8?B?SUNtRDgwblVsWkxMNVlCOWZTOWg5NVdNNlh4R0U3a1B0Y2xON3ZpMTJFRjQ0?=
 =?utf-8?B?Qk1KSURZZ2Y1MDdTb25sSTNCbGNJS0EwNmFKN3FDYU1RTVpJUUVOSjZLampv?=
 =?utf-8?Q?y2wsFGhdxKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkU3SmZIdysxTnN0dWU3cTFIOWlGRytsUlhOTm9FY2pLbU11NE9LSG5EM1Fs?=
 =?utf-8?B?RC8rc0VvdTZYTDlQeU5WNGxwRk5NYUZwRlVqcFZEVTIyVk5jdk9rLzFNQTE4?=
 =?utf-8?B?ai9pRW1KckVtcHZMMVl3V29tdVNKZ1lwZnJ0QjhzTXd6UzloS3E5SEV5bVRG?=
 =?utf-8?B?ZVJVb0llYUcrcTROTDNBWm8zS1lyWFdWYitGMlh2bDdpNmtTMm5FMW9YMERs?=
 =?utf-8?B?MjV5V1JXQ284dXBrbHdtcTd2NzFReUxSTDNNd0pzTWw1Vm1EcjFtbFY5WGlk?=
 =?utf-8?B?NCtYcldIbU5sK1htZEV6emMxMGRjRWVwczRxQ1dPaTdzYzc5T1kyZFF5N2o4?=
 =?utf-8?B?STdHMGdNOTdqbG1YOEZQRVd4dExsUDVKZkZkOWtjZUVkZklVUTFabzF2TEdl?=
 =?utf-8?B?L2crem0va1VjWkV6YlJ2cVEzSXhZejYySWhhUEd1N2FXbTNuQzhvazd5bVpO?=
 =?utf-8?B?WHlCMFFBcFkvRy9aV2p1V29XcUo4OXNNT0E0ZWVJMndJT25IZFcyai94U0VW?=
 =?utf-8?B?ODY2ejJlZURYSDFuMWlRdG05R3h2RXJDMENtMVRVaHUrTHRjaFBKQ3UzaXJt?=
 =?utf-8?B?NW9RVkpmSDZrdGtFalV1SDh3UG9TallxWTRkNUJQM2VyY1Q3a1J1QndJOVc4?=
 =?utf-8?B?Z3YzWktzdVV2d0RnUGp5b1FVcDBNdnRyc0ZOc0RuQ1ZkVHNTMncxaFdCVjNk?=
 =?utf-8?B?a3gzU0ltRFB0cTBuQ2FzMGVFZ2FLRXZsU0syTEZ2QmwySmxBRjcyalpkNmp0?=
 =?utf-8?B?ZUNyM2Y3Q0N6bWY2YjFpWUwvRkRzRlZHUXNuVUJnWW9lZ3RaRG5neFB4T014?=
 =?utf-8?B?WjdvS2IrWFMyeXBCMmtyb3dwdjFYRVcrdUFOMFZLVTRFNEJQRHhXMzgyMlVi?=
 =?utf-8?B?VlFQdWtoSXJrNW5wZkI3UXhYVGdCN0lYYmZ4NElBZWJFZlA4MTQrcCtKR01l?=
 =?utf-8?B?S1JSQkkrSHdPdDZIUkNuZGwxSUlOOFg2ZEJJTHZpcGVkbGNjZzI4ZkJ2UnRH?=
 =?utf-8?B?MFhXNGV5cUVVNkpWbmtSenRvSlMwZ1Rob0Z1cjdHc3IzdTNVMmVjMTFFOGZs?=
 =?utf-8?B?b3V4UDNobXhNbUxyQlU4ZWFneTl4c1RaMjdRVCtiYWNpUGpTWi91M09mNzRE?=
 =?utf-8?B?UURIbE1CRzg1d0FWekF6M1dmaG1jYnF0QmVoK015VjFveUZhS3EzU1lFc1Vx?=
 =?utf-8?B?YjE2cXRKNzNHcFltaytxV2oxNDB5a3R0WEZRVXdIRWpFNEluTXBhNW8zWDMr?=
 =?utf-8?B?ajJIN2E4WEhqZkU5Vk0xSEtPSFQya25MR1hkMmdveC9vVDVJWWtocmpuVUVB?=
 =?utf-8?B?MFY4NlpVcHpaYWZzRHJzSHJHd3JrcndsNEZWaTNCeE5IelVCUlRHOWhldFBq?=
 =?utf-8?B?aDJnKzJWWHhDOVdmd0RkcFNHWTV6RXhsU2YzcllUNk5sVjB3bjBNazNocEZ6?=
 =?utf-8?B?dU01OVVMRitYVDFmOHR2bUlnS2F2ZFZtaFBiWXdKSFl5L3BXMFFKRWZqOUFt?=
 =?utf-8?B?QjFDZnptbXd3OVN0QkhMSXJmamZSK3VHakFocERYcFU5a1VVT1lFb3gxU3Ev?=
 =?utf-8?B?WUc5ZVV2Q0RGek00VnhtMWErbzE3U1BxNHZDakR5Y2M5a01nN05tU2tIVmVZ?=
 =?utf-8?B?c0dNUlZVVXdBRUpsajh6VWdWdXkvUm5CcmZrN2RndVRiVHpyU0Q2KzVjOW9Y?=
 =?utf-8?B?VFJGWTBGNE40cXJqSTRnV1poeW5ySG1kR1NvejVBaHJ0RzJ0a2dPY3JyNlFn?=
 =?utf-8?B?NFY0L3oySVZHeVEwb1FLanRlRmdhMVlmNmJlTVVTa3pnMkpQMGZGOXVaQjdO?=
 =?utf-8?B?bzAyUVVhKzdoeUJVTkhXZ0diVDFzQURqRHg4Y2lZZjNYWmE4VkEwekJZeG9V?=
 =?utf-8?B?VHBMMEo2bXc0akhHWlByRHRkUy8ybEZpRWErVDNxby9OMlR1dW9iMXVmMmoy?=
 =?utf-8?B?b29RZVV0TjJTNnNCbzZlMXA1d2dUd2phRlBnSCtQREpBdS9lWWJ2ZTdTd3pS?=
 =?utf-8?B?VHZCSHU3MTQyVXZTMlZDei9rRFk4VEg3SDVhcUlkcmdwdk1Jb0lQQ2pDS25m?=
 =?utf-8?B?TjhZRWdXd00wY2JLVWtQRlQ0eDMvZVVydXB2Rm1QQ0x3K1orU3VmUDkrTjdu?=
 =?utf-8?Q?GLIS2Rhrg7CMU0iVd+s4tB/fO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9c9/rNLONz/Hxu+Pst5B30ZptUmqd18utq+l0qrPs/G/BMDYSlt6Uz+/YgizndHOMt/nitcvSwKoIOiAtyRF9zVEqOZEieBuEv78z91t8p/5qaffH3G2528UZnnLlcrmvHDtAiYGYb/fZxiMgLLn9Q1tp5T0io6L1a6OUm+QPUawt/JjyxFAvI3hH2lqNOfoojHEbXnbhTP9WmAMrw1eSKH5l72BWOZBrCRT9rdXQlB1Wev5RVjaHniHg+BHa3St88EMs/N7/2p4yKLfzUOrMenBrfZFEU2SV1JbD2j262EFhKkmEvBpK6Yuv4LqPE5hSiD5Jo3RhK3ip5k9O5gX3HV2XtdMp0bgTpbkbfGYWnyZOoxn39wcUo3UWHA4V1MBRQwaFwt447UHyvwOT4AMzQ2ilf2OviPuyv7KytHAEQobkyVfvWxlINosvd5K9S+LgaC1kWtsl6JzC2oDVyxalIWSlHqw/ezfYATGP8LzZ6GEWWXTktwnfL/WnTQwONAZ4FnvfraHnmnpihuu5PA0GnZrXVXImhEgOCBZkRTjIM11QgVhfH1sCTvzIy6N4uLvi9Mb/JQFhE3uQI+jFGpTAriywspXJ5UDOdco6Bkqb6ooJq3x4cec3SOCuz4PLUr7
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d0806-83bf-408c-4795-08dde6aa5547
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:15:40.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrxILVVZdp4hba8xgSECLSQXkTwICvq4hd1+gJgkRv5zQhAC8LP+rDaemAVVc+IgjI8mKkM20Fn5iVglL+61jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8233

On 2025-08-28 21:16, Samiullah Khawaja wrote:
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
>    echo 2 | sudo tee /sys/class/net/eth0/threaded
>    NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
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

The experiment script above does not work, because the sysfs parameter 
does not exist anymore in this version.

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

I believe there's a bug when disabling busy-polled napi threading after 
an experiment. My system hangs and needs a hard reset.

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

On my system, routing the irq to same core where xsk_rr runs results in 
lower latency than routing the irq to a different core. To me that makes 
sense in a low-rate latency-sensitive scenario where interrupts are not 
causing much trouble, but the resulting locality might be beneficial. I 
think you should test this as well.

The experiments reported above (except for the first one) are 
cherry-picking parameter combinations that result in a near-100% load 
and ignore anything else. Near-100% load is a highly unlikely scenario 
for a latency-sensitive workload.

When combining the above two paragraphs, I believe other interesting 
setups are missing from the experiments, such as comparing to two pairs 
of xsk_rr under high load (as mentioned in my previous emails).

Thanks,
Martin


