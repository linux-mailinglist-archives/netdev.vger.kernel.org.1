Return-Path: <netdev+bounces-149716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24D9E6E86
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F2E16C6A5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF82066C5;
	Fri,  6 Dec 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iYtBPAal"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0461204F93;
	Fri,  6 Dec 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489109; cv=fail; b=lykjZPFi07fS8O+s24kAOg7ndqC/WUqQIdiIqC5NyOkmPhGxaeUoNNgKAN+BFVPkzNBE30YsLBojRBo0OkU5ddDFlANDvcHymlevCX0MkR3bjJHOXedNvsD1Oe6A6vuSHRmNbpE3ruuPEdqeOLEGV39zv/Vc0TVIDN4T2bnU7XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489109; c=relaxed/simple;
	bh=2Ha4266yy7MEjnio8a5kjt5Sez7giTKQ/EugwQ881sI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQR/eG7EQgTbEphSY9Wspcc7uW0fG7u2MlfT1jpQUUZxZhp3CfVuXoV5t2VIGLhVDKTHP/nj/nPkWH4sZrwwDChW2eOlvuxwYhpHmPrCqe3JbJEUDEfKjBgSCLLYGuq/WfKwTDnJAQBE1OZEw42n3p81Gr1XQGYWnN1hqQYxYgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iYtBPAal; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U22S1/zgXlTIAdyJk2p3i95zL/gyEhFTik/yDGqBZ69zpBOlHLEpEzho9r994sVn5HBCV7AfGtWGLqH3Woc+hQOCyOzBRny+Th37NtmT3FPuJejdwH9NWf/ue+meKETyvU2TPmEkXEc00pHy869IZmhDZUVFaxARy4mN9JleJrOy8B0SBoxRg2kg2um441vUREHvVrrwyUokXgpA/NRH0GWqTaDsZRpfT7Qi55XhHORtXzv6RaXaUjj0AiaFd3JO8LxKJeIpWgFzlM6fpnMJL53tEoRnmo0YV1CbUrE8ZphY8/XoPWl9sz3SOUpoayMfdbAIW5g3StkO0WJZECg3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ha4266yy7MEjnio8a5kjt5Sez7giTKQ/EugwQ881sI=;
 b=oCvUmXfgJQwnQQNaOE2EKlqEpchsNPxNzGLxxDgTuDEqLNfAA5g7IGo4Auu79YucO0cVmEZt4rqZScVcl3M31U5dUm/9lFtrbCpIEE0pL1zi81ZmXV/gi5pId5Hk2QUsNttegnN3+cpCs49f7XkpiUHp+7J9GotE/UVIbjyDas7FnSbSi/qUpvUqnN5aH5fokbJzNbm79JFBM52u9Xe8ypKgyRQt7mGaQGRH72MiqZySNYilAPQEbjGGAqQzTPN8UEx7FsanaFjYS3c96ii/cs9G4El8Jtq+5D5LaGHFo4iQCzj2f5U9Ov30AFXWloHh3mdBYz/CXY4dX8wUIakUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ha4266yy7MEjnio8a5kjt5Sez7giTKQ/EugwQ881sI=;
 b=iYtBPAalb31bxV0GPB0yVThEBegMafRKlkE19TrdIWGbQ5G0ui3P/9xDHJUmds43QQ+shq5SiQzwgvvZ+X6E81HPeK74uR/CxpP4UP0529h6kDhTz/pbphZwja3S8BfkcEvBfrEo9MqNHQT30Opa558moolVGLroDswDjX5d100/swNlpc2364IlfH4A+JPuhif+KCsUalCLS/5oaHgQtc0OXVeKhAIiZGyt01J9URiPNpPEqQKWYjWvyTfAb4zBhn479wF03g5eXybbE1LUOnWMutoiHuLx7PLkc20nnwBf5c9wCa9krHdYFuyF4u49o8wfQvnwB9sI8RYJOLmWEQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8076.eurprd04.prod.outlook.com (2603:10a6:10:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 12:45:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 12:45:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Topic: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Index: AQHbRg+5C4mdptfiA06bM4c11AC4ErLY9OWAgAAMdbCAACfMAIAAAlig
Date: Fri, 6 Dec 2024 12:45:02 +0000
Message-ID:
 <PAXPR04MB85107FD857F1AB33BBE4F70988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com> <20241206092329.GH2581@kernel.org>
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123030.GM2581@kernel.org>
In-Reply-To: <20241206123030.GM2581@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8076:EE_
x-ms-office365-filtering-correlation-id: 55f34e60-d883-4b08-347d-08dd15f3cd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OU9BMVBWOHVvVXRkdFk5TUxXTkNCb0RZYmlUWWRYYWVFeG90RTlKUjJNWnFv?=
 =?utf-8?B?cUZkNTl0YUYxK2xwS2l0Nm1PQVR4eE5oYVhWcFlMQlV3MUFLcUZvb1hsWExD?=
 =?utf-8?B?cnVIRVNOZU1KcFROdkZ5NTB0QUwxMG9ONXI1ZXRjUlk5Rk01clhFZVZ3MWox?=
 =?utf-8?B?V1Nma1FiMGxGb0JPZFlINDlNTkdmZ0VIYlRjSzZxa25uaStaRUlzaDZWeHU2?=
 =?utf-8?B?T2ZGWlRFWUhVWUk1WjRud2c0TXRxOTZ0YVk3TWY5bkVBcmpWVzBabXlpK3Vl?=
 =?utf-8?B?QmlCRFZSN2ZuTUxpcGtCVi9uN1R1VXNIaG51WkZrckloenRpeXJWUk9yMEQ0?=
 =?utf-8?B?QksxYlh3QlN1bDNlL1RPY2E4a2phdjJYdEdJdkdyWVJVbEVocC91ZkQ5d201?=
 =?utf-8?B?ZHp5LzZZbWhZZ2VvamNMOVlpaFd1eTRrazBJN0plT3I2MWpwc2tybE5ucDND?=
 =?utf-8?B?UXg4S2VyV2dqSlBNOFlPYlVpemNOWFNZTy9DYVhDNjVhSXk5Y20raWMwYnBT?=
 =?utf-8?B?UkVQRlFBQU5LdW1NT0hVMHc3MkFpSjN3NWNnaW91NjlzYVpuMEdrU2FqOFJi?=
 =?utf-8?B?YThoZFA5WURjUEdxV0Q1SktXWklqLzBoNzdxZUQ3eG5lUzhCdUxoR2RlN0Rl?=
 =?utf-8?B?UStzbFFFYmlTTkVKUUdyd2o1KzRLdlNUU3dWcTRxQWtJTVFSMytOeXVOQVRU?=
 =?utf-8?B?bkoyeW50MHpFRUs3SjRQVFNlbEFWRDBxNTRkNzNIdm9laTJ0SHQrMlJYdWw3?=
 =?utf-8?B?YVlLYzhlR0JpN3lkOUtvY2RlZzRZZWlveFY2NkR5RFBjWmVuQkx6eUtYVVcv?=
 =?utf-8?B?eVF2bms0RFdPenBZUlIyWXBxNkU0dGRHVkpuNFJSK3ozSGZnTmE2WGpsWExY?=
 =?utf-8?B?RXVzTDcySjlsNjhQQ3BrcU12QktCRk05bDU3MEg2dEZpdVNLenF5NnRicDdh?=
 =?utf-8?B?R3dqM1R5dW9ndWlaRnUzT3RxWHpsVWlFcUR5YkVlRUZRdFBSSnNLMWpJRHZi?=
 =?utf-8?B?enp4cFVnMUMzNVdsWEY1bXh2SkVlZkFCUlJDY2krNmVwYkwzRFYxSmE1eHox?=
 =?utf-8?B?eEs2NDN5N0hYOWdWWCtmWmdiQ2Qvbk1VU3lLMktlR081MlpTVFJyZTlvUnJh?=
 =?utf-8?B?WkNXTFkxaUpNYTR1S29OSk55RGJXRFVpTldlNXZRRkRGOURNVmN2TS83NVMz?=
 =?utf-8?B?cEdTdFExb24wTXVwZHE0Q01wbE95WS9WYzY4SXJYNzNTVGhHdGZyTEo2TFRz?=
 =?utf-8?B?U3JGRU5Xbk1sVGpUbWtpcjNMeEEzdEhzK0Rmc3hiZHM5ekt5MFY2L1BaWDZz?=
 =?utf-8?B?TXdYZldpSzlTNmhPZFE2YUlyL2YvcjhqVGlQRnBZMGgyWEpTVlVhVTJ2aWw5?=
 =?utf-8?B?T0xUSDFUQm5iSnNoTUQ0ZDF6Sk0xRVRwQXNTL0kzajZaQVVGaDdaR01QQndm?=
 =?utf-8?B?RndYczQvcjh1c3JudUZmZm16MWRuSlk3NjFENytFZmZXekhnN2YvYk9UM1dH?=
 =?utf-8?B?UVJ5OTFZQVZGdHBGV1RnTThCY2tZY0Q3eXhEZXJGWG0zN2MyQzNka3NDV0t6?=
 =?utf-8?B?aHUxeDhSNlZFTUd5cXhkREZBbXdGdzhsbSt1QjdMc1AyZmhJazFkNER4ZWJ6?=
 =?utf-8?B?clcyUUJVNTVZcmpLdE9QbUQ1Z3YvaVprd05mTlVUd2lMcUZpSEJMV3ZYY3RT?=
 =?utf-8?B?dUVQdWw4SjFlbzB0NjlKdGh0K3BNdWpnRFNKNmZpZDJMcUxHMHNOKzRhZFNV?=
 =?utf-8?B?azVzdnF0Ly9BUE1TUGlBcysrYkZ2dW5ZVkFNaG15VENZckk4eE5PSVcyVkZR?=
 =?utf-8?B?MHpQc0dBbnBXM3VkS3JHYUJhS2UwVlB4d0Y4cDJkV1RTanRVSjhpU21yWURD?=
 =?utf-8?B?N1FHdHRiN1hYNWltcWF6bktaaUQ3dkp3dm9KZHVQeVpiekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE9ORWNyTmFXOU8vY2c1Rk4wM2pGbkNRZENQa28xK05jR3F6MGl1emc1VlJQ?=
 =?utf-8?B?UklrdFp2eWJFYm52OERLUjl1eXkxSFBUektlNS9SOEpmQzlKa3Rzcm5VOGRz?=
 =?utf-8?B?Nm41VFlYOWRoZ3AvdlVjeUVPSmVnc3RZU2NwK1JXSXJQSmVCMHJTQ2NLQkd5?=
 =?utf-8?B?TVQzZ1VRQTJuUWpEL3p6MWVhMGwwcHRiU21TSFJsNCtqTC8xQXljNWZ5SWRD?=
 =?utf-8?B?UHkzaGdOc2NkTnRuZDlQaXVzaUdTWlN1TzUvOGV2MHdXK2xiSFdpczBETzFr?=
 =?utf-8?B?SXFLbEtsUzJEajVHY3IvWkxPVlZRMnQvd2xyYWUySHBBSXgwa0pnbUdtMnpY?=
 =?utf-8?B?aEYraXlpZ0RxOGNyNG1PbkloZGtUZ3AxeXFMb3RpenNzOVhJQlg4N0xYNDdD?=
 =?utf-8?B?UWRuL0xNYVFqaDcwZnNERXhwOG9SR2JvKy9NN2ZLR3l1UnlUdmF1VnpsRWpN?=
 =?utf-8?B?ekhPaldLMlJDdTloVllxM1BmVElNYWFoN1IvNERIMEtTQTl5ZDNSMjBwWXBS?=
 =?utf-8?B?VDgrVUlpTVJLb3ppWFJuNndJKzZWODdzKzhVY1VoS05jQnQvY0hiZDczQ0ZE?=
 =?utf-8?B?dGdSQys4NnFSczBXZWhib0NPWXBieVVSbzEyOUhCL2JpTDJZYzdxaWlvOFhz?=
 =?utf-8?B?Z1RsdlZwQzNoS2xhN2JId01CLy96WnJGSDk4YzduUEdKcGo2Yzh2MktUZDI3?=
 =?utf-8?B?a3JkZTZrd2lPSGpKcnUzdEEvRUszSHczY1Z6V0h2ZlZTMlE0bldoS1BMWFRp?=
 =?utf-8?B?MUZUa1pxRGJ1ZkZJN2k4OStWWnlmRXRKNzBxajlFZklTa3VqNkVZS21vSHQv?=
 =?utf-8?B?d2JXMnJCUjFjTzA5aDdxbVhuMXZsRkZhQzEvOEZpRFd3cC82SDFpenpqY3l1?=
 =?utf-8?B?cEVwcUVmbW5tY2orc3Vhd0swZ1VCS0k4bkF4ME5jSzZVN09lMXJ2T0d4TXZx?=
 =?utf-8?B?ZU5IWmdYeEtYSXFEblB1LzhrTjNiQ1Z1U2JtYXJpZTJPSXBPaHBsUVl6TzZG?=
 =?utf-8?B?NXFpYkYvSXFxWURTTjVxV1Ercjk0bG5neGJxdzhyTUdVUnBycHgzb0VxOXhJ?=
 =?utf-8?B?aGU3QTBhbGRwajkxN2twQ1Q2QUJKTm9oOEZhMlBVUE1NWUdkWUt2TGRrbE5X?=
 =?utf-8?B?clpLbHVnUkVVQnVITmRSMlFRT1JWcG9OcTVHTGl2UlNVRTZhRmN1V2lOa3RD?=
 =?utf-8?B?eERYY0U2dGpjT1FSRjRDNFEyVllobzBVbVgwR3MyTVNVUnBmdHdEa3hWRkd3?=
 =?utf-8?B?K3pObThYNXFiZVB6THZLVjJhOWtJNXpvRDlydEtSSkNYdEllWndvcGFoWUNv?=
 =?utf-8?B?NmFjeDdLTXk3MUJHMXEyN0xVbERPcDd3cGtCcEF2cS9zekhtZ3NsQXpBV3Fm?=
 =?utf-8?B?bTNWUkMrRUVxVzBRZzNpSTRmbDU2Vys2Rmg1bmVJMWxKWnFRd1Y2clpmeEcr?=
 =?utf-8?B?eUVtaDEvZnNLSFM2L3B2bXlTVm42Tk9mcVRoRFN5d2VGUGlwZmNaQmdibk4v?=
 =?utf-8?B?U0dBS0FBQWVLblBRMmRhNVVUUzdKbllWZjNoeVIzbTVNa0VRUjV1Q3dJWDBB?=
 =?utf-8?B?clV3Ni96VVRBODgvTUVySy93RjBqN3RQOG9CVUtBL3lBYmNCbXJ5dFdOTEJX?=
 =?utf-8?B?em9Vcy9ZVUlFQlBCOFB3WENodXNGODVHR256eTFScmNVOTFoaXRxRnBHdDA5?=
 =?utf-8?B?VUpZdGsrUXhvb084K1g4Z0FyKzJMQXVra3h2eDAva3d0aEFWRDJkOVZ0Z2lW?=
 =?utf-8?B?T3p4dytPRWc5OVd0a2dKSlhhNEpRY2VWYVJiRWJTcHFFSGVUUHZ6NnU3cHJt?=
 =?utf-8?B?U0VxemxnSEdkZVcrOVE4UXF4aC9zL1RVWUwrZi9OSGY5eVBJczRrQzAyNlVt?=
 =?utf-8?B?M0ZnaWNDeWZyZkY4SFlBb08vdnI2SjRVWlJjSUtNUGx6cXRlbTllUzE1VUkz?=
 =?utf-8?B?bkwwZmVEL2pXc2pVb3F6VHl5ckMzNUhrWUdGUU53dVo2WFk4K0FQTHpSdmRK?=
 =?utf-8?B?NHZUQzhza3dCUHdEd0ZqdWlJSUVNelhmMnBoYzdyYnZ0UjhaUitMZU9FMFlr?=
 =?utf-8?B?Z2JqbXRGWmdxYURIMGVYZ2JVRWluTml5TFQvQ0dwUzkzUGNlYjBpMEFsSHds?=
 =?utf-8?Q?lXJQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f34e60-d883-4b08-347d-08dd15f3cd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 12:45:02.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1jMDwq6TWhAVVslVXeyCYzt+rGaJqAc7KzJ7jQwozwqc4laALseWU2PctdaXKOBiD7m8hALWaTgjXK2a676Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8076

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDbml6UgMjA6MzENCj4gVG86IFdlaSBG
YW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFu
b2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29t
PjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJh
QGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNv
bT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiBSRVNFTkQg
bmV0LW5leHQgMS81XSBuZXQ6IGVuZXRjOiBhZGQgUnggY2hlY2tzdW0NCj4gb2ZmbG9hZCBmb3Ig
aS5NWDk1IEVORVRDDQo+IA0KPiBPbiBGcmksIERlYyAwNiwgMjAyNCBhdCAxMDozMzoxNUFNICsw
MDAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAy
MDI05bm0MTLmnIg25pelIDE3OjIzDQo+ID4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5j
b20+DQo+ID4gPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBW
bGFkaW1pciBPbHRlYW4NCj4gPiA+IDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXJrIFdh
bmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+ID4gPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+ID4gPiBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+ID4gPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IFJF
U0VORCBuZXQtbmV4dCAxLzVdIG5ldDogZW5ldGM6IGFkZCBSeCBjaGVja3N1bQ0KPiA+ID4gb2Zm
bG9hZCBmb3IgaS5NWDk1IEVORVRDDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBEZWMgMDQsIDIwMjQg
YXQgMDE6Mjk6MjhQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiA+IEVORVRDIHJldiA0
LjEgc3VwcG9ydHMgVENQIGFuZCBVRFAgY2hlY2tzdW0gb2ZmbG9hZCBmb3IgcmVjZWl2ZSwgdGhl
IGJpdA0KPiA+ID4gPiAxMDggb2YgdGhlIFJ4IEJEIHdpbGwgYmUgc2V0IGlmIHRoZSBUQ1AvVURQ
IGNoZWNrc3VtIGlzIGNvcnJlY3QuIFNpbmNlDQo+ID4gPiA+IHRoaXMgY2FwYWJpbGl0eSBpcyBu
b3QgZGVmaW5lZCBpbiByZWdpc3RlciwgdGhlIHJ4X2NzdW0gYml0IGlzIGFkZGVkIHRvDQo+ID4g
PiA+IHN0cnVjdCBlbmV0Y19kcnZkYXRhIHRvIGluZGljYXRlIHdoZXRoZXIgdGhlIGRldmljZSBz
dXBwb3J0cyBSeA0KPiBjaGVja3N1bQ0KPiA+ID4gPiBvZmZsb2FkLg0KPiA+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiA+ID4gUmV2
aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1i
eTogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiB2Mjogbm8gY2hhbmdlcw0KPiA+ID4gPiB2Mzogbm8gY2hhbmdlcw0KPiA+ID4gPiB2
NDogbm8gY2hhbmdlcw0KPiA+ID4gPiB2NTogbm8gY2hhbmdlcw0KPiA+ID4gPiB2Njogbm8gY2hh
bmdlcw0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9lbmV0Yy9lbmV0Yy5jICAgICAgIHwgMTQNCj4gKysrKysrKysrKy0tLS0NCj4gPiA+ID4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5oICAgICAgIHwgIDIgKysN
Cj4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19ody5o
ICAgIHwgIDIgKysNCj4gPiA+ID4gIC4uLi9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjX3BmX2NvbW1vbi5jIHwgIDMgKysrDQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gPiBpbmRl
eCAzNTYzNGM1MTZlMjYuLjMxMzdiNmVlNjJkMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiA+ID4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiA+ID4gQEAgLTEw
MTEsMTAgKzEwMTEsMTUgQEAgc3RhdGljIHZvaWQgZW5ldGNfZ2V0X29mZmxvYWRzKHN0cnVjdA0K
PiBlbmV0Y19iZHINCj4gPiA+ICpyeF9yaW5nLA0KPiA+ID4gPg0KPiA+ID4gPiAgCS8qIFRPRE86
IGhhc2hpbmcgKi8NCj4gPiA+ID4gIAlpZiAocnhfcmluZy0+bmRldi0+ZmVhdHVyZXMgJiBORVRJ
Rl9GX1JYQ1NVTSkgew0KPiA+ID4gPiAtCQl1MTYgaW5ldF9jc3VtID0gbGUxNl90b19jcHUocnhi
ZC0+ci5pbmV0X2NzdW0pOw0KPiA+ID4gPiAtDQo+ID4gPiA+IC0JCXNrYi0+Y3N1bSA9IGNzdW1f
dW5mb2xkKChfX2ZvcmNlDQo+IF9fc3VtMTYpfmh0b25zKGluZXRfY3N1bSkpOw0KPiA+ID4gPiAt
CQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX0NPTVBMRVRFOw0KPiA+ID4gPiArCQlpZiAocHJp
di0+YWN0aXZlX29mZmxvYWRzICYgRU5FVENfRl9SWENTVU0gJiYNCj4gPiA+ID4gKwkJICAgIGxl
MTZfdG9fY3B1KHJ4YmQtPnIuZmxhZ3MpICYNCj4gRU5FVENfUlhCRF9GTEFHX0w0X0NTVU1fT0sp
DQo+ID4gPiB7DQo+ID4gPiA+ICsJCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX1VOTkVDRVNT
QVJZOw0KPiA+ID4gPiArCQl9IGVsc2Ugew0KPiA+ID4gPiArCQkJdTE2IGluZXRfY3N1bSA9IGxl
MTZfdG9fY3B1KHJ4YmQtPnIuaW5ldF9jc3VtKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQkJc2ti
LT5jc3VtID0gY3N1bV91bmZvbGQoKF9fZm9yY2UNCj4gX19zdW0xNil+aHRvbnMoaW5ldF9jc3Vt
KSk7DQo+ID4gPiA+ICsJCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX0NPTVBMRVRFOw0KPiA+
ID4gPiArCQl9DQo+ID4gPiA+ICAJfQ0KPiA+ID4NCj4gPiA+IEhpIFdlaSwNCj4gPiA+DQo+ID4g
PiBJIGFtIHdvbmRlcmluZyBhYm91dCB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlIGFib3Zl
IGFuZA0KPiA+ID4gaGFyZHdhcmUgc3VwcG9ydCBmb3IgQ0hFQ0tTVU1fQ09NUExFVEUuDQo+ID4g
Pg0KPiA+ID4gUHJpb3IgdG8gdGhpcyBwYXRjaCBDSEVDS1NVTV9DT01QTEVURSB3YXMgYWx3YXlz
IHVzZWQsIHdoaWNoIHNlZW1zDQo+ID4gPiBkZXNpcmFibGUuIEJ1dCB3aXRoIHRoaXMgcGF0Y2gs
IENIRUNLU1VNX1VOTkVDRVNTQVJZIGlzIGNvbmRpdGlvbmFsbHkNCj4gdXNlZC4NCj4gPiA+DQo+
ID4gPiBJZiB0aG9zZSBjYXNlcyBkb24ndCB3b3JrIHdpdGggQ0hFQ0tTVU1fQ09NUExFVEUgdGhl
biBpcyB0aGlzIGENCj4gYnVnLWZpeD8NCj4gPiA+DQo+ID4gPiBPciwgYWx0ZXJuYXRpdmVseSwg
aWYgdGhvc2UgY2FzZXMgZG8gd29yayB3aXRoIENIRUNLU1VNX0NPTVBMRVRFLCB0aGVuDQo+ID4g
PiBJJ20gdW5zdXJlIHdoeSB0aGlzIGNoYW5nZSBpcyBuZWNlc3Nhcnkgb3IgZGVzaXJhYmxlLiBJ
dCdzIG15IHVuZGVyc3RhbmRpbmcNCj4gPiA+IHRoYXQgZnJvbSB0aGUgS2VybmVsJ3MgcGVyc3Bl
Y3RpdmUgQ0hFQ0tTVU1fQ09NUExFVEUgaXMgcHJlZmVyYWJsZSB0bw0KPiA+ID4gQ0hFQ0tTVU1f
VU5ORUNFU1NBUlkuDQo+ID4gPg0KPiA+ID4gLi4uDQo+ID4NCj4gPiBSeCBjaGVja3N1bSBvZmZs
b2FkIGlzIGEgbmV3IGZlYXR1cmUgb2YgRU5FVEMgdjQuIFdlIHdvdWxkIGxpa2UgdG8gZXhwbG9p
dA0KPiB0aGlzDQo+ID4gY2FwYWJpbGl0eSBvZiB0aGUgaGFyZHdhcmUgdG8gc2F2ZSBDUFUgY3lj
bGVzIGluIGNhbGN1bGF0aW5nIGFuZCB2ZXJpZnlpbmcNCj4gY2hlY2tzdW0uDQo+ID4NCj4gDQo+
IFVuZGVyc3Rvb2QsIGJ1dCBDSEVDS1NVTV9VTk5FQ0VTU0FSWSBpcyB1c3VhbGx5IHRoZSBwcmVm
ZXJyZWQgb3B0aW9uIGFzDQo+IGl0DQo+IGlzIG1vcmUgZmxleGlibGUsIGUuZy4gYWxsb3dpbmcg
bG93LWNvc3QgY2FsY3VsYXRpb24gb2YgaW5uZXIgY2hlY2tzdW1zDQo+IGluIHRoZSBwcmVzZW5j
ZSBvZiBlbmNhcHN1bGF0aW9uLg0KDQpJIHRoaW5rIHlvdSBtZWFuICdDSEVDS1NVTV9DT01QTEVU
RScgaXMgdGhlIHByZWZlcnJlZCBvcHRpb24uIEJ1dCB0aGVyZSBpcyBubw0Kc3Ryb25nIHJlYXNv
biBhZ2FpbnN0IHVzaW5nIENIRUNLU1VNX1VOTkVDRVNTQVJZLiBTbyBJIGhvcGUgdG8ga2VlcCB0
aGlzIHBhdGNoLg0KDQo=

