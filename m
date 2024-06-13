Return-Path: <netdev+bounces-103177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12753906A62
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828EC1F21820
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9813DB99;
	Thu, 13 Jun 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLZoZkdi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573D132114;
	Thu, 13 Jun 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275685; cv=fail; b=ZjD/gLpW+E9ArWp4WBc0D2xGONKO8flVTO8fdMjQ6sSYTAL+MFYlh2qB1zGvHTmHs8NJdVT0xGkjo75ymnxwEPqRXLwhsWSLTmfQl0HzAv0SGlAaflQH8KAvKQzrqV9rnjR+8W9AO+zgeDSbcT1xTJopam92sozxGNOrnFgKVtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275685; c=relaxed/simple;
	bh=IphsSU75+3bz493Bg82pRbpjtC51e66eBqMxl1IF35U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZ6qN2ZOPGppB0Q2r/JlE7flYIR+LpCGSjKJbB/JP5bq9HM//YsBPWWA66HNBypAR6StQFgClfjWwbcMznffDpYezhC2W2298TJPzXI8DiwZdkRx0yItRGw/HpxUIoRYdFtobkpALyHH6B481ixfBT+lCp8ifB+bOtmQvpcxNlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLZoZkdi; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718275684; x=1749811684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IphsSU75+3bz493Bg82pRbpjtC51e66eBqMxl1IF35U=;
  b=GLZoZkdiFlVQTLutKwFKCc37/nCU1R8CqH4SEkDHA99w7nljxfxa/vLT
   1wkV7LxQBqeX5qJwGvb0nDhdvtBJx3+VKLl0Q+X2cbxZqokjehnw4Ecn+
   SOI983SRV+Cv+0nHwsgNi7lbooUhEBUgxksKN72K9FdMyoSo0TCiqO+/0
   1FEvMVsBu0KVYD+zpihJMbIQM7/T/HAlOqOTshUZBTBMqMqBuK3wSbS9W
   PuOCdq3pBO7+UDRA70dX0FyB2n9OOf/oG1NzCsUYB/GZLsnpPIOebwvPB
   kWPBWaPDMhdsdVbbdvm/sc4mCehWNM4Yw0YblqJ4qouxzOGddtwd1xoST
   w==;
X-CSE-ConnectionGUID: 5+a72M1TT6yUHqLYOGmw3w==
X-CSE-MsgGUID: 71AYQ8KyRyqtIIQpZVL2gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14811167"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14811167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:48:03 -0700
X-CSE-ConnectionGUID: ExbKDVngQXaAiVCebDBN6g==
X-CSE-MsgGUID: zWrdIoibSD68PMjPLII9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39983923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 03:48:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 03:48:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 03:48:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 03:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScUEunjf54MzW36mkV7T7FOrKQjri6iqGytXUE+VbHE7adS771XQhsBHz6QKJ2PJuwHK00yLeyogp53jKcfTJl9qXkINvKjyaIBA2VX8ubrpRMxrCz64FCAeA/pz79jh095fG7u+ICm24G9jEkQR5vtlLFX5SY6o72meT8ujIwVuQROsh8DDajUOkd6qmRmQ/7wVreTbwfPPHWl8X4KdJPoEbKS/6HfK0mgsReQ/A9sGXkAXh9USySoZOU7X3E4Ny5/wMcFVJLUMRFpKsZo7ennFuLFHHETXDbF5ympwsF2SUJvcCBvgA4RU8zCG1xM5vwGTrImPWupDLAe4+JView==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKrKu+9Rdt4aLm+n/RdLfXz7P70b4IXShi7apu8F1jw=;
 b=mFr/pyKuAN2tNVtWgESXBQxoICHy/nmOXarb0pew2qhuaoXzsDTvVh462TZOjgGv+a9IxA0fCP39h7cGHXshmrmQolBo3D5csOYd5QN2F49STseM+e7+Fo+nCaZRKx3U3fQumNrXXyNfdYVbjNo8EkMVbaw/Ew2JMAcQtA427AgWwlBEf+1PJir+VDsqHU4jVopo/0O4D9sirYfnY3BEwyUSMUX0OCP8Dyvpz95xumzSEfALTkDFcwrcvh07dRHUSTWCz4JBvcEPj4ZRjsf81RSnDdOlMNW4l9FK1+PM/6DDN+r74qcC6x+mP8GIXtp1GoSasHwQbA1l0grwsBKDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 10:48:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 10:48:00 +0000
Message-ID: <43c1ec2f-977e-45cd-b974-e943fa880535@intel.com>
Date: Thu, 13 Jun 2024 12:47:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 01/12] libeth: add cacheline / struct alignment
 helpers
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mina Almasry
	<almasrymina@google.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-2-aleksander.lobakin@intel.com>
 <20240529183409.29a914c2@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240529183409.29a914c2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: b7539ad7-b8cf-42bc-13de-08dc8b964b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vy83TE9WNTByVzJGMmV2VHlGbkw5bCtjeGR3d21qR2gxb0wxaEI1TGVjWnBa?=
 =?utf-8?B?SHJjQXhVbjFhU2FVRnpERytXeDRGMCtFc0dUWlo1SGFqY2NSU0FScHdUZ3Vl?=
 =?utf-8?B?cjIwWEQwWnY0K3V5NG8yNmpvaUlPVzBwQk1SOVVIZ3VMd0VkSTUzZnFRcmZk?=
 =?utf-8?B?d1c2ODNqTXRpblhSQjRicEZORXBNUDUxdENpVndKTS9tVFp3U056QThVVGts?=
 =?utf-8?B?MFhmT1h0S05uekQxcVJuME55TEpNUFVlaWk5VS9xVUkrbDhDdTFXL25YWlVG?=
 =?utf-8?B?YUUyZjFycDhCeWpDOHhuUTlOVlh0eEwvdlB3dUdZZXFGYTFJYjZ6UktwdUtP?=
 =?utf-8?B?dDVhREFxSVROaEZrNEUyc0JCbUZ2RGptVEIzdTJnQ09kaHJRTHNNUTRJY3BP?=
 =?utf-8?B?Vk9KVk5IY1pPZUhjbGNVTlltQWkxSGhjRmZ6ZlVEcjd2Sm40MkpURlRhcHhO?=
 =?utf-8?B?K1NIcFYyYWhhTFRwN296THVIQkdmQjNKdUtNeVB2S3Z1OGdxcndFSVh0Nk81?=
 =?utf-8?B?NEhtTUlOQy9yRnlHZUdmRVgrVDY5MkZMZzZPVDVUejFiYklGRy8xdEhvSkpQ?=
 =?utf-8?B?TjBhdEEyd3dENmFacjA4SnVJSTN1MVpDYlN1T2dnb2RpN0xUSEYyclFRNmZt?=
 =?utf-8?B?cHlYNFdkUjlvVjhjYUh6bEpEN3FGZFNORGpndUIvTVNQMzJWMmhMYXJqNE5K?=
 =?utf-8?B?eGFoRnNNRlVQMmJKaVhkTy9KSk5HVm1XWnV5NDFIZTRCZm9xUWgrQk4rck83?=
 =?utf-8?B?c1B1S1NYVytxdUZ5M045R0dhUTJ5R0FkSGVraTJIczJGanpFdDB0Tk5MQzlM?=
 =?utf-8?B?VEg0SGhHbGJXYmFRUCt5Rmw0WDVyVlNBOGZmbElmU0t4NndoUTJZbmFUK3hI?=
 =?utf-8?B?aTRHNGF5blFjTE5GbVV0NFJFZlNiOCtlS0Q1bXNrSlNabnZRK2hlNUErbThN?=
 =?utf-8?B?MGRTWlBURnJuNi9LZkY0Y1VvUWJXVmN5SjhMMjNHMktUWit5bTVTNjZvZ2xi?=
 =?utf-8?B?OW1qSWtrTS81MGxpeGpEeGRIdlhBM1JKajhKaVRQdWlZRllwWTQ1Y0ZzU1pM?=
 =?utf-8?B?c1l3NGErRlgzT2RoamNHUDVtdUxZNTRiYTNJRmFxcWZ2Wk9hZlRhcUlqN2J4?=
 =?utf-8?B?RWdudXIrZG9Fa3RpVjBHSW4wY0xxMk5FemRKdlJUM0xZQ3hoUHh0V1BJV1Fz?=
 =?utf-8?B?bTc0M295NkVOckVYNXc2djdMU0xEenp2dXcxZCtCVTJaL080MFMyODZKNFp1?=
 =?utf-8?B?THZ0YnR5L3hoWngzeVV2T0xoZFhVenpTd3F0bWpRR2p6NXV1Sk5GNmdORUg4?=
 =?utf-8?B?T2Y0THZqME5JT1VGR1pZdi9hYkJTRUZhQWFadi9ObDJFa0grNnVCVzBUZXd2?=
 =?utf-8?B?WEIzUWwyN2FyclUwNkQ1WWdmVmNnK1ozTDJmb1VPby8zbFptY2x1MHBDQXRH?=
 =?utf-8?B?b04xS1dPbENuaXUxYWozVHBCUldIWGlaR0hFYUJzZWNCQk4yVzdUS3NxT0hm?=
 =?utf-8?B?dHdPYzZoZGFicFhyWEZoSXltMGxxYU5aUXVRZUdaWlljZk1aZFd0U2R3b1pj?=
 =?utf-8?B?eWF0UFRDMG03bGFMcWEzR1NDVkErbytMcExqTG1kaEViT3k0eDduUDJMeEFk?=
 =?utf-8?B?UUNEWDB6MU1ySjNaU1ArY1Z5UktSOHNzSHNvV284am45b21hdS9YNVVxOTRy?=
 =?utf-8?B?clA5bzF4VmpmMjlkZllzK3VxRDQyN01CNHZQUUpaUXRxQ05FcVJNSFc0dXda?=
 =?utf-8?Q?3TaG7y+loFAKeMQG3KEBygLq2qQhjU7BqQ8cs2O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S012QXk2aU5LbTlOWThVNHZ2YXlOaWpIdnh1SnZhZzRIZlk3by8vL2Q3aFN4?=
 =?utf-8?B?VmNOS056d1ArWnhtVUtCSUp1L3lxem5TczdmSG82dFpsa1VrakhFeXBiSldo?=
 =?utf-8?B?d3c5Y0FYeVNLZFVTcFBQTG1YU25ISnpMc0krTExGYVZTMXY2VU9ZTmltS3dU?=
 =?utf-8?B?VXRMcGcyOHZqQVhZQVdoTHZvdHdqUldveVRvZTdaMW1XamhXcnBaMjgreERq?=
 =?utf-8?B?ZTI3SUxnVDVwdmR4VUVLOUQ1ZEQ1ckgwSDNrZVZ6L1dDaUV6N0RTUzlzU0JN?=
 =?utf-8?B?dnZ2bktYa2x6ZDZyZ3R1ODdUVlFsUzE5ZndValJNNWVTTmxPM0d6djZXNlFa?=
 =?utf-8?B?QVE0OGdlckJpdUVBTkpnU1lHZFZPQ242d3BlU2hnSHdKNkEzRHZOV293K0Jp?=
 =?utf-8?B?ZXZBQUU3Y0xweXBGbFlzK21mVU54dlBYcHUyTlNIQnd4SHFJQUhxekN4VlIr?=
 =?utf-8?B?VzBndWRGTmNYdFV6VWxMZTN4L296cm1YM01aVkppaWFBWUpHVU1FQ1RRcXFG?=
 =?utf-8?B?Ym1FcVpETnp4S3l1eGRIaGFNN3JoVXJSMnp2Z1ZxZ3ZySy9YMlRSQVN2SjJK?=
 =?utf-8?B?V211MFdqS1Y3NVBtZEk5QTZ3eEo0ZkgwMVZ4ZW5zdHkybHRJdmlUeDVwWXBR?=
 =?utf-8?B?bFpsbFpMdVBPRWxGK04vb080anVrMERUR3pSQW5WVzIweTV6WjZ3Tk9nZmlu?=
 =?utf-8?B?Mk9KK2FBd1l4NTRrNlZ5NnFieEw3VjZWRFM1ZHJvbGI3WlE3SnJnamk0Ym9w?=
 =?utf-8?B?RUxTQ09ZNG1pMGZhVm9HYnRDdVN2NlQ5OU9GTUtSKzhLOVQ1WFh4b0M5NEtz?=
 =?utf-8?B?UGorek1xRFNHcG82OXJRekVnMDVBVzFlWmt1c2QwaVlDL3BXNmE2UVhLMGQ5?=
 =?utf-8?B?Z3FmWWxmNmJPdTM0Vy9qNGRVbUJmTU9oVkZUWmt1LzFkTTNxZnRuTTdJdTN3?=
 =?utf-8?B?TkQ3OVI1d2pvRXl3endUdUd2anN6TFluNWxlcjR0cWtuMk4zbVA4MlNsNXMw?=
 =?utf-8?B?UTdqbjNpUUhNUThwSWNKVnZpUWlDSk1GcGs5aUVLT2R6d2RiZWNZL2tZZFVD?=
 =?utf-8?B?bERUWGtXT1QwVWQ1TkRMOFNzc0JCQlozWXV4TWV2TkZ0QU1NWmtsV3JSWlFE?=
 =?utf-8?B?d0dHV1p0WnU4c2JjMVF5MXZidlZFelhmOUM3ditMM0hCR3pTY1hnM1ptUjQ0?=
 =?utf-8?B?OE5qODNnZUZJRmJvUXBlYWJQdzMwQjR2SWtjWDZaTWZUY1EzdHJYWDRsRUFQ?=
 =?utf-8?B?Zkp3STJrWUNzNlhWVlFsQ0VOaHUrWnljSEJpck1TS2ZKWTNuODgvZTM1eklp?=
 =?utf-8?B?OFpJWGNtaEtxcVN5SjhlVS8vSTFXcnVpbWVtN0tPRWZwaTRLTVdYTUtXVURW?=
 =?utf-8?B?NHl5OUhZUkhMRG8rNkY5c1N4NkI4ai9rWEZXYmNoaVNMUDFYVytHZHZFRjVh?=
 =?utf-8?B?M1hIREs5Z2RJbm15ckxUd0hvc0s2d3MwNndlZ3dCUnE2bmFjRkRXQXE2SFgx?=
 =?utf-8?B?anE2RCtvRmNNSHZYQTJSRFpMNEl6R3ZabW9GNFZLWVdWdTl1czR6eVZOcjM1?=
 =?utf-8?B?WVlLSGtRUERBRmc0YmlQSFlPRjNnR0d1aW1iQU5yd09BalBmckM4QkRTTWxj?=
 =?utf-8?B?MXBLVDN0OVg1cGl4ZG1uK2FwUzhQbUFoSzdhcWpKcjg2dnlPZXBEZmZCcGdy?=
 =?utf-8?B?b2RiMTRoaXNIdjNCN0x6anpRbXEwL2krUVN2KzFSZDhEQ3ZvQ0xBb0FEeEw4?=
 =?utf-8?B?QVZKVVBHY0w5VzhacGFod0dWOXBRSUtrM2NRRk5uQ0xwN2s0ZWFkWWdHNDhj?=
 =?utf-8?B?T3pZU3pEZzF0T2VsRVU0ZFVSWWtKQlNOcUNCaCtVNk9vRWRueDVlTis1OFc5?=
 =?utf-8?B?MjR5YXpRd1BLT0xXdWpIYzBKelZITVMxbjhBdzhpb0xQSmZ6RTI4RFBHM3ly?=
 =?utf-8?B?cU9mZ1JGMTA2VFcyZUZiQUEvMjhSb3pndXYxelZSL3RSV2k1eHVUWnF6cFN5?=
 =?utf-8?B?WU03RUwyRWhNQnJiOFFjU1JkWHJJWEVxM1p5UitSVnZsMDFPR01OUVl6aWRG?=
 =?utf-8?B?dGJoVHBlMnp2TlhHb2szaThEL0xra3ZjZThRbTVYTE9nUWFnZUt2bHB6UHZh?=
 =?utf-8?B?T0FZdS9XRVdmanJiZjV4Uk9JNmpvTG9uMGF4Y1d4eUJRZW5FSFIzdFBSM2R2?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7539ad7-b8cf-42bc-13de-08dc8b964b1d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 10:48:00.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vcf7dB9TN3OB1cLHoXwtYNHKiqN37uN/auhjLmdGuQlz1zdrsDwbwq/I4vM92P+XP9kclZ5QJFjWftKcleXTjQxNdMOTSd6wSt77L1GaSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 May 2024 18:34:09 -0700

> On Tue, 28 May 2024 15:48:35 +0200 Alexander Lobakin wrote:
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 95a59ac78f82..d0cf9a2d82de 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1155,6 +1155,7 @@ sub dump_struct($$) {
>>          $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>>          $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
>>          $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
>> +        $members =~ s/\blibeth_cacheline_group\s*\(([^,]*,)/struct { } $1; STRUCT_GROUP(/gos;
>>          $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
>>  
>>          my $args = qr{([^,)]+)};
> 
> Having per-driver grouping defines is a no-go.

Without it, kdoc warns when I want to describe group fields =\

> Do you need the defines in the first place?

They allow to describe CLs w/o repeating boilerplates like

	cacheline_group_begin(blah) __aligned(blah)
	fields
	cacheline_group_end(blah)

> Are you sure the assert you're adding are not going to explode
> on some weird arch? Honestly, patch 5 feels like a little too

I was adjusting and testing it a lot and CI finally started building
every arch with no issues some time ago, so yes, I'm sure.
64-byte CL on 64-bit arch behaves the same everywhere, so the assertions
for it can be more strict. On other arches, the behaviour is the same as
how Eric asserts netdev cachelines in the core code.

> much for a driver..

We had multiple situations when our team were optimizing the structure
layout and then someone added a new field and messed up the layout
again. So I ended up with strict assertions.
Why is it too much if we have the same stuff for the netdev core?

Thanks,
Olek

