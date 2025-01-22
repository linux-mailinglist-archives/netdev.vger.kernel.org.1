Return-Path: <netdev+bounces-160343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D9A19507
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A4168A3E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359F214237;
	Wed, 22 Jan 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="mdDQEtCo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B8214227;
	Wed, 22 Jan 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559380; cv=fail; b=KhFRKU4F+bL3dKURwlQudr+ERhztIojy9WR6k809Qi/fDcwA5VNL0pqOLv1kIBm4f//UBGbyFWAX/ED2mdjU53kkK4zt45/YwEA3iSkG2bG8dDHgW7jmA8Q+Q26oLdc+NtpHGTJeyAZij0pPWCKUQD9lzAPLc6aLaTtBl6o4G2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559380; c=relaxed/simple;
	bh=SIBxEAagX5ttMG+yVE379v6dDcnMtkBOC/gpPPs+6sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eGYjPJw9jK+mmOtJ7WuIt2ZlEZ5wHnKkK70O8Nc7IMT9aVItjodGhLDFHiDQPv6QEHxqYJlEjBo/wQmWBDb3/oi1hqRNbSiuNe5VxrF4YaYk7yB817cPqtScysArp9gB75mQ6nYNgwBxbPnrM2nqjOCPfWpvonDUTI3j0Zh2ZyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=mdDQEtCo; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+TzItSoCpo9AV1GY82ThqAajF07bG85aY8tqoFmCscLct7+zxvbIRc7vAw3Ru3lJLntbZHK6tqPns9nmRDYKckSfKd2W0KDcvU7lzquPb+9sgDNhXBTi378IVK8Ii2acImHkTEuO0DTRsN+37/OF+HfPCHL5GeYOXhacd5BA4QAAl0rRZ4U7BA23JAAcLj9wSTe6PnL8ebbFyuLTnXyKSDbhETxEmaenFLsVmlFRvSk2nBhDS6i+Rt/VB4WmNtVpU+ohk05v9edD6V3WDKHhyDi59stY+N7vDs3uFn8phWk5B1p/15PDrJM4KcNpljO2mXCrK0qiIwnAxvE6ItXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIBxEAagX5ttMG+yVE379v6dDcnMtkBOC/gpPPs+6sE=;
 b=KcIGOXh6sqKcttlP8K/L+gnqKkWcSM4pVedA7fAqyLU8WZbNGiOnsFS0twyd+fnLjc+pVm/qI28up6UdT3CtKjYatDM6rEt8AsEjWAQJyJ6FiIh+JQ38JaBJBVNmpIxN7z2hmFogbMnKdIUtLkwEWPf+0ehMKhEuckKZwszaFW9uGYZYUB8UoNUUacxuUuEiJYnqeP8saxZ3CZq1RUNR0ZEJtUdntgVALS9ae7TY21ygg2/1R15AcA+CmkD9TdatcHtIiyoBIEKWEXa2r6Ttycg8uZY9pT+O5hXe53jH7lSPNvMOx1M/YlgtT9fDMT+0jYWdHAaXM49+rsOD0dOHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIBxEAagX5ttMG+yVE379v6dDcnMtkBOC/gpPPs+6sE=;
 b=mdDQEtCoutoRouxLx43WHZbRL90ylvXRysknIVan+nk9sU/uj6eY1nIZojQV7u5woP4O7heOrH8kwGeQsXK9bMbnQAAjkRekM3Nuqxg0Q9GN/9kXsfwvUCiYc3YL5fEaVBcpcWb92An52uYth0uUEOoVZAai4bn8wjJFvlg0jmhp/vD+3CZb2Uc+tu3lAJcf/NS3yiCxM0s6Q38jglN74kZ5ZHxuu5XoqUlh4h65901f18cMUfdxrJvmhyRXMic+I/oMAKvInhQd37rC0DlWAUH3X7/ebUMZKxK15zvG/gWjrwymi+rUZjRqzsPFEN1FpjBEw2QIUnb+4iWUvvowxQ==
Received: from DM4PR17MB5969.namprd17.prod.outlook.com (2603:10b6:8:50::17) by
 PH0PR17MB4878.namprd17.prod.outlook.com (2603:10b6:510:8c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Wed, 22 Jan 2025 15:22:54 +0000
Received: from DM4PR17MB5969.namprd17.prod.outlook.com
 ([fe80::f770:8bd1:1aab:b84f]) by DM4PR17MB5969.namprd17.prod.outlook.com
 ([fe80::f770:8bd1:1aab:b84f%4]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 15:22:53 +0000
From: "Badel, Laurent" <LaurentBadel@eaton.com>
To: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, Jakub Kicinski
	<kuba@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] [PATCH] net: fec: Refactor MAC reset to function
Thread-Topic: [EXTERNAL] [PATCH] net: fec: Refactor MAC reset to function
Thread-Index: AQHba/DafTAj29fCA0SAXRpQB0Dq3bMhZPsAgABM3QCAATjFwA==
Date: Wed, 22 Jan 2025 15:22:53 +0000
Message-ID:
 <DM4PR17MB59691A9B9E59DD9D1F6493BBDFE12@DM4PR17MB5969.namprd17.prod.outlook.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
 <DM4PR17MB5969CC2A8D074890B695AF2ADFE62@DM4PR17MB5969.namprd17.prod.outlook.com>
 <8395976e-c867-4788-82e6-6d606599bf6c@prolan.hu>
In-Reply-To: <8395976e-c867-4788-82e6-6d606599bf6c@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=c9ceded5-a46b-4de0-aeea-c56ca2398a11;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2025-01-22T15:21:02Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR17MB5969:EE_|PH0PR17MB4878:EE_
x-ms-office365-filtering-correlation-id: 97a931c4-4b89-4ed5-7699-08dd3af8a438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkppbGk4cjY4U2JneGF3SFU5SXNWZk5yWnRrUUoxVTgxK3RYRkJxTzFINDBk?=
 =?utf-8?B?YTRhSStYSGN0SUx6dGZEMy9EbTRRR1o5OFpjOHRzSXU3UHRtRkVacW83M0sw?=
 =?utf-8?B?S0pRemhCT0JPQjNOcXBMYXVDdi82KzY5V2xTYkdzdE1hSEpYOEtablNFR1I5?=
 =?utf-8?B?S0QyMEY3L2hUc2tDZHY0QUFmdlFOMTBScFM0NnN2ZjNVQzgrUkIxTHIySUYr?=
 =?utf-8?B?NEhtZkFXbVR4VFRYNkJ0aDY1YUcyMzVUQW9wTnJST2E4N3pWYWVlS1lyR1BZ?=
 =?utf-8?B?ZU9IRUlDak0wcUs5eGw1dDVxMEIzZFg2bWQram5YNE9iYmJ6Q08wTW8vRnN3?=
 =?utf-8?B?aXQ2SUp4c3lDNCtrSHhSU3c5a0tYWVo1MURXWmhNRy9PM3BlbVNxKy9ZSnBB?=
 =?utf-8?B?em55NDJybDJPOHBzZFBBdkR0YitiNDBJcllQbmJMVmo0dWgrM2RvSEdySVEw?=
 =?utf-8?B?Nm0vTS9FOHBqMzNLaFl1M3NTK2NWK1gxUU5oSURhbWtDZXN5TW53YVovVEwy?=
 =?utf-8?B?Wkg4cmQvOTNBRE0rVGkrZmdJdFBsdHRURTVjaHBBL29pK2JUeURxOG1GNmNR?=
 =?utf-8?B?Rk53RWJ0eFU3RDRvZWU4am5ZNFpKbVRqQU9SSEpiZUVtdkRkaE5VQjd2Y0tw?=
 =?utf-8?B?RXo2a2NKNXZiNm1MdXYwUVVQZVNBYUxxSTZXYkJTaVVVREp0RUhhYldzaVNr?=
 =?utf-8?B?dTkveHJsL1FyVTFjOXV6Tm1Ca3ZCNnA5RitjZ091WDRhRjdLK0VyYVlueFp1?=
 =?utf-8?B?Vnd4bVB6eHpvMXRtNFVuMDVlMXdEVDZqQzAxUzIyOCtvMlRxWmFkdWYyRzNk?=
 =?utf-8?B?MXZwV0l2RDl4em41MndpTHFCVEpLSUI2SXQ3Z2cxbVdWbnJkY0d2dzBiYlQ2?=
 =?utf-8?B?RkFacUZkUWUydm1WbjVnenJuaFJkUjBOSElXb3ROMmczWk5jSnFpN0hyU2FN?=
 =?utf-8?B?YmFyaXlPR1lrQkxTSjJNNk4wZ1VaSy9naElLNjZ2N1MwVU9SeG12WEZsNzVi?=
 =?utf-8?B?dWpNZG9ZN2lWWGFVaHFzSGdTZlRCQXF6eC95WGdnUDlGRUl0WTBUclRWSm5i?=
 =?utf-8?B?eG9tWEZ6REJJQ3pDdm94QUYvelcwbTRLdkp3b1BVbFBuZURlZ1luVkppV2FH?=
 =?utf-8?B?aVgvWmN3ODZrdjZCbkhrdzdLa3BtTG9lNjFmTStLeWJBTUJrL3VTZXJnOEVl?=
 =?utf-8?B?WkVsT012TTBBVGpNMU1Gc1diR0RDQm1FbkxTUVh2dThPckJ0RjZjVnRiUHdU?=
 =?utf-8?B?eHlDcDF5cnpqcGVBYTVvb2FYd1pwOEhVcFpKWjJBQktWaGpRSUNxSURBZ1dY?=
 =?utf-8?B?czJFWlVJQ3R2RU9mekFSYk9GUDdBb0JYMHZOdHZQWUxoSU40cFRPQk02aVQ2?=
 =?utf-8?B?dGt3ZTRsVGI1d2lFRmhwdTFmSUhjWkdVdnpOTmpMN0Q0RFg0MmU0SFVYdXEy?=
 =?utf-8?B?aXpyZXVqcjV4L3JUWmxjc24raENRSXhId2x3RnFadFZuZkpISWRodzNHQ2Ry?=
 =?utf-8?B?RmRYL01oTTlJU1hzb2p2MFRsWExJdi9YekxQa2k4L3FRNVh6VklmbG9EWnpv?=
 =?utf-8?B?REQ3SmhDeXZ1VDBjbkF2QVJLbFBYSzFvNWZGdjhCRk9BeEVWaEYvUC9Sd1Bo?=
 =?utf-8?B?QU9EY092RzVFb3dzN3JSY05Sd2RzakJQUmJzckZFUGFpSUxPdTladlJIcGc5?=
 =?utf-8?B?WTdBb0IvRHl3ZlpvcnVEMUFIUnZaVGhrOVZxV2VDM1JjUXVDZ1czNGpabVBy?=
 =?utf-8?B?T01VRWhtZzNGaXh1c1JzeXdUdE94NmZHWlFLSlZoYldxMlc2WEUvR255OUdn?=
 =?utf-8?B?eXBOL25uTE1XWmZjTjJiaTFjVGFPVStlZlhsTWd6dWpWZHNOZDRkZlk3VUhH?=
 =?utf-8?B?ZUp3SVo3WXNLZnJJdzFFeVZsbmlUUFJBR3lSTUpuZ2M1WFBmaEtqSURZcHBw?=
 =?utf-8?Q?x2Y4BUnybLQ1FFyIiRnEmvogvphoJVOd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR17MB5969.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTVoTWVhK2M5S1laRGkwb0NNQWhmaHROb2NpZWRQZlBycmptenp5T3JMVHNa?=
 =?utf-8?B?WnRBNWZrZUlkeStxM2NiZUIwMm9qU0FQaE84WGRON2JCU0hKUmNSTS9mVTla?=
 =?utf-8?B?TFBXa0JvbDY5K05FWjVTaXIyZGh5K01Jb1VGcU5sTkdkbmpzTGZSdEZIRVZW?=
 =?utf-8?B?ZGtQNWs1K0QvQXgyZGN2aUdMRTRLTFBieHMrWTZmd2xDekpHS203OUR1TVBa?=
 =?utf-8?B?NEhrekxRY0xNZENMeEx5d3lQQ1R2cll5QjJxMlhIR0NTYXJXUngrcWxKcm1J?=
 =?utf-8?B?SThBQ2puZzgxTDd5OEJQM2xURktZdTUyRWVLMGFUaE1yK0VTUTJBN0IxSVp6?=
 =?utf-8?B?N0pqbDNYTU5CTGFEUnp5UFR5dGljNHJlOHAwRnBSQ3cwdEhQbm04UUk5ZnZq?=
 =?utf-8?B?K1Z5eHFlQU9XM1RmY0tpVWx3cFcyd25yRnhQOXM1cU5abnduUHMyM2hNams5?=
 =?utf-8?B?c3JwYktocUtJMVNRSEk3MFNYNGNvK2cxeGR2d1hVNGRQdFFpcVdQZS9nVm1B?=
 =?utf-8?B?Y096c0p1Z0prUXVYRkdCU3h5Q05UNkxXUFloeU4rWHdVQTFyYWI2SzZrQk5T?=
 =?utf-8?B?d2dkVmVPOVhVT3pPSE5EaTNBTnBMTi9RM0w3Qi9JQ3F6TCtaVmVzVGJlUlhV?=
 =?utf-8?B?aGRSMUhvSzhzZWJ6L1ZsY2x1QzVzZ2ZqUjlDK1kyY3dNdU9VZVBtRWIzNlgy?=
 =?utf-8?B?ZnhVWUUwblkrL0t6eGwrVzQ0OU8vK0pNOUwvdktKR3NpK0pWanVKbldmdTBP?=
 =?utf-8?B?YlFxeTFzOE1XZm5nWVhiWGtDV042TWVzMVpxMDFsNFZnem96YUoybjNHZXIw?=
 =?utf-8?B?SHU2bXdZall1NFN0dmJOMkJrUGNnNWtOM05GemZrSkU3NEN6VkwrT3EvWVcv?=
 =?utf-8?B?S1Jxd1pKRmhsclJ1dHA4bUFLeFF3Z0VYS1lPNVRGV2V5QzFhMUptOGZ4V2Vp?=
 =?utf-8?B?d21lZk92RDZ6K0JRcFgzME5pd09vR2lUNTBuS01FalZZZjIxZzFLKzhHQmhW?=
 =?utf-8?B?cXBjQklDSzIvM2wvZVhqVld2bXB3bGRCb2tYK2VyaDNZbHJtYThJSE56VTgx?=
 =?utf-8?B?WmJuOVRQUFRxU0xyeEVzRDNHUUF3MHdzaFBmelp2S2p4ZTRKNEF0QmJLY3VB?=
 =?utf-8?B?LzRLUnBldnpFdzZZcmhjOThnc05BckFSNEJ2eUpJMk1rQ0NicGtLYm5jUllr?=
 =?utf-8?B?ODJwd1JrYzROWE5CRkZqLzJOOWdJUllwRmNhVHBDQndGK2JzTHJUZzNtcXZv?=
 =?utf-8?B?YVpsQlJZVkRFblhtSTFqeDQyRFBPeVB6NmFvbXdneXdtbXo5Uy9NNS9WZFNV?=
 =?utf-8?B?cFlsYldtZ0d6VmZpNW9qM1FoMXJRd1VkRUkyTTV0NGY0S3RkWFpnYTlWeC9h?=
 =?utf-8?B?NWd3UlkvVFJ5YVNISU5mb2JrRHoyUENFa2phTTlnd2hDclVqUjBLZDJhRU85?=
 =?utf-8?B?ODhhRDNqb09BVFpZb3c2ZWZXdHRGOXZTZHpoVE9MMStwME54b2gwREVYenJN?=
 =?utf-8?B?T3NtZkhQZXNTeHF4SjJ0TDE5T0IxTXZ1K1VlcWRHQWJzSnJnNTZqS0ZHQ3p0?=
 =?utf-8?B?U1cyM0xSL2pRcVZRSUc1ZWxRRUdpVFh1c1g0VEpGR3Z0ei94ODhiMy8rN2lv?=
 =?utf-8?B?bVRZeG5xUlEzeVBkZEVKanZiRDF5cFFHQWpFL1B3dWszV1ZTNEtqK2tkd1ln?=
 =?utf-8?B?cWIwcHprQWRMenhCQWIvUXp1aDFlMXg4RW5BVTZ2bU94enV4Y25ZV0MvckVF?=
 =?utf-8?B?VDM5VXVtWldJakVhZXNZbDJLOXl2VHd5eWlJQlBjT0VnRXE2a3hvc21aVnE1?=
 =?utf-8?B?TUtpUU1oMWQ4VU45bGkzMWNaSGZ5WjdkdFhwdDZwVGN1TEJyUUtNRWs0dzE2?=
 =?utf-8?B?NmhoMDgwMXNXSkt5c0R1T2FRWDNIUXRORzdpanJtOCtoQklCdURQOGoxK0Zj?=
 =?utf-8?B?Nk50amxPcmlBRVpSaDErd3lNbXp2dkRqc0UyVytlYjlBU013Nnd2MlZZNWtE?=
 =?utf-8?B?YVlDOHFLWk41eDBRQ2F6Wk9Xa0VhZERpNm5pYmlrS0Z1Y3p4SGRRS3ZxUTJk?=
 =?utf-8?B?Rmtlb2lVcHcrQVFtUC95cFVNQWJXbVpxYnJ5SkFHNXJ4RG1aazBqZElyZFBi?=
 =?utf-8?Q?6Yb6SusZcqZgtd5kQ2qU/vfl3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR17MB5969.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a931c4-4b89-4ed5-7699-08dd3af8a438
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 15:22:53.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h+dl2U5hwMq2h5mL6fMajxrulwQkBU/Rfr4rsxErxbymGV1TpIukSBMW6Q2s22nfn88iGKJ9Ho7o7yhh2osjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4878

SGkgQmVuY2UsIHRoYW5rIHlvdSBmb3IgeW91ciBleHBsYW5hdGlvbnMuIEl0J3MgY2xlYXJlciB0
byBtZSBub3cgd2hhdCB5b3UNCmFpbSB0byBhY2hpZXZlIGhlcmUuIA0KDQo+IFRvIG1lLCB0aGUg
bmFtZSBgRkVDX1FVSVJLX05PX0hBUkRfUkVTRVRgLCBhbmQgaXRzIGRvYy1jb21tZW50IHNlZW1z
IHRvDQo+IHN1Z2dlc3QgdGhhdCB3ZSBkbyAqbm90KiB3YW50IHRvIGhhcmQtcmVzZXQgdGhpcyBN
QUMgKmV2ZXIqOyBub3QgaW4gdGhlDQo+IGNvZGVwYXRoIG9mIGBmZWNfcmVzdGFydCgpYCBhbmQg
bm90IGluIGBmZWNfc3RvcCgpYC4gDQoNClBlcmhhcHMgYSBiaXQgbWlzbGVhZGluZyBJIGhhdmUg
dG8gYWdyZWUuIEl0J3MgcmVhbGx5IG9ubHkgbWVhbnQgdG8gYXZvaWQgDQp0aGUgbGluayBiZWlu
ZyBkcm9wcGVkIGR1ZSB0byB0aGUgaGFyZCByZXNldCwgd2hpY2ggSSBkb24ndCB0aGluayBpcyBh
IA0KY29uY2VybiBpbiBmZWNfc3RvcCgpLg0KDQo+IERpZCB5b3Ugb2JzZXJ2ZQ0KPiBwcm9ibGVt
cyBvbiBpLk1YMjggaWYgeW91IHNvZnQtcmVzZXQgaXQgaW4gc3RvcCgpPyBJIF9taWdodF8gYmUg
YWJsZSB0bw0KPiBnZXQgbXkgaGFuZHMgb24gYW4gaS5NWDI4NyBhbmQgdGVzdCwgYnV0IEkgaGF2
ZSBubyBpZGVhIGlmIGl0IGlzDQo+IHdvcmtpbmc7IEkgdG9vayBpdCBvdXQgZnJvbSB0aGUganVu
ayBiaW4uDQoNCkkgZGlkIG5vdCBvYnNlcnZlIGFueSBwcm9ibGVtcy4gSSBqdXN0IHRlc3RlZCBp
dCB0b2RheSBvbiBpTVgyOCAod2hpY2ggaXMgDQp0aGUgb25seSBTb0MgY3VycmVudGx5IGJlYXJp
bmcgdGhlIEZFQ19RVUlSS19OT19IQVJEX1JFU0VUIGZsYWcgLSBpTVgyNyBpcyANCmEgZGlmZmVy
ZW50IGZhbWlseSBzbyBJJ20gbm90IHN1cmUgaWYgaXQgaXMgbmVlZGVkIGluIHRoYXQgY2FzZSkg
YW5kIGl0IA0Kd29ya3MgZmluZSwgSSBjYW4gYnJpbmcgdGhlIGludGVyZmFjZSBkb3duIGFuZCBi
YWNrIHVwLCBwdWxsIHRoZSBjb3JkLCANCmNoYW5nZSB0aGUgcGF1c2Ugc2V0dGluZ3MsIGFsbCB3
aXRob3V0IGFueSBhcHBhcmVudCBjaGFuZ2UgaW4gYmVoYXZpb3IuIA0KDQpJIHRlc3RlZCBvbiB0
aGUgNS4xMC4yMzMgdGFnIHdoaWNoIGlzIHRoZSBicmFuY2ggSSBhbSB1c2luZy4gRm9yIA0KY29t
cGxldGVuZXNzIEkgYW0gY3VycmVudGx5IHRyeWluZyB0byB0ZXN0IGl0IG9uIDYuMTMgYnV0IGl0
IHdpbGwgdGFrZSBzb21lDQp0aW1lIGZvciB0aGUgYnVpbGQgdG8gY29tcGxldGUgc28gSSB3aWxs
IHJlcG9ydCBsYXRlciBpbiB0aGUgdW5saWtlbHkgY2FzZQ0KSSBmaW5kIGFuIGlzc3VlLg0KDQpJ
ZiB0aGVyZSBpcyBhbnkgb3RoZXIgcmVsZXZhbnQgdGVzdHMgeW91IGhhdmUgaW4gbWluZCwgcGxl
YXNlIGxldCBtZSBrbm93IA0KYW5kIEknbGwgdHJ5IGl0IG91dCBpZiBwb3NzaWJsZS4NCg0KSSBk
b24ndCB0aGluayB0aGVyZSBpcyBhbnkgc2lnbmlmaWNhbnQgcmlzayBpbiBjaGFuZ2luZyBmcm9t
IGhhcmQgdG8gc29mdCANCnJlc2V0IGJlY2F1c2UgaXQgb25seSBhcHBsaWVzIHRvIGlNWDI4IGFu
ZCB0aGUgaGFyZCByZXNldCBzaG91bGQgYmUgYXNzZXJ0ZWQNCm9uIHRoZSBuZXh0IGNhbGwgdG8g
ZmVjX3Jlc3RhcnQoKSBhbnl3YXkuICBHaXZlbiB0aGUgc3RhdGVkIHJlYXNvbiBmb3IgdGhlIA0K
bW9kaWZpY2F0aW9uIGFuZCBzb21lIGJhc2ljIHRlc3QgcmVzdWx0cywgbXkgb3BpbmlvbiBpcyBu
b3cgdGhhdCB3ZSBjYW4gDQpwcm9jZWVkIHdpdGggdGhlIG1vZGlmaWNhdGlvbi4NCg0KQmVzdCBy
ZWdhcmRzLA0KDQpMYXVyZW50DQo=

