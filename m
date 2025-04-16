Return-Path: <netdev+bounces-183408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0377A909A5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA550177737
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1072153EF;
	Wed, 16 Apr 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeAfCe9x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF71FB3;
	Wed, 16 Apr 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823457; cv=fail; b=fCDPYgAUYFvVOr7WE6GE2goIP7CXdb38fgNGqTiShwl13CJEDYk7Ht9jlfh9d2dhgS6qudxBbh6mIxZh5ghqpxlkdo/z9fZurSMeUcwEDi2+D5hdmm/j3ni/WuDu0ToRbpRH7RVYsKznblocTxhF1w+sUeUmlqWX3qtCoigMKuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823457; c=relaxed/simple;
	bh=dMHVJRdhcPfj0mkqIqBjIUkqCJ2/Q7pmKEmFOBFWQfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oY2H0tyyRtHZzmn5IChmBiph33o3iCgdAnPm3Th5YPFSqms+fK0vVqlPVuw8agFJYbO/Ll3wM7bRdrI0aX1E7Vlw6ErFrHMyZcVbd7fW2c9XX19yB7sxKYehjUqqpuvyyqO+ra6j5kLBQ4rAYhVCuEcf9vHVzEl7ibYOjUYET7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeAfCe9x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744823455; x=1776359455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dMHVJRdhcPfj0mkqIqBjIUkqCJ2/Q7pmKEmFOBFWQfo=;
  b=LeAfCe9xkI7GrlvtXPSP/+zZL4YwNurl/OUcWeu7fPUq8LYqmq3R3B50
   f3AIRZSjlwMjGeCnzUX6xiUmjzpzhBn4AbhLfZdUsIPoFiitp0PBbiQqX
   0rPHyvr2JgSmqyJczXClTopM3BYwwb+UnKz10mEbehU+eMimnUFUJIlMK
   AGL5dVuuyinmID1RVr3vGVLM2HRe588GlY2Exks0yEE5ySE2UDeZZwsDa
   XdCuNGYHEMxpNmTUEI1jLtyNAE1uEvsPwfeOsa5x2ONg0sBcsT0SYWcQQ
   MdVcQjTDZze4ok6c9CPXsKLCL82XI/4nqOMyMZ10ojWzUyTCo70d1LUUC
   Q==;
X-CSE-ConnectionGUID: P3UsJG8JSuuukMMHXBT9eg==
X-CSE-MsgGUID: JB1tRBgPS2OyYkWYGmxs4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="68874850"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="68874850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 10:10:54 -0700
X-CSE-ConnectionGUID: DozbRtORSsi3ZkuqrT8wnQ==
X-CSE-MsgGUID: 8o2qTaHyRa+/m7MNQnle+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="161509314"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 10:10:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 10:10:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 10:10:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 10:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypMquZc8b/mWLqVRd+uKuYG69moXp0dOuIx27MwnENgLuZyrPl4dCAItsJ/l6ShwONvvNe07YdSyWPoveQQhjNogXW2ZYTF7O5e17GoTwU6pm6WZV+zbz31u1kRpZCDIt3HBy1BlDhFA5DRACW8eJ5Dpf/yqdUcyOTYRu0AB/C3e9x4bufmBev36kIB8aK2EkkoHNsU3r13BCPP2o+FgQ/s6kxw96TFha8Sbro6IO4x6V1+d4gOGv9Z+mXQc9QrX7TyMOJb9f1ezuRka485u6jmdWl5WOcxlPKyXd1/Ip2qhzmP3l8nkN3g0qTXv56uCKrf/Va1DU0q1rftw4Qlswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMHVJRdhcPfj0mkqIqBjIUkqCJ2/Q7pmKEmFOBFWQfo=;
 b=tL9POt7yfSg0tdpGUKHdj/HeINzfRftTYZkuwwNuWTZ6qTqnjA2OpuE9GVqf6rXAwD6RNVQbAc1iYpBQflBEezSlTzw5ltsoKmLmFJAAxgzfe2sAKPxpZ32ucWdNKhh+hi8KlnJ+zLTbttOMV01KUrdb9luxzIeLyi+b8FYmXpfSicOeumEruxayr3Kz+ygCcl5lOdaiqeRWQSnoN8LGayFOMDVpg3mnz99LcDYW8Mr5LlzC+X+5Wi/HmyPbXDmfVgG/g2ao0S0rgvJSlkvJAlOQrrKSUED9P3PmphKo4aRvrqiIJ1r7lf6AIaDJAZpqdEoJgmCGBR5ymEAfyp2gtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 17:10:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 17:10:38 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Philipp Stanner <phasta@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	"Dumazet, Eric" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>, Taras Chornyi
	<taras.chornyi@plvision.eu>, Daniele Venzano <venza@brownhat.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, "Ingo
 Molnar" <mingo@kernel.org>, Simon Horman <horms@kernel.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Sabrina Dubroca <sd@queasysnail.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>
Subject: RE: [PATCH 0/8] net: Phase out hybrid PCI devres API
Thread-Topic: [PATCH 0/8] net: Phase out hybrid PCI devres API
Thread-Index: AQHbru7bZvH76Wug30Wj8YBTGEadN7OmhurQ
Date: Wed, 16 Apr 2025 17:10:38 +0000
Message-ID: <CO1PR11MB5089309753FBA1EDE6C2D663D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250416164407.127261-2-phasta@kernel.org>
In-Reply-To: <20250416164407.127261-2-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB4920:EE_
x-ms-office365-filtering-correlation-id: 809b1a96-25c2-4a8f-5805-08dd7d099c0a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?zyFPkOoKk++WfOrGbUG10yyHnjMbWoSUoMJqdG7PEuyFD/dp0J1i8PyYe8Cc?=
 =?us-ascii?Q?cIru+NKw2Op+f4ItYQCP67LJQDR9LCk7WwvnP/0xTjd5omdMYski7dk5t9zQ?=
 =?us-ascii?Q?M5mYhRyGKIJZYNi73qaIB+M6Vi8g9nb2xpDe1TvKGE0eC2fRz5OJm7QzxhGF?=
 =?us-ascii?Q?mpmpLHkq46kHp3RzUjDtUFjg2ZONitz9P6ocVqj+ggVKrWmZwHxyJvjyRR7k?=
 =?us-ascii?Q?ZMJXxKaPd628nQXOHYrdd2DqeX9RJmxfDZVkoyIIpk3TsQiY5106gfMgnImq?=
 =?us-ascii?Q?lwjcJONKIaWtIzyTGQvNVlDMhLR8Ud1hm8MgKstApi2yha2wthJbMt+ufzW6?=
 =?us-ascii?Q?mUhwblg6J8l35EPFi+k5ycOyUHqoDzuD9A3Ls5N74hCCtOPcf55+kQQSLqos?=
 =?us-ascii?Q?8ZzaE2yDZpGc3+s2JYJnxScuurWapO8uMYUpGN6zXIi6jG+NGxi4ssCxOSRm?=
 =?us-ascii?Q?TjDG7+A0Src5m4wcGxvffXz97lX4I2GIoVg45qbLK0YDgdBX7fT+zqty4ilk?=
 =?us-ascii?Q?VA0OAEW20fxvYHdip6ljliCyV1TTHQ/3giNg+B6kAwxn4VofLLZSKsfgIjVH?=
 =?us-ascii?Q?reNr1AZwos54seW18OZLh28Y1s4dMjQjoMhedzXj9FGs9enviusM9t0yXa3Q?=
 =?us-ascii?Q?73L5DlHpDjuW5J+8rP+ZEMzu+KYjPP38ZYOucfk0QY14AYPNx5i+InkqHQ2b?=
 =?us-ascii?Q?zdkTF+52Ef3hSFtPUp9bTPE01e0xjVcLgM8pZE/aJkNBRoNmq2xA1E35dIoi?=
 =?us-ascii?Q?QmE7EG4CX3K+1kTLONAk7Y29Vi1/1zxcrMxNTRWP/VvZ/E6ufp9J6xyvwv1H?=
 =?us-ascii?Q?a4RB+iVoWfCZQH3D7VNZ/JCWrty3QYRx/Wx914C6vKMaxyQU77Cuh6Sqv19d?=
 =?us-ascii?Q?O2M+fZbKJflEuyrlKq/ke4EKemQy7Cg6nIullZuXWrLU3GWlfnfs/mX8muqv?=
 =?us-ascii?Q?Fxmg/BP3CXtc7ys/Zd/PTOzmWucjRPQb0FzaamvpT1FdeT6bl81JxdhUxRqJ?=
 =?us-ascii?Q?Z6JDMBWuH5eQ+ZwGWDfNLhIacbqsivAaUYB3W0+9BLdXy2SSIzjgCcWOMNm8?=
 =?us-ascii?Q?RMoHgXtUk9ky2gcSTaH1UslrHCnMnHPfyTTTxJO16aGfv8Ori0d+byRkTH/X?=
 =?us-ascii?Q?OZXH6fT5PHjyIQK1zut2LMPcX1hoXAzcJpLLk8gZNQsR+fQAOjBSlS8hfD28?=
 =?us-ascii?Q?DVZCK60Mnkang+KvoW3zyi59m/NprV2vkBGS6ScfFzt/8Cbe5oeO2C7IjUfS?=
 =?us-ascii?Q?6lNV/suangJ0CUzEs6kovFxGeJ1uJ5xIoIIHkwRhhdWDULGKTmqfcCoNd9Va?=
 =?us-ascii?Q?DZnWmDH9F/2/wD+uvEZRh7Qp8y0UwLSV1dqqUPEfQnk37Hx+2iZFSILhxK/I?=
 =?us-ascii?Q?IT8aBbz1uYtPw0yToc03TGT/jzQx4K1S5ata8XvqQrV0Fei26jRLyLwcwVOq?=
 =?us-ascii?Q?bNU4RmR0MmEnJ8WgOhqE7lS25DmmP3vhrTZwwqPJYbhXR3CJ790oWLoppEyH?=
 =?us-ascii?Q?feENYCgmLjH4y7A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jt2B3mi96pvhgesotUKRG36lle8lX/ohkaVDE0PEdeA0xAiu49s7SUiit9f1?=
 =?us-ascii?Q?w7uo12AdUJHOtZEAC3FKSfzdf/wVJ9csH7d/7uYEiF+AM0NHh0e65QoSSfGq?=
 =?us-ascii?Q?p3f1HrOBLfDMka4QNqwwH/eybMdjG9c7xpLkWjlxKmA/SxX6Lo81PgZlCCF8?=
 =?us-ascii?Q?imhdLaYNAOf0kpVU0BZRR//tpSBCQGceZpQWhK/ahs1ws3TbLULWvy88u9TS?=
 =?us-ascii?Q?O/RsymLmLxSLoRDCM4cVq+KlcbkZBpcPMB2SRRpqEUwk+OyvY/p3bzLSOSL6?=
 =?us-ascii?Q?X1y6ahXppL98IqdhVckfMUkHChQ2zTcZgHjpR7zBvcd+ybeqffPghflHBFw9?=
 =?us-ascii?Q?04FYN9ogZ1FNN62BncWa0zSmGU5yGb1tAL6rc08xYaZ50PT+x61yIhtu6Mpu?=
 =?us-ascii?Q?WIV4L+/EIyjGRXYo/nApDkmga2R6mtW5sTh4OJdXJjPBLpD3Ukku50EfazF3?=
 =?us-ascii?Q?rFNvC9rGPwECIdlqaBAaqmSmaDwKyAnUS3KJRyT3EhVgoHDxFCWIq5xrS5X1?=
 =?us-ascii?Q?EtPTHoO+qGJIQAh75V7zAUXL8hF4izWX3NcOroWfiCy5zLzfcZtUMGPlKKzy?=
 =?us-ascii?Q?+OugraTSGWWix8bfbM9Nw45wRaQF+PobLT6EDio5/oc2kgh4m//W6UAUSW6E?=
 =?us-ascii?Q?E/Yln1nMsfQeOtdf0jKHqCgjzGSrWliWDigd/r9BxnbXpZSfkiOCXSsp0aZg?=
 =?us-ascii?Q?WRT/qsib5NR4BLUwSD2m6MPfdd5dcbRecHGgfmwcs+xHSWrQVrUv1EFu+EZW?=
 =?us-ascii?Q?M6Fst+POafLno+XZLH/QPmp47vGaYGh2S7rx9wo+cfmnoN89Lx4NgVuPAwhI?=
 =?us-ascii?Q?kAMUSSCa6EDxlriE/HFP5teRCz5J0Ihp8RjtsbuALXtaeIfHf6SvQeF9Sj+l?=
 =?us-ascii?Q?wIeCK0CyegyVEEYKkoVRA0/zPj6D3zdM480M7MvY2axqI3eGA0p44pl6M0Ha?=
 =?us-ascii?Q?1XqWNfSpgmn062S9Qwd0FVpxXM6WQbbnnM54uSQG96oB7t+uVfVS+0XEFEJp?=
 =?us-ascii?Q?p1S+0lZK5wmgOKijP0QtWg+J9jeelmXAru/Sybr+kPhPZVTH9/Vmaf6teR23?=
 =?us-ascii?Q?QF7PyFmoXR/zLy92cdX1eVDwGfoweySnT2JZh26fQE+EiampdEEp70NmmWvO?=
 =?us-ascii?Q?o+Lz0hbeNOlUPNjx0jJBhHf9Ht0FD1ZM7ChgeP0q2gW00OJ6cDFEjWlRepXO?=
 =?us-ascii?Q?tVxD3gN8xEhEq37A4oQmNFEjMrNMnnFVPmkxQketuKvrJVRujTqo6uRkCJBv?=
 =?us-ascii?Q?jpMWvzQsMU6qNwY0QfaG59SAxjOTDB8MOS9GMHUpTlhxlaD8TA3JdcJG6r/m?=
 =?us-ascii?Q?CzjgweJy4ySbv7I0LWnlroxEyoT3L1sET6i3hQxEPQ9xYPCVBrew0fEs9QQL?=
 =?us-ascii?Q?q+lRU3vz/Hf5FaqrCLUGZv2JVPcmuZT5DdmEkHR1xKGnTYZYWdXNWvchct8Q?=
 =?us-ascii?Q?01IdhSe7Gq5u5psGmP7Txah/Bp3mgfPFcRAZUSiaVaxZzP00FiUc688jU32U?=
 =?us-ascii?Q?sZx/d4fIGyw5b65oBP1WMu+OnFH9qg1HkwPv/GxzHyOW18XtrMAWLMQAbyxr?=
 =?us-ascii?Q?FejRGUwgaXvzBIeehGGplZ+UcpLr9hqj4IS2enIh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b1a96-25c2-4a8f-5805-08dd7d099c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 17:10:38.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLtokvThYj0Cz2H+Dk7GdxRihk7WbxDamzDSaLF4FRZEE3mYA6MMSBiaw9F+KwN1DmRw8xoSaj3vTFYP14+TJ0lwE+JP6FkM5NBZYBeWA50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Philipp Stanner <phasta@kernel.org>
> Sent: Wednesday, April 16, 2025 9:44 AM
> To: Sunil Goutham <sgoutham@marvell.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Dumazet,
> Eric <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Geetha sowjanya <gakula@marvell.com>; Subbaraya
> Sundeep <sbhatta@marvell.com>; hariprasad <hkelam@marvell.com>; Bharat
> Bhushan <bbhushan2@marvell.com>; Taras Chornyi
> <taras.chornyi@plvision.eu>; Daniele Venzano <venza@brownhat.org>; Heiner
> Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Th=
omas
> Gleixner <tglx@linutronix.de>; Philipp Stanner <phasta@kernel.org>; Helge=
 Deller
> <deller@gmx.de>; Ingo Molnar <mingo@kernel.org>; Simon Horman
> <horms@kernel.org>; Al Viro <viro@zeniv.linux.org.uk>; Sabrina Dubroca
> <sd@queasysnail.net>; Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-parisc@vger.kernel.org
> Subject: [PATCH 0/8] net: Phase out hybrid PCI devres API
>=20
> Fixes a number of minor issues with the usage of the PCI API in net.
> Notbaly, it replaces calls to the sometimes-managed
> pci_request_regions() to the always-managed pcim_request_all_regions(),
> enabling us to remove that hybrid functionality from PCI.
>=20

Removing the problematic "sometimes" behavior is good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


