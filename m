Return-Path: <netdev+bounces-141384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929119BAA87
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE60283D47
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977B18CC00;
	Mon,  4 Nov 2024 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8rSanAu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47C18C92B;
	Mon,  4 Nov 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684736; cv=fail; b=s1/FnRUJ1/PzublUjl05wQuKqJ4WfzxlQHAzxgawvQeAIV5QwAd6pD0JFFCYz0yS/gvmftFKeh/KptULBrNEfC1sIWI9vEP+I7W1d/WDplGbhByGOao6Q5I3gYAi4me+7WaH+XXnv2Uq02bRQHMC+FGT/J+c8QPKTRyvGZei9tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684736; c=relaxed/simple;
	bh=OMA3xoLPr5FMVv4HxANX1+LYuxtfYcwQa6Uo2hrMcCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NIhODTRmYhHnmjfPzv7NsJnDJ3I0n39+B5oyiuZVDfgH5dxtuWoWZqbbtLHloVgZqQJjuhxynRlPtUfb48p22rYGuJ3r/VvKwsH8c/4gyr85aqoQ0NJcEAWRZ02gQTIrNXfC5GM9NNTnUNrdWlkGWUq0kwaErUGJvYfZ5IVbDSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K8rSanAu; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvntjXqKRUm3+guSfKnIApEfyxomz8+d8V9BOa6TaALSQsAyGj/8B6cL8YTw9Zz4iEpIBL6ZsVbfx9SDh6h0Ii/qFcMy1tbg+jp+YYKYJf8Bf31mp6TPUJHDVjgkXi5PBgD+gxbtM0rd+9kVvbgMZ46Pq4YRRbYYQsvqCQuEpxnzKgUDWmfq/ptUr7dZBCN0BwJ7bqXwWg7Odz6X3js7CClqlo6Cc1d1zWXNIIquLIbBKlV0AlE+JxkpvGxWpD2WHRshhRlI7ir0QUaJgPAeXZHcG/8F5hHjHksA50viWFKMEoGGEtJQh/tzakfFz2JkyOtkOzTEuUSHOZUPnsaecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMA3xoLPr5FMVv4HxANX1+LYuxtfYcwQa6Uo2hrMcCo=;
 b=ZpRZSibXShLLjAcZ9yiIQV+gS3bUIvOuZYAXW9B8BNc8QtuyfHt5RfC2LgfEKhfrqHQFBV5UDi/zOsciGLAQ/32JmdLar0G2cCKzEmUfuVQ9ulxzL/OeIJEyzg9FVfA/cJBO1Vkd3rk3caqq5Un7lXdO0MLfIvbFIHeZ7IRGhH4+V5wxacLtHLv5vkddv97UwWtyXdso6VdbFa0PUJKkwephqFefpX0Daa9yQtI6R2d083AiAdx05EB0BRCvdUDUFk9uIh7ugq/8zIzgmk03xRguLXyqFgufwLK+CT0KggxeZLaPBdmqdEdeYjCHKXg12cy2KpgX4WxqXwt6mRTOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMA3xoLPr5FMVv4HxANX1+LYuxtfYcwQa6Uo2hrMcCo=;
 b=K8rSanAuw/1rLBYzOYZQQAB3C28wt9ZjuXEafHHr8XeQjyV2w5qki+3BHdHyadI3smm543YON3FpOz8DX6Yv2lBnf5b7OT+Ai+Zokf0q1Wv76J7XNcuhgkhDMzs7uCUHUXZAjoFmaB/njZNO9ujw5mFVn4sR6CIT/GU4HekO9uIZxKHPmDe2F5WaTpaZPPDdin32LTxVzVf7wRVt9Q2IiKiRO5sp9gdi+uxoJbSKS+F3GMgRcFIG7MHFUCWnJNC4IUqzPcthDz1z1APfuPxTvPL2NSpUUoRTTUBpCXGl60ltO5kiCvHGE47YhZU/DS7gt8EboGRFkyGjBHPCm/wtMg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9891.eurprd04.prod.outlook.com (2603:10a6:10:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 01:45:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 01:45:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Topic: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Index:
 AQHbKqbVP6taxDbDNEuEvy4Pi75TqLKfZ+OAgACrTbCAACUYsIACHEKAgAAjmYCAA+WxgA==
Date: Mon, 4 Nov 2024 01:45:29 +0000
Message-ID:
 <PAXPR04MB8510000CA1367272180F602488512@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
 <20241030151547.5t5f55hxwd33qysw@skbuf>
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85104B9FCD3D74743E9B261488552@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241101115519.2a6ce6daqrzmhcfh@skbuf>
 <20241101140243.rloj4gg5hwrloilb@skbuf>
In-Reply-To: <20241101140243.rloj4gg5hwrloilb@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9891:EE_
x-ms-office365-filtering-correlation-id: 5cb6241c-318a-4f95-b96a-08dcfc725cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RUk1eml5YWJVTTNldVJQWUdFV1doK3dmRXVBKzREMVZ1emF4ZzhpT3NCYzg5?=
 =?gb2312?B?TVcrSy83UVp4NEhtMlFsWFpsNGpVbDlYZWU1QmV2b1BMNTY3bGE4Q3RINmdX?=
 =?gb2312?B?aU5UZXl1bjR4MEhBbmtqaXdMdkNSS24yVHBZTlA2bFlpMGdENStBeHo0Tk5W?=
 =?gb2312?B?OUVHblZjaFlkT0RNNDlIWllybWhSSDE3K3FjU1hTOTM0WDBLeVg1K2JRUWp5?=
 =?gb2312?B?QndkVnRQOFBSeTVINzZKUUNMYjFCQ2tkUVBrN250ZENGR0U4eGhMR25qRlY3?=
 =?gb2312?B?MExHQldMS2R2blQ1OEt6SzdpWXVmN0VxWWhDQTZGMlplVUthS3paUkJaS05D?=
 =?gb2312?B?cGpFYUgrUTY3b29RelM4dThwOWVzK0taS25ndWpZU0FoREc2ZFJneVdJMEcr?=
 =?gb2312?B?K1dPZEFDWmZPNElSa2JaaXNBREF4UXJWbStMYmpERFpFbUpvSkM0KzBqTGdP?=
 =?gb2312?B?YmR4Y1dJVWhtY0V0ek9pMmY3b0s2VEhCSEtRWUg0V2x5aFNsN1ZuSTJoanB2?=
 =?gb2312?B?dFdWUGtOSDVwcDd1UXdjZjYwUlVHQXorNU5IbzNvOUoyM29RN2tTbERhNG80?=
 =?gb2312?B?UTRvMWpsUE1DajhISjhZZ2dPYTh5NXR0ZjVtV3Q0T3h2YmpEeENGWk1XS0Zi?=
 =?gb2312?B?NnI5d0dwNUw2b21HdmJmcTdpRFFaS2E3M0FZcnZkMWJSelIva2xRTStwUjVQ?=
 =?gb2312?B?TTh4eGNVWVpXWnNRdHNSUXI4VmVob1RrOThXaGFoZGlaa0I2VnVKZW1uNlQx?=
 =?gb2312?B?RGN6MW5aa3dCYTNWdk5NVmJjUzRlVENacTJhb1BDcVlXbXBwN01pU0VKK2VG?=
 =?gb2312?B?UjJPdXdmcktSQVZaTENtM3l1b2lRS0R3NzRhZURCQ2dqSVpydGhjNDh6QnZ3?=
 =?gb2312?B?QTZEdEJnMjdPUmFVMDEveWxqZHZTc2Zyd0cyUjhiSi9zYk1lWlJER2FTbHJu?=
 =?gb2312?B?OWFtemg2bFRVS01HcnlXS0ZpaXVySmxxRXN2OU9NOE9XN3pVVm02MVk4VEFk?=
 =?gb2312?B?MG93djBuSFpVL3BOdlhmNy9vVFBEWCt1cFVSN0RxL09FQ0pQWklqaFkwMC9q?=
 =?gb2312?B?U3hUR0RxRW5ySXVKWW4wS3N6aWYwOWVMek9aRFF5S1M3Vm5uQUlQc2ZLUmxu?=
 =?gb2312?B?WTJ3YndwcVVrUVpOZHZNNHBqWEFhNFVIT2RMVjJ0OFhTcEtCcDVCZVNRaU9k?=
 =?gb2312?B?NDVxV01SbG1mcjBtN2RqZnFjWEtlOEoydGlZREQ2bkJDTG9SV280NENhYXBG?=
 =?gb2312?B?YzhwZ2dBRkJCa1dkL0F0TDVxbFgyVGRlcHpONllEZFdZbWlNMjhUV05YMTRW?=
 =?gb2312?B?RGR3VHdVckVyNnN4bXZaZTEyeDZNK2tpZ3FDWVJqbkdWM25tYnEySStFdUxa?=
 =?gb2312?B?OW5MNUdLK2V4Nk45eFNVcjdVOUNMc1RKTUZsVTU4Y3AwMmUxMzQ0NVFQVXpX?=
 =?gb2312?B?T0tDcm1uQ0gzRVJZWGE3QkFYQUNKRnB5TFMwaGkxRERKZDJSYmZBcTk1cjZa?=
 =?gb2312?B?bHdSRGxYbFA1SHg2RkxSVkRtclEzQzhXdVI4bHFWb2JyaHhBSXRBakkrSFpW?=
 =?gb2312?B?VG5TSnJuM3NFQ1pqVnJOMW1iZDc2SmxZeEY1cGtOMmVvMUxHdzFVL0NjOWpI?=
 =?gb2312?B?L0twY3BxOGx4c2pFUXY2eTlTQXJTSnZrU0MwVlI2V2V1VThKVHUwa2dSNWNq?=
 =?gb2312?B?ZEVUTzk0SlA5ODltcHNxbVdOcklScmk1bWtLR3ZxRGJZVkhZaUZmM0I0RTBR?=
 =?gb2312?B?ZGZZRnVyTDFIOHB4anpNL1hkQWphWFF5TXZ1bGJ4VDRzc0p4QnQrK1EwZ1Jj?=
 =?gb2312?Q?rfYCbvek4Ifha1RnyLTJ79kvks4Ork+NEqlmI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aEJJamlmVEpwVTB4ditXc0dLMUV4RFAveFJHRE9FZEV6K01xZlRaaVhhMGJ5?=
 =?gb2312?B?SUJlMWFTTTFsZDV1TGo5bVhURDZ5T01OcXhFclhWR0o4bFVidDNDY0p6R3p2?=
 =?gb2312?B?Vm85WTJVMlFjWkhucDM2VFRVZ1dncmpqckpIMXFZV2Z5ZnJ3clFjRndDZFlT?=
 =?gb2312?B?aUZoL1NUQnF4L0FiOHhVWHhZekEyZlFjWHpHWWFOL0lpeWZRVlRpVWQvbzdB?=
 =?gb2312?B?cGt5LzlQU043Ri9HTVkvZzN6SjNVcmtOUDFUd0JhVG8rZVgwZ2UrTkFYY2RT?=
 =?gb2312?B?Z3JlblFIc0FGRHBRU3FtNUEyYU5CalhhazRnQUhJdUpGMmUrNG1NRWdYR0lx?=
 =?gb2312?B?RG9iTzVsNFlIdENpRDd0MzJRbHpKMkZlRE82dFgzSnRQMllnUWx0KzhlTEh6?=
 =?gb2312?B?ajF3TnNtYzVKUGxOOU50K3BTR3NlWjhxcktPZStBQmtOWGQ4Z3BVL3RxTTRM?=
 =?gb2312?B?S2tjOEhhYkE0djVDZ0pwNkdmOFc3V3FlWWJ6emdGT0ROcWJhSmRUQmJ0Ylh1?=
 =?gb2312?B?ZXczei9lK0ZST2FwZGRsSVV5LzZXN04yTnNhZ3d0S1hMVC9JaEZLZDZVUjlS?=
 =?gb2312?B?NFVxb255L055T2JWbVJnbjlNZTZsckwvOUdQdmd3K2ljWlNSeWdDaXI2bzRC?=
 =?gb2312?B?K25Yai96K3llcFpzSVhNN09aeFBsYWsrZ2lZUUhLV1lXZ3p3WGYrTjlvMlFi?=
 =?gb2312?B?WmRxMEV5SEY2UnEvakR2aEYrenZJNm9jaWttc2lNeFJrMGE5YmEyUHFFUVNx?=
 =?gb2312?B?UEw2U3kyakVxdEFSNnAycS9uNGFhNE51S2xUdytXbW9vSlZwaDVWWGlnYjNn?=
 =?gb2312?B?cFp1dkFURkxUbENIczBLdUFEWURwYjRtQ0QwWjlvMTVITmZrMitJRURpZE40?=
 =?gb2312?B?UjJ2aUJWeTg3aGxaVUNHdEdLRlFqWko4M0hEOGN4aTdOcUhoS2pRSWY3YWZ4?=
 =?gb2312?B?TUdnNDgxdjBxaUhvbjkrKy80VEgyZVdkNFAreHpYSW5QbXhIVjlDWjJKYVRZ?=
 =?gb2312?B?K2ZjSXE2MFNOMWF4cHFRQjRHL2xsdXNVNXBtbWYyMi9jRUtUTUhKVEd5U0dk?=
 =?gb2312?B?WWxldzBVYkRBbjR4RXFUdGRid2dyV1RoZFEwQXVKdngvcllFSTdiWDArbVE3?=
 =?gb2312?B?Z1ZmZnh4VVgyeHpFbGFack5DWEhSMWFEaDF0N2tTQkZvMks4aGU2MXp1dC9r?=
 =?gb2312?B?NTR1R1ZCaThmNS9ZazdQOHZ3c2VrVnQ1cVBybjlmbENBZ09jNWJOZ3JWVGhi?=
 =?gb2312?B?bGxZb1RxU2hxUFNOR3hLbVRIRTVCZk1iUWcwOEpuNTR3WG9pSkdQcWM0bmZi?=
 =?gb2312?B?em1mTUVISy9OQ0NZOXBHRzFEclJOTUd4UHU3QU92Mmcwd1VWQzZVLzBUVnVt?=
 =?gb2312?B?a3lsUDhmTDFkQnBuY3FHRXBETWlyU2M0SFZMejZqMEM1dHkrVnFYYWZucWxR?=
 =?gb2312?B?WlBWNHYxTlZteXdNd244QkVHRGx5cVVUcXlEU0xSMitHUHdLRzc0a0JhVzNF?=
 =?gb2312?B?dlJ5THp0d0U1WmFDU0xKV0tHSnBYYmRPb3djemVZMlR2ODFYTmw5TFFMV0V6?=
 =?gb2312?B?ZDdjcU9LdG45ZmdOM3pnSnc4NDFLMlI0VG5OR1B3OXZlUzVwTmgremc2UzVh?=
 =?gb2312?B?TDl4WnNvRkFDV1lPL1NOMmtnNHdBZXBJWG5DWGY3Q2ZvRFFtcmpEb0dmTHo5?=
 =?gb2312?B?WGFFdzdpOEIwelh2S2YvcGw3L2w5R3lJckV6TXdZSFFEamxSWWRwZlJNM2hm?=
 =?gb2312?B?bStVclFTQ1lkWkJBOUhQU21CUFpoOXh3aXBnbTlkeW5yNWs3ZGR5MUhaVnZT?=
 =?gb2312?B?bTF6bldrdUplZVM0a21WQmFQTTBWTFVrVHNFaE1JMk1Sbm9ZSmh4bVR2S2s1?=
 =?gb2312?B?anF6KzE0T09HbkdwNEpOZ3MwWUZHdTkvd01Ca1FORWUwTEJnR1JIQ05aZEFm?=
 =?gb2312?B?bit5NFliVXBjT3N5OUtLcmN6bng0V2R5bzR3UWVjME10Vzk3WlBTOFZiUWc5?=
 =?gb2312?B?OVVsWVV6djdRQXRjMnlJQytMRlQ5c2hydU5oMmJFSWhxUDhPNW9DbjdwNisv?=
 =?gb2312?B?cWU5b3hHV2c0RDdrU3psSTZJcmV3aEJkQ29WVkFxQzRBVUtPM2xZaC9ZTEdq?=
 =?gb2312?Q?CxB0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb6241c-318a-4f95-b96a-08dcfc725cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 01:45:29.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGWZ4GMkMIxZXSq5l8WDf5l4HqVOMFKWcDkWo+uF0ejQUI4qwr814o430StPKMY6Us/dIb/nDEHa5S01XLZPuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9891

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMdTCMcjVIDIyOjAzDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgQ2xhdWRpdSBNYW5vaWwNCj4gPGNsYXVkaXUubWFu
b2lsQG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
bmV0XSBuZXQ6IGVuZXRjOiBwcmV2ZW50IFZGIGZyb20gY29uZmlndXJpbmcgcHJlZW1wdGlhYmxl
DQo+IFRDcw0KPiANCj4gT24gRnJpLCBOb3YgMDEsIDIwMjQgYXQgMDE6NTU6MTlQTSArMDIwMCwg
VmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiA+IE9uIFRodSwgT2N0IDMxLCAyMDI0IGF0IDA1OjQ2
OjQ3QU0gKzAyMDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiA+IEFjdHVhbGx5IHBsZWFzZSBk
byB0aGlzIGluc3RlYWQ6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAJaWYgKCEoc2ktPmh3X2ZlYXR1
cmVzICYgRU5FVENfU0lfRl9RQlUpKQ0KPiA+ID4gPiA+DQo+ID4gPg0KPiA+ID4gQWN0dWFsbHks
IFZGcyBvZiBlbm8wIGhhdmUgRU5FVENfU0lfRl9RQlUgYml0IHNldC4gU28gd2Ugc2hvdWxkIHVz
ZSB0aGUNCj4gPiA+IGZvbGxvd2luZyBjaGVjayBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+IGlmICgh
ZW5ldGNfc2lfaXNfcGYoc2kpIHx8ICEoc2ktPmh3X2ZlYXR1cmVzICYgRU5FVENfU0lfRl9RQlUp
KQ0KPiA+ID4NCj4gPiA+IE9yIHdlIG9ubHkgc2V0IEVORVRDX1NJX0ZfUUJVIGJpdCBmb3IgUEYg
aW4gZW5ldGNfZ2V0X3NpX2NhcHMoKSBpZiB0aGUgUEYNCj4gPiA+IHN1cHBvcnRzIDgwMi4xIFFi
dS4NCj4gPg0KPiA+IFRoaXMgb25lIGlzIHdlaXJkLiBJIGRvbid0IGtub3cgd2h5IHRoZSBFTkVU
QyB3b3VsZCBwdXNoIGEgY2FwYWJpbGl0eSBpbg0KPiA+IHRoZSBTSSBwb3J0IGNhcGFiaWxpdHkg
cmVnaXN0ZXIgMCBmb3IgdGhlIFZTSSwgaWYgdGhlIFZTSSBkb2Vzbid0IGhhdmUNCj4gPiBhY2Nl
c3MgdG8gdGhlIHBvcnQgcmVnaXN0ZXJzIGluIHRoZSBmaXJzdCBwbGFjZS4gTGV0IG1lIGFzayBp
bnRlcm5hbGx5LA0KPiA+IHNvIHdlIGNvdWxkIGZpZ3VyZSBvdXQgd2hhdCdzIHRoZSBiZXN0IHRo
aW5nIHRvIGRvLg0KPiANCj4gTGV0J3MgbWFzayB0aGUgRU5FVENfU0lfRl9RQlUgZmVhdHVyZSBm
b3IgVlNJcyBpbiBlbmV0Y19nZXRfc2lfY2FwcygpLg0KPiBUaG91Z2ggd2Ugc2hvdWxkIGRvIHRo
ZSBzYW1lIHdpdGggRU5FVENfU0lQQ0FQUjBfUUJWIGFuZA0KPiBFTkVUQ19TSVBDQVBSMF9QU0ZQ
Lg0KDQpZZXMsIEkgYWdyZWUgd2l0aCB5b3UsIGZvciBRQlYgYW5kIFBTRlAsIEkgdGhpbmsgd2Un
ZCBiZXR0ZXIgdG8gdXNlIGEgc2VwYXJhdGUNCnBhdGNoIHRvIGNsZWFyIHRoZXNlIHR3byBiaXRz
IGZvciBWRnMsIGFuZCB0aGUgdGFyZ2V0IG9mIHRoZSBwYXRjaCB3aWxsIGJlIG5ldC1uZXh0DQp0
cmVlLCBiZWNhdXNlIHRoZSByZWxhdGVkIGludGVyZmFjZXMgb2YgdGhlc2UgdHdvIGZlYXR1cmVz
IGFyZSBub3QgYWNjZXNzZWQgYnkNClZGcywgc28gdGhlcmUgYXJlIG5vIG5vdGFibGUgYW5kIHZp
c2libGUgaXNzdWVzIGF0IHByZXNlbnQuDQo=

