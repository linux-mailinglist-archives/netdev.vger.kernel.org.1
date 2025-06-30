Return-Path: <netdev+bounces-202544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9264BAEE3A7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA88F16FC66
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CE292B3E;
	Mon, 30 Jun 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwKc1uLy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF728C5AC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299757; cv=fail; b=JYT8FyNz++f2bpWo/LlH4NqU7dc5LciUa5u4w+Rd4ZrzsfXYd/ZKIQkROIoVCwxMF6M671cW2lfwCxPoU6S1EdENnK3XO4ImJlDFQ1NIHnpb+MmbX2kzTCEa4X0S4LVoYNxQA7Ik11Q5MjKJyIxrk0Rp5ljyipwWAFtbfNt1nwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299757; c=relaxed/simple;
	bh=kdNrgMQ6s+crvjWCeAalt0PG6KpwoylrcCbHlalSPd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHsfCTMSwMuSC7ihGb/hiAb+GqUPXeY3g/2Nkc8d0UJ6wiRvX2eCh3XI3H5baYRQcZtLnbZdNHAKBytr2mQJUeX6F7vZnu6bdzq2vjdV6dGkeKFh9WnDorMnHxZPrX+7TKONoyG+mXrR8WFMSLlwLiKEW5bsfXeowNYQZkKz0Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwKc1uLy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751299756; x=1782835756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kdNrgMQ6s+crvjWCeAalt0PG6KpwoylrcCbHlalSPd0=;
  b=CwKc1uLy+a9ONClN5anFYjWE3rl08/gT5lCaMdCM036okeO8g15OOt47
   cFzSslteRSA3k6UNFmwchjct6ngR4W2DWKqpbYX7ZpXdEiFMftETn30X3
   YklEEPqFRtdHRkaCWOnSoQwNHGB3p46c2XDTs9h/dPJmyAoHqvk3zcdjQ
   0vZBBxeGiEC7eKpmBGyBSjSQqaUbfPj1kPGZ6jbniTj59sRauKPZAOMEb
   E30wBLEHd9R8XwXWYzafQFAqBW4L4QHIoH00sZTlRFxcyLxNGNqyzPkvf
   LA/kijn0FUVCLK6gvDVlyC5U+tQumKAUup055dXtXiVM3bvQO9YBgFHei
   g==;
X-CSE-ConnectionGUID: zPr+OJFZT6KlLrnEGzITUQ==
X-CSE-MsgGUID: ExQM2SPOT9iPA2jbc5ECJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="63787633"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="63787633"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:09:16 -0700
X-CSE-ConnectionGUID: Tl3YFFj5R5yJljQtMsRuIw==
X-CSE-MsgGUID: UsO9kpfxQ5qmrc7Hmc36Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="152977493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:09:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:09:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 09:09:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 09:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3ku+kYKEiSlc7U5+9jXo06BiLIoxiGY0CbaIfsMZQalGN+RJ28ZGlh0MxI9V3ihze0xR88CcYwKWyp7Dxr/BEfWHeYL4sxtAM9A2xijlPSLUiMmoZZVRzu5V4Y2iQBsPRAcKGJrIsdfQoJfX/euFEoAMK7OXQkPcHvVlddRHcRBQnYxMs2aoViGZOCqJtVW4xxEW/2MxQlPpDepCYMT6qDiB8jEd8z9czUG9GcdpcWlqfg7ocdX2lVnjV0dfZcMAal+qVa3m7YzcYeG5CAeSKtOBIg9O23vh9ohCN+rxzqu9FxyBkccLQgfBm9xQ7lpuOe6naUQ0jYmiSEnuX8G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdNrgMQ6s+crvjWCeAalt0PG6KpwoylrcCbHlalSPd0=;
 b=AFIA5Jf5iDOF30nHLjN6ETV1sGLKL2brHC5tujEYfo5IozTbcDUB9hAgwrfaQyhfJE69XPadsFSCOAK8cwRcOBoCWUJm84nd5S5espsG3LbPjjCoiUqackBiqoM9ogShRvUnGSF5F8zNSoxt6aMsUH3pPySu1UyBRXXzGeCUNnH1h8pRfcqZcn5tT6RkffpG53g7HpjYEHOGjUKYe41skP7XUFPX0LxUrAfUqcdj7apdwzzKCiDsQd78bTMQDwGpVdz5JUUvcuxvPTSUInC3nnu9dTCbRDnoH3xdNXdygpzgShGohm0i9Rbu6L5zUaGwiSsSRCin5VUBkncwxxKT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 30 Jun
 2025 16:09:10 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:09:09 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Thread-Topic: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Thread-Index: AQHb5eraTLJIverxnUGFzGLsGjNTNLQUdh6AgAdn0ZA=
Date: Mon, 30 Jun 2025 16:08:51 +0000
Deferred-Delivery: Mon, 30 Jun 2025 16:08:32 +0000
Message-ID: <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
In-Reply-To: <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|IA4PR11MB9347:EE_
x-ms-office365-filtering-correlation-id: 57e1b286-c9a6-450b-dc95-08ddb7f07250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TE5SdVNiTGxGUCs4TkZKdEdBRU9JYyt1MGcrTzQvb0pWVXBrQXVFZThjMktD?=
 =?utf-8?B?Z1EwdWtoQ09jWGhUSER1dGRaMWppODl3UE4rdVpsb0VtbVFMZFdNQTEvVlVE?=
 =?utf-8?B?N2dGYi9mZlVHdm9WeWltSDI3Ukk0N3NpcGZLSFhIcC8xUWk3RmlvYWU4cW9v?=
 =?utf-8?B?N21DdUhReUxOM3owTkhBU2FTRnltekdibWR1S1d2Y29rcENMT0J2ZDlmMFVj?=
 =?utf-8?B?bTliSzJ3dXdOaWt2UzM3N3NOUmFsRG5nTjNQQ1oraGpxR0VFREZwdjMyaVBs?=
 =?utf-8?B?T3dnUFJkaXZwQmtkMkgyZjBVQTBSKzl3cTlPUml1bkVXbWRMRlBMcXhqRnRy?=
 =?utf-8?B?R2NqOXRlOHZRMXFhWFNOT1luQmdMbTlkTVgyR0xRRFczN2JHNDg2RnlXOFhS?=
 =?utf-8?B?am5YOHRHWUk5NHNGSU81QVF2QmJLK1JlUUZ1VDFsOTdNbHdtZkdSNWJxOFdY?=
 =?utf-8?B?U3F3djkzY2VWWi9FTjFCUGlacXdYK1krVTJkdDZIVmxtdnkrcThJVjdkaDNo?=
 =?utf-8?B?RUFmZG50cjh5eWpjS2xVMk14bkRGb2xDeE90K1JCclhXRThnVGhwWURhQndZ?=
 =?utf-8?B?KzlpOUs2U2U0eE1qbkwyZWpnVStJM01vMk13allrWktRM3dXL0cvdkJ0YVBy?=
 =?utf-8?B?UlhBWkFHekJoakkzTlBaZDFZcmZFOHIwRDVqY0k1bmhmdVdidzk2aStjclQx?=
 =?utf-8?B?bFM3YksxblNZN1hDZGNMM2NNVG1LN3gzZWZ3NkVyUHNVSUFmbS83SUh3NkN0?=
 =?utf-8?B?N2wxYjJxU1JSRjBPNDZSQTZxaWJzVTZmdTk4S2F6ZnYvT05Dc2xuUVRqUE52?=
 =?utf-8?B?dWV6QVdZaElTSVU5SHBzV3lCM3FpQkhYUm5JWmI0RWZSUDhGM3JTazNGbU5V?=
 =?utf-8?B?U2hjenA1MGozV0c1cjRSd2plckZNN2tZZkN0M2dRNStMU1hYN3FRZHNtZDlo?=
 =?utf-8?B?blovWjJlVHg0T0dwOTI1TWFDdE0zV3JTZVZPOVVkTitWV0NnaUd4b2R5VmM2?=
 =?utf-8?B?WitxMVpCSG43NzBtWHJERmZhTmNYU0xuRHlyQlFDNXRtTE5GMTZSSVNzUjJO?=
 =?utf-8?B?UWJXb1BuS2FkYUJjZnVjZHQ3WjcxWmhlYmtWbHIvN0w4R1JldXFXZGJhc0pi?=
 =?utf-8?B?SDB2ZGRnY3pZekJKYmRYWUN0bC9ZbFpmajcrWU0zVGdyUnhHdzZhU2NRd0RN?=
 =?utf-8?B?ZWdHSVF0VVpubERrZmJvUWI4ZGdnVWZ6Z3ZXY1BwVENQZEgrUU5CcHFXSm9G?=
 =?utf-8?B?T3hNRkh0ZldRaExGZENsclB6d3pQUFFPN3ZBL0xrZnJ2cGhmemlaUEx4U2ZE?=
 =?utf-8?B?VVI3U052NmZ5R3RUTEFJNEFVT1IzYzZkY0lBQ05lUDY5UkJ5MlFzZWdkVEh4?=
 =?utf-8?B?eE1DRzZJYmFna1lKbjFGK3N1ZVYrQUFJSDFOWWhsTTJ1UW9MV3kzZTRkdGJo?=
 =?utf-8?B?UW9mMERvUzNBRFM0RXFMRXQxTUYwWTFQSXdJclFoSittU3RIdWpDdkIyRjMv?=
 =?utf-8?B?SWFEUnRaK3ZPcUk1azlWRWNLdk9jeEtVQVdMdHh1ak93YWZld0hEUlZkOUJv?=
 =?utf-8?B?VllMV01TWm9INjZ6dERHRTVnL1BSa01MelJFeFY3eUxJZ3RGZnp1MFErTVl5?=
 =?utf-8?B?amxTSVZuNDJWQWdxcXNMMVhtWk9ZQjRwTytoeWFXRWxEcEl3RVNtbTgya3pB?=
 =?utf-8?B?N3A4TzdHcTQwWEVZcU9hQW9IU0hZSjZwanIyNXA3ZWtkOGpzcC93RElmKzJQ?=
 =?utf-8?B?RzczLzVYcVoyU2R4cnBRM1JWUzNtUUdqWjg5RG1lZzNTWk02d21nUU95RjBm?=
 =?utf-8?B?S2lJYkpvUG1iNjk5Ui9vTGVrR2ZVOG9WS1NqL2NyT25JYy8zR2VKMkNUbDMx?=
 =?utf-8?B?UzErTW9BcnBiZ29HdWtUWnRPYjA4ZHNTYmZVTnEwbUM1bU9XTlBPM21IMXE4?=
 =?utf-8?B?NURkNGs4ZEhEek54c3piNElGYUtOZmJobzNva2k2UkF5M2dFbW14V3NkdUFs?=
 =?utf-8?B?SVNOdy9QQk1nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFU2Wldvd2xpUWdDTlhzWFJSeUE5MS9lTXVsek9TZzJuMTFXVk1zSjFyQ3Bk?=
 =?utf-8?B?QnorTmNBSVFkVTlkRk45YnlrM3ByamorL1IwdzNGQlBvejBSWlU2OEJnTUIw?=
 =?utf-8?B?SVZhd2hkZCtXMEF5WW9DNkxTR2tpOTZCZ05Zcy9tNlhrQjBGQnNSUFVka3dT?=
 =?utf-8?B?dHJzS1BkT1RneXdKTThWbldnbEluRXVpU0NnT3NyQ1ZRalBSVjFleXArYXBM?=
 =?utf-8?B?dTk0WW1vKzczNDI2Q0U1YWRnNUVlWWhpQjQ2LysyaVoyZjIvQjQ1VDlhTmtX?=
 =?utf-8?B?ZWpMKzZJUS9Fam1jOWc0Zi9wWEhTZXBKZ0RNb3EvY3VwZk5uaFdyM1ZxelRP?=
 =?utf-8?B?MXVGRkhmZGRYVUpZUmV2eWR6Tjh4ZWx0TUdkQW0zbk5OSjZrN3lGQTMxV1l4?=
 =?utf-8?B?RlRCN0o3YlF4YUR3ZDZDNkdMZDgxWkhFKy9kU3JTS0krN0QxM2ZlN3FuYUFn?=
 =?utf-8?B?andVbTJBTTl2ZWtzcE5WZEh2VmdaYTZ4R05WeTNEa3VieGNuaGRCN0h6NkJX?=
 =?utf-8?B?VFVmaUxHKzkyaEhFejFua2QvU2pQZG1jWnhNOUJCSUNGZmN3a29vTHpXM05J?=
 =?utf-8?B?M2d0Y2hPM0tncWwxUm9CRmpTdXRqc1R4MXBJWFlLc3FmSWlVRE4wYUZSTHBU?=
 =?utf-8?B?cEdXcVRxRUpqM1lKMGc3NFhKb285NGVMWTBRNS83MFZKY2k2ZnJrMTZ1dk44?=
 =?utf-8?B?b2hKWlRCaXJCT3FNY2hqS1AwclZlcnlSRmVkeFBzeWI4MG1ZekthVDZFM1BG?=
 =?utf-8?B?RFZYaXJsNndkZjh4UFdTVjhyYWJrL3Uyb0xUdVNYMkpuQlpsdE1hTG5jSXZw?=
 =?utf-8?B?TGJ5NzJXdUdIakdMNDNtUEZ6R3RRdFRxbTEwRWVPcHBia2pkbzFKL0I2ekZC?=
 =?utf-8?B?ZHMwZ3FpcVFCRFB2WFhXZTBVSUhsNEFiV3RWOVVETFZ5K0dyY3VrNndnWEgx?=
 =?utf-8?B?eUdqN0ZDcVdhbkxveWY4d1lRWjlMb0tWenpLeHZyTS85R0ZzM050NEZPOXJF?=
 =?utf-8?B?eStsbldSKzZLcTJyeTJlSnVRWXhtTHg0c21PZTFsVWI1VWU3SGlHYlNyRUJS?=
 =?utf-8?B?TFFUL3ZVeUM0Z3pBeThtd0J5dytlWVRuVDVMVURBL3VUT1NKeHVkanFZNHNE?=
 =?utf-8?B?eWJCVWc3cXl0SHl6QkhDT1pNbDVzT0dYQnZ1SWdBaUxTTlRrMHBYSlcrUTE5?=
 =?utf-8?B?ZkhtR2FoRXNtZkNmaFNsT1BMbkk3UmNXaUJsZHpSalRXVnl1Z1NkZHBSdkts?=
 =?utf-8?B?Tk0xemhxQUJPOStrUnVCNmhNaEdmdk1ZbDdWcFdRaG5DZDZpaWUwWnJTV1ZC?=
 =?utf-8?B?RlRKYUFsWHdyL2Ftcm9zOWFkOTZEWWJHTFpVOG5WZ1hqTzd4aFZCTzcxdks0?=
 =?utf-8?B?elBOODBNVmFoYTJUNkN6SXVPaFRSVytjdkFzY04reVFpekFwR3BMV0RFSGI0?=
 =?utf-8?B?NjBIcG9iamxPS083M3Rod3JyTU9uc2NpaVlDZ09WQ09TYmFjejJERjV3VFJ5?=
 =?utf-8?B?czNuc0tLajVPR1h0eHdaa0M5N0p1dFEzUjJ3QS9kbUZCK1YwV0hyeFFBeXZq?=
 =?utf-8?B?SWFNOTJNUDBHV0Irekd4QTZCbUNLTEVZK2FYM1doT3N3N0xQWEdDQUhPb1R2?=
 =?utf-8?B?dzJ6UzdYbVNwZC9Pb1NjdE91NE9IRUVqYi9iZVRPd2IrOG9mbmpXbUQ5WFVa?=
 =?utf-8?B?SnQwVFZpbUo2SUhyc3lZSFdOeWdIRHRJMkRtdGFpMUhDZlgwU1NvTDVNY3pR?=
 =?utf-8?B?Wk85Umo2MUlhQXZQWDZxY3VpK1V5TlRQb05hWTNiazREVXZNQjU0TEZpVzRz?=
 =?utf-8?B?OW5vSWd3TzJRYWw0cDJoN3JVdG5uYURkQjJFRVVnY3FmSFVqQW1ueUJTeXBY?=
 =?utf-8?B?ZUYrNzhFeW9tQjVIL0NFWWdoSUR0azR1bG1hdi9pUnVORk82VXpNVkJVbEl5?=
 =?utf-8?B?a3ExWDM4WDVRVm9FSHZxbU1jc2h2cktvVkxIOG1sK05NUHRlS2h6ckJtTUdG?=
 =?utf-8?B?RHFsUGpJNmhEWkl3Ynd1dVNnaUQ1R2lCbWtkZlhvazczQng1d2J4UGtYbjBo?=
 =?utf-8?B?cGdWQVQxNU1JeVdoSTE0ZG1aWjd5UXd6NGpkZHZhUGtYWk0xeDN0RHprKzBO?=
 =?utf-8?Q?PJh7AzrJZL6v5Lu4cTTq7Abth?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e1b286-c9a6-450b-dc95-08ddb7f07250
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 16:09:09.3814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0CTbnkIQKTQXsAt2Qkxv2mUtBm+2IfX7eZQOXFxf9XEgOMNvpZSeF8f+mhLYGlfhAn2W97zG8V27C5mmJ3NIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-OriginatorOrg: intel.com

PiBEZWFyIEpvc2h1YSwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZXNlIHBhdGNoZXMuIE9u
ZSBtaW5vciBjb21tZW50LCBzaG91bGQgeW91IHJlc2VuZC4NCj4gDQo+IEFtIDI1LjA2LjI1IHVt
IDE4OjExIHNjaHJpZWIgSm9zaHVhIEhheToNCj4gPiBUaGlzIHNlcmllcyBmaXhlcyBhIHN0YWJp
bGl0eSBpc3N1ZSBpbiB0aGUgZmxvdyBzY2hlZHVsaW5nIFR4IHNlbmQvY2xlYW4NCj4gPiBwYXRo
IHRoYXQgcmVzdWx0cyBpbiBhIFR4IHRpbWVvdXQuDQo+ID4NCj4gPiBUaGUgZXhpc3RpbmcgZ3Vh
cmRyYWlscyBpbiB0aGUgVHggcGF0aCB3ZXJlIG5vdCBzdWZmaWNpZW50IHRvIHByZXZlbnQNCj4g
PiB0aGUgZHJpdmVyIGZyb20gcmV1c2luZyBjb21wbGV0aW9uIHRhZ3MgdGhhdCB3ZXJlIHN0aWxs
IGluIGZsaWdodCAoaGVsZA0KPiA+IGJ5IHRoZSBIVykuICBUaGlzIGNvbGxpc2lvbiB3b3VsZCBj
YXVzZSB0aGUgZHJpdmVyIHRvIGVycm9uZW91c2x5IGNsZWFuDQo+ID4gdGhlIHdyb25nIHBhY2tl
dCB0aHVzIGxlYXZpbmcgdGhlIGRlc2NyaXB0b3IgcmluZyBpbiBhIGJhZCBzdGF0ZS4NCj4gPg0K
PiA+IFRoZSBtYWluIHBvaW50IG9mIHRoaXMgcmVmYWN0b3IgaXMgcmVwbGFjZSB0aGUgZmxvdyBz
Y2hlZHVsaW5nIGJ1ZmZlcg0KPiANCj4g4oCmIHRvIHJlcGxhY2Ug4oCmPw0KDQpUaGFua3MsIHdp
bGwgZml4IGluIHYyDQoNCj4gDQo+ID4gcmluZyB3aXRoIGEgbGFyZ2UgcG9vbC9hcnJheSBvZiBi
dWZmZXJzLiAgVGhlIGNvbXBsZXRpb24gdGFnIHRoZW4gc2ltcGx5DQo+ID4gaXMgdGhlIGluZGV4
IGludG8gdGhpcyBhcnJheS4gIFRoZSBkcml2ZXIgdHJhY2tzIHRoZSBmcmVlIHRhZ3MgYW5kIHB1
bGxzDQo+ID4gdGhlIG5leHQgZnJlZSBvbmUgZnJvbSBhIHJlZmlsbHEuICBUaGUgY2xlYW5pbmcg
cm91dGluZXMgc2ltcGx5IHVzZSB0aGUNCj4gPiBjb21wbGV0aW9uIHRhZyBmcm9tIHRoZSBjb21w
bGV0aW9uIGRlc2NyaXB0b3IgdG8gaW5kZXggaW50byB0aGUgYXJyYXkgdG8NCj4gPiBxdWlja2x5
IGZpbmQgdGhlIGJ1ZmZlcnMgdG8gY2xlYW4uDQo+ID4NCj4gPiBBbGwgb2YgdGhlIGNvZGUgdG8g
c3VwcG9ydCB0aGUgcmVmYWN0b3IgaXMgYWRkZWQgZmlyc3QgdG8gZW5zdXJlIHRyYWZmaWMNCj4g
PiBzdGlsbCBwYXNzZXMgd2l0aCBlYWNoIHBhdGNoLiAgVGhlIGZpbmFsIHBhdGNoIHRoZW4gcmVt
b3ZlcyBhbGwgb2YgdGhlDQo+ID4gb2Jzb2xldGUgc3Rhc2hpbmcgY29kZS4NCj4gDQo+IERvIHlv
dSBoYXZlIHJlcHJvZHVjZXJzIGZvciB0aGUgaXNzdWU/DQoNClRoaXMgaXNzdWUgY2Fubm90IGJl
IHJlcHJvZHVjZWQgd2l0aG91dCB0aGUgY3VzdG9tZXIgc3BlY2lmaWMgZGV2aWNlIGNvbmZpZ3Vy
YXRpb24sIGJ1dCBpdCBjYW4gaW1wYWN0IGFueSB0cmFmZmljIG9uY2UgaW4gcGxhY2UuIA0KDQo+
IA0KPiA+IEpvc2h1YSBIYXkgKDUpOg0KPiA+ICAgIGlkcGY6IGFkZCBzdXBwb3J0IGZvciBUeCBy
ZWZpbGxxcyBpbiBmbG93IHNjaGVkdWxpbmcgbW9kZQ0KPiA+ICAgIGlkcGY6IGltcHJvdmUgd2hl
biB0byBzZXQgUkUgYml0IGxvZ2ljDQo+ID4gICAgaWRwZjogcmVwbGFjZSBmbG93IHNjaGVkdWxp
bmcgYnVmZmVyIHJpbmcgd2l0aCBidWZmZXIgcG9vbA0KPiA+ICAgIGlkcGY6IHN0b3AgVHggaWYg
dGhlcmUgYXJlIGluc3VmZmljaWVudCBidWZmZXIgcmVzb3VyY2VzDQo+ID4gICAgaWRwZjogcmVt
b3ZlIG9ic29sZXRlIHN0YXNoaW5nIGNvZGUNCj4gPg0KPiA+ICAgLi4uL2V0aGVybmV0L2ludGVs
L2lkcGYvaWRwZl9zaW5nbGVxX3R4cnguYyAgIHwgICA2ICstDQo+ID4gICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5jICAgfCA2MjYgKysrKysrLS0tLS0tLS0tLS0t
DQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5oICAgfCAg
NzYgKy0tDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25zKCspLCA0NjkgZGVs
ZXRpb25zKC0pDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bCBNZW56ZWwNCg0K
VGhhbmtzLA0KSm9zaA0K

