Return-Path: <netdev+bounces-134367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7A998F19
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C6CB2A077
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99019CD07;
	Thu, 10 Oct 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c30ed0tW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2037.outbound.protection.outlook.com [40.92.23.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF951CB309
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582716; cv=fail; b=qq+65sg1m8aCCDPM8MxW4dHH/xWgIwe20b4oAYvI6nWExCs1faiHyZLyRklND0nin0cAOQ9Zryc9IhFpzHPySWimeVJCes7j2ZmZUnDdtRSoXN9hcd1tcjnpc8mYsYh28M5ajarIjY23PW3aetA5iIhnMpwiofZNbkEWGaVyyWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582716; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=giQmqakmkS4ZibC3Xjmf6QgDvgEX9OXz7Uc2MYPLpTvaxMfd8Rf6YxFtmccYamqkOrY7HnrTIJSOU5iy82abp5fbaKN2UYdnYqeoQ1MVWHprA/wySPvYQJJ6+DYau6sBGNAdVHnndErxGJtBJMfYcyQ+RhmazMThAB170iY/QXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c30ed0tW; arc=fail smtp.client-ip=40.92.23.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsJn5SwiZZMZXpGiYenqf+82YLi9xFYqYz2/ZGYZe+7RpAWGSDkffoIX6BCO00z60iAEr8KwxyNTf5M1XPuP4kLTUPwcZsThYlCpzXj+MZrjFcMhWWOAfujPqDtga/prTq7KSsK7H0b1TxMYqWdUXHxT7rC0n6WqBsBhDk9MoSLGOnWRbs8DuSlolQE1v5A7X7rJ5zrDbrg00Vqo6GUnfv8YxIZNshw/14O2uzM2hh7FOkS40fKsc3CTbqbJNU5ES712+MWVa1sgEwyG660JRcuoygAnJf/e58iwC2HnVbEU5e5LeJMBxflOwtdCApOeevFIZq4N3dR5rSlR4BRMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=dlVknA43HlzXilkRMWB7q5sqXTqmPnD+aXhkurqQ4EsRXIpTaZhRP5H8QimQQmciDnPF4UgZXeNvlBl7svxK7I5k4xWe2Tcn9af0Ej8hVo0FTK3NivJ6+w2dIxEqH6znwXtXnbFHaTWOjzzoBSAJbCvsyOrcJjatyZqIIzAA5wEP9pWnF8Khhnr64jnzg5L3I3NdEGivWl1D8/+SSLqk+S20Fx3sMyi7UvfybLgJpkFjPd4TolgKKBDTN3n4FhSGkFOTZpLi/jnoT4DG/5jaleEWOnuOG6bM41wwCpkDAfFETKptbZyegQzd4T+m+dLPHGEF3hClHz+UzGSm82Z4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=c30ed0tWpka3q4anc/ri4tV1+WgB6lJr+iFywzDcU8NBJ5WPfvRS6dWWCrhHBD/D6qnk/r4cpAyzndBiOwfAfmotZrfobLhLNu1hoDIp/ReCEKBRKyLjfJyoEj8y8p3ctEXStDtQrqkt67e3ovxZiJufIkau6l0DwvC1Tycx4cR2DBWOGprcEHNZ/xfImhGRO2xanhBqPK6PAZ1u0drd2TaoUz8TJQZ8kjS5iUr8uQ7AA6qEcAM5z7nw8YRLrrF6RmGWOmOliyPE0gnsxv6TlEJ7UH7+PJZe19jwHkoV58XZAYIdymgwHx01flJIlaKOV0gVO7kMRAv1P85FC8HkXg==
Received: from CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1ca::5)
 by SJ0PR84MB1823.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 17:51:52 +0000
Received: from CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ab1f:ea69:7433:dd47]) by CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ab1f:ea69:7433:dd47%3]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:51:52 +0000
Message-ID:
 <CH3PR84MB35221465D69F6E3CF2EFABDDD5782@CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM>
Date: Thu, 10 Oct 2024 13:51:50 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Iulian Gilca <igilca@outlook.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0805.namprd03.prod.outlook.com
 (2603:10b6:408:13f::30) To CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:610:1ca::5)
X-Microsoft-Original-Message-ID:
 <b104727c-2b24-4ba2-896d-93f56fdc9d08@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR84MB3522:EE_|SJ0PR84MB1823:EE_
X-MS-Office365-Filtering-Correlation-Id: 27219979-4545-4adb-1397-08dce954388e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|461199028|15080799006|7092599003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	MRvhv/SFi5OD0msAhOqKDoUldFeSXZ0xU0OgLxUzvgqoqEXSWWAxrE2rg05llvQrApxl+Bp14smjlwqWfuPGzAvMKRtut65yMXl//KgKCFAsdv5H9k/26Le5B6UJ3A0zWgkZmEGs6EVcXzyPcWUQWdw2gOK+wyE7ijQErG2n66LR+fQcp19ce5nnhQ1sAE08oBTlbYnZuqgVaEca24qMPgJs6Xvllhgu9JuMMwBfwGLMrtd5MCF5Whojb0T/e3pknELkwljE8IHt8c7mWZ8wpuN1XNaFlHiN0z4HKGJXkhEA6+hCnWnGUfhEC+G16HnSrkjR8b2UVd+hJRCirDz05QhKPMRyhgg+AlE/rBZC57od/I5WTfeaNH0MaQF+tvzdwoHxBnRTxoNjmckFJo/cH8Fe0HV1djbu2F+yKDHLLTEDygNbNCqrpLtNtXDS0VNy695Rff5pYBg4hrRmSDHREVfzrZPsqKci+AN5n9smpl0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhHdXhoZW5IRSttclpEZ1NML2VzYncrUDdSRjIvZDJYc3h2ZndkTzhQcEt4?=
 =?utf-8?B?Si9wRzZUWG9iWnlDQVlQWHBBWTBFc2ZibkVoM1MzSzM0d1Y4bloxWmVSRGhs?=
 =?utf-8?B?aUJUYVlwREJMYW13dE5wZlZiUDdqRXMrM0Zjb2RDc0E3aVc4RTRoRGhiVS9K?=
 =?utf-8?B?Vi9Vc0JWUFRGTzRCTmErSGsvRkhoVjg4a0N3WUl4Z1ZSbUlRV1RZTHY5bEpa?=
 =?utf-8?B?NUQwT0Y4Wll4TXVEQ1V3K28wci8rQ0s4TGRPdHFQL0RmOUQycWNQWFYwTDRG?=
 =?utf-8?B?cTkxZS9LTzhHdFF0b0ZhRUhOR2hKdENWOFZqRVhIczFBcXZLZTJKQU51R3dN?=
 =?utf-8?B?aXFYZllIUlZpakZFWE4zTUdHU2Z3MlNrd2pCOHVDR2FjRkpRTTYrT0JuRzVp?=
 =?utf-8?B?TndjOUROT0k2UlpXcncxTnpmaWd3MDZ4bXoxam94MmVCMUtJaGMzRkxlM1hp?=
 =?utf-8?B?WlY3KzBCVE5nQTVNU1NKaWpRMFo1T2R6eDNKdmxNSHRpZXdpN1habnlRQjNh?=
 =?utf-8?B?UDZxNGlVYVlmdWVvc0h6bE1SMVlXZlZ3enRBdHdHZXpseVE0T1RMYkFiT2xq?=
 =?utf-8?B?a1BHWm56c2t6VTdncTJMRXRhb3U1RUJVeW1SSkdqMndkU1lHWURZY2x3ZHhK?=
 =?utf-8?B?Q25LN2RtUjdnY3VUR0VTVmxLNENWbEdabndZY094OE85Y2NTbUZmOEdtUnZB?=
 =?utf-8?B?VkZ0ZGFXZ3I0aFE5VldoU2kxSkhHdndTSkJDS3FlN2FSN2QvWDA3TGdjemlG?=
 =?utf-8?B?c25UeFI4WGtPQytxa1NGSHFEd0NrczF3VXJtYkVlbThLQzhSWkZJVm5ISWV5?=
 =?utf-8?B?SE1SN1paR1JmNENmemZBYjFYa2RRWTFIY2RTa25XaXB5SWpROGNWSTFjRWo1?=
 =?utf-8?B?cmxUWjFUbnBPMkROV043b09uSUlTVUxmem0vRzNTZVNGaXEzbW1HbzJJZk45?=
 =?utf-8?B?R0dKdWZCSTZ3SERSNS95Q25KSDZBdmpsbm5jdW1tbHp3S29WcDZwUU5ZYWkv?=
 =?utf-8?B?aGI2TEdKWkNMVHhDa0Zjejh4bm9ra2pHVnZ0Q2JPaytKZFdJbnQ2Y2pnSm45?=
 =?utf-8?B?Umo5d1QrbEZMQUE4L2Nad3B3Q0lyWndvZEU5c1ROY0lkdTlQdTBGblFjVm9K?=
 =?utf-8?B?bnJ3UzJjcENxUEMxSGVBN3F6UEROOXZNVEdmNUZHLy9saDVjQXAwNU55d2lU?=
 =?utf-8?B?RFY4UkIrQlpQQmszNHY2b1RaMm9hZUZ3OVZ5VFF4SkNoTDRRQy83TkF6SEpI?=
 =?utf-8?B?MlUwK1NlYTJCWVBpSjd0SHhFYXBpMXlIenJTOFVJY0FOYkFTM0lCTDNveDVE?=
 =?utf-8?B?ZlFQNE9MMGRIVGpkeHZrdVI3d0J0NUZhWStHZVNoNi9lSER6aDNaTm9aTGdF?=
 =?utf-8?B?N1RmcGJPZU5iaEoxcVQra0dLbFZpdWxBQ0VnOGlIZjhyWno3L0hHRmFqWHN5?=
 =?utf-8?B?UTVYd2E1NEFkQzNKZnhyM2s1c0FJamxuU1hCRGJoY0JaeTdYSkNTL0dBKzh4?=
 =?utf-8?B?Y1JHMGE1VUtpNWxDMU0wVHZzbE4veitTR01aMUJCL28yTG9UTmlZZjRjMFZx?=
 =?utf-8?B?LzgzZ1dvNlVyOHltOGNFK0d1c2tGb1Q2eVdGVHMwUUd2UnRrcTkrT25EUDQ1?=
 =?utf-8?B?eTZKdk9DREd3QUMzc05nSG1aS0ZxQm4xUmFocFFCbU0zUGxSZHo5M29oSGNS?=
 =?utf-8?B?TXlOTFYxVkR2QmVhaFlnTjJJeTBNQkpVbllPSERodTdVbzNHTERUMTUrZWMx?=
 =?utf-8?Q?CJlrpRHdOUbYaVok8M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27219979-4545-4adb-1397-08dce954388e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:51:51.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1823

subscribe


