Return-Path: <netdev+bounces-214716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50603B2B016
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361DF564157
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493472571C9;
	Mon, 18 Aug 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o/dSwhaK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49A2517AC
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541069; cv=fail; b=bczI/gWMMBPInpDg7BBiLmwv/LodKAJcdE2V1gdWiZCdTEUEu2tUoFbrHd9us8GJq9drMQUnPo/hRh6LZvhhT5wGBgtvKdlJyl4Bn6PaGBa43ZNmujc0UtG2cnyV1zKx598qa40F7eIIyhckq0dp73zPkkk9FQAkdBdz+HZVVNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541069; c=relaxed/simple;
	bh=A7dhX854hpljSbxhRWA1hw7uBTAoxgbsh6pGg9V0QiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PewVj9Mie2HVbFUmtQkVne8rfSEHkP9c8WSOWDZnzXgPvKluRenMwzQ0lPeCpyo6mmnP5Fh6fd2Qx2XGGVY7RErbmq03bIw5IrnszRuuNmaeJ+kMOtebLII603YTCko3VgoBjGibwdfe6QBugY/FupuvSG8DK0ya+K9kNuySsOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o/dSwhaK; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKxSJ2UEaRHJAKgLLHtPPrU30HHQImPwcGFaogj34lTKE3FGSaE8FrZh7AeLQ1ULRAOIlkUNGm0jzFAfISzdsV3tgl8o37EUg9O8bYwmMHYd/rlKjPIRDujNnk+l6JpcqH8k4+daGkwTsydZfKAv4EVvmII1Acdv/PeQHiKGxbm1ON6/yVr3phlyxpx0LSgx6qzGRGy3LxhHOjyUFMQWFc5SZ9Aok7/itTa61O3A1qaJEk8lrlHfyBd1JvdWUAvZN5lXiUgGRK0U3NoELMr9zvlBi1HqmAZHE1vSQK4XIRX+GP/sxF/qSlPdco1iBM6usdwA+wlRmFwF1Vx8Ftn52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk0n8Z/DrLHV8rDziPfxqPENtHYtfcC+oqb5dNVlyYU=;
 b=W0hOO+8IDZYzd4FgcEwZECrLoLgPUKYXxinFrX7cQ5qsfLFhvLJMbyalehM2NwQkzw+NPMI+2I/2p1GDmTh7ffVY5IJYATvbfyMmA3Qwc1m+6/0x5rWQqAIlZ4lPxSkv7owKGw2cH5yPedxdTWe4q+XlSuVFKF/z5srOXOK0q5nMmiaexbKYqBMGXhqcgUwla/Osqfx1m53Rln4+LwiDmpRNbZNChGIyOe1UIHW1Po2/gIQEMpX5xk6TEoIk3nFFzpkHWe+H1M+J3M2hUqN8+btJu99akMDwkd0fnaCFZj8ThqJhDbwa1DZc7Jpv/lIxGbXzKyv8Kk9KjeI/ji/vUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk0n8Z/DrLHV8rDziPfxqPENtHYtfcC+oqb5dNVlyYU=;
 b=o/dSwhaK4KU+V/6NmlH4fiKPSmfYa3WpDzE5K2vxdlNwzCKQBOS1QvAeTTqXB1NwwhUZex6iNSEcGRqPk1d06xmfugXuNRAgTMP1AvqFqS52Jtr45MS2bSTdlvegp7zNXE886cYmtY7lHvEhJ+TcJAGo2IDfdNJEfGaQUtQVDr1DKjcskjYUKrCcDeJEwzSL22ghxMxKdXXqIU7IaU7OGWWoUTRh3T+k/V5BBxw+GtMJpHU7DqRRMKezJpZgUMKMojfGlZHYBjY7UUwIYgiIMra9VQhddb84I+lpXqlqWUrHlB0AyesYAidV1zeWgXlPK5mZknq05UfrODxXT9Rpkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:17:45 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 18:17:45 +0000
Message-ID: <5b8da3d8-f24c-43d8-9d82-0bcc257e1dac@nvidia.com>
Date: Mon, 18 Aug 2025 21:17:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5] ethtool: add FEC bins histogramm report
To: Vadim Fedorenko <vadfed@meta.com>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20250815132729.2251597-1-vadfed@meta.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250815132729.2251597-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 221af2ae-49df-44d2-5932-08ddde83873f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGh1b3QvTEpmN05kRFJkY2xRZFdKcmY5R2tuck9SVUFLMU93RjBYdEYweVhY?=
 =?utf-8?B?QnVXS2xibWg3VnloRnVwWngrcWs0ajROSXZtcWUwVDJlS2ZHQWZxMFdmSmhU?=
 =?utf-8?B?OTdvV3JTOENiSXNQUlF4c3k0MUlUMjBTS05hMldVM2dFZ2NlWUZwVDcreCtG?=
 =?utf-8?B?clNzYm1hMy9XZDltTm5UUnFMcEVrL29lRllyNDNZcjFLMGhYcWRLeGt6Z2ph?=
 =?utf-8?B?elpaenhsMGU1SklLUFMxSnFqby9yeEMzdDliSVk4WkdrRCsrRXptZERkVGdr?=
 =?utf-8?B?N0RGSlRYOW4zQ3A2S3BzbzJ0WUFaZVgyT0J1ZjQzUG1aMVkzdXQwY2pEWkEx?=
 =?utf-8?B?ZDJlYng5dlp4U0Q1L3h3Q1M1Ny8zdnZQN2k1MnRhaWRCbjNOOW1aQXJlVmFQ?=
 =?utf-8?B?T214R28xK052clZTckVwbUFaQ0xURnRTOHlkTkJkZ2ZRUDJoNVRxVGRBNy92?=
 =?utf-8?B?Q1VYaXRqUEFnTms2VzhJbW9xaVN0Wm9Temttak80QXNYUTRaU2xFZTVBUncr?=
 =?utf-8?B?M2dtYWtWWXBEeHh4ZG5vL3NsaVBYTXJTZy9Id3N0aWkrQlVtSFZvNGp3a0xQ?=
 =?utf-8?B?WXBsazFpMTR0TzJvMVRYc1ZBR29QSUU1cnBtcWoxbi9JMm1zTXdmMTlRVDdK?=
 =?utf-8?B?RVo5NlVKZ04rajJIZmNXaTNWVzJ3NTU3dUZQbVNsSndIQWJWT0JkeHJGbkJL?=
 =?utf-8?B?bm9rWXB4WXhxVnYyT0E5TkhFejlETEkyS1FOdEFoQysyR2FHZk1mZkhwdUY0?=
 =?utf-8?B?Z2dPN3ppMTQyVFlmRmNLdEVMVlV5NURHdVA1WHJRdnhQWEJhakVGU1VuaFpZ?=
 =?utf-8?B?R0NKdkxNRFNHT3Bia1BJVW83VTRRa1ZET0NOOVFDNHQyR3p3YnpkNDdHeVND?=
 =?utf-8?B?aFprRXpiK3hMRkl5NFNDTndwejJENkNmR2J6YVBxVnZ0T01sTmtnYkxiT3lV?=
 =?utf-8?B?Q05kLy9wOWQ3MklZemEyc01oYTBvY0dWVEZINThMQ3RWbDRKSkh0SDE1S25m?=
 =?utf-8?B?RDFlcjBZQkFKekRXVEVNeTI2ZkkvcWxSZlVVK3pUa3BxRExTYTQyZlZTbE96?=
 =?utf-8?B?cGQvVUpjdFJpcEU4MnlndE00RXp3Snp6U2hEVjI2SS9NUUdLYWtvRFo5Q2Za?=
 =?utf-8?B?NUg1L0tQRXIvcFMzOXhOS0xhNWhCKzVDTWRjeEc1Vk1HQXRqNUVpQk52NlQz?=
 =?utf-8?B?UktydkN3K1lVY2N2UVU0aytvRmFqaXFrNXdKakVJSktaa0tmaFNEN29KL2tW?=
 =?utf-8?B?eWs0RlZvVzhjOFh3Z00rNzN4TWxMZ0hjbjIyVTBnNmpVeDJQamxRRVByZDQ2?=
 =?utf-8?B?QUlJaGc3emh3cFQ1SHN2LzBIZEphMjRCWEl2cElXQU5WU05OTUtUeForTjR4?=
 =?utf-8?B?QmhtcmwwdExjTWpXMFBtdVJHQVpxWThCczgwVVFYNko5UXFSaU1oN0dGaVNT?=
 =?utf-8?B?SUI2R0hjbDU2OG5CYjkrLzg5T2t1c0lKcGlYdmdEb0lYNmRRWmtJMk9ma0M4?=
 =?utf-8?B?Zk5lNVdld21jcUJCWVlGTG5HSzRUTFVCRGhuUHZPR3p6cDM3TVhLRzRHRDR2?=
 =?utf-8?B?KzBLRlJhUzdKcWlpV0l3TkZ0OEtPeTVCNmlmZk9CQ2JmWWQ0QzZGQjQ4S2V2?=
 =?utf-8?B?SWlmZDErTFhrL2hyYU9paGV5d2s5OGFEd2tmNGtYMWlKTFNaOWlFTVNhV1Za?=
 =?utf-8?B?WDFtV2MraEdOK09ncy9UZVBFS2c3c29zQmZLY0I3clRVVUM0RWwzUlR1RTg3?=
 =?utf-8?B?VGFGWkRVYVgrTUV0eGYvUWVyaTJXNk9mQ0d4RkRhbHMva1lrZzFobi9tYXVJ?=
 =?utf-8?B?K1QySDNKc213djViRGtaMnNGQVVBby9OU1pEM0RMWGxCZzBLNmNpYnE2dk9Y?=
 =?utf-8?B?V3NtMDZ1bDZUUUJJdHFDT3hMRWYrS0pWWWc0RmJsUzNiUE5JVlJXRG1WRzdM?=
 =?utf-8?Q?uZ7MNZtPNjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlB3d3RESEVCTmJoQkxGOTR0QTVaZHhqRyt6UTFKZFF0WGNkSWdtQ0RGTmFF?=
 =?utf-8?B?MHdCczlxYy8rYXlKMzl0anc0R3JSa2tydld3cmNMN2NJN3dRT2NOM1BVQUFr?=
 =?utf-8?B?Tm9KUXMwdXNFZm1BRnRiaGl6bmFQL2VZTi9ydFRXK05PZHlSZFlaTFpTeWJ5?=
 =?utf-8?B?MCt1QUdQa2FMUlA0ZzVMS1h1ZGJSMzY5M1pxMTB1d3FWOVZ1V0lEbUxFSWs0?=
 =?utf-8?B?STA2UGVZTzdUREJ0a0NQU1FoZFhhNzRCNUViVDIrZzJLWEpmaEJTWXVxMHJS?=
 =?utf-8?B?eXppYVVsd0hwVE9ZaUtlYVM5K0ZGMHJuU24yWlpzaXlGM2ZJWXZSUU1ycDRq?=
 =?utf-8?B?ODBpZlNDbFovY3JlWVpnOHBDS3FjNWdxY1RKdHowNWFHbGhFTUhwT0YvQ1RK?=
 =?utf-8?B?MnpBYXVkS25ucUw3SlFUSjd4N0hOWXFHTnA0bVNtcmNxaVA2dnYySXljVFgw?=
 =?utf-8?B?dWJoTm44aTFzMGptcTNMTXNJWVl2OXdvcWFPZDU3S2lXVVdhNGlTcVB4c2t1?=
 =?utf-8?B?MjMvQkFRbWRVelN5V2FqTXZ1L0tzekJtaFd4YXBMeGVWUnhEK0x0Z2RaVGIv?=
 =?utf-8?B?b1VheUZtQlJSbGY4eWZ1ZnpPdlVVQ3BVLzRkYTIyRUswQnlIVS9tM1dPZGRt?=
 =?utf-8?B?TWdQREtpeExxdEFsdXdqZkJsK01iMHU2TEI5blFuNVpKL25Td05LbHhySktB?=
 =?utf-8?B?QkV3L3NXT1VSL3VqcHFOcjRoSkVsclE5UEVRbTZtV2tzVnA4ampwSXZPbU1N?=
 =?utf-8?B?NE55OTVPOGdNRmxvOERyaDNaWEQ5Z0l0M29NNXd1UE5YSEhxQmg2dFgxaEox?=
 =?utf-8?B?ZWQrNVBzSEVpMjVXYnkvV3V1UndSNEVydWpBc0FPTzVuQUhodExwajU1a2FB?=
 =?utf-8?B?QWpjMGxTcDFLQnF4Zlh2dkxNc1cxSzk3TmlQeFdLeU05eUJ4Z0tIdDI4N0Jq?=
 =?utf-8?B?Z1R0NWtIS08wR3dBMkVFanZLNkZyaDhkN0Qxa3FBdGJVbVBOWHFWcFJQdytl?=
 =?utf-8?B?R002RVYvNG5HVUwyYmphSkRyUzJJRDFab2tYMkwvc3dkdzRTbHNGTHNteHF0?=
 =?utf-8?B?cFc1V3VxZE94VUVOQjlLR085ZGFzUTNsc055dVBSVW84aU9WbzNHTGxNNFR2?=
 =?utf-8?B?eWpnTzBMdjVaSHp5bXNXR0hndTVMb09KRWdQaEUwNWlZRzMrQmZrMHpCMEx4?=
 =?utf-8?B?VVhRZVp4TVN0d25ROE1yZ2tMY3o4VGJKNFZkT3VKWkNtdFNlaTFndWNWTWxQ?=
 =?utf-8?B?cS91NUtwb1dRU25PY2l6Y2lWd0ppUlE2cDB2dXZ4SUZvRUR5QXZDOVE5UXoy?=
 =?utf-8?B?NmtUZFJnYUZuTWRqWVNsdEdzRy9NenNVaWl6N0hDaDJKZE96OXRkcEhXOUtr?=
 =?utf-8?B?OEVWQ3o5TklLQzdEWXNiRzB3RW11MWEvR0taMWMwRHBFeTBqa0NnOHA4cnlD?=
 =?utf-8?B?N1ZpMVpNL2h0d2VtR2lwc3YrV0tDU0YwTHlES1pUTlpSU21kU2dDdzR4cmln?=
 =?utf-8?B?eGZoT0l5L2lSVGhEZ2psRk1ZcU9NK0dKaURCRzByeXJFWHhyMDZqYkZNRzlR?=
 =?utf-8?B?c0ZKYVB2UGlsTDNNMkZibjQvck5jN1dyendMdzRqQmVVb3RGNEVyYmV3cmd1?=
 =?utf-8?B?WFQ1bmFmc010dEpHMW9kemliY0JRdSswOEVNNTU1WllrUHR5SW5TZnFGTzUv?=
 =?utf-8?B?aGZzKzFHQVVRckVwN2FLc0JyVUxqZkp5U203ZlErTmZxeXhuQzZ3MzNYWDZa?=
 =?utf-8?B?TzVjQWpmU1hsUXR4NUllMmxMc0hBY0ZjU3VUQmkzSmlVQUdHRU1hVzFVVEo0?=
 =?utf-8?B?empZOG5TZkg2UjltZlNqMnJtOHZ5T1AvOWJEZDZ1K1V6UUxuUHVKY2JGdDRM?=
 =?utf-8?B?N3cxWmgySCtsZGlTMkRucmdOL1dCM1hmY0p3c0hEQlhicXpLMG1SVmJJa3pX?=
 =?utf-8?B?TFJDT2s2bm9tSC9xcDNYTnFHSm5jVWJjYVdDWXhQNUtsRk1NREtCdUxBaTlx?=
 =?utf-8?B?cENac3BOQXBjdHlaWDBGM1hUNUFBY3pSL09JQkpJZzM5d1NPTTA5MGpGR1N5?=
 =?utf-8?B?N1JDRVl5Z0lJa3V6dkM0SWxGKzBXTHB3Yk04RWpYaGRnaVRuM1B1SlNjb2Y4?=
 =?utf-8?Q?arX6WCuX1AQApjB/pTU1UiqDJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221af2ae-49df-44d2-5932-08ddde83873f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:17:45.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC4yQw/IahOGk5aNiRDh279xwhTn0m7ZHuIcyYj81ay+OJzBEdJnk+ITsRyRemcM9Fckg1N0RvPQ5EmxGfeE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352



On 15/08/2025 16:27, Vadim Fedorenko wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index de5bd76a400ca..6c0dc6ae080a8 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -492,7 +492,25 @@ struct ethtool_pause_stats {
>   };
>   
>   #define ETHTOOL_MAX_LANES	8
> +#define ETHTOOL_FEC_HIST_MAX	18

Could you clarify why it is set to 18?
AFAIU IEEE 802.3ck/df define 16 bins.

> diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
> index e7d3f2c352a34..9313bd17544fd 100644
> --- a/net/ethtool/fec.c
> +++ b/net/ethtool/fec.c
> @@ -17,6 +17,7 @@ struct fec_reply_data {
>   		u64 stats[1 + ETHTOOL_MAX_LANES];
>   		u8 cnt;
>   	} corr, uncorr, corr_bits;
> +	struct ethtool_fec_hist fec_stat_hist;
>   };
>   
>   #define FEC_REPDATA(__reply_base) \
> @@ -113,7 +114,11 @@ static int fec_prepare_data(const struct ethnl_req_info *req_base,
>   		struct ethtool_fec_stats stats;
>   
>   		ethtool_stats_init((u64 *)&stats, sizeof(stats) / 8);
> -		dev->ethtool_ops->get_fec_stats(dev, &stats);
> +		ethtool_stats_init((u64 *)data->fec_stat_hist.values,
> +				   ETHTOOL_MAX_LANES *
this should be ETHTOOL_FEC_HIST_MAX since we’re initializing the 
histogram bins array.

Thanks!
Carolina



