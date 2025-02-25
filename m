Return-Path: <netdev+bounces-169330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E7A437D7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C593A760E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA325EFAB;
	Tue, 25 Feb 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="icrGS47e"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1725D541
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472919; cv=fail; b=thqUmoR87PvWj/mBXdkbBASQIDKLRI0a3IpAXxzIlxI/0NLlbRvZ87Mwlie5bSemTwX0Y6dP4pnsGrYOneC+2NaVSxpp2UYBeDJmKaNK2U/ThGrVBXjbIgHFnQWRla5LPEFVjHlSOlAXozT2EdXNUjBVJ82nP9aHsUxQ3Tb7QTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472919; c=relaxed/simple;
	bh=rIWTP92PKfaAgbGdE6bfE0rDYuFF1fP61r/J2anof+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZEGFNr/1AVg17LuMWzMp/RMMuGnZgYT2mF/3cUfq4M47Jb/Cw35y/7edASsRZ/CbFfb7D/FZqIJSwRVqPARmRm8OUTVciCCg4FHQP6trISG6H6UWWHk5ddb2m9/0SKCJwV4pLMTjqYiL2jG62JIEfrP60hYFG97P8sEYkByBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=icrGS47e; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsVhIQXvzepIZEwAO4HkpcZaZKIghjTuEu3Bt7nLb5NK1vt2eiF2OaXUHecTqFxwwMp9C6ZdRl0rL+16fFeuYzBuqODhDdOhsAZ6NndcqSpqy9NWqSK5dHXIDJznD5BFZmRZVc1DOj+D78+/wv/Ifu+l9PxfWx1pVtPlBtM2OsCb+gOic550eZSYVRtToHQnsLkNO+no7Y7WTfwnZj/8CvC2Mesx5+rBsN96m+KFADXLpRJtoK6yyjj2o/JcBaAaMeSuCfbruPhJNbcXE2Czut0HVarSItN9BbRhkrJaZiyUAhEBl+ov6pjNhXZqWjS9Ikade79b5RbqH/kIi5rpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnWZqiD4sVX6h0qF3s3EpesHGVba/j9LZDDH0m6/Rpo=;
 b=GF4v0QHJH2zrY7B3igpno9BY/3OWvrESVdKf1MFbNny+qWNABC4gBCXrCIXuficYd2HRhKaDQPNJd5STSO5x98jT3Q5mAwc28RA1dyXsBakQVe4dWLx/hd63f6m8VwzkYzp2xMnqi8tt17iBpgWA7JIlX86lPQnxAY2vmrYABVS3Hqic9Mll12ZoUrjGkRmVlnj7Zdo1s+pXVx/feOA9qFcqyaoHcVGaAp4hWIj+/e7s2aqyaCCIoltSpwBh3lU++dD26A+v7Ayo1EzzzEBGn9F99IiGBdaxGDPTHsep6h1Q82Eg7dFBmo+ZyETybv8PKqOQsmKZrjdeV5Q9xieL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnWZqiD4sVX6h0qF3s3EpesHGVba/j9LZDDH0m6/Rpo=;
 b=icrGS47er4GCe4S3sTJqoXIFzrPNAevR66+YAa1EsIB1Ifso6x9Pij09XWdAe4JZjsyVXAtn8xIfvW0JraZ+PjIB9F1H6+E5+aCMIn9mt1sf1dokCvGB52JA+13xzJbxEDJc96xKqggpqDR/9VNP5hTK/f259FBycLg94rxvzhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB9085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:41:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 08:41:50 +0000
Message-ID: <95b6d4e7-24de-4a46-b5ab-c5a9e14ce312@kontron.de>
Date: Tue, 25 Feb 2025 09:41:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: DT options for DSA user port with internal PHY
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>
 <20250204125050.lny3ldp7wwc3g3km@skbuf>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250204125050.lny3ldp7wwc3g3km@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: edd923b4-53b5-43b3-8b89-08dd55783f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVFySFJzNzZiUHlSM2VPaDN2b2gyNWlsMFl4ZFZPaFVPSlIrckxzYzcvWk5q?=
 =?utf-8?B?Q1RqUUxaWXMzaCtZcEtjYkNJSjJSN2piSElwSmQwYjBRMEFzMHhHaHdQUVZz?=
 =?utf-8?B?MEFjWldSTGhPYnVRUEc0N3dHS0J1MDl5TDBETFB2K3YvWWFkOFAyMGVCUjNR?=
 =?utf-8?B?TXRuYXF6ZUZuNFJuYmlzSm5WM3liT2lQV1UraWY4MXlJeE5zc00vUEdRNnZS?=
 =?utf-8?B?NC9zLys4QmtjUzREMTV2UlJjS0hVNlF4WlB6SWpBUm1IT2FqWUFpOVNRcFNm?=
 =?utf-8?B?aWorOXJhdHd3WnNOM2ZVR05teUpWc2FwMnF1d0IveTB4Ti9Ea1pnTUFNRVVB?=
 =?utf-8?B?RXBiVnBRUVFaNGN0WFk5eWIxRHhBV3kxSHV5d0pTNysxQzBxVG5hRi9SQitz?=
 =?utf-8?B?ejgxbXRjR1BzWTJlMHVIM1d4YXVkS3lYdy8rNHc3bm0wY0tvUDk2aitlWXBJ?=
 =?utf-8?B?bnk3bzdFNVoyR1FhWFBwQlJNMVhoVE9YY3UyVlFJM0YrMUtBYnNrQnhjMHZn?=
 =?utf-8?B?NUdVVWNhY1RhcHo1Q2trUDZDL1VnYlhaSzkrTmRDMjlBd0RGWURlRzRvTDEz?=
 =?utf-8?B?ODk2ZDlyOHdPVDBQN3ZqeG1JSVNPZzN3VXZiWkExVFJxSkNpdnAzcGJnWmht?=
 =?utf-8?B?d0FrM2R3eTFDRjdnZmFPZ29HazNia1BiUmVoRWxwa0tsS1lFbHVzVlBXL09s?=
 =?utf-8?B?bnR5Rk44ZmJnekgvaXlJZStKeGNBcUxYSFBZVVJ0SjI3UnVIUXI5TXNjY2hk?=
 =?utf-8?B?V044eVo4clBrenExeEF0bmkyQkNEOTg0cHpYN3pEY1MvMGJjTE9SNE5kMm9i?=
 =?utf-8?B?TEhWNEpYd2ZUd2Y0am42TG1pYnk4V2lhWHd0WDI3Vzk2dHdrMDl1c2RNaEJG?=
 =?utf-8?B?UzVsWjl4MEthL3NpMmUwMFFWTXF3enhmclAvNGxYNHRvRHhlK2xEV1FDTmR3?=
 =?utf-8?B?QXRPSTB5bkxlMUhyMlNwaStvWWppOGtSZGlvYndoZFo0Y2UzOUZndUdScjQ3?=
 =?utf-8?B?V3VGTmIrcGtLcHVibjh0SWF6Y2p1aXIxRTJKWWgxbTlzOXo5ZmJwRGdNcjZQ?=
 =?utf-8?B?bDAxVUVhaml2QUVTNkpHVGp5RHNTWHA0VUNHOVZja0poUHVRWVBvcDVZb1lm?=
 =?utf-8?B?NFBhbnAxR2ZNYlk5c2h1a3p4K2NETWpGSWJDQm4zOEhqcU1XNjVNeFlsdjdF?=
 =?utf-8?B?UklZZ1MvZlBXR3FuR3Z6MjJscmlNWlBnbERhZmtPRUtXSjNPTEJzaGErYno1?=
 =?utf-8?B?cGx3NzNpRytwTmFjck5UbVdScFJTY2RMSDMyclBxdzRmT3RBTGljRWpnUVRE?=
 =?utf-8?B?RHZjWmRoVkNGY1F6R2V0RFMrMlBkMzNHQUs4RWNKVWF3dGdWWTNLV1I2dStI?=
 =?utf-8?B?Q3ZCTXNQVzhlQkhyUEFSQ29vZHYwWkRBd2UxMnk2eHorbWZ3YmF0aWRqY0xa?=
 =?utf-8?B?RnJjRTlMMWo4N1BQdlVTQTZxREZnNWNyOWZoVkV0Y1ZITmZTWTM3RU54RlFq?=
 =?utf-8?B?ZUJpM1I4Y285MGkxMCtPcmwyRGd3ZWNoSTdYczRDckMvSVY2bWJPVkRmNk1Q?=
 =?utf-8?B?Y0NUTkNZK01ZakRaalNGRlpOZWg1R1h6ckN5Z2dSMDh0d3IrdW5uMDh5RXVo?=
 =?utf-8?B?bC9scnVtZWR2MzhKVUgxTmEyL3hqRHBUVk9IRGh1VzlwU3RKOHJtTllFdXpL?=
 =?utf-8?B?K21zQ1dZaDZlMlk0Q2xKeTJHRW5zcXdERWh1VnFmbGlweFVGWUZOby82UVd5?=
 =?utf-8?B?ekFTdmQzdUVhVml4WXE1bE5EZWVzZVVtSkx4SE1oNHJ1dHdpaDFxSHhaVDZJ?=
 =?utf-8?B?TkRRMWRoMnRzbC9nY2ZNc2FFQXpzdE5xeXVNRFlDczRNVDhaRTlIazU2ZHdz?=
 =?utf-8?Q?jBRVflfYT7ZLN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak4yMVZGUlFoVW9kNFByOEFqYU1kNVpBMWwrNDVFeTZFY1pKekZScUE0eVNE?=
 =?utf-8?B?RktCNkFUNHRWMmcwR2xEOFN0ckp4VkRNcFE0OWwwT3BSbCs2QWYwVWZ5cUZ3?=
 =?utf-8?B?Tm1zUG4zMTNSTm4veU1sVDZybVpyclZMemk4c0NNM0dQUXd6Z1VnSWxiYzM2?=
 =?utf-8?B?Q2VVSzR1dzlidm1OaDNHVm83SXZvb1VUZUtWVzU0bi9nMEc5emRDVFpMN1BI?=
 =?utf-8?B?MXNHaFNqblRZR2hEejQwVUkzcE5UeXdCK0hBNjFnekhUblE2a2JVZWJoZU1O?=
 =?utf-8?B?ZEZ1T2FLNEo3VlFCR0hzd0VEZk9lMEt5ZXdnMGtUNStFUnN6QmRBMGREclBI?=
 =?utf-8?B?b0Z3d09HbFozeXp0eEZ4L0hsc3RIWHErWkRoTnFBc1dUSXlneW5NemlYVURC?=
 =?utf-8?B?QTVDZ0dMZFlMWHVpSzFGUXR1aEYxeTV6WXpybC9WZEY1MmJrTTB6Q0d4TDJL?=
 =?utf-8?B?bVZJSVVVanRjL0NJMDhEVlAyOG5TdWZwM3loYU1DNXlCVlRwV2EzNVowUzdB?=
 =?utf-8?B?M0VQUXlvaHNZcFBoUmY3ZUNic3ZpTGRBL2xDOHJUdHRVSnJiL1BoL0FTaGhI?=
 =?utf-8?B?WFdCeUVOOU0xSWRuYVBYd0RkRUw1MEV6MUp0Vk5JbjNNRm5PQWtGVWd0b004?=
 =?utf-8?B?aUswL1NzMDFsaGhoRVBOUDFESDFQNjlCak83Nm9EZzNrTnRHckd3OGpaT1pP?=
 =?utf-8?B?Y0VKb1Avc3l0UXBXdUFhcXZGK2RCbzNNK0xqM0VtOStxdGR5N1N4MDduQkxY?=
 =?utf-8?B?ajhSZWpvWU1rbUQ4bmtoc1RaMlVqWUZrMDBISk00WmFFdkFybUllSkJlKzlr?=
 =?utf-8?B?UGdoRUpXUVpiV0tDVzd0RUVqTUYyZk41ajF5bGhEY0hHajRMbUh2eCtpOER1?=
 =?utf-8?B?RXlUdFRyZE1Zc0tXZjZEdWdYSkpuYkJnZktoTytuNE1VUWY0WVMzNmFBbFQy?=
 =?utf-8?B?R1lmWnhHUmRYMWx6ZlRGbnNyQklwTGFMcjZyV1N4QzU5aGU0czMrSW1GL3B1?=
 =?utf-8?B?andneWp1UlZjU25vV3M3WVFYYWhoVEVucXRITEM2MVBnNm1GMHRpV1VsR3Rw?=
 =?utf-8?B?OUNhNVVYTmlRaW4zd1Btc0RlZVRidGRINCt0NVlmcHlST1NOR1dUeUFvdlhX?=
 =?utf-8?B?UTc5Rys1MSt2eHpQMm5CTlVDeFdNbW1XZUdhcS8vcXRIcW9meUdWTGxYcWN4?=
 =?utf-8?B?TEZrcU5QWGZFbmsxQkk4S0ZxOEl2c09VaS8wS1V4RDJCK1JhZEp5d09sS3Nu?=
 =?utf-8?B?RU8raXcxcWwrN0U2N1pManhKbnl6b0dFVWlHUnNBaUEybVREZmhHQmQ4NGJz?=
 =?utf-8?B?dXp4MmFBMDAyMTdVTHNvZEhqL3pva0RWU3RGNkpCY0dWcFNkaGFUMGJXSFpE?=
 =?utf-8?B?Q1pGK2lzbkVxazg0OHJDOEw1bGVZSFptOHNmdHBqZXVXRGdYT1BFTU1iUkNw?=
 =?utf-8?B?cjBLZ3hodVQvWHI5b1JjZ0dhRERrUmR4TERYTDZONEZkMHNwUkNxYmFlTGsz?=
 =?utf-8?B?cURicDJQWFZpTU1zVkd6eE1vK0dTSGxyQU1RRUdCd2ZuaHJJSlRtY29vNXV5?=
 =?utf-8?B?S0gzN29vNjFYMmM5R3RjdzJTT3kzb25PV2RKZUlBRDNHTlcvdERHVEJFcy9O?=
 =?utf-8?B?UEd5Z3NDRFNuSVppQkZSNVRUYmlGT1RzeDlXamE2OXZSQU5KblVad3dmc1ZE?=
 =?utf-8?B?WWxMN2JrUEtHelNWLzA3OUp6Q3RqckdNcmkxMm1nR2YvQzlxSkxSWFcwOFVO?=
 =?utf-8?B?QTloWGhTU2pxVWhieDdDem1JMzdEMXR5MXpPcENjcFMwRno3Y1RaY3VlL1Nk?=
 =?utf-8?B?NTlGdzFGeVdGRzhjVHI5eFZwVTd1VTA0S2p1bEp1RXlTeUZSRDFmMm5xNDhq?=
 =?utf-8?B?eHE3dzVkMTdrMWhaWjJGd2hJQ3FjeVh2aWJ6blNBb0Z5T0tocmpWMGg4cy9m?=
 =?utf-8?B?cGFMY0ZmTzJXa1BzbFV2VUs5WlRDUnVCSlpvSWkvTzJ0TU9kTkZ0NU43MUtR?=
 =?utf-8?B?a2RPa2o3U0lzMHM3VWlKVlhNZWpPN1Jyc0NYUjRxYkI4eEdyZUpBaUxKUEVL?=
 =?utf-8?B?ZjNtdUQvUlk0NTY0SlhZTys0QW5NTlhFdTg5aVIrUHZnNHd2dC9kYklwWHRq?=
 =?utf-8?B?cDArb3kzUWNZVlVuRGVZSUVOeDE2blFoaDdvdHlaZkVyLzNxTVZnKzNhNzc1?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: edd923b4-53b5-43b3-8b89-08dd55783f36
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:41:50.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzrq2AvGtcaMlQoDhuV/Kr2WKAPo6lT3yaLeJOEIYJqBOEQeVLeISBhYHAgWORyIE9noPbhhE5B0whC4mPzIjBXibAe8NW6r7qEnA7TK/ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9085

Hi Vladimir,

On 04.02.25 1:50 PM, Vladimir Oltean wrote:
> On Tue, Feb 04, 2025 at 09:30:23AM +0100, Frieder Schrempf wrote:
>> Hi,
>>
>> I'm using a KSZ9477 and I'm configuring the DSA user ports in the
>> devicetree.
>>
>> Due to the hardware implementation I need to use some options that
>> currently seem to be unsupported by the driver.
>>
>> First the user ports are physically limited to a maximum speed of
>> 100MBit/s. As the MAC and the PHYs are capable of 1G, this also what
>> gets advertised during autoneg.
>>
>> Second the LEDs controlled by the PHY need to be handled in "Single
>> Mode" instead of "Dual Mode".
>>
>> Usually on an external PHY that gets probed separately, I could use
>> "max-speed" and "micrel,led-mode" to achieve this.
>>
>> But for the KSZ9477 the PHYs are not probed but instead hooked into the
>> switch driver and from the PHY driver I don't seem to have any way to
>> access the DT node for the DSA user port.
>>
>> What would be the proper way to implement this? Any ideas?
>>
>> Thanks
>> Frieder
>>
> 
> I don't believe your assessment your correct. The internal KSZ9477 PHYs
> are probed either way using the standard device model and phylib, it's
> just that their MDIO bus is not backed by an OF node. Looking at
> /sys/bus/mdio_bus/devices/ will show that this is the case.
> 
> DSA has that shorthand way of describing user ports connected to
> internal copper PHYs, but it is for compatibility with legacy drivers
> and device trees. For all new device trees is recommended to describe
> the "mdio" subnode of the switch, the "ethernet-phy" nodes for the
> internal PHYs, and create "phy-handle" references from each user port to
> an internal PHY, as you normally would with any other Ethernet PHY.
> The schema at
> Documentation/devicetree/bindings/net/dsa/microchip/microchip,ksz.yaml
> clearly says that an "mdio" child node of the switch is supported.
> 
> Also see previous discussions where the same thing has been said:
> https://lore.kernel.org/netdev/20241219173805.503900-1-alexander.sverdlin@siemens.com/

Thanks a lot for the detailed explanation. This is really helpful!
I was aware of the mdio subnode, but I incorrectly assumed that it can
only be used for external PHYs on a real MDIO bus.

That resolves my issue and I can now properly configure the internal PHYs.

Thanks
Frieder

