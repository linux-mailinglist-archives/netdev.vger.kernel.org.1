Return-Path: <netdev+bounces-168273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC6A3E545
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F2719C4971
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E1262D3D;
	Thu, 20 Feb 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJWWBS+O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134B1E5701;
	Thu, 20 Feb 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080773; cv=fail; b=OXHhaamzjtyF42E3d3z7W7I849tC41Y7G2V9QsoG+caEP9ceyhBItsV/g0Ek+Pun4THownwz1F0PgEcoz9bXLVMUSH04ghshN/6r8ZSCKG6ckRrNXGtbus7IrgJ1a8rytK/GESWY5/Q1v6yaQ2/xNlpc/F3g74e2w0ddwhIPjxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080773; c=relaxed/simple;
	bh=girGOD2RtLc6iWufhfVVD7iJ0GHgQWvvulFoome/tuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cvw2e+uEwSkiggzspaQI6GeN5hXRJtMQDubAz3TIzUeB8vTcgDY6MdzsdVjKfXapH5sbOCmNg4Urd7r86OTarI3PafBooeez5q7hhydplHm3T57TDRA2WlZcC4QWOuNksx6iI270P6m8RL3E8P/ZKZuAi1uc8EV/EXjnXOQgpVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJWWBS+O; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsIT76s4G+tyeqhUZz4+CMI7QJdQdZv2fACfTJ1DvqwzD0P9WaiPLMrMPkB7cCRQv90kbMJOCssoC+I4DU6TquFg2UlLORBGFiyJCZjnErsQ42Jq1MUaAHj4/z3HfxIM3I+aMRlrNAOPDM/H2l+PXDQUB0T1VWB1NMwrflcCWux7As5NKsW9FwAPd//916SBZ/hDP8eYKCW8c0L6HKR6IPX4Tx1TFR/hH00bVVXZ4PcpO5PCk+F4VZhFogOYFO3THI6EQv0zzbZec87cOis/Prei9qjAob5VGu4V1b0B4ROY8/vJezksBSOZEzJgjXMQ4ck+b9jJFpicynti1RKSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=girGOD2RtLc6iWufhfVVD7iJ0GHgQWvvulFoome/tuI=;
 b=Tolh4Zc2okKL1WHSBZ9owbdGyfWsHWL8PtWdvhC9IEGvAh1bQSyfL06sPJG7T09z5yPvOBuS+2NDaWtrnpQtUig7ZDtKP2o1W67/JW1ghGw1vfphCo9iltJDQXbpTqGrOj7gXZnyX8PYtY12pNg+dR3FV2nUbzimeITtoe7bWVGaUc9gpyAZhvBtXG1if9AYqnKux4QJQstabxTty6HwJF/ZVwmfP9ln39V4YOoXwWu08qkr8xh3az8VF3o94hBcj46ROmTAnJ6Gazy4d25WKkV0mQmchJfvOP9h8ehx/JVSuKQF3m00DSQ6ZklysXgURYygy4ZDYJo3Q9sAfXjjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=girGOD2RtLc6iWufhfVVD7iJ0GHgQWvvulFoome/tuI=;
 b=DJWWBS+OXXmlDhN8TFONoQtw5hf4v6sdtf3reR7yxY9E0N/wo5J61kdiy+nykS7U37kVuiYxLkEIh9s2LJWBODt/DHThsYFMLG6U9FTiruU26T4jHpPKOMUZe/VWLIA5fClW748hr6csK++9oGZS0eHQlsACr65KVqcGFgS7r/4=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 19:46:07 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 19:46:07 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next] net: xilinx: axienet: Implement BQL
Thread-Topic: [PATCH net-next] net: xilinx: axienet: Implement BQL
Thread-Index: AQHbfyVcP9M74iFYYUylKNMVcuL6ibNIO9IAgAUCdACAAzTEAIAALYog
Date: Thu, 20 Feb 2025 19:46:07 +0000
Message-ID:
 <BL3PR12MB65712C116CCECBAB7BD28FD5C9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
 <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
 <3a6e95ea-cdb0-4239-bb47-b29df45f52cc@linux.dev>
In-Reply-To: <3a6e95ea-cdb0-4239-bb47-b29df45f52cc@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e5a54862-68e7-41f2-8447-54fa0d01af4e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T19:41:29Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|SA3PR12MB7922:EE_
x-ms-office365-filtering-correlation-id: 8fcd5c75-2679-420c-551a-08dd51e73817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFp4ZUZhaEZmT0FlMFR0WXMwbHRCRERGbVkyTDd5WjBNUnNzb0Z1VWV0UDM3?=
 =?utf-8?B?QmtvSkliWFlTRVhtMlZqMHprMHF3UnRETHQxejN0UVVoTTR6eFl0OERnZk13?=
 =?utf-8?B?anA1VmJhUmFaUWRRZFBZbWpORzA2S0xCSmlnTGFONjNZSm9NSnFlRi9HUGNF?=
 =?utf-8?B?UlFKQkNYS05FYkk4REpjbVd6cXhpRWVCbDg0bTJqVWx2cDBPQlozQ1Rpcnp6?=
 =?utf-8?B?dXVWdmpFdUxqOXZsK3dna3NSMzkzNjBpZmdmSDBYdkRSOWJLTnVYSko4YzBi?=
 =?utf-8?B?T21HZmhSaGRaaGZqbWg0T2xvZ0p3TmorN2orSmpMODA3WG9nZ3dETFNOL1VM?=
 =?utf-8?B?MlZJYnFBTWlVdk55VHdaYWZzZWxaZ3RmT2E2RnlEdjdkTVF3NmV5ZHd5T3FV?=
 =?utf-8?B?WHlFTzNEUDlLSmp4aHNYa2RDYkE5QXFwU08yUytNbE1JNVVINFlaL2Y5aVZD?=
 =?utf-8?B?cWpRK1pNRnhQNHFubmRjWGlYa2t2ZXFiNEVORlJaV1NDOFpraGhBdXppbnNk?=
 =?utf-8?B?RWdCUVhXYlNTZHc0RnNXK2Uwa2lBUWZXUFhUWENlREdiNTJrQ0R2YS9JczNG?=
 =?utf-8?B?OTBFUkVsVHZ4RERZeDhNK01ZSGlnaEZVbk1ud0svaFI2dlYvVFJVSVdPVVBK?=
 =?utf-8?B?WFZiQS9vVGVuZ21NdFB3QkpuSnU3OTVsdWZYQTlxbXhtT01CdWtVbVh1S2F3?=
 =?utf-8?B?WTBzQ09IVXJHOFlHcWtNajRuMllOdHlsMUp1c2g3UERvV2E3cjk5alNheWNU?=
 =?utf-8?B?WXZqcmJhWXUzMHlabEk3TFlMbXAwL0I5VGVPQzcrcktoY1NZcGw5dVBrVWlY?=
 =?utf-8?B?QzVsdTdzRFJXVnhZYVNWZ2hpaytkeTFLQklEM0pXb3VnNHlFR012MzZGZnVI?=
 =?utf-8?B?QmVhWVc2SEtabXpaZmJKVGhNcURUOUpKOTlHNmtkZGo5SWI4VHo5Q1ZpS0xw?=
 =?utf-8?B?cVp0ZHNHWEhtRnRObEFJZUtZa2hjZ05KWG9EbVRDNCtRelNzMXAvQ3hoaEE2?=
 =?utf-8?B?eWN5Rm9XRElZNzVFalhLRmhBZS91NnpsWjRiU3BvSnJFRFZ3Z3RjU3hEYWww?=
 =?utf-8?B?ZDBPeGVaU0FNNE0rckVOTTdJS0UvN1VPRjRoV3RYMXgvS1VsL1RwZnNkaWZ0?=
 =?utf-8?B?L2VXTnhOTTE1TlRZallIaTVZUm9laWtnQ2VFcHlaUEh0SndnekNFc3JhOTM2?=
 =?utf-8?B?TTFNZndSWFMvR3YvQkZ6V1cyNm5Na0lrY2prZjNXRElNQUhSbUE1MnhEVjIw?=
 =?utf-8?B?QXVGSUNFU0RIL1JhcHcrMmg0TzhSaHJmNHhhL1QyTEJZaXN0YUpRK2l3bjBj?=
 =?utf-8?B?cnc5RnlHVG1MeDl1cklQYktkSWFFVmo5ZTVPakVsUmxRQVFLcmZhZDJGVk5C?=
 =?utf-8?B?Y1NxK3dCM1d5dktkMWF6eVNWMDJFcUVWWXBmLzFxTTF2aVZFZWcxSnUxRUNo?=
 =?utf-8?B?NGNXQ25SOTNacld3NXcwajROQWYwbHFGSXlFT0EwSm1KTW45RGVyVHRsZWly?=
 =?utf-8?B?WkxsWWowaWNzbmxpVVc3akhqc1dEQjdVbG9mSElDMHJZZUZtOHF2WmNRRFpy?=
 =?utf-8?B?aEVUdlpvUzYrN0dLQ0ZldDlHK21wbEM5eGJ4RjhsVG5YYWxhTWJVU25rdEUv?=
 =?utf-8?B?M3NtUjd0cDVCRnpPZkhVeG1waStsMm1oTWNzM24zRjIrdDZZVGFCM2JUS2px?=
 =?utf-8?B?Qm9GdVV6UnV4c0ZFTmEwTDQ0Z0pJSi9haG9DTGEwN2dNVFlBVnNBb0pLZ3VS?=
 =?utf-8?B?ZVVrdXk4MUE2SWVzYjNJWXFDT1ZJQW54MysrMTBCZEZNbXdmcVVUQklEblk2?=
 =?utf-8?B?L0hha3FxMXRNZ05VaG1vQlRtM2ZGbUZGU3lHNTJMSm92YVVQK3ZLY2Z3NGF0?=
 =?utf-8?B?UjFMTkU4RVhXVW0xcG5jQkRXbkZPNDcvUlE4MVJoSDFEWjcvWW1uVXV3MXpD?=
 =?utf-8?Q?nr+uCmXs5MtpX/XxVpnO2bl/+w/mTHQA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cy9TdUhLNnp3ZERWR1h4YUo2bUMvbk5aOVkwV1ZvaU5TQTJMMEtvRXZFMFh1?=
 =?utf-8?B?QXNZL3Zlak0vd3RWWkkxTE1RVmY1aEhGQktES2pVSFZPdDk4NFliQm1OMzdm?=
 =?utf-8?B?aENKSUFjazdCSFMzRHpMZDRvc05EYVQ2amJXSEZ6VmxpUnlncDhyUFc2cTIx?=
 =?utf-8?B?MWQ5NmZXR3pFeUtzNkZNcCt5QmpTSnRKaW02ZVNFU1RjRlBidmc4NU9zMGFk?=
 =?utf-8?B?bGNtTjg0dGhGbGdJUGdkR3FwUDVTZjN6eVkxZUVDcTNaUjNTRlR3aFdsZFhn?=
 =?utf-8?B?YXRQNjkwUURIU1lFZHBIY053bjhTQ1NjMStHNnEveFpBOE5VaFRqT01sRE50?=
 =?utf-8?B?M0k1emR0MzFxZjl4MzVON3Erc01ST1NUTzJ1VEdUM2tUdFZyK08yYTBrT2t6?=
 =?utf-8?B?ZFk2dHpHaXFpS21EVWhNT1Y2di8wZ1liMUhJSEwwbDVQd2hsak1YYTcvZ3hx?=
 =?utf-8?B?a1hWMkhmYlp3QWUvT0E3ZTd0VlkrQnk4N281MXlaSy81eUtWTTI3Q2xhMjNO?=
 =?utf-8?B?MEU5dTc1MWZoa1BucVZPT0FkWmFTZWk0bFZmaWl1M09wcDZMcXhqMEFLcFIx?=
 =?utf-8?B?eDM5cXFEV3REdDlHQ0tVZGJHRE5NTzQyVDQ2bEI1ZDFpYTlBZEVzUkhWeSsy?=
 =?utf-8?B?ekNicTVWb09IWnUzM0VMWEJPY3BLbXQycWhBTjRuaTJLaGwxT2hYRjVGbjZG?=
 =?utf-8?B?c2U1L0VSNU1Wb1ZORHNsVlptTE9sKzMzSEVsTjFuTE5sZkNkTHhRSHRBMkVa?=
 =?utf-8?B?c3Z0bzF1bjFOc0NPY3V1RTJiUm5sK2VGeWdHVGZJdEgwbGpyMWl6RGI3NzNU?=
 =?utf-8?B?TTNTSVNQT1hvWDkyS0lyNE1pRG1qZkFBTTVNNGtMM0FRTE5Xa2x6TG03WVA2?=
 =?utf-8?B?VU42OXhtQnpWYzZCWVI0UUkyZFpwRktHeVE5SlA3SnJSM085dDRsTmwzdEJy?=
 =?utf-8?B?TnJpbDdYNWlFelB5ZVIzak5nQ1BrOEd0Y3lUMWQwUEowNW5WNUR2d3FIY0Nv?=
 =?utf-8?B?UzRucXliemtxSTVVcDlrYUx4UHoyaUUvU2VUbCtkdjNjcnJ1MWN4MWNkbkxy?=
 =?utf-8?B?VU1acWRLbGFLVzBmK2FGaUkwZFovQS9zMll0aktrM3JYL1VEZ0JobjI5QXpW?=
 =?utf-8?B?UFd6WEFqOXYrYnY2VFE2Mm1sMHA3VW5JYkg1YXp1aXA5TXFzcWd2eE1YRjZE?=
 =?utf-8?B?bTJBdTZ6MjBvYnZ1WVNxY0FxQUV2OERpMW9xRkp2cGEzQjM3U0cxMVpiWnlY?=
 =?utf-8?B?K1BYRmJpQVFqMWFmNWZ2cU5YM2ozNkxRZUlDTW9aTEcrM1hKa0NnOEtmK2VH?=
 =?utf-8?B?U2tPZXY5emdROWdLVUFtUXZYakc5Ti9sWDZEYzZBMmp1ZVVMeDRxcTd4Z2dX?=
 =?utf-8?B?NjNOc24vclgzUlJsWk5JZjVhTDVTNVBSWDJ4TkhpNHBxSDhBcG4wVXYxT2VL?=
 =?utf-8?B?ZmJJdFdBYzJlV1JKSXp4Q2ozUDVRK2s5Nm0yd0FJMXhWSkVMMnZRT2ZPZlcw?=
 =?utf-8?B?Z2JoaEZ3UG5iRXhQWU5HdHFyck1uNHZqZFFhMlF4UmxicHNqVXRLK2VPR3hC?=
 =?utf-8?B?RlBIRFVzN3VCbGtuSHNuZUVJcktPR3A0RnFsUnRNVWVPY0dtWVV3eGJIRDNJ?=
 =?utf-8?B?UEcwbHIvTGkzd0VUUGtJYi9iTnh1Ykh2Vm1VNHpTcnE5MWQzd0RDU25YZ1Qz?=
 =?utf-8?B?bWNqTlRDOFJpVDRheEYxNDFCck1VUzNBVTJHRmlaVW8vR3d4M1V5SVlLNmRh?=
 =?utf-8?B?VXZra2k3S2kxMC9zR1g0MzJPaVRTUjliSHM0SWgvVTJqdTY1bFNidkxocU5E?=
 =?utf-8?B?WVVwME13NHM1VnUvS0ZZZmpaSXU2dHQ5ZURoOTMzUE4rQUlaSmlta0VSdktT?=
 =?utf-8?B?bTBiMzBqWXA3QldRRWZrcEo0VVBCOU1STC95c0tNZWo3WTFyUmhDUDVSZVhw?=
 =?utf-8?B?RVMwYUlkdXNERWRmQ0xGRW5Ccm10dWRNM1ZzQnE1bUUxTnU1ajJMUzdiajky?=
 =?utf-8?B?aElZUHhGUnFuVHp5NFRSTWJhblVKVmpLTS9iNCs1RHdoSmVaWWs5Z3g4Ym5N?=
 =?utf-8?B?N2huekFrTkpUdXlJRWxlWFZvNWJMTEJaTWJPQ2Y5REdVQ0MrNEpYYk8yNUFr?=
 =?utf-8?Q?H+Ww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcd5c75-2679-420c-551a-08dd51e73817
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 19:46:07.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLJvYD4pl41Hm4RlIjEYHXVSrtxAf+kDqmbQRRzAMWwLundHOu9NeFd4zb7g8R76mcfhT8dHMHzI1dL426IY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxz
ZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIwLCAy
MDI1IDEwOjI5IFBNDQo+IFRvOiBHdXB0YSwgU3VyYWogPFN1cmFqLkd1cHRhMkBhbWQuY29tPjsg
UGFuZGV5LCBSYWRoZXkgU2h5YW0NCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IERhdmlkIFMgLg0KPiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgU2lt
ZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47
IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggbmV0LW5leHRdIG5ldDogeGlsaW54OiBheGllbmV0OiBJbXBsZW1lbnQgQlFMDQo+DQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMi8xOC8yNSAxMTowMCwgU2VhbiBBbmRl
cnNvbiB3cm90ZToNCj4gPiBPbiAyLzE1LzI1IDA2OjMyLCBHdXB0YSwgU3VyYWogd3JvdGU6DQo+
ID4+DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTog
U2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4+PiBTZW50OiBTYXR1
cmRheSwgRmVicnVhcnkgMTUsIDIwMjUgMjo0MyBBTQ0KPiA+Pj4gVG86IFBhbmRleSwgUmFkaGV5
IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+Ow0KPiA+Pj4gbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZw0KPiA+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBhb2xv
IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IERhdmlkIFMNCj4gLg0KPiA+Pj4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+
ID4+PiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+PiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEVyaWMgRHVtYXpldA0KPiA+Pj4gPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgU2Vh
bg0KPiA+Pj4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiA+Pj4gU3ViamVj
dDogW1BBVENIIG5ldC1uZXh0XSBuZXQ6IHhpbGlueDogYXhpZW5ldDogSW1wbGVtZW50IEJRTA0K
PiA+Pj4NCj4gPj4+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0
ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+ID4+PiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRh
Y2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4+IEltcGxlbWVudCBieXRlIHF1ZXVlIGxpbWl0cyB0byBhbGxvdyBxdWV1ZWluZyBkaXNjaXBs
aW5lcyB0byBhY2NvdW50DQo+ID4+PiBmb3IgcGFja2V0cyBlbnF1ZXVlZCBpbiB0aGUgcmluZyBi
dWZmZXJzIGJ1dCBub3QgeWV0IHRyYW5zbWl0dGVkLg0KPiA+Pj4NCj4gPj4NCj4gPj4gQ291bGQg
eW91IHBsZWFzZSBjaGVjayBpZiBCUUwgY2FuIGJlIGltcGxlbWVudGVkIGZvciBETUFlbmdpbmUg
Zmxvdz8NCj4gPg0KPiA+IEkgY2FuIGhhdmUgYSBsb29rLCBidXQgVEJIIEkgZG8gbm90IHRlc3Qg
dGhlIGRtYSBlbmdpbmUgY29uZmlndXJhdGlvbg0KPiA+IHNpbmNlIGl0IGlzIHNvIG11Y2ggc2xv
d2VyLg0KPg0KPiBJIGhhZCBhIGxvb2ssIGFuZCBCUUwgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBm
b3IgZG1hZW5naW5lLg0KPg0KPiAtLVNlYW4NCg0KT2ssIGdyZWF0IHRoZW4uIFRoYW5rcyA6KQ0K

