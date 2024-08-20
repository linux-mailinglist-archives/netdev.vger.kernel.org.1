Return-Path: <netdev+bounces-119992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAE957CA1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81A01C209D2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FADB5C8EF;
	Tue, 20 Aug 2024 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eDQLhJPT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA417758;
	Tue, 20 Aug 2024 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130792; cv=fail; b=Wb0hq+KHIaoLuv0yiFqQNPLDOz6GnTlz4WlJQbdDL6jySZjjhhrF8strfh34vOwHHp32DKDT6qVJxVh4K/qpPM2b9I5Wev6vKng09R5lxiAdb64dovRJBCOjhQpw5MKlxyxrk7MFmM+iMPPb8M1fJ9Pl39gitSxvTYdW3iDBjuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130792; c=relaxed/simple;
	bh=1ymZkLeZMy3zDjZv9QBeyXTi3KV7C5jP9vmWIRPK6P0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ti3weAVJ2FiNMTrj569colmoePh5pf7lB/bsfrgzi4Tfokww7MZ2q6r/UMDUe5wASMIPHaYw4ox2LCz75Wwwl84Zh/qo2tWt8WL3qPXZU9u8qO7cZGoVxuhNONtK6U/pAWD24rF73PTZXLP2Z2voiUB/fZMIAj9Dc3hp5frV9uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eDQLhJPT; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWfpKNshIx/wa7XmodFifk5NkP53TrMvXBvVnEoTK9w1BMHaL5EW/QPI7XbTj7QfSRIW1/ujg6qRqwTqQEGq+X0lEdGh1UWuFL+7AIQVqiLHAr4JEN4vnG4V/SI8X8TFrSn8TPQ0KGFAFtED6/l9N95pY9Bl6T88wQiLj/rm3M9iw8/DEvM6WkCstAn5yxgKZhE0qdTj9f9aovjayuKGSRsoPS3h2ak4FP7VyCOeCYlpEDZWMrEhdUQ9XTGhjEeDhaW2u75t3K5a2NiU9YgXFqkVvLzlQyfCJLRsTmzfQLQBh1uIFD48NQIm3u74DoBqoUTuFMr42FpZw+nR1VeGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ymZkLeZMy3zDjZv9QBeyXTi3KV7C5jP9vmWIRPK6P0=;
 b=K8LlWHb3WtDAauCr5wrACFTQrPYkrOh65fsGkO/tb5l901Nf3FlqQy1ZNHOJO2/2u8bTzis4+pCx6RkdU5nIvM+cHBQMuOE1YAUngkF7opuLIx1MkVuxAHRy7qGSlY/UvHSt/MEbuN0/V4bGOywVoHWhCwzTJ1zFapMqYQNZoHb9W5R1zT9Vg5m7vxXmSccZX3U0sL+KQSXsYe8UrHqfzd1+T73GodtRzrQgD715fp1Rrei37d6BEyMSle4EJj51NGH0eMqwNw3eu47eCgZJBMTorecw0m2L0yo8OP4g/15WZPPpQaUHJKNaMl6TvnSJERd/9GtXOpPXU3pvMVDfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ymZkLeZMy3zDjZv9QBeyXTi3KV7C5jP9vmWIRPK6P0=;
 b=eDQLhJPTXoKQUY6FBzosTFfxELjDGVnTy+IxT9VxuPKqrT87K/N7HbvEmE6Mtn+fIat+SuHAzfsUhlFqCWpnmko4WiFqJMRZsRW+vThq7W2bvX68tI83vgRJOlV7kbXeBweqntaHuhyT1El8sOznat4wDInmCJFcDNdQE9yIVtrPEzKwNvbJ+TzF9FBczlQ5JAI80p1hBoCFsxJsZUcUp3dOaa9eywXik9ejayxxGv4bDRuhmJrEyBMCWF/Y8HGyPjfl0zNQ+59PqqvfdOWawqm86ohhelXlKzQ1q0u9zu6N7RLd3VjTzy4iVEKhvrojTBa00mjGt3GFtD+G2FLaZg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 05:13:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.018; Tue, 20 Aug 2024
 05:13:06 +0000
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
Thread-Index:
 AQHa7tklv/4L4ggGKE+iM9Tw+y7ldLIoYlwAgAC0geCAABSogIAAAo/AgAAM1wCAABLEQIAGUg+Q
Date: Tue, 20 Aug 2024 05:13:06 +0000
Message-ID:
 <PAXPR04MB8510B51569571BA58243FEB0888D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
 <PAXPR04MB851069B2ABDBBBC4C235336E88812@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB851069B2ABDBBBC4C235336E88812@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB7075:EE_
x-ms-office365-filtering-correlation-id: 8a66c314-c79a-4755-e0d3-08dcc0d6c6ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q01sVGNweFc2SXJuQU9NVkVQV3EzQVltR0xIL0NueVNRcS8wNnI3cWVmUnZx?=
 =?gb2312?B?ZnJpcmY3Z0hLVjRrYTFJQy9hMk45RDNoVElLVjlGbm5kZ0JCVmtURXNFWnYr?=
 =?gb2312?B?MlVvUm9nR3BqUnhsdlF6Vi9UOEp4M1VhNXlLUXhILzV1aUxxVkRhYklib1NB?=
 =?gb2312?B?MytwcS9LU0QxRmVSSXVMb2ZkeTQ3Z3BHaFRjUnEvc1dtUFB5ckZOQitYcGRp?=
 =?gb2312?B?ZUNQQWZEdS9KWll5QllXVDkwcHRnWklzd1pmOEl2eXQ5djFPeVhjRi9sdFFj?=
 =?gb2312?B?WVhLaGlrOHN1c25MSGVQVDN4cUo5aUU0UGJjNU9tcHV0RHl0MmQwSnBzSnNK?=
 =?gb2312?B?dkdJSVd6TVdta09zRUZJcGEvdGZWZEhlaVJwb3hidDdkbC9PWDNtVnJoeGFM?=
 =?gb2312?B?TGlTMzdmQzI2dll0cUQrWndkOWtSTGJwOUt0VTVLM0tZYkhMK2kxdXdTZjA0?=
 =?gb2312?B?Q1pSL1BHdzFKSXZzS3dwRW8vWEN2RFlpa0pjL1BEMktSbWtNakhNckVYT2tU?=
 =?gb2312?B?L05DWVBSNWUyS28vUEZMRmN6eTcwVXRFYlRWNGVzZTNYVG9aT05ESEJxQklY?=
 =?gb2312?B?OFJyOU1VS2ZXbWE1NHIyRllSNis3QS96S1JTM2hsSnJuNEJGTTVKbGZ0TnNm?=
 =?gb2312?B?cEIrK1ZUT3k0N2tna2dQdWUyRmVBT3lOOEw3cEdEbTFaS0hvandHWDhoeVRK?=
 =?gb2312?B?dENiSitvRVNYZGYxK3dZdGlJMHBicERYRngzVC9tTU5XMXR0TmpwM0tnTHRi?=
 =?gb2312?B?RGF5MDZVbVN2bkZKOURxdUN1aDdpZStRS0wwdElaWmxFeW4rTXFOL2FXSGl3?=
 =?gb2312?B?aGN1Y1R3KzdYSi9jdjIrZUxnQ3hIRnBRU1hIS1cxRlFsbE1FejBSeTByWVA1?=
 =?gb2312?B?V0ZiQ2QwYjZ3cE9YY2wydmxWR0VCemtmcWVQZEp3dkRkRytjU1M5Z1kwcGEz?=
 =?gb2312?B?M0txRmZFdlNtZjNOdlN1cG0wZ2poM1JhejlQMHd6U3dydU03aE0yVlB5SXNj?=
 =?gb2312?B?dHJnTzBCamdZb3Vuc25udGJxbjhOSStnZHczUkxHSTROdUZKZVVQYWYwRWo4?=
 =?gb2312?B?TUFPNjFjTDBBdkxjWTVBbXdQWTcxUGRCWllKMytLRTF3Zmh6VnZXTVZUS2Rh?=
 =?gb2312?B?ZjhpUkViQ1JrK3JpVnFHaVN2WEJIdXJlek1nWkV2ekRRSGtjVk42T3NCR3JH?=
 =?gb2312?B?Y2pWNTEzVHp3eHdkekl4bGhGR1FMYXduNmlKR3F0T0VwM3hwc3NWajlsams5?=
 =?gb2312?B?eFVvWk5Wa0R6c0k2N04xY21uZUFDdUtxNzg3NXBUQklURURnQ2YycFVDWmNH?=
 =?gb2312?B?SVdpN2JLOU5ISmt2WG5SRE5EbXdScGExYXdiQllCZDdzaiszVFR2U0tXdHRM?=
 =?gb2312?B?MHVxREs1VGRGdGlRTmE2eWg1TVhWbURHd1dJQlZXRktkL0lnV0hidllBUVlI?=
 =?gb2312?B?K2V2d0EwY0hseTA4cFoxNXMyQnR1S2poa1kzWkdpejNzN2hLbjVWNmxobDRr?=
 =?gb2312?B?bmZ4RXNLYkc2RWs3YlVmUlVObHhQTEZORFpaekxBbncwNzcrbU5sNzJPamJ6?=
 =?gb2312?B?UWFlMW93aEJ5NytVT2dXSGVUaXNlVTV2VXdJSDN2dE9WMy8xQXlhS1ltRTJw?=
 =?gb2312?B?QmhKTGFXUVgvRmZSWGl3VjFMKzkwOEUwOGoycXVlODk1R2pvME82dHRUMlNm?=
 =?gb2312?B?S0pRNEVSQit2MmtPMzI0UHpkdmVzVjR1d1Fwd3VUVHdLQTRzOUgwUUZUazc5?=
 =?gb2312?B?WEZCN1JENzlYMm1IMHdXMk9OUnRsNTd3SGoyZFZGWTNwL2YxY1l4TExXQ0Zq?=
 =?gb2312?B?UmpXcWU4b01ONjFSVVgxN0J0eXRCbGxMK0NGdkx1VTBkd2prYXJNR2JEWDFr?=
 =?gb2312?B?cDNUVEpJSG8wWjUzWk14dFRtb2V6K1RyQ21KMDlZV3Q3WWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RjBrNFFsTW1MdDBrWGx4S3VxQVNuT3NJNkFjcXFMb2p3amlSS3l3Ym1IOXFs?=
 =?gb2312?B?aGRaYVJsYlRGaDdMYjVJZHdyK2xnaWRjVW1YbFVSRGRSMU1KZEhpYndmWnEw?=
 =?gb2312?B?NmNhQUV6MmI2cDI4bk9lQlRIM3hhQ0E0MmdINHd4dHUxemIvUXZvOGtjeWlY?=
 =?gb2312?B?Nk1BS29KQ3F5emNYNENqR0lpcmthSXBSbCttUGNRYzFFeGtFbmxLSUIwanNF?=
 =?gb2312?B?WlRXWjQwdGE2Zy9ZV1hwb3d0YmpkR0NXaEJCZHlBODlCTjNHTWpEa3Qzbkpx?=
 =?gb2312?B?WUJiWUhCQVBWRUw1eG1Ob0RoWjJ2MnA1L0ZGNUUrMTduMmNKMW1SSm1lS1FQ?=
 =?gb2312?B?WENXZ0JLMkN4YUIzWGd1U0VBSmV5VlQxMlRPeWpNcVpESExYUWVtZjgxOGJS?=
 =?gb2312?B?VEZNQkZaei9ScE5nWU5Wb0FQcU96RHJlTk1qZVlGTCtDYUN1RENNVjhRYmd5?=
 =?gb2312?B?Y25KRHhmNjRlNkNKT0UwMFBjcTFjMk5oVjh3YlRiS2NsTVM4NkNmT3FyY1Ev?=
 =?gb2312?B?SDhPUllzMUFUcGpZYkl6b1o1cVNjMkdRbWRMUDRid2I1M21Yb3pRTGFuS2o4?=
 =?gb2312?B?RWc0ZXJmV2NSa2tSTWFCR2V3MXY3Y2hucFRMMjh0cis0NVVMYk5UVXdaTkxa?=
 =?gb2312?B?QVROdFVxeFdIVTdLQ2VJK0FtblgxaEQwSXNjSVJhMkNDMi9yYll2ejJTYUR3?=
 =?gb2312?B?Ynp0cE4zTHExdTVYdDgzWXcwTDlJRGNRWFVycWF3dGJqWkphS0paVUVWcXZV?=
 =?gb2312?B?L1VMWXFrMHRMaDlMd3JIem1DTFhUWklLVlE3dFhMUlhVMWx1RVdkcjlTSmg5?=
 =?gb2312?B?YzJuMWk2YnhZbGdYOTViMkFEUnJaUTJtSklzOU9TL0ZRQllDaHJMWitoSytv?=
 =?gb2312?B?UEZuUVB1V01nR0c5VXF3SlhiY2RIdWViVGdZbUk3M2NLcW5wS1BWSjRQR05M?=
 =?gb2312?B?dDcxQ3IyeFRpdjNocExGSnVtNGhxaXVmdlVCSFBzTXVFQW9FNUpnRlZqSzdE?=
 =?gb2312?B?b0s3Q0tCbjBDWXlrdEwzMmlXY1VqNzk0QmR6WWNnZTR6ZVRqQlZnWlRlMFhz?=
 =?gb2312?B?T210MXZ5ZTBXZkJFNS9Wd2VMUzhkQzRnTlVlcklMTlpZR3dyalFhNXlqdVB2?=
 =?gb2312?B?S1MzWFJyMlZseFg0bU9iQ2kzanhGakNjSlJzNWJRclczYzhzTkc0cmRVZUox?=
 =?gb2312?B?YTR4NDZra3NUSmJKMlNSKytscWhmSzhRSmZRbHV4YlpJbnZicFFCekFRL2dB?=
 =?gb2312?B?N0pJNWowWjk3QWQwdjlmVEh2d2MxRm8zU0tCMHRreFJ3SzVRbTZ0NjNvcTVZ?=
 =?gb2312?B?MjJqdmtBU1pjUDlBaFZNQkxGMHN0NnRKNkFOV2Q4UTZnSTZ1aVF2TFRxT0Nw?=
 =?gb2312?B?d0VScE05eXhsV3RuMVZyZWQ1NW1MdG16Mm5HSjFlQ3Zka1EvVzFBR3crTSts?=
 =?gb2312?B?czArL1dDVkh0UzM3K3kzdUFvT2tPSHB5cGNhTHJMR1UzYU9PRERSUGh1dHQ4?=
 =?gb2312?B?ZVExRGg0QTN4UDVNU1ZqMjFNdmdVdUczakFuNExyZnR4MUJLVkFTNmdjdmhN?=
 =?gb2312?B?NjlySUJIMVp3LzR6YnhkTlNIUUI1eTNmWTlSeHJGYWFQSWxnTTgwbmloUTdD?=
 =?gb2312?B?WVZ4TkRYcmVJbVJKdndPeGhRZXpyR0Uyd0g3RnVnSFdEODlHNEZGeCt2NWxU?=
 =?gb2312?B?bjFreGFoRTkrR1hvN255VGxzWDdCU2pVNFhnSTRJMHhYMzh0VzFNbFVMUDNV?=
 =?gb2312?B?eFE3eGtUdXFUaTlBRVY3bEgrNXR4bFJGWVBTZndJNkIzRFBoVDN0aVlDTVhn?=
 =?gb2312?B?L3RKbEJwOVdZOUdpZjhQL2FkY0NUdlVzY0VqNGFXZ20xMEtFTGZSbG53Tlpp?=
 =?gb2312?B?RHNlOTlVdzkxMjdGMGdudklCdSt0REpjcnQxODNkY1JETGkzT29IaHdtWVNS?=
 =?gb2312?B?emlqQ2svZVkrUW9xV2hCaU5JTmRZZW5XNlhjcmpYL1B0a0prSk0wb2M5emE0?=
 =?gb2312?B?OEVSd3NFUXpNVzk4SVlBR3NwU2Nac0JLeHpGb0lXendua29GaGw4NGJwYlZj?=
 =?gb2312?B?ZDlMQXV5eitVMFZYSnc4cGJuNXNXbDNaRUN1RXliY1MvNm95ODY1Ym9tM0F2?=
 =?gb2312?Q?24tQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66c314-c79a-4755-e0d3-08dcc0d6c6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 05:13:06.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91Lb8M9Xch7xccPwyd2LTeGGTw2kYmyCjGEsvSRtNQCiLsH8ij6xawSaPYlxr7o/Ron8oItEccN8w17URlSPOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOo41MIxNsjVIDEzOjAyDQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+
IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5l
bC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2Vy
bmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5jb207IGhr
YWxsd2VpdDFAZ21haWwuY29tOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IEFuZHJlaSBCb3Rp
bGEgKE9TUykgPGFuZHJlaS5ib3RpbGFAb3NzLm54cC5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIG5ldC1uZXh0IDEvM10gZHQtYmluZGlu
Z3M6IG5ldDogdGphMTF4eDogdXNlIHJldmVyc2UtbW9kZQ0KPiB0byBpbnN0ZWFkIG9mIHJtaWkt
cmVmY2xrLWluDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiA+IFNlbnQ6IDIwMjTE6jjUwjE2yNUgMTE6
MjgNCj4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gQ2M6IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gPiBw
YWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+
ID4gY29ub3IrZHRAa2VybmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5jb207IGhrYWxsd2VpdDFA
Z21haWwuY29tOw0KPiA+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgQW5kcmVpIEJvdGlsYSAoT1NT
KQ0KPiA+IDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMS8zXSBkdC1iaW5kaW5n
czogbmV0OiB0amExMXh4OiB1c2UNCj4gPiByZXZlcnNlLW1vZGUgdG8gaW5zdGVhZCBvZiBybWlp
LXJlZmNsay1pbg0KPiA+DQo+ID4gPiBCYXNlZCBvbiB0aGUgVEpBIGRhdGEgc2hlZXQsIGxpa2Ug
VEpBMTEwMy9USkExMTA0LCBpZiB0aGUgcmV2ZXJzZQ0KPiA+ID4gbW9kZSBpcyBzZXQuIElmIFhN
SUlfTU9ERSBpcyBzZXQgdG8gTUlJLCB0aGUgZGV2aWNlIG9wZXJhdGVzIGluDQo+ID4gPiByZXZN
SUkgbW9kZSAoVFhDTEsgYW5kIFJYQ0xLIGFyZSBpbnB1dCkuIElmIFhNSUlfTU9ERSBpcyBzZXQg
dG8NCj4gPiA+IFJNSUksIHRoZSBkZXZpY2Ugb3BlcmF0ZXMgaW4gcmV2Uk1JSSBtb2RlIChSRUZf
Q0xLIGlzIG91dHB1dCkuIFNvDQo+ID4gPiBpdCdzIGp1c3QgdGhhdCB0aGUgaW5wdXQgYW5kIG91
dHB1dCBkaXJlY3Rpb25zIG9mIHh4X0NMSyBhcmUgcmV2ZXJzZWQuDQo+ID4gPiB3ZSBkb24ndCBu
ZWVkIHRvIHRlbGwgdGhlIE1BQyB0byBwbGF5IHRoZSByb2xlIG9mIHRoZSBQSFksIGluIG91cg0K
PiA+ID4gY2FzZSwgd2UganVzdCBuZWVkIHRoZSBQSFkgdG8gcHJvdmlkZSB0aGUgcmVmZXJlbmNl
IGNsb2NrIGluIFJNSUkgbW9kZS4NCj4gPg0KPiA+IElmIHRoaXMgaXMgcHVyZWx5IGFib3V0IHBy
b3ZpZGluZyBhIHJlZmVyZW5jZSBjbG9jaywgbm9ybWFsbHkgMjVNaHosDQo+ID4gdGhlcmUgYXJl
IGEgZmV3IFBIWSBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgdGhpcy4gRmluZCBvbmUgYW5kIGNvcHkg
aXQuDQo+ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBpbnZlbnQgc29tZXRoaW5nIG5ldy4NCj4gPg0K
PiANCj4gU29ycnksIEkgZGlkbid0IGZpbmQgdGhlIGNvcnJlY3QgUEhZIGRyaXZlciwgY291bGQg
eW91IHBvaW50IG1lIHRvIHdoaWNoIFBIWQ0KPiBkcml2ZXIgdGhhdCBJIGNhbiByZWZlciB0bz8N
Cj4gVGhlIFBIWSBkcml2ZXJzIEkgc2VhcmNoZWQgZm9yIHVzaW5nIHRoZSAiY2xrIiBrZXl3b3Jk
IGFsbCBzZWVtIHRvIHNldCB0aGUNCj4gY2xvY2sgdmlhIGEgdmVuZG9yIGRlZmluZWQgcHJvcGVy
dHkuIFN1Y2ggYXMsDQo+IHJlYWx0ZWs6ICJyZWFsdGVrLGNsa291dC1kaXNhYmxlIg0KPiBkcDgz
ODY3IGFuZCBkcDgzODY5OiAidGksY2xrLW91dHB1dC1zZWwiIGFuZA0KPiAidGksc2dtaWktcmVm
LWNsb2NrLW91dHB1dC1lbmFibGUiDQo+IG1vdG9yY29tbTogIiBtb3RvcmNvbW0sdHgtY2xrLTEw
MDAtaW52ZXJ0ZWQiDQo+IG1pY3JlbDogInJtaWktcmVmIg0KDQpIaSBBbmRyZXcsDQpJIHN0aWxs
IGNhbm5vdCBmaW5kIGEgZ2VuZXJpYyBtZXRob2QgaW4gb3RoZXIgUEhZIGRyaXZlcnMgdG8gcHJv
dmlkZQ0KcmVmZXJlbmNlIGNsb2NrIGJ5IFBIWS4gU28gSSB0aGluayB0aGlzIHBhdGNoIGlzIHRo
ZSBiZXN0IEkgY291bGQgZG8sIGF0DQpsZWFzdCBpdCdzIG1vcmUgcmVhc29uYWJsZSB0aGFuIHRo
ZSAibnhwLHJtaWktcmVmY2xrLWluIiBwcm9wZXJ0eS4NCg==

