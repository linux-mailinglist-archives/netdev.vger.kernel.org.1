Return-Path: <netdev+bounces-189618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61FAB2D24
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D723BE1FF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754A2185BC;
	Mon, 12 May 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="nLg27H8B";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="fzxs/TMu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232A210198;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013309; cv=fail; b=NsSYjLiXVeVFXVkIpHG+fVapAHDvUtb6CJKliuS+Fp6UyuJYuubjoo+AbONtfNF7dt5w7L09/I5/1CHQxfa3ltk8XbwmrsFmyxdDAt9wKlY2j2d06tKxNhkH1EAKaO9djB+FxlYaxaqYQsfZC5afTfDjfQYRCWrRJh/mrCA/Sek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013309; c=relaxed/simple;
	bh=1hIlqrNFHGw9mq61l/tBkz65eya983ytAL8SVpcZlzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=setvnvJ9efs+B2p37V2IKyTOJHjDCkgq5CX5HHsOGv1+OFe/qvKZr4wAmDE0RQq1d7K0GG3LzM57t6dBVZg2b0Ux7kUwcOgwoo3jiDgD0dj7hX0H9JWs8lsqxFMu1KyL1S3o9+9aGkGNgk4hxE6DSqx+OQkkzRXHqBFhk8Ee3oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=nLg27H8B; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=fzxs/TMu; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rq027700;
	Sun, 11 May 2025 20:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=rsrtDaVYT0EGlKun0m/DLcc5C0Zcc+VmuIsFnK4ijq4=; b=nLg27H8BpWYv
	9B2KtvHvDtsgWMs1nMbe8zijvW17vBL9THUCZO2Xgq5N+MauJMsP3PthPlWPOr6m
	dz+Forbhfj3UMogujjA4UgJOBQqf7hPgtEd5U3XLnXv+V6ptaLNxGvELnq8q0VCi
	s2EbTp4M9I6Yfx3h6yhil34eYlR6ERHJFifSIc6iWubPs4EpPu8XoxF54CITqrxy
	sol9CsUbITqUPi7faah6KvDjTmIZCrd+wGJ4DCd2GsHCwq0t7cZe+3y9HTVjOunU
	NGevPm2Cui4iaF9SuTB7W1mGuVY67Gwu117ITdfytlUFyW+sLGMsbDjL2zhWqTIz
	qj8xxUHDbA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTrMB7QlaCG3UKCyuinqlN6ziDlV+uXtu0KjczhQi+TNg6Ug596Gpxh3OLxvIFG9i7x6mRltMLhmUNXP+vhau5mjGB3F6vtuKtPmkOACnoj2PIigOdSvQ+lA98tEj1t6zgGTgIz3354j8UGjRzMALUQRldwuWu2DkhI0gQ3T7fVthYWlv1sU7YOndM2wZvUNbYrf6jj/YBFCsQAi3VmQdIXSVt8oYLUk+FzlCgjlrIZwRR3b95rVHBwBZgtffVtWGBRVrwvuLGxvq66p+DCs+pR6LB/gXoA9oh8Gd/1z0FAhecz5YuAGagCYCRjFijFDje186bDwjKIUWlD5t4AjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsrtDaVYT0EGlKun0m/DLcc5C0Zcc+VmuIsFnK4ijq4=;
 b=ipmSmFSfH61BSDeolOPvEXERfY7oS//fTmcW6/wTc70bi4B9Z37OirK1se/J0+2h7mKUdmDx73L/VpZpFknvK0Ni8ojYe3p2k2dOie74FtSTWEq5a3CutLY26SjsF3XqDE15T04bcz0LHTKA0HcZUYpXX1QbX66aBtijyoAJJX4rpd7zczPLcOz2SCl3gpvImelp9oj0wpi0w6kERuORuBhUsRF72u2V21stTT6tmPRfSLGVQfQ8UGIgabLrlHfsC9zEQ9Mvf0B7di+mfkieS4/OKU+zyfaUcYFewCBvQiv76lU+YzAfySuxh4AK9Lmo3O+PZ2DggqvOzdq50mb+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsrtDaVYT0EGlKun0m/DLcc5C0Zcc+VmuIsFnK4ijq4=;
 b=fzxs/TMuhd/RCK13AFfzJrZsEriES/wzYp4RfMzi7xTZ1oUiPbwrYNeM6AwV1j47mlChLXzfBGCX3s1YC/su8+Y3HLLlHrRfQSEpLz+u+nDet+tWodgnb4dhgPZ/kdsFIw2MbR/vHy96Pldc2tWPC0nvGCCPMr0dPmVMHy2jqm4=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:04 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:04 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 09/15] net: cpc: add support for RST frames
Date: Sun, 11 May 2025 21:27:42 -0400
Message-ID: <20250512012748.79749-10-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 793a4aa2-70a7-4a2f-8681-08dd90f43df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U05GS2RTT1hXY0RkRXVpNEdLemFzaktRWUNaK0NHRXpVYThHZjVsa2IwdEgx?=
 =?utf-8?B?MnFXUG90SFFuVldvK2pxdEVkYmx3bHd4NHVOem15UEQ5UHhqL0dyTnlBc3JT?=
 =?utf-8?B?aU9ZT3diY3I0bVVmcEZ3bzNPRW82R29GRlFWZXkycnpWK3BnL0RWZTBqNHI2?=
 =?utf-8?B?L0xmQmRWd3FOaG93aE9rWmxnckt6RldhVjVnU0REV2pUMVdtUmlwWHc3RE9u?=
 =?utf-8?B?eTgyRmN1YVJ0Vmx4dUZjUjhtbkQ3aTJFWVhkRTYvdXJHMitNWXNnWHVKMk1T?=
 =?utf-8?B?clVKR2Z6OG45U1o0OXY4VG1lSFhvZTJrTmI0eWVWeGR1eHJNS08ySlUwTlZN?=
 =?utf-8?B?MTAvUEFKMmdVenIwTGRRSURKSWhrbTJTbWtSTjJCNk01aU0wdFc5SzJUZkdm?=
 =?utf-8?B?OXJPMU9PdUtnVGRMMSt2VkF5bVVmaWVUL1Bpd0RuVG00Q29RTTVyZGV5dUpy?=
 =?utf-8?B?T1RNdEt3QmxKTmx6ZWdJekNXMTNwNk51NDVvVTNSdXZyb2dGUEhnR1RMSm9z?=
 =?utf-8?B?RmdQNnp2MzJOTGhGU1FGVFRPc1ZtV1FzbG11VGd3VHZaR2ZJRUpYS0RRNVJX?=
 =?utf-8?B?dTV1SjYzYVc2ZzVzaFR3U0JHblk2M01nMFZYVDZxTFAyd29uR1cyQWsyK2E1?=
 =?utf-8?B?K1F1YndpcDFHUWoxbzQyOVk4cHYrVU5ZZjBTaVNFRlBlRmV6M3pGV0Y2ajlH?=
 =?utf-8?B?TjEzWVB3SlptektwQlpGMXJlVkFQcjBOVFU5djEyb2lxZjFKUzA0UkhWdG91?=
 =?utf-8?B?R2VueVJxM0ZjaXZudGF5MmVOV3pQWGd5WEJZVzJkOHp0eUMxRGV3dG1ac3M3?=
 =?utf-8?B?NVpFdTRQajNJYmE1MWlOZm1VRnV0S0N0TmxsS0xWbm53YzFWSHBtai9mUzVP?=
 =?utf-8?B?N2d6cXpzY001Unlabm54WC9tRmFBazZ0L04rRWd4amN2RHpUeExYWkYxUERD?=
 =?utf-8?B?WXJwV3dWZE1kWC94WXc4VXlXbDJuZW9va05LVUpQdVFmbWE2alBKY0pIUGJT?=
 =?utf-8?B?dUVUNFZUUDRDZ1RTZmpnU3pjSnBsUTd3OGN6dnkzQmFNbGw0dzdnZlkrNjVJ?=
 =?utf-8?B?Yko1RkRTMG9hM2RzQWRuSVpsYTZpTVhITjdUY2NJdWJYc0QzZGFTbHI5S0tK?=
 =?utf-8?B?QngyNGQxTEg2TzQ5Q2lteitVR3ZXV3RNYXpOWHJWMG4yb3BYZUFoaTYyNzNW?=
 =?utf-8?B?NjByenI1eS9xN01aR052UElNZ3pQbEVqZkdlcnVrR2lvR2pOcjZ2TFFJTTAr?=
 =?utf-8?B?TzFVWEZNdmRUTXZldWFrOXJvMUNZZlpWV290SFpmWUNjUjV6Ukw0TURobER3?=
 =?utf-8?B?dGRieUdTaW9HMHdwcnlla0I0ZDc2Y29nV25BVjRySXF0WjE0M3FhZ2ZBRlRk?=
 =?utf-8?B?a3F5ZklMaU52a1N4Nytjb3VEYW53eUt2TEtMVnFrMUdKSVlLK0VXclVocjZS?=
 =?utf-8?B?dlhIeGpxbXdYLzhHT3FkbXltOURTRzB2bDh1bkQ4L05qeGN2d0xGL1d2TTJt?=
 =?utf-8?B?RWtOR2hZaDVJalBxL1NkMkRRZ0JUblUxMkpSOUhFeEVZYzhjYTdHSjl2dVJi?=
 =?utf-8?B?TWx5MnJsWTc3d2ppK1VFbHdkcmN3UnVCb0JWbnNuWlhVUy93WThiWVJJUkUy?=
 =?utf-8?B?MlFPZk5ZZE1RODR4QkdvOWlIenNSMi9NRUw4cDBzVzBnbTlkK1BzRnNLRWZV?=
 =?utf-8?B?TTc0dGcvSnh3VkhhWjFDZ0FBeVJuWmNVOUdEdUlHY2hzR2dLaGVmYXdwdHRS?=
 =?utf-8?B?aHNLMVR5WEp4QUxYQU0wcTE5TlpMcUNMa2puQTRNbnBQZXpuaHFmYTg4V081?=
 =?utf-8?B?RHcwVE03cEhqS2pVemtYQnpESWRraFc3UWljR3NKRkZDbU0zL2JTMjU2NGF0?=
 =?utf-8?B?VTkrMHg4bDV1NkRjSmp1d3JkOXBHQlBBWGU5SHNHMDdST3hKb2Q4MmpaY1ky?=
 =?utf-8?B?SWFVMVpNcHJ3VE5XWFNwUXViZ1AvRmZ0aXdIbjk2N2UvVjc3MUVJcTF4Uno0?=
 =?utf-8?Q?opnp1rE+qXIzr5kuyzQ1zMmgYXqHEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZUV1h0Y0l2RGk4ZmMwYUd3T3NCVFl0aHhlaHk4c2ZBdHNkMW81aUpmMFlz?=
 =?utf-8?B?R0RoVW1ZZ05lL1FvOXpORnRRajNuM29mVDJVL044U2FIamdMQUxNTHdXem9k?=
 =?utf-8?B?Umx3WWFodUJRdDRhaEZBSnU1a1k4bGx4N2dZdEJsbUphKzl0WmozVFVkUTJ4?=
 =?utf-8?B?ZGs0aDU0ZEpRTkFjdDJOV1JmSCtlbkpHM2daRWVrR1lRUW9uZzM3b0NiSEFl?=
 =?utf-8?B?WUpuOTJyVXlMYXpWdGJEOUw2VzlGVkt2dGxsdFhPYVpZL3Z6N2xXemQ4UHJK?=
 =?utf-8?B?MWRHQlFkcEhVYzgzbU9jRTJaOEhLTDl2OXd1cmlJOWZvb1lGT3NIbWROOWMy?=
 =?utf-8?B?d1RWczJRaHhkYTFXdGJjL3VuNWdpVGlya0VaM2FHWmN3R1J4QzBrQVJXaFFn?=
 =?utf-8?B?LzdtZUl2dTREOWN6UWtCU2x6aUpyVjR4Nk5Xbk5OLyt4RHE2bmZTeEhvNWR6?=
 =?utf-8?B?emlHMVA5OWZETS80RlZnc21mRlpSZDJqanQzWWtUYXl4Z2lHQ1lFRytTOHJr?=
 =?utf-8?B?ZGkrQ2xMTE1qSjRUR3NYSWtsaTd3c1NjNWRkd2NWSVRyOGpjRWVWMUFJUWdD?=
 =?utf-8?B?MUlkTmFGbGxPU3VHVW9aRFhkbHVHSFVBaTJvOVcyTWxRdkV0YWIycGo5cmNY?=
 =?utf-8?B?WUhSZ0lsRjdjdlFiZU1hNGpVdU9jVFBFeFJtV2lYZjJUQzhjY1dkaW5JTWFR?=
 =?utf-8?B?RkY3R2lZaVFIczhXaWZ2Qng0cVFvKzhzeXNKZDlFVnBCeVB2NE1PZHVuSFFC?=
 =?utf-8?B?dVAxVDJ0UUtzVjBrN0dnaWhlL2d2M2NDckFoRTBMOEphVDl4enpZblU0MENu?=
 =?utf-8?B?QTBxZ2h4SjVhVWxsN1lSeEc5MVZBUVBNZ0xEbUdaMEk2dmFUODBuUFpCRVRX?=
 =?utf-8?B?VU5tanQ1L1UyR2pSY3BuZlpmUm1QbnIwYWx1L0tsVkRobXJGcGFyL1NqT29v?=
 =?utf-8?B?OVg2bVQ0anVwOGY0NzZ1UHRaVzJleXkyNTZydXpSY1ZNbGlETVJWdkVtNDlM?=
 =?utf-8?B?T3JrRkVlNmNhbHJlSmx6K0dSSHJUbUhMTzVKVkpsS0xJUkVJY0RKbDF1aEFS?=
 =?utf-8?B?Zk1ubjJ6MXloOWpmdDFJR0dzNko5VkZVaWlabWcxdmdtMkNXaWFRbVlFaWlE?=
 =?utf-8?B?YzdmV2JOOGxnN1hpdk52anNpV2NaYitPeUw0UGk4K3JVcS9FUVBJYmlxa0Ru?=
 =?utf-8?B?aWNQTFRUQWVYa2xRQ2RxOHZhOFJjMUFqNzZ6MXZuMDQ3Q25BbEk1TGdhWEtz?=
 =?utf-8?B?VzNrYkFiRENQT2R0TXVJcitUanhaNmd1MGg3YjNPeEs0bnRsZEdLb0tpY0F4?=
 =?utf-8?B?blYyZ3VZcmM3bmErWTFBcmZMaXlGZitOWW5HQzRCL1poUWZHazcxQy9OU0No?=
 =?utf-8?B?eE5yVUdaN1RMenFzdGduTkN1N1ZaUkZFZ0FIa3ZJSnRhRmdZVDNrbDhiOE4z?=
 =?utf-8?B?QmJKUFZvbHRaWCs1VW5WSlN3a2VQdUNUSXhseHp1VFJlUERlSG9lVXVhd09M?=
 =?utf-8?B?d1NWODlKUjk0YVBiZVBHWUtIZDZPb0s4N1AxKzIyMHUwMm1wZERDdGcwcktz?=
 =?utf-8?B?aGNCbWhqZE1NUjdKZWE5aFcwK2NUVHZhSXBVSmE0YVNWTVpRb3Y1dnlYeFNi?=
 =?utf-8?B?clpNaFpSK2pobG1qdkw5ZWtwWTdRQ0t0SXZ6VnhsdnY5WVB1a1N1VjJwZlM4?=
 =?utf-8?B?ZWg2UmllUy82ZVl1SndyY05PNVByUmwvbE5CWW4wTjcwQXljTkI4QW01eUox?=
 =?utf-8?B?VDVDUjdJdnVZaVlLTFhSc0cwZ09zMk1uUUU2clE0My9GWDNRc1Z0ZWtSVkJJ?=
 =?utf-8?B?cE5vbHR1UnNzak40UHZ1NHhNalJWQjRpcm1iZ3QvS2hRTS9GYm9iTzNqTy9n?=
 =?utf-8?B?TjZoWDhWT2ZFcThtNVNjK1RmcSs2cFBXV3ZCcVFObEFqL003UlRua1NseW9T?=
 =?utf-8?B?a0l6SnhWYkNROUY5TDRMTWRrb2FKNm5NaGxMRm9yMGMveUFYWnZwTHhic2x6?=
 =?utf-8?B?MFEzZjY1VDV5WkJodStnTTVkaEhSRXFPSFJBamZwSTZDSWNaTVlJOWFxWkJS?=
 =?utf-8?B?NXlyMXMyL05TNFVrZHh2OEZkTXBkZ1E5Z09BN244MU9DakFvZTZVNzhRL3pM?=
 =?utf-8?Q?u36V5EFCLpDy1UPdAHFQa/6hZ?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a4aa2-70a7-4a2f-8681-08dd90f43df2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:04.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf/7wqgwhp/S9CzWnxLoTevts2x59TG+EPXhzLmLZNcEk2y8ixe1YEiyJykKeYRqKRnryWESq0BQeuFIk9Rn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: P1ePiCP7e8EwKgYrPn2Wa7jvvpJV5KCR
X-Proofpoint-ORIG-GUID: P1ePiCP7e8EwKgYrPn2Wa7jvvpJV5KCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX8wX8N86pgMLW vIEt3m8NwieQB+eQ8DtzpD+6w+/bm8bFtshEGHh54zH1sg/F0LlV2jCjC+aT4l7u4y/0R9knVlE W1y2xVuuULmM5/GRCmrcIo9mgIewEDuH8PPekBXJTGnnPeqsch43ejAyPqQu0fKrToeBnSewHVQ
 L4vZvOOlrfQoqrYeBApczlJB+Kxs0Ek2RBK4n3xw1ZPIaU+kwHGewbjK84NwJNMhX4lpxa+Dw5h LY2KlC65Xlbj4qa5OmQICEYxBbvvcWeAFZGdrX8+Mp3Vk66U9zXaeK1mwO2rAAuNRfktmCcrUhm oSEwMBSsJxaOrODyvn+HT+0cRDA+TX4OG2zfgN4Yx0f2UU9k1JsvGcFRxxN85WQ+KqG6xjqrX5L
 sPGkE36D6yVRm4Ujy1Cj/dHfM1O7xqjMWBNC871rzW4u+zcM/du8GL8Kxz1LMnN40vWS7QPp
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea8 cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=HXJrTte0tiLIOPi1Ik8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=991
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Reset frames are used to either disconnect an endpoint or to signal that
a frame is targeting an endpoint that is not connected.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h       |  1 +
 drivers/net/cpc/endpoint.c  | 16 ++++++++++++----
 drivers/net/cpc/interface.c |  9 ++++++++-
 drivers/net/cpc/protocol.c  | 32 +++++++++++++++++++++++++++++++-
 drivers/net/cpc/protocol.h  |  2 ++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index d316fce4ad7..34ee519d907 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -94,6 +94,7 @@ struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const c
 void cpc_endpoint_unregister(struct cpc_endpoint *ep);
 
 int cpc_endpoint_connect(struct cpc_endpoint *ep);
+void __cpc_endpoint_disconnect(struct cpc_endpoint *ep, bool send_rst);
 void cpc_endpoint_disconnect(struct cpc_endpoint *ep);
 int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb);
 void cpc_endpoint_set_ops(struct cpc_endpoint *ep, struct cpc_endpoint_ops *ops);
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index e6b2793d842..7e2f623fb8e 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -253,6 +253,17 @@ int cpc_endpoint_connect(struct cpc_endpoint *ep)
 	return err;
 }
 
+void __cpc_endpoint_disconnect(struct cpc_endpoint *ep, bool send_rst)
+{
+	if (!test_and_clear_bit(CPC_ENDPOINT_UP, &ep->flags))
+		return;
+
+	cpc_interface_remove_rx_endpoint(ep);
+
+	if (send_rst)
+		cpc_protocol_send_rst(ep->intf, ep->id);
+}
+
 /**
  * cpc_endpoint_disconnect - Disconnect endpoint from remote.
  * @ep: Endpoint handle.
@@ -264,10 +275,7 @@ int cpc_endpoint_connect(struct cpc_endpoint *ep)
  */
 void cpc_endpoint_disconnect(struct cpc_endpoint *ep)
 {
-	if (!test_and_clear_bit(CPC_ENDPOINT_UP, &ep->flags))
-		return;
-
-	cpc_interface_remove_rx_endpoint(ep);
+	__cpc_endpoint_disconnect(ep, true);
 }
 
 /**
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index d6b04588a61..30e7976355c 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -28,6 +28,10 @@ static void cpc_interface_rx_work(struct work_struct *work)
 
 		ep = cpc_interface_get_endpoint(intf, ep_id);
 		if (!ep) {
+			if (type != CPC_FRAME_TYPE_RST) {
+				dev_dbg(&intf->dev, "ep%u not allocated (%d)\n", ep_id, type);
+				cpc_protocol_send_rst(intf, ep_id);
+			}
 			kfree_skb(skb);
 			continue;
 		}
@@ -39,8 +43,11 @@ static void cpc_interface_rx_work(struct work_struct *work)
 		case CPC_FRAME_TYPE_SYN:
 			cpc_protocol_on_syn(ep, skb);
 			break;
-		default:
+		case CPC_FRAME_TYPE_RST:
+			dev_dbg(&ep->dev, "reset\n");
 			kfree_skb(skb);
+			cpc_protocol_on_rst(ep);
+			break;
 		}
 
 		cpc_endpoint_put(ep);
diff --git a/drivers/net/cpc/protocol.c b/drivers/net/cpc/protocol.c
index db7ac0dc066..faacd0f42ad 100644
--- a/drivers/net/cpc/protocol.c
+++ b/drivers/net/cpc/protocol.c
@@ -60,6 +60,28 @@ static void __cpc_protocol_send_ack(struct cpc_endpoint *ep)
 	cpc_interface_send_frame(ep->intf, skb);
 }
 
+/**
+ * cpc_protocol_send_rst - send a RST frame
+ * @intf: interface pointer
+ * @ep_id: endpoint id
+ */
+void cpc_protocol_send_rst(struct cpc_interface *intf, u8 ep_id)
+{
+	struct cpc_header hdr = {
+		.ctrl = cpc_header_get_ctrl(CPC_FRAME_TYPE_RST, false),
+		.ep_id = ep_id,
+	};
+	struct sk_buff *skb;
+
+	skb = cpc_skb_alloc(0, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
+	cpc_interface_send_frame(intf, skb);
+}
+
 static void cpc_protocol_on_tx_complete(struct sk_buff *skb)
 {
 	struct cpc_endpoint *ep = cpc_skb_get_ctx(skb);
@@ -228,8 +250,11 @@ void cpc_protocol_on_syn(struct cpc_endpoint *ep, struct sk_buff *skb)
 {
 	mutex_lock(&ep->tcb.lock);
 
-	if (!__cpc_protocol_is_syn_ack_valid(ep, skb))
+	if (!__cpc_protocol_is_syn_ack_valid(ep, skb)) {
+		cpc_protocol_send_rst(ep->intf, ep->id);
+
 		goto out;
+	}
 
 	__cpc_protocol_receive_ack(ep,
 				   cpc_header_get_recv_wnd(skb->data),
@@ -253,6 +278,11 @@ void cpc_protocol_on_syn(struct cpc_endpoint *ep, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+void cpc_protocol_on_rst(struct cpc_endpoint *ep)
+{
+	__cpc_endpoint_disconnect(ep, false);
+}
+
 /**
  * __cpc_protocol_write() - Write a frame.
  * @ep: Endpoint handle.
diff --git a/drivers/net/cpc/protocol.h b/drivers/net/cpc/protocol.h
index e67f0f6d025..977bb7c1450 100644
--- a/drivers/net/cpc/protocol.h
+++ b/drivers/net/cpc/protocol.h
@@ -19,7 +19,9 @@ int __cpc_protocol_write(struct cpc_endpoint *ep, struct cpc_header *hdr, struct
 
 void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb);
 void cpc_protocol_on_syn(struct cpc_endpoint *ep, struct sk_buff *skb);
+void cpc_protocol_on_rst(struct cpc_endpoint *ep);
 
+void cpc_protocol_send_rst(struct cpc_interface *intf, u8 ep_id);
 int cpc_protocol_send_syn(struct cpc_endpoint *ep);
 
 #endif
-- 
2.49.0


