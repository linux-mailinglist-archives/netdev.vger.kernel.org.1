Return-Path: <netdev+bounces-153974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726589FA762
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1407A177C
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F019006B;
	Sun, 22 Dec 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKzECzdg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0C18F2CF
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734889197; cv=fail; b=FkK41o5sMaxL6t/yh+znfacTsPVEIbA/8Cy1ZWb1nUjH5bLVj72tw/7MLg/tOgnvWsRH+0y80KvCBlAAlWlBMUS6ChDJBs0Kr5q3ZRsDHcERCILbPn3ox8QI5vrtBj1ikPHA3tV8ETByjeYZdsuqd0MCY2Q4gQTMsGU4W62CevI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734889197; c=relaxed/simple;
	bh=fkqHQhslVff8eo6B7wxdyCK8lQuBfD/1iMk5ilGUt2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSRvqWFMC9L/e1GFyvV4hVF/lHFfiKSaezD2Z0nPn9RrpSFLh8Be52zTnANLHMrYv9bXroLx5K7beZqriA1I+DoHwr7XIiJjishzAd8Qp9fy3txpQn7x0f2r4x7VvRc+ctZV3aCOaxHz5z6kqfWycq0mZpk8mCepBtZcEw1tiOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKzECzdg; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBY65Do17qaLISMMNHelkawux6lTiMoo4XlyqgRKuLTn9L0aFQ69kOzampcK9jlptGXGNHQsRN9scEZKjkVmX5LFUwRuiY44NzfbssOEsd3SN4oTK46hJqE0pQBDjcfF9GVxW8vEKy/Si5nMz4edj+wECs27qjE79BP63jFG82ghAla/w5NVECkNzcpHQcdsY9dsTrKEG/uFlUEap15+OVC3q0JT585YX2qPSbeMesOj9hN2MVPESSZ/iGMBFUFfYq+o6nms9w5sHEy6VyzEtOv2JDNHP537xLcQp1Ot2RLmC8VGrbzoaQUtKF3GP+5SDYmQpewBlXEHIDJAP7o8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkqHQhslVff8eo6B7wxdyCK8lQuBfD/1iMk5ilGUt2Y=;
 b=S/H/1KQrfOdD0Lo4q6eheg21ctivMFXVjsA3/2f/lljv+Qkn7M+XHwXdi5mJU1iHKz30Tn+Pz9GLybHwN3EatFYdKfjEEnzsqSdmE8DhiSy5WbOcCIPcsAjZfvDJ2HbYeGBi05jyuK0ZoU1AlggGFLGlx37KCKutPMokdEOoc51reyMmbGj9wO0isH39jLnmuPH8VdJHMMoHJGn9Gh4iBU4KgvE91ekM2MeDIRwiLg288/vXrFa7TQvZ9IZnS3p13gRXG8Q8utjSwpDNuYyWEA35ubzTv95DG/z+ITQhQxSf3bSlNEL9V5k1aoD+ejtcqhgmO+BGLWlnXhOMEBDVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkqHQhslVff8eo6B7wxdyCK8lQuBfD/1iMk5ilGUt2Y=;
 b=nKzECzdgRsNspe3w+UNdGQj30tBtn1b00qTiats430NWSCFRMGAaNtaGWKIJYNYofhbStQ3LpSq/j5rdj7LCsCickLOXFyX8KIwHbWkCywZ+VFGcAe932W9HQ6Xlr7VMdJS01sdfd5sZAZ4W0oyON1RjCATNkH3Qa8URYP2A+D0PXdoNNi64G7Paj+si4c5AvbX5dvoE2Ol3Tay3FL78ysXefAQLRkTC0vdUdktrLgUzrgVW8WDP6cFJyb4GC6b+JScs35h/B5STKMLRJ2LfLmltiFzgc2BMQYuQc3drP65okEL4S19zHqUwNxaFGvxBya26nvZhLq0WWKjIRxhA7g==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Sun, 22 Dec
 2024 17:39:49 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 17:39:49 +0000
From: Yong Wang <yongwang@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
	<roopa@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andy Roulin <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nithya
 Miyar <nmiyar@nvidia.com>
Subject: Re: [PATCH net-next 0/2] bridge: multicast: per vlan query
 improvement when port or vlan state changes
Thread-Topic: [PATCH net-next 0/2] bridge: multicast: per vlan query
 improvement when port or vlan state changes
Thread-Index: AQHbUyteLJLW1aDZhUOz22kdwSzKvLLyBs+A///9uwA=
Date: Sun, 22 Dec 2024 17:39:49 +0000
Message-ID: <BD307113-28ED-4A55-A2E7-48F85318772E@nvidia.com>
References: <20241220220604.1430728-1-yongwang@nvidia.com>
 <41ac7bde-9760-44db-9287-dfcc986657c6@blackwall.org>
In-Reply-To: <41ac7bde-9760-44db-9287-dfcc986657c6@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|CY8PR12MB7732:EE_
x-ms-office365-filtering-correlation-id: 6f51cc77-615e-4d9e-b3c8-08dd22afa21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnZZTWM3VW5LOWxDSCtxMmw1MlVITTJaK3A0bkJlKzVzWEwrbzFOdmFITldN?=
 =?utf-8?B?Zm1sRVZDdjVtMGJlOUh4TkRxTkxmZGhLejdyT3E0emwrZW9NNmxjcmRRQ01k?=
 =?utf-8?B?M1dtWFMrNTRpUlBmMUphUGhQb25QZUZXam5OMHN2dTExUzRLYlNhYkkxVjly?=
 =?utf-8?B?em5uRXVQNUxNNm5vWWRsRWk4emRRNG5oQmkydDFsZXptY0R6bnRwTld5V3k1?=
 =?utf-8?B?TlRyZEdVNnpjV1dUOUplanMrekpqbXBtOWJyMVdWTlRURjNlTDd4clBmc3d0?=
 =?utf-8?B?MS9zb0l0cTdxbTc0ckxmLzgxdHhldmpHZnBDcWlJN1dUY2pYOGM4bU5Fanc2?=
 =?utf-8?B?NE1qRWg4aGV4M2Z6alhtbTdLTVlzQy9UOFB6RFdUWFN4N1pFSmNLNXdvV1FB?=
 =?utf-8?B?Q1JlQ29HTGd0cTVxeTlBWkNyUldFWVdYOUpoRGUvcWI5cGlBNEZmQW9Dc21y?=
 =?utf-8?B?WURJd3N6OVZoZWxwTEtHOU9ad0o4YWN4bFRHU1cvTTh1VWYyWStQWldWYkRD?=
 =?utf-8?B?OUtaMWNEakRDMWZuUXQxN01zWDJhNVZBQ2JmVUc4WmpURkd4TE9lRUlTYTI3?=
 =?utf-8?B?VFpqbjJjckxPRDByUndLbXlueS91UEFld25Eb1p5aG1xK3YxY0lHQ3RlTzB4?=
 =?utf-8?B?cFFuNjhhTk5MWUlMdWU5ai9UQ29jdUdldzRmZVhtelRHdXBPMWtpT3o2aGpW?=
 =?utf-8?B?VzJtVTZ2QTV1Njg0cTlLTFZlVmVaSGIvOXo1Mlhwc0xkSHdrWXY2UUZXOVpZ?=
 =?utf-8?B?MUtPdktPanA4UlM1MjRQazg5MVRFS1hZL3VEQ1hBRkpKNnZ1SWxzNXFXN3lk?=
 =?utf-8?B?L0lsYkpwUVd1QkF1eGtiNHJpSWh2cFhmZEdCbUpIOFZmbTEzTWhiRzZOQW43?=
 =?utf-8?B?UmpRSnByVGZkMm9GTnRCUjBmTkk3OHRPcGdzMHJoWFFwUXpYWi9WTmpQcjhq?=
 =?utf-8?B?Y2Z0TzJaeCt0bUFmaDBtUkR2R3oxY1BuWUQ3d3krSVJYeVcyY2IzdVgzK1BI?=
 =?utf-8?B?S3ZtL1ZtRU9YSmI0ZFVwbm5LQTlqR24xbmVtNjRJWUJoRGJ3dEU2SUMyeklE?=
 =?utf-8?B?MXVMY1d3T3lzYnQzWnNWekNWNTBBZXJCYU05ZnROT3BJWTI5RkcwSGlFL1Vp?=
 =?utf-8?B?VU4wUVJ4N3JYWnYvOG4rS2gvb3lzSEMrcWZoMUdqc2tFVTZtdC9YSWx1RkRx?=
 =?utf-8?B?aVhuNzNWbkgvNW5MRm1IcjFZcER1dkpPUlFXRFlCSUhLVTdTMldXYzFhWmh4?=
 =?utf-8?B?WFZaUTNtTUpaRTVCUnp5ajN0NWxxc2lnd2JMa0dkdTVtMElXTWdGNm9ZYi9Y?=
 =?utf-8?B?TS8zQ1JCdW9PeFEyaURDZXhweThBeVI1aGg3ZjN0Mmh5cUJZSUs0bjM4WGdI?=
 =?utf-8?B?TXBaZ2VEOEVCTFI2NkdXa3NHT2J3NHpMT2dWR1doNU9nRy9kSHNJQ3ROUFdF?=
 =?utf-8?B?OURVVWhOb1U4eUZCVFZKYmtMUUtuTTNDejJEQ1VjU0VJUmVmY3ExTkJXdXFS?=
 =?utf-8?B?aFRFc3V2SE1LVjQrUmozY0RBTGQyT3pKVjRQNzJWVGZLaGZzaDlXSUFGcTRR?=
 =?utf-8?B?akhjSHhoVkRIRldJYWo5bUl3K1gyZmp6MzJsbkdIVXlUMlMvdmhPYVZtTUF0?=
 =?utf-8?B?VGhQYlBmTFlzcHFiZVdTNDh2MU1sOFZIbFZjc3FocXlHcEU2VlJuc1hWMThj?=
 =?utf-8?B?V3ZjQUE4cWh2MTEweWQrL0ZPMi8ybUpMQVAxTDJ1UmUzbW5LWEJkUjlOWVFI?=
 =?utf-8?B?VmwzY0thYVpKeWtQQUIzSjVtR3ByV28wak5COS93ak0wenE2NUJrVGlHZyth?=
 =?utf-8?B?cTBUUHpleFFBcE8yeXBWaDN5ZmxXSXRSRXJoL25udGJiQXNCQU45d25vMkt6?=
 =?utf-8?B?MjVoSGk1Y1Q1dFhmSnNpQTc0cWtoM3ZJTEJUYmNHOUlJUlc4NFBibFJUUGwv?=
 =?utf-8?Q?kS0LZO762Al7YJq1vEP8eli0SlkTvtI9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFdpZGdMU3VIUmNZcEdxelJhTjdzZ1RkNnRKRHhHckZSL0xER3lzWVlIZlRp?=
 =?utf-8?B?RG9ETlpUTjA3MENRTy9teUR2VXgvaW9LcHNaQmkxU0hHRjYxWHpzOGE4czNB?=
 =?utf-8?B?WjVyOTc4WUk4Q01OTTlEazFSZ0ErNTY3QXNFNFA0bU5vekJQcGVUb2t6Q2Zm?=
 =?utf-8?B?U3NxVVp4MGZoaE5MZk5kSk01ekVUM3JGVzZ6ekRMVVZUTUpQNDQ2Q3FSeEti?=
 =?utf-8?B?aUNGaTFpTDdwdVQveFhtVHpCeVlXc3BxOCt4UWp1eGZCQUtqWkJ4akhtRWhz?=
 =?utf-8?B?ZHVmcHhic04zN2dNY2RJeHR5d0ErT0ZXbDhxdzI1aWswdmtmU2JOY1k4MnZa?=
 =?utf-8?B?MFA0R3RsZ0RhVTg5MFI5L3p6Rm5xSzhKZnlCWG12ci90NktjTnUrTjY0SGph?=
 =?utf-8?B?SFZHTG9LMWE2L0d6ekM0bktPZmhXTDExaTYweHNSM3Nxc0xzQTIzV0FpK0RR?=
 =?utf-8?B?dTNZaC85U05Camo2UmVTQkl1ak5EMmpXbjNuR2l2MzNjSWdBSEZncHRxRWZn?=
 =?utf-8?B?bEhWQnVTSUVLT1l6UFhrR1FBOE01OU1FZTZiWGdXenlCSitaWXFkVi9jamlo?=
 =?utf-8?B?ekgvS0c4TkNjbDRoakN3UjhJLzJSdUtRTDFWVGlEd0FEeElCTU5jWSs0dHVj?=
 =?utf-8?B?UjdFbXhxWmdDU3IzSkx6WDR4b2RaY1JFZ2xNVjlndFlvWHljaDU4NTFkNWNv?=
 =?utf-8?B?MVczTTBTd0xidjY4eC9JMlNTbE44YzVOanJNUkZ2dzhOcmNUL21KZFlSQWFJ?=
 =?utf-8?B?ZnJmTS9tbTVFM2xOSS9CNnJlR000Zkphd2pNU0JNaUcyaU1jWlRQWDBFWStk?=
 =?utf-8?B?M2xDN3FCeUNWSlNMRERmNnRDNWJBQy96RWdvTG5KL012dHNIUHBMT1I3SzlQ?=
 =?utf-8?B?R2Y3Q1FEbUFYR3BESllDa3BiRzZKUXJicVBnOENZOGR1MUxzNVVReTEzMmJV?=
 =?utf-8?B?KzVvd1o1NXBUaVRwNDRtKzNUazNnY1B6ZHlVOFVYK2NIS0dXalUzTUlMSjRS?=
 =?utf-8?B?djNHL0FyYWJXSllMLzJsazQ0OXhkODNXN3hoQnNydS9hUGJnaUtSeDBKY2hj?=
 =?utf-8?B?MnUrS1pPQ2R1VWZCckZyaUVpWTUrRDZkeEJKVjJmM1MrL2V4cTNVQ1BieHox?=
 =?utf-8?B?eFhPOGFnY1p3bGJENnR4NlB5KzFnTEtXOTdyWWFvUXdNRU1DakZKWTN0TDFN?=
 =?utf-8?B?WktWTng3R2hyMmgyMlpQTHI0ZldNRzRsZkxHZnhBMHM0Y3Z6TTkxZVhJWmZ1?=
 =?utf-8?B?eHZGYlRncXI3VXF6cEw2YUJzcHRlUjZwSU9RTTl2WE9SNHpkUXNlOTJmWUNY?=
 =?utf-8?B?elVMem1YcDVobU9tZk5LWFZRWG5qYjhaSjJvUUt0OUkvczNFRTQ2MkplZnJ3?=
 =?utf-8?B?cGhya3I2UHVHcGRSTFNyMGhGVVlvRjRFQnRJejdaeUxSd28xZS9zVU1XZFps?=
 =?utf-8?B?azNhelQybUg2UkRoMjdLTStxRHRMQzBnYXdrcHRLaENyVDNwUWpRdDE1dTE0?=
 =?utf-8?B?QmJBK2F4MWduZUxlUjhXa3N1d1Z3SUxxcDNDZVptVDJjczJYL1UwK0hoSlgy?=
 =?utf-8?B?QUZCdlVudGpyUC9nZW53VCtUMkswVmhpNVRCeXpqSFp2N3FndmprWXlXaFhT?=
 =?utf-8?B?SWI5Y1hIeW0vUmowYW82UXIxUnVEVSs0VEt1aC9VQWxXTDh1dkg3Uldhekh4?=
 =?utf-8?B?dUpmcUNTQnl3ZjhwTHNXZkYyejNXQjM3R290aSt1Vjd0OXk0bHhrWnlpclEy?=
 =?utf-8?B?cUFzNDkrL0g1L0JTdXdTS1dDVjNVc3V6VzlLNnFhMEVGOHczcUFBdGlYWXNt?=
 =?utf-8?B?dWI3a2hBRjRFVlRlREk0bHkxeEcxYU9aZS9kWWkrY01ROFNJVm84S3NZR2JD?=
 =?utf-8?B?UnNDS0RGUXNNcHJzbG1DWXJhc1Fza2hYQVdBeXdUWTkvSUhhK3RDU0RDUHNl?=
 =?utf-8?B?aUgzeCtmYUZkRW4zKzg5Uk9TaHhUNkhwOTdjZmlLY2grbWs3S0luejhCOUs2?=
 =?utf-8?B?Qi9rbzF6akN0NE5TdnpEeHV0VDNVOTBrY29Ic1BBQnJ1M1dsaTBycmZLWHow?=
 =?utf-8?B?RklBQ3BDT0JJNFVLb1BUUWdNQUhQaHZyMEYzYUlsNkRKZGpHOENKVEl1a1l1?=
 =?utf-8?B?MjdOWm5yWFkzMTVoVGhOZC9jY3FtbXR6K0dhRlJlL2pLVC9LTUZYUmtlK0Vu?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2103D94966C652478965A30F37C380A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f51cc77-615e-4d9e-b3c8-08dd22afa21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2024 17:39:49.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwtNBzW7w2wu1dru3grHVf2UFFw5zIMOIgZiF//8nWshSyl6tZXO0AVwYvmxSGDOkteaFqgwpYzf+sETKijBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

DQpPbiAxMi8yMi8yNCwgMTo0OCBBTSwgIk5pa29sYXkgQWxla3NhbmRyb3YiIDxyYXpvckBibGFj
a3dhbGwub3JnIDxtYWlsdG86cmF6b3JAYmxhY2t3YWxsLm9yZz4+IHdyb3RlOg0KDQoNCj5PbiAx
Mi8yMS8yNCAwMDowNiwgWW9uZyBXYW5nIHdyb3RlOg0KPj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50
YXRpb24gb2YgYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0KCkgb25seSBvcGVyYXRlcyBvbg0KPj4g
cG9ydCdzIG11bHRpY2FzdCBjb250ZXh0LCB3aGljaCBkb2Vzbid0IHRha2UgaW50byBhY2NvdW50
IGluIGNhc2Ugb2Ygdmxhbg0KPj4gc25vb3BpbmcsIG9uZSBkb3duc2lkZSBpcyB0aGUgcG9ydCdz
IGlnbXAgcXVlcnkgdGltZXIgd2lsbCBOT1QgcmVzdW1lIHdoZW4NCj4+IHBvcnQgc3RhdGUgZ2V0
cyBjaGFuZ2VkIGZyb20gQlJfU1RBVEVfQkxPQ0tJTkcgdG8gQlJfU1RBVEVfRk9SV0FSRElORyBl
dGMuDQo+Pg0KPj4gU3VjaCBjb2RlIGZsb3cgd2lsbCBicmllZmx5IGxvb2sgbGlrZToNCj4+IDEu
dmxhbiBzbm9vcGluZw0KPj4gICAtLT4gYnJfbXVsdGljYXN0X3BvcnRfcXVlcnlfZXhwaXJlZCB3
aXRoIHBlciB2bGFuIHBvcnRfbWNhc3RfY3R4DQo+PiAgIC0tPiBwb3J0IGluIEJSX1NUQVRFX0JM
T0NLSU5HIHN0YXRlIC0tPiB0aGVuIG9uZS1zaG90IHRpbWVyIGRpc2NvbnRpbnVlZA0KPj4NCj4+
IFRoZSBwb3J0IHN0YXRlIGNvdWxkIGJlIGNoYW5nZWQgYnkgU1RQIGRhZW1vbiBvciBrZXJuZWwg
U1RQLCB0YWtpbmcgbXN0cGQNCj4+IGFzIGV4YW1wbGU6DQo+Pg0KPj4gMi5tc3RwZCAtLT4gbmV0
bGlua19zZW5kbXNnIC0tPiBicl9zZXRsaW5rIC0tPiBicl9zZXRfcG9ydF9zdGF0ZSB3aXRoIG5v
bg0KPj4gICBibG9ja2luZyBzdGF0ZXMsIGkuZS4gQlJfU1RBVEVfTEVBUk5JTkcgb3IgQlJfU1RB
VEVfRk9SV0FSRElORw0KPj4gICAtLT4gYnJfcG9ydF9zdGF0ZV9zZWxlY3Rpb24gLS0+IGJyX211
bHRpY2FzdF9lbmFibGVfcG9ydA0KPj4gICAtLT4gZW5hYmxlIG11bHRpY2FzdCB3aXRoIHBvcnQn
cyBtdWx0aWNhc3RfY3R4DQo+Pg0KPj4gSGVyZSBmb3IgcGVyIHZsYW4gcXVlcnksIHRoZSBwb3J0
X21jYXN0X2N0eCBvZiBlYWNoIHZsYW4gc2hvdWxkIGJlIHVzZWQNCj4+IGluc3RlYWQgb2YgcG9y
dCdzIG11bHRpY2FzdF9jdHguIFRoZSBmaXJzdCBwYXRjaCBjb3JyZWN0cyBzdWNoIGJlaGF2aW9y
Lg0KPj4NCj4+IFNpbWlsYXJseSwgdmxhbiBzdGF0ZSBjb3VsZCBhbHNvIGltcGFjdCBtdWx0aWNh
c3QgYmVoYXZpb3IsIHRoZSAybmQgcGF0Y2gNCj4+IGFkZHMgZnVuY3Rpb24gdG8gdXBkYXRlIHRo
ZSBjb3JyZXNwb25kaW5nIG11bHRpY2FzdCBjb250ZXh0IHdoZW4gdmxhbiBzdGF0ZQ0KPj4gY2hh
bmdlcy4NCj4+DQo+Pg0KPj4gWW9uZyBXYW5nICgyKToNCj4+ICAgbmV0OiBicmlkZ2U6IG11bHRp
Y2FzdDogcmUtaW1wbGVtZW50IHBvcnQgbXVsdGljYXN0IGVuYWJsZS9kaXNhYmxlDQo+PiAgICAg
ZnVuY3Rpb25zDQo+PiAgIG5ldDogYnJpZGdlOiBtdWx0aWNhc3Q6IHVwZGF0ZSBtdWx0aWNhc3Qg
Y29udGV4IHdoZW4gdmxhbiBzdGF0ZSBnZXRzDQo+PiAgICAgY2hhbmdlZA0KPj4NCj4+ICBuZXQv
YnJpZGdlL2JyX21zdC5jICAgICAgIHwgIDQgKy0NCj4+ICBuZXQvYnJpZGdlL2JyX211bHRpY2Fz
dC5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+PiAgbmV0
L2JyaWRnZS9icl9wcml2YXRlLmggICB8IDEwICsrKy0NCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDk5
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4NCj4+DQo+DQo+SGksDQo+SXQgc2Vl
bXMgdGhlcmUgd2lsbCBiZSBhbm90aGVyIHZlcnNpb24gKHNlZSBrZXJuZWwgcm9ib3QpLCBjYW4g
eW91DQo+cGxlYXNlIGFkZCBzZWxmdGVzdHMgdGhhdCB2ZXJpZnkgdGhlIG5ldyBhbmQgb2xkIGJl
aGF2aW91cj8NCj4NCj5UaGFua3MsDQo+TmlrDQoNClNvdW5kcyBnb29kLCB3ZSBjYW4gd29yayBv
biBzZWxmdGVzdHMsIHdpbGwgcHJvYmFibHkgZm9sbG93IHVwIGFmdGVyDQpuZXh0IHdlZWsuIEhh
cHB5IGhvbGlkYXlzIQ0KDQpUaGFua3MsDQpZb25nDQoNCg0KDQo=

