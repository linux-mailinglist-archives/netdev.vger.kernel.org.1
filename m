Return-Path: <netdev+bounces-216827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FDB35595
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D703A7762
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF72FC86C;
	Tue, 26 Aug 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="V7m7N+ct"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D42FB98F;
	Tue, 26 Aug 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193012; cv=fail; b=OWnq6ZLlnEV0NvR+xejTd8aYVgcJ5b8m6acJMkURqvfvbTVWHU6D0AltjEwD9+KphzNAXrrTou6EwBP08MshAxiN63hwc9yB5ntIMwAOTEVtALQsYe71ICGdpakm8mwBGq9PE4Qnw4KeXkDw7vABB6S+waHzQC0Sw6gjYRNqMWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193012; c=relaxed/simple;
	bh=fiw7tXmBkpJx40XiIWna3BqR+P3H3BOHcTnlJHlwVBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwGF9fe+Cgiih4VvSC4WpiRcd6E2B9fizJq1gLUkPHhJB0Bje+6eDO6uMgdXOwun+s6F6DsttZOFuUVE12rjLK1NWeZ3mnr8/a+i5L3k6QuuldazQEPh1Qb+8pRxXK9DyVM05lm5WQlfHwDyW5Fj0ZakGh8LozwgnHdabAuFSJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=V7m7N+ct; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmUA64vbSCPjrR9JHJvCpSrvFF52cASx+jpV7DQVFjuhzqGKVJkvcEW0+Fy3v2Brys/DMJPJNrqEEGjC7snTJPEDUPFXg2hj2iOBGjss0vAGVVfOO11NGgivjA37zNMVlj9sDQXJ0GuiMJshrl9JSWefEoiBjTkNdyD8qHoEZ020JXXxqMMmSnc5w2GVkWdI2n80G5tQ6yB4Ay6xY7j/QoH5npa/SpfLg4gfOQcDtwds2zGvnMhqwyPDYFx/IoBiFIVVZUMzDaoJUje4hrPpme+9IWB2pXClJJikz2s1GHFKq8gn05NOLHg1ukZNBtSPRmdP6oM6xOXgquSbql/oCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiw7tXmBkpJx40XiIWna3BqR+P3H3BOHcTnlJHlwVBU=;
 b=RlPQKDRTUeynae9M4JyTFLwpZ707YI83BiYA0ja1GU5q1wiZICQWrSpv/j/6c+B0jKuw3grUuctsjC4CdKSFtUDcDtKSBcN92GQPxJUgxqgj+oz5n6+z/om2BblX53Sq50/fj9sOxArNFhrjO86trSppab4xogaIDnD6aLD39c8t8oyTF1FcmolpXZlF2QEKfNRxwtVyzQrisC/MMVFhD5biOaeTXtD9HgBuHxynIVkl+P2SD0ger124WCEooFo1Klypb8J7kUaA/X/OwgPsUw/sE5+yR82vCY2lqvHR7xrSVYEvWF/a9Bm3PMYdvs8Wj799mouu4oILDmdRR2mqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiw7tXmBkpJx40XiIWna3BqR+P3H3BOHcTnlJHlwVBU=;
 b=V7m7N+ctpdSdjkFC9XQV/0iM0MAazDKZZndLSy4QJndgH3f12egiQgpy1flIKqKA10B4bTFLgfT96qTSkKMW1GUkKlp7iheye4DOyep8u7mAaW3nFZizzMJ1TspYdQ9j5NBYBt3ADN67QAR5MgPbASAM2DJERKPB0qSRUsjdfxQz3L8tty8iPaFlS8Pgt655xpBjaWNf8Im89Lddq7Hvns7dQDuCAe+XT/Fl7XUMY13pBVDOwlrWXnEJixDqOCul/y/3COUTm253pyBwzUF8jFULQwWeODX4q07+im5DeAdcn09D4IgIs4siG/t5C0ULXqJpKXsNogoYed8nJ4Evsg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:23:23 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:23:23 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH net-next 5/6] net: dsa: lantiq_gswip: support standard
 MDIO node name
Thread-Topic: [PATCH net-next 5/6] net: dsa: lantiq_gswip: support standard
 MDIO node name
Thread-Index: AQHcFh5q2Fq0ULiFd0G4N7noonQJ0bR0iF4A
Date: Tue, 26 Aug 2025 07:23:23 +0000
Message-ID: <c627bfef02dfd670ef1c07267f53468ca1c3df72.camel@siemens.com>
References: <cover.1756163848.git.daniel@makrotopia.org>
	 <6f4b14df1eef78c09481784555a911b7505d1943.1756163848.git.daniel@makrotopia.org>
In-Reply-To:
 <6f4b14df1eef78c09481784555a911b7505d1943.1756163848.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7308:EE_
x-ms-office365-filtering-correlation-id: d68ff43b-8fb1-4d35-5ffc-08dde4717108
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tldqb3lMS3pqNm1iQkNLcThRaGNQd3FYdU5jM29NR1YxblNBNHhja2M3SzY1?=
 =?utf-8?B?RXBLNmoxWmNoRmdiZDFqdjYwYzJQQ2lpTVJLemMrOTVVWFd5eCtORmlsZEhF?=
 =?utf-8?B?Rkl5elNGL0RRTzMvTjdTSmlxRytiSFVtV0lXc3BGNjdFcVBOSW9idytmRnlW?=
 =?utf-8?B?Z2tTL2FML2VQRGlPNUZFbmVnOEFRdDE0Tys5Qk4rU2MyRWtjNGlFTm1nelN5?=
 =?utf-8?B?YlM2eXN3TVBuN3NnTk5YU0FrQXEvQzVrbDVPQ1daak5vckcwUVNaQ2ZGZE13?=
 =?utf-8?B?emttV0lIdTFsWkNlMUkvb2NVd1g5c3k1TDN6WW9mb2dzTnRBZDhpWmM1TTRE?=
 =?utf-8?B?R1ZkeC9ONERFdUlIdHZnbUhQU0E3ekYxYUI2YXpiTXJJcW9pdmlDZlpLKy85?=
 =?utf-8?B?dEt6MU03Y2FNMTV2Q0VBSDJIWHRZVW45UE14OGQwN0dBbnJvVnlqSUtCZ2Fh?=
 =?utf-8?B?Y09LNmoybjJleHJhUHZLVG5RWHBOZTkzZVVhRWRQbFFVd3RVQzRmQzFzRVNp?=
 =?utf-8?B?NWpjaDNCZGlycEI4TE9mRy9xa3k3K1ZaTzBOemRsNS9QOWtPVVBLczdVUTA5?=
 =?utf-8?B?NFM5VW8yc0QvUDRQUnhvM0ZZUVZJLzJvQmtzSXhCa2xJU0htSFNnMi9XeC9F?=
 =?utf-8?B?WWxOSW5JNVowY2JzeGlXbGJrZFkwTEtjVU9GY2VNS0Rua1dBNVlla3BtWlZJ?=
 =?utf-8?B?VWF5MURkeWVwbUgvVS80a2hEaE1ESzR4K1B5WDZ6YnFZSVpwL1lvdWJpbGpr?=
 =?utf-8?B?Yk4yM3JaRllaL1ZaNkNrNDlPWkRia2xCd0R1c0VtdElEbm1sdTI1YVFPR0p4?=
 =?utf-8?B?NkdUQ2JFeVhaU25IWFg4SVNIMzZiajNKN2NnRTJFMW12czZPUEF6eTFrQzNw?=
 =?utf-8?B?N2dmNHgzRkpPcWd5dTM4anNkQTVYS1FGTTg3V3NpRFE2cXQ3aG9RdDlUdVJq?=
 =?utf-8?B?c01KZ2tCQkRucTZJTXRybVV5eFdOZ2ZrZngrNmpJeFZzVnNRcXVwUnYvSG5h?=
 =?utf-8?B?TnlvOUN4R3RGSDRMOWgxZVZHOEg5eTlaZENDSG5ORFNsQTBIQm11UU9LTDRj?=
 =?utf-8?B?aWtVWGRmbXlKdTA2UU5KdjJzTzFXMVV2a25DUm5xVlVrQkRqTUVtL01GL1V0?=
 =?utf-8?B?d0Exd0VUWjZnM0ZOMEQzaDhUalRMQWMzbk9PTTNTS1VHNDlOenJDTjYveXl1?=
 =?utf-8?B?TWtWbGFzZko5b295SDVPMFBHcU8wUXJVY3ZBTkQ3TGdKRCtDdzQ3aG9EMXFx?=
 =?utf-8?B?UUJoVExLVmo3dXNkOENHZ00vRWcwWTRCZC9PTmg1RDBnZ3g3dmR0N3k4SkNZ?=
 =?utf-8?B?eEFjaCtsdW9uM1Vtb2dDVElLTXNoeXBmWWFOWnBLV3prN0V1d3o4T3dEWngx?=
 =?utf-8?B?SlN2V3Fya0UzUXJQdUJWQUpSTTZ6UjBRZmZWSC9vSkNyVjFVR09HeVZ0cm1z?=
 =?utf-8?B?RnZSczZzalNjYUhXaGp3QksxUEgxRW5hbVRPUHl2cTJ0Qm5tSzM0ZEg1VE1t?=
 =?utf-8?B?L2NQN2pLOEpBTkozK3VDdDlxYUZBb2d4R09tR1JNbHVWcWRVa1dRNkl2Rlk5?=
 =?utf-8?B?UWZxQ0VmTG1ibXJvN2xYQ29mWDI1R0hzbXU4cWJPUjhZRHJ5SC9uZHZLdFpx?=
 =?utf-8?B?VFFuMFRibTlHRWdvNkdxS3NWWkdONFpIWE91QmpZNVhKMG50MnZQYjBmNXRv?=
 =?utf-8?B?K1ZxZXRzL1dXZ0I3U1MvOXllUEREbFFhYmpPTzlVcCs1S2pWanZ2enFIeHdD?=
 =?utf-8?B?RFlFN1oyYlUyYktOOGkzOEhOSHFFSW54VHNTVmZFVkpsODAyZ1NSZjNIOEdO?=
 =?utf-8?B?OG5DUzREdlhqbkdBdVlOd3Q0ZE1lc3JnQ0hwUWk1VVRtYkE2VEpJVFlYT0R3?=
 =?utf-8?B?T3g0UWs5UnVPc2NyY2RGclVicDU3b0xRU3VJL2o2SENKYkdsQ1N4OFpCREJs?=
 =?utf-8?Q?Zg79gM5V5ahVg3owdr+x+aDUYvDdeltc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkNiN0xqcDAyQkRuSndBcW1RczVVOXlPTkFYd2NvWWtwaERnaytIbEk0SC9T?=
 =?utf-8?B?Ukw0R0o4YjNpejZBNWVQUittLzE5ZHc1U1h1ZmtmZlFUcWZzSURBTjZwQjM0?=
 =?utf-8?B?enlpQS9FcVZrMys5Y0VEM0gvUDdsT2svdWhQOGVRZ2twY1VpdytYd0YyOHE2?=
 =?utf-8?B?WXl0Q3VvTWk5QllHTnRDZ1JWMk9vR2JxNytzOHB3dFNPdUVYYVNHdExma093?=
 =?utf-8?B?Q01lVXhJQjdLV2xBcWpQQ3NjbVp4MDFRd21LYUVLS2NWOGZOTEpSTUpsaW5r?=
 =?utf-8?B?LzZjNmhpQUJ2WG9IQWt5Q25Uemh5U3dBc29kZElnZ3htUlBJVm9GK0JuVjRE?=
 =?utf-8?B?ekJ6ci9aRytXYTAxUDhKcUZqdFgwSzQ1U1h3ZHBvSU1vSGlIRGg1c3lyaG9N?=
 =?utf-8?B?Y25MVFpIZ2FMc0xzZGZ6MTVwOWlGUElzWkhabkNMRGtJWFl5YXJBSmhHYzBI?=
 =?utf-8?B?MVN4eTRYYmp4NWtqNGw2NEplT2xwaFFZRzFkV0JxZk1ISlJSNEQvZzNpckRF?=
 =?utf-8?B?TDZVSTMydHR5WkNzNkQxZVRLdWgvQXN1QURPSzdLS2FNMFpIaWhRNWZkN2RM?=
 =?utf-8?B?cFR0SnJyL3JPcDl4SDBxcVhDZVoxQTcwbnd1Ris1cThSSWlmcnczMFBqYTlZ?=
 =?utf-8?B?TVp0US9uYzc5ZzRMZmRscklyZW5FYkRTTitCM1hza2llK2RHZjhCc1VQenB1?=
 =?utf-8?B?Vmo0cE9BQnBKUUYzeC9KdVZrSUpwWHlPeXRzYmVTOFZyYWQycmpXempNYWJn?=
 =?utf-8?B?amdOaDF0M1Awb3NrY242ZkVBajRtM0JOM3ZVR3Myb0VtRG9sQzNHMzVvY2h1?=
 =?utf-8?B?MWg2UExFY29UQ3FScDZ5MXRpeitDNUU1U0ZYcXJtN3FHRVcrMEN3VVlmWis3?=
 =?utf-8?B?eG94aVUrWUZQYW1Ga1ZEc0V1aDZiWUtLQVdBNnFncTVTdXBBV1NsclFqeFZD?=
 =?utf-8?B?WG9hRmoxcFRyRmtFZ2xHMWVteWRHSVMxd1FlaEpRSDlhTGJhRkdOekVWcjdI?=
 =?utf-8?B?MjYvZW01VEVzUG43UWlhaDMyMnArTkNzSGNRMURnMXV5dE9YNjR3VXRmQWpQ?=
 =?utf-8?B?eEFtbWE4SmNvQjlmOTZ5MGFrdWswLzJpSmdxdVA4VFRxK2R0cWtXS0c2YmtM?=
 =?utf-8?B?d2ZBaVpHcTJ4WjVvQnkrZEtzTmRjOTJENGJJaytQNkJ1T0ZwUmxuTFRmYWY3?=
 =?utf-8?B?T1FZY1RXU0xtK3JURU5aenRNMXZMakNrZ1FabkdWNkU0ZkNmT1R2NUVwSVp6?=
 =?utf-8?B?eXBtYjFGa2FKM3hRRCt4SXdLSXRtc3hGLzh0bGNxWGJSTStWaVp2RkFhUnho?=
 =?utf-8?B?Y3NUWm5wVlZiMStVU2FXMFh2ejl0K29LdGlNQXZnSThBRGZQUFVOWmtFdUx4?=
 =?utf-8?B?NDN5OHQyR1Vpa2NmeTJzZTlKYkhuMVpNRWVORENuRithaTd0WlN2RE1Nd2Z0?=
 =?utf-8?B?emlIT05IZDF2MGhmMUdUQ2hiTUxjNW1ybVRPMlRwczI0WXp0ekZhOXUwV2Jj?=
 =?utf-8?B?QVhaVmwxd3U0c0NUSk9mU3o1VTVsNWFiQW9SbisrMWxacDhmM3RuWU5oSmxa?=
 =?utf-8?B?bndzMzQ5YmVDMjcrSGZjWTJnbDhBVHNpVk5sTlUwUVN3UnZ2T0dhaXBCVHk5?=
 =?utf-8?B?VmJYSmlpanBvaS9ZNU10K0xOMWlYc3ZtM2VIWXRGeGh5QVRBUGhISU9STWlj?=
 =?utf-8?B?b3d6TVJxNUJyWGpONi9ySG1rZ3RDMk9mY1MzWjIxbTluQm1RN3dhYlNZZXVF?=
 =?utf-8?B?YThManBoc3NwNkNUd2srb2hyV3pIR3hkSTZncUZuNW1HMllNNE43VHB5cHV3?=
 =?utf-8?B?dXQ2Y3QyV0I5TzBCVFQ4MGlNczVDZUZWMllHd0tLT2FIcDJkR2p1SjNVcVV6?=
 =?utf-8?B?WDZFb0E2SFhWRnZuc3UrcFFKbGF4MEVhK0puZGovWmpJVnpCbTZqa1BTd01Q?=
 =?utf-8?B?V2NRcE5jMTVtMVQyY29pVFRoUHpkaklBNGo5V0FqRER0OEZuL0tFM3hEcGlJ?=
 =?utf-8?B?VnNUY2lUS1pFQk1YSUtZVW1yOXhNRFNRSm02M0hwSnA4RjVpZkowSjN5aVdY?=
 =?utf-8?B?S0hVWUxCa0R3SEdiUUJ6NmtMd1FaSG5mRitnTU9QTzMrdUVqenBBdmdLM0Fn?=
 =?utf-8?B?WWVHaHhZSWdoTTJuUXY0Vyt3eDNiMVhPRGExc3hzdGpUS3pNR0pmYnV5blhk?=
 =?utf-8?Q?enTAE7sNu3A3moa/6lm0ksQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE4547FB2DA2B4F8B19E8346E9332D0@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d68ff43b-8fb1-4d35-5ffc-08dde4717108
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:23:23.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvh+DI9QFlZiNDog2004ALszc42Q2zHkAXiftQ9fNpss/FMeGttmO9+lIlAUPJRvQyUdvmkbU/wpGuUV6/vDWtbzF5QevTW5k2WFh+jT29E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7308

SGkhDQoNCk9uIFR1ZSwgMjAyNS0wOC0yNiBhdCAwMToxNCArMDEwMCwgRGFuaWVsIEdvbGxlIHdy
b3RlOg0KPiBJbnN0ZWFkIG9mIG1hdGNoaW5nIGFnYWluc3QgdGhlIGNoaWxkIG5vZGUncyBjb21w
YXRpYmxlIHN0cmluZyBhbHNvDQo+IHN1cHBvcnQgbG9jYXRpbmcgdGhlIG5vZGUgb2YgdGhlIGRl
dmljZSB0cmVlIG5vZGUgb2YgdGhlIE1ESU8gYnVzDQo+IGluIHRoZSBzdGFuZGFyZCB3YXkgYnkg
cmVmZXJlbmNpbmcgdGhlIG5vZGUgbmFtZSAoIm1kaW8iKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9waWEub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0t
DQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dpcC5jIHwgMyArKysNCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZHNhL2xhbnRpcV9nc3dpcC5jIGIvZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dpcC5jDQo+IGlu
ZGV4IGY5YjAzZmI1ZjU3Yi4uMjNiNjgwNDdmM2M0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9kc2EvbGFudGlxX2dzd2lwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dp
cC5jDQo+IEBAIC0yODYsNiArMjg2LDkgQEAgc3RhdGljIGludCBnc3dpcF9tZGlvKHN0cnVjdCBn
c3dpcF9wcml2ICpwcml2KQ0KPiDCoAlpbnQgZXJyID0gMDsNCj4gwqANCj4gwqAJbWRpb19ucCA9
IG9mX2dldF9jb21wYXRpYmxlX2NoaWxkKHN3aXRjaF9ucCwgImxhbnRpcSx4cngyMDAtbWRpbyIp
Ow0KPiArCWlmICghbWRpb19ucCkNCj4gKwkJbWRpb19ucCA9IG9mX2dldF9jaGlsZF9ieV9uYW1l
KHN3aXRjaF9ucCwgIm1kaW8iKTsNCj4gKw0KPiDCoAlpZiAoIW9mX2RldmljZV9pc19hdmFpbGFi
bGUobWRpb19ucCkpDQo+IMKgCQlnb3RvIG91dF9wdXRfbm9kZTsNCg0KLS0gDQpBbGV4YW5kZXIg
U3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

