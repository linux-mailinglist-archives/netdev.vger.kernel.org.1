Return-Path: <netdev+bounces-116774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08694BA76
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1971C20990
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67B01487C3;
	Thu,  8 Aug 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSqwSprg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C341482E9
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111535; cv=fail; b=HbUOGQY1w4ztdAIIipiLqtBW+CfGIqrenSqWM08T9lEH/A5FXbzh/IIWuKxqok0KfGwCDqTyi6pTebU1beY9VcjdPJWK3tggXYL1YSWeQZDg5ooeuIrdtobHgU6B/wONgipymWLJnSw0mbk3EyuixHzDoOexOnnR4IhgW7a1uCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111535; c=relaxed/simple;
	bh=xPCxTTx/20Zw0KQ+AnfKPn9qpkXd8Y6ws2bsokVVQLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNyrzwZOEEjvywJ8cBQNNAwmHTkCCBHezt/KSSEUt0Wz/7YeOes0aajNpGg3bXq6/+5MtsxeWiZ9i38sJMA8Ba80kIQJ10y6rdSFkk7iHsRo6Gac1iTFPP6cNggeEBwTc/oGTkSEVAK9xaMReDk3aEU4MtP684gL0XRrZOqRelY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSqwSprg; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5rvdGk53q+x0AZimtZm5vy1jfmfT47m2SW3HMYf/fg2X9RHWy9f2OKs+wp+XNNa+qL3ke5Gc0maVWO6BfhdWJaZZEXpRiWAi5+x9ZGMJk2wsU43T3r9EieOBs0OrJTDPtN0AuDTT6LTJkxfZ2TnLnQrdHdyFgyg3zlI4WTzKTrKM+X49fdiQJ+AQgnFIqNzPHWUZZNWtGqYnrtJAsBX548Kaozgrob0jbpzD9obsSEBemXY+puVJvESqwdpgxP5Rd0schUZJ58Qm/7mxKvlEqeBlRAsRsCeXdpuwD0ECJU8uueljSzgwf1OxmmxGwAf+UdOOnXSk3ylhL1KF4sfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPCxTTx/20Zw0KQ+AnfKPn9qpkXd8Y6ws2bsokVVQLU=;
 b=JKKk7+WyJzZA2jVFVym1aCMdSrbU3CBl6bs4J0hB8u9HGylNt86xVTcNsp/FnE2HdPsJkVbkJmxurMMm2+ajKeVV3CEZXyujGg5anDpr4VlY1P+S7jJu1xaK4eezNBwZNcQW1uqyU67O30pg9s6P5nurIcoB7jtvITB6UN2IUywJ7lo20FPiN2IaK2whpOnCsDP6896ECLpzK5f3V3GhoX6RM8aVVJnfxQxsw0RRVnB6UH1JmoZ9FPqnb5YtH9je9Gvdl3kn7GmfY9iO2Tj5Hf5RW2xl6bIbNZmEjG6Kh9U9xMHQ8s5QJtFrP5LCxwXzGl1In8WccEOr9cB4WD0c1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPCxTTx/20Zw0KQ+AnfKPn9qpkXd8Y6ws2bsokVVQLU=;
 b=kSqwSprgX9oIUtrG6ea0ySrclG7Wixxa3Ekvo67sMFCMF0y/Jit8x4XqL+ZXpHUlzr0Slpblr6JgcyPN/DbVqHfaEiARtHXwjLpeDYyiBhVbR2gRTddH3T21f4yxQbjX6QHlsnTXroywfgWoFgkcyn3zmgF/bmGgUSW9tiQYgJTJSZKCL5SLUjJKSv8IyVk+W8HNCU8PT+0nTYt+aWioR8ORG7MUM+7yKYn6jlgEEbs6bdiO3CXi9jYBvYs/1EThQXhvCwDRgR2IN60iP5yrGlrO8Iy4MmU85FWehk/ke9ysIYFTnvvd2uopGU2VO+df5lqZaYENRTUOLVcupftfEg==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 10:05:27 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 10:05:26 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Leon Romanovsky
	<leonro@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net V3 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Topic: [PATCH net V3 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Index: AQHa5vUx5WNrJY6ufUyiOKMvRIBB47IdHm+AgAAIoIA=
Date: Thu, 8 Aug 2024 10:05:26 +0000
Message-ID: <0ed0935e51c244086529a43aa6ccf599e5b3bc52.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-4-tariqt@nvidia.com> <ZrSRKR-KK5l56XUd@Laptop-X1>
In-Reply-To: <ZrSRKR-KK5l56XUd@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|PH0PR12MB7485:EE_
x-ms-office365-filtering-correlation-id: bc8b35f1-c5e6-4cca-d536-08dcb791a05f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a29vdjdzd3hNZ2FYZS9jaVVNSDVKYWpqZmV1QllYVkZUd1lYKzdnYWs5Z2Q4?=
 =?utf-8?B?U1dVMUpPb0VuUHBOd2hhSVMwSStqWWJnRFlqWjRITkgzcTFZbVlqQWZHUmIz?=
 =?utf-8?B?SHNhTW9iTlJYbmdXM0NPOS9hR2ROUHZVNmxDTkRRN0pldmlVemJUbXMwV2ZQ?=
 =?utf-8?B?VXFQMk9wYmlnM2xHVVYwMklhbjNSdkVrbFJiTmk0djBmNFpUb0dnOGZ6UFdt?=
 =?utf-8?B?M2NGR2dKM1c2aDVCbzV1M1dYRURvMDV3MWlWNkFuQ0p1RWNlendUNUhYSHNn?=
 =?utf-8?B?VmtNc2tQektKL1QybE83WlFIQjhNRCtpRi83eERoay9SdXNKaFRkTmtuZVFy?=
 =?utf-8?B?QnBoaWtyMFdPZHZtRldWcHcyS3JmM3ZSRWxZUFg1ZUQ3Y3ltRHdscmFick0z?=
 =?utf-8?B?ZWRSVnM4Mzk5MnpWM1FNMEZ5RE0zT2FCdlVraGZMV3c2UENzcE9od2c0ZytK?=
 =?utf-8?B?SjB3MlRHVStkbEx1RkpiS3pyRlZpRnMxeHZwandpWldhNFJZaHlLMUJrSFJR?=
 =?utf-8?B?VXptbkp1UFphcElPV216dU5hMnBhVEVkc2pwT3NreFpiRU5hWkZ2M2tOMERT?=
 =?utf-8?B?cklibkQ3L0JKMWFHYitCOWFWM0VVVzcxWG5EQ0Y2VlVEK292RS8waFpTNU84?=
 =?utf-8?B?S0lYbmRTVi9kd2ZxanIxQWxXRHlFK2pJS09Md1p0cGpjMDJqQVdRMnVBSkY1?=
 =?utf-8?B?QStrWjlaWVljR1ZFdTg2c0t1Nm1Jdy9OZkJydDMyY1hxaE0za3hPNXd4YkQ5?=
 =?utf-8?B?dklSb2xjeXFQK3BWTHB5V3FmKytCTkFOSUNpSTRlVGYzekNzLzJGdkpIU0g0?=
 =?utf-8?B?Q0I2cUIvamx3bmd5SnFSSDB0Z3lMZmZ4Kyt3THFwRUNpTmRraTNIQ3lrQ0tR?=
 =?utf-8?B?dW4vaHpuOEdWRWRuakZQcFVidkdTWHEvVGpBTThoZk95allpRldtVmg0T1cr?=
 =?utf-8?B?VWhkL21mM0FqZmQzL2tTUFgvS1Fha3RxOGdjTlVsb0JMMXd4dTZYUHJ0djdD?=
 =?utf-8?B?SDdkZUhJdi83YUtLMWJ0dzhoZ1dXbWV5dGlhbDA2VksvV0lVYk9hVTV1WDRp?=
 =?utf-8?B?Tk5tSmp2dnVxZVp5Q3BvUDJXQjJRRU1FdEhsNUF3N3BOQ3RveG96cmZ1STFn?=
 =?utf-8?B?Um80aEYvYnhIN3g0QmgzYU5LZjVBV3JEYUVKNEpwQ200QU9hMTZOeWJLNERO?=
 =?utf-8?B?Rys0UmF1NWU4R3BQOHRNQkEzNGdCRGowQTZQZURCS2JFNVB6cEFTUi9EMFAr?=
 =?utf-8?B?ZWV6KzROQzZXd2Iya1dySXpXWW1ueEYxUlV6Z21XZGljWjU0Mk9YeFFRalpB?=
 =?utf-8?B?eDErTlY3YXp5MXo5Sm5FSytkcGd4QVVDTndyTjNDMUNWYTE4WWhLbTdDT25y?=
 =?utf-8?B?YTMxcExsU1hyVDAyRFRnSzVNak5nTldFcmtuOWNqTHU5M090UHpqZUt4UHZM?=
 =?utf-8?B?L2U4QXVvQlprakl5ZENuWnVBNkYraDZIYXZseGNWQ25DcmZ3aGh2VUt5MWxm?=
 =?utf-8?B?bU5SMzVTZ29BNEdNcVQvd2p5NWdVN2JSUEZnNXV3VXdHczlPcGtqNmQwK0JW?=
 =?utf-8?B?YkszVG5ONXpENkQ4b0cvWkZWdGhUTnV5SG9KWjg0eUdrdTB3NFpocVYwWmIv?=
 =?utf-8?B?QXJlNUozRGhnOWZ4Y3V0c0JFdjZDUTRmbEN0Z2lWbXBQYnVaQUp2QlprSElw?=
 =?utf-8?B?UkJ4ellBdzlBYkZLcGZ4eUhzbmJBSE1UR3ZxMmtTNG9vOVo4RjNxMnEvM0Yx?=
 =?utf-8?B?R05RMGVFYWZqT0NQTkdVWXkwa29td3h6OUVGa0lrcnlzdVlZVm9kbnNzTHdY?=
 =?utf-8?B?aWJBVmVwamw3VmlZeTg5Z0VQSnUyKzRnMXUyYjh3T0ZFWFF4Z29nMGFhbllZ?=
 =?utf-8?B?cGtOOG5QUnlUSnBub240QmdrR0lTZFpQU1hkNkdTN2FUTlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sko1M215UTZsdEdLL0o2L3A4ZS8yemhPQ3hwdXlTcTVWbm9qTjRic1A0c0kr?=
 =?utf-8?B?SW9tUEd6VWRKa0kzY05jc3RVVGhWZnhqZzRoTWg0c2Rkd1dtMnArcEVPcEg3?=
 =?utf-8?B?ZVp6OFBEYktIUE1sLzRFam0wUGpZR0JhTDN3ZHVxcElSWmJUdU9ueCtHYkRq?=
 =?utf-8?B?YzN3TUpYLzZFYnNwM0JOTkF6QW50RUswR25scFpTTGRsMTNQZ3RXdXMxcWxw?=
 =?utf-8?B?dzhDSjdadUlSdXF3SGVmazZQeWtoUUtwQ2VyWVVENllVektvbWFZMVdoZXR2?=
 =?utf-8?B?cmh3UkZtVGRZR3pZemNwY3pHWTY1bENQT1RldjczUDlLMFRGNzg4U2dJOGc3?=
 =?utf-8?B?aGZLMWNqaUZjZll0ZU82azRodml1YThoRS9LYnN5d0hNSFQ1dStQa2hmTWQr?=
 =?utf-8?B?aFhCNXo4TkNSY2U1WnM1N2hsbUlGQTRvL2JwdGw3MkhUblVCbndBeWxrQzM5?=
 =?utf-8?B?UjlhVTl3OVkrek4yVk0wYXV1QUY4a3RjRXo2SzFPbFJyN1dWYlFnVmVmb2RT?=
 =?utf-8?B?eVVsSzFuM1dkR1VWZXczWFF2VUErVE5EUmxvc01hWWkwV3ZpcGcwMXB3RXNQ?=
 =?utf-8?B?djZjTVFVYXJ1MTA2aDUrdE9MbGl3KzFWSUZKdGsyUWQ2d1doYnB5Y28rMk1y?=
 =?utf-8?B?V29pSWI1VDBPUU0va0ZHWUN3RnU2Y3NQTUxMbGlIcFgxTm8vQjB6YnBnYXFx?=
 =?utf-8?B?RjhWZEVvU240MTUwb1o4L2hVNzJhS3NyRkVsMG1uczlOTlJIL1g2dWVzUHZa?=
 =?utf-8?B?WjFIb1lqdG5KMXBqSzB3anl1WmZZQWlTcEwvZVM1VGRPaFlSd1hBbXdhK1ZP?=
 =?utf-8?B?T1JZQWQwQlk2YXU3cDB4a2pJTEtySTliYlNrNGI0dUpOMnVBU2hBODVOaEF4?=
 =?utf-8?B?aXNNOVZuSDYvR0lNbENoWVdRR1RCS2JWMHlIak9jeEJIeHlmRURPOFdZMTRs?=
 =?utf-8?B?aVZkTWo1ZzNPTDd5S3EvcG43akJhWE1Zd3IyOHQrb2hkRWZBYjRpbU5IOFY4?=
 =?utf-8?B?MEJ6bWxVcVpLYTJ1RDBXUEZydjMxbU9KU1lBeTZWN2l1UkhHMUJ2dnVsd1VH?=
 =?utf-8?B?cTlqTytRMDZ2c0FYOU1kTGxoTUhrdlZJcmdsK3A0bGhEME9LY2FOWk5xSVN3?=
 =?utf-8?B?Nmp3MkgwZVIwZDIxTFhuTHlZaExLNzRNbkxEWEExMjJuMmxMWjJOa2R6R0o5?=
 =?utf-8?B?bG9FeXBhLy8vOHJNMi9pOHdmdVhsVmJjbkFlS281WFA4OElwMG14SzRqY1JD?=
 =?utf-8?B?bVN6YXhPK083SkFWUy81Z09rRTlLbWFkNjU4M3o2QWIvd2J2eUNSd0tGWldK?=
 =?utf-8?B?MFRZNXg0c0JiMkZ5clR5R05YS2VyODlIRFIwcUNLVVNFQWQ2cmI1OGJLZ08z?=
 =?utf-8?B?NG84czk4ekIyTTArTXVYaktkQmo1ZmpHc1BzOC9NcHdqNFhoMjN6NXJvTE5I?=
 =?utf-8?B?RGJlUDA0cG5hL2ZTb3dTRm9ReG82YVdLS0Z5cEhtVmR1aU1Zbm1sOUZXOGla?=
 =?utf-8?B?YWs3RStwWk1ZelNBQ3pYQVVFN3J1RHdIdkZZVXRqaVp1d08wVmlPZW9HZHJy?=
 =?utf-8?B?YkRocGpZMVVlWEdkd0E3UmFMRWZDR1BuOU5pQTVMQ040NVlCL29KQTh5QTdO?=
 =?utf-8?B?S0pJNkwvemphVXpIUkZqVGhYZmtEYStBSWRFTE9MYkdJYlBDbk1hejhkcjE3?=
 =?utf-8?B?TE0wd1c0bUZKdUQ3dTBzS0o3cklJOGllbUwySzFqNmFyQnVIM0pNNjdOa2Rt?=
 =?utf-8?B?YXZIN1hOdkZubi9BbnZZWGlsdDZzQ2pBeStpb3BuYWtCU0FTVmxkcGQ0T0M4?=
 =?utf-8?B?RkEwTnBVUFFxKzdrZmV1M0JqTU9hbE9oaXhGaGJpU0VzaVZWVVJpcXM3dUw1?=
 =?utf-8?B?YXJMMmU4QTExaUl6T25oK2NjU013S0hVbmdOWHc3OVQyMkEwQTJYYVRkS08x?=
 =?utf-8?B?SmN3Z04yZ2J0T1RkK0xwTXp6Unc4WXQ2QW94MmhQaVBid0E3dTdpSTFpQVpn?=
 =?utf-8?B?dUtHcXRkdDFpWHFrajlHYm1OZ3o5a0pSZVlqaXQ1WU1xS2FIN1dPWGZ2TTZp?=
 =?utf-8?B?bmprc0FjTG9jallSWmFOemh0NWpHR2hrVXJ1Z1VkU2lvUG9GL1FMWTJPZ2FJ?=
 =?utf-8?B?MklDNXVDYkFMYWhCNjByTjB0VkxJYk4rbEUrSWt1Y3hNUmpXMm5xREFwb2VS?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <330070E2F8D6FF4AAA933BA4375DFAF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8b35f1-c5e6-4cca-d536-08dcb791a05f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 10:05:26.8403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GD8U1OWW34BKBZ1VRpd/h8ve/oSat8meGJv+cnoDy72JSaetKzalVG+CmWU+wBEStaAWQuFqH12F/RGfYk1Arw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

T24gVGh1LCAyMDI0LTA4LTA4IGF0IDE3OjM0ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMDUsIDIwMjQgYXQgMDg6MDM6NTdBTSArMDMwMCwgVGFyaXEgVG91a2FuIHdy
b3RlOg0KPiA+IEZyb206IEppYW5ibyBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBJbiB0aGUgY2l0ZWQgY29tbWl0LCBib25kLT5pcHNlY19sb2NrIGlzIGFkZGVkIHRvIHByb3Rl
Y3QNCj4gPiBpcHNlY19saXN0LA0KPiA+IGhlbmNlIHhkb19kZXZfc3RhdGVfYWRkIGFuZCB4ZG9f
ZGV2X3N0YXRlX2RlbGV0ZSBhcmUgY2FsbGVkIGluc2lkZQ0KPiA+IHRoaXMgbG9jay4gQXMgaXBz
ZWNfbG9jayBpcyBhIHNwaW4gbG9jayBhbmQgc3VjaCB4ZnJtZGV2IG9wcyBtYXkNCj4gPiBzbGVl
cCwNCj4gPiAic2NoZWR1bGluZyB3aGlsZSBhdG9taWMiIHdpbGwgYmUgdHJpZ2dlcmVkIHdoZW4g
Y2hhbmdpbmcgYm9uZCdzDQo+ID4gYWN0aXZlIHNsYXZlLg0KPiA+IA0KPiA+IFvCoCAxMDEuMDU1
MTg5XSBCVUc6IHNjaGVkdWxpbmcgd2hpbGUgYXRvbWljOiBiYXNoLzkwMi8weDAwMDAwMjAwDQo+
ID4gW8KgIDEwMS4wNTU3MjZdIE1vZHVsZXMgbGlua2VkIGluOg0KPiA+IFvCoCAxMDEuMDU4MjEx
XSBDUFU6IDMgUElEOiA5MDIgQ29tbTogYmFzaCBOb3QgdGFpbnRlZCA2LjkuMC1yYzQrICMxDQo+
ID4gW8KgIDEwMS4wNTg3NjBdIEhhcmR3YXJlIG5hbWU6DQo+ID4gW8KgIDEwMS4wNTk0MzRdIENh
bGwgVHJhY2U6DQo+ID4gW8KgIDEwMS4wNTk0MzZdwqAgPFRBU0s+DQo+ID4gW8KgIDEwMS4wNjA4
NzNdwqAgZHVtcF9zdGFja19sdmwrMHg1MS8weDYwDQo+ID4gW8KgIDEwMS4wNjEyNzVdwqAgX19z
Y2hlZHVsZV9idWcrMHg0ZS8weDYwDQo+ID4gW8KgIDEwMS4wNjE2ODJdwqAgX19zY2hlZHVsZSsw
eDYxMi8weDdjMA0KPiA+IFvCoCAxMDEuMDYyMDc4XcKgID8gX19tb2RfdGltZXIrMHgyNWMvMHgz
NzANCj4gPiBbwqAgMTAxLjA2MjQ4Nl3CoCBzY2hlZHVsZSsweDI1LzB4ZDANCj4gPiBbwqAgMTAx
LjA2Mjg0NV3CoCBzY2hlZHVsZV90aW1lb3V0KzB4NzcvMHhmMA0KPiA+IFvCoCAxMDEuMDYzMjY1
XcKgID8gYXNtX2NvbW1vbl9pbnRlcnJ1cHQrMHgyMi8weDQwDQo+ID4gW8KgIDEwMS4wNjM3MjRd
wqAgPyBfX2JwZl90cmFjZV9pdGltZXJfc3RhdGUrMHgxMC8weDEwDQo+ID4gW8KgIDEwMS4wNjQy
MTVdwqAgX193YWl0X2Zvcl9jb21tb24rMHg4Ny8weDE5MA0KPiA+IFvCoCAxMDEuMDY0NjQ4XcKg
ID8gdXNsZWVwX3JhbmdlX3N0YXRlKzB4OTAvMHg5MA0KPiA+IFvCoCAxMDEuMDY1MDkxXcKgIGNt
ZF9leGVjKzB4NDM3LzB4YjIwIFttbHg1X2NvcmVdDQo+ID4gW8KgIDEwMS4wNjU1NjldwqAgbWx4
NV9jbWRfZG8rMHgxZS8weDQwIFttbHg1X2NvcmVdDQo+ID4gW8KgIDEwMS4wNjYwNTFdwqAgbWx4
NV9jbWRfZXhlYysweDE4LzB4MzAgW21seDVfY29yZV0NCj4gPiBbwqAgMTAxLjA2NjU1Ml3CoCBt
bHg1X2NyeXB0b19jcmVhdGVfZGVrX2tleSsweGVhLzB4MTIwIFttbHg1X2NvcmVdDQo+ID4gW8Kg
IDEwMS4wNjcxNjNdwqAgPyBib25kaW5nX3N5c2ZzX3N0b3JlX29wdGlvbisweDRkLzB4ODAgW2Jv
bmRpbmddDQo+ID4gW8KgIDEwMS4wNjc3MzhdwqAgPyBrbWFsbG9jX3RyYWNlKzB4NGQvMHgzNTAN
Cj4gPiBbwqAgMTAxLjA2ODE1Nl3CoCBtbHg1X2lwc2VjX2NyZWF0ZV9zYV9jdHgrMHgzMy8weDEw
MCBbbWx4NV9jb3JlXQ0KPiA+IFvCoCAxMDEuMDY4NzQ3XcKgIG1seDVlX3hmcm1fYWRkX3N0YXRl
KzB4NDdiLzB4YWEwIFttbHg1X2NvcmVdDQo+ID4gW8KgIDEwMS4wNjkzMTJdwqAgYm9uZF9jaGFu
Z2VfYWN0aXZlX3NsYXZlKzB4MzkyLzB4OTAwIFtib25kaW5nXQ0KPiA+IFvCoCAxMDEuMDY5ODY4
XcKgIGJvbmRfb3B0aW9uX2FjdGl2ZV9zbGF2ZV9zZXQrMHgxYzIvMHgyNDAgW2JvbmRpbmddDQo+
ID4gW8KgIDEwMS4wNzA0NTRdwqAgX19ib25kX29wdF9zZXQrMHhhNi8weDQzMCBbYm9uZGluZ10N
Cj4gPiBbwqAgMTAxLjA3MDkzNV3CoCBfX2JvbmRfb3B0X3NldF9ub3RpZnkrMHgyZi8weDkwIFti
b25kaW5nXQ0KPiA+IFvCoCAxMDEuMDcxNDUzXcKgIGJvbmRfb3B0X3RyeXNldF9ydG5sKzB4NzIv
MHhiMCBbYm9uZGluZ10NCj4gPiBbwqAgMTAxLjA3MTk2NV3CoCBib25kaW5nX3N5c2ZzX3N0b3Jl
X29wdGlvbisweDRkLzB4ODAgW2JvbmRpbmddDQo+ID4gW8KgIDEwMS4wNzI1NjddwqAga2VybmZz
X2ZvcF93cml0ZV9pdGVyKzB4MTBjLzB4MWEwDQo+ID4gW8KgIDEwMS4wNzMwMzNdwqAgdmZzX3dy
aXRlKzB4MmQ4LzB4NDAwDQo+ID4gW8KgIDEwMS4wNzM0MTZdwqAgPyBhbGxvY19mZCsweDQ4LzB4
MTgwDQo+ID4gW8KgIDEwMS4wNzM3OThdwqAga3N5c193cml0ZSsweDVmLzB4ZTANCj4gPiBbwqAg
MTAxLjA3NDE3NV3CoCBkb19zeXNjYWxsXzY0KzB4NTIvMHgxMTANCj4gPiBbwqAgMTAxLjA3NDU3
Nl3CoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Yi8weDUzDQo+ID4gDQo+ID4g
QXMgYm9uZF9pcHNlY19hZGRfc2FfYWxsIGFuZCBib25kX2lwc2VjX2RlbF9zYV9hbGwgYXJlIG9u
bHkgY2FsbGVkDQo+ID4gZnJvbSBib25kX2NoYW5nZV9hY3RpdmVfc2xhdmUsIHdoaWNoIHJlcXVp
cmVzIGhvbGRpbmcgdGhlIFJUTkwNCj4gPiBsb2NrLg0KPiA+IEFuZCBib25kX2lwc2VjX2FkZF9z
YSBhbmQgYm9uZF9pcHNlY19kZWxfc2EgYXJlIHhmcm0gc3RhdGUNCj4gPiB4ZG9fZGV2X3N0YXRl
X2FkZCBhbmQgeGRvX2Rldl9zdGF0ZV9kZWxldGUgQVBJcywgd2hpY2ggYXJlIGluIHVzZXINCj4g
PiBjb250ZXh0LiBTbyBpcHNlY19sb2NrIGRvZXNuJ3QgaGF2ZSB0byBiZSBzcGluIGxvY2ssIGNo
YW5nZSBpdCB0bw0KPiA+IG11dGV4LCBhbmQgdGh1cyB0aGUgYWJvdmUgaXNzdWUgY2FuIGJlIHJl
c29sdmVkLg0KPiA+IA0KPiA+IEZpeGVzOiA5YTU2MDU1MDVkOWMgKCJib25kaW5nOiBBZGQgc3Ry
dWN0IGJvbmRfaXBlc2MgdG8gbWFuYWdlIFNBIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuYm8g
TGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFyaXEgVG91a2Fu
IDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L2JvbmRpbmcv
Ym9uZF9tYWluLmMgfCA3NSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+IC0tLS0N
Cj4gPiDCoGluY2x1ZGUvbmV0L2JvbmRpbmcuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICst
DQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5j
DQo+ID4gYi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gaW5kZXggZTU1MGIx
YzA4ZmRiLi41Njc2NGYxYzM5YjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvYm9uZGlu
Zy9ib25kX21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMN
Cj4gPiBAQCAtNDgxLDM1ICs0NzYsNDMgQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19hZGRfc2Ff
YWxsKHN0cnVjdA0KPiA+IGJvbmRpbmcgKmJvbmQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBib25kX2lwc2VjICppcHNlYzsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNsYXZlICpz
bGF2ZTsNCj4gPiDCoA0KPiA+IC3CoMKgwqDCoMKgwqDCoHJjdV9yZWFkX2xvY2soKTsNCj4gPiAt
wqDCoMKgwqDCoMKgwqBzbGF2ZSA9IHJjdV9kZXJlZmVyZW5jZShib25kLT5jdXJyX2FjdGl2ZV9z
bGF2ZSk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFzbGF2ZSkNCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc2xhdmUgPSBy
dG5sX2RlcmVmZXJlbmNlKGJvbmQtPmN1cnJfYWN0aXZlX3NsYXZlKTsNCj4gPiArwqDCoMKgwqDC
oMKgwqByZWFsX2RldiA9IHNsYXZlID8gc2xhdmUtPmRldiA6IE5VTEw7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgaWYgKCFyZWFsX2RldikNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuOw0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgcmVhbF9kZXYgPSBzbGF2ZS0+ZGV2
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmJvbmQtPmlwc2VjX2xvY2spOw0KPiA+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJlYWxfZGV2LT54ZnJtZGV2X29wcyB8fA0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIXJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0ZV9h
ZGQgfHwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldGlmX2lzX2JvbmRfbWFzdGVyKHJl
YWxfZGV2KSkgew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tf
YmgoJmJvbmQtPmlwc2VjX2xvY2spOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKCFsaXN0X2VtcHR5KCZib25kLT5pcHNlY19saXN0KSkNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbGF2ZV93YXJuKGJvbmRfZGV2LCBy
ZWFsX2RldiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJXM6IG5vIHNsYXZlDQo+ID4geGRvX2Rldl9zdGF0
ZV9hZGRcbiIsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18pOw0KPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9ja19iaCgmYm9uZC0+aXBzZWNfbG9jayk7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgfQ0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrX2JoKCZib25kLT5p
cHNlY19sb2NrKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShpcHNl
YywgJmJvbmQtPmlwc2VjX2xpc3QsIGxpc3QpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IGlwc2VjLT54cy0+eHNvLnJlYWxfZGV2
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogSWYgbmV3IHN0
YXRlIGlzIGFkZGVkIGJlZm9yZSBpcHNlY19sb2NrIGFjcXVpcmVkDQo+ID4gKi8NCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGRldikgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGRldiA9PSByZWFsX2RldikNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBjb250aW51ZTsNCj4gSGkgSmlhbmJvLA0KPiANCj4gV2h5IHdlIHNraXAgdGhlIGRl
bGV0aW5nIGhlcmUgaWYgZGV2ID09IHJlYWxfZGV2PyBXaGF0IGlmIHRoZSBzdGF0ZQ0KDQpIZXJl
IHRoZSBib25kIGFjdGl2ZSBzbGF2ZSBpcyB1cGRhdGVkLiBJZiBkZXYgPT0gcmVhbF9kZXYsIHRo
ZSBzdGF0ZQ0KKHNob3VsZCBiZSBuZXdseSBhZGRlZCkgaXMgb2ZmbG9hZGVkIHRvIG5ldyBhY3Rp
dmUsIHNvIG5vIG5lZWQgdG8NCmRlbGV0ZSBhbmQgYWRkIGJhY2sgYWdhaW4uICANCg0KPiBpcyBh
ZGRlZCBhZ2FpbiBvbiB0aGUgc2FtZSBzbGF2ZT8gRnJvbSB0aGUgcHJldmlvdXMgbG9naWMgaXQg
bG9va3Mgd2UNCg0KV2h5IGlzIGl0IGFkZGVkIHRvIHRoZSBzYW1lIHNsYXZlPyBJdCdzIG5vdCB0
aGUgYWN0aXZlIG9uZS4NCg0KPiBkb24ndCBjaGVjayBhbmQgZG8gb3ZlciB3cml0ZSBmb3IgdGhl
IHNhbWUgZGV2aWNlLg0KPiANCj4gVGhhbmtzDQo+IEhhbmdiaW4NCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldi0+eGZybWRldl9vcHMtDQo+ID4g
Pnhkb19kZXZfc3RhdGVfZGVsZXRlKGlwc2VjLT54cyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rl
dl9zdGF0ZV9mcmVlKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldi0+eGZybWRldl9vcHMtDQo+ID4gPnhkb19kZXZf
c3RhdGVfZnJlZShpcHNlYy0+eHMpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXBzZWMtPnhz
LT54c28ucmVhbF9kZXYgPSByZWFsX2RldjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChyZWFsX2Rldi0+eGZybWRldl9vcHMtPnhkb19kZXZfc3RhdGVfYWRkKGlwc2Vj
LQ0KPiA+ID54cywgTlVMTCkpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzbGF2ZV93YXJuKGJvbmRfZGV2LCByZWFsX2RldiwgIiVzOiBmYWls
ZWQNCj4gPiB0byBhZGQgU0FcbiIsIF9fZnVuY19fKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcHNlYy0+eHMtPnhzby5yZWFsX2RldiA9IE5V
TEw7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoH0NCj4gPiAtwqDCoMKgwqDCoMKgwqBzcGluX3VubG9ja19iaCgmYm9uZC0+aXBzZWNf
bG9jayk7DQo+ID4gwqBvdXQ6DQo+ID4gLcKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZib25kLT5pcHNlY19sb2NrKTsNCj4g
PiDCoH0NCg0K

