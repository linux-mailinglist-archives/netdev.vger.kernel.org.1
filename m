Return-Path: <netdev+bounces-206828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B3B04766
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E645C7A4D41
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53626E705;
	Mon, 14 Jul 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W4IGheLl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30860248F74;
	Mon, 14 Jul 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517770; cv=fail; b=lMzTfDcuxeI2JWffZm82L2x3+pXQ/OKw8jUi552x5xrphBNhKVjNdiW0oJRGo/akTeuDY++vye3S2+XSxj5EHKvNUh2GUtIEYpg3OZx9k7RNArSZ/sOUb1mZR5i6HX76wUcEglGIIljWP6ruWV5+kcpk8mZnjUMzbCAYTwOxT44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517770; c=relaxed/simple;
	bh=OE881pk8OiFeVjYXKbsQigCZL9qRYxmS7fx0DOhczsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmTQGOgRwScyZdF2jRVmcKdadLdlHZISU+II85JAMGb/0wPMx+5pTrvgumvkdBHWZFM8Mw5e72r7mE4g+B8vLl32Dw/vTZUdE6EszDZFfIC5LSh7H8jlqMmgQ9+uFK7Sl4gRbpmLlwep3pUDEcQ3Mj9hRb8aLYi18CWafiCOK0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W4IGheLl; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBwYZSfLMTSU82xJp6HjsZnZbI1TBiV4wt4oPFEnIfkSVg+0EM8BNJC7g7VDlagGcmYEiTMlojVPtfqXyciGjI+otDdyVPZLryXuK+wXp4wqZ+9PquJ7iWdbLw8bteqWZE9V36AVwj1CQwM90krakabdnK/AeWqdrT3kaDu7zTkX8ucWhn2xzt4RWHzMk0PCsxiHye8bIZ8LthjKPnbwYWwkaOmbhedQI72xaJwpJ0ojXbmrhTu4N177S+58a00+7bZHokyi1fBVd8vH5TQNDTY3you8oqDLDJlxvXk1EE6II0jai16Wxm03le6o8pR+5Ry1o+pXtZG4ELojjEDagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRcfXtPMThYwwDeWlEjwIPoEN74wki4moyzAHkPY3yI=;
 b=pF+Ed14+JZFm/H69lrHBpbBbFKkjPT0KXMpK4FV0DNBMtec98DTfAijVLHBwsvdRW40Z6hmAt1OOTamtr9FcBMDKiD/rHEXE1aHW4P96TbkNHhS6tyN00aCKYhjnnZQfLnutocpH9oqg9k2YPBWm2zim1ENjR2DjH6t3pD5+9vWcdreQ1jg8PBMivamgZTVwMe80L6QGDBFx7kid99kZ3dysBILwP4SClEVuVnYnFWbNNiSuvFh3652k8XUQ9TfLI3JJoASJpUp8eEhoPdWPK5zY9q6jWybhZs4/2JQoOf7/YXrMwtes3Q4lJSHwZSgEACnJM8amodbroNlveEPKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRcfXtPMThYwwDeWlEjwIPoEN74wki4moyzAHkPY3yI=;
 b=W4IGheLlPnOMg0teCf7pX74pe5rBgerEsI4mzW+0nnUvnPc1YTeaV5ukUJ1yL/bBRHO79pX9aV5u+ajJ+xAi2i6gDTErwy37/vZrBz1IrM6SCrTqNcrqc/4duNjO18DDTh3pWK9HOgnwIN4sl6bHFKOJnCigeRyUUiPHtoNDwp3w98s2f1Jd5Zb1Bd9uBluH5NLTLa+yoXl3gy6nlTeIzb7hDVADgEzYGGWnrEogWBpOWZid0yNNVerHQRFbfeZLSD9VyZZjiBtZBzxyDH2fNoFP1EhrB7vd4g3FRYXm+E5ze/m4ucVLDHRk3tuiB0lbnYbPSA4aiV8rtn26uSKczg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 18:29:25 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 18:29:25 +0000
Message-ID: <0a7282e5-ad01-4be3-8063-8e11eb7e52d4@nvidia.com>
Date: Mon, 14 Jul 2025 21:29:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off stack
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709145908.259213-1-arnd@kernel.org>
 <20250709174547.3604c42b@kernel.org>
 <40196680-c34f-4b41-a6cb-36e3a6089634@nvidia.com>
 <5ca43852-0586-4811-bc45-99e19232ce9d@nvidia.com>
 <20250714082756.40ad644c@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250714082756.40ad644c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee64d4a-00ba-43a9-5938-08ddc3045c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek16dkZ4TVl2RnpGUVpoYmU2M1JrZ3NzRVdCUmkxVFl6WW4walA4RGpRY0FW?=
 =?utf-8?B?RFBaN1VIV25PWXQ5RTZmM1UwRmJCTVhCOFRPcmtmWEw2VnorV052bjlyNW1M?=
 =?utf-8?B?L2U1YTR4VG5ZSkFMb0Z6Qmt1Yzl4ZDBrb2tBUlFBbnRMdkYxaExYV1hmTUVR?=
 =?utf-8?B?VmRmRllrOGhENGFpM3hvUW56MlJhQXh6c25oWFV5NXFqemI1a3ovMzlXWm42?=
 =?utf-8?B?SHI2Mi9mL0RjaVMwYXBrUE14WHV4RkN6VlJOUUl0T2NhbHM4M1VMM2ZVZVgr?=
 =?utf-8?B?NGZqTk9XbDNGSjRjSnRWNytrcW9hcFMvL2dLdllIM3g1RFpwRHhjaGlDU1Zs?=
 =?utf-8?B?b3BpbXZJTitDbHNFd0VSaFJSSVJqZXpxK1E4YUgwNTFIRnhmVUZmc0NCMG91?=
 =?utf-8?B?dTNTZEdSeER3NG5USXVYOXNVdTJnakdBWnp4WlV5KzRwSVRMM1IzMFFCV0pj?=
 =?utf-8?B?VUxyQ3ZjanB4bmdaVVdOaStVcjZFK0dYL2UxcXA0d2pmY1l4WDRveEpRalVq?=
 =?utf-8?B?ajZ2UVoydWcxblpGcUM3WkJnSnFVbzdIYWlCVUp0eEszNXdBZE9Mbkt3VG5S?=
 =?utf-8?B?YXg5aEtZa0tjVEszbGg3SVRBbDgvUjZxREd1L0E3dFZvS0FPRnpGZmtscmdo?=
 =?utf-8?B?YUFSSXE2UjFjOFJPeHdNcWJkN3NyWjdQRjI3Y2JOSUF0L1dGRDNmb2ZNaUpn?=
 =?utf-8?B?K3IwQXZsK01Ja0RNc29ndzVRQ2FmSUpTN0E0QmsvUktoUmMvaHdoRThqbzRj?=
 =?utf-8?B?engwdytGWGI0cWI3alFlMVU5R01HTHd6ZERRL2E1UEUya3BKTS9tZDYwb1pN?=
 =?utf-8?B?eXlrWHdKZXJwaisrTVFDK3h1c2o0aHVnNlVkNjRqY0RGalpTUjk3NmM4VG9o?=
 =?utf-8?B?d0g5QVNrcHBRNmhNLzA1TDlZcldITWNLaUpNWWVSV3Awa0h5M2dxRzRoWE5w?=
 =?utf-8?B?MFp2Rlhzc2MvTTNacElVZk1SeFAvaXEwZ1lvdEp1MmlaSSswNlREdm42ZXgx?=
 =?utf-8?B?eGhhRUFDWHJESnJldkVuUzBrQjU5eXdJYnZXTlQvZXZJcnYxb3VySXpLV1BD?=
 =?utf-8?B?MndhZnNmQm5sUVVjc2gvVERVUDNWOVhheDArSjZWVlBlR2l3Y3N6QTY2dVNO?=
 =?utf-8?B?NEQ4UWdsQk5RTkw0S2ZlMHErbWd0SVJoZ0ZVcmdoenJDQUxpM0tMR0VxbmR6?=
 =?utf-8?B?RlRSTlBEQUR6TnBWd1dYbFFqS2JwaU53bHJnUVlXelJKQmFialBGSG8zNnh0?=
 =?utf-8?B?RTRDaTMybFo0bzR3QU9odVFKTmhtQkxVMzdYeE51bnd3MWxLYm0rU2ZxM3Zt?=
 =?utf-8?B?dUJIYk1DbmhVeFFWSTlRVnM1dzFBaDdmQ0ZVbVgvTTIxVVpWL0x0T2ttbjQ2?=
 =?utf-8?B?OTFINFFVVFNZS0hMeU9XYlJoNGxsZzZWTnVTbGJoVXJkWXpUMWpvTHRJUWly?=
 =?utf-8?B?aWY1SUk5TnpZUFhTSUJycklDSUFhRkM5U2xPR0xFMzZXRnd1QWxrbmFXK0l1?=
 =?utf-8?B?T0svTkFUMlplTE1xUi9CVXkyaHZFblVZVjRNNVFNUEMvVU1MYkFlZXRJbUxY?=
 =?utf-8?B?VHhuTFB1b0hQUE94My9YOHJicGN0amRXS0Q4ejRQZHdMR0ZTSERyQ3VEUERD?=
 =?utf-8?B?alVvc1VnaDl3WGI0WUx1SGhnRTFmbVEvSnhYbmdHMFM3VndlWFB6QjZkdStV?=
 =?utf-8?B?VVZpUmRtV2FwWnhsQXFpU1pRS2dDNm13TERZU0kzelpJVWhPbVZMcjlFNVY1?=
 =?utf-8?B?UHFnWE8xSWZhazNTRTVhYVhtQk1qejdLY3ZJQjRBTWhZQWJNS3EwQWxNNlZ5?=
 =?utf-8?B?eVgwYkNMNXZXWHk5Z3R0VGJOWHh4WUYvRHU0VGNJWmplVTNlNjNGbEFrZFBH?=
 =?utf-8?B?aWNVQUFjL1FLV3Y3eTdIQyt3UDU1d1MvT1NBUi8zdkpCMm1WNmR2aEFhTjVl?=
 =?utf-8?Q?+JtugFXtMlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lleUpxOWloeEprWWJ0Z1U5aGJRYWhuOFBwNlRqSTROZkg3L3BKV0VaZE5V?=
 =?utf-8?B?RDMrdkhOUDh0ay9kNUNjZGQ3ZmpPcWRjYWNvTVJ3Vi9WakM4STVUSjFReGpT?=
 =?utf-8?B?dUVVd2pwTlFIMk1XbFNVelNTK01mc3g5V2FNeW5qRXZQdXhYdzZvRzJPUzdB?=
 =?utf-8?B?b25uTnNrMzNMZ0t3Mm9hQ0htRmovOHAzOWNpUW00eGdQR0lzSHZxQTBScW0y?=
 =?utf-8?B?dEZxVW5sOElPNnB3ZzN6S0ZLcVNCVUNtcUFHQnBtc0JyN04zdC82MGI5VmZW?=
 =?utf-8?B?ZVdJVVBRRjgxelEvZEdWUHpySlJ2eElaR2ROQjNYbFhtdndkcmFjTjJpSDk1?=
 =?utf-8?B?c2o4QlBLM0twOVFtc3kwYTRDeXFxNDZ5UGpBYkhOZXhHQkhSaGo1UmM0TXYv?=
 =?utf-8?B?cDJ3LzhkM1FOK1YrYXJWTDlJYTRUVzJlenZ2dm1YTkw1Nmx3UHhWYjR6K0VZ?=
 =?utf-8?B?SFJZRGJnVmtlOEtaS1JYTEVqZCtSRGtVTnZ2elN5N0I1d0w4L3FMY2d3SXg2?=
 =?utf-8?B?M0pUZVh5NlNBdzF2QlBSeHlzU0JFQzRuQWtIbi8wSHB2dzhjV3pocVB5Qk1s?=
 =?utf-8?B?Q2phNm8ra2hGbUVPczgrbFFudjhORTNzOTFHYitUQWI5QUFpMUEvZktFb2Nq?=
 =?utf-8?B?Um9oOHowN0tNaERpcTA3RTI2a2tEYWE1Q3BYbksxdmR0L0NDMC9sVmRObXpq?=
 =?utf-8?B?U1N3bjJEa0pScmNhMzBscXFiSFkvbFZwenZuNkl2cjdJbnh5LzZzZCtJYXJ3?=
 =?utf-8?B?WmtkWllUcEpqSjU5QVd0cjNobk4rcXE2dkw3SkJUeUFvbHd2NUFreFRQRnk2?=
 =?utf-8?B?ZU9zMndvd21KUG9pYWFYYjJRcUc2bjdWeDlHM0tMM0prVjNCb3M2ZTZoZmls?=
 =?utf-8?B?R2lnRHdlazkxTnF3b3BadFFEeURDKzRvODNaOTZFSTB6bjB5ZGJDYVBrTlNI?=
 =?utf-8?B?ZWJ3bVh3TmxESDgxalJwdXNrUHJ3TnEwOTlBYlZkYW1qL3lvVGMyUWFXckpx?=
 =?utf-8?B?dGZteUF0MTJNTGZTVXZ1OU9sejVCblFsS0lXbFNvbWJreGpPSldXWVlOak8x?=
 =?utf-8?B?cVZFd3VkWE4xQlp6YkJCMENMT2g4QWNpMDlZeUNWK1JWRHNXNWdFT2plWHBW?=
 =?utf-8?B?d2RmUm1VeUZINkdHQmlnWDhBM3RoZWNEK3gwWDNOK0t3U0ZaTVFKNXdId1lK?=
 =?utf-8?B?bTB4ZENBS2s5Zmh1czNFd0FtRDF3NHdNQWFmdlBXSElaa2dqcm16OXdLbFM2?=
 =?utf-8?B?RHJUOC9tNi9kQ0k2Ry9SdkVFa29ocGlWNEg2MU1zODd5ZG8veldyRVdsc1Jj?=
 =?utf-8?B?Vzc0WFJtdTN3NzhybU9oMk8rQ1hHbERwVU16ejN2Y25kUW1wbjhwbVJQTXJp?=
 =?utf-8?B?Yi9QOS8xUDRkdUlLUEdWZXZubmM0czI4QnZUaUk2b2x3L1pCbVdodktTaGMr?=
 =?utf-8?B?NVVIT3RKRnNXUjJrR1hUTDBMSUV2SGdaQml2Uld6cU16TTRFTkhMYkptbEJI?=
 =?utf-8?B?cUZ5TzZPVStQT3BJWVBQeUpwTUc5andjK1FJSlFJaUNmaE5RVlZ4TjYydGV0?=
 =?utf-8?B?elY3R1FtM0pYRlZzSGRhekZOUmNGZ1dLRnBOSGdremhVZ3NzbUJxWUNiODhv?=
 =?utf-8?B?K01YWUJDbGE0TE1OR0pZdXRiaVZIUGtLWHVUVnVvQllEaVcrUllqZlFGZ0Vx?=
 =?utf-8?B?MTgrMjAxbWFIMGdVeHBOTy84Y1B3bm1zb3hScGFhTC85bFpYMzdvdDFOWGVW?=
 =?utf-8?B?cnRMS0NHVTUxQTVxZ2VrWjcxS0hEZk9VZktNNHpiaG5BYzZMLzRKL2IxRGtI?=
 =?utf-8?B?V0xXd2gyckhFK0hQbzVjZ0ErMVQ1NXBtRnd2Y0tTbDArbVFnU2xHNTNvZFY0?=
 =?utf-8?B?azE1a0FSYmMvdlJpRUVRQTl3MllyeTFVTEVmMmhhYWFKRWRDL1BZWS9SdTRU?=
 =?utf-8?B?VVpNUlRrQmRucmFKS2J2d0pSd2RaaXZKVnBBM25JS1ozcEg1MUxKUk45NTVP?=
 =?utf-8?B?RkRyd3RpSXY0QXBWQmxFTGhCY3daaWpOR0Z3a3RUVjRFYUhHemx2SmgrY1NV?=
 =?utf-8?B?aS9DaVFKTzdIcUl1aDdNc3c2cE53L0hQMUhkMlRFMlk2ZmN2NElEOWZreGgr?=
 =?utf-8?Q?cGYD6MkaynsLJkXwyTVIR/UMp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee64d4a-00ba-43a9-5938-08ddc3045c51
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:29:25.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAqCubM3xUj0iYY474fGXnv4jmq/eajvtf0P1jybukZ+JDxroN2SuHX+1PV6Mu5+6o6zC166eXFxrRJT/us0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697



On 14/07/2025 18:27, Jakub Kicinski wrote:
> On Sun, 13 Jul 2025 15:28:11 +0300 Carolina Jubran wrote:
>>> Sure, testing it. Will update.
>>
>> I have tested and it looks good. Thanks!
> 
> Awesome, would you be willing to post the official patch?
> Add my as "suggested-by" and with my sign off.
> Most of the work here was the testing :)
> 

Sure, I will post it soon.
>>>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/
>>>> netlink/specs/devlink.yaml
>>>> index 1c4bb0cbe5f0..3d75bc530b30 100644
>>>> --- a/Documentation/netlink/specs/devlink.yaml
>>>> +++ b/Documentation/netlink/specs/devlink.yaml
>>>> @@ -1271,12 +1259,20 @@ doc: Partial family for Devlink.
>>>>            type: flag
>>>>      -
>>>>        name: dl-rate-tc-bws
>>>> -    subset-of: devlink
>>>> +    name-prefix: devlink-attr-
>>
>> Maybe use name-prefix: devlink-attr-rate-tc- instead?
> 
> Sounds good!



