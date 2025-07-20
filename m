Return-Path: <netdev+bounces-208424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41378B0B561
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928A03B6F92
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DA1EB5DD;
	Sun, 20 Jul 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYV5icTL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A9273FD
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009977; cv=fail; b=Lw5F1aWTpa9huMvTXJ7Cs3SQnf+7ZVFb/i3gbzIdCyu3T8uMlgmAlMTi787pnIRR5lXHmaTH/eaxVybJrGhEAHvBBvKeaa1Sph2cBGrz+XeXBaBhbLE0mLmouSuKvPwxKs1N/MxVb6N2J5iH4PiZEt89fA19PVYwezp9FNZc4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009977; c=relaxed/simple;
	bh=z9upzw7KwDTXJsr65xTotpac1SCWQ+ZGC6/X+e3OSOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pIb+xZnT6oIh0U+HxWpWMoXg4W7XKtvp9oFGdNyoXCzb3qeCypo0u0xRmSkpdocaRfMKXY/XyQ7oeL1qh8WXDCbGTyUypLHj06yA0b/xlBGZVoRXmpIRntB6/em71xNUqtc+kROHlYsc7vb/5tmxex+ebI5OlnQrI/fbVWnTflU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYV5icTL; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCnMT0t1JAKGhGSb5IfSW3l1vktf145RIZqHYfmWiOsFeLj+7H1yamUnwERVTxV9qqWPJfaMhWGtpaT56wIoygxLQzYBUML+3yzqke0h1inXaMD9GzVCcmo/hpSqvy3fVoODoOcmbs96x+2YDG8HXJOgn8yCkrCpaljlEnfZ01iouNT9QeiLjkrgceKJ169Kqp4vmgIv/xJwx2FPNNeFHmpAuHGTJQCakSVgo9MNNdHaDsc9/RabzjMWsqyjv3YFXzlr/4IYCedl5xSxjHjUXiOPKxdpJ21A3m1+P+yNOK76XTNdwLAFUIqTm9eSF17HH8w/FjL0iEMoEfcWoXeCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+OAIwakG2Dx1vhCrUsA8MvkboBdvIciZhvlmD3K6io=;
 b=H3RTr8T7lstIbo0aAH4O6DeeMeB+WaXOirQAxWpiRtiVFv0r0wn0B0oe65pLPeAga5qB5qRe1eNefnrksxitXmgaNG7GibhA6ZcQTufrrBp/vGNVzoQY4tymiGrnZ5W0OPuSEo3FHSDHqZPJ79mQ1sDTCWUckeDQetUjUmKwhr4lkwL1uZ592kim3h9qf7LvKV2T6g0kI9ooDKjHKs8tafcnEUbsruNR5CRB7FnKV4n9XomI4OfjBPB4aq62GvrmXGLFVXf+mRDsyJFf+Nb0/Fu/bhbEjuWohxWdV5FEE1ZPy8DNP6Hrhfcg0FYx9bnG5tNYR+Zw3lf7twLUiA3tTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+OAIwakG2Dx1vhCrUsA8MvkboBdvIciZhvlmD3K6io=;
 b=RYV5icTLvAEP8d0oL+Ozovt0vhmGBWhHygUvW9myk4IFW3/w6HLyV5boEh53oEhAK+ZejLFKmUvHplOni8iX8mx3BX1/J47jkewt9iUILBGp9eaVrG/Wso1Q1KNPoASIvqEknr6QyNFmKn3o0RIjZWKmS0+JoyP8THGmE3as4X2Ls9xMJ6aBv5704KJ2F0u9kE/kohp2IVCLA/xn5fZsZ39kOOHXF6UAobK+TMl1BXW5PSeg+UnGTD56IGEmLvcYAd8mel38SgGIIMA25vT+misXK21OGebcJZriK9/ZaKLuuoVmfABfk+TzZfdK1AhebgrmzNrrNXu2pWhkPWkKPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sun, 20 Jul
 2025 11:12:54 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:12:53 +0000
Message-ID: <f90b8a8b-cf03-41e4-8022-3df3f8542f2e@nvidia.com>
Date: Sun, 20 Jul 2025 14:12:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] ethtool: rss: factor out populating response
 from context
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
References: <20250717234343.2328602-1-kuba@kernel.org>
 <20250717234343.2328602-5-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250717234343.2328602-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cd30d7-d49a-40af-fe5a-08ddc77e5f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmxEazd3ZzVHUVBqUjV2bjVFY3JFZklKbk41VTEybHZheHo0MWlNc1U3L1A3?=
 =?utf-8?B?ZkVMVE9NVWx6cWhMcnhpKzhUOVcvVEtBYkNlS0VLVU9LanhldG9LdDdNelpQ?=
 =?utf-8?B?YnRlRmVqT0RibEhWbGJFZGlzQUc1RnZzYjJML3NoTnNFMmp6enBNMWxWcUhP?=
 =?utf-8?B?VVkyUjVVOWVGUFJqVzgzMHVpTTJ3Q1ZEelgwckFiWjlLbGt2WEZjRWVsZGxE?=
 =?utf-8?B?TDNWWVVRRCtPZUxoSXdnU0M2WjBmL1g4SFNkTFVnS3VWVHRBbFZZQjhIaWYv?=
 =?utf-8?B?TFBMVFpBQnUvN2N0Z3U2QVZvcXZpcGxQTC9sT242RVJPYUdCWW54d0JhMVYv?=
 =?utf-8?B?OE9tL2Z1WE9yWjdmOHBWMW56U3JDa3grUmNIdDV4Z0JsVUpzZnlpYU5MR1Ex?=
 =?utf-8?B?NWxUY3U0NmV0S2pFeUdodGt2VFIxbXRCNGZWOURiTXJkN1dpTWZRK1NsV0V6?=
 =?utf-8?B?YUFmUmUzZWNKTWpDRVovUWFCRDUrU3djQUlqYkIxbDFVNTVvejFybGErcjlK?=
 =?utf-8?B?S0VraS9UMW9iMU8wd1ZyMnZFQWgrMGV6K2QxbEcvUzJCbUdPdGxlRmFwanJv?=
 =?utf-8?B?MVU1dTByYnFscU5kNFF5VS9YLytUU2pablJxbG1xZGhKUGJHWnlXanZvNmRO?=
 =?utf-8?B?WWxLcjNoNEF0UktxRDYrQ2g1SUtCZWxtMGIyL2FXOHc0VnZ6Mml4L0NnOTYr?=
 =?utf-8?B?TmtkUnBhTThYQ0pvQ0g4TXpMT1NqZ2dqdTFQUmY4bHU0UUtwdWlnYVNOdG5r?=
 =?utf-8?B?dUJRUDMrMGxrUEk3eFNRNW9BdGczV0V3dDFMV0xqbytoY28zSit4RmRDWUtt?=
 =?utf-8?B?b203VFZ2bVY1Ukt5SU1oVkM5aGxpd1I0QXFPK0VGMFRGbGczaEFSTnRxZUs2?=
 =?utf-8?B?aERURWVidzd2M3dvcEpZRU8rWUVkbWpZdy8wSks5b2c1R3BnazJBOENjR3dQ?=
 =?utf-8?B?dFF0ZlZkbzZxZGhPaWFiRTJGbW52bGM1SHplWm85VnhJMWY3WmxLZFNhendk?=
 =?utf-8?B?MGJmRGZtUkZLd0dyWm0vZDFNS1JRV0R4ZEgzUTh2NHk0RmwyTWh4Q1VhWVVG?=
 =?utf-8?B?bEcwdDlBNE1DeThxODBwS1UvLy9vOTc5KzliZVY0K1VMNk1xaUU1WDRUMG5p?=
 =?utf-8?B?OE9paU5qcDdkQU1ST2c4a2IrNTNtOFlOR0lwdTZUUFpjYmZkOE1NaHg5TXBo?=
 =?utf-8?B?TDZwNGwxbG5CT0sxZjBvUFZ3YjlOeFlzR1lwUnphaEFMLzVFbjlLSGtTdnlD?=
 =?utf-8?B?a0VTemhsbFpPWDBDd0k5b3Awc2R2a0d5K1lUd2NkY3hIRFFRZUtycm1CREdY?=
 =?utf-8?B?Kyt4eFN3d3FxWXNtWmZRcWEvU3J3aHIrSStXZkUxaDRTVGl5QkF6UFc3UG1P?=
 =?utf-8?B?UDFuTTJseWNvRU91bE9DNnZpd1BzMXFQeng5ZUNaSnducUU4ZTlkTm5YdEN1?=
 =?utf-8?B?RkN4bGNsUGRhZFdpWU9DWEwxZXpFR3dBUFZaaU1aMGkxbThLSHY2WXhEeXFU?=
 =?utf-8?B?WFBCRmFyczJoNDBtYzd2RWg0Zm0ra0haVWNka1VPSUNSb25rUm1CK21BVWRw?=
 =?utf-8?B?d2tuOGpCcFd0T0MvTzRsek9Gd3o0M05PR1BlLzVSSzl0VlZBODFsc01XbVJ1?=
 =?utf-8?B?SWd3MklTSEQ3dlBKSjF5V1ZsaHhjRzJlZ0xJeVYrcnZaRUFVWGJzMDgxN1B3?=
 =?utf-8?B?ajlhV01hcC8yTzE2OVRMNXIyYkQ5Y2RtdUlsRjJ2Rkl5KzgzSEhoRXZ6Y1BN?=
 =?utf-8?B?a0pZSVVVNzMveWdXcTY0SmorWFFGN21DTS81QWVVb1pQKzN6b2FKR2FBb2JH?=
 =?utf-8?B?bWlEd21NZGpmVnorYnBhL3V5ckorK28rM3o4cEVtSGh3Wk8ycThxOGttdDNS?=
 =?utf-8?B?ZldyU240T1hKNDlGNFhDMHlZbUo3Rlk4akNUVmZHanhJVHB5eXdMMk9GRG9v?=
 =?utf-8?Q?5g9aVReprBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUUyWWxRZzR1Uk9Rb2JqRWowWHdzQmxTclVmMlQxVVR3dmd5RGppQ1dmb09w?=
 =?utf-8?B?ck9GcmZOZHZ0YWdIUzhoL3lqeEw4RnVoOUJvbFJwWjY1VmFRUG5FbU5VdEor?=
 =?utf-8?B?OC82MHp6azkrSDQ5MklTbHpETzNpeFh3czc0elgvQm1ERFBQRDZuR2hlRnh0?=
 =?utf-8?B?bnZuYmpkRHhOYWFiT0d0L3dyTGJmay9Ob1dXOFNLMVVtTk5HeC9hZ28ybmc5?=
 =?utf-8?B?MEF5bmYxQlZzU2pJN0JRQXpxMTJMdTFUcGMvV09OajI2UnFUdGpzNUlzaVQ5?=
 =?utf-8?B?YWR6RUYzRG82VHBYalZpQU9ybUFsNmJFNnNyQ3o3cFdzNk4zdzJPVXpPR29q?=
 =?utf-8?B?ZmJYYUwrU0E3Yk56Y1dnd0Z3dENhVGIzeUl0NmZ1dm5mb2hlU3kyb2hobXU1?=
 =?utf-8?B?NDA4SVNoMWsveEhlaU1DbGpTUGVBKzczVmJWL3JWSlVLWG9SWS82dmlBOEU4?=
 =?utf-8?B?VkVGQjkxaHdXOWcvZ2dGZWVNaStPMUxtRGN0bHBoaUwvdHY1RGJIUzBsdDBN?=
 =?utf-8?B?Snl1bHRuSFZ4dEc1SU1ZeUsrcmdVS251bCtTcjBvWk1DaVpnNHNzcVd4RlRT?=
 =?utf-8?B?SURsaWJhdUpkajNZZnNBNmJWa2ZHQ2Y3N2xtTXlQM3ZMak9kRFMvTjF2Vjc4?=
 =?utf-8?B?MFBaaWxiYktKVnRUanN6RE9IQm9LZ0t1bmJZK0ZESzROU05QQ0RSQSt5R2hO?=
 =?utf-8?B?Y1crSmp2ZnEzcW1SMUtmRjZ3NllXRnFPMGJjRGVRN3N5cExWNXZPdHQ3c1pE?=
 =?utf-8?B?TTZmVnE3US9iakdBbCs3NTJlUHhnc3hFcmJqekIvVFF3emtDb0pvNzZKVG5o?=
 =?utf-8?B?djBydXl1Wnh6RVQvT3BMcnRiOVhaOU5LdU5kK2t1bDZKa2tveTN5YnhCZit4?=
 =?utf-8?B?bFUzQXpNZGR5Z1AvY1RROFFJSi92dE8zUGNmckZ2dllTTjF0WHdNVU0vTDVJ?=
 =?utf-8?B?YU5LN1hIeHYwVGRLMEh6ZVUrUzF2WnI4VGRzOHpoWTBDS2pEb3owKytJMktB?=
 =?utf-8?B?T3RDMVhEMjdGNzFVUEk5d0k5VU9uZmdGc054bmdJWlFCVWhOQ3BrN2QxbUlZ?=
 =?utf-8?B?SGordTdzRU9aMHVYcnd0VExvQTVjSVRPblpmUDNZMkcvZVJxZGRvbjFHc2xP?=
 =?utf-8?B?ZjhiZEIvOWxPckNnampVSmcxSWlBSkJvNk5PZ2NlK2FFR2ZxZjhHcFBPVVpj?=
 =?utf-8?B?SDRzSWxZNWlKTjkzZG1qdmhVK2xOVTFDcnM1clUzbm5qSU9MWW81cUU2eEp2?=
 =?utf-8?B?U2JBUUZvSnJ5RTBhK1k2aDQ4a3lVOFo1WHM3MmllbTROZ3ljME1IeVB3SlpK?=
 =?utf-8?B?ZGlwL3AyT0lTbFVQeUU2cWpMWFM1cU9DUUpoWUk1L1dtOTVwNEthcHpNbEhU?=
 =?utf-8?B?M1JUV08vODJMRUMxbU9sTFpmbWZrakNCVHdpTEJqTHpXWkNKNFZxc252aHpm?=
 =?utf-8?B?WG5CVENqOXMzTUQydE91YzA4RCttbmZ4Z0h1VjJqemdhWFVjbnNrNWZ0aHd4?=
 =?utf-8?B?T04xUk1GMG9zbUoxNUdxMURxQUVBa1Q1VnFPc05vNVlZSGJrMFZVWk1ieXRi?=
 =?utf-8?B?RFVQS2tUM1BnTFZGMlpLVHhWbk1kS1FWSGJJYW9WLzhJVU9rYm5hTmxNUE00?=
 =?utf-8?B?RzRTTUw5N3MwNUszZXNvamRsbXBuWFEwNUQvdlN4MDNpMVJUZGdNZWhHUStq?=
 =?utf-8?B?V1J5TXloZEZlZ1pxcmQ5TXBOaUloVVlNcVg0a3l6eVpiMUJQaTZOM2prNmxI?=
 =?utf-8?B?YjI3Z1lrMVJuSXovQXM1eE91Ymk0VTV6S3BuUWV5V3RQb2QxdnVMc3FPbXhy?=
 =?utf-8?B?b3RiRFMra3pCeWN3ZDBRTzRKelNhOHhYM0p5U2FWT0dLeGZqR3RDdmJoeEtZ?=
 =?utf-8?B?NDdLNjh3Qkk0RVdzdk5TZVpvTlgyVmI0S3pmUSszOGFKaHB0dC81ejRUS1Vk?=
 =?utf-8?B?MU0wYldCL1VCMTM3YlI0TFRucTNpSlg3RlJUamo3K2VEd0VIbUNTWHc4UDZT?=
 =?utf-8?B?VE1OVUJMNUprQnVFRUtHVG9QcFo5dVZGa21vNFlpQ21tTTloRm9SZktGaGx6?=
 =?utf-8?B?YUNSNVdDd1g4Zi80YnpialVWWmk0SjNWaG1YMnVrcXFPZHFWdUViM0I1VDlD?=
 =?utf-8?Q?QEywGPVJTmM/wT6gRuLZvIE3M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd30d7-d49a-40af-fe5a-08ddc77e5f53
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:12:53.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwKYAP0t1HczkofXFIiviX8IZlR4mRcNLqKx/I9/REEQHVFgzn4Rd6oUprX4Tr6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On 18/07/2025 2:43, Jakub Kicinski wrote:
> Similarly to previous change, factor out populating the response.
> We will use this after the context was allocated to send a notification
> so this time factor out from the additional context handling, rather
> than context 0 handling (for request context didn't exist, for response
> it does).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

> ---
>  net/ethtool/rss.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index 07a9d89e1c6b..e5516e529b4a 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -179,6 +179,25 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
>  	return ret;
>  }
>  
> +static void
> +__rss_prepare_ctx(struct net_device *dev, struct rss_reply_data *data,
> +		  struct ethtool_rxfh_context *ctx)
> +{
> +	if (WARN_ON_ONCE(data->indir_size != ctx->indir_size ||
> +			 data->hkey_size != ctx->key_size))

I Wouldn't consider this part of "factoring out".

