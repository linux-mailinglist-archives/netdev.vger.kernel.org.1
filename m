Return-Path: <netdev+bounces-301385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GdwfJTaROmovAQgAu9opvQ
	(envelope-from <netdev+bounces-301385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:59:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E01736B7AF1
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OEzOued6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301385-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A203097AC3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D07237F739;
	Tue, 23 Jun 2026 13:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6ED37EFF0;
	Tue, 23 Jun 2026 13:57:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223066; cv=fail; b=Rlw9A8HJLxxem/neuh5uitAKB6aiMTsJGzqzvPzG7W36G3LgZDOOQ+bsUtEQlOnK+fifD6vt6VHnDHFHVRgfLdS9VtIw6Hv0Fx+YEYLB3Fl2eX95FjPRaIFz2YiorFzCSMtPl74QqWeNJS2cBD8U8hYLkxZTLIR2uhnx51mg+Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223066; c=relaxed/simple;
	bh=wx7E/cohYdZ6WMD+rVvGQHdOan05mA/e9982xVQlw7Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFB1OIhJPyfncG+HfGPPhxy+6xReiHVf1sGvGU89mVpi/BKRaNT5MO8VEZVEp0mRaGvQ7dMGjgycoyHwzon49dqD17CWcrUr15mcYIpHhy04Gexumhz7Ihwc7jZCSjB0/VArZ67hDryH/53wGge+IwyKDsRLrXnY3C84x/Pfdc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEzOued6; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782223064; x=1813759064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wx7E/cohYdZ6WMD+rVvGQHdOan05mA/e9982xVQlw7Q=;
  b=OEzOued6Kiwlr2hgB+9RJmgWp0kTwZRMXV7ojt7hfsEANxhazM4YUJV6
   BKvOqFVd/ql23KFjUbl8JehDOsslxQi5oTr8hPNxEMZ2qdVfa9Gnu+e1R
   x9GjzexR+czyplcDCxg/tqH1/KqpfIVccF5O+peB84ZElK2oqU4Pbh0jZ
   by4Yt2zs3if2gMvOmnDGay560NTg3wXPK7RzSU4CH2ujU6t88wV19EWTD
   r2AWdOxbb6R5fTBxBcY8HuWECduRzO7hfJzzepUuH5+GwveveCvX2CVTN
   +lANurodVCafAZ9CVcdSbpBGVeydFVX+o0MdrXm0kBRnJ7jq9v+YUkKYC
   g==;
X-CSE-ConnectionGUID: C6pwc61hTW60CjR9+q23yw==
X-CSE-MsgGUID: ydn0JiH2TLietdlnCUoIcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="70482220"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="70482220"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:57:44 -0700
X-CSE-ConnectionGUID: L7GYosdZTQS9OBo2n2ooyw==
X-CSE-MsgGUID: iW5MuLsiQIy8jSC5oY+XnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254515201"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:57:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 06:57:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 06:57:42 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 06:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZdyBHX/nf2gGxtHeKTgRJUoMlDlWuECxe3gLyJtVz3XwLZ8HuzDPNwOXM4iOdq7vGfFIuu19uugzItw+uNGeaNZ8PaOB3MxgVrS6WetFmemSIL2DhnIK0edk33JDCH/sJah3rgjzpItU0arWuw+up5OtNW/iZUHc0UEfumxcB9fO8xvNJezj1qUC1MAuQJDPu9bJ0tT2muF4EZ5wqYOfXHiygldHCf9KcN4dwesRsyD3H5+c4np1bfhhCcWEFb36aaZ/MwuYmwI4eUubElSyu6nvP3/wyddpkSm+2o+G4CijyKniTMIJ+mUwCqzv/AEPAjJpcQ2ieOvbglnOMzDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tkyqQQV48eHsCaa9gwZE6RcGCcjU2j9NGPE2hQXnMs=;
 b=E+/5Pg47YeKLYRbknTaYTcNZ+tsJw42ukpG1NfkvGhNQmKryjYp3KQJ3jUOGze782hvuEsUsrfYzLBOgJmdEFTmL5vvZ5/crd+JydtSbjuPcY1EPGUznCy9hLf6pVX5ndFtHvCntsHQa97QiRb6T3phVgAHiYfNjEZKi3sgwZ4RB7n9bjVgmh2Hx2FAuP/N9obRbHhyDVBxbCvTSXg9aJZjdFWrzh/fT5XvRPDMWmvHigGkUGy0OpYRSOeXLag5adUuR7G9LxCdrWOWg1eQ9KTyrgRTRl2345HYAso1uldP0Kr7IkyyJdeJq49f/uA6+WOJHFqYpLwRUhl20SWAFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DSVPR11MB9577.namprd11.prod.outlook.com (2603:10b6:8:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 13:57:38 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:57:38 +0000
Message-ID: <ca20516e-fff1-47b3-a43d-78da2545abca@intel.com>
Date: Tue, 23 Jun 2026 15:59:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix stats array overflow when VF requests more
 queues
To: Michal Schmidt <mschmidt@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Petr Oros
	<poros@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260427151827.43342-1-mschmidt@redhat.com>
 <2106884f-6914-437f-84eb-262581b9fef7@intel.com>
 <CADEbmW0BsQsu1pPX=kk58tTz_5EArjCKgmp_MKxRFcuvb3TDGg@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CADEbmW0BsQsu1pPX=kk58tTz_5EArjCKgmp_MKxRFcuvb3TDGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1PEPF00005B95.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::632) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DSVPR11MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 87051195-f1c8-4152-e71c-08ded12f6294
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|56012099006|18002099003|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: PgV3onNlS3qjL+RFjCm+exFJqGQ6MIiUu4pia6WbpgMUyRpi4VEsJSncOJV5lL1wObOEQRPmFDKfRWT6Qdt6YlxCQ6erh2Tm1oIka7itGwWF6ik3pHznNOScn/9vuZGM8sv5JDxikDgUYLO25sJXJ6Ecs/+vBVjw16jLMsdFJm2kG1MNkgJEsUbx+bpbAbOdKqAL9UBcxKGpWesqZdFFlxsgnLoILaWwMDSC1r+6TFQpZnQHCGFNKBREs911SYrahSQrilJbDV5YQtDvibdH8OBOoKWZtwpi1AqWl01laKjnvJoswY7MLim1bL0xRgob8lNN2nq2vRfPIv9vwX3UiwRY0Hr53FhUJZ4vxvFZJgvN0eYAs0gFWWaEHv7oUBIR3axxvuBktzrSVVjbyVuAK7N5sNS0YdiDRuz+x6TVw603zLclLpJ69AVHGaCGKoyB30/GnoW33fb5wt/wdhczIDNVq8i6i5oJHH8twzYjX/lQmJb+RAUeHnk77wmFH4BstBepi4RlY/2vD3AoJlV+GNl6xgaILN2B6HP4ZKLSpXp8DAMAaF65qEBcRPRJyQYFdzodhq03skknz7XTdXNlEsKPrd1teoqxUrCNVI+i+pEY6lXzVFjxQO49YtyBEtaZgGiNo29n1ZnN3aiUwi8XxJRASaoZlVdYOAmTcqCRQqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(56012099006)(18002099003)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lPZmxJaDUzQk1IWjdlMUpOR3JhejFYRjRLYjhvb2VIRlhBNzJ2TkxJcCt3?=
 =?utf-8?B?bnlvUWRrSUFwS0lEZG9sbzNFR1NYd2RLNjU4MXRNdDdXSWdTVWRLWjQyeHUz?=
 =?utf-8?B?LzY3SnZod0tFK2dReHdlQmNrUXplaWZ1TnovdEZGT1BXWk9weDdVTThFTmVX?=
 =?utf-8?B?OUFtNWVrZXdmRWhYcXJ4ZTdYWVpHdWR5R29hVS9OcjY5dUVlY3htL05qL3Bl?=
 =?utf-8?B?dmZyU2huZ0tndG9uMzJKSWt6V29kTnJId3I5Vk5QeDhOaC9jV1AwRU1IM2x6?=
 =?utf-8?B?Rlpnd3ltRjNhNm9BVk1PcHZhb0MwKzUzbjQxWjdpUFZ5b2JNWGxvRkVZKzE4?=
 =?utf-8?B?V2dBU3NaeWRnM1BPUytSZXBTdzdCT0YzdjczeFBxWlo5RkNMQUk3T09WYU4y?=
 =?utf-8?B?bFZ0MkttbUF0cG5xZE1VamRwS3RBWnVwK3JEU25QenNyYWNUL3JpQTNIS0tx?=
 =?utf-8?B?Q0ZxU2Y2eDFhM2s2c1c0WkhxZktjeVpTRmIvZkw2VEQ0bnkxSkdET1pqVXQ0?=
 =?utf-8?B?aEFLa1dnb2FIRHRIeXJ5b3UxemNWK2hGN1VsVzhIemRxN3loYm1iTHFEUjZk?=
 =?utf-8?B?WHBMSTIvZFZwckdDSzgyYjlHSW45a3Z3WG5oNHdKKy95L0U5QTdQZmg3WHFZ?=
 =?utf-8?B?eVEyaWdOTDVpd2cwQzJKQ1BwSU5OeGhVT2NFVjh1enllT1dVVklOemtWeWxn?=
 =?utf-8?B?K2pXanpUakRySmlneGdxOHpnSG81YTQxRlVLcnFmVUV0aEp4S0tLdFZPMEZ1?=
 =?utf-8?B?QUN1QkJDanc3Y0tRU3NMcjBpaEtwVW1BTkVFR3hHWXhZcEN6MStSYTJRS1Fp?=
 =?utf-8?B?TnJ4QmhJTzVlaDFVcVUxOStJeXpCczQyc3FOcmRMTEpvcTZiMC9VaWFTbkpC?=
 =?utf-8?B?YjhSc3llbndJbG1nZmk2UzhKYkVyRnhEL3dldG1ncVlNeXNwNEJuQzFMdm1t?=
 =?utf-8?B?Sm50bG1MUGZ2akh0K3lleXVtcVBWZTFEa05xaUd0RFMzSjhtcjIvc0JDSWYw?=
 =?utf-8?B?RTZBUXVuOE9DZllVOHd5SThZdjM4R2UrelppSGZWYmdLUElad0NrdmRFNEFx?=
 =?utf-8?B?MDZnWnVFOEU4Q3NrQzdXbmRTSzdzNVZuK0g1UUUySjhKYU02UmdHd2tXUXl1?=
 =?utf-8?B?TjRyQXFZcGVuOGJod1l4TG81WWJKaW1wQ3hrTUNMT056YTNzczJxUDZpNExr?=
 =?utf-8?B?bzNRWnplM1RiaHpTQndScFY1TzlhTkMva1B2YVhpSmhaWHJuRUpWMFVJZ2ts?=
 =?utf-8?B?US9IaFVHaUxyUExnaEJYUUVpYUhKeUNiVFdVeEl3d0Q5dFpKN0hmOHA5UEox?=
 =?utf-8?B?WXJlTG9URlUvZWpUYytnUUIzN2lxbC9zcWtTRXZoRmkvVDd3OG9LWk93RzFF?=
 =?utf-8?B?d3VYTUpnOXk0OVJPdW1JMkdjSXFFeFdWSnd4V2MxV3daWUhsbUEwWDgrSXJK?=
 =?utf-8?B?aTMvT0FVR2RRcFdtVXZGSjA5cUdXK2p6cm5DWWFGdjBnOVpPN3B0NkpiS2tL?=
 =?utf-8?B?czE1VHpyc05DM2R0ays1MG8rcWhEUk1UdzYxMDlYMEU5L1F1MUxCT1F6WmZU?=
 =?utf-8?B?NW9ta0FFNENXL0hjd2lSWWRpMko2VG03U0plTGxSTlluUFZ2c2pjS3M2b0N4?=
 =?utf-8?B?YzZhSnU3MmxyWU9XdkZZRE5zR3I1ekc1UjRIaW5LdWZvVnZJY0RBYkNwSzBV?=
 =?utf-8?B?Q1lsekJGa0RUSXZkaDVWZ2xSdmRuRndBTDgzSzJOL0N6T2FJQkM5WjFodXc0?=
 =?utf-8?B?UmV6U2NzVzhpQVRIQkhSUWptVVNidytyU1RvanZoWnZuVjMraENWRENjd1NC?=
 =?utf-8?B?bkN5d05WRnByZkpmZm9kTWZOTXc1bE5uclY3RXgrd3NDejRLSU9BYmdZclNJ?=
 =?utf-8?B?Mis5UFBjdTR5VnBLU1g0Z2pDOHpNZi9hS3pucHZsM3IyblhWUG1sQkRTU2Vv?=
 =?utf-8?B?NnRSdWl2YzUyYnRnMDhwa0g5QmFySWdBcEVXUkU5d281U2ZiRHpQcGFkU21N?=
 =?utf-8?B?MzBwc3dJZDBmbUhtTnVmSVdzY3A2aGpZaTNrdVYyOHJEQVlTak84b2R0TEpV?=
 =?utf-8?B?Y1haRG9HMjdZVGpaUHFCSGdKRUxnMUkrVE92ZzFQbjBNazRiMGpYUGxsRE9s?=
 =?utf-8?B?ZXl6NG5CRmlHQXJRanFaQUJCcFpRNlVVNE5objU3SGNuSzR4cjdQTmJXMmdN?=
 =?utf-8?B?UzNjeVk3OHlzbkFHTUM2MWloMnBaazB4SUdXR0xBUnk5eDFMSXVrdVNnaGlU?=
 =?utf-8?B?UVExZGwyR3FVam1GS0Q4WEtwUi8wZVBjN1FoemduV3lUdTRYK0lpTmtWYmtJ?=
 =?utf-8?B?WG5YUEpoelVjUFpLVGlwVENORlZxQ29OaWZsMTEvenhZS3J6L05qYzRvazBz?=
 =?utf-8?Q?gMKeYHG+WftOJx94=3D?=
X-Exchange-RoutingPolicyChecked: UD185If+/EMfHFJjcd9VSNJzZVo5faJB/wC40HqRv3qlG6feOzOg2OyK+8CCPHBygHZKVyUk+obW26tjVXZhrXApYGK5ViNgoQ0NV8+NbF9M/M5QXAKDJPQyTibIDVHSNxIEEs3bBwm1FCa6XXcsGfCJZSdmNAKn4Sd2PizCguLkAKv+UOOiiPbMcrBgxkWWBZYxkPtJr04zGwqUzMldGgFCVBzYrNFTTxZset0asByFziqki/OmPoRijx5vEaBNp9JkJCGYv0wt8iZObat1W3NyptqCrmQAhUiLIPBB6oEu8N9G9n3vB2i0sYvm85LUNuzbNcVoUDJ8dk6G4RMCrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87051195-f1c8-4152-e71c-08ded12f6294
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:57:38.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO4gYQb/62e0pwqOsVqlLX9zgJpTcBQd+Xho6nOCbsjVDY/znSmV9hZWb9ATYlqkEtaLrM3XzYYHKGcG1zwj/k8qUwv1p8rSSyucQNMybv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9577
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301385-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mschmidt@redhat.com,m:anthony.l.nguyen@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:poros@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E01736B7AF1

On 4/29/26 23:59, Michal Schmidt wrote:
> On Tue, Apr 28, 2026 at 4:00 PM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>> On 4/27/26 17:18, Michal Schmidt wrote:
>>> When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
>>> ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
>>> The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
>>> followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
>>> stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
>>> alloc_txq/alloc_rxq to the new larger value, but
>>> ice_vsi_alloc_stat_arrays() returns early because the stats already
>>> exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
>>> alloc_txq and writes beyond the bounds of the old, smaller
>>> tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
>>> metadata.
>>>
>>
>> thank you for reproducing the bug, it is exactly the situation that
>> I was facing
>> have you tried with my proposed (unfortunately not public yet) fix
>> to just combine ice_vsi_alloc_stat_arrays() and
>> ice_vsi_realloc_stat_arrays() into one function?
> 
> I tried that now and the result is: yes, your patch fixes the bug too.
> Michal
> 

Hi,
are you going to make your patch more robust against on CHNL VSIs?
https://lore.kernel.org/netdev/20260523001618.1757240-1-kuba@kernel.org

alternatively I could sent my "alternative fix" which covers that case

