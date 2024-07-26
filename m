Return-Path: <netdev+bounces-113229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9593D406
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823B72887C3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942917C236;
	Fri, 26 Jul 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNkb0pE4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420D17C23A
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999852; cv=fail; b=otOAU9D2chTOzmH8QqTL+L7D6ILW1+1NX51ZPI8cjSeDmjrJ2kfxO4AaAoaRM7jajFZS7YeDpgZ8PdC7CiB5fwo+ZBfV+34OjE2/JiMdIRW3BgHzBL/aKBhry+ts3PPvtHbjdwR+eMfsBf8htjp24zmsBeIj9TQpZjrLcLtxc58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999852; c=relaxed/simple;
	bh=2+9Nz/AdGFENezCzr+E/Z1NcX/j+xtOBntDxqRi9ZUk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E2sObExcudpobi62nB55H8rp0+8VB8DpO/6hy+Ox9gaeTIaXeIqkx+WETH1pwf3d70lARCmm5IjKL0+FUGdfPT1PGlQ2dd8Bzq7j6e4BZ0yleAb5F4g6Ymq5wAu1tFervp7FUwkQbb9gsqrSvFSiGmaEieHv6SzbCInoNUx2yV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNkb0pE4; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721999850; x=1753535850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2+9Nz/AdGFENezCzr+E/Z1NcX/j+xtOBntDxqRi9ZUk=;
  b=jNkb0pE4Lzck6uU4zVprgJTEhMx2z6WHIuSeZA0Srl4r5NSEUOwLq0/g
   Sg6GsEnYil4gWXmJSGeQFfzXhzkkqlyZNPaeUXMHVaDeTJBdvqz9Ek4ME
   24D0lJUvcPj9/9taC8VMJkSjQz23qc8ErXmSUYLtY5Yp+OAf1aq8IZACo
   0eEAH9DUGZGVybr7WKpQyip+7D/U8FqSdjZr0e/fsRPenRrJbB4NX/S0q
   Pz9LdRJlFuFYJJR2PvOqWSW7dhEZ/iMhaK8tEQCWb5fKG0+B6ZrsF49Va
   jCY2EXxYAwAqguNthH024RTKDyJlrYWOrsETpZLb7+Haey2xOoPpKhvMK
   g==;
X-CSE-ConnectionGUID: aqVOKZPpT2OeD/ug4DAonA==
X-CSE-MsgGUID: vua7bIAxSgeYJgAm0f+2Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23590675"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="23590675"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 06:17:29 -0700
X-CSE-ConnectionGUID: 3yHFVNwpQcO7IcOm0W2VaA==
X-CSE-MsgGUID: 3QHfUlQiR+yHwhCU88wipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53348088"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 06:17:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 06:17:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 06:17:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 06:17:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 06:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsrgcGAANtYaQRRt8D/L3urZOFu0OgFy3rXyZzze4+/QSCLlK9d3nybvYjBCd85Y2ZzzfK88y+ECErN1ydjjfdpP34Qcdz7dqgD2OMVJUzL7eBNtdmRZNWYK/Z8WoIb1rLg9N8L1VGr4CoB79X1Gb98VWd2uet8c438XIu+g9m1k1JDHG/H7FuY8wefjluZYg6BPhT3d/wAd/PYrWh6lo+TlggZqPRewl+GrRq5SGLt0GrYk6rQFZCQH1Li3NYtFa5kLglAaL5Ls932YqMxEy/TG2Gma9i8Vtmbrng0oAcp93n/jK66Bqc81X87FRh7NUu5doWBGXBAcr9KKIXSHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU2KUcHLoe06aSXUMiF20f2MaXsU3l402Ezu/6krFSk=;
 b=yomEVPG4h6Xt9JWr2UI/AWAX5p09s43jTO/JniaQgc7hrKo0hxa7MQ/DJOcmSTj63hI7R+50a4ibMdpi9718xU/WQ1puFc6FYjYyEGv4JcfyRzYCkNTqegr02JQvlYzjoA5Tt9ToyJjNUy+TAdahGQ6OWWrXWWuYmjW8lfeX95Jv8SFIZaAFr62f66romzw6jTa66Hgi4YWrNCC4KY9RWRMT40CBgjU3FW1T6fTv/cCd0hN2V6z+qWGZyjG1AAf6xrBnWDSOuSGbuZ2uYSgbep6f9Sx1qEmUJ0KctGJ+Fz+cBbtDo+JDCt06Kgs9yO/aMe8AFPHH3oaAX2/EGZhSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 13:17:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:17:26 +0000
Message-ID: <5fb6f2ad-6db1-4dd6-b985-19dd14035603@intel.com>
Date: Fri, 26 Jul 2024 15:17:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next 1/4] ice: Implement PTP
 support for E830 devices
To: Karol Kolacinski <karol.kolacinski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Paul Greenwalt
	<paul.greenwalt@intel.com>, Michal Michalik <michal.michalik@intel.com>,
	<netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Milena Olech <milena.olech@intel.com>
References: <20240725093932.54856-6-karol.kolacinski@intel.com>
 <20240725093932.54856-7-karol.kolacinski@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240725093932.54856-7-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0030.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: adad04f0-8255-4e20-90eb-08dcad754aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWhsQ1pEZVgwNG5TSWZzQjUxdmU5VTBlR044eWNBajJhbFlHVDdaMEdPWHdB?=
 =?utf-8?B?TTZneVhOTEJ2U1B5blBickZyWHVJUkQ0emhpMUlOL1JRMnp3Ukx5Q3Y5dUZG?=
 =?utf-8?B?ajNPSHhoRW8zd2FtS3hva0ZEVDBzVjBSUzdiWHhVejVYT1VzdUxYU0MxQjZy?=
 =?utf-8?B?ZUxmNzFrektKblMxczFCOXBscy9qNHhrcERRYzUzTGhHcDV4RmFKNklFVExW?=
 =?utf-8?B?cTFCZGFuMmdLK0pVWEQ4emtJdVhuOTVEVHlhR3pHTndyZm8rZHpQY1VpMnNN?=
 =?utf-8?B?QzgrZHorRUliSmcxUi9vZ1VQWXNWRFpXMGJNU082S3Q5WmZ2TEwwUkg1L2c5?=
 =?utf-8?B?anNWL0RMYmp5dGRkSS9JeFQyU2p6RTlOT2I4am1kSzlWc1JXTUtMbm1zbitv?=
 =?utf-8?B?Z1BLTUI2c29QY2crdytRVDd3ckl1RlEzb09vR3Z2eHZ3eE1iMlhDYjMwUUwz?=
 =?utf-8?B?WCtlV3M3QzVudmpsQW9BSm9ldG1sVTJhUGZsdEtlUWpHYVBlVDVDS3ovS2dy?=
 =?utf-8?B?dlA5VkVLYUVSNHRRdjY4cTlVa1F3WmtSbEIrY1RWTkoxOHBCQkZpOGVMcU1z?=
 =?utf-8?B?Y3RYZ05BOWgydTlzdHVsdzdpSXpqTmZlQmtsR2RwT1hwd3RBMjRIYWZCKzIy?=
 =?utf-8?B?LzhTUUFNbmxlUzFXR2l6dmpCNlFZTmVIdEZNTjRHd2VmV3ZFME96T3QrQ2Z0?=
 =?utf-8?B?ak5wWU9QdGovQVA5YTNWVTdITDc2M2xOSDl3REVBRDlYbFB1WFRBM3hCRHMx?=
 =?utf-8?B?U0N6bmpGVDNqYS9LU2dxblJpRENnVVlDUGNia3QzczQ0T2srendFZVJYSzNW?=
 =?utf-8?B?bGZWWFd3K1VDM2ZwMGFMM01jN3JnU2JVa1NRQklKYjE5ejJnZXhMUHRBb3Fv?=
 =?utf-8?B?QW9MbWZIWkZIWDE3bWF5SWdpbVlrUlh6S09qbkUvaHJkMHI3Z2grSDNqaGJS?=
 =?utf-8?B?UjExU3gwZkNCRzV5Z1hpNUZjSVdQVjY4Q2RZZWQrNjZGYUJTZUFNVkRDalg1?=
 =?utf-8?B?Y2dabldlMjJXazZtUGJLeXMvL00vS2lKVDBUSzJoR250bUR4NkEwMUhLdHNS?=
 =?utf-8?B?VkVMMFQwMzQzdVNHOUV0elVtdUJKbHdQbFFQVEw4WlVUcmp5VHFsNW52MUl1?=
 =?utf-8?B?L2UyNDB2SVRDcUtWWk1kaWJBalJoOUVOQWF5SjJBRUgrZi84UkJ5YkFuN0hp?=
 =?utf-8?B?YWRvU2dVWEs3NUhOS0hZc2ZrNk9lUHIrcFdJRVY5bXVFVzI1Zk9LSENycWpi?=
 =?utf-8?B?UDlaUW00Q0hsN1UzVVBxUW9QK1R5eDZNT3FCZllhb2NNQ3l5UlI5M0IySzAx?=
 =?utf-8?B?OW9XQ2JVQXFqSGtZaThnQnJ6bFJSK3ZTWVBnS3VjTTFrOXhBMGZaWmo4WG9R?=
 =?utf-8?B?NDdnWHNYTGJOTVQrS01LbXJaRTFGMUh2MHdBakh6aTFCMURrTW9EMnp6UVhD?=
 =?utf-8?B?ZVJGOVZ2elJNdVc5eWpMQTYzYXNMYUNOdVFKdmwzeS9YcjZ5Y05UMlUxSmds?=
 =?utf-8?B?Mk5wY3h3OXdaeXcva2xxcnIvaEowRjRKTVAyQ1d5SWlCamh2VHN6N2xwRCtr?=
 =?utf-8?B?SHg4eXZxeUpqSEhkeFpjUGZzeWtPSGVlWWQyK0I5WnYwRHdKdVBKY1FKUnlB?=
 =?utf-8?B?VWlPM0RmVTN2K2FzL1AyVDJXWTh0b2xweG4ydEFla3ViK2trTHl2ZHRzSVFj?=
 =?utf-8?B?UktmVW5NR1A1cnZLa1hscUcrbllxRWZJTW94eXkzakU0OWdlZFVoS25xMWZD?=
 =?utf-8?B?SzlKRm4ramc5NEdaRmQzbktmdlp0Rmk1akYzUDd5T3FLMUN6dGRHT3d4UWVG?=
 =?utf-8?B?bjQrZG93UzdwQVdTZjNuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emF2Q1l2UWVwZzRjOGtJZ2Iyc0Nwb1ZHdXdyZ1pGRm1oS01qVTV1Yno4VlRT?=
 =?utf-8?B?VTh4SWJmbzFycFZETUFjQk1YKzk2L0dQc1FXMDk3QUZJNnJpRmFUUFBiSWJB?=
 =?utf-8?B?TW1NMmI1V0liV0loTWZLbXhYTmNwbldhOU9nTXRxb3U1N2dYbUd1Q25oRWZo?=
 =?utf-8?B?QS90Q1JXNU1vd3IxU1dYMGphNGd3cDdCTG04UktGZm13UDRCbEVqOWRiNEcx?=
 =?utf-8?B?RjdIYzd1WVphZkZVVk1MSm9VeHJOeFM5NFVFRFdJVXBRQ2NTb3JIaTM0dWh5?=
 =?utf-8?B?MVhmamFiUTFsSFhJUkU1OExrSmZEU1ZqWFVrR2JpS2d0SFZUdU9sNFNrMXFB?=
 =?utf-8?B?cCtmb1M3WGF3Yi8xR3RyWDh1aEs3V2l3WHhNdURtMTZPNjFzdjJYdDBFV0cx?=
 =?utf-8?B?dm1YYXJoQXljVElGZnZKSXF1UEZIMHFocHZxWUlXUHQrSkN6T1NhUWhUQW42?=
 =?utf-8?B?dlBPVlFEUWlMdFdxOGlaOGVkQlh3ZVZQeWJ6TVI4cEo5SG5VN1NQU01oYW9Y?=
 =?utf-8?B?bU9hOGlzbE43Z3p4Mk16aVFQa1dqZStZOFNSUDA1UGljN09wTzBXeWY2dkNo?=
 =?utf-8?B?cVZrY1dibTI3czJQWUliSGVOWWZxbU5mOVZLeEJVcXh1cXRZNlkwaXZvTHZ1?=
 =?utf-8?B?SHhBZGZoM2JVa0lyRGd6MjdxUDNTUGVMbzFqdHErTTV2ZFFMNXRGcWFYK3lz?=
 =?utf-8?B?RDZISzZQNDVOVlYyaUpwZEt0SHpITHVrNkw3R1Fia2dYRGRWNHlRUFZwWE4r?=
 =?utf-8?B?N01Sd2VISzlWaGlmeDVheEhxbGdGbFRrWVhrVzNvRVpQTW1JcUlaN2RONk5F?=
 =?utf-8?B?Z0VrYkt1Ym9UWG5NY2ZMZTNVcEhjWjJGemYwYnFLYkpuQ3RDbHNlNmVKVTJ4?=
 =?utf-8?B?Nlg4aWdWQ0J4TUtRb21iNWZsZHV4aWtQSzZnQk1WSG1sL0s0Y3NYc3B0UHhy?=
 =?utf-8?B?UW1TUnBFQ2M3cVdLVTh1UlZzRHk1ZU51dVZPZFNmdFhLaHh1eVp3UnRWZkdw?=
 =?utf-8?B?RXZhQVZkUk53aFd3M1c5YWpDSHE5a1FhOWpRVDhEcFR5OVpURjRxeHRzTDZE?=
 =?utf-8?B?eVBHa2dZY2I2MXo2ckw0ckdSWWRhUHNvRGpEM3ZhaHhpUzc0QTU5MGFJNi9S?=
 =?utf-8?B?OW50TVUvTGRpb1AyNUdDcXhWeVVzOGdoNWRGblptOFRrdG51N2FxVmI3V1Vu?=
 =?utf-8?B?SWJUVzNzQzMzT1crd1d5MVlaY0FZcStmZXI0emNGZ3RTMjFrRUtCa3UrOHlX?=
 =?utf-8?B?dSszNUhCK1lML1FRcTFHMFJzMStwTkFTakVSaGE5djlVeDQ1Q1A5MUlOVDlw?=
 =?utf-8?B?RnlZL1MwLy90aE0xWldrSWpZRExIWnlmd1ZzMk90YVRDLzRYWkVibk5mRGVs?=
 =?utf-8?B?TzZucXpxMzZiNlVaeHQxRmlWTy9ISmdJeEZ2dXU5VUozRjZ1K0VHVjRYeUFh?=
 =?utf-8?B?RjlIVUNKQ1AzU1lVVmhRcmJuR3IzL0ozcE0xb09PK0V5TXFhSkFDbkZhQUFL?=
 =?utf-8?B?TjYxUTN3dmZNREtpMnlRL3RPNUJ6WHBkUFNKRzd2by9kUUcyYzU3NmR6azk4?=
 =?utf-8?B?YnBPRmhPOCtLVWYwMFdxRVI1ZHVqUG0zdlJLd0dVQVJ1Mnc5L1dxZVlNQjlu?=
 =?utf-8?B?RlNxYlloRFpzWm5FblFZRy9DUGJTbmtNU3ZKU3lMcFRxM1BjOGVsMXMvZk1S?=
 =?utf-8?B?eGhqOEVDS3NOV283WEd6Qk42R0FJY0RLSytza1dpbWVraWNQWWcrdWYwd1dj?=
 =?utf-8?B?R0xabGd3VGdUdXd4MUp3R01ZUzNTcU81SUdqSnBORCtQOTM0bDJOMWx5aW83?=
 =?utf-8?B?L2l1aElQY0psemRxOWZCSXd3anlHbmZKdjZKOHBZa0lDMkJ4WllOcmlvYmZ6?=
 =?utf-8?B?Q3lvamVlekRhbXpHdk9hNU04RmZiMGltQll2SVRNaHF1MHlpdHkvZ284Mkcv?=
 =?utf-8?B?Q09vazB2bkovc3k2Y0JERmhuUGhqY1RiUHhkNGF5c0NOV0JRVXdNT0F5MzIr?=
 =?utf-8?B?WEd6WHorL0Fpc1A1dW9iZFRFTUZFUUF1VG93b2tEQ05YZk1Gc3FBYnBSb2N1?=
 =?utf-8?B?cHZJbVRQMkdTcVFVSDBaRjNQeFpTQmgzbXRUai9pSG9WQ2JkNTZXMGIzQWVt?=
 =?utf-8?B?T1ZFak1oS1ZIY1c0ckU4U3RGVW5WQnBuRjh2L2piVThGeGU1anFnZmszNlQ3?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adad04f0-8255-4e20-90eb-08dcad754aca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:17:25.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hN46v5IKWq1akpm0PHdi+rEmH3Cx/F9C8g9S3DRKcYI+3U3GZ2EYzFe43fA0sSDRpPlD/aoJo51sv6VdKcecYn/+h4FN3i2apmeGf3BhBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Thu, 25 Jul 2024 11:34:48 +0200

> From: Michal Michalik <michal.michalik@intel.com>
> 
> Add specific functions and definitions for E830 devices to enable
> PTP support.
> Introduce new PHY model ICE_PHY_E830.
> E830 devices support direct write to GLTSYN_ registers without shadow
> registers and 64 bit read of PHC time.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V2 -> V3: Fixed kdoc for ice_is_e***() and ice_ptp_init_phy_e830()
> V1 -> V2: Fixed compilation issue with GENMASK bits higher than 32
> 
>  drivers/net/ethernet/intel/ice/ice_common.c   |  13 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  11 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 199 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  7 files changed, 226 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 009716a12a26..8bff63d3d664 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -267,7 +267,7 @@ bool ice_is_e822(struct ice_hw *hw)
>   * ice_is_e823
>   * @hw: pointer to the hardware structure
>   *
> - * returns true if the device is E823-L or E823-C based, false if not.
> + * Return: true if the device is E823-L or E823-C based, false if not.

I'd move this, together with FIELD_{GET,PREP}() conversion, to a
separate commit maybe (one is enough).

>   */
>  bool ice_is_e823(struct ice_hw *hw)
>  {
> @@ -307,6 +307,17 @@ bool ice_is_e825c(struct ice_hw *hw)
>  	}
>  }
>  
> +/**
> + * ice_is_e830
> + * @hw: pointer to the hardware structure
> + *
> + * Return: true if the device is E830 based, false if not.
> + */
> +bool ice_is_e830(const struct ice_hw *hw)
> +{
> +	return hw->mac_type == ICE_MAC_E830;
> +}

I think making this one check external instead of a static inline only
increases object code size. Can't they reside in the header?

[...]

> +/**
> + * ice_ptp_init_phc_e830 - Perform E830 specific PHC initialization
> + * @hw: pointer to HW struct
> + *
> + * Perform E830-specific PTP hardware clock initialization steps.
> + *
> + * Return: 0 on success
> + */
> +static int ice_ptp_init_phc_e830(struct ice_hw *hw)
> +{
> +	ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
> +	return 0;

Can't this and the below functions be void since they always return zero?

> +}
> +
> +/**
> + * ice_ptp_write_direct_incval_e830 - Prep PHY port increment value change
> + * @hw: pointer to HW struct
> + * @incval: The new 40bit increment value to prepare
> + *
> + * Prepare the PHY port for a new increment value by programming the PHC
> + * GLTSYN_INCVAL_L and GLTSYN_INCVAL_H registers. The actual change is
> + * completed by FW automatically.
> + */
> +static int ice_ptp_write_direct_incval_e830(struct ice_hw *hw, u64 incval)

const @hw (below as well)?

[...]

> @@ -5474,12 +5618,14 @@ void ice_ptp_init_hw(struct ice_hw *hw)
>  {
>  	struct ice_ptp_hw *ptp = &hw->ptp;
>  
> -	if (ice_is_e822(hw) || ice_is_e823(hw))
> -		ice_ptp_init_phy_e82x(ptp);
> -	else if (ice_is_e810(hw))
> +	if (ice_is_e810(hw))
>  		ice_ptp_init_phy_e810(ptp);
> +	else if (ice_is_e822(hw) || ice_is_e823(hw))
> +		ice_ptp_init_phy_e82x(ptp);
>  	else if (ice_is_e825c(hw))
>  		ice_ptp_init_phy_e825c(hw);
> +	else if (ice_is_e830(hw))
> +		ice_ptp_init_phy_e830(ptp);
>  	else
>  		ptp->phy_model = ICE_PHY_UNSUP;

Since at least most of these functions just check for one field, can't
this be one switch-case on that fields (if you open-code that check)?

>  }
> @@ -5570,6 +5716,8 @@ static int ice_ptp_port_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>  	switch (hw->ptp.phy_model) {
>  	case ICE_PHY_E810:
>  		return ice_ptp_port_cmd_e810(hw, cmd);
> +	case ICE_PHY_E830:
> +		return ice_ptp_port_cmd_e830(hw, cmd);
>  	default:
>  		break;
>  	}
> @@ -5640,6 +5788,10 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
>  	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>  
>  	/* Source timers */
> +	/* For E830 we don't need to use shadow registers, its automatic */

							   ^^^
							   it's

[...]

Thanks,
Olek

