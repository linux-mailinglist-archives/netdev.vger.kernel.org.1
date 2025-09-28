Return-Path: <netdev+bounces-226967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62ABA6845
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 07:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B8B3BE807
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 05:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C511D5ADE;
	Sun, 28 Sep 2025 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nndp7QZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759B1A9FBE
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759036919; cv=fail; b=WklXXyiZvKVtL0IYC3l+Rhua6JIVA2GSKj9Sd3UBcKgH52qaNPruzhJezEgkJODydl0LV1FMa9QBovpP2Uz7sC9oX07GtZwpmEV38UNCMFMNwbcJf5SCKZD0orbV8Lmf3mxISKuYzB6gvV+v92oLjKWRDorppVJo+qI3tThNg9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759036919; c=relaxed/simple;
	bh=yanc8V7nfCDvxzQQggAd+PZNLv8o6tblOEu9x/AcLtw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Y6pnCuiVw5KZNzsfEderEE7LERHEoTLLsHYYzvEcIXQ9VeqpvQw65vPz6vaSsNx7MOUtjfN3HTNoXHxUS2Ok9h/C5Y5s8ixqfNYhR5Hs2jm8zp2JMZ3j0VVqMsuXhPgwzAItspCDviZe2kULDdmX1quv3tMFpa+rGKUJXhVxaiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nndp7QZN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759036916; x=1790572916;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=yanc8V7nfCDvxzQQggAd+PZNLv8o6tblOEu9x/AcLtw=;
  b=Nndp7QZNAeG5dBE0lNftvEj+FChwWA3rynfYWtCzpppGkFIZ+qR3+R/I
   2PggFC40Y5hTUYHHKsHSE++/dcKZBRGWnwoSkT7ySvNu2v+ExUDwIokIq
   aS88LH0X41rDBC8e26f70K47dtR85ihUM1HcyErnp2x25mpIZbZ5Wu6pP
   v/u0TUJrkgbMw9iH3n2cPl1X7zRQUYg4IVZw08ggsoLMA6ICwwjL/Ygsg
   yvGy1oN3Ks+zUbOEI7XyaTe4eVwZ5+px/yWC//N/uCvp8zCGrGrKQERGp
   Y3uBxP1TKIF5LwMnbfijLp48N/EKzVejKxTFC2N/zGa1XzTucvlT4Tj6l
   A==;
X-CSE-ConnectionGUID: 9l41vsneQnalzk0FNRjScw==
X-CSE-MsgGUID: TKQRqMGsT++KQ1UYV3Q0Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="78741740"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="78741740"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:21:56 -0700
X-CSE-ConnectionGUID: mSGmPjUtQKWQbWFPZBLoLw==
X-CSE-MsgGUID: k050YQe2Qb6pBAhi8eiLIA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:21:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 22:21:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 27 Sep 2025 22:21:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 22:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emJ0NNCttw38a91f0ZpTDjpj8r2Mk3fAg7RLQZGPocwLhcWdngxhe3lZPakKy9J2/r7Ehbf3HIE6WPbVsehY9/O+XKiJEbDVU1vZIRmkwlhoa32Me1SBh2J3kiKmYVQiJWnfbrmd3dF8WzeTEYqXnWL2Ck/WuTF5vSHWXhB5j5FCCw4D2tSHGrI/7oTuxRZdaEPb/fJnnT4H7aYU61xZkqGsindfnarEgLhLmftJnUbspA/z5Zu2hVXUsXsxBogDCTyMZjbfpqSTO7TpyYK3xyYlezUTaiVWi5pBuUyvUin8tXU3gbqlgsbgypMwHR0yxl0LohiRHfT/KB7WS/SsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrsnd6FPYmpRMCpUK3GIyTGlC8ixpug8GS0HlaBJ91A=;
 b=M3R00gwEbCa8dsjrb4lEOv8MZHC8Y/TTygjwblS4WzTpTNFXBiujpKNCFK3HGkmqKVbqdJh4uL4WHi/E7cKt6ECUfM97Kj/AIOBY8Ab6GghEh7Wnibn2U4jNjDfZTwsgiph5RK6RMutbLOCzFi1EcbivUgosHRM7JERu+cUe4Xw2TJjpZT79GQSlze0yX0A2oXw7eDQwZxRL/FcscXlVnSqSrbWFNn4R7BXpvf5UYD1+qqj1YbV5naaBDJlpu7eFEkT/aCf0c/87QqSav8Eij8u48XYRTm+C8m40MICAK2VqL8H+rwtrf/zMGQ9FwtnpgQ9A9H83upJVgo2oD3odqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 05:21:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 05:21:52 +0000
Date: Sun, 28 Sep 2025 13:21:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern
	<dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  4effb335b5: stress-ng.rawsock.ops_per_sec
 53.2% regression
Message-ID: <202509281326.f605b4eb-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 100a7bb0-9e04-4dbb-8c5c-08ddfe4eeee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5VNXsvpYMy3zwJlqcm8UR44dMvFcWfo+bGUY39Q0ehMWYx9cHZovbLuCsX?=
 =?iso-8859-1?Q?0o3xaSzFRKI4jtgfUCljehdBo3vkEvnF6Vw28ZCWV469vACwLM9SyNQzft?=
 =?iso-8859-1?Q?kX2gcu/clnviYkAqW6PtgASGUXXK9vaXlFMH8CZkZLGK4TD+vL9cgQzBO2?=
 =?iso-8859-1?Q?k+MKbsU/Yaq71xg6ZjRWaLljLIjBw88/sr/vAJTs3AgI4rUhSfv7sjXNv2?=
 =?iso-8859-1?Q?Uo+k0ltX5lTsPKyakpOp9Pfv6bCMtWm49i7+5cTm0EZxD/Qvtt2lbwCqTR?=
 =?iso-8859-1?Q?1g5DSMnKKdtC51UPrGWHVcX3TjevxD6V7bQuGCpNAZHUDIB69/U/IWermf?=
 =?iso-8859-1?Q?elqfbS6h6ZsuxW3VelVNERWJOwCPuy81pncPD3Ns0Ss+K8VImcd+sdYfsY?=
 =?iso-8859-1?Q?b+QHovrNQMfROssH7kre8Qf/cAFbZqdM2FKc6j6aIW5bE4S0CodqySCDvB?=
 =?iso-8859-1?Q?Wx7s+wOFTQP6R3aVxYawbgl3AgBDfNhWQpZpEw4RTKz6/6WMHPsrruVRTz?=
 =?iso-8859-1?Q?elUdJFgso/YAXq2GYjzjucqX2laIJJGnD8of0uSTxttJoADdzlaBqqGa63?=
 =?iso-8859-1?Q?R5igQZszG/eoYUZU1Cn60IKSuLbEBsO2MkUqGVkZpiruTp9IrBn68JyGGA?=
 =?iso-8859-1?Q?vpOLK/wVtX8MbJOX9QpeydwTU4UKmzIGkcTp42NVfxTYdGcYZ3e4p/yBTR?=
 =?iso-8859-1?Q?BN8NTzXK/NSKAJuqRBUUVx03JBN6DuJxirauUrVfiSSi3H2U0yMmSKphV5?=
 =?iso-8859-1?Q?2B+E3fNsm080/cTaVJ6aOpzqCx5yhN9Gw2w3n5A1u/5Ldey2YW34knS/zV?=
 =?iso-8859-1?Q?+2KVAp8ZNheaqKL1+pI6bfk7K2gxIj/Ee+9QeqfXcQ9bZ53U3J0bx+hGg1?=
 =?iso-8859-1?Q?+lnAYw1zHvVIUbgSFcA7OebiiFs3OmWjsaqt6BdEm8+W+p1HlMj6ZHXMU1?=
 =?iso-8859-1?Q?HfDgZBjf3WCWBva1XG7S0WfIM1AK6DPHpRVCZIw9ZROkSjerczxf3MoO1b?=
 =?iso-8859-1?Q?U9AD8W186IjUPAjmetBgiRF0VBm9NVkSutjzfJDrgW7lg8nkJDm+DQuufe?=
 =?iso-8859-1?Q?B/5zt/LY1Yc0vn62qHLUhVTfx6MsWfQlLShT5IjM0aV2UtjJGcJC0Fwh24?=
 =?iso-8859-1?Q?QEu1W1k192NFzxvM+Jk7NODtFiOu5QQYhL/2aYBNQBpxZIQP9qabeLV2zx?=
 =?iso-8859-1?Q?WXq1C5a9MlKwRfuGODtszesP3dEOXJNlWHjTz9F5iGPLqUDDnT3c9McHyY?=
 =?iso-8859-1?Q?CB/U6P0h1A7uyKR9BIVyiLVn37pRAmDMtuC/y4j3KGCH5MNNl2Y/bw5QDD?=
 =?iso-8859-1?Q?Sx0x7WOFG70ZiSmhuPs1wOwNNpPdQtTdhF1oCzdEyjO42PdBNBN1/5mAC3?=
 =?iso-8859-1?Q?v2vsaIfzYLvnyb4nT8q4zEYdH7xf24/YUD8QIrgbCUTtEXrc/Atx2494OO?=
 =?iso-8859-1?Q?ge8JCtv5bVPt5l55bYPmYCLMCq5yCHAnfSo2n7O3LHdhC6FilvGqG9BrTv?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2J2tFyc9BSuSMfpJRbe+FH2yasKjrgqtxeGCtiRlZUUjB52JRnSYEklueV?=
 =?iso-8859-1?Q?q5iOH026Q218ppGsR1gmIG23LsfCwNwwECn7B/I7qJOdXEsZixwJzBxra0?=
 =?iso-8859-1?Q?59zN97t1pXqWToJY2L769TIojJDsoeuUYslXlmEFtuyAQbdPGMaCr7LJW+?=
 =?iso-8859-1?Q?A7ldWRYwkN5grq+uxO54cO1R+yU7YZqFVWtC7xSy94vCAkeD0U9QaNHXF/?=
 =?iso-8859-1?Q?+6i+yTuryLrecGvc5hkvzvIDy36vGmU2wLtF+VPauwBwVIdHr2bwSZitEg?=
 =?iso-8859-1?Q?EtzRLD69DAnrq0l3BYD34oupbY5xOyOuOpZ39f/hCdgkdtgT2d+Mip7Ol5?=
 =?iso-8859-1?Q?3Wr4bN2yzTquiktpXXAUvUZNpb4afhFpt4QEMZLhUZklGSV5szA0/hYKkl?=
 =?iso-8859-1?Q?d0iQVUnYhZHxS+WzF0UQyJorrOPcH3Dhjh8mB6vG9AwkbCrCLgn6VacRet?=
 =?iso-8859-1?Q?7xuPtS7ggtHA154ba3GOd/V8l592uXqXkAAZ4cxXKgCs/4giswPFYEBnxB?=
 =?iso-8859-1?Q?t5gNs2SaaTxtl2nu+bh5XLQ+EKb5ldCHZNZrHDoYBeAgW124Vij8TP0Fjm?=
 =?iso-8859-1?Q?VhWuUVyMOk8+lhDlNh3dHBFNn34fm8oNp1W00YjjHXywk8JCJoEdbr/DPs?=
 =?iso-8859-1?Q?58hKGv/yGzZr30wEt2O+IKHn6ARrSVj32Bs5vVrPHgYP+6mwjEbN4dvQWu?=
 =?iso-8859-1?Q?+rEakQt1pWvpHAd/HgHZrdWNzqxyR3hXxysxxtXVNgA2k4emfuF7uNARtj?=
 =?iso-8859-1?Q?eDNufttbEkmzfHY29SkOp04gg3UI7he+L7t2Y27l/Jn3seP6anuaU5t4Bh?=
 =?iso-8859-1?Q?o1qLMde2qoAobezYhoOyaGIjMEyZyKo/c8xXWLAK6XQ3pJJokV9bc4GkK6?=
 =?iso-8859-1?Q?I9EJLte3cRw528z4XYE1HbCcTN3duBIr0j/6L3m2eSa7t3zQ1uVRNLBBp5?=
 =?iso-8859-1?Q?W/t8d2YcZdelTpztNvQuGkQVP23zo/oUB5FAcxKwcC6tlnljupZKv5ih4n?=
 =?iso-8859-1?Q?59ottwpTpKIKoBruwCauKrCssuKt162jZHQIG/ZLMqHdS1RzmBuuUo7BV2?=
 =?iso-8859-1?Q?W6+SRi6Ay4RiwfEcPpeWQZFtB5hcyBu5omoGiF9Lj+Mqth+9b5PrEOVrLR?=
 =?iso-8859-1?Q?bbPhj8aemcqQRckCKt6PMR0/wyJ5mIeXn7W+J7B+2CaIwXzd0vaQ91lCcB?=
 =?iso-8859-1?Q?rW55oX3LuYuHRtgk606VzSWDLXz7IFR5bplZbyIR6QmC2KdSWqZhUzn7xk?=
 =?iso-8859-1?Q?pIBNCH0B6cF2Qk/sOjRz5Ce/h7+p6U+6GPFa1l2/j9CyC6lHfH1Hl5c7OK?=
 =?iso-8859-1?Q?wYn4/jbciBVtD++Kt8m6IUgAUgRgAyjpoIQ5j3OlSO6Lh4e16oeorW5zhO?=
 =?iso-8859-1?Q?5sRyjkqLi8CfT+viw7iZDNFdsG5+lK8L4JsxKebPlo9D6GgpQHxjxmtmjM?=
 =?iso-8859-1?Q?Umdwy7reNLuV4MqJfoiGwxJiEk3obyiKf0m8KmWpGfq9A/T38d2N4R0QFU?=
 =?iso-8859-1?Q?ivIKh8ZgWLOt2Wi9hQoL78GU5ymSonwqX4mPUyTjl51EB1iek4TzaucI+R?=
 =?iso-8859-1?Q?RQEQ8tDv9t/4ZJDC1Fb3KNhkgd7M4dIz7qDgx89zU9xlY0gPg+kRxqUfY6?=
 =?iso-8859-1?Q?ZQtkxJdYjCjOGzmx1ZSsMfqXkfExtmqCJEMJ4vTnq7wyemHz07IYcRSQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 100a7bb0-9e04-4dbb-8c5c-08ddfe4eeee1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 05:21:52.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzkkrFjBLMir6i8ino5spzGZe6lLA6M2yNsFovOrwg3oRSj9+MHsNKMR/w4PP1/0KlxqUawPYHw27NeN7NiZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 53.2% regression of stress-ng.rawsock.ops_per_sec on:


commit: 4effb335b5dab08cb6e2c38d038910f8b527cfc9 ("net: group sk_backlog and sk_receive_queue")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master 262858079afde6d367ce3db183c74d8a43a0e83f]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: rawsock
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509281326.f605b4eb-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250928/202509281326.f605b4eb-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/rawsock/stress-ng/60s

commit: 
  faf7b4aefd ("udp: update sk_rmem_alloc before busylock acquisition")
  4effb335b5 ("net: group sk_backlog and sk_receive_queue")

faf7b4aefd5be1d1 4effb335b5dab08cb6e2c38d038 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.724e+08           +39.7%  6.599e+08 ±  3%  cpuidle..time
    370887 ±  4%    +197.2%    1102311 ±  5%  cpuidle..usage
      0.15           -38.9%       0.09 ± 44%  turbostat.IPC
    365.00           -20.0%     292.04 ± 44%  turbostat.PkgWatt
     20.18           -24.4%      15.26 ± 44%  turbostat.RAMWatt
      2.45 ± 19%      +2.5        5.00 ±  8%  mpstat.cpu.all.idle%
      0.77 ±  2%      -0.3        0.51 ±  5%  mpstat.cpu.all.iowait%
     72.04           +12.2       84.22        mpstat.cpu.all.soft%
     23.72 ±  2%     -14.2        9.52 ±  2%  mpstat.cpu.all.sys%
      0.78 ±  2%      -0.3        0.50 ±  4%  mpstat.cpu.all.usr%
      2.83 ±  2%     -52.1%       1.36 ±  2%  stress-ng.rawsock.MB_recv'd_per_sec
 1.265e+09 ±  2%     -53.2%  5.922e+08 ±  2%  stress-ng.rawsock.ops
  21105419 ±  2%     -53.2%    9879110 ±  2%  stress-ng.rawsock.ops_per_sec
   1706591 ±  2%     -42.6%     979134 ±  3%  stress-ng.time.involuntary_context_switches
    167007           -16.4%     139564        stress-ng.time.minor_page_faults
      4696 ±  2%     -61.0%       1833 ±  3%  stress-ng.time.percent_of_cpu_this_job_got
      2751 ±  2%     -61.1%       1069 ±  3%  stress-ng.time.system_time
     71.44           -54.7%      32.39 ±  2%  stress-ng.time.user_time
    107720 ±  2%    +825.7%     997196 ±  7%  stress-ng.time.voluntary_context_switches
      4.98 ±  5%     -21.5%       3.91 ±  9%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      4.98 ±  5%     -21.5%       3.91 ±  9%  perf-sched.total_sch_delay.average.ms
     24.66 ±  4%     -20.3%      19.64 ±  6%  perf-sched.total_wait_and_delay.average.ms
    183199 ±  4%     +37.2%     251374 ±  7%  perf-sched.total_wait_and_delay.count.ms
      3016 ±  8%     -20.2%       2408 ± 15%  perf-sched.total_wait_and_delay.max.ms
     19.68 ±  4%     -20.1%      15.73 ±  6%  perf-sched.total_wait_time.average.ms
     24.66 ±  4%     -20.3%      19.64 ±  6%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    183199 ±  4%     +37.2%     251374 ±  7%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      3016 ±  8%     -20.2%       2408 ± 15%  perf-sched.wait_and_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     19.68 ±  4%     -20.1%      15.73 ±  6%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    286434            +3.6%     296783 ±  2%  proc-vmstat.nr_active_anon
    105242 ±  2%      +9.9%     115646 ±  5%  proc-vmstat.nr_shmem
    286434            +3.6%     296783 ±  2%  proc-vmstat.nr_zone_active_anon
   2409442 ±  2%      -5.9%    2266894        proc-vmstat.numa_hit
    999.33 ±  9%     -39.4%     606.00        proc-vmstat.numa_huge_pte_updates
   2211541 ±  2%      -6.4%    2068937 ±  2%  proc-vmstat.numa_local
    109879 ±  3%     -34.2%      72337 ±  6%  proc-vmstat.numa_pages_migrated
    549890 ±  9%     -37.0%     346160 ±  2%  proc-vmstat.numa_pte_updates
   4067603 ±  2%      -8.0%    3744126 ±  2%  proc-vmstat.pgalloc_normal
    529475            -6.2%     496583 ±  4%  proc-vmstat.pgfault
   3743518 ±  2%      -9.7%    3380255 ±  3%  proc-vmstat.pgfree
    109879 ±  3%     -34.2%      72337 ±  6%  proc-vmstat.pgmigrate_success
   1929439 ±  3%     -62.7%     720154 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3052555 ±  4%     -46.0%    1647653 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.max
   1136911 ±  8%     -53.8%     524938 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
    342016 ±  5%     -60.9%     133755 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     10.92 ± 28%     -55.0%       4.92 ± 10%  sched_debug.cfs_rq:/.h_nr_queued.max
     10.92 ± 28%     -55.0%       4.92 ± 10%  sched_debug.cfs_rq:/.h_nr_runnable.max
   1929439 ±  3%     -62.7%     720155 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   3052555 ±  4%     -46.0%    1647653 ± 19%  sched_debug.cfs_rq:/.min_vruntime.max
   1136911 ±  8%     -53.8%     524938 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
    342016 ±  5%     -60.9%     133755 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
     10081 ± 27%     -54.9%       4549 ± 15%  sched_debug.cfs_rq:/.runnable_avg.max
      9761 ± 28%     -57.5%       4144 ± 15%  sched_debug.cfs_rq:/.util_est.max
   1460892 ±  7%     -16.4%    1221901 ±  3%  sched_debug.cpu.avg_idle.avg
    477384 ±  4%     +32.5%     632636 ±  4%  sched_debug.cpu.avg_idle.stddev
      1622 ±  2%     -50.8%     797.70 ±  7%  sched_debug.cpu.clock_task.stddev
     11.00 ± 28%     -55.3%       4.92 ± 10%  sched_debug.cpu.nr_running.max
      7423 ±  3%     +32.7%       9850 ±  4%  sched_debug.cpu.nr_switches.avg
      3621 ±  8%     +76.2%       6381 ±  5%  sched_debug.cpu.nr_switches.min
     30.25 ±  2%     -17.5%      24.95 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
      2.21           -32.3%       1.50 ±  2%  perf-stat.i.MPKI
 1.943e+10           -19.6%  1.561e+10        perf-stat.i.branch-instructions
      0.62            -0.2        0.42 ±  3%  perf-stat.i.branch-miss-rate%
 1.209e+08 ±  2%     -45.6%   65759957 ±  2%  perf-stat.i.branch-misses
     11.52 ±  2%      -2.6        8.92 ±  3%  perf-stat.i.cache-miss-rate%
 1.955e+08 ±  2%     -48.8%  1.001e+08 ±  2%  perf-stat.i.cache-misses
 1.713e+09           -26.2%  1.264e+09 ±  2%  perf-stat.i.cache-references
     36879 ±  2%     +48.4%      54743 ±  5%  perf-stat.i.context-switches
      6.80           +33.2%       9.05        perf-stat.i.cpi
 1.939e+11            +2.0%  1.978e+11        perf-stat.i.cpu-clock
      2055 ±  2%    +122.7%       4577 ±  5%  perf-stat.i.cpu-migrations
      3093 ±  2%    +107.7%       6424 ±  3%  perf-stat.i.cycles-between-cache-misses
  8.83e+10           -24.9%  6.634e+10        perf-stat.i.instructions
      0.15           -24.9%       0.11        perf-stat.i.ipc
 1.939e+11            +2.0%  1.978e+11        perf-stat.i.task-clock
      2.21           -32.9%       1.49 ±  2%  perf-stat.overall.MPKI
      0.62            -0.2        0.42 ±  3%  perf-stat.overall.branch-miss-rate%
     11.40 ±  2%      -3.8        7.64 ±  4%  perf-stat.overall.cache-miss-rate%
      6.80           +33.2%       9.06        perf-stat.overall.cpi
      3074 ±  2%     +98.3%       6098        perf-stat.overall.cycles-between-cache-misses
      0.15           -24.9%       0.11        perf-stat.overall.ipc
 1.896e+10           -21.0%  1.498e+10        perf-stat.ps.branch-instructions
  1.18e+08           -47.2%   62243287 ±  2%  perf-stat.ps.branch-misses
 1.906e+08 ±  2%     -50.6%   94253030        perf-stat.ps.cache-misses
 1.672e+09           -26.1%  1.235e+09 ±  2%  perf-stat.ps.cache-references
     35748 ±  2%     +41.7%      50645 ±  4%  perf-stat.ps.context-switches
 5.859e+11            -1.9%  5.746e+11        perf-stat.ps.cpu-cycles
      1945 ±  2%    +112.2%       4127 ±  6%  perf-stat.ps.cpu-migrations
 8.617e+10           -26.3%  6.347e+10        perf-stat.ps.instructions
 5.239e+12           -26.8%  3.836e+12        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


