Return-Path: <netdev+bounces-109257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB80927977
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B504288C00
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C01B0117;
	Thu,  4 Jul 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GAy6BBSv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9A1B010F;
	Thu,  4 Jul 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105432; cv=fail; b=ReBvujYh6/bXEdRboPesLjQchfJSx2cv9E8EPIzTI8oqLV3OsJF2nfRPj3SdiwD1x2eMkDGVemJ8/dpMFinLZL6NBHj0iQuRzKXhGtZ5yCqetd8tCLX8tCr+KbuAf5IWOIiNaPVwbDlgQwzdn8XcrLX/IoYoXjDBu7v24zDu4i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105432; c=relaxed/simple;
	bh=mQWroSb7kMnehyNzCCHX6s2dTYjFnSgTfg/7QjZ2uJY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u3G5vIvsspLmGXX5py5Q+f+nQB40phw5bI8TLP3kmHNYc4jAy77fimObvKR+lFmEF1chED2KGH5+6u+LKwRSNiO1o1s4ahYQ2/h+IIMBhsPJ3mqsTihqg8+/DreA8dtxjJu4oJ+vHnDlcMecTrebi7kKWtx4FoiYprt73LZCTcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GAy6BBSv; arc=fail smtp.client-ip=40.107.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVKPVGgWQFlvye0PeUyFcyfIp2x7DmDazMTmDb4xsTD75h90YU00yvbcek71n0s7rgDkAB40JeIUgJ6GVLq7N7XcAPaOjBnbXJLpe/ZUb5/JWo4ci8+I08GBZFcKV2Cf+DJQ+elS9fV2Eg2FEOp5GN6YFsgRx39dKKKOZKdULwOtuGsBkjNINoAnixFROdlE7piZwLoptX0RVCU9HCvLrHnWejj6Jhf1c3U9NDB1jW8sTQhGW5SLi3MMQKnSndGBPZii1xI02ivy96RUsrXP2UI+mLSksobWVnaOlwZRXw+313ROZB2xBJGam/bYGLD6vYGpZv/bafhY+x6oSOmkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=Eq2kQ7zZYb0wXPgOdmIOP7GAPy9fGxtX0qvVFcVjggO7A+yki//0vIe7VSCD9kLn7AzRyVApgJJPnN1oEPNHJNhyXAIW02lkcIqHoUlihehg33PG+tIykt9n0vCpI0bEnH7owMf/JQ7S1Gsum85Xp8pUa+kybHd3v9JpNWBpHuKVTgGAXm582byWSh/BapE6SGue/kpGbM7ftFEc0gO1kerASYfHDftKO+b2cyxoXl6uwGCGRHC7ats1uVyRFjKio9Jin40O7qEGeiB0FwT4KHpP27cN++WB8GBm8cJ0Ns3iPxOnq6pf6PT5ZKTXWivt/wB/LBnE5mty+LVJnOq+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=GAy6BBSvKU5asasO8G8teq7W3bmRoO2FUPMVPu+26XWNw/IdP+9qC39a0rv8vcSIwlMDv7LvtIs1isvwSECAIFiiKKpKMnuP/dBKjmeF2Fg16JcInIX8Dhso6LBcz6F1j1zSFUVFtcX/PhVGczWVUZDXyA6hNFovRLrOrJ/EaRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB10714.eurprd04.prod.outlook.com (2603:10a6:800:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 15:03:46 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:03:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jul 2024 17:03:20 +0200
Subject: [PATCH v7 2/5] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-cn9130-som-v7-2-eea606ba5faa@solid-run.com>
References: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
In-Reply-To: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI2PR04MB10714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8341b73f-0c2d-4b29-927a-08dc9c3a8067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0NOOCsyOFFtWlovYSsvblk0R2tjakxoclh3SVE4RHhMQWJETlJBaUt2RG8v?=
 =?utf-8?B?TXdzVE1aNkFTR21MREtCU1FiUzdMUU5hY2orb0pmVjdlQVhacHVvUkUzTjRy?=
 =?utf-8?B?bkVLVGkxOEFNdU5DNnZOUUM4a0hva2g2NGJUTlRzZ3A5aFR4OFZHQjdIMmxC?=
 =?utf-8?B?YlpvSEdsMVE0MkE5em9qdnVCVGZIUGFEckYwTlRoQlZ1eERMWk5EcmpXQ1ZN?=
 =?utf-8?B?ejdiOHZkdVRSVmNlc3RSTE9XQmJvbFltRS9iZEFjYlBCaUZZWGRnNU8ydkFS?=
 =?utf-8?B?a28wUy9qM09mczNRK1Y3WUE4S2FuNUU1dTN3VUl4T2VmWlFUbitiQnVGTFk2?=
 =?utf-8?B?UEtPS3hycXFIVkZaUnR0My82N2d1ejB2M29MMlY0S0tta2lkd1c3N001TmRR?=
 =?utf-8?B?YzFSRUdKWEtuMHl5V3BjVE1jUURqeFVwTDZrUlZBVEtBS1BrYnhXY1lLUnJ4?=
 =?utf-8?B?SFM1KzFyT2lIOWJzbDIzY2xlZ3hvVW5aUUN1Sms5ZjNOMWo0VlAxZUhWMmlk?=
 =?utf-8?B?bmNFNFljNFowc2RiaUthYzVuREd0Z2ZNUGdxYW84WFlQdHF5cXMrT20wRXZr?=
 =?utf-8?B?OUFyYUNBK3JnWmhHa2FYUnQxM09sR3grcEtQclZQVGZiV1VUQmVrU2EzRHlQ?=
 =?utf-8?B?RGRPOHFQYW0vU0JjU0pxQUd5VGpVUkl5L29YdVFQWHRQOVZTdTc1ODVYSnlD?=
 =?utf-8?B?ZlJFSmtyVlFEb2dWdElWb1BSdndhS3RIbXo5S3dnbFk3dEZ5KzFjaTUvR2ZN?=
 =?utf-8?B?cytmbkRmWVFyekZuRHNPUTlmMnQ3Zk9wV3lZQjdNdEw2WFpKbnVSbDFzMjVO?=
 =?utf-8?B?WVZVU1puYS9GWDRzZXhpUjEyTUZXcTkxbHQrYjdaK3Vwc2hWdnVwR0ZsZzFl?=
 =?utf-8?B?TjlwS0Z3ZVFtSUFxYVdlSVFhNHhWTjBmUk5HaHV6K3ZSRUIrbVB0bkorbUoy?=
 =?utf-8?B?bXBIYUtvS01aVFd0QVY3d1dKaFZTNUFvOWk0bGpWbGQ4NUY5UHZxU1RLR0xh?=
 =?utf-8?B?a01KQWM3RVFQdG1qeFVDaERVdjEwaHVxNW5tYkFpTFU0SlpUVDNCSnhXMWdn?=
 =?utf-8?B?RDhlem9VSmhLa2xvVDFvZ0I1Q0lXYmp0cEhhMG5tbzF5MkZ4MkxCa1g4b1RQ?=
 =?utf-8?B?NEFYcmdGQVlqM2pZZThxSEJ5Z241ZDNPeUxMTncyeGxKYmRNNktIcXUrQXV3?=
 =?utf-8?B?TUs3eUJXZyt0blBKVTFKc0FEenZJQ3lpVStyaGt6YmlWQUpCY2pyTW5lc1ow?=
 =?utf-8?B?Nkg1Qm9FcEFHZTl1SFF1VXFZdFh0WGtoZFBBUS9Qa1ZGU0JnSEJxcUdPS0lt?=
 =?utf-8?B?eFVnZU1maHArMFhvcXhSSzdNTTFHZTdOOHVTR0J2K21mczdVRTFpQmVZTTFa?=
 =?utf-8?B?RjhTZ25FVGNKSkt0USt5cHlvUk1VQWM2bnlzNzFaMHRBbUZJNHlFc2NGNE85?=
 =?utf-8?B?ZVRMSzhJalcrYjVMWWtubXA4WGNuRDBBK1dXZXNBdXY1dHJhNlltcXdFeHhn?=
 =?utf-8?B?b3M0Qyt0TFltL3hFRUdkaHNaTW9GWWhLdjBZcGRxL0F0RXFWOEtldzZyZFlW?=
 =?utf-8?B?VzYwRmZaTkQ1NUo0QmZweUFvdStDRC95RTFUR282VkU4Yy9kUTRCZmZaa1pX?=
 =?utf-8?B?cnUvaGhyajd2U1gyekZmWWZOZlJhbDBOWTZNYVoxaWpZemE3Z1V4MGRzQkxk?=
 =?utf-8?B?SjhWVlRvVHpBZHBKMUtqcjNrT01LSWZJWktpVFpDSDBuNmcvak5CTDFITDVO?=
 =?utf-8?B?MVdSNXlybHNudWpOdFF6OVZTZzAyeFNJOTg0S1M0RTZDb0FFd0k5TzNqQUEr?=
 =?utf-8?B?alY1d09vNDRvRmJnOTJtNUdrSGRTOXRqejhTSTdDYm1BR0NFWjNwb2xzUVpV?=
 =?utf-8?B?a0xrR2l1Nll0NEROWVJhblhxRGoxQnpzZldsWlE5RGpLbGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZDY3JISXRpNHlrSjhtZGxmN0dic3lmcVl0MmlBY3N2YkV4SHZnV3orTXVR?=
 =?utf-8?B?WWRXd2ZCdGxxWkRXV0x2NWlpZHNRNVFyY2VBWFNTalZHWTdtNHpXV004K0VW?=
 =?utf-8?B?T3h5d1daS012NVRCQjlIM2RmcVE3cktXWnoyVlVFeWl0RUViYVBCWnIvQUg3?=
 =?utf-8?B?dEp5UGpYS0crcDZwUkcxUWZhRWlVb2JTQk8xdFNWbUVQa2svdmtKYUhFTkNY?=
 =?utf-8?B?SCs2SStCOFppYVVGZkkySmtqSXU3eXE0N0VDVVhGcWdydG95bmNyd3pPdjE1?=
 =?utf-8?B?UUt4KzN5cUJiU1BEb2lNcnJORlFuL3NkUm45Q0haSnJxRDM1WDRFWWJ4M0xN?=
 =?utf-8?B?YVJpT21wVlc2alB1MWNuOCtOV2VkRzVwZEE2Z09Tb0UzQVZBWDNmY0p3dVpF?=
 =?utf-8?B?K0VoQzVWcGxnOGhtSUdvdXFDNU5GZWNnaHBIaWMrRTIzL2s3TmNLdEh0K0sr?=
 =?utf-8?B?dXB0QjBHL0VXL1RXbk45NzhOV283SEE3Z0g4TzR3ZnFRSUQvMGlTTmJXTjds?=
 =?utf-8?B?dm9wTk9lODd2R1YxYXAvYkZGZGRUaEs3Q01ua2NHQ3RDaVFKUmM3YXlmOE52?=
 =?utf-8?B?ZlUvYXlpcG5kakdISEV0dVNHb2dpZHBlOS9wNDV6TS8xcks5T05LcHhGMWcv?=
 =?utf-8?B?M3E4S0xNNUhVUGFMb1FXT3RmYW1HWktjZEhOWTNYdmFhUlJIWmtzY0VOc21N?=
 =?utf-8?B?RklFQlRhdlpBMGFNeGJwaEQyU090bnUrdkJXVlVwSS8xcGpUaGxOaHBsMnJw?=
 =?utf-8?B?aHR4L3FQWjZ4b2lmM2t3QThsZ0NOWWNLc0xGL3pRdzJ1Z3pyS0dGeDdrWmUy?=
 =?utf-8?B?TUlqME1ENHNZMjJNaEVsK0VVVUs2NDA0UEVrQVg5QUFoNCtyU0MvY01rdnAx?=
 =?utf-8?B?cTFvbzNwbmZ3UXltbDJBZDJpd292NU8zbDM0RmlsMG1NQ0x1WDBpdFBxcStO?=
 =?utf-8?B?RHA3T01sWGJFUTlMdTRDR29TQ2FzbDFGNXJlK3J4UDJ1L1NtdUhQREE1d3JV?=
 =?utf-8?B?akJyQkZiZVVMKzhTSDEvSm9RbXAycTBmK3dKZ1lQQjJHYVR6N0puTklmTklI?=
 =?utf-8?B?UEhSK3hKblFCNmVrb0RmNGJ4bjdhdmtoenROdzJidEgwcW9VWXIrenNSUzZJ?=
 =?utf-8?B?NjQycDEvSlFWWS9JNVRlMEYyWFJiYjhlQmJNOTBTTm1kY2tPNVFVK1RXeTJI?=
 =?utf-8?B?YnRROW16Q2RKQXQwTjdhaEo5cSt3VXI5d3R5dERqZUFLU1gzRGVWWFF3bExL?=
 =?utf-8?B?KzhiZXZIcy8wZ2VXcmZaUWNDRXJZaklremYrTm56WUhYUWs4TnVlNG82RW4r?=
 =?utf-8?B?TWJSZSt0bHgraC9xSld1bTJRSXdxWG8vTjNDQzdBNVdRMzQ1c1hlNGpsbnc4?=
 =?utf-8?B?VGNUaFRhU2VHRXJYaEJwbmVEc0FPYndRR0lVMTh0UnFMWnJucFJiZWx6SmN6?=
 =?utf-8?B?Tkh6WmFFaFptSW9nMHk1T0xyWkxiYkNndWRpZWxwYndPcWFkNVlyNWY1MkhB?=
 =?utf-8?B?aFpFNjBmRmMzb1cvYnFPeXltdStTWUVBZExDRmRYelkyOWltSy9IaktNWHZw?=
 =?utf-8?B?ay83MFRQdGh1WTNVQ2hYcHBFRVUwOEplc0hWdnd1blY4ZmtXU202T3RScm9v?=
 =?utf-8?B?UlhtQVJia2p6ZkJzVmNoN1Fsb05BeVk0ZWxZajBMdGRZalpTaGU4YWVHdDNp?=
 =?utf-8?B?QUgxR2VOQlJvYnMzaWRBZ3E3bW1KaVJOcmhQblV0cERxL0pFSk9USkVtTzR2?=
 =?utf-8?B?RWZmcS8zMDZZRiswK0huUndzOHRqb2R2QVdZb0dURm0vTHZ5VFhaZkVhKzVK?=
 =?utf-8?B?U1hSNHBIVWxqeWpudm9KZTFPWk5sWlcvNm1wZytuaVZqRkt1UHlweHdCb2JZ?=
 =?utf-8?B?UHp2TFY3SDJFMDNPL1lrbDlEZUNpMmxNZk1BTzFWcFFxaTlka3RaOGhlMkVZ?=
 =?utf-8?B?WTNKR2RlTXQvNFdmUFF4S1pkc21jT0xJeXV1UW9KRUIwYVRYakJmaWlDNDRJ?=
 =?utf-8?B?L2lVeW4xdkZDUzBSZGxVSjdBMm9WQUw5MTNKczU3amxzRmtLb0xpZnljUi9Q?=
 =?utf-8?B?cjF4UjViNjdVWUcwZk93bndobVF5bSsyaTA5akJ5T2Vxa0VONmk5QUpCTFhy?=
 =?utf-8?Q?Cz6phRuRY9Vx1bYN1F2h4SANs?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8341b73f-0c2d-4b29-927a-08dc9c3a8067
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:03:45.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOd+jzcWLoDjp6tfsHJMjk14v+aQzyWNHqlRI3chIod6DOSKBFvGLkWF1WKDZFEtzhPY5vTE0+aml12MzAmvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10714

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


