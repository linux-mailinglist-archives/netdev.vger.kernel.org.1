Return-Path: <netdev+bounces-231336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7347FBF7A0D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B938F3A8F5F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C87342C95;
	Tue, 21 Oct 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SI2uHd3r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AB33C51B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063520; cv=fail; b=TOjBuMkM31bhXfTYdEtF1I5NQw6MCbqt9VrQBsTNEDFMMtHnj+8pRQbUnel/VdbV6EJAU0lh3pQp1q6o6SL8cr7XfGTqDj5Z9ENblGlO2DGmEM+wLXJ84nFN6lOWHoz4mM2xhwm7ZvywNE9sJPvxoo5YBVUSBbstRxbM7OfoyDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063520; c=relaxed/simple;
	bh=Zy6Yd43dRiZTJvzuYEWzfXCt9A1tp0AaQ4wuR7EZJgw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=le33rF1kofgqR/iWv77F1AmvRfr5yPRLnuLe/A9EdI1tRN2bvwLP3yHPBSIG12Ct4wVMXa+xatsmD2/AfYBCYsS3helKQAWTpBQkhja2kRpiP4zYBoMLpkN/pakNOflfvZvCxheZLiTmyAoBcTrw33EqYPoycC69gVFollMl1kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SI2uHd3r; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8GsiB017546;
	Tue, 21 Oct 2025 16:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5gs8P9
	eTnvx3vbctXF3u1ijPS/iLvmXyKoxTQfgx1/s=; b=SI2uHd3rShI3ZxGgTWytUl
	XfmIeZH1LO/41jR5jFfGpYxppSatw2t/b6OxgTDHa9dqLGqQQuTJKDVuaHYXWmeI
	TbD7RgWuBjtr5op+G8EmDYPGLBpWVy8ZoNZNVThInUEmjmg+6RaeB3FoQ7wNxrSd
	ocVfxiSovR88jGJWJv6zOSJ3y9rvXb1DWIKNxt38Nj0pCvO3SMLbyOT0XmQ8oI/H
	oIcKor8XzJpdRN8x8sNUejDbHmVAVUKOk521qy8VvGf/vHs4PWfEuCZ6jcHARge4
	Wd2vba8qc6vAIhW7D+0YUGG/pJYKTPQJL7R4oXRtE0BOmlBpQQQzeDF6Jpj16aZg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f82u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:18:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LGCwTr017901;
	Tue, 21 Oct 2025 16:18:25 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f82ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:18:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOhaZdU9XBq2/r2c2XBAev9UuTLuBJDKT9345NtguoCUIg4oFYOS066uZb4p89zAA7lnb47QrBWmumxNVZaKVKFqJW0ybru/Y0bOoY5vGS+ZG5eZiIzj27xWhb1lVIQdrXFSls13GtDShRu/zhvAB4pvpcPCn/NGtISOOI/Ne3OZRbYf7cFonr9i3HNWydg21BtiKfhekH86ZSpVBwb0au0hbd3xxZZ1ukcMulTFobJpeb9VG2aqTTakRUc8kHR5gTGG8C6K/cyV3AXWKqigmEzq9bQG22tuAxfYwvFEV9Ym3gNh9pxR/4b+QVbWUL6xoyUZOdsqpSaQPzOsZD7Sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gs8P9eTnvx3vbctXF3u1ijPS/iLvmXyKoxTQfgx1/s=;
 b=spVzTGTfpE8dCwIuXUY9MCztvz//Qbt0oke5c7AfclIhd8KT78T3hIU72kvDbntr2bWJHo929R3v/8Er3FIzFUMjgH0TzbxFJEYDoLDfLCryl7ATVzaW6Fitf3rbipab0hDRNENbgCnhsGEKmsi1qp/9t5HUKVypaolAPQAyAHvLn/ecwFQ25jIL5ZV7mdvcyAjl/v0X4QK7XINAPUsv/XwlEegog2Eri0tpDbmqC5AiR2YD2BVFvoa7Fjb1dSWWyYZFUMImJUFlk1nkwSraHirveMkfCnGKP9b5lV7oRXioA5K0/YnkLWVHcCjHDMJCm/7Dpb9n2EQjLLDZrvflbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SA6PR15MB6594.namprd15.prod.outlook.com (2603:10b6:806:410::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:18:21 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:18:21 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com" <edumazet@google.com>,
        Nikolay Aleksandrov
	<razor@blackwall.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for
 extended arp_ip_target format.
Thread-Index: AQHcPJyjleye9we4VUOHrCeB+8OXEbTErQUAgACFoACAAD2pHoAHVm95gAALQ2o=
Date: Tue, 21 Oct 2025 16:18:21 +0000
Message-ID:
 <MW3PR15MB39130C39ACD2718F927B725EFAF2A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
	<20251013235328.1289410-7-wilder@us.ibm.com>
	<ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
 <20251016124908.759bbb63@kernel.org>
 <MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
 <MW3PR15MB3913D2F92582A3FB369D5FA2FAF2A@MW3PR15MB3913.namprd15.prod.outlook.com>
In-Reply-To:
 <MW3PR15MB3913D2F92582A3FB369D5FA2FAF2A@MW3PR15MB3913.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SA6PR15MB6594:EE_
x-ms-office365-filtering-correlation-id: 1b1a45d5-f562-4b58-e2dd-08de10bd73e9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5DByJV2blKwtreYdTCOevZpkawYsTF6ogN477nhw4u35MJw1P94L7cSu7r?=
 =?iso-8859-1?Q?rZGwbL2IEOIZhXYNuUPKzhwhfazE6z5IN5Bm1S07DlBCclgrGHZzgxDKws?=
 =?iso-8859-1?Q?mhwo2MQ3OjiQ6/nzcTVQvClwuUgfI9fm01EPxC1tRs+12zpLx1BtlLxo1k?=
 =?iso-8859-1?Q?BGH0sdVUqPl0KtDY8zmqJOSerrSs7MCLNjk/g7OgsyDVoXnkjums/wpaCC?=
 =?iso-8859-1?Q?ckF2WqDIzYWUyrsa83yVWUdwtMz91o4nGrxpdX7HQc2V7kgEYnL5+vXaQc?=
 =?iso-8859-1?Q?HZo7CNkczTjJKRHESNyKYst2oBMl9PJmioFNiBlxoapw9AuYxJo32pGB4P?=
 =?iso-8859-1?Q?Yd5jGVH84y5eLepjUgqgBu1a9LOskUSPCd03Om3FniifLJUCcMUXbJ61Y8?=
 =?iso-8859-1?Q?te5AJescjEpD4RYD+OtRR8E5+Y7k15I5d0QAAMHt6d+w9+YivwL7dU+jrF?=
 =?iso-8859-1?Q?OwtQAG7T0NHvii25u1aDPrTkytkGvYGTDzu4nvLgrRVUwnTJjAnxkuE+VW?=
 =?iso-8859-1?Q?1o1XBs+e/RIuY0vQgOmik2XcuMUF1tpbKkUXjKO15dVVp2UyQRoNHDvmSb?=
 =?iso-8859-1?Q?sfXupyjh4CpLxAMqMTjqhZAtoHBocPhD0kNIuY6B5CCVKjWMIcLMcBX6YI?=
 =?iso-8859-1?Q?Y6t9s399qm3jp8zwljTFzY05UkyVsPoR66mrLdwHxWUCsOIaGVh0NfSNJK?=
 =?iso-8859-1?Q?Y4XtTUo/ThPxDl45DP8M8rVkX6f5rfViMhQyYub1rJgFY5CCpsz6RIWQ9Z?=
 =?iso-8859-1?Q?nMTmzzrowZu+fyn6W50hfNSt5zfeR4E9vL3k+GRH4MqnjjJkAblgm9RDSt?=
 =?iso-8859-1?Q?4JZfkFLJ1UmOb09nxEsgHwR7pk9U/sjGkGszk9NVpWp9l7Bf3M3t0qhS9t?=
 =?iso-8859-1?Q?7HQDCM2C0m6n45dLuOxPXp5pdAYnSrutd50hSQfzpNaTRKAAnQ4FGSeStU?=
 =?iso-8859-1?Q?gP60vGfFTGFvG463pvLv6AaBfLC41l4+KkIyQNsdONv53ed6JQ52rppWNy?=
 =?iso-8859-1?Q?IUveK5+VLifNybQbOoP8HstpOV4z3eUf/FElF8TzqCB1wp6wjTgXFTsWoC?=
 =?iso-8859-1?Q?LhqRY7RZkVLkmYat2VbfzYqn65WabJu+Ay+voar0F3R8xT53BN+88Xeesu?=
 =?iso-8859-1?Q?pun2GMA9h0+zXkLJIf4fj9lZtwQgJEt99Plt0OId8msJRz8+nPSTACXCRb?=
 =?iso-8859-1?Q?91rchFiRHoj7RstNoVDc0DDq2iBiEyuP8o2V3MloieGVN/b61Q1ESBhCCS?=
 =?iso-8859-1?Q?AJdF7pdt0gXb+Zyl3t2nIidWoIdFgnCfbU17ECFzj7i6Q/aK1Oyoor/71/?=
 =?iso-8859-1?Q?0LeOqP7t6DXc9xfmMK59c4YDz8qHO+pKcC0lLSCRcMSelXfs0HkTBoEL3q?=
 =?iso-8859-1?Q?tUjWNB1+/SVRbAfK8omPtHCBOeAvS3egNt+V0Bi6ca4hJOZuUhSplH8EyT?=
 =?iso-8859-1?Q?iJzn7q6tjl2HWPJv7bx1wBy3XoBJ4DDk9Nnt2KYgjOjOSbfWkl817Dt1d4?=
 =?iso-8859-1?Q?BgQ4WA8LkIiA1b7X7TVtmvSfzHg/Eb2alvctGYB5eM3vWJ6j3Dggs7hEfB?=
 =?iso-8859-1?Q?NW75uJuzPMwzgLAP/YhqI92Si/RX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d3f46jY7Gku5DcIAKEspcVhI5Lose1bcYC2DZfTlha6yHCbBFkLM+V56NH?=
 =?iso-8859-1?Q?0HxxEJccOJdNuzrY7i45vf9pbhHEmgzNO7DzGTGsg7qbzWtl0JWQjLiV3V?=
 =?iso-8859-1?Q?JG+O9XnzkoCDFQa4IPSLgwWT/cVK3W4h5Z5a8Y5VWEhQETrRtg4yeVJaBK?=
 =?iso-8859-1?Q?XlDcPpscgjita96Khk091+/MhHGRozzBW98ByayPsE88zE1fFPNwnbG4wI?=
 =?iso-8859-1?Q?GfM4+fNPu7QKTjg6w5edaxa/74Bx4YB+ggrbHuSTDdjIBzHkQXmqVrLcaq?=
 =?iso-8859-1?Q?eQVi9ak/TebUnCFt+ljJtZVX60/PA4MNkpGTzxAaIdBdrcZzaKyUk6m2xc?=
 =?iso-8859-1?Q?h40+6LGIu0b7K3RL30NKEygVYpsDJXtHc9zVXddwAyD0y/rlAIqTyNNtym?=
 =?iso-8859-1?Q?4i8l1+SOJKgB9ygXCUFY56P5f9ObHBS5zrXAZB+5/lYGt/Q/VB0oE5CanL?=
 =?iso-8859-1?Q?teDUMZt9JBu3BwrQIeszymbQp9J4hJoCzCMcZBd4yoHXMJbYb9MKkNDBtd?=
 =?iso-8859-1?Q?N+13aqA4BT4eZFo9XSftDmmJX/cY43pyoynGLJbFAYCGzXUW8Yw17PUNsP?=
 =?iso-8859-1?Q?pv2jywvaeQ542cU+fLVixNXOjYoFEXSjV3g0A10GsQWoaF39a2IEBq9jfx?=
 =?iso-8859-1?Q?tfGm53giobN21km7eGmxB91Sg0qy1QxPer3x7VXcsaHFGf419S2JHp5NKW?=
 =?iso-8859-1?Q?FzfXoliTZV7xnFwM/H7EUscdTDHjjT+mNY0o9f0RSfoWxOCE6BsgczfZP2?=
 =?iso-8859-1?Q?/hvKhDVVE7nCvgQS0jrOVDRF0R4MAbs7nyKSBW0P7CaEcrcYxIA+WEupNA?=
 =?iso-8859-1?Q?FZQmktgGmOuN1G3uVREort4M3plScjOJhVEMMwyVJcpRsmoJR5qq2sRuvz?=
 =?iso-8859-1?Q?k/t0+gHImhrlFJ0eN3SC5cAwNYb1crhsaqNJEd2oxgWOyNCEAYbR0r/k3w?=
 =?iso-8859-1?Q?1QVXpx6MWHzP1bnbQdVvPptcfz57mnQz2wN6K7qgfDtRhPgfnf++Fs6K7h?=
 =?iso-8859-1?Q?XtpHfJf9ScvIgbj1kZHqXQ/kCkLrX9ZXRbc9Dk/Jwx7fH+zkGuc2JGwikb?=
 =?iso-8859-1?Q?p4wVqHFvVxASmN+JIt9MxDezHzYikJW4JwTorbKz+64cItpUfyOQXzAfHm?=
 =?iso-8859-1?Q?pB8rFyxhwbKdXGbj5zZBL7YJs1Z4A3Hv0p/3gV19LmgDJUwCqu+8+P0y8a?=
 =?iso-8859-1?Q?Xwx5wNFEgc9UtGHeDmh6ccZN0yZnC5ZTA0OGd+Q1qditloaRyJa/s2Dm94?=
 =?iso-8859-1?Q?rbVoHVbJR6+le7LEruuAJBMF8Cb8177XW3VL+XaNz9I2638tw4zE2jh4J6?=
 =?iso-8859-1?Q?Fq/QO+WmIV7YBWmZ6RTsdhOmLjGPNWqFdttJyLYWb3xu/+yYnwrFPEsoEB?=
 =?iso-8859-1?Q?kZHAuAJBMpztAgb2gXWPf/K01jK5hyspGOZlnWmdGsrlTSl6vZZWIWNsny?=
 =?iso-8859-1?Q?OzqssQw/qVM9O+rZSJQiz3Eb0gX6fSo/3IuGyeNemlbsjidSY7I2uNu5gb?=
 =?iso-8859-1?Q?k8XALXV+f8Q+AxIELqCnnuAUj2poyKSuWgPXtNjBy8QRTj0X/on3xh2biI?=
 =?iso-8859-1?Q?0R4OKQGlgmUvTZGU4cXC7Oyx8mTFrfGn/nya6dAYoMqt5MDa4GKF26X3FM?=
 =?iso-8859-1?Q?2tUQA002sdy3EKI9jws34qJmGjPL/C1P7gvhmFjFXllG+MavG32UEDx4bg?=
 =?iso-8859-1?Q?iW1GncKANM3WFQ/Z1jA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1a45d5-f562-4b58-e2dd-08de10bd73e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 16:18:21.2656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EkyXXpoaA6VKyC/njnX+Tn6PrGq6wrKlYT7FY8m4VACgVFDpAc9E1SOQ5QfoSMYD10bDjXu21Kssf9A/BEmKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6594
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f7b252 cx=c_pps
 a=yvofFnGdSAaTKL5iNkS0vw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2OjVGFKQAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=1XWaLZrsAAAA:8
 a=jFq_gwtVQDHxNXWrUSMA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22
 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WDh-3rpFB5r3TM5gFuShXhuxlkywy6_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0NUMvxXXs1yO
 JOAIhk3TbaorfamJHVn8jNGrWUJ+ldD4sNeO7j1QKOaK/E37TFrA4ns+WrZwLdtXd4IOgmZ4oqg
 JH/yZgwtEDagwTS38dSxiOfJO91jtVwHolciMq0tuSpvIlWxNwoTxJx0wXeyz3FnYRLMi5iitAL
 5Ef0z9zvlnyDV99QfCoLC0jWuVwS4hHUOz4CkCTL8C0/bd2nlW+HS9YLzmuFw/loANR6tesayRJ
 8lZ3ujc/veG48cmsPZZZ9wX1af/fQefYvgpO8jVm5I5URfV5489mkVyZG3J4oey0LiTVO+i66iU
 8ZIHi2IjeEN6C0KDAbj3OmDz4j7mmNNZZAD/ZZZV/za42JiiIoZYAdUVgvDX5krObisX9mo24aY
 TivHttVpugndMvYL87TPj5vz6Q2FIw==
X-Proofpoint-ORIG-GUID: EOrOEmgsJ3gWnUvTUpT-Ahx8ljZBGJUj
Subject: RE: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

=0A=
=0A=
=0A=
________________________________________=0A=
From: David Wilder <wilder@us.ibm.com>=0A=
Sent: Tuesday, October 21, 2025 9:00 AM=0A=
To: Jakub Kicinski; Paolo Abeni=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; Pradeep Satyanarayana; i.maxi=
mets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumber.org=
; horms@kernel.org; andrew+netdev@lunn.ch; edumazet@google.com; Nikolay Ale=
ksandrov=0A=
Subject: Re: [EXTERNAL] Re: [PATCH net-next v13 6/7] bonding: Update for ex=
tended arp_ip_target format.=0A=
=0A=
=0A=
=0A=
>> On Thu, 16 Oct 2025 13:50:52 +0200 Paolo Abeni wrote:=0A=
>> > > +           if (nla_put(skb, i, size, &data))=0A=
>> > > +                   goto nla_put_failure;=0A=
>> > >     }=0A=
>> > >=0A=
>> > >     if (targets_added)=0A=
>> >=0A=
>> > I guess you should update bond_get_size() accordingly???=0A=
>> >=0A=
>> > Also changing the binary layout of an existing NL type does not feel=
=0A=
>> > safe. @Jakub: is that something we can safely allow?=0A=
>>=0A=
>> In general extending attributes is fine, but going from a scalar=0A=
>> to a struct is questionable. YNL for example will not allow it.=0A=
=0A=
> I am not sure I understand your concern. I have change the=0A=
> netlink socket payload from a fixed 4 bytes to a variable number of bytes=
.=0A=
> 4 bytes for ipv4 address followed by some number of bytes with the=0A=
> list of vlans, could be zero. Netlink sockets just need to be told the=0A=
> payload size.  Or have I missed the point?=0A=
=0A=
> Is the concern here the variable size of the payload?=0A=
>=0A=
> I have updated bond_get_size() to use the maximum size of the payload so =
the payload allocation should correct :=0A=
=0A=
** Correction: =0A=
+struct bond_arp_ip_target_payload {=0A=
+       __be32 addr;=0A=
+       struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];=0A=
+} __packed;=0A=
+=0A=
                                                /* IFLA_BOND_ARP_IP_TARGET =
*/=0A=
                nla_total_size(sizeof(struct nlattr)) +=0A=
-               nla_total_size(sizeof(u32)) * BOND_MAX_ARP_TARGETS +=0A=
+               nla_total_size(sizeof(struct bond_arp_ip_target_payload)) *=
 BOND_MAX_ARP_TARGETS +=0A=
=0A=
>>>=0A=
>>> I haven't looked at the series more closely until now.=0A=
>>>=0A=
>>> Why are there multiple vlan tags per target?=0A=
>>=0A=
>> You can have a vlan inside a vlan, the original arp_ip_target=0A=
>> option code supported this.=0A=
>>=0A=
>>>=0A=
>>> Is this configuration really something we should support in the kernel?=
=0A=
>>> IDK how much we should push "OvS-compatibility" into other parts of the=
=0A=
>>> stack. If user knows that they have to apply this funny configuration=
=0A=
>>> on the bond maybe they should just arp from user space?=0A=
>=0A=
>> This change is not just for compatibility with OVS. Ilya Maximets pointe=
d out:=0A=
>> "..this is true not only for OVS.  You can add various TC qdiscs onto th=
e=0A=
>> interface that will break all those assumptions as well, for example.  L=
oaded=0A=
>> BPF/XDP programs will too."=0A=
>=0A=
>> When using the arp_ip_target option the bond driver must discover what=
=0A=
>> vlans are in the path to the target. These special arps must be generate=
d by=0A=
>> the bonding driver to know what bonded slave the packets is to sent and=
=0A=
>> received on and at what frequency.=0A=
>>=0A=
>> When the the arp_ip_target feature was first introduced discovering vlan=
s in the=0A=
>> path to the target was easy by following the linked net_devices. As our=
=0A=
>> networking code has evolved this is no longer possible with all configur=
ations=0A=
>> as Ilya pointed out.  What I have done is provide alternate way to provi=
de the=0A=
>> list of vlans so this desirable feature can continue to function.=0A=
>=0A=
> Regards=0A=
>  David Wilder=0A=

