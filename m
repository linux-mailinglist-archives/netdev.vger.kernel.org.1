Return-Path: <netdev+bounces-189621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CCAB2D26
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2633BD413
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628F219A8D;
	Mon, 12 May 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="AZDvZfng";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="FnIXsui+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C622116EB;
	Mon, 12 May 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013310; cv=fail; b=chQGX2GjK4Y/bojNZUkWSLOMuws8UDLK28zxk/s78am4QXkE5GqatrkZpmXgvaFOdYPblV3RaDgvChJjU9PeJyvMZaJGivx+MzHMD/7k/j2j9LIgrWGhKTbRZVqGWvP3XMR50GtldG8edw0BKF+iGckFplgonP7ory13+/3xRZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013310; c=relaxed/simple;
	bh=jySBjMDmNQNCXrabGC8bX4EwHQRzxNxw4QyUDEwm/iQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssG9ZbEfdb0bW75dBoMbFtqu1V/1J7XmR4lMd/FSxViKHGpgHWBCx7Dp1K0aa9CV95EitlAp/4pzFI/caZZYmP7ZlLQW2AzqY5cySabrnzhUu56+cBSeoBqPtuQPf1Gc8m0qfV5sjz1hI0T8cyqJ+M94P0dmtRBbAOuBqEoh3Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=AZDvZfng; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=FnIXsui+; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0dSZF021480;
	Sun, 11 May 2025 20:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=OENZnLNkhByALmDeJKCZ0SPB8gbBjIOoxib6TmUA89w=; b=AZDvZfngDgoR
	SNxoRUOVGtbttncqu5UjUIBDrmJZg/BtyScBuREstK1FLly4YlqauwhKRXKCWibW
	Y2iU9LG9/HK+kuPlKzlWWMIyh28uM6HxmarFzEpGWn49bB/LVa+xqVutfUaJyoAu
	cgYQe5v+NqoTYket4ScVbsbN6+QpIXJRYB8m98Yq4OUhRTpnCUZWpbK0MgGoG8ys
	MwjhSWcMsU3jKfDtd9zMqZt2VyEwOhNRos5EyPEWPNN4Uebydf+y62hP9JxQa9pk
	0NZgC5wODqXVnj24u83nYC2C0xXnLSF9q5XUdYCkR9NHbRIaeO3eDUFh2/mpsciT
	Q1yrluSGUw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwx8kksrqWmRUjOliV40fW9k1Ryf7dGeW9Rn/OQSNEF1AHsjNlt4ig9mQm3zXvakL26L0Y39+rURu9ytHVQBZOLvUMF3BcO/YnNkanoi+Nr7AhpU1M5KVlzDr93IxLtujsjZHVLeBaSpofBtNo0+CFEM0FDbkcC9qKzIlJjdZ2pnFjQZz/UM/gEXpOTy5LJxq3N+oC3p8of7lw/vy3PB6hXUEJX0+N8aVDpGdTp77IGi/fqQZWalWQZ9dU4BenEmUXSVJfTmcz/I4+eNVGiMClGxxsf8wiG72btikv152Ot9LIBqBwM5YCizM7v8PmofO+T8wRQd3R5habnvde3siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OENZnLNkhByALmDeJKCZ0SPB8gbBjIOoxib6TmUA89w=;
 b=kjcEpbaePTt0bdjOrgy35g3ZOC4WvwzxCDuVwwfIkP3TPC8RX4pqg3FkbAOsGtXxTZGxqkdzJ1Vu8/IQ/RiD3Q00CkE5uSkYZKPc0qHXOJYleH6bDMVeZTfo0q6Y6YAgWuCSk63L6iXH3KMVxm0RQhqdMkcu5kQLWw7gQ3g/Iq+i3GBYBm6EhCHTywAy0do4CdV3A5F6+Gl9oMl1WXS0hmGYPr5/cBAVpyjLPzRQ0abIVt2KrLhQSTcYfWu5v8YpS5Y02eib6+h+857LgzExv42SiHUcdvpDWaEShvA0TBNYdqgI7bHBArze1ZPQVr3LUx85wXM9i+zGO0Zk7dvCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OENZnLNkhByALmDeJKCZ0SPB8gbBjIOoxib6TmUA89w=;
 b=FnIXsui+6yOU90tJpT3YsqTfPxYZAZY+s18+decZZxENdN25RAzFHPBpyoLyVDiMiI8r2i0jxOk/GaH0Ir7xe0Ax/9CTYdy3+0PxmRrSlOM5OlhSdOSUQVhtKnt8Y2LGfF9YdV3iw4lGMMkmdyzUU7mTMR0n4ZGVDMNjU2GI2Vg=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:28:00 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:00 +0000
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
Subject: [RFC net-next 04/15] net: cpc: add protocol header structure and API
Date: Sun, 11 May 2025 21:27:37 -0400
Message-ID: <20250512012748.79749-5-damien.riegel@silabs.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 022797e0-16c0-4d9b-643e-08dd90f43bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NElsU0hTbFBJN1N3RCtWcGRSY1NBQkNTUnB3U3FlWEc2QXdkNTFEUjcyUjZF?=
 =?utf-8?B?dHhJeU05VUo3cm9UUG42TCtNdlZ4VGE1SFREUklqeXRtNzhXcGtlUnBvVUVo?=
 =?utf-8?B?OFlBTkRZYjRoV2NZZXBOcW40Sjh5ZkxwbUpoS2pjYzh4dW8vNENCVTRLbnEv?=
 =?utf-8?B?Lzgrbll5Tjh1VExqQ1JnR0NOSS9PbFNqV3lKdXVkWFVhd3JuRTZZbERlYXVs?=
 =?utf-8?B?KzRpdnNtNDk0KyswaWtNMGdnZWdFenUwenYvQStuNDBhdTNYTWk2N056VFBB?=
 =?utf-8?B?eU5uT2d1aUtROWVjZWw2aG1OTlVHS2xtTVp2dVh6VjQ3RFNXZkhqcUc3R1RP?=
 =?utf-8?B?NEFlUmU1dTBNQllMQzB3TXhIT3YzQlhnaW1vaDk4UlBPd1A4QmFQdWlndWUw?=
 =?utf-8?B?QjBHSzRtek1uQXhnSnJmRy9SYW0zK1loQjFnYm9sOHJLZnJLUnhySEs2SVlZ?=
 =?utf-8?B?ZEJCbGd0RE5OeFVDLytaZGgzSDNVVThvaEt0L3F4ek1va3RjeVRRZmVLZnJp?=
 =?utf-8?B?Vk5OWHptNWUvbDR0MEdMaG1GOTgvQzR0UGVJOEUrdEsvck9jK0Y4NkpMY1VR?=
 =?utf-8?B?TWM1MW16WDdPNjN3dVRmZ3JDbHlTTUlvb2NSZC80R3poaWJVUDdDWEZ2OVI4?=
 =?utf-8?B?L3lERXB1STVJL2FUdzh4NkRYdUo4VVUrUjZCd3pGOEJzZXZBb2I2YklrbHM2?=
 =?utf-8?B?K0NmTnU2RzA0QUJxMUNWaEtYaXhUbGlDVDVHcnlrdno4bWd0VGxKRVdDdmln?=
 =?utf-8?B?aXNQL0pMWVIxNEZJOFd6MVlmZmRMMVJ2eGNZZjJwS0tIRkoyTWs4TW1meDVs?=
 =?utf-8?B?aVEzUkVRTmdMSUwrLzBPNG54SUM1M2g2Z0ZITlhEYVVxaDluWm9HUXVvbURY?=
 =?utf-8?B?MThsZVJVSFFUSkZtSTQzUjhhTGZ6bWtxYnl2V1FFQVRjUlF1WW02b1JGSUxu?=
 =?utf-8?B?QVlJSlBOck9kRU9ENTZOWmlubzVUVjJaNkdDVTd5VlkvU3pzT0VNbWFvazZ3?=
 =?utf-8?B?TjNFRVBZbWZKRXVJbmZZdnYrQmp6WW9aWTNoT3pvK2g2ODNGTGN3enNLN3Ro?=
 =?utf-8?B?cHVOMnpDZlRwS2FRVHBibWNKV0ZQamhCWm1saGlCdzVQVUFUODVDUlJ4aHdI?=
 =?utf-8?B?WWdCWnRQc01qbXdBQzNuTW5DUVh1QlN2NSszbmtuQytEd1hjQU5NSjh2Q1Zn?=
 =?utf-8?B?NlhQcDBRWVkycXFIQWNpOCtoTGY2dGJuN2JvUHlHamUyRUlUNzlXTjF1SHJP?=
 =?utf-8?B?eG1UREpKWCtNUVFvSHlXQUJ4QTFYbGVLNGVONnZHOVZ0NWtxa2EzVHM5YkVv?=
 =?utf-8?B?V2dmRngwS3RZckpRL0hSaVd1TTkwQjVJb1RHNkw1eEVURjVEL05KTXgvUGhC?=
 =?utf-8?B?U0t3WUg2VkthLzFDN2pUYVoxK1NvM3dUenRvYlVUQzRQZjZLaFBBVExjQjJG?=
 =?utf-8?B?OHUrUFFNOHltSEExZWpvcmkrQkhUY0ZuZzhVRkZWaWY4Q0prMjhWZmdVaU1G?=
 =?utf-8?B?YnJXY1oxd05VL3pscDErZE5VOG4xa0hjRCtGQXdVQ252UWx6MVdMREFReDNX?=
 =?utf-8?B?MW9wL3FxTnI2R1pORjk1NDJuQWZxd2N6SjFBKzIyZU1OTzhwOUVuMlBzci9m?=
 =?utf-8?B?QXMvNEpiOU1Kb2Y1RkF6amNXS1A1VWsxQ1JTKzRDNk1RdHFSV01CMVA5TW1r?=
 =?utf-8?B?TEdRZ3d5OWlDem5GUE1zMG1VRnEyMmEyRzhZRXVDSE8rdE1wMDRaWkl6aXB5?=
 =?utf-8?B?LytqMUEzZ0Q4Q2IxbDZqbis4NDdSM1lFWXowbE5WajB6R3FlOEt0RFhzSGVU?=
 =?utf-8?B?eU4rZzcrTXFHNUgrbFBPM0IzRC9TS2lpMTdLb2liMy9rS1VVeXpva1ZIbXk0?=
 =?utf-8?B?YnpRVi80eFM5aGN6bjRSb3UyTHlubm0yQXY1N2NHbG03SVZLc0RiT0lqcXFC?=
 =?utf-8?B?azBYVVcwRCs0bEpxOFVEc2dXQ0ZBMy9uSmZlSGpRd011eFRnRUQ2bTY4bzEv?=
 =?utf-8?Q?5/+ucAY0fC/kKcN/sAtKVQiAjIbOA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlwc0hHQzQzd2tENjNTOTArWEd4VGRhMWRDQ3k3MTVkbFFJZkZvT3k5RERn?=
 =?utf-8?B?MUU5TmEwWktCclgvRDhzTklaOVhjYTZaZXgzOG80WXBnSFFPbDl4eWNnck1M?=
 =?utf-8?B?RVRLVXBGQzZmRlBUbG1SZWZJYjJPM1ltU2d2UWJ4aHhxTCtlRFpNck9kRndB?=
 =?utf-8?B?bkN2R1BNWC9WUHFydWd3eTFLUGM1UkpteEt2Z2ZMWmxjejJBSFlyZGszTGdv?=
 =?utf-8?B?REhNbm5RakZNa3hLSmhGM1pqcDlUdXpLcTd5MVozalI4eFhMTHNZM0VEYmhS?=
 =?utf-8?B?c2c4Q2tlMno1bS9NeTFydUxrVkp3T3Y2Y3BURjlvSGZBeXRCV2hDOS9DRFQw?=
 =?utf-8?B?cEZ5czhPbGFCbG4xR2FTM05YZzk5Wlp2aG1GQWNlMGd3MGlzM3dxU2Z1ZmUw?=
 =?utf-8?B?K25YMG5Na3lhWEFuV1JCb0VnakdhMVVNeW50bFlOUmh6SDhCQURiYjJlZ3Bt?=
 =?utf-8?B?N3c3QUpKdDlscThJM1pBcVlqM0lEODdOOGdybjN2QmMwa3A3eUhVb2IzbytC?=
 =?utf-8?B?bUZyZ0l0eHl6RC9wUFliWmljd1I5V0xxakFONnk5ZjVyUzY4YW9pVVZJNTRm?=
 =?utf-8?B?cFBYaEtvQnJsUU04VXYzMWxhTDI2SU5xRnZJcFM0SHFzYWdkWEZpekZJSjh1?=
 =?utf-8?B?MVBURTlvZmVvMTQ5SjZ6Qkp2WEF6cytDZ0pwU2pGZE9xK3RGdlhMVytTK0tN?=
 =?utf-8?B?c2RiRFFGbTdEVEgzSXE0cTlrNkxVdkhpLzJXQzdoOWc1ZFJIb2FIWm1RZjFs?=
 =?utf-8?B?YnI2N0tTd01vVXlwVW5Ca1psSGtRb21LUUhaUTkveEk0K2lxWGN6VHhCa0dH?=
 =?utf-8?B?azRWUnZid2dRc09OSWR4ZzBqeFZwYkN1ekhielhvSE1vR1A5NkhTR0syTjBN?=
 =?utf-8?B?VEZRSUNmUUU2RnFjVFQrZjhLVWkyUUFKVUtQeHMrdGRQMjZVTEhZQ0xyQjln?=
 =?utf-8?B?WFVQNVNscGh2ZVVtejFnL1ZuMDY0OEJCRzZaUDBpaDhTTXN3UkJRUGV3S0N5?=
 =?utf-8?B?RlZBSFR4a0U2bHllUmh6MWZUTDFIeERtY2lNdXRZSnQ3UjJlNE9XWXdCT0FJ?=
 =?utf-8?B?TzRCbC9WN2xGOWxDbDF6UVc0UURjeXRNai96NkZMZmFFMWVsa2IwZTdabE9t?=
 =?utf-8?B?Rmc0dGVkS1lTVjB6OHpWQlR3Ylc1ZVM2cUxTQUVzNWZMc3dtYXp3Y3l6TkJM?=
 =?utf-8?B?N015cW1RRURmVm1xalJOL0lEZXloRDZ1WUlkb215S1FhTG5BdnBiNW8xNUNV?=
 =?utf-8?B?Zmd5S3VnUkhkS0E1ckFPTVREWSszMGJya1FLeWJwSExaam50Ny9vU0k2RVph?=
 =?utf-8?B?dk5Qc1Z6b1lYVzNveC92QXFwZE51VVlZOWFsQUpuWUZDRjNuRjRPb3FOZjlG?=
 =?utf-8?B?K2d0VlpZbHdIS1RONFN6dVFwVXJhcFEwN3B4cStkS2hrbEg4UlorekhTblBm?=
 =?utf-8?B?d0RSaE1sOEduYXZpOTRuV3VXdCt1TFU1RWxlQ1dmc2h2NjBFZVNjZ3k0QWQ0?=
 =?utf-8?B?SWhONEF0STdORVJOL3hUYUYzVDNVRzdaRW5wZEY2aGUzZi9vWGRwd2pCU2tt?=
 =?utf-8?B?dEdzTTRtMUt6UTd2bHVWSHZxandkU2g1Q3NtajcyL0lZSjdmSUdKZ2JnVnl4?=
 =?utf-8?B?dlgyVnBqZmpJYkxOUmJhMmc1a3JyQWNtdXNJaU5PU1dFWmpUUysvOHdxcUlW?=
 =?utf-8?B?dXFRaUVZbklxZ2FzazBmMWQxWFJockJvSkVGNG1mZHFNL0dPZUlTVTZPTkNz?=
 =?utf-8?B?VVZlSHR6aXR0bGFnWEI0dlNLYk8vTXhlUlpZZVdqdTVaL0gvQVNyL3U2WFRi?=
 =?utf-8?B?aFhWU0FiTzQ5bDdIbWhZL2tQNEY0RVc4ZU0zT0RUbXNHaFl5NXErRENWTFRF?=
 =?utf-8?B?L2hKeDZvelk2MHJaVzV6QjZwY3VqbXVBK012TWhaUmpDTERVLzcvVjJkbkQ1?=
 =?utf-8?B?Ujk3clp0aUlCbUZNM3dTNm1DcW9QN2tkM3ZPMnVHMG43MlllUERLdHBHemlU?=
 =?utf-8?B?eGNFMGdkczlXUHJ5K3dsWUlJQllvUGhCTTRxT3hpd1A1YXBpL3JLanhFelBC?=
 =?utf-8?B?ZUJ2NjFkc1N0UlVJTE4xOFBSMWZpc3I1RWxvR0JsRXpiNXQ1UlZPV1g5dDlG?=
 =?utf-8?Q?cRSENTSjat91Ma6oiEjqRSvqC?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022797e0-16c0-4d9b-643e-08dd90f43bb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:00.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGF6DbSCB7IbDXx94Bhpq0bAFIGIBk2WlmKTEwVxZAVg+a9nQfdfm/5EATsFq8fVWHORT+4tXjsVf+0aVwta+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: wQfZNIKp8h2q9zNT1x2u_effgSdj8WIj
X-Proofpoint-ORIG-GUID: wQfZNIKp8h2q9zNT1x2u_effgSdj8WIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfXyBLg8iiOTwRP aRrpVSI9h3AJRl3EESMlqNDHgpUAwV9Y7vXHXKLzy8AxK1knRyWw6qKKn+aK3bPBiE8kqrf5hkl IPU/j2lfLr/G9ntztkTtu+TeX4cWcWMI0h2Xkv6oHzuk/XkUXz9pUKOsrfdtwccoLcyCngpMFhK
 80A1MxyBmWoxZslY6/sSZ7gF4uw97XuXyBCVavWFRm7EmAa0vniQGBnXC7TixWITZBvY+uuXbq7 wduCti6iy1y6JR/5YLs/decwZvqDrEWDlJ+86ZJEUpNR90dfNXWiNCc4qbjZVMbrf8EBEKiyMx+ YxnZD6woKWKDCWHNhKNKUtHnbHz897cgJhoxYgxyZ2nZXRuwVHFIs4KZs/CCS+f+jVGTcPNJ9UF
 K0be+wgvLtEPwHDbpTwDy56AN8vbcyORLHeGtDTs1sKowSbWWM5kUPQqK18xSLX4wrjr6FB4
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea7 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=F0xCgmf7AXx50LILr2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

CPC frames are composed of a header and optionally a payload. There are
three main frame types currently supported:
  - DATA for transmitting payload or regular control frames (like ACKs,
    that don't have payload associated with them)
  - SYN for connection sequence
  - RST for disconnection and errors

Add structure and functions to operate on this header. They will be
leveraged in a future commit where the protocol is actually implemented.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Makefile |   2 +-
 drivers/net/cpc/header.c | 237 +++++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/header.h |  83 ++++++++++++++
 3 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/cpc/header.c
 create mode 100644 drivers/net/cpc/header.h

diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index 673a40db424..81c470012c1 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := endpoint.o interface.o main.o
+cpc-y := endpoint.o header.o interface.o main.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/header.c b/drivers/net/cpc/header.c
new file mode 100644
index 00000000000..9f6d637b5ae
--- /dev/null
+++ b/drivers/net/cpc/header.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/string.h>
+
+#include "header.h"
+
+#define CPC_CONTROL_TYPE_MASK 0xC0
+#define CPC_CONTROL_ACK_MASK BIT(2)
+
+/**
+ * cpc_header_get_type() - Get the frame type.
+ * @hdr_raw: Raw header.
+ * @type: Reference to a frame type.
+ *
+ * Return: True if the type has been successfully decoded, otherwise false.
+ *         On success, the output parameter type is assigned.
+ */
+bool cpc_header_get_type(const u8 hdr_raw[CPC_HEADER_SIZE], enum cpc_frame_type *type)
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	switch (FIELD_GET(CPC_CONTROL_TYPE_MASK, hdr->ctrl)) {
+	case CPC_FRAME_TYPE_DATA:
+		*type = CPC_FRAME_TYPE_DATA;
+		break;
+	case CPC_FRAME_TYPE_SYN:
+		*type = CPC_FRAME_TYPE_SYN;
+		break;
+	case CPC_FRAME_TYPE_RST:
+		*type = CPC_FRAME_TYPE_RST;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * cpc_header_get_ep_id() - Get the endpoint id.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Endpoint id.
+ */
+u8 cpc_header_get_ep_id(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return hdr->ep_id;
+}
+
+/**
+ * cpc_header_get_recv_wnd() - Get the receive window.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Receive window.
+ */
+u8 cpc_header_get_recv_wnd(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return hdr->recv_wnd;
+}
+
+/**
+ * cpc_header_get_seq() - Get the sequence number.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Sequence number.
+ */
+u8 cpc_header_get_seq(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return hdr->seq;
+}
+
+/**
+ * cpc_header_get_ack() - Get the acknowledge number.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Acknowledge number.
+ */
+u8 cpc_header_get_ack(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return hdr->ack;
+}
+
+/**
+ * cpc_header_get_req_ack() - Get the request acknowledge frame flag.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Request acknowledge frame flag.
+ */
+bool cpc_header_get_req_ack(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return FIELD_GET(CPC_CONTROL_ACK_MASK, hdr->ctrl);
+}
+
+/**
+ * cpc_header_get_mtu() - Get the maximum transmission unit.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Maximum transmission unit.
+ *
+ * Must only be used over a SYN frame.
+ */
+u16 cpc_header_get_mtu(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return le16_to_cpu(hdr->syn.mtu);
+}
+
+/**
+ * cpc_header_get_payload_len() - Get the payload length.
+ * @hdr_raw: Raw header.
+ *
+ * Return: Payload length.
+ *
+ * Must only be used over a DATA frame.
+ */
+u16 cpc_header_get_payload_len(const u8 hdr_raw[CPC_HEADER_SIZE])
+{
+	const struct cpc_header *hdr = (struct cpc_header *)hdr_raw;
+
+	return le16_to_cpu(hdr->dat.payload_len);
+}
+
+/**
+ * cpc_header_get_ctrl() - Encode parameters into a control byte.
+ * @type: Frame type.
+ * @req_ack: Frame flag indicating a request to be acknowledged.
+ *
+ * Return: Encoded control byte.
+ */
+u8 cpc_header_get_ctrl(enum cpc_frame_type type, bool req_ack)
+{
+	return FIELD_PREP(CPC_CONTROL_TYPE_MASK, type) |
+	       FIELD_PREP(CPC_CONTROL_ACK_MASK, req_ack);
+}
+
+/**
+ * cpc_header_get_frames_acked_count() - Get frames to be acknowledged.
+ * @seq: Current sequence number of the endpoint.
+ * @ack: Acknowledge number of the received frame.
+ * @ack_pending_count: Amount of frames pending on an acknowledge.
+ *
+ * Return: Frames to be acknowledged.
+ */
+u8 cpc_header_get_frames_acked_count(u8 seq, u8 ack, u8 ack_pending_count)
+{
+	u8 frames_acked_count;
+	u8 ack_range_min;
+	u8 ack_range_max;
+
+	ack_range_min = seq + 1;
+	ack_range_max = seq + ack_pending_count;
+
+	if (!cpc_header_number_in_range(ack_range_min, ack_range_max, ack))
+		return 0;
+
+	/* Find number of frames acknowledged with ACK number. */
+	if (ack > seq) {
+		frames_acked_count = ack - seq;
+	} else {
+		frames_acked_count = 256 - seq;
+		frames_acked_count += ack;
+	}
+
+	return frames_acked_count;
+}
+
+/**
+ * cpc_header_is_syn_ack_valid() - Check if the provided SYN-ACK valid or not.
+ * @seq: Current sequence number of the endpoint.
+ * @ack: Acknowledge number of the received SYN.
+ *
+ * Return: True if valid, otherwise false.
+ */
+bool cpc_header_is_syn_ack_valid(u8 seq, u8 ack)
+{
+	return !!cpc_header_get_frames_acked_count(seq, ack, 1);
+}
+
+/**
+ * cpc_header_number_in_window() - Test if a number is within a window.
+ * @start: Start of the window.
+ * @end: Window size.
+ * @n: Number to be tested.
+ *
+ * Given the start of the window and its size, test if the number is
+ * in the range [start; start + wnd).
+ *
+ * @return True if start <= n <= start + wnd - 1 (modulo 256), otherwise false.
+ */
+bool cpc_header_number_in_window(u8 start, u8 wnd, u8 n)
+{
+	u8 end;
+
+	if (wnd == 0)
+		return false;
+
+	end = start + wnd - 1;
+
+	return cpc_header_number_in_range(start, end, n);
+}
+
+/**
+ * cpc_header_number_in_range() - Test if a number is between start and end (included).
+ * @start: Lowest limit.
+ * @end: Highest limit inclusively.
+ * @n: Number to be tested.
+ *
+ * @return True if start <= n <= end (modulo 256), otherwise false.
+ */
+bool cpc_header_number_in_range(u8 start, u8 end, u8 n)
+{
+	if (end >= start) {
+		if (n < start || n > end)
+			return false;
+	} else {
+		if (n > end && n < start)
+			return false;
+	}
+
+	return true;
+}
diff --git a/drivers/net/cpc/header.h b/drivers/net/cpc/header.h
new file mode 100644
index 00000000000..c85bcaef345
--- /dev/null
+++ b/drivers/net/cpc/header.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_HEADER_H
+#define __CPC_HEADER_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+#define CPC_HEADER_MAX_RX_WINDOW 255
+#define CPC_HEADER_SIZE 8
+
+/**
+ * enum cpc_frame_type - Describes all possible frame types that can
+ * be received or sent.
+ * @CPC_FRAME_TYPE_DATA: Used to send and control application DATA frames.
+ * @CPC_FRAME_TYPE_SYN: Used to initiate an endpoint connection.
+ * @CPC_FRAME_TYPE_RST: Used to reset the endpoint connection and indicate
+ *                      that the endpoint is unavailable.
+ */
+enum cpc_frame_type {
+	CPC_FRAME_TYPE_DATA,
+	CPC_FRAME_TYPE_SYN,
+	CPC_FRAME_TYPE_RST,
+};
+
+/**
+ * struct cpc_header - Representation of the CPC header.
+ * @ctrl: Indicates the frame type [7..6] and frame flags [5..0].
+ *        Currently only the request acknowledge flag is supported.
+ *        This flag indicates if the frame should be acknowledged by
+ *        the remote on reception.
+ * @ep_id: Address of the endpoint the frame is destined to.
+ * @recv_wnd: Indicates to the remote how many reception buffers are
+ *            available so it can determine how many frames it can send.
+ * @seq: Identifies the frame with a number.
+ * @ack: Indicate the sequence number of the next expected frame from
+ *       the remote. When paired with a fast re-transmit flag, it indicates
+ *       the sequence number of the frame in error that should be
+ *       re-transmitted.
+ * @syn.mtu: On a SYN frame, this represents the maximum transmission unit.
+ * @dat.payload_len: On a DATA frame, this indicates the payload length.
+ */
+struct cpc_header {
+	u8 ctrl;
+	u8 ep_id;
+	u8 recv_wnd;
+	u8 seq;
+	u8 ack;
+	union {
+		u8 extension[3];
+		struct __packed {
+			__le16 mtu;
+			u8 reserved;
+		} syn;
+		struct __packed {
+			__le16 payload_len;
+			u8 reserved;
+		} dat;
+		struct __packed {
+			u8 reserved[3];
+		} rst;
+	};
+} __packed;
+
+bool cpc_header_get_type(const u8 hdr_raw[CPC_HEADER_SIZE], enum cpc_frame_type *type);
+u8 cpc_header_get_ep_id(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u8 cpc_header_get_recv_wnd(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u8 cpc_header_get_seq(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u8 cpc_header_get_ack(const u8 hdr_raw[CPC_HEADER_SIZE]);
+bool cpc_header_get_req_ack(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u16 cpc_header_get_mtu(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u16 cpc_header_get_payload_len(const u8 hdr_raw[CPC_HEADER_SIZE]);
+u8 cpc_header_get_ctrl(enum cpc_frame_type type, bool req_ack);
+
+u8 cpc_header_get_frames_acked_count(u8 seq, u8 ack, u8 ack_pending_count);
+bool cpc_header_is_syn_ack_valid(u8 seq, u8 ack);
+bool cpc_header_number_in_window(u8 start, u8 wnd, u8 n);
+bool cpc_header_number_in_range(u8 start, u8 end, u8 n);
+
+#endif
-- 
2.49.0


