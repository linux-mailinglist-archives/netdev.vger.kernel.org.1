Return-Path: <netdev+bounces-98436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96238D16CC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200BB1F21BF3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D18771B47;
	Tue, 28 May 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YhnPZCho"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704B4F1F2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886974; cv=fail; b=igFX/IMLwSWhPhtSz1x13tsmpLYrALIQEFjGG4AogE0ckbzIn4wzBxm7plM77DQv/x/UiakjqSN6Vzc0XkjDpqSAALavkCUtNGTCAaTz+sIWzhE2c2aOEIPeq+27TcBE6ey5RU372SeY3ooRLh6KPpWyoq68vRSBBAnHDi8tzgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886974; c=relaxed/simple;
	bh=er0I0lcp0SC54zWL/JzE69dRJ26Ydx0ATUaTuys1vik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbC3nfcILlSuAnDzqxiRuK/VrG9FuHvDyMJO9lpgLgeVyDhNoupP0Up6GVRCUILoo6QT+DATY4CSU7vClI7O/5np9122ElG2SV/c51WBpllsRVNVZdMoqdVVUkTySHHJqhK6jXmxJa9tgTwmK9lVB4n6NeQzvT5Gg2RSLG4LNkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YhnPZCho; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQxogob7FdqxstOY7orC1j0sVYCBa/eFL7eDTFdsNW+DVvd379sCtaxDsT6RBrQ7Cb/cKsWF6Eqolhmv5qv18+/9uhC2hm6vK+/5oV+4uz8Qbrig/pTczAF4430WhsbmEJqQm+uNuX91NJo2HeRte1jFbcfz8JUw8PiWfxSzKnUWihwgLeYkply563wsvj4jHSz/N2A5CRs+lhYAKASqw6p/BKR0VpcyCpVHFI+yHII2Jcp2ze1EheCiyMODmiFyCM62R/lXHvvIoK3Q7nsMQ0tjGZ/497ExI1bELwY+BkGgzQyr7DQRXsZ54YTOvd1iInjZiAfdD42UDD7SGx7KAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er0I0lcp0SC54zWL/JzE69dRJ26Ydx0ATUaTuys1vik=;
 b=fdLo2CvFVY80NHwVSc/uKWlQFL4Z4AwwQqM46A5JbLpckeGrpks+MqHYwFraf30mGtmOch+SHPB7LTnaBs63gvgf3BA3UzrDxDeF8yG2mVgQmijQWTBmJ3/HpgFB4uqmtGLdWVTWrYRhcS0QPWEEqFJtgZETedPPa2Pw98jWDvUlrjG47oax0akeYcwxgqfysECe1wGkzxh73K51+pLwOqCmDk+n5IpmtAmcs0pzkVVaOYKiGNLcArl+3ZbfzI9/dHMJZODzy5UZizyaeyD4E1UMkntjVWe3CW9y9js65rCAjjy1i2P0h+eI9meVlwNt17BojDHlJ/cu/AEPA/6M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er0I0lcp0SC54zWL/JzE69dRJ26Ydx0ATUaTuys1vik=;
 b=YhnPZChoLNjE3BCP61VQXG3SLrg60V8m5IxDW8zejKPNuUsH6nL4PFG31D3Xeng7bbc8IhPExCUW9u07vilnpQbViKVkXum5YYFKDZjYxibvGccYxrRV7nX28cvc0GZ11f4G9lAQakM6avFwF+fQqki/z0qmhNTe3R/4PLOj3JdfN6nCq6IYPsLV9weUma6e7z0pJx+lVKBHPb5AwhTzUDrBh4jL8HHNYFH3R1EV805FLcO1V2qeIJq3OlkeZF9snyxIL1ezXcZev/KSXmCI428z4MhWIsprUr6fpV/ywAJ8+5Nbdhz6tRAS0JzX0qy3kxtqQhObkMTdkXmdaW6SHw==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 09:02:49 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 09:02:49 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index:
 AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIAJgugAgAMbzACAARmhgIAASUoAgAADfACAADMPgIAAWyIAgAXHJICAAaQuAIAABS2A
Date: Tue, 28 May 2024 09:02:49 +0000
Message-ID: <e6f70384717d85fb1604566530afd02a594f427f.camel@nvidia.com>
References: <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
	 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
	 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
	 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
	 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
	 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
	 <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
	 <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
	 <ZlQ455Vg0HfGbkzT@gauss3.secunet.de> <ZlWZYOMaiAUE8a3+@gauss3.secunet.de>
In-Reply-To: <ZlWZYOMaiAUE8a3+@gauss3.secunet.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|SN7PR12MB8058:EE_
x-ms-office365-filtering-correlation-id: c7a8cd78-5035-49b5-de74-08dc7ef4f306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFJIVEJGSGd5TDN6dEFZbFZITHNabEt5WVpOWjBwQ0NPSDNKQ0JET2lDZlJB?=
 =?utf-8?B?U1h1QWdsajZ6ZXM1NlBSWXVuVHJ3SlRUeHBYU3FXbWVjQml2enEyamVFbXEy?=
 =?utf-8?B?eDNQRC9ML1NNZ0JzaG9zZllhekdDRWJuMWM0UC9vcDI2MFROVkpJYmVnOUdT?=
 =?utf-8?B?SkJZNXRxandEZTNnZnRUNVpuTkJnRjJnTktINDZRMzlFaHJNR05HMGQ5WUJ3?=
 =?utf-8?B?R1V4S21iL3EyNTYzVnhpcXN6ZW8zWDdPVloxL0U4dlJHajFTTmlNMkZ5NTdR?=
 =?utf-8?B?bnZlQVdaOC9IczJzNHlHSUdqenJXcWVjaHQvVDRKNlQ1YmNQdjNQWU1SOWNC?=
 =?utf-8?B?dVZjbFZPRTB0ZThBVnBMZTlwdkJjbDdqdkNQYTJST3ZrejFEeTN4UmVCVHRG?=
 =?utf-8?B?M0U1TTAvRlVaZWU3cVExZHlJeGliNTdjd1dncjdyQy9RVXVhb2VoQ2ZNTllX?=
 =?utf-8?B?WG4zWTVrbzc2UHNkK29vUHBPTnBPY01Qdjc3NFgxcUhhVmZjdnF6UFo2OTBH?=
 =?utf-8?B?VEZ5c1hDQTZLK0lSTk9HWFd3TjRMMW9EUUNCbEo4Rks4YlFyaWE0ckowTFNS?=
 =?utf-8?B?TzBieEpxbHNxZkFIWkZ5QmJvKzNnZUtEYUllM3NzUWd3QTh1MUhJUFVmb29U?=
 =?utf-8?B?QUlSMGdNNFlwY1BiTnZrbzUxeWc5UUNPS1ZrYkRoRXpXZXUvVWpDZU5kbmhC?=
 =?utf-8?B?VWQ1NEdZZSs4TmtLVVA4b2s2RGI4OWI4OGFJdTJrbHdHc0J2WjQxSEFhSG5G?=
 =?utf-8?B?MGxzK29PUnRmK2ZBY3Q1MXZzZDdrWExEa1B4bllaa1kxNUo5Q1NSTGF1QWhL?=
 =?utf-8?B?QVk4SUdVL20vajNlTW45cEFMTnhsOFlSRlV3bENDaGg5c0JrSGFsZWNNVG9w?=
 =?utf-8?B?QlQyTnVoS0U4R010SnpMWnowdFpxWXR5Nm8rOFk3a0JGMjB6aG9IK0JUU1FO?=
 =?utf-8?B?T0t4azlVQnBNYm81eDZFeDlJR0E5VURPWHQ3ZGgzYVVQOEIzRVZ0UmZSNGJM?=
 =?utf-8?B?aHNmb2pZTVNZelJEU1FhMGxZR2ZuS2hUdlhLZENoM3NpMm5tV0lIYjBMRFM4?=
 =?utf-8?B?bDlCTDYzakhaTDNBcmVMSVZMY3VMZWZFcmxMdUpqWm81K3FUNlorclBGNDlB?=
 =?utf-8?B?Ui9zR3A1YWVzSThveHBFMlBUOFJKOTVZVGg3bjVMWGZ5c2d4OENpZmsrdmc0?=
 =?utf-8?B?bTNUMC92alFFL2Q5S0g3SnlMYklUYW9zMGJKcjFZK2h2Tkl2aHFGRmlrejZk?=
 =?utf-8?B?R055b3drdStUaUI4bjlMcnRNdzVhM2Z1TGxDSUY3MFRQZCtib2ZIQVBkK2dx?=
 =?utf-8?B?Tm5TdlNhMzIyRzBuYXJGMkZhOG82UTJnMzdTNWliYkpwNUg1K2l5SExkb0cx?=
 =?utf-8?B?TWt1VnNxZFprQXFlbUY2QnlmUFBlK2I1S3M2VlM2Y1ZzTEg3TS9GeG5zbFFy?=
 =?utf-8?B?eFppSEJ5N0dBaytlUmplNHk3LzVsd080OEJ1bVhoMCsvT0hGQ0xNZm1hcitD?=
 =?utf-8?B?NHVOL0syeWsxOXRxcG1ERW5GbHo0VnpqY3RwN2h5OVhodDh4RS9LY0I0aTJy?=
 =?utf-8?B?cy9oREt2SjRMTVNjWXoxcGdJSExKdGExTzhTUzQvQnZqTVZ3ZnNSYTVBd0hl?=
 =?utf-8?B?NGptaFdOVFZyV0huVkFZZ2RTYnFUNktpaGRRYmRLTE4vdDFTaUM5ZlRXWEdD?=
 =?utf-8?B?SExaVTVHWHpwU2dLdC96b29MQzFqdTVsVzlTNGJlOXVIOEovY015MXZwZ0Jw?=
 =?utf-8?B?aGpSRytFd2FYTmVuSmJhQzV1R2tSczZyQnlXeWVrZitVc2lwSml5YzQ0Uk16?=
 =?utf-8?B?bVVFVFBXcldTa01hMXMzZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0FJYk13dklsTXkvc3o2TitHeCtBZytrL3NWZXU4YUJ3OW1UaGJNQjVPNnpK?=
 =?utf-8?B?NjJMYTA2QjFBcWdUMEtpWEEyeEl6MVNoc09JZDRVRHF2Z1pXN1hURTlQTWNw?=
 =?utf-8?B?cEUxZCtoZy9pSGFxRXhlaXVrcnN3eFpsME44NlJmVEdPcTV1RnNNRmxmVjBS?=
 =?utf-8?B?SFhkeHkvZUZENDFTNUgzV0hWQXQydVhvL211MEpUaXZaNTc2bGswbkNURFB0?=
 =?utf-8?B?aU5HZGcxandlL2pScFNLMHl0L0lEWEtPV2VLNjhlU0FBTEVOaWcvdUVIQUFL?=
 =?utf-8?B?SGdyM1ZzYWNrTjlYTnFDcFRyTDE0Zm5Bd1FzcTNiMlZJZHBxdWREVXNOT1Rn?=
 =?utf-8?B?T1RNK3VrYS81RjRpeS9WMzgrcFJ6ZnpxcGN6czNRWmxOSFoyQmorWUgybkVK?=
 =?utf-8?B?emU4Q2V3QVlKSDF1bURXajVsWjNGWVZpRTZkb3BJNlhORFJFSkt3bzdCQURZ?=
 =?utf-8?B?NjA0c2tqSXN6NmpZdU44d2ZVS2lna013RlZxdkpwWW5GbE1VYkMrN3VDaG8x?=
 =?utf-8?B?VTdVYWRLeGQ3cUQrd2V1OGliUERiQWdUY0swQVluaXdtSUxQT0IwM2srbm12?=
 =?utf-8?B?VHZtSW9ua2JhcTg1aGd0VXVjRWRUNUhvMHMwRVpzYTh2bHJ3QnNocGJiYXl6?=
 =?utf-8?B?bDB6Z3B0MVRBTUxIdGdhdm5JNUR3M2VlSnFXam9FemsxQjBqaFBrR1lzbjNF?=
 =?utf-8?B?NjcrWW1zNTF2NEtlcGFxWTNUSUNzWXVuN1E1SFl4cDRkM0V5SjNkM2xIZEtC?=
 =?utf-8?B?Y0o1TndKc2cwczlCQm1Cb3EwOEFUMHN2TzlzQmpDRlFyK2hsQTNBeFpzbktz?=
 =?utf-8?B?RHJYM1prVGh6MlJLSFFyQXd6UGxxN3BEYStPRFFpMk1ZbkJnc1V2U3lpQ1Nw?=
 =?utf-8?B?TGUxeTJjeUQzV3RZalVMY3BRaVNaOC9LaFhEeHBCaFQ2RDhDelZoWVhKUzFr?=
 =?utf-8?B?K3A3OXlJSDY4aW5TQ0hFT0tiaVdDQ3gvQ0Vva25XR2k0SVlVL2tkM0k3c3hx?=
 =?utf-8?B?bmRrbkV2ck04Y0ZoS1MxUHVkN2FCNjVEazdZaWp3ZEU5MkpNUTlBbnYzZlQ2?=
 =?utf-8?B?NDA5WG9SUUk2Smk4MzRjeXI2MG1DUFNHMVFjaDd3TVhHSzlSeHBzeG0yMjNq?=
 =?utf-8?B?OWhvVzloUGtMaEsrMXE3RFpEY2RoNzNlQUVKU2lMaVlBYVNJTzFIYXZ1Tmt5?=
 =?utf-8?B?RjFjdFBZcHNRSlhyN1dOWXZqRjd6b3h5Y2JCeTlqYlBsYzlzeTRLTGtpVzVm?=
 =?utf-8?B?L2Y2ZUQvemFLWWZCVzVRQjBxWk0vNEtVaHkyVkM0UDMzSlBubmhQZlVwSTVN?=
 =?utf-8?B?VXlmdEF6NDdUYUlOQjhhTXNqaVExRzRScFRLelcyYk85Z3lKaDVyZGowUmVC?=
 =?utf-8?B?dUVtZFR4dHJTblJYQkEwVFhEUnJnMzY5RGhleVFodGxQSjRmcGc4dkdJS0d2?=
 =?utf-8?B?SER2cHlROHhmQVBlSHVHNWJreEo5dWtSMjMyUktrejdhYk5UeVp0YmpJV1RE?=
 =?utf-8?B?ME9ZeG9MUGRlZVphOU15Mjdpd0FUY0dCVXA0UURudGhrRW1oT3lyNklYcHR2?=
 =?utf-8?B?eVhqWWdTUDFpakQydUw3SHcwUncxYjRjb1BGTEVyVjVNMS96UlI5aGpvRkhU?=
 =?utf-8?B?Z0FXenkwU252MXIrSGhQK200V0c0S1NaM0s2YkNDcVJnSEJUY2YzTmNNSW5V?=
 =?utf-8?B?Tlg5ak9jOTRQTkEzdkZ3OEtibDhuMEFoajVtZ0dsdEZ4RGZrYW8zeUZpYzI4?=
 =?utf-8?B?dzIrZ2dsZkdHdzhOTzJtaXd2ZkkraVZMZG03WGlYNXRRZVJmVUhkNkVQbG54?=
 =?utf-8?B?alJ2bGs3cFN5Tm5FZ3BJSEJhRmFNZWwwMUJJazU1c1pYTkE5N1Q4NC9CWEJ5?=
 =?utf-8?B?VGxFZUhtWU9YekU3TUFHYW5XSW5QZHRJalVIeUhMT2lnTzFRVkNIdEFxM2pO?=
 =?utf-8?B?Q0RSWTdDT0REaHNPQ0RXaEhOc0JNQU1iV1lNSTcrVW13YzJNM3ZaMllKQlJz?=
 =?utf-8?B?Tk9rOUM4d05ZSzVhQkNVWTI5c2ZNQzdqZzEvU0h1OTVUdXhrbGNtSDl6U2xq?=
 =?utf-8?B?bndlN0orb0F6dDJadmFiY1Zpb2Q3RkhHbnVhY3dJMzJ3OTF5YS94SUFnaGhB?=
 =?utf-8?Q?ed6RThNIcvwLoOPtuW9Kv22jC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567F9AAC3C85E340B9A45CC2553BD7B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a8cd78-5035-49b5-de74-08dc7ef4f306
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 09:02:49.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kegjl026CpXsmbAl8vVkSkqwSVV12FZ6CcrF3RV4VHQV9ipN8ZCiMYOjq+j5ETgMfqEnFenyxv23qtIs8vWU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDEwOjQ0ICswMjAwLCBTdGVmZmVuIEtsYXNzZXJ0IHdyb3Rl
Og0KPiBPbiBNb24sIE1heSAyNywgMjAyNCBhdCAwOTo0MDoyM0FNICswMjAwLCBTdGVmZmVuIEts
YXNzZXJ0IHdyb3RlOg0KPiA+IE9uIFRodSwgTWF5IDIzLCAyMDI0IGF0IDAzOjI2OjIyUE0gKzAw
MDAsIEppYW5ibyBMaXUgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjQtMDUtMjMgYXQgMTI6MDAg
KzAyMDAsIFN0ZWZmZW4gS2xhc3NlcnQgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBIbSwgaW50
ZXJlc3RpbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91IGNoZWNrIGlmIHhmcm1fZGV2X3N0
YXRlX2ZyZWUoKSBpcyB0cmlnZ2VyZWQgaW4gdGhhdA0KPiA+ID4gPiBjb2RlcGF0aA0KPiA+ID4g
PiBhbmQgaWYgaXQgYWN0dWFsbHkgcmVtb3ZlcyB0aGUgZGV2aWNlIGZyb20gdGhlIHN0YXRlcz8N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IHhmcm1fZGV2X3N0YXRlX2ZyZWUgaXMgbm90IHRyaWdn
ZXJlZC4gSSB0aGluayBpdCdzIGJlY2F1c2UgSSBkaWQNCj4gPiA+ICJpcCB4DQo+ID4gPiBzIGRl
bGFsbCIgYmVmb3JlIHVucmVnaXN0ZXIgbmV0ZGV2Lg0KPiA+IA0KPiA+IFllcywgbGlrZWx5LiBT
byB3ZSBjYW4ndCBkZWZlciB0aGUgZGV2aWNlIHJlbW92YWwgdG8gdGhlIHN0YXRlIGZyZWUNCj4g
PiBmdW5jdGlvbnMsIHdlIGFsd2F5cyBuZWVkIHRvIGRvIHRoYXQgb24gc3RhdGUgZGVsZXRlLg0K
PiANCj4gVGhlIG9ubHkgKG5vdCB0b28gY29tcGxpY2F0ZWQpIHNvbHV0aW9uIEkgc2VlIHNvIGZh
ciBpcyB0bw0KPiBmcmVlIHRoZSBkZXZpY2UgZWFybHksIGFsb25nIHdpdGggdGhlIHN0YXRlIGRl
bGV0ZSBmdW5jdGlvbjoNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQveGZybS94ZnJtX3N0YXRlLmMg
Yi9uZXQveGZybS94ZnJtX3N0YXRlLmMNCj4gaW5kZXggNjQ5YmI3MzlkZjBkLi5iZmM3MWQyZGFh
NmEgMTAwNjQ0DQo+IC0tLSBhL25ldC94ZnJtL3hmcm1fc3RhdGUuYw0KPiArKysgYi9uZXQveGZy
bS94ZnJtX3N0YXRlLmMNCj4gQEAgLTcyMSw2ICs3MjEsNyBAQCBpbnQgX194ZnJtX3N0YXRlX2Rl
bGV0ZShzdHJ1Y3QgeGZybV9zdGF0ZSAqeCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc29ja19wdXQocmN1X2RlcmVmZXJlbmNlX3Jhdyh4LT5lbmNh
cF9zaykpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhmcm1fZGV2
X3N0YXRlX2RlbGV0ZSh4KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhmcm1f
ZGV2X3N0YXRlX2ZyZWUoeCk7DQo+IMKgDQoNClN0aWxsIGhpdCAic2NoZWR1bGluZyB3aGlsZSBh
dG9taWMiIGlzc3VlIGJlY2F1c2UgX194ZnJtX3N0YXRlX2RlbGV0ZQ0KaXMgY2FsbGVkIGluIHN0
YXRlJ3Mgc3BpbiBsb2NrLiANCg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IEFsbCB4ZnJtX3N0YXRlIG9iamVjdHMgYXJlIGNyZWF0ZWQgYnkNCj4geGZybV9zdGF0ZV9hbGxv
Yy4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgeGZybV9zdGF0ZV9h
bGxvYyBjYWxsIGdpdmVzIGEgcmVmZXJlbmNlLCBhbmQNCj4gdGhhdA0KDQo=

