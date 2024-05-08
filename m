Return-Path: <netdev+bounces-94483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDD8BF9C9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D9BB22478
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1578C60;
	Wed,  8 May 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hPHv2kjp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65085757FF;
	Wed,  8 May 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161761; cv=fail; b=Gy3HsXA2FZtg5ErzYzYIblYAEy4r0ic8Pf2MpkOBm01Wi5lgEN8mFGKbmy5Z90LeQVWDdhw2CTu+QhAQYU8dXVSK153mJgjs3Lc6SmHs6zc87k2xFNVw/pyz/i6VzGFm1Itcdec+5cLEJzYjIk4P47L+mYPbNlq3b+sgnGcOiqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161761; c=relaxed/simple;
	bh=8VGZbqcasdOHCNao/uu9PMHi1CadRMArxv4SnT0c/OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aibcw3Cehew2tRBrEzIbRTosfeQHFbQgz8NBFp4b0XPU0PRV8PR2OoJTWxU7V/zEe+TRh7UGd36BZye/zgVf/tdqD4jdCW8bnsffTUIl9A/1FMe+NiEd3BzbJKhRvwgGc4RN87c3xVcBNREmxZlSOChFxm1Zxh8w2qXmNxRVMfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hPHv2kjp; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44853xdq032037;
	Wed, 8 May 2024 02:49:11 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xysfnjs5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 02:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM1KmACy/f25dvSEKiiCdYartOSzAIvmvFOneH3AmXL1wbzc/Q+YnfWjwutFLHoZQ6372ckySOoFoWNc0DvV5eSdSoUjuQ2klmmK3nlsGZlLbJ5YMAvqwtDaOwlRx5oldtmbAt+MX19XF6eIfQ7pblkn3XeNN0aLi6QNBawuIqdAuL7CmAKXdzSnNHAoFC3yM5I/NBW6mGbsFeXjm19nkA5k9yOfSWQfU3REfWoJXB0iCrAX6dp2VmKWPc6T39QrUkJODV8aqWjVGac4IKtyRAoxMr56jBVfEy3MfRdGSJrs48NFwym5cKqYlH5fDEJZh/TxhgShNFaxGtIJgzhq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VGZbqcasdOHCNao/uu9PMHi1CadRMArxv4SnT0c/OE=;
 b=XkoiM9BJVaWFZbiAGY7mdHgFhsw65E1fqAtrfIKy1Tn5DWyCpjeudm4zXcsQv7XRsEwI6N3KYyJYCfyN5jQ/hrywnjLrnHXyEEn4kalidokoTO7QzNBpVd1MdjEkU4xjsyBtKwS8BjAezw4MkCoPeuKU7ZIpXgmzeVXWhCmB1KsObeNoS7MJuEN9IYt+uIzG9vaC+XEUVmWO8pC8BOFFO0I+00Lmj8jjqgk8xQgQhRqdHDhgoAnSWNqF8mViQvFlKaadK8HMAaSc8B9ZUxsHZ94MhpUJOpXgqTBUfGGwL8emnVBbozpsKYuft3t1YzM0nysHrXlcuH9pKFDbetOtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VGZbqcasdOHCNao/uu9PMHi1CadRMArxv4SnT0c/OE=;
 b=hPHv2kjpPi2ZZbdZysZx87b08VFZzewFGqExeLeXA1tDA0e22UzZWBrUYM2jZAs8afH84nn/tj2tAP6oEC9wQDoECglZiM2LeRGxOD0mTJspTidAxvBHaYCVUu7hrs28iJSBK5zZsjc2vTnsXWGj79htHTgWmTioMU6ZjO97fTw=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SA3PR18MB5625.namprd18.prod.outlook.com (2603:10b6:806:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 09:49:04 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 8 May 2024
 09:49:03 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Naveen
 Mamindlapalli <naveenm@marvell.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
Subject: Re: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue
 index of HTB class
Thread-Topic: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue
 index of HTB class
Thread-Index: AQHaoSz2ZI1f5da0kEayt7jEr0JQmw==
Date: Wed, 8 May 2024 09:49:03 +0000
Message-ID: 
 <PH0PR18MB44742A66DA0E93E219A154EADEE52@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240508070935.11501-1-hkelam@marvell.com>
 <f9c7f7ba-fa82-422a-be3c-fd5c50a63bfb@web.de>
In-Reply-To: <f9c7f7ba-fa82-422a-be3c-fd5c50a63bfb@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SA3PR18MB5625:EE_
x-ms-office365-filtering-correlation-id: 46805737-4643-4a8d-4cbb-08dc6f44187f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y3E2WTBzaU5BNkpSSFREajFoNUh2OCtpMVUxTGNvaFpqc3Y0c2pjSy9KeFMw?=
 =?utf-8?B?ekQ1dDF0UFlacExsNythS1c0cjVqbVJFcW90dUEwZGhmK2V4WENveU54U1lx?=
 =?utf-8?B?c1R5VWdFQU5xTXYxOE91cUNrMEwxRXMrdVJmcEc5c2N4c3IzamdQZWpEa1Zs?=
 =?utf-8?B?NTcxM2I2Zk4zSkx6UjJSVHVQNFM4UGhoS2hZdmpQSStMUkQwaGEwZFFLS1li?=
 =?utf-8?B?bkRSemx1dGN1YzE5TERJSmQyYXVkVmVHM00ya1RGUi9FUmNYY1k0U0Eyandv?=
 =?utf-8?B?THBJS0l4bGFFN0h2aU9GTGo1amVMcHdpcWNVT1lRRHp1NmQ0b3BKM2pidFBL?=
 =?utf-8?B?eWhzSjFEK0FzZ1hHcXZwanVvRlBmNUpkTXVNRFhUZDR1VnM1cldiQmZtclFZ?=
 =?utf-8?B?bEVHNGR4NlFKOW5XTzhMNndZZFVnUENkeXg4MHI3M3NxV2dqUUtNOFRYbmZr?=
 =?utf-8?B?USsxTWUzQklqc1hWUkpOcU5BaC9Kc2x2Z3p2MU9WRWhtcW1MZGd4NlFwSVV0?=
 =?utf-8?B?dGhaV0NKRVhuNjhpcmwwcUV5Rnh4U1YrWjhCK0NTZkJyRmRKeGthZmJ0WDBa?=
 =?utf-8?B?QmNaYiswbnU1bXROR1dyS0YzQnU2TGhsbWNRZHE3eEF1SDRkTUlxSlR2MEt4?=
 =?utf-8?B?ajhZU1JFbFlSbXpOam1PZXdWZWUwczYrUWw2cndPTWQrYlVJM0s3YndCR1Q0?=
 =?utf-8?B?WFAxWDAxWXQ1eUEyUkRURmx3dGNvQ1pKbU9TZGFRU0Q5YXd0RFNwL0NYNFhE?=
 =?utf-8?B?YkUxNUpiSzFGNittR2dqd3dtR1VOMWltaHdrWmpsS0F5VG9Rdkg1eUxJWnRT?=
 =?utf-8?B?VGZ1bk1IVUh2TEdXMGhVVnhORS9RelUzTXlZalViODUwMGNMc050d0N2WU9n?=
 =?utf-8?B?NzQxaHpLSFVwenpmVG1EdmlnUXYya1A1RGFHOHJOU1RqOVgxZEtVUTBMcDFY?=
 =?utf-8?B?S2pOUVNwc1N6OFF5TGQyWFRzUm9wOEdsSzNLeEZjZHFuR21BL1pzZGJjMEZs?=
 =?utf-8?B?UlNJQ3gxYXdUNE9BMVZMZWVwYVZIckh1SnlocFhCeSszZVBvY3g5SEZLYUl6?=
 =?utf-8?B?YksyY3BvRDJPaFlncTM5a3RBa0FQWENVZS9GTS9kWFhpNDRwaVRkRldUZWdD?=
 =?utf-8?B?T0RGTGRlNkdTb0tkaEJXN2RjOVl6ZXZTalBzenhKN3dGdVhsb25vYVlxbm41?=
 =?utf-8?B?VHBEK25rZnE1MTloeHJJRGVjZ0tOTmVhZFR4eU83NmdHUitjV05BV0dQV2tB?=
 =?utf-8?B?OGJyMWhla3ZyUXZTM0lXWjVzSFQ3UXJLT1BPRUtTdkNGWUJZVERvUU5SZ1A3?=
 =?utf-8?B?QWlZV2ZLVmRhQ0hDcWErM21mZmdqYXVLcVJBVGJoTWljME9JY24rWUNkdUk5?=
 =?utf-8?B?NEVidk1ZZmN6YUdqRVMyblUzbzM2akUwZjNVWmpxNGRETEtKa2xJM0kvQ1FR?=
 =?utf-8?B?UnFSY1FuKzRsSVlvQTFtMDVnd0NqOEorc1FSS003bDZJcmtCY0VQTm9TUE1M?=
 =?utf-8?B?Y21NMzlYMEdpYjhxUlIzMW1NbnBJVDIycC9HQ01lcFZzUUkxSWtTemxXZzZZ?=
 =?utf-8?B?bzcyRHUyeU1xQmVlY2xqY2J6ckdRMEpocGwrdzJvYWF2bzdtQXhuY1VrVDNt?=
 =?utf-8?B?SHl2cXNmT0g1dnBkVVp0NWNHbDN0RHNHNTdpRWlkaDB0eHFpbWlPRG1VOHgr?=
 =?utf-8?B?czlsdzh5aWVzc1pGbGlsVlVKai9udm9MZmRTZjZwVlczUm84YkZ2ZU9RPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N04xcFFyYWFrckt5RkMwaHJBUGtJYW5OWmV0eElCWjVqMDlpb3pJV2lTY0ZV?=
 =?utf-8?B?VFowNFBFUkdZUVkvdmRVR283RXYyRUF5Q0o4eU9PWDlBUUZVQ1dsdWU5QmpY?=
 =?utf-8?B?L3RURXRITGFoMW94NXlsQVRWMkU5dUlDRWl4MlIvK1A1b08rdm5Eb3k4T2JV?=
 =?utf-8?B?aVVyd203SVA4YkN1SFQvUHUzbCtvUjNIcG5IbVRrY01CeXJzOXoybThxOTNB?=
 =?utf-8?B?Q0RodmFoMU5Wbk1iNHdBOGpQN1hTN0hSMElPOWRwSTFZZDBKM2lpUHo2RURB?=
 =?utf-8?B?YzVrTXczT2FScEJlbit6NzdzcDRUQ2MrbXdLbTAxS2poRjZoWnl0dXJRQXpH?=
 =?utf-8?B?V0pYaGc5QlJOSEV4alZlbDBUWFp4d2JoNjFvbVNaYmVhcnl6aS9UbE1wdFZl?=
 =?utf-8?B?WXZYSWR0aUtZVTFoam5hVWtDZVB5TjBhR3JkRVNLYnhNblN3RU42OFNMaU9h?=
 =?utf-8?B?Ull2Y3RQMTkrcHByZFJJLzlPRHVtZDVBTEhuVHpWb1U5cWswOG9YbjQ0UlV1?=
 =?utf-8?B?TXV4MXF5cVhQZ0tOQWdxVmN4MjJOQnB0K0YxTUZuNEVUMUZETkFvaDY1T1NJ?=
 =?utf-8?B?UWV3TVRnS2R0VVpJMXI1TDJYRVNnbE9OT0lxUzNyUWhqaVZsZEhYWnZGNXNU?=
 =?utf-8?B?Y3h3SWJBTjB3dHdGQ2RvcUpyclVLNyt2Z2lobTJzNkplTFp1WEUzQmp1akRY?=
 =?utf-8?B?dVNEOFp4cmo4ZXdEUkR0OTB1Y2R0UkNSR0xaYkNuSzhLZzZrRXhRaVlXU29l?=
 =?utf-8?B?L3YwNXNXd2FjQTV0T1M4M3paN0g5MGk1RmZUbmZ4QTc0MUhqNndTejRXM0pK?=
 =?utf-8?B?S3pOdDVpZlhGdTBNa1I1TU04NjJURjhxbnM2aHl2RnRmNC9MOWY4aXhNelZo?=
 =?utf-8?B?OXpnU0EvSmtDZzVrM2hybEhYZ1RaVUk1dkhjelo0ZVZDZFJScDdyd21ZY1pX?=
 =?utf-8?B?ZzlwcnBNZmRiMERiNXd1NmFnZUYzbzF6c1JUYkptZWtKMFJSQ3NIZ1Z3dHVI?=
 =?utf-8?B?RnNISHYvVmM0STU5N3lXT3RZQ1p1UjBGdG5VTVRIMTNRN3dPTm4rZ1owY21x?=
 =?utf-8?B?UllWcG0xU3ZGaFFuVFRadnlQcDkwT1FNbUxhK25OZHVIdHFkT3pnRnhNRUFk?=
 =?utf-8?B?cVU1eC9QK21OcWs5K2llbmNzdmRIVkRXZzRKdU9FUi9INnNCWVVIc2psdkht?=
 =?utf-8?B?b1QvVVUrV3pNanBuOTVoUWdSc1pZdHNBTE5TV04yWEFDSHFvWW0xMThZZXBy?=
 =?utf-8?B?c0t0OHdXenF5UmVzL0FYS0ZzTGZ4TkpURWVaOFF1T0pzd21CZk1RQmpiSlhm?=
 =?utf-8?B?VTczUUZ0ck8vNGNhNE1raEJZeEJ3eTlQbWpqZEJmb2ZYU2tlSFBUSGZUZ2M3?=
 =?utf-8?B?bmdsOVdEU0FlVm9VQlpzbHJxY3JibWRLNlM4VUhZRFdHMmw1ZlFhOTYySDlS?=
 =?utf-8?B?ZHFmZXRmcXFXN2RGOVlCYWkxQklaYW44clp6VVhpZVVCbno2SE9iZkp3bEt2?=
 =?utf-8?B?ZUFKdjc5YS9pdVB1Q25HU0ZnZ0cwV1lPVVNNY0puK1JadHl5QUJmRE1FNFVD?=
 =?utf-8?B?OGU5VjNYdUlMWFdMeXJ0ZTdiOW1ONFYvREoxSDlOTmZ6OEJtOHpVUjNTQkx5?=
 =?utf-8?B?VllNZWJPWG5aeFkzczh2VEo0cFdVKzk2UnIxVmhsaVBTb1ltSTdZL2tPb0Jo?=
 =?utf-8?B?c0RVd1l0bHZIdmtmb05SZWpib2JUOFNZK01RSGZnbzhGTFRLc2lUMEVYMFlY?=
 =?utf-8?B?VGdWOHh3OWw3K2pLY0xsbHR1L3dNbVN4ZE16TEZzVlU3Wm05TVYxdnplSkJX?=
 =?utf-8?B?emVjT2tudTFpdHVwdWorSUt1Zngra0Jzb1A2YXB6Y3o4Q1BIVzliUGk5MjZt?=
 =?utf-8?B?STBiMXh2S2psRmIvVjdrNmNaYzBmelpXYWZoMzJMU1hucUljV1pkRlJGV244?=
 =?utf-8?B?MDI1UnJRQVhYZlFNS1JkNFlVOFNPVFBmZC9tczJDUzZYS2xZV1BXODdQZG53?=
 =?utf-8?B?b1VSeldoQy9lS1Y4cXlnaFRmMzl5TWdBQWFRelcrN2JjVDhaVjZjMk9MM3Q3?=
 =?utf-8?B?L05vRHpkRFpIOEpJVEdPdW5WSEVvK2hyL094NEJIdkNMY3JMQlNWazEwaXFO?=
 =?utf-8?Q?2aaY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46805737-4643-4a8d-4cbb-08dc6f44187f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 09:49:03.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQshLNGQCm+Ny2ZxPDeLxKc8FCH8UW7pg7ybO6AwM/AdtKOlR58wwh9XpovxxFA1XqjFEXMZ5BKrFOv7hOlL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5625
X-Proofpoint-ORIG-GUID: Xju2nVWdS80DGI9-KOSA0X98reTay5fP
X-Proofpoint-GUID: Xju2nVWdS80DGI9-KOSA0X98reTay5fP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_05,2024-05-08_01,2023-05-22_02

DQoNCj4g4oCmDQo+ID4gVGhpcyBwYXRjaCBzb2x2ZXMgdGhlIHByb2JsZW0gYnkgYXNzaWduaW5n
IGRlbGV0ZWQgY2xhc3MgdHJhbnNtaXQNCj4gPiBxdWV1ZS9zZW5kIHF1ZXVlIHRvIGFjdGl2ZSBj
bGFzcy4NCj4gDQo+ICogSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBhZGQgdGhlIHRhZyDigJxG
aXhlc+KAnT8NCj4gDQogICAgICBUaGlzIHBhdGNoIGlzIHRhcmdldGVkIHRvICJuZXQtbmV4dCIg
LHJlYXNvbiBiZWluZyBpdCBpbXBsZW1lbnRzIGEgbmV3IHdheSBvZiBhc3NpZ25pbmcgdHJhbnNt
aXQgcXVldWVzIHRvIHRoZSBIVEIgY2xhc3Nlcy4gDQpUaG91Z2ggdGhlIGNvbW1pdCBkZXNjcmlw
dGlvbiBtZW50aW9ucyBzb2x2aW5nIGEgcHJvYmxlbSwgYnV0IHRoZSBpbXBsZW1lbnRhdGlvbiB3
ZW50IGJleW9uZCBhIHNpbXBsZSBmaXguDQoNClRoYW5rcywNCkhhcmlwcmFzYWQgayANCg0KPiAq
IFdvdWxkIHlvdSBsaWtlIHRvIHVzZSBpbXBlcmF0aXZlIHdvcmRpbmdzIGZvciBhbiBpbXByb3Zl
ZCBjaGFuZ2UNCj4gZGVzY3JpcHRpb24/DQo+ICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9p
bnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0Lmtlcm5lbC5vcmdfcHViX3NjbV9saW51
eF9rZXJuZWxfZ2l0X3RvcnZhbGRzX2xpbnV4LmdpdF90cmVlX0RvY3VtDQo+IGVudGF0aW9uX3By
b2Nlc3Nfc3VibWl0dGluZy0yRHBhdGNoZXMucnN0LTNGaC0zRHY2LjktMkRyYzctDQo+IDIzbjk0
JmQ9RHdJRmFRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPTJiZDRrUDQ0RUNZRmdmLQ0KPiBL
b05TSldxRWlwRXRweFhuTkJLeTB2eW9KSjhBJm09TU92Y0FnaGhSQ0VsUHBzUm41dXhOSmhCUVp1
NEZsMy0NCj4gZGR2VTdXaEliejVBN3N1V1VTYXNfX2luclprOE1mX18mcz1DcTFjV1dsQjVXVW4x
T25vVzhhR19naGkNCj4gdzd4WGpOVnFoMkRzSWF1bUxSVSZlPQ0KPiANCj4gUmVnYXJkcywNCj4g
TWFya3VzDQo=

