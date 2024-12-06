Return-Path: <netdev+bounces-149713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E89E6E62
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B031282AF0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D1201254;
	Fri,  6 Dec 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZ/Hy4HW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAC1B4136;
	Fri,  6 Dec 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488737; cv=fail; b=o98klsAUpdjPL5nCp5x1czoiXfd3SZWXlBaFUCcGF2wJGCMsGIWRZf7vwmj7jijtcQ8kQrQytTV1dFOwzg96zRmeUpv5BItDBW+rimi4RnQ9/r1IuATGSVdm6UD/zWLvViZOLZTFMjJ2qVY/wnzdL3K/Yn3FgnRNQydfg0y6w7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488737; c=relaxed/simple;
	bh=escnczFdpq+w3wIKG93HtZDTYQs7KFdwxMcAvXdzs1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USK5gsrVDMEuiJVGVRn8KbYEhRiDaRu3hy8KtrC5/mJbXXHydHF8SkeylL5dhR57IxHKRF8oAnUO66vnp22I41A8NKC/dk5zvMj9kpqassBSi4BTaXWrrJRrZyxudyRMZDsGT+oLFJW8SJ2gQnsggiwGhV8YFlIYQhZkAcoQCSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZ/Hy4HW; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4kTnzz5v108i/zp0vV0EXiQtQESXyIz6KOoItbMeR9fUOOYWqkYtYY8brXLvkT5im6+RAaN7u6+YP608V7zZwvYXIdywYYqFgf96xwH/PrwCC8m30oHV8+kxquo4Wqf5daqhlU5SZcxzcjO08FMuK7PTyHQoiNuBacAe9r2sK/I+zSevti+ir1oq5sSvHM1OSDC942nZWsDDf7FChEGU066eooe8A68904kyb46wQ4k9MQqAhQDwTvNmgB5EhOoWLO6mpTlk1xfJqc+rVmU6w8sFeFtDcDIv/TCuWF82z56r126luNk9F4NucjatABDZEwuvCxfAZw1HF6lGjfRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=escnczFdpq+w3wIKG93HtZDTYQs7KFdwxMcAvXdzs1A=;
 b=w4tTjG/JqFcsLkX/GD7EcgS2xmx4L9xkCH4YNVoFZvXUtudkpZCiiLDgCl8sgSifs0s02EyIUuNyJPCffZKXoOs7UZDCSFMaihX1g1weYhsG4f5J3bhz+8gTeh2g76fBKJ8nXsCm4UYBH+OSYcUR2kC9RblWKTv14ogjoG3We+H9Q0VWCRKr1R3WZ9FnA32V7u/YSt6v/cCa65v3dbxMlsvrdi1+LAPFkj4Ll5aUqCFLTc6CtcJ/fTMlB2CZwzDWzRcID8Xh1cGGIZHVUoTRetjX9G7uV2enTL2dYkU46TAiSn6VH6QTnGf9CItf60JgODYCmsWlnlwlvMRvyM10pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=escnczFdpq+w3wIKG93HtZDTYQs7KFdwxMcAvXdzs1A=;
 b=EZ/Hy4HWSJNLAelRZPcxrAsFXINX6SJ4Y2rOtVwjjNQwCBGe8f6hzh3ioTAk9CYRbYMX8RtzlQRMXswpVXDmdTVdMDX+CdkEXesx5W8tkpxPqbxtCPikxO2iycuTD/BU8WykwTUM7FkwwSUG/quHFmy2RzlNn06ootnXcm6ZxBl3V5g2rgbphXf+/3VfAvvNea9vSUTXrkfld0eIm9pHEWKgvuDECPmVAkJGJLBxPb23R68ssrRku4XWxE1USQj2riD5bPHgt6BvbZ2Zqp4HmnlmU3tcqHbUaHa94QT3rkEwpqSMnHZ3bfRBYahp5wppaFXX1NdQ2kYUPacmEtmImA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10371.eurprd04.prod.outlook.com (2603:10a6:800:23a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 12:38:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 12:38:49 +0000
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
Subject: RE: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Thread-Topic: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Thread-Index: AQHbRg+8AbbuO/ZnDUqQrVEXfplrYbLY+LYAgAAQk6CAACBfgIAAALpw
Date: Fri, 6 Dec 2024 12:38:49 +0000
Message-ID:
 <PAXPR04MB851043CBB0B4458BACE0AEBE88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-3-wei.fang@nxp.com> <20241206093708.GI2581@kernel.org>
 <PAXPR04MB8510D797ABEFA1D6153A3C9A88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123219.GN2581@kernel.org>
In-Reply-To: <20241206123219.GN2581@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10371:EE_
x-ms-office365-filtering-correlation-id: 0d4ce773-3a5d-45b6-578b-08dd15f2ef24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnRVUFcwNlIvNUZtQ0ZsTDRCZm11UkVLQUZzY0h2WHdxS3QrUEJQcWsxYzJy?=
 =?utf-8?B?dVRzTFVzY3haWWx0NlMyOXNZQ29iN2lSY2sxSjkvSXNGOHQrNkJjTUhzMjdQ?=
 =?utf-8?B?c2FNVFZNWFNvTFNXeE5HN1dRdjJrbkd4UEhIMGh5SUhKTnhYdTEvRTBheWdr?=
 =?utf-8?B?ZHZjRUpDTDdMQ2F0SUVPSUhQNkR0OVFHc1NFZlZzTFZRblZNVjM1Z0xuMUJo?=
 =?utf-8?B?TE0xTkJiT2hrcDFhWWJzWWN2TlRkVWx1aDN0UGtpNktTNDVKOVdoNWFTdDdn?=
 =?utf-8?B?dDZ2VjhMM0F6ZytLb0oxNFhUL3lTUW9HNUNVUDQ1THlKZXhtWjNZY3BIanMx?=
 =?utf-8?B?aG9qcGo5dWQyS2RzVEo5WWpaSmVmNVVpaWNQWmZaZUFINGpVdFZDSjBYd2dO?=
 =?utf-8?B?QndSVzFwSGllRU55Z2wyQTlVcFIwMUhYT3ZYdm1DYnZIUkhFMS9mdDRiOGxT?=
 =?utf-8?B?SDhlMmxhUVJQbGVYa0hnWWptMUZVbmlHcUF2SHk2SjFGSzNpb2NUUHRCUTB6?=
 =?utf-8?B?Y2I0UnloV3N3Z2dvV1ovL0NaeVd1cWJMZTQ5bEZpRFhjeCtSSmlrQ3NWVnNv?=
 =?utf-8?B?YlZkOW1wbytQSFJLM3lia3JDcjB0aTY4d0NKekczZWhFS0VmMi9JbW0vYm5U?=
 =?utf-8?B?VDR1WUIwSUwvNUxmTEh3OENXcjh1SitVYzlMNU5hcFM2d29DcjNrc2g3MlNO?=
 =?utf-8?B?dnJ0ZTcxeDVGdld6eXJJM2lob0ZEamZFenNoNnhkUktmaDU4K1pnUStGY05K?=
 =?utf-8?B?ZHUydlIyS1dYT2VTQW5zV1BsV05WVHNSSElrVVJ0dVp6eXBSaHRZMGVEbWha?=
 =?utf-8?B?SXRndTI4dGhEYUt2VEdVS1o1am0zOVRSb2k1SWxKRVptVUJ1ZWw2TTE0YXBK?=
 =?utf-8?B?TG1sTWV2NHlIZVVSVkVJUXNUd3hTellIb2krcjhrWXhqRkdEL2taNnBsV3Q2?=
 =?utf-8?B?b3pGbDIwbWJ4UVgrQVlGSW1OVldJQUp1MHgrMEYwNzZhYS9XMVBNdHdjM2Z4?=
 =?utf-8?B?Lzd2WEtickZrdGpaK29kZW56RzkzdGkvYXN2SVZXanVJbmV2SWZBL1I2VHpB?=
 =?utf-8?B?WUVqZ25ac1BUT2xtUnZ1c2RyTlhTYWp5eVkwSTEwaVlkcWcrb1JSbXJWMGRB?=
 =?utf-8?B?eTNKN0wzelk4QVRMQzNuamdLYkExSVMvV0E0ZU5mL0FMcjFlc213NWxVaTRL?=
 =?utf-8?B?czgwRXNVYnZnVHM0MUJzbldtYXg1NWhuYmpHV0pSZUFyS1NXcjZjQW1iT0lo?=
 =?utf-8?B?S1BnS3VIQVlteldGbnJZeXVkQmJvUE10U25LTU1kMkhYQy9neitITzNnWDl4?=
 =?utf-8?B?ejB3ZkR3a29FVmg5NVNlSzM3eHBTdGhIN0tUWGFsMXJacURJMVJESlJ4dVds?=
 =?utf-8?B?M0UxVWRKOHlUWEJhT0NDQktYbnlqTERpM1AzcFo0bG9kYS9TaWJxWDJnY0R3?=
 =?utf-8?B?QTA5SkhOU1JLaFNNRlpaRmxsQml0UG14eVBNRy9odlI4ZDN0QnpYZU1FUWN4?=
 =?utf-8?B?djVsV3ErdFFhOWZJTk1Wb0Y3L1pyUEIrNWFkNW9tclpFb0UzYzRSdjIwckRs?=
 =?utf-8?B?ZExlWXp3dHRqTnJtSldsR2s0emIvTCt2Rmd4b2x6c1dvTDl1dVRybURNMlhC?=
 =?utf-8?B?UkdRa1BRYU1CVkVsK1ErZjBqdURIWjhUcXZjT0JQSHN5bzgzb2VwV1JWb2Zt?=
 =?utf-8?B?ei82TzBSc2hhWHVrTmZyK2lXL3loMUJMVHZjUDJseXRhNGdsR0tkdkFrbG1M?=
 =?utf-8?B?a0dIbjRUU1ZCVnJCdnNVK1EwZ3oxWkZTa1JNL2pWOC9LWVBUQUYyaGZWSmZX?=
 =?utf-8?B?MHZNZzJrZTJhYlQxYVNMMVJJWEl2dlFFQlFSV0ZaeXdNb1dNVjlLMGdvWmw1?=
 =?utf-8?B?Q1dDYVNoL1lpN0NrVkh4eG5BU1FCNDlVRjlRckJ1eHFUOWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nm4ramhjSkt2OWVQTERSVUdHSk5LdFRuK3JiTEMwckRQV20zTTVZNzBKdmZW?=
 =?utf-8?B?VDNYa0tXSXNFRWJDeHBrVjZKODBNVmhZTjRoNjMrSHZDRkcweWwxdTJkZFlt?=
 =?utf-8?B?SG1FeXltWUtqRlgzUk42Y2w5L3JjT1lUdVo1R2NXVkRxNXNyTXJrYmJ3YmlY?=
 =?utf-8?B?RUVoN1hBaXJybG14ZGlMRnliOGsrUFpqbE9RN3RYNkRVVm5PemdqMkZhV2pq?=
 =?utf-8?B?cC9JZWpRZFVXdHo1L0dpRmhVV3I1V0N0NzhlRUZLR1ZtR0RvWDVLQjR2QVp4?=
 =?utf-8?B?eXY3OW9lbFkxR0V5U3BObFBBYTFKb01MVVFHbjZpeUNKWW9kY00weU8zb1p2?=
 =?utf-8?B?dDJML0JESjRZSkJia3U3R1k2QjJ2eG4wbGlKSVpXdEpoZU1BbEp6aUQvVzZr?=
 =?utf-8?B?cEU5OFMzbjVURmw0U1RFWkJWR2xSY0NMNitvUVJpVUtGUzhmZ2NWOUpIbjFU?=
 =?utf-8?B?Rjh5QlY5enVuSDRRNWVJNC92K3JBemxkVm4rOU9LbEN5N3RySmtJK1prMG9C?=
 =?utf-8?B?bzZFMXF3SSsxbUthZ3Y3YjhwZXMwbVFyZjF1L0Q3OTN3NXBzTXBXb0tjOE1C?=
 =?utf-8?B?UGpQWUJrUElDNnNHQmFSWlZ6TjV4TFBJZ1ZucW1TTXk4bloyNlBYV1lGbjEy?=
 =?utf-8?B?VEZRcFRCbXMyWFJGWnM2Si80RHIwajZQY09sWHZxN2E3dTdtdkRVSDJQYitT?=
 =?utf-8?B?bDBMZ0lCaVBTZXhVRFZvVXEvc25Nc01qbjRSYVpSZmtqemNxSmZ4Kzc1eTl6?=
 =?utf-8?B?R2R2TXVtYi9rK3J1aytNWXd1ZnkxSnpNN0dPQ3JJdzZYbEhSdEpJc2JRczVs?=
 =?utf-8?B?WjVuN1QvNTJQK1NPOWlIcmJ3NVJNRjhsbGRyeUdBRVh2MEMyblhEQUxzVyto?=
 =?utf-8?B?STY2SlVkakdwS1I5K29VeHNtNW9lOThvb0JMRlYxViswSHVrS2NjaUxYbGxh?=
 =?utf-8?B?cjBteXNYS01Xd2RhWktnbVRvSW4xN1dtUzJZOXU0SjNMVDUxcUxEYWtUQnpC?=
 =?utf-8?B?cWkwbU1GOWY4emFGM3dTelhickpodVpOVThOQnE3a0FHY2JIT2dheEJMNlZq?=
 =?utf-8?B?bUcybnZXbTM2cVRyekQ2SFVLSVdOamNWREhJMS9VM0VnczVuaGtaN0h4ZWR1?=
 =?utf-8?B?RmJJRktSQURueEFDS3ArdTAveG5CSTBnL3h1YlFqdHJSMlBZeE1YMkkvS0k3?=
 =?utf-8?B?NHlKc2ljVXp5aHRMTDVpM0JoV251WmROMWUxbnBrOGNUcEdnRy8vNFg0c2tv?=
 =?utf-8?B?ZENDN3hMQnAzOFpDelVObWVaYUpScGluR2tOT0xxdkp3SXhoR2k5Qmk0eHlL?=
 =?utf-8?B?L2NoVGlGSHVxbzI4Z2tVb2NuNzZzL2hXdGFkd3B6dnNLNE8zaW0vM25PTUwx?=
 =?utf-8?B?NkNnUDc3SXJSUlprbG1QaEJNNDVLb2d6VFpLWTFvL1phSG5xZnQ5SWFFcjJY?=
 =?utf-8?B?clFhaGx5angyMFFlT3VlOUo5ZWJvMVFYaHo3dHQ0QU1tdmxiVUdzSE9zUjY3?=
 =?utf-8?B?dStPZDRMSDcwZ284L1pZMkdxTlBUN0pmY09PcFFmaE82ZkVlQkFkUlJwcGlZ?=
 =?utf-8?B?SFMwMGczMHpPNDhPTEU5djZOaHN4S3NldEx1azFOYk9jWmswWW9BQkU0aldU?=
 =?utf-8?B?V0NhNFFtSGV2SG9kWXdkR1U3MGQzNTM0UzJ2QXhTY28yQldqOVZzVUtzcktC?=
 =?utf-8?B?QStGUy93em5ONEtnYWFLNkVNQWZ0OTVscU5HbE9rUHUrdzAxckpaZVkwaE1n?=
 =?utf-8?B?VlVCMUQ5SFhvVkVzdW5DQ0pSYWZyMjR1NHNZM2Q3eTBrWFRBa2IvTklDNUt5?=
 =?utf-8?B?eXBWSnY2cmc3MU92ejJmVlZlM2FFcHoxWU9aSE4vS1Awc2ZUb1llYVhFazFs?=
 =?utf-8?B?M3pDQ2c2VDJxT3lHelFaSWtiL3N2U3U0M0JBQXdzWms3TWxBa0FFTHNZejhJ?=
 =?utf-8?B?Y3BGdHZFZzN4L2ZYbG5NeC9UbDhpQlNCL3V2aEZhZGkrb2JVc0hmWWpPYnh0?=
 =?utf-8?B?KzJuRHZVTUN1WEpydXRXVU9QSm11c2c0QUhvUmlUMDNWZjZMV0RRMlgzTmF4?=
 =?utf-8?B?RmM4Q2lzSzUvQ1NYdll3dVJadzJLay82TEhTRGlseTJSNFMyWUJ1NTQxVkpq?=
 =?utf-8?Q?Ec0c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4ce773-3a5d-45b6-578b-08dd15f2ef24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 12:38:49.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92/vv6DEgRn+tLnjCgXXkw1L0bFeNPcYiSKoHktoZ6Dd+17u56+y7cHq/IOomrKJn6pEHUrkNuYrCv9dVHZoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10371

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDbml6UgMjA6MzINCj4gVG86IFdlaSBG
YW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFu
b2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29t
PjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJh
QGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNv
bT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiBSRVNFTkQg
bmV0LW5leHQgMi81XSBuZXQ6IGVuZXRjOiBhZGQgVHggY2hlY2tzdW0NCj4gb2ZmbG9hZCBmb3Ig
aS5NWDk1IEVORVRDDQo+IA0KPiBPbiBGcmksIERlYyAwNiwgMjAyNCBhdCAxMDo0Njo0OUFNICsw
MDAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAy
MDI05bm0MTLmnIg25pelIDE3OjM3DQo+ID4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5j
b20+DQo+ID4gPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBW
bGFkaW1pciBPbHRlYW4NCj4gPiA+IDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXJrIFdh
bmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+ID4gPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+ID4gPiBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+ID4gPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiA+ID4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NiBSRVNFTkQgbmV0LW5leHQgMi81XSBuZXQ6IGVuZXRjOiBhZGQgVHgNCj4gPiA+IGNoZWNr
c3VtIG9mZmxvYWQgZm9yIGkuTVg5NSBFTkVUQw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRGVjIDA0
LCAyMDI0IGF0IDAxOjI5OjI5UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiBJbiBh
ZGRpdGlvbiB0byBzdXBwb3J0aW5nIFJ4IGNoZWNrc3VtIG9mZmxvYWQsIGkuTVg5NSBFTkVUQyBh
bHNvDQo+ID4gPiA+IHN1cHBvcnRzIFR4IGNoZWNrc3VtIG9mZmxvYWQuIFRoZSB0cmFuc21pdCBj
aGVja3N1bSBvZmZsb2FkIGlzDQo+ID4gPiA+IGltcGxlbWVudGVkIHRocm91Z2ggdGhlIFR4IEJE
LiBUbyBzdXBwb3J0IFR4IGNoZWNrc3VtIG9mZmxvYWQsDQo+ID4gPiA+IHNvZnR3YXJlIG5lZWRz
IHRvIGZpbGwgc29tZSBhdXhpbGlhcnkgaW5mb3JtYXRpb24gaW4gVHggQkQsIHN1Y2gNCj4gPiA+
ID4gYXMgSVAgdmVyc2lvbiwgSVAgaGVhZGVyIG9mZnNldCBhbmQgc2l6ZSwgd2hldGhlciBMNCBp
cyBVRFAgb3IgVENQLCBldGMuDQo+ID4gPiA+DQo+ID4gPiA+IFNhbWUgYXMgUnggY2hlY2tzdW0g
b2ZmbG9hZCwgVHggY2hlY2tzdW0gb2ZmbG9hZCBjYXBhYmlsaXR5IGlzbid0DQo+ID4gPiA+IGRl
ZmluZWQgaW4gcmVnaXN0ZXIsIHNvIHR4X2NzdW0gYml0IGlzIGFkZGVkIHRvIHN0cnVjdA0KPiA+
ID4gPiBlbmV0Y19kcnZkYXRhIHRvIGluZGljYXRlIHdoZXRoZXIgdGhlIGRldmljZSBzdXBwb3J0
cyBUeCBjaGVja3N1bQ0KPiBvZmZsb2FkLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEZyYW5r
IExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQ2xhdWRpdSBNYW5v
aWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gLi4uDQo+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjX2h3LmgNCj4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjX2h3LmgNCj4gPiA+ID4gaW5kZXggNGI4ZmQxODc5MDA1Li41OTBiMTQxMmZhZGYgMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
Y19ody5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0
Yy9lbmV0Y19ody5oDQo+ID4gPiA+IEBAIC01NTgsNyArNTU4LDEyIEBAIHVuaW9uIGVuZXRjX3R4
X2JkIHsNCj4gPiA+ID4gIAkJX19sZTE2IGZybV9sZW47DQo+ID4gPiA+ICAJCXVuaW9uIHsNCj4g
PiA+ID4gIAkJCXN0cnVjdCB7DQo+ID4gPiA+IC0JCQkJdTggcmVzZXJ2ZWRbM107DQo+ID4gPiA+
ICsJCQkJdTggbDNfc3RhcnQ6NzsNCj4gPiA+ID4gKwkJCQl1OCBpcGNzOjE7DQo+ID4gPiA+ICsJ
CQkJdTggbDNfaGRyX3NpemU6NzsNCj4gPiA+ID4gKwkJCQl1OCBsM3Q6MTsNCj4gPiA+ID4gKwkJ
CQl1OCByZXN2OjU7DQo+ID4gPiA+ICsJCQkJdTggbDR0OjM7DQo+ID4gPiA+ICAJCQkJdTggZmxh
Z3M7DQo+ID4gPiA+ICAJCQl9OyAvKiBkZWZhdWx0IGxheW91dCAqLw0KPiA+ID4NCj4gPiA+IEhp
IFdlaSwNCj4gPiA+DQo+ID4gPiBHaXZlbiB0aGF0IGxpdHRsZS1lbmRpYW4gdHlwZXMgYXJlIHVz
ZWQgZWxzZXdoZXJlIGluIHRoaXMgc3RydWN0dXJlDQo+ID4gPiBJIGFtIGd1ZXNzaW5nIHRoYXQg
dGhlIGxheW91dCBhYm92ZSB3b3JrcyBmb3IgbGl0dGxlLWVuZGlhbiBob3N0cw0KPiA+ID4gYnV0
IHdpbGwgbm90IHdvcmsgb24gYmlnLWVuZGlhbiBob3N0cy4NCj4gPiA+DQo+ID4gPiBJZiBzbywg
SSB3b3VsZCBzdWdnZXN0IGFuIGFsdGVybmF0ZSBhcHByb2FjaCBvZiB1c2luZyBhIHNpbmdsZQ0K
PiA+ID4gMzItYml0IHdvcmQgYW5kIGFjY2Vzc2luZyBpdCB1c2luZyBhIGNvbWJpbmF0aW9uIG9m
IEZJRUxEX1BSRVAoKSBhbmQNCj4gPiA+IEZJRUxEX0dFVCgpIHVzaW5nIG1hc2tzIGNyZWF0ZWQg
dXNpbmcgR0VOTUFTSygpIGFuZCBCSVQoKS4NCj4gPg0KPiA+IEdvb2Qgc3VnZ2VzdGlvbiwgSSB3
aWxsIHJlZmluZSBpdCwgdGhhbmtzLg0KPiANCj4gVGhhbmtzLiBJIGZvcmdvdCB0byBtZW50aW9u
IHRoYXQgeW91IHdpbGwgbGlrZWx5IGFsc28gbmVlZCB0byBhZGQNCj4gY3B1X3RvX2xlMzIgYW5k
IGxlMzJfdG9fY3B1IHRvIHRoZSBtaXguDQo+IA0KDQpJIHRoaW5rIEkgd2lsbCB1c2UgdTggaW5z
dGVhZCBvZiAzMi1iaXQsIGJlY2F1c2UgSSBkb24ndCB3YW50IHRvIGFmZmVjdA0KdGhlIGV4aXN0
aW5nICd1OCBmbGFnJy4gQW5kIHU4IGlzIGdvb2QgZW5vdWdoLg0KDQo+ID4gPiBPciwgbGVzcyBk
ZXNpcmFibHkgSU1ITywgYnkgcHJvdmlkaW5nIGFuIGFsdGVybmF0ZSBsYXlvdXQgZm9yIHRoZQ0K
PiA+ID4gZW1iZWRkZWQgc3RydWN0IGZvciBiaWcgZW5kaWFuIHN5c3RlbXMuDQo+ID4gPg0KPiA+
ID4gLi4uDQo+ID4NCg==

