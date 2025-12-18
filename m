Return-Path: <netdev+bounces-245336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B49CCBBC1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F296A3001048
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744C32E13B;
	Thu, 18 Dec 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XEzI/2Cq"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AF26F28F;
	Thu, 18 Dec 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059856; cv=fail; b=pt+T0UutRtMJI6l6bsTRaUwlk0lhsIp+msYj4hszvadGdfwpC64xQnXTmPsMUk3+lgeWZUIEEeJRRX2cK4CBLheO9whaPtGuRxKlBymdXR9NThwCZCW5EWcNw/U3QqtRSvBRdVfqt0scdcihPtDru/XcrC2GnWv2AM9huBqjPow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059856; c=relaxed/simple;
	bh=7rYdJS978Y/sqEZNThSfFXVBaOjFKp41zn+Xirkb4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+Nfj75/AGSVzVSWOJKUAr/iLAnlS7Jj5IviBZsYz87VSJUYkLUONp+rpkfLSS3FltkoXeEaA9xuZ0qaUwZRpvyGTUc7gCe0NzQJy122q5SV8nfv7ngj1FCCcstH0CUsdUvpnlOSlzDArS0vrXZam2f9n00/LWtI7xQKUhZ9b14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XEzI/2Cq; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCfLzG0JWsknJHfL0bdcvil54yftVYTvZlviEROIUYAOg2SXbACqSbT2KvwvvVsx8x73iSIQI3+ZiIWez9QZAzX4VoofvXfmc1hHbs/6yQh0qt87wBcnpEEW8t/9QKq3s0Dx7Ttop5WGRw0lL19cpgHzJOKvQTwPcFDpPUwzTDBL9z32idk+f/uJ5/3UCjyy28I/kUDmTLOwb6bBAaN49pkhQNaup0R3FTRUwSzYkJjocIzGnhXiHqzSZNQ8Ks9cxBaPp5zWMeahiUgf4h+b/GowBm7DFJx3jXsxYO/uKvxCtbHIDz8gKnJtqtE0uyzoILbpdDOJTGTBrtkSXExJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVjh+T/1s6DMoCXUUo93vFpn7oremBSe+CRTc8JoTLM=;
 b=NuV9zsmSVuOWeLnwUjEipm123hi5V3GaPyaLOBVQl9WeEKOyjyfV0X/J57X14SZEYIV5sZnIjEX8s02ox6T+JEU2hVgBtQ5zBPtxFLLcZJfc8pehRKMUE37hhh4hfZrb6fU+YjP1fHtCze2Tiu7+HMM71bi33DwoguCiY2P13W//4edvrMBisLeTEPcdZnzI7xHokGoJRhXT3JIVnkWm9FOfaRvvfvJDkfN2t4eCLgGsRICUvdN2GQtoF1b1klfLNxFknOjkK5EOQm4AMv5UBbVPvlYjMVS2/Z+KTHGb/KJhnu9uK461IuynPnAV0tU4pwHrQagma3WZs0Tq78YxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVjh+T/1s6DMoCXUUo93vFpn7oremBSe+CRTc8JoTLM=;
 b=XEzI/2CqmYpDWk+QkCsxS19lZlj1Zk02qrB6Hs0KZHB8dztXBGkVyEVjp+hfS/OYWAWgqwlnyZfSxIajlcFe0m7lRfhWuw/NShdwGigOwJAVvcoWdTOG2iBnIRts3UyBWXJaUGKp4px4SpRaGIHNYMF8h0/YxG3kN18ROfgdm2kCBz7SM9NGUMlaWOAdzGLZqbF/ny1Xw9S475SQfcRZ5tWHaAnGNxmXp04UTPSetWRJYwamWAJ/U+AO0Q8xnmj3JbwGvdEHzIcbQsMi6hX+WIH59mI0rRRVOvEGvUHEX9s8Tm/Zi+f4XvZkb9rSLwF/W8U1TcM7Mycvh1Ty6N7uTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 12:10:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:10:48 +0000
Date: Thu, 18 Dec 2025 14:10:38 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>
Subject: Re: [PATCH net v2] net: bridge: Describe @tunnel_hash member in
 net_bridge_vlan_group struct
Message-ID: <aUPvPtpGvcGacG5T@shredder>
References: <20251218042936.24175-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218042936.24175-2-bagasdotme@gmail.com>
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0a14a5-64c5-4f5e-2282-08de3e2e7b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AWXb0RE4e6I30n3I1KY9ArmkqdIzUsbf8JO/waufjZmX5w/2PclCfHTL2Rt?=
 =?us-ascii?Q?8wZN2AA36ILAVjzUVNOvTCYFQ2KEOhDqmDj5Kt0iy96vPOnb72BpkMIyJGtB?=
 =?us-ascii?Q?Z6YPO4zGd74oj7/8XwdDH0kQeB0xGQUN30eSP6n6cTvCxQbRuLN8bWruUEQd?=
 =?us-ascii?Q?Td+vrZogLmkk3dnE62OAaq931itywSkdCNm5bxVFPEKZxF8rP23y+3lBTGvl?=
 =?us-ascii?Q?H4GBzB+Jl6z5iQwl43sK5jNBAnm5+X+9f3ixo0LZO2CxusmlMwjFCmu+ECLG?=
 =?us-ascii?Q?OGOuLwFLnnQCgktAjvnyZDrEUWVHWo4uN/f6RBVWIyTeBiedItBPZbmO68bM?=
 =?us-ascii?Q?E6GsZpUWBBp/n5sPoovFue/Mzzy4iGEZa2RxftGDo7p4P/xJ3Nd1YcCEjRgX?=
 =?us-ascii?Q?vvAty+G8L39v1PZgZEB5JCBifxzRdwqKCT3cC8OL0bzBghZctgeKEF6QAsVZ?=
 =?us-ascii?Q?U4LxrZ3VK3J00IuLFIhdgU9w6CjNMaHWAHlF8Ufl+yStMqC/lIZAOKeJ+Le5?=
 =?us-ascii?Q?IuecduDQyAeFPrqbcI3uR0ZCpuVhR8WxFIhSw116X4yIli7T3ipxMCtQNotN?=
 =?us-ascii?Q?Npv1N+LWwz3HbgGmsq7TXqXWs/DB9oVHJqCUBASsF3gh1USGDnfDnNhe4zzW?=
 =?us-ascii?Q?/IZjdD74cFfvJZe4U/O0cPX/S+QyLz0PZ9Ol1aABiK5mFbtFzMM3RR61ne7r?=
 =?us-ascii?Q?Bnv4OTHy/AhRkpNKsaSdcjs3M/2Wqq8O3u3vj5IKXdiS8sdF/Qs6TUpfPe+T?=
 =?us-ascii?Q?Ch57d3sE0GlwgcYA2hw9dyiKNAxOjDrXeXcQovx8wD3fKBrkpkq87IY3zhv3?=
 =?us-ascii?Q?jBXNecoAtgTdmdhCnJUtDTZr+rVf/xgwYdcQ25NDmUDpFwzK0JwBD9Zlyi5L?=
 =?us-ascii?Q?kaiy8rRgTkEKogiPblpwtbCfLqPknpsGgEehIVdGi5yT2kxx31JxPMmIUmOx?=
 =?us-ascii?Q?BFHdCt/rxkfxHh3EnycYp94ipRmsSXI1QPPdWl9WDNm1uNSfLMNF+DHlUWG3?=
 =?us-ascii?Q?zYRJeCs43WlYMz/nl1EwfXYXS55NXHMhuZfc949dYegnGL4hzv7cGBHt+N15?=
 =?us-ascii?Q?OjXQTYY6FBR+8VxBWr1XbJI3gURCZ7QAvkzokAaugZ6w0yX3SWaIH+MQyn4Z?=
 =?us-ascii?Q?nrt1xc0uwaYn+EJvYSSch1iuV9zQasXL1CKxeVwh+uI5w8ZS8zDJlZhnqMfj?=
 =?us-ascii?Q?erKpBaBHvPCU882WKbam1uKnvNuwbyn/082jhJayQpKUzp2iwZ+yff47LJyz?=
 =?us-ascii?Q?aLUBIcxhF28inwqKakYbkr1ZqJKZyPQQ/AqOD6K18UioNIDDUw3PhWVAoS0M?=
 =?us-ascii?Q?EHBu1rA5DbHnGidM/J3juVLq5lDb6Xwwfc3toR0WlQHu34Z0XWFMdy5mYduW?=
 =?us-ascii?Q?kD6LgjfWiLPuCPS1r9lOFTCvDzJxHr3H0bcyOUvyhLgqRpbKbvxPct+5DD9P?=
 =?us-ascii?Q?ctnpdlgvk80ySFr25jZu/x7phZ8vipWR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JfbvZbGLVIJQiqNc3+QdmI3Cv8G5DPQjKiMkqVUGjtxXV0CWQ5uTXq0RwTaC?=
 =?us-ascii?Q?bU3rJnUP1xD8NgRYaJznx3ktRQehq1uPQJFsS110bN3ORXBr9dcYoLWpmxMB?=
 =?us-ascii?Q?o5GCn6IxhwNIcDxFMJ/1kZMTeuBsDKInx7vkbKX/Eo2xwbG47MLD6J1X7Azf?=
 =?us-ascii?Q?FHxen585ralc8QqKhKI2+zw7Am2ZDE8Dl4sAOr1PXeptlcNFlKUD6NExrSfj?=
 =?us-ascii?Q?KoAVtCuORJ7ig8Crh5sJYzjiIgXCAdqSrDAqI6KrnmZ5BaE2dMUCiptOMViI?=
 =?us-ascii?Q?jZTKb/KRxVWNRRnLHyhj04RPW5BcllYJpJrI0E7z4f0tWyXvaY2cIXf+Fw0V?=
 =?us-ascii?Q?L5I2H+O3O2y6k030DAcOgTPo+XhFFR+1h4gGhh04CQNbFrOZBiFS+aLVMRjt?=
 =?us-ascii?Q?3U6BE0AKWAJKTTFExb8wxfvlDIliXieUzf+iIk8wSkESqtWFC+jj43GpggRx?=
 =?us-ascii?Q?D6YcqDAaKUUuLckLRQcR9XO7xr2xU3yOwvtIuD5+6MOK991mZ/7ojGZf91lW?=
 =?us-ascii?Q?YNavFFjruVvjiL2SSLIwHU/v5/omzBYWU0BEVUTdj1iEsHnErlvYhR8Z4L+8?=
 =?us-ascii?Q?Co5y7TztkKwFki2tui2pUsag12rHGuIL0PJ7Qzjz2DoKEpCJpWxju5eq/cXQ?=
 =?us-ascii?Q?ksRTz6JGKdHJjDvifP9S7F59a15B/uyTgDXPZtFNrz9JUqPZ4N8N79/ZxdxL?=
 =?us-ascii?Q?Sb5m8/YwX4sEA99U/Amta2uEFOxN+FINIAS3t2oJ0o/RSYKj4hsx+q7PgJM1?=
 =?us-ascii?Q?pr/MVEjgynmfyXPQ3xeIFARCIutcH8rzjI3KAEs1/afY12D8lL0KunB3X8ls?=
 =?us-ascii?Q?fP6W3yFQHnwAqLlLH7PdgQ9/uIMGEhNEcoZQrzqkpDTdUCvxV6x+foGdVhJF?=
 =?us-ascii?Q?QLj27VhvG94pY+XOpW5ZTJNWtF/5j5yAclfEyR3uJLPmA4gSy2zx/wv5tra/?=
 =?us-ascii?Q?UzXVXr0vC4FEfPWqcKfRBJC1igpRT1TAjadesYDjAU2C/VTy6U/Xi6ydC1Ka?=
 =?us-ascii?Q?vZsQpCkjbthIWECSjDcHQ9BM9lCuOa1TCTwLXmdPX8jJIT3Od4FvHowWZfpH?=
 =?us-ascii?Q?GAHSdHnDzcQJo+S1WVBGcHpB21uCLvg31W8m8CKjy20kL8m0Wo1BdwfQcP03?=
 =?us-ascii?Q?Eu2HPnSKGZUOL9LNnuT8dx9Onc/VwWg9u5yUoQ/KIU4jIMYOixOxoVAx4Fdo?=
 =?us-ascii?Q?MRH4oh02158seNEUD6FijhYtV5P+vw6ccOhEyx6JJK8JazTqxBVTQjaX7aAZ?=
 =?us-ascii?Q?gF8RDGmkCB9eFXyPPFC5yaOkDj3wmeASMP/iBbBUT73eUHM40z3KbynmBZvZ?=
 =?us-ascii?Q?7xILN+gQxXKiI3LiGO8JQT/Z42o0Adb6+7q1J2FZOqXCJVc4/1NN9L86QI9+?=
 =?us-ascii?Q?vANlxbuPO/Fm+nkEblMQAdG7sRvlBmtwGrtNGQPzCWOE24XXJczbPxuxpG24?=
 =?us-ascii?Q?RmaM7w1/XPKv8aPqmnO5HEjBKSbP0HTf6pEp1IguhgDLg437owX5T4Wcrpby?=
 =?us-ascii?Q?buFezwT99z96SBf1XwjYirwHefT0u8AhcwfAz+/0lP5RsNa31dQyFxXvhCmX?=
 =?us-ascii?Q?RVsmufuM6vsnIrLnwFhn7+U7mQz5YvBDE7/hZzmh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0a14a5-64c5-4f5e-2282-08de3e2e7b14
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 12:10:48.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0QbQ+nd85uw04kqIa8CpMrMiYPsudz0MXIMf5xSaMZyHnrFIRDaR/IuOAvJyw75rZnJJrWh0r362imNvrS3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

On Thu, Dec 18, 2025 at 11:29:37AM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'
> 
> Fix it by describing @tunnel_hash member.
> 
> Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

