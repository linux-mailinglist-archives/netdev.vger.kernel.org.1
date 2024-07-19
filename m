Return-Path: <netdev+bounces-112254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB5937B64
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357322819AC
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B3146596;
	Fri, 19 Jul 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdR7dlBY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F7146592
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408279; cv=fail; b=q+qEMk3h+RSG2akeo/RwZuSysp7uwk/puVn4+BFp9IaV4+6ufwLsvNDWgrG6PsmZVFdHa3ajfzLGWABH3DjRwb3gPLm8d/Y6jIrXZ+ssht0ujJc7ADb0NeysSBJ0dy77roXVQDLIaYdOWOWssSvswjhZ7FwUrM36RtuSfJLZjT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408279; c=relaxed/simple;
	bh=4lfMLbqMEFYlvnVw3xcxBk1gqZdP3MH2C7vU9FsCd54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AkY9vk5XeasaHxdBzePDtYoV7Um2Bh1LS3et34z91fu2/nJbqWSKxKWAY7VUxqn9it06l7oijQ6lpAipDNqftepMLQG6GQpMuxHeoW6byYzH2FiQcik5qkLBUcsAASahSxrfXW+KusvLhfEzHbOFEm5+KEIlrAaGTsiPZtWsWwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdR7dlBY; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRkbpSRI+E40TlilQaoFqnZNxpCUYOmDuW2oOwy0FEXQ0VYzIb4idV6pKNrFdKA2yPwzz4GHqrfZVmjKg10Oqw02xLM4GfZifLy7wIXHOCrRz/+rcSABEMJUzg2IEAYXMB8nV+cLcvxO//ABdRF7Mf4uznYIm1RCQRCl97bYFzLeUrT8Fz1zua8uC4HMpuoO5vHis63cTyY3HRDiNdAZII2nLQz3sFkVBDuaZXi/cPaqocLTLOiosqTx/JvduXXwMCPLuQMg+b8gMQ0iLOlCm6qUdlg+cETu7Zhxz2qXBgFeIbXG5niES3+SWHTlpwxOnlYlbpJqVJ8Imcqic37IUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lfMLbqMEFYlvnVw3xcxBk1gqZdP3MH2C7vU9FsCd54=;
 b=VKgWCNwaCEFITPD8VKIhIddfm0DBi9oLxl4CMNmuIXBbjdu7z1669/Jk3TGyF7krL02x1djFwMsNnR2rK2rLDpNK/MwgwmCl2XpYh/sPXjtY4mwP5BdYEYMTP/z/DcPCUOItlV4dQ28SPVGqs9S6pvb+8mCZ4ccrO/dX09Ev1zFnUUXXgcQPdQEY/MWbt/qFdWOYXmZv4Wfl9V6q2CTAzYzVb+CvdbwnZmDeQGflEgwiEQ+hvjFrp3HN8qqJBQceURilSgcInXi+Wka2sVj1SF5X8Mpvm+ahN9C4W34qMYP3azK5tsMv3A45bd9InprfZ8AsFrRKI/zFODAaLR/3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lfMLbqMEFYlvnVw3xcxBk1gqZdP3MH2C7vU9FsCd54=;
 b=pdR7dlBYqnIqdl+7PzSs/WbKrSeBELCg8UzjqYKcVKkdR0X7ciGPlSqziIoaNGQFkxdfmdpL397atM63MguXlZijMLsxlqz9TDow/6R5dty9lOP/z7uQTq4pULI2xVoRBpTE4ooskkytZeYBh4HLr1lxlax2hLMNuUiR+jDSb9Op84BMO/zx3hmPi7GnU96jnWUN4sUIYPGFQP0PytB5/0yMZnK8//mQH0CDrVL2LCa9lNOiAiMg7zBF+nfStSJkV3/B1g7SdvmFVEnBoXr5ii3J6uf3ys4sxSszbP6bzvmEe6mGAZuTVLNB7qa+5p9MZEj7d0RUdxWIwoAaJyixig==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Fri, 19 Jul
 2024 16:57:54 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:57:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "leitao@debian.org" <leitao@debian.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: mlx5e warnings on 6.10
Thread-Topic: mlx5e warnings on 6.10
Thread-Index: AQHa2D4+JbNH/I9pAEC7H20JEKF92LH8UsaAgACJqgCAAWyqgA==
Date: Fri, 19 Jul 2024 16:57:54 +0000
Message-ID: <80940c9175a29d9bf47d344d195fe6fadec36a98.camel@nvidia.com>
References: <Zpet0KnLyqgoPsJ4@gmail.com>
	 <dad86bed4c22fcedbd280b4a5a5ad8e8298419a5.camel@nvidia.com>
	 <ZplpKq8FKi3vwfxv@gmail.com>
In-Reply-To: <ZplpKq8FKi3vwfxv@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|DS0PR12MB9448:EE_
x-ms-office365-filtering-correlation-id: 36bd6072-407e-41d8-8308-08dca813ee9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1VUeUpKYTJsOTFVTlVXZkN2WXFndEsrSFRtUFBJemtZVTNlQkJwUGZnT0pt?=
 =?utf-8?B?cnJYc0k4SDRNZjlyd1l4aXVOdDZnLzZNU0dyQ3pEWElndEs0K1ZoTmdhVndE?=
 =?utf-8?B?TVJWT2owbitFalNEVzFMd0J4QUxaRWZlekRMM095VnM5MFNUM3NYVjhvcHZW?=
 =?utf-8?B?YXl1c1Z6S0F2OG9uTk5hZXFxSENUWm5RUVlFWVNSdEt1aTdNNDNFNGlaK2lu?=
 =?utf-8?B?Q2M0aW1QalcxZFBHWjZhcytNNVQ2ZVRPMEpML0pDdWxFT0ZHR0RRcHVlM3Js?=
 =?utf-8?B?R3RFS3VmVkZpRWFaWnNuNHErdG9PdmdPSy9uQkRseU9YSDZVK25wcGRkN1Mv?=
 =?utf-8?B?dThSSURKdWdBSXMzNUluZmRrS3ZkLzJjWnZJelB3NVZwRFF1UktIcG1JQlZI?=
 =?utf-8?B?eElFNUxmQ2NSblJnRzNCVFZLM0JMb1ZVVGNmbXFibW5jNHFUNFFrd0lOSWR0?=
 =?utf-8?B?Zmw4S0luZCtaOTgySmdFcFFIUnAxMG5VbEpwTHh4UnhhaVFBa2VnWmVFY20v?=
 =?utf-8?B?dVpsdTJmM1Q4UmROYlRsSnFSS1VZNEtqN3l5SElyYkxESUVrNkt1Y3grdVpa?=
 =?utf-8?B?VWY5NTcwZFh5RHJjMWhPTjNZblNvbEd3OElMa1h5clJqZlpIYUJReDgyODVR?=
 =?utf-8?B?SEIxa043WkQrWHN0T1ZGc0dwalhoYUpaaVZZUEtjaU5GWjJETWRSbUd4RkVa?=
 =?utf-8?B?ekp6cG9rc041dE11Nlp4Mk1nUml4cldMQXRFOUtTcjJ5RmY3OEFXQ01PWTk1?=
 =?utf-8?B?aTNkajNuNXFpbzRSZzlhTzRRQW5rZ2VFbThZWGRtb0JBM2NsRnhtaXluTElT?=
 =?utf-8?B?MmhGSDhvRnRmK21BUitzVWNDZlBWQi8xVk5tdWRMdlN4ZHZjbjh5NkVzcTN5?=
 =?utf-8?B?UW92eUZOaElvSVhvS1JxMlRzb21TT3dKekNKSTdjcVJ1ZThKVTh6cXJiZEla?=
 =?utf-8?B?ZTdSamw5VHh3T2g3RzVHcE04Y3dXcXA2WEsvdkoxY21TSlQxWUJ3MWI4ZHcy?=
 =?utf-8?B?MnNqZmJOamgrMGxrR3lvQWRKVjQ0bU5jd1MySTNrdFlDbFdWVXFpS2ZlMFVK?=
 =?utf-8?B?S0xqbnlHb2ZFK3NZdFZ6Mld0RmFGOUxOY0NMeUYwQytaMHNsdkI1T2hYVUtz?=
 =?utf-8?B?T09vSGZvZi8rMmJycXBkcW0zVmVZdld4ekxaRC9JRFFhZ1hYQzF4NHlHT1gz?=
 =?utf-8?B?SkhSWUk2VGhYVzZyM1pITWNtNXdrMVBUdm5EMkR1dXg5cU1UUnNwYWEzMjhK?=
 =?utf-8?B?dzJpQVh1YkVHYktTalFSY1Q1TVV2N0F2VkFnRlBoOHg3bk4zOENlcEduR0tn?=
 =?utf-8?B?NGVQZjVLOE1RWU51eUZzZ013NFduZzNiY2J6cGx5dDBFdFh1QXprc0N5Qis1?=
 =?utf-8?B?cFlkUVV6RkZUMm9sdXVjcno1bmhSeU1NTXNBdUs4NmM3bkkwQ3FnOG5ZQlpn?=
 =?utf-8?B?aE5HT2pScVpDbyszK3NEY3JjWWQ4NmpQVFhIaUl0YmNZRXdrS3VHSmJ5U05n?=
 =?utf-8?B?QTdZbTRjMkd1YmtUbEtldkF4R25INUtZQmRCTjNmUXZsSFVKZTJZRUJ4Z1BN?=
 =?utf-8?B?T0kxUnVuZXdSQnovOU4zczNCRkd6QlBIOFZ1WU12ZVduamxVQ3M1WlB6R2pr?=
 =?utf-8?B?MWk1ZEtEWkdVU3FjWG9yTW1vekxiblhYUi9jR2FWeUN4aTVWd0dmcmVCNWtP?=
 =?utf-8?B?LzFsMG5RN3U5dVFLRGZCVmRTL0RBVThlSWsyUU80bldiSjdkMzVsQ3FGRURk?=
 =?utf-8?B?TUswcytoWWxmVkIyM2htcW1HcyswUHo3a1FTdHAxb1FFOWo0ZVVSZnBEd0xZ?=
 =?utf-8?B?bHIyL1FMdVlQRlJxdDJlU0ZjTnRpVHZXaE5mZVRXZWUwZ0c1ZHhndXFYYmpL?=
 =?utf-8?B?Wk5nblFGbnJobDNXK0FEcWIxQ3ZHN3RlKzBObXZoQWZVT3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWw4SmJxajcxQmE5ckVWWE5zNS8zTE05Q0kzTDVEekRsUTk4U2NJOWliYk5o?=
 =?utf-8?B?L2JINGpwcldSeno4bjIwOUlraXVOZmxIREhpdVBjNlphTGsrVVhSOGdmSGtX?=
 =?utf-8?B?THFxZEQxNXN3TC9zSU1yZ1ZqYVR2eHc4N05hWjJaYzNMbzlLcW9JK0tsSFp1?=
 =?utf-8?B?RGFGSTVwdjdOTW5BMEhZbkpZS2pQOG13eTZ2YUNJaGdsV2ZNWjZuOHJrWWcx?=
 =?utf-8?B?bExzS0RjL0pQaEZTQnVLd3BGbTNZNklEQmtxMVlYUzdWM1lTbmVaWjRCVHRM?=
 =?utf-8?B?RmJRc3ZOL0U5djUzbmJDc25UZ1V0VGlMZjF5c1B5L01wQW5NK3M4MloxdEtD?=
 =?utf-8?B?a21wODdUYUhJQ2o5OVJoL2hESUx0YXQzUVlZb3VxeGsrSlllUjhmRzRhSnJk?=
 =?utf-8?B?NTU4a2FLWXdZUFBtMXJCSU1XbndHSWN2ZzFoZFh5VU9SZFlwL0Voc3NoalBZ?=
 =?utf-8?B?SEFSOEJrMWRXZXlNQjJCUFpiVTRBNUhZd0hqS3N0cFZxV29sVmJLVWJ6SFd3?=
 =?utf-8?B?NjcwbmhmMUNSYjZmdzZrNndXNjliQWxLQTVuSkFkZVJ4RTh0VjhyWWFrS2hC?=
 =?utf-8?B?UUc1TXMyRTFuZDRDclprUzhWNjNyUUdOMDBnKzFpNDdBaVhONmFHYWN2aTZQ?=
 =?utf-8?B?YlQ3V2QwaENrbDVuQWhqaUVVSE5XWnZlUzRBVnRsOHBkZ1d1Rzk1emkyRjdw?=
 =?utf-8?B?cHBaRTlkSnBCU0dpYk5iSFJsekNLZDdsL1poaGVkVmJNMUNxd2RGaTBsdVZP?=
 =?utf-8?B?d0NWM3RJQitaTEtPK2dKdDA3N3ZBTFFMVWlIMjNKZm1xM0VMb1QyRGZJMVk3?=
 =?utf-8?B?UTM1L3FYd05WMTBMaUdUc1luMTE2aWtBUTRVN0YwbzVjYXQvSXozOTA0NmtW?=
 =?utf-8?B?SDQwNTh0Z2ROWFl4M1lWM281Q29QQ0NUT0JRQ0p1RFAzeVN6VlltaHo4dFlH?=
 =?utf-8?B?OUd2SGw5YjJmNFBtaGd3TTk0a3RSb2o5Q2pXSnRpaFlCNGdTYytoZnh2QkM5?=
 =?utf-8?B?TEZkYzlxRWVzczlUcWtMQWdWZVoxZm9nc2FGclRaNFFNVWJpUC9lcGZzR0ww?=
 =?utf-8?B?OVVzb0YvaU83dElJWDhONFNzUFlwYW1EWi9OaG43aklRaDR2eEFNeWt3STA0?=
 =?utf-8?B?YXNYbXpTMEViQVE5bm9JS09DeHJlZDV3d0YwNkVIUENRbkNhV2dUMjIwb1l6?=
 =?utf-8?B?eHJGNVlpMkJDcGoxa3F3eWJmWkxjK2pKR0cyNm9kTUpKTTJmTUZoanBqd3lz?=
 =?utf-8?B?WDVza2s1VEc0cDA1UWxVMVBleUZpcHBKQkNpOTBnemZuUklKUmt2ck8xK3lL?=
 =?utf-8?B?bEhndUdlWGpUY3RCZ09tTzdKMWdzWUpGNDRlYXMvMXc2aDhuditDMEhNZm1k?=
 =?utf-8?B?NVhZTG9OdWI0VE1xQXZJNGkrb1gyZEpnUU1ydmJPMEJicU1vTDJGT203Skxi?=
 =?utf-8?B?cm9wbzNzdnkwaUtLQ29qbE16UE5uaHE3N043MFJhT1BwYzB2QUIyTG4vWnRx?=
 =?utf-8?B?RTMyVWs3SWtGUXhJaDM3Tk80a0RsaGRrRUI4eHR6NjlReFFrR3Q2aitDZDVi?=
 =?utf-8?B?dkpIcnFnQnNsSGpvd3hvNHArMlhoZ2hXcnZKSkZTMXVMYVdHSVZ6eFZxMklO?=
 =?utf-8?B?S2NJaFV6WE01dlQ0STNRZUtMcmRmVnZzNXpRazU0YkxXbTdLWHhVUEYwWXRo?=
 =?utf-8?B?LzFTdkMwbkF1TGxrWEEyTjgxMk5zT0tCNjIvdk5DNFIxWUtMdlFBR1ErVlMv?=
 =?utf-8?B?T2hicDhsdkxrS3JDdlFjbnp0VVNCTkwyZzVlY3FRbDZrMTQwNnZodHFnV0Zw?=
 =?utf-8?B?ZmhXZytXRWo0c1JTNHdBak83NlhMTDdHbXhZek1MZmpIUERLaVpmcGpJcUJG?=
 =?utf-8?B?TkNhbUVhb0lRQXE0TzREUUV3U0I1c3NIMXI0ZzU2VVBRMUp1V3VQdllzK0Qx?=
 =?utf-8?B?Mk1XWDl6VG8yTjFSYlZoZWlWRVNENFRRa3oxcEtURmU4enBCZGtGT0ZyUGhh?=
 =?utf-8?B?MEJyNDlsd25kUFAwZ0FLbTM3azdCOS9NYXM0U1ZIZXg2V09ENDRWSFoyTnhY?=
 =?utf-8?B?S2M4c3NFd1pGLzlQUFpLZjVhVFlreUJBSEFvblNHYVF5d2VnbkZBc2xUdWtL?=
 =?utf-8?B?UjJpVzFGeEF5SWtYSStDeENWcGdLaEhTVkdxQllIR0YwbVE0S1ZWMVczQ1ZT?=
 =?utf-8?Q?mDCKE8kEW6dfLM8GlbVobswflkfMzctIxvJ8ZL48la+7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA307729D523441A2614B0543F52750@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bd6072-407e-41d8-8308-08dca813ee9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 16:57:54.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NakrtYmmACKr1MH/UcvlqEJ0UBRLH/5i55uUUWnmKH5B0Fhntk5MjUH2+ELA68DrqU/VvD2aJetqSKh41ogcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

T24gVGh1LCAyMDI0LTA3LTE4IGF0IDEyOjEyIC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6DQo+
IE9uIFRodSwgSnVsIDE4LCAyMDI0IGF0IDExOjAwOjAwQU0gKzAwMDAsIERyYWdvcyBUYXR1bGVh
IHdyb3RlOg0KPiA+IEhpIEJyZW5vLA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNC0wNy0xNyBhdCAw
NDo0MSAtMDcwMCwgQnJlbm8gTGVpdGFvIHdyb3RlOg0KPiANCj4gPiA+IFNoYXJpbmcgaW4gY2Fz
ZSB5b3UgZmluZCBpdCB1c2VmdWwuDQo+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gVGhl
IG91dHB1dCwgaXQgaXMgdmVyeSB1c2VmdWwuIFRoZSBwcm9ibGVtIHNlZW1zIHRvIGJlDQo+ID4g
dGhhdCBtbHg1ZV90eF9yZXBvcnRlcl90aW1lb3V0X3JlY292ZXIoKSBzaG91bGQgdGFrZSBhIHN0
YXRlIGxvY2sgYW5kIGRvZXNuJ3QuDQo+IA0KPiBSaWdodC4gSSd2ZSBsb29rZWQgYXQgb3RoZXIg
Y2FzZXMgd2hlcmUgbWx4NWVfc2FmZV9yZW9wZW5fY2hhbm5lbHMoKSBpcw0KPiBjYWxsZWQsIGFu
ZCBwcml2LT5zdGF0ZV9sb2NrIGlzLCBpbiBmYWN0LCBob2xkIGJlZm9yZSBjYWxsaW5nIGl0Lg0K
PiANCj4gU28sIGluZGVwZW5kZW50IGlmIHRoaXMgZml4IHRoZSBwcm9ibGVtIG9yIG5vdCwgaXQg
c2VlbXMgdGhlIHJpZ2h0IHRoaW5nDQo+IHRvIGRvLg0KPiANCj4gRmVlbCBmcmVlIHRvIGFkZCBh
ICJSZXZpZXdlZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4iIHdoZW4NCj4g
eW91IHNlbmQgaXQuDQo+IA0KVGhhbmtzIQ0KDQo+ID4gSSB3b25kZXIgd2h5IHRoaXMgaGFwcGVu
ZWQgb25seSBpbiA2LjEwLiBUaGVyZSB3ZXJlIG5vIHJlbGV2YW50IGNoYW5nZXMgaW4gNi4xMC4N
Cj4gPiBPciBpcyBpdCBtYXliZSB0aGF0IHVudGlsIG5vdyB5b3UgZGlkbid0IHJ1biBpbnRvIHRo
ZSB0eCBxdWV1ZSB0aW1lb3V0IGlzc3VlPw0KPiANCj4gSSBkb24ndCBoYXZlIGEgcmVwcm9kdWNl
ciBmb3IgaXQsIHNvLCBpIGp1c3QgZ290IGl0IGluIDYuMTAuIE1heWJlIGp1c3QNCj4gYSBjb2lu
Y2lkZW5jZT8NCj4gDQpJdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0byBmaW5kIG91dCBpZiB5b3Ug
YXJlIHN1ZGRlbmx5IHNlZWluZyBtb3JlIHR4IHF1ZXVlDQp0aW1lb3V0IGV2ZW50cyB0aGFuIHVz
dWFsIGluIDYuMTAuDQoNCj4gPiBXb3VsZCB5b3UgaGF2ZSB0aGUgcG9zc2liaWxpdHkgYW5kIHdp
bGxpbmduZXNzIHRvIHRlc3QgdGhlIGJlbG93IGZpeD8NCj4gDQo+IFN1cmUuIEkgaGF2ZSB0d28g
aG9zdHMgcnVubmluZyB3aXRoIHlvdXIgcGF0Y2gsIGJ1dCwgaXQgaXMgaGFyZCB0byBtYWtlDQo+
IHRoZW0gdGltZW91dC4NCj4gDQo+IExldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSB0cmljayBJ
IGNhbiBleHBsb3JlIGFuZCBmb3JjZSB0aGUgY2FyZCB0bw0KPiB0aW1lIG91dC4NCj4gDQpJJ2Qg
Z3Vlc3MgdGhhdCB0aGVyZSBtdXN0IGJlIGEgd2F5LiBJJ20gaW4gdGhlIGJlc3QgcG9zaXRpb24g
dG8gZmluZCBvdXQgOikuDQpPbmNlIEkga25vdyBJIGNhbiBhbHNvIHRlc3QgaXQgbXlzZWxmLg0K
DQoNClRoYW5rcywNCkRyYWdvcw0K

