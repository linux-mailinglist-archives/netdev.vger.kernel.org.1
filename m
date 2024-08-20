Return-Path: <netdev+bounces-120159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFB958766
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A3282AC8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC219004D;
	Tue, 20 Aug 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU9KW+80"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6518FDC4;
	Tue, 20 Aug 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158417; cv=fail; b=LQVzjBIlW6JXk0kB3fShyXalhKf2byq3q63pMSE+zgP//boJFv4qICDvnNfpd0YDqljm3frPMs/KW8+EY8Nka8xHxp7FhPhmxq2RsXVlZQ0lak1ex7U2jUSCxInuu2JGLbaGpE43QveAv7GkhuOjHtq/4oWd5g4amBFTO5tcJ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158417; c=relaxed/simple;
	bh=iYA1rAn1egZCYBNSD/wXt3KEL8Ezj6EgsY2ZBscqgr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rpmp4+Y5jFu5twBK3VlVeRRWzoEsl0dVH1tHppTsUg8RlLL3f2CX7+ofMaZTu07yedudElo/ySv1l1ejCwN4y8vUYbxS+0zA71f+P7Ak///5ysb0CWMyqY5Bz6Ltus/dF0oyFPovj6Idw4nfsIhgxi5C7O/a2fALXB1y9g9idFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU9KW+80; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724158416; x=1755694416;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iYA1rAn1egZCYBNSD/wXt3KEL8Ezj6EgsY2ZBscqgr8=;
  b=AU9KW+80EM3nQk9S1OxlYGQdSIExtVTWWN9upgcysDchbGTcj2Vo6VaH
   uK488oAE7sl3bxjRHFk6uuxE7s4bYr170f4al6umWHZyiC9s2WRgCrya/
   BraXsDN2SKUNNfDBJaIQAI/RDmTEyk6EApUyvZlTOjjPbsFlNeEPYdrdG
   AARIH5rwdE/r6g4G944xGXb9tyMI0RyGgEr01yraKvQv1myqqgTqlx/IG
   MxXfDoQSIU0fkUNlho/ALp/Ru1GW6Xryx5J8fGsEQA+b4k8kogQ7wawj6
   JOvqpV/gRC1lhz2DxvTQ7M7s+b/qf0OeQAvmUqLVi3FSYPNjX6vN6ZUwN
   w==;
X-CSE-ConnectionGUID: /LkUJho/T6i8W8ezy7LUpQ==
X-CSE-MsgGUID: FQ4JOsnrSmyP5XMgKV3VmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13113056"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="13113056"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 05:53:35 -0700
X-CSE-ConnectionGUID: pU/mPkwST+maiLochQHndQ==
X-CSE-MsgGUID: R/7kI9zoQBq5XyVNqZBNWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="83921177"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 05:53:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:53:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 05:53:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 05:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcEl+plqL6x+0fwJq136JqmoTv53NYdVswAd2/NPFYhGlrkP/g00F/hsdTHz+SdkjLO0rFKuB7IM+XelsvTJpdWnISkJmmhPH/GqIfy6dko2km7rvsjCmYfUOhYA8V2XpMM2uLhmiIV4qqlguMhyw7P3SlCLmAJCGU1/qd2ak0IIfw7fdH8EuW/Hfxq3AOcdfW9qdSCdezn29GiFgJm0p49Cx8Xh7tQxTZU7NTbFWN2AIENf+tYEni9TcNCo9qitO1OJKiI4KQEY9t4aLwo9G0ke4ZJonDnKZtFat9k9KbwWf7jfxXUkouXyRwbtszxaCfgzSyNLRH6WGlj6AR+Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrW1kN7VLvok6METn9gbwHGSjHmYLvJxTUYPooNJxE8=;
 b=V5za+M1H0ALM6qAg50lm87UZsTkAmLFcpTftk1w428XpQK1jNVKewTNnyN5QRJDHYRR1t9HVOgBnus0oKjP4siuGv7+cryuenHYIc9rEzs5MSHNY8yDmH+r9W/v5KuwUGYQXge2khe9ao6RyHO2ji3dRyUmYAPjfnEW44ylwhugcUB5V9W3ccHZtYENXuTsCD1/RzxoiKiuIBcWBegnVItOxNgcMooR/5UhQqZ5G3Rsf+lfvQvoDkoXJXVrrXHNrufE2h8wLmIBf2fQDd6iLz+1WQV1zIcp1MmGtRnObpC53px485NJuh6SjYAhFxzb+S9omiPQa8JeyWmuGtbINeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Tue, 20 Aug
 2024 12:53:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 12:53:30 +0000
Date: Tue, 20 Aug 2024 07:53:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	"Timur Tabi" <timur@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Message-ID: <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0ac447-121e-419b-d4ed-08dcc117172a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WlvsjVH4zvoogAvaAFHEPhpUfL/yfp7QgJBRHFk63eaLQ+o7uG1gGHcaCftZ?=
 =?us-ascii?Q?4Q4LcT9zS2Gkcb5M5hM+UQQOmsHH46s47rgmzrG/VfxU8ZC/bUvVLC33DJUh?=
 =?us-ascii?Q?193AE0fLUANzuI1QbVdvvT5P+z2rkmCZAmgjE4PsxgpwXv2MXshQgGjbmq81?=
 =?us-ascii?Q?v430tbPLr6wJ+XnzkmintDLx95gxUYKrawt262um2REWVY43EuB9ftpOJq6c?=
 =?us-ascii?Q?BAxI/bQb5aeeY3aoAJDVNROWQeUtiYtF+nQdKL93gxxKoe77WfYKNxZxVtTZ?=
 =?us-ascii?Q?KNqZp5RWtwiMPGUzfl6aFB3p9KPHeO67DapUiyWSfPujyrOKIxJ6SWWcL9EC?=
 =?us-ascii?Q?5F9mPsAu9XHWX97jGA2K23QeeZfPV/gzWKyBcXn/WRHnG01gWHOZDk5cqPe+?=
 =?us-ascii?Q?5FReKo99PkXI4RM7wiUB7r1BHiJWQRiL2ERLgBEn+92xAvZG8Mw97p8WU/gQ?=
 =?us-ascii?Q?msSNLRiSRpmSIg0JhcTm97ZHFK5nrkIND57J+25jp22TwZ6fDW0EuXs567kb?=
 =?us-ascii?Q?7OoCtQw/CyTWs/WvcC38mvaVcwPhU3xtabtHxBRvQ6foeSjii2i6Y2PMV0Jh?=
 =?us-ascii?Q?yAPlgZfsFp3YtjITtNLW8tirisPU4hHGcXjbFtgdhSJDPXHfXYF92thjbFHB?=
 =?us-ascii?Q?ivpQNUgHTDzrw24Sikp+8HNxmCj2pFzHNds8IqGNuOpmNxugUKK7zafYNfBO?=
 =?us-ascii?Q?8tUuEzewvMK5grgPDdH+0GVA1XKsPHqMQ53a1pasAnReOXBI6t4es5+aM4Vl?=
 =?us-ascii?Q?heAQtpvDjareOoE2s1OZG3YveS/1bTEE4tWxfoFsHQsPXqKljoY5NXCOm8Px?=
 =?us-ascii?Q?DC0tb1Fxv2mxukvodLpi++oyw5nNUSNz4daCHvS0xNhxAzwj+GAg+edtbmkA?=
 =?us-ascii?Q?WNS4xJ9SfZuUV3wCL3aQmIclUTeBw/2dU5iBTrlGMMbbnLy+DwUW17YJuppt?=
 =?us-ascii?Q?kLhDfP2ILH4RCMwI7AQqwG6chw+Vw8YLwEJsauPhIqc4/h8gn4+xCRno/IQI?=
 =?us-ascii?Q?ifTRDVY2xqccNTmnXqaXfmfL986gy5YEHaETI9LgTsZEMdK+zRT7ZcmtSCtV?=
 =?us-ascii?Q?2BpURptrGjBqghaB4mx9bOtuNOdJpf4WwhjfBSBanUb5mS43dLg1q0lMhiyF?=
 =?us-ascii?Q?o/cpkw7ElRhqHLGm7CjzECxfXJsdzK8ZzTxEyswgVo6AypRR0lvKNpPdwoBg?=
 =?us-ascii?Q?IUOcyAXMYBo0ZPeewHmRJoAPorAKV/9eq6OYlheTp+6l7yOg2q57o/dR0RVO?=
 =?us-ascii?Q?PfwwPIi8lweWVgGcVinipJZ6JSFIf0A/wwSMWMLPGM3eIiP2PcSZ/FT7iFza?=
 =?us-ascii?Q?O+8kwCF9ddEVkYKa/ZrD2oze2m0tgzfGhNLdMAOjG3w/Yla0NNBrXioeSju6?=
 =?us-ascii?Q?9I5dxTAFqHF5/6FEwZ/Y3ZO/MI3M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQdGcG6KnCTVriAdR14cqot15Vl+5830kYiVNtbppt6pKwhWqsQWOQAb/sPc?=
 =?us-ascii?Q?hShITCTIwR/rkqKtMSbZQ8uX8q37Y8BAvxDCVlKAkChSlVgNoHVwOf98JfCt?=
 =?us-ascii?Q?o6KAtgV2P4oz+GZeTsVWj1gLiVoZSyx/0DOvWFcBfMjlYGDwnBXMpsm6Tg32?=
 =?us-ascii?Q?/B4o80Cb3IOtQb+pajPn3Z8dXALKMs9U5wwI2b1eiw5xY0Bfpr5G8dNeXhNo?=
 =?us-ascii?Q?MR9SAI21aLvo3+C4X/f8+UUAB2+/RAaAuU5e2vTl6CzNIhMhGBYqNJT6ATei?=
 =?us-ascii?Q?WmNdVzLNLf2d3OFuXC5jKn/AhzHC+LdDicfaYDIm65TATuqZDb9MTJfbrWaR?=
 =?us-ascii?Q?UkK0k3+eVe5M82osn5vScZzrqiNaDe3t+O0YOiL49kI5vEDKH6S8MpikLvTH?=
 =?us-ascii?Q?6XYV2dOyhjwH2+ymA4CAApaRI/YG5A/aj2IEs06qhNlXOhTLS9syCvlfSmRi?=
 =?us-ascii?Q?T0gl/AEjxIYOeV6xo+Wu0nMIQ8zFN2JB3o8+Zf/SgRUxl66y2REZDUBjRJSp?=
 =?us-ascii?Q?Wwvqc/wMSg9EgxlOYDztU4YRzKC6069PCOCWcpNm92l7fD8TKhgdfqvVCHyL?=
 =?us-ascii?Q?4bfB9s2CTgA+wWSqbYxGourmT0KYG8FT1vQEeYEi/+gBoEKFTM3cxaPdNnpJ?=
 =?us-ascii?Q?UcBa/gixyBcoofhz4xhb+NdlGJDVaaJ1arWaSdj+Ho9zEmn5dy+7qRBNxf6b?=
 =?us-ascii?Q?2tQP2hKC87OROjZ6HUyb6RmGY2GtObqHQxg4xzTFt7d18g3++EGNlOBdDHId?=
 =?us-ascii?Q?DjfR0XuX8NT+9UwHZX7L9q2hdSv1jUMy/yI/SZ4rywiA5gEbE7jqVcNKjYt+?=
 =?us-ascii?Q?x5bBiUInBB3eNT5aLEwi1JLMGlDatvJC+8fXVhjrQ5qISVYnQhGVLc6VUb1N?=
 =?us-ascii?Q?A2nSasF5PymASrvCiozTIPVpR5+bMER7LyzJ5jxv5uWCT/dWgz70chhH2c3w?=
 =?us-ascii?Q?VdeM7e9dVwJ0oOZzFg1uGdjrADNLY1hCR19KcgcfPxyxIP92e2+KNgHO/29X?=
 =?us-ascii?Q?XxRnG4p+QM6kQsvC5fyX0ysM3znTgkqQpA4i73PVCm4U5lpmJrFOrhMrzVSK?=
 =?us-ascii?Q?Fenl1QrNBP80UUrQtnDn6QErrRetp2nooP8uoGJJxAKmgaXU4kpGgFpWwaIZ?=
 =?us-ascii?Q?jyV7vdzK1wWKEo5zqgfCabO3dcK0p7PJI8QWSd5fXKyrLqZPnZ3NdcQViYMC?=
 =?us-ascii?Q?SS6oLo0F8pIf/O2piWkVmRjMJbKLJkWb3FXHRa+wa7vd1MgpI1RMgxBopKsJ?=
 =?us-ascii?Q?kOV7uMBQ+yaz9PJUk7CJgX/VmWDRx1ve0hZQ6NyCLSM2TkaVq5FR2FjRaxHr?=
 =?us-ascii?Q?sMWshzYAy/ErSbdXxMWnYugmAFZ3u85tVxESgH1cxDH3zwR4ZqvbvKlYSYVL?=
 =?us-ascii?Q?7NKejE/p16bHYy2y+1qW6ZrzVqMgQbG99zAEueCaHHJOqAK8ZlECokn88T0k?=
 =?us-ascii?Q?3f75eNZ0QEVZYh3sADjujKaxh0X8+dPxXnJ7HxumOmljA7rwM7NX+HnX/nCK?=
 =?us-ascii?Q?tS37Hi/D2a5r10nA5nLeElh6jaoZsw18SZcDuIGkJnA8pNXuA0oL7mNQ06Y9?=
 =?us-ascii?Q?NsVCQLSVH9UFSETvoXhllRaWlVoTL9EFPekcKBYx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0ac447-121e-419b-d4ed-08dcc117172a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:53:29.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj9a3w932nzsbpq5lkrb1jvBZTULdLxAqEiWXtzbTcns8OkBwvXh/AhzjboCHsqnqcdJKSiTGoalAgfLqQef/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> The following API cluster takes the same type parameter list, but do not
> have consistent parameter check as shown below.
> 
> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
> device_for_each_child_reverse(struct device *parent, ...) // same as above
> device_find_child(struct device *parent, ...)      // check (!parent)
> 

Seems reasonable.

What about device_find_child_by_name()?

> Fixed by using consistent check (!parent || !parent->p) for the cluster.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1688e76cb64b..b1dd8c5590dc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
>  	struct device *child;
>  	int error = 0;
>  
> -	if (!parent->p)
> +	if (!parent || !parent->p)
>  		return 0;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>  	struct device *child;
>  	int error = 0;
>  
> -	if (!parent->p)
> +	if (!parent || !parent->p)
>  		return 0;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
>  	struct klist_iter i;
>  	struct device *child;
>  
> -	if (!parent)
> +	if (!parent || !parent->p)

Perhaps this was just a typo which should have been.

	if (!parent->p)
?

I think there is an expectation that none of these are called with a NULL
parent.

Ira

>  		return NULL;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> 
> -- 
> 2.34.1
> 



