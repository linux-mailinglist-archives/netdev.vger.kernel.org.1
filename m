Return-Path: <netdev+bounces-128483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BC979C3A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE061C221AD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8CE13213E;
	Mon, 16 Sep 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XHHBMV29"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0223A9
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472915; cv=fail; b=FyzOMwXLaocIdxnEcRXJkXEZg7W2slLDIekwjdrFLgWx6BFo+re8fo71KXxBuTzYQapbR5H8EwE+D8emYncYIEnfAvA6GIXb58p0lNeC5eWhJZumvwSR3rZkBQHG0C0zxDT7vu0BDxgDVmGi4ezEMNH6EboEcPhn9i39EZOSbFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472915; c=relaxed/simple;
	bh=0Po2XhvW7DoS0JaQJ90Muf/FT3GT1t8zekIYan9+3Hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eIXof7wYbMoLX2BD2C+u2X5Qvn9xRABkWh1zoijKG0QXBRzxfly7M3IMmxMbskUPZDyBUq7lIs6LodwYDY98VNalM9MHYAsNY4w3UyXwet+vZx97QEuNBEGrIDNEIt0hmKrN1yqR3IyF4VnXd9iIPor5IXioLCmOc9zcTU+KGEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XHHBMV29; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdjylXefki5REr3D8Qnv0JO/I4JfLi4vYJ84nG8TRKZnT+cwIo82i/OkotbkZeGrV10IXuczQ3nP3kVklhs37iCR2iVm8qRtyJ15gIGz/1smnS/A+QUUJAVGdvVln5KCPctzK0+iGnF1Q9rkT3ggx3xd19i9TmzwuY2IOhBvhJXagDKFFajgL60HtUCoTeWIwfBF1bETTAIR2SlZpHnV6+jWcMfcYRY6xprpJozFTfArDlQ+we00vomd1i5RonL0xCpCM2Gs/dLyA5Y+Ypx1zut1NbCzZfvhwdM7hWEUf4l4mujv6izHbq9Bfdg1BIB1ibPfRoYkm3wplWqbYh1G2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Po2XhvW7DoS0JaQJ90Muf/FT3GT1t8zekIYan9+3Hg=;
 b=YCeTTmf46MfI/LUm1HTDR+jmjWXqHAiamgnA6Af1unfy6bkXeNLVy4eMa5jyJub+rDLAoyXGeyYFsq9xLDePZp/WfCb3Ds4I9TF82B7B1EvjUjHjF8A16Q+Wi8Br0pp9k7mDsb3L2+w6npI1aGW+HU0rVIptCcCIMTlgseUhfmmDltLVa+To53CH/k/sdYMxLs55S9w/2vGwPMdbVbVPmjtPANwb8mIN6XNycFI7AmWT5wupBICEuDXpzT31UvNiKrCob7BNqNd/TVwZxz1aQLauLm8bhTzXPT/2NLAdBKoHoYv70gVvhMZ9Sk65aFG4PT/AwfzBjIowmxJ9pffPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Po2XhvW7DoS0JaQJ90Muf/FT3GT1t8zekIYan9+3Hg=;
 b=XHHBMV29gb3c4ZqpSltAyptCedFHyoPDskPrEu0f6TdnI4ZJAn8dGRyiFps4BBdfb858XOmz28gUAXnd+P16P0e5biOL9JwW4qZXSKRW0S1OLvEqV+nfsmT3jpZU7ZisVl1MYoWvUbzYpSw3i0w8INMDWkdoKWIAcYHM45jzRG7aVfYfM2WokOJIDKtp86e1Su61jU0U/ActUHNoFKmTKHOnwNdTKzaPxjaeu88fAiW6gktpfDc/B/zCmLNxtmM+QKqsuwWWvobyNeN1U64OzzovddRgS9STlNScyMXcRmo1CBA0vnuyDl/S6n5ZKHtGz4QlKdQU1wcf0V+NqzAovw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:48:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:48:29 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Topic: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Index: AQHbA4Hagboir6ZjOEqxQ/L/+DWWZ7JWGDUAgAAGsYCAA+SAAIAADnkAgAAAvwA=
Date: Mon, 16 Sep 2024 07:48:29 +0000
Message-ID: <7677a147a323964561a6e7089cb03c8f6f9021a6.camel@siemens.com>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
	 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
	 <20240913190326.xv5qkxt7b3sjuroz@skbuf>
	 <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
	 <524fb6eddd85e1db38934f49635c0a7263ae0994.camel@siemens.com>
	 <20240916074548.6thyqbak5ata7422@skbuf>
In-Reply-To: <20240916074548.6thyqbak5ata7422@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3348:EE_
x-ms-office365-filtering-correlation-id: c3103d51-a76e-4397-baaa-08dcd623f4b2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGFuTmpobWxmNXNtS0tzdU1FQnc2Tkx3QmpQNHBoU1RFRlRKS0Vkb1ZNc21E?=
 =?utf-8?B?NU9oOFNNcHFzUWI2Zy9JTm0rR0JmZkcrYnRWZVBNcUJmTnV1MUpuR3YwVU5Z?=
 =?utf-8?B?U1dRUW1HbHErLzJWYVdBME0vS3MvV0MzMFFUcERXOUdBZUg4SVc5cDZLYkNm?=
 =?utf-8?B?RVo1KzNMc1VlazFHVU5HN08vcks0TUpxK29QNnluYzYrWC8vY2o2ai9MN1RR?=
 =?utf-8?B?SUJXMzg2TEFtbDFwdDVRdUNWcXRNcHZHa2xOSVp3ZC80azd1R1Zpa01jOHlH?=
 =?utf-8?B?QnhIN1JRQXNFTGlPblluZXhxMU9Wdm5sN1N2dmxBcXdML1Q0aHFTd1Nic05F?=
 =?utf-8?B?cUl4bjBVckdVcDFZRFdFclcxQXNOcVZkZEIzR1BKcFdrdVlnSytZSnZNVWh3?=
 =?utf-8?B?M0hLM1lFUjNkZndyd1dvb1pBUDQzUGhmUnJyNkZnVlhwSEpoUEY5WTNLR2lV?=
 =?utf-8?B?R2cxTjhGdFVJT1htWUpoZmNZUzIwd3dLQitXWm5Jc3dtbXlvMTVUTGU1bkdM?=
 =?utf-8?B?SHBFN0ovN2VDYXhHaGMvVGdTRm5NQnpLc0RpTmRQSHYwRzNHam1aTm01cUVI?=
 =?utf-8?B?ZHRqREpjU2VVaW8yMHM5SDAyZU9FdnlxTEFVN2dvY0NhUllZSU5ldXpncXNY?=
 =?utf-8?B?MDNCTTVEM3VDeTlqVE9OQnVLWkNrK0pSanZmSVRKMVlsUzB1REcwMHBFTloz?=
 =?utf-8?B?aVhMMVVVRTRBQkN1WHV6TjNkMlhoK0hUYW01VEhleW8wbHpidUxXNTRyaitx?=
 =?utf-8?B?MllzTzliSUkxUlM3U3lOK0ZnNG9KUVp6dW9ReDVxWjlweXJ0cXYzNWFMT09H?=
 =?utf-8?B?cFdNWmp0b1paL1FMczJ2akQ4Uy9kb2F4RFVLVzN2MlY5MnJNeXQxL0haMlN3?=
 =?utf-8?B?SkROQTB6eUhxKzNTcm1xVlo0UGJvOHUwMmJoNWRRYlNJcUlYdFFhc1JodVlT?=
 =?utf-8?B?OHcvcWNxUmpUM0hQY285NXZORUxLTzNwdE00RjEydlg3MXNVR0hYb0YrbTA0?=
 =?utf-8?B?cTIzVFNqOWdGOWM1NUpUOHJvUjJ4Z0FaR3VVZHV1UWQ0VFlZRTdzRW9jTEF1?=
 =?utf-8?B?bDIvY0d6ZlBlcEdQR3U2OHBOWVYybEdQMWRQSlJDR2ZEQVpJeEREeUlibUYr?=
 =?utf-8?B?WVhoVHZrbzZIL2tzL2theWJiMkVBNEErRnYvS1lVa21Fcko5Zm9GTElLTHlN?=
 =?utf-8?B?ZmE5UUthS25HR1pIdExHMk03OE1aMjgwa1QyRUZETEpVOGlncURScEJjTk02?=
 =?utf-8?B?QVJmbE82SjlzOFBKWGIraDI2djQ2dmJuZEowd3ZNTlRTaEkvMjVwWFFhbnhD?=
 =?utf-8?B?RTVZUk5zUVBxa0RlNmhRcEFLT3BkRVZuSWh1a3JFOGNUenRtODFueGVJdUlM?=
 =?utf-8?B?dXlybVNsTzV0dGtpZmhNc1VCa0RQcXE0Z0NlOHZXcy8zNUY0RjNhY2NrUElz?=
 =?utf-8?B?NXg0Z1ZnclRaNVFNSXo4MlU0N0NXdHNZM1o2ZnhhOFhEbVNVSW1veWYvVlVv?=
 =?utf-8?B?S1lHMW1uQ1BBVlNHcGl1TWo2dHZhbXUvUnhHeFF6Y0lLaTY2NUFXK05ZVDFT?=
 =?utf-8?B?VnZiTi9zZzBRUkQwS2ZTTHlrS0tLRFBXdW5jK1NFZmNEdUlzbkt0K2NsK2RR?=
 =?utf-8?B?ZVpmQkIwWGphdndwUUMwWTZoZllhTWFncERWV2wrenY1Ym5GQ2QwZ3pzV1E5?=
 =?utf-8?B?ZUtaMHQ5QXRpQmx0S0pydVNaUUFjKzJoN0xaUVFVZFpTOWg0ZkNWSHBKbTlF?=
 =?utf-8?B?WUdzT09hdWNXbWlPSXNoZFN2cVhGeGpldkNwWDJGc0pPdTh3N2hmakNueStz?=
 =?utf-8?B?ZG5GWDBZbit1S1UzeDZnQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmtmdDBtN0xiUldHWDEybENvSE1jZmhUUTZLRmNiVFhzYlliV29lalZ3STFT?=
 =?utf-8?B?dVB5bHhFMkdzMk1HNXBSQlJnYlBzd09vS1FSbjBnMGxrVWxpMWVsc0Q0dGNw?=
 =?utf-8?B?LzBDZkNxWFZrWndSSzhXM3laVTJFbEJhakFsZUF5RGdhUE05VWY3MTRwQWZo?=
 =?utf-8?B?L29na0toRlJ0MzVua2FCbzJWQ0RlaUF4RG9tMTR2d2ZqSHJ4SVlDazZld1U3?=
 =?utf-8?B?U0tuTGk2V3NoVTlPcXRneTJPbWtqMnNENVFBS0tvV1NlM24wVUlDaXUramJy?=
 =?utf-8?B?VWd6RnVVUGpVN0daS3RnbmRGQmJKMlB6Qm4zWldJci9TZ1ZiV2Ezc2hFeTVV?=
 =?utf-8?B?N1BwbmlpUVY0dXBuWHJMS2wwVHdjOTNMMXo0U1c0M1Y4bjU5alB3WDdPUW51?=
 =?utf-8?B?SmhUQ0Z2bnFXeUlXRTBneExYR3ZwZStUelgyRnp1TnU4Zkh6Q25HU25KZkZo?=
 =?utf-8?B?ckYxbzVDak1PMzFLTFYvamFMa282bEVoYXJmcFlBSXNJWHJvQkdKMitTOGRv?=
 =?utf-8?B?L1phYU1HM0M3TmUwYU5Cd2ZzS1JyZVJLZ1k5RjQvV0FuckdaMS8zamFrUGZY?=
 =?utf-8?B?dXZGOElVVHpNalBwZW5pYXNQMklzZ1dDcXlNUU05K1V4amwzNmswNUJVdU1u?=
 =?utf-8?B?NDBCek5yczM2eEVKK0p1S2JNQ0ZtQlY1a25TNTY0OUljK0xHTENKS05Sd0F4?=
 =?utf-8?B?TmgvbCtGaTNsZGliNVlybjF0NjRuMElLa0lrdHJDQis1MXlsc0dCV3o3eFdD?=
 =?utf-8?B?Uk40cTNMTkhvVmxua1ptVGFnWFR4Vzh3Z1hOcFVBUVJRQWNiREdxMTdGODYy?=
 =?utf-8?B?MGxGV0dqenBxNXg3Wk1iNEE4WldPRlZONjdsT1ZTeGpKVmduRW01bzlhMDV6?=
 =?utf-8?B?Z3oyOWZHOStGTDgwRTFKMFlya2c5TzZNd0VCWmRIKy9ZckxXQTJqRGlMT2lT?=
 =?utf-8?B?VVlVc3M0TE4vTWJhM1k4YjNqaEpJS1Y0L1Z1dFRCVm44ck5VY09yZjBqWDY0?=
 =?utf-8?B?ZjRwRSsyMkd4VFpBaVBXSFpvZGVXQVk1YU5oMDl6aWhURlNEYXRCWm9QM2p5?=
 =?utf-8?B?cHZEZ2lvVkhITit1RGZ4TkdVdUpnS1lYanJOMnA3Y0dORWFtamt3N25QcFEw?=
 =?utf-8?B?RTNiTUl1QktZcWlkdk10VzlndWRtZEd5L0c5KzNFZDlRVW1FSC8ya1VGK0lB?=
 =?utf-8?B?cThMcEgzdDdWM0liMnZ1cDVNZ01yTEdJekVYcFhFUXNOcENrUnRXaFQvNGJm?=
 =?utf-8?B?ZFJ1V0NadllZSGF4dlJ0bjFGYmZWM2ptTlZEczlGdUUrYldQek5uVkUrWUdI?=
 =?utf-8?B?a0R5SlNVRzVJeVp5L2JnSVp1Z2M1Z3VBSUhNdGg5UyttKzN4YzZQWGRQOUFa?=
 =?utf-8?B?VXgzYnlPWnlSdnBrUVNtR0hrRjA3U2tINkFmc05IT3lPNGdyaGV3U0lFU1RL?=
 =?utf-8?B?NFkzLzFNSDMycGhXUU91Qmllb3ZwZWZBOEhKdm4yRURWc1h3RzNodDlkY0xz?=
 =?utf-8?B?TVYwR3ZrWlhIWTl2WGhwQ2tzQkFTbS93cnRtT3oxcHlwVHJLUDBxNGU5Zjkv?=
 =?utf-8?B?Z1JLYnVQckxGa2V4NmwrNEhsa3NmQkltT0FlTTVid0tFVU9VWXdZQTliMlFk?=
 =?utf-8?B?U1NGdjhIdk1aM1F4OEpSZzlRMHdXL3kwd3h6Q29ieldDTEp0MXVBUFBGQnNy?=
 =?utf-8?B?V2F2T3JpcVhRM0xYdVYzS1pWb3gxT3ZzVkRPOXAzZGtMZ2JIUk1BSWhnWmJp?=
 =?utf-8?B?VE1NTzNJMXE1aXp4M0dsQUNIenlBODV0SlphWlNYRUh3YWhkTnVIeWxDbXhm?=
 =?utf-8?B?SUUvYUlHOGR3cldIZmQ1NDc2MS9LZVhMcURsS2RldXV5NFllN1YxOUdPVlN1?=
 =?utf-8?B?TCt5Y3Vsb1NKaGV0eFpIMnlqcGxpMHIybitkSVpyTndsbTNWQ2NXSHBDU0xt?=
 =?utf-8?B?QUdFTDZYdzg4ZkQxQWE0Y0MzMGYrZVRWbkJldVJMWTlkdVhodjEvTU40b3lk?=
 =?utf-8?B?emxDdnQ1b1FLdFBHYjdaQjA2VXRIN2dnc3I1amFQQzRHUW10MVljc1poL2gv?=
 =?utf-8?B?L0daZlM2ZVV5blB1RkQ5T3N4ZGRNTVF5SW8yMWJGR1V6UTBTSndUTnVQQlJy?=
 =?utf-8?B?NDFQdVhDYVpBazJlSktVcVdSZkdJTHJ3aWFvQU5JV1dqd0YzMnZ2K1BBSXFp?=
 =?utf-8?Q?t6LBWvPnBUUmsLdMhzpKw+E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8F1C49D4A7FF44EBE24C3E87E5DA84A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3103d51-a76e-4397-baaa-08dcd623f4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 07:48:29.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkkywlLvfdR5kQJ1tmawTEl7Uog4mSiMo1rfq/62/sMpIkiq7BwavjPi5A3HZYG4cat+Uz9s0PSXzMVhXMizr1fI4iZ1lONCSkLXpyL+XY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3348

SGkgVmxhZGltaXIsDQoNCk9uIE1vbiwgMjAyNC0wOS0xNiBhdCAxMDo0NSArMDMwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAwNjo1NDowMUFNICsw
MDAwLCBTdmVyZGxpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+IHNoYWxsIEkgc2VuZCBhIHYyIHdp
dGhvdXQgIl9jdXJyZW50bHkiIHN1ZmZpeCBhbmQgTWVkaWF0ZWsgZHJpdmVycyByZWZhY3RvcmVk
IGFzDQo+ID4gRmxvcmlhbiBwcm9wb3NlZD8NCj4gDQo+IEkgd291bGQgbGlrZSB0byBtYWtlIHNv
bWUgbW9yZSBhZGp1c3RtZW50cyB0byB5b3VyIHBhdGNoIGFuZCBzZW5kIGl0DQo+IGJhY2sgdG8g
eW91LiBJIHdhcyBub3QgcGxhbm5pbmcgdG8gZG8gdGhpcyBleGFjdGx5IG5vdywgc2luY2UgdGhl
IG1lcmdlDQo+IHdpbmRvdyB3aWxsIGJlIG9wZW4gZm9yIHRoZSBmb2xsb3dpbmcgMiB3ZWVrcy4N
Cg0Kbm8gcHJvYmxlbSENCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K

