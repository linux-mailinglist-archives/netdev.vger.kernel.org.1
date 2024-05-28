Return-Path: <netdev+bounces-98650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E346C8D1F32
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFC2286318
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAC16FF29;
	Tue, 28 May 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OE6HDbwT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B237107A0
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907641; cv=fail; b=Na7Cp60oHZTMee7bojeZN9URPFPLioolGDX2g0cEePg4YOdd8BdCkY+kiEHnCv0qMUKecxd4Lru/1XDxJrY6e2EMiaaX5W10Zs75IOTKBe69CXaWxJbT8EtqFTfUfODFw0XXGvFurd/awmYf4iX4zGnboALpEDSBTdBHToCmsbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907641; c=relaxed/simple;
	bh=QH5SWn0K9JUI2SpmQOu+4CuGt6FqO2bdhb3/2Vi8ikM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQaL7EYQJSkqCBH1yIX3Ks6W7eVwPorp0poi4FpXqAbkixXKl4TGz8DYs0/sYmObuVnvn4nznibq5X2vXzbFQtQU8ClP3Xo0v9tAgo7IFvggRkdzo21waSI2sABPokJAt1sm0ZT+YeMJjstXkNi8Omumr79IEeSFNAExv5G7WSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OE6HDbwT; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4Vp68P/XJU9C+XoMxkPiVw9OyVeoqkYdfmPAM1s/ERlEVrFyq+p4CPXeHGF+eQgawyiTDLy7yTigmbYM3/GpGGNo5w4eF0m5NOlnr9AplUTlffdtNt1s36fX5or78vdbZIsoKznsJD/QK5gtiJne9V173nBdMC/pcLBnz1ab8CYqdcBuERiqHikJBURyGp0wgkzRXgcqahz/DDtUfV1UDxdMmR8ROkz9pEM29f1fT+eIEbOyCQxOy3eTjiRm2qbsRY9OBJKNNakURZNHn6bFvxCOLQlJ8+ZTdAztSJ6jNOUf043EyE/wQO1ckhalmrX+Rj59xcVIDOMrXtAJ3kP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhCYtlUKFykbbdBoABO344w+Nn6vyQDr2V7dbH14tJY=;
 b=ggKMrgp90HShJL9cjMGXJLXS4wJLFPN6VA2+a9Bs7D0IluAZwvJ60DgWbnxb0MMEvP8fzh3wKyeJfC7oHnETvJXBWAHHfDBqRV1eB5clcs2RP7VE+hjSstzNK87x1Jsn9gJRew2AlP8d0nCgrV3eNaA3fcbfUICRsHq+nmdvlUFEmmFGSMCCBk0w94cYu9EmHa5l1WTAH1NQUt+H/IpSE/BkpuXwnxKWa/btCx1Tprn9n9DqG+XrOHTlj4wJFcsPNUO+0R2X65dcZtTjOFUBKJd7rBfxNf7Bycp9pxxJRvWzcWh1aQ3CFqZqtkK1RBkDUoXClSVTyPrUAUFwpbLmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhCYtlUKFykbbdBoABO344w+Nn6vyQDr2V7dbH14tJY=;
 b=OE6HDbwTKG5QYo27KcW7lcTVAplGtPwzxfusMTfDHdFU1hk5A+tfZO01k2q0quURifNKbaspWWJ6tDigPuNjt8NRobWxpiP73Ur8kqwcsjR75l3TLz7poX76H3mvZq5XJQCcz2ctUjOdYVhOCK+imvopBeYsJ9IzNwO4Tgm07rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by VI1PR02MB5901.eurprd02.prod.outlook.com (2603:10a6:803:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:47:14 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:47:14 +0000
Message-ID: <18725214-4419-4822-8e16-1d47a3decd3a@axis.com>
Date: Tue, 28 May 2024 16:47:01 +0200
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
 <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>
 <44c85449-1a9b-4a5e-8962-1d2c37138f97@lunn.ch>
 <b9ce037f-8720-4a6c-8cfe-01bffee230c1@axis.com>
 <79af2fc0-7439-4c6d-9059-048440c3a406@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <79af2fc0-7439-4c6d-9059-048440c3a406@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|VI1PR02MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: cfac44fc-ddf4-4744-1f3c-08dc7f251052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3hmd1creEUxRGJVNFBZS3BoYnFQZTJGenB0dmlqcWY5a3JkeFdCTklRNS80?=
 =?utf-8?B?d0VKYlFXdUFuaGcxTTZ6Mm94UzJocTFJNE9uREYwTjhXdTNTVnFBQjROeGdt?=
 =?utf-8?B?NjZqOXBmcmEzeGt4dVRhWE9va0tWYUNTYlFCMkxscUFLTWVoUkVuK3Rkcnd3?=
 =?utf-8?B?QUZvMHhHNWkwTkc5YXg5UUY0RStJYkNHWHBQSVZWY3VSZjI2UWkyQXhqOTJY?=
 =?utf-8?B?elMwZm5zSlhTa05ubFlMZVhtQ29UWUVaOVhKNjJobFJoN0UxTWVadUtFZmsv?=
 =?utf-8?B?dElJMTJ4VFlFRGZ3OS9CYXpsM3VLQ0hxTGRMSGFuY0RIRW9FOWRLS3dScHJC?=
 =?utf-8?B?L2ZqeU9ibWszMjV4UVd3VEc3dXZiS3p1Y2NSdG5SN1lpR0pvZ1lmRjF2VFFR?=
 =?utf-8?B?d0dwamZwbHpJRzBWYXYyZ3FKVU42ZDRNMnlxcFJ4UmVPcjEyR0s1MkZnUFJ4?=
 =?utf-8?B?V2R5SEYvbzAyVmhHQUJDc044Z0I4Rkg4ZWJ1TFJqd0dnMlo4bUx3NTNTaWk3?=
 =?utf-8?B?ME9GbDVCdkpSV3NyUk1LSlRoZGVoVlBORzlnYSttTUdaeTVTbFBQT2UwYVFq?=
 =?utf-8?B?SVRTZUR1MkZJekFJbk1BL0kyR3k0czNUNXNJZnA2N0RtRko5RFNjaGxOZVpL?=
 =?utf-8?B?TGhpRUYxVm9kdzhkcXJqR0dEMGs3RW9Na090SGhaczF0NjdtQWVQMTJndE91?=
 =?utf-8?B?MzBEVmNPbGNuNG4rQVFFQUVjbmw4VEwxR21PelRLQUxLOWN2cWFtcGRyRDJu?=
 =?utf-8?B?SmpFbG9NNUlra2dWR2dNeWhHOVE4Yk83LzZ4bFNXcWt6SHJkZzdER3E3TjZU?=
 =?utf-8?B?TitSV2VJTC8vWG5pa3ZTZ2dNcjZBUXRZOUdlczNnd2ljY1JGY2hCOWZWSFc5?=
 =?utf-8?B?VkxjcXJUZmdXQm9pYWVlY05RSXZwdVU3OEc0MFlLRUNwQVdya2pMYTdnaFJW?=
 =?utf-8?B?R3Fzbi94dHRMTXFVOVJROWo5RFMrRXBnNEo2MGVUOS9JWHVaMlhSa21JY1hV?=
 =?utf-8?B?NUZoaVNOMlo0VGV5YnJiYXFNV0lkVXhNV1p6WWp1R2xBdTF0a0ZwZ1dPS0lu?=
 =?utf-8?B?Mmp1eG9IWkUzMG0vbmR1U0xKcXBHbWpwamlXVWRTckJ5NmdkMmpLQ2JXRGtC?=
 =?utf-8?B?ck5qSXgvbVpQSTV0eXFmN2c2eHFJbHl6QTZqdFlpRCtVZ2NlOUp5Y2dOWEIv?=
 =?utf-8?B?SGgwY1JKa296VkUvcHFDbktSOGlnUjVGQWRybWRtbEwwcUlzL05iVmVpUi9S?=
 =?utf-8?B?SFpVdmluQUdBOSs5c3hvZG1SS1ZCV2s3TGFXU1JQRWovaWovN2ltczByZVZq?=
 =?utf-8?B?VXF1cWFYNDBOOHQzdWF6Q0gwS3l3RHBEY3lUWUFYTmJmMUowRkxjZ20wbHN3?=
 =?utf-8?B?eUNTbEE1bmNSdXZKSUVJNmFCeHBEd0U1d1ZqWXV6UHAvVTE3NUR5eVFud3lP?=
 =?utf-8?B?VzgyQ2pkSGZyR2s5OHB2bTEvSjU0Y1U3UkoyeUMzay9rRGNzYXFLWkp5b0JL?=
 =?utf-8?B?emVUdUYrNmFFVG9sSjBrc0pVcytTdDdpbGhZZS9SdVBCYzJKbE1keWlHSmNF?=
 =?utf-8?B?VmgyU1pzR2luQ0JyUXd2cjJCd2NrNFpFeGhZVTVQKzBaYVFtUFFiRE51ME43?=
 =?utf-8?B?eE15Y01JSDZrV3JZWWE2OEd6NndsZ3RlVXJzVHB2eFI1SlcvQmVzRVFUQUhX?=
 =?utf-8?B?cjBzazNmUGRxR0IrRXVrNmpmalRuTjlrVEp0Nkg2dzBndnJNTnhYTXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXIyOWFqTzkybTlOK094ZzQ3QkEyL3M5NjdnLzA1ckd2Zk5wRGczRDVOdlhO?=
 =?utf-8?B?VTdxL2JMUEZOMm1USHRRdWVFbEtZcTI0WVRUcVdnb2VLenBicmJtSTFMSWlM?=
 =?utf-8?B?a21PUy91YzBaTGFZM2h6V2hGVHFnZ1ppR0NvTXpMVy8vYW5LSW0wV1hBaGk3?=
 =?utf-8?B?WlBlQWdZenlZM3Y4YzdxZ3dCaS9NOW53ait2U2U0alI3NDQvc0FIWllTaEMy?=
 =?utf-8?B?b1RzZm8remNaa21nWVl5Z1orQkMwMmF5V1FVWFJweWdoMllWUjVWZW5JWUlH?=
 =?utf-8?B?WjNhclBvcFpRQklpSHB0TmFwMG9Ldkx2SmRMZEU3dHJ1TUhSWEE1MXhXNTZK?=
 =?utf-8?B?bmJYeml3Qk9pY2MyblFUK0YxcktNcWxpUS9qRk9pdzZPSjA2WmFzUllCclV6?=
 =?utf-8?B?N2ZVUFdBYTFibjVpYzJsRFEwYUlDYzM5TDdRaDFhemdwd1NJTDRUallLSktx?=
 =?utf-8?B?QnpMMWVtMGFTaE02UGxoNU9sVUEvYU5oVHJRMitUNmdYcTA5c2RFOVJOZGVn?=
 =?utf-8?B?akxESXBIcGlINFhKdTFZMlJnTjd4QjB2eGhvaVdoV2daeThrZ25FN25WRnlk?=
 =?utf-8?B?dTBrcG5CekdNQ1h6bDhkZzUzNmJJU094SVhwMlkrRkJDZGJyZFBwZ1ZOWlNE?=
 =?utf-8?B?THZ3V1piN1hUcjk1dm5NaVBBZGxwTll2V0JCRDg5T1l6L1hpOURqa1hFempa?=
 =?utf-8?B?a2ZDc0VlMjJxbGhzSXJ1TEx4V1BvTk5ZMjNLcVpwR0p3ME5xdjJSZVVPRzl5?=
 =?utf-8?B?MW9pUmRMb1dIUWtaZG4rTFJVRXMwZ29kcTZLSHVjSFk5VmpqNmtKTmNjS2pV?=
 =?utf-8?B?WGRGYXpXVFN5MzltdXVJQzE4RUZWM3Bjc2lTbnRyUThZZktZNHVFMlhIZG5J?=
 =?utf-8?B?dlRVS2J3QnBkdjJCeG1lZEM0aWlyazZsRUZjUGxiMjNmTnhkTk1CM1hEd0lM?=
 =?utf-8?B?azVpMWNkT2FvdzdSdStEWUdhTkU5ajdncnRTbVBrK1ZQdG12VUlnQk5RY1B4?=
 =?utf-8?B?cG1QZmhaVEx4VTZ3c3hJaVB3YWk3ckRaT2Mwb2ZESSt1QXhVOXQ0bklJMXpx?=
 =?utf-8?B?WlkyVCtYZXg2N3h2cHBUeDVFc3BHSExzajVDTjVTZDE0SkpUN0VtK1hFWVVO?=
 =?utf-8?B?bnVuaXFEek9raUpwUkordnRkeUFUbHViNmtXKzBadEZZVGd3c1p4VVBHSVNn?=
 =?utf-8?B?T0llTHJhUU0yUUtvYjhvWnBad3laS1VCcWRya0pCZGJNT3dNelFWaTBQWE00?=
 =?utf-8?B?WjJUelFEdXhEZkprS1FpV09mKzhSeDdmSWo1ZFdjSWRESHhQSTJ1Z21Ha1JF?=
 =?utf-8?B?aHlFNDdyQ3NkTjNVd3psaXRPeDU5Qytpc0tHbVRjdFlpTnZMMVJ4bXQ2TWln?=
 =?utf-8?B?NE5hNzduOG1na0FKMDdwYmtmUVlodzhmQU1MTFdiT2Z2cGdwbFM1NVJCTWdN?=
 =?utf-8?B?aHlDK1BMMlB0NjVyV0tBcjNxVVlzSGlPcmVkMGRIWmRLSm5hSEhaWHA0dDRO?=
 =?utf-8?B?K29aTERnbVhpWWFLTGorY1E3MzIxOERDSGJhL3liUzc0SGZsOGRRYWN4dHh6?=
 =?utf-8?B?RDlqcm5UdjhCdUdpZm82RVozbkExQ1M0d2t2T0V5NVNqR0MrMFlFcE55dWxk?=
 =?utf-8?B?eFFVT3p3RGJIcVF5MFdZbWNTSTlMdW1aemtLTk5nTHNjSTRvU05YWmNBcGUz?=
 =?utf-8?B?UGtyNTJuaFZBQ0ZEam9PTnpOM1gvc25Gck10SGhtb3g4akRhR0NUT0JPK0F4?=
 =?utf-8?B?dGR1aE9Mcjc0T2djeG91WWtaQmExS0JYajc5bU8vcXZxMVdOY1JaOU1PYzdj?=
 =?utf-8?B?d2pHQmFUYlpqSWU1elI4WlFRVEczN3lWTGJOMzFDN005aVh4NlI3QVdSSlg5?=
 =?utf-8?B?Yk5CdXFBSjZTb2NjRDMzNjF0Q3FEdVA3angzaEZLUVZJWEIzU2tteUFkYzB4?=
 =?utf-8?B?a2d6VEQ2MXZ5MlJoWWIvNG9sSVB1RlUvalZ4QUszWE1DNFgvdzdPVm5IY2pq?=
 =?utf-8?B?Z1FIYjBrRTNHOEdKNHJYTUhiU1pUL2ZmRXVZbzB0dU0yL1pOd29UVllLVWR6?=
 =?utf-8?B?WVZkYm02TDk1dkJXWHNwaFE4cEpNTTJiZy9DR1FxWGRQZ0FvZkdZR1dJMDVJ?=
 =?utf-8?Q?9UAzDnclLmKmsBtS4a2Pq+8rJ?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfac44fc-ddf4-4744-1f3c-08dc7f251052
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:47:14.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUGLTwQjUMxE0L2TkEAU6Bb2Pm5MnhtwUdYPqvoHQj06gHWVpdSCidKiMzcPVLg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5901


On 5/27/24 15:20, Andrew Lunn wrote:
>>> So IEEE and BRR autoneg are mutually exclusive. It would be good to
>>> see if 802.3 actually says or implies that. Generic functions like
>>> ksetting_set/get should be based on 802.3, so when designing the API
>>> we should focus on that, not what the particular devices you are
>>> interested in support.
>> I am not sure about how to determine whether IEEE 802.3 says anything about
>> the IEEE and BRR modes auto-negotiation mutual exclusivity - it is purely
>> question of the implementation, in our case in the Broadcom PHYs.
> CLause 22 and clause 45 might say something. e.g. the documentation
> about BMSR_ANEGCAPABLE might indicate what link modes it covers.
There is nothing new in IEEE 802.3 clause 22, compared to what can be 
found in a datasheet of any PHY complying the standard... As for Clause 
45, I'd say that it does not handle the BRR case, nor the 100Base-T1 aka 
1BR100.
>
>> One of the
>> BRR modes (1BR100) is direct equivalent of 100Base-T1 as specified in IEEE
>> 802.3bw. As it requests different hardware to be connected, I doubt there is
>> any (even theoretical) possibility to negotiate with a set of supported
>> modes including let's say 100Base-T1 and 100Base-T.
>>> We probably want phydev->supports listing all modes, IEEE and BRR. Is
>>> there a bit equivalent to BMSR_ANEGCAPABLE indicating the hardware can
>>> do BRR autoneg? If there is, we probably want to add a
>>> ETHTOOL_LINK_MODE_Autoneg_BRR_BIT.
>> There is "LDS Ability" (LRESR_LDSABILITY) bit in the LRE registers set of
>> BCM54810, which is equivalent to BMSR_ANEGCAPABLE and it is at same position
>> (bit 3 of the status register), so that just this could work.
>>
>> But just in our case, the LDS Ability bit is "reserved" and "reads as 1"
>> (BCM54811, BCM54501). So at least for these two it cannot be used as an
>> indication of aneg capability.
>>
>> LDS is "long-distance signaling" int he Broadcom's terminology, "a special
>> new type of auto-negotiation"....
> For generic code, we should go from what 802.3 says. Does clause 22 or
> clause 45 define anything like LDS Ability? If you look at how 802.3
> C22/C45 works, it is mostly self describing. You can read registers to
> determine what the PHY supports. So it is possible to have generic
> genphy_read_abilities() and genphy_c45_pma_read_abilities which does
> most of the work. Ideally we just want to extend them to cover BBR
> link modes.
>
This sounds to me like we should not rely on common properties of IEEE 
and BRR register sets and rather implement it separately for the 
BroadR-Reach mode.

In other words, on initialization, decide whether there will be IEEE or 
BRR mode and behave according to that. The IEEE mode is already 
implemented in current state of Broadcom PHY library and broadcom.c and 
it does not nothing special in addition to make sure that the BRR mode 
is off. The rest is IEEE compatible.

If there were fully separated handling of IEEE and BRR, it would be 
difficult to do IEEE/BRR auto-detection or even try to issue aneg start 
command in both modes at once then check which one succeeds. However, 
this is not I would like to implement anyway (also for lack of hardware 
capable of doing so).

All code in bcm-phy-lib should handle PHY in LRE (or BRR) mode. For 
example, bcm54811_config_aneg in my last patch version basically calls 
bcm_config_aneg or genphy_config_aneg based on whether the PHY is in BRR 
or IEEE mode. The bcm_config_aneg then calls some genphy_... functions 
and thus relies on the fact that the LRE (BRR mode) registers do mostly 
the same as IEEE. This should probably be avoided and all control that 
can be done in the LRE register set only be done there and of course use 
the register definitions from brcmphy.h (LRECR_RESET to reset the chip, 
although it is same bit 15 as BMCR_RESET in Basic mode control register 
etc.). Only this shall be a pure solution.

For example, regarding the auto-negotiation, in BRR mode it shall mean 
LDS, in IEEE mode the usual auto-negotiation as described in IEEE802.3.

>>> ksetting_set should enforce this mutual exclusion. So
>>> phydev->advertise should never be set containing invalid combination,
>>> ksetting_set() should return an error.
>>>
>>> I guess we need to initialize phydev->advertise to IEEE link modes in
>>> order to not cause regressions. However, if the PHY does not support
>>> any IEEE modes, it can then default to BRR link modes. It would also
>>> make sense to have a standardized DT property to indicate BRR should
>>> be used by default.
>> With device tree property it would be about the same situation as with phy
>> tunable, wouldn't? The tunable was already in the first version of this
>> patch and it (or DT property) is same type of solution, one knows in advance
>> which set of link modes to use. I personally feel the DT as better method,
>> because the IEEE/BRR selection is of hardware nature and cannot be easily
>> auto-detected - exactly what the DT is for.
> If we decide IEEE and BRR are mutually exclusive because of the
> coupling, then this is clearly a hardware property. So DT, and maybe
> sometime in the future ACPI, is the correct way to describe this.

yes, see previous paragraph - IEEE and BRR to be mutually exclusive, 
neglect the possibility existing in some chips to do kind of 
super-auto-negotiation and thus make the chip to detect the type of 
connected physical network. I cannot test it and anyway, the BCM54810 
(with BRR aneg) seems to be deprecated in favor of BCM54811 (no BRR 
aneg, or at least not documented).

For our use case this is irrelevant, we have fixed master-slave and 
speed selection.

>
>> There is description of the LDS negotioation in BCM54810 datasheet saying
>> that if the PHY detects standard Ethernet link pulses on a wire pair, it
>> transitions automatically from BRR-LDS to Clause 28 auto-negotioation mode.
>> Thus, at least the 54810 can be set so that it starts in BRR mode and if
>> there is no BRR PHY at the other end and the other end is also set to
>> auto-negotiate (Clause-28), the auto-negotiation continues in IEEE mode and
>> potentially results in the PHY in IEEE mode. In this case, it would make
>> sense to have both BRR and IEEE link modes in same list and just start with
>> BRR, leaving on the PHY itself the decision to fall back to IEEE. The
>> process would be sub-optimal in most use cases - who would use BRR PHY in
>> hardwired IEEE circuit..?
>>
>> However, I cannot promise to do such a driver because I do not have the
>> BCM54810 available nor it is my task here.
> That is fine. At the moment, we are just trying to explore all the
> corners before we decide how this should work. 802.3 should be our
> main guide, but also look at real hardware.
>
>> OK so back to the proposed new parameter for ethtool, the "linkmode" would
>> mean forced setting of  given link mode - so use the link_mode_masks as 1 of
>> N or just pass the link mode number as another parameter?
> The autoneg off should be enough to indicate what the passed link mode
> means. However, it could also be placed into a new property it that
> seems more logical for the API. When it comes to the internal API, i
> think it will be a new member anyway.
OK then the only change to ethtool itself would be adding the 
possibility of eg. "linkmode 100BaseT1/Full", let the other end process 
it together with other parameters such as master-slave etc.
>
> 	Andrew

So now, maybe it's time to try to implement the solution discussed above 
and try another patch version...?


Kamil


