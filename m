Return-Path: <netdev+bounces-215161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B203B2D45E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17A01BC4B4B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C722579E;
	Wed, 20 Aug 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="UGqxHuVi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400863770B;
	Wed, 20 Aug 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673048; cv=fail; b=KJMV997/8ZJ9Mz0/uCty5DHiD9zjxvglYm5iNuhzabqJmjemNmnr9y0V9jRlGKpI+WcUx2MqAV8dZy86FNe3IKSvgpKf+Y4rRzVqvl3zmfq3xaf3CKs94mdlgI7KdKc/0PqmBxql0G2or9uhXGcR2HL5jNOIfpuWAbhuQUncwUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673048; c=relaxed/simple;
	bh=z+nyEmtiGNhi+tBHcottDZjsywYLzVQsqX+nCYfYFJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FKATOwUA7PFE6pvns0IutsjXG6FzybXI9lLyY9HZL4esbZRMPdAGCE36moxL2abLoVv2TK5xOhTwyO4k2KrmLMFoq4HnlrZ/JVKrY9jZO/yVUPwrOxhAOeYZuYQbIeF47oY4wwpDsGEr64g0AlY4sH8a2CxiNp9lr51dhwc4JXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UGqxHuVi; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuwkyHZv7e17ayM6Zwesyiy1qvGWeNfD0Jnd9IRs6n+7LBmc7EYQwACEBa0zf2/dzLENVlnMUkMZR+oKkXx30da4BQcvRlTL15LN0uo/EQGLHAbK2lzGiyNw4EDkhvvHbDbd3lu0Ek+D+cF9xkTKXGPiS1bvj26h6qkzGvjRLMphE6DJm0AZRGOmsEVH5lBd9cR6ivCNs/ynk5TZZ37HTQ/WDRN34gFhkxtQOyOVyjHBLahbgDUlYrLv4fVGitwRBPpVLsTo/EACpAHSUMot6Qaq6oWk7AMxj9Tlq2/omEUzFEL0y8xhm7wArbQyaaTihDCtXyGaREnbxV8+tt6thA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzrsi2n7wxbfWVFhmCFUnfRZjRMJ2SRTp/WukrKzSB0=;
 b=g2TovVcLRF0JXD0FNVczb06kFlRFTDWofLNVmo4JGwuyp7RAi37F0w3BY1V4jLW0b3bytGrIWXis8YqVdLfPQdRN7mOj65X/ADPgL6Xc/t+3Au4y+AmZ+7Yo/8xrkUQP88bMode0dUdkSk330b6V1oQb3JWWHI/fOBvJk6TwVz98HCJhCfh2dmBpEjLUvkNOHFsaAok4HImt7tU/PAky3EqbxIkvffNyVS97WG9UMCgCf8V/uKmI5dj86GbrtuIxXFGZMfgnS/ipcmgOdLrLlYykm6wmQ9g40F8dhJ1BxSSZv3nZVPNQQNJ2fFZwZN3PNXM4+jbTmeF66aT0rw8r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzrsi2n7wxbfWVFhmCFUnfRZjRMJ2SRTp/WukrKzSB0=;
 b=UGqxHuVicoKrYMAOLkR1QDq5waLf39K+g6066OluHa8tBUjrQsY+5hdCqBHdMHU077sz0UB9ngeGDIwL0vi86KX9MUSaTmgUQlNma8HT97dYyVsB7/XEakSCO3EUclERS/PrzvTJUP+0Vz0QSEtr7F1JXFgvKtQ4DaxxxdT6o+2oBLb3WpCLjEkTwWMN5O/RP9uqulwp01BkVIHbgNMN8tD38wdguuFJBP1sRn27rxMuRAsdXRGtGJn2SkiHmMYn/fOWR+pxaH4cvWN0svQOJ6GdfcKkmYGpFX0o6iMcLfr0DYR2TJLfM+sLlgI8jLxprwNC9rwvzWmLggB0WYSAmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by CH5PR03MB7840.namprd03.prod.outlook.com (2603:10b6:610:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 06:57:24 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 06:57:24 +0000
Message-ID: <4f6b4593-0658-44be-95ad-07172e9afc9c@altera.com>
Date: Wed, 20 Aug 2025 12:27:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: xgmac: Correct supported
 speed modes
To: Jakub Kicinski <kuba@kernel.org>,
 Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
 <20250816-xgmac-minor-fixes-v2-2-699552cf8a7f@altera.com>
 <20250819181920.275f2827@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250819181920.275f2827@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::34) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|CH5PR03MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 439c1bbc-dcdd-409c-f6d2-08dddfb6d0bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk9mL3JBNDVhVUcwNkRRaG0zU0VFQ2V4VHhHWW0rRkRBQmhKbzFlVkJXTlcz?=
 =?utf-8?B?L2VaNjgrUDJZaWJBdk9yUkZZZkRLZ2N3S3YzYTNNWkFiNzdnZkpQMXhwSHpw?=
 =?utf-8?B?NCtpMEswYW1lNjdUTGdNNWQxSk5NYXlENXhORkRMOUVOekJ3ajRqVUIyNk9Y?=
 =?utf-8?B?WmtXM2hsKy9YTTdUK1BDOFJuWnhGNDdYZkJjdmlPNXhkYURUYUJ1NHlncEFN?=
 =?utf-8?B?L3V2eVErZXB0N20rcUpUOFZJZnI1UHhiRHhOb2cvcDVZVHkvQVpsWTljdGlD?=
 =?utf-8?B?SjBuSG12b05LbnQ2ZTdXNzNJczhqRm8wUlNzbHhiOTB4ZHNtTnVwYkx5bDlX?=
 =?utf-8?B?UndFbGwxQ0U2QzlDVWR1Uk5xL0ZCbnN0K2JkSno0dU1NY25DSC9pOUl6Q3M2?=
 =?utf-8?B?SlppVzdHeU5TVnNwNE80T3RYVUpxYzJXdnpDSzNsSi8zbG9IUzZYaURWVGEw?=
 =?utf-8?B?Tm9TZkk3SFFhWk5EcmYvSXlrcmowUFd2cUlZL016cjBXM1hGS094ZVJJRnZv?=
 =?utf-8?B?amZsMGRVakdscDllV0ZQSld2aUFLVDhhZm5yU3FpNTEvaWpjbDB0eERpWlBy?=
 =?utf-8?B?UE9hL28xSlVkSm90QkhRaWtIRWhMeGorUWdzdnFDNU0rMks3bEJIbjV2N0Vv?=
 =?utf-8?B?ZjFYcDFjakdSNFUza3k3aVBKRHdHSU1maDNHaXN2UUFMNHBoQmNZa0Fic0c5?=
 =?utf-8?B?NE9CMEhoa0o5UXJ4Yk53ak1CUGoyWDM5SjFJdEhrbTExVDFhUDU4ZzlIcjNz?=
 =?utf-8?B?QldzdUxGa2NQaTd5UDlUZWtVMVlDb1B4a3pEZWJKS1JxQ0RraGs0RDJIbXdU?=
 =?utf-8?B?cWtBZjByLy9OdUw2cmxPNnpDQTdoSG1mcS9PTFZ3T0FCRTlRSldRdXlqMFZk?=
 =?utf-8?B?d0tGR1Z3SS9CcVBhVHYwTUkzYUxraGlBY1hydnpKTWVwejRoUk5rWUlpR0l1?=
 =?utf-8?B?RTYvMDVnQVZ5M0VUMjV1eW9NYmVBbFVJUml3aHdsYzE2VGtPWFU5MWhxc1JY?=
 =?utf-8?B?b2V0UWtlRGFrTTdQVnFVWG16RmlWT2poUnhONVhZOUJTV2hEc0JzL3pxTERC?=
 =?utf-8?B?dlhHODZRSGpNbjFGRm4xcStlVUdMS0lNK0Fmbmd6Zis5bUFVVFVmZklOaHZw?=
 =?utf-8?B?QmQ0MzNqUEtHdmcwUmMvNEpFbFUrN1Fyd2tJSm9SMkY4MGVBKzBlZ3lUZTBG?=
 =?utf-8?B?SVFVTkpQY2JPdWRFUVpYZTRiYTg2RVg0OWZreWltUCtsaTBVbC9wVWNyMHd4?=
 =?utf-8?B?WjNUM2Vqa2l2ZFRGZmRGT3p3VU9HR3c0WXZ2eGJINmowTVpjY21OKzFCWDA4?=
 =?utf-8?B?VWpJRUJSM2E1WE5OTDZoS29NU0VpWDZycGxRdWVWbkdUVmNadEZnbVUyVmJn?=
 =?utf-8?B?ZktRRkhFSVp5Q29zQ2NhcG85Sk9NdGd3RTJuRXVyRzZPTXhnQzhEdW4ySk1y?=
 =?utf-8?B?SXpTaVFEODE5Y3VpeThRTlFhR3F2QkZMc0tPRG5yMTFuYkM0UWZtREgwbUFS?=
 =?utf-8?B?N3hhTnVjZ2JnK1VkT2NYTFhMYm9PWUkyNkNmOUFxRkI3ajl2Q29TUGtRdTFC?=
 =?utf-8?B?YS9mMWo5WUVJZ1ZML2dHNnRya0htVHI3cFN6Y3dzbjdNRURQcThnRGpJSHVk?=
 =?utf-8?B?OWE5SFNONGtONFJWcVFsMFdXeHl3MXpyNGFoR1Z5MDBibVRpZkZPcFdNcGpz?=
 =?utf-8?B?cTh1VHRoRC9nTFdVNFNHVWJlMDQzTUxNZXN0ZmhIV05PS0RZUnF6R0ZUZytV?=
 =?utf-8?B?d0hweW9FRjlFYWFyUkVkUTFJVUxodjBIK0xjdmxhL0hpd1dxMDNBNk1Lazdm?=
 =?utf-8?B?ZkR0Y2M0QnQ4ZytSYVY1SHNxN0dSMGtHMkgvbU5HVTg2SCt1T2lHTy9aWVRp?=
 =?utf-8?B?UVg2Wk5UR1gvdWduTFMvbFFIMkwxWDQzR3ZTMmo2Ull0UGwwL29tbXlZMWVJ?=
 =?utf-8?Q?3BowxvpmNQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFArTkw3QTl0K3Y2eitvSzZWd0FuRk5JZURzcFh0bkVUeEtlWXQ2OFV4cXRx?=
 =?utf-8?B?a1h2VllLcTR0WGhnbjdKbzRZanpyeGhzMGVyZTc0UGVxY1d1UllyVzFtb0pi?=
 =?utf-8?B?cDNXS01BTS9FK29tblJiZTNaVFFIMnNBL2EyMnlMc09qYTgzZmhMSktzSW1I?=
 =?utf-8?B?c0gxRnlnTW81bXhWWHl1SFh6YzRzdGxRNlJScU5ZNlVCNG0ySXVROERwaU9L?=
 =?utf-8?B?cW5PK2w0ZzN4ZzMxZUlOeVh4blRBc2QyN1dMRklDeDNIdlFMVlRvK2pDRzZG?=
 =?utf-8?B?eHVVVkNNU0sxNDBtUkp2T2tJVm1rY1R0aFFhaFdibFV3SldYRHFxMENLV20r?=
 =?utf-8?B?dzVQSFZ4QnlUMG5PZVpzNHh2N0tFekZFQ1JPVXJkOEJnOHA3WmdxSTZlSjEr?=
 =?utf-8?B?RU1KY2ZDSzRYK012NVZ5VldrN2RYZElUazFSZ2V1WTVzeENlbnQzMFpUV2dN?=
 =?utf-8?B?VTFUVjJxTlJaSFZTdmQ3bGFnUjlwanUyWFRjZTRPNVF3RXVGNW5McG5yS294?=
 =?utf-8?B?VUxjYTBaUUFmMXlNRmZMa1pmR05lZlByZERMaXRqTDVITUk4ZHYwenFmd1dq?=
 =?utf-8?B?MlJQQ3U4Zkhua04ra1Z6Qm40dzFyNjdWSmdxZWpHZVBLVEpYaHV5TDBjVjAw?=
 =?utf-8?B?TDJSK2VqQlNHUkFoTTRTQlNiQnlDWjNxUmdPd0R0R3VESGpJZnQvUnpZU2VW?=
 =?utf-8?B?d2kzWkVaVHEzYndCOUhMM05odEp0ckEzbFNnV0FOSFNvbzN5SE1yQ2F5Tm5S?=
 =?utf-8?B?WkFCbmx1M0ZpYjhIYXZDak54LzFpaWUwNGtWeFBra0w0d1hUYlk5QUhOQXdo?=
 =?utf-8?B?aWtpZ0xJT2IybndrYnZQeUdySDI5VUw1a29udHdpRXJ5UTdoVHM1QUZab2Ro?=
 =?utf-8?B?eGV5R1JGTWFwN1NjK0hUZlc2aWVEQzR5dTVsZXppWlZ6eFZMU2N1QndTeTFZ?=
 =?utf-8?B?V3MrR1p6TDQ3c3JBQng4K0w2akZ4UlIranR5dzVtcjBqUDlVSzJjbWloTjdP?=
 =?utf-8?B?Y25BRVlRMVJCYmlmSk53RVowSVRLYWVNend3Y1hoZFhpYy9JWFY2OHVLSncv?=
 =?utf-8?B?dnd0NW05QkwwOGJST0RWSm5kMGNPMGcvdjFOVzRmTUw0NW5TV3V2dkM0elBC?=
 =?utf-8?B?U2FtUHpmVVE1VXlud0xlNGJlMnNNYVRCcXQzd0hnbXVaRkZZRGF2V1hUWjYx?=
 =?utf-8?B?VTRpREtQamVILzBWSnY0cjN5QnZ5RG45Ky9wL0hxaFRFS2hocUp6QjQyZG1o?=
 =?utf-8?B?MEVkS25PWlRFejVEYVVHaFMrK3dadGY4N3pUdCt3TUd1a3pLZlJaU3lpdkMy?=
 =?utf-8?B?SXFsKzdFQm1uV2RnRGh3bTRmcDdydG85OEo2TStsUnRVY3JhMkIwN0o4K3NZ?=
 =?utf-8?B?OG9RM3h4bUs3bmx6TTVscjQwTlhNcWxvcURyYWljanc1MkN6RkNFM2NZQ014?=
 =?utf-8?B?ZDlQUHBPMVlod3Y3NnVVQ1IwSU9iU1ZsYUlweFNGMjhobDdZTXB2UDdzK0pH?=
 =?utf-8?B?VmFxblZVb3RGM05yaFBXUnd2U2pRWDRFcFNqbzFCTldUbi9YTEhUdTlKcGJ4?=
 =?utf-8?B?M3JlU3B5ekw1ei8rK2Zsa29nM25SUzNOSDhqSGJXTWR4MHlRUjdoK0F1UE9Q?=
 =?utf-8?B?RXNtczhBZlo2QlN3Qm5FT250TVgwdzZ2QjBmK3haV29QdGc0UjEzck00QVRw?=
 =?utf-8?B?QmxLUXhUaUYxYlpvcWh2RFQyT3VLU096aTZqaU5rNFBjTkJVUm55V1B5NlY5?=
 =?utf-8?B?b2VNU2lEaTM1emc1eEh4R3NxMjkxaFZTUmozSXNWZVVnMm1sVUNCQUV1VlpQ?=
 =?utf-8?B?UFpaYzVLNjJneDZwcmd1ZlRxYWVCeHRFRTNPVlU0a0t1ZmdMRWJ2YlZGSXRx?=
 =?utf-8?B?TWZzSnlhbTIyN1IwSDlhUWxHWTRoVldhTHFOcTk2TXMrVEwrUlM2UVdHNmln?=
 =?utf-8?B?Vk1QamFBUXRRWlZNRVpZZ1lEeUhnQjBURTZuTFpDYnVHN3hueXBpVHpaUGR0?=
 =?utf-8?B?TmVrelJUTnNFdm1FamtSYTFxazlkV1JaUVFHMlJhUWFucS92MFp1b3lTS24x?=
 =?utf-8?B?RXBZelZVWmluMGhWVlAyMk9TUVdNU055QjRBcHZFY3AxODVOazFiU240cU90?=
 =?utf-8?B?WnFBY2Z0cnhIem9tSi9pNE5WNzFxeU9Td3JWOWl0WnBvTE5rYktHMGdoSXJx?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439c1bbc-dcdd-409c-f6d2-08dddfb6d0bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 06:57:24.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqeHWdbCY+K/zaiIOPFeeHlIkZuwt6ACiwiAaqwRumGQ3Tn4HdCwqlViJ3DYjYRmsVnNRbLXYlINeLJ30d838WPvqr+sWHWTXp5Do7xdyYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7840

Hi Jakub,

Thanks for reviewing the patch.

On 8/20/2025 6:49 AM, Jakub Kicinski wrote:
> On Sat, 16 Aug 2025 00:55:24 +0800 Rohan G Thomas via B4 Relay wrote:
>>   {
>>   	u32 hw_cap;
>>   
>> +	struct stmmac_priv *priv = container_of(dma_cap, struct stmmac_priv,
>> +						dma_cap);
>> +
>>   	/* MAC HW feature 0 */
> 
> nit: no empty lines between variable declarations and longest to
> shortest, so:

Sure, will fix this in the next version.

> 
>   {
> +	struct stmmac_priv *priv = container_of(dma_cap, struct stmmac_priv,
> +						dma_cap);
>   	u32 hw_cap;

Best Regards,
Rohan

