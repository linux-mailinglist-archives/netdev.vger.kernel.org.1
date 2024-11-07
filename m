Return-Path: <netdev+bounces-142721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040F9C0193
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7DCB22C2F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFC1E25F6;
	Thu,  7 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/CHpO/o"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461518785B;
	Thu,  7 Nov 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973170; cv=fail; b=LFVy/2qYvAo7oJe8hFocE7263UtnsqwbJ63ZaJN+/0mHglS7/RqACyLWVRK8plyTUBz1BqxxJTnXwd/2KW4TE3fh/qmkXMEMbsySeS2E6lF4L6qJdtIi2ovUt+o0PnkgGFOzeowXWpry4Y9OHucACOpPjj/XTYO8NzPubv3EaP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973170; c=relaxed/simple;
	bh=FnG6/pVK/n/95Lu2XJL6diYlGzYGuDdqINfwh37hj24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uY6B2P0MuLW1mJP2KV7tZvHX05PFs/OTNYDf3L+IfYYclbEWoNwD5Khj8m50zznA6wnZNeojHJkdnj4kBFPF25nx+v4t4gS4zClpFTWGGizvPhH/QBAmCgE7Pv+Vt3JwjfIMfnA37pF8OaLEVgalsLvwQw9jNxv6uf5r5cr7dQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V/CHpO/o; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYFxFGi2No2SK4kjCgfIUq2jESGnHvuSrZRpU9eTigWhAcJr53Y7IOxHTlqcJoykgD/11PqugRk/H3nUNes193EbqPsFJ5K9c4AJNuO//HpR4mVN9n0E9sEANX3c38rqGgTNCu0rf6RPZmar88czAiCPf4WARPdzYHBs4KdnwIOQd0d7AZc5qwjXBb8GurKFixdk2/htdHVZ/0/NjWTSw7S5Ca/qrNUIj2x7EZeB7KWAKOhZYGXGZ3CODWUXelo+xjqFLn/o0sb4CDKWhUJ7/L7ADY6fjRyvqOqCCJ97zrUrliS54YThv2kW3+xg3rRtmyW6QEelu7Ju3ck7GVPjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnG6/pVK/n/95Lu2XJL6diYlGzYGuDdqINfwh37hj24=;
 b=DB4+EJ0x6kGkYna8e6y26ltZJF8/uX1zIKYn5vI1Bxh5Jv/Tjlcz+0cUoLQYIPUycHb6hn4rXrXudI8yOTzLAgWJFKKGY4fRfDc0ndN3ZYRQCYJebJt7TypThNRnrPYx1zQUYBQ6d3hZ4ZoIlkwuVCd5DXQNBpUA5nq6sC3kObiAs32lC10jkMoAeezgij/YEfF6Cr5S0cqcVgYgwjo6zWxlfBAXKDt4FFSeUh70uh1zxCS6ljJ6HXvuwaXq1xGriNtKLWY3htNgD3GDTrgqM8LnC3r0Tj4nwOGEvcmshVIDoyvoCL/V2g7yLwRnxBfLk0TKPr8ovjF9BEt6wnmhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnG6/pVK/n/95Lu2XJL6diYlGzYGuDdqINfwh37hj24=;
 b=V/CHpO/ouW+Wj2Ry5r8saENlRhdOa56ePSOl29IlaBEReQ3RDG8cqLxSDkOMQDQR4ijbpjoZ5D6tzhj/1LRPqBbXeF9qPCGPhd1P9kbPWcc+MmDuM65FunYJawNNheQvcwBQD5qr0iKfbDSUdLFDnJY3DTKYShnqYmvCey+cABq8LAFjhTSOJNbkUF8e/WZv06uPHpGitXmJ/tWCRhwDxdcnx0cy+UYwvwq6rIC+DZQMH3i0fqkT9PLWPvnxsAbj5HHFZ8ZOi91Xa6lJaAFvxyRT/S6ryZ662HcX1YrQGNESFsps5hHWFcIpIb1HxuQrt4Hi1fLJR3QEDBlGgcZNCQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 09:52:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 09:52:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Hariprasad Kelam <hkelam@marvell.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 0/5] Add more feautues for ENETC v4 - round 1
Thread-Topic: [PATCH net-next 0/5] Add more feautues for ENETC v4 - round 1
Thread-Index: AQHbMMinebyVteVtV0SHmkTmBrQEvrKriLEAgAAJy6A=
Date: Thu, 7 Nov 2024 09:52:44 +0000
Message-ID:
 <PAXPR04MB8510B19BBCC8110A4E45C12F885C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <ZyyEbCKxjkVFXUMB@test-OptiPlex-Tower-Plus-7010>
In-Reply-To: <ZyyEbCKxjkVFXUMB@test-OptiPlex-Tower-Plus-7010>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7636:EE_
x-ms-office365-filtering-correlation-id: 7bccb212-80c6-4107-4834-08dcff11edcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MkNnMGs0UXYyTnVRK2haa1A5Zmd6cWNSVlV2NW13TmxWa3lUZzhZU2hkZjBv?=
 =?gb2312?B?eXoyQ2NvU3BTb3JxNkRJQ2J5Q1pzWGp1bWI4OGxoVGhWeGZhS2N1WFE5MlhD?=
 =?gb2312?B?Y1llbHB6dldRb25NNkM0YTRzNnJiZW1vKzVIT0hsem5INzlRRXZWOC90TnBE?=
 =?gb2312?B?czI2TlFySU1lN3JNYkxiQTdiNm9iWENNeitJZkgwbSttSk4rMWYrSFJoZGZY?=
 =?gb2312?B?WG5VMkZXT0FaVy9VZUUzOWFmdjFDN0lpZWc3VU93OHlPVng3dE5TTkI2VHVl?=
 =?gb2312?B?LzczUElFMzFoNUp0eWU2QWRWL3Z1RjZWbWVvL0pnNXJFSVJJZXhYVm9aVk4w?=
 =?gb2312?B?aEhUbEQxNTVkYTRLRkdSQjlFQmZmTUhnZXRjZGx6VEZja3J3Vnl2NHlpMFRX?=
 =?gb2312?B?M1k0b25SZksrMDB2UStVRkFheS9sUmt6M1htUTJHNGFZTExId2VoQTlHWkVl?=
 =?gb2312?B?ZGtvWGNiT0dSS21uM2hmU0ZmTkNGbER0UjhaZEkzaGFCN2lmS1NUU0lCU2Mw?=
 =?gb2312?B?YXJBd2dtdUxTbDdsZG9VVG5ZN1N1WEFiclJONTBlZ3Jta2xDVjY2Y0ZmTVpx?=
 =?gb2312?B?MUpsWHpMREVVMnBHSlYyRjRCbEJSVldkMDNiektYSUpjR0pPOFArNGxBQWk4?=
 =?gb2312?B?azZSdHk4NFNKSlRhYm5rdlZDaW0wYU5vbUdIZVc1bVNjT3lHWmRzZzh0Z2Fy?=
 =?gb2312?B?R0RnWUFoQ1Y0bkRVUDM4U0Y4Q0R1YjVVNm8yMU9iT1NMRmFScnp1ZC9tRWox?=
 =?gb2312?B?YVl5ZTNCOUM4VzcvdjFNSzJFV3NTK1dRMnZwZVMwOTJoL3lySHE3R2xKTGNw?=
 =?gb2312?B?TXRpNDFzdWpkM3Y5SUJpT3pYMGQ5elM5ZHo1V1kyWE5zczBBdm5Kb05HT3A1?=
 =?gb2312?B?cHFzT3BxZDVxeUwyT3J2a2lZVEdqUFR0K3JPSFhBK3lrcmdnUTJpaFF5VnNR?=
 =?gb2312?B?c3FOanF0cDZjdjUxMFVyejNhUVd6ZXNzN3BFOHVRcDJoWTlMVC9mUmc2eHhC?=
 =?gb2312?B?eUpjby9MM244eEhBZDVGeWxKRWFxY251MEtReHRsRGxNampVWkh2T2UrWDhl?=
 =?gb2312?B?ODdxbXhQblcrcER6NEVQUTgvN0N5K0VleXJ4OVJUd2gyWVFodlNTTGFTb085?=
 =?gb2312?B?dytkbFhzL0hUREsxbHJRVVVTWVdqdjB0dDRGZ1ZXRzlnZFl1SW9FanM2aGpp?=
 =?gb2312?B?cFZyL1lJQ2pCV0hmWTNtWXdGNGFiUG5XaW1PRzVmRmlJaEZmNEcwa2hWRVNm?=
 =?gb2312?B?d3pRZmlzMkh2ZU1ZaGtDVXVqQUZHWHpXVCttVkg0SkdraWdrbXNYR3E2alB2?=
 =?gb2312?B?dFZLSU40dTFUZlN3TUF4VVdGMFJkMU0rRkFCMXFXQjA1UENydVJTN1FvZjZj?=
 =?gb2312?B?RjdIaWFvaTBQTnl6TnRyaFA1YmJoOWljamYzZVNnMFlDWSt6SE9mRVlWZkdo?=
 =?gb2312?B?b0I2eFRJN1BCZGs2NVNvY1Y5M1EyUC9BNExXVVI2ME84MHVTdG0valE0dk91?=
 =?gb2312?B?RStnUGtRL0ppUjhJZHhOUkJCMTRiOG9lY3FhN016cTV1MzJnaCtwb3REeXZ2?=
 =?gb2312?B?V1lzRzdzRjV2UzZSM3RsWUYyY2h3YllXWmUzZ1FuVFdiaDRpRkxMakxsZnND?=
 =?gb2312?B?QWVieUhScGI2NmVEblBGQXlZekxzdUdsaVJwNkFYVXM3bDZUOUlQZi84VW1U?=
 =?gb2312?B?S0JSd0w3OWo1S3lXWXdBTERiOFNRZ1Q4Yk00ayswM1Vua2hRN1RJdEVLSlZz?=
 =?gb2312?B?NGFXYVYreDJsOHRXRnNNcysranZzZVFWbjBveWltMldqbk9YUlEzMWJsTE05?=
 =?gb2312?Q?XwVPFONvkAvh4QTCHvyQKnBrYeeznX+LzW/9c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dHozTmErdVhBbURhVk5pVi9ZNVdrOW9VNW5tOG0zYjk0WVdEWUJqWlNPUVp0?=
 =?gb2312?B?LzhuK29EYmtIcUVOVXRKUUNuY3hRdlhId2FRMkt5N0ZtT1M5UmE2aTF5NnNj?=
 =?gb2312?B?VUtrcFpCU2g0NDAvcWpaQ2xzRGIzdi84VStRcEk3T0plSjFsN05XOWo5V1pz?=
 =?gb2312?B?Q2VaMExHeUp6YmRRa0tuaU82YUFkV2pHZmhwbHV3ZTJWU280MlRWY0tyK0p4?=
 =?gb2312?B?KzlDbnRzNkZKdE5JL3dOeC9ySmh2eFZIcTZuMVpVUkVoNHNiekRtT3owMjRa?=
 =?gb2312?B?WW5vTWRQdGdlbGMvQm93UGx0bVFMSm85cHBncVZyd1l4RTdvWXYyNnF1cGZV?=
 =?gb2312?B?L084QVFLRjlJbVI1U1g2SHVoTnY1QnFCSUJYRHkvWTYrLzVJTko3a0UrN2Fp?=
 =?gb2312?B?cFNEOGdHYXFhZmpxOWt3WUlrM0srUTBJdk9RUDVYZWxjaFhNTWo1U09nby82?=
 =?gb2312?B?WGdHQ1h5dm55bzBoZkowMVBScWsrV2FhdTVkWGdOVzdPTVArOEQ3OHhHWGM3?=
 =?gb2312?B?eFZ6VEt2YmpBdkltUFAyeW9NOUJRbkwranRCa09UUUlkZDBFdUFzWmxYZ2Fw?=
 =?gb2312?B?eGUvYitVZnZVNmFHdnJzVFNYdlZkeUl3SGJ5T3JFSy9vTTBzUGJZNnNkRDZU?=
 =?gb2312?B?eUF3cUpjdy9LZFZmelFYOFNpNHJoWHJQemhuNDZqZVlFV1RuZFpHaks2VllB?=
 =?gb2312?B?S3NaM3VBMnlCRkt5cmNJV1FERDYwTDRnRDJIQm9SMnMxMElXRDhGQVlFQmIr?=
 =?gb2312?B?K1NDYjgvdWJmaEhUR2RhTjNETnVpTVBvdExibkhBTXB6QktUODMxUkFIU0ww?=
 =?gb2312?B?NmVIcGVIazFKZnlwL0tYT2hzZmptV3FtdG5oWTNpOWVVQ0dKTFA4NUwwRmF0?=
 =?gb2312?B?THVQcTRmanVTMVp4Yzd2MTNXYW9nWXNwSDBDWVRsS0ovbnkwYit3UVUwcGh1?=
 =?gb2312?B?VGZOU3FnWi9Zano3c1lHejZ2c2x4c3YzMktYSFZOKzU1bVF2bTl5c3NpYW8x?=
 =?gb2312?B?dTBoa3IxNkMvcmkwTFM0Q3VjVHZKNjVMdTMrVHVza1B5TkoxdEFUS2s5akx5?=
 =?gb2312?B?eTQxbEdiMnNNMlBwNHRzd2tlMVBIRVliRWhzb2lVYlpyTVNqUHozTjYzeHk5?=
 =?gb2312?B?TkcvNXZBNFdJckRyeGNwb3o1OG9ybnM0SHVDVFg4L3BZQWtlVUpsTklZZW52?=
 =?gb2312?B?MjU3L1RkUEFXb3lrdnZISk9FM3lmMDF0bU41RGFGTm5VRlFpckF4SnBuMjJl?=
 =?gb2312?B?UzNYNHk3WkVuUm9NcEhSS2YvdjBXdnVyV0RuclN1YStsQVNtdTNldWZTZ1FK?=
 =?gb2312?B?VkNLQ2lVRUNWZW51ZEFaTi83b21QWkpvQmZsNmFZSXUyazY4NW9MOUNkRmdj?=
 =?gb2312?B?SVEralp3TGpreTZ3NFR3YVQzcWpTMDR4SEU1TW84V085R3dsdW9DQ2hPRTVC?=
 =?gb2312?B?OXRxeXViRnpLQnEwNFRVK1ludkdWOTdvRkVaMDYyNnhjelNydmg3Qjg3cUlS?=
 =?gb2312?B?bWlPWXR5ZTNSdlJYMllSbi9yWVArZEQvSHRrUWhLRmd0aEwrM3RKTmV0Q1RP?=
 =?gb2312?B?WWF2ck1ZRW9nL1pNSFZMMHA5cDhGam1uRmxwQnFGcUtXZEMxbGUwaUF1UHJN?=
 =?gb2312?B?QmJlSDdVMkZVUHlWa2V3aUFSUUxIbnVDT3BvUEd5Yk1WMnlvN2FGN0RuWjdS?=
 =?gb2312?B?M05Qa2NDMVcxc21NVGlsTGxwY1B5NlExdjAxYjVwKzRCMVVBU3JJOWhHU2Ur?=
 =?gb2312?B?c0Iyblh4R2ExVkR2RjNvcENSUmlCUGk5b2RPZ2t2K2ZVVHQxdFNUL2FLQ3hI?=
 =?gb2312?B?bkhBSlVTT3Bnc3R5cWtUL0t1enF2SDJYVjNYS3NSTDJlcVdxWkgzdExlaHhK?=
 =?gb2312?B?TU1GaEdGaHNzMWJFZWRUYkVUbGhnaDBLbE9BU2x4L055RXNjSE5EQytDbXEr?=
 =?gb2312?B?UXZTSXlYV291bmIwNUZ0djh2YmVYeGl0Qys2OGVuem1sdzk5ak5tTDhSQnFZ?=
 =?gb2312?B?NVZVeC9jY0Q1QlVyYU14NU12SldaRjhzSGZjSkdFM3VuUWtpUnB2cHgxUEdV?=
 =?gb2312?B?Qm5wOE9OcEovUy9EckxQRUp6cFRRcDRuSHV4M2pjY1d6RHNkSFMxSUZnVUhK?=
 =?gb2312?Q?gN0k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bccb212-80c6-4107-4834-08dcff11edcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 09:52:44.8252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r15hIKJFeBlQtzUT4aJxyb9qRLwZqNwhys3ymty8X6dXLpaTh/p2fmMcqQBLCSrwm/HnZkb9+/7R/grAYS6C+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXJpcHJhc2FkIEtlbGFtIDxo
a2VsYW1AbWFydmVsbC5jb20+DQo+IFNlbnQ6IDIwMjTE6jEx1MI3yNUgMTc6MTINCj4gVG86IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUu
bWFub2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAu
Y29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gYW5kcmV3K25ldGRl
dkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBr
dWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMC81XSBBZGQgbW9yZSBmZWF1dHVlcyBmb3Ig
RU5FVEMgdjQgLSByb3VuZCAxDQo+IA0KPiBPbiAyMDI0LTExLTA3IGF0IDA5OjA4OjEyLCBXZWkg
RmFuZyAod2VpLmZhbmdAbnhwLmNvbSkgd3JvdGU6DQo+ID4gQ29tcGFyZWQgdG8gRU5FVEMgdjEg
KExTMTAyOEEpLCBFTkVUQyB2NCAoaS5NWDk1KSBhZGRzIG1vcmUgZmVhdHVyZXMsDQo+ID4gYW5k
IHNvbWUgZmVhdHVyZXMgYXJlIGNvbmZpZ3VyZWQgY29tcGxldGVseSBkaWZmZXJlbnRseSBmcm9t
IHYxLiBJbg0KPiA+IG9yZGVyIHRvIG1vcmUgZnVsbHkgc3VwcG9ydCBFTkVUQyB2NCwgdGhlc2Ug
ZmVhdHVyZXMgd2lsbCBiZSBhZGRlZA0KPiA+IHRocm91Z2ggc2V2ZXJhbCByb3VuZHMgb2YgcGF0
Y2ggc2V0cy4gVGhpcyByb3VuZCBhZGRzIHRoZXNlIGZlYXR1cmVzLA0KPiA+IHN1Y2ggYXMgVHgg
YW5kIFJ4IGNoZWNrc3VtIG9mZmxvYWQsIGluY3JlYXNlIG1heGltdW0gY2hhaW5lZCBUeCBCRA0K
PiA+IG51bWJlciBhbmQgTGFyZ2Ugc2VuZCBvZmZsb2FkIChMU08pLg0KPiA+DQo+ID4gV2VpIEZh
bmcgKDUpOg0KPiA+ICAgbmV0OiBlbmV0YzogYWRkIFJ4IGNoZWNrc3VtIG9mZmxvYWQgZm9yIGku
TVg5NSBFTkVUQw0KPiA+ICAgbmV0OiBlbmV0YzogYWRkIFR4IGNoZWNrc3VtIG9mZmxvYWQgZm9y
IGkuTVg5NSBFTkVUQw0KPiA+ICAgbmV0OiBlbmV0YzogdXBkYXRlIG1heCBjaGFpbmVkIFR4IEJE
IG51bWJlciBmb3IgaS5NWDk1IEVORVRDDQo+ID4gICBuZXQ6IGVuZXRjOiBhZGQgTFNPIHN1cHBv
cnQgZm9yIGkuTVg5NSBFTkVUQyBQRg0KPiA+ICAgbmV0OiBlbmV0YzogYWRkIFVEUCBzZWdtZW50
YXRpb24gb2ZmbG9hZCBzdXBwb3J0DQo+ID4NCj4gDQo+IENhbiB5b3UgcmVmYWN0b3IgdGhlIHBh
dGNoZXMgaW4gYSB3YXkgdGhhdCAibmRldi0+aHdfZmVhdHVyZXMiIHNldCBpbg0KPiBjb3JyZXNw
b25kaW5nIHBhdGNoLg0KPiANCj4gDQo+IFNldHRpbmcgTkVUSUZfRl9IV19DU1VNIGluICJuZXQ6
IGVuZXRjOiBhZGQgVURQIHNlZ21lbnRhdGlvbiBvZmZsb2FkDQo+IHN1cHBvcnQiIGRvZXMgbm90
IGxvb2sgZ29vZCB0byBtZS4NCj4gDQoNClNvcnJ5LCBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQu
IEkgb25seSBzZXQgTkVUSUZfRl9HU09fVURQX0w0IGluIHRoZSBwYXRjaC4NCk5FVElGX0ZfSFdf
Q1NVTSB3YXMgYWxyZWFkeSBzZXQgYmVmb3JlIHRoaXMgcGF0Y2ggc2V0Lg0KDQo=

