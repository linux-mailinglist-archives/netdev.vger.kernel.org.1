Return-Path: <netdev+bounces-235163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A5C2CDBA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352BA18C1E94
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC389313E19;
	Mon,  3 Nov 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ7Qg8qM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C42283FCF
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183697; cv=fail; b=ZvSYe1pXkxwr5kliAt/o73JvIYmMY5lyLApoQ3wWPbqEj+G4l7El8drlGXdZ/wHL/PQ0BfA6kcgQgMrQVY1tHdgQOUkvmPpe1GxeAKZcD+OSzbHS6EItwJDcjQUcyLe7GS70Ppo8NDYq8C3dgldr8pXSrvKxHsKE99rttZBimLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183697; c=relaxed/simple;
	bh=3sCO2jM7S/bT1LSorbzdr8SIwKyejveh2uSm6QXW5dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1ll7cwb5GoDGIKvgqfNjk8sTHlGAGPZGyjJJGFlvqO+Y0cmQS1v98xvylFeU6edvOFIZT2wNLZL02HyZhUcSHlCT9k6rtILuJbHNKliPKdbB23sJRE3sAAWxfYxkpzRe4v2QPHTHDp3BnG1j6cFeAKpxZH5JpaSBI7MLrTuilI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ7Qg8qM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183696; x=1793719696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3sCO2jM7S/bT1LSorbzdr8SIwKyejveh2uSm6QXW5dQ=;
  b=ZQ7Qg8qMDoarMQaNZXad3oQXqruUrrcjGnE3qwFErB3vFMm4G2Qi9Gsq
   LqnJAuIbytCs3WiJADhKf5grUFWwWA8F3hG/y+WlDaALnd0gqtfjFecaR
   jyd5ANxtxd7xUTuu5L87cbi0tiIFxqyHwFqL2DLgwQdRVZKf3QWLeMY4A
   rw5lZmIA4ymd9+s6+pHIkeOpE9+eKYTS9KNw1bxWkC06+j8ZvT8f+gm7u
   WIu60cK1j9CfnkqB2ylt8Lnaw0Eg+2bQ4BSEPQ13Tr+mk8t+NK5vklqhz
   /trWsFqwyR9t5gaVAnRb4mEovFrQ30tH9b7vTliBAwhAVV7DoAxqDc/Xe
   g==;
X-CSE-ConnectionGUID: YLKntwtJR7K/poQ4sZsiXQ==
X-CSE-MsgGUID: VJwdhUfdSB6tirL47uG+lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66873205"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="66873205"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:15 -0800
X-CSE-ConnectionGUID: o5G6sjmbREepCrKxpIoKbw==
X-CSE-MsgGUID: CDIKRPieRym/GYvpZf/Mjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187040390"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:28:15 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYEFemw+MdKWQvEbZN4nh8MIjzTqqkXbxoMHqubitF/wgCZDao1MqkUZ68U+e1kIKjaS5KqZPL3mB+UQdZGCgNT+49Qf1QSuVcPLMuSBJAgUR2I2RaxwjwGkqIQnwfdgzGDyux6dotul+kxxN0DjL6nTr5Phj+EPFMM2l9i86Oy4JZ7OZeUY2YX2QaVy8zFhKSjIpoVyVS4c1gIhqC22ry82UYGDZBHYAA8TaJG/WhIULGcFB/Q+rslfDSy6ngJsh1E905dvsc1gdrN5GcujfUwj9/6MWZbN5PsGDKJ+44RR+bE1WPTr+Pc5Y3m86E1KzFae895spF1AD2SiorDBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sCO2jM7S/bT1LSorbzdr8SIwKyejveh2uSm6QXW5dQ=;
 b=G1KYGUzIJSCy25OqtHgmcF+jWUkAsMkHaJDz07cDd1seV5PVJcZd+yU/nAhlMUiSD6EO7JLK+l8WF1gZ/WuOyBP4Z/pBJRZBTx0cc7+u/qs0ck9Y++XBa3V69AOIUAmj0zQSjSW7tjDwFiDE5lkRD0l1YhvB2lYlhVxE3r32UAnVVry3pAQnjssWga5o1LtebNiyTqchVqy7OWardKtBUUBj6ZlppRwddcxBz4R8ApiACGVY49ELx5BKxoV/xU9jEEwSwYNeUWNJXZlDj5MxBWM8hgEuQp5M2BobqpdjMwQN8llX/zz0EtE7IcKS5Br3yF+oVccgb3w+5Fen+Z8SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:28:07 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:28:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 05/10] idpf: reshuffle
 idpf_vport struct members to avoid holes
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 05/10] idpf: reshuffle
 idpf_vport struct members to avoid holes
Thread-Index: AQHcQuFTYl7mNAiQTUaHz2ML7ihBSrThJgmg
Date: Mon, 3 Nov 2025 15:28:04 +0000
Message-ID: <SJ1PR11MB629715E9E1DCDAD7B71919259BC7A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-6-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-6-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY5PR11MB6211:EE_
x-ms-office365-filtering-correlation-id: 534f6e73-4d43-4f6c-56bf-08de1aed9572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?PYK/YjOa9x5PEq7e+emuxsUxLdaEYuF/6q6/TWtc/8tNrFf4HYoLQcs7qof5?=
 =?us-ascii?Q?6FTIcTJBlWI+ROD6MRotaAbvcwbs1N85WxUzo/330IOgB3ECcZd4KOdliV6Y?=
 =?us-ascii?Q?byN822rZNC4OqCpbr50JKiR4+Z6lEo0kt0A7WU6jXVWZndhJ9oQu3rL+vrSy?=
 =?us-ascii?Q?3XlEf5r8y4r7Nu75shSBqMLt+DOqzygbPZX86tUBM2ZNkFsBDRWc1iMKcHnV?=
 =?us-ascii?Q?uoUKz4aFGm2OmdoJJq33aee4ATve0DG3kdsKHgJavCS0CCtrYv4P6O6mWCHh?=
 =?us-ascii?Q?AuxS6Ts4B0u5ffFszyvQARiHI2vcZ2CEm6/m8gmYHShmZf8LaykhS0OZWDa6?=
 =?us-ascii?Q?11AykCWnRxQUH3WUeUQy4wlXxzFk5PGDB4xpe2qPFzoa8ESmTPot0c7sgVcq?=
 =?us-ascii?Q?T0+yHejh4ouNqa0T3Rd+BRHZDnrR/LWEf2J7elFqFqKmjVA3kSTOkdmwyXKG?=
 =?us-ascii?Q?LUb6XjHVdA7+efq9C5ThB5G8d6VpFloIvxw+FdEqdE6z+drpWCHUvgxQLHmc?=
 =?us-ascii?Q?nwN+Hjf0tJ3Rqn3yP1bxcN93WXEPL7KrJxg0C9QT60Vy62zPLYsl902cBtkv?=
 =?us-ascii?Q?6kpCVEirFBU7V6JPmtw1Ro5RayAWJ1hrkhyBQxNoMMEzcxsonWJlhktzktUv?=
 =?us-ascii?Q?+bAbVF70TrTFx49LLHqivEBK46+8IqxAs32gCI7uEGqX19+4NiHkCJkynPrI?=
 =?us-ascii?Q?FKY/ks5C4kkz6IHvMB8uT2wi5e98ajkFcHwyzpcFgwzbiGadzUjMmI0LDkMB?=
 =?us-ascii?Q?qgLOfe30Y5ISV6lcnOFme19H39cmgD9rMPpRsTXA/iE5xl3ihKRbAYJz+WPt?=
 =?us-ascii?Q?JGi0YMYklU4J2sB4aqKJa7slXMt/3w4qRBiCRLWGmuBYUosXSSNlvMUhrlDb?=
 =?us-ascii?Q?sQAPgHMLUnHrKxTuMMZE2EWaDXFeDlA7QKkR8cKNrx42bU4Dg1T7bf/1FArd?=
 =?us-ascii?Q?A8gnKPtouZg9gpPiDUGFyyzJjm67uyDpv8m/uIaQ4inRC8MKKtenxHidWGyx?=
 =?us-ascii?Q?qnVqdItKQn4Skef4KbeaZWEJydbOJtmQOy37i3OA75Se3WebXEMfl3TkRVol?=
 =?us-ascii?Q?0WViXYtLetqSAcj0LXYA9rux1UyzwW9UG3CpMv5oXSEB1Jq1X1Av6axvzzXf?=
 =?us-ascii?Q?spOCbfVyw4GGswVdhdiDTP9TlH9gNaipQ1I+Ej5zbH4ssB3il/BW+moYBPap?=
 =?us-ascii?Q?1ppN5TWO1ajYZCCUUflWE+uT+IIaBhilPN70ve2+BpSBxisXQJv3QphKxpRz?=
 =?us-ascii?Q?AHCYqr7QmQwT8EaTc3eXbnGVWax7IljRIKJNy3bew+icTnAxExOusbdIbb5M?=
 =?us-ascii?Q?snXpzTGwMcRamK3sDgaTleOzr6xTiHW7FdhbJe5dGVhNxxJMpKlLc31tpoBF?=
 =?us-ascii?Q?y1XxOvPvQ572Xkoc+KDAU81Wc9dIRDIDtitpWfkYwMYhxfDGwjsMRPk09lh7?=
 =?us-ascii?Q?+ZjHFLKvZoHOB5VDTBin62i/UPuiEHr8LAX0m1MgC7tlMOmUh0Z826GN/a2y?=
 =?us-ascii?Q?c5ty7qdKhRotf67P6dAngmcCwDnveGraPAN0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ENnHj1PV0Mz1frVIz27byKtGMIUgesxQyWnzOmpt3dsBxcuHNVDCCv7hnQd?=
 =?us-ascii?Q?6mXT/YevR23WFA5Z3k2qLLtPKFDBXKOeOSqO0nwK+xz2VsAgaR+4iajafJ+d?=
 =?us-ascii?Q?vaK3386nXrTO1yni5u1oC90rofrAdHRqhKzU0fP4oxpSEoi888QkzxYi87Bi?=
 =?us-ascii?Q?+U7peGx0hopGOGMUQ9baEXjZ4M+kUBWcQMf7azPRbkIoZiHYFhmAyHmTbtOY?=
 =?us-ascii?Q?f4P9BokUsCe8zjCfGG036xhhsJ3rJyFSoGzjSpYt8fLKSn+g1JR4Y7/344aS?=
 =?us-ascii?Q?XE+1UNdqH//hz+XcHufZEF0TjBbab3cEdaHC4R5N/U/6GZ1dvOQF9Va5JWiC?=
 =?us-ascii?Q?sF0Po1y0VvOLhLdQRBpPZ7jnFeGVkeAGenZjO1UOp8zyZqDf1oFkcsoR+0ai?=
 =?us-ascii?Q?Tu4+9Oh6PjFG5YyNWq9Kx370QqQ1n64wRYWOD2QlZh/XAi4W8H94pIt9Rjr3?=
 =?us-ascii?Q?YWfGvZfrs4jXE9ZpFdczYOVkkPXPk93jlY8A9tDrX529t7NPuoK/9XxXhgVB?=
 =?us-ascii?Q?ks0VqVUotXJOlO2OZdJkf9lJWGMjnoJ/NfH/l4k8zDfT8ako9oMRWqOrcUZx?=
 =?us-ascii?Q?Ukvrc3al72/0UV63r1PmSNtnZ2Rj3uiAJkfBIhdUldCiQ7q1HJL0L0sw/hhk?=
 =?us-ascii?Q?bOx+39t44BqK0gqjlr1Yfx8jsc2CWYQy8bm6+hHPLPKzz1p8y0qsWK4NJ2ud?=
 =?us-ascii?Q?UjtMC0D5aqZQgCp2WWDOO4CHpeBEfHgkU1aEIDGtOwFJSEnf/EhtbFCVrRCe?=
 =?us-ascii?Q?X/DYLc8/hd2bwltpa7G459km3oDeXWmpQCPIDhP8D0h7g1Wpna5UXyeK7K2G?=
 =?us-ascii?Q?KArzwlB5BT5ls8UCRu7Aa/Rkc6ttsirmoaFQU5DAHWcxEt4GqZ5/hVhnlkgB?=
 =?us-ascii?Q?0tz1uzkhmafKO2S2xxAnxs++ZCN98Murbpxsu2ep1gq17EDKMt4GttfNfWx/?=
 =?us-ascii?Q?QRBiJSLD2ZhTJeS9VAooKGgC/MqT0Az8A4E+qdpXQeUQq7XaMvZoJatQj5dr?=
 =?us-ascii?Q?LWuuD8qK/3O1x6qxrRS24PA+6jiNyycd5lrEWPkGxDJEskrznNe5ocnsABnm?=
 =?us-ascii?Q?SRiF0r/0ZLHsjW/mj0Be1CyGodidfIrZ2Sd/r+NDeStLsti1lzY5BgDsRMUu?=
 =?us-ascii?Q?Vfl7V8lDz0KoglJWFBCb1K1sntLY0Y+9EQ8Ficm0XX80xjKnDcWkapmKDbO1?=
 =?us-ascii?Q?rOtk3/uFQD5bWK2E9bW3611z42BsRBC42IPT4hgvGc1EqiTPf4kApZmjnKLj?=
 =?us-ascii?Q?UaJ/Hhx+3Hy6uGunjq8Q0E9hTUvjqHr2CBrHkhmXFyUxyChEWEiixa0nYf/f?=
 =?us-ascii?Q?HqnJxS30bwSGRUyf3eLvH4COkAND/B4tGuCCPJMFWwaU9Z5ojg2fnTJULuIC?=
 =?us-ascii?Q?D+va39rz6FsydP6V4NRRjnurT5r026BrC5kqBCW4AkPBe9SIOzKRNb4l6UJq?=
 =?us-ascii?Q?lsKEgyowTktbMCaNT+5DDbt6PQ7eHu3VeNgIdZ5tB2rwTwcUEVnvu4WzLd4M?=
 =?us-ascii?Q?XoMhDNzPEqiuXjMovmK0SGXW5Sy9/MKRavn1phxHUqiQyVyK1ruHwukEKu9B?=
 =?us-ascii?Q?GCjQvDg1RUDubx6LfpvwGboc9qD//3ZZKMbbVjl4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534f6e73-4d43-4f6c-56bf-08de1aed9572
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:28:04.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxTe3FUU33Pl5EKIgXczqs3MjFT9DamrBqvOnGZky+SG0qo1ekU+iSyDHELgytb1QvBxqtwA284sGMcwEzpQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Tuesday, October 21, 2025 4:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 05/10] idpf: reshuffle idpf=
_vport
> struct members to avoid holes
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> The previous refactor of moving queue and vector resources out of the
> idpf_vport structure, created few holes. Reshuffle the existing members t=
o
> avoid holes as much as possible.
>=20
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>


