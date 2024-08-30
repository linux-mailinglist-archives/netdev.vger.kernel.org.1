Return-Path: <netdev+bounces-123706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7F9663BA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0817F1F239F3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D171B1D5E;
	Fri, 30 Aug 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDG5lHwe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FEB17BB1E;
	Fri, 30 Aug 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026880; cv=fail; b=alUdDjbjt8EFAAKXDZydh5QmblJSw/nOi6+AvqZUOlXaSlt+JCDyyYsUrLstoOZU1qwagWUtzxMZqX8ionGIIleSl5DFiB2aIQ7U/ykLEISxSQ1vowlxU373VJWl/7CosrYRUfwp25ZlqBJOMgtzteknjuUnrhfhPbr+Uwfis0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026880; c=relaxed/simple;
	bh=spGXc46EntNutza4nWJuTQmTWYyiQfgS2EVZC3zSmG8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QRqWf6FqeRxbQBpL9xonOxmWaiQ77g4e/iYNh68MjZln8hubKz1dl+qo6uXGZnzrJ7gU/5eVL64UVHjVAVyFgDSAehJ3/NwcJl3KyqKRQRkk/PNrx6A2OPKDbO8zVvIUhVVXs4/Ph7tz+NKqEuFBrKg5cXG5VESJS5Id9jJJwJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDG5lHwe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725026879; x=1756562879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=spGXc46EntNutza4nWJuTQmTWYyiQfgS2EVZC3zSmG8=;
  b=ZDG5lHwewSswoZ+iuXNhiVRbCd8BsULBC8t/wvlbHZIV9IYX6YuAyl4W
   xLjRluOgR3in9C88iNXDSzmQRQCNHF33iEiqHMAe1QrBRfYISzqGU4eT7
   jwySpEbMieXxwPvHjV3Cq6U2hmv5Y4hyBo6hsd/qCELiRqF36A8+lt19s
   AweX0jbWoy6R4DZ7UJ0hJwTv5ISeiBAuK4cUemUGy4i+avW4q9ZhU/CWB
   az69XHWiq9VgDYbvsTY72AI2cOc5QzRxcninHJrDVrbabbMaA5YErYYOI
   zg9Q+p5Kq4MogruZ6GFef/TqTkfTEM77mz6dCNwsAYBNghppUfmO/y/tO
   A==;
X-CSE-ConnectionGUID: jdBn9WcNTWSZ+HtJeSeE4Q==
X-CSE-MsgGUID: sntPFV9MTPu46RnuXrH0AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13298366"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13298366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:07:58 -0700
X-CSE-ConnectionGUID: N20bNCLgTw2ZCCHOn188qw==
X-CSE-MsgGUID: 5F3HmzoiT0WCaaLpfB39yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63734176"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:07:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:07:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:07:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksnIGYZjJQaNF5p7kOxCUiRe4Esz//x6hd55TMTcGsv/QL/dd2cLH+0EviTBG1wTxveNz8w3cH0IK8oTITtk7lVCIKKwSuB0CJwPqBK1R9WkuvSByPPsFqbI9cD/V1C7xzbzQtfxygvSlH2+WS/Sucbi6OPTbg4y7cWVNswbj05TFs+VYs7JlSJdilS7VlzF3RMIpizhtyrEh9Qojlvk7F25rIFmoTyjY8oHvr4nlpDZ5iOUG6SvdEAMTht5TkM1ZEreTk054ugwSz5g4DnrVrsdz9s98vOPCgrgvx227h9arAIZgmSg5fVqx3GdJIv971EsQjwvl+Chx6ghKi5e5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3s9QNZnAYBmNpTHxt/jYVFxHVmu7LPdzX7VogaKV7Y=;
 b=oDV9pB4TukcZswDAUlD/PWPMMBI0rZgmgUwv2KpP59i3gyHhDM3xuKSi5YWB3qcW4Uf7lugLOnu4BGryENv971a+mUd/pKW/vmAsoOk4VM5DvJYFp/E0B914qdXYmFCLJ+jR44dvQOnQYAIwDRK6u42OZ3YeRGvrLzwg3LpTz21PkEJDSnLjwSG2aQLn9cuuocSpo9jrHD7Xv/+sbfKgvtko5Tk9UOvhI3xSWdQ32tYBipjzpoku2suXBTFsddJKoatEttuwQvmeXeuIwgAsGLF4IYHG15Evr6jR98jiXQBA3BcIWOdKvD1+SlekxTU+FFb4QJ99ftyf5Ry57lU8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.30; Fri, 30 Aug
 2024 14:07:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:07:52 +0000
Message-ID: <728d4ad3-bd32-4bbe-bbd1-cd2c62df1fad@intel.com>
Date: Fri, 30 Aug 2024 16:07:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: MD Danish Anwar <danishanwar@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240828091901.3120935-4-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a2c75-63d6-4f4e-daf5-08dcc8fd2315
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVHcERhUThtc3BidEpQM2lsRFljb1FON0J2K2RHTFR4Y2M0R3hCOEJ1Wkkx?=
 =?utf-8?B?K2dhRnRCNC82NjVhTVYySG9VY01YeG1meHhCZXVXLyt2ZC80MU9LU0tsa2ZQ?=
 =?utf-8?B?UXFCNjNVdDVvZ1gwaGFuaEgxbnh0dXRQcWRUQVRKYVNTazZWWDRVaGE3a2VW?=
 =?utf-8?B?SGpNMjlWTHJlclRWYjBMT200NnVVVEFLTU9NSjNCdVBqeXBvZzR0ZVdNNi85?=
 =?utf-8?B?cmpLRFhMUkduVi9wUkxLSFlBVytmUkdNTy9Gd0xtQldzeUNZS1kvSU1qQWM2?=
 =?utf-8?B?LzZCMUhwZWdQLzNaL1JTUWFaN1k1aW1wU05ISjlTMG5McmVVUmtrcm1Uc0Ro?=
 =?utf-8?B?Sy9RbDdRQ1hVYzFYQjY0NUdmcUsvSU9PQ2NtL1dLT1QydmUvaEV2K083ZzNF?=
 =?utf-8?B?N0twaWR4VUZxMEZmMzkrWFkxRm0xbkV4MzBhVjVWOGQzTEI2Ry9BQ29vQVhU?=
 =?utf-8?B?ZU54bGZQY21yTFBLTlJsdVdVN010SW9mK3R1MXJJRnZub3JhNnNDZVZ0OVRm?=
 =?utf-8?B?ZkxDTlNwUUs5UkN0THlDL1owSE54VWx5WDZRRlZ0OGp1bVdZMnhiRE9CTGhV?=
 =?utf-8?B?NHQySzZnRUgwOW8zbDAydWVlZmVXSWoyd3lLNlNaZjE3S21kbExYU2o5eEw3?=
 =?utf-8?B?SGNxdUFydkJxQjg2Zm9JNGtQWEFKV0M3Q09GM2pyNWcya25FQXZXMFlBZHJl?=
 =?utf-8?B?VW9tN2IxUWlBL1RYNTY2SHNTYnFxanY2RXl4V1BmK0VjRTByNU1GZEprTUlE?=
 =?utf-8?B?R3NvWFp4REh5WWZlVE5UZEM3OTBVYkxybW85anVZQ2dtcWs1Z3c5c0g2MzZt?=
 =?utf-8?B?NjhGYmFoU3ZFL2orbVJydGZiZWRBdmdIYXRXMEkzVThzSmRna1RubDBOalpi?=
 =?utf-8?B?TllWZnFGbDVZRkErKy83NEF4VytMenJ0VnN0T2VqUmtBamQ4cmRIN3JiZXNB?=
 =?utf-8?B?eUh1R09lTHgyMXJGNURiMTk1a0d5K0dhUUZtVmRFME5jMnh3OThlNnZJaUJG?=
 =?utf-8?B?STB4bE53RGUxcXZLdnprWThJbEZtdEJxYjBJZjVlNS9WRldDUi81TDU0MDBm?=
 =?utf-8?B?ZlE1WCtrOFdyWFU4V2lpWXNuUlRQQjMvMkx5T3Zndlp0L1BrYXpiZGFyOEgx?=
 =?utf-8?B?KzRlMVVGREhiZlh1QmRLN2w5QUJ6N2FBRXVtdC9jRUwrcE9tcElWc0dDa0tu?=
 =?utf-8?B?cXFSK1I5U2NCK2hWdDMrWDFRRXdKUTYxWDJMNk8vUjVJZ1BKV2QrK3ZtYk1G?=
 =?utf-8?B?SkxYc3hZMU9sTE9HUVljZUdHSHl4dks2NkpSN01RbjZ4ZGZMQ0tjaUpBRVFN?=
 =?utf-8?B?blBubHdNQjZMQVVhNklYcmQ4UjdFNXREazBZRk8yeDNqc3NPc1RBQ3VvRmpV?=
 =?utf-8?B?eTIzWFFaa0dNdkYzMlhIYlZ5Q2FUcmdYcGNUZEJqWWpOZEwvM3VMVUgwVk5E?=
 =?utf-8?B?WTFFVFBjNjFvUXRBRHNvWTAydnByMDR5VW1PY3BvTGUvUGtaR2krV1pPUUYw?=
 =?utf-8?B?K0gvczExcytqakZ2MjhtYVM1dWVQL2VtS0lMWkV4TVJOVlp0UlhUckRocURj?=
 =?utf-8?B?eVN0SmZpbHFybWsvQlV0YXc2RWlBMG92TmxJaDlmbTEyUkw5SS9GdFlnc1Fq?=
 =?utf-8?B?dThJdmJ6WGdSZjlTSjRUbUJoazBvbCt3eUMzR3RaNHZCWkt4WThUVDB0T2lV?=
 =?utf-8?B?eTdpQ01ZUnY1VWc2TXpDZUVlaUJYVlpETm0yMDlKckxZNzdlaE9NVG9hTWNk?=
 =?utf-8?B?RFZiTDVBMHFUb2trd2N2WWJlT0dONDB5a1ZaRkswbVJVZExMWnhUZGFQdFBV?=
 =?utf-8?B?aHJPY2U3ck9mQkxlWXgwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0xURGtLNWQraU5UcFNiK2pTeksySkxGN0N1NVh3TEtvbVMvMVdZVHJGS2Q3?=
 =?utf-8?B?Y3AvU3ZRMHJzVWxURE5qNXF0eDA5WGFHUEVicnU2TjZqNzhUMjJVOGJyTVpQ?=
 =?utf-8?B?Nm9CKzFSRS9yL2srM0xoeDlPdG1BOFhPOXdGUlJVeEtLbW84ZytVamkxTUxJ?=
 =?utf-8?B?R0FiZXFRQnRCWEV5ZHRuM1lPT1FkVmZnUlJGTTg5NDFhK2s1WFpFN3NQeCsx?=
 =?utf-8?B?Z0ZXTUdVMWlrS0R5RlpDcUdaWU5idng1Mk9iaFRHaVZiYjZkbFowR0ZQaERI?=
 =?utf-8?B?MmZaaEtML1NaRktMbi9sLy9MZEF1a1p1K3QyMjUwRS9GMEVOQXVUcXg5YzVO?=
 =?utf-8?B?L2VRemNMOEsvVWFJT0Y0Y1pkQzVEckFKZVRkbDJSZUJvczlNdjFWQ2pTN1RC?=
 =?utf-8?B?WFpWN3BNSExZNGVoM2VqamlSUXFpcDBWTmtyZmFNOEw4MUszclo4N3ZmcHNq?=
 =?utf-8?B?aGdGL0lVWjI3NXc1RlBrOWlCN1FWZGJwR1hWSWRyYW9mV0JSL0YrQ1o4VHVk?=
 =?utf-8?B?dzB3bWdOaThybmtLQjAxRkVjRzFPSm85NTMxWXNPNW9lK2srWit1aitHa3NR?=
 =?utf-8?B?bUpmQXJXLzl4UStsM0ZYdlNqTnVpbnp6ejd5c085eEhGdTFTYTJqa1I1THdJ?=
 =?utf-8?B?YzFkWVkrM1NtUkZCbzFWRjlQVWd6NE94bGdNckRXcjNGcXpwdDB4MzNIUXRk?=
 =?utf-8?B?WkVsTUpXTmMwZE9ja1pBUHJocGJrWFVxSzFJZ09YcFdveUwvdnl0MWxDR1RH?=
 =?utf-8?B?RzBYMTFmQnh3QnVZSUQvZUk4c29hcFQ2dHNPbm1FQ0djL01yVVhpTjIrbmJx?=
 =?utf-8?B?N3RQL28wbFhUSURpc3pLQWt0N0I0WEV1UzV4M092QU1IY3NLdnVJb25nVWV3?=
 =?utf-8?B?MFNFejBxQUkreit3MWRNQVVwdG04T1EzOEpYT1BjWittL2FWTEJ2WDc0Ulkx?=
 =?utf-8?B?c0k3NTZmZzVEUTlQZ05DTUNkM3pYVnc4Q2Juc043RFhCa2p5VlA3MTVHRWlM?=
 =?utf-8?B?MW1XbWEzNmFQK1NTbk9TUGE2VWlFcXg1Wmp1NlFmVlNHbE9MTXBaQmdXaFN0?=
 =?utf-8?B?SEJFRDJvK25ZbFp0NksvbWhGWmlXbThSdWNGNnVXZHEwUHJjMklZNjBhK1ZR?=
 =?utf-8?B?QjVzMVRkMjd1RC9MbnVFNWF6TmtPSzFYeGw2T3dOV21ZSitZM0MzTWl5TktL?=
 =?utf-8?B?QzFPK2xpT3RGM2Erak8ybi9ieW9keE9uNm1Nc2pVM2J4UEFXUy9DOXczSlpa?=
 =?utf-8?B?eGp1V2JpWlQ2MTZkY0ZhdndqQU4vN3F5N3dNTUpRSHV0UjZOQXJocmdUTkVS?=
 =?utf-8?B?TnlsY0JqaERmdVovZ0Y2VHlaRDl0MWFzN1R2dW5UbkllYnovRU9NSzJNYWNQ?=
 =?utf-8?B?TCtXczQ3a0FVMVBlQXc5YmlWSUVyWWNKV01iaGF2Z0dmTVdhZmVGU3dEUXBR?=
 =?utf-8?B?WkRaYXZVQUVNNDRINkdMZkxLYmVCdFZvN1lLdXFjaFZ2aGtwQWFrUEowbEZt?=
 =?utf-8?B?bUhuWFpMQlQ3U3dqTGp1THdSbEV3dHhwUDVwZXV5NEgzWTU0cFgzY2pORFpW?=
 =?utf-8?B?U1NBbVNpUkJOYXdDSnR1KzQ4S2M5aGR5WXdmSHAwUVZ4WXNVaU1xNEdLVnNa?=
 =?utf-8?B?WDZpUTBCaWpKZ0hBSTRTM0tYQnBTbzB1T0hTaHZyb0h1bjZGT29YbDhoTTR4?=
 =?utf-8?B?K0M5ZFZnQTY4WEluekZNcTNLR1BGektnd3BFOGo4MVVTUzVIbjFJUmh5MnVP?=
 =?utf-8?B?Vm90U1haekNLNC84TVpLdkVaUThIQzl3emw2L0ZJcE1Majg2aExqUTc2QWRF?=
 =?utf-8?B?aFNGQllXam1PRERZbEkrTkl3VXpxQkg4WjJ6YXdGZHVWb095bkVaUWdwWG9Y?=
 =?utf-8?B?UDNqVjRmOXlFWEREZTFNakhDWnRkVURCbkdnUlJsRGFXdXoyYm1MTzk1UVVW?=
 =?utf-8?B?MEJUMVphSmNQVHdOTEtlM1FYRzhlQ2FmaWNyaERadEhMNTVrUmtUQ3NBV1Iz?=
 =?utf-8?B?RnhST2xLS2VuSDJwNisvZURUMGpZbmNiRFplOVB2dDJFQmlGUGJWNCtnMHU3?=
 =?utf-8?B?Zitsb25ybFNEL25SM2lSTzg5QTFqM2F2b2VjYjl4ZmhOZk8zbXRSTlVuWEsw?=
 =?utf-8?B?L1hhdExZbGlpVU1YdUV1MnJER2FCditLM0xXMkdBbWtBcGhGVDI5RWRUOUxa?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a2c75-63d6-4f4e-daf5-08dcc8fd2315
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:07:52.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9dgtlw8UFJwKfBWc6W+sFhibPnMR3yJioeXITf0L40+xo2UC8rtURpWf7YzJ5kWFFOQ/me7GvTXYe3B2Wu5Q4zOUkjvpiITe1xHnEU+hts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com

From: Md Danish Anwar <danishanwar@ti.com>
Date: Wed, 28 Aug 2024 14:48:58 +0530

> Add support for offloading HSR port-to-port frame forward to hardware.
> When the slave interfaces are added to the HSR interface, the PRU cores
> will be stopped and ICSSG HSR firmwares will be loaded to them.
> 
> Similarly, when HSR interface is deleted, the PRU cores will be stopped
> and dual EMAC firmware will be loaded to them.
> 
> This commit also renames some APIs that are common between switch and
> hsr mode with '_fw_offload' suffix.

[...]

> @@ -726,6 +744,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
>  	queue_work(emac->cmd_wq, &emac->rx_mode_work);
>  }
>  
> +static int emac_ndo_set_features(struct net_device *ndev,
> +				 netdev_features_t features)
> +{
> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;

Maybe you could give this definition and/or this variable shorter names,
so that you won't cross 80 cols?

> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;

(same)

> +	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);

You don't need to compare with zero. Just = a ^ b. Type `bool` takes
care of this.

> +
> +	if (hsr_change_request)
> +		ndev->features = features;

Does it mean you reject any feature change except HSR?

> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_open = emac_ndo_open,
>  	.ndo_stop = emac_ndo_stop,
> @@ -737,6 +768,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
> +	.ndo_set_features = emac_ndo_set_features,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> @@ -865,6 +897,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	ndev->ethtool_ops = &icssg_ethtool_ops;
>  	ndev->hw_features = NETIF_F_SG;
>  	ndev->features = ndev->hw_features;
> +	ndev->hw_features |= NETIF_F_HW_HSR_FWD;

Why not HSR_OFFLOAD right away, so that you wouldn't need to replace
this line with the mentioned def a commit later?

>  
>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,

[...]

> +	prueth->hsr_members |= BIT(emac->port_id);
> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
> +		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
> +		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
> +			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
> +			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES))
> +				return -EOPNOTSUPP;
> +			prueth->is_hsr_offload_mode = true;
> +			prueth->default_vlan = 1;
> +			emac0->port_vlan = prueth->default_vlan;
> +			emac1->port_vlan = prueth->default_vlan;
> +			icssg_change_mode(prueth);
> +			dev_dbg(prueth->dev, "Enabling HSR offload mode\n");

netdev_dbg()?

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void prueth_hsr_port_unlink(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *emac0;
> +	struct prueth_emac *emac1;
> +
> +	emac0 = prueth->emac[PRUETH_MAC0];
> +	emac1 = prueth->emac[PRUETH_MAC1];
> +
> +	prueth->hsr_members &= ~BIT(emac->port_id);
> +	if (prueth->is_hsr_offload_mode) {
> +		prueth->is_hsr_offload_mode = false;
> +		emac0->port_vlan = 0;
> +		emac1->port_vlan = 0;
> +		prueth->hsr_dev = NULL;
> +		prueth_emac_restart(prueth);
> +		dev_dbg(prueth->dev, "Enabling Dual EMAC mode\n");

(same here and in all the places below)

> +	}
> +}

Thanks,
Olek

