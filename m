Return-Path: <netdev+bounces-206677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3CB04083
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDEC188773F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12009254848;
	Mon, 14 Jul 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqxN5U2i"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A8253356;
	Mon, 14 Jul 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500639; cv=fail; b=LL1ypVxdRWW9X3GvGjMHnAjN6DlIJBTmP327tyij8Odt7KwBMkHBMW58f/3w20vGiA3/H+kVXtmEe26iKPkKLUHWkA0y7BCcwCY5y7tb6Mv8l30ZAbDeC+kljSdpf6ppMteBZ0Jhvky8nzFFNZS6ONfG27gNlQlWP8INnyTjTH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500639; c=relaxed/simple;
	bh=ICJzbkBifEuUnWO6CrQmBS5f5sIgnhUdPYfwvvOMSds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEakwF66jbdK9IV0fORpRUx6HTTUaKmYLv/vg/+MQKABHCoCqQF6ifiyW6EzPqTR0OR3+5VyNPms4Nm5+xjWR3xKtGL3s76FpAkr1wa/hVptRXU3AaryIyF7Z+qTZE8lwqx/DQe/kk5AACbEm0hngtMCCqdofct24QRurrjKIwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LqxN5U2i; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEud4lWxmZE7za4A4yXo3bJCjc0Orua1oEZjXQblY8IP7I5AFP0DTb3Qjl1mQKG9mXwxUHz7x6aGblI+6Y9w7zSzAqDgaDnaETe/4vTfcIyuv9f0K9x7zXNxe/jJXkaLnlFLyjZf+BQjeeneCg7wu+o9oLBW3EP9YAV9GRS2qi36zBZm/MWJZ2OqWGV0ei8ZRzXxTt47GqEi6Yfrqa2DjwVtRcI2rlArAGr8lvtqPfRDbbzOYJtVVBgyWcpCd9LFjgpVLgwn3zLuZEHh9LjJIUe/MChbfuYSvQIw96nexNOPkijrk3MzfZNSgRLOJwouhlMC9REVFPeqft3XXD5lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICJzbkBifEuUnWO6CrQmBS5f5sIgnhUdPYfwvvOMSds=;
 b=uKEW2Lf95qneUvJLduhE30ftcxmQkkU5u2NzlVtB0EQwkY3x16v/xIQcC4AwQo++sKKRxbzJGcumw+KM8oNdF+E59s7z9efvQdj6klUlex+KEpAQbyManeH6a28ywH3SRTBO7h3O2V8ZymK2yfRiGIRIfOy3f7zp7KQ/XPURu8Lw443Niu4BsnPMHBO/28gR9q/v4Mu9oiZjq6c5BuqTzu3wU5mo+SHzGvNpu5J3xOXu77eRJLHFZe2/7gCA89rUAb/lOQNigY2uAYwRLX/R/I9shTVwW83XkjMNlVDUfnJZ2nxs42fjUf5m2NuGHL801cShfvjaQRj9okIMwRhR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICJzbkBifEuUnWO6CrQmBS5f5sIgnhUdPYfwvvOMSds=;
 b=LqxN5U2ilnil3UJ5eeWJatjEcPD6SFUyR1Mud7WJrS0CDYl6MOqFwfJZBGePGf7yLpoXKBrh2gQQDbVDi3WZd76BYcJfV4fce7I0J5y5uP+/IsEWZgz/xy05DzlpCyRQ99x+hyuN7+BLnYK11PG4E9+wVbgD/V6qEYFvTiNL8HvAepcuGjgT0Z5cYLTTjvpVSDDYyv6cfsspNrI7n01WLrcwlBuY3inyqPy5tXAli//ywqeCv/XHiIMn5P91yBbWpyXAlfjOsR+wguijCkOccNkrvfA3ACqLoFoKeLJMhrzPzi6r41Y0RhgeM1DBcsQyK89oPbT6QIDPdwrQ/qkQZA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11095.eurprd04.prod.outlook.com (2603:10a6:150:27a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 13:43:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 13:43:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8CAABL4gIAAIhmQ
Date: Mon, 14 Jul 2025 13:43:54 +0000
Message-ID:
 <PAXPR04MB8510A9625CCB563BDA8AEBBD8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <70560f1e-fbbc-4e65-a8f4-140eb9a6e56e@kernel.org>
In-Reply-To: <70560f1e-fbbc-4e65-a8f4-140eb9a6e56e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11095:EE_
x-ms-office365-filtering-correlation-id: af103df2-c909-488a-6d86-08ddc2dc7951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmRDOFdJYytGZURyU0tXdUcrSEFEUW9GazVOQ1JDWGRPaWxSZUFEaFZscW1M?=
 =?utf-8?B?Q2FQbFNEVEl2eFBydkxYaENLWmMyMFluK3VIck9LM2FZdU1NRldDdmJMMXpD?=
 =?utf-8?B?d2VlN3ZkdXh4OVQ2azVEb29NelNzUzE5UjN2cTRSNHBCQnU4dkRlQVllbHBx?=
 =?utf-8?B?WjJlR2RxV20vT01wMG5Ya0JHaW9jbmVyQ3VsblR0WGxWV0pRM25FeXFMTkRX?=
 =?utf-8?B?Qzg0VElJMVM1bjU0d0dGclpXREdVeFZlVEdWQlBlQlp1ZG40Vko3b3hUREhP?=
 =?utf-8?B?N3MrbVVoWjQ2YnRaLzNJRXQxVzBxR3ZhdnRQT1Qyb3B2SUYreW9WN29FTCtQ?=
 =?utf-8?B?S3RCUGVMOWNDejNUZFdscVdBOGVjWGlNUWcyYVA4WjlJcGRzb21zdGFWekVu?=
 =?utf-8?B?SXFNZWVXRklpUU5SR2Nhb0hmQVZKK01MQWFMSVZPWi8zSW1jeWRNSVppd1ZN?=
 =?utf-8?B?YXpJNVhyMk01bWp2cmtOVU9CS2VWUk92YURnQnU3SGwxRUpDQmJsTEs3NWJv?=
 =?utf-8?B?R1A2aVcxU0thU2R5dUFEY0Njc3FzamZOMUI2eTB6RHpxWmR6Nndyb1QyQytn?=
 =?utf-8?B?STh3eXJhTkpCLzNTL1YzejJJa3BoTVVDWnRPVWpKNFJpRWx4RGNmSWV3VVk2?=
 =?utf-8?B?b1czY095ZDVtR1JZMFFmanZUYVoySWFvKzY0TWxoNzRoVnNvL1ZHWVRhNXNJ?=
 =?utf-8?B?T2c2SjJCN29BblNMbWtuc3pnRmxBVHJpV1J5WXdoS1VkczIwWjlFbklFQ3RJ?=
 =?utf-8?B?b1pIdjVvVzY0WHh5emMySXBzOGlSb1k4MjAvU2xYbHVvelRRY2lkckdxUDJN?=
 =?utf-8?B?cU40ZGNCOXBxVXk2Ky96MmQzb0hraFNXUXphSkZZbDBXbWtLWExVczdpY2ow?=
 =?utf-8?B?cThOdVo1bjRjaEdMbHRvdVA0RC9ZK0VZTFh5dVRuaGluS3JsM1Z3Wld2V0ha?=
 =?utf-8?B?elJqNHFQU1pSNFVZUHZITWdCd3BEYzAwQ0k1Rkk3UXlSL0lVM09FRmM2QWtz?=
 =?utf-8?B?WGNGa0U5SkRuekxudGdQeVl3TUk1dUU3bUYxT0JWb0lpTW42cE5tWW9UZExG?=
 =?utf-8?B?WDZnWi9qY0ljY2tIdmp3Y1QzNFUyY3FtZlErS2gyRnFaL0M2M2dRWWJRSk1T?=
 =?utf-8?B?U2RxV1pCUGVLRWhyVk02Um9wcE5SVndKT0V6UEs2OGdCVTVzVnltakdRTjBo?=
 =?utf-8?B?NGJOc0RkbjNHaTY5M2c1NHh3eElxa3BmWFBuU0Z0VFFTcHREcVZobjZ6ajRy?=
 =?utf-8?B?SnQrSXd3T2hHYzAraHhFeUl0cmZZT2dGUm9mcC9ERVVQRFRmWXBEa09wL0xD?=
 =?utf-8?B?YWlad0E2UE4yS2xOd2VaVnd4QnUyUHd6dHBRL2VNSktYSjdUTWptc0FiR2o0?=
 =?utf-8?B?WkJ1NDljdThhSThJTXdjMnpyTjVoOWhMYjVaMC9TajF1aXRCd21yY1dXcXIw?=
 =?utf-8?B?V3EzQWg2ZS93RkhsYzZkTmxxc2dvTXdJQXBPeitLYXNaL2NCalZyVVdVbjRD?=
 =?utf-8?B?dlVMb01LMjBWSlM1eVdDSGIveTZTa01OZlpSTHZ6MGpaY0JXNWoxMUJRR21I?=
 =?utf-8?B?Yk1GKzN3aWcvelJ2T25taWxPYjRyOGV5NFdNQVo3eTBMMklpRk14c25IOTh3?=
 =?utf-8?B?dzh2YXlIWkhpL1Jka2pGcWlRUWN4dnFQdEtPcTl4TU5DdWJBbkNMc3ZvSUdD?=
 =?utf-8?B?TFgvRWNzbXFQNEJPWTBsTUkzMGIrM1RDWm1RUmJxNVdJK0t1TEVHSTIyUHNI?=
 =?utf-8?B?Mm4zeExYV3hwVUFYVXBTKzRweFdCMnhweEg1b0psMENpT2N5K01NNitMeHBX?=
 =?utf-8?B?VTdDYXN1NUwzVWZWaUx2ak55a0kzRm92b3IvWFpKZXVaR1pNYStUTDBTMUhC?=
 =?utf-8?B?bWpvaE15eFFhSDBRK3JUT2RneVg1cjNyNkhQOWpoTEVwNkxtbU9hVTYyTk1z?=
 =?utf-8?B?TG5SUnFINDk0QkczQVNpQnlSMnVJc3ZTWlM1MHhOcm9EQm9FenhtYVVLWnZM?=
 =?utf-8?B?TDJIWHozNVVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG15dGc5RDduME4wTkRTUUJQUXBXazZ6TGxMOWcwRkRldktDMjUzQ2xxOVFa?=
 =?utf-8?B?cm1ML3piQVlpbUFRbzVTR0ZYTC93YXNveDZZaEdXMWtJWkZIbmJRaVJaZVRO?=
 =?utf-8?B?eEtUTlBPbWdIZVdWOTR6QVZ0VEV0bU1LUXlJck0zRHNObG1ZL1EwSklpdmRv?=
 =?utf-8?B?dlIrQ2hMK21WZjg3M3lhd2QwVkd3czJzaVhYUVpzdTUvdmVSbE9ZeTVLeUsv?=
 =?utf-8?B?clJWYWdUVldBeXMzenFxZURuVXlGV2w1VFFCTm16a25FdlNxNGt6aFloejZ0?=
 =?utf-8?B?WHhCWU4xT2VGOFkvQlN1MVBGek5CWUw1SDByUWRUYW9RZGtVQ2cxUHk0VWRC?=
 =?utf-8?B?Wi9PYUtVZmZnM0xsT1NKcklISFlOeDBjb1BWVVgvNytKeFVCUkJER2JHRk8z?=
 =?utf-8?B?YWlCMGZFVzE2UXhQMmcwdmdOcVJ2VGJtOUlRMmxGeGZBamVmRCtSa1ErM2c5?=
 =?utf-8?B?SzZyanZUbXVtb3dhQ1lsTWtvUjRGQ2JuR0R0MEFqdVZlNngvMTZPcTFWaC9C?=
 =?utf-8?B?YktUR3dmUXBHSy9WbDRNcTR3cFZ0dWltV1F3bXhPbXB0a1RtM2NjV0x2bXpv?=
 =?utf-8?B?cTVMUzUxTHhQTjhrOHJSWGd4anNweklsU0FwRUVIR09Jc1VWTVBWbUpnL0RW?=
 =?utf-8?B?Nk92MVFUeDRBbEtaNDU5ZC9NY3oxME51aFY1UzRuOWV3Vk5McVBzSVdib3pO?=
 =?utf-8?B?WXh2MUxydDhaOEpDMi9rK3dueFJ1cWR1RFd0TTR3K0d2NEk4eHpCbndqQ3Ju?=
 =?utf-8?B?QUNVUDR4aGJlQlFqOEZrdjhTc3JENXFseDdBUU13Yjd2NVVwcnVCSWN6STB4?=
 =?utf-8?B?bUFOMVorSjVVM2VRLzNSUXRSbDFjcVYyaWtSWlJraTAybHg1am9ZU21qa3lq?=
 =?utf-8?B?ZmppQmVOMkF1RkpLa0NUZUhySTFHRGN4bjJlalE0U003UHFEUHoyLzdsSXFu?=
 =?utf-8?B?bjZhaUtObUFLQlJ4Y1dISVFPTkVLSGtTVE1wK0UvVWVMY3pnbnM3ZmRRT1Bh?=
 =?utf-8?B?YjZxaGNYTWNiMWV4TXVtMlp1Y0pzQW5rQ1h0S3YwOHI5OFN2MU11TEFBY3Rz?=
 =?utf-8?B?WkhzSm4rY1VNYUx5VlhYTFd4SEZXZmwyOWpYSEpLOHdkQ1VlaGVidm80bUFU?=
 =?utf-8?B?dHMyeTRuVVFDYlk3MGV2R0duNDVzanNPS1NwemVTa0ZrMURsMUpRZHlYNFQ5?=
 =?utf-8?B?Y0R0NCtNRkVDT0pIRVgrTUhXUWJXRmxQWjZKK1RxakxyczVta1p3dlB0M2Vk?=
 =?utf-8?B?aFJPWHBTTk5neXlSOHh6cWV0RjV5bE54Ky9RNVlXNG0yV3g5UjNwSlNaTXhx?=
 =?utf-8?B?bG5sTE81d0dWbkt3QURldlE4NGI1TUpGMGpVWFFxMThaQ0ZHN2owdnlBSENH?=
 =?utf-8?B?c1JlYmVGSVBWdkdpaS9zT0pKaktSSDVwSllIR3B2VjlxOXV6c0l2VkFpcDcr?=
 =?utf-8?B?Y2FiNkR4NzExbTNwamRpdnJOVkpzMTlDME82Q3ErVVd3aW1OZ2ZjSVBXNCtm?=
 =?utf-8?B?SjR1QUlodEtnMnFVSUZSRTM2RnV3UHpTcEZGV1c5b2dtbWFTMWY1dHozTjZs?=
 =?utf-8?B?K25LZUNES3RpeTRnajA3STZsU1VEWjE4R3pINStoaHpBT3VZcGp3ai91YWoz?=
 =?utf-8?B?OCtOSDJBeFo3ZkV3UVFRQ2w0YWVPL0NqTEliV2liQk0rTC9Ib2NlZ1lsYjhw?=
 =?utf-8?B?RGE0NHVCWUJ1SzdESW05U3ZYTmdrUDd1NEZkcUR2WUJrdmlQL3pjU3Zlc1Vk?=
 =?utf-8?B?TStKTld1Tll5NlY4bFk1b2lXbWxZckg3MzJyall4ZnlUKzVBT25iVFdDakhU?=
 =?utf-8?B?WXpidWRmU1BkUzlvYjlyZHNKSmdZakovR0RZc2VvS2hqMTJPUEp3MnJhdS84?=
 =?utf-8?B?MkFqcWhNVGZpUnlUVHUvUVh4cGVTTGQzd3RoUUJkZ0tRSGRqSXJacGx5c2xE?=
 =?utf-8?B?WE4xWStEZnJuUWdDWFR2UFBUVk5jZjdta0ltTk9Eems4VGVUNHpKbFhsRHVi?=
 =?utf-8?B?OSswN0d3ZjhRZmMxOUQ3VW45MFU2SElLdkxoZVltdG1iMlc2VkNTeTBNMm85?=
 =?utf-8?B?aTl1U2kybWl1SllUeHJweFRpSWhSNlYxNkJocURRdmxmVkhKVzlFOEhGcExr?=
 =?utf-8?Q?Kttc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af103df2-c909-488a-6d86-08ddc2dc7951
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 13:43:54.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNIiNT8Us42hnN6xo95SecAZhR0F1GE8CQ7rBgJx/s7xPetfRWAdH2EefqhNJCG2eVVJBzbwlRMynAmhzBn9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11095

PiBPbiAxNC8wNy8yMDI1IDEyOjI4LCBXZWkgRmFuZyB3cm90ZToNCj4gPj4+DQo+ID4+PiBDdXJy
ZW50bHksIHRoZSBlbmV0YyBkcml2ZXIgdXNlcyB0aGUgUENJZSBkZXZpY2UgbnVtYmVyIGFuZCBm
dW5jdGlvbg0KPiBudW1iZXINCj4gPj4+IG9mIHRoZSBUaW1lciB0byBvYnRhaW4gdGhlIFRpbWVy
IGRldmljZSwgc28gdGhlcmUgaXMgbm8gcmVsYXRlZCBiaW5kaW5nIGluDQo+IERUUy4NCj4gPj4N
Cj4gPj4gU28geW91IGp1c3QgdGlnaHRseSBjb3VwbGVkIHRoZXNlIGRldmljZXMuIExvb2tzIHBv
b3IgZGVzaWduIGZvciBtZSwgYnV0DQo+ID4+IHlvdXIgY2hvaWNlLiBBbnl3YXksIHRoZW4gdXNl
IHRoYXQgY2hhbm5lbCBhcyBpbmZvcm1hdGlvbiB0byBwYXNzIHRoZQ0KPiA+PiBwaW4vdGltZXIv
Y2hhbm5lbCBudW1iZXIuIFlvdSBkbyBub3QgZ2V0IGEgbmV3IHByb3BlcnR5IGZvciB0aGF0Lg0K
PiA+Pg0KPiA+DQo+ID4gSSBkbyBub3QgdW5kZXJzdGFuZCwgdGhlIHByb3BlcnR5IGlzIHRvIGlu
ZGljYXRlIHdoaWNoIHBpbiB0aGUgYm9hcmQgaXMNCj4gPiB1c2VkIHRvIG91dCBQUFMgc2lnbmFs
LCBhcyBJIHNhaWQgZWFybGllciwgdGhlc2UgcGlucyBhcmUgbXVsdGlwbGV4ZWQgd2l0aA0KPiAN
Cj4gU3VyZSwgSSBnZXQgaXQgYW5kIG15IGFyZ3VtZW50IGZvciBwaGFuZGxlIGNlbGxzIHN0YXlz
LiBJZiB5b3UgZGVjaWRlDQo+IG5vdCB0byB1c2UgaXQsIHlvdSBkbyBub3QgZ2V0IGEgbmV3IHBy
b3BlcnR5Lg0KDQpJIGRvIG5vdCBrbm93IGhvdyB0byBhZGQgdGhlIHBoYW5kbGUgY2VsbHMsIGEg
cGhhbmRsZSB2YWx1ZSBpcyBhIHdheSB0bw0KcmVmZXJlbmNlIGFub3RoZXIgbm9kZSBpbiB0aGUg
RFRTLiBCdXQgZm9yIHRoZSBORVRDIFRpbWVyLCB3aGF0IG5vZGUNCmRvZXMgaXQgbmVlZCB0byBy
ZWZlcmVuY2U/IFRvIGJlIGhvbmVzdCwgSSBoYXZlIG5vIGlkZWEuDQoNCg==

