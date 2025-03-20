Return-Path: <netdev+bounces-176516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04409A6A9E9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5A018828AD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CC22541B;
	Thu, 20 Mar 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UoSUhRKj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0C224B0D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484294; cv=fail; b=beA42VxvCahO9FaNKAc8QWqcHIM7/jOUdEfyNwmOY+kkspM3+J7ywgYHWUgaMbO6FrD/MtWKAo6QbzKNkGD5tRy8CVnMRJ1X3gBnZGbLzSsrPP/22dynglg3RDRczzbDTgpfmJdvKz8z0KlOmtK+blynWC4c50SSHmvSI6yvNmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484294; c=relaxed/simple;
	bh=zrUKB83k8HNP/fyEw43UYX/EegmW9cCgBfjsyYzkMfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mFY81LvJEqXHWOmHMjXFkDB0kX5uh3U1iWr8cVpgMt/DT7H65oTR2W3ACp+i1+Wj+uMIQxK8SOzcBMIPfsHpfXfzWsSUkP5Qp4YuE53o/CQHtOkAaFgiX6i/IQaIaBrkeIlVGxMZ9kQCb5ejy3O3o2fWkQC+xmeueJrYGVnRWoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UoSUhRKj; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSxelMrUHpALKEdCSSPvSzFC3Q/US6pHR2pEVnN1Jj2b+mVT2cyiThXOJ6vF1hzKRrc97wQAEE/ci+CbTH6WLnMtrmqhITjUA+4ZwjNNaCZ4XFmswOIkNjeD6LmDPzqnUZ5xDkiNYG4ii2D4jLWRRVy+XcoehotiRCadPVa/aNENbhZ3uze0PttrHLaSs2QZllOBNFbJbtzHbze1XXwT5ZdIOVmzeFt+5SP6t+kc+w2o9d7obVqP70LE5Er48WAQGAeiHJOVUJz7PJsbdw9WLK2FGpu0Elz8t+/T6qeOrMGXlGzFTySrPziXxLSDlRsKNMoRwWhLPmOP23nLIoplmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrUKB83k8HNP/fyEw43UYX/EegmW9cCgBfjsyYzkMfI=;
 b=EfeQEzeexv2Crhv7OvZogqB6yieR8Kk+zjXbgH/7pn87qWmKfdoW1qAKp9yQHiphlnJzUteCPv9VqzQEshyjZ9ByMRUmS6IGIr5xsks4cyUkGthejBOfNRnllpLPp/we/Rr2CcZjm74RSOKHqoykmm+nVsyY8H3Xep2oidi8YGf183WdfAWepsuxcQ1W5fFcshcbYx0OSzJPAunGPwtU04vWP+T3TED//sg9r0Kohyibhi7MxH0wR7wwBs4+eVaKbt2b2U/5oixlPaUwa6PmvNrC/g/M1JLADNfjOsySzs+08m1HdnPTdvHBW/UzcSUzfkWMVfNQjb3n//UHZXbO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrUKB83k8HNP/fyEw43UYX/EegmW9cCgBfjsyYzkMfI=;
 b=UoSUhRKjm9O+9ZVhGXMOK68/8BG+WI0LNNmYjUqMpUoe28JhULPm4+SFAvTjsXsc5OgFSlL7Pzf92kvg0USj8W30zFPbADpzyHYegRn3Ei3NgzjJngiD+T5bIzWHeUEj0mb003Ts4IllwhDvM4764IfL7AoPgu7J84oj1wIyRzgeOcOeh+a8Pk5CG4elCWObYhom5UZFfL5mBVlTIRjfNaCy/jAfKN8xZrU7KSs8FTQEd/dhJY8adWoq+XVf4TTikbjqJ2nhUsvgsqWIIM6wc8mQysBx71LGpiVlg73MUEpYaOweTc4cEtDGS7d0LAjsj20mIygk4B5YslfJpD3iYQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Thu, 20 Mar 2025 15:24:46 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 15:24:46 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>, "lucien.xin@gmail.com"
	<lucien.xin@gmail.com>
CC: "chopps@labn.net" <chopps@labn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, Dragos Tatulea <dtatulea@nvidia.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Yael Chemla <ychemla@nvidia.com>, "wangfe@google.com"
	<wangfe@google.com>
Subject: Re: [PATCH net] xfrm: Force software GSO only in tunnel mode
Thread-Topic: [PATCH net] xfrm: Force software GSO only in tunnel mode
Thread-Index: AQHblyfqqyC8/2d/h0+DBEjIoKYBWbN3t9IAgARySYA=
Date: Thu, 20 Mar 2025 15:24:46 +0000
Message-ID: <305606b805fa2bb4725bcbd8c5ee88b88dfff7c5.camel@nvidia.com>
References: <20250317103205.573927-1-mbloch@nvidia.com>
	 <CADvbK_ftLCTfmj=Z5yhuatt5eOvxuf=sxbduwdjK4mfuw=4wVw@mail.gmail.com>
In-Reply-To:
 <CADvbK_ftLCTfmj=Z5yhuatt5eOvxuf=sxbduwdjK4mfuw=4wVw@mail.gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|DM4PR12MB7503:EE_
x-ms-office365-filtering-correlation-id: 1dd869e9-05f6-434b-1d4c-08dd67c358c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akFlMW0rVm45WXhReUhRRkNlcmZXU3Y2bjR5RlBZbFVmMXJMNUo4UTZQNGI1?=
 =?utf-8?B?amZjNzJtRlQrU2dsNTF1eVo4SzlZTXJ4RmthV09yemt5eSs0MWVVV3h4ZWsw?=
 =?utf-8?B?bUF2Z3JCMGRZQTBSck4wWW5KY1lKRkF0RGlrSWp2Y05USERtenRPTGJRcUw0?=
 =?utf-8?B?ejQ1NmRuMHgvU1NIUG8rT1NwL2JGUzgrS0NXUXpTaUpMRnRHOTlaRGRvR21u?=
 =?utf-8?B?MC93TzNDLzZucGpBQUNIK2xXSkhpMDAvRkR2OXN2d1FxYVN5d3lxRkwxWjVp?=
 =?utf-8?B?eVoxbGdCbG94N0V4TFlFODZYRUtxK1VGbXgxeDZGQkVFV1UvYUNWa3hVMXBB?=
 =?utf-8?B?REllZUdlOFc0Snpyc3h4bGpmRnlwdCtkczVFWHg3Yks2QW5uYUNaV2VKRk5J?=
 =?utf-8?B?a1lVZVhXSnd5UzlTQmZ1aTdlT2JRSWdWNHRsRE02blJudnVLY3Exd1RDK2x6?=
 =?utf-8?B?M3FZaUpOeHdpRCtJVEczNEgrcVpQTUVoSU0yNzdBRi9OQ2RSb2ZkclErSlFu?=
 =?utf-8?B?ZDROZHYra3NTT3hRenQ2WHAxSHk3UDVaNGo4YXNEQlUrSW95S3VUSmlTSytB?=
 =?utf-8?B?alhwR0llTERtQmNwSDlpbHNKeXhSZ0hKcmJxdDZ3Rkg2QTZYc2svY2hTN0ln?=
 =?utf-8?B?cnZCWlhLUGJFRDltd0ZWdTRXdjJHQjYvTE9IbS9hZjhyUUV6ZDcveFc2UTUw?=
 =?utf-8?B?Nmd3d1RYa2dzR3ZscGtVbXQ5WEhzVGZHc0VRa1FEME1iQXcwekFDSEQ0ejl1?=
 =?utf-8?B?NlFkWnFpZkxSM2VtVmZ4bHFIcU1zWkVkWSttTXR4bWJYQno4YWZOeEVmZG80?=
 =?utf-8?B?UTJVcWlqeWdGSFBmZVRNcTV5NVdIV2tvdHlYbk90UnBDb0VZUU00UGZmVzZv?=
 =?utf-8?B?K3FDR29mVzNqK0NFRmZvMGd4VERpbGRId1ljUWIvTDZpSzc2UFJhS1VMNFVj?=
 =?utf-8?B?cU9nTGFTLy82aTJNYTFLK1pRTC90YUwyZWJ6MXR1Rmw2S2JsUVhwTzlPMGRP?=
 =?utf-8?B?MzZhU0hRM3dIaWlSR09aT2VGMnY4WWtqaC9WWkdBOWJXOWdCZUdnS0pYcVBr?=
 =?utf-8?B?RVRXQVhUVkYzMWxSZnQzZHhHUE93ckF5R2xENGF1UTRBWU1ldVBEOHc5WGJp?=
 =?utf-8?B?cC9WZy9GMDJsYzdDMVR3aFowcTFFdmE1eEUrSitlUzUvSmhFZUZxTEtzTG13?=
 =?utf-8?B?NTJqTjJ5L2lEOEFFZEh6VU5tMldKZmFUem0yVDIzYlY4VE1kSERwVVNQM2F4?=
 =?utf-8?B?WVBnMWdJUTVzUS9kYk9sWEJnRWlTa21McUNIVzRHNTJkVjZzUG1YVlR0bTI5?=
 =?utf-8?B?OThrLytwcjZPUVFvblUyMm80aUFCWHJWckVuN2x5cHZWNmRuTUw5bEtBeVg5?=
 =?utf-8?B?K0Z1QzFFcWtnYlBsN2RFRUN3K3cvN0dIK0hsbnFmejBqZDJpSGFqYi9ZWWww?=
 =?utf-8?B?Y0J6b1ZnZ1JaTXdHdVN3aWJxWTN3UWdoRDNCamxRdVJyZWZKSWsvQ0MvSStI?=
 =?utf-8?B?cDRKTlVQSy84dDE5V2N5QU9GQ3VkbUk3T281MnFNZVdiTDlOdjl3dmFzdEpY?=
 =?utf-8?B?YUpKM2JJOFhBSDFjQzIyYTBwalc2ZlVVZWhvQlo4TDFaRHZsTnhpaXptVmJ6?=
 =?utf-8?B?d1Z2RmxxTmdGYTBpYkJXL2VmVmtyeEpZam9yQnJOWDk5eG1qUzdDS0NKUUR3?=
 =?utf-8?B?Yld0T2ljRUxtSkthYys3d0J1Rkl2cTBCU0hEQVRUcFdSKy9OR2EwdXpOaTJy?=
 =?utf-8?B?dFJXTmVIajlsMENjMTgxQXEzTit3dzF6UmdqZ2RlWVVIb1lSa3o2U2hpZHB5?=
 =?utf-8?B?UFdhd2V1Snl0bFVHV1ZHREprMS9lS1ZNaG8xajRDempZTGl6T2libmRFaUwv?=
 =?utf-8?B?R2paa3pzWEUvcUhsRGtLMW1qQnNmbWNncTY5UmlNLy83SXgyUGdkT2JRQkx5?=
 =?utf-8?Q?Q9KBoY/SiSSmqi8wlq/xcYugjcaPlWM0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDArOWt0Lzl5emovb3hnWTVNOVkycVlPaDd0OVlNSnVSc2tXSUpocDAyc08r?=
 =?utf-8?B?Wlp2RTJiVG1iOHU3VHFCYWtZZnU3ek9VazVxSGE3WWhCNHJWcXZnZzRIK1Vk?=
 =?utf-8?B?dWI1M1NGWjZnQlF0eVhld3dsZk1CLzJTZDFRVjZLWGJGRjd5WUptSkplcWg2?=
 =?utf-8?B?akpINVl3NkFBTUd5aXlrWERxV3BXa3hVQzFncVRvV1hTN1JTT0NwWUhBNTZE?=
 =?utf-8?B?VWpGOHJFZkQ5SVJVWDhiUkI2VTFrK0NxaVdXdlVmWHk3MmluZVNTLzNOUmwx?=
 =?utf-8?B?U3h0UCtBdTdiSGhZa1R5akg5Y0ptc3cyTkRldGEvVDdLVlZqd0ZJMzZmMWcx?=
 =?utf-8?B?cVhQakNkM1l0aGpQTm9oK0NrQ2VOZnFIWXQ3VFFGaXBDUUhrbFpCemE1eEx0?=
 =?utf-8?B?RExvRTByQzY2VFluRk9HOVdBWGVHSkltUUsyY1ptZWsydXJBaEZnZ2ZjeDBC?=
 =?utf-8?B?dWtqRjc3RXhraFhkTjlEaFlzTVJOL25EYUMzcFJITnVhUkFlSVpLYlFFMUJ0?=
 =?utf-8?B?WVdhbFZSdi9XYSthNHF5RHBGNUNHK2lRRGFSZW9nUzQzRldETnltbWVNbUtD?=
 =?utf-8?B?KzAvZXdnZ0ZvUHkzN3E0SktXTUxvZmJySDAxcUVQUEdwUHVSa0VDcm9sVlVT?=
 =?utf-8?B?c2pCSEhEUU9mcmtUb2o2bjhmNTE0bk1SeXU2QWdLOFNSYVM4cWJjM3dLNlNm?=
 =?utf-8?B?TCtJVHBvSUpETHhDbjAwdnA2REVhRGN3QmNPKzUvVngrSkpSUUpQZXA2dnFV?=
 =?utf-8?B?TlNHdkNxdVVTb3l4VTRrcWZRKzRPZ2F6WUJFSVozemUvMU9QeG9SMWI1Q0lF?=
 =?utf-8?B?NWVLSG9oMmQ1RGpZOTgzclhTaWlydzhMbGlJTytKeWVFSUNxSG1vUXNrSFFB?=
 =?utf-8?B?bFdIbmFiU1UrMjM0cjlYMnl5dzNmbmpGYTAyRS9yY3RhTDkyd0ZHbHNZNWQ2?=
 =?utf-8?B?M0NCdk5ZWlFDOGRoV0tiTDAxazEzMmhVekNYc0dZczRwSUhGKzNBdzJLcTVp?=
 =?utf-8?B?WkhlSkRvNjY3WDdDVThnYTJSS0VLd256aFRHWWRNMnZLazV6M25LZUlvdnVn?=
 =?utf-8?B?YmFrclIxRTdXQktQK1pmVmVTenkycDBmL2hFallkNjV1WEs0V1k4Zmt2aFdk?=
 =?utf-8?B?MVByOHdGaExLM2QySHEyL1RGNmxjMWpjK3dTMGZuWG83ZEhRZG9meFlTSnox?=
 =?utf-8?B?VGNuem52VFVIZi9YV1pabDdGNmJ3ay9kcHQ0eENmV0JnbVFFMFlDcWlPTnRs?=
 =?utf-8?B?Q3BxOVRGcnUwWWNnbTNMTG84QlNqUm5xV1lhcXFYWDk0dzFmL1BEcUlYeEdy?=
 =?utf-8?B?L0FhYnUrNmlVazF4ZUVWM04zYTFYUEkzMExsYXRSc1F5N2Zwb3k0VEd5c1Vk?=
 =?utf-8?B?b0lhd3BFNkdDWkR4bVJNL3BTd21HelhxUmxJcFY3M0xxY0pJRlRFblBycnJm?=
 =?utf-8?B?eWJYUS82a3VIT2FiK1hGS1Z5bGl5emt4aENIZFMzZUF1NUlEYnZZbS8xQW5R?=
 =?utf-8?B?SVFPQi9HeDNLWTZxSk5TTTBXVTc5ZExmeWZaR1ljdC9ySWh6b1BqRWZPbzda?=
 =?utf-8?B?ZW9vVlJlMjNBQUREcFlIM29sOEsyZ0RwalQvUDdXQnVqN203b2ZIbCtvQ1Y0?=
 =?utf-8?B?bVhqbnlYdnF6MXluNjFqZm1qS04xSDFTQ2JqT3h2TzF1S2k1dUkwa1dScWxG?=
 =?utf-8?B?amlGZGwzZmF2dmJsOFYvODJWa2hXblBjTk13OEg1UUFRUE9oeEM2T3RUQnNo?=
 =?utf-8?B?VnJhL2lpTzBXT3NNRXovbmlyWUljME5pSDc0eTloZ1ZPYTlIZWtMQXg5bm16?=
 =?utf-8?B?QTlrUlRjZmJETmNDWXNka0Z3T09FRGkxRGV2ZHNyQ2VWVW0zY3RZVW5OT1Rv?=
 =?utf-8?B?QXJpcEtrdUhpYTl5S2dTM0VMNk1ZcHlRbkdIa1o2djNNVW81cU9RV3BscjVu?=
 =?utf-8?B?M1Q4R3N1dHpKQjVFSFltQ0krZ25Cb0xpOFp6dXNXQVVxNHkweHRScTFqT3Rh?=
 =?utf-8?B?UnJWTzdYYXhwaUN6Tk81L3ppZHhrV2FQSUlyaDhkZXEwWUMrQXlFbzh2REZy?=
 =?utf-8?B?ZHlXek9zWnZ3VWZpcitkZnZoNW9Pei8rNXB4eG9ZMHpTb3NFc0hKMmhYb2Fk?=
 =?utf-8?Q?TgBxSRmmupWiQDqiNrJC3zTtF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E8F83D72E5295468DB84159236C2513@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd869e9-05f6-434b-1d4c-08dd67c358c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:24:46.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FS1hGAT/HPOUT0oyJdF+j60IUbFkgisUNtCQu1ymubFqZCGAhDOplxA3WSsK6dRU7sHeEtYet87dX1ER5Uf54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE1OjMwIC0wNDAwLCBYaW4gTG9uZyB3cm90ZToNCj4gRm9y
IFVEUCB0dW5uZWxzLCB0aGVyZSBhcmUgdHdvIHR5cGVzOg0KPiANCj4gLSBFTkNBUF9UWVBFX0VU
SEVSIGVuY2FwcyBhbiBldGhlciBwYWNrZXQgKGUuZy4sIFZYTEFOLCBHZW5ldmUpLg0KPiAtIEVO
Q0FQX1RZUEVfSVBQUk9UTyBlbmNhcHMgYW4gaXBwcm90byBwYWNrZXQgKGUuZy4sIFNDVFAgb3Zl
ciBVRFApLg0KPiANCj4gV2hlbiBwZXJmb3JtaW5nIEdTTyB2aWEgc2tiX3VkcF90dW5uZWxfc2Vn
bWVudCgpOg0KPiANCj4gLSBFTkNBUF9UWVBFX0VUSEVSIHJlbGllcyBvbiBpbm5lcl9uZXR3b3Jr
X2hlYWRlciB0byBsb2NhdGUgdGhlDQo+IMKgIG5ldHdvcmsgaGVhZGVyLg0KPiAtIEVOQ0FQX1RZ
UEVfSVBQUk9UTyByZWxpZXMgb24gaW5uZXJfdHJhbnNwb3J0X2hlYWRlciB0byBsb2NhdGUNCj4g
wqAgdGhlIHRyYW5zcG9ydCBoZWFkZXIuDQo+IA0KPiBIb3dldmVyLCBib3RoIElQc2VjIHRyYW5z
cG9ydCBhbmQgdHVubmVsIG1vZGVzIG1vZGlmeQ0KPiBpbm5lcl90cmFuc3BvcnRfaGVhZGVyLiBU
aGlzIHBhdGNoIHJhaXNlcyBhIGNvbmNlcm4gdGhhdCBHU08gbWF5DQo+IG5vdCB3b3JrIGNvcnJl
Y3RseSBmb3IgRU5DQVBfVFlQRV9JUFBST1RPIFVEUCB0dW5uZWxzIG92ZXIgSVBzZWMNCj4gaW4g
dHJhbnNwb3J0IG1vZGUuDQoNCnNrYl91ZHBfdHVubmVsX3NlZ21lbnQgLT4gX19za2JfdWRwX3R1
bm5lbF9zZWdtZW50IGRvZXM6DQoNCnRubF9obGVuID0gc2tiX2lubmVyX21hY19oZWFkZXIoc2ti
KSAtIHNrYl90cmFuc3BvcnRfaGVhZGVyKHNrYik7DQpfX3NrYl9wdWxsKHNrYiwgdG5sX2hsZW4p
Ow0Kc2tiX3Jlc2V0X21hY19oZWFkZXIoc2tiKTsNCnNrYl9zZXRfbmV0d29ya19oZWFkZXIoc2ti
LCBza2JfaW5uZXJfbmV0d29ya19vZmZzZXQoc2tiKSk7DQpza2Jfc2V0X3RyYW5zcG9ydF9oZWFk
ZXIoc2tiLCBza2JfaW5uZXJfdHJhbnNwb3J0X29mZnNldChza2IpKTsNCg0KQXMgYSBjb25jcmV0
ZSBleGFtcGxlLCBpbiBjYXNlIG9mIFRDUCBvdmVyIEdlbmV2ZSBvdmVyIElQc2VjIGluDQp0cmFu
c3BvcnQgbW9kZSwgdGhpcyBpcyB0aGUgc2VxdWVuY2Ugb2YgaGVhZGVyIG1hbmlwdWxhdGlvbnMg
ZG9uZToNCmdlbmV2ZV9idWlsZF9za2I6IG1oIDE5MCBuaCAyMDQgdGggMjI0IGltaCAxOTAgaW5o
IDIwNCBpdGggMjI0IGRhdGEgMTgyDQppcHR1bm5lbF94bWl0OiBtaCAxOTAgbmggMTU0IHRoIDE3
NCBpbWggMTkwIGluaCAyMDQgaXRoIDIyNCBkYXRhIDE1NA0KeGZybTRfdHJhbnNwb3J0X291dHB1
dDogbWggMTQ3IG5oIDEzOCB0aCAxNTggaW1oIDE5MCBpbmggMjA0IGl0aCAxNzQNCmRhdGEgMTc0
DQpza2JfbWFjX2dzb19zZWdtZW50OiBtaCAxMjQgbmggMTM4IHRoIDE1OCBpbWggMTkwIGluaCAy
MDQgaXRoIDE3NCBkYXRhDQoxMjQNCmluZXRfZ3NvX3NlZ21lbnQ6IG1oIDEyNCBuaCAxMzggdGgg
MTU4IGltaCAxOTAgaW5oIDIwNCBpdGggMTc0IGRhdGEgMTM4DQplc3A0X2dzb19zZWdtZW50OiBt
aCAxMjQgbmggMTM4IHRoIDE1OCBpbWggMTkwIGluaCAyMDQgaXRoIDE3NCBkYXRhIDE1OA0KX19z
a2JfdWRwX3R1bm5lbF9zZWdtZW50OiBtaCAxMjQgbmggMTM4IHRoIDE3NCBpbWggMTkwIGluaCAy
MDQgaXRoIDE3NA0KZGF0YSAxNzQNCl9fc2tiX3VkcF90dW5uZWxfc2VnbWVudDogdG5sX2hsZW4g
MTYNCl9fc2tiX3VkcF90dW5uZWxfc2VnbWVudDogaW5uZXIgc2tiIG1oIDE5MCBuaCAyMDQgdGgg
MTc0IGltaCAxOTAgaW5oDQoyMDQgaXRoIDE3NCBkYXRhIDE5MA0Kc2tiX21hY19nc29fc2VnbWVu
dDogbWggMTkwIG5oIDIwNCB0aCAxNzQgaW1oIDE5MCBpbmggMjA0IGl0aCAxNzQgZGF0YQ0KMTkw
DQppbmV0X2dzb19zZWdtZW50OiBtaCAxOTAgbmggMjA0IHRoIDE3NCBpbWggMTkwIGluaCAyMDQg
aXRoIDE3NCBkYXRhIDIwNA0KdGNwX2dzb19zZWdtZW50OiBtaCAxOTAgbmggMjA0IHRoIDIyNCBp
bWggMTkwIGluaCAyMDQgaXRoIDE3NCBkYXRhIDIyNA0KDQpBbGwgbnVtYmVycyBhcmUgb2Zmc2V0
cyBmcm9tIHNrYi0+aGVhZCBwcmludGVkIGF0IGZ1bmN0aW9uIHN0YXJ0DQooZXhjZXB0IGZvciAn
X19za2JfdWRwX3R1bm5lbF9zZWdtZW50OiBpbm5lcicsIHByaW50ZWQgYWZ0ZXIgdGhlIGNvZGUN
CmJsb2NrIG1lbnRpb25lZCBhYm92ZSkuDQpJIHNlZSB0aGF0IHhmcm00X3RyYW5zcG9ydF9vdXRw
dXQgbW92ZXMgdGhlIGlubmVyIHRyYW5zcG9ydCBoZWFkZXINCmZvcndhcmQgKHRvIDE3NCkgYW5k
IHRoYXQgX19za2JfdWRwX3R1bm5lbF9zZWdtZW50IGluY29ycmVjdGx5IHNldHMNCnRyYW5zcG9y
dCBoZWFkZXIgdG8gaXQsIGJ1dCBmb3J0dW5hdGVseSBpbmV0X2dzb19zZWdtZW50IHJlc2V0cyBp
dCB0bw0KdGhlIGNvcnJlY3QgdmFsdWUgYWZ0ZXIgcHVsbGluZyB0aGUgaXAgaGVhZGVyLg0KDQpJ
biBjYXNlIG9mIEVOQ0FQX1RZUEVfSVBQUk9UTywgaW5ldF9nc29fc2VnbWVudC9pcHY2X2dzb19z
ZWdtZW50IHdvdWxkDQpiZSBpbnZva2VkIGRpcmVjdGx5IGJ5IF9fc2tiX3VkcF90dW5uZWxfc2Vn
bWVudCBhbmQgaXQgd291bGQgc2VlIHRoZQ0KbmV0d29yayBoZWFkZXIgc2V0IGNvcnJlY3RseS4g
QnV0IGJvdGggY29tcHV0ZSBuaG9mZiBsaWtlIHRoaXM6DQpuaG9mZiA9IHNrYl9uZXR3b3JrX2hl
YWRlcihza2IpIC0gc2tiX21hY19oZWFkZXIoc2tiKTsNCldoaWNoIHdvdWxkIGJlIDAgZ2l2ZW4g
bWFjX2hlYWRlciBpcyBzZXQgdG8gdGhlIHNhbWUgb2Zmc2V0IGFzIHRoZSBpcA0KaGVhZGVyLg0K
QnV0IHRoYXQgb25seSBtYWtlcyB0aGUgcHNrYl9tYXlfcHVsbCBjaGVjayAmIHRoZSBza2JfcHVs
bCBub3QgZG8NCmFueXRoaW5nLiBUaGUgZnVuY3Rpb25zIHRoZW4gcHJvY2VlZCB0byBzZXQgdXAg
dGhlIHRyYW5zcG9ydCBoZWFkZXINCmNvcnJlY3RseQ0KSSB0aGluayB0aGUgY29kZSBtaWdodCBz
dGlsbCB3b3JrIGJ1dCBJIGhhdmVuJ3QgdmVyaWZpZWQgd2l0aCBhDQpFTkNBUF9UWVBFX0lQUFJP
VE8gcHJvdG9jb2wuDQoNCkluIGdlbmVyYWwsIHdoaWxlIHN0YXJpbmcgYXQgdGhpcyBjb2RlLCBJ
IGdvdCB0aGUgaW1wcmVzc2lvbiB0aGF0wqB0aGVzZQ0KZnVuY3Rpb25zIGFyZSBicml0dGxlLCBy
ZWx5aW5nIG9uIGFzc3VtcHRpb25zIG1hZGUgaW4gY29tcGxldGVseQ0KZGlmZmVyZW50IGFyZWFz
IHRoYXQgbWlnaHQgZWFzaWx5IGJlIGJyb2tlbiBnaXZlbiBhIGRpZmZlcmVudA0KY29tYmluYXRp
b24gb2YgcHJvdG9jb2xzLg0KDQpJIHRoaW5rIHRoYXQgdGhlIGNvZGUgYmxvY2sgaW4gX19za2Jf
dWRwX3R1bm5lbF9zZWdtZW50IGNvdWxkIGJlIG1hZGUNCmxlc3MgYnJpdHRsZSBpZiBpdCBzdG9w
cyByZWx5aW5nIG9uIHRoZSBzYXZlZCBpbm5lciBoZWFkZXJzICh3aGljaA0KbWlnaHQgbm90IGJl
IHNldCB0byB0aGUgYWN0dWFsIGlubmVyIHByb3RvY29scyBhYm91dCB0byBiZSBoYW5kbGVkKSwN
CmFuZCBpbnN0ZWFkIHBhcnNlIHRoZSBtYWMgb3IgbmV0d29yayBoZWFkZXJzIGFuZCBzZXQgdGhl
IG5leHQgaGVhZGVycw0KYWNjb3JkaW5nbHkuIFRoaXMgbWlnaHQgZXZlbiBhbGxvdyBiYWNrIEhX
IEdTTyBmb3IgWEZSTSBpbiB0dW5uZWwgbW9kZQ0Kd2l0aCBjcnlwdG8gb2ZmbG9hZCwgbGlrZSBi
ZWZvcmUgeW91ciBvcmlnaW5hbCAyMDIwIHBhdGNoLiBXRFlUPw0KDQpDb3NtaW4uDQo=

