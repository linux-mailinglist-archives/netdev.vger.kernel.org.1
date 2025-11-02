Return-Path: <netdev+bounces-234897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA11C28F64
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1473B1126
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EC12CDBE;
	Sun,  2 Nov 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3b+A++T"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181711DDDD
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762088980; cv=fail; b=nFvgWeugd9YPZV1gd47sTk/pMTgn8AOmmfwlgT73CgN5v9/uKFvsjeTXIRfVcHOnIia4MqalSIsnK4z38cvzbvKNT60cfKQzsOVFNqVAWS6/QT4KgItouXd12QAmoUHUIRmIa2GSrMIjUAIZiwCm/+G2WP8lUcPPdZ1XAL9NZYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762088980; c=relaxed/simple;
	bh=JxTg4L2CsHOlGz67yD3e7JHa7TSJE2avkIhWinfo7hY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RLYQn6EFVV63NnhokaxiW7jprGuwvFmOYhpsxMJ8iW8bkTD143Co130ldePDzkAzGG6bHchEsuUdgCI/3hatwiKo7Q8SXvKER6y97uddpMfIgd+6ppVX9bjELRjWbf8j0QTTqD6bYblmd/xj6POKcWSCYnBCCaNJAOI4FtgSZZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3b+A++T; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utgbnZ61SIw7gdI/mP4yAPwR38lliCmqtCzK83gHvoGZA6EiiPchXZM0C2phCggi+U3hQ6t32csqX0fiq3viPRpjxxRE4jogpFebRyMaS29TB3i2Z1qAdV5rffpfUdW5Qt1+gNha316bE8VL5sGR6EUhMKRCyfaRow6iVhCyv8njaodgGZLiRmKepy0gF2odZfsHrV7vWjfa62rmCbyGlxBfVd03Lyy8/FxQ4aeGLytI1B8qLaIkPuc0g3S3GL7wkNepDqjOmHCWCTV80szcqI6FF8bB1zsz6OShvCPeUXaTy68u1p+FxWty5CNV/HOXzGL5+7FZJh/rY8rnUaUaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3PZLRYitLt+AN2G5LuzM5h/NNLr230ipEpFcaFAkrg=;
 b=euk8wt/MyknrzijfY8LDUpbcVozWewb0q3pSuzqM4Q7vvjcI9CGJokr73q5jKzeOel5gKbYqxxApLQFO/OlvjFpXVKd6tcfDBoRjGaKqo4G6v2Jo7vnNlPKcdKriq8z5aWSj/NHp+xZgrMZu7jQ1cS7xy05HSax24AmxqEpxcwC+dKXIXffQue+EZovMmGhzfnobusdPlo+kSUt215c7wKNnF9r8RMMhP4QqpJvebhygZm3Nbk0Sd2lF59BtB/aw90TOElbsAy8tje/JBASC1zw9QoV74T97DuOJcfEjwLzUBBfB3Jh2F661EcsFbE5ERCDzjIfqnsIjSmkJ7vp+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3PZLRYitLt+AN2G5LuzM5h/NNLr230ipEpFcaFAkrg=;
 b=n3b+A++T4073vAePSbO4zbmSCamLyfHdMIpIWZRKswEgPEC0bA/ofd8BtYDegN6UNVlQo4OAMF/WzMWErcdIrJaXdFTikdiYpWLpUE2yTRMhKCVn6eazTo52d1Z6u8kaLy6cGWs7JenF86bM6eODhIj8AP014F1TL3AAZbh2TO+VoGCcO7qHpJ/3PoBWkdosRfGVCTxydMleXzjMQJxzIWkMCxHTJIjsOqMm+/H5lfjm0Kwvc/p08jWdsCEXDapfWWmdgPUUjOf2oqA1vw/0EpoXyYOgnYoSGZI2gv4ivowXqDb5Alh1Ot73QseMbsxDU0dN1jb+0B2Tbgkp2WNkiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Sun, 2 Nov
 2025 13:09:34 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9275.015; Sun, 2 Nov 2025
 13:09:33 +0000
Message-ID: <742b1cd3-5935-44dd-bc3d-5744b56aa861@nvidia.com>
Date: Sun, 2 Nov 2025 15:09:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Matthew W Carlis <mattc@purestorage.com>
Cc: adailey@purestorage.com, ashishk@purestorage.com, kuba@kernel.org,
 mbloch@nvidia.com, msaggi@purestorage.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, tariqt@nvidia.com
References: <8a7ecc3f-32c8-42fb-b814-9bb12d53e29b@nvidia.com>
 <20251030200942.38659-1-mattc@purestorage.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251030200942.38659-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: e61884cc-506f-4899-969e-08de1a1110fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0JqMXZvY2tLUHV3NFNMcnpadE5RYkRZb3dmT25BU3pOMGV3WmJKWW93WE1j?=
 =?utf-8?B?cWdNN2FjWTdFblpDTEZWbEtId1BSU1lwaHlEbWlScXRXeWxWYkRwVDhqeitM?=
 =?utf-8?B?VlZUaElaL0tVcDk4N1NIMXVQSDQwU25oemZnYnlZS0RmaTdKL05RVzdBZFA2?=
 =?utf-8?B?bU44WjdsZjlFN2NadDhLSHF6MzVvbVVhQWZ1RVZjditRRnRmVGJtNmpyT0tq?=
 =?utf-8?B?ZVA5OVc4dGhQS09zclhIMTNWWUk3QTdycHd2ZE1DV2U5YjVTYUZSSVBZZ1pY?=
 =?utf-8?B?R0tzVk9DQjlrcHdTSXkreVE2a2NLZHFLRHovcUkyUzB1ZGpObWRQRENwYmU0?=
 =?utf-8?B?blExVHVhLzQyWGg3dmc2cmg5K0s3cGV1bEFXdWRwUy9Pb1hnUXM3dTlqZllZ?=
 =?utf-8?B?bFhxQS9zYURSREZtb2IxYTFBUXU1SFpQVktBaU92MlRhWS9XbTMycHlQbEcx?=
 =?utf-8?B?QXM2SGFQTVJ0Q25sa015TFJHUmtuUVRBc2dJczFxRTZ4cjhzQ3JsQjlWWEdD?=
 =?utf-8?B?WlNZeW9iTGVZTFNzcmIxOEt5QUdHOGhNbEdVM0Vsak5aVHRlSWt5ald1cmZo?=
 =?utf-8?B?Q3dRcXFkZnVZZCtSNHZndFVtcTUzWGM5VXNwcFV5N1ZpdG01a0d1dmovTGJP?=
 =?utf-8?B?K0JSWGgySmxNVVBFYTE5diswektZVVFUNFg1N1ByOUZseDUxbVhmdUpsSVBP?=
 =?utf-8?B?UXBGeTlySUhYUkFHUUtHWGhlUHlLSmdIVkxHbk1sREhBRlRFdWpHWDhOeHZo?=
 =?utf-8?B?RVk5R1NvcDlHQUgycjVlK3o4S1o0U1JWQkxFemJkWHd6WS96dGd2QVl6L2ZN?=
 =?utf-8?B?WUNkM00rS0RzMEw2MVFneTZlNmpSb1hCZUkxU1ZmUyt1WEY0YytQZE1wMkx3?=
 =?utf-8?B?QlNncEppdktxRFc3MVlRYXhuVS9qazd0dHhHSjZpZmhZZ3BsRk02MGhBTUlE?=
 =?utf-8?B?alFkTW9iMHREMlRZTS9ZNisvWTRzMUNlUlNzb2JIQkVuc1JIaUdyeDY5WEt4?=
 =?utf-8?B?OERzdC9LT1NESDNVTlEyRlRBaEVkUVBNRTg0WWhRbzlLM0dPUGNtMWxvRVNB?=
 =?utf-8?B?dTJrZ0lmamM4a0J0TGJMMVpaU0xIcndDSDUvTTFLYmJZTVhNRHhIWFczRlF1?=
 =?utf-8?B?RVdWU3hHaDJiTnppc1pVT0NaMnQ0NHAvakEzY1dIeGJhdW13MGl0UXNPMUlr?=
 =?utf-8?B?U2ZVOU1sNG5QYk4wT1o2aEFQMjJrR0RvUjY4OVVLT0pVeTNkaHJMWUozN1Z2?=
 =?utf-8?B?NkVZZTNQSWRxTnJhSmVJVHhPdE5sVkVrY1gxbjArbjF5bTlBbkwwODFmaVcy?=
 =?utf-8?B?M1VBbnZ3Y0ZHYUdXS1huSklXTlZxRzhoU2Y1NUFiSkJKQXFxTXRXQjNaMTlu?=
 =?utf-8?B?QVM4MnBXZmtMK1BEVU8xQklQOGlVRlY0UzUvNHRBKzhCQWdMQW1LZHlqaUd2?=
 =?utf-8?B?YW94VEFNd1JzODZ0ZUM1WGhlY2NhY29Xd3YwU0h2bk5QaHh5THBNVTBrdnEv?=
 =?utf-8?B?YUpkdUV1SWlSaVlyTUJUdFRTTzBYd2dYaUYrQkNVOVhTR05mQnh3MXhnVmxo?=
 =?utf-8?B?TEFKWkhDV0FacmliaFBlMVB6WE5PaERRTG84Ui8yWXlLMXBsc2p4VHZ5bFFC?=
 =?utf-8?B?c01xdmMyVC9xNlJYZjl6ejVwVEVJYlhrZWZMd1dwdTNKYm1kVXRMc3dRREZD?=
 =?utf-8?B?a2VUbGh2R0Fza2tmNGExY3c1czZsb2FYenU4Nm9FbUtHUmtlQUxSSGY1VVFZ?=
 =?utf-8?B?cFZQQXhYaU9xdWpZRTc2K3U3RlpSVXRLRGQ4RWpaQ2I2OUhGdXBCSjhhOXZy?=
 =?utf-8?B?S0VrUkhaakt2bFZlNzZ1TlhxOTdERHB5cmRyS0MzQ1dkcEpSTUNxMmMvakhn?=
 =?utf-8?B?ek5BbXpSMXg5cFc3SmdCYUU4UWJPSUpPcEE2aC92dERnVEd0NDNsUEgzcjNU?=
 =?utf-8?Q?EjNGYgvfjH8IEVEN5KDy9o7gICXkBQnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1U1SFd5S3Y2SSs0SlRPSVdvcDF0ZDZ0NXdlWHBYck5RZDUybTQ0ZnVESEZ3?=
 =?utf-8?B?a1gvQW9KNlVHcVp0MHlCN2M2UHY2RlBLT3c2SUVUaGh3MUZMQ2hEVDdtcVlk?=
 =?utf-8?B?RUxrSGRURDFhRzhkMXlxemZUdjcwSXFTUDYwb1llc0FLQ2pBcTVETHlBUU04?=
 =?utf-8?B?QkhoNkJaNFVQZ2tHU3dkekNMRGp2eVVwdnArd080VXhXeGdiaHZHNGxYRkdp?=
 =?utf-8?B?MVQ2T3NwL3Z4NS95WGFRbkJIZ0ttK1pidjVLcGtzZWdXeEs3Zkw5dy80K2dk?=
 =?utf-8?B?M0NOSzMvL1VhMjdZaSs1S3hvTFFlVVhpZzJhcWdtTm9YeXVhQ201NHhQM2E4?=
 =?utf-8?B?cmFQQTMvWjJJa0VUL0Q5OUZvTUdPWnA5TzhldmR5eWlkYmJCTUlvajdSbkVy?=
 =?utf-8?B?Z3RPbGljVE1XYkdFSDZzNHlZeHRkVXVNYXBvVjRwd1gwdm1SaE82Y2w3dnVG?=
 =?utf-8?B?cVJSVnljK0VWRXFTWmxxeVIwTW5xSUdEYWsySENCOE1HeUo4TTJ2ZnlKODNn?=
 =?utf-8?B?eUJwSmNPRWhCRkQ2dVhQNlBubGlXU1pZdVNKYUc0dy9ucytIQlFSS2xCRGNT?=
 =?utf-8?B?N2tyMnQ2cXlteDlVcVFsV1pIeXdHR3c2RGFpdGh0T0V4aVVXVUZxNThCWCsv?=
 =?utf-8?B?bkEya0dSNm9MR0F1TEI2NTZEbXk4T0dsTU5xZWhRN1pOcnFLRGZldVBlYTNj?=
 =?utf-8?B?RXh5SzdlVjZpSFZ0NXZ3Y0krV0owOWNKd0I4MmsrZFhLSlFQckJUaHUrREI2?=
 =?utf-8?B?TzdQbzFWeHI1NjF3aXlCbGdnRlhSWkJybkZNWmlKM3J1UktHUkxGK1VPUjRS?=
 =?utf-8?B?QWxJSmJKTXFCOEVmTTRBdkwvb0dkMVhuSXJJaisrdmtFZjhOZkpkQ1Z5MmhO?=
 =?utf-8?B?RDhTSFZNMHpVNUtDT01JaHJGZHVWOVNyYjVwN2ozQmV4eEt1RWJpT2RTOFNp?=
 =?utf-8?B?aGhIbVFuOHJuMUJJekI2UmtmSHdLYTM5V2NENkxqakJ0bHl2amxtUWxTbk95?=
 =?utf-8?B?c1dEOWkwSy9lZ2hNd0pUWDczOEJBZVJ3ZDhNaUxGalIrY3RCVlBWdTVWNm9n?=
 =?utf-8?B?UTJIM0JyZkw0RnlZaWtjRjljN1o0NXovTVBhK0djTXVsaEQ3L29PajFHV0sr?=
 =?utf-8?B?emZ4Wk1hWndSdng1MVRhNUtPSGx5VzBjaC9vTzBNQUVXOCtQYXFEcERiQUVF?=
 =?utf-8?B?WWU5M1NFY3Z4WmsvK29xSldaMDFvT2JwWHJ4a2VvZkd6TDJ6ZDRYWGxJSlV2?=
 =?utf-8?B?Yjd1bEpSZ1FVYjZWQjhibHpSd1JtdTRnSFFMRUplTEVlajZ6Q2x1Rm1wOHZQ?=
 =?utf-8?B?YXZQWU1POUd3eTJCWjA5T2JvSjVQbHoyZ2s0UEN0QVVuL0hQK2N0UmdMTjAw?=
 =?utf-8?B?dGw4UlEwSmRha2VEWm5nWTVCN0pzL1VMYThRNlJkYXNtS0dURUE4SmhpaVZu?=
 =?utf-8?B?bjJ4MVFnR1pjeDJqelZrZWNqQ2FSQ292Y0pvb3pUZ2dpeXN3dFJBaEgweGFE?=
 =?utf-8?B?bjg5cldJNnRKR2psYXB2bE9ycGtCM0RMRDArK0h4a3JUWnZOZW9FWE55Z3Rh?=
 =?utf-8?B?TWprd0d5aHVCcmtXSVdWV2IvVHMrZ0FiQlVvUXhwckVvY0hNUUpaMmNRdUk3?=
 =?utf-8?B?WWcyU2h1WGIxdnFPaWVuSmQ0RGFyVDRXUHdJS0JYUWE5bnVZazV4Q2J2YTVJ?=
 =?utf-8?B?QTVjYXlXaWNuL21LcEU2MThvSk9ISGFjeFZlclpqVEhYSm4vRE0ya2xkaE12?=
 =?utf-8?B?a3pKUG5VcXZkYjNyV1FkZW1ZZ01neks3cVhqd0VlU1doQU5iMjNXSVllRUx0?=
 =?utf-8?B?MlU0MGxGWTJKTllzRGpLc2E4YWFOOWhzemlidGlBSHBLOFowbHEyNTJQVEE4?=
 =?utf-8?B?TTV0U2dsUFVmcFNyZTkrNkZCY3JYN2lmcU1USmVGaG5haDVkb1poUENjVWU1?=
 =?utf-8?B?anJCQ1IvKzkxaTg1RVFMRUlOTUtUaFVHaCtQSjllOVdRckt6NzhVbjZSa2Ev?=
 =?utf-8?B?Q2NjMTB0aVdOekdDY1Fpc0paRldPNVkvZHJpcGhzSG4yZWp6cVNTU3IxaC91?=
 =?utf-8?B?Z21PVU56YXVFTDU2QnBCMXlrK1V0clQyMFpsVVRvdzdkZFl2N1NUNzVjc0dv?=
 =?utf-8?Q?h1pxV8h58X3pa1FjJLHgAF0PL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61884cc-506f-4899-969e-08de1a1110fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 13:09:33.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 155ocmrKLeQc05td7SQ4wH0piJO7atbv2Slejxy7x2vp1s0r+qVqi+seEmKRHx4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794

On 30/10/2025 22:09, Matthew W Carlis wrote:
> On Thu, 30 Oct 2025 16:48:54, Gal Pressman wrote:
>> I asked before, maybe these automatic tools that keep querying the
>> module continue to do so because of the success return code, and that
>> will be resolved soon?
> 
> I went and ran the command on a port with no module and agree that it does
> return zero. 
> 
> It doesn't solve the problem for me... Part of the reason automation will
> periodically run the command is for inventory purposes. We want to roughly
> know when a module was installed or removed. Then, as far as I can tell the
> only way to know if a module is installed is by running this command which
> has the consequence of generating log spam when there is not a module installed.
> 
>> Changing the log level makes things more difficult, as most production
>> servers will not enable the debug print, and the logs would be harder to
>> analyze.
> 
> I care less about the logging level... I suspect it should be info or dbg, but
> we just don't want log lines generated when we're trying to figure out if some
> module is installed.

I have an idea on how to make the situation better, will hopefully have
something soon.

