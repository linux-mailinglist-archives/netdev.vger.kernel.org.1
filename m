Return-Path: <netdev+bounces-180014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A3A7F1A2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3677D174917
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838B18EAB;
	Tue,  8 Apr 2025 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yh2U0yY5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24BAD39;
	Tue,  8 Apr 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072286; cv=fail; b=GFBa1c78imOxquySqYACYL5NtmKQfAMUmoSijGmATNeuatPLCgSvp8ZBl3hCFmVGcORSofGiOnfjaTEBbC8fFx68SeOvN+B6lNDcF4+DJskD/C1y/1iCiEXKHnFNq5Yx9WvQo/Qepg2NSPb4jo8RQcuA7vthNukNgvQQklJZMYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072286; c=relaxed/simple;
	bh=TxBN4vMiwY4L2ux6hbhGYheqghN1ryqWDbK55sv5Elo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGNI+RVAo8PW/bBfvZtC8mdWcyvVxlJLbww9zvXwPWI0LIQtqx+KdN1onvH434PFP4lCllBcq4Z37XZkN8rtVT/8IFoYZTFTAyMr6yDc4Ge6Dl0z2B3dMVnSOzmE5QtQOpmpgJCjSX//xxRvZBoF6wrYjyutq0jXhbWylDseENE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yh2U0yY5; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfH+PaZ0FTw95XzOFFSX1RHmuFBGDsteXYl1+K+5njEuclLZU2LKHl1QFc0o1rWKbwkAU+ElPAIy6s8DyLtwdz5XZud2AnanXgn0rZy1iAlA0R/81159lHND4Q7W29qiO3bCv4YQMA1RQclKKLcCP0v1gRj6YbYywzE91ZkyUWYopUTWQSaOxQbNDfacbU3OoprQ6/yxKzXOALng/EbqTq6lKQh4sL5b/Sh9SrGNQq2XJF1JOnYwZn6j+8Ow/u2Ef5j+PgpNkc+4Q4Qr8RBKvBohpuY+ajNNMZdl+BEIQWMPsNVXp+6Q5iqVogdqoz/6NaPTofrOq80y/CMIE6xl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQFfQsF8kT1MMW3HQz4VEJrCn2nftZK+jo2+5cXm8L8=;
 b=mDEn+4cOztbXIOU6+NEzw9RY0i/r2QpbOdLmmSBln/+zm4mUkmGaPyKUuGOXqqT36xKA4vGMtfVniaKCxcxvCTkXjoLRw4lnF9slARyf8GTpxXIwd9zG3l1kDzuTt7QBVV5UW2tcLxs+o+ZIbAoAMz5xQ7NlhmmAmq6HawC3kuFapOWvC5mfrrNpYZ/5i/tKDQSGVoczJ4LcUYf4lB8gTk/0S/UH4oyfsFtEKM6W9zHTqkmTXpN80+3aW99o+JgVbp5fath2ufutjEvVVtVbRLBp7q4O/IwDGsM7xItMmyboIrXsINmqCb6Fderw22Ti52IOaBS9RkBbVIpZv53wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQFfQsF8kT1MMW3HQz4VEJrCn2nftZK+jo2+5cXm8L8=;
 b=yh2U0yY5YHNdP/iAIzxtbeWaKgDU+MaQdQB5mbse1dbTGUGaDpUSWIMwxtT6E8TUI4kOOqhSp24BAG/gdqksR0BtoGrO+hkSa3+lvyFP8XT3V9Ya4PXGLn8IeSVYfdRnl/k9zFe7qT/1x965Vv3t1XJTc1vdmdy7rax6e0zlvdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Tue, 8 Apr 2025 00:31:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 00:31:21 +0000
Message-ID: <d9638476-1778-4e34-96ac-448d12877702@amd.com>
Date: Mon, 7 Apr 2025 17:31:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Bharath R <bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250407215122.609521-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ce3eef-8857-49f6-b27c-08dd7634af52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlVBM3JVbzVGRTJQMUlDMUN6azF3QTdCcVk3SDZZY1ZuUzZ6VVdrMGNTQy9h?=
 =?utf-8?B?MzAyNlVndXB3R21JbGdHZW12b2pIRXg3KythSUd6ZzRjY0RIRzVpWmxRek1I?=
 =?utf-8?B?RTVpZ1M1YjNpMlVZaUllcVVqZFZuaWhYdk9IZWtLcU1ZQUMrTEI5TGhWUWQv?=
 =?utf-8?B?L0c2c0xDV0duNnB1ZGJTL043eHdMQlBiS1RlOVhNMXQ4WGxNQ1h6QW5jck5X?=
 =?utf-8?B?VzJtRWlEbm5jU01mQlVBeXFSNktXQ3Jkck5NYVhYdUM1dytYc2RQcXpidjQ4?=
 =?utf-8?B?a0xEdnhURWdlZWp4WGIwVi90TCs3ZmFGanA5N2RNR25scWpLZHJHRE1KUWx1?=
 =?utf-8?B?ZUtxczhuNE9HWDZCZzJKdlZ3cU1OWHIxVnZpU2RreEk3VFVTV0F3RTFualU2?=
 =?utf-8?B?MVhYbHhtUjZKQXpGdXVFOGl6UmUwY3hCVjU1QjRVRG56L2JYK24yZ0pVckgv?=
 =?utf-8?B?NSt6VDJuTG9Cd1AxbnhESW1wTlY4Z0dkdnc4aS9EdjV0M1NhOFQ0WTdPRXlh?=
 =?utf-8?B?dHozb2MvVUlOZ3pRZEFXRHpDSVpzUWsrbkpqUFZydEMxUTFpV01ZSkg1MjBH?=
 =?utf-8?B?MDhra2FXYVBPaW5NWS9tQmZOS09UZFRVdkkyazk0WVp4THUydWt3bEFCOERO?=
 =?utf-8?B?SjFrVU56RWtFRVJzSDQ3UXBGa3puUUJ2Q3p3S2c1SjhadDlRZDdncFBleVV0?=
 =?utf-8?B?ZE5RL3lCVmxWYkdnTWl0c0poaDZCd1g3WXoxQ0UyeU9UUmhNTExJcVNXbVhS?=
 =?utf-8?B?QzZOd2Q2cjQ4U0hjdnZqMVJSazNpd2hISmFPYXRHMldpYTR1MDl6WDJ4TFhC?=
 =?utf-8?B?d1NRNkxzQ0ZyRGhXZmxhUnFlQ0oxa3hwck00UXVPZ09TekloaC9wai8xV0dt?=
 =?utf-8?B?Nk9wT1ZzaDlJOGVlZnhmaVZYT2I2MG9hTk53TmJOa3k3Y0V5UzJyVEcwUHBq?=
 =?utf-8?B?K2crN3dFbnNsdW4wbGVtMm90ZmxnVFd4WlRrUmg4SmQ3VGpqRlZFK3pNaTFt?=
 =?utf-8?B?VTg3VUhyQ3h0MENuK1ZXVng2eHRYQ0NZa2RUL3hrc3pZMDVEZjRhVFo4SnZz?=
 =?utf-8?B?Y3VVS05lVzFLM3hmSnkzR0lvNU1nUFFDVVVhSUhtRFg2dVdwOTZKa21iVE5P?=
 =?utf-8?B?b3ZNVlNEZ2h4aGZhTkpyZHorVEt6T2hmTFJHRHlIK3BXQXZUOEZydlI5U0hJ?=
 =?utf-8?B?TDYzWWdnc0VuYmVRMXZVaURLSk14V1BDLzY3VDBsd1ZCNEhOMFhuRG03aTZ5?=
 =?utf-8?B?cklBNTlrUkF2TW81Z1Rrdk9KaituOWdXY0ZZUjBtQWJJdUhjRzc2amFDVFZM?=
 =?utf-8?B?M0VGZmxUN1cyVWxhTGFETjJvQ3Jwejc5UE5iTE9PTVNTcGF3UmZRVzFvR3E5?=
 =?utf-8?B?OWl4QjNpbjJTa01jZ3U5ZU0wVUhFY25ZN3IrNmk2OHZYSGtxTHFRYVBQRmov?=
 =?utf-8?B?U0V3ZXc1c1ViTmdTbzJKdVpjS1pKVVRsemFmV0Rub3JEdkFDMDdDMnB0cHMv?=
 =?utf-8?B?NHBvK0gzSGRQV0t6Vkp6MEQyZFRVc2QwODQyTzhPU3UvU0gxLzY1Z3hySjlL?=
 =?utf-8?B?amw4YzN6YkNOV0JKNHV1NDdoYi9tOWxKVVowVldpTW9DNDQvRTd1MWNvdkRE?=
 =?utf-8?B?YlZsOGJmRURWMGdZS05LVVFBQVRZVHdIL2ZUaFdqcUpiNXVMc3ViaVVmdUx5?=
 =?utf-8?B?Q2JFY2p0amp4MHNNNHpTMnJsbTBITVg4WnQ3V3Jmb0piZDMreWtndXlyZzdk?=
 =?utf-8?B?VmZLN2FLTUZpNVFVWHh4OVl5bWpaZFdWZEJieHJwNjV1cUZDYkdzTzJkemF3?=
 =?utf-8?B?T1J4M1JueUN1RUZhOHljKytpQU5XZ0I1RUNwM1ArejA3TnU1SjYyM3ZOS2dQ?=
 =?utf-8?Q?sbBMWe4K6SO2m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZCYUJrQWpZZmVGN1F4MmlDdFJEa09uby9SRjBsRytsRFVXeE12UDNJU3Rq?=
 =?utf-8?B?L2ptRkxLb1h5Wi9lYTlwSVR5SWFPNnlLcWw3clR2NC9oYlVRZHNjbWRmNEYv?=
 =?utf-8?B?QnRtaXVjNGt1azVsZ01MZzlmeFFuMlNBSGFJRHV0ZDZkU21hWUl2VXkzN0dm?=
 =?utf-8?B?VjhlMWFwWk1UUVo5TTZveEI2anhJcGk4NXgrUGFOcEU1dkRGNGhPUi9vY3l0?=
 =?utf-8?B?VGdwb0xIdWNzaE5wVnNvWldubjNycXpidkcrR2lqZEpYRlVhVGJmWVlNOThz?=
 =?utf-8?B?TDBOQ2tFRERoV1QxZHljaklBQ1RrT2RHbmh6K05XWlpMdjYvdDJLS3M1aFJX?=
 =?utf-8?B?Y3dlMnJvVTUxZmNuZGlNbFZZSkc0MVUwSnRudkE1UnRTK2N1eHMyL0Jpd3li?=
 =?utf-8?B?TWZKVnM0RnhobWpEdU8vU0U0VElRWENDQVpEU3VSU0FLekhDRTA0aUZ0QlRQ?=
 =?utf-8?B?NFZXYkpWZXUrTGVhRzJOMGRIZnVENnozN1VFS1QydFZTdWlJN0FldWdSWWNH?=
 =?utf-8?B?YlBRSVF2a2VnL0ZsTVpLamVYODNWMkg0SjQ0a1Z3dmFvbm1VYnU4b0EzQS8y?=
 =?utf-8?B?OEhBOTFka0w0cWxlbnhVbkNvNnB6RXRRUlF2eWNoRENrTVJXR1V3QmVDWXdn?=
 =?utf-8?B?d0xJT0FzWmM5OXh1K1lPVVRQdWhQb2svUEpEb1hRQ2tTejFOQUpnUkpMTEd1?=
 =?utf-8?B?c3dMcWhITXMzbHphYnlCWjhxanNvWjR0UzdQczRXL201UFljM2hoQnRDUXN0?=
 =?utf-8?B?NTZvVFpSVlRRRXhpaTI2Y3JDSE5paXkvRm1PLzhVcVpOaVY0d0txM21JRFov?=
 =?utf-8?B?WHNaV1hpaURuWHZsbTFmUEcrMzdEeTNnaTh5OWxNcks0UXB6MXh6YWpvbHRj?=
 =?utf-8?B?L24wZEdWWjNjNmlSZFV4UVd6RWp3bVIxOVdkQ1RhT1kvY1hRZWVabVRJbFVo?=
 =?utf-8?B?Qnc0RC9jdVNhQ0ZxQllpWlYwaG53SDV0SWg5eWdZaVltTFgvWDZXanE1Sk1s?=
 =?utf-8?B?WnBreVZQMkJHa2I0ZVZXc1FwdTZuL29yVCtaMUgxenJrcUtKL0o3T3gwZkZY?=
 =?utf-8?B?aXYzemEvNklkVnVEUWZtMmVZTDZwejlIUmp3SjU3anZMRHQzYitDSy9DWEVz?=
 =?utf-8?B?eWJjQjNOYXdWWGgyRTZsN3RMK1BSTWo3TUVCdFUvUHdqWGUxcDNhc3pqeEVj?=
 =?utf-8?B?RkFJUjNtZ3BqRXhzRWRzdDRNMkprRTFHNWkrdTNybms5Z2V3cjA4OTJUNGpu?=
 =?utf-8?B?OEJGVlMxUTJuVUkyWmdkK2xBUUxXMHlkL1NMS0NSSzArNWF3aWxVYmdQQTQ2?=
 =?utf-8?B?NTRSQTcwSGRxcnFuRkdKcmp5WUdSamNYaXFGRlhmOUZNMTVRQlJzZlNSSERQ?=
 =?utf-8?B?Z3NwYWJkUHlhb2dRWDNiUVpXa0x5bnJnNW4zQktodnhxbTdOb2Z6RWtQLzlX?=
 =?utf-8?B?dUMva045TWZUNzdEaVVqSmJ5TEpDUERHT2NCVzdmck04ekNHQ0NyZmJscm5G?=
 =?utf-8?B?YStlUUZueVIyN2poS1Z4eSsvYWwxSm1EUmFhMjJCdEY3MFhIOWF2UmpwMk9t?=
 =?utf-8?B?RWhBVURqeGZQbStoYW5CbGVBT25NOWRRY3ZjNmdVc3NtR0V2bWlrSG9PT3Yy?=
 =?utf-8?B?eVlabmc4UFhXYWlOQkJVRThXem9JU0I3MytjYmQzUVlBNE9va3pEZnF1RUty?=
 =?utf-8?B?aXFuUVpySXA3QVVXemVPNkQySVV6eFVFWnF1ak9VUnFrMktYc2FxMW9rZ2o2?=
 =?utf-8?B?dlV5RDFXbDRVakdZYjA3ZGs2RUplVFpRRDdndXgzQjZoN2hTZ1dsRUNpQWhE?=
 =?utf-8?B?aVVJb2NQeVU3OS9DQUdMZlNwREhJU1NDZ3o5ekR4NDZ3Lyt2UFJvZnZkU0hG?=
 =?utf-8?B?VzNoc2Z1aVIxc2pNUkhLdTQ5YkpkVGxaZVY1QXJ3S3ZyN0hxQ1RXdzJ1WXcy?=
 =?utf-8?B?QjYzRURSWERTYlBuUzZ6ZU4rdDB1d3JTU0pNSVZPR1FuOVEzTmRBemFXRkRT?=
 =?utf-8?B?VzRyTzBmR1d3NFkwQW93dnF2WEVzM1ZUc2x5MnhPNS95RXFOV05XNG9lcjR5?=
 =?utf-8?B?eHVXWXhnNCtzVzMvN1lkT3YyT3duc0VJSGR6ZWVaWlRNbTFTbXhVUlh2UE9D?=
 =?utf-8?Q?hcrivR7fYCjdxdHwHOFpqy9cK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce3eef-8857-49f6-b27c-08dd7634af52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 00:31:21.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27vp5OBqiGN8CpHHwUT7stefEOg5AGwtOMF5Cuk6tN0EBqeEZDXrPiJkReLuT8Fa/2Z7ictKVR3NKjN31EQuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

On 4/7/2025 2:51 PM, Tony Nguyen wrote:
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Prevent from proceeding if there's nothing to print.
> 
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   net/devlink/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> index d6e3db300acb..02602704bdea 100644
> --- a/net/devlink/dev.c
> +++ b/net/devlink/dev.c
> @@ -775,7 +775,7 @@ static int devlink_info_version_put(struct devlink_info_req *req, int attr,
>                  req->version_cb(version_name, version_type,
>                                  req->version_cb_priv);
> 
> -       if (!req->msg)
> +       if (!req->msg || !*version_value)

Personally, I'd like to know that the value was blank if there was 
normally a value to be printed.  This is removing a useful indicator of 
something that might be wrong.

sln

>                  return 0;
> 
>          nest = nla_nest_start_noflag(req->msg, attr);
> --
> 2.47.1
> 
> 


