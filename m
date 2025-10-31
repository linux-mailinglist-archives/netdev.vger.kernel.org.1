Return-Path: <netdev+bounces-234616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284AC24AF4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F691890869
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE68B342169;
	Fri, 31 Oct 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="QNhVz7Ue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="UMbfnk5x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92F341AC1
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908694; cv=fail; b=Mmw5X4NisY7RdC22zZgzxolbN4gG8sP2RZLWNzJxUHPeUkRmAY+0uppYz9yn8gr8IV0I6fzAfD03sHnztGLowjoHp+iPPp+6szMHCH5y3BF1pm3V0FpsQrgEJhk2oiQyC2yJuCMLXZ3mM7h2xWQfArX0oKjeCApE1xyRNZZS+B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908694; c=relaxed/simple;
	bh=HpxdMqbIwJ0Kr0BpeNWD6T5uaXx3eb07ZCf79lKBS1U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UsN2IcddnsD5vKDXHDZG3rJP5MuGV3Lgh3ooKtQzi4bTyNA38ezu0tm2gAdTUNft7OUP9ZX4/y2rAbCJvLmZu9izv3v9hSdILziXic1qDDDegaYFshUp+Csp/ssZTn3NM+Ol3zYttat9msEeu1Bd96P6Xs6+YT/Ca7sgrgDILyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=QNhVz7Ue; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=UMbfnk5x reason="signature verification failed"; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 59VAb7Vl3650868;
	Fri, 31 Oct 2025 11:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	jan2016.eng; bh=78Yt+EuyUEWtqnYE13u8qxo5fTUf9KV+kpo9n3FZzTA=; b=
	QNhVz7UeJkXGkJAZ1es8Cf+0Dwnga+JrwFhVoPTXXhJ0srOD8JrExoLFHYJasjbT
	vl8JpRosWpS4f0mAhs6m3j4YJLP35faEljGzLuR86iGydunZI/t2OpsMBV4GsX4c
	QFNvbPwF/tC5TH+zpm3O+UepKTNEH3XvDAX+47dWa5ZhaRpKOZvuwAUi0viCobAe
	40W8/vHQk9wVX5vJgiU86WnnjyIWsGX5RgL+sQplzC5Z6c3mgQV4fIdr7NHf+6Ux
	rPHYXUrj3CS8BUeiL8CSKN9DckD19k2wKIbtWedW0BcdxRnRcM43IuRtq1VyLjw3
	OAKv0HKYLHGF+9LKs/pFgw==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4a4eujrn85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 11:04:43 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 59VAdjcY022855;
	Fri, 31 Oct 2025 07:04:43 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4a34ecw4at-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 07:04:42 -0400
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:04:23 -0700
Received: from CO1PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 04:04:23 -0700
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by SA1PR17MB4818.namprd17.prod.outlook.com (2603:10b6:806:19d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 11:04:20 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:04:20 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: skb_attempt_defer_free and reference counting
Thread-Topic: skb_attempt_defer_free and reference counting
Thread-Index: AQHcSlYbM+I7L06e50iQUkSS3NdY2Q==
Date: Fri, 31 Oct 2025 11:04:20 +0000
Message-ID: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|SA1PR17MB4818:EE_
x-ms-office365-filtering-correlation-id: 6e7efec7-f5b6-4a39-9a4d-08de186d3dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|4053099003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZlQ4WnZSUUVZbmFjSzFYU1A1UHpqSFF3bGhQdmN0bEVJNjVydGpaSE5LdGhS?=
 =?utf-8?B?aG5FVDBKYkwyNVBFLy9xSm8ydERFWGZJNFdUVVloRlEwTUpISnZ5U3FSY1Ja?=
 =?utf-8?B?N2ZDZm9SRHA0Q1BuYVlheHhJZjl2ekZ3L1ZxMGZzZEp3ZGxMeTNYRUgxemVh?=
 =?utf-8?B?ampzR1hmcWU4T2VGb0VaNVpGK1ZrcHUyVlhaUDZ1TmFUclh0cll3bTQ2YW54?=
 =?utf-8?B?YmdOSm1ESFF1eVRZNTZhVCtNMXcwOUVGdWdPS05VeWNFRVNtaHlRcEx5dWhL?=
 =?utf-8?B?c0xsUXlVeEN0c2F4YnRHWXRzZ0NnL1ZXdFViYVRKbzBlcFp3OFRJMzh6cnNv?=
 =?utf-8?B?UFpRSVlyT2w2Wm9EMW04M2FFWHpESFBaWms5bU9WeVBicWRiV3ZRT0x6SGxk?=
 =?utf-8?B?SDNhekpxSC8yb2ZxaWhnWElHOW9EZ0U0MG14VXladWhKN3J3bndOWVUyenk5?=
 =?utf-8?B?bzd5aU96Nnljb1c5UUxPQ0dUS2dwc2FBZFVhelBlS3FXSGtSczRkcHlYV1Jk?=
 =?utf-8?B?QnlHcCtBSXZjMTE3N0wrdXd6cXVBaVkwOTUyNzhCZHJqNEZ3ZzE4N0NxODBZ?=
 =?utf-8?B?NHkyQ1RXRkdNRFVhOXhmNjNxOGhxMlhEcTNLVU93UkhXTS9rNVUza01UZHBH?=
 =?utf-8?B?YlYxWEdsbCtwbVNxYWcyNXViNUR1UTA3eTNKUzVmS3JaclhZR25TejIyZkF0?=
 =?utf-8?B?QVI4VGtnbkJqZnlKWnBWWmk2SGtZYmRoRFhrb0FiOExqamdvZzF1ZGI3b3Zt?=
 =?utf-8?B?bGFvOGdiUHZuTVZqNG40UGlwaG94VG5uNTh0cmJZT1RPZ3JuaS95cDNiUkpI?=
 =?utf-8?B?YlJIUko2cjVUL1lWSFMxS2NtRmlseDIvd3NLWXUvUi9wdG1rWnc0cFRnV2R0?=
 =?utf-8?B?TVJ2STg0QVRSejVsdUpKeTRTdjBnanA3OWVEMWpmQS91MmVKWEljL2VnMDJo?=
 =?utf-8?B?SXJCMDlsNEE5c3JwcGNnR1Y0Y2IrSXFpNjRocjR1UmpjR0pZakhKMTJFcmJp?=
 =?utf-8?B?UkJ5bXdBUjVET202V0lOT1RtVDJZbVJDSTdWWkhObVg5QlkzVjJ1dXhJcHVC?=
 =?utf-8?B?L2s3aGpLaFNJSEVsOTFoWTV3OHFIeW55WXFoYUZmbHZNdGh4NEpFcjBuRmp6?=
 =?utf-8?B?bUpxVnk0dE05dlFUTmpXeDV4eGtZQjE4R2RJZW9RSTE1V3loM2hXeXZnZlkw?=
 =?utf-8?B?RVlhbjd6QnNKaUNyaWZBODZrQ1Nic2pmcFJNR05UMithQllPM0NiSW55L3lL?=
 =?utf-8?B?VCtDQVJ0Skh4UUxzb3Fjd3NLU3pkbFNmWkgyV1N4Q0UyVTBnV2VMLzlGOTdw?=
 =?utf-8?B?UjI3bUtQZXFGbTJ0T1JXWGVQNTJmS1J4UlhzeWNZeFZVY1I1OWJ3Mml1UDRi?=
 =?utf-8?B?ZnNVTHFSZ3R2Tmd4cXpyNUhTWkxRbEtSZ1lpUkp3VDl1bjM0UXV2MlBLWFFt?=
 =?utf-8?B?MFM5Zk9aK0IycXJvY2hHbG9pZVpzUFNVTTk5cGRIWHc2Uk1YaEVmNFN2aURj?=
 =?utf-8?B?aURRY0FqZDcraHd1Zlo1bmFpbFZreW5EdWhXbDhzRlZCK0ZNTFZrVDc4Lzh3?=
 =?utf-8?B?bzBOSHBrR0pzRXcwa2pnTWNSN1NoaVV4NC9RUlR5Wkh1RFYvMFlqWjMxbEFO?=
 =?utf-8?B?K1BtL0VNU3RaMURmZWlIN29oN2FMZXNzcWw3cFExZ2UvVnVhYXFySVplMkRG?=
 =?utf-8?B?dDdzVmJMc1JFVWhpV3FKN25NV0MvWHR5RFZ4Tk1zdlRZYk40UDB3TE0vWkp3?=
 =?utf-8?B?Wk1la2IycGZ1Um5aUW0vRVZxUkt5VFlmaWtmclZ5UVhOcWVkM3owbjM5UnB3?=
 =?utf-8?B?Wjh2YnBNd05SOE9xMlFRampob1AvVUJaWTEvNHRkeHhsWnhMakN6bUxzdDBj?=
 =?utf-8?B?dW9DRElWemF2aU1YNU5PdmZaamZBZFh6MW1mdXNWbmdqTmFETm5CbFNBamg2?=
 =?utf-8?B?cTdoWmZnMWxiNEYyU0hlbUJiUnRHSDJGeU1ycEFrSm5GQ2VlcGZ2b2xtT2pk?=
 =?utf-8?B?UkZROVhrN3lpbXJ5UlUySVI2cEdMWUUwMFBkdEFTb0RLVmE5MU1nRllrbG93?=
 =?utf-8?Q?wj6ibq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2FNLys3Q1ZCWWdjUTg2aDdHK0c0REw3Szg3bUJMMS9LQzFnTTZBSlJwakJy?=
 =?utf-8?B?WGNzR0VLR2l6ZnZ4K2NreU8zcWEybVBNY3o0RERqbFVjSVJlOVRreENReURR?=
 =?utf-8?B?bUdtb0tRNCtCVkNaRDF3RUFROUdETi9wVmtsSUExMURSc2JPSTZ2eEtuWW96?=
 =?utf-8?B?VlZzem1BOHdmY3B4ek95VFh6MmpnUnFiVkxZQnVKNU1HU0ZlWEtNakRaM1hi?=
 =?utf-8?B?TG8yRUFIbVpvSVFhSER1VDZOekJURTkzYVI2TDRkSE1QV096S3J2YmFlL1JL?=
 =?utf-8?B?TjVURDVjdnpMelp6NEFCUWVQUnUxcFJMNGNUSm1tSkJiOVdzWWgxRzhaM1pD?=
 =?utf-8?B?VUNtTit3MEREUG53eDIvUnhCaHJuZ1BUM1F5WWxDeG9lT0REWWE5YjI3elBB?=
 =?utf-8?B?ZHJlSERrdVM4cDRiWkViZThvWEJLSHhxbktFcHo0L2JBaGhKeDI5OUdCV0Yz?=
 =?utf-8?B?VUJHSEFtSjRNamhGRWZEcEM0bGVBcmIwTmVvdDFFSm03Y2VadGJERWRmZXJr?=
 =?utf-8?B?SktnMEt6SHU2Z1pTU29La3J3V3RBUi9CMXpGSlBXaUp1RzNrSWphRlpmbjJW?=
 =?utf-8?B?MUpEOG1uNkRzWVpxRHVoTmRCWk9ZVUlnS29YZ2orbCtHcm5FYXBxbWsrRWZt?=
 =?utf-8?B?TUhsaDc1Ym5hZkNUU2hENWNLUWEva1NpZ0NReUhzYkthSzRvTENETU9DUkor?=
 =?utf-8?B?bldjbmplNTdhM2NPaXRDZjJuSHppdllhTnRrUGpsbjhoSHV3OVZmVEZkOGZa?=
 =?utf-8?B?MUI1VFo2Y1RrMC84b1ZkTWxPbzMvZW80OUp0OFB6dDZ5dGxuYVJPVTR4RE5o?=
 =?utf-8?B?SC9neFVhQkVLeGFWQWIrOFNWcEFWS3NxTFRWVjEzWGFJeTVLcEFKdHhhb2xl?=
 =?utf-8?B?eG4yLzRRVmtVcS9mMHI3c1lLbmlLdGl5NWtDdW83bVpUVktYZjh1WXBkbjBz?=
 =?utf-8?B?dVZhSkxOTGR2d1ZNbEdyT1N4Y2NtbzdTRVRVUnA1ZW44N01tVHpLbUlnZWVS?=
 =?utf-8?B?em1kQWZHQndFNnk4cVNkWnZmN0lZRnRrVzdFL2J3UVk5NkJFZG1LU3lRcXd5?=
 =?utf-8?B?am94M3dYRHRkVmF2Z3IzZnRtNlM5U3k5YnpuUEs3MTdzWENOeDcxWmZ0R2Vw?=
 =?utf-8?B?SjFSQmpJaWlSY1h4ZUVZV0txZmhWUnRSUXQ1dUJYYXYvcnk2L2dGUnpoV2x0?=
 =?utf-8?B?RDhyT2R6ckNsc2JzRjZUYmNzenBzTHkwOG1DQWwwMWpPQXA4ejVzdnRUKy9o?=
 =?utf-8?B?UDI2eDZYUDhRZjgyWWxLSjZpSGtOcUpabXlNTzVmR1BteU1ydjUyMzF5Q2Ri?=
 =?utf-8?B?SmRTMVMyc1pBWTBiSEFOVGtaTjZMeFBaMERJQ0x5OUhJQitXNVdnWTRqM2J1?=
 =?utf-8?B?MDRQWmZYcXZKRzJNcmdlRkR6Qzl1b1ViVUR3MFp1Q0FqZlpYekdBWFc3WUVV?=
 =?utf-8?B?Zlc5RHBoNHkvRkx4aWRmamVSMElLYytsWklVZ1dOTVhCZElQNktiZUFCUFQz?=
 =?utf-8?B?ZGNldktkWkF0aFZlUENPdi9BOEhvUFNKZGJnNjQ2RGNkMnhpdHJOaE5hMXky?=
 =?utf-8?B?WEcwaHhRbHlvWTNDV1Y1dTZ6bWR4Z1Jzb0VXN3lwU3lvNXpHaUw2T2xsZ3Iv?=
 =?utf-8?B?MjZlNFB0T1F1N1hHK0JTRVJoTmdkZllMS3Y1Q0dWWDdDcUZSTXJoM1BWRjd5?=
 =?utf-8?B?a0JSSVNCT3h3NDArVExZbUZaKzFNK3cyNEFMV1lMaTZkVXFQeFIwN2VXRml0?=
 =?utf-8?B?RW1McVdheEE1KzZCMmszSkt1NTVxbHB6TURPakM0LzhBRk8zT2RMNWttaWJJ?=
 =?utf-8?B?R2VTSVVkazlkUXFISW8rS0RDYkdKUTNrNFFQRW5xS2g4UjllNHk3WGVzY2hQ?=
 =?utf-8?B?d21WUE51YWhHdjhKTkt6bFd1bGZ5c0dVU2o2WlNtSWdTZG5OOXEzUkxUeGEy?=
 =?utf-8?B?Y0dld09Ja1FGR2Q1dXQrU291ZDRDMHgxU3J5ZlBpZWZJSGtqM1Bmb1Z6bHIx?=
 =?utf-8?B?eWwxSzlLQUtzUnpzZ3lWSG9yOHdVa3lzMHNEa24reXRZam9XVStJL3J5OWdl?=
 =?utf-8?B?Z0tobW9iNGgvam5VVmlVaWVwWFkvb09rY25kOTJtZzFVY3pHdHNITUxGOFU3?=
 =?utf-8?B?V09jblYwRkE5cU84elJTeHZvTGQwNzQ5bjFzeGtqYXZJOXpacjlGNVc4MU1n?=
 =?utf-8?B?ZFhQRnVOdmU5U2o0ZXc4dkF1d3F0QW8xN082YjB3NTBxMnlIU2V1RzJ4K0lB?=
 =?utf-8?B?bGlEanVxaUxXQ2UwUkFGT3J4SitRPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duia9RStaJRweysVJc8HWnZva+dPKMX1dGhgpnVk1mJ7W9NVMXulafmTO4cAnj3AGVJhOBbKHLdB1WNG4T4P45i/yGHUi7ILCYRdodcIC3pSP5PtTj1FCXQ3c+kBCGoxn4zePAZ4nmDJuhgKwc7RCpvwtGI9nLUD7xU+QWqmhdUcBk/Czf5T6OSmSuRzD+IGm1UuS/+GcRp9ChMib7NLriU+lyOSL4TvBE9/qRDoqTq4qlDrzK4mEUaY4EpjfJ5C58Xz2YMH8o4U8ga7gqxS4GsiRvQENfF6RAKsIZZWlp8Wga0bvui7i9UYHRcPbqLUA7P1TqXl1//8n013vqswNw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtXG/yXnbejQ2uIPSObONVK86QlOXDzmIr9al+Ywjro=;
 b=QAb7IqUqGvLhOjF9CLkmB5ZmSQvhJgNC/6IsDDZS3ARpIFGf/DvbUur57nAvYKSZMf/onJOQ4e0Qh5wu6uQs/0JswNKAlxtQhQspwN3rsUraizQzfomvYUy57a5n6OlsY7mmp7UyuSxFR4+XccDHFxOdh3mk86sQ0ZQxPFiy2jlDVsgotTdqw5QhcZxRCr+69rFZ+969h7HMT9rAoZap+TcREY3axmNF7vbOFH1/KuqrGGTlAAEYlxYhsf6lRk4zvSSGLOwxmGB/Kzc0ehJWLVAz46/bLkDNgik6D4ypBClyzMv8EV9CK5yFR1CZI4AV0NRf19me/duLS8XHDyBB0w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtXG/yXnbejQ2uIPSObONVK86QlOXDzmIr9al+Ywjro=;
 b=UMbfnk5xgATQeyhpa+8aPPQc6xUAXearyD8sOV0L4TS+f0DDbbwPTAgXI+DmbinwTs71UwMDuO0rycLOw3hpYQ7mTmbyOhR1+KvsNXoQyDEAGTE28NdGmUl1GF30m+TfDyzxjaZueahrCsjda9QeKCfs0OkjnDt/1ILhpJu+F0s=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 6e7efec7-f5b6-4a39-9a4d-08de186d3dd8
x-ms-exchange-crosstenant-originalarrivaltime: 31 Oct 2025 11:04:20.1218 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 108gPA27XN4yphXmNPyBhuXn9ZYF6UQqaqAU7smnayIyeQinTATLwrl8rYy+RlBSZcTrYSuMQ1G1/u4XP3cYfQ==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB4818
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_61C3FFB8-4F66-4320-BD81-DF906EAA4E84";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=963 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310100
X-Authority-Analysis: v=2.4 cv=NZzrFmD4 c=1 sm=1 tr=0 ts=690497cc cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QeNz6ABa_XVftLjxsM8A:9
 a=QEXdDO2ut3YA:10 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10 a=kppHIGQHXtZhPLBrNlmB:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMCBTYWx0ZWRfX6Wa1AjXG+wOu
 h3qV/U+B2UzPvoosenIZU1XvMmjvanBwENSMjEcFyz9PD/OHIqIwn410YX87JFsDQelyBQZNq+0
 lolfvqTTg7KS6d/WpogWWhdrLDnDpltwivhHmf1KfEQOjEJzpp8WC2+pYKxxr5Q6ERm+1sNvE9n
 rXhZkKemO4TUAeM4sUbIcAhNBTQoPL2KpIfiVKIWbFx6tmMXmzAaY+35Qi7Ay/No/cdUug//jH5
 H9DViXY6pb431qnBg3VEe/29ThU2RJ9vlasqIBpK8Y8AkuP21O8w9xMDKlk6bXGxiBTZNY07etL
 nEldhqXoiL/d6gKee2tUXnsq2GY/xebHP9ryJM+eflAttv2IbTJFEnS4U3G1vEeGyb5yTTvJpql
 GNxJWyeOFZN/x1bf2NM/yGQN9N7Hkg==
X-Proofpoint-ORIG-GUID: KVitOdd8Up54ZMqj4ij7cPOuJr_YexIj
X-Proofpoint-GUID: KVitOdd8Up54ZMqj4ij7cPOuJr_YexIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310100

--Apple-Mail=_61C3FFB8-4F66-4320-BD81-DF906EAA4E84
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

I=E2=80=99ve been looking at using skb_attempt_defer_free and had a =
question about the skb reference counting.

The existing reference release for any skb handed to =
skb_attempt_defer_free is done in skb_defer_free_flush (via =
napi_consume_skb). However, it seems to me that calling =
skb_attempt_defer_free on the same skb to drop the multiple references =
is problematic as, if the defer_list isn=E2=80=99t serviced between the =
calls, the list gets corrupted. That is, the skb can=E2=80=99t appear on =
the list twice.

Would it be possible to move the reference count drop into =
skb_attempt_defer_free and only add the skb to the list on last =
reference drop?

Thanks,
Nick=

--Apple-Mail=_61C3FFB8-4F66-4320-BD81-DF906EAA4E84
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCdAw
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJzCCBMyg
AwIBAgITFwALNmsig7+wwzUCkAABAAs2azAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyMDEwNDUz
N1oXDTI3MDgyMDEwNDUzN1owUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1lMOTEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw+xt0nZCcrD8rAKNpeal0GTIwS1cfPfIQXZHKRSOrSlcW9LIeOG4
E9u4ABGfGw+zChN5wtTeySgvvxE1SIwW13aoAscxyAPaS0VuEJGA6lUVsA2o+y/VD7q9pKIZj7X2
OxHykVWBjXBpRcR9XFZ5PV2N60Z2UBlwSdbiVp0KBXzreWMBXnHKkjCSdnbVuvOj3ESrN706h3ff
5Ce7grWg7UWARnS/Jck1QAEDqIHLSxJ3FhgbJZBt6Bqgp28EqkP+dQxzp//vnUDIwxBzpSICAMsk
d9I0nsdVvHV0evJSjqDgLF9gw7/4jjjQGW/ugHBytYSBEjDFuB0HOat0va8SjQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUWgue6rVjEAcBSPcAqJXWGxAZi9gwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0kAMEYCIQDg4lvtCdYN
NSoA7BrmrnhzqPrsFhQejDMGHCeY7ECV5AIhAOV93F+CcxakPdapxskTdtiTYz7dbj7AVto5kQkB
66NEMYIB6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAV
BgNVBAMTDkFrYW1haUNsaWVudENBAhMXAAs2ayKDv7DDNQKQAAEACzZrMA0GCWCGSAFlAwQCAQUA
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMDMxMTEwNDA5
WjAvBgkqhkiG9w0BCQQxIgQg8DwtVY2jHgv5sQauDuLbs97e0n4OOmFZzMLvLXutauUwDQYJKoZI
hvcNAQELBQAEggEAcKONn2fNolyvivLTU9/d2cbx7oSqtmAhOldR++oufcFS8wzXMX5r5+vkwAFi
vWQFg/uYxL/UeBUrdvvNObLN0rXQi+DCg0ijqrLbwthdJSlo/ENVEOLJlgb792/X0Cba0kCR52Uw
ILqBEeJamODU4bQa22buXJ4Fsul66T2LMm03bSGRKb0/k8Brs+VQkvou6C54swfLNjrR3MgOA2TX
56E8enhBwraS0mWrRKHRRD+fIs4j8NzgzYNGEB8a5yI0tdyQx7xt8793C3a5Bz4ux/n/7kuTLhr5
4bJ/NqR956hKMbbUoTXh/hoATsfX+9t8sBt7UdV2D/ey6jkHHHsaugAAAAAAAA==

--Apple-Mail=_61C3FFB8-4F66-4320-BD81-DF906EAA4E84--

