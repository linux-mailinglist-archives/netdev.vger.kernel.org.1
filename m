Return-Path: <netdev+bounces-180743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC657A82527
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA921BC35B9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0C25FA10;
	Wed,  9 Apr 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esmypyUs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8525E836
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202432; cv=fail; b=nVcV4HDyDSOgwJ2tDpyD5F3UkkAHXRJavfcVdnUUvE/j/wUmKswUy+nf/RROTqXnFPSakc72+AMxQAQ7Fg5ELaQZfgbuC0pn1kAw/V84dDx+xwhi3meC+0wJOAtVyH5yb+800vxwpa47EILQlT8lAl5i5syu2TvUOxCJz5oz8jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202432; c=relaxed/simple;
	bh=9rumd7ZQ9AdR5jct7lwrj56HdojTn+D8Mbgq6KaNtYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBo/zSKFses9eo5J/hUi/MGjAaM88SCW5BgFZaC46Mg88D1ZaBBxuNkBOXOykwVD8OV94WDFyQsODtHTP+UQaVrCWVLBY1TzUc1cuWafPVAMxZYaJTWqwbOexZ/6pevCJfjWPFS0yC0HT9Vv1EUtHW6XsB736tepbvHIeP5o7vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esmypyUs; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqUmPatD5qY/OxF5jwYP3OQuOn+2Xsw+gPRu3H7RltHFxhooqE6hc7o3zdhqrRJrsLBK9lG3iYCtYCgmtFnl8J72Ygso/5DbHAK898JEy6NDeVwc5oo2M1OpI1trifgFsHF6n9U8pfr/M+i2J9s1UlsyQG5GoVbp/w0s3zO0wqlzWtP8A9ldXLtjjmhg82ftZ1mG7Gk6th4h+dWHsI7pX/o+moziPMI7CeydMp+KDiUFr+Qf8SJa25yt3w9t7W2ApWkC6umEUr2n20wvXrGRIlBXIBsVwk/TURLIZu4/pry3TLIMimI636hbL9pAU4RuXdZoL6QvYWGpRdyyh9h5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2ckFg9GNQck5RTxW/s1uuEQVkaG/eW2EcTfJstHpQU=;
 b=oqBKKvgEnP1MYzxJQDwQQZLnpLyYgBOOHrXGTOBHaV9ibsl1BEzh0NFfmMjRed38E6CnXQuiut+mVlcOqhU3EAW7E6fTspjAzR6hTdR1RYb8dxcnxHG2rmA6UXet526MCRSPhy6dFOoZzzgsRK5mOZJuHREtnjRbV8OTYUPmpntAxG9eZ3pEC9ohSkzkVPTkCpe6BpgTWyV3YdIfHDbeiSNYmqmNpRMYrBzbOn6K7bOTOnGkMi58jSBtCnlWaQnZeFISH4rVO2sbasvhDLHFYGUicATWkTO38u5kPlmNK8BX1y8Z+O12qiS2aJzXY0uD3NCYxhOSokls+ssIPioZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2ckFg9GNQck5RTxW/s1uuEQVkaG/eW2EcTfJstHpQU=;
 b=esmypyUsBO4Hk6zbAH3RFXrpa3oVoAeh530u129qDJMyR73hDNLiakiEnRBIFLjoOSeoXTuC/OcvopRYozAIlvp9QnHNELZydniDrqWvRarMVTN3hB0pjZMgE0b49vaUsQ3bIY/5tXUfNnxmmcHstpeeQF2ibLBWGht3KSNNjFVY3Z0BPWPn0fj/KdA51BOF4Qvu6HDm53lEFfW8nzaxRLay6n1jEfeWujDbYmG+LvU8kIXTzcHDD8LQkLsy0dIPYFAMJrtXpN68uIGZ+NzcD7NNOiw6yo/CVtQDnXoebHmOaO+guDS0tUv0ZKE8JkYV6KD0dV//sl24nqihaFC9uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 12:40:25 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 12:40:25 +0000
Date: Wed, 9 Apr 2025 12:40:17 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, 
	Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, cratiu@nvidia.com
Subject: Re: [net-next 07/11] net/mlx5e: Convert over to netmem
Message-ID: <2c5lwvqvqicmthhu6uyu4r6rfanxxz6iloaysz7uvw4qpoeojb@g5whyniwnf67>
References: <20250116215530.158886-1-saeed@kernel.org>
 <20250116215530.158886-8-saeed@kernel.org>
 <CAHS8izOfkLtFzqsfnacQrVaiW0ZkHRoeZwNK4FVV7j3yR1T_vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOfkLtFzqsfnacQrVaiW0ZkHRoeZwNK4FVV7j3yR1T_vQ@mail.gmail.com>
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: eebff922-f63c-456e-87b4-08dd7763b388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFVVeGFESnVFSm80MHBrWG9ic01MeUpQNk9BODRnT3B0VS9jeXUwMmxQSHpT?=
 =?utf-8?B?Znd6Q0Z0QkYzdzhjQXF4QTZtRHFwRjBzTTg1VkJOZ1JLdWdnNlVZUXAvc2I2?=
 =?utf-8?B?bzFJT2l2WHZkQzNFR2s5bjZ4V01idU1KQ1FxL1MxRGU0d2VIRjV4WEdPbDRZ?=
 =?utf-8?B?dGVrQUdLMitnWEE2WGdTbVVWejFyWExuNkpPZDMzSEV3SDJCNldNWWsrcnRJ?=
 =?utf-8?B?ZFJIVjBkUDJrd0tvUUR4SEJxVUxKUnBwMHVXQkhtQmRlZVN2S1RzYjNIejhN?=
 =?utf-8?B?ZkZiVGRZSWNjcmNieXBjeTRIdzhWanJsNW5KSnVVR0lXWG52VnVUbW5ueml5?=
 =?utf-8?B?cTBKRzJYSGRvellMS1JBeXYxZXpiUFRVTEg2ZkFHVXhrUk5BUGZaMUgza2tQ?=
 =?utf-8?B?bjllVHBPV21sNlB1V01IdHZ1TTNuMDZqSE5WUGVnUzN6b1ZIMlVPWi81SkRN?=
 =?utf-8?B?SjZPY1hKOFdRYlV4NVBtS2xRU3Bld2FiM2M1eXBIQUxnVW5pc2lIb0Y3Sjgz?=
 =?utf-8?B?S0h2MEp3QjFaM2NOVFNSSkd5Ny9WeXBwd09jazIrY3V2YlBxUW82UDBNU3pP?=
 =?utf-8?B?Y3NONzF6WThya20ydHpIb1VIU1lnckFRTFU5NVBKNHltT3VOTjlRaGhZRy80?=
 =?utf-8?B?cjlVdlM1b1ZOcVliN1MzY29VeTA1QnZ0UHhhTm12eHpJZGVSdzNTMVFNdzYx?=
 =?utf-8?B?YXdZam1GRjRDVWFEK0N5aEREcG1CTnNFVTFCbHlvU1FNWkE2WHpxN2pIdTlW?=
 =?utf-8?B?L2ZKTzJ5SHBJRC9mK1kyZVUzWmd3VU9VMk11WTBDVFg4K05qMERMWFZNelZw?=
 =?utf-8?B?RkthOVpMbVRwQTBvVGpxbGtLSDZ5Y1FZSlRaZ1F4NzNXK2pSaEFzVHhWNkk3?=
 =?utf-8?B?Y0pRa001ejZsVTJQM0hyUEtzdEJLZXU1M0dVa0E1T2N2WE5nMDlYZmFneHl4?=
 =?utf-8?B?blFiUWpTTDNPdlRLQXJSUWlPWlpQaWFXa05XcDhCRElNLzQ2MG5vOGVlZkFC?=
 =?utf-8?B?a3ErTCtueUd1QlY0L2s5M0xacEhjY1VBTFhBQjJWMEJtVWFmQW5XNDdubGlx?=
 =?utf-8?B?WE80ZTE5QnhvK0Q1VmRCV2dneXdNVkFZUzB4TWM2YUdyMVY4bjlGVTM0dHIv?=
 =?utf-8?B?MFpoSHVhcjJ2Z2RvRWxwZ1hZTWpRbDdJMXVCSzJuTzBMREIycVdOMSt0c2l3?=
 =?utf-8?B?UldSY213L2pETVozMUdVaTdydGVnOFdsOEFEck41T0pFQS9DaE5nVVoya2F3?=
 =?utf-8?B?OGQrKzAzU0FrL1pXT2xLZ1o2dUpqNkU1T3pjRlU5aEdMQVFiVmtkOXJMOU9j?=
 =?utf-8?B?a3Zvek5MMHM3cm16RFlvNjVFWk1wMk40T3loUnc4dzlYSG4yaWZ1RFdzSkVk?=
 =?utf-8?B?ZGFGTVNkRllmSmVLZ0hMWjI5TUhGRnlKM0VLRm5BZ0JCZUEwcjI3cGM0c1FE?=
 =?utf-8?B?QStIdnpSZDZpR1VMTjFYYVZ5Njh3ZzZUOXgwd0FKQWlNdjl0cDBLMHB3Sm5V?=
 =?utf-8?B?dUQxaDQ1Zk9kVmgyVkVaOURzNmRJMHJ6dW5DdjE0ek5XMk5uZXplYTdjVWRr?=
 =?utf-8?B?dk4yZDArM1ZZZzR3TiszM2hiZTlSZ3B1NUM2bGRnemhxYnZ6b2ZDOW9iejhn?=
 =?utf-8?B?aEt1QnFGK3RkM1J3Vkk5VFhkU3RqYzlaTVhNUG1ML3NEdis2elFOUjhRUVg2?=
 =?utf-8?B?ZmtMS2VkVTBSWG5ZNU9RSHBCekIrcGcvMGlaVitmd04zdUV2cDZsTXNUS1RK?=
 =?utf-8?B?bXVGcTJvYWxncXMrTHpqZzFnblllVG8wQnltT0FTaGRLWjgrT0VBRm45REM3?=
 =?utf-8?B?aENkd204R1o3ZXFCbytmWW9OOWlZaExveHhpN3R5VHFsVTZtYmU0aHdRQjVC?=
 =?utf-8?B?V1lVUml4TVFKd2NpVHFYbEZ2dS8vbUlVK2k4eWhQUXZEckxPYWpnTGdFYW0v?=
 =?utf-8?Q?qR9asXJR6+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnlqWERrMG9Yb1NtZEh3cmo2ZEU1TEZoV2VxOXRncWJhd3VYRzFwYkFZOTZq?=
 =?utf-8?B?Ums0a0R4YXN4c1R4SjlNOGlNMmJ6bFUzckR1SjY3L3lvaEdFSnZFVmdrbjlB?=
 =?utf-8?B?amM5NU4xRlNHeVk1Wit1bkpMMFd6STNVNklXcHZSck9ZM3FzSytvRTFDMDRC?=
 =?utf-8?B?aEpaamZvYU56UDJPQUJTQnZyRGttWG9vVGNRMngwR3d1U1RTY3Q5dFFNblJZ?=
 =?utf-8?B?ZVV3RUlEa3ROMy80R2FrMkJBR1NQUy8yWUovdGRwdDBBQzRxYTl6QUcwMlRE?=
 =?utf-8?B?RGdlSGw2R25rcHVPQ1hmY01VREZFbzBNV0xldVRia0VPa3BzbG9NMzl1UEt2?=
 =?utf-8?B?ZnpTcSs3dGgydnFrT05WM1VqNEk5TlpxY1Qrdm5TR2pqTDlMd2tVNCtFUFNP?=
 =?utf-8?B?TDNRZXVWVUFLNUNIUTFzYUhTWVh3dDZuTEpzenFkRDVlMVdVVFpoRzJCZTQ2?=
 =?utf-8?B?aXo3T0hUMFRnN3RyRE1uNFdOKzdjSlBzaDBXRVcwT0xUSlp4SGVNTGc4eG5H?=
 =?utf-8?B?LzhPcjF3WlJyR3BvUWdGVWVmMkVOcXhYSEJQTDk2R1gzc3dXRWhHdlJUcVJD?=
 =?utf-8?B?VXI2RXo0c2VFdjJxME9WL2dqU2ZjdzJUenJHZWdzakhMUVhCcGQrVFkxaFY5?=
 =?utf-8?B?elZGVUxidTNDZEJLNVcvTGw0azNFVHc5bHlkYkR4QXZDR21VM21qdDNTTWFZ?=
 =?utf-8?B?clBRN3h5bGUwd2NhTEJZcU9rMjk1SlloOUFYcGo1UFNHdFVjcmhIM3RjUDFD?=
 =?utf-8?B?bXhLODVZMHpHM21OZHhmTVZCeUpQQm9udkhGS3Q1YXJnQmZPZlpXZ0RiMU9H?=
 =?utf-8?B?NTJzMU9zZGZYMmZKWTQ0LzhyL2dUM3JvNjNPT3piakpMMllMLzlzWFZzMkZI?=
 =?utf-8?B?SU5qTGlMY3g0UHRqYWJHVUgvY2E1WW4xSzYwUUd6d0grRUZmTG9jU2RTSTln?=
 =?utf-8?B?M1orYk5qVUUrTmtJbjJEN3U4RHN2MHZBdG16UGZYREhHa0JMWlR2aVRpVkNC?=
 =?utf-8?B?Z1FIemhRMzA4d2t2dDFRMGhUZHE3ZDIzWmV3TXBiZE9IZ3diajZ5OFBvRjNY?=
 =?utf-8?B?bWZrc2pPVXJnNWxwT0lOcE1QTG1HRUVXc3dBODgrOE9FcWNkb20xNFZHQndY?=
 =?utf-8?B?a3FMU0oyb1laR0ZUNSt1QmJMbkREaDRYeS9FeVI2K0o0aTNjNTlidGtFdmFl?=
 =?utf-8?B?UHVLSnJISUtJN3BlTlpyK2VKM2kxbEk2RXlDRERlZDJzeTU2ZVRyRk1kYTM3?=
 =?utf-8?B?QmcxYTk3czltVWdKODBXcFcyenJBK2ZQRnh6SFc3dW52VFZHenVTdzRMZnc5?=
 =?utf-8?B?c2J1RVZJMVZxL3V0VWx0U2RWUDdXcU8zUi8zdWNUcEtNd2liNTE5KzVVT0xx?=
 =?utf-8?B?NkFUZVNTNEM0bzZLYXVLbDZwZjd0cHU1VmxXSEVCalN3R1FSdHZESlY3ek02?=
 =?utf-8?B?cTU4R1FIengwd09XTzlwNnREdVArMDRWbzVHMGxTMW9pd3ZTRkNOTE5vV3p0?=
 =?utf-8?B?QkJyT2FlMnNRSEt6Q1pwckV1b1BRUjFyaGJZdXpReDdYQjZwRWNabUtEUmxw?=
 =?utf-8?B?ZzBqQkcvWVRyTFdVcDE4Q3IxOE1KbEVZMDJtYWJ5bzQ0bzR3WC85RFJsa25o?=
 =?utf-8?B?ekUvdkVUcFdEbVBSWlhjV0w3R1VxU3R6V3dkY3lXNVM4aEZVUzN6dkN2Q1Bo?=
 =?utf-8?B?UWZ2L2J6a1JhWkJTbndEcnJVbkdPOXBCellLaW5COHVEY05JOG9pZkdNZ2ps?=
 =?utf-8?B?aDFzQi9BeGE3TGJTUWVDYUVDbHpwNzFMMVduMmZ1a0puVVRseHZMcVdsREJ2?=
 =?utf-8?B?eVVxZzR1Q1BJcW0vMG94Wk1DZ2hwM1JWSXFFSE5xaXlxNmlOcHNWeTlUR2Jy?=
 =?utf-8?B?aDQ3ZmM3MlNiS3E3SEhsNk9nT29BbzNyZWMyUkMzTHNNTnRudy9PdWRETW9z?=
 =?utf-8?B?bUhUWGFaNDYvdFg1TmJHWXFNOVRNS0haanJlOVZlVXNSdnArbVFZZWp4ekVi?=
 =?utf-8?B?ZHJGMnR1eDVUTUkrUkpCbmdMdkljUFdTK0hRUGp0dnVtOTF1VnUrUmxLM09s?=
 =?utf-8?B?cmdTN1EvckhNRDN5dDUvZ0ozL2VuNUkvOE9vNDJXUDF6bkxqYTVRZE5SeFVS?=
 =?utf-8?Q?gY/Y1tUX0zHnYkNnf3gvP9Fvv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebff922-f63c-456e-87b4-08dd7763b388
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:40:25.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRsyHl3YX6etTDPDVk62GwhwaBiWSNNlj9g/JiDwudOpzbCquBihtxHkBfUMCKOYmRnawEZOvNZUowEskY1zAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

On Wed, Feb 05, 2025 at 12:14:08PM -0800, Mina Almasry wrote:
> On Thu, Jan 16, 2025 at 1:56 PM Saeed Mahameed <saeed@kernel.org> wrote:
> >
> > From: Saeed Mahameed <saeedm@nvidia.com>
> >
> > mlx5e_page_frag holds the physical page itself, to naturally support
> > zc page pools, remove physical page reference from mlx5 and replace it
> > with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
> > pages.
> >
> > No performance degradation observed.
> >
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 80 ++++++++++---------
> >  2 files changed, 43 insertions(+), 39 deletions(-)
> >
> ...
> > @@ -514,9 +514,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
> >         }
> >
> >         frag = &sinfo->frags[sinfo->nr_frags++];
> > -       skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
> > +       skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
> >
> > -       if (page_is_pfmemalloc(frag_page->page))
> > +       if (!netmem_is_net_iov(netmem) && page_is_pfmemalloc(netmem_to_page(netmem)))
> >                 xdp_buff_set_frag_pfmemalloc(xdp);
> 
> Consider using:
> 
> netmem_is_pfmemalloc(netmem_ref netmem)
> 
> In general we try to avoid netmem_to_page() casts in the driver. These
> assumptions may break in the future.
>
We will fix in v2 which we are preparing.

> >         sinfo->xdp_frags_size += len;
> >  }
> > @@ -527,27 +527,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
> >                    u32 frag_offset, u32 len,
> >                    unsigned int truesize)
> >  {
> > -       dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
> > +       dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> > +       struct page *page = netmem_to_page(frag_page->netmem);
> >         u8 next_frag = skb_shinfo(skb)->nr_frags;
> >
> >         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
> >                                 rq->buff.map_dir);
> >
> > -       if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
> > +       if (skb_can_coalesce(skb, next_frag, page, frag_offset)) {
> 
> Similarly here, consider adding skb_can_coalesce_netmem() that handles
> this correctly in core code (which future drivers can reuse) rather
> than doing 1-off handling in the driver.
> 
Good point. It is definitely worth adding as coalescing is desirable.

> Also, from a quick look at skb_can_coalesce(), I think it can work
> fine with netmems? Because it just needs to be converted to use
> skb_frag_netmem istead of skb_frag_page() inside of the function, but
> otherwise the function looks applicable to netmem for me.
>
Having an extra skb_can_coalesce_netmems() which can be called
by the driver on the rx path makes sense. I don't think we can drop the
skb_zcopy() check from skb_can_coalesce() as this is also used on the tx
path.

Thanks,
Dragos

