Return-Path: <netdev+bounces-177776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D814A71B35
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB4618896A7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CE1E5218;
	Wed, 26 Mar 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDhLl2Wj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B62747B
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004536; cv=fail; b=XCR1zH8qenHER1szqTe391Fu0g8xCPj7FGOpqyrSwZr1cIPoGMFtsTPxCMfk0X+uHBtfu4DMBmfD+rP92rfFm9UoK3c0F+g9t8tGpEGXMzG8uZVuA7V2JmDJW5k5iBJNuZ3M2nzs95rMclHLc/ZVDFd/sSQqP8YMXjtRs/pXx/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004536; c=relaxed/simple;
	bh=+bLhL3X3rUzCvZWeiLj5QzxMOsDHiDDoLZqfwCMpM0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usePhevdL3JhpVdaxk3SVfy/jE8EHY3NuiwRPESdQ1qEEkCG3ra5Qzx+mi6OKzUIK8UPQbtyO6X++USAOT3SAhn1lY8dAHgYExTOlAeMVLpdz0JVZZ7puTPLRqpImYRCh0whCfSA2AmmXoUXVPn2ugsI7BfgKIE9DT03kLGWh2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qDhLl2Wj; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOfL8wz06/tEy62g7OHlshIpIf3qf3C7WdyOeeVKBuDn/FIUVs16KmCdhr5VJU+o72qHWRlI11DPt55awQt82Fv3mW7f8CjrpjpDyhjOD3PU9WK/AhBQJNAYu3z4nDm9WMnGUfuFLvFTUXV07juKBcyibi+NlplioPi/Jirr4/n6SRjyJ6VdKusYLRf1QunCwmUcipHE+RoYZ6gM/Z+oDis/TZLOI9aS+NDODFmORgb+8TrdSvH6PRV3zyG0EbbI0edQQtJAyyU5OoIz7Z5XJWNoLKJe/4okW93uIcx8YtU3s9bzjtTj5OXCrqcE04aS6XCePSqlhPkV7yjXd2NtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bLhL3X3rUzCvZWeiLj5QzxMOsDHiDDoLZqfwCMpM0M=;
 b=bXFT/HyhPD5WE/FaVD91b5VSG/XUPLCYn6zloHERCPY+ZdIB2PlNnyRKMAWyGugGDYwPNCa6iK5BbNf6IsEE2XUZl8S8zvzmJYTb0tAHYH9/Uyo5QLrgy98mqJjUgaQ5Dx6e6+E42fYS+9gW3nPAckS8uQQT419LonZnUiqEQJLnezXpzoukk2rzFChwPk2vsGk+lEEWeYSoLH/Z04SuRt2VItaaylSD9fbf40b/9YkjQicy21tJbIxeVUk7iY+aWEpDpomnU/v+siGNRaW7H5jgqZEyPJk1KocX2ZBzPnT+chAZnNvI8l6SKuMl7uQepGy2KlAYVvTbYSwMqnBejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bLhL3X3rUzCvZWeiLj5QzxMOsDHiDDoLZqfwCMpM0M=;
 b=qDhLl2Wj/hhn3CHy1kEgVnyfP4WQtuzjzivj/Sh/ELoteGUiDKdGqgeb5N/Gp9RY+ZLXMqrz/12pbL5lJFuzQ3578T3owC/CxU4KpkWVPNCsTl2zhVYS6qhLYnc+axk7LyM+YbOCrdRw6V6YjZOEizb2wgIQ6+ZulNapfqjckuEwzWQmJ8R8l7P/nEsGqc0jiUq+IsqBwxzI9I5z/tJMNuHjM9mf98p1yZ7P+pQGKL85gFUUWWtG8QLb/FLcEF9MIIOPNRpaSSHRje1YUN+uIJJEWSvU8VWlwOlGWMF0Bbnnr8yvb31uWXnxEc5ZS33kMobidpqn1XATI0CtCeszoQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Wed, 26 Mar 2025 15:55:28 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:55:27 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Leon Romanovsky
	<leonro@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: net-shapers plan
Thread-Topic: net-shapers plan
Thread-Index: AQHbjqCY35hNbeh1T02OBouE+eij/LNt+HUAgBe5RYA=
Date: Wed, 26 Mar 2025 15:55:27 +0000
Message-ID: <3e5c829bbcbfe88f7febea52646a6e0bd0dd4068.camel@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
	 <czbmzydl32avn6gnwfrsmilemcmajcklnsv6rrlhrcas7iwpjc@wmqwsth6wj27>
In-Reply-To: <czbmzydl32avn6gnwfrsmilemcmajcklnsv6rrlhrcas7iwpjc@wmqwsth6wj27>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CY5PR12MB6648:EE_
x-ms-office365-filtering-correlation-id: 093da60d-1e1b-4eb8-d3c8-08dd6c7ea0f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVlWUCtRTnFPQ0lTWGtFWGEwYzF2OHpISW5aMmRtVUZjV0NBZFFsYzdKb2lv?=
 =?utf-8?B?L1VPZytJWnJIZ1pXWENkRHVEZ2NuRy9JaVl2ZFQyWEdJYkliYVNNSFBGU2ZM?=
 =?utf-8?B?bGRpeVBia2VRcW9EV2FlRkZlTkRUemhxUnQybk1KOW5VcUhPU2lqU3YxbDFW?=
 =?utf-8?B?bWUyWEJwTE9NSDErVnpwbmRsOXpUZTNKYXkwdG9UaysxR2MzdmZYd3gzeENL?=
 =?utf-8?B?RU1HMVZZNzdkWWlHVGFXZ1JBUE9wcmd2SlZDelA2YUgwSGVjYkN1ZU9lclNX?=
 =?utf-8?B?cnNVRlhJVitJdVRmOFJBb29YVDRUaFlZc3FORUpWd0ZZTkRZY2RhRFUvcGdN?=
 =?utf-8?B?cWxzZEtYalRWNFNRbCs2YWgwNkFwY2hpaWV0UWNBV1RwVmlqanl5bWdQclBF?=
 =?utf-8?B?VjY2L3FtaDdVRTZTMmJkcGVHVTNrNUo4am41VWlEMjA0V3pzc2NiSG9NT0hq?=
 =?utf-8?B?TlRZYVJLR2o1SHZvQXVYVGliYmNwM0FFTndWSkhGREd0Yy80dnl2ekUrZEFl?=
 =?utf-8?B?SEMrc2FmM1hTMi9XSUVMY2RnV05ueGJMd2x0L0dIK2cxdVYvSkoyWkRiL3hu?=
 =?utf-8?B?dUlBTSttVE4rWEtuQnhIMjdqRi9LQzE5b0JOZW93T21ZSWxKSkJSMStWeDha?=
 =?utf-8?B?UU5MNFB1Mk1BQkduVE1tZWRzbDRrTko5YnI3eWJjenhXZi9EL0RhSVZLRjNw?=
 =?utf-8?B?NU5MeFBiaTdzRnhsNWc4SnpidUtTaFpQaWxwY0ZnVXV6SEhsOTJ0R2xBdG41?=
 =?utf-8?B?WWs2MEhySnpSUzY2NnBrbU1tUFBOcnJqR3V0aVZlNkJPNFdWdmh2eXU4NGpX?=
 =?utf-8?B?MDc1R3lQZnVaSWV5V1NSTlB1YU1jWkhOWEZtQTNNMCtTek9DbndndlE5VkRa?=
 =?utf-8?B?NTJVSDdkbXI4NlBMaXhEK3BJV0RZbnVyM3JFeGMxWUhtVUQ4eUpTTWh6elB2?=
 =?utf-8?B?dzZuOC93WjlVK2Z4VW1ET2t0c2UzT1BGWlFxNmpXaDMzLzVXeWdBUFlmZVg3?=
 =?utf-8?B?ZUcyU0dISm9yNy9nR2hXYUMzaWgxdUxHS2F4OXZEdi9KMXIzMFpxNndoaFo3?=
 =?utf-8?B?bjgwL3F6SFdDT2xpZkN3T21GLzcvQzBvVFpyUHpOV2dQQkhnMW1PRC9lbGtp?=
 =?utf-8?B?UjNHMFNTUEJFS3FTK005b1ZNa1VkR3NXNnczK0JWRTMxZEVJVWJYU1FpNzFI?=
 =?utf-8?B?T2UyaENvaUpJckR3N1hobm9RVStSV09WTzZtejRYb3RHTmVydHBpQmloVGx4?=
 =?utf-8?B?QnZSWld0YkFqY2M4L0dSYWV4RU5zS3VHRzIxanoxdnFUOVVTQ2hlVEI3NnUx?=
 =?utf-8?B?TEhKK3hkVmJaMlpiejZZam1GcDFWU2ViZEJaVEJKYlJaYWVTRVc4OEhTMWVO?=
 =?utf-8?B?UG9yYmIwU3ZjcHJGYXlwODFHc2JHeDZIMUVoZGU0SlNIemZ6RlRzQnhQaUpO?=
 =?utf-8?B?M0h3aDNZTmdTTWl4TlJOREltSWk5Zlk2VVg3aFVYVlJxMFZZaXZDSk9FdURG?=
 =?utf-8?B?djB0N1lkZlkyQ1BaWUFFcHprRHZVR3Z2T3RqR1RGbWR4Y0U2SGVFQkxDVjFD?=
 =?utf-8?B?N2xndjFGWHhKNHkxWnl2SytsdGV3WVZDRTFPTDdIdFFmN1RrcmJNRUJ1b0JV?=
 =?utf-8?B?UlJwS3BnVGo0UmY3bEpFamNqWUxMdUovRUU2QVJxcjRrVkUyTTF0SVJROVg4?=
 =?utf-8?B?L1BYK210eUIvQW9YcHVyUDNzaXkvUTBFVTZ3ampDRmRybXBIdEIyaHl5bFJU?=
 =?utf-8?B?RVA3WWJUdXdvYzFRUXpLYXRIUTJMTEoweG42Ky96Z2RtcDhEczZodzkxWHQ4?=
 =?utf-8?B?SnRlZU8yWXRCK0RvWTNkaHU2dnNvV1VvS1lSdDNBUktseWViV1FTczJlejFh?=
 =?utf-8?B?RC92MnJBK0wzdnUwdmpGL2ZQd0w5T0xUVmUwT01CYkEyYUlwNXpNSVBJeTFF?=
 =?utf-8?Q?IByM6FQq1QcXiBwKwX0G8uRon8KZzmjI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3lyZHNnUHVLT05QVklUb2l5MWxRRlcwOWlQTzV4d2VQQWxSSlkyaEhmVzE2?=
 =?utf-8?B?OHhNQWFGSHVFMTZCZTMvd0tkWThxN2dDZUhEWWtncTdIVkZQNjZLTjFzN2lv?=
 =?utf-8?B?Vm9QSkNjZEMvVHNmNGp3eEZkZnJMRFFyTEVKaTg3ck43YnZlVlRncWxTY3Nw?=
 =?utf-8?B?TmJ1enVKZERUa3Qwczk3UEpGalRTQ2JNZmZ0TzMzVERCMTZINWFuTmpjaWtZ?=
 =?utf-8?B?UEFZM3Y1RWZ5bFN6eWt3dGJ2YWF2N1ZFMEVsMkZwRkc2RVQ0RGhaSUcrNzhi?=
 =?utf-8?B?L1JjTGdHYSs4MFUwOUlUUldPODlRcStzcE9kVDlXQUpKdWZlVXZGSC9UZHNj?=
 =?utf-8?B?bzhzcFhmTlMyS3hqSmNqMW55V1g4WFRXbkd5NG5qTGYyWlozdU0xa0YydjQ1?=
 =?utf-8?B?SkU1eS9vN3dQQzdrYk5xeGQyQTVXRWtVeDJHeVRZeFVOaks5YXhudnJBM2Zt?=
 =?utf-8?B?ZGN4R0JUdnpxWk9ydnB4MDVOSmYySkxyZ0pFWnk4d2RJSGxFWFpwLzF4V0l6?=
 =?utf-8?B?UTlIb1FiTEFSNTFGZ0RxL0taeUJuaFp6ZVpuSlRQbkdtV1NXaHY1VnhHTEha?=
 =?utf-8?B?dFN0OWZzOTdDWDdWWEdJcDZUWjh2NElpLytOa3BYU05tdkxOekRCNUx0ckRi?=
 =?utf-8?B?K0JJS3YwQ2RrazhDelczSC9ZQ1Y0eUdSNHZuZ3BQdTVKZVRuekZLVzN5NWFO?=
 =?utf-8?B?dU9ERldTK1c1N1Y3TFJFRUN3Z0xpMm5wL3IrN2FTSC96d0kyZVo5Wm9mMDcy?=
 =?utf-8?B?bGt0Vmh3RSt1MVJCaW1WUDdXWTRSdVNORnVQMEFQY0M5UHdscHMvMEEvYmJ4?=
 =?utf-8?B?NEpnTEU5dThPQmdhQlhsYWdTTGswNDNUaFVXcnlKb1pJWjg2Wkd0K2pTRS9V?=
 =?utf-8?B?OElnTTRZcFc3ZGNGY051a1ZuUHpHMjNMLzhvM2Q4ZGo1WlBwd2t4aW4vYjZY?=
 =?utf-8?B?elJWWDg1VHFqYS8vcDdOYldmZGFEcXhJSk1sWEtwQUlsU09Ta3BhT2EwdE56?=
 =?utf-8?B?ZGtJVjZnamNnajc5eXBtaFkxcC9OTGRPMlgwS2tTM2dHbVBuNHJ6LzRoeVBa?=
 =?utf-8?B?YXVDcHhia0VEVHRLQVRQbWprQktWTnQ1c0xMV2Qyakd5OG5zamptNjNsdzJB?=
 =?utf-8?B?TWJtM3JmKzRRKzhCUXorVWdzQW93eFBUUUEvbENjVGZiUlkrR1FTNzIxVmdw?=
 =?utf-8?B?amxWWDdUWXM5RFhKVWRmSkRIMXlYL0ZzK3gwWE5NTi93YWp2MjFDeEVrMGQv?=
 =?utf-8?B?NGFWbGFuSG5tM2JncFNrM3ovS2xTQWFRWDJwS2tDMy9qNVo1eVZMckFhL2ZU?=
 =?utf-8?B?c2xPeDRBN005WFRwWExESG1rbWh3czRMR0psYkZ6TXhjSEpJblVFNWRQeE9M?=
 =?utf-8?B?MmZwcFVPOS9KaHNaajNpaTh3VnBPMHFoZVFxbCtWdlIxb1pBTnRKb3I4eGpM?=
 =?utf-8?B?WHJKUnM4M2Fka0ZZakJYemZ5ajhDazRuWjZVTEtmSkZDZkFkWjQrd1hQcWNM?=
 =?utf-8?B?MTJNd0tzcFJHeUxZaWRaRk5jcm83MENXNS8zdGJNUnNmdDBKZzRIR0dtOVha?=
 =?utf-8?B?aU1GamkxelBSVEphZHl5L3VRSEJlSXkwY1VLN0NpUldiYVIzZE1ROWx1MG5i?=
 =?utf-8?B?bW9UcTE2NkhQNTUzMmZDWXpDYkdwQWdGUGhSbTlkOE5GcHZ0NnNsZXJmYkZN?=
 =?utf-8?B?VFJxLzRtaDBsL2xsUUdzeW83NUFqc1NDYi90L3ZEYnhrZmNNOEt1NjBRNHVu?=
 =?utf-8?B?MzlIMm1XamduSjBFY29wd0FkMS8xTjI2T1p0eXRHTDlheDhLTW43OHRYbEI5?=
 =?utf-8?B?ekpON2JxWEo5elg5T2tLYVRwS0xXQ2IrVW0vOGFzanZFT0YwVVcyblFnS3N6?=
 =?utf-8?B?Z04wcUVFdERFOUN6dXQvRytibDRwaXptOU8yTUltTHo0OFlyNjhhRnBMYlR6?=
 =?utf-8?B?eU1CNFRoeHFPQVdVTHlwS0xvcUM4Y0pTY1hiQmZ5U0dpVEtPbVRob3pJbml0?=
 =?utf-8?B?ZW1kVWpLWkpHTTZySGdxUEYxWW9RSkZLRStvdEdPTkFMampYREZYcjh0eGtQ?=
 =?utf-8?B?U3dKMlBqQW5OSTQxYURCbEJYb2J6N29COEh0Tm9JYlA4dHR4aENzUkNTbXBx?=
 =?utf-8?Q?75iZFTvjybgJ5SSavFo4YUh4z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4401DD1E59C08A4DADDA578A4870B2EF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 093da60d-1e1b-4eb8-d3c8-08dd6c7ea0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:55:27.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSfgQ3diOm5v4AhWbjcJz6a99DV5H0grC2xHpqS2jBLIPm4/hokY12bW13zpvCbsFDRFd2kzbVtc5kYO5B07EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

T24gVHVlLCAyMDI1LTAzLTExIGF0IDE0OjM4ICswMTAwLCBKaXJpIFBpcmtvIHdyb3RlOg0KPiBU
aHUsIE1hciAwNiwgMjAyNSBhdCAwMzowMzo1NFBNICswMTAwLCBjcmF0aXVAbnZpZGlhLmNvbcKg
d3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiANCj4gPiAzLiBBZGQgYSBuZXcgREVWTElOSyBi
aW5kaW5nIHR5cGUgZm9yIHRoZSBoaWVyYXJjaHksIHRvIGJlIGFibGUgdG8NCj4gPiByZXByZXNl
bnQgbmV0ZGV2IGdyb3Vwcy4gVGhhdCBwYXJ0IG9mIHRoZSBoaWVyYXJjaHkgd291bGQgYmUgc3Rv
cmVkDQo+ID4gaW4NCj4gPiB0aGUgZGV2bGluayBvYmplY3QgaW5zdGVhZCBvZiB0aGUgbmV0ZGV2
LiBUaGlzIGFsbG93cyBzZXBhcmF0aW9uDQo+ID4gYmV0d2VlbiB0aGUgVk0gYW5kIHRoZSBoeXBl
cnZpc29yIHBhcnRzIG9mIHRoZSBoaWVyYXJjaHkuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiANCj4g
PiAzLiBFeHRlbmQgTk9ERSBzY29wZSB0byBncm91cCBtdWx0aXBsZSBuZXRkZXZzIGFuZCBuZXcg
REVWTElOSw0KPiA+IGJpbmRpbmcNCj4gPiBUb2RheSwgYWxsIG5ldC1zaGFwZXJzIG9iamVjdHMg
YXJlIG93bmVkIGJ5IGEgbmV0ZGV2aWNlLiBXaG8gc2hvdWxkDQo+ID4gb3duDQo+ID4gYSBuZXQg
c2hhcGVyIHRoYXQgcmVwcmVzZW50cyBhIGdyb3VwIG9mIG5ldGRldmljZXM/IEl0IG5lZWRzIHRv
IGJlDQo+ID4gYQ0KPiA+IHN0YWJsZSBvYmplY3QgdGhhdCBpc24ndCBhZmZlY3RlZCBieSBncm91
cCBtZW1iZXJzaGlwIGNoYW5nZXMgYW5kDQo+ID4gdGhlcmVmb3JlIGNhbm5vdCBiZSBhbnkgbmV0
ZGV2IGZyb20gdGhlIGdyb3VwLiBUaGUgb25seSBzZW5zaWJsZQ0KPiA+IG9wdGlvbg0KPiA+IHdv
dWxkIGJlIHRvIHBpY2sgYW4gb2JqZWN0IGNvcnJlc3BvbmRpbmcgdG8gdGhlIGVzd2l0Y2ggdG8g
b3duIHN1Y2gNCj4gPiBncm91cHMsIHdoaWNoIG5lYXRseSBjb3JyZXNwb25kcyB0byB0aGUgZGV2
bGluayBvYmplY3QgdG9kYXkuDQo+IA0KPiBDb3VsZCB5b3UgYmUgbGl0dGUgYml0IG1vcmUgZGVz
Y3JpcHRpdmUgYWJvdXQgdGhpcz8gSSBkb24ndA0KPiB1bmRlcnN0YW5kDQo+IHdoeSB5b3UgbmVl
ZCBncm91cCBvZiBuZXRkZXZpY2VzLiBJIHVuZGVyc3RhbmQgdGhhdCBmb3IgZGV2bGluaw0KPiBi
aW5kaW5nLA0KPiB5b3UgaGF2ZSB1c2VjYXNlIGZvciBncm91cCAoZGV2bGluayByYXRlIG5vZGUp
LiBCdXQgZG8geW91IGhhdmUgYQ0KPiB1c2VjYXNlIGZvciBncm91cCBvZiBuZXRkZXZpY2VzPyBQ
ZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZy4NCj4gDQo+IFsuLi5dDQoNClRoZSBnb2FsIGlz
IGZvciBuZXQtc2hhcGVycyB0byBiZSBhYmxlIHRvIG1hbmlwdWxhdGUgdGhlIGh3IHNjaGVkdWxp
bmcNCm9iamVjdCBjb3JyZXNwb25kaW5nIHRvIGEgZGV2bGluayByYXRlIG5vZGUgd2hpY2ggZ3Jv
dXBzIG11bHRpcGxlDQpkZXZsaW5rIGxlYXZlcyAob25lIHBlciBkZXZsaW5rIHBvcnQpIHRvZGF5
LiBBdCB0aGlzIGxldmVsLCB0aGUNCm5ldGRldmljZSBpcyBqdXN0IGEgcHJveHkgZm9yIHRoZSBk
ZXZsaW5rIHBvcnQuIFNvIHllcywgSSBtZWFudA0KZ3JvdXBpbmcgZGV2bGluayBwb3J0cyBvciB3
aGF0ZXZlciBlbnRpdHkgZmVlbHMgYXBwcm9wcmlhdGUgYXQgdGhhdA0KbGV2ZWwgKG1heWJlIHJl
cHJlc2VudG9yIGRldmljZXMgYXMgaGFuZGxlcyBmb3IgdGhlIGNvcnJlc3BvbmRpbmcNCnBvcnRz
PykuDQoNCldpdGhvdXQgdGhpcyBhYmlsaXR5LCB5b3UgY2Fubm90IGZ1bGx5IHJlcHJlc2VudCB0
aGUgZGV2bGluayBoaWVyYXJjaHkNCndpdGggbmV0LXNoYXBlcnMuDQoNCkNvc21pbi4NCg==

