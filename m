Return-Path: <netdev+bounces-96705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266678C737D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BE01F211D2
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFB142E9A;
	Thu, 16 May 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C0qjj9TY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEC2576F;
	Thu, 16 May 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850574; cv=fail; b=p7DLT7KIjilVjtWxq4YcXJPeXXgcT8xc2fbTkfiRXMdpQEQ8HGfoLUFnGx2O0Wmn+DwjcAUOVLHSjPBsHjTfnW/1j+2BHMyV/Ee85ywQpS01bRFG7lTFILBqml2xsrmOv9Urr1cHcbfn+raslap5h9zXd4gV/B2fWrti0X/0M+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850574; c=relaxed/simple;
	bh=u4sov4XhJot2KDZ2ChBnxGIPPO/JGbXTPtNZKZHk4DY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gcau3uXi2Ua9dS3FmxgRG199U2yCyzVjaQTnpGqeDEjDjyBvlbQHKk+BGZ5DjZcR2dE1tqUA8EJC4FZuY6r4qBOT26fNWQ1F80p3h+JguVqOuvhB6AAIBW7bug2/dBbZopnj+r39uOkBnm1L9rrEhSS4BHP4zszNoqgsr82+SVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C0qjj9TY; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZf4TezoQj286BqcF9RDYcXCdpqbxSG0DGrrkYLcBvFwWNGYczbHea+GYvT18yhO48mRgj+iPpiCZsV3yPrRgvXBqucp5IDUDdoqxqDeqRj5/rZE6UAvBFuz9yxS0n+jcujB/kIhAVgZaU162HVJTykWUAAX1iCbiGdSaX8GxDjPJIyX+hYUcWFmNcPcJO+qEjpj/JTprP6HvoSUahKJaITyxQWn7eX8TfbQ3WjxDsgpWBE4y35gzYkGeKSctWs8+SFjZlYyvt/Oi3hkivWYoUcoJ4ahEl27mQvJLF6m3/fQZpuycZA84eQBpyriED+Pu1aAbb5EQYjhm0CGDiP40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eei3vd+omHJpnkz9i6KFO2tFKeKPjTDDB9CavxoX4A=;
 b=IxZuwmLoChUl/ApsXztQ/duFBiCsiEwLgNWYO7eZHFXpVudL/Qxe4Izymr5AiycNaU8lsa4hKwZPhS9KSv+ojR2MzJwMPrZZnX77c/xGMDHvzyqH2K9PyZGtquFI+JqsfYR39PuHPWr3cslM6dnrmqvxCs1TG4ri4fB/APH/59UBpImgvzPcNA9O+9XVGoNvHlm5/Mc3iiaq4qzv71H3cwnvAwwx8rz+kCOFeMVdhi0xmXj/PyWaV6htZH24My1pxgXVJqFwp9MlqfSU/N59L+uiPiFQNwtRdMiJWQSADpgTVFLuHKdPOhpiml2LzQyG+1d9o3WQBU7BHLhA9Uv8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eei3vd+omHJpnkz9i6KFO2tFKeKPjTDDB9CavxoX4A=;
 b=C0qjj9TY8SX3d7KSYGi5TYwZMeMvLqG/YHkp3Vwx1+iPhZYpz+B7wl63cutDDOafcdDvTOpiDQt05mB1r7tPOrJfdbdb+sSoIZLW9iC/l8372I7GwgwDqL4/gbqdMLt9x9/JR2u9+3lcZftclGM70cFd2hmsWSQ1+r5LZiLoM9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 09:09:30 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%3]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 09:09:30 +0000
Message-ID: <6bbc4606-67f4-4689-bd85-7de6b6f99a62@amd.com>
Date: Thu, 16 May 2024 14:39:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH net-next 1/2] dt-bindings: net: xilinx_gmii2rgmii: Add
 clock support
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>, git@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, harini.katakam@amd.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 michal.simek@amd.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
 <20240515094645.3691877-2-vineeth.karumanchi@amd.com>
 <4ae4d926-73f0-4f30-9d83-908a92046829@kernel.org>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <4ae4d926-73f0-4f30-9d83-908a92046829@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1cfea4-b36b-4724-ffd6-08dc7587e4a9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDNxRTBQMzNKcFczMzNQR21RVytSaEl5L3p2eTY2WVRtbUF0RGtETW44N3Nz?=
 =?utf-8?B?MVJXd21xSWpaUUZ4S3FpYlB2ZVg0dXpoa203eWdQM1pHN1U1UU9ncGx4WEVw?=
 =?utf-8?B?YkE3bzQwR3YyeWt3MHd3aDB3T2RqeFVSVzYvdEIyZXo3Y0xCVHpyWXhYekFB?=
 =?utf-8?B?SlBobUltYU1sZkdWMHkwdnVPU2pwdm8yNWJqbld3dzFYTDhjbWF5bmVHN0JT?=
 =?utf-8?B?RlEvQk9Ec3dqNTc4TStrVGQ3MWV2VTJMR3cwYmhEQlFSc2piN0l4N3ZhbVI1?=
 =?utf-8?B?TWRsU3U5MUF3NjRVemZOcHpET29rVC9TNTBac1kvVUhqYVJXM0MrbDdCNXVq?=
 =?utf-8?B?M1BEMEsxcDYxSEJnVWNLYjhUdTJyVVVDR1RsS1FKc3FlTllKM296TUFvWTU1?=
 =?utf-8?B?ZmRDbnpaaGM5MnBsTFNkRy9qK1AyRjEwUXhqZVZoWkYvV28xK0hWdkhVbktr?=
 =?utf-8?B?NU5uRmkybVdSRG5PLzd6VFhBaWdONStwZWN6UzE3dURPNWg1WDN3TFpNRyts?=
 =?utf-8?B?NklEdmd5Yk03SXZZeDRIY3RvNGRpYTY0alFQTVo1YnZlZGhVMkNHTDBvU3d6?=
 =?utf-8?B?OEpmZ1AvL1o2MFZYdkhLZlF2LzZ6SG1SY3JZaVBJMFRScGdJMWZHRUVhSGhN?=
 =?utf-8?B?TzZ2RWFxVjdIN2NGUFlhTHYvN3gvc2VSOVJUemNYVTZvbVRsZTBLNHRGSE1Y?=
 =?utf-8?B?WDU1MG1vcWVneWRyTE5KdVNmM2ExSUNDanM0ck42QlpJR3htVktLdTlwUFFV?=
 =?utf-8?B?VXR1c0dXQVF3Q1BORlFrakMxcmI0cmp6TXN3dUpxUk1vazNaZlp2T3h2SUN3?=
 =?utf-8?B?S1ppMy9Mckh4bFkyRnVTeUNJQThLd3Uxa1I4Z0d5aTVsKzYwU1oxY0lkZHNZ?=
 =?utf-8?B?cXQzUFZocHJ2ckt4eTZjUFlwYXI5VE8yWjB6Y0JFOEFCLzkxdmY0V0owVTl5?=
 =?utf-8?B?dFFJaFpGYmE4VWZaODVDa2wrZW1lcGdMZ3hXUGF0cnNtRjk4dFFDSU93RWF0?=
 =?utf-8?B?Nlo0eWNId1pyVE96OVQ0TUN1SERuUm9QZ0V3d084bGhJczJYRHI0ZktjdktB?=
 =?utf-8?B?V1dPZVp0VzJrVW1PQmlNdVVpU1BCNEhmNkpzZU1sNmc3U1hYOGNRcmlPOUlE?=
 =?utf-8?B?M1g4QWZuQXg0REZDR2t6U0tFZFJtTjJoTTNJa3lZVlFZV3ROM2lGZ0xOTHBt?=
 =?utf-8?B?M0lLN3lobXdVbFB0bHhzcWZ1eFNEMmJIVG5jLzdTdHpnenFEN0pwVDlWM2d2?=
 =?utf-8?B?Mk5VSkZ2bVVHVjNNTVZLOVkxckFqS2haMjlzMWVxVGc0RS9yMXV0SnBXcE9Z?=
 =?utf-8?B?ZS9GelYxenNTVjNpeW5QblNTVzlDSFB5eEc4ckRadWtST2RoSUdMS3A3Szl2?=
 =?utf-8?B?SXZUN1NsbVI3aFRoajkzdTVJL2s5aU1jVjlnS0l0VFNRNFRscUpCaTJuNkZQ?=
 =?utf-8?B?KzJCZUxGdTRGQms5NUhnbHZzeWFKd29PbHU1dTlnM05YWEFSOHI1R04yL2pY?=
 =?utf-8?B?TG5yQTJnaDNSdDVvUTFHS0ZvYVFpWCt2YVZJQXVPTnFwU0pWN3NucHl3MWlZ?=
 =?utf-8?B?amc4cUlqalJCSTVLM3ZUL04vU3Evc3FBUkhmNnExcWxLZStWWmlQN1ZXTUYr?=
 =?utf-8?B?TWVGZGJOZlFxU0FJeFVMejZreENlZER3N1Zvdm93b0JlSTMvMzhXZW4xcW5s?=
 =?utf-8?B?b2szSVpBUHdlTkFoVExsSEptVG5CQ3luaVUzMzRjaVExbEcvV0tCSUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVlQnhyckdZR21ZUm9kSlIxa3hzT3FqeENBNE5nWk81YnYzam1CcTNVNndS?=
 =?utf-8?B?UFBaWWJrZE9pTmJVU3h6aW5TYjd6VUZwTG5pdVZtOXJwMW5GNjJNZVQwTm4v?=
 =?utf-8?B?WFl0MkpLT25xMkJ0ZDI2a1ZNcitYeFlWMTlIRHlXM01NSjAxYXZQbDlscTIx?=
 =?utf-8?B?MkNPRnNwZnpEdDRSVDA0enc3Wm9BZVNOelh2RXVHdUhLelI5ZjJ1YWlxRldF?=
 =?utf-8?B?NitYcVNycGRqSlZRY1FpSTNCT08xK0JWaWhTOTVmNWQ2eGtLR2MwdlNodUx3?=
 =?utf-8?B?bmFNUFZFbUdkNERyby9ZZ1B4YWNCY1c5Q1JDR1RpL0d2bm9XVXU5VUVSZWpF?=
 =?utf-8?B?Z1FmSjh2RzQvRjBrZDBwalYxdEZoeWQ2T3k2RFJBc3hvSUV4ZmpGdXRJUG9P?=
 =?utf-8?B?bWo4WUNqbnJ2K1FUU3hWZU9BNXFhMmVmN2JWei93ejBadHNkSGtjaHcyTzhO?=
 =?utf-8?B?V3R4Q0tHUkVZdW9wZ0h3aDA5Z3QvM2gzbFprOUR0Qm5mV1F5SEFtYk9CZFVq?=
 =?utf-8?B?YzEwMkpRQ3BzMlpvSkgxMFZQNklPT28xaVFQd2FJeDRQZEIxbnkyeStIK3Vh?=
 =?utf-8?B?cVFZSDVuVUFlaGdMYTFEbTFEaU13d09wWGVBSzAwRS8zVW90SEJaN2F1Smg3?=
 =?utf-8?B?V3B0alhmVGR3R016dVM5WGd3bWJDTCtCeGZOTVdwM3czQkRuRk5FaWd5ejln?=
 =?utf-8?B?NHI2MlUzZDFKYkMyMitWSlIxNGFzWWlXclcxNXoycHR0dDVWd25GbWl4ZXZa?=
 =?utf-8?B?MHhTTFQ5Tkg1OS9QdzVHczgwbkZqdmowSGxwWGZhQ0NXZzdGdFhkaktGWVFO?=
 =?utf-8?B?QXBPMUV1RWVLK1l0Um9wQkRTV00reVIyUFgzUTZJeWpEdjN4VklNSlBaSkNX?=
 =?utf-8?B?WHNrcm0weTlMNjk5blZOTHkzRE1TYzJ2Y2V4ZWphdDhCdkt4QkFMZURIcVRF?=
 =?utf-8?B?SHhzV2xZY3BBbGRMR3VLNDN0VjE5K1FGZzFkQjlmdzBwRVlDNmlkRXp0U3dt?=
 =?utf-8?B?SXRGNDNYd21IYnkrdUZLMlgybEdVU3luTWhHNEtoeXp4NjZ2cVlvUmtMclg5?=
 =?utf-8?B?MzNjMFRMbUVHTkNQVXNnWmV0SFlTVjV6WVYwOG5MWnhkMkUza3hnaVlYRmQr?=
 =?utf-8?B?TGEwTUYyQzZKNk91ek1zL2tsdmttSzlqVzNoL3ZxbjBrK1Z3cnFaZVppT2g0?=
 =?utf-8?B?V3Z0WlZQYU9DMll0REk5Uy9ZUStrb0VCai80Zy9ma3pJRklGTEdJbjZzK1li?=
 =?utf-8?B?MEgrSDIrcitxeUdoNUtpWmtiU25NZzJXZHpHMTgvMVh1eHpqdkxGVFc0TkpO?=
 =?utf-8?B?NlFlcTMyT3hsNVQxYnkwckRId204RWZFZW1yWmwrQUFka3laZkJaNE12L05p?=
 =?utf-8?B?RFM2Y2RQenpOQlZKVW4rSmRFcWNZVzZXMHFoekZ1dXBJNlZuNGI3VURkS0V3?=
 =?utf-8?B?TjlWZkx1b1hIbVErQU52L0NGWWE4a1pxczFGTktVM3phRFlyQmpJTzRvRGY5?=
 =?utf-8?B?NnVRanB6ZE8rSUM1MDhrNjdsRVN1bzFmTEE3eTFxVzM3UVdoajA3MU9ESG50?=
 =?utf-8?B?bkkwcnVNNmw0MmpwSzFlL01zNFRhMjIzTWV0d0JRcDI4ZHdjbnE3ZS9USkhG?=
 =?utf-8?B?bTY3QklUcHVsQjZOaVdCUFVVNFVYd0MxVWg0bXMrSWgvTzJOc3pCV2ZyUzhh?=
 =?utf-8?B?RXJIaEttVGZFV2t3ZENYNGpVYXhKQ1lHcnJRbE9sWVlUZzBMWW8rUE9GUGI0?=
 =?utf-8?B?NHpzWFRYNkJmbmk4SWhyRmd6WGEvbXgxS29ZbklQNEhHS1ZLVmo0V1VvUEdI?=
 =?utf-8?B?RXRFUkxya09TcVFNNjVaQUNKd21NcHB2aU5Xc25BbUZQck5WalJYQzQwMFd6?=
 =?utf-8?B?N1orNCsvZ3JuR3VKcmYrYkpLbC9MUlM2Q1JYais4VnlOVGxuT0Z4eEo5YzBt?=
 =?utf-8?B?dmEyMDVYNEZVaFhRUFNjQXBsNE9wVkJqSm42eVpjbThLVXRxNml1cmFmRjlt?=
 =?utf-8?B?eTkvMWwzRWpWUXRwdjN2ay9Yb2FVdXlwbWtzQnJqQldlMUlnQ3dqR2o1cU5N?=
 =?utf-8?B?YjRtTDNvWWdNUGpkQkdFQTZrU0NzRHdaVWo3NVFEdENLT1N2RTloSSsxUTlm?=
 =?utf-8?Q?q0oWLHC7wLksfgRXUkwimsKu8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1cfea4-b36b-4724-ffd6-08dc7587e4a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:09:29.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHZUbI+fR3c4aqd6xAMGHtXANNvd9uM7lmTxS+PN2FFM0i1g/JsdbdO/nQp8CfTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

Hi Krzysztof,

On 15/05/24 7:37 pm, Krzysztof Kozlowski wrote:
> On 15/05/2024 11:46, Vineeth Karumanchi wrote:
>> Add input clock support to gmii_to_rgmii IP.
> 
> Why? Wasn't it there before?

Earlier we used to enable all PL clocks (fixed), now we want to enable 
only the needed clocks.

> 
>> Add "clocks" and "clock_names" bindings, "clkin" is the input clock name.
> 
> Please use standard email subjects, so with the PATCH keyword in the
> title. `git format-patch` helps here to create proper versioned patches.
> Another useful tool is b4. Skipping the PATCH keyword makes filtering of
> emails more difficult thus making the review process less convenient.
> 
> Don't write it by yourself....
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 

sorry mybad, I used 'git format-patch', but typo!.
Will take care from next time.

>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>>   .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml      | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
>> index 0f781dac6717..d84d13fb2c54 100644
>> --- a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
>> +++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
>> @@ -31,6 +31,13 @@ properties:
>>     phy-handle:
>>       $ref: ethernet-controller.yaml#/properties/phy-handle
>>   
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: clkin
>> +    description: 200/375 MHz free-running clock is used as a input clock.
> 
> Nope, just write the description as items in clocks, instead of
> maxItems. And drop clock-names, not needed and kind of obvious.
> 

OK.

🙏 vineeth

> 
> Best regards,
> Krzysztof
> 

