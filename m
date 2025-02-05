Return-Path: <netdev+bounces-162958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AFA28A36
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08BB1888D17
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A222CBE0;
	Wed,  5 Feb 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVUqJ2L/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41522CBD3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758331; cv=fail; b=RV1iUuFex1Q5DdKZGUdO/gasrC+s7twsHx3NT6dIzCwEWT29VYaGEHvTRi5sAWid+Yrvp9n77/TdEUBkXzNYlq1mJM4jko1Y904y7hWVn8iY//TU9kj0y97UiMTHlhMMNtpZoXc5yw16HR8ZtUSNWfkzDAb9am8aRlmFjffQOB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758331; c=relaxed/simple;
	bh=S9HE0DZja9pKD20DjP1Lj5yq8M+xsJ6oNUdPFdVTumY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUW08993qefe6CCYBSpUtPECVkO5PvxPHA0rM2el5tf1zfyXm3pLJ0YmzIATqspANYkUWJoGg7s4482lkRAxglLoY/g+ZFcw4RgV3X9X/c9xeFVw4vVUqEe0XRbsDidri/7DRGXeM5SOkxRKdna+0TCVtxBFJeyT8hF+MY8Nv3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVUqJ2L/; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN1gPhRzXGw88RhFrhGf3CSvRdsSYfKxayOkhgmSJktNvHS18jGTD++raUgfb08QK1fQ5AWnLICtPXQ+y0U/5HcQ3RbM/oSgz7KscCCxKAfzlGKsdiQCv5VB4RvWFODAa3AmBDWKo/+ZHB/cPswZcLjLEQ/q4+levqry63RrqEnL02WiZ5d2wiUABXlagyRwm1DvZCKBI8vLt6L+w7EGdHm1BG/FeYwILG+HnpSdVofHlGX2nJgATlIyLFfjTRsW+sNLeyd+vFbDTZ2TSKZWucg/y/aKDzQf3NNGFyVOxs2zioh8D/lfGSQoNiLHVs6t6y2Phji0dXX3Niz4/sZF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9HE0DZja9pKD20DjP1Lj5yq8M+xsJ6oNUdPFdVTumY=;
 b=t69G6DsdeN6AKYOkksaqiA7Y0IiKlpnpDXAIhmM+tt4rvuDe4yay/8V2XewTw8w3GBpOxVI9ZOgjG2EfRbphtiNDZyrdAJoSX4oof5XinR86HhU0QwfyyYBrdmWkl+ykjADs+YrPmWvcv35ONpLJbprrNHGeNzHOVlSy1OHByh8Xc6ml1F3+/qzVkLNfh2ui0Jtc6046eCorGQmeuyDhEl6J4itB1wlYj+VwDrW5cxFE84mVkRridPw5uWPO+/94DxIph8pp4ZO5vCQkXrTVyM8poqfxK23FojXhyn3lXyU0A4HcD4MaF1o2xLAtUJJtsZS83m8q2k8gfcuqErWv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9HE0DZja9pKD20DjP1Lj5yq8M+xsJ6oNUdPFdVTumY=;
 b=NVUqJ2L/uy83ialRC8ysxrBpswXNeiL4yvkvFRbx4ODSDtNrx1eLQa9lVvzKyoFjF0sN6U4odb1Fc4Ki9IFaJYkpct/9sJ/dG1+9LNZ7ZUQWaQRck7BGpJzyIjuTbykruscfBqK3pFXqpKY6O8bo2BeehTWQ0uhUber7QZNjNegIhsDlgi4bG8aCPRE73Qsm74GOQAKwgrYyAl8Q5FbJ8EP3up4Uor8Vc9PC8ljtwnMWqh9zNdVgIwTqn0x1KplqRXb8riq8vo7FXT/WKP5cgsl1lJ2rYjXav/wXeCCxy2E0vdUKll3Cdc+ACFccV3lSVfrDDxFfNIvLP6kVc+hdgQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 12:25:26 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 12:25:26 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbdwpytanztMFZ5kSa6adxP+Q0lLM3/t6AgACJ54CAAAfH4IAAEe2AgAAAmcA=
Date: Wed, 5 Feb 2025 12:25:26 +0000
Message-ID:
 <DM6PR12MB4516BB5F52BB011832F45B98D8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183427.1b261882@kernel.org>
 <2ca4e13a-c260-40dc-b403-5cc73e664e02@linux.dev>
 <DM6PR12MB451696EDF6DF09074926E8F3D8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
 <7c417b93-773b-432b-89f6-fe380ca4878f@linux.dev>
In-Reply-To: <7c417b93-773b-432b-89f6-fe380ca4878f@linux.dev>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA1PR12MB7411:EE_
x-ms-office365-filtering-correlation-id: 82b6ece8-f589-4420-f411-08dd45e02bae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUllRXJ2QjFGZW9pZDNGVWVZU28yaTlPKzBxZy9BclRSSW93c1RaRE9CSkpK?=
 =?utf-8?B?QzBUcHNLZjJjMWJrdU93UDZZMUxNRkoyajFUUzFXbzM1RmZySXlSUDY4a0hi?=
 =?utf-8?B?ZEphQ05BN1A3OUNYTjRKOFVUV0duWmVtUCtCdmtENWpJaXdwZ05BNUQwbjhp?=
 =?utf-8?B?ODU5c3hwWFVVWjlTVGFzcUFSZjVUMW1FenpSYUdzTm05M240emp6cXFtdHI2?=
 =?utf-8?B?NGc2YjE4UHhhV1kzdlRETEljbW1rUExMWDlySVhrQ1FxVm56eklTTHNhQUp2?=
 =?utf-8?B?MU9pWjQwV3p6dzVHeG5Zc1RERnhWSmFQanNiT2JXSUdmckIyRjArWUw5Tmkv?=
 =?utf-8?B?bFJMSGdHZVBSQjBaaUlGZUYyQXZ4MWFlVUozQmVpdC9aei9SRzRaNHhVbS84?=
 =?utf-8?B?SGZvZmo3RCtYMGJUR1Z4enVrYWhsN25objhyazRyWEZnVjhBNEFCN2h2OTY1?=
 =?utf-8?B?UDNNWDFBWTlDRjUyQ2FZem1rRXQ3R0V1VzZDMDYzU2VnOUE2dVlDS29kZUxr?=
 =?utf-8?B?aTVwbFRkZkVRK3hmQ2F0NVZDVnBUUTliL2JyKzg5ZTRnQ3JqclNad2cvNksz?=
 =?utf-8?B?SXlTeVRCYlNERSt0VzBscFZFd2hmMjNneXF0RU1lMHU5RTIzNzJ3dmJKREpX?=
 =?utf-8?B?aXFzaHBtL3JLTkp4L3JVNGRIV1pxZXIxVHk4VHdkZUdFZGcvYStLYUZMc2F4?=
 =?utf-8?B?ZmZ1ZTFxcFZySDVrRkQrSnBJTEFSU2dOem9jV3BnaHJLaW9kbEJCd0p3N3hW?=
 =?utf-8?B?NUtEQjFlaGd4UzhqMVZic3h3aGN0MW9GeEFMNWdWVUZZWk1rMHJZWWkwNERr?=
 =?utf-8?B?bWJ4RmY4YVdFN0dYcFJRSTM3US90d0YzUysyOE85Y29iOTkrQkpCc09ldk1T?=
 =?utf-8?B?Vkc5cTAzV0ttRS9EYXhTTS9Ic1RMMWxEcmpjWjY5NGE3TVdWNEdlYVpNbnRD?=
 =?utf-8?B?SzFXcmdlWG9qMkNncVFmSElXRURLTlEvTXVYMVVGa2syRllCbkxRQ1YvYlhr?=
 =?utf-8?B?VWRpZFM0N1lQd2RjOC9hZWdGZG5aOWVWR21jNkkxaEU2d3luWHJ1Unc0WHhJ?=
 =?utf-8?B?bUJPTXBKQnZKRGV1QjVDRGRvMW04dmpXcG5hcXd1cFY3QlVSenZwaWRGQTln?=
 =?utf-8?B?OWpYYzRTbm11TC9zUHVOaGZwMGpUSEJub0lkQ2p0T2xNMDNSY3BlV1pZa2dP?=
 =?utf-8?B?bnVYeDNFSFRoQ2UwNWNsVGZEVUN5cis0aEJkdW9oNEFtZXNOOGd4aEsxRjdk?=
 =?utf-8?B?OFM4Vk1QMzBNeEJFRmM3TUNCdmJ5MWREeDNIQnJYNUNqemRMTDMyY3RtMGFr?=
 =?utf-8?B?ckhORjNmWnY4cXI5NDlOMmJwSWdlMzZ6NkEyMGdaaTYzS1J6MndOYUtjcUg3?=
 =?utf-8?B?elo2ZURxSVdmUXRLRExPbjJUSUFzRXhpbTByS0RNY3plcUo3RDdxMHVoeVUy?=
 =?utf-8?B?NzdRc1pDRXhqeGlKd2RsM3creVM0bUM3bzA3UG5Ock5WTHp1c05MZWxUUEVk?=
 =?utf-8?B?eVE4dmM1UXNrNk05M1JNYmlXc09aUGN4NkJMR0krUHQ4S1A5VkxwbEZoQ0pL?=
 =?utf-8?B?SXVMNGFMV3RkcWhTMXhqQTJ0ekRKcWxmaGh4RUlVMWFQOEo3TmFqOE9xYWF0?=
 =?utf-8?B?eEIydmRGRWh2cE5kbjR2ZHlJTmthNng5SktmN1hMSnpvUXBoclU4bG5WRG11?=
 =?utf-8?B?Q1hXK1QrNTFIY25IZHBxaGdDaCtTWVB3NlZmalZ5RWZsMFoyYmlvZEVCNFNG?=
 =?utf-8?B?RUZ5ckVQYUErUVUvTWFzRUJScVl1VytlaTRlakVWeVMxTUZhTFdlWlY0Smcv?=
 =?utf-8?B?NERnNG9Gbko4YS8xWnFNM1RabTg0RkhkUXFhSUI3WWZHZHRCRkYranRnbkFB?=
 =?utf-8?B?enIwQTNKcVJENGxUbm83U3RKRlZlODFncE95ZlJZVk91OEhZREozMnQzaDln?=
 =?utf-8?Q?TnN4wgmeRJT+1odZS9Y2n3oSklbz5ZKh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGpPRk00WTNOQ0hwNXR1TnBZMnA3WSthVnl3NHlyNGowOVpubXUzSUFBSHlC?=
 =?utf-8?B?L0VWblUySnFkV3Jwc25acGN2UWFZRjdxU1htbWV0MEdZZzZIcUdyWjlhcnFm?=
 =?utf-8?B?a3N1ZmVyRnhGUGN3dmlWTC9kY1A3MU5ESXB5bFgxbEcrWXpyNWxQaGMrRjZL?=
 =?utf-8?B?bUU2SHdGdk9DTXRDSEU2SlUzL2luUUxGV3NyR0t5cWhlbTUwaEU1L2I1YVB5?=
 =?utf-8?B?cU5xY0o1elBSSTJMM3NsVk43bnQ2MmlGdmF3SDlSK25kVXhHVHNNYkUxcGZK?=
 =?utf-8?B?K1cxNWZtN29IOHBaRk13NFlmQmduNUVQOHE2V0VVV3U0QlB5K09zTTBLNDdi?=
 =?utf-8?B?ZndqcjNBaXFaa1lCcmZlSk9pVzhYdHJXcHZEVllXVnlscG1lcWJSSXVFY2VT?=
 =?utf-8?B?dm1rc1RzVFJBaG0rQ1o3a1NiQitJUkNnS2tHY0xzNkxKSk1wQnk3Y2ZVNUFp?=
 =?utf-8?B?VElVL2JPdFZLQnNrR2RTdG1vczR5WE9KSEFMU3p3YmlBb0VFd1RCaDZIYU00?=
 =?utf-8?B?QlUzeSt3NnU2NGl5TWtxUkIvSTROdkNhMVRrR1cvQk5iNDlZVXBueElWWGJR?=
 =?utf-8?B?T3RldmJsc0hOSjVxMXpwaGJtKzJRQmVlcHN3YVBFcjNNaVlCcktFU293cURE?=
 =?utf-8?B?dGZXMFpRbCs2ZHY0M01VMnA0R0lqaEFaT2poZUJLTVBJSmE2YjVLSGRuZ3A4?=
 =?utf-8?B?THpmTzY4YkhrZS9DdWRmZldLOXpRS2ZpYnhNZ0tJUzJOeEY4OHo4VjVrNk5l?=
 =?utf-8?B?ZEFJNUhlVWtsZDlYTEEweTliM0pxL0g4YzF1dmdDZ1hsbUxpTjg0R21qdFpL?=
 =?utf-8?B?cjQ4Nkx1WlNvMkxWeUVSM0pXL0lKNnZwQzVaYzdBTUFzemFReVZJeFVscVdR?=
 =?utf-8?B?RnF6VHRuT2QybUg1ckJscFpwV1ZZSGovZlVYWElTRXBtTm03ZXQzNTlCVkZ4?=
 =?utf-8?B?K3BWUmMwbWdHNWpWUWttY0o0c1kvVkZqcE11aC8wWlRGSEswR2dZZG9LQmEy?=
 =?utf-8?B?bS9OOEVENmJ3U3lyMlNjenZab05QNlFDOU0vNjB4MzZQRHJzNWZFWnRESERN?=
 =?utf-8?B?TE50ZitHUlBHMFhOdnF6cTJOMXVNVGxYL2pKZmxuMlB6MHlRdFlKdkltTDNE?=
 =?utf-8?B?Q3dzRzNzWW5BZ05uZlVzRGsyRWw0emo0VjB5ekIzS2pFSnhtN0ExUDZBQkpu?=
 =?utf-8?B?R3VlUUhCSTUzMGNxK2R1WTFaRWFUa1Zoek1PSGM3Z0p6MVhxUXhOREM2WVZE?=
 =?utf-8?B?K1hnYmdjYzJXTk5ienJYOWZQUlhuR3dRcitHdVd3MHVNVG9FT3l5RGRpcW84?=
 =?utf-8?B?TU82Qllhdng1UnVueXpVSlRqOGNwTEY4aEl5YjFRMG1JTjNIUVNOaHRkODdK?=
 =?utf-8?B?ZG94RUlHb212bGY4eVJFdyt2Rmk3TmlOeDFXWXVCZGxVRGI1R25wcEYxRkVl?=
 =?utf-8?B?RDRLRU5oeGxpWWhmTkFMMy9xdStaWVgvSWIrZk1JV25NMmpYTktzdGJ1S0lt?=
 =?utf-8?B?b1JXQTMza2orN0NieVF0TTZBM0NDajN6bmdaczJPRm4xUmQ0ZHowd2VpN2pl?=
 =?utf-8?B?Uk1VbHBPRHRNL2dFSlgrUVdPdzVmVUhCOUplb1pNRm5RWXlkR3MzZFc0cHZk?=
 =?utf-8?B?OTVVNjRnR2t1QVV1RHdMcEtoN0pGUzJjb0lkdWdpSzIyc1FtZC9GR2FOc0JO?=
 =?utf-8?B?RkhYMGlLOUZsajJKRXJjZnFYekhXN01lV1dRcUVCUGdUR3RuY214UGtMRSs0?=
 =?utf-8?B?Ym5xdUlHUlZ1RFlaTkhWSUNtMVZxdHRWQzRwSWg5RStvUWlYQy82YytTb2hi?=
 =?utf-8?B?YUUyUTdBTUZHVVUrM0wwZFdYa1M3WWswanNMeGxvaG9nc21mcGh5MkRSWkFT?=
 =?utf-8?B?NXluR3FxMVhUNjRmaEpPSCtGbk5IRGVNR29ZUXRJY2VJSmFpRmtTNmRrRE84?=
 =?utf-8?B?M1FTMTdQdFl2WDRydXpDNjJlVjRORlRpano0OFhuNkJhK0FhMldVNFdMb29J?=
 =?utf-8?B?QkVtbGVQRlh2bU16SUpndzY0RXlZQ2t0N21zenVUazRhVUlzWGdMKythVzF4?=
 =?utf-8?B?RWtLcnRGbUJ4R2RGTDl2ckhvVXgrZU04bzVLUjV0anhjbzlFajJYNmlkT2ta?=
 =?utf-8?Q?dsmNCAxjbuTCKWrD8Brq014VJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b6ece8-f589-4420-f411-08dd45e02bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 12:25:26.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL3tvKc0zCR66zU/10UN4/9m+VBFhZ/psaj8C7XBjFwokqg8LepcSXaCHB1jbx6GSBKbZ8xE1Jrx+PpUEnFjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

PiBGcm9tOiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgNSBGZWJydWFyeSAyMDI1IDE0OjIwDQo+IFRvOiBEYW5pZWxsZSBSYXRz
b24gPGRhbmllbGxlckBudmlkaWEuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2UuY3o7IG1hdHRA
dHJhdmVyc2UuY29tLmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0IENvaGVuIDxh
bWNvaGVuQG52aWRpYS5jb20+OyBOQlUtbWx4c3cNCj4gPE5CVS1tbHhzd0BleGNoYW5nZS5udmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCB2MyAxMC8xNl0gcXNm
cDogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nDQo+IHRvIC0tbW9kdWxlLWluZm8gaW4gU0ZGODYz
NiBtb2R1bGVzDQo+IA0KPiBPbiAwNS8wMi8yMDI1IDEyOjEzLCBEYW5pZWxsZSBSYXRzb24gd3Jv
dGU6DQo+ID4+IEZyb206IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRl
dj4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCA1IEZlYnJ1YXJ5IDIwMjUgMTI6NDgNCj4gPj4gVG86
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBEYW5pZWxsZSBSYXRzb24NCj4gPj4g
PGRhbmllbGxlckBudmlkaWEuY29tPg0KPiA+PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
bWt1YmVjZWtAc3VzZS5jejsgbWF0dEB0cmF2ZXJzZS5jb20uYXU7DQo+ID4+IGRhbmllbC56YWhr
YUBnbWFpbC5jb207IEFtaXQgQ29oZW4gPGFtY29oZW5AbnZpZGlhLmNvbT47IE5CVS0NCj4gbWx4
c3cNCj4gPj4gPG5idS1tbHhzd0BleGNoYW5nZS5udmlkaWEuY29tPg0KPiA+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIGV0aHRvb2wtbmV4dCB2MyAxMC8xNl0gcXNmcDogQWRkIEpTT04gb3V0cHV0DQo+
ID4+IGhhbmRsaW5nIHRvIC0tbW9kdWxlLWluZm8gaW4gU0ZGODYzNiBtb2R1bGVzDQo+ID4+DQo+
ID4+IE9uIDA1LzAyLzIwMjUgMDI6MzQsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+Pj4gT24g
VHVlLCA0IEZlYiAyMDI1IDE1OjM5OjUxICswMjAwIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4g
Pj4+PiArI2RlZmluZSBZRVNOTyh4KSAoKCh4KSAhPSAwKSA/ICJZZXMiIDogIk5vIikgI2RlZmlu
ZSBPTk9GRih4KQ0KPiA+Pj4+ICsoKCh4KSAhPSAwKSA/ICJPbiIgOiAiT2ZmIikNCj4gPj4+DQo+
ID4+PiBBcmUgdGhlc2UgbmVlZGVkID8gSXQgYXBwZWFycyB3ZSBoYXZlIHRoZW0gZGVmaW5lZCB0
d2ljZSBhZnRlciB0aGlzDQo+ID4+PiBzZXJpZXM6DQo+ID4+Pg0KPiA+Pj4gJCBnaXQgZ3JlcCAn
ZGVmaW5lIFlFUycNCj4gPj4+IGNtaXMuaDojZGVmaW5lIFlFU05PKHgpICgoKHgpICE9IDApID8g
IlllcyIgOiAiTm8iKQ0KPiA+Pj4gbW9kdWxlLWNvbW1vbi5oOiNkZWZpbmUgWUVTTk8oeCkgKCgo
eCkgIT0gMCkgPyAiWWVzIiA6ICJObyIpDQo+ID4+DQo+ID4+IEFyZSB3ZSBzdHJpY3Qgb24gY2Fw
aXRhbCBmaXJzdCBsZXR0ZXIgaGVyZT8gSWYgbm90IHRoZW4gbWF5YmUgdHJ5IHRvDQo+ID4+IHVz
ZQ0KPiA+PiBzdHJfeWVzX25vKCkgYW5kIHJlbW92ZSB0aGlzIGRlZmluaXRpb24gY29tcGxldGVs
eT8NCj4gPg0KPiA+IEkgb25seSBtb3ZlZCBpdCB0byBhIGRpZmZlcmVudCBmaWxlLCBJIGRpZG7i
gJl0IGZpbmQgYSByZWFzb24gdG8gY2hhbmdlIGl0IHJpZ2h0IG5vdy4NCj4gPiBJIGNhbiBhZGQg
YSBzZXBhcmF0ZSBwYXRjaCB0byBjaGFuZ2UgYWxsIHRoZSBZRVNOTyBhbmQgT05PRkYgdXNlcywg
YW5kDQo+IHJlbW92ZSB0aG9zZSBkZWZpbml0aW9ucywgZG8geW91IHdhbnQgbWUgdG8gZG8gdGhh
dD8NCj4gPiBUbyBiZSBob25lc3QsIEkgZG9u4oCZdCBrbm93IGlmIHRoZXJlIGlzIGEganVzdGlm
aWNhdGlvbiB0byBkbyBpdCBpbiB0aGF0IHBhdGNoc2V0LA0KPiBjb25zaWRlcmluZyBpdCBpcyBh
IHByZXR0eSBsb25nIGFueXdheS4NCj4gDQo+IFdlbGwsIEkgZG8gcmVhbGx5IGtub3cgdGhhdCBw
dXJlIHJlZmFjdG9yaW5nIHRvIHN0cl95ZXNfbm8oKSBhbmQNCj4gc3RyX29uX29mZigpIGFyZSBu
b3QgYXBwcmVjaWF0ZWQgaW4gbmV0ZGV2LiBJIHRob3VnaHQgdGhhdCB3ZSBtYXkgY29tYmluZQ0K
PiB0aGVzZSBjaGFuZ2VzLCBidXQgbm8gc3Ryb25nIGZlZWxpbmcuIFdlIG1heSBrZWVwIGl0IGFz
IGlzLg0KDQpJIHVuZGVyc3RhbmQgeW91ciBwb2ludC4NCk5vcm1hbGx5LCBJIHdvdWxkIHNpbXBs
eSBjb21iaW5lIGl0LCBCdXQgSSBmZWVsIHRoZXJlIGlzIGEgbG90IG9mIHJlZmFjdG9yaW5nIGlu
IHRoaXMgcGF0Y2hzZXQgYW5kIGEgbG90IG9mIHN0dWZmIGdhdGhlcmVkIGluIGl0LCBzbyBub3Qg
c3VyZSBpZiBhZGRpbmcgdGhpcyB0b28gbWFrZXMgc2Vuc2UgdGhpcyB0aW1lLCBvbmx5IGJlY2F1
c2UgSSBtb3ZlZCBpdCB0byBhIGRpZmZlcmVudCBmaWxlLg0K

