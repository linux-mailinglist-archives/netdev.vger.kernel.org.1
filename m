Return-Path: <netdev+bounces-231981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D825BFF5D1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC8D3A8C39
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2729BD8C;
	Thu, 23 Oct 2025 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="deWpNoTx"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A929B795
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201370; cv=fail; b=qe/cJNzbz5wlicjKb6OvNLlyPqgcBPYiL8YWNtteduQu77Fy7TeFxwsXyB+ZOygTxPRVJ3hmE91ZbZ/30VsAd0svBsVOnauNTfKNni3CgueQLdPbvyJfF9pRtyMJ2CfGe/zpJhxxFfTsRb3S0AU3WLgjhfvoxH9hk+DFfoJvUTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201370; c=relaxed/simple;
	bh=699m0GtW9u8j4IipWs5Zw+XMp1a1WwBVZk6rQIurD5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrFKW472hTkZlwJB+/56fxB4m6aLl8wmz52QpOUUoYkWgzFVapC6xxUy9WGJ4MJFfXVD9wwYecUYI3nrAO8Gc7SZNCqnKuol7poFDuMItevo2pyXhn6L02hJGdalTzfDAaSg6bTO3QqKNyCoqDVEJ1+cAFJjBxDrekxEL+9dZ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=deWpNoTx; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag242Djurq7kUUcXGgLqiv0uX4GoIUuiRBfJpn2zZUQSMwAeq/ah39DM3grv1V/ejH/7nwJFyhYypMdbLAztu9HShGTB1tuaqQhhtt4tK3eKJEcds3cPNKIixdN7arVxoZ7IUS+QY3dPueKt8DO9t6u9+qenhYhXDRWVGSXpT8gRnW3BAqVmuSgIbqdpn0iEjA+YdqyttizSa3cJoCLHuiWuqWqpYZP57Z2iS3BJ5HJXdbW0OCho6zOU34L73PSLjKcfaJXPS2ivPCeedsl7YH6reGwAcjuPY0XizrQvDKjExO/u9Ou9v0y7HpQVO6NeR0hzI8MLLz+wJWZk4lxGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=699m0GtW9u8j4IipWs5Zw+XMp1a1WwBVZk6rQIurD5s=;
 b=aJtWk7NC+ym2Zvb0gbA9NpWYdqmDAYP4au1DKMEnyRe9p41dti3D8y0bK4SDCMudAG+gMiAzdGLcKWXYZ47AbEfJpNx683ScLwJlmB6ILdpEy+rs9WKiNnbaUuMcaUUTCzuR+EjBF7cudWmaTKuMpOyLu0woc8kfvDf6U58Y0dU9x0DO6PwKT/23hRA5hTYAiceBkIaBQqzRNYDpGFjBnyKsXvkwc4vvzOesso+gx4maeWjdbTlI5TNbRN9k3ruBxhGaCb4fnh1+PYJqCPV0KVi7g9lmbjk0tfqHtbB5uK2ZFvhPr/YpUBT6HRDIuprFLG9pWA3h4hdzvhDYAbveqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=699m0GtW9u8j4IipWs5Zw+XMp1a1WwBVZk6rQIurD5s=;
 b=deWpNoTxrk8odTgBxeGtz40YT8JKV/lypieJe8ioGaPUeuWwt0mdyo4w6QcjFadTa+EAUNI3CzbMN7TDNqvXPe2UW9uEB9nPjS9muCt90HsG3EenyY+GqnWijZDJ5YRK+zHhoQDO9askgI582go969UOIGgExbl7j5WRBDL7mRu5CLKnuXFqQ6b8SJZPhQ1IeXJX5bn4IAIyZZh9al40LSvaslXW9F2onDTI3Y07H/aIee7Yq2em/VoqAeV8wk2OgVAWHe+2/6gVsxxbpVFI7pCTzrG209ni3RBTOW51uBFEorYW60PEqL+oTq8lezfcJp9zen2Mh+ySW6R1UilxqQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:36:04 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%4]) with mapi id 15.20.9228.011; Thu, 23 Oct 2025
 06:36:04 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Johannes Eigner <johannes.eigner@a-eberle.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: RE: [PATCH ethtool v2 1/2] sfpid: Fix JSON output of SFP diagnostics
Thread-Topic: [PATCH ethtool v2 1/2] sfpid: Fix JSON output of SFP diagnostics
Thread-Index: AQHcQ2Ob4tQEr36Av0eZO1i8rbq3uLTPRzaQ
Date: Thu, 23 Oct 2025 06:36:03 +0000
Message-ID:
 <DM6PR12MB451625174F9F4D445BF936F9D8F0A@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
 <20251022-fix-module-info-json-v2-1-d1f7b3d2e759@a-eberle.de>
In-Reply-To: <20251022-fix-module-info-json-v2-1-d1f7b3d2e759@a-eberle.de>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA0PR12MB7556:EE_
x-ms-office365-filtering-correlation-id: 7b9b328d-61e7-457b-1d3e-08de11fe7085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXdqYzN2OW5PNURJWTQ4dlNoVDNmcmdkZFBsTnEvQU1XZitoWjdjLzh4Qkt3?=
 =?utf-8?B?RUU4ZG1BMjZhdW1KWnNJSnJndTExbGNpcmJXOVZ4OUx5U2dYcVRVODFWaFNM?=
 =?utf-8?B?bGdFWG16ZVlheFUzb1hkZGtVdjMwMkg2ajl1MmcrUTd3a1RMVEFoTktvQ2Vk?=
 =?utf-8?B?emNCQUZSdkRYL2cvRmF3M0FsZWRsd1hPZm5jRkhIeUtXVTdvb09qQStwMDJy?=
 =?utf-8?B?RVYraG15TnBaQ2RsRmw1NDVtajJoSHFLN3NCbGRpbGVCU1g1S2hTRWEyL2Fj?=
 =?utf-8?B?L1lnL1UwejBQSmVMMG9BT2JqazJNRWdOanZPZmwzU1VCUVN5SzBsWFVjMmp5?=
 =?utf-8?B?QitMRTBZVi96N3hrUWkwY2ZqS0ppbm9jZW15eWVmZkE2MHZqYkxuTDB2VUY3?=
 =?utf-8?B?Tk5HUDFTQzhsZHpBSVJYQlNSekwwbUN4NzVwQVNiblRRRUUvbWJoTU40SjRL?=
 =?utf-8?B?bWtNdWZtRUEzNWZnbWNrUEx4M2NIREFCLzR3WHE2NXNqZHVycTAyVTBuYnNu?=
 =?utf-8?B?aG83cjVXTDJNVHF2YWIraHpNakg5c3BzWVQ4azgrQ1hJb1dFeWcvcXlmMVMy?=
 =?utf-8?B?c0xKNzk2R3g0S1hoMlFJRWM4ckxCY1g4dFcvTHRSZ1M2MnhxNERWM21hek9a?=
 =?utf-8?B?enB1c2lTbkJVVTlDZ0FZT2NPbkVJRE1GdjcwWWxFQjlBWW81QWd3TzFaZCtQ?=
 =?utf-8?B?cGcxT0hvK2VXaGpCdEFBN0RUZkVNUTJVa21ndnJTU1V5MEVUdXRCU2FaVU5w?=
 =?utf-8?B?ZWdVNkd4TTIyd0FMQkpNaDdMYVFSUHdWV0VGK25QNkk0SHk1MHEvWGZmREJx?=
 =?utf-8?B?NXQ3VngvVmNqR0V4Y1cxRlJ2VkYwQ2R4VVV2RWpjcFArUGMybjZhZ2VEN0xy?=
 =?utf-8?B?YkNmZDNHbW9UWTFhSXlPbnhHU1BBM1ZCa09WUC96WCtxdWc2eG02NjZRdk1R?=
 =?utf-8?B?RmRCSTE5ODVVTVRLYXk1OEE2QmgwK0ViSGxEaXBEYkU5a2ZkMkdZaldxdmUy?=
 =?utf-8?B?VHNVdW5IUVBQdHJ2Mkp0a2MzbVFOQ0J1bUNqOUtraWdoK3JINWNrbThGaS9h?=
 =?utf-8?B?cDF5UGRuOU8zOERJVlJVRURVMmRRb2RjaXJQZjRDWE96bzU0bm5xNlY3bmk3?=
 =?utf-8?B?QjRXOTBOMXVvN1RKcE9qZXcrZmlWbGNtcTl5djJOdjhSQTF2cXk3M3ZUR1o2?=
 =?utf-8?B?ZDhMOU1Eb2NWazlENVR2azhQZ01qMWhLUjB1MFhZUHgwMFpnVDFpa3NIUmVy?=
 =?utf-8?B?RFVOK0JEK2NuTEhMYWwyN1ZKWk05YnB4ZGVjRE5rRW9sVm1XNFJLMHl6ZEhh?=
 =?utf-8?B?NklMRmw4VkJnSDFVSmQzRUJvMU8wUmlsQVhZbjRNOFJBS0c4WEpQOTJGVXdC?=
 =?utf-8?B?T3cyOUloUlZMWkx0engrZUk4bHRlT3J1dHByemZFV3V4aE5zL29jKzU1MXhQ?=
 =?utf-8?B?bXBSOWNncndSRUxnZHJlYWhKd0JVWlBCZGdlSTlueS9TS3gxU2ozMFJhcjBR?=
 =?utf-8?B?ZDR5b29qNm1LbnBnRDd6MGlqL3ZNcDZuQzVYWnJNcFNEWmQvbVhZVkxzN05w?=
 =?utf-8?B?VnQ0RENEeEhWUVg4ckdLL1REVVhnL3htMGhGS3lpVTBvN2d1ZUxIMWEzZS9h?=
 =?utf-8?B?a3ljc3R3L3M5bXdoc0pLa3ZuSnRDclAxREVlOUdUYnlRY0pYYzNPMnpGM3ZP?=
 =?utf-8?B?dTV1YmhtVGpVZE9YT1duNDNkcHlyV01RQVRKNDEwYmdjZ0xJbVFJMHZoSVlH?=
 =?utf-8?B?U2FkYkZDUjh4QzVxR255M24xWnNQZUV0dlFlUGg4RURybmpBZWhUUWNyYnBM?=
 =?utf-8?B?M2RFVExvMnY3MnBmV0JybVRYckVlYkdhR29JWk5tSU9qZjFoWjNWMTJsRlBN?=
 =?utf-8?B?UzZ0NUI1bE5yY1VmMm55UGVWN1VXMlhyTEJub1k3MkVaY05NZTA2TEFpdC9a?=
 =?utf-8?B?bk5CRm5ZeFV0Z2R6clBGYmRZQWhsekxKYTZsL09kMVlreGd2NFc3cHljRUQ0?=
 =?utf-8?B?QnNKYkxFaG1sR2QyMzNabWNuVE5SeWFTRWcyOTdLWFZkYXNpaXFEampidmQ2?=
 =?utf-8?Q?3yzyuG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDQwSHFrVWJwN0FlQnRmVU9kSitKY1R3NjJzYno5MEE3NXNOTVhoZDY1aHpK?=
 =?utf-8?B?TWlVdE15VEpJOEFuZXVNazA0NUxqYStpWG5RVVQrcWliWEI1d3hYRXhkdHlE?=
 =?utf-8?B?UUUzT1BzVGJORTY2WFVoek9rUUNIMExjUENJTjkxYXYrczhkdC91TlNOWncx?=
 =?utf-8?B?ZkZvc0VjVlQ3QlpHTXkyc05Va09PSStIVW1oWVJrODZnMGROVXlBcUVKZHhu?=
 =?utf-8?B?M2ZtcjlmTzZpc1VtcGRMMDlqOUtxSlI5OFA3QnR1eitpWDR5d3RxT0YxMEVR?=
 =?utf-8?B?eXROdXdBbEVJdFR5bzhrNnQzSjU1cmV3WmoybjNnVUdERDI1bkxadG5aZHlQ?=
 =?utf-8?B?OGsvaXY4OTN2cGZNNDR3VERRS1h3SmhpVEVPOEhzYmdPN0lVS1o5WlJJTkdo?=
 =?utf-8?B?ZmpMdkJ1eFNRSEtmOFBacEdhSVc4ZmF4a0c1Tk9xT0lCeEtoRzVhZWhIZWpj?=
 =?utf-8?B?U2h0b0tNY2hOOTEzY3ZtRTlvczNxczQwV09vbUxwRTF4VmhkYkJaSUlYUDBM?=
 =?utf-8?B?cnQzZTc2QjIzcFlaVUU3VTRGQXo5dnpwWWs3OWd0RHhIUjgxQWFvT3NRbXUr?=
 =?utf-8?B?cGgyS0xna2gvL2RvTUgwM29aWDZKQkFqblNWL0NpOUFCN0xTWldMaW0zRXM0?=
 =?utf-8?B?M0VvamwzVng5Qks0ZUxDZkU2d1krZCs4MjhuZ2tkRDhFRDdXRFR2ZUYzTkxI?=
 =?utf-8?B?RG5zK0dMaEYwOGMrdENEbjB6ZTg2UXNMcEtnZytwQWJrUnJBaSttVW5FcEc0?=
 =?utf-8?B?Z1U2dWdGc2FlWDFrK2lBV1F2U2huVVRxKy9qYk1NS1dkSmQ3cE5QNzVJVzBv?=
 =?utf-8?B?d1B0RFR1ZkNsYVllWCs0UlQ0YmRzWklwdGtrbGI0djBFckFGVkZZTVpLdCsx?=
 =?utf-8?B?S1dVZE53bVBDaTJSVDJMUEUrMDZxRURMbjkxTXdqUXFzbWtrRFJTbHViY1ht?=
 =?utf-8?B?UktveFdnQk5vUk1rUWdvSEtMTktHWTI4SjVVVEZzblc4VFlYSmlIZHFtMVEw?=
 =?utf-8?B?cWpkM2JaNDlHNVpqM0VBcjExZkRZbW9xRnI3MWxPUDR2Nno1cmZEWFNrOW1o?=
 =?utf-8?B?MDMxRFRNWExxTU5xZERScmVuKzVzdDlyUzU2SytWeFNBZUd2VFZ0d3hXVHlO?=
 =?utf-8?B?SUptT1B1K0loa1pGTkFoelBSWEt6WWQ0MmNVK1lQWkxlY1owaldlTVpCanRM?=
 =?utf-8?B?Y2VPNkowSEs5dXZ6d0VXWmlkZ2xPdjB6V1VQb2RtSmpuVkN5Ry9pb2RaVWZm?=
 =?utf-8?B?ZUVNSXBac1NRQzJxQXFpZDVudGc5Z2hyVFJkWGR3aFhIMzQ1NDFDQnR4WCtl?=
 =?utf-8?B?cURFL3JGWTdta2g1Y1pmTW5DWEdRNnppelVnckF2dm90bWQvZndnZzRDREhG?=
 =?utf-8?B?WjdlbFdNbnlZbUFmeGFLQUk1d2hybWwwNU9KSnJsQjlhOEYzcEpGZmtmOFRM?=
 =?utf-8?B?SFZmU3djK2pjWVRhNC9FSlQ3UFM5SWlBNkhYSjZsOW43MVpOQlpWbHdrYzRt?=
 =?utf-8?B?YXlkeHBnQms5UUhCZzBndzREdnZwYmF6a0Q2Q09XUlQrMFU4YkpkWFhYbXNH?=
 =?utf-8?B?OTNlUmkxZDVwNzB4bG5BY3c4cEVMNGpFTDZEWEJzN3NScGx4U2ZKeURRUDdC?=
 =?utf-8?B?TnBOM2FqaktGYWV2ZmpPY3MvV0FHVVJRYnRRNWZFb25pVlZNN0NNV1dmT2ps?=
 =?utf-8?B?QVlHb0syVlJxdEFqYXo5T3dVNWxJd28yS0dSeHVyRTIxUEo5enNDa05seGhC?=
 =?utf-8?B?TThNMVRIZ2dJd2tSSW5NQWd0VE1oNVZNR3dDV1ROUlVCK3ViMU1UbHFSdCt5?=
 =?utf-8?B?empBeGpzOVBjaXg1U3p4UlE0NEcwOWhDalQrQ3p4OWdQREdGeGhlMm1Iak80?=
 =?utf-8?B?bTBuVk5Ea3pkTjF0S0ZQWmZ5UTR2d2JGbml4dndWOWFkM3N2SHhHd2V2THJR?=
 =?utf-8?B?MlBwenNmd2JKNko3ODBZei9meStjVWpzM1ZuejdrSEx1elJyWmdwbXE4UW9y?=
 =?utf-8?B?SUZyWmdaOTI3VVpFb3lWQTB0eUNJd1JKZFBnVjhrYnpEbjNLNE9rS3A0VStZ?=
 =?utf-8?B?KzY5anllcUNEZnBNZEJVSGo4bEQwbW5FVTNHeHZPOEtoREh4K1M1QWZZY1BW?=
 =?utf-8?Q?5xhIxV8G4sWBQYne22qyCgn7r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9b328d-61e7-457b-1d3e-08de11fe7085
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:36:04.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dErR7JuWdi7Hb2ntXFzD+LjvWQVaYA8MsqA2mBng7Zlj+6bD97vUpUnDqmHOI/uKxWcr8WHaIE1A0vQrTX39+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBFaWduZXIgPGpv
aGFubmVzLmVpZ25lckBhLWViZXJsZS5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCAyMiBPY3RvYmVy
IDIwMjUgMTc6NTMNCj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pY2hhbCBL
dWJlY2VrIDxta3ViZWNla0BzdXNlLmN6PjsgRGFuaWVsbGUgUmF0c29uDQo+IDxkYW5pZWxsZXJA
bnZpZGlhLmNvbT47IFN0ZXBoYW4gV3VybSA8c3RlcGhhbi53dXJtQGEtZWJlcmxlLmRlPjsNCj4g
Sm9oYW5uZXMgRWlnbmVyIDxqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGU+DQo+IFN1YmplY3Q6
IFtQQVRDSCBldGh0b29sIHYyIDEvMl0gc2ZwaWQ6IEZpeCBKU09OIG91dHB1dCBvZiBTRlAgZGlh
Z25vc3RpY3MNCj4gDQo+IENsb3NlIGFuZCBkZWxldGUgSlNPTiBvYmplY3Qgb25seSBhZnRlciBv
dXRwdXQgb2YgU0ZQIGRpYWdub3N0aWNzIHNvDQo+IHRoYXQgaXQgaXMgYWxzbyBKU09OIGZvcm1h
dHRlZC4gSWYgdGhlIEpTT04gb2JqZWN0IGlzIGRlbGV0ZWQgdG9vIGVhcmx5LA0KPiBzb21lIG9m
IHRoZSBvdXRwdXQgd2lsbCBub3QgYmUgSlNPTiBmb3JtYXR0ZWQsIHJlc3VsdGluZyBpbiBtaXhl
ZCBvdXRwdXQNCj4gZm9ybWF0cy4NCj4gDQo+IEZpeGVzOiA3MDNiZmVlMTM2NDkgKGV0aHRvb2w6
IEVuYWJsZSBKU09OIG91dHB1dCBzdXBwb3J0IGZvciBTRkY4MDc5IGFuZA0KPiBTRkY4NDcyIG1v
ZHVsZXMpDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEVpZ25lciA8am9oYW5uZXMuZWlnbmVy
QGEtZWJlcmxlLmRlPg0KPiAtLS0NCj4gIHNmcGlkLmMgfCA5ICsrKysrLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9zZnBpZC5jIGIvc2ZwaWQuYw0KPiBpbmRleCA2MmFjYjRmLi45ZDA5MjU2IDEwMDY0NA0K
PiAtLS0gYS9zZnBpZC5jDQo+ICsrKyBiL3NmcGlkLmMNCj4gQEAgLTUyMCwyMiArNTIwLDIzIEBA
IGludCBzZmY4MDc5X3Nob3dfYWxsX25sKHN0cnVjdCBjbWRfY29udGV4dCAqY3R4KQ0KPiAgCW5l
d19qc29uX29iaihjdHgtPmpzb24pOw0KPiAgCW9wZW5fanNvbl9vYmplY3QoTlVMTCk7DQo+ICAJ
c2ZmODA3OV9zaG93X2FsbF9jb21tb24oYnVmKTsNCj4gLQljbG9zZV9qc29uX29iamVjdCgpOw0K
PiAtCWRlbGV0ZV9qc29uX29iaigpOw0KPiANCj4gIAkvKiBGaW5pc2ggaWYgQTJoIHBhZ2UgaXMg
bm90IHByZXNlbnQgKi8NCj4gIAlpZiAoIShidWZbOTJdICYgKDEgPDwgNikpKQ0KPiAtCQlnb3Rv
IG91dDsNCj4gKwkJZ290byBvdXRfanNvbjsNCj4gDQo+ICAJLyogUmVhZCBBMmggcGFnZSAqLw0K
PiAgCXJldCA9IHNmZjgwNzlfZ2V0X2VlcHJvbV9wYWdlKGN0eCwgU0ZGODA3OV9JMkNfQUREUkVT
U19ISUdILA0KPiAgCQkJCSAgICAgIGJ1ZiArIEVUSF9NT0RVTEVfU0ZGXzgwNzlfTEVOKTsNCj4g
IAlpZiAocmV0KSB7DQo+ICAJCWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHJlYWQgUGFnZSBB
MmguXG4iKTsNCj4gLQkJZ290byBvdXQ7DQo+ICsJCWdvdG8gb3V0X2pzb247DQo+ICAJfQ0KPiAN
Cj4gIAlzZmY4NDcyX3Nob3dfYWxsKGJ1Zik7DQo+ICtvdXRfanNvbjoNCj4gKwljbG9zZV9qc29u
X29iamVjdCgpOw0KPiArCWRlbGV0ZV9qc29uX29iaigpOw0KPiAgb3V0Og0KPiAgCWZyZWUoYnVm
KTsNCj4gDQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNv
biA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo=

