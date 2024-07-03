Return-Path: <netdev+bounces-108842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17E925F53
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D41C22104
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767BD16EC0F;
	Wed,  3 Jul 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd2kAHRk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D0142649
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007811; cv=fail; b=SusMrXq2ulwx0pvqt0wGZFCUqfdQojuQfCc3GqAn2zzul7slTzdDY93hl9YiM9aYNml5hgFBM9kot4T9md1ph0OqiMZC1mjG035+wGG0pR9eg5/vm4nth/JTwWJ/cE40N/oceDqNEGttHDMcNtcWAR9bmbsffo3KWUMo1a/lXmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007811; c=relaxed/simple;
	bh=fvvB3QkJtFdZqZQBi5ZKSHNBjXOaZzPqlbdcYI8CPcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cb5pNIfOf+3pPlmfscNCYVZ0aPf+PW2eFlgVviP6zcYJyZ+bRWAKKVov6freqs+Wl7Ae7X2UIrKCaCQOI7r0eGQC0YnikJrdWoVsHqBfqdr89j6IA1QFmB8m7yvVwL8GAqsvChAlmw5e0LihxFCjbGbX0AdJjnYOpnemfRm1Y2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd2kAHRk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720007809; x=1751543809;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fvvB3QkJtFdZqZQBi5ZKSHNBjXOaZzPqlbdcYI8CPcg=;
  b=kd2kAHRklRLOEXuuLT9C4RuIix4l2oT3h48F2ymy3ycb24qmPZd51m1V
   j44phiAyGuiMUcFfEiJf4/O3rjzFzcRxwRY/xnfsbXrrjMgTwKYT5mQzR
   MhoibmnMwW5MxZBMVqlf6mO4Wl/FAAIxVJqi8NaUaTynAcYMx56ZN89We
   c+Dbwop1SkZMOL+tw4JQw4HUkVoQiA83Z0l+VjExJTWYLGZC1TfuwaET/
   cMfh0KOxWJD7QPr2VdpjThJ2gt79w7iQZMG4X2VNL9Vj8WV8b6sJ5e3Z4
   3Dk5FD2WEZd+DjRHm3gsQAoxR77rE19hyAruocFujZR+uvJmbXk8W1C69
   g==;
X-CSE-ConnectionGUID: w1NC2sFoS12E1rz+8aTgjA==
X-CSE-MsgGUID: 6pN8tIuuSyK6ERRNdZR2rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16954096"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16954096"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:56:49 -0700
X-CSE-ConnectionGUID: SylI5vcVR2GrJFdnyIVSxw==
X-CSE-MsgGUID: sjSdpSokSSyO5fZwn5KIaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46243211"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 04:56:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:56:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:56:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 04:56:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 04:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYvFF58YvC1wzVMQjhlJbMUXkiTZVxTQ5kNvKkTbels6Os5z7OuHmyHaY8Rvjq6qpqvFZxsy2HvF6zvkEOR5gbgO22WbQePOiiIao00g1xU4/hfMsNZZtLBFnjYF1VcaGmXDy7hb/X3/GcM+LLXhAJXBiA0Qb+03gnum4hDMxWByaSo8mH8qOUvsetl7CbDj6oUNObgfdnhgVdvWDap229WcpBOjfNuS84DoeL7xGj0OPixZZN3R3Gom6q5IuO0ROmknubwVrHIBGwNnmBsW7hePGblwMiTj/O0NUL7AeIWOCFli45XJjnyy7anqLwnA5lnxKseWK5rOobfO6HTaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoKrfi64LjvEvd/87Cx+L8av9rF5Ji5jZJSkZWC/bqo=;
 b=P9YUZ4u3lWiphfsShQi67joQpD66LLa8LaXRP5A/Mw5XEYppzqdXl5wzl75FwHIRWajrVhZBeEyjgiYfs1/8o1znjzzxgJD6nGtmzrKYqbo3Dub+ja5IX3Xh+5UfXjXXHKDXBI3C8W6jJrNEUXoH+ftveGNNLuxfyruyB+EYt8Elsilrs6/M292yXa7zSQ87VNLzgR0NH7uvhM9O1jBdjD7DuMlkW8yEGUQBM6GUs6Sfa7fgi1joHufXLFLn8AcDjkQwIQAis8eYBnUzdznEwjQRy6s+eoZfsyUx54BOLmLqJ+RuCFOWMyY0zmUFfyLSG/7j+LP3yteBlfFPgMLrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 11:56:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 11:56:45 +0000
Date: Wed, 3 Jul 2024 13:56:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <richardcochran@gmail.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>, Simon Horman
	<horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net v2 1/4] ice: Fix improper extts handling
Message-ID: <ZoU8cSUjkEN5w7Y4@boxer>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
 <20240702171459.2606611-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702171459.2606611-2-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 91340f92-752c-4740-ecdb-08dc9b57364c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vrrlLY+7Rh5Psm69lGUqFgG92HoCZWiO79N91iWc0x4sWshIyf60LbwEgQSh?=
 =?us-ascii?Q?rPJbfYw50WO5GVBp+vDXfZnlTIkLFvIHq0CN2C8askX75X3KLsxBQGeQ0Z2m?=
 =?us-ascii?Q?yaSGVvmLjdvZS6FDUPSZXLcaImET5F6gHLfPt25ZYHlG+9qn5aBq6P3f5Qpq?=
 =?us-ascii?Q?lG3Up14ehWLhmH7iUlQz82PGnvJi3OTyqpvjjS18LTAntUzRX2cYkKSvCVI1?=
 =?us-ascii?Q?xK/20tO7GudAEfjAgPsvvo4JQ21ndRK2TGf28uv5FUpxVHCteopkBiL7E8vH?=
 =?us-ascii?Q?okSxsHKvKSdHmbENyO5lrdZeOtfHz+CEY8wLvwfgWuSSlHJxSn0N/u2gC4FG?=
 =?us-ascii?Q?srUN4L17wWvCRZU0epB3skuKM/5gLE0BNwkusrOrnVLzMotepGlcPCLA9a2p?=
 =?us-ascii?Q?yNZ5hH9pnprYu6Qs4KE3+skvepo9hbmmU/H4RuQj6wo9dZ1xuleglh1ARlna?=
 =?us-ascii?Q?4K7paAKqaba5J0GkGYtTJ6voNuAdF1UJZqxHWH4fiPGgozVWf3GgZlPAsP+I?=
 =?us-ascii?Q?cDEyMrkpBrItZhGmwYEs3kNnf8urRVBicVdHXjUTGVF5ZSwrnB1mIhlJg//f?=
 =?us-ascii?Q?iERzyOHAA25IRcbUY3us2AdVhn/U/AR+A33hog1nvqPhO23vvIGQvSSxoEk6?=
 =?us-ascii?Q?uivxOeCXWIoTYH91A0njA0VnLlnSeFq/RnCvaZK/GHtgf8klAJEff36GNCm6?=
 =?us-ascii?Q?3Ndd92jeFy7qwm048HeY7BBFenSrStx9HpVSGSGtG0vbyiuOwBjHPutEAOB+?=
 =?us-ascii?Q?uG6BeItAoUPMIWhqT3bH78OsvRwRjfFnUaRgoA1IB745OnmTLTVnItlACA2Y?=
 =?us-ascii?Q?mOX47Ol+ijPC+C8IsDgG0LGszkHHTX2fDd873/x1/tA6fdu3t3SIzaDc4J/c?=
 =?us-ascii?Q?MEAjDNWa3L0LIrjkZ3jsq40Cuz6lN/YOwGTjAq4UCe0ESBLSZClEPSuhsowi?=
 =?us-ascii?Q?txR68CgX5LGmgCNSuuswuiRaphofY62Q5Bmw3fberzQWrcQWcaZKN5au3wfF?=
 =?us-ascii?Q?9RpRF32yTRTCctfbrbHyqMAqyDmsYX9UXjm7W+MM+bQg1K6OHf+anmcH/iGA?=
 =?us-ascii?Q?l73GU42ITBbEyg2MHhc0JsLH1Pcpdkbp6Azwyp8GgUDeFKA0IQs4nLf+vOAV?=
 =?us-ascii?Q?m6gQjPkcWDRjpxxh1yz3NSG7XqKwvj1sdZH1hXxvWxK/heW9VGYJcOOmemzt?=
 =?us-ascii?Q?deR2uPfLohnjz3I5YJd/lBNCbsiEB3/NEBD45UF97M9laxr+9mbiNoUIMK30?=
 =?us-ascii?Q?Ai1+G1aonO8afBy2EuWL3Trw9ZDCBUas34EIMPTyw0UI8QtCSStGd1X3xWVH?=
 =?us-ascii?Q?Bt7sdXP2n27vkHQvpHI9M5FoGqtZOKFDZxHTop2J8cpXGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBric0hNtY9GOKunQ6BM4MvEFdVlVXZpotUjAeu+fWjJF/qQ45Ng59aQ+YYg?=
 =?us-ascii?Q?9muFyDg/Ac6i4aD3gsCY55a5v0oH7Y0WfOTz/x8FWUE4IpHBVrSI3yuqjhLy?=
 =?us-ascii?Q?QxrSJjVHZPO31tpUzBl9uBdmG0lr7jWQ/NBHGxurNHlNNWGvLgcrh8+3UfPh?=
 =?us-ascii?Q?LdH2kxTg2bRUQK//9bgzJ1p7Z6TE+gT3f3TuqOVJrwGezjhhXkuWR+92PbOv?=
 =?us-ascii?Q?wmnYay2y6YZWOFrq4U7VdA3wyjfvZ+zBgnNpxEpnHmgUGKS8uqt/wB8GxIQ7?=
 =?us-ascii?Q?EhbsCsPuToO20jbEjrXyNoCNyaNGgLosWCNosIY6/ZVg2ZrehDEC/RJPBZ7g?=
 =?us-ascii?Q?LbRgt+DIkwIullvo9YYu9tOdJrZGCbGBX+DhYrTMFRYpSlxR4FTDANr/wfQH?=
 =?us-ascii?Q?nXBYXfGWGwNTyrRnKCuuoyHGHBokNhVEx/k5aE56T4b1VAsGI6dFWpVd9SlJ?=
 =?us-ascii?Q?v1ebuWVUHpqGbx9PTCcIM5TJYcaVHgnORCdHytJRTrqd4mZRcwQvYEfbL40a?=
 =?us-ascii?Q?M7m3iHRriasyKZatLSngmQFzemgr7FofeOToG39gq1qnvcDchnB0QkYFUXTM?=
 =?us-ascii?Q?2gZpfyHNQts2C+1XnUF990QSyMVzU2QR2EbV/FNpTixaLXeuB40RGoFaxoYk?=
 =?us-ascii?Q?IsqKJFakA7Q9jJT/JWJYtsl0LbWEYLrqLvKmqKTJ+pibMA5vNC0mUHUEyxQx?=
 =?us-ascii?Q?X6mJ4h3+J4qyWb5sYIsvEay0Exn4G26T6E6DDTpvSXtbnNvMjwt43vGEyQog?=
 =?us-ascii?Q?/BJ+et/0pIjseG+Qoqa5CmgRyCTQwLy5T9rQJds2mNSSd3QUh3iWRNVgBVYO?=
 =?us-ascii?Q?e87yGIGB443vYgE/7s2Vx12rR2vQ0thz1bLWsrjXLs8eMCrhoEUSZKh7+poM?=
 =?us-ascii?Q?RU6A36Nb/Wuz7lSdRqdNx93rg8xyCCkd9+MygEHpw2HCYAMcmT6zMiKYIHhM?=
 =?us-ascii?Q?l9lQlU2vqnJi+6qGwbEyBzN/ZbeewdStSxbw/GI2vNKHDr0oK6fqfB94HbLa?=
 =?us-ascii?Q?UIh95rAsnvXdUQggc2ArXm3mnFnDUv7nCk7FdqKhD2noAC7tNlOduiFJyglo?=
 =?us-ascii?Q?yJMtOU3S7E1fZxzA6BoWMR+VbPX7E3x56oxToX+P1e16vp0Itbo7XO0Op6RB?=
 =?us-ascii?Q?z2/ijJStLmsjXIrvWdG5frbi+l/mmvj2Uao+5KOVcqY0qCMUpVl/dgQ++Xqe?=
 =?us-ascii?Q?mc0rOPvI/LV5h639yyDs0kfrQBJwlQGREpI7VqysF3X0sy9WlcPspC98a1ED?=
 =?us-ascii?Q?UYqd5mVATn5871+9QzoAtEn9OmPsM1jeKdJQ6RCd5MuZjKyiByHA271m5POt?=
 =?us-ascii?Q?Hch0uEyioTT/zdIbq3k601W7OATdOaRDgFeGsviyTCRkC1H9AzhNXFjwk9ir?=
 =?us-ascii?Q?MKFlVfUR3F4tSgJb2se6UbdXKuu9n5MKLSvKhloPFmcC1K3WRInQKbXKqUGv?=
 =?us-ascii?Q?j/dkVqvZ6awElxEwZIsHXi2vs8cdlVZ+jK0wESKbukTy7WRjV70fgD4YmVuL?=
 =?us-ascii?Q?wuX7ABrjWdL89QO4oZSQ3fhKL8Lgt7gGUAbCwtKeT7c/ktsjNrm5l0ZoAD0J?=
 =?us-ascii?Q?th1sBtAWdO+rAu6LABGvFyu36gkUN0n9DnXEC/iq5fYtTdpLuY33ClGBe6cT?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91340f92-752c-4740-ecdb-08dc9b57364c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:56:45.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VACYGzzoTItNQy5xKNVMTLGWjdcRaFXH88l595GosD3apAqrDqaxSZcPItmdvYPN8BpL81RZdf9QsmMtKuJu8y/dl4kwYqnPJsOfW+CrxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com

On Tue, Jul 02, 2024 at 10:14:54AM -0700, Tony Nguyen wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Extts events are disabled and enabled by the application ts2phc.
> However, in case where the driver is removed when the application is
> running, a specific extts event remains enabled and can cause a kernel
> crash.
> As a side effect, when the driver is reloaded and application is started
> again, remaining extts event for the channel from a previous run will
> keep firing and the message "extts on unexpected channel" might be
> printed to the user.
> 
> To avoid that, extts events shall be disabled when PTP is released.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 105 ++++++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp.h |   8 ++
>  2 files changed, 91 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 0f17fc1181d2..4d6555fadd83 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1584,27 +1584,24 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>  /**
>   * ice_ptp_cfg_extts - Configure EXTTS pin and channel
>   * @pf: Board private structure
> - * @ena: true to enable; false to disable
>   * @chan: GPIO channel (0-3)
> - * @gpio_pin: GPIO pin
> - * @extts_flags: request flags from the ptp_extts_request.flags
> + * @config: desired EXTTS configuration.
> + * @store: If set to true, the values will be stored
> + *
> + * Configure an external timestamp event on the requested channel.
>   */
> -static int
> -ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
> -		  unsigned int extts_flags)
> +static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
> +			      struct ice_extts_channel *config, bool store)
>  {
>  	u32 func, aux_reg, gpio_reg, irq_reg;
>  	struct ice_hw *hw = &pf->hw;
>  	u8 tmr_idx;
>  
> -	if (chan > (unsigned int)pf->ptp.info.n_ext_ts)
> -		return -EINVAL;
> -
>  	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>  
>  	irq_reg = rd32(hw, PFINT_OICR_ENA);
>  
> -	if (ena) {
> +	if (config->ena) {
>  		/* Enable the interrupt */
>  		irq_reg |= PFINT_OICR_TSYN_EVNT_M;
>  		aux_reg = GLTSYN_AUX_IN_0_INT_ENA_M;
> @@ -1613,9 +1610,9 @@ ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
>  #define GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE	BIT(1)
>  
>  		/* set event level to requested edge */
> -		if (extts_flags & PTP_FALLING_EDGE)
> +		if (config->flags & PTP_FALLING_EDGE)
>  			aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE;
> -		if (extts_flags & PTP_RISING_EDGE)
> +		if (config->flags & PTP_RISING_EDGE)
>  			aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_RISING_EDGE;
>  
>  		/* Write GPIO CTL reg.
> @@ -1636,9 +1633,47 @@ ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
>  
>  	wr32(hw, PFINT_OICR_ENA, irq_reg);
>  	wr32(hw, GLTSYN_AUX_IN(chan, tmr_idx), aux_reg);
> -	wr32(hw, GLGEN_GPIO_CTL(gpio_pin), gpio_reg);
> +	wr32(hw, GLGEN_GPIO_CTL(config->gpio_pin), gpio_reg);
>  
> -	return 0;
> +	if (store)
> +		memcpy(&pf->ptp.extts_channels[chan], config, sizeof(*config));
> +}
> +
> +/**
> + * ice_ptp_disable_all_extts - Disable all EXTTS channels
> + * @pf: Board private structure
> + */
> +static void ice_ptp_disable_all_extts(struct ice_pf *pf)
> +{
> +	struct ice_extts_channel extts_cfg = {};
> +	int i;
> +
> +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> +		if (pf->ptp.extts_channels[i].ena) {
> +			extts_cfg.gpio_pin = pf->ptp.extts_channels[i].gpio_pin;
> +			extts_cfg.ena = false;
> +			ice_ptp_cfg_extts(pf, i, &extts_cfg, false);
> +		}
> +	}
> +
> +	synchronize_irq(pf->oicr_irq.virq);
> +}
> +
> +/**
> + * ice_ptp_enable_all_extts - Enable all EXTTS channels
> + * @pf: Board private structure
> + *
> + * Called during reset to restore user configuration.
> + */
> +static void ice_ptp_enable_all_extts(struct ice_pf *pf)
> +{
> +	int i;
> +
> +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> +		if (pf->ptp.extts_channels[i].ena)
> +			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> +					  false);
> +	}

Still one redundant pair of braces. Just do:

	for (i = 0; i < pf->ptp.info.n_ext_ts; i++)
		if (pf->ptp.extts_channels[i].ena)
			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
					  false);

>  }
>  

