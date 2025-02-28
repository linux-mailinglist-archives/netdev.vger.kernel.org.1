Return-Path: <netdev+bounces-170784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C642EA49DE4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E633BE924
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26548274268;
	Fri, 28 Feb 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O2BXPPzG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261F27560B;
	Fri, 28 Feb 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757438; cv=fail; b=HwSiDGBq+iNn2AIensoMgefCIMhGKKn8MyBVq/OSa/b7Vj8e/3KUTvDq/J4Q+UoVc6yhUt9iGmRrIbsYu6B5n1ebWHSP3ittOiLTQtO2jYOztxwzX+4NCxIZOSROVmuPlwlfoD+FgcXhdx79Yonn8dqM4Oi8TWDFzwokqcRDyPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757438; c=relaxed/simple;
	bh=jMae/gS9aeJVl7V1scGl8OvqRldw+rUPbF3Vv9oEoRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qirj6NEN921T7G/7YgUAzS3BUe8wmfYEVWRv8ax7oMOEMTPLQouZp/R2QyB9ToXVcAl1tQom4UcYOXB+ZtPaSCfsFhfDcmz3fgVhrlGMbmc8Q7oT46HHijkuFt5yBs+yQ55YufSio5jEKrY0eVh0Smje/Erb3dPOuPTXe97WwvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O2BXPPzG; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUtNzl6INoKmQL5VIWM3gJ6gLZgognELyXYNn+Aq91O4QaNP2vaStsJPnppo1bXsZaQ28+wfHhjMN6guuBdwgFxOQkjLBmUgDOulCvXUrkDKM8OB24kMfxnVCiLhejSBx/VkohQm/WEyUvZxz24F1Vbf+pCVO9EeRewhvQUtSaPFrwB050yzT70ZJnJ6oAxIkSHy8D5QP+ah2ixj5BbvB9LAY/ZsQ/3a9ZPNpMSK6owtxaBniEagV8q90YVYWHB51GwW08TNqQvWg1WobxEKLQrAXMGT9Z//pbZRjCPwZPsD3bxWKKd1UXxGJ/jZqxeofJqJT3jUeuWZISxMAp1ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFf5kKNt/3TV4SrjeVtO+pq5d7vnY1H+D8rSh2YZHH4=;
 b=ssEB0H9eqB8hgWTge9VukhuJCQTEeOMYmvc4TZ26KO2parEkMiCAGlsh7ob9uRGwC2aSDvx88FqCVqZqNeXdpD4s+6kQlOAGX3NtbV7loENP/fbOuB7UoTSlUowvBTCxpMLFB6AgdOmftcdW9T454tAnLntLz82MXK2L0HaVgI4uEoV9rOxpni46puksyK2HHgi4M+tw0r1EoL4XGAKcK3gt2rj7Uki9l/4UVtylpL3HoaSTux9sEcvviY1LnhJEhJDum7CO974a7q41RUu00KzE/elov1GowAlrmj3uiu0/ickTgaZal29ZcW4QSqoTJs8gWvW2kUoWsmS24AEkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFf5kKNt/3TV4SrjeVtO+pq5d7vnY1H+D8rSh2YZHH4=;
 b=O2BXPPzGqkrgKM/y+MKM3KNJ/O0SB8FMr/w4UGBgONZD443pjvIy54mr2pX0/yB6D+bujULn4JJ4ameY+45hA3Y8R+SdUYKYKCIYD/r5jmOd/Rk2ezM5zYAl3+g8aVfWnhef/V00q3ZuQKgjw61xi1bknh9fZU0j7XztIlR/4wnSiLxYnh3CeX4U3OAl2kfhjgd6AdVjYZaFoKfa3krEgXxK1FDYvSkn6UzFFvVOJ76Od4dpgj98L/jV6NuIubF10C76D41OS7id4W9kIoYvx/IVWlKwAhRDrvlkaRbEmUUQwW7mg+E+SajWkxfIBxNg/fiDNEkVVOYiLhErXDP+dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:43:52 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 15:43:52 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH net-next v2 2/2] net: phy: nxp-c45-tja11xx: add support for TJA1121
Date: Fri, 28 Feb 2025 17:43:20 +0200
Message-ID: <20250228154320.2979000-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
References: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: db1fd4b9-905d-4e39-6ca8-08dd580eb387
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUt3b2pqajg5YnU3ZDlZUWtMMi9SZTgwU1VTMDIwS0VWcjdrNUlWSDN5dURY?=
 =?utf-8?B?ZEl0WVNDcjVtTkd6RG1Ob2NxbEZjdHNjKytaRGhWM2JYemRaYVhsdnVKS2xu?=
 =?utf-8?B?Z3FpR2pWdHJtVUhjU0lPMFRTNEJWbTM4QlNWRm9LRlBiQmRhQmEzN0JUNmVo?=
 =?utf-8?B?YkwrdDNKT1BKMytCZzBaOGZyb2Vkc2llT1FrTEt6Z2lPZkpFNmRUQllVSDVn?=
 =?utf-8?B?V3Uvc0ZyR290cEdScXJTd3FuOUxreUpqNUhQOG9Ta0R1U0dTSE5tay9WMXVM?=
 =?utf-8?B?azFKQjRsdWowSmdSUG9DUG4zZVlPeEpDWFNKTXhvQVdFamI2QmV2bHY5WS9o?=
 =?utf-8?B?c2JYNFZmbUw4VGZxc2RtZFRCUUNkMlFCOFZzbFJvWjdHeEpUUmw0alNvM0Ev?=
 =?utf-8?B?UkRVT2lkMldzTXBPc3RxUTl4dkwyTExqZUhxSVlad3ZBby9wNFJ5bVpBMzUw?=
 =?utf-8?B?YUo3WXJ6dGhxeDIvdEVlbGh1c0kybHhkamlnNTNmZU9CVzUzd1RwVnRjYytl?=
 =?utf-8?B?Um93Sk04dUw0WlFWdllTTnF2Mi9ZSVltMlN4OUNNWmJIcHMwenpVWlc2Wk90?=
 =?utf-8?B?a3VWc0RtYjh1ZFU1eG8welB3cmhhR2ZhWnJlS0VTS2lNbHN5MnB1STJrZWwr?=
 =?utf-8?B?TkhOZ2xsU1BJMmVKWVN2M3ZrN0RJaUx2bXdyTTlpWWxVZVRNYUxhTzdCOTJB?=
 =?utf-8?B?ZFZFeDFqNnJjMjhwZUI1cUlqN2NGU1lOODJid2pYcm5VK0FkaHhZc3NiKzZt?=
 =?utf-8?B?TGVBZExBaFpqZFJTbWQ1Yzg5a2pQeDNwVSs4OThmRUZxT3Y3S3JSeno1Nm9I?=
 =?utf-8?B?RFkraW54OEpyUi85ZVNLcWNHd1RwYUJwY1hPcHNJOUtqSFRpd3lmSjM0TnRh?=
 =?utf-8?B?aGhKRTZUMWpiVnlOd3ZKM0pQOGwvR2w3U3F0aU91cHZBM05QeUhSQVdqZTZY?=
 =?utf-8?B?SEF2TVFDRTVqVTZUcXJxbnlCUERUTHVHcmErcVlRV0VZcFkxYVE0ZGVoSkxD?=
 =?utf-8?B?VGdJOTI1TURaZjVFYXY5eld2Wi80S2RMT1d6eXVkRHI2djZiL2pPNDBNTHRw?=
 =?utf-8?B?M2VhbWxNdlZYSXA5YWpRL3UxK1R6QTFiUG9HQXZiQVpsTGY0ZzFlZnQ5RVIv?=
 =?utf-8?B?SW5ZRUx4WEFFaUJJV2tkTk5welRXdVpibTBLRTB1WU05SEZHYjEvSWowWlZD?=
 =?utf-8?B?SnQ3c0xnMWdRUTJRSjI0Unc2Q05ZVmdGWURJd3VjdU1xaU5rOEd2UWVNN0Rk?=
 =?utf-8?B?bTFLbHg3alF1OStyODdqaVFlcjEwaXRHb1lKclphRjBCbk9JNmI0cHhhdU82?=
 =?utf-8?B?Z09sWFdEREpWQlcwSjAxSlo3RjNiam8ySDJqN3hBWG1mR2hqcVIrN3p3T2tx?=
 =?utf-8?B?K3dpS1ZKMHhyajI1bW9RM2hFUFBpZ1RtYmpmNE5WTkh5RDJQWU04THB3QndY?=
 =?utf-8?B?VHlyUnMwUkx2ZXZ2Z014Rnc1S24za211VEsweW40S0hqS01CRGJPQ1BEd3o5?=
 =?utf-8?B?MnRERWdBWDN2aVNpemVwMmYzMmJHSS9FbHZrQkxiK0lTQVdwQUlQOW5QcGxW?=
 =?utf-8?B?QkZUOUpMdnFHdXlwZ0NLRmN5ZlhDMkk4MUVjWDZqR2tncTZtdVI4NXk5UmI5?=
 =?utf-8?B?aVJsSEVlS291eENnMmNlMko5Rlo5dDhoeXFEUmM1SURWbWdvak93UmpIdGox?=
 =?utf-8?B?WUpYbldUbXZncHdqMGRDajBPMzJqQnIySmZRNElPVGpLZTk5VzBvaE5ZazZt?=
 =?utf-8?B?bFNYd1d1SUVGYzBNU2dhMXVrS2FwU0NuNFZyZXZpbFBKemg1cHZWbCtaOFZw?=
 =?utf-8?B?Nlljb2RqQVllTnBxRjN2MHVLcDMrUkJucXE4d3hyQ0E5MVphYmtuYk1mNTh2?=
 =?utf-8?Q?+nD/n6DKllzWA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFob0pYZmpGWDgzSHl1NlhBemtYWkNFNGRsc3hYbHlSbjhMNWRrMlN2bzVu?=
 =?utf-8?B?Kzd4Zlc4Q1RHVzVhMUE1c0NUTWZodFVYNlpsR043anZnNFJpUGtVbkp0dU5o?=
 =?utf-8?B?QU9Sd2MrUkltUG1NbVhiVkV4eGREZXRmUzA1cEZzZjNwVGNUOTBqSTNKcGFr?=
 =?utf-8?B?S0xmcG1sZUxMYWV3Z091SFVlK09IajN4cTZSSzBTUVhXWXpZODlwZE10YWFB?=
 =?utf-8?B?aVJqRGcyS0Y2QXVRY0RUMkhGcW0xR3g2bkh3SzFpR0FPb0pzbUlnaVdXU3Y1?=
 =?utf-8?B?V25qRmtLYk1pQWFMUm82MVVjQUtZKzIyOXJMOGVWaDBoSFExRFlVYmdkTXF4?=
 =?utf-8?B?ZmR5NldkWlJneXo5dGtiaVJtNmNzZVVhUnFUb2d6ZWJHZHlxbGZBbytsdXhX?=
 =?utf-8?B?OE5idTQwSUNRNVVsR3VrRGdpR1RTeW9HaGNmUCsvQkUya0hYVXdMd1JBZWx4?=
 =?utf-8?B?Z253eFAzMUFPNDM2YXBaVm5Od2xJdUVWaldqK2gvTno0RG03K3hTVWFaaG9T?=
 =?utf-8?B?RHFRNkhNNTBSVlVtVWt6R3gzK3RnSEVmVGpCMDVVY2dMRWh2dTJ1WFRLZVBz?=
 =?utf-8?B?V2FXaFFWNnF1T1huK2ZoOHgyM3NZdDVHWXBXRGRsR0t5d3dGS2Q4YjVGWDF5?=
 =?utf-8?B?YStRTWp3eUNVSjdLdlJaMjdGTHlpSGRwdlEwV1FZZzVZWjJmUjB2a0Jhdklr?=
 =?utf-8?B?UUZ3RUZIeWt3SlpMNGlrSTVlYjdmeUVjNmVQRm5QSU85ekJnbDRDcDhkeUJH?=
 =?utf-8?B?R1ZUcmVsUmRhRlpNV0djTGJGZFFjS29naE8rR1FQNlozWngzd3pOSmw1S3hn?=
 =?utf-8?B?MWd6cVlEM2dqUHlEVWx1Z3hCRUczWHdITWtZZ2RiSUttdzE4aCtiZE85MHVv?=
 =?utf-8?B?OFNyTzM1STd4M01hTUI0TDV5RzdzLzlZRlBDUGREKzJ4Rk5VdXdrWDMzN1Jz?=
 =?utf-8?B?NUtVcS96dGtFTzdJczh0YWpzME9hbDFDQTRRSVBBS2prYnY0Q3g3QVJKUW9m?=
 =?utf-8?B?clBhNy9yclVVUjFGdmJOODJ4cjkzY1RoTEE0NDk4dEFseVRCOU5lUjhlbmVP?=
 =?utf-8?B?YVNTeW5OeHJtZVBNRXNHeEtveURxeHpEWU00em93dGNxY3ZUUmJDV3lveWQ2?=
 =?utf-8?B?OWsyYXUvWStDSmhpdWd4dG52S3RsdkZOcWt1dGUvVnpXc0loWTVtSXlDSXQ5?=
 =?utf-8?B?V1lLZmVnbyt1TTdaaldocy9sVnJ1eENNWVVTeU1pWHgvRzlCSytCa0RKcXdt?=
 =?utf-8?B?cUIxc1BIY1dFV1V2enJjcWNRYldWeFRsN3NpVFNnbSswNGtIZTIwc3ZOSDly?=
 =?utf-8?B?MlpJU3hNTnFXakRHY3BzMGhNcFJHdytuNFcva0lLckd6SmNWWENvTFI2RlFi?=
 =?utf-8?B?SkZUeWprcjRRMXJ3Z3NrbUlTc083R3BGeVQ0SnByZy9LaStWb2NTM2gyQ2h5?=
 =?utf-8?B?cHM5SjlLOVNKWEtRbTlUdUVmRzdVY1UvQktOMkNjVTJvTnd6REt3RzBzV2lL?=
 =?utf-8?B?a3Uwc0wrdkZMU1ROeVNyUEhDeEd2WnJBcnJtTXg1QzArVWJTVktzaWJLOTVF?=
 =?utf-8?B?QjFYY2VUWTZlV0tpTWJRa2Z1UjZkMDJMclVjOWRvRXB2aldVOC9uT2VhNkRQ?=
 =?utf-8?B?Y1AvUDBTQ2xvajB3QUhoQklodWxZUnhuMjNkeHc1VXEyYVJwZ1lWSmJNcFRX?=
 =?utf-8?B?L1dzZ2o0OWluWlJuUEVRRDhFcVNDYWZWS1NpdDVsYWFheWFGZFMzZnViR0xm?=
 =?utf-8?B?WGZUM1F4SkZMWm1aZG4veTN0UnJ4bnVDR2dETC9lZ0Q4cHhScjNTcUpzb3Ey?=
 =?utf-8?B?eVNIVitLdUk2T055dnhEQU5Ta0xwTzVTeGFxUHBtV0NvQllpMGdPS3lib1Jv?=
 =?utf-8?B?MXZOM01nc3RMVFE2Yk5MRnZGNXBwVHNJN2lNR0crNnM4UXNIemdlaGVtenRB?=
 =?utf-8?B?c1A2QUNmQTVzczRWd1RKVkk3ZWR5RWxOQ084VkE1WU54ZWwvRy9VdDhsd2RQ?=
 =?utf-8?B?NkpOaEwzSVJmSDZXNVp5MGxzb25QbnAxTUF3SlRodW9FVjR1YnVDRmtEVzBD?=
 =?utf-8?B?R3J0aldGN3lIMGRvUGZnMEorbk9DbTc4MEhuaU4vYkNGdTlOMjVuWU1VaEJs?=
 =?utf-8?Q?5ALxvv1yLmWEPVahzfm8Lg/DP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1fd4b9-905d-4e39-6ca8-08dd580eb387
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:43:52.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10Waw7oJ1oOUwIu2nwi3Qw2ARWbst7AfrL3N7gCTilviXsSc+Etc2Kr64vpAa1qyJ+x//EjygFU06jolEfeT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

Add support for TJA1121 which is based on TJA1120 but with
additional MACsec IP.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/Kconfig           |  2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 40 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..d29f9f7fd2e1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -328,7 +328,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on MACSEC || !MACSEC
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
+	  Currently supports the TJA1103, TJA1104, TJA1120 and TJA1121 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 4013a17c205a..63945fe58227 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,7 @@
 #define PHY_ID_MASK			GENMASK(31, 4)
 /* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
+/* Same id: TJA1120, TJA1121 */
 #define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
@@ -1914,6 +1915,18 @@ static int tja1104_match_phy_device(struct phy_device *phydev)
 	       nxp_c45_macsec_ability(phydev);
 }
 
+static int tja1120_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
+	       !nxp_c45_macsec_ability(phydev);
+}
+
+static int tja1121_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
+	       nxp_c45_macsec_ability(phydev);
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -2032,7 +2045,6 @@ static struct phy_driver nxp_c45_driver[] = {
 		.match_phy_device	= tja1104_match_phy_device,
 	},
 	{
-		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
 		.name			= "NXP C45 TJA1120",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1120_phy_data,
@@ -2055,6 +2067,32 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1120_match_phy_device,
+	},
+	{
+		.name			= "NXP C45 TJA1121",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1120_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= tja1120_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.link_change_notify	= tja1120_link_change_notify,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1121_match_phy_device,
 	},
 };
 
-- 
2.48.1


