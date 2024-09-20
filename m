Return-Path: <netdev+bounces-129030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC59A97D06C
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 06:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3505D1F241AA
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 04:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88A1F957;
	Fri, 20 Sep 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhboVmMA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D20225D7
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805127; cv=fail; b=Jl20e5vGOrprknDXLFf4uUo3eXDi+9KC76clnlHwdrT4stOsBoTqLhCpHlWAWI1upwVgmvJUWBccLH7cveyrWPTTrI9HmnILZGYTUh0B0GFJ0UeTBNJcV0j+mSh/0cD7iT1NivAW2d2SdwbF8asuYS9OLUaJOp1bintUZUEQnw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805127; c=relaxed/simple;
	bh=2j16f+bWWBMWGN0bgOK8hbTQGbMjyGVd6NVjat38it4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=sTInqrGHDBXxCDlEXTG8QrYR6fV62699dMKYGEiVhAdcrlyW8hVdQfTHhFB/7btWAkFb+dbRBGQYsZ3unltJGRMlfbfldIvUXZcb3ftqTQBJQUkA3h1MfAZmgqNzRjZrn9Ztcw59c6UjAoY8As4/rv6u2GgpWHaf3GFwQ1RL5L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhboVmMA; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsKK61EUqk6fG/U+L87xVxGfUiRldJ2TnQsUUre5KNsFv5cspwJ5vDoNWyIvUFGQVeJKDJj7AGuuKpcY3CuCBM4yZ9Q9DwM7xmSbl/glcK3GSkzido7kfSv05EvlO7K7SZCOS8SN87/BNnLRzluJAGy7dENw5Wl9dUpFJ6zC0l4dGuFaI5baausUVxLjrn27X3AS5asvCzPkhLNccqsZ6axWwQItT7mE4OMIan0upsibamjCeJUJtBdWmaRqfsWOVDjPPeUJi6VkEB8HFeWn4gufvCaHoVeZ+7fGehvIlfFlYJpfmsB6vSd5LXoxa9nks04+FkwTuzSPszIJyQIVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j16f+bWWBMWGN0bgOK8hbTQGbMjyGVd6NVjat38it4=;
 b=M6et6gc0hRiBlpCHMqhKnSdau7pVoGeoNEoh7ZQgsmRHX/AHxXuNjbxzcSGXbD4b8UcnL7YZPviXrJysX0xZr67VP1gr7y1zHHmDd1rWzOPwM8Mvqmq+Npg140o60VhkGzBe/Z1EYcIxe5nvlzO1MAdG0zgiSeJ4hS4QxFWA0vmL+XnyP6YEx9Tg6PizNWl7phKU31yV+3B5lu+K6JBs5oakw6CYreHZCd7Vcy49nx4kWue61SlEo04uHodxzL6N0wrmRrOs+8Mu79k9xlkKu3P44fIKkBq4618Gyn42yTs1dDEAdcIwxYAyN/ssib5ue/Z6XarDxCql0QyadzKXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j16f+bWWBMWGN0bgOK8hbTQGbMjyGVd6NVjat38it4=;
 b=mhboVmMAbQkbL0V94ZmdRrG5kBRQMclsO5B3lbINVGjUZnI0YMJ63bIDuqpxJ7BblKC1v3J2ITOmMcJO+9I/jsmA0RpytsZvFi1LfuESKSvFThAJN0ROcmnJ/bj1oMN/Im3U52Uxt2vDYiDVHS5nW8XRGj0vent5Sl2h+4FB1B5eBIavgncIfFcMd8pAkfzSfxpOe/jOjTbThDGqHaenx/fQLLxVblMNUP8r72F5NwFBLxMXDrj5kHFfUuUBdxLcDE6ptFs+/QbaHd2atRwON6DlIa4OFA0Lx6MXnyGNAaVX215fW9uFjLPypFL6/zXNG90BdzQqNYzYKbWBLRXihQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 04:05:20 +0000
Received: from IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b]) by IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 04:05:19 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Richard Cochran <richardcochran@gmail.com>,  netdev@vger.kernel.org,
  "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Maciek Machnikowski
 <maciek@machnikowski.net>
Subject: Re: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
In-Reply-To: <ZuO3qgO9OfUJrYUS@hoboy.vegasvil.org> (Richard Cochran's message
	of "Thu, 12 Sep 2024 20:55:22 -0700")
References: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
	<Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
	<b7f33997-de4e-4a3d-ab1e-0e8fc77854ec@foss.st.com>
	<ZuEZG6DM3SUdkE62@hoboy.vegasvil.org>
	<0ff0672d-9c36-4ff6-b863-3dce83d4d172@foss.st.com>
	<ZuO3qgO9OfUJrYUS@hoboy.vegasvil.org>
Date: Thu, 19 Sep 2024 21:05:16 -0700
Message-ID: <87v7yrynpf.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To IA0PR12MB7601.namprd12.prod.outlook.com
 (2603:10b6:208:43b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7601:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d322306-e818-46e1-1802-08dcd9297109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FhdGl0YlZkV3ZMQzhIQmNkcXhCVEwyeFl4aWlNVWJ5SmNYS1RTaUpodlln?=
 =?utf-8?B?ZE80UlRDSEcvci9CN05LdllZUmQwYkoyQlFkVDhLNmUrM1RDaHhBUkN1SGZ0?=
 =?utf-8?B?eWs0VGhDaUtPR0trOVpuMEc3cmhNNFA3YTBaeUNZT2E3MUJWUWNpYVdDM0ZS?=
 =?utf-8?B?OVJmdVVLd1ROTlFaL3pTTDJXUzg0V2pXeENmbWdOOFlvSWVudXM4Rjk2WWpy?=
 =?utf-8?B?Q1NtOFRIbFg3LzlCRnBBNitMZUtsZmtYK2hYdVRIQXR3STBSSldQR1VjLzE2?=
 =?utf-8?B?cUxMU0ZIOFljblhtV3Q1NnY5WUZUZ0J0ZnRtYU9lOXVOVHQ3aGY1cWVtMEFr?=
 =?utf-8?B?UWVrYWgrQ3ZTcW5uUGpYWi92OUU5ak5YM2UvT1pMMHd1YXlXSHZZNlI5K2tB?=
 =?utf-8?B?c3Vja202TFpHZTBhV3MzYVlBOHZmcVA4ZlBTRU9rV0NNTEMvU0dpUFBRSzNt?=
 =?utf-8?B?ZWlIaGxKV0xGQVdJcTNOeEpsc29CN3owaWNpaHFkVG41WHYxL2s5ZXF6Q0NO?=
 =?utf-8?B?SEpUNnJScXhSN0ZiT0hiRHViTDQrZFlHQ3I1Z0h0aHhvbXFhRitHci9VK1Zq?=
 =?utf-8?B?VGRUMWltNlJTU09YeEhINjA5MjFiOVRpaHRMUXByM3hhdlJteHZkMnByVjYv?=
 =?utf-8?B?cU5zVmwzRUZoVlYvTEh0dGljWnhPZGI4ci84bzFrUDg1UEI1bkVqNmVhcFFR?=
 =?utf-8?B?VmlUT29sQ2plUmgwa3RleUg4cHBWMUcrZi9rRGtvc3owTUdKVzFrMGpmMmRK?=
 =?utf-8?B?U2hwNE92NTR6b21JM0U4eDdWL3dKclBuTFp6ZHQzcGxnTkJTOURVMFRZdFhS?=
 =?utf-8?B?NkwrYTF6VE1qTXpjUjBRN2RTRndpbm4vY2l4L25EZWRsRVA3ZUVlVVg1VUoz?=
 =?utf-8?B?SG5zQ2t0L2RVeVgvQmVrNVFJb2FJdXkxREJSb3JlU3B2c2E4TXNkblZhOGU4?=
 =?utf-8?B?YUZ2Mi9XM1BMV2RUNmdNbXlwSm5GeHZ2Y1doMHVTZVdKZHF2NEhQWEZkOVlX?=
 =?utf-8?B?Z0pjaDdjTG9JRWJ6a1ZQbUdwTWVuWE8zNTR4NFhVTm0yZnMyUHJkNnJGUVM2?=
 =?utf-8?B?U292NkdlMmIzeUd4TmxYaUk4TGZGdWdNekxRb2lVd2E5TTdBdWpMblNadXhB?=
 =?utf-8?B?OWRPdmZERjFVcitlYnFZRjFpdUdMbTVSc3RpNVIxbVNmZmFrMzBSbmNITm5X?=
 =?utf-8?B?NFE3ZklZM1FhWGQ1RDQyakJTWVp1WC9seS8rNjdHRERDS05ZY0dOTlU3WEYx?=
 =?utf-8?B?c25zOTBJQXJibTBKNHJwSXhBRHhtQ2NFcG54dVowcmNOSFBqVitJZ0VDbS9m?=
 =?utf-8?B?Y2RoUVpuT3YydkV2TFcyZVhSc0w2aWM4SVNCNmRJUUxWRVd2KzUwZmpwR3ZB?=
 =?utf-8?B?SkdEU0ZxZm5LMmd6Q3pTQ0hPMXUvdUQyYmU3Sk5CMjNEN0J0a3U3R0kwV1Fh?=
 =?utf-8?B?Z09IUnJndCtCNTZwSGRrZjl2eEhuUTdhS084ellWMSthVTBWT0szclBacDhT?=
 =?utf-8?B?b05zdktsU0swNUJTcFRRUm1ibzZ0UkUxQ3V4aHhBbzBiOUFUaWlod3BaYzFB?=
 =?utf-8?B?SDlaaGNrWWdMUyt6L2FXalUyV2l2NHk4WEZzQW9WQ0dVaXp2aFhZWElodDFI?=
 =?utf-8?B?ek1ZQmdiYUdrUFlqSm5La2F2aTBsMlNPaFVmbTlvOEpPVFdxR0EveWdWWkNx?=
 =?utf-8?B?VStSVTAyRm50a0NDMWVCUWY2c1dQTmtybUxtQkF3QUVNc1dSZ1NIbVJCNkZM?=
 =?utf-8?B?YmdWVlZ1eEduZnlMZGpZZjJGU1VmN3llK2FHdWhzcTNPTEYwMklEbFQxZ21j?=
 =?utf-8?B?YkhyQUVsYXlWV2Q0UGdkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW84N09Ed2FsRTFGckxHSi9aSGREL3EweG4xTUZjYWFxeWtIb2pxZjk3MVlY?=
 =?utf-8?B?dndXS2M2TVhMRWVmRlA4UXpwZlplSWJFTEpsZHdVU25yWWNRM1hCSXh0VlZU?=
 =?utf-8?B?WDJ5cjJqVE1UZG5ZdjBDS3l6NjdJYXEwMDVYK04vZmZaQ2ZjNHhaVHdrRVZB?=
 =?utf-8?B?b2ZyV08wbmgwVXNkbnEwWENPb3FjOFhjWC9adnlDc25zbnZzMHA1Z3QxQU5L?=
 =?utf-8?B?bjdBYVBjNkpiSHVDc3pEUk9pbHRESXVGbmRxMVB2VTg0bFN2cldrcXFUbHc0?=
 =?utf-8?B?TEdzVjZ4RU9zbkU0KzQ1YldsemdDdkQxeGhLNjVlcW5xTmg3RlFGaWMwUTc4?=
 =?utf-8?B?TzNvLzhNMWwreWdVL2s0S1hENnpXVlBCNlJVNnFZTVFDYlJueWtDZDZ0amI1?=
 =?utf-8?B?RElTeUlhNWl4SUVjYU1POGRaUExCckZVK3hORG5WOXJ0RUJaWEpOTHJPc3hC?=
 =?utf-8?B?ZlJiOFM1czhVOVZpZnNBR3NkeU13TWVlT0t1UkVOZWdndUJIUUZTWExUemY5?=
 =?utf-8?B?UzJ5aWNVcTNEQkNYRmZtdmdRZVBVUU54UVQzQlZiZU9JUGdOcGRlWUFqZ2c3?=
 =?utf-8?B?VWFoK2hMbUpFd1FqVGRLQm9hRHB5UFVoVnYzU0Q2THBPQ29RbjRnNmJ6eFdj?=
 =?utf-8?B?WFJGVW5IeGFRenpiVDd6ZlYzZU5qdjdEeUNuOE1jNlh3SXc5d3NRTGplSmJW?=
 =?utf-8?B?Ui9qczlSYlNpQnkyV0ZBUVNLdlJ5eTVyVGt1REdGeDJVTStobURiRzJNWFJl?=
 =?utf-8?B?clZ4UGU1aStRZFE0NzNtaHE1a2pvWEtqRzFndW01S3NFcWtqRExFMVl5ZmF6?=
 =?utf-8?B?R253RllIdjk1N0pJdFFxVTROWUI3UEEvWlRpUUJBakpaYmJZbFp3SW44dExx?=
 =?utf-8?B?Z2YyVG05TFVOZHRRR1pEUVRGYmdqMy9tMzd4cjB4WTJmalppTFlDOXNvMVo1?=
 =?utf-8?B?WWJtdkhacWtGMlBkQWpzUkVFL2prT0JvdW0wNUFBQlQzbFFOMnRvZUd2cjlz?=
 =?utf-8?B?VzZMMFJzK3d4ejVIT2FBU2ZpMitVODVmMDlSZG9SS0lVNEVxaU5OZFZWUyt1?=
 =?utf-8?B?UXl2SDE1ZWdWUmFGRUZScVQ1ZVpQaUJsMzd5NWNvTm11OFZoUTlvUXk5V0lv?=
 =?utf-8?B?U3pPcWhnazczZnc2UCtJWFZ2dkNielkyY3pDcm41RmdaUjFicWpRSFBUZ0VX?=
 =?utf-8?B?R3JXUGw4V1Q5OTNuMU9CeTJGWU9FMk1IVEQ1Y1ROR1VPbjlVOFF1OC9rMHIy?=
 =?utf-8?B?K0IvcEhLeWU0dytEZ2NlVjhackc4L2lTM2VZNG9weU9EejFiNEVuWEJ6Rm9h?=
 =?utf-8?B?Mmh0OFFDbkN3L1R4Q0VqRElrcEhSQW5KZjVPeXZuQlozVWpKRFFrM2ZKUnRB?=
 =?utf-8?B?UWxoNlhWU0VQcVN4ZnlIQTdmd2JKNWF0cDBrUDlSOEg3QmtIWktDeWZEUlhZ?=
 =?utf-8?B?eUdwRDV4QkdEbnlxY2FCVjFKWTZPNTBnek1CRWlBSkNSaE90bUM1US94ZCsx?=
 =?utf-8?B?VnVHVU1CTDRsT1pQVm84cCtaSmFwQWZRSHJmT1pETDFacEFoMDBObCtudkRh?=
 =?utf-8?B?N1FZUm8rM3RhZHNaMlVkOTdkRS9WbEs1RFNQZmxObkRvb0N0bExOTnc3ais2?=
 =?utf-8?B?Ym5TblZHT1JwSjFVcmluMDhqU3ZJb0swa3ErMkV6bDdpZHhER3Avd0FiZkx5?=
 =?utf-8?B?WjE0VTlHeXRvdkk4TVUrRVBUQzErd0VkOWRnM2d2ZExDMHB3QitWOWxLYXlx?=
 =?utf-8?B?dzdwMDhRQmlJOW5sTFRYdEpsaFNUZzY0TjhSU3pGa1VnNVN5ako0b3NQeE5i?=
 =?utf-8?B?T0x3cG90dFhSVzNtSVdjUytJVTFYaHdJdVA0RSsycGY2cmQyeVNlb1lFTm9V?=
 =?utf-8?B?ZmFjMitOSzYrQTRQM3ZIUisvcFNKaDFIcHNpclFzNWkrK0JZaWJPdjJmUDZQ?=
 =?utf-8?B?bm1LaTR0eTc3RGJhWlVQVEdHdHEyUkdENnZBbmcxZG5MeEJKOGx6SmNIRnZk?=
 =?utf-8?B?Qk9JaWdUOG1VUk40SDBNeFVaWWhobmVUcXNSWm1QSjN0Uk52bmpzMkpHZDBT?=
 =?utf-8?B?dFkrb3hxaEp5elZZY0pyczl4aFBNUnkxZ3lzZ25ockhQbTVYU2JyVzA3UXc0?=
 =?utf-8?Q?Xk1IjEZYEu33hIqOZDp8CuVa6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d322306-e818-46e1-1802-08dcd9297109
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 04:05:19.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nm8qpHxwi1W+3QxKZgPhmo7m1a2M94FWTiBi+1A1EOwtgYU5+DWplBFs8zPgxsg4Yynf2mes3SPWbJbqInWRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

T24gVGh1LCAxMiBTZXAsIDIwMjQgMjA6NTU6MjIgLTA3MDAgUmljaGFyZCBDb2NocmFuIDxyaWNo
YXJkY29jaHJhbkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAxMiwgMjAyNCBhdCAw
NDo1MTo1MVBNICswMjAwLCBDaHJpc3RvcGhlIFJPVUxMSUVSIHdyb3RlOg0KPj4gSGkgUmljaGFy
ZCwNCj4+IA0KPj4gDQo+PiBJIHB1dCBpbiBhdHRhY2htZW50IHJlc3VsdCBvZiBwYWhvbGUuDQo+
PiANCj4+IEl0IGlzIDoNCj4+IA0KPj4gc3RydWN0IHB0cF9jbG9ja19jYXBzIHsNCj4+IMKgwqAg
wqBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1heF9h
ZGo7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqDCoCAwIDQgKi8NCj4+IMKgwqAg
wqBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5fYWxh
cm07wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqDCoCA0IDQgKi8NCj4+IMKgwqAg
wqBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5fZXh0
X3RzO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqDCoMKgIDggNCAqLw0KPj4gwqDCoCDC
oGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbl9wZXJf
b3V0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqAgMTIgNCAqLw0KPj4gwqDCoCDCoGlu
dMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHBzO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqAgMTYgNCAqLw0KPj4gwqDCoCDC
oGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbl9waW5z
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqAgMjAgNCAqLw0KPj4gwqDCoCDC
oGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3Jvc3Nf
dGltZXN0YW1waW5nO8KgwqAgLyrCoMKgwqAgMjQgNCAqLw0KPj4gwqDCoCDCoGludMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRqdXN0X3BoYXNlO8KgwqDC
oMKgwqDCoMKgwqAgLyrCoMKgwqAgMjggNCAqLw0KPj4gwqDCoCDCoGludMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4X3BoYXNlX2FkajvCoMKgwqDCoMKg
wqDCoCAvKsKgwqDCoCAzMiA0ICovDQo+PiDCoMKgIMKgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByc3ZbMTFdO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qwqDCoMKgIDM2IDQ0ICovDQo+PiANCj4+IMKgwqAgwqAvKiBzaXplOiA4MCwgY2FjaGVs
aW5lczogMiwgbWVtYmVyczogMTAgKi8NCj4+IMKgwqAgwqAvKiBsYXN0IGNhY2hlbGluZTogMTYg
Ynl0ZXMgKi8NCj4+IH07DQo+DQo+IFRvdGFsIHNpemUgaXMgODAgYnl0ZXMuDQo+DQo+IEFzIGV4
cGVjdGVkLg0KPg0KPiBTbyBJIGNhbid0IGV4cGxhaW4gdGhlIGVycm9yIHRoYXQgeW91IGFyZSBz
ZWVpbmcuDQoNCkNvdWxkIHlvdSBzaGFyZSB3aGF0IGtpbmQgb2YgU1RNMzIgZGV2ZWxvcG1lbnQg
Ym9hcmQgeW91IGFyZSB1c2luZyAobGlrZQ0KdGhlIG1vZGVsKSwgdGhlIGtlcm5lbCBjb25maWcs
IGFuZCB0b29sY2hhaW4geW91IGFyZSB1c2luZyB0byBidWlsZCB0aGUNCmtlcm5lbD8gSSB3b3Vs
ZCBiZSBpbnRlcmVzdGVkIGluIHRyeWluZyB0byByZXByb2R1Y2UuIEFsc28gY291bGQgeW91IHJ1
bg0KcGFob2xlIG9uIHRoZSBwdHAga2VybmVsIG1vZHVsZSwgIi9saWIvbW9kdWxlcy8kKHVuYW1l
IC1yKS9rZXJuZWwvZHJpdmVycy9wdHAvcHRwLmtvIiwNCmFuZCBjaGVjayB0aGUgc2l6ZSBvZiBz
dHJ1Y3QgcHRwX2Nsb2NrX2NhcHMgdGhlcmU/IElmIGl0IGlzIGNvbXByZXNzZWQsDQp5b3Ugd2ls
bCBuZWVkIHRvIHVuY29tcHJlc3MgdGhlIGtlcm5lbCBvYmplY3QuDQoNCkkgYW0gaGF2aW5nIGEg
aGFyZCB0aW1lIGJlbGlldmluZyBjb21taXQNCmMzYjYwYWI3YTRkZmY2ZTZlNjA4ZTY4NWI3MGRk
YzNkNmIyYWNhODEgaXMgdGhlIGZ1bmRhbWVudGFsIGN1bHByaXQsIGJ1dA0KbW9yZSBsaWtlbHkg
aXQgZXhwb3NlcyBzb21lIG90aGVyIGlzc3VlIHNlZW4gdW5pcXVlbHkgb24gYXJtaGYuIE15DQp0
aGVvcnkgaXMgaWYgeW91IGhhdmUgYW5vdGhlciBjb21taXQgdGhhdCBjaGFuZ2VzIHN0cnVjdCBw
dHBfY2xvY2tfY2Fwcw0KYW5kIGFkZHMgYW4gYWRkaXRpb25hbCB1c2VkIGZpZWxkIGluIHBsYWNl
IG9mIGEgcnN2IGVsZW1lbnQsIHlvdSB3b3VsZA0KZXhwZXJpZW5jZSB0aGUgc2FtZSBpc3N1ZS4N
Cg0KSSBkbyBub3Qgd29yayBvbiBQVFAgcHJvZmVzc2lvbmFsbHkgYW55bW9yZSwgYnV0IEkgYW0g
aW50ZXJlc3RlZCBpbg0KbG9va2luZyBpbnRvIHRoaXMuDQoNCi0tIA0KVGhhbmtzLA0KDQpSYWh1
bCBSYW1lc2hiYWJ1DQo=

