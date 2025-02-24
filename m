Return-Path: <netdev+bounces-169169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC0A42C75
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9093A88E7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3711EDA26;
	Mon, 24 Feb 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ngMTLu0X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58D155CB3;
	Mon, 24 Feb 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424391; cv=fail; b=NfngtW5Tw8IQFp5dtt+0FoD0NMs6CGFR2mRaB2gVHSNZZIp48yEXK/xIQviDMnhP6HGJubWnbiD1DIqkuFLQniwtwOxSPj1TVWNncJh2ElMBsyIMf8kM2exfD4nWWXb46Mert0spPswmpAFXUgs+gxvIm0AVEmOwnmVFje3dcFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424391; c=relaxed/simple;
	bh=Ip4ntJdA0vw0k3mVl++om78kLLIJbeRgcCAaVAiStm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jE9QWgPieO+xWT9KYkH0KMTDrI6MX9ap9QyDbtmVtSu8TI7hSl5GK/KAPBosp5UPBKacSrxoqxeTGGYdSygD6v2JQirBS8I76pPnLBOrEWv0SFI5a6rUG3Ex9raJx8z9/QDuU7HWZNOohs/Nq6cg4ofJ5qs3Ly5hzI/xU4KsK+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ngMTLu0X; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIuEfd016105;
	Mon, 24 Feb 2025 11:13:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Ip4ntJdA0vw0k3mVl++om78kLLIJbeRgcCAaVAiStm8=; b=ngMTLu0XcJ1e
	etyyeSztQFhA/xZW8fn26YCtz1vl+dvbOSi6D1X7woiUXmt8nsPdw91yDbYeRWBy
	3w3ITRRLMVmRkQGg9hGStuZUhKzORvACGViUu4NuERvmMXLwB1/yluwZS/uTnSQS
	T6obayK+teq5d2P9t8g22pRYUHlMGSQop4rZYNkOEDbfl/UQW2mao21hVSkyZhRD
	BJe2ZzYI9uN62t/yJ+1ZiB9bW7yY1UctYq9hc4fFCcgsI5MdXPEOX6gYVdeNNFTX
	gUU2w/qYlyuxYfIjo/7ZEp5NLlp/UbAeGkcTXKgCLDa25B7iRd9q9UcKwB2dy9Io
	GIIXud+SZA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450xg0r4xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 11:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3Mo3YVLFFwW+6TxNFI412k82DECaIiV8k0OmmIgt7pLpvdY1xAAjsArfHFhSnaMyfrs5Y2fAYtoIHZlkOPvAjRDTFy3Z+UwmdjM2wpfh56lvZCjTb+WPXXlFxrxAMPqlk0hB/STKwpg01z5KnZLM7gsrYC9LYku3ytaEEuA2pgZxo6z6qfa6/CLGPd3B1jXCWm9bYeAI2hRwgO35OeQ5ztQML7m+cVHA+DnDSJ7HsBYILvMQa4GMmu06xo4OYZtLsBK9k86HvWD9WnYrNBwjhS6+R9my/9FuCkhY3lJczug/ePOMZHr8lFKc0wMMDgtDUmPLRHbcjQsuE+Nej4jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ip4ntJdA0vw0k3mVl++om78kLLIJbeRgcCAaVAiStm8=;
 b=UweoB0cIsq3peakfnyFb336ZUu2WLeyQ3SeLfdrxAO/yIl8udjb7Td79SdOPxxNUgpd1RBqeIxRH9tGzUr3O6lcgFyqIxwkmhnjH6g9FQTYuQdh/O6tw+wz5KDXtNXW4CtvdjTRfQtDOGNj/5YF9VgpSR0A3sidlwUiQSIlZ94qFEMufbxmMnvpz9/WPowOOHFqfBrvg8lLwMrhuNZ7CzVA99NLaScROfksz+9Ir7SMPRZe88ik9aQkpsUqODyDl8K1pHIpXQCUvLEoZFrGuh1GqgZRDFNnzmeFtddXsbJXc9BRALaw5NXiuZ3Z1xn4mQI2+bEJ3SNxWn9M6kn8tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA3PR15MB5630.namprd15.prod.outlook.com (2603:10b6:806:304::10)
 by MW4PR15MB5272.namprd15.prod.outlook.com (2603:10b6:303:18a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:12:59 +0000
Received: from SA3PR15MB5630.namprd15.prod.outlook.com
 ([fe80::fdb8:ba07:3c92:8b88]) by SA3PR15MB5630.namprd15.prod.outlook.com
 ([fe80::fdb8:ba07:3c92:8b88%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:12:59 +0000
From: Yonghong Song <yhs@meta.com>
To: Eric Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>
CC: Neal Cardwell <ncardwell@google.com>,
        Kuniyuki Iwashima
	<kuniyu@amazon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Thread-Topic: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Thread-Index: AQHbhulT3ZjLHNl1G0KXnJJmpAFTzbNWz+OAgAABC48=
Date: Mon, 24 Feb 2025 19:12:59 +0000
Message-ID:
 <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
In-Reply-To:
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR15MB5630:EE_|MW4PR15MB5272:EE_
x-ms-office365-filtering-correlation-id: e0093ac4-3c84-4c2f-8e5a-08dd55074098
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmluSmpMSVNVakhHTUdGK2h6cS94MG1uT05mMHoxZDRUdm83TVh2djF4QXN1?=
 =?utf-8?B?YjliaTVjNU9EQjJ3VGczN3U5WEpWSTZOaThiVmZQT0FJZUNlWDRmQlhWODRp?=
 =?utf-8?B?U003OW1xMjRWNGlzKzRINkFuNVZTOXk0SDd4N0RUUll1eVROMzJKZTMvSTdi?=
 =?utf-8?B?SnFIVnRBai9KcC9tK3c0MDNZRVQ3M2tlL3JPMXUwbHdrMEpHYnptVkVWWVcy?=
 =?utf-8?B?OXJxWUVtOHhyTmZKVGF4bm0xU2E0OXVibE81aDZ3R0tZbW5pUDJuZTB1c0Vw?=
 =?utf-8?B?aTF5QVpocEtjeDVIZFhHZVVOdzB1U0w1SFhJUDlaWUxJdmJZdnNnMEpEdHZk?=
 =?utf-8?B?YW5RM3NhWDI5UW94M3JoOEo3RERWV2dXa05ZVDVCQ1YxcExjYmZSY3VYSkYz?=
 =?utf-8?B?djVzT1Vidm1TT3M4aFp5VndxK3E1MnlobU1iV0J1YzhkWTVWVHB4WnhGWkJE?=
 =?utf-8?B?NzlSYlQ3VHIzbXhLUVJ1MkZ6ZW5IdU1ReGU5OFFLVndpV08xYlVxSjRDVWpj?=
 =?utf-8?B?bTQ5bU1iQXNqUGViQ2NHbmNTK24yTGlwamx3NGhIRnUxRVBFcWx4dmdRdk5T?=
 =?utf-8?B?Rjc4MVdneVczVlJVYXBYOEJ1bkpsYTJLY0RIM3VERnZOUUh1WEVyZklUVHR4?=
 =?utf-8?B?U0R3dTZiZ01mTDdnTVRxM29VekVjNW5Za1JNSmo2MWE1cGJ4cmswaHRpUUhj?=
 =?utf-8?B?eGhzRFBFbU12RWNwT3VrOGp0QnRkVEV3d2oveml0WlJZVXZWaC9WcWxKVlVE?=
 =?utf-8?B?cndUUHQ0U21vd3k4a1FYWTlsUWcyYmFwbTFzRm14TG5aaEN4Y0E1Rm1taThr?=
 =?utf-8?B?c1RSak5QYjZ2UFY2bWZaMWhRQ1cvLzZPYU9EbVVOOTFqN3JZbG9tQTEvN3No?=
 =?utf-8?B?R0hhWlF1S1ZJZGtOT05WMXdNSVIwaDkxSlV5Wk5sQWIzQVhkS1lnamJ2a2RX?=
 =?utf-8?B?N25hZ0hTZ0FFV2FQTVByZ3JXN2RuR1hld01QcWlUY0ZJdmEyWDNzVVhSNlVR?=
 =?utf-8?B?TkNPLy9GOUxqbTd3STQ1c2NlOXZyS3JNK2lKZUFROGdpVjZlem4rUFBqZUNs?=
 =?utf-8?B?Q1loVS8rRndwWGRSTXRxSy9xMm4zdHBQdngwRDVySGZVayszNjl1TGRoUDd5?=
 =?utf-8?B?RHNnYnlRTTZVTm1EODZ1TFFSU3RhVk9Jb3JOOUV3dERTem9FU3FwRG53eWxo?=
 =?utf-8?B?VVdoVHIxYVNXbEgzRnEyM0k0YlZkVnNVQi85bWVYclgvOCtrelJZNkVrVFlJ?=
 =?utf-8?B?V2JLcE9ucXpoVENVSlBVWEt2TUtJc2JlQnd2aFVYSU9UQmt3SUh0bnFTZU1D?=
 =?utf-8?B?dG4wbHRlQTN1N3RZTGJ6K1oyaXBDL0ZDRGpjcGtBa3I0Y3JTY3IxUzFhYnJn?=
 =?utf-8?B?Ty9XKzhycndZSmxTa1B5TkM1Qmt4YkJiV3M5K0hUUExvVUd0dEpwREhXVmQ5?=
 =?utf-8?B?a2xxM1UyUUJ5Y3RXTWYxSkRWcm02eXRKRlA0RCtGZjFmaG5CWTVtM0FldW1S?=
 =?utf-8?B?N25Xd0hsNUJ1bFBKa2ZEaHQ0aXhUblhxNzlaVFhJOUpvS2w2ZndOU0FWMXdl?=
 =?utf-8?B?UnArY3A0WmQ3eWZZSE84cXFWT1hPQmcrZ2R2VE5XRVJiR2V6MStJSVdKcGhR?=
 =?utf-8?B?eXdUWUpnUWpINmxKNUFLRmRIRHZ3ZE9qK3ZmN1JubFo5N3dPMzNoclJCVktZ?=
 =?utf-8?B?ZXZ6U25QMjRLZnVidDNZc2s0V25IUmFiUEVCS2dnOVErRmpkZlFlOG1FVzNq?=
 =?utf-8?B?WG5LQzhiZFhqY0FwaEpGb25LTkVnNU5tbWFMTktxQmg4UVVKNUdjUlVIZ0RD?=
 =?utf-8?B?R21nM1F0WllCNDlza2RvNitSVXZsRHptMHZsSkFmUUJ6bHdsTk96dlgvS3FZ?=
 =?utf-8?B?UWZmNm1TZEhEWTg3c0c2QTZabTJ0cldwb2FEbWF6cUl3VElQMVlJK1FoOFBO?=
 =?utf-8?Q?1IgRQbxB318hsQfOs8iKGqr9iNkUsF7e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR15MB5630.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWY3a1NDaWY4ZnZGa0IwUGpsd1NsQXlNVzh5bkVLM0REbEwvbzFFVTgzcThZ?=
 =?utf-8?B?SGlUUVRRY0NGYmhEY3kwVlhxZkkvdXg4WEJXdTF0ZURYNWMxbE9qcTc0WjlD?=
 =?utf-8?B?YlpvV2djSjJ1RE1ybzZCNFE5akxPODROWVQyRGM0OCtWcTA1cHN5RlM1eDB5?=
 =?utf-8?B?VUF3cC9xaExSQitKbUtiSm02c1NOVG00SytUdTlyVXVJclk2dWsvbDRzV0dy?=
 =?utf-8?B?NnJGTjlRcjZTZ3A2YjNoOEN3NHI0NVVzZkVlbUpTTlZkR3VIaXh1UFZaZXQx?=
 =?utf-8?B?VUZ4a05CcTN4eXk2TU02VnVTamxiSXFyWWxmbEozU0tjR0dlckM0NFBQcURV?=
 =?utf-8?B?TFZFdEVwVGtrN2dONmxMVjJuWjM5bklXVDVDNXZVUVBTZzBxWDNidG41L25l?=
 =?utf-8?B?SGpRVCsrZkRZZUpwR2RzZElvWkVzL0pKNkd1UUN3V041NHZzNGE5SGp4Z2R3?=
 =?utf-8?B?WGkxRUtkMW1OSy9nMW1ZTFQrR2pFRlYwek5RTEpncm14MUNQeFY5cGQ0UzlO?=
 =?utf-8?B?UHhZbWVBZXQwRXgwa1lVR1Q1VlpDZUkxQkVEU3BFTzloR0lnY25sMVN3V1hT?=
 =?utf-8?B?VktXWUJwZ29RR1RLbjdEZXN2c2k2dEljRUFNMDJzSk4vM0cxN3loYjduNUo4?=
 =?utf-8?B?dTRNcVJPTXhYZnBKNU8xdFlJU1VYengrZGxPMVE3TU9EakZiZWNrVCs3b3dV?=
 =?utf-8?B?ZUN4MUlCWVBkTDZnY1RlQkhZWWZ0NStOVkZUUFNWS1VZdWNqc2I3Z2hNcWNv?=
 =?utf-8?B?UHMzclM1U0FkSzhSaGNoWXVxc0d0blJhUmZnWEFSZW91NUlRV3ByUUpOcStm?=
 =?utf-8?B?L09zM28vNEx4MWRIOVZBdUxPRkoyQk5yVHBiSWVZazBIWHhTazdTdHI4THFW?=
 =?utf-8?B?bzZIbTFsSzhDTGdkYy81dkw0VVM3WlVnV3AxdTF1c1VlQS9FQzNUVFY0YmxU?=
 =?utf-8?B?aHNjdUdnNHhlUVJtSG1sZG1nTVVmUWZjRjVla1MrYmpsKzU1WU5yNE9Fbkw2?=
 =?utf-8?B?d1FwRVhYVCtpYTlhZzFPMmVJU09LOWw2cnFDbDNMVUJueURRY3BGUDk4Y28w?=
 =?utf-8?B?N0dXdkNyazZ0bW0rY2h0STdrdjFVZWhoZ1NMOVZkaTdpcjRhbk9jaFhsUzgz?=
 =?utf-8?B?aGxBVlRwRGxMcjV6OUIrbGxRR3VPcWk0MnA4cEtNL1NCRzJjSHp1MXkrQjZn?=
 =?utf-8?B?Rk1BK0k4OWswaTJ6Qlh3SG5oWjRQcm5TOFJSdEdIN3IvdDhaM1BWaE1nUlJJ?=
 =?utf-8?B?SlF6QWkrWWN4eVNvSy9PSThTRmhENVJIU05sZG12UDJSdGlPcFRmVVhnWXAx?=
 =?utf-8?B?T1B1SnV2WW0veVlkdjJaSHVQL1NOWlBEWDVJM2NZKzY1R0d4REdYVlJmV0JQ?=
 =?utf-8?B?QVdHZWN6MC9tWnBnRDZ5V3l0VkpNYkNtVGJ6TGE1UG0rU2pLdGJqcStKZXhz?=
 =?utf-8?B?RjF0bWlyZUtyOERwRVZrWjVnbGZlQ3pBaE5teUErSkllN2JXN3FJWWIwQW00?=
 =?utf-8?B?SHRDUUpaNExHREdORmtzOTRYNk9ETzlXV0kzZ05EeEJsRHQ3Y3JycGxaZE8v?=
 =?utf-8?B?UEpRR1h6cHlSMitRVGtTa2txWXdnQ3dqVEplSWF4eG05YmVvQllPSUxTZXp0?=
 =?utf-8?B?a3BwNWZxOFJDbXNUbVpqTHZSRUM3ZlE2RFV3K3hVMElXa1ZSTEdZOE9mNDhI?=
 =?utf-8?B?Y3dCYnVaY0cyN2t6UUNHQUV4amdpeVU4OGFSSGpEV3lmdXJ1SUg1Ylk2ekxZ?=
 =?utf-8?B?YXNzb3poMW9ibXYwZStNZ0wzVkF5MFI5N2s3WGxhcmlpNDhrVEI4ZzZTYVVu?=
 =?utf-8?B?OWd3b29tSytqd3ljbVhTa3dBWXpTMHRvUEMvdXdnNlEwMlN5Qm5ERTRQL1Zx?=
 =?utf-8?B?d1g0ekhmR2xKdE5wMmt4d24rYUFpSVNmbkl1Uy91MWE3bktLY0VuRGJEOEZN?=
 =?utf-8?B?Z0ZkQmFoWTRydS9wL1dlVU1tb0xuc3F6bnVEamc0UWR5R2pRVVkyVTlHaWhY?=
 =?utf-8?B?ZFVHZWZ3cllxVzNXMm9kWUhKd0N6RlJDOUJRY3JSSWlhYWViZHZBZ0hHUFFR?=
 =?utf-8?B?cm54NnRWdlBLZ3AwL1JUUkFqYjZlMG9lODZZcytSQkRYV0IwQzYwbU9RVnEv?=
 =?utf-8?Q?VrTB5FcVI7lVVAaW7VuLlddxB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR15MB5630.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0093ac4-3c84-4c2f-8e5a-08dd55074098
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 19:12:59.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywkU4UvcIUiA8NlpbNrDM97zW4gciX+XeZ+QMCWujNyFCZFlUJLdeGOfqob1m9EI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5272
X-Proofpoint-ORIG-GUID: 7MSQBz-ySAA-0K_AyRHe4SYyhgHd3f8j
X-Proofpoint-GUID: 7MSQBz-ySAA-0K_AyRHe4SYyhgHd3f8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01

PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4KPiBPbiBNb24sIEZl
YiAyNCwgMjAyNSBhdCA3OjI04oCvUE0gQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4g
d3JvdGU6Cj4+Cj4+IEFkZCBhIGxpZ2h0d2VpZ2h0IHRyYWNlcG9pbnQgdG8gbW9uaXRvciBUQ1Ag
c2VuZG1zZyBvcGVyYXRpb25zLCBlbmFibGluZwo+PiB0aGUgdHJhY2luZyBvZiBUQ1AgbWVzc2Fn
ZXMgYmVpbmcgc2VudC4KPj4KPj4gTWV0YSBoYXMgYmVlbiB1c2luZyBCUEYgcHJvZ3JhbXMgdG8g
bW9uaXRvciB0aGlzIGZ1bmN0aW9uIGZvciB5ZWFycywKPj4gaW5kaWNhdGluZyBzaWduaWZpY2Fu
dCBpbnRlcmVzdCBpbiBvYnNlcnZpbmcgdGhpcyBpbXBvcnRhbnQKPj4gZnVuY3Rpb25hbGl0eS4g
QWRkaW5nIGEgcHJvcGVyIHRyYWNlcG9pbnQgcHJvdmlkZXMgYSBzdGFibGUgQVBJIGZvciBhbGwK
Pj4gdXNlcnMgd2hvIG5lZWQgdmlzaWJpbGl0eSBpbnRvIFRDUCBtZXNzYWdlIHRyYW5zbWlzc2lv
bi4KPj4KPj4gVGhlIGltcGxlbWVudGF0aW9uIHVzZXMgREVDTEFSRV9UUkFDRSBpbnN0ZWFkIG9m
IFRSQUNFX0VWRU5UIHRvIGF2b2lkCj4+IGNyZWF0aW5nIHVubmVjZXNzYXJ5IHRyYWNlIGV2ZW50
IGluZnJhc3RydWN0dXJlIGFuZCB0cmFjZWZzIGV4cG9ydHMsCj4+IGtlZXBpbmcgdGhlIGltcGxl
bWVudGF0aW9uIG1pbmltYWwgd2hpbGUgc3RhYmlsaXppbmcgdGhlIEFQSS4KPj4KPj4gR2l2ZW4g
dGhhdCB0aGlzIHBhdGNoIGNyZWF0ZXMgYSByYXd0cmFjZXBvaW50LCB5b3UgY291bGQgaG9vayBp
bnRvIGl0Cj4+IHVzaW5nIHJlZ3VsYXIgdG9vbGluZywgbGlrZSBicGZ0cmFjZSwgdXNpbmcgcmVn
dWxhciByYXd0cmFjZXBvaW50Cj4+IGluZnJhc3RydWN0dXJlLCBzdWNoIGFzOgo+Pgo+PiAgICAg
ICAgIHJhd3RyYWNlcG9pbnQ6dGNwX3NlbmRtc2dfdHAgewo+PiAgICAgICAgICAgICAgICAgLi4u
Lgo+PiAgICAgICAgIH0KPgo+IEkgd291bGQgZXhwZWN0IHRjcF9zZW5kbXNnKCkgYmVpbmcgc3Rh
YmxlIGVub3VnaCA/Cj4KPiBrcHJvYmU6dGNwX3NlbmRtc2cgewo+IH0KCkluIExUTyBtb2RlLCB0
Y3Bfc2VuZG1zZyBjb3VsZCBiZSBpbmxpbmVkIGNyb3NzIGZpbGVzLiBGb3IgZXhhbXBsZSwKCiAg
bmV0L2lwdjQvdGNwLmM6IAogICAgICAgaW50IHRjcF9zZW5kbXNnKHN0cnVjdCBzb2NrICpzaywg
c3RydWN0IG1zZ2hkciAqbXNnLCBzaXplX3Qgc2l6ZSkKICBuZXQvaXB2NC90Y3BfYnBmLmM6CiAg
ICAgICAuLi4KICAgICAgcmV0dXJuIHRjcF9zZW5kbXNnKHNrLCBtc2csIHNpemUpOwogIG5ldC9p
cHY2L2FmX2luZXQ2LmM6CiAgICAgICAuLi4KICAgICAgIHJldHVybiBJTkRJUkVDVF9DQUxMXzIo
cHJvdC0+c2VuZG1zZywgdGNwX3NlbmRtc2csIHVkcHY2X3NlbmRtc2csIC4uLikKCkFuZCB0aGlz
IGRvZXMgaGFwcGVuIGluIG91ciBwcm9kdWN0aW9uIGVudmlyb25tZW50Lg==

