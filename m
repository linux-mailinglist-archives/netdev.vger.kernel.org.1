Return-Path: <netdev+bounces-202754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB019AEED91
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08897A27B9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5A20D50B;
	Tue,  1 Jul 2025 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zx+Zi5kO"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D271F37C5;
	Tue,  1 Jul 2025 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347666; cv=fail; b=SJHRuZaKVIBWkPKsy6bPqAJF/W0k27AAqq+YTqjcW8NIH5PF3VVjXrG6lFSosOO+pEdhtQbPG1WcgE5v2KIabv/vyavo+kyS6ftALFN2tr7fhbF26BJqmMPpe60BFrq2D51LkO4qh5RRGUHiiFPBmcCF6/fAJgYsJyPPc2BsyLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347666; c=relaxed/simple;
	bh=BtBy59xOBF7aow2+9Ykmws5BzqZM+6UT+vroIb37hrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9olIrZP+2DZCMHYYC1ZPMezb9lbRbQZ8idNGARrP7G0UfsOYXHGI5M9IVCU7csSF4FnbxQYY73M7yC+ql01bp6R+9TNGabAXxZJeKrKDs7Hn9JPWwfadrKa17usvbbm0kp6LDwoKlYZSswhP41A3d+bKqxfQDfcCRQS9hdWwPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zx+Zi5kO; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTV8hCS1vA9VF6wWXC2wCYz9URPeu65jj/GatcQ5yi3uU340gHYdKjkR89TodJjme2gHBHTcqsCUqzsiIoGK9I+Stwhm0KMHdKeBMIQOOcsh2pQAAekiovFxgW1m3merYKTgkMrMyzvBPpJt2H27+5tcObqVhLTkuZoRJLCUCH3dmAetqxf5NOAeSpQNJfBbGgzgnlY+IQuQlYPDftQ+m32deAZ463kI074Tcw5GDeFcGaZr10HOsQuV9WUAA8KNjsEf3kq8FdygVd+lKgK6Qrcgr3pikebZ6zuxxfIihB/uWTlkUS+Y1yi11yHddL1Y5liCekgu9DH9vuNbWgAvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJulEhWPTRAUXifsh5pYXb8CRVMaaDAYxuGCGfNKNe8=;
 b=uXo82BXYRs6O1sAFLTOPAj0BB7Zs49Vu8/nsu76nRsBNutXySpCpI6bFjwcLLrn39+GGmUiq29J/9wtM3l7kqrSQL6tf72nC372K8hb1mGMhYr7YvjE/xKaMKklqEEKaSN9+mjZnlkCZPL38d2Ip0baLQ/J3Q5L31W4bNwVtKl45OM7mELF69rbJ5rfG2ky50wHAZtU6gyqC8dMfZyi+0TWwagw75xoMej10+4Qx12PSyVSHmg33BDIiXtAwkaSLHRH+O9ndbwfPyYoDLLYXE9hYQKZWQS0bEzCbQ8MHZEeYahrvMmtR3yEQvNPstGCvFtpAdanE5dYkrT11mxRRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJulEhWPTRAUXifsh5pYXb8CRVMaaDAYxuGCGfNKNe8=;
 b=zx+Zi5kOYcZpqK0vMOZQcdyNScIV0q6H9E2sPkqstXQrrnSnaJXmuFmGoG7GdKckLBIa855XT3TgjHJVw45KuSGUcSul4jVcCNARfWAow85l+gWq/1AF9YITyDizt8uVNx2NH4lal+TKmIga2GMPNCWLK6fZSW9Rj66LgjaoRnisqZ6kZfyZ3pB1ZaHNPAPn2PeZwuQK3498Rwa3hWxUl9yiQZoLGefkhrfwcqmNqqs6pcfkftJxE2b3TBS/WR8387CLFqIplpk4udhmuRgs28SlvxL432TEAqv274wgCHLpNlHJ3seMwdSWcBVHCHaMTRn9TCHG+IB9l4o22CUjtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7389.apcprd03.prod.outlook.com (2603:1096:820:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 05:27:40 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 05:27:38 +0000
Message-ID: <c7a52d2f-646f-4f71-8883-dea397d97d2b@amlogic.com>
Date: Tue, 1 Jul 2025 13:27:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
 <CABBYNZ+eVbYr4+08-qCccV+2BpUibV7jA55jJti9+PFS_4L1yg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+eVbYr4+08-qCccV+2BpUibV7jA55jJti9+PFS_4L1yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b4d95f-d128-4c0e-1536-08ddb85ffd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUlHUWtPOVBKcmROYmJhN3BVNk9VdWtMOUNpQ1JBanIxTkU3Z20yMTIxY1pI?=
 =?utf-8?B?RWFsa1k3eG5SWE4wUWFDaE5KVkxKWEtGdFBIUzRGNlZSYnFhd1lBQW5WbFdx?=
 =?utf-8?B?VEZVRUQxTEJIcWZyRUZ5YkhxVlJ1Wng0NkErMHFhUWNMNkdmN0pWUUo1aXIw?=
 =?utf-8?B?NDZWeUZSZzRWaTBSR2UySFhBV2xNNVFkcjBvQmtJQzJiUXN4a0FtaG1rd2dx?=
 =?utf-8?B?enp1Z0JwM25OeXg0K3NNMUhQczZmM00vOGsxM0wxWHNoUXRUQkc5VWlTMURj?=
 =?utf-8?B?SFBzaGtBTEJKU3pudnI1RTNDZ2cyWmRUYTc4MVVQOFAxZk1qYUc3NHhJNlJp?=
 =?utf-8?B?VGNjRmhDUXRYRkJ6OXUvS2JlMmNPSnh0S0dvY2MycnVQRkdwNWcveCtGc3V3?=
 =?utf-8?B?UWo4Y0E1QXJURUpidlNNQVFkV3pXN1F1T1V3YlptSG9sZXZVQjBvQU4zNmJ0?=
 =?utf-8?B?alNMS3BvWEFSTWFZbTljL1RlSEdlY3BFYy90RFVBcHUxQW45SVNTRW1wWEsx?=
 =?utf-8?B?NWc5aVJGanhCVkVYVjhQMVBFbkdqazlwTWdGVTZqbml4YjhFaXc5SkN5WUMz?=
 =?utf-8?B?QVRSa2MvSGxyUDRSRXVTUCt0Yk9Hc2hPTlBLM0xUSGpldzhXaFJxNVVNQmt6?=
 =?utf-8?B?UDQ0NDhHTFhxeGhDbXRIdHJNeFFlMzVhVkprM21xYWFzcDhvUFZWU1RRdGdU?=
 =?utf-8?B?M0h1YUIvRGpxOGIvV3R2Z09WSHNTR0N0aEpreXpxZzZhTTBXSmxsb1hBbkxM?=
 =?utf-8?B?MXh6aGtZYVJvRVd1azQ4WVNvcEtBQmxIYVFENXdiNUw1L0huZHorcVVHcGNq?=
 =?utf-8?B?a0JJb1h5aU4vLzBKTC9JeTJuL2ZQOWVHeUZYc3ZyVTFObEFrNmV4eDVrY0JL?=
 =?utf-8?B?TksxUjVWajZjZHE2VUwrRGtjMnBQMmJMSW03NzNvOEVVdE1ZejQwRDZsOVFj?=
 =?utf-8?B?VVo3Qzlqak1JSVR0U0pXSjB0T2NaWnN0bzRoTHkrQW1uYk5XN1BZM3g1b1NJ?=
 =?utf-8?B?RzJxVVdMTklNVlgySEUwR2VLU25zR1lxcGoveGQvYkZXUkdLK2xmT0JhSEZj?=
 =?utf-8?B?Um5kS09td3VBWnlPT3R6SkRlWGRvOVVmL2xwc080bEFvREt1U25GeFk5Q3k4?=
 =?utf-8?B?aEgzVmJrYkpmOHN4YUdSRDVxbW8rK3dUME1SVU1RZDY2WU5iNlR1VVFzV2RK?=
 =?utf-8?B?S3NoV2F1YytaT25XZkxKZkY1QUVTSUdyeGozUG9RcTBUZnJ0aGUrb3I4Tnd5?=
 =?utf-8?B?TkxkcENSNlpqUFUrZjRqd3EvYTUrSW5ab3Z6ZlkwWmtJOXpzeUMyWEpySFlx?=
 =?utf-8?B?dHlNeWxIRzE1YUtEdXRtYlo5Tm5WdWI2SGFaZ0hoR2xJM0ZXaXQ4Nit5Z3VN?=
 =?utf-8?B?T2FIMVdGM1dQZDJTdmQ4WjVQYTliNm0zR0NwOTYvbFNDUGFkazlMMXpNYzB2?=
 =?utf-8?B?Y095WURrR1hJK2ZIcHpPaVpaVTFjcWdmbURtbmFDZUZGa096MGRPd3J2Wk9G?=
 =?utf-8?B?Qm4yZENTZDZ4dDk4Q3I2Vm1Tb2pWVmVTSDZMNmNoVlFhNm1tT1VGd2JadCsr?=
 =?utf-8?B?c3VjL3huM3FPN1ZQMmFwYmVKVUpjcWVOb3h2eHVxY3NBWnRzS0lhK1ZaRURU?=
 =?utf-8?B?eFdsMElnRGxhR1MvVGZXTGNVazhUTUlnZDhYZzZDUnpnVjcyVGxWYXBkZDNs?=
 =?utf-8?B?UmlNWFVFQzdDOXVzRHhXZ3pITmZ3QWJWVFN0Sm1qeVZVbUpRckgrc3ZRVHhF?=
 =?utf-8?B?b2dFeTM2VEx2VHhKL2dPSGY4dmJCek5aWS9FL3cxcmpFdlpmZFZBVWM3Yyto?=
 =?utf-8?B?TzJZWGNtTEY2czRKKzZCeXFPeXJScmswNlJXUWRqNkFBY3FNRHlXSE02WmJ3?=
 =?utf-8?B?cDRGdHpZOU5uTVc2QjE5QW54SDB6aUN0N3BqRXBSSHA4dm90VEM2R2NhRE5a?=
 =?utf-8?Q?awRitNuCRUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2I4M0pOT09ZSEZHZUxMWjJXbTR0UjBrWGhZUUczZUZwbUE4QzNKenBReVdI?=
 =?utf-8?B?STl3Q2E3S0drU3NtNk9pQTR0dWdDTVAwZjEyUlQrbmYxaDBUR2srZmI2cEpE?=
 =?utf-8?B?c0JVWEI1eC8xMWZjVDZRM2J6Zmd1a1FoQTF2dnQ1N2U5QTUzeW02UGFXSmJE?=
 =?utf-8?B?WlVoeHJ3SStxRnpwZTJZL1VtNm8rU1NlSWZzTW5id2VEdSs3YWRyUEN6aDUr?=
 =?utf-8?B?SGVJTHB2L1BRNHA3anpqWDZWeFNKZXJMWlFDN2lJNWF4QitEbnJSSHJONEpE?=
 =?utf-8?B?enoxS2M3c2Z4dkVEbk9rRVRLWUtBV2NiNkd6NGxGRk9ibUNVeG1pY3JqSnpB?=
 =?utf-8?B?WGVONXFXUEVNL3FVNTM2MG4vd1cyYTNkL1hCV2g4SUlCQis4L2NhYlc5Wmd1?=
 =?utf-8?B?UEVqMjBMS0dFcVdCK3lIdHFoUzVta3JXang3ZWx0dXFxNWNXazEyU2NxbExR?=
 =?utf-8?B?WmpiR0IzWHF2RHM0YXE0V2o3bDJ1WFo2aXpjWHV0UVd4Tld2c2YxQ2R6NmRF?=
 =?utf-8?B?d2Jna2VPMkNWTGZHTnhka0xybU93RmRKeVVUVFpwcEJxUjA2VkpLT0ZUNnBU?=
 =?utf-8?B?cTVhUm1PN0dRUXpPdjRrNDRxZ0hvVVJub2xsWXQvdW5tVGJHRWNhbDB1dTZp?=
 =?utf-8?B?dzdpM0RXTks4RkViZ2UzMjJrUndDNXE3Q3laQnJRbUxJNUhJc2xIMDRhUG90?=
 =?utf-8?B?WU9naHo0cnRMZ0MxQms3UnpCVjNKWlB0V1JUVk1CZ0xHdVBjQU92Q0o2clNq?=
 =?utf-8?B?U09CSkY5aDNXUFUvdGh5bTV2MmJqMWpjZDJzYmJQR1d4bVhSWGNZZUllQlhE?=
 =?utf-8?B?eHlOeVNkMDlBQW9qb1kvNHhiUFk0bnFlODllYlMxMTE5WVhMQzJ2b1dPZzI4?=
 =?utf-8?B?VjFBQm96d1RReEpUR3BoaWhJMlhtU0RFbk9KQzZocGNsYnJYTkhIUWN2MnBC?=
 =?utf-8?B?TjlqRlB1WXZYMkdKdVVCbUpPVjZFQU9MazZjcFpTNmpaeWdaY0s3YnN3WVR6?=
 =?utf-8?B?cHVQM1pab2VSbS9XZHZwVy9qaEpqZCtyTzRMT3N6bGpsUTYrUTlpVUtVaDZ6?=
 =?utf-8?B?ZnlIRUs1TVdaWmtFdEpEaDBDRlQyaWpZT2lMcEhsZjQ4WklFRWhQNUFPYnJk?=
 =?utf-8?B?clRiWG1RZCtzQWFxNXh0TWdBdVZ2MkdrQnEwTTV1SDJDa1FDb3lhbmxSdEVW?=
 =?utf-8?B?TkZ5VnhQMThLdURTNUhZZkpFTUQ0OGRVamV0SFNkK1ZqNG0vYjNWSytkWWdP?=
 =?utf-8?B?eHY0ZElpaVhHVUJzRU5mSlRPTTd0anRIcERYTXBFRkU0c212TTdCeDNGVFh4?=
 =?utf-8?B?UGxRY0UyTXF0UHdBVUMzUitOMnI2dnBsRWxjRG9UWXdKcEhVcU1LRFJOUWdx?=
 =?utf-8?B?d01aUnk5cjdZdkN4b29PUkcxS0YyUFVRQVkyRzFXUG9DeE92RVlNTFZ6alJU?=
 =?utf-8?B?Z2tuYjJ1MVRyeUJ2aWZQY3pQdnFNQnNKQjJBUE5aNnRNbEtPdUwzU3RTeW4z?=
 =?utf-8?B?NkJtS0g3bmdvQlBxSzdCSFYzYUY4Smo1dXYxRjZLRTZSeDVXc083WVA5L1Br?=
 =?utf-8?B?VEpUK2VzZm5zL091bXBOOG85Wk5ZT1NVVWJ5dzBRTlRjdWpmazc4Q2RvRGhE?=
 =?utf-8?B?SmtCYnVXZkU0d1ltMzIvcm1lRWtJRU82enFKZXUxRlpsQjN1VU5SM1NqeHFk?=
 =?utf-8?B?bHNlMkJVNWtaWXp5Nllpcld4Q2JweTN6azNLMFJJOTV5V2IxYVNmVVE0Vk1p?=
 =?utf-8?B?eVBQUTRPa1pua0lIQ3RlMVZESWxrV1hwOVVIR3hoZmF2RHRXNlJ4SHR1ZVFE?=
 =?utf-8?B?b3pEWXJKcHk3NXdoTWVFMCtOSFB3VXlhUlVuSXFKbmZ2SkJDbDVXd1RVVEZD?=
 =?utf-8?B?T2t3YlRDMkY5eU5GU2pKV01DdEoyNUFFZnRNVlFkaHRzcHJuYUhBTHQ2ZUJW?=
 =?utf-8?B?VTRjdnc5U1lPMVcxU0Rpdi9UcFpwUjQ4WHhNb3UwQWlWR2RJWjFnZ2xsUU42?=
 =?utf-8?B?djFXdVRya2dhMWFWaWpzQ0lwYVpqS2RVRlJCeUoxMlZDTjdmdWVqS1M2SlZI?=
 =?utf-8?B?TWp1Zk42LzcyYURNa0NCcEI1cHo3YmpTRmQwN0tITEpET0xTNnZuSVVrUmE2?=
 =?utf-8?Q?N39QqTDHaHAPD9rzEdVS7AYba?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4d95f-d128-4c0e-1536-08ddb85ffd59
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:27:38.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqjb2yHCppPmt73dLcWGhEQm5sNDnYotfKVk5BKocV0kf/kqC4vCMkJRbWod85I4DY4+V0gLFTjDRvOZndFxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7389

Hi Luzi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Mon, Jun 30, 2025 at 2:45 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>> event (subevent 0x1E). Currently, this event is not handled, causing
>> the BIS stream to remain active in BlueZ and preventing recovery.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Delete the PA sync connection separately.
>> - Add state and role check when lookup BIS connections
>> - Link to v2: https://lore.kernel.org/r/20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com
>>
>> Changes in v2:
>> - Matching the BIG handle is required when looking up a BIG connection.
>> - Use ev->reason to determine the cause of disconnection.
>> - Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
>> - Delete the big connection
>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
>> ---
>>   include/net/bluetooth/hci.h      |  6 ++++++
>>   include/net/bluetooth/hci_core.h | 16 ++++++++++++----
>>   net/bluetooth/hci_conn.c         |  3 ++-
>>   net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 82cbd54443ac..48389a64accb 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>          __le16  bis[];
>>   } __packed;
>>
>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>> +struct hci_evt_le_big_sync_lost {
>> +       __u8    handle;
>> +       __u8    reason;
>> +} __packed;
>> +
>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT 0x22
>>   struct hci_evt_le_big_info_adv_report {
>>          __le16  sync_handle;
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index a760f05fa3fb..5ab19d4fef93 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1340,7 +1340,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
>>   }
>>
>>   static inline struct hci_conn *
>> -hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
>> +hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
>> +                              __u16 state, __u8 role)
>>   {
>>          struct hci_conn_hash *h = &hdev->conn_hash;
>>          struct hci_conn  *c;
>> @@ -1348,9 +1349,16 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
>>          rcu_read_lock();
>>
>>          list_for_each_entry_rcu(c, &h->list, list) {
>> -               if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
>> -                   c->state != state)
>> -                       continue;
>> +               if (role == HCI_ROLE_MASTER) {
>> +                       if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
>> +                               c->state != state || c->role != role)
>> +                               continue;
> We don't really need to compare the address anymore since we now have
> dedicated types for CIS and BIS, Id probably fix that in a leading
> patch since that should have been added as a Fixes to the commit that
> introduced the separate types, I will send a fix for it just make sure
> you rebase your tree on top of bluetooth-next.
>
>> +               } else {
>> +                       if (c->type != BIS_LINK ||
>> +                               c->state != state ||
>> +                               c->role != role)
>> +                               continue;
>> +               }
> Then all we need to do is add the role check.


Yes, I will do.

>
>>                  if (handle == c->iso_qos.bcast.big) {
>>                          rcu_read_unlock();
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 4f379184df5b..6bb1ab42db39 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -2146,7 +2146,8 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
>>          struct hci_link *link;
>>
>>          /* Look for any BIS that is open for rebinding */
>> -       conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_OPEN);
>> +       conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big,
>> +                                            BT_OPEN, HCI_ROLE_MASTER);
>>          if (conn) {
>>                  memcpy(qos, &conn->iso_qos, sizeof(*qos));
>>                  conn->state = BT_CONNECTED;
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 66052d6aaa1d..f3e3e4964677 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3903,6 +3903,8 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
>>                  goto unlock;
>>          }
>>
>> +       conn->state = BT_CONNECTED;
>> +
>>          switch (cp->direction) {
>>          /* Input (Host to Controller) */
>>          case 0x00:
>> @@ -6913,7 +6915,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
>>
>>          /* Connect all BISes that are bound to the BIG */
>>          while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
>> -                                                     BT_BOUND))) {
>> +                                       BT_BOUND, HCI_ROLE_MASTER))) {
>>                  if (ev->status) {
>>                          hci_connect_cfm(conn, ev->status);
>>                          hci_conn_del(conn);
>> @@ -6968,6 +6970,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>          }
>>
>>          clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
>> +       conn->state = BT_CONNECTED;
> Wrong line, anyway I have fixed this upstream already so you need to rebase.
Got it.
>
>>          conn->num_bis = 0;
>>          memset(conn->bis, 0, sizeof(conn->num_bis));
>> @@ -7026,6 +7029,35 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>          hci_dev_unlock(hdev);
>>   }
>>
>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>> +                                    struct sk_buff *skb)
>> +{
>> +       struct hci_evt_le_big_sync_lost *ev = data;
>> +       struct hci_conn *bis, *conn;
>> +
>> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>> +
>> +       hci_dev_lock(hdev);
>> +
>> +       /* Delete the pa sync connection */
>> +       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
>> +       if (bis) {
>> +               conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
>> +               if (conn)
>> +                       hci_conn_del(conn);
>> +       }
>> +
>> +       /* Delete each bis connection */
>> +       while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
>> +                                               BT_CONNECTED, HCI_ROLE_SLAVE))) {
>> +               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
>> +               hci_disconn_cfm(bis, ev->reason);
>> +               hci_conn_del(bis);
>> +       }
>> +
>> +       hci_dev_unlock(hdev);
>> +}
>> +
>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>                                             struct sk_buff *skb)
>>   {
>> @@ -7149,6 +7181,11 @@ static const struct hci_le_ev {
>>                       hci_le_big_sync_established_evt,
>>                       sizeof(struct hci_evt_le_big_sync_estabilished),
>>                       HCI_MAX_EVENT_SIZE),
>> +       /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>> +       HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>> +                    hci_le_big_sync_lost_evt,
>> +                    sizeof(struct hci_evt_le_big_sync_lost),
>> +                    HCI_MAX_EVENT_SIZE),
> After you fix the comments I do expect some code to introduce support
> into our emulator and then add some test to iso-tester that causes the
> test to generate HCI_EVT_LE_BIG_SYNC_LOST so we can confirm this is
> working as intended.


Sure, I'll give it a try.

>>          /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>          HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>                       hci_le_big_info_adv_report_evt,
>>
>> ---
>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz

