Return-Path: <netdev+bounces-119139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B43954530
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A94BB21C40
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CF13C667;
	Fri, 16 Aug 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JxOmGl5V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80E13AA41
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799430; cv=fail; b=O0a3Nx6K4Pj6wNfPpamdjI+pOvifsYWhdKgKkoSEFwXCsHEs3m0LB0RxaT+8wJD7Vz2iY/RtknYrw1wK3FbzY5WOfOQ1szfwuXBzCn+CR4TQo3YyiJtW4boKgc9scEl9QcPR48KkSB5VXUzH9y3HMYiTT+rmsQq8B9MFALx0vKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799430; c=relaxed/simple;
	bh=sqQWku8yRCHvtJqh5Ud9tSARSxJIMSBYPwWUJ56lYMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxKUsnVAFAcmHxehjfK1miZutzWXd5FgYYIS+lY17MSZjlegOnV624qgv5CJ3UNL7s11XIh1e8470rCJWTVgzY9RVhfhftzpTZykrX5hyyYNKfrOYiDCVwbYhfZ0URwk4bIARw3PQ8NWjzKhQquwAy9fQYDK2Bg27ygkXJnU7VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JxOmGl5V; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNDnuH/oQkRs7RWeH3oJoOt7VUU/hjwrbQieq05QGaT0KAWF2jjgQFFIUkYRuhJqoKzvE3bZkyKH/rHPKGiHrdx/qa+a7nRhTl6VgyxghniSfqAauGr9yRwyM6GMjNpO+UQ6T/1MG9MP6SwJMvFP3Xrp6hCFKLQPfPL9s84+0zz9TKIB42l4IaIIQ1cdh+jafjIP5/gbSrIP5U4O8U+JjHkLdghiT+p0zSbHtxWb1XQgXrFtdeh3XqAOytv0F3kvR1XMYzDaZWymHdwoAruw0b5CW1YAG5b8M7RlMd1yzxs0uki3mMD1HkapcSx9iDok1bR2pkM4S/Ew2dXvPpR2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqQWku8yRCHvtJqh5Ud9tSARSxJIMSBYPwWUJ56lYMs=;
 b=LDhuTtVMtKwYu56chuQM3W37jSWxhSKWJZFXN8KrSDYMuWWCi6qAc3ZWaeMjJTNOQAUQe3SAoDef3uRxRIyYdL92dgely3q6yJUFbo2MMcfACyXca7gl61EDF1JpCQu6jS83Iozb5260ItDj5KyGJZxoIqHl5klwbNqAtOVeLPERKCPvjR/9PyZMLUqr+BVq1fz7aYKLin2uYLj/LQ6VkPPl8Jcojjy1gLUEJHCBMx1O8B4jA5SRZOjTLLBmbGUyTPWiV/QRNTLmVYKVrYKbIKysISHeDTLXyozBfDafMU4ctb4jgktMSHncnUrtUS56NlVIE0oSGQ9MTm6zm6IrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqQWku8yRCHvtJqh5Ud9tSARSxJIMSBYPwWUJ56lYMs=;
 b=JxOmGl5VxEAYw+vxUTGucvCHKib9JUUXd+15K1lKAK0Xx7XDs0tNbcPSZUrOshmuAr7RY249OqqaVN06RcZfxzI06DZ5RMYmu65ruzJ5eJj+x/YGoZdHrcDL1Pbctxfk0cHnW8joSDnUFCjibPKCFj5cRv8eUn+KdaTIIiwy8gXI+ONEKu5wkESOcVjcXWULlqfdhL+nnqNaKfkZGykRgn7jyzUDZ/R3fS1cAFwl1vgZUd6qR3rk0s3m0FzV6turuWSzG4Vl4qQXnSATJWfOc9bbovJ42g0meCLanZu7WtooZd5Kk2M3Gc0XRYQO2SkFhfgyqGLoNe1RYMZd4IAnSQ==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 09:10:25 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 09:10:25 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Leon Romanovsky
	<leonro@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net V4 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V4 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index: AQHa7x6jL7NB5X8oxkij4wjap8vVZrIpNLkAgABlSgA=
Date: Fri, 16 Aug 2024 09:10:25 +0000
Message-ID: <07bad330d9259f851a5b6354c1c6a72587048c0e.camel@nvidia.com>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
	 <20240815142103.2253886-2-tariqt@nvidia.com> <Zr7CiE9Rw8cxvzPf@Laptop-X1>
In-Reply-To: <Zr7CiE9Rw8cxvzPf@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|LV3PR12MB9119:EE_
x-ms-office365-filtering-correlation-id: c505f113-38ae-4635-e3cf-08dcbdd34403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHBSemdjSEt4MFIxaW4rMnIrUjBLbzh5YnhtdmYvTVN4U2EvM2dkTjcyY0Ru?=
 =?utf-8?B?cEtML09XOTdDTHdCVTRZZ2pvNTJOdzgrMFNUSXYrV3RtWGdpTnZLYk15bE9Y?=
 =?utf-8?B?TE5LeVF3SWszclpLK1FmMENQeEhIaTA2bm0xOGxySy9lZDNVZ0c1RVRiWXR6?=
 =?utf-8?B?dXQxYVF2NDhHR0ZiM0hGT0ZFcThKZGFqeStVaGdmQVRJYXNUSFZoSlBvc1I1?=
 =?utf-8?B?YnRra1ZBNTB2Q203ZS9EWUx0dWxYaU9KYk9JWHliZ1U0RXJvRk5PWTJ4LzdW?=
 =?utf-8?B?YVN6QWlqQVFWdHllQkNwYmM1NmtYdW8xSzJudkZKOUhDenhJSkFlS0tzQnh5?=
 =?utf-8?B?MkZZcnlJbkpUeHh6QmE4OXVuRWIwdGxJQlFkeWhINVE0Wmk5ZHN0YmF1eW5P?=
 =?utf-8?B?RjV6NFM4SVVmVHZjUmNkNTk2NE9oWnc4ejNTQTlOWG43ZFB1MFJUeC9KTnJr?=
 =?utf-8?B?dlJpdlltbm5KV0YvUHJ0MjVRSVhyTG1xWDJ5cUQ0L1p6NkVRRHRLMUFJS1hh?=
 =?utf-8?B?OXdsM1Z3cDJ0NGRpMzNjY3hwU0w5a2lvN3FpTlVUTEtoRzRITk0vY01VODhU?=
 =?utf-8?B?dXc3UlBjWDdwK2g4YzZ4am4wYmNESXdpbzJBT1V6UWEzZEYvSGROVDhBa1Iy?=
 =?utf-8?B?STFSRWhZdy9MbEJiZXBUVDg1aCsxcmQrTzQwRDlZZ0M5TTk3dllVblAvWkQr?=
 =?utf-8?B?cUlYQkpDUFdKaFhPdzRWRllIZGxoOEpEWVlQMHVESkFOSTlHZnNUZ1J0MWhT?=
 =?utf-8?B?YkQveXozTmJqcHZwa0ZVZDVXOEdaM0N5QXVCU2ZCZkFVMnBXaDlSUFdBNGpZ?=
 =?utf-8?B?ZjgvVmNMcVV2bjdTa2ZMQStHZDU4UG1OdjJSNVRUekkrUHlVTUFVeDhsOWQv?=
 =?utf-8?B?Q01FSlBJSFByaWtOVWFLMFdFY2IvTmg0RjdDN2lDRmpyNXZtK2R0aDRzS2VN?=
 =?utf-8?B?OWxQaWNiYnpqbzM3YW1yNU9SZGFFWXR2SjJNT2dURXdlUXFYWjBzRi85bGJF?=
 =?utf-8?B?MjgyQ2R1VE5FdGpuNWE0d0YraFlQakpQb01vK2VjblRMd3lyOU9wTEVudzJy?=
 =?utf-8?B?WmJUTGY0ZUZUbjVIbWNiRmtqajFOdEprMmFLUGRTOTZBWmRIclhlVWp3aHp6?=
 =?utf-8?B?YWpTd0RETnBBaFl5TFdINEU0aGc3aXo1SUgyVEtmY2t2bVRTV1FaZ21EdmZW?=
 =?utf-8?B?UE1zdXlyY1dNZ21SQnlYWTRDMjUybk9kT2xqQWNWVHcvMlk2L0NmY1NSRjZN?=
 =?utf-8?B?ODZGV2t5eVB0OTJUN1NFRWdDbGo0VENVQ1d2dE9heGNWeFNlMzFpUm1hcGxL?=
 =?utf-8?B?NzI4VURiQUhaRFlhVEJCbG1IVUtvUFlnR0FaNldZejdDQlZISFdTZVJLVVNV?=
 =?utf-8?B?RFFRbHE3b3dHck5DK3VpeFU5aWhWZ01vUmJ1c01jTnFlSWRkVWcrTHdJbUI5?=
 =?utf-8?B?OE9OcVhOdmNjN0UrRFdmaWlUbVkyUFFwT1hpeTVWZkNRYytITElKaU1aWW9u?=
 =?utf-8?B?OUlYMnVJL2ZBbmxrVHBiMUVxdU0zOXpwY2J4VUp0clRlUGMrK3JOblBkMmRv?=
 =?utf-8?B?YSszbm1HRm03NWg4ZmpQaVF5UEJsR2tPbXAwMjZjSTJrYTdEWkRmN3RKMlRI?=
 =?utf-8?B?Tm93YnF3ejJoOWxjNnRHWkZkdERwcFNBb0FtVlhxSEx4UUxFc3U2V09jVmRr?=
 =?utf-8?B?Qmlqc1AyV20wak4rUm9sUXg2MWhzeTc0alIzOCtoaFhnMWMyRVU5cy9RNVc0?=
 =?utf-8?B?bDFTME9zVHFlbkJQUGlGVVMxYlo4ZzcwVGlndTJlM295dEF0cEc2d2k0ZDFD?=
 =?utf-8?B?NHZ5YUd2QnZnKy82NEwrblpJdjZyYTZCbjU4dUlJcnpnc3JWTkFGaDYwZDRy?=
 =?utf-8?B?amEyeEQrd0tNRWhHZ3UzcUZGM1kweXJUcW9SWitNYVhJZUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVVBRTlXSThyNFBhb25CWmM3VGQ5eXhPcmlhMVhZUDNTRG8vbnNKdWUycTVl?=
 =?utf-8?B?czQ3WisvQ0xRZHRwcEVHR1FHODBzLzYycU9nNWtzRk9aL2svRW9WajZ6d0xn?=
 =?utf-8?B?MGhrT0RJbGhMWUdZZFZpU0ZDNm03c2JxenE0UXY1cTFvSUVlYUZYQzBmNXM1?=
 =?utf-8?B?SlZST1c0VFZxSEZMdkpCWWtYSXFiS0M2RTN2THdFS3cvWnlwcHIwV2lTMTc5?=
 =?utf-8?B?Wkg3akdtVUFyVkM5NW5WY2FZeTZ1aEMvTktGVkUyQlcyNWxlY2Fqb05ReFEx?=
 =?utf-8?B?eUg1azQ2S2RSY1JPbXI3SmlBcXNpNXJ0enpKWENnbmtiUjVsaGhlaVFmNTR2?=
 =?utf-8?B?WjU5T3A0TlF6T2dwR1J3S0RycGlsRkVEcHl0ZjRRWEoyRnBMbkJ5dVd6bmJ1?=
 =?utf-8?B?WHg0N3NxVEJldzhVdkVjVHJXb3l2c3Yxell3Mlh2OXF5WWFzaCtLMk12RmRI?=
 =?utf-8?B?VExvME9lSWJDejBkSGpLeDQ2R0Z2bUsxS3pVTlFhbjhYT3liODFDZUJCNHZY?=
 =?utf-8?B?SnU3b2IxZXo5WThkc09nSHRuQVJ6M1F5V2ptMnZaY3NTNVNzZlhZaVFJdnFw?=
 =?utf-8?B?SjJ2SDVMYS9JNXhNSjcydkwxOVF1Ump3bVMzY2w5d1Y3QkRKRjFoY0JPMG9Q?=
 =?utf-8?B?V2VLc1h5T2dQNTZJR2hlcFE5NktpeWxubU1tN3o4VFc2eWNFNHlPQlgxSjRH?=
 =?utf-8?B?S0JKajdGNEZ5eXJpdkxLWE52U3U0TE9CdzhadkRrM0ZUQ3JjWkoyTUt5cnpC?=
 =?utf-8?B?UENUUGtuUHZOejhBRzQ1dDNzNUVlNnlDMGhzcHNrZ1J5RVY3SVJ4dGJCSHBR?=
 =?utf-8?B?SjJPZVpvK3BkUXdtYVhYZlE4K0U5d01OalUraHdpTGc0T0RlWXk4Uk0wbWJw?=
 =?utf-8?B?MlhDdENJcmRQZE05TThlMThDTUJDRktpWTZteHkzNmh3OWpWZU04TlZNZzdv?=
 =?utf-8?B?YnQ5ZU5YVlo1dmIvMTNKMGVPYUJIbHdPdmVZOVRKTWZ0V0Vqdm05ei9WZkdR?=
 =?utf-8?B?a01kYmxUaVdwMWpUeHR6UXpHSUVKWm04ZS9qSFR6Uk1CQXhNVTYrRkFaUGJJ?=
 =?utf-8?B?RlNFeE9rZ2tycDZnSDVwS0FmZWtGdTg3QkozZmU4MHdPdTdrRm1qU1dNby9n?=
 =?utf-8?B?ejVQaG1wL3pJeGNBQzBhdnNMN0QwT29rellucDRBbG5xWWlxK1ZiMHAxOG04?=
 =?utf-8?B?ZmFLcWJ2dGdxKytPWEk5Wmx3Uk5Ld0ZYZFpFc2Q1ZmR1RmNiNFJtVWlWOEo5?=
 =?utf-8?B?aGVqUFdhajNIRWlmZHdMZStVYlRmV3BNSTNmekpHN3lIZlMzWkVvREVxN043?=
 =?utf-8?B?cU5lM2UzSXprdERBWEFXMjFUQXdFTnVyeU11eFdTeUJ6R3dubVZMZVBBUjYr?=
 =?utf-8?B?Zncrd2hEQlB6QTJCTnJIQk1hUlFSdlFsZmFvN1B2eks2YS84WWM2TG9LR0M0?=
 =?utf-8?B?bUljRzBaSjZvZjhPVGhLcUpZenh0Q3p3UlVSZ1gvcytWaXpNZzd3VElNSzYy?=
 =?utf-8?B?VWVaSlpBdDRTbXlzbzV6OUhEcEFqOUJXMlZzTHNlZUtuOVpjaFU5ZG5FTkkr?=
 =?utf-8?B?ek92dXUvVVBZbVlMTUpVRW9NaGdQNG1OWmoyVnA1QlNMekhCR0lzcFZzV2JR?=
 =?utf-8?B?ZFdXeDk4RXB6VFNxTnd0d0l4aUtlYVZtdWNycDJ2RnpJNHdGdnV3VXY5RnlS?=
 =?utf-8?B?WU9ZYmdycVJnY1lydmg2RktUUUxSRU1DYVBMUnFkYk5DVnI3bzBUMDhkSHBo?=
 =?utf-8?B?YnYvcW13Znp0dkJCTnJ1bUFES0QzYStkQ3cyN09IRDU4SFA1UFlPU0ZuaFpj?=
 =?utf-8?B?UnBPMDVKaU9WQ21JU1QwbkNsV3M0WlBsaVFkQXZTbEdJOVZ5ZEtGVm5jQzFi?=
 =?utf-8?B?c1BZMkp2ZEc2TE4wNVZ5dUVXRjZsTmd2Z3pZN1hzRmhpUFl1NmFGRmJkUG10?=
 =?utf-8?B?MjduRU01Wmw3Rlh5ejYwK1UxWENBanp1UGxGdDFnYy9SRDZzN1dNOFkzTXAv?=
 =?utf-8?B?TVp3aksxNnMrM2RpeUFmNVBhTHBaZlBLQysrcER4RE43c2JndzQzNlRHWHJx?=
 =?utf-8?B?bXZPTGVoeU83UVN3QW01OFhENFpvd2NKT3VGSDhCbUtmODE3cWsrT21mMTFk?=
 =?utf-8?B?NjJpeU13bEhObkZlYW5qQWlTbi90ejg0Ty9ZU292eHFhWXc5cUZUK2R5Y2cz?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC4FB45F0AABD44B15E4699992A115A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c505f113-38ae-4635-e3cf-08dcbdd34403
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 09:10:25.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4V4wCGloExqY/ZL9+5pPlZ4xCRW0Z6IXjaSt2PdbNTtL4VEsOJaCUX8opKcV4NYq+rEPl1pCq8Pu+S5mzh56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

T24gRnJpLCAyMDI0LTA4LTE2IGF0IDExOjA3ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgMDU6MjE6MDFQTSArMDMwMCwgVGFyaXEgVG91a2FuIHdy
b3RlOg0KPiA+IEZyb206IEppYW5ibyBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBBZGQgdGhpcyBpbXBsZW1lbnRhdGlvbiBmb3IgYm9uZGluZywgc28gaGFyZHdhcmUgcmVzb3Vy
Y2VzIGNhbiBiZQ0KPiA+IGZyZWVkIGZyb20gdGhlIGFjdGl2ZSBzbGF2ZSBhZnRlciB4ZnJtIHN0
YXRlIGlzIGRlbGV0ZWQuIFRoZSBuZXRkZXYNCj4gPiB1c2VkIHRvIGludm9rZSB4ZG9fZGV2X3N0
YXRlX2ZyZWUgY2FsbGJhY2ssIGlzIHNhdmVkIGluIHRoZSB4ZnJtDQo+ID4gc3RhdGUNCj4gPiAo
eHMtPnhzby5yZWFsX2RldiksIHdoaWNoIGlzIGFsc28gdGhlIGJvbmQncyBhY3RpdmUgc2xhdmUu
DQo+ID4gDQo+ID4gQW5kIGNhbGwgaXQgd2hlbiBkZWxldGluZyBhbGwgU0FzIGZyb20gb2xkIGFj
dGl2ZSByZWFsIGludGVyZmFjZQ0KPiA+IHdoaWxlDQo+ID4gc3dpdGNoaW5nIGN1cnJlbnQgYWN0
aXZlIHNsYXZlLg0KPiA+IA0KPiA+IEZpeGVzOiA5YTU2MDU1MDVkOWMgKCJib25kaW5nOiBBZGQg
c3RydWN0IGJvbmRfaXBlc2MgdG8gbWFuYWdlIFNBIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFu
Ym8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFyaXEgVG91
a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSGFuZ2JpbiBMaXUgPGxp
dWhhbmdiaW5AZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvYm9uZGluZy9i
b25kX21haW4uYyB8IDMyDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMNCj4gPiBpbmRleCAxY2Q5MmMxMmU3ODIuLmViNWU0Mzg2MDY3MCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+IEBAIC01ODEsNiArNTgxLDgg
QEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19kZWxfc2FfYWxsKHN0cnVjdA0KPiA+IGJvbmRpbmcg
KmJvbmQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzbGF2ZS0+ZGV2LT54ZnJtZGV2X29wcy0NCj4gPiA+eGRvX2Rl
dl9zdGF0ZV9kZWxldGUoaXBzZWMtPnhzKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzbGF2ZS0+ZGV2LT54ZnJtZGV2X29wcy0NCj4gPiA+
eGRvX2Rldl9zdGF0ZV9mcmVlKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNsYXZlLT5kZXYtPnhmcm1kZXZfb3BzLQ0K
PiA+ID54ZG9fZGV2X3N0YXRlX2ZyZWUoaXBzZWMtPnhzKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlw
c2VjLT54cy0+eHNvLnJlYWxfZGV2ID0gTlVMTDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+
IEBAIC01ODgsNiArNTkwLDM1IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZGVsX3NhX2FsbChz
dHJ1Y3QNCj4gPiBib25kaW5nICpib25kKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91
bmxvY2soKTsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+ICtzdGF0aWMgdm9pZCBib25kX2lwc2VjX2Zy
ZWVfc2Eoc3RydWN0IHhmcm1fc3RhdGUgKnhzKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IG5ldF9kZXZpY2UgKmJvbmRfZGV2ID0geHMtPnhzby5kZXY7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgc3RydWN0IG5ldF9kZXZpY2UgKnJlYWxfZGV2Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBib25kaW5nICpib25kOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBzbGF2ZSAqc2xh
dmU7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghYm9uZF9kZXYpDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDC
oMKgcmN1X3JlYWRfbG9jaygpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGJvbmQgPSBuZXRkZXZfcHJp
dihib25kX2Rldik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc2xhdmUgPSByY3VfZGVyZWZlcmVuY2Uo
Ym9uZC0+Y3Vycl9hY3RpdmVfc2xhdmUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJlYWxfZGV2ID0g
c2xhdmUgPyBzbGF2ZS0+ZGV2IDogTlVMTDsNCj4gPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91
bmxvY2soKTsNCj4gDQo+IEFzIEkgcmVwbGllZCBpbiAgIA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvWnJ3Z1JhRGMxVm8wSmhjakBMYXB0b3AtWDEvLA0KPiANCg0KQXMgSSByZXBs
aWVkLCB0aGUgUkNVIGxvY2sgaXMgdG8gcHJvdGVjdCB0aGUgcmVhZGluZyBvZiB0aGUgY29udGVu
dA0KcG9pbnRlZCBieSBjdXJyX2FjdGl2ZV9zbGF2ZSwgbm90IHRoZSBzbGF2ZS0+ZGV2IGl0c2Vs
Zi4NCg0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXNsYXZlKQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDC
oGlmICgheHMtPnhzby5yZWFsX2RldikNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBXQVJOX09OKHhzLT54c28ucmVh
bF9kZXYgIT0gcmVhbF9kZXYpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmVhbF9k
ZXYgJiYgcmVhbF9kZXYtPnhmcm1kZXZfb3BzICYmDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0ZV9mcmVlKQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWFsX2Rldi0+eGZybWRldl9vcHMtPnhkb19kZXZfc3Rh
dGVfZnJlZSh4cyk7DQo+IA0KPiBIb3cgZG8geW91IG1ha2Ugc3VyZSB0aGUgc2xhdmUgbm90IGZy
ZWVkIGFmdGVyIHJjdV9yZWFkX3VubG9jaygpPw0KPiANCg0KU28gZG8geW91IHdhbnQgdG8gbW92
ZSByY3VfcmVhZF91bmxvY2sgYWZ0ZXIgeGRvX2Rldl9zdGF0ZV9mcmVlLCBqdXN0DQpsaWtlIHdo
YXQgeW91IGRpZCBpbiB5b3VyIHBhdGNoZXM/IA0KIA0KDQpUaGFua3MhDQpKaWFuYm8NCg0KDQo=

