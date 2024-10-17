Return-Path: <netdev+bounces-136713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D459A2BB4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568AC284920
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE21DFE36;
	Thu, 17 Oct 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6qPz5Tx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EA1DF246;
	Thu, 17 Oct 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188561; cv=fail; b=F5vF+zlv2qcdlwa85jX5HX4JxDObdwhFPvblepLrvxzU8F3KC7XT1NdSP9M+YyFmHrN4Tbtra2EK3DfsHbivBku7C/rxOJwHkBBH+1DgEsOL3owhsxU4lQYNCnK5bgh09R+8AkymrE6RXmFN70DsSn7b7tBmJgIqa5qZV3clUAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188561; c=relaxed/simple;
	bh=KY83I7jmfEj3XZxUZSOjR/lt8jrU5WxwFBFzwgYW27w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIBtMure+RK6T1asI1KIGROIEYSudelZxNvpXwt2SG99a1143TbN5OtugNHp1OAoXwcb0tdfXEGsSu0o5BcUGm8v0dmq0RACOhRHgLgrBJeGMYetAnBxlHu+abrGOv4OBoKwPB4AHuULI1rCLQ69woXtbik+2f1/09nFC1a+Fs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6qPz5Tx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729188557; x=1760724557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KY83I7jmfEj3XZxUZSOjR/lt8jrU5WxwFBFzwgYW27w=;
  b=c6qPz5Txe3TYrai1ILPn3fkduE7LKyoJlGCqhfRf4bSTQnCmjN0AJLRF
   DVPyQjHQS81WKnDU0kdhTRRfbHdjgT1BIpN9PVy8wwG7ak8wHd8temDlQ
   x3XV8NFSPTrX4fmAGE1fTE8nQPRBpCxzCT0/w+vzY9J7oKe+69jKfrauy
   iVnmnpb3lTMOXNyD6Zr8uxDGDezi4NqBOjrZfK/GCkt1JuewjlYJlgqMg
   fdy9ra6kKpEbeyyHUdRdpHSGO8UTN9yssW1IfTwNKkRr9+MUZVYbQiekE
   v5vH+N3y8V4L2kHgNFbgc0LLl0ATyoc+LPSgKBb0vrKW+XOIj+MEdh29Q
   g==;
X-CSE-ConnectionGUID: LUEbNhVzSu2/PjyJyrqilg==
X-CSE-MsgGUID: 1J0MSADGQca+69WFZEBtmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31558945"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="31558945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 11:09:16 -0700
X-CSE-ConnectionGUID: DXGeegZ7RuOqiAPh3Vaxiw==
X-CSE-MsgGUID: Y7Xy8cczRtOzdQXJD9DTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116074445"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 11:09:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:09:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 11:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNWvEDH924xCyptLZs4pcKD+qzco7k1LKcScEFPbe8vAIAGOgN+7iU8L3k8moWsnxm8Hsvh5vRkukyWdEy/+v4CK1tQvTIwBw6pbPOwBtPfJnLxOEo3eXefsJHj9rnY+VMZRoF8gZDozSB7QsEcLbA/Qq1rdKnUGzp6TAuNG/y2+ykO71ANEhxNyF2vYpT/QaBMje0sVvCrPRV5wa9xlGQBoQaBGxnLMwAup/bXFqB7SFubD1xUGXpHZDsB6isrjpyvWauOFsk5KOkH5NcCHMa0B4qySd4oH21/Ry8WjbTMZV9ae26zpepwyZx2qsJl626HuC18uXXPs5X4YKeuF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kCygzX7st3DwWJMuqkUQvZAKn2Kaql6GLx7R3f2yYw=;
 b=uVk4Iq4jBLNsqhDcUVO9FIcQGZ2Jyag2dQCWTpNoJVMJXQDx+mAYy+4/Ra4HbrPdQMtvaNu8lNy1cpyJEI6Jx4blnZIbbUp57+nxgLTSwZu1Bax6cwxvSdzF1AH89vDp7aBFsHZVFItmPVuK7GGgJ2gYnhRfne4OySauNzwyaw/0qRZb1k1DeXNnDnw/OKBUYQJkfaKYy7Smu0Ulrmz4GhYJDassloFKGM3NSBne4yEP0b7aZY8I0o7DmwZjsKND0FPTCShThgy5QwNPwuRZ1/1lV+WL//7lyiWWSxT37SCG0mpgC0H4iX3V8E6JPgTA5nZZSCE76Vh44jsLneWS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 18:09:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:09:12 +0000
Message-ID: <a36ad97d-9013-460c-8d33-c40ba10b2949@intel.com>
Date: Thu, 17 Oct 2024 11:09:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] octeon_ep: Add SKB allocation failures
 handling in __octep_oq_process_rx()
To: Aleksandr Mishin <amishin@t-argos.ru>, Veerasenareddy Burru
	<vburru@marvell.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>, Sathesh Edara <sedara@marvell.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20241017100651.15863-1-amishin@t-argos.ru>
 <20241017100651.15863-3-amishin@t-argos.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241017100651.15863-3-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: b3095824-0d04-4664-eee3-08dceed6ce01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGc0WGxMTCs3RldkNUVtNThSZjVHOEZLSnNhTHVOM1YzbmZhbEhhNkxXd3B1?=
 =?utf-8?B?ZG9jMnpHRDNVSGpyblRHbVBsYTZhK09ZYTNHcFRReXZDaGh6b0hVdWZ5Z2JE?=
 =?utf-8?B?R3A2K3dHVlpqSEUzdXlrWkhpZmF1RmpHbTBnc09uYnpQVFRHaUVNdzRIVWww?=
 =?utf-8?B?T20yQ0tVem1BUEl0ajhvRGdORmlBUmUyZ3ZQR3dQSVJ4c0lJMXNDamY1cUlp?=
 =?utf-8?B?UFBjWjBmZFFWbThxTzRNUmdmTmNzTkJNUS9FLzZSa21sM09Ec2Flcitvb0Nt?=
 =?utf-8?B?QU8wMUNySnFIbWxOMW9qblRXZERMMjBUTHZkcDhBVXhZQ2VjS2k4UW5BTlkx?=
 =?utf-8?B?TUd2a0RrZGpNWTIyZlRzTXRGaFMxOHdVTGUwMkZ3VndreXhSY1Zyak4wUVN4?=
 =?utf-8?B?bEVVRnU4cXAxeGJ0bVFoNGJISmNIRDExRzF6dEJYZWs2SFdyRUtxcXZjK0pY?=
 =?utf-8?B?Qi9IVjVkeEx3eWJKaTZTSnltZ3Y5UTIzNmkzNmk1L2xGRjhwOGlOZGcyZXRW?=
 =?utf-8?B?YktOcjZHUUl4MUVkbG5QMEdNdkJ1djB3emNIQVpWaUd6M3lhdVJCTVlmaHJn?=
 =?utf-8?B?T0tkdldYcFFTNEp1eVg1d2JVMUNxNDBINTJZOUNja2tsRzk5YnNEdEg2Z0Uz?=
 =?utf-8?B?bVQvK1BuRGJOU2NlZHB2ZWo5OWluenlzSXBaRGdvdTlsZ1dCVHhPbHF2cnQ2?=
 =?utf-8?B?SXRTenFyL0RUcjRzNGVQQlF2YTg1MFNmbmd6NjR1d2psT3hPR0x0QzhQcnpS?=
 =?utf-8?B?T1RCemNiNzVLZmRvZzBBdGQvV2xvNkQ2YWZIWDRKUnp5VTRBYXczRFIwT0Qv?=
 =?utf-8?B?OEpGbnNDOGJUMjE5SzRqUGZSYUJPdFVOODZnejVOZmtvM2toNGRJT0wxS2hM?=
 =?utf-8?B?b3FhdzdnZ0xMYmRwajNieTNLY3Y1WCtieUZGZjJ1VnY5bUJtMml0ZVVlUGlx?=
 =?utf-8?B?dUxXOW8yRk16UVY3cVlJWktETk9aNTRrMHpIKzdaYUMzcHQyd1JUREpBbFZp?=
 =?utf-8?B?akxxckVtR0RIb1BxUGtlM21uMUtXYWwvK0IySG9hbnk3Z3lneUZnSzhDSi9k?=
 =?utf-8?B?Y21jbC9lL0ZZRFpoejMyOEdsd1ltbi93QVVkalZDd2VSTDFvVTVsV0Zzejlm?=
 =?utf-8?B?L3BDMlRiazFnNGhxanJKcDFKMFdYU1NLd0hKZUw3UWthQTBXSDZpS2NLV1d3?=
 =?utf-8?B?UmE5UjFwNmEvYXVwVVhpcHRKdTVWYlowcTlZMndXUVhGcWtoQWhLNTE5R01t?=
 =?utf-8?B?b1ExRnhoWWxvYk5tTnVPMkZGYlNDNWI4VWZ6djcwZlNUd1IzN2E1eGVFdGJk?=
 =?utf-8?B?Si9oM3BEV3hsdjUxdXE1dE53bjBFR29Ob2tNeTNwTnJCTWpVeC9tWWxRZktK?=
 =?utf-8?B?STdQNStjL3FtdHRHNGNFcGdzTHk4bitwWFkrN3VNTEtjMVdld2pmWWpWTU5T?=
 =?utf-8?B?b3lrTjMxZ1FBdE5oa1gyZzRJUjR6VTgvT0Q1MktCdHpNL0ZSMTdSMWh0WDQw?=
 =?utf-8?B?RWNYSWRQMXkyc3FSTHJZajJMbDJYVE4xK2YyaGNhQjlOenFJSkQ2SHh3M2Yw?=
 =?utf-8?B?ZmwydDJxaVNoc3pHN2NDWkMvYlVlVWozNnFxRGUxdnF2enk1NjBaZGNydGVT?=
 =?utf-8?B?RTNJUHBOUmNUMzdvTmkyRkNhbEY2dVk1U2Q2VEl4SjdQM01yMUtZZzNvK1Jw?=
 =?utf-8?B?UjRkUktKTlRDSjM1a0JKcWUrOTF1U2dRNEVma2I4aHU5R1lkaTI2K0l5ZzlK?=
 =?utf-8?Q?8trVHgP8/1XEN6dpDEI91jHdTWaVGPaNRTnN6oc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9KRUFmQ0F5Sjk3R0NRMjhyQmd3MDB5L1JtaC9DWlJLeS95amlFMjdZcG9X?=
 =?utf-8?B?UGJxVnN6RGJoSlBXQ0lJVW1wRmZiUW40WUFmUk9qTzFpVFdNZWRQTlhtWUNJ?=
 =?utf-8?B?dnNwa3VoR245b3J2WlY4MlY5N2FEVWxHK2cxQmZVOEM3bmo3TzFTQlFiMjhz?=
 =?utf-8?B?YlZPTmJhV1RyYzMvU1RPTEE4VE1NNGFaSXpsWG1aOGdJbTVvUDFDejg5N2M2?=
 =?utf-8?B?WG14aC9QcS9GcmFRN2V6ZzVEbzlUUG1DVXh2NlZwQWxQL2VQWm9rMlJEMDRQ?=
 =?utf-8?B?WGVEb1JqWGIraWpCZW9CN09nVHU3Y0IyOC9VMHQvZTUvNEpFUE1sK2FNaDhw?=
 =?utf-8?B?Yi9CMUh0OGF2YmxRejA2Nk1lOXlrK0FySS8yWlhLYmFzbmw5dGRsVlNhMm9h?=
 =?utf-8?B?ZFpjTHlvOEVkOVhWcXVDRFNmNkd6eng3VGJ6dEIycjVzMmV1ay9kM0J0Z3Y3?=
 =?utf-8?B?T201ZENreHRZdjRyaHZuK25ESGd2OXVUdzlRMGsvTmVobXIyYXc2UXVlL2di?=
 =?utf-8?B?Rms2VzhPczFrVnZDN09LYWN5TUFjZG9XaGNrSDUwY0Qzbk9rZjVKYmxSY0FB?=
 =?utf-8?B?dml1cWZEL0xJOFIzRFA0MkQ3N2lpNGFUb2NtdjNYUGVBVS9NOEo3VlRFb3lN?=
 =?utf-8?B?WmJpNVdsS2p3bXB0NndqK3VHQlEwS1ZmU2JLSXBEU0pIWVNDdHVXVFhiR3Av?=
 =?utf-8?B?dTMvN0docEZsK0tJWG5YZmx1WDZnNlp4WVFBVjFlSUptUnVwL0JyTjBDSmZu?=
 =?utf-8?B?YXlZZzhsRHdwdVhHKzBHZC9oM01QQjZWcUszWFhXVFFiVjYvSHc4eGFDSmtG?=
 =?utf-8?B?V1VtQ0tKUTJqeUlITDBSaXN0Z1V4TEc1dHdUOEI4cEc1Q25lRGJoYmVWUUlw?=
 =?utf-8?B?OGpCblA1NXZOejJscHhmL1BockoxQms2YVhQN3hYT2VSZzZkNlBJSi91dnJT?=
 =?utf-8?B?WTNUZkFrcHlDTUxLRUloTTMwbzl3QVllREVSZ1I5YmpIV0U4WVRaNkc3VlVJ?=
 =?utf-8?B?d0VJZnNpMk9Cam9LOXo0bnhvSThNaG4wZjlIdG0yWC9uNTNSL0JldjF5T1R3?=
 =?utf-8?B?SGxMNHRNb1ZpdFZWQXhvY0VQWXZ0ZGFOdlB0TjZsdWQraGkyQlJTcld1bERD?=
 =?utf-8?B?blg5d0huZnhDaFNSUy9JeXA1YjZSTGtoemVOamNveDJyTUdhQks5VERzTnF6?=
 =?utf-8?B?QmI0REgvNjFtSUQ5YktmUU0xRTNScjZOYTZ4MGU1eUhVRlo0R0lWa3dESEZE?=
 =?utf-8?B?OFQzc2ptRkFoRWlFV2g1Q0NBS1A1RGcvL04zZnorWjVOZzRYcEVTb1NBVFdB?=
 =?utf-8?B?MGJiY2NMWWQ4WjhVRDFOZVlUbDF4clBxZnZMbjZ2SklVWVpXVTVrQUozQUc3?=
 =?utf-8?B?L0Fnd2VCeHp1cTFwcnRiRllCTmVmU3A2NDRBbTRRU0xxZjUyUWdYNWdxd0dV?=
 =?utf-8?B?cmF5ek0wenE3dVVBN1VJd1JPb1hIZFVFWkVxS2lYczFXelVka1JDdEpWR29k?=
 =?utf-8?B?U09TSnBmU2lXak1Qc3Z2bHlHZkhMZlgwSTF3RTlYSHV4L3NEalVEWXYvRUEz?=
 =?utf-8?B?UWdZUno4Y2ZLSzF3M21JQUV4S3NpdHJYdlpROFVVQUdROGtrUHUyVFVyRG41?=
 =?utf-8?B?MU12QXNNZkxpT2g4MkwyV0lnNUJ3Y1dYcXVlaDAzU0JSNEZ2dk1rYUEwODlt?=
 =?utf-8?B?M2x0MTk5dXdOc1hNQ0IxdEkrK0ZwMkdIL3RId2x0RTFRWXRnL1Uxc3ZPS3Vr?=
 =?utf-8?B?TndTelk2TEtIYU5zdjRQM3VLcXlmcE9mZnVZT2FrNHdhT3d0UDVYV3YwbSt3?=
 =?utf-8?B?Q0RHcVhMNjhZYTBWOXNyWFVJUTBUcnIvVGNBdjllclBZWTBsbVNyUWdWamxv?=
 =?utf-8?B?VlZxdFAxTmhuOUNQNlpFZnAxa3l5amZISU5HQmM3cktEbU9aWXBCRjZ6VUpL?=
 =?utf-8?B?eDlBSnVpUzNnREpmaFBkL0dXd1ozSG1JQ2I4a0c5ZFBTdjZPTHJaOUplVGdv?=
 =?utf-8?B?SFUyRVAzaG9PdEdFcitVNXhTSmRDa0h1SWY3N2QrWDRxL3g3aUJJeW1mQmVY?=
 =?utf-8?B?SWhBMWwxd1owM09xZEVlY3l2SlhmRUcwRGNkbVRPM1hyMUY1bW5rbWl3YlFa?=
 =?utf-8?B?SmZKZURjYkRWZVRINTRCQ1RDY3F2T1BHMUI5Q0tvZmV5QnU3VjYrb3NBNWZU?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3095824-0d04-4664-eee3-08dceed6ce01
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:09:12.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGyYOWazHnEkwzI+b6aHHJISdgFY8nwe3JAUf4Mcc2bAqTbIqxVHnQzUngyycWqhXkGTan+tbrZUbj6WddcAuGjvoWbpOa0HmNw2Kh/J9c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com



On 10/17/2024 3:06 AM, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> Helper function is implemented to unmmap/flush all the fragment buffers
> used by the dropped packet. 'alloc_failures' counter is incremented to
> mark the skb allocation error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

