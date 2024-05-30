Return-Path: <netdev+bounces-99285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F88D4494
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5856F285D4E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2414388D;
	Thu, 30 May 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="cE+I5dUo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED425763;
	Thu, 30 May 2024 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717044024; cv=fail; b=ETSZjMIao9LZgwql7zSIWthpSq7UiFVLDVOek15vfTaWDDoye7TT/utyx4AiPDdaZmyCt/evlhEAF51nusYHprdUr4PbdaxCul3XsO0xJb5eXIqRkTCakXE8DyZA5PRLHLsgawpvyi/K0oEt2TOUL+rt255YisG7zD4wuZgheTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717044024; c=relaxed/simple;
	bh=kmbL2XjnCtzvK9b4hlQGKaCnI0eMa56CA+zPGnwBxNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgZ8z26XBZh/Yazu+Xd+oDQeZ4zKmIYVcf/MKE3Kw+alhLGfBC+RryUvQiC9SdfhuFaSYJ5JhmJ2Lr/2BVUgQQ2wFGuScOaEmIL+6CPwquDfRVqm1lc0kM3uTNw5bS++nFvNZmI6ppscFA4FCNndzO5mJg9FhxwALs52a0HultI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=cE+I5dUo; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U2LgQH024101;
	Wed, 29 May 2024 21:39:51 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn0anu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 21:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiVssdhssdpRbfpTZFKm5+HktAC61XpLzCmQhcLZgAuBjp2/KBTfpd1xtF/KW+0KNyQvrqwqtrOQdX5pKvN+E0+wpZJmRhiIULsdWF81F5IIZIggJWtFL5csbWNfVh/XVcRpKaM1KaaadUqzKZtWqOm1XcryAKBB5nWZEP2ASMXeaG2VKE+618c4xZx9PVvKZjlnCe/q/PV/fl9wo+FwVObUDPZqKXLwwWawlCExrRQLwuVZSncf+4gU4wYDdGruJaJqqkAB5vT7nyJsZOsNOMvDJE4aL0TT41m3yQ1g34bpaGY2ApPvVZo/PzWxSNdWrhh8ywI/p6hW2U6yPc1Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmbL2XjnCtzvK9b4hlQGKaCnI0eMa56CA+zPGnwBxNM=;
 b=HT2s9BCEejYlWexGKmAhxHDSHl+Yr89UAOs2Oo62GlWWsiPQBm9EzUKCH+wwNEyq6is1f19TMrITeD2xxA+iUBkHnvneQne/mMFBVz40HdZDvbSzBlUhvM4HOazJ/oDJST0cdjjniL9QPlP8DGxMD3Eqhb5rI1j0DGUuMHfLZgSy5vu0xruPsS9f/7IAMaWy8jVarsQCo1/6SsHgr7uIHBV9NHd3oY+Ncwdi6bIRcCNzLvyROMGr1+XkcFOsDSuiNWtiQrxmx+0jJm+swzMeWse/L6i00xBGoY6WZrvOzmkDzJofV9HoyJWB7p6uR5jWbPj+DVWhRYhkkqCGR7imww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmbL2XjnCtzvK9b4hlQGKaCnI0eMa56CA+zPGnwBxNM=;
 b=cE+I5dUo35mqG//KOA3F8xxHnRzxTLKHAX8GEF9poJASK7jerJ19oFRA1XWCyH7A8sGQcdrAFy0DiN/zkPQJ74X4ymeYhWTOfmLf07xkrwnghfCNTO8XbgwkpcoLlxXXGnFb8DNqh+fVJh+gl77Lpz1JqkhqNBZUdK/wVS8Flbg=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by CH3PR18MB5794.namprd18.prod.outlook.com (2603:10b6:610:1b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 04:39:47 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 04:39:46 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>,
        =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
	<Sam.Shih@mediatek.com>,
        "linux@fw-web.de" <linux@fw-web.de>,
        "john@phrozen.org" <john@phrozen.org>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "frank-w@public-files.de"
	<frank-w@public-files.de>,
        Sean Wang <Sean.Wang@mediatek.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasX5cqaDOSKO1+UOevLBWKIgzS7GufW4wgACGFACAAC/Q/w==
Date: Thu, 30 May 2024 04:39:46 +0000
Message-ID: 
 <BY3PR18MB473789B7BACF95C69D196B01C6F32@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527142142.126796-1-linux@fw-web.de>
	 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
	 <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
	 <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
	 <BY3PR18MB4737EC8554AA453AF4B332E8C6F22@BY3PR18MB4737.namprd18.prod.outlook.com>
 <4611828c0f2a4e9c8157e583217b7bc5072dc4ea.camel@mediatek.com>
In-Reply-To: <4611828c0f2a4e9c8157e583217b7bc5072dc4ea.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|CH3PR18MB5794:EE_
x-ms-office365-filtering-correlation-id: 40911884-0ccc-4f14-63fd-08dc806288ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d0xZbDl5bjhad2R2T1VLNXJpT1h3dkxJWi9ZcnhKRVVMQm1tOGk3N1Z3K05J?=
 =?utf-8?B?ckcwSjUrNXQ2WEhTVFRyZTZvSE51ajNFVDlZdXVEYkVVNUVCOFFnRlRLUUkz?=
 =?utf-8?B?aW5aUmlReXppaGJpaVh2NWRsNjk5Qnh0YVhKc00rMS9TUm9xNE9yS0krdVRC?=
 =?utf-8?B?UnBwNUtxOW1LZGU4dHdEdWJwSDhFN0RiSlJURkwrNVUxWFc3YjNaSDNQdWNU?=
 =?utf-8?B?dGEwYzAxTVV0RHRHSVV3eEVtcm5rTER3T0IwVVlFb2M1VG5nbmxNL2tta2Jz?=
 =?utf-8?B?aVJLRGFBaUs1RWJvMVlLWk9JOGFMa0VOTTZIOWFNdzdqN0lmL1pVUVpidVl5?=
 =?utf-8?B?Sk1RZEpyY1ExL3llbEdySFdYVlFqYnpXc3lJS2s3aHRjbzBXcS9IZGNGekdn?=
 =?utf-8?B?MmlvalFqK0crQUF0QkRNMDU2U1ZzZCtoTWFBZE9LazI3ZmVPbUJmSnFFSTVh?=
 =?utf-8?B?N0dPdXU1VG5EcW81KzNSSWNzVW9jdG1tdC92b0pPV0FZRmxEcDZzUEl2WW9R?=
 =?utf-8?B?WkRZeWFYYUNBU01xQmhHZjZSbkRvRWsxbmh6WENuMVIzOW9DNmpYMFNINDE5?=
 =?utf-8?B?empUdFozUERXRC9UekYwSmFmOCt1WGIrcyt5cTQ1VTEzd1A0alcyS3NESVd0?=
 =?utf-8?B?Y0lwSjkyelhpTXlSQ0MyNDNIRi91cnJPaGRRdGFoQ2M3VUMzeWdlc0YxNU5O?=
 =?utf-8?B?WHNpSTJ4dS9Xd2MxamprRG5BUXhYclI5aHlkUWZtclQ2YjQ3djNSWGNkWkpq?=
 =?utf-8?B?Ky9pdkFUc1FpNWovN2txdTZGOU1kZXVLOGRTYnR4MWFZcnlhK1JwU1VLZGhZ?=
 =?utf-8?B?cFBtSnZrcnFVR0NEVHJUemZRUWw0THVidWpRalpTVEJDWW40ZVc1L2UvV0Vo?=
 =?utf-8?B?SzNzMm16WlhMSWN2YldZOThoSlNJZW95dU5GRzRDOCtFdjlybGt4QVFnNzhx?=
 =?utf-8?B?ODE0MXZUTFVld1YySWhGZDN6TTNYNWg0Nlc3TjRXWGllOWxqcngxQ2VPMlVl?=
 =?utf-8?B?a0xLenVuUmgweEI0UDRqVnVuRUQyUDJWTzYzUFgzQ2I1Y0NXcnJlSStBR01J?=
 =?utf-8?B?TmdCd0kyQ2daL1pvL1hvTFpBK3YxckZrbzZDSnJwcGxFd0hpUGEzeitDR3E3?=
 =?utf-8?B?N05TbDVhU1ZYMEpEODRhaTc5K0pLZnNTQWorclczalZ0eUVyTUl6MEp6Z3Nu?=
 =?utf-8?B?QXovZDB4clN0cTM4d2FXWFd4M2lEMHZwQ2NCcityYzV3RGQ5ekhmV2tkTGUx?=
 =?utf-8?B?U013L3ZZMnZDQ2ZLdnRVWWNuQ1RmWDRranBsWGwxM3AwMHpyWE9BdU9rNkl1?=
 =?utf-8?B?cmp5OFhMTWxEamFId2h3MXUydlBqZkprWVlWYlNkRUd4NkRlbTNJaEN0OEUv?=
 =?utf-8?B?L0FXWWk5R3B0OTZBT0ErWlFoaW1YWVdUL3Q2N0djS1owbit2YVdsTTNYazlS?=
 =?utf-8?B?UTR3YlhXVnYxcmhaaEdsL01ablU0T29ZTkhZL0JqL2ZHTGlzRkhuTTNCZGdU?=
 =?utf-8?B?TjVZYytJRE05ckJQSDdKQTdYYjV1eSsvZFlDM0RoNUt0WDd6cXpHaldJZTE2?=
 =?utf-8?B?dkV6Y0J3R05iS3F3NzI3ZlByUk5XSjV0ZzVwZFFDUnp4MXNNdGoxamxpeVFS?=
 =?utf-8?B?d3ZDYjVINXhGVkYvbnNTUlBXbkRYcm0yU1VuOGU5MWc5WXkxRWtTaVFOZ21q?=
 =?utf-8?B?UGZaM3hDbW5HU0hFVENGVVIzb2NidkZuVzAyQ3hsR2dTQ1pXOEJTOHZPbkdn?=
 =?utf-8?B?TnBoZ1N1MGZWRDRYRkYwa2hRWXJORFFCZlpmVk4wb3gzZUtkV0FaMVZPMm8w?=
 =?utf-8?B?L2cyem9VbW5YcGFwMHgwZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SkRwUkRTdk9lbFhRZnpUSTFNektHRjJHbmhVbGF3S2ZYVGlSdG1aaTZGS01D?=
 =?utf-8?B?OEFSOUVuQ1ZLQUNUc0x6WTdUcFRuRjMyNVNFZ3dBUnRTQUtNcVFuZVh2b3ZG?=
 =?utf-8?B?RjhwL0o2R1RhTGRaMHp3TWJ0aUpyYlg1aSswK2VBVUQvNDdZcVVkNUlZaGhY?=
 =?utf-8?B?TTdBTXljTCtadjNoaHFNTDVaTGpSTm10TzhqUEhrMzZXbkdSVmNaUzBRaGth?=
 =?utf-8?B?SExOWjlHNnQ5aG5jSnlhb1p4TUNORDBXdUY5NmNySHpORFNHUHpSdkY3WnUw?=
 =?utf-8?B?SHV2aHNzMkExbFlNMXZYYlloZC91bWRZaW8rZWZvaFEycmRoZ0svU0t2R0JZ?=
 =?utf-8?B?Wk5xTjVSTE1YdmZwMGkxR2lKNjc4LzV6ck9iYjRBSkg2ODdOSGF5bWRPNmk2?=
 =?utf-8?B?bEpzalRuclpnMWVMNkhFVWttcGd5MDZReFZoWjBpK2dnbHFEcHJEcXJnMUI1?=
 =?utf-8?B?dEhsRFI1WmtGUlZNVkpPMVFNeTR3anJiZjJhUnNQRURDZ2c1N21DbGZMeWVu?=
 =?utf-8?B?cGZPMHE0ajZERmtLaHFCMzV3S202cm9mN3FIMWY2YWdDMk8xdUtMZVlQSEJu?=
 =?utf-8?B?MmJMYTJWb0JIQUhzVnloSWpqbnFjYWJrWFdrUzFvS0NMRkNlcEF6cHdsdndL?=
 =?utf-8?B?NUpBYkliQXRJcVQ4TmRSdUQ3V2pFWUpxMVYvVmYxd24xQUhLdGlJYWZ2TUV2?=
 =?utf-8?B?clRWem5IMUxSckp0bXFpSnNLekswR0dQYWNxWmhnbUl6SHgwOXptd01aMDNs?=
 =?utf-8?B?UVdSVjRhTHl2eDVqZ2ZnK2cvUmlEc283QTRtbjFJWTg2eWZRSjZOTGFOT2Q4?=
 =?utf-8?B?MzRwaWFjc2lqNC8zOWpkR2l3SEMwT0QvV1BBUGZ6QzV1dW8zQTdjenVZZTVs?=
 =?utf-8?B?VlJYSHEyeWt1SGVQZ3VlM3FEZjdHUE55U1JMR3hwWmpLMnFZTGVvNjZ2bkFO?=
 =?utf-8?B?N3plaUpheHcxM0M0dWdYL2lGWDFnQzZyQlloUGJPR1dMeXJFSXR2aHd6ZkRE?=
 =?utf-8?B?VEc3OW5NdnFaam01YjlIY3gyemtnV1pMNnV5cEhVUTNLc2lMbUJlYTY5ZE8r?=
 =?utf-8?B?R28xN3lyT1diRXJjSG1qcmZ1Q0hSdUJmdzJqRVVjRjRQcmZtc2FiSUdjNHRy?=
 =?utf-8?B?VXhMWEN3NmtOblRmQ1dCN2VNdVZ6V3BBT3NPZEc5M1dTbEVEeThtYTZ0YSsr?=
 =?utf-8?B?bXFzbXduMDRtSzlwT29CZnFmM1hvQUZJaGFJa2h3UjNHNlFNUXlCbk85Wmxh?=
 =?utf-8?B?YmJISnduaTBXa0o1QkVPWHZlbU9XbElXVFNtZnJIUTdyZ2VvOFNnRVVTMTRh?=
 =?utf-8?B?MC8zMUZvUkJ1R1pudDcvdVBvMzQ1SXViajdJU0I1N3EzMHJPU08zanZnc05x?=
 =?utf-8?B?dGVHL3U3c0ZCeVpOVzk5R2huaGhZVHFkUmFtZU9NdWR2dHdXUG43RXFGYzkz?=
 =?utf-8?B?aXJNNmxiUzJZbTFNZ2ZRU1dmLzN5M1ZSSHI1RTROUTNxK1FxQzBoRVp0WVlX?=
 =?utf-8?B?MVhHZWFiem9QWG9NUUVMU21GVXd1bE02dlRpeXY3YUM3NTFLQ3UwRERRUWpV?=
 =?utf-8?B?QnVicDhvN3BTMUd6L2FMa0ltTzZUZHg1ZG5Mbk1XdzNjdHRkeElkQjZDTXgz?=
 =?utf-8?B?OGRnalRYZTZQTlZUK2FjYkRHd0w2cWRXNlJ1YmFqblNVUjFCVTgvbVlIRFh6?=
 =?utf-8?B?OENaYUdMT0R0cnhlQXY0eXVwVmZmQmVzRUdiajQ2VGRuMUxZUEs3MCt4VE53?=
 =?utf-8?B?OTJKNWxqa2FsVkRXRTk4dG9MeVpFcklZcTNBQ1lwazluNHpUTGNVSlRXL2dF?=
 =?utf-8?B?RWFlMy9FMFgyU05XSGl4SmIyK0s0TE1IM0RQaDIrODRSRlc2MHdldnZDR0RT?=
 =?utf-8?B?cFJPYVdpdG11RW9zbks2UkZQZWRlQmFrZW11TTF0ZlFwUFFhYitaMTNPMW5K?=
 =?utf-8?B?OXk2VDhac2ZDOXRZK2VkMWlJMEdLZFM3NlZOR3hNdC9aMW5WUHZ3MnRKd0wz?=
 =?utf-8?B?b1pENkZGVlVmWFlud2h5cjlOeFMyY3daMVh1SXl5Ky96eFRwSTlHU1AzbTdt?=
 =?utf-8?B?WWZITFJETE40cVM4Z1YrTy9XZUtiRE5WK1dtVzFVZUZnS2ViTmdycFVlRCtj?=
 =?utf-8?Q?01OkVgUWXlf1qshjzo0B2xiUq?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40911884-0ccc-4f14-63fd-08dc806288ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 04:39:46.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYFNdoHbYpT4mqXVGWkrmAoDNQJgZftlxCibdwsog9OCLBzDyimr4xYIO3O1wu+cxIcxK1qjfEgcjvwxgwAVhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5794
X-Proofpoint-ORIG-GUID: IBchWhoAFdNBf-gKfRFpXcFqGESyCNZ5
X-Proofpoint-GUID: IBchWhoAFdNBf-gKfRFpXcFqGESyCNZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01

Cj4gT24gV2VkLCAyMDI0LTA1LTI5IGF0IDE3OjUwICswMDAwLCBTdW5pbCBLb3Z2dXJpIEdvdXRo
YW0gd3JvdGU6Cj4gwqAgCgo+IMKgT24gTW9uLCAyMDI0LTA1LTI3IGF0IDE3OjEzICswMTAwLCBE
YW5pZWwgR29sbGUgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTWF5IDI3LCAyMDI0IGF0IDAzOjU1OjU1
UE0gR01ULCBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0KPiA+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gPiA+ID4g
PiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxsaW51eEBmdy13ZWIuZGU+Cj4gPiA+ID4gPiA+ID4g
U2VudDogTW9uZGF5LCBNYXkgMjcsIDIwMjQgNzo1MiBQTQo+ID4gPiA+ID4gPiA+IFRvOiBGZWxp
eCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+OyBTZWFuIFdhbmcgPAo+ID4gPiA+ID4gPiA+IHNlYW4u
d2FuZ0BtZWRpYXRlay5jb20+Owo+ID4gPiA+ID4gPiA+IE1hcmsgTGVlIDxNYXJrLU1DLkxlZUBt
ZWRpYXRlay5jb20+OyBMb3JlbnpvIEJpYW5jb25pCj4gPiA+ID4gPiA+ID4gPGxvcmVuem9Aa2Vy
bmVsLm9yZz47IERhdmlkIFMuIE1pbGxlciA8Cj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiA+ID4g
PiA7IEVyaWMKPiA+ID4gPiA+ID4gPiBEdW1hemV0Cj4gPiA+ID4gPiA+ID4gPGVkdW1hemV0QGdv
b2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsKPiA+ID4gPiBQYW9s
bwo+ID4gPiA+ID4gPiA+IEFiZW5pCj4gPiA+ID4gPiA+ID4gPHBhYmVuaUByZWRoYXQuY29tPjsg
TWF0dGhpYXMgQnJ1Z2dlciA8Cj4gPiA+ID4gbWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47Cj4gPiA+
ID4gPiA+ID4gQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPAo+ID4gPiA+ID4gPiA+IGFuZ2Vs
b2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4KPiA+ID4gPiA+ID4gPiBDYzogRnJh
bmsgV3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+OyBKb2huCj4gPiA+ID4gQ3Jp
c3Bpbgo+ID4gPiA+ID4gPiA+IDxqb2huQHBocm96ZW4ub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgCj4gPiA+ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsKPiA+ID4g
PiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IAo+ID4gPiA+ID4g
PiA+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7Cj4gPiA+ID4gPiA+ID4gRGFu
aWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+Cj4gPiA+ID4gPiA+ID4gU3ViamVjdDog
W25ldCB2Ml0gbmV0OiBldGhlcm5ldDogbXRrX2V0aF9zb2M6IGhhbmRsZSBkbWEKPiA+ID4gPiBi
dWZmZXIKPiA+ID4gPiA+ID4gPiBzaXplIHNvYyBzcGVjaWZpYwo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gRnJvbTogRnJhbmsgV3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGUgbWFpbmxpbmUgTVRLIGV0aGVybmV0IGRy
aXZlciBzdWZmZXJzIGxvbmcgdGltZSBmcm9tCj4gPiA+ID4gcmFybHkgYnV0Cj4gPiA+ID4gPiA+
ID4gYW5ub3lpbmcgdHgKPiA+ID4gPiA+ID4gPiBxdWV1ZSB0aW1lb3V0cy4gV2UgdGhpbmsgdGhh
dCB0aGlzIGlzIGNhdXNlZCBieSBmaXhlZCBkbWEKPiA+ID4gPiBzaXplcwo+ID4gPiA+ID4gPiA+
IGhhcmRjb2RlZCBmb3IKPiA+ID4gPiA+ID4gPiBhbGwgU29Dcy4KPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IFVzZSB0aGUgZG1hLXNpemUgaW1wbGVtZW50YXRpb24gZnJvbSBTREsgaW4gYSBw
ZXIgU29DCj4gPiA+ID4gbWFubmVyLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRml4ZXM6
IDY1NmU3MDUyNDNmZCAoIm5ldC1uZXh0OiBtZWRpYXRlazogYWRkIHN1cHBvcnQgZm9yCj4gPiA+
ID4gTVQ3NjIzCj4gPiA+ID4gPiA+ID4gZXRoZXJuZXQiKQo+ID4gPiA+ID4gPiA+IFN1Z2dlc3Rl
ZC1ieTogRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+Cj4gPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRnJhbmsgV3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+
Cj4gPiA+IAo+ID4gPiA+ID4KPiA+ID4gPiA+IC4uLi4uLi4uLi4uLi4uCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsv
bXRrX2V0aF9zb2MuYwo+ID4gPiA+ID4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0
ZWsvbXRrX2V0aF9zb2MuYwo+ID4gPiA+ID4gPiA+IGluZGV4IGNhZTQ2MjkwYTdhZS4uZjFmZjFi
ZTczOTI2IDEwMDY0NAo+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
ZGlhdGVrL210a19ldGhfc29jLmMKPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWRpYXRlay9tdGtfZXRoX3NvYy5jCj4gPiA+IAo+ID4gPiA+ID4KPiA+ID4gPiA+IC4u
Li4uLi4uLi4uLi4KPiA+ID4gPiA+ID4gPiBAQCAtMTE0Miw0MCArMTE0Miw0NiBAQCBzdGF0aWMg
aW50IG10a19pbml0X2ZxX2RtYShzdHJ1Y3QKPiA+ID4gPiBtdGtfZXRoCj4gPiA+ID4gPiA+ID4g
KmV0aCkKPiA+ID4gPiA+ID4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBjbnQgKiBzb2MtCj4gPiA+ID4gPiA+ID4gPnR4LmRlc2Nfc2l6ZSwKPiA+ID4gPiA+ID4g
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZXRoLQo+ID4gPiA+
ID4gPiA+ID5waHlfc2NyYXRjaF9yaW5nLAo+ID4gPiA+ID4gPiA+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEdGUF9LRVJORUwpOwo+ID4gPiAKPiA+ID4gPiA+Cj4g
PiA+ID4gPiAuLi4uLi4uLi4uLi4uLgo+ID4gPiA+ID4gPiA+IC0gwqBmb3IgKGkgPSAwOyBpIDwg
Y250OyBpKyspIHsKPiA+ID4gPiA+ID4gPiAtIMKgIMKgIMKgZG1hX2FkZHJfdCBhZGRyID0gZG1h
X2FkZHIgKyBpICoKPiBNVEtfUURNQV9QQUdFX1NJWkU7Cj4gPiA+ID4gPiA+ID4gLSDCoCDCoCDC
oHN0cnVjdCBtdGtfdHhfZG1hX3YyICp0eGQ7Cj4gPiA+ID4gPiA+ID4gKyDCoCDCoCDCoGRtYV9h
ZGRyID0gZG1hX21hcF9zaW5nbGUoZXRoLT5kbWFfZGV2LAo+ID4gPiA+ID4gPiA+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBldGgtPnNjcmF0Y2hfaGVhZFtqXSwgbGVuICoKPiA+ID4gPiA+
ID4gPiBNVEtfUURNQV9QQUdFX1NJWkUsCj4gPiA+ID4gPiA+ID4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoERNQV9GUk9NX0RFVklDRSk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gQXMgcGVyIGNvbW1pdCBtc2csIHRoZSBmaXggaXMgZm9yIHRyYW5zbWl0IHF1
ZXVlIHRpbWVvdXRzLgo+ID4gPiA+ID4gQnV0IHRoZSBETUEgYnVmZmVyIGNoYW5nZXMgc2VlbXMg
Zm9yIHJlY2VpdmUgcGt0cy4KPiA+ID4gPiA+IENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB0aGUg
Y29ubmVjdGlvbiBoZXJlLgo+ID4gCj4gPiA+Cj4gPiA+ICpJIGd1ZXNzKiB0aGUgbWVtb3J5IHdp
bmRvdyB1c2VkIGZvciBib3RoLCBUWCBhbmQgUlggRE1BCj4gPiBkZXNjcmlwdG9ycwo+ID4gPiBu
ZWVkcyB0byBiZSB3aXNlbHkgc3BsaXQgdG8gbm90IHJpc2sgVFggcXVldWUgb3ZlcnJ1bnMsIGRl
cGVuZGluZwo+ID4gb24KPiA+ID4gdGhlCj4gPiA+IFNvQyBzcGVlZCBhbmQgd2l0aG91dCBodXJ0
aW5nIFJYIHBlcmZvcm1hbmNlLi4uCj4gPiA+Cj4gPiA+IE1heWJlIHNvbWVvbmUgaW5zaWRlIE1l
ZGlhVGVrIChJJ3ZlIGFkZGVkIHRvIENjIG5vdykgYW5kIG1vcmUKPiA+ID4gZmFtaWxpYXIKPiA+
ID4gd2l0aCB0aGUgZGVzaWduIGNhbiBlbGFib3JhdGUgaW4gbW9yZSBkZXRhaWwuCj4gwqAKPiA+
V2UndmUgZW5jb3VudGVyZWQgYSB0cmFuc21pdCBxdWV1ZSB0aW1lb3V0IGlzc3VlIG9uIHRoZSBN
VDc5ODg4IGFuZAo+ID5oYXZlIGlkZW50aWZpZWQgaXQgYXMgYmVpbmcgcmVsYXRlZCB0byB0aGUg
UlNTIGZlYXR1cmUuCj4gPldlIHN1c3BlY3QgdGhpcyBwcm9ibGVtIGFyaXNlcyBmcm9tIGEgbG93
IGxldmVsIG9mIGZyZWUgVFggRE1BRHMsCj4gdGhlCj4gPlRYIFJpbmcgYWxvbW9zdCBmdWxsLgo+
ID5TaW5jZSBSU1MgaXMgZW5hYmxlZCwgdGhlcmUgYXJlIDQgUnggUmluZ3MsIHdpdGggZWFjaCBj
b250YWluaW5nCj4gMjA0OAo+ID5ETUFEcywgdG90YWxpbmcgODE5MiBmb3IgUnguIEluIGNvbnRy
YXN0LCB0aGUgVHggUmluZyBoYXMgb25seSAyMDQ4Cj4gPkRNQURzLiBUeCBETUFEcyB3aWxsIGJl
IGNvbnN1bWVkIHJhcGlkbHkgZHVyaW5nIGEgMTBHIExBTiB0byAxMEcgV0FOCj4gPmZvcndhcmRp
bmcgdGVzdCwgc3Vic2VxdWVudGx5IGNhdXNpbmcgdGhlIHRyYW5zbWl0IHF1ZXVlIHRvIHN0b3Au
Cj4gPlRoZXJlZm9yZSwgd2UgcmVkdWNlZCB0aGUgbnVtYmVyIG9mIFJ4IERNQURzIGZvciBlYWNo
IHJpbmcgdG8KPiBiYWxhbmNlCj4gPmJvdGggVHggYW5kIFJ4IERNQURzLCB3aGljaCByZXNvbHZl
cyB0aGlzIGlzc3VlLgo+IAo+IE9rYXksIGJ1dCBpdOKAmXMgc3RpbGwgbm90IGNsZWFyIHdoeSBp
dOKAmXMgcmVzdWx0aW5nIGluIGEgdHJhbnNtaXQKPiB0aW1lb3V0Lgo+IFdoZW4gdHJhbnNtaXQg
cXVldWUgaXMgc3RvcHBlZCBhbmQgYWZ0ZXIgc29tZSBUeCBwa3RzIGluIHRoZSBwaXBlbGluZQo+
IGFyZSBmbHVzaGVkIG91dCwgaXNu4oCZdAo+IFR4IHF1ZXVlIHdha2V1cCBub3QgaGFwcGVuaW5n
ID8KPiDCoAo+IFllcywgdGhlIHRyYW5zbWl0IHRpbWVvdXQgaXMgY2F1c2VkIGJ5IHRoZSBUeCBx
dWV1ZSBub3Qgd2FraW5nIHVwLgo+IFRoZSBUeCBxdWV1ZSBzdG9wcyB3aGVuIHRoZSBmcmVlIGNv
dW50ZXIgaXMgbGVzcyB0aGFuIHJpbmctPnRocmVzLCBhbmQKPiBpdCB3aWxsIHdha2UgdXAgb25j
ZSB0aGUgZnJlZSBjb3VudGVyIGlzIGdyZWF0ZXIgdGhhbiByaW5nLT50aHJlcy4KPiBJZiB0aGUg
Q1BVIGlzIHRvbyBsYXRlIHRvIHdha2UgdXAgdGhlIFR4IHF1ZXVlcywgaXQgbWF5IGNhdXNlIGEg
dHJhbnNtaXQgdGltZW91dC4KPiBUaGVyZWZvcmUsIHdlIGJhbGFuY2VkIHRoZSBUWCBhbmQgUlgg
RE1BRHMgdG8gaW1wcm92ZSB0aGlzIGVycm9yIHNpdHVhdGlvbi4KPiDCoAoKT2theSwgcGxlYXNl
IHB1dCBhcyBtdWNoIG9mIHRoaXMgaW5mbyBhcyBwb3NzaWJsZSBpbiBjb21taXQgbXNnLgoKVGhh
bmtzLApTdW5pbC4KCg==

