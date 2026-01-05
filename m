Return-Path: <netdev+bounces-247165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F197CF528C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1763088B62
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC2344054;
	Mon,  5 Jan 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hNnO81fC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C633BBD0;
	Mon,  5 Jan 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636058; cv=fail; b=WGoJJJUtzO9ZryGpO7dYqWQLfS4Nc/mYSah3++f5gVDm4M0uI9BQ4ctipNB4whFNiN6mGOP/JbdB7rtwDbTPk/nKUtWEFsWbcmJuI6oxFUn0B6/u0H0qbBXaAbVfWdz5BrIonXGuyOFR89IjSHKzC/KdhI7Tjb6aarOrVNqgRFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636058; c=relaxed/simple;
	bh=DjXg8eULHtA6bBbwyHpUOUMvNLdvTamGzE02an4zVPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urWCqPUGU0W1M2YiI1yzhebAvrGMbOrAE7ho+RuPViZJJZ6TkxR7+nY1AE5Om8Tnpm+br5JCf1H7dwuVpGI3216KyEO53n21epoMpp2NkxilEqKH+gkZTEGBUf/945rqZcqE92erb3K7815rhDk3bqgu3SdN/Qp74HGoNxfSw3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hNnO81fC; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGTH+mqfd7lQ8Y1x9y29U1PEI7075DESh5iXX3RApBDTvZqTz3undcH08mgz4o9cMAB+wgKVJB5dkCl+0ugusipFrIpSg2Qy3bwdNdB+1jbA1QLU+BOLxs5L0jJZPm2wNgip/AwxRgxPUCLOd2NJQkaaTYOsXhdeWKUufL9KGp7ciEYfscTUj71/ZecpJlJ5M1i1fiaXMrzwlbcnN/AorehzWNsYMsFFJYDscvMcgZ4mVuRJmUp32j5pQZXwv5Dj2MW6Kakne5NL2qkDAjBkK+87a7zdMOO03ik9vC0E4TYG+cqbidsSXht0tQ9+ZbABkE/ECSZ6ZmrZY/bbx76Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjXg8eULHtA6bBbwyHpUOUMvNLdvTamGzE02an4zVPA=;
 b=rIfpdC8gUn5Zj9XPVEvTio0/RG1ill4XBiZxdQhMeO3IKUSqE7D1CaNgfun4cZaRRFOeVsbxhf+Ko21YKu4AplPFfgwOVrHyeINeiMSxAP1+sYrtYQDZGKWsP5tUZQaagzvTMLpSGvcAUjTuV/n1alxwuXBsxoslm3wiAGNsB1PDmTYBv5A64l7X4GRzMCjjSviUq87sw5n+t2UvFgly8xYfbhsUBdFlZVtmwEARb8qMdcPXOXguWz1LVA+VuhZAfwe7Pr4Ib8h4RSL/b1aIf7uS24hRpBDX5ZcrYIX5Z55UxYm5O793l2lreh/2SBUryf0aMTX16xISTM21LjVwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjXg8eULHtA6bBbwyHpUOUMvNLdvTamGzE02an4zVPA=;
 b=hNnO81fCeXvbioc4jHPULabscXByRyt1iPCPP1LUyJApIT4piDaJ3kucVMmvwc/LX61z4GnGUuihj439owukCoT/PAXdnRBUPmB5Epiive2CcEMqftE+J9ECufEv9y9PtbUyJ8ulBpTMM8wy5B/ELt/Reqqs+Y8kjOkDx75yl9Sl+CziXHwRT+wVI7yJpFOj7/TNkLPGmA8rRysXv/oocyhts4j8uyZy2zhhj6H4rvL+TFz3JoifXFXT5HIPHjtw47fI4fxUT0UyL8W14LkFCidvN4CWjWOhHOoqJJNftkuu18iqV+GRNtuICd8ZMMv7IFioYXffzQG6lTuHg8kzrg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 18:00:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 18:00:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear
 R(G)MII slew rate
Thread-Topic: [PATCH v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Thread-Index: AQHcfmxQpjVa06BIVUOu1hyCqMD/u7VD3ZyA
Date: Mon, 5 Jan 2026 18:00:52 +0000
Message-ID: <3cba9f17436bb3329ff4a54b6d2f8948b2aa7d5d.camel@siemens.com>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
	 <20260105175320.2141753-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260105175320.2141753-2-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6319:EE_
x-ms-office365-filtering-correlation-id: 92c3254d-fe00-4e48-95ea-08de4c845e1f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2RjSGZ3aE1ibEZVNUY2ellvMzAwK3BqdjlxM1BSQ1g5R1dxZEI1Qm9vNnBU?=
 =?utf-8?B?VDNsR2Z1ZFhIRzRYTDJjMVk0UGhjY3ZGbVUyWnJmS1JzK09XcjRETUtkRk1W?=
 =?utf-8?B?NG5aUm41cGZGWHlMekttR3JVMWVCWHJxVjZGTFRVYjA4R2VOS1JGMkxBMWVp?=
 =?utf-8?B?dVRFRFhqVk40S2VHTHBwaE9oUWE5ZXBUUDE0YUJmbXprdUlXZ29GOWU1cnh2?=
 =?utf-8?B?MW4zdFh4bFUzMWxyY1RnWU5JaFArRVFQbHVKeTJ6UWV0VnlReTB5OU8wdXlS?=
 =?utf-8?B?MzhiZlhLaG50b1ZPM1VMWE5DVEhrQSsxckJVU2pBYU1yL2lSZG9WM05rWFdk?=
 =?utf-8?B?K0RQd2RVazlZZXV4UWhsODAydlJlRlRHK09ESy9wVithQ3lOSG5lZ0QrYnd1?=
 =?utf-8?B?azIrWndCWDNpWFhkeURrbTRRLzdRQkpBYmw0bUNaeTNlMkdjWTJtTGVHdkJx?=
 =?utf-8?B?d3ZtZk9rTTdJQkNWWkhUcCtwekRydHZvK3R1SCtZMENaUmNrdE9DVGRIOGg3?=
 =?utf-8?B?STZyYmJ4V2pNQnBGVzBwSHVuc3ZheEw1K3Z3MmNWcWtWQ0NXUFlZQWhCVEg5?=
 =?utf-8?B?OUZlMks4bWJ6U0ZRVDA2SVBpclplME5nb0g3ZjhYYTlqU3haaVkyTlN6aUZD?=
 =?utf-8?B?aUc1ankwR3d4NzFQbVFUOGVRTk5RTGF3QVdiSFp4K1JmL2wxVFgxRHZGSkZW?=
 =?utf-8?B?QmFEQ2ZYL1pwYW90aWg2TkMrQi9sSzhTU3Q2WnhGdU55SWVwSURWM0Q4cFcz?=
 =?utf-8?B?dWo1d3JlVXI1eXBvRzB3UlREQmUraWZXWHhWbVFnNjdwdEZwSGExbkYrb1Jj?=
 =?utf-8?B?eUcvbkVHNnAxaUZGejNQY1A1bEl3YUdkZ3MrdlAyN1VTNHJxQ25GWUU2d0NK?=
 =?utf-8?B?QWxoNURtbVBEU3ByN01GT1V4Q1duOU1WSENFeGxoWVVGekphMXJWR2tLU0N0?=
 =?utf-8?B?bnc4ZDc4NUlOZDluSTdrMW1PYmhWOURDUytwRkpMQ2M4ais5YmlVTkw0anpu?=
 =?utf-8?B?UEhlTktsSUhqMzNGZ0FlcEpSaDNVN3lYdmZ1b2pxQVp3SWhLMDAvR28rbC9x?=
 =?utf-8?B?K1dkT2ttRXhMVXBqa1l0NFJQTGdYSW02cnV6cFc2d3N3eEp3aGl3eUhyT3ZB?=
 =?utf-8?B?bnErakUzdFNCdWVhK3pQOWNIbDh6V3NZMzRENTc5RHdsZmFNbDhnSUt0bTU3?=
 =?utf-8?B?Zk9Ma296UHVYN09jOG1OK1JWczJJajlIUjZrRVNDOWdnRnJHbXJRR3VyV2pi?=
 =?utf-8?B?Q2dqeGRUTWsvT2NHMXNGYzgzWmxIb09xdzlURjdxQmdzYi96aWdJZHEzeHZw?=
 =?utf-8?B?aVE4WTNiUE83WkVwSzlaeW1IcnV6dGlMZ3FjZDMzTjZsRFdsZGIwN3VKeFQ5?=
 =?utf-8?B?UXVjM09rKzUrRXJrVVRJc3prQVVPQ0EvTFNQNzRaYXJnQ3ZDSmpyelErVmFa?=
 =?utf-8?B?SkFQbmRsWmIwK0RqUklNc0l5cFYxak1TSDVWdmtpM1dpNVNRWjd2QnF0Wm94?=
 =?utf-8?B?VUZKcDdoak5sd2pGT2I4MUFEU1JpS28vTmhTUTlreDIxK2VqMkV1TTUyeTNx?=
 =?utf-8?B?RFZtb0pneXQ1dU9wSnQvbDQ0REcxTTRJeUY1ZGVCVkczY3dJdkg0UTBJMVUx?=
 =?utf-8?B?bDFvMjk5Y0xIbUdkdHpNdzRWWUUyZkV5RWpOaFJFS01nc2x2RzNESys4Nm9X?=
 =?utf-8?B?Yi91TXVzRG1LWjd3SXhBL0sydUcwcEgrekRrU0NpeldkTHRyeWlLSlpncXU5?=
 =?utf-8?B?U0IzQWVERSsxb3JZMm1UL1lpZjRQV3JwaXdrV3BuMzdNVjNpYVMrVXNJTmVn?=
 =?utf-8?B?NjFRZVBuTFpkY0haano5T0YzeFhuNmNGYlFWVVlGd2lZZldLU280eDgrUmJx?=
 =?utf-8?B?K1c2U0FMUjAybjdwd3p2SkN5TzlGUEN4N3FPS2dvVUF0cGVlU1lKTTdVc2dl?=
 =?utf-8?B?R0ZjbWp6SC9PdnpiRTFXaElxZVdTQlBVTC9qUzM4RmErcVZiWmtPSW5zeWIv?=
 =?utf-8?B?eFJIZlZBUXp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzhreXc2bjFRSDhkYksySmVMQ2plTWFhSFAwNmxjTURNbTJ2S1VsczFsVFdh?=
 =?utf-8?B?OE8xV0lXTFFwMERHMGhVQ3pZZUY5QTF0QlA1c2NaY0hCNzdjNG0xQUthVDhP?=
 =?utf-8?B?T0xmSlp1UkNBNnp2MWFVdElNTlBKeThwSHU3QnRXUSt4bDArcFZELzM4V2dP?=
 =?utf-8?B?bzk0N0JRUnNWdzFyL0JEQTc3czc1SllQblR4czRnZGRSMWxrZ0lEODMvTXpK?=
 =?utf-8?B?OXAzWUdMNHZ4Rm9COHltZHg3S3c4ZXQxbHBPNVgzb2szVktFTlloUE1MOXRT?=
 =?utf-8?B?VldQRjBLWS9nWTJ5Tm9UbGVGYUhyeDY4L1BtcGZ0bDIzRitnMER0UGtVRTRw?=
 =?utf-8?B?RmNKMlhhZ1RZMXlUY2R2eTZxUXZNQkFQczBEQzZiVVE4SEpZRG9JSEs5ci90?=
 =?utf-8?B?N3lLcUw0NHhBbWZiUEIyV0NvUXpaTEtrRjVNMUNyV25rd29YY3Jhb3ZuSXda?=
 =?utf-8?B?TXlhaWdQdk5RTENzYkZaWlJQZjJ2ZUVsVDlNL2pTeXYvSFYvM3V1ajlPTnJU?=
 =?utf-8?B?MGlFWmtqMi9WRUJ2a2sxck9aUmZ4clBRSmVRMHFrTzhFNk9qcGdSdFZMQWwr?=
 =?utf-8?B?K2tYaTNndGdtQmMrNEtQeWVMSnVIbDAyL0UzaEtrWGZLZHo5VmFFQXdVWStX?=
 =?utf-8?B?RzUwdVBxc0lxZ2xtUHAxTFYwdG9rN1NtMGs3L3FYL2dxRERUMG5LYVR4QUFX?=
 =?utf-8?B?cmpOV1JMbGhrc1VyNTRaWHkwVjRON2x3aVE1ZmQwZG5ZOEM5ODJhakp2OVpi?=
 =?utf-8?B?dEJSUkZaUWlpZVh4clBDb2V2T1FROWdyRllXRjc1ekxqYTIxMWZzQjN3T2k5?=
 =?utf-8?B?UVR3YTA3eDN4eXRHQUJMby9DU2ZYZEpnMFpPa1dib0twTzRQRmpvUnpXVHd5?=
 =?utf-8?B?UkR4MHFJUVBlMm96QUY2SHJJenppbXJoTHhXcVRtcnY5TDQ2eXo3d29mUTh4?=
 =?utf-8?B?bzg0Vm82MDBiUHUzcytmeTdQeVBRNmVsbzBzU1ZiZm9OaGF6bDZwVnp6SFdu?=
 =?utf-8?B?bUVOSjV3WXhIdWd3aXZPYlBCQ1lieHV5NDQ5enhNdDhOS0ZMZ1JRcHo4ZCtG?=
 =?utf-8?B?d1dWK00rZmloU1lOVkpQYWc0UDZzZGpITlhCYkQ5QjZ3VmNzVEhFY0M4bUpv?=
 =?utf-8?B?UWNHZmZ3TDRPcnVQbStEajlQVndLNU9iaFNRc3BIU1MwejlnVVZqMHgreERQ?=
 =?utf-8?B?aWxJc1Z6aUZFRFFhd3o2ZTc0STJJMkd6N0JEbmp0Z1RROFRBZDVMQmd4bHUv?=
 =?utf-8?B?NFRWZnkwb2N2R21sUytuTlhHUWN3clRoMFZQM3FyOWVMU1dIelNTWFpFRHBQ?=
 =?utf-8?B?N1JBWmNRaXRMR3Jpb0t3ZlBsODFxMVlUZXJ4SUY3ZjBsL2dTMWJ5TVJ3OE91?=
 =?utf-8?B?ay9NYnY1eFNDQUd2UThCMmhtejRSWmt6Vnc1bUxLbHFXSUU5QytsQUJ1VjNJ?=
 =?utf-8?B?dDgyRDZibnlKaUQ3M0hlZEFkMlRyRit6NGRRUi83RDlTKy9FNU5WbDk1cFlk?=
 =?utf-8?B?WXF3R3VUQlVOSllUOTQxbTRLeXBncHlReUZuTDZDcVFnVlhSaDRxNVFZUHRy?=
 =?utf-8?B?WTBsY2xwdkpDR2ZHazlldThJU3JVK1BiTWMrMUY0dk02bHBNdGZxdndlK2dt?=
 =?utf-8?B?WHdUQlcyM1EyTy9Ebi9CNURVOVhrTG5IekVTRWx5ZFQySTJScDlXVldTWlRr?=
 =?utf-8?B?MzBWWkhkRDJ1TmVuZVhBTzhlSWVDV0ltM1JtbjZzenFUVC9xaFJsVzlHak1y?=
 =?utf-8?B?RDNvMkoycFJ2d2ZJV09wa1RQaTA4NFR6cS9XT2RYZG1lWGxmK3FrMzFsY3Ft?=
 =?utf-8?B?VnNQZ0NSNnpqWnJ4c0hweHI5K3Z0YVpsWkM1Y3VWVCt1emVoa1EvQ1ZRYko1?=
 =?utf-8?B?U2tUWEhXTnhFdTZsVWh3S2hSc1RLVGgzeFBiTks1Si9lckdrZFhTQ3VSOVlx?=
 =?utf-8?B?cTFmRUE2RnUrTmhtYTVGYk5GeHFaZWtWU25hU09vV0Iydm5jQk8zbEErVlJw?=
 =?utf-8?B?NHoycnFmVGUwbDhpY2VFdUFkZXdKMkcvWE56UTN4OUh2NG8vNW9IanZ2UXRt?=
 =?utf-8?B?bTkrQTRmS0RnaVRybVhISXVJSHptQ2xWaHlhTmlLd0Q0TlhjTHk5Q0xxb00w?=
 =?utf-8?B?NXFNOVA1SHJMNnhzSTdOcUJYWXFWK2RqNmxPV2ljczZwZDk3YWFxY1puaGIx?=
 =?utf-8?B?cjlqMW42V3V6d3RSVDF6MHh4RDVuZjFCc0VuTFpIbFpKUldhL2hZUTNadDdu?=
 =?utf-8?B?ZFhBTnFMTnpKaU1HOHZ1R1kyejA1bDErb0crRCtkQXBUUzdXUStLeXhhL1dx?=
 =?utf-8?B?UmtRNS9mdkk2d1hlU2R4VjhkeWtWc0FvaG0rdWRpcEE5RDIzUU54WVdmMG5s?=
 =?utf-8?Q?EjkR7cSff8xD3NLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA7BDC365FF854590CA543B8C1C7260@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c3254d-fe00-4e48-95ea-08de4c845e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 18:00:53.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: au0RkKDzWRR+MsMEHpSZDDBKoFDohFfkglA2fEnC0GxfK0ri1RTw9V9epT4qihElMQP47PEuNoWn2opKNMCQBYYAM8jWl3sgKR+V/MnisaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6319

UGxlYXNlIGRpc3JlZ2FyZCB0aGUgdHdvIHBhdGNoZXMgd2l0aG91dCBuZXQtbmV4dCB0YWcsIHRo
ZXkgd2VyZSBtZWFudA0KZm9yIG5ldC1uZXh0LCBJJ3ZlIGp1c3QgcmUtc2VudCB0aGVtIHByb3Bl
cmx5Lg0KDQpPbiBNb24sIDIwMjYtMDEtMDUgYXQgMTg6NTMgKzAxMDAsIEEuIFN2ZXJkbGluIHdy
b3RlOg0KPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVt
ZW5zLmNvbT4NCj4gDQo+IEFkZCBuZXcgc2xldy1yYXRlIHVpbnQzMiBwcm9wZXJ0eS4gVGhpcyBw
cm9wZXJ0eSBpcyBvbmx5IGFwcGxpY2FibGUgZm9yDQo+IHBvcnRzIGluIFIoRylNSUkgbW9kZSBh
bmQgYWxsb3dzIGZvciBzbGV3IHJhdGUgcmVkdWN0aW9uIGluIGNvbXBhcmlzb24gdG8NCj4gIm5v
cm1hbCIgZGVmYXVsdCBjb25maWd1cmF0aW9uIHdpdGggdGhlIHB1cnBvc2UgdG8gcmVkdWNlIHJh
ZGlhdGVkDQo+IGVtaXNzaW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gQ2hhbmdlbG9n
Og0KPiB2MzoNCj4gLSB1c2UgW3BpbmN0cmxdIHN0YW5kYXJkICJzbGV3LXJhdGUiIHByb3BlcnR5
IGFzIHN1Z2dlc3RlZCBieSBSb2INCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NTEyMTkyMDQzMjQuR0EzODgxOTY5LXJvYmhAa2VybmVsLm9yZy8NCj4gdjI6DQo+IC0gdW5jaGFu
Z2VkDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9sYW50aXEsZ3N3aXAu
eWFtbCAgICAgICAgICB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZHNhL2xhbnRpcSxnc3dpcC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9kc2EvbGFudGlxLGdzd2lwLnlhbWwNCj4gaW5kZXggMjA1YjY4Mzg0OWE1My4u
Mjc3YjEyMWIxNTlkNSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9kc2EvbGFudGlxLGdzd2lwLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvbGFudGlxLGdzd2lwLnlhbWwNCj4gQEAgLTExMSw2
ICsxMTEsMTMgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgICBkZXNjcmlwdGlv
bjoNCj4gICAgICAgICAgICAgICAgQ29uZmlndXJlIHRoZSBSTUlJIHJlZmVyZW5jZSBjbG9jayB0
byBiZSBhIGNsb2NrIG91dHB1dA0KPiAgICAgICAgICAgICAgICByYXRoZXIgdGhhbiBhbiBpbnB1
dC4gT25seSBhcHBsaWNhYmxlIGZvciBSTUlJIG1vZGUuDQo+ICsgICAgICAgICAgc2xldy1yYXRl
Og0KPiArICAgICAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+ICsgICAgICAgICAgICBlbnVtOiBbMCwgMV0NCj4gKyAgICAgICAgICAgIGRlc2Ny
aXB0aW9uOiB8DQo+ICsgICAgICAgICAgICAgIENvbmZpZ3VyZSBSKEcpTUlJIFRYRC9UWEMgcGFk
cycgc2xldyByYXRlOg0KPiArICAgICAgICAgICAgICAwOiAibm9ybWFsIg0KPiArICAgICAgICAg
ICAgICAxOiAic2xvdyINCj4gICAgICAgICAgICB0eC1pbnRlcm5hbC1kZWxheS1wczoNCj4gICAg
ICAgICAgICAgIGVudW06IFswLCA1MDAsIDEwMDAsIDE1MDAsIDIwMDAsIDI1MDAsIDMwMDAsIDM1
MDBdDQo+ICAgICAgICAgICAgICBkZXNjcmlwdGlvbjoNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRs
aW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

