Return-Path: <netdev+bounces-183811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FEA921C5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ADC16B098
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9F253B64;
	Thu, 17 Apr 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jr1AEdfh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252F253352;
	Thu, 17 Apr 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904287; cv=fail; b=PpMnbpp515+GH1PJHHwOyQVn/d1fcQtDV9PDUieGETsSp03KR3B60YROVfQ7D4zd8RC8lxcMMhUJQYrJ/LVCn5C2Esq3asHXFTxbhqGlmF3soMd6aY1cs0wejNECx/ulbS/5yDdHODLfa/7ry0qLnML4ccLoxgk1MacnwtQYUZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904287; c=relaxed/simple;
	bh=OSP+8JilRcBUbTkyOPiaWVBjKQTXTy0DQo5K+LPBcCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izEf5u3yM27DU8laDT1Pf8WXYE+stBN2sj0WGY3N29djT1bSHO/+vyFdC8fVjqo06F+cjBUFGVMxxtuRhB/MMkCnO/xAmF1tIW0wkwG3mQ5Y1PapSQmrkUw1OOnN/pwNhomcdEOqrXB43CsrHjliOzamc0FJdmndmuLbg6VFVzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jr1AEdfh; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HEd2AB028763;
	Thu, 17 Apr 2025 08:38:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=OSP+8JilRcBUbTkyOPiaWVBjKQTXTy0DQo5K+LPBcCs=; b=
	jr1AEdfhum5eOZfZoRy9qk9/cjSGfMMezRjxjFyTPYJezOUdpI+j3fkSpTUsZfvi
	chmhdDRYbJ44AMt8ZDaAlZt91Es/Wv9sSiMtrMoeH+O54JujvaA5kzqLTbwbgshd
	012FXt2y6BtwcDkscfwSGpssAOToV1qe23hGBaQ1YJnmSm9qJEyDkp1vrLRAIQ8j
	M24d1rOBp1yx8UEKNwm1C2T8s6FdFHtgjWf6xTITpSgrLtVU5MBWVqp8W42rdqJv
	DILbwT+5uEKBRqM4Aq0LmfEB5LLQP6Hu5sWlfOy6i5FMuk+5KXxBfpdGnoQ6QLs/
	CzzafoEzqt37KFnJf8uvww==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 462rw6mac5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJyQqGWXIN2NREZEBKjkPeb+7bE6yiFWNfmnQAa3urO+rsqBlUUM6sPxqLYkWzFVG6keDlJx1uggu/1keVUsq2jgw/fVNOA6ieZh1vaLFd2RRBMBwLgEN2BafZFZDo1EtDVbx7e93dWldRZTCee+Zuxnnxs1h81UjcFy/NOnEnWDhsanywqKdEF6Jb5lv6uL59MSAMQXjl8HGBrfVuB8h1D+GM32sKK9mqectecG+8ySz3V7h8rbkf3yfOX0BzY3jkwLqRAbBDwCHaT/DsuGKme+bVZxPyc1fmcZkxi+343bg8rtROc7MgFUVDw34MB02egHB9Okf4pK9yhTz9DFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSP+8JilRcBUbTkyOPiaWVBjKQTXTy0DQo5K+LPBcCs=;
 b=iYzjqEwFofaJjRf9cC4Wjri6riH2Ew5bAXKTXJsm4ejSD2s+JBnkhHmwxFs3h3qIfnsOMk7Jmi0Asc2ePXQIwlTgzcXuVZyTYrGGLB9BVVeNJTamTtCSsZ/q69QPEeRSiK8+3lJFtn8Gql2XMN9sA7Ohk0+blagITloO1KzsgR5PAOop5kyaTUpsM/O2b7LGbW8qqRSC4wzUdQUpZX7ojpVtt9mzZ7mnu0IyFxzrphOD7+A6aA1bgEdrzNOMuigNcExVgM0Nw8gxAwPUpjfwFzZ076Pv2yRITvmUPvP+nac66NqH65imAnck1jPScpEyNemBUuFbS4vo1wi03moFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB6494.namprd15.prod.outlook.com (2603:10b6:806:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 15:37:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:37:59 +0000
From: Song Liu <songliubraving@meta.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Breno Leitao <leitao@debian.org>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Thread-Topic: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Thread-Index: AQHbrwUHpR08jPFxa0WeDmIG+BoIGbOnbecAgABNhYCAAByQgIAAJ1EA
Date: Thu, 17 Apr 2025 15:37:59 +0000
Message-ID: <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
 <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
In-Reply-To: <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB6494:EE_
x-ms-office365-filtering-correlation-id: 8d7ead5d-a5d7-4198-8064-08dd7dc5d50f
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUMwSGY3RjdwZVZZcHRzSXZsbU5jN3N2T3RvMTlJWmJja1Ayb09vSTIxWkFz?=
 =?utf-8?B?Z0NxY1pOYW9RN2toZExIZitsOHo4N2xqaGR2S2VJMEpPNnVjVnZxTDcyTW40?=
 =?utf-8?B?RVZOd3RuMVdMTktXSnNkeEwwVElTRlQyRTV1ck90RWNETm1iRng2eGp6SzFJ?=
 =?utf-8?B?NlZLMTFoeStpWnFOY3piWkgvZXVjS25lV1B5RlFaYmJKM2ZvanpRS1NOcnNX?=
 =?utf-8?B?R1VUZFI4OWg0TitxRDloWm9mczZKbmVxYXRLd1JLOTBlcjdMTWJpM1ZManQx?=
 =?utf-8?B?RXhQU0k2bThyUGZ3Y1FOZDAxaEQ1N2ttUjVtTWswSVFMa1R4WUQ1R3MwTHdt?=
 =?utf-8?B?TWdld3NxRkxuanZ2RVcyWmNoY3loeVVXYVIxVnlaQlJQa0NUM0RxYk5oSFZD?=
 =?utf-8?B?UkdKYnAydzJGTWo2TTNxR3kzNjV5YkJoVGhrY1FGWFEwVnZPeVVpdUpIbXFX?=
 =?utf-8?B?YlEwZUI1YnJWMVNrNGdHTnVUak1mOExXY1lZVjBsMndKUWZQRHArYVc3Mmkz?=
 =?utf-8?B?bjNNbUltUk5qbGZPZ29GL2ZTVXpKeVVkTlgyMjk0NGFLREZzSW9KUkY3QWd0?=
 =?utf-8?B?M0laclNDRktqRThEYVNvTHZQNEZLMkNOSVFCYjZqQUczVlhDclRIeTdiVndl?=
 =?utf-8?B?WDFkb05Uc1ppQ2pZT1B0ckdIVU9hTXFlQTBPS0k3eVU5WUp5ZFlsY09CQVdQ?=
 =?utf-8?B?UkZoS2Zsd0lLd0FSdXRWN0ZLalk3enZmMmlob1J6eEw1eWd6NG1KdDZkK3h1?=
 =?utf-8?B?RXZwbWRXR2p5czZoOC9XRFNNMTV5WlY1eFBQeCtSa1J1RHFoQzFkbzZ6Ukdp?=
 =?utf-8?B?bXhPTThpL3VMK3kvUmRhZGFBTTJVcjdIRWk0OEo5UnI5Z0dzSXcxcnI2MUVh?=
 =?utf-8?B?bVRYTUp4akVobTVYNDV5MFo1OU50ckU0RW9pVURvS1k4eHVxYWMyNU8rUGZM?=
 =?utf-8?B?QWg5YXR2VEl4OFF6Y2s5TGRCTVY5U252eFhBMlRSMUgweFk4OGxCZ1M3YVhX?=
 =?utf-8?B?R2htenF2V0dWeDU1MkxsTXdkTWJsTlRLa0F2V3VkcUZpTGFybEJjdXJWbzQz?=
 =?utf-8?B?a3p3bzZLSHEwZWdROElKeE8vMUJ1c0dxVXNHN1JtaFpmdFhhSDRlNUJqdEJJ?=
 =?utf-8?B?Y3lUcEh1QTdOMnRac3NxeG1NUEErY3dQTkR2Wm55OGVxbHo1UktkbVd2ai8y?=
 =?utf-8?B?MVN6RjRIN21nTU40b0JSbmprQzVFRmRxV2dGWHFRYmpwM3YxWWlabksvbmRZ?=
 =?utf-8?B?emkxZU51MStBQVJlazRod2tlVE9rL2ZPZ2NEU3B3cDMxdnpVSER3OUdiNUlh?=
 =?utf-8?B?Um41OFgrRmM5b0FKVVVtWUQwb3JHb00za1lleXp3aVFaTzRxcEpPdEw1SXVS?=
 =?utf-8?B?MUtuM044ekQvdDU1bnFISTFQSjFxbUNBU2FwcnNGc3JvT2taUDAwSll6WlpK?=
 =?utf-8?B?TmE3ZDlVNElscUpuTzZLYVV4VTZCR29XaGEreVp1MzVLTmZHZk01ZDNnS3lu?=
 =?utf-8?B?aXQ5ME5KcjhkdGNSV243bG5uWlVnQ0s2L0tWQzVsdDh4VVF2M0FXZHRUWkdJ?=
 =?utf-8?B?TzJwajkxdVkzN3c1OVlGVjl0NmF5OTM3T1FHWW5FSk1HWVV5OHZzTWhoT0lF?=
 =?utf-8?B?b0FYMEgwSVV5UU1Va1plY2xaNENsU1lvSCtEQTFaSjh6ZTZBdDN3Q0dBMkxp?=
 =?utf-8?B?ZGlTYjA3aEtNZmEyOWwxWG02T3l6djRGUWgyd2Q4SzMxVWR4SHM5VmZvSmx6?=
 =?utf-8?B?enNrVzZ0QXRxZDNuc0pzeHJhZXp0cmpwRHZqc0JaUzRiZXcwTVhKcXZSdTFN?=
 =?utf-8?B?NEhFZmRHSmNzdC9YUGh3cXZSZ2pSSTByV0UxV2VsdEFTa2lmWU9rQ2hOcHJk?=
 =?utf-8?B?TmZVYm1TMCt0c3R3WkhKQnBRZTJVZ2VPaTd4TDJmaWJleHpNaTBVbmpwdDZs?=
 =?utf-8?B?elZST3RZZDJpaXlyd0ZMODd5VURLSitxeENINjJ4UktDSkt0RWt2dTFoR3Nq?=
 =?utf-8?B?RjZwSGhmQTFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW16VGoxUjAweC9wcVBhWjl2M09CQUVhMHA0V1lLSmRSc0YreGczNXVvOG1Q?=
 =?utf-8?B?TjN1OURpNUlMMWJ5Szh4WWh2VVhVUGxaNmlORitSeW1KS0E2SGtqaWhHdjB6?=
 =?utf-8?B?dHB6RlkyZm1UQm9aejJNcGMxbGFYWlJTbi9WdUhNRHBYZlAyWXdiY0RRRGRP?=
 =?utf-8?B?SWZNeml2ZEp6VjFiQVM3REw3a0NWeW9ndGcrNVFIb0pkZXEzajJsT2ZuMDhC?=
 =?utf-8?B?cndJbVY2anpRemlHeEJHQlZoWkhPMGpqemltOWQza29keUJkSXBRR0VqQ2dY?=
 =?utf-8?B?cGRLblhZUnhpZzBkb0ZqaHlXamNRWnlTeGRTN3Q4OVV6T0lHL0c4Yk1TdG1P?=
 =?utf-8?B?eEhUbWJuSElucDBvcWt6Um1wZC9kSFRzVHNmRUdRdHY0TnVrY0pFUHVUQ3F5?=
 =?utf-8?B?ZGV5eVNhQm01ZDZ4UkU1cndPcUZBeGEreEhWb2dBU2k2czFVbWwyTWNaUUpt?=
 =?utf-8?B?empWTnhCUDVYMUc3dVpiMmJaYk96bmZuYVRSU2NEenhNcXdyVnRMSnh4cTY3?=
 =?utf-8?B?WjMwK3lPYkRuMFhuZWNHVTRrZnc3YTE3ZityUmFDV3Uwd0dXNEgzczBDdFBm?=
 =?utf-8?B?K1MrMVN4NFJuVXRDN1hESnpCY1l1UUFtcnltL3IyUVNZRE8yUWIwNTBpR1dw?=
 =?utf-8?B?VWZ6S1BSZUViMytza0pMVENSRFVmZDlSTi9FeDdqYnlQN3FLbVhEcEdCYWxr?=
 =?utf-8?B?MnVWWmFKVUlzRjRVYmJDeVVUL20xajY4cTNtNWh6MmJrY2pnMFIveFk5Qi9L?=
 =?utf-8?B?VkxlVHQrZ0hmc0drc2gwN0Q4RXVlWExBTlRZeUhleEtFSGRZQzgyTXQwa09y?=
 =?utf-8?B?Q0pvblM0dzRuMGNWZThDK1dUWjVSMjZpZXpOdUUzbGs1Z2ZaRUlyMFcyY0FI?=
 =?utf-8?B?dC9mcGI1LzUxS1hoNWs5T2wyWTU3MVVPNVRPRkdrcVd4OEcyelFhdTVwaTdw?=
 =?utf-8?B?aTdhZm54SmJZS1ExcHVCa2U4TTRJd3UyYjQ1NDh2NXZDWUFoQ0s5OUJwZlB2?=
 =?utf-8?B?Zlp0UlMvWUN0OSsyWGxXQTZhb0tBWG4weUZqUzdEWXM5eklHdjVROVlqUDU0?=
 =?utf-8?B?Z1ZFSGhURTRWTGpSSTRqZVNJT0VNM251cnVNQzZ1YWVRTWY2RnN0R3RMdE11?=
 =?utf-8?B?OGszazlSaXRqc0k4SmZlQnhKTkwwdlpBVE5VRjg1Z2s4a0NOMTR3aVRnSnEw?=
 =?utf-8?B?dDZJZG9EOXRWL3lMUjh2SkY2bXZuSC91WkgvY042d3c5VUVzTGtFVVpIS0ls?=
 =?utf-8?B?S0w0ajdZeUlFbEVIWTZXNEFCdVRkbHdVeVJOc2F0bm1ycU9QTUVhZkYwaXZq?=
 =?utf-8?B?MU5Lc0U3V1dHQUxwcGpVVEEydTIxMUJJMDFjYjI4M2lMS3hZcFVudCtMR3Vm?=
 =?utf-8?B?ZHRoYURtZXgwNGlBelhGY2F2SkVVbFVOOWM0WXE4c3FCbVM1eGVJOVdLWVFh?=
 =?utf-8?B?L0Q5UEwzOFliWEwwSTJHeGFZcGVLaXZhd3R4ZmF5L2p2eUU3RUFCWUhYa2cx?=
 =?utf-8?B?RUtmQzJNSG9zSS9zWXFmQXlDMUdWU1lDdk94N1lsbEJvVW1TcmdBR3NzMklF?=
 =?utf-8?B?N3MyQ0w0K2hONUxXdmVQdkU2bk1ZRFhzaXhiTjgxaGZnZnB2bDQ5Nk1PSUN1?=
 =?utf-8?B?RTZZaEZvanVKNjJudUZnbGc4Z0paRlRBT3pNYmZiRGN0VlNjVmliY3VSb1B5?=
 =?utf-8?B?VGg1SzVHTVd2TVAzbDVqQXpIdUxnN2ZqUm8yejRQeXZDckJIMTVaUzRQQS81?=
 =?utf-8?B?L0NMR1lhQzYzbithL0ZFS1NzY25WUWZmZi8wOWI1alhWUDdDcWY3VGJuU1FZ?=
 =?utf-8?B?OXNYdmxyb1RjSEp1aExWLzlvQ3p3cFRhNUEzb3lYQll4Q3VOdnNYNkl3anpo?=
 =?utf-8?B?b05VYmJMUnpTUVQ1QmVYdTZuWEU0U250Z1NqUjEwbnlrMW9YaVpJcE56aXJV?=
 =?utf-8?B?MHU5QkFiKzZOQ2JFOFZQV1dBN2l1OUFpUEJrRDQ1VVpzWmN5K3k5dHg4Vm0x?=
 =?utf-8?B?dTl5bGNYM0R1S3JpNnNNaG5YajFBSDcxYlllWlVUNVNXdG5UUHV4a2RONy9x?=
 =?utf-8?B?NjVZSHJkSlQ5UkJLVXVSNEg5bjJVbGUrUDhNbjZPM0txeEMxQmNQQzlaU1F4?=
 =?utf-8?B?bXJvT0ZHOVN4WWF1cThKU2Z4RFI3UlpOVmRxLzE3OENLbzVkQXlRTjhINmFK?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43412E2B256BBF459E8312A8FB95282D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ead5d-a5d7-4198-8064-08dd7dc5d50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:37:59.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP1C6TNzheTw8soRKeDNvIxalXLQaBwpCqsqB9UQUCWXUXOvs90S3BRFAA78dZsZ28VMXxomm5pUf9ZxNbCZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6494
X-Authority-Analysis: v=2.4 cv=WLF/XmsR c=1 sm=1 tr=0 ts=6801205c cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=HuaqkK1U_g7WYMCNvusA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VhtvossYZolwv9ZXV4uCrxFjg2UmI2iy
X-Proofpoint-GUID: VhtvossYZolwv9ZXV4uCrxFjg2UmI2iy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01

SGkgUGFvbG8sIA0KDQo+IE9uIEFwciAxNywgMjAyNSwgYXQgNjoxN+KAr0FNLCBQYW9sbyBBYmVu
aSA8cGFiZW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gNC8xNy8yNSAxOjM0IFBNLCBC
cmVubyBMZWl0YW8gd3JvdGU6DQo+PiBPbiBUaHUsIEFwciAxNywgMjAyNSBhdCAwODo1NzoyNEFN
ICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4+PiBPbiA0LzE2LzI1IDk6MjMgUE0sIEJyZW5v
IExlaXRhbyB3cm90ZToNCj4+Pj4gQWRkIGEgbGlnaHR3ZWlnaHQgdHJhY2Vwb2ludCB0byBtb25p
dG9yIFVEUCBzZW5kIG1lc3NhZ2Ugb3BlcmF0aW9ucywNCj4+Pj4gc2ltaWxhciB0byB0aGUgcmVj
ZW50bHkgaW50cm9kdWNlZCB0Y3Bfc2VuZG1zZ19sb2NrZWQoKSB0cmFjZSBldmVudCBpbg0KPj4+
PiBjb21taXQgMGYwODMzNWFkZTcxMiAoInRyYWNlOiB0Y3A6IEFkZCB0cmFjZXBvaW50IGZvcg0K
Pj4+PiB0Y3Bfc2VuZG1zZ19sb2NrZWQoKSIpDQo+Pj4gDQo+Pj4gV2h5IGlzIGl0IG5lZWRlZD8g
d2hhdCB3b3VsZCBhZGQgb24gdG9wIG9mIGEgcGxhaW4gcGVyZiBwcm9iZSwgd2hpY2gNCj4+PiB3
aWxsIGJlIGFsd2F5cyBhdmFpbGFibGUgZm9yIHN1Y2ggZnVuY3Rpb24gd2l0aCBzdWNoIGFyZ3Vt
ZW50LCBhcyB0aGUNCj4+PiBmdW5jdGlvbiBjYW4ndCBiZSBpbmxpbmVkPw0KPj4gDQo+PiBXaHkg
dGhpcyBmdW5jdGlvbiBjYW4ndCBiZSBpbmxpbmVkPw0KPiANCj4gQmVjYXVzZSB0aGUga2VybmVs
IG5lZWQgdG8gYmUgYWJsZSBmaW5kIGEgcG9pbnRlciB0byBpdDoNCj4gDQo+IC5zZW5kbXNnID0g
dWRwX3NlbmRtc2csDQo+IA0KPiBJJ2xsIGJlIHJlYWxseSBjdXJpb3VzIHRvIGxlYXJuIGhvdyB0
aGUgY29tcGlsZXIgY291bGQgaW5saW5lIHRoYXQuDQoNCkl0IGlzIHRydWUgdGhhdCBmdW5jdGlv
bnMgdGhhdCBhcmUgb25seSB1c2VkIHZpYSBmdW5jdGlvbiBwb2ludGVycw0Kd2lsbCBub3QgYmUg
aW5saW5lZCBieSBjb21waWxlcnMgKGF0IGxlYXN0IGZvciB0aG9zZSB3ZSBoYXZlIHRlc3RlZCku
DQpGb3IgdGhpcyByZWFzb24sIHdlIGRvIG5vdCB3b3JyeSBhYm91dCBmdW5jdGlvbnMgaW4gdmFy
aW91cw0KdGNwX2Nvbmdlc3Rpb25fb3BzLiBIb3dldmVyLCB1ZHBfc2VuZG1zZyBpcyBhbHNvIGNh
bGxlZCBkaXJlY3RseQ0KYnkgdWRwdjZfc2VuZG1zZywgc28gaXQgY2FuIHN0aWxsIGdldCBpbmxp
bmVkIGJ5IExUTy4gDQoNClRoYW5rcywNClNvbmcNCg0K

