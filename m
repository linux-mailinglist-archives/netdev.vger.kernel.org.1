Return-Path: <netdev+bounces-203713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B5AF6D92
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525BA17B743
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729814286;
	Thu,  3 Jul 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ARIUKlLL"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022115.outbound.protection.outlook.com [40.107.75.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D51B415F;
	Thu,  3 Jul 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532521; cv=fail; b=l0ZJytmYI8StAnG9PJuo7B2oZ8m4SaZQjmIaTXH3TTsVj3uQds71418ZNjmFxNPDQPkE1HMFKwvFFTeukNZiSMg790a9wX0Mv9FtdGlzuh6oU5rh7mfRlrhkLs+kFN217vpKJTv4Ak5NusHs0qloE+VCTLe2Xo07AttEuVjP2ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532521; c=relaxed/simple;
	bh=D9ra7S9SNaH9XPvRR3DQh07L6glat1lZZVmD4uC7YsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGnc5djVF9jhJMHxu8k97tysiKSXPeowgxgi/W40bluvExrKR4PSSkUUODVw1ifdhRpEB9JHotZxytll4Pq+ur9A+GmVvjkx4UWqHGV5k5kJcFW9Iv0JVC0NdGwViypWOaCvI2j2eV9v5uVjlPzuhMpV0PtjEwBmJnGrsaM7Bt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ARIUKlLL; arc=fail smtp.client-ip=40.107.75.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHdbnhf5EnYhKpLksJxhCNMXLsm3M8Zp3VSPi/16PzHkG3INUwkBzmiiUaeMM+A+W1jlRTkYNkRsn7/7P0/nZ6d8XtEoz1hW0w/u05S8nWq0I3BQ19HO0F7N3bw0ihfySVH6FRlTPB+4zmZt1AHUlv3sQ+t7CJea7rZg8xxH723YEfq4+Zb0G26Y50serPPoIupJuQqAz/c9jWnDkUfJqRKEuelLqSVyJcjiiZhCRazOpXoqyxojJlgPd6wW3mOF70LX579Ga5Hc0fYLaI4SAZt0qrdEU0nUMc0e1XYvJe2pxQuQ9Y93RIdmjZAUv42u58OPgPf2eCDHKOopsWppKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt/+xN5i8gWdEjFDUDBCMqDoh9iBCSft3YB7qr5Pw9M=;
 b=SCzLx3psiPhWi+qcH7x1lXUMNF5vg7TCSRf4iK2Tu+jjV+uIqjiEnpx0xjMpqPn1e8TUE3vvULF23PTSAHW24onkRQFiIXsx7u5v6Mn1YExHHS3H3yY6g+nrBTypxjCVfm3wiAe8EI3LC+fG8XmuRw8oTlfXdPmSuKUlKGLIXNcOb458yfdYDnY87G0J8l6zPiuX6v1VuO3wFD9qtXFI1s4xnFDsY1ZV0h1MliGXoPKa1vluWXpyp42JSDjG/UARq3KvPIhMwHMu8mxGnPf/Mo6ZxVgTfn2K8doGeyOzP0Pb4PxJ8WXNSincylVdm4pf5ftXoMegbTaHgpnmG/kpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt/+xN5i8gWdEjFDUDBCMqDoh9iBCSft3YB7qr5Pw9M=;
 b=ARIUKlLLhB1UEFlYUmpG0d9w27EwDTrfobg38Fz3OPAYje3b71VM5CKQpscHN0vYig7QPM9N+oLIk9s3r6DvrIe076do0LgGVTUP0eCSBExC96uhcvIjk2NCZWWwl5JidrxUANRfgslD8TtuZLx3BoAHmJ/CZInpu6s4z8HURBdw19cnaNRj3OMLT7SMsL5eYvBr42wOO9tGgj0QFzy1dHfTS0fez28kQVwMizHC0FUYND9jgpgeKhTjohSNRJFrz3LhLucAOHT91HFjzac3nJUowg8wYGWAxF7JE4uu5VxNnZOpfhrXwwnFW1ZXcXoQNIz/r3BFFb4Cumwim+WoPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB8841.apcprd03.prod.outlook.com (2603:1096:990:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 08:48:32 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 08:48:32 +0000
Message-ID: <fa781c84-759c-4c31-811c-d8a93bfb8f1e@amlogic.com>
Date: Thu, 3 Jul 2025 16:48:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync
 state
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
 <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com>
 <73cfbf68-21e5-4a3e-aa30-a8b08e9ca1a7@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <73cfbf68-21e5-4a3e-aa30-a8b08e9ca1a7@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b3ca1c-44d4-40de-9027-08ddba0e63ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjJBZ2psNXJPejhnOTZkQVY5aVJwaFd2akVVVS8vdW5GazV5TW5ueCthTEh1?=
 =?utf-8?B?TXRSbGNIVzBQMkFBRzY5T3RDZExBc09wcmNDeGdnNUFOYTlYeWhkNjZjYTZj?=
 =?utf-8?B?T2E0eExUTHdGdGkxaFRQa29aRUNCVWtDUjd0SXZpNlJ6NkkvTWFUOS9UUFM2?=
 =?utf-8?B?QjBiYWYvc1ROalZlbGhHbExMa05Edk1BdlB1VFNLNFRHTHIvdmRTV0FjajRQ?=
 =?utf-8?B?MEtUSjZ5RUdRSFluMjNydVUyclVIQXl4NytmWnJ2a3g5Q0tzTnE0SmhXeVB5?=
 =?utf-8?B?bU5GUXZqdzhVTmpoYzE0OVdXOHZrT3c0bEl2WVZIdTc4ZExqZFpXOU5ZN2Iy?=
 =?utf-8?B?NGN1dVpLUjN0Q1RhczdQeFFyL1Ztd2s3UGdoOGx3S1d3dGIrWnhJWFVwT3h3?=
 =?utf-8?B?c2wzWGEyYWhMb3NrL1I1Q2J6T2RhVjJBMldFRTVzd2Jqc3pqZkh1WW1POVIx?=
 =?utf-8?B?Q2d0RGo3dCtneWcwOXhRZjBEdkN2TDVKVjhua1hwR0xUSlp3czdVTG9tKy9h?=
 =?utf-8?B?YytlZnZNeS9hcmc0WlArcHR4TjRsampURlZpN2VSNmdYRThuZWRxaW9yNlJV?=
 =?utf-8?B?RnBpQVlMSkJlYkVFZ2lhREFyaUtOSjg1RlByei9FZEpWMlRmaktzU0FkdmF4?=
 =?utf-8?B?OSs2cnBiWGRNQll1VEtzVVNlZk93ZlhuZXMrVXdCd3U0eU8rVGZZb2pVT2l5?=
 =?utf-8?B?OWRtdzNxa3ROUjgzaDI0UzdUUmhJd0tJRGdUZHNYQW1hOTVPSU9iQWlJSlJ6?=
 =?utf-8?B?NnU5Rm8vOG1qWklvZzlSSW5KVURlcENhTWJ2dFRlSUlyNFMrck1tUkY1VUN1?=
 =?utf-8?B?ZDBVK3dDdiszcklTQ3JoWS95elFXOU9rVDk2WE1aUWlaYWFWOStIVDNtUDVM?=
 =?utf-8?B?MVY1VXV1dlg5VHVkQ042c1VSWmlKL2ZLY2lqZzVxc0hBajQxSm1kWVNFZE9i?=
 =?utf-8?B?VTdCVnAvZEdOZ0lvMWE1U3l6bGgrNDdveGhZY0xLeFk5bHZZR291RWE5dnow?=
 =?utf-8?B?OGoyQU9tOHRIaUJvNjlSODhGWEpsVjZQTWFDQWoyMHYzVUxOTU9hdldLVnho?=
 =?utf-8?B?OEdZanEyZnJvOWM4eFQ3OEE2NkdoTG9OaXlpS1ZYZk9MMVViS0NkcTZ2Z2x0?=
 =?utf-8?B?UVczZDBaN0tiL1kxRTRuQWRWMTdzRGdBamFnMmFENXBYUThjVnpsK1VCeUV3?=
 =?utf-8?B?K2RIOFZjNStaZ21wbUVqdkF1aDcrZGdUVFNuci9hYWJtUm9KZ1hTdkpxK3RE?=
 =?utf-8?B?Y3dRRWFWS25pZ3o3c3BGNGorUElPazJSQnhZNlZtZWk4VHpaRU11QzZYNlhR?=
 =?utf-8?B?VGVxTVEvdEhpQmJIckhqLzR5UXovWFdVZlEvY25mNmFPTGxUK3RBLzVoSDNw?=
 =?utf-8?B?L202Z1lZdGFCV2ttKzd4bVRFTW9odzZMR2Raem9wSWUvMHRDUDNDZEZmZnJw?=
 =?utf-8?B?a21zWm1VaXRoTWVzVXBaZnlDQ3NUY2VTMGgvRWxkM0hRbXFoN2Yyd3N5Ly81?=
 =?utf-8?B?WHRMNVRSM2txcDlrTzBra0VEcHJkM2FIN1pMZi84RVJQa21jcFZwanZGT0lB?=
 =?utf-8?B?aUttMTI0QUFvOVM3MUVtNGpOck1JRFZGeGVvQW45bWRaSEI4VVkzTlpXYm8z?=
 =?utf-8?B?eDRPTjY0T0dWT1UyWjcyb2k5eWdzZys2WUxLWXlXWkpFSDBzaUx5Vm9tMHc2?=
 =?utf-8?B?UGRPUG1VVVlreDBldDJqb29qRmMyVElpdVdDVTFUT2g5aDNyQ0NTOWtmZ0NN?=
 =?utf-8?B?MFZHY3RkT1U0QVNTaWQvaUdENGQvSUJKaXd3MnZFMHlXa1lGa3RZMStodDdG?=
 =?utf-8?B?MW1PbExFRjlUdkFtNGdONjV3clBTWXRQbXFMbE9GczVscGJZNlR3aU5OWFFB?=
 =?utf-8?B?NUhjWnZaU1JmdzdYeW9uaDZIUU5PYU5rajM3cVRHai9URGpndTA5ZlBOYVYz?=
 =?utf-8?Q?lhWo+GBl5U4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWtVaEdVZ3ZEVnp6c1NwNURHR0dyc2hWaXNJbHhmOUJTaFkyK0x0RUk5bXJl?=
 =?utf-8?B?TDZCZk5QNVRqa3Vqb0Z5WWt0VmtWUW81WlQ2RWU5K2UxczJQNU1zUzJiWGp3?=
 =?utf-8?B?ckZCWHF4ZnViN24zaXNkNWdNZ3Njdk5tR09nWFFBczl4ZWpTVkM1MXQ2eG82?=
 =?utf-8?B?TmwwZGd0a2FOWGJicEF1L1VEOUpOMWVOZS9iazNYK1d6c2ZrSmt1TkNsUGF1?=
 =?utf-8?B?cGtRVVFxK3ovRVlMOTFoNFowdjZEcmdsQXY1TlFlN2dLc3dEQiszSVVpUHZL?=
 =?utf-8?B?bjlTYS90TkIwTkhDRUp5MkFPYWQrYThGTjhxWHFQTTk2MzJxaHE1c3hxMW53?=
 =?utf-8?B?K00xK3FXZHJQWkgybEtTTUlsYW56MWVNOWdzd0VlSW9OcFYvVjRFVFBNYzJj?=
 =?utf-8?B?MTdIbDJxeXdXSGVuMmQrYmhvaDRoYkVlUGtJbWlrNnFOQVA0SW14c3JLV1dZ?=
 =?utf-8?B?NDU0ZS94eGxhRnBUL1hralpaekZsK2EwN1g4OGI2bEcwR1lzSjRNRFhrRytJ?=
 =?utf-8?B?eXRNVC9FVWZKaDlLK29hRUgramhqblMyS1h0Z2s4dUJvMHpZNytFbURWK3dh?=
 =?utf-8?B?WDZMckVJcUFDWVlzSSt0dXlPTTdBVUtzTkh4Z1FVQ2h4ZVhmTWExOExGbUJL?=
 =?utf-8?B?b3lXU0hQUVBYV0EvY0krNjZBTUxtZ0dzTVFKQVh3NzJwRVdPUUJ5ZHI0VHY3?=
 =?utf-8?B?bjNWamVnN1JKTXJzZkkzQ3BuU3FLMGIrOHJFM2RNS3dnaU43ejN0VGVoTUlW?=
 =?utf-8?B?aDFRTUFUN25kZ3JNYjl3d3pVZzJOUnN1NDVhNXNhaTBDNnJXRU4yRmNhZER2?=
 =?utf-8?B?bzVmTkZDTGVlTWxLTmt1N3RMNzNhc0RMd1J4QTU2SndBaUJBQXVGV1IraU45?=
 =?utf-8?B?OFh4MjA1UHJLTjhnZExrZ3cvL1dHVlNaajkyRExoRTdaNVJJT21HQzQ3MXpk?=
 =?utf-8?B?cll1SHFwWjFYcVo5djRDZlo3VHozVlhsM2hFc0IzWXM0OVJBYjM2cCtCU0VM?=
 =?utf-8?B?UG1jTXdNOUQrTndIb0dIcUJ3eFlWTFNnRWJqM1ljWHhrRlZMeFJqTDVxQ29y?=
 =?utf-8?B?NFFONm1NdmJvaXdqSUtpRVM2RW5WU2VZY01qaFNlZjhyK3NYZnkvNEpQLzlW?=
 =?utf-8?B?L3lVRXk5NTFUYUtyZUk2a2k4SDQ0WGtPVzd5QkdRdjhtbVZWbkszVEZ2WlIw?=
 =?utf-8?B?N1NQMTVXRkh2V0FYQWdRL2tDdDNXWlNpTk1rak5nT1U3K0swMHI1VTdGQnBm?=
 =?utf-8?B?eVhwcEtMa0ZVQmtoRkJBc212anRqdWZBMXdRUDFGeXd2M05ZUzYxMUFWUjNk?=
 =?utf-8?B?b1FwVldEcFh6NVVoR2R6emQ3amE0eUhlOUxISExRYXNWeHNJOVpDdCtEb2x6?=
 =?utf-8?B?WkVUVkFzalBxR2RwM0RNK0Yzd1FOelhkQmtaT3FrWWRoVGRtZ0ppYWNEcDN6?=
 =?utf-8?B?ejU1ZURqZUkvRFZ3ZlQ1Y1dCNzJ1YjF6Wlh5R0MydzFWV2RDYWlFMjJDbU5F?=
 =?utf-8?B?QkxxNGZyOS9wTFhvWGVxdGRTam13UWRMQWFGYmNYNGtEZHd2RCsxWEtNaWRr?=
 =?utf-8?B?UitPQy9nM1lkcnpZK2t0dG1kM3prc1hpcWE1RFE5NFR0cklHTythVDQ5SHVD?=
 =?utf-8?B?SE1LL3dSV2M0NXo4TmZuR3h4WUVTVkR0dFJHcWVVcFN1QUVsbkhSeTU0WFJl?=
 =?utf-8?B?N0IvVjRDcTNocDg2ak1QN0JzRlh1czBHdmppUHlnVFdPNFkzU1NvWWs1d0Js?=
 =?utf-8?B?eTJTTGtuU21BM1dmKzM5WjVzZDFZbTBpWWx4YVhWTXRZTWlBRFptSGl4QTE1?=
 =?utf-8?B?ZDNTK3QzbmhvQ1NUWVBEL1N0Zi8zNGx5YUZNSzhaVUo5MlVINm9PTGxFQjNp?=
 =?utf-8?B?UWIvQkxhbDN0TDdNNjVpYk5QbERtWHptRW5qSFBOOVQ0YzNocFNCRDZDM1kx?=
 =?utf-8?B?RlhUQ1lLblRWL1NQTVhvYzFQQjk2R3pUbVZLcTFxQnZodElteHlNTm5EMktQ?=
 =?utf-8?B?OUZZd2lhazRZQjNmam1CaHZicXR1dy82T25aZUQvWXVtRDRKaUdpK3ZTNS92?=
 =?utf-8?B?Z1hhUVkrd2puQWNjZ0xCWXFoUUR3OXkrbmVmUzRMYXJiZWZ0ZXFUNzVZRGVU?=
 =?utf-8?Q?6UwRdQl77/D1R15B8YNZ0P8p0?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b3ca1c-44d4-40de-9027-08ddba0e63ca
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:48:32.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75AUoydINfDKJdmJCgLDk3JfbD89Ozo2TB0lyxx+lf9QODC/J6ajjhKV1HdhepBRdYxIlFDYAUY1r2CH/mYyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8841

Hi,
Please forgive my oversight,
I replied to the wrong email. Kindly ignore that response.
> Hi Luiz,
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On Tue, Jul 1, 2025 at 9:18 PM Yang Li via B4 Relay
>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> Ignore the big sync connections, we are looking for the PA
>>> sync connection that was created as a result of the PA sync
>>> established event.
>> Were you seeing an issue with this, if you do please describe it and
>> add the traces, debug logs, etc.
>
> Since the PA sync connection is set to BT_CONNECTED in 
> hci_le_big_sync_established_evt, if its status is BT_CONNECTED when 
> hci_abort_conn_sync is called, hci_disconnect_sync() will be executed, 
> which will cause the PA sync connection to be deleted.
>
> int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, 
> u8 reason)
> {
> ...
>     switch (conn->state) {
>     case BT_CONNECTED:
>     case BT_CONFIG:
>         err = hci_disconnect_sync(hdev, conn, reason);
>         break;
> ...
>
> stack trace as below:
>
> [   55.154495][0 T1966  d.] CPU: 0 PID: 1966 Comm: kworker/u9:0 
> Tainted: G           O       6.6.77 #104
> [   55.155721][0 T1966  d.] Hardware name: Amlogic (DT)
> [   55.156336][0 T1966  d.] Workqueue: hci0 hci_cmd_sync_work
> [   55.157018][0 T1966  d.] Call trace:
> [   55.157461][0 T1966  d.]  dump_backtrace+0x94/0xec
> [   55.158056][0 T1966  d.]  show_stack+0x18/0x24
> [   55.158607][0 T1966  d.]  dump_stack_lvl+0x48/0x60
> [   55.159205][0 T1966  d.]  dump_stack+0x18/0x24
> [   55.159756][0 T1966  d.]  hci_conn_del+0x1c/0x12c
> [   55.160341][0 T1966  d.]  hci_conn_failed+0xdc/0x150
> [   55.160958][0 T1966  d.]  hci_abort_conn_sync+0x204/0x388
> [   55.161630][0 T1966  d.]  abort_conn_sync+0x58/0x80
> [   55.162237][0 T1966  d.]  hci_cmd_sync_work+0x94/0x100
> [   55.162877][0 T1966  d.]  process_one_work+0x168/0x444
> [   55.163516][0 T1966  d.]  worker_thread+0x378/0x3f4
> [   55.164122][0 T1966  d.]  kthread+0x108/0x10c
> [   55.164664][0 T1966  d.]  ret_from_fork+0x10/0x20
> [   55.165408][0 T1966  d.] hci0 hcon 000000004f36962c handle 3841 #PA 
> sync connection
>
>
> btmon trace:
>
> < HCI Command: Disconnect (0x01|0x0006) plen 3             #75 [hci0] 
> 14.640630
>         Handle: 3841
>         Reason: Remote User Terminated Connection (0x13)
> > HCI Event: Command Status (0x0f) plen 4                  #76 [hci0] 
> 14.642103
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
>
>
> So the current question is whether the PA sync connection, which is 
> marked as BT_CONNECTED, really needs to be disconnected.
> If it does need to be disconnected, then the PA sync terminate command 
> must be executed.
> However, in my opinion, the PA sync connection should not be 
> disconnected.
>
>>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>>   include/net/bluetooth/hci_core.h | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h 
>>> b/include/net/bluetooth/hci_core.h
>>> index 3ce1fb6f5822..646b0c5fd7a5 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct 
>>> hci_dev *hdev, __u16 sync_handle)
>>>                  if (c->type != BIS_LINK)
>>>                          continue;
>>>
>>> +               /* Ignore the big sync connections, we are looking
>>> +                * for the PA sync connection that was created as
>>> +                * a result of the PA sync established event.
>>> +                */
>>> +               if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
>>> +                       continue;
>>> +
>> hci_conn_hash_lookup_pa_sync_big_handle does:
>>
>>          if (c->type != BIS_LINK ||
>>              !test_bit(HCI_CONN_PA_SYNC, &c->flags))
>>
>>>                  /* Ignore the listen hcon, we are looking
>>>                   * for the child hcon that was created as
>>>                   * a result of the PA sync established event.
>>>
>>> ---
>>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>>> change-id: 20250701-pa_sync-2fc7fc9f592c
>>>
>>> Best regards,
>>> -- 
>>> Yang Li <yang.li@amlogic.com>
>>>
>>>
>>
>> -- 
>> Luiz Augusto von Dentz



