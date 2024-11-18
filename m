Return-Path: <netdev+bounces-145745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE89D09A5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFC828235C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9391494DB;
	Mon, 18 Nov 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="E0Pmtgb5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580A13B5AF;
	Mon, 18 Nov 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911403; cv=fail; b=qiOTdOJIg3IpV3b97dXzVL147+SRBslFUhwwq4Biv2h2I0F4vsAgQiJdq2Fug7V3WGPY15dxCBjKchkcZxOB+eOvkALRnynqPi4w2VkniUChp1XLoImkccbATCr+RMCjZ1yPACXjfdwM0CPb5uRS6DFHGxbMmMjuGAwzNOOQVJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911403; c=relaxed/simple;
	bh=IFQLRajeJwWKTTBgX+NZNKScUMSiXNHoNz9D1AK52FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTwc9RyywDnaqskrjkw0OYXsF/AkuPBt1n4IgMjGc/lt3H3KkptL7hwPMnzLHka0AdHYJ+pOZjlnwv+G0YfZGMuOF163CWVZSmyVPWVTSBIcxEp6sJexZ7ajP1PZosiEurNDgzCWFRStNeMPzHLpr32O4W3g0GJ92Up+ECqu/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=E0Pmtgb5; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI009UM008164;
	Sun, 17 Nov 2024 22:27:16 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42xuspj7yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Nov 2024 22:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRfDcx/MrkcrVznhgG8kbor7kTD6liPRY7Vt+hlUs2EH86txcxeDGVWEy3Z7JdfybV9MhnqWYQ5jSI9UV+Ovp5ojoeTAmzaB/30lDEnF0rL/r0GM43CMoanb3f3B7LqQZ71RGeinuqIMvk3r9V0dk4u6QfTczTkRnLALn+KPZyU7DotIA08LrluQrggrxFMICpmi0jCdnq65uShuh6B8XIqoKbi7XPbemV/3Eo8j2h+4CjaojszlckO+024YOG5GnARSsYNiq+jAo7tq7edL1KJYXK2nEy0gN0k5vgSwXVAuorQhGVcEOJG882EpjQYL7Lv0k68iE361DGNTWn0Hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFQLRajeJwWKTTBgX+NZNKScUMSiXNHoNz9D1AK52FY=;
 b=lTEJ734P0c97q6xKtI2hDeZz3VtHJdZsw0fyjf/C6s0OBYgGaW6xNFHeBHtg3Wmr2jVIhpbT6LzMMce7Aa7efKqVmlStc/0SmStEax+61jV9aKXlmIkhibiKJT3m8J5LTPeQ3Om9JYX6mzzwXAlQQgoDFbv+DmiMPnvv59X0lbEQdSyCXD7fSa+E0zpHAoQk+wQTp6rHimBNjjZSB4MwAE/MuhfT3JixCNz5o3rCkyzT2ZudXvBaj7EEaorw4fpk6ASruiRV/FhTJeO/qZJ9KfFCDLR4xuzECEy2Pv4jRZm5Xu0BcRzWLnX+fB4R/Dm1dINcisNN4OYtwwSk1ubPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFQLRajeJwWKTTBgX+NZNKScUMSiXNHoNz9D1AK52FY=;
 b=E0Pmtgb5gnXvO1tYLJocDewurntXrH17ic4KEXcQj1zzEp5fCszSvaR2xJSpQXf9+HIcFODpv8L0MauO3gYlBPm/UbjYSDJ3uOgD+LnQaDxHXyTrpvHu7fbxTTMsewEzn0bFKGO9SicAzwayMfU5EnJvJeiB94HbmXx559MSOXw=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DM6PR18MB3587.namprd18.prod.outlook.com (2603:10b6:5:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 06:27:04 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:27:04 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v3 0/6] CN20K silicon with mbox support
Thread-Topic: [net-next PATCH v3 0/6] CN20K silicon with mbox support
Thread-Index: AQHbOYLiKWpi02ZdAEOXXQrWWONLXg==
Date: Mon, 18 Nov 2024 06:27:03 +0000
Message-ID:
 <BY3PR18MB4707B47B1325D147DDBAC15DA0272@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241112185326.819546-1-saikrishnag@marvell.com>
 <20241115152250.2ecec8a6@kernel.org>
In-Reply-To: <20241115152250.2ecec8a6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DM6PR18MB3587:EE_
x-ms-office365-filtering-correlation-id: fcbc289d-d044-4e24-2960-08dd079a048e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEl5ZFlYZTVUdmdTK2NhS1ZLY3FMc2k4Wkg1Y0JXTnNMNkJaeEZta1ZkUk90?=
 =?utf-8?B?MU5YSWE2cXN6aEZqakEzYkY0WjVqMzVEOGVoWFJVeEk0Qlo2Zi9tZlBOZE13?=
 =?utf-8?B?d0pkUkR2QVo0Z3ZrNjVoeC9mNTJubENzT0dqQWxweUpNci84RmQ1K2dQcGFR?=
 =?utf-8?B?YkwzNGJNa0lSbHJNTDFKY09McnZ1WnpFa1FFaS9vblBUNFkyNHB2cFJ0RllB?=
 =?utf-8?B?d0NrM05WaUhwV0haMk9jaWlWWmlJOVdiZi9SNGViTlV4VmhkU2pSa2pzNFI1?=
 =?utf-8?B?SEQzQlRtMCs4VVlPOFNzTjFIQ3diT05iQld6dmxLQk1lYkZFR2F3V3dJSmNk?=
 =?utf-8?B?ZXpoYit3OXREN1dNcTF0UFpySzNCekplV2N3Z2xBUlpGeEtGdWtrZC9tK25G?=
 =?utf-8?B?eHZQUzlvWnM5YTA5SWltM2Uzd3l6MWhpL1JqOXJmYVJPeWFHTVhZUUduV2ZY?=
 =?utf-8?B?Vy9sb0xuNTRXZytYVFJ6MzFvQjJBWERrTWgzckpEYjhEeHJ6UVVIS0Q2dXhH?=
 =?utf-8?B?OHlrdTF3L2RBMFlyeWdkZjZyN2ZIb1JXWlVpYUttRVhZWG8zTDY3OXZsa0VT?=
 =?utf-8?B?aGZhT09GaFRkUndUMGxRelJaMEh0RC9mVmZXbFZhT2pYR2R4aGd5dzdGMGRh?=
 =?utf-8?B?YW5KVG94T0Y4dzFTUHhQaUhqNmpPb1ZHUjhaN0FtOHpOQ2tHYThNaUkvVHFT?=
 =?utf-8?B?SVRGVG41emJrZnljT1psV0xwVzM5TmFkS2NYZ1VNQWFiaWxJbEJ4U1RvbkE1?=
 =?utf-8?B?OFlDalhKZU9sV1FnVzV1NjEwbGV4RFVjdDFFblc4cTIvNkJGODdqL2Q5UEhq?=
 =?utf-8?B?NFcvS05rc2NWVXA3U3h2aW5wMUdhRmN1ZU13dU1kSnJuUkdUOFBYdmIvaExZ?=
 =?utf-8?B?UWZxV3Q1VzdXM2EzL1hiQlIyVmU5V0l6RGJLd25UaGRQUFhPWEJEb1hLalIw?=
 =?utf-8?B?b0U2S29KdVFJWnp2bS84dUhSUGVZUVhwYzE5T1BvcnVFcnVRdloyaFd1djhY?=
 =?utf-8?B?dS9wWUZlVjhPejBGYzFrWkhEYUU5M1FleHZuaHFGNjhzbFdhNW1GNjFxNjJE?=
 =?utf-8?B?TEJ0Q2Q1RDVCaFpGejZEaG1qZlR5TUNoeHQySmRMeW9YZWlOUnFOVEYzNlJG?=
 =?utf-8?B?dDVYcktER2ppdkNQeTRSNzdpY2JHeGRSMS80VGkxYm5oaEU4emRqeDY5V0gw?=
 =?utf-8?B?Q3NlUmZSSFYrUktHUy96ZXJhOVg3MEZad0RGTW9mMzJwRThpSDNhaitzMFh0?=
 =?utf-8?B?T08wVnYvMkVFRU4xb01oalBBcktDK2RFQm4wV1lEQlVuSktsZStrZTZzOWUz?=
 =?utf-8?B?NzRwYlNwckpQR01DVmZTaWgydkYyTzF6ZHpmYzBUKzZrdWJwWVc5OGYzZExK?=
 =?utf-8?B?dDJKMGVBMnVuQWxUc2lQcmxMUG9jQXViUElxT2pwdlNCQ0oydWZ1OUo4VXNv?=
 =?utf-8?B?RU8rT0tocVdRNkYzMzl5QVp0VUVYcC9kakliNEt2OVA5VVdjcDZjWG1xMDJX?=
 =?utf-8?B?L1RoSWYxQnhpS0VDaUR5bldkY0NmVkNSVS9HcE5JYWRKZURTTnJiVmJhcWpj?=
 =?utf-8?B?QitneE1vbGFvV21FRnVSOUx0clRUdFg0Vm8zMGNVTzR4aVlwY2FPaUdRUVNn?=
 =?utf-8?B?VEVFVVl1cEZPOWNRVnVuendTOU9LSTdBSHhYcGtUcTgyNnpLNDBmQWJDZWxk?=
 =?utf-8?B?NVEydXh3M1RHQUw4LzBkdG9SQTRWR2xYWFRUWTZKQU05V2Jua1ZSSmQyQ25U?=
 =?utf-8?B?V3FEYXQwQ3Z0ZEJpUi8xaktKVGQ1U0JlV1pvclhKUnBhL0dzb1FSbjA5N2pB?=
 =?utf-8?Q?64D/tqg4jcvtzTw5B8Yr2nIgZ0eciQbRysDsY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU5DK0RVTS9EQ0RWMUVnWGFQVU1zbGpINDUwL216cFBFN1pHZUdlYkZVMVJD?=
 =?utf-8?B?SVIwYzhHS1ZPRWxhWjRiZ1UxNytocjZiSktYd1dRSjcyMS9ia0kvQzFqOW12?=
 =?utf-8?B?eVhIc2paNEd4STFodWM4WjEvdlBJODh1STEyeTRLREVFRkZ0aTNkS0hGMjhn?=
 =?utf-8?B?QXZlZzJ5RUthUGFtRU5YWUhTK1lDa2hmOURsME4vN21DRjczMnpWY1lYbk1V?=
 =?utf-8?B?YWtkV0RTMFpLeURIWWtiVkNkVGhhK2I5dWh2cnBwY2gvMG9mNEExYUVBTUpk?=
 =?utf-8?B?SnE1cnNKMUd4a0FQNmJ2VFBieHpTMnZrL0UzVStiT3Rjd3NOQmpnR2VrRlF3?=
 =?utf-8?B?MUdmcGV0WjIycmVzL1VoY2lxUGpYMWd3dXVUczhBVEJ4T2ZWd3JTZGtFblAr?=
 =?utf-8?B?aHhCZEZiUmQybGRSUzJDUlZubjJnZm00a0dTRWU0NmxEbG9EcWpNaXN3aUg3?=
 =?utf-8?B?VWJreUoyRnl5V2k3dVVhZ1hKcHFXQ2V6T0dSTGRqTllVY3NCa0VGZ2pBQ3Yw?=
 =?utf-8?B?SkdrQjJsT1F6ekU1bEI2VVZiZ0Z1ZDlaU1ljcC9nS0t0NWI1VkY0ZGpvaTVN?=
 =?utf-8?B?RlN0dVRabzRFTjBMQmhqUERPOUM0bjA2NUhNSGZEek9rZ0hUOWlLbUhNMXZC?=
 =?utf-8?B?QiswdUxCL1BjT3J5Q3E4czBJQ3hvYlV1cTNSNGJqRFdxTWpxWnJMSVowcG14?=
 =?utf-8?B?cWJ2dmZ5TFI3d3BMblZhaU10TzNQTXFJc081ZHhmQUdFamJjY0NRMTJkR01m?=
 =?utf-8?B?ZythZEVNMU9oc2d1QlBLWmllTkw0TU1sdlZ1eG1PV0lCZFVSeENoMDdVRUNR?=
 =?utf-8?B?TDNBbWRYTWpkNjRqaTF6SEJCR1J4UXlxK2Jid3B1R0xoc3VWQVBzNGp5d0o0?=
 =?utf-8?B?Mmc2R21XK0E3eDhUZlFPL2xpaFRvSmYrWlRrcFBEbFlkREptY2NFZlMrUkY1?=
 =?utf-8?B?QXNVZjJ1UUp4RGlqdXk3QmZUd1RPNDh6THcvekM5Z0RGVFEvUFhCY1ZZRUJT?=
 =?utf-8?B?ZGNONGhVZEpid3NQalY1MUNKVit6MGZhb1FvMjI0UGxOSFNOSUw0c3ZhMm9Y?=
 =?utf-8?B?eFVkKzhiYjUrVWEyMU1KdzZNTjk2VGVJd3dWRXgrWlMreVRIN1VQWTNLL1JF?=
 =?utf-8?B?TnhWdVdMQWhDMnI4TFRhR2JxQzF2OU9tdVZnSFR2Vm9GK2xFUjFOYVJGOFhR?=
 =?utf-8?B?dDNNZUhzNUl4OEplakNNNGxxRmNWdS9hckE0bEVybVlsNU1sM0JaeVd5Q2dI?=
 =?utf-8?B?ZUFuTGF2SWxyUXY2Qmg3MDFWYWdqNTFNOGFTdmZsNWJIeUtrV01RVG9ycDFY?=
 =?utf-8?B?aTNwMkxIa0lOQ2dpZ0FrTjRRQkdKdGx6TFFJQzVhVUt1bjZsK3hhZUdZVlAx?=
 =?utf-8?B?bnB1WlhqUmpjVGpBQjZPOUVGbUpMUFlFQjdsV2lvM29pc1B5OGM0V082RTdU?=
 =?utf-8?B?VUp4OThCNU9tczk3Q0UvQ3RiY3dxYkJQcUpOcWc5Wklzb1VJU2NQblBWMSsv?=
 =?utf-8?B?cEE5MlhiYjRRK1VRQUREUlkrbTNlZDJ5TENsd09QRFMyakNXRU1PNzIvMDJ2?=
 =?utf-8?B?ZGExeDhRNXJzSEtTZVFVaXMyRXE4UkR2OENiQnNQdnU1MU9jKzJtOExyaXlu?=
 =?utf-8?B?Wk9FdWRxU2tWK0xpQ1VHbVR3eEp3dCtZckFBYjZIa3QzbnR0NHgwakdoU2k1?=
 =?utf-8?B?S0lNT0Z2UWJSdmFPMzZBS0dDVUlhYkh5V3kxUFhXamV6TU1xRHY5b2lSaU0w?=
 =?utf-8?B?cHpkYzNjcGM0ZVVMUVdmNU9Uczlkbzd6S0l1cm9WcHliWFQwamhWdUdqWExN?=
 =?utf-8?B?b0xHTTB3bFRCemJDQXhNY29NWjZvNEU2KzVwL3JWZ3pGSkJHcDQ5Z0c0bGY2?=
 =?utf-8?B?SFlwait1RVZVNWlwaWMzZ0FsRGdWQjNjTnNXc05yZ1F3U2I1dDBTT0FEM2hk?=
 =?utf-8?B?eXJEZklsN1RkTmphclJoTXY3SnF6ZFFteVJ0NmVmUEJuVnBVelZhbDNNenQ4?=
 =?utf-8?B?V3pweGVNdEU0UUJxUEdaTm1zUURXUVdENWhMaVJhNFdZdnlJVjVBYjA2bVM2?=
 =?utf-8?B?MU5NUlF0L3phbzZmOXIvSzJQbDJNN2t0YkhUVlZyWkJ6REYzZzlOUjRUVG5a?=
 =?utf-8?Q?EKoQJKqXbajxPWhb8wevoaXjt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbc289d-d044-4e24-2960-08dd079a048e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 06:27:03.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsbViCBbyz2om7+YIqj4f0TbGYSY1/rbN2mwCiWeuveMAGtptCQJIU2rXpnxxEndd6b2Nm8F35FOlA5uyshsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3587
X-Proofpoint-GUID: iU62xIhiGifONRB3HwaD6DiPtgIVaD9Y
X-Proofpoint-ORIG-GUID: iU62xIhiGifONRB3HwaD6DiPtgIVaD9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAxNiwgMjAyNCA0OjUz
IEFNDQo+IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0K
PiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJl
ZGhhdC5jb207DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkNCj4gR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+
OyBHZWV0aGFzb3dqYW55YSBBa3VsYQ0KPiA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgTGludSBDaGVy
aWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IEplcmluIEphY29iDQo+IDxqZXJpbmpAbWFydmVs
bC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWEN
Cj4gU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IGthbGVzaC0NCj4gYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW25ldC1uZXh0IFBBVENIIHYzIDAvNl0gQ04yMEsgc2lsaWNvbiB3aXRoIG1ib3gNCj4g
c3VwcG9ydA0KPiANCj4gT24gV2VkLCAxMyBOb3YgMjAyNCAwMDrigIoyMzrigIoyMCArMDUzMCBT
YWkgS3Jpc2huYSB3cm90ZTogPiBDTjIwSyBpcyB0aGUgbmV4dA0KPiBnZW5lcmF0aW9uIHNpbGlj
b24gaW4gdGhlIE9jdGVvbiBzZXJpZXMgd2l0aCB2YXJpb3VzID4gaW1wcm92ZW1lbnRzIGFuZCBu
ZXcNCj4gZmVhdHVyZXMuIGRvZXMgbm90IGFwcGx5IGNsZWFubHkgcGxlYXNlIHJlc3BpbiAtLSBw
dy1ib3Q6IGNyIOKAjSDigI0g4oCNIOKAjSDigI0g4oCNIOKAjSDigI0g4oCNIOKAjSDigI0g4oCN
IOKAjSDigI0g4oCNIOKAjSDigI0g4oCNIOKAjSDigI0g4oCNIOKAjSDigI0NCj4gDQo+IE9uIFdl
ZCwgMTMgTm92IDIwMjQgMDA6MjM6MjAgKzA1MzAgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4gQ04y
MEsgaXMgdGhlIG5leHQgZ2VuZXJhdGlvbiBzaWxpY29uIGluIHRoZSBPY3Rlb24gc2VyaWVzIHdp
dGggdmFyaW91cw0KPiA+IGltcHJvdmVtZW50cyBhbmQgbmV3IGZlYXR1cmVzLg0KPiANCj4gZG9l
cyBub3QgYXBwbHkgY2xlYW5seSBwbGVhc2UgcmVzcGluDQoNCkFjaywgSSB3aWxsIHJlYmFzZSBh
bmQgc3VibWl0IHBhdGNoIHNldCBWNCAuDQoNClRoYW5rcywNClNhaQ0KPiAtLQ0KPiBwdy1ib3Q6
IGNyDQo=

