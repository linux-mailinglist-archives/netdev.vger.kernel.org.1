Return-Path: <netdev+bounces-119085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B9953FDB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF031C22253
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89782548E0;
	Fri, 16 Aug 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YOgithLF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033B2C1BA;
	Fri, 16 Aug 2024 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777071; cv=fail; b=WLxFV6rShyTpmQ8jjmuyLCO1WD23UNC42eURgzyDgYHRmmtfzj5TOFKp0lsx4/84EzPDpuZ3qnttXQyNztPcOautUqoH/GZ3cml13iTZGiiN2LltmePC8f/9Uxiut7S/gtQ8IeilxVjCe4zSpb0YrZOD4lf+XHExRl7RTwEaUAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777071; c=relaxed/simple;
	bh=WYbVsbgx+dtQp6vTDYG6vf4ArXEo9DOSAcbewcl2r90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GqTRDaSja9NmxHcCC/eQ61d9m8ZABtAFubS3NhHIKQDWwUjfyj1z3L3ECO16MPRK7yBMfNCmIS8/7M/HcTV+xbsoQ1uLiOpDibIa5NqC/68xTRmxVAkeQDYc0giYm0B7vRGxDOt1qh4PI0PJ5WVBEgerM1p+V5RPrcxTSaFZFxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YOgithLF; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzsbJt7S7pxVyhFZU+nSVSDCjTyyQbr9mAQTBboiCSnWIvwGPC6Ruuv9KLpoG7ob3y2yAjfqTChBoICt1XDTwas7U3c9Jh6bQ8fHYwwwSQGCU3kCUZnreXn72JmH3WOxsFb34ajVUeBFZOFXO4FLhU8lfxykBtfaMmr+jrA58Mpfo/Fpybc5E5me61VLCKdKE3WajpYaCOt6TuyNLhmiXv9UFgPvGadkoOLHGj+beB7D846jBpC2mXNr+PuuzJNBV0XCfNF9992H+Xb2cn2vfp/CfDe7+lCFap42mu/hNoQzoKa9yNkZpSsUMDnmFRqHHL3cS2TL/5OWRBVVNHSTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYbVsbgx+dtQp6vTDYG6vf4ArXEo9DOSAcbewcl2r90=;
 b=Xdq7LfaK+otUAOzz5EJMNwbXhBKEfi8gyBUhTV2q93s2KH81h5yigfWISML9zoE64d2b73jKQNi6WcvM8sbFzBsbe8+cmAjpwtZZHCgfUhHAaHiRzuCcE95cZbiJPMynyhw41UiAZPX+m7KJ2v0WlnAeTdZjNYkV9SYcTE0QDc1liXwnxpXC6Nn/KbYHx+yZY7PHRdtiRsfk0ErW3rwgIRYkFk1eWLT+Dmdt9PIowKaGiE75p6vMpxnsH898noVE6jIcgM/lfodODgIjvzfdh3nuuCo1xPZ9q6FbPvCGfo5Puuc4OJGNtIXxO93deZfEk6UVW0xnI01QQmLhm/fGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYbVsbgx+dtQp6vTDYG6vf4ArXEo9DOSAcbewcl2r90=;
 b=YOgithLFHZbXHoGqH/tV7fqL+r/CRe5VAFTM0r/RKYZEI9BL2hDSBy4cvvxK/fl/jO+CyVFgZhqCQFZ8h+OXIDBZMcVAMsj2urFJl7RSY4S5Mbr0N6TTVo+DMcz1lymCofHp/fIkBfZ4M9ytu2W+63Q5+H77OnpKLWvSgEe3caNIdHkAAHzAY2mCGRGOu51j2rK1lnuBU8gT7LNLXqQkLvX23ouibuQA7V14cXuG4+GUuYZdRxbP/p8oulfeWPSNU2Bt46jcQf6ZG8G46x53FTcERw5JMq52JIEol2UjcNquM/eNu4h4m23DZU1hDoZiLddzfZbl7gV0BHwcfyqTRQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:57:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 02:57:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Topic: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Index: AQHa7tklv/4L4ggGKE+iM9Tw+y7ldLIoYlwAgAC0geCAABSogIAAAo/A
Date: Fri, 16 Aug 2024 02:57:44 +0000
Message-ID:
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
In-Reply-To: <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB8010:EE_
x-ms-office365-filtering-correlation-id: b4b71fbc-bcfc-4fb1-e47f-08dcbd9f33fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?d29iZFkvYmovemVYRi8xR3V6M21oMmRMaUIrZTh4Rmt5bUNhbE96d3NOV2Vw?=
 =?gb2312?B?VjQvYW15dURQeUxiU3Z4QjZqNDdyQU1IeXk3RVBkdEJGU2svVnVoRE0wS3RN?=
 =?gb2312?B?dHlyZHZ1SEg4cGZNRngzaDB0dVZxNy9wdHFkTUFrVmpaOVMyUFBabitQSm5D?=
 =?gb2312?B?NjR0QWtTczU3ZVhrMWRRTHlERHdKaVJxUzk4WVNuUG5YWklESDAwSFdlbU94?=
 =?gb2312?B?YURqUTZrY0tHTzZsUHZTT1dwdmJZSkwvd3ZnUW5Sc3ZSaFhlTzVoRVhJc0dG?=
 =?gb2312?B?NEwvZEd4K2lFUUVGdlVNbEFGUEJaNkZIeVN6UE1PeEVjY0k3eU04K3pwcFVP?=
 =?gb2312?B?OHZYWkM0OGFzT2t4Z1JqMzJyZmwrakQ5WjlVbjNEbzdlTDNYeGRZeklWU0Nw?=
 =?gb2312?B?VnZGRjBPbC95TkZpclgvTmRhbGwzVnc3ZVh1V2ZmZlhmRlFnK0dGUzN1M05F?=
 =?gb2312?B?VXJvT1U1M2ZYaFpWTkZXUkRwcm5uc0dURmh4V1RUU21VaUpyZThtRkI0MURI?=
 =?gb2312?B?YWwyVVNNb0g0M1o4OFhtVjRvTi9OUk1kajViZHl5TWJMV2Q0V1FlVldsQUp0?=
 =?gb2312?B?R0J2a3FoLzI2N0o2OU1BdmNsTkM4UEE5cXBUS2VnSXFLcXBKTkhGdDh6UXov?=
 =?gb2312?B?OEtSZ0NiQXdWdXNCdXVZYmFLa1FkN29MeUplZVRRTnhsTW9UYXJURm00Q210?=
 =?gb2312?B?U1ByU3c2Tk1rVUZjQjRaWnZsNHh3cVVkdWttbzZ5N2crdkJpdVVyL3ZmS3cv?=
 =?gb2312?B?MVZNMmNUemJqUEUvcGEybXJtN1FuV05JbzNjYjYxSHZTY2pzVDJ5bnhjclJt?=
 =?gb2312?B?N0JuUTRScjFSVkpkV3lHSEpkQjdkYWR1d0kwbUl5WVh3SHZacW5sRTNmbi96?=
 =?gb2312?B?WlI3UVY1dlFyU0VCNGtyS2ZwK3ZNRzlMSmRJamYxQWRVYmRQcWtBSXN4Vld2?=
 =?gb2312?B?UnZVYVArVkRPRXB5ODZ5Y3ZIR2lISnVNcEp5dHRiMFQycDdyS1hyeExIUWZL?=
 =?gb2312?B?SzJvNXhIWW9TeHFCYkVoQWlxUVJuQ2tpSmhUUkJpZDlPYk5yNjBQbkMvQUU0?=
 =?gb2312?B?akFWUFhXVmNYc3NPRFhnK2dCV2xxMVlxcUVHaUJpdlliTDE2NTd0aVRKeEl5?=
 =?gb2312?B?b09Cck1MejZzMDByZEJtbW9KS2hoQlBDZGZUSWxjMlJRM01mNElzeUNYWVc3?=
 =?gb2312?B?OUpZV3pjSDZLdG8wYnNMYTkyYm5aR0g2T2hveno3elVielZWem41ckc3bGda?=
 =?gb2312?B?aVJpZ2cvMkw4UWJ3dHJITHVHVW5nb1pBY0FKNGVvck44aFV6SXVzam9hcnlZ?=
 =?gb2312?B?YmxwUGxLbEdJV0VhUk1ya2pHQUU0ellBZGl6cjIyUVhpZXc4Mi85Q3JVbHEw?=
 =?gb2312?B?WUFGdUI3QnAzUGRZK2xNdGlNVHFxMGIrQWg5S1dpUWhhM1doWHBmQkV2M2J1?=
 =?gb2312?B?NjdoUytleWo3dGJUSmRqcUJFU3NRSlpFb3ZhMW9ocnBaQmFKa0lXOXZnSllv?=
 =?gb2312?B?by80Z2JMZjlMRkppdU5oVEt4QlJTMWxWTG1HdlJqdy9zUzJZTE9HTENXWWFY?=
 =?gb2312?B?dm1JM1lMMmhFTHVCTWF2bzVtVFRRVkxFOXZCTnJNMlB2SU1oRlg1Nng2czNI?=
 =?gb2312?B?dGtYTWRvZFZDU3VGWHpZbXk2UU94S29WeVdINVU2eE5SUTQrUGR3eGxHOVA0?=
 =?gb2312?B?Q2UzckdIMTU1aFkyc0duQ1dUSlFIN1dsYi9VMUFnYlB3UlRkQUlkUUVrdE5j?=
 =?gb2312?B?NW5rbVU0YWFvYkhEd0U1cXZTWjdyazJxU2tCMVZGdVBmZitqSGJOSlRYTVF3?=
 =?gb2312?B?QmJGUk9nV2ZSMklzcXpvd2QvYkY0V0dyNnYxZ2ROVjNkVTlEVkx0bHZHQktC?=
 =?gb2312?B?UFZwT0IzUENtUllIbWM0RlRxOVFXTmZJK2h0cFRvM2U1T0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?S25RSXFYN0V1OWFjaThRMkpreW5yUFJ0dGQ1U3A1NzJmL3M1S2VsQitnTjV3?=
 =?gb2312?B?VFVsZEJjMmJ4YkFmVklJS3FZaFN4Nit4WWw3aDFydjJOUXh3aEVWUldoVHVt?=
 =?gb2312?B?SXl3aVlYU001VW9wUkVGcUVUbkFrNlV6Tzh1OXNuSlFrVGpQc3RMMlBmUkdK?=
 =?gb2312?B?SS9lazZBT0xTeUNvYkppb1BiaVppcmZkaVAvUFgzNStIaE9pcHZSbnVqbWQy?=
 =?gb2312?B?R3pBZ0N4dW5lSXBlMFp2elk1dTZLUUMyaTNhZkd3Q2gwTjg4YWhNalUydkpa?=
 =?gb2312?B?Y0dYVG9rVmtORGt1UHVHeFAyYkhuWHhUTUw3RWNjY1p0MmpOemZxZDBJQmha?=
 =?gb2312?B?cEtFV1dZQ1pzbHZQTDFVR0tCM083d0NldzhDUzJIQnRLa3JkcFhjZzFKc0p2?=
 =?gb2312?B?ZmtKa2F0WThiT3dwYjF1UWlWWFU4b09hakRKcWpQUDRyZ3VFSGxoWmRFZWdp?=
 =?gb2312?B?bkRHdVZwZjhLRjRtRm5iMTZsTHNrd29KZnovV1JiZmtkN2dDamxyeGhSWEtF?=
 =?gb2312?B?TExuSTAxa3puSXFiQXVmb2M3RGlQZW80SEJwdkY2eGg5L0tQTlFtbXRIcjFo?=
 =?gb2312?B?Ly9DZzhHd1RuZUc0QWFQQXd2RjZaUzBFVzBOOXp0aHBMVk9aT3gxT3l1eFlu?=
 =?gb2312?B?aHdUazVMeGZEMWZaaUJOQkswNnAvOStqMTU3V0phYk0ralNnZmlWc3pSSVRN?=
 =?gb2312?B?TElWU1FsS2ExQ3hFZ0NVb3VNdGhMQnI0aTJpVU4rakR1WTF6Y2hSTUl3UFN2?=
 =?gb2312?B?Z0hKOGxvSkpSMTJIb09xMDlWWEtYd0dEaWd4cWRoMUpDWDMyWkxDSUJYZXhT?=
 =?gb2312?B?Q1FEQWJoNndIZG83ZTBJZStWQ2RtenZET0psZW5kVVhZREI0SWcyaUhDR2Fu?=
 =?gb2312?B?R1ZlYXpKVGhrQklrWlkwSiswWlpZZUZWTlk2dEV3Mmo5d2hVZ3RETzFHM0F0?=
 =?gb2312?B?bEtyeURrWnF2dVg1cFhhdEJGNmNiMEcrbXhJeGpOUWx6VGVWN3dCL0hqN0tY?=
 =?gb2312?B?YmZ4UjYzTDVpdFlENTkxM3Bwa3l4dytNQjZNYkpkMzk4OUtocVY4RlM0VFlI?=
 =?gb2312?B?NDVWYitVRE82dU11TEo0dm1ndzJWcmtPL0NFWkZxNjFlWjhXY2FJVGpKUFBD?=
 =?gb2312?B?UnBTYzdDcXlRUEpYUUt0SmU1d3R6MGJyMkx5Wkw3MWQ1MW12dWxCbjJpM3JE?=
 =?gb2312?B?dlZUS2NQNWp4TWo4Wk1tUzBmT3IyeGZIeWdUSFBSTlY0a0NkUEFWaGlQK1JX?=
 =?gb2312?B?MVo5Z3hheUZjWUhaWkF0dVd0UXk3T05wN0ovNTdrMmdKc1VGMDF2TnBCNCtQ?=
 =?gb2312?B?NjYwN3ArdDEwV1ppNlFOb0p4WTlEODEzS1VWd0Z5NHcrVE9mempRaGFZNUlG?=
 =?gb2312?B?K2RpWVJwbkJGUDlaekpOVW1LTWtXaGliS2FvbGZjdDhINXpvejk4SklHMCtH?=
 =?gb2312?B?dEZzcVNUTmxoU1UxY3VkRW14S1djd3MyRXFNRm1XNmpOUnZDdU4zTjNSSFdQ?=
 =?gb2312?B?K1JHc01id3ZNeUxWOWJkUmVZZG9MQUg5NjZHbm9sQUhaSUxRb0VxT0J6cWpp?=
 =?gb2312?B?WjJRZDVjSURML2hHaXcyK2hmTys5cE5ENml6dTBzN1l3bm9iS0pKbklVZkJV?=
 =?gb2312?B?K0VXVkxMVnR1RE1FckhqZ3Z6eDNDWk9ncXRIaENQTTZxSFgrR1g4NnBNUEFG?=
 =?gb2312?B?RG4zOE13WGxqOWdUbjJ0WlREbk9odVdKbGVrVGR4a1pnVWl6V1A4eGlnSjBV?=
 =?gb2312?B?WjErbDRLMkFORkNTSmREODVrcGtUWXM2cUpKbXVQR1BJWGFLbERpTWtUUVJo?=
 =?gb2312?B?cld0QmxjN25zUkl3WnVHa0szTmdaT2VsOXZHd3dDaFBDYjJmZGxLMGJnWktz?=
 =?gb2312?B?YUg2UXZBS2NUS01WWGdxakpFck5zc2hYSFFSNzVka2pwR2E0Sk1xRmhpS2wy?=
 =?gb2312?B?emM5V0crZm5UVExudEQ2KzZ6NEJVYkcrcE9WaE85YVZqK1N5RXIzR0JYNVVW?=
 =?gb2312?B?NHkrcXlZekY4YmMzb1BTRTVhazRHNnptdHZ4bHBNVk9obHpKbDVrc2F1TlYr?=
 =?gb2312?B?ZXZxUXRZYU9mU29TRkNOOGlKV0UvQXExYmx2QldKSGJPN2RnWFNOTUl5TEhB?=
 =?gb2312?Q?hxFE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b71fbc-bcfc-4fb1-e47f-08dcbd9f33fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 02:57:44.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Krnw81UMVaRcqGMUJdkPvj4/gJo8OhjJ8uMkJKwDzp3amE3nh0Fofk7kB5AMY418tiyn+GcFIgHCmmidtM7xxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjE2yNUgMTA6MzMNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGYuZmFp
bmVsbGlAZ21haWwuY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgu
b3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpIDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxLzNdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IHVzZSByZXZlcnNlLW1vZGUNCj4g
dG8gaW5zdGVhZCBvZiBybWlpLXJlZmNsay1pbg0KPiANCj4gPiBBY2NvcmRpbmcgdG8gdGhlIGNv
bW1pdCBtZXNzYWdlIGM4NThkNDM2YmU4YiAoIm5ldDogcGh5OiBpbnRyb2R1Y2UNCj4gPiBQSFlf
SU5URVJGQUNFX01PREVfUkVWUk1JSSIpLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQNCj4gPiBQ
SFlfSU5URVJGQUNFX01PREVfUkVWUk1JSSBhbmQgUEhZX0lOVEVSRkFDRV9NT0RFX1JFVk1JSQ0K
PiA+IGFyZSB1c2VkIGZvciBNQUMgdG8gTUFDIGNvbm5lY3Rpb25zLCB3aGljaCBtZWFucyB0aGUg
TUFDIGJlaGF2ZXMNCj4gPiBsaW5rIGFuIFJNSUkvTUlJIFBIWS4gRm9yIHRoZSBNQUMgdG8gUEhZ
IGNvbm5lY3Rpb24sIEkgdGhpbmsgdGhlc2UgdHdvDQo+ID4gbWFjcm9zIGFyZSBub3QgYXBwbGlj
YWJsZS4NCj4gDQo+IEluIE1BQyB0byBNQUMgY29ubmVjdGlvbnMsIFJFVlJNSUkgbWVhbnMgdGhh
dCBlbmQgcGxheXMgdGhlIHJvbGUgb2YgYQ0KPiBQSFksIGV2ZW4gdGhvdWdoIGl0IGlzIGEgTUFD
Lg0KPiANCj4gV2hhdCBpcyBhY3R1YWxseSBoYXBwZW5pbmcgd2hlbiB5b3UgdXNlIHRoZXNlIHBy
b3BlcnRpZXMvcmVnaXN0ZXINCj4gc2V0dGluZyBvbiB0aGUgUEhZPyAgSXQgaXMgcGxheWluZyB0
aGUgcm9sZSBvZiBhIE1BQz8gSW4gb3JkZXIgdG8gaGF2ZQ0KPiBhIHdvcmtpbmcgbGluaywgZG8g
eW91IG5lZWQgdG8gdGVsbCB0aGUgTUFDIHRvIHBsYXkgdGhlIHJvbGUgb2YgdGhlDQo+IFBIWT8N
Cj4gDQpCYXNlZCBvbiB0aGUgVEpBIGRhdGEgc2hlZXQsIGxpa2UgVEpBMTEwMy9USkExMTA0LCBp
ZiB0aGUgcmV2ZXJzZSBtb2RlDQppcyBzZXQuIElmIFhNSUlfTU9ERSBpcyBzZXQgdG8gTUlJLCB0
aGUgZGV2aWNlIG9wZXJhdGVzIGluIHJldk1JSSBtb2RlDQooVFhDTEsgYW5kIFJYQ0xLIGFyZSBp
bnB1dCkuIElmIFhNSUlfTU9ERSBpcyBzZXQgdG8gUk1JSSwgdGhlIGRldmljZQ0Kb3BlcmF0ZXMg
aW4gcmV2Uk1JSSBtb2RlIChSRUZfQ0xLIGlzIG91dHB1dCkuIFNvIGl0J3MganVzdCB0aGF0IHRo
ZSBpbnB1dA0KYW5kIG91dHB1dCBkaXJlY3Rpb25zIG9mIHh4X0NMSyBhcmUgcmV2ZXJzZWQuDQp3
ZSBkb24ndCBuZWVkIHRvIHRlbGwgdGhlIE1BQyB0byBwbGF5IHRoZSByb2xlIG9mIHRoZSBQSFks
IGluIG91ciBjYXNlLCB3ZQ0KanVzdCBuZWVkIHRoZSBQSFkgdG8gcHJvdmlkZSB0aGUgcmVmZXJl
bmNlIGNsb2NrIGluIFJNSUkgbW9kZS4NCg0K

