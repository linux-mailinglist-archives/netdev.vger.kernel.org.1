Return-Path: <netdev+bounces-248477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5DD08F8D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EE23002D0A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514AE330D27;
	Fri,  9 Jan 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyevZctK"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B2DAFA5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958744; cv=fail; b=uPZKOk4D1QoDNdcwgULAl9RVDo/ODUhZzjfqyupqdM6GxnvcOAWvTPRO8fif/MVI1agBIMinETn7uqHOwk/8qDox/I4FEtX9aItqlLzlKQXFWdo9y8HQzVqGHNLdHIvxhfd0f9rQkreueZXFNdF4uFmX+qBttTOX1MuIzaHlICo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958744; c=relaxed/simple;
	bh=e/OkPDHuViSF05LD+w4GRayzf+4ZaCfn8lQwO1yRSFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TBAw6+B7l6ZUiD0CDiFH0xvPZF6kyt29Gg2qgMqbQeurKckmqSY7NYnk2OVrDZpRVWXc9LnNp+7ftb97LzsMz3fsFZrVJVFswuiHQTNgF32CroUYZ1n9CnuQ4uL/tpAJFbd2KdC2oW1AhVspY3f6el7GXsSNOJVvfNsy9h2JTGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MyevZctK; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW3dyraz9xgamFi3E7bjDDfWGAch4PoknZwOXGcn/sjuzDOi0VskxbGr8zjKiSUeyq4K7BR1InsME2/yi2z5pwp3wIaXOI5Z7s2feXbXThuKbOkIt2U+vgDQ33HdCcDN4dWRhuxZ52UDctlE2SstGx4D/HrvWJVBLC88gxuLNNONRx2PhRcFo84H4DHUr44W4yPBSmYjl2sdkbOppQLsTeOBAZuaaoenfMke2Bjw/sUkfd2kwNyY6Blbv5tV0REAf7SmWR/JrEMz3+3bWjSuSYH2OYunIXgDygz4Yw2Xr8pGXVjMRjtnUNsbxKuZuF3CrU+VuZCRN0C6yxT60OJZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/OkPDHuViSF05LD+w4GRayzf+4ZaCfn8lQwO1yRSFM=;
 b=AZmMIqbVy5EVh7c1V9CMxhMzPwY4SOwSNKhHXDTDBTzwyOmhoVnpG39iK/nP8E7HNhBTF42TJrk7fsqDxO7GivOid90s/cZyt7f0pal/RKhEOTxndsx1Dv8C0a5d8/htvywHI5iWpyew9eoe5zK+Vfm3bRcrrEDVXtblRmdq7eobKdyiXHucBiOqsijgrqGqbIuXsXR0DBgjeQJqbMLUngmupUpH1PAetvUkw6zX6+pDhD/an8mDCYs1zVGusRgWU36QotN9tl0JRSdtewrGBF+p81+15KrnObsnhxbDlooI7McDKBmf8wb+zy/Y/CXnKuL7E+cKop8t9gejDWKenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/OkPDHuViSF05LD+w4GRayzf+4ZaCfn8lQwO1yRSFM=;
 b=MyevZctKCfWI4UvrQI2Nx886inLPdxTEt6Ft1lYOqHlKi9aFnYmjwW4wAth79V8IY7dGXI7wTQK1Qdq7sCpumtrxiP4BuciP9hcVdoNH+b9neb8g812BlXn1Ah3Rlrh5OpzsK2t5obHdCvo5gfj6lbfOpwuX9s6T+90yraEXSASlKqhfPsCqcTbvJBj9pEiclpJsye7VSNa0bHrWUkY7vqZwf+4ToE2d0juAsHkCj7jN5hZXObQnsgzdoR9rSOWvLjP7mUUpaGM/7MV7v7uzXY6RHw27h/4I173CKkHP+WHvht3L8u+rf2c9pCp0GhI2aUqEljoieA3kC3wn0Lld+g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CY8PR12MB9036.namprd12.prod.outlook.com
 (2603:10b6:930:78::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 11:39:00 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 11:38:59 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: Dragos Tatulea <dtatulea@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Index: AQHcf8MYq0aPKotsqky8aDx5Wvpp8LVJpWmAgAAUJAA=
Date: Fri, 9 Jan 2026 11:38:59 +0000
Message-ID: <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
	 <aWDX64mYvwI3EVo4@krikkit>
In-Reply-To: <aWDX64mYvwI3EVo4@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CY8PR12MB9036:EE_
x-ms-office365-filtering-correlation-id: c933ba6b-6d91-4a6d-b316-08de4f73ae58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDNaMjJLWkpPRGdDS01oYzNkOW1JWEMxeWxHMTJBVWJ4aWxMQmRCSjg1RGd1?=
 =?utf-8?B?Nm5MYmNhd1ZkTjlXZzE1U1FUR01ranRPR0lPemg1eElDVkwxSFNOTzVOTGho?=
 =?utf-8?B?bS9JTXlkNy9wY2ZoT1ZrUFFmeExicmg4YTlzUFZET3kydWlXYzFVeU1lZzNE?=
 =?utf-8?B?cVduMjNoeGRTNGoxYTA4RW1saktYL1ZnL0R6Y0JkdW1SMWQ4cDNVQnhpVDBO?=
 =?utf-8?B?Um02ZldNNG5LdUVWTzBHK1lVUUY2RHQ3OW0rb0pKY2tINm1NWjNEOUlWemxi?=
 =?utf-8?B?RTlSOThpLytxMDhRMG1ld1V1WmNrd3dKMG83UXN0cWhzdlJpVUZnWUxpM0hx?=
 =?utf-8?B?K0ZQRGhYMDgxSmg3NW1HVUlNbmo4VStWM3J5dFArN1IwVG80T2xnTXV0R0g4?=
 =?utf-8?B?Y01aVFJNdkgvdk8rVjErNmdpakNaVDRpUXV5d2tSL0xWU1ZDcnF6UHgxUkx2?=
 =?utf-8?B?T3Q5Y2Nyd0NDZEVPdVdvdnA3V1ZBSDRKSDFTQndvczE4N1dOMDl2WStnWjFu?=
 =?utf-8?B?L1hvZHk3NEFUMnNkTmhqZlBmekE2MmtoYXJSVlFCSmtqeCtXRUNpaGg2SDVW?=
 =?utf-8?B?K0t2NEtwZXFkcG9zSDRWUjVRRFU0OHp2K0J4ZW1xcEF1Q0tRUENKLzJpZnpC?=
 =?utf-8?B?K1RzK21hUnZYcXZJQjREOHc2Y29KTVRMVEdRL0xjOE9JZlVDcVdQL241OHBi?=
 =?utf-8?B?TnZDR0pYNndNdG1GMlp3UzFVTUNudGEwWFBWVWxuUHhkSFVxa01XV2c4dE56?=
 =?utf-8?B?YklpbFdObUF4Rkl5bGtxVnUwbGVTa2RWRlpidFZITFVaSitjNXJ6aFBzWk51?=
 =?utf-8?B?YlVpbjVsNDRjZ01sSUpHdlJxNDVoYUw2d1o3aWV4ek1rcU5Ea254TTRuVERo?=
 =?utf-8?B?dnFNWnhUZm5jU0hWRllQZUJsNTNBck5jNVZPMi9MMzBnbUx6T2RrejJ0WkNw?=
 =?utf-8?B?Vm5TaXVjeWJkdDVLNlN0Q0tJM2x1VWs2QTE2MTJqTkhnV3dWY1R6N24yN25t?=
 =?utf-8?B?SWt6VlBHK3h0YTEzTzJ1SGNBTU9BZU9zK1hYTDR0NUVZWUxhZjY3M203aUIv?=
 =?utf-8?B?b0tiMmh4am9DdmEvdEM1VXFMdXVmYjlHMlM0WU0xYnFQZDRCYW93V3pHd3RK?=
 =?utf-8?B?bldVN3hrUi9vK1BrOVU0cjJUamgvKzlDdTRoRXRtTFA0VStxbG56ZHZQcC9W?=
 =?utf-8?B?M3dJRGZuUUNyNVhRNHVicHcvTWxUQTN4TFprQzYyS2lTUk5iS1BNY1k4ckZm?=
 =?utf-8?B?ZnRvNmFDOHZoU2VndTZBUXlRQ0NzdUYzdFVyZmRJVXZLMjJjSTVIV2h6SzJy?=
 =?utf-8?B?SkNhNmRwdytXOGFkdjVJRjNFMXNFaWNoYmFqRmlwWjNEMkhnTUU2RDI3ZUlt?=
 =?utf-8?B?aTcwRE5VdjJlOUZrTDhOY0drN1JNSVJVbHNwNUtGQzh5eEVCSktGdXhzUklv?=
 =?utf-8?B?U0dBSmNUQXJiWWdvREVFRzB1QkhjWW1hWGYrakJseE5NcnIwMUhZZDhGS1B1?=
 =?utf-8?B?blR6bGl5WUF2N1BFOU9yZXN5REx0eDRETUp6TmV1YlRESjVrYmhVeTR1Y0xI?=
 =?utf-8?B?eWtMcmlEbVFlWnZ6WnZSV3BQU2p2eGZpSUl6bUJrREZsUVI4aFhtSUV2ZzNq?=
 =?utf-8?B?WmNXMTlEQ25ScmQ0M2MwZWRJQTdvcmJOcWRwRkUyWWxCc01pQkNmSjVpZHBy?=
 =?utf-8?B?Ylg1SUtIanM2RkN0cUkvVjdUYlprRUNkeGcwNExjZE9xdXN3V0VqN2JzVFpn?=
 =?utf-8?B?TzlXM2Flby9iOXpKeTlqa1psREwwWnh4NVBWWXB5aUJaT0pKSDM0VjJJejlX?=
 =?utf-8?B?QThycXZRMHMrRndjMVFSQjBac2c5eWptbk9vbklZYU9KSnRlWjlLQVc4Lzh4?=
 =?utf-8?B?bEh4dEhXbWJISkt4M21VWUp1YXd1VThqT0pzTHVYU2xCWVUwVkVWNUVMSHQ3?=
 =?utf-8?B?YXBDbktsT3dpVEpoRkpoek9tOUtBVTlhUXc1cDJnOEs5WGNaeFF1Sk5nVGt5?=
 =?utf-8?B?cHZDT2Q0WVpnbFQvNWI1QXgrVEdQcGc3MmZja3VmQ2xQK1pUSnRhRHV2dFZ4?=
 =?utf-8?Q?ymY/WO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlBnWlhuQzRleEd2S1lTQnJmMGw4d2Y2U1RKNmk5d0NtTTB3Sk1hTGJvRXVz?=
 =?utf-8?B?V0k0bVRZbGM4ckFFV0I0YTVaQ3ZUQzNXYlFKQW04V0pyWXhESXc0TXdHclh0?=
 =?utf-8?B?R0VBZjN2MmhxdC9MVTQxM08wdklwdzdRblJEUVB1bGpYenlMRzdXallLbHBG?=
 =?utf-8?B?bExCMjVTZmwzWXgzRUxSN1pHdkIwU1lnMzRJNms1aTlMY0laZkt6Sy9zQ3BL?=
 =?utf-8?B?aE13eGs1Tm96c0R1elNQenJaWDR2U1gxYVBnVmlOVktOWnFoQUhtdUhCZGx0?=
 =?utf-8?B?dmRKS3drc3lrbDRYTTkxTVdOODdZUnVjNlh5STZMRjR0c2xYVGN6alA1dUVt?=
 =?utf-8?B?SlhNdjVvMUZxWEgxSHh0K3luU21nM3lVbUNIbUxjL3JXYTJlSGdESmVhMFZG?=
 =?utf-8?B?Tk5LS2gzekhlSjVqVE1wMFFFS1crTVFXRldtcC83bjhkcU9oQ0F0WlBSZm5G?=
 =?utf-8?B?WnBWN2FsSTljRGdmREVGZlE2cFlKN2pWTmdGY2lIVFhXRkt6VU9WanMydnNI?=
 =?utf-8?B?c1BreHdJdTR1UTQ2cFFsbUxHUS94alNlK3NQKzIzRFp3d3NIcndlTlVKL0wz?=
 =?utf-8?B?VHBRSDIybjl0cFFISDZkU2xqQmtQMUxzSklkVGlYeGxCK0hGMndMTCtkOWN2?=
 =?utf-8?B?Q3RlMUh6NEprL0ZTRTVGRnVHRDEvUTVucStKYmkrbTJ4d25STEFvdzVZNkdS?=
 =?utf-8?B?VVJtdXZHRUxoMkJDdzBadkhPSWRVb3d2eUQwRHgzdHg2aUs2dEJHMG0ya0JV?=
 =?utf-8?B?ZjNXVk81NE9nZEtLUXJ0MFRibEUzOWhJRGY4aWQ2MzdzUnJaNUE1L2lCK2p3?=
 =?utf-8?B?UVZ2bmhOK21Xd3N4NWptZENFbGp3cXdHUUVuQ0JmUmo3Vkt0ZnpRMXM1NGRp?=
 =?utf-8?B?Qk9GUHVJdjN2MkRLWkJYT0FKekZFNW5yKy9EY21tNGFtWE4vNHhBeHVFOWhE?=
 =?utf-8?B?TDR1c2VuYUMwbjk4bGU4aWlBMG4vZThIUXRJUytVaWNocVBvWXZ1RUZWWXQ0?=
 =?utf-8?B?K0Y4cHpibmYxMzEwdWlJOUNIb05OMjhrRXdLUUxzM3hzS1I2R3JOZ1h6aEV2?=
 =?utf-8?B?cGxObWhhUVdUNGR1N1E3YTlpeFVScWpPTkxrTWN2a0pwbnNERFpZZmF2Lzhz?=
 =?utf-8?B?bUlBUzd1LytReG1aYytQQzkzNnZBc0hSakVTQ3lpMC9WRVllb1Fnc3ZzK3Fr?=
 =?utf-8?B?amk0bndnelR0Q2s5UFB3UUU1bWdscDJzVGFkYWQyQWZKYlFUWEkxZWZ3emts?=
 =?utf-8?B?SmR4T0pPYzVBZzdEWjNCQ1JROXJnWTJsZ3JVTnpCWW5zUEZXcXBKWVplNTE0?=
 =?utf-8?B?dXF1N0piRkVQckZBWDNvdXB3SUNDSUQ2Y3kxOE1hMERlWnNTMTRnRUVVWEJP?=
 =?utf-8?B?UEhxVnJNdW00dVArcEZ0R3dqbGtJZXdHYzFlME5iRkN2L2JtQUREL1ZPc28w?=
 =?utf-8?B?cm1kN2NQSHlXemFabkFRZVYwV21zRndqUlNjN0lDVGhocVdWNGIzQ051dUdL?=
 =?utf-8?B?ejVxdWJCK1c4Y28vczdrNEVMckx2UU4vUFFkZEFiZmY0R3lnM2RjTDNIYjc3?=
 =?utf-8?B?UjZFRE9tNDljay9xN1g2ODg4ZjNaQ1Vwb1c4OTByRmR6TTNScW5ScmRJZmZT?=
 =?utf-8?B?SHVrb1dlbnZVTzJMU1V2V0lTdmhockhnbjFVZWdTR1R1SlZDekI1b0daeEZ1?=
 =?utf-8?B?eGpEZTBHMnJ0R3E4cmkrc2ZDTWFCbkthMHB6TmNML3B5ZDhIWGpqTGJiMm9q?=
 =?utf-8?B?UzVVbi8yb3QvTjBEOWphWXlQSjlmVHgzWlZueG5jZmNRT2xKbFNnTkpXeUFz?=
 =?utf-8?B?N1QveWxEVElyOW12bEtzZk1RR3JtZFcrVm9xK21TSlR3RGhwZ3liSVMyb2pS?=
 =?utf-8?B?T0loelZoSU45QmVZT3paS0VUMWRGS1JUelNaZC9lL3ZQNWVzTnJnYW4zMUlT?=
 =?utf-8?B?STZ6Y3BHYVF5RGhNQSs4Tnpaaks3MWZ6TVlMRW96UTV6M3JMdVdhanZ4bEEy?=
 =?utf-8?B?amQ1Qi9Eb1R3LzNveU1FWU9BMGJBRHVnd2tCT0VCM3EvUjBuQ3Zlem1mSTJ0?=
 =?utf-8?B?TzRBNmFQSVZUcWt0NVZjdC9XK3oveFNNczVRWE5IdE9xcTdTV2g1TDUrN21N?=
 =?utf-8?B?dk94eXp5YXhmVVdtNW9nblN0UFNzTXVqLzdieWpLNnpGbmlyZzY5V2tZd1Jo?=
 =?utf-8?B?WDl3UkRTbkxkNnBsV0xKQzd3dHhlbHRNenl3SWVHOEMzbXRLQW1sMkUwcW5W?=
 =?utf-8?B?TnVuOE1jTVhONUJnZmkvRjNvWGdSVlhYMHMwZGljTTEvZ1hXYjZpM2lmU1Fp?=
 =?utf-8?B?aHV6YVFZakQxYWFYdXZXbkF0ejAyVzI2OHBxQUJqMllqdkY2Um9nUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E6F23C3A17132489E2171DE492E94FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c933ba6b-6d91-4a6d-b316-08de4f73ae58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 11:38:59.7656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+MCHISsQD+ATNeycxt6MW3BTMo82NT1FyQ9AwFwvf/20cCWaj4dkECEIryW8WNR15uQTD1TkHSEZ8n/fRSLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

T24gRnJpLCAyMDI2LTAxLTA5IGF0IDExOjI2ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDEtMDcsIDEyOjQ3OjIzICswMjAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
VkxBTi1maWx0ZXJpbmcgaXMgZG9uZSB0aHJvdWdoIHR3byBuZXRkZXYgZmVhdHVyZXMNCj4gPiAo
TkVUSUZfRl9IV19WTEFOX0NUQUdfRklMVEVSIGFuZCBORVRJRl9GX0hXX1ZMQU5fU1RBR19GSUxU
RVIpIGFuZA0KPiA+IHR3bw0KPiA+IG5ldGRldiBvcHMgKG5kb192bGFuX3J4X2FkZF92aWQgYW5k
IG5kb192bGFuX3J4X2tpbGxfdmlkKS4NCj4gPiANCj4gPiBJbXBsZW1lbnQgdGhlc2UgYW5kIGFk
dmVydGlzZSB0aGUgZmVhdHVyZXMgaWYgdGhlIGxvd2VyIGRldmljZQ0KPiA+IHN1cHBvcnRzDQo+
ID4gdGhlbS4gVGhpcyBhbGxvd3MgcHJvcGVyIFZMQU4gZmlsdGVyaW5nIHRvIHdvcmsgb24gdG9w
IG9mIG1hY3NlYw0KPiA+IGRldmljZXMsIHdoZW4gdGhlIGxvd2VyIGRldmljZSBpcyBjYXBhYmxl
IG9mIFZMQU4gZmlsdGVyaW5nLg0KPiA+IEFzIGEgY29uY3JldGUgZXhhbXBsZSwgaGF2aW5nIHRo
aXMgY2hhaW4gb2YgaW50ZXJmYWNlcyBub3cgd29ya3M6DQo+ID4gdmxhbl9maWx0ZXJpbmdfY2Fw
YWJsZV9kZXYoMSkgLT4gbWFjc2VjX2RldigyKSAtPg0KPiA+IG1hY3NlY192bGFuX2RldigzKQ0K
PiA+IA0KPiA+IEJlZm9yZSB0aGUgIkZpeGVzIiBjb21taXQgdGhpcyB1c2VkIHRvIGFjY2lkZW50
YWxseSB3b3JrIGJlY2F1c2UNCj4gPiB0aGUNCj4gPiBtYWNzZWMgZGV2aWNlIChhbmQgdGh1cyB0
aGUgbG93ZXIgZGV2aWNlKSB3YXMgcHV0IGluIHByb21pc2N1b3VzDQo+ID4gbW9kZQ0KPiA+IGFu
ZCB0aGUgVkxBTiBmaWx0ZXIgd2FzIG5vdCB1c2VkLiBCdXQgYWZ0ZXIgdGhhdCBjb21taXQgY29y
cmVjdGx5DQo+ID4gbWFkZQ0KPiA+IHRoZSBtYWNzZWMgZHJpdmVyIGV4cG9zZSB0aGUgSUZGX1VO
SUNBU1RfRkxUIGZsYWcsIHByb21pc2N1b3VzIG1vZGUNCj4gPiB3YXMNCj4gPiBubyBsb25nZXIg
dXNlZCBhbmQgVkxBTiBmaWx0ZXJzIG9uIGRldiAxIGtpY2tlZCBpbi4gV2l0aG91dCBzdXBwb3J0
DQo+ID4gaW4NCj4gPiBkZXYgMiBmb3IgcHJvcGFnYXRpbmcgVkxBTiBmaWx0ZXJzIGRvd24sIHRo
ZSByZWdpc3Rlcl92bGFuX2RldiAtPg0KPiA+IHZsYW5fdmlkX2FkZCAtPiBfX3ZsYW5fdmlkX2Fk
ZCAtPiB2bGFuX2FkZF9yeF9maWx0ZXJfaW5mbyBjYWxsIGZyb20NCj4gPiBkZXYNCj4gPiAzIGlz
IHNpbGVudGx5IGVhdGVuIChiZWNhdXNlIHZsYW5faHdfZmlsdGVyX2NhcGFibGUgcmV0dXJucyBm
YWxzZQ0KPiA+IGFuZA0KPiA+IHZsYW5fYWRkX3J4X2ZpbHRlcl9pbmZvIHNpbGVudGx5IHN1Y2Nl
ZWRzKS4NCj4gDQo+IFdlIG9ubHkgd2FudCB0byBwcm9wYWdhdGUgVkxBTiBmaWx0ZXJzIHdoZW4g
bWFjc2VjIG9mZmxvYWQgaXMgdXNlZCwNCj4gbm8/IElmIG9mZmxvYWQgaXNuJ3QgdXNlZCwgdGhl
IGxvd2VyIGRldmljZSBzaG91bGQgYmUgdW5hd2FyZSBvZg0KPiB3aGF0ZXZlciBpcyBoYXBwZW5p
bmcgb24gdG9wIG9mIG1hY3NlYywgc28gSSBkb24ndCB0aGluayBub24tDQo+IG9mZmxvYWRlZA0K
PiBzZXR1cHMgYXJlIGFmZmVjdGVkIGJ5IHRoaXM/DQoNClZMQU4gZmlsdGVycyBhcmUgbm90IHJl
bGF0ZWQgdG8gbWFjc2VjIG9mZmxvYWQsIHJpZ2h0PyBJdCdzIGFib3V0DQppbmZvcm1pbmcgdGhl
IGxvd2VyIG5ldGRldmljZSB3aGljaCBWTEFOcyBzaG91bGQgYmUgYWxsb3dlZC4gV2l0aG91dA0K
dGhpcyBwYXRjaCwgdGhlIFZMQU4tdGFnZ2VkIHBhY2tldHMgaW50ZW5kZWQgZm9yIHRoZSBtYWNz
ZWMgdmxhbiBkZXZpY2UNCmFyZSBkaXNjYXJkZWQgYnkgdGhlIGxvd2VyIGRldmljZSBWTEFOIGZp
bHRlci4NCg0KPiBFdmVuIHdoZW4gb2ZmbG9hZCBpcyB1c2VkLCB0aGUgbG93ZXIgZGV2aWNlIHNo
b3VsZCBwcm9iYWJseSBoYW5kbGUNCj4gIkVUSCArIFZMQU4gNSIgZGlmZmVyZW50bHkgZnJvbSAi
RVRIICsgTUFDU0VDICsgVkxBTiA1IiwgYnV0IHRoYXQgbWF5DQo+IG5vdCBiZSBwb3NzaWJsZSB3
aXRoIGp1c3QgdGhlIGV4aXN0aW5nIGRldmljZSBvcHMuDQoNCkkgZG9uJ3Qgc2VlIGhvdyBtYWNz
ZWMgcGxheXMgYSByb2xlIGludG8gaG93IHRoZSBsb3dlciBkZXZpY2UgaGFuZGxlcw0KVkxBTnMu
IEZyb20gdGhlIHByb3RvY29sIGRpYWdyYW1zLCBJIHNlZSB0aGF0IGl0J3MgRVRIICsgVkxBTiA1
ICsNCk1BQ1NFQywgdGhlIFZMQU4gaXNuJ3QgZW5jcnlwdGVkIGlmIHByZXNlbnQuDQoNCkNvc21p
bi4NCg==

