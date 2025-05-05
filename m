Return-Path: <netdev+bounces-187736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A9AA94B7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CD617678C
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E32586EE;
	Mon,  5 May 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pRjFmGIx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7331E32C6
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452505; cv=fail; b=khl/jnzs3pWGseTPTeEGxl6MwjYAYlCWSS2tesl675UmU54GYZPVyl+AVkkq1Lc61zt09yfeZuXV4GNd5rnoVS8tz93dq99wjFbQUwTFS7YM633nll7ML3OMVT/dZAUKBGCR54onYl2QFuWu/Rvq6NMCIcZoTsPcl+inIkYVlbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452505; c=relaxed/simple;
	bh=miS+DBc+/6iUnpuBzvEkaaFBTIFekWyhblyW+VFNHGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LC1YpiqdzV+az+29trD12rYRtBtamGWi8uRmfeTPL1+FHy2fKXDonfK2rUC9h5TW1XuX+fcFBTM50/FPVbnO13fxL5Xi1PiXpftgBFqIt9ecUvM2gZ5rowDyvl9S0m0wnqAzAhcdm4eCMiG8v8Y6knN7uiFGE2T0E9Lg5vfQJyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pRjFmGIx; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4N7e8TudVZvpMppuErt3O3SHP7LxIiMJmqMtIB/GeIpmR/Pi6e8QNKHJlhf1QDnKHZsX7pWkQZGgdt9TjoAIRqGNYkSjknF5qmLw/Bx/SRa5Yiz95vsA9IbOFbDbgqb6AZXBvfNyjiZb04ViigmoquhGvl8xOhtLjPb6LhJZ3C5x4MKYQNg+G3jOZ4FmADKMCDT+HiFfsYjuua65oNbEH3gcIzXUSQruyvxTbN1cJ3BFKFv0DQE9u7B5nuJ9pvwXIeA7QRcC+wDuUSx+d1+Q/xL1rtlrYvu5/hfM324f1UwpwGLSWgPyUbkrEwlyidZ5NBxmdSqW/mBJu6RYsvU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miS+DBc+/6iUnpuBzvEkaaFBTIFekWyhblyW+VFNHGk=;
 b=hgez7QY3vQGuT5kSon7eDJQ6/ejeMbD8Jwi74Q/pdsYjOaXPnpg7P7S2e1AGO9Ydr+BSHaM9ZBYUhQWrHM1f6b/R1Kbk6h/8j+lObFEDBq73zYH2lVELTprkPmxAtk9vlz4+NfjDzefIOzqJHSjQ1vUEdi07HJKErZhha9bBHX9KI5L21RN0Gsc7IKIpAUSwMaTDn4mxW6QiT0rQp/m2p5cWeuv9o7UA0TbQM3mvBC7RSMQ8Ktvn6Dlp2RC8m1tD0gwwFZA7tWhJHNP/gXa2pzt8ngre8+7Aaj7xYWLHmkUvfB8oPMiXzWJpQ3iT64NlF7V2aPe0Jp1JmJn9RoUP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miS+DBc+/6iUnpuBzvEkaaFBTIFekWyhblyW+VFNHGk=;
 b=pRjFmGIxFNthxCo4B3GtfpjgWaTD6v5iihXmqzb2veCtWSJfRNoju1CC6NewdUngbm8XcOxUPRJFEtFalNRPtPPnYdKh4yXavBJo8+1L2RLHpuSnZkRp2PkuJUoycRRphMhpQzVTa/55OcTV9zFFUYCcC4IXTLQ5ZZjvc5upA/BEypf9ewOmBRC12a+btaWXDE5xInuqgCOXCZ5sPLfF/1iyU/+ej2W9QMGWDZN1FJSxjrNs0g/qzSkzVU38t2W3H3Dm7bdoU56flbLTWdceTf+Olz7WzVzGeqSIaZ7nnDlJAAM3wlp2w3ar0BFcHksDJBsXYSndgiyy/+kFSpM4ug==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:41:39 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8699.024; Mon, 5 May 2025
 13:41:39 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "saeed@kernel.org" <saeed@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Thread-Topic: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Thread-Index: AQHbje0DX5+rdJVuAUCwIzeB0fSvMrPEav8A
Date: Mon, 5 May 2025 13:41:39 +0000
Message-ID: <eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	 <20250305163732.2766420-5-sdf@fomichev.me>
In-Reply-To: <20250305163732.2766420-5-sdf@fomichev.me>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SA1PR12MB6749:EE_
x-ms-office365-filtering-correlation-id: fc0698a3-fd7d-4e4b-dd80-08dd8bda905b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjErLy9PODZ0MDkzdEYvM0ExQVo1MVFnNjJXU1pBNTB0dnUxUkVEM204dFg5?=
 =?utf-8?B?OWh5ZmNPb2tacGxWY2IyUGxtZG9HNG1jZ2xmWlYrcnlxNGVXSXpTSkxaTFds?=
 =?utf-8?B?RncrNWZvYmxzSTBRRTBxdTNmQ200YXBSQWZMWjdqWWlDU2tIVHM2WkpCMk9z?=
 =?utf-8?B?Um5mdEJPS3hjalRrcllaZis0RUJRdnJuS2Z0UmZreVRwVmVyWnhJdTNDT09Z?=
 =?utf-8?B?K1F2T1NkdzV0SmxvaTZMWTBqQlh3dlR3OC9BdDhxQ2ZCdzhpRUo2d255eFdL?=
 =?utf-8?B?ZzAvWnB5K0laemdJUjdGVUZFbmtSczNUaEQ4TGxCYk96SkozQ0ZZZlFIR0o5?=
 =?utf-8?B?cTZYTFpPK2puQk91czVQWm5FdnZWeWhLTktEWlV2Y1BMMVk1TWRRVllrYjZ4?=
 =?utf-8?B?UHdaakIrNG54aitIZm1rWU8vTmdLMjNsKzlnbU1NRlNYQWJzNFRiRlJvTERP?=
 =?utf-8?B?RDl5Qk9zTzI1L20ybUZ0OXVIN2JkVllQMUNDek10U2Z2b2hOdjFXbVF3allE?=
 =?utf-8?B?T2Jhb2VXWnFoNVB2N0JqazV4N25JNmFmUzMwcW5waUlCUktOVHdCQ1p6YTNL?=
 =?utf-8?B?V1pQMzErUVVJa0JlUWczU00yaDNnT0RVYUw0NlJkL1lCd1JqTDNLQlErQjA3?=
 =?utf-8?B?TUlhU3VWZDE1S3pNQkh1aUFZRUl1a2tZeHdVZ0toRngxcEluTGxmRjlCelFo?=
 =?utf-8?B?WkZ2bXMzdTh0WDFRV2RSVVVCVVluTVZHQldEbHB2em9rN2tJTHd3enQ1UEk4?=
 =?utf-8?B?bzQwTngwZ3NSeUdXWE5LN3MreGRWZSszcGpGRGRyWS82UGZ4SWJYY2xBUzBU?=
 =?utf-8?B?VzQxbFVTSWo1TFdLOElwYVQ5T3NqMllZNzU3cS9aV1hyeTF2eVlzLzB1SExr?=
 =?utf-8?B?QmhUS0ZpdVBIbmlFMVJlSTRtODZSZUU0c2Q2VFArTnZBZVlYTGlpSDBoRGNH?=
 =?utf-8?B?cFdxR0lVR3hQYXVITHhyYXVSQkg3NTV0T1BYMjBLQjlsRkRzYS9wNU05bGlD?=
 =?utf-8?B?dTNwTHFaVGVySTZSYWsyOVJCUnRVckdrOHpueWt4TXZ5a2lTOVdLQkwzV0Fx?=
 =?utf-8?B?YWQweG9hK3NHUWQ0K20xdnhxdmNJbXZqL3NVN1A2aVBQM1M0aWlRRE5pekpa?=
 =?utf-8?B?R1E0Yk9aM3pEYVE0RDNkcnhzQW9rQ003NVp5UmFIbVVQZjJtSUF0RTBLaDMr?=
 =?utf-8?B?T0FSNW9kTmVGdnhLTEY0b2dSZUQzdExadGZrdWM2RC9URWM4MGsyZzkzcFg1?=
 =?utf-8?B?VkpVeTVrK0hpRVIwOFZwcmJ3UmEwc3RKTEpDZjhmZ1dJaUx0VHhBNXQ2Z0Fx?=
 =?utf-8?B?cWRRUzl5clArenduNms5ZjBFNGlTMnBnaFlwc01HNUZON1RMY3RtNGVzQ0M5?=
 =?utf-8?B?ZSt4TzE0QzMxSG93UlRLcTV1ZS94YWJKaGFXaGJDRzFESlFJbFRtajN3WWRH?=
 =?utf-8?B?cThZTGpObk05K0NMd29TTnk0SlFxbjYweHB4WnVWNHdaQWZaVS9jeDJ5SXhy?=
 =?utf-8?B?cmxITWhIelV4elV6VkNHQ1NWTlFKd3loMkliOWVYdTI3M3BzSSsxMlZjSVds?=
 =?utf-8?B?Wkk4STFJdklYblZvcURDS2RramNSQ3hCQ3U3N0dUbDRWY3V1TEZVd2JidCs4?=
 =?utf-8?B?YnVYdXAzUlRtS0ZVUWZ0M3dEZmcrK1BRV2RWUnZ6djArTXpMOHAvYmFxSGhx?=
 =?utf-8?B?dkxsQTV3SkN6WTFkLzFoaUlHd1BEQTJxUEt2YnVpMHNFVU11OC80WU05UHpn?=
 =?utf-8?B?MERpNnZDSmdxcWExTjRyZXRhMUcxNVIzTmw2ODhHYTB4a1EyczJSL0ZqN1J3?=
 =?utf-8?B?TkdJMGlHRUZVVFJPRTk4M3lCeTRsOUZibzNvZXlSTUlQYzQrUXdxYjArNS94?=
 =?utf-8?B?RjJSd0o5dXo1ZWpxS0s4T3o1Y1NPd2kxL25Sa3JYWGt4cHBYdkgxbXNGazh2?=
 =?utf-8?B?eWsxa1QxWDlUbllVK0kzblZ0RnZmRGtOalVpblQramFjK0NUdXAvekNwV2NV?=
 =?utf-8?B?a1BTb1JUK0tRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2NiVFIwTzl2M2Z0Ukp5bjI4Q2gwaW1PR1lBL2JxUXpLOUdKSlVnV2lxTEZz?=
 =?utf-8?B?eDRwVkkyYnF0b1dpQ2tyOHdyNXRVN1RkNGJSNjFXbjFvTHR1UHA4dUZYMm1N?=
 =?utf-8?B?NkM0Y1pSYVdoQjZ4MjlqV1phUUVxM2xwRG5Eb200Q01YSnpIWHFubXB6MEpy?=
 =?utf-8?B?bGlhVXVZdkVWdWpFOUoxTUVHQXExQ1M0NU51RUtoSm5FKy92eWJnK1JsNVRB?=
 =?utf-8?B?cnVRZVIxOG1nc3N5ZkI3a05PRFVkUEJ5ME5Mb2R6N0FxN3pEWThZUGhxb3h1?=
 =?utf-8?B?Mlk0TklvR05kU2lkSmN3ell1bG9BWWRNRWdqWWpKek5NQUhOUG8yRFBaSldp?=
 =?utf-8?B?ejAxRzlza1dKUXFGQ3c2aXh2eWJMSjNibzVSbDltcXNEQ1BvZ3U1UG9JY3Zx?=
 =?utf-8?B?Z2I5WFIyMSthT1E1dTdvSjZWcnkzbWFNVlQzakdRbExTbzhod3RCa3d2ZUIx?=
 =?utf-8?B?OCtiNys1QjNlZlkvUFNid1p3aHY0eG15d1pnUXZRVmxXcjQrZVhPOWRXK3Jn?=
 =?utf-8?B?aXpoZzl1aGhXSkhkR3N6SzMwVzFyMWVEemt0N2RPOVo0TmVSeDJESmw1V1Nt?=
 =?utf-8?B?TmhuV3MvTEJlMU1UejFCSGhTNmFIS0VJbHFZdUowcDI4ckhYQ3ByNzJ4Sm5r?=
 =?utf-8?B?QUl0YWcwc05GMm5tQkRxaG0reXQ1UVpaVGQyRDFVem5Sa2g5eFg3MEZvdHMv?=
 =?utf-8?B?eDdlL2dSQXJubk9RazhHdGtVb0FKR2U5NXlRc3BXUGhXL2w0a2xkdE9qRlJY?=
 =?utf-8?B?ZGs4ZmxJUThsdWZ6bUJ4SUdGS2kycDlRV2pKZTlBT0QvZmEvQmNyNVViNEZy?=
 =?utf-8?B?U2xodzFwVHU5K2RtNmlSVzUrYy9tT2FDNHBiaWphS1FSNkNuMnE5V0FRRE9E?=
 =?utf-8?B?dHBoOWlKcGNXZCtLSXd3NkN1OEhwNnh2bThCanIvZCt0TlhZcnp0VGlNdFBv?=
 =?utf-8?B?ZG5LbVdQdTlxUk05S2ZWSUlLS0I4N3VMb1F0K0ZidklBRVlDREF0cFh3VUlo?=
 =?utf-8?B?N3VPa1R5WVBXYTg1UUxxY04vN3Q5bk5Sb3VNZW44M2VEZVFOKzQ4QXEwdm5k?=
 =?utf-8?B?OFRmelVzYVRHZXNoWmNPSG5qUFJXdnVRcldEbktOZ1J1SlR1VFAvajYwbE1m?=
 =?utf-8?B?cjQ2RHVSU09nUmZaSGo4QnNOaVljVmdsb2U3RHJXb0JDdll4anlHMGJZbHFC?=
 =?utf-8?B?MjlieTJDMnNhR1NvVjBQT1E5WXcxY3o5QVNZWmllTzFDQ05COGhIdm1VNmVJ?=
 =?utf-8?B?djl3K2dtcWYyNmpQblk0U0ZpV0hyR0FQTmF0SnRRTlJWSHN6NzBOTTVDNys4?=
 =?utf-8?B?SnIvS2VrOHZFeGF3eDloN2NRZFplM2NOc0UzSWpFUStNb2E4MENYTGNCYmdD?=
 =?utf-8?B?VVN4NEVSbFJGRHVYZHBnMmc1Q2QycFQzd3JxWWpWVmUra3ptbDRyTWlvcjRU?=
 =?utf-8?B?bDlUZ0dqc3lKZU1Ha2xKbS85OWtBVDVhSEk2dUtXTlIxa1VRLzRwS1FteFU1?=
 =?utf-8?B?K2VEMjFRNWRvZWlXckI1MWlOQ2N1NG02eHEvdWw4ZW80amptZCtEZFNSL011?=
 =?utf-8?B?V2VKTDdMQVowWllGNEhmMzE1UExNNzNpbDBzTndYQWJuTkprcmVjczNKbFJO?=
 =?utf-8?B?N0xicFkrNHl0eWhTdjZHcitpVnYxQ2VqZnNDc0xmZjNBbXN2VFYzOWU4R2FK?=
 =?utf-8?B?dER4SmlRU2xkK3RFT1BJNndnL0VFdVZhVkR4MjBRRWNWdjIvMENNbiswV20z?=
 =?utf-8?B?bGxIczZDNVRSSUlEYWNJdXlja3p4Um5ZelpVR3dyblc3aUZHaThoV3RadjBN?=
 =?utf-8?B?M1hWWHRqWlg4ZmdpRDRqZGlrcy9La0NrcHN2eU9MM3Z5cFJLUGZ4QUNNL2N4?=
 =?utf-8?B?dUpQemJCMExhWHIzWWN3dzBkTnVnZG5jWVJrV1llbFpoeGVxaERDOEQwdndT?=
 =?utf-8?B?RFVuY1JFK0swZEVlQ3Z1SGYzWmNjVWY3aWZYT1pxcnh1VmJrb2d2QW9zWTQ3?=
 =?utf-8?B?TjdFWHpnMERuS2IwZ2IwVU9ZUUU1eG8zSWRXOUh2NDVSY1FDdUtHWjhVc1Fj?=
 =?utf-8?B?Z1NURm5ZVGVKaWxVY1lReXVEZVptbStYRmQzeGxrekI4RSs0ZnZDeE50aDdT?=
 =?utf-8?Q?Vbf66TpTLvksUVeicQW8JRuR7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B26F1C4E7A82A498F1B99038D96C133@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0698a3-fd7d-4e4b-dd80-08dd8bda905b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 13:41:39.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDU6PThlNogOzUyRyFFZgqUku+qzSM2VThyHIhb2JYdenNjaKMrSKikHn9cJdTtEN9GbpydO7mRYvF4XQp6l3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDA4OjM3IC0wODAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IFFkaXNjIG9wZXJhdGlvbnMgdGhhdCBjYW4gbGVhZCB0byBuZG9fc2V0dXBfdGMgbWln
aHQgbmVlZA0KPiB0byBoYXZlIGFuIGluc3RhbmNlIGxvY2suIEFkZCBuZXRkZXZfbG9ja19vcHMv
bmV0ZGV2X3VubG9ja19vcHMNCj4gaW52b2NhdGlvbnMgZm9yIGFsbCBwc2NoZWRfcnRubF9tc2df
aGFuZGxlcnMgb3BlcmF0aW9ucy4NCg0KU29ycnkgZm9yIHJlc3VycmVjdGluZyB0aGlzIHRocmVh
ZCwgYnV0IGl0IHNlZW1zIGxpa2UgYSBnb29kIHBsYWNlIHRvDQphc2sgYSByZWxhdGVkIHF1ZXN0
aW9uLg0KDQpJZiBxZGlzYyBvcGVyYXRpb25zIHRoYXQgbGVhZCB0byAubmRvX3NldHVwX3RjKCkg
bmVlZCB0byBob2xkIGFuDQppbnN0YW5jZSBsb2NrLCBzaG91bGRuJ3QgYWxsIHN1Y2ggY2FsbGVy
cyBhY3F1aXJlIGl0Pw0KDQpJbiBteSB0ZXN0aW5nLCBJIGZvdW5kIG91dCB0aGF0IGUuZy4sIHdo
ZW4gdW5sb2FkaW5nIGEgZGV2aWNlLCB0aGVyZSdzDQp0aGlzIGNhbGwgcGF0aCB3aGljaCBlbmRz
IHVwIGNhbGxpbmcgLm5kb19zZXR1cF90YygpIHVubG9ja2VkOg0KDQpkZXZsaW5rX3JlbG9hZCAt
Li4uLT4gZGV2aWNlX2RlbCAtLi4uLT4gdW5yZWdpc3Rlcl9uZXRkZXYgLS4uLi0+DQp1bnJlZ2lz
dGVyX25ldGRldmljZV9tYW55X25vdGlmeSAtPiBkZXZfc2h1dGRvd24gLT4gcWRpc2NfcHV0IC0+
DQpfX3FkaXNjX2Rlc3Ryb3kgLT4gbXFwcmlvX2Rpc2FibGVfb2ZmbG9hZCAtPiAubmRvX3NldHVw
X3RjDQoNCk1hbnkgb3RoZXIgcWRpc2NzIChvdGhlciB0aGFuIG1xcHJpbykgY2FsbCAubmRvX3Nl
dHVwX3RjKCkgYW5kIHdvdWxkIGJlDQppbiBhIHNpbWlsYXIgc2l0dWF0aW9uLg0KDQpEb2VzIGl0
IG1ha2Ugc2Vuc2UgdG8gZXh0ZW5kIHRoZSBuZXRkZXYgbG9jayBmb3IgZGV2X3NodXRkb3duIGxp
a2UgaW4NCnRoZSBwYXRjaCBiZWxvdz8gQWZ0ZXIgc29tZSBiYXNpYyB0ZXN0aW5nLCBpdCBzZWVt
cyBzYWZlIGJ1dCBJIGhhdmVuJ3QNCmxvb2tlZCB0b28gZGVlcCBpbnRvIGFsbCBwb3NzaWJpbGl0
aWVzLg0KDQpDb3NtaW4uDQoNCkZyb20gZThiNjEzZGZkMmIyNDFhNmMxOWJiODlhODI5ZDU5OGQ2
NjQwYjZmOSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IENvc21pbiBSYXRpdSA8Y3Jh
dGl1QG52aWRpYS5jb20+DQpEYXRlOiBNb24sIDUgTWF5IDIwMjUgMTU6MzQ6NTMgKzAzMDANClN1
YmplY3Q6IFtQQVRDSCAwMS8yMF0gbmV0L3NjaGVkOiBMb2NrIG5ldGRldmljZXMgZHVyaW5nIGRl
dl9zaHV0ZG93bg0KDQpWYXJpb3VzIHFkaXNjcyBjYW4gZW5kIHVwIGNhbGxpbmcgaW50byAubmRv
X3NldHVwX3RjKCkgYW5kIGFzIHN1Y2gsDQptaWdodCBuZWVkIHRoZSBuZXRkZXYgaW5zdGFuY2Ug
bG9jay4NCg0KU2lnbmVkLW9mZi1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZpZGlhLmNvbT4N
Ci0tLQ0KIG5ldC9jb3JlL2Rldi5jIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9u
ZXQvY29yZS9kZXYuYw0KaW5kZXggZDFhOGNhZDBjOTljLi4xMzRjZWRkZjdmYTUgMTAwNjQ0DQot
LS0gYS9uZXQvY29yZS9kZXYuYw0KKysrIGIvbmV0L2NvcmUvZGV2LmMNCkBAIC0xMjAyMCw5ICsx
MjAyMCw5IEBAIHZvaWQgdW5yZWdpc3Rlcl9uZXRkZXZpY2VfbWFueV9ub3RpZnkoc3RydWN0DQps
aXN0X2hlYWQgKmhlYWQsDQogICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYiA9IE5V
TEw7DQogDQogICAgICAgICAgICAgICAgLyogU2h1dGRvd24gcXVldWVpbmcgZGlzY2lwbGluZS4g
Ki8NCisgICAgICAgICAgICAgICBuZXRkZXZfbG9ja19vcHMoZGV2KTsNCiAgICAgICAgICAgICAg
ICBkZXZfc2h1dGRvd24oZGV2KTsNCiAgICAgICAgICAgICAgICBkZXZfdGN4X3VuaW5zdGFsbChk
ZXYpOw0KLSAgICAgICAgICAgICAgIG5ldGRldl9sb2NrX29wcyhkZXYpOw0KICAgICAgICAgICAg
ICAgIGRldl94ZHBfdW5pbnN0YWxsKGRldik7DQogICAgICAgICAgICAgICAgZGV2X21lbW9yeV9w
cm92aWRlcl91bmluc3RhbGwoZGV2KTsNCiAgICAgICAgICAgICAgICBuZXRkZXZfdW5sb2NrX29w
cyhkZXYpOw0KQEAgLTEyMjE4LDcgKzEyMjE4LDkgQEAgaW50IF9fZGV2X2NoYW5nZV9uZXRfbmFt
ZXNwYWNlKHN0cnVjdA0KbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgbmV0ICpuZXQsDQogICAgICAg
IHN5bmNocm9uaXplX25ldCgpOw0KIA0KICAgICAgICAvKiBTaHV0ZG93biBxdWV1ZWluZyBkaXNj
aXBsaW5lLiAqLw0KKyAgICAgICBuZXRkZXZfbG9ja19vcHMoZGV2KTsNCiAgICAgICAgZGV2X3No
dXRkb3duKGRldik7DQorICAgICAgIG5ldGRldl91bmxvY2tfb3BzKGRldik7DQogDQogICAgICAg
IC8qIE5vdGlmeSBwcm90b2NvbHMsIHRoYXQgd2UgYXJlIGFib3V0IHRvIGRlc3Ryb3kNCiAgICAg
ICAgICogdGhpcyBkZXZpY2UuIFRoZXkgc2hvdWxkIGNsZWFuIGFsbCB0aGUgdGhpbmdzLg0KLS0g
DQoyLjQ1LjANCg0K

