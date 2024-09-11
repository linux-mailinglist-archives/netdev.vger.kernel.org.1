Return-Path: <netdev+bounces-127318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D500974F34
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AEA1C2205C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9141184539;
	Wed, 11 Sep 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="O1ovIbsM"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632416EB76;
	Wed, 11 Sep 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049060; cv=fail; b=hgWR32nFifIyXm98uvW4J96sBY6r7SvyJ4ddu5DUXBNyM7LYakHBKcL0msds8Y9gvSKIvMB9O4RySlRD5Tx1Opn8X8GzNGa61jHBY8k79u+nqsIVRB+x98w+0ZMkMrhqPjo7xzusJyL8NTChTQ73oBKj/cYYc9z4jSrUvleCd+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049060; c=relaxed/simple;
	bh=ILkIQcmo2mpD/3WE8SY2mbjLKteGKEWJf874njquUy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBT5fZebfdt8HdMgQq+s2Np9rQ7tqk8MEK2/Q7wGzIA8omagHajEmB8RDZAY/CyfseYNYY4YV5VUmHDSeg6huNg/18+ScwaGk4p4TZ8gsxyek/ToKIwxy15X/UMtyZzWJtOxd+EuROUh2vFe3trJ0XFM59JG85lOaj+0KVyMHt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=O1ovIbsM; arc=fail smtp.client-ip=40.107.117.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/a+DGVJL3kFeiBaDu0OMPnQplBNg0GkUhdD5WYLoMgYF1u8tPE1wYWCoj2QP1hDQEFegKjD5vj6XNrFHcWFRnvj5d66QgIIbq92PzA2AdDfIvp5FO9C+3RBRiqL46SZ5uVV1+Tg5Oh2bZQkF9YfQhjiaK71u4Z7+f/7MRmKV+hBmf99shE9vHEMHDR3d3H2QiPsdjqfDRuICeNakBfOAC9yhSj5/i13/SzB3FL5CNaMCqGtSIQo/+5hW8li/7BeDh9l6KYQH1qkAQv6Igv/vm3z57IVSkscMNhN1o0qWt6akTHEELEOfECd7kfAtGdX8LWnqTcsvCW+JaH+elhOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILkIQcmo2mpD/3WE8SY2mbjLKteGKEWJf874njquUy8=;
 b=c7o10eZjxzPw7OXdCyqihnYtNVu0THDAHr4QhuT/KBk3ta+uYKzZYsLJ7r4wU9R9P9VgJcQLQqErHmvbEYVhODmgIEHHvTn0iSn7URmDyNgwxUBAqRm+RrPnkIaBD8eXUhprk/1fmmXOqofNGmbhhfQYxX9lNJ+6KFPIIq/urnA9/CSv4PzEeS/G9vkREX1toUpKrYKruZwBsunJ/wjSOm0kJTOzFG0wpl4fqhBtGxrO6/ga9NMPCnCkqK9hPAhbPfqgY5NKcedKfY2CcSeNGraNvPQLesw8E7frY3rUgCeP0OVy95QQL5xlndbQpKOskTp4ocDojgnO7NHI/ZCzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILkIQcmo2mpD/3WE8SY2mbjLKteGKEWJf874njquUy8=;
 b=O1ovIbsMq53IwWc0+qF5CL1mE5aZKgGtgnskx2LRTXiqCpXZHKW0vlG54NYcQdeDX13FcEbxLGv0oKE+StSsuunj9dTDOzNomERNQQRnzECsAqXphjblYOfxdBH22d8KLk5ngV+XEALI0qLJBPmPy1I2tcy2ItCL+2HXttROGItdmp8KUnsGk6o4HwNNhTQdEGu5tAET2rZW/MdON6a5w+mRpR/4n3P4irWoqeuy2RKZG22C70jrSefL9BNlpZclRiZLXIdRtahSbZ0EC85fPODo+2g/uhYcPmPHSBZrDoJFXgCEIgag0Sokz27fzwkkZcl6ZeD8wDmczAhoXaH6Qg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6294.apcprd06.prod.outlook.com (2603:1096:990:14::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 10:04:14 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 10:04:13 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjogW1BBVENIIG5ldC1uZXh0XSBuZXQ6?=
 =?utf-8?B?IGZ0Z21hYzEwMDogRml4IHBvdGVudGlhbCBOVUxMIGRlcmVmZXJlbmNlIGlu?=
 =?utf-8?Q?_error_handling?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBmdGdtYWMx?=
 =?utf-8?B?MDA6IEZpeCBwb3RlbnRpYWwgTlVMTCBkZXJlZmVyZW5jZSBpbiBlcnJvciBo?=
 =?utf-8?Q?andling?=
Thread-Index:
 AQHa/1rfMsgzpIAVIUKgpr/yLMfBE7JKRNDwgACk0ACAA8oWYIAArigAgAEmb4CAAAsCwIAAF9QAgAG4wSA=
Date: Wed, 11 Sep 2024 10:04:13 +0000
Message-ID:
 <SEYPR06MB5134DB8DB445057FE187D1999D9B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
 <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6261c529-0a15-4395-a8e9-3840ae4dddd6@lunn.ch>
 <a2dba28a-6ac4-4770-b618-acfdd59cbbf4@stanley.mountain>
 <SEYPR06MB5134C7E0E578CB8AB92AA76F9D9A2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <81e35682-ee80-4ac7-8b6b-07ebb2a68e3f@stanley.mountain>
In-Reply-To: <81e35682-ee80-4ac7-8b6b-07ebb2a68e3f@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6294:EE_
x-ms-office365-filtering-correlation-id: 9dcada30-876f-4b32-9909-08dcd24916a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk5ZcDZ3ZWIrVFdTS0R0cXRtY01KR092WlFxbU5xb2greHJhaXFzRlJiNlNC?=
 =?utf-8?B?M3M2OFIrR1JsbmZjZGpnaEtvaUNtTlB4ZTdmRGdtU2RYdHF3eEc4dSs0Z2RU?=
 =?utf-8?B?ME5PNFFIajRHZjIvQjlkb2czQlJRVE00dFJxY3Zod3FoNHNTS1NxWXhCM3lV?=
 =?utf-8?B?dm5MUnFQazliOUJGUCtJVnc4dlB1cFZiRmt4dWhjSWNvL2dOMUxyTVZ5YTEw?=
 =?utf-8?B?c3lSVDFyRkgxcmU5Uy9zdC9EWk5sZVpJM2IvSkZpdi8ya3BqNVppOWlkQWt0?=
 =?utf-8?B?K0hFTW1oUGY2VzFacVZ5dmoxeXA2c3dMaDRlMXcvaGkxT0ZYTVI0ZUdKRnYr?=
 =?utf-8?B?c3krcVo5VzRDUUplOWJ3ZnRDdEZOK0hZdjdMbVp1QUNXTXRxQlJwVEVJc3JR?=
 =?utf-8?B?eTFSZ3QwK3FucjZDcU1BaGE0cHlROHd4TDYzRVFDVDlTQ2hMSEcwV2ZoemNx?=
 =?utf-8?B?OS9nNGtJOEtOaUwxS0hNTG9TWmZlZkxKRFdVMGc5aEhjeGdhOUpTNlRhOTZY?=
 =?utf-8?B?V3dldXp5TUJjUnhucjFrMklFTlhTbUpBMFJwdVQzTitwL014WnljbHlNTVd3?=
 =?utf-8?B?ay8rMGtVK2c4UWdwUUxHeGFTLzE0T3NLcmZrbUNUdGhzaVRRSFFnUHlxWWsy?=
 =?utf-8?B?bUhWbmhYeHlsU1k2alFBaEEzTVVrL2twQUdJMEFtWFlHeWViWWpGU3pHNmJN?=
 =?utf-8?B?b0h3anJyckVaV1A3SE15V2NKQnVEUFczT0s0SkpOMGVYRmcreDRmeVRWVHpB?=
 =?utf-8?B?K3hSUEhlME8wVmpQVTQ3dTc5NUpPbEpEcWJ2cnpyMHdOVng0WHgzd2NFU2Jh?=
 =?utf-8?B?K3Bvb0o4TU1lWjFLMllwTDdRanRUTy9laEFCbDV4RENTVWt3M2F4RCs3UHhI?=
 =?utf-8?B?bU92YlE5RE1XQ2FyT1Vpcjk0REM0MVBlVmtpMU41NEFvK0lYSHNZa3h1NmJh?=
 =?utf-8?B?Nno2VGN1NmVFK3EyWlk4d0lKUGxhZ1RpR24zSUdGTGsvQzE0N0VoMmtxQTNy?=
 =?utf-8?B?d0phNFc2V1ZhSi82djlKc2tIVzM2L08zNG55NS9DeENTRVQxaU55UGhEQXRN?=
 =?utf-8?B?QzFVV0htcmppaURNLytsd3p1MnVWZk5qVGpsZzFyY0E1YUJBdlloUjQrdlZx?=
 =?utf-8?B?VG9tSy81Tk85cVJKQmNCdmZnbWRLVkYydzh6OGl3T1VCNXF4SWFDTVdXMWJM?=
 =?utf-8?B?R0tSZFVyQ2UzTHB1Rm5aaU53UzVuZUlQSU15b01qQU51bjhGaGxmOU9kdVZJ?=
 =?utf-8?B?NUhPTHQzVFdlWmd0OURWaks1NGhmd2Mzdmt4dG05Q0h3VFZlVWFFZkJpUXpk?=
 =?utf-8?B?d1pzM0c0WGVCMzBZOGxUR0hwRzM2cFZ6ZEUzYmlCTTJBcnhzV0h3NFZGaDBr?=
 =?utf-8?B?Tk5ZV0NxMG1RUjhRSzNIZ0hjbWE1SUt3R0FXRndOQUJzYzl5enk3aVdETkcx?=
 =?utf-8?B?a3hMdjBqWXZZNit2WnVMRklJalBjWjZYZElWVE1WdjMzaTB0YzFRMlViL1Ax?=
 =?utf-8?B?TCtBcFVKUlJEejIzTFJvdHRNaVVlRFpERnJiUlRSb25HUm53ay8rS21VYnRZ?=
 =?utf-8?B?ZVJ6SlRvTG8xMG5LdjFrUHpJams3ejBnVWM4bHh1amY2VTg5ZEZjWi9jNWda?=
 =?utf-8?B?c1JtRGVENEdKczlhWDgyQXdxNlVjK2hzN1BVazdiUkVkUmRUaHNtUmV2MitW?=
 =?utf-8?B?ZVcrNE9qUEdOSnlGUXFHRVBoQ1Byc24yZll6Ulh1QjBHek5MM0E1TEMvaHhF?=
 =?utf-8?B?QU95ZDhHYlVvVjNDa1ZGYUtqeGdlYnRrSHhQL25hOU9qNXlhVXNTYlFwQUQw?=
 =?utf-8?B?RlBWMEtzK2pNTVF2TEwxa3dvRUZMTTlWT0Y4R3NkRzZCb3pDais2ZlJ4Vmxr?=
 =?utf-8?B?MWtPTVdLSm9pZnNYbDBIWkZvbWI2S29uaUpRN1kyVDJnaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0ZZS2pSdlkrZWtSVVFxdUVOWHpTa0luYmh4Zndzc295MnZvekJaN3NXb1dn?=
 =?utf-8?B?WDdKNWNsaVVBOEhYdWlIeG5zRStEc3NsY294TnJhNlhtQkRWT2tDcWJrVGRB?=
 =?utf-8?B?ajM1L2NZUjkxcEtqUDlIY2o4c3lab2JZSmV2aDNTckJHL1d6K2E2S3c4UVlU?=
 =?utf-8?B?WlFRRnNzUG1ON3VwL3lNd2tnWjA3M20rZUgyNGZacXVyeGhKRXZvRXhXNzBY?=
 =?utf-8?B?eHkzMWdlSUt6RlVMRllLeGY2dUR5VlJKSUp0c1JkdFI3S01KNDV6UTlrQ2Vm?=
 =?utf-8?B?Nm4raEY3MXUveVZsQjUvaE5IS2p1bVUyMVUxLzB6cmNWb1dzdWxyb3ZVc0hu?=
 =?utf-8?B?K0hkeWFTbUhiNE1TM1dYQk1KR0loRjBYQnE2eU0vTXNST3lPb2lSaTMrWHkv?=
 =?utf-8?B?d2ZiU1FBcTFLOVIvbDRGZVNjWXYySHR3d2dBMXNVaUo0MHExMmdySGRjS0Vk?=
 =?utf-8?B?NmxjUEhvZGRteENld0FZSk1VVncyZjhCQXIwaDFpYUtTYkIvV3BsSHdGSFIx?=
 =?utf-8?B?cTFoRUZRMm0xem5Rd0MrRGtwUVlRVUpLVHRNcnRkWVE0VTdQK2FnMktaeWNv?=
 =?utf-8?B?WG5IL0YwMlhzZVQ4N1M2VEtuMytaT2NlcXZXUk1qNXVFcVBKekQzb3FKMWpD?=
 =?utf-8?B?OUF4OWZhZWx6a2FoVEZ3SVVGeFlyaDdtb095N1RoSDJkdUxCSTNJOHFaaXJq?=
 =?utf-8?B?SUtBeHJYaHY0M29KSnFxdktXTmU0T3FHWktzTldZQ3RYRjlPMFNBK0RNaUJm?=
 =?utf-8?B?ZDNlaDZEcjhraXZNNm9tWTFoYVdsU1ZEcFoyWHVNNUtqZmUrSU94ZGY0Mnpz?=
 =?utf-8?B?NXVPa2JtZk56VkVkaWxheWF0WXdmay9uNmYrVU5ZclBqVVBVa08zS3Vwb0ov?=
 =?utf-8?B?dE1tRHNFY2tINzJERzhvdlkrK1IyUkdyZ0xGYlNRNjF1UVVVcGUzenFoUnV0?=
 =?utf-8?B?ZTV2T1JpNm56dk11aEdjVjljUU9keGlRN01mZkJjWFdTQ1NLazJmYmUwaENK?=
 =?utf-8?B?YWpWT2ZqY0ZvcXY2WjZxM253NmxkczFlTkVSamt5NEQzTlJxSTE1UjhRMitI?=
 =?utf-8?B?OFN3dnBmNjRzYWp2R2phT2dOVDM2amxvNWdmZkJRSEt2bUhpazU4UEtLdU0w?=
 =?utf-8?B?eTNkQ1Y5TnVjSXNBVStjR3l3cTFBOWkrbXhHZmtCVld4bENpWENGY0RoeGMv?=
 =?utf-8?B?Y0RaWS9rdHJBd3NMK3VqN1JSWktpOERVTmJBQWp6TnVYaitOOVNUWkVBYTJ6?=
 =?utf-8?B?dGNuY0ZMRWZTdCtJZXRZL3l4REFzOWVza0Z6aGFVaXZUNS9qRSt1ZVZQaE8x?=
 =?utf-8?B?d09uQ1QvV1hkZHhmM1ZaMVptdWx4NGF4bXpzN2h5VGh4UXJnZG4wNUQ4cjNQ?=
 =?utf-8?B?alMwenE3eUw4UXNsVUk5SGZRVWZPUStWVFEvUytPVU80K0k2dXdEek5rQUE2?=
 =?utf-8?B?VUpRRVptK1JkZldEcXU3RGlzNUhTZmZwZjM2eHkzVURiVTU2UHRpRmc4bHBl?=
 =?utf-8?B?bXBjcENuaTBwRzdBRXV4UlNKRXg4ODFOUTlzVjlFMk5nK0RscFZlWS9ZWUU0?=
 =?utf-8?B?cmZYUlBhTmdOMlJNcVU2T3B5Zm1PWXF4VHkvZEdiNXcyNXNaeEFTa2UzR21L?=
 =?utf-8?B?dHk2b3NYT001TkpzRU5LZnRuNWQwSlFxaHRNNHhLWXFUaGVtOGdpcE9Ob0NZ?=
 =?utf-8?B?YXF1dFVrUEdIa3V1M0RFeGNLZmFyTmlSR1I1UGxhYm5kV3UrT2hVT3VHa0FN?=
 =?utf-8?B?OGt0aUhZT1JSdXF4akVsNTVoZHBrbDFTblBvNVZ3c1ljY1hzbjczcTJzMEFO?=
 =?utf-8?B?MU16R3dmZ0w5ZDJmM3oyVmg5UEc0VVR4YjZqQWdUb2hjaEJZazJLSTVxM2Vu?=
 =?utf-8?B?czNkVHJTTVFQdVJ0ajlESFJFQnh4Nm9OOSt2T3RMKzE1enN6ajMyK2l4TTJE?=
 =?utf-8?B?bkJCNDEzejFyMDhlbVdTYkNZUEppRXV0RHVYQXJqa2FPQk5lQ2xOUHNJcHhk?=
 =?utf-8?B?eGFqeDVqaEczNm94N2JpcnRMT2x1aTZVU2QzQUFkdUdPeTRtNmhvTnF6ZFdB?=
 =?utf-8?B?Rk5uR25JNlRtS3c2OWEzNnNjZ0tLeGRBTjkydDVOSlI2ZklQeHdkMTFoaHhK?=
 =?utf-8?Q?4rmKZk1+uRmOD9doJn2Vyq6xL?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcada30-876f-4b32-9909-08dcd24916a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 10:04:13.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSg2/DsSTtFO82SsMiOTZlTZAc+0O+4tBQWIeXZjXIZFiEVHu1t8VY7Rjd5jnWvMQXyOpV9vZJZiJcNi/Au9GL+2IIRQCr64GpGPZjeTOro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6294

SGkgRGFuLA0KDQo+ID4NCj4gPiBDb3VsZCB5b3Ugc2hhcmUgbW9yZSBkZXRhaWwgYWJvdXQgdGhl
IGNyYXNoIGlzIGhhcHBlbmluZyB3aGVuIHlvdSBhZGQgYQ0KPiBzZWNvbmQgZ290bz8NCj4gPiBJ
J20gd29uZGVyaW5nIGlmIHRoZXJlIGFyZSBvdGhlciB0aGluZ3MgSSBtaXNzZWQuDQo+IA0KPiBJ
J20gc2F5aW5nIGlmIHdlIGFkZCBhIGZlYXR1cmUgaW4gdGhlIGZ1dHVyZS4gIFNvbWV0aGluZyBs
aWtlIHRoaXMuDQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4gaW5kZXggZjNjYzE0Y2M3NTdk
Li40MTdjN2Y0ZGQ0NzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFk
YXkvZnRnbWFjMTAwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdt
YWMxMDAuYw0KPiBAQCAtMTU2MiwxMCArMTU2MiwyMiBAQCBzdGF0aWMgaW50IGZ0Z21hYzEwMF9v
cGVuKHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpuZXRkZXYpDQo+ICAJCQlnb3RvIGVycl9uY3NpOw0K
PiAgCX0NCj4gDQo+ICsJcmV0ID0gc29tZV9uZXdfZmVhdHVyZSgpOw0KPiArCWlmIChyZXQpDQo+
ICsJCWdvdG8gZXJyX2ZyZWVfbmNzaTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiANCj4gK2Vycl9m
cmVlX25jc2k6DQo+ICsJaWYgKHByaXYtPnVzZV9uY3NpKQ0KPiArCQluY3NpX3N0b3BfZGV2KHBy
aXYtPm5kZXYpOw0KPiAgZXJyX25jc2k6DQo+ICAJcGh5X3N0b3AobmV0ZGV2LT5waHlkZXYpOw0K
PiAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eDQo+IENyYXNoLg0KPiANCj4gIAluYXBp
X2Rpc2FibGUoJnByaXYtPm5hcGkpOw0KPiAgCW5ldGlmX3N0b3BfcXVldWUobmV0ZGV2KTsNCj4g
IGVycl9hbGxvYzoNCg0KVGhhbmsgeW91IGZvciB0aGUgaW5mb3JtYXRpb24uDQpJIGFncmVlIHdp
dGggdGhpcyBjaGFuZ2UuDQoNClRoYW5rcywNCkphY2t5DQo=

