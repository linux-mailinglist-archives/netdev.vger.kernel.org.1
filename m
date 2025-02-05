Return-Path: <netdev+bounces-162818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7BA2815A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07CF3A03EB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD725A63B;
	Wed,  5 Feb 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="4yJIrkLX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580322071
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719236; cv=fail; b=esieme9DwwhSgwq+v5yovAs8DHwUpmPCceH/Y7Nbcv89Rp2RzBDX6/IC1Q86KWcm4T5A45YpyiAfJs4d2i80S4uowFsbdBWJPXke7lohTXaFTLQ/PDlRZb1UOuQ2Y0qbHkN90HezhSIlnhRsorFNZpt545xoGdBK4FLOZD6jVAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719236; c=relaxed/simple;
	bh=JsHrYhaTM9Q6p/GW37P87Pk+tMlP2VQnPSzxoCXjq/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwqTYUqNH7xFqYyFC+HU6SdLNfWhnWU9s43OAB0cD1rbF+Y0yF9e78WUTEbWxR777cbWfLz9r8MnopBryHCjaLw5vbUl+g7snowKetBVisnJR2j7usQg9/zydPUSVtHw4un7eYhlApNsatwl+OwcPirILDZNIn+yLqXxvQV6Eq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=4yJIrkLX; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1738719234; x=1770255234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JsHrYhaTM9Q6p/GW37P87Pk+tMlP2VQnPSzxoCXjq/w=;
  b=4yJIrkLXeopMW67Jpz4qe/Uk1OE2/59UqvIfL1X9fyfYIF+sjmupZVbf
   p6mwmB0r8loutZ6WaQL+ApZz0VuyT0Y5aZaulMyOsaTYocJ1D+UBE8DhK
   zN3RehlzUql+58OgB5Ub9S0kw3ovT6uu3M670YIarJky3aeN1Xt5F9TD+
   8=;
X-CSE-ConnectionGUID: 8ihiaf0MRye6mgTPLF+g5w==
X-CSE-MsgGUID: sSeaLiriS0+e/1f1winDqw==
X-Talos-CUID: =?us-ascii?q?9a23=3A+yZlxGgUPpOjLoRFR8Ovx/zcuTJuInzdzX7ee2q?=
 =?us-ascii?q?CGGs3TbKpcXu+u6w5jJ87?=
X-Talos-MUID: 9a23:HRgppQpyIi0BK2LJb+sezypZOc5M4r6vMxhOnNJftZCbNCpcIijI2Q==
Received: from mail-canadaeastazlp17010005.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.5])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 20:32:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWjyYHHf//zAUGqWqKkF47bcHl3zNnEf35/g9eAbaZtiW5gaaXqMn/BrnnejXT5i0DaHhaLGlodpdbweaMuBaSUi+TNl57uH+4GCim2X8sCsKOIIZUBwEqpL2ADMvvTMFBoei/xQSN3P4xaQst3qjH+ctprZYtUIex6ow2HEFGFk5/IP/JdeHNhlXjnwZRwqgXZUYziufFwTndWf00g3retDv0Ddi1jMLIhVR/N6HtEtIUsEMppy9BmiySVSZB5+BSGi70rbEgrUnyOtE7Tbue1Mk0gBwdii+jvv+G//v90IMTdLCq+WDgME1z4hHO/q74umbouMmtINPb1l3TyBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LHn6tydew9f9IuvtzIrDk4i3N/eQdElGvoQVVSnJf8=;
 b=OTmt78zbKELGBTXdBx5BJb7I5ErK7SV5Tm7xKILAwtNyEKQKsqDqeps0efnjQjzaPfshRqtEEITmecg2VQCycmh+k3utM+/BDKqdKUDl9kCV8IjZf1ipMdRTbXwRXaRLQrVFrH6hGZSTiIyNV5if4l+mAzyc4VrIr/2x12vznqG7zgeG2OVHkmwIuVWEC1RHXEN4qBUMHw1hTavoFyvfFSxog/g0TgNsUuveg5BJQ44muHOnRCPSjRZjecClhWdzmNxKdIdw1Z71Dqpwm068PWMyjtmsnXJ51x3/eEdGpxNZi5/76tD8ShBpVKEb1BiEx46tXxXJ0yX+G75hjcLyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB8356.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 01:32:42 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 01:32:42 +0000
Message-ID: <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
Date: Tue, 4 Feb 2025 20:32:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>
References: <20250205001052.2590140-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:610:59::34) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 548a516b-cbd4-451e-b4b4-08dd4584fc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUlpTDcvcEp1QVN1SFd6M0FtWUd0ekhSeDFZNVM0WTBuUXdlbFJkT3BvV2JF?=
 =?utf-8?B?STdzY2ZhK0dhaTlPZHVNOTdVMTZSdng4RVprOFBvYmQvNE83RmxpeFo4dEEw?=
 =?utf-8?B?N2xSQVZ2eklWbEtFT3NmZHhSa1lrZ25SbTZHMGdOeTZZUE9ta1JVNW50cjB5?=
 =?utf-8?B?U0JwaHZmSTlubnFEZDdYVmo2cGxHQkJycDduMmZIc2F4U1FaNjNHQm1SZm5P?=
 =?utf-8?B?dUtDak0yR3BYMXZrWGVKVWV0a3oycC9vUjRIemppdnFUMExqY0h2SDRzOStx?=
 =?utf-8?B?U29NVWEydEVBYWU1VWhBRnpsbUFYbTZ0WXkzSHRrS2owaG41MmQ2eXlWaE9v?=
 =?utf-8?B?S01xb3laMzZZRGVUQzA2UlF0UFlaL0RlYXJraGsxWDBGdXZQNUQ5Qkp0eGNF?=
 =?utf-8?B?ZlVPSGpmY0hZN1l2ZGthYnhLZnBuOTlCS3pHWk9SK1pSU1VqVXBrUW1UZVZx?=
 =?utf-8?B?dWttR1doUm9yYnlDNURqWWxPUVMwU29OVndMWkVQZUNwdmVrK3cvdm9GVnJN?=
 =?utf-8?B?WFFwTG1PV081L013aktCazZZT2ZIckxpUEpXWWVuWXkwYlQyZ3pNbkl6NFY0?=
 =?utf-8?B?bzZDZWo2Z3hwTjZhd0NrVGc0cVRNTFNPNlJ6R1BMNGlrdUtSNWRCcUZBRWxr?=
 =?utf-8?B?THkvMW51V0xFK2lKdkJSWlVGa2ZDSzRtdmR0emhPM3ViVm1kQ3N2MCtGNGNI?=
 =?utf-8?B?T0xPM2U4eFVoU1BHOEpYRVZ0cXJpTGpFb2ljRGo3M1pKVFBTSi9Mb1VtTU0x?=
 =?utf-8?B?L2dFa1BWaEU3S0JUTUZCWWpCa0g4d0pXRWhuUC9VVkQzQzV2RE9oT0xPblJm?=
 =?utf-8?B?Tmo5MnhZWjZBUEdqU2p3NGdzYWpvbnNBcmltM0Q1dzFLN0hrNXVQV2xaVS9l?=
 =?utf-8?B?UExNUkg0R3h5RUw4MnJFQmd1VzcwUjRnM2JaYWs5eEtZcnFsYllFZUZXZldR?=
 =?utf-8?B?dmJNenlDdVFjTVgrajlTalNzbVZaU3NLb29Qc2VpVlhBc2MzNnlXL3A4NFFR?=
 =?utf-8?B?d3pIVUtBZ3RQdzNwRCtpamxIWkZqS2V0SzVhVE51eXNjM29VRGlaTm9Dbktr?=
 =?utf-8?B?SmNQdUFaU2lrd2VTRjFLTVV0Z0pPaFp2TTRPSzgvdDF5S21rTDB3cFl0TzJ2?=
 =?utf-8?B?VnMyMWkvM0R6MEE3TG1wWFEzOGZKeTBjWUZ3VVZrcEp6cmRGWk1Ma2pFL3Ji?=
 =?utf-8?B?alpONlYyNjZPQ0pKVlZ5dTR4aGNWaUR6UVNvTFNLczZwY0ZMU3VPMU5JV2dY?=
 =?utf-8?B?SGJidjJuN0FTblFLSUpWWTZLNDZxQXcxNmFYM0xLVWlWRW52Q29DTGd4WVIw?=
 =?utf-8?B?YW5IcG5QU3FWM0NuWGdHODNiZGZBSjNGeDVqY1ZWbW5jZ1V5N3A3NVJDVmxr?=
 =?utf-8?B?NzUzOVF4LysyWmNqTFArU0pySml1cU16aXZRckVaaGpzL2VjZWJLblBlSWNP?=
 =?utf-8?B?clpvZjdyK3dsczBJalRlZUZYMWNtOEwrNHhMSmgwa1AxcGVkdnAraGVyd2E5?=
 =?utf-8?B?ZXhCcEN5NzZHS3hXVzFGaHExZ3gxV0dKRXF5cTdrMDFmd1l6aUExQVp6U016?=
 =?utf-8?B?SWdLVnVjZFdpUlVDbW40cHNXeUVLZm9WbllURE9wZExYVzdnSm5Nb3pYYXZ6?=
 =?utf-8?B?VFNLY3F3eVcxUEt0elhhKzQ0Y3lPMUVta1VUcTlJQ0xkU3llT2M2OGhiUitp?=
 =?utf-8?B?VldiOTFzWTB3Q2lSdjJuQjBKcGkwUnhDa0Q0cUVqakxkbVlvQmNJTzNOOXEx?=
 =?utf-8?B?S0g2LzU4RW02NjA1MityWnZ1bldCNzJyV0duNEN4b25KTDFzU29MVkJkWXBy?=
 =?utf-8?B?dlBWekF6R3duZ0NnN3pKTWdNQ3JSd0VLSTNsL04zM1VGMG11ZEMwWXRrd29l?=
 =?utf-8?Q?LduAF9u3BV1QO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzlKNjN0NFpIMlA0TElITnEwZnFKRWh5ZDRqQzZjUUo4VGdyb1EvOWJZeWRD?=
 =?utf-8?B?d0JRREVqa29HMG1LOVVwTnY0T2wwc3ZQSEx5Z05uSkFtaExEeTVHVld4SkJ0?=
 =?utf-8?B?b3pCL0NtUXBLSDNYeFp5aWo4aC96K1d1eEtWYy9ydUp6R3Q0ZFR6NjlGREFQ?=
 =?utf-8?B?VENtd2hqbnB6c2RCRWpQTEpva3I0MzBxNGpUYUVwczRwa1FPMVE4R0RLU1gy?=
 =?utf-8?B?RUwwN2tnaFI4ZkFxVHQ0Slh6QXAydGVKNUcxYXFRVyt3cm5oUmxmYXdLb1hS?=
 =?utf-8?B?NEFrcXEvaGwvK2JIWHUrR0FsdDQrQVd0Nkl0OUNRZmgrS0dqckdxSVV4UWd0?=
 =?utf-8?B?cVV1RXZnbEt1WlFqZHB2a24yVUNtWnMzL001bWNQQitFbTdTWVBmRnptUVc5?=
 =?utf-8?B?Q2tWZ0toTC95M2hJNFRDMlI2VXJPUnF1YWNkcGtxdXZTYkZtdFFjZ2NaM3Vk?=
 =?utf-8?B?dDE5RmJxdXc0K2ZzZU9WamhyellwNTdiNFZvb3NmcTZOdXlGNXlIU2FsTHRW?=
 =?utf-8?B?SVVjcmF3TDdHZlJtYzdzb0pibU54SkdhYllIeVRqMUVXRERqUDliZ0IyOTM5?=
 =?utf-8?B?eUVmcjY0QzVYYkwyajdncE1YOXhyWEphZGlIQldwQUg0KzZ3WTQ0NCtEMk9M?=
 =?utf-8?B?d05keEZNTzR2NVRGS2sySXVYbEJLMFgwWnltWUYzVHNmem5hSkhsL01WUlNL?=
 =?utf-8?B?L2JURVcwUkI4dk9qUnkrbjJ2aGJiemtEdi9uTzZ1L3BuendmejdFdGNZTllT?=
 =?utf-8?B?RDBlejVwS2hoK3NMc3d3bWRWbEgyQ084U2dodURwSXMzb0lmL3BuV0tVUGJT?=
 =?utf-8?B?dGkvdUYxR05ZdGdOU0Z0S2I1b254YUpUcFBKNWgweWMvMVk3QlRzY0NnVWRl?=
 =?utf-8?B?WmQrMlJnN1IyVzBnblhZT1B3OU1aU1prNUdEVmNPZjhxYXZMbFpnZzRMUEF2?=
 =?utf-8?B?ZE9IbmVjMTEzU0hpUHptMEpRcmJ4UEpjLzZsc3Q5R0hiekdZWkFydTBJc2VI?=
 =?utf-8?B?OEFhNERHYWlIYXN2SmpoVERaUGpQcE9ITk53Y0lyaFQrd3dsQU92b00xMU8r?=
 =?utf-8?B?ZXdpdWhvb2RsQ1lXMXFqOUVoVEtJeHRwVUF6eUFmUlZVd0FoOE9nUFNsMXI2?=
 =?utf-8?B?MXJSZG1lMFQ1TXZqZkhIaUx5bG4zd1NCM3cwa2JSSmtqdDdCWHlPNXFCUUti?=
 =?utf-8?B?UDE2OUdMNC96S01RQWlXWGVwR1QwNmYwMis4dEthSG9GWXlvN3VBS3FEM0NB?=
 =?utf-8?B?M2xXWGZXNG9kbVZack1nZUtzWnJQNzJXUkJ2NkxXdEVhVkZ5d2wrN1ZVOUNL?=
 =?utf-8?B?LzEvZ3RXKzQ0K2RGNG5tdm5FT3hZamRVai9zdlVXNHI2aWZ0SUlyMTVRbG1q?=
 =?utf-8?B?Y3N4NmxpajZUWEVaeVFxME5OcU9pYktUU0l3WWJtcmZSSFAyOGZFb0ZVTWIr?=
 =?utf-8?B?a2tUejJBQ3NDVEtZNExNS2xpdU9IdDN6TW5NZkVOVWM5Wno0RHJad2M5Mm13?=
 =?utf-8?B?Vm90UXpwaTdVeEo0OWNCaCt5TExSbExRQ3lDaGZUZkI4TTlVbk5iKzQ5VU9G?=
 =?utf-8?B?WTRxcmhrSVFBNXpiclJjNHM1bC9KdVY1RXB2UkVYRnVxUTJWNlhudFhJcmwv?=
 =?utf-8?B?MDdkTitQMm1FWnJxWmVxYlg0MW9hNGgzeWRnMTEyTmpEM01aTytOdFZwZmM0?=
 =?utf-8?B?bjdkZkhFUzVEb0xKK1pNTTFzenBwZUxweURrS0hQSUtRZzg1VVN4SEZ1TUFE?=
 =?utf-8?B?SFQ1TmRZTGJ2RkVCKzlOSFp6ZlZYcENVVENpTTFuVlVtWGhaaTZ1WENRdlVE?=
 =?utf-8?B?UFlSeENPM3lESGtkZ3lqWUpyaU1NUHYxS3lMNjd6MGZUZERJRlRINEFpMWY5?=
 =?utf-8?B?U3M2d3U2akVPejFYMVpWMnZLSDUyTHJjVGhLSE9ON2txbTNGVVVQNXIyZWZr?=
 =?utf-8?B?b2ZzNHlpU1cvZXhNcFZpYTMvN1g3N25pbDhwRFJnSzRmMHBrcU1OaVFSNUVO?=
 =?utf-8?B?ME9ZY29hNklRMXhEdTA5a2Vhakh6OXhwNWxIbDB5VHdvdmVjZjVyWElNOWJo?=
 =?utf-8?B?c281anZIYXlibmtvNVBrZ1pCMGI2RXpLU1BucnhTYU5zRkZnZE1ZVXZVVTVW?=
 =?utf-8?Q?2v+uim7hA/YD0i1xYzsA4OGJf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sSN+3/2jtSmQcnmXzVjOmV+PdKILHc/3j38VM79KbjAWBqqtuy2tmwDM5qmHRcnKPDlrZCj6VsimLH7XHyUdnRXGnAxjEB0pzG1IYCA/GO3yf20r4n+DN5igmLqa/bt+TqjoBSIFWzbklsOOwnnpO420tVYijwQbRDwtmAsO5Y0tl9PC8fs02L5Yqe/s4kfidbmaG6zKf26+K3w12IuElD2OeDNKOkE418fUZegEs05ZJJ9Se0g96IMeddMUUqk9l94BEEVHg8O9tWUNLSmL1woCnvQqBfUsw9FqZB4a1dEEzjmGHlU5/k5ebPkAsN9bS56wNBsuTw5JC/ElDU1aWjg26Y4An85lX/igUxyugl+iqoKBBYRmnU0oYuQVAMtu0ZC8br8qqunE4Rn5J2a6KgmAM7bKvhshQhrjqyPF1MHC+WRMFlVheFfMbysXIB8Xyf6GXle7c+X38c1CQkhECh19tP+ghDqnuv/0Eqn2M2XY6A765iv2RyyBrVe6k/pRCduOGnSm3QbxbJrMf/gHVN37cuJ26CZHiJClCJx7DIaNsub9GmaZpeGwQQyubNzM5ne00bPRlEu7YYB33/2q/rB9QT7rK9U4UIZkMLvX7ZfLb5m4KEPSW4hA69QcvOhO
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 548a516b-cbd4-451e-b4b4-08dd4584fc3f
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:32:42.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwRE4imvmItGxc6UYJPe2Q9dv/UF1/rkhY5CqovcOkPA5zOZ+aXDV8V6KmAy0vX1I4UFu1ny+L9N38ifDDTDqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8356

On 2025-02-04 19:10, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.

[snip]

> Setup:
> 
> - Running on Google C3 VMs with idpf driver with following configurations.
> - IRQ affinity and coalascing is common for both experiments.
> - There is only 1 RX/TX queue configured.
> - First experiment enables busy poll using sysctl for both epoll and
>    socket APIs.
> - Second experiment enables NAPI threaded busy poll for the full device
>    using sysctl.
> 
> Non threaded NAPI busy poll enabled using sysctl.
> ```
> echo 400 | sudo tee /proc/sys/net/core/busy_poll
> echo 400 | sudo tee /proc/sys/net/core/busy_read
> echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```
> 
> Results using following command,
> ```
> sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
> 		--profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
> 		-p 50,90,99,999 -H <IP> -l 10
> 
> ...
> ...
> 
> num_transactions=2835
> latency_min=0.000018976
> latency_max=0.049642100
> latency_mean=0.003243618
> latency_stddev=0.010636847
> latency_p50=0.000025270
> latency_p90=0.005406710
> latency_p99=0.049807350
> latency_p99.9=0.049807350
> ```
> 
> Results with napi threaded busy poll using following command,
> ```
> sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
>                  --profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
>                  -p 50,90,99,999 -H <IP> -l 10
> 
> ...
> ...
> 
> num_transactions=460163
> latency_min=0.000015707
> latency_max=0.200182942
> latency_mean=0.000019453
> latency_stddev=0.000720727
> latency_p50=0.000016950
> latency_p90=0.000017270
> latency_p99=0.000018710
> latency_p99.9=0.000020150
> ```
> 
> Here with NAPI threaded busy poll in a separate core, we are able to
> consistently poll the NAPI to keep latency to absolute minimum. And also
> we are able to do this without any major changes to the onload stack and
> threading model.

As far as I'm concerned, this is still not sufficient information to 
fully assess the experiment. The experiment shows an 162-fold decrease 
in latency and a corresponding increase in throughput for this 
closed-loop workload (which, btw, is different from your open-loop fixed 
rate use case). This would be an extraordinary improvement and that 
alone warrants some scrutiny. 162X means either the base case has a lot 
of idle time or wastes an enormous amount of cpu cycles. How can that be 
explained? It would be good to get some instruction/cycle counts to 
drill down further.

The server process invocation and the actual irq routing is not 
provided. Just stating its common for both experiments is not 
sufficient. Without further information, I still cannot rule out that:

- In the base case, application and napi processing execute on the same 
core and trample on each other. I don't know how onload implements 
epoll_wait, but I worry that it cannot align application processing 
(busy-looping?) and napi processing (also busy-looping?).

- In the threaded busy-loop case, napi processing ends up on one core, 
while the application executes on another one. This uses two cores 
instead of one.

Based on the above, I think at least the following additional scenarios 
need to be investigated:

a) Run the server application in proper fullbusy mode, i.e., cleanly 
alternating between application processing and napi processing. As a 
second step, spread the incoming traffic across two cores to compare 
apples to apples.

b) Run application and napi processing on separate cores, but simply by 
way of thread pinning and interrupt routing. How close does that get to 
the current results? Then selectively add threaded napi and then busy 
polling.

c) Run the whole thing without onload for comparison. The benefits 
should show without onload as well and it's easier to reproduce. Also, I 
suspect onload hurts in the base case and that explains the atrociously 
high latency and low throughput of it.

Or, even better, simply provide a complete specification / script for 
the experiment that makes it easy to reproduce.

Note that I don't dismiss the approach out of hand. I just think it's 
important to properly understand the purported performance improvements. 
At the same time, I don't think it's good for the planet to burn cores 
with busy-looping without good reason.

Thanks,
Martin


