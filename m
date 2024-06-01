Return-Path: <netdev+bounces-99877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5A8D6D1B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B04E1C21018
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1417136A;
	Sat,  1 Jun 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix79pHh2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC746EDB;
	Sat,  1 Jun 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717201204; cv=fail; b=uNIznjtyleEYJ5sKMjHK60opwdCCQB9Q0QWffyBAtUwbMwKpzB2RHptfFAdxf1Soiast1O+oTtsnxO0tSSOLXukM+b7g5tFNI7U5VuXLXrZfasq45zz1s4CURYOli/FK4ml0DmkgYdrEoNvHxej1kmNHP7e5Ay1Aq7m1spWfd9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717201204; c=relaxed/simple;
	bh=b3tZYv+KxEXNM/yW59HPEELytBCSyW8Qo7rnTyP+mRc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwD2NoV+qHJh81nA/759id+r8otnHDgkuKQMn2WUJdMB8kbiNZOAG3lN1VwmUcf/bnt0F3ODOkjBH7t0w1Ekh0BSWTLYpGons261AoLhjBFCk9Pe+FjAlbhgWKmDuo13Rb9iR0lFEhm5CUvbYWyQrNmILUSZKjHFuLEMryYkD5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix79pHh2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717201203; x=1748737203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b3tZYv+KxEXNM/yW59HPEELytBCSyW8Qo7rnTyP+mRc=;
  b=Ix79pHh2TCg1cLSjmhhgnZVAsouGSyF1ncggNnyKwCaU5vF3fOSqbzJH
   A4lJ9A67cTwrPqFCrdviSSlnn5OhXWA7BjTeFi27HF8eHJGWMY0OL1cAV
   fwqjfEQT9z1N+rXznwWNQkHSL9k/oPesivAFA6EezShl6GtqwQzyxSlzM
   xCKy1qnWjj4sEbo+2d7kTBVA78ZbTsJzevQeGxEcwGzdtdndpSFKZ8IoL
   7LheZAQxmnGP9OjY3VcQmCRh4J4hfKTh5VFF1zLVvP7SeLhNlfqbR4QX3
   ami29f/81VIt58Tp0iqSbzKYdSyORPfX0FzOC8En5LdO05QQGS7PKLbuj
   A==;
X-CSE-ConnectionGUID: 03Tufw38T96JeW3EKcZcdA==
X-CSE-MsgGUID: qY5zhrFDRvaY/7X7TnHL8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13955951"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13955951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 17:20:02 -0700
X-CSE-ConnectionGUID: pOgGeMYTThi0YEkTGUM+gw==
X-CSE-MsgGUID: hu18OErvTWatmB2MnVkVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36316534"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 17:20:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 17:20:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 17:20:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 17:20:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 17:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cffErf/x+Pqt30JzfUsN10X358lg5jNW1POpL4a+xjloZUPKtR/zlXhLvCV16/m3L2SJGNcI+6lkcGTYMaWeVFFdwRFVqSvR8m/4XHBYoic/y+o7+2/+9yAdIPAq2RlBHgmtf3BYEvYQAlCJu0S06+11zmjhNxEoi/x9kOOYAGQ5KBFR0gFiJ72glN1xaKwOrShcQMqbQNkvY8c85apaKcmlGRH+82JR4NJEYtuRJ+p2JSubO2pLCFwj7MmJ1fwOHZ7EF5IxEhsrUHnC9fKj6he/mt6Hag3IWenQtJvcuOKH4S3op9OuPo4zNfr59U062LckBkO8CYOTMSVhw97D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InUzqeARsLuagyzHS5A7opu4y0Yla0j6oo2zNaZ4ZmE=;
 b=SsQYP5LKye6Rf+hEgRNBbGYE9pAZvGaaSZ3E5iLtZ2+F3Is028rKfwbunLkIU4D+Xm9xrH/N96YcoiJefKPrPWOLQJcE8HaZA86lRxwfQ1DuWlC2v/L/ZAhfKXtDnowe1QFEwJXI979iYzFyrV0+R8z/sHMeeOBNhR/A7r9DZtC93Z/3P7Wy2+8X7mIdjov2Mg1VgvWoceoGVjPAYPbnzWX0HdUpAG+mHxph/ADxvgAj1LHH/Fb6OhENx0Z5ALi2wB+tq5+x3qxPRE6jMx/QvLkPEWfhXuyfIiO/5DfEJ/cvYKM4nBbmrAHWcDLGovI6HVJT0FtGgq6Yl+oPA8U6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sat, 1 Jun
 2024 00:19:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 00:19:58 +0000
Message-ID: <459119f9-f477-4b10-b6eb-27fd667b8183@intel.com>
Date: Fri, 31 May 2024 17:19:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: caif: remove unused structs
To: <linux@treblig.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240531232917.302386-1-linux@treblig.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240531232917.302386-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dc258b-749d-4871-f94b-08dc81d09257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTBJVWl4dTEra1BOcFdrblYvWGJwZnoxWEJwTkJVRlVYRVJCUGpnVDllUmhX?=
 =?utf-8?B?cEpjL2poUG5XRWJUOGc4eVI3eVZMREdVTVJ3MUFsdHB6S0I3N0RHREpGdkNR?=
 =?utf-8?B?SmdjaDFVekllajFQNDJ3L0RLdFQ0aExka2lWc1NvR1U1YTZkVDl2TkpqOUZK?=
 =?utf-8?B?T1FXZ3o5cW51VDJEK2hiYVluQlRkcDdQazNBWGJzdnU0dGN5Q1AxV2lUd3Rk?=
 =?utf-8?B?RVc1ZzNZS0RKQktheEdDVGpjUWJSZHlDRVFsTFhBRnM5aU1WcjlPRnZDOWph?=
 =?utf-8?B?VEduRXZieTVIY3dxR2xudkhCaVJSRVpNVi93VXZwM3RJU2ViL0Q2aWM4T2VH?=
 =?utf-8?B?TE5RZVp2RzRaVHl4UmduQmZpc1NoL2Jmenhja0YrR3ZpOWZUd25ON2tIR1ZK?=
 =?utf-8?B?VXVHaFlWTzNhZ1R1Nmx1cnJUd0o2anRSY3hSVjlUeHgyNC9IQ3p0QWw0Y2tZ?=
 =?utf-8?B?NUFQZ2lqQkd5R0ppdVNrRFZxbnZOT2RSMFRZcEdOdXFmZFZOQWRnT2dUbGVB?=
 =?utf-8?B?bmE5UFVUblNPK1VWYVpNUmJsdFVNUUNHWSs5MDJ1UE83dFNzUWpLOFdGY01J?=
 =?utf-8?B?RWdWZ0hld1VpY083SkxTVWwrV0NoZDhod2dQcG1aUWUxWWxGazRkRWJURVpD?=
 =?utf-8?B?dXNpNGZwMmFOc0hoVWhWMWw3OG0xWnFFS3ZuSWxFVHQwd0s0UE1DcVlobDd4?=
 =?utf-8?B?Zi96WVBqb2ZJVDRlNXh4K1U3VERydVNqQkwyZ0YveUVwc0FoYkpmRnhHaThu?=
 =?utf-8?B?eEUvekRzcVJ0QXh6WFJuRUh3ekJrMmYwQ2hRaDY4UnYwRGhNZVhiaGlOalNN?=
 =?utf-8?B?aXZmVk9SYk1HOTJ2a1VyMXBqZkFFOWF6U2V1dDlySTgzQnVtWmt1b29McTRV?=
 =?utf-8?B?M1pqeDg2QUczbDlKVjhLR2RQS0liM1RQdDVqZmJKaVVyWEp6MG5HMmVQNE5n?=
 =?utf-8?B?K0ptNG90YW5CeWU4MzFJU04vZEtobTVlcDY3ODRVR25wMlIwQmdTS3lDWEFN?=
 =?utf-8?B?UlI5VHQ1Nk54bHFBalI3S0tJcTVEK1B0eGhSajBDQUFsOUc2V2xLV0lWWEE1?=
 =?utf-8?B?VkNyTkZqdUliNGpnci92SlZDOGljMHYyYkY5UHkzR2tpWW1UbVVraTlPM2tQ?=
 =?utf-8?B?QkpaUWltZWVPbDdLL1FZR2ZLQ2xIQ0Q2UEduYklzYlpnUHRxTnkwWUhyYTVl?=
 =?utf-8?B?L1BUMk95MGVIVWFCVmJzVFRGQ0w0SVFDa295ZUc4LzdWTzRQM08vdldvYS90?=
 =?utf-8?B?Zk4wTGtxalIwTytuTldKWHZJL3J6U1NkSko0eG9aRDNWQkx2MEpUTys5MU8y?=
 =?utf-8?B?Y0hzWjJwQ2J4WTQza1pYTlBjOVl0a2hpTGhhTWNrT0xBS0JZRHJYM2RZMjh1?=
 =?utf-8?B?Qkw5VXIrczRaVktzN0dMZnBkQmJhOFpZcDRLbjFnaHBtdEpQUGNJeFBXWnkw?=
 =?utf-8?B?aEVLKzJSZ21ReHFoVnFhUUYyY1dhN3M3ZVZoWkJzNGxwV3VjQWFSN0xNcTNw?=
 =?utf-8?B?Smxzc3NsODZ5Ny9iQnY0RWR4Vk1hYXUvREl3bGhXOTVGUEhkV0ZFRFJsTit0?=
 =?utf-8?B?bXU2MXlwYmwrRUJ4ellPMm5xLzlNcS9hVXNwWW5UZ3hIZndKSTloaEVCS3RF?=
 =?utf-8?B?eVVTUmp6WC9RQklxRTFzRW82Y1puNEErd3pjV1pzTVRFUko2ZWplVXFxaEsv?=
 =?utf-8?B?Ykx3dll6ektobFBPQ1FhZm5vNUh5ZW1ZRkFhSldXRm1qTDlRUHRVVVV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yyt3b0hnMy9IUkF6MDVKRElpdkgrU2Rsa2VPMTA1RjgzTis5MUg4WjdZVlRm?=
 =?utf-8?B?ZVlkUjU3U1g3NmtveEM4ZU84SkVQNytEOHVhaEhMN1F0MnF0RFJndDQ3VHVV?=
 =?utf-8?B?VURZSTVQbnBhY1dMczR1U3BQWGF2a2dnLzczeFMxK1lENmVwSHlldGVSbHRC?=
 =?utf-8?B?bU5Va2xRN0dSQlJqb0tGaWFtZUJkUzl1alcxSWFwM0hHQ0RuWWNLUjBCWm11?=
 =?utf-8?B?Smx1SnFSOFNZNm5meWVlRWJvM0VTM3NDMGkrdDJnQVBvRVIwZ2lHNFo0d0Uv?=
 =?utf-8?B?Tk9GK3FKbXJvbG9NVEpJK2xnVGlybTF5RDVjWlk3SVlyS1VKd3BVazdCRjBF?=
 =?utf-8?B?YW9obTUwWm9WU2ZDQ0c1STdxMHV2VjdkckswdUdhK250dnpBMHlHbXRZUk5M?=
 =?utf-8?B?ZzJNNVNwWk0yOTUzdHllNFdiVHNSc1RzaktHN3JodHRNZklQTDlwc3NXV3VG?=
 =?utf-8?B?TThIZE1nRHpBblJzMncyQ2o5aFFmNXNhRlpvUThWSDJacTZPbHFtQWNBSWJz?=
 =?utf-8?B?TUtldW9JQzJ2TXVrb05DSUtKQy9aN2tKcFpRditiTERJd05VdVZYUkw3SGZs?=
 =?utf-8?B?Q1ZtU1cvTUx5eDBFTXVCVWlMSHUrQkppVWxDR09TZnd4WUZHQWRTcmsrT2hu?=
 =?utf-8?B?TFl4Nkk1dEFkYkkycnRHOEdlc1ZHRk1VRkwwQWRVSXhRYVN0dGFSajNkdHNn?=
 =?utf-8?B?QjV4YnRCMGVvaWRGSnpEOWZLd3MvbitaWit4ZGdwSHh4SUtYK2dIcW9Jc0Ez?=
 =?utf-8?B?YTN0WFhidEh0eGdkZGdpTlorU3VKTFBMV05OQUpyUE9yTGNzMDI4aWlvaE1S?=
 =?utf-8?B?TnREVVkwbjBkN2FRenk1aFJLVjNxSVhnbitWSktPanRzMjNPS2FRSTlpZ3h6?=
 =?utf-8?B?elBoOTl2WU1IZFNZTzg1UmJzckN6b3NuamtTWWxQSEVjVkJ4clJPcjFjWmRw?=
 =?utf-8?B?NWJaL01JbzdLcUE2cTZQQnlPUmZESXd1bnhoSzVWV01jbFNyTUN3VEZhOU8z?=
 =?utf-8?B?SVBFdVl0dmpzbEFVTUVEeWJQbThMdzh3SmhEbW12U3U3Rk8zTy9jbFoveUgx?=
 =?utf-8?B?djM4WEhGb0kxZzE1WVBBNFpmaktUbXMzU1J0UFRuWkpqbmYxUDNTNDRCRWQ2?=
 =?utf-8?B?K2srT0Fqd0RwSzllSmRUdGhuclJLMnZmbkxFak4yQzJidGpNcXJSWEZwWW9W?=
 =?utf-8?B?Q3BDaXlXN0RwTWd4UTJqV29hTGprQnFnd25XNk5iTGk3ejlQR1ppMGVNZmdZ?=
 =?utf-8?B?Z3lXMzNUOU9OaEFtY1RhbnN3VW1kZ2ZOMjNud3lIOVZodkFCQ2h3WjNXM2E1?=
 =?utf-8?B?eC9GMDhiaStmWjlRcGFpTW9YQ3RickJNd3NCOU9aY2wzOU5lNWpYaXJ3WGRv?=
 =?utf-8?B?cGVPaDYxUmZGSzVYZXo2VVVZa0h5dkFkUElHMFZxT3dXd3dQWjNDTW4yYjVu?=
 =?utf-8?B?c2hyTWVVZWtlN3VUNFJaTi8rd3BnM0ZOYnkyWk9rS2JvNm8vcUt3ZG0rVi9k?=
 =?utf-8?B?YThsT29qaW5aVERLc2dOWHZxNUIzaEVQWllZMHQ2aG1Dc0ZFQzd4SU05ejg2?=
 =?utf-8?B?ZXBUVlYvVUZ5MDhtbkpoSnd3VWNsYUlMYmtaL3o0Nk9VbHE2U2lzVi9yUmJZ?=
 =?utf-8?B?eVNya0NXNVhJcFhzSFpwSVdwWGkxQ3g0OUZXVVZuZTg1dEdnNm55a0NkUnJn?=
 =?utf-8?B?VVZDM29PNkRmNkM2dldSYlp2REhVRnVIYUdhRjQ2ZVlodUh4d2VrdUN1V2R3?=
 =?utf-8?B?MXdUdG03QzNGQXV6TEdFUnNFMlh5dkFDZHg0c2RMWGpWcnJqSHVmMVE5Qys5?=
 =?utf-8?B?N09maldXUUI0dWNLZ2lqbUtvdUVKQmdnN1FlbzcrZ2tMSjZZek1mbE9uWFlT?=
 =?utf-8?B?TEVBM2hEdFZlc2Vobnd2aVRZbFdtNDc0d0IrNGJaUitleitmUG91ekpHQnhv?=
 =?utf-8?B?T0R2Q3dJTjFnOUtiSWJ6V0Z3QkF2dmtlYU5nMU81TDhKbUdwNldlS1daUCt0?=
 =?utf-8?B?KzZwTENMYTBVVU5WOGRZQi9wRFdMTEtteG5MVzgwWk1ZWHdlRnN1bUUwRWl2?=
 =?utf-8?B?SmMzMHhuYitJMnVxTElHdC9SL1g1WWVDSjVmVlkya1IxR2dheDJVNzF4bEN1?=
 =?utf-8?B?UFBCTTQwT3NjZnE4azYzQTJKbG95ZU8rQ2R6MU9UUjhPa3F2Rzc5ZlpXOVNL?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dc258b-749d-4871-f94b-08dc81d09257
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 00:19:58.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwyMLblHSPps3PgdzanxgdMdBcMJgpJ7KVgnXee0scf+Uyq9f06YRl+fNuvfrUFFkLdKG/6JpiYGDX7izQUXZCfUJjp/if3nTHUeDl1kAhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com



On 5/31/2024 4:29 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cfpktq' has been unused since
> commit 73d6ac633c6c ("caif: code cleanup").
> 
> 'caif_packet_funcs' is declared but never defined.
> 
> Remove both of them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

