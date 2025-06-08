Return-Path: <netdev+bounces-195537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1EAAD1142
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5619E169BA8
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 06:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A311EFF8F;
	Sun,  8 Jun 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ViEJzcTC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59896A55;
	Sun,  8 Jun 2025 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749363494; cv=fail; b=SNw8XTZUkNpjClNZb6lfi9hliEWVhLplPbUI4TFGYf6G4PQi5OITBV3COBC/3zGRD6q+klOFZOURGuBZqIHSBx0ZR7n0qnD/N31r6T4yS95Ekqn9dHsWlaGOAjZeZFbzbJWOFtn2dQI+x3Sju+JtDc1HU1dVOvNhUzxK+wt499s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749363494; c=relaxed/simple;
	bh=wfaT+kR3Dd/Z6d6tNqYxpIJ1aS58NFsjZYoW85s0g10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UzgjYjhBz8bt9BOPeizO+1SHUIbtkVmQmemzJf8d5AxipaC6GyzZHM0Tu8fU7SrJMcGQIZdCrGXYdZ2lQKKyznkK//GW/6qvALDM6beWr+B1X92+lOwTMFM4I9d3DSwVm/GFV1fozbMtzh1tR5QT2SFO4W8pW1muJGH69qdmFME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ViEJzcTC; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVSFUP8MiSXsRkeEaRSs5aG+iqtXIiPyCxvO8wjj1MW1xPufvFhMXX3EtGMS1q0D5oXi5PmfVpIWM4WuoLrr270m4DT7jWkgTexpQjedzAZD1FVB25/0fUQZRCh3D0/5R+j3NIJXEh8ZdSCaiNjgDDj49V8E4vgVfuZG2jCtFzjL1ssnG6tQ5hRdbl6V8yjEbmataWVcgWZi0EQfmdNZDSE35BcN3nAA2WI1alsqTOFEHkCk+B+ht4QNDjWDmfEycJNUTVbRziF90qUoQ/aVY3hkbr8gKzi/WQX0uckRThLZv/+W6NwL5xnEAiTq16yYZcGYA9kcPHbfV0Ns+DhzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfaT+kR3Dd/Z6d6tNqYxpIJ1aS58NFsjZYoW85s0g10=;
 b=Bc3N7eppsCTfifbLUc+fUmz9R45OvXVVa7XfY7CcnJ51X22OWnEFlcTyWZgQ19SwbOu73nrrbN2WTEu8vm/0bvEKsFOD5HjskK2fUnV3lAedAYu+pw1x4Ej2tkD7DRATvXtWrJ3Erf2EN7qZA/OXPOKBxER6NFSErZiD4imTgmwUyP4st07imdYsX1nbTV6hq9O3H/0ZUZsIApjWLveYCD8vTiUmlckL2XWUdIbRwSNalwUxNrpYB4ZH+FdiPUxrWVFHjaws8Ag3bB/LPPts3Bjxer6kHeB41hPsYqp1KO28kVtad41Po1dK3cu9y3tc3cEN0/SoyZW6biXe1ApRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfaT+kR3Dd/Z6d6tNqYxpIJ1aS58NFsjZYoW85s0g10=;
 b=ViEJzcTCB4ZU3jYgamOg2UWb3FXIMoVfMUQEJ0HosfC1sLiHIzXNm5k5ASrLR+GOvntABUU4ngj1n15Vaj+qDsAfIZ96ZFI68rcBfdBeS30VN1TPFV8jkyn16oDiNXCfS03/cQCI02wljfIfnLThq9o98tNi/8PL+0d27WEjh9tkLAgUMts37WBjsPnTCtxHEEh/U/DPyNyxRLVeUFcP5r7SV7xntOaw6SCiCxYic4S9ZJr66FbIlfNgdEI9g9z/x2hm2jujN3bZwHMPseisv+818YcSlBLQxP7tju+FPkkzGRTIf+x4c2bEk0dMGK5eyWBKOu4V/O7C+ssDUTb5qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Sun, 8 Jun
 2025 06:18:09 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Sun, 8 Jun 2025
 06:18:08 +0000
Message-ID: <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
Date: Sun, 8 Jun 2025 09:17:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
To: Paolo Abeni <pabeni@redhat.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef4dd61-4775-467c-28f0-08dda6543cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhjWEZyM2dlWkR1NlhTeTdaNXNXNW5SeUxvaUwwLzF6MVpPK3NoV0h5UFFR?=
 =?utf-8?B?aUx2Wmk2YVlnWFUyNTNPZ3FjcktwTTFnbHhOWmwrVTgxam1tdVdreG45d0JL?=
 =?utf-8?B?OWl0VFJXc2lsaVd5ekpwV1NTQ1ZhaEtmbFZGdXNMQTRWWk1HbDFZTlJObGhk?=
 =?utf-8?B?Y1dmcEg2c0RUcnBzZFd1Nmd1eFA1czVya0RZZTF5NytMSlZLKzdxQm15MnZE?=
 =?utf-8?B?dmF2eU5hWWhqMnNtdGZqV2ZnWjZ5Q21oQ3RFR0Y0Vk56OWRrTVlBcjM3T29T?=
 =?utf-8?B?ekkzUEVuTHgvd3YwWnlnbHRmQzl1a2ZiTXhqRzZDQlByTmkxM25BemtlRlh1?=
 =?utf-8?B?Zzh4Z0FqTnJhZlpZQi9EZ0o1MkROWk9oY2dmN0FGRTE1TVlpTmdrbmFUbnZu?=
 =?utf-8?B?M25BQkxmbU5RWGF4UkVOQWlUaDFGUEdDSnk1TEVMcDFKNUZMRTByVEdMcDRH?=
 =?utf-8?B?VjNlOEptb20yMUR5RmZNTXplUTRqOGxqWXdkbFRnWWhKUHVrbklWT0lRdll2?=
 =?utf-8?B?YnZxMGZ4MDhqNzM4anJwYmhGNko5dDEzVTBsL1JhODBhNTlyaHpoRVE2Q1Zs?=
 =?utf-8?B?ZlYrbXhoNmdoRlZiNXl1bXZVR1VpN2s1aHNvVTIyTkJQVDV2ZHozQUM4RkZl?=
 =?utf-8?B?Tm5mbnp5U2pCUGpEOXlOU1lqdUtZcEduaVJyWUdmeUpRQnR2cGVLaWxYUEFW?=
 =?utf-8?B?SXBYVG1Razg5MG1jb2ZPSUdzSFIxQWJlczVqUU50R3pCeUZKL1N2S3BWK21X?=
 =?utf-8?B?VDRFb050TXloakd3QloxNGdzN3NSNDFUMHdvcXI0WmFuVkdmTHc0SkJReTRi?=
 =?utf-8?B?dDkrT242ZGVzRnhUNlhRR2ljN2xQNXZQUmg5M3NSd3VZSTZsWWRMVmdGMW44?=
 =?utf-8?B?ZmQ4TEo1d2NmZGN4bmEycGlJbVhUVXVGUnh4eURKdnYxSW54L1pwMmNoZE92?=
 =?utf-8?B?NHFsQ1VITG5WVjdkZSt5QXBvWmNOV29Hc1U2eHNYdThoWk9DUk1SVlNuWVgy?=
 =?utf-8?B?RWEyc3p0ZlJESVRpSFowT0g2V0YxTVdjKzBsOS9QQnZMSHIrRnpJSGN2Qldo?=
 =?utf-8?B?cWVhV0lOcjlnMGhrM2VUSERYUVJFcjlUYnc1ZmlHUU9Jdk1qMDZrdDMrcm42?=
 =?utf-8?B?QVZTMHA1cGZ2ZFhHdDlVaEg2ZDI5ZEEzQXVhYllvSTRRbWJTTFluY0twZjVl?=
 =?utf-8?B?SmJ6YldTL3ZYZlA1Z0FTN3I3bXBUR1BVeFVpeHhBTDc1SkltYndHSDhET1lu?=
 =?utf-8?B?OXVYanFRU0FWQkh1SWp5YlNVcnFMR3d3anNJbnRERWN5NzJSRUhrbGRtN1pm?=
 =?utf-8?B?Y1g3MWxZMGlRMW1nUG1UVEU0MnlxRHVSU043M2J6R3JZUjFrTi92a0MxZlJY?=
 =?utf-8?B?L1RVWEg5OVJuSERGd1Z2ZzQ1NitqcVUyaU5Td2hickpJSG1TNXZRNWZJK2hB?=
 =?utf-8?B?bGpzZmIxVmRxZnRQa0piVjdsZFZ6WGp2NDMvSDMzQ1NPSXFkM1J6VS9BUXBV?=
 =?utf-8?B?SXhXUDFSMlhFVEkza2Z2Z0E0ZHZYclZ6RC8yV201MGlhVnQwbUczK0Rzd3dh?=
 =?utf-8?B?QWZGdzdWQWNxUlZ4ci9NdE85MmNWQTBFaWoxOFA4WmZCRnQra3Q2cUZ3d2d4?=
 =?utf-8?B?VHROc2c3eUZwRjVzdmJUUEo5dnJRVmNQeG5NbXdTUmdaQ0VhWThrWnA2SUV4?=
 =?utf-8?B?djV4YWRBeEVyR1JXMEZiOW1XNlR1UmVQaXQrMXl1a0FrdGMwZXFWeTc5Uy9w?=
 =?utf-8?B?c2ZJMGZoNHdhVWx0SnFERThWeW5rLzF2ZHlXd1d4N1kxS1hMa0dpTnh6S3RN?=
 =?utf-8?B?RDIzMTdRQ1VPQVBoYTY1cllvQ1VheThKRVEvU0xCWmliZjRvd0hHNHFJQ0JW?=
 =?utf-8?B?OTVJREdoTFRSVFlGMWtGZTdvbk1ya3JNL1ozWEZzNkZjRlUremt2WkpvUGhT?=
 =?utf-8?B?R2RrZ0FHNndUSzJCQ2pNS1YvWXRlKy9LdWNyMjU5OUhzVnZLTzZWVlRxczM3?=
 =?utf-8?B?a2R1OHZUcXNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MExBVXhOZGhZUFkxUEhWa081U0cyMDFka1hFd1J5b3E2aFF2N1JGck9tRktR?=
 =?utf-8?B?eGVwRGRQNHlMOGQ1SVZpOGtWK1JObU5ic2thQjB5dkluT0hhOFBRVDdFbUdH?=
 =?utf-8?B?TWNMZFY0NTl4TjdqWWpuMjYzVlAxclNYOFNPdm81UmhnL1llTGRXYzc5U0tw?=
 =?utf-8?B?ckt2dlhmbHkxakFvMFZ5SCtrV1pzZXdqYUJJQnJPaXIrWGZ1Yzg2bFUrWHlM?=
 =?utf-8?B?eE5MZVkvTWo5aU84WFNIc2Fvd3Zhb3V2eDA5Sm03cFo2ZEY5WjVSRkVjblJn?=
 =?utf-8?B?Z1Nqb3FESTcyekN6R2tSMlEvbFBPM0FocDRwdExtb2E0b1NqM2NJbW5OZDA0?=
 =?utf-8?B?V0FFRC9mVUsxMUZBWkxVVHN6THlKaEpwMnJyZCtnTmFYaHlhZVJlMWwxNDlk?=
 =?utf-8?B?UjBTbms2WWlyWkozNHU2ZHgyL003VXZvUmVOMXhDQXpoN1JrdE9EdDhpNUt3?=
 =?utf-8?B?SGVzRHdUelpyWWRkc09YSERVWUVENkhHNXJyLzZHT3RNMjRXQ2o2WlJWZ2xo?=
 =?utf-8?B?SGNCd0R5ZUFoa3QwWm9DZXRydEtWRWY5V1J5cnU4cy80VXhnTG1LeGMrNW4z?=
 =?utf-8?B?M3lqbHVWTkh6RnByeERzcHVvZG1XMXBsKzU2U1N3MXJCRGF5WFlaME1hdHNY?=
 =?utf-8?B?bUd0OEVRczdHZ2hNOEg2bjdISnhWakNlTzZqQW8zR2o4L3VGZ2d5UDVhcmgr?=
 =?utf-8?B?Z0p3QlN0TStEdmU1Y1BBaXNhdG4yeitZK3hMYXdndFNPTElaNjZ0NFdsVzcz?=
 =?utf-8?B?a2tqa3N0NXBuTzIrNVBGdjVpbDVRSlV1QnRsWWFuM1J2TVA2T0xqYlFUZ3pS?=
 =?utf-8?B?S1J0eXMrMEpscnNmTUwvZDJjYzNRRHRQNkRoQzRGbi9rZFJ3Z1lrV3FIQUFm?=
 =?utf-8?B?NnZybmpWanZKR21qck05SGF1SUp4VDFjVWw0MFJ4K0dNajBrU2svdVBVU3ZF?=
 =?utf-8?B?dUlWZ0RJZDZBc2JkTmw1dWNaQ2NjckhjT3piNmphaFR0eDJ2WFpyb0ltU3U3?=
 =?utf-8?B?cTgzeVBCSGJlYm9xeStjUkIya09ZNVNiUnBWYWFuZTdidTFlNTNiT3pQNGhK?=
 =?utf-8?B?TWU2bEJrZ3A2NzdLMzA2akM2Q2UySWNNQzFSQ29ZNTg2WkpHc0piRzFGVlNr?=
 =?utf-8?B?ZnlqdWhTSUNIeTl4MHVpdzhpeTFJbFZWS2NLYkdWZnlMUEx5Um52R2MweDdC?=
 =?utf-8?B?SmdJVzBUMWJLaFh0S3FjdmFhSVdFUFlkeTk2eWhJNjhPRDZKMDVpZXZJYjZZ?=
 =?utf-8?B?cVZPZFVFWEo2UjhBVzJYRkR3OUVwQ0s0cVJlajFIVm4wMU5VZVhRMUhBd2lB?=
 =?utf-8?B?SEQ0YzVIOXRIaWFYcDg3Qk56Z3pyY29qWDRRUm8xNEh0eWhpb3NlY2JUNEpX?=
 =?utf-8?B?eXdpVyszVVgxUExOWnQrVXBTMjlCd3ZvbDJaNmZzaDRROElpWlVXUGFTNzVV?=
 =?utf-8?B?YTM0T2Rwa3NhSzE0cTVUNkw3aXNIVWtpdERha3NjN3pkK3JTanV0cFpGNjZq?=
 =?utf-8?B?WVplSlEyTjJXWGN0bkVKNGdaSEZqSlg1TmlhQjhESzZrTllKTEZBOHRmYTR1?=
 =?utf-8?B?WU9RdlprVjZoZDdTcnlTemRkZWtOZHpsMGlONHg2U215OVRETnRjUlNtYnA4?=
 =?utf-8?B?OEw5UEJKaXpQZFYxQkhlZjkrM3NsQUxDMS9xRFd1cndEb1pueGtXWi9mMmlL?=
 =?utf-8?B?S2Y2Tkh4N3J3bm9PU0lyN0J5V3dFN3FFVlJQQzVkVmZiYUNWUXhDdVp1T3Fx?=
 =?utf-8?B?QnRzNGNzU2tiZGtuZ2xNNVBhMkNONmZXcXBaKzlhNHdQbkNZV28zWVg4Qjk0?=
 =?utf-8?B?ZUNFb2tITUp0SkVydFUyTFZvcHpqNjNRbUpmb0FBUHFyNEpnQ3ViQmZtdklP?=
 =?utf-8?B?VjUyRG1Mc0k2VWYycnR4ME5wQnZ5U0tYWnZxa2RpSVVLUjBWZHpEUWRaZjJv?=
 =?utf-8?B?M1ZwNVB3TFp1Um45bEpoSjdFS3M5SE4rbUJCWXlkWUMxTVd6MWwyOHNsQ1lq?=
 =?utf-8?B?a2J4UVludDc4Sk5iVmNTK2dDMWhoM2w5WC92eU0wM2dJdk9DVGJGcnVUbUJO?=
 =?utf-8?B?bWZkcWpJZlU2UTlHRCt4dlJ4M2FuSVN2eGx4Tk9CKzY0TExKMEFkUXg1aEhU?=
 =?utf-8?Q?cGRFU8y2Y8YIGkxFpLkxVRTOE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef4dd61-4775-467c-28f0-08dda6543cf8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 06:18:08.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rn6rWtbpUB2kNy1QgfsoVoEVWcssTG1qkWpGUFoZaDQFdzTFctUZFl6c6PrEFEjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597

On 28/05/2025 10:31, Paolo Abeni wrote:
> I'm sorry, even if this has been posted (just) before the merge window,
> I think an uAPI extension this late is a bit too dangerous, please
> repost when net-next will reopen after the merge window.

Are all new uapi changes expected to come with a test that exercises the
functionality?

