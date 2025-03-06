Return-Path: <netdev+bounces-172467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23DA54D04
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C6A167626
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547F13C9B8;
	Thu,  6 Mar 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCgpMbNm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A65131E49
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270088; cv=fail; b=dB3atVMSRQGQwBeU7e4q9LgFrXNZjK1N+BUeL1foRCFwO/Tri7LwqNr68jKfGyVklofqlJpHjXoYZeIBAnKa1v7Bkd3VrwZG6zllMq3ECA7kN32g5AST9P78Eeibh3sIUkej0wDXULtF01Uf9aGg/TRpchlvHi4QpfIpAwJNptA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270088; c=relaxed/simple;
	bh=ThYvWStBLmwRBNPqhfbcxOltsl/jmr2xeSEHXrBJ2kI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7n87ow6BAqJjKQl+Y3wQpLYcsamALPVpVNn8RJkz+i5HUtNzqn4YiQY0/g2PqJq5OFhz8+X8dl87XhXsBgohyIk/5Z6UQN7YIelMbr0SBIsDNdGlEzPoMweBQC76wjYVsEliXsqX6cWmD3S23Ig9mcVeiEc963cPOl3kw4AaWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCgpMbNm; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/TNfBqDqkXio5aPMYy+1yhgiXb0y4TlYsoGzQ/2JnKmHULUSwZyad3ZDlzLUH8b/FyfnnBqQ+KmQ6ovOI1dHzhETPMapVQ12B+i4YVUvK0MHVwuGmKPOg7NKS7vu5IrhsldVZRctnFlEWkkbNtrIziSTvGSKcNiUgmFJ5EWmp+GVdWdiIfLmqVmlyfcjOmRKE1/pfbHyqMzyP/JI3/Fs85H943Pi0JQJJsFFofCKaLRn2kIPbgbNS/QJ77qzRA/RB9CZ9DvKbYoY5rnUSZwVeTj4dbidWee67jTdD5kGKabJxnA3kIuG4uFK6831iO3SaMcfRSYJGf8W6p/u6z/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThYvWStBLmwRBNPqhfbcxOltsl/jmr2xeSEHXrBJ2kI=;
 b=TOEr1C8kOFGmW8D8YZUi/BwQY3nwu+W4Wu7aNe7HEvWsQmyLXEzslbBolFVvv3TGBIjgdoJ9KV76LzjLJ3SUhg3yrOPevf7pww3HNNMp1MNlcm+UjlWn2c9x1fL6S27GNRkBUwK7FboAV93frFHasCoD6wxP9zz+CxQ3qSUtFPXICzDxrya7wwrumk2nMRQ9PvKwe1HLjSVi8ti31mUgEl3zIKsJVWH6QBzx3HjWAAApL4jW7XB2XLsLhb+xYYxQ6KEf3Ri1rUniOI9kT/znGxug4SZiO+NdPrBBPZyB+9K52ldi0Xj/84JL5ZaOnjLbIaNdU19rqNqQ04DeYu1Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThYvWStBLmwRBNPqhfbcxOltsl/jmr2xeSEHXrBJ2kI=;
 b=oCgpMbNmo4hwtmypFwoeD+4wxj2Ywjxo/oe+EdMdMHrR/u2Kea7wKJYaAYChLP5fu/4zZnsTcDqxZJGjQ0Ndbi9mravEvSmvgkPdfwCV7XBIww5j7DTMbLoBvl4TkuflVgJmdkZFIBCBd6VnckJ6LSzPQcGw0tXVl0cQUo8Wxq94YsvS4ZN+nzGKbHxAv31fcc/S+NEt43HftAAlTtI9funXAhVI/ouOOm2jJCUocVmwrmubpqcG3wldTR4MgDHK/7bIERRhm7CZKgDVVP8+vDEwWHKgRsOT6+2tq5TegiWconIsbJXsCZjyqo22EW/EflROjtEx50/mPLMniXRLFQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:08:03 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 14:08:03 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 00/15] Rate management on traffic classes + misc
Thread-Topic: [PATCH net-next 00/15] Rate management on traffic classes + misc
Thread-Index: AQHbetwRkQVjOhBoNUO6/NSjumfSArNDCOAAgCNDv4A=
Date: Thu, 6 Mar 2025 14:08:03 +0000
Message-ID: <2dc932d53506e6bc118cc9eb7ab7c2c11dc3881d.camel@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
	 <20250211193628.2490eb49@kernel.org>
In-Reply-To: <20250211193628.2490eb49@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN0PR12MB5812:EE_
x-ms-office365-filtering-correlation-id: 6e0d6b39-5390-40ae-440a-08dd5cb84fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3JMNWNnTVI5Y0UzYmVzbm8xTm5TQXh0M1k3K1p2RmZvUXhpKzZLNHczcnNT?=
 =?utf-8?B?MlJSVU5IRkdXQnlXK1hhajE2NkdmVlBRR3E4Qmw2UFoxYUorV3N1L1dCMGJD?=
 =?utf-8?B?R3pPWlZqT0F4UDlZVFFIMm1MNHJhajJuTXFPWHhicE1HUVVPNW1NYXZtYXdk?=
 =?utf-8?B?bWliNHJoc2FiOVAwMVB4bndLRDMvdXc4T0NBWTRuVVJ2Rlk0WkV6aFdUVjZF?=
 =?utf-8?B?ZlhaakNFQ050YUtWRFZNMC9Yd2MrbmZNRXk5akZlOGJYNy9tMnZ0Ri83aFZ6?=
 =?utf-8?B?U1FxZy9EQVhrOXdGVkU0VkUxUEMzOEF0UU1kenFtelpuUE1oMFR3ZTFKQkhT?=
 =?utf-8?B?aVdyeVhjT0tVYzlta2NCN2tOMHNvZE04S2EzYjg2UGF6V0hEbUltOFB0Um1N?=
 =?utf-8?B?cGFCeXlPUDFqSTlaUitmQnpSZU8yYUFUemRnb1hLd0c1UlVtZ0NESkJhRFA1?=
 =?utf-8?B?Vmp3YVpGWFVEUVFDYkdoMkk2bTd3YlQrM1ZQSm5hTmJVRVF1Wjd1UUJLZUQ5?=
 =?utf-8?B?VjA0V1V2WHdYWER1SDM2SnNNMUQ5WXpWb0k0a0NEWW1NVk5IR2I4QkFyNmZX?=
 =?utf-8?B?UTdmMVc0Rm9jc1hHYTdaRTVjVytLQUQxK002Z1JsbElwQUIxbXRFajd6eFRa?=
 =?utf-8?B?TWUxQ3FRQjdYUXFTQnZyVlhPcmlKeU9LRzNYRFZuQ1VnWmJCSDFMTFZZbUh5?=
 =?utf-8?B?NHRzZFU4b3NtZ25oRldpTWpGaStST0ZhT3lkTmNYNmVlc0EvbE85ZmRFRkho?=
 =?utf-8?B?SHhGK1pEa2dMV0hwSW1tRDdvSVNuaE94ZXlvdVRSTmJzSWlEdXFYeHJPdHFa?=
 =?utf-8?B?a2lhVkJnVDdwZFhoQWNrQWR4V0N3RWtWRUM4SVhmUG9oMXlrTlhKWW04YkZD?=
 =?utf-8?B?UjcxQ2JrUFdqUXVTbVNWQ2txUlNTcDdyMFdjVzZNcXZiZjhmYWhmM2NqR01a?=
 =?utf-8?B?UldZdlFPNitER3M1WWdsUmJNRjBqVk9HWU5MQWY4bmFQb2ZNYllxaFZyY0wr?=
 =?utf-8?B?TDQxUVZHMGYvSnlNSXJjajBVanNZeVpKajZ3SXRMQ1RCUlkrV3Q4YU1Nd3ZN?=
 =?utf-8?B?UTlJQnhjZUw1aUZnQjFhbHVpL0ErazFMT2dtZFpUYVBUWlIxWndiTzAvNHRH?=
 =?utf-8?B?aXVhSDltNDVMVFBhZkdKYS82TW44TTRuQjNSYUtuQjVKZnpXdzYwWTA3TFMz?=
 =?utf-8?B?emlFd0UzS2JuOHdyZy9hWGlMa1Q5MnNWQmgxU09qck11bEkvMWJlcUZhTDhr?=
 =?utf-8?B?ZFlkMWlnRzZYVXp3bkk1bFlpNUxXQVBvTzg0eWVCMjN1cXFBeWdhOXVSak90?=
 =?utf-8?B?OWs3RktIb0U4MnpzckpMWkREeUFBVzMxaWZxT0dkU1NHeUoyWWRGTjY2SDJU?=
 =?utf-8?B?SnJNQmo0VitSRUlZMGFyUXpMUERYQlhLM3kyZitacEVQT01SMHVNOWJiZGVF?=
 =?utf-8?B?ZGpPZGRpVWxNMnNBd1Y1VkF1MHg3dlpwK1R5T0lIMDFjaFNGRjJydEJLamo3?=
 =?utf-8?B?MmhyOVpUR2prYzVmZlFVT1BtRS9SU3craytjOFVnSEhFemdWTnN4enRxVFBa?=
 =?utf-8?B?ZHFjbG95TDlWSW00N3piQ1AwNHNrMS9rT09wMGd4Wjg4VzNHL2lEbW00dDNF?=
 =?utf-8?B?U0w3c3o5NHNqUkRwVGlxeUplYVRDT0JKRFdIMllxQTVydDF2ODJQVHJ1TWMx?=
 =?utf-8?B?SSt3czJYaHNGZkNKNVNMN2ZrbHpKRzk1Ym9XbHF2RjdValNSM01TTXVyNWpN?=
 =?utf-8?B?YjNWTGFxSUFqWSt2VjNETlh6dEc1NmZSc0N6Y0hYNnMwa1Y2eGpVblJrNTRz?=
 =?utf-8?B?VTVFUUgxQld6elVybkcxSWFHamV5dEVLTmZnVDEwQjgwWm1nMVdvQmtYUThV?=
 =?utf-8?B?cVo0dG1VRXlVS0ZiSDhBb1p2NTBkU3JVTWE1TWlSTWxHdTE3Q0l2R2hrN0Uy?=
 =?utf-8?Q?snsjWsnxHjLNPzvDR3TKPaPaqvvOb8K8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L24yZStDNFNEdTNJL3dwTlNJZmJlUXlEc1BKRUJ4R0h4QVJKZWxwTDcvUTdr?=
 =?utf-8?B?NDA5MERtK0FrRXVVMVJWUE1IbWZxaExEMlZ5QnFPMmhJSFRUZ3BjSjZ0ZUR3?=
 =?utf-8?B?ay9TeDR5bjFBaXBzc1RyM2tRWWlaUi9XbXNGZmhQRmNCUmppMzZTbTRqcEZE?=
 =?utf-8?B?Zmx4eFFwZWpyS3k3cVBmc3prM1psQWwyWGNOTVpYK2FndFRveUUzeDdYbWJa?=
 =?utf-8?B?ajBpakwzQlA2WTJqZFFLZmFIYU9icHAzc2Noc1Flc21HbGIxeVpRR0YySmVS?=
 =?utf-8?B?bitIN1lvUWNKSkNZUHQzeTlVbGFVb082ZXJIc0JMTnNMNVZnY1Y0YWp4WVVF?=
 =?utf-8?B?S0VzSnJyUWZ3SllJbU1uSzMzcStNRFVyTk9lZnJUTzlMYjhSMWMvalhwRS96?=
 =?utf-8?B?eFM3d202Z3hkUjlkb01CR1lLMHJudk56WE9TU293cWZNZGRUdSt4dHBGT2VV?=
 =?utf-8?B?clBzU2ZaWnY5UnZqdXJoSzJFbk5adWVVbWdGME9WUTZGU2Y4NDRSd2lDWDlk?=
 =?utf-8?B?alJwRGliUFppWDVDeUMrVnhMMTFEck84WXBLLzlNeng3ZW92UWYycE5VaTdn?=
 =?utf-8?B?VDVCd0QyMUtvdWJpTkJBK3crcllsMDdzbFg2RHNiVjNxOC9TQ0RpSFg5YXRL?=
 =?utf-8?B?OERzV0VqTlA3cTV0WWR6Y3lSS2R3RmJDQVlXWjUwRzdMRTlXbFJHQVVZd3FT?=
 =?utf-8?B?N2h0eUpjS3NtZEZ2dGZ4aHpIQm1za3lnaGRnWktoR29veVIrOEw5cUhHUllR?=
 =?utf-8?B?dzU3RFdid0cwN1NabldKOHVwYzZZTkkvMXpLY1NnckJVRWdEZUI4UnVlTnFE?=
 =?utf-8?B?UVh2aGxSWTA3VVZ2QkIydTZTSTYzL21nMDhha2c5MVpTYkJ2WS9ZUGE0VjdE?=
 =?utf-8?B?U0JJcGdKL2sxNEdDYUVWSWtIS3NmMTI3RzBWSk5YWUxNL1V5TXhoSno3RzNz?=
 =?utf-8?B?QkI1NDU1MFZwUEJVV2JqNXovY3JyRWVPYXMrSnowUm10Q2VtVXpHcDA3M2pT?=
 =?utf-8?B?TzRlU2g0ZzlIK0ZaZVF4ZE5UNzVkYlJPdUFobE1ZRm00dlVlbjZad0MvK2Zt?=
 =?utf-8?B?WVRscGo5MUNGZUt3d2UvOWdxb0VUVGFLdTV6S09WRXVxUFRlNVI2SityQkZY?=
 =?utf-8?B?R2cwdzIzbExLbjNsZTdPdGpQUnpQeGF1K1JvT2xITG8vOW5aTmtOV3UxdTBw?=
 =?utf-8?B?NDAvNWhzQ0NJNW9SK2tpaFAzOHFPNGRkOHpQY3pVcG1QckFybEpFVW9KOXk2?=
 =?utf-8?B?T3ZhYUxDYldueGoyVVBUMmF0Ymp4eWE1ay9zNGs5K3NZZkg4NU53THFjMm0z?=
 =?utf-8?B?NC81NlpYRGh4UjA1N09PU01GRTJvMWFLbW9RUi9ZRmZzbTNzWlAvdFFrcUp0?=
 =?utf-8?B?WE5maTJpamlsV0R1dzdvQ3hlc29ySUNnaURLV1dzVFk4aDZ6Rk5VUklueXVD?=
 =?utf-8?B?aDdLcUpGSmo1RHdlNTVOb21wZ00vMG40ZG8xWEtEVWZ6SExRQUN5ZE5NdEtK?=
 =?utf-8?B?eHMyM3VjY0k4d0RzLy9xNWk2dVc4WFdCV0ZlNkRCSlN0T2ZZaUg0SGVtYlBH?=
 =?utf-8?B?UFdPR2k3M042S1B2YXo3dnFoS0VJcGU2Y0dPU1R6ZHo0QWZrUUhkSlN6Z1RG?=
 =?utf-8?B?b3JKQnc3T1BuQjRyd1lKWFZCejBqUytMRDlIUngvT2d2NnJkOUZVYzhMeWtw?=
 =?utf-8?B?ZElnNTc2VHZLWlhvR2FZbWhPRnQrVHR6TGNPcDUwZkJOTHFoSDgzNkVpcnV2?=
 =?utf-8?B?YmUvdllhQzdhL1kzRTd2YzlBdGk1d09TRXNUcEpMai9Lc0wyMkFadzU4b0c1?=
 =?utf-8?B?aVBMcFFXaTJRYTNSdUFzN0wrOE41Y1k5b29xQ3hFejRLWnAxaEtUb1ZlOGgz?=
 =?utf-8?B?SjVnMzlodnoyWjV2VmVtMTk4aXh4L1p0R3VBSGZnYW9mdmNlTyt1aCtmU2dl?=
 =?utf-8?B?U29wcDQ0czFjSmJqVlBXOUtoTjVKZHBEYnBqZG1BQU5OcGFQQ0c1TnFwL09l?=
 =?utf-8?B?Rk41UU1sdkdrRXM2aFhuQ1dNQUt0d0tLaVRreks1OEp2akRjSlQ0SmpRN1ZP?=
 =?utf-8?B?N1BLd25QcXd5aDVlalB5RFFIMnViMW9WUERUMFNRL2I4Wk5zUUMzSmpVUkhh?=
 =?utf-8?Q?6ujbeThuY9gwc1DaMbuZozApk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81CB52E54F381A488DE99435F407D7CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0d6b39-5390-40ae-440a-08dd5cb84fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 14:08:03.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PvmAEwNPm908mVhMs96nIvvNQMTD7JSUFfBCpjZoczDlicjT0sM/XI8JDXYm/lfnQ4wMa/oe8F3XwP5QnNQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE5OjM2IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gL3RyaW0gQ0MsIGFkZCBDYXJvbGluYS4NCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IHRoZSBwbGFuIGlzIGZvciBzaGFwZXJzLiBBcyB5b3Ugc2F5IGF0IG5ldGRldg0KPiBsZXZlbCB0
aGUgY2xhc3NlcyB3aWxsIGxpa2VseSBiZSBhc3NvY2lhdGVkIHdpdGggcXVldWVzLCBzbyB0aGVy
ZQ0KPiBpc24ndA0KPiBtdWNoIHRvIGRvLiBTbyBob3cgd2lsbCB3ZSByZXByZXNlbnQgdGhlIFRD
cyBiYXNlZCBvbiBjbGFzc2lmaWNhdGlvbj8NCj4gSSBhcHByZWNpYXRlIHlvdSB3b3JraW5nIHdp
dGggUGFvbG8gYW5kIFNpbW9uLCBidXQgZnJvbSBteQ0KPiBwZXJzcGVjdGl2ZQ0KPiBub25lIG9m
IHRoZSBxdWVzdGlvbnMgaGF2ZSBiZWVuIGFuc3dlcmVkLg0KPiANCj4gSSdtIG5vdCBldmVuIGFz
a2luZyB5b3UgdG8gd3JpdGUgdGhlIGNvZGUsIGp1c3QgdG8gaGF2ZSBhIHNvbGlkIHBsYW4uDQoN
CkkgaGF2ZSBzZW50IHNvbWV0aGluZyB1cCBhdA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0
ZGV2L2Q5ODMxZDBjOTQwYTdiNzc0MTlhYmU3YzczMzBlODIyYmJmZDFjZmIuY2FtZWxAbnZpZGlh
LmNvbS9ULyN1DQoNClRoaXMgaXMgdGhlIHJlc3VsdCBvZiBzZXZlcmFsIG1lZXRpbmdzIHdpdGgg
UGFvbG8sIFNpbW9uIGFuZCBDYXJvbGluYQ0Kb3ZlciB0aGUgbGFzdCBjb3VwbGUgb2YgbW9udGhz
Lg0KTGV0J3MgY29udGludWUgdGhlIGRpc2N1c3Npb24gb24gdGhhdCB0aHJlYWQuDQoNCkNvc21p
bi4NCg==

