Return-Path: <netdev+bounces-130887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E498BE3A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37281F21BF8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21361C578C;
	Tue,  1 Oct 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VOHdgz/8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA91C4627;
	Tue,  1 Oct 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790318; cv=fail; b=mTYM2SejcEhn2Q4HQFj82k0BSdao+NygArHidpV9P6rw+Etj+KP1yXnWdxzQA1rGQyp/Z118bSrXUAmUWSKg7QXP+zYGh8eZ+hU/8pYw0hGp41xTKG0KDSBC7vXW3f1Zgl464vtGDH9qJmHwMtBxqvhaU4CoRmIXpbWwu216Zk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790318; c=relaxed/simple;
	bh=LCm1LwLbcVX2YVAUlS/ukHhtWetBuLJ86LBy5Wj220E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwobChfUxYTPAGCVXudbl98jGXIyqlnszBsUX99TRb7R2X543kw38wYC/N3Ew9FUS1V7eUb4+w9PiCI7RoyYinH+3nzM/u/610z7yDgVtiS85kxFhamZ5sLF5oVIsbnoCb5oNbiw/OzzrR4nL1Y2Wn4zCiYCYLAnQ2efZ+wKTtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VOHdgz/8; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ3yyJRURULnEv6oNqwJl8gmlPC0Jdh0vDi4ki2C9fFPtso2J/EfOsUDwv7ojsm0/oCIFasFPFB6nLfvD4bPboyZ3Tl7ZmcDalaEEuuGV47vzE+0+WtsblIOT5zGtYqVy3sGFjjDJlRDwLh4iSBPJ6A5IT8qHS83lC/LES7XG3Np/JkXzNvnkpQKni875+JSK+lzY15a6sIliVTtzezHCP/64SirVw7cKS7fOVEwR2UOrGDscOtbVJRSvBo2RXQphkftAq4yzlH3aekdoY5VgynJ884uM5nT+RCgih96AXQlT98dsm0opjGL1zS9LcDsPDbcg09VgDKtqDgUiYI40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCm1LwLbcVX2YVAUlS/ukHhtWetBuLJ86LBy5Wj220E=;
 b=j0TZO7To/MCWIyghES6dh6Axs/szybSDeFi+MZH6o/ys8tmTXNliQeXzT844yW1Ps2AttDbAswsIk4C5HdD18bHxQVsnpwyEkiEMe7bvIoxvKqlSd0xUY2abh1X4mbV2nKXT+pF1BDpzB8/nwuIhvXxd1RaDZmU8fDDZIyNG3+tK9VZZxwL/LL46wg/KOnGluYAUXWYAeaA/s9mNTZE2OwQt9Kvj2S7d0GIUJy/z7JP5EykVZ09Ry5HJBAIvdn0h8XqBaX7i5gOx0XGuBiHpZAMze0BMWM1oU0JZbyhDNXkKKsBlxvnfhtaRgwnkO0fvp5XYhHZMTaC+PkKaxEVb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCm1LwLbcVX2YVAUlS/ukHhtWetBuLJ86LBy5Wj220E=;
 b=VOHdgz/8e8cRPrYA95vLh214XZoVADA592BCDurP9I/FzAMYPn8/SsoamCHspt6IvnDFqAClf3kNz6L6qRTS3urWlv/dfXWx+rCWecvw8mcXYfzYqNB8cUvUNAXdp0elEBv5lcoGpqfjHu1UuLlaO+aSLne+tIrVDtPRWlAkAjKzLr92M/9I7S5NQA+C68o1TxpXjWtXSZun3GKZWIBpOOjZUN5rILKpHWkQ77QndKbfe8862TtfD098cy8ANaKGn4f0LJB1E5fjPTXrWnj103WmmIsWIHsgU5NGvtz7jJBWtR9sm9etr1ULlm4nY673mpA9hkZfQlcxgJed75LsGw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 13:45:11 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:45:11 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "inguin@gmx.de" <inguin@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dmurphy@ti.com" <dmurphy@ti.com>
Subject: Re: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Thread-Topic: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Thread-Index: AQHbE9r2Doq2VGEaREuQkQ81wCcCNbJxtNYAgAAv0oCAAAPngA==
Date: Tue, 1 Oct 2024 13:45:11 +0000
Message-ID: <c26909742e1f2bbe8f96699c1bbd54c2eada42ce.camel@siemens.com>
References: <20241001075733.10986-1-inguin@gmx.de>
	 <c9baa43edbde4a6aab7ec32a25eec4dae7031443.camel@siemens.com>
	 <9e970294-912a-4bc4-8841-3515f789d582@gmx.de>
In-Reply-To: <9e970294-912a-4bc4-8841-3515f789d582@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3507:EE_
x-ms-office365-filtering-correlation-id: bf704378-a26a-45da-368e-08dce21f4572
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTF5RWM1eDZNamlJTTIwUTIwcEw2QTdBMkYwbXR3QnBpQXVyWEI5cjBTeWRJ?=
 =?utf-8?B?ZisyM1piMzBPTVhoMVRFbnZrZWV6Mm1qbndncSt0NldqS2dldFRHMEFidWJ0?=
 =?utf-8?B?dC9uMEF2SVlSREVRUE1UNWtuMmo2c29ncmxON3hYNTl0UmZNSE1WaVZxOStq?=
 =?utf-8?B?RGN2b3JzUnphQ3ZPeW9hQnZxZ3VQak5OM2pIMDJCVHpOQUs0bnZSdTUzQko0?=
 =?utf-8?B?QjFIOWo3a0lWVExyQ2lIRnhmU0NyODRyb3EvK2FqWUJjalhOeFZja3pORzRx?=
 =?utf-8?B?YzBkeXVhRGo2UFgyZm9mRG12UzJUd2Z6MXp2QmZZQWk0UytSTDZDcGg2TDBz?=
 =?utf-8?B?RnRobytjdjFTRlJHRnBpcWxnNTZIUUNkNE4yWGx6NDhMNmpWL1JRVmtUSkEr?=
 =?utf-8?B?QnFTTDNiakJobE5VRUJsZjUrNllpMFFydCtCWkxJZTFkcDF2Zi8xcndrbHhT?=
 =?utf-8?B?cmt1SGFOc1dtYVBXdkEyK3BhTVVSeHhxNlJMZXB4RGVuQUhHUkRkcFpUaGcv?=
 =?utf-8?B?bWlaWHJhNksxQnJUZ3YrWW1iS2JuOFBzMWR5NW0yY29OZ2xJVWVrYnZkZ3JH?=
 =?utf-8?B?emNDL3p2WlJROGZEYmUwc1QreHUzdFlDZ0VUQ2hKTGlFQ2tqZkFDa0tGdEJt?=
 =?utf-8?B?dWdvcnRIN2dqMUVYRStIYk1NUDF3d0FDellYUERxd2s3RVMzMlIwL3BndmJt?=
 =?utf-8?B?WHRhNUwwUUtvd2lSblI1SnFieWpmby9OTVo2dk84VHZTaytyTjZEUGpKaXpR?=
 =?utf-8?B?UzNXYlJpVmlTZ3QxNHJEVWExWldkRWs0WDY5dUNMOTdMd003eHpsZVBmeUlZ?=
 =?utf-8?B?VC92MUFrVTgwQ0NHZmt3YWg0VXcrVmR3dmlKZDZJN0NDb0pYcjlWVmN6Ungw?=
 =?utf-8?B?bUw0U3U2OFM1ZFlRZXFPdEZBcFVqWHFDTkp0VDBENHVYblVpRDZlYk0zR05z?=
 =?utf-8?B?YnBiVXg1TlU2OFVWSnBPNll1RWlNMkNxYjRiVEJtZkZqdWN0RzYrVi9IV01r?=
 =?utf-8?B?VmIrUSs4NW80QW1Zc2drT3R5ZHV0dk9tNlJ6eS9JNzRZZStKak5WZnZVdDA4?=
 =?utf-8?B?MjIwWGlqbGpvSmZoRFF5Q3RidDFGOGtpVE5UUlZ1NUZhUVdod0w3K3Z4enVw?=
 =?utf-8?B?WCtvNzBNeGZIZUdtWEJ3bFBEVkdiOHRDaHlIazNpcWc5Y052V3dpYWc0ckJW?=
 =?utf-8?B?bFZLVitHWHVlMFBkaXZiUllmU212NkZ5SHpJZ0Y5TTFqdWh5cUI4WmM3cGdY?=
 =?utf-8?B?R0xrTWlPd2pUK09uZ01lbGFqQnhRVjQxZU9tcVV0dTlScGZUNUpuajJHMFkx?=
 =?utf-8?B?RExsRHV0WjZvelFpZmtaM1BwM0tRcFVsMUcrRVVISEl5WHozUzN6SGw3cnZN?=
 =?utf-8?B?NDR6cUl1MHRWdDNXdlZxc1dzaytVM1hsMytZeE1hZlpzMEpFUEgxQ1oxaTZr?=
 =?utf-8?B?aDNMWS9XWG9hcUozekJkVHk4TUNTVnNwMThIRlRpZ3BPOUNGejBleDFBUWlJ?=
 =?utf-8?B?ekNOZFE0Z1BPUm0xUFZtV3cxYXo1NmUzZzNKQjRaQmZuaWtLaTh3SW0wSVFK?=
 =?utf-8?B?b0N5T3lwYmhYbjVwdnkvU2RlalR2OVRud3FuRWlsb2NaZkhUZm1FZVhOMGJh?=
 =?utf-8?B?TG1xN0lVV3lCRkZlOFRGcGpZZWlMTXczbm5ZcTRWVXM5S2VWR2NqeWRqZEFL?=
 =?utf-8?B?Y0oxNEwrVGJpMm5id042U09wa3VmYUovSTA4bjc4dkNKS05rc3JNMy8wVEpF?=
 =?utf-8?B?djE2WmVTRWR5UTZHL2lLb3JrK3NjQTRvQWVDTTdFN3MrSncwbVZvd3hIczkw?=
 =?utf-8?Q?Xec+C2LyfLAjGOFGk448W7QOLrNLCPlu4BS7U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWI4YnM2SW90SW51NUFpT1BYZmRBbDRZWjljVDZYc1BDbmZPWkI5NEtwYVY1?=
 =?utf-8?B?ZHpUUExxZjRoaU43dVJUaHJubTNZTjhFT0p6WXFhajNKemRJS3MrMGhkRTVY?=
 =?utf-8?B?bTdJQ1hHaG1rRjYyKytaT05UclB6em5jNWlQNWpGSzFaNGlIVXl5ZW9JREpR?=
 =?utf-8?B?SU9RM3ZvL3RpT2gwUmhvdFZ6R1MxYk5LSUJZcHgxYloxeUEybC9kWURWWTI3?=
 =?utf-8?B?cmJ0Q3BxaE9taWg1OU05ZU9lc3orajI1S2QzVlRKRmdLZ09wNCtncDE4azlz?=
 =?utf-8?B?R0I3Wk02WThHSU9YRDF1RmZXb2RGeUsrWmpvK0tWV0x4ak03OENCNFFVbEpZ?=
 =?utf-8?B?dnZrNUVXT2F2dW90SzRUb2kxcmN2MHB3eHB2bnl4aW81TUxZU0U0V2lPaDFM?=
 =?utf-8?B?d1kvSGVzbzlVQzhMZWdJREYzalUxdTQ0Z1JkZlhScE5LQzZOQS9rTm9uWnIx?=
 =?utf-8?B?SjdHc1ZUVGdUVXdCTExITUQ0YkpZbXFZYkxKRFk1YkxOT1RZcE5sN1Z4NC83?=
 =?utf-8?B?UDI0WTJJZm9ZY0VyUXQ1WXNlR3lNQXhEWnQ2WUlJbGpDR2x1bE9FbFNFc1Vu?=
 =?utf-8?B?S0w3WTQwRDdWYjBtNkxvbkpQUkRwMjlhU0xZWlloSFpxZ0ovaUFub0tqbGNO?=
 =?utf-8?B?YUdkS01aQ1hGQWdQLzJidjRFSVB6YnpCbWROY1BRcCtHdHpSQnJLL1B3K3Fh?=
 =?utf-8?B?cFJoanlpS3c2ZEUwcS9TRDdoNGFBSHZlRFY5M3lBd2pvUjFQaVNFUEJ6TFgw?=
 =?utf-8?B?QUxSUytUT3RzMG9GVGdTeW0zSzJjWFlxOUNSSkJ6NVhFN0VwRTVVcXdzcnVM?=
 =?utf-8?B?WTh3YU9NMUFJUDVBMGx1N1BSREovdFVkNVlFY29GN0xhYU1mNGtxY1lBMStv?=
 =?utf-8?B?ZCtQSGg0UWtUSGFBQ3FvMTlHTjhCRXlyaTFYNVFIVUd4cnhPMFQ5TnVNdFB4?=
 =?utf-8?B?ODh4VHJDT1JzSzF3RFF0c01VbGJSMlU1cWFlVWhVeVdpd2hncFFQWTF4SUg4?=
 =?utf-8?B?dEJJQXVRZW9lRnErVGgrZkZHbm9aaDloZWtYM3NzZDdDRTc4Vmo0Sy8wREM0?=
 =?utf-8?B?ZTAzYmduTExKY2NlUW9jc1dHWjBhMHl5ZG1IVVFjRFRtZWNoQVg1WkgydmpW?=
 =?utf-8?B?anZUT0ZyYTVNRDBHWTBLMnRQRko0SGhScUQ4b0ZjYUJQZDlHRlY3VVREcVZV?=
 =?utf-8?B?bmM3UXdIM2NaYU1jZGZVcVZkOVo0MEJOU1dqemxKaFlaZHZpT3ZKSDdzSVQr?=
 =?utf-8?B?UjdSRXVVekcwWGRqcXBQQ0EzSXJNc2R6RWpWaTljWmRDeWZRN3J3QTB1OWlm?=
 =?utf-8?B?eXdrUndGZUVXMURXTjVtTGZSL20rT0cyRVB6eHFwUno1dCs3Z3FuZHJzZTBZ?=
 =?utf-8?B?TXlFc2hlei9Uc0QwcmhtQzlmNm9qdjFIU1l4RUp6cnJCN1laRU9GMllhditZ?=
 =?utf-8?B?eWRMK0tab2ZIcC9rZnpTSzZRMmU3UWJjbE83SDdqc0R2bWlYV0xwQkZCYU5I?=
 =?utf-8?B?UDgzRGFkMC9kdEtzZDNJL2JjRlA0dVpRczlWNHlGa0JSTnhtMVVPbEw2UG5y?=
 =?utf-8?B?MlY5aGMvck9NTHB0dDNCRFBCTjhIKzZXOEZmNDRQVXczL24wZ1ZqVFNRcUVZ?=
 =?utf-8?B?R2JnMDQ5eTNld24wWlVqY21MUXJpM3ZyczY0NDlsVWlmQTRkS3JJZnAreTk5?=
 =?utf-8?B?ZEpleHJJRUF4eGtyVGlaTzVlRmVJK2twbG84bFliZlZGUENMUU1UY1JGZXg5?=
 =?utf-8?B?VSt5eGZaWExENWh5bHI4RjJhdEZrT3huZGtQbmp3ek1yNldwUXBXSlE3SWho?=
 =?utf-8?B?SGQvR3lhQld0ckp0WS8wZUlPNzJjY1ZhclpEMTA3R3pEWmZLQ1VnYU9sVUFr?=
 =?utf-8?B?SE9FRDFXcGxTZWIwekJFcStMSHRwTU95eWRvdFptOTdVbkdMWmVPYzV0aUlw?=
 =?utf-8?B?OVFjNlgxbEZ1UkgyWk9HdzlFOHpvRGlsb01MSm52ZGJLRWI3ZGd3d0REQ3gw?=
 =?utf-8?B?SExNdlpWR1BvVEs3Wk1ZUUY3Q0hCL3FyQllVR1cvUG13SUNvc2R0Uk9VUmJv?=
 =?utf-8?B?ZVp2K1pDd2R4c0s0L3QzMEF2LzhMMFA3cmNXNW5qZEdYekRsOHlFWENUTjBT?=
 =?utf-8?B?MDBjYzk4ODk4N21ieWdPMnNyZDJlYlV0QzI0VmcxcFpiMThORE1IZ2VPOFY4?=
 =?utf-8?Q?PiGYeYh2LwdTw9XtWts0C2A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D10A60867402459208765D85E97DD7@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf704378-a26a-45da-368e-08dce21f4572
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 13:45:11.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogKzM8eS5ijmfVEHMkuer8jTQoJ4dOAMt9CwjFtdYwA34l7irYZaz0V+ozSb5RPghgG5pdoGdeu2Hr2DGeIDqZDVrdjOvRtJIyxCUoVll7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3507

SGkgSW5nbyENCg0KT24gVHVlLCAyMDI0LTEwLTAxIGF0IDE1OjMxICswMjAwLCBJbmdvIHZhbiBM
aWwgd3JvdGU6DQo+IE9uIDEwLzEvMjQgMTI6NDAsIFN2ZXJkbGluLCBBbGV4YW5kZXIgd3JvdGU6
DQo+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9kcDgzODY5LmMgYi9kcml2
ZXJzL25ldC9waHkvZHA4Mzg2OS5jDQo+ID4gPiBpbmRleCBkN2FhZWZiNTIyNmIuLjljNWFjNWQ2
YTlmZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9kcDgzODY5LmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9kcDgzODY5LmMNCj4gPiA+IEBAIC02NDUsNyArNjQ1LDcg
QEAgc3RhdGljIGludCBkcDgzODY5X2NvbmZpZ3VyZV9maWJlcihzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2LA0KPiA+ID4gwqAgwqAJCcKgwqDCoMKgIHBoeWRldi0+c3VwcG9ydGVkKTsNCj4gPiA+
IA0KPiA+ID4gwqAgwqAJbGlua21vZGVfc2V0X2JpdChFVEhUT09MX0xJTktfTU9ERV9GSUJSRV9C
SVQsIHBoeWRldi0+c3VwcG9ydGVkKTsNCj4gPiA+IC0JbGlua21vZGVfc2V0X2JpdChBRFZFUlRJ
U0VEX0ZJQlJFLCBwaHlkZXYtPmFkdmVydGlzaW5nKTsNCj4gPiA+ICsJbGlua21vZGVfc2V0X2Jp
dChFVEhUT09MX0xJTktfTU9ERV9GSUJSRV9CSVQsIHBoeWRldi0+YWR2ZXJ0aXNpbmcpOw0KPiA+
IA0KPiA+IEFyZSB5b3Ugc3VyZSB0aGlzIGxpbmttb2RlX3NldF9iaXQoKSBpcyByZXF1aXJlZCBh
dCBhbGw/DQo+IA0KPiBZb3UncmUgcmlnaHQsIGl0J3MgcHJvYmFibHkgbm90IHJlcXVpcmVkLiBJ
IGp1c3QgdHJhY2tlZCBhIHdlaXJkIGJ1Zw0KPiBkb3duIHRvIHRoaXMgY2xlYXIgbWlzdGFrZSBh
bmQgd2FudGVkIHRvIGNoYW5nZSBhcyBsaXR0bGUgYXMgcG9zc2libGUuDQoNCkFzIGxpdHRsZSBh
cyBwb3NzaWJsZSB3b3VsZCBiZSBub3QgdG8gYWRkIHlldCBhbm90aGVyIGJpdCBzZXQuDQpPYnZp
b3VzbHkgaXQgaGFzIGJlZW4gd29ya2luZyAoaWYgaXQgd2FzIGF0IGFsbCkgd2l0aG91dCBhIHBy
b3BlciB3cml0ZSwNCmJ1dCBkaXNwaXRlIHRoZSBpbmNvcnJlY3Qgd3JpdGUuDQoNCj4gVGhlIGxv
Z2ljIG9mIHRoZSBmdW5jdGlvbiBzZWVtcyBhIGJpdCBvZGQgdG8gbWU6IEF0IHRoZSBiZWdpbm5p
bmcsDQo+IGFkdmVydGlzaW5nIGlzIEFORGVkIHdpdGggc3VwcG9ydGVkLCBhbmQgYXQgdGhlIGVu
ZCBpdCdzIE9SZWQgYWdhaW4uDQo+IEluc2lkZSB0aGUgZnVuY3Rpb24gdGhleSBhcmUgbW9zdGx5
IG1hbmlwdWxhdGVkIHRvZ2V0aGVyLg0KPiANCj4gQ291bGRuJ3QgdGhhdCBiZSByZXBsYWNlZCB3
aXRoIGEgc2ltcGxlICJwaHlkZXYtPmFkdmVydGlzaW5nID0NCj4gcGh5ZGV2LT5zdXBwb3J0ZWQ7
IiBhdCB0aGUgZW5kPw0KDQpZZXMsIHRoZSBmdW5jdGlvbiBsb29rcyBzdHJhbmdlLg0KQnV0IGFz
IHRoaXMgaXMgZm9yIC1zdGFibGUsIG1heWJlIGNvbXBsZXRlIHJld29yayBpcyB1bmRlc2lyZWQu
DQpJTU8sIGp1c3QgZGVsZXRlIHRoZSBib2d1cyB3cml0ZS4NCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

