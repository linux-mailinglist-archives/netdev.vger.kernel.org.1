Return-Path: <netdev+bounces-136359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012299A17FD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B03F1F21847
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBBE22612;
	Thu, 17 Oct 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eV0qpUux"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0B18EB1;
	Thu, 17 Oct 2024 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129504; cv=fail; b=rdHNwclBVsUrLAppegA+1wxiFV/orwy7owqmlh1igTk01W2IduNB107Z5Cf/x+8KBTudvdDFOHRQVoYHIotQpUykQo88N8p8MGqvjQ3wk6GMEBr1ZeBrtPRLrGxrrJhnVjsqV1vqObsQRGEoNcRaY1TScs6lyI9BRjVciISC66Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129504; c=relaxed/simple;
	bh=s9pLX5ZoFfVzq5/xS6qiUc5gvANg0cnHc7FeNM7jbOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2JKGNorcIF7PdyXaCicAlxy6zUs4r+ltUZ0c+gFjJtzeyApel9PawWqfgBUWJ52enkyAUuRWuNpAOz7wmI+GNH0b/Gt/5JJDkaoQvDPuDopabXBO8oWLUv1YM80c/V7rblpr99yM/ujcAM0+sIjzSzWRXm4FHZSdhRviF/c9M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eV0qpUux; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytZ17HVvpBCYQdOrp5T5xy+2ii6HGJvZBfmHbyip0dSOUEmF6qoSnW6N4kJskPCxFoOcQ7kI4K6NoB4W/JfcCQ+Ex98kMSk/KxOE65FzgOZ4YSAxg15pOUBC4XD1nVKZXXTPEX3Oqatnzg5wn117ZihGI2+kGHlZEXbRVg5zTfOKyeIkq135IoOT+Vn4/T7cQx4i2UxoQeGLa9BqX7V0iLjLOYCe2E8WWVHpsG2BGIjmpRo8o7A0Sl3Fpv5UDFI20yCtR8ScxhbwLmwbaoNX6jUYAH0myfPi+fT+PLHjvM5FZUADKpYNnofzrBG8vKUcxlFli0QGuAKpRCIuhDIT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9pLX5ZoFfVzq5/xS6qiUc5gvANg0cnHc7FeNM7jbOs=;
 b=DhVMI9Ee/jPcla3mPP2PtJUCKe8gT8bIQsbPuOJlDNwMPtAmRudGIw8pWul2abLZDecWsWP6RYm5oIFb9sxRIKbauIHNN0Z2SuNYTrg+32vz8E2QA+y0RxjN+FM0DLGdWTAOuQyeAmNJ9NMp8upFCFH91KFsSMg6fwNzYCHHzN7H3E0HVMQO35Aq73oIkX+IgQ1lsj5kF70N4MvHEFIkqpBtwaZCWB0wVY5sG33TUDr4DoGb8REeyrsMbzrUOJPP5H/lzpeYXdysxkQeyo2ueCrjMpuccK/4eids5F2CzXbNTWojhZrJkNcFCDm+VHUIPtU0v1F1LXevd/trJ2iKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9pLX5ZoFfVzq5/xS6qiUc5gvANg0cnHc7FeNM7jbOs=;
 b=eV0qpUuxSJF9C77JrcV8/Mf1ivu9MXEVTPavMXZv/IHcvueXGDoRKpCeu/J72fBlMxBil23yXzccBt2Z6UGrDs9T49lq0AvAj/4x76Ws2FI85R498GB/jLL9PuxD2c3cqXvSc1TPCgDJq55NSzSQak+eCv0CzHgGLlGAsPEQ535DUuvKIc8f0kORqHKErrLRe3iTVTTbKF9whfMLkehmPA4/x0b/jT1fERKVEzN4XSxy8XOEoEqY/4rtArJ2CH44xQIC/HOJJM5TiKzpEl8Gy7ryLZtFJj5LaDRZwH1S/XoNmhisipe80Lg4Ov9Sm5PsNWb6dA3mYUBl5LA5fwn8fA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 01:44:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 01:44:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 04/13] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Thread-Topic: [PATCH net-next 04/13] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Thread-Index: AQHbIBWvu1+ExEiUCUiDq4K29x6P/bKKLAMg
Date: Thu, 17 Oct 2024 01:44:56 +0000
Message-ID:
 <PAXPR04MB85104D687950EEBDCED2420988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8346:EE_
x-ms-office365-filtering-correlation-id: 5c59608a-d8ff-405a-a6b1-08dcee4d4d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzN4UUo3dVNWcmlsNXQvdWExanBBSnF1N29YOE02WmdGMjVzUlFOek9LMC9o?=
 =?utf-8?B?TDBxaVFaSUZ2dHNLREEvZmZjRGhscG9YbUZkWW4xeTZQem1ZR21vMHU0alhJ?=
 =?utf-8?B?ekJpOGVhWDlTcWFhRUxVZTRQT29IVkxYeHJlbklSTUZuaWRjM0Z5NE1sTGJ2?=
 =?utf-8?B?WDRnd2Z0RjBtUU52Sm9nR2thbnRTL0RFVnFGMjRzY3drZUY1MWFOM1I4bzVS?=
 =?utf-8?B?bC8rL3VnOVlsMFZKeTQwWDBtWFNEYXcvVUNhQ3VETEdqUzR4bUNhRVEzQWpr?=
 =?utf-8?B?MnI0ZkRPL1hURjV4Y3l6Z01pSGZUTVppUU0zbWp3V083eDhneWNpU0IrNWwv?=
 =?utf-8?B?NDdvS3dPbnhwbHZhelA2aEhIbkdEQWZvZVduV2hraFZ2c3JsQ2g0SW5iOFBM?=
 =?utf-8?B?d1dkYitwa3hnV3ZreXgvSkd3aVlFZ3NOOFNmeXRKOVhGbUs2b3hKUjFNL2t3?=
 =?utf-8?B?N3ptWXhva0IxRi9Td0JraU84aW03cmFpemVLN2ZxRmVyQTVobHdBS1BFRnZO?=
 =?utf-8?B?YURucnhqL09UYTFFc2thdmhyTHBQZlV2T2dXSDNKN2hyc2Z3c1FZbmpOdU1o?=
 =?utf-8?B?aE5YSjVoRitJbmxIN3VqbjdUOS9TVFp0NDF3U3R0a3V6YVlSRVlNRG02Vmxz?=
 =?utf-8?B?TFBHZk5RRFhwcmJLQjdORi9uaXlLcXdsSXF3ZEVFcDNMWkdkdXp1Ry8yc3Bi?=
 =?utf-8?B?SGVEeXJKcFZPZklEMkJxT1hhbk5Gc2VJQW9Uek9GTExLbUhHRnRrVnlwV1Fo?=
 =?utf-8?B?N2VkaDhCaUVqSEFqMTJTWDhoU20vRHJlTCtNTjZTOThOek13TVN1R0VPekh5?=
 =?utf-8?B?a3p3V09wTXkvT0xxMlJIR01SU2FLM2hUM3VWTGF6TXpmRFBVTjVUN1phekIw?=
 =?utf-8?B?dDZwVDV3RjJldlZlY1Fwemw3ZzVOU1E5aENZb1BpajA2cHFxZWtCcXlvT29h?=
 =?utf-8?B?UzlMc1Zydm8venI3aEtDNWpPK3FCdGVnRkNYL01nSkxOcWZjTjhML2VSU20v?=
 =?utf-8?B?NkUrQldtOUhMVC9aNWJHV28rSGVRL2l4SjA3eDJYbkxPSzlkK084MzNFRlJV?=
 =?utf-8?B?WWZVSUFkeXRHczU0TkxGNzl5NnFWd1lXYnMzSXlTSWcxSUd3NmZ3V0RJTHJ4?=
 =?utf-8?B?cGYxR1VmNHdqN2VHc3kxVGtTdzA0ZS8zalJwVENWaXdTVkE0b1l5WUZGc3NY?=
 =?utf-8?B?UzdCYkN0NkZuQkpoK3E2b0thR0FWMVFnQXp5OTlXT1g1Y0V1WlJaa2JEQUMw?=
 =?utf-8?B?bnlpQ1RTcDB2ODYzczBlZFdMSndGVjM2dHFybW0yVnZmVUg5anNDbDNVUjlX?=
 =?utf-8?B?Nlk0SzZZMTBBdHBDeDBxbkYwYVMxY3ZXaExSY3FSR2tMRy8rWjU3UlUwR0R5?=
 =?utf-8?B?eUZmZThEZVJ3ajRjUXA3d0lPL0xUN1JiV0FhbzN5Z3FIR3BIWFFEMWxTOEZj?=
 =?utf-8?B?OWFpN3Rva3ZFUFcyakhYTG40WnNISStOc2UyWGtZK3BpcDc0MEpmNU05c3Vn?=
 =?utf-8?B?RWZPakFKWmFGd2lmeFVFdkRGT0ZEdnIwcTM0QkI4UUdMOVljQ3JDNFhDVmVu?=
 =?utf-8?B?RXJhV2xCWHptSDk4eFpTYVFycklxQUFMQjBmTXhwQnREQ0hjQXJDOWZvbEZ4?=
 =?utf-8?B?Zy9oVlQ0MEJOT3FxbW5ocmk1dS92ZmhRSUZRWnBBWnhsdldDdWFrTTZtcmNX?=
 =?utf-8?B?dFZJMHhvRElBeHBhY04zZFdqQ3BRd3p6SFV3ejd0TmtwWlRheExORzBvZStC?=
 =?utf-8?B?UVZtanlUaWlUYTJmUzMxaGlxTjd1TG94TndrQnRWL2I0ZmF1OEtNL2ZMN1VM?=
 =?utf-8?Q?efYx454KL0mF8am5i8Wj9c4KwU0AiywPFCRyE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek5ETG1iZzRKTDJRVE1iUmV2ZGlzMkFUdW84dUkzb0p6UjRTZUJxSjRDa2dx?=
 =?utf-8?B?czZpcG54aVdKVGhvcW1tL2REZHJSck5GV2g4dllCWVB1WnN0eCtrRmhPK3Fm?=
 =?utf-8?B?WENkSDBpM2pLdXpyR0pqbVRicUE5cE1kQ09ab3dwVm5BRUZvL2E2aTdqQTJJ?=
 =?utf-8?B?SDBzRzJ0WFE5bzh1ZWRqbVFlVGhVNEgxZldYR0YvWWh2YXRyaU9CV3JKb25h?=
 =?utf-8?B?WEhIRE1HQlRTU0sxSnVLTUtQOXdTS01aOU1sSVQ3NE1Nc3d6YzlKbkxPMXJF?=
 =?utf-8?B?bmtKTjUvbjlVWmRXSXZ5aGRLdjRBcHEwOVNxbG9OeHFnZjhlRVpmMFBDcjVo?=
 =?utf-8?B?SU83VTBDMERVVWhhSkZlMkJpVkNDUXhKRjJoQ2h6d0k1RGNSNEtmSFdBTThL?=
 =?utf-8?B?aU8vZUw2NXdiRzY0NzNKZUtuZER4NnJ0cEs2RFpaNlNYWFgyc3lteHVacVJr?=
 =?utf-8?B?SE9rQ3JNdVZjbkc1V3orTmF2NGxYWVA1WDk4enplUC95Q2xURXZ2QkZmUkF3?=
 =?utf-8?B?NTUydkZwNzBsaTRYMi9NVkpTZ2thZGtzUzdFV1JzdmJGaUZmKzhUM2lMeTkz?=
 =?utf-8?B?bmZBM3Q1ZVZQcHpjVzJ4SUJldGYwaHBZQmRtMUhsd2ZvY3dDMVRnMzdJRFVM?=
 =?utf-8?B?akVHVkFOeUtyOXA5a3BQUlp0UVpVWW5GRzFmRHlPMCsramI4MXQ4UnVRSkRz?=
 =?utf-8?B?Q3ZWamY1UWtnYXNmZ1FVaU9qM1h1SDBZRkZQWnYzdHpRN1I2bXowaFlJeGNN?=
 =?utf-8?B?QXNRN09jZVNydncvRDUrLy9xMEtKU2Y1ZmErKytMQ2VXa1hUVExyem1nNURQ?=
 =?utf-8?B?V3IxVytGbVZrR0dwbmc0aERRbFlocDZTNEJwL05BdkI4Sm9xYlpBZ21vSVRT?=
 =?utf-8?B?Zjg3RmJtSmlMNjFrV2tRUnluWXBUQ01YVFFWa2hSOTd5QmYzakNXRTVCS3Yx?=
 =?utf-8?B?dVZOdzBZZGR0NnQrUWYzaWhtZWRwcVJ0R3JmK05GZG1STFRTZ1pNVFBKemdn?=
 =?utf-8?B?RW52UVJ6RzhzQXR2Ry9Semc1NnNuRHRpYW0rTGVIWUVUWS9IdXBmRVh6bkNr?=
 =?utf-8?B?ZHlNNVdzTUJmSXhPei82L3dwL1k4YVFXTkJ4WDNDZDlBOE9PZTZGVytmYTY1?=
 =?utf-8?B?ckVQUFBQR291eEpBU0grTlhMU0VFV01ldC83cHBIVGR5ak5vY1FNTHM5WFFk?=
 =?utf-8?B?U3hIMTlCOStNei9SaThDTmRJcXA5VlNXVVI3R054RmNtZ0p6LzFzUmVBeUVO?=
 =?utf-8?B?WlRDTUkzWXp6ZlJWeThLSnZPeVpiM0hqMmtKZSs1dGRsdmpsRS9TcjA2cWlM?=
 =?utf-8?B?VDUrNGxmM1ErK0gzeVRnZ1pyR0F1cWFPOWZwcG9UWVN1M3BSMWRQOEdkOWww?=
 =?utf-8?B?S0hGVjR5R3JlaWVISW1FZW82Z1JjOHp6U0RQV1crZTBic3JoZk5aSzdob0Y1?=
 =?utf-8?B?RnEzcU5LMllZdS8rQ2FsY3U1M2NDcTE4RDlsT1ZSUisyRDJPaHltRmdhZS9M?=
 =?utf-8?B?WDVEYlNpRE5RVEhuTVhKeU1tTnpyQndJWXJjakhjbGUwMTBkcFdVNTBia0Rw?=
 =?utf-8?B?YVFTSE9hc1BMV0N4aEQ0Yk1TWWtTcmpmV2hyU3l1QmphaWRIME1TaTdMbGRv?=
 =?utf-8?B?Yi9oYzdReEZZSVQ2bXNtZlhKQll1cWZEckhwL2M1Vk1JejdhQVQzOGVETmNX?=
 =?utf-8?B?NkZGWG9XOWhXdGZicnZGbktMTmtPYmNYUExxdEtGM3R4SnQyckJFQ2p2N1ZX?=
 =?utf-8?B?OXZoY0xER0tISEpieXFlNjRZTitKei9teXlCR3c2L0p4anFKUm12TXhFVklT?=
 =?utf-8?B?d21RSVBlK3ovanBWZDl3NnRIY1VnaTV6MnhVaW1hZkJ1ejhjZE8rbVlmYVAw?=
 =?utf-8?B?UnY2WVFuZlFNSk8rUDlTVElXbEhtVi9kam85ekljaitxaTBuTmlFUndqdWxl?=
 =?utf-8?B?NE93TU9vVVdDNVo3VjhDZWlDenp2OWNUdXpQZDg3aGhvSW0wQnpvSGlLc0ZC?=
 =?utf-8?B?VHQyUEJadkROaDhTQ2ZvMkEyZEtNeFVwbDFqNldJM01RaVlwQS95K1lkeHly?=
 =?utf-8?B?L0JhU2E3KytUYmk3WHY3ZFpTeDdNY0NPS2ZDNEx4dnR6YnRUclF2UEJxN0FJ?=
 =?utf-8?Q?Hwik=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59608a-d8ff-405a-a6b1-08dcee4d4d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:44:56.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89qRz3Ik5h+x5fcdMqgvlaNM3OTsiavL39ZiGXnaknwHd2anTxG/wlKd78eTXJTt5Bq149kp/r3x9EJIWPMdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwNC8xM10gbmV0OiBmZWM6IHJlbmFtZSBzdHJ1Y3QgZmVjX2Rl
dmluZm8NCj4gZmVjX2lteDZ4X2luZm8gLT4gZmVjX2lteDZzeF9pbmZvDQo+IA0KPiBJbiBkYTcy
MjE4NmY2NTQgKCJuZXQ6IGZlYzogc2V0IEdQUiBiaXQgb24gc3VzcGVuZCBieSBEVA0KPiBjb25m
aWd1cmF0aW9uLiIpIHRoZSBwbGF0Zm9ybV9kZXZpY2VfaWQgZmVjX2RldnR5cGU6OmRyaXZlcl9k
YXRhIHdhcw0KPiBjb252ZXJ0ZWQgZnJvbSBob2xkaW5nIHRoZSBxdWlya3MgdG8gYSBwb2ludGlu
ZyB0byBzdHJ1Y3QgZmVjX2RldmluZm8uDQo+IA0KPiBUaGUgc3RydWN0IGZlY19kZXZpbmZvIGhv
bGRpbmcgdGhlIGluZm9ybWF0aW9uIGZvciB0aGUgaS5NWDZTWCB3YXMNCj4gbmFtZWQgZmVjX2lt
eDZ4X2luZm8uDQo+IA0KPiBUbyBhbGlnbiB0aGUgbmFtZSBvZiB0aGUgc3RydWN0IHdpdGggdGhl
IFNvQydzIG5hbWUsIHJlbmFtZSBzdHJ1Y3QNCj4gZmVjX2RldmluZm8gZmVjX2lteDZ4X2luZm8g
dG8gc3RydWN0IGZlY19kZXZpbmZvIGZlY19pbXg2c3hfaW5mby4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCA0ICsrLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRleA0KPiAxYjU1MDQ3
YzAyMzdjYmVhNGU0NGE1YTgzMzVhZjVjMTFlMjMyNWY4Li5jNTcwMzljYzgzMjI4ZGNkOTgwYThm
ZA0KPiBiYzE4Y2QzZWFiMmRmZTFhNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTEzMSw3ICsxMzEsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGZlY19kZXZpbmZvIGZlY19tdmY2MDBfaW5mbyA9IHsNCj4gIAkJICBGRUNfUVVJUktfSEFT
X01ESU9fQzQ1LA0KPiAgfTsNCj4gDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGZlY19kZXZpbmZv
IGZlY19pbXg2eF9pbmZvID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmZWNfZGV2aW5mbyBm
ZWNfaW14NnN4X2luZm8gPSB7DQo+ICAJLnF1aXJrcyA9IEZFQ19RVUlSS19FTkVUX01BQyB8IEZF
Q19RVUlSS19IQVNfR0JJVCB8DQo+ICAJCSAgRkVDX1FVSVJLX0hBU19CVUZERVNDX0VYIHwgRkVD
X1FVSVJLX0hBU19DU1VNIHwNCj4gIAkJICBGRUNfUVVJUktfSEFTX1ZMQU4gfCBGRUNfUVVJUktf
SEFTX0FWQiB8DQo+IEBAIC0xOTYsNyArMTk2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgZmVjX2R0X2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDI4
LWZlYyIsIC5kYXRhID0gJmZlY19pbXgyOF9pbmZvLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDZxLWZlYyIsIC5kYXRhID0gJmZlY19pbXg2cV9pbmZvLCB9LA0KPiAgCXsgLmNvbXBh
dGlibGUgPSAiZnNsLG12ZjYwMC1mZWMiLCAuZGF0YSA9ICZmZWNfbXZmNjAwX2luZm8sIH0sDQo+
IC0JeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LWZlYyIsIC5kYXRhID0gJmZlY19pbXg2eF9p
bmZvLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1mZWMiLCAuZGF0YSA9ICZm
ZWNfaW14NnN4X2luZm8sIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnVsLWZlYyIs
IC5kYXRhID0gJmZlY19pbXg2dWxfaW5mbywgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg4bXEtZmVjIiwgLmRhdGEgPSAmZmVjX2lteDhtcV9pbmZvLCB9LA0KPiAgCXsgLmNvbXBhdGli
bGUgPSAiZnNsLGlteDhxbS1mZWMiLCAuZGF0YSA9ICZmZWNfaW14OHFtX2luZm8sIH0sDQo+IA0K
PiAtLQ0KPiAyLjQ1LjINCj4gDQoNClRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KDQo=

