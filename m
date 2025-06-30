Return-Path: <netdev+bounces-202645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B5AEE764
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9293A7A5B93
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615A1A3178;
	Mon, 30 Jun 2025 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iggQb9vb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69519067C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311167; cv=fail; b=S9GqmCeknzMUodnME+dTThr5Kxq75/w3Or3PPwL590RHjUkuAOM/sdj7KJB3yY0vStEoj4uZKLdoQzQjDfShjfCMRaDVjAZ/rs+ErTG/jqDtcR3iLcoCxkyyrKzIf6EAoBWDTFsqRcIkF5ZLA1MuOdtzG4hKBOEIoK5TIq8QFZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311167; c=relaxed/simple;
	bh=wtYFEp+ibYriG1YH7js94QsNVkd9FlFBWrKp7vu7p6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pp12Mg/DKCsoIAOA1SxqQiQcqNCDqdl4tuZTasmAtgIoBrz6R18AwR9+yD5gsSU6y5/v6zN8BNNYuhkTrSTDyhbgaM6+KEOZmS2SGebMTfbKxCnlkjfDxI0rOgEnLyuoF2eYouVyWbguShxLHCZDpGruFvB79VZpUR9dw0QSxhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iggQb9vb; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1qqh46P5Re3G4/21hO4DFqpVlKV+Gr0yVN3ra3sPLrfZeOGLy7c/BL/IeAgWgJdLQPOl9MHL0E2IeFRNqbXRm3anet67M7BvBLd7HsOh0yUE674F0GTyCmiGE+3Tro+K/nRJGHsjmA9psQVjndVU8VzPxx/JgwgA3zcMrj4ldkbiRvEiZMsmtWGggnSsSwZGaomQacB4uI8jbGd6JvTv71U+Yt4wo/Vghld1JSW0gM+BDA/FubrBYO18pP/CQSeeLhZ4wPjnTOKryjk5sVkFx2ZcQ09NO105mZ9hjhJMRfbRBj7DLza+I3Na+kAqQTIsqQCEFWmizO4SXD2EHko9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEgVDKRqCTr4pICXTVVEbpzS2X6Y5etGA3T92wgy8yo=;
 b=O3jB1se30nwsqHCoqDHiEu7Se2TOm6C3Gui2eRsaY9kNQqcw7H6R8um0Wf61pRd2Vvd4L+zVK4cc8whvVpDWx4Pl2h43r7UR2Y9Z0GhvOyaADEoOtvyedzRpoxAbGuQBEYgQ2wS9UzoTDdL7gUj3Y18V07PklKsPJgpRfYJcX9gVA3A05zHOxA3TlMgeUXpdVY8XlsDh10Mhesx+8gNC0ES777fGhxmIf4RCY5YB2W6CUt/qCQo8poy4j5gqdzXw3HAdjFUQfGrSMQtCgDbBbEiGJUDwuDBCJBqq4ucdIOnGGOh8EPFH2BwS+VpKPQ+cOuwT8RhIUQj13EX6d+BzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEgVDKRqCTr4pICXTVVEbpzS2X6Y5etGA3T92wgy8yo=;
 b=iggQb9vb+XKWoRVA/RK9eReTAOq37oxvg8U8MvxB5eCVmjqoWktJQVE++J9WTuUY6fdjZJCh1PRUemQL/dpuzQpffv5djDKZLTHl6zwG00pXxiCBVwlZ+QBd2cPKorHbW5+eCcZa9eue2UHlJdOQl1jj3YtdfhwvUFAQ+y7tOgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 30 Jun
 2025 19:19:23 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 19:19:23 +0000
Message-ID: <b9f6ef83-5bca-42e6-bc32-865c667e7e5c@amd.com>
Date: Tue, 1 Jul 2025 00:49:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] amd-xgbe: add support for giant packet size
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250630152901.2644294-1-Raju.Rangoju@amd.com>
 <679e9678-8c9a-49ea-87a8-a38650a82e19@lunn.ch>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <679e9678-8c9a-49ea-87a8-a38650a82e19@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: f59160f9-b8fd-4466-7ee6-08ddb80b0546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3A0WjVzZlMxeFk5RnNnZCtHK2xCdjBscXF4WW9ZY1d1SUJJLzNTNHFjSkpZ?=
 =?utf-8?B?SUloWDBtcE5tNXVyU1RKUDg0V0FIY2l2Z0JGRThMMkZVMFFZMnk3MVdDY1Fp?=
 =?utf-8?B?MTVvSmZIQlgyZ1pTTFRsVjJMOStVaVNBVjRzdDlxZEN5eldDVzlQT05CaDFl?=
 =?utf-8?B?ajhHTENUV2N5NHMzNnRRaTdxU3duRDl5MEZzNlUzNDk5Z0xZSXoyN04yTkhK?=
 =?utf-8?B?Zk5wT0tRSTgxTnJzZEdOaGw0VzRyVHZkUXA0K0FpbWJQTUhLM3J0SFp3V09j?=
 =?utf-8?B?bExTdHA0c01TZTd4V0RWb0RLZitkYkdKQlNiN2F0NjJaaCtiSXgvNThYOXJR?=
 =?utf-8?B?TEVzNENoeVJHOWtMNHNVN0JSZThhNHJiLzYwOHpGK0I2YitaS2Y1ajU0UDhy?=
 =?utf-8?B?V3FwYlM2MzFEeEI2SXVkWVl1dmFDdlUzQ3VYRU53SkVPM0RSdG1LYk53ZEVn?=
 =?utf-8?B?eUY3SDZDWnExNnhrSnc2Ukk3T0lIa29mN2lLUDV2Y0dIYVpkMTUzdVl1MzZX?=
 =?utf-8?B?RFdJbW9BQjFIbjd6dVF4T2NrYk5JczRXK0d0UE1RYTI1MWFROGkxU21iQS9V?=
 =?utf-8?B?YStKL2RmRFZ3SjVMUmxTeEpqTlFpY3lVb1NxYmVkVjRwVFdhRFNpeUQ1c1Ja?=
 =?utf-8?B?bTZSeHIzKzc2WVFpeDVSK25sN2pZaTl0bXhYdk1WQnlMUFlCZWhDSFk1bTJx?=
 =?utf-8?B?WU1xZFpKK2lJRXFHRVFaWVU0R2NKdmdZbXJacnNFTjl1YTNKdHM4VkNGVng5?=
 =?utf-8?B?RkhIeFdOVU5jY29GaDBRSW1nKzRFSUIrOUl3ekZiSUY1aWk4VzRKYlB2M0lH?=
 =?utf-8?B?T2dJZFZvelYwTW5wSFBYSXV2M2dUa3BLSW1UYnovOEdpYnRvRzBqSlZlNU9Y?=
 =?utf-8?B?b1lONVpZOEZsVVBRZEtTaEd0bjlmMG52dVdTeEExemwrem9CRkxxYlR2N2RZ?=
 =?utf-8?B?ZHNSQlBTNDJNZUhrcGsranBQMHFPZHlpMFZJNy9mQUZuekE1U3FvcUdVOWFw?=
 =?utf-8?B?T24rdVRabTJLejJhbDc5eXlSRzUyU0ZjcUFpcnY5Z2NOcnpYOHNiK3cwdzVx?=
 =?utf-8?B?bDlxMG9SUkErVnNEbElPM0lJVU9Ec3hITGY0UEZMVnJmOXA5QjRCSWo3S3ZE?=
 =?utf-8?B?RVNhK1ZlNnJEeWRwbitaS2hjMWQ2dE05cVJxenlYN1BhaFhVQlJMaHVQa2pY?=
 =?utf-8?B?NHFIWnFydW9vVWh3cU8xMkZ2YzVNL3JFdlY4cERHUjh6S2N6Ukk3VDJXZlR3?=
 =?utf-8?B?d2pvcnBXMlBqU3FFeGFaS0w0Q3BObnJpZk5xYi9kQjExMk1ZMGlnd1dLR1Bk?=
 =?utf-8?B?d25EZ2Q2aEIwTzVBZTd2ZThSaDM2cVRHeDUzeFFSY0poeEcwc3A1Y0RQL1Fj?=
 =?utf-8?B?akdvRHBMcXNBMHFNeE9BYU43RDY5OCs0TnFrOU0rY01DTG1BcFFzYThhUWhm?=
 =?utf-8?B?QytqSWVlZXZJNnZzbVpDM2NhTWdWWjRveUJKcCtNS28rd2JJSEtBVGk4TG9G?=
 =?utf-8?B?SEJ5L2JvdWhiYjlJOW5idGhrTy9USU9MOHJ2cVNWeHZrZStQa00wbnArdm81?=
 =?utf-8?B?clBwSTRRMWtqZkZ5UWxLaUUyZ3h6dVBVd3FmcXIyanBjSk9MRXJLeVU1SkM4?=
 =?utf-8?B?ZmVWYVpLQXRUdFdReGZ5alBZdWRjenVvbldjckh3QldvRE5EekNFaWVYenVY?=
 =?utf-8?B?UHZlbTNma1BYLzgvWWpja3dSOUcra3JFSExYM3VReGVEbDVuZ3psR2NlaFZz?=
 =?utf-8?B?Sk1mNjc2R253enA0YUJKcXF6WXJFVlA2RGxaU3gyS01CZ2ZLaUhPZWJpZllu?=
 =?utf-8?B?MUZuK3BYOURCUmMxU3p1eGsweFZ0S1hUaGV2Rnc4VitBa2Y3T25zTUM3eitN?=
 =?utf-8?B?blRhRFJLVExyZ3gvQWxaa0lqQm43ZFNLMUl3b3dSTHV1MDJwRi9kUHhXcW16?=
 =?utf-8?Q?Kbor0+y0scE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDM0WXU4T0ZqcGhtRWpSenczSlg4SW5VQ29WMDg3dHBoNm83VWFidnAwWHd1?=
 =?utf-8?B?aWRxeEZUODFQd2pmdnF6VmNHUS9CKzdnV1RwdXdOVkFaaVlvdjUzNzdCT0ds?=
 =?utf-8?B?SnlFMEpHZ3ZNRzZtZnZnMjgzRzI1dHdZM3ZrYmZtNUprbzlkdkZWaURaY3k2?=
 =?utf-8?B?RjhCVTJPbHlxdVFPTXllQS9TcWFhVUYvOVhIQTZTM1c2Q3IwcjdzWjF6WDA5?=
 =?utf-8?B?bkQ0MDhJWHV5aTZkdElibENmNlhIbzJsVEhpeEh6VGVKRFdjNk45SzhKOE5h?=
 =?utf-8?B?VE5zNTMxdkI1WVRXSFhaeUNpTCtEaHFzMUtDaVVId090UkZVT0c2cWV2M3dm?=
 =?utf-8?B?MEhWa2tFMkFxb0hockdvNmlrNU9qTk1qR2hmVVoyZDk4c28vWmw4czlYb1E3?=
 =?utf-8?B?SDNMRCtaMEFLOUVNbEppTHpXZHErMGZYaGx3UkI2dWYrWlVmM1ZNL0F3Z0Z0?=
 =?utf-8?B?MGhxWU1rbzZtS0NrUWIzN2ZCZ2VLaWtmZG5ENzdaNUFyTFF3dVROTlRFWExo?=
 =?utf-8?B?TVZjUktGekNCbHZCRkdVdnRjdzl5bW9MclhjdXBldCtmRGQ2QkhmSWFDaVVQ?=
 =?utf-8?B?NkJPS2ZxS1czT2JFQ1VRRExwYVVaNFFnNDVidUJWV1pDWXI1N1poM0J3MndI?=
 =?utf-8?B?R0FtWmhsSEtXR3JYRWx0M3BMd1RnS25PSjhsb2FCUjFUcC9tUTdLSldad3Jt?=
 =?utf-8?B?SjhNUVBtYXdRcVJZTlorYzV5V2c4a2tqVktDbXFCbllETkJjZU1QV1N5ZElq?=
 =?utf-8?B?K2tyNlZxeHYrcXZNL3RaQXZzSyt5UUswSmhURStMSWZscGx5VkZrRGczeGpj?=
 =?utf-8?B?NU5QV09JenJhUDR6WkdUWFR4NHRJaHR0VlowM1JIbUxWMGRMTDBUVUJ1RGNx?=
 =?utf-8?B?S1ExQUI3NW56QnV6UXNyQzY2cWpzblhXSEw1TEpMcmhwWXh0NVZmdUlIRlc1?=
 =?utf-8?B?U0hPS01kQlhmYkcvNVFwZGNWNXRvOVBBUFdIRENxaGVrUXFJUzlOSjJpNFI2?=
 =?utf-8?B?cGRyWjZUR05BWUUyUjZ5aHJiSXhuS01vN0w1Q01kUjFIN0paU0Jva253ZGM3?=
 =?utf-8?B?d04rSk1yOVBDWXA4K2Q5K2k1emlibXZscnY2eTlEMWU2MEZaZTdQZFJzNXFn?=
 =?utf-8?B?NXorRUZXNnRLNkRsYkthdFlrVzN6TUk5S3RNNXF3MzA4VjFPNGFnK05DL2p5?=
 =?utf-8?B?am9peGNxUU9sbDdXbzh2U2xQejBYUGp0QUlNZHNvU2t0U0NwMEZ5MkxFNkNF?=
 =?utf-8?B?STVSb2dHZ2NIdXRDMFdmdlJKWGF3VTZsdkpmanRhejJCbHFGSEViME9rdVIy?=
 =?utf-8?B?YzRBR3BDd21ITmgzRzAxWkZnNXM5WjY4d3lCZGJneXFnWUgvV0laWlJhdldH?=
 =?utf-8?B?cE5nZHVzTVVUVHB4WTZleVJDdExwT0NOeUIvWjNNMXAzTmEyZlJNQVJMbHJS?=
 =?utf-8?B?SlhZaHJxN1ptR2FTd3h5cTd2am82cWkxNUJuZWZWLzZrWWlYWVZDUStrZXc1?=
 =?utf-8?B?dWh4clJDMXYwVmFCa1ZDL0FEWDZDZW9KWkZPWUlVb29EOS9paUlhaVd0ektW?=
 =?utf-8?B?N2dGUGlIWkVMdDJtR0IzcFo1MjFmRzBwbktwSUFnWGpWOGVkSXEvZUZBM0FS?=
 =?utf-8?B?SmlSNy8rNDM2MDVDYjZRTnBrekNNY2ZEOHB2YmxEdlYyeEdRbXlqazR4cGNy?=
 =?utf-8?B?cGtjczd4cEJJMTluamZ6b3RrNURianEvWDRQQTJrbWpqaFdma29CbjVHeHZB?=
 =?utf-8?B?NXJBMUpkb3FHRUFKZVk2b1NEakJUQzFOUllvMHdvQ2djQis1cTQ2RnpzbzFP?=
 =?utf-8?B?eHNlUzY1S09SUkw0YzljSDQvSzRZanlsMUNYZ0xnVzB5dDYyVEVrczR5cnZB?=
 =?utf-8?B?c25na1l3M29KTDVFd2U3QTFJd0ZLbG5Pa3NzN095Rmpic25FYjRLRm9vWEZV?=
 =?utf-8?B?N0lxVnVaWFdPRnJkS0JVRUhpUVZwVi9nU1RBQVp1dEFhWHAvU0UvMGhJdFdj?=
 =?utf-8?B?SS93ME1YT09xdHZIRUk5anZMVlZkaFR6cG5WSUdiQkUxRldrcmhIczR0bTY2?=
 =?utf-8?B?S3ppaXhmZjZWNmM2Sy9YZlY2QUllY1BRUFROazM1WlJsV3BQS2ZScnVUcUYx?=
 =?utf-8?Q?rInMA4WcOzptn1XSWWTTOsZnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59160f9-b8fd-4466-7ee6-08ddb80b0546
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:19:23.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWXVy/bAn+l7ccHrnSVexjrv3RuJ1Zl1FE8Wtx8x9aGevy87WbGhbPY9a8jBqjpfQ8DFSXnwrfKpKvb34LVG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284



On 6/30/2025 10:17 PM, Andrew Lunn wrote:
> On Mon, Jun 30, 2025 at 08:59:01PM +0530, Raju Rangoju wrote:
>> AMD XGBE HW supports Giant packets up to 16K bytes. Add necessary
>> changes to enable the giant packet support.
> 
> How does v2 differ from v1? You should include a change history.

There are minor changes between v1 and v2. I'll capture those in the 
changes log and resend v2.

> 
> You also need to wait 24 hours between posts.
Sure.

Thanks,
Raju

> 
>      Andrew


