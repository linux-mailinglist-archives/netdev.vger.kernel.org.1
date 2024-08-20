Return-Path: <netdev+bounces-120206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AACC9588C5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CB7B22E4A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC822EE4;
	Tue, 20 Aug 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7tg9rWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74EA2E405;
	Tue, 20 Aug 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163309; cv=fail; b=WY6CG854TQRMcOCHLkllTNXLRhbNRvxG7vCkUPteOuxvGUi1CeVgPNVBblXRhKILYoeAW0++t9VpZwuQ4jVeqLJ0VdUIhPvATCdGxiqY6WVCy3Ajnv7vQQKQnWOdAwybTjldS6XCXHqfv1BxT5RX8YXOn14P1pnx0181xFffvsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163309; c=relaxed/simple;
	bh=OuAmu/GvvfdNfuzMYlUPkr7L0uxNEULRQdO+IqKR18c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gdltkVDAAQ3eVh4k7FjEq4+8wQqJS6xUgVrcrJwfprNnDQ36sieJ5pwjn2SJKOk0woJK7TXiQqQcAK6Oi9UtcmkSrqWUyg+jvwJLUE1tMfkj9jMMBN7yEbHcmCwSQKbgbWfTHkUMxsavxtj4X6B8eDqVsRV2ru/fjcUQBDSSMrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7tg9rWk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724163307; x=1755699307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OuAmu/GvvfdNfuzMYlUPkr7L0uxNEULRQdO+IqKR18c=;
  b=E7tg9rWkTbuts1H5GtDvvfeYn1OqoBjf1is91+onssG8OR2TOMGV6cUD
   xjBjni/GJ5l1W4zVANYZ1P3P55c8NnAka8PAJkF5KPJJDaNOdaW+CsNtu
   WVUWbHmeuCvZo4lNci/BAnSncirkcUOFvEHPmbAPWcyUph/jcY3LdP/BD
   3VeTfINTWl0D6mr9tW0mb7TUlbyuEJwSuIIP+B18xHm+urLqXjIdHThyK
   4dWY9g7/Z4dkjfauIOHZeGgCjQG1bvpG23mwS682/EvhQBofhOhBGcYhz
   o4IVrn+/s+wx1+1MpNTPErD/2V2S6K4zkC1EnNmf88jPWN6KnQZJeVZdO
   w==;
X-CSE-ConnectionGUID: 3OqwhSCWTnu9nc5C+AljCg==
X-CSE-MsgGUID: 3eJcaKCzTHip3KtjDvvNdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39921124"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39921124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 07:15:06 -0700
X-CSE-ConnectionGUID: XD68Z4XSQQqXpR2Bwl6Pfw==
X-CSE-MsgGUID: /ccwdmmtS2euWrx0Fh0Hig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60709163"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 07:15:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 07:15:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 07:15:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 07:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OePsS9DrqsllhlQmO3f20xAzs7CnG/YDaTyNf/Hog7wt7NbEOcjZgtJgAlcgauUGN1poIQp/YyR1BrHqNGd5lw0hQDoIS0QPW4v4bWv4iy131E9S4gyIS5MWqQnEZwWEU6oMFOqAuhGEzQAWXsc58ar37GwXqL1LkOJJIAqUGl7sDLYZUtig5R4dnxfJpEFnWdGNVUSkCQ925Er5aAEPK2mYaJZ0uMSavCxHT9JqmWwoY55tZZeEmlNrqq0N229O6BKUnuezYEQ4LAJ2sdSBm6k0IHHiR/3lgTCiDWpaKvY0480GJVpLK7J+ToxOl5HElPl0xJG26LxlbsP+0Kfp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfbu5XPeoP9WDNuCOufENk6NWcf7B2g6efUeKd4OTY0=;
 b=y5pdiCL4vJkIHIADLz84rvkGO7/rstThp/LeH4Xyf+ARMsXkysbcMfzsktKNKg/3gtyuKPc1oBksHsOVEoSVJs1DK9GJCDSMrtGiGwe11W47EotKXVdztQxybHBqnr6J9PDfSWCh500qzCvohz/qBvrHGbHYgqaFeYYM+6QhuOqJPriYnj/eb9+07h6wTgNgJGTd1HcCL4V8DSNB1Sfx12GHb7yiRQ46/HjWCBAIuIu0R0S0cNjCVf9ZL9TN5dCiKN4qp2C6MalIipbrYMt0Mf2eLMwXEE/65PYeam7e18Yk+A0RT3OLfa+7sQA/jI6wEc3NUTbdtanMnLKifLt8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 14:15:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:15:03 +0000
Date: Tue, 20 Aug 2024 09:14:57 -0500
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
Message-ID: <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
 <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
 <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
X-ClientProxiedBy: MW4PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:303:8d::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 85aff468-86e5-4eb1-8013-08dcc1227bd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HN1j6JPSDgmOt943DPGDm8JewUIABoU8Ci5T6yjxnuX0wDsaV9/bEeIKhNxm?=
 =?us-ascii?Q?7M5I9FV6q1qlf2SxgH53/o1dp/6X24+Uhz42UZuUfNIQX+HbsT24iFI2dfAq?=
 =?us-ascii?Q?3t8Mx7fUIQDo+qcbNsveFDyNav5CxybDgEZLQBCsT22cbjLB9xdoj3lJ2atG?=
 =?us-ascii?Q?CS5UNbM9NcsqgaCjX+gU7WIfuirkuBjdu3bapluUKRmaE323HgbjSoYTB8/s?=
 =?us-ascii?Q?a+Ph90dZn3R9bfzSnsfSA8zVJydrr/yhdYaSXUOj9dqsHhStgjblNuFSTB6K?=
 =?us-ascii?Q?X1VZeQYHLDUiU6MQiNri/uwOVt/FAcUMVr6wKepENTF4rjyyvH9DpZKOh5WS?=
 =?us-ascii?Q?nqF6T6XRainuxs6DBmWE99YQ9Cip0xemGYw8Yxcdc/6uCGxM1KzQbLo1Gd/H?=
 =?us-ascii?Q?HaFxcA3hQRAitaJSpWIGkci2PDekVUROBIwrFx2GEGtDJk+We+JK32sq36wK?=
 =?us-ascii?Q?mH4QlXNPDTwksBOZPw2j3nj9bw5fenic0j0zu+i9qzvBwkJ7HweGjMWJbe0y?=
 =?us-ascii?Q?zE3ZLKpPCilILmAPn3qE3qoQl8wk2566jp8YlPy5kuNceu7vnRgA/JwICsu3?=
 =?us-ascii?Q?bbAVaRcaiYNXlGTunrMfkH63VNAso/hU83k5RHObVv2VkF+MJXnuKuFULosN?=
 =?us-ascii?Q?R74hjySsqtrh4czwnfLs1i7mhZbKId7SQ6O+U5WJqzBg0kZ/bsA+J5owkj/W?=
 =?us-ascii?Q?7Vpn1PxIDs0cnBJqcZ1qMEQOkFMZgzxfHn388HguJr7lU8l66tF961oQbvgO?=
 =?us-ascii?Q?woUCIbIUZPZj0qLi04NTqu9Fy2kgzcMqc20I652oVjS/SmW7usSsG2GkWe92?=
 =?us-ascii?Q?lE7GESgoWL8EtpO5UfLGBamruRmPPF9fnD6EAGxcuVmJF41NjWEp1BpD09Vi?=
 =?us-ascii?Q?av317JFHEjnzrHP8Num3SeSRn27Z7CyGoVPgeGKTIoo8iNxgdrwHYIcM+jnW?=
 =?us-ascii?Q?qcZ1B6IuPFrPWSQ0Xwt0cupGfmE0XCk1u7FEhqavhvkUZ35xIK5D8sXteEz9?=
 =?us-ascii?Q?LF10TzHP0sdvlVlEdXmhr01feHh9yerPxo6P0ND2QumO6Em8I/SnVgEcxzQC?=
 =?us-ascii?Q?Lu3yFJvrtxu6PNNr7ESX3KWICTVemrPrTlXPLIvsrD9FJaUKIBT5cBTQhkjL?=
 =?us-ascii?Q?OoLVTco6Qt2uOCoM3kjwroO4DOIQlp9il7Q9gfCw+qxi2legtlsU04gIn6QT?=
 =?us-ascii?Q?DqXAJNmoQHBjIlE/4EwkHDVC1pvNlMpVzEweKMoaK22nPnhNEFlfNQy/mmIs?=
 =?us-ascii?Q?RRLqcT525JC6EhJz43kGqB19OrgM/vmNwlnu2rDWk406qG4BQXGtJp00B1jr?=
 =?us-ascii?Q?MWxi5JLCDNiVr6Ouj2lBOGzOCpJrvYZeiLzCQgKEftTy/1/ke5t04vZJJ9Ff?=
 =?us-ascii?Q?8WlTA9FeSIslCWRjkh4lFTTy7czQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qqw7BneEFf+UZLJzNL8RB6/ScECTQ3iLFs7gkVrROcAizXaNuuKe7OdsTK5U?=
 =?us-ascii?Q?insxQYLXZGthpzXu4VoOgq/Xki9nkWW4MBzMEwCEV2PeVPHhKcbcM7LSHNfU?=
 =?us-ascii?Q?EhYRzfXhY+W/heeKxfL2z0i2X73UGvzPZlVgEYqZdM0GZHATpO/05Ke8oKgA?=
 =?us-ascii?Q?U303EFh7M15SU9Ax3i1v2hwO0u/v5Q0lzm55HZlDOzeDvORXUmbzl1/jBCn2?=
 =?us-ascii?Q?lfG8Js7QrUcx/yNTIsIrwIsDeBJAFy4aBPSxLkyg8Q+V0EHFGT5rAPoXz0UE?=
 =?us-ascii?Q?uikzwm1iAt1UkErBuW3VFTvCQdRbmoWU4+WkJ/Njuri1XeqND5SVtyLV2nFB?=
 =?us-ascii?Q?1+x7qlPWorgTTpxZ9piP3oqtnt5HnCGvAh+Z/YNfcAAw2ohiqL3WbMUHSRY3?=
 =?us-ascii?Q?hUPy/LKbod+iogi/I91Wt1Iz9Pwnh8Yr+tWpwOTTPh2onk/OQpmSQ2FTpFNU?=
 =?us-ascii?Q?tSvmIhjI03m8KlUMot++LE236qW6O79L8hs725zgQ0+vsEJjZQqengJlfbJ5?=
 =?us-ascii?Q?ltNhC1S7M4NWPw8Vuy4ma3ec8MD5fygeNm0Emg+KZLs3nj7h1U3gOs/ycn5K?=
 =?us-ascii?Q?kj8QpeTTotCNvm+t2FbtSQ2o10BPmCUNf4yM2Rd90w86bJh4FxzjkN1Fj+yR?=
 =?us-ascii?Q?7gh6DxxNXqfDkyjlpICp+HuM/pemAQVSl32a5BS9hRNz5yvrRgMcBPfwxpQC?=
 =?us-ascii?Q?OrRH8MgSdNCTmv8fS9sxAKLDbrV25/7RHBrUn94PmPbkz5dMLRNBkj3WAtMf?=
 =?us-ascii?Q?BdySPkaZFuXELNt3sxGxQoT7cSxjd2TGPfphCi9gAcYIVdxoILlBlH0Iv1q4?=
 =?us-ascii?Q?pVCW2tBTw+0oY/HRD6eGoQPY4gxu22wMaDmZkNqRMRlFbGs6EkcvwoHJVdXV?=
 =?us-ascii?Q?PM1Fl6SQ5IQMFgHIGXDUwoBJcY//+LVg3FuePl3IzewKqAnkXJ3eVRGcBulx?=
 =?us-ascii?Q?VAHg5QVyEvgyyV+MwWbn9KF69WDpCLobY4XnKoD5SOClER5tmbt8gAweZO9V?=
 =?us-ascii?Q?piBOE8GB9drIMUxkDFHsnwxMQP71aCJyR/6oryip37wo12q0v0A0BwJiRGsY?=
 =?us-ascii?Q?LU/A6q2DdrEcJG4eXNWewFofv6PSZwcdiGRosszInYnyklEt7jZJfdt6LbML?=
 =?us-ascii?Q?rfXg3JqB25Cj768QQTcTB5RLgCPJiH8ITglU3NzEA/NgTU1IyFiM3saKgaoj?=
 =?us-ascii?Q?gq4lBMbCn8vHkbmcRCdpDA3V05gfNz8UiWOFHjUIbd9NKz2GJdeS9rFh65op?=
 =?us-ascii?Q?Wv29KEVRtkI7YzMNKATC7ptZWAcVFTPenktzYpkrTgAxEmcq50ZSeo1yzY+6?=
 =?us-ascii?Q?xRUzq026RDOYEShleVtgKH/jw1xEOngyuP5Dv2Zu3uiEtHy01KVgCpVe7yW3?=
 =?us-ascii?Q?UKCkioWZyBbrwdABUgzbUbYxpo4WiYVsGOQ2v/KPJ4CIzZB8KU0dRs7+u3yq?=
 =?us-ascii?Q?R16EqCphMrWcmuqUzQsgmL1pQ0FlU8kMrWbx99l2eiU9skXh7jTb8ESDIfr9?=
 =?us-ascii?Q?D+GD24uEWxEIGIOLB8k/in8E3HIguahnkgY0W5ivFJlTTzKTLeeWJlDdIOpQ?=
 =?us-ascii?Q?1DymNYDYBzElrVaCxuYV0PEHcacM5FOOpmXmU14s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aff468-86e5-4eb1-8013-08dcc1227bd4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:15:03.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyewlwpTTz+hgRqncpu1eV9QZdcYrEqGAkXOXQ+jYh9Vr9YVVl/q6PZjQUC0dvUMoP5yAOdjlDLmmWoHa9dLYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/8/20 20:53, Ira Weiny wrote:
> > Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> The following API cluster takes the same type parameter list, but do not
> >> have consistent parameter check as shown below.
> >>
> >> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
> >> device_for_each_child_reverse(struct device *parent, ...) // same as above
> >> device_find_child(struct device *parent, ...)      // check (!parent)
> >>
> > 
> > Seems reasonable.
> > 
> > What about device_find_child_by_name()?
> > 
> 
> Plan to simplify this API implementation by * atomic * API
> device_find_child() as following:
> 
> https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
> struct device *device_find_child_by_name(struct device *parent,
>  					 const char *name)
> {
> 	return device_find_child(parent, name, device_match_name);
> }

Ok.  Thanks.

> 
> >> Fixed by using consistent check (!parent || !parent->p) for the cluster.
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/base/core.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 1688e76cb64b..b1dd8c5590dc 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
> >>  	struct device *child;
> >>  	int error = 0;
> >>  
> >> -	if (!parent->p)
> >> +	if (!parent || !parent->p)
> >>  		return 0;
> >>  
> >>  	klist_iter_init(&parent->p->klist_children, &i);
> >> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
> >>  	struct device *child;
> >>  	int error = 0;
> >>  
> >> -	if (!parent->p)
> >> +	if (!parent || !parent->p)
> >>  		return 0;
> >>  
> >>  	klist_iter_init(&parent->p->klist_children, &i);
> >> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
> >>  	struct klist_iter i;
> >>  	struct device *child;
> >>  
> >> -	if (!parent)
> >> +	if (!parent || !parent->p)
> > 
> > Perhaps this was just a typo which should have been.
> > 
> > 	if (!parent->p)
> > ?
> > 
> maybe, but the following device_find_child_by_name() also use (!parent).
> 
> > I think there is an expectation that none of these are called with a NULL
> > parent.
> >
> 
> this patch aim is to make these atomic APIs have consistent checks as
> far as possible, that will make other patches within this series more
> acceptable.
> 
> i combine two checks to (!parent || !parent->p) since i did not know
> which is better.

I'm not entirely clear either.  But checking the member p makes more sense
to me than the parent parameter.  I would expect that iterating the
children of a device must be done only when the parent device is not NULL.

parent->p is more subtle.  I'm unclear why the API would need to allow
that to run without error.

Ira

