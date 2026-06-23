Return-Path: <netdev+bounces-301306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8A1Dd5MOmph5gcAu9opvQ
	(envelope-from <netdev+bounces-301306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0166B5952
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CWNVpRK0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301306-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCDE3013A51
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768F246778;
	Tue, 23 Jun 2026 09:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C091D5CE0;
	Tue, 23 Jun 2026 09:03:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205390; cv=fail; b=a+kpFURTmqzi9SIFj2XooPZE47CDg1RL3vlJNhigoIQ9djmc7V/vjrAAxHy9e3JUzXE26CBdIOIXnpTUdXw92YznU/Cr37Xz+JtOYgxGCSL1BRuxcz8eP5hx8WpZEIUuafGKF/k9yf0N/FZymuKtcsD/U3Krto9kr+85RCRFHNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205390; c=relaxed/simple;
	bh=Z7Z48YHl0W2jhFHrQXjEYzGuzkqSvunmq281Sb7x8lY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aY0rcHAjqSSC/NrTtZzs3PTAB5IQs+/MKZKmA04aKgcGJ944rimxv/vdLg0x2vUGQf2oHsSxnZ/j1+F6ip8a/Rrtr4nclidb4vhXoxQ44C/h2HJ6qZhhT7pVxxyMnG4wH9GESOpcQnO1zRZ/1vfAnbJ28qsVu/1ZM+GpTpfy4lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWNVpRK0; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782205389; x=1813741389;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z7Z48YHl0W2jhFHrQXjEYzGuzkqSvunmq281Sb7x8lY=;
  b=CWNVpRK0M35Cel9OAefb9S7CxUyEfDuIkFzUO9VLLLc4fEXFJpozvyXZ
   5JQwx8jzATRClE63Vad7PfUflX3VSOXw6YUsM1dbvy6m89LRg+PuIrsQq
   cE1dGlBSpkF++om+fJgPwpQLvGAObCNPMLcU+27BFLb8Cqj9RvSCIYrRA
   NPRs0WrD1GDTMNpbYfXOuqHg/nAr/LWlk6lTT7dRzooCLTMMWjODU/KpK
   mkXS/tUaptJ6lc425Xj3VIZ1rsTzAeoW50+YXrs2LvajDtk/s5HOdbOCo
   zYxgYNc2UhAf8sHqkBxTeF3estOgrqsgBwaC/tiHdBWty0lGX3319taVE
   A==;
X-CSE-ConnectionGUID: Eycf5otvRr66ViEL5Ypjsw==
X-CSE-MsgGUID: ym+0GhjVTO6FqVmP9DkZUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94058975"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94058975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:03:08 -0700
X-CSE-ConnectionGUID: pxlZW7eVSh22Kjd5sPrPKA==
X-CSE-MsgGUID: kxeULv+ITeOhQlGNyLizKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="247118423"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:03:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:03:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 02:03:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxt9EsABTLt99xk6CwC+BDfgwO0V3H095EVbdSEAhXUhsfTigW9sheVDjHqhgpKbCiKjdzQ789HJoPfzc/g3nh+OlikGUQTsTyPKMHNZd8HMrmkMDUc+LRh81oPLHkNrcnumK8vEUYz0hLxdNvrjdKifYxmQPqegWOAOpJBuqBOBTE+XPZz5RzBZipFC53+iunkM3S/BoG88rGfDN/MKTr+JcyUgxH6vHBf2qJWp4loeloQ940YHUWEw3TZbtwJHxB8iggY09wzqccILx27o8ClemkegCtdGx4q4IDX5vcWMKdUteQQ6p4DNi3+BEL0gmUqSraEbqEnnjqlOghPWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj0dsod0JweKsrJMYBgYsyjmneeeZwP4JMGdxgvsI7c=;
 b=EYQb609f9OvwJ9eEL4Y0PYtdA7RbrKHcgOCyARlmeY3THVDjxjWW9gARF/5vDhkyVD1OuBlEVZ3YEbdS6OjTZQYolWeFeyRfy1QuNLf3LqoxQQq5EHfLIjx7COWkl2FGsdUnbSn6x89hnXrh3Hg7oG6rjHXXJz86rEGMpOXsPnpMc0u9TVpiPu5kney8kOwJT8cNhZKkE+9cOlhffgeB6DpeDMtpqjSD60O/RmrLyFid+3WtAxjBaVkp3cc8RLnQLeMgQzX8mH5/HskTe8p0M1nAHr1Uvq4DH+Ks8y+ZJFpB1P/36V9vY7ziotfNEaA4qDn+U3EBy0MsO9iRAp7NTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 09:02:59 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:02:59 +0000
Date: Tue, 23 Jun 2026 11:02:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jason Xing <kerneljasonxing@gmail.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <ajpLuDNCu2PHS78l@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
 <ajJsMj0QMOF5I8qq@boxer>
 <20260622160706.0b4a27bf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622160706.0b4a27bf@kernel.org>
X-ClientProxiedBy: DU7P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::13) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY8PR11MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0f04ab-fc11-4473-1865-08ded1063904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 0JMazcgGrPJe+tSI6dngj4y7ScUSoYudQprq2ubjP6e77lA7k8kfpIH/rObubkVZo5SeYd47GmXVubhLLIE4O6/Djf+yBX1ISUXHakWMZe+5pdsPc0KKmi+OjhUOwZjt5Cj6fU636dPRXq7mVnxtMbnBUVGDJK6AbwyKz599ifREMQcZb7VUCDNzn1hVTmQo5qgw+gFpdR1bqnOkEYQa5k5UXNaePvVZTSDog5E1fDLx5yXwBhSCfOHofGvKX+vpD+AXOXxyILqv2Dylu+CNnKV+dByw+i6/F38bQ2g4edpDr+4eRYtma2mexA6H530QP1S1BoxoTGGgQ3CfS04RnCSmivHoEs+y34pcXlCuy6KENtfP0Yz2NWDIaPVVnH6trbFpzWff4hiQ4VCG5noJu6UVbZJv9jgBno3vPA1NI+jZDDjv4I3FlkNhxsYt83qmW+Saoq9VrHGWLtgRUGkKUftbrC+P2oEBs46mPxXfGt7axqRFWlGefxqM+btZzgVTtFYRAvBlyn4rWf2MKndFfiI56sLUFVQrx7/4gDDCrKD/lrMiQWLrqrXiylXFPW7qU8CZPC5bmaaASCBm9xD9va6nn4NDAC3nApHrG94L8X+YZ/X8QNW5YSiVYmAvhf4CWDgWF5DcxYFI8SlIQC4vSJXfzZHXnErGXAX9hNJTt+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1IxbzdSNWtNQi9BcEVvRUlTZk9USFFwbXFQN3VZdER6TGJISjF0c2syREQy?=
 =?utf-8?B?ZGR0a0JVeDRFdTlwSUg4R1dWYllPZ0ZJMzExekhFakY5RnZwRmhubW53SS9x?=
 =?utf-8?B?bGg2dmM4cG5YMW1sQ2x3UitsSW95cCtXd29QcnN2K21JbldJYlVKTWxaUXhz?=
 =?utf-8?B?UTNFUXlnM1JqREVENElaSXJxU2tHS2JYOW9aeDZqSEtJZXhSbWd0WGl5Tk9C?=
 =?utf-8?B?cnk5U041TVBLT0UvU212OW8yQWJ6b21OZXJsYXg4eldxNWtMS0d1YUFGZE9H?=
 =?utf-8?B?TEs1NFVVSVZtYlVVUnJiL2Jib2RSejhoeXJBc29mL3ptTFR6ZEVwdUNJODRp?=
 =?utf-8?B?R00vbXE0bDVxcjlIK2ltaE5oVkFKdHZITlY2clJwc0JhVkJQL2hCSUNRcnBL?=
 =?utf-8?B?a2wwNTFoTVBuTUhnZHJHS3NwemRBQlFoMUE1ek96S0tsaUlXQkV5NDY4aWh0?=
 =?utf-8?B?L0dNdkdyUWhvTTFHaEN5YzRtNStVUzJOanJCVmxza1cxOThISmF4NGp2Y0tN?=
 =?utf-8?B?Q1dZOFVRQnpqa3dKcUdKTWZVUnQ4dzRhUC9MYzk0WEZiTW44bm0rS3ZZRk5Y?=
 =?utf-8?B?RUxXUXlwOW9FZkpyT0htWjJEWWFsVjc3OG1Xdlk2cGNtbW40TFFWZHBaTTEr?=
 =?utf-8?B?RTQ3QnZ3RW1WTGNaelE5TDIxN2pYNVBRZkJDbytVa2hsRERrRnNFTkNWRnNU?=
 =?utf-8?B?cndBK1QzOHFaRDVna0t1T2M1UDliQUNlMjN6OXA4eDBjWjZxY1B5WWpjOTVi?=
 =?utf-8?B?SmdwNEoyMHFRYVo0bXRsWFROemdPdHh6cEthN3VJOUV1ZlpteGJSR0pkak9p?=
 =?utf-8?B?QUVvdGxqd0pOWUdvaU1TekpzcmVYajlRczNoaWtHQWlLcFFZSm9TelRzazNj?=
 =?utf-8?B?MUVjaWEzUkdyOVBuRXl2TzBTZGF2ZFd6d1kvdjRJYmdzV3RDWTI1T1VMYmhx?=
 =?utf-8?B?cVY3Wjh1TXFqV1BaTjE1ZlVqNStPU0NOTENZa2FFSWtxeGJWdkQ3b2QwRzJP?=
 =?utf-8?B?cU5FYzJyQ2JZdG9RdFpKMVdJZTV6VzZtQWlUbTMzWCtYR2xXczlRanQrUjk5?=
 =?utf-8?B?eWJCRUhxMXJuNGlKZjd2ZUdiRUI1NkpkNTFQY09QcnpNaXExVy9QdnY4T0My?=
 =?utf-8?B?RnJTQlhCeUVHdWpMQWk5aDg5cVcwVSsrUGVkSTBRTXVpK1hHeUpEYmdoY0JK?=
 =?utf-8?B?NEZJQUcvaStDODBKaHpzUnNnOHhPYWg2dThnUGIzSkF6RUdkUFNYcGpTb0dT?=
 =?utf-8?B?NGx4ZFdHRldRUVdpWDQrNHJEaXpyQkR3UVpVb3NmNEV0ZWVYZm1hamV5N0d0?=
 =?utf-8?B?bFI1NlgzUlpIcG5ZSlpEVTM4ZkJnbUllMEtEL1JYd1NyOHIzcytBa1RIOFRK?=
 =?utf-8?B?MkJDaXJROXZHdkdadG1IbkxMaDNTbUxMNnE3OWV1eWdPQURjLzhldSs2QmJw?=
 =?utf-8?B?MXp1RXVpOHBscmRyVW5wQjU3dG9nT1NlU3o0YXpjTnZjZmRUYXNiVUV3aGc1?=
 =?utf-8?B?Tm1rU3dUN0VoaTduRCtUS1ROMWd6dVZWZC9KbTlPc1dIYktjSjZtdWRCb3Zx?=
 =?utf-8?B?dDZIemhDS1dDWWs0cEtYdmJZaGNIWWxOenN4dkZkejByM0JVVVhjck9YUVUx?=
 =?utf-8?B?K09lUVBybnBIYms2MlRHdU05NUxQcytWdnhKYkRDTWdYK2xueVNjMENHN1ho?=
 =?utf-8?B?dFQrOURKZFdQNERLV0xjbWVDTUJtTGF1b2FkT2RGNnVtNU9weHpmUy96YU0x?=
 =?utf-8?B?UTE3aFh0SlZaNVFrMGI0SDRYWWw2Z21pcEhKckRPcWw3VWk2MGIraHdMb3Bh?=
 =?utf-8?B?aTdIYWJOdUdyQ3J2RUtyZ3hPTGVEOFVOcGFqZnNheVc2Ky9qL0lkam0yMkcx?=
 =?utf-8?B?aWo2SVdtWmxOcUlveHFFMjRpdDhMMEU0dTIyVGhFMGtRaEZiL3hvb1hNejJu?=
 =?utf-8?B?eGQ5c0RBSHB2S3lQRzZCYllqa3lacXVQdDgzcUNhU3FralJ4bjFicGJndHlt?=
 =?utf-8?B?Vis5eFdzRk9SaTdOQ0Y1RFVhdlhWYnVCZ0dNWFVaYmg5eFFWeVBSTVF4RGpa?=
 =?utf-8?B?RENpK2FiQXNQM1FMMkpUWE4rcFBqTExqQVF2ZjR5L3IzRTd6S1g4ckZxK0NN?=
 =?utf-8?B?Q21GOHVxbVlqemVydFpsVDAxRWVtZDIzQmNTSWdlc3NmeTJlMDdCeUE5Tm4x?=
 =?utf-8?B?VEVZak4ydlVFM1hSRjZ4bjlSY2Q5VDVjYUtxZmpBckIvMmlVRkcrblk5VmJp?=
 =?utf-8?B?QzZQbjZQSnVXeFZyQms5VDZtc3ZTQllhRUlYR3BBU1N0WUdvd0tCb2haanVh?=
 =?utf-8?B?RmRwVncxVzNtaHVQYUI3VDFpWG5kWjF5RFRsMXZBOWNwNVNXdTZmOEdIUkNM?=
 =?utf-8?Q?FYA15G5Z38J4PgNM=3D?=
X-Exchange-RoutingPolicyChecked: COA55Fv6VlYZw//2GV9D8EWCAQK0b5M2lxd+eUGDr/4Q3NbY+Guh7ymFOV+3uovd/20jGM1d1Nt9214LSrs02IlDq2FWPv1FhfKZR+RbuhER+PaIKTTSeYGQyIYigu9XYcwIoJf86fOjK+pFF5UqAGBm5VFhPNeMoR1amZ5b+zXnKWLbSHgIx7nxoOQyTWPuOQSqyDRS56alc9XQBkwO4FrsDW9Dt0C6Nzup4wFtXll+0cuKy0jYZdUr5TBCMqVrtoSpz0ia4VV9xBQ+y1Kw25X9Ea3EXbInPSOoKCQmQDO+gSsBn2NjwOu4xaJkkXghOYPT9EjCKmGRAWq4tB/viQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f04ab-fc11-4473-1865-08ded1063904
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:02:59.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbDvRUWxHZ08moGRWu13OMCvQwdPPY+evwUK3OhTy9WBSXPhHL5xGcGgtUIyq3NDWlll/TDnEWS/fPDsY3t8qVnpVjS6yNh9i9foR19ubSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301306-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kerneljasonxing@gmail.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,boxer:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org,tencent.com,davemloft.net,redhat.com,kernel.org,iogearbox.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E0166B5952

On Mon, Jun 22, 2026 at 04:07:06PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Jun 2026 11:43:14 +0200 Maciej Fijalkowski wrote:
> > > On Tue, Jun 16, 2026 at 11:50 PM Tushar Vyavahare
> > > <tushar.vyavahare@intel.com> wrote:  
> > > >
> > > > This series improves AF_XDP selftests by making timeout handling
> > > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > > >
> > > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > > dependence on RX UMEM setup state for timeout behavior.
> > > >
> > > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > > before worker startup, removing signal-based termination, and using
> > > > barrier synchronization only for dual-thread runs.
> > > >
> > > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > > configuration does not leak into subsequent cases on shared-netdev
> > > > runs.
> > > >
> > > > Together these changes make timeout handling easier to follow and
> > > > improve selftest stability, especially on real NIC runs.  
> > > 
> > > net-next is closed, but in the meantime I'll review the series ASAP.
> > > 
> > > BTW, another thing about selftests I had in my mind is that are you
> > > planning to work on this [1]?  
> > 
> > This one is on me. I took your changes Jason and aligned ZC batching side
> > to this behavior, followed by xskxceiver adjustment. I am planning to send
> > this today EOD, however let's see how badly internal Sashiko will kick my
> > ass.
> 
> Hi Maciej, do you want these applied? If they help make the tests less
> flaky I think that it's fine to take them during the merge window.

Hi Jakub,

last refactor from Tushar broke BIDIRECTIONAL test case when HW is test
target, but not on veth, so let me test these changes locally and then get
back to you.

BPF CI runs xskxceiver on veth so this has not been caught. Seems my/our
focus should be to enable xskxceiver HW tests on any kind of
environment/infrastructure.

Gonna get back to you by the EOD.
Maciej

