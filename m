Return-Path: <netdev+bounces-197368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5358DAD851B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B7189F5AD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5026B759;
	Fri, 13 Jun 2025 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9iYKszA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17B26B75A
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800947; cv=fail; b=iWgkyhbRyo0i9CmZrhv2KEtWeP/Bn2N5eZk9OXUiX/yiU1eC+AmRES2fNw8wW88KUkcSHFzxwEbwrUMbO+3ZCJyQlNlf28g/YUSYKF3uszGGoFe0A4FPapXzqVJ3I9Cq8M62tUDRpthVOr8SH0oNXA6LHHqID2ROWwEPX5JHGa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800947; c=relaxed/simple;
	bh=sYu3x+yZytpqVJCMXWLjcXkw5wjIIhGcee/JLSiVZqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTHDbhB/g46MQYD1bkPGsJ23Nypo1KrXjo3vxBI5KdAw4tEi77Ztf8MwXzdeRuMqghTFypQC3yhaZAAaaxp7w+S9jYQ5mTEZUJ8dQnM50zKskW1y04/9OZBnq7nLHMjMQDq2YS4awHNKyXb1BbvwtY/sVnSzC9XOLz7ohRbTLiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9iYKszA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749800946; x=1781336946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sYu3x+yZytpqVJCMXWLjcXkw5wjIIhGcee/JLSiVZqY=;
  b=Z9iYKszApUbtR2wp9vmPFMiyT2UU8x2aqXzDD8kgivatbNGiGCIap13m
   G16f9vmMSmlUeMD628yca8OmA/8Y8TWoQ6BalsrrgygT3rowDFkWQ+Hig
   DCtRgrst/IPlL00OvKig7BbHaHWxWVVZnEboeQeBay16IFAuvUyRl7sS8
   sHF+fQvd2W+Zj+xtRXRoAZz1Lc37540kaDoomEGRFHxkfUVDfLwnLlxuU
   /UIRIjdqR+yVIniU8E6X3+u62SoG/wx4T+jlJqPEdwMSm0rrNcwfWb4Pk
   cho7aKwEa7YElDlFWmUztvNuCjl8l6J7qLwzPnoPln7SWabL1uCAeH142
   Q==;
X-CSE-ConnectionGUID: /mBIFaRrQzGFzECnVwyIpw==
X-CSE-MsgGUID: G17hrclhQOiWV8lzhXX+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69452414"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69452414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:49:04 -0700
X-CSE-ConnectionGUID: /dG6dd3jSVO3ao/v5MTeqw==
X-CSE-MsgGUID: VDIJSrK2RyuiUgRhg2qCjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="148646250"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:48:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:48:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 00:48:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNmDAzCGMtyFbqsRon99BUt2GDMEvlBXYOTcxkC6sTjlZ8g7KSvnAI/cV0xCEs8wG0l/spE7Rb1n2n6c1wWv/3cO5VblbYXSx4M2GVEuYczJJM8yxA50J2CH0cdjT4tLHxGlwgkjv34ceGneYY1vQw+HVKicYF3q5aWwJ5k4YBWSmwDW5MI4qT7FFaaZVnsBlz+PNfzhR0G0dk2EcQm8slnslmz4Zi6C8A8I+81RTgL7KSCoqAlgnzM0n38nl7rLScNHJqfNAadUTKsKuvBh0xoJ+aK24/sjnIVsHCWkLjADdzCrhgG0TkroVcqhOlZJ96qjsxJgyBECmVnykMCeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxPfCvF0xPQ5a+x8rH+tC70weKzS4EygV4f4OqMZ8II=;
 b=lf/ApxtjR5yhC0gtNAWdwGXf2fLZzWQ3WyZNh2+/rULf+0a941xzokHDu7sUYLc+C5h4p1mE3RbrONxHmFTuw+QrWFGttHXOZU4egPbkrFaKu1BHtMeV4peqRSTyCGGrQdCEoNtXkDBRFKA4K4psVWgTeqNGS35GmauevOtD2BJGsIV3y6BGLa1CWhdtVwh5BWmqN2iq1tyo6sJBRdbUR9AkCk1J8ijAs7Cak/Z3PRFYCpMcnnjvZlgxpuQuZ8G2wpsoX9OknRqKlgBEpUK8bCZdHG1L5BBIAnK0genCdLfm9n20aGB2SoXy0WQKaxzpgHBb9UnxfYUHTiY1DbogUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF691668CDD.namprd11.prod.outlook.com (2603:10b6:f:fc02::2a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 07:48:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Fri, 13 Jun 2025
 07:48:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/7] eth: ixgbe: migrate to new
 RXFH callbacks
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/7] eth: ixgbe: migrate to
 new RXFH callbacks
Thread-Index: AQHb2/7DWj1aGu2iH0yf4BGK6CMKVLQAtzGw
Date: Fri, 13 Jun 2025 07:48:52 +0000
Message-ID: <IA3PR11MB8986B1E6B6A62DCEDA928240E577A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250613010111.3548291-1-kuba@kernel.org>
 <20250613010111.3548291-4-kuba@kernel.org>
In-Reply-To: <20250613010111.3548291-4-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF691668CDD:EE_
x-ms-office365-filtering-correlation-id: b51c33e1-80f6-4f1c-67d5-08ddaa4ebe23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jnG4W+ngrsmM52gNyUCkzqz81R4Id0OIS99WGWGnh5OahTX/KaWaf8AJmqhf?=
 =?us-ascii?Q?ZHwFB67CW7VRy+j0uTiTg7CV9rFWs29lefQpi5sk9GRrTxcj5ndTWTbmfP+R?=
 =?us-ascii?Q?IY8ORjgO0Qqm3hT6byipHa7Bz2qzGe4o0MfM08ClIj0A/IQfzbhwTH0E3wjm?=
 =?us-ascii?Q?/M3MfK4QlpJkpkn6uq0+wCPDdPf2uK7tLagxHbOOyu/GCWjJA2vsPjsthkd/?=
 =?us-ascii?Q?7USRnEEk673QRDRcBmo4Zb/9lp92CyohhcFTDKZ7nAtBwz0LGZ+GKey7CRpv?=
 =?us-ascii?Q?FgFoCEYqNYrLh4fWHcdG9QfN7H7TybDCs+tZRv9KVz1ct0+ed2VmFAw5bNfA?=
 =?us-ascii?Q?iiugGyg/ZERJJZxrLZgKSArro2iiPxp8anKlKZyDvT3177K5fkE1DCmxv6nS?=
 =?us-ascii?Q?u5hBWpEhkd+FVKgK6Pq50o4agtOc0A6af+HFxfUiFRvY1nWTO6BmATY+iCys?=
 =?us-ascii?Q?TKpkvHcyHnX8M2k0RXJa5ro0U78O81glsAqPtqNPk6IdfX3TE2+seW4iEfi4?=
 =?us-ascii?Q?sf0AdVRM6CK3gUw0H579UlHs8ycvOMMsZ2IQM7DqzGHnnJfYhFCgTxvg++Uj?=
 =?us-ascii?Q?3hwmpO4RrVFOPVR5yKmRjy+BNJ0u3QYxLn4rbBXdBdlxuPpyYHGUOf039aaz?=
 =?us-ascii?Q?HMU0eztQ3AxnrJMLLz1GAgGdjH2vj/d+f5g5t/ECwH0sstbd9ZaHPHnarxfB?=
 =?us-ascii?Q?xK+bIvZJjV3O+50JRpDbfMMv6gEwlePIQhijx09EBZIfVm1i8/F2Ki7W1a5n?=
 =?us-ascii?Q?oQcAQwaWx9Xfwy1efERPhuobUNwkAuQirv/OAANGwcdCmsldT02EE8cfJbHZ?=
 =?us-ascii?Q?mljQLhwozKR8C5PVQGfu5/Nvbh+DKPj7BQ+XVNODRTHI7gVRXite4kWsV/W1?=
 =?us-ascii?Q?Zmpw9PvfeYmf1e2WTBRsRa48YRaVzTOxl31J2xi9vXNCN2isysvNBqJy9vKc?=
 =?us-ascii?Q?eI3AcnolydcdVEdpUs7QxIgqN8fclAsNz2QKg9gwFpvuDfkRy/kmtDHRhKWD?=
 =?us-ascii?Q?wzlYzFOvH+M1lOs/uBEq9FxvTPiNDvuVEMiowWCZhg5yfsU3MaMmC+H6bmnv?=
 =?us-ascii?Q?uccTlfJbIUhWPux9GvIJ4bUb2rVHgNZanZ5o8oUhXtGU86FrvBQTL3oFfsCK?=
 =?us-ascii?Q?YbTIm6uQNaapwaCC3jqTo8y56LBwfZKOmSxipPZzT2loa2VygUmoDHi/CLIQ?=
 =?us-ascii?Q?cRumivbzGU1oEw7ZGRkVGlUz+JHMl0g78B979OqxFUpy0ltkfnjSkej1m3w3?=
 =?us-ascii?Q?pA2elMpiyDjNOyPdOsJxTVe3BROulIGam7Cb8vwaUqLPMs54Kaha7q4z5doW?=
 =?us-ascii?Q?1FM6L4inlaVvm1u6EeJFJmWvo61emAaQHnJztvGkMcP0Q5FVTwauL5+e6fZ6?=
 =?us-ascii?Q?AQnRrOSeZPlp9v0sfaINYuYAnbcQBDpt1GUDL0rx+CJeQmi4FtUwcOcjmUWU?=
 =?us-ascii?Q?r/oq3MWDjm24ScylMjHZ6aW7obzUZfIbeGLHLGXu6ECB7uHAFFDVvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H123mArDEnuL5wsr5mLZ5FiE8W3HMpvBpWctHgtYDlV3P2cnOPKAsa77g4MH?=
 =?us-ascii?Q?OWrNK2O4o2Uub7czIMoHVho2VXSFGcFzGZheq48d6C1fguG7+0+X3+mODX6i?=
 =?us-ascii?Q?tNOFFfnkeEFSObyoeItyDrCp9l4AnOjZMf7CMw/G/YQ42D/o0TnA8ajw7FAI?=
 =?us-ascii?Q?f7USgCELz7PBr99Ew/AVNL7Cvd9Km0B+1oAEx49MRGd/uYaGy6kCRl+jNHWc?=
 =?us-ascii?Q?ew+dxxtZ494XvyDbosnjoSMERJKEgzJ7+9fyfn/AClP4W05ZVvoi9X8TNtX+?=
 =?us-ascii?Q?OwBYUbLCvte78ILmmPqTCAolaY/VnsZbyDA63OvvxvhLklJ3cDBt1rQ4xbSA?=
 =?us-ascii?Q?SyJKbq2gsZY04c1f/iXZDelu0Put8wfS1sm0Ex3w6Yae0y+Ysvx323EPyR77?=
 =?us-ascii?Q?medioIxddtwrDsLXz9urgsfDMm6I1j+S4vAn8n3peNfzAJWsPzZ6iwBCL5Yw?=
 =?us-ascii?Q?2KVkVuTfh3BTgDvjwCw8ilhMUJaSAZ2MVDR6IuRBy+8N/XXiLxmtJ9iG7JTh?=
 =?us-ascii?Q?TXF+ubiwaizBPpktH5Ql/+ci+ncqUMzQ3oDtr25BTrWQm3ErEJgUxzM46lU9?=
 =?us-ascii?Q?LWlKyXyWeNbHaZt6ImnvPPlQFyEbI38pRJuRgbcqj8rrUNgVxVfbrYpc8x8M?=
 =?us-ascii?Q?8Sn7gaErczg0hAMnOTy0qu1b6sdYWI3uIzONsZjlJUxLiM8L0QnU2ujGEQHv?=
 =?us-ascii?Q?S4WIA3ILNOO/VhjFP3JW5IcwGBFRcEw4toUHl0vJRiLGlcMIKlt6tNZ4Ro0o?=
 =?us-ascii?Q?sAZR5mgEuYr3y1YWFwoDjoesEf5vJNRNfoyyjUL6i0QIGKrWsXpaOlR27ePm?=
 =?us-ascii?Q?8/B8N9ziNxaj9fzPLTHMlZzJTCwSRRioPS/tpb5sgyBasACcbLXWtszH8V5X?=
 =?us-ascii?Q?srTouQqG2no2ofTpuDJ6jw2LKgQz4AFLU8lMCQ4RF5EPStetgmJRfTEMKjWZ?=
 =?us-ascii?Q?s7NZmX14fBrqbvMrTg0Dd3TBsiMVAw5KaE6XneDuSHECN32HTKl+LCvDQ1RQ?=
 =?us-ascii?Q?CmVO5Xt24Px+BidWKZPCSsoLXbWAjGuCUQzwrkPXOn3DqHJlXFMkNFiv0asz?=
 =?us-ascii?Q?ICKA921mmbJFKpO455dEzM1Qyvujle+qYfbpNzIM6Lg+I03yX9yQJFnNtV59?=
 =?us-ascii?Q?655oFEHa63hxmOM/IPObzXv54KdLuiKWo4RVMfChYr+yJ07A85mRXiLJp0gZ?=
 =?us-ascii?Q?Nv5Xe7upeMrdj4LEtxdoQumCkhjBRl/j3mRD8CQH2vqpf6XF3EZDzrZCGjy2?=
 =?us-ascii?Q?WahHPmP/orBumc6xWUJGyPqb19Yt9ctg3hsKE9CdHdgoTzBHXzzW+1XtILDC?=
 =?us-ascii?Q?DGiyFP/Fie9CfEjuSuPSzZ+dP+Tg5/C2HJmAmJQijCUrzaGdTrKY4xo4aEb6?=
 =?us-ascii?Q?b7a8f4N2a6dB8iahG/7w67lySL39VmJnG8H/GEEbaVgjiS5CVy/ipXbhJk3Z?=
 =?us-ascii?Q?DB1yGkOgH9lmvwOT94cnMJGcKk4wJodMnp/IqnfDfE/FHILrVptriffIYP81?=
 =?us-ascii?Q?wL5ODmHWDeyG04yJnqUV/Iz9u5nNTzHn6Mfhx9pXO5bLJ9NZXE90uWjFNVpn?=
 =?us-ascii?Q?9rOUsY4ItCMbNlJ1nF4vSAKqouWzPIw6P4PpIQeLEcd4+vpClbOqlE/S+lgQ?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51c33e1-80f6-4f1c-67d5-08ddaa4ebe23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 07:48:53.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17cE31s7AtJkvAyCCTmgSImYCPuHO5KppwrWDoK75k+OFpc79yt6aWZUDmPDEJDawm0oBNgR8DG9W8i+95nJ6yXRjhq3lYowq/FIfaQXYd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jakub Kicinski
> Sent: Friday, June 13, 2025 3:01 AM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; intel-wired-
> lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; michal.swiatkowski@linux.intel.com; Jakub
> Kicinski <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net-next 3/7] eth: ixgbe: migrate to
> new RXFH callbacks
>=20
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 20 +++++++++---------
> -
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 1dc1c6e611a4..8aac6b1ae1c7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2753,9 +2753,11 @@ static int ixgbe_get_ethtool_fdir_all(struct
> ixgbe_adapter *adapter,
>  	return 0;
>  }
>=20
> -static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
> -				   struct ethtool_rxnfc *cmd)
> +static int ixgbe_get_rxfh_fields(struct net_device *dev,
> +				 struct ethtool_rxfh_fields *cmd)
>  {
> +	struct ixgbe_adapter *adapter =3D ixgbe_from_netdev(dev);
> +
>  	cmd->data =3D 0;
>=20
>  	/* Report default options for RSS on ixgbe */ @@ -2825,9
> +2827,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct
> ethtool_rxnfc *cmd,
>  	case ETHTOOL_GRXCLSRLALL:
>  		ret =3D ixgbe_get_ethtool_fdir_all(adapter, cmd,
> rule_locs);
>  		break;
> -	case ETHTOOL_GRXFH:
> -		ret =3D ixgbe_get_rss_hash_opts(adapter, cmd);
> -		break;
>  	default:
>  		break;
>  	}
> @@ -3079,9 +3078,11 @@ static int ixgbe_del_ethtool_fdir_entry(struct
> ixgbe_adapter *adapter,
>=20
>  #define UDP_RSS_FLAGS (IXGBE_FLAG2_RSS_FIELD_IPV4_UDP | \
>  		       IXGBE_FLAG2_RSS_FIELD_IPV6_UDP) -static int
> ixgbe_set_rss_hash_opt(struct ixgbe_adapter *adapter,
> -				  struct ethtool_rxnfc *nfc)
> +static int ixgbe_set_rxfh_fields(struct net_device *dev,
> +				 const struct ethtool_rxfh_fields *nfc,
> +				 struct netlink_ext_ack *extack)
>  {
> +	struct ixgbe_adapter *adapter =3D ixgbe_from_netdev(dev);
>  	u32 flags2 =3D adapter->flags2;
>=20
>  	/*
> @@ -3204,9 +3205,6 @@ static int ixgbe_set_rxnfc(struct net_device
> *dev, struct ethtool_rxnfc *cmd)
>  	case ETHTOOL_SRXCLSRLDEL:
>  		ret =3D ixgbe_del_ethtool_fdir_entry(adapter, cmd);
>  		break;
> -	case ETHTOOL_SRXFH:
> -		ret =3D ixgbe_set_rss_hash_opt(adapter, cmd);
> -		break;
>  	default:
>  		break;
>  	}
> @@ -3797,6 +3795,8 @@ static const struct ethtool_ops
> ixgbe_ethtool_ops_e610 =3D {
>  	.get_rxfh_key_size	=3D ixgbe_get_rxfh_key_size,
>  	.get_rxfh		=3D ixgbe_get_rxfh,
>  	.set_rxfh		=3D ixgbe_set_rxfh,
> +	.get_rxfh_fields	=3D ixgbe_get_rxfh_fields,
> +	.set_rxfh_fields	=3D ixgbe_set_rxfh_fields,
>  	.get_eee		=3D ixgbe_get_eee,
>  	.set_eee		=3D ixgbe_set_eee,
>  	.get_channels		=3D ixgbe_get_channels,
> --
> 2.49.0


