Return-Path: <netdev+bounces-111663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528493204A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48D0B20B71
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CB1C286;
	Tue, 16 Jul 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnfEq32O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88522309;
	Tue, 16 Jul 2024 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721110020; cv=fail; b=bh4+5lxA8GtQySXDU8J92azLKP7cN7Aye78v97UIRgcozJQ/PLdZmBeeRrT5PAvpol6KMHf/CeklEONbfKGT3c4RAyD3DdbWp7iTiF0ksBlBQ/q2L2Y1AnAfcHSBqDiUyB+xzMvh6BDYZAPdcGjUAGbEEZIED4mDnAL0yt+Bp3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721110020; c=relaxed/simple;
	bh=Yt2ZXH3Xw8Ha2LRAzjaU8xKnurvHvbyuK7Lk/9MpwmE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meLKCqFFog8dayzFbea9SyrmzNhqxlmfgd5AfGAhCxNi5fSi2AYiyht2Kvsr1/sXIbv8rVVPBKRV9DuMdYOYjlC4VDlRVz+CJl/wQh7q/cKFVsP+RPQfwDfyIeXH3g6ev296U9YbtaCFIUoKkjBgKm4QaSrWEHL1iz2h5hJilg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnfEq32O; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721110018; x=1752646018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yt2ZXH3Xw8Ha2LRAzjaU8xKnurvHvbyuK7Lk/9MpwmE=;
  b=VnfEq32ORs8y9JHhQwIZdK2FDL3l9OUwgekaP788RVaxcCJ0TsUdin5x
   1XQtKJwmEHCcS0t26v//+UlewXI4wEpcBjGIH4/JTtjA5UoX1UL/Gv93T
   CbNdB+oKNobvdTh2qzotpx2Ty0LbJPhKG9gU9iLvYvSsNEQvonegepirH
   fqjV0tsV2cvTDf/Glc02IfQ8XLDHo+MopQGduvyl8Z7CxCErNZI0/Ulq3
   CYZJlU81tuUj1G2BkvpAhQAm0Y/g2vAyU/TtQGjwVkClJPeH7Ivqliu3J
   frulL2xd6fIruIFCQKghZ/UbicOJODajeHyjCZTRa1Qo/jvay/u6lfRZ0
   g==;
X-CSE-ConnectionGUID: G4B0MWGrSaKkmEDiyiyL1g==
X-CSE-MsgGUID: gsYBHpdITc6FIgvifodjDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35958344"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="35958344"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 23:06:55 -0700
X-CSE-ConnectionGUID: jCu0wPK1Rq6/b7hUJMqXuQ==
X-CSE-MsgGUID: 0+pzlXYGSNmNzBkiV0wlbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49725214"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 23:06:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 23:06:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 23:06:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 23:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSzUo15GmgR+SSMnz0IY6IxZ9wKyIQTc40RL2Eaml7QyPMB/OnGenWd9BjOYURqs5rXWfQ2Jb45qtyqPnafkoKcOyowR8UrZas67xZKQqY2FZG4KrFcipD6PSLLJZy+7/fzdNIsTvxjRCDTZ7jmN7ckPELb72Xs7Gzh7PLx6uKMda2c+RlPE1pjXnCOJYzMJ7wq3LCRj15NDqJ1ColUP0yRGI8VjGcysZvYmvFLXH57eReA4/bi1xyGQG/uBItMSZCb7euKNiREM39w8ob9aFsh0TldDiRt6iXVVLMCx5oNcoyeTFKBAuwmaDM/+snsgEpvM2jYmiRCPkIbTRd0oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wje6hhcaAh0xdrEHNg+42H6hmk7K/qPV3w0pe2qXkJY=;
 b=qRC5Pglrqwp+rdrSF4JoSZs4rehpG9Pj3uicZHNqJrmwycN66mcHaIPEcx5mzjipb1JS9DOwWNQjp/oHRhaIaTAFoWximXLe6+xgKaDt/C9ZCn0rVJ14UgZ1HorE8QdfeLeAfrXPLaAxrslhWYzzx0AnpVrA76ODAKjYcYvjsaC+VHFPa6pa/Emw/TsAWrgIOx0GSJobt8xx9eoy9bJH/SS2KDcxueknzbndiTgVqCWgcjlI9Plj2fb7Izyu8hbeJKe43SV2F0llwCA3WSHTM9x94l5osjeFBomskgQ9lTcGGNcQveanxk/QDawbUINTzIs41zkQRiT7sV7/Q2JjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 06:06:52 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 06:06:52 +0000
Message-ID: <73311003-6b8e-4140-935a-55bd63a723e6@intel.com>
Date: Tue, 16 Jul 2024 14:06:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 94155970-5960-4067-3522-08dca55d7cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REZISzNvZkxrRHV4TTZnWWNkUzE1WHU1eEp3SjJyM2RaRVdwdmdBeVNyZ1NB?=
 =?utf-8?B?aHZoTVVLaVV2Q1cvOEpKS0o0K0kzdlh5WGxxVEFCN3ZtRGd2OWNlbGlEU0FG?=
 =?utf-8?B?TldzK0NUR0hCcWg0SXgyZXB5b1pXRlh0eUVxdXVmZUxiNHFqZFlaNEdpdnlW?=
 =?utf-8?B?MHhySnpFY1M2QXhrbVlFVlpmaWJMN0c1djQ4YUgxc2ovc2RPV0JWYy9VcTdk?=
 =?utf-8?B?VnBtU2tjZEluL1pjQm9GemxqeFRKU05waHRiUjg1OTZaSHM1RXNoY1BNaC93?=
 =?utf-8?B?WFF4bmwweTJ4cjJ2TUtlcFhpaXRYaTBRTVQyY0NkZjlOS0ZxZW1EZjJKK3Z0?=
 =?utf-8?B?UkJpZnFpazh6MUsvYjNoTzdQcjZRQi9lMk5kM3NCSS9iQkd3K2VZZ1pqcm5K?=
 =?utf-8?B?M2NIdFhYdGwvUFJ1S2tyOHUySkZoUjZBN0o3alp2ZkdodmFZQ3ZmUUNjMlF5?=
 =?utf-8?B?a2JWOWJPVTQvZHVKM09tK2hFbHB5R29RUHFGL3V0bDlncXFyczI4K1lBcE16?=
 =?utf-8?B?dnd1aVNuak5jejRCcGVUblZIcW96ektGMzBLVW5WenhLWFB5QUYrYU1WcHRk?=
 =?utf-8?B?aDhFMk1xbnduS20yRnJGdk1WVXZheHVrSW01MDVYKzFFNmd2TmlWOTQ5NzVh?=
 =?utf-8?B?Yzl1RFJaUkM1T3d3RDI0YnhDN1hKMVlwMTJlVndCUXhtR3BLcDJsWDhUek94?=
 =?utf-8?B?b2h2R1lwckp5V09RcG5aYnI1eW5QSW9JMjMwYXAzdGNIOFdFVU1DQjdqcUQ3?=
 =?utf-8?B?eHBLbEM1TmNYS1BmRXRuczJTKzJpQjYyYm1vWnNsK2ErMitPaVFvTUdKRWdv?=
 =?utf-8?B?UHV6UklqMi9tVWZpeFhUVVkxTE9IS3A5eStpeFY5V25PUTRmdGFaYzlMNkxG?=
 =?utf-8?B?SnpRMS9KT2poNWJseWtJdEJ0cW5GMjR6Y0cxNGhpeDRUWFZXT0lObHdkTXNm?=
 =?utf-8?B?bHpPeDJjd2dZMkJMY1pVdEFML1ZkY1VVTlAvR2hoWU12amlCMXFZaU5uRHIy?=
 =?utf-8?B?V1Z1MS9PY05HYzRFZ2dyVklhOE9CbXBMUlFQRjl4NlZENGlnalJ1YTAzUTMx?=
 =?utf-8?B?N1NIdkZyNnZUQm9ObWZXNW4yVHVRUlQwK3BLNnFzK1J0QU4xdWpqK3NPREFr?=
 =?utf-8?B?cEFVU1BaNDNHejAreksrZExYRG83RDFZb283LzQwSFBTZUxuNnJieDFDOTRF?=
 =?utf-8?B?VTk2WlBzMGFkbTZhTkpzYUdhaCtUeU9Pb2o3OUFaK2lydy84Q0F2bWtBdkw2?=
 =?utf-8?B?dmk2bVcrZ2QrbnZzQ0ZqNHVRbENQbE9SdDA0c0dVYWpkeVU0QS9UZmZYVklB?=
 =?utf-8?B?QjJ3aXVPSlJCbUJDWUE4QVNGRHd3d2FtMUdJRmhLR3BVWEtwaXFCUkl3L1BO?=
 =?utf-8?B?VWVzK2ZrdlhQQjN3RGM0VW5RT2diNFkvS2JEcVIzT3dPcG0vaGFjZk1ZUzdN?=
 =?utf-8?B?QS9JWHpQMEFGdHhWTmo4SE1NYVRQTGdyR0w2RUdTempBZS9QNFZMMjhjdXl4?=
 =?utf-8?B?SERrTHZlUVMva3l2OS9ZWUl2bG9nckphdlRZaDZlN0FxNkhUTExCT1RTTnJL?=
 =?utf-8?B?Y3NSYnBsWWQxYlkrQkNoOE5LeXd6M0R1VmMrMlZ4SUpwODZsdSsyVXdtVnYw?=
 =?utf-8?B?b0lCcmQ5YU5WOWgwTlNpN0E2WFROUHkzbG9uN3VxVWlDdTlKNXRpb0kyWGI0?=
 =?utf-8?B?TnZWNlBkQW5FRktMaFNZTC9RT0tIRUFvTmM4aVU2blZtbC9iZGhFU2NNUnAx?=
 =?utf-8?B?ZzVvVnVjdEpnRDFnSWJuK0l6ajcvdDExZUdmVkRrODA4MnVsUWFQN3ovY3JH?=
 =?utf-8?B?Sis2VHBXRFZIUkdrUitkZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnlsVXRQSGtaMUFnVTlDdFZZUlNRZHpHVFZFNXcwODdtTFkvVG13SXVzbzNK?=
 =?utf-8?B?aW1tM2F3QWdLWnVPcnA0VEJzOVZrRktxM3FlelpWKzJZWVkzaDBELys2VEkr?=
 =?utf-8?B?VlVkd3ZuTEJ5WmdJK3ArdTlNcXFid3JDMmlpajVvQU1yU21PR0I1OXJKQWVV?=
 =?utf-8?B?UEVzWG9VcG5DRWI3VGlVNUVQdm1IL1BvY21tcXZLQURTS3c2cWtmYUg1dzBk?=
 =?utf-8?B?NTExaFljaW0weVI4NEcrdUFPWUM3MUxJT0RsRHpXanRYSUM5QXJ3SjZzdG5t?=
 =?utf-8?B?TDJiUmY5bnlYelYrT1h5RmFKdUJjdVA3ZVY2U3NvbmsvREk5bUZVVG0wNU1v?=
 =?utf-8?B?MVFIR0FVK0NSYldIRjlGdUdMY0Y1L2VKY0RNaHlrT1p6dnRRRXhGUjl2UjVK?=
 =?utf-8?B?MC9JY05BVFRpOGxwRDBrUVNET1NyN0s3SFVTS2NGdDYrT2g1TWtBOGFYeUxr?=
 =?utf-8?B?RzVxS1hoS1lqT3JkQ2EvN3dacmVVeGJyK1YzK2NvbmVPYnEzQTFMOTljUEM2?=
 =?utf-8?B?Z29zWWdhcm9VcWkxdUhjRWxxSWg1MC94SGdIODhZdDlPYXY0SEIwc2ZLQlo4?=
 =?utf-8?B?VFc1eG12bzc5b1ZNbkFjbmFFOW1KMEJEQmpSM2kyVmdnWk1DY0VycUxVcWNm?=
 =?utf-8?B?bG9FcHdsRUU2c2w3VldsL3pSZ0dLQStiUzNabWFkOXJRaTB5QjhNUkpBZkNB?=
 =?utf-8?B?S3h3ZEtzdjFtSzBhOUVtSTF4MFJxTDBJa3RmaW1QY1FUeHVOLzNzeGRHWUMx?=
 =?utf-8?B?UjdqdTlHK1dINHFJV1E3WktFUU9JN3orWXViU1JsdEdtNmRvR3hDUllLNWxt?=
 =?utf-8?B?bk5jTkZNR1pZRzlUbGMxdCtHdVBWMkJSUnVCc3JlUnF3Y3ZQdG9HVjBKb0Fv?=
 =?utf-8?B?MjNYM1B4WnFXZU1CYVBBbVpLZmZOUlNweWxYR1BGVUt4dHI2TWpUN0R4S25k?=
 =?utf-8?B?Mkszd2NvMytBTGxJdnA1ZlNOcVNTOUxrVnVQN0d3QmJQRzlCQlJ1NjhpNGor?=
 =?utf-8?B?dm9Ka3VJZ0dRdWhFTnRHTmJLUGw1bUd2MGFyZW94QkhKS0tGbmxxc3EvQ25p?=
 =?utf-8?B?bmwyT2R6VGdYZHphM2MzUFVUK0h4QlpaYWVFRkpPdUY1KzVQZjY4Sk50OHNL?=
 =?utf-8?B?dVFhWE44eGMwYUJ5Y2pyakVsdVBSVnBQZDd6TGs4RDlXbmZhSTBzb25wQUx3?=
 =?utf-8?B?V05QR0sraU51UVhqYXpYeDFxRE43enlEbzJidm12MG81TVhVc0FFdEw4RVpO?=
 =?utf-8?B?VjV0RG9aalBTcWdaNDE0QnIrcHYzbXdaTmFFeWM2UDB2QmppR3JLUTg3Y0lr?=
 =?utf-8?B?YXdYbzVVblU2amtOVDIxZlYvVzh6SkZVUXBiODU4dkp4N1NLdU1KUkI3WmlG?=
 =?utf-8?B?UFNWdHFNU0wyMDdrNkNZa1hSM0xOZjF1dVZkT3ZrMWIvN0F0QWdMamVGSG1m?=
 =?utf-8?B?d1luSGcxSmVySW9ZV2lndFB6anNPUVREaC9OaGhiK3ZrYTExdjNxMWdreHR3?=
 =?utf-8?B?czhpRXU0ZGZqdnB5VFNnVmFxV3Yxdm8rTS9mL3BQWjNqY2MvbmpVNW1SK1J0?=
 =?utf-8?B?Z1RZckFxclkwbW4rNzd1REp1NlRid1g4Q0JHdTJCSW1wc0dNSURIUjY5Zitj?=
 =?utf-8?B?cUxpQ01FemhFTnpYa0N1dkJjV1cvbUZpeFAwaWltenJicVFMNHVQMHNNYlRN?=
 =?utf-8?B?aThlK3QrUVg0RnVCVXp5eXA3Qmh6R0ZuSmRQY0VKMERZM3FSekUyTmpCckFD?=
 =?utf-8?B?VC9LZlZGOTVEcDNLSnRaV0FiOFNEd0l1dktnN01DWVJmdnMycGlJZXdVb2xR?=
 =?utf-8?B?Z01ObEFVbkphQ1BDMmZwaVdoTmo0MDl1a093REVHZndyNUUyOFVDLzloSTJM?=
 =?utf-8?B?WGI3bDF5M1FPQUlsQzJHc0dsQnNpR0NBcXBGUGN5S0RvOVdSZGdyYzUzNXJk?=
 =?utf-8?B?VjZKaEI3RVpJbzF3djg2LzlLTnRRelliNm5sM1ZXZGZkWk03cXRMV2c5eTUy?=
 =?utf-8?B?ZXV5OHhaYUZXZ1BwRVk3WnByUnBnUDNDL0JEMGtmR1pldVhWTVEwckFRK293?=
 =?utf-8?B?S05POENONmwvVzczNG41SUxJak9RR1MyVHpQNDR6R1VuRzlTczczaE5sLzRv?=
 =?utf-8?Q?GMViENVCXbrPolh0nJRkHEh+O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94155970-5960-4067-3522-08dca55d7cbc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 06:06:52.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGvJq4JWcJiedmp7sI7S7tV+PTzFJbFlK7A6a/1j0iMvCdBKnAG2WlyhBeCnARcAWPRdOOSft/AWpITj8/G7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-OriginatorOrg: intel.com

On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is create equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
>
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
>
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h                  |   3 +
>  drivers/cxl/cxlmem.h               |   5 +
>  drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>  include/linux/cxl_accel_mem.h      |   9 ++
>  5 files changed, 192 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 538ebd5a64fd..ca464bfef77b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxld = &cxlrd->cxlsd.cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
> +			      cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/* A Host bridge could have more interleave ways than an
> +	 * endpoint, couldn´t it?
> +	 *
> +	 * What does interleave ways mean here in terms of the requestor?
> +	 * Why the FFMWS has 0 interleave ways but root port has 1?
> +	 */
> +	if (cxld->interleave_ways != ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
> +		return 0;
> +	}
> +
> +	cxlsd = &cxlrd->cxlsd;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	found = 0;
> +	for (int i = 0; i < ctx->interleave_ways; i++)
> +		for (int j = 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] ==
> +					cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max: output parameter of bytes available in the returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
> + * is a point in time snapshot. If by the time the caller goes to use this root
> + * decoder's capacity the capacity is reduced then caller needs to loop and
> + * retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max)
> +{
> +
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.interleave_ways = interleave_ways,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root;
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	root = find_cxl_root(endpoint);

Could use scope-based resource management  __free() here to drop below put_device(&root_port->dev);

e.g. struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(endpoint);


> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +	put_device(&root_port->dev);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
> +
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9973430d975f..d3fdd2c1e066 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -770,6 +770,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
> +
>  bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8f2a820bd92d..a0e0795ec064 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -877,4 +877,9 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 2cf4837ddfc1..6d49571ccff7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -22,6 +22,7 @@ void efx_cxl_init(struct efx_nic *efx)
>  {
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl = efx->cxl;
> +	resource_size_t max = 0;
>  	struct resource res;
>  	u16 dvsec;
>  
> @@ -74,6 +75,19 @@ void efx_cxl_init(struct efx_nic *efx)
>  	if (IS_ERR(cxl->endpoint))
>  		pci_info(pci_dev, "CXL accel acquire endpoint failed");
>  
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint, 1,
> +					    CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					    &max);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_info(pci_dev, "CXL accel get HPA failed");
> +		goto out;
> +	}
> +
> +	if (max < EFX_CTPIO_BUFFER_SIZE)
> +		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
> +				  max, EFX_CTPIO_BUFFER_SIZE);
> +out:
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  }
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index 701910021df8..f3e77688ffe0 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -6,6 +6,10 @@
>  #ifndef __CXL_ACCEL_MEM_H
>  #define __CXL_ACCEL_MEM_H
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +
>  enum accel_resource{
>  	CXL_ACCEL_RES_DPA,
>  	CXL_ACCEL_RES_RAM,
> @@ -32,4 +36,9 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  
>  struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>  void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> +
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
>  #endif



