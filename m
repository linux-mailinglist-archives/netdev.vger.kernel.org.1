Return-Path: <netdev+bounces-118710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E98952872
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B2E1C20F6C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE46383A5;
	Thu, 15 Aug 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edU0U+cf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189C1C6BE
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723694263; cv=fail; b=L/rRErOJUlziSpIwJYKWXiK6slgSEMZnpThoqOutZE29kUM6sX0dEOWWWLr0Yvkr2BZlVpF/rf+lnmsGfCJout19mNlNi+vWY9RA38WmkjshJe7EDqakpMqSr7RkAUjaDQNufFrow6CmWZtSF01xQy89b+GKLC7zPRE6jSTOrXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723694263; c=relaxed/simple;
	bh=NUOojuQJxEytcdvGNqnuvBOj7Pqhqre5qv5LBLM3etw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8fzV0uqCRDdTkSpqyF4slvN6D15VQ1m4qyJ2iK55wFAuiI3o07P45oAIPoL9prtPVFm7zCwNumy4+txkzpSZQE9TnED60csDZbTer5g9j2i7eVBHToKGIpKbRXZD9rnxNt3svP6FkS94z4qol5uWlVecpvob05CujbcU3/Ye4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edU0U+cf; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4GhsxC9pVfBbnShsu5+rNm53J4MKeZsNjQ8Rf01cloHaKMFXxMWTlfXnYO4PQ/DytfQbw6rwHXGui6+sGh4GboSkCAgbJVptplZIfArXbX+V7T5nmWtkAky2pJEkLTJoz8qnxoZ/fowF7c6dXPa+z/Egp6B+gR/sRrjV2rnaDqr839bKPqvhUf+MxBkfop9LCEB2dBz4zjUs+Rcf8z0kUKQ+wH8p3s/JxkVq0mqyp0f4mbhAFtjad1hTGy8bj1ltxOGyvdLXQ9qL0MsMXJf6IY/HRDlGOH///dNKbn7s25spRFX4wyGugDMuhLkiDX2zP8WDi4pCK/E+BKmtqC4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUOojuQJxEytcdvGNqnuvBOj7Pqhqre5qv5LBLM3etw=;
 b=ubo1IzKvhRcUVhY0dN+1PSPlcAG91jkLlpdtZY5SRKxjQVwKbp12oLu7ctItQFDBC+o1CLbQiOdqkW/6u6wtH2QYxskddnF04ZO5gPHTeDYteAGaHpvK6VvGeFwT/6H6VrEPRjg+UaOPCB4R1Du3PFgxN1IPQGfT1cOwrP4hUvxUGwKB+cBmXl8SkzVCzLwrK5iiDIn9v5aKqc9HZQLaehLNpJUzh9qy/sa20omA/thmhcWBoQxS8Hcy7CvrzJj4IQeGGWWgdqlzF0je4AOCFg7039hNcSj+rPBx8ujUlok1kZ2s2Z+qWh/4nPSN1OeSEL+698iCU3BfBSOBRFdCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUOojuQJxEytcdvGNqnuvBOj7Pqhqre5qv5LBLM3etw=;
 b=edU0U+cf4VSXvpbXlEXsU6+lESyEPVQN8dJeMCE+dC2zjtoRTLx6Wm6C4JG/uIR3Lzsvs2ZinMEuZaZmiVwlNPI6+b5sRc2gGMIRSeCLqkeGNvrOklSu9cyO4UPf5/bDqPDGn1o3BknbpLLK1yEQcyAR7NWH/Cgt382y6ap3PSGFm31B1VnjxR45IcpruPNsLTopF1F0gkZiFlIjQRMpAbCq8uBWNeVK+PWHp2TfH5+wfLlt6A7L4nUO42ymhbVdG2CtnKajMzJtbisQbYdNdBAQhjEjpOAOJQOD1eqTlEGwrMwkb5X0sNN0Ai8TCPtsb9ijChlFfts0HaPH7PUA+A==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 03:57:38 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 03:57:37 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index:
 AQHa5vUrWi/gseXBCEqaGlxcFyce2bIkZyIAgAAkNgCAAL0JgIAAxiQAgAASv4CAAXQrAIAAJLIAgAAGewA=
Date: Thu, 15 Aug 2024 03:57:37 +0000
Message-ID: <59cc7d35b0b1248a96313324fc21c95f3e5d1497.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-2-tariqt@nvidia.com>
	 <20240812174834.4bcba98d@kernel.org>
	 <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
	 <20240813071445.3e5f1cc9@kernel.org>
	 <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>
	 <ZrwgRaDc1Vo0Jhcj@Laptop-X1>
	 <e7ee528b3db5ba94937ca6c933f9060e32f79f3d.camel@nvidia.com>
	 <Zr13QBes8L4i1Kvn@Laptop-X1>
In-Reply-To: <Zr13QBes8L4i1Kvn@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|IA1PR12MB6259:EE_
x-ms-office365-filtering-correlation-id: 17aa9e0c-9020-4202-b6be-08dcbcde66fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGswMUkzZWljSlRMWFhPQ2hUQVo1UVFHd3hVbVZRWms1RjJCRmVYRk1RTmI3?=
 =?utf-8?B?aXFpVStyRWtsSWg0V0cwaCs1SlFGd2p5TmZ1R00vU3VjMWxJdTFKUXRtV0kz?=
 =?utf-8?B?ai9VWGVPcFpuSVRrM05TV1F6SWJMWFdIc3F6ZEx5VTVtcVF0SmxjK0g0aHJa?=
 =?utf-8?B?dC9rb0FNQnVHdGQxNFZZdU1XQVF3ajRiVzlRSzl0WjJsNWIzVVBYK1djVGRQ?=
 =?utf-8?B?WitFUk1reVVhWDI5RE9GODBvN2JKb2xYTThleFRMTDdxcVJJYmtPSEpxRERk?=
 =?utf-8?B?UVZEL0hFb3hRa2dZbUZGREtYZXI4dUxRaG1YbHlFWENPblVGQjkwbGZ0UjhD?=
 =?utf-8?B?MUw4aDhlMDdIdzJDNXVOWU5EUlBxYXpEQzdyQkdoRjdMRURTNnBpdkVWYnVa?=
 =?utf-8?B?WEF3OXM0VEdhbWtoTkJYU1MwVDNNL2V6aUgyZC84VnpnRkUrNGhWdDRRT2Zm?=
 =?utf-8?B?WXBhN0JvRklxcEpUMmYrSTJlV2Nlb05FNmZwUnMrRWNVQThobFloTURSS1NZ?=
 =?utf-8?B?dkRERE1wTEkyZEdpOWVuWmNrbVcxME1pN0pmT3RrNUlBNjhxMTZQTDBxWTRt?=
 =?utf-8?B?UnB6QkZVdFpaUHVuL1ZkNlZuN1ZHRHZjUE11bXJMcE1tMUJhZkdaSjRDN2ZU?=
 =?utf-8?B?eUw1c0VJeDZxK05NaTNQUFZja0JaV2VkNFBSYkVJN2ZPY2tXeUJySHFpY0Fo?=
 =?utf-8?B?WXlSQU1ydmNYVURvY2dMRmYrME41TTAxeUtUUEgrUHJEMUMzMk5NVEttTnlZ?=
 =?utf-8?B?NFQ2RVp4REJGWmZ1ZG5RVXBQcE1zcnUwVXZqMzRMKytGWWFnemhld0tienpF?=
 =?utf-8?B?Z3I0eXQ3NHl0c3BnSk9LalJ1OWNBeUE4bGIzVnE1V3AyUzB5VW1OcHVTa3NF?=
 =?utf-8?B?M0tMNzFFMXRWZjVTajJ6R0VXSXdJVDR2a3RZMVo3bE0rVUhhb1ZGMU9sclVx?=
 =?utf-8?B?ZVUxN2FOK1Z4SldjS2VwVVhkU2lnVWlxUnlFbHVKK1B0K2poaVNSeFc3SDlY?=
 =?utf-8?B?VVA5aUxvZTJXUE5kM3NiQzhwdzBSRWp1RTNmNlI1MmtTZFA0WWxDdDRnRkhn?=
 =?utf-8?B?NG5lajNTUXlvR1VYZGQ3WFlPVmg0c2UzcWxzSG84bmxKUjYvVVYxQlZsRHA0?=
 =?utf-8?B?aXJVV2c2OEtkd1FzbVlMajlWcEdxRlhhOUZOY29XMkFOSXh0SGpQd1pJempK?=
 =?utf-8?B?eTdVMEYwckszWk04TjczWXhYVUhvTEpCeHNBT2oyVGxLVUpoc0duSDlBSlFl?=
 =?utf-8?B?bzI3cW1tY1MzQnE1MTZYRW9hNnkxeEg2V0svaVBZa0U5c2IyYzhhSzJMM2F3?=
 =?utf-8?B?RWVlRitHbXc3VGVXRTlmOERPN25RZFJES29IcUNZdURXZ1JQdlZUTytITnpt?=
 =?utf-8?B?dU5tMVF3WEgybnRpa3VaWTlIR3FkeitBWXpMUFplUzMvY2pjWDF4OFczemFi?=
 =?utf-8?B?TnNydUYzNG55b1FPSFlGTEk4VDZGaVRyeStyakJyRGM3aDlzejZVdG5MNzZS?=
 =?utf-8?B?SGN6M1RUZTlSSHp6dkJDdVhINVBXRDRHcHYraHpLNk10LzNKQjB0bHI0Vy9P?=
 =?utf-8?B?TmRDTFFiRGpGOUxoSWJhSE84eUZIZkJyZnBJa1czeUR5Y29aZThadnhYMHJo?=
 =?utf-8?B?a25QRG1CbEtRUldtTk1hTCtXY3VwQ0JQM3NpUE9HUkdMNlZrdmNPNVdiKzhn?=
 =?utf-8?B?cjZabGQ1VHMxeW5vdXJtQzlnc0Q3TVFhTWk0QVhaVnVkM1FlRHlSS3VPR3Rh?=
 =?utf-8?B?V1ZBZUZxaFFRQ2RGN1FyRDg0QnZmUm91eDZOMW56V3crSTJheVZUUlpUaDZM?=
 =?utf-8?B?Mit0dW42T2d4VzBXbEtsSjB1QXVuTWlqakVGYWR4OTJIdHQvUVpyTTFuUGJk?=
 =?utf-8?B?RjN0dGp3aU53b3FuVjNHZ1oycS9tWEFDR0tyL3JKTE90dFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a09KNXUyYWVpY2hBenpIVlZhNjZtMTJSeDR1ck11ZmRKY2ZsK2R2TU0vT3Z3?=
 =?utf-8?B?cnFMczlORE9NeXRlTEJKZzY1aVdOc1VxUFNVQnU2bzNVQXVkV2hneEl1UXFG?=
 =?utf-8?B?ekpTb3RWcWEwMXlYS1I3ODBqVXhPZWNoTkxSWGNwL1d0dUJxeGNwZWNaWjdt?=
 =?utf-8?B?UXdTempKVWxWYXNHczdIQ1oxdzk4VXdIRFkvVHhKU3hPQ3c2TjVCMGhpQ3pP?=
 =?utf-8?B?N0p6emZsckVxaFpVVlhLdHE5VElrRXRDb3F4YUpIaklMWnFSQ2FlQU5aU0ww?=
 =?utf-8?B?UkU2R0E4YWZSbmF0emtpeWRidDAwNUtJRmVNMVplSVR3RmJBVDJjYnlhd0dz?=
 =?utf-8?B?VjNkclpURnhPN1lMY0xLclNYWHA2ak0rMDJ4MHZMeFBPTWs3azlyeE9hU2t0?=
 =?utf-8?B?NWU2eWtRcTFqWm9tMFF3NGVIRGFYdXNaaHNVU0gyMHQ4RytOeHFXR3llM01D?=
 =?utf-8?B?Yk5FWG5pNlE4cTlEaWk5RHFrVkhTQ0VVRDRVcGI3S3R6c1dLVDU4eEhqR3I0?=
 =?utf-8?B?SHZGTnpHNmJLZEJkTUxhQUZRcG5kTnU0ZytwWFh6NVlsUWZWQzI5eDRnaHVs?=
 =?utf-8?B?NDl6NmlVcDdHYVdVWnlka0JZMWVTc25YTFBYWkttcmZISSs0b2dZcmhNdEpz?=
 =?utf-8?B?TGR1bkNuaDVZOXdMd24wRHphbFhETmVGaWJvQ2RhWWJvd05QL0U4YnhXcS85?=
 =?utf-8?B?bDlGY3JmT2x3SmM2V0tQTjIzcGw3UDI2V2o4SWpXZStzenVWM3N5OTNiUW1j?=
 =?utf-8?B?QVVHTU5FcU5ON2xKUk1Xb2h4NmtpTGxZdjZIdEcvTDY4SHpIa2g0N3RQVEtY?=
 =?utf-8?B?QkhHeGF1ZUxLaEZSVUxVL2p3dWNHMW52SFg0UVc3WGZ1azdzbE1sNnI2dmIv?=
 =?utf-8?B?cURSMDdsV3ZtMzZpa3M0ZCs3VVphUGUyUVpXYjh3Z3lObVdqTGF5TnRUdW14?=
 =?utf-8?B?UFJ4WW84ZzNVSXc0eDByb2c4aTUydUZ2MDBUdjgvZjMraEFoZ2U3SURremdr?=
 =?utf-8?B?WGVkSHArcktqOEt2ekxtV1AxcEhuOWRhSnc1UVNRa01EeUlKdm9QOTdCNkxs?=
 =?utf-8?B?L0lxY2lxMFlJUzBTT1kzV2hWSEpZQjVPdHA3VXVtNE1LSHQ4bk9SZTRVY3Zs?=
 =?utf-8?B?NGJ0aGd5QjFXWXJIU3FWWEJsTU4wWE1Gdk1qSnl5TjdqdXlBaXFHWmpuVjdp?=
 =?utf-8?B?YVlJWG55SjEzSFJXN1JYamdSWDhDYnlGOUN6dkJsV2dORENmVDdpWUl5ekxT?=
 =?utf-8?B?a3RONTlUUXl4dG9LcEVCT2pDSlVCWWNmNkowTkFhMUdSaUR5dUNOYUVjb2lW?=
 =?utf-8?B?NEpRSWRTWUpPKzlSellDOEZiaDNKTjBVb3hnT1dNemhlbVRzSEVhNzh2dnJF?=
 =?utf-8?B?VUFnL3BscStsRzI4ZUJqbFZaMGo4QTJiWGNoM2szdXd0ajhFdjl2ZCtRTUR0?=
 =?utf-8?B?SUd1VkxRV2lNd1hKTUVRTDV2NDBOQTN1TDRiSE1kS05OZGdPbWZ1RTZNVG5K?=
 =?utf-8?B?b2ZINU9ZdUpIbm5wb2xIYis4NVhnaUtPd0NHL3BPQXN3cG90TWF4NmZXV3RJ?=
 =?utf-8?B?ZENwTmUyY2hEeDQ1dG1Mb00yOCtlUFc2dDVjdWZzRTNLVW1QMmRLWWhJbG5y?=
 =?utf-8?B?UTFGQjhSVHVmRmxpOWxTMUJwYVZqR1d0YmVFdkZ0YXpUNGV1TDVnMXF6dExF?=
 =?utf-8?B?VDR2NDFKbWp6Qi95bkFJb21PQ0ZNQXJCLzBLYXdVamhjbFAwVldLZmJlZkRl?=
 =?utf-8?B?WGpEczdEbDRiaEllVmg3ZGVDUUg4ZWViQUtIWkl2bjYyZUxjdDlmbDBkU0dy?=
 =?utf-8?B?T2VrcjV4RkkrY0Q0bVVUcnJOSzErVGhZZXcraXNESFBWR1NyR05JaUZRRDFh?=
 =?utf-8?B?dW1lcjY0bXdxazNFeHQ2UFgvenA4WnV2dGVsNE9MeklYNDJjeXZIUGZKY1Nh?=
 =?utf-8?B?alNYYTRWa3IrRDNQSmg3KzVaaXF6ZFJYZVYzQ29rYzViTWQ1WEVxUFhtWkxl?=
 =?utf-8?B?RzJaWittY1NaeHlCZEpEdHhCNkRMSmtLbmNmZ2U1UytmRFZaK01zSU96bXly?=
 =?utf-8?B?eFFTTmJNQ3dmTkVBOFFtUE12bDhEMi9VRXFJd0prbitBUlNicms0T01yS202?=
 =?utf-8?B?UG1yWm5ZQTVNaE5tR3BTWmVWVjZsOWQ3R0ZGdUMyUlFYUit0UlFPUE5aNG5N?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32F83CF39005A047A1D6CCD2148E4E82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17aa9e0c-9020-4202-b6be-08dcbcde66fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 03:57:37.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbdNnkVEvl78pDRbss8xrcPL109woKj+QSO/tN4jQ8CtjnTRdduT1PFmTs6IelgsGk25Znz9r2ayioDJ83zw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

T24gVGh1LCAyMDI0LTA4LTE1IGF0IDExOjM0ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgMDE6MjM6MDVBTSArMDAwMCwgSmlhbmJvIExpdSB3cm90
ZToNCj4gPiBPbiBXZWQsIDIwMjQtMDgtMTQgYXQgMTE6MTEgKzA4MDAsIEhhbmdiaW4gTGl1IHdy
b3RlOg0KPiA+ID4gT24gV2VkLCBBdWcgMTQsIDIwMjQgYXQgMDI6MDM6NThBTSArMDAwMCwgSmlh
bmJvIExpdSB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDI0LTA4LTEzIGF0IDA3OjE0IC0wNzAw
LCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIDEzIEF1ZyAyMDI0IDAy
OjU4OjEyICswMDAwIEppYW5ibyBMaXUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgcmN1X3JlYWRfbG9jaygpOw0KPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGJv
bmQgPSBuZXRkZXZfcHJpdihib25kX2Rldik7DQo+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgc2xhdmUgPSByY3VfZGVyZWZlcmVuY2UoYm9uZC0NCj4gPiA+ID4gPiA+ID4gPiA+Y3Vycl9h
Y3RpdmVfc2xhdmUpOw0KPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJlYWxfZGV2ID0g
c2xhdmUgPyBzbGF2ZS0+ZGV2IDogTlVMTDsNCj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqByY3VfcmVhZF91bmxvY2soKTvCoCANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdo
YXQncyBob2xkaW5nIG9udG8gcmVhbF9kZXYgb25jZSB5b3UgZHJvcCB0aGUgcmN1IGxvY2sNCj4g
PiA+ID4gPiA+ID4gaGVyZT/CoCANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSB0aGluayBp
dCBzaG91bGQgYmUgeGZybSBzdGF0ZSAoYW5kIGJvbmQgZGV2aWNlKS4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBQbGVhc2UgZXhwbGFpbiBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gbW9yZSBj
ZXJ0YWluDQo+ID4gPiA+ID4gdGVybXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTb3JyeSwgSSBkb24n
dCB1bmRlcnN0YW5kLiBUaGUgcmVhbF9kZXYgaXMgc2F2ZWQgaW4geHMtDQo+ID4gPiA+ID4geHNv
LnJlYWxfZGV2LA0KPiA+ID4gPiBhbmQgYWxzbyBib25kJ3Mgc2xhdmUuIEl0J3Mgc3RyYWlnaHRm
b3J3YXJkLiBXaGF0IGVsc2UgZG8gSQ0KPiA+ID4gPiBuZWVkIHRvDQo+ID4gPiA+IGV4cGxhaW4/
DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgSmFrdWIgbWVhbnMgeW91IG5lZWQgdG8gbWFrZSBzdXJl
IHRoZSByZWFsX2RldiBpcyBub3QNCj4gPiA+IGZyZWVkDQo+ID4gPiBkdXJpbmcNCj4gPiA+IHhm
cm1kZXZfb3BzLiBTZWUgYm9uZF9pcHNlY19hZGRfc2EoKS4gWW91IHVubG9jayBpdCB0b28gZWFy
bHkgYW5kDQo+ID4gPiBsYXRlcg0KPiA+ID4geGZybWRldl9vcHMgaXMgbm90IHByb3RlY3RlZC4N
Cj4gPiANCj4gPiBUaGlzIFJDVSBsb2NrIGlzIHRvIHByb3RlY3QgdGhlIHJlYWRpbmcgb2YgY3Vy
cl9hY3RpdmVfc2xhdmUsIHdoaWNoDQo+ID4gaXMNCj4gPiBwb2ludGluZyB0byBhIGJpZyBzdHVj
dCAtIHNsYXZlIHN0cnVjdCwgc28gdGhlcmUgaXMgbm8gZXJyb3IgdG8gZ2V0DQo+ID4gcmVhbF9k
ZXYgZnJvbSBzbGF2ZS0+ZGV2Lg0KPiANCj4gSXQncyBub3QgYWJvdXQgZ2V0dGluZyByZWFsX2Rl
diBmcm9tIHNsYXZlLT5kZXYuIEFzIEpha3ViIHNhaWQsDQo+IFdoYXQncyBob2xkaW5nDQo+IG9u
IHJlYWxfZGV2IG9uY2UgeW91IGRyb3AgdGhlIHJjdSBsb2NrPw0KPiANCg0KQXMgeW91IG1lbnRp
b25lZCB0aGUgbG9jaywgSSBleHBsYWluZWQgd2hhdCdzIGl0IHVzZWQgZm9yLCBzbyB3ZSB3aWxs
DQpub3QgbWl4IGJhc2ljIGNvbmNlcHRzIGFuZCBtYWtlIHRoaW5ncyBjb21wbGljYXRlZC4gDQpB
cyBmb3IgSmFrdWIncyBxdWVzdGlvbiwgSSBhbHJlYWR5IGFuc3dlcmVkLiBBbmQgSSdtIHdhaXRp
bmcgZm9yIGhpcw0KcmVwbHkgc28gSSBjYW4gYmV0dGVyIHVuZGVzdGFuZCBob3cgdG8gbW9kaWZ5
IGlmIHRoZXJlIGlzIGFueS4gDQoNClRoYW5rcyENCkppYW5ibw0K

