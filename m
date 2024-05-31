Return-Path: <netdev+bounces-99755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AF8D6382
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FB1C22F35
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C602159216;
	Fri, 31 May 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2ljpQnN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2046.outbound.protection.outlook.com [40.107.8.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EED1586C8;
	Fri, 31 May 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163528; cv=fail; b=KaboexG/9EKI4iWLz6irJBFaxKLqIxJGHNbcswIL06tCfbLtFBqcrmzCCraeCuayfPx9aqQLepyqJ7JF24Z6kgxNN8hQe3YO3i2EURaLhytGyXmk6uU4deaDOiF8mIbBzHaKwGvrdKw0HeG7mVrjK+dEQ5H+YpXM4AryAcER7QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163528; c=relaxed/simple;
	bh=CvPYu0JiWULge1RRiZS+A6g1U/yTgEE8dFRkSR304e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V9oJ3Lb83VCRw5vbjemztO+XBSRKQonzX3HbIy8oCPpctq+q2Ebbxj7OcTJEszKL1SiTPRCmEpRqojGgSM4qFVpJ2a//c/+cPdxFLEPAkzf/ASyrMXTPrz252Eo2lEM02r2coq34ZU0tJDPWSks9dz7nhkxKgv8PWxn3hh77tlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D2ljpQnN; arc=fail smtp.client-ip=40.107.8.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZsMAXvjH/cXUf0L045nXKKl8Vmmil8kE/8yB8aPlkucsG5jZt3RhUh6svc74RY8O4WOly3KoLjNO8lwiwb7l0NJFzF4noigNLSTAcoFXXcZoH86c5l2VCwnLP6SsfApHPlTdADs/gf7uNFMFoRotvPd0mTlN8sjA0MSe99D3p2xPgmLFiDrdoX0uCJ0qKXEBgxS2n2xf1R2qDbx3KtSq9RFiZV2C2tuDzJLPK7Drd/gQacLem/14FDwsPP+OliAILztiuGgVGagr4CS+fvMPYm5IQzd2TTLSUP9LwRlXNAQrbXIpjI7HyUP+N1wqQH9y2lawIueOgycdBIa1cPv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBO6SeYt63c6s5pj4Da0QmVcowYkpc1Xo9e34Bt1yeE=;
 b=UAg97+xhS5CWopcQj9BhKTkNxuKnxLC1GH9wCyhJGhywZh4i0AflkUhg8lDczHE5Bu5ztGNjf9riDYAgZgXZIv1XxpmBpxs6b3I2g1L0D35ChevEg8409HAklWZ/41xGszVHSB02L8N2b3zrA8Rd8vBJltE3dWY5UFnn2bR0VYv+4rI988GMsh7ShxCBabVKnut7LDlQsKBTQ80Wvw6E9DlH5WSnAFnpOrrK6WEb4lv3UFYL2c2VyGIpoJwJ38P7AsJFFimBrdZWb2aFJ1l4PjyhUkpJOvpuwo5HDiiZq+OYLA1w3C2EXrK8vtUVRhr1Z+NtBegy5mNbYZplfPRGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBO6SeYt63c6s5pj4Da0QmVcowYkpc1Xo9e34Bt1yeE=;
 b=D2ljpQnNK6UYqcYQTQ6SS52ek50ZyFsSi6KQNmriAqvse4YDM1rDzDHBwsQ9MrxKVIGJZkpjfMVDq2DRw/ePIepxMVZ9SK3zbxemW5ykI/qLMkUPbSc0oriehHBCqc6LMPJSdDeFds5OUHPwfvs9XRtuoR5ZMoTMlf5UZ8f/S/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM0PR04MB6994.eurprd04.prod.outlook.com (2603:10a6:208:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 13:52:02 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 13:52:01 +0000
Date: Fri, 31 May 2024 16:51:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <20240531135157.aaxgslyur5br6zkb@skbuf>
References: <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
X-ClientProxiedBy: VI1PR08CA0231.eurprd08.prod.outlook.com
 (2603:10a6:802:15::40) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM0PR04MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7a5c2e-056f-43e8-4305-08dc8178d908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXUxK3Vvek8vSDV0NmVhUUpETEdPZXNiM1B6UlZKZUppV1ZGYlVuZXJ1REN6?=
 =?utf-8?B?V2M2aEdiK1k0OGpBWmNOTlV0SGlDS2RmQkZrbTdMZ0RRZkJqYmYySVpXemhk?=
 =?utf-8?B?MWMyejZrMWtoUTEwbEF1S285VEFzSkRta2JsZ05PSTJwZlpsaTZ4dUVlOTVO?=
 =?utf-8?B?N2Mrbnp2OUl0bkQrRm9oZkFydnF2Z2N3SXhGL1F6NWlkRzVRM3RRRmR3enB1?=
 =?utf-8?B?aXFjRlRJQkZPOUsyNUE3ejhiY1cxb2dKMWpLeGR2VVQreGpnSk5tV0gxcFg4?=
 =?utf-8?B?WnlJVUpWS0UwVW05YnBwZHNPNFpPYmZnaGJlcWpBNU1pNmlpVnJTSVpNTVhG?=
 =?utf-8?B?aEpJaSsreFlrSkd1eG5tK2xuaW1lUjRxVkdmT1Z2dW5URTFSM09ZZGxJaGxF?=
 =?utf-8?B?YW5Xemc3SHYveFhldlQ2V1loVGdDYThMeVp6UURBNUtmTDc0ZWg2QWhQcWxC?=
 =?utf-8?B?ZWdWWlQ5bnQ4dXBGaWoxS0Y1ZjQxSnZBaDh5NkRDWGNlazJQQk9sZXNXZ2Jk?=
 =?utf-8?B?UUhjTnUyYy90bEFGOGVRTGs3Z0dWRlVXZi9EWnRhWlFpZkhxRDhKZzdsc011?=
 =?utf-8?B?bzVHQVRwNUhScHRmczRHbXhuL1hOQ1Z6Qi9ERG5DcWZIKzNkM2RvWmZqN0I4?=
 =?utf-8?B?L29RQzQrVW5LejFFSUxlRlJzdVozSDlybjJqRDhqazRnekxzc2NFRGdtTnkz?=
 =?utf-8?B?RllLYWJyQkc4TmtwejhDK045RmEwQkdMVy9CRG4rWXd0VHhiSllLK2NzY3pB?=
 =?utf-8?B?eitrZlJZNTV1VkJRL29WZk9yQnVuYUZOaTB1N2pTWUcvanEya2pLVEN5eGpX?=
 =?utf-8?B?UU1PMlhwVlZaNmhJVVVBM3BXRXhUUXRrc1JwME1OS1BsamV5QTFlN1FhZVZz?=
 =?utf-8?B?QUF5djZ0citVbU5mYThHNGpGTWJnakUzaW9uMUZVQTBBUFp1V1JLdStFeFBG?=
 =?utf-8?B?Wm5mL2F1dkZhYkJXNUlodllPSm1pWFJrQzY1NkNBRVREZjZCM1Q5SCtEeXpZ?=
 =?utf-8?B?VDNSM0EwSmxnN2VYR3JWTkdsckRFZmhFMTVGengxdU1sS0I2S2xUaEVFRFZy?=
 =?utf-8?B?dmZBVVFDWFhiNVlFOWVsQlprNnlHQVphL3FrcGlwNlNyaG04Mm5ZcUdPYmRl?=
 =?utf-8?B?Um9va0s1S3BmTGE4K1JCb3JZV0ZSTnFrdy9VQng4Sm5CL00vL05YeERBb0pa?=
 =?utf-8?B?OHVLVmpYdW40WVlWQUEycFpRYnZZdDdUT0VHSm5WMENHS1dLclFUdU1Gek9z?=
 =?utf-8?B?VHhySkp3YTJIM3FVRm9vaS8vK1Iyb2I2MWtNY2lla1c0b1hBcGJ2UkU2UTBv?=
 =?utf-8?B?SzFvYWg5NG5jdm41aU5pbitTeVpvVnNUUnM3NnNyU1FwNHplVHpYS0dlZWFW?=
 =?utf-8?B?bkhVaUZiTGJaUHhURUMwY1N0ZFJrVmpoc3Y5ZWJ6TGlmWVpYS1crNkJEUlpp?=
 =?utf-8?B?VmIzV2lVeFZ6UU9mUi9sZzVSVTFKRWxjZ0IzdHE0cElaOGR6eS80VG82VlJV?=
 =?utf-8?B?WnFKZ0ZzZ3hYazNscEl3Z2JZWlpUUld5N3JPU1FCZlhWUjJYRGZLbHdqL0xm?=
 =?utf-8?B?V1FUdGxLVzgzYzQ4VkJqRTZrbW9wMDMrdFRXaFRUQTRPamhzMm5XcDZDU2Ji?=
 =?utf-8?Q?N+qHaYzwjWQ0qyvufBbSwt/NGoGyPNKQJxknrGIOYZHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1p5UVNuVzF1VWZNZ09meXdPK01RZEdVdGpBRFRoc1VyeFFWMU5QRmdvckti?=
 =?utf-8?B?cXpNN256SDMvcTY4eWhxZ0xKUWhPV3Zwbk1VMmV6djVlUERJNU1OaitHbVMy?=
 =?utf-8?B?SGZVRitCVW9kMmpqRE83OXUwUUZUZEFlaEQxTnUvVWNjSEpOUFpnV0xDUko3?=
 =?utf-8?B?SEMyVG1PR3lVVzYxd3ZJdXNqUUU5WVdwMVV3ZFZHL2lNL1F1N3lRSmJmQkhJ?=
 =?utf-8?B?UmhXTE4wZTRHNU5VMDBWT2UxVFcrWDJ4ZWZsZWxGR3pVWUFwR1RJU2k3cGdL?=
 =?utf-8?B?WnhtTzBvQlRTSE9iaUlGeFU2WS9RTEtiM3lTNVVOSFN1RjlLVXhiaGJYbFly?=
 =?utf-8?B?Z1NVZGJtSVNCOG9taUhSWHA0N1hpbzBIbi8wUTh6WkxmamJ1U2lpa1FoMEd0?=
 =?utf-8?B?MFRSNTdRMlpkRDcxYmVTaFN2VTNFUGRKeWk1UGVTVTA3YVJxalN4YmlpYVE0?=
 =?utf-8?B?WG5VZFphMWNaM3lYbEZZVmM5dDNBdHBFbDJ4UzQ5b0E0VDRFN21pb29haGpz?=
 =?utf-8?B?QmFFb0tGQmVRU3lEVXk4UVdVTVIycGtLUitWcjQzVWhIN1FjSGVMOTNYdzZS?=
 =?utf-8?B?OTR1SFhKQ0wrMnlERVdOcExwV2UrRXdlNUJuZVpLakd2NTVLL0d2bGFyZ2oy?=
 =?utf-8?B?Y2lieFZZcmYyM3lGelNMaS9wU3V3eHh3YVNzd3h4UXhtSHIwdWx3dGRNc21K?=
 =?utf-8?B?eXRVTUFaVzBtZFg2ODFHcjkybUpScFJubWo4Tkk0MTJpakpnVStJK1MrMS9i?=
 =?utf-8?B?ZXhLYlpxaS9MVTdpZkFmcFRBNS84Q0Y5MTlmanFITkJGdk92bE9FZ1BBeHpZ?=
 =?utf-8?B?aFdlZDFsUWRXQ0tub2x0NVovdGhURGxhMk44dGxEbXd6N3ZZVjFEZUZWU0JZ?=
 =?utf-8?B?N0w5NWhoSlBJdUJhYVcwdm0rVU54OWwycVUyNnY2d2ZrbDhqaTVBWFlubzY3?=
 =?utf-8?B?WmVGNkkyc3laOHVESHpNaWlhc0pnUURSL00xMUJTcDNJMGxhbXFRK2RVYjB3?=
 =?utf-8?B?NCtCdXY5Y2RDL1duZWphWDUzaFVkN0RNQ1NIZTFZY1J0MEZ4aHljS0Z5YmhH?=
 =?utf-8?B?MzQ4RTlwZTdSUUFVQnJ3andTakFvQk9nSEpzRDlzc0ZyYkJwWWRQMkpodG9N?=
 =?utf-8?B?Q1ludW02eFFMaVlkbDBrcndMV2t5R1JoaUQwaFlHRWI2WnJabm55OUJHamUy?=
 =?utf-8?B?YVlDb1ZKSXFTM2YyVmEzbS9aSCsyOENSSi91QzdnZC9uZlZ1RHRkWXJKQ1JG?=
 =?utf-8?B?UGxIcWlyNXBwRE40THpBNXdsYnNtZlV0TjJtRUxybmVoeUlraFJlV2Q4K0sy?=
 =?utf-8?B?MUhYYkRlN0twSjVsYjFHSkJ2OXNaSzd3ZkhCbXFBNFdnM0c0aFg1eFNaM1Iy?=
 =?utf-8?B?S3JMRkhmNVBZMnZvYkVIS0pKTTFFUG9hUHJzWDlhV2hMQUhQb1FqKzhSVFRV?=
 =?utf-8?B?cURJaEtqbEtqcmVvaklhSWZ0eGY2WkdRa3pTaUg4YnJSS004M0hwcXhWeTBK?=
 =?utf-8?B?VHNHcjNHMXRmelRsTzhhenljdmlMMnFmTjh1WUE1aXpLR0kzVS82enpjb0Vq?=
 =?utf-8?B?ckxQUEtDOEZrSWdIY1dNNmJBUzhwOVRydzhTUWRpZUNXbW1kNHRUdlRVd1Fz?=
 =?utf-8?B?N3JaK2Rlb3c1NXQvSjVDRmI3UFcrdUF1cFF1OVMvVW1XeHVHNXJycEoxSjMr?=
 =?utf-8?B?UHNiTFJ4ZlFzNXhQQUhKNkV5TW5vTzdhRkhXSFFadWpiL2hwL3pnQWEyZDN3?=
 =?utf-8?B?b2FUcW54cXNjMXhrUkhpM1Fzakx6S0FkRmVFL3NxMmdVVURSTmtFVHY1ZVll?=
 =?utf-8?B?VEo4bmM2eitPZVZMaWU3RGt3RHpFelFTZE1WQzJwelU4bFpOeERKeWhTOVNE?=
 =?utf-8?B?RyttazRUY3lGQlJ0R3VMR3dyNU9pd3BuakxSNXF6dm4wR1d6cDY3TnBhaHBO?=
 =?utf-8?B?ckkzWlBNTE8zMG5YTFFaMmZuNTltdUJINFEvbDlkQlJjTkduYzlEaDE2NTNP?=
 =?utf-8?B?S1h1RHdPZldITURTaUU5Q2FnRlAvalJFUHp6Sjh0bWY5bHRUNVl3dFZvQWcx?=
 =?utf-8?B?YURmWExVWnZkSDg1aDFYQ281R25uTlBZN3g4OHBCa0xqdGlSN1U3QU5UWXlH?=
 =?utf-8?B?Sk01WklXNng2NmxJcGkrWWlCMFNCeCtjZU9BREdkMHY0M1RwRkI2OXZJSWRC?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7a5c2e-056f-43e8-4305-08dc8178d908
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 13:52:01.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjlBSk/aBvjJ+ggh11ok/MQaaYMz6i8fusRAeK/1Nc2zcTXa8KxlFOmyzkm/ZHFGimrHv978MPuXZHYQFsrCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994

On Fri, May 31, 2024 at 10:15:12AM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> The ICSSG dual-emac / switch firmware supports Enhanced Scheduled Traffic
> (EST – defined in P802.1Qbv/D2.2 that later got included in IEEE
> 802.1Q-2018) configuration. EST allows express queue traffic to be
> scheduled (placed) on the wire at specific repeatable time intervals. In
> Linux kernel, EST configuration is done through tc command and the taprio
> scheduler in the net core implements a software only scheduler
> (SCH_TAPRIO). If the NIC is capable of EST configuration,user indicate
> "flag 2" in the command which is then parsed by taprio scheduler in net
> core and indicate that the command is to be offloaded to h/w. taprio then
> offloads the command to the driver by calling ndo_setup_tc() ndo ops. This
> patch implements ndo_setup_tc() to offload EST configuration to ICSSG.

This is all a lot of verbiage about generic tc-taprio and nothing
concrete about the ICSSG implementation... It is useless, sorry.

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig              |   1 +
>  drivers/net/ethernet/ti/Makefile             |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   3 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 288 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 ++++++++
>  6 files changed, 408 insertions(+)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index f160a3b71499..6deac9035610 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -190,6 +190,7 @@ config TI_ICSSG_PRUETH
>  	depends on PRU_REMOTEPROC
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on NET_SCH_TAPRIO

I think the pattern should be "depends on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n".
What you want is to be built as a module when taprio is a module,
because you use symbols exported by it (taprio_offload_get(), taprio_offload_free()).

>  	help
>  	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
>  	  This subsystem is available starting with the AM65 platform.
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 59cd20a38267..0a86311bd170 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o
>  icssg-prueth-y := icssg/icssg_prueth.o \
>  		  icssg/icssg_common.o \
>  		  icssg/icssg_classifier.o \
> +		  icssg/icssg_qos.o \
>  		  icssg/icssg_queues.o \
>  		  icssg/icssg_config.o \
>  		  icssg/icssg_mii_cfg.o \
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index d159bdf7dd9d..8982ecb8a43d 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -706,6 +706,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>  	.ndo_get_stats64 = emac_ndo_get_stats64,
>  	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> @@ -840,6 +841,8 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	emac->rx_hrtimer.function = &emac_rx_timer_callback;
>  	prueth->emac[mac] = emac;
>  
> +	icssg_qos_tas_init(ndev);
> +
>  	return 0;
>  
>  free:
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index fab2428de78b..c6851546e6c5 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -37,6 +37,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>  
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -195,6 +196,7 @@ struct prueth_emac {
>  	/* RX IRQ Coalescing Related */
>  	struct hrtimer rx_hrtimer;
>  	unsigned long rx_pace_timeout_ns;
> +	struct prueth_qos qos;
>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..5e93b1b9ca43
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/printk.h>
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +
> +	if ((readb(tas->active_list)) == TAS_LIST0) {

Who and when updates tas->active_list from TAS_LIST0 to TAS_LIST1?

> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
> +	} else {
> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
> +	}
> +}
> +
> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	u16 __iomem *max_sdu_tbl_ptr;
> +	u8 gate_idx;
> +
> +	/* update the maxsdu table */
> +	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
> +
> +	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
> +}
> +
> +static void tas_reset(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	int i;
> +
> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
> +		tas->max_sdu_table.max_sdu[i] = 2048;

Macro + short comment for the magic number, please.

> +
> +	tas_update_maxsdu_table(emac);
> +
> +	writeb(TAS_LIST0, tas->active_list);
> +
> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
> +}
> +
> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	int ret;
> +
> +	if (tas->state == state)
> +		return 0;
> +
> +	switch (state) {
> +	case TAS_STATE_RESET:
> +		tas_reset(emac);
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
> +		tas->state = TAS_STATE_RESET;
> +		break;
> +	case TAS_STATE_ENABLE:
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
> +		tas->state = TAS_STATE_ENABLE;
> +		break;
> +	case TAS_STATE_DISABLE:
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
> +		tas->state = TAS_STATE_DISABLE;

This can be expressed as just "tas->state = state" outside the switch statement.
But probably shouldn't be, if "ret != 0".

> +		break;
> +	default:
> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);

There are two levels of logging for this error, and this particular one
isn't useful. We can infer it went through the "default" case when the
printk below returned -EINVAL, because if that -EINVAL came from
emac_set_port_state(), that would have printed, in turn, "invalid port command".

I don't think that a "default" case is needed here, as long as all enum
values are handled, and the input is sanitized everywhere (which it is).

> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);

FWIW, emac_set_port_state() has its own logging. I don't necessarily see
the need for this print.

> +	return ret;
> +}
> +
> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	struct ptp_system_timestamp sts;
> +	u32 change_cycle_count;
> +	u32 cycle_time;
> +	u64 base_time;
> +	u64 cur_time;
> +
> +	/* IEP clock has a hardware errata due to which it wraps around exactly
> +	 * once every taprio cycle. To compensate for that, adjust cycle time
> +	 * by the wrap around time which is stored in emac->iep->def_inc
> +	 */
> +	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
> +	base_time = admin_list->base_time;
> +	cur_time = prueth_iep_gettime(emac, &sts);
> +
> +	if (base_time > cur_time)
> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
> +	else
> +		change_cycle_count = 1;
> +
> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
> +
> +	/* config_change cleared by f/w to ack reception of new shadow list */
> +	writeb(1, &tas->config_list->config_change);
> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
> +	writeb(1, &tas->config_list->config_pending);
> +
> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);

The call path here is:

emac_taprio_replace()
-> tas_update_oper_list()
   -> tas_set_trigger_list_change()
      -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
-> tas_set_state(emac, TAS_STATE_ENABLE);
   -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);

I'm surprised by the calls to emac_set_port_state() in such a quick
succession? Is there any firmware requirement for how much should the
port stay in the TAS_TRIGGER state? Or is it not really a state, despite
it being an argument to a function named emac_set_port_state()?

> +}

There's something extremely elementary about this function which I still
don't understand.

When does the schedule actually _start_? Can that be controlled by the
driver with the high (nanosecond) precision necessary in order for the
ICSSG to synchronize with the schedule of other equipment in the LAN?

You never pass the base time per se to the firmware. Just a number of
cycles from now. I guess that number of cycles decides when the schedule
starts, but what are those cycles relative to?

> +
> +static int tas_update_oper_list(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	u32 tas_acc_gate_close_time = 0;
> +	u8 idx, gate_idx, val;
> +	int ret;
> +
> +	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
> +		return -EINVAL;
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	for (idx = 0; idx < admin_list->num_entries; idx++) {
> +		writeb(admin_list->entries[idx].gate_mask,
> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
> +		tas_acc_gate_close_time += admin_list->entries[idx].interval;
> +
> +		/* extend last entry till end of cycle time */
> +		if (idx == admin_list->num_entries - 1)
> +			writel(admin_list->cycle_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +		else
> +			writel(tas_acc_gate_close_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* clear remaining entries */
> +	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* update the Array of gate close time for each queue in each window */
> +	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
> +		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
> +			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
> +			u32 gate_close_time = 0;
> +
> +			if (gate_mask_list_idx & BIT(gate_idx))
> +				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
> +
> +			writel(gate_close_time,
> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
> +		}

An implementation which operates per TX queues rather than per traffic
classes should report caps->gate_mask_per_txq = true in TC_QUERY_CAPS.

> +	}
> +
> +	/* tell f/w to swap active & shadow list */
> +	ret = tas_set_trigger_list_change(emac);
> +	if (ret) {
> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for completion */
> +	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
> +	if (ret) {
> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
> +		return ret;
> +	}
> +
> +	tas_update_fw_list_pointers(emac);

Calling this twice in the same function? Explanation?

> +
> +	return 0;
> +}
> +
> +static int emac_taprio_replace(struct net_device *ndev,
> +			       struct tc_taprio_qopt_offload *taprio)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret;
> +
> +	if (taprio->cycle_time_extension) {
> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> +		return -EINVAL;
> +	}
> +
> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> +		return -EINVAL;
> +	}
> +
> +	if (emac->qos.tas.taprio_admin)
> +		taprio_offload_free(emac->qos.tas.taprio_admin);
> +
> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
> +	ret = tas_update_oper_list(emac);

If this fails and there was a previous emac->qos.tas.taprio_admin
schedule present, you just broke it. In particular, the
"if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)" bounds check really
doesn't belong there; it should have been done much earlier, to avoid a
complete offload breakage for such a silly thing (replacing a working
taprio schedule with a new one that has too large cycle breaks the old
schedule).

> +	if (ret)
> +		goto clear_taprio;
> +
> +	ret = tas_set_state(emac, TAS_STATE_ENABLE);
> +	if (ret)
> +		goto clear_taprio;
> +
> +clear_taprio:
> +	emac->qos.tas.taprio_admin = NULL;
> +	taprio_offload_free(taprio);
> +
> +	return ret;
> +}
> +
> +static int emac_taprio_destroy(struct net_device *ndev,
> +			       struct tc_taprio_qopt_offload *taprio)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret;
> +
> +	taprio_offload_free(taprio);
> +
> +	ret = tas_set_state(emac, TAS_STATE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	return tas_set_state(emac, TAS_STATE_DISABLE);

Again, any timing requirements for the state transitions? Why not
directly do TAS_STATE_DISABLE? It's not very clear what they do
different, despite of the attempt to document these firmware states.

> +}
> +
> +static int emac_setup_taprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_taprio_qopt_offload *taprio = type_data;
> +	int ret;
> +
> +	switch (taprio->cmd) {
> +	case TAPRIO_CMD_REPLACE:
> +		ret = emac_taprio_replace(ndev, taprio);
> +		break;
> +	case TAPRIO_CMD_DESTROY:
> +		ret = emac_taprio_destroy(ndev, taprio);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_TAPRIO:
> +		return emac_setup_taprio(ndev, type_data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +void icssg_qos_tas_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct tas_config *tas;
> +
> +	tas = &emac->qos.tas.config;
> +
> +	tas->config_list = emac->dram.va + TAS_CONFIG_CHANGE_TIME;
> +	tas->active_list = emac->dram.va + TAS_ACTIVE_LIST_INDEX;
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	tas_set_state(emac, TAS_STATE_RESET);

Why leave it in TAS_STATE_RESET and not TAS_STATE_DISABLE? The firmware
state at probe time is not idempotent with its state after a
emac_taprio_replace() -> emac_taprio_destroy() sequence, which is not
good.

> +}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> new file mode 100644
> index 000000000000..25baccdd1ce5
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __NET_TI_ICSSG_QOS_H
> +#define __NET_TI_ICSSG_QOS_H
> +
> +#include <linux/atomic.h>
> +#include <linux/netdevice.h>
> +#include <net/pkt_sched.h>
> +
> +/* Maximum number of gate command entries in each list. */
> +#define TAS_MAX_CMD_LISTS   (16)
> +
> +/* Maximum number of transmit queues supported by implementation */
> +#define TAS_MAX_NUM_QUEUES  (8)
> +
> +/* Minimum cycle time supported by implementation (in ns) */
> +#define TAS_MIN_CYCLE_TIME  (1000000)
> +
> +/* Minimum cycle time supported by implementation (in ns) */
> +#define TAS_MAX_CYCLE_TIME  (4000000000)
> +
> +/* Minimum TAS window duration supported by implementation (in ns) */
> +#define TAS_MIN_WINDOW_DURATION  (10000)
> +
> +/**
> + * enum tas_list_num - TAS list number
> + * @TAS_LIST0: TAS list number is 0
> + * @TAS_LIST1: TAS list number is 1
> + */
> +enum tas_list_num {
> +	TAS_LIST0 = 0,
> +	TAS_LIST1 = 1
> +};
> +
> +/**
> + * enum tas_state - State of TAS in firmware
> + * @TAS_STATE_DISABLE: TAS state machine is disabled.
> + * @TAS_STATE_ENABLE: TAS state machine is enabled.
> + * @TAS_STATE_RESET: TAS state machine is reset.
> + */
> +enum tas_state {
> +	TAS_STATE_DISABLE = 0,
> +	TAS_STATE_ENABLE = 1,
> +	TAS_STATE_RESET = 2,
> +};
> +
> +/**
> + * struct tas_config_list - Config state machine variables
> + * @config_change_time: New list is copied at this time
> + * @config_change_error_counter: Incremented if admin->BaseTime < current time
> + *				 and TAS_enabled is true
> + * @config_pending: True if list update is pending
> + * @config_change: Set to true when application trigger updating of admin list
> + *		   to active list, cleared when configChangeTime is updated
> + */
> +struct tas_config_list {
> +	u64 config_change_time;
> +	u32 config_change_error_counter;
> +	u8 config_pending;
> +	u8 config_change;
> +};

Should be __packed since it maps over a firmware-defined __iomem memory
region. The compiler is not free to pad as it wishes.

> +
> +/* Max SDU table. See IEEE Std 802.1Q-2018 12.29.1.1 */
> +struct tas_max_sdu_table {
> +	u16 max_sdu[TAS_MAX_NUM_QUEUES];
> +};
> +
> +/**
> + * struct tas_firmware_list - TAS List Structure based on firmware memory map
> + * @gate_mask_list: Window gate mask list
> + * @win_end_time_list: Window end time list
> + * @gate_close_time_list: Array of gate close time for each queue in each window
> + */
> +struct tas_firmware_list {
> +	u8 gate_mask_list[TAS_MAX_CMD_LISTS];
> +	u32 win_end_time_list[TAS_MAX_CMD_LISTS];
> +	u32 gate_close_time_list[TAS_MAX_CMD_LISTS][TAS_MAX_NUM_QUEUES];
> +};

Should be __packed.

> +
> +/**
> + * struct tas_config - Main Time Aware Shaper Handle
> + * @state: TAS state
> + * @max_sdu_table: Max SDU table
> + * @config_list: Config change variables
> + * @active_list: Current operating list operating list
> + * @fw_active_list: Active List pointer, used by firmware
> + * @fw_shadow_list: Shadow List pointer, used by driver
> + */
> +struct tas_config {
> +	enum tas_state state;
> +	struct tas_max_sdu_table max_sdu_table;
> +	struct tas_config_list __iomem *config_list;
> +	u8 __iomem *active_list;
> +	struct tas_firmware_list __iomem *fw_active_list;
> +	struct tas_firmware_list __iomem *fw_shadow_list;
> +};
> +
> +struct prueth_qos_tas {
> +	struct tc_taprio_qopt_offload *taprio_admin;
> +	struct tc_taprio_qopt_offload *taprio_oper;

"taprio_oper" is unused.

> +	struct tas_config config;
> +};
> +
> +struct prueth_qos {
> +	struct prueth_qos_tas tas;
> +};
> +
> +void icssg_qos_tas_init(struct net_device *ndev);
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data);
> +#endif /* __NET_TI_ICSSG_QOS_H */
> -- 
> 2.34.1
>

