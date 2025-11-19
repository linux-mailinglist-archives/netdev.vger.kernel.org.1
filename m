Return-Path: <netdev+bounces-239848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE2C6D114
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4A7F4F2796
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAB31ED89;
	Wed, 19 Nov 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTJo5Spj"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8E313525
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536657; cv=fail; b=cob/cB71s2eV3ZsdE5ZBFwTV5q6q1NZQqKt95cVvJXuqGsLTMXDIGZ5+My9sEs3qFUMpVYksyWqWSgdM0UZaY1PJV5zrwuVtCyF0SkArt8xQFBeWsZMmI4O8sh7AWtx6UCugU8nhFT8tYYXZInQ4KqmXJxd5zyXlrjZQV/0mYRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536657; c=relaxed/simple;
	bh=eG5ZW6CT7X7e4mOmtGZ/hJgcLoDUu4xxjgSsVT1aOoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eS/b9ZbEY3bqEBYUo2cDP92xCaalGwIhmZvHB4XcHp5ywzMxRurOAZJcoQndvaQn2G5NlUuR5207hH6oBJkSAu+cPb56yk4Q+dBquMNlePI44wpSUN8IFWNKfIUrf2Gy+PLLcx7hoXjtF6IgGTRMBGBP7eJhfUqJF3uiIe0QtdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTJo5Spj; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJzuhJUhgIbi5mGWr8Dg8XRrtgPpIRh1G+sB2XYuYKfhH6u673Y0dNMGK4XeOOVqsiIuFPfxV194szJbvaDTsrrqMLqj+qrOP5Oth8AevLfpcp6aIgUZzO7qLrXdv0GH4s/xRCQj85gK5paV08Lul2TzXIgqExtiR0KST/DywYZActPGTcNHzcRtuxgmnYfAKANwZQ2MuBIG/iCjIhD9W3ykWN0be6Qc2gdjy8bvvqaYWilWEmMlRgl40IOzRp+I0p+hp2Li2/dKii6N0r+jI93MjHRf0+iH+TQ5Pn9gkI/5FJknHT+1KCrbLVtbpSvNQiRYG1WXjJorpR0mKCt79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGgzeYsF52EHq8lqEnd14p9xo6joWbaAhCIOpaN/ZXw=;
 b=aRCduwGFDh3qam90Mf9zKXU6600I6M3WLSucZ6J+3QY4TsnSQGov1TYVF/KAWwcEDR3g9ueJRF43a4ChuKy1iQuNz98sckLyz6Bb0LFFf8z/EwXKhJceft9yhMkOxeMFWRsri2U/fqk7YDC5YjslCLOa45zNyj4yMKrAFBxo4wv//nweGLz66y7V2x19TCOPKwQbPZP1q2UC9o+DZwu6VVc+OxIpRuGb4fT9Twpngz0VCDeIbvO8Kzbf+qNzvhD/tkqztYRAn350hMz8zQbgSpJYZgYVegc87ktn1WyijSeSg81KZZgpUAd49bM4RpI+LV+HiWaBr6pL0ki31Wp2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGgzeYsF52EHq8lqEnd14p9xo6joWbaAhCIOpaN/ZXw=;
 b=jTJo5SpjDpcdjlgScFgB4mG6RKx5/6SjjGjqexyFBIhGEpIxszOun7Kqyp/c7TTqaAmP4I0T/U32PQNJerl3Vk9H0yiZ3P3eHB46LNP/3IXxczYmIytegncCk15vfI1YvSX8zdipLZydtATCsO8PrM+6w0u1Hm8JARRVxrPY1tD3XjmhMrKOF9QTpIOocpS5CvZG9Tu8EQQwdZC+jrM3W2sPnTpE8PWujNuBdc9mVBfoEicIONv4CsgzGplQRi4VhBL3z0uE4+W2eFXTyRNE9AjBG5lYAD/KD0jLnb0IXMwufth28oQGvCudTTrEkUdd2vyjlTGggHkstzuZEUqiOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:17:32 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:17:31 +0000
Message-ID: <e7b5bb24-0ea0-4b73-8548-3b67872a742d@nvidia.com>
Date: Wed, 19 Nov 2025 01:17:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
 <20251119020521-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119020521-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:4:ad::49) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 68585a1e-d5b2-4b36-4003-08de273bb41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TndkTHpIWGN6M3RVMGg2LzRuRDBHMWxPM3JpR0pZamVyK3dIampRc0dhMG9G?=
 =?utf-8?B?UVlacFhGWUJIbk0xT2RudjF4bENvQUFuNVVXdzA3TnlGTGFZcnB0dTV4ajVQ?=
 =?utf-8?B?eWlTZEpGWDhsa0VzWHBEV0VnSTJjeWE2VnVHbjdab25IYWMvaDVFWVErSlFu?=
 =?utf-8?B?aEVXTXRxS2dKQWFVSEh4Q2pVTW1kMjVvaFlrRUFNa2dYZVpTcVZCaG8xajRO?=
 =?utf-8?B?M0ZxY0hjZmVDMjA2ZnhKK05TdG1mN2tjSWo3Y0p1aXQ3b2ZhaitCQVdNWE5m?=
 =?utf-8?B?ZXJJVmp4SU1ha0VJOGlsaDFEYW5VTGZQSnBjeG5xcTNzN3JKd1VpaFdSVHZB?=
 =?utf-8?B?MHdKM1ViUzJLQnBQa3g3MnhDekE4M0pVOVVuTGp2TksyaVcwdXhseG81RTNK?=
 =?utf-8?B?dlBBTEhFSHZ6MC9DbFhXbENVZ1NveU5Mc3N5MUNPRGNzZ0habTk4a3NHbklK?=
 =?utf-8?B?MUFoNDJHSGdQejN2K1lTczdWb3JWZmtqbjl5dTRBRkRNa0s0dWVxd3pMMGly?=
 =?utf-8?B?ZmRGMHNPVnpnTm83QzVyVStaZUErMTJlYUxYYjZnTkhWemVKTVlsWGtSYjZD?=
 =?utf-8?B?ZERBVm84Vk9icUxENmhDVWNYOEE4WmZwc1haa2F3WFRHWExmUFRXWHlqdUc5?=
 =?utf-8?B?WjczdS92clBmWGcrU3o3MGREYnhGbmZxRWlJY29OYkd6eDBCWTA1a2hKR2Jh?=
 =?utf-8?B?cEU0aGhrMm4xVUluN3lvcDY5dFI2WTNaelFTYms2RFBTZm9ZeDE1QzA3ZWVq?=
 =?utf-8?B?QlNWV1lCTDBka3dzTit4MnlQbm5udEh0aDFMR3ZRT0tOSzJzeUlpbTdhTkF0?=
 =?utf-8?B?N1RTMS9saVNvMFB5aERqODIwbTJnY0sycDM0MHg1eGIzUy9SMXhVbVNJa2pl?=
 =?utf-8?B?UmpNRk9DQllCODN4TTVYa1VoUFNGbVhKMlJWVEN3Vlkyb1BqL1JMNS81TWRP?=
 =?utf-8?B?SXJpSGFCRlJHbnF1U2hDS3BTMUFBRFlrSUp5eTBYK3lJNjAvQ0lFbnJ0cGgv?=
 =?utf-8?B?SHlnOEhiMjZQcnZ2dFllRDFMVERRT3h2VzBUdHFJMkpXYUlGL2ZZbnA3VDhH?=
 =?utf-8?B?OFB1amhvTUpFcDA3Z3RrMkZLc2h6L1NiZm9JL2dRZUxsYkQyQlBWZzAwdmJq?=
 =?utf-8?B?OG96LzBBUHhoR25wUENHcXJjMU5kcEtGTG9STWhqUGdsRUdNTGdqeGJhb0Zn?=
 =?utf-8?B?dzlyaWZFRDEwREtEYkhncGVOTVBZRXVpcEQvZDBvTTNwQ2crY0VsSkcwSVJE?=
 =?utf-8?B?K3psWEFOZmpEYlRDS1hWS09tUXFpcStsUlZDNjFzOG0vUFF5QTlDY1hYb0lM?=
 =?utf-8?B?S2MxR3Y2bmI2V1BoNndzVWwvTENXVHRkc3NtcTkvS0xCOCt1Z2NpWlMxTmI2?=
 =?utf-8?B?NC9ReWd2MVFyRWE3R1ZLT2Z0cjg5c3BZWUNYa1ZudmhZNktSZCtSVmNkM2xN?=
 =?utf-8?B?MVVpaDdEUzFqOTFxZit1VjQwbEVDZXEyb0tvU1lETXZmSXAra25MSmgxM3k1?=
 =?utf-8?B?QUh5NWMrR3hHRDRmYnU2eVQ4dFR0a3hEOHFDblJ4ZXRHeVFEWjJOd2VWUmtS?=
 =?utf-8?B?K2JsaTRsc1RxTEZ2dVpVUzhhN3BvVG00eVk3Tjk3SGMyNkN0dkZQVW9HSDFF?=
 =?utf-8?B?SVBmNGFzWlM2bnVId2VXS2d3RXlHV3pKK2hzaVM2eG9qVjZ3TW5Vd2p3SzdW?=
 =?utf-8?B?enE0QmdDYzZzN1hUZ3UyVUd1WkIwSXZaT1RSbjAySUF3U2NGMyt5OVI2clJS?=
 =?utf-8?B?NUw4WXplTHd4R01ya0VkM1ZVb3RGdmEwbG9WNlNPbUF0TmtzME1SL2dvQlRL?=
 =?utf-8?B?TXZHMHp0c2ZqbHJmWi9vRmt3QjFPOVRDYktrUkJjM2QrN3NxTVJxalJjRTFy?=
 =?utf-8?B?V1RmdVMvYmgwS2szL0pOYWlFbEttbkhSTlJTN3lmRitKTmg1Yjd2dVBTTXdR?=
 =?utf-8?Q?ur0NI35YhIYQvCe+WPMAUtfdOUMN/Gx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkF3TDAvSnhNQWtQQU52SzRkU0R3cVlFZ3JYZVdGc1A1cURWS1dSeStieFVR?=
 =?utf-8?B?RVpaQmJGcDhiczJKMTQweWVpWWpFQnQyYjAvU0hteWJLZm95WWlPRFQyWlJB?=
 =?utf-8?B?Q1NvMWRreGpBejhhMmpyNHF0MlVvOU54Ti95L2trSHpaM0NyT0VFUG43U2pZ?=
 =?utf-8?B?TTRqMDdTc1EyS1dadmRnTS9SZkc5VURjcmxMREplaXdjOFRMS25velQ1bkw3?=
 =?utf-8?B?d014V2FydU4vVGtCd1QyU3M3VmlFNGl3YVBuaDFLUHZTMjdwYWEyREJlblZt?=
 =?utf-8?B?SmdGUHBTMnZJdmhwNHF0eXZKMFFvZWQ3SkFjeEVOY3BKeENrOE1tcUIxVS9u?=
 =?utf-8?B?clFJQ2dibitRV2I0U2V0YVBOVkNKTUJMMjRkY1lZSWRXOWdZMXozMlpkZklh?=
 =?utf-8?B?bDRHTDVQWFdVZDZKL0pZNkZOZWN2VExCcXNoeXBzdlVheTYyUlRybEVKdjJv?=
 =?utf-8?B?eVJTRUx4QzZRVm9hbEtxS3ZEbHlUUDZydm4vd21zMU9yUFZ3OE9hdUVFMUFT?=
 =?utf-8?B?TFR6dVNoS3l0WGc3SE02YmYxN01LT2V3WlNaRXI2VnJSV0I0TWxoSHM4MTRO?=
 =?utf-8?B?M0RkVGNqREJXS2F6Nk8xVzNWSzZrendWY29RWUVycHJiOUM1MzBUallGTlhV?=
 =?utf-8?B?cmJ3UXlLUFJYeXRRKzBPd3R4Z2hIZERnZmJkTE8zNWhOWS96RWgzMzFRNDRz?=
 =?utf-8?B?RUVsWmR0RVhzeE9jaWFnenpLaExJc2tacVBGRTJ4TGgweTVjd2hsTEw4UTVL?=
 =?utf-8?B?ZSt5cFFEK3gxcFhsRkxuR3hnWVptWlV6TWRSTTBwQzRjdDZveFZKVmMvQ0xo?=
 =?utf-8?B?R3FSZ0RzYVMvQlV1NS9LU2NPUnhNdFdpRFdxWXFLT0ptNjh4SytpYnVMTmxl?=
 =?utf-8?B?ZzM1N05VdzdjM1V4VmdEczJYbTgwbVNJdTNCRGdPNmtoZ0xiNEhBNThlUklj?=
 =?utf-8?B?UE5SSDdtK3E1c1BwRjN5YmVVenVFOGFnRk5OM3o0MGdIb0NHZllFN2hDbU5v?=
 =?utf-8?B?N00ybG1BN1ZsS09QMnNSb0YrbUdBbXhJY2FhbTdrblZnenB3NHhzdU5xNzZK?=
 =?utf-8?B?SjY5OEhvN25Felk1aHhabEVyeGlCbHpBZmFMYllGOVowNlhQeUFMRWpWdE9z?=
 =?utf-8?B?bmphY3I5a1NKTUxkTWM0QStGaW04TE1DMU5PVmxMRzk4akZMU1dGRHV0bENt?=
 =?utf-8?B?Z2xLclN3YkFjd1VPS0c3SFZyUnpUMTF3c2lqK2pzaGQ0c2hwRlF4eWJUWXFq?=
 =?utf-8?B?SGx1ekNqSFpvNHpFV3VWUWxmekZzbnM2QjQrOER0K2xPTjVCK0dIRHhGZjhy?=
 =?utf-8?B?bVQzYzlQVWw5WlhyY01xOXo2NkNUcGIzbTRzRVFYUE9JR3p3RzFFMlowamJ1?=
 =?utf-8?B?MCtiVDhWRVFSMmtoSWhPZ2JzODYxN1pvTEYrZlU3emNtQ2p3OUl3MElHY3FF?=
 =?utf-8?B?NFovcVZWbm93RGpFcUIxTHBGYlE5Nng5RUxlWkpiTlcwb080dTNQMUdLLzUw?=
 =?utf-8?B?WWhtaWVWQzRRS0llUDFBWFZ1VlU3cFg5Q0FJc3hVL1gvd1BKMTdXRVZFeEdk?=
 =?utf-8?B?S2dUemJmZlVpRFdIL00zNDBnMmJPc2tkYTBqQVZhMElKQk9VdnBWTUhTK2t3?=
 =?utf-8?B?NHY5ZTB0dTlMVU9XSElQYTVjTmJhNmdRRXRqcWpIWFZycjFVT2prclNocDU5?=
 =?utf-8?B?VEErYll5RkRpVy8wZ1p0WHA5QlgzU1VOem5YN3lYL2N4YXRJNWpHRjZleUZi?=
 =?utf-8?B?azBObk5qOWt6N0Y3TVBIcDFOMDVvSmg4NlVHTW5yVjZoOTJNRlhnOGJLWXox?=
 =?utf-8?B?ZUtHVmp2WFZsYzJaQzR0R0w0elAyL2krU0Jyb2xPVExxM2F1eE5zbGxnMEty?=
 =?utf-8?B?bkhpRUcwYmVZMElNNDZMVGpHV0h0elI5ODJRU2Y5dmJtTVNzK0FMVFFOREtq?=
 =?utf-8?B?TUhtc0hnV2FyaTdCa3NuSTByNUMvYlQ3ZktibUhjQUVlYWVCT3hicjFLRUdy?=
 =?utf-8?B?SzlaNjNCQlB2T01SYmQrcnNvbE5WSzNuNE04REhTY3M0NEhUNTRaazZURE9u?=
 =?utf-8?B?RUs1bXcvMnFnSy9Ja2JVWTgzOW1QUHo4Tk1WWFRwRTJoU1RQb2w0Ym9aYm5h?=
 =?utf-8?Q?9JpGB4ceGUPel/HkQf6JqC71L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68585a1e-d5b2-4b36-4003-08de273bb41a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:17:31.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpF81VOVmsnINk40csd0bJg07FN3gMmVyuDqIczBaZsVMsmlEY/PM3DtxFjLcgrXoXkbu/E1/V+QkmWbupbQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

On 11/19/25 1:06 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:03:36AM -0600, Dan Jurgens wrote:
>> On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
>>> On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
>>>> Add support for IP_USER type rules from ethtool.
>>>>
>>>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>>> +		      const struct ethtool_rx_flow_spec *fs)
>>>> +{
>>>> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
>>>> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
>>>> +
>>>> +	mask->saddr = l3_mask->ip4src;
>>>> +	mask->daddr = l3_mask->ip4dst;
>>>> +	key->saddr = l3_val->ip4src;
>>>> +	key->daddr = l3_val->ip4dst;
>>>> +
>>>> +	if (l3_mask->proto) {
>>>
>>> you seem to check mask for proto here but the ethtool_usrip4_spec doc
>>> seems to say the mask for proto must be 0. 
>>>
>>>
>>> what gives?
>>>
>>
>> Then for user_ip flows ethtool should provide 0 as the mask, and based
>> on your comment below I'm verifying that.
> 
> but if it does then how did this patch work in your testing?

Why wouldn't it work? For IP only flows the proto field is not relevant.
It only filters on IP address, not port.

> 
>> I can move this hunk to the TCP/UDP patch if you prefer.
> 
> 
> not sure what you mean so I can't comment on that.
> generally it's best to add code in the same patch where
> it's used - easier to review.
> 

the l3_mask->proto will only be set for TCP/UDP flows.


