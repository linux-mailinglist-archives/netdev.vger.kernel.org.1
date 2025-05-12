Return-Path: <netdev+bounces-189760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB9AB38C3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45661B60B7A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF39294A0C;
	Mon, 12 May 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuPwUdVF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5128E61F;
	Mon, 12 May 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056176; cv=fail; b=bpAIBuWmD/Y6FNj4YTzCqPVv8VuGYhNi2qAwf9urcbSe1nljBFupmSOZid6QuUly7iL21roQxPe6gyMYrgaS4Z3nzj15LA/GaGVWyQUiaixmo5ytIYFtynxMENFWz5Pj8q6uObpbQhpcw6Q4O5Qutk+h99ZkQ7yHtCnzQZ0jVJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056176; c=relaxed/simple;
	bh=c5tMMG/67+49haFFi2g3okC7Sud1/nKnVqir2aPoWQ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WDIOlY8S2DbFS3rifljs7yHU4i2EDYCn26kWaPseCZQLCJc1KMcA/gVIZYrJEl7MHZnjdkjC0cu/PgxWkX7SVCmERrOKd011FGs4Y696CLffZK7zH57j0afoaGZCsXwjN/yBfwqb3JQu8BcpI2PDSEoOPEhciVNgL6+qVU2tIGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuPwUdVF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747056174; x=1778592174;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c5tMMG/67+49haFFi2g3okC7Sud1/nKnVqir2aPoWQ0=;
  b=YuPwUdVFib4ScxK8m9rB1jZRCNGHP2UGtvxzal9joBo8CS8GkvohtAhb
   sIBNExkAxT0iZs1tbowPWNMgdAvnxS61J4dd0ZOc3uwZl9MmdE7K5HZzA
   DixlQkifqVdZftjTcJG96nRKUqSSCPRAhBVXHMnu4vzNGc+1w+wwDXHEh
   +RWYhcqnOG+uwmiRhnmX7RO7FDh5Ye6uvyUrDDovCLsAGXni1Jl08D5Dw
   ndkNl+Js4n1QzYTk6/dKq1XV4W7IawYmUI/WsbHkbzhUQbc+DbD0cfk0N
   MD4tNPoPHsExzOppdjUsuqlIWtgtc2LSYtmZ/5uHu9lbxwTVi/Vso0qeb
   Q==;
X-CSE-ConnectionGUID: zEVkYciQTcCcu9Rm9OL8cQ==
X-CSE-MsgGUID: +eVCUN92R6CbxL42W93HcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="71363796"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="71363796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:22:52 -0700
X-CSE-ConnectionGUID: 7d2PxyiJSQaVGmhBITJ27A==
X-CSE-MsgGUID: cVeKd9M3TQ6XvyUGjbyy1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137834945"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:22:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 06:22:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 06:22:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 06:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuwzlvNOGgOMU3Qmo2JNsMUkcB6lyY7yacuR078WXeP8fAM3D6EHGRclP0bD3TUnSsKVf78qqPum0neW+OkDg9XdTIGA/WIw2D7t+oitG0l2E8G6h7vjMmZSWH9cgXW8pQdNl9Pavj4gYWmA90YqBeV6kFbDfGZAIZkReeq02f5Iv5F7DuWQBmpF596R3znZaj5aY1EaJEUx9xIsUEd+MaHcAn3BO7TBLhSPOvYXrckA9leRpFmaEz8oSWX8A+aJBhmCST+W+MBrt21HuoKKlZ4Zxl8P5a+1It3gjXhvomDg5U55HsCQek5Ax7BuZC5K4V0BGBUnx7N8KbbWKLJ+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulAs7s2Hq8GIKCICRUSDIeeUQDLzBQHlzJKh8FR2yr8=;
 b=K3S+Fxwd3JB9Log6acuePWHECNfvjhDo0DtmR4m/HNXbQwxxufgw+PLbDpg39VcWfmUoQQSoUhtyy1sFMFtKAYtwHTqL7qEhMJsv54IOmGaWZ/Adg+tjKy1puCrfqvpo7LUFW3ue12NUAFWnBxW/f7lxVjr4xs1Ne7Wn7Q34an31N0fPb+xybhP51Gv5w3ibLupSO2c3YlWriWPmwGbhbmxU2yQkcGZe+PlxnJScGWunf+zZ56wrGA1QasyhU2XBLiHmcyKrUCcZHSsT3BlZsRMzEd4ra810nGhGKiWu+pfSKuZExz/XIfPAxWnk/TYRhY7oNhtk6Q261InQu1YI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 13:22:12 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 13:22:11 +0000
Date: Mon, 12 May 2025 15:21:58 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Tatyana
 Nikolova" <tatyana.e.nikolova@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, "Lee Trager" <lee@trager.us>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, "Sridhar Samudrala"
	<sridhar.samudrala@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
	"Madhu Chittim" <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
	"Milena Olech" <milena.olech@intel.com>, <pavan.kumar.linga@intel.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: Re: [PATCH iwl-next v3 00/15] Introduce iXD driver
Message-ID: <aCH19kCiDI0GUs8s@soc-5CG4396X81.clients.intel.com>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
 <20250512124906.GA1417107@horms.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250512124906.GA1417107@horms.kernel.org>
X-ClientProxiedBy: PR0P264CA0062.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::26) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: b87d16db-ca35-4f99-8361-08dd915800e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VH/3jUkuAVGY6d+pl72lp1mbtZsTO/syprBrsRB+j/xXixSKPgwUYGOjk9z6?=
 =?us-ascii?Q?AFleSxcmfKTqTBJmnJRkvGnvIvDNK8wl104HoeFeQxLidayTzKHc4rjfH98O?=
 =?us-ascii?Q?J9EDFO1hbxH54m9DFUlW/w4wCghRfKvnBQIwuCk7aeHI0257NEWIZajQTe3d?=
 =?us-ascii?Q?qm8i2VBbJW85Mxj1v8KgJxIlThpF5Pw2Lo+rmDElYRvksfbc2VCtv8ANStb7?=
 =?us-ascii?Q?P6/W9KwR6TnasxU0NSsb6MKLXHE3UIACrs6uMtF+4dPxbVYLh7M3xteML17m?=
 =?us-ascii?Q?r72ocFjzkBJrVZHxpnNTcCAQ69AeZYWnT11A+ijgXUFLkrRk3OZIE8U+zjB8?=
 =?us-ascii?Q?JNqlhIurH4MOz/wDw3aL7TkzEviu8N0ARZpS+M47vPGwuByFrrhkxwYmOZRu?=
 =?us-ascii?Q?HbYNmH/tSS8d8GFDaER90Q38Pa52aZVdbvIYow+Y33Gh0OTcsbyNjBA3JWBc?=
 =?us-ascii?Q?ce4WO/Y9S86qsp2eEZ0jd69bE5yGZdx4B53xeGpGy2xoGFwNPE9xcZhGRKPH?=
 =?us-ascii?Q?409Dp6FAbFmyojL4xgpcwn6DVM2VpQHVuL5pS3SwOsM+aiWNJPjNReNNjHjF?=
 =?us-ascii?Q?NBEcGjBOH8eOexqAkHa3/yejxq9Hnfq4q58ZaiEzt3mY5IWssUSoSDx4wqAu?=
 =?us-ascii?Q?A2ZRBGzl7pGsHJd1MhueZvkB8S4AuX1loI73qfjO2hCCYe/Qq+ywXN8+/PVc?=
 =?us-ascii?Q?XS74IUzw+X6A+4tv9mIkkMo9BzguAijZ8yvuMABoB+KiDi/sZN9R4mInpOLO?=
 =?us-ascii?Q?a2g4qtA6Cm4DO1a4ZxUJCiAU4sFc/ovqrsAR+ZQXneoTXRXmjDH0Rn5gturc?=
 =?us-ascii?Q?h511HgV47harLLpr7PMEc5QoVaqvcS1Ybt7rd2WPLPhoFsW75Yvnc7Qya/cp?=
 =?us-ascii?Q?dl65L0FHzuiDgVVkUXJQ/AEkzb1BEtXGME+Ka5tdmJlvABLU9KLFnoVBBL14?=
 =?us-ascii?Q?QJQpgay7h0o8nzD8uvmqe5OAseDrF2dY3xbOUeHIh1FtSFu3/PrOwMvLDunU?=
 =?us-ascii?Q?5w5wGRB4qg1im9DgJTRbk4a+XzEbbjyLAv7OUESmGDrtOEjm1qe0IZCH7HZY?=
 =?us-ascii?Q?UDAckKp0xvtoyChV/fe0yweNe9gMnj81fPIlQ6XoHP3WzaowRNQKzwn76bHb?=
 =?us-ascii?Q?qJzSxvTNw2E+/On1Nl7vQ0n9XPrL7IT51hUHYiqoVdo3eTOUSeIQSWYAUKeO?=
 =?us-ascii?Q?zo0tdxJcxYrKYxvpUNa9f+19+08iBihPMZ9JLbdQIiN4ejhp58bjtb0NPyy8?=
 =?us-ascii?Q?QaI5GuSJFNkTc94iZjJ8WKTs5VDw0/ANEBCNZ6wTePJbeEsTSgwHi3VdN3bl?=
 =?us-ascii?Q?CqVjBPz0aXu+hgbjQqecVCxILqp1dUDCsYv0QXX1mfIODyCjyu9GIifm+LR9?=
 =?us-ascii?Q?75ky8JE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?phsgsa2prtPv73yqV4nzFrb8mbYekzTBOUIbA5DGjdoc7AgVe5wUpUBsqzwR?=
 =?us-ascii?Q?0+SEzfSyweY/on6th9k2ft23e0aBo/flkfgd2Q/eu+QL+CxrUcqj9qud+JRA?=
 =?us-ascii?Q?KNnXlAEcYHVBPwiWg9IdtvkdOq1w/jm3azoVjREYbXoWWGqlVIXauN5rcbN0?=
 =?us-ascii?Q?KNW2oSQHI7RgXtxOGYsV30L4pxj4PFea2Mx8q1U3HnoOksZDnSdZ/ESq6kAM?=
 =?us-ascii?Q?GzZ1AwUrmaKzLLrQXmwaV2dHCa2bLnEJNELgRY41M3DwUGxkzot5DF9OUtF5?=
 =?us-ascii?Q?/bOqiOisNafXNDIngsGJL7BXWEFH207Hrv9JaiNHXiGXcA5xyPqTdbf8bUcj?=
 =?us-ascii?Q?qMfGvTXZQalSyUqf9bHxKkBiXfNt6asmqI9SkR/hx1Vi6y1CnIIrV7rGDeP8?=
 =?us-ascii?Q?cxsStJ/G9pr2xG5sE0ST6k0rOPD7a+/Vz8JqPcOMY0Wz+sHj6IcanS4QeFFD?=
 =?us-ascii?Q?NPENI78Fx6fiXdH5WakHrC1JXfvzih9B7C6ME3BOZsrcGKbQ0psy7kxP/w0p?=
 =?us-ascii?Q?EooWqE9ImGUuEaKFv0KEmZqWok1aaWfYkkiWay4THRcnkneKTVkeGFNKg1hG?=
 =?us-ascii?Q?h95Pl/xmeb7v49gWPKjqLYDI8pB1lepsXzSXEjolYOHp6BSLIdE9G2shmH1v?=
 =?us-ascii?Q?znvQu6vnRwuaxuwVWX4EZBq1LKzVz1rL5BiuZOAN6JSr+Qx35cnetNXu9ahO?=
 =?us-ascii?Q?6c5A3Py2JkpEEqtmz2KlZNPiJQ1RD7zf/O/F3FPjJ7NHdehPrfY5/lwUiDEO?=
 =?us-ascii?Q?dhMMy21l0dXuhja4tAjEFNMu4XsuENv7wKlAQLpsujM+h1zGlDK1jTMh6rcN?=
 =?us-ascii?Q?OMQi9uaDYbFJsLscBbqU9x53Nfv368cUYU2042r0kMbMBVNRetUn2uFPPL7G?=
 =?us-ascii?Q?FvXUToXV+HiOmyb1uXavcRzD0JOklQEO3uTWT58OKOZFQQ3n/gymHORFWnMU?=
 =?us-ascii?Q?fCis6UMKFvcvRt2whtKRLYTgDEVDlsRTgpe3NZVCWiZF0yZTfW0eaxPEOvV3?=
 =?us-ascii?Q?z2HaZWBegI7TSCMkctHMPDVBfhYzdpgVyJoAdb8jSatvBOKkynqtTeZNIYB3?=
 =?us-ascii?Q?lAJKLCUZLqK2nvYL24F1Ke8E7IOhV5yr97R2auc8cEvr5Q5ZD7tW0gjZnitu?=
 =?us-ascii?Q?BW47G8sU50IUfAfDR3vptwvsmgGGh8vuPZrfx+/NDLFgQuZL0RjYdfAqe1/7?=
 =?us-ascii?Q?06yb+X4BMqh2yz2MpMBN/dpP32Q3QdLfBSo24fht9xocU2QHRzye/qofnDLg?=
 =?us-ascii?Q?OBNoBVIij/Mk224shgbzMncTkwZMjIcnNJbhb/dlLfd+wMGb/VUHE5OTC5Qa?=
 =?us-ascii?Q?yB6rm87Kt6yPscLJ+NZ3NahxdWfxgAzrovsWMP0jWb5OPdQENw7IBk4NT0V1?=
 =?us-ascii?Q?qaRKnhepqxyIMhN/VMQhmvAkVDAACmDQrgozwNx/wZphvpBI1LilzKzOQL4E?=
 =?us-ascii?Q?QUEQ+6Vr+YZ8GlB/kxk6CtSzr4a7V5J2D72G/KTKz0ZoLEr5scypoNA7KD+j?=
 =?us-ascii?Q?Qn6tzep23FLkegxKW2Rt8Eqbm0dkyf4bBzSh/p/tA+jn85Lp1NpdMz6GkTuW?=
 =?us-ascii?Q?gnwpdCKfhDapmpNLhoDcWKUeTWUxS7QqiPRqzrnuUdK52IUlBie82VIF57K/?=
 =?us-ascii?Q?aoQ6TMV1mhC3HSaNMFM7WmaOBKFMlX1skX5H6iLZGCOjJKxXBGKFJ0Hwe9wH?=
 =?us-ascii?Q?u592jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b87d16db-ca35-4f99-8361-08dd915800e0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:22:11.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1c5Xr3eaMmbyqZT8vP1pG6EM/5iZJbPOC8xvwjkNjLm3T71cCycjiLC+lV7I41vuO77CQ8SUPlth6x3YWhJO8fSCIiB433NehyP2MnqOY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com

On Mon, May 12, 2025 at 01:49:06PM +0100, Simon Horman wrote:
> On Fri, May 09, 2025 at 03:42:57PM +0200, Larysa Zaremba wrote:
> > This patch series adds the iXD driver, which supports the Intel(R)
> > Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> > It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> > exposed by the same card. The reason for the separation is to be able
> > to offload the control plane to the host different from where the data
> > plane is running.
> > 
> > This is the first phase in the release of this driver where we implement the
> > initialization of the core PCI driver. Subsequent phases will implement
> > advanced features like usage of idpf ethernet aux device, link management,
> > NVM update via devlink, switchdev port representors, data and exception path,
> > flow rule programming, etc.
> 
> Hi Larysa,
> 
> I am having a bit of trouble figuring out where to cleanly apply this
> series to. Could you help me out?

Tree did change quite a bit in a short span of time between me fetching and 
sending, sorry for the trouble.

The base commit is 10f540c09cf9 "ice: default to TIME_REF instead of TXCO on 
E825-C". In case you cannot access it, I have pushed the tree to my github.

https://github.com/walking-machine/linux/commits/ixd_phase1_iwl_v3

This version is probably much closer to what would be in dev-queue eventually, 
compared to a properly rebased one. Some patches were pulled out of dev-queue 
because of validation problems, but should be back pretty soon, as far as I 
know. Those patches are the reason why I have an additional fix in the github 
tree.

