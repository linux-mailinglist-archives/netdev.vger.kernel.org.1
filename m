Return-Path: <netdev+bounces-199641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6FAE10E0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 04:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE6A3A2589
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE830E852;
	Fri, 20 Jun 2025 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nkkhf0lu"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA4C8FE;
	Fri, 20 Jun 2025 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750384906; cv=fail; b=IHcJM4OKgOdduzcdLNB2qhfQv14M7d2UFjzMgSdAxHozjUq0NbhSM0f6i6Fwx88vft5GYdJxYsMwhBA4OKYS23b+FwiPiGKDZyjOE6vRKQcCrY4u1mbzVyeDMMcf4xGP8Dujd2Ijc4g/WzHuLtZdQEy0nJj9kwTsdHaQuEJK/oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750384906; c=relaxed/simple;
	bh=7bS9pLZNcfraLK+ducmSCqdSsYaxc+BepZyO0nrf5qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rZq21QBbsY0PQY1M+WspFUM89y76W9ToBT5vrgNW/DLivzF1D0XRsFW4rNg6nSPHfzuHhcq5x7Fqxwv8TnMs57piIjP5CGTTlfgCnjxzizZsIBrDIaPhLsjkg9b+zI/bK+js8yTnfUhGREL9XGdmOyRH4axOuiBYSIjd4ZmpYSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nkkhf0lu; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmhNQjokndMySxRaga9V0Wa4crEyY1W01uqyu9kHtSrW9SjOSYiSmicKgfuzr7vkxxpGI9HnOwoZlkW269Zqze6FNLdY6edn+FjbTLGqHsDLCxo0oG0kkD7xXHCYGDd4Gi/xdF3boxrktK+lZEK128UmnydCnp1/DGud31cBYO38VwSM9u7Xk7NcBDZwaeMeQwg2nv6gSaCelPYxTaj/87No44SSsRhsBXlV26G1r5pWzgMSAkers3YyVWU1uFGpwdRacpsukeil8HXPfrkPL9cTJwjffb4vRdVS66XWRdlGCwNsaOP9+8isUqLd+IIg2j9M8CWqFfxZ8Aw2QgNspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZtoGokYCW344L87MVOX0Qz3AK81d58RydqnbZTlyG0=;
 b=BcRRlCC9nV/cbxk55PX5fZJKMrjREl9Qk05+TWSEnq6zpGT8JK9/Q9Du4UTvVj0/YP3FGnXCq+Br/Y3jPtKz1AEYED/oYu3dY9HUsaBw78rpSBFURU1BQySQvedCtxAYAX/QJhni9mJxUcn5oa0euK6Rc1PLSrfE7d362bO7mFXD8MJdCQBrAe+ehvckSFG9Mq5B64U2ryeE8P4StP9v2Dc3V3rpdRJiMAK5UTSVxT83F8dt6wnqNw5k4RqK5lVaN8vKNhyecuoLtyfNijRPJVVxhnzeGEqo+EWJT0tqaOsJE2dtpt5n1Z7mONVYWYmoxAvxcjgHaB/Yu6awmCpqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZtoGokYCW344L87MVOX0Qz3AK81d58RydqnbZTlyG0=;
 b=nkkhf0luv6wLmoIMTtmih8aXlWuAS5eEjjQNs6ZXYuqsoXpDHK6LRdZ3AqeaOhyQ8ycT9aMuNnaNUI3uS8RAy3RdmudwDGnmbC98h4/yCVjNeahyS8SxC0wTp6vNaGYWCh9pTNznT/PvZgECNz0TgZr89nm/PXcdUoSftVdA/CkDZXvPl/No+9OoUYhjbxoColdWDuEkiJhdrZl3U51uSptZtzE3hmaqZeF8r5NlFO+jRCo1Cd8e5X8j5IKvzdtzT2XN5D5iGqk3ZIEAjzJQg8y/qvSqQcTQEil9LSwJFGKlA0DKMklnnBRgSRLvVCSD6vOmSDxqG+HAQHZX7Z1kdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6192.apcprd06.prod.outlook.com (2603:1096:400:332::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Fri, 20 Jun 2025 02:01:40 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Fri, 20 Jun 2025
 02:01:40 +0000
Message-ID: <deeedf88-b481-47f2-ade0-095d6eb49e62@vivo.com>
Date: Fri, 20 Jun 2025 10:01:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfc: pn544: Use str_low_high() helper
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jakub Kicinski <kuba@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20250619093426.121154-1-rongqianfeng@vivo.com>
 <20250619093426.121154-3-rongqianfeng@vivo.com>
 <26bf536c-41bb-4d6e-b722-828facaeb653@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <26bf536c-41bb-4d6e-b722-828facaeb653@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: b22b02f1-d0bb-4eb1-2eb8-08ddaf9e6502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlcxUGhOWkFqc0hZS1FlNXlhR1dIVUVEM0FBTTJaTXhxcWNqaFlFRG9ZNFhU?=
 =?utf-8?B?cGFOcHRlemJQdnQ3RVRhdWZYNE1xc01tQjdGeDJyYTBtOUNwVDBSa2kzTTFK?=
 =?utf-8?B?Uy91OUx4bmlvNm43aU5nMlZGN0k5SHFMTTRLMnJKUU4rQWlGVGJHUENGSkNu?=
 =?utf-8?B?UVNzM2p2eFlaM2Raa2xOUlEvamI4Z1BSeVVEQ0ZGaEpHMHYrSnFBREZHYTFD?=
 =?utf-8?B?bGozMStBY2pCNjdJOWxYbTU5WXZVK1pQdE5KUnVPU3dkdnNWSTdCL0p5aFdu?=
 =?utf-8?B?MEViSHQwSjFyWmxpU0pMS3RjbDE4c3hHZWtDeEQrMlpyT1loaXRuOXU1aGVS?=
 =?utf-8?B?eDBaWS9mWlpXNjRpQUxQVjhabnpoSDdjbVpOWGVQNGt0NzlzVmp1aFgrc2tN?=
 =?utf-8?B?ZjUvTm41Y1J4WlRwVFFhdVY0ZmlOQzdCS1hsNGtDWVZucUZyOTN2RXZzc1di?=
 =?utf-8?B?NElwVWN0Z1c5R1ZGd1pxc01vRUZYVHQ3UFZ2S0VhTXpoWEJKaGxiVmpNbEtJ?=
 =?utf-8?B?cjlQUCs2RWdwRFp3NzBLYUlrbTcvQlQ2RkZDL0w5N3J1aFNnU1dvcEptbGh5?=
 =?utf-8?B?cmlBeDExb0JhZEFybUxjVzlLM2hYYmxremNHd0kxZDIveEgxRE9hQ0p1U3lm?=
 =?utf-8?B?aHJZeVhjVXY5akpHYjNNNlkrVCtXNDR4cXFZSXhlU1c3ZGVlcVdBWmpzaktj?=
 =?utf-8?B?cUR1RlhqVzZVcENuNjlLTnZUZ1FiY1B3RDdTNWhFbzh6SFJPSmVhbWpKaFZC?=
 =?utf-8?B?ZTlTSzQvS29XWXRmWG0zeXZXT3U1YS8zcEMxckFOWXduUWZMR1hlcXJTZ3li?=
 =?utf-8?B?WCtoU01zZEdKYzRnZGZWMzl5Z3JOVW1rOFBCUU5FZzhYMExPaW9xVmlRc1gy?=
 =?utf-8?B?UEV2aWFMK2t0R2d3QVd2RnFlbHJvU1kxQ2dSb1czeWIzdFVPVzJIaTNYUFlu?=
 =?utf-8?B?UmtFYkpxcjgvUGNXbFZMZUhEV2xuUyt2ZGxhd2NhWU1nVHJaaWZucmN0djRU?=
 =?utf-8?B?SVhwZlU1OUdiSFUrNHRjRml3azhYQzZ2bWY0UDdSeU1wZVFDeUR3cXNRWVB5?=
 =?utf-8?B?Z2FKUXl3cTdCeWFrQWszMGlSU3JodGxXM1AxVjNQUWcrWFFNQnE2UVgxRnQr?=
 =?utf-8?B?NXpNTjJoSHNVZGF6ZWs2djAxVU90RTkveHRMeHpvMGNMVDBwL3U4NFpEbEZt?=
 =?utf-8?B?K1psWXlVeGEzVjJqVDFhWmNVK2NpRVFLT3AvUWFCeFNIc1FhbkNTK3k2SUxs?=
 =?utf-8?B?eTYzYnNPeEtCWEk1K2lSRkIxdDVOTWhvZnVnZmQ3WE13S3lRcmdJeEhhcGVG?=
 =?utf-8?B?QU1OQnpINU1zVEJqU1R6OHF3SS9hckZoeHplTnV2TlZHTkNvUmJkVUtZT0tp?=
 =?utf-8?B?OFc3SkxzNmp1YWdpRnA0akJLRStWYkxMQnNPL2tjTlBQNnRvWElZbXUwV254?=
 =?utf-8?B?UjlzVE4xUG1YZjN0MkFUdlhWMThlV2xiaEhHUTdqQXAxWlVwN3FtUnRPMTBu?=
 =?utf-8?B?QytLS0JIaU9WNVg4TDVWMExLUHQyTjRTd1Z3STlsdGt4M0pzaXJpcStoQldK?=
 =?utf-8?B?bENhdHg3WkJZb3VHRlU1Q2RMY285ZnlXajJYTWw2MDlqWjU1Q2pJajZhZlNO?=
 =?utf-8?B?TlhMUXBVdy83bWEzZ2RPOXZ1Wjlxb21DTTRwLzdyWExvTSt5dlZoN3IrU283?=
 =?utf-8?B?RitLMnZnTGFya05yTmdISFNJY3NzejdCcVdvbVhLUGhkRm1RanVRNG5UVzJw?=
 =?utf-8?B?RVBKZGpLSnR3MmtRQTc0QnAyVEgzRjNRbmpVMWFDL29hKzlVYWlIakJvaWhS?=
 =?utf-8?B?Sm4zNTBzR205Q3I3MTBrekRnSmNNSG16dllDajg3SDRoWEhPNjdPZVVnMERl?=
 =?utf-8?B?Qk1ZbWlsQVlpeklpVXhlaFNrSG9pWi9iM0tPNncxZGl1SnpjN1RXNkNINklo?=
 =?utf-8?Q?ozFJ5onmx6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBqSENHOXhrSkNGdUJHNmNoZXNWaXRjOXJ6NTU3dm9oQU5oSnkzeE5iVGZN?=
 =?utf-8?B?Y3NRUGI3TnI1ZDFSZ2IvQ3FyVXZ2R09xVU5jMi9HZlVWZkNoZHJudDNyd0hM?=
 =?utf-8?B?SGQwNE9Vc2FXRjJjSkluN3Z0aksvRHh3Y25HU0IxMHJ2eXZZTmx1L29qMDlU?=
 =?utf-8?B?RVY0RnAxUWVNcnBJa0x0Y1E1d2piOTFTZkppdjlQRjdoQVpLb0UzT0RpRFhR?=
 =?utf-8?B?bm1MKzVJa3dCNTd4cFlYNEFhWU9DOS9aeEE4ZzJnRjZOMjhpS3Z6cnlFVTNE?=
 =?utf-8?B?ZmNhWkQ3WTRHZDcrblI5U3dNVXpZRUVQaVp6MXRVNFBwM0RkNTBFT3lwRVFy?=
 =?utf-8?B?UjIwSHdEQmJGN0xpdm1OQTM2WEY1bnl1QnVWWVNSLzNRSEdhcUhlNURBSzlW?=
 =?utf-8?B?WjVjbXZQMmN3WTVldFB6TGRKcEMvOXcxelFDdXh3ejlpU2Jwem8yaVdDOHVX?=
 =?utf-8?B?K3llWlpPWDU2TlRnbVowbUNzSm9ITVdvZG5vUTQ0SUU3bFl4TnVoNEYwU3Jp?=
 =?utf-8?B?d3RDQnlZNHVRcC91MlUwNHUrL0xwL016djdLaUtXdlJaQW1RalZHb01tY3B3?=
 =?utf-8?B?RTBEYWlOV3p5a05UdG5yTEdjK1MrT25zWHlNVzlZY1hWaU16TXpUTWNqenIw?=
 =?utf-8?B?WTBLVW1YT3pHM095VGN1U0U4a2VXd1YzUDEvalVCMklSN3gxK3h1V2JwWmk0?=
 =?utf-8?B?NG9CcW9lNmIvd3NFM3l6R0VvUXR0K1pnby8vNXVvcWdTVjhXZlloczUyNEtz?=
 =?utf-8?B?YmxndzFNL0F1dlBycjhxQ1JrcVpkWE9CSFFaaUJKWnlWZUpJaEJvNFNkZ1gv?=
 =?utf-8?B?OVdKdkcra0pXcTBNOGlmeXZ6RWN6L0hseXMyQ0x1N1FIZ0ZqaC9rVVkzWW1M?=
 =?utf-8?B?cC81UHpicUY4ckxnYlQzTyt5R0ZVNDdKSHRzdG84RElDNkZNdHBGUk96VVZl?=
 =?utf-8?B?eU5PeEVIeFJCWWF0aW1rQlZwTURnY0k0RWRlcXI2ZEFUN1Rnbm1vVXRIVFlY?=
 =?utf-8?B?d3ArcmV5akQ1bFdkOWRhdUhrdndYYUdYQytxMXh3TXVnazRpVkRLOGlONWlt?=
 =?utf-8?B?M29USlhUQyt5b1RXcHNRVE96QTEyQ0srNDloYzhPaFlNOGt5TG5yaGRwekVq?=
 =?utf-8?B?NGx6dDZTWlI5d1dFZkx1SXhoZ3g0UVNEL3ZKSG5tZzdtL0VobmNmQXdZaXJr?=
 =?utf-8?B?V1YxSHdaRVppdVlWVVNUTEJjK2RkSnpUK1dHQldneXRRTXp1RmdtelVuTHd4?=
 =?utf-8?B?cDZKQng3T0g5bjhiL2d4SWhjMVVRUjhuNE9YWWpyNE50d2l5Qmw5NlNPRFpO?=
 =?utf-8?B?WGtDY0NzNHpBbHBaZHFLYUMvUDYwc3QvNHFwZTAwOFJGSXQ2RmxTTHFmeHhs?=
 =?utf-8?B?S3lGUWJaYjA1aC9UWjdqQW9LZituNm85ZDVGbVBhRVp6MW1aMmpQR1E4eDA2?=
 =?utf-8?B?OThWVE5rbEZJam5LYjMxU00vNEFaTk1PYWVlQ3lvQW5lOGwxNGxDOWIycjkv?=
 =?utf-8?B?OXY0T1pOZXNEQ2lzL0xoL1NnOUVMNWdKZHdWcDlDRnUxM2ljTDdwMHlzclFU?=
 =?utf-8?B?Y0pCWWNOSTRyTWwxSlZNT2loRms2TXo0NVBDT2tDZFNvbE5xUjVKMkt1MjNa?=
 =?utf-8?B?UkhRSnZCc3prcFYrTUU5UUovSWp4dXB0WlJsVTYvWThCcHdONGJNcUpLT05t?=
 =?utf-8?B?UHRQUlJiWWo2ZEVaWlBBaUZSVTBXazh3cmc4b3BWcjk2QWJKUDFsYStScEFY?=
 =?utf-8?B?eEVVeVppZ2JGSjZzWFllVmFSOTdqNXRWcGpqV3l3dWk4dHpvWUkybnZTVkxi?=
 =?utf-8?B?a0dzOTdKUCtSL0ZLa2lhS3dmbkJUeXV0aUEyUUlzb3NvYmlzSElJVTV0T20w?=
 =?utf-8?B?aEJ0eURWL2V6SWovYjVRd0tLZjBxYTBBNTlYa0ZqTnV2dEZTbFJRT0RsUk1X?=
 =?utf-8?B?YmNEcCt0UEh0MnRLRU5XY0JRWmJsajZST21CT0xDSWlqbnFndHRqK1JwcC9y?=
 =?utf-8?B?cGJUcnZ5cVdqdzVmMW5LVXJVV0N6bnVETFlYbkZWaDNtcXJOWHFTWGZDbk5T?=
 =?utf-8?B?bjZJcHRDd1JIS3d5TzZkZm4wZktCVmJYaGV3RkRpa3VIVUtvQUpIdUx2U2RB?=
 =?utf-8?Q?Wpxep3WbGfBgkeInl+SGLJ+Ud?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22b02f1-d0bb-4eb1-2eb8-08ddaf9e6502
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 02:01:39.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Lgs5wzX/nb4vzChKyrxfOxJW1UFnQ0Rw6yLXqiIUCV3LDd5QT9TIVQLA0SJmCIhcAcx5XbsIEerRjvwlU8jXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6192


在 2025/6/20 1:33, Krzysztof Kozlowski 写道:
> On 19/06/2025 11:34, Qianfeng Rong wrote:
>> Remove hard-coded strings by using the str_low_high() helper
>> function.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/nfc/pn544/i2c.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> No need to make it one change per patch... but anyway look at netdev
> responses for that such changes.
>
> Best regards,
> Krzysztof

Thanks for your reminder, I can release v2 if necessary.

Best regards,
Qianfeng


