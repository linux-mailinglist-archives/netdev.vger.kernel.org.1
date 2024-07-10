Return-Path: <netdev+bounces-110681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F092DB4C
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9A21C21384
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96313C3D5;
	Wed, 10 Jul 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga8FnsUn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101913AC0C;
	Wed, 10 Jul 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648571; cv=fail; b=rJSv+LHJSugJAHxs5gP83HB/vatER5P9x/BvvPtk/MJcfFlZkwHXG57n9uJ5bP+Yzql+ND02cRkyqFtOhrkXkHG5Fm/kI5v9DgyjRnB+FhGWY4q3c7m+LFBgYtDFgigfxpFqh2ZHRGOR6/+N3qnXyDiv07CGl/eEF8gAq6Y369w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648571; c=relaxed/simple;
	bh=FegqCg6XsUbSwhn246DuDGCv8bZrMmrzugRKJO31h8c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kD+jS2p4xsuaagLthkfRCB0Rp/HmCLW8yyIKVF7dNx7B8KgKhLTo4meEIcgH6wrji2dI3V5QpfC46iwZ+QVZF6Dgq0T/RcjvfGGNeMSvys5LslgCXKiYxVorcOI9M8I/SXFgb8u4LOu5b/tUV6P3apt2Fq2PlLG5nC2b5CuvPI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga8FnsUn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720648569; x=1752184569;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FegqCg6XsUbSwhn246DuDGCv8bZrMmrzugRKJO31h8c=;
  b=ga8FnsUn7YVMpPo/KDVG1PsExVcep3oZ/u3QIr1eom0fQ8h28QHrA0NC
   uiBFfQqQdhe1SQnFNAPTWU+WEpLbGefCXMslzjh34djq50KA2vvYQ8i1/
   dkIvV0YeYYZrH7Un2lopytQ0hYV64usCcXDE3CYeK2cmy3Z2SPxaniSGu
   SlVKT2cKwOdtWOxbQYeCY2O+ma581+7vF1wW1CIbdYJIYsdCqWaCRM+0c
   7RJQCTclKMhEMXr4k++Qqy5q2wu2pPwZz9QfMkIkqcIOaZG3K7z7ODpBs
   EWk6ifk0KcW6VV7zmAJQtIEzekO+ajsFsJ0u+B3N5FC7LVwWl0sSBHTEz
   w==;
X-CSE-ConnectionGUID: TrMcttgxTzKkzbmbrjP4xw==
X-CSE-MsgGUID: uDceIDDHTUy/q718K+jHIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28604520"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28604520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 14:56:08 -0700
X-CSE-ConnectionGUID: Yoms8bQ9QcydJCbAmAIucA==
X-CSE-MsgGUID: vabkihT6S0eBoa+9W/5BNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48245151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 14:56:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 14:56:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 14:56:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 14:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOPpCrAO49CHLdBczZCHhtabcSrK5HP+WEQ8+QCyxDignWGT2qWvoSMeKCDUZxl7Kh/v9BEAToAsyfhCgwy97U9N0nkTc7Ix48aKa8sNykJ7XZbUdUrWMwVq1YnKzZYp3TJv+EWgO3sYPIXTUZoEXUlReAjguvaLfLZnGpOi9JOm4c+XXgKc2CL8JiKJt6Vco4He/Z1FeTyn+GK0/Vj92VJ+O1X7cQ+cCDd389kadZtvmR7QuEg7jWp6dqGKLF3Kft25c8kYlkZQma4P6CaLtdzckuEGj70GKVrJLMkLK/cdMGbZs4dYC+9P6Lgg3Qp04GIZiHWGWM9vPWi5sirazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/wa4fKIH8vCAT2nyWWLxFDpyPVoES6g64rLsNpTsjk=;
 b=G7sm9aUkJ5WFb8L9S8gPbbpkl+bG7oHi7DZCxXZDLPlCFdDeBx5pa8mS99vZ93OpYvcDJGWnwQO+K4rinLm58GyFieJIqF0jpiGm1aWMq+WmTZmYftyHTttvgz6wwxbYKLmuCf5ET/2KzXFszuIBnLsPR9LOTFcgz+WupsSBPhzEiGV7CMdAY5mrrrx/Y5tfpGuaEw7+toSfZRZqhKaog6OJk4trdPz6utAzauTzezE52YD+b3Mf8o/zT6+kHF8opjrfXK+Mmb2m09DcbWxu23SOhHL0mt8XMWVPgnqGf7NnhnSC/a8xByQWeTxe1q938tPsTkzyejqA70E9L6WO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 21:56:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 21:56:03 +0000
Message-ID: <f1f22f79-1494-45b5-9c89-f18c1b10b19a@intel.com>
Date: Wed, 10 Jul 2024 14:56:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: ethernet: mtk-star-emac: set mac_managed_pm
 when probing
To: Jian Hui Lee <jianhui.lee@canonical.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Florian Fainelli
	<f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20240708065210.4178980-1-jianhui.lee@canonical.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240708065210.4178980-1-jianhui.lee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7788e107-051c-4b99-3e29-08dca12b17ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1VhV0Z2eDdSNE9vSEhsTFpoY3pLOTFsNFNQalBaQU9oOEhWM0kyZ29GQmtM?=
 =?utf-8?B?NXFWdXFGUlI5SGRaWDF1ZENaUUswa3MwL3MzbDd0VTJTcXB2eHNuN0tKLzlx?=
 =?utf-8?B?Z1U5b0tDT3luSmh3UXVDdGdGeGl2YkVPTWgxa2wrSTFIOEtVbHMveTRMelI5?=
 =?utf-8?B?V01aZkRKYkROV2t2RDFaSGF4bnhtNERmb2M1T3RHK0o3TjhQcWUyby92bzlr?=
 =?utf-8?B?SVQzdjhlcWI1QWJqa25UUnZDTHFUN01qVFZGOGlIaU03VG5rNy9qd3pHWlpM?=
 =?utf-8?B?MkhucnBJcXVVWEh6SVFweWpDeXErK3o0QVF3Q1pnUnhmTGFWOE1lb3FkYVVX?=
 =?utf-8?B?R3B3dEVEbEhUWTZGVE5vaUd1a2VrdGd5Y3o4ZXBUZ0lyNmVyZmM0UkxMZWRn?=
 =?utf-8?B?c0hHMU8wbWQ3WWE1dC8vM2tGS25QR293YkNXODRYKy9PUXlZQXZDT09lVjJs?=
 =?utf-8?B?V3lOK1BNZ0g5azI1dGd6ZXNML3NCYWVqaE5hZkRaSEU2djJmeUZ3SHE2UU5Z?=
 =?utf-8?B?VWxqM2cwVXh3TW5uK1VWeUR0SHo3eFBTNFhTZzNnUVRQMGt1NlhkN2x1aFgv?=
 =?utf-8?B?eWhmV0NDZGlJdDd1eFpENm1rcjZZV2F6N3BvNmt6VllqRE9XaTNpV1laUm5r?=
 =?utf-8?B?V0l5cm95TlFmbDRLMEpjb0l6T2ltOFN5V2ZmY0R3OE51SnNsZXVPU3QwSGpK?=
 =?utf-8?B?ZzZFc3lPbXNLbVNGdkNRTlpnTFUvZDEyZUFKSVk5UFZxWUhoT01NY0FpTXVP?=
 =?utf-8?B?UG1zdE9jRnRkZUFQeDJzbkdRc1Zzb2E1WDN1TmxTNDJhN3BIMWdyeERmSUYr?=
 =?utf-8?B?Um5ISWhIT0EvSEFGa1A3NUcwcjhNQmlQQktuTlNlVVc2dGpCNFZqeTVJS0dU?=
 =?utf-8?B?V2M2V1l1MDlnRHdRZnBMaVZTK2Fjd1MvUVpqckYvWFJlSWlnSHNuMldHTE56?=
 =?utf-8?B?Z3ZkblJSNWR1dDYxKzRCYTVxekhodTJDeU9DdkVybmJ5YkpNVHhHR0gxOStq?=
 =?utf-8?B?dmFoLzNKa2RUUDFNQWpodDlYaFczenkxRmcyOXBrS1ZvZWE0TG9VQXd1ZjlM?=
 =?utf-8?B?RFgvaWJsdncvczV3K2hxc1RMSG9WKzBCZ1E3blNKVmJXU2FKc2YrbzI0T3pi?=
 =?utf-8?B?L05oWlJMU2NxRTBMQ0xuQThoZVpEd1dLaXBsV2NzMFY5bjdrZlV6ZW5KbWpl?=
 =?utf-8?B?aTJjd0dCZWtqdjZtbEtDN1ZzdzJzK3ExTkNWeFR3S2ZFQlY2ZlBiUHhHQU5Y?=
 =?utf-8?B?MjNIamtxdVduYlRwNzhUMDBIOHo3cUhlK0RWVU15aWdPNjJ0cm5PWDJ2V0l4?=
 =?utf-8?B?Qm1ZamlCRnZhY3hJN3RzSTg2OEZNa1B6U3lzOTZWekRFZkt2bXc5cHczOFdS?=
 =?utf-8?B?SGpGMk42MGRTUy93ZW8zNjZzSlVJbGJhaE1Ra1NBd2kyM1F3K0lUbk9BbWdr?=
 =?utf-8?B?cjlNeVRLR2VhTzYzMk83b1Z2UEUyWXUraWpqdFkwZzg1OUpNMkcyZVp4ellM?=
 =?utf-8?B?bkRLWmhQeUREODY5UEdsTE9IQUk5Z1BIZnpJQ1ZJLzZrUVVJWWxmSnhiNGlN?=
 =?utf-8?B?K1FEZCsxMmV4K0M0S0JIdkhwZzIxblB1OWNPNzYxZzFwdWtBV0t2UUZCR21X?=
 =?utf-8?B?WHdJaGVzeUk3UStIa1pma003QUFLOUVTZnhhL0tkaXRldXRKY3Y1VU55OHBU?=
 =?utf-8?B?V0ZaekhGVXFXSXJrczFqa2YyVy9sZEdGRk54U3lMNjhFUjJpcUlDUnFSWFFD?=
 =?utf-8?B?dkt1bUtwbGx3bGZIcDFsUzJNZ2NjUDFtV21iQ2dYOEdsM0VsMEdHeEZPdUpP?=
 =?utf-8?B?NG1EdVJtRlc1b3B6c0MzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVp2bDVxSDFkL1ZlN2EwZW0rQXNnR0ZWdmRUN1hrVDlzZTV4L3dRYTd5RXVm?=
 =?utf-8?B?ODBQOHAxUFpwaDkrT0tscTZjK0MwaFE2WmY2NXpiVkNuN1BxcE1hWkM5aFJh?=
 =?utf-8?B?Z1VsTHpnQ016M3BrVGRQazNiV2VJWFNlOE94Nzl4aUh4YlZyUlp4a1pjQVcx?=
 =?utf-8?B?WlhXdzJxRTZwdWU4V1VNN3BGRmtSSnZ6d0pzVDl2NHRHTEdDRTcva1c5ZVpi?=
 =?utf-8?B?QW9MMDFxQVlicmswcXJMdmVwMjNad2xlQVAvUE43dEFhOGFsaGdXb3pLN28r?=
 =?utf-8?B?M2ZiYklFcTJsZGNhTzhNTGpRSURUSDBabFBWb0lwSVZYM3pFRDFkYjFSTWFT?=
 =?utf-8?B?dmQwNG9yUXRzaW1FZlBMNDhEakhLWGpPK29ud0pSdFg0MGtnbUhJZTV5NC9Y?=
 =?utf-8?B?TllsUnZhRm9ySkduYTFPMlNjL25SMzFlVmExWjFrODIzY3ljS0Zna1lXakJ2?=
 =?utf-8?B?UDlHMTl5WmthTytvWFVycncxZkhLU0lMb21sRXczd3ExUnpuOHBDWWdzZVVq?=
 =?utf-8?B?Q05ieWpieTQ4dHM5ZEdnYzFxY1BjV1o5Z2RGOVBLZ0czZzk3UW5wb0JrTHJ3?=
 =?utf-8?B?ODFyNjRGTElyOEtmTDlyOTcvWFpwZklQbURNNmlvdDgwUlM4dXMvM0tqNHk1?=
 =?utf-8?B?bDlUVVNWYmMwd001VEMvSmF2cGQwRUQ2UTdPbmJ2QTBkMU5jYnpsOFQ0K2J6?=
 =?utf-8?B?SXBMTVd5dkJBM01SRW5RT01mZjdqdjVMVnZNbHpBSGtDODljMzJUbDFMRk9y?=
 =?utf-8?B?MWRZdVhzS3JvYnlKUW9QL3JSZzFLeGZWVGk3QXEyQXE0T01qTkFCanFzOHow?=
 =?utf-8?B?eGdEdm15em9EL2FtRGFFMWZSY0FVbHIwVFVnMFFSUXcwaXRGb2dSVC9lc1Ji?=
 =?utf-8?B?OW52V2l4UFUwbC9ZcEtLZkFrYldiMy9QZ1JkRmlUb2hTcEFLVWZqb3U0bmx3?=
 =?utf-8?B?WUEzNGtkOUFycTdrNmkwVGpZVE0veDRsK1NqZTJNeCtweWRnOHBpcDRZNVZB?=
 =?utf-8?B?ejVHTjh6N3dMWEZhN2NXbVNvbVp4NjBtV1RHQkc2cHlNV1lPWlNJRnIyaXlO?=
 =?utf-8?B?VUJTM1YwTnl2bmlIVG5zZG5Ddi9xbS9FZTZWMENUc0VCNGtUSUMwYUZTWkdy?=
 =?utf-8?B?cFlMaWJ6TldPUzNtd3QyekNxRXlDazhPZ2pNRHFoMUhhNTZRNk5ERTZnVHlh?=
 =?utf-8?B?VHEvcmp5V2xEMk5KNHN5a29pRTBjai9iTm40SGtZU0hOVUIyY2RuenY5VE8y?=
 =?utf-8?B?Tzc4M0FzTDVQSXY3RFhaSVBkUkFwQ1ZzMVZQdzBzWnRkMDBDOFdMR3VEVTBC?=
 =?utf-8?B?M3AycEVGSlJGd21YZ01wd1R6TllaVWpoK1pscjBUMXgrWi9QZitDdEtQL2ov?=
 =?utf-8?B?QVc1M3hxSUJ0UzdVWkZpSjEwYlZ6VGp5SmFsUzFQR0Y4RzVlVnJuRWFrQkhi?=
 =?utf-8?B?NkxjWkg5aHFoL0hWMmE2Y3dXNys3eHMxMklVWmZPTkg5QWNCVUtQeFZvT1hM?=
 =?utf-8?B?a0FCM2Q2MWJmSjVyOEZLdkZ3LzN0a1JGUGFyQWk3WWl2TTA4eFdsbUhDSDY3?=
 =?utf-8?B?bUhtVVVNKzUwdGxwV01UekExd3ZiQmNISHYvODRkQzZvSDJTV2FKcXdIRUJ6?=
 =?utf-8?B?bkNaV0p6TlR0NCthbm9heWdtMU9wRkJXdkc1c3ZoWlZUOUJPdG5GY1RhSUNt?=
 =?utf-8?B?RjVqV1k5SGdzLzhHSU8yVE9ad2RIc1lEOWVmZU9JcG9HVFU1R3lOZUE3bkRI?=
 =?utf-8?B?QzA3aWJtcWZrK0tIeEowWnJHZjUwWS9ieWhiTHhkMUlyZFQwMU45SFdPeWdx?=
 =?utf-8?B?a21QYVpzakNVUmF2NFVBTy83am5BNUNVRUY4VzB6ZFlHU0xIdnp2SlBZY0FM?=
 =?utf-8?B?cy8wNnk2TFBLTW1aNjlYcXQweXkzeXJWR0d3MUJZZ0d4MUhuMmcvUytwZ0Zn?=
 =?utf-8?B?YjNBUUQzYVNaV1FZMGhRdE9nWncveVRRNk4yWXRSYmVoUENrYzl4Ni9qclZJ?=
 =?utf-8?B?SUg3dXlQeHlyaW5MMjY3QWp1ZU5ndVV6OW9SeEUyOCtQTVdoNjFodXJFaVpi?=
 =?utf-8?B?WmprVWlZWEd0R0NFcm1mNWRnbHNXY2Y0OElHZWV3R2NmenZ3WkR1WDFjSzZa?=
 =?utf-8?B?RDlTcEtINVNQUUtNR3BHZUxNRUl5NkVOZXFCYmVYdHVYK3BTK1d1SjI2N0Z6?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7788e107-051c-4b99-3e29-08dca12b17ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 21:56:03.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxVnk1igQW86Xz5STD+o49EpZr2YKCzWhVD7iNnpX335f880/uld1+J/h25zMFF1hlKX0PxoR7Y6Dmq4xldJ0XwWt3/1q5BVNEC7K96J+Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
X-OriginatorOrg: intel.com



On 7/7/2024 11:52 PM, Jian Hui Lee wrote:
> The below commit introduced a warning message when phy state is not in
> the states: PHY_HALTED, PHY_READY, and PHY_UP.
> commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
> 
> mtk-star-emac doesn't need mdiobus suspend/resume. To fix the warning
> message during resume, indicate the phy resume/suspend is managed by the
> mac when probing.
> 
> Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
> Signed-off-by: Jian Hui Lee <jianhui.lee@canonical.com>
> ---
> v2: apply reverse x-mas tree order declaration
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> v1: https://lore.kernel.org/netdev/20240703061840.3137496-1-jianhui.lee@canonical.com/
> 
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index 31aebeb2e285..25989c79c92e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -1524,6 +1524,7 @@ static int mtk_star_probe(struct platform_device *pdev)
>  {
>  	struct device_node *of_node;
>  	struct mtk_star_priv *priv;
> +	struct phy_device *phydev;
>  	struct net_device *ndev;
>  	struct device *dev;
>  	void __iomem *base;
> @@ -1649,6 +1650,12 @@ static int mtk_star_probe(struct platform_device *pdev)
>  	netif_napi_add(ndev, &priv->rx_napi, mtk_star_rx_poll);
>  	netif_napi_add_tx(ndev, &priv->tx_napi, mtk_star_tx_poll);
>  
> +	phydev = of_phy_find_device(priv->phy_node);
> +	if (phydev) {
> +		phydev->mac_managed_pm = true;
> +		put_device(&phydev->mdio.dev);
> +	}
> +
>  	return devm_register_netdev(dev, ndev);
>  }
>  

