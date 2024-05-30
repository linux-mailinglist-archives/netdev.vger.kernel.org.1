Return-Path: <netdev+bounces-99445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A8B8D4E78
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C47B22193
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91C17D371;
	Thu, 30 May 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TWGQuE2I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="gTUq3wfm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC3145A01
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081081; cv=fail; b=AqsVTiEymgNd2+VKKUY9lophFXUtZgFTk7F3JNHjwLIojOIutlBBBt1EAvNJfDsCpeTiFT/VatwksdNCWqjOpPRNIoQ7YXoj6s3aI5M9jQOMyu+HvSPlBjyQyMqoZmmZPVonPHPB6bSBPgJrIlM9wwyli74fLO1nrsyrJHXq28Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081081; c=relaxed/simple;
	bh=aDZKNrBXAlOuR9HC3GDc4tZhtR9sr0kR3LpuSzGLT98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rizbg6Jw7kzLtPSoMBWtJnY3C5bzXxpr1W28aSKhAW1krgcoyVqsMaemSR6sBEoS7QdWbg1nQcrmPv5v366NfDj6ieh/e60t22sOOmjx6ehSayA5fjtLiVYNuc4K7/tZVu9htvV6DFCUDM+wSzfRFzKlzU/nFYLE7wl3y2wdrIg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TWGQuE2I; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=gTUq3wfm reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=aK59OPyMgpFfDveXqEz55B03IUswPnEbOXWJM9Bh4K0dS0vR85w/CsytMfsRMooCDJdVXpIpAKKLXqrc+hOT9o70zUJ9j3loeksJ9h/4DoepDJ/cFA+bUKBi3VddGPu3AsmLyTOgurh07fIbZ6hHc6zLJ5g1SbNLUEC1ro3ktTDNW+BHbxfVkHksuE0uiHvHkxU6JLD7p+0BqMUCLs6mwMiG77113yN+rXdP6a5djRRIKDjFj0hFfwOis964gy4eFweuAfCr8XvzUSlcWYdKhwHqnQ50ArdFMAEZORWm8KyxERfnuUckCX2+ryVcNDUt+C8oNwelUZscPX4XOlYisw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGWFo1UaR8T1fC4XetydtI//Emdw+N6vg1f8Ui8wnHU=;
 b=HBS8FKaqBuCUx/AVrvrss74dx9PIkhtEBzm/i1iNpjRDdsjtHWOQYt+8Fh2/0sQ0bjb8uV98in2B6IuD8NhBOj2MyfZklCEvvKsHqNfLwkcoP/ARUr0TIJaTa3inOxpl10rAfWeDEZrUgwbPR0mdTxOj9gtT+GsfWB5SXsTbNangpw3R3OldFKf0ikfkI3f9wtaGaDXkufl+K48lbod3bQMl7ZdCSA+Gthdxa0fqZTYM8Koqr8rGjRNY3ymHdnAGlDA2vXurvnE3pEJjYR3HU8gEiwvBDV6PFqrTDdi7mhWjz8jq7dZ14X9TFJaaPFMZUKxu0OfbVUmOUInAZWTmyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGWFo1UaR8T1fC4XetydtI//Emdw+N6vg1f8Ui8wnHU=;
 b=TWGQuE2IwmbvF9hrO0Oe+K/tWarfD6ST3HV5kwugKGovshrAwrzLR23hUZKoBAiMWm1IXhtseeLJytFC1lonA75JPLAzfUBfoy/MPDHNACPlCWpwKK1r526Iyoi8HURcoKF86U+mHAAXF3Xl8OKqm4T16pYMYjd5NeZ5L9NUG8AB79SGYAs/zJMgPTS3N1BQbDrqSDrXJUbOpmbjtE6XUGEpQUgJ14DbsAAAIxqQzZtSTbEcnHd14PG6cU6/YWzsQEZO9c0KHJpQHqGxmgXbhm/4Nh4u346pzLrwaZsoVZsEXrsigMVlOShq5LbNa4Z5+3BfVJUrppUbw8OrbDXatQ==
Received: from DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) by PA6PR03MB10467.eurprd03.prod.outlook.com
 (2603:10a6:102:3d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Thu, 30 May
 2024 14:57:53 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::2d) by DUZPR01CA0303.outlook.office365.com
 (2603:10a6:10:4b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 14:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Thu, 30 May 2024 14:57:53 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id D166720080F8F;
	Thu, 30 May 2024 14:57:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id DB4082008006E;
	Thu, 30 May 2024 14:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhmRq7ZnfsUC/p64DI9mEEi1xDcr2i45SEAcdBLoyn8jH+oIxGVFcsDLLiieqaiGIL9yOF9xfmEswfQ+gPa3ooz98bw8oogyoFMwbxmuPV+Y6AmmNBNoujUWcw+tU/ulIX/9DxvE7huR349CjC72X+2fyp/4C9Ag9N4fAn2fk86LkSr5NEyHudDDBOPx5SU9imIWKcIW7Hrtq9R6T0Pe0SQQBuWmEGmwtRqvF4Ykq+0r9FG4qBGJH8ptRWwtBRHBUEiXn02VIQyx+Mf+IuE2LhiR4QdVwcxl5pvhViRdiakAybOMbru73t3f4+J0PrCA1O2B3MPukE39p5pDEo/lXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZKXWzNQlcZxUZdh9h5SlQGU8585daXBc4dUfuP0e04=;
 b=Di4Dt2E4FGJp4IgP57Ehx1GX6aL3Jx8hyYd91MCRKIm30cxK1FGXQP3tqxTXbtso5l4hqeewEptwa8hiumBzSUfNwazgSbwgFBWkmbpMYdL7L3iZ0FuR1RbusLdK6G1pUcbLPtg7LDa8YeXOQt2iIvekCt3Blwjf/PpWqMaKUWOG22GncJ+psFRnz9sEeJZj6Cx1azeEabKkOXOU0OP1RcyIEMmeSiaDE/5n/aCOCzMv9sJJS06Wb1KcpMXdNGw0Fvu7lqEGtQ9Q16jxIG3US5sYOIWBiIhDKd2K5P/adDs9y8Vsvd+cPLZoo1/Ne6ZB641VKfZX01yMiGlz+ovUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZKXWzNQlcZxUZdh9h5SlQGU8585daXBc4dUfuP0e04=;
 b=gTUq3wfm/HCstOj7D/ObnQl6GebZADc8HInqGXgi9dMe/dGlT2okroRUeboy1z3l2Xl110w0FwxBkux9pRzcaBSWe/KA1Ul+rcihLZLgcf7omLPIMMbzUWBTZhWjY8EFJIZWgwRju+t1oNmf1cghDVFlt3o/roTAlHhX5gpwr0SRzBaHVMRRsfkvYbl80qmmkPjKmvrzmKSxcof5Wz5904XQ/uSOvMVYvc79XaOwkfnTl2bwkHe9J5rRtGft6umlWlxY+Mg8f/g8Dycx8xfYffM21ZvQZ877GMkrAIJZfsdWhQQn34z73AN7BSzVx27TSiO3W6IB4DEyXxDuEwpXCA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU4PR03MB10862.eurprd03.prod.outlook.com (2603:10a6:10:582::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 14:57:48 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::3acf:6b06:23c3:6cfa]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::3acf:6b06:23c3:6cfa%6]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 14:57:48 +0000
Message-ID: <9d77af3f-997a-45cf-873d-79b912a15f72@seco.com>
Date: Thu, 30 May 2024 10:57:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: fman_memac: remove the now unnecessary
 checking for fixed-link
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
 Serge Semin <fancer.lancer@gmail.com>, Madalin Bucur
 <madalin.bucur@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
 <E1sCJN1-00Ecr7-02@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <E1sCJN1-00Ecr7-02@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:335::9) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DU4PR03MB10862:EE_|DB1PEPF000509E6:EE_|PA6PR03MB10467:EE_
X-MS-Office365-Filtering-Correlation-Id: fd48c3d8-a63e-46a9-d7b7-08dc80b8e1e9
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aEliL1VvcDFrQjJjU1lObnAxZlVLMU82YzdMbDFENS9KUHlMS2NiWDh1cXV6?=
 =?utf-8?B?S25LMjdHQWdIdXJUemNualRkWGw3ajFMTllGRFZoVy9JM1JMR1FHUWhrdmM1?=
 =?utf-8?B?UDBuY0sxblBCTjFac2pLRkRoa0x5S0ZKU1o5WXY2TDNkWDE5S3hoelR1dXdN?=
 =?utf-8?B?aXFRS0pBSDlBQUV4OU5LeUJBbW04bFRNQkJsWWcyb1ZlRFowS1poUHJZZVlY?=
 =?utf-8?B?YjRIUlVJVERiNllZZis0SzRKd3BhcVU1T1NSV2EzMnNBaFBXWTUxTmt5ZC9i?=
 =?utf-8?B?QnNDUWdraVVGSjhQN3MrTFZ1UGZiNTRJOFJwYU1KcVd1ajBja09hbzBYSDM5?=
 =?utf-8?B?djVYdTB2WGRFQ2t3eURzYlZjRnNCdTN1ekIxU2psdGhNSis2Z1ZjV0Q1QmdH?=
 =?utf-8?B?YkRBVEhsRlFvbWNmSEllWWVFc2xQam10Ti9zN3BERkU5Sk9aVU1EM3hWMXNB?=
 =?utf-8?B?K3p2TlhKVllZbFd6Q213QytYS1p4eG53bGtPUERsSTB1aTdHaVBtU2RiMm9O?=
 =?utf-8?B?N2YxVitGQWhEWEVTR1QyK1c0NXVCUWh0d3BXc3Mwc2F1UjhPQ3pTc2VBZW0w?=
 =?utf-8?B?ZXNTMTJyaDhOU0ZNMHU2YXFlRGxWVzNiWHNnVjA4Z2h4R2VVbU5aQTcxaDhX?=
 =?utf-8?B?TVoyOTJqd2Q4cjkxWldrVGJ2MHcvWkNEbGllWXpTQS80akJCbzRjYnpFN3kr?=
 =?utf-8?B?WHdkaTA2T0J3UzZQZlMvRHpQeHdUZ290N00rUEhCT25HdHd4d3RoOWlSc1NV?=
 =?utf-8?B?SHNVM0kwdytjamEwL2NqM1kxZVVJTGZVVGtLTzNjTi85MnRmUmZTdnNReE8z?=
 =?utf-8?B?S0VvSGVaVnU0R2hycWc1ZDlPazFEcXc2Y1pWajNPd2J4QzlxWWhseFpoZUU2?=
 =?utf-8?B?b0RmVmd0d0JiZjNqWHg1bVFPenZmdFdOMWxUSHM2KzJ4QUNQNlV0M0ViV0Uy?=
 =?utf-8?B?bVE2ajlUOFNOcGVIc3NQZVIwNDVjUnJNVlljeW95VjR2NjlZRW1ibVdnYUZU?=
 =?utf-8?B?OWYzQU1ycHRRcmwyRjVsMDBCMjZzdDhMOWgyZjJ3b3VYU0ozTkFIWlNaNTNr?=
 =?utf-8?B?cXcxdGxGSnlONjhRRFd0WjFhaHpPMTdJV3RXRTdCYXVFVU0yTW9GVC8wditC?=
 =?utf-8?B?bTVDL0Y2elo5RmhVVTJUKzllcDRMT2ZFVEtHZWtkNEZnZjhYbHdiQ0R6djNn?=
 =?utf-8?B?YUF3SmVYR0JTaHZZL1pnS05UMFdQR1lJS3k0U2VaN1A5cmJzQ0JmRHFib01O?=
 =?utf-8?B?bDd4REZUdHE3T3JGUjYxRFF3VXBLZnZDQnlWdlBTNmFMdDZIZGlNajhzNmg1?=
 =?utf-8?B?a3AxQWRVWXArZ0RtbUwxbVBHN3VoS3l2d2kxanlnMmxLSnBNV2o1MC9IWnho?=
 =?utf-8?B?TFZCL1hnUnh3NVBzWld1MWtZN2FWVFpaVUFDZ3RvSExVMUVhY3pudnRrWmJr?=
 =?utf-8?B?a3ZPOXp3V3cvWnJKbktJQXlDMkZHdi9IaFp2VFVWVU0rYlhmVXgwZWxJMlFH?=
 =?utf-8?B?Q3hDWUxzQlBYY2ZwSWVwVnRWbmgzdWRzdzZhcHo4djVweFBpRjFraXBPM1Jt?=
 =?utf-8?B?N0l5RHdVOXY3TGtGZHExVHVuVmhzS0xEbFNSblllWFppZUcwRTQ3ald4YXgw?=
 =?utf-8?B?N2pRSGNHTlF1ajVoOE5QbS9vOEhGUCtQdW5YckhBS28wcWUwbENma1lqMWxz?=
 =?utf-8?B?SHFVVjBQZGh0WWR5VndmWHh6c1R0MUZ6SWtWNFZzblZVSCszMzRvazlJcDN6?=
 =?utf-8?B?Y2JCRVB0UmhQVFRFcEJoMEx1azV1YncrdEtSemNYMjl4ZEpIK0RDLytTV2dO?=
 =?utf-8?B?ODlBdmVXdDkybkdnM2oxUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10862
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	23831b38-ab24-4394-22ce-08dc80b8deac
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|82310400017|35042699013|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0Y3aXlBSGlLZitubXJLc3FraXMzWlc3V3F3d1VFeDVsZDIyZmUwUG00Uy9X?=
 =?utf-8?B?NCtIRmFMZFpNaUFTUUExdEdVOWdhQ3djYnJRYzVJNnh4TUhiT3pLTVp3UzJP?=
 =?utf-8?B?a0ZEMmg0NXZZcmw4ZXhMMmNZS214N1o5SUVkZHBqRlpBdVlXK3FTZGk2WlZN?=
 =?utf-8?B?VkJHUTh0Vjc5VWxQcllqWUNkYVhTMVhIbTJKNHFnYjdsSXl0cWhVbktubW1B?=
 =?utf-8?B?aTZpK2hBRFBBMzF2T2x1SmJYdU9CRXBrSEhuNUxlY1pjbWRGWnlPVSt2NlBH?=
 =?utf-8?B?WjNwZGI2ZkVVR3cxalp3dVlDZW5pZDdtMUR6WjlUb2x6QU1CNGJoVlBBdGxN?=
 =?utf-8?B?YUJkTU9PR3VIU1VOR1dVR0I4amYwN2c4aFBzQkZEdkxsdlcvRGV3Q2crdGIw?=
 =?utf-8?B?N0J5eWU1OEJqWjVScDJFTnFVUS9KZXpOcVhCLzhBTWx0TkdyZi9Bekw3cXdX?=
 =?utf-8?B?dEZ5clF6ZWMvQ3R4dllkMlhIaFFEd3ZidkhwOGFYbFFaOEwzUGlNbjVZbSsr?=
 =?utf-8?B?RWk1ODBFZkhJL2xEUVlURGxCQ3hzcnBUc1gwUmFGVlIvbU9scWhPalh6cThq?=
 =?utf-8?B?ZnVIQitIMHMzb25sOEZ1Nmp1cGE3UEpxUldJTDJoRjlQT1l4U3lRME1tTlMx?=
 =?utf-8?B?djBHRjZEeWl1SzVTaXdtV2JKcER3YVhMS0d0Z3IxUFNLTUd3UmRaZThmOXBa?=
 =?utf-8?B?eHNmVWxiaWxWc1VsR0JMVEFMNmc4SEIxUWxSaTZzSm1rQVFxWXc4bHJobi8v?=
 =?utf-8?B?OTQvTkd4aExqUWNXcjdlS3FpUm9qRmdiWkJNNng4aFYzNFd4WEVaZkxQdXEz?=
 =?utf-8?B?SHA3eittRzR1ZDhwNEtwYnhEajd6T0dMb2ZHdysrR0EwNkk1dmc5a1lSZllt?=
 =?utf-8?B?eVp3ODY3cVhEdzRnaGlPaHN3QVR3S3FzZ2JEMm9BVlZrUlBPUXVKWHF1b2Ur?=
 =?utf-8?B?WkY4N3ovVmVycmVJRFhLR0cwdjJvczkyNEw0UTRaN29QNktVTzF0VFVkcE5E?=
 =?utf-8?B?SFIzZVZDRFhSRW9TNDBHK0NKNGdQOXdva3BYVnVTSDRSQUdyaDFaa0MwUlIz?=
 =?utf-8?B?QSsrSUZubkUvZ0xVM08xeVhlN1VxYVY2Qkk4L24yRlBwU0ZpVW9uNnc0N2gv?=
 =?utf-8?B?ci92VjRqMkh1ZzBsMGQ2WFNtMVMvNWFhRlZ1MHNoT2Y4R1Ewdjk4M0lTOXB3?=
 =?utf-8?B?ejhyY2V1Sjk5dUFyWXBIUjJFZWpDa2RJc050d2FMdmVXQ29weTVyeStaTWxT?=
 =?utf-8?B?aXo2QTUvMnRQcThzUGFTYmMyZHNPYjFTdUw3VDZNT2xPUnAxM09TT1c5Qi9M?=
 =?utf-8?B?VmNNalNmS1o0THYwSG0vSHdBTXV1OEdMT3ZiSnJSYllzdGVSWFp6NHJjWjBT?=
 =?utf-8?B?YVFxYzhkQXQ1TDZXWWM4SWk5ajJQRG9zUjA0c0xIVTBxTXI3cWJpeFVZQmVF?=
 =?utf-8?B?QUVmUUJnSjE5U2dlOHJSWFFoTW9aR2VZTFk4WTZmRm9JbGgxWWxPUWRUMm5i?=
 =?utf-8?B?aCsySXZmYlBSUW9HVUlyWVVWWUVTVDZQNk1rYllrNXFsN0VrQmRVUnpZbXVl?=
 =?utf-8?B?dFJyTmJYd1ZPdXo0QUt6UW1EZjNIT1BQSWVUdHpUSExDTS9wdWNrNFFIRksy?=
 =?utf-8?B?SjZYTFpRNjBCT21xbnJFN3BtbnhvUm0rOHhqSkVFZzlsLzc3U0dwdWx3MTlz?=
 =?utf-8?B?bW9PMUtrcy90Q1VTZmtRWG1TUi9abStwQkk3REU2Uk1JTUNMRFpyaTRYME11?=
 =?utf-8?B?NXdxMlNWVVVqVG9PajFjcFBlNHlJdUhYczZQYVdOUThYVXRYaFRvSHVTUlQ5?=
 =?utf-8?B?eGZrTnlrTEZxWGtaRTBDZ1RzOGFMaTVFdC91akdYSE1uMUkwUGtlamZWNUZ2?=
 =?utf-8?Q?vszCF8LdKUu+U?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400017)(35042699013)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:57:53.1523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd48c3d8-a63e-46a9-d7b7-08dc80b8e1e9
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10467

On 5/29/24 09:29, Russell King (Oracle) wrote:
> Since default_an_inband can be overriden by a fixed-link specification,
> there is no need for memac to be checking for this before setting
> default_an_inband. Remove this code and update the comment.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c
> index 9c44a3581950..796e6f4e583d 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1066,7 +1066,6 @@ int memac_initialization(struct mac_device *mac_dev=
,
>                        struct fman_mac_params *params)
>  {
>       int                      err;
> -     struct device_node      *fixed;
>       struct phylink_pcs      *pcs;
>       struct fman_mac         *memac;
>       unsigned long            capabilities;
> @@ -1222,18 +1221,15 @@ int memac_initialization(struct mac_device *mac_d=
ev,
>               memac->rgmii_no_half_duplex =3D true;
>
>       /* Most boards should use MLO_AN_INBAND, but existing boards don't =
have
> -      * a managed property. Default to MLO_AN_INBAND if nothing else is
> -      * specified. We need to be careful and not enable this if we have =
a
> -      * fixed link or if we are using MII or RGMII, since those
> -      * configurations modes don't use in-band autonegotiation.
> +      * a managed property. Default to MLO_AN_INBAND rather than MLO_AN_=
PHY.
> +      * Phylink will allow this to be overriden by a fixed link. We need=
 to
> +      * be careful and not enable this if we are using MII or RGMII, sin=
ce
> +      * those configurations modes don't use in-band autonegotiation.
>        */
> -     fixed =3D of_get_child_by_name(mac_node, "fixed-link");
> -     if (!fixed && !of_property_read_bool(mac_node, "fixed-link") &&
> -         !of_property_read_bool(mac_node, "managed") &&
> +     if (!of_property_read_bool(mac_node, "managed") &&
>           mac_dev->phy_if !=3D PHY_INTERFACE_MODE_MII &&
>           !phy_interface_mode_is_rgmii(mac_dev->phy_if))
>               mac_dev->phylink_config.default_an_inband =3D true;
> -     of_node_put(fixed);
>
>       err =3D memac_init(mac_dev->fman_mac);
>       if (err < 0)

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[Clea Astarte Google Cloud, SECO SpA]<https://clea.ai/astarte-on-google-clo=
ud>

