Return-Path: <netdev+bounces-97950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B668CE458
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10961F2234E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B585269;
	Fri, 24 May 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QD6acvpK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A985923
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547273; cv=fail; b=cQFpE6rarkwNy2NP2NelzpKvqlta9vbfo6AFz41eAx5vaXBfQHhQgIqdt02XrKTurj+vhBvuTPeHqyP4hWWEkIXi82k3BF6QcY75Kj++Ai7bk41dU50D+J7TLkS2SDvGP2l8iNUy5ZO4Q6P6Ql/J9MB7GItzIXeSEBpFVGiMxbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547273; c=relaxed/simple;
	bh=7CE+vVCj1XcOnX7TikkE7mEOxWeDuu5U4uFbtLOtMvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQ4Nn5yJBWWT/+C/21mjRx7DjwyCaaqwSDa9ReosFIFYCPStar5LV7KvmZhomxc19k13C4EbPqTs8RrbMsv7x2js30lxJQGElxwB1ryLQLr8uVmzjFjqwiu0Jwpc7nOMEaIF4zCMzS5+9Zt3tRdP7M88cMFQvTEL2naX7PZC2pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QD6acvpK; arc=fail smtp.client-ip=40.107.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyas/eQfOgpvulONGT6ZrZ7Rcw2v+I8iYj6cII4WVHOfuCwhRpz0Ks/O+iuxC1ZyLREQMAPJcFBme1vPMHxDHHD8xMwjmwWlKao0BOkpAamDlUQCgvo5ZrBw+2BtNzUkGfbM7wJxqLy24sm/az6BuYJRfdpStWeY5vXAh9doGHXwtu8ZPGguWrdtraERildsKIaYp9cTOA1r2ZFwcglDBd9buW8rl6fYvqEhqy0b4qhbpfQczGQHQu5eNCtVn6ioUz/wrAjYxcGHwH/lf/0aSlG/Vvuzm8sewQ9Nkih4JpAMVEgyCfTCk4IRkfA5FRk7KFWDVwnCk1J5Yxg2Dow4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfeWAKMFz2nDPAvadzH3FTs6sfkY3e6otHcpd+rPCp8=;
 b=KH0/Djy+beDjWNbxAj1VGhJaPH7m6oqCJwDQZZfbl7PijD/6vnc1Eivp9lWfVWzWX1LZgbHopP5e7KmKbQfi0uOjLH5kjyDlOW/RwZAj87oY6hr2etVZqdjqk33H4FEXKpVrTEsn6TSs3Y3alY/1OLmOSYJJAKP1dKmfKabzKtFqfiW+0V36oYYkj48mLDr7P5Dmj3M9RfrLCg7bi8OuRLE7T9O0ejACQ2uWpl9dsP+8AOvi5cTKQfd2xS0xpnGxkTJrZIBqW3mfBX1Ll4nb8MefScvVDhtzB6HicDkdwEv2LSxXB3miCRHpma7jtbx73jMtbyl9mSg6vsk49NPvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfeWAKMFz2nDPAvadzH3FTs6sfkY3e6otHcpd+rPCp8=;
 b=QD6acvpKRUrkvc/cuhYOlw0Ofwrf27C/Dh9ryP8AFPfvuZ890LlAV5yJA/F4RYsLdmpgR2Xh9Z7N/SOwQyuvZCM8ysty67/Mjb3RAdJAmrEFcSnEUnYAk43P5fiYC2Ut/j3l2XALfVE9jE2LG2iACBMkeNsFZuwo6uNgC/uOIG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by GV2PR02MB8602.eurprd02.prod.outlook.com (2603:10a6:150:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 10:41:06 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 10:41:06 +0000
Message-ID: <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>
Date: Fri, 24 May 2024 12:40:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
 <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
 <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::15) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|GV2PR02MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a638a3b-6ace-433f-b89c-08dc7bde0425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmFPL3RlNkRYL3RtNmdvK2NWbGdZam9aRUJjNmY3MzRiNlNwN0l4TTNLNDZK?=
 =?utf-8?B?OHNoNnFzWGhseWRGaWd2V3Ewcmp0cmpwZ1d2UVduZWx3aXk5VmppNWo4eUsv?=
 =?utf-8?B?NmdINThqS1FkdUp4aWEyb0hYTks2ZU9rMzhXMktjRFBoalUzK3lXWjV3aENh?=
 =?utf-8?B?NDlzcEg0QnZ5WjV6WnhNSWdJbktvM2VPTTYyaHhYcjFCUS9VVUhWRUxSSGhz?=
 =?utf-8?B?TkhSd0JVa1BIa3EwNnN0L2xKLzdCY3FXVDVUVmpqbFMyT3N1N1h4OTlQRHJZ?=
 =?utf-8?B?ZTVxcU83OWhaSUl5OWVtckp6REhKejNWWGI5ZnduNkU4R2wyaGdtTll5TVUx?=
 =?utf-8?B?NUsyeXYxbHdpT3JudTY5ZERXb0lWSUxUQ005SHVXb0RrbTlnL21GZ1JYdW9x?=
 =?utf-8?B?NU96NTBkM2lCTUxmRGJrVFlJS0tJV2pBc0tyMjVHeG11V3l0cVdLYmlTS1k1?=
 =?utf-8?B?VGtvdVRNOTN3ZG5FTVJ6bllkQ0h1OGVWZG5QWnF4WXdyVUphTzY2UFJ0M0Nm?=
 =?utf-8?B?QllrSm4rM3Zpc2VrWDAvQUwwTFZVZzh1ZzBCOG56SlcybE9lMEQ0MVFKeE01?=
 =?utf-8?B?WkNwbnhFSmhBdzdqcTd1ZE84YloyUFA2TkZTeTc0QVVwc25UVWtjSXJwamgv?=
 =?utf-8?B?S2g0Q3VPVlJUZlJhMHVZd3ZqSzNaV0JHL0t5cHVSbFowLzJhYS9YelVzTytO?=
 =?utf-8?B?eWhyTzJBZnRMYU1odDNqYWdFQlBIQlZWYWFTbEY1VWlXMFJYSTRUMC9ockFY?=
 =?utf-8?B?TlMrRnNEb2N0RXc1VElQK09YVGh0RHBvUWJ5cGVmRWtIY2p0Q3VUZWMxUE0v?=
 =?utf-8?B?WkxHSFZMdUgyTDVMUDhUM05oSmUyRy9tYXVod3RnWWRwUGJTN2xoa3VUVE1l?=
 =?utf-8?B?S1dlYng0c1MxVXVmaXJpTGxUVCtkTVU2ZnBEQ3QvSUFBRDM3ZkdIZFFrVVcy?=
 =?utf-8?B?ZUt5YXBwKzRIVWdXNnpRVVVrRlRZUzlnM0NRdnZSbGtVQm92ZE1FdldVOVhR?=
 =?utf-8?B?OW90RFBwcEVYSkl6MnppMHFtczh1K1RjbEFEQU1QM2pLbWQ2V0RzSnFtWE9I?=
 =?utf-8?B?alFSYlJOMlplRzQrZVhFcFpxQXlsREgvSC9UaFZvb0YzYjEyUUMxZXh5ZDVT?=
 =?utf-8?B?Tk0zTjNoR1ZOaVNCblc5bGV3VHdocjE5L2ExYVh6c3o1VTFUbXhaWW5KNkQw?=
 =?utf-8?B?NWVyZS9HbGxtb1JiVjJjTTkvOFpFaEhFZzJTQjdwSnAzWmVFVGdmRG10RHdw?=
 =?utf-8?B?UDdtQmgzTkhwdDZERUtPbytUamZxVVJ4TUdUQzBybVhKc040ek91Y3ZFVFZR?=
 =?utf-8?B?TUlGK0hpaVpRam9xT3R2cVJtYk9ya1c3ZWJESFlZeEdmTW94VkZOL0txbWV3?=
 =?utf-8?B?cllXODNQVVB0Smk2dE1oWEJwUktZb2ZoR01jZnB2em1TOFRBbFNCb1VpcjhM?=
 =?utf-8?B?N1dINWR6b0ZpbFRIa254LytYVGtCSHFoZkV0UVd1RGFuSVRiZmtmeW5WRWJM?=
 =?utf-8?B?SG1MZTFwN1NLTHV5MlphWHg5ZkwxVU02YXVmdTBUVmd2Sm5jQkJIb2NBcFdK?=
 =?utf-8?B?b0QxVUw2MlpLUjNLbzliRHJGY0ROTjFiTGxmN1JkVElHWlpic3ZHUDNRdXlk?=
 =?utf-8?B?VGdBYSszQmxtMjdqSUF3T2NTbVBKVVdyaVQxWVVmV3E1OVRYN1A0YjNTWnZn?=
 =?utf-8?B?b1c4RkZHeWxYNlVnSEsyUENoSXRPZUtnd25RUzF0TDJCR0NTZXJqNWd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnRsOWtKL2FuWEpMNEkwVnJTZHdIV0R4cUdMMUxOUWZGSzZNbGdEV0lmRm5R?=
 =?utf-8?B?dHRVQXpFOUVkenFnV21FNDdBU21jWWRwQzl0MWFlSWNFUDBPMjcyaE9FTUxj?=
 =?utf-8?B?ZXZtcHlkR2NlZUR2SlpGVUF1NUE0WmxRUkczSzc1cHBGLzIvUktYK2YxWUhJ?=
 =?utf-8?B?MkxJZEYzeFF5cUZGdm1QbGtWRnNPSmZkMVV6c3VqSUdySWpPUXJzNmgvTzg3?=
 =?utf-8?B?SzdGbHVxa3V1UjhwbUFvY05RK1RIeHc1LzNlWnM5cWJmUjFqWEh0eE96UUJB?=
 =?utf-8?B?dkhPdjVVMk8vWklORkNiZmhLTk5JYzJpYkdvNEdxbkxHQ21rWmx1MkVHSkE5?=
 =?utf-8?B?T205dEErcXpjeHcwb0piUWdSMnJGQXlsNHpMSUt0c3NscldlODZZekhscnFl?=
 =?utf-8?B?RGsrK3RUc1F3Uy8vWWlOSk1sNHZYS0lpUnFvb3EvRGZMUHJhVnFNTmVQbi84?=
 =?utf-8?B?T3E3SHc2NURreEVMdFUzeHhhYlNWSG5kQUZuOUV1WENoTXk3RGFDWEFya3ho?=
 =?utf-8?B?Y1B2V3hyOW5vaTJCcGgrT1lnR2JrUHZEVmN0dmhJemlFYUxmSUQ5eVJWSGFD?=
 =?utf-8?B?c0NCWkljQlloWnFjcXRCNmlyZVI3YmZ4UHZJWWFHbjl5K3ArVDA3M0NXQUxE?=
 =?utf-8?B?U0VIYmwrWHVVaDlDN0dhcDdLVGg5QTRYMld6QWNjZlQrdlZ4LzdHY05DK1V2?=
 =?utf-8?B?QUsrTk5HRGdTRHRUMmUxa1IzWUdtOUJvdmF5VTlZYTZjS05wbmpnMk9zTkl2?=
 =?utf-8?B?b3RIeE44YWNtM2xmZWJhUkUraVpjZlNUU2lkTzgwME1PZGdvNHV4TUVQWlYz?=
 =?utf-8?B?Ny92OGZjWkFzNGVPOEpucTQvTk9id3dweUIwWWNaeC9ETEcxSGxkaXhnYzhE?=
 =?utf-8?B?TEZWb0w3R1dDdUR6enBUOXdWOFZUMmgrRWVINTI3REk0ZUw1ZnJEbTFCcldV?=
 =?utf-8?B?aWlpOHdodFp4QVFWYm9wSE9NdGNSKzRlM2NSZWNOSGhoZUlYQUt4WFBHZ1lB?=
 =?utf-8?B?ajhQYi9MK2pCSHZQZGZPTVBISU9NNEF3Mk1YandrUXlTUVgxVjNOWmFoWDFq?=
 =?utf-8?B?WkY3dEdQZ0tvbDhxdi9lckhMVkZCUmorWmk0TWQxa2ZqRWpnSWNVWjhWbGpO?=
 =?utf-8?B?UWlkUlJpcTl1cTZQdnJuL01sajAxTmwydG5GY05xWDJ1OERqb0xaNjY3Wnoz?=
 =?utf-8?B?NGhHVlFLeXk1bnZaSmhjQW1oOE5sdFZhcjZscFpWNEc0VGJHMGlnSUF5dk5t?=
 =?utf-8?B?K0lSUWtzWTFUTS9JdGpjL2hoS1d6am54K0xJS1lWMHp6K0RTTzd6N1RqMVhS?=
 =?utf-8?B?RkVkTXJ6MytSR2FZb3ZMZWdKQ0RmU2x2cGd1TG1TSktYQloxRk1odGxPTlFp?=
 =?utf-8?B?U2hSeUV4ZklodkpqWmhBc3p1bVRubzRwa3hsaU9tdURJTXF5bGt6QzhBRFpJ?=
 =?utf-8?B?RSthRXU0SUg0cjQ4VnpiRXV0QW03eTg3bFJrQUEvdGdFbUR2L045TVA5eVQw?=
 =?utf-8?B?U3pCTkl1bG9mQ0FLUkJ5cW9XY1VVak9QcDFGRU5yUEQ1azNNQWNlRHloWjk2?=
 =?utf-8?B?d2F0WkxDQ0k5YnpwVnY2aWRVRG9YajFyUjJSakgzQ09QcTN6L25NdktiR3Vj?=
 =?utf-8?B?dENZNkptWDB2b3NpVEc2V1pOTml5QjNMSDNpeStZaGZxWkZ3SG5aWjAwVEc5?=
 =?utf-8?B?S0QrQ0k3SkpEVmRyRWxTaTJjTHpjcjV3UmZJcmNNcndRbmQ0OU1ZSDh5QWVL?=
 =?utf-8?B?N3JtaUlyT1ZpUVdNeEh5Y2dBVjkyTzhnL2YrYWl5T3BXQllTRENwbWJOSVI0?=
 =?utf-8?B?QVBQZmlja0xyQVpadWQwai9RcTdidDRrR2ZUU2RpY08yRGZvQ0VtMmZOdFZJ?=
 =?utf-8?B?K21TQ2t2bnZTL0dHQ1UzaDk0MzhRYVB2UUZtQWVwUFVIdnd1b3V3aWZyZU5y?=
 =?utf-8?B?OWdxclk0eUx4S1F6cnZLOXk2U3VKTzhLcWhxdlpoWWtrb3NUdGFNS0RqeFlQ?=
 =?utf-8?B?TVYvQlhGTWJxUmk0TlFhRDZodHFKQXhnaG4xNXVuRjQzQ0hDSHVqcWFMdjdX?=
 =?utf-8?B?N1dycklYNE1aWkVkMi9DOUNwcHlpQklpSXEyVDY4alhvL2VLRzNBdnkyVkhK?=
 =?utf-8?Q?qevW0iOkDqUi24XxlKm3QbBwF?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a638a3b-6ace-433f-b89c-08dc7bde0425
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 10:41:06.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dIj/H2qg2L1HfpoPTizHN9gAa5XXTlwCmnxGvgmGloNsAazva8KQCE8bxc81Hms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8602


On 5/23/24 16:27, Andrew Lunn wrote:
>>> ethtool -s eth42 autoneg off linkmode 1BR10
>> This sounds perfect to me. The second (shorter) way is better because, at
>> least with BCM54811, given the link mode, the duplex and speed are also
>> determined. All BroadR-Reach link modes are full duplex, anyway.
> Great.
>
>>> You can probably add a new member to ethtool_link_ksettings to pass it
>>> to phylib. From there, it probably needs putting into a phy_device
>>> member, next to speed and duplex. The PHY driver can then use it to
>>> configure the hardware.
>> I did not dare to cut this deep so far, but as I see there is a demand,
>> let's go for it!
> It also seems quite a generic feature. e.g. to select between
> 1000BaseT_FULL and 1000BaseT1_FULL. So it should get reused for other
> use cases.
>
>>> 2) Invalid combinations of link modes when auto-neg is
>>> enabled. Probably the first question to answer is, is this specific to
>>> this PHY, or generic across all PHYs which support BR and IEEE
>>> modes. If it is generic, we can add tests in
>>> phy_ethtool_ksettings_set() to return EINVAL. If this is specific to
>>> this PHY, it gets messy. When phylib call phy_start_aneg() to
>>> configure the hardware, it does not expect it to return an error. We
>>> might need to add an additional op to phy_driver to allow the PHY
>>> driver to validate settings when phy_ethtool_ksettings_set() is
>>> called. This would help solve a similar problem with a new mediatek
>>> PHY which is broken with forced modes.
>> Regarding the specificity, it definitely touches the BCM54811 and even more
>> BCM54810, because the ...810 supports autoneg  in BroadR-Reach mode too.
> That was what i did not know. Does 802.3 allow auto-neg for these
> BroadR-Reach modes at the same time as 'normal' modes. And it seems
> like the ..810 supports is, and i assume it conforms to 802.3? So we
> cannot globally return an error in ethtool_ksetting_set() with a mix
> or modes, it needs to be the driver which decides.

As far I understand it, the chip is not capable of attempting IEEE and 
BroadR-Reach modes at the same time, not even the BCM54810, which is 
capable of autoneg in BRR. One has to choose IEEE or BRR first then 
start the auto-negotiation (or attempt the link with forced 
master-slave/speed setting for BRR). There are two separate "link is up" 
bits, one if the IEEE registers, second in the BRR one. Theoretically, 
it should be possible to have kind of auto-detection of hardware - for 
example start with IEEE, if there is no link after a timeout, try BRR as 
well. But as for the circuitry necessary to do that, there would have to 
be something like hardware plug-in, as I was told by our HW team. In 
other words, it is not probable to have a device capable of both 
(IEEE+BRR) modes at once. Thus, having the driver to choose from a set 
containing IEEE and BRR modes makes little sense.
Our use case is fixed master/slave and fixed speed (10/100), and BRR on 
1 pair only with BCM54811.  I can imagine autoneg master/slave and 
10/100 in the same physical media (one pair) but that would require 
BCM54810.

Back to the ethtool_ksetting_set(), both BCM54810 and 54811 sure support 
the IEEE modes and this would function even with a generic driver. With 
BRR and no autoneg, it seems that if there is one of 10, 100, 1000 
speeds and half or full duplex, it would be sufficient to have 
config_aneg method of the phy driver implemented correctly to do the 
thing (start IEEE (generic) or BRR auto-negotiation, which would include 
set up the PHY for selected link mode and wait for the link to appear). 
Not sure about how many other drivers regularly used fit this scheme, it 
seems that vast majority prefers auto-negotiation... However, it could 
be even made so that direct linkmode selection would work everywhere, 
leaving to the phy driver the choice of whether start autoneg with only 
one option or force that option directly when there is no aneg at all 
(BCM54811 in BRR mode).

>
>     Andrew
Kamil

