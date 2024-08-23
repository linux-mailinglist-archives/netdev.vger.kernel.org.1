Return-Path: <netdev+bounces-121456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1295D42C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698901F221C4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2018C920;
	Fri, 23 Aug 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKKWGPUu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CF18C330;
	Fri, 23 Aug 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433582; cv=fail; b=RSW/aTwbfi4qkV0iu6n2wQHgJyMdUtMH//8F1+BGW10JOAZxIxxAm6m9Fkm4HVI/yse3T19eT3a8kjIZKQKKNDSjI3DtGpOPPM9R9uTDk6ayt1XO/WZF3894v2OvD0P6KLFxkrvm3ttARwyGzL/YsxEsHGG+cXt1Gh3wk8ivtSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433582; c=relaxed/simple;
	bh=NEHoiM3zNSNwkp84y+CodJBHhxlfHdwfHA3bY7iLCEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPLmGVbTmgmxJ31ALzs576Pckk6rBXpCKniunBibYZd0euxgjuRvvKRafVtioGJxmR9DokX6D6vXmmnXSd30mNE5WK698B2ldDiuhiKuT4cL+fNxr621oATkAYuTUWnny6GbAw7jduIBkBupX8bmST35qB3dsz9IeeXLHr9XL4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKKWGPUu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724433580; x=1755969580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NEHoiM3zNSNwkp84y+CodJBHhxlfHdwfHA3bY7iLCEw=;
  b=AKKWGPUuIo89Uy1XoTzpZ/dl5ocVrgTUTi8BjQpKdhD8pHhLyOMOME+M
   Gpo8G714bJ6vJFaKNXlYXcB9ffQwQgw5fhfABEACAAO8XrHN2d50d53nq
   HdBZuKtbgzCmH7Qwnrj6kxh+gawNNm2B1oCY/g04fzPft7R9GdXs+RDnO
   HIfw04Jz048RnkOWGMAaWWUcM4/G22AjW4ovG2DbnzvnNVr2u87l3uXpk
   bjMUPbd9Kn7Xvx4ouD1QknjDCTMjrpTmBirLrX2Dn86ml2r+zinyvaK9L
   t/YOcGkNuhZCMppnBL+GHhdFlk94MbcvpEy+xJTz93PcmrUhGeerI5z0f
   A==;
X-CSE-ConnectionGUID: SfTuhDtlQYyYOvW+6ST3vw==
X-CSE-MsgGUID: +hG8RSxFSvunA4zpz/QlQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34071218"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34071218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 10:19:40 -0700
X-CSE-ConnectionGUID: GlExvqBsTrOXHO7K5kGJoQ==
X-CSE-MsgGUID: s6iLVAXfQhWBRxdZdlFywQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61708481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 10:19:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 10:19:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 10:19:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 10:19:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 10:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWeEakcCNE99learwQKAa/WptYbHe3qlaE0LHxSY61qOUzdL8707MFr3miu0KHi0/0/DmjwWy8+0qfVxfY7GZcIikYPtD5h7F5s4WNfLbowtWR5UpAHSITJNTjdXmNh252VOnFnBS3/kJr9kcBTJtEIkSUC2NtbvoQmKREbH9jobA0kzLH4EV+0u+TsWFgxwsewtRjEQp0InEozaKnqGtb45j4rnHaZ9rTVb3MbT0chPuo52r5j0so4PsJD5u9HevqZEToOzxvdvU+DWIav0MPSK+YcbaFICp+0Z7CDA5UScnzo5wanMwhJqmWiJ/TAzxxu3kRuteECupNBoJzW4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWmKxrScMetgl1/iNXNefbAJQCJUc/sJTDt6B6EjG/o=;
 b=aGtJX/2iPOac1hGFjWIcS5blGpB3cVydCJP3QyXotVZGgKMQXgu5WvCWjH5YwyoYAvwwQ/FNHs4eVbBmx0OnfnS3m/Y7ihDeBMfMv0ExBXCP/8JyNBAnjezF2MXUmBFObVrSRXAOPnfw5iLyI80vMTQwR96jnjnlPv7/7J6qryT/JN2nFLTS2/qv1fNrYsEo0hsLrqcs6xxrRA0gTvRBUvyi9l7Sfu6U3LLIz5x+0iY/zXWglz/fF3ucMTK9PMs7cYLOIVjCbZisva0yxbE5BOZIGxyaJ75jD+7gbjRL9byr2Kq5TSETTDwmoNStTRHchIhOLwDV6YcOY6bjDqpI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 17:19:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 17:19:35 +0000
Date: Fri, 23 Aug 2024 12:19:28 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Takashi
 Sakamoto" <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux1394-devel@lists.sourceforge.net>, <netdev@vger.kernel.org>, Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Message-ID: <66c8c4a0633e9_a87cd294f6@iweiny-mobl.notmuch>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
 <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
 <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
 <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
 <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cd119a-fbf9-4b8b-a746-08dcc397c29b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H3TEBfvjOSjasmAKilvh/DwbAQq6+5fobECBPVRwDO6QE6TRMNNvniavekEF?=
 =?us-ascii?Q?6yVJyrORu0tJZDVDV8zWcsEssaOLDsP0JVHFWFcM6wFhYVx+mLluSxufp4ae?=
 =?us-ascii?Q?uYZyJuf3JFfFWdHnO0E7Vtpcv0EC5XYbJ6jfnz7RpJWXFaS1SxNwuP8UQ0F4?=
 =?us-ascii?Q?FoPkTqjO3IvLYf2C4AyT9rMOGD18U7KgYXNkAcE6/GHQAAZdGKGI59m3BKOb?=
 =?us-ascii?Q?zI0YTqoAZOiWoIJiz9X/pUoMNcrt6ijmIYTGNF385SX3VXMXH1m9CNEphwrk?=
 =?us-ascii?Q?/WOFV8xYsAH086N6sDyHuBxmfm1VUd+4FQTs9HlWB65LoONwN0sZzViJiyWU?=
 =?us-ascii?Q?vHHkd/cpzCKi0OQW5f6vPz1CL5ty8uMUH2NTz68OAWm/4rHpejqpRlyYSZRV?=
 =?us-ascii?Q?ryvCmapXYYCeULKWFdmglcH7FDv6Iv1blJADhNR1JbOTBMjxFPuSObP5cB97?=
 =?us-ascii?Q?hB2hJQPLYsqYz6BxWQNBjIymS0uoMmko/VXb6zgaTx7CB9CwEF+CKquBf+2A?=
 =?us-ascii?Q?s5Zb+M/ESCLA6217wUoGx+F4fdgJM7qsSjdlthVgOyruS07R7+faqPh3UBTa?=
 =?us-ascii?Q?moZZgYCLmjOLtkyN26+UoCueQbtNxloK8CiOC/4xvdiPpuNK7GrQBdxUFpMy?=
 =?us-ascii?Q?WDdU+TeiMqSYrcqJLnOSWvJETeIBWhnSVp75zAnX4zW8lp8zKLd9rNJ/asjG?=
 =?us-ascii?Q?o119ZGBZa1ReR9oCYp48dYlZlCe7XitzpAZDVb3RUNUuXcKkORjH/tuNiHGB?=
 =?us-ascii?Q?xYfj7VSiKM4pOQeeiXUsXGYSEmdOfth1FWN4lDW2en/FON9FdswGaV2BuYSM?=
 =?us-ascii?Q?ML3+D4cQiiKBMO7Vh43avJxlKx3piw6k+sSaHhyfl8yMO13X99jyTrloDb/c?=
 =?us-ascii?Q?PHCtP9kBv/ehf1dM2QbSoMwEMgoZQgtdYwGxwkifPicVUTmtgwBf9KaC8M/O?=
 =?us-ascii?Q?xO0k87R05/GAAbYhq09onayEMiJ5ND2Af7pRXfYG1oWUtk/dqKWp4teGQhrC?=
 =?us-ascii?Q?+qTfbLP2dERwajcq/oQ5XIy9f0qZCuL6V5INhDNPCmsGLvVnsrmZeKJE4KSq?=
 =?us-ascii?Q?qh84hd2THATYLYjImR/t6wxh/3VqEdZEVnGLB5GRbzFSjE69eWHXqi5+cy0u?=
 =?us-ascii?Q?RuF3PALgyW5sIute+7GZ30V5UN488vD1UYwlyRJXC22WPNZ1PPBogQ1lsV++?=
 =?us-ascii?Q?1fuRekNdx8SXS/rwgM88LwYmUQ4LPduvgNu+Y3nV2gk46b/6YPDhcOaEyU6o?=
 =?us-ascii?Q?brDWnoPUkHc8UEOOZMVbUREkKM/+hVRE1B1x2e6/nKKxC3cDbZMNuZ2cjj5N?=
 =?us-ascii?Q?PtLjUR2Aneg2zpopl5KO3Jd02uslqAHzQrn6VxDtrSoMDtscMpmQnnGklzP7?=
 =?us-ascii?Q?5W2MPaBwGZ6HK29j4vT1qubkLjnZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYa2WbWG3oX43A5Tblhj3Kw0N2UWQUfIZScb7nxI6Io/karEy1XnaUVZq4PI?=
 =?us-ascii?Q?A2Ktpd9w0JhyiNCA041yZxEW+Q/VGEDFAT9Yf3bkCTDkzegoFLZIDbsktzKw?=
 =?us-ascii?Q?dCeyX9F+JTIvug1EjDEAvVna2JOuRPtNsf7uuAX3bkpDwKrKMiUEUyvDJcuT?=
 =?us-ascii?Q?NmAddD7aaM/e0RfT+vpi4/brXKKAR+IE/epqoUCet/7fEcSkrGDzd7CskdtA?=
 =?us-ascii?Q?DxDoe/1j/LTsDgTbQaDVFTR6YqYRbJYuM/LLvtNtm+fpo/ECcI+oxfRVs1JQ?=
 =?us-ascii?Q?Hl94v3EF2ni5JeIe9JH1+6l2ucINjvIt8MA71VAlBUbYv5jXiQjtuXPneiRy?=
 =?us-ascii?Q?iwEgWdCL3mEuZ3yQ5L9R7N8kuBTPTog8sGspVZfJzP0wHxJgaUeO3nTWqNDu?=
 =?us-ascii?Q?tvDCPozg8xtA1AZkAAHIoUYkO8fcdhyEXpfy8my5uDOPV9DeJfHjgb6OFnhb?=
 =?us-ascii?Q?lLgaARW8RSasfnH/OrgWcBnCGtsfupJUg2vaDDr6YBPthRH+jIUj1Xkrsxtz?=
 =?us-ascii?Q?Stg8k54OdaVLDiIdH/xmbqURSNeA3bT1T9Ww+zVy9WXhj+IeVNM1roCfGWbC?=
 =?us-ascii?Q?wFtdUFeO/XKmrRAVDImyAXdQ2LzWmCtigVs/sJgQb3d0YtItcXioh74fDIAz?=
 =?us-ascii?Q?kMcjM8EF2l/OdaYY1EskYLcwcoLoIOZG3y+0nUtbt9Ru+CMTjztLf16fgh//?=
 =?us-ascii?Q?5LFOYchXsAlrnywXdk+oyWXZaHfW4bnMdEqfTKcyRLwei/1y+8Sq+xOSdjXO?=
 =?us-ascii?Q?RAMjVmnmiD9lSyLJGGt72VFJvH3A0xY0ZxtLwawNSFSklf1VdXa1HV3q5cw9?=
 =?us-ascii?Q?iShtg7Eo7kGP6WQ65kn+KCXpUsIbk/HDpBa4Huf9Z1eNpTnwJlt8e01IBEfr?=
 =?us-ascii?Q?OJw/K/9ZOqFc381seU+UfcQMHni/2znvRYFjwzGqECnIR8Hm3AVCGCq49nTc?=
 =?us-ascii?Q?uLFuOO1c4lGPUjW1t1hNIuvY6QIJcPsgp3p2IPrlAn8UTqt1Lt79Kf6YLLbr?=
 =?us-ascii?Q?OMIgA9ekDVimVQzptVShUiyUTaeJUvP66lyh/uq0n5OQzw/UQAzIMZhYfWOq?=
 =?us-ascii?Q?Yk47uefEE81NZDwEk6tx/yetZ0/cxI4/HvJ3zebfz72qcl0J8CsE4dcL2jpd?=
 =?us-ascii?Q?1ZGf6TCnbbcTb4DNrThvAeXSGpuTL5gmtJGAsU/B4i0GalNMFXlxjEyLQTnb?=
 =?us-ascii?Q?8kkpqFhKoLlbJb9HoU+b2nov+vPB66BrHmhhgX0NuHB+tSswDbk55hcxDxm/?=
 =?us-ascii?Q?dYVWVadTxGT540OBXJDmGFWqzaOleRkTM1VTL7fJks8qAnaXRTgn+uVP8whh?=
 =?us-ascii?Q?gJP6nIpRkKu8obcGVjxS6QuhaRG0H8J/kCQhl9MP+ffb2zB7t8URSIrZrw+1?=
 =?us-ascii?Q?ujiQNXhsy9/b6jcQutBFOniwfETsOLGJWSxVB88hWk2EVVcITU+dGa0iYfY0?=
 =?us-ascii?Q?DF1YpyBXQfiVCPRuxGMo7naAIhWD+VBOA8NOh/oD9l666UfQiFJ//nS5vT2Z?=
 =?us-ascii?Q?6T8AvokoIu3F3U/+CD/szGr5lFFpr6GfJVmLydsDoDupTJB7qVCGbvvOV2aQ?=
 =?us-ascii?Q?azZABMhCl9E9i8E2wy6A09CqxB9r+J8jE21ldHLy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cd119a-fbf9-4b8b-a746-08dcc397c29b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:19:35.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xBeNIvZ75biw4Db21k3NS1inXAlRoxSQjIVnwSuGgcrMp5PXHdq2zAkGszMvI+W8m0itDFXLsSv9VDINSSIwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/8/20 22:14, Ira Weiny wrote:
> > Zijun Hu wrote:
> >> On 2024/8/20 20:53, Ira Weiny wrote:
> >>> Zijun Hu wrote:
> >>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>
> >>>> The following API cluster takes the same type parameter list, but do not
> >>>> have consistent parameter check as shown below.
> >>>>
> >>>> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
> >>>> device_for_each_child_reverse(struct device *parent, ...) // same as above
> >>>> device_find_child(struct device *parent, ...)      // check (!parent)
> >>>>
> >>>
> >>> Seems reasonable.
> >>>
> >>> What about device_find_child_by_name()?
> >>>
> >>
> >> Plan to simplify this API implementation by * atomic * API
> >> device_find_child() as following:
> >>
> >> https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
> >> struct device *device_find_child_by_name(struct device *parent,
> >>  					 const char *name)
> >> {
> >> 	return device_find_child(parent, name, device_match_name);
> >> }
> > 
> > Ok.  Thanks.
> > 
> >>
> >>>> Fixed by using consistent check (!parent || !parent->p) for the cluster.
> >>>>
> >>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>> ---
> >>>>  drivers/base/core.c | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>>> index 1688e76cb64b..b1dd8c5590dc 100644
> >>>> --- a/drivers/base/core.c
> >>>> +++ b/drivers/base/core.c
> >>>> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
> >>>>  	struct device *child;
> >>>>  	int error = 0;
> >>>>  
> >>>> -	if (!parent->p)
> >>>> +	if (!parent || !parent->p)
> >>>>  		return 0;
> >>>>  
> >>>>  	klist_iter_init(&parent->p->klist_children, &i);
> >>>> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
> >>>>  	struct device *child;
> >>>>  	int error = 0;
> >>>>  
> >>>> -	if (!parent->p)
> >>>> +	if (!parent || !parent->p)
> >>>>  		return 0;
> >>>>  
> >>>>  	klist_iter_init(&parent->p->klist_children, &i);
> >>>> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
> >>>>  	struct klist_iter i;
> >>>>  	struct device *child;
> >>>>  
> >>>> -	if (!parent)
> >>>> +	if (!parent || !parent->p)
> >>>
> >>> Perhaps this was just a typo which should have been.
> >>>
> >>> 	if (!parent->p)
> >>> ?
> >>>
> >> maybe, but the following device_find_child_by_name() also use (!parent).
> >>
> >>> I think there is an expectation that none of these are called with a NULL
> >>> parent.
> >>>
> >>
> >> this patch aim is to make these atomic APIs have consistent checks as
> >> far as possible, that will make other patches within this series more
> >> acceptable.
> >>
> >> i combine two checks to (!parent || !parent->p) since i did not know
> >> which is better.
> > 
> > I'm not entirely clear either.  But checking the member p makes more sense
> > to me than the parent parameter.  I would expect that iterating the
> > children of a device must be done only when the parent device is not NULL.
> > 
> > parent->p is more subtle.  I'm unclear why the API would need to allow
> > that to run without error.
> > 
> i prefer (!parent || !parent->p) with below reasons:
> 
> 1)
> original API authors have such concern that either (!parent) or
> (!parent->p) maybe happen since they are checked, all their concerns
> can be covered by (!parent || !parent->p).
> 
> 2)
> It is the more robust than either (!parent) or (!parent->p)
> 
> 3)
> it also does not have any negative effect.

It adds code and instructions to all paths calling these functions.

What is the reason to allow?

void foo() {
...
	device_for_each_child(NULL, ...);
...
}

What are we finding the child of in that case?

Ira

> 
> > Ira
> 



