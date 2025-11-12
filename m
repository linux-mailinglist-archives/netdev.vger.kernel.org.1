Return-Path: <netdev+bounces-237822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A1C5097E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2113B1921
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D02405E7;
	Wed, 12 Nov 2025 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOafgz+5"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E744C63
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924563; cv=fail; b=CCkSev078zjjhAG3GmmY0q/jwPSpe9ferB+17JbRrjfARQ/6KXZehqOwFoIyqk1whgenG5bV0RLfVR/l85yWrCskY0Khzs+65DfgPz2lwKY9Da3YuKrpQL9KSfSA5rb3vgcrwmLq1yamNKKT2plOlSwPSrjrwCqJnXO2Mw3CTz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924563; c=relaxed/simple;
	bh=G8Ro4aIT7T2Mr9uQSN5ZgdjMeLRHXCOW70Pbn6Q0Z50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PUBBBIseXXo6ZXf/tyRJrQitHbZAM8ObLxMdR/Vw3sPExIdkZj/2C+lQa15zlmmbThObHnXutQgHtmLyNl/39tLLgGBUUprwt/gGQqeCbk8WvxrpgPdxd0kPXShunsQUk+6smzDyIDPJA5wu6cRW8ofuqWZRk2XBc7BsjX3EpJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOafgz+5; arc=fail smtp.client-ip=52.101.53.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2Wm9nOeJjUwAbezEXn68UBzjaadP7TrVHnUCvBTYb05c9svURRPZNJpo2AS/BgHie7MK0MVq8xrS1JWXHepd/CJSBwS9OZ5S8zXi7Knf/Im9xVb3wqBQBzvLIc+ccs/Qup/q3noJoxwOAgvmbN7NLpxoSa6L4cfXVPcN45ZgDZBqlR0k2CcSHIpbGbcKOry/6oVIaHJaqGsCRLoeYfWrfvh+WpFsn7EDFuI+OSNFi+bKRMy4yQRuUdfeUvHjfoba+wrjWLm/JU0rG+wjXs9ysWeDBh2Ne6KkFNp56XNAutwUWGImOkg/PVpUHqRp9s3LgB6ubGeO+XmkuvsrnEFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCpFv+AH6Ijht+yc2WLDCywxy07bNyn8ah+nVgwdkOA=;
 b=PRNq7GZRqcO2wfhf1xJmfJ/WxgbooX1gnrJR1RxMP1Rru14x18EZD+3SVUaKvqMliwHSGLuxzIaFOH6SqN3t05aGLBCeT5tBassf3U9RBlCrZTaFTIf1s8lRsQXWcI2aw/OqY8BBZ4FKcEn1topjjnlj3syKYbx6+jwzbSPxLqUzjpqynGZfIp/MVRZjeBVkZutFjRy1wU+mh+iJg9xMdI2Eyzr/grfO6wzVOLuLIcLVTiR1EuTGkKJy4N1uxavPrV5UcdCujUOSXhuoRVK2cZi1W0cEPh/8BsX1394gCOQRmzC49ArDcE8XcL6oSlatpC3zHTh4Jo8zejq/yOjSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCpFv+AH6Ijht+yc2WLDCywxy07bNyn8ah+nVgwdkOA=;
 b=sOafgz+5ZUwVhU3QbsZWPdviYWzJy890NNgIXvezFcihUxZfNmsuoSWIUTGxnIJ+kbWA/VezYqsppaJIK2RdI6TJjRsSS7BZcauuoffGtLKG91jZLCfRD/HFPFA9uHlECz8ZEVePgJbBGRRxYbilb8Y4D/F68gP6vCta1yvj545fHgzmUih3aBT/XAD72qZTWSgjhns6SP6u561oktj5dhCj8ed1oW++NUNGe/+yl6k0Q+dY1nqf5RawuDSbsJ4IBeKm0+3AYahZPse4c1z4xL4VWqNst4Y/Ij2mKZG03e0CbkrzZapWF+AIbIgaLuVtaZzIa9L25ChukV+74SXmdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:15:58 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 05:15:58 +0000
Message-ID: <ada8b5c4-2a9e-45d9-a9e1-28fa50afce8d@nvidia.com>
Date: Tue, 11 Nov 2025 23:15:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
 <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
 <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
 <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 66922202-416d-4779-6315-08de21aa9039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjNSOTFpSlZiRGtXeityTjVWZlF0bGdNLyttZkRyMWRDakhpbFhaMklYQ0RJ?=
 =?utf-8?B?WVVrSG8vVlgwL3M4K2hpeEhZQk1qcFNtbHZDTHBKWEVIcnM2NHVJTHpZNzQy?=
 =?utf-8?B?c01ZRkdaYzVta25sNHhVVDVTVUtSYVUrU3JhVUwvYXRWejZzOXE2Zm52ZU5x?=
 =?utf-8?B?TVkvSHZ3emVWQk55V2h5L0h0ckZQQ0dGMmVad2ZuZXBndnRnWTJQaEVWaDJJ?=
 =?utf-8?B?cmM0WjNzTS9vbHprVDcxYjNWTWxvaVBzL251ZWZtTElZQlY4aDZuaDFTeUhq?=
 =?utf-8?B?SWhOb2NiUkZPVHZMTGllZmtlbGxXM0NaMlZqQXZvMmRCKy9tdUJ2dmd6Q2lY?=
 =?utf-8?B?N2MvS2JQZnBTRTR2VkYxZHZIaHBub3BndW5tWWtGNjM2ZG01UzRXMjIzZ2cw?=
 =?utf-8?B?N3RhUEtKMkgzNmF1QTJidkVLbUg0T2JYSE1YQ2Z6Z0ZFcjFMWGpkMzR3dzEy?=
 =?utf-8?B?YW5NZ0M0TFFXWFRPS0Yrb1BENnJXZkxiSGV6KzY3bkVSWGxFMytRejRIVWF1?=
 =?utf-8?B?U2dMNkdkUFlNM210cGpiNk0rRERvUStXTitEcWV5QkwxZUFsQUV6Z2NPOXg3?=
 =?utf-8?B?Tm5MSUQ3M0FsT1NlVmhrbC9ScWJyR3Bod0lpR2NZWWpyRithVnZ4bGlidFVM?=
 =?utf-8?B?Qmg2dCtrSDFVSWhvbGg1MHpBeXVJU1VyQnkxRGw3RmNtM1A5V2ZTTHVWWjlG?=
 =?utf-8?B?L29ucWVkUExqbFdpMk9KOVFFRjcvaDlhVFdJc3BGa1RxWGs3MkFRSzZqNUhG?=
 =?utf-8?B?OTNiV1pZMGxTVnhrMHBMYkRwVmdLMVArcmVUeUI1ODBRLzkydUM2YVQ5VkJ4?=
 =?utf-8?B?ZEFiZm1LQ0F5WERTOHNGbGpBR3JDMW16VjdUTGx6SjdXaEphTld2YjBCcy9W?=
 =?utf-8?B?T05YSmFIYTI5VlFqa2lIaUtibkg2OTloQWxSNXpwVDNHOGRiY2gwRHM4TnlW?=
 =?utf-8?B?VENOS0JxM1pBb29NbFRtNEdxd1dkUExGam8rSFhMck1CaXZ2Wi9LVU1NRC9W?=
 =?utf-8?B?T1c0UkNGc0ZsTGRuajBrM255UFM5ZHBzQlpKam16MkQwcnllc1pUcGI3YjZS?=
 =?utf-8?B?WlNqeUo1bHUzM01va1l1WVA3Y2xhdjdXMnFYYit0NjkvVWJoOURRMlZyNFc4?=
 =?utf-8?B?Wk45VlFBbHd3aE92QSthOWJpT1Buc0tpeTg3VWFPOGIzZUVLMVpNU3lkaUxo?=
 =?utf-8?B?aXQxUUFRV3hkc2hmTWxtUGt3eE5RcUo0UHNVUjBGaXNRN1pEeThSUG9hSmJN?=
 =?utf-8?B?NjNmRXF2alZWaUpQbHgyOVh0V1l0aEppVllXazZXZ1JScjRxamZFZU5MYm1L?=
 =?utf-8?B?UlJ6VnpuckFjeE1iLzBsejVCMCtqbEMyMjVHTWpVcmptT3BMbktuSmRzZWtj?=
 =?utf-8?B?ME8wQms5a1IyK0I0RmtUblU5LzI1Q2lmMHVyby8rcTNuRFZITEVVZWoxMGVq?=
 =?utf-8?B?MWxzVGhFUHA2SWk5aDlRdUtPazdFcS8yWEtmKzN1NDVQRDYxMFhMT3F4M0xm?=
 =?utf-8?B?aEZ5cTh2akUyMExMa040VDR3SFRleXYvK0NKdW5ZVFRjeS94SXNZUnNxTjBz?=
 =?utf-8?B?M3BUbTBjTEFwUndMV013RXp5blpCaXdaOE8xdmdXMVNNNWZENFprSDlpYmsv?=
 =?utf-8?B?QnJIYnhqUTI1elBPcDlJd1dQOUhJcmJvbk9uaFErRy9FUEYvOTZIS2cxdU4x?=
 =?utf-8?B?ODE1YTI0NFhGd1VrbThKVzdQTXFFVVlKQ25DYnpMakQ0RjFtT1B4K2gzZ0hw?=
 =?utf-8?B?Y25USEZhUjNGOW5VSVdFRzBuVFFXVmRxZnRTWW1QcXBNV284L2gxM2FjUVVy?=
 =?utf-8?B?S0Z2a0NNdDN6NzFDMFlrNXh0T2dzeU9TTzBQa1pBSENSc09ScWN3bmNrdkJQ?=
 =?utf-8?B?QmdlVUkwdktvMk1xY2hDamUxNHNCWVRGanNyVm1rTUJqN01IN1hDQlBZVTBj?=
 =?utf-8?Q?ZTzipk2PjUn09+SFyI+e1CtKXq7Wqze4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWw3cFVxQ1BkRDRuTFFJdkNuM0R5Vk1mZmhMSktpZ0RiWG1tODV1d0FMVlNX?=
 =?utf-8?B?WWlab1RTUVJwdXRiS2JBOTlWVmRGWVNOejFXaWhDYnVjRHZsWnlBc0FIVEEy?=
 =?utf-8?B?endUS0xleUgwOW1seml6MzlpOWQ2TFM0TlNwaGZnK0Z1ZmIxeUNSOEdpancx?=
 =?utf-8?B?eVdIZ1Q3NXNCMGI0bTlNMFhTSjNKZWd4NURFN2NnWncrdlZFYVkveGZ5NGY2?=
 =?utf-8?B?eXAyc1pyWUJHMXpjOUR4YjZnUWFLZHRYUDBpaFBmN3FBTXlIM2QzTXkvdGtG?=
 =?utf-8?B?WWRQR0F6M0NFWUtuaC9Cbk40Mmk2MHhWK2NqSnJiOE5kY2ZvRU9ueWxEcGpu?=
 =?utf-8?B?NGdVQ2Q5VThSRmNHS3Q0V0Z6U1JCK2tJSC9yZ0R2Q293ZFphaXRmM0EvbjBJ?=
 =?utf-8?B?dDZDR0p2ODJUcjU3b21NdFNKd2p0MENGczQ2OERFMkN5bU9wOWowWGlvaytB?=
 =?utf-8?B?aTJRK0JzMzl2MnErbnBocSsxU1ZSMzdMU2IwWVJQNnBKQ0NuVGxaVzU3QWYy?=
 =?utf-8?B?QWpzajFIVkNzU1BKRktZU1NXcjFMTmJkRDZUUi9uTG10VkdFbWRWaFZZSkVm?=
 =?utf-8?B?Y01KUzFSZkc3LzA0ZGRMSDlxRHRnMlBaZlRYRFVjNnVBSTErMUUwNmUyc1Y0?=
 =?utf-8?B?RUxpNDZJOGxmZnEwbEhNMzJ4TmpzM2MxSkR1M1hPU3N5VnlDdUl0Y3lvbzdT?=
 =?utf-8?B?N2NtdHJmS0VUUmVyeTl6SjNMYXB0MC91Zzh5SFNtczFUQjJYS0lTZUZ3Zisv?=
 =?utf-8?B?M3hiZ294SUt2T0NXcHQrOUI4NEZyaGhld2hDeldGT1hGbEdTdUl0Ri9Ydkxt?=
 =?utf-8?B?TTlmMHhTR2t5QUkvMk9TNFFVZkZsdVlnT0UveFdTck5MZ2JZMGJhd2JnM2pB?=
 =?utf-8?B?SkRzODZ2MWFWczc2OWZyUEh0d0pERnlNZmlYSDJ5QXI2YTllSk55alhLWlhM?=
 =?utf-8?B?REp6NU1TeFhLYWpzV0NncndGby9IM2VjWWkwRjBPWGcvVmxPRkl0VUF1cjBN?=
 =?utf-8?B?UlJDRHVaYWtBekVRSnZRb0xMZDRDTTNNelYwdEVXK20wOHZYVVN0WVA4dUNz?=
 =?utf-8?B?a0FTcEt6bmhDanVUd3ZhcG5TcnNFeXExUmFLT1cyMG5ETy90VmJFNUtidmRP?=
 =?utf-8?B?NWN4bW41V3pFMHdRd2ZVUHphb0dzZDNkVzVEanZXUDJxb1p4dGxyMmYwN3pF?=
 =?utf-8?B?am1LWGZHb1BBcFlGRldvR2gxSUhUQ1FVZmcrR1RLZjl3dzRpeEVvcVBKTEFT?=
 =?utf-8?B?d2VWZFpiUmRIOEhyaldsZDRMSzdFNGJUblQ4c3hDSXJadWJqb3dkdDRIcW9N?=
 =?utf-8?B?YzkrcklLY05pTW9NNVlibi9ISEgvVlZ3blg5d2U1N2RRa0ljTFJ6SUlhU01o?=
 =?utf-8?B?TmRqMDh5Tzcwc3pUNUZIZUdXNWtkcUVBQmp5NEZoQkZXSC9XVkJaS0hweXJj?=
 =?utf-8?B?L0FjUVhueDdVbnNRVm1YTDBsTk5PTUlITklTeFA5NDVFbi9TVURsbUtRdFFV?=
 =?utf-8?B?cDJmTGxYSlRvKzhiVFRvNGw1bFBNam81bTNjRjZLUmsvQnphREVVQTZTSUFK?=
 =?utf-8?B?aURhU0g1dU80S0NVN2UxM3dmcURxQkRacUo3OGdTYVJRY3J6VTE4dTFVZVlV?=
 =?utf-8?B?cmgvQ3VJZE5MZVVyV0pMUGlrU1dha3o0V0tJWG04RklMMFVCU3paYURHVW45?=
 =?utf-8?B?R1lKbmMybDBzcmdiN21XVzZPcmVhb0lDdE9pZjgvdDlUZkZia1RmYU9rUGt5?=
 =?utf-8?B?b3RGaXdEUFpLU2dqUzZ5SWFRZmNsQUQ1cnllclVFVFVEaGl3SzhPN3lNUDJa?=
 =?utf-8?B?WkRDRGMzSEZyWFR3cjF3aU1HS0RsRk8vUDYvTS9VK092R0dCcGRmYU8zdTJR?=
 =?utf-8?B?QWxjdFUxenVzQlJxOU92R0svLzhvbEkrZHFhZE5vZDhWMFNUSzJMd2luYjAw?=
 =?utf-8?B?eDNrNE1EVk5hYTc3emg4Uk5tSStzRUhzaFlWTWtoeHpyWjR3U0U0Zzl3NTRB?=
 =?utf-8?B?NmtJb3Z5MFBRZDVtTVlkYWRHQzVhSnJOTEpka0V4UnBGRUVJV1NlcUM3NWZy?=
 =?utf-8?B?R0VWQU04RER6eVZuVDAzR1R6TERqdjhqSDlUNWpSeUkvbFdmMGJNM2VqMkR2?=
 =?utf-8?Q?BqqqVoVJq7U2dScSvlL3ihCPT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66922202-416d-4779-6315-08de21aa9039
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:15:58.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY8Tf6LIMTlWju6boG5SpWMmqCFbPvl4ezTBY/Cepxn6c3uVdUBkTFHnJw607CwYJlf9GJ/Qs66kGGvwYMCkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

On 11/11/25 10:18 PM, Jason Wang wrote:
> On Wed, Nov 12, 2025 at 11:02 AM Dan Jurgens <danielj@nvidia.com> wrote:
>>
>> On 11/11/25 7:00 PM, Jason Wang wrote:
>>> On Tue, Nov 11, 2025 at 6:42 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
>>>>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>>       }
>>>>>       vi->guest_offloads_capable = vi->guest_offloads;
>>>>>
>>>>> +     /* Initialize flow filters. Not supported is an acceptable and common
>>>>> +      * return code
>>>>> +      */
>>>>> +     err = virtnet_ff_init(&vi->ff, vi->vdev);
>>>>> +     if (err && err != -EOPNOTSUPP) {
>>>>> +             rtnl_unlock();
>>>>> +             goto free_unregister_netdev;
>>>>
>>>> I'm sorry for not noticing the following earlier, but it looks like that
>>>> the code could error out on ENOMEM even if the feature is not really
>>>> supported,  when `cap_id_list` allocation fails, which in turn looks a
>>>> bit bad, as the allocated chunk is not that small (32K if I read
>>>> correctly).
>>>>
>>>> @Jason, @Micheal: WDYT?
>>>
>>> I agree. I think virtnet_ff_init() should be only called when the
>>> feature is negotiated.
>>>
>>> Thanks
>>>
>>
>> Are you suggesting we wait to call init until get/set_rxnfc is called? I
>> don't like that idea. Probe is the right time to do feature discovery.
> 
> Nope I meant it might be better:
> 
> 1) embed virtio_admin_cmd_query_cap_id_result in virtnet_info to avoid
> dynamic allocation
> 
> Or
> 
> 2) at least check if there's an adminq before trying to call virtnet_ff_init()?

I could do a check like this:

        if (!vdev->config->admin_cmd_exec)
                return -EOPNOTSUPP;

Or would you prefer it added to the virtio_admin_command api?

bool virtio_admin_supported(struct virtio_device *vdev);

> 
> Thanks
> 
>>
>>
>>>>
>>>> /P
>>>>
>>>
>>
> 


