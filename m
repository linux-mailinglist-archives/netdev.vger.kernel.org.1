Return-Path: <netdev+bounces-136357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D580D9A17F4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4790328755F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC911C695;
	Thu, 17 Oct 2024 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YNAnLBao"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181C6FB9;
	Thu, 17 Oct 2024 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129057; cv=fail; b=qjrNSszrBpoVnwr5L5zeQNuayDM4cUDmBS7GfoytFlom/vVGzv9Jc3LAkmfICymo0pZcf2cNIk9UkRbfe08NjdyIiPET1zSM+vLNKKLdBVAQ8DCqlr8QL11+X/i5v1eBOqzozK3ZkO+oY4Vm2LOyAoFW3VqOir/mSKYEQfMOStI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129057; c=relaxed/simple;
	bh=zjTFu6pd+vDmp6CZcZrefGhGEuuL6a0pTaK/bby7SdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0COudgja9P0NZ28n/tULClmy62CmOTBop3lh5NVi6PisXUfwb3S6tokXrjRHrgP/kOohJYcC8KIKJQKIJv/afNsA9y+w/DoQZ6HXceiXYVjgBkRoLayZmxoR9iYh7qDSzq9eUeoESUSXIMt1XhM9A88+8LrfGuSTkqdSUZ1008=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YNAnLBao; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfiYs656y0V1aJyqB7KWAFLNBJa+uYc4RPZMKU+AZggRXpS7TIn21VQ3rq8M+FIwjLm1E9D7gPs1Lj9rUt5No+60RX9e4f88fjUrBLiXCHcpydwHwjDQnoanJSijDFulBNTuAwXKYC81DtkH4XvlcS2Ru97js9ASVokr6fDtLJgFvU2zbhdeHlm0eBYOUsSW1SvVliQa8SyBmc79+PKLAiZ6V5DSlfaDrb2xsMPWfglWfJKQwu4yvJuApGCQU52uTx2MrliclBZayK5qDM0Ow0e6YD4BbpKBab724zSHdwIFPDjozodok4wbiFu8cotplRHhTsqQDLsTpfB3ZkMe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjTFu6pd+vDmp6CZcZrefGhGEuuL6a0pTaK/bby7SdQ=;
 b=WaaHxd7o3bA1WHavxunTmlwiWY00E5zubzHYDXMplSuUWkXDj2rOceR0wVxaS8CQp+UWEJMhSnqU39bAYB8ERC1mhmww2an/LFuNppFYJp2RQe68xO9wLemv9fgEax6W1vLHwNax+JjJVWJN02SPGaFRDFI+TFDT3eiHx6wiMgOjA8DWzioSAQ23t5d69WiBHCNNLOR10nZ9tZ54l4qtKnNwSt6Qvf9Vhh8vDwmPWtMp9RZMs6wCFPOfchgFbRZWGHZrKV6ai9FXVgSzQxm1m/FidD3+J1twYNQI7x7xtqeURfancT/Rkvv3uRfYlk1AegPIf1+tiQAZouReo5ovQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjTFu6pd+vDmp6CZcZrefGhGEuuL6a0pTaK/bby7SdQ=;
 b=YNAnLBaoLp3yjSgSndhdFrWoNRBZRrN7RfJC9pqXkB2k/Bi/jzHYRQcjVbrw7av+Or2Ik2fnb98R/WVRkc0Ic7AYHAKt8wFt/VVXiyNXjWPHwdVbTcMRW2feUjK7BMCk5K6lklMaosF9MmJ0t8QZe1QcDuR/o49bn+9o7maqbKaWFRAgKUX1/xzC20JuaWXdnZ6xVd6qgmvP20wcSnlYrU+HlmWNecHWBSQ+BcifZ4NcmoKag8UWjsKEicHyCaNNWYg9By5W5HQp4n3dTRI1dNz2J/GB9QzCjhAgZzgcg/bEGQgG1tHu5qlkOdpJrkl8+0cfI7ZOdCKXjRqB/rE7HA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 01:37:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 01:37:29 +0000
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
Subject: RE: [PATCH net-next 02/13] net: fec: struct fec_enet_private: remove
 obsolete comment
Thread-Topic: [PATCH net-next 02/13] net: fec: struct fec_enet_private: remove
 obsolete comment
Thread-Index: AQHbIBWxAJULb9ZcLk6aNA1iisb/wbKKKgGg
Date: Thu, 17 Oct 2024 01:37:29 +0000
Message-ID:
 <PAXPR04MB851039F2D74D33F9F30C143C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-2-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-2-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10694:EE_
x-ms-office365-filtering-correlation-id: 608f9268-0c5e-42e3-fe4f-08dcee4c4372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm5BL0kxbExkYWExU3liMDZsbVVhSGwzZjRIekU0c2tCUCtpc1grUjZZQVIv?=
 =?utf-8?B?d2JyRzVYcGJGREtQRHpxc0pGQjgzc0JBaUpUVktKbk5zMWl6K2g5eEhnRmhZ?=
 =?utf-8?B?VDdiV2VvSm1vS3lUeldxRExpa1V5a2N6emt5SnNVWG84T2dhbDd6dFVyYmd4?=
 =?utf-8?B?V2xYVjlzbzlRTjFicWUrejlJblY5MlpEazgrMFByVEN5aEpjUVhySStEN3o2?=
 =?utf-8?B?b3BsbnBFREtNWGRCSXAyNFdIY1BBNlZqb2ViMWptVFR2K0Y5OVA1SmprMSsz?=
 =?utf-8?B?YjVNWDBLMnhNNDFTMUxOc2Q0aWRWTVFIa0JtOXE5ajlGK3FKOGxrL25xN3dp?=
 =?utf-8?B?dENHdHlJcEdyRENrMmJFNC8zck5vT3hCZHNCdnZmY0huWWliNEtWSWpwMy9r?=
 =?utf-8?B?aE8vYlQycHdpdVlDSnZWMXBqZTNLZ01PYTRLd0puQTdVS0hrYkozbmVuYWMw?=
 =?utf-8?B?eTg0Y2tCVUdNV0tNRXhzTkRYaGhRc0d3VnJDaTZmVU9lc1pOWFRpdEh2ZjFL?=
 =?utf-8?B?U09hekRYaWNmSmVWSnhXREQvb1ZnZHNDUXZtS1VPNUY4bThPaUUrOFFGVDZK?=
 =?utf-8?B?aWUxUVcrZHlDelhTSEtUWjNmTnVHOFQ1NGNhYzVVYW9rWDJva2RoS3hBelo0?=
 =?utf-8?B?d3UvNDNyb3JMdEhXeDh5L2o2enBYQWxZMldiYVdnZlJxRnpWOGNTeDg3RUlX?=
 =?utf-8?B?SWhieWNXM25QZVhJL0V1b3dKRXdCWXo3RjNrMFdVaUFKSS9pSjAybHR1Ynh1?=
 =?utf-8?B?dDNqekkwRERxTlNHWHEyLytTbGVrb0dEbjZBSGhGUkhzWUpMTFh3ZUlQM0h2?=
 =?utf-8?B?b3JGUlY5ekxDd3phNUdLNytPTzJrMXRqZ3ExdCtqYWZaTkpMYTdDdWlkbHRn?=
 =?utf-8?B?QXM1aDZRWk9talA0Z0RCVDYxRjJRME5ZNG8xU2xmLzhIVVl0NkVmMTVkdFp5?=
 =?utf-8?B?MEVlZkpsRTdCUUEvNXhES2g2dmVPQ1oxUEdva1dySERMMkg2UTN3ZHhQSFpL?=
 =?utf-8?B?OG9WL1ZCZkNmVGtUREJCSk1pc2RvbkpCMjlKQ0w2MGJBRzg0VGV2ZmEzT1Rt?=
 =?utf-8?B?SlFtajZ1dnd5V005NTZsOXFZaXloc1RHdGhkd2NpR05XUUx6Tkt1SDlMYlB1?=
 =?utf-8?B?UXpPYlVWWlJNMzE2UmI1dVpwS2Q0ZENrakFkVnBoaFQ1Z1BydkZoVE9MQyt5?=
 =?utf-8?B?M1FMdHZNdUVaVURydzNNTmYvNlNNZnFtWnNxcFFBVmpnSG9qMnVQRVc5enFI?=
 =?utf-8?B?OTN3UmZEQlFCWkVNN0RvM2h6aUVpdDBqVW80VStMVndKR2oyNGdrWlQrV25u?=
 =?utf-8?B?MkR3OEYyYnBwSHI4TG1tRnpGM3NwRyszSngxY3J2emV5a2xVOHFDcHJ3eXR2?=
 =?utf-8?B?bG15eXNtSERhNnViZ2ZiYXJhNU03TDE2RXBKWHpHUVY4elRqZ0JmcXYzOWRM?=
 =?utf-8?B?Qlg4VFVYdkNacStWazQ3c3lhaUoydVNGWTZWOU1FUThDd3gxZXdPSlVVY0Fu?=
 =?utf-8?B?dVVvMFd4ejRBZnovMGVwMFI1Z2o2V3FSZkovRUtoanloeXlMbEtJWVNlb1Ux?=
 =?utf-8?B?QXkyOG0wZDRWaUduR1pST0dhdmdrVGtoUnNYaDlvWmpkYWJ2TFFpTjdXNU9P?=
 =?utf-8?B?ZVdjcGgxSEx6MThVeTg0T1MxNUpjQW14N1NYb0lrN29GdTZMYTY2aVNwTUFJ?=
 =?utf-8?B?ZWd3KzYwM3NXSnJRUVRYdlZpU2ZxbmlOS3drZ0lHcmx1S3gvTGNvelBwQ2p5?=
 =?utf-8?B?a0RiR2RBOG1HZXRMMG5mbU1xYTZGMlNrSHhFS1NHandSNzJTUjMrWGgzU0tp?=
 =?utf-8?Q?NZVbOTfYrGaPdVouJEVHBAKF/64ieCLMI3Gb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmRXWUNYWGVONlFDcGgrTXBGcDh0UTBjck1oalIxb1lMZmp4Z21KYjBtdms4?=
 =?utf-8?B?T2hNYWpEdkE5S3NOUnMxajRuQmtVRklVeGxQeVdoZCtCakhJUWxIWUtod2tv?=
 =?utf-8?B?TGxIaXh6OHRYYkF0dlEyejNVUTNFdXRSN0ZiSzBZZDZINnBoZzd3aVZiejVK?=
 =?utf-8?B?SkEyeE1veFpYRUFPdW9zd0d0eGN2dkZDSVBUVllZT1ZYQmx3Q3FBdVVSOWQz?=
 =?utf-8?B?MzhaWUxXR3FIT09OWEFJSTZsdmlhZXZGNkJyZ0lHN3o4RGtHdHN0NlNBTDk5?=
 =?utf-8?B?Z2p1SStZZFpnVjE2VnpPVHBFSUxmRGpyK0FHanRrRCtaR1VLN1hqbWZySVZj?=
 =?utf-8?B?UnBpUkczRi9Tb3Q2YVRHTUZtYWdsOGkzRWpmRjVNbGxxVmprN3BxRXRoMisr?=
 =?utf-8?B?enpvVFJqdkdQdU4zMk9ldDNTUFVYZzNhN0J3SlB0eVVGZXhFYjMvNk8wcXZD?=
 =?utf-8?B?NnkxcUtFcnBoc0tYejM1NVhjWlZIQ0Zzd0p4NjhraTZWY1hab01ESTNiOWJD?=
 =?utf-8?B?M093WjI4UHVPMzlNd2pmRVkraFpCOC9PZCtieHpRS2FUTERoVWYzY2xSNlBy?=
 =?utf-8?B?QlVMcVdMcU9GWUhYMnViV2crQS9UN09IQmlvUUd1SnMvbEJqMmRCTjhLUThk?=
 =?utf-8?B?L0pNVjNJZ01FbXZTMGZoMmtJSDZNbUtaZUI2NGxZdTF5Qzg5MTBGRmZuaGI0?=
 =?utf-8?B?VFluMmd0SFV2NUZsY2p1QkhUOGcrVVhiZHl5R1hMNlpZZkgyTytLUkRxeTk1?=
 =?utf-8?B?N21oYTNSb2NhZzRGM3QxVkNtNmVQb1hxOHhTekpHaExXRmRCdUxIK1g5R3lS?=
 =?utf-8?B?anZ1czlGdXdMVUl4bkdETTBpcnhEY0Y2cURtYW93cEdTZzJ1eHhhdUg4ZCs5?=
 =?utf-8?B?UnRwU1Y1RUhMNnhPczBnbWRzNXZWbElhQmhwaFBDQ3lVVmZtTURDeGU4SFcv?=
 =?utf-8?B?Y3hFVDlHWHd6cmJSOU0vbkhNY2hLSXNFN1VHWEUyVG94cTNKMzdtVTQ3REIw?=
 =?utf-8?B?emsxbUovWnlERmdYNnlwUlJ5ckV4V2tWaFQrSTlxSk5WRThtcFpRYWFKWk1H?=
 =?utf-8?B?d2RFY3M3YkxTbXRvdk44bVR2eHoreGpJYStHQlFxQmJ1ZFpmczY2WTFSYllF?=
 =?utf-8?B?NG00czkxRGdsT0lCNzZCWVlJd3lJeWNud25IZnRjYXRHbXQzeXp0U2FZUGJU?=
 =?utf-8?B?R0hRd3VqTjluUy9JY0pMeDYzWStCL1dURVN3STNwdFE3N2NEUytSNXBHR01K?=
 =?utf-8?B?YlY4eHJtVTJtUGhmL29XTVMvZDJ1R25sSVFFSk1rbkdOSGZ1dVJrbTU0L2kz?=
 =?utf-8?B?S1J6RmJlVVhDeXFtSm1CODJ0MER4TmZrVHYxdW5CeHdRZDRZNHQ0L0d4Nngz?=
 =?utf-8?B?ZzJjd2xOQUtqc3pYekpEdW04cXczQ2ZGay9pbStqaGtycGJkRFNkSHdDSU04?=
 =?utf-8?B?UmJHTWM5NVRtb0tBMlVJU2hRVlFmK0d1Y3BRdlNpZW1JQ3ZrSU13VGVUWjFp?=
 =?utf-8?B?TmdHUUZqTlViMGpJS2k3TGRRL2o5TDVlNHRoazVQTzdOdnRkcXlPQURnZnZp?=
 =?utf-8?B?TFB0SXo1cndENC9vTVRteU14d1lEY0kvbXZva2VRMjhOcTVJb1Z4Yis1TEY5?=
 =?utf-8?B?eHJ2L0Urc0ExOVZuMjRQUmRGUmtqUVg3OHVqUEp2cUh5aTVnVHdDTGp5eGw3?=
 =?utf-8?B?TTVxRXNjWlFmMDJTUjVTNkNxaEk1aHNwdlFMMlFZNGFEOUhPUTZLWkpwdy9W?=
 =?utf-8?B?UWh5UDdjVGEwVEtnZkZ3Vy82Q3IzejhEMEM0VEJvOHNPWTB4ZW8zUzRCelhE?=
 =?utf-8?B?VjZkNExUZW1qem5YMmtyTVpJdUZzM3B3Y01wbnY5NXROYi9oTmgrbmxPdjRJ?=
 =?utf-8?B?Q0JqMis4aG1SYkMxelJaQ21PWnd3UXhZZDVRWHk0NEUzS3o0WjlkdXJNbHRw?=
 =?utf-8?B?Q2tSeEpaUWFnMzVDYVdML0hlNTViamFKY2VseHR0dk9IdXFsR2dPNHZPOXlM?=
 =?utf-8?B?elE0MGR0UkJaTGhFYzZSMkozSHd0azNYWnlaWmZZQWJYWFpSYmZxdzhYd1Fr?=
 =?utf-8?B?eStBYjdOcWtKUkZyRWVWWXA4WUFQR1JNQ1oydFNtVEtHN3ppM0xNUisyT3Zr?=
 =?utf-8?Q?/YzY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f9268-0c5e-42e3-fe4f-08dcee4c4372
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:37:29.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eL9hP1105TCvpFtRz5s5tU4nVISjVxrGes1PSeTn0leJroyjJUNJ9TBVM3ZgQiv6Qdlt8aQQ721mfwMa99a3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694

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
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwMi8xM10gbmV0OiBmZWM6IHN0cnVjdCBmZWNfZW5ldF9wcml2
YXRlOiByZW1vdmUNCj4gb2Jzb2xldGUgY29tbWVudA0KPiANCj4gSW4gY29tbWl0IDRkNDk0Y2Rj
OTJiMyAoIm5ldDogZmVjOiBjaGFuZ2UgZGF0YSBzdHJ1Y3R1cmUgdG8gc3VwcG9ydA0KPiBtdWx0
aXF1ZXVlIikgdGhlIGRhdGEgc3RydWN0dXJlcyB3ZXJlIGNoYW5nZWQsIHNvIHRoYXQgdGhlIGNv
bW1lbnQNCj4gYWJvdXQgdGhlIHNlbnQtaW4tcGxhY2Ugc2tiIGRvZXNuJ3QgYXBwbHkgYW55IG1v
cmUuIFJlbW92ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxt
a2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlYy5oIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBpbmRleA0KPiA3N2MyYTA4ZDIz
NTQyYWNjZGI4NWIzN2E2Zjg2ODQ3ZDllYjU2YTdhLi5lNTVjN2NjYWQyZWMzOWE5ZjM0OTIxMw0K
PiA1Njc1ZDQ4MGEyMmY3MDMyZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2ZlYy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWMuaA0KPiBAQCAtNjE0LDcgKzYxNCw2IEBAIHN0cnVjdCBmZWNfZW5ldF9wcml2YXRlIHsNCj4g
IAl1bnNpZ25lZCBpbnQgbnVtX3R4X3F1ZXVlczsNCj4gIAl1bnNpZ25lZCBpbnQgbnVtX3J4X3F1
ZXVlczsNCj4gDQo+IC0JLyogVGhlIHNhdmVkIGFkZHJlc3Mgb2YgYSBzZW50LWluLXBsYWNlIHBh
Y2tldC9idWZmZXIsIGZvciBza2ZyZWUoKS4gKi8NCj4gIAlzdHJ1Y3QgZmVjX2VuZXRfcHJpdl90
eF9xICp0eF9xdWV1ZVtGRUNfRU5FVF9NQVhfVFhfUVNdOw0KPiAgCXN0cnVjdCBmZWNfZW5ldF9w
cml2X3J4X3EgKnJ4X3F1ZXVlW0ZFQ19FTkVUX01BWF9SWF9RU107DQo+IA0KPiANCj4gLS0NCj4g
Mi40NS4yDQo+IA0KDQpUaGFua3MuDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdA
bnhwLmNvbT4NCg0K

