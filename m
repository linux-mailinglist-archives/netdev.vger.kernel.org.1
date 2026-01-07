Return-Path: <netdev+bounces-247723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C316ECFDCA7
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D4030E8038
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F83254AF;
	Wed,  7 Jan 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gx3KCq3X"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613063254A0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790305; cv=fail; b=tLsM3fRkOrcMYTTi1utRbXeZYvLDP8RBcqP8fZH1FCz0D3F1/oEz68xpnq9qJSCEcKhXqXZFTbArPmRASl632/41083XCQ8vc7ucAf+H1IxYZaI7gPgYo+FF7k7A9ts5nn1YFCuyG+i9YIXIl/ADwQbg4+OJtzCur72eiB1gVDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790305; c=relaxed/simple;
	bh=UFtO5/NodxHZ+lw/aUfPnS0W75AB+LhrmKGkniLrGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCPhO1kSXm0fSG4xmsT8LvT5C2WiKMTikgyB6uhe/jVHqJwxU0vsrmPCKXJ9xoef0k9YOCyLQJPcLK6BpLAFWhsIbOGnfOlhTrpRcRH5dsSvuZuLuNM5q5r7Fjj64RImPs5d1PPxMOcOroOlerEkNSgzf/MWYb9EjhcsJdixFh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gx3KCq3X; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzNafCw8pDWupR3yAXlh6mc8LMZV/mP6DDdaGrysZ0xstYvx4GvxETVKTTUe+Y4sCxwANEBn2Iw8S3g9CdjytuBdSXmdwDtSXTSxZYJPa7mHVgvam6CSxkDl0Z6xEujSGT5UZZb8o3NdTmoo5yeV9n2OYEC3kyF2Gft8/tqP2awypen6TBf9yG+HjJkwjFBxnyKiK1mQKv9V+ygaxi5/K/wE3m/QRzakj1LjmYqHFgkc4CxznU8R/MSUThx14SsfAOy4Sui7xBqbNH9cUXboDs9za8SwojpFGeP1kZfLPFbRy4zohHeDm8a83t6b/6bptBA5W9x55wWNwvN6ZJhCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFtO5/NodxHZ+lw/aUfPnS0W75AB+LhrmKGkniLrGb4=;
 b=hAQtogdEK1Nit9bFM72fO3xo/EJ6C7vUPnlzl7RT8N3og2nTW2cPXDD3K48NXCLl16Sd0pzokbISHlmNPPwTDgwfChthUEBZ/9P6t5Nz+pfGuWeJdOIAcBobQ8YTnLkAWALLqKnvw5vbrKKvYU+fnkvP2AvEXWeAfi/CK7CycSKXvJ7atbAWgUroozsZXh+l0bU6mjvwzPQrJ6a+GVHuq9k0maB/mPj2H79z60x5O4YCz9W+ZUsc6bmKKTnI1+HhpHDVhrh7ku/CLhx0hVLKrOyWNtWZXlkLxo9R1UD/in2eTCaESKIJEXxfGHjOQrS0e9AH4T+Hgi7MLBSiYf/G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFtO5/NodxHZ+lw/aUfPnS0W75AB+LhrmKGkniLrGb4=;
 b=Gx3KCq3X8Leo8wCZBgdhwvPUPu30jKCRildn/KsJmzjZZzKGm18hUU1nz7LHrRGUMmRlWvVTtsqv6whXlD6/nx5CcLWNJWNNcR2F5z3d1usC322Dq4jaL24lLnpH8+bD60Dy5KExACFhkyaidAcwxP1OQEQ5gk6dbcng6asv0AcTbOpIdSfXE80maKHcLidNGJwPaF5eBPpTgkvKYaJt7cYRr+gOWs0zCxRcxqAHbSB9tduiwcvX9BIl6iMDzemXyvNVZz7XoqMZLl2+KvGsWE5ILGwPbp9+mXdjSuNr4IUr1aq6D9I9TW80Xtg762/oFFtPjudu9IRRFCT7AsNsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 7 Jan
 2026 12:51:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 12:51:40 +0000
Date: Wed, 7 Jan 2026 14:51:29 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org
Subject: Re: [RFC PATCH net-next 2/2] selftests: fib_tests: Add test cases
 for route lookup with oif
Message-ID: <20260107125129.GA482189@shredder>
References: <20251224161801.824589-1-idosch@nvidia.com>
 <20251224161801.824589-2-idosch@nvidia.com>
 <f2ece8a4-1eaf-45c6-8861-27042d275b92@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ece8a4-1eaf-45c6-8861-27042d275b92@kernel.org>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 516b1813-8f3e-4b13-959c-08de4deb80ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/JvZ+obiELeVdlCDDEfLUcjYIkQVtKejk2ThCnlW5t1jwIZ5vSFeZ5wNALv?=
 =?us-ascii?Q?7uJbub5pjBbwCPLBcqwtrSWzKSCRjVkM4gEahOT3VY/KxnT1bI1QI18+pt6/?=
 =?us-ascii?Q?WVvidRV39ds2r/0+FwcI6piVI5DjflyTgcpVscNTV8p+ALEJ5RznhNf3pop7?=
 =?us-ascii?Q?EF67ZNZZGyQN8Xdqt+NcuPzbWcUJyzMaKhG+GBbEvEOTDk3Wg7Ir27I0TjPd?=
 =?us-ascii?Q?sCmQp58vpIa1z9EtI5K6nYOMheGB+JteWnTlTUkmn5oddF4/6vC13cgZnP8i?=
 =?us-ascii?Q?e46vpEDIoYuEOJaNjob1cvpRYmqGSsdYn/IcWYa1eZF4hNcdUu5g3WZvZ24V?=
 =?us-ascii?Q?aSVaFJwxii23bKNZyvPNbofSFo0jJIeJAv4UXOpfd/52Y6LGHaXXoHxm1kpb?=
 =?us-ascii?Q?t6/KfUC9dfWYc54EZpdpvd3RIH96ycS/ED3Rx1qR6kqkdt4Jya42zQzAa6+W?=
 =?us-ascii?Q?BQBQCxxmL7Hl6uL5E5Ws1tLjeAOJdg4GY36MYvyA7rHKbxX0g8Tnwol5sYBu?=
 =?us-ascii?Q?Inmi/MwGRi8S2TT41HYXQ7LED8q5rIOyXDnKvNgO2zPkHYs6Y99eehVos1KS?=
 =?us-ascii?Q?Qppz745RyTRBh4JHVOGHL+G2hXO4ZRuFZUThAkYwdb1ucwoNGAi6L1OHWKu6?=
 =?us-ascii?Q?xfFuBvss139F+wyT7WjWCGB2PQa+wHLgyG45WN65I9hMOWzQJ81z5HGx65/F?=
 =?us-ascii?Q?AK0WLUY0/E2y5zFhwd3sImbaFStz6shMxq64jEmjJwvLakLYwG7n1UkxFMQl?=
 =?us-ascii?Q?nb6EgIoid8Q/rsrP/6iKUOczbdp+E3ygvHfnv6VuA6K0+mi/egHEN/+FJkFK?=
 =?us-ascii?Q?WIUni+LglQV3hzbZj6B4fw0gsBERKSjVGh46ldYs64gL1cm71T/3Eg9zaodG?=
 =?us-ascii?Q?Phu/DGwqHgrZuiL5G96OfjBXSaP0XVrhTczibOEV4PeUGXO9PAvhGbEjb23j?=
 =?us-ascii?Q?ld45GHlnuY1bk4W3aeYqP4An37yK7NnWT8QE7iWn9IMDCco0U/gVNV92BQQN?=
 =?us-ascii?Q?/ijjdErREzbvAmo9WN4Ewihcs+NZafwu06qq7lgFnqG3JkNuMRNcrBTuTW8g?=
 =?us-ascii?Q?hNLmH9FhEUqHPcHYgM84NIXU9+cW3laCSh+5dpu5u/BYxYyWSkvvomhP/eVA?=
 =?us-ascii?Q?/hUZHPHxK/v8K0UVdTgZKsZccTcAsNH1FxuW6FdVD34ji7HWl9usuZ6ziEJP?=
 =?us-ascii?Q?SfmEkgB0X0LYYYix+5MNKTp8tVZXmUwz64XrDtXMFZLpZLJf9oxNv7g2a94S?=
 =?us-ascii?Q?yEUtu13JIDF2yAfDBHAh2dd17z22h4TS7SH2p/8cYmucwvEpSBl0vpfZvHOf?=
 =?us-ascii?Q?7URQqhZY4YfcN20oXw/Pt0v1K3PN08cSgeFFJUvcLamOU/btzsQYy1h0svW0?=
 =?us-ascii?Q?YfEA/Qbh/exIcsuWGz0jpM4OyvrP3X1kWdrQm9KVro7bQhhFeEFEFjWcpvVD?=
 =?us-ascii?Q?p44Z+DaC9AveH5IChQ0KTc1TNXTJP3gz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7TC7tBsbG0UNfydBaN2tDWaCPngZY4IFBbf0XDK7LDImO4A2m3qbEfElr/K?=
 =?us-ascii?Q?Zk55Qi2eAxck8umW1A2JxSlM1SW0ViEPaHUOuBoK+3UMm/KYPAp0ypCWzXuv?=
 =?us-ascii?Q?IB07kdiaYRHvBQftyumxHUPkuZolZoHMMsvXxOYxUBnB0/Majx/8l3sUa/Iy?=
 =?us-ascii?Q?0a55gopnr3zLQgWWC+cFSmL2KrgKILtZ5K2GYWQjomb2SGua87bpZo/bZQCp?=
 =?us-ascii?Q?dXeF42rXElSJo7vZ4MHJCbIr0sedVcYXMVoDWYEZMjb4rxy/QaNQtA8BUh9z?=
 =?us-ascii?Q?owbEcQNTiBzrcYs7joHR3HXa8yEt3RQ/WgF4w4sbcLJGnjGM7fMbxs8NmQ49?=
 =?us-ascii?Q?FW7CgzHBHsT8yuxLgfwAEt2wx4m0pzapCMxUMJtYs5552/um2iIsEj9OX33L?=
 =?us-ascii?Q?Y0lW3yGO3Ob7tGre3jqk5GLOcs/HBoYsrewvidU9cfa/6Cco+joVvzjjstLT?=
 =?us-ascii?Q?DfvJMVG/f5/tR2WGCTx2aeIJszSZVeiSZ9FIFQjeu6gu+0bExPYzQD969lom?=
 =?us-ascii?Q?kU+jGYWicyFeAFG3eB0TgHWIFm8J8TNxMgPfE9fbCgG2Da8Vu0idbjmQHHDb?=
 =?us-ascii?Q?Iq6CnwwFfkiPsxAZF2hcCp+5f6hvOWuugMbHODKlxi2nCeoi0/F3f5PVa1/1?=
 =?us-ascii?Q?qrprt+j2hSW4fQTxxuqqVtwU+ZIsQ6eq1UwHyBcqEsOeUzdN/8bFueprOGNh?=
 =?us-ascii?Q?L22kPEd2U076MtQa/i04Eh6HR0ed71baGcRWrSFidaujeT91o0vvuWASWg4y?=
 =?us-ascii?Q?Wmcph2FYstiTpKIfhTtunrpfGuDirkeMhHBj3bZ1tuc7yI2x4lYXeQGAeHkB?=
 =?us-ascii?Q?roq57rMZPsC7XhZ+ka+fLzO09JN+nSLLGGAE41pyhrmroh6yt2am/+rIkQeQ?=
 =?us-ascii?Q?c/Ey2JSlr5P21eVrUVcW0bvn7+FKbD/de1FQzfwhD39Iy8P5GMaUmuwQMbYx?=
 =?us-ascii?Q?Uf6BvzcsPg9yZEkafk6MJdZuoUw0HxbSwud3zpvsv9DgZ0QVG7yuH7EpZS4y?=
 =?us-ascii?Q?YWsB7JESG/FSiHVk+d9JYkJOCsUl2saCtJQwEXrRsQKZcHfhcEodXgC3ionJ?=
 =?us-ascii?Q?zKD9DM9eIIC0yiEWLPwX4vTbEE3Y+P7P+r2+s4YwwUBe5Iyl/KSUPSjpZ7dk?=
 =?us-ascii?Q?srlMjdwJrp5rY1Wv3PQ554pyjhiSxnwcsgWlgwyijVRKuQNryQFJ4NfK6t09?=
 =?us-ascii?Q?VglRD2Nz5/YrNL0lXdZ2wHCNV3Y6yGvCEahPVifWfHTRgFraPDR567RmZ2Wf?=
 =?us-ascii?Q?7tRkobG/ZQvM+WKYBVN4mPbFP23tDNohG39oltZOv7s+xbfetTxCCuWog2Hc?=
 =?us-ascii?Q?blpWVft/Dfwh0S0bLPWtb/aq4oSFFVRqUe+YowjmZ4rx36RkM8v/EU14Hy42?=
 =?us-ascii?Q?cZDldVGP5Ec1R4mZ2YjJNZSqmqyKZ6o7B9L3/EF7FvZM6QgaqnA9/f6KbeXK?=
 =?us-ascii?Q?+SEYoQXAZC97OumxHtjFJoUVeP4K0ZdmhJewTvDFxIm9yf7n1yxqYpRPti9C?=
 =?us-ascii?Q?kD4bBMiR3JvHeH/AlitacvJQHne7G236MLxa2oTbJv65BJetDGKPu0L8c5xx?=
 =?us-ascii?Q?vDfm6B/GCZxUrkaYiRQmihX7pBbdoZbZFR09v9c3AHjaHXUotJOmxiA49Qog?=
 =?us-ascii?Q?zREoTqBZFGcb7+SLy+KJ/HPkb3EGTI6tfpKBIpcBpjwh4dmgBTuIoO/WVu/T?=
 =?us-ascii?Q?gElZoQf8HSzh5lNDIGSZRHSGPIBnnsMZh/v2nTYEk0dvcVhY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b1813-8f3e-4b13-959c-08de4deb80ca
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:51:40.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Npc/RynnYw/gNsvmJIWj8WUcVfMRhMcCrhUHvAnaWJJ/SmnWv2Pv1yroJ7lMWebljajbzBYP2tXAc0HgIBglSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

On Tue, Jan 06, 2026 at 10:59:53AM -0700, David Ahern wrote:
> if VRF versions of the test also pass, I am good with the proposed change.

OK, thanks. I added VRF tests and they also pass. Will include them in
v2.

