Return-Path: <netdev+bounces-281914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BBlOhPF8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9C487050
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A75317A466
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D9332612;
	Tue, 28 Apr 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhcmG01j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A133D509;
	Tue, 28 Apr 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385707; cv=fail; b=O3ev7QytCUq5FvCXu6aMgHIEgIE9wfgUUWMzZjW+6mxhas0P2jdMJYn0IqL898ntbClY97//Y0sd4LtSMAPdecsJsjpx9rZmApibmZtmDSDFswavGRMbcWWrRwQ8C4TAyaQF+e9kIV+tBHmm+rjsmpyrX4ElUnrnbR3aJ2pUwzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385707; c=relaxed/simple;
	bh=0C/5rHqofw+ihMi0Ry5Z5KO76F9wLumRVUhYre/3XnA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LRjqYkjN1tvQR8jTjv/Lk//zbupKoVYAn2rIVk90qPaxnaYiWqnmg9BIGR5FvFhwcHuPSYsnsCm+/pnpWRmBA1jNyGtvbEORhe1jvJq15wXuTp7CKNY2LUMJh6eHSw/j5KgbOPPtLC7nqdMfj88N0zt1ZavaBNkxeXxcU04x3k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhcmG01j; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777385706; x=1808921706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0C/5rHqofw+ihMi0Ry5Z5KO76F9wLumRVUhYre/3XnA=;
  b=LhcmG01j0Fxr6HroMDrN+8eedU7zUDf0j59v7+YYZhyDRij7fXy2MFwh
   6zxPKZiZ9uscD8tpANOV9kRWa9bMFqjxx/SsgyXBWuQXN/XbE7rxZI+JZ
   bfRHv43vli6EZ+qjs9IGMLAmY1dvqEL6n3m4NfbM2H+5DeIV0rMLYV8rU
   gS/gTXoquvEnTIqBnv1m9IdQrdRksLH9Gw3wwK02jFgIWckmsdaGVgwjd
   kMrUSwVjVFTZAp0CWoWeTBw62dKIxwW/2FQUT4orCqE5P6XsTfenIH8WO
   SF8JbRJ+VXg4D9DD7sY/aKhLYhrZnfclFzHA70F4YAEKOTqUgHzWyruFj
   Q==;
X-CSE-ConnectionGUID: lUF7x16zR4aapzWtFjF/tw==
X-CSE-MsgGUID: PrumjcyhQhSH5NWXi2XQBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82160007"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="82160007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:15:05 -0700
X-CSE-ConnectionGUID: Cl8aQR2IRi6TQSBxzHUfwQ==
X-CSE-MsgGUID: l+7O/NFWQ9KRar9LaLKTew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="235720243"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:15:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:15:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 07:15:03 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1mUxSjVwDNLr3DZbqkjzgLt02FJZgtjoQdp5zYP/VOGycnrZsgs5Siq9OTd1mpe/+n2sBAwCua+QrJBTfv07UIWj1VGJGIGDD3kugT9w/o28gx8tG/TuYRd2nO47/b/D2BpanRpqohxgJeZ9L5zzp/AjYnj7mA6/49W5NbypfwGKkfPSCNImGeBn8757AB4qqZqo/vg4eUSn9t9nL4QcruXrZKYaPqp1PTq04jcWJz0HcuheVd7VJFAJ9QlmkJxsu/VyrQ2zh1qv0su6DxBvMRCSRgzehK2rdmRafsx9RT6IqQLqKInCHQjHYmdTGOhpoRBRu0zJd5Q+L3xRBs7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPgQwl4ffD491C0qYyd9hXukk9GNtokchqG2aBDkCE0=;
 b=nnIRGrBuO8cXxO+oyHahw8BcRQ1pBdijRClORQbPuJgW9cNfrUVXFUSMMxIS4Yb07B2sL/B02Mh9FvqY1kgKw1TH2bYw24Xo8u/oBrrO4IeUd279nFRE1egoBmsgUXKQzLzKnpog/m0kZN+tiGd4A/vTp8n55oqt1G1VD8A4O/fwwV3ccJ6vJ3h/XE0t7KOcO3lHAY6JxonuqZliAy3IVSA10noYt6MIHpa12X9VF7LkPmXL7iZgPvOgCqu/fIojGmgQhJGxBG3Qjn7Jj0ZL7i+zU2ZHZ5p6YfbWM6nfC/VNM2ts4ndoiIJFVZ3Q7Wj6yXMeMxEAdo3LVMAPa07+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB9775.namprd11.prod.outlook.com (2603:10b6:510:397::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 14:15:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db%2]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 14:15:02 +0000
Date: Tue, 28 Apr 2026 16:14:50 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor idpf
 to use libie_pci APIs
Message-ID: <afDA2slh1tx_7jvb@soc-5CG4396X81.clients.intel.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-8-larysa.zaremba@intel.com>
 <IA3PR11MB898658952B56FC5666A64EE2E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB898658952B56FC5666A64EE2E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI6PEPF00000224.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f5) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c7cbc1-a8ca-4102-7890-08dea530894f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: w89ZvUT5HVYRNrxrpLivjLjIPjyNkrIEw/I9KUAUPj+eZYgN2821F9vrlSh/o8pKz/mpYV8MiQGivNSrZquSmL/wZdmGXTWDNp6ugAwTdvCGXSF7pNiDnNSlmD/RiydkZ5bn3lERAxcONmCsGeTzacpqeFy6M3I3NVnaFNZRPcKvBFabFJMJE3Vu8aUPWRqfJ7LATrlL8hNPT0Re5g8+BVfM9FGa4LeOlSCzwq3R6VwA1iCswm9I+F9Xzm21xIjEDPkr5/hzUuYzAkkVtU4dD/rbd+WToyHFd3ii4DiPIS9geIDV2ooFI8Y84mFV+1OPMa5zlHS85Yw+M3A+eAfTVNo8roKOscUXMvfJhYauPtq2Hf1sdBadrSzEkshijUhDroqmBU85NyqnaXM7kt6N5ih4Ifad1gXzw4kxuXSXu6xGVUHXODifD27LO6AUzhxAgISaWiwDPryi358mkIb5W2LPF2tIBGR1kekCLDyJaoSwp3IDyq00LktuAHv7VMp2HXXSn0mB8V5rT+y1rStRrq+1azgsgUX4FTBnOajpH2F11BPI8IsrVVLXW6nGSuXpVAggZfEwVCF88YOqMvq605w02s5re27Mu8gtW76vvnpJV8F0Ud6yRwKfQZIXJgNxXo9ht7XRqAyu/hOsRlAAI6+zG0qeB82PRWUmR6ER7jhehp6KnHEJ3N7bwGVSjyhyZkl5eqHcoUoe4svWSaZmBaPCNgjMcdBAvnfJrboTGCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0F+xdK6XuR2P/QWZnlGUbFXkHYVQIPRY1ng8zS2QSh8dZdBAoAHqFZnmUIoJ?=
 =?us-ascii?Q?gpp4HLLMeaxCGeXQan2os4qT0/gBoMR/GUKaWv+SG20eJn4JHnmQTUm5X/1h?=
 =?us-ascii?Q?exhA5p0u/ut5+ioXPoEIdgdQEbTeQELIYwYYs2xQNMUnO8H6IPnoRC8i80jp?=
 =?us-ascii?Q?vZutWkcLBzJ30iRIHwjcpWh84gjKeNCW5Ykm71IRr8g9QLb4bUaqMJhqPKO1?=
 =?us-ascii?Q?ZoZYS1X4YvGnucJ8XLaCV3Pi5fi3FZ/ihXh59vnP9FN4Z8teRxklcpMyj/2J?=
 =?us-ascii?Q?XJg+S6RzmgO1AwFM94dREmoRjARHu3aMkLNd3fUDygQvhnaGsss51e+hxWbO?=
 =?us-ascii?Q?mTVuecMb4uDMP0hTCa/5Zfwsp1qXGsXFaSLyN4Aoap2y9X/hTyAgALecizJf?=
 =?us-ascii?Q?0FNpjQR3TjeDzAUIB8eX37JCaIB0T2zolFG19DHWbnabE4kVSyYy/c1SMwEL?=
 =?us-ascii?Q?AM3S5a/HIqPzlKEDqdAYyaAw9VHR8OcVLHyD6zYpOJ3HIvtL85Hca5gGyNik?=
 =?us-ascii?Q?uzxCUNOe162X8wLjcsmq+WyMRgRKb/lHfw6jGRmZU9ra9ah05z68B7Yz2GnV?=
 =?us-ascii?Q?5jX8zJJn4f2lmF+tPj/tLgF/V0/VpkjhDwr5YM3YMUfSE9IJ0z9AxpNFIlww?=
 =?us-ascii?Q?ofVMSLddQfHighWExj2NfjWutb8SvhTvxAWIlP8NiMibCc32D7FpHzOjgW3E?=
 =?us-ascii?Q?sDA4eiaRIldfHA2LamZi8uqLinnvPF1/x9MFSpi/+pcX/dH/6j2wnGC79U2Y?=
 =?us-ascii?Q?RJ6LvTLnBBq3EUJ7+hhIa/Zs+fYWGNX08qZ8EBh6o3FweJne+wZ9LSCycS9s?=
 =?us-ascii?Q?o51vbjO1ZML9IZmYRiRdtUgXJsFLB5Q7J/jxiKtJYC6qXeMqDhIXheMwFeIt?=
 =?us-ascii?Q?2wAvbCTsRcIE41CeZul9sNQoCZi5DnxPXdZwrtJSJov9s88316LgSkB65Uo7?=
 =?us-ascii?Q?qjDKU9evnbNJyeVvxy2c/SHjV+GQU4z+oka4hijJHdaIKqR02o8l6y+wNjDO?=
 =?us-ascii?Q?y5l4mL9kSqaOAd/ZLZGeF85t10PAOnSqOXWHI6i/Skw2UOdTz5oY18aO6Jh8?=
 =?us-ascii?Q?QSe1rOXthzsQ5bQwYKE379i1aB2gFGrAUHXth+DeQntFxpeHvHk34dr4tv+u?=
 =?us-ascii?Q?6O4eFJStgOGDE4fyGHawM55nTKcoek7g2l09eKNitgelBmMnNJ8zmT+wnDzW?=
 =?us-ascii?Q?mC1ae3CbTVOjmyqn84g8sk5jWWDmXSlTrDa48LtxFbi2YznLotNhmfTbtGd9?=
 =?us-ascii?Q?TUzcQ07bd/8n1FZSx0n0ysz/le3/KwoJvsYYJWZfvIPxHEhqBOyOSKcXWRDB?=
 =?us-ascii?Q?Qxy0zlGCiggvaOWBgKgPxIuDA2C4lLFa3FlnLayiBOftqWFk6XcwHujNTFWX?=
 =?us-ascii?Q?RCikhFxK89Hchos+nfEtYZwOc5Khzmx/qNLD6P4k4WwPMS2fRtnRzstu4tdq?=
 =?us-ascii?Q?rZwUm82nNC3EVh3IEqxKUPt+EzwtLBWLi3s8MEK6d7s0j/4FtCi5U60s5EtU?=
 =?us-ascii?Q?F/Pw8HQ6J4KDyf30CAecJojSjc2dOSa35hN4IDAIqWcgrSLOJjXejX8HrZuj?=
 =?us-ascii?Q?6+PuttxBQ8juGOw0UvXi0bjOBoTp7dXvqi+DyR9E7UD86E72Q2A7oOb21pDc?=
 =?us-ascii?Q?AA9N97ofoYODt+EMH+MT0PI9N0vFQimj9ZSb0yRfdaWvIFMqVqVLD/qm8jH6?=
 =?us-ascii?Q?WqBnJTbSziFh9cYyFCLxlubqcGt0Jq7Sp4ZRgjMCjeFrVqFzJPmKGC4kwkeC?=
 =?us-ascii?Q?n4MsbRsNEUF3ZXxCiBpWK4c3tpvsILbVfVb3hqYh9nHwJ5PD//03Ef0hx8oi?=
X-MS-Exchange-AntiSpam-MessageData-1: uZC0CDw1BsV8N2huykeUWEiUc/pPLZQhVkE=
X-Exchange-RoutingPolicyChecked: hMzBOLtMIYb+P+nJgChbF28NlGq45dAvmy7Cnvn38Zj9X7GCbbXy5PUzIGdJvoNNAEK1qsaOeVIpi9eoZGJgK6TXmreBQ5scepdnZb9QDpvXLPJY76ZoYgKlxPuWShnDDVI8PBEKvJOJmwfl491AsNquQANUHdnWk156VooikZ9o2ICk3PHY2pfjCR6yd0BkVm0LmU5Y8Lm0Fn1NLrS/gtBpVLPPReUCeKFcdhXNAoAkgDfptZ72U2XznZKPymNNWj91ZPnewm1FXeODcA/H5wBYgoVs1Q3GSqV+ApJiZgYQ4AHKFiJSF73ZdeTL1alqVYyS9+3yD1FnDPP9+pfbfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c7cbc1-a8ca-4102-7890-08dea530894f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:15:01.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ObgZqE3Xd/c9fKEe8qmIRBCTfYRHrlASCpm0c3CpLEDqLkRlOuI+3HoF3eBJlAjMDjcFGf3iV7uiCmydKVjravC0D3SyGfK8fCSGRLteC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9775
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4FC9C487050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281914-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On Tue, Apr 28, 2026 at 10:47:29AM +0200, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: Tuesday, April 28, 2026 10:27 AM
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> > <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> > <samuel.salin@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v7 07/14] idpf: refactor
> > idpf to use libie_pci APIs
> > 
> > From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > 
> > Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> > be deleted for now as it also houses control queues that will be
> > refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> > mmio info from the start in order to not increase the diff later.
> > 
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Tested-by: Samuel Salin <Samuel.salin@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
> >  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
> >  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
> >  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
> >  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
> >  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 ++--
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
> >  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++------
> >  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  57 +++---
> >  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 169 +++++++++--------
> > -
> >  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 +++---
> >  11 files changed, 288 insertions(+), 315 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> > b/drivers/net/ethernet/intel/idpf/Kconfig
> > index adab2154125b..586df3a4afe9 100644
> > --- a/drivers/net/ethernet/intel/idpf/Kconfig
> > +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> > @@ -6,6 +6,7 @@ config IDPF
> >  	depends on PCI_MSI
> >  	depends on PTP_1588_CLOCK_OPTIONAL
> >  	select DIMLIB
> > +	select LIBIE_CP
> >  	select LIBETH_XDP
> >  	help
> >  	  This driver supports Intel(R) Infrastructure Data Path
> > Function diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> > b/drivers/net/ethernet/intel/idpf/idpf.h
> > index 0d08f51be7e3..efdb58990a8b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> > @@ -23,6 +23,7 @@ struct idpf_rss_data;
> > 
> >  #include <linux/intel/iidc_rdma.h>
> >  #include <linux/intel/iidc_rdma_idpf.h>
> > +#include <linux/intel/libie/controlq.h>
> >  #include <linux/intel/virtchnl2.h>
> > 
> >  #include "idpf_txrx.h"
> > @@ -625,6 +626,7 @@ struct idpf_vc_xn_manager;
> >   * @flags: See enum idpf_flags
> >   * @reset_reg: See struct idpf_reset_reg
> >   * @hw: Device access data
> 
> ...
> 
> >  	for (i = 0; i < num_vecs; i++) {
> >  		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
> >  		u16 vec_id = rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC;
> >  		struct idpf_intr_reg *intr = &q_vector->intr_reg;
> > +		struct idpf_vec_regs *reg = &reg_vals[vec_id];
> >  		u32 spacing;
> > 
> > -		intr->dyn_ctl = idpf_get_reg_addr(adapter,
> > -
> > reg_vals[vec_id].dyn_ctl_reg);
> > +		intr->dyn_ctl =	libie_pci_get_mmio_addr(mmio,
> > +							reg->dyn_ctl_reg);
> Stray TAB after =

Seems so.

> 
> >  		intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
> >  		intr->dyn_ctl_intena_msk_m =
> > PF_GLINT_DYN_CTL_INTENA_MSK_M;
> >  		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S; @@
> 
> ...
> 
> > 
> >  	return 0;
> >  }
> > --
> > 2.47.0
> 

