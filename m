Return-Path: <netdev+bounces-258277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YABJJBB7jGkcpgAAu9opvQ
	(envelope-from <netdev+bounces-258277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F812486D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 743E3301053A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056835F8A3;
	Wed, 11 Feb 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="fgEwTml/"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023094.outbound.protection.outlook.com [40.107.159.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919F19CD0A;
	Wed, 11 Feb 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814220; cv=fail; b=Nv7+iJF+D9SNVrgL9ezGIuxD6R/d+vU+doqSygYaEOe8z9diU4H2bwM+uwf2Jn3l5g+14jSh/w3s8QrFxr687j7FM690DpP8A41zaaskNQUShXJkjZgXLZYig8sTvh7y9fn/s60kcsGLaar5YzmXnj9S+aOJvBxwrLGeVeqKTAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814220; c=relaxed/simple;
	bh=sXHIjIeROpmDH78guerccl7W6O/vLMb5hjKqMoQ+EB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxHMTyfrw9at0FGF/zQsDwkU4GcARRF8k8p4t0GOXFxy5P1UIzdxj6rduHSR4fgyVFVT+gEofzDplowrMZ6MYQgHFtaCD/IWNpTydiDkpgXwDV70WLWi96Hu8/EqSDC7kf0AOfMXtTnLBD9SKxdmoSWg3DPU2Zn67R2yisxhJCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=fgEwTml/; arc=fail smtp.client-ip=40.107.159.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mumyzAnJ8EoyqZuoAw3jogsmFzJ7CvKohxOdgu2J9Phy6zeUu98282UMhVi90ao2GHjg/w2gaurrdSBfK/qwBEQlTYeYpq1AIpHe9nkSwo3Y1BDjyzNGap6LgZjxuVoloD1soVX6EB18RWkLRAK/KBd6YGbHGnGduC8GhFaHwHwQ0e5xtRJR3RMGtJSSYZ3t0vmUOpvqodqx875NhdjUlYcdD/Xask0K13lG5DQ1h2+OnDNSRbARQr8kCoJnhyxOGNEX4rewtvKh1xCpFqm6Q5Zmikbyu+M/ZBB6GUW3/LBbOJdijDAQvgdh+ASTUFpOUQBLhCZdKKd5+TamvvDm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXHIjIeROpmDH78guerccl7W6O/vLMb5hjKqMoQ+EB4=;
 b=niAuTpOavBkJI4gAlfy/WxorZQI0VxXak76fsptsCQppL9nHHg4I/pU18UfK7DrEKVapzlkcetXVqaw4k2kmAFT/0tugdZeoyr6mx7HALvALlJYw3j6TyvkfIcp67AM9xROTWp8BwtZLmUN4LcJ5zMkaMQX+fCyMLtg854tUl5Lt39aojKyWgPFwvIgsxrjQptnJHmCaE/tdu1eNT2fiODow4OS/WMnFR+okAyt2OP7HItuSye7qyLjv/q0eRwl0698RfvI2J7p3ujZnu7+R/GyD31nj8rEreKMxCh8HHMKCaYmC4vD8Dl4QzgUGs2jpgMLfbGmLXdcOKegCzRd3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXHIjIeROpmDH78guerccl7W6O/vLMb5hjKqMoQ+EB4=;
 b=fgEwTml/Jq9Thp0oSbfsg7FDp2X55XJKiYE0Z7geQE7y0bv7F6G5ZxboQnX+rVNf8RLtJy0s6+XPNSxAIg3brCBFU4MMSKFcnHjdGtInnnPvfHMTujs7MkbExkPvny4+wRar2w8Qc2FSDGU2WTtrIXOptSxu85508c2so7DChR+Fd7ekarqeH2qW6zVDQ4IrdoLUme7fQLZh66X4kzF7PVlXP8gQwcFpe97RU3SHm/1s8lR/YbKHKRuacpDDlnDlNNEwPZJvrVlIkSLim5iem2i0H9rOPl1GjULuN62GaTnyFlZsQN8+cKujhjLB/NdgFW71ZA4bgk6edB5/bB06Fw==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by DB9P195MB2084.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 12:50:13 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 12:50:13 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "robh@kernel.org" <robh@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Jan Remmet <j.remmet@phytec.de>,
	"davem@davemloft.net" <davem@davemloft.net>, "afd@ti.com" <afd@ti.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Benjamin Hahn <b.hahn@phytec.de>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>, Yashwanth
 Varakala <y.varakala@phytec.de>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Thread-Topic: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Thread-Index: AQHcmpxhWRkMKA1T7UebNhPB945cELV9dLMA
Date: Wed, 11 Feb 2026 12:50:13 +0000
Message-ID: <cfe612e3aa7455d61825d94de627caa384628854.camel@phytec.de>
References:
 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
	 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>
	 <20260210144849.GB2675838-robh@kernel.org>
In-Reply-To: <20260210144849.GB2675838-robh@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|DB9P195MB2084:EE_
x-ms-office365-filtering-correlation-id: 058fa9e2-29a3-4ce5-00f3-08de696c193a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MThKRGhIY0sxTGhjYkM0SWpYeStEeGN6eUNJTGFCZDdWU0Fkems4WTBzQXF4?=
 =?utf-8?B?QmpHK2k5QjU4cENNeWNOSys5c0thMWE3TEVraU9PaGUwTVZDVEl0N0xxWTZz?=
 =?utf-8?B?MWoyNzBBSkh2OS80YzUwMnJBcXNSb2lHVnFTR3lmVVZUTG9MdE9iUWozUFpU?=
 =?utf-8?B?UGluV0JDdjBFdHlGaHd3eVVJRUdIZ3p4SEY3aFpaNjMyQ3lzaSszbk5zaG8y?=
 =?utf-8?B?TzJOdVppbnN4TUZ1RWpMdXJSQk9GNlI3WUtGUERnT0JLaUp0aWtXellRN0Rr?=
 =?utf-8?B?UVE4K3JZSmZxeU5ZN1dJaW0xelBHZDY2MGtRV2xNSUhYNmRWMVpvZG5wdC9V?=
 =?utf-8?B?b2xRZFg5R3JoTTJLdCs2a01qYmc5MmF4bkM5SkhJdTZZZ3NkaVFnZEJKeFBZ?=
 =?utf-8?B?bWdsblNSK2d6cHlvSFpTaVYraEs4anl3dERTODhqVVlMaHVtMHMvQmROajF5?=
 =?utf-8?B?NmRGTWNHZDVrbEdvSDFLK1J0ZjVIdVF1VVJWdkZ2M21ibUZuVXVuQUdwT2o0?=
 =?utf-8?B?Z2xIZEpUalZGQUJOVzFqWnM1bm9nV1BXRGJZcXR0MzRJZ3kyTlVqdlQwOWVx?=
 =?utf-8?B?SmJvS0hiRnVxQ3NGL1BzSkxUaEVIQW9FWGQ1MGFyYUQvWTBLbU5ORnFjTkIw?=
 =?utf-8?B?U3VZK01hV3JXcDYvS2U5dEZxSHY0SDA5bUtUbks3aWR1WTRXNXBvNHM3MGkx?=
 =?utf-8?B?TUpmckpxNGc4aHQxUC82RU16anJjVVdWaEJCK3NERlU3N0xoOWEydFVlWTJ0?=
 =?utf-8?B?NGxBZWpCRFpQcm12ZHpvWEM3akdJMndRcDlTcU50cHk0eHd0Z3AzNGhXVXFS?=
 =?utf-8?B?WFJGOGdXbzdFdDhidVBJem9CM0Q0NDlaT01wb0xEU0d0ZVBQVDBOQTVKRDFp?=
 =?utf-8?B?bkdSQUV2VzlTa1VHcktPY1BjVkZqK3JNckNhTTh6ZWQ3aDlOSVhndXU1SmNY?=
 =?utf-8?B?SklycU5QU29CL3FMQ3FnNzBFL2dWNEthVlE5eFhyM09JT3hCeUJTSDJraEFu?=
 =?utf-8?B?UmkyNHF6T0xGN1llWkl1T0VsUmhsU3ZFbnkwRnhySWRhOXcvWVdGaTNOY2xn?=
 =?utf-8?B?T0hGWGdTOGFkOHMxSDdscjZLV1FmVGZ5enhzdWFlNTBKQjNvVnhxOFFTV3Bj?=
 =?utf-8?B?ZUgwajZkWmZsZ0l2Qm94NHRYN2xiYjlxbThWTUN6TnZDbmtsSW9vdnZtZ2lo?=
 =?utf-8?B?RkU2TDZEaHZTdFpDZ0V3eXkybkNSNE53cEJvVzNqSlhOcXJoeHd3RWlNSElR?=
 =?utf-8?B?L3B3YUFQMmdnMDdIa3BWK3VwblFWcVRxSlFhejlEZFNkWDl5c2Y3QnFBWGJJ?=
 =?utf-8?B?OXVId00xTFVKY1hSK0FyZDRGUjJlSVIxWUNkVDYrSis4SzVpMUdNaUxpSTla?=
 =?utf-8?B?SUpJYndDYk9yWW1jQllIKzdaU1JMVVBJM2t1aVkybFZpODVkZEVlVm40MU1I?=
 =?utf-8?B?dWZBSUo2ZmZOdUpiMkpIdHRLV2dHOTlNbW1qNjFJVDhla3BvTW9tT2pVa1Ew?=
 =?utf-8?B?VElrQ0JkOXRWVFpGU1RHVW01N2NXNW81SFlGSGU2K1VkQTc4NXBsWXp2TUV4?=
 =?utf-8?B?OWhLY2R5T1BBY3gvZmU3d204a1JGMitlKzBtTDZ2OUg5Uk5lWFB5ZytNM3hw?=
 =?utf-8?B?Qjh1Um5QUTZZZmJlUVE2QzlvNHBDejZSaGtvejIrZ0doY3d0ZlpRbE9FT3JR?=
 =?utf-8?B?cGcvZ1F1ZWw0a2ZGSjVVNWtmK296ZlVZK2RPSlhkQlJtZ3VrY3d4cGgzb3Bt?=
 =?utf-8?B?V096RjNKUjlMclRGdXd1bjU1MU5VVGhHdHRRVVU1UDl2KzlzeTZFTVlTK1o1?=
 =?utf-8?B?V3dOTm82ZWNhSlpYNHhQSUJGbEhLbWNBdzhoN0VBbmFLbmpEdVphUXlNOUJ6?=
 =?utf-8?B?dHFRRmE3RFpQK2xMbzlLQXFyTGRnb1BNRVVrTW13djFqbG04OXVHOE9Obnlz?=
 =?utf-8?B?bXNEKzhxUnNCbUV4elM5YUlxSTZuZTY0aTdlcVFtL00zUUlGd2RaeGZqRFVW?=
 =?utf-8?B?ZTVjZ01hSTNNekpmYzdZODE2MnhwWFBlMUlvSEFzaUN5Uk51VFNPZHpVU3pD?=
 =?utf-8?B?MGNVdEZUMFcvSjM0SHVmaGNsbHQ1RkdlenpJcjRJZkZuSHNmNVpIcTdjMGYw?=
 =?utf-8?B?ZDFBUjk1NGN5TGUyZGtrWktpSkFsaEZORmVFK1NyZ3BZOHZ3dEFqYlU5NFVs?=
 =?utf-8?Q?mELpm+0w9ull7UY3Z02pslg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUdwcUxiWUlhcmFENVdVUXFjcDcrMDZMS3ZiWTNCcWs3TlorS1FGc1VMcmdx?=
 =?utf-8?B?QXh0RkVJZ0JXN29sUHdvdGNmdWcxb1ZlK0QwM2ErcVlyQ3VDMTlEZzNvSE96?=
 =?utf-8?B?ZW9Xc3kyMUhFaUh4cndBb05GZnIzaFBsTjlleEJUclYzNExGVkxGS1NaUm8x?=
 =?utf-8?B?YmtrMVJTbDMzM2RkSXp5c2Zva0d2MjVrSk9zTUxVOEhaQzFwV1pNYVlvTWNK?=
 =?utf-8?B?U2VyNWxsMHh5Y3h4N2hlaG5LT25NSGlSQTllV0lYd052U1ZWNjJON2x3bWdr?=
 =?utf-8?B?VjNVaSsyY3Q0Tnd6Z0VYc0F3c1NNVHVuV0JKUC9Zc0l1ZVB5QTB2TkpvVEtl?=
 =?utf-8?B?N1BQK2VOZ0Q0dVR5anNyZklVbEJxbnVnMEdMZVl4WmRsZ1krazZSTE9RUVJp?=
 =?utf-8?B?aTdIdmlyQjJNNndFcnBDbzh4R29udjlCL29MSzFWMVRsNzR1M0MxNVVCeWJE?=
 =?utf-8?B?eUlTa0N3Z09qOXR1MWcyYjAzV2NFdlhhT1BxTi9YM280Sk1zeWlMTlQ1RE9U?=
 =?utf-8?B?TTFjczdoZGxBQ1F6UzJLbGhBRXE1bnpqeVl3MlRvazEweUtZRmlGNlZrdWhq?=
 =?utf-8?B?RUxJbzJnbUNDcVNrK2VadS9wbno2NVZOdWJ4bUUzU2tIb1BJOVdnVFpUK0k2?=
 =?utf-8?B?UzZNSFlXaXBQN2hSN0JSeUYyYnRHMU9uYzAycXF1bDFpUlN2VEpBVFp2dmNu?=
 =?utf-8?B?dSt4OEtRWjFWZGFZamdMZjVQck1mMzVkOWQwL1FDaDlTRG5JNFVPdnhRLy9I?=
 =?utf-8?B?VGR2V2pFSGNzaUJFN2lFZnRrRHFCMnZKMHZVTmxrSEJRY3FnUndoRTJXTWUz?=
 =?utf-8?B?TUpZbnlWMnIwaStlQ1pmLzJ4b1kxREFOeml5dEY3aXFOWlpJZVN6NmllUTNs?=
 =?utf-8?B?bzRzSHRqdG9kMzNFM2lRVy8rYUZBR2xjZkIwSHJ3dDFEOUJ2Q3ZaZ29xQ09V?=
 =?utf-8?B?ek1kZ3M0U0FFd2NxUlZKNzdwY2ptdXdidkRYVnBXK29ZL0xwWGdXaU01OXRW?=
 =?utf-8?B?eEh5S292SmYyYzdaYjRqbWRCdUVIY2VPSHJLdW1jTGNlUU9CRlBpT00vL09W?=
 =?utf-8?B?WmhKeVRObnM1MFFiVkU0VXNFenhoaGsveEFxeVdvc1JMYkw1aG9LVFdQV2tU?=
 =?utf-8?B?b29DZytsWE1BQ3o3N3Q3cjUrbkpIRDFxVTczaTlVcjdtek1IMjljV3c3RHoz?=
 =?utf-8?B?Y0g3R1d5Tnorb1JicFRSMWZiR1JuVkR4YlBrN3k3MENnRTNXWkxNbmZnanMv?=
 =?utf-8?B?ZFRhREs5ZG9EWXFLQkVqSGorSFNaR0UrSU1hejAzWURIaWE0SGxCSTFqUmc3?=
 =?utf-8?B?Q1JWM2oxU1dERUQvWktuR0U4WDNKMlVaaGE3cFJ6S2ppQng0dnRrWU81ZVlp?=
 =?utf-8?B?T2N1WVZMcmV2dXRuWm1uY2kzOE50dWg4bFNVNkdlRitJUGtXOXowcG9lMlEv?=
 =?utf-8?B?V0tydU1DNFFJcGVTNjFtRXVTTHV5QjdNOGlVeFNqMnA2b3N2ejk5MVc3UHh3?=
 =?utf-8?B?NWppMm9DQWJDTFBYRUtDZUsvZkxTbFZ6S2pJRm9SS3czZ1ZxK0wvQUdqVjV6?=
 =?utf-8?B?OXczaUVRR2VBVFROY2JHeFpGUktrZlZmaGlCbDYxSzFDZWdVWEtiRW9CYlF6?=
 =?utf-8?B?NFE2enl3RDBhSlNRQjJzTVZrb0MvVWdoZkJmZWV3SUlBSmdZR0RIbnZuQXc2?=
 =?utf-8?B?QW1WbWxlUUZvM2J0MTdxbUJQeW93Z1hyTmJIa0dhaGRyZVJBaThJcTNqWi96?=
 =?utf-8?B?V05mampHaGd6TGp1SkdzWkVWNDE3bjJzS21WU0xYOGlFWE9Xdm1hSXVFbzZq?=
 =?utf-8?B?Nzk1TElKTnNFemYxQVVjV1haTkJJNG9jN3hkTGpqVnhBcm5BV2Y5WDBZZDZp?=
 =?utf-8?B?TEpKdHBqT0JxOWNMRlZKTHRNek45MTM3bDhDaGdiQ3pCZ1V3TktzNHh0WmFQ?=
 =?utf-8?B?eXZmVHNkdHJ3SXRTYWppQVNaNnIwa1pNd1NsM0doTmtWSzBhNWRQVEJlYk5B?=
 =?utf-8?B?WWRXem5LUFVZdGdqR0QvZGVhZ3ZsaU1TVVZYTlpMVnR3b0dqdkxnMkZONXNs?=
 =?utf-8?B?SlVud1IzYjhZZ1ZXemExOEd1dFlSTms4bms0NWlIRlFtbWFlSFpLbk9DSGhz?=
 =?utf-8?B?SGowYmQ1OE45MUhqenJXUFY2MzFjU1ZmZHFsak45RUttbWNRZVltS1hXaDdu?=
 =?utf-8?B?YmEvWTBqWWlNSUo5WC96S3ZuMGF4RmM3UFJPdS9TK2ZaTGFITml2aEFtMTl5?=
 =?utf-8?B?cTZwMWxyLzU5N1A3MDV6dHM2Wm4xNE0vUzF4L1dWNU5mWjMrcTVvVytScGlX?=
 =?utf-8?B?eWRhVHNPMEswSEQ2SmhiMFYxSmV0UW1ZcDNEYnZyVkJKZlJ0QWc2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ADDF02DEDC81E4285C6140A07385F56@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 058fa9e2-29a3-4ce5-00f3-08de696c193a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 12:50:13.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJUFG/s6cqT6gMS5+d9z1qx1KG6n6yHurels41qXrTKZ3Iu7dD8i3dMTMuSUBV+NgzEyJkTIbufG3zuAsB1YJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[phytec.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[phytec.de:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258277-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,phytec.de,davemloft.net,ti.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmail.com,google.com,lists.phytec.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.remmet@phytec.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phytec.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phytec.de:mid,phytec.de:dkim,phytec.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E19F812486D
X-Rspamd-Action: no action

SGVsbG8gUm9iLA0KDQpBbSBEaWVuc3RhZywgZGVtIDEwLjAyLjIwMjYgdW0gMDg6NDggLTA2MDAg
c2NocmllYiBSb2IgSGVycmluZzoNCj4gT24gVGh1LCBKYW4gMjksIDIwMjYgYXQgMDM6MTM6MzNQ
TSArMDEwMCwgVGVyZXNhIFJlbW1ldCB3cm90ZToNCj4gPiBBZGQgYW4gb3B0aW9uYWwgZGV2aWNl
IHRyZWUgcHJvcGVydHksICJ0aSxvdXRwdXQtaW1wZWRhbmNlIiwgd2hpY2gNCj4gPiBzcGVjaWZp
ZXMgdGhlIG91dHB1dCBpbXBlZGFuY2UgdXNpbmcgYSByYXcgcmVnaXN0ZXIgZmllbGQgdmFsdWUN
Cj4gPiBmcm9tDQo+ID4gMHgwIHRvIDB4MWYuDQo+ID4gDQo+ID4gMHgwIGNvcnJlc3BvbmRzIHRv
IHRoZSBoaWdoZXN0IGltcGVkYW5jZSAoYXBwcm94aW1hdGVseSA3MCBvaG1zKSwNCj4gPiB3aGls
ZSAweDFmIHJlcHJlc2VudHMgdGhlIGxvd2VzdCAoYXBwcm94aW1hdGVseSAzNSBvaG1zKS4NCj4g
PiANCj4gPiBUaGlzIHByb3BlcnR5IGFsbG93cyB0aGUgaW1wZWRhbmNlIHRvIGJlIGNvbmZpZ3Vy
ZWQgdGhyb3VnaCB0aGUNCj4gPiBkZXZpY2UtdHJlZSB0byBhbnkgcmVxdWlyZWQgdmFsdWUgcmF0
aGVyIHRoYW4gYmVpbmcgbGltaXRlZCB0bw0KPiA+IGZpeGVkDQo+ID4gbWluaW11bSBvciBtYXhp
bXVtIHNldHRpbmdzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRlcmVzYSBSZW1tZXQgPHQu
cmVtbWV0QHBoeXRlYy5kZT4NCj4gPiAtLS0NCj4gPiDCoERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvdGksZHA4Mzg2Ny55YW1sIHwgMTkNCj4gPiArKysrKysrKysrKysrKy0t
LS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC90aSxkcDgzODY3LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvdGksZHA4Mzg2Ny55YW1sDQo+ID4gaW5kZXggNGJjMWY5OGZkOWZlLi5hOGQ4
YmZiNjhiZWUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC90aSxkcDgzODY3LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4NjcueWFtbA0KPiA+IEBAIC01MiwxMSArNTIsMjAgQEAg
cHJvcGVydGllczoNCj4gPiDCoMKgwqDCoCBkZXNjcmlwdGlvbjogfA0KPiA+IMKgwqDCoMKgwqDC
oCBNQUMgSW50ZXJmYWNlIEltcGVkYW5jZSBjb250cm9sIHRvIHNldCB0aGUgcHJvZ3JhbW1hYmxl
DQo+ID4gb3V0cHV0IGltcGVkYW5jZQ0KPiA+IMKgwqDCoMKgwqDCoCB0byBhIG1heGltdW0gdmFs
dWUgKDcwIG9obXMpLg0KPiA+IC3CoMKgwqDCoMKgIE5vdGU6IFNwZWNpZnlpbmcgYW4gaW9faW1w
ZWRhbmNlX2N0cmwgbnZtZW0gY2VsbCBvciBvbmUgb2YNCj4gPiB0aGUNCj4gPiAtwqDCoMKgwqDC
oMKgwqAgdGksbWluLW91dHB1dC1pbXBlZGFuY2UsIHRpLG1heC1vdXRwdXQtaW1wZWRhbmNlDQo+
ID4gcHJvcGVydGllcw0KPiA+IC3CoMKgwqDCoMKgwqDCoCBhcmUgbXV0dWFsbHkgZXhjbHVzaXZl
LiBJZiBtb3JlIHRoYW4gb25lIGlzIHByZXNlbnQsIGFuDQo+ID4gbnZtZW0NCj4gPiAtwqDCoMKg
wqDCoMKgwqAgY2VsbCB0YWtlcyBwcmVjZWRlbmNlIG92ZXIgdGksbWF4LW91dHB1dC1pbXBlZGFu
Y2UsIHdoaWNoDQo+ID4gaW4NCj4gPiAtwqDCoMKgwqDCoMKgwqAgdHVybiB0YWtlcyBwcmVjZWRl
bmNlIG92ZXIgdGksbWluLW91dHB1dC1pbXBlZGFuY2UuDQo+ID4gK8KgwqDCoMKgwqAgTm90ZTog
U3BlY2lmeWluZyBhbiBpb19pbXBlZGFuY2VfY3RybCBudm1lbSBjZWxsLCB0aSxvdXRwdXQtDQo+
ID4gaW1wZWRhbmNlDQo+ID4gK8KgwqDCoMKgwqDCoMKgIG9yIG9uZSBvZiB0aGUgYm9vbGVhbiB0
aSxtaW4tb3V0cHV0LWltcGVkYW5jZSBhbmQgdGksbWF4LQ0KPiA+IG91dHB1dC1pbXBlZGFuY2UN
Cj4gPiArwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllcyBpcyBtdXR1YWxseSBleGNsdXNpdmUuDQo+
ID4gK8KgwqDCoMKgwqDCoMKgIElmIG1vcmUgdGhhbiBvbmUgaXMgcHJlc2VudCB0aGUgcHJpb3Jp
dHkgb3JkZXIgaXMgbnZtZW0NCj4gPiBjZWxsLA0KPiA+ICvCoMKgwqDCoMKgwqDCoCB0aSxvdXRw
dXQtaW1wZWRhbmNlLCB0aSxtYXgtb3V0cHV0LWltcGVkYW5jZSBhbmQgbGFzdA0KPiA+ICvCoMKg
wqDCoMKgwqDCoCB0aSxtaW4tb3V0cHV0LWltcGVkYW5jZS4NCj4gPiArDQo+ID4gK8KgIHRpLG91
dHB1dC1pbXBlZGFuY2U6DQo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOg0KPiA+ICvCoMKgwqDC
oMKgIE1BQyBJbnRlcmZhY2UgSW1wZWRhbmNlIGNvbnRyb2wgdG8gc2V0IHRoZSByYXcgcmVnaXN0
ZXINCj4gPiB2YWx1ZSBmcm9tIDB4MA0KPiA+ICvCoMKgwqDCoMKgIChhcHByb3guIDcwIG9obXMp
IHRvIDB4MWYgKGFwcHJveC4gMzUgb2htcykuDQo+ID4gK8KgwqDCoCBtaW5pbXVtOiAwDQo+ID4g
K8KgwqDCoCBtYXhpbXVtOiAzMQ0KPiANCj4gSG93IGRvZXMgdGhpcyBjb21wYXJlIHRvICdtYWMt
dGVybWluYXRpb24tb2htcyc/IFNlZW1zIGxpa2UgdGhpcw0KPiBzaG91bGQgDQo+IGJlIGEgY29t
bW9uIHByb3BlcnR5IHdoZXRoZXIgaXQncyB0aGUgc2FtZSBvciBmb3IgYSBkaWZmZXJlbnQNCj4g
bG9jYXRpb24uDQoNCnRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgdGhlIHRlcm1pbmF0aW9uIGlzIG5v
dCBwYXNzZWQgaW4gb2htcyBidXQgYSByYXcNCnJlZ2lzdGVyIHZhbHVlIHRoYXQgY2FuIG5vdCBk
aXJlY3RseSBiZSBtYXRjaGVkIHRvIGEgcmVzaXN0YW5jZSB2YWx1ZS4NCg0KVGhlIGRhdGFzaGVl
dCBzYXlzIGhlcmUgIk91dHB1dCBpbXBlZGFuY2UgYXBwcm94aW1hdGUgcmFuZ2UgZnJvbSAzNS0N
Cjcwb2htcyBpbiAzMiBzdGVwcy4NCkxvd2VzdCBiZWluZyAxMTExMSBhbmQgaGlnaGVzdCBiZWlu
ZyAwMDAwMC4gUmFuZ2UgYW5kIFN0ZXAgc2l6ZQ0Kd2lsbCB2YXJ5IHdpdGggcHJvY2Vzcy4iDQoN
ClNvIHVzaW5nICdtYWMtdGVybWluYXRpb24tb2htcycgc2VlbWVkIG5vdCB0aGUgcmlnaHQgZml0
IGhlcmUgYXMgdGhlDQpkb2N1bWVudGF0aW9uIHRhbGtzIGFib3V0IHNlbGVjdGluZyBhIHJlc2lz
dGFuY2UgdmFsdWUgd2hpY2ggaXMgbm90DQpwb3NzaWJsZSBpbiB0aGlzIGNhc2UuDQoNClRlcmVz
YQ0KDQo+IA0KPiBSb2INCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9u
YS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERp
cGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1J
bmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8
DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjYvNjY1LzAwNjA4LCBERSAxNDkwNTk4NTUNCg==

