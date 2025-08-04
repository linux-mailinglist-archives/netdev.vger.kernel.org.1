Return-Path: <netdev+bounces-211524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059BB19EEA
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C2189B370
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A622459E7;
	Mon,  4 Aug 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WSj7Br0o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939F23ABBD
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300501; cv=fail; b=XHCb2VuQP2mlGR1cgoeSSnmeZJxlgEodoPVA2e7ZC5prHNxrh1Ah5t8bIrPF2tE8ZOFb91Z+CqBd60rbGfUusyPUyO2HDNAjUDjhFWcxY8Nb7+1lI50uUOEnr8OGCkQdw5EIuOA03nHTOFA+PYLUsPXWbb2GJrziJ2J5E8UIDBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300501; c=relaxed/simple;
	bh=cZLvbWorCz32I8E2uZDaQa27IJ6lHSOarQAtrTSMuGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qneUPlrInQ03ZCVA/5bXzOUfW8qOYQoHoISmpAcyOmcJphou4E8z75I5z3/AmDbWjsMbcyIzZu7YlphodPPpXAVwl7LtIo9pr5p95dZPeL6BkhDUFw7JscghDypEzFAOpL13z0K9A0K3WY1SGARSkhHfXNvk4tfNucXhvCUnxC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WSj7Br0o; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrM0FKpkPlyoDLy6AYo0lnhnNyx1YalNIfw0DqSkt8gy+Kl8U0VfkGdqEaIsPmuIfXesZpuMPQam4+NWw26HxmnFpYj8oLaaQtDDjKlxYamMDVY2BW/CJKhCr2Z03F1fMK9o4ch+lLG6Ec8+V3ef4NYSNV5/w78fYLHTScw40MdOqrWZolcZRsUOlroRxmuehVudmgbuFS9nWikIxA5q+UovXGEPcfou3N1efkVWfTHNM9nud6Bjj9Z3Qdf8PgrQW1BRPK+Nh46L3lOtnzfyltFaHZVnkSDTbP+JhIS53SH+mQBMr5mV1sJklIoIv/2Bm5kD7+fOti93IeWgkGHnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZLvbWorCz32I8E2uZDaQa27IJ6lHSOarQAtrTSMuGk=;
 b=jf8YWM4PxdQfbmnf7y4zLIlFpPqfIp6/ZiPUYwEiS25GM16E51iL1/8ycmaSXBsjRvFgSWD2IYrc5tlJQDRbI41+A0AHUyUylwY4SbNcIHQjYnVwGnkruDEe+aweM5M6SLQZ0dO8DsZ1JD3vjaOO6Z5Arh6vdWezibNIdLzVkvfZYmvIGBz2GktRK2/Y2yxC2kLSG78JFLQ910lCvEEosyJSyftohDy2e2jRgdA1xlCnOoKqGaB7wRta1jcr/35fncrZhUWfZRPsH+oAHoG6Vtp3DOXkU7A9eta/ql+ERQIac94OD+HbjVzfKoDIJbYiPnZlSd7OC+yOdeFlpY41Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZLvbWorCz32I8E2uZDaQa27IJ6lHSOarQAtrTSMuGk=;
 b=WSj7Br0oAz7x4UNoZNtPznRtuA3vu+f8xEy9e2uzbIBBbgX0BXSYg3uX52s23aySjDW5cPkkLF6mlHFR8gs6SYT9f44/5P96YafTBOVh46XYpENd/ka4/P7mGhvRRdI/7glsgAQUETZrdFqgBYEwA/rqlOxn8axjl0R8LeFTMxV7zAxkd0PTJuZyJVBtCP2MWoFOAQtiZWTFB9Dg6MG/oEgTJl+os0Ye9F0S+1Nj2Lpm5F7DvIzUz5VoHqCFlsr/7NWY50LUUwoJIjbcgMMYwfmYjv56hZeqpIRRprUxEFGMaoK8suWUFAgF045FBUHDZ5ueLQszXGi5iNk0pc2YZA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DM6PR12MB4449.namprd12.prod.outlook.com
 (2603:10b6:5:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 09:41:37 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4%8]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 09:41:36 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>
CC: Leon Romanovsky <leonro@nvidia.com>, "razor@blackwall.org"
	<razor@blackwall.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec v2 2/3] xfrm: bring back device check in
 validate_xmit_xfrm
Thread-Topic: [PATCH ipsec v2 2/3] xfrm: bring back device check in
 validate_xmit_xfrm
Thread-Index: AQHcBSHmsI0+9Gj/PEaPbgUb7i5GZLRSPawA
Date: Mon, 4 Aug 2025 09:41:36 +0000
Message-ID: <e1244baffb21cdb109bb480ceaf535a5cc97f2b3.camel@nvidia.com>
References: <cover.1754297051.git.sd@queasysnail.net>
	 <692725ef1363566cb2fe8d0c928971271f5dd503.1754297051.git.sd@queasysnail.net>
In-Reply-To:
 <692725ef1363566cb2fe8d0c928971271f5dd503.1754297051.git.sd@queasysnail.net>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DM6PR12MB4449:EE_
x-ms-office365-filtering-correlation-id: 22cb46b6-3e6e-4c17-5ece-08ddd33b1b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGgwZGVGOUl6amNxTHZnKzl0aVhXSEoxazd5NFpSZ3V0S1M5VHpCVHNhbzhI?=
 =?utf-8?B?TXZiUEQrYmdMV1lKM2swWHBPV0FYeWJhRjNjS2paSTlTaXFjbTQvWExSd3BL?=
 =?utf-8?B?aTlQWEJJUzlad3lRZ2NzOEhQRDJZUXNZclhQeFBZMC9oZE5EdDQ1NGFkVkhx?=
 =?utf-8?B?TXlFMUFsYnRReXFEcllWRnJlTkVtSnpHTmV4NEJremlqYndVclROcmx3QU55?=
 =?utf-8?B?cnQzM0w2QmdOOVhDaVNDLzlBVzFnWksyMndPSGNzaDFFQ2VXZHNwdVJjaGtx?=
 =?utf-8?B?RFRQOTZya0gyMHdSQVd4d05taXlORVdyUEd2dlIvcnlUWEZGKzNLYi9FTDB6?=
 =?utf-8?B?OVJiVFlEOGdSaFVjSzBpVDlqZm54NXlLWUpScTdLekVBZHVYQ0w1Q2hVbVdt?=
 =?utf-8?B?K2RYK25KUmtHKzIvWnd3RXBGVUpvOEJJY1ZLbVhHb3BLZWpZZUZsQnE5MFZW?=
 =?utf-8?B?SGxEM08vQStVSHdYanVSZFhzcWFDY1ZHTGhDZlFjM3JsTXdwNU9YZW9QdWJW?=
 =?utf-8?B?TEFlVVI1ZEpXenBESU8veU1XNXU2a1oxaENtRzEzZ3NPRzVQQlM1M3hnT1JJ?=
 =?utf-8?B?QUlWVndsNDI1U2JLSE1qVUFqM0xvYTVlZmFMYlhQR2d2TVd4TXZRRkpsQzlv?=
 =?utf-8?B?QVl4WDBmMGE1THdqYUhSUld6UmcvQWJOODRoNUZFbVlSWU5aQTlKaFhkOEQ1?=
 =?utf-8?B?dU1yaDMrU3VVWmJQS3h4emlKNTM5SGVnb2h5cUZFWjVTTVNtTHN0OXVteFpz?=
 =?utf-8?B?SXNZbVZZYVRSRlIyaDZQY2lyN1h2MzExWmZDUElISWVpeEpQYThJMGRLSmpS?=
 =?utf-8?B?WXAzSk1ZSjhVSjJQdmE1bVgrZktyL3pxWWRoc3R4YjBsUzJ5UHFDTGdENGNy?=
 =?utf-8?B?ZHJ1bU1PdlR0OHc3cXVRWFAwTlVpRGRvTzdtcFJWVE5heG5vMVUzMEhJTkFr?=
 =?utf-8?B?djVNb2ZiZXFLZklOZVpDVVRBcEhLRzh5YUg0RGt2cmw0eThiSE5iM1hpSXVl?=
 =?utf-8?B?N2VlbXZIT3FPdHU1UEhGNXpTamlPclNvUHNnWFdtOUFhZWtOenM0Q1lDQTJX?=
 =?utf-8?B?cS9VNjU4b040UlZ3dzhSSmdBUysza0xhbm0rbWtYNnNrVDVVaURaV21acVE5?=
 =?utf-8?B?Nmp1bDEySVMxMUp5ZDl6YU5EWWRpV3N4VHBldnlhV0ZYaUtMMFNXRTdkbTNJ?=
 =?utf-8?B?N3dLLzFYRW45ZjlxSFQyNnlXb21yL3NtUFI3VmcyQno5KzQxKzNSU0dHdzVu?=
 =?utf-8?B?cWY5enJJQllNYzhYOVFVY2twbTYvYWVxSEdKbzNpT3pmSENkSlY5WDNZcUJ3?=
 =?utf-8?B?cEd6TzZJSXRvV0hSbzdkYU1CZE5FSjZac294OVBoVjArOGZiMVNlYnZjdFRW?=
 =?utf-8?B?TGNiOEFwbjNHdmwxdFhuaE1PdTE1WFJWd080WDhUd0xSTE11WDRQTU1SNkkw?=
 =?utf-8?B?cW1acjRxVTlFejFEUXM4MzVubFRhR3RGd0NnWC9kb2xiTWF2WEFic0dCSHpI?=
 =?utf-8?B?TGJaeCtGdExuc1lZelRLeEJ0VWo4b0FDVStxV05IUE9JN3ovMHZvaTRHNDUr?=
 =?utf-8?B?WnV4L0JyRU93S0R1UUU5cXhVeFRaQis3QUo5RE1TVkJ6NEVXQmFDMm1MeWRm?=
 =?utf-8?B?ZHQ5VGJRYk55eE05d1owS3ZkZWhlcDNZZkZiNXJVWCtic1hHT3JJdGMrdEd2?=
 =?utf-8?B?aWFlYitQcmxCSXNKOWVpM00yOTZyY3poY0c0YzhlZ09Uc2xEWmpwcXVXaWtW?=
 =?utf-8?B?aWhkZU1ERiswNVppMnEybDc3cENjZjh6N2pNTXRqb0d6QlliRWRlbCsyN0hQ?=
 =?utf-8?B?QW5rL25iL1loNmZuZ3RlQlhBM1BZSy82MFVwa0J0aEFNZUcyNFpvd0tKTzBl?=
 =?utf-8?B?U3FHVWIyVEhHN2lIeXU1S2QzMUNhbmw4VDIvcndweGtqeE9FUE5OMExiUnpG?=
 =?utf-8?B?T0YxMmVXa2xIZDJNU2FHQjErdXZORU9mbU5GTDRYeVBaM216TVJQVHNHekRi?=
 =?utf-8?B?SWQyaDFZaGNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXBFUlpyNU5tbVc2NzQ4TXJGMjlSZWJXQ0lOaXRJbHNEb3pNK2d6N0tnK0ti?=
 =?utf-8?B?RFZodGQ4NGZFVE1INHpyck5CZW9QNlc4RDlRR0dBL2N3b285dVlmYVRYczdr?=
 =?utf-8?B?OCtYOW9vdWZneXlJTlMrUS9Uc1p0M0tMQmxYQnJJcEJnU2xtbURta0FwcC9Z?=
 =?utf-8?B?allocUFnWktacXBRNkxlcFAyK3NSRFVCZGljdDEwdTExMFR3Q1JINDFjQVE1?=
 =?utf-8?B?TWZiSzZkT1FnT0hkSEk2dzF5THBwVnhEbEFqVEJLZkJVVlFsR2IxbExkV0RQ?=
 =?utf-8?B?U1JFVmNack5pd1V3Z3VuaHJxQ1hVWXlDTE5oQ2dvRlMwMTRZQkI2c0RzaXBT?=
 =?utf-8?B?M0pZd2xRdWtJajFsV1d1SUJwNHFqajJlQU1PbXBmdkZ1cUNSN2FmRStlOWhI?=
 =?utf-8?B?RGVPblRuVmNmSDhyZi9ndlZOTjFwUXNRcEh1N2dhMlRacjFiZlg3bWU5TEpn?=
 =?utf-8?B?T2lVVDNMd1NxOUszTndEVUJOZlVERDl1N2JRWmtnVGNuQ2NIekdsMUo5WW9i?=
 =?utf-8?B?UjloYVBLOXg0Zy9PbCtFVE96RkJ4MVNrQ2ZJLzdnM1BBS0R0TGEwV1FMSVRt?=
 =?utf-8?B?aUUzZG9tb3RrTWNaZzQ1b0RITEZVY2t2QkU2c1VsMllVTWpGVnIvcWJ6a2hF?=
 =?utf-8?B?bllKT1RzVFdzYUxQdkl0cGFzTGhURGRKNm1HS0lDT1IyeUxnMHVKd3psUlBX?=
 =?utf-8?B?bU1hNFQ2NDEvRVFlblMrRkM1VEtYLzQrUVcyVkFEVUFnelErVDZyMFZsbUd2?=
 =?utf-8?B?MjJvclFFUEY1TVMvVUZnY3htclFNVlQwcGxoblhlbmFFcmJjTHJnK3c1NnJi?=
 =?utf-8?B?WnRLMkJ6KzhUOEEyVjBGSzZieG1CKzhxdXlCMERCYlNpZ0prS3RUdEZVWlBy?=
 =?utf-8?B?MVRYNzhINUl6azBMQkxEekpNcnh0dy9YclE3RXdtVlBVaWQ0Q1Yvckl2YmhG?=
 =?utf-8?B?U3dYTGxUaEN6UzM2Z3BNN3RvMjNmZHV4QnBIMjBtOGVCOGNCSENaNThJYktx?=
 =?utf-8?B?bW9uTVJiUURiNHYrV2tkaVloTWlxSHdFekJSdm5GZitqT3pPcmN6cUFEdThP?=
 =?utf-8?B?d1E1LzNobHFPNE56Ris4eHVQLzBCeTh3aU1pRmdWTDRPZEJlWUFPYjJ0V0JK?=
 =?utf-8?B?cE5LUjRnSmpDTGpDZVU2d29BUDNTbmQ0M0IwZnhHcG1rRDZ1ajM2QjE0NFNl?=
 =?utf-8?B?dDY4TWVRclQ0dTQ1L01tZzlwcHQ4V09Qd2xkbXlaUXRzT1Fta2hsOVQ4TmZ6?=
 =?utf-8?B?a211dmRPdHZ5Q3J0WjdWb1RoQXJ0b05HZGlQakQwYlpiYkFHU25pVHNjZTBQ?=
 =?utf-8?B?U3ZFajN3UmJCdHpnUWRaR1NjODF0YnFvTVBiYVBsM1VUalIvYkwybjUweDNt?=
 =?utf-8?B?UVdCMkNEL0k5R0E1ZFpIbUluRjJYZ0I4SFA0RDcrMUg3dkcrWHJpY0M3dTZ5?=
 =?utf-8?B?S0NZc2MvMndZZk93K3RIbFNmVGJuTEVWQnR1MWJpZFNjYVJaQnhzc3R0MHNQ?=
 =?utf-8?B?K05Qai95YlFOQXBSckM5Q0F3MUY3UUtRVDhOdlFIejJ5UE9nME9FalMrT2k3?=
 =?utf-8?B?NjIzaDVvYlQwbFdPS21yYk11Y0NhM29sUFlhSzFVemV5TnRCdElMTUJrSW4z?=
 =?utf-8?B?YS9nQVhuNk9KKzd5YVNscnpyVVhsUFZwdXVaL0tHZG1KYU93cGlXNzZUTGVz?=
 =?utf-8?B?K0FBOSt0NDlHNnVIQWpIb2pLenBQOHFGSTJHcEh0ZXJzNHlTOW8zdmhBV1Yy?=
 =?utf-8?B?VWVxeTZzWXE2c3lGVHJsdksyN24yZ004ZGpUVmVITFpQYVU0MVc0UExyOG1Y?=
 =?utf-8?B?L2VKd1lnL05NbStzRFpBWlhEZENxQVlxbXhWazU4b1lRbGtMdWdMTkNVcDRL?=
 =?utf-8?B?Mi9YVjV5NnFTMXhQR2tTdEFmeUUxYVUwSGg4N2RVc1FDWWczcFcrRkNPVjhl?=
 =?utf-8?B?ZEJpRXlJWjlROWloaUcwTnFBWTEyTmF4ZEliY2tBTFpaU0FPS3hWTFlwZUJP?=
 =?utf-8?B?SStJZy9kSmNXSGhIYXFQdStiYldWdHlCK3JwRFcwYjZJTVhTMzhMd0xJVkoz?=
 =?utf-8?B?R2hLMW1mQjNuMi9FSjA2TVAyQmhpYThLTExZaGtrRVAxR0pPcjdUWlhEL3Jx?=
 =?utf-8?Q?tan9xdTiAfKbWUcB9eQbQt8Vt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2958564D7B456D4BBA750FF1A5437A43@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cb46b6-3e6e-4c17-5ece-08ddd33b1b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 09:41:36.9399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yknosX997tmgZ/s6UJCkdkHRg/b99epK0k80tw4qqbg8ws19z1h7l/DZo66Uy9Tlhe05XDNiqfXzXUnxt3MZtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

T24gTW9uLCAyMDI1LTA4LTA0IGF0IDExOjI2ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IFRoaXMgaXMgcGFydGlhbCByZXZlcnQgb2YgY29tbWl0DQo+IGQ1M2RkYTI5MWJiZDk5M2Ey
OWI4NGQzNThkMjgyMDc2ZTNkMDE1MDYuDQo+IA0KPiBUaGlzIGNoYW5nZSBjYXVzZXMgdHJhZmZp
YyB1c2luZyBHU08gd2l0aCBTVyBjcnlwdG8gcnVubmluZyB0aHJvdWdoIGENCj4gTklDIGNhcGFi
bGUgb2YgSFcgb2ZmbG9hZCB0byBubyBsb25nZXIgZ2V0IHNlZ21lbnRlZCBkdXJpbmcNCj4gdmFs
aWRhdGVfeG1pdF94ZnJtLCBhbmQgaXMgdW5yZWxhdGVkIHRvIHRoZSBib25kaW5nIHVzZSBjYXNl
DQo+IG1lbnRpb25lZA0KPiBpbiB0aGUgY29tbWl0Lg0KPiANCj4gRml4ZXM6IGQ1M2RkYTI5MWJi
ZCAoInhmcm06IFJlbW92ZSB1bm5lZWRlZCBkZXZpY2UgY2hlY2sgZnJvbQ0KPiB2YWxpZGF0ZV94
bWl0X3hmcm0iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTYWJyaW5hIER1YnJvY2EgPHNkQHF1ZWFzeXNu
YWlsLm5ldD4NCj4gLS0tDQo+IHYyOiBvbmx5IHJldmVydCB0aGUgdW53YW50ZWQgY2hhbmdlcw0K
PiANCj4gwqBuZXQveGZybS94ZnJtX2RldmljZS5jIHwgMyArKy0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0
L3hmcm0veGZybV9kZXZpY2UuYyBiL25ldC94ZnJtL3hmcm1fZGV2aWNlLmMNCj4gaW5kZXggMWY4
ODQ3MmFhYWMwLi5jN2ExZjA4MGQyZGUgMTAwNjQ0DQo+IC0tLSBhL25ldC94ZnJtL3hmcm1fZGV2
aWNlLmMNCj4gKysrIGIvbmV0L3hmcm0veGZybV9kZXZpY2UuYw0KPiBAQCAtMTU1LDcgKzE1NSw4
IEBAIHN0cnVjdCBza19idWZmICp2YWxpZGF0ZV94bWl0X3hmcm0oc3RydWN0IHNrX2J1ZmYNCj4g
KnNrYiwgbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyDQo+IMKgCQlyZXR1cm4gc2tiOw0KPiDCoAl9
DQo+IMKgDQo+IC0JaWYgKHNrYl9pc19nc28oc2tiKSAmJg0KPiB1bmxpa2VseSh4bWl0X3hmcm1f
Y2hlY2tfb3ZlcmZsb3coc2tiKSkpIHsNCj4gKwlpZiAoc2tiX2lzX2dzbyhza2IpICYmICh1bmxp
a2VseSh4LT54c28uZGV2ICE9IGRldikgfHwNCj4gKwkJCQl1bmxpa2VseSh4bWl0X3hmcm1fY2hl
Y2tfb3ZlcmZsb3coc2sNCj4gYikpKSkgew0KPiDCoAkJc3RydWN0IHNrX2J1ZmYgKnNlZ3M7DQo+
IMKgDQo+IMKgCQkvKiBQYWNrZXQgZ290IHJlcm91dGVkLCBmaXh1cCBmZWF0dXJlcyBhbmQgc2Vn
bWVudA0KPiBpdC4gKi8NCg0KVGhhbmtzIQ0KUmV2aWV3ZWQtYnk6IENvc21pbiBSYXRpdSA8Y3Jh
dGl1QG52aWRpYS5jb20+DQo=

