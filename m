Return-Path: <netdev+bounces-161636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD3A22D04
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D27A0FD1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB81D5170;
	Thu, 30 Jan 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7TfZOTq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592B1EEE6
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738240740; cv=fail; b=rWyunPeFXjCIyiRt2+pHAzL5ZC10GfcNTRqGax1uOESKSJURWe16rBKpNS3uktOR2TMBnWojqFaqYw6n7hvrArTOaSbPdG4bq/7v/HJt7oY9CbS0GQLggVWx45yauIf6ckTSs2WN24ZClT8+u9EGa5rd/VXXE0S2Ml+bI9RfMeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738240740; c=relaxed/simple;
	bh=Bg0HIaJNv0TzaRSSNGri3INnAQBHDB3tyPIUurNoHG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPyZfsBdadPtep4yxlYFgsDsIAaQG8/Pzv+R42wQzkfgK9/uoUHx8UEj7sVEBmyBcrARq1ClBjezFxzGGnfolJ+U1GlRSY92gcR3+6P9SitEwVmsQcHZAgy86ZCsROFEJeltaDR6QblCYWigML9pIBiXQdbzpdmzCnS2us/UCJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7TfZOTq; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2t6bBkYqkD4plHM0xIkM4rSFuZWBaCmk1Dm88oAORC1yYoLjtwEZAOet94TG5RlHVKn6DCkH7pVz0l4uvyJrLv8Xx6Pa+N/ybEzbUlAlpjUO9Uw9qKwOxjNUSpDUVY34ipGWgzw0QU/5rxic+y93ztsI3tdG57w0/hQp4SBf6KFnCeMof6AjbMGjGCg8+/gBGDwZLT4z2xS1glf/UpkgcW95hUWFPa/twivOKWhoVD4a8kkavB41/WQTqqeC5LcqPuxO9umEW1JwkaalucMnQiGT0184k3H3N5KfLbwfPKFNGv3xpkLzKRdudXsjIqKsT56kv2VbjJijYw9A2QZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg0HIaJNv0TzaRSSNGri3INnAQBHDB3tyPIUurNoHG0=;
 b=m1d/ZKDdKpGUhYWICC+GPGlRB9VERy2pbSDGnRK0Ap9BxfoZ66uhqVq/LSPJXovlXZL6IfjEIdiyUtZaoQ4nxawXM9UniFU65HOUZqCxYaB4Tg9Gc85pdxjjWqU2GeXdFRaCUebVvBOgGrw9yqscmOKZ40gBgr3SnpyaIwuM4+vVeziQWXavS6IXZsQ+9vmUnkoy39bZgoNP65DJduGGu7uS+EZLN32ZEd7uKsMfCm7vtLqah8gNB5RFrfWrOw/wKZDmx1pIaiEFm7h8GLsxhhHqmv3/snZqllnrEdyfEoUAQEmYuJxX8XQE3wCuN/owsrQWguV+uT8QzO04nGgbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0HIaJNv0TzaRSSNGri3INnAQBHDB3tyPIUurNoHG0=;
 b=X7TfZOTqkzoI2IO9w91q6jOKaavDPtGdsmi30rm6RXllqt6d1FdMBCOv5sqwnjhKVZI7O6BYM29aIQojOVA3DCFrY/wfto/WjsHIuuKqPR/af07fh1iHbv4VNwTbOLVTtM/LKDaMLVfesO4UQYlLTYXKahcCkFGpUgDrMX3t4wLYvvoWcdGs3YC6A/U+0+SVVgyDSaHvsDHGToOU3IO1zgpq4bvmvw4K89NtNR/9CCwaDPqdQ/GYeuPr1c0EnZpeP9XGQfdAMnzVva4GodCAU/w7N8L5H4xshApEja5eCwCbGQ7lRjLWR0qcGll2/UN7Z3tzi9FkYFVlQXSMErb6IA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 12:38:56 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 12:38:56 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Topic: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Index:
 AQHbb+l4mmigAbpb8kyWjZyRHuAtqrMrD+QAgAEebmCAAJRtgIAAlESAgAEyngCAALvScA==
Date: Thu, 30 Jan 2025 12:38:56 +0000
Message-ID:
 <DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250128140923.144412cf@kernel.org>
	<DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250129171728.1ad90a87@kernel.org>
In-Reply-To: <20250129171728.1ad90a87@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CY8PR12MB7538:EE_
x-ms-office365-filtering-correlation-id: a78abaf0-4c06-44d2-0cd9-08dd412b0fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmZaSjQ5cWNLT1drY1NqUFlKc1hDRWNxQkdiV0VlRVBKandDd3BkYTIrUFRY?=
 =?utf-8?B?aGFYWE5ra2pFb2VvOWJuNUowK2xleGp1cHBJa1VmZGV0MGhIbUFDZld6emlH?=
 =?utf-8?B?MTVBY0pDSnNrVFF5UUZYa3hYRlJ2eTFoWmVYL1ZzMFJ5ZitUSHNzb2FhUERJ?=
 =?utf-8?B?SCtLRkEvV0VaME00RGxqeERwZUxWNlJ4dFJ2cGYrUmFlL1NtbHl5ZGI1N1M2?=
 =?utf-8?B?QzM1RXYvMHQwdi9zdXRwM0txWmxpcTRSWGJhV1VHdUdMUUUxa0hQa0w4RFFU?=
 =?utf-8?B?cFF1cjhSaXFFRy9qZ25uMnlKTURlMlJhVm42aHlUWFlCdlliZ1FXT1h6cTNS?=
 =?utf-8?B?WG1PTHRWNktXU1BkV3pubWovbGx3ZnRSRkVtUGpuYXJMWFllU1hxcWI5SWhs?=
 =?utf-8?B?U3NaQVpKS0NnRjlWM05FRTdiWWZYbG9yREp4K044d0w1UmZkTFMxSGN3K1Zv?=
 =?utf-8?B?TmQxS3Nod0pkNk0rcEJFT2ZKSmJJUllZUUFiMHVOYWMzU3pvbTlZV3NUM2hr?=
 =?utf-8?B?WjVpT1Z6bkVjMnoxNVVQRDFXK2wzWWU0ajRwWUR2Y1JwZC9ONUIwaTdrcDNC?=
 =?utf-8?B?VFBpRFdJdlY0OGt3ZElCSkhXdDFkR3M5WnIvaTRHYUFqR1VUd2RRdkExaHFp?=
 =?utf-8?B?ejBjMHozQU1TN2NXVzA4RTNuKzR2blNDV3lPbExxVlNDYW9aZFNJekJjM2NP?=
 =?utf-8?B?S3NUV3FzTERPVWJwSWtoMFE2bGZjN09CSWkwUXlJcVFTaU5IZUJVUFB2Q3Ar?=
 =?utf-8?B?c3dIS2YySm9nYWVqNnNKSmRnRlJnNkpNWGNDcElJV1p5N09kMVhFbnUyMVZV?=
 =?utf-8?B?S2syMWhlVUlGdXF4clhSZmgyVkVzaytycmNwYWNtSExTOXhNY0dDZEMvbVc4?=
 =?utf-8?B?NlFsWDhtem9BVk1CSytFT2d1SnVlVjJZZitiS1VOcE81SU5XenFxZHd2NHVH?=
 =?utf-8?B?ZU50Wm8xNzJEWHlvSE8zR0FDUER3TUlYdk8rdHppV0xwTEt2MjcwNnlEK2ZM?=
 =?utf-8?B?cGl4dHFNaFpxWDRZbTF3V0dFNDFYUWwzV205cnp4RGZaOERUZ1lqUm9oSENZ?=
 =?utf-8?B?aTBLRGt0NUdJWW5RR1IwN0RHRDZGcVJ1aFJIaU9ybCswSlhMMVU0aXUwaE80?=
 =?utf-8?B?RHgzSW5oWThpT0h6RXlqcHFHZDV3S0g1ZzhGcnZBa2kvdkpvdzVKeFkyTmxi?=
 =?utf-8?B?WVpoc25GMGJBQzcwdnRpNHRycklvdVpNQ0RWbWlzd0F3bE96YXV6WWJITm1Z?=
 =?utf-8?B?dUsxZEl3Nkt4NlBjaWZncDdQejlyTzFYMjVUaGFtV29ZTW8vQjdaZjlmVER5?=
 =?utf-8?B?TVcyMlpHM3NBZTlsK1U2NzRmWWR0M3FOY2FiQkhmdGQreTlpTCtTdzMyTk5w?=
 =?utf-8?B?QXRrZXlLdXlGRXErSXl0TnROZk1VSzhnSmtQWWVXS1Rxb2xCWWxZR2xYRjJx?=
 =?utf-8?B?V0E2bFVDSXNZQi81QzRSS3NXRHRZWG16dXR3c1pxOHV3S1JnSTg2TW1iVmVE?=
 =?utf-8?B?c3dvaW9VeXVhZ2h5RFgySjRYZUhJV0pBRlA2bndtNFNHRVhlRjA2VEJuZllH?=
 =?utf-8?B?aFZIeFRaMkErSnZTMEtyKzdHdmZ4a1EyUXFGSXJIZXhYd0luTDdUOEM4V1FR?=
 =?utf-8?B?dUE0SFdhcDltbWN6RzNHM2xDQzdZWjB1MEFXTUY1ektndHZwVGNKTXo5WDJj?=
 =?utf-8?B?dldueTk2a2gya3hERnZ2MnZMVmRGaU1qQ3FYTEZIWU5SNWY2eUlJWDJyN0Fw?=
 =?utf-8?B?NTU3TTU2akViYnMzM3VqZjUyYTJ3M0s1N1VzZUZjbE5YclMwQ2ZZeFIrMGQw?=
 =?utf-8?B?WlFBYVFQZWpyTnl3R3dtVkpiUFgxUDhhVkJmdFBxMkpHYUZySHc0MHMvNzdO?=
 =?utf-8?B?ZlB3dzBPRXlaRlJHWnhhZE9hT3hUdlVyUXRVZ2JIUmRRMHd1Q2E2ZWowZlJE?=
 =?utf-8?Q?s3I0hFhsyak=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGlBQnRGRkV4THZCZU9zQmZrV3RpcldKbnY4UHcrb2lueGNrSEpUcG5sZ1ZX?=
 =?utf-8?B?UzFXb2hFem8wZWM4eFFZUVR4VnFCRTBySS95RTN6cFdHOWV3NFFWenJ4eTl1?=
 =?utf-8?B?L3pXcHp5VFR5MFhQa1FlSHdPNTN3bHIvNjQ4TmFMVXlZbllucUJML2NGbVlT?=
 =?utf-8?B?WTZpV1JjbEhqUW0wYzdNVjNLQXhTMGJpWWtRWWhGdjhrZ3ZvOXQ0VW0vNHFN?=
 =?utf-8?B?K1U2R1hZV3BPMFdYd1VOVjFodHlDS01ZWjVNQWVVTU4rVzE1c0Q3VG8rR3FK?=
 =?utf-8?B?UnFFVG9DdDRaMmlFdkFHME9QQXVOdU82Zm1DVFNJNmszUHRleUdzN2hmVTBT?=
 =?utf-8?B?UzV5T052WjZSdGQxRWtGQ3VkTHM5T09XbnVBeGZnU0ljaysxcHRPczR5NUhX?=
 =?utf-8?B?VkRjeit3ZjBqUVhCSTFuVjFlejFzZkttMkE5djZ1SnVRb1huUDR0R2JkYTBo?=
 =?utf-8?B?NFFlUHU2cm1jNE1IbytmQmZXaGFFbkNFM2E2bWtCOTZyUTBRYzcwRGVCTlpk?=
 =?utf-8?B?U3VhYkhTYlJTcUN2NzlRaUZxMlAreDVhSHBDekNiNFNQc0VLL1V5SnJJK2Rt?=
 =?utf-8?B?V1hldkxCSHJUbTdNUGsrS1JOMURmRXRjN1JTaXJpdVV3cDRSMElPNXFaeG51?=
 =?utf-8?B?dzk1YlViN3JuTy84cEZ3QTE0QzZIeWF3WEhKR3FtUEZjR2x6djRmc0V6OXVR?=
 =?utf-8?B?WVVXMXFkTFI0TzEyekE4bWVlSm5XMmlQamUvQUJENTZuYnc2MDB3blJ3TGJv?=
 =?utf-8?B?UDQvbmI4K0xPQ01ac0tWeGZlK2xRNHNrUFB4QnNPMGh3TzhHOXVYWDF4TnJU?=
 =?utf-8?B?M1kwcmd4Sk1WejVCUU5zYVl4UGhzbGZNS2ExUHdFYk85YW55RjVUTVp1aGNN?=
 =?utf-8?B?YzhxQ3NiY3FMeHBKZnBtb3RrWGNSakRrMWhaeURORzFhSnFpNlhvL0V6QVMv?=
 =?utf-8?B?RUsxRWNoRUw4dWxBZVZxT3ZCTXM4cXB6T0JNRThPc1gvM2dLd1BvdWVJTjMr?=
 =?utf-8?B?bkloTnFOYUtZZUYzRlZWZjluS2NwczY1K1Z0Y0pWTjArbmhNUVE4UDJqeDZ4?=
 =?utf-8?B?YXBxZzl1SVBTenIzRHdCSzd0VTNaVndmUTQ0WDJZUVNGZEFsd1czUG1uaHFT?=
 =?utf-8?B?d2J0MmRWTFUvaW1kbDh0cUxLWW8vNnd1eTR4T0tPWURESEZ4aU1OcUd5YVRC?=
 =?utf-8?B?WENSd2NJVUZDTjdtVFN5WEpnQzljZWcyZGdqRnpWY1QvNWU2SFllWTN6dDUw?=
 =?utf-8?B?NVk5ZnhsRFpZNGVXQm5tU0swVzdaQ0FHVnBXRzgybXQ4NHJjT004aXdjTDhx?=
 =?utf-8?B?WXJYUk5zM3Nldm5JQ0c5R2gvRm9PTkVuWFh3TDR4NGQzdDJlYWlBeGltRUJF?=
 =?utf-8?B?bW42LzJaa0JMNGx3NzQvcW1KMTBuQVYwY2toblJ5NXhnVHVHVkFzTDB2VHp3?=
 =?utf-8?B?eElvTksyeXRVVzJ6a05iWjg5ejl5ZWlYMGs0YlJCdU5IeXhkc3RJT2wyQXNp?=
 =?utf-8?B?V1FZNHRDTzExU0NnQkQrNWpmU3BxNUZERWRFenVjWjA3MzBiSnF4UlVWT0xl?=
 =?utf-8?B?am15azU2Tk5XWHV3SFRzbEpmMFZyUUlvZXI0S0luaWhwTW14dFl4M2hZT0Va?=
 =?utf-8?B?WEZvN1FoaEpGVW5Oc1pGbCs3UUc0UkN1VW53SkljS29Va0hYcTBUT2FXSGxS?=
 =?utf-8?B?Ri93YnVIVWZ5R21tdm9RazgwMlcranU0dFJDdEZEN0w1alFYM3VzTzQxSzNN?=
 =?utf-8?B?T3JHdU1nQmc4dFVickFmZUVKSHZvVFpEWUd5YVQvaS91VzF6dGJFOXdxS3BP?=
 =?utf-8?B?cGdjTHhFRUFYUWN4U29xcXVYQXd3OXhvcVVlTUxSVHNnS0RCMlBNdjA1aFlm?=
 =?utf-8?B?TDV4Y0Zud2dQVzlaS3ZkZVBVaStRcURlMUpUZjN2WENMZHMyOXFJdFhSUFhY?=
 =?utf-8?B?OVE0cnhRUGdwcUJDOEhhNHJCM0xncXAyeU42SmpyWmZRakM5aVBFSnhGZDAy?=
 =?utf-8?B?THNjd2NFSGRwbGdkSy9Xc0xIWkdDanJzU1FTS04raDExeVB6aVo0SUd0RnI4?=
 =?utf-8?B?UkNWZ3NyUDRSbkUxUE1wZE5QNmdYM2duRXRTTDZTWURyNjhCWW40N0xZQlEr?=
 =?utf-8?Q?oyocZu2E+gkhxYyYTlsN6Mswj?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78abaf0-4c06-44d2-0cd9-08dd412b0fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 12:38:56.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+ym+KU1+W9qxE5WJR8VIZyUgUK6Qd0CotXKvfvVJHBmEws98NM14O0gRcnWa0bCHS5poosbgmGjhdpWG+olgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2Rh
eSwgMzAgSmFudWFyeSAyMDI1IDM6MTcNCj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBta3ViZWNla0BzdXNl
LmN6OyBtYXR0QHRyYXZlcnNlLmNvbS5hdTsNCj4gZGFuaWVsLnphaGthQGdtYWlsLmNvbTsgQW1p
dCBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPjsgTkJVLW1seHN3DQo+IDxOQlUtbWx4c3dAZXhj
aGFuZ2UubnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBldGh0b29sLW5leHQgMDgv
MTRdIGNtaXM6IEVuYWJsZSBKU09OIG91dHB1dCBzdXBwb3J0IGluDQo+IENNSVMgbW9kdWxlcw0K
PiANCj4gT24gV2VkLCAyOSBKYW4gMjAyNSAwNzowNjowOSArMDAwMCBEYW5pZWxsZSBSYXRzb24g
d3JvdGU6DQo+ID4gPiBJcyB0aGUgY29uc3VtZXIgb2YgdGhlIEpTT04gb3V0cHV0IHN1cHBvc2Vk
IHRvIGJlIHBhcnNpbmcgdGhlIHVuaXRzDQo+ID4gPiBhbmQgbWFraW5nIHN1cmUgdG8gc2NhbGUg
dGhlIHZhbHVlcyBldmVyeSB0aW1lIGl0IHJlYWRzIChlLmcuIGRpdmlkZQ0KPiA+ID4gYnkgMTAw
MCBpZiBpdCB3YW50cyBXIGJ1dCB1bml0IGlzIG1XKT8NCj4gPiA+DQo+ID4gPiBPciB0aGUgdW5p
dCBpcyBmdWxseSBpbXBsaWVkIGJ5IHRoZSBrZXksIGFuZCBjYW4ndCBjaGFuZ2U/IElPVyB0aGUN
Cj4gPiA+IHVuaXQgaXMgb25seSBsaXN0ZWQgc28gdGhhdCB0aGUgaHVtYW4gd3JpdGluZyB0aGUg
Y29uc3VtZXIgY2FuDQo+ID4gPiBmaWd1cmUgb3V0IHRoZSB1bml0IGFuZCB0aGVuIGhhcmRjb2Rl
IGl0Pw0KPiA+DQo+ID4gWWVzLCB0aGUgdW5pdCBpcyBpbXBsaWVkIGJ5IHRoZSBrZXkgaXMgaGFy
ZGNvZGVkLiBTYW1lIGFzIGZvciB0aGUNCj4gPiByZWd1bGFyIG91dHB1dCwgaXQgc2hvdWxkIGdp
dmUgdGhlIGNvc3R1bWVyIGlkZWEgYWJvdXQgdGhlIHNjYWxlLg0KPiA+IFRoZXJlIGFyZSBhbHNv
IHRlbXBlcmF0dXJlIGZpZWxkcyB0aGF0IGNvdWxkIGJlIGVpdGhlciBGIG9yIEMgZGVncmVlcy4N
Cj4gPiBTbyBvdmVyYWxsICwgdGhlIHVuaXRzIGZpZWxkcyBzaG91bGQgYWxpZ24gYWxsIHRoZSBm
aWVsZHMgdGhhdCBpbXBsaWVzDQo+ID4gc29tZSBzb3J0IG9mIHNjYWxlLg0KPiANCj4gU29tZSBz
b3J0IG9mIGEgc2NoZW1hIHdvdWxkIGJlIGEgYmV0dGVyIHBsYWNlIHRvIGRvY3VtZW50IHRoZSB1
bml0IG9mIHRoZQ0KPiBmaWVsZHMsIElNTy4NCg0KU28gc2hvdWxkIHRoZSB1bml0cyBmaWVsZHMg
YmUgcmVtb3ZlZCBlbnRpcmVseT8gIEFuZCBvbmx5IGJlIGRvY3VtZW50ZWQgaW4gdGhlIGpzb24g
c2NoZW1hIGZpbGU/DQo=

