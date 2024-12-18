Return-Path: <netdev+bounces-153037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1D9F69F8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3171883162
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49771150980;
	Wed, 18 Dec 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AIYcWGl0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6A481B3;
	Wed, 18 Dec 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535534; cv=fail; b=KL2Zqla0mvmlenh0/953mb2j4eq6ZvthHDNqCDnInIx/yhMKFJiO+VNVNjG3rC1uPRh2E6P+SGJSH11CdI523EZQFMCord+nPst2HAijxMvNSkNgVYdcM5JyPyNa96EcJSUhtDCRg9OM9MW7M544IGD7hLCOI0Y446uSB/3aou0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535534; c=relaxed/simple;
	bh=BJaLhfi2UucKWsjoHsGZBBg2/hacowgV4s1PwgZCO+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bPWyUE+GT30hFb78JJkabZnAI41u6bM3RG65Kt4MNbStJ5pxDZLXu8ZIB4ENgA/9DeoVXltmFxoKoXZ7epUeLzK0gDl5oO8CMJhRUTQvidU8I2DlDXNJMsiqANI8t89xDBiJtkSHCODv8ALBPT3sL3Wr2Ku8vGF0QvUJ/4C9vWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AIYcWGl0; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDTWlP017341;
	Wed, 18 Dec 2024 07:25:16 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kyaf080b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 07:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn7M6EovP1Uu3HAXcyap32xjBO7vcoRV5mZIFWxY9BPc+4yjeCXXR8UGZOyhStA06/dTcWSuXIFyt5L8FzfsFV19LYTfVXim3esqS6DbSfowTfv+F1ilRUIFoKn1UPUT6Dj51qjo02s7bcn9v+lRXoXiXQL2eeBZYc0Xg8UULdYtBctr25afJAAccZ1fty5X/PMds7KkvDjjXTwnudojWS3qKXqllv0Wk64QYXEBHFPPo4xGnjc6NDaco4Ue3oFxu5QlCMfVXZmyqgjLBpzxEhO7AHIJbG0/0B6mdKRMb7rU0orskw+YCRbcnPAjuISSbnY28J7rAfUuBGgu4rnmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJaLhfi2UucKWsjoHsGZBBg2/hacowgV4s1PwgZCO+Q=;
 b=Beg127uHWTup8FCT9bPfZ/7vPp5c3NhCQKiZDic5/cbMMfi3qCwbXM7OQCdvaU7XZxRPrW5zraincsxwcxpzxi+s+AVGnZAL6Fuco/VgBv0wsfNy1srYznvf4slfWkkUDWSFL/cFs0Aygob0+L4kCdBiWn9iklQ4U/KQIMiOIprhv+1SldzLiqwxACf3GFOnNosWOx0dWtJDCjDCR6Fw3xx2zWBIt04T+Kq5QOw2orKzycYPyd0kDJysB9+GHDw1pWgTGlmPC77oAKv12WXdRiIwG/8ZdSMrpUldkoV5pdplUb4HFzj93IbsjIkI0vvrRpFCmSELPBvhqCHVx+5VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJaLhfi2UucKWsjoHsGZBBg2/hacowgV4s1PwgZCO+Q=;
 b=AIYcWGl0nDeFGdPWxSCZj0ag7vFg4hjakiiYSDozjCT2RnJRgUf4H8rJgOmMFYCGnnEYlexBgDV0kSBcKRTXPyIGPvbxs4P+GNMtzCQEG/UnZZOSrFpL2WzEP243B0p934yFL9uoAeH8Mm+Y9T7RFqp2Xf4r6XMdjWJyagXwBDQ=
Received: from BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14)
 by SN7PR18MB5342.namprd18.prod.outlook.com (2603:10b6:806:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:25:13 +0000
Received: from BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db]) by BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 15:25:13 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Eric Dumazet <edumazet@google.com>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index:
 AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAAEnACAAD0IMIABfHCAgAAKTTCAAUofAIAAD6YAgAAH6gCAAAPGAIAAAZdw
Date: Wed, 18 Dec 2024 15:25:13 +0000
Message-ID:
 <BY3PR18MB472105E5D09B8FE018DBFC15C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
 <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
In-Reply-To:
 <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4721:EE_|SN7PR18MB5342:EE_
x-ms-office365-filtering-correlation-id: 5373d654-a2b4-4746-6c4c-08dd1f782af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnBCa2ZibnJxZXNlWHQzYkdvVE9CWHkrMHFRR3RXa0VhajlEQUVETUtQV1M1?=
 =?utf-8?B?UWFoRnZwZ2JYQzJTM01vN3ZWMDFJOUhxYVJSRURUektMOWtrVVMzendoSENH?=
 =?utf-8?B?RWRNMkR0UnFGYUIwVE96R0VFWHJQQ0JnZ3A3ZXdHTENaMGRMZHgzQ3doVkt6?=
 =?utf-8?B?SzE5dnYyd2IrTzhVWE5yTVlKWVBiVUR2MmtSS2FoMG1laHUvV0dZNnc0dXN3?=
 =?utf-8?B?VThNdDZ2TzhMYXZyMFM5TDgvL0w4OHN1YlZUakt6N3RueXYwZ1Z6Y3NXY3M3?=
 =?utf-8?B?WUZNSzZZalhtbXhkMEtycHdQZmtjbmNOY1VxQzNIOTJpYlZtYUFDUStVZzdy?=
 =?utf-8?B?cmxlVWhQc0FCQldZd3B6WEJEY1R4WGRSdVUrWDJ2WkhkVzFyZzdQempxb3NI?=
 =?utf-8?B?eVNjZ0hCR2t1Wi9OQTB2R3Z6bGh0QmxRV3d2Z2g3YXk1b1FJZ2lkWm9CYjQ1?=
 =?utf-8?B?MmdFZFgzY0JtbzNmKzhLUzE3U0dyNVJURCtkME5RUHVPWDN6Y2ltYmhqeENP?=
 =?utf-8?B?Smswdzhwc1NXTnQvSFJYUVdKUFpHYlVwa2dWa0ZrMm1GM3dyVFpxaHUvQVFR?=
 =?utf-8?B?NFlzRXd0OGVWYmp3NWFBWHF3elM2L3NCVy9xbFl3a3RrQ0lVOXg2Z0RSelNz?=
 =?utf-8?B?NllEWlltbWFwWGFGM3kxSFhVUWd1ckl1V2ZBM0tINkJPd2ZrMEhkQkpwa0JH?=
 =?utf-8?B?VUxDaTZORCs1b0xxaWV0bUtXdDFYVUxESTlvVFErVEE2UUZDVXBTWUJTRWFm?=
 =?utf-8?B?Q0VCTEExZEtZa05GaGFFRDBhRlJmSHVGQkh4OGt6bURLNmZBcGF0cDhWSmhI?=
 =?utf-8?B?ZW5NYWFNRjNxSDJnWVB4YUhGUmthazhUelpqZm8rdUtmY0ZsdUhuZXZDVDk1?=
 =?utf-8?B?dFoya1N0blNUYkdmVXpGVnpFZUx4bkcrVGJEa2dpOVJOYzZLR2s3N0FLdHRt?=
 =?utf-8?B?SHp2OHdMNlJVQnZPM1RZT0FxNmpsdDVFQ0JSQjQ3eWRXWk9XVUUzcHlmMFNn?=
 =?utf-8?B?bGdldzk4ZUlnTGNHMFBBWXp6cEp3Z1RGdHdONnROV21lVmh0TThCZEN0Sjlq?=
 =?utf-8?B?U3JoS0Z1NXpiWThzeUVRVTlBRGtoNVBlbU1KWCt5VnZBekJUR0xGSFlwcEpp?=
 =?utf-8?B?cUtiZXNVaVkydG16ZUFxT29IVHM2ZFhwYnlmbDBDWEs4KzVURXJBVXQxbkpi?=
 =?utf-8?B?ekRtdmg4UGlmVWpNNmY3SXlrcmNBYW5sb2JLV0doempDY0xDYVRWK3dNaDZL?=
 =?utf-8?B?TDZFRVEzUUo2L0xhSlRrSWFRZnRPUU0vMmtGVzIxbktjWTBwVFFvU3pqS0V2?=
 =?utf-8?B?Ky9XL2w2MjFETmdDc1NFTFlYdDVRUDRSenM5ejFNc2l1V3NjS0tLTEFKYUVF?=
 =?utf-8?B?UGxKUmdVZUdCRkVRQlpNWE5nT3pBTldaWTBkNWxVaGExWUZQdDdWb0w0S3Fj?=
 =?utf-8?B?REpuZGQ5WlFNbDFkSGpvMkN1c05tTmptUUY4WFM5QldIK08vTVdlS2ZhMFZm?=
 =?utf-8?B?bFFLZ0hVVjgyRVJ2SElhMUE4d1dua1pDQzM3eWNtbFlQbWpuSjMza0dzVXJs?=
 =?utf-8?B?RmRYR1ROVFYyVmJkdDFlRzNwWkJ5UUdPcFNPazMrMmJsMit2SXdTRDdreHBm?=
 =?utf-8?B?UUE3ZTZmcnRKSzQrZVN3blpZdE5PRnNhdW5TNDFSVkZwd1NTVjQwdDV1MTNl?=
 =?utf-8?B?YVBhNzNRN1V4MUpZdUgvTTRpWk9Pc1FZVE90cWtHUitHa3EyY05QN0h0azF4?=
 =?utf-8?B?UnRIeFcxZ0xwaWJWai8xTFI2bTA5d2JnaVc3TzRwcnVXVFJTZHdFeGpNSkhW?=
 =?utf-8?B?NXFrdjg3Wm9XZ3JPNHZmTTJTQmM0RURjUCt2TTdaR0NOdXFqcTZaUjhiR1gr?=
 =?utf-8?B?eTYyazFBRnBnVE11ck1MOFhGR2xmN2ppT0poZmJNV1QyaWRiSWYrUlRzQ2VM?=
 =?utf-8?Q?+fe4VU+fMnaxtZNm/u08/1ldCtUy6WzK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4721.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDNOdjQwam1iZmpPM3pweGRQTjZBR3JTclRXOTdnUzQ2cGcwazIrT012bnli?=
 =?utf-8?B?TGJlYTNKdlFTTnh2MlQzejE0MUF1NldDdGlqMGZ3UTgyVkgycm1Tbll1bUxG?=
 =?utf-8?B?OEVFUGF0b3VPUW1DVW14L2VmS2Vidy9FRkJMcWg3aUdhTjlodGtBS3VsSWtx?=
 =?utf-8?B?b0RmRkMyK1NGclA2aHM3ckpEYXoxcmUrcHFtNHlIMXR5Si9WM0JsMzlzd1Y4?=
 =?utf-8?B?L3phdzJoN241VS82MkV1TGpBUlNrQUpOeUttTDJXUllXUytuK2VmZ1ROTEI3?=
 =?utf-8?B?RVdnMUZzZGtHK1p5c0RPMFVoazJ4N213bkJmeVhVekxHYkluWThvYmdpOEVs?=
 =?utf-8?B?eGR2WlExRkNYUWova2RldS9rVzM0enBhTEV4a3hGNWtTdzVqM0N2ME95eVpD?=
 =?utf-8?B?SHh5c1AxTGZkVkpuaTMyRmgyajlFTkZwbENFQ2VsY0FpMFk2dzE2OHRFalV2?=
 =?utf-8?B?SmhLSWp1T25SQmpKenJoNkNrTkVLS25qWS8yWlZYZHlYd1hRdU4zenh1WGt4?=
 =?utf-8?B?R2FHS1p4dnBmaUNCMnJ0VUZ0UE44YVcwYVV0SHdPajczOXFiL1M3blYydnBK?=
 =?utf-8?B?dEYrR3VmcHRtRW96OTRqV2JmaVJhMGRzTXZyMnF6OU04S1NoZDZIeXgvWWxF?=
 =?utf-8?B?bUZUQmFhWEJjOHJhdUNCRE1yam0vYjJtQnNoTkprRHdaWWpQQ3hKcjVlUjFN?=
 =?utf-8?B?amYrcmM1L0owOWVBeEUzSGxITlVFTGlTMjJpM0pidUxJYnc5VDZmZzFoVzF4?=
 =?utf-8?B?Mm43STkrRDFyOTVGRXd4eWhHUDRNclAzcDRzQTZWKzBUWUpMTElxUXlkcVA3?=
 =?utf-8?B?SGJSNDFwUWVlbjRKM0E5Ky9MT3IzYkZJTy9GcVNyNElQcVcvaDNwTUs3OTJh?=
 =?utf-8?B?eE54b2lqNGptRE9jcWMvZ3JmckJpVXo4ZjZxcXNObjVaSFZOVlFMeXNGZGE2?=
 =?utf-8?B?YmpEZXNKYjlLSkF2TWl1Njh1QzlHdXR3bFNPclBSOUxEc1Z5dlBCZGlIbUpN?=
 =?utf-8?B?SEcxMTNOcUx6OE1lN2dkNjVJTUFUL25VbkM1R1VuNVlZMnpPc21WOHQ2Mm8y?=
 =?utf-8?B?RnY4TUtteENwWE5CaFEvSFB6K3VOWW5OOUZJMFRCU215dEdKZG94TklSM1k5?=
 =?utf-8?B?dWJ6c1FFY1hxOGlPRTJaeFV6N3lmTkIzVjN0NFVGc0tXQ2M1aG1mcy9nTkRh?=
 =?utf-8?B?MzA4ekFEOFpkVVMrVzZ6VmNWU2d5Tnh1eEk3UEhwVHFZRnZUR2ltV0x6ZzNO?=
 =?utf-8?B?Z1lXVy90N0duaUZ6SEQxNm53bkhRU2pYblVXa21JV0t5ZzdqSjV6NXJzSldF?=
 =?utf-8?B?enRIRThFbGpDZDUvbmpaLzVhRzRaNDQ4b2xzOW9iOUFHS3hEdWhGb0kwdW43?=
 =?utf-8?B?cndVVnl6MVZOcG5ib04rWmFDcVh1ZUhFQkIxNVBhVUZqWktwK2pRTGM4WFpF?=
 =?utf-8?B?aE1uanZLWDFhcnRCN09DY2ZVa01EeHZ4V2hGbm5LUCtWTmJiNGRFeUx3NjRU?=
 =?utf-8?B?aUx0eHlwQVFXdWxOcGRvZVk3SElnREw0S0hsZnJMQ1hXN0RhV09XU2dlUHVL?=
 =?utf-8?B?d2VkNms5TVRrTEZtR1hyWGJQVm9ZOHVaa04wSXI5S3hlWHhUdlRmWnErVWRD?=
 =?utf-8?B?QS8vSkxwTTcwa01mWDEyc1d0bDJadzdCZ2k5RUI3enJCdGlUNm8xODZPY09w?=
 =?utf-8?B?RmJQN1JIc21qaGYwUU5ySnA0TWNqd0F6SlZma2VVRWloZzhuSFFLb1hDUmRG?=
 =?utf-8?B?VDU1MFhqTUNSa0U3VStuQkNTQlNqUmtsRzRXUUtxS0FWOVNNeGVyTWJiY0Fm?=
 =?utf-8?B?ZU5jQ1ZlcENHZkNFM2dDNHV0N1BsaDMyZXhuZVRkZkpGOEdFcThXWHVpSjVI?=
 =?utf-8?B?SGF0Nmd1QlhneWxPSkJwQ3FrQTI3R0FCck1KbDVidnRQL1VBMXUxSGpWSnlp?=
 =?utf-8?B?bUVvV2NhV0gwVU9QcXRoVDF6NFAvYndHanIzMkZIaHlNdEwxalJWeWt1Yy9q?=
 =?utf-8?B?R21yVGRDWGxaWG4rY25MdUt0bEVFZUR1WHRVdkdZWmNGWFdHU1dSeWpaSjV4?=
 =?utf-8?B?MXRROXViOUtZcVJCN0RLV1N3aFpYVVg5TWVyaFhPdkxaWmx3OUZvRUx3SGI4?=
 =?utf-8?Q?yOYm/gmzcvRCrXqdynrbJ51nW?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4721.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5373d654-a2b4-4746-6c4c-08dd1f782af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 15:25:13.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpdPLV8PJxiybCTdR5KrDa9HZEgorD7IWTGtBbK6eI7oIJjX/VsEOIZ55OowtuaW+AtgDvcWl9KrvuOqrlUYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5342
X-Proofpoint-GUID: 8iHockONmkh7xA2voSq8xS1mLMZn8Q8F
X-Proofpoint-ORIG-GUID: 8iHockONmkh7xA2voSq8xS1mLMZn8Q8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQo+ID4gT24gV2VkLCBEZWMgMTgsIDIwMjQgYXQgMDM6MjE6MTJQTSArMDEwMCwgRXJpYyBEdW1h
emV0IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBEZWMgMTgsIDIwMjQgYXQgMjoyNeKAr1BNIExhcnlz
YSBaYXJlbWJhDQo+IDxsYXJ5c2EuemFyZW1iYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gSXQgaXMgaGFyZCB0byBrbm93IHdpdGhvdXQgdGVzdGluZyAoYnV0IHRl
c3Rpbmcgc2hvdWxkIG5vdCBiZSBoYXJkKS4gSQ0KPiB0aGluayB0aGUNCj4gPiA+ID4gcGhyYXNl
ICJTdGF0aXN0aWNzIG11c3QgcGVyc2lzdCBhY3Jvc3Mgcm91dGluZSBvcGVyYXRpb25zIGxpa2Ug
YnJpbmdpbmcgdGhlDQo+ID4gPiA+IGludGVyZmFjZSBkb3duIGFuZCB1cC4iIFswXSBpbXBsaWVz
IHRoYXQgYnJpbmdpbmcgdGhlIGludGVyZmFjZSBkb3duDQo+IG1heSBub3QNCj4gPiA+ID4gbmVj
ZXNzYXJpbHkgcHJldmVudCBzdGF0cyBjYWxscy4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgZG9uJ3Qg
IGFkZCB3b3JrYXJvdW5kcyB0byBpbmRpdmlkdWFsIGRyaXZlcnMuDQo+ID4gPg0KPiA+ID4gSSB0
aGluayB0aGUgY29yZSBuZXR3b3JraW5nIHN0YWNrIHNob3VsZCBoYW5kbGUgdGhlIHBvc3NpYmxl
IHJhY2VzLg0KPiA+ID4NCj4gPiA+IE1vc3QgZGV2X2dldF9zdGF0cygpIGNhbGxlcnMgYXJlIGNv
cnJlY3RseSB0ZXN0aW5nIGRldl9pc2FsaXZlKCkgb3INCj4gPiA+IGFyZSBwcm90ZWN0ZWQgYnkg
UlROTC4NCj4gPiA+DQo+ID4gPiBUaGVyZSBhcmUgZmV3IG5lc3RlZCBjYXNlcyB0aGF0IGFyZSBu
b3QgcHJvcGVybHkgaGFuZGxlZCwgdGhlDQo+ID4gPiBmb2xsb3dpbmcgcGF0Y2ggc2hvdWxkIHRh
a2UgY2FyZSBvZiB0aGVtLg0KPiA+ID4NCj4gPg0KPiA+IEkgd2FzIHVuZGVyIHRoZSBpbXByZXNz
aW9uIHRoYXQgLm5kb19zdG9wKCkgYmVpbmcgY2FsbGVkIGRvZXMgbm90IG1lYW4gdGhlDQo+ID4g
ZGV2aWNlIHN0b3BzIGJlaW5nIE5FVFJFR19SRUdJU1RFUkVELCBzdWNoIGxpbmsgd291bGQgYmUg
cmVxdWlyZWQgdG8NCj4gc29sdmUgdGhlDQo+ID4gb3JpZ2luYWwgcHJvYmxlbSAgd2l0aCB5b3Vy
IHBhdGNoIGFsb25lICh0aG91Z2ggaXQgaXMgZ2VuZXJhbGx5IGEgZ29vZA0KPiBjaGFuZ2UpLg0K
PiA+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB0aGlzIHJlbGF0aW9uPw0KPiA+DQo+IA0KPiBu
ZG9fc3RvcCgpIGJlaW5nIGNhbGxlZCBtdXN0IGhhdmUgbm8gaW1wYWN0IG9uIHN0YXRpc3RpY3Mg
Og0KPiANCj4gIyBpcCAtcyBsaW5rIHNoIGRldiBsbw0KPiAxOiBsbzogPExPT1BCQUNLLFVQLExP
V0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mgbm9xdWV1ZSBzdGF0ZSBVTktOT1dODQo+IG1vZGUgREVG
QVVMVCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KPiAgICAgbGluay9sb29wYmFjayAwMDowMDow
MDowMDowMDowMCBicmQgMDA6MDA6MDA6MDA6MDA6MDANCj4gICAgIFJYOiAgYnl0ZXMgcGFja2V0
cyBlcnJvcnMgZHJvcHBlZCAgbWlzc2VkICAgbWNhc3QNCj4gICAgICAgIDM0NzM1NjggICA0MTM1
MiAgICAgIDAgICAgICAgMCAgICAgICAwICAgICAgIDANCj4gICAgIFRYOiAgYnl0ZXMgcGFja2V0
cyBlcnJvcnMgZHJvcHBlZCBjYXJyaWVyIGNvbGxzbnMNCj4gICAgICAgIDM0NzM1NjggICA0MTM1
MiAgICAgIDAgICAgICAgMCAgICAgICAwICAgICAgIDANCj4gDQo+ICMgaXAgbGluayBzZXQgZGV2
IGxvIGRvd24gICMgd291bGQgY2FsbCBuZG9fc3RvcCgpIGlmIGxvb3BiYWNrIGhhZCBvbmUNCj4g
DQo+ICMgaXAgLXMgbGluayBzaCBkZXYgbG8NCj4gMTogbG86IDxMT09QQkFDSz4gbXR1IDY1NTM2
IHFkaXNjIG5vcXVldWUgc3RhdGUgRE9XTiBtb2RlIERFRkFVTFQNCj4gZ3JvdXAgZGVmYXVsdCBx
bGVuIDEwMDANCj4gICAgIGxpbmsvbG9vcGJhY2sgMDA6MDA6MDA6MDA6MDA6MDAgYnJkIDAwOjAw
OjAwOjAwOjAwOjAwDQo+ICAgICBSWDogIGJ5dGVzIHBhY2tldHMgZXJyb3JzIGRyb3BwZWQgIG1p
c3NlZCAgIG1jYXN0DQo+ICAgICAgICAzNDczNTY4ICAgNDEzNTIgICAgICAwICAgICAgIDAgICAg
ICAgMCAgICAgICAwDQo+ICAgICBUWDogIGJ5dGVzIHBhY2tldHMgZXJyb3JzIGRyb3BwZWQgY2Fy
cmllciBjb2xsc25zDQo+ICAgICAgICAzNDczNTY4ICAgNDEzNTIgICAgICAwICAgICAgIDAgICAg
ICAgMCAgICAgICAwDQo+IA0KPiANCj4gU28gcGVyaGFwcyB0aGUgcHJvYmxlbSB3aXRoIHRoaXMg
ZHJpdmVyIGlzIHRoYXQgaXRzIG5kb19zdG9wKCkgaXMNCj4gZG9pbmcgdGhpbmdzIGl0IHNob3Vs
ZCBub3QuDQoNCkhpIEVyaWMsDQoNClRoaXMgcGF0Y2ggaXMgbm90IGEgd29ya2Fyb3VuZC4gSW4g
c29tZSBzZXR1cHMsIHdlIHdlcmUgc2VlaW5nIHJhY2VzIHdpdGggcmVnYXJkcw0KdG8gcmVzb3Vy
Y2UgZnJlZWluZyBiZXR3ZWVuIG5kb19zdG9wKCkgYW5kIG5kb19nZXRfc3RhdHMoKS4gSGVuY2Ug
dG8gc3luYyB3aXRoIHRoZSB2aWV3IG9mDQpyZXNvdXJjZXMsIGEgc3luY2hyb25pemVfbmV0KCkg
aXMgY2FsbGVkIGluIG5kb19zdG9wKCkuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugc2VlIGFu
eXRoaW5nIHdyb25nIGhlcmUuDQoNClRoYW5rcw0K

