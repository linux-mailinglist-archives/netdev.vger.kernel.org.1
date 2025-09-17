Return-Path: <netdev+bounces-223937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44272B7D8E7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A054E486E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BED34DCD8;
	Wed, 17 Sep 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKWgRLHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0034AAF8;
	Wed, 17 Sep 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103327; cv=fail; b=tLZw0gCMP2IBiMjtmG4T/2imlAuyEJXVj17Ip0fu7fhQUtGQTogw3tddixQCwkhoiguvNrNQG58CI6DjOqooG9FXN2dfQxr6uTj6qAMJBxCfVzMZz+nr7+sPP3FsgKRFgBmckFZ0rPeZr7rkyqGzCaU/AsU/3Uy6AirIRgZb4/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103327; c=relaxed/simple;
	bh=uqEfiDBAzTF5Bizo6lBhcWut/BNtvfhC3meo4b47yA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFvY0oINR0/mE8eeyJBLqogaNtc+t7t82synOnm1+G3KOD/mF35x4y5kcCM7PIB4RBNP6GTWTMdadOQ5oQCkAISUaO1pQn+wqb5NkmXatvZH0LyNEaRggbenM+Wn9qEa6K4HD0PrQWl04hNkPLgYSlf3nu4o646Czi3dxU1glkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKWgRLHQ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758103325; x=1789639325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uqEfiDBAzTF5Bizo6lBhcWut/BNtvfhC3meo4b47yA8=;
  b=MKWgRLHQWG84AGigJhAU+/PTX4omCeTV6wpuH+gqEvcUqQgkx/1UXZTb
   aNAf38VkTWhOuCppg/D5At5hVbzEciMDZpKe6XsPu9Z6yab3D731ht6mi
   ntDbgO2JZmWpWDxZyzquIplDzstxy/8mX33YASF1RGGeiJlmxQG2Qacip
   wrcZ54w4555hkee86v2OQdrPEfq58EtGXaSJHRJK4XoSy0V/yC9a3on5y
   JpKSQPE/Ylk9nvKULGIpUCB0OfNGwGhD2ArCTnvOnIIOvQk50Rxx6BLOs
   MCysLgCysQRbm1lpkbPKX/Pa9iJBXQq3hxVzKnijjhwLSen+id+0L6ypl
   g==;
X-CSE-ConnectionGUID: 3l4Czu6TQTW11Ys9ocYKsw==
X-CSE-MsgGUID: REJnhDG9Rl6rULbB7Kxwbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60469004"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60469004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 03:02:04 -0700
X-CSE-ConnectionGUID: omBMim24RVixcbsrlEHxjg==
X-CSE-MsgGUID: NAhNoUuIQxqTMA4+OveF8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="180338055"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 03:02:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 03:02:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 03:02:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 03:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU2IW8qfXfWc54HEoczuVJ73Jt3oey+6lzT87VTQQkqifpQUxkGuhjOX5Jo9bg7lsI7QK+O0Vz/9DOz4iP3488ZwFYKYPBwo/RRMWf6qMwugEUSKEHm3BIeZuBqjYVlmuAxuAj0zcVCP4PJ1eMCgSCWSZx4c5LhceBuMQ7FFlgV2L0XGi+elSjIJbudvwmzOADRJTT3Nug0657jVFdDHM9uSEdTdkZY6bYHgoz28epc/SBcwn2X8QNHt7M2tO23Fk+KpGr56A0TvAM3ol0ArhxsgMmM90iZVzTpiSvQZhi2hY2td9uc0PklW+9yA2zaC9cE8Ls+CFU9pA12pAjI5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqEfiDBAzTF5Bizo6lBhcWut/BNtvfhC3meo4b47yA8=;
 b=wVX+1UMJM/pxYWQbozDt0aBgS/jd2DaCt1dh0EV6rT5Mg1ogRMAzHnPReXxN49Ocbz4I3tFsXZwlCPX00CyF7sWK4clhqf89kzz5dqMZJTZkDKRIgTBuUqwfTtmaVyBtb5YSF9lur2dhiP/HZ1OOtgqEFYtYvnM1FMhUxHSu1NXStZP0G3aJjn+So1+/B7dVvzGBukqeUux58JGT52weeNUvNd86JEholuf2h2CZ1pYCKxqOgRkvrb3J+/tNMlyTkXA+sARb4/2a+KWGBz2Aqle86yUsmBnpKpga2SMeEjyC+dXPdadZmtcXpxwb3YF8FWfRVx2bqv+VRobU16tFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 10:01:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 10:01:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] libie: fix string names for AQ
 error codes
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] libie: fix string names for AQ
 error codes
Thread-Index: AQHcJ0X4aIlxQUaSk0KVCCxkJFUBMLSXJX+Q
Date: Wed, 17 Sep 2025 10:01:53 +0000
Message-ID: <IA3PR11MB89864A81AB23A4AD5A246991E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916-jk-fix-missing-underscore-v1-1-a64be25ec2ac@intel.com>
In-Reply-To: <20250916-jk-fix-missing-underscore-v1-1-a64be25ec2ac@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8058:EE_
x-ms-office365-filtering-correlation-id: 91a7d909-9ca5-4a5e-6317-08ddf5d13a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?M0lSN2VuR0IwZm5XbzRxZG51YVlBSVRjRVZ5dTNGckppcGhwWmpkeTNHdDEw?=
 =?utf-8?B?WmxjYzhPQTFqMnVFZnZZUnladDhjTW4xY0tESER0V1ZMTTRObEh1VVVQTVNI?=
 =?utf-8?B?TVE4Nko5cFJtcEhtbjIvS2tTWGd0ZEdJTWF4UEIzRWhjNHJzM0t4NlRTN1JZ?=
 =?utf-8?B?RWEzTjBYZE1RY1k1TXBaMFNhUzIxdkJVd0ppTzBTVXBsSzlBdHM2TmNlUXhL?=
 =?utf-8?B?cTRvdTlUYlhXaUxpSEhmNThnWVlnSENzTm1USG10QUFtdENQT1hYVkJtT21X?=
 =?utf-8?B?RXk4SXAydTBPS1d1Nk9oUHZ5K3BhRk1UL0d4cW1EOUxqUGxWSUVhWG0wQm9B?=
 =?utf-8?B?blUyczVxSWFldm9FTWZRdjJTWlRaRzdIbGJQQUs0VDlFS29LSFNsMGF1ZURh?=
 =?utf-8?B?eUJOU0l5U0FQWGdXOVhDUll6YnVId1dFekQ4VkwrK2RuZnQ2a2lkZzVwOFh5?=
 =?utf-8?B?RXQ5MXF0RVV0Sk5jM0NHUXJKV3gxVFBqVzhQTytZdE4rWDV0UHZIY1dqV1BP?=
 =?utf-8?B?cXNYK3NZQWpWcWhxeGUvV25keEZmMEthVlQ4VjFyZDAwdm10clIwUXVUK1BL?=
 =?utf-8?B?d2RIWHIwekphdkZCYzVXYkZUWDFtTnMwenpvM1hpN04wcDFlWjFzY0xmY0lI?=
 =?utf-8?B?REE0Mmd3K3JiNmFkTWlhREt3NTByMTh2dUdJNFFncjI2Y0JudVBIWUZiY2x3?=
 =?utf-8?B?YUcwcnpVU3E3SWw5ZWhoYTdISDhvcXgwNnBzdnBhYUU0NEJmNWNoMVlDV3NW?=
 =?utf-8?B?ZVdMcnNVQ0JmZmhnRkNTMllVVzhtaFkrc1FlSnpFRUFXV2FGV1ZOSmdMQlNq?=
 =?utf-8?B?a1F1ZjB0OGowZWVNblg4MU1xKzYvYmQxQWN0Zi9OZ056eXdkWTJzT0VUd0ha?=
 =?utf-8?B?UnNicjdQSkoycjRFanVWTXF6cC9xUE8rZXZ3TTBNNTZrRG93bG10SVZ1Zm9Y?=
 =?utf-8?B?d2JhWVdBRXJFclZsVXNBQkZaQTdiRG9VWFlKSnNNbGViMUlxNHBrdnhFYmF1?=
 =?utf-8?B?YlFnK0MrL1RwNnROR29FTWpJWmFmVVBVWVNDOFhtQ2psS2labi9uL1BuTTVZ?=
 =?utf-8?B?bkNpQ2pKMXRDQi8zWlV4YmNsNzdZWXpCS2JTL3NxUjA0RFYySHVFZFdzYjZu?=
 =?utf-8?B?WHRmNGVIOFNIRTJ0Z3IzcUYvNFVoaENMS2U5NitPK2RWNDRTUCtqZWQ1dVJD?=
 =?utf-8?B?RHRTZGk4WElRSi9IRWFVTU8wOVZiYWhaeWdtZjU0OFFZdHhSNE1mN2taRDVo?=
 =?utf-8?B?QzlIeWdlUi9Sa1NVT1g1d3VyRlB5cTVEUWI5Q09hd2h4YmtsZjF6czkzRTZI?=
 =?utf-8?B?cnRKTEZNaWJRU1VYcnZMZ1Q3NzdyakZPR0RPZWsrUHVuRGxMM3dzTXpab0pZ?=
 =?utf-8?B?UFc2U1AzZXVoWVVDQjgvTUR0QkYxRmNJcWtyNTRseWF5aEdVaE5peXY2aHlV?=
 =?utf-8?B?dWQ2UUMxR3htbldlRzhNd244YXE3RitiRnhmTDlKNm1QY2s5Q3oyaFM0L0Nj?=
 =?utf-8?B?YzIvaHE0bGNyZnlOaVg5bXVtV1dTRnBMZlU0UnFCNG4vMStvS205Zmw5czl1?=
 =?utf-8?B?SWRURHFXUTFWN21JR3VhdDExdncxVGpkZ0tLSGtkSnpybk9panIyOVYzb3dB?=
 =?utf-8?B?ek94U1pHdkZLbVJtOUt4NDFKUjN3aHJGVWZPa1RrVC9DSnRGZGhDb08vYVJK?=
 =?utf-8?B?dkRPc3VmY2syYU1VVDI3ZjVxN04wcFlhYzVibFJ6eTdjK2w2NmZ6eGZlQjFx?=
 =?utf-8?B?Y2FZeEpFOW1mYmE4M3BSME51VEIzemxRbkw3djNrZVE3amJRc2dIMVYxdjVB?=
 =?utf-8?B?NkNmd1Ayd3BKM09kdHArVllOZXZhUlA3emdzZlBVT0NDMkFDU0IrcHNPdFRH?=
 =?utf-8?B?OVh3b0NwbmQzZW03aFNSVEdzWEwwSmtEVFVtalRzVTd0TVFRNVVsSWRPVTNT?=
 =?utf-8?B?UWVLNTRtTHViRkdBZnFxRUdFK3VpSDVUcDkwUFcwOTF5OTMycDFHTE5KVHo3?=
 =?utf-8?Q?f2sMvRkBj1sOdv6pVt7Y5m9QXE9HP0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXdPbzcxOVVEL1AyQXhGejhsRmlEQ2d5TENHcW55NGpsd3hHQU1YMThOTnZP?=
 =?utf-8?B?SVVFRDlkNmFyd1hEbXdjTDUxZFNxWndoeklmMkE2U2ZOL2FSa281bFRkZkNS?=
 =?utf-8?B?Z3c4WEdKaGZ1cVU2NUdCVVRqREQzVEY2S2RTa0RTMHpXV0dYTFpjNUdUOHc0?=
 =?utf-8?B?T0ZCMjBjaE1BK240Zi9BaTU5VlFKRUZ1RXdsQzVocFp5NlR4Qjh5Qjh0cWRY?=
 =?utf-8?B?eEpGZ1VkRE9QZGQ2L1NQUi9qZE9OWlplemNDTXZkM3c5NFhNTnpMZUtDRlVH?=
 =?utf-8?B?RlZZQW9rSk44d2p0SE9sQTRoMWVhWUpMSEtiREJtNnZwa1ZNaUZnejFldDVz?=
 =?utf-8?B?ZjlENE5VVzI4OXBjamZ5MjlDaXlIa1FNSWRaa0RBUTU0R3ZaOTJ3RzFjU3Zu?=
 =?utf-8?B?L00rUDJNVkVjS0JFUktteW4zTlpaZnR5TVlHZ29qQVhpVFQzcHJaK09PZW9W?=
 =?utf-8?B?c2xrM0E3emVxM1h6ZVlQY21KUWlUVG5XanQzQXE5bTQ3K0Z3YTJjQXMxeE9s?=
 =?utf-8?B?Yk9PTzFlMlQyOC9tZ3hkSmpTQlNiQzB6QkFROGhzajBPR1NUWllhYzIrb0g5?=
 =?utf-8?B?akVVa1U5dmNBdWpXRGlSK3kxL0dVYThKM05vWWE4R01IVHpBUEE5cWJwcWdS?=
 =?utf-8?B?dGlVVU56a0p6VVhOOGV5aEVEM3pZNEJWSFA5eVE3OEJKTHJTN0FPb1pTZm1F?=
 =?utf-8?B?K0xvNVR0V1M3ME1ROEcwNGtxMTA5dyt0UTJ2SXBIWG54SkRkaDVBN3RBSWVl?=
 =?utf-8?B?M2kraEp4dEcwL2dPQytKdTFEb3RWRkYvZjFjMm5WQjJqS29YbXB0N1lndDNQ?=
 =?utf-8?B?MDJnU3FvYVcrb0gwaFJOazFBWTRzUEZVenJpUUp4SU1lYy9LcFRSM0NqZVV1?=
 =?utf-8?B?bnFabzZEKzN0elZveE9DdmFjSVRKc09obzQxcm5iUkxCb1JFdHdnTUc5bytz?=
 =?utf-8?B?bWFPSU9nQ3QvT08ranpiRFdHWXNscHlFYnNxK0orL0lOa1BiWVFQNGVSOWd1?=
 =?utf-8?B?K1pBeEgwNWh0VHYzNDFIL1V2QjZ2SzJNb0ZYS29vS0wrMWNIdkNha3owdnZZ?=
 =?utf-8?B?Ni9YVlBXbVdLbGxXZ1hKN0t6OTZTZE5jYk50ZHFWUFhhWmhwN3I5YjVNN3Rl?=
 =?utf-8?B?RGFyOFhMaHMrcEgxbmpOSFVGUksvbVQ1WVRHUnA2WWUwL1c5Yzd1Zy96SmNn?=
 =?utf-8?B?enA5WVloM2F2aDVTeUN1Q3U2dEhsTlNoc08vYzlmWVVwYllyQ3hMV3dVRjhu?=
 =?utf-8?B?dDc1eEYvcUJoMzgrNWNUL2RkRXBnaFRGTTJiUGo2SzY3SHh5RVlTY1lJVTlQ?=
 =?utf-8?B?dXZGRmNIMm9VYUxaS0hFTXNGMnhRTm84bkY3MWpVdWlSWlhzcWFtMmplak5s?=
 =?utf-8?B?RWRxS3htZjhQUnBSTVJSOE1JS0pNMlRkdVQ0cStmNkpMZTZSVWJOa3cwVUl2?=
 =?utf-8?B?S1orRjNsaDJTZUc4UkJxNlU1d1RZV1BRWm9pR2pqTWZHSGl6RVdFeXVhemhs?=
 =?utf-8?B?SjB5cWlUNTVYdHAzWjFERkN2ZWtpaW9DT1kwYkVoQ1I3K2tFN1VOOTdUeVdk?=
 =?utf-8?B?ZjFlVTBDNzRySzQyQytnWTZnWTZVV2N2dEdqYTBJVEFJU1dOc2lmTWdhYkdP?=
 =?utf-8?B?bjNJQnprVjZtRFArajJSQTVMaWNLbDdFcFlvQzMydXpTUWVCYWtRWnkwMDBa?=
 =?utf-8?B?UE5XMFE2R3JITUxnSk5Ham0vaGtnRGZubnVMSTJ2c1ZvQnJLR3dOVlZMK3pm?=
 =?utf-8?B?QjJBOXZSZWg2NlVXSHY4aHNSN0NTcTJVL1Ura0lKbEZjN29ieElsYTQvelB4?=
 =?utf-8?B?bE1OVEJGNXVaWXIvb2pQaVZmdHVDNzB0RENWYmZXSTVSL0E4bkN5MXZ4d2NQ?=
 =?utf-8?B?TmM4eVhCQXJJSU9aQzEvN1ZJSU9PZ3h5U0N2aDNtSnJKZEI1c3Z3NXZtcTZ3?=
 =?utf-8?B?VVdpVmJoU2tYOXErVHExdEU4WktZZWdXa1Ezc0FYR20zaVloUFFxZVBBdk94?=
 =?utf-8?B?VGhOeStybGJtNTQ3UElLVVZCTFhEay9TeGd1c2dMOUxTQldCc2xreEtlYTdv?=
 =?utf-8?B?T2puYjFyK0xEUEdvaXRJNXZraFVtQVNMSkxvaHovS1RoOUNCM21JYTJGQ205?=
 =?utf-8?B?M1Z5MEl6TGRseUIyWHoyS2ZZcGVtT0JILzl6UHZtUE1DOVA4MnZmUVBtTWlZ?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a7d909-9ca5-4a5e-6317-08ddf5d13a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 10:01:53.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaP6dqIKV9AM8L1FwVchT2WBLgjmMhMBQavwNiD2LVs0zv/OGqkZzrSuX+42+tWR+c14wD5UHKIJb1t7MaDuvGc7oMYgpuRrVzZgB7Idqh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSAxMDowOSBQTQ0K
PiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0
c3plbCwNCj4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IExvYmFr
aW4sIEFsZWtzYW5kZXINCj4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+OyBBbmRyZXcg
THVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBk
YXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVk
aGF0LmNvbT47IE1pY2hhbCBTd2lhdGtvd3NraQ0KPiA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4
LmludGVsLmNvbT4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRl
bC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV0XSBsaWJpZTogZml4IHN0cmluZyBuYW1lcyBmb3IN
Cj4gQVEgZXJyb3IgY29kZXMNCj4gDQo+IFRoZSBMSUJJRV9BUV9TVFIgbWFjcm8oKSBpbnRyb2R1
Y2VkIGJ5IGNvbW1pdCA1ZmVhYTdhMDdiODUgKCJsaWJpZToNCj4gYWRkIGFkbWlucSBoZWxwZXIg
Zm9yIGNvbnZlcnRpbmcgZXJyIHRvIHN0ciIpIGlzIHVzZWQgaW4gb3JkZXIgdG8NCj4gZ2VuZXJh
dGUgc3RyaW5ncyBmb3IgcHJpbnRpbmcgaHVtYW4gcmVhZGFibGUgZXJyb3IgY29kZXMuIEl0cw0K
PiBkZWZpbml0aW9uIGlzIG1pc3NpbmcgdGhlIHNlcGFyYXRpbmcgdW5kZXJzY29yZSAoJ18nKSBj
aGFyYWN0ZXIgd2hpY2gNCj4gbWFrZXMgdGhlIHJlc3VsdGluZyBzdHJpbmdzIGRpZmZpY3VsdCB0
byByZWFkLiBBZGRpdGlvbmFsbHksIHRoZQ0KPiBzdHJpbmcgd29uJ3QgbWF0Y2ggdGhlIHNvdXJj
ZSBjb2RlLCBwcmV2ZW50aW5nIHNlYXJjaCB0b29scyBmcm9tDQo+IHdvcmtpbmcgcHJvcGVybHku
DQo+IA0KPiBBZGQgdGhlIG1pc3NpbmcgdW5kZXJzY29yZSBjaGFyYWN0ZXIsIGZpeGluZyB0aGUg
ZXJyb3Igc3RyaW5nIG5hbWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IEZpeGVzOiA1ZmVhYTdhMDdiODUgKCJsaWJpZTog
YWRkIGFkbWlucSBoZWxwZXIgZm9yIGNvbnZlcnRpbmcgZXJyIHRvDQo+IHN0ciIpDQo+IC0tLQ0K
PiBJIGZvdW5kIHRoaXMgcmVjZW50bHkgd2hpbGUgcmV2aWV3aW5nIHRoZSBsaWJpZSBjb2RlLiBJ
IGJlbGlldmUgdGhpcw0KPiB3YXJyYW50cyBhIG5ldCBmaXggYmVjYXVzZSBpdCBpcyBib3RoIHNp
bXBsZSwgYW5kIGJlY2F1c2UgdXNlcnMgbWF5DQo+IGF0dGVtcHQgdG8gcGFzcyBwcmludGVkIGVy
cm9yIGNvZGVzIGludG8gc2VhcmNoIHRvb2xzIGxpa2UgZ3JlcCwgYW5kDQo+IHdpbGwgYmUgdW5h
YmxlIHRvIGxvY2F0ZSB0aGUgZXJyb3IgdmFsdWVzIHdpdGhvdXQgbWFudWFsbHkgYWRkaW5nIHRo
ZQ0KPiBtaXNzaW5nICdfJy4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9s
aWJpZS9hZG1pbnEuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2xpYmllL2FkbWlucS5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvbGliaWUv
YWRtaW5xLmMNCj4gaW5kZXggNTUzNTY1NDhlM2YwLi43YjRmZjQ3OWU3ZTUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2xpYmllL2FkbWlucS5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2xpYmllL2FkbWlucS5jDQo+IEBAIC02LDcgKzYsNyBA
QA0KPiANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbGliaWVfYXFfc3RyX2FycltdID0g
ew0KPiAgI2RlZmluZSBMSUJJRV9BUV9TVFIoeCkJCQkJCVwNCj4gLQlbTElCSUVfQVFfUkNfIyN4
XQk9ICJMSUJJRV9BUV9SQyIgI3gNCj4gKwlbTElCSUVfQVFfUkNfIyN4XQk9ICJMSUJJRV9BUV9S
Q18iICN4DQo+ICAJTElCSUVfQVFfU1RSKE9LKSwNCj4gIAlMSUJJRV9BUV9TVFIoRVBFUk0pLA0K
PiAgCUxJQklFX0FRX1NUUihFTk9FTlQpLA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA5M2Fi
NDg4MWE0ZTJiOTY1N2JkY2U0Yjg5NDAwNzNiZmI0ZWQ1ZWFiDQo+IGNoYW5nZS1pZDogMjAyNTA5
MTYtamstZml4LW1pc3NpbmctdW5kZXJzY29yZS1lMmZmYzdlMzk0MzgNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gLS0NCj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoN
ClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT4NCg==

