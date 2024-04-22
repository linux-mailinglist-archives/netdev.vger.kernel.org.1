Return-Path: <netdev+bounces-90231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76818AD351
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068401C21606
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BC153BE0;
	Mon, 22 Apr 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoUUx280"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845115218D
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807153; cv=fail; b=m8V/UHGaS8BvpBGNugubzm+d7x2U55R5fdYlWOyB2Qbmq66dBIHD8+yoCZfq7r9Rp2Nnyim9xsmctQH/r1CIzwsRSMk3GNVp8BFNsENYqgDsf731zoldmmdVmEfZoQFKDaLtsMy1R629dnbVONDopLlzvmBLYi50CmPtvSUtXxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807153; c=relaxed/simple;
	bh=pwP2GjAF2I3XuJT2O5NdryNNoBKGpNcOgSvTGT/Aho8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LdQr/mD+a7xsqBOnGtGIUWbCoxIDVTY4t4uoAmMApuubthGjFusflpv/swtNvlYC+bbBxeoV9UxUHZ+i4/7e3P3VWd0+eMhqYGh8vcC63r0Hpp/j60UXM01JM5lM0opV6eDiwF5ft9cxQp+Xo1HKX1YkSBNf4f7FNrn7m4p29E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoUUx280; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfovpVrxCAAU1YFL8ApWLcggNltW1qNvvaS7Vnu91zFJRxMIjV0wupuqJlo4e0SVsRxkgiJaUlw/hkG+eCVSFAN6EBnktoJ6Z5R5zFNoX2w6/bnN7s9Q4zsuTRjcf3nXfoKW2+5NIR6oFIdEpeWprKpv2KI9tit6X7NDv26vejSPQ+oUL/1dtzDvDlChbYyi7DT06mz9csNYFCP9VtW6cWoU/hNighuQnEw6U5TgV42NwLZxRIzmXlrvGaJMn4B4V6UvOWRnxJqe24l8P0ikzk7hGDN0M4BzusmeY9x/58rvECUiiJNZDu9Fw1o/yi+JBY75BcXreVL1DYfOTveVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwP2GjAF2I3XuJT2O5NdryNNoBKGpNcOgSvTGT/Aho8=;
 b=TjU1986H4qg9GhukmG1jL7moZFzK2lgttPNC2lpvowYfMCozEYqhKVTQpGZWVC5ol5lhM0lnxFjbtT+Tvdk0v4YjaUEkQm1d2gbPX7NUJ+DVaw3niUaW86jLfcrvzbQ273tg31EZy65muV7rTWy1uJZY++ZeXpni+OjVPEEB9oXzfi8NeOFnVPnZEixPtQt2hesNETdD+Xn1HEAq0eeLFEBw5gLaMoGgdjMcMlIAYr3vOeOcFFIDm/W38iKJPO5qFWsPwu/IQZ04QPo8nrJXip1oK6IFG+8vxhCPkMT7us49Hov0bWoeYBf4u4n0eojJYKrlFR2kAPYm3BecDvlNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwP2GjAF2I3XuJT2O5NdryNNoBKGpNcOgSvTGT/Aho8=;
 b=OoUUx2807WXqq8WqjvJsnylJGlYMaswqIxtDIO/AgnjmPJeLdrJK4L2N8lhNuGPJBZ10NNHt2gr9+uuOnDIvRYS2zt3jU2h99syQhT6txXMkzH+8x5jJuIbXR62NvQHgRxL4Q+mc+BOXa8kxc8pPMdjVXbtqqbFA6m1rSTXknpvedYOZ4q7KaHMKzaVbPToiwbbx4CVtwhxl8KwtE+glNKhwwt5c+mQaFB1dp1Ul1kNnWgB0hyIM2NpTDPKSYrWmiXjCFlfSwG+EQECfFhnDDx36SVRY5StqpbMsamFLXX8KFcBw3YFGCbNxu1s2lmQIbqb6Vayi4mU/Ns8oWBT/cA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 17:32:27 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 17:32:27 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "oxana@cloudflare.com" <oxana@cloudflare.com>
CC: Shay Drori <shayd@nvidia.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: mlx5 driver fails to detect NIC in 6.6.28
Thread-Topic: mlx5 driver fails to detect NIC in 6.6.28
Thread-Index: AQHaklekYwro6CBsoUOORjm1K8wlnbFvoNkAgAARoICABNajAIAACEoA
Date: Mon, 22 Apr 2024 17:32:27 +0000
Message-ID: <5fd52af8fda93e9142d34288bdceeef0bc0933c2.camel@nvidia.com>
References: <5226cedc180a1126ac5cdb48ee9aa9ef8b594452.camel@nvidia.com>
	 <20240422170428.32576-1-oxana@cloudflare.com>
In-Reply-To: <20240422170428.32576-1-oxana@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SJ2PR12MB8953:EE_
x-ms-office365-filtering-correlation-id: 2713025e-afc5-4f4a-2da6-08dc62f22e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFdRNHF5SHZWQWhMeG9IbjRUTzZzSENXRDZRdEgyaXhlRkRLaWdoZUtnNk0r?=
 =?utf-8?B?ODFLTUU0RU1SRlByU3VtcFBQcm83Tm1pU2VzSzJhdmcvRVNWeGx4WWNiTlBU?=
 =?utf-8?B?SkdlbDErZnp0U1NtMERqVWV0M3dHb0dQK3FmUHhkdGppL1JhbndBR3kzZS9U?=
 =?utf-8?B?TkcvbXdhVlFRcGtzS1I0VkN0Q2FYVUlUcElQYTVjanNvV3hSbXBGVDhzTTVK?=
 =?utf-8?B?ZDJIRzJGOW9IY0ZVN2lqRmtJcmp6UlRuTUJETjkyRTZRY2VuNzVjdUZWcGx3?=
 =?utf-8?B?Unl5VDNLa200T3NIWEkwRWRNcG9ibUhRVzFtbVJrRkFOVXhGMVZLMWNQdVIr?=
 =?utf-8?B?UTRmd0J0U3VleTZxUU1QazBsbzBLcUtiWngvTTBPVzFTaEhtSmpuM2tDYzhs?=
 =?utf-8?B?ZllQSHBxekliOUdxYmhjOExoY2J2emROeVNpS2dYU1NMS2VBNkFiclRsZmgr?=
 =?utf-8?B?MFhPVGwwQmtOc2R6Z0g2MXVDek9BSmE5TitDVHg1OHdnUnY5ZUpuRmRYVEhT?=
 =?utf-8?B?SkFMa0l4N1BUSk8rOXFzYS9nbFl5dVFJdDQybWczclNiem9XV0RiR25WR2Rt?=
 =?utf-8?B?a3hNdDFqVy90c2ZGY0k3SyticVVLeS9jbjZ3eWxEZEliWDQxWEhiRlNOTHpu?=
 =?utf-8?B?S0I4YWxENzIydEZYVmQ2RHRaK1lUcGowOEswTWxNeFFKWkNVN1RObjN3MWlr?=
 =?utf-8?B?Q1ZiYjR0UUl4UEpDYmVHOFozZ3IrMjBvYnFVb2xjWXcyT0VZN2tsSXQ1TStp?=
 =?utf-8?B?NGEzMjh3YXFYdlNrVEUrVDZjYUF2UlU1TWkvTHUzNGVmZUJRVVpuZS9JbzBt?=
 =?utf-8?B?aDhvNGgxd3JBVE1WSjNhczZFbG5jeFk0QlN3Y2J5T1BWdStXMjR1bDZvRHRs?=
 =?utf-8?B?RkI1d3FOOE5EY0xrOU52TXlSMWtKbzVJNVlVeGt1eFF3aG1vMURVZ0t6VHU5?=
 =?utf-8?B?ZksvRXZWT0Y5VGVuc1VHY0FMM2dybXIwVmdjZFB6ZFpmRzFuZVVjUmV4U05F?=
 =?utf-8?B?NllFNndzKzFVMFdwUXUvQlFmV0ZHTWU0RWFxRzM0dXMvQlQ1VHd3VmJPTjF4?=
 =?utf-8?B?WlNuMGtrR2ZqVEZUak9QeWc4d0Rwd2VsZzRBL2pBVk1xOGJhbzllUmdWd1li?=
 =?utf-8?B?ODlwR2RicmJlbXIwRVI2QU1vVDJvRVlHUDVRMmIzMDRRSjN2ZFYzb2RsK202?=
 =?utf-8?B?Sll5cHB1WENGWldXTWUwR2x3MFEwZmR1aGxuMHdkaXloM1cwNENIUmk3L0JK?=
 =?utf-8?B?aUpnY1UyRzY1ckF0OUgxUUwwQXU0dlMzYVg0Zm84MkRYVUxmZVJDNzNjcHFG?=
 =?utf-8?B?MHlSbDJISUdZSTN3N0VZZGFmTitRcEVySUVrNE1uZHdPT1ErY0tGRkt3ZHdL?=
 =?utf-8?B?cVpXTGdyMlJyNk95UTdVbkxuN2ZSZG1sR2QwTDJsaFlpMGFOVWpBdEpzRTJa?=
 =?utf-8?B?NzUzenVxNFNBQVpialVVb094Y3BxWjVWN1dIZ1R3Qk8wOVNHSlNWbTVIRGRI?=
 =?utf-8?B?MFNkVGl0U1ZycFJlengzcklMSGRxb2VXQmJVWTdDUlJiVy9ReEJ2M2tGSTRy?=
 =?utf-8?B?SXVQcXQ2RHJOd2VUaVpOSXJSa1c4NlNSekNWV0h0OHV0MDRDM053T09kTmJZ?=
 =?utf-8?B?SGJEL3ZYdGZGdWFjTzcrVUhWQlFQUTlxQzdjNkJuSlhNeEVWb3ZPT3dPUnU2?=
 =?utf-8?B?MEdta1YrcTd5NVF1aGZydjVsaXViOGx3bEZ0Ri94RTYrUVdRM3NrU3lLTzRP?=
 =?utf-8?B?MzB0N2lRRno0elJFUDNrQ2tNSUxYcmhzcjFrQWJKUXhrL2pyWjluTDVtQVFt?=
 =?utf-8?B?d2N5SW9LeElYUFp0K21wUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejZZajhuOGlSMHBReGR4a0FQQzhTTk53cHY5aUVQTmxnYmxySVl5bE9XNmkr?=
 =?utf-8?B?SmdZVW5oY3dTUUc2em5paE1SelkyMjl2QS9PU1JDSyt4b0ZFeTYyRGdQbHhT?=
 =?utf-8?B?S0syZVNyRW9GQWZBbVJOT1BXS3NLajVHTGF6YUNVd2NyY010VG1vSVkxRHNR?=
 =?utf-8?B?ZUNyUzNLT3Z0VFdIS2ZkM01BOGxwOUV0K2o3ZDlocGQreXZaaURWdDBrc1Q1?=
 =?utf-8?B?U2g4b1h0RHkwaktoTng2VEF5dUZ4c3JEWlpLMG54MVdQdFcycDNLQnRMeTZ1?=
 =?utf-8?B?VHdpZjBFT3JWV2FZN0tPYlhrTkxSclRCMi9vdUtQK1d3ZWJKY09RaWNZT1lk?=
 =?utf-8?B?ekNvZnJoQ0ZWcXVobmFXVDJ5cEFEcWMrUnhqT2pGUHhidDJiaXBoeFJjRTZ2?=
 =?utf-8?B?S1RIc1hTbEhwTXpJcjFwblFPR2lweWNiYWhJVDA0R2N5YlhidFl2bDlUKzls?=
 =?utf-8?B?ZDNyT0R4YjZ0VDBSYVpEa2Nsc3dybjBlQlBnR3ZpTEhWSGlhcFdEMTdZTXhQ?=
 =?utf-8?B?RnVsZHFGeGlaTUozdnZGK3Jwak5FQVV1MVdrUDJPOXBvREh5SEo0V3YrYnBU?=
 =?utf-8?B?VEFDUkM5cHYyeXdNOGl1emszdWM1SUdtd2dLMko1YzIrOTZkOWpvd0xlNTJE?=
 =?utf-8?B?ZU5ldE84ZU5sMHRUTkJCWi9ZWEtONk9uaUV1OVdUMVEzMXkvWkFCaGJKWUhv?=
 =?utf-8?B?TkpOSkxlZXBZUjBkekFDb3ZMSXlPMEFqY2xHVk1OZjVoT1RjVVovTTFseDJ6?=
 =?utf-8?B?VlAyaWhGM0s0SlFwdEQ3NDUyYVZiMnptYVIvbm1NWWNzWWY2dVFrZngzbVE5?=
 =?utf-8?B?bW5qWjU5ZFhwMWw1NFdqSDNjaXFaNVZ5azZBUmRPcVpiYkFrakROS1hQUkpC?=
 =?utf-8?B?V3grZ1pNUndXQ1RwR2Y2QjllYkI0OUFSdFNoZ1JlOEdyOTh4YVZmb1Mvd3hG?=
 =?utf-8?B?WFlUclZvMjc5TjJmdzNWMWdVVjlxWEVZZkFRYjZDMWpMaFkvUEc3UXFxOWFN?=
 =?utf-8?B?bEVMTXdLWFRNUFRMYW1QVU9zMVlCd0gzZkFwaFI5RWhod1FZSXR2RVk2OWQ1?=
 =?utf-8?B?cG0rZWg4TElhWlRRSmpaTk9JUklxcFRDQ3F1aCs3LzczNnZodUtoUTNWU3B6?=
 =?utf-8?B?UktOMFkwdGJIS2c2MDVjMXkxbGE3K2Q1eTVtaWllMjhQU2xQVFJpSVhXc2pp?=
 =?utf-8?B?RzV0TUQzT3Nvc1ZBWHk3K003OThaSmNCSmpnQXJMVGJDbWdBbzJDZEJSUVMw?=
 =?utf-8?B?U3hRdUM0WFZaQlN3bGFJMzhSNEMreDR4THViYmYrU1VZRStnby9oU1JiUW5q?=
 =?utf-8?B?Wm41SWFKMEhUeGw5ZHJoRnh0ak5BaEJKN1lLbFVTaEt2Uk5OUnRlSW82aDZK?=
 =?utf-8?B?YXdYdFNMVEpNczR0ZGUvK0VBMERVWGVjTFJGb1AwNEFiSTRWSnAyVjZoSXZU?=
 =?utf-8?B?aVhyS1UyRi9CRFp0ZjhtUXlHeC9EeWxVM0pCSU5LZFVyUmd4WXVTTmE3VWl6?=
 =?utf-8?B?aWQ1RU9RcWFLcTBDQ2NtcTZNR0gvMmRrUHY2NXl0Y2RGM1dOSHhoeW5VZGI1?=
 =?utf-8?B?dWR5V0pwa2tBRW04NStSRlhVcG9JZ2xxYU1WRmozVWVhRisrMWpEc2V4QjFZ?=
 =?utf-8?B?Q25TUERoVDNIdjVYa3ZYcmllV3p4UER1RGswUW1rZVhoTm9pcnFkcHVpV29h?=
 =?utf-8?B?a2hHTmwxUnJUQzFHZ2lyZElTYXd2VEVzVmhIOHplcS90VmphSjRXTlNPUzdP?=
 =?utf-8?B?akowQlF4bHVtWFcwajhvemh5ak00YXN0bVhZWGtWa3Y4Unk3a0tMVXdmMXJz?=
 =?utf-8?B?TFhHQU9CSmlUQWNDOVdIbWhsSVJFQy9oY3JKb2F6SEYxL3U2am5rekg4Ty9N?=
 =?utf-8?B?REdneEJITUJTdmIxNTFobTZsemN0WXEraXNlZk1tb1dIckNJN0czNk1aUjdE?=
 =?utf-8?B?dFE2aGlQdTRQM0FMR1B4Tkx3bDQ2U21xS2ZRL0YzVkFUTzU5M3dUOVpobGIv?=
 =?utf-8?B?R29rTWs5STBkc2ZuSHRnMXZqc21DdjJXZERlbXNBRDI2eTEyYmM1c1ZnMjhX?=
 =?utf-8?B?UXhjeGtncGp2VzNGQWlkVWpSelVsUTVQTHk4QWFWemo2R1J2WWN3ZnhiVEw3?=
 =?utf-8?B?Q0FSS1hsSEU5dU9uN1h6ZXZMdHVEOVI3OVA1c2dDTHJZQ2RlTmhXcTc2UHNv?=
 =?utf-8?Q?rs0OiWsk8RCsV18sUrR0P02HyAeokQQVwFH8TbsjmRUj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C9C6E980539A428DCBDF1C705BF871@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2713025e-afc5-4f4a-2da6-08dc62f22e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 17:32:27.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POqPT96dJZ1U6BLDotaTIGtNJHa7bbz9RjCLuGyTMsNWeWft/vutjr+qXVrcOA7gBK8OLMpbcxBYvpHsHUOqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDE4OjAyICswMTAwLCBPeGFuYSBLaGFyaXRvbm92YSB3cm90
ZToNCj4gT24gRnJpLCBBcHIgMTksIDIwMjQgYXQgNToyOOKAr1BNIE94YW5hIEtoYXJpdG9ub3Zh
IDxveGFuYUBjbG91ZGZsYXJlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCAyMDI0LTA0
LTE5IGF0IDE0OjA2ICswMDAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToNCj4gPiA+IFdhcyB0aXBw
ZWQgYnkgU2hheSB0aGF0IHRoZSBtaXNzaW5nIGNvbW1pdCBmcm9tIHN0YWJsZSBpcyAwNTUzZTc1
M2VhOWUNCj4gPiA+ICJuZXQvbWx4NTogRS1zd2l0Y2gsIHN0b3JlIGVzd2l0Y2ggcG9pbnRlciBi
ZWZvcmUgcmVnaXN0ZXJpbmcgZGV2bGlua19wYXJhbSIuDQo+ID4gPiBUZXN0ZWQgb24gbXkgc2lk
ZSBhbmQgaXQgd29ya3MuDQo+ID4gPiANCj4gPiA+IE94YW5hLCB3b3VsZCBpdCBiZSBhIHRhbGwg
YXNrIHRvIGdldCB0aGlzIHBhdGNoIHRlc3RlZCBvbiB5b3VyIGVuZCBhcyB3ZWxsDQo+ID4gPiBi
ZWZvcmUgd2UgYXNrIGZvciBpbmNsdXNpb24gaW4gNi42Lnggc3RhYmxlPw0KPiA+ID4gDQo+ID4g
DQo+ID4gVGhhbmtzIGZvciBiaXNlY3RpbmcgYW5kIGZpbmRpbmcgdGhlIGZpeCENCj4gPiANCj4g
PiBJJ2xsIGdpdmUgaXQgYSB0cnkuIEknbGwgZ2V0IGJhY2sgdG8geW91LCBidXQgcHJvYmFibHkg
YWxyZWFkeSBvbiBNb25kYXksIGVuZCBvZiANCj4gPiB0aGUgZGF5IHRvZGF5LiAgDQo+ID4gDQo+
IA0KPiBIaSBEcmFnb3MsDQo+IA0KPiBKdXN0IGNoZWNrZWQgdGhlIHBhdGNoIC0gZXZlcnl0aGlu
ZyB3b3Jrcy4NCj4gVGhhbmtzIGFnYWluIGZvciBjaGFtaW5nIGluIGFuZCBoZWxwaW5nIGhlcmUh
ICANClRoYW5rcyBmb3IgdGhlIHF1aWNrIHRlc3QuIEFuZCB0aGFuayB5b3UgU2hheSBmb3IgeW91
ciB0aXAuDQoNClNlbnQgdGhlIG1haWwgdG8gc3RhYmxlLg0KDQoNClRoYW5rcywNCkRyYWdvcw0K

