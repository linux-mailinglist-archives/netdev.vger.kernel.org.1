Return-Path: <netdev+bounces-130837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2798BBAD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE231C20ACF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07AA1C2323;
	Tue,  1 Oct 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yJm29el8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A01C174B
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783845; cv=fail; b=jsa//2eWeqwHDhny8wJAgHV/hhgzWqK+i9ipyoqBkAyexm/UaIxkl1KUlFm0HUaNdb3WCxJlDUVnuqPOTXPslt6QOkFqkqpGXES49wEYPs7EWCNZBuj54c2n0KzwLN4VeHNf1IreHUjBMWg/Zy1RWumIugiPIUs8+ejpIyYdEIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783845; c=relaxed/simple;
	bh=Afkwmy9HsOET9hAd8XT/NwGlSKNanHdmcnaGKNATZYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAEiDE2Vbpymje2rRdjJ3WfxmHlTIsik/hAfwms8fKCsA7skE6ZVo9qwyhIJrsD8k6drsTd3i9+IBH9wgGFqCTYQySO+JkZARmdLKKDLmDIsxWDKtrmmWyjiiOy7o46KeKirf9YuVst46C5uPXmaLAah4S5o1oq+p60DNmFcEKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yJm29el8; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1+ff40Spl4EO3m+X44Wwmqc/Ug3/LDSpD79IK2LWxaveqkKjcuapnGabSzfwSO4YhadqLIpMTln5z6MxKasMOMs6JglziXaA10TOtBbWeYI7LbiWG8E6i+LzNxThV9HxGx0UqekPe0glmj36p6kVlko7rumSvBkKawGV+51BG1Gk4CQoNIhbX21gwD41kRngbyzXbcoPyuM+2/F2taxwgCUFAgYXLO2YTD/ZtgYqublW0cB4dOT7iMA5i0659BBF81O68/6z6YBbrfjjmOpvJk4oA4cNIsVXcXwo7jTuSpLFG4WwTZVd7wBDUedNTeoBp0qWiGimO/WQRdL6wCCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afkwmy9HsOET9hAd8XT/NwGlSKNanHdmcnaGKNATZYA=;
 b=h5Q16rv+/dgiiTW77tSD6B0Y/M1Yyxa7b0i/0lXTVVw1zQVuBAYzVdrRpq28dEi5qnh5RSkOqQC0BZpzrJHce0jOqB4CIByNoW2CNf19L2sBdn4rKZgV+0nXU+HwTbxpeEd3a7KcN4oI+ZDCMazEDbi+0QQfn5SoG6Zc0Y1+BSeu7sGv4nYfehEXqNCV7HTgCG7m8FQpPek8bVN/Z6+ArroMFEaD57LTX54o9EAe6E5pxSMtKzd55avd7aaGDY1RGkT6P0SEIpcJDyERSIm1KpHyJY8pZ9YQ/F5p1kw4Mq2mivf0Z7loOsUyXakC4GNjJgtWH7K6NobT0zB0nKC9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afkwmy9HsOET9hAd8XT/NwGlSKNanHdmcnaGKNATZYA=;
 b=yJm29el8liwud0qrE3OcbfSrc90+TKENtJQfj9+zhQaq7y9ybS2CUii8sy52qxripyWEvENsQ4F2bUE7zwpePrZUwHmifcIUgX1Sx1pCQgFClxWTt5dSluDRxAOeRhxeJqRrI4yNM7vAdefQa+fnr00ZUphi590PjfEbYTNr6jvZOna7oTEzHxSDDKazl12/oX789oCIVOxBBCwJPlzxd308vXBtEc+QoG5Y6vI63N81ytTGK0AZcEQLO3tIau1kivmftEdk6q/XwGAXHB5h8JxWSufkGM5XVVBz0KqirCLBU0AkCxQ+SvRLjJYTwDJa0wQtyet1Yjrk78c4+wCDdg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 11:57:15 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 11:57:15 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "agust@denx.de" <agust@denx.de>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Topic: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Index: AQHbE+CTRy+Tklzr+UaZ7E82hLhQvbJxwtsAgAAHfwA=
Date: Tue, 1 Oct 2024 11:57:15 +0000
Message-ID: <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
	 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
In-Reply-To: <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7216:EE_
x-ms-office365-filtering-correlation-id: 9863b882-7310-498a-1db0-08dce2103154
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUNWQ0lmY1FCWXhQNE5HTmxSbnlGbDl5d2FPQ1dtWkxUdlRxSDIzaG91R3pQ?=
 =?utf-8?B?TFhCSUFTaFNUZXFld29WdlhmRjVVK2VUSmIzMU9YaWpnMVB6VEoyRVg1d1No?=
 =?utf-8?B?QVAxcEdyNjZHTW14dUZWQ3dPbDlFVVBjTm42SGhVenplenBHb05TVVEwSm03?=
 =?utf-8?B?NjlVWHpLcFUrU3hJZTBHNmpzSkR5dWkrQkNUVU9qMUN0UmNhOVc4STVRTFNE?=
 =?utf-8?B?TnpLaW82NEcwMDNENnpud3B5Y2dFcTEvRTFnOER4VU1DNU8rMURCcnZEekpP?=
 =?utf-8?B?VWI1TlkvZlRxYUtncFdBRm5BMFlUazFQWGFDaDZzR0h2Ui9zOEw2VDB3TXIw?=
 =?utf-8?B?ZDJVMHFESGYycm9ZK29qTS83VmEyTE5lL3QzTm5kbVBRVlFqSmhYdVg5MTBw?=
 =?utf-8?B?QnZsNTQzZEtwMXhKcnpBVStmZ0s3eGpadEdBMUlTZndSa1lOa0gxcmxlQWpt?=
 =?utf-8?B?RmJtYy96bVp2dTZqQkIvQlRvdW1adlRlUUlCS2h5alpIVmYzSkxzUlltMEta?=
 =?utf-8?B?Y0hCZU9XUThGK09pTEthQkl0VHQxNW15MytBaEN4VUVMZ3RiYXUrY1J0Nldi?=
 =?utf-8?B?cnN1R2NGRHE0MlhMRS90R0dLcU5DTm5MWEtFUDF2U2NjYmEyNWxZTVdQdC9J?=
 =?utf-8?B?Y1NRUFMxMVRBemxKbHB1cTRFRWpISlJ4empQWXhTSC9kcFlTcnBFNXVvVDYz?=
 =?utf-8?B?aG9PSVFYSHNkY2JoZlNGOG1ORzkrSjhndUpkSVhLa2k3Qkc3WmZDSjF3VVhM?=
 =?utf-8?B?SnE5YjBMaTJRU1ZUUk1kQUJrc3dvZnJ3RVhIZlM5eHU3M0Y4cTl3QkFMS0hz?=
 =?utf-8?B?OEpiVE9Cd0l5SnpJNnJEdHIvR2lGRmZuajA4M2RPdlMxejAxWFkvRVdFNWNa?=
 =?utf-8?B?NktYa090cER2ZjlCMEZNV04wcE5Eb1ZBNmRqM29wTURQcTU1TjlPWUFUS3Zo?=
 =?utf-8?B?MFF1VUZJZXU4a2RRb0U0enZjY0pVeWxFWUdvVzdncDRjSFJXNGZsK0JXQ1BX?=
 =?utf-8?B?VlhhSWFnanpJR0cxV21veStPb1hocnY2d094S2VEQlVIeGE0M0FaUzRYb1ZW?=
 =?utf-8?B?OGU5cUkvVkpIRThXbk1BWXVET2ZVVW9wVjREaVMxOXJBd2owaHpRV3J0MytS?=
 =?utf-8?B?OFIvQ005SXpHWHV4VFZQWkNXUjB6SjVPMnpZRVphQXIxc2tvcXdVSExGMGho?=
 =?utf-8?B?WUxSbEltVkVIckVtamFTTURwck5OK2ZBR3lCWHJubUM2dnBaem41aDRlci93?=
 =?utf-8?B?eUc3RGxTVlFuSWMxM01GdEJDQlNZQUxhVzk1WVlMUzM3NFZDSDZING9xM29J?=
 =?utf-8?B?SU1uNHBZNi9ON2NiNzZVKzJvOFNscHhiNjJDUnkrbkpzSmNzWU9lN2E3UVhq?=
 =?utf-8?B?enFkeEEwODBybmpsOGI1eWd0ZDQ0QmNTdVdoL2VLTWRkdFlTVzJoREljZVdV?=
 =?utf-8?B?a09zakZFUUU0cmFrcmR0aldyc2g2b1NkTEo1VGtvaU1LUGlSUm1VdzNwNXZT?=
 =?utf-8?B?RUUreFM3MjN2M05Cdk1mOEFqcCttR0gwR3BUWTBxb3ZQOTMxWjZpL1NpWFFO?=
 =?utf-8?B?OTZENnJqNG1qNDVodjBoRWs2NStsWTdIUDRHL0MzOGZGMUp5bXA4aGlSQXpU?=
 =?utf-8?B?cXZScGEyWjF1V1FrSlEyY0ZHYWg1OGhhZ3F6U1VzSEtSUjRJYkM4Z1VYZzJl?=
 =?utf-8?B?Q1l5K3pFb3ZsNjZWbTdoRXRGUEhFR1lDeGZ1NU9qWEFlYkFhekVZQkZhek55?=
 =?utf-8?B?dGJsOTY3bHM2ZEdDTG1YWWQ1Mk1vTlFWRjI1MVNyVERDU3R6aTdXeTZ3ZjNK?=
 =?utf-8?Q?P6Cn+bUlH5DUEOfSdjFenwp4FAfLRu3NUyIyA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXB2ZnEvYnNyR3NycWI0OW1kcGU5WUlCUnNsd0RqNWU2YVVKMjlzL3N2N25I?=
 =?utf-8?B?SjBVSlEzQy8zQUVxVERHYUxuTjV4N05KSmgwRm93bks0aCtxQmt5YWpnTUlN?=
 =?utf-8?B?RnBrZHdZNE1wb2tFY09Jc3ozRWx6cXlFam9YQ0hzUmgrTGI0SUVuRzZVT05C?=
 =?utf-8?B?MFZ6Nlp1UzUyZ09VRnRWajBhdFVWVWVDenlvVnQyc212WVlmWmptM1ZwWTFE?=
 =?utf-8?B?TFU1bHdjbHhtY3d6b0ozQWpBTzQyY3luVXR4bE9hdHIwNDRRdHArczVRZkdk?=
 =?utf-8?B?NzJ4UzdoYlRhZVNMdVlWSTYxQUNCcFdmQ0gwNXlFeTdFRXFZRXpWT09YdDZs?=
 =?utf-8?B?MEszUUR0K0ZqakVuajdvZFpCRy9IVGttZ3BOTkphc3A5N2o4VHBzOG8zNXMz?=
 =?utf-8?B?MnZDeTR1QkpQU3UzajBkWkZZaW1WdzRMK0hwZHdRRkM2Z0Qzd1NoN0puaitW?=
 =?utf-8?B?ckp4Tm8wQitEMks0YnBCNzZjWU5FaU1RcmlnNGt0TSs0Qnk0S3dUcWc0eit1?=
 =?utf-8?B?Nmk4QzNDUnBkQkpIdVpBRDVhdnFucThSY2Q4Z0E2bHNuWDJlTEFwWVR4TzhH?=
 =?utf-8?B?SGdaenBmb0wzWTNRaUJXZEVNWG1WUXlad1B4SExSNVc3dDhISmU5U2VScytL?=
 =?utf-8?B?aUN6eUxBb285YmtGK3ZkakhacXVZM3VmaCtTTzVZdWNtSnVwaERibEdYTyty?=
 =?utf-8?B?aWNPYnFtUnk0QXQyTXdvam1YNVUrMXozeHR6VTA2Wk9WdWUvbTFHaDByUzJF?=
 =?utf-8?B?Ujd1ZVYrWnZnMjVDVVVXQVlzaG5CaXFoaHQrazFSelB5VW4xNDFmbTcwSjBF?=
 =?utf-8?B?YVdPeEJ3NnJ1YTF3TnlhTWJJK0xNVGJ0Q1pYNnJ1emE1T2I4ZHVHTHhkbHdR?=
 =?utf-8?B?Z3pjVjAraXJxZVBLa210ZkIzeGZUYS9UUFU1cFAzOHFiVExUeERxRWJVaGgv?=
 =?utf-8?B?TzJqNmtPMEJOUG1wcklMRFFyL3hucEVYTFVvdG5tMTBSNEwyRXRsY2xWZkQ0?=
 =?utf-8?B?RklhVjZ1a1ZLK0x6c2hZYWNNUlF3V2pvaDNqSzJlVmxyUFNpM3pWZnU4RVRq?=
 =?utf-8?B?UzUrK25HMEZ2UkhFY3UvOWpmMWZaSWZCcGxLd0tQUmVDY3kydTExRE1oN0dp?=
 =?utf-8?B?WTIvWkZwQ2owRnhFcTRxOGhHMnNmcUVFOWVncTVVUXVENFdpVDMxU2JtaE1F?=
 =?utf-8?B?dWNXYnNvL0w5M0ljTEViSjlNd2NsZitXY1FWTEJLbmQwSzJERFA3VkZWS2ND?=
 =?utf-8?B?dnFVdm1vb09yOURYakNMWDdic2pMZDFpcDIxaGMraTJ3TlJvMWxzZ1I5eTA2?=
 =?utf-8?B?VGR3ODlBUmpuSjFMSm5WaVRlSmhjamVQOWdmSDNlL20rb0tlSUQ4bUxFTkNK?=
 =?utf-8?B?cVJKTStlQjI0TVdkMUZrWHhhZVloaWptdVJYbzFuTzdIbGhzVUNna1FRYnN6?=
 =?utf-8?B?cXVXaGVXTklXSU5ZVkQwNllNMG5RTkV2SmZMZUE0ZHRJbGZDZzdvbVR2b2M4?=
 =?utf-8?B?RmcxOU9Jc0VxeVVNTERDVzkvL0R3cXkxSER3OEZxcUFVeHZaWnBDd0I2RkxD?=
 =?utf-8?B?Z0ZiRmcvZXNrY0o5VGxtZ0x2VzBMYkYxYUdEU3dKUmNPVnZyaXo0R0Vndkhl?=
 =?utf-8?B?dG9RbHlsS0lRYms3Rjltb0w5UFFuUzl3WG0xNGJjd3VWaXRWb25pS1V5bis2?=
 =?utf-8?B?cGNGR2F6Q3VLdFdCNUkxMVVFclZkdEZsQW9DWDZucXNSaVFxc2xkWUZqSnNH?=
 =?utf-8?B?cDhNL3R5MStQNk9OYWUyelJrdFBsZ0hyazNtTkw1RGVpZ2xWbmtkQmYyeUc1?=
 =?utf-8?B?YXo5MjlHYlJHRTgwT2d0Y3RjQk0xZUtwbnllZXV2VU95RXNPbjl4UHFyU285?=
 =?utf-8?B?UjFQSGNXNzVQT1J1M0Exald1WnoxM0E0Vk1IdFNUT3c2V3BKVXYyOFovM2Yw?=
 =?utf-8?B?NDV3b2JGcWlLNXBYM3NjOC9QQWY2b0lQTUJkWXlCTWoveVoxamkzWW1LQ2lj?=
 =?utf-8?B?MEVjVmY1MHUyTWFLTHQwVTFzc01yOUJPaVZvN09EOW12K0hJNHBFMmlnUXE1?=
 =?utf-8?B?SzlGTHhDOFZWZ2JEd1JMZ01zRXQ2SEdRSEVRdHd6RXdVMEc2UkRqaFVJQVVG?=
 =?utf-8?B?d0dYOVhvRmQ5M2NEbnA3M2VPemVvK1JGZVI4ejRadHJVRHMweExBMDNxbDRW?=
 =?utf-8?Q?aZUevCwiWV0oHSYpuNk+ooE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD702D619D7066438BDB5563693847A4@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9863b882-7310-498a-1db0-08dce2103154
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:57:15.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqniGwmHyRyXWKCIVrr+O4KTwQ/cNvZIYh4KisURarumQ6bDVKKI45Lu1FzrBgeLdM8vilkbpNHo8c0c28WiNJ3wBaKtc/TKemDHe2Zz1y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7216

SGkgUGFydGhpYmFuIQ0KDQpPbiBUdWUsIDIwMjQtMTAtMDEgYXQgMTE6MzAgKzAwMDAsIFBhcnRo
aWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBJIHRoaW5rIHRoZSBzdWJq
ZWN0IGxpbmUgc2hvdWxkIGhhdmUgIm5ldCIgdGFnIGluc3RlYWQgb2YgIm5ldC1uZXh0IiBhcyAN
Cj4gaXQgaXMgYW4gdXBkYXRlIG9uIHRoZSBleGlzdGluZyBkcml2ZXIgaW4gdGhlIG5ldGRldiBz
b3VyY2UgdHJlZS4NCj4gDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9uZXRkZXYtRkFRLnR4dA0KDQpJIGV4cGxpY2l0bHkgZGlkbid0IHRhcmdl
dCBpdCBmb3IgLXN0YWJsZSBiZWNhdXNlIHNlZW1zIHRoYXQgbm9ib2R5DQplbHNlIGlzIGFmZmVj
dGVkIGJ5IHRoaXMgaXNzdWUgKG9yIGhhdmUgdGhlaXIgZG93bnN0cmVhbSB3b3JrYXJvdW5kcyku
DQoNCkhvd2V2ZXIsIGl0J3MgdXAgdG8gbWFpbnRhaW5lcnMgYW5kIHNoYWxsIGFjdHVhbGx5IGFw
cGx5IGNsZWFubHkgdG8gYm90aA0KdHJlZXMuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpT
aWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

