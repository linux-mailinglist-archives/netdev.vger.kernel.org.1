Return-Path: <netdev+bounces-231701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F0CBFCBD0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 380D44E77C7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931431A7FE;
	Wed, 22 Oct 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="cxx/L0dI";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="i+veCEza"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay10-hz2-if1.hornetsecurity.com (mx-relay10-hz2-if1.hornetsecurity.com [94.100.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1D34BA5C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145268; cv=fail; b=FfHzockpjgn7at4Lo/4Yum3Bu5AaVZfaojCHUFgphwsELh8JsS8l1UXDIQHmhDvTZqotjIPJdH48YpmcEDxcOvI2K/G1qV2jHn1m/Zmty2HwTobOIPT9sgSvQPdCmOah9IbEvxipSixVPBVn4WIBC1GZ0gHDF5mEY9fYPjgSHBQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145268; c=relaxed/simple;
	bh=RbpBSWAyVUKiS/PmCPMjzA2a+K/UGfzDqTYZ+n/u3KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Disposition:
	 In-Reply-To:MIME-Version:Content-Type; b=Bc5amTPhT72hNhjhNg8AcWU2KMXPTRJhyDP+LHEEJGfaZPjFW17824a8Ruw7MPMrYGkjwjCc6hWhBAQvVQ2S/rvG+gZzP4vuZU7IyHMXmHFFcl6XGRO4L6mvqrhzVDDON7vKU3esjkrAku59PZVHGitwk/GD9xZZg8KsP4j+Hv0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=cxx/L0dI reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=i+veCEza; arc=fail smtp.client-ip=94.100.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate10-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.65.83, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=du2pr03cu002.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=dKE9m9hb1p+brHDCcJeLhcHv4jgJ/4eFsG6s1mT3Iac=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761145216;
 b=pnAP3JpmAz6rhk7DVE/5QW5l8OHYNtIpnnMFC1ZCSd0BnZoMnJtHgJuoxRADzV/c/Q6CWxcT
 qfZbF+x0W4X7VF0JY3TiqujzWgD2BfK7f07xqHLrsj4HDqNDRsNGJ9HMhO5ECz4kUSjefGPp2EF
 weld8+4KewhAqZ1+x8GDCfh5KewGfrmwV2MWxFMW6AsxM5Qc9fLYo98Po7udW94/WVrwgpd/V/T
 lXn7P60/W1ujZnXa0hJ55RbWBSXQxvRE7jeyJpnWlRLj4lttrUfMY9Qt80CXDVTUYdiTvwNrp+p
 Mt+r9vyx7NpJtPOA3nYeU6JR+c3F+TTQYDLtMPJ+l722g==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761145216;
 b=KBxkuulzvr0IkIuOKvXOpAM24BlMGpYIzzpZdHaPCOf3uAYtphuo8RzJB5QPXxOqNXmobHtb
 qxmrxf+HTSDAop5XurL5dCB4WgYqPHnG+9dIuZ2592HTcZZq05InhkdU5dMo6LFaatjdXw3MLpl
 yHbPoCR8pL2ZgBuUpbbBIvq0OoC9xIkWPZwiGWYP6AfLqCm94Shv81Zc8HdH3eExbylga/u5qC+
 Ga1kullOTHqEj+D70q6+t3du+mCNul00QVL2GF52IliShVGyJgigkuGnBIpQYBmkupeUDcCr/YR
 Ci5sPIQaGHqZMAqOBetQQoBOQWU5BDrV8PCV3YS+Fze8Q==
Received: from mail-northeuropeazon11021083.outbound.protection.outlook.com ([52.101.65.83]) by mx-relay10-hz2.antispameurope.com;
 Wed, 22 Oct 2025 17:00:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUTRk46Yp2SaTg8irgnoi2h6rTZaQgTWdopmCxjj04KM09TbNOLM5Bpv55k1Z6K8+E0zv0kmOQlznKzhqS5k8hqnogWgkZMs0DLhlBRbGEuHAEzUQ3Ux+mXH7ygvBi3Rn8kmGLUJQrnW1d2G+UZ6OT/4otISqYI0bPMYVIgrnfuKzBe+D1zXlYUFU40Cod90zOULOpvmN2jEXc4qyto1RbguV1FFUU2rc+vT/JQNgUZjPbdSZGIbyos40VF1Iqm7Ui1Ynd8fmru1vs9lg0smkvZTi4mnWHLm0aJsSTTTLzOQX+snfQTEVVjqpelDUwKf6siOlvaTtIT3nqEXN76WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgd2VcwUqcG3MvS/uhK3co0ZuYyq64nZeq9eHCXkRkM=;
 b=tNVzmvRF7xO7Keb5SVSY9jagfFEkX+KUHcStkisxEsHmo/mvDW30XNm6I+mbSTJClPF5YuNOE/URuhCIf40IgrhT+xFwimdu75YEj4KeyRuXGGAqvIOyGN2pHfB+R7+nbr4daH40jE/h/0H2bPm2VS/siCXauhVHEamfp9Xv7CxMZcuIOYTVOaMSj395Du6IaOuDSATKTUnQcPYqirtd6GC4YsuEE7S9UKuobq4g1+r5CcaLCJEvDY4Y+OufledqwkVnxxbQewC9kJ+EuMH6Pr2s9SbSN32aa1yof6LWJg6yvye82mcPCP7OucdDFo7KHLQGq+TS9nN8VFNgJ0ttUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgd2VcwUqcG3MvS/uhK3co0ZuYyq64nZeq9eHCXkRkM=;
 b=cxx/L0dICx0gVVmMytb/TyFIYGewnLU+A08yFcnLAicEbU7aj2WEUQE8PWklE9a0xZCHBsDB0BIDf/WBc3iVGF95te1LhUQpK57AdT0LHyFR7vpKuUhUVg/nxVY6XqyErUJi84vHrOCrb29AalJpTLtkNEIPsjGfHX86zbAriM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by VI1PR10MB3295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:59:48 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:59:48 +0000
Date: Wed, 22 Oct 2025 16:59:45 +0200
From: Johannes Eigner <johannes.eigner@a-eberle.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Message-ID: <aPjxYbbiYAexF9nQ@PC-LX-JohEi>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
 <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
Content-Disposition: inline
In-Reply-To: <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|VI1PR10MB3295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6845bbf4-ccbf-45b7-fc5c-08de117ba4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGp5aFFxcmhFOFhYNFdaUWVpbnoyWkxmREFkWVh0Tm1wMUdVanVlbXFOeGhS?=
 =?utf-8?B?TmxqdFVZTWl3bVJDU3lzaHNmbnJPUWZuamVWR0J0bzdnRjhuUE12dWY3bU1L?=
 =?utf-8?B?VmYvVVAycUpOMkM1TzQ5OEJGLzBIZW5SZ2FKOFRsQTc5cnIwTGVXWVREWTNT?=
 =?utf-8?B?czA0dzJwOEZjTTJ2VFlVZWVDUStLajZhVnB3Mjd5Tlpua2ZCMkFRR2VYY1lU?=
 =?utf-8?B?ZHgvNlhlWGRpSzBUYmYraDdZZmFNcDBoOUVnNUl5R3RiSmlGNXk2SGJVZGUw?=
 =?utf-8?B?bU1ZcjVxc3E1bWVHMGZ4UlNaM0E2LzNPaTJWYTlpNGNScndSM1ljd2lIcnpn?=
 =?utf-8?B?bUgyZysvWllHQTBnTWk1UkN6aGxsWEVXVkxHL21wS1lxalByNWo0OFBxd3lI?=
 =?utf-8?B?RlA4bEJhZVIxN1dqajVaSFE2TlVqQmxmTUVubzl1WUdjRXNyMmpsZVdFNFVX?=
 =?utf-8?B?TGRvS0tjSTFNbFdLWjVLTmErRExTOTJoMmZFT21sdTFxaHhKU1RSWEZhdnlI?=
 =?utf-8?B?T1B1OTFXQUFOVGRZaUJEQUZINUV5M1hNeG16U1pKS0RuWmpMM1FkNm9rOFV6?=
 =?utf-8?B?Q2RKMjVlcGM5Tmk1UEFveVdRK1FPaDRtSWlGSkVqRzJwa2ttMjlFdWtqY1Fw?=
 =?utf-8?B?Z2VxdzhnS0d6N1Z6Ry82VUV4cFQvcXR0M05UM2tHRjRYY2VESWtsNXd3Z0d1?=
 =?utf-8?B?dW5tblB4SjVQSlZobHZTR2tiTFpMRlB0WktMOUxmbE9jaXNwcnBGZVhiN1gz?=
 =?utf-8?B?b1l3NWpEbE5rQVhSRStjaGZxOWIxQUtuNnhveW00M0J1Y3NQS3lzeEpsY21E?=
 =?utf-8?B?aTZIK29KZUcweTh6ZG5QL3RwSm95Mit5cjZERitISFFlSlZUSjlSTElRMkEv?=
 =?utf-8?B?N3V5LzdwSlh3VFJNR2lUODhSR3FqWnRtY2J5d1lLb2l3dmtHc2x3bmw4UW9X?=
 =?utf-8?B?TlVyR08xNEZCaXZyU24zcW84MjZJaXVmMy9iVXkxTWhLZmN3aEpmY0Q2YUxW?=
 =?utf-8?B?UzFvVUthSXh2b083dVoxbDBRYTVpdWRJb2FnNjBUOVd4TzVLN25FM2JkeWRp?=
 =?utf-8?B?WlNocENUT1ZMam5iYTAwN1pTcGsxdVRGYW1sRE8xMTFBVFBDRnpoWDZZZnBt?=
 =?utf-8?B?eW5OSnBDR3hpR0R1S00wbFlQTXVNWmR2MWY1cHlVZ0RrQ2dDeGtFOFFuemh3?=
 =?utf-8?B?K3NsakRrWHpGUWh5YlBidm4yaGlJUDdCalZpYWJqbmE1LzVTMUlEWTN3VGFR?=
 =?utf-8?B?a29acnZRQ0kzNlUxSG43NXdNNXQ5cEJhRDNjUDdRU1psM2NGZ1hTY1FMcHVB?=
 =?utf-8?B?L0J4blZ6N2hGWjg2V3ZwSGpKcmhhYmVqbWhDalZRdEE1RW1mK2VQaVhQUUM1?=
 =?utf-8?B?THIvNG9iVlFySFVWaWdhZytFM1BUcHhocDJocGJLMlJXcXRJUWl0MVpsa0Ns?=
 =?utf-8?B?ZmRMVXh3aTR1aW12Z1p2M1RRZnByRFNTUmsvN3hsaVh6VVR5MUs4YnZPSTk4?=
 =?utf-8?B?RUpaaSszcDhrSHRkNll2RDlUSmN0aDRXaWdlTW14RjZMQzFPR083YjR3dVhh?=
 =?utf-8?B?ajlVVHREZE9PVmhKMVQzWU9XTSs4T0tVMUtNcnJkUDdYYkovcy9UVmpCWG5z?=
 =?utf-8?B?UVR0QmtqWk81YlEyV3NVSEhRdHQzMU1maGhQb3lBTW9QQ21NSVBFSHZUdlMz?=
 =?utf-8?B?LzAxU1FDRGthajl5VkM1b21HQjF6MU5sQW9Xb05xK0ptQlVUVlJQWDU0MnFo?=
 =?utf-8?B?WVhFcnlOZFBZZlEwZ2Rad3lEVkxTZkVvSTZNeUZaWVFaRGxwcDRDTWMxZ0V4?=
 =?utf-8?B?d3kyRnEyTXJieVY4RUE4eWFjSjhoaFBEY2JXWUZTcUhjbHYrZEkxQ25DNXBE?=
 =?utf-8?B?eEs2WGM5UGswcHVrS0JmS29ERTdOK0pEMHpSSWJZNFVvMGtUa20xZVRkRVFu?=
 =?utf-8?Q?Od9gzOhgiw+AbF7KSUcVZzaKQ7BC5kMv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1dXU2pIWnR0bTBnN2RkeE85eUlUUFhLT0RPNzF5cDBGaE53M1pwdytvSFlL?=
 =?utf-8?B?RHRhVzJRNktWcDV3d3lGeXdGeW1CUkI3NkxaMXlvM1doanZWRlN0OXRzMFBO?=
 =?utf-8?B?OGdPZlRyZTlJSGpCdkMrOVo3T2g2OWFvMmRYSEhBV2duVWhXV1lvcE1GSUpr?=
 =?utf-8?B?YnNodkh6WVVsUXovS1ZNWk52bEZneGw5QXV5NlVpNWx6N25IRG02ZGpXK3dW?=
 =?utf-8?B?Wnp0MVgvc3hZdGNwNDIxdDlDNGk0R0xFU0syamh0LzJxa2t3ZFZtc09sQ2Zt?=
 =?utf-8?B?MmExRnRPU05SbjFxcURETEZBZW91RWsyVjMwbFA0dlZ1ejVNa2s5VGxUVStI?=
 =?utf-8?B?eWJNa1oyZ3lNTVAzVzdHcm9uVDdWTFUwcVZrb1kzb0RBMm9tOVh4LzV4bkZj?=
 =?utf-8?B?c2w2dDhnR1cvMWExanJTWVpjOUFURGVRcFg1TjBGRTZPVXcwUmFTanNRVDM3?=
 =?utf-8?B?MVg2TXNkQW9rdVZCUkFSZHZndXZzUkJqeUtLekxJcjZMYTJVM1dDTVFXVFJm?=
 =?utf-8?B?WmJ4RTkrbkE4QXlmSGZ1SmdEU3BndU1xTVZuREhCVGlNblBTNGFMREEzSVhh?=
 =?utf-8?B?WW1MaFU0TEtmNFgwUm5tYnVuWGlHTDRuckw1WE1HOTJZbFd4c0F2dDVBd2ov?=
 =?utf-8?B?aVFhUFF5bEZsQVFUNysvUlI5TG1WN3BYUENHZW00N2U1eXNaL0t5NTg0ZUF6?=
 =?utf-8?B?OTZjSm9RakxkMllVQVM2dWllMDZqWktzMlNsTElMNy9rajBVM3FNWGNvNjR0?=
 =?utf-8?B?dE80K1NWQTdXWjM5VjNkT3dNdUo5SzFnNzlqRDNlakQ1Q3ppSXdKSXREREZv?=
 =?utf-8?B?R2JqNFp6bUNEc3ROcHBJOWJNN0lyREpRcU9JTm1XaUdld0xnajhlTkZkVUdr?=
 =?utf-8?B?Ky9lOEptTEJEVUsrOHBab0dPUEVwNFlrVytTL0gyTTRHcGdBTHBiMG9sekY5?=
 =?utf-8?B?cFpTSzNZWGxqcXRmM1lzN2kwdVVVTFp5VlA1cHFmTTE0QzJrc1lqTkVZcVJp?=
 =?utf-8?B?SUM5WGh5a05vRzU3aWQwbXdBNkM4MlVGQXB6WWM1eGF4UDZyYzg4RG9hYkNv?=
 =?utf-8?B?cE5HS1VIeUtkbEpwUHNRYTBhVlVzMjdnVEhYMUU5em5NV2s0WnBWUTBkYTBz?=
 =?utf-8?B?bkxOVmp5anRYNUlVYm5acmhOek1aR05aK3N0OXlPWGpXZnpBVFNjVXBtZUMr?=
 =?utf-8?B?c0l0ZVpqUXA5emNrbHU3REM5dTBhYjB5SU45VWkzMTd1V3E5NFVRai9jM1pi?=
 =?utf-8?B?UEhIcFdjcGR2OG04UzhXRHVrajR0bC83STJyNmNzK28zYmt4TjJndzBiTmpt?=
 =?utf-8?B?S3Y1dFZaRTl4ZFozOUtGQ1lqU1R2VktZTWt3K255MjVhOUJudVoxQW1NV0cv?=
 =?utf-8?B?LytmRWhIUXh1TWl5ZHhOMzBiUDdsc05ueXljVHBlc3hFY09MWWo3akthUVVM?=
 =?utf-8?B?T1NXbmdCY2g3VU9OL0d3TzZSUnVKNjhrRVkvVitSbTFaR0tWbmRPdHVtT2do?=
 =?utf-8?B?akJzZjBGemJraThBbFJHM1Y5cHUyV201em5McjBSdCsrRVhYbklDVHp6NHIv?=
 =?utf-8?B?bWdJYU5FRzBTck9yWDFYQmpESjN6WElTUUNuNjNZNllXNkh6UnpwWElTOTNJ?=
 =?utf-8?B?eGl0bkhNLzlrNEtlK0I3TEVwdTZvdnZ0OVR4SGtiNXltSmdCK1IvYWtkT1Fh?=
 =?utf-8?B?N0pzdEwrb0NBZGkzRWRSa2NUZUpRYk1URUFBOEN3bnB6dVZPOGxSSE03WDZE?=
 =?utf-8?B?Z1FvZGZqMkJWR09PMjdYZ1NDS2VMZ2ZHQTIrWXlYYm12ZnZ4SHlZa1JEOEtN?=
 =?utf-8?B?dzNYUzduV2djMzl3NjhmOFBmVVVQOWd0NFR0aUtUeXZpSjIvZnpCNlFKZ2Y3?=
 =?utf-8?B?YlRPaUxTbEVaajZoM2o0WGgxamE1dlViT0JZNFNrOUM1ZktJc1VHYzE3anVs?=
 =?utf-8?B?WVFOWUVVcFdkVFRnZmFhSHhiUU9pS1Y2cHNYUkVLVTRQRXVISGNLY1JtTTQx?=
 =?utf-8?B?V1N3K0I4YlU3Q3J5bko1UUVsNzdwdVVrWDA1amV6emNhd3lweFI2dVpxa3Iz?=
 =?utf-8?B?NE1BVjZJWVlkR1djSUY5RjBhUUdBYkVSQ1VSb2hKZXhzTy9jS21zL3h6S2Jm?=
 =?utf-8?B?M1RVY0hKekkwVWt0Qmx1b2J6Z0N5OW1aVnAwcjJWSVNQYTVFODR2WE9OaXlr?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6845bbf4-ccbf-45b7-fc5c-08de117ba4f0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:59:48.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfByVQ9hbFguA7nl2GFrxDLr7m+5BfPFJ/+AmLtFghiUIqWbZo6i0FqWHFMAEAC8p8anJzydLvmgJkL1UUvYmA1NFazJB+kEx+7F7wvB7ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3295
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----03C2811EEF68F68A81B01D62A01E6F1B"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay10-hz2.antispameurope.com with 4csC4m0hlzz4FJpd
X-cloud-security-connect: mail-northeuropeazon11021083.outbound.protection.outlook.com[52.101.65.83], TLS=1, IP=52.101.65.83
X-cloud-security-Digest:3513a1ca266c2b1578690a16fcb78ed7
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:3.005
DKIM-Signature: a=rsa-sha256;
 bh=dKE9m9hb1p+brHDCcJeLhcHv4jgJ/4eFsG6s1mT3Iac=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761145215; v=1;
 b=i+veCEzazYplPBMNjm2H7beOBbF5mrAwM9+mWzizeLJoQvTM8Yp7crGR5/UwSV6rrYeltatY
 eTdVlHWCrTaxRXp+geB4FpUtHnGqDhfrQ/WKbD453cj039Er68OASlShByw8GMKa+sr/kJXObmR
 TidCCG8wHxL9oqpeZEyNh3MDo7n+9LYS3L2vZZ/Z8ArYGDNQ8710DzX5qDABOIgXyJ5lpAbO9tN
 DaRn8EtzYEtzU55JLlrA1fOG8ojA0q2VkevDu9rCQNYBBfSL8Go6TyWw3uHoRlHBvpOjLEUBTMb
 dhqrLz5yn3CUtE26sdF1v34VuiesKJEcHGZQsv0saiw9w==

This is an S/MIME signed message

------03C2811EEF68F68A81B01D62A01E6F1B
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Date: Wed, 22 Oct 2025 16:59:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Am Wed, Oct 22, 2025 at 03:32:24PM +0200 schrieb Andrew Lunn:
> On Tue, Oct 21, 2025 at 04:00:13PM +0200, Johannes Eigner wrote:
> > Append "_thresholds" to the threshold JSON objects to avoid using the
> > same key which is not allowed in JSON.
> > The JSON output for SFP transceivers uses the keys "laser_bias_current",
> > "laser_output_power", "module_temperature" and "module_voltage" for
> > both the actual value and the threshold values. This leads to invalid
> > JSON output as keys in a JSON object must be unique.
> > For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
> > also used for both the actual value and the threshold values.
> > 
> > Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
> > ---
> >  sff-common.c | 50 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> > 
> > diff --git a/sff-common.c b/sff-common.c
> > index 0824dfb..6528f5a 100644
> > --- a/sff-common.c
> > +++ b/sff-common.c
> > @@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
> >  
> >  void sff_show_thresholds_json(struct sff_diags sd)
> >  {
> > -	open_json_object("laser_bias_current");
> > -	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
> > -	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
> > -	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
> > -	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
> > +	open_json_object("laser_bias_current_thresholds");
> > +	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
> > +	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
> > +	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
> > +	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
> >  	close_json_object();
> 
> I'm struggling understanding the changes here. Maybe give an example
> before and after.
>

Shortened example for laser_bias_current, full output at end of mail.

Shortened output without patch
$ ethtool -j -m sfp1
        "laser_bias_current": 15.604,
        "laser_bias_current_high_alarm": false,
        "laser_bias_current_low_alarm": false,
        "laser_bias_current_high_warning": false,
        "laser_bias_current_low_warning": false,
        "laser_bias_current": {
            "high_alarm_threshold": 80,
            "low_alarm_threshold": 2,
            "high_warning_threshold": 70,
            "low_warning_threshold": 3
        },

Shortened output after patch
$ ethtool -j -m sfp1
        "laser_bias_current": 16.168,
        "laser_bias_current_high_alarm": false,
        "laser_bias_current_low_alarm": false,
        "laser_bias_current_high_warning": false,
        "laser_bias_current_low_warning": false,
        "laser_bias_current_threshold": {
            "high_alarm": 80,
            "low_alarm": 2,
            "high_warning": 70,
            "low_warning": 3
        },

> The commit message talks about adding _threshold, but you are also
> removing _threshold, which is what is confusing me. Is this required?
> It makes the ABI breakage bigger.

Removing _threshold from the child objects is not required. I removed
them because it is somehow redundant to have _threshold at the parent and
child. If a smaller ABI breakage is more desirable I can drop the
removal of _threshold in the children.

Johannes


Full output without patch
$ ethtool -j -m sfp1
[ {
        "identifier": 3,
        "identifier_description": "SFP",
        "extended_identifier": 4,
        "extended_identifier_description": "GBIC/SFP defined by 2-wire interface ID",
        "connector": 7,
        "connector_description": "LC",
        "transceiver_codes": [ 0,0,0,2,0,0,0,0,0 ],
        "transceiver_type": "Ethernet: 1000BASE-LX",
        "encoding": 1,
        "encoding_description": "8B/10B",
        "br_nominal": 1300,
        "rate_identifier": 0,
        "rate_identifier_description": "unspecified",
        "length_(smf)": 10,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 0,
        "length_(om3)": 0,
        "laser_wavelength": 1310,
        "vendor_name": "FLEXOPTIX",
        "vendor_oui": [ 56,134,2 ],
        "vendor_pn": "S.1312.2M.DI",
        "vendor_rev": "A",
        "option_values": [ 0,26 ],
        "option": "TX_DISABLE implemented",
        "br_margin_max": 0,
        "br_margin_min": 0,
        "vendor_sn": "F7B0CRQ",
        "date_code": "240618",
        "optical_diagnostics_support": true,
        "laser_bias_current": 15.604,
        "laser_output_power": 0.2461,
        "rx_power": {
            "value": 0.0516,
            "type": "Receiver signal average optical power"
        },
        "module_temperature": 26.5898,
        "module_voltage": 3.3812,
        "alarm/warning_flags_implemented": true,
        "laser_bias_current_high_alarm": false,
        "laser_bias_current_low_alarm": false,
        "laser_bias_current_high_warning": false,
        "laser_bias_current_low_warning": false,
        "laser_output_power_high_alarm": false,
        "laser_output_power_low_alarm": false,
        "laser_output_power_high_warning": false,
        "laser_output_power_low_warning": false,
        "module_temperature_high_alarm": false,
        "module_temperature_low_alarm": false,
        "module_temperature_high_warning": false,
        "module_temperature_low_warning": false,
        "module_voltage_high_alarm": false,
        "module_voltage_low_alarm": false,
        "module_voltage_high_warning": false,
        "module_voltage_low_warning": false,
        "laser_rx_power_high_alarm": false,
        "laser_rx_power_low_alarm": false,
        "laser_rx_power_high_warning": false,
        "laser_rx_power_low_warning": false,
        "laser_bias_current": {
            "high_alarm_threshold": 80,
            "low_alarm_threshold": 2,
            "high_warning_threshold": 70,
            "low_warning_threshold": 3
        },
        "laser_output_power": {
            "high_alarm_threshold": 0.7943,
            "low_alarm_threshold": 0.0794,
            "high_warning_threshold": 0.631,
            "low_warning_threshold": 0.1
        },
        "module_temperature": {
            "high_alarm_threshold": 110,
            "low_alarm_threshold": -45,
            "high_warning_threshold": 95,
            "low_warning_threshold": -42
        },
        "module_voltage": {
            "high_alarm_threshold": 3.6,
            "low_alarm_threshold": 3,
            "high_warning_threshold": 3.5,
            "low_warning_threshold": 3.05
        },
        "laser_rx_power": {
            "high_alarm_threshold": 0.5012,
            "low_alarm_threshold": 0.004,
            "high_warning_threshold": 0.3981,
            "low_warning_threshold": 0.005
        }
    } ]

Full output after patch
$ ethtool -j -m sfp1
[ {
        "identifier": 3,
        "identifier_description": "SFP",
        "extended_identifier": 4,
        "extended_identifier_description": "GBIC/SFP defined by 2-wire interface ID",
        "connector": 7,
        "connector_description": "LC",
        "transceiver_codes": [ 0,0,0,2,0,0,0,0,0 ],
        "transceiver_type": "Ethernet: 1000BASE-LX",
        "encoding": 1,
        "encoding_description": "8B/10B",
        "br_nominal": 1300,
        "rate_identifier": 0,
        "rate_identifier_description": "unspecified",
        "length_(smf)": 10,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 0,
        "length_(om3)": 0,
        "laser_wavelength": 1310,
        "vendor_name": "FLEXOPTIX",
        "vendor_oui": [ 56,134,2 ],
        "vendor_pn": "S.1312.2M.DI",
        "vendor_rev": "A",
        "option_values": [ 0,26 ],
        "option": "TX_DISABLE implemented",
        "br_margin_max": 0,
        "br_margin_min": 0,
        "vendor_sn": "F7B0CRQ",
        "date_code": "240618",
        "optical_diagnostics_support": true,
        "laser_bias_current": 16.168,
        "laser_output_power": 0.2478,
        "rx_power": {
            "value": 0.052,
            "type": "Receiver signal average optical power"
        },
        "module_temperature": 31.918,
        "module_voltage": 3.3678,
        "alarm/warning_flags_implemented": true,
        "laser_bias_current_high_alarm": false,
        "laser_bias_current_low_alarm": false,
        "laser_bias_current_high_warning": false,
        "laser_bias_current_low_warning": false,
        "laser_output_power_high_alarm": false,
        "laser_output_power_low_alarm": false,
        "laser_output_power_high_warning": false,
        "laser_output_power_low_warning": false,
        "module_temperature_high_alarm": false,
        "module_temperature_low_alarm": false,
        "module_temperature_high_warning": false,
        "module_temperature_low_warning": false,
        "module_voltage_high_alarm": false,
        "module_voltage_low_alarm": false,
        "module_voltage_high_warning": false,
        "module_voltage_low_warning": false,
        "laser_rx_power_high_alarm": false,
        "laser_rx_power_low_alarm": false,
        "laser_rx_power_high_warning": false,
        "laser_rx_power_low_warning": false,
        "laser_bias_current_threshold": {
            "high_alarm": 80,
            "low_alarm": 2,
            "high_warning": 70,
            "low_warning": 3
        },
        "laser_output_power_threshold": {
            "high_alarm": 0.7943,
            "low_alarm": 0.0794,
            "high_warning": 0.631,
            "low_warning": 0.1
        },
        "module_temperature_threshold": {
            "high_alarm": 110,
            "low_alarm": -45,
            "high_warning": 95,
            "low_warning": -42
        },
        "module_voltage_threshold": {
            "high_alarm": 3.6,
            "low_alarm": 3,
            "high_warning": 3.5,
            "low_warning": 3.05
        },
        "laser_rx_power_threshold": {
            "high_alarm": 0.5012,
            "low_alarm": 0.004,
            "high_warning": 0.3981,
            "low_warning": 0.005
        }
    } ]


------03C2811EEF68F68A81B01D62A01E6F1B
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjIxNDU5NTZaMC8GCSqG
SIb3DQEJBDEiBCBvEV6zyXHLr8eId4O3VSG3ZHi33ZsPRx8zZza7h76GfDB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgA7VIW1KTtu
h5KvrrfvQkA6PhPDJB4mYh/OfBGEfVO+2MFd/8m5RIDE1OEuOyIoao75N9Qb+iEY
78+t9Yc9h0Q4JQb9zgi4/KIS2TD0w1xhfdrGsTzltAcRzO/AnyfZ2TP/3R2thTJb
DrBvH8LypT7kzdUOSwmRSPpRS25tG9Uzp7JSywkIN0ewUgKn2UsfU3Z2j/TB+Acr
5YzpDxPL2vuxOOknea3z6nA4XGkKCxtiYNSfQh9aqOUVoQRfRH/qjNTGWRe+R2QD
Lhc0IKXz0cQQuA4R2nz7bQnCdepXrxRAzJBmOjE/7rDhEtedC63K1MTgySe7o+bd
K9131MdouwPKpgbbBhF5kjGzDhKP+ViODfpJQIeAsatWxnstM3kQz48ClaJOehbb
/scvFwSgW6p1j/4A7GlsqrYEP88raEe/pqRjncVlIuNnLdMNmLRdeWxUIzI+wvgG
tmHB17PK8cm/qStMO6zlxLFDKo5iOg/ccHI+1oa5SHSTf651Yac2qcoj6/G0j6NF
g0PSke/rFW0NXuTPXkg6NYe/I4gz1EEkC01AQmBZKA4ZX1TvJcQYAx1urEN8KkvZ
Lns75eYwNKOsbvemnT2o3y/79rgRObJ0VcKcQsn7P5t4/hWa7+ivN3MZY8QDb8lu
TP3MuDn2kiZ4+TgDfW8mGMjbKdLOvg2FsQ==

------03C2811EEF68F68A81B01D62A01E6F1B--


