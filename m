Return-Path: <netdev+bounces-234012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9FC1B708
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2939E5C0830
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55DF2BD001;
	Wed, 29 Oct 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="4tpg4xCN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1126E719
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747998; cv=fail; b=TpfcH/CXq6k6fNyu0uc0X0XnSMuLDJXdsZYgvH8/MsKyvg6j6TslqEbpH8WgwNCUeFsKUBI9VWhUtsx+slzPd2vQsm2ORHsd/zzvCG88PgRVR0e042fNd8QmiBPBiGmbYr2MOlmKE7Cr6y8ZhdsYALdrG+8310ZMErAnB8K1czc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747998; c=relaxed/simple;
	bh=9PF7Lq5D5LdXng4dKWmGESxCxozu0EXWPQJSCHwCkgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZm2A+o5DX1e3XK7SfphvC/eBasfBPTHtgxnsgw4p72b9LXJg3nuK6ocoj6rIv3dotAarOVE8hIc632AFkq2uaRtCfT0KM72CszeL5RxvvsXrYa+TEvYWcth0rSJTM7v0BjYvIMdaxg5CpmefcM1S1hnQEtlBZW7lxSG4h0f1Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=4tpg4xCN; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1761747996; x=1793283996;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9PF7Lq5D5LdXng4dKWmGESxCxozu0EXWPQJSCHwCkgE=;
  b=4tpg4xCNFxxYpBZfjwubz6m2Z/cCSVeLHI7XfSAlTDiKtLzLl/ph5U4s
   WUSnq1xkWAhrvYy3HeYbNzQoKesMtU5h+v5NLuNP3HH5bOHFWtQY8VG3s
   pigiNLXXTKf3YBxhXpJClcJWhZrLh8Nk1YlxhyA7pP8QU4izKjB5LdWeX
   Y=;
X-CSE-ConnectionGUID: +WjwuuLdTqKx8zZVmENVEg==
X-CSE-MsgGUID: ySnWp7ETRBictlqgjXKjhg==
X-Talos-CUID: 9a23:9to1pGzJ3e4Cs/kumYmUBgVXJcI6b2D5wEvJAF/oG1RXTZCzd3KfrfY=
X-Talos-MUID: 9a23:LfuMAQlCQQKaOdkECSlodnpzD8FX+/uDNHonkJ4av9CLNxxTOTeS2WE=
Received: from mail-canadacentralazon11021119.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.107.192.119])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 10:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raM50rkj/XrLAv2bv4Bsmzv9sW9QakAY0Y4jlIiFnjsPeVV4IxWH/iUBIcXjmKOO++lfBlV7rgFb/1kcZ3a/UkP8shUc7wlGDC487PwQWuYh+0Q6SwNz+pVgxd55oA2pIlgAMUmGcDtaZm6pYcfFMUYY2oTFJ5z/Dhh4pUIzTz1QUHxVvFs1kLbI9crF1jybhiA6qofxp3aENlommnGetkrQQaM0IBMwLELkVh1sBXzyudFb4bYwTsNeNW4CaBGfAvbi046QqkIpuO/a6wz5qqUL1qQVo7mlSQLhFQfTCOhiKfDEjIp7CBrAnp3MseD0XOxUN7Vio9ItPzfVu/tuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Wup8swRSEdOZpHKCzpvdAZhRtIGhKrsYqVjHMxDUs=;
 b=MnnUfPlBXptzu2wNzYw51GQmO/ex7k2MbsHRRSbZAmtiImVCYU9hs7xaEj253Kl6f43wqcpgNfG5xgOa6VS/GoE6gC0w+1XAziWa8uyZtbq4lBVVDz5gO1xUYAeC4YNdTQaf8uw0B9B1is1wt5VNIogXO0CAUxAvob+RjnVESo0TiF5iWcAojRRHp8SXj15qBEfGZE4jHjXI4AVmuw+Csd5VcVhpTXX04JH92rTIykk9/DhsKeCotityjNPk/gq2WzyzylrFWXdCjtKSdgBRVEsmf/e/3uGEylN3VFzqFFezGZQE0xgPgB7AZIjXbdEUVJCjd5P9i8LCMo5ChHXYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQ1PR01MB11566.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 14:25:25 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 14:25:25 +0000
Message-ID: <559f1484-c41b-4d45-bfd1-40291c62bfbf@uwaterloo.ca>
Date: Wed, 29 Oct 2025 10:25:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/2] Add support to do threaded napi busy
 poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20251028203007.575686-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20251028203007.575686-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQ1PR01MB11566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6c5428-9744-4484-6afc-08de16f7005d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDVrdE5qazR1MlRLQi9oZW9WNXcxTWswYjI3MGVGdTlTbFNaSEhLTkxzemxa?=
 =?utf-8?B?MU5LTTlpNXV3QjlxQmdOcjN3QklweVVMUVRyRUVkRjk4eVc4Qjc1QXV6TTVZ?=
 =?utf-8?B?NHJwOGpjczBjMldHUGJUWkErRTJkMitERXQxcXJuTDhoQWl2a1FpQ092M3Vz?=
 =?utf-8?B?eHFjUm5odDhuS1pNaWdzcU9iSWZIK0VVT2VhR1IrVWFPeDRIZlRPeWdDcWFR?=
 =?utf-8?B?eXR2cU5qZTY2NGJNZW56ZXFYTFFmMVgwZWtHUjJQSzVueGdhNUxyMDBmWGZz?=
 =?utf-8?B?OEFDSjdQRWMxbEpGaUdlYzJUNlZtenAvZ1pqNWhIaFdpZ3FqTWVSY2JyL25P?=
 =?utf-8?B?cVdEdWFsYmE3dWx0Ky9PbENycVBuU081NjM1dmc0YzE5bzg4RXN4N2gvMGs3?=
 =?utf-8?B?eVN5TytkSkp0RmZYNCtmeVVQbmJqaDRkN1drNytRRVVEQVpST1VpTE1yeDE3?=
 =?utf-8?B?RmFCcmtENlJyVTJEOTREUUxkZ2tlTTQxWU5DdTNzNTN5R1RkczNJY2FDMktt?=
 =?utf-8?B?a1l5LzhxcTYrRHlzL014dSs4RE5wZE1ONXdDZHQvejFUSjA2VzdEY2l1UWlD?=
 =?utf-8?B?ZDYrN01ScVZnZndOUmRmdnRyM1JxQkZsY0ozRlJoOW13eFB4M2pMaGJ5enh0?=
 =?utf-8?B?eDZXLzNFOHlFRk95dG9LY0I1R1l2M1I4aWpNUHZJMFhsY1R0ZWtzd2pzdzR1?=
 =?utf-8?B?VS80N3hDUTVsTGZoSHJBQ3AzZm8vbHloa0NPK2QxbEtMd0RMcFhLc2JncDRw?=
 =?utf-8?B?d1VkUVVzeE0zQW0za3duelk5R1N0d016Sm9MNk9zUzZEeHE3K0dRN0ZUcGhv?=
 =?utf-8?B?Tk5vejhIWjdYVzJQVVVPZy9iN1ZlQk56ZU5YK1B1MTFGTVFkOVM2bEZzYXpS?=
 =?utf-8?B?bmM3Z0tvVFY5RmhxdlZ3WEJ0Q2dXd29vSm9pQWdpVXdoaXNsdWR2S0N0enBr?=
 =?utf-8?B?aGN3WVV6cDJWRnBaYURScGRvWWsxMXJ4MFd3RWxtNk5oNkxJOUJBWFBHTzgw?=
 =?utf-8?B?eUZURVMxWmlrakNOM1RGYkVPaHgzZ2FzMXlkSTliQnVIMXVNbDBHM3AwQ21h?=
 =?utf-8?B?ZkRRL2ZEcEJmLy9oSTBuaEhXbnpWQ2xPZmx5WTNEaXIybGptQTl6S0MvSjdk?=
 =?utf-8?B?U1ZaaksweEI1RWpMZXhVVGh1M254QlBMS1BkRVNhSVM1cGZ5bEg2YTRTNkV3?=
 =?utf-8?B?OUI3SlRrV1Zhb0ZBUUM1TmsyOHJGekJxc3R0bG9pSjNISDVScG9jMm82Rzdm?=
 =?utf-8?B?TXhPRTNOeTZBYXRWNGJBQ3MvK2o5bmVkOWVrVmNwVlYxU2lmRk05SXdVblpF?=
 =?utf-8?B?RUZvR3pqS3I0aWxPUGhabjRyY0k2NUVtbDJLUjVSVzUvOGR4ZmUyVThDTkFo?=
 =?utf-8?B?MVBuMzdRNmdhVkt5VFYwdWhmazhxUTJpV0xwWmRjOEZKVHl2NHppMHBGQXMw?=
 =?utf-8?B?MGYzaUtacWIwcFB5Q0RGRVJzVDk2bnZ1NFFEVm5neXZ1OHhRTXduaEtzeFR1?=
 =?utf-8?B?TUFWNUJ4VUZQUFN3SzgvaGpBR2pQRnBWU0UzU3JFNXE2VloxeTBHeXRZYzVo?=
 =?utf-8?B?Ymd0WHBCNVRUekNpQ3UxVVE3c2UyVnNodFhnYUdpZzhPM0FjVC9JdEJCajd6?=
 =?utf-8?B?OFhxSUJLNUZZRzdhK21pRlhUb3lXcXVTZHh6eVdqeGJEUnBLcUNpWnN2d25H?=
 =?utf-8?B?WGs5eFBTSEV1NTBPRHVIeXUweXRhTkZ0UFRzcDZSSFlBZ0tRQ3VCMDZoQlhq?=
 =?utf-8?B?RzBDSjRNbGM3T2ZnVUYyNHkzTkRRVXZEVVprMzF4K2grVmpSTW04dklTekpU?=
 =?utf-8?B?M3FBWXJvNjdZZHhNbUhFeXBLYUpZZ2FPbGZZbC9SZmNJZWtJWFg1U1pzUFgz?=
 =?utf-8?B?c3JLMUhSQWhob1RTZHBvRzYxVDR0SjhOcDRpWW5NVlU1MTg4VDFGYjZNdWl0?=
 =?utf-8?Q?9HWzSNmE7Byq3hhPzsgAGVQPR5UoEFAa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzhTNllHdld3dW0xaDc4b1RxbEZMbWo5U2puRjZWYktGT29LVE9GRVhmV3pQ?=
 =?utf-8?B?d2ZPMFFubEhCdkljNzV3OENSMFB0L05SOEIxZEtYN1ZUVkJTbjBWQnR1WHpz?=
 =?utf-8?B?Ty94OWNLbEcvUXdMQmhqekt1anFzdEttOEpoR2NIZzJYYTlvTVhxSElFR2hF?=
 =?utf-8?B?c3J0d3VIMlFtMkRmdStiKzc2c0dQNHJGYi95dUVhbjdNcHlLU1BjdXcvZUc4?=
 =?utf-8?B?Y0ZWWXhNdGdPSmFhQUVvdkN0N1V1KzFpL1djbzdDYUc3TmtHTGRBczVBQ2Ns?=
 =?utf-8?B?U0k2SE5DWEdFbDBGWTNjRDRGSG9aKzJ4S1JaSnJuMXNrY2hSMnp2b2g0WFJy?=
 =?utf-8?B?R3B1YjBRb1luOTVPUC80NXdmQW5DYnBvc2VRZDcwa3RKbWNhd0Z2cFB2RDc5?=
 =?utf-8?B?U0Rwek45OXZMcFplZEluWkkzdTFSb1greEgzZEtMQ0VPTUo4N3FvMDJQQkdL?=
 =?utf-8?B?Mjd5ZlhHazZ2NjRqMG55RkRhNU9NZkN5WE9kR0pjeVZXa3VhQU8wM2JZTURi?=
 =?utf-8?B?Q2xrVzJoa1NBNy9Ja0lyYmozR2FuWmM5a1hxT2pJWnY2ckFPNG9lRkFpbnBK?=
 =?utf-8?B?ZG1aMTJ1elQ4aVJpTmlvdUNlUSthQldBWnNRMzU4RmVZVzBNNi9tc0tYZk5l?=
 =?utf-8?B?KzlXbHUxTHMwKzVMQ2RLOWo3SjduYUt2N1JvZkpFcjlqcGwrTjBIejVaby9j?=
 =?utf-8?B?RTRWMm85Sk5PSVBESUpDYmFGU1drS0htWlQwWHoyUFQ4SlNTT1pnRGRwWVF0?=
 =?utf-8?B?eE8yQmlKZXBUNXd1dEhQRjIzZGdqT1ZwRUtsajBmL1M2WExzMThNY1lHRXY5?=
 =?utf-8?B?QWJ1SFU1RmFGZ2FqZElEWXd6WHUzdzcydlJXN1RaTVlNb2RmRmFiZHRRYkNQ?=
 =?utf-8?B?b1F5cmgyUjR2QUJQU3pqaGowVEJYN1VleTFvdlFaL2NwYTAvL3FGUElLMlh5?=
 =?utf-8?B?RVN1LzFaRlZIWVFBOVF2RkZOS3pkSWRLaEllbmxYbS9CbjZidmlKMWh2bXc3?=
 =?utf-8?B?dndQOUg5dWxUUkthSFBZRGQrYU1RaTBacDBVanAyUVNsMWxDME00WFRSaTB4?=
 =?utf-8?B?NGl1SzdlWWh3ZWNYVmdYLzVuY0hLUDgvTk52RHYxUUVyajVQSmh1dERNZVJW?=
 =?utf-8?B?bzNhcVY1cjRzMXpFL3ZhUHhTbzZzVDJSMW9PTERwV1JScGRIbWI3dkRtWUdZ?=
 =?utf-8?B?SWI0RUxJM1hTSnZobGRrZVE4VUpDMUtIQUxlbzJTZFFVWHlkcXN0aWI1VnZs?=
 =?utf-8?B?d0RsMmE3V0RxVnVKc1N4K2FTSTZMUS9lZDZPazNjWHNlRXlWYXdaR0F4cnh5?=
 =?utf-8?B?TEtjSXhiamZSYXpGY0hxdnlaNGt0VDEwY2VCRUsva0xvdlRVWFJQZ0UrOWZ4?=
 =?utf-8?B?Rm1ZOUg1RnBtWUdDaVlGWnJZSUttRWNHQnRmQmJxWlhyZE55ZnFjUkhiaWsz?=
 =?utf-8?B?dytqdUlpY25RSlVhOFpWWGlSRGY4OUU2dTdaeTRoSmZIV2JMTHpOYm91WHFN?=
 =?utf-8?B?SDBQTWU4VVoyM3Q3TVFFR0lVbnJLU3dkL2V2V2ZiMGx4Z2puS0RpSmVGMzRZ?=
 =?utf-8?B?bGhHYkQwa2JLUmdOTDQvS3RLeXFFYUFDWElEbU9jcWZ0VWoxRFIwOWo5dWtF?=
 =?utf-8?B?ZUhVTVVXSVkyeXdVNW8rNHc5UHVIVDRwRDlLaGtUQkJwb0txNGFzVzBIRmE3?=
 =?utf-8?B?RE9DaDRodVpNcmhad3JxVkFYdlJENWs1WkZpQUduTWxWVGhma1ZEV3cySXlt?=
 =?utf-8?B?bGpUZkVWd053Y0RJM2JWeDlaOU1tVjJKVE9Kd01CME9zYTVmQ1BZYlBFeXN2?=
 =?utf-8?B?dWdBbTR5b2tXTWhlVXJjZ1FJdElQeVp3WWl2MitGMGpzYVlnY0tITi80OVdY?=
 =?utf-8?B?Y0c3YUhUNUFweHB0R1pmMm43NXlqajJyZEMzQWx5ZnZjS1pLdU1IYzlDODVE?=
 =?utf-8?B?T0NabnRqVXZCV1NPY2ovQ09CaDROK2xmbUdCOWlVNjhiNm9tZ2QxVUN0UHlo?=
 =?utf-8?B?eklOaDR5UTFSZjlPSFpFTjhyTksxOHhaSVZIUWxWMGZFYzBSSkFNeU9GYlMr?=
 =?utf-8?B?ZzdZVkRQdE9ucy95TUk3b3c0bHJWMnJBQUkwN0RJOGF4NHlqa3BpYjRTMUdN?=
 =?utf-8?Q?a0+AYqaXa218I4BNngRkIxOpv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VZggbf/knw9NCsGmWFDUak9EhFDgbewF9KEVwF4uAT4+qyWwAGJlQvG+OmijAOTcz65sec8O1GErTs4I1hyJgksJQLxLH8x4UpsBQhHKQ7EZA5AGREhwjm0i9Z3FO9k2InSMmTO2YrccTyzgRFCrLlAPvj+wQCsuceL23NA/0XDsZuLhri4XkFR01CIIBqc73oxEnCN7AVd+tJAa00fHj/lEK+ZqfWHBPQ6ak8H6ICsMDrJ/qNSizTfZnB8Ee8vVf/hZUKbhk3m+e4P3fVCb97t4SaWTui67Uk6nx4oK2N/3Ovp0oC8pyIWMu4LAHP5PGv9AUKgXRRx8GkSpSFkcoapLICCvM+vEy/x9RzOAM95SMAyJviojtVRfLM2OUytpBe1FLFMxNsXdZtEYcDR0yxGJgNwo9wQwhyoGfLreAukj4oTiJOgcvsgEF8ybBCKYxGd8fdjjQGUQb1qTyzatdlN5/Q4tFD/G2eLKXNrubNlI/5J/2Jh2x4tg5CAYfWilzBg9dhmNXkjdJIlcWyrRs6MgWbUj+onSvpgfGQldyY2vayc5WNp16YFSwS3GVaE0OfRbdGlBp0V8pe55GJAZIBVPdLzhrtJdGFfz09jQ6yplFcHKL6XzLCvZgWUcPPCd
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6c5428-9744-4484-6afc-08de16f7005d
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:25:25.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtM9aY+6+rj+m0PooPZXq0OCbDFRHFYc7wag4XU47Xr0CZ3j+nLh2eyDppEuUpYmNNzRFMkRmoYoHBK1G6VmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11566

On 2025-10-28 16:30, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Extend the netlink interface to allow enabling/disabling threaded
> busypolling at individual napi level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. This can
> be suitable for applications that want very low latency at the expense
> of cpu usage and efficiency.
> 
> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
> backing a socket, but the missing piece is a mechanism to busy poll a
> NAPI instance in a dedicated thread while ignoring available events or
> packets, regardless of the userspace API. Most existing mechanisms are
> designed to work in a pattern where you poll until new packets or events
> are received, after which userspace is expected to handle them.
> 
> As a result, one has to hack together a solution using a mechanism
> intended to receive packets or events, not to simply NAPI poll. NAPI
> threaded busy polling, on the other hand, provides this capability
> natively, independent of any userspace API. This makes it really easy to
> setup and manage.
> 
> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>    frequency of the packet being sent, we use open-loop sampling. That is
>    the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>    recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>    delay in usecs on the client side after a reply is received from the
>    server.
> 
> The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.
> 
> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>    packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll
> 
> System is configured using following script in all 4 cases,
> 
> ```
> echo 0 | sudo tee /sys/class/net/eth0/threaded
> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> 
> sudo ethtool -L eth0 rx 1 tx 1
> sudo ethtool -G eth0 rx 1024
> 
> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> 
>   # pin IRQs on CPU 2
> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> 				print arr[0]}' < /proc/interrupts)"
> for irq in "${IRQS}"; \
> 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> 
> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> 
> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> 
> if [[ -z "$1" ]]; then
>    echo 400 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> 
> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> 
> if [[ "$1" == "enable_threaded" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_poll
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>    NAPI_ID=$(ynl --family netdev --output-json --do queue-get \
>      --json '{"ifindex": '${IFINDEX}', "id": '0', "type": "rx"}' | jq '."napi-id"')
> 
>    ynl --family netdev --json '{"id": "'${NAPI_ID}'", "threaded": "busy-poll"}'
> 
>    NAPI_T=$(ynl --family netdev --output-json --do napi-get \
>      --json '{"id": "'$NAPI_ID'"}' | jq '."pid"')
> 
>    sudo chrt -f  -p 50 $NAPI_T
> 
>    # pin threaded poll thread to CPU 2
>    sudo taskset -pc 2 $NAPI_T
> fi
> 
> if [[ "$1" == "enable_interrupt" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> ```
> 
> To enable various configurations, script can be run as following,
> 
> - Interrupt Only
>    ```
>    <script> enable_interrupt
>    ```
> 
> - SO_BUSYPOLL (no arguments to script)
>    ```
>    <script>
>    ```
> 
> - NAPI threaded busypoll
>    ```
>    <script> enable_threaded
>    ```
> 
> Once configured, the workload is run with various configurations using
> following commands. Set period (1/frequency) and delay in usecs to
> produce results for packet frequency and application processing delay.
> 
>   ## Interrupt Only and SO_BUSYPOLL (inline)
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> ```
> 
>   ## SO_BUSYPOLL(done in separate core using recvfrom)
> 
> Argument -t spawns a separate thread and continuously calls recvfrom.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -t
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> ```
> 
>   ## NAPI Threaded Busy Poll
> 
> Argument -n skips the recvfrom call as there is no recv kick needed.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -n
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> ```
> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>   ## Observations
> 
> - Here without application processing all the approaches give the same
>    latency within 1usecs range and NAPI threaded gives minimum latency.
> - With application processing the latency increases by 3-4usecs when
>    doing inline polling.
> - Using a dedicated core to drive napi polling keeps the latency same
>    even with application processing. This is observed both in userspace
>    and threaded napi (in kernel).
> - Using napi threaded polling in kernel gives lower latency by
>    1-2usecs as compared to userspace driven polling in separate core.
> - Even on a dedicated core, SO_BUSYPOLL adds around 1-2usecs of latency.
>    This is because it doesn't continuously busy poll until events are
>    ready. Instead, it returns after polling only once, requiring the
>    process to re-invoke the syscall for each poll, which requires a new
>    enter/leave kernel cycle and the setup/teardown of the busy poll for
>    every single poll attempt.
> - With application processing userspace will get the packet from recv
>    ring and spend some time doing application processing and then do napi
>    polling. While application processing is happening a dedicated core
>    doing napi polling can pull the packet of the NAPI RX queue and
>    populate the AF_XDP recv ring. This means that when the application
>    thread is done with application processing it has new packets ready to
>    recv and process in recv ring.
> - Napi threaded busy polling in the kernel with a dedicated core gives
>    the consistent P5-P99 latency.
> 
> Note well that threaded napi busy-polling has not been shown to yield
> efficiency or throughput benefits. In contrast, dedicating an entire
> core to busy-polling one NAPI (NIC queue) is rather inefficient.
> However, in certain specific use cases, this mechanism results in lower
> packet processing latency. The experimental testing reported here only
> covers those use cases and does not present a comprehensive evaluation
> of threaded napi busy-polling.
> 
> Following histogram is generated to measure the time spent in recvfrom
> while using inline thread with SO_BUSYPOLL. The histogram is generated
> using the following bpftrace command. In this experiment there are 32K
> packets per second and the application processing delay is 30usecs. This
> is to measure whether there is significant time spent pulling packets
> from the descriptor queue that it will affect the overall latency if
> done inline.
> 
> ```
> bpftrace -e '
>          kprobe:xsk_recvmsg {
>                  @start[tid] = nsecs;
>          }
>          kretprobe:xsk_recvmsg {
>                  if (@start[tid]) {
>                          $sample = (nsecs - @start[tid]);
>                          @xsk_recvfrom_hist = hist($sample);
>                          delete(@start[tid]);
>                  }
>          }
>          END { clear(@start);}'
> ```
> 
> Here in case of inline busypolling around 35 percent of calls are taking
> 1-2usecs and around 50 percent are taking 0.5-2usecs.
> 
> @xsk_recvfrom_hist:
> [128, 256)         24073 |@@@@@@@@@@@@@@@@@@@@@@                              |
> [256, 512)         55633 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [512, 1K)          20974 |@@@@@@@@@@@@@@@@@@@                                 |
> [1K, 2K)           34234 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
> [2K, 4K)            3266 |@@@                                                 |
> [4K, 8K)              19 |                                                    |
> 
> v10:
>   - Added a note to the cover letter suggested by Martin Karsten about
>     the usability of the this feature.
>   - Removed the NAPI_STATE_SCHED_THREADED_BUSY_POLL and using
>     NAPI_STATE_IN_BUSY_POLL to return early from napi_complete_done.
>   - Fixed grammar and spelling mistakes in documentation and commit
>     messages.
>   - Removed the usage of unnecessary atomic operations while enabling and
>     disabling busy poll.
>   - Changed the NAPI threaded enum name from busy-poll-enabled to
>     busy-poll.
>   - Changed the order in which NAPI threaded and napi threaded busy-poll
>     state bits are set.
>   - Updated the Documentation to reflect the enum name change.
> 
> v9:
>   - Unset NAPI_STATE_THREADED_BUSY_POLL when stopping napi kthread to
>     prevent network disruption as reported by Martin Karsten.
>   - Updated napi threaded busy poll enable instructions to use netlink
>     instead of sysfs. This is because the sysfs mechanism to enable napi
>     threaded busy poll is removed.
> 
> v8:
>   - Fixed selftest build error.
>   - Removed support of enabling napi busy poll at device level.
>   - Updated documentation to reflect removal of busy poll at device
>     level.
>   - Added paragraph in the cover letter mentioning that napi threaded
>     busy polling allows busy polling a NAPI natively independent of API.
>   - Added paragraph in the cover letter explaining why SO_BUSYPOLL is
>     still not enough when run in a dedicated core.
> 
> v7:
>   - Rebased.
> 
> v6:
>   - Moved threaded in struct netdevice up to fill the cacheline hole.
>   - Changed dev_set_threaded to dev_set_threaded_hint and removed the
>     second argument that was always set to true by all the drivers.
>     Exported only dev_set_threaded_hint and made dev_set_threaded core
>     only function. This change is done in a separate commit.
>   - Updated documentation comment for threaded in struct netdevice.
>   - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Also
>     used it in kernel/bpf/cpumap.c
>   - Updated documentation to explicitly state that the NAPI threaded busy
>     polling would keep the CPU core busy at 100% usage.
>   - Updated documentation and commit messages.
> 
> v5:
>   - Updated experiment data with 'SO_PREFER_BUSY_POLL' usage as
>     suggested.
>   - Sent 'Add support to set napi threaded for individual napi'
>     separately. This series depends on top of that patch.
>     https://lore.kernel.org/netdev/20250423201413.1564527-1-skhawaja@google.com/
>   - Added a separate patch to use enum for napi threaded state. Updated
>     the nl_netdev python test.
>   - Using "write all" semantics when napi settings set at device level.
>     This aligns with already existing behaviour for other settings.
>   - Fix comments to make them kdoc compatible.
>   - Updated Documentation/networking/net_cachelines/net_device.rst
>   - Updated the missed gro_flush modification in napi_complete_done
> 
> v4:
>   - Using AF_XDP based benchmark for experiments.
>   - Re-enable dev level napi threaded busypoll after soft reset.
> 
> v3:
>   - Fixed calls to dev_set_threaded in drivers
> 
> v2:
>   - Add documentation in napi.rst.
>   - Provide experiment data and usecase details.
>   - Update busy_poller selftest to include napi threaded poll testcase.
>   - Define threaded mode enum in netlink interface.
>   - Included NAPI threaded state in napi config to save/restore.
> 
> Samiullah Khawaja (2):
>    net: Extend NAPI threaded polling to allow kthread based busy polling
>    selftests: Add napi threaded busy poll test in `busy_poller`
> 
>   Documentation/netlink/specs/netdev.yaml       |  5 +-
>   Documentation/networking/napi.rst             | 50 +++++++++++++++-
>   include/linux/netdevice.h                     |  4 +-
>   include/uapi/linux/netdev.h                   |  1 +
>   net/core/dev.c                                | 58 +++++++++++++++----
>   net/core/dev.h                                |  3 +
>   net/core/netdev-genl-gen.c                    |  2 +-
>   tools/include/uapi/linux/netdev.h             |  1 +
>   tools/testing/selftests/net/busy_poll_test.sh | 24 +++++++-
>   tools/testing/selftests/net/busy_poller.c     | 16 ++++-
>   10 files changed, 145 insertions(+), 19 deletions(-)
> 
> 
> base-commit: bfe62db5422b1a5f25752bd0877a097d436d876d

I have tested this again. Not sure what's appropriate, so I'm offering 
both tags:

Acked-by: Martin Karsten <mkarsten@uwaterloo.ca>

Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>

Best,
Martin


