Return-Path: <netdev+bounces-145011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6239C9162
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78A91F21824
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950C18C933;
	Thu, 14 Nov 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmW8W5ue"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC5AD5B
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607606; cv=fail; b=nlMuZc7/XiFilYzvAwzN6CzGCn7dSNHOrw2QWOoRI3JEtdt56Ku8ETnjDqyQ3Zrxql1j/RrYWA1gHTpLwxeDx1McQufe4HCYddgImINRetbr7/svvppiYNFrbWCD4pcKSbbWyH/6chusgPT4kwOtJR00YbpiWECMGiYV7XJ17Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607606; c=relaxed/simple;
	bh=fTy3dCJwgd1yc+mUU+BZJx817l60Q5veRkqGeTfFQSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ptA1p9CFuV6OfrSbl7KCxFhLj3DqGdpJQf8eCkRWmamXeXzHeKg20XRdK4ALo3nWuCP052BRaPI4UEnAxnN+g1eXF3ZwtnDukU4l211zzIPnyPJPLlHH6vAJWWBbi++XBWB+D3UO8ZvAx3LPseIJDqJfbfh8WVHYTOB+jrVPQss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmW8W5ue; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731607605; x=1763143605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fTy3dCJwgd1yc+mUU+BZJx817l60Q5veRkqGeTfFQSM=;
  b=GmW8W5ue288Qcg/o1Hb61THz132LaWmFLO6KLTxn0qfGxrgzoTUSTahJ
   D9EueYYGWSkoXPpbyzUnhySL3jd65zX6CSFrov+CkD8pmAHzIG8dW1Q58
   k8v4Xrslqor25OYWdIUB8hmJXWFCwt9lyAfRABEr19JIyLmUgYS5hawk8
   n8GB08KmqBMVdnt+EReK2H9qpxc7AWfeajcrP64HRNVoFC60wWlqcwdxG
   QpcI7lm1c/qi/AKov+ageUZPG2+N8JiCtqGwJ2x22x5d45iLdsX11Cunv
   Myz9npHttGlXhftUD9QLi/zGqn8QlgL5CGK5dMhjZhhCEGBzj5RUfIcER
   w==;
X-CSE-ConnectionGUID: 5hSOJ9TuQrWfPT0QRYoi9w==
X-CSE-MsgGUID: p2QTc5XtSa644Azs2bzI3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34435091"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="34435091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 10:06:39 -0800
X-CSE-ConnectionGUID: vm3A22PaRDi4dCfgOz/gGQ==
X-CSE-MsgGUID: rcoQ1159QISMwA5qDM6bxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="111591400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 10:06:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 10:06:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 10:06:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 10:06:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn0DTLGnJ1qm6jsgo6jBeSZYkHewldQmDxwwFL9L16sgbaSnwM+Hw1hIaT8SYA1gjHX2mLoPNbnzzGAjwHj7zhsJf4AJ+E+tEmCJi4aSTyxZC5RzIjUV5TbxCjxsJD0/+a10hV8Ly6pUvr4azYGCfxrLZ1qa2T0v7m/ZNrXWmhTiWHJf5rx8FVoNqhYJaVXOavaXVYQuj6RI56awS5ZBT0pps3LtAGSU01yd9b7HhAH0hV+7tGZ0mWXFYizIGWaGykR2ZOuseIw/pd/hp0G+dT6wr3TlaklCFmYeVHvOPdFVzIZH4mNGfHWilkX8smD9TrbKxSOmB38yY3KOlnVGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJkoh08ZVyOhguFwCw1zxP/kKD/3xY6teANxAYtjhDk=;
 b=NT5MyssBB/Fqd+MPZVXkWwt6n5UcddmmYaS2xUoa+azdAFSxzZWd+52EuvpdEcqTcdxHoQW/Z9nQagF9atEGR32dGeQ0/9eD7XS8M2PcaT9nOuTS9cethxaIVQrS0mJ2tnEe7t4BINN0U1TwcHaZVia9rGMKZnoQaD4I9YWDmxm/21vgD+oinfHrTF/yL8fbp8PbkNBCYQTqeW4p9e+20DBiNQK0Y2jFP5carZCLKYBwLTRC93DCiJBTbOl2i8tarQ8nZoqFxyw97IF3iErzrQQjkCsibS/ndggqXrRuRDLadSX66VSRNvPyCq7un7z5EKXKweX2WRh6gtqND/JM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 18:06:21 +0000
Received: from IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73]) by IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73%7]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 18:06:21 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "jbrandeb@kernel.org" <jbrandeb@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Brandeburg, Jesse" <jbrandeburg@cloudflare.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
Thread-Topic: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
Thread-Index: AQHbNiheW2jXC+EQOEikvp/7aLqJQrK3EdHg
Date: Thu, 14 Nov 2024 18:06:21 +0000
Message-ID: <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
In-Reply-To: <20241114000105.703740-1-jbrandeb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_|SN7PR11MB6727:EE_
x-ms-office365-filtering-correlation-id: 58b8d78d-e02b-4eea-a55c-08dd04d70b6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zZQKbDNQfotJxDHLRFW4rADdAOHiRvBaLspJXRzBseGPwkiJvVpQOVPSgHSM?=
 =?us-ascii?Q?gO166hIbWbpFVMKFJWmhMkK8gUfPA2EimXYEGG0KYfkVt42Ryz6VwHkT+2lg?=
 =?us-ascii?Q?pKXltg+0IkI4S7Vnbxr+6rM1xZFV7En/zZC66iWSw2jmmfI+M7ykHQ2q7/L0?=
 =?us-ascii?Q?OURJKmjV4w8HVzl8SHWWvDMUTj4MBD3vbpGTl1izF1XTFZO7p5++kkUKzUWo?=
 =?us-ascii?Q?Y7qliDzYyJkT7HIgvJoikVAwSxuXLHSh36gE0+yDt1xyr5robklyPqyLSHI/?=
 =?us-ascii?Q?EkZB6gFN7w7qTeZUEyfkb7xM+QZsTVV6gFAAxhzJhrvGdYMlD3bhfUWl0CZ4?=
 =?us-ascii?Q?LeU35LTTIMWlVCc0NWZlcEpOKtu7tb3G3j99dk0MuQTIPmeu0k7NB1271EhC?=
 =?us-ascii?Q?PU91y3HH2aaZQxK0nHGvahRHoAk129nQLoXiIT64c4HDQ/II7ajikb3BXkOH?=
 =?us-ascii?Q?N4HoN+AWon6nMTB3oqytfby1deY2mKBCnxlq9xWd3p0YZda3v5E+aQvRZkWK?=
 =?us-ascii?Q?WVBNKJEVES+AMnPgGYFUU9FKRXl6BULdMn3HMRnuEJpeVE/yEno1gFWbs16k?=
 =?us-ascii?Q?D3D66C6PgjgMFGxigVs0eQu5quNHnpNgabFn90qwzyFKhE+GCfxN1lnLcZK3?=
 =?us-ascii?Q?MHDMCeAQ+jBKVP4X31JBY2CZHXmRix+5jmvHBj2VGHq/TdXNU5+sHg2hdMXy?=
 =?us-ascii?Q?dMrwiJlnnRbjhTg2uTqdCnh3d5tA2JE+YP4Cmgt5RODYIQUPnoLaS4RNuz/J?=
 =?us-ascii?Q?7LHQCo38y5yKaKFrfcEFHn+ECzRZ7rR6kX7NsT3kkBBGBEvHuNpgEAoLycjX?=
 =?us-ascii?Q?nmAg6H8A0YSP9Z0BrKpUugr4HYKaAdidSR2swCZcq20NKf0NXoLVohufdvoY?=
 =?us-ascii?Q?3kzl5o/GuqqrMQZT515FCj6L2lpT9DXerlvmg/XukOaxAzapQXD6UujdF7io?=
 =?us-ascii?Q?QFx24JeX4eFwS0QGVaVHYQUlCuXJZRDKaQpENN+4kftxpBYgAI41IFV/gmm/?=
 =?us-ascii?Q?Sqxo7bHU7U/4txMznte/KY72DdupOfVEfYFaL7kH74kc0qo4KYdt4usCSXaK?=
 =?us-ascii?Q?kNZmAbuCcbMkdGQ+M103Qu+8Earm0z6JoqR0LWJVi/bymJDRFv77nskDAmKx?=
 =?us-ascii?Q?L/g/SInvYSlvOUYSLbKrE70B2ZTiMiHHFpSq1A+2Y1E3IeAMPwZ4ptDTxL0e?=
 =?us-ascii?Q?0vRSixyUUHLmeDDt6J+Xg44+oeHWraQXpkzwS3ruyET/M53rDuOjXWqvAi0N?=
 =?us-ascii?Q?WHQF9p1Yz51EFCg//+Q4fnCoSmy3ZVEeqXPKYJZhdv670VknE3z+iSHhxHHs?=
 =?us-ascii?Q?yXyADdaYzCXRklX/9mOaomXRpoEVshYm7H0ZeMDeE3XDB/rRRKD5Xq5Io90U?=
 =?us-ascii?Q?XO05dFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cczfy2SEbmoItOZ4tHHEq4gkv4trjoKhIJIPs8z+EBoP/LZmF/FIG3GJ5FSA?=
 =?us-ascii?Q?uO//52Qr9i64yYV3BLx+wAd5rHmuEtLPphtbTCARlL6xADotb+5BsFlyXrkx?=
 =?us-ascii?Q?Fsm2iFpRmx0o9LQM/+mnBNHOUmX0jKcaKrTeXYhvw0F1iB0lVUZHYLAypPxd?=
 =?us-ascii?Q?/HbOshQ8lhJkd1BuRS7T841HGuzdh4ZFsXmOnRW4GJ2YKE9QEzQulU62iVto?=
 =?us-ascii?Q?zCN8GF8VdHAMvpbOaBGxuYAiRGQYZqJX0k0tAwb7N0BJjMVhO/l+gQXp9TMT?=
 =?us-ascii?Q?jR2EoJ3XwiWnkIs3WQU/pzUaatozGtSTZboN0o60WeeMjrYc7pOvENhyVkVv?=
 =?us-ascii?Q?7eCxBXSGIf4Ky6KqR0H0V/CGK0Cc1ZS1+lEKSUHjabFFCRho8qW/7D8PIing?=
 =?us-ascii?Q?sg6fFytif2pgKTlbXvYOU++xzwCwnjk75ZW7jk561r0rjDaEtN7zFqQWoQcO?=
 =?us-ascii?Q?HJKSlyDuJtkw05iu71pgw0bh6fNuTS7HguVFbVUIeS5TwTzm3zNtYkCALg7o?=
 =?us-ascii?Q?7Xdnu3t8Q8HuJ6JCs/um4AN7+ZSvnxzD9MByzydYfEToG+QdTgowGr6dZCEv?=
 =?us-ascii?Q?sDqQM6uG1RKQsYOqbNQYyEh9k+eLTFkReP4HBNaswgMu9yI5LklxaVo7pq/p?=
 =?us-ascii?Q?PzrEEqyML2sF9a/pHJjSAOHqljK4fhxdNy9j9AblKiEMRf9c3qMnXIT0LMc6?=
 =?us-ascii?Q?WgRLk3JO3NFfw6/OSKok0gq/OXxM5Rt+zepV5O4GCVwTL8MKtw+eelW5FCcT?=
 =?us-ascii?Q?cOAHvkY5pcnUW2/mg48yAW97oInC1K6iDteyPpG5i5Hcry4nqxKhEqFjzxkJ?=
 =?us-ascii?Q?Mqq+Um2YOSCeQ2B0X+SO3XO4WLnoJewmErNoGBtejrlOsnJz75tAFzNTQqUa?=
 =?us-ascii?Q?gFKlD5kjXsZJqaYkmu4iQRouP+QG2NUNHNRpkIvpUjD+bk2AZ4cfVwF+cQZ8?=
 =?us-ascii?Q?8XUGkpshA1c06At3XTr0HDnvLBVJ0HdujQtJwJL0ch2a4eCDIe0dabQV3+GB?=
 =?us-ascii?Q?XP1dXocMILYtbQMmVUTS4VRlYT74/Yhk5iicSpD6kLwHxMsB3Tul74ws4p8i?=
 =?us-ascii?Q?Y2tc1XcBvqRXa/dxY9/kaI3EauLpvjcuI/5VqtyaOE9+l/Moi7vaDN2sVWTb?=
 =?us-ascii?Q?mgKvC0e7Q6Kjw4GGjdqEc3mfI3sIJe3qx6OdGWGEBfwMhSlfvqkLMCT7gQ24?=
 =?us-ascii?Q?j00w6wPhv12i1qzy68V25/Z/idoI3AG5DxVzQrQqOL13/SNegtpq7RjEPZZX?=
 =?us-ascii?Q?wRndrofq9cc2OYhHn5jotVXF4a5NUMTfpHhZjWlp4h9gR1bodCaGi6HhBKDh?=
 =?us-ascii?Q?0Ny1kcdoWFVNdBRS4iddFFJiObkTQV62c71QjJCxF+G5DP9eBIKjGHObUUEA?=
 =?us-ascii?Q?5cXGkxlZP0zXdKr6ziEv0X0Ox+hxnesROE1umqeYgj3gIQqIpGNxt5BKXeqZ?=
 =?us-ascii?Q?bV23Le0XEIwWjLhl06pe4peJjhBuERSOxSVRQSS8EK1oKbPz+0aLnklfOjFZ?=
 =?us-ascii?Q?FxV3zjRlv/bE3aHDgw0NH6aSE30tSoGQ2RJUbOQUpHn4rLrz4s48PKciWVwv?=
 =?us-ascii?Q?bnC1Opr0lrirBV+qpOoc2wxUjCXkUWB5UsEQCuQz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8d78d-e02b-4eea-a55c-08dd04d70b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 18:06:21.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljkGXCptVzpqSsWnorVdsH6p0U9GZHAvbhTc/PV4Te7KHygukN+qFOyr1WWMOqBsjCLFVgPkge9p+Z+0zcd51aZuTrDlNImh0ArRlFkafWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: jbrandeb@kernel.org <jbrandeb@kernel.org>
> Sent: Wednesday, November 13, 2024 4:01 PM
> To: netdev@vger.kernel.org
> Cc: Brandeburg, Jesse <jbrandeburg@cloudflare.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; intel-wired-lan@lists.osuosl.org; Ertman, David M
> <david.m.ertman@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>
> Subject: [PATCH net v1] ice: do not reserve resources for RDMA when
> disabled
>=20
> From: Jesse Brandeburg <jbrandeb@kernel.org>
>=20
> If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
> built-in, then don't let the driver reserve resources for RDMA.
>=20
> Do this by avoiding enabling the capability when scanning hardware
> capabilities.
>=20
> Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
> CC: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Jesse Brandeburg <jbrandeb@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index 009716a12a26..70be07ad2c10 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2174,7 +2174,8 @@ ice_parse_common_caps(struct ice_hw *hw, struct
> ice_hw_common_caps *caps,
>  			  caps->nvm_unified_update);
>  		break;
>  	case ICE_AQC_CAPS_RDMA:
> -		caps->rdma =3D (number =3D=3D 1);
> +		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
> +			caps->rdma =3D (number =3D=3D 1);
>  		ice_debug(hw, ICE_DBG_INIT, "%s: rdma =3D %d\n", prefix,

The HW caps struct should always accurately reflect the capabilities of the=
 HW being probed.  Since this
is a kernel configuration (i.e. software) consideration, the more appropria=
te approach would be to control
the PF flag "ICE_FLAG_RDMA_ENA" based on the kernel CONFIG setting.

Thanks,
DaveE=20

