Return-Path: <netdev+bounces-148939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2E9E390B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A089F164BA6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C831AE863;
	Wed,  4 Dec 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1+V2Vas"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897691AF0C1
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312491; cv=fail; b=iTJyIvBqmqBQUfzoLiOhmjg9VSVtObTmjqEhEil5SINcNbFy3UNZMHQ+fbuIdCyZ7zWL6VAiUQZlhyFyAxtuoL/y+2Pny0XMUJuUhzzTcmI522QdOmE8K8n8z+Pm2ComvutnhVuQKDuOXWEbsXPBA4P3UtDMX/OHfez5+VGsRpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312491; c=relaxed/simple;
	bh=BuGH+yrlBnmoWGb8UCoaRTKSlBsOa5eZMN4SyNPvQz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GRjjPeLzJmXFBS4zgrvyq7xuzQlvPhCFyR9egDCmiPVSxk6qKvHQe8GAyGHEqObG9YcECcsiRStky5E68L6kDLMK7bXCuV98juUxi3owwH0AKrwjUizvRoMNbH6CaAvxHjQLxSbkV5U73wWW05Zi2AVQVgsEX1opd/bQmQPPujQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1+V2Vas; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H31DBGqdnXQ3VT35e6rrjGIfmE7HXV9xTlnYP7puSkq6VmLX/sPLV0RC9V369C6B8o5D0QAyARZoLzgOYCWxhD8uKzCuGTufGLTxCKUI2J8h83bP2W5gnQPcczlPCSQX2Os8xFaIhnu7b6ACtTEoS0UI5LWkQN/2eeISSH87Nd0k+idr9D8wYbFYmNsaXwms7gBnqiDybhxsopBC3rXnG8zY/CoRCvdqTbN+il62DFGIwnPYeOh8YnTQzaXz5QZvT2mWm/OUwW+OCoxwh9XwfaSXY/42ZX+i8c3CV5I2j+6o9qHAjGiG2/IMR2EknotCIwXpMZSJ+Uq5oX14CLHcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rza794I+Zo4p2nQ1u4y4kX0BtSFqTVS+alOZP4wcR4=;
 b=QHasJXqm6BgNdLnOthDvFZGCCL8PhXQGIv+HZ2a9pSUX3NZh1ladWPZRHART+LomO9OdWCK29lahiOgKSwzWao1s8augRV6rEegSnH0QKNMeUbhWNXTLYObQ2VdiyuIrIMtBrraz5ddoI9vqe7RUq9SEqY5kx9PWXQ5UM+IfCIxYiRvf6SsQ3sFgSbP45S/QuZBhe1agAryvpMl2Nz3rYg+5IR0ZY04EgWBK65bXhiEy7ZUBVQtnZLE1p+q6IW/NF+uSAUy65K4N3MokAQY0ZFT4pfvNggIWYh9vQdR9aU5g+dTVevnkVL9RzxF+upe0V6RQUd11yX9cW/BdRsNI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rza794I+Zo4p2nQ1u4y4kX0BtSFqTVS+alOZP4wcR4=;
 b=T1+V2VasjHwwl9QEvBGnyLMi396di3jjXXxA3vlhTX9twAnINN35gTohBPtSkwypKoQ5Ir9NAEFfpp/rRnwgd3aeLKX3rBkegiA9lC6y8f9xIx01fAf+xoj4qKMit0Dw1Dh6RUCU5AjjNP1mOCC0vW6/pZMIR85ie0ccAY2slb5iak8Z78eGGDRJiefbXAm4EM4lnizjL/dpRMftHTMHRHUECreffv8q/yzWy0Z4//Kk7EIRAqKKdkpEbs9YaGJCI4PAPdwsBVEbIGULdNzJpqSQFv6C6mH3ne3SBS8AhSdARA7CzZ0GaEu5QWwyJ6pNg4nKtvuNjAzueGewThktmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB8378.eurprd04.prod.outlook.com (2603:10a6:10:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 11:41:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 11:41:24 +0000
Date: Wed, 4 Dec 2024 13:41:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
Message-ID: <20241204114121.hzqtiscwfdyvicym@skbuf>
References: <20241203170933.2449307-1-edumazet@google.com>
 <20241203173718.owpsc6h2kmhdvhy4@skbuf>
 <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0110.eurprd09.prod.outlook.com
 (2603:10a6:803:78::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 21942c84-8bb9-4c3c-0c03-08dd145894ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R01sRzRCcmllZ0dSc01nL0JDTmdxVEw0cFgyVzExb0VOYU11dTZGUmpLYW5R?=
 =?utf-8?B?K09QNzgzYWw1RHZpdVhidWpKQjlHME93TVhsd2RNU2VoejhXbU95ZHdKNHF6?=
 =?utf-8?B?RWU3NzJ4cktPZjBZRUYyR0pCUHlSa1ZuREk2cThNdzhqVk40ZjlZNEJOYzFQ?=
 =?utf-8?B?dFlFU21DTEVQL3liN0tTUHlGNDl3MzVDOE5QakF3d1l2MFVwTWYycUtmVkRz?=
 =?utf-8?B?WS9DUFJRVnpXWFRmQXVvZWxZdHRNQWM1ckhOVXV3YkFkaXVnMVBZYUtLa2dv?=
 =?utf-8?B?MzVvd3FnM0VRemJUdjJNbElOK0hEc09ncjFPNi9BMTFuSkZMaEZJdXRCNjMv?=
 =?utf-8?B?cVM4R0JIL3EzZGN6WngxZzNYWjRNTUFpR1RxcVhHaDNiMHZqSTB6YUtnRmZY?=
 =?utf-8?B?WWliQjlJU3pkYVppRTZTUXRVa1ZZWU9ROHVGZlozZWRwWUdnNkJTK0pqaE5s?=
 =?utf-8?B?T3I0UVc5dDB5MmNISWpZekpEbnMxbDRQT3d1RGdzcFZkblYyM2o2Y2dodkFG?=
 =?utf-8?B?aXkvYVkwR1BNYzFDRWJmSG1LdjdndlVROUY1dXdCU0ZQY3pWZ3lRdFdTczRL?=
 =?utf-8?B?L1VIK1ZGRlQvRG8zeFJyOElRbGRxUUx4NklIVjQ3QXlBQTl4NWNRQi9ZclBh?=
 =?utf-8?B?TFJ5NTQra0tIZzJzamFESmlIQU5FdHcrd3VSUTJPck5oT0JlUnpOV2ZzZEtq?=
 =?utf-8?B?cUMzVVo0elUvUzUvZzdKdmxwcXJ5QXR1MHFjZk1wb2t3STJHL2cyNkxmSS9W?=
 =?utf-8?B?TjdJT091cUdEV3RrRXU0dmFPSVNWeExKd2s4NFl2RlpjNTFQbTV5TUVMSDJ5?=
 =?utf-8?B?T1I4Q2JJV1VXWjY2akJHQTF5TVRmT05STlNtREVTNURCSXZQT3lMS3FveDNm?=
 =?utf-8?B?OU1mQzI2MjBjY0pkYnowakVjaHZrV2JEVHZzRmZ2STUrTG1sVGZzT09FeXUv?=
 =?utf-8?B?U3NVQVczdzJOL05GYlduUmtkWmhFRDFjbnl1blltM0RrK2RNZHhDRFg4MlhG?=
 =?utf-8?B?VWVrenhMSjhIYTg3WTlHSWR6RStESjV0ZTIzWk9NLzR0azlMSzcwVVg3cFNu?=
 =?utf-8?B?RlZIVTN3c09kYlNpcnIvYWhmdUZRa0xuQVVtNk9JdW1EclcrU0RUMDJ1ZE00?=
 =?utf-8?B?THU2cmRlOFJTSmMxYW53Y1VpS0VveTg5U0NPNGhNZkpaRjdTVVl2QkkrUzcz?=
 =?utf-8?B?cG4vaVEzZUJWcjZLRUdibkNkcUIvWTI0YlZVQ0hMTnVLeExWS1RxeWhMdHhr?=
 =?utf-8?B?Wlk3QkpFMVE3SnM3VGJDQ1czRUc1cVFoNnJramFLdG93Zzg3WVJSRGtycER1?=
 =?utf-8?B?dXIvbWNnMmIwSWtJZCtyUmhaV1JOR08ydDV2bkpCRlFvYjhRdkdBQnhxSVBZ?=
 =?utf-8?B?VGNyRVI3UzFhMEFCamRCYjh6bUpMQWVCYXl3NTh4dnVHQ01ISks3Z0QxOHIz?=
 =?utf-8?B?d2IwbStGZ2JrY2YxMHBmVDhGY2NNM2k4WFNwNUk1bm92K3VnOGRzVGo4bzNP?=
 =?utf-8?B?dmUzZDM2cWFuMlV1VnZnVkJDMmlxQnJTTEhQUm5GQ25kcG1Mb2ZqcEd1QUFp?=
 =?utf-8?B?bTJLV0JzTy9qbUlQem5CZ2NFUXo0Q2lGdDBmSitwdFRCcVoxNDJiZG5JSElF?=
 =?utf-8?B?Wk1Kb3JjUnlWalBranpTcXgwMDRhdTFVS2hZYnRjWjZzbEl0a0FZVWNjWDhR?=
 =?utf-8?B?ZXA1NEFJa2p4b3FBalo2TjUxQ1pBOEdyZTBUaXF1VEJ1Tmdub04yTWF3ZSti?=
 =?utf-8?Q?j1R21XQ1eAPA3lI+gI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M25MRWhWU05qVTlybVRVSzR0OXVlenJ5ZmNMc2tIRUVtUGQ1UHhyWUFPZHpv?=
 =?utf-8?B?M1RHcC9jVUNmN3BWbk4rUldJcllTeE5aM2UzaHRXcmo3NWFsN2RyekNyQUtm?=
 =?utf-8?B?d3loRGZxUGM1QVhDczlsUGc5UkRhYWkzZlgrYklmWUJRVHQzeUY0MStMVDUr?=
 =?utf-8?B?ZVQ0ZzgxUWVBQ01LbkFRTzZXbjdWSndPVjBsZ09aZGNmd0htQmNTb3pYREFV?=
 =?utf-8?B?MDNQNVBGV2FyVENhK2wydDFCSmg2OUVHMUV3aWpLcmkwT3pOeVR4aUpEckh6?=
 =?utf-8?B?MUtrNFFockI3ckNUdUlEZWt2T1JNeG1OUUVBcjY1UHpWWVhISXZOTGcwYTZV?=
 =?utf-8?B?Z0t6dk9xSS9qZVdQTUJiZVUwd3NkSnExWmo3Qk5SOU5zbEE0MkpFdGg4bjJD?=
 =?utf-8?B?cDZ5NGhDZU9jK3huMWRFMEx2aW5aQURFMWVmVXlVSmpPV3ZvUkVsQ2g1WjlQ?=
 =?utf-8?B?RFBWT3dFRTZrOE5YdEs1U1pISGZlRm55TGtuVHduZHJhZXVQS25BdGd5N2o4?=
 =?utf-8?B?VUNveEJzSHdWV2VnSGo0N2lqNHJ3R1NEZDlZS05XN2Y5QldpSWFSd0c1TVhi?=
 =?utf-8?B?eHBZR2ZpcFJjQkhja0NiNzZwVUExTUJqY0p2MVpYNGJrVnl3eHJVYmwvZEVq?=
 =?utf-8?B?T3JSeEVNOG9YeDRGZ0tlY2RFSkRDTTlEZmV1YnhFOXREOHFrcEQ4TlFMWFlT?=
 =?utf-8?B?UG1odEpXSmNkcy85Wm42cVZuelRRMDJjR0F4cW1XOXYwcGtwaGJGeU9XVDFO?=
 =?utf-8?B?S3U3SzlVVTQ1MVNOaUVUaGlDQ3JsQTFEUG1Eblk1cG1zRDdMTW9rZHBYOTFG?=
 =?utf-8?B?YjY0V3VRYXdMLy9ENmZKKzFCNXRMaTdpTmpnYzJzeU4rei8waEhadlF3c2pP?=
 =?utf-8?B?djI4dEpHMEdpTHJwdUVGVXBMSmdvaXdvRDF6VDQvZWJDL2dGUWtsSzNIckQ0?=
 =?utf-8?B?SUxtelhPN1hDS2prRVRCZ2MvSG81NHdCME0xNTRmbVU2bXk5Ri9Ka1IxT2ZV?=
 =?utf-8?B?NXp6dHJhdW42RWNQMkZ5dDAvcnhOZDM3RkUrYU53ek1WS3Y0d0crV0lLVHp1?=
 =?utf-8?B?a2FwK3BNV2MzNnpuSnpSeGZvNGgrOFl0QzJCVUtZQ2dJaHFIa0N0cUlHVDlH?=
 =?utf-8?B?K0lyQm16aVRQRHRiVWFTNTFyaEdUZndlYWp1ZklDMTBQTmt5VjBtdHU3Qzd2?=
 =?utf-8?B?Sjc0bUlsN1FzZHIzbjdYQUNHa3pvaVkweDNpK3Raa2FyNnREY3lUZEFSWlpH?=
 =?utf-8?B?NUpLWmQwWGpqd0NIMURtVS9JV2dBOUcwVWpuN1RKZHlYTldKRVNUclNtcjdz?=
 =?utf-8?B?S2JJYXRnZStPRjRub1VyM28wWnB6MHpxbzJ4M1ZDTER2Q2lUVDYvQ0IzbElM?=
 =?utf-8?B?S0hkNXhzRGxZeHQ1a0s5a1NDVi9sQmRHN1RPdTZwZ1JlMm5FVEFuWkdqS2xK?=
 =?utf-8?B?NE5hbjlMSDM5ZXlTZS9NQUxrMUV4cFRWWlh0S3VrMWZuQU4zbEFBdzNobWh4?=
 =?utf-8?B?N3hJejhmV2ttSjlFb255R0dZWlBMOGtQQmJPZDNmQzk4NzZRNE4xcnNlL0oz?=
 =?utf-8?B?UjNlM003OHNQZU5qVkxhb2ptTzBuTFVGbjlZYUhLS1FvNUJuUzlwYVpTSjZE?=
 =?utf-8?B?bFkvMXFtdmhNZDJpRlhBQ3FZS2M2Z2tSRS91RHdmQ3R3cTlSVUVVeVVNUERh?=
 =?utf-8?B?S1pyS2tVeUJCUzhNVTBhR3h6VCtnQVFhRXBxUzh3U3dVMEluMnBCQVNZY1dM?=
 =?utf-8?B?TGRZTzBTdzBiN0EzNFU0Wmx0ZTVjMmxxTmdtSGhkc0luL3VPVnNyN0F1cFZl?=
 =?utf-8?B?NHQzR0NLaytqUVlzM1ZLVGh1bitGZmVCU3VYNHo5eUwyR0dZMVBjMFU3elpv?=
 =?utf-8?B?ejZhcTRNenVaUVFweWpSZnlpU3pRMnpwUlZrak1odlpZbUNUR3dBV2Y2WFlo?=
 =?utf-8?B?cERVaFl6YWoyczEzeUVXRkVxZjBwZ1A0a2NVVW0rNXQwbnNLU093RWR0b0xh?=
 =?utf-8?B?bFg0elF1M2c4V3loMFFjL1VsTlZDNlFqNDJUUWVnS1ZzK1I5d2hrMXhwV2hI?=
 =?utf-8?B?TFlMb0FLQ3BSMWVrbzdPODZZWGNFNHBzcVE2NXNhdnFkckZrNnN1Z3VsL0t3?=
 =?utf-8?B?WlZmVDBRNS9xQkFWa3hvVU5YVTFWeGZZb2Z2dkJxaU83VXRqUUNsMFRqWWJX?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21942c84-8bb9-4c3c-0c03-08dd145894ea
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:41:24.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPCz2F412XLJEjVJyNsrdLmwPH1oCmHTk4AhtlWSrioczp9PGNnioN9+UMU1V8qjGpPG4vkak1g8JISPI8uwdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8378

On Tue, Dec 03, 2024 at 06:56:09PM +0100, Eric Dumazet wrote:
> On Tue, Dec 3, 2024 at 6:37â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > Hi Eric,
> >
> > On Tue, Dec 03, 2024 at 05:09:33PM +0000, Eric Dumazet wrote:
> > > syzbot reported an UAF in default_operstate() [1]
> > >
> > > Issue is a race between device and netns dismantles.
> > >
> > > After calling __rtnl_unlock() from netdev_run_todo(),
> > > we can not assume the netns of each device is still alive.
> > >
> > > Make sure the device is not in NETREG_UNREGISTERED state,
> > > and add an ASSERT_RTNL() before the call to
> > > __dev_get_by_index().
> > >
> > > We might move this ASSERT_RTNL() in __dev_get_by_index()
> > > in the future.
> > >
> > > [1]
> > >
> > > BUG: KASAN: slab-use-after-free in __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
> > > Read of size 8 at addr ffff888043eba1b0 by task syz.0.0/5339
> > >
> > > CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >   __dump_stack lib/dump_stack.c:94 [inline]
> > >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > >   print_address_description mm/kasan/report.c:378 [inline]
> > >   print_report+0x169/0x550 mm/kasan/report.c:489
> > >   kasan_report+0x143/0x180 mm/kasan/report.c:602
> > >   __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
> > >   default_operstate net/core/link_watch.c:51 [inline]
> > >   rfc2863_policy+0x224/0x300 net/core/link_watch.c:67
> > >   linkwatch_do_dev+0x3e/0x170 net/core/link_watch.c:170
> > >   netdev_run_todo+0x461/0x1000 net/core/dev.c:10894
> > >   rtnl_unlock net/core/rtnetlink.c:152 [inline]
> > >   rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
> > >   rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3520
> > >   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
> > >   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
> > >   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
> > >   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
> > >   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
> > >   sock_sendmsg_nosec net/socket.c:711 [inline]
> > >   __sock_sendmsg+0x221/0x270 net/socket.c:726
> > >   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
> > >   ___sys_sendmsg net/socket.c:2637 [inline]
> > >   __sys_sendmsg+0x269/0x350 net/socket.c:2669
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f2a3cb80809
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f2a3d9cd058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > > RAX: ffffffffffffffda RBX: 00007f2a3cd45fa0 RCX: 00007f2a3cb80809
> > > RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000008
> > > RBP: 00007f2a3cbf393e R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 00007f2a3cd45fa0 R15: 00007ffd03bc65c8
> > >  </TASK>
> >
> > In the future could you please trim irrelevant stuff from dumps like this?
> 
> I prefer the full output, it can be very useful. It is relevant to me at least.

I mean the kasan, dump_stack and mm portion from the stack traces,
as well as the register dump, are pretty much irrelevant. They make
navigating the useful portion of the kasan splat more difficult.

> > > Allocated by task 5339:
> > >   kasan_save_stack mm/kasan/common.c:47 [inline]
> > >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> > >   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
> > >   kasan_kmalloc include/linux/kasan.h:260 [inline]
> > >   __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
> > >   kmalloc_noprof include/linux/slab.h:901 [inline]
> > >   kmalloc_array_noprof include/linux/slab.h:945 [inline]
> > >   netdev_create_hash net/core/dev.c:11870 [inline]
> > >   netdev_init+0x10c/0x250 net/core/dev.c:11890
> > >   ops_init+0x31e/0x590 net/core/net_namespace.c:138
> > >   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
> > >   copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
> > >   create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
> > >   unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
> > >   ksys_unshare+0x57d/0xa70 kernel/fork.c:3314
> > >   __do_sys_unshare kernel/fork.c:3385 [inline]
> > >   __se_sys_unshare kernel/fork.c:3383 [inline]
> > >   __x64_sys_unshare+0x38/0x40 kernel/fork.c:3383
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Freed by task 12:
> > >   kasan_save_stack mm/kasan/common.c:47 [inline]
> > >   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
> > >   poison_slab_object mm/kasan/common.c:247 [inline]
> > >   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
> > >   kasan_slab_free include/linux/kasan.h:233 [inline]
> > >   slab_free_hook mm/slub.c:2338 [inline]
> > >   slab_free mm/slub.c:4598 [inline]
> > >   kfree+0x196/0x420 mm/slub.c:4746
> > >   netdev_exit+0x65/0xd0 net/core/dev.c:11992
> > >   ops_exit_list net/core/net_namespace.c:172 [inline]
> > >   cleanup_net+0x802/0xcc0 net/core/net_namespace.c:632

Where is __put_net() called from? The timeline is not clear to me.

> > >   process_one_work kernel/workqueue.c:3229 [inline]
> > >   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> > >   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> > >   kthread+0x2f0/0x390 kernel/kthread.c:389
> > >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >
> > > The buggy address belongs to the object at ffff888043eba000
> > >  which belongs to the cache kmalloc-2k of size 2048
> > > The buggy address is located 432 bytes inside of
> > >  freed 2048-byte region [ffff888043eba000, ffff888043eba800)
> > >
> > > The buggy address belongs to the physical page:
> > > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43eb8
> > > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > > flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
> > > page_type: f5(slab)
> > > raw: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
> > > raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
> > > head: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
> > > head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
> > > head: 04fff00000000003 ffffea00010fae01 ffffffffffffffff 0000000000000000
> > > head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5339, tgid 5338 (syz.0.0), ts 69674195892, free_ts 69663220888
> > >   set_page_owner include/linux/page_owner.h:32 [inline]
> > >   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> > >   prep_new_page mm/page_alloc.c:1564 [inline]
> > >   get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
> > >   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> > >   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> > >   alloc_slab_page+0x6a/0x140 mm/slub.c:2408
> > >   allocate_slab+0x5a/0x2f0 mm/slub.c:2574
> > >   new_slab mm/slub.c:2627 [inline]
> > >   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
> > >   __slab_alloc+0x58/0xa0 mm/slub.c:3905
> > >   __slab_alloc_node mm/slub.c:3980 [inline]
> > >   slab_alloc_node mm/slub.c:4141 [inline]
> > >   __do_kmalloc_node mm/slub.c:4282 [inline]
> > >   __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4295
> > >   kmalloc_noprof include/linux/slab.h:905 [inline]
> > >   sk_prot_alloc+0xe0/0x210 net/core/sock.c:2165
> > >   sk_alloc+0x38/0x370 net/core/sock.c:2218
> > >   __netlink_create+0x65/0x260 net/netlink/af_netlink.c:629
> > >   __netlink_kernel_create+0x174/0x6f0 net/netlink/af_netlink.c:2015
> > >   netlink_kernel_create include/linux/netlink.h:62 [inline]
> > >   uevent_net_init+0xed/0x2d0 lib/kobject_uevent.c:783
> > >   ops_init+0x31e/0x590 net/core/net_namespace.c:138
> > >   setup_net+0x287/0x9e0 net/core/net_namespace.c:362
> > > page last free pid 1032 tgid 1032 stack trace:
> > >   reset_page_owner include/linux/page_owner.h:25 [inline]
> > >   free_pages_prepare mm/page_alloc.c:1127 [inline]
> > >   free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
> > >   __slab_free+0x31b/0x3d0 mm/slub.c:4509
> > >   qlink_free mm/kasan/quarantine.c:163 [inline]
> > >   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
> > >   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
> > >   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
> > >   kasan_slab_alloc include/linux/kasan.h:250 [inline]
> > >   slab_post_alloc_hook mm/slub.c:4104 [inline]
> > >   slab_alloc_node mm/slub.c:4153 [inline]
> > >   kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
> > >   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
> > >   alloc_skb include/linux/skbuff.h:1323 [inline]
> > >   alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
> > >   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
> > >   sock_alloc_send_skb include/net/sock.h:1797 [inline]
> > >   mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
> > >   add_grhead net/ipv6/mcast.c:1850 [inline]
> > >   add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
> > >   mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
> > >   ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2245
> > >   addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4342
> > >  addrconf_dad_work+0xdc2/0x16f0
> > >   process_one_work kernel/workqueue.c:3229 [inline]
> > >   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> > >
> > > Memory state around the buggy address:
> > >  ffff888043eba080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff888043eba100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >ffff888043eba180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >                                      ^
> > >  ffff888043eba200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff888043eba280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >
> > > Fixes: 8c55facecd7a ("net: linkwatch: only report IF_OPER_LOWERLAYERDOWN if iflink is actually down")
> > > Reported-by: syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/674f3a18.050a0220.48a03.0041.GAE@google.com/T/#u
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > ---
> > >  net/core/link_watch.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> > > index ab150641142aa1545c71fc5d3b11db33c70cf437..1b4d39e38084272269a51503c217fc1e5a1326eb 100644
> > > --- a/net/core/link_watch.c
> > > +++ b/net/core/link_watch.c
> > > @@ -45,9 +45,14 @@ static unsigned int default_operstate(const struct net_device *dev)
> > >               int iflink = dev_get_iflink(dev);
> > >               struct net_device *peer;
> > >
> > > -             if (iflink == dev->ifindex)
> > > +             /* If called from netdev_run_todo()/linkwatch_sync_dev(),
> > > +              * dev_net(dev) can be already freed, and RTNL is not held.
> > > +              */
> > > +             if (dev->reg_state == NETREG_UNREGISTERED ||
> > > +                 iflink == dev->ifindex)
> > >                       return IF_OPER_DOWN;
> > >
> > > +             ASSERT_RTNL();
> > >               peer = __dev_get_by_index(dev_net(dev), iflink);
> > >               if (!peer)
> > >                       return IF_OPER_DOWN;
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >
> >
> > Thanks for submitting a patch, the issue makes sense.
> >
> > Question: is the rtnl_mutex actually held in the problematic case though?
> > The netdev_run_todo() call path is:
> 
> As explained in the comment, RTNL is not held in this case :
> 
>  /* If called from netdev_run_todo()/linkwatch_sync_dev(),
>  * dev_net(dev) can be already freed, and RTNL is not held.
>  */
> 
> In the future, we might change default_operstate() to use dev_get_by_index_rcu()
> and not rely on RTNL anymore, but after this patch, the ASSERT_RTNL() is fine.

Ah, ASSERT_RTNL() is only done if the reg_state is not NETREG_UNREGISTERED.
I misinterpreted the order of operations and thought it is asserted unconditionally.
My bad.

> >
> >         __rtnl_unlock();                                                <- unlocks
> >
> >         /* Wait for rcu callbacks to finish before next phase */
> >         if (!list_empty(&list))
> >                 rcu_barrier();
> >
> >         list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> >                 if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
> >                         netdev_WARN(dev, "run_todo but not unregistering\n");
> >                         list_del(&dev->todo_list);
> >                         continue;
> >                 }
> >
> >                 WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
> 
> // reg_state is set to NETREG_UNREGISTERING
> 
> >                 linkwatch_sync_dev(dev);                                <- asserts
> >         }
> >
> > And on the same note: does linkwatch not have a chance to run also,
> > concurrently with us, in this timeframe? Could we not catch the
> > dev->reg_state in NETREG_UNREGISTERING?
> 
> I guess we can add a READ_ONCE() on many dev->reg_state reads.
> 
> The race should not matter for linkwatch, if the device is going away.

I meant: linkwatch runs periodically, via linkwatch_event(). Isn't there
a chance that linkwatch_event() can run once, immediately after
__rtnl_unlock() in netdev_run_todo(), while the netdev is in the
NETREG_UNREGISTERING state? Won't that create problems for __dev_get_by_index()
too? I guess it depends on when the netns is torn down, which I couldn't find.

