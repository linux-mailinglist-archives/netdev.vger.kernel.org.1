Return-Path: <netdev+bounces-241330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56351C82BB3
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFA81342C0C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B71FDA92;
	Mon, 24 Nov 2025 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ljngd5JM"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76AA944
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024454; cv=fail; b=Ml3G2Arb6PzpabMnN39vjTAALOXeyuKV9mwkAOaT4nAPCA8kwfCg/eywboZ3/uSF0uHYT4T2ymoFVnZIkcQVIIpXkD0o3Up0bLuxX8JjJkWIG5aQ575TpjkEaz1nTfFOMFz0xOD/pkj8dfsOpdoZu6WNX1zKeec1hPAT1CR8KwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024454; c=relaxed/simple;
	bh=5f/krZZ7eLtZwrGgBkaL9iiWNpZJ3siQuEH6idc5GCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVJAQqYizT7ymIsexCM34KEHnA8CtYARf4II2WfyOPxpJEhocysbB0ZKB7UZ/aP+p1HyndSRJ1Bw24GTR22pRQDABnIhNSIpe8ajfy/q5wjKvBGHc6R1crGEKLtK9sB6zAWf0X6EZlV9SdsXn8MPtTTL5DBxujBs9hf2SXaTBGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ljngd5JM; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVvzdApmLjVJPulxquPyMkXbcPREHgcxAKOogCq91UOsjKA/KFnnLOGQfVFO4BWkEp46PTWuo6MAayI0IAi/nGTbE9iS9mEB++VWrk0SYbBBH3E0PJYGzRW/dCf/8HtPXL0FVbSfzNOcDHs/PGmwm05R2wZW8Anc+/D2afrKd2Ax3bjYIbDEbk8qKjLf4b4vEv8cXMgl+XShc6j/kF48X482URTkSjCGoTqG+HOHtL6pXEWnPAnwOng/bKrLGU+k6yjySx5DEoqppHl4tvNvnVKbwEjuKPiRoOtNp8IEUZ7NNm6I4g9IRNZnZgxSJqN6yL+iU/YigaPVq4dNi+lY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrhTQb4y8SyC4YwuXdKCsm3pVAwLfj2My7bHmZYiXP0=;
 b=ey/7FBEXyw1ZXtzhzRC4vf4Ge0/37fy0j1tELFqnlmgmlGOKYYNOoKovHjxHA1osWUZ+m/3c9imLVTG6ARdXgsNN3UFSN/d6JB5nzLtneQqleZzRjgISyhPWJOGOslCYfLR8wj+YK6WPXLHuImHT5B7N3XRWth81HHG3hMTJVPhForzvlquq0iYyLkZhJWOykV30tI6dYJkBYbIbG9d5nfzaKpC0DrrxQUP00zHoP35RriX5XucO2Y+kdnRd957dxgqkgg3Gyri13nHmDTEpFY4MzRue8HeUUzdBq87veacPIx0AtHc7/tv/xZ6h8nTmZhNFv9yJfopqpt57R/BPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrhTQb4y8SyC4YwuXdKCsm3pVAwLfj2My7bHmZYiXP0=;
 b=Ljngd5JMb+yFiR9f0HJ+dsuEaivz6DxdfHtoTCIqS/+d3ebZRxyc/L2BsnGi+7Kq9dtXrnKuqPtW7da0uqWUTJXDX9tOUV0LhuL4ZHE9eJglK/zoIyvbA/oEAd6wY9RVlXZ/eletH+B2+nPUviIP28KOaKz6Qb+OH2zor5TPfoBxilI7B3Hfu4pWGND6+PLF00us0L41jVPsihjCTjQsEYiu0QBNWHV0CjWBbnYJ60cxvI/nwFEuoPfFzk8FUn/YB1c9hVYSE4BwIUlu19rv2OviAHjNyAi1zJ2Ggtt5CZQr6jz5LD0wjnLIgtIGdPLiCcjjR7Ni5PH/DXr7BGpSOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:47:28 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 22:47:28 +0000
Message-ID: <64058bf7-14b9-4baf-91c9-6ae4b455d507@nvidia.com>
Date: Mon, 24 Nov 2025 16:47:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-12-danielj@nvidia.com>
 <20251124165953-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124165953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bf75be-1ec0-40d1-9aa0-08de2bab71c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZBQTEwMm9ML0hkbkhXU1BtMWdnZHF0SEhsYXMrOXNpbjZGWXVMUUJHcHpI?=
 =?utf-8?B?WTBYNGhWYmRJRE5UdHhnZGlEVmxiU2Y1UW1lTHIxWG45NlNRVE50NUhOMGxk?=
 =?utf-8?B?R0NOY2lIRmNtaDRaKzhBZVFYNlp0RzBqMGk0R2hzT0YzbjJEVkpYOWNrcGxo?=
 =?utf-8?B?STRrZ1QxQ3dhRHlmTWpsVDVPSmFWY0xyejhpSHE3MEFldng2M243SUNpbitJ?=
 =?utf-8?B?d3ljL0tZa2pCZDVWeVdhZEd2YTA4MkxjUWwzN3ZxdGxFNGZIT1pQWUsvemhs?=
 =?utf-8?B?bEVZSkdqckZRSU5mRFNLQXUvNkdlK2p2ZzRmWWhaeHB0Zit6b21FL05hMXAw?=
 =?utf-8?B?cloxeVpSOHdEa2FzT1g4RENzV0hvS2plQnpUTEFvc01DNSsrd0h1bHZQY1N3?=
 =?utf-8?B?M2M0dElNYjJvRWJwQkhBWXdocUNFTHZyV0NUL013Q08yRHJPSzlOcHZFTTNh?=
 =?utf-8?B?cG05VnNHQ28zL3FFcEpZQ1NxYkZKUUxtWW55VnNzWmhDVWpmTW1QMmF0V2lu?=
 =?utf-8?B?ekgySmVwT2lnN1ppcTVRcFBqZFZ2aWZWamxOOTRTVzgxVW0zNXJPc2NKNmRE?=
 =?utf-8?B?d2xqUlJZU3F1MmNmclRkaXpWemIyWHdkcUNJdVc4YzdpYTRrZURvSEZlYUxm?=
 =?utf-8?B?SlFxOUp1aE5ybTEyRHIrWmNFMkEyUTlEZkpia1dJUXVRUTNEV2pMdlhNOTA5?=
 =?utf-8?B?dDhhenYzbFNKV2Q1V29YRnFCdlRzeDlPRnVhWVR0elFQcVNSa2dRbVZqUS85?=
 =?utf-8?B?VE42Tk0zTmtkUXNmSVZ0U2txVjZxL0FMdm5Hc0t3VlQ5eGJCVFhhZ0UrZWpI?=
 =?utf-8?B?elRpRjVGc2diVTNjSTBNUWFub3BSZ1ZHcnBTM3YwNFQ3MXlTdUl2Z2Y0dVUw?=
 =?utf-8?B?bE9NR3ZZams1Y3lMcGJMd3J2Um5Jek82RHZoWlZhUnluOE9uc1BJOUxVWlFL?=
 =?utf-8?B?WXB0dExLcWI4Z3ZIc2tvd1lBeTlZMjlLL3pzTVI1YmJaeWJEakNzdlpzT1hr?=
 =?utf-8?B?WkxQamFTWUhQY0hVbjNKNW53dk92d3B1eHhxUllBcm9mWjJTU1NtUU9qb3RP?=
 =?utf-8?B?ZHVIb3BSaXRkOE5jN0E0ZU1ZUXVDUjFFUTRNdU9RbkI5UlZ1aXFFSUV5LzFX?=
 =?utf-8?B?WmJPRzNaSjBPblh1akwvcUtOZVNoeHZOb0t5ZVpGeHpyR1RYOFUvZnlRdjZV?=
 =?utf-8?B?dThzdXI3elVmZnJMY210ZzdZZnhoc1hONVV5ZjFEQ2hZMkh1VHJNWmIyYUpC?=
 =?utf-8?B?UlBoUk0za3lYYzFybnN6WmFhbVBvZ095U2lPUzJzODBad1FYMDJ3SVVQUHVp?=
 =?utf-8?B?M0dZTWdZcWZnbXptRTVIeFQ2aDRRY3hVV1J1d3JtUXdWbVlPaVROSGNTT0hG?=
 =?utf-8?B?WVFJWGpobGFWVk90Q2poRDBmNlQwSVMrMllnZ1ZEQUU0VmJ2R3pXanJzN3Rs?=
 =?utf-8?B?Mis1MG1LeDAxTUw0UUh3TzRaUzkyMkVtZUI3RW1NZnkwT3JjTE5GR2JlM3Ix?=
 =?utf-8?B?eFFrOENEQmRwS0xUUDF4WThDN0pQZWhJc3dvdlFtcWRhL1NRZ1RhcVF1c3BW?=
 =?utf-8?B?VzBKdXJVbndCc3NhMGIwVXlFZ0tqSXYwV3QxSWxjemJhNHYxSmVIK0VDY3Zp?=
 =?utf-8?B?amt3UjBLQU1aUjZKVktmOGJmWE5nU2VJQXd4aDFaU2FXcEhkNFVvaFV6VDgw?=
 =?utf-8?B?bThOeUNjRk9jS3YyZmhyZ0l2OEFlMGg1b3VPaFI2a2VKL3JPak14eUhNcEZw?=
 =?utf-8?B?aDlQYll2eTVlejYzQWl6RE0zTW01WVIvNDc4QzA1Y3NKMTlod0JQR2R5ZzQ5?=
 =?utf-8?B?YkNpQTVmUkJtMmFLSHFoeGpINjV6OTA3QU1mN0VyWklPRWVaNWpmRUlLQ25m?=
 =?utf-8?B?MVdWR0FOd1Q1NmdTejY4WDc0ZW1jUnhKbXlYTVJqYmVScy9mUkoraGtWTXZC?=
 =?utf-8?Q?IReuKIU4WnvxzmiiYuhNO3J6wVFAxm7P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFd5b29nL2xGWEtRQ1RMcEZJRklqSENndlUwZGM1VXBiSUxNSEhJYnBGUkI2?=
 =?utf-8?B?TmxWYjJKS2hwa0xIb1RRV3ZUcTg3bTU1N2pFa0dub3FVV3hmV2FPVEJGbTRj?=
 =?utf-8?B?TVBneHErWTlRcSs3QysxcVI2MGZLMHNJWkZFK2dkQVRKY2dKNUJUTVI0TUM5?=
 =?utf-8?B?dW5EOTdQeWtRNkVWaklvbmNsUDhEbUl5RTlsM2M2d2sxWnV3cnpqcHF5YlZT?=
 =?utf-8?B?QVljUGZWMXF0bys4eERhR2VUZmQ0ajQ1VkJhSE9IVkdNOG4yRjZST0pka2Q2?=
 =?utf-8?B?a2xpRkd6dTd3S2ZXbFRsUFRUOXA4MitrZ1hzc1hRMmNwcHJ1YjFCeU15Smdu?=
 =?utf-8?B?QXFqMmMrazduMEUzRUJELzdrTGpvckU0aE5CWG9xQUlndGZzMnhNbE1iN0t1?=
 =?utf-8?B?TCtNSEN1TTRQVmk0UEhLb1ZuUTkxV0VqcVpzd0gxTkROTnRuckNFQ3hLb0R5?=
 =?utf-8?B?aG9aSjNnSTdvaUpKSUZxdHBpSHptZVptbmJBQTU0aW43OU43cjd1NzV4RzRr?=
 =?utf-8?B?aXh3QTlqTENEMVlPTUtIUG01WkxVWVZjcmhVUVZ1NkNvZ2xqR2hFUTgwd05h?=
 =?utf-8?B?dUxON1BPNkdnYjdtL1BYTlp4dytqallkQ0pMRHduUGdzNVVtM21ydVprbGVX?=
 =?utf-8?B?eHFlS2dEOWxpNElKWVJ4cnRGbmxGcGhQSThzd1RzOWJhajBwRzdaU2Z1cnkv?=
 =?utf-8?B?OHBDelZ4Z05TTENNYXlHUExDUVhIbU9xS0lTR09jQWJBR0lQT0doYkJCNXJB?=
 =?utf-8?B?NFRwT0hUa2NxNnlndm1FNVBtTkFZVmJVaWVRT1creUs3YWlqZ0IrV3I4Ykxu?=
 =?utf-8?B?ZkN0bTg2YVVXUlVNcUVKOHZSMG0yMk4rUHFDTDl6azZvTEpGWnpUdXVkMzQx?=
 =?utf-8?B?VHR0S0tZeCs3dDBscHN3MUdObFJwNmluZ2taS21OemY1MkpHSWJhR0FWM1Z2?=
 =?utf-8?B?S2VjMjVkQ0FDMFFXYlF1bUI3VWFRUmxCR1NqTXlsWkxOWkh1dlBXK25OUlA3?=
 =?utf-8?B?UVBhL2JzakY3bHlIWEVzVDBkMmRza0dubldGVmNKZzROeC9YaVZRVXpzYWlm?=
 =?utf-8?B?UWlLdzI3NjgyRTJaWC90c1VRQzRsZ3JCckVQWTBVeXdVZzE2ZFY0RWxuRkNj?=
 =?utf-8?B?MXoyMjBueC9kVDQwNkE1RVBUZWNmMDhGRC9EcThSRnRpWTFkZG9lQnphYXB6?=
 =?utf-8?B?dEdFblVXWURnTTUvdFh4R29JLzRma0FEVGpHWml0N0lKUFFWY2pDNWtySlV1?=
 =?utf-8?B?cDI3UitxQU52VC9MR016UDJoT2JJb21RRXdXK0RIMWdJUnVWZUtIRC8vL1Uv?=
 =?utf-8?B?QVIxYU54UUptTVkvcGpUWFh1NGlPWm5ZTVRxWVBJQWVEcFcxMUJnV0xZZWRC?=
 =?utf-8?B?dEptZFVMMlpKc001cDVPQUhBMGlQSWJIeHVpZEU0aUsybTRRYlB5K1llb0U4?=
 =?utf-8?B?L3V4cGZhdnhZSGZtQVlaQTNXa1dvRHE1dDBpODlxZ3F2L0pxK0hmRlRSZlFa?=
 =?utf-8?B?MjdPNWF5S3M1LzlXdURCV2dnNUZWclNtK3lhZnZaR0kza1d0dHMrY2Q4T29S?=
 =?utf-8?B?MEdySW5CT1JrMTBudkNtQU0vdjhQanBLMkV4TTdydm5GVXI4SU5lQ3pacUZz?=
 =?utf-8?B?aVdDOSthVmlkZUFJMXhwR0crdTJzQkQyMXgxL3o5WDRKNGFWL3R4RXN6bnFq?=
 =?utf-8?B?TVdETm5GOEJtMDBlYUJsWDhLQTdzb0s3QmZNVW5iVnluR1NVOEpoUGIwdytl?=
 =?utf-8?B?TjlZaVk5bVRhRjlrbnZTVWNTaGNQdDNHWXIyK1QwWVdJTTJxcVBlVGxVVU1Z?=
 =?utf-8?B?V2Y4VEFvNDluRFVyNGFhZVZOY01IS05DRGJnOVZqZ2tGOXlWR0oxVzlGTlhT?=
 =?utf-8?B?enZWd1FsaERTdGJyQjlhYUdGZmc3TDlwYjk3WFZiMFRwS2g1Kzhzend6eVo3?=
 =?utf-8?B?TjgxZStDbGJmREFlSDk5bzR5Q0wvcmMray9ha05rNzJwTHNZT0lYRVhpb2hk?=
 =?utf-8?B?cWVPR1hESnNlZUNyUFcvVTNudGZQN0dSbE1aUEs5OW5hbGEvU2lObkNjRXdQ?=
 =?utf-8?B?V0VEai9YWExGOWdYM1hPUWYzbk1wNEpQdFZ4cGFYdnNNOW5OTXhzWS83UVpJ?=
 =?utf-8?Q?/YZChCY9K3U6YQogccCP8otfM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bf75be-1ec0-40d1-9aa0-08de2bab71c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:47:28.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmAPAvTMTtR4G4tAaikQD3MQekoCHU5Sz2McuWTBWhV7q09aWcKZZyPYOeojDBGuZe/1v2Hmn7ClvWMR2TFLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

On 11/24/25 4:02 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:22PM -0600, Daniel Jurgens wrote:
>> Implement TCP and UDP V4/V6 ethtool flow types.
>>
>> Examples:
>> $ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
>> 4321 action 20
>> Added rule with ID 4
>>
>> This example directs IPv4 UDP traffic with the specified address and
>> port to queue 20.
>>
>> $ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
>> 2001:db8::2 dst-port 4321 action 12
>> Added rule with ID 5
>>
>> This example directs IPv6 TCP traffic with the specified address and
>> port to queue 12.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4: (*num_hdrs)++ to ++(*num_hdrs)
>>
>> v12:
>>   - Refactor calculate_flow_sizes. MST
>>   - Refactor build_and_insert to remove goto validate. MST
>>   - Move parse_ip4/6 l3_mask check here. MST
>> ---
>> ---
>>  drivers/net/virtio_net.c | 223 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 212 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index bb8ec4265da5..e6c7e8cd4ab4 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5950,6 +5950,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
>>  	return true;
>>  }
>>  
>> +static bool validate_tcp_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct tcphdr *cap, *mask;
>> +
>> +	cap = (struct tcphdr *)&sel_cap->mask;
>> +	mask = (struct tcphdr *)&sel->mask;
>> +
>> +	if (mask->source &&
>> +	    !check_mask_vs_cap(&mask->source, &cap->source,
>> +	    sizeof(cap->source), partial_mask))
>> +		return false;
>> +
>> +	if (mask->dest &&
>> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
>> +	    sizeof(cap->dest), partial_mask))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static bool validate_udp_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct udphdr *cap, *mask;
>> +
>> +	cap = (struct udphdr *)&sel_cap->mask;
>> +	mask = (struct udphdr *)&sel->mask;
>> +
>> +	if (mask->source &&
>> +	    !check_mask_vs_cap(&mask->source, &cap->source,
>> +	    sizeof(cap->source), partial_mask))
>> +		return false;
>> +
>> +	if (mask->dest &&
>> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
>> +	    sizeof(cap->dest), partial_mask))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static bool validate_mask(const struct virtnet_ff *ff,
>>  			  const struct virtio_net_ff_selector *sel)
>>  {
>> @@ -5967,11 +6013,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
>>  
>>  	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
>>  		return validate_ip6_mask(ff, sel, sel_cap);
>> +
>> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
>> +		return validate_tcp_mask(ff, sel, sel_cap);
>> +
>> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
>> +		return validate_udp_mask(ff, sel, sel_cap);
>>  	}
>>  
>>  	return false;
>>  }
>>  
>> +static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
>> +		    __be16 psrc_m, __be16 psrc_k,
>> +		    __be16 pdst_m, __be16 pdst_k)
>> +{
>> +	if (psrc_m) {
>> +		mask->source = psrc_m;
>> +		key->source = psrc_k;
>> +	}
>> +	if (pdst_m) {
>> +		mask->dest = pdst_m;
>> +		key->dest = pdst_k;
>> +	}
>> +}
>> +
>> +static void set_udp(struct udphdr *mask, struct udphdr *key,
>> +		    __be16 psrc_m, __be16 psrc_k,
>> +		    __be16 pdst_m, __be16 pdst_k)
>> +{
>> +	if (psrc_m) {
>> +		mask->source = psrc_m;
>> +		key->source = psrc_k;
>> +	}
>> +	if (pdst_m) {
>> +		mask->dest = pdst_m;
>> +		key->dest = pdst_k;
>> +	}
>> +}
>> +
>>  static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>  		      const struct ethtool_rx_flow_spec *fs)
>>  {
>> @@ -5987,6 +6067,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>  		mask->daddr = l3_mask->ip4dst;
>>  		key->daddr = l3_val->ip4dst;
>>  	}
>> +
>> +	if (l3_mask->proto) {
>> +		mask->protocol = l3_mask->proto;
>> +		key->protocol = l3_val->proto;
>> +	}
>>  }
>>  
>>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>> @@ -6004,16 +6089,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>>  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>>  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>>  	}
>> +
>> +	if (l3_mask->l4_proto) {
>> +		mask->nexthdr = l3_mask->l4_proto;
>> +		key->nexthdr = l3_val->l4_proto;
>> +	}
>>  }
>>  
>>  static bool has_ipv4(u32 flow_type)
>>  {
>> -	return flow_type == IP_USER_FLOW;
>> +	return flow_type == TCP_V4_FLOW ||
>> +	       flow_type == UDP_V4_FLOW ||
>> +	       flow_type == IP_USER_FLOW;
>>  }
>>  
>>  static bool has_ipv6(u32 flow_type)
>>  {
>> -	return flow_type == IPV6_USER_FLOW;
>> +	return flow_type == TCP_V6_FLOW ||
>> +	       flow_type == UDP_V6_FLOW ||
>> +	       flow_type == IPV6_USER_FLOW;
>> +}
>> +
>> +static bool has_tcp(u32 flow_type)
>> +{
>> +	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
>> +}
>> +
>> +static bool has_udp(u32 flow_type)
>> +{
>> +	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
>>  }
>>  
>>  static int setup_classifier(struct virtnet_ff *ff,
>> @@ -6153,6 +6257,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>>  	case ETHER_FLOW:
>>  	case IP_USER_FLOW:
>>  	case IPV6_USER_FLOW:
>> +	case TCP_V4_FLOW:
>> +	case TCP_V6_FLOW:
>> +	case UDP_V4_FLOW:
>> +	case UDP_V6_FLOW:
>>  		return true;
>>  	}
>>  
>> @@ -6194,6 +6302,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>>  			size += sizeof(struct iphdr);
>>  		else if (has_ipv6(fs->flow_type))
>>  			size += sizeof(struct ipv6hdr);
>> +
>> +		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
>> +			++(*num_hdrs);
>> +			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
>> +							 sizeof(struct udphdr);
>> +		}
>>  	}
>>  
>>  	BUG_ON(size > 0xff);
>> @@ -6233,7 +6347,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>>  
>>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>>  			     u8 *key,
>> -			     const struct ethtool_rx_flow_spec *fs)
>> +			     const struct ethtool_rx_flow_spec *fs,
>> +			     int num_hdrs)
>>  {
>>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
>> @@ -6244,23 +6359,95 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
>>  		selector->length = sizeof(struct ipv6hdr);
>>  
>> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
>> -		    fs->m_u.usr_ip6_spec.l4_4_bytes)
>> +		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
>> +				      fs->m_u.usr_ip6_spec.l4_4_bytes))
>>  			return -EINVAL;
>>  
>>  		parse_ip6(v6_m, v6_k, fs);
>> +
>> +		if (num_hdrs > 2) {
>> +			v6_m->nexthdr = 0xff;
>> +			if (has_tcp(fs->flow_type))
>> +				v6_k->nexthdr = IPPROTO_TCP;
>> +			else
>> +				v6_k->nexthdr = IPPROTO_UDP;
>> +		}
>>  	} else {
>>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>>  		selector->length = sizeof(struct iphdr);
>>  
>> -		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>> -		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>> -		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
>> -		    fs->m_u.usr_ip4_spec.ip_ver ||
>> -		    fs->m_u.usr_ip4_spec.proto)
>> +		if (num_hdrs == 2 &&
>> +		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>> +		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>> +		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
>> +		     fs->m_u.usr_ip4_spec.ip_ver ||
>> +		     fs->m_u.usr_ip4_spec.proto))
>>  			return -EINVAL;
>>  
>>  		parse_ip4(v4_m, v4_k, fs);
>> +
>> +		if (num_hdrs > 2) {
>> +			v4_m->protocol = 0xff;
>> +			if (has_tcp(fs->flow_type))
>> +				v4_k->protocol = IPPROTO_TCP;
>> +			else
>> +				v4_k->protocol = IPPROTO_UDP;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
>> +				    u8 *key,
>> +				    struct ethtool_rx_flow_spec *fs)
>> +{
>> +	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
>> +	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
>> +	const struct ethtool_tcpip6_spec *v6_l4_mask;
>> +	const struct ethtool_tcpip4_spec *v4_l4_mask;
>> +	const struct ethtool_tcpip6_spec *v6_l4_key;
>> +	const struct ethtool_tcpip4_spec *v4_l4_key;
>> +	struct tcphdr *tcp_k = (struct tcphdr *)key;
>> +	struct udphdr *udp_k = (struct udphdr *)key;
>> +
>> +	if (has_tcp(fs->flow_type)) {
>> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
>> +		selector->length = sizeof(struct tcphdr);
>> +
>> +		if (has_ipv6(fs->flow_type)) {
>> +			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
>> +			v6_l4_key = &fs->h_u.tcp_ip6_spec;
>> +
>> +			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
>> +				v6_l4_mask->pdst, v6_l4_key->pdst);
>> +		} else {
>> +			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
>> +			v4_l4_key = &fs->h_u.tcp_ip4_spec;
>> +
>> +			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
>> +				v4_l4_mask->pdst, v4_l4_key->pdst);
>> +		}
>> +
>> +	} else if (has_udp(fs->flow_type)) {
>> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
>> +		selector->length = sizeof(struct udphdr);
>> +
>> +		if (has_ipv6(fs->flow_type)) {
>> +			v6_l4_mask = &fs->m_u.udp_ip6_spec;
>> +			v6_l4_key = &fs->h_u.udp_ip6_spec;
>> +
>> +			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
>> +				v6_l4_mask->pdst, v6_l4_key->pdst);
>> +		} else {
>> +			v4_l4_mask = &fs->m_u.udp_ip4_spec;
>> +			v4_l4_key = &fs->h_u.udp_ip4_spec;
>> +
>> +			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
>> +				v4_l4_mask->pdst, v4_l4_key->pdst);
>> +		}
>> +	} else {
>> +		return -EOPNOTSUPP;
>>  	}
>>  
>>  	return 0;
>> @@ -6300,6 +6487,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>>  	struct virtio_net_ff_selector *selector;
>>  	struct virtnet_classifier *c;
>>  	size_t classifier_size;
>> +	size_t key_offset;
>>  	int num_hdrs;
>>  	u8 key_size;
>>  	u8 *key;
>> @@ -6332,11 +6520,24 @@ static int build_and_insert(struct virtnet_ff *ff,
>>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>>  
>>  	if (num_hdrs != 1) {
>> +		key_offset = selector->length;
>>  		selector = next_selector(selector);
>>  
>> -		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
>> +		err = setup_ip_key_mask(selector, key + key_offset,
>> +					fs, num_hdrs);
>>  		if (err)
>>  			goto err_classifier;
>> +
>> +		if (num_hdrs >= 2) {
> 
> 
> So elsewhere it is num_hdrs > 2 here it's >= 2 ...
> 
> all this is confusing.
> 
> 
> 
> Can you please add some constants so reader can understand why
> is each condition checked.
> 
> 
> 
> For example, is this not invoked on ip only filters? num_hdrs will be 2,
> right?
> 

It is invoked, incorrectly. But ethool is well behavied. I'll just
chechk flow_type vs num_hdrs.


>> +			key_offset += selector->length;
>> +			selector = next_selector(selector);
>> +
>> +			err = setup_transport_key_mask(selector,
>> +						       key + key_offset,
>> +						       fs);
>> +			if (err)
>> +				goto err_classifier;
>> +		}
>>  	}
>>  
>>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>> -- 
>> 2.50.1
> 


