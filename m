Return-Path: <netdev+bounces-135020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A945899BDD1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 04:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B55E1F2268A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 02:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00E3E499;
	Mon, 14 Oct 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="B8k07iLB"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099253D97A;
	Mon, 14 Oct 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873541; cv=fail; b=kfgISw3K/V4OsaJbIwnBPKjAMyaNH5+ZjLgYzn4NAppRJ1xSjg7BjUmeqHxwPcF6LEW8CUEkb/d8ZHQbOMnN+DEq1h5e9IDqidwDjSc/ZFultmvaWbYamK2PXE/UaQNEWYCVXxlz98q9vfHmZ1RQPNEkt+oiG2d/93TJnlqezcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873541; c=relaxed/simple;
	bh=9mKNuJDcW4W4ssl8Jd9iWBB4hzpEOnXID0zJTl24EEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsb97K/eeU322QgJswGwfiOf/aGGb9WlQdQdHgIiRG+EC8VDpgeBolyGYJ/cvwVKKx/D/MbvBI7oq00H3UXICW7bYmp/x8nBCQ9QVypdihsNb++a31yrBah4u4DxQagai3DtBT6YzSwhn1il/LL2TUNJfzC3Q7XLTX2jywWw+5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=B8k07iLB; arc=fail smtp.client-ip=40.107.117.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwNjnHm5JagFSAd6f641oOIc/k7WPnxIqUfOMMOaO8OmN7Q+RfBc1agfMntRtvHgikN0z0NIFcECbFnT+0p6VS4lmm7Z64kKLyK3XbSaB5yHCc6bzjGTtxEY+xPNBzFRc7FJapkokWjEyhZnigbWbYp0oYEeinexvZPKReHLK/3MiAdE6qEGl4pdLeP6GHN9P73fizrfuX9zBsglhboGq7EOcDe43R4PUBX0mbiEDU7HSAPCWfwzwVUxi+TfSLJSmXHTrclcoQBJ7d1lcCZ9Z/RxovL8TJ4Yd9hambUlbIXlAwX3G/+NAkVBdfZHM1PGupLNE6n67GEc38MlDI/KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mKNuJDcW4W4ssl8Jd9iWBB4hzpEOnXID0zJTl24EEY=;
 b=G4ngjecmLWGDCTb/nKgviwgzQdzsI39kdWLzORnJBnK5CSr5QAPMqF6nnPkD4vZmMXHlaFfIvMoDvqpaVSTymO3V7LAiygCtCrCBGkW4+TAgLJlxRThOEEgpnDSdUO26jv1Pje8oxg9swnmcSU5wFqZSZbynu4mQMINUXqZliovGQ8h6bQXDkdAgNnxcp3rHIjLKGsl5pB3plCkKj3iE6qoVB1OjqByexMZXHpF54PEUlQQOCh0VwPOnyghq9063GmFbCsgFV/d7y5r2EpzxZ5/ghJ8xlq5y9eH0nKu4hOG6Lq6m/6hbHvs69D1/H44SlsdJF1xqpeGuAsC5im3b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKNuJDcW4W4ssl8Jd9iWBB4hzpEOnXID0zJTl24EEY=;
 b=B8k07iLBUvooXijiooKcqEpY/yupRFD+cMJnPOb/YTiyvJYVHjBJkJ+RbroLvck/6xtsjMvSXZu5aQRymM+p8eleGaYE0bqhfdrQa/I58dKZrE0mJCMnLUldhLj37fJqvGTKYcRJOKlYzBf35rvz9w1J0+5RMqn67moMzTxwzyFefrp9arUPT1d42BA7rGELPIFJNuk8Db2X50Vu3Nh2HKx1dOdoz+L9ZuzOLYrkUsVfwlphaUn+Leg9NbP6TIXcUYE3u9tSs6SkJvQfYLET7I07flrD93Q0MWT3ZoZgbjYnvn00UYBRuDb6o/S2dPEh0W1MRxeEQmsj4KjJKxH4Eg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SI2PR06MB5170.apcprd06.prod.outlook.com (2603:1096:4:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Mon, 14 Oct
 2024 02:38:56 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 02:38:56 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "rentao.bupt@gmail.com" <rentao.bupt@gmail.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "andrew@aj.id.au"
	<andrew@aj.id.au>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldF0gbmV0OiBmdGdtYWMxMDA6IHJlZmFjdG9yIGdldHRpbmcgcGh5?=
 =?big5?Q?_device_handle?=
Thread-Topic: [net] net: ftgmac100: refactor getting phy device handle
Thread-Index: AQHbG7XnDLjERVlDRUik5aI23MfSrLKDXeUAgAIrnrA=
Date: Mon, 14 Oct 2024 02:38:56 +0000
Message-ID:
 <SEYPR06MB513444FDA713972EFC05FBFD9D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241011081633.2171603-1-jacky_chou@aspeedtech.com>
 <be591afe-d70b-4208-a189-40e65227ad14@lunn.ch>
In-Reply-To: <be591afe-d70b-4208-a189-40e65227ad14@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SI2PR06MB5170:EE_
x-ms-office365-filtering-correlation-id: ca7c75c3-fbee-4c7d-af31-08dcebf959a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?WWhaM0Zaa05YNFBvUmpZVG1WT09mSW9zWlVPUUk4N3Q0emVRb3RKc05sZ3hEbllr?=
 =?big5?B?T1E5a2xNbXAzVmxOV3pabkpyR1NDNmk4SkhGRDgwbGJVVE0wZ01nQXY1M09kd2Zn?=
 =?big5?B?M2E4UFNQcDl2T0xKWnRTNzVkVHduQWdJUEVkbFJySDQ0TmV3VWo1OE82QWhSWWp4?=
 =?big5?B?ajQvNTNhYzZvNjJlSXBVVVlPV1E4Um9LRWE2RXJvMXJZaGN3QnNOaXZCeGtnbGQr?=
 =?big5?B?NGFndUNoR20xSjJSR01XL1ptdXloWnZVRjNQeC9uYnBORXV2Nzk2cEN5MDNXakk3?=
 =?big5?B?b3ovUGNJVlFMVWErcWI3UVZEVkEvUm4yWUU0dFZ4VFE3R0EyUGdHWmlja3lncXd2?=
 =?big5?B?a3ZzaUNCdndRdnNzcVJDVGRtTnRGbUJrVVJwZlJldi9sSnh1cmxabURlSEFqb3A3?=
 =?big5?B?bmRUQWUycHVtVjJ1a2d0M2VvbFJjeVBWVkNKWlZ1YWhEVU00bmt2K0hORWF1eGFZ?=
 =?big5?B?Yytsc1NITkE3cjBxc2NzOXRNbkhlSHhqZy9oUzlCc2RuOG56Ri9KeXhaRTg5SUFD?=
 =?big5?B?WjJGcG1qVHFGZkJ0M2NvVzVhcWFKOWpNME1CT3BzUEloamNtVXRPeHgrU1ZTVlFW?=
 =?big5?B?em1aaWw5WUUrNDd6MnI5RTQvKzlaZHp5VDB5azJiblNZelRPSWhBVmpuZitwMnNp?=
 =?big5?B?bVFkY2ZtSXl2Nm1iSTNSbzF4RE54eTFMVWJBZklwVXAralNZRXk0elVVNmFkWXNN?=
 =?big5?B?ZDl4eUJ1ejZjZDJvR1FXaFEzbW5IT2xrRXM0TWtFT2x2VlZsdGhUekNndGsvMzVj?=
 =?big5?B?YlN6MThEcEpRNUlFeXNnSkdmVWIzZHZUVnIzaGN0N29RUGlwMGVHcDMrVGZyS29z?=
 =?big5?B?RUQrMEw5RHdlNnlFd0tiUVhhdnl5UGo1SWxBaXFRYXRUL1dvSkEvNlkyS2xvUSty?=
 =?big5?B?SlgrQU5ObFR1SjA1N1pWbE1JSlE3VjIwK1pKT08rVkFIakRsV1lSUmN2WTFjK3Z3?=
 =?big5?B?WmZzZ0tOZ3AxWFFvNlJyNnJqaUFwdU1IK1k4dE8rT1hDUmQ1OUVRcFZTUi9SaHc5?=
 =?big5?B?ZGUzWWxBWk43WlpsQU4vVml4cXNtQzlHVi9XSm83aE9oZzV4bG9tNkJGRXdncFAw?=
 =?big5?B?THhwMXdDYlgwUDFNYTNBUUszSzFZR0RVMG5YTks2YkhnZitsa1VEMy9BOURmdDR1?=
 =?big5?B?UTErb28vNWoxd1QyZ2Z4S2xMSVUwWUNqa0JNU2lvK3QzSFVGUWNmUXZ3aDlac256?=
 =?big5?B?RGthQjFJdjMyTjlnRUQ2aG1mM2FoRS9lS2RQYWh4Q0hYaG1VYWZiWmRIaXhORlB0?=
 =?big5?B?Y2VUR2JQbTRCUVdxbGZEMlN5RENtUWhwZk13ZXczQjVHd1RyYmdROUtvMWtEZnFo?=
 =?big5?B?VjJMckFTOTMxWWJzdEJ0NVZtemppRnI0d2hDNlhxUVVDQjBFM3ZWaFF2U0R1RlBS?=
 =?big5?B?WFE1SDBvVWt1UExxdXVDU3BjV3dKVWxOY09YY3dYMldSMSs5OEwxZWNXSG5VMURU?=
 =?big5?B?UER5L3A0RHgzZW42M0Zla1hvbGh4RXlKMHUxOFU0ZHdMM0pYejlJMEhhTWJIRkQ1?=
 =?big5?B?eDhLY0h2SENPdHFzYkVONFBMODdKTzZlSVJWSFE5ZXdlKzV2UjhOd1cwWHZrSC8z?=
 =?big5?B?ak9lZDJOT1VGNFZqZ3h4Tjk0OWZoTGVBNndjbWErVEJBcWFhcm9OUXEvK3VtTzJY?=
 =?big5?B?MjVHazhHeWlXZ2kvaXFUdk5NaEFGN0FvQnF1ckVIWFdlR3N3OWlXMDNSeitDNGY4?=
 =?big5?B?TU43UzVUQW94d3pYYnVvV21GK0Zxdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?dDJ1OEQ0TGxuOGh2S3NXM0VNRUlzZ253aExrbitwNnJHZm5LaC9VUXVpVkFvcGRk?=
 =?big5?B?NUZpbmo0SXNadGpzQ3cvTEcwaHpBUUhNNGszL0FMUkpla3Q2aXJwS1ZEUTZ6ZTFJ?=
 =?big5?B?dVBtS3YwUnJPb0dlVUJ4UXFJSkJkYUVXVXRWVEZPNHRBVm9PbHdrbW5SK3phb2t0?=
 =?big5?B?MCs2bVZ5NnE4aHhiQndrVnNDZURtTC9GaU9pdnA0WnpzMk5LaUo4YmZveTk5MVQv?=
 =?big5?B?RGZwbTdzK1BPaURpd2hyTElGaVpNU1RYQm5yaVVtWmlUYWdTam92eDJoUkoxQ0pN?=
 =?big5?B?YkxONWQxODdlMXRxSlUza3VHQU5iMjFSc3RnYUp4WkNBOVcxdmxTcVEybWJKMGU5?=
 =?big5?B?Z09URXJud2ZWNTkvNEJJYmxqcWdwVXRaMEJVcUMwaC94YlIxdVBwSXF3NGdWTnIw?=
 =?big5?B?NUgzMjRQSnFYcFBRMzhSOWFmZlZrRnhkckhmQlBoZm00QzVtQmE4Qm5CcjJ4VHN5?=
 =?big5?B?bG83c2RjR1o3SDFmQXRkcGdvTzI3bTFRZjdWTktRc0MraGV6VjA0LzdtSG9kN3A0?=
 =?big5?B?cm1TNk42cStXbUlVUC8ydFVoT3I4bDAzMDJxWU5aUTd3bTNoWFdwdk5QU3NyRmR0?=
 =?big5?B?RU5rOEwybmUzRmFhZ2d4Y0Qzelp0blRjNjhtbTcyMHNRUHZhSERIUW41bUNMWjhM?=
 =?big5?B?ZExNbHB2OE5iaEJGLzFnM1Z2eG1GR3UxLzNqNG4vK0ZJeE81RGp2QjBLbW9wT2lQ?=
 =?big5?B?RkFIb0tQUUkzQ3MyUW1FUHdFdDdIMzZ2T3NjYkR0UDI5OVhCSm9DNm5ndlNJNS9k?=
 =?big5?B?ZC9GNjRtYjJCWlU0aFV2YVpEOFlIS0pVaFk3RCtyWlFkOFNINXBtL0RjTitkaXgr?=
 =?big5?B?dERDbGVtQmdlUWtxRXFtMjRVc1czSzR1bnprUjIrbE5nN3ZXbjV3TUhiVTdQVkls?=
 =?big5?B?ZkxLTkNYU2FiVXFxMmorK2k3M3N4L1dySngvTzh0WTdWeDJjclRBK3U3Umc5YnRI?=
 =?big5?B?UTF2cUJGaW9IQkFkZTNwdy91N0lRU1VRTGhwRmZrNUJnY0N1cG9Pc0Yzd2RqTXd3?=
 =?big5?B?d24wKzliMkxTc1ZXN0tVbXNpaEhJcGZZeVVHMVZPZXJmUk5LRThNMEdzWUdUL05B?=
 =?big5?B?U0VMZE9EQzFCZ1d3UWlDbk9qYUptYytXclBjczZxbFFLT0ErblZvdXZxVkZ5Wi9D?=
 =?big5?B?Wm1tNlhJb1kvREJ1WlhjaytTWFk1WkJRNHYxZHl3SnJYWTJXTmF0VnhEK2M1OXpl?=
 =?big5?B?LzNIZHpDZjhiRm01MWVoeG5Zc25Wd2hCT24yS3ZCOHpSWkZkNVU5U3prNXY3VVBK?=
 =?big5?B?ZWZUdWhVMDNjWEhKMXRVWVRxRUNIckVkbUdISm9IVTc4amxJeFVENVZKRHlVd0M4?=
 =?big5?B?eUc2WHlUdTVKK1Uyc0N1THlOUk5YaEh4dWRDMFhNcEpXVXE5RFNNL3FVbGVWaDRo?=
 =?big5?B?U2lQLzUzZWdCOENOenVreUpKbCszejM5NjlORTFzYmlma2xUWlZyZjNzS0dLZyt4?=
 =?big5?B?WldBZ2UwakRkRkJBR3NtYVo3b0tCVzgxYkhmU1p0dmcxcy9zVVlBYlB0S3V0RWpa?=
 =?big5?B?REtmakEzbXl4SVFLc21SeGFTaGd3RjAvV3JPYzRlRVpGUUkyU2gxclZMZEVyeldH?=
 =?big5?B?dXRpdlp2WnJCYjhQeXUzMkRheWdlY3lHb0NyWkhlKzNXZzM2ZXYxQ3J0K1ZTVmg1?=
 =?big5?B?Nmd2ajR5UmJ5czVXRmpWbjY2WjBNQmZsVXoveEhDY3U4UDF6RUxNKzlvZEhudzdj?=
 =?big5?B?VlRvbzVOY0VNaUZqZVdQYnlscFpQR0RNNjBiUkMrWFJCQ2ZnQ1RCVDdhY1l2K2xl?=
 =?big5?B?RnVwdzlkb29IbE9rcFFIMitkRW1hS1l4Q0h2L21GbmJZOVNIaEFuUkp2TWlMd2VC?=
 =?big5?B?RkVOWjVvK1V6MFVMbUZpWWliUWRhem1OWU1iUGFRSm53eEdUcnBHQ1FBdVRpWHE0?=
 =?big5?B?Z3A5L3E1cEsyRmZzTFBJaUFVTk8vakgxT3BPN2xGRU04SjgvVmVhOTU1TnM3WkVa?=
 =?big5?B?OHp0LzBDdDhlTHRXbUxhYUlmV1krUERpMllwRGpnK2FsSXo2clNvYm5ocVhvQjF5?=
 =?big5?Q?/EZPJQNaHmGfTszY?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7c75c3-fbee-4c7d-af31-08dcebf959a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 02:38:56.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aubDQreXSRtWHbmbQ4Dss4PTZkHokB0DMZ50x3qagqzsc5PcW/kfxUxpdF8YMHTunWZ9syqkAWcuMiYT5F0y1rVYfu1qZ2fhQhvDMPQ7kAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5170

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gPiBUaGUgZnRnbWFjMTAw
IHN1cHBvcnRzIE5DLVNJIG1vZGUsIGRlZGljYXRlZCBQSFkgYW5kIGZpeGVkLWxpbmsgUEhZLg0K
PiA+IFRoZSBkZWRpY2F0ZWQgUEhZIGlzIHVzaW5nIHRoZSBwaHlfaGFuZGxlIHByb3BlcnR5IHRv
IGdldCBwaHkgZGV2aWNlDQo+ID4gaGFuZGxlIGFuZCB0aGUgZml4ZWQtbGluayBwaHkgaXMgdXNp
bmcgdGhlIGZpeGVkLWxpbmsgcHJvcGVydHkgdG8NCj4gPiByZWdpc3RlciBhIGZpeGVkLWxpbmsg
cGh5IGRldmljZS4NCj4gPg0KPiA+IEluIG9mX3BoeV9nZXRfYW5kX2Nvbm5lY3QgZnVuY3Rpb24s
IGl0IGhlbHAgZHJpdmVyIHRvIGdldCBhbmQgcmVnaXN0ZXINCj4gPiB0aGVzZSBQSFlzIGhhbmRs
ZS4NCj4gPiBUaGVyZWZvcmUsIGhlcmUgcmVmYWN0b3JzIHRoaXMgcGFydCBieSB1c2luZyBvZl9w
aHlfZ2V0X2FuZF9jb25uZWN0Lg0KPiA+DQo+ID4gRml4ZXM6IDM4NTYxZGVkNTBkMCAoIm5ldDog
ZnRnbWFjMTAwOiBzdXBwb3J0IGZpeGVkIGxpbmsiKQ0KPiA+IEZpeGVzOiAzOWJmYWI4ODQ0YTAg
KCJuZXQ6IGZ0Z21hYzEwMDogQWRkIHN1cHBvcnQgZm9yIERUIHBoeS1oYW5kbGUNCj4gPiBwcm9w
ZXJ0eSIpDQo+IA0KPiBGaXhlczogaW1wbGllcyBzb21ldGhpbmcgaXMgYnJva2VuLiBXaGF0IGlz
IGFjdHVhbGx5IHdyb25nIHdpdGggdGhpcyBjb2RlPw0KPiBXaGF0IHNvcnQgb2YgcHJvYmxlbSBk
b2VzIGEgdXNlciBzZWU/DQoNCkkgYW0gYXBvbG9neSB3aGF0IEkgYW0gbm90IHN1cmUgaWYgdXNp
bmcgZml4ZXMgdG8gc2VuZCBteSBwYXRjaC4NCkkganVzdCByZWZhY3RvciB0aGlzIHBhcnQgYW5k
IGxldCB0aGUgcmVsZXZhbnQgcGVvcGxlIGtub3cgdGhhdCBJIGhhdmUgYWRqdXN0ZWQgDQp0aGVp
ciBjb2RlLg0KVGhpcyBwYXRjaCBpcyBub3QgYSBidWcgZml4Lg0KDQo+IA0KPiA+IC0JCXBoeV9z
dXBwb3J0X2FzeW1fcGF1c2UocGh5KTsNCj4gPiArCQlpZiAob2ZfZ2V0X3Byb3BlcnR5KG5wLCAi
cGh5LWhhbmRsZSIsIE5VTEwpKQ0KPiA+ICsJCQlwaHlfc3VwcG9ydF9hc3ltX3BhdXNlKHBoeSk7
DQo+IA0KPiBUaGlzIGlzIHByb2JhYmx5IHdyb25nLiBUaGlzIGlzIHRoZSBNQUMgbGF5ZXIgdGVs
bGluZyBwaHlsaWIgdGhhdCB0aGUgTUFDDQo+IHN1cHBvcnRzIGFzeW0gcGF1c2UuIEl0IHNob3Vs
ZCBtYWtlcyBubyBkaWZmZXJlbmNlIHRvIHRoZSBNQUMgd2hhdCBzb3J0IG9mDQo+IFBIWSBpcyBi
ZWluZyB1c2VkLCBhbGwgdGhlIE1BQyBpcyBsb29raW5nIGF0L3NlbmRpbmcgaXMgcGF1c2UgZnJh
bWVzLg0KDQpBZ3JlZS4gSXQgaXMgTUFDIGZ1bmN0aW9uLCBub3QgUEhZLg0KSSB3aWxsIGFkanVz
dCBpdCBvbiBuZXh0IHZlcnNpb24uDQpUaGFuayB5b3UuDQo=

