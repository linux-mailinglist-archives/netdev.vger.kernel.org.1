Return-Path: <netdev+bounces-203756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2333AF7077
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53731885AF5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF91288CAA;
	Thu,  3 Jul 2025 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="W/wxJ3vH"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022075.outbound.protection.outlook.com [40.107.75.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA31B95B;
	Thu,  3 Jul 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538920; cv=fail; b=O1Zrj+RmczkHxYzkGxqyeMVI57/mA2xPSWKVOBbVdOGeQy9n0REEuKfjyf/RkRgTnysEY+6ybGxZv32VE2qmPvcBTiI65Vb7669YZjpUZ33TBEhlqqc1w8YWroLImjd6aJ/ehwk/ZyGSxBmfqS44s9fLgU0e5PgTHg5VcNw4cwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538920; c=relaxed/simple;
	bh=dt9lLE6WTbdn7QfSyGIfacCkAZiOeNBhuQhcgY8t9lY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWKU2yOgRtf75Fz+/MqU6SjSH1NNWAgdr32+uEPXr1lWun/y7XK5dr9WWaqPp7gb0mcaBkKDkamjMwWNVf5HGyh6eSWZ9GtYrgJI98qskejWSeAd/hRLq++5nL/1bosRYsqC1gTVxov9cNilf3o2ihlRSOYvCLSz6yF5XbKSpp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=W/wxJ3vH; arc=fail smtp.client-ip=40.107.75.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6UDrNpvUDfNu07EZIeApXQgE8B4flyZEbVlxryOCyHCQKGJxm5fLDofqjxE/WvXkQZOxN1BgBQF09FZ+zZoJlcXDBfdwREM4OfIR3b1MSmo4JynkQsE8yRIhhLG9Bnuh1uDP4IiF6dq4nv/Yx1Q+4d+tBbJlvunD1/T4kFRapt9ae7b/y3wpQ/0k74I/UBYs48FbfrUjev3xMgkL4WLvAgy2De+YN7QppUMC4QAuBXfVQ02JxpRxz+uGuLJHMwfhuGT2OA5OdLDh6kApN/FOMGcI7yknB918q1JpP2MhoEWPlHnz8F6RunXWCXuU2s/cU6NfHZCxnQlmW+gtns0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnoEw5PsYN4XEFbcJ8nsfl/2XCgjP/YhwdqzVBkGpM4=;
 b=Dhxa1ER6oZPNol2AYx0Q1lkLT41ryR5ldHoWVOmiwK6nl/+lVhMsf7nnbDvQ+F8cQxGfh5VlHpc0iw7+g8AI8ECGG8eLs6eV5l0wmtgcD149yykhBcojBZmsUd1uDdArwKLJKR9PrVV9FCaX0UUlEElwL1kKz3WknLKNcp/i2OUH7cei9Hy8v+air/z6qs1SCKeJcyEkAs9aXelTx0q8Ru+M+ms/M/WHQhhJhc2HlmuzcVpgm8Jw1PRIzuPW0HDtz1nOx65/jCnnDI7SXLHz280uJ/Ejsh2JaB//Jbqpumwne244Ouey/0C/D+6IjjmyDwS+Q2n4LDiYaH/DyHD4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnoEw5PsYN4XEFbcJ8nsfl/2XCgjP/YhwdqzVBkGpM4=;
 b=W/wxJ3vHEwrcm5qcOaq8soM99yKDOkV6hEJ/JpcwDoO+b4wvf24Ke1ekAvM9h6WRMckvBvbweg/+JUoW6AbCOhYZjprE1l1z9CsrV9T8WH5RjwHt3XBr1Ahe/m/zgCotH9dmCm6Z6BmJmqqTZrG3wtCAs/3eACosaMwsLdZ9ZCN6n3eAce3k9iX92L2DVreKr+yH2aTT97a+jym0ZWUYbJvDmykXMDqsRF2QqIN78gDL0R7SRfyIBFcQqr6sfmgD69jhYeoorcD457j6S1CHw9Cb2kIPcua7baVw1N0RInj4mx0Z6amo69orprWqnRaeirdvBPBBF8rjv94Jt6lYxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB7081.apcprd03.prod.outlook.com (2603:1096:400:33b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:35:13 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 10:35:11 +0000
Message-ID: <7ea17a93-284d-4e9b-8130-cc46b16a9524@amlogic.com>
Date: Thu, 3 Jul 2025 18:34:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for
 ISO sockets
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
 <d6906cfb7fae090b9fe0c1c5b8708182eb939b42.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <d6906cfb7fae090b9fe0c1c5b8708182eb939b42.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca675a7-f475-426e-a8e6-08ddba1d4a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhnNkIrS2UzZGUwUndpUXZJd3F6U0ttb3l0Wm1GbW9hQVJWSzllK01BTnNF?=
 =?utf-8?B?MVp1Rnc1dHFicGtJRDNUamh0dTRhVFlGTmpVbmtYVGF2YVJlMjBhSkl1VlRV?=
 =?utf-8?B?eHVBTUR1MGtwS1FpTVRid3JrMTVrRU13SVE0aHVyMEJxVnRtb0xJOFlzcjJQ?=
 =?utf-8?B?U2J3L3p1U2UrUlhCSGdHT0puNFd6Tk8rMVoraHFhR1pLVWVNQVZhS1VpMWF4?=
 =?utf-8?B?eWtuOVAzU0FsRmcwY2krb0x5UG1MUmpKMlVlYU5WZjRzVWptQnBQditVWW95?=
 =?utf-8?B?bXlCbTJVUTN2ZzYxblFLSWl2MXc4WXk2WVBBdXRBdERtS0Z2ZXdBT3pFUkR6?=
 =?utf-8?B?TzNHZE54a3pMSzZVZGdYUzJhS0ppYXRicmxLWXA1alJ1M3lXNmNVLzV2aWpr?=
 =?utf-8?B?Tk90VTVYTlpHT0dtSUZKdFRncmd1WVlwcW02dS9jNjJrb2hiRWthT2s5YmxC?=
 =?utf-8?B?SG5tSytPYzBtZmRtbXI5VW01OWZWTks1RmRLN090L1JOalJhZjAzYmFwOStJ?=
 =?utf-8?B?Y2dYWkVYcVhyTlZ2emVRYWp4VHJDRXh2anlnOXF0cVlNaEJUdEhqUFE0SzAy?=
 =?utf-8?B?U21uYjhUR3lWUVdyd1V4OVhHWVBCZWVuUkJyYjlTdWp4S1hYT0g5QlpvdFFP?=
 =?utf-8?B?RXNTNWI4eG83aFowemRod3poMjVIQkVXQXZhYWRBVkYyVXJhNHFXSGlDYVVo?=
 =?utf-8?B?bEFkTHR2bW0yaGNNRy9Oak1zVjhQQ3dydUNpU3JTeFNVZnJiZ2ZnY1FaT1VW?=
 =?utf-8?B?Q0FtM1hIQURvcm9NQlN5SVl1NE5ubkhjUlFHRlcwV0ZRNi80WnFlemNqSkx3?=
 =?utf-8?B?V0VBdUovWWNDOWV4eDFYZEM1am1kaVIwUjZQV0Vack9wdFVKV3dab1l4WXd1?=
 =?utf-8?B?bmczb2txU2Q3R0dRRUQyU3F6MWtrOUlUdXdRTkUvTitUQjJ3UkgvQ3JqUUxY?=
 =?utf-8?B?YkNoOTZzSE1qQ3JWTExUdk4xc25SdVFwQUJpcGs2bHZjeEM1TTVFTmJkODMx?=
 =?utf-8?B?YkE3bFJtY3FUUjQxK1c1Y1RLSkJ6MHFtZk5rbGM1RHpiWjM4MFROTFQyTTRw?=
 =?utf-8?B?b0s0MXJjWVJHSGxzSHVYSUZEUG4yazVmWllnaklEbXV4emxHbWhNSVVHbHJU?=
 =?utf-8?B?eE5JSlNHSkYwUUdobVJzcktDUG44c3JZYXExL01oSmp1MWE1M1FDMXFrZ3E1?=
 =?utf-8?B?U2g5Sk8zK2hpZVVGcUdkT0dzMTEzVTdrUVgxWEF4WVlVa25sNmhEd3lvMGtl?=
 =?utf-8?B?disxcW5vL29GRUlnY2FPK3hLT05XZ0xtRHNWdlFWancvZlFqbmcyekVQWllL?=
 =?utf-8?B?Q0tQMU0rR3BqWXZmSmxRSVJsejhPUS9GL0l5N1FxeHJsQ1hmMm1BbHJKZUdW?=
 =?utf-8?B?bkhIN3dNdW52dHBDMWVKK0w4b254SUswc0R0endNYzNCa3RNenhibFRack8w?=
 =?utf-8?B?a0lFQm9qVVJ2eThyQ3hURTJzSDZja3pEM1lpdmtIczF1MTRQYmZEZUtudkJ4?=
 =?utf-8?B?Y1paSkJiRlRxdkVRSEVrcGtyL0JZdUtIclZmMWlQZ1A3VmxmS2tDNWQvYmdn?=
 =?utf-8?B?RjUxdVpibTU4SHFaK1hvSFFuaEtibjlDdHBtOGVQVFV6NDdYcHBabjBsUjE5?=
 =?utf-8?B?KzYyb3JWK3YvaHpiQVorNzJLeXpzWk5xeFBZUHZQbzZkaUpmeWw1VEwvQ0Rq?=
 =?utf-8?B?Y1lFbjRqcnplUTVpQURGZ3VrTUl1cTJJMHFCa2NoK0V5VjU4ZUVRdWxEVERX?=
 =?utf-8?B?K2U0UnJFcHRjTmhGRnVFSVYwYjlxMEdmMlhWYmQraGMvNDVEbmFmYlZmbkx5?=
 =?utf-8?B?N0pycnFaSWh3Z1FXekZtL24yMXZPT09CU3IrWEtrQTZnNUdtZzVxdnMzdGR1?=
 =?utf-8?B?WGo3QUlkOTBSM3FPcU1xbTNiVTFnQitnRy9XV3ZENmxtZjlhSUgra3cxLzZG?=
 =?utf-8?Q?UlnPwaiCa0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRNaXQ0K0xwcUtTYzdidTU1Z1ZWUU9MUnR4TGZFWExrekhFOFNqeXdJUFVM?=
 =?utf-8?B?dDFicnJ5bUw3WnNjK3lCa1IrQXpCcE05UlE4c3dFc1lsVmVWV3N0VVVTV2lI?=
 =?utf-8?B?dUIxSmpONDFKaHE1NFFqK0lBc3AwdHoxb1EvVFAxYTVCMGxSK0pGanIweTlW?=
 =?utf-8?B?Wk5LSWFBdnZpZEcyY0NmajdmVE02RDdnRERIREhBOG5rOTZQSzN6NzhEQ0FD?=
 =?utf-8?B?bTB2T0kyeFl2YjRQbTEzaUt4SnNpdlhhZXNKV3VtcWV6SjBRVFBPaFJZdGZ6?=
 =?utf-8?B?TWYvVmJhMWtOZzgvN0RLeGJzTWVGejMyVzl2dmxsYWhsSmlmM3NuTmNTM3JB?=
 =?utf-8?B?bkxjV2xzencvN2VQcjdhNHlmTCtRTExxQXBidnBvTnZ3eUx6bU5aNkJFZkZk?=
 =?utf-8?B?bFVTZnpyS1lrZWJIY3NLYXJ0cWduVTM1MVBKU0RyRmJ4aHFoRG1YWVRrZlRw?=
 =?utf-8?B?b0xuMjUyVTYzNUFZN0JvVlZPbGpvMTFhZUdXb2g4WS8wL2VaSXl6eTRLdTJY?=
 =?utf-8?B?eGkxRkVLMXd4Q1BFSDhhV2JzdFloZG4ydCtwNU5PUEliSHVMSU1ucFRLZFZ5?=
 =?utf-8?B?cmtpNldiT3MwZm1JSUo0N0hiVnc1Zkt0ZG9wWFdDakJiMGVEUVZISTFJd25r?=
 =?utf-8?B?MVBmRGdLSXYxWHE5YnIyellZcTZtcG1GNks1R0ZRRVlmL0h5NlN5YU5tYjB5?=
 =?utf-8?B?TTRsQXNvOUgrdUpHNlBrNFFBUy9sVERwVG5XblBNTmJkWk12bmxqYVlBRlU1?=
 =?utf-8?B?a3JuTW9jSzdIV084UlBtc3g4d1ErMWFHWU81ZFRXdVNHL3JROHl1VkwrTHJK?=
 =?utf-8?B?ZmRIc2Z1VWVXeTdtM0JtTDdISDRScWJ6alRjVmN2Q0JWZmtkUTc0bmVldHM4?=
 =?utf-8?B?cnNMY1dGSDNaUzRNMGpQa0hLV2RuOVFXaWllTlNFRlZIM2RoMEZNTlpkV0N6?=
 =?utf-8?B?UkNEc3oxYmtFaWN5eDY4S25GNGp5MGpFc3JkTE9yRTVUQXJnbUdxVVcyQ1g4?=
 =?utf-8?B?MU5HZW9sVkhPdy96dXNOeEJXWE9vNk5oRk1GcWRvWG96VG8zbldvcXdUOE1U?=
 =?utf-8?B?U2tSZ25INTZLZ0NqUTY2b1BQOWFDcEx2bEErMS9FdWJ5STg3eVlxN2R6YXU5?=
 =?utf-8?B?eC84TDZYQ0s1QjZ4WUtFZ1YzcDVrck5VYk1IK2Zsdi91TjhTVmMvb29tbUx0?=
 =?utf-8?B?TnF4NndZRVlkcExmbTJHOFNHRUdvQWRZeE5hKy9pbWlENmtCYTZ4NmdtVk43?=
 =?utf-8?B?WnZyejU1L0RCR004aXI5RkRBZzgyNWVzRERodTYzSnNRNXlRWkFxdzRYNEZB?=
 =?utf-8?B?b294c2NJcTNhWk5QWEtzL3hwVXhkcExHKzhINi9WWkhTUm92NVZSak16WXdK?=
 =?utf-8?B?enN4a0JGeElYVzVnK0NlaTBGblkzNk9jdS9hazdnQnJlSGZLdG9wUDhnOUQy?=
 =?utf-8?B?YnRIb2kyRU03NUpkMTVlUkQveHk4MTJ3TWFLWllFd1ZzZ2kxWFRIMXo5N1Zm?=
 =?utf-8?B?eFR1cEpZYnlSNXA4TVJhR2h0MUFqa0xqSDZkbjl1QW4xTCtxMjYxNXFVeGxr?=
 =?utf-8?B?NFdQUTJqT0J1WUtNcTNlVW5DR2JEcTVXQjhvWDZaWG9RbmM2Tm5QS053SDlt?=
 =?utf-8?B?MzdBYmx2bXRkQTg3SEdyWXcwVGl2SzYyZy9zcDVCRHdIQzAvTTQ3bkRkakpz?=
 =?utf-8?B?VHJrZXJtc3dXczNGalFueWpjYmo0anBmcnBFcDdaeDl6dzdvWVJUc1BFdWtR?=
 =?utf-8?B?WTQvYUZ3YlFGWXBTaDdYUGNpWCt3cVhJYU5NakwwdnpYdGxyRklRMmVOMS81?=
 =?utf-8?B?NkFRMytGR0ExbGZqT3NWeG0wOGV3TFFHWC9WanlEMDZQamM5Y3BSNlo3NUFx?=
 =?utf-8?B?R0dZK0wyMUtjclVOM25RNmpGdEQ1NVlSYmY2YkVPdm5ZUDR4QUVkS0VHNW1Z?=
 =?utf-8?B?eklla3VGWUpSNENBajhUeWY3b2NQTDYzNDU3ZjdhN0wzc1VxQVc3dFZUNy9x?=
 =?utf-8?B?dmhXZFc1WkNCY1VuU3B4UHAvK0dWYk5COSsyb0V6dkFRSzAvc3FMU2NIMVl5?=
 =?utf-8?B?cnJqMFNZTzJYMDh3SWRUV2lxSlY4MkZDS3YyaUlsSUdUY3hIcjRlS1ZtUlZy?=
 =?utf-8?Q?cqMx2Ij0jvfxwTlb7G636hjax?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca675a7-f475-426e-a8e6-08ddba1d4a28
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 10:35:11.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKqZRK3jl0CjVvPe1qHd3StpMTW/K50q44j5SnfK6MBjciOBPejdqFFKn31XwEHkydEXiRiq/78KwJpKjZzYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7081

Hi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> ke, 2025-07-02 kello 19:35 +0800, Yang Li via B4 Relay kirjoitti:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> User-space applications (e.g., PipeWire) depend on
>> ISO-formatted timestamps for precise audio sync.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v2:
>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>> ---
>>   net/bluetooth/iso.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index fc22782cbeeb..6927c593a1d6 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>                                goto drop;
>>                        }
>>
>> +                     /* Record the timestamp to skb*/
>> +                     skb->skb_mstamp_ns = le32_to_cpu(hdr->ts);
> Hardware timestamps are supposed to go in
>
>          skb_hwtstamps(skb)->hwtstamp
>
> See Documentation/networking/timestamping.rst
> "3.1 Hardware Timestamping Implementation: Device Drivers" and how it
> is done in drivers/net/
>
> This documentation also explains how user applications can obtain the
> hardware timestamps.
>
> AFAIK, skb->tstamp (skb->skb_mstamp_ns is union for it) must be in
> system clock. The hdr->ts is in some unsynchronized controller clock,
> so they should go to HW timestamps.


Following your suggestion, I switched to hwtstamp but kept 
SO_TIMESTAMPNS on the PipeWire side.

+                       struct skb_shared_hwtstamps *hwts = 
skb_hwtstamps(skb);
+                       if (hwts)
+                               hwts->hwtstamp = 
us_to_ktime(le32_to_cpu(hdr->ts));
+

The value I get is unexpectedly large and not the same as the timestamp 
in the ISO data.

read_data: received timestamp: 880608.479272966
read_data: received timestamp: 880608.479438633
read_data: received timestamp: 880608.489259466
read_data: received timestamp: 880608.489434550
read_data: received timestamp: 880608.499289258
read_data: received timestamp: 880608.499464550
read_data: received timestamp: 880608.509278008
read_data: received timestamp: 880608.509451425
read_data: received timestamp: 880608.519261175
read_data: received timestamp: 880608.519438633
read_data: received timestamp: 880608.529385008
read_data: received timestamp: 880608.529462133
read_data: received timestamp: 880608.539273758
read_data: received timestamp: 880608.539452758
read_data: received timestamp: 880608.549271258
read_data: received timestamp: 880608.549450008
read_data: received timestamp: 880608.559263466
read_data: received timestamp: 880608.559443216
read_data: received timestamp: 880608.569257466


Is there any special processing in the application code?

>
>> +
>>                        len = __le16_to_cpu(hdr->slen);
>>                } else {
>>                        struct hci_iso_data_hdr *hdr;
>>
>> ---
>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>> change-id: 20250421-iso_ts-c82a300ae784
>>
>> Best regards,
> --
> Pauli Virtanen

