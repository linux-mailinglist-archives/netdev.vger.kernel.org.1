Return-Path: <netdev+bounces-186518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC6A9F802
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E361887278
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C25279787;
	Mon, 28 Apr 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="ebOEMITd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2126FA53
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863522; cv=fail; b=Yct1RPQtGcHVvL8VoxXsntTx6xXbx7mqaRzBtyQrwL0x77kKDJZlUf2sBYPRNATL5xSmvXKUAWbn3rDgcURI/gRsXZ4RV3izqbDLBXYipZAOx+vyi1kelxpiqeZFJo0d91PDbgvoSuyPUubNUyBNQnMTufJRhdaJ5bhVz0zgGj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863522; c=relaxed/simple;
	bh=G1LoK3qYTKgkTHOR1ZyrgHnFIMNVwsqwn+aKNUrXV+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L0Co8rOaLDAe8TEa739rfP83xJT2f533QQFg2jkFBPects9k6V2FqUPxLOvsDptnDBgbwTRso8qdP02J2opfcu0020+LYmsLSN/PT424n57Rplg211qKDXb00K6smb8J3GMQteBRie6RUzrKBFSWivSzttRnfeiwGaE28evj0dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=ebOEMITd; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1745863520; x=1777399520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G1LoK3qYTKgkTHOR1ZyrgHnFIMNVwsqwn+aKNUrXV+Y=;
  b=ebOEMITdyUKhvnZQuw9mr2LXT+Gsxyr4hZd5JOEnSiFh6DnsjcQfg2Ic
   1fvEoPV7QxzF0jCHLxBCwo++aYyxGalNllqp/x0dVGkdTbqCmB5JagMHm
   jVqMSBOh3S4kHeCOtpYOrtANc5eGPdDKJzxW9LN5dqBsuD1heLyoF6K6Y
   o=;
X-CSE-ConnectionGUID: MmoST7nmS4y4Nggu3t9GgA==
X-CSE-MsgGUID: dLG4LDGAQ22eYj/eR2bkHg==
X-Talos-CUID: =?us-ascii?q?9a23=3AiDFtjWqFF/9q/6z0Wl0LiafmUeUgdUbhk3HVGBO?=
 =?us-ascii?q?pVUBmR6DOVQ6/94oxxg=3D=3D?=
X-Talos-MUID: 9a23:yfw37QukfOol7QgK9c2niBVNaONEzI2XUhoAoJdBtvPePy9QNGLI
Received: from mail-canadacentralazlp17011052.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.52])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 14:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoP9WpJHBgYOiOGMleXGwL+rDddppk3R+Bj3kDyFrPRIBfRv2KtTX7Qt0nuFa611hDbrmFwz01rFDuuauuUMry2SgztcpDs8VnGfGO/n+K4Uwi2hH9j3kRoRRol3yJDb6obLOYqpzUD5UYHSss+L2W13UKAcv0oIEDj3n1iRw0APRfZ5cWCPR2n4g4JLAvvBqiEBaIVl9s4Xw8A+6F0CAgCN4oUuOZZs4NyhM2zFSrvaQlIIg4pkL+AqfuFW6n3F47uA5C4BP6qPLKXxmvNUj7+ADH8k3pyBKGl+gPuDDupY9deHnH1Vb5CybG5roBWGkvRsAqz9N5RjyLrBNAueYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djb805ST1ObnN7zNUYTsKQY1nRnQrBIgSQzKEasudlY=;
 b=BeEF/8HpgwPQjDsnSGgRsnWdqa5JFt/VxbxqrONj4vALpBwL0E4YLE0P/FVBeV2nVCR17pFLV2guIwI8Lih54AvkI3kg/Dkk/HXYsK1Qlixr7VvjbCwdZyBeDrKMDJxE1kzm+veXTW63BwugV8M3laxaI6KpMR5kyFII4djwpC75JG/psG6gU1Cf+vPf0p5JK65/Yb3TMlGEzeFgFfrTT9uybui0DtZR8IJfRq5ZmMAPMy+Rp0ULS4gowTQ1eEzk8Z9pPz0kIkPTPLoQGSco3TnJ9YBg0oL9X6TskeFQB40YxBFclHwj8Rzqdw5r0K5PSZ6F1Ez384z+zn43vlguAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB8568.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 18:05:14 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:05:14 +0000
Message-ID: <b65404cb-cd51-40ad-a6a0-d7366391da7f@uwaterloo.ca>
Date: Mon, 28 Apr 2025 14:05:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com
Cc: netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::25) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e95bd06-82e3-47a0-8e25-08dd867f395f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djhmR254S1FEd0xQMmRNUjdWa2JBUTRtWFVTak01NDNlNEM0Q2syWGloeHVQ?=
 =?utf-8?B?ZUIrVXcwTGY5MWVMQUVBbGdvSFVOd0V1UW9IVGI2bGRIK2Q2WFIvSnJ5ZjZD?=
 =?utf-8?B?YjUwM0NrOEVtOE45QnNIMFd6ZmxKdGhqVStvTEdvU29GRU5Ub0k4S3lRWmY3?=
 =?utf-8?B?ZWpiSFgyZnJiYzE3NU1YNDRMWGY1ZTN2TjhoeDVlajhmZUw1R3pkdGlBTVRo?=
 =?utf-8?B?bXU3Q3htVHZvbTBDUlhrYWFqTytnYXpRbUJVZVp6RkduMk1hMHlXZWhMbklW?=
 =?utf-8?B?L3M4OHRpSjRxdmo1TThPbEpDdWI2aXpLcER1KytvbnNiZmJJTUorcCtrYnQy?=
 =?utf-8?B?d010RUdsYjJoempiVUlVT0JVU05XSzNjcmhoZm9zRlh1YWx1cTlJOWtZcUpk?=
 =?utf-8?B?VHlpU1lvSXJYeEpPSEExendFTWF6bUFUTFdJcEJhMzNDbUJPTWxkWjJpTEVY?=
 =?utf-8?B?VytLK2dZUHBhdmdzZENGTnFYWDR6eFFzY3AwVjB3a2ZUL0FTNXUxbVFKV0ow?=
 =?utf-8?B?SDNKSlBiOGI4VllwMDIzampuRjhrYnFGSXJjdndpWFJWbGx0U2ptK0xYMFRI?=
 =?utf-8?B?N2lWTWhsbmRNZDJvN2NidkFDTUxmdEVqS1MyTmZtcTlOdFpzUm5oQ0lqc0di?=
 =?utf-8?B?aHkwTXMzeTYrNVJOMHZyYmhiQkw1TnBPUm5TU2VCbzJlOG10QjMyYW5HRE12?=
 =?utf-8?B?STgzRW85b1hJckQvSFFrL3dYTUFEeDJOVTVyelh3ZFlRQWk4SG96SlllVTdr?=
 =?utf-8?B?elhvMTZNaE14UGI0dTBQa0p4U0NMSElKK2F1aHREM2d3M05FbUQvOXdqSGlh?=
 =?utf-8?B?VEZsdzJ2TGJiWnFyZG1vYjhuNmNyN0JBVTZzOU9nZUlDTmhpNWM0OStUcW1n?=
 =?utf-8?B?Z2d1RDdnN05ZUVB3VkwvSXdGd3Q2SElMOXUrQUdNMEUrRGxnZkdxaVZuWmNp?=
 =?utf-8?B?WEF2NUZ2Q3VuQmRpcWlFODJLY0ZrK1NZZG00cDh1WXRYbzFicmd6dWx2ZTds?=
 =?utf-8?B?RTFFSkZYZ0xMWmZwN2tWSFNJWjdQaVkrRXg5MjNzQ2xqVzVDaXhDNFgvaVE3?=
 =?utf-8?B?eWdjallLZVdqWjlyUkhLVW0xdGp4YzE3Q0kvd3FQYXZQVGtkWkhTQTVtOEJZ?=
 =?utf-8?B?YUdFeDVsdkFOVld5cE84b0JrYU1lcXVhQVd3eGtab1M5Q05RTU9iREt0OW9K?=
 =?utf-8?B?bC9QK0tvY3E3WHVwUnd4TnduRXNuMnh5V09xMVUyVC9WZlNpRThNUFFmdmlV?=
 =?utf-8?B?eW44akNYNTNCWjVBM1NXWFRGcG1HR2VkSjZVWjNONkY0WjBUdEYxU2dFWHlo?=
 =?utf-8?B?ZkM4VkpNZGlLN3lzZEltY25jZjNOYXBxNkNxL1RqcGg3UStwMEhMLzlINmRQ?=
 =?utf-8?B?NWE1RVpraU9NemJtMm9md0pMYjNJbWpjTVdsMHhGNFhHKzZTTGZlMC9OVkZW?=
 =?utf-8?B?WUlDVVV1ZWp1aFdGaGhjZFBkQnlZNm94RHFJaVBmajdtbVlqMkFqRGFyZ2dQ?=
 =?utf-8?B?MmNHaUloZ0FQNGRMSTNnL3VjZW1EOXQ2SFBLcGhtaGtwdlZaQldqaUxJSEY4?=
 =?utf-8?B?S3NxY0tKLzR2WXQraktreFNoT0pQanNpS1VTQzZKMUFVZ3RmbWJwaks3TC9D?=
 =?utf-8?B?N1lWbHljdy9xN0N3VHc0c3lFd2ZPV1ZXRFVBcllHVkcxYWxVaHZ3WE9FeGwr?=
 =?utf-8?B?Uk9mWmJuRHcyOFpWZlI4K04zcFo4ZWxheGZNKzk1V0M4bTBSZHdzZlZ6WHJO?=
 =?utf-8?B?MldIUVhRMjRPRVpnMTBmU0lFZzFpRHpIb01FNGc2UitMeGFxcHFUb1lmcmlw?=
 =?utf-8?B?TCtDQVhPZTlnRWZTY2YvSnhvU2w2NkVMVzQ1cVNsdGgyclNTdVUyay9CMk5R?=
 =?utf-8?B?cTBtWVFQLzlxai9PeEhYUVpPTEdveXhkRVE0d0g0c1p2a3poK0E3YW8xamk0?=
 =?utf-8?Q?jh3wF0Y78jU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1hnR1pXZnVKY0lJV3ErR1BtYmpiMGVJcFR6OGFmRUtRZ3dGbjlLZVlSRGh0?=
 =?utf-8?B?V1VHT212RGx6dzgrMk1iak1WZExFUHZJdXROV0E1REJQdlpqekhzdzhtN2sz?=
 =?utf-8?B?U1ZEbzNyL3kyMjREeTE3a2tWL1BseXBPSmZhdHpSY3IxNjZCYlBieUlJU01C?=
 =?utf-8?B?ME0rdERicHVDNmxLSkh4bS9SZEcwK250RGNMME0xRVZMNUZZRm1Xb3RMS0pt?=
 =?utf-8?B?ZUY3Wno4c2RGWUJXdktOZkNMT3JlZStMaFBqNVFoOVdxOWx3dG4vMk1XRnBP?=
 =?utf-8?B?WVVwTHU4ODRNMUV2K3Ywd1MxSVFYZGpVSU9UR1FSOUIyQkZWV2twbVdZaW8z?=
 =?utf-8?B?djZlZ2Rta0w2ZEtFK2swOThzZTFSeTIwRmwvY3RTOFN6S0FLNWlwQzl0cVNJ?=
 =?utf-8?B?TGs5N1RBMVgrbFFKd2s4TktpVzlPcGNBWktMcldQRTF0OXlkaGtqV3pDZDZx?=
 =?utf-8?B?K21OVEt0MUxqRWVneHo0TFdOYVRkR1RsVVBYTjErMTRZbC82K0xXUFFqU0d5?=
 =?utf-8?B?VThqb1N6ODNFcFRYSUhkOWlTWEx4YlFTZ3RrTEVGY1ZIclZGVmQxRTlRdW1G?=
 =?utf-8?B?RHZNbHBlTGlkU211OVJQYjRmSTg3NlprS0l5MlJ1OXRDc1BPOXUyR1lqRFUx?=
 =?utf-8?B?ZTZYNjFsLy9sMTZkU1dPZWdaYSttN2FMai82d0hRWGZZV2p6bE1HUFRhSmVt?=
 =?utf-8?B?aUxob3pyWWdVazI3MllKVzA3ZTlGNDlVM21QZWgxQkVUU2F1eUwyTkY2UnAw?=
 =?utf-8?B?Wm1xUmg3djROcUNRR2xIWVd2QWNZVVlZRjJZa3VGMndOazVFME9xWmFwNDBY?=
 =?utf-8?B?VkFiQXk1bUgrK2ZpZDR4N2RXMGdvbGR1R04ydkVYZGJqQzNaSkMzK1B6dDlq?=
 =?utf-8?B?QnRKSWJTV29JRTlwb3JKcjBWc29iZVE4c0QxVkxiWHpvOWlndTB5NGVUZTBT?=
 =?utf-8?B?b2hTcTY2VkRic3VXRTB1cHF1TnBUQm0xMkF2TDRxRDl1TzBtNXMxb0JMWWhL?=
 =?utf-8?B?eXB2Y2hoMVpnOUV0Nkx3OWswZ1Z0ODVpY3dZTUhCL1RTeW93eWdPVHRqaEFo?=
 =?utf-8?B?eU9wYWRBUG1HbnVNS2VLWk44M1VJQ0RjbVNjd1BnQjZsYnZwRWdCWGJsR045?=
 =?utf-8?B?NXRUcTFXcTFzRi9kNDhBa1hVRzhkL1VzU0hoOVJTSDRzL1l1MURBeDhiS2h3?=
 =?utf-8?B?Z3F4SWIyK01kZlJFVGxyNlJDWktQSzYvWUJOek1NVk1uTnpDbnB1aU1DQmhB?=
 =?utf-8?B?SUtIU3oyUWxVdzdZUnRCdzNja05ucVZsSThhR2ZFSll0Mk5HOWI2WUNwUFcz?=
 =?utf-8?B?UWlVK1hEZ1dwZTdUbHpUNW5qMnJnRWRJaXZ5MFIzVjlLb3RscDNwb0R4V1ZB?=
 =?utf-8?B?a2JJWllod0pSbFpvbEhJeEYzdWdOV2o5UGk4UFo0QWllUXFWUnlaMUN4ZDd6?=
 =?utf-8?B?MFg2VXZDNFUwdGVPSGxaK0tMa0M4Tm40N09zVzZ2L2VEUHY3T0RyNUwrVkMy?=
 =?utf-8?B?NDdKcGl5Umd3MkFUdkRtNjJhUmc5bUdONG9pS2l2SVpDeGdQSEZpNi82WVB4?=
 =?utf-8?B?M1FndFFLWnlDNGRESVJFdHNPVjBIdU5ockx1a3FTL1ZLanc1SUFFN2xHZTg2?=
 =?utf-8?B?VHJxZHlUTDIvS3RjQkhzTWpocTNDMFdFMnRZWE9WT2toRVA0OTFyNzBXTW5W?=
 =?utf-8?B?d09TMktoWGZGOVhySGNQV1V3eUx1d3dEK28vd2J6UTdURDB0aUU3Z1Y4YlE3?=
 =?utf-8?B?TnQwbGlHZnI2SlZsTUh3TVJQbHRSUFFLb2swZ2dPNUdLOFM2OU9RYVdDYnNN?=
 =?utf-8?B?WElVNlc5THZ5NkRsU280ZE1LNEFyWUYxRTY3TVp2dnhmOU1waE1QaFRraDBI?=
 =?utf-8?B?NG5DeGVPc0dsZlBtQW8wWldTaFYzVVppalpuQXN0djJoeHNaL0xtM2V6VFk3?=
 =?utf-8?B?NmE3aVVCclM2K0oyWldpVDhEODZpbVowV01kU09xUFZZb1JHYkd0a0traGoy?=
 =?utf-8?B?ZlhMdXpURWtqSUVYSDdBOHlWSmgxOXU5aFo3TzBPQjNmSXpRWlBNaUxxVTRv?=
 =?utf-8?B?Y0FkejVjMzU5TE1SNVhrNG1IbWd2aW5hL0pUeE5DYjFBQjl5aEVQU1lHTlRC?=
 =?utf-8?Q?H5sCuunpoIWngEDu7cUG6sBUS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFXJdVrmvBF2R88Hk1pyJdzpx5jlfGt8LaWD8zK5Thwkk5I3WOVCyupX6f/UicfDUGDtMcu/ruirA6H7Dau5T6R+4IeSZkpJZY1nSITA5NGJK/UNbBVxQEM5ZS68Qh1m6k0YWZ9C0PiQZfN339jLolerA2Bp1aQP0tTlHxnt0uy/7/siwM+mHdTDtvdv0EvehbsSrjHLUiBYpZJKtISdqL6SC9wQZEgi0AgLTCHH7ceXBojJk7vLKGRrbZuStJoxXIrkW1Xol7BTLUiWSxwia5SayDWj4S6Xc5ospiILjlcqcGKUBmemuudTNukZzwXKQ4vXhSMlZLWtXaEb0h7HOc4H9cmIrEqNgfV2clNs0274ZlyeMNNMzVJeYBZ4Uz0KuSYo7nzGRPAe0pNrhX+EDQPJkuFZgrdzllbD+JSho11UNF3rSAsYwlKoTV516b2/KwIWWP63HixcDTFjDcUsFR+DpY/JYbRpjMho/Beh35S8vuipaj+7GcgPMAopXGeNBJWBC94gWE4ROOiPN9Fp4pqD/qtwZ7kPGJVMbdmip8Q+3gts5sauNRWBzvC1sHFBbAj77+RwqErQkvF53dZi8wpbC5Je/axlsdBWE4dgQov5RfZ1AieU8dDRZdrSvV0C
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e95bd06-82e3-47a0-8e25-08dd867f395f
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:05:14.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utG41+6FNsDB5Dq7Db1U5bsg0eabG94tqMSRgiSJ+GqNtiEsFmGsiVQjzHWxA198u2gmgbh9XQki3UH8k2ePbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8568

On 2025-04-28 12:52, Willem de Bruijn wrote:
> Martin Karsten wrote:
>> On 2025-04-24 16:02, Samiullah Khawaja wrote:

[snip]

> There is also a functional argument for this feature. It brings
> parity with userspace network stacks like DPDK and Google's SNAP [1].
> These also run packet (and L4+) network processing on dedicated cores,
> and by default do so in polling mode. An XDP plane currently lacks
> this well understood configuration. This brings it closer to parity.
I believe these existing user-level stacks burn one core per queue. This 
scheme burns two.

