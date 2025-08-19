Return-Path: <netdev+bounces-214903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD49B2BB96
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843F85602CC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB7A28488C;
	Tue, 19 Aug 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkOuq7TA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835FC1A0B0E;
	Tue, 19 Aug 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591465; cv=fail; b=A8EmIC1gCbhwx3wDEZb13L2pJOxPlgIif/t9g6MC0+Ndj+i8tXJiI9e9n58Y5xfKshsJ5meGJg/RSSm3WtS7Io60J+5UOp11EOweGVdaUMqL4qZEnaZNGfyfjL/mehfkYMSqoC9GYRdx3j4kpTuTosKZN1whD3Px/Q7bV7v1sN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591465; c=relaxed/simple;
	bh=1MQDNPXS4dn7pVKidd6illDciSCYGv5Gbx3hBO7aLjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogi2eZsCrqOUl9kuINBzsFDX5FuVuC4QE+ku8Tb3CUdq7uNpsJ26x8/qazoimGfR2Zv3c/jADzrFwgSgkph0hZCn65J/5m3yT7Xq31bBslD+jRr0K5rR2gcmEOSnu7J8D0V3X+o3ibCLbA51erZq2YGPKlSX3jcPXCy1pvrBI/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkOuq7TA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755591463; x=1787127463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1MQDNPXS4dn7pVKidd6illDciSCYGv5Gbx3hBO7aLjc=;
  b=JkOuq7TAeH2uUphVXP70ckAPmNjqt/7AQpwwPxg6SlAy+jBCpsTmPpK1
   mg5t6BtNNnQxMm/epPmjvAXHgG8+vvnxq9w8iXKhsbOgdPK9oUFh2edv6
   4wA+91DChvzmXfK+a2sEfcnboJWV3G3/We0FtZJKnuTR4QWViQIbbxRyc
   UzOhiffY2kyGxcIi+zInFC0brPajL67pchIa430viOlJ1L0fmbttlLUxK
   jobsmgs71gODQUaQ9uPzICAcz0UciNuosoSZuBcL2FXaXzNOsR5OdHNhq
   GBc+taex0a34lhBzOjkjlARKJIj/90DElhswTU5TIbtbStM6cFyA0dqtu
   w==;
X-CSE-ConnectionGUID: UhFkH7oCQ6mKTWb/gs/GDg==
X-CSE-MsgGUID: O/1+YnyvS5G/wV8ntoHePw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="75279872"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="75279872"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:17:43 -0700
X-CSE-ConnectionGUID: 76R5An4qSNKV25pAwG0STA==
X-CSE-MsgGUID: mDJtLkKAT8+SdFw6u8zdNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168148800"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:17:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:17:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 01:17:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1AWhULFX8XxxaSRmNYVbsQ9DwqKunnUtg2PYSETEKjuHgQsJ3py9lPSwbI7Dl5KT1ZusgfuqG1i0fvz7rudcsZyCXM1sTrm7ZKCccklGTg3NMrTyZcQp+sw93l/TxU2Z5qvmkNP+dypTBdM0cDKu6euV7xc4S3CzasB1hO59AEYz4/G1vtFqWYvcAgQhp+F/5IDw3AwAOqYuRW1Tv83uwY/JAIw4Sav0bPm7B1XiygD8zxKoSmaXMhIDUW37mYCW97ALlK3qduoCqsplr9PTMJqjJRD5PouoGBQ5VU68UOG82smNPa+18oE5ue4VnY/Muv+GLRFrAOj7Cu4qgWE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd/2eTIgskKx+cXU0gBXrtKIoROVIBnNKHD+jvSaAWY=;
 b=ta4A7pJRH3KzefG1vkYaDIBDsmpXz81srFHtg28HfPhxXBPI5GDYKtjr44ZIlsp7bnA4k5DaZ1u9vGad+BL9+cG0DPZnJDT8RH+iFltABi8tcgET4EHKG6lltzxXf92cnL2rciWmXUav3DTHEnMLAT9BcMlpYAZlwYbKyeK5sbwxOg55rIHpHqci5Fs7Z2pkQWTF71RUcUlFAtUCkYjZmY87JhylKPmBiHCB0PQ6l7Rgi7E1Ka2p9/aXp/R9CVkPYFFY1W+SyQhLLe8/Xzt/aizL3U8/zVkKBdL+0NhsPf2Me/TSi3dsTaSnGY+m86L2FilBNe38WgH7HJSWApAcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9322.namprd11.prod.outlook.com (2603:10b6:208:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:17:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:17:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add lbtx_packets
 and lbtx_bytes to ethtool statistics
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add
 lbtx_packets and lbtx_bytes to ethtool statistics
Thread-Index: AQHcEFOYti1SSvt7ZUKSDAIMO3FB+bRpoqsg
Date: Tue, 19 Aug 2025 08:17:39 +0000
Message-ID: <IA3PR11MB89868C41DE1891F01EB287C0E530A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250818151902.64979-4-enjuk@amazon.com>
 <20250818151902.64979-5-enjuk@amazon.com>
In-Reply-To: <20250818151902.64979-5-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9322:EE_
x-ms-office365-filtering-correlation-id: 02eb18f8-3d4a-42cc-dcc8-08dddef8dd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?azFlzOEz4u2NpFC90cB9ZGYZQMt+JVzaUO4HFn3ererzxV2NZ4NLXAPEeN/2?=
 =?us-ascii?Q?3UHlT9EsffjgdAiP4Al0vEAzmQ3ocWk0QDGbLtAfpNRHEPHJXi9a176hT09A?=
 =?us-ascii?Q?yzmnsEzfVsrJz8SLX34Of1MVtExaxKDtr4YkNfmAYctOw5YYUGEsGTvWUjdC?=
 =?us-ascii?Q?Vcx+7jojNtZvzyFOx69Obic3/CSXT/JPJtZPjCZBdmbaU55yNdThbdHM7I26?=
 =?us-ascii?Q?DqDhhXJZNYbamFPBVSDtwIvmy4wFfPLbcnzd9Kr76Ffmh+TfvCSQ0mFq7AAB?=
 =?us-ascii?Q?Az2uVFvNFj2W9aTZSacyNevfFA/EF3/eJXgk6GL+yhmsYDrkZcwmeXsD/n7G?=
 =?us-ascii?Q?ldHOCpggpERr1Ct4LxV2t2b4dPr0nTs4QcGU60q7U73IvS0PsjoZUdOxBfyi?=
 =?us-ascii?Q?/Yqe9+ojx5NCC1tKZ7vYJA8ZVZdDuOv+GU9wc6K1HV6BASX8T9CiJTThVGcl?=
 =?us-ascii?Q?suLrpRtC1DDx+ZhXzbplXtHC+R0rBLUh9pDwwomUODWy4S4OWwXJpferw66y?=
 =?us-ascii?Q?pT8vY9YWVyGfowwhs8NgARwLw+N4/TFSg8/FnmyGZeg6ow8ohH3UuBdi330h?=
 =?us-ascii?Q?lI/uAIc801KzMf/SgJiy9YLkLgwfAMcin/AMpm6ndG1LMOUJE/medWRQTlW8?=
 =?us-ascii?Q?OMTG0LHxppShX15hYzkk0T7VsgO6BAqy86YYTCw/fzfoBwHf1gEbUv5xaMKG?=
 =?us-ascii?Q?I3qnmi3Dr+3AH5oQjahIme+eFQoyu2TrpdfAl7gHZRVEXRVPlllP4UJY7flG?=
 =?us-ascii?Q?tv4oL0Z4VenO8wdxJvYv+DBnaBoyebUJ9O1MrJVuy1tGveVqN54HISyTLMZw?=
 =?us-ascii?Q?cI2JHF4HYZgSBruq0Fz7XCWNNNut0tfbCU2/mQjc7ok2/EVlR+KqvmMFMDqx?=
 =?us-ascii?Q?Di5VlwqkTi/lXH28u7r9Jqes4EVTmnUzpsqfoEYfCiNNHNPLWIlgEvIWZ0Nu?=
 =?us-ascii?Q?pMbWQjFRE7Xpt02XNYcQQsBrhZfSWYH/rN/zTJkJPmlt0MC66qwRV0lKuvsx?=
 =?us-ascii?Q?n2XGL/30HV5TvLNcWZ3wLVUXL7DCSmdu+G9cJwoVa3zjVO3sayQGfN456ic6?=
 =?us-ascii?Q?rO3BTjZy9G2SGAJuydELDRvAPbTmYafGuSLpQW3QSTFTK2bON+PCOVu7F7M6?=
 =?us-ascii?Q?hbT1vnrBR2HFRqMDiQJUqJxnlReZejRUMb6Dzy5jUoprHE8Vb47W7hjTjdq8?=
 =?us-ascii?Q?epo1VKJQjN1icB7PNdfGWMC6NsjehDeL6v2aT1b/CWm/htB7N3OwGB+G5uVY?=
 =?us-ascii?Q?kwxGwEKlR6t+rZJppky4aVqhpofvTMcWSHU+hDv2rP0p1xaqCH5Sg0l15h9w?=
 =?us-ascii?Q?Kok99gpQk7QH93xjiWLiB5MYwGtsnSgqm31z5sNNxZI8sjWcro/FsxuVfNTZ?=
 =?us-ascii?Q?djZXG8j7knHxFOYDDwS9CeLx69rHaYrZ+mc1DeAZaDlKGB+gys3Y7YhzZJau?=
 =?us-ascii?Q?ETNYxXYM9waN/KxVdn57l9W8nEMw3mk1DqaBJDXCMkrxZeKlCCMHS6fO+FIQ?=
 =?us-ascii?Q?ClGa8iHTvd6TVHs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTQ2diXFIR0BSCCUH6NQL8Io0D958iFgINDNA6Ev0oWRojqDhu4fAvR00WxO?=
 =?us-ascii?Q?Mw1Wtkl0JYjSeN8Gn0SqDgK9P4L3Qwf6msbx2JxqwZ0bmW0N7vQoYllLae3U?=
 =?us-ascii?Q?pOYao2gkDvsh4YNAZnwdVL53YA3HpzhQHsPJ1uSJDYZgebwmUAEeovc/N++z?=
 =?us-ascii?Q?WjWq8W3hrAxT8xcTIOanGVsfUqXmn9v1AxEehLpaEiGNdrMWsoZ6LGUdLSQs?=
 =?us-ascii?Q?LyIJtZFVNPk5vSs0IzXueU8VFVlobExZk9K2s1ENOnY9xFNKewTT8w3LOLH5?=
 =?us-ascii?Q?7semi67enV51VgWqki1NuuzD0pZCrbnyPRTH1Rkc/2Gve9TPEUib54etsGe7?=
 =?us-ascii?Q?hTzBJ6mXvA3u65/0XL6EEnksyiZhPWRz2Ch0kevlkaU3IoFO3dScbCMRbBYx?=
 =?us-ascii?Q?qQbxQj13pgXDkDt9kkiBONi6i5LchpKaqv0FNu0gcXmmM8zMnZu2C8lqnOKY?=
 =?us-ascii?Q?XP3uPzIZGQwsKZIV12wqdjQSn0Ih8ANNzLDCD+Qtlcs/4Is/Q6iNZSv5wO+2?=
 =?us-ascii?Q?QuvP+I6o2luiHmZQuikU0Irb9JRaOlgEgt68Ld/X4HF6JUOtHL08+hqRGYmY?=
 =?us-ascii?Q?Y6uAnbQVOF0k89gkeOJkkkhI5wXJSbjrlpFUh/rSEtc58iJQ/JkG5U9nMB1B?=
 =?us-ascii?Q?fnYAV629xBvQ11DDJXc7X6dW7gaLgMo6Du1ZTA9rRANFIFAVIGszgIJrJcfQ?=
 =?us-ascii?Q?Njky4CXQSytcMYDVfkpolzCqmd/d2WduD6GNQgxlzBKw20KrQdfc0J6nq5Du?=
 =?us-ascii?Q?wPmTfrZiftl0hVdip/pcmXaxb+bFk3t1TYlSR1n34/iEeMOpHKGCE5qTdRfV?=
 =?us-ascii?Q?cwyoaUMd0ELBlVjLE0wGLHK9WSuHDEahvt1n6aAZ2AHaaD2iji8KP9XX34Oe?=
 =?us-ascii?Q?2LzMBgZuvXazEY90+vkEFu9msazRugf4ws6MPXmWm3+5IE7hrwedIsVQtyOa?=
 =?us-ascii?Q?KyNsXgWNVIx6orHTFdnJ7EtBFBYhBrVx2SvrHlZRy4jpehLV3X1pu8iLXmvN?=
 =?us-ascii?Q?piMqaMqE9CK4wPnFjE1yhwynd059ftL6BUr62I8Jp4D+GCtTlNlwMXMjklFH?=
 =?us-ascii?Q?EFPJDYi10OSar0JpJMowqKB4rMD+06Kxu5+nsG9VjDKBQbl0AmkeG48uLWmD?=
 =?us-ascii?Q?AUSupoFFZw23vD8MhNwPuQ+IIMuWXAGAAjLWuTU4tfg3C/xCh9rlALjo7Dc3?=
 =?us-ascii?Q?EqV7Mh84j1Sh5Iq9vB42AS4S4LJuGyg7Iue5PG6deuVil41bZXp6CKYiVTYs?=
 =?us-ascii?Q?SK10vXyn5ohkznJHubuPCJyxD7FJO3mic9hoLwo/6wP2cM///HYuaJV6ASM2?=
 =?us-ascii?Q?FwK9dPr3IwYlk4rtAP+tY4FvS+AKI1TIp2mW+VMMYQRcyXmA7eXbp5jwc5ha?=
 =?us-ascii?Q?BqiTtGkQvSPNLbjuvXgLgt1xMPzcpDYxjiTs7FtCBmdMZsIjgBaVcRcqu3TE?=
 =?us-ascii?Q?kpztqMZSyNgeKIyztUQh01HwSxI1X+MS5PqKqmFDNZNxNymAeBZWO/N6YkTW?=
 =?us-ascii?Q?OsEdi861SYWzI/yDnDVC0RfWARMbcRzvnaKynbrtDe28MEL5U+l6fmrfO7WS?=
 =?us-ascii?Q?V2wD8/EODzDnKQCkYdDB0amW6YxCmPTh4OriyD2fy7EjMKj/ciL9vbI7AqjL?=
 =?us-ascii?Q?9w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02eb18f8-3d4a-42cc-dcc8-08dddef8dd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:17:39.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GURI5ZLYUX2LBroC+KGKMWZC+++z5yf9JHe60fthvrzBruyOvg5jTkF5fG046jRsrkVE5PjvbSuxlm69b/uXjKHia1uX+C7xym7fAoozA4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9322
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Monday, August 18, 2025 5:18 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> <enjuk@amazon.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add
> lbtx_packets and lbtx_bytes to ethtool statistics
>=20
> Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
> Packets/Octets loopback Count), but doesn't show the TX-side
> equivalents (lbtx_packets and lbtx_bytes). Add visibility of those
> missing statistics by adding them to ethtool statistics.
>=20
> In addition, the order of lbrx_bytes and lbrx_packets is not
> consistent with non-loopback statistics (rx_packets, rx_bytes).
> Therefore, align the order by swapping positions of lbrx_bytes and
> lbrx_packets.
>=20
> Tested on Intel Corporation I350 Gigabit Network Connection.
>=20
> Before:
>   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>        rx_packets: 135
>        tx_packets: 106
>        rx_bytes: 16010
>        tx_bytes: 12451
>        lbrx_bytes: 1148
>        lbrx_packets: 12
>=20
> After:
>   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>        rx_packets: 748
>        tx_packets: 304
>        rx_bytes: 81513
>        tx_bytes: 33698
>        lbrx_packets: 97
>        lbtx_packets: 109
>        lbrx_bytes: 12090
>        lbtx_bytes: 12401
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c
> b/drivers/net/ethernet/intel/igbvf/ethtool.c
> index 773895c663fd..c6defc495f13 100644
> --- a/drivers/net/ethernet/intel/igbvf/ethtool.c
> +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
> @@ -30,8 +30,10 @@ static const struct igbvf_stats
> igbvf_gstrings_stats[] =3D {
>  	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },
>  	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },
>  	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },
> -	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
>  	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc)
> },
> +	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc)
> },
> +	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
> +	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
>  	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
>  	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base)
> },
>  	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc)
> },
> --
> 2.48.1


