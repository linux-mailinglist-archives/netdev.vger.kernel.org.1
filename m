Return-Path: <netdev+bounces-101443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B432C8FED74
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678B92810B5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D851BB685;
	Thu,  6 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFNj8LpV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BD1BB681;
	Thu,  6 Jun 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683490; cv=fail; b=JNky/2rG6zNzt4pur+axJ0xuZFaY5343P5Bou3i0/s43ocpopZjEkaiRHAaQ2x2EYgLUFOuZu+sQ0cZRI9MpLD1ZBhTrnAB/F3F5h1DeWX3ANFIIfZZpVLB7eWp1I8AbLRQIIhbhBsmZn4fSsZWMxDZTk1AVlcx2/MxS7a1c2Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683490; c=relaxed/simple;
	bh=LXYxZtDpaTFKjvVcG/ZZw5S/6Iv2cO9pqZ2uIy+j1/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDBMqFwLDH8d+f0/v7BSQ81R+NcCsdHEe0YT10noXJ12I4z5KfYEG9pJFP27ErQfxVc5gvq5h8a14no659fNru+hc2Z7WbY37tR+y+lt0ETCsImI5Jb/CkP6ILl7wb4ndQrw344Ld5xFRAHHrw6oSnGHmsjBMW9Kwz2EjhgJu9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFNj8LpV; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAmBnaTTFHq0GtxoZBcqRqCxXgQjrAW5fiQOZP2recxCQe5OyiF1R394+9nYc4dNH20GT/TFDJtxaOLaJgr2Lq/n0lF7JDxklCIQoNxiBj2Giy7uQk/XL2iQ4DfksJKUoYQ90eh8xtGvB4tiu6VvXeKg0NcWsdMOZqDwV1rx5f2KPuik1vu2ivTNkckNG1GkXF4YAzibAecjJKiSwfcw2IN3gdR2W6zkgfHfFpHyc2aDGFeRj6dWFiGQatvM62nkf+iake5VuSNfj5cEQBqiq/9nJV3XTaR+s0LMae4BzjrQcJtgNe2WvlpWgjjQOZ9X7rB6RjrKInD5qvE+NZA2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tzIQh5T9Vy0piFBeIHdeNe2TQuj4jrvlg7wG2YM2zM=;
 b=lRBZypyaT2WEYifMFNZH9IjQSH9X4hj6enDN9kFRUyt/KDAGqxdyZmPJM1MzSkf86svPnok2rF5UStrcuY9X6fUsUp+bIf3U/mGg79rSGhA4aJBiuohkqmwwBc2LTiczouv8Oqc2fbsZCIiyhA5LteKDAT6vON4tCZhPLz/xAegHedruFNMqQSOv+sqz1tKCYCExJM6c2klMYi7feraZW0gQ038R9+kDGYDo8VH44YrT5Lng0Kz3DdpguWI2V6oasIVy8XDNBInArgMB4z8WeIb69lkEyPQT9jy9k8rO2AhExpnb27vzQjMI+4gb4kiXqTifqHORdLd1605B1+/JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tzIQh5T9Vy0piFBeIHdeNe2TQuj4jrvlg7wG2YM2zM=;
 b=IFNj8LpVmA7TrIouEFehdR8vDXjx83KiZlDCni1r0juG+WgaM6yXWXUQE8VNOExwCglcBo1ks1MR0AYETEr2pEjW0FDeHGpIFnJTifZ1OnBZ2xVj1EzFjGNPVE0ZwmHTkA2JWyO5o567XzCgj9TK/NgbImplsielJO/SCgWC54M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Thu, 6 Jun 2024 14:18:04 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:18:04 +0000
Date: Thu, 6 Jun 2024 17:17:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <20240606141759.pzug3gezeuabrxzm@skbuf>
References: <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <20240603135100.t57lr4u3j6h6zszd@skbuf>
 <d5786231-b79d-46a0-bb4e-020efb805559@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5786231-b79d-46a0-bb4e-020efb805559@ti.com>
X-ClientProxiedBy: VI1P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::16) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: fb89a444-5fe3-46d7-3d46-08dc86337a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejZOWVFuRXNBYVArdlUxTTlUSUxVYkJxeXdoSEhEUVN1RWV5YjJ3NWsrQllG?=
 =?utf-8?B?WCtIMkJFOVphQTk3NXZiLzdyejMrZjBzeWQ0ZGJDMDJjcjlvekpIcitBRFBM?=
 =?utf-8?B?c1JsN1VWSjh5azNpR3E1bHVFakZKS0xremNHUUdTNEl1NVpqaUdLWUlGSWpa?=
 =?utf-8?B?cjVpcms5ZkxjSm1QUXR0dkhjN3RYWjBMaFpZQ253QWRlRENSNWdIb1MrNHVh?=
 =?utf-8?B?RE5FdFpJTVRYUFB6WVEyZ2xVTVhTYlJJNFgwSnFHUmFmZytSdHljTUxVQ1ZB?=
 =?utf-8?B?RnMxUmtDSk1rYWZYcVd2T0RhM3FWZG1FbkNacVdYdU1qcklmVEJnd2xnSnYy?=
 =?utf-8?B?ODIxRXUydS9OdTdYNUJudUFCaC8zNmRXeWpBeHNwcmt5NVFZSmZMNWtyZHV0?=
 =?utf-8?B?eWtXNFl0MTdQRUljRWFWaXdTMlNLSWVIclREUUZkNTdVb0w0aUh5QndmT2Nu?=
 =?utf-8?B?YkEwOTBzS08ySFgzN2hMWlpvaG9QS1pwdTF3S215UHpxcDhPTmV2T0QzZ1Ix?=
 =?utf-8?B?N25wWlkwelF0YURwRUF1YU1ZcytSUGhEd0NBdWpndE9JdkpXOG9iTDFhYm5Y?=
 =?utf-8?B?TlU3SU5mU0UrMnArTG9tVTJEb3FPVnl6MkxkcDdheE9rWDhmZ3pIN1ZDc0dU?=
 =?utf-8?B?NWZFQmpEYXhGT0N2aURZMmdIRk1zamo2OWlhbnNHenBET2QwSjFZZk9hNTZ6?=
 =?utf-8?B?dGh1K2ZEYWJCc1Z3Q0VEZEY2ZmJHcUQ2eEVVZXJVbk9CTGJtV2NjTzBmQitX?=
 =?utf-8?B?a1FOV1FnUTFDaThUckhzSDhVanBSblZSRlo4U3J0QmRjVTMyaE9rbUNDVTdI?=
 =?utf-8?B?VGM1bncvSTBlRFpqVHR1c3FhdjlaOWdjaW5yYUh2WWlzaFZCV2JkNkFSZmhE?=
 =?utf-8?B?ZEovSGpNckJCQ3ZmeWo2YUpNYllxenMrbDlFTG0xc3J4MnNOd0pFTUNtVXAr?=
 =?utf-8?B?bE5kKzhjd09Rd3MyMHZCVTQ4OUxCUWdHS2ZBSjlDcE1uUVRNMDJKM1dGRzFI?=
 =?utf-8?B?eGZ1azU5enFQMEJVL0VpTEhTRmtuYmlldTdVTGl2a3QxL0xFTDdMNThJU2lM?=
 =?utf-8?B?NUFOUDA5MnBSOU5Tek1KeFpWZmJkaXNMc3BwZGtldkY1QlMrbDBCbTZ2a3ox?=
 =?utf-8?B?ZE8rYzJ3ekxRQjVQT3hUdTB5ZmYxWjNDWjRDZUVzQ1M1V0FEemtJK0NVWk1o?=
 =?utf-8?B?d2N1UjVRTWI0eXExUHNzUFR6YjhvdkU0aUNvOHo1dC93OTB1Y2gxN2JaRVZs?=
 =?utf-8?B?djc2ZWltQmlXLzdmSWczY3dQM0d6MDUyakpqbVgwOFdqazZpODdwNzhKU1VB?=
 =?utf-8?B?VjF1cjJzaHFEUTM1SWNvUVc3ZHczYlVyT0tDTXdIR3ovUHJTTElUcWtVMTlY?=
 =?utf-8?B?SGtNMlNpZmN6NmhzYW8za0hkbWFueFlJRDN4elhNY0h0ZjdZN3ZiQ3YwRkI5?=
 =?utf-8?B?YjJibkU3NXVCWmo2MkN4OUZHcW1lWXRDc3JRNWFTWmwwSktBV1V1dFU4M2dU?=
 =?utf-8?B?b0FyQ2lkem0vZEFwMHVlQnhVUXFmdDdMdjYrb3BXNGw1d0RWZGo4dkVyb1NP?=
 =?utf-8?B?a2RDVzRSMnYwVnVPaEJ6WVB5bGROMzdpdS9ZQTdOUmNoTW5qdDVDd2ZMMjlW?=
 =?utf-8?B?WkQ1bjdYWjByRk1TMk5zcGs5OUVlL1ROQmNnVXB0NTdZakpjUDJwTTF3YWR6?=
 =?utf-8?B?R2VVNU5iNTc2N0NiQ0JVeEt4T1A5aHNrdTBXM1BjN2ZxV1Y2OHloM21DZjdv?=
 =?utf-8?Q?vXRJF6Ghzok22zYy6+1MXxsFWlbgaVThxreEPSh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZ3L0ZXUTNlTWFveDYwdXpmdERIWE56Tk1hdVZGV043ZW5RMEpwL3I5SkFw?=
 =?utf-8?B?RVdkSjlmWTRldHF5K0xqSW9MK2tRMEw3ek5saEtYYmh2RXBUVS9YOXVvR3lT?=
 =?utf-8?B?WWJtM1NjUDhtZUNKaFFNbjNscG1nbTZiNE5CMStuRlRXRkJXbVdSS0Rkdkpp?=
 =?utf-8?B?S1M0c0dlUjJGQ28zYndackNkSEZlRVU0eExMdDdtM1pneFdWR29jTTA2M05K?=
 =?utf-8?B?Y0NzbmF0SHB0NGZhUUMrWEZVTWpWVnFEY0htcGVRQmphREZQTy9aVGFndUN0?=
 =?utf-8?B?WWFTak0velBITFo4VkhBZHVPUGwvWHIwYnVZZlo2aUVZMGxyc1h3ZjhPRnBS?=
 =?utf-8?B?K3hVNGs1c1NTam14MkdsOWRzZ3kvWnh4cEJFc3RlVlNqWVpQN3U3ckhiMVBk?=
 =?utf-8?B?clpYWWdhVVBpWlZuaU1ZVjFBbUVTODBQYzJ2UlJLR3AvQjVVN1FkTXV6bm0y?=
 =?utf-8?B?QXRUVjZEUDlLT28vT2VNdWs0UXJDNjF5aWtPTU1jakpPdjNiQldsMnZZcU9l?=
 =?utf-8?B?eStLTkRCM0N3SVNVdHhIblY1SVBRejdGa2NyNWI0ZWpZUnpES2FramhaWmxD?=
 =?utf-8?B?d1lqYWJOdHphVXJUMkZZbVFwUTFBcUd6NkxYemQvbDRMY2JFSWRKa2s1ak9i?=
 =?utf-8?B?OTJFenNGbGYxZjkwbCt4c3lwRVVxeXBqQkhKNndHekJVS3RmYmVLZHVqajYw?=
 =?utf-8?B?M1BlakZGN21ZWTJ0V21CMUhZdG96ZXpvekpyVmVTZ1NYNnkxWmlLMzUvS1Jk?=
 =?utf-8?B?cUpseEs2TllVbUlFYUg4N0JSRWQxbFI3Mk8raTNSTHJUbmhrb01zVVJ6alg5?=
 =?utf-8?B?ZW1GbExGZzE2eVVFdEp3emhwWWo3cXFnbS96Nm9jRmRyVElMaEhOTVl3Zy9C?=
 =?utf-8?B?SlU5RkJHVGJZRzdIVlQ1cjZoM1ZYU2YySVlpWmZJNmpHU21HSHlBbzF2QkRY?=
 =?utf-8?B?WUMwVVNJREZGV2xmelN2RHoyQVZjbzNlS2pUOGNkYytzRlFmcFpnM2tRWnVv?=
 =?utf-8?B?SHlFWU1ub0FGdTVMdGZzeGkzZHAyVHIvTUtTaG5HTEtOdkFKNUVKdzN5RzQv?=
 =?utf-8?B?bTJsaW54aFZ6U0ZGZTF1Y0U5dkNFUXZ6ekk4dlNlS1ptT0lodXJLcTJHQXUx?=
 =?utf-8?B?bEUvb0xEdDRUWDhuTXJCN0tZd1FZcXdLTGpKZDJsUSsvbWdBRFdjVkoxUlZU?=
 =?utf-8?B?VXVrK1I0ajBoYnZTSFlLN0hlSXBaOHUzQWZNUEw0ZzFmMzVXdnQrUHIyaGFo?=
 =?utf-8?B?NkJ2U3lLUzZvZWJxOEJUWkZiNm1vcGh1cjRMYjZYdUs2b2FJbGttREJOOXFz?=
 =?utf-8?B?bnpCMVN5YUhNajdJdytKbExRZGw0S3ZaSzRuZmkzVzNlYXlGd2lsaTV5NkV3?=
 =?utf-8?B?Y0ltQW1wS3ZnVWFqbU0zbFhWTWxtcFhrRmxQQmVZaWRTWUphTXdaNVEwN291?=
 =?utf-8?B?Vk1iRCtDejZhNHVJRnQ5NGt5REJpTnlLb21PaW5makVSMmR1b0FQL0V2QXRh?=
 =?utf-8?B?V3A2akd0Z3FQbDVVMWlSVldvaUY0c3pyNHRyV3JIemZtOVYyc01WUTRxZTRh?=
 =?utf-8?B?dXc1U3ZNYVJkVHpmNDBIQ2pteU5mY3R2L25BazIwbHQzMmhKbHVOSDduc1V2?=
 =?utf-8?B?dWxuUEtnQkprMjREVFlpdTBSSWcwZ3BNUXJNdUJyaFJNM0UyQ3hUL05wUVEz?=
 =?utf-8?B?T3MxMzV0TzRYK01EOWpjR2xQTEdHTm5SRWU4eHRneG5TdnNYcmFad2hsNzNz?=
 =?utf-8?B?Z2Y1eXgzSTBTdUxBNFpkWUFuTzdwSk4zWHNWSXJuRnlDUGtXczJ2NFFObjkw?=
 =?utf-8?B?LytMc1hiUExVVkYycTdoc29ESUZiUHBDNUJicUZWaWpZNHNydGNRd0g2SGNY?=
 =?utf-8?B?ZmtSQU81NkJVKysySGFEWjhxWHFaYlR4S3orUSs5WE8zSEhmR0xOc0pBc3po?=
 =?utf-8?B?SnlOTTg5WVp4Ry85VXZlNCtBRm4wc2FVVzF1WjZpbkZROHZyallrOFJhUjZO?=
 =?utf-8?B?U0pRTEdSNzI0NllXT20vUE5HTi9JbG9nZUhidXNhSEpnR3p2VzEyL3AyRG8z?=
 =?utf-8?B?ZjY1QzVaRzFVMWN3RS94L0dDcjVVOFoxNC9LeHB4eW5ua1NyTzA2OU1FQ3Mr?=
 =?utf-8?B?M0d2U0hpOXhmb3RYWHNGc292TUk3aVNLdk1pdDJyTjRqb2UwbjJOc0hmck51?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb89a444-5fe3-46d7-3d46-08dc86337a8a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:18:03.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbbpwt+JdcpRLpIMW9pfFH8N41UbiB3fNcchAHD4wwJX2UkJEE2XevHKr2Qp19WL+M0yWetuFfgZ1gYaNFEcYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

On Thu, Jun 06, 2024 at 04:33:58PM +0530, MD Danish Anwar wrote:
> >>>> +static void tas_reset(struct prueth_emac *emac)
> >>>> +{
> >>>> +	struct tas_config *tas = &emac->qos.tas.config;
> >>>> +	int i;
> >>>> +
> >>>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
> >>>> +		tas->max_sdu_table.max_sdu[i] = 2048;
> >>>
> >>> Macro + short comment for the magic number, please.
> >>>
> >>
> >> Sure I will add it. Each elements in this array is a 2 byte value
> >> showing the maximum length of frame to be allowed through each gate.
> > 
> > Is the queueMaxSDU[] array active even with the TAS being in the reset
> > state? Does this configuration have any impact upon the device MTU?
> > I don't know why 2048 was chosen.
> 
> I talked to the firmware team. The value of 248 is actually wrong. It
> should be the device mtu only i.e. PRUETH_MAX_MTU.

There was another comment about the value of 0, sent separately.

> > If you're replacing an existing active schedule with a shadow one, the
> > ICSSG_EMAC_PORT_TAS_ENABLE command isn't needed because the TAS is
> > already enabled on the port, right? In fact it will be suppressed by
> > tas_set_state() without even generating an emac_set_port_state() call,
> > right?
> > 
> 
> As this point TAS is not enabled. TAS is enabled on the port only when
> ICSSG_EMAC_PORT_TAS_ENABLE is sent. Which happens at the end of
> emac_taprio_replace().

"If you're replacing an existing active schedule" => emac_taprio_replace()
was already called once, and we're calling it again, with no emac_taprio_destroy()
in between.

This is done using the "tc qdisc replace" command. You can keep the
mqprio parameters the same, just change the schedule parameters.
The transition from the old to the new schedule is supposed to be
seamless and at a well-defined time, according to the IEEE definitions.

> >> The following three offsets are configured in this function,
> >> 1. TAS_ADMIN_CYCLE_TIME → admin cycle time
> >> 2. TAS_CONFIG_CHANGE_CYCLE_COUNT → number of cycles after which the
> >> admin list is taken as operating list.
> >> This parameter is calculated based on the base_time, cur_time and
> >> cycle_time. If the base_time is in past (already passed) the
> >> TAS_CONFIG_CHANGE_CYCLE_COUNT is set to 1. If the base_time is in
> >> future, TAS_CONFIG_CHANGE_CYCLE_COUNT is calculated using
> >> DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time)
> >> 3. TAS_ADMIN_LIST_LENGTH → Number of window entries in the admin list.
> >>
> >> After configuring the above three parameters, the driver gives the
> >> trigger signal to the firmware using the R30 command interface with
> >> ICSSG_EMAC_PORT_TAS_TRIGGER command.
> >>
> >> The schedule starts based on TAS_CONFIG_CHANGE_CYCLE_COUNT. Those cycles
> >> are relative to time remaining in the base_time from now i.e. base_time
> >> - cur_time.
> > 
> > So you're saying that the firmware executes the schedule switch at
> > 
> > 	now                  +      TAS_ADMIN_CYCLE_TIME * TAS_CONFIG_CHANGE_CYCLE_COUNT ns
> > 	~~~
> > 	time of reception of
> > 	ICSSG_EMAC_PORT_TAS_TRIGGER
> > 	R30 command
> > 
> > ?
> > 
> 
> I talked to the firmware team on this topic. Seems like this is actually
> a bug in the firmware design. This *now* is very relative and it will
> always introduce jitter as you have mentioned.
> 
> The firmware needs to change to handle the below two cases that you have
> mentioned.
> 
> The schedule should start at base-time (given by user). Instead of
> sending the cycle count from now to base-time to firmware. Driver should
> send the absolute cycle count corresponding to the base-time. Firmware
> can then check the curr cycle count and when it matches the count set by
> driver firmware will start scheduling.
> 
> change_cycle_count = base-time / cycle-time;
> 
> This way the irregularity with *now* will be removed. Now even if we run
> the same command on two different ICSSG devices(whose clocks are synced
> with PTP), the scheduling will happen at same time.
> 
> As the change_cycle_count will be same for both of them. Since the
> clocks are synced the current cycle count (read from
> TIMESYNC_FW_WC_CYCLECOUNT_OFFSET) will also be same for both the devices

You could pass the actual requested base-time to the firmware, and let
the firmware calculate a cycle count or whatever the hardware needs.
Otherwise, you advance the base-time in the driver into what was the
future at the time, but by the time the r30 command reaches the
firmware, the passed number of cycles has already elapsed.

> > I'm not really interested in how the driver calculates the cycle count,
> > just in what are the primitives that the firmware ABI wants.
> > 
> > Does the readb_poll_timeout() call from tas_update_oper_list() actually
> > wait until this whole time elapses? It is user space input, so it can
> > keep a task waiting in the kernel, with rtnl_lock() acquired, for a very
> > long time if the base_time is far away in the future.
> > 
> 
> readb_poll_timeout() call from tas_update_oper_list() waits for exactly
> 10 msecs. Driver send the trigger_list_change command and sets
> config_change register to 1 (details in tas_set_trigger_list_change()).
> Driver waits for 10 ms for firmware to clear this register. If the
> register is not cleared, list wasn't changed by firmware. Driver will
> then return err.

And the firmware clears this register when? Quickly upon reception of
the TAS_TRIGGER command, or after the TAS is actually triggered (after
change_cycle_count cycles)?

> > 2. You cannot apply a phase offset between the schedules on two ICSSG
> > devices in the same network.
> > 
> > Since there is a PHY-dependent propagation delay on each link, network
> > engineers typically delay the schedules on switch ports along the path
> > of a stream.
> > 
> > Say for example there is a propagation delay of 800 ns on a switch with
> > base-time 0. On the next switch, you could add the schedule like this:
> > 
> > tc qdisc replace dev swp0 parent root taprio \
> > 	num_tc 8 \
> > 	map 0 1 2 3 4 5 6 7 \
> > 	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> > 	base-time 800 \
> > 	sched-entry S 0x81 100000 \
> > 	sched-entry S 0x01 900000 \
> > 	flags 0x2 \
> > 	max-sdu 0 0 0 0 0 0 0 79
> > 
> > Same schedule, phase-shifted by 800 ns, so that if the packet goes
> > through an open gate in the first switch, it will also go through an
> > open gate through the second.
> > 
> > According to your own calculations and explanations, the firmware ABI
> > makes no difference between base-time 0 and base-time 800.
> > 
> 
> In the new implementation base-time 0 and base-time 800 will make a
> difference. as the change_cycle_count will be different from both the cases.
> In case of base-time 0, change_cycle_count will be 1. Implying schedule
> will start on the very next cycle.
> 
> In case of base-time 800, change_cycle_count will be 800 / cycle-time.

In this example, cycle-time is (much) larger than 800 ns, so 800 / cycle-time is 0.
Simply put, base-time 0 and base-time 800 will still be treated equally,
if the firmware only starts the schedule upon integer multiples of the
cycle time. A use case is offsetting schedules by a small value, smaller
than the cycle time.

The base-time value of 800 should be advanced by the smallest integer
multiple of the cycle-time that satisfies the inequality
new-base-time = (base-time + N * cycle-time) >= now.

You can see that for the same value of N and cycle-time, new-base-time
will different when base-time = 0 vs when base-time = 800. Taprio
expects that difference to be reflected into the schedule.

> > In this case they are probably both smaller than the current time, so
> > TAS_CONFIG_CHANGE_CYCLE_COUNT will be set to the same "1" in both cases.
> > 
> 
> If cycle-time is larger then both 0 and 800 then the change_cycle_count
> would be 1 in both the cases.
> 
> > But even assuming a future base-time, it still will make no difference.
> > The firmware seems to operate only on integer multiples of a cycle-time
> > (here 1000000).
> 
> Yes, the firmware works only on multiple of cycle time. If the base-time
> is not a multiple of cycle time, the scheduling will start on the next
> cycle count.
> 
> i.e. change_cycle_count = ceil (base-time / cycle-time)
> > Summarized, the blocking problems I see are:
> > 
> > - For issue #2, the driver should not lie to the user space that it
> >   applied a schedule with a base-time that isn't a precise multiple of
> >   the cycle-time, because it doesn't do that.
> > 
> 
> Yes, I acknowledge it's a limitation. Driver can print "requested
> base-time is not multiple of cycle-time, secheduling will start on the
> next available cycle from base-time". I agree the driver shouldn't lie
> about this. Whenever driver encounters a base time which is not multiple
> of cycle-time. It can still do the scheduling but throw a print so that
> user is aware of this.

Is that a firmware or a hardware limitation? You're making it sound as
if we shouldn't be expecting for it to be lifted.

> > - For issue #1, the bigger problem is that there is always a
> >   software-induced jitter which makes whatever the user space has
> >   requested irrelevant.
> > 
> 
> As a I mentioned earlier, the new implementation will take care of this.
> 
> I will work with the firmware team to get this fixed. Once that's done I
> will send a new revision.
> 
> Thanks for all the feedbacks. Please let me know if some more
> clarification is needed.

Ok, so we're waiting for a new firmware release, and a check in the
driver that the firmware version >= some minimum requirement, else
-EOPNOTSUPP?

