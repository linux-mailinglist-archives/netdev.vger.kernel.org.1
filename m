Return-Path: <netdev+bounces-199409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC5AE02C4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7806A3A3918
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4B223DFB;
	Thu, 19 Jun 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q49GF6BX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4016223DC9
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329334; cv=fail; b=O8HrQZxn5Ew5+HX8SJD3i/go2uR2aG0d58KdcmwISJfiyuoHkEEZBEjdUbbwQGrDIozoO0tnMHs43aQXkjPgslIoGfmrf6f/CWd7EnVG1c39nYxHTumzAYlHGmxYHa433+4FiC5PVURgSNy/P2DY8so+jfE60E8s9S0OPZPGbpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329334; c=relaxed/simple;
	bh=HUh6bZPmPEKaLlQs2EqwVBJAUkbipSwwo+x2l5dlAvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ov32DHp1mdKPchs9s3yETtIwDxgFWXCThzdyjvabMWdixe4VUH1NuGZRAjV22BrSTQ49p7bGgv9/193fFAAEmYCQiZa/lW1/Pz8qZdcUTf3sPuJyjmcj3WKhpve3j9RkNbapAgVXaloMx20DHkU7wnnyEO6IFtjihg8KiClxNRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q49GF6BX; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEEAkIoJRTCu2bKIK5Z/v8ncdMgJcX3YFhejPRlZeQTvgDoGYPSVyXJS8/91RDN8AbA7pg2HQKFQta1NpaBfRa5hBMEN9lQtVKcOxg2RajJvI/mzUAoPjQ6Kb5olADqcH6QAyQ6EmG1Msr2XPG/PNxuHWbZ9H7cmPiT2QWoAKwHNeHmwSuaUVVAiP1OHNgZMLO3IKcZpruvm0AWjT4PRFmsR8/BIlR04Axhk44TFli1l9M0SefkA6FBXp9ddaptkT+trF9c9hPjRCtkkAhchHMsPnVc2zgxNCrQp/yhDG6tdrB9w8cQyGKWsgkGIKOjqelYrmkoEG9U4xgloiq/TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUh6bZPmPEKaLlQs2EqwVBJAUkbipSwwo+x2l5dlAvQ=;
 b=DgCq+WaM2Sp9RGDKOTv0v9OXqHsSRXPUh92gOOhInVIllGlQcfJFfUqF0LN4DCqXpgzujSfeTWQq+FSqjl6/7ccLog/7+MZyMbYJovm8Sn6mmK/yUzLfTCzREbhxvTk/HoWZyn+WxihbMa8COUqD4nbdqc8S7/JLTZIEF44P1l1KnCEMqN90YII1zewz+URaQ8H8fKPwA+G1JaLrUS7N+etwYBvuAbIRiRCTU5VFfYkuC1klgRmW5fZxiW4VTKwU6XbBljcyE9ZO6GXxPZ6l++yC+aTJpGtX/YH0OFmKsX7c+yGXSvmaSg4FqyBqCb4usU/2SpZuwNRG23OyIXNK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUh6bZPmPEKaLlQs2EqwVBJAUkbipSwwo+x2l5dlAvQ=;
 b=q49GF6BXfAWcXtTI7tuOQuUVhwKqf6PhB+4C/WTLORgH5pzaZLIly/3oD6LVo8GmnpTJbMaSMg5vROc8hsZwFoiXQgZwRAA1+0QiIydTjGeNnrVtzKyXsnwU5So2ekgL/nb4DEkj1pTIvnFwabG3jrkF+SB/7W0s1YHuMqokCx7yj76215rdxotKrb5NyE3/trhmTZF6d5H09jOROZrbmhEPm3Q+6HzZvF8m3TG6z/PCRS03RtC8DHIMsdjY1xdZ7L299aRuPDxF/FKHgQx0MbXV1zsivUGIqeHXwqcoxdNyQvYudNRB9xDlVbU5U6aGEMGAKNpqDVpPIDFfKQdu1A==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.33; Thu, 19 Jun
 2025 10:35:30 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::1737:4879:9c9c:6d5f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::1737:4879:9c9c:6d5f%6]) with mapi id 15.20.8835.032; Thu, 19 Jun 2025
 10:35:30 +0000
From: <Rengarajan.S@microchip.com>
To: <aleksei.kodanev@bell-sw.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
CC: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
	<davem@davemloft.net>, <Raju.Lakkaraju@microchip.com>, <kuba@kernel.org>,
	<richardcochran@gmail.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
Thread-Topic: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
Thread-Index: AQHb3rMyYgI6dXHKSU+AARYFNcNdnrQKRdKAgAAHhQA=
Date: Thu, 19 Jun 2025 10:35:29 +0000
Message-ID: <d201228a692312c3bb658bbc3e1865a3289a0684.camel@microchip.com>
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
	 <6a6eb40f-9790-460b-aeab-d6977c0371dc@redhat.com>
In-Reply-To: <6a6eb40f-9790-460b-aeab-d6977c0371dc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SJ2PR11MB8371:EE_
x-ms-office365-filtering-correlation-id: 4fd82047-fef2-464d-3e47-08ddaf1d0346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTFJTGE5MVltc2N0UkpUUm9oZ1hVRE1JZGdPVDl0ZHBoVzg3L0dxZW9aZXJa?=
 =?utf-8?B?cjY2N3Uza2xwS2RjWXhOdWNud04wZUpobGh1TWZYMmdJUHBIckJRcWpkYm5C?=
 =?utf-8?B?bXpwb3lqU0lqbVErNlhqaDduVDN3NDEzV0NhV1NvNUIzK3paK0xTMjV3d1dM?=
 =?utf-8?B?MWVxdkIwejFOT1BqQldvSTM4amZia1AvckdkMDl6WDMybFZ6dTNxZEhGZG9p?=
 =?utf-8?B?aDV2TkNLSUV0Q0cwemJGVGhzU0NlNkRuMkZIUTlONVNNbHFXaVBHd2hJWnk4?=
 =?utf-8?B?SVpFZ3VTK2JwZnVudEV0MXQrQ3BmZVVwS0lTOHZBam5USkVkY1ZrUnZ5YUx0?=
 =?utf-8?B?Q3Rvb0tCWmVYZjBFZCtUdm13eWxCNVM0Uis3YzdZZ1VGMVdveFRBOUd5Q2E0?=
 =?utf-8?B?cXBwdDA5bFFSczQxc1dUZk4wZ3VsSzZJVytJNDhqV3RTMDloc3psRHhXeXV0?=
 =?utf-8?B?TUxDMUVsKzdtVlJxbnJyWnN5Snh3VWlYRzVPbndaSDQ4Uk5QWVlIQVZuRmVJ?=
 =?utf-8?B?M2FoNW9qTDEySzdmazZySm5IeEQ3V2s4blFvUFdkQ3ZqR3RQcHAxajh1RFd3?=
 =?utf-8?B?UndNeUEyVXBtUUdXMEZFY1BmSWRHdTBiajgycW41U1FpaGRJRldveDh5VnM3?=
 =?utf-8?B?dUFHaU52NFh6aGhwK09WeFk1OVVLQmRXNzdWa01xdmZRUlc0a2JJa2FFSExR?=
 =?utf-8?B?cWlnN3laMmZUdWFpYmVOaFNrR0VDTko4YVUzcVI5bnd0TmIrdWRQVVdzUW1F?=
 =?utf-8?B?c2pNVCtRNTJsVVMyMmhRdWxLM1cvN3FsdXZyc1p6V0VOM3RYZlByVCtqejgr?=
 =?utf-8?B?R0ZrbHY4TGpvK1ZqdTZhQmVTRjhMRmVISG5DYWx1aGRaV0FwSEszcnJwSUdm?=
 =?utf-8?B?cG9Sbk1FbXB1Um4yREZ2NXNGT0s3VXZsT2g0R2JnMTg3cWgzeFJXMFVtMThF?=
 =?utf-8?B?eUY2YmpCeXBQRDdhNlVDNTNhQ2JrcnlIYmI5UGF5TUZUaFl6RHRKK1l6RzV3?=
 =?utf-8?B?SDFNYTV5azhpdFhiekZVZVQxa3JnU1JSTWRqUkxhMkdKUkZGTE1jNkg4SnZm?=
 =?utf-8?B?MTN3M2JsTHV5N2d4dFZ3UnNWWnBjV2pCb2xMOU5GbnZ6WitvR1diUjNyZHpi?=
 =?utf-8?B?cmRHeldudEdEK00ySy8zMVArVlErc1E5eTlzZFJNYTlBWVZmd0FkQndUbUla?=
 =?utf-8?B?SVVoVmlWVHUyTDhUckFqT00vZE10MjU3d05BT25sQXlJUy9JYXlZYkNMRnhW?=
 =?utf-8?B?dS9kMzZpSmVtODVDbDh4WXN4U3VFQW1lY2wyQmdRWjA5Rk5VUHNBOUNxWFJX?=
 =?utf-8?B?M1NpNEoycW1KcnNiMjM3cU9Mb2N5WUZMUWxPeVpzSUdPbXJwWlI0dzdIMmNy?=
 =?utf-8?B?N2ZxaHFoS25ObCsvRCt0bTFrL0NTYnVDNW45QURUM21ucXRPMGFrcDNGaTFF?=
 =?utf-8?B?TTVXTXVXd0JFRUZKRWRPK0k4OTlVN3RsRkszK1ptRUhodzNGQ1pPRjRWNmFk?=
 =?utf-8?B?QythQlVCSVdMS1M4VjBMeTRVQUdETUpBdkhyYVd6UzI1b1MzQVRXV3MrWUZ1?=
 =?utf-8?B?ZDY4YUtaaktaT1Y1amtXalFTOUdCNHVTenp3UFhQR2p1bFhONW5TSTRpM04v?=
 =?utf-8?B?WStCZm9WM0FOSjJvand6MjRyOGlmL093ZzZFWmUyQzFBcU14Q2dRZWs5VkV2?=
 =?utf-8?B?MDZUTDZrcGJ0bVNJVjFxbTMvNjBqQmlpRHNpQldKZWpDdjhsSVBwY2FJbksz?=
 =?utf-8?B?VzBYbldESTdhQXVmYytVUG11UkZTcmdKMlRWZUFhVVFlb2YyZ3h6dmg4ekNY?=
 =?utf-8?B?eFVyUlZUNnl0VUtyTEJLalgrR3JuTjBGZ2Zqd3QrelUySjBNemhyNE9od3Az?=
 =?utf-8?B?K0l5am55NkVyYVo3TVl0Tk44d1drRDN1SHZ0NDhmdHQ2TTFLZWhnQmFVZ3dW?=
 =?utf-8?B?bkNOcXZ6bXFJMWFOL1A2T0Y1c1I1eEpFY2FIZDEyUWpEN2U4UTJtVUtoa3g2?=
 =?utf-8?Q?InyMdHmlEKfJsnciLEDoB/Tmd46fEY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2orSjlJMkxqcDZ5SlV3VisvUituRDE1WWlLOFJRVDI4WjhCaHVuQW5QYWlz?=
 =?utf-8?B?NE9seWI5b2oyNVNOdXlDYVY3N3J4REFYd096Yll5cTJlNjlzZ0tNNXRSNGlQ?=
 =?utf-8?B?cjdYenArclcvL3RhbFlLS0hkbFNZZXFoUTM1OHNTUDU5MVdheTFIZkJBcjVE?=
 =?utf-8?B?OXRJcE1xRzVJRTQzR2tNenVGWis2bE51cFZJNjcxWEZXMWVaN3J6dnBock5M?=
 =?utf-8?B?VmZ5UUdCVFI4ajJzejBkT2s0M1g0STU1RXlJNVJ5RUpIUzJ6SlBuMFhUVHRi?=
 =?utf-8?B?elZlZnk0ZkluR0kxRlcyZHJ1bDIvNXhLOUhnbmhOL3c3Z3k5ZUJSeGNKWmdh?=
 =?utf-8?B?QVIyV3l1U3JGOHk0UTYwS1QzMXFoaXdnMllZVGt2WlRjWFowaFdMdG9rNzBa?=
 =?utf-8?B?ak03eGFJb2xWSFpSTVJqM1JQMENNSGlUamRyQmIwdzBoTWsxcmdvWjdmdXBz?=
 =?utf-8?B?SFBCeXdWa2NPWEJWMWxLV2x6M1FLZWpybHFNYXZQUiswY1Z6OVI4Y1JBek1X?=
 =?utf-8?B?akpycUErd0J2aDZtMXpLZDRDUkhuZGhRMExWV3lxMjgvYVlLRUR0OURwZENY?=
 =?utf-8?B?Ny92NnNTY0RtTXZpWW5nM1RVWGt6ZGxxWWhUc0hVUUwrVnh2ZDZVbU5pNWo5?=
 =?utf-8?B?aTMvMm96czcwZXcrNHl6ZCtVSHM2MlFaeUUzMEJBdGlqN1l3R1MxTXE0aXc5?=
 =?utf-8?B?N09Kb1k5Uk10MUFBVHZScFdMSG5vaDBaUzVja1VVMzQ4UkdQTXY0YzlwZWlS?=
 =?utf-8?B?TnRVSGtWdUhiZlB6MzFuWFFzVXpMNm5DazdFSUNrcTM2QVBBUXBDcEgvbWcw?=
 =?utf-8?B?Z0paeWhsaWhoc1NPWVZUcW9UOHlVVWk5b0s1V2Erc1FWNWhGQU5NSC9wL1Q1?=
 =?utf-8?B?cldETG5La1BJaTVkQjk2WHg5WmY3N3pXY2V4aEVnUkFFSnN5aFR3cVgzTmRS?=
 =?utf-8?B?MVRZdDVxc3p1Z1Jjek40cHpVWDY5RDBBYUtkbHVqS0xWY3RLNUN2cDBOcmRo?=
 =?utf-8?B?RWRZZTd3S2gySmcwQlVEOHJma2pqOGovamhIbXN3NDhWYjlmVENvWmJsdjRo?=
 =?utf-8?B?Uk1ZTERKNkNjVjJCNUdWVmkyZm1qYkZUSDN1NFM5UElxTFg2c1B4YnI5NWdS?=
 =?utf-8?B?blVMUUk4bGEwZ1g0dHlTTjNUbEN4ekhZSGNQVzZNNGJNUDNjUUVpNkdOSXor?=
 =?utf-8?B?bkx0NENyRXlpcU05WUdzTG1Fc0JGdFNtdVh2OEhOYW5zdTFqVGdDWVdSSTZK?=
 =?utf-8?B?b3V4Ty81SzNEcGFKejNtcllrU09yQzFzTktVKy9FUU03MDZMdS83TDBmd1Vu?=
 =?utf-8?B?a0JCN2d3QmljYVBXVjFMTWVQZURzejNzS0c2YnFTVTl2WFU1dWR0aXUyVURp?=
 =?utf-8?B?UEtPSHF4dUpacmhORXY2MEkvMkszbVFmOWJQNTBHU01WVVBlR0pkM29IcHUw?=
 =?utf-8?B?akhzTklkMzg3VWNHR3cwRzhsWGVRZ2ZPUFBua0lOSU1iVHBPdFJ0d0dIZzZz?=
 =?utf-8?B?em15bGxqZW82SHhCZkxieVk5bjUyYS9Tc0lBcU8xY3RVRnQ3b1ZyVGlMTm50?=
 =?utf-8?B?c0xXOStkem43OWM2RDMvQXREd29GOHBnOVQvUm1oTDRPNEJWNVVtVEZZN21H?=
 =?utf-8?B?VzVBZkZHZFZjTWloVVJVbFpOTFlNWTRKRnJvUHpDYzdSZ0dYSW9iTnBNbjZT?=
 =?utf-8?B?b3RmSmVhNVltN3pEbkpxekVtNzZyWmZkMEVaa1FQQmpGNEd6b3ZpdTRCWFlx?=
 =?utf-8?B?ZzRadDNVWitERlQzRnpkbEljdmFUTElZM0RRdFRZQ0QrV2pZNHFLVDhld1ly?=
 =?utf-8?B?d2pST1hpWWpFaTc5ZVNjb2lnekltKy9qQ2VpRVcwYzR4Y09BdlBhN2l6anY1?=
 =?utf-8?B?a3c1NWNzTVRDYzNHS3ZidVdid3p4dGlERlVuTFE0WE9PT0RiZzZ6bldRMmhu?=
 =?utf-8?B?Wm15UXA5Y2k0dTV4aUh5UHVGREEyc0lWVUQ5bW8zeTVOSytOMVB6YlE4SlBQ?=
 =?utf-8?B?OVpYaXdDNFUzeTJOcWVCZVladTFncW5CSlVsS01OMGh2YmpWNkFRc3ZKZXpI?=
 =?utf-8?B?cVN2WUlrRFdaVkhJRCtGZ0h6alp5dFdIZXJTNWlxc3NDREFMMWJldExHRnYw?=
 =?utf-8?B?YmFnSjRFQmh6cWJ1aVFDRElTZEVTRG5FdkRCV0M2Y0l5eC9CaXJ4NitlVXB3?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2194A1BE1391A1429A8AC19FAFF63941@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd82047-fef2-464d-3e47-08ddaf1d0346
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 10:35:30.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbt6MZk/G8LSyhaQMjBzbCX2LB7gsnnfYlXPLl7smKKUn2DndomKjW8O5da+k09WtFrc4cbBy47U5ESXYcXvR0kCbE2RT0TzJiTQdkNWmHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371

SGkgUGFvbG8sDQoNCk9uIFRodSwgMjAyNS0wNi0xOSBhdCAxMjowNCArMDIwMCwgUGFvbG8gQWJl
bmkgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
T24gNi8xNi8yNSAxOjM3IFBNLCBBbGV4ZXkgS29kYW5ldiB3cm90ZToNCj4gPiBCZWZvcmUgY2Fs
bGluZyBsYW43NDN4X3B0cF9pb19ldmVudF9jbG9ja19nZXQoKSwgdGhlICdjaGFubmVsJw0KPiA+
IHZhbHVlDQo+ID4gaXMgY2hlY2tlZCBhZ2FpbnN0IHRoZSBtYXhpbXVtIHZhbHVlIG9mDQo+ID4g
UENJMTFYMVhfUFRQX0lPX01BWF9DSEFOTkVMUyg4KS4NCj4gPiBUaGlzIHNlZW1zIGNvcnJlY3Qg
YW5kIGFsaWducyB3aXRoIHRoZSBQVFAgaW50ZXJydXB0IHN0YXR1cw0KPiA+IHJlZ2lzdGVyDQo+
ID4gKFBUUF9JTlRfU1RTKSBzcGVjaWZpY2F0aW9ucy4NCj4gPiANCj4gPiBIb3dldmVyLCBsYW43
NDN4X3B0cF9pb19ldmVudF9jbG9ja19nZXQoKSB3cml0ZXMgdG8gcHRwLT5leHR0c1tdDQo+ID4g
d2l0aA0KPiA+IG9ubHkgTEFONzQzWF9QVFBfTl9FWFRUUyg0KSBlbGVtZW50cywgdXNpbmcgY2hh
bm5lbCBhcyBhbiBpbmRleDoNCj4gPiANCj4gPiAgICAgbGFuNzQzeF9wdHBfaW9fZXZlbnRfY2xv
Y2tfZ2V0KC4uLiwgdTggY2hhbm5lbCwuLi4pDQo+ID4gICAgIHsNCj4gPiAgICAgICAgIC4uLg0K
PiA+ICAgICAgICAgLyogVXBkYXRlIExvY2FsIHRpbWVzdGFtcCAqLw0KPiA+ICAgICAgICAgZXh0
dHMgPSAmcHRwLT5leHR0c1tjaGFubmVsXTsNCj4gPiAgICAgICAgIGV4dHRzLT50cy50dl9zZWMg
PSBzZWM7DQo+ID4gICAgICAgICAuLi4NCj4gPiAgICAgfQ0KPiA+IA0KPiA+IFRvIGF2b2lkIGFu
IG91dC1vZi1ib3VuZHMgd3JpdGUgYW5kIHV0aWxpemUgYWxsIHRoZSBzdXBwb3J0ZWQgR1BJTw0K
PiA+IGlucHV0cywgc2V0IExBTjc0M1hfUFRQX05fRVhUVFMgdG8gOC4NCj4gPiANCj4gPiBEZXRl
Y3RlZCB1c2luZyB0aGUgc3RhdGljIGFuYWx5c2lzIHRvb2wgLSBTdmFjZS4NCj4gPiBGaXhlczog
NjA5NDJjMzk3YWY2ICgibmV0OiBsYW43NDN4OiBBZGQgc3VwcG9ydCBmb3IgUFRQLUlPIEV2ZW50
DQo+ID4gSW5wdXQgRXh0ZXJuYWwgVGltZXN0YW1wIChleHR0cykiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhleSBLb2RhbmV2IDxhbGVrc2VpLmtvZGFuZXZAYmVsbC1zdy5jb20+DQo+IA0KPiBA
UmVuZ2FyYWphbjogSSBzZWUgeW91IHN1Z2dlc3RlZCB0aGlzIGFwcHJvYWNoIG9uIFYxLCBidXQg
aXQgd291bGQgYmUNCj4gbmljZSB0byBoYXZlIGV4cGxpY2l0IGFjayBoZXJlIChvciBldmVuIGJl
dHRlciBpbiB0aGlzIGNhc2UgdGVzdGVkLQ0KPiBieSkNCg0KWWVzLCBJIGFncmVlIHdpdGggdGhl
IHJlY2VudCBjaGFuZ2UgbWFkZSBieSBBbGV4ZXkgdG8gc2V0DQpMQU43NDNYX1BUUF9OX0VYVFRT
IHRvIDguIEkgaGF2ZSB0ZXN0ZWQgdGhpcyBvbiBteSBlbmQgdXNpbmcgR1BJTw0KbnVtYmVycyBn
cmVhdGVyIHRoYW4gNCBhbmQgZGlkIG5vdCBlbmNvdW50ZXIgYW55IGlzc3Vlcy4gSSB3aWxsIGdv
DQphaGVhZCBhbmQgcHJvdmlkZSBteSBhY2tub3dsZWRnbWVudCBmb3IgQWxleGV5J3MgcGF0Y2gu
DQoNClRoYW5rcywNClJlbmdhcmFqYW4gUw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0K
PiANCg==

