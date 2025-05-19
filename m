Return-Path: <netdev+bounces-191377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F676ABB465
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1CD3B6257
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C091E5201;
	Mon, 19 May 2025 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PzSC8BmY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4560B663;
	Mon, 19 May 2025 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631858; cv=fail; b=sFK3h59306bYxSQu6LpgXXzuid1bdj5OcJW/GKIK0BhDoU0IQMl//ASf8tS5aLyEUVEL3ppfALIiiNF6kcHVW/znEp3KZmRA6M57qBIuRZG8gcBZ1HIu8bSs5/opHT3oZguopLRLAcHXlmNk8nA+u9Wh/y+oApg4XitN4y6QW9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631858; c=relaxed/simple;
	bh=fZB2RLlh3q4CDHuoFiDxSmqElFjtMTN5O7uYbcx+zHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ef4Vusnxuuow+57EsI20dsRp5+kk4F0PoKeBsLQI/iogFA2p/1XP5HhzzbGDzrWI+39DPRbqqXGL4lb+rABX03+6gRGKVJZ5l+/5khr9fBWhosW2MBkoIZZ5NS/0GPSbhC6jJ6SoqHgnOA2+vOJpXdNUnM7HQ6QA+Vaz5eRNvJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PzSC8BmY; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G23jdqHkpTcHtM54g/cFnkV1bo6hyn029blV+LVnTdZYwH5Bki6tuWu1eJYUw1no12kraXayGHxHxCkHMAGnF60ZI6BCN1ZoTQjtV/TwrpfV61R3zEIKj5chJ6Em5FuaFdte32OjauaWt5yCRv89D9yK/agfkZMkmDqGXYHJekeOYgjfNEkrFhB/dsR+ry3YWQMI04Y50aE6PMfUsfDfvE/QJBdKPVHOc0TIskaVE40nPfB3Trdq7x9Cd5UFCiSXXJb5aXJIsNs6OpURXQLYNXy0/9sc8XQZXfWd5+rrsDPXwYcW/OjHOfZew5vkRK0btdL1kgP7TpXGrj27em1Feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZB2RLlh3q4CDHuoFiDxSmqElFjtMTN5O7uYbcx+zHE=;
 b=YsNIXOndk63X5ByCs5H/7rbWqEsA+K8QSaR3fx9MsTqQMbCAmV4ttvj4sTy0uikDunXoW2kQlzZO6M6Sug+RybBZm0f5+aRDuE83lRlJPfGVNAZdWuHaFajFFB2DkHGiZ64NDE3vf2QZid05U8vo4tI4Qa4u4Ujk+kkd9xrX0Azg/gZhJWXSKrHboCMXL2FnEfAOKSGdQzi1obP9slZLranTExidXi0woDMcljPEDa8eHQ2MR0ja2/lC7hW8dTwE6ZWrcliivLzzZafS/oZBa0Fl3CITHq1gFAqnUx2T09JXJTpw/lYCJfckDcxp+94vdPU+kdMSUGGYISCH/KTQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZB2RLlh3q4CDHuoFiDxSmqElFjtMTN5O7uYbcx+zHE=;
 b=PzSC8BmYsQbT8cQd3XsvNVW5hQOfXqORtP9M+rClx2Prhc29VTVVBPYO42JhxoBVpHnPj3XmIbFxmZeNOaLu8iZg4heWPrpKsbGKWniVx3ldSwO3KjYiM8mswtWcZqcc5VJldX2FYiSpq8jCQe11zNQqh7GBeEJwROqHVUCSgcI=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:17:33 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 05:17:33 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Eric Dumazet <edumazet@google.com>, Can Ayberk Demir
	<ayberkdemir@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v4] net: axienet: safely drop oversized RX frames
Thread-Topic: [PATCH net v4] net: axienet: safely drop oversized RX frames
Thread-Index: AQHbxj6vkm1qz95Sh0W7gxuRvdlBArPU9fMAgAR15cA=
Date: Mon, 19 May 2025 05:17:33 +0000
Message-ID:
 <BL3PR12MB65717939233B7E5F94BF7E43C99CA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250509104755.46464-1-ayberkdemir@gmail.com>
 <20250516084334.2463-1-ayberkdemir@gmail.com>
 <CANn89iJ9iAP0GXk_qmzu+2MjWHi_NDOjG1QdLAiY1YSj+RjZQw@mail.gmail.com>
In-Reply-To:
 <CANn89iJ9iAP0GXk_qmzu+2MjWHi_NDOjG1QdLAiY1YSj+RjZQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8eff40ea-e993-45d0-9431-dc72f22e2ac5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-19T05:09:15Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|PH8PR12MB7351:EE_
x-ms-office365-filtering-correlation-id: f0fc81e1-1114-408b-87e8-08dd9694760f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VG11SXlkUm1lZXFLSSt3M0dnZFRrRm4rTG1CR1pMTWVCQ3R3ODRFTzJnTFhV?=
 =?utf-8?B?U2ZVbWlScVFPZ1ZpV1lZUC9lekVkUDBOeEVWQ2puQTJ3ZHFhN1lrUTVxM0Jx?=
 =?utf-8?B?YTVJdlFwSzFWbGdIWURxUzJvaCtPM3BzVkhLenhaY0hPaVlDdmxvL055RzN2?=
 =?utf-8?B?c1RZU212cTRmajBzOFAvam1qMmcxdlBvNG1wMTJQNXBxK3NqQk42eHQxdHdF?=
 =?utf-8?B?YmI1RFZsSjVZcmlvdGNqV2krbUtDb0xrUkF0aUpKUnJlSDFLSG9ldVVFQ21Q?=
 =?utf-8?B?cG9hNFE4UkM4cG5GOG84anZDWXhNZlhBUVYxMjNOS2xyUkd0Y1FZSitRWHk3?=
 =?utf-8?B?SVhiVXc4dXBUQWhGUDJQR0MrakoxZWRIU3BGdkhFSUpRMkNzSngyUkl0MG8z?=
 =?utf-8?B?R0FYc3g3S2JmVUlsbWEzZGZlVVRDRVJUNnFiRitCNnBnWmJabm5ldC9KOEdE?=
 =?utf-8?B?TzBOZnJTWmxRa1ZTMDVOYlQvblpOL2FPSWZzc2luaHBXRlpXRTRUSi9weUtY?=
 =?utf-8?B?WllEZkRBNXVnTmdlV1JVWEFaeHh3TVdjdWg1WkZCbFJ5QUtZMjdVWEtHZk9K?=
 =?utf-8?B?UWdFRFRBakNWNkhjSHVJNUkyV3J3MHN5T0JsRHp6T1RXNmxLUVRUVG5QTFpl?=
 =?utf-8?B?NkFlck1xSlVRZ1Y2VmduVjhYeE81T1d5d01lbnlBOGpNK0FOWnp2eGRmMW5s?=
 =?utf-8?B?T1EyVXF4MStWZ0ZVVzlObVQ1amtGS2prQXZwTGVOTGd2dEgzUVl2d3VjZFp3?=
 =?utf-8?B?YmVZMXN2aEVnRTBVMXFtam1JTXlsdy9aNnBWb0hyaWdSMzJzYXNwUWJJWjFH?=
 =?utf-8?B?NHlRaFlkaE4rbllGdldLVWNnUVR6SUhWYUpVdU9aUHRZSEYxQ1lxYlRoSVc4?=
 =?utf-8?B?TjhINXVGWER3RlNYUGo2MGluamR6WFNPT0xwUkFJdWRkLy8wQlhjSW01amJE?=
 =?utf-8?B?V01GRHd4UVZZTy9rVXlGeDB2NzZsbzV3Rzc1QzFpT1NSZlB4azFrSTM4cmFT?=
 =?utf-8?B?cUVFNjNtTGxscGZWQ1BORWVNNi9LcVRXVEkxYStXOGNWVFB4RW1jM2JncURT?=
 =?utf-8?B?eGZzNHJ2TU1oc1BDZ2JERW1IcjBHT2pCQ0xza0o2TTduRDkrZityT3U0STh0?=
 =?utf-8?B?WEt5RGwwWjlEQXNrUXVLZGhsdXM5R1plVno0aUpGK0Fla21RcFJpTFhpSnd0?=
 =?utf-8?B?b3F4dElHZDhVakQrN2RYVFh3LzlKcTZXK1ArUlAxWk9hNkpqS1lWempleGlk?=
 =?utf-8?B?bWFUYXRoVm5sNXdhZUMzalpscE0xVm9tdlpYWlBVVVc1Y25XZ2RaYUwyTEZY?=
 =?utf-8?B?OXJ2NldTSGYxY3k5L1JXUVl4YzhRb1V0dEN6cWplRVRjNldUTVc1ZnUvcWFQ?=
 =?utf-8?B?ZzhhZG5vMlh2Sk80SW1vbEE1dXlCMHFvWm9DOWhteVlCK0d3c295T0lOdWhJ?=
 =?utf-8?B?ajdVSlVzRm02MHdmNzdSdDVhV3FmcVh4aDlGeG5sa1R4Smk3cjh1WXhoYkd4?=
 =?utf-8?B?YVJVbTc5KzNPTmJxVS9QL0s0dS84a2ppV1EwR2VkU1pMbU83eW1EZG1XV1ND?=
 =?utf-8?B?UlJsSWNDVVI5TmZzQ0N0Rk11YlBxSHczUCsrK282M1lDYWQxQ3dsS1RTdEU2?=
 =?utf-8?B?ZExYSDVUQmgrSUl6enRJTHFQbXJCcDBuUTl2aXlKQUdlUlJjUlBXUHdMdWlx?=
 =?utf-8?B?THk3b1RrL3JXdnlJOWwvTWhRb3U4eWJSNDVRMzJmNkt5dHUxK09lTy9Va3Vi?=
 =?utf-8?B?cWt4akQ1bHdzcHhodThHU2tFbUI4TUpwZzF3b3Z1Uk5heVd0RDdObUxiaHdo?=
 =?utf-8?B?K3dvNjZ5VythdHlXV0N3c0xiNC9IZUdMNERERUhmWkJqc3BVam5ubHRXbm44?=
 =?utf-8?B?TVNiemxKVVZXV0g2dTNOd01POStmWDU4aU1lYVp2aUR4RDJaVEUreFlLMzYr?=
 =?utf-8?B?VTRrOXRDSFJPQ1FPQ2lkVnpHNy9IOFcxM1B4eXB3SDhZNmhaMVMzZkNFaXNs?=
 =?utf-8?Q?t9NEd78ZOJqbkOFjg7N/zZ5ii+Mf38=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U041dUU4TEtmM2xzcnBRU1l0OHBxYW1yQjNGcEJYQmtlZWl4R1RaUldBWkZz?=
 =?utf-8?B?OFREVjBHcUs1TGp2OTdQdVMrcEtCMFFnenBDK1ZRYXptSExBdDloM09VZnBX?=
 =?utf-8?B?NlMydmViREduN3NkRmtHeFR3a0VXRG14OEZmNTFac3NxeXJnc2diRzdzaEFH?=
 =?utf-8?B?Z0JhQXBLZzVyS2Q3eHRsZzFZRjhNVkRIMEhpaWhvb2QwTDk3Rnprc0ZCUGxK?=
 =?utf-8?B?WUlOblY2dzhJajYyUCtOS1hLb09uYlBGOEhDUXR6VDR2R004dUwwK3Exa1ZC?=
 =?utf-8?B?REdDd2tpdUM3RHFsNHNUT1lzUzhJUkRiV0FwQnR5aFJ3UGlCWExYb2hvd3ZZ?=
 =?utf-8?B?WGRLbkpiMEorZHFFSnQ5QitFTkJ5R0prM2tDdi94czVWanZFZHc1cC9RL05z?=
 =?utf-8?B?cDlXb3RsemxTS0JQR3YydnhldmxrN3RMdUdrbGx1Zlk4RTJreWRtYkR6WGlu?=
 =?utf-8?B?Ty8wWjl5dEJ3UThZMk1RSnY1R0JpcFFYaTgyRUc4d2s0NzZaYmkyWGRFUzBN?=
 =?utf-8?B?MURTTXFrZmQ2TDVpNHg1c0V4bjlVRStOTyt6UWxjdXlsZTlwM0xLbk5Ibk9k?=
 =?utf-8?B?Ly9EQ3hJYi9LTW9tRVZYTmttZUFLQjE5dHNRdG1LV1dUKytocVhQdGFtSUx5?=
 =?utf-8?B?MlJQTktWUFIrRVMxNW93aFNkSCtwUEdWKzEydXdnbVUzbkZEcEErWGJuTjhm?=
 =?utf-8?B?b3M3Yk5lY1JIS1Q2R3RESEVYQXJoYmRQOWttbFBQMmpmZHpxbHlnSjJPTlNE?=
 =?utf-8?B?Umxwd3Zab1RKYnpCc3h3RzZnK05CL2pFbHJkMUFSSW12ek9iR0diRnNFRWwr?=
 =?utf-8?B?SFBGQnZQbXMvSjZmWFBSVUs2Y1ZsSXluS0NRV2JER2Nlcmk0bk9wQXRHZHpE?=
 =?utf-8?B?UTd3N1ZhSlVaWTNhcCtzZ1ZjSFRtamVReDZpNlRIemx5ZUxvMjFLekYwYXVw?=
 =?utf-8?B?ai82ZjNPUXFpVU9mRi9Lc205eE9WYjJrdEZHQy9DZ0V4dkorRncrN2JWdnFw?=
 =?utf-8?B?VmJCcnQ1MkRJVjFmOHFKWG90NFJ5aWh6MStKdVJNc1NRZjBLQmtaaGN1K2U5?=
 =?utf-8?B?U3RFZGlqTitVcVlmTFdMZjNUcTZSQmdoTmFjN0pGTWZrMVdZaUJ0V3FiSHRL?=
 =?utf-8?B?SXRMM3JIdVBrZEZnOEszOUFUVDgvNG81K2ZLV2FocDZFVUdhUHM3SkJ5R1h6?=
 =?utf-8?B?YjJGb2N5QmRVcmVTRjB2NXBvVGlyUmROSWI5VVNmUUxqdkx3dzM0bVJjc0Rl?=
 =?utf-8?B?RTZxSUFCdEpML3NEQmlnTUNhU1lDVzBYSTkzZUlsajFnSjY5azNrSVBDNUk1?=
 =?utf-8?B?Y0EyVExWTHdGWW4xTkQ2OU55eUxrZ0x3VU1pbjlRbDJuMlFTOVhyeHZvQklZ?=
 =?utf-8?B?eXhXcE1RNnpTYTdLUjdpTG8yNmMydHBUdWVjVTRLaSthNm53bVBrblVHWjJy?=
 =?utf-8?B?cDBtTElUR0JvZ0lWb0dVWkhaWml0Um5iMHJTN0R2bzBJWkpaMWQ2R0tNWjRJ?=
 =?utf-8?B?K1hxSzBkV1hWZk1tWEdXMi82aWkwS3pVdUJiTEtWU0dkQlFEY3VnZFNRVUZE?=
 =?utf-8?B?aXNURVh6bDE3QUpzOXBkQk1lbGMyUW4xVDREWkdwdmJOQW13L2NDdHRTQmo1?=
 =?utf-8?B?VitmcXNSZmdmWUY3SWFIR3R5djgrTmI2T0dvUWtiTVM5eWg3SFAvbEwycFoz?=
 =?utf-8?B?dmwrWDNueHZYMXVaR29rUVIvbDNXK3hla2lHUlJSbU54TWZoditjK21MV0dD?=
 =?utf-8?B?eFpxZ0srdjJEM1R2MVIyL2R3RlBua29xWXBvVU5JbEdsL3duS2lQNjk1TTlt?=
 =?utf-8?B?ejhuRVhTOG9wRStMcmQwM1BZRXVja0labncwWWw5YTRnWjNYQUY4WU5vbmtj?=
 =?utf-8?B?bTJaaTFNQSsrZU9sb1l4V1B1d0orR2ZPQUFpMG1QMlNQYm00eHRKYlMyeUgy?=
 =?utf-8?B?UEdaRkVORWlCVkhEWndjeVFkaE5pN2d4clorUzFWc1RNRHkwVW1XWlE2WStT?=
 =?utf-8?B?Y1JtMllVYU9BWEpZdVZrNzRlcnRwbURSVVJ4MU4rSG9nT1FVT0Q1aUxNUjcy?=
 =?utf-8?B?b3ZaaDZWZFNuVy9FcUtyM05zWTBYWmVwRUFseW5lb0pQNEVFeWdmeUlRV3Rx?=
 =?utf-8?Q?Qkso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fc81e1-1114-408b-87e8-08dd9694760f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 05:17:33.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBuKgJ2ntMnGx3QP+UGug/wlRSz/31KYDSDqws6WmD2sTZwS2RY++sn0xVG7+BnCAwfl9T2SmYEa2A6WmOmyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDE2LCAyMDI1IDI6MzIgUE0N
Cj4gVG86IENhbiBBeWJlcmsgRGVtaXIgPGF5YmVya2RlbWlyQGdtYWlsLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5
YW0ucGFuZGV5QGFtZC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsN
Cj4gRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBT
aW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEd1cHRh
LCBTdXJhag0KPiA8U3VyYWouR3VwdGEyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
bmV0IHY0XSBuZXQ6IGF4aWVuZXQ6IHNhZmVseSBkcm9wIG92ZXJzaXplZCBSWCBmcmFtZXMNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBGcmksIE1heSAxNiwgMjAyNSBh
dCAxOjQ04oCvQU0gQ2FuIEF5YmVyayBEZW1pciA8YXliZXJrZGVtaXJAZ21haWwuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IENhbiBBeWJlcmsgREVNSVIgPGF5YmVya2RlbWlyQGdtYWls
LmNvbT4NCj4gPg0KPiA+IEluIEFYSSBFdGhlcm5ldCAoYXhpZW5ldCkgZHJpdmVyLCByZWNlaXZp
bmcgYW4gRXRoZXJuZXQgZnJhbWUgbGFyZ2VyDQo+ID4gdGhhbiB0aGUgYWxsb2NhdGVkIHNrYiBi
dWZmZXIgbWF5IGNhdXNlIG1lbW9yeSBjb3JydXB0aW9uIG9yIGtlcm5lbA0KPiA+IHBhbmljLCBl
c3BlY2lhbGx5IHdoZW4gdGhlIGludGVyZmFjZSBNVFUgaXMgc21hbGwgYW5kIGEganVtYm8gZnJh
bWUgaXMgcmVjZWl2ZWQuDQo+ID4NCj4gPiBUaGlzIGJ1ZyB3YXMgZGlzY292ZXJlZCBkdXJpbmcg
dGVzdGluZyBvbiBhIEtyaWEgSzI2IHBsYXRmb3JtLiBXaGVuIGFuDQo+ID4gb3ZlcnNpemVkIGZy
YW1lIGlzIHJlY2VpdmVkIGFuZCBgc2tiX3B1dCgpYCBpcyBjYWxsZWQgd2l0aG91dCBjaGVja2lu
Zw0KPiA+IHRoZSB0YWlscm9vbSwgdGhlIGZvbGxvd2luZyBrZXJuZWwgcGFuaWMgb2NjdXJzOg0K
PiA+DQo+ID4gICBza2JfcGFuaWMrMHg1OC8weDVjDQo+ID4gICBza2JfcHV0KzB4OTAvMHhiMA0K
PiA+ICAgYXhpZW5ldF9yeF9wb2xsKzB4MTMwLzB4NGVjDQo+ID4gICAuLi4NCj4gPiAgIEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzIC0gQlVHOiBGYXRhbCBleGNlcHRpb24gaW4gaW50
ZXJydXB0DQo+ID4NCj4gPiBGaXhlczogOGEzYjdhMjUyZGNhICgiZHJpdmVycy9uZXQvZXRoZXJu
ZXQveGlsaW54OiBhZGRlZCBYaWxpbnggQVhJDQo+ID4gRXRoZXJuZXQgZHJpdmVyIikNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENhbiBBeWJlcmsgREVNSVIgPGF5YmVya2RlbWlyQGdtYWlsLmNv
bT4NCj4gPiBUZXN0ZWQtYnk6IFN1cmFqIEd1cHRhIDxzdXJhai5ndXB0YTJAYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+IC0gTW92ZWQgRml4ZXM6IHRhZyBiZWZvcmUg
U09CIGFzIHJlcXVlc3RlZA0KPiA+IC0gQWRkZWQgVGVzdGVkLWJ5IHRhZyBmcm9tIFN1cmFqIEd1
cHRhDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gRml4ZWQgJ25kZXYnIHVuZGVjbGFy
ZWQgZXJyb3Ig4oaSIHJlcGxhY2VkIHdpdGggJ2xwLT5uZGV2Jw0KPiA+IC0gQWRkZWQgcnhfZHJv
cHBlZCsrIGZvciBzdGF0aXN0aWNzDQo+ID4gLSBBZGRlZCBGaXhlczogdGFnDQo+ID4NCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+IC0gVGhpcyBwYXRjaCBhZGRyZXNzZXMgc3R5bGUgaXNzdWVzIHBv
aW50ZWQgb3V0IGluIHYxLg0KPiA+IC0tLQ0KPiA+ICAuLi4vbmV0L2V0aGVybmV0L3hpbGlueC94
aWxpbnhfYXhpZW5ldF9tYWluLmMgfCA0Nw0KPiA+ICsrKysrKysrKysrLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5l
dF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5l
dF9tYWluLmMNCj4gPiBpbmRleCAxYjdhNjUzYzFmNGUuLjdhMTIxMzJlMmI3YyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21h
aW4uYw0KPiA+IEBAIC0xMjIzLDI4ICsxMjIzLDM3IEBAIHN0YXRpYyBpbnQgYXhpZW5ldF9yeF9w
b2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50DQo+IGJ1ZGdldCkNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFfdW5tYXBfc2luZ2xlKGxwLT5kZXYsIHBoeXMsIGxwLT5tYXhf
ZnJtX3NpemUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
TUFfRlJPTV9ERVZJQ0UpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc2tiX3B1
dChza2IsIGxlbmd0aCk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc2tiLT5wcm90b2Nv
bCA9IGV0aF90eXBlX3RyYW5zKHNrYiwgbHAtPm5kZXYpOw0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIC8qc2tiX2NoZWNrc3VtX25vbmVfYXNzZXJ0KHNrYik7Ki8NCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICBza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX05PTkU7DQo+ID4gLQ0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIC8qIGlmIHdlJ3JlIGRvaW5nIFJ4IGNzdW0gb2ZmbG9h
ZCwgc2V0IGl0IHVwICovDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxwLT5mZWF0
dXJlcyAmIFhBRV9GRUFUVVJFX0ZVTExfUlhfQ1NVTSkgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY3N1bXN0YXR1cyA9IChjdXJfcC0+YXBwMiAmDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFhBRV9GVUxMX0NTVU1fU1RBVFVT
X01BU0spID4+IDM7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY3N1
bXN0YXR1cyA9PSBYQUVfSVBfVENQX0NTVU1fVkFMSURBVEVEIHx8DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY3N1bXN0YXR1cyA9PSBYQUVfSVBfVURQX0NTVU1fVkFM
SURBVEVEKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNr
Yi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fVU5ORUNFU1NBUlk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KGxlbmd0aCA+IHNrYl90YWlscm9vbShza2IpKSkgew0KPg0K
PiBJZiByZWFsbHkgdGhlIE5JQyBjb3BpZWQgbW9yZSBkYXRhIHRoYW4gYWxsb3dlZCwgd2UgYWxy
ZWFkeSBoYXZlIGNvcnJ1cHRpb24gb2Yga2VybmVsDQo+IG1lbW9yeS4NCj4NCj4gRHJvcHBpbmcg
dGhlIHBhY2tldCBoZXJlIGhhcyB1bmRldGVybWluZWQgYmVoYXZpb3IuDQo+DQo+IElmIHRoZSBO
SUMgb25seSByZXBvcnRzIHRoZSBiaWcgbGVuZ3RoIGJ1dCBoYXMgbm90IHBlcmZvcm1lZCBhbnkg
RE1BLCB0aGVuIHRoZSBza2INCj4gY2FuIGJlIHJlY3ljbGVkLg0KPiBObyBwb2ludCBmcmVlaW5n
IGl0LCBhbmQgcmUtYWxsb2NhdGUgYSBuZXcgb25lLg0KDQpBZ3JlZWQsIHRoaXMgbWF5IG5vdCBi
ZSB0aGUgcmlnaHQgcGxhY2UgdG8gZHJvcCB0aGUgcGFja2V0LiBQbGVhc2UgY2hlY2sganVtYm8g
ZnJhbWUgY29uZmlndXJhdGlvbnMuIFdlIHN1c3BlY3QgbWVtb3J5IGZvciBqdW1ibyBmcmFtZXMg
KHJlcHJlc2VudGVkIGJ5ICJ4bG54LHJ4bWVtIiBpbiBEVCkgbWlnaHQgbm90IGJlDQpzdWZmaWNp
ZW50IGluIHRoZSBkZXNpZ24uIFRoaXMgbWVtb3J5IHNpemUgaXMgY2hlY2tlZCBpbiB0aGUgZHJp
dmVyIGJlZm9yZSBlbmFibGluZyBqdW1ibyBmcmFtZSBzdXBwb3J0Lg0K

