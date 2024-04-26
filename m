Return-Path: <netdev+bounces-91708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8918B3826
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA994282735
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB14146D51;
	Fri, 26 Apr 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIJBR8jE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4276145B21
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137380; cv=fail; b=CZPUHjOUZx1giFpfZgkQk+4w/2ubbFAQowddKeaaC6+KY+SI3PNe86coonQEyr6RqHpB3MPmNb9EPElj8OuMYcV+FHGSdC4ZOOwtq+WLV1e+vneOHKuBxnt9FceeN+nUWGpJ7CJNZovpH227zIFk6FsT2kYvdVHKAzoDqMDeT7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137380; c=relaxed/simple;
	bh=JKkpSN50qwvMDzlQn0smjXSd9dch3IcQGshjAhioT+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghn2Cwpmwj6/HnyYd7Np0yCjrxn48hn4koS9mFteS6Jk2FJ3Rv238z8QyjqnWg03uPpRc4thXCmvgxlDZcALKOEv/B4lv/HQoKw+v9I8A0vNXwKvpjp7Gqd3CstFQ4DYasq1S3Z0SyNEZ10LmwyiNiSBFiNfliKwILHD2j6u/ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIJBR8jE; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCLJQ4/lavPkCa06Qfa8T+euCOOKvJ0QTJt4YIE+Dm9OGzyJz/XFRbkUB81G9YXRgvRCPEUE4w4R7L7pEOU8obZOBgVre59HufIUWoQZGAGADuiTdvBpqbemXCncdqAVDMfPSXHS1gLSDx9zVpRCRoqXde8dHOWitTdnzH+MRZ7Nbz9R0KW8aAJPtujeKRQS1+ls45rp//JyuFp2GKM9NsThSdDGyeOurF+YiVEXiiHJYwvD/dahUf9ekoMv2/fLpv2/okQMC3BanWlkJPYerHrs55QXh67s7Ju/iYj06sqXgA6+btjZmzP7JIUokPHF6W75NbD4m/oO/RPWKZ+i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKkpSN50qwvMDzlQn0smjXSd9dch3IcQGshjAhioT+A=;
 b=Ji6UvSv+3QWMmrk/uudgSochpoMDImKLC0gIzYmo6NG8R8QNKRN3UZMrxN2so6zwt1epq6SHEPGpOW6n3pOj2aY07fwM47eFQsoaLLGs59avmIYWO4w/Niow2GdAlzWntr8Tkk3WhY6oMbNnex0n2svTO8giFS6At7gLmvlXT6Snr2JoZXFmDXdjaY/PBzRCJcfNF7uz+pzkU/g6z5jzjyv+fcdzVGhhL5ZMNg311XW3Lr6ssDdjjihdTm2jdbDc9kyLkdkDtB85IRrucQfuyStvlLXlqE63u9cvryevWII7LT2I+jit1WtbAHeb7L4A6miCeUzPtXBMF/esERFrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKkpSN50qwvMDzlQn0smjXSd9dch3IcQGshjAhioT+A=;
 b=aIJBR8jEhsCYxobK61vFW/Ot9YxnZ2Ux1AzLTiLTmIrR1FAQ4EqDhTFrBPUTzGp8zYT2n4zGWg45/IMy5afBQx8ybuXqptl124M0lqjrpLQLeRBvnNbC0eBcugfjIZcpRNllv4pRlzkgm3Ry/W3bXQ6YSRxC/7weWQMLBvHLYwWTnOcWbf9eS1XXPHK5tcDKhtixEgIZURONqNgPjR+6JTICEiHy0eOwfDDcaSWlO0FMay6B0evf5CLPu6lWvSlPdTR4Zi5Coo0SBGPPzBFiW+XFmN0EGaRUV1E0iXr1cpgfKJRzXdXEyPXaG8vgy0hzkilM2p5xAgXDbvqcG9T/ww==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 13:16:13 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 13:16:12 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>
CC: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
Thread-Topic: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
Thread-Index: AQHalTJzRZrcxWFwSk6x4nm7jiFIWbF6VMuAgAA4TuA=
Date: Fri, 26 Apr 2024 13:16:12 +0000
Message-ID:
 <CH0PR12MB85809DEB2B232B4628A795A6C9162@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
 <20148f24e2e35e711dc47878e19fb6bd118dce29.camel@redhat.com>
In-Reply-To: <20148f24e2e35e711dc47878e19fb6bd118dce29.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|IA0PR12MB7775:EE_
x-ms-office365-filtering-correlation-id: 3338b172-04e7-4fa4-d4a5-08dc65f30ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWEyOWZGZTdWOWZFeU9tQVpmK3Bvd1MzUk1GVy9iN3RMVnMyNXJSNEhiWHA3?=
 =?utf-8?B?d3pIUU9PbUV2ZFdvQTd0YkpGai85bWhLVnFmd3RWYjF1WkY1SUNXWWRmNjh2?=
 =?utf-8?B?cElkZFBud3RrR2EwQ0UvNFRxRlBsMGtqSlVoaGFlYmlQeFM2ZWx6WWcvRSta?=
 =?utf-8?B?cnBJQ2F0WkR1NUUyajdyMVVxYnJHNng0dUgydTV0MmU4eGRLaXdOZU5WRy9l?=
 =?utf-8?B?cmNSOXVyemhVcFVsRlRlTDlndnJ2dTYwZE0zdHRjT28xWnBXTzRodTd2T1hw?=
 =?utf-8?B?YjNkSmhWNmdiZzBabW95Q3V6YlBRMGpTdHIxMU1IR2w0bHZZcDJSNEZhNXp4?=
 =?utf-8?B?T0ZyN0JxZHhSdDJSM1BISHNGcUFzY251cXZEcXExS0tJNm9oM2EyQVhubFZY?=
 =?utf-8?B?RkxrTkNFV3pIVGxEdHRaN2FQZjhwVlZjTWFNL2JrMm5YNTVpT1g1NXF5dVQv?=
 =?utf-8?B?cGNWSXM3QlZJTUpGNlJyYWFmbUc4ZjNqQ3loQWhGc0djNVRMREZuUEs5VWY1?=
 =?utf-8?B?WUhRbzdRUC9NaFV0YmZrUjYyNmxVWU5IMUNHcEYveVk0Q3dpSCtnYWppZ1h5?=
 =?utf-8?B?bFgrOW9acnQ1QXFHRW5yS2Nka09NTld2bmIxNFdyWG9UWWNtYWhyY2Z5QnlJ?=
 =?utf-8?B?RzN2T0tHWlNPNWI0RHFGSHVhZzFqNzhHWC9uTDNTSGJkNjFmcWR6Z0hQVG85?=
 =?utf-8?B?cFJNL01DTHZWYU81bkhWQW1VTTByYm53VHRXRnp2ek1lMDRrSUhxWHBkaE5U?=
 =?utf-8?B?TitYK2RiSmZMdmpGSUZFVnc2UHRScHdSNnJWNHg5d0ppd01NYzNqZmNTV3dq?=
 =?utf-8?B?Y3BvbWl0MEt3Rjg1Zlh1dUJOUEFJZ25uM0dNOTNZdVduSy9ZU3JDZ3dpeTZt?=
 =?utf-8?B?cjZCVWtjQ0pmL1pvREZHeE8yOWc3TldUdjAwQ1B3NzlmM2ZNZXNtQTdkaUNz?=
 =?utf-8?B?NWhYZ2dGcWM4VnpQbFZqUU40OVdtTTFwMFM3cGN5RXFQS2N0Qms2UnhJM3FX?=
 =?utf-8?B?bFZpd295cHBmTmN3ZXVhbEJQT2V0dUphVGxnYnNEVkRNRHNnQ3ErRXJlbmxQ?=
 =?utf-8?B?T0g4dWU2WjV0NTZ5ZGVVakNKb0c2MFVpOUlXMXY3S3d1RWMyWmJyWG8yR3VX?=
 =?utf-8?B?dDRDbGlPWUpKSWI1QWcyMm9EL2dLbEJQUDF5aG0yU1Zya2hqMWFNdTROV2lL?=
 =?utf-8?B?SUZmd0o3ODh3V1lURktuRTR5L3JRZ1BwZWRiUGIyUjJGaDRjNHo1TDRMUFZl?=
 =?utf-8?B?dVpjU3NBa2tCMnA4Qzk0eENuZlpkN3JWemxYand4aUtJRzBnL1lyR3BaWDdY?=
 =?utf-8?B?R0wxQS8vYU5pWVc0d25GVFdYZ0NJY0M5TDMyK2FIakFIUjhZSkFvaVRUWUw0?=
 =?utf-8?B?VnRHRWRXU2JRT1NyZVQrdEg1VHRnU2llN1ROVGFVZnNubklIZUpnOG5taUdk?=
 =?utf-8?B?NDFyVUVUUjFzZlZSQkYyVG9zTVI4cm9Oc2pkalh3VlFIOEVHZHkxSlVrT0U4?=
 =?utf-8?B?MmdjeVcvdHdaTXIyRXhwWEhHNXRHa3pxeVFPcCswTzRjOGVFWHBNaGxMcGM0?=
 =?utf-8?B?M0MvRU1MQXBpTUFobDBGN08rY2FvKzdtcm43U2l1aDlKWDlTWHlYbUZvSzl5?=
 =?utf-8?B?QlJ3K1ZIdWcxbU1QaGR1VFZoU0NycTBONGhiL0JCaUV2dlpSMDJJOXExT25E?=
 =?utf-8?B?V3Rna0VrRWNPRW9ZNWNZZ0tVb200U21Hd0VIZHQzQVhIandvRCt4S1dJRGVN?=
 =?utf-8?B?NVg0TngzNW9XNnhZb1hsT3doVkdkdTJyTVpFUmtQV09RaDhFenF4WUlEcVc3?=
 =?utf-8?B?MGxWRDhQVmZTRXBkMVcvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWhlMVo0Rnp2Qld0U0pPbzh3Z25yY3BsMnhiUmcrRmNKZjd3eTNoR2ZDUm5t?=
 =?utf-8?B?bnJ0eEk1UFQ0cHA0T0I5N2ozMXVJZ1RoZ3RycHlodk8vOWFFMFRhT0Ztc0o1?=
 =?utf-8?B?bmwydlUwMGJZOHVndlB3c1lBRGxzTGZJdU80Rk52M0JENENURnhsRU1HNVVr?=
 =?utf-8?B?MDlZbmROQ1lacXAyTU5hK1FQRHJDY3gyQ3FOblRObkpSendmZUp3WTJFTTZQ?=
 =?utf-8?B?VHNUSXA5dXBDQ2tWMTZaejVuV2ZtTVRMOVE2YjVqa0xVZHp0ZTdpUTZHRWZn?=
 =?utf-8?B?UFVvbVhoQ3ZIcDdqNDZWL2JIZ2o1ODBUdUNpbURoQVAzTlBiMitvUDVKNHdk?=
 =?utf-8?B?MUkzUDFWRnExNFoyTzJMdkMrNEFLQUU1Tm02Y0Q5TFo1Vnh0Rm8xWUdiK2wz?=
 =?utf-8?B?dmJFUk9VU2F5ZkY3RXh3UXYxbngxVUZsZno3SHcxZHlWUjRLYW0yV080bEFt?=
 =?utf-8?B?dG5ZcjlvSnREdFRjcFR6ME5VNzhVRnB4Ry9sMjR5TVM1UU5SRGpPczMxblVF?=
 =?utf-8?B?UGZrdDMySzJJK1VONGtJK3RnL2FEK2dmK1phZU9KUm5sdE4zNVR3ZDdWZWw3?=
 =?utf-8?B?UnpodUhhcTlJbElpbXVxM3NLdEZKSVk5VnE4K1NGRkhKOUlkZnhXYzVPNG1K?=
 =?utf-8?B?czZ3dTZqQUxyNm5rbVV2WVdRZ0l4K2dwV1B3aEtseXVEU2dKbktqOXBqTHUw?=
 =?utf-8?B?ZHNpLzhjbGM4cExhL01LK05VZVUwWDU0MTgzNVk2MitTcDlCaWRGS1VaYTJZ?=
 =?utf-8?B?cDlJbUIydmw5KzVXWTMwVHk0R3d1Q2w4ODdNZ242VUtLR2MwRVAydEROZ2NG?=
 =?utf-8?B?SEdnTkhFa0pnQkN5WFE5dmxKeW5WdXMvdkpueUFMdVp4VFE4clZvVE5kT2RR?=
 =?utf-8?B?OXRZTHdXVVdUK0g5ait6RnZWdzR4VVpuZ1RLZFVSOWZkSyttQk1EN2wyWE4z?=
 =?utf-8?B?aVFPVHVJZlpSdXY5YUFxWEY5THJWTURKVEtEMk9mZldBS0JXelZWWjdaeFFL?=
 =?utf-8?B?ZWdFU1hQTmw0bFBlNERyTXE0cFBMdjMvVnF5YmxrYUxiSk5UYmd4ZzJSRTZt?=
 =?utf-8?B?SGpMVjRzSUlHL3VVcnlQZ2tTWFZzdjd6azRmZDF5anlBaER5VFFCMHVWSWhq?=
 =?utf-8?B?eUpYcm5LV21Bbm1mMXA5cWxleUpoM2Q1ci9CV2hVZ3BzbXBleW1GUCtHYlhO?=
 =?utf-8?B?STcreCtaS08vQjQ1Sk1YYWdHandWM1hOMzVPZHJON3N2VGJmY2FrOUszN0FE?=
 =?utf-8?B?WkRmVmV3eWtoUW1WOXFJN3NYR3JiQ3FGajZ6SEdHWFpPM05kV0EzdUROS2E0?=
 =?utf-8?B?ZVlLK0dqVWpDNmJpdWRUbEN1Zk5FWlJkdThZUkIvczJ6NWl0bElLWmd5ckhz?=
 =?utf-8?B?cm52REZKOFdpY01VU29sVWtXL3V3anNUYmJCT0d5SWxuTmgxOWRyTmM1Qnlt?=
 =?utf-8?B?OTVRTHRINDJwR2pIVnlTK3c0QjlOWkFUWmNucVZld2ErcHZ2bWJmYzZmWGIv?=
 =?utf-8?B?NVVkaWNpaCs2eGZTaTFCekVIWCt3bHNkcExFdnEyT3FtV0oxLzRYcXl4c3Ux?=
 =?utf-8?B?V3VoY1BUQnpucy9pYVFlRVVuRUNVdjlPRFVNMkxoYlJVUVJ1T0VNY2c0NjJi?=
 =?utf-8?B?L2syOGYraGZUVkJkUjE2b2tnVFlDNFBzQnhGbHNoMnorQzZDd3lFSlVEMlh6?=
 =?utf-8?B?Q2g3ME5pMVRkTDZNNC93OC96clphRzhQS3ZqZG44VzhDSVI4aWxZb2l5WXlV?=
 =?utf-8?B?cmJJbXdFeDZieEFqUk5oamliSEFzTDhLUGNBaDF1cjdlRGZlVGxnTHB3U2Jy?=
 =?utf-8?B?OFAxUnJIemd2UzFXbDlxbENabGljZFd0ZHJKQmk3Z1kyQW5XMnpyYjc1V1RU?=
 =?utf-8?B?ZTRxa3VyRjV4TlVGZkQyczk0Q2N2Si9DOXYvQ2R0NkQxbVBQeEtqQ2JpYldJ?=
 =?utf-8?B?cE1jRzBpaVI0K1prTTlTYTVibm5HdFd6S0tRQnhBbDAwSXFoaTBpRnF6MkJh?=
 =?utf-8?B?dTRlVDBHZDVvcWtQVEpYZTZndTh2QXZpQmNCUWhZdGo1MlYwbEVSRTd3MGtw?=
 =?utf-8?B?MDhQVGV3LzA2cjFFQjJmdkZHUVVNbTRWSERuMCtNMUJnZ25QL3NZZnZ4alBV?=
 =?utf-8?Q?2rvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3338b172-04e7-4fa4-d4a5-08dc65f30ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:16:12.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAFRsBP3w0ywnrP0B+eZoJCE7f6Zva3oRBhUQYcdluoBYEnAFk4lDwMoL4HmEvTo3BO78pAiaLM0ExOUvAQVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

PiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwg
QXByaWwgMjYsIDIwMjQgNDo1NCBBTQ0KPiBUbzogRGFuIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlh
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGphc293YW5nQHJlZGhhdC5jb207IG1z
dEByZWRoYXQuY29tDQo+IENjOiB4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbTsgdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXguZGV2Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBn
b29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IEppcmkgUGlya28NCj4gPGppcmlAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NSAwLzZdIFJlbW92ZSBSVE5MIGxv
Y2sgcHJvdGVjdGlvbiBvZiBDVlENCj4gDQo+IE9uIFR1ZSwgMjAyNC0wNC0yMyBhdCAwNjo1NyAr
MDMwMCwgRGFuaWVsIEp1cmdlbnMgd3JvdGU6DQo+ID4gQ3VycmVudGx5IHRoZSBidWZmZXIgdXNl
ZCBmb3IgY29udHJvbCBWUSBjb21tYW5kcyBpcyBwcm90ZWN0ZWQgYnkgdGhlDQo+ID4gUlROTCBs
b2NrLiBQcmV2aW91c2x5IHRoaXMgd2Fzbid0IGEgbWFqb3IgY29uY2VybiBiZWNhdXNlIHRoZSBj
b250cm9sDQo+ID4gVlEgd2FzIG9ubHkgdXNlZCBkdXJpbmcgZGV2aWNlIHNldHVwIGFuZCB1c2Vy
IGludGVyYWN0aW9uLiBXaXRoIHRoZQ0KPiA+IHJlY2VudCBhZGRpdGlvbiBvZiBkeW5hbWljIGlu
dGVycnVwdCBtb2RlcmF0aW9uIHRoZSBjb250cm9sIFZRIG1heSBiZQ0KPiA+IHVzZWQgZnJlcXVl
bnRseSBkdXJpbmcgbm9ybWFsIG9wZXJhdGlvbi4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIHJlbW92
ZXMgdGhlIFJOVEwgbG9jayBkZXBlbmRlbmN5IGJ5IGludHJvZHVjaW5nIGEgbXV0ZXggdG8NCj4g
PiBwcm90ZWN0IHRoZSBjb250cm9sIGJ1ZmZlciBhbmQgd3JpdGluZyBTR3MgdG8gdGhlIGNvbnRy
b2wgVlEuDQo+ID4NCj4gPiB2NToNCj4gPiAJLSBDaGFuZ2VkIGN2cV9sb2NrIHRvIGEgbXV0ZXgu
DQo+ID4gCS0gQ2hhbmdlZCBkaW1fbG9jayB0byBtdXRleCwgYmVjYXVzZSBpdCdzIGhlbGQgdGFr
aW5nDQo+ID4gCSAgdGhlIGN2cV9sb2NrLg0KPiA+IAktIFVzZSBzcGluL211dGV4X2xvY2svdW5s
b2NrIHZzIGd1YXJkIG1hY3Jvcy4NCj4gPiB2NDoNCj4gPiAJLSBQcm90ZWN0IGRpbV9lbmFibGVk
IHdpdGggc2FtZSBsb2NrIGFzIHdlbGwgaW50cl9jb2FsLg0KPiA+IAktIFJlbmFtZSBpbnRyX2Nv
YWxfbG9jayB0byBkaW1fbG9jay4NCj4gPiAJLSBSZW1vdmUgc29tZSBzY29wZWRfZ3VhcmQgd2hl
cmUgdGhlIGVycm9yIHBhdGggZG9lc24ndA0KPiA+IAkgIGhhdmUgdG8gYmUgaW4gdGhlIGxvY2su
DQo+ID4gdjM6DQo+ID4gCS0gQ2hhbmdlZCB0eXBlIG9mIF9vZmZsb2FkcyB0byBfX3ZpcnRpbzE2
IHRvIGZpeCBzdGF0aWMNCj4gPiAJICBhbmFseXNpcyB3YXJuaW5nLg0KPiA+IAktIE1vdmVkIGEg
bWlzcGxhY2VkIGh1bmsgdG8gdGhlIGNvcnJlY3QgcGF0Y2guDQo+ID4gdjI6DQo+ID4gCS0gTmV3
IHBhdGNoIHRvIG9ubHkgcHJvY2VzcyB0aGUgcHJvdmlkZWQgcXVldWUgaW4NCj4gPiAJICB2aXJ0
bmV0X2RpbV93b3JrDQo+ID4gCS0gTmV3IHBhdGNoIHRvIGxvY2sgcGVyIHF1ZXVlIHJ4IGNvYWxl
c2Npbmcgc3RydWN0dXJlLg0KPiANCj4gSSBoYWQgb25seSBzb21lIG1pbm9yIGNvbW1lbnRzLCBw
b3NzaWJseSBvdmVyYWxsIHdvcnRoIGFub3RoZXIgaXRlcmF0aW9uLg0KPiANCj4gTW9yZSBpbXBv
cnRhbnRseSwgdGhpcyBkZXNlcnZlcyBhbiBleHBsaWNpdCBhY2sgZnJvbSB0aGUgdmlydGlvIGNy
ZXcuDQo+IEBKYXNvbiwgQE1pY2hhZWw6IGNvdWxkIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2s/DQoN
ClRoYW5rcyBmb3IgdGhlIHJldmlldywgUGFvbG8uIEknbGwgZ2l2ZSBKYXNvIGFuZCBNaWNoYWVs
IGEgY2hhbmNlIHRvIHJlc3BvbmQgYmVmb3JlIHNlbmRpbmcgYWdhaW4gdG8gYWRkcmVzcyB5b3Vy
IGNvbW1lbnRzLg0KDQo+IA0KPiBUaGFua3MhDQo+IA0KPiBQYW9sbw0KDQo=

