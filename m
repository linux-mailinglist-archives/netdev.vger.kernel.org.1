Return-Path: <netdev+bounces-94378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10D8BF4B2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC211F24994
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC1111A3;
	Wed,  8 May 2024 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rAdOKHHs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD61118E;
	Wed,  8 May 2024 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136399; cv=fail; b=k82RRgFhhmmow4IEvzfidz260ERFr9s8rDlykORGYZp2pqXssL5r+h9/oCoE2/uTKStwwc+QTzU6HmODytK+XMYpL+9dKcv4T/k+FYN6Xxc4MrbUtz2ifcIaC89QzF7XKneGaU6xkruDka98u3kU16gfavh1lkGZBQdoeoOKW1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136399; c=relaxed/simple;
	bh=GaIa9M72aGtNFfPYiGu0Ig/tb68VPSfrgXxEKbJVJeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOUMjFPueCsIMYwz2YSDrteihmOny56zhV2lHkWmCSYe5XO6wqQRlrSkIGriTLIYpYdM0fBRoSiCVaIWBUnoAwrPhx1RiDNcGZ9PuSFsNY1+c8gDNcg5uLTJ81UqNTKM7C36IlYIylbTgNr1vliB9hktsIdQTcmsKUYYcMnolV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rAdOKHHs; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0ZKD7Oth3iBbK9yz2YdzVXWjOJ/7RSAUPR3OVrX0t0IuOrtKShtj0YHkNVhTD1uGyS5PIlYYg5bI6rzmIDvUuOflRLJBZWbyIjiXOMTmq6qf47Pdai6i9hnYnuzBAsXFVZGkeNrGw0ffIsLR8cnV/bQAcsElfRHZAxRvU1NJCJUgEPd6ElaFfN/mejaYaQyU70ltVhC1QLY7Tyb59ACx19fHcv1N8ABFlixPnCxfUXcVxoFNP/LUDmo2IqA6BnEtXTbS7SY24VqJNpT05Y8t6sGlydCBie9a/hdFGEfXeWJDp/GpqHu08tpXsyAA/1NopM8gHzEZf2MxxyuSQR0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaIa9M72aGtNFfPYiGu0Ig/tb68VPSfrgXxEKbJVJeI=;
 b=kchS9bOKR1YyESG5BH4nPYi+Tn1PmU2Fhik6lWnaRhfsep6awe4xtH6gEZnBUm5OWdszTI4Ww0EyZ8qjMAp4w1T2tl42APombOKozYVrfR8mmh+7bpHd6KOZ231haCCiQkCR7pQzIurd5VP7zsTEsjq+BFWJfswY97j0FvrTEiz2V33LALa8puOR9PRM4jNa/Au8GWqQlWXFojOMPSS47Z1IMp/d/D8z01zrGsZyMGHHL+DkulNZH17DjxiKZ1xgj+FLH6AkVVsWkkNpjSDXidkQF0l20tlBVF9w869SNzsxgEJKtsHne9xMbgFhrQNfHJbODT91f3TK8oQOQZO6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaIa9M72aGtNFfPYiGu0Ig/tb68VPSfrgXxEKbJVJeI=;
 b=rAdOKHHsilpUeiJi5symNaWYwCf65tGjYI7pYf1/TzZ4ENjA65lUkCm21n58BD0Li+cWW/fVUmFuuoXBtLPuQyvw4CPlEvGLTzHNCA2qvqekxoFtFhlkcewVTaeKqXjiS0sfP4RcJVU6v/P4fpb1A39Pce5kOInHqQs1pf0s4gI=
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 02:46:31 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 02:46:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Suman Ghosh <sumang@marvell.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH net-next] net: fec: Convert fec driver to use
 lock guards
Thread-Topic: [EXTERNAL] [PATCH net-next] net: fec: Convert fec driver to use
 lock guards
Thread-Index: AQHaoF87FjdcCM/rFkC270r3dj6/NrGLqiOAgAD3jlA=
Date: Wed, 8 May 2024 02:46:31 +0000
Message-ID:
 <AM0PR0402MB3891B1E5E2A99367F57DE8AC88E52@AM0PR0402MB3891.eurprd04.prod.outlook.com>
References: <20240507090520.284821-1-wei.fang@nxp.com>
 <SJ0PR18MB521656F021A8A9BECD0CE105DBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To:
 <SJ0PR18MB521656F021A8A9BECD0CE105DBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3891:EE_|DBAPR04MB7413:EE_
x-ms-office365-filtering-correlation-id: 4957b9d4-fbb2-45d9-7968-08dc6f09110e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?bVRKdU9VYzNBUDFsWlZSZXhOVmRDVllTVXBsajNOU05YRXJPWndtblNXaC9Q?=
 =?gb2312?B?T2h0enVJMklpaytOQk9KOEJsamhJQlFkVDN4VW5ZQi80MU1EQTI1eE1LNnhk?=
 =?gb2312?B?dDNtRnBTRldYaXRUNnIyVjBLTlZJTU5jRUZhK3I5V1RFaHBLdE9hRHczb1gv?=
 =?gb2312?B?czM3Ym01NXU5OVQ1RVVkS20rM0Fra2YvMUpHeWE2S0t4WmlMckhMSTNSdjhB?=
 =?gb2312?B?SDRTZTcvaG5OMExsQ3RzbzViWnkxWnNISjY1ZEprbDVPRWEwUDlLNXI1bmtR?=
 =?gb2312?B?eURmYjJZNzFOZTJHYlRZL2tBZW5XTHJ5NWluL3ptQi9TWHZ6QmZEaktMR1Nk?=
 =?gb2312?B?MGpZNm9mU2RuWDlHM21MRXU4TFEyVHE3akFMNFB5bXFMUzZKTmtIQkp2c0xX?=
 =?gb2312?B?dyt1bEtXWmhPSTZrUzhhNyt4a2xnRjFNS09mR01tZDlqOThXWXZEYmsrMTZX?=
 =?gb2312?B?UWhtK1ZrODFwRTIvYlpvWU5kM2tGaXYvNTl0dTIvMVM2Z0phcWhZT0FpZlNv?=
 =?gb2312?B?UklpbzNEVjcxbldkZEJ5eTRKWVgwNnRHMFNGZUozcHYwb2Q4cVJRVmJJNUp5?=
 =?gb2312?B?dmFJTmtEYThuZGNKTzdNQndEU1lCVER2REd4aEQ0TENFME01MUFaaWhlN1Ny?=
 =?gb2312?B?QTFzeURWNW8yTkxrMlRnaDF1VWpRTVV6N2lMdFVPckQwcTRnWFVYTCtaZE54?=
 =?gb2312?B?dmFpaG1ITTBVTTcyOEx4NmtsdW1kVDBSM2I4aVBJVXdWNGZCZnNwUnhLckpY?=
 =?gb2312?B?WERrYmJaVUhDR0FVN3pUdEhkMFhiZExLTjVqcDJmQTVZQ1ZQWFBzUks3ZUI0?=
 =?gb2312?B?VlQ2NytTWHE2ZERSTDZDUCtqUVBqWncyeEFhWmJqRTdhM1lVRWFBaDdZUDZM?=
 =?gb2312?B?SFREb3A4QUowa1k1MjNyQ0lFWWpJd3ZLZ1NtWldldXZzTms2ZUo3VzlUM1lp?=
 =?gb2312?B?QUVKNW95KzNlWTJ1d2ZMOUdweFJXaFNHc0RlMWw0L1Yxa1AvWitjMGJUNmd4?=
 =?gb2312?B?UkNmNGFxV2xSU0xHdWlTRU9vc2JJR0hmVXNGYWc2RmV2VFVsVjdKSGlESkF1?=
 =?gb2312?B?NkowMEh2R0dBMUkwL01yaXBXazV5V0k4Yk9xUkhmbjg0ZjgvOGFmZTM5RFcr?=
 =?gb2312?B?UUZjdVN0RHhFdzMzQ1dkUldYb1ZrQTliYVY5Y2RZeVpYeXIrbFQzcjhiV1pS?=
 =?gb2312?B?REVVSGh0MmZtNitacHNvQUlPTE51L3M4cVh0cG96em9RNWNidDBJZ1RxS3NN?=
 =?gb2312?B?Mmh5YURoL2dJMmlpMkVBbnNucU5EQ0dUQjJaMUhxMkkxRGpkNURPNUl2UERH?=
 =?gb2312?B?Tk5WNTh2dWx2V1FyVS9HYm00V1dpSzZtR1V1aGFJOENkVm5FNTJIQ1dTM3Mr?=
 =?gb2312?B?VTJqenJvWWpUU1BjeW9UWXJQNGdyMWpSbnJrRVE2MThxaXh0eUl4V3JDUUFy?=
 =?gb2312?B?VkR5QnQ3Wm9rKzJ3dmNtamM1YVRKZ1RCL1p4WlBnNWlsa3hKb1lFNDJDRUUv?=
 =?gb2312?B?TWZHUnFGLzhXM2pySk1CVG15ODNORjlRaWpUQkh6dW55L1hsY05aYVR1ZWRQ?=
 =?gb2312?B?am1ScU5lamxsVlYxdTM2TWZwczVNWFVVaFNlcUppaDRDMEpBYkhjUEJramFP?=
 =?gb2312?B?N2t5OXphNVp1YWw1U1NnNER2empxaVk4QkM4TnBoc0dEWjZaWXRDZnhRMGoy?=
 =?gb2312?B?bytMOERtT2tHczhnLzBtUmRCQ1lSN0h0TXpieTVEZ1RNaWh3ZTVQZGw3VUJ6?=
 =?gb2312?B?ajN2dGVIanpJQjlQcFFJKzRrMlliWnJsV0NHRHlaRTBNTFFWRktBK0dTNjlt?=
 =?gb2312?B?bzUxSndXSEZmWEZNL1JRZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?emYzM0tRRFQ5MFhoNnhwRUZmOVlydjRvSHo5NWF4SFkydks5SUluRis4SlFE?=
 =?gb2312?B?MEVHV3VGZFpwUVBVeWxjT0pvcnlHTUlyNEdWdWpudm85MFVCVjlwMUF2anE1?=
 =?gb2312?B?dG51NGpMK1hDL2lzc3VXVHFwVmpOSlQ3R1dPT2oyVFB0bnNpa3lWSmY3bmZF?=
 =?gb2312?B?TDlPR01CeUpNaDhsSGp4TG9rQ0N5TTEwMzdxeGVhWHNOUGdCaWRaanZYeG8x?=
 =?gb2312?B?SVQrZE8rYWVEOVk4QnEyYTc1SFVkRGpRUDhUSndpN2lILzZjQ2pYOWhNam5D?=
 =?gb2312?B?SVVaSk1hZTc0VStoYmJtMHp0K3hvWnZEaHFiYWovdkJqK2xZL0hYWm0rT05y?=
 =?gb2312?B?dWR0bDNnV2xPclhwLzQvNS92SFh4ejdvLzFBRHdMenNhZ2xVNFIwL1JGWk9v?=
 =?gb2312?B?NGN1ZXBvMTFpcDlTZ1BmN0lBOUIvQVRwWUIyOEEyQUlLbUQvakNnR3llNVBD?=
 =?gb2312?B?U3pWY3lqM0JMeWRldUJnTEU0MWlKY3k5UDZaSHNwenQ2bWlZOFU0cm9rSFpI?=
 =?gb2312?B?elRXNlBUQlpUVWNtNEVNWUlJc1V5SXNHS1U5ekVxalBldm9JY0ZoNmR6UUIx?=
 =?gb2312?B?cUdjNmlaME1zTXRJMG5pNU9vUGJoc2h0enhXaVBhSjhGbGV6bGlTOHZ1VXR1?=
 =?gb2312?B?RVlnNVVRRVdsZnVjYS9tY213dUkrcFVmMmtxVWE3dHdnU282YjlFUk5BMFR4?=
 =?gb2312?B?eUtGaUpkNG1XMnNBOVVTc1hOUTlJRHRpSGpaZ2JpUUdWekpXb1JuUGdJYllB?=
 =?gb2312?B?Q0pqeTdNcnNyR2xETjV6NklJZVpIc1E4SGQrcG1tZWNvWEhoZSszUDhTTHNa?=
 =?gb2312?B?Y01NbjdXOG10dy8yUXI5eEl4M3VUK0lzd0ladllneWtndU9qZmpNZVlwS0JR?=
 =?gb2312?B?dWVZcHlIVlJiV2pyVzltTUxEeEFKM3lvejlnVnBmMzl3dldwN2FpNmM3NXFx?=
 =?gb2312?B?YVRHeU0zaXM5RUUwV0o1NmtEdlk5YWNmR3haN1BZUG5mQzUrTUxoeUp4ZjhC?=
 =?gb2312?B?NXJReldsSDByOEw0emxlQmw5MlZIc0JCUUI2cnBzVXVCTFVLZ0NKWTkvTDNw?=
 =?gb2312?B?aVR5VlJqL0RrOER6T2dITllOWlcrNEdHUkZKdVhkSDZUbnl2Q0EzR0pxZ3B2?=
 =?gb2312?B?YjYzYmw4Rms4Z3FXN1VKc2FueTZWK253WnhsMTFzc1dQMkt3RFkxSWVCZnJi?=
 =?gb2312?B?d2JXT0NseDBYWnRIVG5FVjRtdVk2YWJRNWNLbVlrOXZQN1lLTDZ4N3hnbTJq?=
 =?gb2312?B?VlpaR2M1MEJpMWN0bE4zN1d2U0ZSMCtVNk5zSlRxdW1mSzVKSW93RFJzc0pl?=
 =?gb2312?B?T1BSMjZNWSsvUW8ycDQ3cnIzcko2VWR2MXloSVl5eVFUV09HREJxQi9aMHBU?=
 =?gb2312?B?SmY0YzVaU1dONGhwMmZMVXZUQkJFc3VCbmE4TUxyQzROTVV5RXpQY09WcFdZ?=
 =?gb2312?B?WTJkNGsxOEQxMjJWbElkVVhJRmhuOHlXM0JyOGtDZzRscGw5c3JEVXVHdDB6?=
 =?gb2312?B?YkZnRzJ4QkdpY01WanFvUHVwcUx4Q2FhWEpZakJvbTEzRmltT2FLMm4wM3d0?=
 =?gb2312?B?aEM5Q2QvN3R2Und6bndXWDBWaEVJM2piN3M2dXI5c1N4QjNtRngrS3cxZUNr?=
 =?gb2312?B?Y3JXUUJhaTNWQmVkTnUyNDJBbFBXU0NCcjYzVHdDQjg4dTNGdXFhaUEzcXVw?=
 =?gb2312?B?OUl5OGxQdC9aWHVYcytWRnFQeE9ibXpFSVhsOWhqOFl1VFJOQVJYN0JmS3RS?=
 =?gb2312?B?NDFBUjBTY01zMUJKWEwrRVdWZnkwK01NZEpRN0xKR2JkTTI5TXZlaXM5UXQ2?=
 =?gb2312?B?T3NUUldCUGVVamZ0NXBIb0ZpWlZmZDd2V25OS0s5SWppSFZRMCtwOFFsVTZa?=
 =?gb2312?B?ZklxQ1R6Yit0NEVpRjRueXhkejBoN1V0ZmNqRm84SFVXRjlnYWkzZ0xHY1Ns?=
 =?gb2312?B?M1ROdi9GREhrRCtsWVVhazRxem9aQ2V4TlYzRWl4eG1kekdYOWFJVGV0NWZ5?=
 =?gb2312?B?VTVQZStueHJPdDVGSVU5VUVySlkwcjIrdGVQK0JadFJhbzl5SkxhUXU2MG9z?=
 =?gb2312?B?L3VkU0JZVVRlU25OK3lkdUFvMEJlYTRBNk1jU0lFckVBdnZZTGkzNWFPelNY?=
 =?gb2312?Q?2ix4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4957b9d4-fbb2-45d9-7968-08dc6f09110e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 02:46:31.1191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aABw8lpwV81ICZmXy85s6cLgzuk6ET6KSH7Tm83VW9ZqO//jrU7W+oCBtSBAU2+rfSNqLCpwsy9/HNjO5KqhnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW1hbiBHaG9zaCA8c3VtYW5n
QG1hcnZlbGwuY29tPg0KPiBTZW50OiAyMDI0xOo11MI3yNUgMTk6NTUNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgU2hlbndlaQ0KPiBX
YW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRl
dg0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZmVjOiBD
b252ZXJ0IGZlYyBkcml2ZXIgdG8gdXNlDQo+IGxvY2sgZ3VhcmRzDQo+IA0KPiA+IGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgIDM3ICsrKystLS0tDQo+ID5kcml2
ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jICB8IDEwNCArKysrKysrKystLS0t
LS0tLS0tLS0tDQo+ID4gMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA4MyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9mZWNfbWFpbi5jDQo+ID5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNf
bWFpbi5jDQo+ID5pbmRleCA4YmQyMTNkYThmYjYuLjVmOThjMDYxNTExNSAxMDA2NDQNCj4gPi0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4rKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+QEAgLTEzOTcsMTIg
KzEzOTcsMTEgQEAgc3RhdGljIHZvaWQNCj4gPiBmZWNfZW5ldF9od3RzdGFtcChzdHJ1Y3QgZmVj
X2VuZXRfcHJpdmF0ZSAqZmVwLCB1bnNpZ25lZCB0cywNCj4gPiAJc3RydWN0IHNrYl9zaGFyZWRf
aHd0c3RhbXBzICpod3RzdGFtcHMpICB7DQo+ID4tCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4g
CXU2NCBuczsNCj4gPg0KPiA+LQlzcGluX2xvY2tfaXJxc2F2ZSgmZmVwLT50bXJlZ19sb2NrLCBm
bGFncyk7DQo+ID4tCW5zID0gdGltZWNvdW50ZXJfY3ljMnRpbWUoJmZlcC0+dGMsIHRzKTsNCj4g
Pi0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+ID4r
CXNjb3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmZmVwLT50bXJlZ19sb2NrKSB7DQo+ID4r
CQlucyA9IHRpbWVjb3VudGVyX2N5YzJ0aW1lKCZmZXAtPnRjLCB0cyk7DQo+ID4rCX0NCj4gPg0K
PiA+IAltZW1zZXQoaHd0c3RhbXBzLCAwLCBzaXplb2YoKmh3dHN0YW1wcykpOw0KPiA+IAlod3Rz
dGFtcHMtPmh3dHN0YW1wID0gbnNfdG9fa3RpbWUobnMpOyBAQCAtMjMxMywxNSArMjMxMiwxMyBA
QA0KPiBzdGF0aWMNCj4gPmludCBmZWNfZW5ldF9jbGtfZW5hYmxlKHN0cnVjdCBuZXRfZGV2aWNl
ICpuZGV2LCBib29sIGVuYWJsZSkNCj4gPiAJCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gCQlpZiAo
ZmVwLT5jbGtfcHRwKSB7DQo+ID4tCQkJbXV0ZXhfbG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsN
Cj4gPi0JCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZmVwLT5jbGtfcHRwKTsNCj4gPi0JCQlp
ZiAocmV0KSB7DQo+ID4tCQkJCW11dGV4X3VubG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsNCj4g
Pi0JCQkJZ290byBmYWlsZWRfY2xrX3B0cDsNCj4gPi0JCQl9IGVsc2Ugew0KPiA+LQkJCQlmZXAt
PnB0cF9jbGtfb24gPSB0cnVlOw0KPiA+KwkJCXNjb3BlZF9ndWFyZChtdXRleCwgJmZlcC0+cHRw
X2Nsa19tdXRleCkgew0KPiA+KwkJCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZmVwLT5jbGtf
cHRwKTsNCj4gPisJCQkJaWYgKHJldCkNCj4gPisJCQkJCWdvdG8gZmFpbGVkX2Nsa19wdHA7DQo+
ID4rCQkJCWVsc2UNCj4gPisJCQkJCWZlcC0+cHRwX2Nsa19vbiA9IHRydWU7DQo+ID4gCQkJfQ0K
PiA+LQkJCW11dGV4X3VubG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsNCj4gPiAJCX0NCj4gPg0K
PiA+IAkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGZlcC0+Y2xrX3JlZik7IEBAIC0yMzM2LDEw
ICsyMzMzLDEwDQo+IEBADQo+ID5zdGF0aWMgaW50IGZlY19lbmV0X2Nsa19lbmFibGUoc3RydWN0
IG5ldF9kZXZpY2UgKm5kZXYsIGJvb2wgZW5hYmxlKQ0KPiA+IAl9IGVsc2Ugew0KPiA+IAkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGZlcC0+Y2xrX2VuZXRfb3V0KTsNCj4gPiAJCWlmIChmZXAtPmNs
a19wdHApIHsNCj4gPi0JCQltdXRleF9sb2NrKCZmZXAtPnB0cF9jbGtfbXV0ZXgpOw0KPiA+LQkJ
CWNsa19kaXNhYmxlX3VucHJlcGFyZShmZXAtPmNsa19wdHApOw0KPiA+LQkJCWZlcC0+cHRwX2Ns
a19vbiA9IGZhbHNlOw0KPiA+LQkJCW11dGV4X3VubG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsN
Cj4gPisJCQlzY29wZWRfZ3VhcmQobXV0ZXgsICZmZXAtPnB0cF9jbGtfbXV0ZXgpIHsNCj4gPisJ
CQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGZlcC0+Y2xrX3B0cCk7DQo+ID4rCQkJCWZlcC0+cHRw
X2Nsa19vbiA9IGZhbHNlOw0KPiA+KwkJCX0NCj4gPiAJCX0NCj4gPiAJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShmZXAtPmNsa19yZWYpOw0KPiA+IAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGZlcC0+
Y2xrXzJ4X3R4Y2xrKTsNCj4gPkBAIC0yMzUyLDEwICsyMzQ5LDEwIEBAIHN0YXRpYyBpbnQgZmVj
X2VuZXRfY2xrX2VuYWJsZShzdHJ1Y3QNCj4gbmV0X2RldmljZQ0KPiA+Km5kZXYsIGJvb2wgZW5h
YmxlKQ0KPiA+IAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGZlcC0+Y2xrX3JlZik7DQo+ID4gZmFp
bGVkX2Nsa19yZWY6DQo+ID4gCWlmIChmZXAtPmNsa19wdHApIHsNCj4gPi0JCW11dGV4X2xvY2so
JmZlcC0+cHRwX2Nsa19tdXRleCk7DQo+ID4tCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZmVwLT5j
bGtfcHRwKTsNCj4gPi0JCWZlcC0+cHRwX2Nsa19vbiA9IGZhbHNlOw0KPiA+LQkJbXV0ZXhfdW5s
b2NrKCZmZXAtPnB0cF9jbGtfbXV0ZXgpOw0KPiA+KwkJc2NvcGVkX2d1YXJkKG11dGV4LCAmZmVw
LT5wdHBfY2xrX211dGV4KSB7DQo+IFtTdW1hbl0gSGkgV2VpLA0KPiBJIGFtIG5ldyB0byB0aGUg
dXNlIG9mIHNjb3BlZF9ndWFyZCgpIGFuZCBoYXZlIGEgY29uZnVzaW9uIGhlcmUuIEFib3ZlLA0K
PiAiZ290byBmYWlsZWRfY2xrX3JlZiIgaXMgZ2V0dGluZyBjYWxsZWQgYWZ0ZXIgc2NvcGVkX2d1
YXJkKCkgZGVjbGFyYXRpb24gYW5kDQo+IHlvdSBhcmUgYWdhaW4gZG9pbmcgc2NvcGVkX2d1YXJk
KCkgaW5zaWRlIHRoZSBnb3RvIGxhYmVsIGZhaWxlZF9jbGtfcmVmLiBXaHkNCj4gaXMgdGhpcyBk
b3VibGUgZGVjbGFyYXRpb24gbmVlZGVkPw0KDQpUaGUgbG9jayB3aWxsIGJlIGZyZWVkIHdoZW4g
aXQgZ29lcyBvdXQgb2Ygc2NvcGUuIEFuZCB0aGUgc2Vjb25kIHNjb3BlX2d1YXJkKCkgaXMNCm5v
dCBuZXN0ZWQgaW4gdGhlIGZpcnN0IHNjb3BlX2d1YXJkKCkuDQoNCj4gPisJCQljbGtfZGlzYWJs
ZV91bnByZXBhcmUoZmVwLT5jbGtfcHRwKTsNCj4gPisJCQlmZXAtPnB0cF9jbGtfb24gPSBmYWxz
ZTsNCj4gPisJCX0NCj4gPiAJfQ0KPiA+IGZhaWxlZF9jbGtfcHRwOg0KPiA+IAljbGtfZGlzYWJs
ZV91bnByZXBhcmUoZmVwLT5jbGtfZW5ldF9vdXQpOw0KDQo=

