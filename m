Return-Path: <netdev+bounces-231168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1FBF5F13
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC80218C7E3B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4E2F2909;
	Tue, 21 Oct 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tQQprDlw"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A872F3602
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044666; cv=fail; b=LJd3GDrKiIr70ZODZCivuwD4/dTfjLGvPAXn+e4WV2RStoOY4K0ZY4ZESJtB4QbMYYXqESl+dreyZJcctIgj/k2Bx9BCNOrEHwHwfBO+lwJm+34eB2KmZEEJgy9aL+yxqt4iuDHINeFOL6YfiQw0MW6epE8Z5grcorHHiCyd3Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044666; c=relaxed/simple;
	bh=oyNapKM6icBdo4FNtuEsrG4A4023j1Yp3fNM083uYbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P+fH5z8S7XoTge/eK5dt3ktyFhs78tKFW4+Izrzy1wM0yJylK1giR/sm8mgEbdh0nVeoTMQfgQR5mWj4N4/krWNj5/8CL78a4Nbc51anCVcaqXMcl7pKfe/eu4jql6/SZSuFemLC9k4JFNvN3wFh7V/EAVLkgdqYfxQ02ZN8FCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tQQprDlw; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWkQXTwwauXOzhdwQDMI/cnL8ZygN2HcEc/LnoVBMmRhnVLzmUEdX6XiPzEKUQrdQKD+qfZ6rSR5FXRYZGxjNv0IzYaz7vq2Rk4aNE6Q7/Vl+RaRs51ZYTUiP2r6IsKNEKvoxMFMt7RnNgD3l+oLLRts4bn0Aivwz4XURIlR/cjFc3DIeTPqu3trsvm6Ssd4VyUwO+YL0qQ/3D1nCN4lzN6I1ZQrz/IB0U8mkl79Tem6H8Tu3ZLFfjB61vPX9vdjKwdsXLzKHFVJfsq+rA3IjTjVjQmWjjVuliYlr4mXnSao+FaveoF80/RjM0SZURrjHHbO2WuW8hH7IPukfBUGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyNapKM6icBdo4FNtuEsrG4A4023j1Yp3fNM083uYbE=;
 b=sw85H3TbhWZVyfkbdqKN6Nq4nfZHMNgNRyOfHuWMVOsewFfEePOWHRNVJxQI2F9Nb8fN76jhQmh8cZFkQBHy8PO2epLSjTo6pSecd1cSl4f471jRzJPPiFR2bZH3ar5hMZ6BaH9QT9wSFeoz+nngxSecFJJPWlGEVWs5qC3uonobnc/PFqwu3G+4aIkLLUfQnwCa9zEbRRpEr3Xo9rFxL2LMLeBl4f4PfAJ0ECvyUtzsDOCp8rZzwfY8ATBTuwDsKMCvs68uBalQ320ArbNgm557NTG925KWRIyGluQemp2IEe3dSjCJpUrBv/iUq0ACLa4jd0jSWPyPRdAhtr9tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyNapKM6icBdo4FNtuEsrG4A4023j1Yp3fNM083uYbE=;
 b=tQQprDlwNQdmrg3jU6sv2/DancG2DmMfWdSKej+dV/+tMmqvEGoLIrFK9IA8vCAcONddBB4H5XTMobyfX6d9hrCLsDbtkwCujdGzBJTZc1hZ9hilwo5tkmqJ3eDJS9kwi/YhiNoOrXVaGrb8H0qMx5kllXE9Dar01mN1K5yoo/T1iJA9QF2qYW90uYWN04hh5iAqqmdmYyuoR7Ci4DOGIYbMQwIvgGs+w6nGBPYMUEybHR8eHXYskIV2knFvagVtdaIo2bZjvTyuHSbT3Zg4BRvvhHG+I22ThOaak9FI0noyDh0V+uncHyX4jl0nkZ4gKnciXs+M9Z+5Mt7dayd2Dw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 21 Oct
 2025 11:02:58 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 11:02:58 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
	<john@phrozen.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>, "bxu@maxlinear.com"
	<bxu@maxlinear.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "fchan@maxlinear.com" <fchan@maxlinear.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>, "hauke@hauke-m.de"
	<hauke@hauke-m.de>, "kuba@kernel.org" <kuba@kernel.org>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>
Subject: Re: [PATCH net-next v4 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
Thread-Topic: [PATCH net-next v4 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
Thread-Index: AQHcQcEipMRy4tp8tkWK88XVAf0nSbTMcQGA
Date: Tue, 21 Oct 2025 11:02:58 +0000
Message-ID: <4bf4846a4726a372825b3daa3e2f50e4eab48e57.camel@siemens.com>
References: <cover.1760964550.git.daniel@makrotopia.org>
In-Reply-To: <cover.1760964550.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9380:EE_
x-ms-office365-filtering-correlation-id: 04f22009-9897-4c23-fd42-08de1091653e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGFwcnYxVVBNT2ZNeEFOZ3FPTWZFNXE5dFptRFlSTDlRRFF0M1haalhUQWc4?=
 =?utf-8?B?STlibkdOMlk0M3lEZ3dJQ2FBQWE3ZE9nSW1vbTFWUnkzNjFwSmh3amx6RlpS?=
 =?utf-8?B?QTM3U2RWbVVPZUtCMjduZ24wQkZZNmNXeDdwVlp0cmRwdllnR29HMGVjTHFo?=
 =?utf-8?B?Tit3V2JoMnB2TS9GZERvdTVDMDhvcE1tb3J0emk2eVlZVWxwNmJtZDYvM3Ju?=
 =?utf-8?B?L1hRSHhab2NWcXZiYk0veEZwZU5hVG1aNHAvcWF4TlJVblZSZkdVYThSK0xR?=
 =?utf-8?B?YUpkc0hTTktxZ3Vtb1FTMjZVaGRjUTQzc0NDaWtUK1V4ZmtGWktjQ3dhc01B?=
 =?utf-8?B?VDZkRjJRV1hndmJZaS9NVkpETE5LUmkyR1gyYjNIMmVVWVVvM2Qxb3BibmVi?=
 =?utf-8?B?NHNSakphNEl5Z1F2aXpRd3g1NHF2MGIrdnhNTFZCSEZyMlo0U2YyWFViVW1N?=
 =?utf-8?B?TGdITDFzSjZ0TmJpekVqMys5aHJkdHFkajkxVmVXQ1JGelZTaldiQlk4Nm91?=
 =?utf-8?B?dTJjY2RaMWFMWS94MUMyWUFMRVd2K01jTnA0UStKK0dqMUpTOW90NWhqVXZU?=
 =?utf-8?B?enhXVGJFVTdYc01kMlN0ajlZMnlXMG1KMERwR3lHRTQ3b0xiRVpDK29iR3JW?=
 =?utf-8?B?dUNwUml4bmNoQ0o1djlJamVpNG56cEZxTWNibWNrWk96RjRBQ2ZMOEtLNWFu?=
 =?utf-8?B?blZxQUg4MkkxclFGV1NrVVB6dUZQcWl2Qy9kcnhvd3FEZmZjakYvdmYzaTJJ?=
 =?utf-8?B?aXhtUTFBbWhWYTc5NjZUVThhQ0ptN1dnbklocFd2SXF2dGhxdzZJcEl4YzIz?=
 =?utf-8?B?c3FaTTVXa01Id1dBRVViLzhiMDlxakwxM21KNHZaVEJzWGZua3lvejRySHVS?=
 =?utf-8?B?TEthUUliRGIvTVN1WWpITW9BbEw5UTlNNTFETEJxaWhycUxiaGNYQVZTdWNW?=
 =?utf-8?B?eTMxaEJZOEthdFFFOEtZYzBuRXNtM0N0N0JTZGoxYjgwRmdUR3FzVHlCV1pX?=
 =?utf-8?B?dmVCYWp4ZkdQSSsyR1NjOHVQblNLU3VIWC9jckwwSXZWK1VlZStHSzA0TXlx?=
 =?utf-8?B?djVQQmpnMEJOd0YwaUxQNFdJZGtmR0s3OEVZUXBMaDkzK2twdEkrd2JNR1F6?=
 =?utf-8?B?T0lwelRPVU55eFRJRnNNSVZpSzBjelNIdmErZmtDYzlBZ3JEYzgwdXVuZ0ov?=
 =?utf-8?B?a0hMQjd5bFloVzRkSHh1SDBmZDZvVXUyZWdaeGQzM055cWU4ejllU3FmWHhZ?=
 =?utf-8?B?cDJmMTFwZnB0VGNBTlFwY0ZMc2F5TTFkWGtyVnhhWlROUUF0MFI4RGpVUnFx?=
 =?utf-8?B?TytsNTFBWWFpYy9PSGRXL3h5ZGFwWlRseW9DVE15WVhXM29hOFJjNEc5UXlo?=
 =?utf-8?B?VEZjUXR3ektkcTRFclZuMHRVLy91N0F2cEtmM1g2Vzg4WjdTcXYxaTNmVE9m?=
 =?utf-8?B?VndEUGV1TDVMblMrai80K2hDcG1tblErMkVwWXpGc0w4bkJnTlFWVGd2cjl3?=
 =?utf-8?B?THJGNll4dnBSYmQ2OGpjcGl5clBmY0JxbDdWb0svc084WERtd3VNb05ud2Ix?=
 =?utf-8?B?b2lsK3BRSzBKUzZsRnVoTUNFNWI3YU11bWl3VnFJWWdSSkVMbzc2RHovRnFo?=
 =?utf-8?B?TUlvN2piZk1nR1B2ZjZld1QxYWdBMm1MbXJRTkJoZXNmZk9UcFZva1g3b2Fk?=
 =?utf-8?B?ZDJHcTN5OUhsUjNTbFE5WFRUNHVHY2xNN1NQOHllR3VNTWhDSmRHRVZKTU1x?=
 =?utf-8?B?RkdVWk9BRnRNeTZpNkZQT3pNVHlyam5wTjA2M3BHT3B3Y3hSTnk5OExlUm53?=
 =?utf-8?B?bzRLb3NOLzd4MnZnL0htNEdxd2JWUFAvcS8xUmwwVWc4SVdFWHdzOWFlUTUr?=
 =?utf-8?B?ekgrT0tLR0dDSTF2UnJrcTlKaWJRd2R0S1NjTmduajdqVWcxU2FJWENLMk1M?=
 =?utf-8?B?QkRGUXJxQzBYdlY5SnBjbWV1L25DbEJSNXcwbDArNktlV2gwYVJ2V1B0WEtT?=
 =?utf-8?B?VGhHVGxvblN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3lIRGR2RU40QnAwRVVtNHBtTys3Z1hmeld5YU5XWElNVTdidkJIR24zd2Ji?=
 =?utf-8?B?c2RYZUx0TkljQnVDcEgwdGZ3MXY5ZEEvL3c4WUVIMnJTcnVUWjFmSzV5U1dR?=
 =?utf-8?B?c29mWWZZZ2pta2hITVpZd1JoT3h0OENYN3AyMVJHRmNWdVYwcjRsYXFhSm1E?=
 =?utf-8?B?dkgxbUQ3V0dseGFTT2RQZ1NQeXdFK2dybEF4UG14SE1IVFV6NGpMN2l2aUpV?=
 =?utf-8?B?NnZoN21RVWpwcXcwd1ZheEcvZWM5Uk1OSmsxR3JlN3F0MlRNSjV6YlhmRGNa?=
 =?utf-8?B?SnB1c2JES1JwKzUyMFVlQjM5cjFIQTNaZUYrVS9KVldWSEF3L2VwSWorTTFB?=
 =?utf-8?B?VGRqNUpwOFd6V095dkJiL0plWEx5VndEWmdKZE5UdXJJRzlEMmloV0xhRzVS?=
 =?utf-8?B?QXdvTVRrVUN0QWpmeTdhcEZWa25KMEJOSTJCMVBXeEFQeDdKWHBTS2lxVUlv?=
 =?utf-8?B?U2QvWEEvUDBMZENMbzdDb3dGVzQxekwrK0lMZm9DdGkzT1BnRUhiRWcvUFZG?=
 =?utf-8?B?WXMxWHozOFQwOXI1T2srWGNsMHBuS3RxbnpCUVRaWDZ1bGQ2OVFQcHZEdTE5?=
 =?utf-8?B?SitQWUd4RWkzb3BnYUdYSjlLdnA0ckhzUit4b2hSVEFQZDZnc2MwUUQ2TGp3?=
 =?utf-8?B?ZmRhWmVuaEZhN0RHb3M2YVdBWkk4aEJHMmk3RHBCR1VTTktWc2FmMkF4clJG?=
 =?utf-8?B?SjR2NUtoQ1VFK0FzSWhqZVZVaE9lemZXdGZ3QlhranNMVHA4cUZUQmJKN0lU?=
 =?utf-8?B?eUlmZFYweVljdC9rc1U1S2hjRDhZMWNuVkxCZEZvaTZqWXIyWnBkcitCS1l1?=
 =?utf-8?B?eUkwN0ZNVGgzMkNOTlhMTDV2cUF1MlJkU1RUakdLOW93cDNJZ0xNSGd1Q1FF?=
 =?utf-8?B?T2YyTzNEaVdXbWVFeTdIbDFVSSthUXRGL3JoS3BvNGJMU2tRVGZ5OElOaEJp?=
 =?utf-8?B?QXk3UnpubUw1SUpLNmRZQUV1VjYrQXhEckd2UWlZeklEV21CeTFscUNqUzRU?=
 =?utf-8?B?b21IWGlwcnhVcnE2bUFwRUpDT1pvNnptRXN6R0NETGVodmRzTXpMd1Vsakdy?=
 =?utf-8?B?ZlNBYVl1WStlZTBVS0RHQ0RvU1ZGcU9uT1ZodjB3M2ZMbzRQdklYVUx1K2Va?=
 =?utf-8?B?eVZMRmNJdk1yMWJPUFNQWC85QjE3OG1rTzNHRm0zWHljTGhUYzZHY3ZtT0w4?=
 =?utf-8?B?NWcxTlRhcy9seGI5RDJMSmRoVitGejBPR0syN2tVamROYVVNQkxGZksvQXZJ?=
 =?utf-8?B?RHRLTTg2M2hoWFg1MlRWVlZUQXY5QndFNFFteEZTRTE2cC9vbC9oTVlCa3FT?=
 =?utf-8?B?R0hIVDZjTUlrUTFkVnNnVVhEODc3blZtQ3h2bjNnRWR3R0RxaW03UXFmVTh2?=
 =?utf-8?B?UVJ6Q3RvT29GTG9CeGI4ekVJOCs0b0xrVkFXRllIVHNXdjdVSGdkdXMxc2Jj?=
 =?utf-8?B?V3pHcGE5RU1iT1U4V1Zkczg0bkxPdEp4UzdwVUg4VXZEeS9QVWkzaUpHTGJH?=
 =?utf-8?B?ZGRjVXBZUXMxU0pWSUduY2NBNlFVMHpBMHc0V2ZzT2xlRHhjcGpob092S1Mr?=
 =?utf-8?B?SGZuZVhUK3c4b3RNVnBWV3JZRzgyZy93cGxicGJHY1RJTmdQb0VEK1BQSEE0?=
 =?utf-8?B?VW5wVW03YUpMVFJhYndpeFByUzFtTnZkQnhqTllmeWg5eEMzRXNKS2ZnRFIy?=
 =?utf-8?B?bmpFZm1GYnhhZW9HY1BqbzJ3aDBKUU8vMjVNN21LVmliMjE4eTBocHNBejZU?=
 =?utf-8?B?M1IzR0xhQ3V4L2ZKTElMMEhTQWZKbmxZR2QyaTdIY1BOMzVtOTMzcnJPMjVo?=
 =?utf-8?B?VXdiZnpxc245QkFlMFlCVDhHMkN4OUh6YlJ3L3JUV25SRC9Bb3o3U29TYUdr?=
 =?utf-8?B?SGdoNHlWYURHd28wWlhKckdvK09PaUxFWm0yQlB6L1J5dGZlRGtMd0psMEYr?=
 =?utf-8?B?M05veUQwUUlZclIwRmg4U1lpOW5CSGtWYWRXWTdRSWN2Mm9Ud00vTHlpZEkr?=
 =?utf-8?B?TWVxN1RldEdmMnVJMWlkbzB5MEp6NTVjRDcrUUszS3hEWlM0bStkRnZDVUtl?=
 =?utf-8?B?WSt6c3dFVDBMZmZxNWNOWVZ1VWEvNVBIV0FKL2FMZmdYZFZVSm1pZ25kcEFU?=
 =?utf-8?B?eDI1V21rK1hkRDZvenRCZCtMMHNLM2R2QVd1ZExtR1hMMmI2RUR1eHhlYkVh?=
 =?utf-8?Q?dtGfTHnUliyYq63BXZbYZyg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC55B060E3885459D7629D9E593F399@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f22009-9897-4c23-fd42-08de1091653e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 11:02:58.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPcIXhMNeQ2BHH5hPakUVYOqCTLvFMbHaQkNvUqiUzV9pQEmjL4OcXeNZwG7BXx+yxp72Kx336f/Iww/+N2hOCSMBjL5gYXaRYHyXY+dSkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9380

SGkgRGFuaWVsLA0KDQpPbiBNb24sIDIwMjUtMTAtMjAgYXQgMTM6NTcgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gVGhpcyBzZXJpZXMgcmVmYWN0b3JzIHRoZSBsYW50aXFfZ3N3aXAgZHJp
dmVyIHRvIHV0aWxpemUgdGhlIHJlZ21hcCBBUEkNCj4gZm9yIHJlZ2lzdGVyIGFjY2VzcywgcmVw
bGFjaW5nIHRoZSBwcmV2aW91cyBhcHByb2FjaCBvZiBvcGVuLWNvZGluZw0KPiByZWdpc3RlciBv
cGVyYXRpb25zLg0KPiANCj4gVXNpbmcgcmVnbWFwIHBhdmVzIHRoZSB3YXkgZm9yIHN1cHBvcnRp
bmcgZGlmZmVyZW50IGJ1c3NlcyB0byBhY2Nlc3MgdGhlDQo+IHN3aXRjaCByZWdpc3RlcnMsIGZv
ciBleGFtcGxlIGl0IG1ha2VzIGl0IGVhc2llciB0byB1c2UgYW4gTURJTy1iYXNlZA0KPiBtZXRo
b2QgcmVxdWlyZWQgdG8gYWNjZXNzIHRoZSByZWdpc3RlcnMgb2YgdGhlIE1heExpbmVhciBHU1cx
eHggc2VyaWVzDQo+IG9mIGRlZGljYXRlZCBzd2l0Y2ggSUNzLg0KDQp0aGFuayB5b3UgZm9yIHRo
ZSBwYXRjaGVzIQ0KSSd2ZSB0ZXN0ZWQgdGhpcyBzZXJpZXMgd2l0aCB5b3VyIEdTVzF4eCBzdXBw
b3J0IHBhdGNoZXMgWzFdIG9uIHRvcCB3aXRoIEdTVzE0NQ0KaGFyZHdhcmUsIGxvb2tzIGdvb2Qg
dG8gbWU6DQoNClRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRs
aW5Ac2llbWVucy5jb20+DQoNClsxXSBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vZGFuZ293cnQv
bGludXgvdHJlZS9teGwtZ3N3MXh4LWZvci1uZXQtbmV4dA0KDQo+IERhbmllbCBHb2xsZSAoNyk6
DQo+ICAgbmV0OiBkc2E6IGxhbnRpcV9nc3dpcDogY2xhcmlmeSBHU1dJUCAyLjIgVkxBTiBtb2Rl
IGluIGNvbW1lbnQNCj4gICBuZXQ6IGRzYTogbGFudGlxX2dzd2lwOiBjb252ZXJ0IGFjY2Vzc29y
cyB0byB1c2UgcmVnbWFwDQo+ICAgbmV0OiBkc2E6IGxhbnRpcV9nc3dpcDogY29udmVydCB0cml2
aWFsIGFjY2Vzc29yIHVzZXMgdG8gcmVnbWFwDQo+ICAgbmV0OiBkc2E6IGxhbnRpcV9nc3dpcDog
bWFudWFsbHkgY29udmVydCByZW1haW5pbmcgdXNlcyBvZiByZWFkDQo+ICAgICBhY2Nlc3NvcnMN
Cj4gICBuZXQ6IGRzYTogbGFudGlxX2dzd2lwOiByZXBsYWNlICpfbWFzaygpIGZ1bmN0aW9ucyB3
aXRoIHJlZ21hcCBBUEkNCj4gICBuZXQ6IGRzYTogbGFudGlxX2dzd2lwOiBvcHRpbWl6ZSByZWdt
YXBfd3JpdGVfYml0cygpIHN0YXRlbWVudHMNCj4gICBuZXQ6IGRzYTogbGFudGlxX2dzd2lwOiBo
YXJtb25pemUgZ3N3aXBfbWlpX21hc2tfKigpIHBhcmFtZXRlcnMNCj4gDQo+ICBkcml2ZXJzL25l
dC9kc2EvbGFudGlxL0tjb25maWcgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvbmV0L2RzYS9s
YW50aXEvbGFudGlxX2dzd2lwLmMgfCA0NzEgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4g
IGRyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwLmggfCAgIDYgKy0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMjQzIGluc2VydGlvbnMoKyksIDIzNSBkZWxldGlvbnMoLSkNCj4gDQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

