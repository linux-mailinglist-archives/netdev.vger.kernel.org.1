Return-Path: <netdev+bounces-206419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96936B030CB
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01F1189BFF1
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FA1F0994;
	Sun, 13 Jul 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V13l9nOs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052B1A83F9
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752405164; cv=fail; b=STaZJH9FMZwRwZAqhcpxCvEO7/C+XJANwAwIZlC8FSp05SgoN1NWu7PydBy/eZ18G1Xgo+NCc6RB7PAicH7KM06C0z76GLF7304bHV48Sm4Jg4ycAG97gdDoGpeE24muCb/DuyQOCeVSKi9FtlL1DhKJmtoxEV+n16C2sRDCsug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752405164; c=relaxed/simple;
	bh=hUi1+//U8liwCK7ORyDvUYg1JC3AsNmtafAE4aeyQw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAGWgRmYTlXD4OSxYOqYuySEB5fFgG7CEJdyjdcWJosQusNgQfO75YuuqtSovcRcufeTZRGsW8dbDRLjpsqCZasweAAnwfI/CLwaqGgGBy+myIKmbCFgEbn5EfxVx2bvYOCznHDunC8R69JaHrrZHPgWGOf7W8E1hOkFW1lAvt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V13l9nOs; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxhW2btvDDxjl8j8tffGNCCgogojZfTBhlvhWhg4G/kVU0STLnen67jdT3UyZuGqdGAVr1owMCfV7yzI9qDpZhg9DhmF8UAzwHurqVSn4jVwN+AvORS0DPtJJ9evviUbSve/trH7GdtmkIo7iz/eoRVO3wopqokbYb+YuyzgHz5h8/gIzqB5MD0oMAGGh/G2yl+c01Eu6ldoYUgtHLx6HrN/N0pwl+qVt2As1Dm3oFAZhq7rZL8f/6wnri0gtniAS6IYjrZdeQ1cX1HBfxJOuOSn2KNK5Ii27x/IjXeAxn7SWX4vHTm1Pxmh3DOG2385VfTy8lPIDmPc6iJ0zoyROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybzuViAel+V94rmxY8AtbE0/CvEXEyZjW7xf+zp5i9U=;
 b=tEz5Qcoa9ZDEZjCWzXqbTS8ygyxF09JyWcvP4PBABmnsjmJ/yX5PQiuyNSRNHeM0kgEXqPr912/abIgJFxmlbdjl4opbZ2CKpZiaMEZ6arAyizEliEIKqw5+WI2QL1Es+u2ffRsqpvfcCqUGUhb2Og8Y5EtbMgJyPFUwKILIoHXYLtfqkbOnhPxablic5zZtm0pgGtBO15eyJ7xoc3ohpeIq7Xfnoql7k5yO7vIBVvw7R7B+Ysmr3CUnXsnNprySXarw0EmE9EsnHsCs1lfDwM0dHCdurCJBjTdl4J0BcGRXeNmjJ8bJROGFqBHEs0dm0+DFI48axrmwNtE8NamtiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybzuViAel+V94rmxY8AtbE0/CvEXEyZjW7xf+zp5i9U=;
 b=V13l9nOsx1fYMLxmzhIv3M6D2rffEMRGVC1YFQzOuFN/6teiCuN5OwdbSMSdJZrukP9K8UND8RepZX+4ogdPsswsACalTqIAAb7ncprNm7nuOkZHbDxUOHirQSqU28DmWOePWoLBueY3PLBu+lC4VpetoY4bUEFldieKapv0Z3cubofk1M+AhUkJnEBmawvLEojU7wXN16mOlEq/WSzR6n/OofojiVUvdlqBpnmsABePGyFtx1axXBTbEe5leuHhPdXSCyb9vkzyT4JKVOSyljxkEwoS+ul2Li7FA7cEjdw57KY6GdvCOuPJCPbjwXSmF7SQtGYm6rtsOweoUWN8Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:12:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:12:39 +0000
Message-ID: <2a4c0db9-d330-441f-bce1-937401657bfe@nvidia.com>
Date: Sun, 13 Jul 2025 14:12:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] ethtool: rss: support setting flow hashing
 fields
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-11-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bae0ed8-626d-456b-3229-08ddc1fe2dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxzSlovWm5EU2hLOW9la0ZhQzRwOW1HUktQcXA4aTY1cUkxUE5wWXZtUGtR?=
 =?utf-8?B?c3NOMEppQ1FZYUtrZUMzN1h5Q1llS29pOGkzTHUzZkd4T2Zkd0VNRUNxYnN6?=
 =?utf-8?B?V2ltcHhXYUZyMEI2NWpRWFdBNkFCOGFFMHF5aWlKMzRGanBNelQ1ZFQxSkp2?=
 =?utf-8?B?SW55WHJtc3REc0t4M1BkQndUVUtydlE1WlBuVXFWNjF6cGhVM3AzTUVSQTVF?=
 =?utf-8?B?Zm1QMG03cWVvaDEyVG1zUEV6d2xMRXNvQmNEY1BEU3ZUOE9qSGV6ZmhDc1Nn?=
 =?utf-8?B?MFdOQ29pV2ExcnJ2YjVUd1l0UXA1dEphKzY0YlB2UkMxRTJZakUvVkh5MVlo?=
 =?utf-8?B?OVdLMVZreERIdzY0SVlsVVZaamVHVEkzekFkVjVsTi9rYnlPSDRqaGdJclE0?=
 =?utf-8?B?dVVlZFRyZVBLK3dVQmQxWEpjdW4zL1ZIYkJJcW5ra2VEY2YwZVoyOXJ1Kzh6?=
 =?utf-8?B?RVBFRFVJeDNzUm5GVnB4SWp2UGxxZGdTanhFeE15cTdwclFWWERRT3NaaGxr?=
 =?utf-8?B?RHdRZkJ1eFJFT2RDUmVyeVNJakIxeFhtTlJFTzhSam1qYnpkaWM4MWNsWGk0?=
 =?utf-8?B?UHNXd093b0FtQnUyR3k5bDRQRVZ1R0FOYjB5U0R2OC9HQldoTVFWUlRiTEhT?=
 =?utf-8?B?K3gvMFFZQkY1V1NSYmtJS0JrR3FTTkhDbktiKzdqdFVNSWpOS2hsK0JGS3l3?=
 =?utf-8?B?Y0FvOTZ2KzlLY28ybUM4bXZ4UG5veUs1eEg0Wm01bThKbit2ZkZuUnhPMGRm?=
 =?utf-8?B?bUNBdys2b2FndHViUU9NeXNZNFRjcHlnQXFhSUxJRFZXaDFPd3V2ZVE2U1oy?=
 =?utf-8?B?eHN2UG1TZ0piaTRTc2ZRV2hzRHlKOHgySTU4MnJtdlJxbUE4U05UbllyWGdY?=
 =?utf-8?B?dkNRT0JqcGdwOENCVVg0ZC9RZ0RXcXA2ay9LSjZFbzRiRkVrYVJRQ1YyeWpr?=
 =?utf-8?B?dXRrNElTL29vb25YallwUit6YW5uNVNBRCt5NUJUTHNqZTZCWVJ1K3FaMS91?=
 =?utf-8?B?eTVEWVkrK3MrazNuaU9iRmhYSTdJVFN4ZFJudS9Vc3NkOVdqK3pXOWZtV0FF?=
 =?utf-8?B?d2ozSFQ1eDJtaDF3U2g5d2xiYkZiYWxUYnlNQkwvV0IyN1RTWlhzSVBEWHNK?=
 =?utf-8?B?TjhoYjV3SGs2czBjU1dYU1NQb2dVUWtYb3Y1ZW9HR0Q5eC8vT2dsalliRzFP?=
 =?utf-8?B?dTZmbVEyNVpyUUlUODF2bk5tVTF0TmZrb0hEd1FmazVHdkR1YXBYVnhRRTJL?=
 =?utf-8?B?NnNleWpqTWpNYlNUczJsdW9MQnI1ZHBhcWhwbVBheHRMY24yK0MvSG56S3hh?=
 =?utf-8?B?VWlSd1V0c2JzbFRKeERaeWRkUUhERVlkZDJlUVRnVTF1S2UrY2hQTHFmWjZ2?=
 =?utf-8?B?NnVVNHBWN0dqbjJOeFkyNGNsN1RiZVJ5K3ZIaTdBU1lOTENSajNBRU9FbFQ3?=
 =?utf-8?B?VWEvYUJUc2FSTkFtTVVaRVEwUGZzNmF0a1o1WXh2cjFxb0x4NnA4cWJPNzlY?=
 =?utf-8?B?dVFZMnRpVWV3SzcvMWhvVXlpQmtkQWJnZmRLNFUrbFVIb0h3cjE5YXZ5MmR5?=
 =?utf-8?B?bWpidHRHRUEyRE9KUmk4VG9QWG5NNC9vZmtoUmxOQU9lR3FaWW91NGllREd0?=
 =?utf-8?B?MFFGZERxcjdPSkhaSGxSTjJROFRuWkRpdWFmVUtxR3JNSUJhaDI4aTd4cnVE?=
 =?utf-8?B?eWYweU5Da2QraE9ibEhSTjB3VVZtdURhUnJlMVN3VVRUUFE5S0x5ZnQxSVVj?=
 =?utf-8?B?azI5MUcyZjI3c1FNOGtadGZoeHBkUXIwMlZiZjFsV2xqMlBlYUtjMEkwcklK?=
 =?utf-8?B?UHM1STMyaEk3Lyt3aGxxR1FwYVZTM3pMOXlGZWtmTmsvUElqcGRpWFRVUmdT?=
 =?utf-8?B?Y0JNUjhuQnd1SXNWNlUxdHlsR3k5OGJ5M1ZtVXpLV2hMTk5YZE1naDBpZk5u?=
 =?utf-8?Q?uc6piwzpsxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVJ1WEFObWVSMmVnVGF0cGxtRjA4NWNHNy9lRDBXZ3g4NTMwTkFydkFpQzhi?=
 =?utf-8?B?dXB0M0kyVUpoRkVicmlRRThFR0dLbEVXL0hNMkQ3OVVWZjMxMkh1VHVaTEVw?=
 =?utf-8?B?ZUx5Qy82cysxWFhMdFJiZ1NpdGtTc0hOWFFBSVVQVEhSU0xpVzZSVUk5SkZn?=
 =?utf-8?B?M0FRWDVjNUlYQmpCWlFZaDdZZURMVkJ5RnNJdHJncEpZWHpEM3dVdHQ0K0FK?=
 =?utf-8?B?ZE9lY2Y1V0ZwS251UDhIa2o0ZEtYNUZ4KzMxUGo3LzNMNm5CUTdpaktBWlYx?=
 =?utf-8?B?RmorSWlXcTR0eXM2ckxIR0ZEWEcwcThENUFZMjFjTDhhYkYxUjhKeDRNcG5U?=
 =?utf-8?B?WktsQzlrcnlVYThEZDRxOERSUGRCOVNBV2g5ZWN4a2NwRDZOR2RYeCtnSmdG?=
 =?utf-8?B?YUdQVlRjU0grY2kvM2dXc2NnY1Izd21jMDM2MXJoREJmNk9GZmgrTE1aTGI4?=
 =?utf-8?B?QllLV0ZiWERmcE9RMUY4bURmcDFhbDJJdk5DRjU0OVZqZnBDOXJ3SGNvWGlO?=
 =?utf-8?B?S0JUZG5MNWtIR2dpVDNLcENGTVVHcDl1a1JhQlZWS0pLcFhrcXd0ZWpjUjI3?=
 =?utf-8?B?YVhVNnRiTCtudVBocm9ySXJzTTZISXJWTDZFM2dweGtVbHRBUVM2eGgxc0Fi?=
 =?utf-8?B?eFRJYlZnQmNSY3h3QXpjdWFRZWtrZ3g1ZXpKRG5NVC9yb3NXZkMzRk84bklR?=
 =?utf-8?B?dUI5UlNGalhBYjdaLzh4ZWh1eG1Ia3BOSXA1UHY3VVdLbmh3M1RET1hJNjZu?=
 =?utf-8?B?cnR4THhZcVJlWE1HV3ZiT1gxMWZSU1pZeisrU2dvTmVvYjBkN3lPL21EaUpm?=
 =?utf-8?B?bVArV2xKZjAvcFJuU0JaU2ZuaG9LSHFEcEVJZzlhelpzWXpJWTJLNjVTbUdR?=
 =?utf-8?B?VGI1Y2tZWHRtUDJmKzBGTlR3TlFLOUNoWGtDUzBmZ3cxS3dkUjIwYm5Ed1JJ?=
 =?utf-8?B?RmQwdjJoZWlydFRQcFNUa0dtaHE0YWFUejdXTW5QZTRINzg0S2lJajhBWmZx?=
 =?utf-8?B?d1JxckY3c2VrQ0xXaHZFdGNjMlNkN1BnTDA0RldESDRwYnN0eUVjVVE3U1Zh?=
 =?utf-8?B?OWxvdlJseXBhdVdQNGhGNUlWeHBvRUQ4ZHY4SnUwcnd4ZUR0TG9rUU5DdCt4?=
 =?utf-8?B?ZzdWNEorVEF3Q3lLZENVYjFEQmlOcnU3eUVpNENEOHN1Y204M1VNbWlSa2ln?=
 =?utf-8?B?VW1Zb2d6dGpJL3JMMlU4akRKOHVLWFV4aE9Tak1tVVRma0xSK0p6ODdoQmtQ?=
 =?utf-8?B?MGR5NDdBaElsK1ZMWllsWVdzcjRDZUMxbWdZOVgzYU9oVjBDN1dOVlNITUZu?=
 =?utf-8?B?KzZyMlY5ak5KT2VKc1diK1BUdUllc2UxR2JaL3ZUbys5WThuREFMdGp3OHlX?=
 =?utf-8?B?dlZwWVNJMzdHQ3YvNmpaU3R4TEJwYWpMN3luN2greHE2eE81MXZBL2JXcTlS?=
 =?utf-8?B?QVBsSkFjVnlnQzVobDkrVW13VHgwUDF2M01laFptbUhNK2VhNGhnR3YyaW00?=
 =?utf-8?B?K2FQTXNpck1kcUZSZ0lUbk9QSXVTUThISzd3eXpXRERKYjdUTDI2SGFZK2hD?=
 =?utf-8?B?dmFheW9PS2VVRWVrWkJ5UEkxNS9XbDB4cVhlNnkxM2c3QnhiZS9lUTJES3Na?=
 =?utf-8?B?Z2NTSFVQM3BJV2dkOUVGTGxrL2Q2eGlXMHNPSVp5Q1ZxQ21ubWE0VzFXZk1q?=
 =?utf-8?B?eHl6c0tIZkRBZmFldzdNamZtREVFYmVCNkpBb0cyVXhSRmJxdG9XejNyYXIw?=
 =?utf-8?B?enBwV2QxUDZvbHI2SGlxZWtvVDR3bW1Yb3VFOGJJR3VaNWw2aFFLMncyaFRK?=
 =?utf-8?B?TXRBZVJCL3cvcUlDNnJybGp5UkFnM2VvTXFzNjYxdlR2U2pjUitCa2FpS2l6?=
 =?utf-8?B?WFVDMk5HNG03MmJ2Q3p3WjZ5cGFlSXRmKzlwVXExNXBRaUtKU0tMQ3M3Y1N5?=
 =?utf-8?B?Uy9tb1B1Q3ozQUFXQzdETGZpbG1IOFM2MU0vUUtVd0pzVzErL1BYQ084SU5F?=
 =?utf-8?B?YlpFMHE4SmZ5bDNlcWw2OWR0TDU5aHF6cURPU3JqbXhrMGtMVXBBdERZZjR0?=
 =?utf-8?B?YmY3WWpzWDlFb1RqbUQ5UmxZeW0raDZjeG1ackNUZk96bGtjc1lWZXdHcFNy?=
 =?utf-8?Q?JKX3NduIt4nec1lC3QIyEcIYR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bae0ed8-626d-456b-3229-08ddc1fe2dd0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:12:39.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imphudVA9yoXg9TaQA1UEy302npZRVGW8t+Idfu/qlmkZ/9ILx7tYlJaI50MFBlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 11/07/2025 4:53, Jakub Kicinski wrote:
> Add support for ETHTOOL_SRXFH (setting hashing fields) in RSS_SET.
> 
> The tricky part is dealing with symmetric hashing, user can change
> the hashing fields and symmetric hash in one request. Since fields
> and hash function config are separate driver callback changes to
> the two are not atomic. Keep things simple and validate the settings
> against both pre- and post- change ones. Meaning that we will reject
> the config request if user tries to correct the flow fields and set
> input_xfrm in one request, or disables input_xfrm and makes flow
> fields non-symmetric.

How is it different than what we have in ioctl?

> 
> We can adjust it later if there's a real need. Starting simple feels
> right, and potentially partially applying the settings isn't nice,
> either.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  static void
>  rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
>  		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
> @@ -673,11 +767,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  	struct rss_req_info *request = RSS_REQINFO(req_info);
>  	struct ethtool_rxfh_context *ctx = NULL;
>  	struct net_device *dev = req_info->dev;
> +	bool mod = false, fields_mod = false;

Why not use mod?

>  	struct ethtool_rxfh_param rxfh = {};
>  	struct nlattr **tb = info->attrs;
>  	struct rss_reply_data data = {};
>  	const struct ethtool_ops *ops;
> -	bool mod = false;
>  	int ret;
>  
>  	ops = dev->ethtool_ops;
> @@ -708,14 +802,10 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
>  	/* xfrm_input is NO_CHANGE AKA 0xff if per-context not supported */
>  	if (!request->rss_context || ops->rxfh_per_ctx_key)
> -		xfrm_sym = !!rxfh.input_xfrm;
> +		xfrm_sym = rxfh.input_xfrm || data.input_xfrm;
>  	if (rxfh.input_xfrm == data.input_xfrm)
>  		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
>  
> -	ret = rss_check_rxfh_fields_sym(dev, info, &data, xfrm_sym);
> -	if (ret)
> -		goto exit_clean_data;
> -
>  	mutex_lock(&dev->ethtool->rss_lock);
>  	if (request->rss_context) {
>  		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
> @@ -725,6 +815,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  		}
>  	}
>  
> +	ret = ethnl_set_rss_fields(dev, info, request->rss_context,
> +				   &data, xfrm_sym, &fields_mod);
> +	if (ret)
> +		goto exit_unlock;
> +
>  	if (!mod)
>  		ret = 0; /* nothing to tell the driver */
>  	else if (!rxfh.rss_context)
> @@ -748,7 +843,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  exit_clean_data:
>  	rss_cleanup_data(&data.base);
>  
> -	return ret ?: mod;
> +	return ret ?: mod || fields_mod;
>  }

