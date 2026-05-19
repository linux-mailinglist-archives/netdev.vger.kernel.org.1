Return-Path: <netdev+bounces-289209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3SA2apC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:05:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A08A5755E6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6A03044F1C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC357E0FF;
	Tue, 19 May 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="su6rdVXO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660191BC2A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148923; cv=fail; b=Jz/lIAhSNd9Jtn90hz+MwHTIbHx9pFKPeUFLJ2OpEkOFemqOWdBs+d7g3kuFT1ept8js+5rRcP9uUihMhlkZDJj5eaBMWJ7fr+v09gDCHu8MlMQy7EfNS4xjx396AGnhKr78grKAvLAjLCwAipafoos1RsN5r708qc5Mgm3uzWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148923; c=relaxed/simple;
	bh=OrYVP/gYy3GxrHDH8rNzjOWjChqcEGt2DBW9NsSnj/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GpsEcQJoZM7L372U5GvaIuixu1LgZpKeXu6dXupkwprO6JnIxCmGEh402+CZXUWEYKoIAT/GbYAQ6Z2fGx051foSjGC64n6rhYsM3SeSIRhdFmorPJMwOZNHHd2fw2BmCejhqus9YEIJzwtEbDCqmYKjuIIwlsxvJ21dLQvKExs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=su6rdVXO; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C49TUq5vT54TCm/2QbxzVInfcnbeSxEiK2rcG77hcmgDogwsGxlDLaCTzqUnPt9MVyGi9T933BUa5bOsGJf6EfJjInlqUx+cJuhxBllHDiLHQNViPkaXKaCSH5pXAIv/8YhO7OujPswKmXWzPdaDCbS8k0AXAM2IMhwfNGI6BQUTmScetMLRmZMBakC9dLW4KuRz4jMIfQOKnlTGGP0znPK7yQgmKATAbVEeZ6f/0xkktavMzPaGUO487yRJyUmrVWdQ7QRky243n9BnB/BVwnOl4C/pNYSWUX8FIxsY8nnArZHqooMb6I79iPBm/LMbpV3yCKLd4Pz58DwIch6sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1djQgsBBenZXPe61uj38Bn1Fm9VME5HMPXDTbb+Uws=;
 b=h2sWZ6PXX9VQXG8Y1yQzyq8eujsqRg0vFOGfzMoZJl8NiOnQxaonMELndT7xBHF+EtXbS+XTOPjFOWVIhd5YqBiQP1At03ByuJlNNu2eHX8n0T/7yrMi3/+PzQjuI48VdDg7zVrPLDHkPiXRf/AEPEeZMvR6hmL2KI1Zj1SX9bTyojZNh0Z7/VJvUx1ZTNaI0HJy9++0gPkNt+XznxR5IEEHLcg5R6eFYHDdO+Dcg7zvSkcQSGDvpR97rIUTbHlB/SXBqJSuTdUgYQ4+a+Alebd0fR2tFlGMIXafw3s2/bCeyp6oyLjc89+V4iBuwnOc+iqSsC5VuPGbalHR5dTa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1djQgsBBenZXPe61uj38Bn1Fm9VME5HMPXDTbb+Uws=;
 b=su6rdVXOZ50e345D5UyKo3paTiZAdpf1PVB+YjUa1XaGLFYOU2w9Os6foaegGt1MW7MdMvc3NGvul2Y+RJaPCAEbNJ9BeC4SWL9OyzzvOLHMf+ZEMIF4zJNHy79iUNjtZeqSdp5n1ZoSzxZOQn7pmUC73QJkMwaARgj4zOphMmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 00:01:59 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 00:01:59 +0000
Message-ID: <4c18744d-742e-49c2-bca1-90c86cdcc2ed@amd.com>
Date: Mon, 18 May 2026 17:01:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] ionic: Small improvements in devcmd retry
 logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
 <20260512224421.25236-2-eric.joyner@amd.com>
 <20260514182646.16f8ad33@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260514182646.16f8ad33@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 200c70bf-cb98-47f9-9cb1-08deb539d8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	WrHe1jiyALIi0gKlzh/abrq0k8TpEH8DWbKqD6qEIitu+rwj+04rvtomxYspHF+9xMEv471LAQqKinZRnOqBD4spbPw0O5vAtWVY0YIfpuwlXh1rpcc0RG58zf61szQRFQiHPjbJVdg+ziZJ82j+1Ri4KqPdVjGoruKuJBx12hwtQcf7kw0UU3OGfxyWOCPHjMik0JrHJdQ/EVV10M6KB/cguhcDIRdiPLSnma3mqeFPUdjsXSvNQc9bEGjba+BQaFk379RposJHkFNb8eJiCZeVd/xRQRsTdpxaRNz9Sh8SkRK3LZRAA0I/HsugQZ7v/FX8/6ICU4L7PXysDnd1Pc55eKWhrp/+T/z/MpBfAvEQebAA/fPfVXiatTHnYCwwa4S7ebSF7cgkr+b2axesiS/55yrjDXi3ln4VLEgA5K7+qpAPSsYipD1dMktE7sh34qx4oAKFlP/p0ZUsxxCzVSx2PDXzA7HyU1VroHZAKrkNPn0XOjaldML2U6v07eJezh1gnIHHT9wLJbKCkqGNlmKR+8UbnLAxI4IBLRcAbLvZPrajpyuGw4on354MPwTmVDE4eDgWNe2Nkbt98xMCukDPZRbxcQtSOfJPYwylv8X8b1gcGOi/F6CVKLcMJndrtq15T/baRPZ63Lx0/vwEUw8vdw2ZG8DV7YtbCBoh6luuyId1he4mvKo7PugxO7SH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXQ2aTNFcVBWVmg3MzM4cVRLLzVzTGZ6L0pFbTFiSXd4UTZocndmKzNDYmxv?=
 =?utf-8?B?NUtTTWxjd1pYTlJwdjNRb2ZzOVl2K1o2engxUGZibCtLcndWbHB5V1FsYVNO?=
 =?utf-8?B?bnVVdmwvSmp5SWpxMVhLL05iQVZnYzk1NU54MHZqNTFBY0RyYUVlcjBzSnNO?=
 =?utf-8?B?cWJtVlBFM0hDK0tqSmlNRHY3S0k2TFdDUTRQck9lNW92aTloYXBYbnRKakI5?=
 =?utf-8?B?U0wzdmo2UFRiYzhUN01HbjZ1K05nc2c3MWs3UlNFYzlEdDNpSlBnQU9JOFND?=
 =?utf-8?B?a0wyTTVIdG9saTNCdmtHQkdOakY5TUN1cktaSjZlaVJiNFNQS3kzUG9rUUQ3?=
 =?utf-8?B?bVdDcWNNVGJNMFF3MW5icGg3dHBTYVB3b3pHYmVtdDF1SVppUHlwUitwaWdK?=
 =?utf-8?B?K3pVbDNWMWszdlNDUkxsa04ycDh5SmZHWFdrTCtpamV6Y3d3bjNsb3M3NXFG?=
 =?utf-8?B?cGtKcFBjeFJMTUxhSW4yQmpjaFp3ZkxkUXdTQW5VcHJkWjY5WWFiRjBacVBl?=
 =?utf-8?B?WER0SGFSdndteGlyZWxkUWlBVkpqSk15V2x2azdWcUttTHIzdmJlYjI3KzlP?=
 =?utf-8?B?ZEZubDNKUnY0K0VpWlJDUXBSNFlCYjFIN240TnEzVTdzd2gzdURiWGlKRG44?=
 =?utf-8?B?OVpZdFFDVEdDenVVbHNsNk1RaUx5ZmZVN05nVkRraTg5SDdFMWdPbVlHWW5D?=
 =?utf-8?B?a1ZlWGptdEVCaGpQZEZxSUR6U0NRUEtCOVM5ZitaY3dVU1NPTHJyeWdsUVFD?=
 =?utf-8?B?bld2STVIUGZSL01HZk8rdi9jNDdKUm91aEJidCtlci9SaUxrVjI3YWhQR3Fu?=
 =?utf-8?B?aDhHZ1pSb3ZXNkxiczAvL3A1Z0p5WnU0cmRQMmtIVlRSc2tPY3ozMVJWRnJQ?=
 =?utf-8?B?cWxOV1Y1dk1zWHJnaXJwUFV0c2IrSUhUS1dCd2FUNFIxVjVIRVpoOHFzQm9B?=
 =?utf-8?B?R3MzdDRnMTE3VnROYitJQkE0WW5FeEpGRXo2NnR5MUFSVU1ReVBKdWRqUUNQ?=
 =?utf-8?B?djNyZ044T1ZFa0ZRVXcrWGZHM3loQU50S2xvNjdEa0h5NmpyT1BMUEdRUjJE?=
 =?utf-8?B?Uk1sNE9zT01YRDF6S0dQZmsvMEd2YkRmdTBiaXB0MmFSdXU2cVlvdkt2eWxj?=
 =?utf-8?B?TzVaLzZuN3VQdURLNWVabEJUbG52K1pYRU9UQUdodzd6SytiM3ZQNnlmbmJG?=
 =?utf-8?B?SXZBWktzZzJVNDFJR1RMS3YxR2Y1QnkwSDVhUXR6UWdJYzR6WWpSUjlTWkVS?=
 =?utf-8?B?Y09idGE2UFhleWNDeVdwN3JHYkRUS0hxOHN1bWdrN0JqeEpGeVFoMTRuV29Q?=
 =?utf-8?B?SGc4ZmZ4cjRvV0VKU2hkY0I1WW95RU1aY0Zsb3Rxd3F4TE1tbkcyQ1VZUjFi?=
 =?utf-8?B?d1h3cVhJWDdDWDlaVkRxcVdYL0pseUJLYU9DVExpOFJhQ0FyMmFVNWsyN0k3?=
 =?utf-8?B?WnpzUTB1NnNDOU1neWphZFNtL3lUSElwcHcxVTlzU2htTGh0Q1IxVitvVDU5?=
 =?utf-8?B?V0FOa3VocS9VUHk2SG5yMG50cmtURkkvZFE3bjQzaHlhazlSeFFZK25Jdzgr?=
 =?utf-8?B?V0ZTazdvNDlJdzlvTjdBRVpKWTFqU1U5NTB5UmlnR0FRT3ZHT09XUFhiSitC?=
 =?utf-8?B?MHk5Zmc0K011SkZjcXNUZHFWS0huVndBd1FKbXRxQWFpbnVrWFUvejBCRTdL?=
 =?utf-8?B?V2VYVFpXVGhTTDVWbmNBeUFYckZRdCt5QlBQY3pmdjZNcXVDMWZQdlVkVzBW?=
 =?utf-8?B?ZFVlWWphSmwwdXBIVUFzS2JrdFU0TnpFWFBOc1VUanBYQUwxTy9MNCt2K3hW?=
 =?utf-8?B?MHR3Qy9xaUQrSXlQYXJpSFVKUmFpU2xFeU9zSXlpYWY1TVY1ZXQ3UisxTXpS?=
 =?utf-8?B?ellvUitDR1lDRk9SRGkxbnVqUmtjQy9GcURuV3pPNFVNdGxJd1JNNWxTenh6?=
 =?utf-8?B?aXc2eUlwUVFoNEVrckVObllDR0xoTWJJSzB3ZTcxQ0drVStJOEx6U241aFZC?=
 =?utf-8?B?dlNMZUxLT1RSQzZsWFJjWktvWkYzWTRXbHplWitOQ3liN1A1UGVmcFgyREJa?=
 =?utf-8?B?cWlIblJhRWJKd2tuMDVTL0pmVE5aSTFsNzF5ZitxYThXL2s5TlNtN0NLa0ZD?=
 =?utf-8?B?a2ZDd25mOGs0dk1jOUFiZ2NWY0JaWTlxK2M5OXhPQmVxdDVFK1I4TURtOVU1?=
 =?utf-8?B?YnBRaitjQnQzU21UejhHRlh6RGt5amtZMEJoOFJxMk5xajI5Q1NmZS9paDlk?=
 =?utf-8?B?OERRcGkrcEJuSlM5SkdFWDBoQUhDS0R4ajBKT1p4ek1zbnpUT2FJbmJTN1Q2?=
 =?utf-8?Q?YZsrHZacY6InGLhVke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200c70bf-cb98-47f9-9cb1-08deb539d8fa
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 00:01:59.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43vnf66cgsmCPhSMatuw/SeWCgZo8DTcShV8RzbeHFBZFsHr/Hemy2skxO5FCAEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289209-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A08A5755E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/2026 6:26 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 12 May 2026 15:44:17 -0700 Eric Joyner wrote:
>>  Another commit uses this return value to help
>> signal that a deferred probe should be performed due to the firmware not
>> being ready, which is why it would return EAGAIN.
> 
> Where can we find that "another commit". Reading this I was expecting
> it to be another commit in this series, but I don't see any EAGAIN
> later.

It's in a commit in the series that's targeting net that I've posted; but I
think it'll be clearer if I roll that into this series in the next rev.

- Eric

