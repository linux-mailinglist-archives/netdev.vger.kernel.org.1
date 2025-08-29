Return-Path: <netdev+bounces-218122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BCB3B2C2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E520A16868E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470321859A;
	Fri, 29 Aug 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPKwT7Dc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B67404E
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446981; cv=fail; b=MwuiSy+8qKDacS+LCjPeHsLMdK8bPQTb1uzQkwPeRUXJ5ULAXVVuzGhr5vAgP2CLGJPcf+SxlJK77VYHE6qaGG+T0XjzAjOVrJneyy4AJ/rvJiVr2I4t3NU/XXJWFjjpZ/AaK2joLVaZxm3kBqmlDVHVVDo5NczbeBSMxKfHZVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446981; c=relaxed/simple;
	bh=fRRLMUKpxPZdAKiFsZ5hkYt3cXJ1PSzI5LDsnRM2e0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+vc59V3D5xKXbiHyfc1HoojCgm+4j1LuLWeoCsPxLD4Y8cYYdOiGP77WJZO13hFiZoZKTaUjPPZDWJLNMO8ZnRjQviQ62eX6X3EHCQY+7uAemVY4GOCSkuISQrgQ946OkBTpd7iuDfMRViSosv438TbjJ/RePNEuGpNAgjWvag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPKwT7Dc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756446980; x=1787982980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fRRLMUKpxPZdAKiFsZ5hkYt3cXJ1PSzI5LDsnRM2e0E=;
  b=HPKwT7DcTNcqELXA8rlyKjj3brWLdJtByyAzVoiglgy+Kek73xJM6bjl
   NHM8tLIW1jGLZcyOrz9s4IJb2OihNOd/8DEeUb7UVWM0TYB/ZfjIdM7GL
   SkmBb1hS93ReDCm/sI6qD6v3V0qgiY8sR5LO81OjT1PI7FDf5wTV5NelR
   rn9CCQdgyjcFtAXr+sNx6yOgAfF1i6b5qwKp04yqLohm+aYlQaC9moOnw
   ts4HJ7z6/0P4gnJ7LhiYE8nxb+Rm7YbCqN2gHUKiUz5I8B7fhAuo7vg4w
   DPGC73h26TOsMNciTG3zw4+r1MrjzCTOz5dFTQdD5T9ZQmqTyCdyZgwAu
   g==;
X-CSE-ConnectionGUID: 51NudRnVQvagYfI0Kr1kMw==
X-CSE-MsgGUID: cosTepiHRnyiRlsfUif7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="84133959"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="84133959"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 22:56:19 -0700
X-CSE-ConnectionGUID: QAPhpiIFQZeNUr00/82b1w==
X-CSE-MsgGUID: pmqhY/3aSISgUH1wLZNEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169558259"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 22:56:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:56:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 22:56:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1JzJ1gjzuUM6FfR/VlB8xdwmn9c8kE9O5cxZ0tF4rS6t1tPKWCMCsHwACrCLAzXcJ2uL7oHtGfCN3UNnQPJuapx5Tja7JBnkgIfGwgl8BVgaiBbKQTg7oWs4ia5yaqDN/Tx/VaCITLyjOdgoX2DPSxuHvfJikrkEzj0j5sE99Mvw8/qbW0JnTIlVmTxXnRSljDz1Lt3XZNHygmTJUyjglUwm2ItxLtQCO/9307mPj/VDuQZRgAslaNASq45gcSOsPyIPxR86sM1BuKLKlPYeOUoMuPWqT2pEBTqtJ0oEhQvbNcWfS+loJq8EGweXTYSbx3jBWCeN/+BEHc94f8EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRRLMUKpxPZdAKiFsZ5hkYt3cXJ1PSzI5LDsnRM2e0E=;
 b=O+VJiLOveiGHFZCmB/i4qzuPecym2sMXb5acquvx6AdEcmMd5nsSVqIt7R97YyshqiZ90sSh8eMe5SjGDVtlUfx076c1jSNcdsRLeAE1Nm2uYyEVMjyechAyfx/i4is0QS7br1UqywQJz8/y5p+Qt8BJmhEXY1N7OOyec1rO3NFn6dGNt5VdtmT4LOvqcjVfH/sc1jqaOlETigT1hguQqiRcp2e7o9ZJvKwZPdhzP/IB7liSXhgI/N1/0ovA6+jTl3X+HrsfCNfpKemClk8RiUNTtrsHfGU6PK+jCXQP/312nqHUFO74UdiBsbjn/bgdQrNWlk0ETr2ZOS7e6r5PNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 05:56:04 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 05:56:04 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: reduce number of
 reads when getting OROM data
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: reduce number of
 reads when getting OROM data
Thread-Index: AQHcBSZk/g6Rjit97E6HBaDUju+Mi7R5SEfQ
Date: Fri, 29 Aug 2025 05:56:04 +0000
Message-ID: <IA1PR11MB6241A3A4DC211E09280747B38B3AA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250804094156.1690216-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20250804094156.1690216-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MN2PR11MB4600:EE_
x-ms-office365-filtering-correlation-id: 42a05bd7-f467-4ba7-cd25-08dde6c0bd74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?8Mjp8oz2tLChHok/II2PewWrkfd+8aSnL9RjqdGbLzg9BoBB/MDhVSPvPtB+?=
 =?us-ascii?Q?Q0viOjj0voGobGMcsWjLlIZb9Zrpx99r9SFJBaPXQJ/2ZnqP66l6oFO2dtIm?=
 =?us-ascii?Q?4N+MgL4lfz9mO86EAMIqcHSIGHhGgjuHl+9vcMy4vgs5ReLvJMz4KdNpvp1W?=
 =?us-ascii?Q?9qx7Ei7L5HHxOZyC+EPXaEUtGX4YFqH+GYmSXdJ7XE9bKAVgBTZB1i1sv5W9?=
 =?us-ascii?Q?2ci9pOKKMSoumufCd8l1tXBfWfyl08U/SQBMCsju/8Z6yOTkmljLBAzFzEqO?=
 =?us-ascii?Q?6pghrC7GkOvmMPQdoq7Knx3didEpkMQtTK3EH+ldBU7gRnJZcZ90uXKNvVSa?=
 =?us-ascii?Q?QzdCZ43GLRaF7Wn5JmK9T4TRXgE3+X/nIBUZnG8lQPQhXJcFqq+wtFt4G9TS?=
 =?us-ascii?Q?OelbZyDqOeW64XHZ0N/UZ8mYgKiKeERayFdd3GNEyxVqm+Wmh0HUb3e/b33B?=
 =?us-ascii?Q?G4uXQ2ci27qso8VSntJXkZZ8sDOPCc8kfWRMweSUPLG6ChXOIFA5KgZ18U7r?=
 =?us-ascii?Q?2M6X17DsMXAMihXOux365cvJ60Qh1OxTEScYVYikAlIw3GjoKs0X9hnX/e3B?=
 =?us-ascii?Q?T/fvhUefFAzmwjgNGSCYWOcPptd+mgqmdir9Au6QncjC+gNJpl4B3j/fikTP?=
 =?us-ascii?Q?y9+mixLhBFbiJDaFROOHfCW2zeR+/kDJy+SXHYYtnzUal52FWPIoqgKeiLjF?=
 =?us-ascii?Q?U+K67aV6S/JtfAHn5gx4XlWIkE/4xwe8fn26whr4hKrxZ6iCa9wkyTrJLnLl?=
 =?us-ascii?Q?+LzZPuP6fZjDGQ74O44pjOb/TsLKAWKq0ErDRLRjqzaQuIlNP/Juz9q1Mh6g?=
 =?us-ascii?Q?dqCOi6jSd87LaoMmSXfcayotthHcpZqd74PF0w/uv+FmTZag1c00p99gHC4Z?=
 =?us-ascii?Q?PlUnNS+40yE8Whgp+6bgDLAVrTsfue5W0XsfpVeHRqZ9l4+K8Oiy8L1m+w+6?=
 =?us-ascii?Q?ZZneuqfSqeNcmzAudCIo4XBLGwBOUDHPvDPorbJ55kHj8Kl8mhw4ejjjvy6s?=
 =?us-ascii?Q?SwudCRiDZ6cSi7Uw9VylN+RnenK55p4ugX+jl524GFKlzfAcMwF/ZKHvPs1G?=
 =?us-ascii?Q?xw6p91dQevqH0sJs0dJzRxiR/w88CNxL0B6wCeXax6ZG5J30HOzeqXUU1uQ4?=
 =?us-ascii?Q?Zl/Y1blUrLk6+Bi67dsHz4gXgf6x8Q5kVGd+UkMiMSICJ6VVt+a/1vp7g7QA?=
 =?us-ascii?Q?bvrXDXA2wI4F+es77ALZr2D9d1TT9cgN0AAtziELO0BZGpSFVtWGw5ricqXi?=
 =?us-ascii?Q?yI1z30M5xzNQc7vbPkd67RJ+D87xuRGlPIPcVUVklWBAO2Ug7WsshFmQC5cT?=
 =?us-ascii?Q?VCtjz8AW8IdABodYsv8lIDKcF6xerAEG8cAuq6/jbQqyKVHV8KAb767JvyXP?=
 =?us-ascii?Q?+5fNejmA8OK0ekr1vqeZtarZKEQMdjDh64ZVuXCqj7LJgbGFUSpcKjj5Uzhu?=
 =?us-ascii?Q?6hF7YT32m6xLjziSd04mgj2kAEycYtfaXEo5RZXR6i0lZOp0ZGu8kq9KbxOD?=
 =?us-ascii?Q?1eBWyYy4WVuajHU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fuzm/A2wmJ6xjIeFS1/d4U9RSqDJS4egvoXSo+zfWge+LxtUPH+/AVEglBct?=
 =?us-ascii?Q?xnWN2PrqnK1VrkGW++y1uvZS9ki+77GXBCj9Bv23O726rKcEEVeKFNMlNhEv?=
 =?us-ascii?Q?3hvPL23hWwgsSg+mgOzrdwJW5bs4Hn4crSyyn9r8yjfWvZnCYLuNGDxJBD29?=
 =?us-ascii?Q?sufnJywYHUIdDDtF99AiVRo08tEqlaQ/SxFX6+X0kMlBBtOMWGM7cb6T3Nba?=
 =?us-ascii?Q?n4a0SNfNBQeE8NpHc/EApMXgNs6kEzoEpNXHPsr94fbHwMA5Ms5bAX4kuczc?=
 =?us-ascii?Q?CYYIHolDXdsRa+zEix8N0VpV8xUaneCazxl70DVuKJvxwzBwRj7ofqQHfRyC?=
 =?us-ascii?Q?8ZUj57BwR1Mn/9/ycbQtay+RWF0ticjtV3hblpcknWyCKcTifX9ItlNMbuda?=
 =?us-ascii?Q?LcCQ7Ex/shJMm3tNMctJpDDIiPFKtJtcPDLDKA7lL/qdTxpurYQW5D2kpoSX?=
 =?us-ascii?Q?fgk6S5yzyokm5RYZ7Zi8R2iwCQS76TuvWmjYz2ZyefQJx7Fy0wpaetNWnEJa?=
 =?us-ascii?Q?BculBfN2AA4PxN01IKUWvKCX7EhsiLyevs0t3fTNpLlusUE4h36xuAN+02aB?=
 =?us-ascii?Q?vHPqQZ4jXGb7Lr/lAhCTDVlRvpYxxe//POVjmauRyVZ0b9qEoT1EHXCj/41l?=
 =?us-ascii?Q?8ffM8qtUS03oQnyofl6dYZ7KvqT9g81PAfmHv6MIAX1EuIZoo1dojpqfygEt?=
 =?us-ascii?Q?zpx/H8wrC4SLe8bpdgvEFh+xTs4JEqg9d9mLPYz6vsy3FRm8X9TkGDmy77JJ?=
 =?us-ascii?Q?EkruDD+td+Wli1j2Fi+EJIY88/aqBKLBmDnC8PgdtQeXRBDnI8i6NMa4DOQE?=
 =?us-ascii?Q?PUDWUuFI4SkcQMAZ5UjIpDv7NH3Wgud/6kmOnXKNn0rGl+WijSW5zXUGICkk?=
 =?us-ascii?Q?R6lLEvIE9y7J3hS2siB4PWOiNaqtMmRGlPtlOkyleKPyzAyE9Q68uvjeWW/w?=
 =?us-ascii?Q?/XhesEl8/WphW2Rw0HC73QYb8TlI7h6V06SRMSQWAV6vUdw3EaWxPJljQ6dp?=
 =?us-ascii?Q?bQwXDLZ/KV7mC5c7krlJgKbA+LWyhcw1F0raSjQT+vGPA1+bdWwyBT7NE8gV?=
 =?us-ascii?Q?PK/CCTd5JLebDfLyDFQQWDM/ykkDnDqan/tzMKCsaKCUY8gd12wDXnZHd2Lg?=
 =?us-ascii?Q?TVXWxStubt9doZgZWBSLLCDdMVAXSx3gauGQMvB5QgspmT8ET+o36q2dqMWn?=
 =?us-ascii?Q?QK5srwWHHjoCCrQWESSTDc5kjPilebJipZtGO0gb3fCwLvlllt5usMdB9r1H?=
 =?us-ascii?Q?5r49KpaLkfeVUjH02Ww3wze16pU3Booh6x0SirwWgPiY/FjSSRLNFsGl6Unv?=
 =?us-ascii?Q?owsQppZ6spNdAwGtb3dAutb76Fbc3JzfafW5hXZfqLrdF6C1y+trh8XiW7hF?=
 =?us-ascii?Q?esXHKJyAZXnYI/nDEotBBVrQwMsj4XyiIoB0eMkArYhBN+su4mM9kUckTvzm?=
 =?us-ascii?Q?04Eep3hnl+s2t1H6lKeys3ALlkn2Cp3bgWKsaP0MWyz/U9f/JiKeSHSrfQn2?=
 =?us-ascii?Q?uuXI728l0kYW2iARbprBXkN10Ypy8HfEY9mu+EVydUtIU9K8eOx22GlpWKd5?=
 =?us-ascii?Q?wURnjaCoRfGZOpkn8RfFzu0dynP9CxVP/hQA+fn4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a05bd7-f467-4ba7-cd25-08dde6c0bd74
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 05:56:04.3047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/LWSDWz7tkMG8+AsgxDigkapT+7FGTld3VG6OWAyvKGpozUtpiZzFhQjw8JS/OsGQh9bzeJbneGHbYgddyPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 04 August 2025 15:12
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Simon Horman <horms@kernel.org>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: reduce number of re=
ads when getting OROM data
>
> Currently, during locating the CIVD section, the ixgbe driver loops over =
the OROM area and at each iteration reads only OROM-datastruct-size amount =
of data. This results in many small reads and is inefficient.
>
> Optimize this by reading the entire OROM bank into memory once before ent=
ering the loop. This significantly reduces the probing time.
>
> Without this patch probing time may exceed over 25s, whereas with this pa=
tch applied avrege time of probe is not greter than 5s.
>
> without the patch:
> [14:12:22] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [14:12:25] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count =3D 63,=
 Tx Queue count =3D 63 XDP Queue count =3D 0 [14:12:25] ixgbe 0000:21:00.0:=
 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link) [14:12:26] i=
xgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001 [14:12:26] ixgbe 000=
0:21:00.0: 20:3a:43:09:3a:12 [14:12:26] ixgbe 0000:21:00.0: Intel(R) 10 Gig=
abit Network Connection [14:12:50] ixgbe 0000:21:00.0 ens2f0np0: renamed fr=
om eth0
>
> with the patch:
> [14:18:18] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [14:18:19] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count =3D 63,=
 Tx Queue count =3D 63 XDP Queue count =3D 0 [14:18:19] ixgbe 0000:21:00.0:=
 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link) [14:18:19] i=
xgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001 [14:18:19] ixgbe 000=
0:21:00.0: 20:3a:43:09:3a:12 [14:18:19] ixgbe 0000:21:00.0: Intel(R) 10 Gig=
abit Network Connection [14:18:22] ixgbe 0000:21:00.0 ens2f0np0: renamed fr=
om eth0
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend the commit msg; minor code tweaks
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 59 +++++++++++++------
> 1 file changed, 40 insertions(+), 19 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

