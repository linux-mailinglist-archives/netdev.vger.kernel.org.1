Return-Path: <netdev+bounces-206321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21368B02A6B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60049564D84
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8421FF58;
	Sat, 12 Jul 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tcqa0HIR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B9254848
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752315742; cv=fail; b=WYhu8YzercD1uhcgfKz+HZzToSmh8tTNDzaJ5PCLOwdPHUD4K7fHnhhv5GqOatcJsvOSnMHJNHrHovxOA8Za0d4MjxqHJMf0Rd0SJVQLxQRALQYATsPl2pFuof+QSKO8kya3jRS58lbGCPk206adkRWtehUQVyhSNE9M9XK/vos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752315742; c=relaxed/simple;
	bh=HnztqFhP95GZ8+llazJDG6XpcQh1d+mv4Vo1DsjVbSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfnQ5APVdmDpAYlBmbusn6UnfNX31xiUvJCzVt6JRRaNY6H9rv/eG7eDNgh9HEZNtKPYvmA9t2GL0lHdtIZvFVtcPqP2ppXccspkwXfmJDpKzKsRYK9M2DMt9x0w9mR3FqmAfGccpyr9yfQB/tcvhvhqxmlU+b5ZnDXmoV9V2RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tcqa0HIR; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoD2sBvlDfGngATobvBojXHkHrgLoTEUEjKZ5mOymip187zFYyyOEx8y9EvSuYbNIJSp/64X+06Rmj60l6M60Mtyr2c49zEOjbAf0s8AYyOXtIamZ5dryfJyxpe82wS98lZ9F+Iee7s1qPtiEGyBlopEkA1Fqb53tiwro4Uf6+a8H4/rNVlTtay3BMXjpU2zekwzBU47YwN9Lmo+hOsZux4B6gSXgpDwNPCxqNj8osXkNqjKtsGbIYWtAFgiSvpLVzEnGKjxWY9OTFk8q//24KZvlBdqcHAVh6HzV1+oZrhvMZAuKNcZu5HfZGpC3QJgfhGTqjWn5KucPJtF6xxfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSo1tQUJ6NGCK41dsQ6E3dHYA5CzsGksDRg5dqIk7gY=;
 b=pr+bBLV/pouhL3diCr1K70jeKkq1TWCrK22g2EwL58Ldz94nR2NxosPTTaFvgEEMxrx3h8kolpf/QJPT+DXKNRryZThOgNjaHcesJjE3wI9VEz4d0jCz3nYUyqA3ugS7PCw1B2u9o8zsJOULJGlB58RLWf2x0JKO2qWIkV9khhCl7wozoTP+Dxg4sbViQwcz1QFw1APTfwOLfyHmaVb7bRS0FSzYIWG3rQIBJ4zEyLLGWNNvk71S6hpec8jrygzmYUYiXApd6E7HwpxUfZlOq4+tqM8Vm3JRy53ia9S2lMLr1QmngnmGHlsaTASdQ0qnt5dxjR3Pxi21U3Bh1P0pXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSo1tQUJ6NGCK41dsQ6E3dHYA5CzsGksDRg5dqIk7gY=;
 b=Tcqa0HIRLkf/L4GrS32FBMD0FcIZ7WZEeZUCLyXpCc5NSk0TShE0YZ/Vq8lH2oibVt6DLTepva1sudHN7MLQAWqgiffgNKh4kpNUPANcuDo9gV70huly3a9Cjf2m3WRtGqubenUEbFVbHG1AbbQ9vExXMPJFTIcuLO2NwfQ4g3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Sat, 12 Jul
 2025 10:22:17 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8901.024; Sat, 12 Jul 2025
 10:22:16 +0000
Message-ID: <d0489a7b-9af9-4c6e-9397-c3a8062f2bfc@amd.com>
Date: Sat, 12 Jul 2025 15:52:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] amd-xgbe: add hardware PTP timestamping support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20250707175356.46246-1-Raju.Rangoju@amd.com>
 <fc6140db-08d9-4d05-bb68-410ddbb63c65@linux.dev>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <fc6140db-08d9-4d05-bb68-410ddbb63c65@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::11) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de7931-8d9b-487d-f599-08ddc12df9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhUUmNpR3hPWWtXUmVRWkxDVjYzUVVlZW9ZY3BWMmpsM1lMODlmdkRBMnhv?=
 =?utf-8?B?RjBhcDZWTWVTQ0dOY3h2TnZtd1FQSGhsK0RnS2ppVU5iWkNTM0h0SWxqOHZ6?=
 =?utf-8?B?dXVKRjVrblBFY3Z2Ym0vU1ZoTmpoTW9xZ2ZoNEdEL1ZIVnVVeGlHK0FPaFJE?=
 =?utf-8?B?UHNCSnRhdDlYVDdETHFPdVlOSnAzdEgyaUdmbTlrejJkU2JwVWxBQ2FKTmtC?=
 =?utf-8?B?Lys1OC9SOGZObnU4b20rMFlzcUcxN3VIL1BIbGlINEtZWUtzdnh4cGQ5dmdZ?=
 =?utf-8?B?Mk9ZTEQwdXBsT0tPQlY0OXU1VUxjQjJZLzkvQnM3TkQvbiswS05tVHVQcHcy?=
 =?utf-8?B?c2srZkd0ek9SdnNXTFFPcVR2dDJCRWhGa3FZdzBWK0EyQktWeFFPdmhUZnFJ?=
 =?utf-8?B?SFdNQkovR1VQZVUyWDN3anY1d0RvdmlKSGxNN0xOVEVmMmlXbmhSZ1dSYTdB?=
 =?utf-8?B?TXVSSFdmUk9ZRGxrTlpndEJxdGUwdWhiNENiK0NyNzJWOTBkdEpXblVGOXBr?=
 =?utf-8?B?UWNqMHJmUEprdmJrSWptSzdlQkV0WTRlQXoxRDNRc01PeEdXNnZpaDdHbWwr?=
 =?utf-8?B?NWFldU9EUXRUS200dWRTOVN2eEFlLzlYMzFZS0VQNENERkNEdmRFTXlrVmxP?=
 =?utf-8?B?RlVaSk1NZjRjVk92MHhJYmlZVGs0bFJrRFlQOGpuVE0ySlpoU2tSakNoNms5?=
 =?utf-8?B?TWdPR1kvU0VCZHhYeE1GSWRwZk9LWk5tQjhGcEZ3RVZ4aEpaLzl0clpDVllG?=
 =?utf-8?B?SW55U3hWL0Y3UHpEMkd6bHAwQXRNV0daSU5ycHE1YndGWnBjc0F2SEZ1ZXVW?=
 =?utf-8?B?YjVobVRxN1p5N1FqMUVLa1REVW9CT2dKanU5VVNTS0EwdGNyWnp2NUJIcWFK?=
 =?utf-8?B?ZllOemhWdjZWYisvWjVlU2tOdmhkQ3JBdUFBMzhsbDl0TlpFZjdTam1BdkNF?=
 =?utf-8?B?RWlvVk90cmJWNklCRVQ0RzFmVEhxdDFLcE5DWlhCaDlRY0FrR1JvNHZXbDNu?=
 =?utf-8?B?Q3IvdmVwYk9HZzhlYVdqa0paNEE1aVQzRUpSamwvT2lkMER5Qkw0OTJFL0xt?=
 =?utf-8?B?blEvd0dZWE9DSEQ5Kzc4T0NTdk9OWVlDdXpCYXF5a0hzTWFkOWtMTHlZZzA0?=
 =?utf-8?B?Z0hGejR3bzc5YUlzQWdTZ2FIS203ampzNVM3NVhzTDNxSmxQdVdnR2ExR3BX?=
 =?utf-8?B?dXo2MzZPaHBRRlhvZHMzNHo4ZjRLS3YvNUtvS2ZXeDRtUjBlSjFoeGtYTkJi?=
 =?utf-8?B?L0Q1M0xKRUFiTE9yYUE0ZW5UTGxPcHNKK0t1bGZQdVp6VWRKUWhweEE1Tzg0?=
 =?utf-8?B?bWpmSURpVDFMUlc2TzRkNzJrYlUxeVVsR0xGSkJ0dVJmZHROYm8wR2Z5SUQv?=
 =?utf-8?B?RjNjSVdPSDBzbG9xOGt3Sk5VWXBKVlZWdjhQcEt1cktYRCtYSFFock1heXgr?=
 =?utf-8?B?SElwQWNxTko3WE1YdEZ4MHczNHJKZ3FOZFJhNy9zQjJkeUR5dVlxaElRTUlW?=
 =?utf-8?B?V1dkbVVVTTVCdC83Vko2dW1odi9HSGg2Z0RrbTJqeCtWQllQMC9rR0RxcWh5?=
 =?utf-8?B?N1NrT3hraCs5UkJuZytIekN5bUFXcjZJT21lTTlsd05YMytPWFpzRW1vcmlR?=
 =?utf-8?B?V1FLOFExdS92djRwaWtJWHNVUGFJMlhRMkg0eXVIcmt5NEViSzBrZC9jUDdO?=
 =?utf-8?B?VmdSd3g5bXJONUl0MDQyWHhhN3BPMWRCMVgrZFRSL0tBd052aFNDR0NyMDVC?=
 =?utf-8?B?RWZLbWFOVVlaaW92MlEvd2U1a0NoN1k2T0REMU1lSWVoRHc0ckZPV1U2UXQ5?=
 =?utf-8?B?YmNaZlRuSS85L1lkcWwyY2JZVkpJdjdLb0ZaSG0zVEZwL3U4ZnA3YklLNVRn?=
 =?utf-8?B?NmJ1M25hQllwVWdNTW1iWitGLzB2WGZvbndVd2JqaXNORC84VDNPRWFFc1h1?=
 =?utf-8?Q?VHjKt7GZlWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU9uQTlHY3BBc3FEUktLRlc3YXZGQm9DTFFUd0VsSHIydlRpTnE3U1F1bCtJ?=
 =?utf-8?B?cFVrd3FENDJUeHRicXZ4WHpwQ1ZoWnVTajQvQ1Q1UXFCM1c4a3pYY1RYS2pq?=
 =?utf-8?B?TVhJVVd6eXhoc1ErRXdHaEtBVTB2L2JqSlJBM1ZCZzQvK2IxVTdvUHdMMG5M?=
 =?utf-8?B?T0hBU3h4TTRmYjFMMmI3Sk8vSlNrR3lTa3AyTkVMWVJheDhaOUdLK0JaNG9V?=
 =?utf-8?B?aE50R0VLZ3NIaUsrUmFmVjhYRXgxTnlLNG5OZHYrajBKaXpKbDRROVpiNUJz?=
 =?utf-8?B?RFFkR0dUbVkzTGlyR3IzbTBsR1IxZmZjWkZOWmlaTjdZbjExK1Rxc1dXSDVy?=
 =?utf-8?B?dDFRenZVbE5tNHJJLzVKelg1MjdNTXpuUzVuWGVrdVpCb3J0K2M1Z0krQ09G?=
 =?utf-8?B?TGRkU0Fib1JWeFhrWmNpcXpwYlRLbmJOQ0dCRk9mbDVCRjhOQVZnUG9KZ0Fz?=
 =?utf-8?B?RXc5a2NWQzFDWlRPc1BGWEZNMEpRcWRlRHY2UXJGakZrQng2OERTMUtnT3JE?=
 =?utf-8?B?OWhUZ2YxR2lpbTRBM3F0R1pEb0IxVnpMSnVoTGpSVHhaWE5MNXRmanJZdlZ1?=
 =?utf-8?B?bFg3SERkem5TVkRPTHJmeFFXV3NKTWcvR2tQT0JjeDFTYThHVXVueXZ3T3BM?=
 =?utf-8?B?MTNnenlZVDc3L1JWRm1BUDZXNWVoMTN1TGt0SDVsOTFoYWlIaDRpTzRET3Fx?=
 =?utf-8?B?VjJhUEtTUUxQd0NER2ZGNEtSZWhoU0FpNGZzSEl5c3l5S1JwcnFuQjROY3Nz?=
 =?utf-8?B?d3ExWnBwOUF4VzNyVkljTXhzaSs5NkEwcGxMTHVwRmh6anF3eXRWdjNsajIv?=
 =?utf-8?B?VUV1TVpxcDVIUjNxRlhoQ2ZKVGxvbnoyRURWRWNkcWVsWTA0UmlidnBzbVAv?=
 =?utf-8?B?UjZhVzI1WGxyMXFzbStrY1NFdUlZWTBCVGMzYy9SV0ZBc3hGMHJrSHdFdFc1?=
 =?utf-8?B?ZnZtd0R6bmhYTjI3WjAyY3VsWXAzaW5icENBcnRFSHdTeDl1VGJJT0ZIOTE5?=
 =?utf-8?B?TVhucGtZS1paVDlBUlpCb0cvNkxtaVF5STFsU3FxZnNmMHhIUEVFUzNEU3l0?=
 =?utf-8?B?U0t0akUzd0dkaWdZNisvanFTVHU1RGZxS1lwa1RhZXQ0YWdWVmZ4Zmx2SnA0?=
 =?utf-8?B?VTNob3djYnpTbHBhSENNMzZNQ0txdjJReGhBdUdQQ1U3VDN1VjVobmxyc0M2?=
 =?utf-8?B?c1gwL0t0RzdWd2hoUkxETTMyeisxNFpCaHByWGVEU0NrT1Mzc2pNWG9NbWhX?=
 =?utf-8?B?SllvbE03WEpZNnFpRUVxRjQyRytCNEp3QmkzbnIxczNDbUYzS1duQi9MQ3VL?=
 =?utf-8?B?Vm5iNmlxQ2tkSU94QXEycWVPNk8zenBrcWdsdm0zZmw1a2xXemVmSEhyZnFH?=
 =?utf-8?B?SUxNSHl0RFVpL3Q4c3lWcjNBS3ZIODE0K285NzlmN0EwTWpnZ2NnSnlyVUdK?=
 =?utf-8?B?SHdueUpQSVBWekI5eStuaWdhOEx0Zm1YVlBNWklCNzkvTE0yRnAyT2YwWHpP?=
 =?utf-8?B?MWZpMjFOaExtVWcwdEdzUjdNV1NZWmYxd2thTXJyZFlTZURySWh4WkFtakIy?=
 =?utf-8?B?bU4vVnF0dnJ3TFRQSE5JZWlRUGt2SmhFckltRFZnaHkyN2xZaE5RT0NuUWcr?=
 =?utf-8?B?SFd6a2VrOENsd2lvV1MwU0lvY1hYN2JPQUlnY2s4TGtmT2kxZE5nd3BqQlpB?=
 =?utf-8?B?NkMyLzE2WG5FbXI4eUd5YU1UMlZ4a3JmenBSRlBiWHhLK3RMVUR6eDErU1gr?=
 =?utf-8?B?YkgyVlJvSkx4Q0VzaWI2NW1LL1BnTEh4QjJtbG90OCtid2dqTEtBUWJxZVo5?=
 =?utf-8?B?UmdaeXBVTFlCY2tGa21yRUZKdGtOWG1hOGEzL2wreCtWaHZQdUl0aGJRWUZM?=
 =?utf-8?B?SDNYMk1jenQ4V1ZKMjFSL0lMUGlJaE5BNVdtODM4QVEyNW1TSHBPaVJ6dWpX?=
 =?utf-8?B?bmRCRXYyWXZEZTVzcWpGczkvTCsydCszbEtGbXAzU3VlQ0ZaU1lhb1NJeElK?=
 =?utf-8?B?MHJBeXBzb1Y1WElQZ1BEdkhrMXlIa1d5dFBNaTBFTkRFRW5wQktBWXVPTUN5?=
 =?utf-8?B?WExndWR4WmlCeURLWUlITytFZjFKRk5LeDJ2c1prR0cyUmJ2WFlObk1GUTla?=
 =?utf-8?Q?qbxp+W75XlKgPQrqwB30Ta2P+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de7931-8d9b-487d-f599-08ddc12df9a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 10:22:16.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoPj1HC8qRJGdbwpIkRyoQddflcIJ6kUtih3yqKaYjY3zkpfgkVTDmrezrws8y+wcZwo+JO2b+W6C094CWzVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799



On 7/8/2025 4:24 PM, Vadim Fedorenko wrote:
> On 07/07/2025 18:53, Raju Rangoju wrote:
>> @@ -1636,8 +1659,8 @@ static void xgbe_get_rx_tstamp(struct 
>> xgbe_packet_data *packet,
>>       if (XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSA) &&
>>           !XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSD)) {
>>           nsec = le32_to_cpu(rdesc->desc1);
>> -        nsec <<= 32;
>> -        nsec |= le32_to_cpu(rdesc->desc0);
>> +        nsec *= NSEC_PER_SEC;
>> +        nsec += le32_to_cpu(rdesc->desc0);
> 
> This change is not explained in the commit message. Looks like the
> HW timestamping has already been implemented, but in a wrong way?

Yes, the previous implementation was partial and not functional. This 
patch adds support for full implementation.

>> +    /* Calculate the addend:
>> +     *   addend = 2^32 / (PTP ref clock / (PTP clock based on SSINC))
>> +     *          = (2^32 * (PTP clock based on SSINC)) / PTP ref clock
>> +     */
>> +    if (pdata->vdata->tstamp_ptp_clock_freq)
>> +        dividend = 100000000;           // PTP clock frequency is 125MHz
>> +    else
>> +        dividend = 50000000;            // PTP clock frequency is 50MHz
> why do you use 100_000_000 value for 125MHz while 50_000_000 for 50MHz?
> it doesn't look intuitive
>

That is due to the difference in the ideal clock frequency vs
actual clock freq running on the board. I'll address the comments in v2.

