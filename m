Return-Path: <netdev+bounces-95363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAAC8C1FBC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244C5284C37
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DB15FA85;
	Fri, 10 May 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAlP0B3a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E0161912
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329799; cv=fail; b=VpHQ2lmWpIk5VesAY3WX549EcnSwcS5W/D6vA367sWEM1OyW2ashJJvJ6R1BRcgOCqScg0M4UAAVnxUUWPL9mUKEHKJCe7jGlcqBVGJWRnZOtxz0sjWUk6/FYJhHQZBdLYJrqMlQ/80nx61v9xakKpqauoluBXxqMU3VmI5OfHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329799; c=relaxed/simple;
	bh=wOK37iK9GefE1HPMnlliIFqjM6p4ZrTyFd8h56+7+Do=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pi9okTTg3r2pdSgutM7tAyd6snHxK7pvOHpEa8bkOnAADTRg+4zPYmNJP46BcBkJPGn0qk8h5HoAlOv5nwbUg/gn6au7gxQd/hJB3KBZCsaqi+ueNHzoULkCQz5gVyx0rIMi7X75YBBTtkagigPlff56qsQLTt9RPQDwoHwoRVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAlP0B3a; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715329796; x=1746865796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wOK37iK9GefE1HPMnlliIFqjM6p4ZrTyFd8h56+7+Do=;
  b=HAlP0B3aLluHqsfhMaYRaYY/aYMFMwV5Yf/e25bf7VKwvsas4H6wcPX4
   CwKkRhTbzvOgWG9/ITs9vRfFEaf3OyaWKt2bMu7LqN1aiiZgFI3HBowx9
   IjWfIvVK8tuFh4oMupfqt4WWwPjOyjMrUevZ5hpK29gJsWh7yZII6qFiF
   yH5ksGQEYAPGNe6Fv60mBrLu0Slj5UcQpKzud8GMN/LHJp/ule+KLfMh0
   u0FTgBGFNFkRvexghK/VxsPPad/GkT2ROvuyG6p3Y+rc+Z66ptLyHsDnK
   t41CEL2dqOD1G670bUfHmI4wZoQeAMtdCqlrmItqOHKPpBOsq0gsHW+18
   Q==;
X-CSE-ConnectionGUID: LmXLp9IJQP2ofPtnpL6Ijg==
X-CSE-MsgGUID: sBz9pKmjQGiO4UcUbJ/BfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28783596"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="28783596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 01:29:55 -0700
X-CSE-ConnectionGUID: TdWt7Wq0Tt+9tBduDzIZEw==
X-CSE-MsgGUID: YaG5mLfERW+yfhT8H+nV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29480473"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 01:29:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 01:29:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 01:29:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 01:29:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 01:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnIZAkkJ6K8mDJCJNkb7jOOr3fqegyYexG2NzM3FtjSjdowjnvGwP8Orad1TNThe+sOU1PylR42ukfl9B+WW/ERH240fgZ18Xtp1tQjVW/L9q5zGUZgPNL6LQnC+T7SQ20a+xXEP0e+B6r9jE3I7YBHOWVU13T7UEtjT/BAFZQRmduB77/w2sGr3wiNsDBwGbezDrrwqgHRdV1sLPUrVp1IiFm5OTqEaXHkC0kDDv+wKRyNa9Dkm2izDwY+okgFK6LaeRodY+H4ZIDcDo+9oxPBGNm/MEbRlq0SA86hR7bGBZuOCeMOBDfIx4IgPGzWKND6b4AYyI8wklwCcJ6Ccdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJJL2QmYk2PySZ9Q+3wAS+k2v2rV94us8OPtm3rPyxs=;
 b=lHhLv/jYg4h8aWHgYAjlgOV3ME+a7koedkC3x+MZhHqeyaTx3wsPC1qwX4seqCbXRKZUpKPfVzKEBu3xnWXAN3V4/fytmwqXfHmrh4FVvs3IBmg/HUw4kVFGQxZEcH6MvfOOd3o1NOcLSOrTTt7LH4eH0DdAoqO8XS9JOjLu0VTcl00TQOnhV8vOLW9uMq+nRHhU5uoatvTZLyBQmSEoz0CjFYWyDdvShkTt4hHZp3+NpM1H8GUYOpFkiPR3ZrHV/TUfwT0W29q/Ge2XHzB9u+zUYlR8IHMmYiVd6gkz1QPTS0gHcD7VafJvd3+L6/oF0h95d+aElQlViZKM7Eag+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:29:50 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 08:29:50 +0000
Date: Fri, 10 May 2024 10:29:42 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, "Yu
 Watanabe" <watanabe.yu@gmail.com>
Subject: Re: [PATCH net] inet: fix inet_fill_ifaddr() flags truncation
Message-ID: <Zj3a9h/VdgwboRZJ@lzaremba-mobl.ger.corp.intel.com>
References: <20240510072932.2678952-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240510072932.2678952-1-edumazet@google.com>
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 135c08c4-1838-4039-73fa-08dc70cb5bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UylgLi5LwKa5OX1d0cNINrfgQsHVshdVTSVVV4LT+Pv/ggGH/3Xbi8iSIQH?=
 =?us-ascii?Q?yAeIiZmr3ybURsNm6BUw0cPIDYMaa8piinVgoMVixCZH/lgNhERjDypFxyZM?=
 =?us-ascii?Q?7adwzsoEGa0kk4nwETOjzgwstEhnZ/qvDcdzZyrdpZEd/ipwzxf2pGkPW9Sz?=
 =?us-ascii?Q?ORdgV1jDeGfCpQXaQR0hNkfPMb96BvsF5eHyIidXVDXD5YwIsocIL2sLh2mw?=
 =?us-ascii?Q?LVze6srJzsjIHOaWQdfXUmUWmq4Cry93ZJUPLbgXBO9g8hlzDlsOCfcyMA17?=
 =?us-ascii?Q?UIKIHXqjrH48S8yFp1hPsem0OsvNzFYLIps+RJHwg/SZy9dtpHCquNlp9WVN?=
 =?us-ascii?Q?8iqVuN5KvYmHSBdqhisE2sudNOg5g4SqKmm7cSoy3NjvDr29oK/ZRlHgTK2B?=
 =?us-ascii?Q?k2JJ2xjjlgW+MU1/rFHPdR4G8neO4y/TWUdSTn8B9bSPxqd/KNdBHvJm2vNC?=
 =?us-ascii?Q?wDRCGeQzr4Rs/VHCctmNTVvPdxaO4oJZxnTXXo0lRPPRBZcU56so0jqbshjg?=
 =?us-ascii?Q?KMQJToMTQ9Bfn2xVdqLl9CpHBz/P8uSFpdYAasZOa/Ph/aVYqU1FEqdw2kd/?=
 =?us-ascii?Q?936LboeWDSAvk5IvHQGqxurGKLWFxHT4KJE4pJwRermud/QuTXJG/5nTbLce?=
 =?us-ascii?Q?0ZlxTGl75SwZHDz1MqxleI9xfiQUKiGMVGq6o4cBuftLpzvkNas+De6P1/dn?=
 =?us-ascii?Q?rKWS34nBryCggz6lzzeO3Olw2DQEYRvdvXXuYpM3XNqfovabLU5InWUV5YZE?=
 =?us-ascii?Q?8f2bQSUghV/8j5ihxbLcCR8L/dqWLfy2nEJ07rDXnbKbQNVI6y1JVqXM5f4n?=
 =?us-ascii?Q?yMdAw69VeJJ/xLqjrbOpImF6Ff/+NseCKWCiI3tnm292ZzPKAaXk2IG1kfAS?=
 =?us-ascii?Q?6JrSFipgQzqkGUQIMPbA5h6LyRfMuy8/nvw3AyOGxBDUFgGV/vCR2xK8xI9i?=
 =?us-ascii?Q?L6TOFMZcJPfpcuKCe4zb1fk+lJFcqMVSdSxxSUZMgWYWg17WEM9KvmuGsGN9?=
 =?us-ascii?Q?v2LfPSGPFdudZZeQNoYDyZcbDuLgCETkwtLAyMgKVUki1bu/K6gRGexn7DTL?=
 =?us-ascii?Q?5vNbT4klGlst8gYpH1psslGXl2icOAnlJBEV1b4uaMSex+Gx+fRML5PpUqi6?=
 =?us-ascii?Q?3p1UBJ1iMtp2q5gLSi3VdVrv/h6GEa1IPFidkVfiP5E7T3qiesl7AIJXSc1N?=
 =?us-ascii?Q?qcXfMcSKFJhdzvazDq485/jnOfErbQps5KrNHD/UGjbcy19eFPQe1M84/5Q?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zan68R/WkWjL9azcRRsGrW58RwYhItwFt7cOyp1VZlbO5NApQmIVxgzD3T88?=
 =?us-ascii?Q?UfJvBI/Rz0QI4yPrex+PpWLKW3NIiSrNYH6VWO+CtbnFdbgQ716FF2+CjVoi?=
 =?us-ascii?Q?fIooJaE18EEzzSvDA5uy+XSZM7rlNs7DuMvtpHfwAfKCsFcOeQeq+Sclhduk?=
 =?us-ascii?Q?sQTxSlQf/b8WJ4g9FKW0hK2HMFpHUWF5KkiAONHwFuizZ/MgFCc38MQfC7DH?=
 =?us-ascii?Q?U3pWRCA5g7vfwv1s7no7+Y1N1NdvUh3bWt/3+zQBap7enwV490keaj/7FHLR?=
 =?us-ascii?Q?IeXTJoSyeqbpWjMPQbws/hTVZZjaDOP8wqX57qQTMM2uMZoFyrBFWfKQ02iM?=
 =?us-ascii?Q?1bQwiz/si9Mw9QvBClF1a4Uj5xa2ZZYgwEhxPe1cWSzZZlykrFnx62/q3aCz?=
 =?us-ascii?Q?mamObESWkvTpaWp6+G2z1pCSRX92Qv1CKzauSiOgDVlJVgm9aFlXusoBEcIX?=
 =?us-ascii?Q?6H5gLSqoioqR6oPgGgSPGwjYB388UMkB2Z5vzpSx9YRJyXQkMIO3alUTWz0a?=
 =?us-ascii?Q?EFj5ke+p2+Txp7zLM8BX9Z7jmyjvIDC63eNIrPM2TDhCWDO5shF7IGB35Jrp?=
 =?us-ascii?Q?BKKc1N7yoFQGDDshDzsnNuVbD85W5Yzw2haYPe5JPMOHgFMXufNblhUqW4tp?=
 =?us-ascii?Q?T8aiWX1EEBA1CnR6+rxeeLJB76bnC/c3WnLnv2MYiQxWgt6v1pOXfSfCxiMq?=
 =?us-ascii?Q?JJwWx+dZxRdZD+AqEqtmODJGR36FNvYxjtFq0CZjBEK7LU2Oky9rSt6K+zJc?=
 =?us-ascii?Q?0dzMHyKAmDPtUyte81qlPGJJHGH3BDL87bwgLZHMele/oD9yqqbNTK6c+UCm?=
 =?us-ascii?Q?Po5d10JwOqnwhV6hr4tdVSw4523Vyo8BjZOGbZ/i5ar8EBRkN4TzRz8tLitg?=
 =?us-ascii?Q?/Pgf/Sn+V4SzeYVVlFCPvU7oJkeqEhmOqnmwrG2mISEln5yLc3mC3GI87uOT?=
 =?us-ascii?Q?wPwuOGcK0F7gsJBxzHITNZyTE1SEEJ8U4MkBcOvb3cNORJO8JS6Sg6D+XJi9?=
 =?us-ascii?Q?ljx98RFJdMwpApGeuI886ZRxotg/98bvCF6dOmC26dy22fHpQU7kkQY8jpAC?=
 =?us-ascii?Q?0pHT6LA2pFvyXeLrtGZG1CcJzEgLj3z6VpIhM+ytWJlkWlNy53o9pdjzOmPG?=
 =?us-ascii?Q?ilZOajTotv9oLO+HwHhLf+HnVAWnJbSFHXcIyYLlXf4/KzQFJT0SL94m4/wZ?=
 =?us-ascii?Q?ezuEh+r5RyqpnpUmHlkespMblWnXmWuvYLm3a0CHn4Dw76QGV+VpiIpEUvB8?=
 =?us-ascii?Q?YBfb5y9vv1Cf2v21xLOMfNYKs4mH2tmUdp7VAih61f69hcyJFn4HSDHsVX0v?=
 =?us-ascii?Q?C6RsfEC6GRs3ak9w/fLL1TNjDUKj6cuTZ9FfioCliR9QJgnN+nGGk8TqZms9?=
 =?us-ascii?Q?NR3L7oA66NAN/bzzg+oCNvrPQHvymXGJV23thEAdpwCrNy+uiB+c6G8rArVN?=
 =?us-ascii?Q?7dVY5RPzFYBGKJsTs+ZVmPLb/GqVPrGfiEFMq+MvoJnQkRm94T3no/pJz8QI?=
 =?us-ascii?Q?X0nrAbSK0N0x3TqJDVRk/GGQ7pXSTbPshw+s/jmxoCVnkcyuR0W8mQ1/347d?=
 =?us-ascii?Q?w39VKwaFiYsjE34ySkqhA4D7wOLlAawBQ0d1+yLARc7/p+6fKgNCJL9Bt+kb?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135c08c4-1838-4039-73fa-08dc70cb5bc5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:29:50.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tpZS3r03S/kXvz2bvjgBVTt5z8t4z9K1egKR856a2WKMnRl1ipIU7QaBdaxyNVS5aSXt6OkharGAsA+97oRi9Ch6Xj/c8x4SF6/79vjiNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 07:29:32AM +0000, Eric Dumazet wrote:
> I missed that (struct ifaddrmsg)->ifa_flags was only 8bits,
> while (struct in_ifaddr)->ifa_flags is 32bits.
> 
> Use a temporary 32bit variable as I did in set_ifa_lifetime()
> and check_lifetime().
> 
> Fixes: 3ddc2231c810 ("inet: annotate data-races around ifa->ifa_flags")
> Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
> Dianosed-by: Yu Watanabe <watanabe.yu@gmail.com>
> Closes: https://github.com/systemd/systemd/pull/32666#issuecomment-2103977928

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/devinet.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7a437f0d41905e6acfdc35743afba3a7abfd0dd5..7e45c34c8340a6d2cf96b4485cd4249fd4da7009 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -1683,6 +1683,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
>  	struct nlmsghdr  *nlh;
>  	unsigned long tstamp;
>  	u32 preferred, valid;
> +	u32 flags;
>  
>  	nlh = nlmsg_put(skb, args->portid, args->seq, args->event, sizeof(*ifm),
>  			args->flags);
> @@ -1692,7 +1693,13 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
>  	ifm = nlmsg_data(nlh);
>  	ifm->ifa_family = AF_INET;
>  	ifm->ifa_prefixlen = ifa->ifa_prefixlen;
> -	ifm->ifa_flags = READ_ONCE(ifa->ifa_flags);
> +
> +	flags = READ_ONCE(ifa->ifa_flags);
> +	/* Warning : ifm->ifa_flags is an __u8, it holds only 8 bits.
> +	 * The 32bit value is given in IFA_FLAGS attribute.
> +	 */
> +	ifm->ifa_flags = (__u8)flags;
> +
>  	ifm->ifa_scope = ifa->ifa_scope;
>  	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
>  
> @@ -1701,7 +1708,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
>  		goto nla_put_failure;
>  
>  	tstamp = READ_ONCE(ifa->ifa_tstamp);
> -	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
> +	if (!(flags & IFA_F_PERMANENT)) {
>  		preferred = READ_ONCE(ifa->ifa_preferred_lft);
>  		valid = READ_ONCE(ifa->ifa_valid_lft);
>  		if (preferred != INFINITY_LIFE_TIME) {
> @@ -1732,7 +1739,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
>  	     nla_put_string(skb, IFA_LABEL, ifa->ifa_label)) ||
>  	    (ifa->ifa_proto &&
>  	     nla_put_u8(skb, IFA_PROTO, ifa->ifa_proto)) ||
> -	    nla_put_u32(skb, IFA_FLAGS, ifm->ifa_flags) ||
> +	    nla_put_u32(skb, IFA_FLAGS, flags) ||
>  	    (ifa->ifa_rt_priority &&
>  	     nla_put_u32(skb, IFA_RT_PRIORITY, ifa->ifa_rt_priority)) ||
>  	    put_cacheinfo(skb, READ_ONCE(ifa->ifa_cstamp), tstamp,
> -- 
> 2.45.0.118.g7fe29c98d7-goog
> 
> 

