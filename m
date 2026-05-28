Return-Path: <netdev+bounces-292605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFF1NR8GGGqYaQgAu9opvQ
	(envelope-from <netdev+bounces-292605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C55EF3C8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5734C310A4BF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB7390229;
	Thu, 28 May 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY/u/xe8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8938F255;
	Thu, 28 May 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958513; cv=fail; b=q7NhSUZORrgYD/Ehpey+3KLJxB4NxpgDoDgh4AhnIizdQR4e+zw8tm6kr6SfBPQcq2MEQ8mLck2SfHX3L0RFVtEu0qXBnmOmcDtKLtvZweoW8gRtnQg0IqlwhqoJvbOy/TVJdH4rZ05jEhltEeJ73ki3wQx88rJEPqBC27Q3Rak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958513; c=relaxed/simple;
	bh=RKxcK2bdIb9fzokqv5zy4O7LJhYYpVobiY7MG9Gc3BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNu3kAgiJoZMFIt6pJhYRwany5dd5kDe1W1dpQQT4ffBx+FjZ8vc7Bs1hRhff7SWCEvaa10QeEwN0n49PLvOa+hIGp73HUv4GE70a9j7uYhr0O4zDeMiwoPLbhZIy0PmMUBLOj52CoIPGWGGcXlXelWBctmOcytljRAI/shPwV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY/u/xe8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958511; x=1811494511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKxcK2bdIb9fzokqv5zy4O7LJhYYpVobiY7MG9Gc3BA=;
  b=ZY/u/xe8ul1sTLrvmD9ovZFJHmmOGSfQxfVM9DYQgnZByvFaKjvSMxcj
   MVyakGVzgjvT+9BhP1jA+OQgvzh+Jr6tFZgmmm7eaKniNv2zoA16qI2Lg
   qWWYL3E+M5wyi8wcavPXS1f0reC1ersGWgcPD+jNvGnA/zwrr+IpuB1YH
   SiIk8SerblZKlD2qp+7FFjDcnadSWeSPoLD3HXwWg2KW6nu9PBiiMhvIE
   pzwAoVqMZvaqBcLn0v61hpZPciXnvXQksuo2JTuNPW8lxorsK/6BfBfsm
   T1TVL5j0ZuKXkJ55fDVAKOuozrwIeEnAeabbAR4v3wCbtYyNm5syy17hA
   A==;
X-CSE-ConnectionGUID: yXXcjBIyQrCu7wnaExopRw==
X-CSE-MsgGUID: 5uc5eRZUTgKpL0CICmn4sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84423918"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="84423918"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:55:10 -0700
X-CSE-ConnectionGUID: qD0gL9ynS56cJ4a2JocfDA==
X-CSE-MsgGUID: ZKxLCVRTTW699dqDhHKzxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="236138179"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:55:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:55:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 01:55:08 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ6hDFHexdIqkI3/+5RLBovUitUMUnYiEa8f42t6ZGJQybc3hBgZwqeo7uSSN/Ikgj9v3RmiaCqTcvAPqDQRPiO8UZg6q4sZaNDR9QIaLMmunoJAkwB84M0JtOP1W7l9k52uEUvLpoRZvMo5bXfBL+xfX4YAR8OC6Vx3AJnmcmuV3mlMSndUFjcphUTQq8TzN6FN6qfXrSvrSOpcUWGK+KhpHGY9RBFHkS14erzdim8XINdkVuylLOKvnilApJlxeHeaArOdXn6NoIOwIbLA/zOpopzM2V+6fm/SuvvUbm5z8cS2qxlv9x7zLYLSUJxiIknfMM4Bkc7/7g+czovHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6X8WTI1ipy90Fc1uukqks+0xnxThkqniu7eqCL2oFs=;
 b=zGGkLbOebJhCK+s5CoxM7XROzxZvLyvigsN6s1Je6YrYdFnB9+FMY24OrXRU3+NNvnrxGghjFkUsazR3+1FaTB0x/WeDvhn20Gak5rWU90LgTIffXoq+JnK5uFsjxqe8n7J3eLx8fcYzcuJ7DHRj6PmzawBpsJ42OgNrt64YrcLG4+Q4Z0qDOskt7L1ZavzkZoaOQk03A+VsnNFo0e2BQgPfTSqTeYAUbirTlZrC2ejEl8ilNzmYJx4oCfBbydwnUI9VfVWd7mc9s0MLzJgExz/2J9fio87HdLnGSl2KAOTRZ3f1lszFFqeZSHQxlQYJVGELUgcY+KuGWtNQD7zR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:55:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:55:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v11 net-next 5/8] ice: introduce TXC
 DPLL device and TX ref clock pin framework for E825
Thread-Topic: [Intel-wired-lan] [PATCH v11 net-next 5/8] ice: introduce TXC
 DPLL device and TX ref clock pin framework for E825
Thread-Index: AQHc7POiGfI9oAMcR0uwmhghl6/owbYjJU4Q
Date: Thu, 28 May 2026 08:55:00 +0000
Message-ID: <IA3PR11MB89864E0FCDA2EDD8DCE99AA4E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-6-grzegorz.nitka@intel.com>
In-Reply-To: <20260526093419.639220-6-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: fc574569-8ab8-4cd9-0e3e-08debc96ccf1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: B/yl8itNasBVRexngRDkbz/6egQcjOeoe0LqyEBZdMZ5YNQD0o2AO8QSNlH0CrzCUXhY7prUKtuBRVbF7gBjgMZ/rjeBJYWejdAhwDOnnw0iz52FNWeC4wJKrB6Oz/J4XzSUUSBxpIPI8FOLaNuCD8/oEBmTcwk/b+orhXuNSx+sAKmai0MWwIQ7AOInsVeZdpj6NW5LMH19fETCuMWsg/EmP+Rt0Vfq5P7nVEeXvdk65Cb/nDZcVoCBzfGQ/EcvjIX1AjGUtmM/cg1lnRINUeoBKiEToQfObOT7AJvh60tOVClVhPMhGfL2nTzaGl+4QYokRZ4ThyGDEGp11I3PLfa3e+q8FK4iy9iN4QCiyaQKZstozGMF83BKV37R3N6S5k66Kb5DTi5DGePYAl4as7Z/QgGAGvRu25SC1dMYNN7jiLOqnoRoEAMAeqtHOgSl3X7F4LUhMfru81PtW9KkaWYt+4/Py8Q+AhZk4NIo8lK+WDjSpKrURtze47kgD5LIzsm6R5+nntRLBRBc2t8hd/WvEHMBzd4F7N5J7RvsSCkqm/eJz79YWXnS8ZF8GGIV1RoQq2r3OkhxC0mJJCj4fw8s9NVdrIPe3CM+yvWnu/tpGP3A9Ozi6YVXq2vfchhCzUOdu7QsZS/692zKtLkwIm/2uHPcfYzA5bJoqc3tXHygqPhdHlFDVtqNPQ+Ti49zEaT9pKrc4fzMwLGJMg1QPisZ7XLMPwi6AnhT2qyjKYpkNy+9j+AtPTGI2qSWs48J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNb4huudgvGu78VImIdqheTpAio9bNuPgzGUXhHj1yBvn8hQwN4mqI345OaZ?=
 =?us-ascii?Q?TzZcRoD8096fMs8LkCY2ZJN/WecCLKcGnqjYm1lJpKgDr78nlcVa/i1gXp6i?=
 =?us-ascii?Q?Bk7qzJTZYtYmXgdaHa6J8RTuYbJbuFbV46mVsEcMuvpbzie7r29Fftepo9TH?=
 =?us-ascii?Q?smPUz7TJ1nZxmzAa/hwBY7+bnRlqbOFpcGMUgkOlMaCE+u5txW4Eni9pPH6U?=
 =?us-ascii?Q?P5FD5LKkCLru/j/hMZNgM0kxf1YYw4axiU2mKDhS2G31crFCrRm1kwOLuGsq?=
 =?us-ascii?Q?/WMKBHuwfddUU5X2dmpM0Z5egZk6V2Jlp5ygg+/dMi1S+f3lW/LERvRowhoY?=
 =?us-ascii?Q?8NF6bWXV9BwpBI5Hxb508GGhe2XIHCGFc+7NmsMsacwJ/Z1XjTJDrMzFRSbx?=
 =?us-ascii?Q?BJzkW9NnkQ92tm5d9R2ZrpZb5N8caZ3XprGD+wNx0NiAkCYPXkj0/B4KG/gw?=
 =?us-ascii?Q?TCzlRajsOmZdVbLHAmtMao1giaVO3wfJJHx+88v4EWgPQ/SaJJg+apAuzGKQ?=
 =?us-ascii?Q?S9r2xalhXJDk0RQRmarZFsaQYEBREXgWzXkxDWZ67G4O+swOXgTTK/w5CQJH?=
 =?us-ascii?Q?d/lLeCscw2QzkJQZgU4FyObBS7PD8kCV5/+NWFafYHWWk52YH7TEjGkEcewF?=
 =?us-ascii?Q?Kz3ZLOYnHx2UimLnTmt/nHL5ev3FsyXKftHzKXJOBYTAvQrOvXjhOw21yggM?=
 =?us-ascii?Q?m2VtW2e77L6LvYIN63ozS820QQ41NMBeSwYBFspsyESUmxUy1eicrKenSMDh?=
 =?us-ascii?Q?PgNToz17NxKEsElWXE3Bg7Ex66teA1GzUcizYz6Qsyi3AeCAgqbFRWC1K1Wh?=
 =?us-ascii?Q?AnK83lI+GRBKhjhDEmNp1DHCLSR2ETD7yHeTxns0THwCpmrGqGiNBOnZrr9x?=
 =?us-ascii?Q?nFazEw1jSqBYYxvrd96SM6vij17qF9ZKU0A/y+bQR9yw4c6Yf/WUe+z9BtIv?=
 =?us-ascii?Q?/Pm8VdD9cI4Ag6dS3Dl4OsshZ4ewggx0wT6tr7qOjy7fxP4Hf9/W8ePokUE+?=
 =?us-ascii?Q?WJEmZGmRKnLvhfWhRVJwbdjmY7YJTCJuJf6kRgcmA6Swo5j4rBIsJtBxXVAq?=
 =?us-ascii?Q?FB2VwvMtQM1y2US5DPtr1jHLLoT/9gglIN0tu5Y2wbymwOYiY8lqjfZ1kQ0A?=
 =?us-ascii?Q?EVDzg+fyRlJoOOXbg2zDSGoPFCy0WxRIcHdHBjFNwZVw0O8P6/aIf9/PH8tk?=
 =?us-ascii?Q?OvlQpqessfQD0HGh6efIfs0LBY+V/9key1bnRevxS/LDUBy+/JTVuRDarzGs?=
 =?us-ascii?Q?zlZxLFggItYbDcHJGIa1rNS5bTOgA24IGevdCcpy+lxRAZvz6o9DQKCLZihM?=
 =?us-ascii?Q?5/kd9aPGlDUZPhDzFHz7gn2zP8HSrVsspeUc1hSLNSNoIj4748sJDP0H8xmN?=
 =?us-ascii?Q?SiBlMyXuKDjynMxZ8DJjEKnx787Gm4hkKxOPir8JA33yxAWyxFR2Bf3lq/W9?=
 =?us-ascii?Q?BC9glWFhQsxB9tfXx5cnhK8LFLvlsIakxwPIy4R7mBWfrQGFMUMF74EqGk27?=
 =?us-ascii?Q?eRUF1M4lZQd8gxIb5GNC1i7sKWr8zi60ZBi3jIDT76yWk9atBs+qlJpt41Am?=
 =?us-ascii?Q?pNTeyzcgaYw4LnrqzOOKitHKGJTsbmmXOnw7R8VbaBI5Nd75JknCBocZ5kT6?=
 =?us-ascii?Q?zGG8qivB7VKfY9/Cso4k6Jnx6ky8tJICj2Tn0OfNG0txeb8UfhrMF/fTjvQR?=
 =?us-ascii?Q?vWpMrTlRGPNNilZtt5DyGHQg9bElHeJb51ADu9q43uGgIww9YpOo6lf+TFc2?=
 =?us-ascii?Q?kh6M6onFm32zIWUpDkZ9RoNTRvGW/zs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dm180muOnSg3DH1LWSH+YAI4hJhuDd2DtCfBZVKH0Cm8v8dmiwLPM4ALdQ4KhBw8BvJAuWL3ResRf6WYpS8+E5LezPrBWn9XoKrbFXqXwFbXpbsadPXnTfOWRLVIkzis3Xa6C0D+Q1K36HVbybhfNVxtvuIRozV36oAIJJ9/G9I++yFga9+7bRxJ01dfD3dszlik3LXO+hCMHwCoucDFwYpgK72hu2n1RyreO2NRAT89xZ82RyzSCMz9SGw15CU9sqh4YF7zhmo8oP3CcoRBIFNJXCJHE4suJCdocDJx0rfMPe4Bzn/nYs8C287kgiZUrhWxvjs/MU0WnYfGf19aow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc574569-8ab8-4cd9-0e3e-08debc96ccf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:55:00.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5Uv7E8AJuGZCXNjwMENj/wzH1SK5KebraaizJZItlXX7RNf0sSQJjLxMxw+VJs1PNyqdTnIvAjXU4k5wi74+Frm4wRx/JDWt6cxtxMLQUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292605-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B68C55EF3C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Tuesday, May 26, 2026 11:34 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v11 net-next 5/8] ice: introduce TXC
> DPLL device and TX ref clock pin framework for E825
>=20
> E825 devices provide a dedicated TX clock (TXC) domain which may be
> driven by multiple reference clock sources, including external board
> references and port-derived SyncE. To support future TX clock control
> and observability through the Linux DPLL subsystem, introduce a
> separate TXC DPLL device (of DPLL_TYPE_GENERIC) and a framework for
> representing TX reference clock inputs.
>=20
> This change adds a new internal DPLL pin type (TXCLK) and registers TX
> reference clock pins for E825-based devices:
> - EXT_EREF0: a board-level external electrical reference
> - SYNCE: a port-derived SyncE reference described via firmware nodes
>=20
> The TXC DPLL device is created and managed alongside the existing PPS
> and EEC DPLL instances. TXCLK pins are registered directly or deferred
> via a notifier when backed by fwnode-described pins.
> A per-pin attribute encodes the TX reference source associated with
> each TXCLK pin.
>=20
> At this stage, TXCLK pin state callbacks and TXC DPLL lock status
> reporting are implemented as placeholders. Pin state getters always
> return DISCONNECTED, and the TXC DPLL is initialized in the UNLOCKED
> state. No hardware configuration or TX reference switching is
> performed yet.
>=20
> This patch establishes the structural groundwork required for
> hardware-backed TX reference selection, verification, and
> synchronization status reporting, which will be implemented in
> subsequent patches.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c   | 322 ++++++++++++++++++-
> -
>  drivers/net/ethernet/intel/ice/ice_dpll.h   |   6 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   7 +
>  3 files changed, 310 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index b9c7df50123d..1b193e0c35ab 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -19,6 +19,11 @@
>  #define ICE_DPLL_SW_PIN_INPUT_BASE_QSFP		6
>  #define ICE_DPLL_SW_PIN_OUTPUT_BASE		0
>=20

...

>  #define E810C_QSFP_C827_0_HANDLE 2
>  #define E810C_QSFP_C827_1_HANDLE 3
>=20
> --
> 2.39.3


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

