Return-Path: <netdev+bounces-122608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51686961E50
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765311C22B00
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376A14C592;
	Wed, 28 Aug 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ljrVIFmO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647914AD25
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823601; cv=fail; b=O2H1eWKAi6/8HDE35JKtUy+gPKmVkcFZ8XQB57eLDQZuR8kMgqWtO6OPSwSVn1MOXGbOVaR7x6BWu69s8MZeiukS32hwDxHvUOwcUDADg8LM+UK9Xu60T0EcO1x4iPCHtV+Sk9Xev0ybNkEZ0ditjoZhXwPnOCJ8J0WO8eH7vXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823601; c=relaxed/simple;
	bh=uyERxYDZh8jxtbMgmbSG1/zbTbK7ootSjGx+CglKobo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pW/4/oKE3MkNuMF/hrmx/G/nvUwHIZfpOX5pd7hl9s7qdASq3iCAzdQa42TqXnbsN6h56KhAq8BoEBB0ZNwclddCI5tF1ADwbN8brB0HncFKbIxgEgN7q2zQcsjgV22y3Ji4Ro3Vtg55RhLZM9s6qd2NvdBy2SLV9EE+L3Kg/r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ljrVIFmO reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47S1e2Gu017255;
	Tue, 27 Aug 2024 22:39:51 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 419tebrmc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 22:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP2l2P9mYaQNAViEHah2ZcCaaKyn6scLvz42n6N8ri2zKtgBGdFR/xX7+F2TckeJ0nXQI5Gxtt599f63RL4kML+/JIxot6KKNbg3aWAJFVcql1zXd0O/X7kzFZt1c/a0+Ihl5VxvGF7NR+10cSZO9fwt/FPFViRCxnEb6E0kF4CeQT0jhEaD/9iuHjQ++IcOi9zoCqSzQN4HaoNIM60+oDu41i/JnhSBkLIZ42b6/ECMYxQ0AQuoFc7EQdK1c9fee4hjRUUE0YIoQ4Vk3/9twaqJrIRxqJ/xPCPCjC0m8R9k4YHvjjCgwjIHK+/7D2TRzmonRHOXyp1AFegw7vJlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzAxi5KnkiV+NdI24lEj/g80T7dYlqcFe5+xCA2rDOo=;
 b=dmWXouZpQGjlQA25JOLzY5/l1dD9y2+sBVPzf8sHafWtfwBoIt1P/XEU9z6Ts4SUfzLMtD5Dav3/bEPcOMQjuekqTU8XKUo6vZnYhtlWMdbNPNsgzU61GH573bZVKK0vNQwbsguX+lgrZYDpM9jTO+JmtyE2Dror0lpJ5Xj3i7wDDQHLmhLvFpMaRdW6sfcaQTlOJS00FfS5onRfePDotfJCCLpr43LvwwtGdaTsmvD+qrS26opdCoXOHhguSRJ5QFHznlmYjPC3PSG69DebM6SzaB/nyOl9dHVaOvQOrgFDi+ofWxNRzvlCUETZjGnFIWUum6Kp9QOIbYKlVQ2UDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzAxi5KnkiV+NdI24lEj/g80T7dYlqcFe5+xCA2rDOo=;
 b=ljrVIFmOC0vyU+vp/JOX9kt3P67uaHtqCa8xHMRnB4nPHJm7NWCt3EXybnXbisnNje05oJstzh5aLTCsp/JWsXjy9rJTENQyDbOREc8FQLOsbzkxoVAfIgaduk4E87J3OfXFbBx6CX9v+An7FktQ+D/b2otr5SGvVeenfp8B6tI=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by DM4PR18MB5122.namprd18.prod.outlook.com (2603:10b6:8:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 05:39:48 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 05:39:48 +0000
From: Srujana Challa <schalla@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu
 Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,1/2] octeontx2-af: reduce cpt flt
 interrupt vectors for CN10KB
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,1/2] octeontx2-af: reduce cpt flt
 interrupt vectors for CN10KB
Thread-Index: AQHa+J69gK0xZYcNMEWixEiZOoW51LI8Go4w
Date: Wed, 28 Aug 2024 05:39:48 +0000
Message-ID:
 <DS0PR18MB536880099C7682CAD84604CBA0952@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240827042512.216634-1-schalla@marvell.com>
 <20240827042512.216634-2-schalla@marvell.com>
 <20240827163218.GO1368797@kernel.org>
In-Reply-To: <20240827163218.GO1368797@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|DM4PR18MB5122:EE_
x-ms-office365-filtering-correlation-id: 47d70ef7-0133-472a-dd3a-08dcc723d46f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFNNSXZ0bCtGMkJBSmsrV0dYUUppMGlkdlFaUHh1aXc3eU1ITFY0OWticVFQ?=
 =?utf-8?B?Vkk1VVlCT3VPZ1dPZEN5U0ZPZnViOTVlRlh0dVd6OGZVSWpvb3BPMGFZK2Fl?=
 =?utf-8?B?WnUxQlpQY0MvUVl0VjhDeWNjQ2JWT3p5Q0YxNEhVVUZBVU9yOTYwMWJTMTF1?=
 =?utf-8?B?blh2dXpDNzVvMnNnRUJBM2RGVE0xTU50d005ZHh0WWxCSGhWbEg5M0dESG5E?=
 =?utf-8?B?VVJ1RGZjdGU4eGZTUkNEU0hQc0lPeHRvZFNDdFBUYkQ2ZExuZys4aEl6NWlT?=
 =?utf-8?B?Ly9ObXViRE1kWkZXQW1hVWdYYUZkSFo0czQ2VHpGVkJhOFpKQmJVWGJ1cWFv?=
 =?utf-8?B?VDhzZjhESGpCRUtaK3FycW9rNnhYRTd4WXVFRkZ2ZWJFaVE3MWFvcitOa05i?=
 =?utf-8?B?UEo2MlFSbitCK2dGbUYzendXWEpjQjh2QTMra1RBaVBXRlZxckRyazFmSUo2?=
 =?utf-8?B?UFhKTmVmc05lSmVYRzJpNGN1NDVsYXF0MFdoNTI3L0ovM1hQQUdwNkFLTGFG?=
 =?utf-8?B?Z1EzWHdsMnBsclV4VUpsMjRKQnZ1ZmdRaXl6OS9JYkFHTDVETkhaSk9BU3RY?=
 =?utf-8?B?RFM3OTU0dnRDT2ZSc0ZuWERGN3lscWhwRFM2UitlcjBaMEtDemxBMk4yRytm?=
 =?utf-8?B?eGV0QVA1akpaUUhqSC9iY1g3RW5ZOEE3N245c1pKZEs5SVc1TEU3V1ozaEJD?=
 =?utf-8?B?NG5PVDFobzdrS3ExdEV0cjBQYjdjM0gyTDJFVEdmbStOSEhIRWJuVUR0R3JF?=
 =?utf-8?B?Z3UyL3kvalY4cUxjQ3J0K1VGaFY5NkhlbEJFdGVvRU8vcEhvMC8vVGw3SHBq?=
 =?utf-8?B?RGhFc0lNY1hzNUNCYkRIYzU2MGRLT3Y2NURHOWxBNjFoam5uT1VaSzBQWklY?=
 =?utf-8?B?TWlvcWhEL1ZwVjJ4M3B3UVY2am91WnIxZmtQV3ErU2xWbFFMTEpBMCtlNi9X?=
 =?utf-8?B?N01lVUtUSUNRclI3aHpJSm80TThVQ1cwWUZVcHpTSFRuREpNaTBxUkpEa1h3?=
 =?utf-8?B?RlFkZFRnSE52SUkxd2NYMDJCcllqZDJRLzZNNm9VTG92ck10TDRSN3hhZkkr?=
 =?utf-8?B?NzlxWktWeGpSU3k4M0VQeXZxVldMMU5tNEwwbVVFNjkxTUhUQlh6bllKaUNU?=
 =?utf-8?B?RUtoRS92ZDU5VDVHTGJVeWtMNVVyVVBBS0FJbjhaamtIZWpNc2tjSmNIcWto?=
 =?utf-8?B?VlFOaDhqN2ZVMmZPWWdQUkdIRXdNOVVtb2x0RFhselUwb2RiVTlVdUlaWWVQ?=
 =?utf-8?B?WjVGOHkrVEtYY2lSNnN0SitnVWJBcW5HOVl3RUl5R05taElrZ1ErM25LR1kx?=
 =?utf-8?B?V2VxMWY5NjgyNXBKL0pJK3ZRR0xtV1drUnNXQXVUbW16L2ZqOWFKUEcrOTl4?=
 =?utf-8?B?b1ZKT2tEUW4rWFpiMHg4amdXZEI0bHA2azlrVGZ1a2lmdDE5MHRoYUNadTR0?=
 =?utf-8?B?WTlTY2FneEhBT2xPOCtOWXJsY0RIWnJ1S093WVA1K2oreG9XYzJDR0hWdlIr?=
 =?utf-8?B?dDdyUi9CL1FXMFlzd250KzZUaU9TdGtjRTJnbS82QXRYd1RCQThhR2hISG1N?=
 =?utf-8?B?elAwU1JZNnlLcVlEbWFpMWVHMUZQYmF6a0ZCRmVibml5a1VKRTI2ejlCTWFu?=
 =?utf-8?B?eVFRQ2xVR1NzVTQva1RKTmRhR1J0bWo2WmNEZkFNWW1QWEJ0dmxFVTR1NU5U?=
 =?utf-8?B?eENSR0hMUHlnY1g1eGJlbWhFRE5QaVZpLzVOQ2xBd2dHMHBBb1NBM1Z1akov?=
 =?utf-8?B?WXIrdUN5eUlEcmRHYVMrMlUxdnUyd05mY3dYa2JMRkxBN1UrQndYYnNKK1pp?=
 =?utf-8?B?YmdZRHlUNjdWbmYvV09NZE01R1ZkdU5yNUpIZkppclhwRTVFdHNsN1lYVXNo?=
 =?utf-8?B?Zm16OHBhUzYrWjdFZnRKellrVDQ1TFNsbnk2K052dkRrT0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1IySjBYV01tRXlPYnkrY1Vwc2JDOElxY0xsTGJlSkpYZ1dFaWR6b2VjUzNu?=
 =?utf-8?B?SWxtQ0hxZGo0cnpGVUhzZFlwWHlkUUJNeFA5blBaZnV4T3VNSmU0cU5tcWd4?=
 =?utf-8?B?QWg5Skh3YnNrempyT21BY281V3l6OUxOYVFaZEhYQVVKbFFFVDBDM09RRm9B?=
 =?utf-8?B?NVdpYlI5cWpCRTJZTVEzeVpsTnJhdFIzZDJtZnVhYWtxb05rTFBjZjVJQUVr?=
 =?utf-8?B?MTFiK01na2VOM3pVNzBVZ1RrNlBpQ0t6RHRNdnp1bi91TVNhWkVpbm05dkFV?=
 =?utf-8?B?NHY3a3pYREo3ekZZMlB2aWZMaEZTZDkwY1M2WXdFb3hZd01XLzdvZ3lVYUhL?=
 =?utf-8?B?c1RjRTJIODVmN3pyLzNXQ1hmQVpaQkFiUnBZYm1RcXVsMDNJcG81Q3lOMTdk?=
 =?utf-8?B?dWtTWGttQk5PTXIyTU8rb2wrQmgvZlQ3RXE4TXdaVHNvRkplbDNUWXJrc1Z0?=
 =?utf-8?B?TTROeGJPdElqdVpIWG1sVENpUXBnaWozY0hwVEp1VjRQQ0xqUDkvRjRIellW?=
 =?utf-8?B?bklOYnJ6NUlLMXBkSEI3NWp5bEZjU0xTWVJweWVCUkZOKzlkeS9LU1ZkWUFJ?=
 =?utf-8?B?azFzdG1tNUxGNVRUb2NFUWlDMjd3eHNUYWlSZ0sySWZvMmZFQWloKzZFdmVJ?=
 =?utf-8?B?cmZDdDk5VmpXVCtDT3Nqb0lXWmk4OEF0eDBaU2JxQkcwYTY4OTk1U0czalpE?=
 =?utf-8?B?a2k2eDF4N2p2cnM4d2VzakZPa2lUQUhUdkFkc0dBUnUweTQ3L2JYOTNKdWpu?=
 =?utf-8?B?OWtFWGJQcGFYSFMxWUV1ZHZ3YVBZMi8rUm4wR3MxcnVRU0NkU2ljTXdPWThv?=
 =?utf-8?B?Y0Niam5EcS9vbzExaDQzZFpEQmlkdFZ1WWNwV2tUeFRTOHc4K2Ftd1NmTDlk?=
 =?utf-8?B?b1hvcmVudnFMdVFmaE4yZDRlZnVJOUs2S1JRT3luWklXK2ZoTG9Wa3JKSEww?=
 =?utf-8?B?QmZhUjJsZ3BqR2RaOVV4VjdJRXloWTdzWm9OeEptUVUrVmFTcTZ6SXZmQmZl?=
 =?utf-8?B?cW1xdytPVkt1eUc3RHJLRk9KUnlZc05HQklVdlpOaEhBdmMrS3FJWlNxdk5K?=
 =?utf-8?B?N2pUVXdzOUdDRS9QLzFKaVdzbUxDSkZVMkliN3F4eXIydXBwL0tvMTNtR21T?=
 =?utf-8?B?RjViekw3VTBZNlplSjF0T0JEY1Q1RDBuSENxRlFmK2hSSDBURjBhSEY0b09L?=
 =?utf-8?B?Q21wcm5ST285b2ZkNXBxbmpXSDV0dHpDeHl0RVF4R3JLbys1czF6U1FkTzNG?=
 =?utf-8?B?Mi9JWGR2YmFWQVRYeWhjN3BTSHFyV2haS1R2bU9mSTRMeko0SlI3QUowRkh0?=
 =?utf-8?B?d094bTRGczNhN1pQZnpRU0tVV3JlcjFkeFg2dEduZGJ6eFpZcE43UVREZjlF?=
 =?utf-8?B?WUVHUktFUkRmYUFYTDF0a3ZrSWFvR25zVmtTUXdQWXI1RlZDNFByeEEwbjhI?=
 =?utf-8?B?dzNOeVJFc01LOTlqL2YwN0FIOXAvTEV4K1BrWGhlaGlTdU1rQWZCQXlYTEtt?=
 =?utf-8?B?enZjM0kzNlNhL1JMdXg2czR5eUppSks5dzhTUU92aU1CRVNreWpFaWtqZCti?=
 =?utf-8?B?VFhFZjNMZ0lUQ2hQcFlYdUJzeUZVYmlORHpuV0k4eDNZbDlsbVJCUWYzdTAx?=
 =?utf-8?B?ci9kZVBQT0lvaW5BRU4vY1hENnhob2tKZ2d0OFZxZnlsTUwzOC9ibWgxSXk5?=
 =?utf-8?B?blVadG5HRWxLRmw2djlHZnNiaHlTRGhWaUNvOEpDTUxIWEkyWkd0UzdKVWtS?=
 =?utf-8?B?aitTMmI1NEs2U1Rxa1NCTFFNa0l2VTZFSkRJQVBxK1V2Tk5MTzNqRDVEUEU1?=
 =?utf-8?B?YStRQjIzbE5lZVVMaENjZzhYVGFPcEVNdUV4Y3o3NkRLS01paVlyOXBkRUpJ?=
 =?utf-8?B?cU1xYWR0RGlSa0w1K3NPcGoyaUxxK1U4SDdmdUVXRndmV3pTcnBaR3RwMkVT?=
 =?utf-8?B?TnhSYi8yTXFXZzN4cVpKRG1DUjcrNm1FNkw5SGQvOGx4RDhoNVA1YjVBRkhr?=
 =?utf-8?B?TFY1b2VpU3U0UmNHeVJ5L1VBaTBxeUlrMUI4SnFnTG41clVSZkdycm8rNEpN?=
 =?utf-8?B?R1d0Sm1aZTlCWVF2NlNoME1jYXlsMWlvblk2andYbk8yb2MvUTFIbVhVZTZa?=
 =?utf-8?B?MEtXejNwUmdCNlVKSmdoWGtyM1Mvc01pVHF6azd3U1VuYUdpQjNZUm1YOVlH?=
 =?utf-8?Q?qjs/Wl5P6nTg/8+om0PuPwGqBxm4flYlWz/4QWxUc6Ww?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d70ef7-0133-472a-dd3a-08dcc723d46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 05:39:48.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLi1T4t7jsUWjyP+f7lwl8EjCY5eA/+wpFLGlxAaK1TFL+nSh2bMfB38Rm0JOgMeKBij2q3ml/xJ+wBSl5C2ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5122
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fcQxsWZ4Gx9ahVHdXLMtLryQdV49iMiR
X-Proofpoint-GUID: fcQxsWZ4Gx9ahVHdXLMtLryQdV49iMiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01

> Subject: [EXTERNAL] Re: [PATCH net-next,1/2] octeontx2-af: reduce cpt flt
> interrupt vectors for CN10KB
>=20
> On Tue, Aug 27, 2024 at 09:=E2=80=8A55:=E2=80=8A11AM +0530, Srujana Chall=
a wrote: > On
> CN10KB, number of flt interrupt vectors are reduced to > 2. So, modify the
> code accordingly for cn10k. I think it would be nice to state that the pa=
tch
> moves away from=20
> On Tue, Aug 27, 2024 at 09:55:11AM +0530, Srujana Challa wrote:
> > On CN10KB, number of flt interrupt vectors are reduced to 2. So,
> > modify the code accordingly for cn10k.
>=20
> I think it would be nice to state that the patch moves away from a hard-c=
oded
> to dynamic number of vectors.
> And that this is in order to accommodate the CN10KB, which has 2 vectors,=
 as
> opposed to chips supported by the driver to date, which have 3.
Sure, I will make the change.
>=20
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> > index 3e09d2285814..e56d27018828 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> > @@ -37,6 +37,44 @@
> >  	(_rsp)->free_sts_##etype =3D free_sts;                        \
> >  })
> >
> > +#define MAX_AE  GENMASK_ULL(47, 32)
> > +#define MAX_IE  GENMASK_ULL(31, 16)
> > +#define MAX_SE  GENMASK_ULL(15, 0)
>=20
> nit: Maybe a blank line here.
>=20
> > +static u32 cpt_max_engines_get(struct rvu *rvu) {
> > +	u16 max_ses, max_ies, max_aes;
> > +	u64 reg;
> > +
> > +	reg =3D rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_CONSTANTS1);
> > +	max_ses =3D FIELD_GET(MAX_SE, reg);
> > +	max_ies =3D FIELD_GET(MAX_IE, reg);
> > +	max_aes =3D FIELD_GET(MAX_AE, reg);
> > +
> > +	return max_ses + max_ies + max_aes;
>=20
> Maybe I am wrong, but it looks like this will perform u16 addition.
> Can that overflow? I ask because the return type is u32, implying values =
larger
> than 64k are expected.
No, it couldn't overflow. I will change the return type to u16.
>=20
> > +}
> > +
> > +/* Number of flt interrupt vectors are depends on number of engines
> > +that the
> > + * chip has. Each flt vector represents 64 engines.
> > + */
> > +static int cpt_10k_flt_nvecs_get(struct rvu *rvu) {
> > +	u32 max_engs;
> > +	int flt_vecs;
> > +
> > +	max_engs =3D cpt_max_engines_get(rvu);
> > +
> > +	flt_vecs =3D (max_engs / 64);
> > +	flt_vecs +=3D (max_engs % 64) ? 1 : 0;
>=20
> I don't think the parentheses are needed on the lines above.
> And likewise elsewhere in this patch.
>=20
> At any rate, here, I think you can use DIV_ROUND_UP.
Ack.

>=20
> > +
> > +	if (flt_vecs > CPT_10K_AF_INT_VEC_FLT_MAX) {
> > +		dev_warn(rvu->dev, "flt_vecs(%d) exceeds the max
> vectors(%d)\n",
> > +			 flt_vecs, CPT_10K_AF_INT_VEC_FLT_MAX);
> > +		flt_vecs =3D CPT_10K_AF_INT_VEC_FLT_MAX;
> > +	}
>=20
> cpt_max_engines_get seems to get called quite a bit.
> I think dev_warn_once() is probably appropriate here.
Ack.

>=20
> > +
> > +	return flt_vecs;
> > +}
> > +
> >  static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)  {
> >  	struct rvu_block *block =3D ptr;
> > @@ -150,17 +188,25 @@ static void cpt_10k_unregister_interrupts(struct
> > rvu_block *block, int off)  {
> >  	struct rvu *rvu =3D block->rvu;
> >  	int blkaddr =3D block->addr;
> > +	u32 max_engs;
> > +	u8 nr;
> >  	int i;
> >
> > +	max_engs =3D cpt_max_engines_get(rvu);
> > +
> >  	/* Disable all CPT AF interrupts */
> > -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(0), ~0ULL);
> > -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(1), ~0ULL);
> > -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(2), 0xFFFF);
> > +	for (i =3D CPT_10K_AF_INT_VEC_FLT0; i < cpt_10k_flt_nvecs_get(rvu);
> > +i++) {
>=20
> I think it would be best to cache the value of cpt_10k_flt_nvecs_get() ra=
ther
> than run it for each iteration of the loop. I'm assuming it has a non-zer=
o cost as
> it reads a register, the value of which which I assume does not change.
>=20
> Also, the same register is already read by the call to cpt_max_engines_ge=
t(). It
> would be nice to read it just once in this scope.
Ack.

>=20
> Likewise elsewhere.
>=20
> Also, there is an inconsistency between the type of i and the return type=
 of
> cpt_10k_flt_nvecs_get(). Probably harmless, but IMHO it would be nice to =
fix.
Both are int only.

>=20
> > +		nr =3D (max_engs > 64) ? 64 : max_engs;
> > +		max_engs -=3D nr;
> > +		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i),
> > +			    INTR_MASK(nr));
> > +	}
> >
> >  	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
> >  	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
> >
> > -	for (i =3D 0; i < CPT_10K_AF_INT_VEC_CNT; i++)
> > +	/* CPT AF interrupt vectors are flt_int, rvu_int and ras_int. */
> > +	for (i =3D 0; i < cpt_10k_flt_nvecs_get(rvu) + 2; i++)
>=20
> It would be nice to avoid the naked '2' here.
> Perhaps a macro is appropriate.
Ack.
>=20
> >  		if (rvu->irq_allocated[off + i]) {
> >  			free_irq(pci_irq_vector(rvu->pdev, off + i), block);
> >  			rvu->irq_allocated[off + i] =3D false;
>=20
> ...
>=20
> --
> pw-bot: cr

Thanks for reviewing the patch.

