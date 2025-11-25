Return-Path: <netdev+bounces-241341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52144C82E86
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214E14E04A9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA651BC41;
	Tue, 25 Nov 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hf7b+Q8e"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19AB67E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764029420; cv=fail; b=qETCuyvQhsF3zLaYnGKzCH+WAN3pZimIiVZNzl1yDmC5S+HBlpnw9sP7R+1U7aSE/XlyGdIl3BWk2ggugwwXwcBgVhzCr0xE5kkJYDdxtxjuAqmgKb6E+fcSvigZZapIjxvyOHmXBAMdy4LSHdH2q92Btgh5YOGUceFEH3bXm/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764029420; c=relaxed/simple;
	bh=ODvJ6Lm/amueHUgiPDs1AA+mkxiQviMxuiQovFzw6H0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwpfl9XK6seoGCfS40Cy2wkS9uy36qVlaovG+xQt9XjRj4aIr/hScIUKi3wYamMm0i0/z/t0ubkeazarSPRhbm0MsqL2HDKUjMwRLzKtH/9TUbzYoL9rJ2rouOhlXB9RZXHcDZKPZ6pckoCAHV35+NsLkQHrdhmkqzskgaOFI/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hf7b+Q8e; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=demkIDHiPT7fjjThZR2Ngnu9hN1Mok0q0gC7GyXQgDXk4MGWuJcWFA7nbpgDu0fPuVKC6kFF841IjmXsirUx8CiCxw3jmGJq1nUwNZ6ld1p2WlwOZsdTA+Ntss9B0oKEiCr/DL9o53lCYZRZ61El0rZz88Z28z1IceixA6NN55rtH0HdD8fLd3H+kjiQ4m73NHsPbNZvFzHtv1DHlI9VziPa2pSM2cGHZaVIfEgasjGErYHlHiTodqj2F8eRf/Kf/UktWRaSMBl44mYWfZ6bRMVCvy//BSQ3Pz8r7ggQ2yv8T+ZvvepCm5HMMAIHgnZ+Sk/QXbwNvR2/ARCmCLTKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB6X/sy47/BpXDoTvT78DxBzKgbedxfWdsGuY5Huy4w=;
 b=bwOEQ9xZOw7uJj1Ua01L6mhlvqwye9UE62k79r4FBrmARhKXoEC7jYzYXbuxLezvZ0hnXJw2zkEQZB136Qae6B/pqSoiGNLt9H5JAT1+oUabPeUgYfqE2uf9C/8bzmYYjUAHAcM7AxlzlnGZhfG9qJX44dIwdJv/s/Igzm69Hm+BKe602R1Q37bHqbNWnHy7Clt2KISshOO4ZGO0qGnRqHr3ftWSP4HUg9TOCMKf2yqoujSkKH6UNEOvH0sgkxNlq+smix89/F1Slsy2IBCK8+b7DUvjjv8sXIYduNK7qUPIBZFbyYvtBRGt5j/5zMiwe/7qox8IpiLVhAuh4iQbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB6X/sy47/BpXDoTvT78DxBzKgbedxfWdsGuY5Huy4w=;
 b=hf7b+Q8eip8X/10xbEhoLk6ndT6Cnat68sPHQOY+73d42RkrOk7F1TWLYqUO9woEWFwVCeBnk/fPKp0WRa1hvAt/uKyYU+/JgYIrXkMhzFk4UxzcRKoJDhoVYwmIaFqo5aYpUioP42JX3mkulltFe9+OxM94RrY4H9I1rMf/A7cUR7AeA9x2nYuec6mJXzO8aujueSR9C/kset+Q2JrQ8dmfgN06QqhwK0Ms12QL7RS4bOk1RDHLNKEjv2FZ/Zh9jex+PtkZU97f275OtRg3EkfEYD2IbFlstmyTZcI5lpJxIVJJOWd0ei4D3WWYJnc2/vaijS4rJ6C4VMZn0RCNVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 00:10:14 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 00:10:13 +0000
Message-ID: <94a3e428-dfea-4910-998d-eb2e26824014@nvidia.com>
Date: Mon, 24 Nov 2025 18:10:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
 <20251124165246-mutt-send-email-mst@kernel.org>
 <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>
 <20251124180941-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124180941-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9fe9d4-a23c-4265-825a-08de2bb700fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxWUmpENUVaeGJUZlc4eXJXb3ZDMWNjRFZ1azRsTlZIUkZDZjBxQnpCdUxq?=
 =?utf-8?B?eWZGR3V5bW85NHVlcm5qd2JZb2U5eEoyaGtNSyt4MkFId2FhbzZOb0NzQWZR?=
 =?utf-8?B?TE16MXhoN05wdW1tRkZ2VU02eURySnJPUnRjMGM0cDk4WWltUzVZK1VsL2Yz?=
 =?utf-8?B?VTVsM3FQVzdwWWhYYjRITkE5SHpCRjBLVXBJVVBRQVJhM0QwYXpPYkpqWmta?=
 =?utf-8?B?cDMzNGtjMU5XRE15SFFsV2dYVmw5NWF0TC9RWkhTWmV3RG5qWUpWNXlVSXll?=
 =?utf-8?B?TzBjWHNxNEVheEhIY3dKdm9mMzI1TEdlUnRSUFRZTkZuOTF4YzA2T3dJNU01?=
 =?utf-8?B?MkQzNXdHdUZZczkrN3RpNXdwQVpVMXRlc1YwRHRYcTJ2ZThyQmlGTUYrSzUx?=
 =?utf-8?B?WFdIWFVIRm9BRzdmdStqRy9zdjN0V3UxWklWbVpYOGpCNlphaW1tR05IV3RB?=
 =?utf-8?B?WjZ2ZkVvOHV5ZTl5RzJNTWZCczB3RThsQkFxdEZzcU9vb2xrWHV1OXI2NFUy?=
 =?utf-8?B?bnl4QWc5VG1UTFpYU1ZlYU9XRTBaVHRQaGpKMWxUNXFyU0ZVdlczOEZZWlEr?=
 =?utf-8?B?UXhJcWpuTzl4SU9IdGc3d2t3dzV1aXoybHdScWw5SHlHc3B5WTVua1FWMnMx?=
 =?utf-8?B?Z0srU2lLbm91amFaeHhGam5MN3dzVXF3dFE5MWc1aUtVNlhETkdFS2ZrUS9o?=
 =?utf-8?B?c0wxSTRhRmxxRzN0akZ1UTNxZlZVeUJKRkRjcEV6L3dOU0gvOHE1L3ZQc2ZJ?=
 =?utf-8?B?eW9qeWx0RXlvZk1TWXJQRlpiNHhNWEo0L1Eya0t2YkFWQ0hQYjhGS2IzR0d6?=
 =?utf-8?B?VTVyZm9XTlRCOE9Ib2c3NHRoRk1qM0w4UlVRTFVNeGVEVjllRWQ1cDdNcE5l?=
 =?utf-8?B?bm83Q0lMSDBMSUc0MGJhUklFclpZWDg1V2JzTTZyeU1xbnpmSzd2bk1rNjhN?=
 =?utf-8?B?ZFJlenZwaElHdEpSWHhPSm1vRzQ2QjdWZXdtTzV3NThKY1lvUm1zbWpFYVBH?=
 =?utf-8?B?K0ZlUC9nR1k3U2J6OUhkcFlpZUlhR085S0dKWFdXTFdlMC9xejBocVhkTm0y?=
 =?utf-8?B?L1RRNXJYTS8wTk01Q3I3VHozRERUR2xzN1dnOGJxZWdUS0hpYzJ2M0JXMlRu?=
 =?utf-8?B?elRlbVcyaXd2eUJGeTB5YXdtcXFOZUZESkVBV2RuUzZtMGdyMUw4dmlkZHNG?=
 =?utf-8?B?NENBVFdSbUNFVkhiT1lpK3JyekFDOEhBMjVlSmZwd2RWQ1JhckY4WmRxbVVJ?=
 =?utf-8?B?OWRacmxWcFYzYzY2N0NFSzdhL3NTZFArYXpXRlpKbGxTY0laSzd2ZkJIMGpZ?=
 =?utf-8?B?d2l3cCtKUW5SV2ppcXJyZjBlRUk0V3NLVDN1RWtkdHpwV29Wbk93TWQyZEZz?=
 =?utf-8?B?WHhvaTRNS0h5NzFCQUlMVUQvV3gwb0tXaDJyb25TaTRzeHhxL0dILzdGMEJV?=
 =?utf-8?B?R0pxdW1DSUJCL1dXQmFEeWkwYlV0WGJiaGhhbjdSUUdJYm8xMDRhUUZVckZ5?=
 =?utf-8?B?MmdtMXExM3F6Mi8rTGdSWkZ1aWcxanNKbFFyenJvMzQ2ZHgyd24yUkFUUXVy?=
 =?utf-8?B?bFdMelNWaWpFR1VZZUo3bFdhY0MvelBFTEtiUEJ4dG5GQ1dkTnJXc0ZkMWhu?=
 =?utf-8?B?K1NUZkRUeDhGYjAzbG8yem5ueUxBRVpiaWpDdDVzRm5DU3dsWGIwdDFNblV3?=
 =?utf-8?B?MC95eGViZlpERVprMXIwM2QyZU9NRGtVR3NXMFVzQ29DeitLWkVzZzIvZHBw?=
 =?utf-8?B?UWw0QjRPc0p2V05UTU9HTnZmUk9RNGQ0L3p5YytPS3lWSVF0ZldaUEdXcnpT?=
 =?utf-8?B?U29paUJmTlhBak5PQ3ZkSGxweTVvV1IrSU5VSHdMYXJmRkVOczVlZk5zV2ov?=
 =?utf-8?B?WDN4UXNISG1UV3JVTEo1ZWs3TVZiR1R4bnZkV0FQUklyWjhremx3KzBYYzky?=
 =?utf-8?Q?QQGjSbw38i4BKpF8zHKMyr9aGCAfOqUw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2lBUWVkbzNISVg1RE5VTGNXb1dZVFdRU2lncDIycStMN2tZTlJQUkxyWmRt?=
 =?utf-8?B?cEZTcnBWNDhaa096R0hwVVNMd2tIWm03TGg2VktIRHdka3lvL01CbG5sakxG?=
 =?utf-8?B?WXVkT1RScEpPWlQrV3FFNlFuV2RUbXMyMVNBcm5ITVltbSs0K05ueVJnUWxQ?=
 =?utf-8?B?T0Fzc2o4RlowRlNITklVTDZDNWp6bGNhM2xhLzFUWUdadmhpamRtMEVHVS9N?=
 =?utf-8?B?QVpic2k5TlI3bzNFOUFibFFBNno3aXgzODVsMHEyOFZlaEl2Yy9Ta1duMWlH?=
 =?utf-8?B?RHJvTEVKLy9JNXpvSnROQU9wSDJZTHpSSmVJWDFSQVJuc3R0TWVlcU5YR2VP?=
 =?utf-8?B?VVpzdzFlSFFkTEFHbEx2TWptQXhySWpyUXJESm03OFBDb0wrcE1nZGxxZi96?=
 =?utf-8?B?VndKZE1odVpWcEVkeTBXRk1jaG54MDVJNE1jRFkrTDN5OVFmMEZQSHhqbkov?=
 =?utf-8?B?Qm43dFZtbHYwY2ZoM2JGcGdibXBXZTdzTnBRZm92TStjalNYTFRMK1BkaGll?=
 =?utf-8?B?SEhxN3pGbGthLzNjaDIySmE3VXpsV0VRVUg3MTgrelNRcmtzdmxjVFU4a2xo?=
 =?utf-8?B?bUhMbmU0aWNBU01aOEIvS0orUUlod0FSR0xBMGhQMVBNdkVvd29EQlVzNFdZ?=
 =?utf-8?B?TGptNEJjRFgxY2JEaVNLQ29Cc25YeFdqeTM2OW9FeEVHd0lpb2JWSEl3Mk9w?=
 =?utf-8?B?QzRwNHFxRGxVaE1SZ2tQTERFV1RGNHFqSjVIYkhaZFAvTnZjNXNXMEptdnBw?=
 =?utf-8?B?cDNkRjMzSmswNXZXWTgveXFidHl5bGUzcUlpOEdvLy9ReVFoekgvcjdFa3RH?=
 =?utf-8?B?YU5EWjFyMmdlSDRhUzFtd2E0STRybzIzUmxrQ1pRU1NRV1pFcGVyNXJCSkpl?=
 =?utf-8?B?VnFzV1JSTldCTURMaGg3K2JRZjdRWGlkV3RTR21aeVc4SDA1dVI4aCtjdXNl?=
 =?utf-8?B?aEd1aEd1bG4zRTFJSmFsdW9RK0JMYUxKc1dzYy9xSFd3T3lMWFQ3RVlrQ2dP?=
 =?utf-8?B?cEMzcnJIbHozSVZ6OHFLbU9aZXM2c3F2dnFJTXlmd2NKUWlPRmIvU1EyOGlp?=
 =?utf-8?B?eWQ5WVNjSnZSdE1TWS93NDZ1c1Z4a1ZJakN4alErNmNYQnRrV1kvK3ZkblFr?=
 =?utf-8?B?Rk1oYjB4RStZL2Y5T0dTWTlsV3hqMTNlSXNKWnA3NGF0K3hoR3FBUXdUT2Qw?=
 =?utf-8?B?VXJUd0xNVUpQcWIzclhZOThhOXhkODE3bHdEUzcvUGRCUDFtYTVaSm1KUGhk?=
 =?utf-8?B?cE1aRG85YXoycG00U0tFSi9ab29va05TbEUybDM3eWl4TW5XYURod2x1NEFw?=
 =?utf-8?B?WHB6YlpVSFoyV29GUE1STVpxcGlJclY5ZUV0dVk0ZytUQUlydnM5TUNwNU9Y?=
 =?utf-8?B?QkIrWmZyMFBrdDFkcmU3Z25DeHpNelYza2plb2ZIemVyWTJXazZsbjlYczJ6?=
 =?utf-8?B?bStjd0FDY3YyMy9BVnducTk3ZXZKRlk1UHB1MW5rc01kRFVRaFNJb2NIVVdY?=
 =?utf-8?B?ZVJKOWorNUYzSEdhYjNlU1RuVDF4S3hBMEVlV1pDUHV0Ynh2YW9lM2ZBNGRv?=
 =?utf-8?B?bThQYjFqbUJyQUlaQVlRbmMxK1E3NUNnMG1ZeXAwZ3RyZGhNMGFwRzRZeGRi?=
 =?utf-8?B?cDVSOTVWdmxWSlIwQkV1MjNxbjk2ejFubWlGTXpNTkpLb25sMXJ1SkFNemxX?=
 =?utf-8?B?UXpQQ1lGMG5pYm5VM2ViVHNsNU0wMm0rY3Zpa2haT2NSdWcxYkR0WkhnamV0?=
 =?utf-8?B?WWVnUXpnVHcxd1c5VWJmVFMxYkFGWGZ0aGkyREtZZml6Ukx1S2F2ckNwdUZp?=
 =?utf-8?B?ME5HR3F3U2xCN3JaR0tOdVYxMWJhUDBsazdyeXQ3empsK0xGb0xIdTA2cEtC?=
 =?utf-8?B?NDh2R1FneTlxWkV6TlZwdjRRY0pFbmJQd3FLUU5td0JHQlpxbTNrNGp6cGhW?=
 =?utf-8?B?dmVhNnlQcDNoZGRTTC9ZQmhENXJKZjl2cSs4dmlSU2Zib0cwZkY1TkdXcUtW?=
 =?utf-8?B?YWRUNDlxV3dwU0hZUVIwU09HNCsrRnpJNkkraXpxTFBtQ0RpclFkR3hDN0NH?=
 =?utf-8?B?T2NCa2JVTmNmYU9LSjUxOUsyVFNta0J1MTZ1MzhjQk5JZmxpcSttTmo3U2k3?=
 =?utf-8?Q?CDni8hkVfpCXvQKLGUI4XtR/k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9fe9d4-a23c-4265-825a-08de2bb700fb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 00:10:13.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwNwQnX3vXUPci3Wy1CH+jA1ITKweLBTPCOUZsIogJsbo/5dCotAGAWv/OWex/eW8O19vJFtUibjXmP2y2AQ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

On 11/24/25 5:12 PM, Michael S. Tsirkin wrote:
> On Mon, Nov 24, 2025 at 05:04:30PM -0600, Dan Jurgens wrote:
>> On 11/24/25 3:59 PM, Michael S. Tsirkin wrote:
>>> On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
>>>> Implement support for IPV6_USER_FLOW type rules.
>>>>
>>
>>>>  	return false;
>>>> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>>>  	}
>>>>  }
>>>>  
>>>> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>>>> +		      const struct ethtool_rx_flow_spec *fs)
>>>> +{
>>>
>>> I note logic wise it is different from ipv4, it is looking at the fs.
>>
>> I'm not following you here. They both get the l3_mask and l3_val from
>> the flow spec.
> 
> yes but ipv4 is buggy in your patch.
> 

Agreed, will fix that.

>>>
>>>> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
>>>> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
>>>> +
>>>> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
>>>> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
>>>> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
>>>> +	}
>>>> +
>>>> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
>>>> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>>>> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>>>> +	}
>>>
>>> Is this enough?
>>> For example, what if user tries to set up a filter by l4_proto ?
>>>
>>
>> That's in the next patch.
> 
> yes but if just this one is applied (e.g. by bisect)?
> 

1. You told me to move it to the TCP patch last review.

2. None of this code is really reachable until the get ops are added in
the last patch. ethtool needs to do gets to know if/how it can set.

Bisecting would be a strange way to try to debug this series, since
functionality is added by flow type.

> 
>>>
>>>> +}
>>>> +
>>>>  static bool has_ipv4(u32 flow_type)
>>>>  {
>>>>  	return flow_type == IP_USER_FLOW;
>>>>  }
>>>>  
>>>> +static bool has_ipv6(u32 flow_type)
>>>> +{
>>>> +	return flow_type == IPV6_USER_FLOW;
>>>> +}
>>>> +
>> dr);
>>>>  
>>>> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>>>> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>>>> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
>>>> -	    fs->m_u.usr_ip4_spec.ip_ver ||
>>>> -	    fs->m_u.usr_ip4_spec.proto)
>>>> -		return -EINVAL;
>>>> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
>>>> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
>>>> +			return -EINVAL;
>>>>  
>>>> -	parse_ip4(v4_m, v4_k, fs);
>>>> +		parse_ip6(v6_m, v6_k, fs);
>>>
>>>
>>> why does ipv6 not check unsupported fields unlike ipv4?
>>
>> The UAPI for user_ip6 doesn't make the same assertions:
>>
>> /**
>>
>>  * struct ethtool_usrip6_spec - general flow specification for IPv6
>>
>>  * @ip6src: Source host
>>
>>  * @ip6dst: Destination host
>>
>>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>>
>>  * @tclass: Traffic Class
>>
>>  * @l4_proto: Transport protocol number (nexthdr after any Extension
>> Headers)                                          ]
>>  */
>>
>> /**
>>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>>  * @ip4src: Source host
>>  * @ip4dst: Destination host
>>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>>  * @tos: Type-of-service
>>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>>  * @proto: Transport protocol number; mask must be 0
>>  */
>>
>> A check of l4_proto is probably reasonable though, since this is adding
>> filter by IP only, so l4_proto should be unset.
> 
> 
> maybe run this by relevant maintainers.
>>
>>>
>>>> +	} else {
>>>> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>>>> +		selector->length = sizeof(struct iphdr);
>>>> +
>>>> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>>>> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
>>>> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
>>>> +		    fs->m_u.usr_ip4_spec.ip_ver ||
>>>> +		    fs->m_u.usr_ip4_spec.proto)
>>>> +			return -EINVAL;
>>>> +
>>>> +		parse_ip4(v4_m, v4_k, fs);
>>>> +	}
>>>>  
>>>>  	return 0;
>>>>  }
>>>> -- 
>>>> 2.50.1
>>>
> 


